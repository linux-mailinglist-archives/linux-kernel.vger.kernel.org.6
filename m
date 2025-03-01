Return-Path: <linux-kernel+bounces-540085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE28A4AD76
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B083B13A9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA8C1E5B7A;
	Sat,  1 Mar 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aKfmjQ4t"
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6311B6CFE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 19:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740855803; cv=none; b=R6m4SrmaYUozR2EhHTDyzvJa3ABZvYq5frRS3XDJK3DPn347QVNrh8TwhDQHUH19dsbRRnKE70dgLLzhFAU7v+0pZyQHJB0KWZQ17DQ7vLAgHeY9G9+DwbHZxYm0AeMA5T2hyP4/nITWiedQXuU5Rbf0hB2GmiaYTKJ8ywxw4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740855803; c=relaxed/simple;
	bh=GRjsFbkbVxXqkass6qIGbhqNaI3PmF5zffUNEdoUW8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b8uAISZfJNkO1R9LGZKdGVjzUy5+TDgXmd94shmTO9pFXgwsRd2O0BTVZH4ryE39BZ5Hss8Cpg7cPJj+z75SPBCMGZZMHjJYPBucQJdIHX0qY5AFCQOfUtWCeva3ByIgj+KRFKXoYpxbQrLbn/qkAda86hHUL+IXLVfc7kuf1mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aKfmjQ4t; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-7c23aede3deso40171085a.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 11:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740855800; x=1741460600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPtTyrhHo4Bp34ujcUzSOaIDxgVPVdiOF8KP+yd3nw8=;
        b=aKfmjQ4tqbwyYMQwDe7Hx3zxDJa0Yp2/H53VRGCAuCtCIgHCS+gX6K0lyL69kgyCt0
         3Vv7K7wN708YiheapACyMkcFfqTfxrtEyi+c0g7jlPUNXjY3Ap4hUOYGA/lqDOAvj8od
         RGQVPZz6Iizb+/KYYNIql95FgpmjXVPXq+gJ9i46oAbrqXkZff8KdkoHo51ZpRAjRlDX
         0yZYxn9EKycyIt/mzUWi1awqUbEQL5W0NTM5KBSQDqGv8Wj1oQer9MBAiJmG8KpLD10p
         wMQbxwEDcmxUUI0SMdpURCYVknme0qrhYNuerFNtCL6l1mfMRPyRVDrh6slJTEXAFpE3
         51pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740855800; x=1741460600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPtTyrhHo4Bp34ujcUzSOaIDxgVPVdiOF8KP+yd3nw8=;
        b=TVLmyUetlW78LnzCJOMB99DrIRYHYx6H/CN9uoyTAUI/CWQgStAQ1PDmaKT6AWSEAK
         FeFgdG2TiuE4nhiX0bhetmE5OWtrLbz2WQxZ/O7xWa8JpIgxMZ/dYo5rxcRmwCh9Gcle
         b8+eROeaUtUamdiQyvxPuzUQEnYO2MEUPD1ZTV9uxq0NuXJu5qJuLHnH8BQB4Kh7dlAl
         Iuj3S6mmjjAb5Kep7FXD9J6PpgivVP0biZqSQcst4Ci2A/KjgDhgLyfKoLkl3SSk7/2u
         lglDp2sz9Zo6ara0jV2PDBvhw7etD8JIYQivG8dT913SBM918D/78f43PA4YN7S4lD7W
         O6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpiiEuppXPlcWorfXkElqbwX2DN1Y2orSBySZHcEBvTkjvouo823t3tJH1Im1sBon8RfhIi/2jyJZQRJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QJL8JSTXpe2Hlx8U2ZgsKKw8cu86ZR1kKAJLWAluxoWTIxK2
	BxZeno17W1Fe78hA++6oEeGZ2u4bzbv5Td+Kdvtm+P+gZC/2jsrUmqKAH5gMWuB1EAn2O99unC+
	Dj7BfLr+F4S4vhrq8JurJipx1uGh+j/+pG/YI6OmznhLnW1wm
X-Gm-Gg: ASbGncs8nppFVHj1jRUVcQez1MEf9RHhdWsrZGdPTKripokzTTcNSanrRHwKl4ov0PE
	x4yNTCuzzYcUfHDBLF+TDuHEZQ5VgYHxOGi7gf/N+/mCZVhpLHVzai2Vey+nSvgtZ+R3sYVrybt
	HOOVYtWv30pENU2iUw2kG+pViFyR2WUk2nbGidMdIAF+58PReYCJOKfX59O8jpXBGB045zY3Z/6
	VPeSe6dnby/6wKviO2vsCQnwtYPWB9gPOIAbPyVAyu4ZvDcfHMMJKIbWYhWWJzddd+j7YWG3/Qr
	bPv+uFDeWHn50RxwJUAC68bJg9Os9HO/tw==
X-Google-Smtp-Source: AGHT+IHT7qGAIK+FkEaSknbOU0OApb1ysNsvmSnrt6XPcK/Su4fAh06kTZ1i9H3Vw3B4+jE1gchSfRbEcxz6
X-Received: by 2002:a05:620a:410b:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7c39c4bebdcmr470979485a.6.1740855800384;
        Sat, 01 Mar 2025 11:03:20 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e8b0f85d4bsm812006d6.5.2025.03.01.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 11:03:20 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E2EBC340314;
	Sat,  1 Mar 2025 12:03:18 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DCDEAE4164A; Sat,  1 Mar 2025 12:03:18 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: don't cast registered buffer index to int
Date: Sat,  1 Mar 2025 12:03:16 -0700
Message-ID: <20250301190317.950208-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_buffer_register_bvec() takes index as an unsigned int argument, but
ublk_register_io_buf() casts ub_cmd->addr (a u64) to int. Remove the
misleading cast and instead pass index as an unsigned value to
ublk_register_io_buf() and ublk_unregister_io_buf().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 512cbd456817..af5a4ff4bd3d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1760,16 +1760,15 @@ static void ublk_io_release(void *priv)
 	ublk_put_req_ref(ubq, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 				struct ublk_queue *ubq, unsigned int tag,
-				const struct ublksrv_io_cmd *ub_cmd,
-				unsigned int issue_flags)
+				unsigned int index, unsigned int issue_flags)
 {
 	struct ublk_device *ub = cmd->file->private_data;
-	int index = (int)ub_cmd->addr, ret;
 	struct request *req;
+	int ret;
 
 	req = __ublk_check_and_get_req(ub, ubq, tag, 0);
 	if (!req)
 		return -EINVAL;
 
@@ -1782,14 +1781,13 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 
 	return 0;
 }
 
 static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
-				  const struct ublksrv_io_cmd *ub_cmd,
-				  unsigned int issue_flags)
+				  unsigned int index, unsigned int issue_flags)
 {
-	return io_buffer_unregister_bvec(cmd, ub_cmd->addr, issue_flags);
+	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1840,13 +1838,13 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 		goto out;
 
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
-		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd, issue_flags);
+		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd->addr, issue_flags);
 	case UBLK_IO_UNREGISTER_IO_BUF:
-		return ublk_unregister_io_buf(cmd, ub_cmd, issue_flags);
+		return ublk_unregister_io_buf(cmd, ub_cmd->addr, issue_flags);
 	case UBLK_IO_FETCH_REQ:
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 		if (ublk_queue_ready(ubq)) {
 			ret = -EBUSY;
 			goto out;
-- 
2.45.2


