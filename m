Return-Path: <linux-kernel+bounces-222808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAA89107FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DA2281F76
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E411AD9EC;
	Thu, 20 Jun 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjKmnhmM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E491E48B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893202; cv=none; b=SWKM40cQ/s4gj1akmRy1MJUiEKvxfuc8iZ8DOb6Xq7p3WSNVvdFERTOOyiddeDgACNhOXPnwNnjOQnyqbTD2EUcuqm7PhJ9l1mcAUmHFmeHL0Kb3v4adXYqkYHe/o0bc08adhCpicDoam0CYioVIjv8MKixCtrVM/PSOgbmVR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893202; c=relaxed/simple;
	bh=/JAmiiZWB1tRsr19XCxymVqTazffJcs1aVIaFgEx5Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLMJPo6byqVn2q/WAINkS7IIqE2aMgckrFx5gotxWl9okG5rrajGeFsATM8//RGqs/hvnZeI82kow22V5GqUhq8MxNfwuxv8Zoe2h+YhupP5ex/mz0g/B5jPUOdYKtAzz17HSDfZXWByp2UheYE9f+y5V0CVZrX7TvLfzZan/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjKmnhmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD136C4AF11
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718893201;
	bh=/JAmiiZWB1tRsr19XCxymVqTazffJcs1aVIaFgEx5Lg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hjKmnhmMuRYAIox5aFwp23aYhNQo09aZc6unr5JtyYrq13JS3cOL7wduKrXlEjmoR
	 OvPs2i8PelIqInD8a3IzgdJT5/vP6aofnkeG0bPqFv5gnYSL1vpYQuPrP378KYiwAj
	 GuWHxSaEn+1Aqww3Z5Z+vUcBlPE9Hwbc4ujvNKOnVzx6SPU9dAF8AkfkMfaggP/IYY
	 INuXmfGEBg51aKfr9/f5J1XF4I2bE+DnoVPpIR75l0itopeyE+/qCGDVR2MLdOBiNq
	 sjeiFGs/468ioohTStQ5WpaaBL7IA7m/RjoW7eGeED9y6cioBVEVDmvCEzejfMSeyp
	 cLtw2q7j17Pgg==
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-70df213542aso701290a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:20:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvrkFl+cVFEeAk+ZbNhytk85UhfoJdOLBFfcihgxU8ogaWFfVJitqCGCEAwjXjO5Temzw2zryHvDDMoiPNtUSVScgBtHdz7cp/u7yW
X-Gm-Message-State: AOJu0Yy2CFEvOkkQ2G/jiY0pdVfQACJkzqmc4gh10ihdDUSzfLTBeQEz
	0FfbdDaafoE8Dvv5ffLgCKOsRj9LG6ExFgKJmYybSIhQkAYv2oqdWuhbUfd5vfq6whYs5whJzNF
	Vb7iWz4m1A2wTuA9XsddTqj/pTQ==
X-Google-Smtp-Source: AGHT+IFdX5LFhKH0jgJGzuBnyaSdfplQkl7Br4G/jei37asmuDLLgaokqkFn5thWy43rneZsfwc0lfFXrdK0roAHWok=
X-Received: by 2002:a17:902:f54d:b0:1f9:b7ea:c320 with SMTP id
 d9443c01a7336-1f9b7eac674mr34658135ad.41.1718893201169; Thu, 20 Jun 2024
 07:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620054708.2230665-1-wenst@chromium.org>
In-Reply-To: <20240620054708.2230665-1-wenst@chromium.org>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 20 Jun 2024 22:20:07 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9tLUAcw+C5D78SNwrV6kHds7JhtAoFYFmxxfAH9vtkDQ@mail.gmail.com>
Message-ID: <CAAOTY_9tLUAcw+C5D78SNwrV6kHds7JhtAoFYFmxxfAH9vtkDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION=y
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Chen-Yu:

Chen-Yu Tsai <wenst@chromium.org> =E6=96=BC 2024=E5=B9=B46=E6=9C=8820=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=881:47=E5=AF=AB=E9=81=93=EF=BC=9A
>
> With the recent switch from fbdev-generic to fbdev-dma, the driver now
> requires the DRM GEM DMA helpers. This dependency is missing, and will
> cause a link failure if fbdev emulation is enabled.
>
> Add the missing dependency.

Acked-by: Chun-Kuang Hu <chunkuang.hu@mediatek.com>

>
> Fixes: 0992284b4fe4 ("drm/mediatek: Use fbdev-dma")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> The commit this patch fixes is in drm-misc-next. Ideally this patch
> should be applied on top of it directly.
>
> CK, could you give your ack for it?
>
>  drivers/gpu/drm/mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/=
Kconfig
> index 96cbe020f493..d6449ebae838 100644
> --- a/drivers/gpu/drm/mediatek/Kconfig
> +++ b/drivers/gpu/drm/mediatek/Kconfig
> @@ -7,6 +7,7 @@ config DRM_MEDIATEK
>         depends on HAVE_ARM_SMCCC
>         depends on OF
>         depends on MTK_MMSYS
> +       select DRM_GEM_DMA_HELPER if DRM_FBDEV_EMULATION
>         select DRM_KMS_HELPER
>         select DRM_MIPI_DSI
>         select DRM_PANEL
> --
> 2.45.2.741.gdbec12cfda-goog
>

