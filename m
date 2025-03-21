Return-Path: <linux-kernel+bounces-571964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777B6A6C4BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA4D189B601
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB09231A24;
	Fri, 21 Mar 2025 20:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A3egmY96"
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C88230BE9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742590677; cv=none; b=ukAYBTHXbx/OQp/Xvpg4kcKqQuyzWz9kmVrWXrW4tRtCnR0KZWE4pZgMbJ7ktUNYBdvtT02PmHmk1aMOcTiJUPfkJpJu558Up/ZtuCHSY/3UDRflHL3Xo0n5Qft+C6GnCkDA7V8Zj4aex2n40+o8tOXspK9GLr88dD2gVfBKlh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742590677; c=relaxed/simple;
	bh=yKL7IczPQuQF3SWeOBm0zCzXPd1dogWlb0noBZzcEIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb7uMa7BKNVJCK4oP7jimtI0xVbh4zfPitTZUEcTWd78+NIKMxtBCjGZFeixapWhCajhKl6MpIM7hW8LnwoUJxIJqiv1CvGzf37wG0X6eg2K3bQi4dlBUl2faxtPddXQfxclYHDU3shPva0F9hUshB07A9Ju3s35lECwXiYp8gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A3egmY96; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-2ff73032ac0so608535a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742590675; x=1743195475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqACgqSPAGulvpdL72lXsG7CJBHtcdgDXf09Xg+OLKQ=;
        b=A3egmY96xnVfSszRD6ovreu2rfmGBY/orRnNjIHZ6SW2oCi7cimULNl78uOI57ymIY
         PbL2y776Tn4JI/fuRzFicV340GZ6qPnuAt+k0WymC2JIYngSzdZlS7oS/u+DFXkb9Khi
         Nk8stAr5jvruOdq0KkS70x0WehismJWS9ZoWpIu9pYrgTO2USYy81XNEu+JrgWkDiiRM
         /k4ltq0ilLEL11SjgPCzhIS4iFZnvdlv7C3ona+d7maGwZCodumLGrNzp5D4ZZOT0owq
         uTeoLeRik01XJtsqPl/ej60gIQ5mg7uWXnsHuL6s8pOJY2BZHBbGKkCvd5+1pedQJvfZ
         0Hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742590675; x=1743195475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqACgqSPAGulvpdL72lXsG7CJBHtcdgDXf09Xg+OLKQ=;
        b=IR2FMULNZ2XuJPmUoYehDjHmvlx1TevxkshkwlrxSldXVgPmsZynNS5pMs6GJ+xLu7
         wWGrXFViouwe5/t40G3qhUobVs8NVMrE1eCbYk1zcpHIWZa7xeDswMwKuxXiLhYyPER8
         Nrizw92k2S/T7qphApSm55mAduIdLSt+hFgITGNKhLsJ7e4xX0KO6d4//vIhB1hX3Pkt
         PsfB8UDiZ6hwM3kAGkvAw/seG7JDIAJ6Y1bue00kK2BgaOD33BGl/r7BJfgcA3jLWz6l
         W/NpnMB4Scoht1x2inYdjdzw3czUt46hjNhwxooZ2e73eqXSFfOQzzXA6VU2auyLaz0V
         KuBw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6GY/6V8uvs+la6taNX9zKusG33vEsDFcnBIm3f18tskterPVhSZlpovEdQxboQox0IzKIs/uZtC0EBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnqIm835WG7YMAvwVQ1vc01JcIfeZPDPiFB1kPOjVvJgwB7GEw
	02AFMmAUn/qVRnkHbqChefEA9PWGrNGVLIf0zplxoRZnB6+FbRbTnN8t3qVPpV9OG2n0h1DKwjW
	Go6ilXKm7szzcwfA1REpM660QjWw2/INq/PEjfzN7o0Q/tj2u
X-Gm-Gg: ASbGncvNz4PRYkND8dj5rplp7AvVhFMTyYdG6bqyJJLbyU+scpX/OTmUD9xiwRFNb68
	GIjXDhmzPwcbZ036BAr0x4cXz3UTj8vUORoojc2rhIhVI8hzBAaS42OeuKXIXhY9iapQeOGhM08
	dTS4y/n752nrg57FEushfFlPupaf/+3JMlD1eDcDNbOcJFCTT8H20IAtIdMDymXm5fvhJhujFEq
	QzoB3iGxafM1xp5UodJPvjR71yD9a9AQ0z8rM0Vbfmxq0ZOpaQg5NlrTK+sxGRAR68BaggvlmPS
	l56oome3cfayDhzOlwdzIna6v28c/++y/g==
X-Google-Smtp-Source: AGHT+IEaGairhpn8t9yDvUk8suCFhpcyk6iBi2A9vV17xzcU4/YSuUiQ14iekBObKOIJ+plm9Q03wWYMW1RU
X-Received: by 2002:a05:6a20:431b:b0:1ee:e167:1f36 with SMTP id adf61e73a8af0-1fe42f55affmr3471813637.5.1742590674800;
        Fri, 21 Mar 2025 13:57:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7390602a27csm136934b3a.15.2025.03.21.13.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:57:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3402C3402DC;
	Fri, 21 Mar 2025 14:57:54 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 28A2DE4195A; Fri, 21 Mar 2025 14:57:24 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/3] nvme/ioctl: don't call blk_mq_free_request() in nvme_map_user_request()
Date: Fri, 21 Mar 2025 14:57:21 -0600
Message-ID: <20250321205722.3947901-3-csander@purestorage.com>
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


