Return-Path: <linux-kernel+bounces-383661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BCE9B1ED7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A47C281BB6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179516BE2A;
	Sun, 27 Oct 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEKbTQaE"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D81A187550;
	Sun, 27 Oct 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039835; cv=none; b=Fw6WLOHxILpBgfh+qrF/vMvTWiCtJu5hb1BjQv6+M+5Z88+uEBBblM90uO+i+NT57GiLE5ltpOPBNEP0qcQyA/uFs3x1KfCAbq0M20FCnh/i5Seqqv923Thk7NgMAq9iOX+qB0h+Fw6ab927l4aMu40QjCeVjgQal7ZOQzy+CuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039835; c=relaxed/simple;
	bh=CoVWEnlBPdjJCJefeQaTQ8gbNhHuSPoMiBvydRFIuAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2eCjuLhkZjL3JhP8qu6wcTJoPBeIqw0yrASd66JKhmVEq8Byxi+SlT+Skt/axMg3POAQBPhhgERQQU+eFC+NxCNnMq43zid/QPu1ngOVM+Ezy8gpc8MP015TAduJyCCnnlTKiArI7DiJ+TV3M8i4df0b9nT+AdtfsK+O8LoFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEKbTQaE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c940512711so647977a12.1;
        Sun, 27 Oct 2024 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039831; x=1730644631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc9m6bP/Ec4/sf5Bz+f2cFTipH3TOQ+xgwUgV2+F15w=;
        b=VEKbTQaE2xvYNyrlHkzrBv23T3EGaNnjd32s5g6xfNY6dBxB1w2X2psillfPkEE/US
         AcNqN0vJwFdsTHAD63OOIZyQZqhiUR1iWFzpCDb+ZVNIqP/+S7nPAJ8Pg7/siuVa1WUc
         Wt1B5bLS10wo+/wjHK1drXRuUZ8GzY5ILDz5k24yiV07h7EvVaCPbqsBg5+vTPbqddW0
         j33+VANlZ93I7hOwZIQIMNbbdwf/lB/xQaWMUr6610ynAmPaWWOAGHWn6uXbBV5WhnDX
         hPs2mv51K0/SSE3y/lQxTszFK/zqoO2xurNfiVpW89brVMGXlEdbDi1LUzYQssy6f22J
         B/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039831; x=1730644631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc9m6bP/Ec4/sf5Bz+f2cFTipH3TOQ+xgwUgV2+F15w=;
        b=kJtV11F9vITfpVBt7pi84HrYLHALlqQ+9YS2AbOSuyDqMbL7H8E0RnzXsIg0H5JxK3
         vejQI8+0NoBqjBxcUDHQtylo98nTHReQOxi4OwOtbJwzlOqiQzlnKRyFQwsAqfKzB75x
         alK35hrFKUFIKgISXsG/wH/ANMQeqdSFEOijJpE6IJ6+kOlKM/tEik0gTSb5z1AMQPk/
         Vi/DRXX0M9dFnidGfBYrRpoiBeaNqljj8dBOp6JXd8vqBpSQb+mBRLcbLF3BPBeuXFUs
         q+rb/9pmdpLkYbIPNW2/azSADxKeL4pd3UK1wcsEj7sA8l1wV9VayuaOnJUuXPUDN9Ci
         zKZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/0EwoFkoviR9xurZSgvJPUjvlQe6xJ9x4u15f5pSHCX2BSmTy6YJQbF7ZXXrU3qP9NbtJNplgsC9w@vger.kernel.org, AJvYcCWxKgoAJklg0gKUtOicw4RMQJtWONMoER7ukjHTsHqGHlwhQobT/bnRUXtKrRrKjiidinz7OyV9Y4c893ot@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5ouRUZAX9ArVtBiFjgq+2KPwk/6x6cWV8CJtTvE9MNrN7k8g
	LUZi/yy3eYbT5i4JN0IzzxpC3wO/GKnPvatV2Ju5xevWwDyc7AR/
X-Google-Smtp-Source: AGHT+IE987XMb2XqdO4bjToqVxrbKSYbHnI2DHlCsTHNLo8W7QfuQ5iCb2V07aiTSvnU+TcyDnsUvA==
X-Received: by 2002:a17:907:3f28:b0:a9a:4f6:756a with SMTP id a640c23a62f3a-a9de5a4e3a8mr181941166b.0.1730039831389;
        Sun, 27 Oct 2024 07:37:11 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:11 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 11/22] dt-bindings: net: snps,dwmac: add support for Arria10
Date: Sun, 27 Oct 2024 14:36:43 +0000
Message-Id: <20241027143654.28474-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hard processor system (HPS) on the Inte/Altera Arria10 provides
three Ethernet Media Access Controller (EMAC) peripherals. Each EMAC
can be used to transmit and receive data at 10/100/1000 Mbps over
ethernet connections in compliance with the IEEE 802.3 specification.
The EMACs on the Arria10 are instances of the Synopsis DesignWare
Universal 10/100/1000 Ethernet MAC, version 3.72a.

Support the Synopsis DesignWare version 3.72a, which is used in Intel's
Arria10 SoC, since it was missing.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 15073627c..d26bb77eb 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -26,6 +26,7 @@ select:
           - snps,dwmac-3.610
           - snps,dwmac-3.70a
           - snps,dwmac-3.710
+          - snps,dwmac-3.72a
           - snps,dwmac-4.00
           - snps,dwmac-4.10a
           - snps,dwmac-4.20a
@@ -88,6 +89,7 @@ properties:
         - snps,dwmac-3.610
         - snps,dwmac-3.70a
         - snps,dwmac-3.710
+        - snps,dwmac-3.72a
         - snps,dwmac-4.00
         - snps,dwmac-4.10a
         - snps,dwmac-4.20a
-- 
2.25.1


