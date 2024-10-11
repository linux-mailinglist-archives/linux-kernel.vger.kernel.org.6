Return-Path: <linux-kernel+bounces-360930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD26599A179
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50EA11F22AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E4A213EF9;
	Fri, 11 Oct 2024 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="JRg6NMsB"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0129420FAA1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642906; cv=none; b=TfWj+KU2SQRd7+vCY8NHEQF7MnOxbxihdlRtfjklf7tGL/XOxIgDGWfXD/rb8LgMcZ+KW+5WYmPeqiaHdwUcFAKHh0IlMFjLYcW3jMyQ8It5fH07W1/pbHqwQZAEp6vH6e8q7w8LcD5LXFd2cexbqtPtT30uIf66ehDDeWISMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642906; c=relaxed/simple;
	bh=sAspBPW2aJDhH2ElRQqQ5ltJlXwR8eTbuD4hXdxnqTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqiPWJNdGz87//B2p4jdeEHjnlKYUhcpOEt0GNlg1ABbr/z1Dti4nCBp7H/X0EK0WBb8OJS6RNAY6pT7GMgyiv88S61+mxmyOnY4VPtRdtxtUfxtTHzQxEr1a4bFJ+51E3f++i5jz2OyMevo3cnmJOU6xKjIVs1SOfBJoOlojnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=JRg6NMsB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99c0c203f0so45479966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728642903; x=1729247703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
        b=JRg6NMsB3a4o7FXrn8vAGH563tTPhuhctO/ybN8WamffDCoXq6MmU0e580CRc8tAB7
         d0BYpHvzTbGHtu43SWZ+nsRq78ZiIGFabtBFCJhHxT6c3hJmM96BqaQii5ufuotmDOjy
         pR3QSDtBtZVvB2npF2ZElg5YTW4fEG0ygltRyj2OXVH12YyIo5TOkyMf7X/0GiYa27P7
         3upuD9+0GLDJ83Eh87qnnogrAwlbM+4EJWBbRmgLIRe5b8SngXbc8X+0AX/yyt1Mpfkz
         tiUdw7+Kk87oNPnUxe0G64a9xnEjicl/a7UJmPcVz+jI7v+Gi68RrZdr/i+oyYCbtP1e
         oxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642903; x=1729247703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
        b=nbt1Chi8FyKl5wz81bMVQQGI8UaA//bzrNedf//WPO5Nr+qgEJ8fVan8qUjX/uuU5L
         tACYKmCZTEBYmLj7tnAfJhrY/dvu/teGDWre4A4TumgY2sYKCAApNFdPURb8/JGFr4F4
         t0TEx4ThM/joO2tmDDcGIts0A/XN2OAfy6DwYNG0j2AqRsuv/PosI8405xP2tUUjOso2
         65TWtgGJ5aIdw8q+KqEcGCK2YIbTfh2e9NIvHG4UFbXNPQnQ2l1Uf7tCKDobMgMOjLt5
         c5fa8xT55HlH+3RnRsuGjlykFr5p/wt4ggdRvSVQJsSb25/9P85j9uPaUs5iFlBo36B7
         qGsA==
X-Forwarded-Encrypted: i=1; AJvYcCU149we2GYRK5scYrbAJrdlSgaoqZszH1UPFiGF5r2nvPxxv5QMJBXbD4hve+wG8sY410QveUbbwKTh3ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiG/URtNLYZZ/CoyZSjhE3CDxa7ovF8hI68PTjpZKWdpOCAM5n
	8vSrexhOskaWjdcUrCde8iAn6vnBQlSQi5NOhTKFYy/1BCRYqCSr6dcJESdLb28=
X-Google-Smtp-Source: AGHT+IHmMFXgOQt6HdbOjbNwqxb1gSUXTJIPPXeMo+p0D5zo0aDi/f6I7hGGf5bbIflrEjE/ff6IVQ==
X-Received: by 2002:a17:906:c144:b0:a99:3318:e7c3 with SMTP id a640c23a62f3a-a99b95a997cmr169084966b.43.1728642903272;
        Fri, 11 Oct 2024 03:35:03 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:35:03 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 20/37] arm: gic-v3-its: Implement of_xlate
Date: Fri, 11 Oct 2024 12:23:01 +0200
Message-ID: <20241011102419.12523-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changelog v6:
- Update header order

---
 arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..0d5545bfb2 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -4,6 +4,7 @@
  */
 #include <cpu_func.h>
 #include <dm.h>
+#include <irq.h>
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
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
2.46.2


