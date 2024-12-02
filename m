Return-Path: <linux-kernel+bounces-427006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0FD9DFB1E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 545CF281D53
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8C1FA84A;
	Mon,  2 Dec 2024 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="QNI9QLe7"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEF51F9F61;
	Mon,  2 Dec 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124088; cv=none; b=fNKJ1dg3F0qrkPkLJa7S+W4xlWRm6vvBMUXaQ5ffQDsKLc7p1Ho7gdhZSjZ+2xoBEzrjCyiexcErT5y23oGjFiT7LVp7Ms2OUu0yEgHOh/SKxMV4NpQapaZ9Y/a9wG7NQK3xpoahw7j33DAOUwTFmESAFX5D2VOOOiXijx55Js0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124088; c=relaxed/simple;
	bh=NHY9fGrT5rQnP1CUH/eaY5EXLY57ol9rwQRXtaU71xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QiFlbUBmO9wicNVtQnAdGyFrjAoTjAy7xT2T2mkRnQOQduF2jXjYGmw0yo2MjHcN2McMa5RJkkcMhoIwVudUxVP82uwWEV0jfmgZUA38dQDKNp810o2x/Eze7vYn20jIw0/YmrpDSmVnVLcOoNK5t9csUpiVb62O2RwBNHkiZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=QNI9QLe7; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FHbi25psmEzRQhG5NVjd803yBwXVAPrvD4Z4Ntprh18=; b=QNI9QLe7mnhV9lun0PCdAtOsfS
	7poEq7S2lQnSklcHYbksL5HQQdutzqRR0hwSRR8qBUed8l8h4kBM4J5Adch70634fFbf4+bfcd3vM
	1QaNoG3LtvmHBztxPdX1lL4l0IzQ5Oo+iCITEVJryixYL081adhTwy+63cSQoFKtiRr9W6hh/M7Wa
	MinS1qHzGSUhQWiO6eTlsVwknGNQKhXn588SuXTxfN4/gLwRKhNSnP/IXQGJS3i+oB1HWFAc5Q4I0
	AK9Eyh8SVyDoBPBOVPKmLpvkLpq0vtZvhpyLamZWI4tQco1nRbypdTnx9n1hePKwiKD2V3lsxAFQp
	ySi7Jwjg==;
Received: from [89.212.21.243] (port=53766 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tI0kA-007Bva-16;
	Mon, 02 Dec 2024 08:21:18 +0100
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
Subject: [PATCH v2 06/15] arm64: dts: imx8mm-phyboard-polis: add RTC description
Date: Mon,  2 Dec 2024 08:20:43 +0100
Message-Id: <20241202072052.2195283-7-andrej.picej@norik.com>
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

From: Yannic Moog <y.moog@phytec.de>

Add RTC description.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
 - no change
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


