Return-Path: <linux-kernel+bounces-571921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FABEA6C454
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46248467AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B86230277;
	Fri, 21 Mar 2025 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UlSLiUgM"
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1D230BC1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589414; cv=none; b=Wo8Ly86PgwjUnYEGC7Wvhtf7mPXNliVJbr5gxZrsCezm6hztgBP61Iy4WOQMk1qbfzOi/7evgMqDmGJuXb6bQ2/mu2+Uo4yY9j+1sGr+pPxmaBxRH9LeNEBrjrdS/Dc+q/r5BJP5BssM5kWLJHEu8nCdkhRJc9IX6GvEEryaN38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589414; c=relaxed/simple;
	bh=rEO2xlrZInh/IDtnHXah1CxvwJNxm6y0050eewZE38E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTpI0014yQI9gQDHaAnGyRSCytYl0Vj2k/0AokaalouRifD4SYfA/KMAx1phP3t2Ta5/T4Taww2zUBnLXoYyTjtmQz2ZOWS2rd6vyFVPLSB7J+ybIFv0XtU3Km66B6/veKg8dtbLZGsFHCxM9p7IrUn9KlLjBlMi+Ki35FDscu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UlSLiUgM; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-223fd44daf8so7186845ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742589410; x=1743194210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQ14CF88ps+y9JKHzrmpWKepjjCRvlmio15JuiIfmyA=;
        b=UlSLiUgMpPEYN2ns3s0uIENtorHdj9ARZ1z5mvFdST6hKX9DNIzCduLS1w6x+w+hyX
         Nv9pSQc2X11WI+PHrQld7XyL7dUes4Quq65Pa3lwHJ5kuImRZAee929cPJXS6DKQvOHv
         RTREnN1eVOyHTqnobts/otzMKhvqshilad4dmIqvnusTEnO0Ofx58lcEOwv350F3I59y
         e3NTQzZlCAQM/ahUT9X6kW+Lzm+7X426T7t+BkCA2HKWT4N1eokgqqS3ZUMjqpLlUUfP
         r6YqbE2MY6STGOGPMkdhp5m1VTdlCSWUJWzfbT5JtiiTFoC4tbPib+j2z7serk1r3fL9
         idDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589410; x=1743194210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQ14CF88ps+y9JKHzrmpWKepjjCRvlmio15JuiIfmyA=;
        b=cqmi2rjIwm44FLWWCJPvssd1jvkHvNFHIwZpJzMvs9o4PpKiYBoRwRPJiqdbI2kuSj
         ZbDZHLPwdBc66Vh5//Gz/CT4pePweZXLNOLSB0AwynhriyAuf1Cf3SMTmTXZmceXve9b
         MVEkeE9B/DREg4gac74B1Gt2vIX/bLaECnHeqRBdZLplgD1TBCmUYCnwp9dKfLsJswmO
         Yjtk4WfX4BMcuMfLC+1Xb4ua9lFSbNHKGn8Q2RHUlHU5ph+3NTPsrrXtZJVZvcnXnG96
         iDyUrZ1oVg/zwqYYR6R0b5JUceNL5H7XaR4+ptaHVQadSVjkGB64zTMQGDMivDXy6gb1
         cw6g==
X-Forwarded-Encrypted: i=1; AJvYcCVIVikvKKN4/I9i7lukUErqTaeN9HuVhrTz/V1mMyEEUlmUurBNQM+F6/4mmE81rLg48VLhxCPZun2ovb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmhmWgbrR6VVb9dp8ftbCplmJd1m2xb6j27of0iIz4CXJn24I3
	iFNYXYT3zEcDIrGp73r1jZoqWef4lcvkrb2ZP4j6Iq2gVEGzrob8AyYzpMEe61KPiut9SBthqeD
	qUVJlkcUOI9Y0it87VOVUVY+w4xYTnYR+
X-Gm-Gg: ASbGncsLCdQq56X5NIybhgxoVfeMnjec+P1U8qxIIUru93NkHUwsnVLAdAOmiIwFPhB
	yl+M7h5ADMfg8qV7j+TkyRA8YrnJceWlLPZhUue2rkw5opW2D4v3a1Ex56dH6esZ9QTdmpB2XRD
	yoQb5alpaivsUIz0CpGlt4S2CZzCWOTFJKZZbkMOTWjFg6LdjKihEkVfK9WEPFLLpeLjGkTU0xt
	rtb9GIZRysARIrX1jXVV5EigIr4CbmVhEO+qvvF0Qs8eO+IJaBayDl5CmAgYtku81whYhvcX1v9
	GjKxJvCCk0WcJbUGV4Fq+6XidzHZLhDNuCDal+9AQwvQkt69
X-Google-Smtp-Source: AGHT+IFIj6bIjEm/3qgI1qYI4OA5ti99/yOaPrOtq4B6Fitpx4Zxnzfv1pINOLQ0GXzj2xQjYD6Hj0SUAHD3
X-Received: by 2002:a17:902:f641:b0:224:1212:7da1 with SMTP id d9443c01a7336-22780e172a0mr29236135ad.13.1742589410068;
        Fri, 21 Mar 2025 13:36:50 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-22780ef2471sm943475ad.14.2025.03.21.13.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:36:50 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 514F53400FE;
	Fri, 21 Mar 2025 14:36:49 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 457E7E4195E; Fri, 21 Mar 2025 14:36:19 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/3] nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()
Date: Fri, 21 Mar 2025 14:36:04 -0600
Message-ID: <20250321203604.3911446-4-csander@purestorage.com>
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

nvme_map_user_request() is called from both nvme_submit_user_cmd() and
nvme_uring_cmd_io(). But the ioucmd branch is only applicable to
nvme_uring_cmd_io(). Move it to nvme_uring_cmd_io() and just pass the
resulting iov_iter to nvme_map_user_request().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 40 +++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 843371e6e1e2..feac2c2b33e1 100644
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
@@ -511,13 +500,28 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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


