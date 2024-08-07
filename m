Return-Path: <linux-kernel+bounces-277547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2212494A30A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1330B22FF6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C71E1C9DF0;
	Wed,  7 Aug 2024 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dBHag/Cr"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584F1C8FD1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019207; cv=none; b=H6S03Xof4m5RJOnXvupOXCxwKrBmF0XBzt3DoaT54ROyWSnS68mEuOjNMBcfUyJMKXq+Z297WuZzIiYDc3ITEXFE5ONYeQNVYL+Rc998C16zlIux72jAFM1cPMC/y/LNtKrBpQaPm2H5RDurmAnSQpPJuNmEc4BYARkFarGw2/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019207; c=relaxed/simple;
	bh=tj7dPLjohlXqXC4UMPaCrmG8QKp9rTWHCWtYtTDim9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SmfpV1miT+017EpFBhMkZHh+nXDWmCWVhSVJdOb9sunqtxpZJZLGP+Ku3Cxm7OUQ2vmY66YpooO+q2fUSd9Ts+maMv5N3d+UwrEbNS8ixbqTX7Fncy5E+cWBYn8ckMP3S0qf9u4XArHET8kXQxanssH5pcpzq83WMsutGvxuZQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dBHag/Cr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42803bbf842so14379955e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723019203; x=1723624003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZHByOv0mOQel4KMBZjJK3uZiiCwuwlf50RnLCFOcRk=;
        b=dBHag/CrOYN+vaKffxSqOiozgEMO5b7XAqzo8yaPVzkuSpHd8vppwVJAl61EvHXgcD
         BS4IDl6DLU6tRZ4prR4RAMovpR315lJL0YD8cQPPMcsPmS72RlktBb7Fc6IGP13V8wKO
         zq5ruxWQTPngbeRaE+7ZDcwtA2BrNhoRoMbxgt/x+SkAvaeES9WFjBWsLNawV3wLcvmx
         bBsxPBVXcEjCR9GkITHjG6WtOF5MZvVKOiaw2tiuRX8RvU/HwP+MElQbcMHOZHXJ3Yok
         DHTUal8TNRYFz702fO+usksGpuTlfhc9/V/HD1hviXP67O9N+X1UJqNoVW+bPovEnGAG
         PA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723019203; x=1723624003;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZHByOv0mOQel4KMBZjJK3uZiiCwuwlf50RnLCFOcRk=;
        b=JilRI1bx6nJ6NyF87KDMQ2lrgtiNz8WSuv6FtzB0NBHMwO2xhULZiqrSg1+Ih9T/Wd
         c106PN6V8Bf/woV+TJmDPGP6RHW8sZ1BbVWbLgQNvwH/DoEJteIzOVrniyWwzP5IQZoG
         mFANWjJlyOADJ+F0csmQH2yQwiJUcbuJ00MXO8cA9gdpJy2dHDDk7Mk3HmAljZ5luTZI
         I4mDvR/JI7BAN+42p9bAOO3eGec5aCJGKyg3+ID37mFN2GjQZyw3n2M7qFwL3WgA0gGg
         lNH5kR3GChmRUjmc7Zr8HNL8wdfQETS6f8YXPgI/tYCwPH8xEbSAIC5VozAqgeKJ8iy7
         U+pA==
X-Forwarded-Encrypted: i=1; AJvYcCVSmYBPIXjh+c0T68ahGqiGwFgZSpyfYV1sdSFw9zaFvE7PaKbA77+uXnTvB+xxlgBKZrMcm57EquDi4xaY04pvK63COWq+0x1Dat/G
X-Gm-Message-State: AOJu0YyyirTgyLMvnuEyrhrbQt+TZlu+eSthKPl8mqh5ZoU+rQz125XN
	hX1tYF/kRbZ9JVl2gP5W400z3iDEYeWQbu5BSPtnF41CtQ+viIB6e1MpCmlCA1XqVivFvIS/pMy
	CQAA8Lw==
X-Google-Smtp-Source: AGHT+IFz38MFkpvdt0BKpKNIiKOyIyBho+s/Gh9rbf8GDZAtKNc/QE+/bIeiT1DD/pgoorf5EawALA==
X-Received: by 2002:a5d:5510:0:b0:368:6606:bd01 with SMTP id ffacd0b85a97d-36bbc1c4abfmr13978046f8f.55.1723019203144;
        Wed, 07 Aug 2024 01:26:43 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:90f1:3c4c:261c:b0f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290580cb80sm18381625e9.45.2024.08.07.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:26:42 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>,  Kevin Hilman
 <khilman@baylibre.com>,  dri-devel@lists.freedesktop.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] drm/meson: dw-hdmi: split resets out of hw init.
In-Reply-To: <CAFBinCCvWFCCvb9gPvv0-eudG=iuKROk5rPSiorKTnHcToDfTQ@mail.gmail.com>
	(Martin Blumenstingl's message of "Tue, 6 Aug 2024 22:49:40 +0200")
References: <20240730125023.710237-1-jbrunet@baylibre.com>
	<20240730125023.710237-6-jbrunet@baylibre.com>
	<CAFBinCCvWFCCvb9gPvv0-eudG=iuKROk5rPSiorKTnHcToDfTQ@mail.gmail.com>
Date: Wed, 07 Aug 2024 10:26:42 +0200
Message-ID: <1ja5hozqkd.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue 06 Aug 2024 at 22:49, Martin Blumenstingl <martin.blumenstingl@googl=
email.com> wrote:

> Hi Jerome,
>
> On Tue, Jul 30, 2024 at 2:50=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.c=
om> wrote:
>>
>> This prepares the migration to regmap usage.
>>
>> To properly setup regmap, the APB needs to be in working order.
>> This is easier handled if the resets are not mixed with hw init.
>>
>> More checks are required to determine if the resets are needed
>> on resume or not. Add a note for this.
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/gpu/drm/meson/meson_dw_hdmi.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/mes=
on/meson_dw_hdmi.c
>> index 5cd3264ab874..47aa3e184e98 100644
>> --- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> +++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
>> @@ -581,11 +581,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi=
 *meson_dw_hdmi)
>>         /* Bring HDMITX MEM output of power down */
>>         regmap_update_bits(priv->hhi, HHI_MEM_PD_REG0, 0xff << 8, 0);
>>
>> -       /* Reset HDMITX APB & TX & PHY */
>> -       reset_control_reset(meson_dw_hdmi->hdmitx_apb);
>> -       reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
>> -       reset_control_reset(meson_dw_hdmi->hdmitx_phy);
>> -
>>         /* Enable APB3 fail on error */
>>         if (!meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
>>                 writel_bits_relaxed(BIT(15), BIT(15),
>> @@ -675,6 +670,10 @@ static int meson_dw_hdmi_bind(struct device *dev, s=
truct device *master,
>>                 return PTR_ERR(meson_dw_hdmi->hdmitx_phy);
>>         }
>>
>> +       reset_control_reset(meson_dw_hdmi->hdmitx_apb);
>> +       reset_control_reset(meson_dw_hdmi->hdmitx_ctrl);
>> +       reset_control_reset(meson_dw_hdmi->hdmitx_phy);
> The old out of tree vendor driver [0] enables the "isfr" and "iahb"
> (in P_HHI_HDMI_CLK_CNTL and P_HHI_GCLK_MPEG2) clocks before triggering
> the resets.
> Previously meson_dw_hdmi's behavior was identical as it enabled the
> clocks in meson_dw_hdmi_bind() and only later triggered the resets.
>
> I'm totally fine with moving the resets to meson_dw_hdmi_bind() but I
> think it should happen after devm_clk_bulk_get_all_enable() has been
> called (to keep the order and thus avoid side-effects that we don't
> know about yet).

Good point.

I was also thinking about squashing this with the regmap patch.
I've split it apart for v1 to make things a bit more clear but it only
really makes sense with the regmap conversion.=20

>
> Also out of curiosity: are you planning to convert the driver to use
> devm_reset_control_bulk_get_exclusive()?
>

It's been a while this I've done that. I remember I thought about it.
I think it was a bit more difficult to use that clocks. I was looking at
making the driver a bit more clean and simple. It was not really helping
to move it in that direction IIRC.

>
> Best regards,
> Martin
>
>
> [0] https://github.com/endlessm/linux-s905x/blob/master/drivers/amlogic/h=
dmi/hdmi_tx_20/hw/hdmi_tx_hw.c#L470

--=20
Jerome

