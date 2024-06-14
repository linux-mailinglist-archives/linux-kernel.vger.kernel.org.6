Return-Path: <linux-kernel+bounces-214947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75413908C82
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D9B283AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E001C3D;
	Fri, 14 Jun 2024 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRpspczR"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010263B;
	Fri, 14 Jun 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718372090; cv=none; b=sOeHBAYC+EDXYz8HkFN5V1Jrccn1IYUSQAPFa460xCRJDAjxtz1mwQx+riizclZYF/Vw0wT18hGASI9MMU2wXfnlhE3bcabgsKwivc+qwyZCWcUKOgkfl4LU1Nj4PTF/DwKCoXgoK0KU9cxM1g9l08i1tL7uRsqdFJx8fIRqy+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718372090; c=relaxed/simple;
	bh=zxBS0H2QF3bKj/W6dDqqMOK3hfNC0OpxKQw4sGnVXlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYAtJstx5VfbIxHOB7IXY8ThG80OMEaDyE1PYi9mku7qXmBarAOuCocRdtBUl8DQBJVxh7iYTlDz08sh0B6Fuj0JdV+3DIRrQA98mTzgFbtYcR+A8YlfX81WGRlTK28mQeM+GiGZ5Chu3YfxxKWpuR/L0HJm/s5zNAf9Z5KTpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRpspczR; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f6e183f084so16967475ad.1;
        Fri, 14 Jun 2024 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718372089; x=1718976889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nru6Eq6mqHXuglPNhyO4PL0IfuMfzt0ofiBJPcYAh9g=;
        b=FRpspczRf/XLskVzAEbseNIMjr5fVMH31NGq4GAl3NZWwAr+at5pB9Jn6//sV0v5Cp
         NHpD861yIns43vtzRLuNzLA6vtc+YlR1bXHhwKkjotanXWv/IyUpPEH59UISDVYL5UWw
         Dqf3+mWsHIg0bLsBYNzTiJQOFqCoq93bt1tQOJTZ/q9TB3Hb06g0Wiwt0yv35rE1xKb+
         t8DHwIpyXQacTHCCuOfjD8xAjxmxXrm+xaxmQTPJ0QKk8a8sf8qDqmqcvdB1NW1MOJ3G
         0lnHXAnU4SZBX3GjH4u3shmQbDzJcY6awJ1yr4DbByV66AkxpQ/veY6RLyNGEALl1FUL
         HT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718372089; x=1718976889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nru6Eq6mqHXuglPNhyO4PL0IfuMfzt0ofiBJPcYAh9g=;
        b=nX+xV4rYuTPeIO2skEPvG76CfJlC6eimmtDqs4GBuyUGJ1Pgc7W465eqfA/XU6iBQY
         H161oVZ2f4j8scvTgimSAGyh3woJAQ8nsISpEpAG4Yhh9FPA5sQdEGP57H7UDHJrwXwe
         yvYoLVtaNdfZUux/u1sznyOOQ/Y4mh5H9l5B67IwgSRuYpZ4mHP1MGF0R3GtbgvjRyqP
         c11ye0JEVxTFNsleMOwZYBdcSlwD3Q07xpgizx1UfFkDHfJRdLitk9gRguik+GnKNlyR
         lykZENH0VFA3x3ZcC59d3NxsYLgG5YjqX8t6BSoeG7lj3ym78aEH1ZmTF+BW6+nPevwi
         19uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkm4oIHUAA/+Zj/lHUy9v3HyvANTaUKchPeR/YzBo/LKR1QjADxeBcg67FuqPldoy9h6ui61alabMVCsG6XldHbAlV8xdQkxxbUOf29QTX2WbqQUdTcI6/+m5AXczjOR+tCec8tH2TqUc=
X-Gm-Message-State: AOJu0YyOZiApee7fh/1KwDKGgzpcFt1vmAdYi7EwcL7A2IhNKYV9nbZK
	CJL1SOk0lNmULhlHls7geCKCsXC6THKwHoL95+kHW9D51qR07vuid9W3sg==
X-Google-Smtp-Source: AGHT+IHKvOBWThNtSvLUxrssGXWTECOs32Rb6mxtnICh0Qv0OU0khhafRBdKoP9rcxQX0LQSRmMGZg==
X-Received: by 2002:a17:902:d2cf:b0:1f7:2d45:2f1 with SMTP id d9443c01a7336-1f8627ce142mr29481485ad.15.1718372088406;
        Fri, 14 Jun 2024 06:34:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e5fsm32010525ad.59.2024.06.14.06.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 06:34:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 14 Jun 2024 06:34:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] hwmon: (max6639) : Add hwmon attributes for fan
 and pwm
Message-ID: <3df529a9-b2cc-467e-aef0-598dcdbbfb3e@roeck-us.net>
References: <20240614055533.2735210-1-naresh.solanki@9elements.com>
 <20240614055533.2735210-2-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614055533.2735210-2-naresh.solanki@9elements.com>

On Fri, Jun 14, 2024 at 11:25:31AM +0530, Naresh Solanki wrote:
> Add attribute for fan & pwm i.e.,
> fanY_pulse
> pwmY_freq
> 
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> ---
> Changes in V5:
> - Remove unnecessary IS_ERR check.
> - Add mutex
> ---
>  drivers/hwmon/max6639.c | 90 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 86 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> index 45ed629c6af9..091a4a0abd27 100644
> --- a/drivers/hwmon/max6639.c
> +++ b/drivers/hwmon/max6639.c
> @@ -76,6 +76,7 @@ static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
>   */
>  struct max6639_data {
>  	struct regmap *regmap;
> +	struct mutex update_lock;
>  
>  	/* Register values initialized only once */
>  	u8 ppr[MAX6639_NUM_CHANNELS];	/* Pulses per rotation 0..3 for 1..4 ppr */
> @@ -232,6 +233,9 @@ static int max6639_read_fan(struct device *dev, u32 attr, int channel,
>  			return res;
>  		*fan_val = !!(val & BIT(1 - channel));
>  		return 0;
> +	case hwmon_fan_pulses:
> +		*fan_val = data->ppr[channel];
> +		return 0;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -243,6 +247,33 @@ static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
>  	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
>  }
>  
> +static int max6639_write_fan(struct device *dev, u32 attr, int channel,
> +			     long val)
> +{
> +	struct max6639_data *data = dev_get_drvdata(dev);
> +	int err;
> +
> +	switch (attr) {
> +	case hwmon_fan_pulses:
> +		if (val <= 0 || val > 5)
> +			return -EINVAL;
> +

Testing max6639 ...
Out of range value accepted writing into fan1_pulses: val=5 max=4
Out of range value accepted writing into fan2_pulses: val=5 max=4

Valid range is 1..4.

No need to resend, I'll fix that up and apply.

Thanks,
Guenter

