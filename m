Return-Path: <linux-kernel+bounces-326707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D4976C03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608131C22463
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDABD1BA27E;
	Thu, 12 Sep 2024 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="UBSs2qF3"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B21B9840
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151182; cv=none; b=F2pA5LE15WpCFaOaDFpHT9oNJNtVrrgt9Iwq+MXbl1mYKkDQaHfcK9pi+x1r7Aaga/ULlsRWBONqlPIls67MwjeOMq0OR/Ir7cwckSGiY+7Vll6SS+2YCsPbh5o838gXEjtJds9K/Y/4DEeZhIsaTsVpyvp4WnVjzoWH0zMsJcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151182; c=relaxed/simple;
	bh=O52ssyD7ALtqCtZg1swX9DhLAIImi9FBWThsLl7IaxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5d1XXEqZV15Y8iFhOU1d7PxmqqvHziNVJ8jpB4eUK3X+K5eVJ5PAAWb8xP1tiUuZzMPRy0iWtV2Cg2f+P7sEJW1eMuOgvvBGGm+dZmh/ThvVl8k99U3Akhp4cipKwnuLikHbJhBHvUNI1YKqQcT0qieNJH8NOJ6wpqBFVtaBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=UBSs2qF3; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
	by cmsmtp with ESMTPS
	id okRDsJ79xg2lzokm3sjizH; Thu, 12 Sep 2024 14:26:19 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id oklzsMIhur1Juokm1sQdCw; Thu, 12 Sep 2024 14:26:18 +0000
X-Authority-Analysis: v=2.4 cv=VPjbncPX c=1 sm=1 tr=0 ts=66e2fa0a
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=EaEq8P2WXUwA:10 a=-pn6D5nKLtMA:10 a=vU9dKmh3AAAA:8 a=jOwBCQwwsqbqoLW4yoUA:9
 a=j__mt3AifRkrCLMinO4U:22 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RyxZ7dJEpL0KSF3krujUDmOJrfvECrlisXCbyNhBHAg=; b=UBSs2qF33ZqudvUjR87fx1fzSF
	1C57TQe1LSZYs9f1XRLo7AE8TbJbtOzNYKYoMsKP6mE+rEyjHQ2flGy5Sa1qJTXZF4SOY7sItLFSx
	6WFp3f5ZrJM/tjc3lAAyl88NCndlYTQ6k4OPMqXzsZA+eqRAz40YymcjYoHNYkEOXu/TR6tAxT0lH
	pIPV+EEdbQ25H1cyxabxgKaGWfZMG9ibLlnKup2J/Y6cM449w8S3jjJNIWm5QsMo5rLcKVZbVceim
	iVkMPx493It0qWQ7SUBGNS6ehcg7Ea55IWwKbJJYla6gSW1Hv1D0K4aOyS1C2vvRglHS4RG9N8bkZ
	BNLdtNyw==;
Received: from [122.165.245.213] (port=41006 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1sokly-003n4z-0c;
	Thu, 12 Sep 2024 19:56:14 +0530
From: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
Subject: [PATCH v3 2/6] ARM: dts: rockchip: Add watchdog node for RV1126
Date: Thu, 12 Sep 2024 19:54:47 +0530
Message-Id: <20240912142451.2952633-3-karthikeyan@linumiz.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912142451.2952633-1-karthikeyan@linumiz.com>
References: <20240912142451.2952633-1-karthikeyan@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1sokly-003n4z-0c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:41006
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 25
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOvBm97qvLTur2Sx72liBBAK1EK4CEpALI/JaU7TMbnqIYTV/hxFcankR+JFAv3i2GgO0hJM0ukbl7i35wbByQ5OeoBD9o7Ex3ywGivZucujai1WUqyq
 bucCtcGRdGaaGAwb+BSakLWHTtZ14qb30ifb/37PeeGmO27Bb4pLP9Mn6u9gk02hXzG+VFG9V4ix8wCrgQpQh9J8uOCZuaCFx6nxCEY1MiT9CILyd0arcr2B

Add watchdog node for Rockchip RV1126

Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
---

Notes:
    v3:
    - add watchdog compatible string
    
    v2:
    - no change

 arch/arm/boot/dts/rockchip/rv1126.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rv1126.dtsi b/arch/arm/boot/dts/rockchip/rv1126.dtsi
index abf442804d27..22a22bcad04b 100644
--- a/arch/arm/boot/dts/rockchip/rv1126.dtsi
+++ b/arch/arm/boot/dts/rockchip/rv1126.dtsi
@@ -544,6 +544,14 @@ timer0: timer@ff660000 {
 		clock-names = "pclk", "timer";
 	};
 
+	wdt: watchdog@ff680000 {
+		compatible = "rockchip,rv1126-wdt", "snps,dw-wdt";
+		reg = <0xff680000 0x100>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_WDT>;
+		status = "disabled";
+	};
+
 	i2s0: i2s@ff800000 {
 		compatible = "rockchip,rv1126-i2s-tdm";
 		reg = <0xff800000 0x1000>;
-- 
2.39.2


