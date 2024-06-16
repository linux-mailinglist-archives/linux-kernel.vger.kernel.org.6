Return-Path: <linux-kernel+bounces-216386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950EE909EB8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22011C20DED
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA36286AE;
	Sun, 16 Jun 2024 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fOx9DXUz"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B6739FFB;
	Sun, 16 Jun 2024 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558480; cv=none; b=SGcxzuSpb03/KgVRjAZ6ZaEu3pRq85sm82IEFRxvc8gN00Vpvk/8B4U16Cm5RMawzE8uFLyIqY8k6SGiEVK9hdxUVwanw69JAiNgamMo/mJIKrv7S1LwMHjKq/1BX5XhoAbfDHquOVo+myfZQNq1QDBjVWZmEgxWtcSBAJiJ3dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558480; c=relaxed/simple;
	bh=XJRpVJ6q+6fZ3iJUTtv6tSoasYa9YGg70qQsdIRLcRA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MYMogLdEZqeOuQgP4D3mszMmujZ5G7SMnmDqs09T1tyHlsmqorS5Ff2AacFnTEQvwVSPw11NGiyRttl+NvfLQm72RnbTv8eejML4Gq741N+VYeqJ3LUWeSAUZAcAPpgPdxqvNQmuG0Zc/uHynUrUDbjttvpzXi0EyBAey1ycqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fOx9DXUz; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718558475; bh=JKwEkli64nV+u6UbVuHjl1rryovcclGC4cUSLhcp14k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fOx9DXUzRSKFB3VzlEM/jMlO1VRg8rsx13uXibzAGqP9ajpLRg6dE5zHAMGY1ju5a
	 yMeGSyugu5WgVb0qIo3x/YnyKHd2NNaHh3I/eTDBUEmZJ8Vd0h2eTMRQo+PmrrwIFb
	 0E/v9NC+ptCefdClylUJDVPlAZ9DMFWZsXzgyahA=
Received: from cyy-pc.lan ([240e:379:2260:ed00:cd33:e8cf:d8f9:bed3])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 5452D659; Mon, 17 Jun 2024 01:21:05 +0800
X-QQ-mid: xmsmtpt1718558473tzxk4bd50
Message-ID: <tencent_417C31822BDAD48EF8B84B312521318DBA08@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIe57aA5A2c3PUjTCRk8fYygcDw9FdDkbDlvTVj9MFZs4odlQdLBD
	 YD/KHRA3SyQc53FC3gTWE7zU4iEZXY2rUPh3czyoAQBojOkU4fNo7/pYeokOCJrBF6xiB7X7o/Yh
	 lX2OIHvyQ92ujGSwwrXtNQPxtmhGS33EECAbjvL5rRJkaFnJVqpiiCxylBpzZhYVvz0oBIU8QGh1
	 Qs4ZR+WEH9fUdmBwBNWnJOP73Y8PQdeG2phEQI5UzKSqjPc/bQSgGeYibBLrqR3Qgs8Ft6RY+LxM
	 8TTNpqhzKE4LUEVLko4rbvNAgNPFAcm+qQ5z8cRDJ1izWhFjcj/ygg081QhhL96fMZG8ccPzX611
	 T6EYJ8gSVVUYcBl6RVQxv0n6e/TEwiEZcygN4c2nTgZE2wgIyPUa3Y2BFnndHjWU4X8og5C6SStq
	 6jzyK8b34os81x99rcPcyB/4vBqomvDYU+i1FCpp9AUYeC9Nfn6+7fCRSvQ8X2YDjPYOxDQa1g9y
	 qAk0sHK1u2231ZmuU1JYZpaQCaSyaokXzs/MgFT55LnKt5ZAr+QuWHVcc66gVWtTIN1y9dKShH2X
	 fm6drPZRdJu4P2SScVouk6pc5zyzkP1rIcxFMcpvcCl+QeYWxa2iMqYo90lqhMo7ZFC6/H4zwfA+
	 PWLs45zLuzIdkAxDvMxzPMSmGJ8UDM3chWrzWs0uiPP4eMaj4JIicLHm4Uk3M2VWQNsupzbX14Nm
	 7SP69SO4y1VmgVZlO4l6L6LjTdcixX7+t5+G2sp9SB8dEEjipjJiHBTbQgEcw70CxZXgprtdkndU
	 ELgAXBwwcRdLPH4/hIQvD8/kWvqR0BraENdNNjXMtsje4se4bCBafRzRMw5lg1mzph5aQnYtTXnp
	 EsR5uOtG4hXaJtoCYmXHGHnrOQKm5LRdv99Br2svKakQTCnUADAhZIpwvZJwwwY8ch9Qtao/nQSp
	 TLLLW1lrIy5IYynnuoC4G9D4O3Cr6DhckL96mS8VsRGzTs6L2mkItZHaUjBmLcsZGSMFvxNgKxVW
	 O6U4S27vGC2i2Pa3naOQ6Udog83miNQ+eVWp0gOw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Subject: [PATCH v1 5/9] dt-bindings: interrupt-controller: Add SpacemiT K1 PLIC
Date: Mon, 17 Jun 2024 01:20:50 +0800
X-OQ-MSGID: <20240616172054.3074948-5-cyy@cyyself.name>
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

Add compatible string for SpacemiT K1 PLIC.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml     | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 709b2211276b..3d0426b56904 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -59,6 +59,7 @@ properties:
           - enum:
               - canaan,k210-plic
               - sifive,fu540-c000-plic
+              - spacemit,k1-plic
               - starfive,jh7100-plic
               - starfive,jh7110-plic
           - const: sifive,plic-1.0.0
@@ -71,7 +72,9 @@ properties:
               - thead,th1520-plic
           - const: thead,c900-plic
       - items:
-          - const: sifive,plic-1.0.0
+          - enum:
+              - sifive,plic-1.0.0
+              - spacemit,k1-plic
           - const: riscv,plic0
         deprecated: true
         description: For the QEMU virt machine only
-- 
2.45.1


