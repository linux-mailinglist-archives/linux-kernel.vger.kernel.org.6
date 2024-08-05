Return-Path: <linux-kernel+bounces-274927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958AE947E51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51ADB2847B8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6BB15B10C;
	Mon,  5 Aug 2024 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkqDyS5v"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D2F1514E1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872246; cv=none; b=Euv70iz6ppy/cBg1pw4NZqRNZidoFD+NnFHf98BiUCvFmnYr3oYW+9kRrqCvzKGl2L44ogloyb0LO7LPoXR7Krcn/q9ECjgAhL+1/r4lT+QC5y5f/gqBltZAorqoRuObagexqjw9owCVC+Ve28Yolcf9X42l8HtoT5TPo6mkmHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872246; c=relaxed/simple;
	bh=QLBKnKFGo1KQKDia/AdJ+vl3ZgO9VkyXpjqRJoPkZHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSLS7Z1jKrCjVaCPiEBtdanrZL4+KQ1OSaOoWqRwvSSYbhU0bNZ8abAnHH5IXyjtHCwcHid4Uzzo7+CAiL6rPlKEBdjsTMcPydy4uN1HyshLDUQxJhu3qSG/0SXB/W9Q+8cx+PHDHT9IfS86EFF81mJ+LkFa+Cd8TpMiue1OiWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkqDyS5v; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so981793266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722872243; x=1723477043; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrBwIGwG3+u5FlpRUxtjBR8VlO80V8brLm+1GYvIpgQ=;
        b=HkqDyS5vh7YDRhCqq6eovSlZ3yqvMK6VrfAI+w+ACzYPYnj1/h8VsdXWdj6PErVefC
         e+Uc/tamaF0rnc0AKVitnUKn15CxCe3XdSeCUO7d8xuWWq0Lpr23LU8IGt2ACjn/CQLQ
         LZvdtCAFM+XxfUwwTCxCMabOcovc8eHEe+aFIEpk6cBBXfopx6HkxXGMAwGEEDentc/Y
         B5iP+6NNr3I4M6VXIFq/XUjZFnthck+VLypv+Q+yUye26/kLBjE7daHLGEKgOLYbJ/6g
         IR3UUyF8ikedGsGAe4NzVvvvIQWVIrPSvgPfwAo90rtIUhkTX8+pp4Xi6CG+modvSl6u
         wZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872243; x=1723477043;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrBwIGwG3+u5FlpRUxtjBR8VlO80V8brLm+1GYvIpgQ=;
        b=tu4420uYYvrukyaxBmfuteeRyovlnMlIxIqTV1g7FkZ+UF4hRw0xV1fGuM/jW9sYml
         2yR2rUc3UQmdPL4O9jyTLW14L4t3p82kCBbONPL3+vhQwpu3NuIS65JG/zrCbr5SNocT
         a0Lzv+KpEtn2i6DLRZxiF0Bel4uyIVctvyXV/yYHmbkHNBqkUSFFuokKpFUHjgAKwY56
         eDdh19rI1uDE+jTTcBoJIiZEHeIXPBL+JEzqqiHx2f1FKUA3Y0jIA3rmVKpWSLTXwIv1
         QYDuEhoFFV/JL+Ap4S5C55Br5tEsFlizYLhL1TLdvPT0MW7IY+0nwGaRncWvgGaagwnv
         nbBw==
X-Forwarded-Encrypted: i=1; AJvYcCUisezkSUvcmmLnTyOTQRd0iVw9ur3MPYxs4TkoSSd9CCqlEl7MbAzNXjxbIDbFl0OfdCgdlbq3+GPznVDIb0SQR77DtQt21ZYjJt0I
X-Gm-Message-State: AOJu0YyIAcjwbS1i52aeWScmoOJuBU6p75Evp1dDOrLAOWqempzjVhiE
	zIOcAQO+43PNoI7iolcWxAHrLBec0+cFVBGe4rXjgXqtv6HpREr5
X-Google-Smtp-Source: AGHT+IFSwaBAMaiQnJ9beyzCMDN+8VuoJz0ozS1ktq4fNAlJRGsO05WZ0a5nCZBmueoxzL7cEC+Jog==
X-Received: by 2002:a17:907:2d29:b0:a7a:b561:358e with SMTP id a640c23a62f3a-a7dc628d37bmr1080912566b.33.1722872242953;
        Mon, 05 Aug 2024 08:37:22 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e7feecsm468897266b.176.2024.08.05.08.37.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2024 08:37:21 -0700 (PDT)
Date: Mon, 5 Aug 2024 15:37:20 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 1/5] memblock test: fix implicit declaration of
 function 'virt_to_phys'
Message-ID: <20240805153720.myjqd6ur65x5ucsu@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240802010923.15577-1-richard.weiyang@gmail.com>
 <ZrCjYqdmNfn3di-o@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrCjYqdmNfn3di-o@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Aug 05, 2024 at 01:03:14PM +0300, Mike Rapoport wrote:
>On Fri, Aug 02, 2024 at 01:09:19AM +0000, Wei Yang wrote:
>> Commit 94ff46de4a73 ("memblock: Move late alloc warning down to phys
>> alloc") introduce the usage of virt_to_phys(), which is not defined in
>> memblock tests.
>> 
>> Define it in mm.h to fix the build error.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> 
>> ---
>> v3: use static inline as phys_to_virt
>> v2: move definition to mm.h
>> ---
>>  tools/include/linux/mm.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
>> index cad4f2927983..c9e915914add 100644
>> --- a/tools/include/linux/mm.h
>> +++ b/tools/include/linux/mm.h
>> @@ -25,6 +25,12 @@ static inline void *phys_to_virt(unsigned long address)
>>  	return __va(address);
>>  }
>>  
>> +#define virt_to_phys virt_to_phys
>> +static inline phys_addr_t virt_to_phys(volatile void *address)
>
>Why volatilte?
>

There are two definitions of virt_to_phys:

  include/asm-generic/io.h
  arch/x86/include/asm/io.h

both has volatile.

I just copy from it. But I don't 100% understand it.

>> +{
>> +	return (unsigned long)address;
>
>This should be phys_addr_t, look at its definition in tools/include/linux/types.h
>

You are right. Will fix it.

>> +}
>> +
>>  void reserve_bootmem_region(phys_addr_t start, phys_addr_t end, int nid);
>>  
>>  static inline void totalram_pages_inc(void)
>> -- 
>> 2.34.1
>> 
>
>-- 
>Sincerely yours,
>Mike.

-- 
Wei Yang
Help you, Help me

