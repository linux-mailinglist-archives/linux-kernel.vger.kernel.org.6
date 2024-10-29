Return-Path: <linux-kernel+bounces-386696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 731439B4713
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09A0B22B19
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAEF205AB2;
	Tue, 29 Oct 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="B6QRk4dd"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3112204953;
	Tue, 29 Oct 2024 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198397; cv=none; b=I4kQUwTAoCjI3OEPfrYkthGwVmJvz/dSSxf6FaulSYLlhGpAWEN7mXiAjwixpzqfmtF9v+jB2FvFcxMofPvqN95vqeLHTvl+wE12S7uKWfQt0d4TiKwyYcfvyghFn8k4ZlMTPSfkdn99GCua36DANDQFiufaALUEiH3BxgPXrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198397; c=relaxed/simple;
	bh=Yrdbgcr1AAB40HD8bt1tMrf8RZtm6twOby5iTI4zshM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlA7MFC3cObhAWRI/BnVp6ILht+hiAUMi0U71/LrYQS0whcBYeQZQYzQANw6DZbQaJiSOqSIzRttSUjucItQhi0lh0rvXyZRTt9FnR58ozf98JvlYBqwtQM6LbVzppVYm0WSitssWO4nU54PiWB0//GPZKjT7jUOM7MFjVpXQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=B6QRk4dd; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout1.routing.net (Postfix) with ESMTP id 002E84052B;
	Tue, 29 Oct 2024 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBdI6EjJp8UowrmiaGoi2Fq0w1WX7yePH0/G5CJ86tg=;
	b=B6QRk4ddbj0ZZC/LxU5uFAqI8NGYdIVNDvDOSHpmeveadWs3FRdR3qg+kbeRhMb9kvZ04I
	/mxqhWvHivzZmgCZR5qRiMZoA2zq8B2uEdyGgLHC1D3VO0+nwnZrmlpdArbsdHn/isNvDJ
	R2rQ48EApPPYlIWnyS+mXv7w0ceO8mA=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 64F813600D8;
	Tue, 29 Oct 2024 10:39:49 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC v1 11/14] arm64: dts: mediatek: mt7988: add thermal-zone
Date: Tue, 29 Oct 2024 11:39:30 +0100
Message-ID: <20241029103937.45852-12-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029103937.45852-1-linux@fw-web.de>
References: <20241029103937.45852-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: a237a3f0-1cac-4e47-a90d-bc7df7aaec54

From: Frank Wunderlich <frank-w@public-files.de>

Add basic thermal-zone node.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index de9a9ff2edd8..a3a7deda35a5 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -379,6 +379,45 @@ clock-controller@15031000 {
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+			thermal-sensors = <&lvts 0>;
+			trips {
+				cpu_trip_crit: crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+
+				cpu_trip_hot: hot {
+					temperature = <120000>;
+					hysteresis = <2000>;
+					type = "hot";
+				};
+
+				cpu_trip_active_high: active-high {
+					temperature = <115000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_trip_active_med: active-med {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_trip_active_low: active-low {
+					temperature = <40000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
2.43.0


