Return-Path: <linux-kernel+bounces-380950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1AA9AF832
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74B9B2189E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2846618C015;
	Fri, 25 Oct 2024 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qZ3VuSbs"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D081727
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827110; cv=none; b=NbyBS02A4YOMmoa87FJRQubFmSPYYzDyufkEPdwFc5KChbDRUGopiCa/8myshSLp3af6eviwb2RZJv6wcqeJMQUA6FS7/5i+UQ2OoT26HcRmQxNGjc0oaIeUabOK/9AxkFImx4Xw1Yp5L27aQ9flEwmDfox6H4Wwu/91tTPTRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827110; c=relaxed/simple;
	bh=gSdOw2C0fWikfMAw+92k/J3Z2DxgAa7qNn/CH7ikF1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcC3YmY/EzR92VyveuzyDaVRo9LSqx5apVDw5Hld1pk5b5rsUgiDTN0aKDZcvQ/T9OALzOnMW2NvvERVhY7MR8WfTQpD+tIUDjhHwhAicvX0KSpB4DOvFm8l7auSdBjRRnHIUnol366GoaykX+ycmKik1IE6eRvx7lIjHXqazCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qZ3VuSbs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KPtiRefIVj2r1QZ28pr6tjXRbRd65kS1Nb97xk88qNY=; b=qZ3VuSbshZ6dFiGxMqW+y4gJxL
	i26gT3A0aYyePxpDCzcaBn1kAmk7167UQ2IT1HuqbkE1MxCcd6d3+d53+F/G4g/Qwo9g9n1jEYU4q
	tDCDUU1cl81mMgfiN2fYm7Eb2VzTkEHcEO9bcLPriO1vaOxdhPX5La/atVP8N1QVCYn5KIGwfYN98
	/No8r0qoe6vf3qu3KVcZaXdTzog8ZXEEjedf190Mx7AhNKU0CMbOTefKIoGREgIX7EjlHqxtBpHVL
	VJ8nXMj9hbr34cLeQ4+uLkMotvO2TentmvlRM0AFFmgshci7zibuRQ4zzxTdIW9/e9wz3d2g/QtBM
	Rdr+ZRgw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4B2q-00000004nqv-0r6r;
	Fri, 25 Oct 2024 03:31:24 +0000
Date: Fri, 25 Oct 2024 04:31:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	wangkefeng.wang@huawei.com, shy828301@gmail.com,
	dhowells@redhat.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: shmem: fallback to page size splice if large folio
 has poisoned subpages
Message-ID: <ZxsRCyBSO-C27Uzn@casper.infradead.org>
References: <fd3893f318493a3720dc1a4b1c33f0f692ddf125.1729825743.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd3893f318493a3720dc1a4b1c33f0f692ddf125.1729825743.git.baolin.wang@linux.alibaba.com>

On Fri, Oct 25, 2024 at 11:26:39AM +0800, Baolin Wang wrote:
> The tmpfs has already supported the PMD-sized large folios, and splice()
> can not read any subpages if the large folio has a poisoned subpage,
> which is not good as we discussed in previous mail[1].

folios do not have subpages.  folios have pages.  do not use the term
"subpage" anywhere.  ever.

