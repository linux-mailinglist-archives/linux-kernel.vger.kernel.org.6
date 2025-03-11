Return-Path: <linux-kernel+bounces-556300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D8A5C3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7063A922E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2449323817A;
	Tue, 11 Mar 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjIl/ZkO"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13425A65A;
	Tue, 11 Mar 2025 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703315; cv=none; b=e9RcTvsF3Uh8BFGyrSXlD9zMVG2lvCLr90R1ajCy6Wt+9YfAyXBXJ0eUsSsDRiUaXVy9UKPXdBtKz+yjwY4d/mwm9h4zCsD4ALFZWBVGNlHLWTHrFkECdU5E/EcNavK+v7ozeEsgctvXxmaHmgZxAlzen052g3+JKMJ4XdgIzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703315; c=relaxed/simple;
	bh=2tapGsa8TR5UGEosiOrzGuNAlMJqB1o+5LffL5Xtdoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LjxKJaThIPH7kRRZ0IYWE4hMyLoRI1nxn0I3EgYjNqlzQjeR+XQRxDSs5ptjvLKRD84VJXxxYjXZCp41P2glu3Iu2UaN3iXTxOlURmpr1JdVlwty7dP6aWKQyQTGA9+0f/dxJV6c9ZKJwl6C0CTzbCFApu68tdZYxc3atfEghbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjIl/ZkO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-224172f32b3so9117935ad.2;
        Tue, 11 Mar 2025 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741703313; x=1742308113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4BU+SZ02d2XzQItB7vSu0vr+Y6teTSqGnj3Dul5zaOg=;
        b=ZjIl/ZkOgA/fBoUWZwgz9RwDkskCMfVJ4j5oKORQTiCb6u2fyAQJi8ao/GDjv3mq17
         wd/UXNu0HImvapFDOd1aDbealQLASE5qEHvc9a/PcsuGW2K1nxdi+kGSOwVxlbzffg16
         IcCYHrUyuQUcPX6O+hJPqdbjMdppFra4LTsFPdA/fo0g+apPRXo2EstZWTf25lBv2UFd
         HNb8CAQ7bx5HnDQRaQRGLFknm0I7ibUIxxQApbWhvAgD16619ug/kLlNZHRu9ApQ7Kum
         uLr4aG+OlXr3aqTIBgbVtxn3XbRmV37ahdyiqvPjRa+WOhREJQLaxHxnQM1ZPBl9LSQy
         H08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703313; x=1742308113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BU+SZ02d2XzQItB7vSu0vr+Y6teTSqGnj3Dul5zaOg=;
        b=HdGZ6tcsvGASTn7eJNX4Y2AkY6C6cG/5m8e/Od94G7RYEWf2uZ2QvxoLlhcdHz+ABH
         6dkXujvNwUffiZOWDfoqtkmQ8FRDWQNi0VH6rjxBpcS1QWMC8mZ4VzDU0fac2Eg5CFu1
         MQu7uR4HImMVUpOav6sFM/hNAMwe/9dm5qOGpe0JN817S9ZaddJYpto7FU3VvdhfZ3Ue
         Za5k8oM8I8XC9a8GGxA4/eA8FD7qRBgQR+6eRbrif/hPM+wweb5+9TZT1xgPFcfFExUF
         anhKo/TV2xpg9YoHMs5Om3umE41jr+K1dStzyJzu93aVYUJCQIfq8FOrSCI0R5QDMUxk
         pYaA==
X-Forwarded-Encrypted: i=1; AJvYcCVOXzqNXvpDLDi2JacVJlur9XZTSEvWy0oyJwc6OL6OspsdkcbfIZTgcfuuMaRCwEyuQsDL7G7hlA/QyUGO@vger.kernel.org, AJvYcCWOfOVLSCNff3K/flWxEoZHvFmHgMOFjo285eJhezwQKNogKyxz0ke0RU9+S4hIOko5UogMNl0/IUWm@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxFf6LEvH3usHz9Z0ir37TuIydMdu/nkS0p1QS2lADLlxKFLn
	iYs2euwL1bsMNOdANtEsCjFXtUsrj3BcJkE1aEBEAZxlzxu6+PIh
X-Gm-Gg: ASbGncuT/pCa1JK2cKGO0s8RubC7q9ISvLnqpVS3wk8E5Ec4V9gMPIjIbhGem+ESJHc
	MFhV07xARx7nuKp6xZP3zVIPPUxxSNRR/FENZOTaRsDSn38Bm/6R1OCxIW4qbLlcqdN/8ZRAKjj
	dw82UtNixVxBGEeqQY7cg3dC//4NkXUF+xdQ9/TboSwlZiXWEao19eWVuE1dTd3TbBcTQAOei5n
	ddYHQkO0Nle8bjRqayB0DZGrl8z35fEsPE1Eop8zZoaYZTdZZ/zrdP/6VCwqat2dtTtahwMytkv
	JF8RlYqjO+X3a0rsYfs0cmZZKdqJL8F/use2wkMNjEeI3Xp0FQ==
X-Google-Smtp-Source: AGHT+IHYBCivxsu2aj6qSakK9DONJVcdwxBohBs2hi/qC896QdVSsypN75o/kpHRKEb2BaeV0jQP3w==
X-Received: by 2002:a17:902:e802:b0:215:8d29:af0b with SMTP id d9443c01a7336-225932f6a0cmr20288795ad.14.1741703313413;
        Tue, 11 Mar 2025 07:28:33 -0700 (PDT)
Received: from rock-5b.. ([221.220.131.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f773sm98493875ad.117.2025.03.11.07.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:28:32 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add AP6275P wireless support to ArmSoM Sige7
Date: Tue, 11 Mar 2025 22:27:50 +0800
Message-ID: <20250311142825.2727171-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ArmSoM Sige7 uses the PCI-e AP6275P Wi-Fi 6 module. The pcie@0 node can
be used as Bridge1, so the wifi@0 node is used as a device under the
Bridege 1 similar with Khadas Edge 2.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---

 .../boot/dts/rockchip/rk3588-armsom-sige7.dts    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
index 6a0fffaa26ee..face42bb0d7d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts
@@ -300,6 +300,22 @@ &pcie2x1l0 {
 &pcie2x1l1 {
 	reset-gpios = <&gpio3 RK_PD4 GPIO_ACTIVE_HIGH>;
 	status = "okay";
+
+	pcie@0,0 {
+		reg = <0x300000 0 0 0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		ranges;
+		device_type = "pci";
+		bus-range = <0x30 0x3f>;
+
+		wifi: wifi@0,0 {
+			compatible = "pci14e4,449d";
+			reg = <0x310000 0 0 0 0>;
+			clocks = <&hym8563>;
+			clock-names = "lpo";
+		};
+	};
 };
 
 /* phy0 - left ethernet port */
-- 
2.43.0


