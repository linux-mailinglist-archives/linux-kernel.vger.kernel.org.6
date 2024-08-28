Return-Path: <linux-kernel+bounces-304441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F70962017
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 760BF28210A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705B0158D8B;
	Wed, 28 Aug 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQBOCFft"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05C15853A;
	Wed, 28 Aug 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724828125; cv=none; b=pIeqe69g6Q1D8xejY2uZV68WDoUFJB7fWNQXtjPbq5kEtcumHU4Y9z6P3ix8p/hbAXAVwVYiHkSBvn+/6okkztG1YyewFSYlDU5kxAc236hgE3r7AnDjBmXd2wuXdqR0P692vgIoSWO61aW5TofY3odCKPkca593SOxPe8lZANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724828125; c=relaxed/simple;
	bh=azKLHZTs1ZBY+eqdcedgQhDiON5SLSXIxeYqPgyi+P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TKIaIl8EqbN9icxL2nwzRufZJohIFkM4AKyD2PaOpCbEqFxWoy4HklisKw5teCc9yEyvByqh+kgTT2uDZCuqm7oNVdkHMAUqEXBxj73hhv9Q9se2OEnNNvUM5SznK0hgADg+dNeBapy4eBkVegZ2n716G/R1XMdm0g5julU1tgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQBOCFft; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2023dd9b86aso50739765ad.1;
        Tue, 27 Aug 2024 23:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724828124; x=1725432924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRxYEethFaPHbS9fj3JDuM9MZyXWGe/oMxrByYjDscI=;
        b=MQBOCFftrb06giSkjBiMTv475aQPEBBphhOa9GbDUr7UcpnboAJ4Imvom1TXvh0gCA
         v9V8A6AjVw8gEO8CyM4lG5Mw74+SPiP71uyO+NV+tI4eIm4P+v0y/VFbzPNyrmjsmwGc
         eZ/nCFACWkWBfmyE6JUKnqJFYt9pxWSMWReYYqwfU3y03tG/+I4WW9/XVaB/VeTkr/LZ
         1hn8Q1eS0VG/5aK1/xrWq9mV77++vwiwcJS65tLwvI+jQTdjBaORPSaL7b6UhIl/9lUY
         DXNiBiyUQA11XdZ9Gf6oRxRokM60qDxqdtrJFm2eJwoORFXg79ZPBeopLSt/PfQ8igsK
         szow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724828124; x=1725432924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRxYEethFaPHbS9fj3JDuM9MZyXWGe/oMxrByYjDscI=;
        b=AkICqGGkgA7EU/SxuR2bLWGvPVJUOjSFHqsuxB1bqD+OdRzsv5w7ACOHS7DGEbEJPW
         xAJd13hQCw41ugLU07sTDawAz7cJZyHb1H7pTrCyKtMfjYsCb+rnNdz41Cmh5jJOjyAl
         a8/i5YcejPwN4qu4QpXr1BGqZZZDooIivP5LGK/OdxiffnFLueEqSLRPfOzZWRFG8PO/
         ivEzfGcf0fsnBVPXKMilRJ9cLg0HdNHhamKKcVh4V7T5YPQ58gT/3P2E0NZ1ArMkIRDM
         eeHgxtxj9F6qpXN4S9KCJ71DrtY6kPbdKhH9vaB7/ydkOJ82FFTdm4GMDKRXzh01GM/h
         JwHg==
X-Forwarded-Encrypted: i=1; AJvYcCWRx7oqF/0NKNaCE80MNat/eF2PU3HjIf/VPDfrPnrEcRmsNCflKacnDFoYfLYbZpGl/YuKatOgqwctPD3P@vger.kernel.org, AJvYcCXTvKRwfwO/kEHpSzu2u8FZQ+MVVCIJwvp/GgwO2WfFFzbi1wYY2+3ErJgbRrmwJwg/F+OsPu8VvCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynSzjQytLcp5Si7aGZqJk35lj3p2urX6IfpP36LjyaPTb1Stc0
	ygNrci0nwVYM0CUCH9+lo+cIWq4cnMWPdvhorfAXNgVBbwHfv1FApaelW1mK
X-Google-Smtp-Source: AGHT+IFNEx4Dk5gs2p6bZvs7Rq9HQ8hMPHB0qibnOdi772UG3c9oJXf1TaaHf1ctBf8WV+Gpt55VlQ==
X-Received: by 2002:a17:902:e891:b0:202:38be:7b20 with SMTP id d9443c01a7336-2039e4cd9d5mr157176925ad.38.1724828123590;
        Tue, 27 Aug 2024 23:55:23 -0700 (PDT)
Received: from m91p.airy.home ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385607f94sm92816005ad.182.2024.08.27.23.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:55:22 -0700 (PDT)
From: Bo Gan <ganboing@gmail.com>
To: zong.li@sifive.com,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Pragnesh.patel@sifive.com,
	aou@eecs.berkeley.edu,
	erik.danie@sifive.com,
	hes@sifive.com,
	mturquette@baylibre.com,
	palmer@dabbelt.com,
	palmerdabbelt@google.com,
	paul.walmsley@sifive.com,
	pragnesh.patel@openfive.com,
	sboyd@kernel.org,
	schwab@linux-m68k.org,
	yash.shah@sifive.com
Subject: [PATCH 2/3] riscv: dts: sifive: fu740: Use reset index from header
Date: Tue, 27 Aug 2024 23:55:19 -0700
Message-Id: <93f4603de5056c94085cd2a91934563789701795.1724827635.git.ganboing@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724827635.git.ganboing@gmail.com>
References: <cover.1724827635.git.ganboing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hard-coded index is removed.

Signed-off-by: Bo Gan <ganboing@gmail.com>
---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index 6150f3397bff..a2c09033a9ed 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include <dt-bindings/clock/sifive-fu740-prci.h>
+#include <dt-bindings/reset/sifive-fu740-prci.h>
 
 / {
 	#address-cells = <2>;
@@ -358,7 +359,7 @@ pcie@e00000000 {
 			clocks = <&prci FU740_PRCI_CLK_PCIE_AUX>;
 			pwren-gpios = <&gpio 5 0>;
 			reset-gpios = <&gpio 8 0>;
-			resets = <&prci 4>;
+			resets = <&prci FU740_PRCI_RST_PCIE_POWER_UP_N>;
 			status = "okay";
 		};
 	};
-- 
2.34.1


