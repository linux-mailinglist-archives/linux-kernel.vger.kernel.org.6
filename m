Return-Path: <linux-kernel+bounces-243603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873DA929851
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4C228163E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 14:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C52A249ED;
	Sun,  7 Jul 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJvLaU02"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873BD22612
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720361386; cv=none; b=nTasSR+9UlPplU81DopkvCJHvThxPtdAv0mBHpo4fyrnTC8+0MV8zwXch30xa5F/4aXzGndQL0CwE7rlhml4BhNKw868HhNhWfmti0jnL3Cj1yPqxxLua9Qsi7tKDNLPfx9bX35orFXyXtuWqJTksgkQhG6y4/BlQQ/RKDMTczM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720361386; c=relaxed/simple;
	bh=6BthhZFCOm4WRciB8xCCd8ulQRYGqLpS9VKFMi+fEig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVod9IbkBljaNmPG3gj63MC2QhzybtgHYLdkZlwz72uQx67U+LlLh0L54H4fZPkRZHYFonrBwDsch9TYI2fTysGo3JdekNm8YfBIFpEKiYV7TBfW3Bvc8xZiVvX4k1DYU/Ff1Fp7D1dO6BiYdZK/PVRPP2resiOOskhj/Nfbr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJvLaU02; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77af4cd570so181469266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720361383; x=1720966183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9ZekFg0P3GM8MHpqFlzQHu8Ld3um8orszUxX9Yi27k=;
        b=NJvLaU02mBhRAt7fI52MsNtDz3QIxUxhSitBtLM4hzli4FbgdgEs+lyLhRmSCyuGi0
         m1hMmiEBoVipY2/Hni6Jwg07lnm03gUaz3idvkyVCrE1bnIbsgwnt/gANUjx3MV1vjyc
         yxA9Z/Vk0u9cOSEJUK4ISI8b845qvfgEVfcT+JY3TaMXaK+T0gqktyGb4Q+jG/ZQ5NxN
         x5lpgGF3dKnIgB7VOdXRYq1MnTTFZJUgR4zKpkWURtMVeW2wZcVybU7kf4OBaXs3PvNO
         JW6p2fOeokBMsATLWVCmMRmr8duYLP8XB7vX988AU7/dgSFNtAdvwbjlTWUuSo3h/fNI
         NQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720361383; x=1720966183;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W9ZekFg0P3GM8MHpqFlzQHu8Ld3um8orszUxX9Yi27k=;
        b=abKr6j3JuQOHlUDOAF2XiuSxIXcGJpDRTp70qbW+tjqbEEY6AvB2aICbh6XblFqTlJ
         jaufMIOGgMVMhYYiFuDvBXcTapmfVG1uGSZ6mkc457OYZ0QooQa/x4SmLQg/4bkbFTID
         XhfWwz+8FhzHjtwjw91vnr4AUq3D65fWKT4057X2iHxu9Q93gHHhBipOZQ4JFQh/pprf
         tra4ToaARmLpNMa72CjaZgi9qs6IT54avMad3RIn7dgEhP22as4ld29WcLjyWkQtIt6l
         QrqQSswanHc4Fc0pSeUIFJ6qPq8WWbsYSk4VfnqJs5XXNJS05d9K+RzkDk1ai6tySQ8a
         8C4g==
X-Forwarded-Encrypted: i=1; AJvYcCWMJHmkFeInl9YC7vo8Nhdfp9xVM85fp67CwmvmxiJfE++KAK4wXEwzmTrAXzIIuqvJdH2f8yd7RTmTIwfs8ub1iJoWHOToaFgP8hAK
X-Gm-Message-State: AOJu0YwjUEp4mmVKh5wqb/3JGX1OSSw/E+qIs5fADjP/a8tuy4v0NK+q
	Mj+Zf9FWSMuLWVyPdHPZxPnDd/9HJWRIBt74GFK6kIu2OVNs1vBN
X-Google-Smtp-Source: AGHT+IHnKVoMwg2WNbrh/UEoUMzdUm208qNxBURO6gjT09IeRByg0iHpbDppLtHHTfUDSlNargGf5w==
X-Received: by 2002:a05:6402:3590:b0:57c:5874:4f5c with SMTP id 4fb4d7f45d1cf-58e5b898d67mr8749965a12.32.1720361382518;
        Sun, 07 Jul 2024 07:09:42 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-28.xnet.hr. [88.207.40.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5861381868csm11712149a12.55.2024.07.07.07.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 07:09:42 -0700 (PDT)
Message-ID: <f9818a25-0604-49a8-af06-3dc7de006377@gmail.com>
Date: Sun, 7 Jul 2024 16:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM linux-next]
To: Jonas Gorski <jonas.gorski@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
Cc: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <47e0483d-6e3d-43a8-9273-25278a4a74b9@gmail.com>
 <0c095098-4b3e-481b-b866-29cacb9f165d@milecki.pl>
 <CAOiHx=nmcf1mRy_i9vUDNtqOZTQ=PFWY8MGEV1FZfgt=GHqj5A@mail.gmail.com>
Content-Language: en-US
From: Mirsad Todorovac <mtodorovac69@gmail.com>
In-Reply-To: <CAOiHx=nmcf1mRy_i9vUDNtqOZTQ=PFWY8MGEV1FZfgt=GHqj5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/7/24 10:12, Jonas Gorski wrote:
> On Sun, 7 Jul 2024 at 09:38, Rafał Miłecki <rafal@milecki.pl> wrote:
>>
>> Some more descriptive subject would be nice :)
>>
>>
>> On 7.07.2024 02:10, Mirsad Todorovac wrote:
>>> In file included from ./include/asm-generic/bug.h:22,
>>>                   from ./arch/x86/include/asm/bug.h:87,
>>>                   from ./include/linux/bug.h:5,
>>>                   from ./include/linux/fortify-string.h:6,
>>>                   from ./include/linux/string.h:374,
>>>                   from ./arch/x86/include/asm/page_32.h:18,
>>>                   from ./arch/x86/include/asm/page.h:14,
>>>                   from ./arch/x86/include/asm/processor.h:20,
>>>                   from ./arch/x86/include/asm/timex.h:5,
>>>                   from ./include/linux/timex.h:67,
>>>                   from ./include/linux/time32.h:13,
>>>                   from ./include/linux/time.h:60,
>>>                   from ./include/linux/stat.h:19,
>>>                   from ./include/linux/module.h:13,
>>>                   from drivers/mtd/mtdpart.c:10:
>>> drivers/mtd/mtdpart.c: In function ‘parse_mtd_partitions’:
>>> drivers/mtd/mtdpart.c:693:34: error: ‘%s’ directive argument is null [-Werror=format-overflow=]
>>>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>>>        |                                  ^~~~~~~~~~~~~~~~~~~~~
>>> ./include/linux/printk.h:376:21: note: in definition of macro ‘pr_fmt’
>>>    376 | #define pr_fmt(fmt) fmt
>>>        |                     ^~~
>>> ./include/linux/dynamic_debug.h:248:9: note: in expansion of macro ‘__dynamic_func_call_cls’
>>>    248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
>>>        |         ^~~~~~~~~~~~~~~~~~~~~~~
>>> ./include/linux/dynamic_debug.h:250:9: note: in expansion of macro ‘_dynamic_func_call_cls’
>>>    250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>>>        |         ^~~~~~~~~~~~~~~~~~~~~~
>>> ./include/linux/dynamic_debug.h:269:9: note: in expansion of macro ‘_dynamic_func_call’
>>>    269 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
>>>        |         ^~~~~~~~~~~~~~~~~~
>>> ./include/linux/printk.h:610:9: note: in expansion of macro ‘dynamic_pr_debug’
>>>    610 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>>>        |         ^~~~~~~~~~~~~~~~
>>> drivers/mtd/mtdpart.c:693:25: note: in expansion of macro ‘pr_debug’
>>>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>>>        |                         ^~~~~~~~
>>> drivers/mtd/mtdpart.c:693:50: note: format string is defined here
>>>    693 |                         pr_debug("%s: got parser %s\n", master->name,
>>>        |                                                  ^~
>>>
>>> Offending commit is 5b644aa012f67.
>>
>> Actually it goes back to 2015 to the commit 8e2c992b59fc ("mtd: mtdpart: add debug prints to partition parser.").
>>
>>
>>> Proposed non-intrusive fix resolves the warning/error, but I could not test the code.
>>> (I don't have the physical device.)
>>>
>>> -----------------><------------------------------------------
>>> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
>>> index 6811a714349d..81665d67ed2d 100644
>>> --- a/drivers/mtd/mtdpart.c
>>> +++ b/drivers/mtd/mtdpart.c
>>> @@ -691,7 +691,7 @@ int parse_mtd_partitions(struct mtd_info *master, const char *const *types,
>>>                          if (!parser && !request_module("%s", *types))
>>>                                  parser = mtd_part_parser_get(*types);
>>>                          pr_debug("%s: got parser %s\n", master->name,
>>> -                               parser ? parser->name : NULL);
>>> +                               parser ? parser->name : "(null"));
>>>                          if (!parser)
>>>                                  continue;
>>>                          ret = mtd_part_do_parse(parser, master, &pparts, data);
>>>
>>>
>>> Hope this helps.
>>
>> I'd say it's simple enough to send patch without actual hw testing.
> 
> Though the kernel's vsprintf will already handle NULL pointers and
> print "(null)" [1], so I'm not sure if this is an actual improvement.
> 
> The only way this can be NULL though is if the request_module()
> failed, so maybe a proper error message would be better here instead
> of an obscure "got parser (null)". You don't even know which type
> wasn't available. E.g. pr_debug("%: no parser for type %s
> available\n", master->name, *types).

Agreed. Your proposal is much more descriptive.

Will you do this patch or should I and put a Suggested-by: ?

However, I would sleep much better if this is tested on actual hw. :-/

Best regards,
Mirsad Todorovac

> [1] https://elixir.bootlin.com/linux/latest/source/lib/vsprintf.c#L696
> 
> Best Regards,
> Jonas

