Return-Path: <linux-kernel+bounces-525970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E0A3F7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4CB17F76A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B9120F09A;
	Fri, 21 Feb 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8zWMSWc"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581B74BED;
	Fri, 21 Feb 2025 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150223; cv=none; b=n10L6fjCL59tVZkBtj8N4N5YLp7TT0ZiBSJHsLS824E8k4VFourBZG3h7jujSYffT0LETZo4eI8m/1Xy3plCgpWBmIHUdWPTx+YhGL+G3KrDH070HR6U+aCUpZCxIWAwESemyBJbmT0bkDF8PsbU30nD0R/yAX031k/OjifKQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150223; c=relaxed/simple;
	bh=gsnNSPpy3H9i0wRjy+ytwpp2TYwWOrgCWOPkgSZooRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBk0Q79GICLEmXzrMCSvaBeD1Q/BfLXJQh8CUECZgqm2WEQyBmHOj39vywDEHC8i6PsC5iBXA8EPQ5Qm51Ii7SQ/UeLVKbVNAdl0B0A9HYnZZJn+ObkX6TpofHvIT/57dSUN/QEzl+OfvXdAKDk2PISuuP2mnDX6gxSOeSH5fyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8zWMSWc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220d601886fso33923305ad.1;
        Fri, 21 Feb 2025 07:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740150221; x=1740755021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pXQvWn8yA4pYClIty3dZm8IPvbcGvvyTtfzoets52jY=;
        b=a8zWMSWcBVDr95E8rnOBwgcFu7GBkM+zSmM7w8JkJVsxk3G09ZUgXsfnURGB2d+VHK
         TKDV37Bz2hUMkSKxY9R4aNfWSZgPEiW8Ol/sI6piKaEtRy23L492rLTWKxt0AOoPkTNg
         zQZbLAQXSpMaBQgG4Y6JPQ+/n4MxK+CFnlVX9I8Gw7qa0EifDgkl/fGIsw/Ih0iefNNE
         jOpJj3jQHRwU1HBDs3Trqti3gENNW9tv8hJ8RVB8apr6MMALguLoyipRAIXoMCKHxGKY
         M8vInU9XTk93og0IywoR7BZCCwkTCL0+SWXw2XKIx1BvL1xAP4EofyoJ/1yj56TQwN5V
         A03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150221; x=1740755021;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXQvWn8yA4pYClIty3dZm8IPvbcGvvyTtfzoets52jY=;
        b=jd7qIZ6/Zm20Pkhc3tgjMbHhS7bLMjKhKZhGpWEJET0moAvjPR+snsoeAfaTBbozDE
         vC4EI8SNB1vdeS/CxyRzc6mEUAa4JZN/OzPB+PpFzwGhw9YweAiE6FbL3JrLGvS5Swdb
         LBKWYmF2DDqCbBuwADinuEmXy6RKOuLMSYQeOXmBmBwTC5qNAFGNBa3eZTqK7z5yy9Mo
         oVwrwgIHlq7n9Pj7e+sUAxc7cUQbJJS3iWGItIZzNE9Wb+ySvw0Y6nbl3yhQTWHQ5ofN
         mA9us+4seXZY434sURwzWQ+KSvC9ItTC3BatY222/4dC6Y0Bj8xfisYhrkDLogJIHao7
         xSVA==
X-Forwarded-Encrypted: i=1; AJvYcCUSfboRA1RHQJc0cF/fxGf7nccR2VwLsWEt/B1leKnl5OR5Q1qWUIjh45KD6z3ox+6Ybrgv7CfWitfP@vger.kernel.org, AJvYcCWVzYnyMkA49vwgXz0XtTHjgt8Dqfjzx2aYJh1QnU46QvrjI3RxiCwv+cUMmof5KQo04kT55Wghac2WxNw=@vger.kernel.org, AJvYcCX6tc1gnw9PlnN7lfoXhTpodKzvPFuD26eGHRGqH1Hrz69JRtWFbQzQjVuVoFbLlqNky7qTgSAabHoJyaat@vger.kernel.org, AJvYcCXTaa8o4KONxmrh+7isgs2c+FfBW6KWYHXYOfOTiU7e49Ye25v70gKt6mh2rs598njc9WXhK45MhKbITzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxIlueZjzmGq0f2PRRyo5J0otYsWSHdpXJsk3+JMt+O0a95dM
	95cOe4B7Bd9rON2UWaLOBm6C6tjJVOZ52Ld38rnoWF6V84OzHoD+
X-Gm-Gg: ASbGnctDkSxI2Yf0DjlCrrcp6Ib/9A6g5JpE+ArJlrg49JopboJNxc2UTMVqh9CiSvb
	ns5xjOsqsvuya0YTOHl4IceCNk8RGWxHJijz+3do7VHemg7tCGYLrr6UoR0chvBg8ogAM477qbC
	g413sVIw4iUV5aL3NJDFeAY9p4A8HW33+aYi9O/+ZHiYAtzHH9afKMu8aNMAjCRiEAnFRTZrL5+
	gDWu4347Tdc/skd537/HjbWuov/LZXXy0gwK/msALjeRdBpaUYvdW/lvQbtB7zVY0Gn/1OP5QXH
	I5WIUgHj1sRlfF/O/xXnR8rOLchCgQ9rxDjvWqBA1+FUIJqREF2G8yprI75RvN6z2mEZRVztO4k
	=
X-Google-Smtp-Source: AGHT+IFvvlSHmnEHZenrLxnU2xsQDizN0mIChQ6nonulNZbyqK538np0l4F2iSLpvjGVmqAux4YHnQ==
X-Received: by 2002:a17:903:32c5:b0:21f:658b:8ed5 with SMTP id d9443c01a7336-2219ff30c91mr54740935ad.6.1740150221366;
        Fri, 21 Feb 2025 07:03:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536457esm137995665ad.85.2025.02.21.07.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 07:03:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <409e8873-5ebd-41af-8162-30668271be6a@roeck-us.net>
Date: Fri, 21 Feb 2025 07:03:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/29] ASoC: tas2770: expose die temp to hwmon
To: James Calligeros <jcalligeros99@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Dan Murphy <dmurphy@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shi Fu <shifu0704@thundersoft.com>,
 Jean Delvare <jdelvare@suse.com>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Hector Martin <marcan@marcan.st>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 asahi@lists.linux.dev, linux-hwmon@vger.kernel.org
References: <20250218-apple-codec-changes-v2-0-932760fd7e07@gmail.com>
 <20250218-apple-codec-changes-v2-14-932760fd7e07@gmail.com>
 <4e0e2ae0-c53d-444c-9d8a-d465be690232@roeck-us.net>
 <CAHgNfTzfK4HnYs+LDH7kcR+pZqSxT9YBZYQ=c+Mcpva4Vx=D_w@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHgNfTzfK4HnYs+LDH7kcR+pZqSxT9YBZYQ=c+Mcpva4Vx=D_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/25 03:31, James Calligeros wrote:
> On Wed, Feb 19, 2025 at 1:20 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 2/18/25 00:35, James Calligeros wrote:
>>> +static int tas2770_hwmon_read(struct device *dev,
>>> +                           enum hwmon_sensor_types type,
>>> +                           u32 attr, int channel, long *val)
>>> +{
>>> +     struct tas2770_priv *tas2770 = i2c_get_clientdata(to_i2c_client(dev));
>>> +     int ret;
>>> +
>>> +     switch (attr) {
>>> +     case hwmon_temp_input:
>>> +             ret = tas2770_read_die_temp(tas2770, (int *)val);
>>
>> Type casting a pointer like this is never a good idea. This only works
>> if sizeof(int) == sizeof(long).
> 
> I will rework this when dropping the die temp sysfs interface. This
> was mostly so that
> I didn't have to change any of the code there, but since we're going
> to drop that
> anyway it's redundant.
> 
>>> +             if (!ret)
>>> +                     *val *= 1000;
>>
>> The calculations in the previous patch suggest that this is wrong.
>>
>> Either case, this is redundant. The temperature is already displayed
>> as device specific sysfs attribute. Displaying it twice does not make sense.
>> I would suggest to either drop the sysfs attribute in the previous patch
>> or to drop this patch.
> 
> The calculation in the datasheet yields the temperature in degrees Celsius.
> hwmon consumers expect temperatures in "millidegrees" Celsius as per the
> sysfs interface documentation[1]. Regardless, as above I will likely rework this

Yes, I am well aware of that.

> when dropping the die temp sysfs interface so that things are a little
> more logical.
> 

Unless I really misread the code, tas2770_read_die_temp() doesn't return
the temperature in degrees C.

Guenter


