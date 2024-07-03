Return-Path: <linux-kernel+bounces-239758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF0B926501
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC94B22644
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290BE181D18;
	Wed,  3 Jul 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vB447qfW"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95D181D0B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021068; cv=none; b=BGs7nX5Lv8Joae5ZF6NBdr5AHjra0YU9dNn30KMTxln7WRb+1FK2XNAB3VjEO8AoKgzpPYxVsmTOBopF2DLOm22aAE6sNWAYX/Jnkn0OqDUBmwbcojQjyl9FHGrrZrR/z+dbonVpZZ7enFtTYiTa3SUxjnQehFZNqdW7gt6W8LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021068; c=relaxed/simple;
	bh=wWQnGurz34dVjbYa9e51gztmmwliLAPDPJ50ZxG9qgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OtMy1/5XBnpCkRvKzGnz/LEV5WaOvTOVYJo/cUszUG4CHYkjh0bO/4YBsMDMUAhLwrqkMh2Sah11C9RVIz4f2MOo19IEl8KrVTKNCMqCuAb6xVCOitmnlQl6xfiCCxcW/rZpTFKgP9ge0VUlprAKvjzPUK75vvvS4SbN3K1xo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vB447qfW; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-36710f4d5c9so3659313f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720021065; x=1720625865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0VgYma1pZNwjgQS0gGYLtcG95OpDEpiYchTd4dd1CUU=;
        b=vB447qfWA+QqAReHdJNZ6pANeyk610uYUMJas++wzJz0l8thIZWaLmY3lOGRaMDbdl
         3x8pINYgZQpnfPz4oTUy9hHA6F8bQY24WDV1lBuIfHcZb1Bf4HxcsyYY1exSeAYf9Uut
         YrCKWqWk/F75yiXjcqpS611pjQ3qSB0a82xO/iYMhPrUECSpBGZ95ZI+BpxHQAeBaufh
         /4e4rQooSl64Q8gR++CKkt4DJH1B4CfjHtevJjCQEKIKYoaSeO/rbk4KVQWvSxEtNaxA
         mk9OddIYcXDezGG8WA7L2rkesLhlOCo8pIRik5USrbHTWxcaxMPdhsdv8aqW0qLRZMfk
         OIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021065; x=1720625865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VgYma1pZNwjgQS0gGYLtcG95OpDEpiYchTd4dd1CUU=;
        b=ULqDC4DmDbJJulFyKwRgpHKMyEbTD/QiHwWAicfgg9ge8H7Tcjv/PCRa0U73FKQBDA
         a3HeqXosZIW558L6JPdwHI00v24CddoQ23EroWCzb7MiS+BzaiKQq/acU/iop0jWkNLj
         Opychd2kvsRq54UlpPUiRjdvbs6s0QrAPns3Il7dWD8Jop8Kh3IAR/qiaZm6AbvwpnHt
         E5ZXM7GNIL1iqMG+upXwT8UjWLXTICnQsf+AlDGb1eI85yrAUtWZRyJymenjSCqqtFEb
         sS4BG2f8kQAovQfbwtsUgMIO88A8rWtlHDYt9kwtzQmg3J652RlAtQSe+WR/d+w8AJyn
         DWtw==
X-Gm-Message-State: AOJu0YxTfvGq1F7/fbl3PMFbntW3kqZ3fLMf45hYYS95HZxP0Gd9HfLq
	HHvg79+zRvUmczE7SWHVbu7+MIHCKbpXi1CxbYv3D6wyK1uO5BS9+A++s9m6J3ikrCk9CyeAgYs
	A0ry8HLJQnVQu1C3xkhW9sjh9rg==
X-Google-Smtp-Source: AGHT+IFtkau4PUrPfaFpoWT9WZrMlwkJ6nzWXCWyNHWwfM9MaDp702lOc0joHAm0FFW3M+zr4hwKVhi/sAR/SkVIlZA=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a5d:6447:0:b0:362:b9a0:1cdc with SMTP
 id ffacd0b85a97d-367756b2babmr19658f8f.5.1720021065201; Wed, 03 Jul 2024
 08:37:45 -0700 (PDT)
Date: Wed,  3 Jul 2024 15:37:32 +0000
In-Reply-To: <20240703153732.3214238-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240703153732.3214238-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240703153732.3214238-3-sebastianene@google.com>
Subject: [PATCH v3 2/2] misc: Register a PPI for the vcpu stall detection
 virtual device
From: Sebastian Ene <sebastianene@google.com>
To: arnd@arndb.de, gregkh@linuxfoundation.org, will@kernel.org, maz@kernel.org, 
	Rob Herring <robh+dt@kernel.org>, Dragan Cvetic <dragan.cvetic@xilinx.com>, 
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	kernel-team@android.com, Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"

Request a PPI for each vCPU during probe which will be used by the host
to communicate a stall detected event on the vCPU. When the host raises
this interrupt from the virtual machine monitor, the guest is expected to
handle the interrupt and panic.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 drivers/misc/vcpu_stall_detector.c | 31 ++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
index e2015c87f03f..41b8c2119e20 100644
--- a/drivers/misc/vcpu_stall_detector.c
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -32,6 +32,7 @@
 struct vcpu_stall_detect_config {
 	u32 clock_freq_hz;
 	u32 stall_timeout_sec;
+	int ppi_irq;
 
 	void __iomem *membase;
 	struct platform_device *dev;
@@ -77,6 +78,12 @@ vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
 	return HRTIMER_RESTART;
 }
 
+static irqreturn_t vcpu_stall_detector_irq(int irq, void *dev)
+{
+	panic("vCPU stall detector");
+	return IRQ_HANDLED;
+}
+
 static int start_stall_detector_cpu(unsigned int cpu)
 {
 	u32 ticks, ping_timeout_ms;
@@ -132,7 +139,7 @@ static int stop_stall_detector_cpu(unsigned int cpu)
 
 static int vcpu_stall_detect_probe(struct platform_device *pdev)
 {
-	int ret;
+	int ret, irq;
 	struct resource *r;
 	void __iomem *membase;
 	u32 clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
@@ -169,9 +176,22 @@ static int vcpu_stall_detect_probe(struct platform_device *pdev)
 	vcpu_stall_config = (struct vcpu_stall_detect_config) {
 		.membase		= membase,
 		.clock_freq_hz		= clock_freq_hz,
-		.stall_timeout_sec	= stall_timeout_sec
+		.stall_timeout_sec	= stall_timeout_sec,
+		.ppi_irq		= -1,
 	};
 
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq > 0) {
+		ret = request_percpu_irq(irq,
+					 vcpu_stall_detector_irq,
+					 "vcpu_stall_detector",
+					 vcpu_stall_detectors);
+		if (ret)
+			goto err;
+
+		vcpu_stall_config.ppi_irq = irq;
+	}
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				"virt/vcpu_stall_detector:online",
 				start_stall_detector_cpu,
@@ -184,6 +204,9 @@ static int vcpu_stall_detect_probe(struct platform_device *pdev)
 	vcpu_stall_config.hp_online = ret;
 	return 0;
 err:
+	if (vcpu_stall_config.ppi_irq > 0)
+		free_percpu_irq(vcpu_stall_config.ppi_irq,
+				vcpu_stall_detectors);
 	return ret;
 }
 
@@ -193,6 +216,10 @@ static void vcpu_stall_detect_remove(struct platform_device *pdev)
 
 	cpuhp_remove_state(vcpu_stall_config.hp_online);
 
+	if (vcpu_stall_config.ppi_irq > 0)
+		free_percpu_irq(vcpu_stall_config.ppi_irq,
+				vcpu_stall_detectors);
+
 	for_each_possible_cpu(cpu)
 		stop_stall_detector_cpu(cpu);
 }
-- 
2.45.2.803.g4e1b14247a-goog


