Return-Path: <linux-kernel+bounces-563315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF356A63D94
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3E2E3AD75B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BC6169AE6;
	Mon, 17 Mar 2025 03:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NcgJYp7Q"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28A71519A3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742183486; cv=none; b=KUsUNHUGc+9S9iIvWpjzcFxjnyQw72GWWOS3S9GHvcZHYQJuJ+4Up6RKOZ48wTr/op5ZEKGGZJQGoW00Jbc1G889K7Io+8pXija3ai6INa268nf08Ke/a4duB8CYEXqXJrI4ewqywWxwo4ymhCvTGiMaqxDVD0/jn1d5yVBgtrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742183486; c=relaxed/simple;
	bh=Bn92wbaIQwnR7LDXhf2VNfpNMnGgk1DVNZHihOSS96s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zd3U7JAiZfKtK8QIx0SFfWMEJAI+l0hIHx9xxD11fW/mV4E9aq6+wrtKg1JBYArzsI8p42VS+843R+Xpd1YBHWg2o+K88aEK5Q4O7xsSSt4MZRDJxJi4byR+ifIspxOtjt+pGvqmkxxRtMlZXgziWmyY3B8+T6w6eI3D+N7YBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NcgJYp7Q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2255003f4c6so63946435ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 20:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742183483; x=1742788283; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNZBfMvSNnXJiaeX6hMwSsN7OOb+ypIwewtzoH1j+pU=;
        b=NcgJYp7QLt5BT5it5hAiS8wVdJvfLOMJKz68mw9wuLS8qlIfRZHAJzYxPTQF0Yd9vl
         +6V5OxQlPXFw7OhpKkaVzzXKvfil7AchCUBPJoQhhPQsXEtlKluu70O41wO1ksXSy+oi
         2z8RsqUFzLvDlGSi+3wOICWTaIAt/l4H9xkwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742183483; x=1742788283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNZBfMvSNnXJiaeX6hMwSsN7OOb+ypIwewtzoH1j+pU=;
        b=q/nZoMR0IgyaYd3vPQhpFTiXeNHpC0/MOpnAvVFiysvX1cCfnxtzPyvyhCZaeUjtvF
         NgY1mJ9aGSBIR1npH8BCTt+3PIbL3TTc8LclpCL8uAjd0w655eC3LmCIfAMykZeIbOHb
         U8zYmkcyAYuhK8tMmekg4I6EaJSQEkAP5AbfYad2T3WNdwH0/RustP10wPuHASPFumpA
         kk5z3UBRFlc3wABDnyfmQs8UOhqwhyDoyFoZJYl4BE4aml0nE3qval4JOE/tj0MJpaKR
         iZICWNe6ujYk6OCQLz6GLOoyz2bbqjK0rGvHUlS72+4ZenCVB4swT4dtKSp7SCbP9Um4
         Pfww==
X-Forwarded-Encrypted: i=1; AJvYcCUChKG6Ja2zhCcSIiiQ1wGhVxubITttqkOuaafUP1mt6NfQAUwNd6djmSFh+zT0dJgR6e7Ltc9wtrvc//g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6a2RwXYmCiTh+V29cYRwitkGMar3zNd6k/QVFwVwwX9jmeRJE
	6/25W8aI89Fr0rAh3EO9rDuVTTw12XX2NMZqBxEBQYB4UXpiepAV0g+577D9/g==
X-Gm-Gg: ASbGncugQbDmCFQsZud6ZZdOjuwKytPucPVzIj0VOqVmab3RnBSZBmMeneKC9P8jp5d
	MXeHAHXU36GMMW4Kr9nIFqNIl08TurGE6JPRawPu0u63KJkPbS1/w4C6/4+yl8v1eJrSJ6q3yAj
	4/E1iARNV2D5R85bvJaKu+xbqOpOJAXDGXPkYRJrrZJ6H+2AamtfTvqOsCPiR116ktxVzA+px8A
	Nll4fS+4LWiBn5KFZEujoVIr8iI50dm7uoSqgcYGoqSKglQg+lPuLoJKRsXOO0labnzlY3Gkwv4
	+s9jtDYvnsvThF2R7nTVr/uuxIu8iIrnkMOzSME=
X-Google-Smtp-Source: AGHT+IEPQ1bRD4grN06N92KNZWUf4hENnVZkATK1o9ytsZfQcCKJcjED3P0YY6Zn6G9M/+mPJ8xpdA==
X-Received: by 2002:a05:6a00:9a7:b0:730:927c:d451 with SMTP id d2e1a72fcca58-7372246dacbmr14550119b3a.20.1742183483104;
        Sun, 16 Mar 2025 20:51:23 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:77b5:e0b8:95d2:83db])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9ddf44sm6193099a12.18.2025.03.16.20.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 20:51:22 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:51:19 +0800
From: "Sung-Chi, Li" <lschyi@chromium.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] hwmon: (cros_ec) Add reading target fan RPM function
Message-ID: <Z9ecN4ZWx1P5csrK@google.com>
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
 <20250313-extend_ec_hwmon_fan-v1-2-5c566776f2c4@chromium.org>
 <782e6319-2082-4f05-9987-fa68439701ef@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <782e6319-2082-4f05-9987-fa68439701ef@t-8ch.de>

On Thu, Mar 13, 2025 at 05:24:28PM +0100, Thomas Weißschuh wrote:
> On 2025-03-13 12:47:43+0800, Sung-Chi Li wrote:
> > Implement the functionality of reading the target fan RPM setting from
> > ChromeOS embedded controller under framework.
> > 
> > Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> > ---
> >  drivers/hwmon/cros_ec_hwmon.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
> > index b2fec0768301f116f49c57b8dbfb042b98a573e1..73bfcbbaf9531be6b753cfef8045fd5dab5b2ab3 100644
> > --- a/drivers/hwmon/cros_ec_hwmon.c
> > +++ b/drivers/hwmon/cros_ec_hwmon.c
> > @@ -36,6 +36,19 @@ static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index
> >  	return 0;
> >  }
> >  
> > +static int cros_ec_hwmon_read_fan_target(struct cros_ec_device *cros_ec, u8 index, int32_t *speed)
> 
> int32_t is a userspace type. In the kernel use i32, or even better u32.
> 
Sorry for missing this important detail, I will not use userspace type
for following changes.

> > +{
> > +	int ret;
> > +	struct ec_response_pwm_get_fan_rpm r;
> 
> Switch the variable declarations around.
> Also call the request "req".
> 
> > +
> > +	ret = cros_ec_cmd(cros_ec, 0, EC_CMD_PWM_GET_FAN_TARGET_RPM, NULL, 0, &r, sizeof(r));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*speed = le32_to_cpu(r.rpm);
> 
> r.rpm is not marked as __le32, I'm not sure if sparse will complain
> about the usage of le32_to_cpu().
> 
It did. Currently, all devices are running little endians on both AP and EC, so
I think it is ok not to explicitly call the le32_to_cpu?

> > +	return 0;
> > +}
> > +
> >  static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
> >  {
> >  	unsigned int offset;
> > @@ -95,6 +108,7 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> >  {
> >  	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
> >  	int ret = -EOPNOTSUPP;
> > +	int32_t target_rpm;
> 
> Also u32.
> 
Same for the kernel type changes.

> >  	u16 speed;
> >  	u8 temp;
> >  
> > @@ -111,6 +125,10 @@ static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> >  			ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
> >  			if (ret == 0)
> >  				*val = cros_ec_hwmon_is_error_fan(speed);
> > +		} else if (attr == hwmon_fan_target) {
> > +			ret = cros_ec_hwmon_read_fan_target(priv->cros_ec, channel, &target_rpm);
> > +			if (ret == 0)
> > +				*val = target_rpm;
> >  		}
> >  	} else if (type == hwmon_temp) {
> >  		if (attr == hwmon_temp_input) {
> > 
> > -- 
> > 2.49.0.rc0.332.g42c0ae87b1-goog
> > 

