Return-Path: <linux-kernel+bounces-292330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1757956E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4531F23708
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F3A17554A;
	Mon, 19 Aug 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LnmVg/Yz"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FE165EE7
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079619; cv=none; b=IIIrzBGH3Ns65WvibS+xzXrD2nGOcNRjwSuEl1QJvtl+aMyFCowfvQOMOYoNkON08ZX/fa8zYEqFM/LmM801YfNbuqUY1fxVmT+PPtKFj4osDPlMEtEIrngDhW+9LKgKQSS1g/m/zNPRqsCtmx7t76nTW7IQRbQQvSo6NVgF2+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079619; c=relaxed/simple;
	bh=UpakP+LQFlNnM6Zw0AAlsSkDSRLmpBoawiG982MRG6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I4N889ZXOhIa6Dj8bCNYRTzbLbJZXf8m8hep6B8eodanoXok+9Qvv/uU3+pMzOcKCN/LvQEGiRTjJioJ+PSa9HzEvpZGVAuVZkYMq1Oh7oXl7hdVmkcCQIVlvU0GbXdOl/KW46ZB/mm+GcXjoCzg59nOaDFWcJpWZcu+aJc1ph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LnmVg/Yz; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724079613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vgW+uHwNuk7h93K8oNWROGjNqFAAAj5a0d6tOmKKCMI=;
	b=LnmVg/Yzf0giKL+M9jhBOh9EHvL6h4BZbcnBMxi7OA/JnpuhR9xQfpm0UFuyStYRA2zEMI
	0/ioX34gZAW7l2VeC4G6lLpJBTcSjTtkAwlW2TgF4PO/yCDKgCtpWu/SHHttPSI4m7xSYh
	Ypa4JQzcYVTgE2lnPlXkEx8isk0CIYw=
From: Wen Yang <wen.yang@linux.dev>
To: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pstore: replace spinlock_t by raw_spinlock_t
Date: Mon, 19 Aug 2024 22:59:45 +0800
Message-Id: <20240819145945.61274-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

pstore_dump() is called when both preemption and local IRQ are disabled,
and a spinlock is obtained, which is problematic for the RT kernel because
in this configuration, spinlocks are sleep locks.

Replace the spinlock_t with raw_spinlock_t to avoid sleeping in atomic context.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Kees Cook <kees@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/pstore/platform.c   | 8 ++++----
 include/linux/pstore.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 3497ede88aa0..84719e2bcbc4 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -288,13 +288,13 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	why = kmsg_dump_reason_str(reason);
 
 	if (pstore_cannot_block_path(reason)) {
-		if (!spin_trylock_irqsave(&psinfo->buf_lock, flags)) {
+		if (!raw_spin_trylock_irqsave(&psinfo->buf_lock, flags)) {
 			pr_err("dump skipped in %s path because of concurrent dump\n",
 					in_nmi() ? "NMI" : why);
 			return;
 		}
 	} else {
-		spin_lock_irqsave(&psinfo->buf_lock, flags);
+		raw_spin_lock_irqsave(&psinfo->buf_lock, flags);
 	}
 
 	kmsg_dump_rewind(&iter);
@@ -364,7 +364,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		total += record.size;
 		part++;
 	}
-	spin_unlock_irqrestore(&psinfo->buf_lock, flags);
+	raw_spin_unlock_irqrestore(&psinfo->buf_lock, flags);
 
 	if (saved_ret) {
 		pr_err_once("backend (%s) writing error (%d)\n", psinfo->name,
@@ -503,7 +503,7 @@ int pstore_register(struct pstore_info *psi)
 		psi->write_user = pstore_write_user_compat;
 	psinfo = psi;
 	mutex_init(&psinfo->read_mutex);
-	spin_lock_init(&psinfo->buf_lock);
+	raw_spin_lock_init(&psinfo->buf_lock);
 
 	if (psi->flags & PSTORE_FLAGS_DMESG)
 		allocate_buf_for_compression();
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 638507a3c8ff..fed601053c51 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -182,7 +182,7 @@ struct pstore_info {
 	struct module	*owner;
 	const char	*name;
 
-	spinlock_t	buf_lock;
+	raw_spinlock_t	buf_lock;
 	char		*buf;
 	size_t		bufsize;
 
-- 
2.25.1


