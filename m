Return-Path: <linux-kernel+bounces-308229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DF29658F1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5432F287764
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F0158A23;
	Fri, 30 Aug 2024 07:44:17 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C22F1581EB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003857; cv=none; b=p7Gfh2CSFrSX2FAQMfhsOo9dRbMePYXCQstHfQvB71uSerhDk/N7qUs52U/sQd9l1HB4cPL5QHe2IFpR9Zyz3vxy+LkGyqfazqgUxACeCGGdm+ElsDlhFFQDH+lpaP36Ggolb/apZHgNEmECfQjcZyHIk8xblJPKEaRNhrPFkT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003857; c=relaxed/simple;
	bh=s+b8Q4G2WSnUCM7oCRuGYmgDVZU2AImlsdTGDGOuSaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5LzeHg7MbgHe/+Zjax7cTF7TBO7deNfl6Slx5KKvuM8DcOaB/D8WQ0cbKV9YiSTWVIyNbnTyx7P/4jRCPE3LakQ08nlCwu0G4ABeyshE5ssdNVyMqsGRB7Xa+o+KNQT+aK1kFUEyNhWsFqYULe73BUBxm1h2SXQVz9TT4NWZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466d17845d86-8e679;
	Fri, 30 Aug 2024 15:44:05 +0800 (CST)
X-RM-TRANSID:2ee466d17845d86-8e679
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66d1783210e-d2d23;
	Fri, 30 Aug 2024 15:44:05 +0800 (CST)
X-RM-TRANSID:2eea66d1783210e-d2d23
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
Subject: [PATCH] android: binder: modify incorrect comments
Date: Fri, 30 Aug 2024 15:37:43 +0800
Message-Id: <20240830073743.2052-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for binder_proc_unlock was incorrect, so it should be modified.

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




