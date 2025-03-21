Return-Path: <linux-kernel+bounces-571818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1230EA6C2C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12E11889B90
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D0C22B8B1;
	Fri, 21 Mar 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SIbmHa7A"
Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389A182D7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742582925; cv=none; b=m1dltqAY6DYHruk1DtOqGQXGTI03VfhhhjUDmCPFPtt+fgClmO0eRtOL1mV+kpFZNpx5x18vjcMRuQVOhmGXDkOxKwT3Oqc3r0Iv7jYmtyjUdiTRZLLhWe8gJJMYY6AolvbavVlH1PMMVHDS4BLuAaJrAQVa1+BNzGy6+5cR6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742582925; c=relaxed/simple;
	bh=A3iW60qspZ7EVkOlE+MyGo4VhzreaaD9dkKM9cX8B4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBsHnZANPW4cAXNMVshmyzs0SfOND2qBeFY4AcvU7RFwZrCMXTwRoYUSaG2yCcHVzF3MRFH8/Dvq8YTAMyEAqqPGtXaMQb51Ck9/5Qp28B6ZjWsOqNaFsLRMCrkkn1eo1YeWZzmUK2i3dLAO/3cyeduQ1OWlz3YgWexIYOMU6JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SIbmHa7A; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-4769a9055e6so929971cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742582923; x=1743187723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfjEq8IyL7/x/8c9RdusJ/wqPO/dcQUh+COX5jmkRnk=;
        b=SIbmHa7APd7hcKIWqHVLzoPIwyvDWshKAp3PKTEv0zhgdTJ7iU1EpKGtOOcQVXThtf
         XhPrwFNo7jhqiQz6q20HkTkbMYE/2rr3XFy53fEZQrcERpuAyy4f3imOaTFCafMj5g/u
         AJBPSvbtFDk7bgAP3e4QdNfPL47iTjfVgL0Z/VZOO3oliN/jMHXB9HdOrN6qCtBYu6Gh
         opE9enTNkY00+iNl8roJhyuU5c+C0fATi1O4c+JfMVvMQMDEb6572tCngyLm5QN+sw+T
         4PEUJ6LDbBa2ZIogNeHiEWs1GUnsDHISfBGE9tPrfHWSsVIO0PplioqUstYKNmn3U9fq
         ExMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742582923; x=1743187723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfjEq8IyL7/x/8c9RdusJ/wqPO/dcQUh+COX5jmkRnk=;
        b=QmBhv6owehfl1/cgLNtTP5XYh3qM6a11sDY5tPFig1lC4k9vv55X42zLhhl0ZNPWZr
         JPXv6WtoX8a97YOjUlwcdBRx2hqyft3awOjkEpTxP7aPkLOPhCJVZNRhGE+AscHm5mvk
         pGS5YDjf4T6KRFTpJQRik17ty7N7utTmtZeZ3rXnlHPfA66mTb3a7hlQHHcB5S7QRBpf
         todLZeR9Us6F5gOMuC9/xszMtqH4FzITNwF1gZ2knhspykF2XNxxbsi0i7BrlGnvRCUa
         vse1byhdH6Tqf4unsp46Zifvz+FQJsI0NYj3pZtizzLibJnBgPA2rFGjl6szU14PPJQt
         rBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/uKu8H5eLXwKfkRt2MFbXC9Z07zBOe+h001fWE3iFmUuH0rIxUVlQk644zvgEHJHz56GPa+HixoMko3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDImgBaTGJWyAyjQSO8f9BoJGbxY4TN3eMCMA7MrtEE0TUQN5K
	pKFEXofFWhGQ34IGbCOw6q/zg/8nSSMTrSgJsi9bwJBCrnl8UiKrCXSaZ4e//aLmNcXJT2SJ2J5
	4EB+uU5wKAH30QVI5fAgk+thlmg9F0WzK
X-Gm-Gg: ASbGncsHHcphW3LLqweVdEp74fdzqD+zKDqZ/E0Y4mzsiaS8bxQ9iCRC3iij3C5IRy+
	rl+AsxJsdlb1N6hRSgmLh+wC8MDzJPsv4yL5gf67lPjgSDAjnf9JKwRgfxNaTkYFKTe7PuSh4af
	qKbjOGjwdBszPfDGf45jZhPBjT702906hWsRsv+jst7nNoXFpNDabJETAAKv1FfL3rQZDxzLjlN
	gczD/GTwuwMLOSyPHo4lstrUJnmY4c/M3nIOFRPvkUJzjCW1ScfN+I0jCLiAgN7VBnpi0nE5Lh3
	fSpYpZ1MkMPXlmiUlMGD1DwN+e7FxGGM2c2sqUUWDUU50Sg4
X-Google-Smtp-Source: AGHT+IGmTdCvB1188jBMmyDMG3MYl9833lk8K/s6kZSo8qwO5x/RMDQKhQyV5LroO0Dqzra7vD1ZM+pBTfVD
X-Received: by 2002:ad4:5c8c:0:b0:6d8:e6be:50fc with SMTP id 6a1803df08f44-6eb3f2ec191mr22803036d6.6.1742582922650;
        Fri, 21 Mar 2025 11:48:42 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6eb3efaa3a3sm1211626d6.35.2025.03.21.11.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:48:42 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 66D26340245;
	Fri, 21 Mar 2025 12:48:41 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 628F1E4195E; Fri, 21 Mar 2025 12:48:41 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/3] io_uring/uring_cmd: import fixed buffer before going async
Date: Fri, 21 Mar 2025 12:48:19 -0600
Message-ID: <20250321184819.3847386-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321184819.3847386-1-csander@purestorage.com>
References: <20250321184819.3847386-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For uring_cmd operations with fixed buffers, the fixed buffer lookup
happens in io_uring_cmd_import_fixed(), called from the ->uring_cmd()
implementation. A ->uring_cmd() implementation could return -EAGAIN on
the initial issue for any reason before io_uring_cmd_import_fixed().
For example, nvme_uring_cmd_io() calls nvme_alloc_user_request() first,
which can return -EAGAIN if all tags in the tag set are in use.
This ordering difference is observable when using
UBLK_U_IO_{,UN}REGISTER_IO_BUF SQEs to modify the fixed buffer table.
If the uring_cmd is followed by a UBLK_U_IO_UNREGISTER_IO_BUF operation
that unregisters the fixed buffer, the uring_cmd going async will cause
the fixed buffer lookup to fail because it happens after the unregister.

Move the fixed buffer lookup out of io_uring_cmd_import_fixed() and
instead perform it in io_uring_cmd() before calling ->uring_cmd().
io_uring_cmd_import_fixed() now only initializes an iov_iter from the
existing fixed buffer node. This division of responsibilities makes
sense as the fixed buffer lookup is an io_uring implementation detail
and independent of the ->uring_cmd() implementation. It also cuts down
on the need to pass around the io_uring issue_flags.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 27cb27b6d5ea ("io_uring: add support for kernel registered bvecs")
---
 drivers/nvme/host/ioctl.c    | 10 ++++------
 include/linux/io_uring/cmd.h |  6 ++----
 io_uring/rsrc.c              |  6 ++++++
 io_uring/rsrc.h              |  2 ++
 io_uring/uring_cmd.c         | 10 +++++++---
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index fe9fb80c6a14..3fad74563b9e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -112,12 +112,11 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	return req;
 }
 
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		struct io_uring_cmd *ioucmd, unsigned int flags,
-		unsigned int iou_issue_flags)
+		struct io_uring_cmd *ioucmd, unsigned int flags)
 {
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
@@ -141,12 +140,11 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 
 		/* fixedbufs is only for non-vectored io */
 		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC))
 			return -EINVAL;
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
-				rq_data_dir(req), &iter, ioucmd,
-				iou_issue_flags);
+				rq_data_dir(req), &iter, ioucmd);
 		if (ret < 0)
 			goto out;
 		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
 	} else {
 		ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
@@ -194,11 +192,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		return PTR_ERR(req);
 
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
-				meta_len, NULL, flags, 0);
+				meta_len, NULL, flags);
 		if (ret)
 			return ret;
 	}
 
 	bio = req->bio;
@@ -514,11 +512,11 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
 	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
-			d.metadata_len, ioucmd, vec, issue_flags);
+			d.metadata_len, ioucmd, vec);
 		if (ret)
 			return ret;
 	}
 
 	/* to free bio on completion, as req->bio will be null at that time */
diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 598cacda4aa3..ea243bfab2a8 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -39,12 +39,11 @@ static inline void io_uring_cmd_private_sz_check(size_t cmd_sz)
 )
 
 #if defined(CONFIG_IO_URING)
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
-			      struct io_uring_cmd *ioucmd,
-			      unsigned int issue_flags);
+			      struct io_uring_cmd *ioucmd);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
  *
@@ -69,12 +68,11 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
 
 #else
 static inline int
 io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
-			  struct iov_iter *iter, struct io_uring_cmd *ioucmd,
-			  unsigned int issue_flags)
+			  struct iov_iter *iter, struct io_uring_cmd *ioucmd)
 {
 	return -EOPNOTSUPP;
 }
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		u64 ret2, unsigned issue_flags)
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 5fff6ba2b7c0..ad0dfe51acb1 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1099,10 +1099,16 @@ int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 	if (!node)
 		return -EFAULT;
 	return io_import_fixed(ddir, iter, node->buf, buf_addr, len);
 }
 
+int io_import_buf_node(struct io_kiocb *req, struct iov_iter *iter,
+			u64 buf_addr, size_t len, int ddir)
+{
+	return io_import_fixed(ddir, iter, req->buf_node->buf, buf_addr, len);
+}
+
 /* Lock two rings at once. The rings must be different! */
 static void lock_two_rings(struct io_ring_ctx *ctx1, struct io_ring_ctx *ctx2)
 {
 	if (ctx1 > ctx2)
 		swap(ctx1, ctx2);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index f10a1252b3e9..bc0f8f0a2054 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -59,10 +59,12 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
 int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
 			unsigned issue_flags);
+int io_import_buf_node(struct io_kiocb *req, struct iov_iter *iter,
+			u64 buf_addr, size_t len, int ddir);
 
 int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg);
 int io_sqe_buffers_unregister(struct io_ring_ctx *ctx);
 int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			    unsigned int nr_args, u64 __user *tags);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index de39b602aa82..15a76fe48fe5 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -232,10 +232,15 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 			return -EOPNOTSUPP;
 		issue_flags |= IO_URING_F_IOPOLL;
 		req->iopoll_completed = 0;
 	}
 
+	if (ioucmd->flags & IORING_URING_CMD_FIXED) {
+		if (!io_find_buf_node(req, issue_flags))
+			return -EFAULT;
+	}
+
 	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
 	if (ret == -EAGAIN || ret == -EIOCBQUEUED)
 		return ret;
 	if (ret < 0)
 		req_set_fail(req);
@@ -244,16 +249,15 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 	return IOU_OK;
 }
 
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct iov_iter *iter,
-			      struct io_uring_cmd *ioucmd,
-			      unsigned int issue_flags)
+			      struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
-	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
+	return io_import_buf_node(req, iter, ubuf, len, rw);
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
-- 
2.45.2


