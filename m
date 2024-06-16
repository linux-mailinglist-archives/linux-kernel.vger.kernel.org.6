Return-Path: <linux-kernel+bounces-216391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D214909EC4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6F41F21FF4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CE838F96;
	Sun, 16 Jun 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rhv25Wty"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA345957;
	Sun, 16 Jun 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558785; cv=none; b=osSXoa5IWOyQtMoIiF3cy7n4OnToN1aUVOv1bWZdQdl2TMdwk2I+aTZHFpeby6jkjGfaq6Cpu45t28XG/XPgbQ+/7TEtH4zTmmqZxWrJUsTfg8e+MM32/sKOax0Iu4npXynCbu8H/BWAOk+2TZtuVNk8g/xKD/mQqoJZgKIh2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558785; c=relaxed/simple;
	bh=xLtD3CUJ3A5b3eMpkLHWo+koapJSWAUCDA0EKrtJSLc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iipWQg5Co+/cSUk24yZlOng1JvoeETtygp6D4LGILq4I99SfwzO7ifPLvYVmos+udzjI6mjB5ARWJ87b4V6cNIN4AIoHaMgCmz4pI/21xT2MdxUzDgpEgGdK0yzP1bIhyh9T5xxd9ReuLoCMWyyy0Yz0OKYnuZcuK9aUg/Twr3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rhv25Wty; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718558480; bh=4TsNRvdG1NQQAdbELi3/OvMmViVBRkNVoBLMMVaWK1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rhv25WtyUpKbhPGwTOvBB68on6EsFbRmExJKlcOAI48LpWILVlBgEzS30ntlHhQpc
	 ZTsxshFvGQMOLCfO9iR33PUM5G9mMbBRHm4ASB4Xp0wVc70+28TIuqvRTvFv2uJPGL
	 fegiiSN20VBePGBLXpEmH7lqz32lz32fubcdq73g=
Received: from cyy-pc.lan ([240e:379:2260:ed00:cd33:e8cf:d8f9:bed3])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 5452D659; Mon, 17 Jun 2024 01:21:05 +0800
X-QQ-mid: xmsmtpt1718558477tyhsnv86d
Message-ID: <tencent_904B1050FBC0B10A172C263924BD518F8F05@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8RA6sM/aK2Q+9dZcLaP+4NJQa9FQkX6htwVjNCVrAuZ5gfdMI56
	 0aA8f9z8guNkaFGAs65Z/o2KgVEJYvcd/QY3iuRt0CW9VcRBXEAAKHD1Mvwzj5yv0iGpxDiftMD0
	 IuxdwCbMTidsy/7axyyLf1wk6W5M9kD2n7R0ar6PU4rRWmTYt8rOWeNoMpKyadSzBmWKHM/JxZbZ
	 r/cmk61LbXOTBOLXZlE3mZ6m51MVDkj6E/rv+pr55Z+z5vI2DjxZd5L1RzONPQihfDTQCJ9AldWy
	 wQDXtCb5vs2TrVnpkzJB7kVJ+1ouniZy25DC0uvfNChmXJOqkKr/M8Qdp4auqXO+y6akZbSPnqd1
	 OgVWlmJkZ/55zS7fUJs+rJPy8VoVzz1r6XQ77b0B9sDFS6ZHTKYapUX/n+k6D4kZDplYcEld51s0
	 q9X9z6oB54QYdB6icx6bmV46Wl0E+11AnX1cQGSj6bGI3EHORbFd5mTflyggK1DgU8Z1wB243J7d
	 9B6Sw161M0EYK8KH8t5LaQhpLXshVlx7ENsPz18qiP5wAY8DuOwNkfnkYSfja2qV/1hYKV9zuxC8
	 3G0iZY9PzFureZxC/qW1m8MbFD5etIwn0P7FPOP7wMYv97Z8TTXuQOx0sFYwWDA9ZfmlvVSDKkTV
	 8a5782w88sM0HuVlbd1yzKfao7fyNOkBPn37mahwfi7uOtWE8xxM6fGdmjaycoJVm+ZVB9Ty3Wm/
	 EDzieAYZRfNc6YRFgEX8rUO91O8pvEPjc4YHWZlXTxNxpy1lq7S3npjl/zCHeQldfOjxOA3n+YJ0
	 9j8w/fVoY8bpy8Cv3qxkyseSLhnBrvkxyUB9fwxnLqraM+BSJcUya9jp9IWJDOW4HxAjteAT7+ph
	 An+i7qBhyDVcMS3gGnG3kpi7mHyCB13aBs9z2JWb4mbSVdbBxDD+fAC1zshse4wu8CehtiNYIO01
	 m8Be11gHTz1xXuPndactt3OzVkZycHM6a8Z5WjQ+/0NgUstFIRyCe4KmGXFzUe5IkApHFJK+rTFv
	 K87rDm4ZWrZVJQYFYilZhF0XqMNGlTpRZSihoK8LZrWjKe+hu75uwD8wNypnUd0dlHcSvxYQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v1 8/9] riscv: dts: spacemit: add Banana Pi BPI-F3 board device tree
Date: Mon, 17 Jun 2024 01:20:53 +0800
X-OQ-MSGID: <20240616172054.3074948-8-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Banana Pi BPI-F3 [1] is a industrial grade RISC-V development board, it
design with SpacemiT K1 8 core RISC-V chip [2].

Currently only support booting into console with only uart enabled,
other features will be added soon later.

[1] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3
[2] https://www.spacemit.com/en/spacemit-key-stone-2/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/boot/dts/Makefile                 |  1 +
 arch/riscv/boot/dts/spacemit/Makefile        |  2 ++
 arch/riscv/boot/dts/spacemit/bananapi-f3.dts | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)
 create mode 100644 arch/riscv/boot/dts/spacemit/Makefile
 create mode 100644 arch/riscv/boot/dts/spacemit/bananapi-f3.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index fdae05bbf556..bff887d38abe 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -5,6 +5,7 @@ subdir-y += microchip
 subdir-y += renesas
 subdir-y += sifive
 subdir-y += sophgo
+subdir-y += spacemit
 subdir-y += starfive
 subdir-y += thead
 
diff --git a/arch/riscv/boot/dts/spacemit/Makefile b/arch/riscv/boot/dts/spacemit/Makefile
new file mode 100644
index 000000000000..5c512f4e297d
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SPACEMIT) += bananapi-f3.dtb
diff --git a/arch/riscv/boot/dts/spacemit/bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/bananapi-f3.dts
new file mode 100644
index 000000000000..023274189b49
--- /dev/null
+++ b/arch/riscv/boot/dts/spacemit/bananapi-f3.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ */
+
+#include "k1.dtsi"
+
+/ {
+	model = "Banana Pi BPI-F3";
+	compatible = "bananapi,bpi-f3", "spacemit,k1";
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.45.1


