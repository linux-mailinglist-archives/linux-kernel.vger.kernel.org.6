Return-Path: <linux-kernel+bounces-297727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BA495BCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479031F24893
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234491CE707;
	Thu, 22 Aug 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="Sjtq0vYd"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA27217C220
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346561; cv=none; b=SniT7PVGuNfv7512gAxRg2qv6gLjlu1wmg8+Nf2XelWsEbk2PujbUwQLAQ5mr6ibFD5FUpBNTI3CsxMxk48YYWdDnVJ+ocM4od3uIK63q7H+QskLKuQ4EbOqFTu8Wfih1peFrOjRMDyrnbZc3TcxRaGh96nxQat/y4hxsHOfxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346561; c=relaxed/simple;
	bh=BqvlomoQuGgKcLCkJbBGkUc1aYljHC4hmHRvnjjGJ5c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LrYcxSgGhUEAu9pZlBPy7sz1da76uHXfCzra1SxZue8YAudnvF3dEmY9j8Ma3m+PNOy5Oa6hNmu2iKOK8VWKkZ8JPJttLahFEwjfPHO8hmOSkS02dvWLz0/1Oiei5zfCqtJ/Yew/kAmc5Lxo9ECHe2GiT6Syxhq6C8ONjhyOH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=Sjtq0vYd; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1724345969;
	bh=BqvlomoQuGgKcLCkJbBGkUc1aYljHC4hmHRvnjjGJ5c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Sjtq0vYdrH6sY8E4bhOw4s6ztKj182MKxE7+j3YsSroNcNgKrDasOntWEOmVg7N9y
	 KJYxXsa3PvweT/g89KbTgypcSpgZF10BE+xSeR70U5HQqIPM3PhrCt+RTzYEV7eIJm
	 lAZQEdnit1P9uHM3K0JqIIh8bsN4EurQrW737iVk=
Received: by gentwo.org (Postfix, from userid 1003)
	id 1FF864035D; Thu, 22 Aug 2024 09:59:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 1ECD640253;
	Thu, 22 Aug 2024 09:59:29 -0700 (PDT)
Date: Thu, 22 Aug 2024 09:59:29 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Yan Zhen <yanzhen@vivo.com>
cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
    akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev, 
    42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    opensource.kernel@vivo.com
Subject: Re: [PATCH v1] mm:slab:use kmem_cache_free() to free
In-Reply-To: <20240822022704.1195439-1-yanzhen@vivo.com>
Message-ID: <1bb9fcbc-310a-ad36-9e96-61dc80681f12@gentwo.org>
References: <20240822022704.1195439-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 22 Aug 2024, Yan Zhen wrote:

> The kmem_cache_alloc() is typically used to free memory allocated through
> the kernel memory cache (slab allocator).

Well yes but since we removed SLOB we can use kfree() on any slab object.

> Using kmem_cache_free() for deallocation may be more reasonable.


It is more symmetric and looks better.

Reviewed-by: Christoph Lameter <cl@linux.com>

