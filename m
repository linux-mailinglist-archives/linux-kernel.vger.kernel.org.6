Return-Path: <linux-kernel+bounces-213354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A5290741E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DB11C22BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1FA144D15;
	Thu, 13 Jun 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eABclINr"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4ED1448E9;
	Thu, 13 Jun 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286252; cv=none; b=NmC54q0z9C9MwiJFdV2X3HS3gevLNnkzcxWm9rHMBkBnMhzIXyYJlhyC4/ND1RmJZk1HNg9sjJFLkjhfhq0x7feEbMuid69IRxgBJAHjTCiiu2vl8TA1Lso2810hBlMzhW2s5VFR2o//i5VM3BY79m8mvLsUtmOuSs3BnfHP60o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286252; c=relaxed/simple;
	bh=xNK/PCEG3N6+VYN8NIPMtL5Es0MOikkNeua2KGAGwy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evWfL11mUzPd7eCYpN9X4jAM0a4Wt7hc6i1J3R0gAXXJs3LkeT8WaxdH2i1X/fJa9RL+96roS83EbXnnwqDG4O29Lz7vkR5Yn2J+lBrrANsYv+vxg6wHlVcoIwm73ElYyRsLvjv/9vkYDvSMhfFhPCsEBl08qaLJ+GeTbbG39xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eABclINr; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ba33b08550so546303eaf.2;
        Thu, 13 Jun 2024 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718286249; x=1718891049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=K+bL1zWxRb6IFK9YDQY5NUClMqeTp1DcWB3L8U2N2LA=;
        b=eABclINr2c4sD6eSOiEfz1twr1z2N2+p6mDKYPotCqoHDECdPdUUOKL+AA6wJliGdx
         wB65QpHyPrYMl0k0LZvLG0Q7s+1pn45LC0DWuHFGIKYmv/DZ951+9IVtjRetAr7bLrsx
         ZwfinOxGG9lVZbZM/vLyVazKpU+m4bPai+bIu4MrruptgtPh6PpPnLXvPsf+mhMeHVG9
         3O2Bg2Y+mpB3XcBre0BmVgPKFdRq973unmfjKsI6sCt+C1H3b5rBrX6EhllLCrRBxzpI
         WgtsBQ1jgtqjVzBpmjE6hxtU7Pk/8NzkeMfKvyA77pYbemkGw5tijnhme+vcYg93KAsA
         i5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286249; x=1718891049;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+bL1zWxRb6IFK9YDQY5NUClMqeTp1DcWB3L8U2N2LA=;
        b=D51o1mdihQfpagukJoCZiUEPJ/NsqtQfeM9WsvHElF99RqUnQeMQJYg4OXyX3bYxE5
         XARi1c7CmwJyDWKe9F2KcbDVbmdsw0m5V46XZqUtBTppyEXy1mDiUYcY5KtvVgJbToR+
         bezmmRQSjD1PRIBxlMm0aErBZjxaoWD3VvZzrptZsJbnunnC8fDjwWsVi+PVRjH7mFl7
         OzdvBSodhjTnzndoT4yjMJlVkBeM15c+rhhyRlrdiDckEvoxIcX6o0rWx/xn+VdztYyV
         MckPJipODPOak+XjB5GtvHG8jtyhZFT+8M4eKyF19VVUCmCbJvo4nZUY93xmRab07vEU
         MiEA==
X-Forwarded-Encrypted: i=1; AJvYcCVqn+WutC8Ry/V9Nh3hnVIh4MzOe+QQOqfOcSu2deK6G0biEdbshmCmxI8jaLGJSiohbhasQfqJQ61ZgrbYJRZMM96Zw8iCC15mF1R57KyEZ1WfsqbLV6PeFQay35WvBiljfz44uotlfbc=
X-Gm-Message-State: AOJu0YytaQ66vWcLK9/b1wThDopUG4x5ykaMKggbiPcPXWJO3hemiPII
	syUctluZHNj92rMZVbUKq7XEVMDEXkBquRFTpgEPwWUTHRXQobFYsCfaeQ==
X-Google-Smtp-Source: AGHT+IH5cQ/X1yNZ8NKXqndwy0W17U5qnpvK5dGoFeuq5Qs0pA+uHPpbDXyM9HndK/XKi0UPheteEA==
X-Received: by 2002:a05:6820:229c:b0:5b1:bf03:d1c6 with SMTP id 006d021491bc7-5bb3b963494mr5540538eaf.1.1718286248879;
        Thu, 13 Jun 2024 06:44:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd5de6a1eesm187903eaf.7.2024.06.13.06.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 06:44:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <49d2ceb3-24f2-4cef-841c-392595f66c92@roeck-us.net>
Date: Thu, 13 Jun 2024 06:44:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hwmon: (max6639) : Add hwmon attributes for fan
 and pwm
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240604124742.4093334-1-naresh.solanki@9elements.com>
 <20240604124742.4093334-2-naresh.solanki@9elements.com>
 <3bd9a52e-bfca-4ac2-af48-59772de8b61e@roeck-us.net>
 <CABqG17gS=qfrJCkug5aca6Ag1JSPhbFbfr7X8x7XLCpDwtOMAw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABqG17gS=qfrJCkug5aca6Ag1JSPhbFbfr7X8x7XLCpDwtOMAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 02:51, Naresh Solanki wrote:
...
>>
>>> +     switch (attr) {
>>> +     case hwmon_fan_pulses:
>>> +             if (val <= 0 || val > 5)
>>> +                     return -EINVAL;
>>> +
>>> +             /* Set Fan pulse per revolution */
>>> +             err = max6639_set_ppr(data, channel, val);
>>> +             if (err < 0)
>>> +                     return err;
>>> +
>>> +             data->ppr[channel] = val;
>>
>> Needs mutex protection to avoid inconsistencies due to concurrent writes.
> This is single i2c access. Still we need mutex protection here ?

In this case, the mutex doesn't protect the i2c access, it protects the
consistency between the chip configuration and the information stored
in data->ppr[].

CPU1			CPU2
[val==1]		[val!=1]

max6639_set_ppr();
			max6639_set_ppr();
			data->ppr[channel] = val;
data->ppr[channel] = val;

The alternative would be to not cache ppr and read it from the regmap cache
when needed.

Guenter


