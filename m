Return-Path: <linux-kernel+bounces-561352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1D6A6105E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C59417A355
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ECF1FDA9B;
	Fri, 14 Mar 2025 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lxgR6E9g"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AF1FAC37
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952847; cv=none; b=m/U1ATiyK2v3iXAHVkTL7+9vRHJJzPwZh4+GdEj2AyUZY1HYzuTqShfHAlQrt+OMsv1JjdJIiXUTaeYuNrvE5XlmnwjiY624N92CmcMnSUPt3wbKSX7RvHvv1gsujZXQTdAdcy0/o8dIgXMWaAjT7O1ceVCfO4c3saW2nlGEYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952847; c=relaxed/simple;
	bh=9S08aj6cuSDTLfzLSRyiaJKUipi4ZUDEq0jVrExy7QY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2f0oCdepG/dHHDtcXfM+kCKm4cp/8F1TBsQvspXn7h4JxcSmtduF4RKOa33OlS7slsBnAe9b5pkxVjV2vTWTCa/Zy0ipU/EFrct4mQJZFUAi9QA8+90cI5fNsWzmwA506pCw5HCRGNoOriXc5gYNhC7XRpfr2kUBAaM5FAUC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lxgR6E9g; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso2025657f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741952844; x=1742557644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RzikXcMBGZjkkMXY0vzLgpXOZlJlOHrf1lUiKHrI63E=;
        b=lxgR6E9gEPI2VQ/wcCjV0KIp7cMr4bfJFjWk/5GOeuVJ5qhF6/UAbFYuad33lThEP6
         RZEHmyL9PpkGCDT3TCjogJ9o6q9Be16fVfq/cyYI0dFdSx6U0OIoRkwmmLRCvrhdv0DH
         8g4+Ximy1DW0f5gMs3+o/rbX7PKwSotv+AkBRZosfBD3gCrgaBiqeT4Z8nVTMEqlIx8n
         tw4Me7/t/jSIkmOMAc4ko40U/e5wwEbDsJ4vlluHdnrWSxOQ7kK1Z3Fm2VcfDdXww6bt
         pQHgjR2QWB+IFf36S2R0Ce0djPsuLKnFZ3MwEqtO5s2jegYQqmUlV04lMBTKO4TlEyXD
         HQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741952844; x=1742557644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzikXcMBGZjkkMXY0vzLgpXOZlJlOHrf1lUiKHrI63E=;
        b=uMkQoBh/S/CAjil9u6HLe0UQQcuPiCrS0u1PgVzFYxMwHnPABiSbC+NPrG9O48xYm3
         xO+CCz52/ezyeOF1i7OFrxrb+ogm/PTtlvb/6OPt68RtZW9I4gz87jxhN4vYUPNmQ/6O
         8dQY52LzEkRYkgcP2mRD1PbqqbnREUqQbChG9ZwOM3Tglla78ejlEmhtZcHW9yE7a2ab
         1vglg9xlzyHAsI4cAJpmlKZw5QGpMr+pivsjzxeCD5XN6zn3eSLA19B236KoYUXPhOrr
         iPCLmsdWfD2T2GMpTGZplQiRpKPl3hv8J+IBCZ6YYNnzsmEgNPhQphUaJj6S8WKt+v2Z
         BXNA==
X-Forwarded-Encrypted: i=1; AJvYcCVSFYeO+A56s45w+0JyDo2e8zQsxPIECiDcemJNLgD3BKWu6M+d3r3BP/BJcetxwWWVQLxYw+eKCyJ2BQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAoHV9a69tyxWN76wLqUcZENn+xzPcudiJVV4NlbnaAHc9ztAL
	iIziNC1hQ8OWVbGR0pvf2+Zujq8xzU0eUgFl7YBUEJm3gZ02vjw+fed2gplg1h4=
X-Gm-Gg: ASbGncvsi4hDTgUC1fPpToI+yd5IwEQN+iihJ3ipbK06GT4O2x/X0UekUuEKK8Cy5t7
	JHEu79swCdRl6rBwolpq1kUqCnd+XEdzOvtr93zSFY3mz26sUbZDdx8mQs0EQPcFubNo8oUgAs4
	hbHymGF4xBNE0i9HwgfSuv7FwUKVteK/65Pm7I3zssaL+IG5xjHbAtKrGEICSRIAepcMeL6Q8yQ
	4cOqBJ4horrPa0vtCgG9hguIAHw7ljIVcX6D+ccMaSpERN0JsGAks2B3vbqPb9hjUYpTICrvqLy
	eewChfTa0eTmTfTmD/WeELYHm5L8Yts/7X6nrhq0Zf0JFm/Ze1TAmbyhTHgCnp5lDmKsGNQEWQi
	aTMw8IxHb1eIr7Q==
X-Google-Smtp-Source: AGHT+IGtfAcAmGZVPhIyucY33egMDOBZySQ+8fr8l7lHLk072SvheDgQHi3fAYh9SVsSUmw9CF0urA==
X-Received: by 2002:a05:6000:2cf:b0:390:f116:d220 with SMTP id ffacd0b85a97d-3971c97ba0cmr2373277f8f.17.1741952844036;
        Fri, 14 Mar 2025 04:47:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9ccsm5371909f8f.96.2025.03.14.04.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 04:47:23 -0700 (PDT)
Message-ID: <f0945e93-7ac0-4217-8095-93fff303bdf2@rivosinc.com>
Date: Fri, 14 Mar 2025 12:47:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/17] riscv: misaligned: use correct CONFIG_ ifdef for
 misaligned_access_speed
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-kselftest@vger.kernel.org, Samuel Holland <samuel.holland@sifive.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
 <20250310151229.2365992-7-cleger@rivosinc.com>
 <20250313-a437330d8e1c638a9aa61e0a@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250313-a437330d8e1c638a9aa61e0a@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/03/2025 14:06, Andrew Jones wrote:
> On Mon, Mar 10, 2025 at 04:12:13PM +0100, Clément Léger wrote:
>> misaligned_access_speed is defined under CONFIG_RISCV_SCALAR_MISALIGNED
>> but was used under CONFIG_RISCV_PROBE_UNALIGNED_ACCESS. Fix that by
>> using the correct config option.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/kernel/traps_misaligned.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
>> index ffac424faa88..7fe25adf2539 100644
>> --- a/arch/riscv/kernel/traps_misaligned.c
>> +++ b/arch/riscv/kernel/traps_misaligned.c
>> @@ -362,7 +362,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
>>  
>>  	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
>>  
>> -#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
>> +#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
>>  	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
>>  #endif
> 
> Sure, but CONFIG_RISCV_PROBE_UNALIGNED_ACCESS selects
> CONFIG_RISCV_SCALAR_MISALIGNED, so this isn't fixing anything. 

Indeed, that is not fixing anything (hence no Fixes tag), it compiles as
a side effect of Kconfig dependencies.

> Changing it
> does make sense though since this line in handle_scalar_misaligned_load()
> "belongs" to check_unaligned_access_emulated() which is also under
> CONFIG_RISCV_SCALAR_MISALIGNED. Anyway, all this unaligned configs need a
> major cleanup.

Yes, as I said, I'd be advocating to remove all that ifdefery mess.

Thanks,

Clément

> 
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> 
> Thanks,
> drew
> 
>>  
>> -- 
>> 2.47.2
>>
>>
>> -- 
>> kvm-riscv mailing list
>> kvm-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kvm-riscv


