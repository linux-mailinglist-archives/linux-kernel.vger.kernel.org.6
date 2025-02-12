Return-Path: <linux-kernel+bounces-511080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DDEA32587
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B49D188B472
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BB820ADD8;
	Wed, 12 Feb 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U7y2082C"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6B2B9BC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361639; cv=none; b=oF+Vxr1m8oJXCjlE7NqaypOPwa/CpDqoPx8HeT+z5BN2/PCCCQ667pmaw0x9cwrERFLumuHXXoQ9v8V7WwEnT+0mjg54/Z8qWpH4AJCeia0nNDjSpKOyL046YLVQ9017JjgKBLdsRToaIPDIDgufrEVjlGvcjKK2ZhN39onfTKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361639; c=relaxed/simple;
	bh=mQ7Bx8LWA2WPZV209RY0v4ZJsFPtlqQJ+P0zlyTJ/PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UM/ZH4ibJuPZVz0yg3NyyINAkQ8veWQD8pz5GcV+XEJuapmUvsFeS0PklenMti17tVTh+rnQWz9G1+X2e1vktLDEcDfnR1MSu/SjdiIju7QdqWd1UpkEQzzDQGn9suJCtIBKmDfZGU7uYaKP2QKXTxr4MhSQKci9of0xgHoT4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U7y2082C; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739361625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZtGIzwFB0GJQ/v8jIXIgc4rWv8l3r7GL5QeYcUjBimI=;
	b=U7y2082CpqHjXso6MkBN4/hCTHukf1cqmPYgVq1hZe1NOeBYLzzt95d4yJLMJSM5UG/ehN
	Q6YdNDo7Ra/UMPYFAzx0ZdFOWzXCWrL8sSLVSWaF7NkPkUIXphU/r2o9XFPhCM/cPsGD0u
	c//bYtToQRSAHko2YWSvIkMLHgz5IaQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jeff Layton <jlayton@kernel.org>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	xu xin <xu.xin16@zte.com.cn>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: Use str_yes_no() helper in proc_pid_ksm_stat()
Date: Wed, 12 Feb 2025 12:59:52 +0100
Message-ID: <20250212115954.111652-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/proc/base.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e956c322..f28acc5d5ec8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -60,6 +60,7 @@
 #include <linux/file.h>
 #include <linux/generic-radix-tree.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/seq_file.h>
 #include <linux/namei.h>
 #include <linux/mnt_namespace.h>
@@ -3280,14 +3281,14 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
 		seq_printf(m, "ksm_merge_any: %s\n",
-				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
+				str_yes_no(test_bit(MMF_VM_MERGE_ANY, &mm->flags)));
 		ret = mmap_read_lock_killable(mm);
 		if (ret) {
 			mmput(mm);
 			return ret;
 		}
 		seq_printf(m, "ksm_mergeable: %s\n",
-				ksm_process_mergeable(mm) ? "yes" : "no");
+				str_yes_no(ksm_process_mergeable(mm)));
 		mmap_read_unlock(mm);
 		mmput(mm);
 	}
-- 
2.48.1


