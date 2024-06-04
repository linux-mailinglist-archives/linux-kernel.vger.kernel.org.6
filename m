Return-Path: <linux-kernel+bounces-201086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8828FB923
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE511C225CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3292F14883E;
	Tue,  4 Jun 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXTJv7xD"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BE149C50;
	Tue,  4 Jun 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518876; cv=none; b=m9YiYFq4YPF6ty8Y4cesojHirG3TIpJrxg3+ZHX8+8voIKlDztK1+qUjLv6GLdGwoviLR8q61IoR8BanEIX8BfrLikpk6aR2aolfSze0G7pSlFBNGxOc6CgnGq8hj0X6KwD8tWXbpgCwnUKo3lViN6mKxXvTIWS+8MnqeGKZWJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518876; c=relaxed/simple;
	bh=4uSJyZO2PGqasvVTKyVYCRMXP+1Rum4qg4++cW6PAIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WeDiMpi4C5uHUIatWFsJAkzMjk+0gVX7HSEBNmMqCvapF5/iR0rKLWOwfWuthl1uSKxkH+pZ/nP5De3mbK6huZ2XDMMPCsGiWROnGUJsJXeJsiVM0HAA+yGYGtaN3qJqJ0o6BpLL+AIA7JU5FoFnuA+eNMhiUGNH0QQ5jPlN63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXTJv7xD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f48b825d8cso11353125ad.2;
        Tue, 04 Jun 2024 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717518874; x=1718123674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSWAqBDL1izzu0pJ0VxA5Nn7Co4tP4tZJFYWLGdgAg8=;
        b=LXTJv7xDDZ7JoHAPYqv3+/SVWipdAbta/cdinc4rvOm4Id6tx0Q19lxb8a13dAkQDr
         DSMOU3eo2eagNyZAFT47gnTvyYkbKkPK7t0ZpXP0m0lQ1DLS2nmQ5C9qz69qIALKy601
         rx5ktCs950aPxeOwT6aUZ/OO655/8DItIOQtb43hqVMvdkG+OT2tIKAFqLsAcqovPKow
         GJHTdpsJuZ0btfjkUn9dZA70MQ+TRdZyQpWZmK+ShrtmeMkO9bjcZNUKPwSw7AhW9DR6
         M3lmdJLEYh7+1zSnuuv4aXgUVpL2AAdS3+v0+KzkFfvWU/jwGLtwL+rkpifs0TGNET0/
         KrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518874; x=1718123674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSWAqBDL1izzu0pJ0VxA5Nn7Co4tP4tZJFYWLGdgAg8=;
        b=WmPOTUrFQchUg2Nn0GCDBdiJ4hPoI9CC41pkf5bzrq22C6K++NtQlN8Pgj8wY+eS/A
         Lh2J0Lzd+u1d3+iZoSlX29oTyLLSPRlwCFuaIebw6yAIoHYPRGPjyuI0XSOJ1xsj48sB
         gimCwFLkEXMwz9AUlBerYi8cCI/15i7l/12+pQr43/HimwtIFWw28+yiG5VyTwy4xj8V
         96jMzgeEI2DlpQBD0qn5/C00GOfq5/N1wP5pXDJJ5Q0TWuzMCtz6+aXTgkLnZOW4Nhgi
         2jjYNyQdsnEZNGLfZEzrSGSixRcJjovh2f3PXnXbIt5XsvdUp9CMJOzLkI3MN/sOu6g8
         p5Og==
X-Forwarded-Encrypted: i=1; AJvYcCW8BF9kbQ+kjJWOAQpVmqafhOsHVEXi73chUpigFjmw0QzU71OMjNM5Egf62pWpKnrh3KLMsV6DNNSLEzlmt+Q1xOAe+kZ3nOnAjYReaoz89X/ZJPs2Zr2rurlSit/kDCYn9jLNn8UZFQ==
X-Gm-Message-State: AOJu0YzjbU4ZDYLiv9/VYu7rdGVCAlYWtTGCx6TUpPHoVng2OvYQUw/S
	EKkxaVHfD8nNECyJXuiywt2CVpZPq9mr4islLZKru0oB5HlzYyH3
X-Google-Smtp-Source: AGHT+IHwz4HQgLu2AhAlwAyyyDOYRi8UyDFV49LkLxu7HqmpNBzU9VPhkitQY78LumAPLMZ+arYn6A==
X-Received: by 2002:a17:902:f687:b0:1f6:5a50:93b3 with SMTP id d9443c01a7336-1f6a5a716edmr293035ad.43.1717518874470;
        Tue, 04 Jun 2024 09:34:34 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.99])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63235561csm85463445ad.70.2024.06.04.09.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:34:34 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Diederik de Haas <didi.debian@cknow.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: rockchip: Add RGA2 support to rk3588
Date: Wed,  5 Jun 2024 00:34:07 +0800
Message-Id: <20240604163408.1863080-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604163408.1863080-1-liujianfeng1994@gmail.com>
References: <20240604163408.1863080-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3588 also features a RGA2 block. Add the necessary device tree
node.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>

---

Changes in v2:
- Sort node by bus-address based on next-20240604

 arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
index 6ac5ac8b48a..beebc4dc0e7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
@@ -1159,6 +1159,17 @@ power-domain@RK3588_PD_SDMMC {
 		};
 	};
 
+	rga: rga@fdb80000 {
+		compatible = "rockchip,rk3588-rga", "rockchip,rk3288-rga";
+		reg = <0x0 0xfdb80000 0x0 0x180>;
+		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru ACLK_RGA2>, <&cru HCLK_RGA2>, <&cru CLK_RGA2_CORE>;
+		clock-names = "aclk", "hclk", "sclk";
+		resets = <&cru SRST_RGA2_CORE>, <&cru SRST_A_RGA2>, <&cru SRST_H_RGA2>;
+		reset-names = "core", "axi", "ahb";
+		power-domains = <&power RK3588_PD_VDPU>;
+	};
+
 	av1d: video-codec@fdc70000 {
 		compatible = "rockchip,rk3588-av1-vpu";
 		reg = <0x0 0xfdc70000 0x0 0x800>;
-- 
2.34.1


