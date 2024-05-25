Return-Path: <linux-kernel+bounces-189382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A58CEF51
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63DD1C2089C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFCA50263;
	Sat, 25 May 2024 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbziSav6"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC833B297;
	Sat, 25 May 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716647632; cv=none; b=IzVt6Va1igtDPr+vzy5nSKy7sOHtE7fpUnFfh330ckMrgFMXHyHZDReX9Wvzpus60hU/rkAGX6OqOYwPLHQNaSVVOIfxBxH7UwTSBJx1T0o+RoEzx+t7yPUs9XeWuUgwRNgqi7tQpUqqkcnrd+GADWdMiHnlRJC+S1iFyGXAgd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716647632; c=relaxed/simple;
	bh=5n7lkDxcP7/xIQnHH72V11GBJnBkIwLKgCjvbVNGbAU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou4emxU0yAC2z0U2xOL/bnopJ2Kzq1K7E6TiGUyEXosTOzZv2S4R4Up+xS8t2yBAmGLVfv8d4twunUPvXmvc5oobSxaCul3aXP1FOXy6Q6kZO2uEFoW/bsm1/jZjPhQWQERtn5zXP+VzT7sPfqJyswkNQeusZYjBEN+ZTkckzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbziSav6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354be94c874so2992923f8f.3;
        Sat, 25 May 2024 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716647629; x=1717252429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CErVniz+W5wR3XMrkvKFk+LDivHl4mX/Bk33d4Ln3XM=;
        b=LbziSav6NEzr95dC/Ukztuvu9dholwTFaWpANoDRjj4MiTZ7yrUrBIf8cgsK/3TarO
         n4A1UxcqrxVMg7nfld6nLX68EOuDdnmGSDgYiGlD7fvJfzkPgSZeF+BWp0ClBTToYvHA
         /ZWuGot+v30Q5YDZ1gqP45H2Yn2fcwx++dxWOf0dBknnCuZ7tVMUMGhiQewDoB5gXg5S
         0j+LfyxBmKe/rpC69/SVdCrd8wXquRA/iBE3moDjeLMtVZPgHOZ6X7wI8Ch1Zn1oO9YF
         yHx4fwo4XXynHRtng3GH8HAGD+rGvcM66sA0hmnrg+KkCELeu97rYZC5rPT+P0VAhinW
         zgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716647629; x=1717252429;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CErVniz+W5wR3XMrkvKFk+LDivHl4mX/Bk33d4Ln3XM=;
        b=CDTqBjm0gWqSHcPnijo8CKhY8bNRPjphkeNOPCxYGnUcFOz1zReyoExHd0do73BBBb
         uEx3EM3MMLGpkp6YNFxeSI+1cGia+JOEzAEwW+fJGZEFCtcmROaVgP7EmMIsWcSWqoBO
         ls28O0w/I9d119av+qWpcNMXPN3slsgR+r56Kl1diLFOH/drIeIXuk6HlMbTuXMCWGO1
         5B6C2Gs2Mmkg7c/IjwgD6kDyM9WOASEL9Aca8MXUrT+EBADRPenQD/lzSs4+O7HEJfoL
         e9idvfEWU2HA8LJQeaQ6KWenrVtyrCfpms0owbt091nSvRG4ZsBZSemoCPAtaaxpZoDY
         ZOFw==
X-Forwarded-Encrypted: i=1; AJvYcCWGHeUqdoy6aPCEXvkcm5a/mde0iP63f0kcNjPduesRW9v5KR0x6Qe4fvdtny+hjKhKHOo9VWqBHGZQb/ADSRpDu5+pfXxZy1GWqVTh2AQftaw2zBtSFaKyaEhchqFDTaWA6hkkCmPXwTOWYGSSKxW9qlzv4vKYNtPkgVZ3R40AUP/htzP1
X-Gm-Message-State: AOJu0Yy0VsdXBrc3UuQEK1t9OoXTkBY9g46akz1rTGxwdKPD7HWcZL4w
	vExPgZjuJHj6G0XgGlNcQFtt2Agxjhovo+oZaoDBqUf6OVlTUpBo
X-Google-Smtp-Source: AGHT+IHfpJHAR0xPYbhrdjzlHYOsMFn+Fuu2j5n/W/C7wWfej0FrMq1yPZIpjCe6kSIFT9ivsGgj6Q==
X-Received: by 2002:adf:e444:0:b0:356:4cfa:b4a2 with SMTP id ffacd0b85a97d-3564cfaebb7mr2911205f8f.3.1716647628458;
        Sat, 25 May 2024 07:33:48 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a090185sm4116340f8f.47.2024.05.25.07.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 07:33:48 -0700 (PDT)
Message-ID: <6651f6cc.050a0220.6f744.fff3@mx.google.com>
X-Google-Original-Message-ID: <ZlHBu6Fsy1HU3Igy@Ansuel-XPS.>
Date: Sat, 25 May 2024 12:47:23 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] hwmon: g672: add support for g761
References: <20240525102914.22634-1-ansuelsmth@gmail.com>
 <20240525102914.22634-3-ansuelsmth@gmail.com>
 <bbcce511-1105-40f7-b6e7-beef07971205@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbcce511-1105-40f7-b6e7-beef07971205@roeck-us.net>

On Sat, May 25, 2024 at 07:29:55AM -0700, Guenter Roeck wrote:
> On 5/25/24 03:29, Christian Marangi wrote:
> > Add support for g761 PWM Fan Controller.
> > 
> > The g761 is a copy of the g763 with the only difference of supporting
> > and internal clock. This can be configured with the gmt,internal-clock
> > property and in such case clock handling is skipped.
> > 
> 
> Do you happen to have a datasheet ? The datasheet is not available from GMT,
> making it impossible to validate the changes.
>

No datasheet, online there is only the first page that describe the
features.

This internal clock feature is the only difference to g763 and is
present in a downstream driver from a Asus ipq807x router.

I verified that all the regs match.

> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >   drivers/hwmon/g762.c | 23 ++++++++++++++++++++---
> >   1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwmon/g762.c b/drivers/hwmon/g762.c
> > index af1228708e25..1629a3141c11 100644
> > --- a/drivers/hwmon/g762.c
> > +++ b/drivers/hwmon/g762.c
> > @@ -69,6 +69,7 @@ enum g762_regs {
> >   #define G762_REG_FAN_CMD1_PWM_POLARITY  0x02 /* PWM polarity */
> >   #define G762_REG_FAN_CMD1_PULSE_PER_REV 0x01 /* pulse per fan revolution */
> > +#define G761_REG_FAN_CMD2_FAN_CLOCK     0x20 /* choose internal clock*/
> >   #define G762_REG_FAN_CMD2_GEAR_MODE_1   0x08 /* fan gear mode */
> >   #define G762_REG_FAN_CMD2_GEAR_MODE_0   0x04
> >   #define G762_REG_FAN_CMD2_FAN_STARTV_1  0x02 /* fan startup voltage */
> > @@ -115,6 +116,7 @@ enum g762_regs {
> >   struct g762_data {
> >   	struct i2c_client *client;
> > +	bool internal_clock;
> >   	struct clk *clk;
> >   	/* update mutex */
> > @@ -566,6 +568,7 @@ static int do_set_fan_startv(struct device *dev, unsigned long val)
> >   #ifdef CONFIG_OF
> >   static const struct of_device_id g762_dt_match[] = {
> > +	{ .compatible = "gmt,g761" },
> >   	{ .compatible = "gmt,g762" },
> >   	{ .compatible = "gmt,g763" },
> >   	{ },
> > @@ -597,6 +600,16 @@ static int g762_of_clock_enable(struct i2c_client *client)
> >   	if (!client->dev.of_node)
> >   		return 0;
> > +	data = i2c_get_clientdata(client);
> > +
> > +	/* Skip CLK detection and handling if we use internal clock */
> > +	data->internal_clock = of_property_read_bool(client->dev.of_node,
> > +						     "gmt,internal-clock");
> > +	if (data->internal_clock) {
> > +		do_set_clk_freq(&client->dev, 32768); > +		return 0;
> > +	}:
> > +
> >   	clk = of_clk_get(client->dev.of_node, 0);
> >   	if (IS_ERR(clk)) {
> >   		dev_err(&client->dev, "failed to get clock\n");
> > @@ -616,7 +629,6 @@ static int g762_of_clock_enable(struct i2c_client *client)
> >   		goto clk_unprep;
> >   	}
> > -	data = i2c_get_clientdata(client);
> >   	data->clk = clk;
> >   	ret = devm_add_action(&client->dev, g762_of_clock_disable, data);
> > @@ -1029,12 +1041,17 @@ static inline int g762_fan_init(struct device *dev)
> >   	if (IS_ERR(data))
> >   		return PTR_ERR(data);
> > +	if (data->internal_clock)
> > +		data->fan_cmd2 |= G761_REG_FAN_CMD2_FAN_CLOCK;
> > +
> 
> This and the property must only be accepted for G761.
>

Yes you are right. I limit this only in Documentation but as a failsafe
I should also verify this here. Will do in V2.

> >   	data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_FAIL;
> >   	data->fan_cmd1 |= G762_REG_FAN_CMD1_DET_FAN_OOC;
> >   	data->valid = false;
> > -	return i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
> > -					 data->fan_cmd1);
> > +	return (i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD1,
> > +					  data->fan_cmd1) |
> > +		i2c_smbus_write_byte_data(data->client, G762_REG_FAN_CMD2,
> > +					  data->fan_cmd2));
> 
> This is wrong. It would logically combine error codes, and execute
> the second write even after the first failed.
> 

Ok will change the thing. 

> >   }
> >   static int g762_probe(struct i2c_client *client)
> 

-- 
	Ansuel

