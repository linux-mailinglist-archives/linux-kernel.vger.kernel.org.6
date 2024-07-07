Return-Path: <linux-kernel+bounces-243584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED6E929806
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 15:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C88C1C21060
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 13:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790B81F951;
	Sun,  7 Jul 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z28cd61F"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A87225CE
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720357565; cv=none; b=Im9BhTpO8ILKoihu3Vzkc5uitLuTMeuDpoD/bQDFJymKCq7GCekGAU/3zXi3GSRPCWGCRNip1eqnOR2a5zR3C46kclUggbQTg0BXoFb2+TuR80L+8q0NVv2yw4At77VMi1sK/Pfbyk9UfFFZJkFGYDVoH6h8oIKwdS5HJjTCcOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720357565; c=relaxed/simple;
	bh=pjkPc76vsbbz7ZNjLhQVITRyuYtH8dUTAz1WPrrLZIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pe2IFWK1dJhP6J906PERFuB39IknBUZoSScLjpbj1TVksYeqZOB6kKbAAxOW2lrKuXnt2D78PECvV+D0zPEv3ZKC+Pas10L2HeXq8j8nO6sLR1RoM84L0WR2wmWbjvweLklqGzaW/nFKVP/D3iV/gSgy9T3IajoHMmd4GvrYqdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z28cd61F; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea79e689eso2730553e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720357562; x=1720962362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlaWWgvhWy86HoNyxyxMrimJ+nnuKBX5wNNRa2VfaRM=;
        b=Z28cd61FdaCR/nGY/IfiA6DRHRY3ESwz0b2FSNHo2jY62ji9Z+ZptfEelUK5ZdNPQI
         PaRld1mT/honNiqkjjiRNhRshgaFH0ib+vMmuSrQIGVOqzEYRZWJ223kwdb/0CkL7DUC
         vZTBJCYl4pzM83ReGfbZezMFUmkWAuKmnrENuU2yNJIUstb+De6iFsixN1oJidXzBHPX
         fnkUGYklxWT96rfr4N9nlDzIdMrSZgKjsAf4I0MmN9aueOq4hZ9oPWWCEElrojhrL5vi
         jvheOdK7tRlwYovHRZeSXps3ut7110W+JUhby9JqFqGtR2q671hR26X64KQqTrWP8s2w
         AZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720357562; x=1720962362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlaWWgvhWy86HoNyxyxMrimJ+nnuKBX5wNNRa2VfaRM=;
        b=PWxmrrRXFPOgTZi4CfxFYkmwaUps4X1PY/VfjGyDbTgQhSp/dEmG+KXFnZ2OFTuOPk
         v++czKbCrI89Of/kXRfhbprelJlGWg2NUtue8k1rZSzaMG+asEPJ1HRxMsEOEwTeWGcW
         jVxWBCyE28tXTiUnWurJrNm0sQkFPTXDmnfRXLWR9F/dKGhiSOdqZ1CdSnBNAV56t64R
         NMDoBePtPPcKQMGdNBhByijUkmSxlLtppYiTugLvPaowgTPMreY8Ztd2HS7oPloqR0bi
         USiv3Uaf/GwmFZ6Z43BbPFQifqVgF9Cg7oWRbqf2EiL4WRqrz9r9BWeyOWITnndAbV6n
         DTYA==
X-Forwarded-Encrypted: i=1; AJvYcCUecaf9ziqAuKo2Py3dxvZXIlLs7uSA/lq4zCN2g7QYoZ5ysnjNLvZdXH/1x08oXO5RP2Y03NT/Ky9ogMdL8Sw49E5mI3dWA9XXr2Re
X-Gm-Message-State: AOJu0Yzve2Hzg2EsST8fo2HEYM1XchKi5mYrSWvIhZX+jJbIPA2N7U4i
	QQdOUa6ECHFRQfp14csnh5hplQuZyhJqUDfqdXnFokPaWOFv5KV2
X-Google-Smtp-Source: AGHT+IEVdYFuUpkKTKY4SQN/EFfsGHXUTrqtN0FlQdO7rRHyMqnVwDOmaXtETwFSbJE8+eDN3f0+bA==
X-Received: by 2002:a05:6512:485b:b0:52c:a5cc:27e7 with SMTP id 2adb3069b0e04-52ea06c902emr7451026e87.66.1720357561486;
        Sun, 07 Jul 2024 06:06:01 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-28.xnet.hr. [88.207.40.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77dfd03b3fsm151213166b.162.2024.07.07.06.06.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 06:06:00 -0700 (PDT)
Message-ID: <d58cee6a-156a-4d3c-b80e-a35bd27b4223@gmail.com>
Date: Sun, 7 Jul 2024 15:05:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPROBLEM_linux-next=5D_drivers/mtd/mtdpart=2Ec=3A?=
 =?UTF-8?B?NjkzOjM0OiBlcnJvcjog4oCYJXPigJkgZGlyZWN0aXZlIGFyZ3VtZW50IGlzIG51?=
 =?UTF-8?Q?ll?=
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 linux-mtd@lists.infradead.org
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <47e0483d-6e3d-43a8-9273-25278a4a74b9@gmail.com>
 <0c095098-4b3e-481b-b866-29cacb9f165d@milecki.pl>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <0c095098-4b3e-481b-b866-29cacb9f165d@milecki.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Rafał, others,

On 7/7/24 09:37, Rafał Miłecki wrote:
> Some more descriptive subject would be nice :)

I could have sworn I put it there, I wasn't intoxicated :-P

> On 7.07.2024 02:10, Mirsad Todorovac wrote:
>> In file included from ./include/asm-generic/bug.h:22,
>>                   from ./arch/x86/include/asm/bug.h:87,
>>                   from ./include/linux/bug.h:5,
>>                   from ./include/linux/fortify-string.h:6,
>>                   from ./include/linux/string.h:374,
>>                   from ./arch/x86/include/asm/page_32.h:18,
>>                   from ./arch/x86/include/asm/page.h:14,
>>                   from ./arch/x86/include/asm/processor.h:20,
>>                   from ./arch/x86/include/asm/timex.h:5,
>>                   from ./include/linux/timex.h:67,
>>                   from ./include/linux/time32.h:13,
>>                   from ./include/linux/time.h:60,
>>                   from ./include/linux/stat.h:19,
>>                   from ./include/linux/module.h:13,
>>                   from drivers/mtd/mtdpart.c:10:
>> drivers/mtd/mtdpart.c: In function ‘parse_mtd_partitions’:
>> drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
>>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>>        |                                  ^~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/printk.h:376:21: note: in definition of macro ‘pr_fmt’
>>    376 | #define pr_fmt(fmt) fmt
>>        |                     ^~~
>> ./include/linux/dynamic_debug.h:248:9: note: in expansion of macro ‘__dynamic_func_call_cls’
>>    248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
>>        |         ^~~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/dynamic_debug.h:250:9: note: in expansion of macro ‘_dynamic_func_call_cls’
>>    250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>>        |         ^~~~~~~~~~~~~~~~~~~~~~
>> ./include/linux/dynamic_debug.h:269:9: note: in expansion of macro ‘_dynamic_func_call’
>>    269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>>        |         ^~~~~~~~~~~~~~~~~~
>> ./include/linux/printk.h:610:9: note: in expansion of macro ‘dynamic_pr_debug’
>>    610 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>>        |         ^~~~~~~~~~~~~~~~
>> drivers/mtd/mtdpart.c:693:25: note: in expansion of macro ‘pr_debug’
>>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>>        |                         ^~~~~~~~
>> drivers/mtd/mtdpart.c:693:50: note: format string is defined here
>>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>>        |                                                  ^~
>>
>> Offending commit is 5b644aa012f67.
> 
> Actually it goes back to 2015 to the commit 8e2c992b59fc ("mtd: mtdpart: add debug prints to partition parser.").

This is also correct.

>> Proposed non-intrusive fix resolves the warning/error, but I could not test the code.
>> (I don't have the physical device.)
>>
>> -----------------><------------------------------------------
>> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
>> index 6811a714349d..81665d67ed2d 100644
>> --- a/drivers/mtd/mtdpart.c
>> +++ b/drivers/mtd/mtdpart.c
>> @@ -691,7 +691,7 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
>>                          if (!parser && !request_module("%s", *types))
>>                                  parser = mtd_part_parser_get(*types);
>>                          pr_debug("%s: got parser %s\n", master->name,
>> -                               parser ? parser->name : NULL);
>> +                               parser ? parser->name : "(null"));
>>                          if (!parser)
>>                                  continue;
>>                          ret = mtd_part_do_parse(parser, master, &pparts, data);
>>
>>
>> Hope this helps.
> 
> I'd say it's simple enough to send patch without actual hw testing.

Actually, it isn't simple enough to prevent a typo.

Here is the v2.

Do I have your Reviewed-by: or Acked-by: ?

Andy from Intel said that it has to be given explicitly.

------------------------------><-------------------------------------
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 6811a714349d..6f7e250ef710 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -691,7 +691,7 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
                        if (!parser && !request_module("%s", *types))
                                parser = mtd_part_parser_get(*types);
                        pr_debug("%s: got parser %s\n", master->name,
-                               parser ? parser->name : NULL);
+                               parser ? parser->name : "(null)");
                        if (!parser)
                                continue;
                        ret = mtd_part_do_parse(parser, master, &pparts, data);

--

Best regards,
Mirsad Todorovac

