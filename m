Return-Path: <linux-kernel+bounces-512842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368CDA33E54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EE23A58E5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D93F21D3DB;
	Thu, 13 Feb 2025 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twS3QFWf"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47108212FB1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447105; cv=none; b=te/3xU+wOqvgT9ycEOperb0i99L6A0MA5cYw1ttuV40Z+jyJIIBwcV4pqUxxUpyI7wLBAH32efHyW9/dMgl8TKItuXVcbZgIFI6pafWp8+hZSR6WTUnpLXzmKx1SEB09M3PtcO4D1lHkkVCFWEMoLV6OtE+8A2JRnSao4cJZPcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447105; c=relaxed/simple;
	bh=7PtZe0tSJIetPwypQyiZo24A/z2QBMIiJyjFAjqbFBc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LmfMg+twgyYxLBifCVnCwt7HvezCOYE4e3DPwDSKEg0Jnd85Ew8PnR5rD0GWx5nZJ/ZpZjo8RLy1GuW6VH3j1y4YvUZfTClXUQ8CLmuz+03mhH7lqnU4BtPsJa1HrgQGIBi9Bwc2kafI5gm4ltZj1Q+obqoYsqhe8uvnyAsNBXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=twS3QFWf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so5299985e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739447100; x=1740051900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B864o0fggh+K1JfNxHrkc432l7fxNgcBloINRuCFBwY=;
        b=twS3QFWfAlmH026H6yFe9sNWWcDXHLNDQ6d3N2Fw7niGxOd5nbZZTVbK3Cbr/rad8o
         2mg2LEnpIORi7F9SCkAFkw70/xvVYXq5omR60cFAhAYRR3+Z/aucvLdPDjmJ/OWsJBeR
         ViQKiz/q32m78pAU7gH/5y/junQsVILhIgaW46HGFRueeypIBl5rVHOI9IkZ5eeNaKlP
         r8vcL8aMEidy7c3wUqpIC3hkTmvuEMikSzt6WknrmuaZOv3RB/tUtbk0ebp+qfistzOa
         Ymppjaav8JiRpPcTqrzEAL6VRN4TRQt2BnMtLVeRhCpd1u9t3ZNFyi/bggO0tImbJZuJ
         YPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739447100; x=1740051900;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B864o0fggh+K1JfNxHrkc432l7fxNgcBloINRuCFBwY=;
        b=M30ZpIfiPuZUQXF9nXr8zebBjO+BoYL9ZDZyvOVD2v95xYi47owU5iYxuyC41jV60q
         g1wkx9R+nuGrgJRfjqQTiklZupGu7mJ89X4eO0b0sUxJnq61d69QHOxe8U/YW/Jkxumd
         wDHEwxZVnikLFHUglTS5j8ynCIVzh09LA3UwzGhIDBlXB2jxSxKtL6sAaJFgTwEkDaad
         AQpvLyFuRpQK94vODDJLL78L5WGnsodd1pdRUZPNIIPjQjfvkgkXil+mT+LsZBpXDxFD
         MdDBm7JtMxKqSmxHwR0162+nU6E8Bdqz89Oa86rTPys2iNAthSphSC7zmZHlD+Rl/LYT
         O1mA==
X-Forwarded-Encrypted: i=1; AJvYcCXDaFN4/sdsYUrzJcOwa8j3iZglZJc4VP7CKxu7mdJ7RsvXvih22G688Jdb3+I2GsRc73TidJGti4FqJwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp8mBQDAb2aH0mujiT0wujrTrP6r67n7/5DTC2fOEA1OeLrQ9P
	V+4/C0lo0pDoR4KX2xT3l92iXzmqspnrKBH7b6iMRkAqVn4QV53jzQKZ+MRcVABDgRvOz2/VaM2
	QvIY=
X-Gm-Gg: ASbGncu0cvO0hCZAM3a36vvXXKPJlJsdplM8mlVdXHu8/3/ucp2BuQYmzYS7+q6CRSE
	KZ67sGsxyTh0q1zbLpohSk8Xx2OOQfOAlss6S9yXO1XqVfFcgeMPYigSfm838Nwd9bUot8oOvEI
	zNXYQ9Iz6U+SoWqPgAwBlGl0msl0PNn1sjF0glkAM8Frwo8vcT62cAKwMXFEcJyrHo2LyU1NEk9
	RrdIOjqbFpH6ZLk9B0gSeTR72XeVty960KUsralidC4sczxo1uhnOHaLKECJXgFkEGzbnWKqLq0
	90ZHYTRRkfH/W7BJQDQ=
X-Google-Smtp-Source: AGHT+IHKD0ms8VgaTWGBDJMvklWj7HpF1w1pq+OTWxzqSwoHxcvtoBbQvKht7o4Zc8bM5Shdt4UGsA==
X-Received: by 2002:a5d:584e:0:b0:38d:d79a:f82a with SMTP id ffacd0b85a97d-38dea256f8emr5496991f8f.7.1739447100552;
        Thu, 13 Feb 2025 03:45:00 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b41b5sm1688110f8f.14.2025.02.13.03.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:45:00 -0800 (PST)
Message-ID: <58af4b607adbe74725d4869f8f5a09cd5d3be2d3.camel@linaro.org>
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: better interrupt name
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Will
 McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-usb@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2025 11:44:59 +0000
In-Reply-To: <2025021302-malformed-captivity-e862@gregkh>
References: <20250213-max33359-irq-name-v1-1-1900da7a1e79@linaro.org>
	 <2025021302-malformed-captivity-e862@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Greg,

On Thu, 2025-02-13 at 11:11 +0100, Greg Kroah-Hartman wrote:
> On Thu, Feb 13, 2025 at 09:37:54AM +0000, Andr=C3=A9 Draszik wrote:
> > This changes the output of /proc/interrupts from the non-descriptive:
> > =C2=A0=C2=A0=C2=A0 1-0025
> > (or similar) to a more descriptive:
> > =C2=A0=C2=A0=C2=A0 1-0025-max33359
> >=20
> > This makes it easier to find the device, in particular if there are
> > multiple i2c devices, as one doesn't have to remember (or lookup) where
> > it is located.
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > =C2=A0drivers/usb/typec/tcpm/tcpci_maxim_core.c | 13 ++++++++++---
> > =C2=A01 file changed, 10 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/ty=
pec/tcpm/tcpci_maxim_core.c
> > index fd1b80593367..46fc626589db 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> > @@ -420,12 +420,14 @@ static irqreturn_t max_tcpci_isr(int irq, void *d=
ev_id)
> > =C2=A0	return IRQ_WAKE_THREAD;
> > =C2=A0}
> > =C2=A0
> > -static int max_tcpci_init_alert(struct max_tcpci_chip *chip, struct i2=
c_client *client)
> > +static int max_tcpci_init_alert(struct max_tcpci_chip *chip,
> > +				struct i2c_client *client,
> > +				const char *name)
> > =C2=A0{
> > =C2=A0	int ret;
> > =C2=A0
> > =C2=A0	ret =3D devm_request_threaded_irq(chip->dev, client->irq, max_tc=
pci_isr, max_tcpci_irq,
> > -					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
> > +					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), name,
> > =C2=A0					chip);
> > =C2=A0
> > =C2=A0	if (ret < 0)
> > @@ -485,6 +487,7 @@ static int max_tcpci_probe(struct i2c_client *clien=
t)
> > =C2=A0	int ret;
> > =C2=A0	struct max_tcpci_chip *chip;
> > =C2=A0	u8 power_status;
> > +	const char *name;
> > =C2=A0
> > =C2=A0	chip =3D devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> > =C2=A0	if (!chip)
> > @@ -531,7 +534,11 @@ static int max_tcpci_probe(struct i2c_client *clie=
nt)
> > =C2=A0
> > =C2=A0	chip->port =3D tcpci_get_tcpm_port(chip->tcpci);
> > =C2=A0
> > -	ret =3D max_tcpci_init_alert(chip, client);
> > +	name =3D devm_kasprintf(&client->dev, GFP_KERNEL, "%s-%s",
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_name(&client->dev), client->name=
);
> > +	if (!name)
> > +		return -ENOMEM;
>=20
> Please always test your code before sending it out.=C2=A0 You just leaked=
 a
> bunch of stuff here :(

Thanks for the review!

I can not see what leak you're referring to. Could you please clarify?

Thanks,
Andre'


