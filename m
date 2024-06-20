Return-Path: <linux-kernel+bounces-221946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8D290FAFA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66181F22241
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3D612E7F;
	Thu, 20 Jun 2024 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScoHheEF"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E41469D;
	Thu, 20 Jun 2024 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718847230; cv=none; b=ewVy0rnTQ8n+s3uUVt+xyX398pGZh8VyK5xCTmVtVCI8TD1bKXqwCwir6rC30koHk/pCO0AjL8dyrp37jVh4USQzbXwjPhMZrWPo4sgwkrNhZXug5WRtojIirGO/lttOf6MEL4kjzyqnGPeYK5hcXPAqJRttTDBfu11XmDCHoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718847230; c=relaxed/simple;
	bh=2SQzggWorWMQ+hxr5KZ4ouzgg+a7dj9wP5GbU1kw68M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TqdJi5Idj+KVYtfBGl9hq1ZnaSbj3Xg4b0seWE8MJg6xVoUA3T4tpyzoFSix84JYytLYXB2M41lBnYiWHJ1bWm7dblRfmxR81JQhm6VT4NaacN4zm4icxprGeUwnjeBL49uk5zbIhzBysC7/o2w0ynAcV3kwNLvUnpO+SBsqBac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScoHheEF; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b50a68b0b3so8117466d6.0;
        Wed, 19 Jun 2024 18:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718847227; x=1719452027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5HikRv6kiIPMm4QeUn8QwCXDOdRpGxbqfkwLthijeI=;
        b=ScoHheEFh85xNQ0onFqKyHu+059OXFjaoCf5+n4X8jHTfrzX6mRsGuMi8vla0w/Wo8
         +/zWxvUdn+6ipiaUFloEh1c6gBg8ZaPLVrmLOfG9JL0V43MiOVmLcekzQzFIwzNNLn8b
         jPLPWW9Z1a5aIAlBc8KUsKz6NcKx68/RQTBAkCfoi4l8Km+lU8qOVXMNS0mJR9qSI3UL
         paeipVHeaUlmi6GQk/hFeaieePvoRwyW8qst+b6UReqNfsuhOy6v0XabVYk6hG9xdIsR
         Q6TdiI/6i7sa98pav4xRwWXVSqCZeUt5MDi3FSz/wqE56wXMVaCecttjSWyxbkwYEl0O
         tMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718847227; x=1719452027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5HikRv6kiIPMm4QeUn8QwCXDOdRpGxbqfkwLthijeI=;
        b=v1pz0OaBOpq2XjrHY5IWkoKEvNgLEX5krhATXsUs5/2aBcfk5gKnxIxnddmDLMTVxX
         zVvSzBKeSyYEiyvpnJ/pSpYDXAyZNkb47BMPmuZ47lT4NzYDORyTlBO2TsxppVoHkoLF
         TaCYjGCfVg5tNweDCdmq04p6ZU5ITvE2g+2HBzEw4JK6jZx8yrCz+nhHkKy+wxr7Ib0r
         wPcjA2sGUyCU0lRojAOfmLrcX6Bx4Qom7ll1mZvfq8Y+hcOx8P/HsqMDpZG99IxdJyRR
         yj8P9UMFsdQEBVFF3Et9E5+U/j3nwcjjBHu9GWcQXApW4yzjfEZl9TOnZFaGFnBLeeeD
         9cag==
X-Forwarded-Encrypted: i=1; AJvYcCXEFquaMPeXMFjfoMfY029ZAetEM3uKZR+Aaoiwp5GHUVt1E/iYGbr/sNNdLy3LqlvIKegcyweAkGmqpSY/NT//pOXqXUgfgj5O4Q==
X-Gm-Message-State: AOJu0YyxqPJ7Zrc40XKaDCswP5UwPvkAaefVU2zT7wIHXsPrOcvm2Fyh
	MMu8KItdCErKzuZCdK5bqYtygjqw1Iy/OJkYD3YHXQ28oAuN/UIbXay1TA==
X-Google-Smtp-Source: AGHT+IEN53ttccCe1IOgM4GHOIP/75gthbOYHPruIhVGqJeLAJFFAeSgQqBm0F4DE7g+E2ACCcWemw==
X-Received: by 2002:a0c:eace:0:b0:6af:7b2e:1868 with SMTP id 6a1803df08f44-6b501a07c22mr84110066d6.18.1718847226902;
        Wed, 19 Jun 2024 18:33:46 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf2546sm83012256d6.14.2024.06.19.18.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 18:33:46 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
	linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH] arm64: dts: rockchip: add gpio-line-names to radxa-zero-3
Date: Wed, 19 Jun 2024 21:32:49 -0400
Message-ID: <20240620013301.33653-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.44.0.501.g19981daefd7c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add names to the pins of the general-purpose expansion header as given
in the Radxa documentation[1] following the conventions in the kernel[2]
to make it easier for users to correlate pins with functions when using
utilities such as 'gpioinfo'.

[1] https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interface
[2] https://www.kernel.org/doc/Documentation/devicetree/bindings/gpio/gpio.txt

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 .../dts/rockchip/rk3566-radxa-zero-3.dtsi     | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
index 623d5939d194..b72d75b908a2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-radxa-zero-3.dtsi
@@ -109,6 +109,78 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
+&gpio0 {
+	gpio-line-names =
+		/* GPIO0_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_B0 - B7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO0_D0 - D7 */
+		"pin-10 [GPIO0_D0]", "pin-08 [GPIO0_D1]", "",
+		"", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+		/* GPIO1_A0 - A7 */
+		"pin-03 [GPIO1_A0]", "pin-05 [GPIO1_A1]", "",
+		"",                  "pin-37 [GPIO1_A4]", "",
+		"",                  "",
+		/* GPIO1_B0 - B7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO1_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio2 {
+	gpio-line-names =
+		/* GPIO2_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO2_B0 - B7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO2_C0 - C7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO2_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio3 {
+	gpio-line-names =
+		/* GPIO3_A0 - A7 */
+		"",                  "pin-11 [GPIO3_A1]", "pin-13 [GPIO3_A2]",
+		"pin-12 [GPIO3_A3]", "pin-35 [GPIO3_A4]", "pin-40 [GPIO3_A5]",
+		"pin-38 [GPIO3_A6]", "pin-36 [GPIO3_A7]",
+		/* GPIO3_B0 - B7 */
+		"pin-15 [GPIO3_B0]", "pin-16 [GPIO3_B1]", "pin-18 [GPIO3_B2]",
+		"pin-29 [GPIO3_B3]", "pin-31 [GPIO3_B4]", "",
+		"", "",
+		/* GPIO3_C0 - C7 */
+		"",                  "pin-22 [GPIO3_C1]", "pin-32 [GPIO3_C2]",
+		"pin-33 [GPIO3_C3]", "pin-07 [GPIO3_C4]", "",
+		"", "",
+		/* GPIO3_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
+&gpio4 {
+	gpio-line-names =
+		/* GPIO4_A0 - A7 */
+		"", "", "", "", "", "", "", "",
+		/* GPIO4_B0 - B7 */
+		"",                  "",                  "pin-27 [GPIO4_B2]",
+		"pin-28 [GPIO4_B3]", "", "", "", "",
+		/* GPIO4_C0 - C7 */
+		"",                  "",                  "pin-23 [GPIO4_C2]",
+		"pin-19 [GPIO4_C3]", "",                  "pin-21 [GPIO4_C5]",
+		"pin-24 [GPIO4_C6]", "",
+		/* GPIO4_D0 - D7 */
+		"", "", "", "", "", "", "", "";
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu_npu>;
 	status = "okay";
-- 
2.44.0.501.g19981daefd7c


