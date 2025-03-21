Return-Path: <linux-kernel+bounces-571762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7331AA6C1E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199313B9BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8566C22F38B;
	Fri, 21 Mar 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXoOTmS4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D422E410
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579466; cv=none; b=CTjvSnryL8HwUwqb3pPKtJ2X8J1dmw04oUOOc/4/DHdf1JTKZnsnyx94yI+i3ZQr9Sgbhay9tRKiscIUbHlTFqshZm8HPl3cAFcVr0jXfBoMFCmmkP4SXEGiT4FcPIEoRw7uSPXEWL7STPiBkYoii1peQfQzy/bI5xnjEVaHZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579466; c=relaxed/simple;
	bh=q4MAD4MZ9jbGWxaVkOS7XD4VN2wfi+JR96aDUZM4Fwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPlf//tr9b1hkw8ifUhbdkx4skC/9yKNe2dYwtV7s75HNYWDw9NEPBCYzXuz1THa6+9IosxLjsTVVGRQ29zwxood0ZxclCWceqrN3/cDnWcivW7j4VGquTI4rWmIeO2+f+4gRTrzXYsoaBA6w38ok1jMd9ui89oAe49H4S3lOcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXoOTmS4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742579462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nizGFjmh47bimoF8P6GlyAgmg9J5VhaJmX5jPftti6g=;
	b=VXoOTmS4gkWmqz1BZ2y0G405UTelNMJbjLQR2DAQuHwhsviQdB+9XKC6QA9YMfBkbPl+ZK
	yfXvBrk7zMe6scjQn2v0VVOBgz2A+3hUEMEsiYbp/itEyeQRLegHAWAGcZ9n8qNoAgl5Y/
	HV+61uGY0Zuxgixor/J/SLotdXUbjDM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-1tTkf6kWM2Wsl5UTFB8VRQ-1; Fri, 21 Mar 2025 13:50:59 -0400
X-MC-Unique: 1tTkf6kWM2Wsl5UTFB8VRQ-1
X-Mimecast-MFC-AGG-ID: 1tTkf6kWM2Wsl5UTFB8VRQ_1742579457
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so14488055e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742579457; x=1743184257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nizGFjmh47bimoF8P6GlyAgmg9J5VhaJmX5jPftti6g=;
        b=f1hO+IPk6Cj8IWYfj0n+w8J8fntXzXXJp4L5HlZleuyH/C6Vw/7/f7OopHnrIXm+wn
         PHlOLgYclkYS+f3aL9TmeHIKJ8M1VUn9G281mlNOJjIb4XyUosfhEElClKtij5r63rc2
         /YkiKj1BCcfSMJ64nOv+qvHKyYW4yEuRC3M1wDogt8Iny67vCXRb8hr/uP87ht54fXSt
         Uo/FmdrzGVY5FKuC4ICGGwBrdBSdMbu6Ysl1MSFBYzHWwxrYCgcTdWk3zFpRO0bIwfV4
         PZn9qnX5pm9+gk/WXa+ImRQnlwBIEozvFhL2Sr2FuX9pKr95xmkrA2H2MVXWXMFKlPZg
         ZI1A==
X-Forwarded-Encrypted: i=1; AJvYcCWMb1ZVAVL6WBYMx79LQ03INnkQpdDxdkFyCO6pEP2JLpi9HV9hgHptI6eKyz8fA6qHsjm9yZBUqkDSndM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZg8ysEivBiogXllBRiSwBAnw4iII9dAHgDUWzrjUQhGzZrUAa
	jjrYTu4VExxNOF8d/RqRqT2Yc9LUgYhctP7LGt4draioqdYmi3hj7Ppdoo9s6Swa7G27t6D+gnP
	guRkhaM5L4LUOkuYHycq3MWjys1diyWs+1VCGafN1mUNicTdWcTl82/zd6j6g8A==
X-Gm-Gg: ASbGnct4UaEra3VF8LdZSa8hHiUl0s5sJfQeVxWo48s+KV0uIVV8cxfZ0XDadiR4y2O
	Eb7M5n3cD+zJgoQ+6KsZGOP0xsFc6tU21yUoMCHH89VYN70VmWQLASXJ4ijIoz0BvL1fPZ5vkNa
	ckJbFguaNMVayAA0qnCTlJiC14iGVw+y7mCWvfYoZoVdBw3XrhbFG2NiCg18liRJyBG5WyQSNNu
	7SKc8KJ2NklzaKTy8cAO4ezkK52DE5fTZ9ViZgWt9GoAR1JOKXx8vGVUDJIafjOXH+dBF/Snl5y
	1BBtBAEIK/0hk39eRHzLZwyWIHdF7z49GN5WWPtsCYCNiA==
X-Received: by 2002:a05:600c:154a:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-43d50a37825mr44330875e9.20.1742579457248;
        Fri, 21 Mar 2025 10:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd2ITqU5wiCBrJkHArbjZN5d0Muz1P8NVOYT8aSNBRjQqgeuR+YXgk2SrqCV0UsvFwX6aDlA==
X-Received: by 2002:a05:600c:154a:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-43d50a37825mr44330645e9.20.1742579456840;
        Fri, 21 Mar 2025 10:50:56 -0700 (PDT)
Received: from [192.168.88.253] (146-241-77-210.dyn.eolo.it. [146.241.77.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9957c3sm3038115f8f.18.2025.03.21.10.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 10:50:56 -0700 (PDT)
Message-ID: <53852ebf-bd7d-4f8e-bc7c-8dd3271cb1b0@redhat.com>
Date: Fri, 21 Mar 2025 18:50:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: phy: sfp: Add support for SMBus
 module access
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Florian Fainelli <f.fainelli@gmail.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, =?UTF-8?Q?Bj=C3=B8rn_Mork?=
 <bjorn@mork.no>
References: <20250314162319.516163-1-maxime.chevallier@bootlin.com>
 <20250314162319.516163-2-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250314162319.516163-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 5:23 PM, Maxime Chevallier wrote:
> @@ -691,14 +692,71 @@ static int sfp_i2c_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
>  	return ret == ARRAY_SIZE(msgs) ? len : 0;
>  }
>  
> -static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
> +static int sfp_smbus_byte_read(struct sfp *sfp, bool a2, u8 dev_addr,
> +			       void *buf, size_t len)
>  {
> -	if (!i2c_check_functionality(i2c, I2C_FUNC_I2C))
> -		return -EINVAL;
> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	union i2c_smbus_data smbus_data;

Minor nit: please respect the reverse christmas tree order above.

> +	u8 *data = buf;
> +	int ret;
> +
> +	while (len) {
> +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
> +				     I2C_SMBUS_READ, dev_addr,
> +				     I2C_SMBUS_BYTE_DATA, &smbus_data);
> +		if (ret < 0)
> +			return ret;
> +
> +		*data = smbus_data.byte;
> +
> +		len--;
> +		data++;
> +		dev_addr++;
> +	}
> +
> +	return data - (u8 *)buf;
> +}
> +
> +static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
> +				void *buf, size_t len)
> +{
> +	u8 bus_addr = a2 ? 0x51 : 0x50;
> +	union i2c_smbus_data smbus_data;

same here.

Thanks,

Paolo


