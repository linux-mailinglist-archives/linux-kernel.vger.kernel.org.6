Return-Path: <linux-kernel+bounces-184958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB7A8CAE82
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54891F22F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D082574E11;
	Tue, 21 May 2024 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bs1YC+i+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E52F5B
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716295625; cv=none; b=sm31K/NVcGTd+dX3PHUpn0yTLNDKPvLZuPzung+H+90ROtJe7/MKSYIKsN5uuufwLrFEAsk9/xzi3FfBzq5iSCesWAWukOH/BHQShPCAoMe11N0fY141n1DOXFIM51mOSinACa0Zv2fbFq9vhrbe7m3rzeGK6rGnngVVnvUC+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716295625; c=relaxed/simple;
	bh=XrmoUJhlU/7bc8VrKrGuLyJ3TJTPjZrW2vhspqHfNdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeZ6mSwbx6rHkvgG6RAxThedvxKeOAmpdw29yPFoO/1l0QhyD0kWroHcb0GUOOkiINvRhcWXySjqMeezXFBh1G8oSWTdCOYlHHN4w/uppierzpXEo5SlNgv1mFK8hMlM93EIm/KsNeLL1UBvMamwewT54S242sOmwuz+e2lsKbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bs1YC+i+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560EAC4AF18
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 12:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716295625;
	bh=XrmoUJhlU/7bc8VrKrGuLyJ3TJTPjZrW2vhspqHfNdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bs1YC+i+B0zqCkEQPSnVW00xHFKrAIpmcQuRqQ21Ag9g/wMtZzc+Kv6+LjP9KrdMp
	 l9nLroAlertIVW1wMIk4znNsWrp51c4IDMypVHGcOUy9+M3mr+mDcCJkJR3lBjZ+Ap
	 eFYVp5eOr4uRF0PN+5V/0kulCaIcwL/VMROqVue5eIOjQOLHO9f2rzxhdu/ALc1DeM
	 6Pk4bSJSjBbr+IfwVIP8X8YibK9qF3Ehft5/v4AwS+pTp0WmONUj20xb6q1qNJj5FZ
	 hBOjV57mXg9GHgqarLkIF9/r+DdSW2F6x0Cfk4XP5bxpGyq6klXCH+FQMf4jn74iaF
	 WjIbbYUrL39jw==
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-deb5f006019so3361067276.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 05:47:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcTTiAJCb9lw9f2rAWqtyYrM0nMKHg8IMbMbDKgoD5PMGTxbWFJRhM8gbk2HIt23ZBG8a9tiC6WRWqR80Zw8ayAKbQW5j46649TT50
X-Gm-Message-State: AOJu0YwtJ5JOiUExSUc81bokkRrWo7UrP3qFGzRXZO0o5Xl5kbBRUZVD
	WQ8kywjZPDJ+D42ZOLG1ToKd7rY76PIoQ/hHNh7kPmPxo8EKBaPajI+ERTLTwzYPNitiTXP2rvl
	2SvWLsilZI2C+Q51vluUGGt0E1LBdvbXoqEdTkg==
X-Google-Smtp-Source: AGHT+IF7l4XX7l5reCGXrOLAv02SHRdBHksZn1pO49ZL7lhTkI15PZwDPMMPL1gmx/OnXSMcHfkJUQCo3B+kw4bfUjA=
X-Received: by 2002:a25:a125:0:b0:dd0:76e:d630 with SMTP id
 3f1490d57ef6-dee4f37cd06mr28033009276.53.1716295624118; Tue, 21 May 2024
 05:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521080149.1047892-1-kuro.chung@ite.com.tw>
In-Reply-To: <20240521080149.1047892-1-kuro.chung@ite.com.tw>
From: Robert Foss <rfoss@kernel.org>
Date: Tue, 21 May 2024 14:46:53 +0200
X-Gmail-Original-Message-ID: <CAN6tsi4QkALMhwYT7XAHksq7D6CKXsmE4ownCSoaQ5gqr1decA@mail.gmail.com>
Message-ID: <CAN6tsi4QkALMhwYT7XAHksq7D6CKXsmE4ownCSoaQ5gqr1decA@mail.gmail.com>
Subject: Re: [PATCH v12] drm/bridge: it6505: fix hibernate to resume no
 display issue
To: kuro <kuro.chung@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, Kenneth Haung <kenneth.hung@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Allen Chen <allen.chen@ite.com.tw>, Hermes Wu <hermes.wu@ite.com.tw>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

Thanks for spinning another few revisions.

On Tue, May 21, 2024 at 9:51=E2=80=AFAM kuro <kuro.chung@ite.com.tw> wrote:
>
> From: Kuro Chung <kuro.chung@ite.com.tw>
>
> When the system power resumes, the TTL input of IT6505 may experience
> some noise before the video signal stabilizes, necessitating a video
> reset. This patch is implemented to prevent a loop of video error
> interrupts, which can occur when a video reset in the video FIFO error
> interrupt triggers another such interrupt. The patch processes the SCDT
> and FIFO error interrupts simultaneously and ignores any video FIFO
> error interrupts caused by a video reset.
>
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Kuro Chung <kuro.chung@ite.com.tw>
> Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
>
> ---
> V1->V3: update MAINTAINERS mail list
> V3->V4: remove function it6505_irq_video_fifo_error,it6505_irq_io_latch_f=
ifo_overflow
> V4->V5: customer feedback again, update again, kernel build pass
> V5->V6: remove unrelated patch change, split into another patch
> V6->V7: modify code 0x02 to TX_FIFO_RESET by macro define
> V7->V8: fix merge conflict, change mail from 'cc' to 'to'
> V8->V9: modify patch description, patch summary
> V9->V10: modify patch summary, add Fixes
> V10->V11: modify patch description, add Signed-off-by
> V11->V12: moidfy patch description.
>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 73 +++++++++++++++++++----------
>  1 file changed, 49 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index 469157341f3ab..5703fcf4b7b00 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -1307,9 +1307,15 @@ static void it6505_video_reset(struct it6505 *it65=
05)
>         it6505_link_reset_step_train(it6505);
>         it6505_set_bits(it6505, REG_DATA_MUTE_CTRL, EN_VID_MUTE, EN_VID_M=
UTE);
>         it6505_set_bits(it6505, REG_INFOFRAME_CTRL, EN_VID_CTRL_PKT, 0x00=
);
> -       it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, VIDEO_RESET)=
;
> +
> +       it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, TX_FIFO=
_RESET);
> +       it6505_set_bits(it6505, REG_VID_BUS_CTRL1, TX_FIFO_RESET, 0x00);
> +
>         it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, RST_501_=
FIFO);
>         it6505_set_bits(it6505, REG_501_FIFO_CTRL, RST_501_FIFO, 0x00);
> +
> +       it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, VIDEO_RESET)=
;
> +       usleep_range(1000, 2000);
>         it6505_set_bits(it6505, REG_RESET_CTRL, VIDEO_RESET, 0x00);
>  }
>
> @@ -2245,12 +2251,11 @@ static void it6505_link_training_work(struct work=
_struct *work)
>         if (ret) {
>                 it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
>                 it6505_link_train_ok(it6505);
> -               return;
>         } else {
>                 it6505->auto_train_retry--;
> +               it6505_dump(it6505);
>         }
>
> -       it6505_dump(it6505);
>  }
>
>  static void it6505_plugged_status_to_codec(struct it6505 *it6505)
> @@ -2471,31 +2476,53 @@ static void it6505_irq_link_train_fail(struct it6=
505 *it6505)
>         schedule_work(&it6505->link_works);
>  }
>
> -static void it6505_irq_video_fifo_error(struct it6505 *it6505)
> +static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
>  {
> -       struct device *dev =3D it6505->dev;
> -
> -       DRM_DEV_DEBUG_DRIVER(dev, "video fifo overflow interrupt");
> -       it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> -       flush_work(&it6505->link_works);
> -       it6505_stop_hdcp(it6505);
> -       it6505_video_reset(it6505);
> +       return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
>  }
>
> -static void it6505_irq_io_latch_fifo_overflow(struct it6505 *it6505)
> +static void it6505_irq_video_handler(struct it6505 *it6505, const int *i=
nt_status)
>  {
>         struct device *dev =3D it6505->dev;
> +       int reg_0d, reg_int03;
>
> -       DRM_DEV_DEBUG_DRIVER(dev, "IO latch fifo overflow interrupt");
> -       it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> -       flush_work(&it6505->link_works);
> -       it6505_stop_hdcp(it6505);
> -       it6505_video_reset(it6505);
> -}
> +       /*
> +        * When video SCDT change with video not stable,
> +        * Or video FIFO error, need video reset
> +        */
>
> -static bool it6505_test_bit(unsigned int bit, const unsigned int *addr)
> -{
> -       return 1 & (addr[bit / BITS_PER_BYTE] >> (bit % BITS_PER_BYTE));
> +       if ((!it6505_get_video_status(it6505) &&
> +               (it6505_test_bit(INT_SCDT_CHANGE, (unsigned int *) int_st=
atus))) ||
> +               (it6505_test_bit(BIT_INT_IO_FIFO_OVERFLOW, (unsigned int =
*) int_status)) ||
> +               (it6505_test_bit(BIT_INT_VID_FIFO_ERROR, (unsigned int *)=
 int_status))) {
> +
> +               it6505->auto_train_retry =3D AUTO_TRAIN_RETRY;
> +               flush_work(&it6505->link_works);
> +               it6505_stop_hdcp(it6505);
> +               it6505_video_reset(it6505);
> +
> +               usleep_range(10000, 11000);
> +
> +               /*
> +                * Clear FIFO error IRQ to prevent fifo error -> reset lo=
op
> +                * HW will trigger SCDT change IRQ again when video stabl=
e
> +                */
> +
> +               reg_int03 =3D it6505_read(it6505, INT_STATUS_03);
> +               reg_0d =3D it6505_read(it6505, REG_SYSTEM_STS);
> +
> +               reg_int03 &=3D (BIT(INT_VID_FIFO_ERROR) | BIT(INT_IO_LATC=
H_FIFO_OVERFLOW));
> +               it6505_write(it6505, INT_STATUS_03, reg_int03);
> +
> +               DRM_DEV_DEBUG_DRIVER(dev, "reg08 =3D 0x%02x", reg_int03);
> +               DRM_DEV_DEBUG_DRIVER(dev, "reg0D =3D 0x%02x", reg_0d);
> +
> +               return;
> +       }
> +
> +
> +       if (it6505_test_bit(INT_SCDT_CHANGE, (unsigned int *) int_status)=
)
> +               it6505_irq_scdt(it6505);
>  }
>
>  static irqreturn_t it6505_int_threaded_handler(int unused, void *data)
> @@ -2508,15 +2535,12 @@ static irqreturn_t it6505_int_threaded_handler(in=
t unused, void *data)
>         } irq_vec[] =3D {
>                 { BIT_INT_HPD, it6505_irq_hpd },
>                 { BIT_INT_HPD_IRQ, it6505_irq_hpd_irq },
> -               { BIT_INT_SCDT, it6505_irq_scdt },
>                 { BIT_INT_HDCP_FAIL, it6505_irq_hdcp_fail },
>                 { BIT_INT_HDCP_DONE, it6505_irq_hdcp_done },
>                 { BIT_INT_AUX_CMD_FAIL, it6505_irq_aux_cmd_fail },
>                 { BIT_INT_HDCP_KSV_CHECK, it6505_irq_hdcp_ksv_check },
>                 { BIT_INT_AUDIO_FIFO_ERROR, it6505_irq_audio_fifo_error }=
,
>                 { BIT_INT_LINK_TRAIN_FAIL, it6505_irq_link_train_fail },
> -               { BIT_INT_VID_FIFO_ERROR, it6505_irq_video_fifo_error },
> -               { BIT_INT_IO_FIFO_OVERFLOW, it6505_irq_io_latch_fifo_over=
flow },
>         };
>         int int_status[3], i;
>
> @@ -2546,6 +2570,7 @@ static irqreturn_t it6505_int_threaded_handler(int =
unused, void *data)
>                         if (it6505_test_bit(irq_vec[i].bit, (unsigned int=
 *)int_status))
>                                 irq_vec[i].handler(it6505);
>                 }
> +               it6505_irq_video_handler(it6505, (unsigned int *) int_sta=
tus);
>         }
>
>         pm_runtime_put_sync(dev);
> --
> 2.25.1
>

This patch has a few checkpatch --strict warnings, do you mind fixing
those and then we can merge this patch?

linux/scripts/checkpatch.pl --strict --no-signoff --git 'HEAD~0'


Rob.

