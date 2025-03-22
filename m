Return-Path: <linux-kernel+bounces-572633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525B0A6CC64
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 21:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E61D7AADB0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3162356D9;
	Sat, 22 Mar 2025 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="eHtxYJps"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A8224236
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742675783; cv=none; b=NVwsh/4hxkO+KJvMga5uxDW1hUc0Ll6iH8OnicsS0dDC2aZwUMNKtkhKgoOJqk5gvtp73AMslw4p8lTe3pM6ZrLpV9YUUnAg7pupcYDmEoSW2CEaEnh1Vw9ZHLZLrR5bh7OrArLjpHB6p3S6J0h8ksnggRoYYqp0s/x4uZggLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742675783; c=relaxed/simple;
	bh=i6xeSXKUD7T3dNvSuBVDs/MYVZ+onNQyMhRjHKGsRNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHy0/W7/ndUb4U3ERZIDfywmonnLfe+O83AiSgTWI0aaVjekWyLXU8vv1l2mpeRpcwXvFjulxhrmm1zdpWarFghruqiKXwgC8SvYE27HcDb+cV4zD8s8a7yu71mTk3dyNINtMoz57oc//gOjSyD9DBZHBv2kvf57Nwc/IClJlDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=eHtxYJps; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3018e2d042bso3864861a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742675781; x=1743280581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtu2ODMuJN1daFcUihlu1rzkpuFzY3nQ3BRzwub0CsU=;
        b=eHtxYJpsDA09nLlviHfRr451dQTZ77wxCpn1+pb3kMF0RMTIrRr1iFYPNkPylWLWsN
         CzO396L6SPHq/vaoEpd+BS9GjZMcIbnhDIe459RP6Vflqj4KAHYmwDUlaB/4fi8PhTV9
         kcYw5mXIW8+bRnQAdoFfU2yzTN06Ysi0v/Dzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742675781; x=1743280581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtu2ODMuJN1daFcUihlu1rzkpuFzY3nQ3BRzwub0CsU=;
        b=SwllAb2bq4ROzFuvEzXiPx95/3GJXbzZySfGYouHlJDpwYmo39nvzuVv4D1VFL8XbU
         xZz/yxLNN8aTHlfs8Pq0rtZy2LUKQEN2Kz605lXhY2SgGdMQT+RhqZNCVm6Ui887sihm
         U2nzkbPbyp02Y30VmumDIIuJQ8Yhl9pKksyQdk6HYU87v25mP/aVr653yo4aeT6GtCns
         fhPi9g+eOQHA502X5JaTO5H/V0gm0nhZa1rmO/MaFqNoe/pFx8cAl2R2agmoMjPAwOgW
         u8zkJToskjp0QUK+OgpFhRg9z7BmRQkEpB1x5SPE66q1aE6bPQLKisrwx3TgOhf5eIb6
         JC2A==
X-Forwarded-Encrypted: i=1; AJvYcCVVa0ecyKGBRN+HmkcK1H5Bp9zWkK4GcmGTEtoiesKo8QRdz9tu7r3KD6deV12VaDUn8rbdfh2RjD9mEgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUpeWQJu2OhRupo4qS2ZHouph+6M9Enr/MhU8VHV6+okIxVU4
	x7Ylbv+6CXbg0qX4sDj+56pMMmepEOIAs+No3k8mNLn8QBasugKDlUF65QywrDM=
X-Gm-Gg: ASbGncvgkah5N56HREzJle8yVc+qFtgcWY7+NfU3yMBYa+FGyx5ccQnZJhgeIcXF6r+
	KqNZ6dwiOnMgXHuJR0hDJGr2f7h1VR5mdNbuJ4UVbzuL0TakUMu+4keqeQPZY9QjelDIezQPTiO
	s1RQS4QVv98ZymCL2VWxU8RwwAKIbwXow+pKDev+e36Py7vTfxp1awjMFNv3j4dWU084s3sPt+t
	/qjKqurXJUzaxH49akJBTTEgmpaWIFMxuAOs1rhMURx0HuSeIxKrV6udKkRR3FmJUQSuwU4tfEm
	VvU5ShiLu122YJL5mYPMEbkMfiwr6JonM/8sBrxM5VAYh2YVe+b3
X-Google-Smtp-Source: AGHT+IESi0AKU2RsgzC9hdeNWUniwi/w2iinEQxLs5wBA3sRrJswAKj8kq5JE5jmf3oyEm3CD4afpw==
X-Received: by 2002:a17:90b:4fc6:b0:2fe:8a84:e033 with SMTP id 98e67ed59e1d1-3030fe6a292mr11636714a91.2.1742675781177;
        Sat, 22 Mar 2025 13:36:21 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a579sm8711798a91.32.2025.03.22.13.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 13:36:20 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	brauner@kernel.org,
	asml.silence@gmail.com,
	hch@infradead.org,
	axboe@kernel.dk,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH vfs/for-next 1/3] pipe: Move pipe wakeup helpers out of splice
Date: Sat, 22 Mar 2025 20:35:44 +0000
Message-ID: <20250322203558.206411-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250322203558.206411-1-jdamato@fastly.com>
References: <20250322203558.206411-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Splice code has helpers to wakeup pipe readers and writers. Move these
helpers out of splice, rename them from "wakeup_pipe_*" to
"pipe_wakeup_*" and update call sites in splice.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/pipe.c                 | 16 ++++++++++++++++
 fs/splice.c               | 34 +++++++++-------------------------
 include/linux/pipe_fs_i.h |  4 ++++
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 12b22c2723b7..1f496896184b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1070,6 +1070,22 @@ void pipe_wait_writable(struct pipe_inode_info *pipe)
 	pipe_lock(pipe);
 }
 
+void pipe_wakeup_readers(struct pipe_inode_info *pipe)
+{
+	smp_mb();
+	if (waitqueue_active(&pipe->rd_wait))
+		wake_up_interruptible(&pipe->rd_wait);
+	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
+}
+
+void pipe_wakeup_writers(struct pipe_inode_info *pipe)
+{
+	smp_mb();
+	if (waitqueue_active(&pipe->wr_wait))
+		wake_up_interruptible(&pipe->wr_wait);
+	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
+}
+
 /*
  * This depends on both the wait (here) and the wakeup (wake_up_partner)
  * holding the pipe lock, so "*cnt" is stable and we know a wakeup cannot
diff --git a/fs/splice.c b/fs/splice.c
index 2898fa1e9e63..dcd594a8fc06 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -175,14 +175,6 @@ static const struct pipe_buf_operations user_page_pipe_buf_ops = {
 	.get		= generic_pipe_buf_get,
 };
 
-static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
-{
-	smp_mb();
-	if (waitqueue_active(&pipe->rd_wait))
-		wake_up_interruptible(&pipe->rd_wait);
-	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
-}
-
 /**
  * splice_to_pipe - fill passed data into a pipe
  * @pipe:	pipe to fill
@@ -414,14 +406,6 @@ const struct pipe_buf_operations nosteal_pipe_buf_ops = {
 };
 EXPORT_SYMBOL(nosteal_pipe_buf_ops);
 
-static void wakeup_pipe_writers(struct pipe_inode_info *pipe)
-{
-	smp_mb();
-	if (waitqueue_active(&pipe->wr_wait))
-		wake_up_interruptible(&pipe->wr_wait);
-	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
-}
-
 /**
  * splice_from_pipe_feed - feed available data from a pipe to a file
  * @pipe:	pipe to splice from
@@ -541,7 +525,7 @@ static int splice_from_pipe_next(struct pipe_inode_info *pipe, struct splice_des
 			return -ERESTARTSYS;
 
 		if (sd->need_wakeup) {
-			wakeup_pipe_writers(pipe);
+			pipe_wakeup_writers(pipe);
 			sd->need_wakeup = false;
 		}
 
@@ -582,7 +566,7 @@ static void splice_from_pipe_begin(struct splice_desc *sd)
 static void splice_from_pipe_end(struct pipe_inode_info *pipe, struct splice_desc *sd)
 {
 	if (sd->need_wakeup)
-		wakeup_pipe_writers(pipe);
+		pipe_wakeup_writers(pipe);
 }
 
 /**
@@ -837,7 +821,7 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 				goto out;
 
 			if (need_wakeup) {
-				wakeup_pipe_writers(pipe);
+				pipe_wakeup_writers(pipe);
 				need_wakeup = false;
 			}
 
@@ -917,7 +901,7 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 out:
 	pipe_unlock(pipe);
 	if (need_wakeup)
-		wakeup_pipe_writers(pipe);
+		pipe_wakeup_writers(pipe);
 	return spliced ?: ret;
 }
 #endif
@@ -1295,7 +1279,7 @@ ssize_t splice_file_to_pipe(struct file *in,
 		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
 	if (ret > 0)
-		wakeup_pipe_readers(opipe);
+		pipe_wakeup_readers(opipe);
 	return ret;
 }
 
@@ -1558,7 +1542,7 @@ static ssize_t vmsplice_to_pipe(struct file *file, struct iov_iter *iter,
 		ret = iter_to_pipe(iter, pipe, buf_flag);
 	pipe_unlock(pipe);
 	if (ret > 0) {
-		wakeup_pipe_readers(pipe);
+		pipe_wakeup_readers(pipe);
 		fsnotify_modify(file);
 	}
 	return ret;
@@ -1844,10 +1828,10 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 	 * If we put data in the output pipe, wakeup any potential readers.
 	 */
 	if (ret > 0)
-		wakeup_pipe_readers(opipe);
+		pipe_wakeup_readers(opipe);
 
 	if (input_wakeup)
-		wakeup_pipe_writers(ipipe);
+		pipe_wakeup_writers(ipipe);
 
 	return ret;
 }
@@ -1935,7 +1919,7 @@ static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 	 * If we put data in the output pipe, wakeup any potential readers.
 	 */
 	if (ret > 0)
-		wakeup_pipe_readers(opipe);
+		pipe_wakeup_readers(opipe);
 
 	return ret;
 }
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 8ff23bf5a819..de850ef085cb 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -267,6 +267,10 @@ void pipe_double_lock(struct pipe_inode_info *, struct pipe_inode_info *);
 void pipe_wait_readable(struct pipe_inode_info *);
 void pipe_wait_writable(struct pipe_inode_info *);
 
+/* Wake up pipe readers/writers */
+void pipe_wakeup_readers(struct pipe_inode_info *pipe);
+void pipe_wakeup_writers(struct pipe_inode_info *pipe);
+
 struct pipe_inode_info *alloc_pipe_info(void);
 void free_pipe_info(struct pipe_inode_info *);
 
-- 
2.43.0


