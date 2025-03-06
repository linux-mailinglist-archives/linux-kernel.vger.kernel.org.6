Return-Path: <linux-kernel+bounces-549489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20191A5532A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407053A9F83
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A18525BACB;
	Thu,  6 Mar 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvOBGLps"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7219D89B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282401; cv=none; b=ObIDj4myQStYcXzRlvo7nchQUGm2RyXdRqKynkzL/0oBcDmTG745/OfClzMktzy+MGAgQFfEJ3xIWtMfvGkMa7A3dbFAhSnmwUjAjnRYmJ+TAcWPADpQguhNgNw1UbcbnieV5v4DGKpK5NHDFErtsH55M7XrrB1ApXhsJeZtfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282401; c=relaxed/simple;
	bh=yesNcmtGbNvXrMqb4l4AWjH7Uh6GoBe2YNFgTLAoU2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2T+Gn9pYUu7mlZYcswMc7ZtoqZUlpDQjLwLCpcGM93EWo8b+ALbfwQ/skMk8nVfc54e8wUflboBKl35ED7QwVXZSTyZFehBqGI9NRuztw9w+y/JoMi+6nbr9zkhuPbebl7aS5yaTTErUCVIGCanEhbtz9KXClD5w98QCSktTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvOBGLps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741282399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hp0N3y6evf2yrWiBp62GjhkD2NyHCbEpRbyXBBPihTw=;
	b=cvOBGLps3Z02wkoofj6QYNkUUPHJN6q98NMeEvkIcQrjSLCvXh5vsWVP84FggZ2aQTi3bD
	rZfPsBE+z3H76vCZJyhT7mjPIjOpOLEuK1YH9jbcB7YvrIDjbhRmnVAHBjJsHzWiiIA9RJ
	/9XyaZUOswHIrdYhglbpjc+rUON11vs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-ccmIATjANe28STZy267aWg-1; Thu, 06 Mar 2025 12:33:17 -0500
X-MC-Unique: ccmIATjANe28STZy267aWg-1
X-Mimecast-MFC-AGG-ID: ccmIATjANe28STZy267aWg_1741282397
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8bc58e90dso17376366d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 09:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741282397; x=1741887197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp0N3y6evf2yrWiBp62GjhkD2NyHCbEpRbyXBBPihTw=;
        b=HzkuPFyt2oAPBhXJ9fZhUTEUUL2PTsPgXPv7jzczeFD+xoyM8qnYqQ1cm5xM+o60qo
         SCSBFXwHvCNM3Dr4L70MId/7wHp/3r3CFRzKyVhxY4WN9qd2qs7iPNF5JHriExEj3/Ag
         VaQxwUCJy2PEXirXJF7oDTObVg4TCoq5oL3XWMSJOR7cumDZxiD4imzZGE/qrqfm9kgq
         gwQLOFIp1m0E1YHFp5UEgC0xVtEjlHxmstfsWJRbXK0XMnyXcG+3RoAqkrFiOAkZqm4y
         f9ZdDaTq1mymyTL7ly/6rmbF7dIPBIDLx7w58Ih156HmAurJRb86T+T7Y1L1Rd2H4Dbk
         nr1g==
X-Forwarded-Encrypted: i=1; AJvYcCUehLXZx8hlwyixiivHQ5guQcOXpT2eH71PM68I8vJ0Sai7lXsNlDIjrHjDJ3uGPLdGESNE23zvA1FTemk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZnGbTar+o+yYqaNuRLzb+y9P2e7onNbXX/KlLK46iq6Bz5+vG
	UIl2HYkFBStGn3KNKchXxhpw85QmGb62GkGgMM1NYrxK/cMmmLJAeXlDq3hWj8kcCQ7UzQ5xhGb
	GTgUsODDzy8nvY2CvidocTRTHAoQYPcTwP5iAQqI/rQHbtB1il3XbWtuH7Y09IQ==
X-Gm-Gg: ASbGncs60LSPWwNv7lKwVktZHwSmfvUNbb/CxDQ8h9LV3ApH0Hmy+kwm/KVnGCt6oTp
	WybQtnjgALhV9wDXT91iFp/BoqaEvZoOR9pIfTrV8oiwfE5+Iy0CfpYr0cmJWi8PcK99hOkIzSJ
	bapLml5UlkkxXG0z/C6ma8vW1k7ruf0x/1T4baPviXk758pKZrlIfVz6bjsz95kWnO8727hpzd1
	UNs0A9C/venbeoRW0LnG7Aqc4qmcyx+Kgk3Wi4XjsP2aEKJM5rpW/c+4r7wUNUZntjQOIZdiQCm
	F+GhK2M=
X-Received: by 2002:ad4:5dcb:0:b0:6d3:f1ff:f8d6 with SMTP id 6a1803df08f44-6e8e6dd4013mr91007466d6.40.1741282397133;
        Thu, 06 Mar 2025 09:33:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXGTY2TZuxc/5qoe6G+TjInYEiN1/MY4M3Q3Wi5nBQl7XJwnFgOewPjxKsSfPGwYlCfIdGig==
X-Received: by 2002:ad4:5dcb:0:b0:6d3:f1ff:f8d6 with SMTP id 6a1803df08f44-6e8e6dd4013mr91007016d6.40.1741282396798;
        Thu, 06 Mar 2025 09:33:16 -0800 (PST)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a44b8sm9395206d6.59.2025.03.06.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:33:15 -0800 (PST)
Date: Thu, 6 Mar 2025 12:33:12 -0500
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
Message-ID: <Z8ncWAP7ln1St5W-@x1.local>
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
> +static int kvm_gmem_hugetlb_filemap_remove_folios(struct address_space *mapping,
> +						  struct hstate *h,
> +						  loff_t lstart, loff_t lend)
> +{
> +	const pgoff_t end = lend >> PAGE_SHIFT;
> +	pgoff_t next = lstart >> PAGE_SHIFT;
> +	struct folio_batch fbatch;
> +	int num_freed = 0;
> +
> +	folio_batch_init(&fbatch);
> +	while (filemap_get_folios(mapping, &next, end - 1, &fbatch)) {
> +		int i;
> +		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> +			struct folio *folio;
> +			pgoff_t hindex;
> +			u32 hash;
> +
> +			folio = fbatch.folios[i];
> +			hindex = folio->index >> huge_page_order(h);
> +			hash = hugetlb_fault_mutex_hash(mapping, hindex);
> +
> +			mutex_lock(&hugetlb_fault_mutex_table[hash]);

I'm debugging some issue and this caught my attention.  IIUC we need to
unmap the last time here with the fault mutex, right?  Something like:

        unmap_mapping_range(mapping, lstart, lend, 0);

Otherwise I don't know what protects a concurrent fault from happening when
removing the folio from the page cache simultaneously.  Could refer to
remove_inode_single_folio() for hugetlbfs.  For generic folios, it normally
needs the folio lock when unmap, iiuc, but here the mutex should be fine.

So far, even with the line added, my issue still didn't yet go away.
However I figured I should raise this up here anyway at least as a pure
question.

> +			kvm_gmem_hugetlb_filemap_remove_folio(folio);
> +			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> +
> +			num_freed++;
> +		}
> +		folio_batch_release(&fbatch);
> +		cond_resched();
> +	}
> +
> +	return num_freed;
> +}

-- 
Peter Xu


