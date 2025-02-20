Return-Path: <linux-kernel+bounces-523902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF8A3DC9E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48ED77A8CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F4C1FBE8D;
	Thu, 20 Feb 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgYP5nVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466031C174A;
	Thu, 20 Feb 2025 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061521; cv=none; b=QuQDWwutLjiqQN5rvcOXTg+9iFxzHc/R4gbtAiTixKDT+y3o8a3Ie2wQNdS2XMaX2isbpaIlLHkknH11jJAfReD6p2lwout1Rk77GRJOG74+lS90V3BOkW1L1OswAHM/xc/Bti2S0ifk40il1Wk8DS0silFrgWeoo/IrUZNPYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061521; c=relaxed/simple;
	bh=iJw0LuLV1NQL5MljcDvcrTafJWx8F0Mgu90Nuo9CPBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q70OgBkJir42jHXuvIu8DcJkoplIO7WCqjRAycWqWlQMoJhvwLMsvu9TW6Z/VQrLbHES6ww0T0W5dYMGxrH4HutP57VQfvarRWGXMShcbyTxSC1QGHnk74zL77PWqwdrRW3rPhmxx/LoXl0nDPoGsrBo5NyWwOYQqHCXr3WfA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgYP5nVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1824C4CEE2;
	Thu, 20 Feb 2025 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740061520;
	bh=iJw0LuLV1NQL5MljcDvcrTafJWx8F0Mgu90Nuo9CPBQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fgYP5nVX6K3cEeC6Xtpa2YYOrXt4jQeXL8JCyvGMF/Wq9c/Dl1/rzYfnGKwkDKuVR
	 gHb6C+na0d68Og2C7gXIj0iZJM/3qULNH6hQDAa+vTSZk+GFYMOa3A6fCw2mvk5u6/
	 5uVn7cN2Q4sF+6TSewFuRa6c15BcwOzD6G3+xxYO1TO42azPYmzrGDuN94WZ9MN13A
	 /zC+sCSTBD90yJpZAjlY+scHgCW6bQaqC1h6OSdy3vVf4GhwPcG90FifloOqbqG+JM
	 Q3kcjg4+GG8Qe7hehQ2kR6/y1OqdCXRiFqVcwDx9tuwEGi1ReteqysuVMEMzKcrt/F
	 TSz8OW1ul2wig==
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fc042c9290so1684813a91.0;
        Thu, 20 Feb 2025 06:25:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUX84IktpyeN2Y/wSAM380HDsnH4qDrlHs/AZKHXajVXdCZzR3GJ77ri5LLBir6y7WeP5f+kKsE1ouObpxi@vger.kernel.org, AJvYcCXS3+4jcQxe2lPxee2jbHR0PZ9n7nJkkk58hF2L8Wp3GAAoX9987Uum3fT8+IXdjPEIrnC2X+0bY4/r@vger.kernel.org
X-Gm-Message-State: AOJu0YwrE2rGfUdTn2lY/Sy4tIvLYcVEFCVzratO/ePhWoORaJF2I/KB
	RNPeBwazpzN6Rk0K3DW2GC1VbyCZOsb3uW7d6x74wQtM5ViWauZvcPOeUXGp76tK0ZmzDGvtUEn
	pNGesFwLpXFB2BTyn5BSuSHL+2g==
X-Google-Smtp-Source: AGHT+IG6zBpHgkEKWKPXjExGKcMJ3P8RA+4Pl+cW3k6VsvdLJSFhWdQ6SLc1qU7bLx4Pas4JfqVSRji56XJkJ5sp9FQ=
X-Received: by 2002:a17:90b:510b:b0:2ee:f076:20f1 with SMTP id
 98e67ed59e1d1-2fcb56e68dfmr15217411a91.0.1740061520261; Thu, 20 Feb 2025
 06:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com> <20250217154836.108895-33-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250217154836.108895-33-angelogioacchino.delregno@collabora.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 20 Feb 2025 22:26:05 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-54w+_nZtoKiOjw0z3+BxoygKR0zUvUevW4ZijrBWA4Q@mail.gmail.com>
X-Gm-Features: AWEUYZm7oGrflVbB-goWTArAWPiYKFdjfVm86uPsqne31Recqtf46FuqDQvfcSk
Message-ID: <CAAOTY_-54w+_nZtoKiOjw0z3+BxoygKR0zUvUevW4ZijrBWA4Q@mail.gmail.com>
Subject: Re: [PATCH v7 32/43] drm/mediatek: mtk_hdmi: Remove driver bound to
 HDMI print
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com, 
	jie.qiu@mediatek.com, junzhi.zhao@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
	dmitry.baryshkov@linaro.org, lewis.liao@mediatek.com, 
	ives.chenjh@mediatek.com, tommyyl.chen@mediatek.com, 
	jason-jh.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Angelo:

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> =E6=96=
=BC
2025=E5=B9=B42=E6=9C=8817=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8811:=
50=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Remove the "driver bound to HDMI" print to avoid useless spam in
> the kernel log, as registered and bound drivers can be debugged
> through debugfs.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediat=
ek/mtk_hdmi.c
> index 2e98a8ed6cbe..50f9ab48cbf9 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1632,7 +1632,6 @@ static int mtk_hdmi_register_audio_driver(struct de=
vice *dev)
>         if (ret)
>                 return ret;
>
> -       DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
>         return 0;
>  }
>
> --
> 2.48.1
>

