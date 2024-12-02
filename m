Return-Path: <linux-kernel+bounces-427004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38059DFB1D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99204281E70
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75B1F942D;
	Mon,  2 Dec 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="gX+AGEL1"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235AE1F9F51;
	Mon,  2 Dec 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124088; cv=none; b=nfxxV6IE2wUzWQOak+lEETknAaw1B5VIBuZQbX1IxV68mPYLBcr99ZCMkXoT1pFxKp3REJfRMCcxiP3KTjGRY/2GZq0SVECGD9shlCTHwl5X9cTmueNx2e4fMBzWhgDhU0sxSiOWPbnn0lI8RQLiAVrP6PaWLlBD6ypWPjjVEQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124088; c=relaxed/simple;
	bh=zZCwx6aDmhtHSZSz1Vf5W6tgemySIOCZXRdtxUNNrnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSXbfg2/s5Uj5WdWF1PQLOn1pPxUJeM4CFPHSYxESeDCBk/L+ReUfKF1Rz8CrY3dNPaU7CMIJ8aN3o8w+gxnO3mhJGhpxxz9+s2e268tH+Y38jHuJ6Yc+uXI/dAx+hTW67Y/qysx4HgD+5OlKLnHhRJbHB1EgTdCIk4YL/l8Pc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=gX+AGEL1; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=eVTYhFJhI8k30xZQ5d5YzkrSCRBC1puvog4ZcnQaM/Y=; b=gX+AGEL15RVunKduj+xVrx79K6
	lpyDiQGCAvVwfzjdK0uDj2UBKMgSYk+0OBXXa6NIziXEqI/1Yp1hG8Nl20qmfNZXRw1DrIzVVXI4r
	YUiWNbyY/ZdsAsxzUi8RsAvkXeZofoctqBD+6k87s/8MCshbPXBHroQBBLF6Fn9tRhnzT8Y3xgOjk
	cz/RifaYIJzvvANjRNek2bJA9Z0JyIRwvoH9wQsWNPZLua9f4LbVP//D+iC7lYrzmXXBnY9zSr0NQ
	urpBh1QzC/IBych7ZydUdFZa1YHi1h2Qmtze2a8OI1jRX9rbl0Gzzilm8flbBVh42RtWdieuDhJVT
	by4QDV9A==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0kF-007Bva-1q;
	Mon, 02 Dec 2024 08:21:23 +0100
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
Subject: [PATCH v2 08/15] arm64: dts: imx8mm-phygate-tauri-l: Set RTC as wakeup-source
Date: Mon,  2 Dec 2024 08:20:45 +0100
Message-Id: <20241202072052.2195283-9-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202072052.2195283-1-andrej.picej@norik.com>
References: <20241202072052.2195283-1-andrej.picej@norik.com>
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

RV-3028 RTC can be used to wakeup the system on phyGATE-Tauri-L-i.MX8MM,
mark the device as wakeup source.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
---
Changes in v2:
 - added Teresa's Reviewed-by tag.
---
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
index c3835b2d860a..c9bf4ac254bb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts
@@ -217,6 +217,7 @@ &pwm4 {
 &rv3028 {
 	aux-voltage-chargeable = <1>;
 	trickle-resistor-ohms = <3000>;
+	wakeup-source;
 };
 
 &uart1 {
-- 
2.34.1


