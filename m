Return-Path: <linux-kernel+bounces-427106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772B99DFCBE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231C1B213C1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E731FA143;
	Mon,  2 Dec 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7eozW64"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA971F8AEE;
	Mon,  2 Dec 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733130293; cv=none; b=SUMFoareSGUWv2Tme6EjnxFP2XjzZqIM7MjXJ0UHIo91okajdR8Btq0KPely1D97HlAPFhI4TwmjUQOmCfA99o4qRgX7XNSOohYyLWy2iaEYFeSsL+M7jj//VoHMJV7n/5UfMOmrhoUM5frPZYkCVxvD/xseXmx3oZKGZtMrECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733130293; c=relaxed/simple;
	bh=dlrY08Pjcx+vHWOCa/nX67fpRfc/svNQ9ctBrMEI5yg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MnXUnncmFmaTxR5fQMh8eIYA1oQMRLcA4w6xtejUGKAH82A03AcedT5m8Qj84m3mRyz2+cCv8T82MLX+Mu1i5mkiH3ZDux/IZBqBYu9pP8aJvvRbqgshFeaa3Vap3J+40A9GiFgj+HR6/RmqIqnU6DsQva7+OGmc/4sHvWQdBSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7eozW64; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so28327305e9.1;
        Mon, 02 Dec 2024 01:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733130290; x=1733735090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KdRw+3yRhHiEf7cq+avjlIDTXlKe07P6ezlIISrm9AA=;
        b=B7eozW64Cnm7oLZM+7NUUaapQ1bns64zhl7B6dYfISBI8QeGnVux5k11HkPRXFDscu
         7ICP83mhcyKG9uF+13Kpo3MoG93qCBvngO9J+Xvno/pxrW8T9fG6Df1NxxQemRpTKyun
         JSpQFyWRexBNzjiWycpZMGi+4i+RAhucPN8ytgQ+pJR1nSI9PFcjDGwI2rIjhrdabLNt
         eVGK+7pax8jm9j0Pa+LVlfVIb7d6FeqU/iXgOONiJHJ9XLQRl4uxKmrih9Xv+PV2B4oo
         xDEP/cAlyAck3hxfvC1/ijrdz/DpT6InWJAQ6du30ZEkuxECUZbNsWG3ZCXF7whAw3+e
         s5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733130290; x=1733735090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KdRw+3yRhHiEf7cq+avjlIDTXlKe07P6ezlIISrm9AA=;
        b=XnGpl/ngR1/8yEE/G0le8du8cfWnTJMsT08zM0UY6Vm7wcogia6AF3J8h5FpL6mfFq
         euHQDHl3Bt8hZd+OqZSbvJXSsA9he02IR23nCqtdMSg1M04YSLGhxpSs7Ai0sJxCBG0e
         +F9QoPGlU0/sb28V33/Dw+rG/reAWaPPQL9K9OGTnHDHNriLqOhYF94/0ZTH1H4HKIbM
         Y87+Pt5nEUL/dHgkpfhC2fhLcQgA3a4bNTMNobmg4q2v/Ht3/UHi6QHK1g4U87s8HApo
         ss/gPxL7z20TdqWx93IeXNhbPvj7yD3QKiOFFAbsQVa9m2KxA11WVxA6yc0jDOhd3Drl
         6ScA==
X-Forwarded-Encrypted: i=1; AJvYcCUXedHK3v1BZin6hisJG7mdJo3bQTA2zwu5vWyASiVWCQ9sIiQm1SGkRlJsJlOxoek3gBjVXO/p1CXd@vger.kernel.org, AJvYcCUaMMrIfh9m0tUG8XRo04Z1J262oClSDsR7SV0B6COPvdeoamLUr2YFknIH0LvQ0oNaA6kVyV6YNLhHfoUc@vger.kernel.org
X-Gm-Message-State: AOJu0YyTAbLf3eyxnUdJlbjNIuyufxqMrs+Rwxb3ZFHCg/sCHaedELyv
	2vAu65j8NpJZFBoduWpIvBeiy9jf1mqwJa6C0tVhW6Pu+L6chXWV
X-Gm-Gg: ASbGncv5u4sIZBiaKwnkCBk1L1sIgRB3WQYjGY+c1epSKt1C7nsJHgty2rkhv9XGRw4
	7/RJBUEuVY+OtpWoX3aiHpm3A57UrSUnyaDY0jEpjQ9/SROL4PjKS7DsG12KPzIStpSy+2XLpNR
	uWeygPrWxse48JCgjZOhqFPdQtv0rbTJrBIYzhnx72GXzsp0rDBN3m0lmwT/fP/EN/o9z++espu
	Hlc6SxEtuX5BsbrVWn/Ty66+kS5mzH34wS2Kw5VXxs1uBPtt6BVP2JBq6BYbviFkCVCCnKuegxK
	kx5pY0XBdvzKogotTfg=
X-Google-Smtp-Source: AGHT+IE5ej83vkEuAN7FUm2IFCFK29g4LXe0Xrj2GfYHRf/oTcVWykXSn2MRlBnJgbYj4lmc+7P9Ww==
X-Received: by 2002:a05:6000:18a5:b0:385:df84:849b with SMTP id ffacd0b85a97d-385df8486eemr10060974f8f.11.1733130289614;
        Mon, 02 Dec 2024 01:04:49 -0800 (PST)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ee4d932asm3658161f8f.26.2024.12.02.01.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:04:49 -0800 (PST)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Sasha Levin <sashal@kernel.org>,
	Iskander Amara <iskander.amara@theobroma-systems.com>,
	Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
	Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: increase gmac rx_delay to 0x11 on rk3399-puma
Date: Mon,  2 Dec 2024 10:04:07 +0100
Message-Id: <20241202090408.201662-1-jakob.unterwurzacher@cherry.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During mass manufacturing, we noticed the mmc_rx_crc_error counter,
as reported by "ethtool -S eth0 | grep mmc_rx_crc_error" to increase
above zero during nuttcp speedtests.

Cycling through the rx_delay range on two boards shows that is a large
"good" region from 0x11 to 0x35 (see below for details).

This commit increases rx_delay to 0x11, which is the smallest
possible change that fixes the issue we are seeing on the KSZ9031 PHY.
This also matches what most other rk3399 boards do.

Tests for Puma PCBA S/N TT0069903:

	rx_delay mmc_rx_crc_error
	-------- ----------------
	0x09 (dhcp broken)
	0x10 897
	0x11 0
	0x20 0
	0x30 0
	0x35 0
	0x3a 745
	0x3b 11375
	0x3c 36680
	0x40 (dhcp broken)
	0x7f (dhcp broken)

Tests for Puma PCBA S/N TT0157733:

	rx_delay mmc_rx_crc_error
	-------- ----------------
	0x10 59
	0x11 0
	0x35 0

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 9efcdce0f593..13d0c511046b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -181,7 +181,7 @@ &gmac {
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x10>;
-	rx_delay = <0x10>;
+	rx_delay = <0x11>;
 	status = "okay";
 };
 
-- 
2.39.5


