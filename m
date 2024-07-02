Return-Path: <linux-kernel+bounces-237644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6279923C04
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739CB281E01
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAC41591FC;
	Tue,  2 Jul 2024 11:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT0/uhzb"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13F4CDF9;
	Tue,  2 Jul 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918290; cv=none; b=hFihWQQ9ak9/aqeCa7FhRIsawGNPD0lf7F1Ecok29qNkNaqvb9Bfl0ZzEe4Ldiq/r+20RXWeRpwp0VsVPAcja8+1KoBMMRb+RvbkCeiKj2VE1ehek/FB9am5saM5aL9UI0UO7264N0lJoYbe0B/oA8G0xSfaQWjUbjaHfKu+EN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918290; c=relaxed/simple;
	bh=bPk2/IIwST2pJD9LhpzJKQ93eMA0RcRc12FF8ggibBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxmYf4tn4fXiuxj8i5KcEhHSH6oNbKu+FTyKBOb1cZ/6wUDoKPkSmGraT+QlTDLaPBgZwKExmNdlKJQ+TBWcegnkWNKa8rbXJOYrJNVbCDtcphETHo0wT27qjXYteiEzS9OcAEyHDkt1khzDgAwE/wPNmQXkz3a9n0LH7D4xz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT0/uhzb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a72988749f0so606239066b.0;
        Tue, 02 Jul 2024 04:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719918287; x=1720523087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7C2POcto3F3gOVRPECf0Cy4M4QGPtyi7Wen09vwi84=;
        b=lT0/uhzbpACHgWT7nSDMV1q/BPXFbJ280lKnlCXKqodySqaZDxTMN5sz4EQLR7Z2ny
         niSOAVsVDre3Kf8N1cqKKT3BnjyGwsZD5wwH6bqs+jOk/irfMY3jmY1BLWHG8Dk5QgoS
         WTdx0cm37uF/bJK2GTowXcvAVg1dGlIDso8fOsQtTAi3swPatomhfcLPVPwA2Bwj9ymY
         s2gkQbr4TzFfpsWZ7CYqCRhxCwlAcwuK4jCEhhcyRTIqMyNacSlZG9ivDP5uO7TZIzau
         uU/4GrDrxhj5Fjma6kCFzyLgNtxDSMbdb+PlPMnBiJW1SVzZIcNmBEo7QKbsLgDsEbbZ
         UQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719918287; x=1720523087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7C2POcto3F3gOVRPECf0Cy4M4QGPtyi7Wen09vwi84=;
        b=CzfdXVGF6Ok3WYsd/po2SJ1XKH9b3r6yYgkrdYJCTxcBK83xzp3nGirdUgXIrV48tl
         FUtxPc1c9rCxOvoGrnuFEie6a0QXTxGfXspGiy2YwnqGWVFzd6BCryLu6o9tM1ue9OR2
         RmPLNWR/CGziCn+uw1bWuCzmZAlqBF3edFqDT7lIMInW2nfVam26NlOjTT+4/S38Ow3F
         kQuFB75i3KFMpV2t1hnEXowgW4AClfBAMoQ0U8vkluSs06ENbrFxkRODdSWuKPkySjt1
         NObLCGGibmWBMwTGAcWPBF0uu7rfqR6PcjCQlamowwniSVTNINVVjeTNhty4fK0fwOCW
         GT3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnmqkXgv8keg4J3raNKO15hk4v5o+rmuQYWj/xfLxujSxERX8X+wxzQr3xrDY92mogLMXjhDMRXP8jzWQzD5KKgm1iqFJ0neC7kQshSunSqq+FrPEx/1K20bUgGGRZ8OW/NSCpDPLaMc4=
X-Gm-Message-State: AOJu0YwyxYaVmmuSUYIyPx6o90wqOhoZqDDRrvv8+2p5e39okNuWWJ95
	Gq89ALIw3gzXXgUrZ+x7buUdAlQXUowLZVSW7JevmvcxjfJkm8r1LIm13EFEGRvcwYMAFOEXw4p
	GWil5wLXzosUhhYYQcRjdEnd6N27tjZiZ
X-Google-Smtp-Source: AGHT+IGTZWm3mkqa483Gpfcd5M6uFw2wq281cSe1BfyN2Nq/vJFZ/pcKxnlR5hPzqOjus7y5wwWatZOwB4GTYzSc/6M=
X-Received: by 2002:a17:906:c293:b0:a71:94ce:9b03 with SMTP id
 a640c23a62f3a-a751447b1d8mr536870466b.20.1719918287223; Tue, 02 Jul 2024
 04:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701073252.317397-1-chineweff@gmail.com> <6c91530f-00f3-44ed-ae77-312260c2af9e@roeck-us.net>
In-Reply-To: <6c91530f-00f3-44ed-ae77-312260c2af9e@roeck-us.net>
From: Wayne Tung <chineweff@gmail.com>
Date: Tue, 2 Jul 2024 19:04:35 +0800
Message-ID: <CABrnb7xSnrAF66easMHPBs6cFXS7FU+hKAhXDH=DE0EBvAJ3UQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (adt7475) Fix default duty on fan is disabled
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm using adt7475 on the x86 system.
When I tried to probe the driver manually, fans would run at full
speed (It's in disabled mode by default).
It's not the expected behavior.
I traced the driver and found the issue.

Thanks,
Wayne

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2024=E5=B9=B47=E6=9C=882=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=886:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Jul 01, 2024 at 03:32:52PM +0800, Wayne Tung wrote:
> > According to the comments on fan is disabled, we change to manual mode
> > and set the duty cycle to 0.
> > For setting the duty cycle part, the register is wrong. Fix it.
> >
> > Signed-off-by: Wayne Tung <chineweff@gmail.com>
> > ---
>
> Applied.
>
> Curious - how did you find that ? That bug existed since the driver was
> introduced.
>
> Thanks,
> Guenter
>
> >  drivers/hwmon/adt7475.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
> > index 4224ffb30483..ec3336804720 100644
> > --- a/drivers/hwmon/adt7475.c
> > +++ b/drivers/hwmon/adt7475.c
> > @@ -1900,7 +1900,7 @@ static void adt7475_read_pwm(struct i2c_client *c=
lient, int index)
> >               data->pwm[CONTROL][index] &=3D ~0xE0;
> >               data->pwm[CONTROL][index] |=3D (7 << 5);
> >
> > -             i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
> > +             i2c_smbus_write_byte_data(client, PWM_REG(index),
> >                                         data->pwm[INPUT][index]);
> >
> >               i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),

