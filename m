Return-Path: <linux-kernel+bounces-423566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA319DA9C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A96A165568
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087511FF605;
	Wed, 27 Nov 2024 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jQ94pgTk"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873271FF600
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717111; cv=none; b=DMwgFl2b+A6KXnAHKe84Px6Ut5vcwOurjldwVmYjzWOLCou4xePTbXplnhEV43Dls9AQt73GgokkZUs8f9BMifHpZwEABqJliBR4qZfeEWzcGC5Dxut41WuYdVz0kiQ5YXP6jXAiNYC2z6hSa8mEz9/SvfF/KAdJbhclqfPGNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717111; c=relaxed/simple;
	bh=STUWXTSPG/a17o1D4aNg8qizgxy6DEcd4nQTcnXXals=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fC7zplNWcPDc3BC97tI98NE3oVA6wjSINo65SbROhJcnuGx7h2yG22XBPJpOEz8E8e9J1nSnE/XLkbnzh82hPHOIpE2ycvZdj5XVrFoyqn1GuPibCLvzIwGaCd+jNNfM/0GA3QFhW3w5J55inu1Uo1B0ZfssEomsAAWGj6PY+ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jQ94pgTk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-432d866f70fso62037075e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732717107; x=1733321907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTHvqJquQDkugGQStOPmvdUb7cxp5w9lqzDRujNjCrY=;
        b=jQ94pgTkpUiBuGXKQgX+MI6lBa+8hU/RV7CUS16RYAqBXhzHeNvTSpHEe1OZ1KKWtJ
         hzj60VEe/KOdHFdvhvTQm1qiqCKdRzuolCVMK9Fvi3IgYx8zCHF2zg2Dq0z0V5f14B5S
         6hpGwr2yoMQyhjwmvsVIzBotzWJeTt/mVyCHuLvkDMCWMCD5T4WmCylV1cTTikoR3U3j
         +gs08NZXmfxMHFNQgOFnMidSmm0xf3NvsOFwCRWW+BWVI0ugPCJgSGZ/ygugOexr5Fd8
         AlOGa3UKEa8Mwp6PXg0Sc7dXSrHGXitOeBVwBNpkrGo3BR3vwpv+LT9DHyF+cytdmrAA
         AKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732717107; x=1733321907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTHvqJquQDkugGQStOPmvdUb7cxp5w9lqzDRujNjCrY=;
        b=hSPh95oXwkEPd+O8OlRtG04qk1Vu53mjJqc+cecU8Iioelj3bvB4FR3tandG+kNX3m
         t9f5avLt82IpWknzLwQDf6Shhc56lbkI1i+FLC7U52sshSTbdrhCMKZM+y9jKfLvRz4e
         LDDQbxa29QYyU/ii9vUUHvG393MTJMZIOblDHWXCWXSANkHB3Zzz6ev8BHYNAghKdcfd
         aa2PjOcZvjq+o7SR+p0LuEEbTfF8KEzKyFXMmKnSDRZoDObTe7ekc8tRNyWe63lLOXN3
         E52IAHAjxCeSF1m3cJ8lrSco4N9WC15zMGeF2ZslOyORLPcBXEMO5P2Q9YNIhDr0G1KZ
         95Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXKvA0zMUDWJpnlmpbQWgTTFPmyG0Jv6ArCxji32oV0xg5rTZxPSMegy2cUcEWpgRqeq6O96ZPylFtyRfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaeL4sC7K/p/rQTZE/J3iL9PLWlC/izJlBemWyP8Ss0l2e9Gi7
	yinSL19wfVVTMaa1dPeIhShB/6KyiDBUdWywUDmgvRmc/ERymj3WY0DbyhvROxw=
X-Gm-Gg: ASbGncsuKWjTTpRvC7jPHlr8yAFXM/RNj2q2SStJ2vFhvV12612ayLlqk6sCStqbB3Q
	tqI29EgCS9fBfM7YF8weuBQCala/sLt6+8rwhLcjVNNU6Dd1VMdHOyr1cT4hIwyhULOpwSbEWKd
	l0ElGZrefLOO5qsaFGju2TMQ88DPh5EwzeZsFzfZ8gl5AeJUUpSnRkT+drmE49t6qOwNpjEtjzU
	QKmqRau0vI9xCHFXa1Dt7Ank5SBIILmpe5k6eaNQWDN/iZuu6cE28TOPcFBHiWz3Immj/Hgpsnk
	QAWe5ehrmaq0NTm8dtw=
X-Google-Smtp-Source: AGHT+IF1TPsR60czgurK0Oh0ZEUJ56o8Yas+xvOtUbO1mBqDbtgWDtoYJrA43n6OxY5lncVFMEgseQ==
X-Received: by 2002:a05:600c:3b88:b0:434:a765:7f9c with SMTP id 5b1f17b1804b1-434a9db839emr28451645e9.6.1732717106761;
        Wed, 27 Nov 2024 06:18:26 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7b875bsm22370895e9.16.2024.11.27.06.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 06:18:26 -0800 (PST)
Message-ID: <2a902c69-1115-451d-82b7-dcf7641a7c4b@rivosinc.com>
Date: Wed, 27 Nov 2024 15:18:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: module: use a plain variable for list_head instead
 of a pointer
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Charlie Jenkins <charlie@rivosinc.com>, zhangkai@iscas.ac.cn
References: <20241127103016.2699179-1-cleger@rivosinc.com>
 <20241127-2c074e38cc599c7e2d0da505@orel>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20241127-2c074e38cc599c7e2d0da505@orel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/11/2024 15:02, Andrew Jones wrote:
> On Wed, Nov 27, 2024 at 11:30:14AM +0100, Clément Léger wrote:
>> list_head does not need to be allocated, it can be a plain variable.
> 
> rel_head's list_head member, rel_entry, doesn't need to be allocated,
> its storage can just be part of the allocated rel_head.
> 
>> Remove the pointer which allows to get rid of the allocation as well as
>> an existing memory leak.
> 
> It'd be nice to add how the memory leak was found. Inspection or some
> tool?

Yeah sure, it was actually found by Kai Zang, I have added him as Cc but
I can surely give him credit for finding the memleak, I'll add him with
a Reported-by.

Thanks,

Clément

> 
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> ---
>>  arch/riscv/kernel/module.c | 18 ++++--------------
>>  1 file changed, 4 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
>> index 1cd461f3d872..47d0ebeec93c 100644
>> --- a/arch/riscv/kernel/module.c
>> +++ b/arch/riscv/kernel/module.c
>> @@ -23,7 +23,7 @@ struct used_bucket {
>>  
>>  struct relocation_head {
>>  	struct hlist_node node;
>> -	struct list_head *rel_entry;
>> +	struct list_head rel_entry;
>>  	void *location;
>>  };
>>  
>> @@ -634,7 +634,7 @@ process_accumulated_relocations(struct module *me,
>>  			location = rel_head_iter->location;
>>  			list_for_each_entry_safe(rel_entry_iter,
>>  						 rel_entry_iter_tmp,
>> -						 rel_head_iter->rel_entry,
>> +						 &rel_head_iter->rel_entry,
>>  						 head) {
>>  				curr_type = rel_entry_iter->type;
>>  				reloc_handlers[curr_type].reloc_handler(
>> @@ -704,16 +704,7 @@ static int add_relocation_to_accumulate(struct module *me, int type,
>>  			return -ENOMEM;
>>  		}
>>  
>> -		rel_head->rel_entry =
>> -			kmalloc(sizeof(struct list_head), GFP_KERNEL);
>> -
>> -		if (!rel_head->rel_entry) {
>> -			kfree(entry);
>> -			kfree(rel_head);
>> -			return -ENOMEM;
>> -		}
>> -
>> -		INIT_LIST_HEAD(rel_head->rel_entry);
>> +		INIT_LIST_HEAD(&rel_head->rel_entry);
>>  		rel_head->location = location;
>>  		INIT_HLIST_NODE(&rel_head->node);
>>  		if (!current_head->first) {
>> @@ -722,7 +713,6 @@ static int add_relocation_to_accumulate(struct module *me, int type,
>>  
>>  			if (!bucket) {
>>  				kfree(entry);
>> -				kfree(rel_head->rel_entry);
>>  				kfree(rel_head);
>>  				return -ENOMEM;
>>  			}
>> @@ -735,7 +725,7 @@ static int add_relocation_to_accumulate(struct module *me, int type,
>>  	}
>>  
>>  	/* Add relocation to head of discovered rel_head */
>> -	list_add_tail(&entry->head, rel_head->rel_entry);
>> +	list_add_tail(&entry->head, &rel_head->rel_entry);
>>  
>>  	return 0;
>>  }
>> -- 
>> 2.45.2
>>
>>
> 
> Other than the commit message change suggestions,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


