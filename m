Return-Path: <linux-kernel+bounces-270796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80551944562
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A8E1C21E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CAB16B390;
	Thu,  1 Aug 2024 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="WmYiG4Mj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8AE157493
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497010; cv=none; b=KrjW6mUPg7T3L/lxuB3ZKJABwmEehIDmOh5VhNkSB1gRLqGFlPIqXvP/xe+T3vbu4L9MuK6DhZRoHDqob8qFXyxoTwVUmtItrnshSQU0g6AK8itLEUsVNE6znSpi58dNzakvXUZh/z8867mEM0ktwRQWcqfFOdGoSsZC7PBcr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497010; c=relaxed/simple;
	bh=sSnpR8T3HWqyH57d43tYCrY0GtNGtGqXjWZkkziwtLs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U+lGTGJ05MyEU0yEnD2Ikzz7h4qBGWfg4OKYkMVkkpQr1Voer+W8NeH+mvTXpSIXOcSRX+MfJgQ63LIQFX+yKm5AX3l1keg6PXxoCh2+NGq9jIqYvx23hlBHNE5KlhbN/YIYNdv7+HLkr0irJFDFm5yoxW7CdmgDcicbXQ70x7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=WmYiG4Mj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc569440e1so59833165ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722497006; x=1723101806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PCt7QnhrAiB4sQ6YhOwxu8pXKKSA9/F5K2ANy9A8n5A=;
        b=WmYiG4MjmiGb3fNjSsnF86gHy+K6UslMm0NMRSYYie+khNH7Qmo6pKxuMv+Uyx1vRE
         PIv8N+On9ckd+dwf5l68Mlx6t3g4/aiTHzjgWGVD6V3F69cLdX3WJZgXTAP0m1/H05R9
         93lCoT+BKUJNs0hsj33mXG6uLktgC4PKMIN0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722497006; x=1723101806;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCt7QnhrAiB4sQ6YhOwxu8pXKKSA9/F5K2ANy9A8n5A=;
        b=SfpreXNOR0ixgBn+jiNLjws6TnIfiv7Kb6awRaplFYeKOu5zpafxtZlZ/0dCVPWASY
         M7P9IMa2xEIOECod+AVZQk0sbux6hq/P8EqJN81MFPNVfhlo4U9s9RIPBPnotfN2ReEj
         YqaydVoCizfmbzZavA7+11BPcaJ741kP0tmo/M+uctffSACONFpUKVPCopFyETlzEriW
         2Qa/ssQPGDrcPINFHepmHi1ziyD1LbC4TOqMl4jVXHx9+J8DdCZ7Mw5fvPTsoTJTxnN0
         /ZJUfyCbLY6C0qR6jGM0DfuN8C6Wd+m8CLx7Xt+ojTRFvhI0ACK161ZDrvjCkmQAzfah
         0U4g==
X-Forwarded-Encrypted: i=1; AJvYcCVgPUlPw1EGVuyIfXQb/9rORH2+HTz/4OpFxIZontvHC3H2+hf2vRNVPQZ7JANqO+cGTjKsjVIf0Tp0GeKzfPWTgrh4sp4wq0/RFPC3
X-Gm-Message-State: AOJu0YzOWpQxmNfOTBfIhJ+vDFQFz8xfAUheTkTVR6WrZa1MzMk+v7/z
	XoiBCpFuUeBOVODdu5CrV4o2WGRhvc4QWEUyzwbflwT/OdikmzYcIWgwJdl/IUqJ+MmRFuVOgWc
	qHA==
X-Google-Smtp-Source: AGHT+IHKzoCBN8aBLvqtz8kuT+Tx3VpZBBXRM5kC27Z+diKMoF9U00abCS9BlvN1CJ7l7N6CnEFa7A==
X-Received: by 2002:a17:902:654f:b0:1f7:2293:1886 with SMTP id d9443c01a7336-1ff4ce56c00mr16784555ad.12.1722497006327;
        Thu, 01 Aug 2024 00:23:26 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1b6c3sm131715595ad.192.2024.08.01.00.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 00:23:25 -0700 (PDT)
Message-ID: <5a293fa0-944c-4049-896e-fa0a945c82c6@penguintechs.org>
Date: Thu, 1 Aug 2024 00:23:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Bluetooth: hci_qca: fix post merge window regressions
From: Wren Turkal <wt@penguintechs.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <CABBYNZ+dvLGos9oLi6euFkmiU9OReJ5F3qsA6WrhW29yeZ-jWQ@mail.gmail.com>
 <721b286c-7143-40c7-84cf-c77986009895@penguintechs.org>
Content-Language: en-US
In-Reply-To: <721b286c-7143-40c7-84cf-c77986009895@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Bartosz,

On 7/31/24 8:57 PM, Wren Turkal wrote:
> Luiz and Bartosz,
> 
> On 7/31/24 9:32 AM, Luiz Augusto von Dentz wrote:
>> Hi Wren,
>>
>> On Wed, Jul 31, 2024 at 11:21 AM Bartosz Golaszewski <brgl@bgdev.pl> 
>> wrote:
>>>
>>> Here are the fixes for regressions reported by Wren and Dmitry. I could
>>> reproduce the crash on db820c and so I was able to test it but patch 2/3
>>> could use a Tested-by from Wren on QCA6390.
>>
>> Can you give this set a try and report back?
> 
> I'll give it a shot tonight or tomorrow and report back.
> 
> Bartosz, thanks for looking into this.
> 
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>> Bartosz Golaszewski (3):
>>>        Bluetooth: hci_qca: don't call pwrseq_power_off() twice for 
>>> QCA6390
>>>        Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
>>>        Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown
>>>
>>>   drivers/bluetooth/hci_qca.c | 19 +++++++++----------
>>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>> ---
>>> base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
>>> change-id: 20240731-hci_qca_fixes-8e7a8ed3ad83
>>>
>>> Best regards,
>>> -- 
>>> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>
>>
> 

+Tested-by: Wren Turkal <wt@penguintechs.org>

It works. Thanks for chasing this down.

wt
-- 
You're more amazing than you think!


