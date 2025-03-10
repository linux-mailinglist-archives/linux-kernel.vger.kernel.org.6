Return-Path: <linux-kernel+bounces-553434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA11CA58986
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0F3188C27D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E532CA8;
	Mon, 10 Mar 2025 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqsETMfQ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8281E;
	Mon, 10 Mar 2025 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741565467; cv=none; b=WCbX51aXdqXEFgIyMhqmE5ih8ee6eH1YhhLnsxOyjKiJFQ8SAVPO4wvqucA3H9qtMcVJWtx8E0Iv1FseW5feQLG2kdbTwuPcH0yAL21T8pSUCWokW/Jv5Rmik1kcYoJb6R+20ALJG1QmnRP56gQZK/tLqYOlMratyjJZ3omd6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741565467; c=relaxed/simple;
	bh=NNTDTkTEz9AitGsCoxYmnI5gt9HoS2+WSaQHCSMuMMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbi3shPfvFITMxoSNzSiW74mvnvDWVWJnNnEPM7jOAGymKMH4peAT1C9lIf4EPa8u6PrGfusbzAcgO+N/RscAC68RmKX0HPAdB2fugNfuVIDv9Mfcjji6m+e8oGZqyVfEmjAgMwgfFpROO+L7bn1UqwN6QktxJ/BVeAnGLU/fCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqsETMfQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22355618fd9so63886425ad.3;
        Sun, 09 Mar 2025 17:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741565465; x=1742170265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8ALG8qqKPFoDaQ+ApQvcfDOn130RPhdd8vCinfDX1Mk=;
        b=jqsETMfQXy7lONtS57XvEHjB2Me7yoP83Ds2PN74Y1pmFhPtHCQJRa4oTT5cy9uCDk
         zopWpydry9WO0xL8+F5X96xoc/2dfyVpzfY/96y78ouBF6a9VYliY0Jap7SYLQ1gma3Q
         YhX7e2zd6ta7mSNqSPubpLvtT6FAhVP5TjE3gEaqPaJikWhUHGHd09UUIyvlEIH3o+5N
         d8FRL9sJ4+zOuffnHfB9kUquHC46jW1YTBlTughwTy8dmJ+HHEyr9m2Nnra8zdRgrT3z
         o1r4wqh55wanAnYNoczmIgHDignsHfKRCRS391ziXDmi/58OPPMc+gOpnyjVCXXlSOk2
         iu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741565465; x=1742170265;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ALG8qqKPFoDaQ+ApQvcfDOn130RPhdd8vCinfDX1Mk=;
        b=eDoQwTQiF4XoCPG7yjY20XnzafVrbTRRMbdPWFzZ3aR7527KNOn9Z3ZPosJ/C1UgZ9
         9tO0rIJygp9kP+t5eoar67C2dPcn/fRRY3fhOmoQa38VIOvpv/J4QvkvGoUIEv8MWfy0
         ocriAjcXE2PnvN1zzYS1Zq6Uf7Ze88wxSXs6MOxurr4XM44U1NQKk0HWK/+LL9iwAIXS
         +Dov/MBvS/hpZstiZfcdNd9GtIiWaDIbIHHg3VPdStoP+lvuqo6+85+ZZBi4aTV63Y1M
         JKfJRVWLutPG8xHhkcsteE03NU6Zko6RX5C+pUXFviS5HLUZOEzuzOpELx9pFgGjhPR4
         68mA==
X-Forwarded-Encrypted: i=1; AJvYcCULrZ9QqEwtqweFUy5Z3pXic1YCWGPEgs7raIkdNMx9lLIemXt3i72e6/mVFF2xdJBFbjlgDmiq6Es=@vger.kernel.org, AJvYcCUYomXiMQikWfzr9lHoqO3stYNcRIOabWAtJON/n/kkLEZ9uYDSA6+aNZsF42k6QUyVYiPQp4MM4+UXc9hl@vger.kernel.org, AJvYcCXgzaaxnY4G8+3xmdxnc3dyTlriHNMopgjQFZws43K0KnwGtEn4U1QxYueAKD8klhqyfM0N9xGKtwMUGaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVhGAR+GmfN6IPfCYpF0wwbyOqyPP6qnTJIiqQ1xDMiWmrdgF4
	vuqOXbjU4decyGVj89niKQTzN5w1et57o9LqG8vT//TNc6HgFtk/
X-Gm-Gg: ASbGncsx3ekp1hgHaqrl6c9VFZ1Di81J61urFLG3kM6jfLp4EjzU4zHivlPBxjxQJzQ
	mYuGAxoSnovpBpf1NIBxNSUt4b/1KfvrKBLqFH8ysXBQSMrMfNTSCUuSCZn7+j99lAElqnWc4Qw
	Fqe6VQuym7SzBD7gO81uXcORRevNOI153AoHxDnsopUrVrTsMtHRL3HaJdLZxIa8XKR+YrnapLJ
	+S0CDbLLTUE+ggIjWgCqW6+QbR9lC1SPXuEfAytQrzyFP/vg+7STfl5O7gVg9WGFApVYpXYvoaN
	tjinu4VwbSp/KdQKdbfLEMIbofvM4NPNmQBJvpi6NG8SOYz27f4+ZhHnNK3ebN06YnwYnQk0mqH
	V2zCyfz6/lAbg5Bz4tQ==
X-Google-Smtp-Source: AGHT+IHVE5OqQhV5ylGDdd0P+vVeUVyBaJoy5vWD4RhhvEt/K3A2WBkRk/06pCQ1V9qJeFFzmV3dSQ==
X-Received: by 2002:a05:6a00:1703:b0:736:57cb:f2aa with SMTP id d2e1a72fcca58-736aa9fdbbamr16863191b3a.13.1741565465405;
        Sun, 09 Mar 2025 17:11:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698246387sm6951170b3a.72.2025.03.09.17.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 17:11:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9865e1b9-6f03-4f54-83fc-73591646b74c@roeck-us.net>
Date: Sun, 9 Mar 2025 17:11:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hwmon: (dell-smm) Increment the number of fans
To: Kurt Borja <kuurtb@gmail.com>, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
References: <20250304055249.51940-2-kuurtb@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250304055249.51940-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/25 21:52, Kurt Borja wrote:
> Some Alienware laptops that support the SMM interface, may have up to 4
> fans.
> 
> Tested on an Alienware x15 r1.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> Hi all,
> 
> Guenter, if you prefer a different patch for the documentation, let me
> know.
> 

It looks ok, I'd just like to get a confirmation from someone with a
system with fewer fans that this doesn't cause trouble on those.

Thanks,
Guenter

> ~ Kurt
> 
>   Documentation/hwmon/dell-smm-hwmon.rst | 14 +++++++-------
>   drivers/hwmon/dell-smm-hwmon.c         |  5 ++++-
>   2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
> index 74905675d71f..5a4edb6565cf 100644
> --- a/Documentation/hwmon/dell-smm-hwmon.rst
> +++ b/Documentation/hwmon/dell-smm-hwmon.rst
> @@ -32,12 +32,12 @@ Temperature sensors and fans can be queried and set via the standard
>   =============================== ======= =======================================
>   Name				Perm	Description
>   =============================== ======= =======================================
> -fan[1-3]_input                  RO      Fan speed in RPM.
> -fan[1-3]_label                  RO      Fan label.
> -fan[1-3]_min                    RO      Minimal Fan speed in RPM
> -fan[1-3]_max                    RO      Maximal Fan speed in RPM
> -fan[1-3]_target                 RO      Expected Fan speed in RPM
> -pwm[1-3]                        RW      Control the fan PWM duty-cycle.
> +fan[1-4]_input                  RO      Fan speed in RPM.
> +fan[1-4]_label                  RO      Fan label.
> +fan[1-4]_min                    RO      Minimal Fan speed in RPM
> +fan[1-4]_max                    RO      Maximal Fan speed in RPM
> +fan[1-4]_target                 RO      Expected Fan speed in RPM
> +pwm[1-4]                        RW      Control the fan PWM duty-cycle.
>   pwm1_enable                     WO      Enable or disable automatic BIOS fan
>                                           control (not supported on all laptops,
>                                           see below for details).
> @@ -93,7 +93,7 @@ Again, when you find new codes, we'd be happy to have your patches!
>   ---------------------------
>   
>   The driver also exports the fans as thermal cooling devices with
> -``type`` set to ``dell-smm-fan[1-3]``. This allows for easy fan control
> +``type`` set to ``dell-smm-fan[1-4]``. This allows for easy fan control
>   using one of the thermal governors.
>   
>   Module parameters
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index cd00adaad1b4..79e5606e6d2f 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -73,7 +73,7 @@
>   #define DELL_SMM_LEGACY_EXECUTE	0x1
>   
>   #define DELL_SMM_NO_TEMP	10
> -#define DELL_SMM_NO_FANS	3
> +#define DELL_SMM_NO_FANS	4
>   
>   struct smm_regs {
>   	unsigned int eax;
> @@ -1074,11 +1074,14 @@ static const struct hwmon_channel_info * const dell_smm_info[] = {
>   			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
>   			   HWMON_F_TARGET,
>   			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
> +			   HWMON_F_TARGET,
> +			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
>   			   HWMON_F_TARGET
>   			   ),
>   	HWMON_CHANNEL_INFO(pwm,
>   			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>   			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
>   			   HWMON_PWM_INPUT
>   			   ),
>   	NULL


