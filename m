Return-Path: <linux-kernel+bounces-269415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420299432A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654351C21435
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF93E14AA9;
	Wed, 31 Jul 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLXg2z4i"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF993232;
	Wed, 31 Jul 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438160; cv=none; b=bC23XZPSfddOsHieq2732WH7pIjgJqS+KSRlpoyjKrwT+UU1k4fupEIKHHkFMHxYejsSv7688bpidxsxIxlh/LP7aRwqZRzAbzCFvamPwpyEheMa0Iu17ZosRVZHpXJ/Put4/44LtTGc5PtbrtT2WytNdCMLL+lBBl9TP5t7HcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438160; c=relaxed/simple;
	bh=GdbXqK3pOYa0rkRvKMpQ1qP1/xyRibNZjDLqjkPfE2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi7oj/5r6zKXioQByVZOnEiWm/hpk3E/3Bo4qW+J39Yhj9LE6dedt1/rFo9nltHqkKkuM2ue8izOwHn2PBUjo6jnaqcukVj2KBZY1hWlfYyUMUVcIZ0iWaZXTM3ekdyEiY2JlRbjauBimXNFAYsbvRH8RuFxydnbu6eyzfpq11w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLXg2z4i; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d1c655141so4326736b3a.1;
        Wed, 31 Jul 2024 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722438158; x=1723042958; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3pEcVDWIeBBKJY5rYo4nIp1+5IBnyuWvRwhKMSQzHM=;
        b=HLXg2z4iYFFciYI3MiRdHb5/mGXrN4m3aXOMXEM8/SU8LrQ4uJovXxwoEftugkbRpj
         RCqvGInGtSdZtXM1U6hTPD4koC1ezkWI9lU9c0oRhmRyXgamUYcOa6PGB2K96rmH4tDX
         rgG72HuPk2JYhAzjsocs3VWPw5Uk3LHilf8GL2BopAcqhoEKg+sNUcfSXsyc+xdY7L4t
         Fkv/OeOmGD35TIRmpRKm+cAdXZxKUYep8fV2mDFG3zcPVp6UIgEX6TOQlU18ErafeEud
         9KF88gRXEFjzR4rV2HBNMmjWxfWH4vgSZRZYrpZDzt36wNt54jXpMpd6KaKP1j0qJ+Z0
         KFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438158; x=1723042958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3pEcVDWIeBBKJY5rYo4nIp1+5IBnyuWvRwhKMSQzHM=;
        b=PSPjFLnUUdy+7u/BYj17pTIanTSXpdfCdXOppfKX+XTEJgllNNX17qqPm8SlSZ5J/m
         9YsKUVHCVK7hpdoIawWgk5gqc7YpGHDrdZKFolNIqewtfAEwTaXRnVSgrX8cad81T4At
         heUzXgEzDZWsq6+8pqWOjd/v64mcZRGWKkJkO8IU1ou8klFWtvkv7zkCwIw1bspunFER
         ISdOMdwAe5rJnxKEdbjZwQa2b1mWou01u6dE2fGZHRCP4vafh0/UuAQEIe0V1LEcw7cs
         iq5di3jAA9H/MO3do0hyo0AckfwYfKweRdJGZksZQukR9In9xuwyd70OPmqoAq+q/8U0
         TF9w==
X-Forwarded-Encrypted: i=1; AJvYcCXiQipoIQ6zY/miMw3gg9pVVSdobWgKbRh69+hS75JuRIE3t5XS0k8/X8lRJPPO4fHDFgLXZLeBa5tgCrUahkqBX8gdQS72z6t7fWWJ6X7uZNMkMA5KrJhp3GvZ+m95Zknn695h0nvY2p6FpDpqilDE5ulHQ2BtM9DemsdXcmITlXGS0aJRWXeyHyvafyq/wpxADy1z5+bSrXKqOHZekFhy
X-Gm-Message-State: AOJu0Yyq+glCQt4MoFb//lXCnMOCwVZhNua5ihP3a3Zf2p5CJFljfcfC
	wJErTUrJ5oER3Z7fETzoxX7JE44VsDhBoUN+T8K7qNb+Ok5+6qN8
X-Google-Smtp-Source: AGHT+IFDe+Gop8MQmy/8qvQgta8yZDYKCAntFqVNAuMmp6Sw0Ob7fNHgNCvkehwyfC09R83AyyEuCQ==
X-Received: by 2002:a17:902:c947:b0:1fd:a644:e466 with SMTP id d9443c01a7336-1ff0485ba7cmr146711915ad.39.1722438158295;
        Wed, 31 Jul 2024 08:02:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8582dsm121843175ad.6.2024.07.31.08.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:02:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 31 Jul 2024 08:02:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	chunzhi.lin@sophgo.com, haijiao.liu@sophgo.com,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID: <75f6f910-43ff-4d98-b39f-b4b0629a56a1@roeck-us.net>
References: <IA1PR20MB49538C09E94D90F07B7B2562BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953DE89C56AB3F328954131BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB2822D0C770667CFE484EBC95FEB12@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB49534944E268A0A71AA3D5D1BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR20MB49534944E268A0A71AA3D5D1BBB12@IA1PR20MB4953.namprd20.prod.outlook.com>

On Wed, Jul 31, 2024 at 03:17:57PM +0800, Inochi Amaoto wrote:
> On Wed, Jul 31, 2024 at 02:13:20PM GMT, Chen Wang wrote:
> > 
> > On 2024/7/30 15:50, Inochi Amaoto wrote:
> > [......]
> > > +#define REG_CRITICAL_ACTIONS			0x65
> > The name "REG_CRITICAL_ACTIONS" is ambiguous. I have confirmed with sophgo
> > engineers that the complete process is: when the measured temperature
> > exceeds the temperature set by REG_CRITICAL_TEMP, the processor is powered
> > off and shut down, and then after the temperature returns to the temperature
> > set by REG_REPOWER_TEMP, it is decided whether to power on again or remain
> > in the shutdown state based on the action set by REG_CRITICAL_ACTIONS,
> > whether it is reboot or poweroff.
> > 
> > So based on the above description, I think it would be better to
> > call "REG_CRITICAL_ACTIONS" as "REG_REPOWER_ACTIONS". "REG_CRITICAL_ACTIONS"
> > gives people the first impression that it is used to set actions related to
> > REG_CRITICAL_TEMP.
> > 
> > It is also recommended to add the above description of temperature control
> > and action settings in the code. Currently, sophgo does not have a clear
> > document description for this part, and adding it will help us understand
> > its functions.
> > 
> > Adding sophgo engineers Chunzhi and Haijiao, FYI.
> > 
> > > +#define REG_CRITICAL_TEMP			0x66
> > > +#define REG_REPOWER_TEMP			0x67
> > > +
> > > +#define CRITICAL_ACTION_REBOOT			1
> > > +#define CRITICAL_ACTION_POWEROFF		2
> > 
> > As I said upon, actions are not related to critical, but is for restoring
> > from critical, suggest to give a better name.
> > 
> > [......]
> > 
> > > +static ssize_t critical_action_show(struct device *dev,
> > [......]
> > > +static ssize_t critical_action_store(struct device *dev,
> > 
> > [......]
> > 
> > The same reason as upon, "critical_action_xxx" is misleading.
> > 
> > [......]
> > 
> 
> Thanks for explanation, I just get the name from the driver of SG2042.
> This is out of my knowledge.
> 
> > > +static int sg2042_mcu_read_temp(struct device *dev,
> > > +				u32 attr, int channel,
> > > +				long *val)
> > > +{
> > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > +	int tmp;
> > > +	u8 reg;
> > > +
> > > +	switch (attr) {
> > > +	case hwmon_temp_input:
> > > +		reg = channel ? REG_BOARD_TEMP : REG_SOC_TEMP;
> > > +		break;
> > > +	case hwmon_temp_crit:
> > > +		reg = REG_CRITICAL_TEMP;
> > > +		break;
> > > +	case hwmon_temp_crit_hyst:
> > > +		reg = REG_REPOWER_TEMP;
> > > +		break;
> > > +	default:
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	tmp = i2c_smbus_read_byte_data(mcu->client, reg);
> > > +	if (tmp < 0)
> > > +		return tmp;
> > > +	*val = tmp * 1000;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int sg2042_mcu_read(struct device *dev,
> > > +			   enum hwmon_sensor_types type,
> > > +			   u32 attr, int channel, long *val)
> > > +{
> > > +	return sg2042_mcu_read_temp(dev, attr, channel, val);
> > > +}
> > Can we merge sg2042_mcu_read and sg2042_mcu_read_temp？
> 
> Yes, it can be merged. but I think using this nested function 
> is more clear. And gcc can auto inline this function so we
> got no performance penalty.
> 

FWIW, I think that is pointless. Te only difference is unused
parameters.

> > > +
> > > +static int sg2042_mcu_write(struct device *dev,
> > > +			    enum hwmon_sensor_types type,
> > > +			    u32 attr, int channel, long val)
> > > +{
> > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > +	int temp = val / 1000;
> > > +	int hyst_temp, crit_temp;
> > > +	int ret;
> > > +	u8 reg;
> > > +
> > > +	if (temp > MCU_POWER_MAX)
> > > +		temp = MCU_POWER_MAX;

No lower limit ? -1000000 is ok ?

> > > +
> > > +	mutex_lock(&mcu->mutex);
> > > +
> > > +	switch (attr) {
> > > +	case hwmon_temp_crit:
> > > +		hyst_temp = i2c_smbus_read_byte_data(mcu->client,
> > > +						     REG_REPOWER_TEMP);
> > > +		if (hyst_temp < 0) {
> > > +			ret = -ENODEV;
> > > +			goto failed;

Do not overwrite error codes.

> > > +		}
> > > +
> > > +		crit_temp = temp;
> > > +		reg = REG_CRITICAL_TEMP;
> > > +		break;
> > > +	case hwmon_temp_crit_hyst:
> > > +		crit_temp = i2c_smbus_read_byte_data(mcu->client,
> > > +						     REG_CRITICAL_TEMP);
> > > +		if (crit_temp < 0) {
> > > +			ret = -ENODEV;
> > > +			goto failed;

Do not overwrite error codes.

> > > +		}
> > > +
> > > +		hyst_temp = temp;
> > > +		reg = REG_REPOWER_TEMP;
> > > +		break;
> > > +	default:
> > > +		mutex_unlock(&mcu->mutex);
> > > +		return -EOPNOTSUPP;

This is inconsistent.

> > > +	}
> > > +
> > It is recommended to add some comments to explain why we need to ensure that
> > crit_temp is greater than or equal to hyst_temp. This is entirely because
> > the current MCU does not limit the input, which may cause user to set
> > incorrect crit_temp and hyst_temp.
> 
> Yeah, this is good idea.
> 
> > > +	if (crit_temp < hyst_temp) {
> > > +		ret = -EINVAL;
> > > +		goto failed;
> > > +	}
> > > +
> > > +	ret = i2c_smbus_write_byte_data(mcu->client, reg, temp);
> > > +
> > > +failed:
> > > +	mutex_unlock(&mcu->mutex);
> > > +	return ret;
> > > +}
> > > +
> > [......]

