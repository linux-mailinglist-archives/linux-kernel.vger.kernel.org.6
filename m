Return-Path: <linux-kernel+bounces-194544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBC78D3DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529BB1C22456
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038051A38DF;
	Wed, 29 May 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/Y5l9hS"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBB360B8A;
	Wed, 29 May 2024 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005683; cv=none; b=Em4nelmfmVvz7PvFKG35Qpk+KQO67d4N/y8QcmuQhh8zpNiPzn5/X+0qJQhumpzcCPL8aPoNLxh5VCC7EaNceIrvY/B65dqRXgJKKdcCfAsUnxJYg/cYtlmwLntOyg62nEpWaO2vLguG69N/57s0XNZgrvxAvkw3Wz28KBKpQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005683; c=relaxed/simple;
	bh=C9bv8n2Yph9zB4abb7Qhz66pPr/f91zc6NXxwuqWJOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t5xeiD86+Qbqw1b4vO1o3N3MCsACMxCnQOv1NPngwri+19bSKk2ifY9KOnKTJ4Fa2QBnx411LEKLQWgGMuWL9mfOLsTzWsyoS8QiL0flVvSpOkE7Ivog+86pcdw4bLGvWRt10rq98Bikjd3BPCglKfct2l9tpcTKRrnEil2kJBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/Y5l9hS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4603237e0so205859b3a.0;
        Wed, 29 May 2024 11:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717005681; x=1717610481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7v4SBxMsVcC1Y8hf6RcuPsH7ukRGgbWwv2pnXRLZ3hs=;
        b=a/Y5l9hSCBmKVFJYF8aHn0cGT39Wfrfa8GBM74Uh+bVmpdQMIfy7DmOUcva7+XOdFX
         mhaibzArFQGyRZoI9/SCpUhbj+UEptR0QwFRjcIcIpPDtnw/wgss2U8Q/SCwN3uviGOO
         rLjn+Qtn1T45HGkGiwK0/s4hAZUfEfhWhDyhmniz3F7ppHJefMLCoJLSM02mBAKk4NXz
         XSOULwswu6Z7IlP8oylKGEl1wZbDeY7iBIAxciWmZKQllabM9GSyUjb+Oduo+kTJ+D8v
         ADcoyyYXIrqooXRFzO/T4I2fg/xIMM3rP0s8gaKjg+/jnVBR8NU35xrpac6CLu/Ujm9t
         tfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717005681; x=1717610481;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7v4SBxMsVcC1Y8hf6RcuPsH7ukRGgbWwv2pnXRLZ3hs=;
        b=w3231HBCHfYMdhl8tvfWWBi59L1BlhoLc3YEV2i2yLJLaJBxwT3EuoINJy/tifgDXv
         mmBfQBXL9EE3iM9w++BSKJNLA8pt0xKas5jV/9DFM+dU1aLOUaXINiO7uMSGLeMExwLV
         IGMDVVrTADfJIHhN0YZ1VaUBqcEx8IseyZFTwchbCY+wtLzZJ9mDS8jWo4fbIr+4ogJB
         yc3hLjs/qnWPMjgw0IyCc8FU8VZjJz8rN0ysH49XvJHeSClGFTdTD3lFExXmCSPpIsJ2
         dfl2EslQSmzxqMRlrAB5LnVyXTSnOfE4+QYJn0RmTi4ocrh+7xPVY7MMFj3i9WLAPVE9
         wKOA==
X-Forwarded-Encrypted: i=1; AJvYcCV5S9eOf0gSDDVJ5HT4AZT1eoivnHf62LnnFOm4xngoCacTT+BDwFs9V91ciGczCksDNpqV+hLEE2B7kg8DDmTDCRdqcovw4xp+qjhQ3vcaSrhHSds0tLlTncYFonIi8ReVEylK6L3xD/reTCcwTeRuzR0NTvFtWFIHLlzh8WxfiUkSR8M=
X-Gm-Message-State: AOJu0Yxval9RlKocrTb7wm1wdwnzAl6siXGRF1CXP/jWL4Zx2QtS7sj9
	SjUePHnQXE4VGt+pvaT/wnjYb8RIRFCVRCCOlyiU2IZOJrTwCym/xnwudw==
X-Google-Smtp-Source: AGHT+IHqiJT/ps0cD036xFv70u0VPuwVVr1EoTm+aFNcmbJuM7L4nOzLZrp+4SENo8ldRBaO9G08vA==
X-Received: by 2002:a05:6a00:26d7:b0:702:2b15:a1f with SMTP id d2e1a72fcca58-7022b150b97mr1162617b3a.2.1717005679460;
        Wed, 29 May 2024 11:01:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7022f2425e3sm55095b3a.126.2024.05.29.11.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 11:01:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a3eff514-f515-41a2-bb11-603434dc38fb@roeck-us.net>
Date: Wed, 29 May 2024 11:01:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drivers: hwmon: max31827: Add PEC support
To: Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240527092947.4370-1-radu.sabau@analog.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240527092947.4370-1-radu.sabau@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 02:29, Radu Sabau wrote:
> Add support for PEC by attaching PEC attribute to the i2c device.
> Add pec_store and pec_show function for accessing the "pec" file.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---

Sorry for the trouble, but I decided to add PEC support to the
hardware monitoring code. With those changes, the hwmon core creates
the attribute and handles i2c client configuration. The driver only
needs to configure the chip.

I'll copy you on the patches introducing and using this functionality.

Please apply the patch introducing the core changes to your system
and rebase this patch on top of it.

Thanks,
Guenter


