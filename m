Return-Path: <linux-kernel+bounces-220130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342C90DD04
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B92284D29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA33C16EB6D;
	Tue, 18 Jun 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QLcIv/mt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61416EB4C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741140; cv=none; b=pQ44lBV9ZUlUmXoH3R3bZ1/c+FVba9HYAHmeqnj7KVp2617naLYUo9whajF8ATYxoKfwzZKPAbGh+ncU9BKkeF552jrr/aapP3KwsTQd7Wvt2UbvRRuhrSGKCtzuet4r12AZ8p1cZCYH0FEsnbvE9gTbuKwaU7q/C/GEoMm4PkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741140; c=relaxed/simple;
	bh=Q3cL9NGd/2gb60TlkW0zKQw7uwMcaoAmw21Ymu4oJHM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P/gvmKam1Jms81LASTI4qJX0JSQCZ22sWzgL0irmfcENqiMpkq9t7eewIwm/2fUmh0MLWuqPFPxm91IDjoUBsTFflmsn9vWLcUOuE/gkB6dupu9/o9UaIZ2jKq83nfcbKiIrp6uwEB0yroRMvfwOfuS6LL149w3qO4F5YrktxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QLcIv/mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44619C3277B;
	Tue, 18 Jun 2024 20:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718741139;
	bh=Q3cL9NGd/2gb60TlkW0zKQw7uwMcaoAmw21Ymu4oJHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QLcIv/mtxo/nJGWDDQFN778osoFvAfAcO1FudY0cHCIrVz6eySdt1dCzPj4FjNM/U
	 +TIqKU9R8cuMpcUPROK/leBJmcnFjQZChBL/krRCjRj1MEInSrD//rSO1d7HVuB0zH
	 gTG4Ujj5CLKp6HPQRWg9952AVvV+Y15RkAO+tRCc=
Date: Tue, 18 Jun 2024 13:05:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: hughd@google.com, willy@infradead.org, david@redhat.com,
 wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com,
 21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
 ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
 p.raghav@samsung.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for
 shmem
Message-Id: <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org>
In-Reply-To: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:54:12 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Shmem will support large folio allocation [1] [2] to get a better performance,
> however, the memory reclaim still splits the precious large folios when trying
> to swap-out shmem, which may lead to the memory fragmentation issue and can not
> take advantage of the large folio for shmeme.
> 
> Moreover, the swap code already supports for swapping out large folio without
> split, and large folio swap-in[3] series is queued into mm-unstable branch.
> Hence this patch set also supports the large folio swap-out and swap-in for
> shmem.

I'll add this to mm-unstable for some exposure, but I wonder how much
testing it will have recieved by the time the next merge window opens?

> Functional testing
> ==================
> I use the latest mm-unstable branch to test with reverting Chris's
> "mm: swap: mTHP swap allocator base on swap cluster order" series which
> can cause some problems (Hugh also reported in [4]).

I dropped Chris's series from mm-unstable.

