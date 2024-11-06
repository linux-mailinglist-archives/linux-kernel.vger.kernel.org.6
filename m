Return-Path: <linux-kernel+bounces-398034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B52689BE48C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A801283655
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284F41DE2C1;
	Wed,  6 Nov 2024 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="rzwkd3HB"
Received: from out187-6.us.a.mail.aliyun.com (out187-6.us.a.mail.aliyun.com [47.90.187.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C51DE3D8
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730889920; cv=none; b=Gx9yq7yjm/pY7yjPSz/ybLnd23xH+3cB0PmdDRCmTuIwPq5aYe15cpSDcGG3L0zzsvKQ3zvIB+Hsp3y+QC47ghKGCyQP//+9Bf8YrnaUEkQhJcHaKYz1TfVfyGNipXgjOlPtvxuDelEQhZS+rDN71HChKSCljK5G/Ji+LJNY/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730889920; c=relaxed/simple;
	bh=TdpKBsOgCyas+x+Rm4U/URbX/Z2utvaDiZxNwLz/BRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V/azpjW+xwqaSZLiE4E0gKp3HuTKaa7/D1Za3h48k2VGoKoq+9H/ks6aB0sdkCJgN+NS1YfAOYl2mr+y/dn6jrFl1yjfHIVPKDF+iz0cSfW83ER6SiqCqtWiYw0lSYT0W58f82DAkYkfhtPRP0sUNFMCoyUDZ6PhM7fxUQlzTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=rzwkd3HB; arc=none smtp.client-ip=47.90.187.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730889898; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=PVxLB4ynQexwBLLLCslCsw+YDn8W8UTgxWZ/DVEd+W4=;
	b=rzwkd3HBdzXyFdgok5rfMJpk65SwSE+m+E2EGf8ShSPO/w6YRFbMrF6wqkTFVI6iWa1RaftZvODQGmvWP0uCZhY5lGJXoKq7Z3ttqBgT4lcee7/wUU7wwUzLEgjxCFkA7IVWoRG7g7yl4HTYQhrpBvW5lYVoTmSQFjkQJBiSPpc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a2sg25o_1730889575 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 18:39:39 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH] um: Always dump trace for specified task in show_stack
Date: Wed, 06 Nov 2024 18:39:33 +0800
Message-Id: <20241106103933.1132365-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, show_stack() always dumps the trace of the current task.
However, it should dump the trace of the specified task if one is
provided. Otherwise, things like running "echo t > sysrq-trigger"
won't work as expected.

Fixes: 970e51feaddb ("um: Add support for CONFIG_STACKTRACE")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/kernel/sysrq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index 4bb8622dc512..e3b6a2fd75d9 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -52,5 +52,5 @@ void show_stack(struct task_struct *task, unsigned long *stack,
 	}
 
 	printk("%sCall Trace:\n", loglvl);
-	dump_trace(current, &stackops, (void *)loglvl);
+	dump_trace(task ?: current, &stackops, (void *)loglvl);
 }
-- 
2.34.1


