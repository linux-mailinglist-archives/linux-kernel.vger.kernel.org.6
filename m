Return-Path: <linux-kernel+bounces-301253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F59595EE38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B4A6B21E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127FA148857;
	Mon, 26 Aug 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="RElUahJY"
Received: from out0-206.mail.aliyun.com (out0-206.mail.aliyun.com [140.205.0.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38B146A69
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724667232; cv=none; b=aO7vYcR2aUNsSWElM/TCALwirKpQiPDuyuWcu7YLJzepFQ2ECkRHHN7DgoZEd6YDe8/jAQ/gie5/ozudxOahCVycZW8E4oVZUXhXSdCHPmJzv/IFAnvQKA4wjK4t0/5SKVk4spnlTEWJQdaMwv0c2JkxDtZ2soLN+UEWjMzqZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724667232; c=relaxed/simple;
	bh=HrzESFheTWJ6BsXZcFRmb4C2rKB54nkinw4WDavn4p4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FZKYBUF/LY4BrsByW0QMNLQwv6o0/FZPEliLepsEbmbi6RP2dtM6h9l1XMxm8WrM28YhQOy8VGrU5BCTJ2SPc/ng6NZ6fEXBchbfb+Gu4JTcS2mcraVTBw+2IY/LRaO7e2b4yvqxqXHQ1X2veEEtTqYjiPgarn+cusX1jdLRf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=RElUahJY; arc=none smtp.client-ip=140.205.0.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1724667226; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UE3KVmrhR4CaBxvq16dvb3ocgiXdhekFGviHku9aBeM=;
	b=RElUahJYR+7j+rzQ7SiONuMIFBcSFFQBDO9VuIVO298f+UuJ62eGgzlpXFgSayfuujg6DBacLHBpCKFoGHl+XMHJFSudcqnAK6hu+Ib4zBgj91m78LrvSNgvXRG0/7Zp/TzdE1wDoo75Ee6kv1XLR39bDPGEJP7vGCSO8Hqcjfw=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Z2YRsd5_1724666907)
          by smtp.aliyun-inc.com;
          Mon, 26 Aug 2024 18:08:28 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v3 5/7] um: Remove the call to SUBARCH_EXECVE1 macro
Date: Mon, 26 Aug 2024 18:08:13 +0800
Message-Id: <20240826100815.904430-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826100815.904430-1-tiwei.btw@antgroup.com>
References: <20240826100815.904430-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro has never been defined by any supported sub-architectures
in tree since it was introduced by commit 1d3468a6643a ("[PATCH uml:
move _kern.c files").

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/exec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/um/kernel/exec.c b/arch/um/kernel/exec.c
index 2c15bb2c104c..cb8b5cd9285c 100644
--- a/arch/um/kernel/exec.c
+++ b/arch/um/kernel/exec.c
@@ -35,8 +35,5 @@ void start_thread(struct pt_regs *regs, unsigned long eip, unsigned long esp)
 	PT_REGS_IP(regs) = eip;
 	PT_REGS_SP(regs) = esp;
 	clear_thread_flag(TIF_SINGLESTEP);
-#ifdef SUBARCH_EXECVE1
-	SUBARCH_EXECVE1(regs->regs);
-#endif
 }
 EXPORT_SYMBOL(start_thread);
-- 
2.34.1


