Return-Path: <linux-kernel+bounces-537759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C6A49047
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771A33AF761
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E4C1A3159;
	Fri, 28 Feb 2025 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loEYDBo/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00412198E9B;
	Fri, 28 Feb 2025 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716759; cv=none; b=iMX13BNSsbTurAzmBL4Q1RfdMtZCdmaXRSxnhU/AiviOmqdsSW/HC9zlrHQvMD+DsrJFRzLPUGk8Gf2oIa/F22GIsNJnDfUCMbNkA9Ags8rizdMh2gvVDNyucotbFCGkk56LV4ZXMHMSQ7IoVuiVIbE5uGHLUG8cP6uO7aYsw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716759; c=relaxed/simple;
	bh=y4hL3tHb9GYf3Yp22BN/113NdRgsnisPVDma5CwN8IE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AUKUA2YZVggFEMKnICnGxGxFMd/8uQnaUh+eGBJGr8Urz8LR/TR7ErTCqfW63OadtFGWDwVvE01idLpc5ZuRkGzvqRdRkvCpok6wc/34oJc0aAj2KmuFcr2iGM3Sg6ekwFl5uq2ELm3fRcULV+ndVDcO/xC16POO2hr4jeLXABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loEYDBo/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22104c4de96so28749675ad.3;
        Thu, 27 Feb 2025 20:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740716757; x=1741321557; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Xiilq0Dm75J5th/0Y2NylH8fDWgiIOPTC9MrBsESQw=;
        b=loEYDBo/4Nicn5kPP3K0bBQwKWMBGAEUeroPDmw8f8rQs8CIQQ+XjP1Wy61YG5Nhox
         NyAlQFd15YLYhShFQF3DgGLrj8mPSvW98b3cfdhdOKsWvUnwbP3kWE6tMbUBxbBBW9C9
         50Ep4L1Jeg6iy1p7u0x7riklbT55l56R60nNGA3rF7Yx7ab2/b7CNb8vH3y9/yEbLNKa
         SMJpFlE7mysRZf6AC3N51v9qjuzeeyceX2ZVFyEfEuUY/P+NuVy+zA6B8lhlqhHBJUJA
         hjpCI7Sy/cnsi0VwWWedsKsODEgYwOcCWbh1XVYS9vDm0NPPVkGpuPA57qzKdmMzXJQd
         Ziig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740716757; x=1741321557;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Xiilq0Dm75J5th/0Y2NylH8fDWgiIOPTC9MrBsESQw=;
        b=I60OKEetdAB44cUwGRtc8HylxYRbjnOOZAyRE2zl+BbCmx3GWSiKckz0eBH9WQAn3c
         8fjZdiALTe0devY4Aa9pbR/P23IRRHGLjUnzNjKF87qX+o7GLP6q9EXlaqtsrp81OIii
         N2px/3d2BR72+3eGYlaCETqCWcya5Fk3jOTV9ZZH/ij/KOpWaCHJYyI2X466a5QJQzsb
         AUcuTIqjqGV7lWu+9qVw47qNRhcgGtCeIBTzGjijXG+/MzKrO3okGRZc4Wuw+sCA/RU8
         aIx7SSWihaY/eVgujCkP+MABWyQBHtGxGjJdkQ8P+bmIgGPPrnrJCc6D5sjk7JlGDlr8
         0mhg==
X-Forwarded-Encrypted: i=1; AJvYcCVrpUhMkRhkYVehNjhGnH+Y0eu7G9g7zzKF4v4s4noffIo7/bwT3H40Uc168pkcUtM4xuTYoDPXV6xkgGHd@vger.kernel.org, AJvYcCWO8faIsIRiJ7rRnSBlcFc9thROblDEFf9Lhh0kElGmPV/wkslLBCvsCmdWxuj+vzUrazn4J/1W4R4f@vger.kernel.org
X-Gm-Message-State: AOJu0YxDjB1m/SKvEuCS5p0HwMysEqNI/UAyb9OSFk5qW7AktSapggL8
	5It+nzAFB7BcV7INgKGGptDl1T5FosPqrIlAjBI0501GlZlKGTNO1yfmyw==
X-Gm-Gg: ASbGncsiyjRkcCuwpCnH4UhhWfhcHZiWeXYbFpms7k0blQl39zO7r84GTuFiCbBv9q+
	bUrNgVNXqIKAMhs/RELe1heLBQtKnPcW+3c5Htr2n6wSePQZpSyIxAJXu/83FEkZeBzuDMYu78r
	YA/4TVWTS+9tsXcE0XCXEmi5HmJVGd00+NR815nL+BjZfAgdcxUKO/LJRuNK0w15C2vZldaMK6f
	JKqVHGJOAiA3dZmI/EvKNmbOXQx1E1Dlvpm/640aIVb4QAxFTM/iNYTCDn2ds1kZ0C47TnjMlx1
	Hs0HCz8ijWoEzE8q+wDvYNficQ==
X-Google-Smtp-Source: AGHT+IFeBzAR6xWeQmNAfZ+GJrvxdPreu7+uqpO6Gb7T3/zhsd0gvDE6M0lVFrM8Kvt+pvkyEuFlhQ==
X-Received: by 2002:a05:6a00:4a85:b0:734:ec1d:2cc4 with SMTP id d2e1a72fcca58-734ec1d2f41mr1165970b3a.24.1740716757263;
        Thu, 27 Feb 2025 20:25:57 -0800 (PST)
Received: from [127.0.1.1] ([49.130.82.63])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-734a003dd19sm2738318b3a.131.2025.02.27.20.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:25:56 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v2 0/5] arm64: dts: apple: Add DWI backlight dt nodes
Date: Fri, 28 Feb 2025 12:25:31 +0800
Message-Id: <20250228-dwi-dt-v2-0-4243fe8647a4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALs6wWcC/2WMQQ7CIBBFr9LMWgwMVaIr72G6QKDtJLY00KCm4
 e6O3br77+flbZBDopDh2myQQqFMcWbAQwNutPMQBHlmQIkniSiFf5Hwq3AXZ2yv9cOrM7C8pND
 Tew/dO+aR8hrTZ+8W9Xv/EkUJ3qbFVitntNG3YbL0PLo4QVdr/QKRXZv9nAAAAA==
X-Change-ID: 20250220-dwi-dt-c9c7af33bd16
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=y4hL3tHb9GYf3Yp22BN/113NdRgsnisPVDma5CwN8IE=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTrIRj7n0/WhF18mWg+qdjxQA8gvt1Qz4ziZV
 R2BWfarCmyJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E6yAAKCRABygi3psUI
 JDBRD/9W8gSW6lX+79iHJI9owGHugB7NeWiPlNECqkp2HsHLiPjNkw2o7shGpHmz0+onoB0uN7R
 KFUAK3oAX868+MYYmwiRSTRm5uYnGJS3RbF7rOXoz3bGV54zYAwQp6XfnAHe4qCBL3pnCswbrP+
 z5Pb+weU7zYj9rGamTdkWn8ckEL7KCFtYzldflzL/mr3bddR8G5PVNlo5k4rtYVMeFmsoGpvrwM
 jswZNkLsTxRw63AKOK74X1c1rrXV8g9RGu+RaL8n62o9SZhEXxHUe8R4wJbseJxcWNTENJYfIXu
 gKA9A3y6XG8CF2oBNnp3AbOTfJ0eZHVs0NHWR7eeDGejuLtkcu8LR89pMNCNB5mUos4/OVUvDqc
 mv0PkWpNrNEkE8E9sdtp2eFmZGzoBwTo85+FtX5cYT1f09yiyXFlsd3Y91jNnzSRXoa/Jzc7j9T
 QwUqoiBNYLzN2PUIqOMblN+ps5/tV/V0lN0+LtTg/wG2gGzlF7uiqVFQosYMlrsmBwQQ8ljxncz
 1Qt0VwOzB8FOBVOy8bbMHbx1uTCM4EuLCSJ5fV4fQ9ZmvKeFwgH4wrPiEtgrmdZ5td0j/4vdR6w
 8JQ7NYUCGiux+CjE5ZQkhUhfk6sap88C84mF1jHcr5kPyy0J9EkPndiE/B/kIYxiPQ1rHc7dGue
 hCb8fHZDK5fbboQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add device tree nodes for DWI backlight found on some Apple iPhones, iPads
and iPod touches. Not all devices have this feature, as some devices
instead have their backlights directly connected to the WLED output of a
PMU or use self-emissive panels.

Devicetree bindings are in the driver series. Last version at:
https://lore.kernel.org/asahi/20250214040306.16312-1-towinchenmi@gmail.com/

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- Fix typo s/iPad touch 7/iPod touch 7/ in commit message.
- Pad "reg" property with a leading zero when needed
- Link to v1: https://lore.kernel.org/r/20250220-dwi-dt-v1-0-d742431c7373@gmail.com

---
Nick Chan (5):
      arm64: dts: apple: s5l8960x: Add backlight nodes
      arm64: dts: apple: t7000: Add backlight nodes
      arm64: dts: apple: s800-0-3: Add backlight nodes
      arm64: dts: apple: t8010: Add backlight nodes
      arm64: dts: apple: t8015: Add backlight nodes

 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi     | 4 ++++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi        | 7 +++++++
 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/s800-0-3.dtsi        | 7 +++++++
 arch/arm64/boot/dts/apple/t7000-handheld.dtsi  | 4 ++++
 arch/arm64/boot/dts/apple/t7000.dtsi           | 7 +++++++
 arch/arm64/boot/dts/apple/t8010-common.dtsi    | 4 ++++
 arch/arm64/boot/dts/apple/t8010.dtsi           | 7 +++++++
 arch/arm64/boot/dts/apple/t8015-8.dtsi         | 4 ++++
 arch/arm64/boot/dts/apple/t8015.dtsi           | 7 +++++++
 10 files changed, 55 insertions(+)
---
base-commit: 5744902a35798e516def50348356f867a6c1f1c7
change-id: 20250220-dwi-dt-c9c7af33bd16

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


