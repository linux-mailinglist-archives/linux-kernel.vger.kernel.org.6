Return-Path: <linux-kernel+bounces-197881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F191D8D7050
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC97A283F8F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B64C152184;
	Sat,  1 Jun 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNO6tR3R"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E48248C;
	Sat,  1 Jun 2024 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717249960; cv=none; b=uCmS82WhxQfngLEBEXOxuAedYjsNHmrrUJ8TQU7RwbzCTKdWwyGOtow2PVeVx41SzabRwlsexUDtXGdAc5kQrdEl5Y0eG7wExHHnYhVgjHucv4psmUt/oytoTEzr3KBwCOB8wa9K1dIozXdNzpVMbmM9XDpOa1qftoYpUD35Ogw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717249960; c=relaxed/simple;
	bh=x97TGYicuAOIiNkkbEMugsrQH1Uh8scFHklNqOBKDT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kxqqn6FpUfGp0INhvMhASSwHLgF5CS/8gRB37Sv9uwLj/h9BS7dW2fSHwToQ/K/cY0Bh1OOpXffSKlvngwiU9QwTxmtf3ehiHQJ5U9BY+zm4qmWMB+EjzZ2T2B5Jn/nRyziJC2zDEhP4sVdibhfG/MjTi2irE1ju4xYyCOwdRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNO6tR3R; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e9c80adc25so138001439f.3;
        Sat, 01 Jun 2024 06:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717249957; x=1717854757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YSOWAUY88oC5lW5rvGSdvx6UaNHLnsYyAlMhcv2+2no=;
        b=kNO6tR3Rqsp8MMDBY37XsmLAGnv4bx93iie6DG9GENgxOFrVQtCZok9KAuFOSUFnDN
         2gMfmRyKeLjOMGYznW4JDKNXSj7UXkWJrnXD/w8ir93Sp4vZdCjCoaixBLg4IRuqRE+F
         pu3QHW7jGguRxNht/nmln21yPxoTlKoT6ns4CMaSsr5fjblaavh0N4p5NWw9kPd3kwh2
         a2U2EXeSb9OFM5AO3oGleUUx90ThtuyuGFkkR1CV/erqrbwq5igZUl8tRION7hq8/oG9
         WHpNjuMWNHqVf97DKXQl2KhRmXYvRhowjfpDXdnANt7oCnVfhMKF7rQfXDtaEymGS96U
         nc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717249957; x=1717854757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSOWAUY88oC5lW5rvGSdvx6UaNHLnsYyAlMhcv2+2no=;
        b=Xreye9vSMgfW8PyJV36BqRGgPtes239SZUwDlcFxvo2/Cjv4hQ7y0JeR5xLCzkh/Ex
         0pmjUt6CM6Cir2R+r7qejd3iqMgYR8vkOzntPm98jNtT/brCx3hTbrJJ2kTQ5jdhsK4w
         NQc0gGyHZrDYyOfSzTyR3PWmT2pllA+5QOVmO6pEfBrZpBJt4MReByzi+FTeSKhNTR3R
         u24j++cgkCS6upfVxyI07pPj4kBopTN2kYChk1SLRM8b72USmT3KNXe5ZZN1aPwNZ/Cu
         r9da+GTp1rbfBjROEU6QxJPQVfjeTLDM3tjRNWCsZUlb+p7IG4QNhwpfkq3GAR9m8Bz5
         ga+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhBR/z1kdxsnovZiH5f6DTpdi5GGfRUsdA2Y12Aikd6Ab4UCwBLIz/juIHCId8NSdMhTJyOTjRJLHuojoJ0vACwpS5ROE3gSAy/GzYaYv9p1CY1SfK/cI+Gw565Wb8BxxJGBr6/8IIMA==
X-Gm-Message-State: AOJu0Yy79NEsPP+Doah/1SsvogGs7fVjwwcBBwYFDarihcKF5hI88wPX
	T+9e7HbU8zBToZi2rT0uvounnC7ck5DsWJ6+I8QULuB0jYHyP3gzfbgiuQ==
X-Google-Smtp-Source: AGHT+IFu377v3BUIDc9piHIID8NWcbvXfFBcxu9yZ9fDFgRolnum/XAZM3rhhAySVW5+a3c2HcN5tA==
X-Received: by 2002:a05:6602:2d88:b0:7ea:fadb:1cd5 with SMTP id ca18e2360f4ac-7eafff2b8e1mr639467839f.18.1717249956993;
        Sat, 01 Jun 2024 06:52:36 -0700 (PDT)
Received: from aford-System-Version.lan ([2601:447:d002:5be:e0b7:c613:ee:e8f3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b56e7824d4sm556349173.172.2024.06.01.06.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:52:36 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/2] arm64: dts: imx8mp-beacon-kit: Enable ADV7535 Hot Plug Detect
Date: Sat,  1 Jun 2024 08:52:28 -0500
Message-ID: <20240601135230.89980-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DSI to HDMI bridge supports hot-plug-detect.The driver
supports shared GPIO IRQ pins, so it's save to enable them
which allows for hot-plug detect.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
V3:  Update commit message, no functional changes.

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index e5d3901f2913..da836172ae46 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -304,6 +304,8 @@ adv_bridge: hdmi@3d {
 		compatible = "adi,adv7535";
 		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
 		reg-names = "main", "cec", "edid", "packet";
+		interrupt-parent = <&gpio4>;
+		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
 		adi,dsi-lanes = <4>;
 		#sound-dai-cells = <0>;
 
-- 
2.43.0


