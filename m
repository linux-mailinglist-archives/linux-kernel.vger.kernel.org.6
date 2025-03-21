Return-Path: <linux-kernel+bounces-571918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01733A6C450
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7DF3BC9A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C05E230273;
	Fri, 21 Mar 2025 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SvnPMNI9"
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D41D5AD4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589382; cv=none; b=e0tHatOlW4b6pgccu6w1wR6GFyjad/UP8HjAkfgK6akYmisFGy7fIB9ruA0ScI8jpashyoeoH4pB3hrDOND8/rPACqtrpK7s+9Y97H3BSsNTRSewlTaaO9D+NvmfXUuuK9gfDD/4DlNT5jV9pgBGq9Xu9Hsyv490KAEpvsi/+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589382; c=relaxed/simple;
	bh=yKL7IczPQuQF3SWeOBm0zCzXPd1dogWlb0noBZzcEIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWEqlQM3bOLc/eeaLGAsp8a+PkB6w6/9V/ableuWkWrfIyuhIEcYi0v64D2Hv5+L1zx596RJtgm5dZKPB/qcSt5zABqsocAKxMoj3O28kSFjeiatJeScwfVARmiZHpbrVx7RVkubtgGxwEvqvZUzqvFzLjCT6E98QLYuAHSpce0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SvnPMNI9; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-85da20b2640so8287039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742589380; x=1743194180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqACgqSPAGulvpdL72lXsG7CJBHtcdgDXf09Xg+OLKQ=;
        b=SvnPMNI9Epp1iaYHXAlblHY6Fe12hqndSRgL3OXPf4urDAsr4fNm9QfSm3HL+vaE2N
         v2I+HVALn4cBr0c0k07w7XJQ8vhWLWSQD0KkyLiFOH50nMdshQ7PaZ2dHGYf412mc6py
         T4Kiq9Fsm8cD4DVz0R1CwRVBTZNTdGWEkhr1AB3dl6llADs+r7yO60RrcrHrRw3b+U8Y
         okS24QebzM+/NwMSXLJAr5YlEK+0l1Ouqroi78Z78LaVMHqRz5vY/1RElM/WTFg3m4S6
         IFmJSDVqSV9VZ/xzPvrOIX9loWrdl46UexpjnaH1GFdIryqkfRVbb1l3JhkVg5eU6Q9z
         c9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589380; x=1743194180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqACgqSPAGulvpdL72lXsG7CJBHtcdgDXf09Xg+OLKQ=;
        b=UWQPjv4qgqAhsa97gpQ+GT/O8iQSWy6PHHkqwcaE2kAStEzG1o85Gem921rbCp23aA
         CLWV90ISBBhRCwEyaGMD8Hy7b45sAugrtwHyRlOQrnBvRTSeR9hp7ZAqn9YWX8O5ACYN
         1C1I05rhA8z/CLDKxSuc2QU9wb3XvasbCf0egAT8kL/ONUvDNeJez2cBkKAoXNN+CePd
         giiCzFv997D+OpDy2+34hNyOkF3s8cKpo7FZlf3DcPQjxCffQ+Ml3dJ2p/xcnhBxnW2c
         iJ7Q6RfaVUZF6Lq5MYF6nIK/2+/CPra6qPLwMM4H4/AxRYd3VDMjUvaKERhKxM3HPasy
         S1rw==
X-Forwarded-Encrypted: i=1; AJvYcCVkiIbV/jXx+ei5ikQ/e76t3OW6Or2weN/sSyhoaGhCjOudS38XrGdV+L+LyCq65UwrNdWpQjdG8EyHCak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWP6rjVd4MJNFWfJD8h4ZTf2ArGHvdJi2dLX4qB0kj3hiZqNcd
	hC1hCi0/Ms85mM0IOFsNr5jQrfORBlpTiDFcJI4lVJD5szqXoLraJbdMo8ueAvgId7u17bo6VqS
	Hlxe5g8ROtCPqFKryP0vD0MP79dZYY9fe
X-Gm-Gg: ASbGncvQ4fgjHKwtngUS7plCtO1FlB9+c/25JlmYxKSDj6m5VbIDq21OZMC3Z8fHUU/
	30j0d4xW3qzPm50BP4+DdLRDbspXaAMl7NB78A1OpI3OZxdNmyUe3SqAeS2ExgeW20soRjkHb2x
	aTHQAvng0ho6o60zcYTb8u7oUzvAYUf+N8E6y26yEplZhv63aTlIHdNPZIS2SLcSHgpHLT6nkJ9
	Bkt2wKa7UHQmDGK4BvKqpbHyOCUwg6escVxQWTAAJOkkmlrXtOBD7nJPZMSqpl7EXxjoC7pezoI
	/x7y2Ux5tlMkeuM4SY02UYcEITW+Ti883vCN+LM5oOKDpzRO
X-Google-Smtp-Source: AGHT+IFz/L/baFi88SI/B6AQo8HEeKlP34YeQ9tNfbIyl5YFOUJhPLitDbGUFcuADfHCVr0v83V3ri7ENB17
X-Received: by 2002:a05:6602:2351:b0:85e:26b0:e7ac with SMTP id ca18e2360f4ac-85e2cc60442mr113217139f.3.1742589379924;
        Fri, 21 Mar 2025 13:36:19 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-85e2bb0a13csm9932339f.0.2025.03.21.13.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:36:19 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C12AA3402DC;
	Fri, 21 Mar 2025 14:36:18 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BCA23E4195E; Fri, 21 Mar 2025 14:36:18 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/3] nvme/ioctl: don't call blk_mq_free_request() in nvme_map_user_request()
Date: Fri, 21 Mar 2025 14:36:03 -0600
Message-ID: <20250321203604.3911446-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250321203604.3911446-1-csander@purestorage.com>
References: <20250321203604.3911446-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The callers of nvme_map_user_request() (nvme_submit_user_cmd() and
nvme_uring_cmd_io()) allocate the request, so have them free it if
nvme_map_user_request() fails.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6c27d72e8cee..843371e6e1e2 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -126,40 +126,38 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	int ret;
 
 	if (!nvme_ctrl_sgl_supported(ctrl))
 		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
 	if (has_metadata) {
-		if (!supports_metadata) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!supports_metadata)
+			return -EINVAL;
+
 		if (!nvme_ctrl_meta_sgl_supported(ctrl))
 			dev_warn_once(ctrl->device,
 				      "using unchecked metadata buffer\n");
 	}
 
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (flags & NVME_IOCTL_VEC) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (flags & NVME_IOCTL_VEC)
+			return -EINVAL;
+
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd);
 		if (ret < 0)
-			goto out;
+			return ret;
 		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
 	} else {
 		ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
 				bufflen, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
 				0, rq_data_dir(req));
 	}
 
 	if (ret)
-		goto out;
+		return ret;
 
 	bio = req->bio;
 	if (bdev)
 		bio_set_dev(bio, bdev);
 
@@ -172,12 +170,10 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	return ret;
 
 out_unmap:
 	if (bio)
 		blk_rq_unmap_user(bio);
-out:
-	blk_mq_free_request(req);
 	return ret;
 }
 
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, u64 ubuffer, unsigned bufflen,
@@ -198,11 +194,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
 				meta_len, NULL, flags);
 		if (ret)
-			return ret;
+			goto out_free_req;
 	}
 
 	bio = req->bio;
 	ctrl = nvme_req(req)->ctrl;
 
@@ -210,15 +206,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	ret = nvme_execute_rq(req, false);
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
 	if (bio)
 		blk_rq_unmap_user(bio);
-	blk_mq_free_request(req);
 
 	if (effects)
 		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
+out_free_req:
+	blk_mq_free_request(req);
 	return ret;
 }
 
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
@@ -518,20 +515,24 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (d.addr && d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, ioucmd, vec);
 		if (ret)
-			return ret;
+			goto out_free_req;
 	}
 
 	/* to free bio on completion, as req->bio will be null at that time */
 	pdu->bio = req->bio;
 	pdu->req = req;
 	req->end_io_data = ioucmd;
 	req->end_io = nvme_uring_cmd_end_io;
 	blk_execute_rq_nowait(req, false);
 	return -EIOCBQUEUED;
+
+out_free_req:
+	blk_mq_free_request(req);
+	return ret;
 }
 
 static bool is_ctrl_ioctl(unsigned int cmd)
 {
 	if (cmd == NVME_IOCTL_ADMIN_CMD || cmd == NVME_IOCTL_ADMIN64_CMD)
-- 
2.45.2


