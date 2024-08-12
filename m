Return-Path: <linux-kernel+bounces-283891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C8F94FA07
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70DE1F261A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81519AD87;
	Mon, 12 Aug 2024 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JRiGf4B4"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BEE199EAF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502966; cv=none; b=jSYvfgYD+uR7h8dPRM8NU5f3rCkopS1EOHIM6elq3toEmm36WP6oU9jpU4y4JNPmej59lXxO57izoEdoY9dCzZhiMrGNv8HlDyMoiZSI3EaGxP8iDQmDqXSqCx58pTDCqMo5fPMbDP6keIC1INeYtCIDvwWkYKS5ZHJU0PvrfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502966; c=relaxed/simple;
	bh=9Geqm2eNxfmbidfN12t9YGa4gHMoM08dePXkh4q5E6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VSL5PWi1/OAo81RrVXXyvsanbAv8ySzh/HcMsdxnDoeG5G3wc13CaYLtXCx4zxJUU2vhz9IZMJQ2mSgTr/JtS9tX2aXpVCaeMLi98RZ9ix0yLvC2HnJhq/Qq9XMgE+jGweoN8yA1Lq9HCZYXk0hNdqLytCyu9kW8rDuG49VP7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JRiGf4B4; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25075f3f472so971341fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723502963; x=1724107763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XpPGGocSzCpr41jGcOS4ZmlxuyG1JeA+rONg3hfVGdQ=;
        b=JRiGf4B4yPSFv3ylNTnQtCI2j/ebC2Dd8QdHhOacNsYf+s/MooheS3EHdQtQOGT7gZ
         +9OM8BFQ/4KhLxFzeDsfqnwvdZxhUbHsIoMgn5MCegt8jdJlHrpsBx6PFT7FEcezx5Z+
         bo/5QKD8ovrITQITp0CdnAix96PG4dqkvrABU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723502963; x=1724107763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpPGGocSzCpr41jGcOS4ZmlxuyG1JeA+rONg3hfVGdQ=;
        b=kgbG3DcMI8VlNUBNr3IkRnIx2OtBDqvPYAk0R7Jb1DtYCAVipXZeGrn6We9K1CuMCw
         qCZxZMkggH80kjULxR2pTVd6Y0rGTijAgxkpmOjzKkz4ZBG0ftJ8xGsQyhWh/rRIKo83
         ZYGKfSfGA770CDxwGJ4PYFlQM62Ja8UIr0fp7OkkLo+sYgsNgeDN5TYr08HuKm9MyLHI
         DcNCYVgnhHvGhG/bOqcmV3hiol3Bqtis9vN2UuAzvyC0ogUBXEQilh0K7vEioKvmSSbk
         DWgdutM0QzCwDUCIo05Vjij5qsWHy+lpie/iVNtcrMdwUVsHQ/5vY2NiABISaGMQ/Ti8
         DG9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB/L6kTelNiR2LpRC619STzgLrwS926/2wip7zyuPLxC9cxcvWXgaHtlJRjohSIC7RLLCny3fxKQcLgbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq1JD3oxepTreBkWCnaM8hTMAWY47Xx+dO8KF/WtxlAG89fNpb
	YinYFgYgnyF9pt/J1hrIzo/PdriaFsofRLfkmNfbY5xyjky7KXRJogy0g2nY6n0XMsimp3amw5n
	g
X-Google-Smtp-Source: AGHT+IHe6d83/UlNNb5pR/cHNVG5k9VCD20VevZVPPNM/u/kk8qnB+ep1qft2HW7dn9dzzqG3dovRQ==
X-Received: by 2002:a05:6871:5811:b0:260:eb27:1b83 with SMTP id 586e51a60fabf-26fd1af54a1mr259422fac.5.1723502963190;
        Mon, 12 Aug 2024 15:49:23 -0700 (PDT)
Received: from [10.229.70.3] (p525182-ipngn902koufu.yamanashi.ocn.ne.jp. [61.207.159.182])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979d3d6fsm164651a12.1.2024.08.12.15.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 15:49:22 -0700 (PDT)
Message-ID: <4072bf51-1d37-4595-a2fa-b72f83c8298b@linuxfoundation.org>
Date: Mon, 12 Aug 2024 16:49:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: resctrl: ignore builds for unsupported
 architectures
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Muhammad Usama Anjum <Usama.Anjum@collabora.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, kernel@collabora.com,
 LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240809071059.265914-1-usama.anjum@collabora.com>
 <d60cf782-9ab0-ed4a-0b3e-ba7a73ae8d51@linux.intel.com>
 <080c4692-c53c-417f-9975-0b4ced0b044c@collabora.com>
 <f7593344-203a-8e73-d53e-574ca511d003@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f7593344-203a-8e73-d53e-574ca511d003@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/9/24 02:45, Ilpo Järvinen wrote:
> Adding Maciej.
> 
> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
>> On 8/9/24 12:23 PM, Ilpo Järvinen wrote:
>>> On Fri, 9 Aug 2024, Muhammad Usama Anjum wrote:
>>>
>>>> This test doesn't have support for other architectures. Altough resctrl
>>>> is supported on x86 and ARM, but arch_supports_noncont_cat() shows that
>>>> only x86 for AMD and Intel are supported by the test.
>>>
>>> One does not follow from the other. arch_supports_noncont_cat() is only
>>> small part of the tests so saying "This test" based on a small subset of
>>> all tests is bogus. Also, I don't see any reason why ARCH_ARM could not be
>>> added and arch_supports_noncont_cat() adapted accordingly.
>> I'm not familiar with resctrl and the architectural part of it. Feel
>> free to fix it and ignore this patch.
>>
>> If more things are missing than just adjusting
>> arch_supports_noncont_cat(), the test should be turned off until proper
>> support is added to the test.
>>
>>>> We get build
>>>> errors when built for ARM and ARM64.
>>>
>>> As this seems the real reason, please quote any errors when you use them
>>> as justification so it can be reviewed if the reasoning is sound or not.
>>
>>    CC       resctrl_tests
>> In file included from resctrl.h:24,
>>                   from cat_test.c:11:
>> In function 'arch_supports_noncont_cat',
>>      inlined from 'noncont_cat_run_test' at cat_test.c:323:6:
>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"
>>         \
>>        |         ^~~~~~~
>> cat_test.c:301:17: note: in expansion of macro '__cpuid_count'
>>    301 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>>        |                 ^~~~~~~~~~~~~
>> ../kselftest.h:74:9: error: impossible constraint in 'asm'
>>     74 |         __asm__ __volatile__ ("cpuid\n\t"
>>         \
>>        |         ^~~~~~~
>> cat_test.c:303:17: note: in expansion of macro '__cpuid_count'
>>    303 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>>        |                 ^~~~~~~~~~~~~
> 
> Okay, so it's specific to lack of CPUID. This seems a kselftest common
> level problem to me, since __cpuid_count() is provided in kselftest.h.
> 
> Shuah (or others), what is the intended mechanism for selftests to know if
> it can be used or not since as is, it's always defined?
_cpuid_count() gets defined in ksefltest.h if it can't find it.

As the comment says both gcc and cland probide __cpuid_count()

   gcc cpuid.h provides __cpuid_count() since v4.4.
   Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.

> 
> I see some Makefiles use compile testing a trivial program to decide whether
> they build some x86_64 tests or not. Is that what should be done here too,
> test if __cpuid_count() compiles or not (and then build some #ifdeffery
> based on the result of that compile testing)?
> 

These build errors need to be fixed instead of restricting the build.

In some cases when the test can't be supported on an architecture then it is okay
to suppress build. This is not a general solution to suppress build warnings

I would recommend against adding suppress build code when it can be fixed.

Let's investigate this problem to fix it properly. I don't see any arm and arm64
maintainers and developers on this thread. It would be good to investigate to
see if this can be fixed.

thanks,
-- Shuah

