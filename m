Return-Path: <linux-kernel+bounces-447589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E779F349E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0FE1645BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5F9146D65;
	Mon, 16 Dec 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsNnKDRG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0F17C64
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363269; cv=none; b=IQwX1P1My/A2pFShgrNurg/xzitpFOGDFZ5k2jhldYHG5cOWwu29bI0JAAWlOzJexxqTU8RoBAyd/XeY1D5LoqlnIMbueYGq1L/Ms06OokSb/WZdcI4RvXg8TCKyD/FWwTm07cagqy4R6wKDDL8RzaZEyye1YW7LpSNaxK1cuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363269; c=relaxed/simple;
	bh=m99RJ0fQ6k4JEIPPgWhqny+fdCzNajg+pd++rSKvKOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djiLM5W/1aYWEz9a7IgbOHctMNjTxyBdql9ybueV2BddBHEFjDPQ3a4tE0VC8sYBSXx4jv/Scli2W6ct/AeJGH3U/aGx8BDkEPxA7PEmfhA+BzwxZdAaEGZk/XH2V1MfQYw0BiIYysbC8GB1VvkWNLqXnFAIsRbh8CmPOhuVD7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsNnKDRG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734363266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EoXThDuzdwSCkju3MJU1hPpxlhHdcR6+6fSsTLqkgM0=;
	b=NsNnKDRGfGw+tSHHNQQLRIGhFF8jhwGwTwpNsbWzqdO37tbD0yb48flKkNq0b0Xc2oJtUp
	dmjFkPqwgAxlS8df0OUQCZCkRN8B2GaBaIqGrYEyR2ywmFkgHSCfY5hi3Xzw0XyENxyRkL
	h5O5u5KChW3gaLG2WDbVYY1ZmfpAYFI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-FIV1QRUNO2qJJ0JcbY90rg-1; Mon, 16 Dec 2024 10:34:24 -0500
X-MC-Unique: FIV1QRUNO2qJJ0JcbY90rg-1
X-Mimecast-MFC-AGG-ID: FIV1QRUNO2qJJ0JcbY90rg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385f0829430so2948872f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734363263; x=1734968063;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EoXThDuzdwSCkju3MJU1hPpxlhHdcR6+6fSsTLqkgM0=;
        b=R5sDcoh8q51iAIQlzX/tIdaD7Vrc1lzL3Kn5r6Ua2062iqA1WWnxsKVtyl4ECMFrgh
         +33lk0RdHFcv0b48Xhtx6CLQNDfF/bgrb0CvIlfFtL9cAnmlKM/nEkCTZN4XQMMTd10o
         xhptAjOcX+QvERRKCSI7h4DED03/UpMitOXg+fCLPbFdqjYBABcXLGTUJtee1CMHJh9C
         NmLtIoauY+LcmHRaj/AbeNfvYayW/rWhwD53emZHRI0T8SYoZm5G1cycdji/QPMY2+dn
         EBvqNIQlaNpNXNwCnO+GZ4+NJrBPkBD5WEx7i7Sjpo7RffKXBGU/A0/pFWFkfVNjs2ZL
         yNyA==
X-Forwarded-Encrypted: i=1; AJvYcCVy+cSFXHJZ8hR7OXtnQDBVoLNd/aYneXyr85rUDjt/Q4QFiWoLlJEPYVFkLqHEEhuTNxEOkH5/PKENKfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKseyW+SatXXwm0ilgyNlZnpj/WjJDxPsiIbP7X2l8qNjwfFAp
	TTq0IJNdNwjs5blttYDxcpvTyHnyTYmWgOl+hxPPZB/xH5TTYm6TDgft55fDSYEEFB4E91H9CKz
	FU0zXDaIjJRlf1sV4sEo7stIdhlneLv8ad2AoKE5pMDnnINslPoJlmsaw7ZKixA==
X-Gm-Gg: ASbGncsxP5TWqCvdhfErTu9fSVD/JDmc9/MrnPMYv5QZ+qkums/y2W3+18CDrjVlFWT
	+GO6FlJcoDt5DKRfxBJFG1gg6uMoBEJ52NiqeRLP3UQQtwCkGPSvV4d+jUpRZNcm90PxVKzZDds
	K6oWG0yPICGjUf02ch4b74TBKjZE4nbyRXaOlzSJvzWbP36MiNdsapzM3EiLmorR2hWNaujNfHp
	v8vQprjtgYjGUzIBNlbOBE/PBdF0JhHOZr698SLHUbbfC9IiBRh6iB0tDu3FBn3tZyHwo1yK9Jb
	Yu3xLX/wsUywOVEzBfnbjeaUmxOf/67ATKwSN6i68AISIU+YyddVEi8AnpKtFRsGr9XVYyeE0AJ
	IQ/wQ7viX
X-Received: by 2002:a5d:598e:0:b0:385:ebaf:3824 with SMTP id ffacd0b85a97d-38880ae148fmr12994364f8f.27.1734363263589;
        Mon, 16 Dec 2024 07:34:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzxyqAPYCNK4zV8bCzmuyObuMX2QNbxU0jtpmqKD4rttBfJUzSfWVcLwa4zTdhiE5xVDgKog==
X-Received: by 2002:a5d:598e:0:b0:385:ebaf:3824 with SMTP id ffacd0b85a97d-38880ae148fmr12994330f8f.27.1734363263195;
        Mon, 16 Dec 2024 07:34:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:f600:c577:b537:f52a:b994? (p200300cbc72af600c577b537f52ab994.dip0.t-ipconnect.de. [2003:cb:c72a:f600:c577:b537:f52a:b994])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8015f77sm8388163f8f.26.2024.12.16.07.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 07:34:22 -0800 (PST)
Message-ID: <8e59d2bd-77d3-41bc-83b7-532b018db4e2@redhat.com>
Date: Mon, 16 Dec 2024 16:34:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: independent PMD page table shared count
To: Liu Shixin <liushixin2@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 Kenneth W Chen <kenneth.w.chen@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Nanyong Sun <sunnanyong@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241214104401.1052550-1-liushixin2@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241214104401.1052550-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.12.24 11:44, Liu Shixin wrote:
> The folio refcount may be increased unexpectly through try_get_folio() by
> caller such as split_huge_pages. In huge_pmd_unshare(), we use refcount to
> check whether a pmd page table is shared. The check is incorrect if the
> refcount is increased by the above caller, and this can cause the page
> table leaked:

Are you sure it is "leaked" ?

I assume what happens is that we end up freeing a page table without 
calling its constructor. That's why page freeing code complains about 
"nonzero mapcount" (overlayed by something else).

 > >   BUG: Bad page state in process sh  pfn:109324
>   page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x66 pfn:0x109324
>   flags: 0x17ffff800000000(node=0|zone=2|lastcpupid=0xfffff)
>   page_type: f2(table)
>   raw: 017ffff800000000 0000000000000000 0000000000000000 0000000000000000
>   raw: 0000000000000066 0000000000000000 00000000f2000000 0000000000000000
>   page dumped because: nonzero mapcount
>   ...
>   CPU: 31 UID: 0 PID: 7515 Comm: sh Kdump: loaded Tainted: G    B              6.13.0-rc2master+ #7
>   Tainted: [B]=BAD_PAGE
>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>   Call trace:
>    show_stack+0x20/0x38 (C)
>    dump_stack_lvl+0x80/0xf8
>    dump_stack+0x18/0x28
>    bad_page+0x8c/0x130
>    free_page_is_bad_report+0xa4/0xb0
>    free_unref_page+0x3cc/0x620
>    __folio_put+0xf4/0x158
>    split_huge_pages_all+0x1e0/0x3e8
>    split_huge_pages_write+0x25c/0x2d8
>    full_proxy_write+0x64/0xd8
>    vfs_write+0xcc/0x280
>    ksys_write+0x70/0x110
>    __arm64_sys_write+0x24/0x38
>    invoke_syscall+0x50/0x120
>    el0_svc_common.constprop.0+0xc8/0xf0
>    do_el0_svc+0x24/0x38
>    el0_svc+0x34/0x128
>    el0t_64_sync_handler+0xc8/0xd0
>    el0t_64_sync+0x190/0x198
> 
> The issue may be triggered by damon, offline_page, page_idle etc. which
> will increase the refcount of page table.

Right, many do have a racy folio_test_lru() check in there, that 
prevents "most of the harm", but not all of them.


-- 
Cheers,

David / dhildenb


