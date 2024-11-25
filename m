Return-Path: <linux-kernel+bounces-420643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242C99D7F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A60B2565B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669FC187849;
	Mon, 25 Nov 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="U5HN/MgF"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AD18FDAA;
	Mon, 25 Nov 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525209; cv=none; b=QIxm1+fG+YciOMb0nZj/RU4oHSLX3qXg590610IO15i30SSkGeUHjtKlBj7BJzktzFO7ZHzjwoiiwP16EKtDR4kOQ0zr4Scj59KTkGNxVknMKThvrfeihPi80n9jLkRHqMnRfChbzF50vIGY/PYRonwdFUzl2kxMG4OUkWPXPeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525209; c=relaxed/simple;
	bh=cCjwqiypvmHR3YiuotuXhVmxvnHRJGZNNvmMo/P2KuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dO/joAX/3TElKtLebJa4Bn6EbRStrkucqDxECLj4PXyAmUTAtVwfidTYqc0bljbcna/QPiiLLJx6rbc9izahUBghNtc+YG18/Q4+zwLpauarXJc/sySXG+TeeZfpTsV/lb9nyVUKIu02mLEufCImlKsrGketYl648UgrrM5KIII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=U5HN/MgF; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xrEA6K10caIyYSUnQG5tc6sO1syANSVcfUKDl8q12Go=; b=U5HN/MgFwm/1e/fUu/RbSqbrrz
	h8eUDc1CO8l9wVbZzFNCWaNrClDTrRD88UOtpRXaPtbsCqjKFeUwhzYroUfU5hk5yrVZi8UbAKCix
	mJ7RGId+cWK+cNeVD97r8iqAbAFvOwoqBcyW07Px+Tne3FzHjQk7W6ToXusCLjAn8uOsvyLNm7crF
	Kzg4g7MjAMyJb07pXm51xI3xdrYnhWWDSTmYvlPYdSrEU1UHmR+vtkBDaPKuovoBRuXsqVvLvFzzx
	0Ptwfi5n2Mf7j6qt5KpuPuXjwARCJWNOh3cmVHP29JjgtBk7FbRw6QK8KgOx7dOfpDVGmOpXOFhTY
	M8mZGxRw==;
Received: from [91.26.50.162] (port=58340 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tFUIq-00Eq70-2A;
	Mon, 25 Nov 2024 09:18:40 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 06/15] arm64: dts: imx8mm-phyboard-polis: add RTC description
Date: Mon, 25 Nov 2024 09:18:05 +0100
Message-Id: <20241125081814.397352-7-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125081814.397352-1-andrej.picej@norik.com>
References: <20241125081814.397352-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Yannic Moog <y.moog@phytec.de>

Add RTC description.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
index 31d5c57d3c24..6c95257119d6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
@@ -219,6 +219,7 @@ &pcie_phy {
 	status = "okay";
 };
 
+/* RTC */
 &rv3028 {
 	aux-voltage-chargeable = <1>;
 	trickle-resistor-ohms = <3000>;
-- 
2.34.1


