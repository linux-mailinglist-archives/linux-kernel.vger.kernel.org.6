Return-Path: <linux-kernel+bounces-536050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200FEA47AED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50313B01E7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D3922B5B8;
	Thu, 27 Feb 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="HUfv/1kr"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CEE22A7FE;
	Thu, 27 Feb 2025 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653779; cv=none; b=CefmEAD3HaxxFFEWnfDLtzzrYT15MNOQbpT8uvgUJrI3x2Jtc7XYv4hohoJAp5wbWRor3iZuref1pMINHfopox+waAU5Jy+K1VmhjRcXOY+2PeyIXdKAZ5rl/vp6Rx8goLRbGhl+2BZXSYfTNbMNp9MPfyZRX5wKqiZ9XM1Tmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653779; c=relaxed/simple;
	bh=Xg/cpLBrcpLSuwdr1Ma9m8NyWsXH9NX2/lvTtG7LWjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxqASyv/DMOuEr8aH86l1ZcBejcCdyCRLOVSvFwjB/kshISvsJn2qrbCM6HcwxEPDqqNn6t2QbjuKcwnPtX24ILSg/hUUGXqatQE6tp4gbA8LbingRGxoDx+ODLMQSKXfn2ibrsk/g+v1MTDzpt/EYD9U/bsWhWSAFUvx2dif1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=HUfv/1kr; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PiGv4eKvzFP8GKMacfTTM7wI8HoQk+tFnB/wXXe8oC8=; b=HUfv/1krv0CyQhz1z4QDZFRZsv
	Ew44NpgikJfUrQxB7Vc9O1guk+n0kGcoRVa3acgN5p4v7hrCMY4/+ExEqYKbjsInQnS2MEgy9SbDN
	vvtcJZ/t9l9TeDcTFOdoMLxj+G4kfePEb4mjrm5yjzhTCPGVo3aqHLqj05FzGtZZKxITpaA+RcdzU
	Ja7FlvKQV5aYI1OgyS9nYWgYNp3ligoqMqnKyX0VtRehMtrO5VBaMxJUEcIquKyDIy1qs5ndZRvsA
	Itcz9Rl9q0cJAwZ5CIQU7c0F+8DFBBZq3VDzB+cksbXm3HPO4WTxQfWzvKW5Nql2qg2UzdCwHOLhr
	+ckAx6zQ==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tnbY9-00008f-Av; Thu, 27 Feb 2025 11:55:29 +0100
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
Date: Thu, 27 Feb 2025 11:55:16 +0100
Message-ID: <174065370894.4124124.10616312809882779303.b4-ty@sntech.de>
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

[1/3] drm/bridge: synopsys: Add audio support for dw-hdmi-qp
      commit: fd0141d1a8a2a26675ee88df75615c05a55044de

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

