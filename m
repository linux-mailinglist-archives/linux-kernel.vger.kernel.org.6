Return-Path: <linux-kernel+bounces-223211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDB8910FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2658283B96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737821B47D5;
	Thu, 20 Jun 2024 17:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bw43jsS4"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633EE1BBBE1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906241; cv=none; b=TjrkgHOZ2ak7rOfN3LitM6u8lAj1rgv+2SR62EnD3XSPhFI7Q0xGOWg7b1TwW3TbOkazpVBnrloWYgBJG05Le4mc0LHaqyp+iDStPTb3GH8qQJnSK5PsWDJ4pYtQ5NA2rLLU5rVv41UpkrE2aPC13TzAW4tGBCv7RcEPH9Mvqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906241; c=relaxed/simple;
	bh=zlWE/BHnOM5LDq/uDURZ2MNHZjunij/1siJW9ZOxI00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaSzK3D6QYiFWO/Q14L+kHlroo+4KDcNeYzWgSB2dEk80dQtR6Zomy9RaLTqpizIMTq5+xjmHj5h9gbce96b+tjYN06E1zO1hKckv34sQ+3uMz4sz4Ne2tgAbc5EPICkUBktQEqsQ4kX54IC9Vv5uuuFzw+iFiaZzFoTjkDu7Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bw43jsS4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7062bf6d9a1so952144b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906240; x=1719511040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lqobSglYEzexPVkHLogTghmlkNBAO5YaO0aqGu8OxQ=;
        b=Bw43jsS4io1Z+u8D9AH8uvq2GxzmZiaxSFF4tOTegVxOCBPYrSKFSIXPu4Pt5dykx+
         fYqqEFFHdcyy1VYiU3MUIyBQP2lhzTXChwhiRo+bZ5A+Qr6n3Xnkpy5CGC9lLJkWD1BG
         sVX2F8UI5jeWzirOsLFh9XNuY6+IsgTioWssrTUHyDY1ZdhAYLsT3C34mehP3UsuoxIS
         AYkoq9ALs7vfbRl6M/VrH/Q0mnsxPI0hgeU7Oe+VrmFvzuV2mA27nBJu1ODz3JNDZa4T
         Ky1+x41t9Blx7btkNRt+QM1icwGsUvEFjqDR+0vA/5dEgEgejirueNiJzblcc30NTNsH
         Nf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906240; x=1719511040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lqobSglYEzexPVkHLogTghmlkNBAO5YaO0aqGu8OxQ=;
        b=lgY/DtL5ByFTdUMRqanLSIVih3NUt9zkllxS+zeA/PTMSkdZpaAIs623szD76qyRq+
         ECoI4/prPDs+raFaNFlG7Tl2wtWAeJzjk3yhittaxAPHOtuqqFbK+7ZYSjkz7HOxRlZd
         QvNtBKTr+v9ThI00pbz208WjJX5CBi+bZn+5fuOb8fosv5iNOp4gj0YAmH3d63tmjNF2
         e8UhDZKI5x/uT0UKi4NxP8T/lUVCixKoPwNE5qx7H0R0Fj2E12VjunNlXlHFT6/Uume/
         EXB4rqgOXIdoahqVf+sSiRHMaRBGRElI6L0+kjpRp/lnAiJMVWTpbjMoBQUZF48li8QE
         WHgQ==
X-Gm-Message-State: AOJu0YwM9CfKphSgGh/hFAHmGNYs7xmmhOpSURUomt0HfsZOG61iPNFu
	8to33PeaxvDAw9Sy0hyqzWw8J1iCL2SFSXDoMX+m6LbZT+xtlOJh4vo2qDpVNM8=
X-Google-Smtp-Source: AGHT+IGJ118F6VC3AtyfokUQpT041EuGRx6X707mgLwtYJ0bL5vbzytScTF3N3LGUj1EU6oZpngWkw==
X-Received: by 2002:a05:6a00:2e02:b0:705:bc88:612a with SMTP id d2e1a72fcca58-70629d690d3mr7357777b3a.1.1718906239678;
        Thu, 20 Jun 2024 10:57:19 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb71e66sm13067589b3a.176.2024.06.20.10.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:19 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Siddh Raman Pant <code@siddh.me>,
	Dave Airlie <airlied@redhat.com>,
	David Disseldorp <ddiss@suse.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Nick Alcock <nick.alcock@oracle.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 04/40] watch_queue: optimize post_one_notification() by using find_and_clear_bit()
Date: Thu, 20 Jun 2024 10:56:27 -0700
Message-ID: <20240620175703.605111-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

post_one_notification() searches for a set bit in wqueue->notes_bitmap,
and after some housekeeping work clears it, firing a BUG() if someone
else cleared the bit in-between.

We can allocate the bit atomically with an atomic find_and_clear_bit(),
and remove the BUG() possibility entirely.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/watch_queue.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 03b90d7d2175..387ee88af71d 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) "watchq: " fmt
 #include <linux/module.h>
+#include <linux/find_atomic.h>
 #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -112,7 +113,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	if (pipe_full(head, tail, pipe->ring_size))
 		goto lost;
 
-	note = find_first_bit(wqueue->notes_bitmap, wqueue->nr_notes);
+	note = find_and_clear_bit(wqueue->notes_bitmap, wqueue->nr_notes);
 	if (note >= wqueue->nr_notes)
 		goto lost;
 
@@ -133,10 +134,6 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	buf->flags = PIPE_BUF_FLAG_WHOLE;
 	smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */
 
-	if (!test_and_clear_bit(note, wqueue->notes_bitmap)) {
-		spin_unlock_irq(&pipe->rd_wait.lock);
-		BUG();
-	}
 	wake_up_interruptible_sync_poll_locked(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	done = true;
 
-- 
2.43.0


