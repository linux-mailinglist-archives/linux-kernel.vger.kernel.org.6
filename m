Return-Path: <linux-kernel+bounces-414678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B229D2C11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47745B37103
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA03143179;
	Tue, 19 Nov 2024 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yaHwTalB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D313AA35
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035464; cv=none; b=LtS0O+Uyu2AF7frabm80s7Hvh46Tyk6j8m/pB3BudqfzhhXBWwj09q1KYjp1xHftO/4GsMGZ05bOr6a5c7DJZbdmU5CnQ1a5aJ63ZVTVgyibIkDbtr6kI8JU/agde/1lFFVFHH6AiEiyVdlP8uDek1wHu+kjk1vbtks6u9k8N90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035464; c=relaxed/simple;
	bh=RAs/ODZf9lNtL7tDMWqAQIEDqlAB/GJFATQxac1YBmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fm2Dn1N0NW60UrCSkx/FAW5yvdq7S+pyAkLzZjvuabrvWT5K1ig1MEm/nm0S8okBFEOhFcskFgi4Zxt2BT7/XLyOQC8opEoriyax0nfMz53X7cNPXozi8Tn64tpdDXotWbxBWuJREARWXO1CisgLbHrF0PxH310ufRj4ezjWQRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yaHwTalB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-212581a0b33so8526185ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732035461; x=1732640261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIM5C3U9SgKHG2ejtKJVceWgRiY5n+HYVGt81nCAm3w=;
        b=yaHwTalB1xk7kcpnKQ5nS0i8r/wh/R/zD03EaSMDZsY1a7KQZivP86WppUayFSJ03Z
         kVpAfEGJmG2JRGqh+g1IRv1og4cdWTXavZcwQ7N+1lnh3YEVMdnvUOz39uxOE8RSNcPo
         kmnuiemkJ+2/lMm7+sGpEXmiTdyzFlmOR/8Mwv6SawI8D9Vee0Ltxwq0K15HxnNQUSyP
         AtABpmhqV0NN71me1AM1Nj3MLVOKv60kVQynwu4P0F8S0jNVoD3fGxAf12kPTB1tgFNM
         OOA6r3K8X3gyQP9jKXjiedjjc3DpS4ybvJ8ZWJm9+6Yy87tsWrpA4AMLlfkxMYy4otm4
         Ug0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732035461; x=1732640261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIM5C3U9SgKHG2ejtKJVceWgRiY5n+HYVGt81nCAm3w=;
        b=mU6rmDd8AdXV4ifNEPim6xK5NvTSFT7igwfdo/dHiML9RhlxKdl/hvJA3nx7P0Rn7I
         ygZQi2Kn+HUqIT5rjGMlhE/JPPnWX/hwVdArief4ErsGiusnBe1wP55ebZgD8HrB4H/E
         bBmkTApPFjExBs5bi4s0tc61cfywXXXc3htYmlUQIg7TjGp5VSezv7hKOhSdS5kumnoB
         PaqRxT1BqmZXoQW1VGe64sOc+/bJTDaw4Zk869EzMZSOEsXZTQSoWjlA6FwngoJERm2p
         UssedI/7HuZYs3UuxAT7zGt3ga/3d8LOwwE/XrFSEO2R0IBCfpPdTjbLsnKaCZzIaur0
         SPxA==
X-Gm-Message-State: AOJu0Yx6npD5gf/8HM/jWh11AnCiE9d8p7lNiqiUTk/QHUSbHqCYORSm
	YKfvKyV9JUAqhshwC6z4YLeHPt2DY+BQvZQlANZ9e7+CRN2Wm4rPK5DTWpUq8w0=
X-Google-Smtp-Source: AGHT+IG4kkUTi/c5CZ92Iiptcoo64JT2r4oVJmh+qSFIGjvkOyirSO0mJ0D9m90WudNodnVcPjFy/w==
X-Received: by 2002:a17:903:946:b0:212:4cfa:ba78 with SMTP id d9443c01a7336-2124cfabbfbmr49230275ad.52.1732035460759;
        Tue, 19 Nov 2024 08:57:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f346cbsm77340865ad.118.2024.11.19.08.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 08:57:40 -0800 (PST)
Message-ID: <ffcdbcbe-a5f6-48f4-a0a3-0d35c6c80050@rivosinc.com>
Date: Tue, 19 Nov 2024 17:57:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: fix memory leakage in
 process_accumulated_relocations
To: zhangkai@iscas.ac.cn, Walmsley <paul.walmsley@sifive.com>,
 Dabbelt <palmer@dabbelt.com>, Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <35cab46a.6d145.19334919ed0.Coremail.zhangkai@iscas.ac.cn>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <35cab46a.6d145.19334919ed0.Coremail.zhangkai@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 16/11/2024 11:42, zhangkai@iscas.ac.cn wrote:
> When module relocation is done, process_accumulated_relocations()
> frees all dynamic allocated memory. rel_head_iter-&gt;rel_entry is
> missed to free that kmemleak might report:
> 
> unreferenced object 0xffffffd880c5fc40 (size 16):
>   comm "insmod", pid 1101, jiffies 4295045138
>   hex dump (first 16 bytes):
>     e0 c0 f5 87 d8 ff ff ff 60 c5 f5 87 d8 ff ff ff  ........`.......
>   backtrace (crc d2ecb20c):
>     [&lt;00000000b01655f6&gt;] kmalloc_trace_noprof+0x268/0x2f6
>     [&lt;000000006dc0067a&gt;] add_relocation_to_accumulate.constprop.0+0xf2/0x1aa
>     [&lt;00000000e1b29a36&gt;] apply_relocate_add+0x13c/0x36e
>     [&lt;000000007543f1fb&gt;] load_module+0x5c6/0x83e
>     [&lt;00000000abce12e8&gt;] init_module_from_file+0x74/0xaa
>     [&lt;0000000049413e3d&gt;] idempotent_init_module+0x116/0x22e
>     [&lt;00000000f9b98b85&gt;] __riscv_sys_finit_module+0x62/0xae
> 
> Signed-off-by: Kai Zhang <zhangkai@iscas.ac.cn>
> ---
>  arch/riscv/kernel/module.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 1cd461f3d87..f8c3c4b47dc 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -643,6 +643,7 @@ process_accumulated_relocations(struct module *me,
>                         }
>                         reloc_handlers[curr_type].accumulate_handler(
>                                 me, location, buffer);
> +                       kfree(rel_head_iter-&gt;rel_entry);

Hey Kai,

Your patch output is messed up probably due to some encoding issue.

But looknig at it and the module code, it seems like rel_entry does not
need to be a pointer. It can be a plain "struct list_head rel_entry" and
then simply pass the list_head pointer rather than allocating/freeing
it. That remove an allocation as well as some memory leak.

BTW, for fixes, you should add a Fixes: tag with the original commit
sha1 that introduced the bug.

Thanks,

Clément

>                         kfree(rel_head_iter);
>                 }
>                 kfree(bucket_iter);


