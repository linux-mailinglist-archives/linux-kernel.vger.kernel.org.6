Return-Path: <linux-kernel+bounces-177932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE22A8C4663
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9439E281CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C66622EE5;
	Mon, 13 May 2024 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV8PZQpP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7ED224CC
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622307; cv=none; b=ZMFoeDhttVGp2fjho47KYZk3hXrh8Nk+KgRuo9xSHr1IG5RBjzETc3p7S19+yn8JL5sVol/LJdSL4OWAnBo8g4gYiQDKZx5LwImTfCdMQmEpO83fbYSJryb5BgnAF2fZJ09g5SZqZgifVO3r278RvW9BVcmpLmE6fvVYELVwo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622307; c=relaxed/simple;
	bh=2rezK1XL/74bCQlLzdhDVSkMiRYcS8LmC2OnklHjGaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDoGKZLYVoUbM2mRvsEU+rQNQVfMsCRuzMuUdGR37WMyeN/PJCkcAKcQPLiS3RT6MRHEy/DaP95CTEtzOuoiFmAQ30Y4TgMGi3k2QOSjuMonnQ0ayRjGimLP/m+kiQjRGoySVMinOW1o6Uh658qmlXR+Sb98q1vUHPrc5VUXFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV8PZQpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABAFC4AF13
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715622306;
	bh=2rezK1XL/74bCQlLzdhDVSkMiRYcS8LmC2OnklHjGaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FV8PZQpPyPmDlglxw4Dg51arwE5HjX7K5iWHJx6RIYBi5AtTOyAwbkSnEyLYl85Ds
	 CU2Ik+LWi9g4K6uCwdbsdoxLI+1JfeTYMeFPb4ws3Ddd3jXO6uwMSp53mZOm2hT4zS
	 2MkyzeFe+p8Mp6RdKxb2ZX+0MRY9i8ekgBLwRlafdC1JV+zEtrHMX3Up0VT0oocRIr
	 A6ZEVxZqy0KcVJucycDkgkq3LgccDRHndzsPHmcwhm/qHFYPv1v/R1UdC7JQ4zo+6L
	 lFMRga04noBuoVzPgVMlY45axmYkpKzFwotqhQHjiJkWCzFuC5HBwy2rLtceF4O6HL
	 GbupwrzCG2HfQ==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de5acdb3838so4715026276.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:45:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXe4xHUGkukGKLY+rW39OK6N1anGVy617lKxvzOsfHo+Ng8gJqoqie4VKwF8RWspwpDCrHU16jUe3rFXN5LJ/pipKrdeuTd87f8vWmZ
X-Gm-Message-State: AOJu0YxrzlkVlH2VimOJ4c0nXDMbrWLTMZKVNJNEuTPGsuNLcxJgrzOm
	UjFHe7VPaBi3tlfItknGsESlfsTQ/GxzBJxX8m46LPEUcTvm8xswW5+9Ueglc05BMUj3p+Ty/rM
	N/YarQrrpuY0GIi+6p9qz4KuqS5HOgzDTiMqsxg==
X-Google-Smtp-Source: AGHT+IFOJ4tybZ9ppj6693Jo6eHIZkd9mIjZAeRXGoyIuu0UFbmcIOOVX5DDCrD/CM348EaQz00MTgYp2cuTxQSpREg=
X-Received: by 2002:a25:bc8f:0:b0:dee:6346:b856 with SMTP id
 3f1490d57ef6-dee6346bbaemr6453224276.34.1715622305916; Mon, 13 May 2024
 10:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506094644.887842-1-kuro.chung@ite.com.tw>
 <20240506094644.887842-2-kuro.chung@ite.com.tw> <CAN6tsi5b50fqgbph4waTuqVO=vjEUCCjSOZYzj6O9Fgg-6Wjfw@mail.gmail.com>
In-Reply-To: <CAN6tsi5b50fqgbph4waTuqVO=vjEUCCjSOZYzj6O9Fgg-6Wjfw@mail.gmail.com>
From: Robert Foss <rfoss@kernel.org>
Date: Mon, 13 May 2024 19:44:55 +0200
X-Gmail-Original-Message-ID: <CAN6tsi6s4q+Lm9xF5iBQiSVGAkGhMg6nCPy4OEwfqmWtNwbr_g@mail.gmail.com>
Message-ID: <CAN6tsi6s4q+Lm9xF5iBQiSVGAkGhMg6nCPy4OEwfqmWtNwbr_g@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] drm/bridge: it6505: fix hibernate to resume no
 display issue
To: kuro <kuro.chung@ite.com.tw>
Cc: Allen Chen <allen.chen@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>, 
	Kenneth Haung <kenneth.hung@ite.com.tw>, 
	Kuro Chung <kuro.chung@ite.corp-partner.google.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 7:42=E2=80=AFPM Robert Foss <rfoss@kernel.org> wrot=
e:
>
> On Mon, May 6, 2024 at 11:36=E2=80=AFAM kuro <kuro.chung@ite.com.tw> wrot=
e:
> >
> > From: Kuro <kuro.chung@ite.com.tw>
> >
> > ITE added a FIFO reset bit for input video. When system power resume,
> > the TTL input of it6505 may get some noise before video signal stable
> > and the hardware function reset is required.
> > But the input FIFO reset will also trigger error interrupts of output m=
odule rising.
> > Thus, it6505 have to wait a period can clear those expected error inter=
rupts
> > caused by manual hardware reset in one interrupt handler calling to avo=
id interrupt looping.
> >
> > Signed-off-by: Kuro Chung <kuro.chung@ite.corp-partner.google.com>
> >
> > ---
> >  drivers/gpu/drm/bridge/ite-it6505.c | 73 +++++++++++++++++++----------
> >  1 file changed, 49 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/brid=
ge/ite-it6505.c
> > index b53da9bb65a16..64e2706e3d0c3 100644
> > --- a/drivers/gpu/drm/bridge/ite-it6505.c
> > +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> > @@ -1317,9 +1317,15 @@ static void it6505_video_reset(struct it6505 *it=
6505)
> >         it6505_link_reset_step_train(it6505);
> >         it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_VID_MUTE, EN_VID=
_MUTE);
> >         it6505_set_bits(it6505, REG_INFOFRAME_CTRL, EN_VID_CTRL_PKT, 0x=
00);
> > -       it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, VIDEO_RESE=
T);
> > +
> > +       it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, TX_FI=
FO_RESET);
> > +       it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, 0x00)=
;
> > +
> >         it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, RST_50=
1_FIFO);
> >         it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, 0x00);
> > +
> > +       it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, VIDEO_RESE=
T);
> > +       usleep_range(1000, 2000);
> >         it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, 0x00);
> >  }
> >
> > @@ -2249,12 +2255,11 @@ static void it6505_link_training_work(struct wo=
rk_struct *work)
> >         if (ret) {
> >                 it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> >                 it6505_link_train_ok(it6505);
> > -               return;
> >         } else {
> >                 it6505->auto_train_retry--;
> > +               it6505_dump(it6505);
> >         }
> >
> > -       it6505_dump(it6505);
> >  }
> >
> >  static void it6505_plugged_status_to_codec(struct it6505 *it6505)
> > @@ -2475,31 +2480,53 @@ static void it6505_irq_link_train_fail(struct i=
t6505 *it6505)
> >         schedule_work(&it6505->link_works);
> >  }
> >
> > -static void it6505_irq_video_fifo_error(struct it6505 *it6505)
> > +static bool it6505_test_bit(unsigned int bit, const unsigned int *addr=
)
> >  {
> > -       struct device *dev =3D &it6505->client->dev;
> > -
> > -       DRM_DEV_DEBUG_DRIVER(dev, "video fifo overflow interrupt");
> > -       it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> > -       flush_work(&it6505->link_works);
> > -       it6505_stop_hdcp(it6505);
> > -       it6505_video_reset(it6505);
> > +       return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE))=
;
> >  }
> >
> > -static void it6505_irq_io_latch_fifo_overflow(struct it6505 *it6505)
> > +static void it6505_irq_video_handler(struct it6505 *it6505, const int =
*int_status)
> >  {
> >         struct device *dev =3D &it6505->client->dev;
> > +       int reg_0d, reg_int03;
> >
> > -       DRM_DEV_DEBUG_DRIVER(dev, "IO latch fifo overflow interrupt");
> > -       it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> > -       flush_work(&it6505->link_works);
> > -       it6505_stop_hdcp(it6505);
> > -       it6505_video_reset(it6505);
> > -}
> > +       /*
> > +        * When video SCDT change with video not stable,
> > +        * Or video FIFO error, need video reset
> > +        */
> >
> > -static bool it6505_test_bit(unsigned int bit, const unsigned int *addr=
)
> > -{
> > -       return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE))=
;
> > +       if ((!it6505_get_video_status(it6505) &&
> > +               (it6505_test_bit(INT_SCDT_CHANGE, (unsigned int *) int_=
status))) ||
> > +               (it6505_test_bit(BIT_INT_IO_FIFO_OVERFLOW, (unsigned in=
t *) int_status)) ||
> > +               (it6505_test_bit(BIT_INT_VID_FIFO_ERROR, (unsigned int =
*) int_status))) {
> > +
> > +               it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> > +               flush_work(&it6505->link_works);
> > +               it6505_stop_hdcp(it6505);
> > +               it6505_video_reset(it6505);
> > +
> > +               usleep_range(10000, 11000);
> > +
> > +               /*
> > +                * Clear FIFO error IRQ to prevent fifo error -> reset =
loop
> > +                * HW will trigger SCDT change IRQ again when video sta=
ble
> > +                */
> > +
> > +               reg_int03 =3D it6505_read(it6505, INT_STATUS_03);
> > +               reg_0d =3D it6505_read(it6505, REG_SYSTEM_STS);
> > +
> > +               reg_int03 &=3D (BIT(INT_VID_FIFO_ERROR) | BIT(INT_IO_LA=
TCH_FIFO_OVERFLOW));
> > +               it6505_write(it6505, INT_STATUS_03, reg_int03);
> > +
> > +               DRM_DEV_DEBUG_DRIVER(dev, "reg08 =3D 0x%02x", reg_int03=
);
> > +               DRM_DEV_DEBUG_DRIVER(dev, "reg0D =3D 0x%02x", reg_0d);
> > +
> > +               return;
> > +       }
> > +
> > +
> > +       if (it6505_test_bit(INT_SCDT_CHANGE, (unsigned int *) int_statu=
s))
> > +               it6505_irq_scdt(it6505);
> >  }
> >
> >  static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
> > @@ -2512,15 +2539,12 @@ static irqreturn_t it6505_int_threaded_handler(=
int unused, void *data)
> >         } irq_vec[] =3D {
> >                 { BIT_INT_HPD, it6505_irq_hpd },
> >                 { BIT_INT_HPD_IRQ, it6505_irq_hpd_irq },
> > -               { BIT_INT_SCDT, it6505_irq_scdt },
> >                 { BIT_INT_HDCP_FAIL, it6505_irq_hdcp_fail },
> >                 { BIT_INT_HDCP_DONE, it6505_irq_hdcp_done },
> >                 { BIT_INT_AUX_CMD_FAIL, it6505_irq_aux_cmd_fail },
> >                 { BIT_INT_HDCP_KSV_CHECK, it6505_irq_hdcp_ksv_check },
> >                 { BIT_INT_AUDIO_FIFO_ERROR, it6505_irq_audio_fifo_error=
 },
> >                 { BIT_INT_LINK_TRAIN_FAIL, it6505_irq_link_train_fail }=
,
> > -               { BIT_INT_VID_FIFO_ERROR, it6505_irq_video_fifo_error }=
,
> > -               { BIT_INT_IO_FIFO_OVERFLOW, it6505_irq_io_latch_fifo_ov=
erflow },
> >         };
> >         int int_status[3], i;
> >
> > @@ -2550,6 +2574,7 @@ static irqreturn_t it6505_int_threaded_handler(in=
t unused, void *data)
> >                         if (it6505_test_bit(irq_vec[i].bit, (unsigned i=
nt *)int_status))
> >                                 irq_vec[i].handler(it6505);
> >                 }
> > +               it6505_irq_video_handler(it6505, (unsigned int *) int_s=
tatus);
> >         }
> >
> >         pm_runtime_put_sync(dev);
> > --
> > 2.25.1
> >
>
> Reviewed-by: Robert Foss <rfoss@kernel.org>

This patch does not apply on drm-misc-next, please fix this and then
this patch is ready to be applied.

