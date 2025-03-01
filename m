Return-Path: <linux-kernel+bounces-539918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C94AA4AAD6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543057A79AA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975F1DE4F1;
	Sat,  1 Mar 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SMj5dZzr"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0D61D5CD6
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829885; cv=none; b=fk3WPeaoqPAxYIFjjPXDSYUBlzSVo2j6xPMcwP4EPbDZ32TO2VNJCVzAFHKGOAiLNZ9c4kYG/Z4yaHyEXGdpNYvHa2yBj3CfuiTPHaOZKx9WgyDxB0Thf6TOOjgt5fVgB0ReKv3U44Ofwt7eRjrcYa0TxwLaWHlF9REQnyl5Dk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829885; c=relaxed/simple;
	bh=MauIs/YOHxA/fbRsi/ga9gpR3qWx7c1ccfDZObnWkYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/WGeJ8H8klSSieqBagUWaMpub9ZOTiImKPiSpntPmS94+LKQVLJszK1nA7I/aW+/OgZxTe1QWfiAxf/xf1rJL+an94q6PnuO8a/XXxRnnLaUKHKoSN+qeAXd7Cna7Sf834elYk8M0cacELjXCJEfS80Nd5R0elvyjpmkp2Moz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=SMj5dZzr; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so4896752a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 03:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1740829882; x=1741434682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdjO+gXNbFswOlU5mvEFI+zF9XideHYOKEcG+ZI2j5U=;
        b=SMj5dZzrKdEBcHTS50/xlfiuWXPsi/bIsTx5SP+4vTQPrWAqBg+ltM2bbt+JxE/x+a
         4KtRssv3WblAGk3OGjCg5xJzlaOTI1nLuSTBoHNEPLXFq0ROYf3bZGfZ778lbcNwxZkQ
         IZa42tIodheplbYqyhDeoI/aEtALAS/KX9t0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740829882; x=1741434682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdjO+gXNbFswOlU5mvEFI+zF9XideHYOKEcG+ZI2j5U=;
        b=ioPmEylY64S7hfFoJ38HZoVWR8wMwf2BXbQBJnX2UJoUfbsnZ6HgEl4vnid8pid4lL
         dv/DKxPYV1pYhlr/qAOaNheFL8+NNp5TBsATtNu8juGy4j4SLdDLb+GJlwcy6UHAcM74
         uKED2y9QV2uMj5mz2Q9hWdPIbBAXtxEKqIH2lIlW0bM5MR2YIGdGdQzcbcUbIEaq1QJd
         efAmy3Bw+dCpcZw4yuERA6ULSd7N2ShDoh/uES6Nwpr28LteehVG5buZ/IYfRsuqdovu
         BzzK+z1QajQRFkphc/9DVuQItogd2I/p8f2+zEHmjy6IhF8gAwutMJJaToK6UvBZw8SO
         B8yA==
X-Gm-Message-State: AOJu0Yz8ZCc4GI0HcAC4kLnTaRPQGdwADm41KRtnKfWRAktexxedL6Ip
	Xp1gdXjf+hOfS1DTK590t0JXBDn8PsHM+wYSyZDjprkAn5CWxU2FU+/H8GGTttCsYyDOpkVsltd
	U
X-Gm-Gg: ASbGncsGePdxg5VDrErwEQlPjVdwoGeDYYnZjB1kCsuDk2gVOFhNsB3OVUVqE5inmR7
	XGv6vhxKmXgJrwqZFSWbrT1u51DVFo6y7xLO+Pjz9FApTneNX27S6tc7m67fR89fBaqjQ8kiYq7
	vnOBlLmlbus1ZZNHk7MDvl4ng/KRLh0vUbWP/4dgWV4JXzPZNvXtVXhhFGLitxr1S8UuU8ZDFgF
	NTVcUQmQiWzrB0bpbEVqWLhLOPOJiX1Og3dZDcMXXxLaorvebWJ6658UaWM8mFLbnPOt1T1KTr2
	vpOruwhmU8YfXpu5EP07aDhZ1i5AZpa62a1Uv3tNbwy4+iaZ21cfR1NcAEOUI0f3w3iuiW9OIGY
	3JwlTTjWg1YwhU3r1ka/i/WA4bwnjdFKZZRA9jh7ob3HnlwyUWAF2iDEXL8XFs5Ip4vJV4cxzEp
	nk7saS0gPFY23a8A==
X-Google-Smtp-Source: AGHT+IFx+Y86kAQg3tCp+lkyRYenJ1ns51tOtXrb2wDfJ/ON7EhmhRzo9A+jgX7mXFnhM4YOd6kA8g==
X-Received: by 2002:a17:907:96a2:b0:abe:eebf:ae54 with SMTP id a640c23a62f3a-abf25fdbdb3mr715780466b.20.1740829881379;
        Sat, 01 Mar 2025 03:51:21 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-25-102-201.retail.telecomitalia.it. [79.25.102.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75d8e8sm460994866b.146.2025.03.01.03.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 03:51:20 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: dts: stm32: use IRQ_TYPE_EDGE_FALLING on stm32mp157c-dk2
Date: Sat,  1 Mar 2025 12:51:09 +0100
Message-ID: <20250301115116.2862353-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the number 2 with the appropriate numerical constant defined in
dt-bindings/interrupt-controller/irq.h.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/boot/dts/st/stm32mp157c-dk2.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
index 5f9c0160a9c4..dcf17c493022 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
@@ -11,6 +11,7 @@
 #include "stm32mp15-pinctrl.dtsi"
 #include "stm32mp15xxac-pinctrl.dtsi"
 #include "stm32mp15xx-dkx.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "STMicroelectronics STM32MP157C-DK2 Discovery Board";
@@ -67,7 +68,7 @@ &i2c1 {
 	touchscreen@38 {
 		compatible = "focaltech,ft6236";
 		reg = <0x38>;
-		interrupts = <2 2>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 		interrupt-parent = <&gpiof>;
 		touchscreen-size-x = <480>;
 		touchscreen-size-y = <800>;
-- 
2.43.0


