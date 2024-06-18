Return-Path: <linux-kernel+bounces-220240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C38690DE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE101B21A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2BF17838C;
	Tue, 18 Jun 2024 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNQzyNJi"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76840178379
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745792; cv=none; b=QcZ9AwS//j8EY2LcvNyFb6hUUa+3xYZOoH+/blUC9pAqNk0wZQV4a76gBV/jKXZ0scXRtsulAOWr2Ks4eGU/n8ouzQU2vwLYuumOqjQeOX1y7nCAAC8V/g8FqlTErRj1J6Yr15e1YrnEKjuAzNvD0SvTtEG0wWVvDH1rmiK7SIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745792; c=relaxed/simple;
	bh=CozcYDWu7sUzoKBu4MLtOhWFXW+t+e5D8AvAr+VUP1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVzLoWAx9Ww4czsF6Ptgazfp87JxcxggdWDmtlSlANeOg/bOcRrcIK9Ffg5ASNz2hkRQyCBiG5kgE7CRzN0fia+UoAAYwTjY9OIKO1D0gCd51ZBe7ZFMlGqO+i24Gui6p2C4zE7xsDkLqwJvMmM5+0KYY1BgWhqOLC5stSOFHjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNQzyNJi; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6c53a315c6eso4171726a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745790; x=1719350590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t/cyF6RBCFFGEjIeF3D7JylpWEzeUX90aI3y20QIt/s=;
        b=gNQzyNJi95IYLawdbhVSvn75zOm0SvChja44F1kIuCkTHQ1MGSfn6PkwdNXvDy3v1A
         2DCfglyw1KAPaAAqUWn2W8UTnpIfOn6ABFoGqtvVwVVXCGbHUDc/eMcl79sx+Apng6TI
         FY47NS5slVeQCOvv+ujGu5y5ujP7gmBsgVN1VlfN5bmwVfuytBZyI+76ogqJWZ72/Vt6
         uvEzT8rQjmA4cuY2c+SDxaGV9soH8c5tBoD9YUwWQTylY78uJHFVfh6cJ4ZXah+5jHRP
         lh//x4IDAQz/a6Y6T62hRxIUBEnhmbvvXUVRuJT4G07tBW3jheUWBgUhd540NqWEyDVY
         UXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745790; x=1719350590;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/cyF6RBCFFGEjIeF3D7JylpWEzeUX90aI3y20QIt/s=;
        b=COhBFz6GO3JnKHMYoiQvgbuML+fGW22xkLk50K7XJyFn5T34iNJzv1pwKC3R0L9hHc
         7HsmYFeP1xKm8bDE+oc/vrD/D4TVVPllwU8yNWuc0J7cjglLp6e02fspNRg3JgieKyk1
         S0hCEqGkQ/pSwZW6sZEFyGKQnZxwHWquDKjHhq9hP5AwWr/xGp608mQxxcuETBd1TZD7
         HFeOjpaFl6vnAsON6Nc0dbPrfWgJ9ODyyBG+CSuFcbxQwz2wKm+Lv6o7zOGyNkSz0e5j
         dG+VKuV88KnjWulu3KqrsMLv/42lXPbJg4TcGRkTU5DDpBr5PixSH3FT6bm4bUdDjMZG
         hnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXECwQ13BbL2MqTltHm9y8tf4LYjpXOrkz75vb1AKVqJcSutzl6Nvh/1AS4vJCWsLEKAsYG3EABpBkRgMHaCDaEXmCNDepIH6TraUsL
X-Gm-Message-State: AOJu0Yz0D4ki06f3abJ+7uuLCSXq4rlSz/+jJSrqoG2ijZRZoOqIt5kx
	ImVKxGLOZxbUzlId10OQiCpso/zWNG/7x1xnQ3F2AK+2R4X3qbME
X-Google-Smtp-Source: AGHT+IENg7pWW+JT6TwnXxl6gmXy4/XHxVcGPJ20go4DSetRmkNuwJUEIPWk/Dt3b2Lxdvou3Ug+jw==
X-Received: by 2002:a17:902:ee51:b0:1f6:f82d:a8c2 with SMTP id d9443c01a7336-1f9aa3e9c78mr8201885ad.31.1718745789684;
        Tue, 18 Jun 2024 14:23:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e5a3edsm102136395ad.51.2024.06.18.14.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 14:23:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7ebb98b3-e852-45af-8b5a-d0fd2357d6a0@roeck-us.net>
Date: Tue, 18 Jun 2024 14:23:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Page select register restrictions in regmap core
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
References: <4b22e04f-3142-4a5a-a8d1-366c4b8bbb73@sirena.org.uk>
 <78c93d6b-af0e-4d96-b213-e1e402524361@roeck-us.net>
 <adcd5997-84ee-4c72-aa37-2940afdc83bd@sirena.org.uk>
 <c4a5fb5c-90b4-488b-8875-a0b819e24bcd@roeck-us.net>
 <19893519-20a6-47cf-bb3b-c61dada627bc@sirena.org.uk>
 <e6733f56-014e-4ea0-aaf8-059334f2b27f@roeck-us.net>
 <1a62fc39-355c-4885-b5f6-b66f01a1328a@sirena.org.uk>
 <0287c32d-0b63-4873-9f71-0094a912f8bb@roeck-us.net>
 <44d4fce5-2ec9-4f62-b7ac-a317c7d843db@sirena.org.uk>
 <3b47b5e3-4eb2-43f9-8f4f-c021d203305e@roeck-us.net>
 <17890e6b-cf00-43cd-9d99-2383b5fbef64@sirena.org.uk>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <17890e6b-cf00-43cd-9d99-2383b5fbef64@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 13:46, Mark Brown wrote:
> On Tue, Jun 18, 2024 at 12:33:40PM -0700, Guenter Roeck wrote:
>> On 6/18/24 10:45, Mark Brown wrote:
>>> On Tue, Jun 18, 2024 at 09:14:56AM -0700, Guenter Roeck wrote:
> 
>>>> It turns out that at least some i801 controllers don't work with the
>>>> access mechanism used by regmap, or maybe the spd5118 chips don't support
>>>> I2C_FUNC_SMBUS_I2C_BLOCK. I already found that those chips don't support
>>>> auto-incrementing the register address and actually reset the address on byte
>>>> reads (i.e., subsequent calls to i2c_smbus_read_byte() always return the data
>>>> from the first register). Since regmap doesn't have a means for me to say
>>>> "don't use I2C_FUNC_SMBUS_I2C_BLOCK even if the controller supports it",
>>>> I may have to drop regmap support entirely anyway. That would be annoying,
>>>> but right now I have no idea how to work around that problem.
> 
>>> You can set the use_single_read and use_single_write flags in the config
>>> to ensure registers are accessed one at a time, that restriction is
>>> moderately common.
> 
>> That doesn't help, unfortunately. Thinking about it, that is not really
>> surprising. The failing write is to the page register, and that was
>> a single write anyway.
> 
> Oh, that's interesting - I'm kind of surprised the wire protocols differ
> but it's been a while since I looked.  We should probably add this to

spd5118 devices are ... weird. For example, they don't auto-increment
addresses on a read operation, meaning regmap_i2c_smbus_i2c_read_reg16()
doesn't work at all because i2c_smbus_read_byte() always reads from
address 0.

> the quirking in regmap-i2c.c, have it select one the 8 bit only smbus
> versions for devices that need register at a time operation.  I'd not be
> surprised if other devices have issues, and anyway if it makes a
> difference to the wire protocol we should try to select something as
> close as possible to what we're actually doing.
> 
> Something like the below perhaps (this probably needs to be converted to
> a match table type thing at this point, there's the SMBUS_WORD_DATA case
> too):
> 
> diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
> index a905e955bbfc..499fcec00f2d 100644
> --- a/drivers/base/regmap/regmap-i2c.c
> +++ b/drivers/base/regmap/regmap-i2c.c
> @@ -313,6 +313,11 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
>   
>   	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
>   		bus = &regmap_i2c;
> +	else if (config->val_bits == 8 && config->reg_bits == 8 &&
> +		 config->use_single_read && config->use_single_write &&
> +		 i2c_check_functionality(i2c->adapter,
> +					 I2C_FUNC_SMBUS_BYTE_DATA))
> +		bus = &regmap_smbus_byte;

That might be an option. Give me more time, though - as it turns out,
I2C_FUNC_SMBUS_BYTE_DATA doesn't work for writes either on the affected
system. Something else is going on.

Thanks,
Guenter


