Return-Path: <linux-kernel+bounces-209698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7F490398D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC240282BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717F17C9F4;
	Tue, 11 Jun 2024 11:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IICO/Ua8"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3017B4FC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718103721; cv=none; b=ZMNjwMM+i+XEm42kx8Hut0wkgcul1HzhVSlfkx5Ee5VHU53k52WSbty4fNJ0U6zYuFlTpHZxyB/Oa+mlgdlKmBqE1SnTXcYDQ6q+B4LCeee8yCrY2g69YeR8xVUDU2lf2v1PRNdWQ6Rvke7XNY1gpFk4n8xFr+IKpWCZHbPXt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718103721; c=relaxed/simple;
	bh=hVjEo+blCJxGsddc696xzRtFvhre3OGMva5lV0FJE8c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fiekInEWtJdmz8coBcUkg4M2Lu+gVPlFOa6rbyMwJi1oOJvoTDZxuaVJuWqvrxHx0Fhnwb+40190KbTqez62Ibl640cY9EhBSmuW06pjIKuLd0YdOvdCWOr1IL2lrd1gMaOsdwBGcGE8UEwv8DpXZyk+rdejCTuqCrYpcuCp2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IICO/Ua8; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62d032a07a9so17230717b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718103719; x=1718708519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JgNB9lB5mnUvAM1aWt6j4JFJQrdeNrcqasIyh6QwE3w=;
        b=IICO/Ua868Zm4TgRsRYN7sb7OZIgLKt+/hgzdyKCGZcHaebOYbyM7LqdnNzB+6QXdT
         kZNkp9mGulLb+uEa+OdppcLZJ36vr+SXiRLtCnJ+nCzeWNOQ4ArLHmbOfjTNmZd1RIVd
         FuwEIg40mKYucTvBUPkU8SGJn6j2VhEJR6HtRsW0Vb+nECfgs0LKUlz2nXnJZIWKDpIj
         DmCDG+m6O/o3LolwbqGbhx5JgKgCaIGVvb14jChk+UQezjBiK6Qa1L+MQQgqpLIvV/i9
         e3F5UWqcTjMgYAWfHRJdMMea53Re3lOqiQjG6u/K9eYz1RiGXeWdDwDbnEO53E83WETo
         21Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718103719; x=1718708519;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgNB9lB5mnUvAM1aWt6j4JFJQrdeNrcqasIyh6QwE3w=;
        b=gqyBC2TJ7oH2eS2HZHbCTgB6FnF2c4VCsHC66YYmEXn4EjezOdJvv3BMyA7sdKBpwh
         D3YOufmt9eE6NmHFywXtQtkaCxF2aAiUkHPjf4i2AD4GoyTo5WHrSLUJpHhk7xCyX+JB
         3wqwENmpTvpAvLZPtjW2KrI95WBWGmWchcnHmzlTuPmhrd4h0YKqO9MahMT6nOyxWKNF
         QZ4DDBxt+SGD4JxYsShrW5HXtuK7sthUGper3yBNoawBSRYmHZ2Jwv06V4ccuvYOLOu6
         VjNwZECtigiqUJlVg1SIoZlyVY04g19peyXYjw6KEwp8RdjN7vcx8oY3EEcL6qjZWy/0
         nEhA==
X-Gm-Message-State: AOJu0Yzm0WPOF4J74glQDFbpyy0QGgLA4xJWdXY1yJctRce2uLC6aPxP
	jF4cqI7dQLgkHbLJT8egaNEj5wzBm84njpsVTL6Vhj8gahLeYNggTHj4E1/cj3rgj6G/iBE5Ftw
	m+yuJCijjTnOQVyJQZSf9yKO0dg==
X-Google-Smtp-Source: AGHT+IFSbYCftxFJqrawKfHzd9GWjB0tkwxSO/X4qBgG4TzhaGADPqOdnzH8OrsK7qerwrpD1sI05Rd+7M1bqF6iaY0=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a25:9984:0:b0:dfa:cd81:4c5c with SMTP
 id 3f1490d57ef6-dfaf6645c46mr2127390276.8.1718103718655; Tue, 11 Jun 2024
 04:01:58 -0700 (PDT)
Date: Tue, 11 Jun 2024 11:01:37 +0000
In-Reply-To: <20240611110136.2003137-2-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611110136.2003137-2-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611110136.2003137-4-sebastianene@google.com>
Subject: [PATCH v2 2/2] misc: Register a PPI for the vcpu stall detection
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
index e2015c87f03f..17808e71cc30 100644
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
+	if (irq > 0 && irq_is_percpu_devid(irq)) {
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
2.45.2.505.gda0bf45e8d-goog


