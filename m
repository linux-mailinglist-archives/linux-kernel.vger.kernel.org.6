Return-Path: <linux-kernel+bounces-370563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E479A2E8E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985341F21456
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA79E2281E5;
	Thu, 17 Oct 2024 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hkp0Q5Zu"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4B17BB32
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197374; cv=none; b=WQbPpi1z7LhI/NsmBp9fp32P2FgEUFTvVBT+Ux3xLNUcDYZL7jpaBuDM4H1fDnJLiiZ1bahEqOFjxiT6anTTXiRYzl4m0KmGzaApU8S4R0pcmJcJTb4fBPdp59Mw7m1QSuR611bmu1EuR3kavTkSaVYfpWcClV9UM8UvHi8HE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197374; c=relaxed/simple;
	bh=AORgYkSEpqScrRJBsDbxUjNY993eTA7X1chV49DsV3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFhTZiPKpvTix1EPx5kz362O5Rszmsd3MrEGw8fwIC7WeOIPsrn9tqjlN90BMPge0NUsqcjJmZJ1xardVthA6Z4pgG+rXHZW8y3tedJpL+Hj/O942PKEUJHT5ebkRrTVgtidnZU0FR56R/lEk5QAE1jUbXtwCi6FnbHmEy1R0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hkp0Q5Zu; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83a94a6032bso47226039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729197367; x=1729802167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11ToTU7vsMi2SSsjzOsYplAbVYXVrOxGmHdlQUxuJOM=;
        b=hkp0Q5ZuAuvcKr+X2tI2e4JBjM3RV9JtVex54UgHOLXlEkKlSrMZPIMekVckzk5dLT
         4xe31MrcOPIBOOBIm7mY0iXgDRUF12niZmMSxHLk99IA0YiJXvS73iGNS7btGDcyoytC
         mteWPiWkfnWATbnKyX5K9PJd9Ec8tc4KNOQSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729197367; x=1729802167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11ToTU7vsMi2SSsjzOsYplAbVYXVrOxGmHdlQUxuJOM=;
        b=ggKHZ2RK0xf0lWfpM2rC6hg+3LCy/Xxek+DECNMWp1ImpFSbYvIURVq6/LIzne8NsZ
         S0uPRMOXNO6wcZ2xlHzMnUxKzcblWZ05u/6dWKbBltJ5wf0q3rLSnynwf3C2eKTXlUvm
         I15KMmokYki7/gf/mwxr5uXOwskq/3DEKB4YoNiGFOU82RtiZSpzz45eEQSfmpV56DqK
         rZog4E8xACndWlySAc1jo4W4DCueTwQkqBqiM2YaADh3hyufQ9QVZmsXW84rHoN5Q1vJ
         2j0ihRVOxaNAYddxrCIcUBQ8LHnpYUVSA1F8XfPviKeBvwDYzRmJla846iqxzSyltiyw
         TXiA==
X-Forwarded-Encrypted: i=1; AJvYcCVkt4GBuYM2VPXVYq2Acfw7b2hUFTBRns2FChairB8z2J72lrZQrY2SsNvzx3JJiZ/84o9K3ItUarbyPOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa8WU4Yy3P0e5sny7lBWIOCLeL6n/yHjpl+oSKmQvzO9+ojFcM
	gWmb/8J3/263v+ydLNtp9uMCgXH/0yrQUn5H2x4/50787OiF8L9tttghQjcNWUE=
X-Google-Smtp-Source: AGHT+IEWVBCgEov4mw1J/kJN0ZwoTJEWDfnh4NgHTLEZFUbsmenZRhqLbReeBnLs3cdVCJsyxaShVQ==
X-Received: by 2002:a05:6e02:1808:b0:3a3:dadc:12f7 with SMTP id e9e14a558f8ab-3a3e5294a27mr33585585ab.3.1729197367437;
        Thu, 17 Oct 2024 13:36:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc10b83e9dsm49449173.56.2024.10.17.13.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 13:36:07 -0700 (PDT)
Message-ID: <56133d31-c94c-4c4c-9ae4-86f06b463a7d@linuxfoundation.org>
Date: Thu, 17 Oct 2024 14:36:06 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] kunit: qemu_configs: add LoongArch config
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241014-kunit-loongarch-v1-0-1699b2ad6099@linutronix.de>
 <20241014-kunit-loongarch-v1-2-1699b2ad6099@linutronix.de>
 <878d5f26-ef05-44f4-93e8-01f66088c0cc@linuxfoundation.org>
 <3a49d3e2-2d76-458f-a0fd-fe52a413f376@linutronix.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3a49d3e2-2d76-458f-a0fd-fe52a413f376@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/24 14:31, Thomas Weißschuh wrote:
> Hi Shuah,
> 
> Oct 17, 2024 22:27:29 Shuah Khan <skhan@linuxfoundation.org>:
> 
>> On 10/14/24 05:36, Thomas Weißschuh wrote:
>>> Add a basic config to run kunit tests on LoongArch.
>>> This requires QEMU 9.1.0 or later for the necessary direct kernel boot
>>> support.
>>> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>>> ---
>>>    tools/testing/kunit/qemu_configs/loongarch.py | 16 ++++++++++++++++
>>>    1 file changed, 16 insertions(+)
>>> diff --git a/tools/testing/kunit/qemu_configs/loongarch.py b/tools/testing/kunit/qemu_configs/loongarch.py
>>> new file mode 100644
>>> index 0000000000000000000000000000000000000000..e7bb7c07819677dfdefac012821a732555813cae
>>> --- /dev/null
>>> +++ b/tools/testing/kunit/qemu_configs/loongarch.py
>>
>> Missing SPDX-License-Identifier.
> 
> Tue others configs don't have one either.
> 
>>> @@ -0,0 +1,16 @@
>>> +from ..qemu_config import QemuArchParams
>>> +
>>> +QEMU_ARCH = QemuArchParams(linux_arch='loongarch',
>>> +              kconfig='''
>>> +CONFIG_EFI_STUB=n
>>> +CONFIG_PCI_HOST_GENERIC=y
>>> +CONFIG_SERIAL_8250=y
>>> +CONFIG_SERIAL_8250_CONSOLE=y
>>> +CONFIG_SERIAL_OF_PLATFORM=y
>>> +''',
>>> +              qemu_arch='loongarch64',
>>> +              kernel_path='arch/loongarch/boot/vmlinux.elf',
>>> +              kernel_command_line='console=ttyS0',
>>> +              extra_qemu_params=[
>>> +                      '-machine', 'virt',
>>> +                      '-cpu', 'max',])
>>>
>>
>> Please send v2 with all the reviewed by tags. If there
>> is a resend 3.4 and 4/4 in this series, send them.
> 
> I'll do that. But it will take some weeks, as I just went on vacation.
> 

Sounds good. Enjoy your vacation.

thanks,
-- Shuah




