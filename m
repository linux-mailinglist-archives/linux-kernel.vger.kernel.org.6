Return-Path: <linux-kernel+bounces-218311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822B490BC61
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE6C284AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CCD198E96;
	Mon, 17 Jun 2024 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z/7qWNWb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90688480;
	Mon, 17 Jun 2024 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718657523; cv=none; b=TFZfZkdLfNUvoDqHKFdY86c0OAVHujp+EimipIq8Z0grYNWTfkGMJ91q6U3gmQaWQ5p3mv/0xElk+zaa68O3IYk7renMJOjE9STZdqvzMrhbs/VwStEfgeqbEgR0CPIgsje7NcDOlaMZkLeAQzY+djq9EEDoQm6bRZZVK6OF04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718657523; c=relaxed/simple;
	bh=78UK3o8feX6Y7vSvvuFi39TkdLBuDUlzUZXhfqvyxgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tro/zNkozGnh1Nvc/bVC/JmSVUfLTUUnAs6WBkSKLgNwVRiiPqeNVeqi76DJeQbWq4aS97FSvFvI86cTP8XJbkxbKq6IrRrAlBbMGZ+wMswrDvrzDQOKJLwqaFXWdxu1bQ7NbmbiQR8LshUv0n9BfbLigcUmesv16tPhKciYZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z/7qWNWb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45HKpqEN014045;
	Mon, 17 Jun 2024 15:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718657512;
	bh=gVyhdQ3l/BMW/aSJ9pkHk1DqLXx6HQtVfXYapVE9KcI=;
	h=From:To:CC:Subject:Date;
	b=Z/7qWNWbK+2Q99PgsbJhsnOPeC3X2+rImAtJlvEghCKXXWUxRA5t6axhIyWo2hhdH
	 4d67W9fK0S8QAo+YcNjdPOYdLD6n3SZOO/SlLsKf1eI7fKAkJYTGoPFhHB08vskbWx
	 lfDDO2dySfp/QMGrqYqBIe4HJ/jFztAX7TjDYvqw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45HKpq1r024561
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Jun 2024 15:51:52 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 15:51:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 15:51:52 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45HKpq0x005527;
	Mon, 17 Jun 2024 15:51:52 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Andrew Davis <afd@ti.com>,
        Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am642-evm/sk: Set serial console settings for stdout-path
Date: Mon, 17 Jun 2024 15:51:43 -0500
Message-ID: <20240617205143.3147509-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Set serial console UART settings in the DT so that generic distros will
work even if the OS loader doesn't explicitly pass it.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 2 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index e20e4ffd0f1f..d63293d85d5f 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -18,7 +18,7 @@ / {
 	model = "Texas Instruments AM642 EVM";
 
 	chosen {
-		stdout-path = &main_uart0;
+		stdout-path = "serial2:115200n8";
 	};
 
 	aliases {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 5b028b3a3192..c23730c395b5 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -18,7 +18,7 @@ / {
 	model = "Texas Instruments AM642 SK";
 
 	chosen {
-		stdout-path = &main_uart0;
+		stdout-path = "serial2:115200n8";
 	};
 
 	aliases {
-- 
2.34.1


