Return-Path: <linux-kernel+bounces-201725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7511C8FC23A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1121F24C87
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0F912F398;
	Wed,  5 Jun 2024 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToYbNrSK"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4AD7FBDD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 03:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717558710; cv=none; b=RVIrG/GYtZSSyG7hRiS4NERKATvz+xOJGmbtvZ5Is+qhVaYHdige7UnWUdxQQkEis+8EyGhbo45As3JwJCdKudckGCl2XJ/BxNmwpoLmXy+Q05e+EX76Kho6ktmumsLK0EXbIzX4B/zrvY7eK/AoDbxf69ercPSkkfl8RzqHhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717558710; c=relaxed/simple;
	bh=GXmH7h/CvLPfbz9Wijg4MOGyroKxU9CO2Byg4as+XIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H9245ORwxYtB72r0wgKbshli//1eBhaLpY7OqpPQyQau2+frmr+nnyEtZFLZE42/Hs7iWtD7U/GsjcpxJOy17Uv9KzKPIKi5Kf1vj2CQ/+vd5g7J91Gn7aomOs/MHGOJYEmh2mzrvHDYDNZxNTeZ7WLA5k7Ti+Y/DVgN5jVTol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToYbNrSK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7025cb09553so3219998b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 20:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717558708; x=1718163508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TZJWN0smhjRNeWSpuAHgy5nc7GxTC32AmAdm6f2hCDU=;
        b=ToYbNrSKthJpsfJf8BTOCHrK4ZVnQRBg8kcKjnGgKt925M/DhLSg3Mmqhom2nPLSm6
         oLf294/QJvqTxkpX+DsdeFMqZU5rgHazxlVEtxiP7NdG4qyZc27JR2DZEweCmGwGwjim
         QIlirNTpytX1vww7E8fPWbusBReSQMYljS/M4uaC1T9ZzmBozh5zZQIpUSwkSCWM6LT6
         F9sq/EPnCxwPOnT0TO+4xT51rtR3W7rrQbc2QsXiy9j9HiqjuBosFMTosGqQ6CA/7Hpe
         yFU920wnQfdX2twEbPEnikZDu9XxT0Hx3tdYItP9lWJJBs5yeBaBQPceLxmHWSbjwi3s
         sVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717558708; x=1718163508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZJWN0smhjRNeWSpuAHgy5nc7GxTC32AmAdm6f2hCDU=;
        b=LMvTBNFKCljqOSXBS6d4Ibk2zahYIqZYBr4XcBHYDDTCC65KCcWPFE0I0izOoXNAH4
         nnLnuZVCi63WvySBC39SGzlJeXEeKrCRfj93XuepR4jplaHaEkODo2h73bDgIcHU7kiy
         IeJX3Mo4ercYXPwnPD/EdTQATsrRLXpAOKMgZREP9FHXjabq6/OH9d9MMWr6fFGyz4Zs
         F32J3OANifIFuszLqQFUR3PVz1YS5vQhucG/vrt7W5BhUZpykbkvqeiptwQpF+iJMSBn
         XtaOdFC9P+QnCPn6vUzt896/7ZpexEQK+MKb57qsp9AxEbtpkS93ew9wfGM6LmZfNrfo
         8IpA==
X-Forwarded-Encrypted: i=1; AJvYcCWLmrMwU3pmbnd5dQk2ywwwxLJ28IKr8I8W8BIY8nV4cHCNdt+Yq5Fyd59igvBnSzGx9UP3cIM43ekw2o4sVMoXNp0sEMcv3rNuxHTK
X-Gm-Message-State: AOJu0Yyg2cLNehixfQjYw1HOTyVkW9CzoBHn/reoA/2If+9cqkM6UJiL
	TTkdLVTxJzsBV3slAUZVPQurW3f1TIPkS+qRiIFMti9rrOSrv1he
X-Google-Smtp-Source: AGHT+IE/K7PUQN0+2GuH78A9OaL1X52lZ9RDIPiqK9s7h30ASVtxZlhXaTt6pz6Elx5JHJbtfPQYeQ==
X-Received: by 2002:a05:6a00:1d11:b0:703:ee63:3be6 with SMTP id d2e1a72fcca58-703ee633e1fmr370122b3a.15.1717558708242;
        Tue, 04 Jun 2024 20:38:28 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70244486e5bsm7481124b3a.62.2024.06.04.20.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 20:38:27 -0700 (PDT)
Message-ID: <2b2e209d-863a-4c21-b7a5-2d328866cd0e@gmail.com>
Date: Wed, 5 Jun 2024 11:38:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] mm/ksm: use folio in try_to_merge_one_page
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-4-alexs@kernel.org>
 <8a4d048c-0764-442a-aa70-48518068f163@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <8a4d048c-0764-442a-aa70-48518068f163@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/24 4:19 PM, David Hildenbrand wrote:
>>
>> @@ -1489,11 +1494,11 @@ static int try_to_merge_one_page(struct vm_area_struct *vma, struct page *page,
>>        * prefer to continue scanning and merging different pages,
>>        * then come back to this page when it is unlocked.
>>        */
>> -    if (!trylock_page(page))
>> +    if (!folio_trylock(folio))
>>           goto out;
>>   -    if (PageTransCompound(page)) {
>> -        if (split_huge_page(page))
>> +    if (folio_test_large(folio)) {
>> +        if (split_folio(folio))
>>               goto out_unlock;
>>       }
> 
> Careful: there is a subtle change:
> 
> In the old code, after split_huge_page() succeeded, you would have a ref on *page* that you have to drop.
> 
> Now, you would have a ref on *folio* -- IOW the head page that calling code has to drop.
> 
> Is that handled accordingly? IOW, is there no code that would assume it would drop the reference on the *page* instead of on the *folio* (that, after split succeeds, would be an order-0 folio)
> 
> If so, worth spelling out in the description (you say "So in the calling path to try_to_merge_one_page() parameter pages are actually folios", but I am not sure if that means that all page refcounting code was changed to folio refcounting code).

Hi David,

Thanks a lot for comments. Yes, the ref on folio was handled. I will mention it again in commit log.
The 2nd patch in this series would just pass folios into next step, tail page will be warned, so the ref on 'page' here is also the ref on folio. they are same.


Thanks
Alex

