Return-Path: <linux-kernel+bounces-331099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE77397A869
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FE501F261DC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 20:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854813E03E;
	Mon, 16 Sep 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxibS1t/"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DA156CA
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 20:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726519543; cv=none; b=XMq+12PvCSXlDuNLCOosy6cGJSnPRLigy1Ga2LsODYxosNsIt6MgkFND0vgQAz7ffoGDLEy6z05/49QkOB4tDoWnFvn35oqteUDLrd48Rz4oQxmb+0F5LhN+TeQEVptrSAH96AEiHiS0xZYCfFsm8aYd90fb1EAU9c7okptCJto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726519543; c=relaxed/simple;
	bh=IEMrAmiBjvKw8O8F9JUIZi0o8LPAuOjEEr2hekilUOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UiZrcBERWcNTpa6KxP3bsTMIzfxih7j3OZqfusjVpnjyrxS/1Z6P1YvNN2J+0d//uVByghDiR1Jc8Lra62KKuboipxUPmunetsFrjKhOcLviQ1Q5O4gm8Tw1znlHkvhws/VRFdi0U5uoxSzFUmoHeDO4czZRfU/QWuCaYhACfPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxibS1t/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-536584f6c84so6095930e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726519540; x=1727124340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07RrCbel2n57k5JkA+rd7wEQD1Pp3W7MwcNJcieDSAA=;
        b=gxibS1t/Me4W5t5a5wJ96dIh6xe9sRaynOJhsuO0vWOKEB/JdgHRKp/RoOIbPEoVBo
         ezXfCGvVWfcbsYF9QfDxCYLF/Bs1gDg/knKXRFmeLKsnwV2azo3BMsyuDm2g7q/06yql
         mv3c6IHl/HNctVjP/8R13XEhnwXdqJ3qDG44CvBIyhEghkY6QokSTwzRdvYBcXLnHPka
         7VTI1gRrMpL6d3+jWdNNyfvfDadtVBt964BMNXsVFh0vMyvBUcRzsizi0LZrCGdSXc9u
         bGVLirDuVoBKb9qYB8eTxY+YENqI80hKg9ASu3TFANGZh6JWtiuz560xHp9wQvRw5IAu
         9CnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726519540; x=1727124340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07RrCbel2n57k5JkA+rd7wEQD1Pp3W7MwcNJcieDSAA=;
        b=PnLl8S8I9WM2GEEprFLM9Ocf7gzOyliVMsUyCE8YZVq58MVAleKIGsE05IOTtkrsBp
         etecO2WGszgwvRuD5rDfWt4TqpEFeBn0vTKU/KXIYxGnJro7rak4g8+6j38axke897u0
         fbd+XOlNCRa1uF8gXy9JvWntuHSj0RfOBA9sIhzeAcYQ1Tk5JFg2QDlexJDZGjU32502
         4SWomnp7xl8YAlIZ7ss0UuLKjZIqWZroR1Um2OHArmYMy5fk2ZMsVMNDvd75unhs4tuU
         1YPJQgtuAX2oALa6NzNjLrYjUQO4U6nORUrbKC6T0P0KoiEsSNynQD1tPpldzVV9/81d
         GxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAFJyyAlTwIIW1POIbgEieTxiD3KImVPtq/fyThIm+U7a/3YPVHVhG53kAMx85Panb+i8PMPRielnpr3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBR/w9ITfIXoCMH06ep0SdQ7RpLTdCnQx1Jt7kC4cMecdEqgi
	stlx+BgjBWFxb/7RSMwub1k1Knhbbn6BhThLAjrJ1Jni1dB7QOMj
X-Google-Smtp-Source: AGHT+IGBoVGZktyfnJSc0q/3ib+Kll8oaCcvG9CIVVKc1VXar2Wf+ks+DR12B2Ikz4FXjCJJmsrGKQ==
X-Received: by 2002:a05:6512:b03:b0:52f:244:206f with SMTP id 2adb3069b0e04-53678ff5e1cmr8511739e87.53.1726519538654;
        Mon, 16 Sep 2024 13:45:38 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870ad17dsm990738e87.241.2024.09.16.13.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 13:45:37 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] arm64: dts: sun50i-a64-pinephone: Add mount matrix for accelerometer
Date: Mon, 16 Sep 2024 23:45:21 +0300
Message-ID: <20240916204521.2033218-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ondřej Jirman <megi@xff.cz>

accelerometer is mounted the way x and z-axis are invereted, x and y
axis have to be spawed to match device orientation.
The mount matrix is based on PCB drawing and was tested on the device.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index bc6af17e9267a..1da7506c38cd0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -229,6 +229,9 @@ accelerometer@68 {
 		interrupts = <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
 		vdd-supply = <&reg_dldo1>;
 		vddio-supply = <&reg_dldo1>;
+		mount-matrix = "0", "1", "0",
+				"-1", "0", "0",
+				"0", "0", "-1";
 	};
 };
 
-- 
2.45.2


