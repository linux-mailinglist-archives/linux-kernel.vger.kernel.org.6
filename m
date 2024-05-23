Return-Path: <linux-kernel+bounces-187724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C508CD73E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386F3281D98
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8478C11717;
	Thu, 23 May 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EnyncnAe"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163F117573
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478623; cv=none; b=gJqi/Kjoy0QJyU5deQnXf7jkwArxu+lDCGv5TDJQ304yFKoJunQXbBiKxoAiVhhFe9jFh6sXi56dnONGh1c/lAz3KVXuBWm9em+Vg4KS9UT4dn9V29BLTD5Nsj3VwErl68RiAze2HG1ohsnqINXFN8O6sYPkj4vou3wj3KAvJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478623; c=relaxed/simple;
	bh=Pbsi2P8PF4TuOLx5XqrI6MwLSCMdLg38mH2lUsB//cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA1YMkTuSgtIH+sRE7SX50cX/3dlWbXRK8g/hTQvlt8IVVGGllrxZjoDx1BZiM7XUz0kYMrxc+C62KZOuaZhRaa4XXF2bAngJhVRfSKsCusP88QUNJc4l9HJs2R/+smgHO4bHBrK9t96JFbEZSIMPhIVEV2v51g25icfrkL9t2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EnyncnAe; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ab8e759adbso10074186d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716478619; x=1717083419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6Yi5QsLgSFqxP/hYDl5gHS5x3eV0VrrWPeAD34sRDM=;
        b=EnyncnAecNcs8FGHsYMxkUYLwYSoq141mlJONw+ANY4MtGnOlRkhrW7NtPWfyRmGaN
         K/bvUrlOqllgNuSRllOUS5YB6BS8NbUCEMDYmBTDYO6F1QavvAiSp99FajFJ46tktWN+
         O+D7dRxa/38zdG23xdU64DzrsTVDL4drrmvCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478619; x=1717083419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6Yi5QsLgSFqxP/hYDl5gHS5x3eV0VrrWPeAD34sRDM=;
        b=phSEUPM2LbPj86P0ATxw/EBrBtnwgkQxu7pgE8lyaq4wLvIlln/y5g+syCu6j8CKCz
         Qdotx/1Omh//r35E5HopupMT4jbRNKq5lkQKTvASXxxf1Elr0RU4hWx+wiHDj5J0+X7Z
         MOg+9sZ9GBzVT8WEJtRV0NZF3/6KaCmeZ824QGrT4SAZO5DPH3ZBl1MDxzEDBjtYibHP
         mq47tbZBJklqnHxy1UtInphDPqOBnij2p0GHENnWzVht8EXRGZTAspzzdCOyQTMMFFw9
         1iM7QiwkiAb7VFyN1MhjSlNzTq53T2tzrwqekXJdVzBFoFSei+Fs5N5Mc6Flqz95PcxU
         0/iw==
X-Forwarded-Encrypted: i=1; AJvYcCXRrGY8NPpGIpBB7s+rvr6NT9jKGhNvGLqmpglVX91zL/NZIvcBvSQh8lyr8uheztGgXXGJH9n6Zs8CbXm/31YFW3Lr4QiytGoP0xWV
X-Gm-Message-State: AOJu0Yy3+whz9Q2rPbsGD5AtAP3ZEw8Z/SQovBkbTWamchq+gb5O2FXL
	pbJ4Pw3v0+tkarfhMB2KIFQg+HOtLEQ9JHhWiih6GpmNuBPI86Punjbw6om1d7mBi4oSfGxC9EM
	=
X-Google-Smtp-Source: AGHT+IE489jSf9Ln4XlazZWNuZ0ROzIL+V8jBGaYAvzljm33ZJfrYsoMm3Qk2YoKd9lLtVDTLd91Kw==
X-Received: by 2002:a05:6214:3a05:b0:6ab:724b:ed5d with SMTP id 6a1803df08f44-6ab8f621b61mr43946846d6.28.1716478619320;
        Thu, 23 May 2024 08:36:59 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab94a51fdasm5048226d6.131.2024.05.23.08.36.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:36:59 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43f87dd6866so405701cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:36:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXo74ZYbETKDDNwTa+2gxj1WgyxKUcPj//Y6mk8QM4gZXkJsZVyxnxzX2pMYpPWr0k9sTds/UW2DyApelg/OWChMGjM6MRXzpIIUl38
X-Received: by 2002:a05:622a:6092:b0:43f:7ae1:7d1 with SMTP id
 d75a77b69052e-43fa7437f48mr2924771cf.4.1716478617614; Thu, 23 May 2024
 08:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523-edp-panel-drop-v1-1-045d62511d09@linaro.org>
In-Reply-To: <20240523-edp-panel-drop-v1-1-045d62511d09@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 23 May 2024 08:36:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xz1VsF8jG0q-Ldk+p=NY-ChJkTk0iW8fq2bO=oRFvXRA@mail.gmail.com>
Message-ID: <CAD=FV=Xz1VsF8jG0q-Ldk+p=NY-ChJkTk0iW8fq2bO=oRFvXRA@mail.gmail.com>
Subject: Re: [PATCH RFC] drm/panel-edp: add fat warning against adding new
 panel compatibles
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 22, 2024 at 3:07=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Add a fat warning against adding new panel compatibles to the panel-edp
> driver. All new users of the eDP panels are supposed to use the generic
> "edp-panel" compatible device on the AUX bus. The remaining compatibles
> are either used by the existing DT or were used previously and are
> retained for backwards compatibility.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> The following compatibles were never used by the devices supported by
> the upstream kernel and are a subject to possible removal:
>
> - auo,b133han05

Ack. Looks like this was added by Bjorn but by the time the dts for
the board (from context, sc8180x-primus) using it made it upstream it
was using "edp-panel".


> - auo,b140han06

Ack. Same as above, but this time the board was "sc8180x-lenovo-flex-5g".


> - ivo,m133nwf4-r0

Ack. Also added by Bjorn but not easy to tell from context which board
it was from. "m133nwf4" never shows up in the history of arm64 qcom
dts files.


> - lg,lp097qx1-spa1

Maybe. Added by Yakir at Rockchip. I don't think this was ChromeOS
related so I don't have any inside knowledge. Presumably this is for
some other hardware they were using. Probably worth CCing Rockchip
mailing list. It's entirely possible that they have downstream dts
files using this and there's no requirement to upstream dts files that
I'm aware of.


> - lg,lp129qe

NAK. See "arch/arm/boot/dts/nvidia/tegra124-venice2.dts"


> - samsung,lsn122dl01-c01

Maybe. Also by Yakir at Rockchip and also doesn't appear to be
ChromeOS, so you should ask them.


> - samsung,ltn140at29-301

NAK. arch/arm/boot/dts/nvidia/tegra124-nyan-blaze.dts


> - sharp,ld-d5116z01b

Added by Jeffrey Hugo. Maybe Cc him to make sure it's OK to delete?


> - sharp,lq140m1jw46

Ack. Feel free to delete. This was used in the sc7280 reference board
(hoglin/zoglin) and by the time the dts made it upstream it was
already using generic edp-panel.


> - starry,kr122ea0sra

Ack. From my previous notes: "starry,kr122ea0sra - rk3399-gru-gru
(reference board, not upstream)". Nobody needs this.


> I'm considering dropping them, unless there is a good reason not to do
> so.
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 6db277efcbb7..95b25ec67168 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1776,7 +1776,23 @@ static const struct of_device_id platform_of_match=
[] =3D {
>         {
>                 /* Must be first */
>                 .compatible =3D "edp-panel",
> -       }, {
> +       },
> +       /*
> +        * Do not add panels to the list below unless they cannot be hand=
led by
> +        * the generic edp-panel compatible.
> +        *
> +        * The only two valid reasons are:
> +        * - because of the panel issues (e.g. broken EDID or broken
> +        *   identification),
> +        * - because the platform which uses the panel didn't wire up the=
 AUX
> +        *   bus properly.

You mean that they physically didn't wire up the AUX bus? I don't
think that's actually possible. I don't believe you can use an eDP
panel without this working. Conceivably a reason to add here is if
there's some old platform that hasn't coded up support for AUX bus.
..but it would be much preferred to update the platform driver to
support it.

-Doug

