Return-Path: <linux-kernel+bounces-332765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EF697BE89
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62E31C2156B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B641C9861;
	Wed, 18 Sep 2024 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="G9bTsXZI"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F271C9842
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672960; cv=none; b=lwQ6Et6yCE7x5bcfVLMHIUe00XwnjRfl9mSPRfi3eIMCrr/WvM3ZOlC/LF8r/bn3LWH4K1aSHn6JutsMpYOwXgCBgab6lbJpM9DzdQ4ReoBJD7n++cqgh76f+B1hpeOM1uNaS4pXVSV/ehCWib40iFas4qO6PUL8BqcbAXlxnmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672960; c=relaxed/simple;
	bh=nN3C1XZe8u2DnhTs3+lSyaOKW8qmFCcsgQE6Av7CBsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmG4okUOkCpEWhBDbx3lT4WdwuNBoNsFWixYgYZybuSqU0GAo1gDpx9wnkkem7msTbkW00e9EROEMxWk4mhANG2Mz3YvCSWmRsEhDqUfiuZfIC75e22WqjKKwZW8biWElqGl6zigUivhrONmgbu2NjxG2zFK4xSwlXwFHVFfAto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=G9bTsXZI; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d4979b843so946909866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1726672957; x=1727277757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVVkN12lSTsAxVKKZE4M7huLa/7vQ/7N6/GXIIUvUdk=;
        b=G9bTsXZIvPr8JmbUpOXsNfvGsbWYyni0AsNkhgNNKrQGQC/zegGtAasiQvvSuNG4sw
         tJHDgDYQbkXGnDxIYx4Lz8CtIVXkKjsMbFmLL9bwds3TpqTYHo+dgDhGL0PyzF1y9Ogw
         J+qpLp2uH3KEEmKT1NPvfcqX3WmGX/5hu3xFGp4fnQFYxAEKnfVFA9pVdFyGKYE6eE7B
         EZq/gZxBJnLLpkB967LauJxTY/FGFsHGDIZPWhw3fGSCK7qJHm2h7o5XXcsGfEeRmAJ9
         jxVYoKEbLud+XcWtBXd0lJRb8OxLvZukTRMSFDVqwn8JsLo9k0UoZ0YP8uOALV1s87ve
         8Wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726672957; x=1727277757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVVkN12lSTsAxVKKZE4M7huLa/7vQ/7N6/GXIIUvUdk=;
        b=ioJl4FCOHAivadsuJzG5aOvbZTaZSb+KV7ImeojwAZsHKKvxZ/u2fwN6Qj+ckPYHcQ
         A+0Xp+m+pGAdAcr/jHptzgwwgoWEUSbVkLv7JpzkyYCYW3A6m2HnnCwrF541wtlgjkYd
         n5+6ciLgqdJUGhDNHCU5NeVrGKero1w2yu2PPk3mqsA3f2HpKxF0TpvKMdlRA3zsGPZJ
         lwTagGWwdKy/9xLkZ0/y/h+QWnRNkNQq1ltoMOVnWt5xuYjQkxXQr3giMzMXAVRZCVdO
         E5T1ZxnHySPZ9FvRmZcdVZfJFrAGkSeTXa7hAEGK+m/DcL5GFsLilEkDw01EO+t1ByHZ
         Psaw==
X-Forwarded-Encrypted: i=1; AJvYcCVkWiOL1+hG4WD/5o/wBH3KU04nRhkHRZz82PDbTOCJGpGup+ZijxnqFl+rD7sIpX6FrgLWxpfIQICHW9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkxpxaO1+Yl0jPMhTOJFIsdV9azSLVb5mS3QwnuLZQsd0amUTk
	glvXYnLfvmoLY6UeeNP3GpMWUKl2U2RKa1/NjUDERReTA56Vd++maTNtiEMTFv8=
X-Google-Smtp-Source: AGHT+IGOYg9+yH/2ascGjyURXEPyRTFrHiW4obxTAigv1a9OYyKclKvz51vX76pAcIuJJd+BL0sxtA==
X-Received: by 2002:a17:907:1b05:b0:a72:69e8:f039 with SMTP id a640c23a62f3a-a902941d803mr2173972266b.12.1726672957163;
        Wed, 18 Sep 2024 08:22:37 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610967b0sm599791266b.42.2024.09.18.08.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 08:22:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 20/35] arm: gic-v3-its: Implement of_xlate
Date: Wed, 18 Sep 2024 17:20:24 +0200
Message-ID: <20240918152136.3395170-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Translate IRQs by implementing of_xlate() as required by
irq_get_by_index() to parse interrupt properties.

TEST: Booted on qemu sbsa-ref that has a GICV3.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..54dbff434c 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -7,6 +7,7 @@
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
+#include <irq.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
@@ -163,8 +164,28 @@ static const struct udevice_id gic_v3_ids[] = {
 	{}
 };
 
+static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_args *args)
+{
+	if (args->args_count > 2) {
+		log_debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args_count > 0)
+		irq->id = args->args[0];
+	if (args->args_count > 1)
+		irq->flags = args->args[1];
+
+	return 0;
+}
+
+static const struct irq_ops arm_gic_v3_ops = {
+	.of_xlate		=  arm_gic_v3_of_xlate,
+};
+
 U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
+	.ops		= &arm_gic_v3_ops,
 };
-- 
2.46.0


