Return-Path: <linux-kernel+bounces-365676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5A599E5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F2C2854A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2641EBA0A;
	Tue, 15 Oct 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsPWwgCo"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A751E9068;
	Tue, 15 Oct 2024 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992027; cv=none; b=D5gpKmiQLllhH9Sn5CadxqTm9ldXOi0sn2xAIHiIvb66LGRjy9lJVIk2tU4lZcz9Sc35HCe64oOF/60Rv3FPPy9hPRIlhh6sdH64FdJalY19NBexeRDDSd39CebXe4v7il/cJ+oMM2dLdxjD5ps2l6MDkva3z5HGZHFtHlx2uUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992027; c=relaxed/simple;
	bh=ch5okUWGA+CN4BsyDr/07MOn3D2VkJk254MFi+dtfKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qtVq7qqUsKp5+IOYeSoGB/ox9EwlymWIujFWhGV8i3ywEu/wNXFUolknsKX/B3hR8lKqH1Sq3YijDa0JfgBEvnlA/tDF0csYvkoSfdcmM/kb8ZfV0Q1SZcxjAMAFOfNLeqJ6WH7nk51EdXaB+tblZSIvkqsf/fcKyZa9opj81OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsPWwgCo; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso3967209a12.2;
        Tue, 15 Oct 2024 04:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728992025; x=1729596825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk20xddrCI+1UTpfhGcnbi1rryEpUOFeAY/WaVP0xkM=;
        b=LsPWwgCoSSgKNtGFCBRmRRzaGLWkEoXpgcnPBqHpyDPfZsoxKMds+aS6LN5xhdL2DH
         iZt4qmFU4Wr97LkOv89idZEJ7yqNYBBjxtjTaq16PrexQZGiseUHWlfIKiJzl98Bkz6/
         DeMUMaJ/XWf6lRJ2/N6wkO3i2awUDGbIXaj1NYzA9wCpFci2diZupRiOGbC+M7MWsJJr
         7Gya8bi0aAG2XG8NtkPKi5vwW5GPBohfe6dIKIcs6y9qdDSQgHx6IWFQ+uHzfoRsP3qh
         mqjMDv+nqwAEohyofUIFHhyRdLynQy6SXVfdGvnYwOL+bbrlQlZVO6Dp4p9ldyidbWkk
         p9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728992025; x=1729596825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zk20xddrCI+1UTpfhGcnbi1rryEpUOFeAY/WaVP0xkM=;
        b=kjkHXvGvWciebETIa1kNETH7Aq59MyAeIah+Meh+BzlDPVUZg7R/tc/GlGrXbBoAkP
         UeGY3mAOy3fcqyfjZKm+OFIpuWFpPtz60F+rjz1cpS2Z9FsoPZIlRqmtrnlEzdy96PDk
         aCT1uj8HsRL8+eWkJL7H01ml0Hkk6VWYkRx1TFxfU2qS47CHPngFcKw4LJQEFbtKQf9M
         +9JMv82V1eRPBIE3sL39qA3NcR8avN3k/MJg7nAAUq5buRgdCpQtd8JRZOnZPKVtqlgI
         6F27o5Ad7sJI60xqXsGO3CIoJQzZw/AXqDkF0sZWjLA9DAH211mu/wpnM9xWgtCo3Xby
         o5Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUtdEqvEM5+OeFXqIV8fwXoBkD16j4495yMt0F4ULQKoa2egXVIjTKKileDutL+T4f4yuwxn05kqIXU@vger.kernel.org, AJvYcCV0GJOfJJDM0UAQhbHWcQx3xvTaK3lQwZWNbJ6hxmC4NIpFLN39mvZD97wt3/swz1FF0r1z8opJwGl4SWGf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5KdzxwqvpvgpfOQ0XpBKB9360qMTk4yGkpnpgM5rIcnRJBjXz
	ev1dYpjfnKu5xJQYLEkfC5pbmTiRRSstVFc2mjSCfDTzFnb/0wHJdfA3i9WR
X-Google-Smtp-Source: AGHT+IGwP1I8w68XCMtbhgXs5MLUMnBT1yYS8XxOgQuQZyarTMsouVs5FP6o5vACqFbWGTmJC9mjCQ==
X-Received: by 2002:a05:6a21:2d84:b0:1d8:adea:6598 with SMTP id adf61e73a8af0-1d8bcfaf61emr23924962637.38.1728992025447;
        Tue, 15 Oct 2024 04:33:45 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1805b056sm10017455ad.248.2024.10.15.04.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:33:44 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: ti: k3-am62-verdin: Fix SoM ADC compatible
Date: Tue, 15 Oct 2024 08:33:34 -0300
Message-Id: <20241015113334.246110-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Fix Verdin AM62 on-SOM ADC compatible. Currently the hardware is not
correctly described in the DT, use the correct TI TLA2024 compatible that
matches what is assembled on the board.

The "ti,tla2024" compatible was introduced in Linux v5.19 and Verdin AM62
support was introduced in Linux v6.5.

The new DTB will not work on kernel older than v5.19, but this seems
unlikely to happen. U-Boot does not use the ADC node and a known Android 14
out-of-tree port uses a Linux Kernel 6.1.

With that said, despite this being a breaking change, it seems fair to
to not expect any regression because of it.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
v2: Update commit message to make clearer these are breaking changes.

v1: https://lore.kernel.org/lkml/20241001111413.10390-1-jpaulo.silvagoncalves@gmail.com/

 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 5bef31b8577b..f201722d81b3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1220,7 +1220,7 @@ sensor@48 {
 	};
 
 	adc@49 {
-		compatible = "ti,ads1015";
+		compatible = "ti,tla2024";
 		reg = <0x49>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.34.1


