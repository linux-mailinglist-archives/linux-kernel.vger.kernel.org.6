Return-Path: <linux-kernel+bounces-427730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4069E0573
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FC616D90C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72AD20DD42;
	Mon,  2 Dec 2024 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="FU3oBlUp"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13120CCEC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149947; cv=none; b=LhGM7zt15BDAhW9LqZ/M5havQAZCUohuh7LheIvIePpCD02c+EBXlP+djqohFcdeiiTFzzbPginoeN7rFXEc7YLyCXLGejyGO+4fibW5tcvTh4cE8ghgTnZhss7vx4jGvi20bZVJdcvBZOie/n/KxS0SqTzHVUrUw6STtxe7vPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149947; c=relaxed/simple;
	bh=0oZ971I0wmrs4nr2rUYR0k2yCq01uDEq0P6ftRI3PNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFstE1JEJnYghzxyDOdxI6lvCgjKVhBkXgX//lc2xZWaKo3xZ3pnEfvenZXF0NZbRy7V6w2niuXwO8SDzeRf8Zw6DOBTX4CtLwTbmc6agOBHrNSlSPwgsFT6rOGBBFmdPmGUjtto/FqzpobPVMahJbWBEJ5eARFsClEn7HhQUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=FU3oBlUp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a044dce2so54635375e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1733149944; x=1733754744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pli6SsFvDcPYaCKSCtuylkfG7oHLkLI1T7gsEQivs80=;
        b=FU3oBlUpxVravc1Nj/VlpDsUlZiMM80dWlzXJq465hCTejwJHscMBaJCIea7BBKeRN
         yopyw+OTOjWrtx3gxBtiWz0/wkDv4RWEy25DDFHc68ZaDpV/ut1FIBoO1HTFVTiZIB6a
         uTfPe1kVaw88NedHiXXsSFlaFz7uSHlC163RRgLb98hKnKtkDxi1QeAXwAZ9dPCC30+y
         ION1qa1AqrmuHslsdmSNID41P/qqG/7LoGginMQD4AUFLPO7AT8uidC9puuXcoSFDBjH
         H+WGcIM9UR13Mx794JCyMTdRdks52MSv4IRPqpRtlu4n2pQtdDh4UNPnDFta3wEJq49G
         jdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149944; x=1733754744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pli6SsFvDcPYaCKSCtuylkfG7oHLkLI1T7gsEQivs80=;
        b=G45l+d0h/h4+QVli/KfQoABqaCLyVzu7C/A4e7lT8KTxCJE9b86aQ2+APVZUnGcEaQ
         7exQv2PC5hcnXwVakT0aCLDnkcca6fW9SHQQ0fG59oooUpHw1FTCf0RaBwAD8R7jbxPI
         UKvidvvGOnFgmqVyEDVLXbU99r0+m78vNjybc/5xz1x8y1MYz183FnBcAmbzm1htuiKg
         679sdlI/Xv+MTZycYAHLljONSGMEAD/iXrYRVr5QsPPKTPGKw8lZSd/swjxUGLWQpK+M
         zrnFTPRrLrLFV+h+e1dpoWIfLA0v7RYqN3pmCrtX0RYKr8+SDNdy03oxmxVih/EPwy5+
         rR0w==
X-Forwarded-Encrypted: i=1; AJvYcCUNImAUFPlvVmMPGAScN8LttM7cAd+oOXyz8SuzT0UEoJDTVtBH+pcXR3CXomyqg1onlqrrwcDJEOKxl28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5CXsjHBVI+nmQPB2Oi2orhnQR0KgPf1+qYeNeAjYKJH+iJ3Fz
	7ZMs+v8ZGiPcLYYvB+prOpivHixIlISlgAwfn0YDfAIuZ6JIsF9a6LUD67ZfjhM=
X-Gm-Gg: ASbGncvjSyvc5MxJzyflWhjQD1GPxWR77Q0c4NrHDcIhR5Ramm+AYaMowaBwUU4SKsK
	5P5vMu49SJmq2NXya/b5QAA4sxOPlfaLsa2PeQqxi7z3yh/CNBa8AzyHyyEx65V1LQ4IyouQh6r
	0WkRIjQM5b0bi3XYitxeeSon4py63TmiS5Unqb+KKxzZaHaLst8FiVzl3byL+9wJMTpJw6CnvH6
	YQ30XZ0zOUQ0dIW++SyFtVhnJIF9yiRNy5Bh9TYPw==
X-Google-Smtp-Source: AGHT+IFok6tkFCPxh9TckNxxVOqWD00WXYrj3eZIwv/5rIdvTJ6mEyRfzTjnuA5/i326onD32S2G0w==
X-Received: by 2002:a05:600c:4686:b0:434:a986:11cf with SMTP id 5b1f17b1804b1-434a9dc3030mr246706275e9.8.1733149943483;
        Mon, 02 Dec 2024 06:32:23 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm188429555e9.9.2024.12.02.06.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:32:23 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 02 Dec 2024 14:32:00 +0000
Subject: [PATCH 7/7] arm64: dts: broadcom: Fix device tree errors on
 BCM2712.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-dt-bcm2712-fixes-v1-7-fac67cc2f98a@raspberrypi.com>
References: <20241202-dt-bcm2712-fixes-v1-0-fac67cc2f98a@raspberrypi.com>
In-Reply-To: <20241202-dt-bcm2712-fixes-v1-0-fac67cc2f98a@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 linux-gpio@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

Resolves the issues on clocks and power nodes

Fixes: 4254a647b6c9 ("arm64: dts: broadcom: Add firmware clocks and power nodes to Pi5 DT")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index fbc56309660f..26e05601416f 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -66,11 +66,7 @@ &sdio1 {
 &soc {
 	firmware: firmware {
 		compatible = "raspberrypi,bcm2835-firmware", "simple-mfd";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
 		mboxes = <&mailbox>;
-		dma-ranges;
 
 		firmware_clocks: clocks {
 			compatible = "raspberrypi,firmware-clocks";
@@ -85,6 +81,11 @@ reset: reset {
 
 	power: power {
 		compatible = "raspberrypi,bcm2835-power";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		dma-ranges;
+
 		firmware = <&firmware>;
 		#power-domain-cells = <1>;
 	};

-- 
2.34.1


