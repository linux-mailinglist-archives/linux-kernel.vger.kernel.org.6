Return-Path: <linux-kernel+bounces-426709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F789DF6E4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F34162E90
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E5E1D7E54;
	Sun,  1 Dec 2024 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGWhUhDD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4241D7E57
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075982; cv=none; b=RWWUyMEBz4IgKtEPl+AWGbQ3ju7jkPCaMjxm/V1gzstRq1yA6eZkrofANEAdizXKslllfYK+udTXZyuClLLZfReNifw45LOAiACVEp1P7xPKGQod1URir4ME4kxrwuz8o3WjFbbLPtGmpP9ScObZ28x9yPZzwonK5TzZGiJX3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075982; c=relaxed/simple;
	bh=aCcFCSZJUXI54+bKPh/05TzVJL4t5c3nMnUzxLQ+3Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9I88ANUtyCH4chPITAgYK1IBIVkNlffjVUu27745rDWClihnKITLnBJafjUekTSq1i0Yjf0xwayClpd7W0FGOcatdFVquffYv0txi+fxAFbsvEpXtZXx9loMRmp4k66Qnf/11s9hG9g+D8MlIPQj19awStFWHmTpTYB1HP2L78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGWhUhDD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733075979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0A+hdS0S9TZs4FCHTCUNfBMXeoZLW6DBQh4uakYhdW8=;
	b=VGWhUhDDE6m+b2rIaDPxKgBtziQo68vTQzjnol33SUi5a7WqBSAxX3J8dbcFrfOmSUwi4l
	PMReeGzgyXw9S4COcKUsPozB5lUbftasOmkYhrKSUW3pxS0iEJQ8XDFsCOkie2R4LY2MDs
	UmWTclP2zOs1LOwyZhdE3FGltIQEBBk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-ufpaLKO2NlmMTm_m6ZSF4Q-1; Sun, 01 Dec 2024 12:59:38 -0500
X-MC-Unique: ufpaLKO2NlmMTm_m6ZSF4Q-1
X-Mimecast-MFC-AGG-ID: ufpaLKO2NlmMTm_m6ZSF4Q
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so18116085ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075977; x=1733680777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0A+hdS0S9TZs4FCHTCUNfBMXeoZLW6DBQh4uakYhdW8=;
        b=L/7V1BU+5ZsGvsfN6MPki+MtGFBNm7OYP7U/bFoBN9r2WXjQKOPUqeUHDC9Fp/vol8
         0NkoTgtsdXr39L9rAyWI8Nd6H8117pdZ9A6n+pgaWvJ/1GKwoDclCv4R0Z7EcM+2kyeL
         5+pDWV2V72WIWTVc3BVO+Ti0twdJkU+DW17rpKTIEzCmcnF2xklrYqvKbs9ch8/6u5OZ
         ALY9Tn4AqZxxDkcX6PHo5gOkC+iMLG7i9HiXdoJ1BCatKZWXJ3Ku1SAx5gnLsfLOMowv
         D04jpjwJnWZFUUxFIYKKqNFPOtsyT0CS9VyWKs1wt3bhArZzvQ/nqHZnq7b3Ubg5tDxv
         6Wbw==
X-Forwarded-Encrypted: i=1; AJvYcCUZhsar0dKXDB3v8WP5957XfYJpyVGqw8FhqW8pOj+9PNbxWZPZ4ACh/I7i5brPO+uwiUlDPt1RFuyDjFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tGDNVtr+9q2Taw2RLv7UpF0vCfrfrYs3pSd+G0DTPnCADzLq
	hSXxxXwBgVL8fgCgL7HvUcHhfvHGlmC2A4k4gf08KgMCpqBusTnC01D5fQTvToDR6yzGGAGpRO3
	otgC6PrvYGFoogYz4y27N690f4qz1V3Ov+TzNV/7SWSLl6VckZiL23ab5dRIv6A==
X-Gm-Gg: ASbGncsuWv8oizP7O7ceIcapXiON77WDn6AgRCw9rmIqSu4tgL424Zam7jlX1Q7kugU
	E5s/0ZBI/D7XbrUk0vf5fxDrxetO7gh2uS78tGW0pZVXEPrRu0qPUP/c2Il9yuAytA6KuJOS3+R
	InQZSG+tplKs6PQyZVOjUTRk7uhPFNqfLmk6ZKEPI1slhIRNPXLIAYHLBbp7gGio1D6EAOKnBVl
	bEtrLNM1vjUwc6oAr6BR88nBpsQl2uoolk4/ywKYH5u3a7JkT6lZT8ODzEzJWkCKEhANzswsE+u
	s6f2aHhbtKE=
X-Received: by 2002:a05:6e02:2192:b0:3a7:dd45:bca1 with SMTP id e9e14a558f8ab-3a7dd45c5e2mr85506565ab.17.1733075977450;
        Sun, 01 Dec 2024 09:59:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHry52UnkIwNHPlxMfjuNJbz0kuNzIn+XivMrF6Q+kiRWIeU+o9LVgyCqSYZICKYohcFcyI2w==
X-Received: by 2002:a05:6e02:2192:b0:3a7:dd45:bca1 with SMTP id e9e14a558f8ab-3a7dd45c5e2mr85506025ab.17.1733075977146;
        Sun, 01 Dec 2024 09:59:37 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a7ccc0b987sm18690775ab.34.2024.12.01.09.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:59:36 -0800 (PST)
Date: Sun, 1 Dec 2024 12:59:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk,
	jgg@nvidia.com, david@redhat.com, rientjes@google.com,
	fvdl@google.com, jthoughton@google.com, seanjc@google.com,
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com,
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev,
	mike.kravetz@oracle.com, erdemaktas@google.com,
	vannapurve@google.com, qperret@google.com, jhubbard@nvidia.com,
	willy@infradead.org, shuah@kernel.org, brauner@kernel.org,
	bfoster@redhat.com, kent.overstreet@linux.dev, pvorel@suse.cz,
	rppt@kernel.org, richard.weiyang@gmail.com, anup@brainfault.org,
	haibo1.xu@intel.com, ajones@ventanamicro.com, vkuznets@redhat.com,
	maciej.wieczor-retman@intel.com, pgonda@google.com,
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org
Subject: Re: [RFC PATCH 14/39] KVM: guest_memfd: hugetlb: initialization and
 cleanup
Message-ID: <Z0ykBZAOZUdf8GbB@x1n>
References: <cover.1726009989.git.ackerleytng@google.com>
 <3fec11d8a007505405eadcf2b3e10ec9051cf6bf.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fec11d8a007505405eadcf2b3e10ec9051cf6bf.1726009989.git.ackerleytng@google.com>

On Tue, Sep 10, 2024 at 11:43:45PM +0000, Ackerley Tng wrote:
> +/**
> + * Removes folios in range [@lstart, @lend) from page cache of inode, updates
> + * inode metadata and hugetlb reservations.
> + */
> +static void kvm_gmem_hugetlb_truncate_folios_range(struct inode *inode,
> +						   loff_t lstart, loff_t lend)
> +{
> +	struct kvm_gmem_hugetlb *hgmem;
> +	struct hstate *h;
> +	int gbl_reserve;
> +	int num_freed;
> +
> +	hgmem = kvm_gmem_hgmem(inode);
> +	h = hgmem->h;
> +
> +	num_freed = kvm_gmem_hugetlb_filemap_remove_folios(inode->i_mapping,
> +							   h, lstart, lend);
> +
> +	gbl_reserve = hugepage_subpool_put_pages(hgmem->spool, num_freed);
> +	hugetlb_acct_memory(h, -gbl_reserve);

I wonder whether this is needed, and whether hugetlb_acct_memory() needs to
be exported in the other patch.

IIUC subpools manages the global reservation on its own when min_pages is
set (which should be gmem's case, where both max/min set to gmem size).
That's in hugepage_put_subpool() -> unlock_or_release_subpool().

> +
> +	spin_lock(&inode->i_lock);
> +	inode->i_blocks -= blocks_per_huge_page(h) * num_freed;
> +	spin_unlock(&inode->i_lock);
> +}

-- 
Peter Xu


