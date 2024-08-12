Return-Path: <linux-kernel+bounces-283263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D05D94EF4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC47128372C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB194D8D1;
	Mon, 12 Aug 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="HzaYOXiM";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZqgtUIer"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3F917A58F;
	Mon, 12 Aug 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472107; cv=none; b=nSHZE5RwTMw5DKaF5kSbBL/uCPJn4+RKqCqFxlnXNIyRX1gqeFSXX7j7GKBgnIuABmNv68wSwjepV3APErESulWwpJFIoBqF749MvDDnzfxKkllBJsZ7G48Ya7SIBS5IGE33t0iISaBa1f6M7QqIOsEQEv/4kKJ6Zn6gD3BVwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472107; c=relaxed/simple;
	bh=aiwOxb+jMFLutwjYWtVJ9gOuQK5Nbkv+X73JAjvsEFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mz0/St2VNvtFMeCFwk21mTIS4HdE3OZ08SmxAfar9pmEjq38Epg3bzed5dA8klGqnZIeHg9FzuycCnNgA0D2LIK2xES+shA0IQ/xMzp0aYkLCgT9SxWkslTEKfY1h8Z76uthLsUtnwT4xeAEVi9sACTNosrav8i0xOJLWUvYLjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=HzaYOXiM; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZqgtUIer reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723472104; x=1755008104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0K7G5V6cVtbaVOEr1S0dT+iNm4AyqSegwDNOMiPThE=;
  b=HzaYOXiMRAojt3yJltvFYRatyPm1YiEcLI17vKn6RDzJuycrV+HMi3op
   0ZhDOupjRsX10TjJqOcHOCuzLvsmm2UW4gA8T89iSRiBr88mp0o1+HISC
   k+dZ8eLw5cFrANdCOrYTXGml5y6m2YHwhmm73x9kJ3ah9J0GZDiJQSNJ7
   qhi0vS/MGdLsly/SkRvudfqrIB9ivMVdEJx8DvxDR6xA902tQe8BeIJ4B
   pu9dgc2J/RHMbNggqHP8yOLLFKJ4wNhgdOQlzPNPP+AD4y66x3zYED+OC
   uBwEfRCG6VQ4LBkAhZSB26/W/WtXErSGE9bAlxAlMovRfSI1sUWu/RK6k
   g==;
X-CSE-ConnectionGUID: 1fq4UM4mRsO0CPXQC48Srw==
X-CSE-MsgGUID: 5enCqQ93R8m1fKyPWt5k2A==
X-IronPort-AV: E=Sophos;i="6.09,283,1716242400"; 
   d="scan'208";a="38365469"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2024 16:15:02 +0200
X-CheckPoint: {66BA18E6-D-82DA89EF-D38C983A}
X-MAIL-CPID: B0CE9BA12C694F5CB299E5AB16835DDC_5
X-Control-Analysis: str=0001.0A782F19.66BA18E6.00CA,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF322161354;
	Mon, 12 Aug 2024 16:14:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723472098; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=j0K7G5V6cVtbaVOEr1S0dT+iNm4AyqSegwDNOMiPThE=;
	b=ZqgtUIerE7Xv8LTCWFybDZ/QhxhvD6j+Mhglrl0wKtayfCjSDmDmwKvTAFpGaZ6JPei1xK
	F8V/mER/ZWV+BGDmbHxZe6H1biO0d3GucWICeFlBtz0T31Y9tLAIvpF654W20+Rc5E9SXw
	D37pxUw7lTiGwBbEqvz19UNEvvqhjPmIicn6PLC6GtIntkXrQFgzpB22ExSeZXw41CS9+p
	Tfjk+/7sqCcLkdBJOJA2RAVmLz0aZylFBPIEt5MxkhZeQSSepotcG3bBhOqtvdpgeLjnvB
	Pw2sJkXBRTaEzCh7n7pncrHEZJU0ggpBpc3ueSN/joJU7hIGcgnUia/5oOn1Rg==
From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 2/2] arm: dts: imx7-mba7: improve compatible for LM75 temp sensor
Date: Mon, 12 Aug 2024 16:14:14 +0200
Message-Id: <20240812141414.96334-3-Markus.Niebel@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812141414.96334-1-Markus.Niebel@ew.tq-group.com>
References: <20240812141414.96334-1-Markus.Niebel@ew.tq-group.com>
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
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
index 775bd3066b87..e1c401f468e1 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
@@ -316,7 +316,7 @@ &flexcan2 {
 
 &i2c1 {
 	lm75: temperature-sensor@49 {
-		compatible = "national,lm75";
+		compatible = "national,lm75a";
 		reg = <0x49>;
 		vs-supply = <&reg_vcc_3v3>;
 	};
-- 
2.34.1


