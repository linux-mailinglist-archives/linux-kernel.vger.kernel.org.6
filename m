Return-Path: <linux-kernel+bounces-174353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF7C8C0D86
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1512842CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF851494D9;
	Thu,  9 May 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="reG0mO/y"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06BC14A4DF;
	Thu,  9 May 2024 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247243; cv=none; b=IoFTKVeQFkZTPVBjpIqFmUVEie6Fm2QwzYHcbMY2taAKHWlt9yypdeb/7k1of2oZEHlqCxZgJhHqfflLlhgNR+M03c5mfNuC26jLgxvsUAQcPP+QFnzf4NZcjXZEcgI16+6CehGTYjhWPi9zJ6aGg46fGDcA4E2ZIbZup7KyCvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247243; c=relaxed/simple;
	bh=MtCUZOEf09vm2s3UfRmmEbhe99AQfnhKa18eN3mnrso=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=nzfu62I+wxVyDe9fUayoBcsWaS0p7wlEZWdSlxLaiyIVfz61CUQZPGwv3UTnX/PLFuLDpGpzb8rBhQM03bO6sRsU6C7kCZLS7CBL633Ik2I4XnW8pty9AAEC9N3k7Lc2USxBXOhRy1jiMm54Mmwm9Hk577ZT0GwatpasTXW17pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=reG0mO/y; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1715247227; bh=uHRrkhKKY/U0upUZfJkXb4BY8bCTGf1SFZ8EyfT1G3g=;
	h=From:To:Cc:Subject:Date;
	b=reG0mO/yMD0Allajl/2aMO1ahdJMd1FG86iTLZ031D7u5g0tYM1mYE3kORENzH04s
	 GQ9UC1LP2QjvCQCjOcF/3MrO5DJk6oNrTrboudF6/TXbLNoe+iijW7tiuiGnvAeRzw
	 zVyBPSiMtLFK0Vh+p7YsW2wjyYMX9DX/LXbR0ZiU=
Received: from cyy-pc.lan ([240e:379:225f:c000:ddd2:5a64:482:d6f2])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 86B97886; Thu, 09 May 2024 17:33:43 +0800
X-QQ-mid: xmsmtpt1715247223taum3m4ji
Message-ID: <tencent_B61C1370E7632842D61BB7F9FA0515B44D09@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8uL2HVuJBhrc2zAVCXYqfSMQbCILL5ryFnjPQlfSSZSmyhy0OIS
	 51hz1Aj5/VjBhn/J3uDwgpLwGwdPxe6mo0HKpyqEVWoVZD1ju4+BSdIZLKYcr1FqxTGvLrKobGz6
	 9MRknHCRtI6YvQTjMv3elKw/uuseaZvLe+uwd92wJ+4Y/ZrEBJg6rV4kXrp+581iAqZbVyxiE19W
	 WuqjyKz1jdnZWTG747f/PaHiKP+38krSpqFhgycfkgnsx77GiKoMDxQfI8x8Y8ynZhDQV//Qz+DH
	 xja4FqphOyVQUcnHNPIf4uVLUaA47Lp18wJpQqGO8sLWnqs8+8gnoYXvOFgHXuzv4rwFCCOPU02C
	 dgxsiD+mjvY16vcI6QgHkd2+clL+jKlA4liQst7W0+bF7OEvuvmpIksFU703rPDhAQY0lByg1bVG
	 ooud3Hq4c4KlTsDwIhRKRnbenhW0cfSmOya03euiBpH9xJuJ4WdlsSaQygHYiD76It9XTfoFRpZw
	 tUTkXSz3rxx4e4pl3SIQROzzZZ0qkcnl4G+Vg1/C3QaTcdEp0eo2xcwrcW6CrY/Sk168Y/YAwTqt
	 zzQEhV8Z+EqwzKDRo9/tpCfx9ry+bkjCr6VEiK1dlBNkwwmk14el1KiG9m/vN6p79Bvc040hha0O
	 3p7hySI/w3VOuB9/Xqemjuf+YtRjntvFCkMmknFI9LTnryALuCB/mlExTlcVbY0e2DD4POPIn8Fd
	 qQPXkgf7XZtsX8q5+kRyWUA5tYZqz7ekw+SJo+QHKvLNhRL6nn4JorQDFnNzolMgQTUkLlS4Xjhp
	 p7zpW/I7ccH83nQ+Euqv2R3XFEXfHzlFhinZw1Uo78unA2WVwgDed+rOCOkipJwUMTRwI5zgvIdv
	 b6FoBWxUi16ON2TOOzjICCTvV0QGfeNVVNxKW7D/7HrCnH2TB5xwJHLBl5QXxUC0rglWkdMCB7Gc
	 zOluQZfO+YuXCG5LlxNL0YfrT1qh/lAlRQpTHEKQCxYrqqYQ98BTPdz9W/qVQBsPHEDBEWuro=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH] riscv: dts: fix isa string for Canaan Kendryte K230
Date: Thu,  9 May 2024 17:33:11 +0800
X-OQ-MSGID: <20240509093311.1943337-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original is a string in dts that has no "zfh" or "zvfh" extension,
but the K230 chip has them, so I am adding them to the dts. This
patch also reordered the Z* extension in the isa string and used
canonical order for the category as the first key and then alphabet
order as the second key to meet RISC-V ISA Extension Naming
Conventions.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
prerequisite-patchset: https://lore.kernel.org/linux-riscv/tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com/
---
 arch/riscv/boot/dts/canaan/k230.dtsi | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
index 95c1a3d8fb11..104e08ef5869 100644
--- a/arch/riscv/boot/dts/canaan/k230.dtsi
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -24,11 +24,12 @@ cpu@0 {
 			compatible = "thead,c908", "riscv";
 			device_type = "cpu";
 			reg = <0>;
-			riscv,isa = "rv64imafdcv_zba_zbb_zbc_zbs_zicbom_zicbop_zicboz_svpbmt";
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zfh_zba_zbb_zbc_zbs_zvfh_svpbmt";
 			riscv,isa-base = "rv64i";
-			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zba", "zbb",
-					       "zbc", "zbs", "zicbom", "zicbop", "zicboz",
-					       "zicntr", "zicsr", "zifencei", "zihpm", "svpbmt";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicsr", "zifencei",
+					       "zihpm", "zfh", "zba", "zbb", "zbc", "zbs", "zvfh",
+					       "svpbmt";
 			riscv,cbom-block-size = <64>;
 			riscv,cbop-block-size = <64>;
 			riscv,cboz-block-size = <64>;
-- 
2.43.0


