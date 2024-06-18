Return-Path: <linux-kernel+bounces-218842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F12AF90C6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5AE8B227A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0BF1A254C;
	Tue, 18 Jun 2024 08:15:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F91A2540;
	Tue, 18 Jun 2024 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698525; cv=none; b=AqJB6abXMy+gwYKJCFy/j84Ut3MbT2gCdTmJGUBP3paii5FVySelJNBmffhG3iZBcmCoujDjMy4XjnQbr3wxtQ7cTJvJa2sbtAwkdeLnXR2kucXQkxlfbmBYUst4uFGPJlg4QVW5qEg+vm1ERU4EfFBayYYU5owhyrfsgbpnAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698525; c=relaxed/simple;
	bh=CQtrWxPxVUIrfgeVQ6RJSUNsuqxOv8q8LFvAUYW9PCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjASnvf0dDkxTMA1/xikj5bkhvS8DyUNurjgUJRruw68243NXykdXtodpd2OZFNRkxalUpWMoYlWSXKDTyVJESvMo6oAIHt4TQqcz8AUcCgDdbND45IweI6EmXyEP+XXfeODD33yrn9GqkDnHNHXzZlkummRVkI1IeNzi0uh2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464D7C3277B;
	Tue, 18 Jun 2024 08:15:23 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_node()
Date: Tue, 18 Jun 2024 16:15:07 +0800
Message-ID: <20240618081507.3996921-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we use "nr_cpus=n" to hard limit the CPU number, cpu_to_node() is
not usable because it can only applied on "possible" CPUs. On the other
hand, early_cpu_to_node() can be always used instead.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-eiointc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index c7ddebf312ad..8ba9082c1796 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -339,7 +339,7 @@ static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
 	int node;
 
 	if (cpu_has_flatmode)
-		node = cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
+		node = early_cpu_to_node(eiointc_priv[nr_pics - 1]->node * CORES_PER_EIO_NODE);
 	else
 		node = eiointc_priv[nr_pics - 1]->node;
 
@@ -431,7 +431,7 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
 		goto out_free_handle;
 
 	if (cpu_has_flatmode)
-		node = cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
+		node = early_cpu_to_node(acpi_eiointc->node * CORES_PER_EIO_NODE);
 	else
 		node = acpi_eiointc->node;
 	acpi_set_vec_parent(node, priv->eiointc_domain, pch_group);
-- 
2.43.0


