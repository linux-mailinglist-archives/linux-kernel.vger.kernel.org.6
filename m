Return-Path: <linux-kernel+bounces-266517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBB5940105
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97553B218F5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D624E18EFC6;
	Mon, 29 Jul 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y/uTrcOh"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0CE653
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722291921; cv=none; b=RUi0tzNLQyBhklY1GsBt+NnXFGB5lhI+cB6daHFVEkACpAvLsqpuCU2DPw/cMvGpnaQF6Bg6anIen0oxTYAgRniWBJknikAGqw5Psq6TWtrwMMU/TkCnVfAw2HN8PUWJiAj4eI8mLCA3froaeaUtse0JPjktQKj1AtyTCO3LyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722291921; c=relaxed/simple;
	bh=xWTezGZC+aNoybLtIfg4ferrsMhAYJp2A89+70NJRZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7oO8PT2EhYfP4RB0Oufe6t0Qas3I3Xck2TRu9ZrKddiUzbgljnYEJh5adh+zj1dw7HHQ/0eQhuiYZcNZtNoDD3PFjrere3teADyET25p4P1FbbjzxSI9DEP8PAqnRnXopJWctOq9g3Tk1XiklexfDxg8HWWsoRtGR9uXh62yuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Y/uTrcOh; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db145c8010so2511951b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722291919; x=1722896719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVlxUbz4pa/9Tj9VrPKszKAsaSj1v3LHCT1Urzl3XiY=;
        b=Y/uTrcOhuW/ywz9K9TOdWAQMOnYbHiE+WdhGMthmcQkFNhWwDXZZ3KM9LTr2MlVlrd
         rG4v481rqZM8GsQLFjWp/uXV7FkUZerjrGxQwUjLDpuwfEGOrGQrK2g6lFLD9lvVNPLE
         PJnfnVQx454RQq2d8a6QoUr4lp9TkvtjbG+sqpw8UiJ8mA16FUR3B3+RCtRHqQH3WhTT
         h10S70SIBUzGoNdNeMcN4Q3UHNKRsVCH/0paz+0YOXdgMpYSwc5kIOaYm122vDE4S3nC
         Iu0OFdwWBqrxNs74G4wr5N3AInjQIJ2liYnKs16Kw61m0axJ7GTPAUnU/7Jfm0TDj+jG
         bZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722291919; x=1722896719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVlxUbz4pa/9Tj9VrPKszKAsaSj1v3LHCT1Urzl3XiY=;
        b=Bhb5AjM/alLByXU0cSrMl6q2xUKcRhf0bapNzBdSBJL0a+e88igaNOOuEhhjgpG/rR
         T8fKxu7coxHluLjRo8rkTHWQo/OND44ldvF94JRMKuKGxmRlNByZZJJHg02qRtngUanq
         4u2353IaScEfEUUs3esQeFxM/qNgwYy6shvP2IIVK/UWhWbOegkrqPiIv/WXuoFp7+PB
         vJWzMxhtoSeNzrY6sxhx/jF/bDBbAVIYTQ1O9DyZCwF12qtRcQDgIAtWiVrZReGFnFmx
         W4bvpIPT5Wao6OMB6jMKz3P20dPADzGYnPZ3fTTUFnFG7E8Wmbo/WCoJqpA4PJL+4VAu
         bjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbKCGgXPUqANuEP93QlNFvXCu9Le161ZAQPz8j/a8oBi391L4JEC1ykxidW51PHvbIqwHrb994fepYDCL1RYgzUUfVZ3a0wjRMuRSK
X-Gm-Message-State: AOJu0YzKqDp1gpWqHEcBC8uNmJP6yMCSzFZ3IBGhBKoS/64UVu3r1DJj
	Jey824C52Rr9xQdixq2LXRoj1mWgEtRxirBtJMs3xGqyvylDlcvLkaq8/BVFPgI=
X-Google-Smtp-Source: AGHT+IFZsbULsvsAJ+zmwGlsO/VzVdEKDMIJBEKpFwmPqkovb7VkPmkLAkzwPqmhAcAqyOaaNLlO3Q==
X-Received: by 2002:a05:6808:1802:b0:3d9:e109:a6d3 with SMTP id 5614622812f47-3db238b1c17mr13699838b6e.26.1722291919190;
        Mon, 29 Jul 2024 15:25:19 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db41805cfasm72082b6e.29.2024.07.29.15.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 15:25:18 -0700 (PDT)
Message-ID: <df249398-5fb8-4ab4-9eb7-95dac294a465@sifive.com>
Date: Mon, 29 Jul 2024 17:25:16 -0500
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
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
 Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>,
 Evan Green <evan@rivosinc.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-kernel@vger.kernel.org
References: <20240718213011.2600150-1-samuel.holland@sifive.com>
 <20240718-a5097a4070f457529d2fff91@orel>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240718-a5097a4070f457529d2fff91@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Drew, Clément,

On 2024-07-18 4:57 PM, Andrew Jones wrote:
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

I think that's a reasonable assumption. An internal extension can only be
added by implication, so any validation would happen in the context of the
superset extension which is actually in the DT/ISA string.

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

This strategy ends up looking like the following, which seems like a lot of
extra code to do nothing with the array entry. But if this is what you all
prefer, I can send it as v2.

Regards,
Samuel

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index ce9a995730c1..cbf8d9a88f45 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -58,6 +58,10 @@ void __init riscv_user_isa_enable(void);
 #define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _validate) \
 	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
 
+#define __RISCV_ISA_EXT_INTERNAL(_id) {							\
+	.id = _id,									\
+}
+
 #if defined(CONFIG_RISCV_MISALIGNED)
 bool check_unaligned_access_emulated_all_cpus(void);
 void unaligned_emulation_finish(void);
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index f6b13e9f5e6c..59562ed13986 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -271,6 +271,9 @@ static void print_isa(struct seq_file *f, const unsigned long *isa_bitmap, int c
 		seq_write(f, "rv64", 4);
 
 	for (int i = 0; i < riscv_isa_ext_count; i++) {
+		if (!riscv_isa_ext[i].name)
+			continue;
+
 		if (!__riscv_isa_extension_available(isa_bitmap, riscv_isa_ext[i].id))
 			continue;
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 68b8f24b630d..e4dd837d7bea 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -387,6 +387,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_INTERNAL(RISCV_ISA_EXT_XLINUXENVCFG),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
@@ -469,7 +470,8 @@ static void __init match_isa_ext(const char *name, const char *name_end, unsigne
 	for (int i = 0; i < riscv_isa_ext_count; i++) {
 		const struct riscv_isa_ext_data *ext = &riscv_isa_ext[i];
 
-		if ((name_end - name == strlen(ext->name)) &&
+		if (ext->name &&
+		    (name_end - name == strlen(ext->name)) &&
 		    !strncasecmp(name, ext->name, name_end - name)) {
 			riscv_isa_set_ext(ext, bitmap);
 			break;
@@ -734,6 +736,9 @@ static void __init riscv_fill_cpu_vendor_ext(struct device_node *cpu_node, int c
 			const struct riscv_isa_ext_data ext = ext_list->ext_data[j];
 			struct riscv_isavendorinfo *isavendorinfo = &ext_list->per_hart_isa_bitmap[cpu];
 
+			if (!ext.property)
+				continue;
+
 			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
 						     ext.property) < 0)
 				continue;
@@ -801,6 +806,9 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 		for (int i = 0; i < riscv_isa_ext_count; i++) {
 			const struct riscv_isa_ext_data *ext = &riscv_isa_ext[i];
 
+			if (!ext->property)
+				continue;
+
 			if (of_property_match_string(cpu_node, "riscv,isa-extensions",
 						     ext->property) < 0)
 				continue;


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


