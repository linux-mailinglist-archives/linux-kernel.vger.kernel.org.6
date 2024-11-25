Return-Path: <linux-kernel+bounces-420644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65FC9D7F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2736FB25881
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5CB18FDD5;
	Mon, 25 Nov 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="ciktTgDM"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F118F2EF;
	Mon, 25 Nov 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525213; cv=none; b=MmKFIlq//9FOHgkMJMr1oKkG8VDAeN8ndZDdJl9P8xERu9xKAc2fDyP3/QLxjODH7KLHNG+odg5QSByV6/+YPnZVvq8eymy2wILn7PrKgp01VTeZmiofNnS83LH3eyoinFUFM+OicZIxXWzSZsHVBvg+9/7fuObE/7JvH3HchtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525213; c=relaxed/simple;
	bh=P0VxazLqNTE4yoG5sYRoWSvw0IVV4rpPxlq/5ASEH5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7F3vGcxYVY0Sx+rw8E+zI1h631ytVbfp02E+hAFAaix6xqpiZDHQYtQNXUVp6wbMhy5ssY2vs7YIo2Ler2ocjaCZOpEIZFtWKnIkudBhYu26uAR3yOEakOXzTOyR4BPcRGvM4E6Tv7mtdk1gQ12TNqXsmvKu1gT/O6561E0TkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=ciktTgDM; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1dzaABlyBSIv+A59mAzCEfDd1bQYz8WOCUm8CNI+AfI=; b=ciktTgDMdjuTVssUTG6WLN6R3O
	OZwgB8JLgyyH0NteENs/nYm8+JCKQMvMQJ0aRTU78WHCjjOKlP4YJyMjsNKozaE49xtp6/pVrBTjH
	9PAWMhOiIdePVKuBwkvX6bkAK0lkc95mzZ1MbM2X6UQ4PjEZGtCaxxRKZDUeMQmcNUvNMTiiQjy+r
	K8uEBNpCrDYbVH6bbFq0Lb1WvurdBx70XMOnqsmQDSPfyQjIoYSDZ5QG9ZsUW2Gimt9Cb0c3OM2LE
	X67OyF4RlcQ58EQw/z19ucV++7U74/CfVXLH8Sl6kfM/C+4OF/CRD4aiqcsc6srNe56TGmyaDjoiI
	iQUxNBRA==;
Received: from [91.26.50.162] (port=58340 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tFUIr-00Eq70-1G;
	Mon, 25 Nov 2024 09:18:41 +0100
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
Subject: [PATCH 07/15] arm64: dts: imx8mm-phyboard-polis: Set RTC as wakeup-source
Date: Mon, 25 Nov 2024 09:18:06 +0100
Message-Id: <20241125081814.397352-8-andrej.picej@norik.com>
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

RV-3028 RTC can be used to wakeup the system on phyBOARD-Polis-i.MX8MM,
mark the device as wakeup source.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
index 6c95257119d6..7aaf705c7e47 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phyboard-polis-rdk.dts
@@ -223,6 +223,7 @@ &pcie_phy {
 &rv3028 {
 	aux-voltage-chargeable = <1>;
 	trickle-resistor-ohms = <3000>;
+	wakeup-source;
 };
 
 &snvs_pwrkey {
-- 
2.34.1


