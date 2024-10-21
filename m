Return-Path: <linux-kernel+bounces-373545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF39A58A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E210C1F22AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593C517C7C;
	Mon, 21 Oct 2024 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnScaqx5"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD99463;
	Mon, 21 Oct 2024 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729475511; cv=none; b=pwHeF/gY5TZfi3ZUhrh16tmuC9r4UTn0ROEPY1KES2oq3aUVM8pVAKXNXs7BEDV1J8X2tuCnGVBn6483sdPMKLlXwZ+dZVy1DUn6P9eR8Tc6gMV5nP49UzgZSG7zXHI97N8E41LtlKl6QKU4rNSZst/L8xrvgZE5GqAplhhkYMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729475511; c=relaxed/simple;
	bh=Cwq503/UWDDXDldw1Nq07IcX4gW8nBt0dj17dfpUtGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sf7TBoIB9wo6qXjwM17Kc3e3URrRRUbSfi1dzy4qkeFCYu55Hqtf1St69WdyNXbYMde31sGqX9HvCyfbl+Acs2ts/Z5qKdx5cw+JoWgRCRT6bgM11oI7/Fb8X1doyGUthyv+s248AO8oQ7V9sLDtGFTXaKMumP1W2CweijK9yb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnScaqx5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea68af2f62so3083819a12.3;
        Sun, 20 Oct 2024 18:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729475509; x=1730080309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2lZ90rM/yl95gasunq8MHFMTMKnOJPDjLru9yVW213o=;
        b=EnScaqx5OWM63cXnG7UzhBmCwSYlzzElRuWTKQPkGink5+PdN5Xvd9lPmKPIXGt39U
         9r/2iAIipKyXTVqCo+zE53z61pwleOBZFcYNvJGFpF0833/YJf4LenVpsloyiTRq0+dg
         vSnvGgi+qQ8WRTQkDOSF7C4B0ZLxUruRlss+dJw3yH/Z60bvxzjgmPkHv0H9+ZtM/Xjb
         /CKKE9u46tKPuI2XkbEcUQ9GglCxftz6tzDHRdGwkih9zzzsdDaoT2X2TSZuf4khkUUg
         M7zRx8/9fUNAUp9LcKa5R+kn+L7x5mGshGM0g25TcbbQdesVRV4B3bEKHD6XkdFB7kL0
         EuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729475509; x=1730080309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lZ90rM/yl95gasunq8MHFMTMKnOJPDjLru9yVW213o=;
        b=ciykf7zyoz3oEiWkUM3PpFscv1HhviycvsDqujjMoNVcMTHufIfRR9Wy+5hu1OIr7J
         5pmET/hv24qmAQIv51BXp6X6LnXCLSgPsC3pCdp2Hqx8eTdpEB7rnT8pdtifFc5du8Xs
         b+g38YxyYV38IVQcA/Fxgzt9t9o1A4NewiLw+dfZwZbSCdlkImICgE6sf2O6/78Wtao5
         1JUoaDSj3zDx6A3094p/JddgYIGdlWzc4zl7auZttw3qpCPqkwSuotfcfya9aRKIJxYS
         1u3AXn3hzxh/UuR5QFTTbRCwGo1153jikTfZYSowA46E3hao1vYf66OvA/9Ce6q7bCMw
         ok7w==
X-Forwarded-Encrypted: i=1; AJvYcCU+iVe8pV5dYnx9Q6O/KKB34ewy4+sNzG4h4TLLE9E5wi8i8mcyPuZGbXkoERX1Gpa7/nzH/D+TP1ZFblg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUiYHFmK0q2v0BtQNiHqfNFCve6UA+qKdxL6/VEg+TeLsu6KcT
	8aUc5Ukl5+ndBqX9diXga7U5WsDrbWq8meNDnpcJx/4qk2y8UtOl15yY+g+a
X-Google-Smtp-Source: AGHT+IHUMxAUf7zs1ZStiEaTzi+8zOdBCaWC9s2oqqARtuMi42TKkyKkVInMzf79Kn4CD0iYuUi9zg==
X-Received: by 2002:a05:6a21:6e41:b0:1d9:2954:5817 with SMTP id adf61e73a8af0-1d92c50fef3mr16322541637.23.1729475509143;
        Sun, 20 Oct 2024 18:51:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec141505bsm1747413b3a.219.2024.10.20.18.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 18:51:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: devicetree@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM5301X ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: meraki-mr26: set mac address for gmac0
Date: Sun, 20 Oct 2024 18:51:47 -0700
Message-ID: <20241021015147.172700-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently this needs to be done in userspace.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../dts/broadcom/bcm53015-meraki-mr26.dts     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts b/arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts
index 0bf5106f7012..08abfdc63d18 100644
--- a/arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts
+++ b/arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts
@@ -59,6 +59,9 @@ &uart1 {
 
 &gmac0 {
 	status = "okay";
+
+	nvmem-cells = <&macaddr_board_config_66>;
+	nvmem-cell-names = "mac-address";
 };
 
 &gmac1 {
@@ -102,8 +105,25 @@ partition@600000 {
 		};
 
 		partition@800000 {
+			compatible = "linux,ubi";
 			label = "ubi";
 			reg = <0x800000 0x7780000>;
+
+			volumes {
+				ubi-volume-board-config {
+					volname = "board-config";
+
+					nvmem-layout {
+						compatible = "fixed-layout";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						macaddr_board_config_66: macaddr@66 {
+							reg = <0x66 0x6>;
+						};
+					};
+				};
+			};
 		};
 	};
 };
-- 
2.47.0


