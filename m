Return-Path: <linux-kernel+bounces-372083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC329A4449
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18F91C21321
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE26204024;
	Fri, 18 Oct 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="JwTr74eo"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401E620401D;
	Fri, 18 Oct 2024 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271092; cv=none; b=n3WLkXEpyLRCKj9IfDzivuCkfPFt80ZCqSNrjaLrcCd0JY8l+lmtB8/oEJo9oM7J6rBS60kBcwkSVJixLJQIwb8G9JrqJFxZfpd5oUAaAOt5u0XXjWP6Ie11fAUh7ghb8byi9gQH+wvSZ71Xic+VSZAvdO/EVwUO169C4o1K2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271092; c=relaxed/simple;
	bh=B0SeB2WwJg1BvYACs7VVokjkEK0F2eaP6kf4rIzHMlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dXk3+A7Jl0f9ckGx+tUKGcnNU0G7A+luO9ikek6clisZbLY7rvd1d3LGCWGRN66AGSQ9rQD1RktvwelCfaTRU9Djm6bpJyIcxGEvOc42sDO3S06HcP3tfcQaeN6aqG22AsBzitMttJil/dTvPFCy0Nx2wIAOhXi/MGrvyX30HzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=JwTr74eo; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8D6791F9EC;
	Fri, 18 Oct 2024 19:04:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729271084;
	bh=LOAXiktB9mBtm2Cx2CnD9l3kZcxCgDju+5Ff3Rj2FTA=; h=From:To:Subject;
	b=JwTr74eoVLP3UBtMrhgff7sACp3nAUL0GCg1Gvxs5yHvgbNLyVPv5bkvPX105KPxH
	 gilw668kZqIGaa8aGi0vsW7xOeZmf2g8e306gJ2A1lq275o106kf4MrqUbnP+ggK7B
	 jfqcbmFxjm/NdEK6TBLld3vwc2xW0Hg+vXV3YC41FPQa0QBwsZvX30PHzkAtMmquAl
	 PtEVF7ezP5y9V5N8K6EMGwDPUUNem1hIHtyt2HuCmmhVCBgtm+NuXgXzS4WSpDE7m/
	 DoD5JdDwuhRnzfnQ0tGS+PfNjh5HVuQK9ZhA/e/xTnYhGUAmFrjkFDgWT+59jKuAx/
	 djfw7B1ew9M3Q==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: ti: k3-am625-verdin: add TPM device
Date: Fri, 18 Oct 2024 19:04:36 +0200
Message-Id: <20241018170436.80010-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add on-SOM TPM device to the device tree file.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 5bef31b8577b..b67962564670 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1131,6 +1131,11 @@ port@1 {
 		};
 	};
 
+	tpm@2e {
+		compatible = "st,st33ktpm2xi2c", "tcg,tpm-tis-i2c";
+		reg = <0x2e>;
+	};
+
 	pmic@30 {
 		compatible = "ti,tps65219";
 		reg = <0x30>;
-- 
2.39.5


