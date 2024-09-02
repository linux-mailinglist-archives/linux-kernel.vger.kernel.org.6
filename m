Return-Path: <linux-kernel+bounces-312070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFBA969192
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 04:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08822841C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53471A264C;
	Tue,  3 Sep 2024 02:51:24 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DF61E49F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725331884; cv=none; b=I2+u23ifyYPqrV59e8G7lp5YNpqE/Mlw8uyCZBNUnpSMWT0g2kB0pNVsm561bBiVdLW12dAavg+aDykryy7cbI1edSWw9wWFQicpnXZqbs6mTEv+KicTNuVHk9nxTdy1QCEMfIXoQ9hLL0Ag3cHdeD2kGlzRZ/SaUUfExiaiJkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725331884; c=relaxed/simple;
	bh=lpdyRN1eS/FPnm9heJn4+XnpQuNq2LMOq19fL4MbQPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GW9hy0ijsQhy0c3s7NUl+U9zuBatXg54VDS368uOftRh31d2sfMVKw7oizNXRXRG013/3VTb6dlI8XBNB13exVyv37UfTyWGZOTJqRiFG3hzDcoS+RPKPnlbLZr8MVnSAujt6sKHQBThomHYE0MPUYJhQsLsoE3CtTmJ34uAUQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666d679a3ddc-a669e;
	Tue, 03 Sep 2024 10:51:17 +0800 (CST)
X-RM-TRANSID:2ee666d679a3ddc-a669e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee266d679966f7-cbd55;
	Tue, 03 Sep 2024 10:51:17 +0800 (CST)
X-RM-TRANSID:2ee266d679966f7-cbd55
From: bajing <bajing@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org
Cc: arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	linux-kernel@vger.kernel.org,
	bajing <bajing@cmss.chinamobile.com>
Subject: [PATCH v3] binder: modify the comment for binder_proc_unlock
Date: Mon,  2 Sep 2024 10:57:20 +0800
Message-Id: <20240902025720.2334-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the comment for binder_proc_unlock() to clearly indicate which spinlock it releases and to better match the acquire comment block in binder_proc_lock().

Notes:
v1: https://lore.kernel.org/all/20240830073743.2052-1-bajing@cmss.chinamobile.com/

v2: Reword commit log per suggestions from cmllamas@
https://lore.kernel.org/all/20240902013636.1739-1-bajing@cmss.chinamobile.com/

v3: Wrap commit message. Add version history.

Signed-off-by: bajing <bajing@cmss.chinamobile.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index fc55b5d0e4f3..578861d57045 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -277,7 +277,7 @@ _binder_proc_lock(struct binder_proc *proc, int line)
 }
 
 /**
- * binder_proc_unlock() - Release spinlock for given binder_proc
+ * binder_proc_unlock() - Release outer lock for given binder_proc
  * @proc:                struct binder_proc to acquire
  *
  * Release lock acquired via binder_proc_lock()
-- 
2.33.0




