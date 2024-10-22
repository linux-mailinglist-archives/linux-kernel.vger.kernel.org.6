Return-Path: <linux-kernel+bounces-375751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEEC9A9A59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBFA1C2135D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 06:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D8814830C;
	Tue, 22 Oct 2024 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zghSAd2L"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0813B280
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729580373; cv=none; b=sWfqcEDe+cximIE9gmgqqXFuoedDlDmBG/IAL/iiCem0qIgcJWeanNdz2JXGoW50GllMQo+DE9/x3gbtK1AM/6bdTP1dBuROJ4cxTd2Y7JK99RFHjYe7mYKQKoQD0qXwyNuyb6DC1nlh+uHSxJFB7srOD0w1Je6g8r9/umfQwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729580373; c=relaxed/simple;
	bh=TvjGSE5GNJjW4VdXHD6cIJ+b9CBXevZuw8+amadgwWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9xOQWdw0W9NRaLrcCfFGN0Q7INZdBShApusqJUkdNTYJaWdJxcNTfrrMu4y7spJbVdFCRDEJHrhUnxZI8hdawAk47BR7FU8IYHzgRti6VULQPrs9tGsw91jmvHDzMuBQsmVtOeCLvU/e1f8vHRTCvXryh7fBbV+CUnpd2WMgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zghSAd2L; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-50d2e71de18so1628817e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729580369; x=1730185169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmrMnZQE3a07XKbFi4coi+hrWjINxdc/YU4ZsynDMvw=;
        b=zghSAd2LEJJ5hlv5Om9FUv2ZOZKJmN9ICEFtjkZpvck+hF2+Opw1yUDq1mUVZNqQX8
         wvD9BSmCOlxRleRgKf1H+aBNnvUYDNBfJFLT/eCWdrWFjLiuLPclgbn3TOOsx7bWZBzq
         5D+rikUMCFpV7mga0qrjzz5S29YWPeArzWrIFEmTISWtpU4qAet45GwNnfeNUBeDWK08
         NEZYGuvuWANZMjyGgH3JRAR2ctiw3zLdr3L2WumaSnqxq7Ds9eSzj8w9M4n5oeae3t8H
         b3/iJll86vPAe0hKjbnJ86H32EY0EcfgieCcomM27mcy5Q+SGQ2FPljkk8ELRCWEg0iz
         q4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729580369; x=1730185169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmrMnZQE3a07XKbFi4coi+hrWjINxdc/YU4ZsynDMvw=;
        b=glaH3FAlpMIu9wDBrWGlRVm22gaisGSJFYAzrLWmgeOUggrk0sdJPQkuaxAgNa3Pih
         VL2JvlE+jkqmgVuS9ny1NCpJ8WHxDJUduM6DzCq8+1vR7v2sF04z9DE6RoeClaM+KIgG
         2SRIlUhKbZBG99ZZb0ZkAhUKajnIWKbnxlkrqVxQau9iXeHOPRc3I9wssrNY2TOmjKxO
         RFAV3l7F+HyLFX3B7cAmMMfOIIPOF4pDd1Wyf3wiIzSdoEXlxvvV7Yfy9SM4VH9dWbwq
         mXaw+Oahbpvi+V72fqd4+vFyoQmC0f7HfA18Id8lVRtbfNl8kC86pjdDno/2w3ENSjQ8
         V1qg==
X-Forwarded-Encrypted: i=1; AJvYcCU6sO+4Y1PdNU0Kn7G08I9oTxULnBVJzGoIYE/LZczlqwLJrgRWje4lK1ZBCmcc4F50vNjPJ7gcNlQT8bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWiwbNeXHEA3uZEW57VLSFGmVGT1aZKJnHoi7BCf4almmYBA4W
	d8Z3dgOC9X+ajzec+9lfOjqEjy5nLgdKhTfTquab7iqxhPVQyu401qsrODpSD1xsc0bK83yGg/0
	pjoLlq9gW/spf0aHA26FTBBKlrkCMVDuYjXgmXQ==
X-Google-Smtp-Source: AGHT+IEX+86wBXIxaEn+JJmosniozV/wBNVR8nbW+AlAIx4DcXOLbFziVIp6cF0B0dDVKfGnCGfxDkGyRjEPYGwyzVk=
X-Received: by 2002:a05:6122:3188:b0:50d:2dd4:e62a with SMTP id
 71dfb90a1353d-50dda3c723emr9671921e0c.13.1729580367724; Mon, 21 Oct 2024
 23:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021130221.1469099-1-aardelean@baylibre.com>
 <20241021130221.1469099-5-aardelean@baylibre.com> <0a7c5305-b4f7-4166-8a8a-05cf6e3273cc@baylibre.com>
In-Reply-To: <0a7c5305-b4f7-4166-8a8a-05cf6e3273cc@baylibre.com>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 22 Oct 2024 09:59:16 +0300
Message-ID: <CA+GgBR_tT5J8Lq7DmSw9GdETiRScXzPzcf5UkDk32GLP8tSrQw@mail.gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: ad7606: rework scale-available to be static
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org, 
	robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com, 
	gstols@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 9:17=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 10/21/24 8:02 AM, Alexandru Ardelean wrote:
> > The main driver for this change is the AD7607 part, which has a scale o=
f
> > "1.220703" for the =C2=B110V range. The AD7607 has a resolution of 14-b=
its.
> >
> > So, just adding the scale-available list for that part would require so=
me
> > quirks to handle just that scale value.
> > But to do it more neatly, the best approach is to rework the scale
> > available lists to have the same format as it is returned to userspace.
> > That way, we can also get rid of the allocation for the 'scale_avail_sh=
ow'
> > array.
> >
> > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > ---
>
> ...
>
>
> >  static ssize_t in_voltage_scale_available_show(struct device *dev,
> >                                              struct device_attribute *a=
ttr,
> >                                              char *buf)
> > @@ -703,8 +690,16 @@ static ssize_t in_voltage_scale_available_show(str=
uct device *dev,
> >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> >       struct ad7606_state *st =3D iio_priv(indio_dev);
> >       struct ad7606_chan_scale *cs =3D &st->chan_scales[0];
> > +     const unsigned int (*vals)[2] =3D cs->scale_avail;
> > +     unsigned int i;
> > +     size_t len =3D 0;
> >
> > -     return ad7606_show_avail(buf, cs->scale_avail, cs->num_scales, tr=
ue);
> > +     for (i =3D 0; i < cs->num_scales; i++)
> > +             len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u "=
,
> > +                              vals[i][0], vals[i][1]);
> > +     buf[len - 1] =3D '\n';
> > +
> > +     return len;
> >  }
> >
> >  static IIO_DEVICE_ATTR_RO(in_voltage_scale_available, 0);
>
> Probably a reason for this that I forgot, but why is this handled in a
> custom attribute instead of ad7606_read_avail()?

[1]
So, this is a quirk of this driver that would require a bigger cleanup.
It could be done as a different series.
Or (otherwise said) I would do it in a different series (unless
requested otherwise).

These device-level attributes are attached in the probe() of this
driver, based on the GPIO configurations provided via DT.
There's that bit of code

        if (st->gpio_os) {
                if (st->gpio_range)
                        indio_dev->info =3D &ad7606_info_os_and_range;
                else
                        indio_dev->info =3D &ad7606_info_os;
        } else {
                if (st->gpio_range)
                        indio_dev->info =3D &ad7606_info_range;
                else
                        indio_dev->info =3D &ad7606_info_no_os_or_range;
        }

The "range" there refers to "scale_available", which is only attached
like this, for HW mode.
A rework of HW-mode would be a good idea.

>
> > @@ -742,6 +737,7 @@ static int ad7606_write_raw(struct iio_dev *indio_d=
ev,
> >                           long mask)
> >  {
> >       struct ad7606_state *st =3D iio_priv(indio_dev);
> > +     unsigned int scale_avail[AD760X_MAX_SCALES];
>
> Calling this scale_avail_uv would make the code easier for me to understa=
nd.

Ack.

>
> >       struct ad7606_chan_scale *cs;
> >       int i, ret, ch =3D 0;
> >
> > @@ -752,7 +748,12 @@ static int ad7606_write_raw(struct iio_dev *indio_=
dev,
> >               if (st->sw_mode_en)
> >                       ch =3D chan->address;
> >               cs =3D &st->chan_scales[ch];
> > -             i =3D find_closest(val2, cs->scale_avail, cs->num_scales)=
;
> > +             for (i =3D 0; i < cs->num_scales; i++) {
> > +                     scale_avail[i] =3D cs->scale_avail[i][0] * 100000=
0 +
>
>                                                                  MICRO

Ack.

>
> > +                                      cs->scale_avail[i][1];
> > +             }
> > +             val =3D val * 1000000 + val2;
> > +             i =3D find_closest(val, scale_avail, cs->num_scales);
> >               ret =3D st->write_scale(indio_dev, ch, i + cs->reg_offset=
);
> >               if (ret < 0)
> >                       return ret;
> > @@ -788,9 +789,15 @@ static ssize_t ad7606_oversampling_ratio_avail(str=
uct device *dev,
> >  {
> >       struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> >       struct ad7606_state *st =3D iio_priv(indio_dev);
> > +     const unsigned int *vals =3D st->oversampling_avail;
> > +     unsigned int i;
> > +     size_t len =3D 0;
> >
> > -     return ad7606_show_avail(buf, st->oversampling_avail,
> > -                              st->num_os_ratios, false);
> > +     for (i =3D 0; i < st->num_os_ratios; i++)
> > +             len +=3D scnprintf(buf + len, PAGE_SIZE - len, "%u ", val=
s[i]);
> > +     buf[len - 1] =3D '\n';
> > +
> > +     return len;
> >  }
> >
> >  static IIO_DEVICE_ATTR(oversampling_ratio_available, 0444,
>
> Same question about ad7606_read_avail() instead for this one.

See [1]

>

