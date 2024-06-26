Return-Path: <linux-kernel+bounces-230223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669DC917A01
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2252528331F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E04015CD58;
	Wed, 26 Jun 2024 07:44:22 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42EF15B968
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719387861; cv=none; b=ZjYWUXTXiKylCG68ISU05jYg48ZllWf+0jv+BA7HUWoIBt3JfmZKKVI/qCYqzsJZGmO93rZ4RBOGrUUX0mxKF/RdSx5DlGdXMI28RplCzObTe0712GmxmJq2gZUGFbhsNcGl0E+g7HBvE9sGxApDORBMecMTjXVTWA5TSlHiXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719387861; c=relaxed/simple;
	bh=iAZ79Lntgn6Yf0IIjT65YZ9isgG2MCvrlbPBPO5OQ3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U/U10MlhrgBZL9M/rAFydJ1sWQEO0Cep0s8Tb+b7AVAGQWqWNJEt2BB0331tQrNZ2X8WdO8jx4fT1BoFK0ukrtIA4WOUmL8MtRgg0O+tg5yw+92rA566iRgCQffHeh8XiOyHXJXwnmT6fruVW4gG/T+gnwnUik98Mci9pB2ON8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowAAXHuatxntmX6vdEg--.47338S2;
	Wed, 26 Jun 2024 15:43:49 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: jgross@suse.com,
	boris.ostrovsky@oracle.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jeremy@goop.org
Cc: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] xen: Fix null pointer dereference in xen_init_lock_cpu()
Date: Wed, 26 Jun 2024 15:43:39 +0800
Message-Id: <20240626074339.2820381-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXHuatxntmX6vdEg--.47338S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrykAF4ktF4kXF45CF18AFb_yoWfZrbE9F
	Z2qa1UCr4rta1av34jya45Gr4Sk3s7JryUWrs3tasIq3y5JFWkKa1Dtrnagw4jka4DurW7
	Ca4UW3yUX34jkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUQZ23UUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

kasprintf() is used for formatting strings and dynamically allocating
memory space. If memory allocation fails, kasprintf() will return NULL.
We should add a check to ensure that failure does not occur.

Fixes: d5de8841355a ("x86: split spinlock implementations out into their own files")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Found this error through static analysis.
---
 arch/x86/xen/spinlock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 5c6fc16e4b92..fe3cd95c1604 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -75,6 +75,8 @@ void xen_init_lock_cpu(int cpu)
 	     cpu, per_cpu(lock_kicker_irq, cpu));
 
 	name = kasprintf(GFP_KERNEL, "spinlock%d", cpu);
+	if (!name)
+		return;
 	per_cpu(irq_name, cpu) = name;
 	irq = bind_ipi_to_irqhandler(XEN_SPIN_UNLOCK_VECTOR,
 				     cpu,
-- 
2.25.1


