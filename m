Return-Path: <linux-kernel+bounces-226972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C291468F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F8B91C21F1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750B0131BDF;
	Mon, 24 Jun 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fn+58yVh"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29E3130A5C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221986; cv=none; b=GXHQo+rOL/wulEQEYHcMZx6z+yJQYpEcHSuqkSOOSHjC4hDNpStxbA8707DDZgv7u/vnXkEpT9kNbGy3bBqP/IJnZ5DsuC4lh+hUIyIhEAdWOGELeePrGLEPHs4+0YhFf67fs3SDgED1lJV3z0+lro9W/Mij5GQxotIVDXOyWSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221986; c=relaxed/simple;
	bh=A5DpDOGB5YJ5dDGPTBnxRtEIUltYaPmh9k8UX38ucjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+MGeFxlscBmkn3jv9a5Ekxn2TGl9IIQz19vp2nwAhk2XjEwjKiNwr8pwM8C6gBriY3kHd7+tRUZak28NPM3veYo1qdF1tDho0zWUND7z4CpQcY6SRjvKNSYzVkpixHLaZNRM5QLu1qGGRlUd9mEgm/oF54Su4oyvW50paX1N7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fn+58yVh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36226e98370so2497022f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719221983; x=1719826783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JD6H/71ed+HgEm6na1DA8I9uAZ8qxNavgSQIFHLcZQ=;
        b=fn+58yVhY38N2gsMq7yvUqnwg2IZntLNHiCMKrJSmozRfPGmAq3wLRic/GOhGSedA1
         IXnPyDxcxvqX5xkZ6qb3LO68k4Pv+4s22my0SakALtzI93Vmtbntq/gOMrOkyBOgQwBG
         h7MnMSfbOknb+1xg1kt5IHpFg/wUlOfytFS1s1FzJ2S889ZVwtQiCZkORdLTT2ZFEZMv
         BE4fe3SslRhTPzhrrzPL1607HHviXPJJwqloxqqzQMqf1QYeWtq408xjs16jNxSRjADS
         OHIkPQiUF7ewL8U+iS86+6L0DSiz4Nt3EB00vybkrwPirW29ctqE2EDhmZgsYhGGSLD0
         CrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221983; x=1719826783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JD6H/71ed+HgEm6na1DA8I9uAZ8qxNavgSQIFHLcZQ=;
        b=EBAfRvD6AFVh1vaQFL1XbcIu36X4VmsfYm8oqESklEXD8muRlze+mUNhH1OtZlB6LU
         YnlLwq5O1yZFurgctUZBhTwypjr7+e+OMd+N5OewXzvdVN0gtze9pk9MAE+cYc4Z4PrX
         S5uS0rxPTWL/+xhUBV+49U33DnNxuM+0aihLua/kh/fDYvF2wFZv+8p6v32DD8qv1BV1
         9OuukrZlOc7Y7kM8pG+GKO5D1Uy2Ss33OAilSFOOFO1t18jrxdzHAOudpPeunt+l49QL
         WCURb/TenZUm09wCiF0kfsNQJfPphPZLV4RglQfdq7NAeejVxKQUqdUqIu/XkGc/WhuP
         Qe/g==
X-Forwarded-Encrypted: i=1; AJvYcCUX0a6PkA8ib6UnYFztY3MQMVJ5WYRRd7GY5Nuxo/BP/zbpqntrbYnu6ikqMGj/OZAxj8r2SFbzg1dxAii60vG+Lx9Cpty0qZH/rB44
X-Gm-Message-State: AOJu0YwG3Zbx3LDEQZa5bxYCOnU/idIpG6zwrjgRLv1IIPeCq0UjwW5f
	48yvXCAf2YIm8wZJrCO/llVtxbYDMfluOGhRJD4Zpa12nZDf7uK0nhQUv5WR5GvCYuB21o4rWeM
	3
X-Google-Smtp-Source: AGHT+IH4cJwn/Amj7JNX6uQlXorQJKTbtqauX/ruYqNWJxJBrNkmIF6ABTUDWnrxpcc2W7lwKXy0IQ==
X-Received: by 2002:a05:6000:2a5:b0:366:ec30:adcc with SMTP id ffacd0b85a97d-366ec30ae4fmr2533851f8f.5.1719221983124;
        Mon, 24 Jun 2024 02:39:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b80e:a46a:7fb3:4e3a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638d9c1aasm9433138f8f.55.2024.06.24.02.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:39:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 1/2] genirq/irq_sim: add an extended irq_sim initializer
Date: Mon, 24 Jun 2024 11:39:32 +0200
Message-ID: <20240624093934.17089-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240624093934.17089-1-brgl@bgdev.pl>
References: <20240624093934.17089-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Currently users of the interrupt simulator don't have any way of being
notified about interrupts from the simulated domain being requested or
released. This causes a problem for one of the users - the GPIO
simulator - which is unable to lock the pins as interrupts.

Define a structure containing callbacks to be executed on various
irq_sim-related events (for now: irq request and release) and provide an
extended function for creating simulated interrupt domains that takes it
and a pointer to custom user data (to be passed to said callbacks) as
arguments.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/irq_sim.h | 17 ++++++++++++
 kernel/irq/irq_sim.c    | 60 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
index ab831e5ae748..89b4d8ff274b 100644
--- a/include/linux/irq_sim.h
+++ b/include/linux/irq_sim.h
@@ -16,11 +16,28 @@
  * requested like normal irqs and enqueued from process context.
  */
 
+struct irq_sim_ops {
+	int (*irq_sim_irq_requested)(struct irq_domain *domain,
+				     irq_hw_number_t hwirq, void *data);
+	void (*irq_sim_irq_released)(struct irq_domain *domain,
+				     irq_hw_number_t hwirq, void *data);
+};
+
 struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 					 unsigned int num_irqs);
 struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
 					      struct fwnode_handle *fwnode,
 					      unsigned int num_irqs);
+struct irq_domain *irq_domain_create_sim_full(struct fwnode_handle *fwnode,
+					      unsigned int num_irqs,
+					      const struct irq_sim_ops *ops,
+					      void *data);
+struct irq_domain *
+devm_irq_domain_create_sim_full(struct device *dev,
+				struct fwnode_handle *fwnode,
+				unsigned int num_irqs,
+				const struct irq_sim_ops *ops,
+				void *data);
 void irq_domain_remove_sim(struct irq_domain *domain);
 
 #endif /* _LINUX_IRQ_SIM_H */
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 38d6ae651ac7..3d4036db15ac 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -17,6 +17,8 @@ struct irq_sim_work_ctx {
 	unsigned int		irq_count;
 	unsigned long		*pending;
 	struct irq_domain	*domain;
+	struct irq_sim_ops	ops;
+	void			*user_data;
 };
 
 struct irq_sim_irq_ctx {
@@ -88,6 +90,31 @@ static int irq_sim_set_irqchip_state(struct irq_data *data,
 	return 0;
 }
 
+static int irq_sim_request_resources(struct irq_data *data)
+{
+	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
+	struct irq_sim_work_ctx *work_ctx = irq_ctx->work_ctx;
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
+
+	if (work_ctx->ops.irq_sim_irq_requested)
+		return work_ctx->ops.irq_sim_irq_requested(work_ctx->domain,
+							   hwirq,
+							   work_ctx->user_data);
+
+	return 0;
+}
+
+static void irq_sim_release_resources(struct irq_data *data)
+{
+	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
+	struct irq_sim_work_ctx *work_ctx = irq_ctx->work_ctx;
+	irq_hw_number_t hwirq = irqd_to_hwirq(data);
+
+	if (work_ctx->ops.irq_sim_irq_released)
+		work_ctx->ops.irq_sim_irq_released(work_ctx->domain, hwirq,
+						   work_ctx->user_data);
+}
+
 static struct irq_chip irq_sim_irqchip = {
 	.name			= "irq_sim",
 	.irq_mask		= irq_sim_irqmask,
@@ -95,6 +122,8 @@ static struct irq_chip irq_sim_irqchip = {
 	.irq_set_type		= irq_sim_set_type,
 	.irq_get_irqchip_state	= irq_sim_get_irqchip_state,
 	.irq_set_irqchip_state	= irq_sim_set_irqchip_state,
+	.irq_request_resources	= irq_sim_request_resources,
+	.irq_release_resources	= irq_sim_release_resources,
 };
 
 static void irq_sim_handle_irq(struct irq_work *work)
@@ -163,6 +192,15 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
  */
 struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 					 unsigned int num_irqs)
+{
+	return irq_domain_create_sim_full(fwnode, num_irqs, NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(irq_domain_create_sim);
+
+struct irq_domain *irq_domain_create_sim_full(struct fwnode_handle *fwnode,
+					      unsigned int num_irqs,
+					      const struct irq_sim_ops *ops,
+					      void *data)
 {
 	struct irq_sim_work_ctx *work_ctx __free(kfree) =
 				kmalloc(sizeof(*work_ctx), GFP_KERNEL);
@@ -183,10 +221,14 @@ struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 	work_ctx->irq_count = num_irqs;
 	work_ctx->work = IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
 	work_ctx->pending = no_free_ptr(pending);
+	work_ctx->user_data = data;
+
+	if (ops)
+		memcpy(&work_ctx->ops, ops, sizeof(*ops));
 
 	return no_free_ptr(work_ctx)->domain;
 }
-EXPORT_SYMBOL_GPL(irq_domain_create_sim);
+EXPORT_SYMBOL_GPL(irq_domain_create_sim_full);
 
 /**
  * irq_domain_remove_sim - Deinitialize the interrupt simulator domain: free
@@ -227,11 +269,23 @@ static void devm_irq_domain_remove_sim(void *data)
 struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
 					      struct fwnode_handle *fwnode,
 					      unsigned int num_irqs)
+{
+	return devm_irq_domain_create_sim_full(dev, fwnode, num_irqs,
+					       NULL, NULL);
+}
+EXPORT_SYMBOL_GPL(devm_irq_domain_create_sim);
+
+struct irq_domain *
+devm_irq_domain_create_sim_full(struct device *dev,
+				struct fwnode_handle *fwnode,
+				unsigned int num_irqs,
+				const struct irq_sim_ops *ops,
+				void *data)
 {
 	struct irq_domain *domain;
 	int ret;
 
-	domain = irq_domain_create_sim(fwnode, num_irqs);
+	domain = irq_domain_create_sim_full(fwnode, num_irqs, ops, data);
 	if (IS_ERR(domain))
 		return domain;
 
@@ -241,4 +295,4 @@ struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
 
 	return domain;
 }
-EXPORT_SYMBOL_GPL(devm_irq_domain_create_sim);
+EXPORT_SYMBOL_GPL(devm_irq_domain_create_sim_full);
-- 
2.43.0


