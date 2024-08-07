Return-Path: <linux-kernel+bounces-278074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948094AA8A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3DA1F216AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D68248C;
	Wed,  7 Aug 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="OhRQgjLi"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E64181720;
	Wed,  7 Aug 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041854; cv=none; b=CfCNyCbTBLxSmhxtdt8lSOQqj04p+fvqSTnj44VoeNvz13TSvk5qsr71LRVv/D+JUqvpldJq3BBDnjSd8HG8l/ddURiUdQy5r2N+n1Oj8jpcdzZf0gkggi2YA1UaBpPdSNflkx24jk6GL/OV63yZqMGPo2v3GtdmLz4ex0red28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041854; c=relaxed/simple;
	bh=wmIyn56BZpdpmjgY4kNRO+10jMJjnSkzPVP/MHdF038=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DcN2Eb3JmYXqL6ZcuCZ8WAMOB2uyWJ9gSlzM7MD6ejboOHPpxM/aRfWIGtDNsiNCU+ZkuWrF3n2NrrEKfi12gP4omEukyxAwk3coXjG2VXOfjXnrZerFUS8y9HuZgYU5S6nw76nehHVm7hEtIpnPBTgRgqAeoHESIEOFIh8OoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=OhRQgjLi; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1F1C121B1A;
	Wed,  7 Aug 2024 16:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723041844;
	bh=QXpRHSt5W22TldwCVm/7sHpUgKzH5tFrdkovYAxdjkw=; h=From:To:Subject;
	b=OhRQgjLiRlK4TQ+9BDkIUYBD6CvZl9P/dCqvJ8oW/MIvpFXFSpbCfqflKBr/gTgMG
	 tbPWmJAoXA+c8DAbBZm6mhcl9jEuDRwURUO9/TrXbARBeS+h4zwnFVuXTNLXHBD+Kz
	 GJU80q/LXqocLv4QdMcsxn77nkGjaGZgQhULvbOfA+5R8LaSEsptujy6qZ9SjSSTHg
	 +De+jqMBfOMlgdMmJ22M6yWdqYRH+3ZZRf03hvfetljmHX/VgxoHXQdsHxxTgB9Ro4
	 3KVoul7zckPwn8LEyQBO5A4CxtAR8Iis+/x/BZ5qe/P8eReEL6oXzwmlEGZgYzydo/
	 YeIuIEX6zNjDw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] arm64: dts: imx8-ss-conn: add PPS channel to the FEC nodes
Date: Wed,  7 Aug 2024 16:43:49 +0200
Message-Id: <20240807144349.297342-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240807144349.297342-1-francesco@dolcini.it>
References: <20240807144349.297342-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

On i.MX8 the FEC PPS channel is routed to the instance 1, not to the
default 0.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index a4a10ce03bfe..a9fd47041e3a 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -121,6 +121,7 @@ fec1: ethernet@5b040000 {
 		assigned-clock-rates = <250000000>, <125000000>;
 		fsl,num-tx-queues = <3>;
 		fsl,num-rx-queues = <3>;
+		fsl,pps-channel = <1>;
 		power-domains = <&pd IMX_SC_R_ENET_0>;
 		status = "disabled";
 	};
@@ -141,6 +142,7 @@ fec2: ethernet@5b050000 {
 		assigned-clock-rates = <250000000>, <125000000>;
 		fsl,num-tx-queues = <3>;
 		fsl,num-rx-queues = <3>;
+		fsl,pps-channel = <1>;
 		power-domains = <&pd IMX_SC_R_ENET_1>;
 		status = "disabled";
 	};
-- 
2.39.2


