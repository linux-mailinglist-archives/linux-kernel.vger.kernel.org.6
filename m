Return-Path: <linux-kernel+bounces-182268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C68D88C8904
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CA52813C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497676A339;
	Fri, 17 May 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TH3VLfoZ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26EE69DF7
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715958459; cv=none; b=m8cQWKSBWBU74m7SVUSwXZiBvnet0mQg8R6lk+7z4aZLFmvFymU3U/mlYo32e4hMIJb3xp6eeBl06u+mTkyIwiTytcB0YBn7ScOfXMrOPos0MNsy+lpfLS0ykwZOuFykol/3f5Jwle1pkHtSn7sOOo0kDl8i2dbDdlFpNSahZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715958459; c=relaxed/simple;
	bh=eny8eu9H9qezFc4DsJLtVNwX8CqUTQ0ivx/im31CVv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgxwjTdJ9NhLksB4NytdPAsbWj767OZSO4DARDYvL4YIV5CXzKF/K2jN7gcl2MjqKGRs2O15na1DW8WJ7tXlnL35u5wI2n5V4uiEWCnZ6GQ9Lz7zlFSd55ETXlLme4GnLQwH3IOSwj9jIsiqAjQTAMw6LrnpVIQlrk/D+vE8UCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TH3VLfoZ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51f99f9e0faso2441998e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715958456; x=1716563256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2IpcqFuguhkshSycy+14Kc4bI4lgV1eoYcFaNGuWgI=;
        b=TH3VLfoZMp3Mj8iMMqCBMFrjCeWJbjjivIgOPMwlhD5APUA4E/LH7OUZXJvyK6ScAJ
         QOAWQfMqah/DaqkBzoauDZiZ/gYGXtCBBDD5wiZZactMOdYOQd7sUNBwuk0UDJwk+sIz
         Nz8ezQYJEPMQR2FNZ65acUKXgm0t/2pyBDsEKNJZb3wtj8Dx57mBbg5be1S0SRvp6UBI
         HJUnvM0gJbxxjr8A2szE3WDme4jPle3pkfa5aeExecGGsMcc17/nOzykhbK/gRy+okrb
         v68pgk0+JpxAPmUs3me1T8AMhjJ/nr2XftPdt/j0+DZx3jqA2k+BYFRTn1ZUyQTK2Hv3
         uYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715958456; x=1716563256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2IpcqFuguhkshSycy+14Kc4bI4lgV1eoYcFaNGuWgI=;
        b=T/Xv8f6wCggohbJlASie8t+T6v25Lb4AekhI2xnRIdFQiVFFIyDvVlbvE0RZTsawKZ
         +NgxZ7BVfPI+j6XlvvYkmXFX9/gwstBn4OAW1n2OG5Du/fyIUfz7Kry8uqHqtQ964LVk
         SY6ZOkCHJ5ytfPO6IGH7vFPPHc+dhW+ZcmSvmHeiYkXnFzyO+M+ghtspZ4Ee5233/vtX
         hN/gMC3WYeftSRvbxgBZ6ag0zHUtn8wYHXxEEtd/QBfzcZW7NFxKMB8vAevrUiPNiodO
         m0/8mkUF5m187ktjoMSw4ZDgwzjy3XWoBfetBxdFH9SBKtrSwow/AXvwA2Wv7VAglvHh
         DVHg==
X-Gm-Message-State: AOJu0Yxlez+zo6aLZ9R5/wOMRZ7obGEaztfQMbS0DeyRi4CY8X2sTAkH
	JJjMeqrXbNDTpsuDryoI/sw2REDcYQLZfTeAVnmKvsvx1NGBhzkIq7CEn11NF6Ntll+iQjBFWZx
	L1w==
X-Google-Smtp-Source: AGHT+IHl8G1Pv0ELVow4czV1iE+a6fx2dTWRemZUhtz+vu03Dn0Skt9D9cqMJ+o3lWoS05lHw0k4VQ==
X-Received: by 2002:a05:6512:3b86:b0:518:a55b:b612 with SMTP id 2adb3069b0e04-52210579225mr18978308e87.54.1715958455570;
        Fri, 17 May 2024 08:07:35 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79be1dsm22040543f8f.10.2024.05.17.08.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 08:07:35 -0700 (PDT)
Date: Fri, 17 May 2024 16:07:31 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>, rostedt@goodmis.org
Subject: Re: [PATCH v1 1/2] mm/memory: cleanly support zeropage in
 vm_insert_page*(), vm_map_pages*() and vmf_insert_mixed()
Message-ID: <Zkdys7YKC5pe1vAu@google.com>
References: <20240430204044.52755-1-david@redhat.com>
 <20240430204044.52755-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430204044.52755-2-david@redhat.com>

Hi David,

[...] 

> -static int validate_page_before_insert(struct page *page)
> +static bool vm_mixed_zeropage_allowed(struct vm_area_struct *vma)
> +{
> +	VM_WARN_ON_ONCE(vma->vm_flags & VM_PFNMAP);
> +	/*
> +	 * Whoever wants to forbid the zeropage after some zeropages
> +	 * might already have been mapped has to scan the page tables and
> +	 * bail out on any zeropages. Zeropages in COW mappings can
> +	 * be unshared using FAULT_FLAG_UNSHARE faults.
> +	 */
> +	if (mm_forbids_zeropage(vma->vm_mm))
> +		return false;
> +	/* zeropages in COW mappings are common and unproblematic. */
> +	if (is_cow_mapping(vma->vm_flags))
> +		return true;
> +	/* Mappings that do not allow for writable PTEs are unproblematic. */
> +	if (!(vma->vm_flags & (VM_WRITE | VM_MAYWRITE)))
> +		return false;

Shouldn't we return true here?

> +	/*
> +	 * Why not allow any VMA that has vm_ops->pfn_mkwrite? GUP could
> +	 * find the shared zeropage and longterm-pin it, which would
> +	 * be problematic as soon as the zeropage gets replaced by a different
> +	 * page due to vma->vm_ops->pfn_mkwrite, because what's mapped would
> +	 * now differ to what GUP looked up. FSDAX is incompatible to
> +	 * FOLL_LONGTERM and VM_IO is incompatible to GUP completely (see
> +	 * check_vma_flags).
> +	 */
> +	return vma->vm_ops && vma->vm_ops->pfn_mkwrite &&
> +	       (vma_is_fsdax(vma) || vma->vm_flags & VM_IO);
> +}
> +

[...]

>  
> -/*
> - * This is the old fallback for page remapping.
> - *
> - * For historical reasons, it only allows reserved pages. Only
> - * old drivers should use this, and they needed to mark their
> - * pages reserved for the old functions anyway.
> - */
>  static int insert_page(struct vm_area_struct *vma, unsigned long addr,
>  			struct page *page, pgprot_t prot)
>  {
> @@ -2023,7 +2065,7 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
>  	pte_t *pte;
>  	spinlock_t *ptl;
>  
> -	retval = validate_page_before_insert(page);
> +	retval = validate_page_before_insert(vma, page);
>  	if (retval)
>  		goto out;
>  	retval = -ENOMEM;
> @@ -2043,7 +2085,7 @@ static int insert_page_in_batch_locked(struct vm_area_struct *vma, pte_t *pte,
>  
>  	if (!page_count(page))
>  		return -EINVAL;

This test here prevents inserting the zero-page.

> -	err = validate_page_before_insert(page);
> +	err = validate_page_before_insert(vma, page);
>  	if (err)
>  		return err;
>  	return insert_page_into_pte_locked(vma, pte, addr, page, prot);
> @@ -2149,7 +2191,8 @@ EXPORT_SYMBOL(vm_insert_pages);
>   * @page: source kernel page
>   *
>   * This allows drivers to insert individual pages they've allocated
> - * into a user vma.
> + * into a user vma. The zeropage is supported in some VMAs,
> + * see vm_mixed_zeropage_allowed().
>   *
>   * The page has to be a nice clean _individual_ kernel allocation.
>   * If you allocate a compound page, you need to have marked it as
> @@ -2195,6 +2238,8 @@ EXPORT_SYMBOL(vm_insert_page);
>   * @offset: user's requested vm_pgoff
>   *
>   * This allows drivers to map range of kernel pages into a user vma.
> + * The zeropage is supported in some VMAs, see
> + * vm_mixed_zeropage_allowed().
>   *
>   * Return: 0 on success and error code otherwise.
>   */
> @@ -2410,8 +2455,11 @@ vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
>  }
>  EXPORT_SYMBOL(vmf_insert_pfn);
>  
> -static bool vm_mixed_ok(struct vm_area_struct *vma, pfn_t pfn)

