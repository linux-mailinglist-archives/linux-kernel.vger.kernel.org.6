Return-Path: <linux-kernel+bounces-340086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E905986E73
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36CCBB216E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777911A3A82;
	Thu, 26 Sep 2024 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Tk4Mr8So"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6B18C33D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337783; cv=none; b=MYRFqWvEtcp0BpVZmqA2DZZi+KRULkimrDUROx7khy3fe8bygTHGILcBhIMz3WYwqrPyaPSAXzxdzPgp8TmsdENEdcagWpk9G1ymR5CTMW1oiSyCtqrmPazi/nmlPAGhXC3sOZZIaXbqtKuflIByczpU7mzMXkggYSdN2IPTKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337783; c=relaxed/simple;
	bh=gtT0Mvj+ehDgw8+FbrJorl4usT/irXouxXsZa1BUCSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5mxJnTwC0eC6JWAq1GnGE1vc++e1YEOzIY1gzNPetxBd8GD0HETLPfrthxyazmtjKeDS81i/139wt1rjNAuLBst3Erciq/RZepy+MU0rucH4fjGehWOSnBJ6E6cjm8DimOpYjFj5IwPTR8iism5caI4FMC383T6Ye+hqQ+E9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Tk4Mr8So; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1263286a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 01:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727337780; x=1727942580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nglbt6RXFRoSF1PZp4LFeCsmiugjPPt9pJDwHl5iBvk=;
        b=Tk4Mr8SoLJIcKcg+/G4wLzcJ1ZVhh9NMjJkRdCTZ3pKNzqwMdtn1Q0pMGKOxpY7/xn
         xnsJL3gsiz2oqAoUrNwSNHpJSLTPDzmiBMZJwdPUg2Rai5Jt6m1gc+NmvPbpdIxby5hm
         QaFMpAODMXZ9retU6PF0xmh5th14kBxbWuqVIrJYPIjUT8s8zC8UGNq/jf56ssycA+CA
         hqzFjzEpDqb22P/Di02uGzZJivAdbbuxFxkddPEEjwmVsose3iU37vNDPbpd+9ueP0Bi
         2rSLblQXI/7n2ABh4FOdNUBMgJdyvLs8F/H/vKJiDDzR+ZbqoueeN4i3vo56Cqn+yguQ
         zyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337780; x=1727942580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nglbt6RXFRoSF1PZp4LFeCsmiugjPPt9pJDwHl5iBvk=;
        b=Sfmr3ne6RXfBLQCsH+2XY8jEwd9yeVxqKEhgkqFXECRj6+GzZXP+0xpqOusOzlBddq
         kuJ5U3S+phO0/5j+Auh9huf6CrGEmdOgTkTtkvrSQeGGJAkS+CiVCQi8VkE8CrTLHpB8
         FT9rImR7pl5cAdSfXKELAKB7dDf2oGogilD9KMVkQ7sJUJGGw0rQsznKPBPxgobqRMum
         qKcyD7Lyvc72ptOzQbQRvugY73nhbHehr0ii2jf6pzcHbeIosuhrorMHfjU2pXFfjRzj
         yajahUgdeTiwOwrbS6pHARVm6K4YQfaBDxJsFGK6k24OnkGTxkARtUqFqkW30Y71856O
         iJ1g==
X-Forwarded-Encrypted: i=1; AJvYcCVXZDXWIISaXbLZDCwoH6/bbj3eBA2Dv/fIU61W9/3iRX8VY+MFZmtFpnTW5yzfH75m3EsOHW9jJrsOly0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJOMgc1Dj7PxJv5WRI5aqVmaBcUhvpBNpQT69+CdB2PKZYlYj
	YKwM5G6qLfbujIirqaGxBlYFO5jfDy6IGr5Va18Rs/6AD2JCYwueXQ/5n1ITTFM=
X-Google-Smtp-Source: AGHT+IHzA5WG+2hK9YWulLvpYCUUm1KdX551aCE17rd+ilxQm58J6VCuSPBltbCiIxXb9SvX/0GohA==
X-Received: by 2002:a05:6402:354f:b0:5c5:cbdd:4648 with SMTP id 4fb4d7f45d1cf-5c8777dc632mr1928306a12.17.1727337780239;
        Thu, 26 Sep 2024 01:03:00 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf4c4fe3sm2822449a12.68.2024.09.26.01.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 01:02:59 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 20/36] arm: gic-v3-its: Implement of_xlate
Date: Thu, 26 Sep 2024 09:59:08 +0200
Message-ID: <20240926080021.148031-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926080021.148031-1-patrick.rudolph@9elements.com>
References: <20240926080021.148031-1-patrick.rudolph@9elements.com>
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


