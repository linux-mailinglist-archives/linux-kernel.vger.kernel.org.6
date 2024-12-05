Return-Path: <linux-kernel+bounces-432405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA2F9E4A46
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05E2165820
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AB038C;
	Thu,  5 Dec 2024 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="kUx8ZXZI"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F3DA47;
	Thu,  5 Dec 2024 00:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357005; cv=none; b=VBQLf+TG4LWkEjfO4Kl3FvsjaJWsqmud4VOehrgQ7U1EG9e2KdhPMm4tSQnvfHyf9TBYzoUJR5o57KIHoU4GUIoAY3o3w3/5yIDNKVUSZwYuYQMKmI0un5D9ApZkSWp3pCIFDZGuDvY+Fyy799FUwCGlpjXlUzEghy1GH1rnUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357005; c=relaxed/simple;
	bh=gHD9yVfr2NpwXHx3iGiB9EPI6jKOz7lrwADbR8y8a/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnIWI2pMnzWZpIG1DHIwygBsuTG+NNG0kiNBPRGkHZTXHQQDnaEchIrXNgK5xvCbNIqwZp4bDoQfg4vRw+2xS9FFncyFT58IS3B15h/xBDEYakXzrnMnJsfxxmcSPsQp+C7Mu0zeY2FWdGuSCg+z28lX+RYj1muo3MiGwEF/sTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=kUx8ZXZI; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 72197A0E95;
	Thu,  5 Dec 2024 01:03:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=J0TfKIJhJzBxEoeio8uy
	Um+I+RQoIvnhme6u8bHSaZ0=; b=kUx8ZXZIASMhlIZ4TiYdy/pZZQmwnG9HM5Fb
	XQwD6yYUH14Yd/8ACjYsThgwfl6VkLFKGd09+UJOjcsXk+Tcfui2en1+tIGYxAM+
	dUgbwBjmkXn7n1xMZmKpefi/4EkN+Q+63tLQwdB60GeDBrGbt5fagW6oH6H2q6WQ
	jy3MN3sQOPa3L4C68I3LL7xJMfjrix0Oa94D1vR/IUMSSP9LShi9T/LwtYf3TgQM
	8r7gEGN1BgWHDeDgKxBlAFDqcxo/IXQOM3TAWgtKzszQQReM7YmBU6VftyOGaaFI
	ItzZykdSr3dhSDHnN9CnkVpa64IZaVCALFo+tKtFyYPaykk8MNVWh6Q+yG1tgbez
	KXHjWgaue2d/1g3mrnQt9PiLU0GKphI5MDTGZ9IP34mPNo/RIu3KN0IMQzd/eg8c
	HCLz5NmcYDrJx5TQOxqISIy5rxNGL4OSElES0t6RIQIe2ncmZLJkzoHHhae2ZIWp
	K852ZSDaUAqu4V1f9vnZyEy6Afv3qV8a3BdVoSI4q5Z09KmG/hhvGcb/xPXttgV8
	jsHTQPqsIYiBofEDLwjdqTzmU+oQMJ9SyhKNXtGS+64UShbXC/Km8oiJBg6XsZ6K
	kPFhDM2Oh4SlCXLXpCerNt2XJMoZkTl139rhbf/TesigfARmig9awebCOO/XVizn
	BXjKIaM=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/3] ARM: dts: suniv: f1c100s: Add support for Audio Codec
Date: Thu, 5 Dec 2024 01:01:37 +0100
Message-ID: <20241205000137.187450-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205000137.187450-1-csokas.bence@prolan.hu>
References: <20241205000137.187450-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1733357001;VERSION=7982;MC=2297510142;ID=169668;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94855627561

From: Mesih Kilinc <mesihkilinc@gmail.com>

Allwinner suniv F1C100s now has basic audio codec support. Enable it
under device tree.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
[ csokas.bence: Rebased on current master ]
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
index 290efe026ceb..e4b41bc93852 100644
--- a/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/allwinner/suniv-f1c100s.dtsi
@@ -336,5 +336,19 @@ uart2: serial@1c25800 {
 			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
+
+		codec: codec@1c23c00 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,suniv-f1c100s-codec";
+			reg = <0x01c23c00 0x400>;
+			interrupts = <21>;
+			clocks = <&ccu CLK_BUS_CODEC>, <&ccu CLK_CODEC>;
+			clock-names = "apb", "codec";
+			dmas = <&dma SUN4I_DMA_NORMAL 12>,
+			       <&dma SUN4I_DMA_NORMAL 12>;
+			dma-names = "rx", "tx";
+			resets = <&ccu RST_BUS_CODEC>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1



