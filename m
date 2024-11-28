Return-Path: <linux-kernel+bounces-424338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8016A9DB336
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6664AB21BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6F11482E1;
	Thu, 28 Nov 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fIR06h5U"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3D146590
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779370; cv=none; b=Z1hpN8gKwdHsNqOSCOEsIOhofVdl3vt6rVm7aejyatyBWj35rqDGrCxD2y9TvruV2+NrspfS5UPpoT7dmsZbYPeIqLwB8qSbEqQaiMonPqSnGaUAU4BG978It2dWhW5SPgpYsqVsUDuaROamxOUzGeiuIB25BTK1rCvsVxjGmeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779370; c=relaxed/simple;
	bh=JX062nscDn9LBwnQIRftOceQt9HqOODvHCFqnP7vfw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJQ4dfJxHMy85tDbCR20+9U6Ct/QMB/C4M6EX881WwPv04w5iwSz01mxExMSxWloIAl94hPl040pptbC69+j2kMNEJWBzMf+8RpailP/RvyiqeNEHp9Cr8AaDp5BL/lhPxRfCpEuw5HWTe60d+qRNz1ldMcFCW1/kg6uSeLJqSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fIR06h5U; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-382296631f1so473130f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 23:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732779366; x=1733384166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnP0d5lLaGKuLe5nnz6rtVePQG9JUXHbtqcoMrzTGKk=;
        b=fIR06h5UtKpWrLuyeP0y6bxhy83d3DNJCbkZkbdCakYpg67MxtGEWOsmQToEOzrx1g
         g93URFYYN6AKDpjaiCHYBT5K3pcPcMM5kVMMTwteaxUaY1yQ3CzG0uXYVnRmPGriefUo
         LInqup7h0VGBKXLGQ1KGehIjkNqzEroPWbNUETR54XZDOP9YyQ7QJ1Iqv7IpXCIjMWOj
         YOOGdm1q0oudkYIHWr/Ll76vEgOJUJ86kz3zIpjq4A1t/o9hyFRPLeY0Hbdp/iCk8TT2
         85VWIGycIIX+XzDshMSjDxe/S8AMbMyY0+CZigNoB3L6vRBBgUwrAjIbG7NjGPP4m+U0
         0BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732779366; x=1733384166;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnP0d5lLaGKuLe5nnz6rtVePQG9JUXHbtqcoMrzTGKk=;
        b=qUNCxW8j8WMNZRfq2fstn2DgKgi97PY1UYNpt5wENZ89O8/666VamzjW6IdtE0DIdP
         2xghGLTvf9a+/qZ/r9Gr093smCL9lYxe8txogGXTO1k8HHnEAgzVpJMg4eKsZGAQ4+qF
         02S2MzcEGFCoKE2rq/TaR19DaXnfFbhDyZLeIYiQn0DDZ31yG9nkGks6TJTl6KYYAZ90
         rQTVNLltj/jAxZmE+9LA6Umt1GRVyFnXYQ90vsnszYZGPJCY98omVMyI1YObYc/iMDm5
         aimWYq/2yCDK/Ro4KfneJA+aYCA1jCIlVXQZLiB9PmhKbglSA7U6zPhcKfdSXCE4k7/z
         /WIA==
X-Forwarded-Encrypted: i=1; AJvYcCXTtn8o6fxV3ulkgOOyyptxiwkdBM8g1rQvvYscd/vB8woynL/Ov9xLcDuO+kpzRza9QQujEEY0wTqYOiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPwUb6OmO5ZKbprc7wtpKi6azJT6Lb4oVoCESnvUsQuOKeUfow
	+y1OPnJNmOWFjIBlO7jN9plxa97UMdZJruyjU0cLuOHlgu2qc5tr0sqOnYoevDc=
X-Gm-Gg: ASbGncs51mr9BdrcgRrVHBUp/L/6zZuQaRIopxiGCAOpY24r9ThMGpslRcMwU/tUTDM
	h5xqQBaHw9zZzUegED20D9MZKBNdWyX9xMX6m2Uak5p6DC5XMJOlnmW4jEgvdMsuOyAO6sl3zFa
	+yWvW45S91DBfxwZHtpwdkGKIU961tX3/hvEHeQqDAecm4SS4uqZZj1Kqipd6Od3iyiH3+9DLIK
	eOth040woNv+7/R/BdCN/KaNn4kmToiT2svVjmgaKwgdhXgLe+bUAxj+HCWdlDit7P9aFnMXUNb
	b9iqyxiLYJ1n+U0fjeI=
X-Google-Smtp-Source: AGHT+IF3J7odguyMKE1/ovbU5qS7/OmybMDWgQ8ajnj5B4Q2mJyalCBlUl0W8XhZiD/NB2/U6PEc/Q==
X-Received: by 2002:a05:6000:1865:b0:382:4a3b:5139 with SMTP id ffacd0b85a97d-385c6ef598emr4607072f8f.59.1732779365868;
        Wed, 27 Nov 2024 23:36:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d22d4sm43904045e9.27.2024.11.27.23.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 23:36:05 -0800 (PST)
Message-ID: <ba0f252c-345e-4988-8d4f-36116708f19e@rivosinc.com>
Date: Thu, 28 Nov 2024 08:36:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: module: use a plain variable for list_head
 instead of a pointer
To: laokz <zhangkai@iscas.ac.cn>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20241127142519.3038691-1-cleger@rivosinc.com>
 <980b98978ab4ee912b37cb101ad43bce20b56dcb.camel@iscas.ac.cn>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <980b98978ab4ee912b37cb101ad43bce20b56dcb.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28/11/2024 02:01, laokz wrote:
> On Wed, 2024-11-27 at 15:25 +0100, Clément Léger wrote:
>> rel_head's list_head member, rel_entry, doesn't need to be allocated,
>> its storage can just be part of the allocated rel_head. Remove the
> 
> Oh my poor English. OK, it's more better than just add the lost kfree.
> 
>> pointer which allows to get rid of the allocation as well as an
>> existing
>> memory leak found by Kai Zang using kmemleak.
>                             ^
>                            Zhang
> 
> BTW. Doesn't it need a fixes tag like what you suggested? (The bug
> might come from 6.7)

Hey Kai,

Apologies for misspelling your name, I'll fix that !

That's a good question, I guess I could have added it indeed but since
it was rather a rework, I left it out. But it's probably better to add
it anyway. I'll send a V3 with the Fixes tag as well as fixing your name
spelling.

Thanks,

Clément

> 
>>
>> Reported-by: Kai Zhang <zhangkai@iscas.ac.cn>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> ---
>>
>> V2:
>>  - Add Kai Reported-by
>>  - Reword the commit description (Andrew)
>>
>> ---
>>  arch/riscv/kernel/module.c | 18 ++++--------------
>>  1 file changed, 4 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
>> index 1cd461f3d872..47d0ebeec93c 100644
>> --- a/arch/riscv/kernel/module.c
>> +++ b/arch/riscv/kernel/module.c
>> @@ -23,7 +23,7 @@ struct used_bucket {
>>  
>>  struct relocation_head {
>>         struct hlist_node node;
>> -       struct list_head *rel_entry;
>> +       struct list_head rel_entry;
>>         void *location;
>>  };
>>  
>> @@ -634,7 +634,7 @@ process_accumulated_relocations(struct module
>> *me,
>>                         location = rel_head_iter->location;
>>                         list_for_each_entry_safe(rel_entry_iter,
>>                                                  rel_entry_iter_tmp,
>> -                                                rel_head_iter-
>>> rel_entry,
>> +                                                &rel_head_iter-
>>> rel_entry,
>>                                                  head) {
>>                                 curr_type = rel_entry_iter->type;
>>                                 reloc_handlers[curr_type].reloc_handl
>> er(
>> @@ -704,16 +704,7 @@ static int add_relocation_to_accumulate(struct
>> module *me, int type,
>>                         return -ENOMEM;
>>                 }
>>  
>> -               rel_head->rel_entry =
>> -                       kmalloc(sizeof(struct list_head),
>> GFP_KERNEL);
>> -
>> -               if (!rel_head->rel_entry) {
>> -                       kfree(entry);
>> -                       kfree(rel_head);
>> -                       return -ENOMEM;
>> -               }
>> -
>> -               INIT_LIST_HEAD(rel_head->rel_entry);
>> +               INIT_LIST_HEAD(&rel_head->rel_entry);
>>                 rel_head->location = location;
>>                 INIT_HLIST_NODE(&rel_head->node);
>>                 if (!current_head->first) {
>> @@ -722,7 +713,6 @@ static int add_relocation_to_accumulate(struct
>> module *me, int type,
>>  
>>                         if (!bucket) {
>>                                 kfree(entry);
>> -                               kfree(rel_head->rel_entry);
>>                                 kfree(rel_head);
>>                                 return -ENOMEM;
>>                         }
>> @@ -735,7 +725,7 @@ static int add_relocation_to_accumulate(struct
>> module *me, int type,
>>         }
>>  
>>         /* Add relocation to head of discovered rel_head */
>> -       list_add_tail(&entry->head, rel_head->rel_entry);
>> +       list_add_tail(&entry->head, &rel_head->rel_entry);
>>  
>>         return 0;
>>  }
> 


