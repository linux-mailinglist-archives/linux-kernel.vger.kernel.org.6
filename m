Return-Path: <linux-kernel+bounces-362834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCBC99B9C2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34F11C20E31
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6447146D65;
	Sun, 13 Oct 2024 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jHqiDTmQ"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD0F804;
	Sun, 13 Oct 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728829843; cv=none; b=XePjGSdVbhxSrl0Wqw2QgBfrBmJSmoPHVC/s2lCs2H03wM5THEGKuvBBYDA/JreeQVp7N3NgtSo6nafS1jcqpedIRAz1aToJyMeCR5+UDFJNeAxHvaLTP7zMtfJMjfkCSzJywO4SL6VyXeMGqs8oqLuYtjfbmy4qGnFIjGpkVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728829843; c=relaxed/simple;
	bh=AEmoM+EFuaT+288e1DXK4XYKWCGrIOxbGOJ/+zJg9lI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uCwJSuDhj4bjA4cQ4If2wBCUgCYfEtVUhDRzix+a5KeYaQ7/iNeNCGCcVoejy8xCqDOJ5A+tRU9vZvJA1TiHG4PZRcW9a3g4H8oR54q3LQdnUCmUmI9PCETXvpYMg6Nvmtpbz3qiRzc8jnlvIeuqD9x4DmOsrs5bBe71zSWYpys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=jHqiDTmQ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a99f646ff1bso146022466b.2;
        Sun, 13 Oct 2024 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728829839; x=1729434639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0glNYA5rVjsDnyfMCJSUHAQP7BmZHrAonKDRalhrkE=;
        b=jHqiDTmQpBNw59UrmJINrX/dPWVvu/dz0b7HLEZwJs0/w+Cd2i1aA3lh27hgvfjJPF
         3t9BKYOHgEV37/NQaze4cHylm2/vgxiuEsTheq17Ej8bsf0kXtJnXQeWLEGLwphmzi9N
         spV9mPlUKlcm1AYbDn8K5uslX2VmrLAPljki+0ykHED9aZZGSI8AanA369lTrhXaFORt
         FwXTulEkq24Nri1/qOhHJ2W/XMU+wF26JUj7a8A4rJ9KqQc7MeuCVRLp0tye5b/3HY/D
         Hy6wPpa1C1F5pIbs3lvt0s0sY4fDXzM6gR/AkGUIRbgFB6qZU50lanPDh0Xa3a9Uo/qB
         FKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728829839; x=1729434639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0glNYA5rVjsDnyfMCJSUHAQP7BmZHrAonKDRalhrkE=;
        b=Mmgl4R7vAfJ7aLm7LRz3H2Wb/fgHQfgfk2uvTF/SRqdTxSwvXvuGxGL68T8PHtOIIa
         XCjScsagjDKJXbYZfcVOgdBkFrkRF6rRRWkXgx96vIcBcSKb3OiPWr/kjQUqvJZZPDQL
         Mvne05LDYBPx0hYOmOURYXvk2+dTkMHvyfhzIiqutyGkni/pXBS14mlnwi74gmd6tQKu
         Z26ylgUhT7s22Cqj0zbn++LWeYV/xJs5oPmo/MSyrHQF2Wp0SGDDz6VxalxCDM2dlQug
         dz0/3qVGT3jog6reb1dSqWBoPC9YSj3PEr+6ujBFp7O9lv9eYygJlhp26IANMg7c8v8M
         W7wA==
X-Forwarded-Encrypted: i=1; AJvYcCUmoEFNgc9/nSHBblcExwVxJBJFWrj9lxQiPeFbZaqMS1BVCNw93NnnwFUMKin88EV7a8hkavZMdUCV@vger.kernel.org, AJvYcCX3OzFWgZUEXd/8tiduyCqJCseQiU9WeX7NEG80pczfeuSkmOykXkRgrzVhmaOVLl9d6f01qnilw1ePUj4P@vger.kernel.org
X-Gm-Message-State: AOJu0YymPbNWpQ7XsQCT77nGX2zRaUBAieT6J8u6e0XXjCDKHDesBlay
	eVvulG6uPgAL2qjatQezRIruZ8yxnO7X4vdv0kZffTsWJdBewLF6
X-Google-Smtp-Source: AGHT+IFKXJhAqy3N9LwfreF+1hi3YEC45npDa52jeGv4glBoubxV5vad2zdUq+GQY4jnDZUy2Xchzg==
X-Received: by 2002:a17:907:3689:b0:a99:5021:bcf0 with SMTP id a640c23a62f3a-a99b93cb817mr918249966b.34.1728829838441;
        Sun, 13 Oct 2024 07:30:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:ba33:7ef4:2f9b:8303])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99ef5d6b93sm192205866b.80.2024.10.13.07.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 07:30:38 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Andy Yan <andyshrk@163.com>,
	"GitAuthor: Cenk Uluisik" <cenk.uluisik@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5b
Date: Sun, 13 Oct 2024 16:30:09 +0200
Message-ID: <20241013143016.16145-1-cenk.uluisik@googlemail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3588s-orangepi-5b.dts | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 09423070c992..45249ce15175 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -154,3 +154,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-odroid-m2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5b.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
new file mode 100644
index 000000000000..107b65a5e7ea
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588s-orangepi-5.dts"
+
+/ {
+	model = "Xunlong Orange Pi 5B";
+	compatible = "rockchip,rk3588s-orangepi-5", "rockchip,rk3588";
+};
+
+&sdhci {
+	status = "okay";
+};
+
+&sfc {
+	status = "disabled";
+};
+
+&wireless_bluetooth {
+	status = "okay";
+};
+
+&wireless_wlan {
+	status = "okay";
+};
-- 
2.46.0


