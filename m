Return-Path: <linux-kernel+bounces-574326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD798A6E3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23D716FF98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88E71C84BB;
	Mon, 24 Mar 2025 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bv11I3vp"
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E91A3174
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846786; cv=none; b=PHyJ0SzejXFH99gkZzPJSottT6RWyQJPnvdmi/X3FpAhmKAqey5KP8Mz9TjgzLTjSqkVAa1SwZeXR4iBKDA6gzZO+NCflgNo6oUlGjkhfjtiaba4PJJuDdpofmrCCJt3eyZ0Hg9Rh5KbfNvIXIAPicc6jpRny2/Ek7CwAo99LaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846786; c=relaxed/simple;
	bh=1iS4mGcy0YW42yJZNnESJIZkw5XDhoB+d/oFC8PEVes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDJmD83+Oc6aYlbAGDbCiF6MBxOOvjPiyKB0cyC8/wQymVE5/FGWN0Zw0gWExb4KIW4nYNTkoznIVagGzsf7QE9Pt7kTnhjboYp2H7BoBOAJCD96J0cwhulyaoGpULu6SdhagZRjKPbrKJvz6s1SYuCNZSV5cogQfyoRk8qXeHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bv11I3vp; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-3d44ebf518cso1873055ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742846783; x=1743451583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBv3iNMxv4+elhFyGCYrja1iq4HKQSGLUCy5fijhOxs=;
        b=bv11I3vp1V3iQBDBm58FK2aDobHabnlnKGlQaRY+8i7FCqj+qaC10f07PM6MSrRuIe
         8/iWK60x/PBKsd00BR3eWzL7LI9bI14Akeasgst/6D6u/LNB3PUwNf/kqzUJaCpOVnAH
         gw29xFfqH0Hgia/JRehpOCUgYWaRuNIpVpeOwFtmeJRQG3rUQKL6P9JA8ye/q8eCEL0h
         ioSsp3HLCVmPG3H1R+UoR3tbGPKRcKvi9xE6jYHM8ODWIWs9pXwviGcCWGF6uV+x8DvA
         DfeZN3yXsmi+Dr9/2AY39OmKH7lg334ul0lUD7HC5amaECkEh1f+UvBKL93lYvk3gJxC
         giIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846783; x=1743451583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBv3iNMxv4+elhFyGCYrja1iq4HKQSGLUCy5fijhOxs=;
        b=EOvT+Mz+yEBQ6Xevwji/RnkiWtYqW2zBRbSM+dPmgc2gaNeCsHnZMTZ/Am3cL1zTtA
         9ShBr58g0dCTEvu31T4MFYU1B044a53zarHClZo4dx0yr3XVcUMgoPjBZiY8gE/BrWHO
         ah57FM9iopirH0P1xPlZS24TNytjim4WX4IuFOdhIv/PhlOQDSPIRPS2GDxrsk7nattd
         K8TK3RswSi2P9nPr69C3BLj+acsG/uXgkFsb8n5snOPE9SmRbwC6YOO3c+k1wY3nRSnE
         hJykOGIXKsDLUkLG98tlOim3+ldPOFDMz1Nmr1nso5ra4d9ktXoayF4Syo2YecVd6mHI
         yKbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2e96IhKMMoVBCa2M+CnbXkNzokwa+BvnKlM9z/+DKUDsolpfKxAMltRCS6scO2sa0Awq/aLRgv1ZKn5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVDTqbzo8RPPtLnsXgOcq01AvYYSCqBCcOVJUBkrXu1wGrIiIg
	FQ0Kr/Z9zEabl3/l3723tpA7NF9oZR2x4mTKJafPUJojUY6UMnrQZsNgGzvOLIhBgzqzff2WYAO
	dcFfs9sZS7evCvYZ0JkP3EEvkV23OYJiK
X-Gm-Gg: ASbGnctVU0FQyjBrjcvMicZl6IX7jgt4FWymm5C5gpf/av4seiuqhGlrpj6owD7hgE/
	rqycMgDyY5rxGZdlokZe5vr+1oTVYh11KZi70hN4+kJChVYQ8hdpHlc8kpHMTJ9XSWsJixWiXR1
	p1QFlZgca2JznYI6ZX9B3clnoSvV4oluodbO7SWj7K/+XJ/QqkXw86bdyW8G9LAziNe2EJFKZow
	e1cfxr5n1JOOJCSF3/6evjWpdwYincrVvPvrJO3RNTIb/AJk9psNBbbG5WiBJuCFuTVz/xTmPzG
	Llv588WOuWR/4dZFUOg/sfGebj5S4ffqfnRSBLOPCPMiaEvj
X-Google-Smtp-Source: AGHT+IEV+lCwII9GhQtPHGVDcjw8YXVvBkkja75sRJDPkHKdd3G9TROtFMPaXK5/0cUjj2j8hg6M5JXiMBNm
X-Received: by 2002:a05:6e02:1c2e:b0:3d3:fd18:4360 with SMTP id e9e14a558f8ab-3d5961854a9mr39970815ab.6.1742846783185;
        Mon, 24 Mar 2025 13:06:23 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d596095834sm3865285ab.40.2025.03.24.13.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 13:06:23 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 29F58340363;
	Mon, 24 Mar 2025 14:06:22 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2180EE40ADF; Mon, 24 Mar 2025 14:05:52 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>,
	linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 2/3] nvme/ioctl: move blk_mq_free_request() out of nvme_map_user_request()
Date: Mon, 24 Mar 2025 14:05:39 -0600
Message-ID: <20250324200540.910962-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250324200540.910962-1-csander@purestorage.com>
References: <20250324200540.910962-1-csander@purestorage.com>
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
index 0634e24eac97..f6576e7201c5 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -127,41 +127,39 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
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
 				rq_data_dir(req), &iter, ioucmd,
 				iou_issue_flags);
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
 
@@ -174,12 +172,10 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
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
@@ -200,11 +196,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	req->timeout = timeout;
 	if (ubuffer && bufflen) {
 		ret = nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
 				meta_len, NULL, flags, 0);
 		if (ret)
-			return ret;
+			goto out_free_req;
 	}
 
 	bio = req->bio;
 	ctrl = nvme_req(req)->ctrl;
 
@@ -212,15 +208,16 @@ static int nvme_submit_user_cmd(struct request_queue *q,
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
@@ -520,20 +517,24 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (d.data_len) {
 		ret = nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
 			d.metadata_len, ioucmd, vec, issue_flags);
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


