Return-Path: <linux-kernel+bounces-247853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3F92D595
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC881C21362
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BC6194A5E;
	Wed, 10 Jul 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hAVRkr+g"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8C194126
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627189; cv=none; b=JfYaRG2fTzgGtWCVog7SJHlFGbnRp9PrgYXDwWd5xVFd5OBNsbDub9VkWL/6RzS5E86IEljgzpWf8W0FhRE/zC1TUi0G3dy/Cm0WxKtljEXozBW8nrU8U1BiiL/N30cqfvkjFheoxA3qVQmS6M6eCkMjLSJArpFO5Dh6Sl8WGFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627189; c=relaxed/simple;
	bh=ar5c/kcYZA38v5PH246OzfRNY9cpIC7n1xJjZdWUz4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUU5AmTTGOJaq8ZBmXyaaPF/kZ/5mILZWXpnbQWDWfxRPAhAWboM+994vN1mR1Lj8EdYC/a8KfwGnwQETKconcaMkBd2pZ0phjyvcpI4GXfWEiE3M3vHR0Im698U/8iGlHfAbcsYE7VeSBVzr9y0RqhFiNX3Rd4MZcdN7lnTLgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hAVRkr+g; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-704473c0698so704231a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720627187; x=1721231987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frwA92uLz4k21pIYgm2Hz8f6vblljgbWvTyStEdlCs0=;
        b=hAVRkr+gTYJxSlTxCG5W8X13T/EBDDqkn/2SYDGgbMkmGtQPEBtSoK5GLWLPHnoilN
         O9FoBrhHa6I5a2dAYEljaG9BEvGwaOKuEnt695c+qJwXWZtMz1d4X6vPvSoZDC1XSJuK
         XRDIq8hBpGHyYts6HECCN7j6zIYZeYMbl/Htg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627187; x=1721231987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frwA92uLz4k21pIYgm2Hz8f6vblljgbWvTyStEdlCs0=;
        b=Yta0XzS9TVtTHagFps0NWHN1BT2xZZpOnplA8Zi46221bGRcZqmX9/Yv8X1r8Jlx8/
         Ow1H5F6ezdidSLtyWvraUtomIAgq6Jhm0iEG6fypcfIRKHq4ZVfMOcbpQp3BhqtlimOR
         J7Hfuaus99ZRqF2Nojbi8pV47sNiPpFrmvgqpApt1yh1b0m2ciolW2uVzzXT5v3+H1zs
         Vr8MJCzPnLUCjT89LHuGqN9b7qeVWesLP0OU78EitYpmdSI6jAmVdrTV5CJw2vgRyJNf
         QG54iYSVLo7QHBbZ4kt864Rhj5GYhGYjR4vlCU039fA+t5jFJKcebRKoEZIaGLmjINTD
         TNeg==
X-Gm-Message-State: AOJu0Yzn689vA12T8k1NJdGjjcfUgryfaY4GR7ZOCnsy9/Wp/hrg+6v9
	vUvd+ec5YJ5CH9QF0kREuf+TGaULbRQzBRoDeVVpfdmq+x9JMUYe2uM49LRzZhdugeEAfl0Eqj6
	dxR8L
X-Google-Smtp-Source: AGHT+IHQd1wRZbU5o4u7yMeQfsiglGBYbW3Iq06FisQsJR+z7eB48QHhxL6hBEV3g7dd48wKMt7OTA==
X-Received: by 2002:a05:6830:388d:b0:707:1794:6f9c with SMTP id 46e09a7af769-70717947304mr528728a34.22.1720627186789;
        Wed, 10 Jul 2024 08:59:46 -0700 (PDT)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374fc0bb0sm892407a34.60.2024.07.10.08.59.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:59:46 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c2011716a3so2431118eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:59:46 -0700 (PDT)
X-Received: by 2002:a05:6870:2254:b0:25e:1688:ddd7 with SMTP id
 586e51a60fabf-25eaec756d6mr4635383fac.58.1720627185644; Wed, 10 Jul 2024
 08:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610132513.1.I6434acf426183b4077ba3e8af4eccaa5921c6c2f@changeid>
 <CAK+PMK4Vbka3XhbXJHmWJRHD4WVe_k9yvRMw71r+n28Jp5cyvA@mail.gmail.com>
In-Reply-To: <CAK+PMK4Vbka3XhbXJHmWJRHD4WVe_k9yvRMw71r+n28Jp5cyvA@mail.gmail.com>
From: Jett Rink <jettrink@chromium.org>
Date: Wed, 10 Jul 2024 09:59:34 -0600
X-Gmail-Original-Message-ID: <CAK+PMK568x+TCvYnkBVsssNSMNc8ZO8Fo8JX9xtzcj+1Wta24A@mail.gmail.com>
Message-ID: <CAK+PMK568x+TCvYnkBVsssNSMNc8ZO8Fo8JX9xtzcj+1Wta24A@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add new device/vendor ID 0x50666666
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Would it be possible to get feedback on this patch that just adds a
new DID_VID please?

-Jett


On Wed, Jun 26, 2024 at 8:03=E2=80=AFAM Jett Rink <jettrink@chromium.org> w=
rote:
>
> I wanted to check the status of this review. Is there something I did
> incorrectly?
>
> -Jett
>
> On Mon, Jun 10, 2024 at 1:25=E2=80=AFPM Jett Rink <jettrink@chromium.org>=
 wrote:
> >
> > Accept another DID:VID for the next generation Google TPM. This TPM
> > has the same Ti50 firmware and fulfills the same interface.
> >
> > Signed-off-by: Jett Rink <jettrink@chromium.org>
> > ---
> >
> >  drivers/char/tpm/tpm_tis_i2c_cr50.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm=
_tis_i2c_cr50.c
> > index 86c9a1a43adb..d9b6abdcda5f 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > @@ -32,7 +32,8 @@
> >  #define TPM_CR50_TIMEOUT_SHORT_MS      2               /* Short timeou=
t during transactions */
> >  #define TPM_CR50_TIMEOUT_NOIRQ_MS      20              /* Timeout for =
TPM ready without IRQ */
> >  #define TPM_CR50_I2C_DID_VID           0x00281ae0L     /* Device and v=
endor ID reg value */
> > -#define TPM_TI50_I2C_DID_VID           0x504a6666L     /* Device and v=
endor ID reg value */
> > +#define TPM_TI50_DT_I2C_DID_VID                0x504a6666L     /* Devi=
ce and vendor ID reg value */
> > +#define TPM_TI50_OT_I2C_DID_VID                0x50666666L     /* Devi=
ce and vendor ID reg value */
> >  #define TPM_CR50_I2C_MAX_RETRIES       3               /* Max retries =
due to I2C errors */
> >  #define TPM_CR50_I2C_RETRY_DELAY_LO    55              /* Min usecs be=
tween retries on I2C */
> >  #define TPM_CR50_I2C_RETRY_DELAY_HI    65              /* Max usecs be=
tween retries on I2C */
> > @@ -781,13 +782,17 @@ static int tpm_cr50_i2c_probe(struct i2c_client *=
client)
> >         }
> >
> >         vendor =3D le32_to_cpup((__le32 *)buf);
> > -       if (vendor !=3D TPM_CR50_I2C_DID_VID && vendor !=3D TPM_TI50_I2=
C_DID_VID) {
> > +       if (vendor !=3D TPM_CR50_I2C_DID_VID &&
> > +           vendor !=3D TPM_TI50_DT_I2C_DID_VID &&
> > +           vendor !=3D TPM_TI50_OT_I2C_DID_VID) {
> >                 dev_err(dev, "Vendor ID did not match! ID was %08x\n", =
vendor);
> >                 return -ENODEV;
> >         }
> >
> >         dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> > -                vendor =3D=3D TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
> > +                vendor =3D=3D TPM_CR50_I2C_DID_VID    ? "cr50" :
> > +                vendor =3D=3D TPM_TI50_DT_I2C_DID_VID ? "ti50 DT" :
> > +                                                    "ti50 OT",
> >                  client->addr, client->irq, vendor >> 16);
> >         return tpm_chip_register(chip);
> >  }
> > --
> > 2.45.2.505.gda0bf45e8d-goog
> >

