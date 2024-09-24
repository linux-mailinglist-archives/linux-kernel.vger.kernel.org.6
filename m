Return-Path: <linux-kernel+bounces-337575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E35984BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF211F23DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34C81369AA;
	Tue, 24 Sep 2024 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SDFB2yqa"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88E83CC8
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727207779; cv=none; b=mqLDwETjsDLwuP+L50kD44yfJAFdU1FQrhhYJbTx42Uvhah1r1NurnWB5NBFvJ4lHjG2DnTPKUcKv8OkC3G5K0HhyXnv0OyMAeheuOAwn+4vah3sz18py/XTf6qe6DhGJBtRT4l3QsoowknWkY8UoQN09l5392Ol2ccMMQQm5+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727207779; c=relaxed/simple;
	bh=4cK0ai1qV8tqLyR6YSuKSqTDXzG2rZorZy7U6bXmDas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3o+1rbWLKRzMrsTPveYJz+JvJjZ443DI806WUiSdFyPsajqskKyGalQB6+Hdbv4AuG4mKKRX5pfnhLAFXT1CqcO2EjHIG3ZfVPtwjC+BvshfmboZpj477H85Ttps8Y/B9IuzTpgPp8Kq5t/SqybFdm3rd9Af2vmYIKJqh8oFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SDFB2yqa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so65887921fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727207773; x=1727812573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS2okOwNkGUX7eeFH/iep/BcUjWJ+kRK0nWW0JJdEA8=;
        b=SDFB2yqaTxcivreLzFQe0HNswf9mFsHj4wo7OegF99Ejhmpq6qMJgjsNex6lwHQcZ5
         MkZPu4Nz3VVmrrINd/V11XmB1cAolBZ3015lKUy466Jv05k+Y5gTdPw3uLLfxxW+ASm/
         yE/ZuT07YNa6v4MQdUdPYItyrpoV4ii+S3BNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727207773; x=1727812573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BS2okOwNkGUX7eeFH/iep/BcUjWJ+kRK0nWW0JJdEA8=;
        b=oSCIWoTIH4URudBq4yU2RI+Sjn7eqZ75WfaKcT7PPbYVwHcXj3wVf6jUOjb/DV3Kqc
         0hXvImCmxzUlVzi9nvH7XH0RcfVH6O9VVfyI1gsEW1dxgxhOV2hr9357A8yplxbTX42o
         KW56qqjm7yyzey3E3sQcPn5akCP2Ypi47Ii2QEOer8FtiXtt7RuUzVk4O4bv968nWK/L
         RJbvaZLXs4vu0rPnpQ+AN+p6A5UkLygeegh+mnxUD9fef4xVbt6+OvxvvjgS23slu9gx
         KPX15U+MIUaqRFAuLIZgyyc9gE677yVb6JcYYz+UFJl3tsVR3ibHyF6wyaU7WiY/4aGn
         cjZA==
X-Forwarded-Encrypted: i=1; AJvYcCVEse3+2uiyan4bqryWB+yicZ4IGb2az7/iOK6l5VRe/pZWvLqKGwr8qY+CAa1gZl+bYOu+XfvJ83ha1XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRntkXUao+XCTWb+fHrxDRqwKh1a3Y6usnRxpOZdf7AtPOESt
	bWTSV2dOLMcKckjrnotX6jM0ktLAS7eRTbndxHC2HdDnn+QbHi8owX942G1h01FU5MeKQlMDR2f
	keQ==
X-Google-Smtp-Source: AGHT+IEhbQGJH2dTAios5PvRqZ6Zl+Jwbjx1CtpUAuNAv+IjfhgNd/ZtHVGyA/IqfGrhMV4vgX8KNQ==
X-Received: by 2002:a2e:d1a:0:b0:2f7:6519:9a01 with SMTP id 38308e7fff4ca-2f91603fb94mr2539201fa.24.1727207772941;
        Tue, 24 Sep 2024 12:56:12 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d282fdc4sm3210571fa.10.2024.09.24.12.56.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 12:56:12 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53654e2ed93so6995127e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:56:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqJ2/301GUpyGbUTDrJrcUe1N1+mvJAD5ZAJGrmhC/jHeLXzNtHroXXXvPL2gth9bBvW9tP6Bfu1yEkSA=@vger.kernel.org
X-Received: by 2002:a05:6512:3b95:b0:52c:adc4:137c with SMTP id
 2adb3069b0e04-53870496b19mr130321e87.20.1727207771379; Tue, 24 Sep 2024
 12:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923122558.728516-1-tejasvipin76@gmail.com>
In-Reply-To: <20240923122558.728516-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 24 Sep 2024 12:55:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WmcyAbzU_M25rCzc3JmNGZ9T0wzMJAfxi-LmdZ6389OQ@mail.gmail.com>
Message-ID: <CAD=FV=WmcyAbzU_M25rCzc3JmNGZ9T0wzMJAfxi-LmdZ6389OQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: elida-kd35t133: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 23, 2024 at 5:33=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> -static int kd35t133_init_sequence(struct kd35t133 *ctx)
> +static void kd35t133_init_sequence(struct mipi_dsi_multi_context *dsi_ct=
x)
>  {
> -       struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> -       struct device *dev =3D ctx->dev;
> -
>         /*
>          * Init sequence was supplied by the panel vendor with minimal
>          * documentation.
>          */
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POSITIVEGAMMA,
> -                              0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, 0x3a, =
0x56,
> -                              0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, 0x0f);
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_NEGATIVEGAMMA,
> -                              0x00, 0x13, 0x18, 0x01, 0x11, 0x06, 0x38, =
0x34,
> -                              0x4d, 0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL1, 0x18, 0x1=
7);
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_POWERCONTROL2, 0x41);
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_VCOMCONTROL, 0x00, 0x1a,=
 0x80);
> -       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x48);
> -       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_INTERFACEMODECTRL, 0x00)=
;
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_FRAMERATECTRL, 0xa0);
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYINVERSIONCTRL, 0x=
02);
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_DISPLAYFUNCTIONCTRL,
> -                              0x20, 0x02);
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_SETIMAGEFUNCTION, 0x00);
> -       mipi_dsi_dcs_write_seq(dsi, KD35T133_CMD_ADJUSTCONTROL3,
> -                              0xa9, 0x51, 0x2c, 0x82);
> -       mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);
> -
> -       dev_dbg(dev, "Panel init sequence done\n");
> -       return 0;
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POSITIVEGAMMA,
> +                                    0x00, 0x13, 0x18, 0x04, 0x0f, 0x06, =
0x3a, 0x56,
> +                                    0x4d, 0x03, 0x0a, 0x06, 0x30, 0x3e, =
0x0f);
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_NEGATIVEGAMMA,
> +                                    0x13, 0x18, 0x01, 0x11, 0x06, 0x38, =
0x34,
> +                                    0x06, 0x0d, 0x0b, 0x31, 0x37, 0x0f);

It seems like you dropped a few bytes in the above. Was this
intentional? You seem to have dropped the first byte from both of the
continuation lines (0x00 from the first, 0x4d from the second).


> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POWERCONTROL1,=
 0x18, 0x17);
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_POWERCONTROL2,=
 0x41);
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_VCOMCONTROL, 0=
x00, 0x1a, 0x80);
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE, =
0x48);
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_SET_PIXEL_FORMAT, =
0x55);
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_INTERFACEMODEC=
TRL, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_FRAMERATECTRL,=
 0xa0);
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_DISPLAYINVERSI=
ONCTRL, 0x02);
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_DISPLAYFUNCTIO=
NCTRL,
> +                                    0x02);

This used to be the bytes 0x20, 0x02. Now it's just 0x02?


> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_SETIMAGEFUNCTI=
ON, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(dsi_ctx, KD35T133_CMD_ADJUSTCONTROL3=
,
> +                                    0x51, 0x2c, 0x82);

This used to be the bytes 0xa9, 0x51, 0x2c, 0x82. Now it's just 0x51,
0x2c, 0x82?


> +       mipi_dsi_dcs_write_buffer_multi(dsi_ctx, NULL, 0);

Are you certain that the above is equivalent to the old
"mipi_dsi_dcs_write(dsi, MIPI_DCS_ENTER_INVERT_MODE, NULL, 0);" ?
Where is the "MIPI_DCS_ENTER_INVERT_MODE" constant?

I think the above needs to be:

  mipi_dsi_dcs_write_seq_multi(dsi_ctx, MIPI_DCS_ENTER_INVERT_MODE);

I've confirmed that this compiles OK and that there's no need to
actually have any bytes in the sequence.


-Doug

