Return-Path: <linux-kernel+bounces-557872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970FDA5DEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B477AD554
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB9E24E009;
	Wed, 12 Mar 2025 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Tl3nEoNd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6C7245039
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789565; cv=none; b=JVG97NCgVblOnbcZmMZg84yN1jgX7kPswi7V78E/VsBbb3LEZxi/vGvWCnPiUveivNVQfqba0PfW7+gKuKwxiS6+w7K3D+qnqrToukB7RXLWXeikSymvtzPfr2wXSeLhmFgS+6c10I9bGpxF3xLKK+ZAwm9ov/GgSEWX/UD5nqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789565; c=relaxed/simple;
	bh=D30yYcLGzCKJP0xV33q/0S+ufxFtV0zBn7R8mUrRc9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odl+Lb2QuPV3BF1fxIEzz8s2/IUCq/NmALq4Z45SpdMMpA8RrSqEsPeCwmXHKgXi9jyvW09QOg7CbbBTj28EOMe6zTTEbisRjxHhb1u8zg3zEJwpxwSpWtkNP77N8tQVo/pfuHQvVyxTWD0OVRQ5ovBL2KHBAmBk1V3Ld9Ras2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Tl3nEoNd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741789559;
	bh=D30yYcLGzCKJP0xV33q/0S+ufxFtV0zBn7R8mUrRc9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tl3nEoNdxDokHqsqyV8dCb3k39ooik8vJ4denOVETXReAYKWE06x+vVqe32mEGkyM
	 /dnJqbP4i//hctFThaVzNPfIFYkRpQhWFaIeAI5izl173G5cPZu9QCFq9cPgmwXaPZ
	 WwXb+tH+xvAlia5PWDVFrKenP3JkcdafO5U4j3/7HRcAi0bHYfLD38zfiqpXXylWTf
	 sRzFBu6uOYskRDnQadlKCPhDsII0MsENDzj6AbhfeOLYGkw2G2u++8Jq1XCGlaEugP
	 Msl6PAhIu4WTkNN8nn2Yx9DsCrskwlLCttJc4S/p+BrGS9sonRFgt9Lvr3OStHraEY
	 YZywoGLxZ0/ng==
Received: from notapiano (unknown [70.107.117.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F59517E1134;
	Wed, 12 Mar 2025 15:25:57 +0100 (CET)
Date: Wed, 12 Mar 2025 11:25:54 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: linux-mediatek@lists.infradead.org, chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
	krzk@kernel.org, daniels@collabora.com, airlied@gmail.com,
	simona.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: defconfig: mediatek: enable PHY drivers
Message-ID: <5706c76e-7558-4405-a4c6-cab9cb5ddf65@notapiano>
References: <20250312041943.25676-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250312041943.25676-1-vignesh.raman@collabora.com>

On Wed, Mar 12, 2025 at 09:49:26AM +0530, Vignesh Raman wrote:
> The mediatek display driver fails to probe on mt8173-elm-hana and
> mt8183-kukui-jacuzzi-juniper-sku16 in v6.14-rc4 due to missing PHY
> configurations.
> 
> Enable the following PHY drivers for MediaTek platforms:
> - CONFIG_PHY_MTK_HDMI=m for HDMI display
> - CONFIG_PHY_MTK_MIPI_DSI=m for DSI display
> - CONFIG_PHY_MTK_XSPHY=m for USB
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Include board details in the commit message.  
>   - Sort newly added PHY configs in defconfig.
> 
> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 1f25423de383..87e8cbd3fd26 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1572,7 +1572,10 @@ CONFIG_PHY_HI6220_USB=y
>  CONFIG_PHY_HISTB_COMBPHY=y
>  CONFIG_PHY_HISI_INNO_USB2=y
>  CONFIG_PHY_MVEBU_CP110_COMPHY=y
> +CONFIG_PHY_MTK_HDMI=m
> +CONFIG_PHY_MTK_MIPI_DSI=m

This isn't the expected ordering. I imagine you manually added these configs in
the defconfig.

To get the right ordering, after you've added the configs anywhere in this
defconfig, do a 'make defconfig', then a 'make savedefconfig', and copy the
generated 'defconfig' file at the root to this location, then you can add just
this hunk to the commit, and it'll be in the correct order.

Thanks,
Nícolas

