Return-Path: <linux-kernel+bounces-390507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAB89B7AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D9D285FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC02F1A00D2;
	Thu, 31 Oct 2024 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="GB+Rf7ne"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07919DFA7;
	Thu, 31 Oct 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378199; cv=none; b=qk3ahvSJD6TGTFFioBZX48yuNpBHLHanCyI21udWL0U0KjvcXM3Hk3HNhM1LSHrtZs2z2+UqlUkN0QHJDhEstkcvVDseE633PycbaUfq04/yp27qgFGEF06B1xfz/jhjutGSLHJ4rsT/HL1rzilzFY0bV5ap3x2bimhA0btMzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378199; c=relaxed/simple;
	bh=gHD9yVfr2NpwXHx3iGiB9EPI6jKOz7lrwADbR8y8a/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISQ+zZ77pZ+J7rebvpH2uRtwY5tZK8hgRvDYxxcQgaDI1QCCE8MPNb7kS9EHaWgc2ZcPzX+OHKz7f3Kk6YRGVgMr4xhovaASYbv/ITWBiiXxmiQMFLIkLcCbxYRW9PGGM39ECL6uNzNOQYRwQtQPFY6GRFulia78GLGLpmMQmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=GB+Rf7ne; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 90C44A0E1A;
	Thu, 31 Oct 2024 13:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=J0TfKIJhJzBxEoeio8uy
	Um+I+RQoIvnhme6u8bHSaZ0=; b=GB+Rf7nebvz+E7tlkHBg5DQFDa8CMcF3/5c9
	vC5hLQJq0hAjMgltfYlM+3jntLqj9YQr7w+/5rlyDbkjFSfFb9hwGcA7H6jJx8Fy
	HqsZDYCpWiJvXsmBXpQDJhQMXe1nI8DR7nTnYe5r3SrtQWLiwUtW1OMD4rRCbY5+
	2uMgBTX7HqzjCHRRm/kcyPebsdK7L8+BvN7CFM+4H1s27+1u4Bb1ZR2eCy7VB7WR
	BD5pzKjE8qXm6wPnMvMsvb+zsd9IPVo6LckquWcHxmrIYQE117dgTbFpAyYBMUHO
	Xg/lRR45SJkT2htDIPulZEX99MCTURD9PxR0Ph8OVw/ID239Z6rsKaC/55FAmuRm
	lGU7LUCfqOUODmrab0Fe/JZz1ZxDuswwS1yQGCRENgMswrn47DtDeb+pYRNLspmR
	2RxKTq4qEEYe6v/uRwbxAKEhRFcg2qSctEjl0Rk8vToqWaz5xeK2H5VG/qU1psuB
	/Op+Kh3zdZL8HK1x1ITRkb7LQ47jIGfGA2+Fkhaqdo5A/mJ8ltcQJGtlICX9G37m
	phO+UNX2eMGWQlmwGMuvQfrD4wnWswqgXPED+ggKoUJVe1Aeb0d98wADty2w1YG7
	ddoYzZjhesKtBfPqxGJCNdyVm6OaCamMXVK5SntzotpVIM3jHTyGPBKK2kX6BukO
	BFxt++Y=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Mesih Kilinc <mesihkilinc@gmail.com>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 09/10] ARM: dts: suniv: f1c100s: Add support for Audio Codec
Date: Thu, 31 Oct 2024 13:35:35 +0100
Message-ID: <20241031123538.2582675-9-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031123538.2582675-1-csokas.bence@prolan.hu>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1730378194;VERSION=7979;MC=1362339620;ID=207189;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667667

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



