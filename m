Return-Path: <linux-kernel+bounces-176253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3A88C2C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63FE2845F4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3361A13CFA8;
	Fri, 10 May 2024 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XTXw3Zor"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2F13CF85
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377585; cv=none; b=g+6uqy/LGvWPlIPVjISUcaIlE+XgkGjJc28xDiJII/9JLkH6dN25xKi9Ayy7jseP0okPDBzjXMbk/r2PRvZnHlB3uwlOixvbWdTsPiXAKVbBUH/JS7B9xfWqwnIcxsk7R5J1c3eCVRi1JFZ5fThgkJxKkX1SFA73nNXlZDZCuYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377585; c=relaxed/simple;
	bh=CpvPSTAYAqztG9rffDCc/ShYAK7R7juTWh57G+Fzu+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZewtHNRC2Oh/bjdNbPRziGGiMh0tKlUY4r/9Z95B4vJdrgeaMsmlYcZthomeQHrSNnnVKVL917s26KoI+s5OHLbElmhXy6uM+7L+xAr3Y/qSkwlEFooTw2aB1WLVYPqXVWk263kjwBnwkqcojM3oxEqlfopZtSh6Tk2eg8CoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XTXw3Zor; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4df4016b3c9so933198e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715377580; x=1715982380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+1JGsreSo427bW6QsqRdAD0+mF6sAJc/uXEOuM+7wQ=;
        b=XTXw3Zore4G8upBCgh+28+mRvKvU6ZVjf3MUbpYjySvoVeQBZ4et4aRiAC57XEH2bZ
         JM2T2z3Phan3/sMN/uLpaOTB6ehm23XjeyYhPDfbHvW3JxEbZwMUMnwRk/tZmolRLBV3
         /CkWCjQx2Gp/chwneHHhpAbi9bbk1BpwNUKS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377580; x=1715982380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+1JGsreSo427bW6QsqRdAD0+mF6sAJc/uXEOuM+7wQ=;
        b=tqBDrA7D+xjZfHgjlCLs6MGk5PisVFfhzP89UM5k7Vh8tL4RXEOv/p2/OWG5nWbkuN
         bEjKhuxH9WqxSJYuv2vDSzC23ciRhC4/Zhwbs165iWKOgdLC90/+PzmhdSa0P3m8BdNv
         zoMkgCoCX1YFnAexVV0/QwhCYktEv/sodzNpbLwLn/npB6bNdh8WB7pqZ337TOUYC4Sf
         CdhzKXyQLS0tZMMLYZBN6Ml06P/nDLutywLLeJCud/UHawHwoEDxSfzg8hTbduA/M05a
         3ygGNTRFLyPvR4G2ggtPBF59EWVYkSEhmerD5S/f/LMdO8zsyPtOlNFmSg5I270w7GwU
         S+xA==
X-Forwarded-Encrypted: i=1; AJvYcCVTTpXIE/TfclqqXECFvk1G72JbZjei7izVglm8Dc8K81Hn9lZK5ckIvTnTRnQ63tiuPdZdzxkUz3VQB8PBWX3ngMDqFZ5pFfC5D6U0
X-Gm-Message-State: AOJu0YzZ0wFIuyafYQsLw4V3EsyWprZ448M5DFXSp7/Kap4mFrghqTP2
	4z69MK51XNXTe08COAAxtghazieq2x/YraW0exlGTcYX0Y1EhXg0yVm2qlt5BWXa4nNj9Rib8FM
	=
X-Google-Smtp-Source: AGHT+IEqg6Cii6B+9JkLVhZlUWsK5qw8gXufXPbKMwBXTb0/Ja6d8NoQhZjMsrWSL96/fFHt6YexFw==
X-Received: by 2002:a05:6122:2525:b0:4de:daa8:b8e2 with SMTP id 71dfb90a1353d-4df8829ccf5mr4683880e0c.3.1715377579956;
        Fri, 10 May 2024 14:46:19 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2758c2sm218514285a.25.2024.05.10.14.46.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 14:46:18 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43dfe020675so142171cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:46:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVurc2pgVaTwmBbeSF5wDDsP2G4JQO+mCKu1HLnuPp6TJG9R/Sp0f3q+V91XZWtocZpk4JrAo+esAxgGCTHnz5niAvokWa0wzjwm4HS
X-Received: by 2002:a05:622a:1b1e:b0:43d:eeb1:fd4e with SMTP id
 d75a77b69052e-43e092249fdmr857681cf.0.1715377578083; Fri, 10 May 2024
 14:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-dsi-panels-upd-api-v1-0-317c78a0dcc8@linaro.org> <20240510-dsi-panels-upd-api-v1-2-317c78a0dcc8@linaro.org>
In-Reply-To: <20240510-dsi-panels-upd-api-v1-2-317c78a0dcc8@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 10 May 2024 14:46:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XkZqAu5RnQmE-2z3NoSgK1LJJCK9Jdkus2f2nSREFZ5A@mail.gmail.com>
Message-ID: <CAD=FV=XkZqAu5RnQmE-2z3NoSgK1LJJCK9Jdkus2f2nSREFZ5A@mail.gmail.com>
Subject: Re: [PATCH RFC 2/7] drm/panel: boe-tv101wum-nl6: use wrapped MIPI DCS functions
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Vinod Koul <vkoul@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, 
	cong yang <yangcong5@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 9, 2024 at 3:37=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Remove conditional code and always use mipi_dsi_dcs_*multi() wrappers to
> simplify driver's init/exit code.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 73 ++++++++------------=
------
>  1 file changed, 21 insertions(+), 52 deletions(-)

Please CC Cong Yang (CCed here) on your next version since he's also
touching this file and your changes will conflict with his.


> @@ -1508,20 +1483,14 @@ static inline struct boe_panel *to_boe_panel(stru=
ct drm_panel *panel)
>
>  static int boe_panel_enter_sleep_mode(struct boe_panel *boe)
>  {
> -       struct mipi_dsi_device *dsi =3D boe->dsi;
> -       int ret;
> -
> -       dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> +       struct mipi_dsi_multi_context ctx =3D { .dsi =3D boe->dsi };
>
> -       ret =3D mipi_dsi_dcs_set_display_off(dsi);
> -       if (ret < 0)
> -               return ret;
> +       boe->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
>
> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(dsi);
> -       if (ret < 0)
> -               return ret;
> +       mipi_dsi_dcs_set_display_off_multi(&ctx);
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
>
> -       return 0;
> +       return ctx.accum_err;
>  }

nit: since the "multi" functions print errors for you, you can get rid
of the (now duplicate) error print in the caller. I guess if you
really wanted to you could actually just inline
boe_panel_enter_sleep_mode() into its one caller and that would make
it easy to use the "_multi" version of msleep() there...

In any case, I think this looks nice:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

