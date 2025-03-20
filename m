Return-Path: <linux-kernel+bounces-570320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A8A6AED4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE5B488047
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8146B22D781;
	Thu, 20 Mar 2025 19:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="etZ7FVHf"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626FF22CBFD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499906; cv=none; b=e6wRg/IMYw7Z62zAMYY8pOgNxhCfV6ovOyPZGU9WqlsF7w+EczMIH5CO0wP+iTrKd14M0/2jUgGyjX07RNR/ad23wfi98vkcaH6soEWxvVLlvVziNgsyYU/4gW0/2I1XphSbyXRJSPHWiQ3HUGAo83LHwF5gsQEdrCWGX87XbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499906; c=relaxed/simple;
	bh=KwRmEv3W3EtqBDLfbMtwfsqs1joXJAuCfqCxq5Hb990=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeCqxJMj+LA/0t71wmY6oFZti8PtZZADsU4Lje0x5RyGefVaAaNXFlngXdRi8l5iYul6mdsbAD+YNsOuNdQ8yKFbQGsS8rGicoDEEoSjpq5d9gclZqfFnLlQp6fJ11lo38rX2GrjQNquwTXS1P+/k6zZ/LTRxrgrpHhx94h1rlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=etZ7FVHf; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85ad83ba141so150037939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742499904; x=1743104704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY3+cr8LwPrnwPUbr8ZQVdT4sW06Crewhjj4AmYBWuU=;
        b=etZ7FVHf/t4RCwsZTTGfwWYqlZhphkFp4QJIBL3GOOpZxDQ9nbLGQH9PJ2cgyAePPl
         bYBE024SQRI60ILNL3ugxJxPKrw33j6D6RWL66JWKJ2NeSMqTs1kL4u3sJ3d40NYR4YL
         5rnSJ9qDaGNIot2I5KBU/nAke7YKPyks0NGYmYP/H2SHzVncbUVMsYVcZUeYZx/yUT90
         9eQM6gWaGkF1YvfK6cP8s/onN/Y661U8ITUlq1UXBVT/6327J/s5tDoZXbx8OSMG9nv1
         zpfytJN8xdBueBPlJBrevoNz9+S+eix7ujXtXaH24Rm5lTfMjL6CoqI+KZlqhbl9OAn0
         kWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499904; x=1743104704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nY3+cr8LwPrnwPUbr8ZQVdT4sW06Crewhjj4AmYBWuU=;
        b=Wqme+rq0zppfXoZInNN2CFd+qWqic3FPUbMbxyhK9oJMJ1RZsWZV3A9K3X7hELmSn7
         6gcUyEbYyHfbApPQ4uMtGmIsiTxadHtNW/+OqFuQTTeTi1CmQpfkbqriBjRW/8ul9Unn
         x2W50lA0YANWozMMTBxcePeeIcNdtKUVFOG+9ZD7YRT1qOQ3Rf88IMuM9H3TIPUHzK4V
         F+rgLC5K/Em7a+Xuh3CZ12IuTvwEQwQWgwdHvoYSCU9ESC/45myflWFOXUD3d5AI8pDz
         +6UxKLiwnKvrK/OKa2LUOADS1hIw/y61wXHONEtakpWAfHRFvyRDllKpZYEIJtTkUKi7
         MONQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyPutitu8IbNxa33VMmNr8DnAOh7v6Py5qcX3rU+x6GDPDwMCsVrHuDMlMNVeRrksOUhkqT28VAawSVwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIcSPuO/bVzk2l4gwZ70GsW9W/1Tec8QldCU5ou3nPCrRElZY
	mDSd3J5AQpLgHIcdWZI7Gh61Ef4V8rXHt6brz4DQdd8zsekoHbVykJxJEzu3gHA=
X-Gm-Gg: ASbGncv2y7Q71xhFBDZXWHO/BGEBeFbi3tpNw/mBrSZwUOiluK3vzVztJDP1Ml9o/aD
	1aHWKPJEed/pxGVJn1t9DostvccYkC6zyM9yggiMrvdiEnreuRUQaVHrN6qeMriCAY97e0uZp0e
	zIzfW5/PmJtxroKAQtYlGOLLPFP+g0y1wRkLL+tn8IuIPpTKEpQa8DFkUJsLOgU5DECp1HJccbl
	PA1geSKGRTPb/5rTz7IEFE2eo7aStS7CtBLqH5z8V8ThO6WzoGjifdxiyjJnUBgDUnQBTWWM5Pl
	OD6E/hpzVjCxAIy77BOR8HWc9YBeVYTtv2/g4Rl958lJWfwUSmZ+ke//rfqdB8bkMiubYBXMwh+
	W2R32upPSXQfQzM08subwzDfy
X-Google-Smtp-Source: AGHT+IHW4ltSCaG93SoWDansawq4DbhKwVMoGQNM/OgukHjVy68CtBuW9QNsRfgK8upO/XwMcw3t4w==
X-Received: by 2002:a05:6602:36c4:b0:85b:5494:5519 with SMTP id ca18e2360f4ac-85e2ca6fff3mr65533439f.5.1742499904534;
        Thu, 20 Mar 2025 12:45:04 -0700 (PDT)
Received: from zoltan.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bd8c40fsm8341439f.32.2025.03.20.12.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:45:04 -0700 (PDT)
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
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] riscv: dts: spacemit: add reset support for the K1 SoC
Date: Thu, 20 Mar 2025 14:44:48 -0500
Message-ID: <20250320194449.510569-8-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320194449.510569-1-elder@riscstar.com>
References: <20250320194449.510569-1-elder@riscstar.com>
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


