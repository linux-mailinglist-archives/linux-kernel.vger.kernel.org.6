Return-Path: <linux-kernel+bounces-559518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E16AA5F4EB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB31B19C2A84
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C574F2673A1;
	Thu, 13 Mar 2025 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hHjw2pig"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F14F24E010
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870176; cv=none; b=Jr27wUs+uMyJ0YC6Sk53fQzVv5qgW7nE1cjMYUq0vtMRBQiO1Kv7/3dgkvv/Vu7GVDy/aEQlFlXdS1KJCYmVcsaXc1HiJSFbzbc7bVZsd2C1q+1bgQV/MMw7r1X4bTrl5AOhD1q7EJAv0YyRMzHg+/YREKms13v9GFbnxExo9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870176; c=relaxed/simple;
	bh=ldBDGgTkPPYuyTRF2v5+H50f0Ki5xayYC0ECnthlcf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2amFgmumfJqaMRkVunW9YqHCezppCv4k84Ru+84UegWD+3sw4kAggPbB00tysyZfKMyN4ojvkmu912oHIwOsvcGE7yZ96mulH1BgEd675OLqNIZgtsDkPA3Nnv2dxzFHZc7k/FLWtFD4iS/65hcjxgVnFlOaiIM2w7TS65/hR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hHjw2pig; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741870172;
	bh=ldBDGgTkPPYuyTRF2v5+H50f0Ki5xayYC0ECnthlcf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHjw2pigsG5DsBzm/jEYPomMS3pE9MEp3/MLzh/rHvopa2pA6QJsSXsqK/CqL2TTX
	 jwVZDNMymLABCy7ct0McWzze8s6ps5RQQKiCh3YgLnd59nvlAEqIEtT/g/qxsa5j7V
	 DTvSO2bH19OcPuM8BvagGbnDSMLF/Ld7gevIk/wq2s8cjRJW005pKFqCEKnv0+NwIi
	 qIrBOUwrWM0ziTER+j0hdkHznr0F6UaPA9tWzLGIdxxBDEqspB/2sUnlwIiUmauKSX
	 m+c5m3+R4Yj8HiPleDFrUdj5SSD0b1dPEkzZ+o9U633FnEI9UnUz8QCzk3msE9u3gG
	 P6l4pp4dTkwjA==
Received: from notapiano (unknown [70.107.117.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A653617E09AA;
	Thu, 13 Mar 2025 13:49:28 +0100 (CET)
Date: Thu, 13 Mar 2025 09:49:26 -0300
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: linux-mediatek@lists.infradead.org, chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
	krzk@kernel.org, daniels@collabora.com, airlied@gmail.com,
	simona.vetter@ffwll.ch, arnd@kernel.org, ck.hu@mediatek.com,
	laura.nao@collabora.com, matthias.bgg@gmail.com,
	tzimmermann@suse.de, mripard@kernel.org, lumag@kernel.org,
	ville.syrjala@linux.intel.com, jani.nikula@intel.com, arnd@arndb.de,
	geert+renesas@glider.be, wenst@chromium.org,
	linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: defconfig: mediatek: enable PHY drivers
Message-ID: <986ad850-3e7c-43f4-84f0-cbce888676fe@notapiano>
References: <20250313040855.62259-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313040855.62259-1-vignesh.raman@collabora.com>

On Thu, Mar 13, 2025 at 09:38:24AM +0530, Vignesh Raman wrote:
> The mediatek display driver fails to probe on mt8173-elm-hana and
> mt8183-kukui-jacuzzi-juniper-sku16 in v6.14-rc4 due to missing PHY
> configurations.
> 
> Commit [1] stopped selecting the MediaTek PHY drivers, requiring them
> to be explicitly enabled in defconfig.
> 
> Enable the following PHY drivers for MediaTek platforms:
> - CONFIG_PHY_MTK_HDMI=m for HDMI display
> - CONFIG_PHY_MTK_MIPI_DSI=m for DSI display
> - CONFIG_PHY_MTK_DP=m for DP display
> 
> [1] commit 924d66011f24 ("drm/mediatek: stop selecting foreign drivers")

Usually this would go directly in the paragraph, like so:

  Commit 924d66011f24 ("drm/mediatek: stop selecting foreign drivers") stopped
  selecting the MediaTek PHY drivers, requiring them to be explicitly enabled in
  defconfig.

But that's just so you know in the future, you don't need to send a new version
just for that.

> 
> Fixes: 924d66011f24 ("drm/mediatek: stop selecting foreign drivers")
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

