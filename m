Return-Path: <linux-kernel+bounces-538927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD52A49EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2E31648E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6428F281341;
	Fri, 28 Feb 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="IBm7uNcl"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BC6280A39;
	Fri, 28 Feb 2025 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760346; cv=none; b=MTsMWX9p2oXweRZSzfFHGeARREeikleCAJF8LldH0F1WgBewAaPp4+EdQGBPQpYeiHIBZqMkeBFFiHsehB2vnavJOK/zaiISXHyn8N5vZdUKyN8N7uyajipdfO23MxeJN3qsRlh8rqiN9pcJxOelHxCWYJPxcWvrbi1gsvrky2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760346; c=relaxed/simple;
	bh=/WgDmotLNZWIT1LRFDaE6/uBsWpuLYmYcKgtd73b4uI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvNG5FE5usA/cXaVTREsmLsl9YJNhZ4XwnYrcBPLEs5UO/SJx0md0TsaSWgu54EcYFW+8wQJTsh2HmRzgbN5Pb4r7ogyPjw4I0/lPb6JBKP+qIlzw0HZoc60NpqzrhpG19N7IcEJHuHv4XRWPA/jN0LWPgOkRAGET5dj+gz6cvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=IBm7uNcl; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 31D0A259C1;
	Fri, 28 Feb 2025 17:32:21 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxMkCbQGKZyu; Fri, 28 Feb 2025 17:32:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1740760332; bh=/WgDmotLNZWIT1LRFDaE6/uBsWpuLYmYcKgtd73b4uI=;
	h=From:To:Cc:Subject:Date;
	b=IBm7uNclD2xtpKvBdOplyoTU9RL0cMbmVskEFxJGSOCFtvK6otlZgJuZUwVpEoaAp
	 j7izJ3JIbkYIn2eUtLkDQMvNvh7mWN0MjaWUuCELvebtuAy+ovKfXNhe+Ej1bpU24H
	 XATQPTSAGUDl5XiPhE/gbOyw83f7hbaEaM9Oq6IMz8nDZWLHBoJhRscuk8YqQ1TYUs
	 1b+VRPLy8dmjUfBbM5XJnUCo7z6wg2MDm+lmj6Gm/Zqw2vE7qj1E/V0AqoZ7IY0wdO
	 +AByPb2FXABEpPAdXfSwAFLSbt3jJl0vhKa/qdstvCQmCX/UN1ijVNKU7AO1PSyVcE
	 St1cZuVAqhu3g==
From: Yao Zi <ziyao@disroot.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Johan Jonker <jbx6244@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Wenhao Cui <lasstp5011@gmail.com>,
	Yuteng Zhong <zonyitoo@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] arm64: dts: rockchip: Remove undocumented sdmmc property from lubancat-1
Date: Fri, 28 Feb 2025 16:31:18 +0000
Message-ID: <20250228163117.47318-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Property "supports-cd" isn't documented anywhere and is unnecessary for
mainline driver to function. It seems a property used by downstream
kernel was brought into mainline.

This should be reported by dtbs_check, but mmc-controller-common.yaml
defaults additionalProperties to true thus allows it. Remove the
property to clean the devicetree up and avoid possible confusion.

Fixes: 8d94da58de53 ("arm64: dts: rockchip: Add EmbedFire LubanCat 1")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
index 61dd71c259aa..ddf84c2a19cf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
@@ -512,7 +512,6 @@ &sdhci {
 
 &sdmmc0 {
 	max-frequency = <150000000>;
-	supports-sd;
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
-- 
2.48.1


