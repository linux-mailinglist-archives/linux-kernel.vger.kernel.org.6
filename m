Return-Path: <linux-kernel+bounces-530371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FF4A43298
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 02:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA2F17498D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 01:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5DE78F4B;
	Tue, 25 Feb 2025 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IfWjzwHX"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5EA502BE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448102; cv=none; b=Rg+uG6ByfkRM5PSETn6/zE3RDSnMD5rvCGSMiNmg5Bbs2y5vwUIVVsHwmRjSBGegp1Z15yaWme/DWP/qZO+9bPqvxJbUZbsYF1D8CIpOmfkOw7ac3MDWZ79GMs797V8rqAyO4SnAwJ40DREeqOS+6qKcGD6Y1u1rfPXMY+ExNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448102; c=relaxed/simple;
	bh=ANDk1f1ewGyRyWWZvJv7bwXf/B8TgaiUTyfdL2L3ZVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPils3bnnD7rkM42W6q1+Q/j+RUQPcbN0RQ5hb6HtXj0HV/Mwv+N9Yrgls8fflObumSo3aH9Z+mn2vw1/4uz1NYVWUeAMWgXGzOvhzBoetFGvuozqF1QyUIkqmhDdIQvvQYSjxxzv1up3hPu2t4K1EEKl4Ta2trWeyI6LiKeBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IfWjzwHX; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab771575040so1053153066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740448098; x=1741052898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loyJuf6zNk03z78etJFgemOo09eYVwdWkJ6KQXv4Jfk=;
        b=IfWjzwHXvdyecVmy3uZVuJF3KOFLD3a3AiwJ8fClVGA1l8k7IyJgilcbbDp9FyUzPC
         odtLjEz/UMJgEDKuLXTOndQ4RUxCsKx9fcpRodKJqWKFfSHSWJarEvuzEpy1PW5bCU76
         yPV5YJ5BoxnWC2Bm3HQvB/l4by6HgNGDeAsyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740448098; x=1741052898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loyJuf6zNk03z78etJFgemOo09eYVwdWkJ6KQXv4Jfk=;
        b=o9EPUW9hxlyEkEJkHhJ3if3thNxl4A48u88DcrOGEky9akVdYPh5yp/vnE+DbsrT73
         Pt0rOh60Yhg3bRIaYKH2RankywA/cNMdrhVtQYqDJiDdLXt9NtDVqnaTjfxbx9BmKDrT
         3bXro2Jy8dkhWPbX5d8hdmUahn3jAaVREqeOT+I3AK+hWydKm7RS3KFMgknI2LcKcvet
         yspZMB0FbWQX/iXRfgaEjYV2NLoNlM2rR0HxQ+2YObJ4j07ayXb9zM7exLvlzcET1xNB
         v7FESSER0s7GBVXc/rG3vOvvCcNswmJzZnkdvmU4tjM4YQ1lMcdCQiTajYsCXvXtU+i4
         ooWA==
X-Forwarded-Encrypted: i=1; AJvYcCV2DSyWQi7duR31Bxvwg/crxff20NQYlQp49QUmB7y0wWghWDJGXsinTWNmg+yY99yQBUNXAcmDr+pQ1nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KEjOMd0c8QNMVpiiQFcQhXcjRYln4BqauemRWoJ0qby7n3rs
	FLTvdC79WVleQFao8flfhdb+1MPa3OZ+W2fD3r/03GDhQp/imbqcwsXS2P1ED/LKxaDaX/3mJyZ
	YD9Wa
X-Gm-Gg: ASbGncu5iiY9GnrugKtuFuH8rjoVZiMXdYCdwinms5bxi5EHKXvqNo/KslQj44bxdrx
	D+DpR8omG8NTvg5XqsLCTamMWQKm69AmLbMOVSftyhq3ekX0WW2BAqPE+x+K3aiX1CvYC1ZWduA
	6LplZnd9vVDYu/n0IFaRVULbqwgTPviPDXkerEvO3opj8FbQWcHbrl8M9CmrlmGMzrtkw2hzwum
	DZnxg1c3IRnORo4388KIytGfBwAgidvrJzbMFdozCzuDZi//rwVjlGzT1ekNkbmpkZUsgpvOxt/
	3ZnzCtGD0JNL66s6e4mHJFI+xK2WV4GKF/tG0FesB9O0JWJD0Vh2c8gaxSvpGphHQw==
X-Google-Smtp-Source: AGHT+IHjS9eKRaZp4Hw9D0pt5iU853ce2qC4Kes8k4/OPWnxvoBKVYStAA1r7FuXwWY6/uO9CPP7Mg==
X-Received: by 2002:a17:907:8995:b0:ab7:cf7c:f9ed with SMTP id a640c23a62f3a-abbedf564b1mr1836052866b.24.1740448098265;
        Mon, 24 Feb 2025 17:48:18 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2012360sm53133366b.114.2025.02.24.17.48.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 17:48:17 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5debbced002so9175396a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:48:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUViIIWfPT6Wi5SrALZetlmOuMsyCRdoKQQrnoTDIXe6ZjbIMjNkmmdJ/ZIMCiAJw8JpWPVcoz6Os8GvYE=@vger.kernel.org
X-Received: by 2002:a05:6512:1253:b0:545:6a2:e59 with SMTP id
 2adb3069b0e04-54838cb627cmr5635189e87.18.1740447736562; Mon, 24 Feb 2025
 17:42:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224081325.96724-1-damon.ding@rock-chips.com> <20250224081325.96724-11-damon.ding@rock-chips.com>
In-Reply-To: <20250224081325.96724-11-damon.ding@rock-chips.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Feb 2025 17:42:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WS_2JAKMyFFmrNtaN7-O4dh2hOXHc25FytDxXAjAr+5A@mail.gmail.com>
X-Gm-Features: AWEUYZkb9AduQv4S2t7Q6Lb4ouepbii0QdSB144heJ2UJlKArYXhKCxoqxEOhvg
Message-ID: <CAD=FV=WS_2JAKMyFFmrNtaN7-O4dh2hOXHc25FytDxXAjAr+5A@mail.gmail.com>
Subject: Re: [PATCH v7 10/15] drm/rockchip: analogix_dp: Add support to get
 panel from the DP AUX bus
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, andy.yan@rock-chips.com, hjc@rock-chips.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	dmitry.baryshkov@linaro.org, sebastian.reichel@collabora.com, 
	cristian.ciocaltea@collabora.com, boris.brezillon@collabora.com, 
	l.stach@pengutronix.de, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 24, 2025 at 12:14=E2=80=AFAM Damon Ding <damon.ding@rock-chips.=
com> wrote:
>
> @@ -392,11 +393,27 @@ static const struct component_ops rockchip_dp_compo=
nent_ops =3D {
>         .unbind =3D rockchip_dp_unbind,
>  };
>
> +static int rockchip_dp_link_panel(struct drm_dp_aux *aux)
> +{
> +       struct analogix_dp_plat_data *plat_data =3D analogix_dp_aux_to_pl=
at_data(aux);
> +       struct rockchip_dp_device *dp =3D pdata_encoder_to_dp(plat_data);
> +       int ret;
> +
> +       ret =3D drm_of_find_panel_or_bridge(dp->dev->of_node, 1, 0, &plat=
_data->panel, NULL);
> +       if (ret && ret !=3D -ENODEV)
> +               return ret;

Can you explain why you treat -ENODEV as a non-error case here? Maybe
this is for the non-eDP case (AKA the DP case) where there's no
further panels or bridges? Maybe a comment would be helpful to remind
us?


> +       ret =3D component_add(dp->dev, &rockchip_dp_component_ops);
> +       if (ret)
> +               return ret;
> +
> +       return ret;

nit: the above could just be:

return component_add(dp->dev, &rockchip_dp_component_ops);


> @@ -448,9 +460,16 @@ static int rockchip_dp_probe(struct platform_device =
*pdev)
>         if (IS_ERR(dp->adp))
>                 return PTR_ERR(dp->adp);
>
> -       ret =3D component_add(dev, &rockchip_dp_component_ops);
> -       if (ret)
> -               return ret;
> +       ret =3D devm_of_dp_aux_populate_bus(analogix_dp_get_aux(dp->adp),=
 rockchip_dp_link_panel);
> +       if (ret) {
> +               if (ret !=3D -ENODEV)
> +                       return dev_err_probe(dp->dev, ret,
> +                                            "failed to populate aux bus =
: %d\n", ret);

IIRC this -ENODEV case is for old legacy panels that aren't listed
under the aux bus in the device tree. Maybe a comment would be helpful
to remind us?

nit: don't need the %d in your error message. dev_err_probe() already
prints the error code.


> +               ret =3D rockchip_dp_link_panel(analogix_dp_get_aux(dp->ad=
p));
> +               if (ret)
> +                       return ret;
> +       }
>
>         return 0;

You can get rid of a few of your return cases by just returning "ret" here.


-Doug

