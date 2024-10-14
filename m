Return-Path: <linux-kernel+bounces-363921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C594E99C877
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709371F212E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596411ADFFC;
	Mon, 14 Oct 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LXkDole1"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478CF1ADFFD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904296; cv=none; b=QKIbdwTekuNTzo8/oe52gFmsx/v0tgLEa/Q9yP2NdC+0hU1laX7ldKcpfUA2gPbLoJxmXSjaFqiN1Z//DOM/Mt2/KcL6nPAqzT4nLnkJsFWUTZI2fGcIDh3RrBVYsV0xQW/g1Hrr1317Auefy81pebk6+9Z4Q5en0IBp+Z4DK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904296; c=relaxed/simple;
	bh=lbSULqzCxOMTsZjzot+Kz2cQLUU1orZtADKrs/VGFBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1bZVdkdG4CaIYUJKxskeA4nWMvoMaM7bQXvAMEJQ4ud6bRZlD/PUXxx4ojN9/6m6gb5l5xd/t+act5251BmKR1BUwIWs2bnCMWb4NDwGLwSWeKD2uoYKGEWdTlIsgRy/rsuPoL6O2tQtbOTD/cw7OUZSQIHKd0TxouyRZzH9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LXkDole1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca96a155cso21869415ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728904294; x=1729509094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM+fK9ga/ZCw4199bv1V/rTffcVs0A/cmY5CAFr87Ps=;
        b=LXkDole1uDTPnYyyZKtnSD0xWmpZ+0pJepZHOXib2JRhsjHaCzTDkejx7jAASPi23i
         sPoKz5uDO09rm4jtSvfTHYV1DMv/9nVq+MkF7W8vD0RoXwVX6QC+TwJ5tioDuElPc+/2
         vcSMJZrFlv+euR8iuhaYwBSeVNHty08srYf6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728904294; x=1729509094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qM+fK9ga/ZCw4199bv1V/rTffcVs0A/cmY5CAFr87Ps=;
        b=Cd+6Cf6AZmuPnbW/33uazLS1Cr+oQieFKiVw4ImgcBAGcAcxpl1rORso8h+OBMwZYn
         gVgspwznBQxaAVwokkvHyiQk6kRT/o8uuWEtWOhWDMc5Anq80cXvCnThXveipHCqnyjW
         Y/eee5F7HONzPhg2Z7/aCfee/aOl0/mMIEcUEu+XAZE+GvWa+oSvhWCkUubAPhTvK4q2
         BKvYgFI+Wj0ZUDJ99speqYqGo1dYaDoeWke+dmG1a/WThi9+gRRxzYvzWqDpWUICQ2rO
         sqG+1PVAvoaDCnanwtj2Q073QOuQuOC3MZFP3jz5nfU8OZVeFSNQxrgpAIio2DavF0sd
         Qzmg==
X-Forwarded-Encrypted: i=1; AJvYcCUpq9PQVP/LgKjRBEXsWEQImaphKWUOP7LCSnnUMFrJ33dePGwfQ15F/x2kkjpvPmTF3Ger9ClU7s+BtBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FmEdTM3lOuuRHXFU/kPA508zCjgw5ksDbSpDaTlOXMy1hnMm
	8Loj90OZk1ji6H4/SSPZiebTvw5hN2V8gkbC/ls/wxD1N988zp9Pi9d+V0ZjJw==
X-Google-Smtp-Source: AGHT+IEeEisqcQCdXNiVjcOQ+BHrMtM1QdZ/7Za8z2Evnw/ptJzlad0MSeVia4oonsqJp6idxrY6sw==
X-Received: by 2002:a17:902:e5ca:b0:20c:8839:c515 with SMTP id d9443c01a7336-20ca16c5a89mr173798755ad.56.1728904294697;
        Mon, 14 Oct 2024 04:11:34 -0700 (PDT)
Received: from fshao-p620.tpe.corp.google.com ([2401:fa00:1:10:4907:d52a:1a1a:58d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc3e6fcsm63858285ad.118.2024.10.14.04.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:11:34 -0700 (PDT)
From: Fei Shao <fshao@chromium.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Fei Shao <fshao@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 8/9] arm64: dts: mediatek: mt8188: Add DP-INTF nodes
Date: Mon, 14 Oct 2024 19:09:30 +0800
Message-ID: <20241014111053.2294519-9-fshao@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241014111053.2294519-1-fshao@chromium.org>
References: <20241014111053.2294519-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the primary and secondary dp-intf nodes.
These DP-INTF hardware IPs are the sink of the vdosys0 and vdosys1
display pipelines for the internal and external displays, respectively.

Individual board device tree should enable the nodes and connect input
and output ports as needed.

Signed-off-by: Fei Shao <fshao@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 3345a2adc0fe..6f5727f05255 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -24,6 +24,8 @@ / {
 	#size-cells = <2>;
 
 	aliases {
+		dp-intf0 = &dp_intf0;
+		dp-intf1 = &dp_intf1;
 		ethdr0 = &ethdr0;
 		gce0 = &gce0;
 		gce1 = &gce1;
@@ -2475,6 +2477,18 @@ disp_dsi1: dsi@1c012000 {
 			status = "disabled";
 		};
 
+		dp_intf0: dp-intf@1c015000 {
+			compatible = "mediatek,mt8188-dp-intf";
+			reg = <0 0x1c015000 0 0x1000>;
+			clocks = <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
+				 <&vdosys0 CLK_VDO0_DP_INTF0>,
+				 <&apmixedsys CLK_APMIXED_TVDPLL1>;
+			clock-names = "pixel", "engine", "pll";
+			interrupts = <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS0>;
+			status = "disabled";
+		};
+
 		mutex0: mutex@1c016000 {
 			compatible = "mediatek,mt8188-disp-mutex";
 			reg = <0 0x1c016000 0 0x1000>;
@@ -2740,6 +2754,18 @@ merge5: merge@1c110000 {
 			mediatek,merge-fifo-en;
 		};
 
+		dp_intf1: dp-intf@1c113000 {
+			compatible = "mediatek,mt8188-dp-intf";
+			reg = <0 0x1c113000 0 0x1000>;
+			clocks = <&vdosys1 CLK_VDO1_DPINTF>,
+				 <&vdosys1 CLK_VDO1_DP_INTF0_MMCK>,
+				 <&apmixedsys CLK_APMIXED_TVDPLL2>;
+			clock-names = "pixel", "engine", "pll";
+			interrupts = <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH 0>;
+			power-domains = <&spm MT8188_POWER_DOMAIN_VDOSYS1>;
+			status = "disabled";
+		};
+
 		ethdr0: ethdr@1c114000 {
 			compatible = "mediatek,mt8188-disp-ethdr", "mediatek,mt8195-disp-ethdr";
 			reg = <0 0x1c114000 0 0x1000>,
-- 
2.47.0.rc1.288.g06298d1525-goog


