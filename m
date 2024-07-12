Return-Path: <linux-kernel+bounces-250108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB09292F455
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F07E2836AD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD64D502;
	Fri, 12 Jul 2024 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpbiQSIe"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696DEC8C0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754534; cv=none; b=gEcVd2/1YRSGr968aUoj4zx3a9K+e0RC+8HxcKG7JFy0E8wRNx+BjkY7mwolDl/NTnZ2MEuy+gU/2BGDzAlKf+DmigoCaWY7+aXUy5d6iFFub1LwLodotSvzXn/n4o0gMV+7UE2IvRqXsZ/7XJN9DaJuY9OSZf0UBuw2KtjQaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754534; c=relaxed/simple;
	bh=OHAsYhaKOEHG3s75UMGzABwQfPDtLyTV5A/SR5L6ck8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DnOkiNwVpwbtHib57BKjOMK8jT1YoUW/Yu8EPl5kltfUB8NMmdQdrEfsNkqq71ZXVKqiSvV8h/u/plSiPQv+aICjmzWy49p+kl0/lHE9L5l7taK9YIfJVFTzvMZZsURf5ChJ0MVJK2T6NpsN6mFk780MOmnAMuuFBWsCniTxxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpbiQSIe; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ooseel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb53bfb6easo11724855ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720754532; x=1721359332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wQYM2xTXqFNK+7ZNgdUzObq9/WGwGVICLOM2rAxGg5Y=;
        b=ZpbiQSIeE1zDCoP8OxdMvLda329zCtIDwOAMq3uULYbhsWsTQQZMBSNu5iqNY4r6sp
         XTr4+lZCsOTGO8xvVReNGgA6Tn6yWgtwi+W9Lj1v0xB5pS+26qRyNyM0p3Pt7wNtII5Q
         HZ26SIU2BdD7wPG/WvPwht//rK7/nPkwSSGcaSrK4HWi1pAk1R75U5ARox7qjykjaDaV
         rHtgKa/CnbLVVfaN3nCEu6L/b7pyfZp3pGMmHDqZckCfL4CuOipIwd82IfIViQ1quBQ/
         CV9Ydve2/+blp9XHz6MKg5qr31h5xp6UhyOJpAryPf78myhf95PMuKw1Im1LLQf1X5mD
         B7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720754532; x=1721359332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQYM2xTXqFNK+7ZNgdUzObq9/WGwGVICLOM2rAxGg5Y=;
        b=IQ5x+gYU3P+xizGAraADT2DIj5b+7/rsFu5rXMpRr+eRoWK72SBVZECqAB7lhzGgMD
         3sOz3zqqIaSJdqvdIau3xuWTQ+9jVwi9ALr6W/D1IyBOGsqvBUvRHegnE0W5J+USYWG/
         F1hl/VNz0arZO0zTiY4yQpIoMkqIBFhivO2yvAH23GTS6pzdSNaA7OiK+ulpcT9BLGEM
         x30c3Rm7eu8kwoPcMnZ+U0V7TQzIbWjdcFZykXYG8sQ9C6zERzZyJmA/P7H4cqi6LYgj
         1gjXAIUPmhSt3wJfXh52SpdG7JK5+mq6YWUzQw9gVYq2r01Tl9+Dtzov0WkPEBWZycUb
         SFqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo58qBQOlzRfpp3N8td9BFaCL4SV8MKfcHllBzK6NjeptLk6MkpBUnEn6K4EfUTRlc/7tKdCjNDxflad6Nz7cmJU59m3f19MYzKVja
X-Gm-Message-State: AOJu0YyNoaKgoHiOrVNszcRl0kwkawXJ93+c+NOR9bMJkJena1D+Qo3o
	J4vDCgjd7umI3Ep9OyosO96GI5ZIqftv9WSqc23hgH2lcdwC278g
X-Google-Smtp-Source: AGHT+IEkCdZSQE4R8aOI+LFP/QhmH25+6KeLCtcd2oQNpJ3YRSDZbo9j3/FKzNSIhevRljHvbHVqZA==
X-Received: by 2002:a17:902:f691:b0:1fb:1fd6:5e57 with SMTP id d9443c01a7336-1fbb6ce5033mr88270925ad.6.1720754531647;
        Thu, 11 Jul 2024 20:22:11 -0700 (PDT)
Received: from SYSOS.. ([115.178.65.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2c055sm58892735ad.104.2024.07.11.20.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 20:22:11 -0700 (PDT)
Sender: Leesoo Ahn <yisooan.dev@gmail.com>
From: Leesoo Ahn <lsahn@ooseel.net>
X-Google-Original-From: Leesoo Ahn <lsahn@wewakecorp.com>
To: lsahn@ooseel.net
Cc: Leesoo Ahn <lsahn@wewakecorp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] android: binder: print error message on failure of creating proc file
Date: Fri, 12 Jul 2024 12:21:40 +0900
Message-Id: <20240712032140.4012667-1-lsahn@wewakecorp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It better prints out an error message to give more information if
calling debugfs_create_file() is failure and the return value has an
error code.

Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
---
 drivers/android/binder.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index b21a7b246a0d..eb0fd1443d69 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5673,6 +5673,7 @@ static int binder_open(struct inode *nodp, struct file *filp)
 
 	if (binder_debugfs_dir_entry_proc && !existing_pid) {
 		char strbuf[11];
+		struct dentry *debugfs_entry;
 
 		snprintf(strbuf, sizeof(strbuf), "%u", proc->pid);
 		/*
@@ -5681,10 +5682,19 @@ static int binder_open(struct inode *nodp, struct file *filp)
 		 * The printing code will anyway print all contexts for a given
 		 * PID so this is not a problem.
 		 */
-		proc->debugfs_entry = debugfs_create_file(strbuf, 0444,
+		debugfs_entry = debugfs_create_file(strbuf, 0444,
 			binder_debugfs_dir_entry_proc,
 			(void *)(unsigned long)proc->pid,
 			&proc_fops);
+		if (!IS_ERR(debugfs_entry)) {
+			proc->debugfs_entry = debugfs_entry;
+		} else {
+			int error;
+
+			error = PTR_ERR(debugfs_entry);
+			pr_warn("Unable to create file %s in debugfs (error %d)\n",
+				strbuf, error);
+		}
 	}
 
 	if (binder_binderfs_dir_entry_proc && !existing_pid) {
-- 
2.34.1


