Return-Path: <linux-kernel+bounces-532930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AFFA453D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7140E16F890
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C137922576E;
	Wed, 26 Feb 2025 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FHe5iexk"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A02253E4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539565; cv=none; b=oujxMmwa9Ot31Up3tX9CmfwuNXMhDyoBITYjbevLo8uvEnL9I0bpQFLIzOai5+fxOdgmSiWXo/ps1wVqiuDO4+/g9KA8l00fB2MdkMEu4zokrg9ly+70byf3Bfo1GIA3vkmy3ts8E0ly56cmeudXtVR/xFGFXkNB+3AVy/s7I00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539565; c=relaxed/simple;
	bh=6vcYR2v2B6MciANMK08E6YqTnOo0JdbZAFgKa4JMsl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0Zjtmn0nrejHCHBMHHNtxGTzf9yRk1204kuWkG7fwAxTVtfxxXw0R80IYLYTOe6/gCO3TxRGz+Kj97fmQ9FI8QBBaYLkJHUxAQCJ9cZmyUFY9Mu3Rx4K4RbxY7sFx/V2uHyNe+bpaAdJ1+H84lliyYc/P6RCEz4oKs0W6AnW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FHe5iexk; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 26 Feb 2025 03:12:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740539560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YyGSXmyx3vQfVQV+XxrCOZhSj5bg+cbgXTy3aGv8JuQ=;
	b=FHe5iexkbGjs6UK995iroW1QDoc6qK7wVPrGLM7k+MCKlvVg9x3d8nizxWgM0pdyA8IWcW
	UWJDKiLCVxs0eLOSUuffYLvt4Cao5+gxZBw1Xb+TD0phCXLdiZLNXtH6/tBdSNjFzxRsko
	pp26qJzkyBGe81WnHliSGtAeHlljNWI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev,
	linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <Z76Go1VGw272joly@google.com>
References: <20250225213200.729056-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225213200.729056-1-nphamcs@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> Currently, we crash the kernel when a decompression failure occurs in
> zswap (either because of memory corruption, or a bug in the compression
> algorithm). This is overkill. We should only SIGBUS the unfortunate
> process asking for the zswap entry on zswap load, and skip the corrupted
> entry in zswap writeback.

Some relevant observations/questions, but not really actionable for this
patch, perhaps some future work, or more likely some incoherent
illogical thoughts :

(1) It seems like not making the folio uptodate will cause shmem faults
to mark the swap entry as hwpoisoned, but I don't see similar handling
for do_swap_page(). So it seems like even if we SIGBUS the process,
other processes mapping the same page could follow in the same
footsteps.
 
(2) A hwpoisoned swap entry results in VM_FAULT_SIGBUS in some cases
(e.g. shmem_fault() -> shmem_get_folio_gfp() -> shmem_swapin_folio()),
even though we have VM_FAULT_HWPOISON. This patch falls under this
bucket, but unfortunately we cannot tell for sure if it's a hwpoision or
a decompression bug.

(3) If we run into a decompression failure, should we free the
underlying memory from zsmalloc? I don't know. On one hand if we free it
zsmalloc may start using it for more compressed objects. OTOH, I don't
think proper hwpoison handling will kick in until the page is freed.
Maybe we should tell zsmalloc to drop this page entirely and mark
objects within it as invalid? Probably not worth the hassle but
something to think about.

