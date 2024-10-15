Return-Path: <linux-kernel+bounces-366215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8A799F24A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E2E1F237F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A788B1EBA0A;
	Tue, 15 Oct 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOGNiF7f"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A873BBF6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008383; cv=none; b=t3xwCiXdvZx4++B027KFiaxEgDq3qbaajd7IeuDewFaANKkAgP15tyA+RxnOW+L0xUAkfFKJoquLsu1vWWs9HoZXeWGpw4FSTsUu0heCqtkhUdKN68yeC9HVpbuuR9wiDrAQ7pwQ9TaQXtT0ci7+ol7xGEm/SFHVw4WOaCFx30E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008383; c=relaxed/simple;
	bh=coV+CW89lf2xb2YOQ9WrDQ5/UFSIDkfrD6hBq941WwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YoJKtOt+zQq7Vh+fPjtNNDivQ2qrmvto3zTTaIjFijn+oo53A0TKrOMFQH1CcV2eqa8dq4pwJknG3pcV8PCJVbCltOld9t1/LombjC79O+xP3Wtlh5Byue68KIUrngDY99IIO4Kw0YG0wGT32jYbq5ldLky92Os9HmkFSv2yV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lOGNiF7f; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-539fe02c386so99e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729008379; x=1729613179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXMfoHtJcAiX4YFy/v4VHJn4H6jq9Bc4cWujSEwbcdk=;
        b=lOGNiF7fh099XNfRmTG8719InGkcNW98XxAXlhttTSep181Qygv+IgRu8azTa8zbxt
         XnasfUSxMVAC9Yvr+PG3m22c7XuL9q/dXOnt717ZbWM5iLaGkhOIHXh/b9HHBggvM4E5
         znqI48iNeMmvVj0h5EozJsF+H+1E3K06u+ymw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008379; x=1729613179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXMfoHtJcAiX4YFy/v4VHJn4H6jq9Bc4cWujSEwbcdk=;
        b=NEp34KvaaTFAmJNyhP3FMeixHbbKoa6hxSPIDqFiAPXLnlwKAoAfDvzcslqaiiHGR4
         2IDgv8+QCNCZ1YguIadl07sfmerUTBEbxT8qU4Z3Lpvu5braiIiDW97LtVz+6K/OU4BN
         m/JDvID5DhBcTxe56S0pmycStD3nc5I957Dzp01Mnpvj96Dybe3O/skoXpdHJsHbz8PM
         Y5QX4vt4RCq1140rrsc5I745V/JAer4lkVStb9nek+U8ftj/ZcGFauK0/yDr2BS/LO28
         +RVTLPeT785VKyD/lUikMNGM2XeF0tBuHUDVTpPmMn+Kks9uQ3oqpIE8BBwDpstZM1PD
         cCzA==
X-Forwarded-Encrypted: i=1; AJvYcCWyiSXn03lzn8XRHU20RPqXkoc/OesnLIXIvH2rYstC4E42tXjnWnjVbEJ0lywgu6BSjpbXtN5n2JuI2sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/e21sfY1ADkDdLaymI/QQZQ0TpUvWHNfQ250vXcN65tqpXC/
	W6g47YC1B+0pc9bsn8yEin+TFyUVlKvVrRQzSqrleiFZlnu70UYLTw7+WPK1BU32l57wm/mtw2G
	ktWns
X-Google-Smtp-Source: AGHT+IGEoMP2j9uNH65RNYu3UjSDlJblsog5X+0ZTldHQcidpeCxEm61YDvH1gYpCdgOFJFrFiDBNw==
X-Received: by 2002:a05:6512:104c:b0:539:fd1b:bb0c with SMTP id 2adb3069b0e04-53a03c9efa1mr405385e87.11.1729008379094;
        Tue, 15 Oct 2024 09:06:19 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539fffb4930sm204250e87.119.2024.10.15.09.06.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 09:06:18 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e4b7409fso3312870e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:06:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9kaMLG/GDhahlxAo4aPQFg9ZQEDanA/3+FKy1EJcUNJ9NISfdEjzjK050qljOWiaWu3Qg4MGVWzDG4Kg=@vger.kernel.org
X-Received: by 2002:a05:6512:a95:b0:539:edc9:7400 with SMTP id
 2adb3069b0e04-53a03cc8dedmr370366e87.20.1729008378263; Tue, 15 Oct 2024
 09:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015134606.5b87093e@endymion.delvare>
In-Reply-To: <20241015134606.5b87093e@endymion.delvare>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 15 Oct 2024 09:06:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WhVWswn28hbxNDLDhMeiZOpsWzsx8OkORniOxWVx_4Gg@mail.gmail.com>
Message-ID: <CAD=FV=WhVWswn28hbxNDLDhMeiZOpsWzsx8OkORniOxWVx_4Gg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/display: Drop obsolete dependency on COMPILE_TEST
To: Jean Delvare <jdelvare@suse.de>
Cc: dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	YueHaibing <yuehaibing@huawei.com>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 15, 2024 at 4:46=E2=80=AFAM Jean Delvare <jdelvare@suse.de> wro=
te:
>
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
>
> To avoid reintroducing the randconfig bug originally fixed by commit
> 876271118aa4 ("drm/display: Fix build error without CONFIG_OF"),
> DRM_MSM which selects DRM_DISPLAY_DP_HELPER must explicitly depend
> on OF. This is consistent with what all other DRM drivers are doing.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> ---
> For regular builds, this is a no-op, as OF is always enabled on
> ARCH_QCOM and SOC_IMX5. So this change only affects test builds. As
> explained before, allowing test builds only when OF is enabled
> improves the quality of these test builds, as the result is then
> closer to how the code is built on its intended targets.
>
> Changes in v3:
> * Rebase on top of kernel v6.11.
> Changes in v2:
> * Let DRM_MSM depend on OF so that random test builds won't break.
>
>  drivers/gpu/drm/display/Kconfig |    2 +-
>  drivers/gpu/drm/msm/Kconfig     |    1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> --- linux-6.11.orig/drivers/gpu/drm/display/Kconfig
> +++ linux-6.11/drivers/gpu/drm/display/Kconfig
> @@ -3,7 +3,7 @@
>  config DRM_DISPLAY_DP_AUX_BUS
>         tristate
>         depends on DRM
> -       depends on OF || COMPILE_TEST
> +       depends on OF
>
>  config DRM_DISPLAY_HELPER
>         tristate
> --- linux-6.11.orig/drivers/gpu/drm/msm/Kconfig
> +++ linux-6.11/drivers/gpu/drm/msm/Kconfig
> @@ -6,6 +6,7 @@ config DRM_MSM
>         depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
>         depends on COMMON_CLK
>         depends on IOMMU_SUPPORT
> +       depends on OF

Perhaps nobody landed this because you're missing the msm maintainers
as specified by `./scripts/get_maintainer.pl -f
drivers/gpu/drm/msm/Kconfig` ? I've added them here. It seems like
we'd at least need an Ack by those guys since this modified the
msm/Kconfig...

FWIW I haven't spent massive time studying this, but what you have
here looks reasonable. I'm happy at least with this from a DP AUX bus
perspective:

Acked-by: Douglas Anderson <dianders@chromium.org>

Presumably landing this via drm-misc makes the most sense after MSM
guys give it an Ack.


-Doug

