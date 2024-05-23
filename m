Return-Path: <linux-kernel+bounces-187764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BAD8CD807
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEF41C217B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29C318C31;
	Thu, 23 May 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luLavgD8"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98AC14A82
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480265; cv=none; b=Vpfa+TMTT02oqGWZcN7eBXXskC8AE6AleCfEiwWKBgtWMpuJPjjP//Yqgqu6fOJ6Wo0EHHPeXLNG4G5bGz8WtLmOb232CVMXZAVMCmyF3ix57X/HNM9tFPdsGPc2KHMezkIuqPEPza+Ssv3IxcdAg1NCQfInAhi2JvU37NA1iVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480265; c=relaxed/simple;
	bh=03UHZfKAtBNlLwH0CZMJBaBFQPZIRqFCOkef15fj/yY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hoh65Bf5IUS+yK0LNlJX+PbQEFxjhng5Dh/VYGYnG3sQfS/zDPiDv2JyltMpzEtaLVov9wQA0gOjB6yiUmhEtfJcSplxCmcmq93eGkAI1UfltYixBIywlHV4UH+d9KTQ7EkyK5cITw3OaKimiCnsFE78XunJRnda8CAnyuZ2Eto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luLavgD8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df4e86c7d39so3128455276.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716480263; x=1717085063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPQFdz2LOhxHiN/om4KkSSYOqO0RGIsb3SSw4n/adp8=;
        b=luLavgD8dR10ePRdop1LhwyVY3nKrJX71S8QspLtoxY8hD1DuvibOQXkGCR/BVP97Z
         +0HiVUit7ag/eToyMNXtTvp04WKznIYMSaEjU40DAoc3cg+AaFTprma1zYmS/4Vqo2FR
         +FcV6EQv/8HEswN/2PyLGMtUsAWnBVIHX6JQHzgOJaT7XLoTlqIKJdcLn9tBowCRaldv
         LUssJKCKRZSWeoxORo0y9SUnkMm+0djpSgT+lWqxz0RZL0MZqPOsKjrllVzvtitwlbGg
         b6H91ORze+yExjuwtoGy27YLh8G768unFnDVxxI9wZSmpNpEgg/es4Xs7XDH5WJ5IHKY
         QTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716480263; x=1717085063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPQFdz2LOhxHiN/om4KkSSYOqO0RGIsb3SSw4n/adp8=;
        b=Ap4kt8jujstYL9F/hPprZBpRHYjqTjkcx0ly8keWawPKwh1qQQXmq72OT+mRnEGAUn
         XEH8NySoBK3+eOo+nutcrJPr8ILffnq6ruWNTlq49DScR7BxsjKqrKm7KuWW2wHPvPWf
         Hk49Fzf9lUZftooutEN9sPVO9mUGFW/D3DaZuuefiV+OPVfMnrqRU1SEuFMxItTKE8MU
         cubW/FPp3J09a0Ca7q/z+zF2up62Ck9J7yZxLtmxp2F2cy8fzFc+2jHV8BfpjxEgOLkW
         4wZoY8YEfMqEuuKI7ehcr7F2BNoXAMJ8UO+xDLeHq6+sNYQpElvKpybRyG5GmWJVOg5r
         clwg==
X-Gm-Message-State: AOJu0YyH7ijQ6i6FxUV5HdLVVvtSCAtoBHcdWF9U2Y3Sm/TPus2kv97L
	OgLHXqPH9ObT0a/LJWLAjZPI1iWZdWzvSarFYyWmU6CKqYMbOmsDQgJ4FwZH8wpDng3U11aDA5x
	v9H2R79R6nFisAMrGrr9gnq3buA==
X-Google-Smtp-Source: AGHT+IGLtprpewNaPwvA33vAxsqmxIcNdZv7l9A4L9Dlu5J4R4Npwq8RXML9iq9TjEe3qMDW9kUt96ZxiOC87YwNAhY=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:20c1:b0:de5:3003:4b64 with
 SMTP id 3f1490d57ef6-df4e0a80c05mr417513276.1.1716480262730; Thu, 23 May 2024
 09:04:22 -0700 (PDT)
Date: Thu, 23 May 2024 16:04:12 +0000
In-Reply-To: <20240523160413.868830-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240523160413.868830-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523160413.868830-2-sebastianene@google.com>
Subject: [PATCH 1/2] dt-bindings: vcpu_stall_detector: Add a PPI interrupt to
 the virtual device
From: Sebastian Ene <sebastianene@google.com>
To: arnd@arndb.de, gregkh@linuxfoundation.org, will@kernel.org, maz@kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Dragan Cvetic <dragan.cvetic@xilinx.com>, 
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	kernel-team@android.com, Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

The vcpu stall detector allows the host to monitor the availability of a
guest VM. Introduce a PPI interrupt which can be injected from the host
into the virtual gic to let the guest reboot itself.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 .../devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml  | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml b/Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
index 1aebeb696ee0..e12d80be00cd 100644
--- a/Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
+++ b/Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
@@ -29,6 +29,9 @@ properties:
       Defaults to 10 if unset.
     default: 10
 
+  interrupts:
+    maxItems: 1
+
   timeout-sec:
     description: |
       The stall detector expiration timeout measured in seconds.
@@ -43,9 +46,12 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     vmwdt@9030000 {
       compatible = "qemu,vcpu-stall-detector";
       reg = <0x9030000 0x10000>;
       clock-frequency = <10>;
       timeout-sec = <8>;
+      interrupts = <GIC_PPI 15 IRQ_TYPE_EDGE_RISING>;
     };
-- 
2.45.1.288.g0e0cd299f1-goog


