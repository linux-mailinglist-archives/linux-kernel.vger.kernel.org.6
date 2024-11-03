Return-Path: <linux-kernel+bounces-394006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0433A9BA87A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 23:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8901F20D38
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B018218C326;
	Sun,  3 Nov 2024 22:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vht3JLKE"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6344D18C02B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730671819; cv=none; b=s7QbAwFuHUcaZDGp8cbykeXeOrjFlxwGnuOa3LOU6apP+PgzcdkAmcwg2MBY1yrjptLT48083+W0eQN/bhrKwE4/qGS6tNW0Wz0ACFZ49hW5emUes7OljnuY5RsrS55nUTpkWufuZUOKkwj6ZtK1m5HG2H6Il7qdFSPCcE6nQMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730671819; c=relaxed/simple;
	bh=YfV5iYFCey8uL8RvVFXKpCmMrpkP6Yn7Yg2LpgeM26E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEYiP0U8610qDSoXeS5EFz/o0XqX4CSPd51iXRWQJ/CPDcJ25hd8v5rwd0j0jb/EQr+HMcHPPJh4H4T6dyZAMwSa1i0+PgvaSnJFP0vkgoLEKTokKQ5d3lnYFYgrAUuFADzmhXst1ScYM+8fhCUvjtE3EddXrH702f8Xm4foEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vht3JLKE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71811707775so1890622a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 14:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730671814; x=1731276614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUWYuqtR3aHLEhG7mg7lZrCRFDuphm1pLOvMuWzILNI=;
        b=Vht3JLKEVK758BtpHL1BLTVtaBpG2uF4Q3UG8skuu2U+kfcId35eHe7kNkDf6n0ZQY
         kudwvrbw6wVGJICEhd9mrurgYwJ1ViZNYV/JLUQmtxtsman9BFUuBOrWWtXomGo5cwzs
         adjrXDgzmCWLuO/8/WpicVXxPxz/q++jKMHrcbYNjsXunavpJpKv8mQbMxHJl3TzQ2O/
         GfaaS5lWHtYtk8KowIifsY8ikWNC7jrx3VkEohZSuiNoroUANGklvt5VfkwjOyaLj44R
         Ph09aImoZQUFrZkKxKK6ogyVNJJr7Tw4Tm086A2bEJr9JSaDFrvzN1RC0/LkExSZg9OH
         TeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730671814; x=1731276614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUWYuqtR3aHLEhG7mg7lZrCRFDuphm1pLOvMuWzILNI=;
        b=eJ0H+4zs61ADwli0pQHgocDsTuAZaVS0R2xZ++/iJUVKmNeAUNFZ3azZ20oRGs0L3b
         /Al7YdOYmvYfikklTl8DbHyW5sQmvlZnCn4ankWFMAIWf/GtS/wRWGz336jsXbYB2aAl
         OVGZzO1yVgwrNseJYS6KUCWSdyDeFmNTNMihomkcygMPOFC7AkHJ+4W8RY428ikhFcAm
         XogKVIBdyxVZdhVRZxThivVszf/GQSXbC9aE9gTbtT5Bd/jTwgBrELqnCxNSQYV6FjRM
         tbDcYomQJfZWx/SwkDoBI4HPNX3FLHTYQYckrR18xR4cyfXr2VPU95XxyImxgNTFVsxT
         zo6w==
X-Forwarded-Encrypted: i=1; AJvYcCXcHg13RsSzGZzcDI9cUroOkMM42/QFmIoqTw3a5JAREd3entCYpobEHSC1NJtO1fCtOReiTOhwXYfn4cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAk6qMwqOS163bNL4PAUFkovRciKiZfwfc+zf51ZQ7S3mcjRTd
	5dEJADtpqd88BzJ1mQS48GnCia2u4gSKAdFZecyHDy9AGzwbET0KLkithxuKXB0=
X-Google-Smtp-Source: AGHT+IGMfVh9LXk0iaYFioOzlB6HVEvHUV0T09OtRUqjTerOH+6ZJQ5jtvM98lKCEUKMBpdWBa6SFw==
X-Received: by 2002:a05:6830:310b:b0:718:118d:2be8 with SMTP id 46e09a7af769-719ca25bdd4mr6851108a34.28.1730671814414;
        Sun, 03 Nov 2024 14:10:14 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189ccb15c0sm1745498a34.60.2024.11.03.14.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 14:10:13 -0800 (PST)
Message-ID: <88b1e5a4-a962-4ef3-abff-724af2f6c09e@baylibre.com>
Date: Sun, 3 Nov 2024 16:10:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: kernel test robot <lkp@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Guillaume Stols <gstols@baylibre.com>, oe-kbuild-all@lists.linux.dev,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>
 <202411020101.5Hs6MkwQ-lkp@intel.com>
 <d44ab5s73kmochmwis3buhd6ci7ff4rwd7kgh47aqar6xeyqna@f4plwf6qbvlm>
 <awpjqzq2ksbqvlfkbh4xnpwqxrnf4np6amifdweasrh52v3jl3@lz3md7ydyhji>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <awpjqzq2ksbqvlfkbh4xnpwqxrnf4np6amifdweasrh52v3jl3@lz3md7ydyhji>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/3/24 2:20 PM, Uwe Kleine-König wrote:
> On Sun, Nov 03, 2024 at 03:00:14PM +0100, Uwe Kleine-König wrote:
>> Hello David,
>>
>> On Sat, Nov 02, 2024 at 01:50:35AM +0800, kernel test robot wrote:
>>> kernel test robot noticed the following build errors:
>>>
>>> [auto build test ERROR on 6fb2fa9805c501d9ade047fc511961f3273cdcb5]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/pwm-core-export-pwm_get_state_hw/20241030-052134
>>> base:   6fb2fa9805c501d9ade047fc511961f3273cdcb5
>>> patch link:    https://lore.kernel.org/r/20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230%40baylibre.com
>>> patch subject: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
>>> config: i386-randconfig-141-20241101 (https://download.01.org/0day-ci/archive/20241102/202411020101.5Hs6MkwQ-lkp@intel.com/config)
>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020101.5Hs6MkwQ-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202411020101.5Hs6MkwQ-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/iio/adc/ad7606.c: In function 'ad7606_read_raw':
>>>>> drivers/iio/adc/ad7606.c:765:23: error: implicit declaration of function 'pwm_get_state_hw'; did you mean 'pwm_get_state'? [-Werror=implicit-function-declaration]
>>>      765 |                 ret = pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
>>>          |                       ^~~~~~~~~~~~~~~~
>>>          |                       pwm_get_state
>>>    cc1: some warnings being treated as errors
>>
>> The problem here is that there is no declaration (and implementation) of
>> pwm_get_state_hw() with CONFIG_PWM=n. Does it make sense to enable the
>> ad7606 driver without enabling PWM support? If yes, we should add a
>> dummy implementation of pwm_get_state_hw(), if not, a depends on PWM
>> should be introduced.
> 
> Looking at the driver, the PWM is optional. So I rewrote the commit from
> patch 1/2 in this series and added a dummy.
> 
> Best regards
> Uwe

Thanks!

