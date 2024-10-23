Return-Path: <linux-kernel+bounces-378089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6559ACB34
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B510B22319
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811F41BC9F6;
	Wed, 23 Oct 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="gojlByxK"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5CE1B4F15
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690149; cv=none; b=JcHT3uLP+kPfDjfn/6umPR1Xitw5r1OF+izwxuWnGw0DBDXcrc25+IlWWDtAgzC2JGO7EvGkWKKY4Lvl3z005Qhz2lUFdsqke0Lnf+f3eKLwUARTnxQFrruL/zgp7eX2qVPyvIpSjEANwehBAJDEeKajBNpxXIv/jrg740ZSK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690149; c=relaxed/simple;
	bh=txny5O+7tzt/uvekFq/Rho85UXcjelsVTPSdxtT6DOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqOruoUFADQsoRYiWZ0xfOYFTzxPVTBmA80ZlfB8C1m97alqgacvZkqFylTlMc7Z6MJ1TQqaPO0vTNx1xaEBbfZS2zPHczRoyolL81+YJFK7m0BlFDKaPykxTtpve6iia+3kROzUDK/lU6561zw+6dviBLMLbIY/1WsBeuL577Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=gojlByxK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso69085905e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1729690146; x=1730294946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKu1shEspiBGFDbULaeGm5YbhuAQEJF6cvlpQuXsf3E=;
        b=gojlByxKPPh6y6N2X3ByoAkWesBOr1pXeqC1imVou/77LoBBqYOteeOulsqD0OGUFT
         Uc3/b4pKbziRidcYVkxwA2uTZJ0K9Vmbi7ncuSU1tV2Jcy3MDr50ARo8Si6AnTJ0stiS
         ta0l1fIPpQN9GZMZ4wmf2cOUdmBgoDn2iesNOfGBi0f/pnTG7ie5Kied3G6uFA2jPl9b
         San4tVPOmJEQcMkXmOE9YGKw+3N/Qe14WKYiskqYWvtckRoWb8lj1RahyLlUQP92qvr2
         k9ZZYUhOL7Vp29/QQ3LFS2ZBZz7MOwJw7pWdRMJMN2R5oDJArPkoDHTsaK6Uwr518Ie1
         ygBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690146; x=1730294946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKu1shEspiBGFDbULaeGm5YbhuAQEJF6cvlpQuXsf3E=;
        b=ImcC2Cd8tef15a1K+yiZtnjnJz1dTIjB3/c9KHvIthf2qEHMaAItwwXF4y6LoGJPO6
         mjIcOuS/wZb+3NT1gGYPUtZ48h52bVFXTE2X3YKHW3zXstYSOoi9I8R3pGYpScipVgRg
         CDCmrlDxaT/TqKM51vCc9JYwiBYvgGOfPs9GRDFedYZgdtZ0nNCSuX8Ql1h5dT6ylFVv
         ++03cFr1esVPIMWgvv0Y1toiCcFqBsAEFOLLYXCtyhyd4YgMmX4CP88uhjs4cxRvgzDi
         AryQx9sM6Nk1+iHBuRgv1Eyrm99w2mXijc7QQcGER24BAUfsHGDsuchgRq+3xCkJLHPr
         dcSw==
X-Forwarded-Encrypted: i=1; AJvYcCUejyvYi2TXGigC1bpmLcSxEJ3CexOrJjW0wL4zpXHdv+9SBI5lxcPLOCyWAvDwNMFrPyqt4TR9DXs1JQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXUn996XMlDi8CEvX7S3mBZNRzxONeB33LhaAvnQKd9JiHMH2
	tx2omLaItxKqyBZoFajfl7CbW2312WdGBHgM5+Q3W1LHD7yFnJTZ4AaGbhIW17+wkIaFjltleVm
	r
X-Google-Smtp-Source: AGHT+IFBvuEGZKWznn7uULpnrgTFSCE8ALsMzElLxazkNqNtoXZysGaQH5SryzLOD4u7WQGCJOUP3w==
X-Received: by 2002:a5d:5644:0:b0:37d:3f5c:5a83 with SMTP id ffacd0b85a97d-37efcf08153mr1901423f8f.19.1729690146498;
        Wed, 23 Oct 2024 06:29:06 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:29:06 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Moritz Fischer <moritzf@google.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 20/37] arm: gic-v3-its: Implement of_xlate
Date: Wed, 23 Oct 2024 15:20:03 +0200
Message-ID: <20241023132116.970117-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Translate IRQs by implementing of_xlate() as required by
irq_get_by_index() to parse interrupt properties.

Map DT interrupts to ARM GIC interrupts as follows:

- Interrupt numbers ID32-ID1019 are used for SPIs
- ID0-ID15 are used for SGIs
- ID16-ID31 are used for PPIs

TEST: Booted on qemu sbsa-ref that has a GICV3.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Moritz Fischer <moritzf@google.com>
---
Changelog v9:
- Require at least 3 interrupt-cells
- Map SPI interrupts to ID32+
- Map PPI interrupts to ID16+
---
 arch/arm/lib/gic-v3-its.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..58f8bf864f 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -4,9 +4,11 @@
  */
 #include <cpu_func.h>
 #include <dm.h>
+#include <irq.h>
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <linux/sizes.h>
@@ -163,8 +165,30 @@ static const struct udevice_id gic_v3_ids[] = {
 	{}
 };
 
+static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_args *args)
+{
+	if (args->args_count < 3) {
+		log_debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args[0] == GIC_SPI)
+		irq->id = args->args[1] + 32;
+	else
+		irq->id = args->args[1] + 16;
+
+	irq->flags = args->args[2];
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


