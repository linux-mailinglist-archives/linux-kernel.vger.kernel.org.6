Return-Path: <linux-kernel+bounces-536427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC4A47F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 394813B30C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14022FF2B;
	Thu, 27 Feb 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GFEjVF6Z"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB00E22DF8E;
	Thu, 27 Feb 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663531; cv=none; b=GygjOQmoOW/JdwYHEkyZfiJfBxL3ECQrw5KK90fSoCpW9qwnq8Jhpt8xt8/DbXKQ3mUUkBv1SSxenCtJUHFBubgAyS+OONtxfVL9MrPg2GQw17t7Q1VkaJlvex3+3YoY5cv3O9/ZX+YAVQavjSfGuhtnP4rt/fboEk2uw/bnvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663531; c=relaxed/simple;
	bh=5wt0a/hmprmYH5u3/+HAePZ7R9lrMyhYIViWGXAjDRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=At4vLtf63+UYSw5mQEmM9/fCMk0ZbI/qFxGMDKziPmEyYEkgMU0u13FA0St0uWIqccOC7a0RXZNQ8/fEPYcOox2mWCaMRqHHIYLCBH5ySGRU9APOtK/x7TghuxGOxam+0FYRFzEexdOW0h6Ta6AaVCNTWOAg2rVKj/A9xFaE9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GFEjVF6Z; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=meVcx23r/r7Dytz72YqeRZuHInvAetvSfHOgo60wpy0=; b=GFEjVF6ZyupV+W2QCWTF/Utl7O
	OgQTRNZSJUwppxQptsnxIyzoPnuntHdT7WgyzUD4CkcAl6USJGFTmLpdZ/tz74XVbyfjBeK5PVB8y
	0hNKQaRQzJYxypYzSM1xgSOFhfX6CZ+UuUetDCtXpKz8ueb+DuvP2mWQfsRLeJ4cLM0HJAwZ4PiJ4
	vUooOewyVgpD4ivZJyI6I3cOiMjwSKjWewiRIcb7U5FZAVqdfbNMsOtwjayDkOg4dkM0TcJ3g9tSv
	pEc7yNRYplHFBKsFXE5hpDqZLN08+/MRsbFu1tFadAfS91BTShdk8v1jVlLuE76cWtgaWbmdgPtBB
	2JN7VILA==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tne5Y-00018T-RH; Thu, 27 Feb 2025 14:38:08 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Alexey Charkov <alchark@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Niklas Cassel <cassel@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Johan Jonker <jbx6244@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Algea Cao <algea.cao@rock-chips.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	kernel@collabora.com
Subject: Re: (subset) [PATCH v7 0/3] Add HDMI audio on the rk3588 SoC
Date: Thu, 27 Feb 2025 14:37:52 +0100
Message-ID: <174066344874.4164500.18360075305644085277.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250217215641.372723-1-detlev.casanova@collabora.com>
References: <20250217215641.372723-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 17 Feb 2025 16:47:39 -0500, Detlev Casanova wrote:
> To support HDMI audio on the rk3588 based devices, the generic HDMI
> Codec framework is used in the dw-hdmi-qp DRM bridge driver.
> 
> The implementation is mainly based on the downstream driver, ported to the
> generic HDMI Codec framework [1] recently merged in the master branch.
> The parameters computation has been kept as is and the data stored in the
> dw_hdmi_qp struct as been cleaned up.
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: rockchip: Add HDMI audio outputs for rk3588 SoC
      commit: b8c6c136971c0e9750eec89f367529b2854d3a3c
[3/3] arm64: dts: rockchip: Enable HDMI audio outputs for Rock 5B
      commit: 97aa62ed1e970bf8aa9f57e87c946a95fa3d5bef

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

