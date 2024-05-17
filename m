Return-Path: <linux-kernel+bounces-182096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9918C8636
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008151C20BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFCB43ACA;
	Fri, 17 May 2024 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVbEAI6r"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71FB41213;
	Fri, 17 May 2024 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715948766; cv=none; b=dxYocppJD+fySxn7DUoq6XOsLvbt6rPQYj2+PmBv5T1/IFxlDHQPfSciYsfTmRZj+L+Ihz75gPDE1+3OUz0liDpu5uYjvSR3Al3QexlVKMy7hpntzTEXLXj5cSmftULottBsFwtHQWGfwPAfTkGPi+Qv/dldHTlU4VIwAyXEWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715948766; c=relaxed/simple;
	bh=Vm4qAjJoPCZ694EsWANLuzZaef/XuiD/Du7DXEqZQ/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UR+JCWRbiWt4oCLg1fZmdudHtZgbSUeynk8HjqNSPJNdjh6csMk//V8853y9RoYSvZKj76jOfiEW74JxFP3jwNn30YVq4HYxnOfNCwrCY9vXiEmJDEOPgRpIahu1ByLO0Q/JJ8sA2+rQ7K6GytDHOBtJdI9Lbo/HXLQUhfoOXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVbEAI6r; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2db17e8767cso7872371fa.3;
        Fri, 17 May 2024 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715948763; x=1716553563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTfbpSzPiGIEgV303dsq51yFhN3J0xYTsTq4AVxFCHI=;
        b=WVbEAI6rzrh4ds5H8zgmNvtleB8IBTWMKaj7T/22vdIzcsZbDvx+571ima7G6CNWoH
         5+fURVkIFEZsky6DHdHioWVUIkPxBIhwPETgbNW93E40Gc7hAl5DxnjXICd2RSz/JM1g
         MjApSNf1DGtSxRyEN/vuaqcnl1kotw+r8p/dt1R6iOkXVJMmBpMSp67wzymXAJbfm/Fb
         liTnJ3aRYGDR3psq/HKsKYszpq0lpo/cxrYgGOwOA2ATfxRHILkSKQuCnb+6B/xXCjRR
         HbGwODrEdholilCY1P2zjf8HPK06DtHyfrHftNpCPO6YH2kXxjCvOpj8DSkxouJTSFNx
         eEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715948763; x=1716553563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTfbpSzPiGIEgV303dsq51yFhN3J0xYTsTq4AVxFCHI=;
        b=akrg1YUxq5AJfZqVJq8A2HuXyNRwfta+qBzS+uyP+Q1pTkTLlhZsBxHWsJhzF5u+pK
         Ej8l9TPAqnC3wpe0Ae76ejYokiY+pCebgpPxOe0NMip0k5vVReggjz4uji7ufkDSs+Ky
         fkYtrwg3BpBZQ10DOuPAhCYXNeJ+WP4bTdaQnh6mtXZgg2XI+FspA11JwXgl7ceIGuqo
         +HS0V+6OMW7iZFHhXxKh3mhBFMx90bAPMELicISCq2Z4duK4HBI+25p61Tm0BaglBFbE
         R+ly4j5hXOBNvqZ6edYtdvDzTtOfYkKV0zNn5ZU0uyeIjb2O+WimyR7E4KUUvczc1GOV
         xnvw==
X-Forwarded-Encrypted: i=1; AJvYcCWeAFqvlpTycmR7UgqJmjkQqq+zIxEDILP4PgnCQRi91/XxzgLf6QYDhJHqJbgk+kMRKTRJz13O4o0ONAV9mnd+P048qZ2NLc4+DHQxVxKsk7WOG73XXFgWrDMhxSbcI95UAmLXO32yzg==
X-Gm-Message-State: AOJu0YzlSiFVzWxHy4UvLSY31kdMfT0IP0abGB6OXcT0azPIGDOG+C0w
	fVarSE9FuUIJZbQOTXp6H2zQyF7/vlUIQpWGqs2vUw+ASqhh6UOU
X-Google-Smtp-Source: AGHT+IESDynaSNz+w7Kg/DLSAjwanT7vil/v6O+GgjNjyOp7XS/RC3dSkeivfIryg2jvuKTuAI0Z9A==
X-Received: by 2002:a2e:7805:0:b0:2e1:bdfd:ce70 with SMTP id 38308e7fff4ca-2e51fd2dd0amr164028651fa.6.1715948762536;
        Fri, 17 May 2024 05:26:02 -0700 (PDT)
Received: from latitude-fedora.letovo.school ([194.247.191.114])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d15156d3sm26598971fa.99.2024.05.17.05.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 05:26:02 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Alexey Charkov <alchark@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add rfkill node for M.2 Key E Bluetooth on Rock 5B
Date: Fri, 17 May 2024 16:25:08 +0400
Message-ID: <20240517122509.4626-1-alchark@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default the BT WAKE signal inside the M.2 key E connector on Radxa
Rock 5B is driven low, which results in the Bluetooth function being
disabled even if the inserted M.2 card supports it. Expose this signal
as an RFKILL device so that it can be enabled by the userspace.

Tested with an Intel AX210 card, which connects a Bluetooth device over
the USB 2.0 bus.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index b70313643af8..27dd95f92f33 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -65,6 +65,13 @@ rfkill {
 		shutdown-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
 	};
 
+	rfkill-bt {
+		compatible = "rfkill-gpio";
+		label = "rfkill-m2-bt";
+		radio-type = "bluetooth";
+		shutdown-gpios = <&gpio3 RK_PD5 GPIO_ACTIVE_HIGH>;
+	};
+
 	vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-- 
2.45.0


