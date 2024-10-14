Return-Path: <linux-kernel+bounces-364546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D9799D5F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300CA1F22EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8161CF2B6;
	Mon, 14 Oct 2024 17:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="gcCczIL2"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384641CF2B2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928488; cv=none; b=hqxMK4WJ7YDTRq9HO9R4xmE2OZfgNtnRR3CSENqQ1Y0snaqu6fUKqIdJFelNm8GjIOmHa7vxFv82OJh8+ivTWnVJqCI+zSWUEMuSg9fmtGabAxj90xmyzY9t/poHbbh+PwrnhIppXT2oQpusRomfEXVr+7xJrUr9r7tcdC+MFkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928488; c=relaxed/simple;
	bh=j8PRpBk/lIiVe/T2RTs5CZVHcgqvJy9CT3C0m3PRVNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJ7O1ZEEdIQ7soKmqNG2UyJ8mG6XoDbGKMQ8vFwUB7wxmat8xvyn5K2pYUBDCIwGQw8gRkRoYoEO44ZvbdAxi8e2oKWm6oY1ZVh4EPQNW6wXwtpwxV7YH0A4u7bbrTpplVWLGQK6Db32MmKfBU6aT+kLCNhpFwTWRS6X3ApquDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=gcCczIL2; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e483c83dbso2702908b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728928485; x=1729533285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ib0LzHxCGUP2Of7LzCAvLTsWSTSTY5vzi6Axbb4I5D0=;
        b=gcCczIL2vD5NxmIJu4XU3mzFGSscbuC5Q2wz7lw0TlYmoABIZpBTmy1kP1IqZa+Eds
         tvFuncHhFc1izI61ygrqs5RmKIUxpLId8q5vRox7Gxkj28OS4RPyi+lRMTEic9oSvNOj
         fhh9g1CzXKjYkni3P8msQ/YyAZh5bJgNVyx49hlulMoc1niwtACAlrM9htalqFo5rJ39
         S6vstqOJ0/OLvFdoiMXlqbxnP9nzc8Dss8tUvvMEwIs9VwkzPdL41a/pTADGf+gh65i0
         m9CQ1QzVZmqgJVXqkPMQsBtIZSfuNZCxumur5SbHxuyGHsmXfNqjsUo1FOohSmr0lGXJ
         UhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928485; x=1729533285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ib0LzHxCGUP2Of7LzCAvLTsWSTSTY5vzi6Axbb4I5D0=;
        b=B5iil8uPadvriB+H+HGksQAxd4PpnAm8+qwzAe5hW3lCqTBCJg4pf6JwNfUy8NIv4S
         qB+WOL+BMbdtvlcxzI0ENuMF8IbpGTEpdoeLZX48k/GOFjT7Je1SMoiTK76/OcF+vVb3
         ZYznxJXfxQ0y5X/DsShXDyALRt+a0oE3+JYAEgwdDSu95fiCjipd3LyiH0V5znqHRphZ
         /UeVGrbEkKGJ6V4o+NAJpeq/a+mDcN82Hn95WwvXSgTSw/KFheQKR1sAqavfN8ttVmJx
         EsgFHXox+T0s48edsC8J2GDkA1cv6s0Jtkf74fvy0BiWptNCy23I8X7UgdLmeSCQhLYy
         B4gg==
X-Forwarded-Encrypted: i=1; AJvYcCWKx5rM1wPBP1oVGPoaaa/zKI2QgLbpY9RoUfJjJqJykr7Mk2wlJUH3F4yEUcrfgw7GcqazJYY3+6zVu94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGBbXh6vXDg2jzGVK0NdoBs2N2d12ja8FNasFHVLPLnkfyc9f
	wRbn0TxHAjYF4XZ4MDLPze2x3PxN/xbOx/S/ifGJq/IvvH6g0H7Zpv+9qUugR8w=
X-Google-Smtp-Source: AGHT+IGn+w4J6ujcKmDO9lhPgpFFwLHQORkcQhURsA6+UDHkjEM67AndBJceCtyLERFJD54nONsRxA==
X-Received: by 2002:a05:6a00:ac7:b0:71e:4fe4:282a with SMTP id d2e1a72fcca58-71e4fe430admr12455912b3a.2.1728928485620;
        Mon, 14 Oct 2024 10:54:45 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e49a7e5e7sm5611109b3a.179.2024.10.14.10.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:54:44 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Mon, 14 Oct 2024 10:54:25 -0700
Subject: [PATCH 8/8] riscv: dts: thead: remove enabled property for spi0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-th1520-pinctrl-dts-v1-8-268592ca786e@tenstorrent.com>
References: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>
In-Reply-To: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kanak Shilledar <kanakshilledar@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1

There are currently no nodes that use spi0 so remove the enabled
property for it in the beaglev ahead and lpi4a dts files. It can be
re-enabled in the future if any peripherals will use it. The definition
of spi0 remains in the th1520.dtsi file.

Suggested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts | 4 ----
 arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts  | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
index c0cf9b086f81..86feb3df02c8 100644
--- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
+++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
@@ -150,7 +150,3 @@ &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
-
-&spi0 {
-	status = "okay";
-};
diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
index f60b1879192d..4020c727f09e 100644
--- a/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
+++ b/arch/riscv/boot/dts/thead/th1520-lichee-pi-4a.dts
@@ -59,7 +59,3 @@ &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	status = "okay";
 };
-
-&spi0 {
-	status = "okay";
-};

-- 
2.34.1


