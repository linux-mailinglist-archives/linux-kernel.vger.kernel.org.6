Return-Path: <linux-kernel+bounces-312660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF32969979
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08D5280A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6119F40E;
	Tue,  3 Sep 2024 09:48:19 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F401A0BF0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 09:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356898; cv=none; b=EUQUq5mjdEFtinkWq5VG0CovLkPSM9oAorWv8PXbdbKoDl3gvuRCwzyu7CBQQjVQuww6OURP7ljD9jVXfnn+g/TQQW92vTzmEg+lA5/Y7QgzEPyWFGjgB9pX4ah7IBJdL38WywMwerosMXDwgS6D/UhLNZuGGxmJk8k9zkQYP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356898; c=relaxed/simple;
	bh=Ie6NLmFQoD4Md3Qk8tF7y80C1Di0Pn1y4OQoov6TJqU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NGPDKJ1kIXU5SVT2uxYYPBi9Km0FASeMNnhzKlhvG1BQ9JKa4XwBaVOOsLvACfzNnjE+j1ldwkjqUfjSIB3InH2tWpkd647CSGRL9Pq1lRr0Qnq8Es+Rf+QP14Xo7majbIK7h7bhB1OCHVLmNqFl6EiVvg1XFqOFuhSg5DITAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966d6db5dfd8-e1fdc;
	Tue, 03 Sep 2024 17:48:14 +0800 (CST)
X-RM-TRANSID:2ee966d6db5dfd8-e1fdc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866d6db4ed4d-da1ba;
	Tue, 03 Sep 2024 17:48:13 +0800 (CST)
X-RM-TRANSID:2ee866d6db4ed4d-da1ba
From: Ba Jing <bajing@cmss.chinamobile.com>
To: gregkh@linuxfoundation.org
Cc: arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH v4] binder: modify the comment for binder_proc_unlock
Date: Mon,  2 Sep 2024 11:37:54 +0800
Message-Id: <20240902033754.2708-1-bajing@cmss.chinamobile.com>
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
https://lore.kernel.org/all/20240902025720.2334-1-bajing@cmss.chinamobile.com/

v4: Modify the commit information.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
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




