Return-Path: <linux-kernel+bounces-304928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607B9626D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FA91C22606
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E4175D5D;
	Wed, 28 Aug 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pItCQxIL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qMhJG9MN"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AE0166F03;
	Wed, 28 Aug 2024 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847627; cv=none; b=Ayl2cTAlJC4lefLiC3LzJYqX6BlRo6OTTQq914YNHjn4AqNTyPiDiFkUiCX8Zo7bfzALl5RWj5MpEPYOeI7m1QvC/qE8YEmqGg1tl/aPNyhEU/T2ghUN++xxReN2S2m+RcROnlULEFXLGy1VJDQVGJgD5+ylZyqqmJ5+Ox5Mf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847627; c=relaxed/simple;
	bh=HmmEEohqwVh1fUXRO/GiYgvsTjyfON6GZYh7OoQhvrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E4hEZ2Su6M8PjFz5W0eaEcsn8/BxuG92wQk7Sg01acKnOsIyFuVQ1GsdVuRnHXd2WW6miOZP35rgCIWJqRHjgmR3XbiPkdRI3FcZSPM2Vp6aBKJLJF+GYzdAxuIVtPTgwHiOgpu/ljl/hqyucwA8TkAMOvf7HjRhJ8UZmXabx10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pItCQxIL; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qMhJG9MN reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724847627; x=1756383627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=23+7cywI0fUPFWkOLsTwrSRQYi45o9fiJhzknLgCNcg=;
  b=pItCQxIL4Jf53IGgy58VFo35Bq1WtEXgQDz7hBWsw21HVKlU/ulMZIPR
   GoySa2LUVniYR5m7OlEv6jUOxqIW9uJ/ODICl2Y/gfqNpQCzOUPzfgsk3
   MolHXB26PsBOXKXRwiesdCDNdVAKGGURehbp02MJ8HYz5FVcWmpxXYUvl
   dtHssNzdq+cx+Bf582+ynoTek5Ncqk0cqynuh8NsNVfCrL7mpymNTESlF
   TBAT14YawSwvzaXfrHjE2ecyX8+VJtHTX9bVZCLOPFzIpCOCm+UzaX26n
   kdROI15zYdvrLFb2OHyUgcmtyYELrhKXPMVkMLVx6hvJRED+jb6NWZpVc
   w==;
X-CSE-ConnectionGUID: 0encm8wqTLmT8C21cEpXEg==
X-CSE-MsgGUID: 42k1YTMmT7CzzW/PKOl1Dg==
X-IronPort-AV: E=Sophos;i="6.10,182,1719871200"; 
   d="scan'208";a="38635575"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2024 14:20:25 +0200
X-CheckPoint: {66CF1607-2A-AFDE3C8E-D8665302}
X-MAIL-CPID: 9395682CF7F8DDBBAB2FB8DCD6B4C2F1_4
X-Control-Analysis: str=0001.0A782F21.66CF1607.016A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20684167A1C;
	Wed, 28 Aug 2024 14:20:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724847619; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=23+7cywI0fUPFWkOLsTwrSRQYi45o9fiJhzknLgCNcg=;
	b=qMhJG9MNsxKzEp+QiVHj7ZBBwzZ+nmo3b/3PSzVtAJgY7dMkda/D+8cJvEAN7gAPh/tiyo
	dNBd1kgdhP7+Ercxk9jwrL5qUUWqCfEGI7J9SYFFw4JnkbSS4tcZSOOqKdLDBhAZsqbM1D
	vtBejCkU6DkoYKSyXNVvXMAkUy42CUhC71zPB21wm/I9FGczvFk3sWHu3uejTBMDqAVzT7
	BwQXSEVgD6Ywama2BeAI/24Hx0v9uc/6LZh3x9zs1Ec3Po2AwrdnYOvY+7aSoLFKr123u7
	fN/hFsJ/wOegk91vIDCmHEmodOieBZhYCaze/w5H5ptF3fLC4AOjcE/vVnPDDQ==
From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 3/4] ARM: dts: imx6qdl-mba6: improve compatible for LM75 temp sensor
Date: Wed, 28 Aug 2024 14:19:58 +0200
Message-Id: <20240828121959.1268463-4-Markus.Niebel@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828121959.1268463-1-Markus.Niebel@ew.tq-group.com>
References: <20240828121959.1268463-1-Markus.Niebel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Use national,lm75a to specify exact variant used. This should cause
no functional changes.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
index 807f3c95e3ce9..aca320ee8f476 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
@@ -13,7 +13,7 @@ &fec {
 
 &i2c1 {
 	lm75: temperature-sensor@49 {
-		compatible = "national,lm75";
+		compatible = "national,lm75a";
 		reg = <0x49>;
 		vs-supply = <&reg_mba6_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
index 789733a45b959..eacd230b97d5d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
@@ -23,7 +23,7 @@ &i2c1 {
 
 &i2c3 {
 	lm75: temperature-sensor@49 {
-		compatible = "national,lm75";
+		compatible = "national,lm75a";
 		reg = <0x49>;
 		vs-supply = <&reg_mba6_3p3v>;
 	};
-- 
2.34.1


