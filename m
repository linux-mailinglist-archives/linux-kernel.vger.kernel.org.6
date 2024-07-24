Return-Path: <linux-kernel+bounces-261449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C774993B77D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6001F21E06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3816DC1E;
	Wed, 24 Jul 2024 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rZTrqlrH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2416D9B9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848503; cv=none; b=f28wqn3p1KTH9CwM+OJqosHHbzMH3Hvxqmgdt4hHj6X6wVIH+yRvqoEXdQegbXBIixmscqvsLWktd6xMH5AIblcAjJ+B00r+I75ifEtwsZmGN/pukFi+Lkz4B5moGXN0KDUDV2x17xSaaReF2mzU9PSKHcGV8r8C1h/K4scufPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848503; c=relaxed/simple;
	bh=I8ER+tVk/Tp27l/vJ0p1p4VwD5JdTgHdZ4Rqk6pB3n4=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EFuxLQ/KmeNpXrlittB0aIn5i37pUXuWxDX43t3CFh+Wlybea1GI/it+XoA70SueYpB4564RqzTCIG7yiNmBDvvbqE51Hjo2uJAEotNXSgyCIp8IGeemHWzRyx4Bp/31c1l10eyVLPIwwQyU9ook7d0syAl0HVON1gJGEH3RYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rZTrqlrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF3FC32781;
	Wed, 24 Jul 2024 19:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721848503;
	bh=I8ER+tVk/Tp27l/vJ0p1p4VwD5JdTgHdZ4Rqk6pB3n4=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=rZTrqlrHzLSBNq6pghxlnx4uYtDAaOn9viV2gMmHV6kU0orWI7Z9ShrSoQvb1H31z
	 ZvgxqnDJQ5GiW7p5nvlyOL4BwFz38oFRp+l7El0fmgS+mSC0MF5aCaVqI+QTS0/gIG
	 ZLkgrnbnfHLNRFyipcRIyMJISVbO0x7Zo1l2VYds=
Date: Wed, 24 Jul 2024 12:15:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, hughd@google.com,
 willy@infradead.org, david@redhat.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ziy@nvidia.com, ioworker0@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Some cleanups for shmem
Message-Id: <20240724121502.aa554409b37f54fb0af26f56@linux-foundation.org>
In-Reply-To: <20240724121407.a81ef1cfdddec3ee348049fb@linux-foundation.org>
References: <cover.1720755677.git.baolin.wang@linux.alibaba.com>
	<20240724121407.a81ef1cfdddec3ee348049fb@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 12:14:07 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> The only difference I'm seeing from the v1 series is the below update
> to [3/3]:

oop. sorry, never mind.

