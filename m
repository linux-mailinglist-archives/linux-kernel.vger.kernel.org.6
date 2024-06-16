Return-Path: <linux-kernel+bounces-216390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC9909EC2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BE01C214B0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5FD3F9C5;
	Sun, 16 Jun 2024 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cJLwlDdF"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF76129CE1;
	Sun, 16 Jun 2024 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558778; cv=none; b=cGcw5v3/nMF4MTCq7DUJeQvsL4ENqAxl5wheJY5CQdSaJK6tPoBijqiszjAr0DVKW2SNZvjQNk+yPquT/qWSC0MKOBntlS/mmchd2v0qOWlN3SWQllVzls2N9iB4MXDM3uv1BZ+Y26uLIzQzpyvU8KG9RrpblAyFSbQ/HYNQLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558778; c=relaxed/simple;
	bh=W7g6QkLbcNyOL0ibOl9QGuUvN0dY+konFUG2EdZkjY0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uTO+faZ0U3xGIBfxSltpB/lMDCwCQCGFDvMOdllTwSq0+o89ApRoxKMvdtdHRT/hFb7SiHIgR5zuAIEpFMuWQskMlmcZGqOJ4yhztnA0bZkYAezd04yogTGnESFM61Pyc75b1q9foCL1W6c1Zl6cmaN+RPpoR8FI3Jd6pi7FIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cJLwlDdF; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718558472; bh=r+q+AS8zVNgaO5tjAABF3jjVaLE+56ZLraN0N9jAFsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJLwlDdFxSeFuZpbLaIYBopGLFmuHUD8KW6B5UDnYoZxoxjoi2IGkQsGSbFZGDHgd
	 biZF8xS/8t/OXenRoIFa72ftBUxRF0Bz0w2P9h6yOwcxLF8x32gkvu3h6ywOPwtZ0y
	 93KyQrHIbTIxB5S5ViOfPjXRgFICm3fKRKy/OA8g=
Received: from cyy-pc.lan ([240e:379:2260:ed00:cd33:e8cf:d8f9:bed3])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 5452D659; Mon, 17 Jun 2024 01:21:05 +0800
X-QQ-mid: xmsmtpt1718558469tvh711cnd
Message-ID: <tencent_D3577BC67116D732862BE4A7B187EF4ED005@qq.com>
X-QQ-XMAILINFO: MFWpArBVhhGTvYuSpRDZ+TOs9ZidMP4HTE29pb1RTzNe4ftOZ44i/dKoQURc49
	 lp32wJdjjAcS+P00s4XeQDmzVhuwbMvAh+M2CTDGBlj8FPftYbUbLc6j+tbxQMyYKzYQfnONNK0P
	 HrEN9VoKfvjKrrJHMYJzXd5DWuBsVcw43zMp7EspUesriYk3PFzTU9lpPKcj/A3I0hMdqWZWc34h
	 G47p6mDORN40tJVfe+Vz2xlkFppyd+iFr0It3zDr4AEY9oJishCn9TZNCgft7TAwYDaUtMd2RNnk
	 2tTMEQqRSvmmtA4NND2iKvteZsMHkFHW6HGqgvH3x+F7iTxGaz8cipzRNGoVteNkdq7VoeuI6hJy
	 v2Wre3Se2UAPOiZYxDbafbKNSlkKR09u5jiKmOjs/FgmCdH9owftTYLXAnsWG0dm8PWzKmpeyzw1
	 izuYfMKXk7J7ZlhYfMN9pd1bGMMz2US5O4AAAmFT/8Czi6PaCHJIWIrpr+VVrtH6nLwwBQ+sSQ/0
	 2zZ7Sfkc8u3HIX1T0u8vRFEZe3I43CXZTXJlYvwVjox5Ej3c31Q4hv7rH++n2uJaA1RUrugcl2kC
	 W/HU6RRufYU84HnL4+YlhJP2CiUhsTawiUkeVR+oWqGQ2Z6L5qrNUxBT58Ba2WCsicKCfWOID04P
	 KkcXyNjYLu67aiKDG+sDj+cuYiCMN7brQLIrwZMExg539/d4VXpomaN2hhrrnMHx1ZFIltPhKS5L
	 DGZck9cRRoTbZSRoepWJVVAzhGAdgtAZzTeQHXHEHIgq3TbkmfoMhkQPqF6Axd3nu8fkq48Czgw6
	 ywLCCAlpsLiwE8nsH/qpFI8lqc+BLBA19dC12RkMiohmjuEHUhDTkzZUJ0+g3k4F8w2/AU+h/imc
	 Gq2gqsqMvJuWFQtKGB1pReYho9kF8OBhx/69zgrpLwkJpOL9qcZguWs5w6gVhvewQA9sd7BnvVWi
	 5mXlcyc+hregkJ/x5xKEvqab8C9jVbg//f81U+B91uUPo+ohoTNGGhdChZHqc3diWZVzHpf3nPu3
	 aBgXVbaMP3jdHT2r1pxyWjK1JZ6hs2ayASvUnjS2+p4iEMGkU5e+VPeIXgz7M=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
Subject: [PATCH v1 3/9] dt-bindings: riscv: add SpacemiT K1 bindings
Date: Mon, 17 Jun 2024 01:20:48 +0800
X-OQ-MSGID: <20240616172054.3074948-3-cyy@cyyself.name>
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

Add DT binding documentation for the SpacemiT K1 Soc[1] and the Banana
Pi BPi-F3 board[2] which used it.

[1] https://www.spacemit.com/en/spacemit-key-stone-2/
[2] https://docs.banana-pi.org/en/BPI-F3/BananaPi_BPI-F3

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 .../devicetree/bindings/riscv/spacemit.yaml   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/spacemit.yaml

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
new file mode 100644
index 000000000000..3b151fd02473
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/spacemit.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT SoC-based boards
+
+description:
+  SpacemiT SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - bananapi,bpi-f3
+          - const: spacemit,k1
+
+additionalProperties: true
+
+...
-- 
2.45.1


