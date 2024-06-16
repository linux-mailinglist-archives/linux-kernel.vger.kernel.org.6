Return-Path: <linux-kernel+bounces-216387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15AC909EBA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92887281D91
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253CC3BBD7;
	Sun, 16 Jun 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xykLnlL0"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92513FE4A;
	Sun, 16 Jun 2024 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558484; cv=none; b=ggN53I/PKbugd6kNSlU2igukvB/2P8rGOaoTKgQ/wBhBIEcaXTZIqAAP8VvlshUzVLGNbKYMAGLEOKq7R3n5osjsn5kh3OeJ0gAJvOnhpt6NFdhDU08pi7HdrtzFsADusHUvgoVgvOTs2lU7whHqibydO9a2lA69n3/IwauOj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558484; c=relaxed/simple;
	bh=U5YtZnEHzBI5u/hJBuc7uRipSuoJTubv21Mh4iSZqbE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rDnW2eDcuoxFF9dIRxQ6aF+G4pQcZAR4thz3KnLH8DmLtEbbOKKLIblRn+B1DRSu9uMxVPVWUNRQz91PtRN/ioy1WcwLC2x5fuSpq4aHNJHDlzAwrBEAGivmYE/FHndViT7FHIbyTUL9HYf6YSxjHQsKkXPpjfScMn6kd2exExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xykLnlL0; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718558473; bh=h/Z20p48DwZNDsPa9mj4N+VQ+bYpq+oeTefGgtOFXe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xykLnlL0jWrga/A98t+1PB0gzWKBylzPqOV2TSX0wW4+Q1c5U+gbKW1fzRMyKw0yO
	 U0t7NqgII8BnmwG3auCHYaeHuKvMm3p+ir9lajh8IfGhg8KX2hw0mMKqF2X1J1JGlh
	 JSEvklVAMCKEA372a042Qm/djX1IzM0FjFgvkMjI=
Received: from cyy-pc.lan ([240e:379:2260:ed00:cd33:e8cf:d8f9:bed3])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 5452D659; Mon, 17 Jun 2024 01:21:05 +0800
X-QQ-mid: xmsmtpt1718558471t1v0fym5a
Message-ID: <tencent_2A51312A21F88DDB7C7D82A2DA8E8EE7B808@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujnNRNhosd+oxF8Tfn/AXML0ORtRxyI7ZEAXUfM26vh8ag8gCooh
	 rWa6l1LjZrVbdg/fCX2UsQIeUtAQNCVklDR3tjflLhf1pRXgMo8r7uFeVwHj5XYOS0t9ZVe0/CXl
	 0tDMZ+35M2HsT1aVGzKfT/OCdwo0sgmDmZ3S7WbgiVaZ1pbp5Ny2OHHUungOjhj6B8OoiUciPoz6
	 GxgRw4wn/JxB900WbKCFQsnMp+eRLBTchRSX1xnsDlhVw9ifu6436mP9/SjJO1w0lct4yd9KwfN7
	 SRySjU4E139y3Ba6sgoA+yaoU29sqliO+lU2+6p0Er7RMevoQaLBDvWNDsA/43h5hgXhz7rWld+o
	 YcYrUpLt7qzInthHD7KyOsBC5273ltwWA16781GrU1+haXF24jMxFjRAAjOuJ1iza0r12SR4jMBo
	 BDtDIohbYRDKLDj/dbbnNbjbwesJO8hTwOVKemOzMh3ivPo61eT5rZwt3vXztth+BJM8HmmMe5Ql
	 jLsEcky/pBZ2MWFfvaVs2jzGyRh5ocjvPgwalDB0XKKJ1lm6ohB5cjcB+OioskmNmAOzhCvcZ37p
	 TIZA86YGb2axLzHmKLCuOtij9TIo/EEwBEn5h6V1kvR6kQbzVmJSzhiLmuscL0pYLT1Zx26kUjgD
	 rNjYnMUu2yvp1sKZ62xOl119HhbwrpI6paKK5/iPT2eDJe1DYnWCPYCNDJ9Yoog9U5QnTB4fklYJ
	 E/9bLZtQUWxqvntGIAeayKlNmkyLLJH1ZdHgG9d0IzolqW23WTUKcqYHPSJOda04P6idFo9IRjM4
	 n+NHKG0G7A11MgAYAG5EcdQ1ieEfRnfIu/6eMzRLhbwVom/dXGU5LnTe8Xu28T1Lo6LQFuBYjxSM
	 Tx+gycwKmjPu/aCjes1TecKROjaJfv3xOdygX1L5DUqrlk8YVpnRVaTyd2cuD6RClcRzoFHA7Qnb
	 yMjAzT1c+OPQ7p6BwB/4LlJSkKZX6hm5abO9t4fn8fk7Ln1eLu42GdWVOo2syyz5lAUZZlmYrWoy
	 MY14PVZUJzsrDtyb4o1C4SFSaF2ZcCWJytbYnxPQ==
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
Subject: [PATCH v1 4/9] dt-bindings: timer: Add SpacemiT K1 CLINT
Date: Mon, 17 Jun 2024 01:20:49 +0800
X-OQ-MSGID: <20240616172054.3074948-4-cyy@cyyself.name>
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

Add compatible string for SpacemiT K1 CLINT.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index fced6f2d8ecb..860cf6a96b31 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -43,7 +43,9 @@ properties:
               - thead,th1520-clint
           - const: thead,c900-clint
       - items:
-          - const: sifive,clint0
+          - enum:
+              - sifive,clint0
+              - spacemit,k1-clint
           - const: riscv,clint0
         deprecated: true
         description: For the QEMU virt machine only
-- 
2.45.1


