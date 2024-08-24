Return-Path: <linux-kernel+bounces-300076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C0B95DE79
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 904C5282AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D717A59D;
	Sat, 24 Aug 2024 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AGesuvpa"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C21714C0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510367; cv=none; b=WpARoMnioQDDoumwZBJflSHiW/iOzT83Wl3M8f+GsCFx76wtxCZ4Ic92szYl9LJV5d9jSFlrz+4xc0ngIRCQLOuhYKrf8nVEIfiitqhjukMfomQjwLyWmP0RvIJNFAJVY2ABh/6A5pDnCMyyyaiJg42LGqFgKgEdxw9qQzE851A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510367; c=relaxed/simple;
	bh=2vG3XvcAJAy/RaIv82c5b6/x/5jevV6hzqeOTNSfal8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E6XETE0LeqBBcqlbmZr2/02FcQenm/8H/c9dzBwZABS2f6zazj/V9uRbVXpZBmqeu1K1Zkt7Z8UkdJt3L1T9uAqSJz5+4pfEMvX8klp6/G5OX6sCjPjo0xm5JU4R1hDZmu/6v6iy3KJT30bC3l/8MHmVH0dEAZNmfChX2dJoEx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AGesuvpa; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724510362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RM30oiM0MdLfvWeDuCVOBBk7mwRBCtry7f5KQtp1Hm4=;
	b=AGesuvpaN0VygvtS1qARv0CNYDoHHZQZXaRUPwWtWxGNF02T1pprOG/WTx1Jk0/PvYXMQK
	aXL7VacI7gjErRufkC/CjqSW67OT+pJslqpNUPyIDWQYjUXQoD4k+RUp9lIbjTtqXcMEGH
	jNYPijzi/JjrvZgq8mIv0/nUlBBKuhc=
From: Wen Yang <wen.yang@linux.dev>
To: Bjorn Andersson <andersson@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Wen Yang <wen.yang@linux.dev>,
	Dave Young <dyoung@redhat.com>,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwspinlock: improve locking safety by using raw_spinlock_t
Date: Sat, 24 Aug 2024 22:38:47 +0800
Message-Id: <20240824143847.5307-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Both __hwspin_trylock and __hwspin_unlock use hwlock->lock, and require
running in atomic context, with a special annotation:
function will never sleep.
However, this requirement is not fulfilled on PREEMPT_RT.

To address it, use raw_spinlock_t instead of spin_lock_t.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/hwspinlock/hwspinlock_core.c     | 20 ++++++++++----------
 drivers/hwspinlock/hwspinlock_internal.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index 6505261e6068..76e5a6c645b1 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -111,17 +111,17 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 	 */
 	switch (mode) {
 	case HWLOCK_IRQSTATE:
-		ret = spin_trylock_irqsave(&hwlock->lock, *flags);
+		ret = raw_spin_trylock_irqsave(&hwlock->lock, *flags);
 		break;
 	case HWLOCK_IRQ:
-		ret = spin_trylock_irq(&hwlock->lock);
+		ret = raw_spin_trylock_irq(&hwlock->lock);
 		break;
 	case HWLOCK_RAW:
 	case HWLOCK_IN_ATOMIC:
 		ret = 1;
 		break;
 	default:
-		ret = spin_trylock(&hwlock->lock);
+		ret = raw_spin_trylock(&hwlock->lock);
 		break;
 	}
 
@@ -136,17 +136,17 @@ int __hwspin_trylock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 	if (!ret) {
 		switch (mode) {
 		case HWLOCK_IRQSTATE:
-			spin_unlock_irqrestore(&hwlock->lock, *flags);
+			raw_spin_unlock_irqrestore(&hwlock->lock, *flags);
 			break;
 		case HWLOCK_IRQ:
-			spin_unlock_irq(&hwlock->lock);
+			raw_spin_unlock_irq(&hwlock->lock);
 			break;
 		case HWLOCK_RAW:
 		case HWLOCK_IN_ATOMIC:
 			/* Nothing to do */
 			break;
 		default:
-			spin_unlock(&hwlock->lock);
+			raw_spin_unlock(&hwlock->lock);
 			break;
 		}
 
@@ -289,17 +289,17 @@ void __hwspin_unlock(struct hwspinlock *hwlock, int mode, unsigned long *flags)
 	/* Undo the spin_trylock{_irq, _irqsave} called while locking */
 	switch (mode) {
 	case HWLOCK_IRQSTATE:
-		spin_unlock_irqrestore(&hwlock->lock, *flags);
+		raw_spin_unlock_irqrestore(&hwlock->lock, *flags);
 		break;
 	case HWLOCK_IRQ:
-		spin_unlock_irq(&hwlock->lock);
+		raw_spin_unlock_irq(&hwlock->lock);
 		break;
 	case HWLOCK_RAW:
 	case HWLOCK_IN_ATOMIC:
 		/* Nothing to do */
 		break;
 	default:
-		spin_unlock(&hwlock->lock);
+		raw_spin_unlock(&hwlock->lock);
 		break;
 	}
 }
@@ -535,7 +535,7 @@ int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 	for (i = 0; i < num_locks; i++) {
 		hwlock = &bank->lock[i];
 
-		spin_lock_init(&hwlock->lock);
+		raw_spin_lock_init(&hwlock->lock);
 		hwlock->bank = bank;
 
 		ret = hwspin_lock_register_single(hwlock, base_id + i);
diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
index f298fc0ee5ad..9fbd66e8a82f 100644
--- a/drivers/hwspinlock/hwspinlock_internal.h
+++ b/drivers/hwspinlock/hwspinlock_internal.h
@@ -42,7 +42,7 @@ struct hwspinlock_ops {
  */
 struct hwspinlock {
 	struct hwspinlock_device *bank;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	void *priv;
 };
 
-- 
2.25.1


