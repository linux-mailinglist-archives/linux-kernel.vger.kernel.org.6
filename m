Return-Path: <linux-kernel+bounces-258728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F173938C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C510B21208
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E3316C6AE;
	Mon, 22 Jul 2024 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="TpZ8jy41"
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6DA16C437
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641406; cv=none; b=eWdW1fROazg/w8OJMnrFHZSqY5ErPZUVTECDFKa3P0LnPyh+wG+I6OwpstI0ugWxOSoMO0GsX6smhud36EIi5Q9yR/nMTQEFd9TwYjv7/7Ns9Z/mMHHx5JIrxUfPZ9SMkZdGYyrl1oSC1yZZRo9OK6rSQ78eayczLOkCGDPAa8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641406; c=relaxed/simple;
	bh=A4I33nibX6sQIz/KSjvrrW2ZqZnbsn4l26E8nv0hiKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afUxG1lqbycbxtpdepWMwnFmWviXy0NNdoCOGq5kFQUd6STROWlib93M95lfhC112TnEvA4QbAu2AlP319vxQw4hAW3DgO1XoeFd+WMwnVy9jEcjeT0yPnB3x+B7XIvLZWBxxxBx9CfAe3ksdqAuFhiDKYk2/l/NPN+x4Z6Mv6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=TpZ8jy41; arc=none smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id AA0C8322D24
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641400;
	bh=A4I33nibX6sQIz/KSjvrrW2ZqZnbsn4l26E8nv0hiKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TpZ8jy413vklg9e0xGsONQT30xSJKSzP4R86024JLYpW9bOnrBbco89Mg850LmxqB
	 IpqTmgQSg8U97sW6YlmzB82jnTuzWxl9v1s9td0EfMvIjey1hN24RKYbf4Rj36DyKt
	 0L6BpDuEYKzoTmBqEvs1ubEpUkBkzhtiJEBefDaI=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id 73242322CBF; Mon, 22 Jul
 2024 11:43:20 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx408.security-mail.net (Postfix) with ESMTPS id C3E7432247A; Mon, 22 Jul
 2024 11:43:19 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 9978E40317; Mon, 22 Jul
 2024 11:43:19 +0200 (CEST)
X-Quarantine-ID: <DMT6fGodWfLp>
X-Secumail-id: <b5cf.669e29b7.c19bb.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan
 Borne <jborne@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>, Yann
 Sionneau <ysionneau@kalrayinc.com>
Cc: devicetree@vger.kernel.org
Subject: [RFC PATCH v3 11/37] dt-bindings: kalray: Add Kalray SoC board
 compatibles
Date: Mon, 22 Jul 2024 11:41:22 +0200
Message-ID: <20240722094226.21602-12-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add Kalray SoC board bindings.

Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3: New patch
---
 .../devicetree/bindings/kalray/kalray.yaml    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/kalray/kalray.yaml

diff --git a/Documentation/devicetree/bindings/kalray/kalray.yaml b/Documentation/devicetree/bindings/kalray/kalray.yaml
new file mode 100644
index 0000000000000..3da817da9b2fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/kalray/kalray.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kalray/kalray.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kalray SoC-based boards
+
+maintainers:
+  - Jonathan Borne <jborne@kalrayinc.com>
+  - Julian Vetter <jvetter@kalrayinc.com>
+  - Yann Sionneau <ysionneau@kalrayinc.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Kalray Coolidge SoC on qemu
+        const: kalray,coolidge-qemu
+
+additionalProperties: true
-- 
2.45.2






