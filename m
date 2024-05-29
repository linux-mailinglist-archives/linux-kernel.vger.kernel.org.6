Return-Path: <linux-kernel+bounces-193835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D0E8D32DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D38B1F24736
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5E9169AF3;
	Wed, 29 May 2024 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eMHOqQvr"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBD816A38D
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974605; cv=none; b=jF6YuO3uomdzGxHJxSn5X+wzYJxw6ToCQKKBxyW0gptJX5B+AgEofdHOE35LGUrx8A4K7FMAKbqUi/QSPXX2UwhG64kJeMpbI6RjYlasT3iNp4J7zMGJlwy/YlG4HBzN0dSCYlFwzJDCbx1r6i5fDu8c0/6xFENr/h7C9MjYoP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974605; c=relaxed/simple;
	bh=GotQfL40NIkCyK0P0uIgVXvV8IV6Viispue0Gu1rRlw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVcW93SwiPMEyZBzMShHsqI9bU6dWra/mquMuN786/HuIEDDHhxiH+2n0UZksDdDQAB0wkX8zAjktqe8A8bAMvqfNO2DLxLFFVnGrcfvStO0/nVajYp66p3a6cr45K4FSCAoiUrqTW/ZFHna3DD9HY97OFFiDXP7ibXDuqtJMlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eMHOqQvr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so15896935e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 02:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716974601; x=1717579401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fhJ836irwNS/8JeOTE2TBDDML/9+Ts5hKkWKN+MrauU=;
        b=eMHOqQvr1ikt6lqlqUKyulR+Pl7NIJ3m7izNRLEjQ2mN7NKUKY91hpCbDtvXQd4D7Y
         DhjqaGbxwYUGQMFHX2kY1YsB6b1sHXcnpKUVYGz/E8GGgZP/WOTNvekE7GS8LfCH+Oqk
         dxARq2G0oZ5FKngWpdwbtzuYZlur95XyNgwODcBn8ytHQ2MJl0PsnnAn4gy2SZnPlr4P
         2W2LZsY5vwAhtRQFyOz2CdKBwN02qdtKx06AqQIOz21YUz2xqNF6DWE68ZWka1li2WXC
         JBr171vXBjnpXFlcjsKyH1X2eUsPNMmGoCjlCMANCZNa1D+hjX3zCIn4pAGUQ1+Qb0bu
         TA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716974601; x=1717579401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhJ836irwNS/8JeOTE2TBDDML/9+Ts5hKkWKN+MrauU=;
        b=a5FkQmay3aY0tttTab29W0kPCbIPuJ4dF9WvQwNosLEOeKR3hPFNZYWlVBW9IuHxic
         CvmaKMakh2kWGPzd0G9s5Lt2ejJKxL9HT8gq/3TVF+JHRJIO5M8SQJ8eljAHTdTEbjwr
         NXJI6WektXuUasBL5gYYHSHZYK13ilIFa78d7IOyMQDJ9FH/zj+JaH4k7szOwkS5Q7Vp
         Uf8Fwv9W6I0NZlLVuzDXXCDt7S733VnxEMk4Pig9UFtZvOTja8o6kJbf8GVsLyB1uwPM
         hSyrbLF1cmOXil56GDoZazwTjRdwPaDwIOlBCptHfITO2Q09+b7D/z4oajKlNLmaEayU
         gFfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQvtfncc9ZugotcqCXBpZLmaCL+esYVDGnh/BdsAJqqR/lUp8pHkbtth79AbqHi0zMcWNz9BOpqtQGVt+13dPRkkeHgR1657wZic3c
X-Gm-Message-State: AOJu0YxEVsXJ8dRNDL3mzFpgnNoxWf2nr9o1AwfsnQ43SzIATg8q4qxh
	Mg1scj05aTgBDLq3ZVtzdF7bks6zvricUwWyyfuxHb9bH9GOGZnbatNsKtDS9Ro=
X-Google-Smtp-Source: AGHT+IFm78cnc3X0c1k2D4eGRsFsXjAbi0O/Q9Jcd6v24wtsbWarGavak3rEikXZrSA/XmfQUHqeuA==
X-Received: by 2002:a05:600c:3144:b0:41a:c592:64ff with SMTP id 5b1f17b1804b1-421089f9787mr136068615e9.35.1716974601075;
        Wed, 29 May 2024 02:23:21 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089708edsm173311555e9.16.2024.05.29.02.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 02:23:20 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Wed, 29 May 2024 11:23:18 +0200
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 14/16] powerpc/64s: Use contiguous PMD/PUD instead
 of HUGEPD
Message-ID: <Zlb0BugOwko4PrLm@localhost.localdomain>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
 <610be6003a6d215e9e9ca87d7f5402042da1e355.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <610be6003a6d215e9e9ca87d7f5402042da1e355.1716815901.git.christophe.leroy@csgroup.eu>

On Mon, May 27, 2024 at 03:30:12PM +0200, Christophe Leroy wrote:
> On book3s/64, the only user of hugepd is hash in 4k mode.
> 
> All other setups (hash-64, radix-4, radix-64) use leaf PMD/PUD.
> 
> Rework hash-4k to use contiguous PMD and PUD instead.
> 
> In that setup there are only two huge page sizes: 16M and 16G.
> 
> 16M sits at PMD level and 16G at PUD level.


On 4k mode, PMD_SIZE is 2MB and PUD_SIZE is 256MB, right?

> +static inline unsigned long hash__pte_update(struct mm_struct *mm,
> +					 unsigned long addr,
> +					 pte_t *ptep, unsigned long clr,
> +					 unsigned long set,
> +					 int huge)
> +{
> +	unsigned long old;
> +
> +	old = hash__pte_update_one(ptep, clr, set);
> +
> +	if (IS_ENABLED(CONFIG_PPC_4K_PAGES) && huge) {
> +		unsigned int psize = get_slice_psize(mm, addr);
> +		int nb, i;
> +
> +		if (psize == MMU_PAGE_16M)
> +			nb = SZ_16M / PMD_SIZE;
> +		else if (psize == MMU_PAGE_16G)
> +			nb = SZ_16G / PUD_SIZE;
> +		else
> +			nb = 1;

On 4K, hugepages are either 16M or 16G. How can we end up in a situation
whwere the is pte is huge, but is is neither MMU_PAGE_16G nor MMU_PAGE_16M?

> diff --git a/arch/powerpc/mm/book3s64/hugetlbpage.c b/arch/powerpc/mm/book3s64/hugetlbpage.c
> index 5a2e512e96db..83c3361b358b 100644
> --- a/arch/powerpc/mm/book3s64/hugetlbpage.c
> +++ b/arch/powerpc/mm/book3s64/hugetlbpage.c
> @@ -53,6 +53,16 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>  		/* If PTE permissions don't match, take page fault */
>  		if (unlikely(!check_pte_access(access, old_pte)))
>  			return 1;
> +		/*
> +		 * If hash-4k, hugepages use seeral contiguous PxD entries
'several'
> +		 * so bail out and let mm make the page young or dirty
> +		 */
> +		if (IS_ENABLED(CONFIG_PPC_4K_PAGES)) {
> +			if (!(old_pte & _PAGE_ACCESSED))
> +				return 1;
> +			if ((access & _PAGE_WRITE) && !(old_pte & _PAGE_DIRTY))
> +				return 1;

I have 0 clue about this code. What would happen if we do not bail out?


-- 
Oscar Salvador
SUSE Labs

