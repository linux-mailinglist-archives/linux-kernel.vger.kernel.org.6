Return-Path: <linux-kernel+bounces-293780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D96958490
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCCB0B21503
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD018E025;
	Tue, 20 Aug 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUJokTUp"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909118DF66;
	Tue, 20 Aug 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149875; cv=none; b=edty2fgBzO1zYwWjNdPHCN0pbVaRGASlhhB2JXyKu9ZOIx21uYSKKQ6kbVty6vtMVuWKL6a54tRl+kWlaaZdkEneC3WspB2TLotvWy+sD+K4t7vaJSuf0Npmrr6X02/A7wWTSY0uQknv4I2thjntAGL6wsa4vSCme3vNaZ0oxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149875; c=relaxed/simple;
	bh=GOQzYW7cugZLSITzWLBLjM26U+sg+o81mjE67KnNXHY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFo22gVvEw0yam0wWkz+pFzIa2Qi0bGKBaYPiyQIx8OORsaS1rezt2T/1NTc2BQFo20qPyOvJLNYX7Lqcm825Ldusjj4PY8CPn017IhCozHHUUtlwrEq1JStLBgQy2GlxYZxdE8YtFy+Xrsblj9XyBoGhR5QaIFo8XfE7Ty7EYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUJokTUp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20223b5c1c0so18682545ad.2;
        Tue, 20 Aug 2024 03:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724149873; x=1724754673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTyPLFrq0EUm/GtouTOsZKz2XgR6IlJiL/XQEMTvFnc=;
        b=ZUJokTUpjZUs3QMPvNdEdIWzMLHMOavLyCLu2pOuvMPco2fBqbaUQ6cMFNu38+1Ucy
         13HputPUzf0aqqXs5OmUMwwS7wY8DPHwUEcvzbRhy1o9zwfx/z541+Vgb9CEpzWtTqG7
         fKUYwv+WRzA7JBIcT1Kvjc4sA+btwB2YzzdsfTTuh9QWm19J2eDuol+Gtl3XLtxyISyY
         0ifFHsQlOcpmtdpNW9loJmLXsEqvIe+nqC9n1Oxexaa++U9Whj4rluBjEENz1MYlseJ/
         2ugeisMDDVboMdMQ1Qtan/9LaFGhiT97MriY9fR4lYqGVVPSu3kyoTeXErnkBr/nkW3Q
         XzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724149873; x=1724754673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTyPLFrq0EUm/GtouTOsZKz2XgR6IlJiL/XQEMTvFnc=;
        b=Q7X5oFrl94tBiXAn7V//QAweWUiiEtmnadKo1ACL+tYOmrSAH4Fqa9Sg/sZGJfqW+B
         enP1QI/wswDUQ6AbuUI/dApc59mJEzqGHDfVX6FcEaCSlkkcoVsnVlISqmK6ru/qAn1Y
         DegkziRI/fwy8h6jSQZ3tDlJbpftiNpzqjHnqCZxN5Zn+VgsJ1A7fSj7Au1zu5U9U92j
         6brwuJZKIqz3uW4e9wy/oL3X0vW3K1RUIldJ1+C4Kbrc2l0xHnZSZf8tVGG0LT8hseZV
         zG0RbfsinPexBnInxYQIUSxjyVKUrdeevXvrVF3PpU1Gr62c+c3U7KfLBeNVPV4G0+7g
         YoXw==
X-Forwarded-Encrypted: i=1; AJvYcCWEoMFmYVYrWCNBd8si09E61yJGJCVZ1EJTzKN8GEQLqQaWHENqb0vk6180SmbVW+JT1ASOmQaS+vu3IAK4rrtCkROjGZq7G86n6YmjIMvCvh7TQoFgK7WEIAXVfEJVp5zpOskRslV3gQ==
X-Gm-Message-State: AOJu0YwKHmsMwN9XjDPDt0V7JC8HhIPyE3Xp4uLuyCgNaPrhm2zBfTVZ
	SA/nr7ZV38v29YLEle3qkM2OkS85bLvjBjBrZi3uNXlsmoVQ2k2V
X-Google-Smtp-Source: AGHT+IF28HPdbzKluxqfocEuK8zyLeXo+mM26BKkQHj+7PAhu+8wajGr/92NbNQoZbYgiqDyMz8AKg==
X-Received: by 2002:a17:902:ea0a:b0:202:32cf:5dbe with SMTP id d9443c01a7336-20232cf5e3emr64763775ad.58.1724149873281;
        Tue, 20 Aug 2024 03:31:13 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02faa5dsm75444115ad.2.2024.08.20.03.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:31:12 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: dts: aspeed: Harma: update sgpio line name
Date: Tue, 20 Aug 2024 18:29:03 +0800
Message-Id: <20240820102904.1756785-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240820102904.1756785-1-peteryin.openbmc@gmail.com>
References: <20240820102904.1756785-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Yin <peter.yin@quantatw.com>

power-card-enable
uart-switch-button
power-fault-n
asic0-card-type-detection0-n
asic0-card-type-detection1-n
asic0-card-type-detection2-n
uart-switch-lsb
uart-switch-msb

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts   | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 92068c65eae4..9db95a791128 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -566,7 +566,7 @@ &gpio0 {
 	/*B0-B7*/	"","","","",
 			"bmc-spi-mux-select-0","led-identify","","",
 	/*C0-C7*/	"reset-cause-platrst","","","","",
-			"cpu0-err-alert","","",
+			"cpu0-err-alert","power-card-enable","",
 	/*D0-D7*/	"","","sol-uart-select","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
@@ -585,7 +585,9 @@ &gpio0 {
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"power-button","power-host-control",
 			"reset-button","","led-power","","","",
-	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
+	/*Q0-Q7*/
+			"","","","",
+			"","power-chassis-control","","uart-switch-button",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","","","","","",
 	/*T0-T7*/	"","","","","","","","",
@@ -685,7 +687,7 @@ &sgpiom0 {
 	"FM_BOARD_REV_ID2","",
 	"FM_BOARD_REV_ID1","",
 	/*H0-H3 line 112-119*/
-	"FM_BOARD_REV_ID0","",
+	"FM_BOARD_REV_ID0","reset-control-cmos-clear",
 	"","","","","","",
 	/*H4-H7 line 120-127*/
 	"","",
@@ -716,9 +718,15 @@ &sgpiom0 {
 	"cpu0-thermtrip-alert","",
 	"reset-cause-pcie","",
 	/*L4-L7 line 184-191*/
-	"pvdd11-ocp-alert","","","","","","","",
+	"pvdd11-ocp-alert","",
+	"power-fault-n","",
+	"asic0-card-type-detection0-n","",
+	"asic0-card-type-detection1-n","",
 	/*M0-M3 line 192-199*/
-	"","","","","","","","",
+	"asic0-card-type-detection2-n","",
+	"uart-switch-lsb","",
+	"uart-switch-msb","",
+	"","",
 	/*M4-M7 line 200-207*/
 	"","","","","","","","",
 	/*N0-N3 line 208-215*/
-- 
2.25.1


