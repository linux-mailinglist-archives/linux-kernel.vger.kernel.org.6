Return-Path: <linux-kernel+bounces-372223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285679A45D0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66011F245E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C934C20CCCB;
	Fri, 18 Oct 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DDNT3Y70"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428E62076CF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729275775; cv=none; b=ScWiGareYpWbjc3/VR463ZsEBQCsL56DE/ek+4ptwzyeVHVPu0fKEBQAF9sLCuIt9J6Lpxhj4zWZzskm6XIJJlufIj4rf186Q4g8R5ZJ1BjN95YFM3Q2CJgV7XdGUGKdzAlhXdDM1OmuV2VMS1RDL1RJKwFY7dFby165S/UYElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729275775; c=relaxed/simple;
	bh=u0936GXmUPAueskjfc4uoMJNjHkAAo0gqXdz0e8uc4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd66fx7JcFg/IEC/R/M18VhtnmiIJKrJ/4GvCqI8CK3akiuyGdlwz1MczfyQQZMeI9+nVw73dnVZGpnSG7XB2Z2Z1Y1qNSon4kup6bizE1kaoUCoQYqUndoPSCW+iLixiTde1An7lJc69roWhj3CxEPaNQD5jHlhwBsSLLLOqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DDNT3Y70; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-718065d6364so1213274a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729275772; x=1729880572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YY/gZTUZcE7FwDL5y9yZ5kb3qybjDB9ydDm5phd55y4=;
        b=DDNT3Y70Rl20NzvjrvIkS4Mt631Xol16zbw6RfKqNpjdzFiLpU98tH27uiptmIWstk
         VZgjvsseQ9V8qL1Lof4EqCWgznhYCcUK7d/6GeaxYT3Y61zbUnQfXF9YXF1ua42fhPCt
         HOt5x7XDALUGz8dZ/tR46lH0qoOukUXN74McU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729275772; x=1729880572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YY/gZTUZcE7FwDL5y9yZ5kb3qybjDB9ydDm5phd55y4=;
        b=b8BVBnyQRyiaMPsU11dWOLZTrBZMle3V8gbQFFjwuKZrAvbswM1gu6xt0q75NGudxy
         q+FMHpMldRufHAALHXnnHnhUze2dcitN+iNKPf3jj1OqXdrDEFlDS4hGuxTFOxPTJFWZ
         ewEDhwgg//iwyRZmReVmhR7yjl0NxbqQ2f1FHW1ML8mPlivJdfe8X3Zqr3qBYXh9N+jK
         +yHP/gVnpl6py8/IDlNKWvkFa6oyQoqOKOk9FFVzNrpu2DQCryrBKNAg/NNJjvy6VsTP
         ODcWE2Gs4PEs+rPdAD3pWUwtWRFJ5RDMP+IBUOE3o1AzreFvEu/DnMVTgMDLdAir46Te
         +aJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvM/7vLo6QEzj+TuTyADR1EipSq9MKvMhNZDLQRCAoVEdpzQOEeMZ1ZyyKbA3SQA6Fb9117XUcVsNoc7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwShklFUQxl3+bqy+cDZU82BZzhvG++benAUutok631WrUxGNc2
	jUANGzfl2+sBdELIrDmPeJYPh72vD7X6fHDUnuPOq3JMBEs/Q4UmjzbGFFSxWw==
X-Google-Smtp-Source: AGHT+IGcpmdltCUQTW2s4jU6bQRrXu/0O4LNqJ9bfrIVMrCKcLJUAx2oJIDi0KGExJyBGL3g8cHHNQ==
X-Received: by 2002:a05:6830:3988:b0:718:4e3:1b27 with SMTP id 46e09a7af769-7181a6ed3ccmr2995907a34.8.1729275772249;
        Fri, 18 Oct 2024 11:22:52 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde114d782sm9307616d6.46.2024.10.18.11.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 11:22:51 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] RFC: dt bindings: Add property "brcm,gen3-eq-presets"
Date: Fri, 18 Oct 2024 14:22:45 -0400
Message-ID: <20241018182247.41130-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018182247.41130-1-james.quinlan@broadcom.com>
References: <20241018182247.41130-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support configuration of the GEN3 preset equalization settings, aka the
Lane Equalization Control Register(s) of the Secondary PCI Express
Extended Capability.  These registers are of type HwInit/RsvdP and
typically set by FW.  In our case they are set by our RC host bridge
driver using internal registers.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index 0925c520195a..f965ad57f32f 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -104,6 +104,18 @@ properties:
     minItems: 1
     maxItems: 3
 
+  brcm,gen3-eq-presets:
+    description: |
+      A u16 array giving the GEN3 equilization presets, one for each lane.
+      These values are destined for the 16bit registers known as the
+      Lane Equalization Control Register(s) of the Secondary PCI Express
+      Extended Capability.  In the array, lane 0 is first term, lane 1 next,
+      etc. The contents of the entries reflect what is necessary for
+      the current board and SoC, and the details of each preset are
+      described in Section 7.27.4 of the PCI base spec, Revision 3.0.
+
+    $ref: /schemas/types.yaml#/definitions/uint16-array
+
 required:
   - compatible
   - reg
-- 
2.43.0


