Return-Path: <linux-kernel+bounces-551951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA521A57351
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4145E188454C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F084B23FC41;
	Fri,  7 Mar 2025 21:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xp3loL53"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633F187346
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381532; cv=none; b=BRMBOL8NsOgmnty2LRz0BO0caamqGoELyNl+ok4Zl1mRQPEIJj3p4xUzYhRz+ZxZHaNen6VeuYaE4lyS3rhHQhnWxzrG10vMPHovuvAzzcSw2IqVDYj7xbgnzo73HJSZbY7Hg23OFA+RGZjaFPMoovXf8Og7KmlgtnA0PlswM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381532; c=relaxed/simple;
	bh=O86692gdpJBrLGAIyOg5k5Q/lBoaotVBJH2qLa+SvLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vCSBV3pruc18Oqn3k6VtZinM9a49XJ1L4IEz08BgtkA4rgZBqEn2HKQIIkpn5tmhBEc7KDuarKeVS32IgpJM8ZVmBD/wMJHxvBf4PfuAcJGHJevIF9+GTEWCCg7ut83oruWQhDkOpWCwPrG+yf/++OSSyg7ejp5Ax7KNQSrPUHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xp3loL53; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso800265e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 13:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741381529; x=1741986329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eh/eSkvEhMuR9LFURDFTZyMNRdILZ8HJGeVMKDceQY8=;
        b=xp3loL53BFsItByO3/M1mohTJ7jKk0fdIMRaJQAFvmK3zA1gSjCTJ7J6Gi5pvN47g7
         f1L2sUnI2GU7+Se11fx21GgpPfzRmjLdbIAge+e5Ot+WA7j+3YlGWQJZT3mcJYjgazG7
         bHgyv9GZi43T2oLjQ540oug7QzL8a0B1a2QhDzsNq+338Q1FihgXV1j3tLTDkKvAEpbn
         s9Kon766q2CmahMdED5f7cnaxwOABT/+GafUeNQiaRKVpcnuZymhwLMhbWh5cw9wnOgG
         okMPFuwdPzqH2TVKh/IDIq6Vvlu2Lnqhm965SKbf2HICsUQ389z4Ym+A2jQm2O8NIwv9
         viJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741381529; x=1741986329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh/eSkvEhMuR9LFURDFTZyMNRdILZ8HJGeVMKDceQY8=;
        b=ApIBAT/Qb+VVhphBQ3HSD5l7wBTt7GFqwm6Ed8/3GZuR7l5P3Xi/8RD6tvtz4jqrDE
         cU21Jl9pnCZA+APgGMxLauTp4iKMj/bDkt5Y8cnjSrlu2MiyIEN1KselTTrZCTnHQ30T
         7H+Q9A5+buTJ2sJQ64igyqfi2WSvf25goNRPvRSJx1n+kydcWplaa53jKq+rjmYqNOo/
         ZmDfLuFFAvWSNDUaYgTcqQHbK0tbj8id4i0dAuVKTXcr4+kyzXBwlwHJixSvqy5+aUoe
         QeuMke1UZUMQwq45OTpjzRFTzvVQ3HFkJoKLHp3nkM4AU9jcg4xTspyO+8hdyx2XXsqf
         KoCg==
X-Forwarded-Encrypted: i=1; AJvYcCUFRkZhI2s9me/lcB0XUeEtpSMis4SmhNHzNN2R4HZVZXBUqWw5sO0jPXoMBUrGtxp38vFOqvbbIjkDcQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yqhH7lm3S6ZU1aAafNxT4Q6p5oBxPt06rLrIh6FpYxidJWIq
	Ep4qquUdKw6Z1I2eytlCgTDAQT8XtAc0wODd4md8sFzobo2SV1/NWdLAq7F+IAs=
X-Gm-Gg: ASbGncvCqSJwT8opWsYu0nolmsWVi9MaOiIvp6K22s3aZVGmAUs/UmQl5uBUwBRKzbE
	8YP6E5uK6KrkqBU23YIGsFcuMZTKou/isSrBrTI9fJRqgSuAheBqOeiCSSslqVy9v7astXauvDb
	oJ3ivNvcBt4ogNcGzOkUcdeXI4uEViTaNLMn3PoHprdbF/dreXYRdDsHsh+qvDEFylQHiFyitij
	zcQuFvuBAIPg5qjpkfgd9B/D2xHjKUfKlMFZFHJhVa/TBw3To4DtMeJsjW4InU6/UimHW5RszR/
	U4LVzfcSmQOy/KqfVlZPF7hiXQcdXJnWWv1J/mFSXtZgaPxRjAIpkbB5Xmr1zjKXr9fJhBytepJ
	RXsbFI9Fah6UZ
X-Google-Smtp-Source: AGHT+IEhPEPL6QXJEBz8w/KPp20Tep5Qz1wXk1qBL5ntKWMnmoekiCpBQK3shdEMdKA3hUH+vlvj4w==
X-Received: by 2002:a05:600c:4f82:b0:43b:ca31:fcfd with SMTP id 5b1f17b1804b1-43c601e18e1mr37233545e9.18.1741381528646;
        Fri, 07 Mar 2025 13:05:28 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfa52sm6296136f8f.21.2025.03.07.13.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 13:05:28 -0800 (PST)
Message-ID: <3f777e6a-01bc-44eb-8eac-7ff685a3fbee@linaro.org>
Date: Fri, 7 Mar 2025 22:05:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 20/20] scripts/ghes_inject: add a script to generate
 GHES error inject
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 linux-kernel@vger.kernel.org, Thomas Huth <thuth@redhat.com>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
 <3045b51edaf2d07eb0c513249fd1c621562ee3d9.1741374594.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3045b51edaf2d07eb0c513249fd1c621562ee3d9.1741374594.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Mauro,

On 7/3/25 20:14, Mauro Carvalho Chehab wrote:
> Using the QMP GHESv2 API requires preparing a raw data array
> containing a CPER record.
> 
> Add a helper script with subcommands to prepare such data.
> 
> Currently, only ARM Processor error CPER record is supported, by
> using:
> 	$ ghes_inject.py arm
> 
> which produces those warnings on Linux:
> 
> [  705.032426] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
> [  774.866308] {4}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> [  774.866583] {4}[Hardware Error]: event severity: recoverable
> [  774.866738] {4}[Hardware Error]:  Error 0, type: recoverable
> [  774.866889] {4}[Hardware Error]:   section_type: ARM processor error
> [  774.867048] {4}[Hardware Error]:   MIDR: 0x00000000000f0510
> [  774.867189] {4}[Hardware Error]:   running state: 0x0
> [  774.867321] {4}[Hardware Error]:   Power State Coordination Interface state: 0
> [  774.867511] {4}[Hardware Error]:   Error info structure 0:
> [  774.867679] {4}[Hardware Error]:   num errors: 2
> [  774.867801] {4}[Hardware Error]:    error_type: 0x02: cache error
> [  774.867962] {4}[Hardware Error]:    error_info: 0x000000000091000f
> [  774.868124] {4}[Hardware Error]:     transaction type: Data Access
> [  774.868280] {4}[Hardware Error]:     cache error, operation type: Data write
> [  774.868465] {4}[Hardware Error]:     cache level: 2
> [  774.868592] {4}[Hardware Error]:     processor context not corrupted
> [  774.868774] [Firmware Warn]: GHES: Unhandled processor error type 0x02: cache error
> 
> Such script allows customizing the error data, allowing to change
> all fields at the record. Please use:
> 
> 	$ ghes_inject.py arm -h

It should be easy enough to add a functional test covering this,
do you mind having a look?

> 
> For more details about its usage.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   MAINTAINERS                    |   3 +
>   scripts/arm_processor_error.py | 476 ++++++++++++++++++++++
>   scripts/ghes_inject.py         |  51 +++
>   scripts/qmp_helper.py          | 703 +++++++++++++++++++++++++++++++++
>   4 files changed, 1233 insertions(+)
>   create mode 100644 scripts/arm_processor_error.py
>   create mode 100755 scripts/ghes_inject.py
>   create mode 100755 scripts/qmp_helper.py


