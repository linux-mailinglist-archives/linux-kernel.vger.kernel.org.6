Return-Path: <linux-kernel+bounces-257030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A52937432
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 678331C21CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 07:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A504D8A1;
	Fri, 19 Jul 2024 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QA4PFPwY"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755E51799B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721373087; cv=none; b=p0xBsZac+/Y1n8QWDp4adHu3eWWrruZ2a425AtLO5Hwcn1XdeI0ZyII0xuJLxMfpDMOzDWym9jYQkRFbfJn9Sg7ut2dh7DyBFp28iyC1YOQiyn1Hl12P6HJacJFb3ZVS6TNjUkwsRo788Z5UVWcFHEc+MdgaCxMS3W6I94e9BKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721373087; c=relaxed/simple;
	bh=xYrum3fEpeZFB01ja+P3y+b4Bx5ACwIYcFak3KB7+c4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcwpscOcMgbqMoltytkmm9z5LoOkwu57tfXLrumZlbzw3cBkl50JEYX+KqlwihEFSNig8fF5V9Lx0dCtjSO/RSoWGEE5GdqWRrXJOJ7iH9gm4IsHX51MI4AXGBoDJAr+l/nLHOiABTgaChTUMQHAmbRFSvEBfZbx1hFfUccHYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QA4PFPwY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42111cf2706so1633605e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721373083; x=1721977883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jk306sEtt+KWaIxzvPA3Rfg8FT2T2O98W/TT8wSXjjI=;
        b=QA4PFPwYOcorn/O0rKC5wjiinGTTswqYFtmp2rSvFWL1KA9zPCEDy0aQ8UW/9wAfGs
         Y6BsColSBTshtApuG3J+p9oxiYFC4n5JUQylTigZaX5j1ZbeQY9MYiqvMoLfPqrim2Rq
         eOC7pFavbLn2Z3KqHjWLVGYecDQB8Rswc7n8bTldNYV1J47ZKuYouUeHn0+rTAKVyuWQ
         HNLgyMJVTPwqaTUzBs/fY4/bmF0JXgOTAQJ9IypSDH/XWpHslZOB09GcytWN5dBSkqU8
         uzRRaQHmQmiIvdXHi/+yQrjcpDNpeCVC3FTEz2nbk/vspVxbHzheBedJA3chNA6DQwkN
         51UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721373083; x=1721977883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jk306sEtt+KWaIxzvPA3Rfg8FT2T2O98W/TT8wSXjjI=;
        b=v1VazI2Qs8aFYlPE45v8lgH0I2Ti+oBcXtU5FlCFKQTBu3JEnHHLkKwciaB2J95Uwr
         RvR9ssVDiPfpOqBN/EadRI++BRZD/v6p1X3+CV0a8bbYZvgVXxH/rle98zm4WfQGBqoO
         /j5B1xgGKHkqxhCyQmVVCOxEbjo/7riUvYkW6/nMt6SwwFS6kAT2m4eUnEJZcW9k9sg7
         MwX6Xnr8mGfKrDl2CoQsqW9rMLGPYc/Qx/u7b38D6XPZTF9Ew+p9ycauMxPA0Ke88Hn4
         ofmIBL+wcUCjnlf7oTJoLZhTZyVeD2Hwr4IdJu0v2Z2AiL423h64BxleIdtaQwXyGeOp
         a+8A==
X-Forwarded-Encrypted: i=1; AJvYcCVM8NN+oL1rqxCt2wsSWPT4fji6ibN7xOKK7E5MWgRxEAuacgIbvbF4sG50Wbvve03b7Rh7RF2R7vdR5iz1kJcO/cpjeaoX3waJzWWu
X-Gm-Message-State: AOJu0YzhZor60uy+xtjzl8C9/MB0gvLcjcKP4N3YguvoxdfDY7kS7C51
	a5i42BYD6qS30juT+s13ZBXt2nG5wbJaFhEVifMl/karOeLVReKy8jDa8bmh3k8=
X-Google-Smtp-Source: AGHT+IFFa900iN8dkh57FH8wZ/8l1M9ljJMs0GMKFosTl1JPDR750e2hW2JZvmRu6cWA8I4/lSFCJw==
X-Received: by 2002:a5d:64e1:0:b0:35f:2a75:91fd with SMTP id ffacd0b85a97d-36872c9ce9cmr760384f8f.6.1721373082617;
        Fri, 19 Jul 2024 00:11:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878684757sm791766f8f.10.2024.07.19.00.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 00:11:22 -0700 (PDT)
Message-ID: <a36e07a1-f4da-4d6f-9e68-929b77b70836@rivosinc.com>
Date: Fri, 19 Jul 2024 09:11:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: cpufeature: Do not drop Linux-internal
 extensions
To: Andrew Jones <ajones@ventanamicro.com>,
 Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>,
 Evan Green <evan@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-kernel@vger.kernel.org
References: <20240718213011.2600150-1-samuel.holland@sifive.com>
 <20240718-a5097a4070f457529d2fff91@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240718-a5097a4070f457529d2fff91@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/07/2024 23:57, Andrew Jones wrote:
> On Thu, Jul 18, 2024 at 02:29:59PM GMT, Samuel Holland wrote:
>> The Linux-internal Xlinuxenvcfg ISA extension is omitted from the
>> riscv_isa_ext array because it has no DT binding and should not appear
>> in /proc/cpuinfo. The logic added in commit 625034abd52a ("riscv: add
>> ISA extensions validation callback") assumes all extensions are included
>> in riscv_isa_ext, and so riscv_resolve_isa() wrongly drops Xlinuxenvcfg
>> from the final ISA string. Instead, accept such Linux-internal ISA
>> extensions as if they have no validation callback.
> 
> This assumes we'll never need a validation callback for a Linux-internal
> ISA extension. We can make that assumption now and change our mind
> later, but we could also add Xlinuxenvcfg to riscv_isa_ext now and
> modify the places where it matters (just print_isa?). If we add
> Xlinuxenvcfg to the array with a NULL name then we could do something
> like
> 
>  print_isa()
>  {
>     for (...) {
>         ...
>         if (!riscv_isa_ext[i].name)
> 	   continue;
>     }
>  }

I would rather add it to the riscv_isa_ext[] array and avoid handling it
differently. There is already the xandespmu extension in this array so
xlinuxenvcfg can be added as well.

Thanks,

Clément

> 
>>
>> Fixes: 625034abd52a ("riscv: add ISA extensions validation callback")
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  arch/riscv/kernel/cpufeature.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 0366dc3baf33..dd25677d60de 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -457,28 +457,26 @@ static void __init riscv_resolve_isa(unsigned long *source_isa,
>>  		bitmap_copy(prev_resolved_isa, resolved_isa, RISCV_ISA_EXT_MAX);
>>  		for_each_set_bit(bit, source_isa, RISCV_ISA_EXT_MAX) {
>>  			ext = riscv_get_isa_ext_data(bit);
>> -			if (!ext)
>> -				continue;
>>  
>> -			if (ext->validate) {
>> +			if (ext && ext->validate) {
>>  				ret = ext->validate(ext, resolved_isa);
>>  				if (ret == -EPROBE_DEFER) {
>>  					loop = true;
>>  					continue;
>>  				} else if (ret) {
>>  					/* Disable the extension entirely */
>> -					clear_bit(ext->id, source_isa);
>> +					clear_bit(bit, source_isa);
>>  					continue;
>>  				}
>>  			}
>>  
>> -			set_bit(ext->id, resolved_isa);
>> +			set_bit(bit, resolved_isa);
>>  			/* No need to keep it in source isa now that it is enabled */
>> -			clear_bit(ext->id, source_isa);
>> +			clear_bit(bit, source_isa);
>>  
>>  			/* Single letter extensions get set in hwcap */
>> -			if (ext->id < RISCV_ISA_EXT_BASE)
>> -				*this_hwcap |= isa2hwcap[ext->id];
>> +			if (bit < RISCV_ISA_EXT_BASE)
>> +				*this_hwcap |= isa2hwcap[bit];
>>  		}
>>  	} while (loop && memcmp(prev_resolved_isa, resolved_isa, sizeof(prev_resolved_isa)));
>>  }
>> -- 
>> 2.45.1
>>
> 
> If we'd rather leave Xlinuxenvcfg out of the array (and generally support
> extensions not in the array), then LGTM
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew

