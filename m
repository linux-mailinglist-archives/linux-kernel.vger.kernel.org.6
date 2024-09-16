Return-Path: <linux-kernel+bounces-330258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E033979BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23D51F21156
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB7712CDBF;
	Mon, 16 Sep 2024 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CBOF6u2F"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC553C482
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469989; cv=none; b=avXVbS8Jjqstw0hnzaRsfTyyrSUmorY/EDbTGEOdPWOK5egoTE98bJv5gWOEiHm0j9F9Kkim9O8ff7cpeUeO1sgSrgxlgOLrGJ4DmHi3/JlXt2kFqiacR2irhE+MB0t4TNSCvzEEdkErB+2ooV5AIuDYxXkdFdTS97BQMbOlM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469989; c=relaxed/simple;
	bh=BRlg6KteMpFfEGHsJSzVG3Wg8eNHikDPuQFuLb5FRIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHT7whZ6qJ14KQ69apiRHcTJfgzh4ebkRSRrHECFIfBN/4E1K7Li+XJF6VK3AtKACd0I8Ljwmga5EdbaEwMQTi6AsEjBRSQy7DmBMfYIxSzoo4yHbuyy50P9NfBFxw5Gm5HXpMkX9k4tXjQ0uIyMvkH1XAMHw3P/08BZKDhNoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CBOF6u2F; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso675192466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 23:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726469986; x=1727074786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hoxc2xLo27czaSJSdH1lZge3rHpm9JVblpGZxZKH8tM=;
        b=CBOF6u2Fybscrpiq0KWGaj0yAVrdlJSWhOdaIeOOSSTcun7wajNISvVXyMZLhxKs/M
         e0P8evC7jPLJpDjvZ1QoHR7V9BRcVpyZr13VdbyPIDIqd43NF5H19e+onzIJeTcGWDer
         XU6ugSX+oq1zE+4HpTbj4xUF44XA9EgCnJ1LAQdBtNvtCyQzfxOiv4ufgaoie/Cdx0cv
         BscloiPlh/sL5kP90sILjC/LpZqZq+9+sC8SqBQIAIOQEqBPIE2zFcEnZj/VD4IwDTLQ
         wA4pWoPzuvwADPfyhsl5nEIptc4AzpN0tjD6mTmB13vV/8ytcoEprDn5b6TkF/gyTot9
         OGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726469986; x=1727074786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hoxc2xLo27czaSJSdH1lZge3rHpm9JVblpGZxZKH8tM=;
        b=Jd/QroZyS1ZIwUlYcvsWOPinupWRfne5Bf8USQ2YBiIFi+8JNLrJFMGej8NJL3qEKd
         EXkB0iKV5hbPvLhchhpxeyJaP9RBkJyqjLv78a2NrX2HrLkEqCsLmIHVzL590mmr7Uzm
         JeQz89k5YvNBloYnsPsxLdxy33S3qQW5JMQQydcsAw1tFI/0kxBLdPXEdGjXPJttftXZ
         rSJ5Bv7NDVkIGXmUoz7jaEOfPrFqtrByxrWllh/hySuZB9Ji7FPOVTZ05qGQd2xDzIwT
         95rmOxV06/SHTIQN0I0vmHO236KQRPhzkJoAlyyGZhfGQd6drU2jRRvYgrrI6cNxFkBZ
         WApQ==
X-Forwarded-Encrypted: i=1; AJvYcCViHCMRia2wNUauaBpSNHn5XWLrg3MZ9w56Y7tGM82y9EHWJfspflbiBh8iDdPhY5EjfzeSDaY2xSG1euM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf5nkgmlzpgDhlDc37yncYvFs6RrcIMgxSPdHn3mgKDWB0UxJN
	EE0qOl9+fOBuTH0V2T8qzN+WrJkSJujFEC0d5k80wAIRk9ibQuj2aH7wa6RTUg==
X-Google-Smtp-Source: AGHT+IGEE+x4myqxVpsG+4wlTw+uLRt/VgS3sL49Fo+T3MUgbxgZNUqjr+4TTGSrsMaNaZ7JrXeu3w==
X-Received: by 2002:a17:907:d3cf:b0:a86:8285:24a0 with SMTP id a640c23a62f3a-a9029434c42mr1485582266b.23.1726469985553;
        Sun, 15 Sep 2024 23:59:45 -0700 (PDT)
Received: from [172.31.47.100] ([193.118.249.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4375sm272050366b.73.2024.09.15.23.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 23:59:45 -0700 (PDT)
Message-ID: <c97450a0-6ddd-49c5-a8e4-0cd2cf9d1635@suse.com>
Date: Mon, 16 Sep 2024 08:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] xen/swiotlb: add alignment check for dma buffers
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240916064748.18071-1-jgross@suse.com>
 <20240916064748.18071-2-jgross@suse.com>
 <d23c9af4-4a79-4300-891a-fba3ea9cbb1c@suse.com>
 <c2dd89b4-46c7-4a0a-a47b-70862294176b@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <c2dd89b4-46c7-4a0a-a47b-70862294176b@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.09.2024 08:56, Juergen Gross wrote:
> On 16.09.24 08:50, Jan Beulich wrote:
>> On 16.09.2024 08:47, Juergen Gross wrote:
>>> --- a/drivers/xen/swiotlb-xen.c
>>> +++ b/drivers/xen/swiotlb-xen.c
>>> @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>>>   {
>>>   	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>>>   	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
>>> +	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
>>>   
>>>   	next_bfn = pfn_to_bfn(xen_pfn);
>>>   
>>> +	/* If buffer is physically aligned, ensure DMA alignment. */
>>> +	if (IS_ALIGNED(p, algn) &&
>>> +	    !IS_ALIGNED(next_bfn << XEN_PAGE_SHIFT, algn))
>>
>> And this shift is not at risk of losing bits on Arm LPAE?
> 
> For alignment check this just doesn't matter (assuming XEN_PAGE_SIZE is
> smaller than 4G).

Oh, yes - of course. A (hypothetical?) strict no-overflow checking
mode of the kernel may take issue though, so maybe better to right-
shift "algn"?

Jan

