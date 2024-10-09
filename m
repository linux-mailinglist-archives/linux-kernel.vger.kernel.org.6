Return-Path: <linux-kernel+bounces-357929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A94199977EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC211F25282
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C101E47B3;
	Wed,  9 Oct 2024 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJF1U9WD"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB01E3DC0;
	Wed,  9 Oct 2024 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510675; cv=none; b=ftmj1qJAI4CyVy5shYLEdoVQTKhZ4FCV+q3EU6gRN8odlTcsWy97feVT6r3zRkristgJceG218TdPGHrdOfxUuSj/ZE+5sUyLBHqnsV0s2F9H/BTbLyi6QDw7qTA2PDDYWkVE8cOgQ7Gr4xeJNtaC1RI5B82Ww3c4EwEyPDRM+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510675; c=relaxed/simple;
	bh=rriGjK0Qsui0z8FOUhESLDFrd94RUi02X72fhkyWP8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMwWIXCXiUzqoc9n3XGZK4Odv+S9DUmwg9gEPXZVna4FZF+Juoe83BxF5hTARMBRyWLswQravG0V7QPXH8czDPZYA+Dc2PitIQX2XqCZfCLiZWCQ0tmHqF9PzkCLN2vC6/pG8YqPAIKjdbMSDFlagSoqKrW5xhD60ZS3h/PTeGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJF1U9WD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7163489149eso194331a12.1;
        Wed, 09 Oct 2024 14:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728510673; x=1729115473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sol3W8UFrRCovXlLUgHlM7OspHqVODPsgRHoBONpm0U=;
        b=FJF1U9WDifsBFMcPHV45Wx2yroXGlx9I/GUrRx4okCxCLCKpexw88q9Z+tNNjflizi
         yVzqy5B6br+kHfTWhYG+z2Lvic3LDDchWfl24PhXVWPDmrPi4AIpEGpzOi3u2blv1uYE
         h3s7dXxM+KrwuPBtD1HX948qIgI9QJNn5TXewdutKf+1YltR7klt0togmFdvrlQQ8iUf
         p+G8+dkvBWi5t4JojsV8CJIcXX6/eXyLli2SL2YZ2l4Y0G6UKslm71248GKoHdq/QvLZ
         jpOaTKNyK0qujerFNi5IkKs0ELBJs56/TGMMA+iWmnvJAfEe2ArPG9Te6AcRfnaSx51N
         uIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728510673; x=1729115473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sol3W8UFrRCovXlLUgHlM7OspHqVODPsgRHoBONpm0U=;
        b=nvG1SuQ9BpolSbobJHmA+Vi6ltQD+RWomqXs4Nlhg/BP973weJMP7DNvmGxAFJVoi5
         Df4eTNqOoUkHcGCAhLFcF67K5bc+m2l1gyoYftP5gW+L0Xxs49b921B3CSYECLqmABI2
         btdxYxONzSMKCGIoOOpZ8J0Bwic3JPUGvoO9PI/rAhKh1xhS+KzeK32IZGKB74vnxO39
         emJ/dOXpFivwx7xUpMcd/kh3vE/tkeDZWlYSAUuTdD/0NztS5yJps7LUsc6dxRAn/yMO
         BUd5b+/7LvSadN/9Jwu83r1gy0/igmvjVGBO629sNrit2f1nBZ6ckctLThl1UIrEZw8v
         +tlg==
X-Forwarded-Encrypted: i=1; AJvYcCU6+CMYbd9ZkajB34BNSvmpvwDtugVy6f2/D1yHEBxXXsygHye0yVRrRmWK5pe18BR5XFOxwGA+L8JPdQob@vger.kernel.org, AJvYcCVDOMMglurXtQ+/nkOldHAPPWyJm5ZFg+vy+62UsDtMjWhna/DOzdkQstFP0zHflcA7/vXVS6V4PMI4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/z4Muk+T6TlAadScXK9XUsrmYY32EVs+6/xSxJxGx0XRyUYe
	kCOwzfSjqxgSt4xEluomo9AJ5avcyiNz9W7LVgLMs9srCDKUt4oi
X-Google-Smtp-Source: AGHT+IFCMFQjQCs5Mduv7g2DFaLrTlXLCKgUXJHSGmeSMjL4kNtOPHyYzgo94KQARP/OLNeiSkbv8w==
X-Received: by 2002:a05:6a21:a4c1:b0:1d2:ea38:39bc with SMTP id adf61e73a8af0-1d8a3bffb85mr7834663637.11.1728510672732;
        Wed, 09 Oct 2024 14:51:12 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833a95sm7651847a12.52.2024.10.09.14.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:51:12 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 3/3] arm64: dts: broadcom: bcmbca: bcm4908: Fix Netgear R8000P partitioning
Date: Wed,  9 Oct 2024 14:50:46 -0700
Message-ID: <20241009215046.1449389-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241009215046.1449389-1-CFSworks@gmail.com>
References: <20241009215046.1449389-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we have just modified the DT schema for BCM4908 partitioning in order
to accommodate `nvmem-cells` partitions, the workaround of using
`fixed-partitions` is no longer necessary to pass the DT check. Promote
this partition table to full-blown BCM4908 active-partition detection
and remove an inappropriate `ranges` property, thus fully complying with
the schema.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 .../arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
index 999d93730240..23adcfd52843 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-netgear-r8000p.dts
@@ -139,7 +139,7 @@ &nandcs {
 	#size-cells = <0>;
 
 	partitions {
-		compatible = "fixed-partitions";
+		compatible = "brcm,bcm4908-partitions";
 		#address-cells = <1>;
 		#size-cells = <1>;
 
@@ -150,7 +150,6 @@ partition@0 {
 
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0 0x0 0x100000>;
 
 			base_mac_addr: mac@106a0 {
 				reg = <0x106a0 0x6>;
@@ -159,7 +158,6 @@ base_mac_addr: mac@106a0 {
 
 		partition@100000 {
 			compatible = "brcm,bcm4908-firmware";
-			label = "firmware";
 			reg = <0x100000 0x4400000>;
 		};
 	};
-- 
2.44.2


