Return-Path: <linux-kernel+bounces-428711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF509E126D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947F6B21ABD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F392814389F;
	Tue,  3 Dec 2024 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A994c7pl"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4E17E;
	Tue,  3 Dec 2024 04:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200443; cv=none; b=UkPe068f7C3jND1Or8IPKFHJtZX5gZ/43RltT9S9N9MsSGf4xNk0ExbLRU5CxPSbptkhqrS4Gco+uzAZTupKRsGFPfoPvgzRpDuraWahEUlQP9TNnzMJORG9cSQ8LjDQbrcQ0gXvl4Zy+EtJVFsAvpipe5gz1DjSuMaN2pfA1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200443; c=relaxed/simple;
	bh=5akBCqIh6nfu3KnXgAHy5/rtArcsD1x3Ug7vLVRs2WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XVxnOr0SeQu57IuruCUZ4AGhcGOAwbAf4PxdLqKvI7brYLjRiVO6JwJr0/NNdBEMofhI93j3GZIeifQpapOtaZWhvhfso1xl4RBHCK6FestzQvaghJMHhqYGX2pZkvoJVivM3J9Fzf5rB6XfNSXmLtRkNwe93L06PQ3ioBZm1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A994c7pl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso48749561fa.0;
        Mon, 02 Dec 2024 20:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733200440; x=1733805240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=39w8iuhHVlLqBuA/1DwxvFPlALFBTRfVCYCBvpz09Oo=;
        b=A994c7pl/s6BS01/vJ2XN/BJx+x7Sj5LiMi/O7hqFExePlWgPpVlfxkoF7HIaZ7Fl5
         rK8PyWMPLP2m93duuKD3XjOSTx8qldHV7hUcSPvSGaf+SxXaUaQNqvGXVNPo9xN1a67W
         llzCjwKhk0MUTDqsPxr9xhteSrJ8XvolULjeHvLz7NBf0OTuta7sWweXPGQHVB4Va+EV
         N6Y+u7MTJfe3hdCb43ELtzdTrzXiJgVxPV1KQrqSkkvwrQDlho08OEUQEEI77nP8k9qf
         SO8qQ7fugx56RLSVkIyblbQ2IfkeS0n5uMMZEv+GYWk/SE3n0k5FpuedIeNP0KPbwt9V
         n0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733200440; x=1733805240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39w8iuhHVlLqBuA/1DwxvFPlALFBTRfVCYCBvpz09Oo=;
        b=OsU+pffZDdJNGUqrE+B9Fg0NM+s/TfH2HV15B/64MR/7swoQdl/zHZJWmAilxO4rJx
         3yLirN8nAUS6fVtE1EI63P9OiknTMXcyFal+D7TRYzTMVatxwth8OSsfgr51c9O0NJZe
         tsZ7tQ+CpSeLMLjMdWM4W/8Te8eHqe417GBz/6/5Vf76WvR50nyx9Qwd2sWglyxOrSGm
         dUOPHf3yT4DJraE5IRH01bg1IUCVY6/0WimtVSayddaZOngoANlX8YEGmPX4bjJS1u7U
         i+38EraCM+yfgN1pXI6EOYS4mFeRPnHfeYDhgd4Sg57BMTZzMDdYO+EGu7f+BTHzx3iv
         9AzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3QQ5gK4j7EPFXq7JpdQwqYG0Mn35fEse8LopTWnp6nTMn8vbcOZ/CnJCV6cLybpbNEugUTlTbKdTZ@vger.kernel.org, AJvYcCXv/PDW9yxZmHK1cdkT2mDIpvmqHZU2N4guX4tPiWXb9DV4TcJlsO6GFB7i9mNWNY2cnib7vxWHsRLxCI1H@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhogSMGvGeVnqf9fcfCvIhdeDWyGsupOWkdl/Wb5UlH+lVglm
	1gIbWA/kvZ+rHVCvzTxH94agiyVWqOxChxNEsuncE6kMHb1Q8Fd3
X-Gm-Gg: ASbGnctRq+0heQyq4/pdUl22+BTSLDE0JucoyI586/3RCh+4E1q88+C9THlfn2QSIj4
	WloTM3duWCCxtGQaB41ZPdOOTlyJFGWpWwCWv30YFyCvm13pTcYOS+JwXnGv0YKCdcCrIgwjO+U
	H3ng1L7PldkMtvT6466FR8RdWK/59dysqGRU8jg5i6ngSJl/cnW4NdlxU1HmyCQgrbUKcvM1vVk
	O/CRF3P3gcnGWG8a/8U2WpLymZ+j95BFX7z+YEfg91TuIpDbW9aJRPq1byw
X-Google-Smtp-Source: AGHT+IGKGrRfxqVUdD5DiHKxFe5Ex6aB7s7ktQE5FUl9w1ZPEdkYdwfxlO6IG0pYexTOTsjgE7WiuQ==
X-Received: by 2002:a2e:b890:0:b0:2ff:9494:969b with SMTP id 38308e7fff4ca-30009b68e44mr6035061fa.0.1733200439312;
        Mon, 02 Dec 2024 20:33:59 -0800 (PST)
Received: from laska.lan ([217.71.227.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfc74a70sm15229881fa.89.2024.12.02.20.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:33:57 -0800 (PST)
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>
Subject: [PATCH] arm64: dts: mediatek: mt7986: fix pwn fan settings for sinovoip bpi-r3 board
Date: Tue,  3 Dec 2024 07:33:55 +0300
Message-ID: <20241203043355.2565797-1-mikhail.kshevetskiy@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Popular bpi-r3 pwm fans like this one

  https://www.amazon.com/youyeetoo-Barebone-Fan-BPI-R3-Integrated/dp/B0CCCTY8PS

will not work properly. Trying different pwm setting using a command

  echo $value > /sys/devices/platform/pwm-fan/hwmon/hwmon1/pwm1

I found:

  pwm1 value     fan rotation speed   cpu temperature     notes
  -----------------------------------------------------------------
    0            maximal              31.5 Celsius        too noisy
   40            optimal              35.2 Celsius        no noise hearable
   95            minimal
   above 95      does not rotate      55.5 Celsius
  -----------------------------------------------------------------

At the moment we have following cooling levels defined:

  cooling-levels = <255 96 0>;

for cpu-active-low, cpu-active-medium and cpu-active-high modes
correspondingly. Thus only cpu-active-high and cpu-active-low are usable.
I think this is wrong.

This patch fixes cpu-active-medium settings for bpi-r3 board.

PS: I know, the patch is not ideal as it can break pwm fan for some users.
    There are some peoples that use handmade cooling solutions, but:
      * discussed cooler is the only 'official' pwm cooler for bpi-r3
        available on the market.
      * most peoples will use passive cooling available on the market or
        the discussed cooler.
      * the pwm-fan dts section was added before the official cooler
        appears on the market.
    Thus it should not be a lot of harm from this fix.

This patch may not be enough. Users may wants to tweak their thermal_zone0
trip points, thus tuning fan rotation speed depending on cpu temperature.
That can be done on the base of the folloving example:

  === example =========
  # cpu temterature below 25 Celsius degrees, no rotation
  echo 25000 > /sys/class/thermal/thermal_zone0/trip_point_4_temp
  # cpu temperature in [25..32] Celsius degrees, normal rotation speed
  echo 32000 > /sys/class/thermal/thermal_zone0/trip_point_3_temp
  # cpu temperature above 50 Celsius degrees, max rotation speed
  echo 50000 > /sys/class/thermal/thermal_zone0/trip_point_2_temp
  =====================

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index ed79ad1ae871..b0cc0cbdff0f 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -42,7 +42,7 @@ fan: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
 		/* cooling level (0, 1, 2) - pwm inverted */
-		cooling-levels = <255 96 0>;
+		cooling-levels = <255 40 0>;
 		pwms = <&pwm 0 10000>;
 		status = "okay";
 	};
-- 
2.45.2


