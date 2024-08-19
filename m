Return-Path: <linux-kernel+bounces-291355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC03C956125
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88837281815
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6516324B34;
	Mon, 19 Aug 2024 02:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS90XxLM"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A821BC3F;
	Mon, 19 Aug 2024 02:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035091; cv=none; b=QXnGL2sPcFLOBwdX9UGid8Km66yqOszOUP1IzoJHecYVqK4iDNZvLqOdas044KEce4HedoiRt2LOkGhtG7bH5dwm63yrMopC7fZLmyXvq8jRWDfRb2ZF2si31xcJl8nrVEH59j6KjV8C4uchctHvX37SgyUUvCLNzS8Jr9kGfec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035091; c=relaxed/simple;
	bh=APWAWLqHGv+8k2O/zcUZPsdwye7ZKJK8e2KlRnavtiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXFZGjaf6jHIy7qycINYe1OPe+X9wcOSmvelIjHHbyj9KEcxWTXbGGzdSHu90+Qg2h05+JZ1J4/EjCBXX8N4Pt1LaryuK1qgG3GVNopIq4JIXd5/cAU8nkdv2wAxVyiQ5LJ2p0psgo72OItIO7OXFQx+eIJUT+SRTE/ujEmDpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS90XxLM; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a4df9dc885so282271085a.0;
        Sun, 18 Aug 2024 19:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724035089; x=1724639889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mI0z4qbYhXzeJGZNJKFvenZKA1XOL8A95IrbXV4PtLM=;
        b=QS90XxLMzpw6sMUdcjsN9gjNtUaZt9GCNaEe5oBWvHOCF3Pzkt5gd9IBH8y7iU2hiO
         nDK+zw4wQWa9mqhyopdGxtQxatql4vgLUON38vKMNepByncyA4/aF8tVghRKH9ugBa6Y
         c4FNo/6x+2JrQ4eD7cpvy82O5JgnEoGIQE+4VZgOZpNU0hsJHFTbyUK4bU9cbhWZ478A
         y9RtZfRltm+xikiaAwtOMU/yg2AVwpRNzIFHG//0/UXT9XQxGq2MtktQOxLuy7AgxjbU
         GWlVH0qPT7W3X66pNb6xj4ZbFyU7mivdRJB+clo8jE93F6jfPmkDhkaYiLk8mWBaJ+nV
         UV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724035089; x=1724639889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mI0z4qbYhXzeJGZNJKFvenZKA1XOL8A95IrbXV4PtLM=;
        b=etkvJcrAgelf85IZIIpxB7+DxBsX9tT3IFfuYNXKITdUryfId0hjUmNwk0WqiY6ar2
         soWvuLZqtqaBY1Ry5W6X6KRAt/qkq4wUPAC2vOzw64/Xefor5DklYzkl8KN8eIrYot4n
         spKQSGw7c/TZYhZObuOGK1gTcBY2zcZmDCH+nn6BZBQvqlrnopL9DbE0MpWXflJ2ajxk
         0IxCRdRBlnArzGS5uAbiDrtMgUGiJYecSQo8rFePVmyNesxprN7cBKRSy53moCpTwiy0
         1u/SdOvRhpNtjzs/VFRiO3YRUzj8VeIKupRfBSzdhVRtfQUdPVJ5LoOqOmX/QX+yjoOL
         oFog==
X-Forwarded-Encrypted: i=1; AJvYcCWAa0VpozoulsGxu1k01gbFihx439ykH56HOD00ZXSirPxHLVSZukKz4o+uyAoGkeqBb4l+7K9HZhquNaR12JjA4Jgsz/ZGt+6DKpfM9/hMA7mUHvc4TjQNsumpVMQEJpgY1H9P20uy
X-Gm-Message-State: AOJu0Yzh9yRBKG+B4A8H173QWNgc3FJ/LPbeDVGHScvyY54/jsiFTPOS
	NJv3fkJ5P3IIC+aDeYdpap6+nsqL2mZAjw5bI9fFHDGadwBRkgh+
X-Google-Smtp-Source: AGHT+IFZ49myeyGjxznVH4Zu0OvbTU5lWVEtVJuZ1O+hjGUExG8VO6LdaznL6XBwEaQJU6VLBIrF4g==
X-Received: by 2002:a05:620a:4013:b0:79f:72f:2c60 with SMTP id af79cd13be357-7a50752170bmr1480619885a.26.1724035089090;
        Sun, 18 Aug 2024 19:38:09 -0700 (PDT)
Received: from [172.20.6.203] ([64.20.177.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02b0c2sm396204985a.22.2024.08.18.19.38.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 19:38:08 -0700 (PDT)
Message-ID: <3938ed07-9473-4210-be44-74e518fd31c6@gmail.com>
Date: Sun, 18 Aug 2024 22:38:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] mm: split underutilized THPs
To: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, roman.gushchin@linux.dev,
 yuzhao@google.com, baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, ryncsn@gmail.com, ak@linux.intel.com,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
 <1e6f3b38-d309-e63f-bca0-5093e152f7d7@google.com>
 <19b1c8e2-f60e-460d-8249-5db71a708dc9@redhat.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <19b1c8e2-f60e-460d-8249-5db71a708dc9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/08/2024 08:45, David Hildenbrand wrote:
> Hi Hugh,
> 
>> 2. I don't understand why there needs to be a new PG_partially_mapped
>> flag, with all its attendant sets and tests and clears all over.  Why
>> can't deferred_split_scan() detect that case for itself, using the
>> criteria from __folio_remove_rmap()? I see folio->_nr_pages_mapped
>> is commented "Do not use outside of rmap and debug code", and
>> folio_nr_pages_mapped() is currently only used from mm/debug.c; but
>> using the info already maintained is preferable to adding a PG_flag
>> (and perhaps more efficient - skips splitting when _nr_pages_mapped
>> already fell to 0 and folio will soon be freed).
> 
> No new users of _nr_pages_mapped if easily/cleanly avoidable, please.
> 
> I'm currently cleaning up the final patches that introduce a new kernel config where we will stop maintaining the page->_mapcount for large folios (and consequently have to stop maintaining folio->_nr_pages_mapped).
> 
> That's the main reasons for the comment -- at one point in my life I want to be done with that project ;) .
> 
> folio->_nr_pages_mapped will still exist and be maintained without the new kernel config enabled. But in the new one, once we'll detect a partial mapping we'll have to flag the folio -- for example as done in this series.
> 
> Having two ways of handling that, depending on the kernel config, will not make the code any better.
> 
> But I agree that we should look into minimizing the usage of any new such flag: I'd have thought we only have to set the flag once, once we detect a partial mapping ... still have to review that patch more thoroughly.

Yes, the flag is set only once, in deferred_split_folio once we detect a partial mapping.

