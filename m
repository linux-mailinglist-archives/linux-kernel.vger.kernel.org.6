Return-Path: <linux-kernel+bounces-530752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E20A437D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B19357A1993
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3C260A23;
	Tue, 25 Feb 2025 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Envf/ird"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7EC16DEA9
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472968; cv=none; b=ftH85Ts0YWEDT9xw86Xyf+W9rhq7L0xXp631qcNWZw1pj7YHRrnQ9ivLm54SWupaF1/sytllA1yRRuwWtHwVVsYS9wzvQ6deu1OqSBBSApiQkpwXmh8T+faa3D+OSu9I91gBr9go2V4eISCBeb0EMHWSwbtenUmvFeD1rgcKKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472968; c=relaxed/simple;
	bh=jRXq8ssUo91/daY5t5TlTKQcS9XD51HyEpcgQhSKrbE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWGRZPVBLVCdPSp4P5cakgIjQ0tNdhZvQYt9chU0GhabAx4et0PDAgByj961+xTXEGzL+InpYfem2gv+ObNrJIds1DalxU/GBUYGsf6Hn6Sovs6pBZWI7Rz2sUzN4Y5YhvGKhO+agrvEh6sMHQjgXuNglR9PjJtJO/9pO7QDU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Envf/ird; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-439946a49e1so33096585e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740472964; x=1741077764; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CqB8W2CJN8Ny6/nq8A+RmCQatW6F2vm+JwrvzYnwz3E=;
        b=Envf/irdgQDveYaozPGPhoMRIgsq1vOoGHoW1F80Gm2t+/+hnzVJb0LLRuSY475sjv
         mnc6Pbh0sFruNLg0dN6H50BpCUPjSdbQ34novZ565DLJ2RkTzykN7saASejA/KGeofuv
         nWKDIrBqMlQGMC7uyeqmADiJ7bAbnOoBR0WlX4+sOQEgVsi2CzfwDeSEb2TIV36FOhvp
         6QDEYkkM6dip30j1toeVqEKX4KC7U4lzqFEyuA+9lCnEU5UBwws03tdZkujjAbfKbtNE
         lvtXROELXADtQGWHtSYbQvhaSSdQXvBYQwbkZRklY5rgdPdW/u+SZmp4fudBi0Vjy5XO
         cnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740472964; x=1741077764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqB8W2CJN8Ny6/nq8A+RmCQatW6F2vm+JwrvzYnwz3E=;
        b=mL4vNS0iiY2eTJLgDTUf3gHDvVQ0jNMUEwIQSaaBrChjmyXhJ3n/lYPwMT+zzzVLe5
         2N7WeXGnVL3r3cgq3wkXMh/9fCiCvl4S8OMXojq/9oPiTF7SEPH1wSbA1O1gqyueBGO0
         JwOa8X7YUTeIl72+cIGATZb2hSku/7Xn+p4ZOdEPpsLLAx/+J8/QtPeXzdPX62ygfQw5
         XF22301ZTR/JQepeJ73QNuIsvUOZteD8xh7peoNTdY7errIUBivwUj7ByM6OJBR07r2u
         GB3XHn2ZkEPlaBXXPcViGW/1LRjCB2ll68JKN3vaTFpB54aKCKmRVfGPyKvrPDX3ZIiF
         3ikA==
X-Forwarded-Encrypted: i=1; AJvYcCVD+zwiKI2/J4cxr8Cn/pA5O1ABMWAxJu3iXWG/Qnfs/UUPd3dpa5aid4b9UHWV+r/J43gtj1jR/xYhS6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNdIn2Ouc2pm7uar5f3m3F6C6QIzEHz5gCSiH5ONveKfmczAJm
	dXvqYrAJkCXzOxrbkvBqRy+xfqUD4O2fVSKSF1kgKnSrtiyxJ+fcSuzl2AIXz6w=
X-Gm-Gg: ASbGncv7GK8YPtufDnqkrqL7TRqu4C9Or5B0vj1USY+U5tSzMkn5e+UF4vxNNTMSo+j
	jBaY4qFcSl/Pkc8ZbEmhf6E4YRzmh+7Pnci4naZQqaIyrm4w0kcv+pLMn6jTUZYo+kPVMffp718
	W6eaIRid7KthojK8rAUiEbpZBxir1zZzsnm2daZbriaZuZIJZdWiyylor1OxB/YImiQ8OKRc4tR
	590dWKacODMSEmBXTVCqaIA9IbsSm7Wl+GEy0nK7oO+mP2gSZAptLTjL+dC+XfXb0sIuIHq1R3b
	i/KCNqZ06UdUkMk+GgCKKGnXr29OGig=
X-Google-Smtp-Source: AGHT+IGJgd1NygEBIqg6/grk4B+Un8Sa506Ytea8slhBHwOSxzKdp9L8SvAlX2UbbxiCmluDx72reQ==
X-Received: by 2002:a05:600c:1910:b0:439:9225:2f50 with SMTP id 5b1f17b1804b1-439ae1f1586mr165534235e9.16.1740472964310;
        Tue, 25 Feb 2025 00:42:44 -0800 (PST)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab1539dc0sm17679615e9.9.2025.02.25.00.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 00:42:43 -0800 (PST)
Message-ID: <a4b065a1b96cf87078320374f7a682b3e3762336.camel@linaro.org>
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: better interrupt name
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: William McVicker <willmcvicker@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, kernel-team@android.com,
 linux-usb@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 25 Feb 2025 08:42:43 +0000
In-Reply-To: <Z6-8Q9oDj04NurJ5@google.com>
References: <20250213-max33359-irq-name-v1-1-1900da7a1e79@linaro.org>
	 <Z6-8Q9oDj04NurJ5@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Will,

On Fri, 2025-02-14 at 13:57 -0800, William McVicker wrote:
> On 02/13/2025, Andr=C3=A9 Draszik wrote:
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
> > +	ret =3D max_tcpci_init_alert(chip, client, name);
> > =C2=A0	if (ret < 0)
> > =C2=A0		return dev_err_probe(&client->dev, ret,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "IRQ initialization failed\n");
>=20
> Can you just change the `init_name` instead like this?
>=20
> =C2=A0 chip->client->dev.init_name =3D name;
>=20
> That way calling `dev_name()` will get you this more informative name as =
well?

I don't think that member is supposed to be set by anybody. Looking
at device_add(), this seems to only be meant to be statically set
by statically allocated devices and is cleared upon device_add().
Essentially no driver sets this in the kernel.

So it doesn't appear to be appropriate.

Cheers,
Andre'


