Return-Path: <linux-kernel+bounces-255319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A79933EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C7E1F21146
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C414F181BA2;
	Wed, 17 Jul 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d7sT929/"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563F4181330
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228326; cv=none; b=k51dI7yTaI1YJRW9CuKgpgVevpw8jQoKHK/8Pozh1LELTWOLgG6G6deVo6L5xNbJHlsnzvha7WUNeAdc1t7qvCBEDmKzc1xPo0d0DC0bg6t8zzopZwFMeofa3pnD04ZcX5y1hLO7k4W2wUdSFfxgP2ME3qD/s6U5vZa4AuBWgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228326; c=relaxed/simple;
	bh=0GykYWba+Yw2USBd/ghyxptd/hrUzR0IBixyGZZhHLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMJklMRkvINYGyl5dQYsTaOVaGodpfMC/wtsqb3Yd7sBthbleUVKVVoN/YF9LXQj6BN7dvxCZbCHJ6n6D//KB3QVI/gY3wkUluumXcaY/NYRhuxOCrkXAYDH7SHmQWGigC/0M1HJMAYISKH87XhOlL0h/+jP/lPlTbHv9MAygxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d7sT929/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44931f038f9so7303691cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721228323; x=1721833123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eGwogNe/nf8SgikTpuY8jnI/BAYLXXgaMeSpJB6GSc=;
        b=d7sT929/1BSeT94WnCrqQLX8lMGGTxBMv0pwAQzIhex5n1w+dsKQX35aet3DfIlLyC
         HJFGOCCSigLddPt/1XD3vfGv76zTRIWR/sgFeD6IWKIXPeZRl9QIuAxLcgnRDKe1vDyv
         WReN5u3LDf91lOJalQrlXeyhp4mgdagu9qlMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721228323; x=1721833123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eGwogNe/nf8SgikTpuY8jnI/BAYLXXgaMeSpJB6GSc=;
        b=AiYFBR28kA0bbRC7E+BKzWWA48YbB51ZlAjs4Ipq1EzV4rne22uJKyKobM0LCXNFkq
         3HOX/rQkuvFFH1vVmliLaiHR12kGUTsU9sgF76IT2VaOuLlIUvECHMHwJT1tER9jH4Zu
         19Bteu0FkWBaKv1Dpv0h2+SAKtNcUQru+Cttmgg8sufM8BFAhbzKFStHEFM4bwnDgxpv
         he1z+Qf4hGFYNHsXJFeeGCTKMYuMB0KQ8Q7pYhVbZg98jyS/4yCWdqQLbQ9dqVdWjWqe
         wM7FcRwOpqkONlviZ2zWYrRuqiFaJhdIPJu43GBrvX4LbFMqv/Yym+09lP7zxd1cReMW
         cHPw==
X-Gm-Message-State: AOJu0YzmX8VKGveV2Hs4YFLCYemFSZ0JoLknHck017fSFLYl8H9FpVWp
	5Y4WSvyWtb4/WuWH/FeirEqSXPmta8tR5+Qc1I68/yt20VWDUvrkiHZcOUQP640Q7SpcBL7iZ04
	=
X-Google-Smtp-Source: AGHT+IHNlVd+6XkPpMRbFUcB1UyEHaTT0Qs43eklVUbt0kRokav5udBXtb4YxqQfbdDHPhJr49R4zw==
X-Received: by 2002:a05:622a:14d2:b0:447:ed2c:bea8 with SMTP id d75a77b69052e-44f8608694cmr33892551cf.3.1721228322600;
        Wed, 17 Jul 2024 07:58:42 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7e118asm48380821cf.30.2024.07.17.07.58.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:58:41 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44e534a1fbeso267271cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:58:41 -0700 (PDT)
X-Received: by 2002:a05:622a:6183:b0:447:e0a6:9163 with SMTP id
 d75a77b69052e-44f8395e9f4mr3721941cf.14.1721228321023; Wed, 17 Jul 2024
 07:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717093925.3017-1-terry_hsiao@compal.corp-partner.google.com>
In-Reply-To: <20240717093925.3017-1-terry_hsiao@compal.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Jul 2024 07:58:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XM7X5J6rzu5gDdmDhJ4Ut8raC92HvcnHmRJmWY7_boSA@mail.gmail.com>
Message-ID: <CAD=FV=XM7X5J6rzu5gDdmDhJ4Ut8raC92HvcnHmRJmWY7_boSA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel-edp: Add panels with conservative timings
To: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 17, 2024 at 2:39=E2=80=AFAM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> The 6 panels are used on Mediatek MT8186 Chromebooks
> - B116XAT04.1  (06AF/B4C4)
> - NV116WHM-A4D (09E5/FA0C)
> - N116BCP-EA2  (0DAE/6111)
> - B116XTN02.3  (06AF/AA73)
> - B116XAN06.1  (06AF/99A1)
> - N116BCA-EA2  (0DAE/5D11)
>
> Signed-off-by: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Please resend with a better patch subject, like "drm/panel-edp: Add 6
panels used by MT8186 Chromebooks".

Also: are you adding timings based on the datasheets, or are you just
guessing here? The previous patches that added "conservative" timings
were because the Chromebooks involved were really old and couldn't be
tracked down and folks couldn't find the relevant datasheets. In the
case of MT8188 I'd expect you to be adding timings based on the
datasheets. Please confirm that you are.

If possible, it's really nice to have the raw EDIDs for the panels in
the commit message in case someone needs it later.


> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index f85a6404ba58..ac280607998f 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1845,8 +1845,11 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x635c, &delay_200_500_e50, "B116X=
AN06.3"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x639c, &delay_200_500_e50, "B140H=
AK02.7"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x723c, &delay_200_500_e50, "B140X=
TN07.2"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x73aa, &delay_200_500_e50, "B116X=
TN02.3"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133U=
AN01.0"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B120X=
AN01.0"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0xa199, &delay_200_500_e50, "B116X=
AN06.1"),

Please keep this sorted. For instance, 0xa199 should come _before_
0xd497, right?


> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0xc4b4, &delay_200_500_e50, "B116X=
AT04.1"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140X=
TN07.7"),
>
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "Unkn=
own"),
> @@ -1901,6 +1904,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b56, &delay_200_500_e80, "NT140=
FHM-N47"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0c20, &delay_200_500_e80, "NT140=
FHM-N47"),
>         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cb6, &delay_200_500_e200, "NT11=
6WHM-N44"),
> +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x0cfa, &delay_200_500_e50, "NV116=
WHM-A4D"),
>
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1130, &delay_200_500_e50, "N116B=
GE-EB2"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N=
116BGE-EA2"),
> @@ -1916,8 +1920,10 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1156, &delay_200_500_e80_d50, "U=
nknown"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1157, &delay_200_500_e80_d50, "N=
116BGE-EA2"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x115b, &delay_200_500_e80_d50, "N=
116BCN-EB1"),
> +       EDP_PANEL_ENTRY('C', 'M', 'N', 0x115d, &delay_200_500_e80_d50, "N=
116BCA-EA2"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x115e, &delay_200_500_e80_d50, "N=
116BCA-EA1"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1160, &delay_200_500_e80_d50, "N=
116BCJ-EAK"),
> +       EDP_PANEL_ENTRY('C', 'M', 'N', 0x1161, &delay_200_500_e80, "N116B=
CP-EA2"),

It looks suspicious that all the panels around this one need 50 ms for
disable but yours doesn't. While it's certainly possible that things
changed for this panel, it's worth double-checking.

-Doug

