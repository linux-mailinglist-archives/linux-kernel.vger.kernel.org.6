Return-Path: <linux-kernel+bounces-210051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C22C903E88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8472B249F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8B917C9EF;
	Tue, 11 Jun 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BS6yuUum"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C21EAD2C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115465; cv=none; b=Z6kxMF2Gtx1m0VRgfvijm4Emp/SM9JLg1Uh+ZJIeSyMW+V+OJGA6Pcgz9K6a2i7P6r/482S2X4AFR6IcSc82n4WYllz27bH0XTSMf5bP0OUxG0qdMpUv0aoUU2T/LiJJ+aQVbX7GPEGMs1mxxfVO006v+dsVn1byvKDuSfyC7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115465; c=relaxed/simple;
	bh=lskd3G4GCsnVhTKd1Caoncv7kWMFEDhrv5k1WmUJXC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHLoObVZf/V4nQtT0RGE3FbDbnlgtxOu+QErC6RBJ1L89ufqI0EPnp+RQv5d1Zy1V+cEOssL2+Fdu5B9+VROniVJQ197xjNlF9uXy+eLL+a287yJE9CWdXtxwCXuPC0SFY7gy6AtDNy9jdBM+D+fNkoFgLQOC6tDP+MgPsrfktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BS6yuUum; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718115462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jE1WXL5kXHxZ8d5bW4A1JQT02tpPoLrfA0795fkkSac=;
	b=BS6yuUum8NadmbBaOozqXzW6yYrIJj1ZaBhLiqx7TiL4/f89/TO5q/stGdDrLPrL2+e22C
	THJ5DhIEUiCU03bBJ9ZTJPwMF6hGUA+WyJYjYkoNxOeYct/iwOaofh398HoxajwOfsL+12
	nR1J7jeGq3p+zNYrNp5Mzcz77zQ7uqE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-ola2u5wGPQWQdT9yfl7tmw-1; Tue, 11 Jun 2024 10:17:41 -0400
X-MC-Unique: ola2u5wGPQWQdT9yfl7tmw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b087876f19so196916d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718115460; x=1718720260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE1WXL5kXHxZ8d5bW4A1JQT02tpPoLrfA0795fkkSac=;
        b=O0br0RTZFrNwOkdgqSbbw3gWG9/uqorua5Rw6khodPyPKrvDwmVCfhPsDj/UVb1f/T
         DBf7CZgQF7TaUnqBwmT5GM0TgY81R9WRoY0w5hgW0iykbJK+Zrcb8uE/BjEUuuDPy3Rg
         OUy1xU/dTxZmrEz6jdPUfIQXJ/9C3Nf3LNo0VAz+rIEXcBlYRYSqg5Hz0qciFZjz1geD
         sm2obp0Qbpwd94cyelIVJxyEKhM517Yf6IiyEtSN2czRfc2t1JDY96Z3eGBTXeGBzO7F
         3Bm46Wr/fX8BK4wtSRzdAENsjV7sd4YlTi81UxwyR12Du60JFdSb913gUmdviTcKC74T
         tTSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBRfvfNsbF1n7n7aZDxiOgR+1slOi78gydXy/OhVyh90163qjcde8BEus9jsgc5JV4FU1ruCpudX/bqFHKiP3FmlJIUDFSiwsTMmII
X-Gm-Message-State: AOJu0YxNmq290DlXeZn49lSIXAT1JDRhOEHwHw8ooj36XqOIs85Kyc8M
	dVY9weQgFxYCLlHhn7/sr5pzj/ffjs6+cecbpD5Jq2jj64E7MeCZsaux9tH/y7oxk+thMTFAhUd
	SuWS9lVKVHZC95MclGMcqLfhACpxDw1v9UGi5dBP/TcmbB7a6ohGS+nLQ2mJoX1kCx1KQQQ==
X-Received: by 2002:ad4:4425:0:b0:6b0:6e0a:4da8 with SMTP id 6a1803df08f44-6b06e0a5003mr90869756d6.1.1718115460058;
        Tue, 11 Jun 2024 07:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfzYLXL/Zzs2Dj1xAt8VEOpOAcqtFphruxKx4ngQRSZQuqsTYigZMQ12LgrL5w44f93GNlSQ==
X-Received: by 2002:ad4:4425:0:b0:6b0:6e0a:4da8 with SMTP id 6a1803df08f44-6b06e0a5003mr90869266d6.1.1718115459381;
        Tue, 11 Jun 2024 07:17:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b07520d999sm29500596d6.37.2024.06.11.07.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 07:17:38 -0700 (PDT)
Date: Tue, 11 Jun 2024 10:17:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 02/18] mm: Define __pte_leaf_size() to also take a PMD
 entry
Message-ID: <ZmhcepJrkDpJ7mSC@x1n>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
 <172b11c93e0de7a84937af2da9f80bd17c56b8c9.1717955558.git.christophe.leroy@csgroup.eu>
 <ZmgaHyS0izhtKbx6@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmgaHyS0izhtKbx6@localhost.localdomain>

Oscar,

On Tue, Jun 11, 2024 at 11:34:23AM +0200, Oscar Salvador wrote:
> Which means that they would be caught in the following code:
> 
>         ptl = pmd_huge_lock(pmd, vma);
>         if (ptl) {
> 	        - 8MB hugepages will be handled here
>                 smaps_pmd_entry(pmd, addr, walk);
>                 spin_unlock(ptl);
>         }
> 	/* pte stuff */
> 	...

Just one quick comment: I think there's one challenge though as this is
also not a generic "pmd leaf", but a pgtable page underneath.  I think it
means smaps_pmd_entry() won't trivially work here, e.g., it will start to
do this:

	if (pmd_present(*pmd)) {
		page = vm_normal_page_pmd(vma, addr, *pmd);

Here vm_normal_page_pmd() will only work if pmd_leaf() satisfies its
definition as:

 * - It should contain a huge PFN, which points to a huge page larger than
 *   PAGE_SIZE of the platform.  The PFN format isn't important here.

But now it's a pgtable page, containing cont-ptes.  Similarly, I think most
pmd_*() helpers will stop working there if we report it as a leaf.

Thanks,

-- 
Peter Xu


