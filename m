Return-Path: <linux-kernel+bounces-350594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A27B990746
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CBECB219FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B866E1AA785;
	Fri,  4 Oct 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="blYdJ9EQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE221D9A7A
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055069; cv=none; b=sxFv418RgfAIfxK+3EnSMbYNCfnwjZLpxeIvoKPP0ofvYwWtSeaRS1S7nmSdzvrhrTiqPgAlabmWoKqZbfoWfRaWb7NVlpDx2LkdRuBiC3r6qgR5UwQIpObkmcuUboetdgxyMcAhID9BGhoTTpcgmCcD1bMUJjFK/N30o9V97Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055069; c=relaxed/simple;
	bh=Vhe5a/pCOXoNV1H+TJfJIiYDSHbQZMOXIJLV1km79KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMiOaQVExqRwbJXTtLhnYBZPLeTdcq7Q9SRDCu1oJ73IB6j2BXT9UDwwCAuG4Hi44+Rw/dEbLstEWdLC5eDwO++4Ix4Jz0KLBtW7QNqFW2H0X07IswaYSgKKK5syj9OPCiCYmOPljuQTowyyna3MQ5oCT1zGVnStRPtvzMpEtlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=blYdJ9EQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qcm0qXDs+Vr+WT+3nup9fENclVZeuo+9akDQMUTWbUY=; b=blYdJ9EQNTYCY7YVSQdNnJi5sX
	YksPjB4ryRppE7hBSVJj/WSQD/gwzjk4GElNU3ijhaRjPh/xMReOFFfLLWUSuaz84pmA0//+hIogM
	JIQCSNvdD6LgVwHs20tWu0ZFcNF+LmwW/8iWGrxl587LH87yt7GWhtpCdAqvbT7JityL0iEmeqLH3
	IcAfATmEJ0lA1VMA5Fud941YJVc28k985ID1u8qmH4kwEg+W6lRx0lN2FJGo9P8pqiccan33hR/kW
	rwrB6aivgLeet67J52N/jh7SN8u/8wvIKE2/POpMCEM0iWlz5y4ghp6bfu4OM65L86/ZUNUuerVTh
	K7bnN1Lw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swk3q-0000000Agm7-1p4w;
	Fri, 04 Oct 2024 15:17:42 +0000
Date: Fri, 4 Oct 2024 16:17:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: manas18244@iiitd.ac.in
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anup Sharma <anupnewsmail@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+093d096417e7038a689b@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] Fixes: null pointer dereference in
 pfnmap_lockdep_assert
Message-ID: <ZwAHFtAmMq9BNuGv@casper.infradead.org>
References: <20241004-fix-null-deref-v3-1-f9459b1cc95f@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-fix-null-deref-v3-1-f9459b1cc95f@iiitd.ac.in>

On Fri, Oct 04, 2024 at 07:15:48PM +0530, Manas via B4 Relay wrote:
> +++ b/mm/memory.c
> @@ -6346,10 +6346,10 @@ static inline void pfnmap_args_setup(struct follow_pfnmap_args *args,
>  static inline void pfnmap_lockdep_assert(struct vm_area_struct *vma)
>  {
>  #ifdef CONFIG_LOCKDEP
> -	struct address_space *mapping = vma->vm_file->f_mapping;
> +	struct address_space *mapping = vma->vm_file ? vma->vm_file->f_mapping : NULL;

Overly long and complex line.  Much simpler to write:

	struct address_space *mapping = NULL;

	if (vma->vm_file)
		mapping = vma->vm_file->f_mapping;

>  	if (mapping)
> -		lockdep_assert(lockdep_is_held(&vma->vm_file->f_mapping->i_mmap_rwsem) ||
> +		lockdep_assert(lockdep_is_held(&mapping->i_mmap_rwsem) ||
>  			       lockdep_is_held(&vma->vm_mm->mmap_lock));
>  	else
>  		lockdep_assert(lockdep_is_held(&vma->vm_mm->mmap_lock));

This one should have been lockdep_assert_held(&vma->vm_mm->mmap_lock).

I'm not sure that the previous one is correct.  The
lockdep_assert_held() macro is pretty careful about checking
LOCK_STATE_NOT_HELD to avoid the LOCK_STATE_UNKNOWN possibility.
But I'll leave that for Peter to fix.

