Return-Path: <linux-kernel+bounces-571516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBA7A6BE33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585AD3B544A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6922D4DD;
	Fri, 21 Mar 2025 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Gd15sIhX"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CAE22C322
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570326; cv=none; b=SYYMdPd/qhbUvcAYh53dkKDHqflaafZsMzkczcFLe/aa2JT4FJerZdgs5YFs5fUxtrZ9IVS5Oma0sAKJM7wqnVprfwjcyn9bRcJ3O4IGV9Xck1SF/u+QZe8MnlUU2ZBOPaNQjKuvwFeWPp9iq3Vw54FHJpP8+RL+MOtv+TbZ1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570326; c=relaxed/simple;
	bh=KwRmEv3W3EtqBDLfbMtwfsqs1joXJAuCfqCxq5Hb990=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1VYeW/8YY4txhu9K9vpCazJoBHdQDozkjjpu3hyrHQDMvHklbeeh1g+AFmL1bxeUvSSTYzoPx8xlaE/07KBYdzFs/c+4QFc5KY0sQagMCrhyp7n5KNAv1ca2K2zVPxnuMfSAtg8wGS6Eb7uTVaj7knovLZ/z2qqB6H93/Imwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Gd15sIhX; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85b58d26336so174586739f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742570324; x=1743175124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY3+cr8LwPrnwPUbr8ZQVdT4sW06Crewhjj4AmYBWuU=;
        b=Gd15sIhX4tO0We2cOgrcjjCQILRs9oNjnwwr8VcMiPrkYPlUQudRVvzHJ+tlLx0cxh
         6w8O9fbHHMbGhofKrkj33y4bbMeSIyY+HPEKUp6QLr+QElgcFxcqRnywXxdJciMO1Lyc
         98HfIqnZ8GP+wfpMAPiwJOs+3MnmysBWGGHaYMFDijrE9FJhbb7hNTW9SfB+2TGNmIwn
         LB3k3YA2OOSqdvX+a92wPeTSCC6FMIiBkZXdmWVSyMkcqiCl5sHg/KFfKsl0PDNuAwN1
         k+xMazFE756CJ+fiC80VHYQRtHGCCQg00n75lX9zKLAPnWh7zBsQRT6OsGHnT9Fytlrk
         Z/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570324; x=1743175124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nY3+cr8LwPrnwPUbr8ZQVdT4sW06Crewhjj4AmYBWuU=;
        b=GOpvWHdIXx2Bkvittn4t9V7IuerqEk45Mr0LdpGHIVWCViYRvOfbM2RGCyuO9/knI/
         LGP2hcN3rFntJ/xcrNKqQbDYK4oE09pXsxGwQYo21W6OPTCm5+uFjQUMqekpnI3ZeVyu
         wktt8nUGALbfB1efM23VKus5UMNx2dDWbh6O/ddznrNeDruyK8UKy11DFrMSeHy/2EMy
         s22FI3of2lBZHFyIbZ2PGQMtacx+DQr8jp41dXrZE6+QveYSovLZ5sSsZVgFMakS3uYX
         FR/8plJ56lIvbdvis5unfTrmGdelj0u3MWpS+8yr5FVSfbNns2pmr8GiAZDFByuI1cuE
         SkcA==
X-Forwarded-Encrypted: i=1; AJvYcCWXVUJEqh+U8kEp7jE4Mfp2MoYEu/nO/iqymA+53jcV/CQEt8IAMJwJovfKE04osou4SZHxEaAZUClFCmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2s+SaawxIU+7N2wnRtAa5WWeMjXxQOsj45kaU9MXLbCkJD9h
	fR/pKit/gyjRQjFbTd21BHT7WymiD2MblDGfJkj8WQv4udjZqdOXb/uGgL281ng=
X-Gm-Gg: ASbGncvRGgFfbDb/bW+WqcCS9OR2dXMdRdmNtvz4cNsAQJFgJUcGjxICyyerjHr6j3/
	91dxQFTo/bS5dFUPtEGGe/eE7vlvmjqWSuKPfJvZqCBVBFRucDXU84lVOxtRt7aLl61Zq1k9OtK
	TulIRZ+86Q7N7w3St4+iYDTVHc4uphKFc+sqKgAUJvKRv/5UsPjBBOIpAkJdn3/gJz8rgvkXD9I
	a9DDjrsxM+4gMOkb+AiA4Wqpway4gIGNuesJeJhaW0jJ7tROUi2gAgSxxfGolbDr72yPEt8UoD/
	CMb+cv1G/0euGGl+NNotKE4mPp61FZhfvKt4RA94T9McW0sy+ZU5Fmp1m0dBnEm8QUFs+owgREt
	1Memj23UIfylPriZnR8p26eMX
X-Google-Smtp-Source: AGHT+IGguI55dL71gHl0tK+hT91rVomg7KnVgw+/XoVslENUEzuEPRHi4KDVzYnSZRrU4EihCkbgug==
X-Received: by 2002:a05:6602:7512:b0:85b:3c49:8825 with SMTP id ca18e2360f4ac-85e2ca62dd3mr380237239f.4.1742570324050;
        Fri, 21 Mar 2025 08:18:44 -0700 (PDT)
Received: from zoltan.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdd0a21sm475553173.41.2025.03.21.08.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:18:43 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: p.zabel@pengutronix.de,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	dlan@gentoo.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heylenay@4d2.org,
	guodong@riscstar.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 7/7] riscv: dts: spacemit: add reset support for the K1 SoC
Date: Fri, 21 Mar 2025 10:18:30 -0500
Message-ID: <20250321151831.623575-8-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321151831.623575-1-elder@riscstar.com>
References: <20250321151831.623575-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define syscon nodes for the RCPU, RCPU2, and APBC2 SpacemiT CCUS, which
currently support resets but not clocks in the SpacemiT K1.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 09a9100986b19..f86d1b58c6d35 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -350,6 +350,18 @@ soc {
 		dma-noncoherent;
 		ranges;
 
+		syscon_rcpu: system-controller@c0880000 {
+			compatible = "spacemit,k1-syscon-rcpu";
+			reg = <0x0 0xc0880000 0x0 0x2048>;
+			#reset-cells = <1>;
+		};
+
+		syscon_rcpu2: system-controller@c0888000 {
+			compatible = "spacemit,k1-syscon-rcpu2";
+			reg = <0x0 0xc0888000 0x0 0x28>;
+			#reset-cells = <1>;
+		};
+
 		syscon_apbc: system-control@d4015000 {
 			compatible = "spacemit,k1-syscon-apbc";
 			reg = <0x0 0xd4015000 0x0 0x1000>;
@@ -518,6 +530,12 @@ clint: timer@e4000000 {
 					      <&cpu7_intc 3>, <&cpu7_intc 7>;
 		};
 
+		syscon_apbc2: system-controller@f0610000 {
+			compatible = "spacemit,k1-syscon-apbc2";
+			reg = <0x0 0xf0610000 0x0 0x20>;
+			#reset-cells = <1>;
+		};
+
 		sec_uart1: serial@f0612000 {
 			compatible = "spacemit,k1-uart", "intel,xscale-uart";
 			reg = <0x0 0xf0612000 0x0 0x100>;
-- 
2.43.0


