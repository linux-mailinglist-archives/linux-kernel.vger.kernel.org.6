Return-Path: <linux-kernel+bounces-570696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA02A6B3A7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A823B837C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF611E5B7A;
	Fri, 21 Mar 2025 04:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="GBYRSSIG"
Received: from out0-220.mail.aliyun.com (out0-220.mail.aliyun.com [140.205.0.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B11B664
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742531172; cv=none; b=RJGtAF3g6toMYgJRB0Sa9d1AKtyORiSO7T43PWAdxr9KMrWgiT3bc6lapmmC7eU3IkoI4z45aHv4WbuTibXVvsc2LYBn7NhhOeT+bobP3Xg5maHVMW6MRUnoYxHtOQX82MIHQIddrN/bbb0eNbxy1dgdbvKQDMNzgHFu/dIMZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742531172; c=relaxed/simple;
	bh=o1ssKcOIg/aDHkWl9VQMhQVIYWwH/7KGmbd90J0EhrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CcduaFH6/DHST9qTOj65+pxJu+RbMWJ154oFT/+32IkL/qvhC2qaLBHYRYYyJ5QsC1E1sxfB0wUlSL9siCfDlZNsPHFYFoYuS61C47W/D0Tz1fhcJK4irA6deDc8rRNMQ6PKOrZ8hvx6mjv+mi++RVa9Jcl7Ee0UlFqLo4/f5uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=GBYRSSIG; arc=none smtp.client-ip=140.205.0.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742531166; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VsJHduJlbjQ/kh8Iq30W8vJNdi20hMIhWmJ47RHEKA0=;
	b=GBYRSSIGOrJXDomVQyDnU6jJAUsgx8TCtKA3Zf0ZFo0MXP5FgINOy0GJwZaT94T6ibyCn1PygNWF2oG0ent5gxyRu15cSOZgeKfNYnfbtyx4Auyj/6I6tvt5r9FvFrcKwZfn7uCKndyCaCq2f01ij5jYvQV/gNTpeMFK8IxbBEU=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.c-P7dFG_1742529313 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 21 Mar 2025 11:55:14 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: linux-kernel@vger.kernel.org
Cc: "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
  "Arnd Bergmann" <arnd@arndb.de>,
  "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [PATCH] char: misc: Use __register_chrdev() to register the actual minor counts
Date: Fri, 21 Mar 2025 11:54:42 +0800
Message-Id: <b63b7981191777a6d175cfa98379e987281b9e3a.1742528326.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit ab760791c0cf ("char: misc: Increase the maximum number of
dynamic misc devices to 1048448"), the minor number of misc char device
is increased to MINORMASK + 1. However, it still uses register_chrdev(),
which defaults to registering the misc char device with only 256 minor
numbers.  Therefore, when a misc device is given a minor number greater
than 255, the device file fails to open in kobj_lookup(). As a solution,
use __register_chrdev() to register the actual minor counts to
accommodate this increase.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
In our environment, the per-cpu coresight_tmc driver occupies too many
minor numbers, which ultimately allocates minor number 256 for our misc
device, resulting in a failure to open the device file in /dev. I'm not
sure if this is a bug or if userspace can only use fewer than 256 minor
numbers. Therefore, I didn't add a fix tag here.
---
 drivers/char/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index f7dd455dd0dd..dda466f9181a 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -315,7 +315,7 @@ static int __init misc_init(void)
 		goto fail_remove;
 
 	err = -EIO;
-	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
+	if (__register_chrdev(MISC_MAJOR, 0, MINORMASK + 1, "misc", &misc_fops))
 		goto fail_printk;
 	return 0;
 
-- 
2.31.1


