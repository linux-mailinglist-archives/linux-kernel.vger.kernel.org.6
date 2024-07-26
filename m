Return-Path: <linux-kernel+bounces-263398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E83B93D54E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5198E1C23C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AB317BA6;
	Fri, 26 Jul 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq/TUqeq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD286FB6
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005161; cv=none; b=Byrf+ZdcpSBoAy7yB8jUbxh+u/wBtLoUJVRMI1tgyKr9YKsXB/82hoc3GUsqZSJSdGOuxvYG4sJ8TpU93unX4lpD+B1wd75g1wKL8uvF4H0Uua8EPMpMBjRsGGrLCa5Z4Fm/Cm5A1VJfcOAAdrnEXxLHm94ajCShjcnLDid3hKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005161; c=relaxed/simple;
	bh=byvsh2Z0nGWbteBytc1lUsqYrSxmpQxuM4E1aK5utuo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KVft8hlsDJxfA16CL+MyPFcg7Di8ptpKxXM7zR915yAMKtxhUF6VJhPoou9PzmfY6152Z1+sE0Q0DN/gzSebf3MF+ezdhhM5DnIl7D4rXqYNSFtBZUTOUT5da4EyNRuWhIC+4mP5w3PQOUjSLH0UXtt4x4DzLNesC6tHdKVYdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cq/TUqeq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722005158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JYTUGDCfTZNE/l3lPsvI7+Ma8ppBanJPr1boNuvZBmI=;
	b=Cq/TUqeqpHU5tV84MALJZyv3P7w7GPND+7Yu8ZDjNl121ajmuCPpn73cDTLlitG4a29rMP
	V5SACsFeU3QTZmRBtdMzwfxy89SpXaQMRYe+C3agw9om5/L7DW7XOB5E9fNJxU+piuJFuE
	fTY0vZd4XG0tPA2To6xpfVeWv2nvZfg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-Nn2lYeTNMUCsKZCtlq57xA-1; Fri, 26 Jul 2024 10:45:57 -0400
X-MC-Unique: Nn2lYeTNMUCsKZCtlq57xA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3687a1a6846so1183866f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722005156; x=1722609956;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JYTUGDCfTZNE/l3lPsvI7+Ma8ppBanJPr1boNuvZBmI=;
        b=YjZRAdnAsgi6dY07T34IrDTW93r8Sm5m/R+j2jutaiKYH3TzxT6CtKOkYy98HNUU+C
         iHsgSI6SFtTQ8xr8RSYJ/+1gRoOvyOfTbxFg+HwypRfgNrS1WypmxBNuAijk/nPwDpGt
         sCU6wxezYmQ20FCW0rXG1kyFm5+KS1Eiqp/ldD34iaXwkcLWgo0f5dmweQlSRVxHTb9M
         cx7L767/qtF/yvk7ASl0AQwAfjjlROEvgEwGGPvswc5UDyR9oLfP5/ehNY/uHIO/ZuQS
         wKYd/7FVcvdWhF3k13+SRiLt5QKOpfidyWkxlUocyQQyDu2GaMdTQT4jwGqSkdX+oq5q
         ld4w==
X-Gm-Message-State: AOJu0Yyu9fV8xXmtJXDU0R2MMltVOuMh87CvTK21DNoK62V15Wqxdt0A
	fQAOyFpzaRseSO/tGqzvy6nyObMgrc8BBbvso8nVZnXvC5NN/Qo8mm8fD+Ba1ipzBQFR7FP+ntp
	2MyY5ZIVHzbmZXqPqGYGc9WWU/TXtx/HRYdByj6zIwYW77Zgvt7uQOoE8RkwdWg==
X-Received: by 2002:a5d:49c2:0:b0:367:83e9:b4a5 with SMTP id ffacd0b85a97d-36b31a79ff7mr4100499f8f.49.1722005155815;
        Fri, 26 Jul 2024 07:45:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhezjviW41dh3V5Qq+AOstwGWnEQSINQFbO25+t0TgirVWiiVljW2qh4OfNvFlWfd95I5XeA==
X-Received: by 2002:a5d:49c2:0:b0:367:83e9:b4a5 with SMTP id ffacd0b85a97d-36b31a79ff7mr4100477f8f.49.1722005155261;
        Fri, 26 Jul 2024 07:45:55 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:a600:7ca0:23b3:d48a:97c7? (p200300cbc713a6007ca023b3d48a97c7.dip0.t-ipconnect.de. [2003:cb:c713:a600:7ca0:23b3:d48a:97c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d989asm5339437f8f.29.2024.07.26.07.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 07:45:54 -0700 (PDT)
Message-ID: <2ae8be1f-7b07-4967-b40c-2e4a85080639@redhat.com>
Date: Fri, 26 Jul 2024 16:45:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
From: David Hildenbrand <david@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725134129.fc9165ac6413c4f774b786c1@linux-foundation.org>
 <7d88ac63-46b9-4b2e-a46b-c78d8d1d9f0e@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7d88ac63-46b9-4b2e-a46b-c78d8d1d9f0e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.07.24 11:19, David Hildenbrand wrote:
> On 25.07.24 22:41, Andrew Morton wrote:
>> On Thu, 25 Jul 2024 20:39:53 +0200 David Hildenbrand <david@redhat.com> wrote:
>>
>>> Working on another generic page table walker that tries to avoid
>>> special-casing hugetlb, I found a page table locking issue with hugetlb
>>> folios that are not mapped using a single PMD/PUD.
>>>
>>> For some hugetlb folio sizes, GUP will take different page table locks
>>> when walking the page tables than hugetlb when modifying the page tables.
>>>
>>> I did not actually try reproducing an issue, but looking at
>>> follow_pmd_mask() where we might be rereading a PMD value multiple times
>>> it's rather clear that concurrent modifications are rather unpleasant.
>>>
>>> In follow_page_pte() we might be better in that regard -- ptep_get() does
>>> a READ_ONCE() -- but who knows what else could happen concurrently in
>>> some weird corner cases (e.g., hugetlb folio getting unmapped and freed).
>>>
>>> Did some basic sanity testing with various hugetlb sizes on x86-64 and
>>> arm64. Maybe I'll find some time to actually write a simple reproducer in
>>> the common weeks, so this wouldn't have to be all-theoretical for now.
>>
>> When can we be confident that this change is merge-worthy?
> 
> I'm convinced that it is the right thing to do, but I don't think we
> have to rush this.
> 
> As Baolin notes, we fixed the same issue in the past, unfortunately also
> without a reproducer IIUC, so I'll try to reproduce the race, but I'm
> not 100% sure if I'll manage to do so..

Okay, so running this series against the reproducer I pulled out of my 
magic hat, this series seems to properly fix it.

-- 
Cheers,

David / dhildenb


