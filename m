Return-Path: <linux-kernel+bounces-183187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207038C95B8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 20:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4FFB21372
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 18:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E05535D0;
	Sun, 19 May 2024 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCcNlOCr"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED91524DC;
	Sun, 19 May 2024 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716141599; cv=none; b=CTFbKXL+RpBqZQpbrn3SRY4GXbM8DXFekvWc14dBWxlxAXia534PqHXu0ST28hStMdt18KYuB8Z3ggTU7uooxB1BRZ3pPxYG+If+N5eS3hHOjWuJMIFa2uBIGXAVTKytWodjb/dG5b4lVMnd4gmeRjJhLNAqQ31dHpoj1G3DOHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716141599; c=relaxed/simple;
	bh=DBEqztXdiLtGKWT3YKbxFmKsOb8T99x1XdfRmFqNGTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X4bxRh8exKmWLmT5yhOG4Hw9O5FwKm+qOGVwDIIlVFJ4Hw07mHHCzIq/WXLXLE2EX0TARGuq0hdJnbtaaqU4SNx5jiptgfangogCpvtvwzVRH1zpHq5ALWCK0aAOOztwehVTNMizroqLbaa8U2TQLp09cmPD0I1i4YyjLLQw8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCcNlOCr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-663d2e6a3d7so815821a12.0;
        Sun, 19 May 2024 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716141598; x=1716746398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB5y4Fy1Uw+dKMHXzCD53I8CL2I1Bp8CZYIt75TaAuQ=;
        b=mCcNlOCrhyKgkk9cNd7u+5EP0PAJ3L9VFPtx3/bjpZxSWAKvIEItteSUHlP2VnXGr0
         6nxzKTqq+MLT2tXeI8Dinln2VOIPOd8sslwpUTA4xPqIKRfGmxt/93+NJUjvIXWbke+j
         YjvSsCnhSSmL2c+GquLCCqEjnDosVbN13AwRhsMYrXFqv7mRvGxp9WeRyoGWUWvunWyg
         6i5m5j5YCkPD3GfjNBJLDMH2q32i5whQhwWhVH+ACit/IEvVCd0L6cTdqGSLxyWA1Ani
         KrpldMFIpcakJQcsNCjsgSnPVRli1dl0S/+WIFDNQAf3iDwWYcx70KYEjUS8lGvxvqgL
         G/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716141598; x=1716746398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB5y4Fy1Uw+dKMHXzCD53I8CL2I1Bp8CZYIt75TaAuQ=;
        b=uwSlQCrS5oWORJdtcU1U5ydgjAsBGbw/KFxra6mV7myjrzRGUoVrdRg/ecgqzvVpUl
         cl9hUEElq8n+DhPG3lfyaDcQsnRqX4XZAZy1bTruMxROk6n3A3Dri2AZa6aj+ripjcCQ
         4EccDb85crGkgvZOY8xeesMGR/asDgMeXoYsi+rt6I4X1L822HxoR1g36cTzzdwWgr/R
         ElONVuoTJAsPwZPTs3Fcc5l3VB0vdEpqtCTc1IZc+CbvrkpLZQDRbbEth1ZoOsBqQHLJ
         BtrSDGXhFhmSDMPFA5wd8NpvpHzwBsPYpfIRVvZxh3LYM8hyx5YTfKop0Kp8Gc3zQvXg
         kd5w==
X-Forwarded-Encrypted: i=1; AJvYcCX7Rd+BcoEmzdRHRkogA74hou3Vo36W3ltk4wcVcLKMazf5dRvzGGiCE0NxGxT1jkXrSAY5qIYogbbtUl1G0X8cGiITc9UGyVLc1+mD8VvFMatfjYJD3g9C1KPrkKuRAE+NZAUPFVqBUA==
X-Gm-Message-State: AOJu0YzUhSC40T0Z/fFayqbqTEfc/O+mzxR5880C2nopw6eIM156wou8
	oLZPyqFmrjvu0IvFGRLbrziZWccMoE48/lSOqsh6qkErtTObpOZ1
X-Google-Smtp-Source: AGHT+IFBTgvJd2LTs7qh/Ad8VvDv1vEGhqTvOWriZjtmSKNU5N91CUbRn8JXTv/uVEqY+dr6ofCLKA==
X-Received: by 2002:a17:903:41c7:b0:1f3:3b0:61a7 with SMTP id d9443c01a7336-1f303b06359mr775465ad.12.1716141597893;
        Sun, 19 May 2024 10:59:57 -0700 (PDT)
Received: from localhost.localdomain ([223.178.84.79])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f2fc5a015esm9424325ad.14.2024.05.19.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 10:59:57 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
X-Google-Original-From: Kanak Shilledar <kanakshilledar111@protonmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] dt-bindings: riscv: cpus: add ref to interrupt-controller
Date: Sun, 19 May 2024 23:29:06 +0530
Message-Id: <20240519175906.138410-3-kanakshilledar111@protonmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240519175906.138410-1-kanakshilledar111@protonmail.com>
References: <20240519175906.138410-1-kanakshilledar111@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

removed the redundant properties for interrupt-controller
and provide reference to the riscv,cpu-intc.yaml which defines
the interrupt-controller. making the properties for riscv
interrupt-controller at a central place.

Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
---
 .../devicetree/bindings/riscv/cpus.yaml       | 22 +------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index d87dd50f1a4b..b90bb83c8e73 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -101,27 +101,7 @@ properties:
   timebase-frequency: false
 
   interrupt-controller:
-    type: object
-    additionalProperties: false
-    description: Describes the CPU's local interrupt controller
-
-    properties:
-      '#interrupt-cells':
-        const: 1
-
-      compatible:
-        oneOf:
-          - items:
-              - const: andestech,cpu-intc
-              - const: riscv,cpu-intc
-          - const: riscv,cpu-intc
-
-      interrupt-controller: true
-
-    required:
-      - '#interrupt-cells'
-      - compatible
-      - interrupt-controller
+    $ref: /schemas/interrupt-controller/riscv,cpu-intc.yaml
 
   cpu-idle-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-- 
2.34.1


