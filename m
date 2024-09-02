Return-Path: <linux-kernel+bounces-310466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A6967D6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455F61C21615
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 01:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B91E1C6BE;
	Mon,  2 Sep 2024 01:37:22 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2D18C3E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 01:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725241041; cv=none; b=g9nCVFDhkUcHL2AXNoam8f4xDAusXPMjWpqoL4zQ150tq+VPkJfUIq2DMsBJadf+1pUFcn4URzj7exzhuaV41gmeqKV7w4uX4N80O123GaBIbZvOtodoL+fxUzXFuDva4QcHIbfxwKiI66a/6A+e2S5cSaqzhE3/IBeVAN8nWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725241041; c=relaxed/simple;
	bh=HacfNGpqlaar1AVLz97+uRGMj7EyeqWsmk6OfePyF70=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MqnhDHL3hvzLeNfMUo2CvnvJY9mwdgcBoIDasmiK0rU/d4gF8zFeETNSTEvdIWYzKG3+GkP6fRXF0flqWH8GqgWhcNy8WmRWw/2YvrxJxVG+B4+j9rSmDykw2JpPtTfmzbXrl57TCIruRQLQwtMNUJ9Dngh38D3ufRfr+9HC7I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee566d516c574e-cd751;
	Mon, 02 Sep 2024 09:37:09 +0800 (CST)
X-RM-TRANSID:2ee566d516c574e-cd751
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.100])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee366d516b3a67-7ee84;
	Mon, 02 Sep 2024 09:37:09 +0800 (CST)
X-RM-TRANSID:2ee366d516b3a67-7ee84
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
Subject: [PATCH] android: binder: modify the comment for binder_proc_unlock
Date: Mon,  2 Sep 2024 09:36:36 +0800
Message-Id: <20240902013636.1739-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the comment for binder_proc_unlock() to clearly indicate which spinlock it releases and to better match the acquire comment block in binder_proc_lock().

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




