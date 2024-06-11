Return-Path: <linux-kernel+bounces-209697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D3490398B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F15289793
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574317B503;
	Tue, 11 Jun 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kfh5vuv2"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7417B43B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103719; cv=none; b=LrmWLo3qhoD3c4Uosuxxe9RMOUi6ijQzd2TYdIGpt1Wv9JIixSBERKBiErU+jbY9U6/XtHMTU6At1qzg9bH4pMpj1cRsuEJ3AHImAWYT2Xol1u0MRieBySdRqTWzY/4Fnzu9iQ/+ehHmpIOO1ZSKBvlc9QH1RhuV8pjX/Ox/stk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103719; c=relaxed/simple;
	bh=ERjV5BJYroAXFIaG6FmVQOy7+GFyAqC/Q40IjLgdSn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QTjcjREbv7tbLPLKfgjqQzCNI7KEKw0YUoj0HhbKq8NNE0yMCSyfNZwFiIr680xDmu+VsKRVzhWZKJ4zzqBVh6/tm1YxsHnVX2lDrRK1eD/1FHtRusx0ZHlzQAbO/idM+Fq2wUFNjbsXHXC9yr9nKX+/oEkoc6aA64K4+aLx36E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kfh5vuv2; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-35f2030f868so1736317f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718103716; x=1718708516; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xD4B/30d59fgI1TQcHmQ/HHM3gNeD0CWu+CBJTxBNY=;
        b=Kfh5vuv2ic6piktH3Pq6vRz5gbg3y3wMOwyPSqzWVpgwCU5LgBf5K2g/rA/0lc6QUC
         IJe3hoopZjmqKYxw+W8j3r044JHG0WqKd0H0xMKhTp9R+9kYLuvjKUttqU1LIm/MpCtP
         6drarUoejmkykFR8P3/qW1+wlT7mKPCDa2+Py/KEayGzX6tnfMx+141DkRIUzVtXEYIM
         YOq8sT2I5QupmZRCRiy9tYUU0/uyiMhztjQbhGac5YpVBiz9GUdyuTGnx9WjsqJE6xuR
         ZX1/2BCIU71BSvhFOVGx2N9G9imzWvDVN9sztNv9aLBMxbitUX5FfCEKaOLWiXaX2k75
         F9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103716; x=1718708516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xD4B/30d59fgI1TQcHmQ/HHM3gNeD0CWu+CBJTxBNY=;
        b=dCsa1PYkSMKr45giBO04zLoOCyFU/mbCmuTzEacAE/afEmAOvBcWKob69/lE56c50N
         INqc9vTnzuK8Hl8GRICu+2Dw7LZd481eXrmcLqcsXZ36tRscunJHrsGxIQpfWRwBDmpH
         au7RrFeRPvTV5SSSVRRfX6/5gkS65GA2MfaSIyiXxBu8kNlI2B4ittUCLValhfRqSbUP
         3EpOwxsudY/I8MwhwV1HwSkKywE39H9l8m0HjSaW9my+GLTShEMzg9+gtk3zW5yzIM3k
         2VJN2fK4NKFz5m4Tx0GlkSs2M17BJzx7nSAL932gWBKvmJBSdSaf9ygaoJItpscEC5qb
         /LIQ==
X-Gm-Message-State: AOJu0YwGx8oDlbpwjTXfLCRx0olNN6n8tjN/Bf1QVdfVQOTxUY8cSnLU
	auT3BlLQzldoxbx3ls63R05g8mURIsNpr8OMM1hdcpLdK4Xx/xRlfQYauhHvxWPtoG0Kg1P7hvE
	WuvVONtkgZQ7xbKAu8pEuARO0jg==
X-Google-Smtp-Source: AGHT+IGU3H0l+d9EL3JRHC0rSDckCHdlyWQo2hHVYLkbmSAXuycL6I3ZIDoZrWBIveWXM3ewNz2C0kt+U5gq8pmJdY4=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a5d:648c:0:b0:35f:3041:9ca0 with SMTP
 id ffacd0b85a97d-35f30419d43mr596f8f.10.1718103716414; Tue, 11 Jun 2024
 04:01:56 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:01:36 +0000
In-Reply-To: <20240611110136.2003137-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611110136.2003137-2-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611110136.2003137-3-sebastianene@google.com>
Subject: [PATCH v2 1/2] dt-bindings: vcpu_stall_detector: Add a PPI interrupt
 to the virtual device
From: Sebastian Ene <sebastianene@google.com>
To: arnd@arndb.de, gregkh@linuxfoundation.org, will@kernel.org, maz@kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Dragan Cvetic <dragan.cvetic@xilinx.com>, 
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	kernel-team@android.com, Sebastian Ene <sebastianene@google.com>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

The vcpu stall detector allows the host to monitor the availability of a
guest VM. Introduce a PPI interrupt which can be injected from the host
into the virtual gic to let the guest reboot itself.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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
2.45.2.505.gda0bf45e8d-goog


