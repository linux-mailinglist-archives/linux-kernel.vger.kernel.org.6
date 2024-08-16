Return-Path: <linux-kernel+bounces-289450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9771B95465D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2E2B2521F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B741714CA;
	Fri, 16 Aug 2024 10:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="LZz4lA0S"
Received: from out0-220.mail.aliyun.com (out0-220.mail.aliyun.com [140.205.0.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E812DD90
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802411; cv=none; b=rNYfho0/dL4OcE0Zjt9VJAEmYuwSBhkQSm+9bLvKpTtvr0SJxeaBSef1ih/ZhZjXR8b6uINUswlZLdjE5mDFYz0PVXhcwbS2FlVky9FVUAdQNj7G2dK5eM5t4XDYJaJbiuhrsb9mufYOJTHHxAFpUjylDQQK5+0WRnt3woWExqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802411; c=relaxed/simple;
	bh=spZ3LOvkvA7HC0vXfPQJtr2q7pS40m/umBN5GazXmmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hiu5g0qwHGDxJzujsAvxIzzZvDFQQPEn5McXtrG/rSXx3ZuVsJcfFah/VWJuGs5JGdvlhKjgsv2qPpE89v1dbPGq1atRRXIXbDV8GNUWr1Aj7H6yB6Rs+j0QXFivWMHP1MssNT/EloaHNgcjJ3QZOTlonDxKE1XjUedKZTAE3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=LZz4lA0S; arc=none smtp.client-ip=140.205.0.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1723802405; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xaPbnHCYbWmnOQhAEH3tFBvJcl0Mc7zmh0X86Vcw7mg=;
	b=LZz4lA0Sa+rqCiyhu+pwRlH+JjFnjML8aYphyxQjZQpuN5pvPdY8VW6a3JU7Qtw77KGBJYSG+ks9FYZ2BT6IfwIx+iLUqxfU/3dtku2xwoVkkbIR7clBYLPKP4M0lcFv2P7a+1jbCxJDUeIJmKVcxPhvN/1c+L5Mjh1TnV7KH3Q=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.YtmFE9B_1723802404)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:00:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 5/6] um: Remove the call to SUBARCH_EXECVE1 macro
Date: Fri, 16 Aug 2024 17:59:52 +0800
Message-Id: <20240816095953.638401-6-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816095953.638401-1-tiwei.btw@antgroup.com>
References: <20240816095953.638401-1-tiwei.btw@antgroup.com>
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


