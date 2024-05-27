Return-Path: <linux-kernel+bounces-190664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38268D011A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9275BB22678
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E1315ECC4;
	Mon, 27 May 2024 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="em4U63Rw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0315DBC1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815829; cv=none; b=JACA6mz+wNmh6wV5ah6f016sEiIOD0V8slEuf0ByF11cMAG1NNwkx7o59f2MDRLh5/RNlBaijs9pvOJBb3gZasTZEMZDMBBBDCtcMlpRwuBJFQQKaaOoij/Y1Zmx932j3hf5RGabPsv+Q88naVPlF3WtSqqW/KE6dk0qkJZoNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815829; c=relaxed/simple;
	bh=qdtjn5vrchoRbpzSHmY5cJaAFqPrjbw9md0ZVHESuXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2dzl2PHkZ8gdDv1PG+n2nqZcmsybXY7/rXikKNVwIRCWZWK/u6FKYwH3Tx0dOHJNAL/g3zjEiGs91c8bhEWQT9qo+8vJYUybkT1GN1N9Quc8JQ/EsQOawp9b0ft6CySRmcRmkRT6YbvzvtdeGHOCb7qmEiMKCoZ2FUVCDHeHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=em4U63Rw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716815826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7eJCdNZH23iGsZcnTIJKyHculmMVAYthSm3YomlEuEQ=;
	b=em4U63RwnNBiJSOfdzJ9An/RiZlE6zdoZH81lnUYsdmBsgkqbKbP2YK7kGjXuZuwQxxHaU
	3RjLx8PNZcfnNVM2wqPbX74o5lnLXnrUTsZSO2o1b0X89xZNicd/LPDzFc5cEVjLRzakvv
	iHX/BdHee82VXNRv+O4HCdPXbPDIbq8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-dqcr9p4fMau_cg2RBIR11Q-1; Mon, 27 May 2024 09:17:05 -0400
X-MC-Unique: dqcr9p4fMau_cg2RBIR11Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e95a73bf3cso23809331fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815824; x=1717420624;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eJCdNZH23iGsZcnTIJKyHculmMVAYthSm3YomlEuEQ=;
        b=HL3y+dDH3N8Oq5X8VhoQQsuITYj8dzYkWqnN1duibIIghkS+sqSr6wAEzxI85j9+qm
         bzSpkLOLSCiMP6VKpMz/lprpWDJkfkPhnHEt8/JE6nSlWu0Bd76eNU0HYRlFm3zuEKEU
         TSqD2HXxSj5d1IY3PLfvIf8AsGFnpa57hy01FShRzcDm11bZ8mahdrbJuy1v3bSXz2Jq
         O/gs8xSEaGO2PUKv6Gfi17q9++ruLMDt9NYFkySfkxqsuOAUSZmblsMrsExxxp8fb47a
         lTz9fZXFD7v/NDGaZnASePd2uEkgqTgfCwe8rHcT7cN+7sL3V2JoAEkUjRlOIjLVhyCu
         yM1g==
X-Gm-Message-State: AOJu0YwKuvIef/QWTwI+dIfmJExwAVlPJqWsV33PgYn7rGUPLQXBzJF8
	WnaVk6plM3W09kTdRurourCMTrhGui3RRTs9yFr8WZTXY7zgo8adOGaYaGglVMTzq0UXq/bh9Ic
	DQYf0q0JzaG1vO5oDcKJnrDVXO8PNp8YVdq+oB1t+2UnjUxBohho707Xf21OlZpPEORy1zw==
X-Received: by 2002:a2e:800f:0:b0:2e9:6306:8a51 with SMTP id 38308e7fff4ca-2e963069082mr46931311fa.52.1716815823862;
        Mon, 27 May 2024 06:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAdFUxvJtf0vCKY+jk148WLl1l1WfDNRCo/OQEaOcdyFS1x8dgg1tRi6TCbi3OUpnFEgKC5A==
X-Received: by 2002:a2e:800f:0:b0:2e9:6306:8a51 with SMTP id 38308e7fff4ca-2e963069082mr46931071fa.52.1716815823363;
        Mon, 27 May 2024 06:17:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1399asm141833865e9.11.2024.05.27.06.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 06:17:02 -0700 (PDT)
Message-ID: <9f3371fa-0d46-4e93-a00b-0f5cb30b58bb@redhat.com>
Date: Mon, 27 May 2024 15:17:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: Move vmf_anon_prepare upfront in hugetlb_wp
To: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, Vishal Moola <vishal.moola@gmail.com>
References: <20240521073446.23185-1-osalvador@suse.de>
 <ZlRKI_tJ2CYhmekw@localhost.localdomain>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <ZlRKI_tJ2CYhmekw@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 27.05.24 um 10:53 schrieb Oscar Salvador:
> On Tue, May 21, 2024 at 09:34:46AM +0200, Oscar Salvador wrote:
>> I did not hit this bug, I just spotted this because I was looking at hugetlb_wp
>> for some other reason. And I did not want to get creative to see if I could
>> trigger this so I could get a backtrace.
>> My assumption is that we could trigger this if 1) this was a shared mapping,
>> so no anon_vma and 2) we call in GUP code with FOLL_WRITE, which would cause
>> the FLAG_UNSHARE to be passed, so we will end up in hugetlb_wp().
> 
> So I checked this again and I have to confess I am bit confused.
> 
> hugetlb_wp() can be called from either hugetlb_fault() or hugetlb_no_page().
> 
> hugetlb_fault()->hugetlb_wp() upon FAULT_FLAG_{WRITE,UNSHARE}
> hugetlb_no_page->hugetlb_wp()-> upon FAULT_FLAG_WRITE && !VM_SHARED
> 
> hugetlb_no_page()->vmf_anon_prepare() upon !VM_SHARED, which means that VM_SHARED
> mappings do not have vma->anon_vma, while others do.
> 
> hugetlb_wp() will call set_huge_ptep_writable() right away and return if it sees
> that the mapping is shared.
> So the only other we have to end up in hugetlb_wp() is via FAULT_FLAG_UNSHARE.
> For that to happen gup_must_unshare() must return true, which means the following
> assumptions must hold.
> 
> - For Anonymous pages:
>    1) !PageAnonExclusive
> - For Filebacked pages:
>    2) We do not have a vma
>    3) It is a COW mapping
> 
> 1) If gup_must_unshare() returns true for Anonymous pages because the page is not
>     exclusive and must be unshared, hugetlb_wp() will already see the
>     vma->anon_prepare being initialized because of the previous
>     hugetlb_no_page()->vmf_anon_prepare.
> 
> 2) I do not quite understand this case.

gup_must_unshare() without a VMA is only used for GUP-fast. Before triggering a 
page fault we always fallback to GUP-slow first, where we have a VMA.

IMHO we better not make assumptions that hugetlb_wp() will always already have 
an anon VMA.

-- 
Thanks,

David / dhildenb


