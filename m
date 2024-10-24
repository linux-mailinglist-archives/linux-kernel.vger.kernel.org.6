Return-Path: <linux-kernel+bounces-379086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2999AD98B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DB31F2232B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C5880034;
	Thu, 24 Oct 2024 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GPcfIUC4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFF1EEA6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729735516; cv=none; b=f+E2+AxDnJ1S9HqPyA6alPZLcSfCiKcmt18FPgjtNXx6SreIBIehL0tktMLWMBuEleupSN4Jd9aBfAV/fNOzb0cI4VSqNkJplfpxRMq9HVk5oy81jqxJ3+mumFcxq6W18DOh0R/Boo17c4x/qHgAd0BaTGtxfU8ahJKyKngpVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729735516; c=relaxed/simple;
	bh=j5iaB5Vx7h/wjwuyqqNj81gSLrS8+ygDJ1Mrf9QAvWM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ebKgoOOjYIxEtqYkXDAw/kVhOuCz8qGm81GUrsBA5XN9yRy3nlg7M09ASyB2ZVOVBXuxqd+TwJkIXpRqcyyW85cMeGOlbJlyfuuQS7ljhAgSlxaYpnq5oNb77hWgB0rcFwbWt9uGNc8Z6YsxL2M67SrZ3jlu2bI+LEm9m+tGSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GPcfIUC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D1AC4CEC6;
	Thu, 24 Oct 2024 02:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729735516;
	bh=j5iaB5Vx7h/wjwuyqqNj81gSLrS8+ygDJ1Mrf9QAvWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GPcfIUC4/RBhqiqGlRsaXIMJBiGDuedB09/tV+wB2i4jC9wM4NU5NH3i4WAVtl/xz
	 oN5EwP3k+ZyyNBgE/TdsZT+4avs3MYnBrDNDnm38TkoKKuijlzNG16IWZWQE2IfnUe
	 GSVwbEqlkhpocMfXQn+XscC/h/eRpwUDDIwFo3gI=
Date: Wed, 23 Oct 2024 19:05:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: cunhuang@tencent.com, leonylgao@tencent.com, j.granados@samsung.com,
 jsiddle@redhat.com, kent.overstreet@linux.dev, 21cnbao@gmail.com,
 ryan.roberts@arm.com, david@redhat.com, ziy@nvidia.com,
 libang.li@antgroup.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/2] hung_task: add detect count for hung tasks
Message-Id: <20241023190515.a80c77fe3fa895910d554888@linux-foundation.org>
In-Reply-To: <20241022114736.83285-1-ioworker0@gmail.com>
References: <20241022114736.83285-1-ioworker0@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 19:47:34 +0800 Lance Yang <ioworker0@gmail.com> wrote:

> Hi all,
> 
> This patchset adds a counter, hung_task_detect_count, to track the number of
> times hung tasks are detected. This counter provides a straightforward way
> to monitor hung task events without manually checking dmesg logs.
> 
> With this counter in place, system issues can be spotted quickly, allowing
> admins to step in promptly before system load spikes occur, even if the
> hung_task_warnings value has been decreased to 0 well before.
> 
> Recently, we encountered a situation where warnings about hung tasks were
> buried in dmesg logs during load spikes. Introducing this counter could
> have helped us detect such issues earlier and improve our analysis efficiency.
> 

Isn't the answer to this problem "write a better parser"?  I mean,
we're providing userspace with information which is already available.


