Return-Path: <linux-kernel+bounces-288898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83A95402C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 05:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25751F25C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91036F303;
	Fri, 16 Aug 2024 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="2RT0/eFe"
Received: from out187-19.us.a.mail.aliyun.com (out187-19.us.a.mail.aliyun.com [47.90.187.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAAB6A8C1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780597; cv=none; b=RQjtL6tYGx5vCuI6R8PQML8ecUo363LCLBRXV3T+FWi4AR2fyXCRfPl5mlbRODAlwRBqVqFQxyaZWRrxjQd2SDQKclFTney0v8TR6h/TMB5vGM965sUi/MG7ZUyI93zlvaF79EnVuaogE4qfSKe7DsMBhIfnbIX1uhr8CHT++vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780597; c=relaxed/simple;
	bh=spZ3LOvkvA7HC0vXfPQJtr2q7pS40m/umBN5GazXmmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFC6JU8YDrymzpL13+HcZnNZeAqnlEfdAFALXoUX82v/lxNJhH0okh1zMeGULqv3JJKTBM+rniExEygE+SuYyik/9Bc8LoRMs9UStGP87vfetbLr3R6+IN/a+pL8g7V/XlpFXpDQ5pfHXgH+6OI3jymj29lMYwQThue8rgVEHLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=2RT0/eFe; arc=none smtp.client-ip=47.90.187.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723780580; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xaPbnHCYbWmnOQhAEH3tFBvJcl0Mc7zmh0X86Vcw7mg=;
	b=2RT0/eFeroIeZqaNKZ+U8MeM36T4N9hB8emOJ4P5Xvq9Da+JHNVJrzO3cfCyh4PxFpJrWeRKgc/5nfNzj9onzSsM1RBgUqAwHrTWLXLzm5VzWiY4na7y8Y3BV0rhTja6Vy+hGWJBXk1pePv6B7okq69S7i11KlHa4wS6yCs5Vrk=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtEBokH_1723773296)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:54:57 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 5/6] um: Remove the call to SUBARCH_EXECVE1 macro
Date: Fri, 16 Aug 2024 09:54:46 +0800
Message-Id: <20240816015447.320394-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816015447.320394-1-tiwei.btw@antgroup.com>
References: <20240816015447.320394-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro isn't defined by any supported sub-architectures in tree
since it was introduced by commit 1d3468a6643a ("[PATCH uml: move
_kern.c files").

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


