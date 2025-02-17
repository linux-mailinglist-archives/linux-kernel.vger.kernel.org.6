Return-Path: <linux-kernel+bounces-516968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360D1A37A55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4DC3AECFA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69069155322;
	Mon, 17 Feb 2025 04:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="ldoW2fS7"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84B2260C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739765445; cv=none; b=rxkfMJKL5uz73WoPzkQPOOFT6ChTg3vtDIWzxzfCyD9Zwy+cDIwvmBN2rY8Jy6z8Kkvn9kQ+JCGIk9n/RrMyUUXMfDolFdP1NythgdQkuP2JkHEjY8Y6moXdllMDl0hCyBR/loFtE96IuI1pcLcYQZ/ZGtSetRmVqL6dFzam7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739765445; c=relaxed/simple;
	bh=UMaPutujyDAb5iBHrtFh/y1qI9ktfsOe/ZHf+S5XvWU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aoOygVOLK+pXKQHqnpiAHFW8D8swoDzRwqAhYopRszSV6hVLUGnoirRPjoNqxoS63LHlaEfPMA/ELgT1aLrXxCtRpS2aLo2g9y08wYxLEKxZLRncpoDxHbhy67RiMW28WT1nMW6nO1QsSTq+2RiKqTbEWrehyCVXP4MGU46l2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=ldoW2fS7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abadccdfe5aso395074366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 20:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1739765442; x=1740370242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRvN5rcy5TnvgoMdGp5N5UOA9EEdQFnO93KkfqoEeas=;
        b=ldoW2fS72gmzOivQjQ3VvuLG6G0dABD42TVmrqiNj3o8Lu56gsht+V9gEjTYjR0p2A
         uJ9iR6jNh1Wf0CZpx8dYNSQJvZHTBtEz5J02OOrBOXXo/wokJPYD3NHNMlCTkWvo6iVf
         anyHybnS6OOi0zR/lKXn9+QzzJ8yUhYvc7LjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739765442; x=1740370242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRvN5rcy5TnvgoMdGp5N5UOA9EEdQFnO93KkfqoEeas=;
        b=wfxSz29MKOxyL7EuY39oDIVaQFuceCfvPu5lomN2ngF4FXie1AshvPROab2HGSPUWT
         dKyaoHZ1wqXR6vYuYnzTYsQr48wkWUnvpWs780Yd5fwz1IHTWaYJYYmWkZEFHj8kVz4q
         R65AoYEAG5q7/KEC4WYdJGh/GoBo9HFrnlhc/bIYAGy79PYBGodFWMxdr6KeL+VTdnhx
         S+hCGihw2bBu7uR0f3D8oedpYFw1zDCJVOHESiHXgnCEg6gna7AtIblgC1GfGaayHSCX
         uRXvru1waxyYE6M/zKNjVip3IpwyYDrqqjcLoIXguSG4L7dN2xt9oWRzm/rIEDBcWhVn
         tbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk/EL80KcjqJrloTmyoBiFiMdLsd6BIOtjPb/S0SRM0JIng2JSTjqEZmHonNLi/6kcbJRunBLZQnbGwYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwexW3KrFm0Hfob+xZCcV5/3JbbXwNc/Q660Z3fF0AhS4cr1YHL
	VnpbFQr8YgQSZm3QocLFq+Ew1kMw2iAcf5Z8K8EdWAiTxB6zdlXvkqeQXeSvNYc=
X-Gm-Gg: ASbGncsOBtlPXZ9UA9b8ns6GTEGdqM3yltQRILpVdW2FN4MMxukpga+taBp9MyVt+K1
	pHy21cx8Nk2g5KjPgwQeLaPlqyMKHHuLjTUA54mdT4UinyBRv+WUT2MiR4e39M5cVr9B/QCK09d
	9/k3h/GDRKAXlnrlZhM10sySro1M5zuP8azGMNUQ6Ym7dAKLrHpcaO3Gwp+StMFxsqYumJIB3VC
	q1N5FzRQ94EH0o2b1qQR5O1s7Mjh31MKQ5lph6Pd73UFVDdDoJhjp3F6RFvZ4mcBkJOmJYrLNtP
	VUFG30k0ZI4Wi1y7ujNPcCpAR2YyrxUPAqNbjg==
X-Google-Smtp-Source: AGHT+IHm7++UNqdBg3vPTO6BkdFxFWkmL9pUr6s+bIqZbUxLLtHl3aNQD6l/pvdhcBzz+HJg2ZYzPA==
X-Received: by 2002:a17:907:1c21:b0:ab7:faca:a323 with SMTP id a640c23a62f3a-abb70d677c5mr829487166b.39.1739765442288;
        Sun, 16 Feb 2025 20:10:42 -0800 (PST)
Received: from localhost.localdomain ([154.91.3.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb91e9d96bsm209201266b.122.2025.02.16.20.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 20:10:41 -0800 (PST)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: Chunjie Zhu <chunjie.zhu@cloud.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fix gfs2 umount timeout bug
Date: Mon, 17 Feb 2025 04:09:27 +0000
Message-Id: <20250217040928.34561-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  If there are heavy lock contenions between nodes in a cluster, at
  fs umount time,

          node 1                           node 2
            |                                |
	    |                                |
     iopen glock lock    -->       iopen glock go_callback
            |                                |
	    |                                |
         EAGAIN                       try evict failure
	    |                                |
	    |                                |
       DLM_ECANCEL                           |
            |                                |
	    |                                |
      glock complete                         |
            |                                |
	    |                                |
    umount(clear_glock)                      |
            |                                |
	    |                                |
 cannot free iopen glock                     |
            |                                |
	    |                                |
    umount timeout (*)                       |
            |                                |
	    |                                |
      umount complete                        |
                                             |
                                             |
				       umount succeed

Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
---
 fs/gfs2/glock.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4a280be229a6..bf2445f0afa9 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2120,6 +2120,23 @@ static void thaw_glock(struct gfs2_glock *gl)
 	gfs2_glock_queue_work(gl, 0);
 }
 
+/**
+ * IOPEN glock might be a zombie glock instance due to lock contention
+ * between nodes in the cluster during fs umount, then it causes umount
+ * timeout
+ */
+
+static int is_zombie_glock(struct gfs2_glock *gl)
+{
+	if (test_bit(GLF_LOCK, &gl->gl_flags) &&
+		test_bit(GLF_DEMOTE, &gl->gl_flags) &&
+		test_bit(GLF_BLOCKING, &gl->gl_flags) &&
+		(gl->gl_name.ln_type == LM_TYPE_IOPEN) &&
+		list_empty(&gl->gl_holders))
+		return 1;
+	return 0;
+}
+
 /**
  * clear_glock - look at a glock and see if we can free it from glock cache
  * @gl: the glock to look at
@@ -2132,7 +2149,8 @@ static void clear_glock(struct gfs2_glock *gl)
 
 	spin_lock(&gl->gl_lockref.lock);
 	if (!__lockref_is_dead(&gl->gl_lockref)) {
-		gl->gl_lockref.count++;
+		if (!is_zombie_glock(gl))
+			gl->gl_lockref.count++;
 		if (gl->gl_state != LM_ST_UNLOCKED)
 			handle_callback(gl, LM_ST_UNLOCKED, 0, false);
 		__gfs2_glock_queue_work(gl, 0);
-- 
2.34.1


