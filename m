Return-Path: <linux-kernel+bounces-187765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17AE8CD809
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292E428420F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7E111AA;
	Thu, 23 May 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RXxeiBjj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259C1D55D
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716480268; cv=none; b=FOMP0jlq1yyvhzhOqtwVbxd0o4NhbjS2qf7/58bwuz1t5Nvo0dJ10VsGctvQQ+ArynV9Gkv+BU5VaVVHYI91baaZELww1U3Hs0AczWDVKUt04aSKldsbVxcVlQ0r/VrIIqNVt7adnibF3jMAleiVl/cK0HMUNoTEXfiTVLBcygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716480268; c=relaxed/simple;
	bh=EhTBCoWEsH6RQeHWfu+3Ppem+Bmf+xIMkgx/LOGt+8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BgysTmtM9dj6UVqcOK1AYqMe5cNQAL2bAZuUu1/uZ3xU9x4ey+wIGTP6zOArRr2MEzkEEO272hLbslC0AzFG1jnJfraBPCLYRpUU6fr2Ch1UsgNrvrtLWsqpX/QajS4L2Gito2HVei8Whdlk7oUNu8kUcvn9scIqFUJfGS2E+Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RXxeiBjj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b2ef746c9so254101517b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716480265; x=1717085065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3d3iyJqmM/1eDHi6IVV043bTCqbOnpQe2A0l9FAURNs=;
        b=RXxeiBjjFncawXnhuOMFZDJN5S23C+oXf0DEXlPgBqL108Uwku/Z+RmPh9S7gWEPsl
         N3ndt7oExXpqqgzIITD6ugUGkN8CBJskCX8Hvfz9638+vPGAlWPrpYmR6O6Zpj9mvpAT
         CuX7RWD8P3SXOSvKBQTb71FwKeFY+c68HEPKzUkDYoYI59yToe4VirrkZ76WP5q0KKTu
         jGAbtt6CKpjBjRJh3pEUB/95sARYDXm/7eWU3ef8p326OaFQnkkl4fY0XLlUI3EiMmSi
         fuevxJCBy8hHUGEkHG4jLxtUQAxJ0hKXk2DjXz+uSyKEiV29C0zbFYQbx+HnkRy/P5Te
         eKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716480265; x=1717085065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3d3iyJqmM/1eDHi6IVV043bTCqbOnpQe2A0l9FAURNs=;
        b=aYFvPuP+einmD1pGjXTxL8XBCKpQIsbIFcUHADUv+XGP8Wz//+eiNUrBqeeUyqwPJ+
         TntzP2bYZE03dDjGwL+3Ub7NiGRKUtCcyAlDRnGSWDGXhxYXSYLt3AmprFCaBNOlNNAj
         araI/GQshczT+r9ioPrhD8rBBCxiQnwrqz4BJ4G/AYmazQIWli6E9aGDWc0PuHiv9gAj
         Xb0xXqE+0rDlj5MtFeqFGXLyUwz9idAaZnIZJv7Sj9wAloNMZjLoiWirmcowRAniuQVl
         /NZNFiho6KPyX7Dsdj2jvpaZHqG2QnEjoeAYvfrZ49lZeDzI7yxCNPzneVbrhRwVTXXU
         UnJA==
X-Gm-Message-State: AOJu0YwcGElu6dqG21FbuztzwSFwCmbeEnhmoEXsUPRvngmK6UAcbXmv
	chqGXs07qAj4+SKP2xAuAlXMCPMsQvRZKOHsS6DrFTaTHvJyvI12wTGsOzVkzSKtGkv3YUXZ6JD
	TjBeT5ZPOrcx3p2ZXkqQCSsaUmw==
X-Google-Smtp-Source: AGHT+IESLjYZSJRI10bNAhY1mQgDdw0aTOQt2wYMTwe81yGAhnG89hGg49am+K4s35CF2jj0v1b5wbDesfLFNl9I1x0=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:6902:1207:b0:df4:db4d:5db2 with
 SMTP id 3f1490d57ef6-df4e0bcd6d0mr1593000276.7.1716480265117; Thu, 23 May
 2024 09:04:25 -0700 (PDT)
Date: Thu, 23 May 2024 16:04:13 +0000
In-Reply-To: <20240523160413.868830-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240523160413.868830-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523160413.868830-3-sebastianene@google.com>
Subject: [PATCH 2/2] misc: Register a PPI for the vcpu stall detection virtual device
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
 drivers/misc/vcpu_stall_detector.c | 41 ++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
index e2015c87f03f..c580cd7fd225 100644
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
+	int ret, irq, num_irqs;
 	struct resource *r;
 	void __iomem *membase;
 	u32 clock_freq_hz = VCPU_STALL_DEFAULT_CLOCK_HZ;
@@ -169,9 +176,32 @@ static int vcpu_stall_detect_probe(struct platform_device *pdev)
 	vcpu_stall_config = (struct vcpu_stall_detect_config) {
 		.membase		= membase,
 		.clock_freq_hz		= clock_freq_hz,
-		.stall_timeout_sec	= stall_timeout_sec
+		.stall_timeout_sec	= stall_timeout_sec,
+		.ppi_irq		= -1,
 	};
 
+	num_irqs = platform_irq_count(pdev);
+	if (num_irqs < 0) {
+		dev_err(&pdev->dev, "Failed to get irqs\n");
+		ret = num_irqs;
+		goto err;
+	} else if (num_irqs > 1) {
+		dev_err(&pdev->dev, "Multipple irqs detected\n");
+		ret = -EINVAL;
+		goto err;
+	} else if (num_irqs == 1) {
+		irq = platform_get_irq(pdev, 0);
+		if ((irq > 0) && irq_is_percpu_devid(irq)) {
+			ret = request_percpu_irq(irq,
+						 vcpu_stall_detector_irq,
+						 "vcpu_stall_detector",
+						 vcpu_stall_detectors);
+			if (!ret)
+				vcpu_stall_config.ppi_irq = irq;
+
+		}
+	}
+
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				"virt/vcpu_stall_detector:online",
 				start_stall_detector_cpu,
@@ -184,6 +214,9 @@ static int vcpu_stall_detect_probe(struct platform_device *pdev)
 	vcpu_stall_config.hp_online = ret;
 	return 0;
 err:
+	if (vcpu_stall_config.ppi_irq > 0)
+		free_percpu_irq(vcpu_stall_config.ppi_irq,
+				vcpu_stall_detectors);
 	return ret;
 }
 
@@ -193,6 +226,10 @@ static void vcpu_stall_detect_remove(struct platform_device *pdev)
 
 	cpuhp_remove_state(vcpu_stall_config.hp_online);
 
+	if (vcpu_stall_config.ppi_irq > 0)
+		free_percpu_irq(vcpu_stall_config.ppi_irq,
+				vcpu_stall_detectors);
+
 	for_each_possible_cpu(cpu)
 		stop_stall_detector_cpu(cpu);
 }
-- 
2.45.1.288.g0e0cd299f1-goog


