Return-Path: <linux-kernel+bounces-414145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F3E9D23B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693831F228AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782F11C2301;
	Tue, 19 Nov 2024 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKk7o4HR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440631AA1C2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013033; cv=none; b=IeHENOc1qGS/D8yOeJHTE9uyMbfWaoBD+nieZAm7QIxiiC1USDX3xCpXPJ4t8Bl1eKaTgQtyWuGqWiURop0BSDl4kg7TKNKdBel7O6LjiUd9H4LI842Q7DqHbxTyFtObC3Kfh8prolBBXJEGgWdI49e4slX3Tz87m/HKr3XlB20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013033; c=relaxed/simple;
	bh=mJwS8pQ4YuI0VuBo4dFVcQzoGWIcpPuIXP3lsqZsb/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXMBFjea5cqVENEaQie0WFWpUJyHKq/XdkoH+rOhuix14izXzFA3TZsGdaTQ+b/4hgBDjmyoE/z9it1nI/kU9TbZ2O+e/ez74c8ryJBfecKsgczmav+9Ntxrkup2OQusRAheWGQXWVDl9NfsagxkoLSYOi7e4w43YNj0XzPhGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKk7o4HR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732013031; x=1763549031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJwS8pQ4YuI0VuBo4dFVcQzoGWIcpPuIXP3lsqZsb/U=;
  b=RKk7o4HRvBj0a3awAKMdFTSTVQRD2H/ee8KZU/hIIJUYIMl7OeyapGa1
   1SyLs3vSdPgB0d/tiRVDocPzGjPa9jEOgL+cENkIzSokiZ9ZoV+WzOI30
   k2mY4fzHU1F1BeDUZ/Lzw9cqDNou83a2LJ0J0TgXlrKyPWz33wor60zf5
   3hz4dKfCT8fSVo/aZTTJV4gSXB4i/n2SO3Jj/7DFLkYMRROF6q/H/ThX/
   b2iD+lhDzPC1NjsS3zf8DaPdH0lChuAq4C36DuObb6+LiowLFOHlR2dfI
   EC2dGFycrTpYRENQwrLKYDA7ZTM1Ap+XqXkHeh+xpgiCF/DOhHH6qQB3d
   Q==;
X-CSE-ConnectionGUID: viVn+x6JSmaHxDPja+t8iQ==
X-CSE-MsgGUID: TSxvAF5lQUeOX+Y0z/M4Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="35913988"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="35913988"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 02:43:51 -0800
X-CSE-ConnectionGUID: 2wwF5anTTl6UQ5mrapDsqw==
X-CSE-MsgGUID: n4s7kc4yRgmTT8sJr2Ll9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="89925597"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 19 Nov 2024 02:43:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 6E6EA18B; Tue, 19 Nov 2024 12:43:45 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] genirq: Move irq_forced_thread_fn() further in the code
Date: Tue, 19 Nov 2024 12:42:34 +0200
Message-ID: <20241119104339.2112455-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241119104339.2112455-1-andriy.shevchenko@linux.intel.com>
References: <20241119104339.2112455-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a preparation of the refactoring, move irq_forced_thread_fn()
further in the code. No functional changes intented.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/irq/manage.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f0803d6bd296..310fbeed4d7a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1181,6 +1181,24 @@ static void irq_finalize_oneshot(struct irq_desc *desc,
 	chip_bus_sync_unlock(desc);
 }
 
+/*
+ * Interrupts explicitly requested as threaded interrupts want to be
+ * preemptible - many of them need to sleep and wait for slow busses to
+ * complete.
+ */
+static irqreturn_t irq_thread_fn(struct irq_desc *desc,
+		struct irqaction *action)
+{
+	irqreturn_t ret;
+
+	ret = action->thread_fn(action->irq, action->dev_id);
+	if (ret == IRQ_HANDLED)
+		atomic_inc(&desc->threads_handled);
+
+	irq_finalize_oneshot(desc, action);
+	return ret;
+}
+
 /*
  * Interrupts which are not explicitly requested as threaded
  * interrupts rely on the implicit bh/preempt disable of the hard irq
@@ -1206,24 +1224,6 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 	return ret;
 }
 
-/*
- * Interrupts explicitly requested as threaded interrupts want to be
- * preemptible - many of them need to sleep and wait for slow busses to
- * complete.
- */
-static irqreturn_t irq_thread_fn(struct irq_desc *desc,
-		struct irqaction *action)
-{
-	irqreturn_t ret;
-
-	ret = action->thread_fn(action->irq, action->dev_id);
-	if (ret == IRQ_HANDLED)
-		atomic_inc(&desc->threads_handled);
-
-	irq_finalize_oneshot(desc, action);
-	return ret;
-}
-
 void wake_threads_waitq(struct irq_desc *desc)
 {
 	if (atomic_dec_and_test(&desc->threads_active))
-- 
2.43.0.rc1.1336.g36b5255a03ac


