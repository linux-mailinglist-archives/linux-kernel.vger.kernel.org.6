Return-Path: <linux-kernel+bounces-373369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D709A55E9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C41F219C3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EB194C7D;
	Sun, 20 Oct 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCEmvE6v"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED4193078
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729450030; cv=none; b=uW0dqTzH8EqNF0xc7DXKdS4xveho1o9MAtdv5GUR0eLRUPO2B3Ud8x9JMEirdoKBUA6DPK9mUahnEkZ+xjzb6OiuRTx4M3lGiMQy9duP00ki1qmz+lfJ7txsf7akf/dSWhVdX6CsoWVJzSVG77pPGjnhvx7fvtMjd5+Aqq2Vh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729450030; c=relaxed/simple;
	bh=yDVmUcOPsK+6r2MNKdv1fLvgP/RzdstYd7n1r8wYqEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YytspaQcfdduq0mHF8oIBk37z/4TOw0EEGK7iUVoBXOOu7M9t55Do3OSEe75qCZb3EHAu1U7xKrivmGrZXxSq2Dqe1xXqwNspWALrsPZQcCCZcdeuNiTFLWJTo+qmc/4EZ+pqx26ih1uDcQjBBSj7z+Ku3BLWqbCmA34CDMyPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCEmvE6v; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e4e481692so3158875b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729450027; x=1730054827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0rgne+RllSD4dCojokc08O6fyLjqxPDouNOsGVSJrE=;
        b=mCEmvE6vy/OUqQKLnz43dAqf13dyiUkBEX39lwIV5X3U3OxdMDKwKJkjmyIkBmkf68
         B1/jwoFPMn9/2IFHjNOj9XzUcRXa/qPmK1s/9e7pjRHiZgMwxTPcGGUWEtfEFVUF6a3e
         OxCTWEPtWj8gbuULQl6tgOJyR0J60ezxTixiEPEmah6WxQsGV6qoi0jhmaZo80D7pHD8
         S2+mzhKnExuJkR18p9c9WVfutqJI2KwMc2viHTcdrUU2WVDLQ4nYxltj7DRXhh0iFTfb
         7OEfUtAebMNCWK5Os6Sskx60pHfGGarbFTI+lJiBgNuKJ63mRb1YtWYsEXxvwv4F25+K
         ogBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729450027; x=1730054827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0rgne+RllSD4dCojokc08O6fyLjqxPDouNOsGVSJrE=;
        b=J41VMlr9cqVOxTmI4rsZY6lzbfLmFtEasVwT8WGSOnR6cDOg8pb4Z2D0m9yvE5XUNt
         C+/HLwR1JKCAm8jkb8D/+Ofs+NJZQyEkssM35URykXgpBrHEC68Ea3V2i6+hATD63dl8
         De5kT3ivMk0t+da15DMh79Q9uN3wQX1S55n8m95KBf5ke/2cy5s7XRmyhhvRdzhmyOlg
         gTU2ZNdeFy3Ysj7ve71c+AP/MClLCnbL404UMTT2FYZIQvxibkB2tQ3VdnV1tPBtYuvb
         orq11LXJzSYl64Jy6JEfvFpsYTXbNqoCGBLDFbiscdwqKzSjZbC68FmXGNMDKN0BQAAh
         djHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRkZtii5CPLy/p0clye15/ahOiD+yOlfUvrrdur9DKIaeB6NHx+RPdStj8Fl4X+mzl48ZwzQzAScLw3bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkyN6KJflYwED0wY/1mUxrOrFXdtMUgi1vzARoItrxXRe2YeV9
	hTVglOlbHBLjbyoZLVjytTPusimHXokLC7YBJUcw0gR+GEUdQuGIYHnS2dE1CPo=
X-Google-Smtp-Source: AGHT+IEKJ2tZYebKlsmIfal4MlXfWP2VdJ72brsGz4X8tn78fB0n6xx0/1+LKeIcGrc9RV2fJRuazQ==
X-Received: by 2002:a05:6a00:140c:b0:71e:cd0:cc99 with SMTP id d2e1a72fcca58-71ea31a57famr13485118b3a.4.1729450027298;
        Sun, 20 Oct 2024 11:47:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407da1sm1443694b3a.191.2024.10.20.11.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 11:47:06 -0700 (PDT)
Message-ID: <9aa82e51-8330-4be1-89ea-bcfadcecea29@linaro.org>
Date: Sun, 20 Oct 2024 11:47:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org, Linux Regressions
 <regressions@lists.linux.dev>, qemu-devel@nongnu.org
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Aishwarya TCV <Aishwarya.TCV@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
 <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/24 10:39, Naresh Kamboju wrote:
> On Fri, 18 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
>> The boot log is incomplete, and no kernel crash was detected.
>> However, the system did not proceed far enough to reach the login prompt.
>>
>> Please find the incomplete boot log links below for your reference.
>> The Qemu version is 9.0.2.
>> The arm devices TI beaglebone x15 boot pass.
>>
>> This is always reproducible.
>> First seen on Linux next-20241017 tag.
>>    Good: next-20241016
>>    Bad: next-20241017
>>
>> qemu-armv7:
>>    boot:
>>      * clang-19-lkftconfig
>>      * gcc-13-lkftconfig
>>      * clang-nightly-lkftconfig
> 
> Anders bisected this boot regressions and found,
> # first bad commit:
>    [efe8419ae78d65e83edc31aad74b605c12e7d60c]
>      vdso: Introduce vdso/page.h
> 
> We are investigating the reason for boot failure due to this commit.

Probably fixed on qemu master with

commit 67d762e716a7127ecc114e9708254316dd521911
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Fri Sep 27 09:10:51 2024 +0200

     target/arm: Avoid target_ulong for physical address lookups



r~

