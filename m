Return-Path: <linux-kernel+bounces-319248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A313596F9B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00681C21954
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8951D4603;
	Fri,  6 Sep 2024 17:02:04 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C451C7B68
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642124; cv=none; b=KNVk+5A+mGgH1ghaGB37aGruTNxZ2g9qv2CafCu/SttXPAaxkg3mD8zCgSQGpKYlGP0QRwjITjd2SbTeGV7CoAAXG2Ye+bcIUc1sALne5EZ/wJKk6zw7B7C/5redh9xQkvr683BMx+ID11reqBeZn5vVnmIK+3vdQJpx8B2rkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642124; c=relaxed/simple;
	bh=lYEJ0HD1KdEziUST6pyYJru8TC5pAqfPSyCgIBabkqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rm/8ZqcoJWyOiMPcfkQa8JO6DaF4Y146NfpJHilxH+hhINZ5jB6ybFrqmzsi9A4v3jWDhr5cdKLD4yU27oZVZGxvWiOA9TufZOD1EjNxwyuTfrjRgGe/GMFqSq0p2GzA29WVT0dvISe+ycKBc7qE2oXN02VLvD/E+jEkPNlwc38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5365c512b00so388932e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 10:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725642121; x=1726246921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKNKjAgQmHXvyH7+pcYaH8KFVlAhAHwotRNhD8OpjZo=;
        b=WignY/OiDs25MaF6ZaALxin4CGQPPUGLRRVG9cg6J3OhEto2dANw01xL6BjUF0aHpi
         e/2yEzI+WJ5943LQgds/O9IflIWtFNswqx/QjlDxj0/f/vNXaszLPXHYiWe0XeL3t5LC
         Hbm7D/SspP7HXsflILGKK4niXoZQNLG694YXZaEbr51m3o8dC6DrD8Wtj+vTWHZeX+7r
         kcoR4cpG6sjlHWA3GfBbQ813TXHXmWMPp/GLbhS3eqk/Nu1Bd0TTV2uncUEiBri09wGE
         liHpcrwnwtDlYvMAQUYt8flIkUx7bcKW7WHqjVXspWbT1CBZR7TwFR0vPY6BPTh7kr5H
         gfgw==
X-Forwarded-Encrypted: i=1; AJvYcCURNTxYO/qQtaKcs3dExEGvyMckKus79W+zrHO0AbQceI+jf0gGoZYD5PqfXuIP1WsWj9GGxqqif/acrmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFVoG94f6H/MIsyL4t6xmKHH+HE6w0y+DxY2oFckdibTM/dmt
	mvvaKVs9/J4m/b4WIItiJAdObHRa/edby3xfzo4SzTBVCWtcr+iq
X-Google-Smtp-Source: AGHT+IE/4ap+9ERg4ETc7S3k6WCffLoP6QxJdBoytSOF4oO3qengKBZCOLHxApUEui6CIKEtuR2HCQ==
X-Received: by 2002:a05:6512:1245:b0:536:568f:c5ed with SMTP id 2adb3069b0e04-536587a34demr2203669e87.1.1725642120345;
        Fri, 06 Sep 2024 10:02:00 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca0606e9dsm26491585e9.45.2024.09.06.10.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 10:01:59 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: ming.lei@redhat.com,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] genirq: Use cpumask_intersects()
Date: Fri,  6 Sep 2024 20:01:40 +0300
Message-ID: <20240906170142.1135207-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `cpumask_any_and(a, b) >= nr_cpu_ids`
and `cpumask_any_and(a, b) < nr_cpu_ids`
with the more readable `!cpumask_intersects(a, b)`
and `cpumask_intersects(a, b)`

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/irq/chip.c      | 2 +-
 kernel/irq/migration.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index dc94e0bf2c940..271e9139de77f 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -198,7 +198,7 @@ __irq_startup_managed(struct irq_desc *desc, const struct cpumask *aff,
 
 	irqd_clr_managed_shutdown(d);
 
-	if (cpumask_any_and(aff, cpu_online_mask) >= nr_cpu_ids) {
+	if (!cpumask_intersects(aff, cpu_online_mask)) {
 		/*
 		 * Catch code which fiddles with enable_irq() on a managed
 		 * and potentially shutdown IRQ. Chained interrupt
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 61ca924ef4b4c..eb150afd671f6 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -26,7 +26,7 @@ bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear)
 	 * The outgoing CPU might be the last online target in a pending
 	 * interrupt move. If that's the case clear the pending move bit.
 	 */
-	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) >= nr_cpu_ids) {
+	if (!cpumask_intersects(desc->pending_mask, cpu_online_mask)) {
 		irqd_clr_move_pending(data);
 		return false;
 	}
@@ -74,7 +74,7 @@ void irq_move_masked_irq(struct irq_data *idata)
 	 * For correct operation this depends on the caller
 	 * masking the irqs.
 	 */
-	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids) {
+	if (cpumask_intersects(desc->pending_mask, cpu_online_mask)) {
 		int ret;
 
 		ret = irq_do_set_affinity(data, desc->pending_mask, false);
-- 
2.45.0


