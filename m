Return-Path: <linux-kernel+bounces-263677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3183E93D8FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A55B21455
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CFE4CB2B;
	Fri, 26 Jul 2024 19:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S8peiIIc"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A13BBF4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022504; cv=none; b=PesEbCFh5eZl12GJ2XGVJRIQTUH/SNMzS7FBVNvTh4VEEtdQHamhJ7DbxiD5B59zHXktF24aYsAP/2zfZmXcSL+y2OsSgQh4DngVvuPismMzmeeb+g7oLfchPIppn9EvCrWeEUoeFTyqO/SntvYZ23X/6FGuf4ZDUtZR6ZPKjoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022504; c=relaxed/simple;
	bh=24jLkCF+CBq9uB6ATrQWCbHLtjoiCw3tZ5O0cb9KmXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/7E3r8arBpP+WPKPwpZOMg/rc8bicCsqmXKm19Sy2rd6CTBQJHmctWw2TB2Zl0oxL27y15h1YO3CpmNwTdMA1Bm7OfDcrvOg/Pox40OBzpO2P71O1tyDQklFjy9Cyx2BFlVoKd6lisW3M8IJ/5KPIMIoVaFz5pkazumn8D0ifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S8peiIIc; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81f8ac6b908so8917639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722022502; x=1722627302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGSqip6SjsIuRJdlh5NYKeJ/7a5iCVukcKeNYY8a5hc=;
        b=S8peiIIclt4jp/kL5qlPq/3RV4Yh0mtRsrvwxLu41lV5p8kyS2o+bVy120RgpqUccQ
         zJlhFgO0WarVa4JJW4P8WtZ4ml84Wi64L+rqnpJD+L9F54U50cTR+JH8Bqi+f7iSRAMk
         Zzv+9Tign16j01VICQbQa6q2bYb9OU7tbLSDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022502; x=1722627302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGSqip6SjsIuRJdlh5NYKeJ/7a5iCVukcKeNYY8a5hc=;
        b=FqpkOXjOSYgLrh3/tUQe0KBiVT/FhkDn/q18H8Zkt3O0CF+P/8WL6U+I6ZmduOFP1+
         ADPoQJ68HZGYuoE08n2y0f4d/qiVqBYH8Af8QT6OV+wn/Nf+5KOWCcCON1pI/xCCOXyg
         xEEQieqbjT7E4UZ3QYebDFvAKOnS7+8g6lX8NjVXGyRWNmf3QNOAYJGTgxJU6Tdjdg4m
         U5TlERJwM3h2YKC1f8O/IBJIix2SNrRpypNIJAcAQjXWobYk61wd5VOkXosWcHUozbHm
         us0fkKdjPoJYAfXrB2+KgdtdSIDV0thAgAYlJZ2Ztd+1lFx8iTQFHKtmFahg97/TymTK
         739A==
X-Forwarded-Encrypted: i=1; AJvYcCX29R3Reje9TREN/DxCvI2y56MEsX0DrhWPhNVwB+2vHJwM/CsNlXlHblh2TsszMc59Kl76fK5t/4exem4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOAjlHac7M+kqKuAEqhpBI/WBDDMIBqwqpUWnzfBdQU+EXME3q
	92fjL1NwYiYbFnbvD50AoWA8iEWOBaMWIpcSbeJCcn7KEYZQE9olcufwbezLTlY=
X-Google-Smtp-Source: AGHT+IH/5nnM/8R4mp4A6vXNaHfd2PfinlE5+3dCX0BOyjbWuhQ/mMRdAGmkZdUOkBPoAVRhSH2U4A==
X-Received: by 2002:a05:6602:4f88:b0:81f:8295:fec5 with SMTP id ca18e2360f4ac-81f82a54258mr391577139f.1.1722022502313;
        Fri, 26 Jul 2024 12:35:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fa43dc5sm984760173.21.2024.07.26.12.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 12:35:01 -0700 (PDT)
Message-ID: <533826b3-8bc4-40f8-a491-5bb5614469c3@linuxfoundation.org>
Date: Fri, 26 Jul 2024 13:35:01 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting kselftest test modules to kunit
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
 davidgow@google.com
Cc: "open list : KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 kunit-dev@googlegroups.com, "kernel@collabora.com" <kernel@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/24 04:09, Muhammad Usama Anjum wrote:
> Hi Kees and All,
> 
> There are several tests in kselftest subsystem which load modules to tests
> the internals of the kernel. Most of these test modules are just loaded by
> the kselftest, their status isn't read and reported to the user logs. Hence
> they don't provide benefit of executing those tests.
> 
> I've found patches from Kees where he has been converting such kselftests
> to kunit tests [1]. The probable motivation is to move tests output of
> kselftest subsystem which only triggers tests without correctly reporting
> the results. On the other hand, kunit is there to test the kernel's
> internal functions which can't be done by userspace.
> 
> Kselftest:	Test user facing APIs from userspace
> Kunit:		Test kernel's internal functions from kernelspace
> 
> This brings me to conclusion that kselftest which are loading modules to
> test kernelspace should be converted to kunit tests. I've noted several
> such kselftests.
> 
> This is just my understanding. Please mention if I'm correct above or more
> reasons to support kselftest test modules transformation into kunit test.
> 
> [1] https://lore.kernel.org/all/20221018082824.never.845-kees@kernel.org/
> 

Please make sure you aren't taking away the ability to run these tests during
boot. It doesn't make sense to convert every single test especially when it
is intended to be run during boot without dependencies - not as a kunit test
but a regression test during boot.

bitmap is one example - pay attention to the config help test - bitmap
one clearly states it runs regression testing during boot. Any test that
says that isn't a candidate for conversion.

I am going to nack any such conversions.

thanks,
-- Shuah

