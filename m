Return-Path: <linux-kernel+bounces-200421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C506B8FAFD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C65E283FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB1B1448E2;
	Tue,  4 Jun 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+2csRV+"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43F13247D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496777; cv=none; b=V7qAsDOSCT35T3eJuJgEfNxPqdum8C2fhbY+YE+R89tkBmhKfnpWVIjhfOiB0C3KqIL9qhAU4gob2YAXNEeCVSWd0KDxVk4XzTJ53ncTC0VBjxkOFxUtv756EuXISzHj9CNBEdiLZ1MjiH+KnJ4UglnHbXaL+BrXGNKwEvdFikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496777; c=relaxed/simple;
	bh=DIY33CopAP5GyxacNZNlb7tIeuoRVph+VanjPJ4u+wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=daOTeFJ0usvQR1lySUhQ1WI7S3GoH5f5uTStbnP04jZOv/GKL+pIu365e1nvhW3voOeqybQFHsBAiWvU4I0uIUZ6zn1pX/I02ZsSJ+rvkCImF5C9ZJUTgQUpaaKkVLptEEYD10H3FQqh12tnl024CBwXHnfHNyIqVTGDTYkmJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+2csRV+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f64ecb1766so8009585ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717496775; x=1718101575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yo00xf5gWSvOoL/K1nBFKHV2CgNWuJjUCsHHkqwt6Ps=;
        b=h+2csRV+G2/iz6qRmo8y+mRRkyE00KbDxP/thIrz0uFWKDfi82LaLpfy2UF4zteuql
         6LewTuvupdePEe1ySsLH0p4lx09xWyu3qYW3LlqGtUug4oTOoZgav6LGv2SzWRkpUE84
         Y7rz0gUoXHouPtw1Q2T0WFgyz2L3Qfr6GFfoWIIaYqtwm8JgdMO6m+aOlfC2kHuJViSd
         S8VFuDJL3rf5FP4us865Jj4LHdHGC06Qb+SNZgg41tx2/ZiKRtWaxXOoCSnVgAXX+IcC
         lWwguEh9pNZjsCkKqdjQ5zCCBZ0PBpf2UWzigyWGWQTMI0gm34gLKqlOwVbt2N54y8jA
         ekGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717496775; x=1718101575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo00xf5gWSvOoL/K1nBFKHV2CgNWuJjUCsHHkqwt6Ps=;
        b=BtoYo5BPjTbbAmFkFW1QY31/ti1pSEnPKK2eYoVjXhaMapS8ZobEFe+qVefAMEfcNv
         hUNasOgyvtBYiBC0rwDBc4OCJyF0JxrmHsD7HWyweVDWNm5CocJyJ+afei5JJ5hu+2FX
         t9YxX5cjhrL3E8PoWq0pidMfzku7q17MmNxpqVRpu7BNbRlydN+1fdeyjwU+wwbwKeQ6
         4Q9HbiPeF9NTLN/cb54X4Z3UyJVDpIWR+Qkrql+cAKBUbXKFGglGLT+jSEeIOnLZzDEo
         5c+gYdHW2uZGWATBP6rS/tQOEskerHZhBMem+SU69R4MW8F64pAA9gnNLwn/E85lhmnI
         xQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7c+Z26tNH2wmJnJDmD1BNM6Pt2Pdq35kvbDBOZN/ScfKdCT0wFGS/uKfWdww8V9IG2M9FEsn6M9vAdavEvN74KxntOKnJWadnXsYZ
X-Gm-Message-State: AOJu0YxgRTOI3eU4yopZs9g8I/aKexq12Gzl8SxG9lxCUBjLtnj0cNmK
	6rhKhW02u2nxcXGXNoUdEBzCB84Z5G4nXqYrREaQIao7uA6Md0u4
X-Google-Smtp-Source: AGHT+IFXLjhPaCj5Z8Oe14oldl4gZO8dRpoP10oLa1z/M5Kni5pv9yJJDxahJGUprS04gno+V7T7Pg==
X-Received: by 2002:a17:902:d481:b0:1f6:8973:e4b0 with SMTP id d9443c01a7336-1f68973ff30mr33527995ad.39.1717496775133;
        Tue, 04 Jun 2024 03:26:15 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632419187sm79631125ad.287.2024.06.04.03.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 03:26:14 -0700 (PDT)
Message-ID: <4d299245-3166-4810-b22b-2a5b4f54a049@gmail.com>
Date: Tue, 4 Jun 2024 18:26:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/ksm: reduce the flush action for ksm merging
 page
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-2-alexs@kernel.org>
 <9ca730ce-2b2f-42d2-8c7a-78735a995c64@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <9ca730ce-2b2f-42d2-8c7a-78735a995c64@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 4:07 PM, David Hildenbrand wrote:
> On 04.06.24 06:24, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> We can put off the flush action util a merging is realy coming. That
>> could reduce some unmerge page flushing.
>> BTW, flushing only do at arm, mips and few other archs.
>>
> 
> I'm no expert on that flushing, but I thought we would have to do the flushing before accessing page content -- before calculating the checksum etc.
> 
> Now you would only do it before the pages_identical() check, but not when calculating the checksum.
> 

Hi David,

Thanks a lot for comments!

If calc_checksum() is wrong before pages_idential(), (that's just after page was write_protected, that's a real guarantee for page context secured) pages_identical could recheck and make thing right. 

And as to 2 flush functions here, I didn't see the guarantee for other writer from any other place. So maybe we should remove these flush action?

Thanks
Alex

