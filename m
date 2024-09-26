Return-Path: <linux-kernel+bounces-341169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C440987C04
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5A21C22CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D38F1AFB3C;
	Thu, 26 Sep 2024 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muDyL2eg"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF84B5AE
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727394791; cv=none; b=RPj9WVehulDb/fygX66A38f5vVEYE+LFRRe/T4dKawQEMJB1tjBz9/bUlZFgpxrdfJ4Gl1UEiymk0E+iRYLEB+oQByGGwpoD2ujQ7NYaEXWJiPoT+QBJfwwQxLhMMxklNDimyEf+2behoAjwgHVDTLu7/1Z5j6rQGSgVQ33quxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727394791; c=relaxed/simple;
	bh=tPFjYp1cAGnMDUrF5YvuZ+MyJO7Zanji3BC3nT5QVzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fbU+ZbCiZJWOCZzNRx6JbllSxaqGQqdGAZ/Y8L2oahbwpTZG3jPvvK1gPZBWVggYLVAOKK/AnhXvLfCGCEnBbWmGNmyIOMz/AZFoobcgFrdJEEWGnj3i1Tx/kFLoTPXlvVbnqy0uS+tI1k6YAHyFqkiSuEDyIZsstHoYLrEkLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muDyL2eg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-208e0a021cfso13816155ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727394789; x=1727999589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nbmi05uQmKdDJ1v+H62Z8EV2ec6e0LPYufcgycYqmKY=;
        b=muDyL2egdzOQ24tkVz5nyPlyxYtL47T+YAnZ2egta58Mh2KQeMJspoo/g3pJ4QZkp7
         tBrBpua+iVwFGf+pbMjdYMTg+oavon10IWxhbsn7qQuWkSrGbZG3zyt49kW0ufPhWtYs
         rFN6272GWb2uwbtXUPqkc9dekqSHDvwY7GGKgmX572rvQsgxRX/6cBNmauqU3ILHkzYf
         B0WwnKgdLLmum3I1I3rtI6FEtjHsJPT3StD5tIwJEbeZEh7ifReIKRZ7WHZeikWggI60
         5quKGDF57JXshOANAO7QLzx3j3UT49f4hTPCubxt7gpEngBHaxWFVORz9LQgP0hvRsIl
         4FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727394789; x=1727999589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbmi05uQmKdDJ1v+H62Z8EV2ec6e0LPYufcgycYqmKY=;
        b=UdzklG0fJ7AmTrGPB9kM/KpPByaRYO8WWirBTaHOklLbXYP5wspplL4OGDsDhC2yaG
         fLZHaJ1lmnSEQ7emvDI0CQSFVDl/YfBdggAQpM6R6H2HBUgEw3NWKWz/QTX+vOxFnUgC
         6QL4bQuIHqcVfPRFdFyGS+287h23hodB7dLP3zXtj5eVsdiCMwVuen+isV983kjlmkVb
         affpYOGVtMpfO9acvL6fQ7WbpoyCynIZePkTJX+38c4yz3h++kp1Zy4/ZPvXSCOAZulp
         q1ipDcohDbtbzCEla7pEO4DnEG6UkKq1ouUB2IP+a5N5SejH5WS4iC1iZNyYJRV1/4p4
         fFzg==
X-Forwarded-Encrypted: i=1; AJvYcCXIFt/d6kvJUBJ9828J3PxWjPcS3mpXdp3OOqQ5qvSvDsMetXYIXbgNxthUupcncuBi0YvRh1hwkd0EWWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuI7dchjwR+gtSeX/jfPqFD7DoQ9tMk5wZl1Be5lqHhEW2YaRJ
	+yyywPI7ym++l3cdDwoFTR1XuCRE1JpFM26E+LjrOmWphPj0cjDxdM+xNA==
X-Google-Smtp-Source: AGHT+IHQeLYjV2g1dhwF+Tov96hdx1JqC7GK5qvaDuFl2XZ/UwAXjEJRc0JPVJLBhvADwVYta8eMSQ==
X-Received: by 2002:a17:903:983:b0:207:3a5d:69b7 with SMTP id d9443c01a7336-20b37394e9cmr19175495ad.15.1727394789343;
        Thu, 26 Sep 2024 16:53:09 -0700 (PDT)
Received: from [0.0.0.0] (ec2-13-113-80-70.ap-northeast-1.compute.amazonaws.com. [13.113.80.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d8d488sm3646585ad.77.2024.09.26.16.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 16:53:08 -0700 (PDT)
Message-ID: <8c0a7e25-164f-4aeb-85e8-0670c7373cd0@gmail.com>
Date: Fri, 27 Sep 2024 07:53:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] rslib: Bug fixes and improvements for Reed-Solomon
 library
To: Randy Dunlap <rdunlap@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20240924123141.16962-1-zhangboyang.id@gmail.com>
 <6a92d261-8cc4-459a-a44f-365f9d41f289@infradead.org>
Content-Language: en-US
From: Zhang Boyang <zhangboyang.id@gmail.com>
In-Reply-To: <6a92d261-8cc4-459a-a44f-365f9d41f289@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/9/27 01:03, Randy Dunlap wrote:
> 
> 
> On 9/24/24 5:31 AM, Zhang Boyang wrote:
>> Hello,
>>
>> I have made several bug fixes and improvements to reed-solomon library.
>>
>> There seems to be no maintainers for reed-solomon library, so I have to send this patch series directly to Linus Torvalds.
> 
> Hi,
> 
> If I were making this patch series, I would send it to Andrew Morton,
> but if Linus takes it, I'm certainly OK with that.
> 

Oh, yes, I found it would be probably a good idea to let it go through 
Andrew after reading kernel docs carefully. (I decided the patch 
destination according to MAINTAINERS file and I'd like to say sorry to 
Linus)

Zhang Boyang

> Thanks.
> 
>> p.s. Revival of https://lore.kernel.org/all/20220806162510.157196-1-zhangboyang.id@gmail.com/


