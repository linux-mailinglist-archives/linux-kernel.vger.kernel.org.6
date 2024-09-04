Return-Path: <linux-kernel+bounces-315191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12196BF0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE4F7B239E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6CB1D9357;
	Wed,  4 Sep 2024 13:48:56 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C311EEE4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457736; cv=none; b=TzAgSgqxam+OBy7/xy7PFLNhcCT7J9pNTW9TuxzNiZ89rx6PckkNMQj1Uww82vV3je4EIapW5csqKoUQSsWCReuPWQiby/16h9Jm+QQVXlKdV+OgAUXWB+YSW7EuYFW+bglizqFvlgv41hRMtgcWsH3jx4+fRb8sl3Ab228u5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457736; c=relaxed/simple;
	bh=Cx7GeCK6YKqd12hc4hWpLZSJSDlsLvkm2QzWflXXen8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LIgOSLZgyyeHHZIdlUMjnr3OOp+Dn6X8Gzr8gN1BO4fSHI2aIxH9AXX+th2NXxuwW2HGFiHrUkIij7mI7hItmkYGuCsMn2NeVYydHAhZDLmyLbZU6wauQSp4bP+yCDucPrGkYwTuC7iQT1b4jhIb5Qfd5Z4AT7OPliiQ5ZxA+lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c1120a32so2628479f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457733; x=1726062533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQogKpQfrswIe53IrkoFhcdLUfNyOlUNsAUHxd9Hcak=;
        b=OdiPMYhahwn4R+mh4I5r/F8kaKmDpEl552xCpxOfRUINaWostoxWkz7ue5I+7Sp/Y2
         jdGc+khk2WpvOBpJDoPmt9pwlgdO5NzYWtAAOYT942+mVezVEHHWVuu3jWmJDYrzkXfp
         8lzsTVUlFAkMJkhSlRX+D1wS2JMeRhn61BzFfpRhU5SL60wawituMCn9Q8EYViRqCUtj
         lV0advASZeRxyP1iSL0LkmsjYgPc1B2UmeU99X2TH76CZLAL6udOmYieXc7gfJXRKJT+
         L91QH800ziAUyY+L0tz56q+/LbKc3imtZ01rtBxyjRqpAGSAjukrOAW0WoRIoiloVzJV
         YaTg==
X-Forwarded-Encrypted: i=1; AJvYcCWyfr7vHjI1T/S1VoUMTdHnJcN8g/+GhGAU9ciGnhWo+0yrauDrlIRqR/dYePStwznRWIbof9Jb5Flr6t8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/s1ewrociLmuOYnkoagMYN6uHsIbVz/xHYdU6fO38SdF81ddf
	bS1SLFmr6vCY2aY+JWxkhQq3A7lWDv3NeYDIUI+wCvmPrBWY7311
X-Google-Smtp-Source: AGHT+IF2kIFgMB0yEBXwP3szgJsRtVc2Y02v3eG2q3uLwVU5/Wm6NYUriyGM2hU5DntTa8U8u8Jj8A==
X-Received: by 2002:a5d:67cd:0:b0:368:68d3:32b3 with SMTP id ffacd0b85a97d-374bceb320emr10068139f8f.26.1725457732756;
        Wed, 04 Sep 2024 06:48:52 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ba593876sm13302958f8f.5.2024.09.04.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:48:52 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: ming.lei@redhat.com,
	Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH] genirq: use cpumask_intersects
Date: Wed,  4 Sep 2024 16:48:23 +0300
Message-ID: <20240904134823.777623-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `cpumask_any_and(a, b) >= nr_cpu_ids`
with more readable `!cpumask_intersects(a, b)`.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 kernel/irq/cpuhotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index eb86283901565..15a7654eff684 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -37,7 +37,7 @@ static inline bool irq_needs_fixup(struct irq_data *d)
 	 * has been removed from the online mask already.
 	 */
 	if (cpumask_any_but(m, cpu) < nr_cpu_ids &&
-	    cpumask_any_and(m, cpu_online_mask) >= nr_cpu_ids) {
+	    !cpumask_intersects(m, cpu_online_mask)) {
 		/*
 		 * If this happens then there was a missed IRQ fixup at some
 		 * point. Warn about it and enforce fixup.
@@ -110,7 +110,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (maskchip && chip->irq_mask)
 		chip->irq_mask(d);
 
-	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
+	if (!cpumask_intersects(affinity, cpu_online_mask)) {
 		/*
 		 * If the interrupt is managed, then shut it down and leave
 		 * the affinity untouched.
-- 
2.45.0


