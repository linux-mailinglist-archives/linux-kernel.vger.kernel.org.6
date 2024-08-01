Return-Path: <linux-kernel+bounces-271751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA2C9452E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92751F247D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BA114A4C1;
	Thu,  1 Aug 2024 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="I7XZWB8E"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F6142E77
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537505; cv=none; b=d4Ehz/sfqCMvE4BtMNjmJhWFR8hoXCZOUWstN0bd+G+U/wJkeODgDtAevGce6ZQRDULrbfAZ04jNZoV6popRkqVx8lQ+hvi/loVj9gvUL3dokODVBwUZOQaz7N1VUrMFvPdV9vZGdYXXE6UyUj7oQ77Cpu03/WKd30t+QCDf6kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537505; c=relaxed/simple;
	bh=zsUROxHK85bECtvAK7eNhBwbloaw0A8ZmtOwteQ6Ako=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1wL75FYOnifZMFv8d6ZOxkrpAiS738Js2fixx4sbdFLHnykJ23sk0fJEo2AZ1qcG8B3HOygG29ha/ZaukMxHbBRzRvfornDfUnDD6tN8utV/b57LlNBF1yjMdY1A9vYfjO1Sbr1pxsH9GMXQQExc3hb5chrnJ0W7bt3N2DzwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=I7XZWB8E; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cf98ba0559so3753189a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1722537502; x=1723142302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tk3fdWOrHxhGe/z2L68pKaBMmRMZIgpiOTECkCtz9Bg=;
        b=I7XZWB8EkGOQhB3Td8EKBOau+6aEr76hCtqSbY1+Rvd1nUbNXPfDRr1SsJBdBB0/Xz
         ixlvptNdkb3/cyY+NcjSowdWFImqiBzNhfxWsDseq1lF/t8DKVyOFTlBTw3Bz1t/mvbZ
         3GoBJPDUneEs67s09Ka5guwsjcfuZo8AXc+fMa+rwFGjiFIhPZdl3Z4cIdm1UEDv/zXr
         D1WbcI0QwgYMCrfPn/eZOsARxI+sjnWjjYDmGPVASAiKcf/r2+TtDEAQ1z7xabwSaN+I
         FGr+bMhuyqfXXyuXCLQKj6Y1CFigpbv0jbN2etXcqWURre+f5DmyHQESqeoadP6G+eHV
         na/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537502; x=1723142302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tk3fdWOrHxhGe/z2L68pKaBMmRMZIgpiOTECkCtz9Bg=;
        b=sS0H6o3ie5Ctc3OXEXlNx6283Wf/bv9O1+ZiCJrZmOwxHjnrJ77LBuvmZLcJ8Iu/r6
         jgroZsDGDpbXC8faTz/5SFJvKZ+ISfEX9v3WOiN7hAUWiTVSU3fTho/pcjbpCEwdHyhQ
         wvssROkUl7wCtO7TA8FS8yKNWFWFGrTULoHx396CQBqgsfLHU089olJfuy7tQPB7EA7v
         OX2yVTvtH3D848pA2YuTqykI9YwMLCEfGKHNsQSdegKLWeXUURU4W5J9x+0kVu/hWdiX
         4PRBhgAHuTY/6xoIZ6zSsAe0YjFhnhJVEHG62SE7JVPoplII3XGbc8jPsaI4npeCr+1V
         B9YA==
X-Forwarded-Encrypted: i=1; AJvYcCVfxNqva0Gp0Jf91OaWIooBrbpY+2uduETgrE08QWJO0P3Mg1ajNpY5pBBeejcJuUFmdcsZ6EG4Ai4bzaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89ehGF2K9b9apZBewkyo3kdb1CC/VQ+js9gZld2o4sBaAoU3j
	rUSTvHHKLnX2qL7XtdxnBtv60qawWfQ/QnxFCrBPnv/pbB37xKdOfYhhPgBSCcI=
X-Google-Smtp-Source: AGHT+IEivcdDbgQ5UTdJZvwjjzFBFMbO3AfwipXdPpcaMO6VuyrFNirJJMGYJHlNvMzav90dOHGVZA==
X-Received: by 2002:a17:90b:33ca:b0:2cb:f9e:3bfb with SMTP id 98e67ed59e1d1-2cff952bdf1mr1296175a91.32.1722537501642;
        Thu, 01 Aug 2024 11:38:21 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:dfa1:41a7:9478:9d47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffaf69d54sm279728a91.12.2024.08.01.11.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 11:38:21 -0700 (PDT)
From: Drew Fustini <drew@pdp7.com>
Date: Thu, 01 Aug 2024 11:38:05 -0700
Subject: [PATCH 1/6] riscv: dts: thead: Add TH1520 AP_SUBSYS clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-th1520-clk-dts-v1-1-71077a0614b8@pdp7.com>
References: <20240801-th1520-clk-dts-v1-0-71077a0614b8@pdp7.com>
In-Reply-To: <20240801-th1520-clk-dts-v1-0-71077a0614b8@pdp7.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kanak Shilledar <kanakshilledar@gmail.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <drew@pdp7.com>, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=drew@pdp7.com;
 h=from:subject:message-id; bh=dnuRibn2g+ZT0aI5L/Shjy6/+JXvi/iMXiSHhCZO6jY=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMaStviZpuPSdaMu/gLKy9YEPtD2nyP28OvGDp5lh7YPPt
 3Xc66YFdJSyMIhxMMiKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmovqB4b9rZgiLlrCdhK3t
 i7JXq7bERMjc+rL7vuG1pyWcj7gSW+UZGe71um+5bRAbdfweq36mrm65VU/aNF7mZiWhJEthFct
 FzAA=
X-Developer-Key: i=drew@pdp7.com; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

From: Drew Fustini <dfustini@tenstorrent.com>

Add node for the AP_SUBSYS clock controller on the T-Head TH1520 SoC.

Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
Link: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index aa703da30fc3..25ef5ee729e6 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/thead,th1520-clk-ap.h>
 
 / {
 	compatible = "thead,th1520";
@@ -419,6 +420,13 @@ uart2: serial@ffec010000 {
 			status = "disabled";
 		};
 
+		clk: clock-controller@ffef010000 {
+			compatible = "thead,th1520-clk-ap";
+			reg = <0xff 0xef010000 0x0 0x1000>;
+			clocks = <&osc>;
+			#clock-cells = <1>;
+		};
+
 		dmac0: dma-controller@ffefc00000 {
 			compatible = "snps,axi-dma-1.01a";
 			reg = <0xff 0xefc00000 0x0 0x1000>;

-- 
2.34.1


