Return-Path: <linux-kernel+bounces-571965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B4CA6C4BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3809C7A72AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6C1233D8E;
	Fri, 21 Mar 2025 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Mso6vozK"
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352F6231A2D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590680; cv=none; b=M9X7/aytG7Si0hfN2dE503wwDtplEF5pdgZE7fTnLqg8DjP6i6o2k6G7wJnojuAsHuKBBt0U2BAXLr544UQ/IW1kKOiPNNLrYzggtcoGw8Uc+vL7y4CRBsLH5C7jy5aYPBbOVTjEhjEtiOGTt+FbynhE1wGajPm+Rm3AZ7N4F+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590680; c=relaxed/simple;
	bh=Bm7bJDmAmFwceMS0uipBzo2HfuoD8vWOeeOP+aFj1gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcbXhJmrS/R4RIMGCnAQzmCCUjIi5ZEcDiBNtJhtJUJP3x/1MQ3pl+hlqXKMvg0zdaf1JHeHG8bNGAyByLzmtU2WcqtLTELbolwukkAQw2Ynz+4SjWcDC+0qV/PxUjCTEyMexW9PqHLWlxjk446Yc3nh3GMn1uB/0d8dI0RXboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Mso6vozK; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-7c549d9ecc6so45416085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742590676; x=1743195476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAQa7curMMZokpp1idcLqQ2LV/40Bv1e439+xYRqV5Y=;
        b=Mso6vozKf+o72ewg9Wd5jdZ2a9eBr4RDr/35fEYzRmtKOmvXBYhnDDwfuq3sIIHzJi
         vxi6IyD9MajlhkV8QpQD5N/udF706dZUbPOjzFj1GSR+HN0h1Ty04ByTeVM1dHky5J/8
         4eE2spqZdRh9Nhv2ekGWoUOOinAxY1RMxg6hP6nhJ5rKqVpJlrk/v1kQPOC+ojHZFqAh
         RcWqn9/d3+V2nJLPAyk0DMl6JgdNT9FNSNJAMiNQ09ZPYcnvfuahcTzafMJVzB6SflLd
         YLxmcxZ3btqa67NmUsgx++HLtxX/2H/dRXojMQp4IRdjwrIXE1lKSMCfH7zvj+zQZ/nd
         pW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590676; x=1743195476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAQa7curMMZokpp1idcLqQ2LV/40Bv1e439+xYRqV5Y=;
        b=pCkPWl7LOD2I4xwLmz0BQ+RLJ2NHpm27XwJED52+GzBWD6q0qPBZjaNtlkW9/eG3Hn
         B2BvxYw7j4r/+OUYkwFmQpceKO+nHrz5h/bV1/jPBkZHbUgjRC9fwKPsQkb1b+VeqhSV
         hTZ4KeEKw/hQo5FI00U0brxjsESWrCb7eHSHsjRlbkoRJjLCCg7Ba/8Tp+Cv2b11QTtk
         bLd3S74Obn683XkRte78qU4P4KBxowE8O6kRCXm4rrvIWW438zK7JNfA3Fo6reBQpbI0
         4t1WVHe9B/jrKqhyXWn+cAyuxrS+mmnmuQu3GlDFoXjR4HH3YMTsIwqEkipkFG2YL2D5
         2JEw==
X-Forwarded-Encrypted: i=1; AJvYcCXIORxLCizp+rtRqfo5wD4e6EBTxjfMlWO1AN4nq+QfAvzBsQ9++O7z2jXzytYHLXTwHw3RqkmRqMXd4EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzedK2T/R2BVVzq5rZchES9q4Hzb65sMl8kNp6WMhzZcxhOW7/p
	QG9yHF8uCZSHISdHSNEB9ZUkG4Je2tGCnkwJHrvjPnrd/eMrdHz89rwfFGtu3OLm9+82qTYP9xP
	816Sf81j+ua88qhgqfKa5Urh0qO0k1BP7
X-Gm-Gg: ASbGncvqv5FghShGK1KAzpMfv/tbYqhu8mqDYIoITeKn+WX4VigJ1krtLTFNjl/1Wlq
	G0/P0UeS6SlQ5qgn+ecQY761Ymh7YCvWadoyWmr6ASomE0s8yikqUZFiHXvnku0/cdVHOTTqGFi
	EgB52cTfWjxJJqpR34oxik2a8XH0uWgZuExmTuoCxh1MONTQrFyf9LdiQgYQ+VZach/RIiTbGSv
	i2pNZl5hAfkiTHz0GZfsVPZTljvtDw+2PsdveMhglbINlRQCvLvshtDk1f/7eUjt2s4u4OoPXQG
	jlDfYfoK+7s3dW6E4i60l/Q0vAqouUws5o3RAKmRJ8IifEcn
X-Google-Smtp-Source: AGHT+IEoEcywwdrdpsNfxd22W+vQnKfycVeMvEhHj3rSWretVHw8fIWoxN23kfgkBMom47MHPGnXOf15e669
X-Received: by 2002:a05:620a:29c8:b0:7c5:6fee:1634 with SMTP id af79cd13be357-7c5ba12f397mr223670085a.3.1742590676104;
        Fri, 21 Mar 2025 13:57:56 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-7c5b931cf93sm13698785a.4.2025.03.21.13.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:57:56 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8F72C3400FE;
	Fri, 21 Mar 2025 14:57:54 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 867A8E4195E; Fri, 21 Mar 2025 14:57:24 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/3] nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()
Date: Fri, 21 Mar 2025 14:57:22 -0600
Message-ID: <20250321205722.3947901-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321205722.3947901-1-csander@purestorage.com>
References: <20250321205722.3947901-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_map_user_request() is called from both nvme_submit_user_cmd() and
nvme_uring_cmd_io(). But the ioucmd branch is only applicable to
nvme_uring_cmd_io(). Move it to nvme_uring_cmd_io() and just pass the
resulting iov_iter to nvme_map_user_request().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 42 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 843371e6e1e2..98489161e029 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -112,11 +112,11 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	return req;
 }
 
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		struct io_uring_cmd *ioucmd, unsigned int flags)
+		struct iov_iter *iter, unsigned int flags)
 {
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
 	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
@@ -134,27 +134,16 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		if (!nvme_ctrl_meta_sgl_supported(ctrl))
 			dev_warn_once(ctrl->device,
 				      "using unchecked metadata buffer\n");
 	}
 
-	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
-		struct iov_iter iter;
-
-		/* fixedbufs is only for non-vectored io */
-		if (flags & NVME_IOCTL_VEC)
-			return -EINVAL;
-
-		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
-				rq_data_dir(req), &iter, ioucmd);
-		if (ret < 0)
-			return ret;
-		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
-	} else {
+	if (iter)
+		ret = blk_rq_map_user_iov(q, req, NULL, iter, GFP_KERNEL);
+	else
 		ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
 				bufflen, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
 				0, rq_data_dir(req));
-	}
 
 	if (ret)
 		return ret;
 
 	bio = req->bio;
@@ -511,13 +500,30 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	req->timeout = d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
 
 	if (d.addr && d.data_len) {
-		ret = nvme_map_user_request(req, d.addr,
-			d.data_len, nvme_to_user_ptr(d.metadata),
-			d.metadata_len, ioucmd, vec);
+		struct iov_iter iter;
+		struct iov_iter *map_iter = NULL;
+
+		if (ioucmd->flags & IORING_URING_CMD_FIXED) {
+			/* fixedbufs is only for non-vectored io */
+			if (vec) {
+				ret = -EINVAL;
+				goto out_free_req;
+			}
+
+			ret = io_uring_cmd_import_fixed(d.addr, d.data_len,
+					rq_data_dir(req), &iter, ioucmd);
+			if (ret < 0)
+				goto out_free_req;
+
+			map_iter = &iter;
+		}
+		ret = nvme_map_user_request(req, d.addr, d.data_len,
+			nvme_to_user_ptr(d.metadata), d.metadata_len,
+			map_iter, vec);
 		if (ret)
 			goto out_free_req;
 	}
 
 	/* to free bio on completion, as req->bio will be null at that time */
-- 
2.45.2


