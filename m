Return-Path: <linux-kernel+bounces-340480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C103C9873EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00D11C228B5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF01DFE1;
	Thu, 26 Sep 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jV9Kd8eW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490883EA98
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355318; cv=none; b=re6uzxl5kd3zz0MREjYXT9+hEvNEebroeCIYEmFjinGM34tSFuMLufXsaVOYWvDtZ86QS29bkqhw/eu92GkTCv18g98SZf/q0Rm9EWl5Kgc42IpyknxpcXvW5l2XWfkfKndlavIduE9eSVzCeQgFwtXH6mxXXU2ZQrIjCdArSjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355318; c=relaxed/simple;
	bh=DQpzIFRv2X+ZRDlASS8Vf6j+iX6bv1wZx21j0KMV81c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOJ7vsOi1jWYBbSgvwTec2f5gslMbkqnjzpyHtCs3NkvNWkzqnhb+UGBfVOIIB0bBOEUQLkEdsnejh5ogtgj/+0Ft+GI6GiH93QFmu+RgGHojpI6U7nKW3hMZ0H9UjbsMS1+ow5A4BpeB8qOSPZ2z+IYhVQV9cUMo9dQkJ6Ou0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jV9Kd8eW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727355316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pLZMSHP2cc3IT88lpSxgsA3n5ydL69p15Njb5n67I/A=;
	b=jV9Kd8eWYJMszT51h3HDLTLgM+knvHl0ZqIcsMuNMrgbYp0YM+Cr8iCGBm3ws4irP/ekhc
	gZtfI/qvjP1mF9fZW848UW0T3lIen3i88ZoYQKAQNJ8KeWX+jH/QEYC0GmG0FmWAtTIr2Y
	YBnB05OyQwHblTvtQ1N0MCea85lVMBE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-jD0YmBJHM_qcYHy4cvXGfA-1; Thu, 26 Sep 2024 08:55:14 -0400
X-MC-Unique: jD0YmBJHM_qcYHy4cvXGfA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6e21dcc7044so17489957b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727355314; x=1727960114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLZMSHP2cc3IT88lpSxgsA3n5ydL69p15Njb5n67I/A=;
        b=pgUQmuubHrhzi47b4HJ75/qajJkTgNVGJGcTBT5U0CtvXv3kl12WLDiQSJVbzLMdLD
         4iUbeKMNImsCxafRk18C0xnYRnYEwJvgwPAknzdk80Ybt/QmwIO7ZId+AkTYI2mRojTg
         tG0MlztHmQ+Esr54tBjnpfAkT1yX1cusx0aFkVcyMWD68u8SCrF+HR+rfgMHHBxUqHsb
         MTgnrsq65UeAMcNEWYbfmF9F2l6e+Lqz9MoYCB7kttNF/3wc41GiOExIVrQ42scdRZRs
         QrgxA0qHKG1P+8OfvNg9M9IGxR1I+4y3ygjwmN854ipqqShcPs3qQyKtnJveYmyGSNb+
         w4cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHPt3NjAMplmbinowe7MfLqIxrRwEiuJbL1tCrtWifQTrEF4jmwwdwFFSBsMCY8902VO7CpFoPgMjJJ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAEp6NlgHoAchlpmpLPkzherFlN8AJsnU3dh2jCFTncmxttpn
	tv0Em1k0A+J3ck6xZT5nPo2c3rDGGYnhzqPhFw3nyNN9c1cVCf276Y1Q333tBShyQsijJ+S82v2
	7APWd+JSMShgc22REj3uYKalVv2I/zpPA1sMPmvd4p9hYjVZ6cmBoVLfnKFhNINXa6bNNlg==
X-Received: by 2002:a05:6902:1b8d:b0:e25:c961:8bce with SMTP id 3f1490d57ef6-e25c9618d57mr2467504276.30.1727355313963;
        Thu, 26 Sep 2024 05:55:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG5ELDaKDmWytABuul86IvEV6NZ0mV6LTYIjO2keZp9W38l4fv8LRN273INdoNj35LCV73dw==
X-Received: by 2002:a05:6902:1b8d:b0:e25:c961:8bce with SMTP id 3f1490d57ef6-e25c9618d57mr2467479276.30.1727355313616;
        Thu, 26 Sep 2024 05:55:13 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b526a0bf6sm25561021cf.88.2024.09.26.05.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:55:13 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] irqchip: Remove obsolete config ARM_GIC_V3_ITS_PCI
Date: Thu, 26 Sep 2024 14:55:02 +0200
Message-ID: <20240926125502.363364-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit b5712bf89b4b ("irqchip/gic-v3-its: Provide MSI parent for
PCI/MSI[-X]") moves the functionality of irq-gic-v3-its-pci-msi.c into
irq-gic-v3-its-msi-parent.c, and drops the former file.

With that, the config option ARM_GIC_V3_ITS_PCI is obsolete, but the
definition of that config is not removed in the commit above.

Remove this obsolete config ARM_GIC_V3_ITS_PCI.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/irqchip/Kconfig | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 341cd9ca5a05..d82bcab233a1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -45,13 +45,6 @@ config ARM_GIC_V3_ITS
 	select IRQ_MSI_LIB
 	default ARM_GIC_V3
 
-config ARM_GIC_V3_ITS_PCI
-	bool
-	depends on ARM_GIC_V3_ITS
-	depends on PCI
-	depends on PCI_MSI
-	default ARM_GIC_V3_ITS
-
 config ARM_GIC_V3_ITS_FSL_MC
 	bool
 	depends on ARM_GIC_V3_ITS
-- 
2.46.1


