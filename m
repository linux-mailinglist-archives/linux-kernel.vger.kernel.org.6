Return-Path: <linux-kernel+bounces-515545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B3A36612
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CE6171DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A6119924D;
	Fri, 14 Feb 2025 19:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Mt2nO6ae"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70AD15FA7B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561228; cv=none; b=UM7JR4350FM+3uv3rdVtzCDVcJ4BlVIzDVUsAvn/i7D61vniP+LNMTru0NH/CS7OBLcHFCCbAdKnbt8PbHzQFS0pjFFMjI5zuP980LOtu0MZGbPsSLZ7fKC6MqZBlqcuP0Bi45FQaqYcE0UHE7DGBgkctV1qlnF3fb5w7OsX9vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561228; c=relaxed/simple;
	bh=55jqhg240yOgqtQp2hkMhDJI7bwzW3oaSKWgrwuFEsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZaDMrOD20v3DDMxfkbXp7ynVUvVq5Ou/PcEi45Y/o0FltW2dpJo9gi9uMWUIaxjg8lU8vBGVAGFHdLdv55naM+bpT3dkLk3HIJxT9/oMiKzYpMhxcbkjhyUV5RN2c+zGPCEuMQaIevZHD4Mmq+3Fq6L/mlHEPPhLK7cbFz+QDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Mt2nO6ae; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0848d475cso118508885a.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739561226; x=1740166026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q54C682wupKw2fn+9hJZ17sdX89XEBbDkpwzhueywsk=;
        b=Mt2nO6aeycPPfnCy1bujlM1UYhiHUIljw6VZR48g1zYy7uo5waceIvFPpk457M4jeQ
         FOLSEXC7Hzeh6OwOdFmQzrYp4eLRyNG03hDEOcKA6hb5r84Y4RemgNUr/Rw/1I69DkGi
         bZl3hdwcRsRh1TXisDohs3AKG3ClrGD0URCCyifSMD3lkvIE+E1BOQiqLHfjQxv96qJ9
         xKfCmih7c0TR+QhlljWIycxTyDfuXUg7kU1dfzeCrFJinSf1nB7baunhUFi/VANVk+yW
         2ZEmZSxVfELs3RRUPokNWrEZNfrWhY9sG/EPQEGHP+WylhLWxZq9ffmzkRYPZN411bZY
         BThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739561226; x=1740166026;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q54C682wupKw2fn+9hJZ17sdX89XEBbDkpwzhueywsk=;
        b=Mu+akIziLgUXXyIco5akAipvT8Tx8WbQmGXnsiASw5zjfx2J9mj1e8Nt/DLhXDwpIn
         vwp+PVQRPbP+wjfEaWjIF6RTzMlS7sfuOCd+i8enDtUsw69nIhpfqBn5sy/hZfHWOKKN
         96rrLXaMoHu4qXi72Z4YgRyEeaH0uDao4AF/n1LreuuxXZyLrtHba5D5CnZuJjFQ1CkT
         UuQGc77vjRj3lbfFCHWWuuFUos768xzSCs00Dfg/pMhcxTUKmvvn293ERB0TX3tlEzux
         QWPnzNPFC3rv7noDRI78od/heQ3XrE1hgN9wCbmI+UJqgARIZXKUIgDIxoo4BT8VcMsx
         ZULA==
X-Forwarded-Encrypted: i=1; AJvYcCXC/oPnJdouMaxinhOfJ4pWRNsB8H9OAZJzfzWAK0gbHkGyko/1DcDoZES2Ab0LG4JSmmk0x3F50tAzOzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTLezrhTESWqolbcsf3V6azZJ92xEwaausgpKC6E/zp8a/K/8O
	I2z3zqmZFU5OiSdlvSRuwVMfUF/AZ29sVvT/ItH0XNfH96Qh9zICQ05lBGbGa9Y=
X-Gm-Gg: ASbGncsBb7PqdnfL0pCiVG0D4H4S5Ak+h9pNf5o3JdhTcNzdG+OFB7Ub3mzV0RVgAaw
	CjGzap3DdqPdRRplg4pUDOVkxORvU4O0GHegBNiITEBWjDAXz4QAWIw7E5H0pQ6JZ4pwHqd9Xqf
	kQRTT0Yc2L9iEJeSdDw4gb4jIxo0r8wCpcxeAYvjsB/lLu4uUbb6KOSAPnkYADIOXIpn9ePjnjs
	/qqU1AFVm74PIIrKj8T7h7+7mD61SWVugvflDff4Juba7GKe/kPnohX2ZGLJ8UhO9ZuQWthI1M/
	pkaHxcQYQSXcaCcajxLJdkvkY/KrKAVGFPfe58HhvHCD4R7idf/M0HVCqMiaP/Kv
X-Google-Smtp-Source: AGHT+IGP6EIu6D5/X4T1lXUP3TqCWP6QCFadGFyDUhKfkvIRhoG4FICvPgxc52H21XaC8VTPwxK1CA==
X-Received: by 2002:a05:620a:2691:b0:7bc:df55:2cd0 with SMTP id af79cd13be357-7c08aa9f850mr103218785a.48.1739561225699;
        Fri, 14 Feb 2025 11:27:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c86155dsm235281185a.87.2025.02.14.11.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:27:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tj1L6-0000000GmO1-2uwa;
	Fri, 14 Feb 2025 15:27:04 -0400
Date: Fri, 14 Feb 2025 15:27:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
	mitchell.augustin@canonical.com, clg@redhat.com,
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/5] vfio/type1: Use mapping page mask for pfnmaps
Message-ID: <20250214192704.GD3696814@ziepe.ca>
References: <20250205231728.2527186-1-alex.williamson@redhat.com>
 <20250205231728.2527186-6-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205231728.2527186-6-alex.williamson@redhat.com>

On Wed, Feb 05, 2025 at 04:17:21PM -0700, Alex Williamson wrote:
> @@ -590,15 +592,23 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
>  	vma = vma_lookup(mm, vaddr);
>  
>  	if (vma && vma->vm_flags & VM_PFNMAP) {
> -		ret = follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMMU_WRITE);
> +		unsigned long pgmask;
> +
> +		ret = follow_fault_pfn(vma, mm, vaddr, pfn, &pgmask,
> +				       prot & IOMMU_WRITE);
>  		if (ret == -EAGAIN)
>  			goto retry;
>  
>  		if (!ret) {
> -			if (is_invalid_reserved_pfn(*pfn))
> -				ret = 1;
> -			else
> +			if (is_invalid_reserved_pfn(*pfn)) {
> +				unsigned long epfn;
> +
> +				epfn = (((*pfn << PAGE_SHIFT) + ~pgmask + 1)
> +					& pgmask) >> PAGE_SHIFT;

That seems a bit indirect

 epfn = ((*pfn) | (~pgmask >> PAGE_SHIFT)) + 1;

?

> +				ret = min_t(int, npages, epfn - *pfn);

It is nitty but the int's here should be long, and npages should be
unsigned long..

Jason

