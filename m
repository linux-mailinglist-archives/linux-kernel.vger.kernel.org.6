Return-Path: <linux-kernel+bounces-247753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7936792D41B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F0D1F23594
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABC3193465;
	Wed, 10 Jul 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc2vKPOV"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093B19046A;
	Wed, 10 Jul 2024 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621247; cv=none; b=gVKVForuy+LzoCyi2PSEssdBppgCrzZKRn9k2YLjBMZ0bgDI+9caDFGMhhyAPrEDUbcq1bU0EMKJXLLzjyqt9VLVUwYvsMRRDBU784VNWRMfq1NbiPW/+8mQm7bAXuIIMhsmC8Tlf5c2xlA4gWB7E1ertfkpdPILOHfOyWWIgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621247; c=relaxed/simple;
	bh=Wxj3LLHdzlQq61Si3dGO0DLu4a1QqSIXcjs73vXnrXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdGinSBsecd7aYue88+rNhrJThuaZVzVq4So06spy9YJ+UZhE5IF09Yd3drlqNoVi8qP3+2B/qpK5y7utEwOs328OIfzmPFjB+8iQfIJ44dlI5xYVP3uWmkedwW6bQhPIUr021T8wTW/KVIzLt+UMhchYSRAG6uUSx+/7HQbP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fc2vKPOV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b31272a04so610663b3a.1;
        Wed, 10 Jul 2024 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720621245; x=1721226045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yq8qmUxe7OsJ3HiUvrOPY7PKG0OHbBgQEkBnBrk1gZs=;
        b=Fc2vKPOVd7GFV5vlQuLKqRFTSCyn9B28i0pgKoTNus8QhPOg/7nYbylhqDI0Ux/Agg
         vAcowqgPiwKUpUFi1GGM4vITE7/kXcJiW/i0efcgzHRoNMp1gHHQ99uk1+9LqCv+mXcX
         DMVwzs2ctJrMsFF9YTyHg28GVZu1RGWVWkfzWs0fD4aNzXFyKMD9JJq42vxksQfeXnKG
         38Ajkb9Rnn4sv6MY06XcRTAEw72zgDRptI3RKeXsxOafqdFbuvYRpgaGOwY2o/1GKKKX
         HJ4o56beQiPWYocCPJ3aulzStvdy3cZ0SgGpna4SaB+ldDFi0BCmlYAZu+YRd2HlSewC
         yH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720621245; x=1721226045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yq8qmUxe7OsJ3HiUvrOPY7PKG0OHbBgQEkBnBrk1gZs=;
        b=VVqoYq1dr+TfMgue0mcpQHiS6MSYb7A2iieUvswc4W4IG7hkrBEhD8psabTI29KSWZ
         bC4AL/SMg9kl5yH6ioTARpJWL39xDsD+opDkLek5h12EVcBPfnoemcCeYJc6flxaQEu3
         fvuiLQYotq7fPK8ytFC7aope9Vr4a928znSr1NZYL237eV4qZDmgWvfETqpj0zvq29GN
         BHBefQeEIHLBBG9STBotqGl5ia1+I3REAypwk1qU+SW20StnyChpmSadzgkWgPlNcPwS
         lsvlTtrgOJGRWmqTWsnNnIHOnhmK50R+/pvIuaiK4od3mlTxGhiZn0m4OHMFj9ez2THM
         ByjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnu3W1a2b5RdGfDb5pqCZHu8RznleWp1Gdk5qDriE25Unhurpwa3YzXN+QyxmLC40ASsdx1GMj4bSKUMr4ho3FC3kWx1+mPq/wouJe0uQuIEoxRuB9kGMsNNOCcMZ4njS2Iv7/uAjwiQ==
X-Gm-Message-State: AOJu0Yxi82/9uHnmhoZjO8OyyXocFdSh84uhFzlp9xcYx3jE8WL4ciwM
	ZlB9WaZ/jet+KkR4q/yw8BhZvTZw6FL1ydqbCzXMj1vxGlFxRurdoEUHpg==
X-Google-Smtp-Source: AGHT+IEdyu26qqjrFh1xLle8XNfPPT+H9pNpc9dz7TvWDJQ33IbIaIpaJZR2a7bDRg86cri1br4WUQ==
X-Received: by 2002:a05:6a20:9145:b0:1c2:8c0c:e60e with SMTP id adf61e73a8af0-1c298c46605mr8533514637.15.1720621244910;
        Wed, 10 Jul 2024 07:20:44 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4398002bsm3943440b3a.148.2024.07.10.07.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:20:44 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
Date: Wed, 10 Jul 2024 19:49:56 +0530
Message-ID: <20240710142001.7234-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
signals. Rename node from 'pcie3' to 'pcie30x4' to align with schematic
nomenclature.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../boot/dts/rockchip/rk3588-rock-5b.dts      | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 2e7512676b7e..a9b55b7996cf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -301,7 +301,7 @@ &pcie30phy {
 
 &pcie3x4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_rst>;
+	pinctrl-0 = <&pcie30x4_perstn_m1 &pcie30x4_clkreqn_m1 &pcie30x4_waken_m1>;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
@@ -340,14 +340,22 @@ pcie2_2_rst: pcie2-2-rst {
 		};
 	};
 
-	pcie3 {
-		pcie3_rst: pcie3-rst {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
+	pcie30x4 {
 		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
 			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		pcie30x4_clkreqn_m1: pcie30x4-clkreqn-m1 {
+			rockchip,pins = <4 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		pcie30x4_waken_m1: pcie30x4-waken-m1 {
+			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		pcie30x4_perstn_m1: pcie30x4-perstn-m1 {
+			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
 	};
 
 	usb {

base-commit: 34afb82a3c67f869267a26f593b6f8fc6bf35905
-- 
2.44.0


