Return-Path: <linux-kernel+bounces-430365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772C19E2FF5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F8B2CDC6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D21209F51;
	Tue,  3 Dec 2024 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmCN8XN/"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F5202F84;
	Tue,  3 Dec 2024 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269043; cv=none; b=dOzrX1Tmjfakg6JWHYBtghQDq+vitPzyE7cQFN5I8cjjRIAuDjt0cGQgjO47eh2DcdrMo5523AFQm4vRjOugNJy7jJhVN1tnW6w+5hOp9Igx65f6e6yp8Wl8oOvnhGjgiG1YPX/JDED1kz5+3FNWIoCKPQN/Cn2kDIiqdPXZahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269043; c=relaxed/simple;
	bh=q1u93VWbmhkuangUi+34Ds4LKF42kWp+h/JOuvnQvnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3O9rirY3VweitKbDZgQ0tEnz7QDhGjNEeMIRpaCAmB9skBSHHS3poqdWIJqF+hAbPhEcdg8ojWpoM53W50DxhSeA46KT7nif9LYNfsXEUbJbK+DtFymi0E0f0b7NOqaNwCiuL0s03rt0QeKn0VCEIreKrxywYKPvnvWx/DKfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmCN8XN/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so2083035a91.2;
        Tue, 03 Dec 2024 15:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733269040; x=1733873840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5qEW4jJfic/KmqYMW2G0FOLqVypcgVgmsP5xVbecKw=;
        b=RmCN8XN/kbXo9gooOIn8547zZtyJZ6RDYRbhTjVDlG+3nMe1TF1bft7m+0S5goJTrn
         j4tv7S/hsrDDDYB/A0W8kUlRTJQ9wOvwsGRVvAb08DXZKHswQsXdkQb9CKnAjsaoJuy9
         GDmN/AlMlDzvtj3K8ccMvD0McZLO7krKkJaFvO0qOXmA56xPiz7nhMiFQ9+J70lSMI7I
         remrm6J3+mwJkswPbMoWBdL0z8ttYbAPZuYZqHf0O0e8bUljEgBjW+lrKzX3BBApgMYD
         bSuGZ2CydjhjaQJEhv+XCP1CEYmfJFIIVg/n+k3Mdx7ggNFc1nNaJmQrIV+eJ2T6IIM6
         3hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733269040; x=1733873840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5qEW4jJfic/KmqYMW2G0FOLqVypcgVgmsP5xVbecKw=;
        b=Fe1tjp8IEXvsUn9E6O9i0eTXvWxSxsmAHMLKo66Uncv87rKMRYdFCquw+GPntieHsy
         fszPCMsdoLUTNu2B0mvS1zGFIlPK+34l+msC8xlGnfgZSyYCt0MeaptIXzTON3CZ5nGW
         37hQzG83zQjRI65RnsQWdp030knfFe9hndD2i6bGCV8cxH9H6uRtnCuXCzWq43aMWneo
         HJjri/aLoRMdpoP3DZgYvDxOiRO2k8SP2Bl+Zt6d06LcId4nB7tUpX6NKr/xZ7RzAXIJ
         Fkdsi0n1197GHW7BN0/3ItHuHQURrol4zGOh0VgpNPXrsN4YF+oFgjlic9OINwe9CDm7
         k2xg==
X-Forwarded-Encrypted: i=1; AJvYcCW3S/YQ897C4ZEh4WydpNEckA/qHxsk4UxCuBs4oyN6OFO7DNNw7ZVfZ2GcZRVE6JoZqNUmHM/4XeGC@vger.kernel.org, AJvYcCWGaVq17EVZe/v1EWJjinQq49pFT2gRNJwwxJ70qGE+njCI7i2pfqRe+QcNdlPh/Qj8Aai+3y/vt8WKiCg2@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBm0yu5a/+elI4nTmMcBYYmtF3vKgyPbnl4qAN6rCJdDnk+oZ
	FkzT3JudiVzQE6aWhBEiqp5sUNgSnga/vHIPc51aGQf/D8WkMHNE
X-Gm-Gg: ASbGnctF4dumt62tuXSxPxuO6UYxEx/9KwPgZQWfKzejzTznWJj3X4qZbCOlwBRTuck
	apsOUOouj/e5vQv9rrgnLGAK8GMkus1MW3Wkx4T9D41K34EaQdDCCBg/qUfGadGmZledNM+3Y51
	wp1URDsU2QFq5XdQ5Vwq18FWSmlMSV0mgwmJNZCcn+AcfEyzEVgPmPgLtxV/hx01R8GnZOENdg9
	zf7PHBppKdEFrklFWke0sm47A==
X-Google-Smtp-Source: AGHT+IGmUB8QfjA0RY2ydXBICshKM7ronJUqIxAE4e7WvnlpNAzxGCSvOX9ygh9d1aeEy5n49zRLvQ==
X-Received: by 2002:a17:90b:3a85:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-2ef012748a3mr6764344a91.33.1733269039866;
        Tue, 03 Dec 2024 15:37:19 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef270352c2sm119187a91.33.2024.12.03.15.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:37:19 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: armada-3720-gl-mv1000: use nvmem-layout
Date: Tue,  3 Dec 2024 15:37:17 -0800
Message-ID: <20241203233717.185016-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvmem-layout is a more flexible replacement for nvmem-cells.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../dts/marvell/armada-3720-gl-mv1000.dts     | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
index 56930f2ce481..7b801b60862d 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts
@@ -98,10 +98,24 @@ partition@f0000 {
 				reg = <0xf0000 0x8000>;
 			};
 
-			factory: partition@f8000 {
+			partition@f8000 {
 				label = "factory";
 				reg = <0xf8000 0x8000>;
 				read-only;
+
+				nvmem-layout {
+					compatible = "fixed-layout";
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					macaddr_factory_0: macaddr@0 {
+						reg = <0x0 0x6>;
+					};
+
+					macaddr_factory_6: macaddr@6 {
+						reg = <0x6 0x6>;
+					};
+				};
 			};
 
 			partition@100000 {
@@ -221,17 +235,3 @@ fixed-link {
 		full-duplex;
 	};
 };
-
-&factory {
-	compatible = "nvmem-cells";
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	macaddr_factory_0: macaddr@0 {
-		reg = <0x0 0x6>;
-	};
-
-	macaddr_factory_6: macaddr@6 {
-		reg = <0x6 0x6>;
-	};
-};
-- 
2.47.0


