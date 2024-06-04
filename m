Return-Path: <linux-kernel+bounces-200220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D6B8FAD22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF5E1C20D71
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BDA1422CC;
	Tue,  4 Jun 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD54TRUT"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802191420C8;
	Tue,  4 Jun 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488593; cv=none; b=cenFM9dH8hKyNN+/GaT/sz8VexmyflwCYsdwsD737X4eac/qjFBJ9AWSzEiiJV0Jj2zUNOvYs9zrDeKwUbNGWLhHvQeRppIjnOdMXPht0AAr7h53yExQSoAuWlZA8xy9XIO13f1dlJQI4ISuzMirrnNsncdanrWUxJUEXYeBPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488593; c=relaxed/simple;
	bh=QfMx1s4NYbFECh0KMXY2fQonXfPgUZeHg/AMZB1cqh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D1nmb33OT5KFiqb8klV/9hVkXoGWrPJJE4lWqBX6aZPROTOucuPRFIP0OtyUDRam4reQhLFdr6cgmHRMPJZFrf3GrNlk5zqIu1kYJGfWNYXnd2IEi9tC7q5OSowOOqbpH1+HhUQekTA6drrLxsvr7hcRYxOsdGhce6STivxbswA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD54TRUT; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d1bc6e5f01so487952b6e.0;
        Tue, 04 Jun 2024 01:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717488591; x=1718093391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/JzBlxPKXhRdUDPgfYR8R62q7BdNA63+MhngvZbY1c=;
        b=iD54TRUT2JuHQu+FGmD08Vaj5FUgQcBh5DM/ii5g6nzmI9A0St96IpAoToMtNI7WhO
         cs5ZPBmy0pXbR/fgDO4ofeU55TGUFp8JUoG253EQcPR4857WZNBeplvYQzgthVT8Qhmr
         xMvpC56B1k9YSn15ad7w+ezPRLiB7rU90HevzadnTy+Q6sAj1Cyh9HizeWdEQ4kdi+LZ
         5XH0kgWmyjZO/Kws9pvRiyoHuymciT2bfC+Wqv9YSq/1OQ4QeH3bzCxjiroD7VqSXavN
         KYSyhLPJzfQB6RJgamDH3cNNvZ9rRd2MnoLq2NjeVnbOFh/9nH+dbhGQMR4eI4RRd3CY
         6FZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717488591; x=1718093391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/JzBlxPKXhRdUDPgfYR8R62q7BdNA63+MhngvZbY1c=;
        b=Fr/e5FToxFO9eBcR2n8uWPb/CZk7cUJ6OxEsz4hS/rQG2F83iEydpYNlKjoiMTcYHX
         aCdQKSrgtTgL3nRvgV9DWLfjktXLpDxIbW29d1FK1LsS/CwdInEhOE3dNrwvLEJM2DWd
         sKKsz42h0EDryHapWYtsHM+pRVb6JmgiPKhUrrYMXHRn4sefEFj2EcyjMZeu+X35ne94
         7U66SnRfLcvLRxk4aj+ceuVtxP86Nmlpx3K/HMm2eo8m4FXl40BviS83iIPISK+pRUJp
         rd46R5hIeDwutFR20k1Bs5oE7h6yzSZbSqWEX1bsniTiQbF9LUzup+KAzSdacmzShl9d
         UdOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc+8Wb0gmuYsppr9nU5XSrrhcCSt0GHygO3bycVwO9OCXCDwtizfzYTsGmzFPJuhFVGdrYHEYJ3gwCTfD54Jdy9xMYPge6JfifoJKjff8IwSzHSJLHakqQctT/r1n8rqw7YnWk4E4fnA==
X-Gm-Message-State: AOJu0YyQH/LWevGtkRzszCYC5l0w9FoeLzBO7DzYMsjqpb6Ahqgu6sGt
	+GZj8VNZtvt+QSSxV1QIx9CEaQkHYnzenMeLaJQ1cLfCuFS9h/Z6
X-Google-Smtp-Source: AGHT+IFFCg2DPiMUJICWLo5W4SVKZNhaNvQA589SkV9jdqKnV5/xLOmdgqG+XDZkhXbK9TcxaAHIpA==
X-Received: by 2002:a05:6808:b17:b0:3d2:c8:7efb with SMTP id 5614622812f47-3d200c87f13mr196016b6e.30.1717488591489;
        Tue, 04 Jun 2024 01:09:51 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702425e20f8sm6594838b3a.86.2024.06.04.01.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 01:09:51 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	schung@nuvoton.com,
	Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH V1] arm64: dts: nuvoton: ma35d1: add rtc node
Date: Tue,  4 Jun 2024 08:09:46 +0000
Message-Id: <20240604080946.80-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

Add RTC node on MA35D1 and enable the RTC module on SOM and IoT boards.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts | 4 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts | 4 ++++
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi         | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
index b89e2be6abae..b3be4331abcf 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-iot-512m.dts
@@ -54,3 +54,7 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&rtc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
index a1ebddecb7f8..9858788a589c 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1-som-256m.dts
@@ -54,3 +54,7 @@ &clk {
 			   "integer",
 			   "integer";
 };
+
+&rtc {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
index 781cdae566a0..394395bfd3ae 100644
--- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
@@ -95,6 +95,14 @@ clk: clock-controller@40460200 {
 			clocks = <&clk_hxt>;
 		};
 
+		rtc: rtc@40410000 {
+			compatible = "nuvoton,ma35d1-rtc";
+			reg = <0x0 0x40410000 0x0 0x200>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk RTC_GATE>;
+			status = "disabled";
+		};
+
 		uart0: serial@40700000 {
 			compatible = "nuvoton,ma35d1-uart";
 			reg = <0x0 0x40700000 0x0 0x100>;
-- 
2.34.1


