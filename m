Return-Path: <linux-kernel+bounces-174792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7C8C150B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECA61F230D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD957EF0C;
	Thu,  9 May 2024 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ChmgI8Mn"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676F1A2C35
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715280632; cv=none; b=sb/UtNCb+8jnoZ6r0OZyO/ljyBYQmJZwYPtCeRRPegss8Apnh4L5mSvLiMy/SP8XL2+NwHtIVVs8bt9+bB2Igf0y/72eIiKXbVNqNpuXLf3bFIUdHc8Gx2cwQQVaahyQezxXV7c/e3QQTJlIkCroSmTgqCX3D1nCzA9/7Itrv4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715280632; c=relaxed/simple;
	bh=4QzClZ1gRVtyCX7YdwhFlyPn+GYCunj82D3LkrwSRjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AIRV6ttSDrV+PvvtZ8hAYmVxqfhgoIhozFB+JNzw9Fe/5NDap+0M7SBJXUdvQ2hU5tVrhfalOvDFxhydw/QOCB6R3XrXX+wv33tiLeQtHsCUFarqQpz89id70tQhSp8friPznzEqtnDsC/UwhRhNjNJR1y8427Hivyw06Vi5LqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ChmgI8Mn; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c5ee4ce695so427441b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715280630; x=1715885430; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKMjOnnO0WYipffLPmzjc4/xyv9Lp/0n3YbamfBbS/w=;
        b=ChmgI8MnbUlRiv6QJJb91iEE0D5qxeIxdWhg5auTYAkW6fpE5yIiKEVd+Y0wceQkz+
         anvo1Hg7hJbHeykm6qWMBV1PhU9r3JLjw7NAaZPsrEbxoid2zMD3tK0ro6W7ejukHc0k
         +60k42goOKTeuEdZf7Lz8ER8grvw1LFgyv5pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715280630; x=1715885430;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKMjOnnO0WYipffLPmzjc4/xyv9Lp/0n3YbamfBbS/w=;
        b=s5/rueQOCJcfjClsOb6Kec3isoUTzfX2Rghnyisy8DZWgncsGwJFgWCd96LnxL0G+5
         a5lgck7zVT8uIOsTNmEWE8nm+yqf/vzU5XxIpiepPa+NM87POX+mpAHazkK2sdvosvaX
         Wv3aFcd1F2cGNEpsUIi6O8uYn1i4pHmhnT8fc/W+sxdQZDOD4A5kKUU/WRDgoP6/iygT
         dCht9m9IH/mxQDm9SqARzMJ4wdmvp5s8lYAwYDotVavs3BhdlaUYk3ybQtEjvs4SdWGu
         3l+y+87QCwm5XgoufglZFRU3Q00dqhKZ5BAd6LgDERdLYUFwXDQ5EPPKs3d+TVASOBWt
         6Jzw==
X-Forwarded-Encrypted: i=1; AJvYcCVaEEUBqBR3lRs9CusYNK1x9VEAhclKOsYqcNVKJJIk+bJGHa+iCMIeou9wKJb102tjqtKtQt6zvL5EQ9d9hSKbtnhmqOE3iUONVPwJ
X-Gm-Message-State: AOJu0YyqR87vPRjAaXiL2hVnMrpr8Df96yxiKlyMq/1EO24YUY1En8sU
	Sq0FA90u2M2PJB77PaonD/i5aBXfPAdEUXNt9SlAJilwIlfE16iS2psBFS+aG0kVPVSyD0JPCxx
	1XA==
X-Google-Smtp-Source: AGHT+IH9XgUI6eSWd/qvCQlRhN0fbF94DXFSpA7qKDsIoQLuEAMzYoQOfhgMTYObHRjT2G6CW3nxIg==
X-Received: by 2002:aca:2412:0:b0:3c9:6d44:8210 with SMTP id 5614622812f47-3c99704c46amr480382b6e.17.1715280628243;
        Thu, 09 May 2024 11:50:28 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c9974a3a5csm50581b6e.17.2024.05.09.11.50.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 11:50:27 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c974a0647bso804908b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:50:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeAwYSnQpvcruNZy25r1UN7WQ1ZMd0ets8+RsI0UUek3aotL1JTaMJ14+hwSV3vfHcoB6VYlEzuyvDECo2VdWj0cnrXY7Qkt1QuXKi
X-Received: by 2002:aca:190e:0:b0:3c9:7aef:403 with SMTP id
 5614622812f47-3c99706bb87mr458934b6e.26.1715280626326; Thu, 09 May 2024
 11:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
 <20240507-cocci-flexarray-v2-1-7aea262cf065@chromium.org> <Zjs9h40l9gfaiOei@pengutronix.de>
In-Reply-To: <Zjs9h40l9gfaiOei@pengutronix.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 9 May 2024 20:50:14 +0200
X-Gmail-Original-Message-ID: <CANiDSCvon2eW4aHk8JD2_GDR9hG1FBhgbCOEZ+W2RC2HHsXM5A@mail.gmail.com>
Message-ID: <CANiDSCvon2eW4aHk8JD2_GDR9hG1FBhgbCOEZ+W2RC2HHsXM5A@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] media: allegro: nal-hevc: Refactor nal_hevc_sub_layer_hrd_parameters
To: Michael Tretter <m.tretter@pengutronix.de>, Ricardo Ribalda <ribalda@chromium.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	Andy Walls <awalls@md.metrocast.net>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

Hi Michael

On Wed, 8 May 2024 at 10:53, Michael Tretter <m.tretter@pengutronix.de> wrote:
>
> On Tue, 07 May 2024 16:27:06 +0000, Ricardo Ribalda wrote:
> > Replace all the single elements arrays with the element itself.
> >
> > Pahole shows the same padding and alignment for x86 and arm in both
> > situations.
> >
> > This fixes this cocci warning:
> > drivers/media/platform/allegro-dvt/nal-hevc.h:102:14-22: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>
> Thanks for the patch.
>
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/platform/allegro-dvt/allegro-core.c |  6 +++---
> >  drivers/media/platform/allegro-dvt/nal-hevc.c     | 11 +++--------
> >  drivers/media/platform/allegro-dvt/nal-hevc.h     |  6 +++---
> >  3 files changed, 9 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/media/platform/allegro-dvt/allegro-core.c b/drivers/media/platform/allegro-dvt/allegro-core.c
> > index da61f9beb6b4..369bd88cc0ae 100644
> > --- a/drivers/media/platform/allegro-dvt/allegro-core.c
> > +++ b/drivers/media/platform/allegro-dvt/allegro-core.c
> > @@ -1852,14 +1852,14 @@ static ssize_t allegro_hevc_write_sps(struct allegro_channel *channel,
> >       hrd->dpb_output_delay_length_minus1 = 30;
> >
> >       hrd->bit_rate_scale = ffs(channel->bitrate_peak) - 6;
> > -     hrd->vcl_hrd[0].bit_rate_value_minus1[0] =
> > +     hrd->vcl_hrd[0].bit_rate_value_minus1 =
> >               (channel->bitrate_peak >> (6 + hrd->bit_rate_scale)) - 1;
> >
> >       cpb_size = v4l2_ctrl_g_ctrl(channel->mpeg_video_cpb_size) * 1000;
> >       hrd->cpb_size_scale = ffs(cpb_size) - 4;
> > -     hrd->vcl_hrd[0].cpb_size_value_minus1[0] = (cpb_size >> (4 + hrd->cpb_size_scale)) - 1;
> > +     hrd->vcl_hrd[0].cpb_size_value_minus1 = (cpb_size >> (4 + hrd->cpb_size_scale)) - 1;
> >
> > -     hrd->vcl_hrd[0].cbr_flag[0] = !v4l2_ctrl_g_ctrl(channel->mpeg_video_frame_rc_enable);
> > +     hrd->vcl_hrd[0].cbr_flag = !v4l2_ctrl_g_ctrl(channel->mpeg_video_frame_rc_enable);
> >
> >       size = nal_hevc_write_sps(&dev->plat_dev->dev, dest, n, sps);
> >
> > diff --git a/drivers/media/platform/allegro-dvt/nal-hevc.c b/drivers/media/platform/allegro-dvt/nal-hevc.c
> > index 9cdf2756e0a3..575089522df5 100644
> > --- a/drivers/media/platform/allegro-dvt/nal-hevc.c
> > +++ b/drivers/media/platform/allegro-dvt/nal-hevc.c
> > @@ -210,14 +210,9 @@ static void nal_hevc_rbsp_vps(struct rbsp *rbsp, struct nal_hevc_vps *vps)
> >  static void nal_hevc_rbsp_sub_layer_hrd_parameters(struct rbsp *rbsp,
> >                                                  struct nal_hevc_sub_layer_hrd_parameters *hrd)
> >  {
> > -     unsigned int i;
> > -     unsigned int cpb_cnt = 1;
> > -
> > -     for (i = 0; i < cpb_cnt; i++) {
> > -             rbsp_uev(rbsp, &hrd->bit_rate_value_minus1[i]);
> > -             rbsp_uev(rbsp, &hrd->cpb_size_value_minus1[i]);
> > -             rbsp_bit(rbsp, &hrd->cbr_flag[i]);
> > -     }
> > +     rbsp_uev(rbsp, &hrd->bit_rate_value_minus1);
> > +     rbsp_uev(rbsp, &hrd->cpb_size_value_minus1);
> > +     rbsp_bit(rbsp, &hrd->cbr_flag);
> >  }
> >
> >  static void nal_hevc_rbsp_hrd_parameters(struct rbsp *rbsp,
> > diff --git a/drivers/media/platform/allegro-dvt/nal-hevc.h b/drivers/media/platform/allegro-dvt/nal-hevc.h
> > index eb46f12aae80..afa7a9d7d654 100644
> > --- a/drivers/media/platform/allegro-dvt/nal-hevc.h
> > +++ b/drivers/media/platform/allegro-dvt/nal-hevc.h
> > @@ -97,9 +97,9 @@ struct nal_hevc_vps {
> >  };
> >
> >  struct nal_hevc_sub_layer_hrd_parameters {
> > -     unsigned int bit_rate_value_minus1[1];
> > -     unsigned int cpb_size_value_minus1[1];
> > -     unsigned int cbr_flag[1];
> > +     unsigned int bit_rate_value_minus1;
> > +     unsigned int cpb_size_value_minus1;
> > +     unsigned int cbr_flag;
>
> The struct is modeled after the specification in ITU-T H.265, which
> defines the fields as arrays. It's a limitation of the current
> implementation that only a single element is supported.
>
> Maybe replacing the hard coded values with a constant would be more
> appropriate to document this limitation.

A define seems to convince coccinelle of our intentions :). I will
upload the fix in v3

diff --git a/drivers/media/platform/allegro-dvt/nal-hevc.h
b/drivers/media/platform/allegro-dvt/nal-hevc.h
index eb46f12aae80..361e2f55c254 100644
--- a/drivers/media/platform/allegro-dvt/nal-hevc.h
+++ b/drivers/media/platform/allegro-dvt/nal-hevc.h
@@ -96,10 +96,11 @@ struct nal_hevc_vps {
        unsigned int extension_data_flag;
 };

+#define N_HRD_PARAMS 1
 struct nal_hevc_sub_layer_hrd_parameters {
-       unsigned int bit_rate_value_minus1[1];
-       unsigned int cpb_size_value_minus1[1];
-       unsigned int cbr_flag[1];
+       unsigned int bit_rate_value_minus1[N_HRD_PARAMS];
+       unsigned int cpb_size_value_minus1[N_HRD_PARAMS];
+       unsigned int cbr_flag[N_HRD_PARAMS];
 };

 struct nal_hevc_hrd_parameters {


Thanks.


>
> Michael
>
> >  };
> >
> >  struct nal_hevc_hrd_parameters {
> >
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
> >



--
Ricardo Ribalda

