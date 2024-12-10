Return-Path: <linux-kernel+bounces-440008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0BD9EB777
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C32188736B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA39233D70;
	Tue, 10 Dec 2024 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lkm2W1a/"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA623278D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733850550; cv=none; b=FS+8kFz5+2tN6dRKexcNESkVFX7SOYhOokEkCbE0Aohecv70znll0wiew2MXcganUyP3aQPc0DgL/rcPEKFtcRyrn9qH2vaY8/0xQzgPOZHTp1Q8wv4L80jQG1LNJ49x0zaELJRjgsOe0NzX3X6QSo50M1MFzb9Nj3k2x12gFYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733850550; c=relaxed/simple;
	bh=kmpw+MU85Klv2VgMx3ZqVirEPF5gOEEsCLRROZYzfzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MX6CERD6kiBFG33ckOtOTt/TykFWvxKKZu6+i6dfuMTxoIXXeCJsvXFtPteVdGb/YiKJINYzT0r2f6PT2SxdOcQGNn8YIu/0pCCjOyQRZPIUKyntWnEPl8fL853plbBbJd5Wmyva4XKJV8H0T6kOTO6GrEBbyTUTIw6w8JU1u2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lkm2W1a/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401c52000fso2435102e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733850546; x=1734455346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuhRNegPQNd7+gF/yjuNpjthxXavGQO/1ZgSXezZky4=;
        b=lkm2W1a/idpkoQhC8rT/QkOJlS/nnHiVXKrL6LmHPsuzSNaOuVXZG8IMj9Ey+kpZhF
         uZWiIFVS5nFihyzDswETynDUQI0TAa9R5h2WuVIpUTLnvZTN3G/4dN3lUbVnuLiU+Zbo
         fgFgRIvljUe/3l90XTqsKi8so5sodmSO53G2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733850546; x=1734455346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuhRNegPQNd7+gF/yjuNpjthxXavGQO/1ZgSXezZky4=;
        b=s9Egr0nfM661IzPU9uSRITt0nVOwDgIxB/KTU52YoKlVwQXH3fWiSr15HGsQ9jiWEi
         unKAe9LXw02YSdT3R1y81LAb38JOPeYMTamDI/z7bIVgQupjVrhq/HnbBO+FdDTofIb/
         jpX10wvhm4YJsrOb02ecxG+wza5n4ZQ0Gm4UgQRU620WzwnO6dY4DvijW9WOcjerdby4
         GzIoizBPbLo80XgrtsE92Z4JFBNhWeejba6AXuEVbd4kSwgUhm3CIMoNbgQy+1Cox0jk
         s8vQeudjp/fk6l7JdfIoYcOMeJHWVSXlW14G7KjehXeXMRiDJPi8p3pH8hr/eeAxMcNk
         g0Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWv1vwnGJRi5vvBmBpjkre9F2dMLLG/be4Qb0Wj9S8iMZGUAsEoRLjev/BEHo7ax6PhWmO9YuEfMgjLljk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJYnAH6QHiZGuAwk6XiuX6ROlr13+y3dbRuy8BLaD+p39sonc
	uuhLrl5G66UVwnl97exKpIkR5BgsiH0yDeo3/lvJRdjBRaoq7vcWySH6oQJwOSDWeoSAo4WogVo
	VHw==
X-Gm-Gg: ASbGncthHnuS2NnkXGuB3z6stinHURkpHrJ9VICJ0eQt/6P+8jvweWLnbgcAuUKRGjo
	a6eFBz5NGzfsSzpHPOY0IhYYCemlHuiyWVviIE26z3hy036MPPrDaLkm+8gwDLl7cTZQkyJhOrp
	4isx1QCOhosxFzVIbZXuPM2ilbnWvPTSff2YfRdn+7YEACh3pc+LwEAlWsveVdkJNEGP/8YTY0E
	IBiGP9+Vi0FDh3ZEcCLnfSdPCAKLTBilHkiAcGaZzZ+ITD6TC3Q4YEdJFx8pAefTxE4R65zharm
	wV8pyDoWBMnchlwT7Q==
X-Google-Smtp-Source: AGHT+IEn0Qez9FAqeh4gb6MVbGzUqhxYTnP8C5zUzfj8/i5XNg7/3CIl5t8cgJytiZz1MPDtzUSmTA==
X-Received: by 2002:a05:6512:1095:b0:53e:94f8:bb30 with SMTP id 2adb3069b0e04-540240bd78dmr2060238e87.24.1733850545829;
        Tue, 10 Dec 2024 09:09:05 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e37e20ebesm1327400e87.110.2024.12.10.09.09.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 09:09:04 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401c52000fso2435039e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:09:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvU7ntjG5byUngyvlA5tcvT3zEYiaTF5VWLSsm3CDuklxskfhDftxO6rWrRpYRAKnpqVwCG3rQ0Aky9TY=@vger.kernel.org
X-Received: by 2002:a05:6512:33d0:b0:53e:368c:ac43 with SMTP id
 2adb3069b0e04-540240aac8fmr2378233e87.5.1733850544359; Tue, 10 Dec 2024
 09:09:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a68a0e3f927e26edca6040067fb653eb06efb79.1733840089.git.geert+renesas@glider.be>
In-Reply-To: <7a68a0e3f927e26edca6040067fb653eb06efb79.1733840089.git.geert+renesas@glider.be>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Dec 2024 09:08:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XpRt_ivSDz0Lzc=A+z3KFrXkVYTn716TD1kZMAyoGQ_A@mail.gmail.com>
X-Gm-Features: AZHOrDkvV4hXVBzL5LdGwv2-ywEkfcu0N74i9maLRg8R7KrBlypjtg_v-QyKEuk
Message-ID: <CAD=FV=XpRt_ivSDz0Lzc=A+z3KFrXkVYTn716TD1kZMAyoGQ_A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi86: Fix multiple instances
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Linus Walleij <linus.walleij@linaro.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Greg KH <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 10, 2024 at 6:19=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Each bridge instance creates up to four auxiliary devices with different
> names.  However, their IDs are always zero, causing duplicate filename
> errors when a system has multiple bridges:
>
>     sysfs: cannot create duplicate filename '/bus/auxiliary/devices/ti_sn=
65dsi86.gpio.0'
>
> Fix this by using a unique instance ID per bridge instance.  The
> instance ID is derived from the I2C adapter number and the bridge's I2C
> address, to support multiple instances on the same bus.
>
> Fixes: bf73537f411b0d4f ("drm/bridge: ti-sn65dsi86: Break GPIO and MIPI-t=
o-eDP bridge into sub-drivers")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> On the White Hawk development board:
>
>     /sys/bus/auxiliary/devices/
>     |-- ti_sn65dsi86.aux.1068
>     |-- ti_sn65dsi86.aux.4140
>     |-- ti_sn65dsi86.bridge.1068
>     |-- ti_sn65dsi86.bridge.4140
>     |-- ti_sn65dsi86.gpio.1068
>     |-- ti_sn65dsi86.gpio.4140
>     |-- ti_sn65dsi86.pwm.1068
>     `-- ti_sn65dsi86.pwm.4140
>
> Discussion after v1:
>   - https://lore.kernel.org/8c2df6a903f87d4932586b25f1d3bd548fe8e6d1.1729=
180470.git.geert+renesas@glider.be
>
> Notes:
>   - While the bridge supports only two possible I2C addresses, I2C
>     translators may be present, increasing the address space.  Hence the
>     instance ID calculation assumes 10-bit addressing.  Perhaps it makes
>     sense to introduce a global I2C helper function for this?
>
>   - I think this is the simplest solution.  If/when the auxiliary bus
>     receives support =C3=A0 la PLATFORM_DEVID_AUTO, the driver can be
>     updated.
>
> v2:
>   - Use I2C adapter/address instead of ida_alloc().
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 ++
>  1 file changed, 2 insertions(+)

While I agree with Laurent that having a more automatic solution would
be nice, this is small and fixes a real problem. I'd be of the opinion
that we should land it.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If I personally end up being the person to land it, I'll likely wait
until January since I'll be on vacation soon for the holidays and I
don't want to check something that's slightly controversial in and
then disappear. If someone else feels it's ready to land before then I
have no objections.

-Doug

