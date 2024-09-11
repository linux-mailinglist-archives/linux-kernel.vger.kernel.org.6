Return-Path: <linux-kernel+bounces-325132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1304975563
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B364128A5A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BEA1A2853;
	Wed, 11 Sep 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="qjJPoobB"
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3613219F122
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726064945; cv=none; b=Xtzit6wUkDR4KsdMz26Ze7q3My11SxQG1rbxHF/Q2eNrsgR/HsLBJkVX9GIbmh7qLjU8wpS+dH9tQQz5F43VAgGQLeKDEeRRng8jc2eDPqOb+qZALLPFeNdHjK4J/8M4IPRlpLMtwu8uDmYg31hArr2JwGEYmnKvb7aSambT8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726064945; c=relaxed/simple;
	bh=8QEuGIvQLbpjRaTFhH2ZFgvXVrDeGK7gSc8y+imv6Tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MW+R0rdDPWxKh47XvkNAJCanWwv6x81t5Gop/zKiTAMqfWcrlulSZhjb8t4PF0opE56yILgSVkN9DmJZhXhe2qXNSPRRvzxqfrIGCXmr+gqOzRO2K5sxls92B9v2ofd9v4pdAfK6H7s3ZP/HxSTQRiy7sZ7rUztdHE8Znmvu5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=qjJPoobB; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso4597306a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1726064942; x=1726669742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P5J0U9Nr2VJWT4UwLDZSs/klCxJAz9CderPyv0geGrk=;
        b=qjJPoobBsOwywpeei7kzIeKsEzkrEoNl2gNgSdPdYbQkoRK0efTx95jMT7MlWOcowN
         un7InA1eOsCMSAslLwJqcKhyOGMci8KvzR4GQhazcW7W30UuAWiVfugFIBOGmGPXwTmd
         UmZnhNyjKcIFce3GKJZZjuAKpuN8phRqIkEahZHgGFhTGebcw0e6Q+X+9kNmoOa6h+q5
         IdEQQOIPfBIWShAeTAVpmt2pKj4m9LzfmC2Ug4vmP65Gnj8j5P+bEaxBAwUwymJ/4EV8
         xkh5OVWqVjcCu3VbxDLU8WDi9AoSidA5g8PGfaqeNMjXj4YF1joL91/dj0YzcvTG3j8G
         ndzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726064942; x=1726669742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5J0U9Nr2VJWT4UwLDZSs/klCxJAz9CderPyv0geGrk=;
        b=raxWxXLOvcktSEj0u8jbvFzqfKiif0KZtzy3TPR13I03+aZ5uo4K2ZE4wR0tfAGSHg
         B/Tw64EjlfGUkzaefSc0Istpf/V3qBlqqORzYb3AckkW63wee3QBu5KHm3lj2oiVD30L
         H7b9/NMcgWHxMfGoDQ9zYlqNvhX4wVyQ8n/i2tJYlfEJ95ObheZyyCs4nrcZz7a4Jo55
         QX+qyUf8eH9ONyA7Ceqq2MK+MkfhUg3zQIqmyuEj3U3B7CMX6AzoF+BtLj41Gb8KREAz
         uVQFqC90J1Rkr7XNgmKenTK7QDajUd/bGROpikWv69g9GYkWjOwi+LqcontwleMVzLky
         rfzg==
X-Gm-Message-State: AOJu0YzVqcVH9OzfwnpXIlXoRL9zgZ11MtyS3ZeVuHQ/aRW7shYfxi5A
	zrkfsdcCaVjQrXQ41KT959uvaz4zK3Iv0QXZym92lJzpkjoLOMawQUdnTZ0B7Q==
X-Google-Smtp-Source: AGHT+IFGDayOTdMe5/yDVHYyC7ZbsU8VPfRxdyEq2dpfA1fEpxwlc2wdxNYQ01Lri1PLU0mE/Fh6Jw==
X-Received: by 2002:a17:90b:1187:b0:2c9:5ecd:e3c5 with SMTP id 98e67ed59e1d1-2daffd0bf4dmr18926938a91.33.1726064942586;
        Wed, 11 Sep 2024 07:29:02 -0700 (PDT)
Received: from [172.16.118.100] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe46c9sm10639116a91.11.2024.09.11.07.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:29:02 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Wed, 11 Sep 2024 19:57:25 +0530
Subject: [PATCH 8/8] addon_boards: mikrobus: Add GPS3 Click
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-mikrobus-dt-v1-8-3ded4dc879e7@beagleboard.org>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
In-Reply-To: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
To: fabien.parent@linaro.org, d-gole@ti.com, lorforlinux@beagleboard.org, 
 jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
 Andrew Davis <afd@ti.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=8QEuGIvQLbpjRaTFhH2ZFgvXVrDeGK7gSc8y+imv6Tg=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBm4ajWfF8HnWfBpRhubrg4fXSooUmChhIDDWBYX
 YkeSu2grEuJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZuGo1gAKCRAFzvXHieVa
 dPDnD/9VKgXwMYmbYiNZDn0qIW01JVcxnkYswlcqt3J9IFXKxgf95CvBhUm2GOHf3upxhxWOrof
 PucLmzSRCO5K5GN/kNAKGNR2WUMe0p+fmhzC4tzgUZYfANMK9yVrwJSX0ot4UoqzPQGUFTSVeUy
 DFot/tuROMVehuPsXnJ6Ku/R/FYuVD8fpHuj3c2QLVnr852mqmt2eOrLNxiqsYFlYly4iAulXS0
 AiyJXCLB/g6hPa/na+7Ko3HmDG7Bkkp8Uw0KMC2sQ/goQM0evweTnBoRl5ulz9ADgGJXfJxsaxW
 XidaFPyzj6z3HD4XKlxYGd2YbM6AJJSVVvbxiyvyoK+1O5/Im41irPY0tWtzaCqS3JPirTIN/ew
 ADTPsLbnFTYajl5eB+kfEEoQ151Gy0Ug6AcmsfPwpP9LzvrqSGoCnWUxFpGu1LwyRddrTD/d0iH
 ySln21m+xMwlWNt5EpvYk9Ds2ZBy5MfnGb7qCNaEZPQ1lpsNKU8U2PZimGlQOJqjHzWcg82t/i4
 1LvwZh1Xj0KuSTfsVIbM00G1zmnZbFFuceiWNQ4sBtanORq+CAwQdZV/nKLgo+g97gEvmyQjfC3
 s/5KC/kK6UecXIphGeKG8z9NYVLJM5CFhQhLQD5jo4i2PtNfwe6ixQbInLrIPEfdnxLKLxkavTg
 H6stu8WIX4LLbGA==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

- GPS3 Click is a UART MikroBUS addon Board

Link: https://www.mikroe.com/gps-3-click

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 addon_boards/mikrobus/Makefile         |  1 +
 addon_boards/mikrobus/mikroe-1714.dtso | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/addon_boards/mikrobus/Makefile b/addon_boards/mikrobus/Makefile
index 4c7a68ea9504..e4b3d1aa7001 100644
--- a/addon_boards/mikrobus/Makefile
+++ b/addon_boards/mikrobus/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 dtb-y += mikroe-5761-i2c.dtbo
+dtb-y += mikroe-1714.dtbo
diff --git a/addon_boards/mikrobus/mikroe-1714.dtso b/addon_boards/mikrobus/mikroe-1714.dtso
new file mode 100644
index 000000000000..c8a0872ba954
--- /dev/null
+++ b/addon_boards/mikrobus/mikroe-1714.dtso
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/**
+ * MikroBUS - Weather Click
+ *
+ * https://www.mikroe.com/weather-click
+ *
+ * Copyright (C) 2024 Ayush Singh <ayush@beagleboard.org>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+&MIKROBUS_CONNECTOR {
+	status = "okay";
+};
+
+&MIKROBUS_TX_UART {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&MIKROBUS_TX_MUX_UART_TX>;
+
+	gnss {
+		compatible = "u-blox,neo-8";
+		reset-gpios = <&MIKROBUS_ALL_GPIO 10 GPIO_ACTIVE_LOW>;
+	};
+};

-- 
2.46.0


