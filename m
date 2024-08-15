Return-Path: <linux-kernel+bounces-287815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2238E952CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DCB1C21200
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200F119FA89;
	Thu, 15 Aug 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gSWfRbD9"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0619EED4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723718465; cv=none; b=GyPgsNfqzXP19EdqGC13pZaJFRUXEGtctHQK3w7Lfd5D73SWy7NB3o9SkvDpuif4dhe/1bNvMONYX/CZmZKLMf7whL3LRs5qu6IplHutxFYSNxdpq6JDAYkg/vwBpHd7sIzoKRrz9PVkJ5Ut4uBrKt3MbSOMwv+DRV5kX1vICKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723718465; c=relaxed/simple;
	bh=t+Jjz5X/AN6g/K0k0bwIHeoDPVGIBjHW8rEfBjN/iNY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGGmY58Tfv/XDc+34yDhUf923vOBaOIPlIt8/CsYIvPgvY2ndOW1I+CVavfaKNVdzUIBJlKhH+IUdpcPSjckVIgaUU09QrBEuva2ymj+bAP8KebwTaN0tOlSZdwqlwN/2HHhCStfpEo2wuC5h9ueFxHmb+R3ngshBZsJD/pLVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gSWfRbD9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JtSYMyjFwSHhr4JtGadybcU9/7LYdzxEw3v7M77JOOI=; b=gSWfRbD9AgJemxejQrnE4jm7Z+
	yogtanjJkf9uoZTJp1wo11bDeGrPq+AhivlTvFWYrkkOzMXbtQGDoYu2ZJDDTjOz5KoKCYG1IIhXz
	ma08MKO6MPdooJ/ppqXLN5l9cWnO2oFpDplHhm9pADOkD6ihvs7x/T5Vbq0sFjlb9jIFuUom0A6lC
	9zE2JiKvkXsqF5cXHFngitFfAYUgN5piYur+dqQPCbCpsFwlirbtJu6bOZpCNs0A7mKM1ERYxv+t7
	BVRDOH1DQAMAt7yCxSGOuPQCS5rv78T1DV9xHa/giPjTq3+XFz3NsPmzepr9gYPh7fKzFuLlK7LGV
	HuuY0YiA==;
Received: from i53875a9f.versanet.de ([83.135.90.159] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1seXuH-0000nZ-PS; Thu, 15 Aug 2024 12:40:37 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Val Packett <val@packett.cool>
Cc: Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 0/2] drm/rockchip: vop: Support internal display on RK3066
Date: Thu, 15 Aug 2024 12:40:32 +0200
Message-Id: <172371788341.684432.2581958703388281846.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624204054.5524-1-val@packett.cool>
References: <20240624204054.5524-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 17:40:47 -0300, Val Packett wrote:
> This tiny patch series makes the changes required to enable the RGB
> display output on the Rockchip RK3066 SoC. Final version as discussed.
> 
> Val Packett (2):
>   drm/rockchip: vop: clear DMA stop bit on RK3066
>   drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066
> 
> [...]

Applied, thanks!

[1/2] drm/rockchip: vop: clear DMA stop bit on RK3066
      commit: 6b44aa559d6c7f4ea591ef9d2352a7250138d62a
[2/2] drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066
      commit: 6ed51ba95e27221ce87979bd2ad5926033b9e1b9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

