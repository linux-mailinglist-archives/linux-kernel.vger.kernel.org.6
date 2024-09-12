Return-Path: <linux-kernel+bounces-327020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB8976FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CFA283529
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE7B1BE854;
	Thu, 12 Sep 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afFYchtH"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8313A40F;
	Thu, 12 Sep 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164116; cv=none; b=rKxRfgDwhZd3eLBT7/8MdYCN04Sg0XXiEneVLyTx9OwgHp9gsKECR5pTDjsmnw49QUL8PrKeANkNQNIuPH40mFNOKxOnQLZfWhXCsbGUQ9bmcD9Dyy+7B5KVGVAIbCKtUgDtuCG8siUIP0yZYtmoCSVtiUSmfA77mH0sVnRSXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164116; c=relaxed/simple;
	bh=hnDHlu488e16aWXuRjYIET5YoiTNALIB7GNheK2RQ80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RuvT8NeT/BkngsEPqMftndbweGplRS6dWn2iEFJc9zFmylMOPQRFe3S2soEKx++EChJsWZEj/VViacZGiPzPZVSfzYpT4X4Yy+7U590FTlR1cHNA7EyzCYvDhI/la7Vl6Hhy4DwE+Ccrjv+AFvOp3dnC5SLWIWD2RC2C3qvlPCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afFYchtH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20688fbaeafso805395ad.0;
        Thu, 12 Sep 2024 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726164114; x=1726768914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XTzb4Q0LRCOZctNYVbt3pa5aTUifZ6PkYnltkFvJtsU=;
        b=afFYchtHoaHjqtRKjfoN7VHDtN2UsJ20CZgUwpgDvNM1euL/Iz0fiwunMQfWmCdqzH
         axszuNfqa13dYXGbMy60Exul+yisbQJZpJu5lXba0K7itf1HB+32FtSQdtuvNQ3Wad/a
         pw1kQzpbGPRDS5BLVE1wtShhGc+gY40cWtPZYIcMBFj8rGcf7gCM/Shiwc4+3zx3YWxO
         SqJmyrfdox4ba7hHOrNIYFoU6BP6EiqzEHAQUiAB43k+HudX44PY7GJffW8+liR7v0Ig
         eNd3Vq8tKi9I+5nYM30PSmBjhQ6DhAy+n84M2RHWO79b7OkApkNt4dPH1FgHuksFGVIk
         QQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726164114; x=1726768914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTzb4Q0LRCOZctNYVbt3pa5aTUifZ6PkYnltkFvJtsU=;
        b=bLXdtf+u4xz16jluQmeUMyn2yvO42HM1BAXVp722WQE4jltJ6c5z/qYNv9l8CIDwKn
         SIArMN7c7ztJveV3iTYThnKu6neJ9SKVIWm4If/MsKFhameDVjdH3cHpZhSU3Tcbt02B
         5jh6NlxL8F7qcki6Uh7KWURZN+1TbeHhezovK6dXpIDqeTPgwEd6dcW0NTzMsDY9365a
         ua1AEcPezS68XPCZ5MY0igvMTljUktfTSlruPOh3GxKgnoisY/aKF+/qvF95jGUQYwnp
         x9fIpSaW3H7BoPgQt40MK8YJrgy27sJfVWsiKnCLd55X0mHnsbQ0J0YTTPWfG/4zGMl5
         EDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGAV6l+B2d6vlWgdwALIf2FlLWsg2zkN1UTBRiVUXUtLuUJXOvMBgLyYXyotaq1/6wgKsIx9+Rkyu2@vger.kernel.org, AJvYcCWtbB9ccQS/cd0IUC14ZD4PL49Fy1nLmjves7mErnczqjc5wf8OPURRZA4z64XNnAmpSMVrfdQSjNXMedMI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuf16JBbumV5H2CqzwgP4mL9MlWXYomEl5UmW4aZCLkyH0AfSd
	WzbXzZUjkwwikJXMKvzewv073M+FbSmAvJkuEpOBRFpiFxAwCRMJ
X-Google-Smtp-Source: AGHT+IF6PVoW3GzdEiQjDPGaoS2GOiZTQP7EqQFVG64ohA0WAsC5hCjj+1mrSSKD0YOCyPD2npDqMw==
X-Received: by 2002:a17:902:f685:b0:205:73e5:4d7a with SMTP id d9443c01a7336-20781b46c0fmr253785ad.10.1726164114128;
        Thu, 12 Sep 2024 11:01:54 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b01a0d1sm16759705ad.277.2024.09.12.11.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 11:01:52 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ondrej Jirman <megi@xff.cz>,
	Chris Morgan <macromorgan@hotmail.com>,
	Alex Zhao <zzc@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Jing Luo <jing@jing.rocks>,
	Kever Yang <kever.yang@rock-chips.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Joshua Riek <jjriek@verizon.net>,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Designate Turing RK1's system power controller
Date: Thu, 12 Sep 2024 11:01:48 -0700
Message-ID: <20240912180148.205957-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the Turing RK1 board reboots when told to power off.

Resolve this by designating the RK806 as the system power controller, so
that the relevant driver can handle system shutdown requests.

Fixes: 2806a69f3f ("arm64: dts: rockchip: Add Turing RK1 SoM support")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index dbaa94ca69f4..33bd1bce2eae 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -289,6 +289,7 @@ pmic@0 {
 		compatible = "rockchip,rk806";
 		spi-max-frequency = <1000000>;
 		reg = <0x0>;
+		system-power-controller;
 
 		interrupt-parent = <&gpio0>;
 		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
-- 
2.44.2


