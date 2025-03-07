Return-Path: <linux-kernel+bounces-550747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A7A5639E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD2C7A47EF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996951FFC44;
	Fri,  7 Mar 2025 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="Q+km1ios"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18C1EA7E5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339249; cv=none; b=uCv8TaZ8Gm7TyXXK34zrFIF8E9UtzpI/VI0V61srfqm1XY31WWGzV/0nJYoV481EiiJVyeCnyoxqmzdn7rlhdQzHZIIAteQx8YWC2ggyk3tRNmIMt0uv4AjMdHZp17hNtigRwYbqnbHZ8dB0ZJr1RJwhkLZqpGNw02FM+yPlL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339249; c=relaxed/simple;
	bh=EOlxAY75X3y75FmTSYltFrdpLHUb9MhwojT4GfBHpHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5eK4+8hyQJnRzuYzF1YOHnMqnXhvYTQLQPi1XIyUMY+xkJRWi8c64YKba36UB7KEy9qCA55IJ40BuI20DIQjLjfnGFbmHO+xnktjUDXtxr7sM0FYE8T4noq6K/PfkjjnlQFPOfR9sOL8I/r6DH5NrtNH84+EhIVY1ulV+gi6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=Q+km1ios; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6feab7c5f96so13070077b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741339245; x=1741944045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36Mpzl2g2Ql1mD+GBxk6knfh/edalweU17g5lOUxsW8=;
        b=Q+km1iosgOVCg1c/cVYg0XWToFQVFGoy+wBvwYQP5TBvGeRbpQ0uTCbFRao8YcCJ8M
         UyDIaHd9KduFS6WGRq5eWiE/UtJbg+eDqY0rh0Lh+YeAPSQwExKxCxwSuEmQM8M2IPpp
         koRErXQNR96Ixn1JDfRdiWMUE8x5PlUg4Vswk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339245; x=1741944045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36Mpzl2g2Ql1mD+GBxk6knfh/edalweU17g5lOUxsW8=;
        b=IBVANs90Aj+nRpR60OSkg+LzM7P0h0lBqi/Qqw+9nkwRtFPgFtNdyub2s2tn9HZv1i
         0FrA9c3YgUa5Rf+airV5ra99RVCVTjaMMVT9eLbgqroZokEIXHWN/zJim8b/xpuBQLYd
         vn6s+Io4pAV1w+phrSza7o2JesiWRRbGgJ9yIzi0KcAxsfkFxTK3E3XHgWq8OVlnDDQE
         GeesSdqXYhyeZ4wIpm9bMBH1Q04h6CTL0ENFWB2w70PJdO/chgXKCzgIwPcZc46AoETK
         WOfuLmZr76seoh4gT5jcj6Qf0e+bCk8NnL897ZFXHJw8C+F8hg4LgPLOfrtghNCtu3qf
         Su9g==
X-Forwarded-Encrypted: i=1; AJvYcCV/XTgL+PayVZ48N9rpid4hBr1Oq9+8OgXfNXiIQS4sQTBLwsGhuNo8FEgR9xdiDPCoGkQipaWfHHeBh2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb3JfcGjs2Vq9+9FeVQZd/HDVjQpzODZjJIXimH/AQqxxufOCj
	EId6iUbAFMXfnGxt0rDvsCRmUroTpwXBfEtBGnxESXvNfyqiEOT0+pOkLnvUEHT1ucHlSLcsjfW
	kdQqzdO+kOfpGYAlU/FvnutqgvZ9a+u1XHFZEF2suAb1lnjQ43g==
X-Gm-Gg: ASbGnctIgxVsSJMFKRpyO3OTsct0RU5k5pocXX5i9WHQsvYRmI3K9Rpx1qsBB8EmRXT
	GJTErI3r0QfDHDMUIMfVukBIDMXgh91kh6jIQwDj451NUWFh6OAafv6CTHPCHYaAel9NDMl5IAg
	VAd15JPPl4yvzj+WsxrWTWeLP4
X-Google-Smtp-Source: AGHT+IHHtkHH4bClarTQDPoQzJBWegMQ1mtMdNXXRANxaeOJkqAsFxaY0+fzNWLiByrID1GLClFedxR/3JsQiqYQR4Q=
X-Received: by 2002:a05:690c:638a:b0:6fd:41e1:83d8 with SMTP id
 00721157ae682-6febf2b4c1dmr37667517b3.6.1741339245381; Fri, 07 Mar 2025
 01:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303132124.52811-2-s.seva@4sigma.it> <Z8nDzyVO596rW0Mf@lore-desk>
In-Reply-To: <Z8nDzyVO596rW0Mf@lore-desk>
From: Silvano Seva <s.seva@4sigma.it>
Date: Fri, 7 Mar 2025 10:20:34 +0100
X-Gm-Features: AQ5f1JqmBKwjE_TVrDfV6pHyPYuuWGyYdwJGFXT_yavn6fnYiy4Nyw8ICQE4AUs
Message-ID: <CALKJsrqc__ZeLoZ5V+hBxVMU+Crpv_YG0KM69N1CXuHc_rM-FQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix possible lockup during FIFO read
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: a.greco@4sigma.it, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, 
	"open list:ST LSM6DSx IMU IIO DRIVER" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 4:48=E2=80=AFPM Lorenzo Bianconi <lorenzo@kernel.org=
> wrote:
>
> > Prevent st_lsm6dsx_read_fifo and st_lsm6dsx_read_tagged_fifo functions
> > from falling in an infinite loop in case pattern_len is equal to zero a=
nd
> > the device FIFO is not empty.
> >
> > Signed-off-by: Silvano Seva <s.seva@4sigma.it>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 0a7cd8c1aa33..7f343614f8a5 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -395,12 +395,17 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw=
)
> >       fifo_len =3D (le16_to_cpu(fifo_status) & fifo_diff_mask) *
> >                  ST_LSM6DSX_CHAN_SIZE;
> >       fifo_len =3D (fifo_len / pattern_len) * pattern_len;
> > +     if (!fifo_len)
> > +             return 0;
>
> I do not think this check is necessary since if fifo_len is 0 we will not=
 run
> the for loop, right?

This check is present in the st_lsm6dsx_read_tagged_fifo() function, i
added it here for consistency. I agree with you that is not strictly
necessary.

>
> >
> >       acc_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> >       gyro_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
> >       if (hw->iio_devs[ST_LSM6DSX_ID_EXT0])
> >               ext_sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_EXT0])=
;
> >
> > +     if (!pattern_len)
> > +             pattern_len =3D ST_LSM6DSX_SAMPLE_SIZE;
>
> same here, I do not think pattern_len can be 0 since hw->sip must be grea=
ter
> than 0 in order to enable the FIFO. Moreover, this check should be some l=
ines
> above since we have already divided fifo_len by pattern_len here.
>

There is a situation causing the subsequent for loop to never
terminate, hanging the kernel boot process: given a system which
doesn't have an hardware reset line allowing the kernel to
re-initialize the IMU hardware, in case of an hot reboot the driver
probe() function attempts to flush the FIFO, which may contain some
data, while the hw->sip is zero.
The complete execution path is the following:
- call of st_lsm6dsx_probe();
- allocation of the st_lsm6dsx_hw structure via the devm_kzalloc,
zero-initializing the sip field;
- call of st_lsm6dsx_init_device();
- call of st_lsm6dsx_reset_device();
- call of st_lsm6dsx_flush_fifo();
- call of st_lsm6dsx_read_fifo/st_lsm6dsx_read_tagged_fifo via the
fifo_ops function pointer.

An alternative solution to solve this situation is initializing the
hw->sip field to a sane default value in either the probe() or
init_device() function.

> > +
> >       for (read_len =3D 0; read_len < fifo_len; read_len +=3D pattern_l=
en) {
> >               err =3D st_lsm6dsx_read_block(hw, ST_LSM6DSX_REG_FIFO_OUT=
L_ADDR,
> >                                           hw->buff, pattern_len,
> > @@ -623,6 +628,9 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_h=
w *hw)
> >       if (!fifo_len)
> >               return 0;
> >
> > +     if (!pattern_len)
> > +             pattern_len =3D ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
>
> for the reason above, this is not necessary.
>
> Regards,
> Lorenzo
>
> > +
> >       for (read_len =3D 0; read_len < fifo_len; read_len +=3D pattern_l=
en) {
> >               err =3D st_lsm6dsx_read_block(hw,
> >                                           ST_LSM6DSX_REG_FIFO_OUT_TAG_A=
DDR,
> > --
> > 2.48.1
> >

