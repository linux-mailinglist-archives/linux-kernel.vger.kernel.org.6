Return-Path: <linux-kernel+bounces-511882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC45AA330FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512083A8C13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C77202C4F;
	Wed, 12 Feb 2025 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SsQzcMpj"
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7506820103A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393169; cv=none; b=Heudl4y/AiDhwrgxEW2MVQXcKY8uxSpTLH0w8z99THXnWA4yXEJWmL7FnA4h8O3BqCq5xCUReW162J2gs7WM/b4EJA9JMz4hutXFOhVUN+ZM7M+zCa9bqTW5oCXxfWhUOU7NS4BDjTe18L8zXVjglPaqUleF+L4xkY+eJo9/JrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393169; c=relaxed/simple;
	bh=eeT59URkB8BtNx633XNrD7bxhoHpewE+65P5H0rT0oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKH+cKh+NJq7wSNtUJqaVnxRXm0dDAGIkg5wF+or/hc3ybr9bGakV8uTcnE8RmRQNwmFlGUpYZF4+L9MpxletF0a6n41A2a3exZgNwQVsHbZoKUBYo3iLXfu/POndkHw4BhaDEv8A10nY3auYPOmYGvXqL4jCWtWA7EG1/1zr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SsQzcMpj; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-2fbfa7100b0so49460a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739393167; x=1739997967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oPNijH5Sc3nr2XmbysFEspzjbNv2CMnY8sx3nT5qMWI=;
        b=SsQzcMpjTCck10euX3vb1V7WFAcLvIwA/86YqNu4EYBIId1d3ZNcw7RA4IJYtbIlI4
         wnklpCs7tYZSOktTP2PCcqzIvIKfzBclgMue+2a3OT75zjcbCrXys2/BUfvSF2Pl+LaS
         cB2/K2q5U9Y/J15B7yeCOHO4RHZaC2LpY9VFvIXTdbPnuo7upeEBzb9DZvfVOgzyik1q
         TEVCWL0t6Fd8sbAydgFcZIoMBzVCNMy7nFvtAwDRrUR0KKpFA5Ye+7HMyUvampJi0GJt
         JWf5TFsKk/car9IsSZGXKIERs6MSaXYSUkC0Z0x9OCCdY5L3KJO5/br9ao8Xay3i/lpz
         5zYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739393167; x=1739997967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oPNijH5Sc3nr2XmbysFEspzjbNv2CMnY8sx3nT5qMWI=;
        b=iTe+aI2pIkjaskBxXa5yJQCadMWVzQdGOcwDzC2KoRChBwAn2PbbeJhZe3kD7p3fO9
         lrB/DefCbHA6iq+DmNwasF+NVdXLeVT9UoFrcmuTo07T2eI9ogDZduhj6IZbbZhBi5Ax
         bfWb3oNP4kQj40aJHjceFVST1u8+I48RGBhEz0A3s7DsTXo9nPeCTSZ5mv9G1WfvjJ99
         cYJfK7k+Pikylelg5HADfUNK+c2+rDuz8wHlHx8ugdsFoZ5Gy08FNTZOce5rN/Ql5h48
         K7fSdY15Bck3PDVh9XUhIFo/hkue7y4eyl7p3cT3qa7vA1zLTbTLexebVIeCaPEC1Oz/
         CRcA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Wm+OU7lxzlgiwrshEqqUXKhzu1Zn3p/iY7Gh5eG4vfsaZlmpBgQ1UA/RFmHrWHACWDeaSpYwcXFo2cA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy/aljyz8z0DA0AEWbbXStkJJRDZsYM4UQG1Tas8myVBfVoQsL
	sxGiemIlQvAij774nbDERdfxYY09YCA9Q6RPrY9FjSOaw++FSXFtJuEaaeNSFjIrNMLck95XByG
	mx1hZOY1e/BxHuk+Xxt6jTt25A1ccvtrQ
X-Gm-Gg: ASbGncumBBltA4maMtSa9BNzyJzkZV8uJYIVrUmcQLWF+Hei4T5UJAZpRSNMdw4eX8x
	T9M1IPJyWX94z//hbafrjzKxmsqH7OJL/6isuVik2EHxJaZZypTy/62YnrLC9EueTYGq9PKtTSi
	pjClsp+Ava7ND22arsDr4EWVb4ebcCrffvpg+44E4F676GmqOZGgtKuWER33bfDuR8t7XtjvYFL
	obflG3TZiDPxYx9ZGI0iEp6MyXryXSpGiFfXKMEtA6fJzmvopw5XLRvpEz9y5rabo35N4PSe0PX
	9UBNnRqf8PAUBSaaheyuY85gjnsd2ahnXy+17g==
X-Google-Smtp-Source: AGHT+IEGGGYFBXQjVOXTA9A01ACW598Eb6VOLJN33xDmsi02G3BvTVlhYf6Ii7mAGdq/sBr0KLz9S/+1QQxO
X-Received: by 2002:a17:90b:1807:b0:2ee:a558:b6bf with SMTP id 98e67ed59e1d1-2fbf5c79d4emr2804484a91.8.1739393166677;
        Wed, 12 Feb 2025 12:46:06 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-2fbf98b9449sm129276a91.4.2025.02.12.12.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:46:06 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E55423401A2;
	Wed, 12 Feb 2025 13:46:05 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E1AFDE419A0; Wed, 12 Feb 2025 13:46:05 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Riley Thomasson <riley@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/2] io_uring/uring_cmd: switch sqe to async_data on EAGAIN
Date: Wed, 12 Feb 2025 13:45:46 -0700
Message-ID: <20250212204546.3751645-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212204546.3751645-1-csander@purestorage.com>
References: <20250212204546.3751645-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5eff57fa9f3a ("io_uring/uring_cmd: defer SQE copying until it's needed")
moved the unconditional memcpy() of the uring_cmd SQE to async_data
to 2 cases when the request goes async:
- If REQ_F_FORCE_ASYNC is set to force the initial issue to go async
- If ->uring_cmd() returns -EAGAIN in the initial non-blocking issue

Unlike the REQ_F_FORCE_ASYNC case, in the EAGAIN case, io_uring_cmd()
copies the SQE to async_data but neglects to update the io_uring_cmd's
sqe field to point to async_data. As a result, sqe still points to the
slot in the userspace-mapped SQ. At the end of io_submit_sqes(), the
kernel advances the SQ head index, allowing userspace to reuse the slot
for a new SQE. If userspace reuses the slot before the io_uring worker
reissues the original SQE, the io_uring_cmd's SQE will be corrupted.

Introduce a helper io_uring_cmd_cache_sqes() to copy the original SQE to
the io_uring_cmd's async_data and point sqe there. Use it for both the
REQ_F_FORCE_ASYNC and EAGAIN cases. This ensures the uring_cmd doesn't
read from the SQ slot after it has been returned to userspace.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 5eff57fa9f3a ("io_uring/uring_cmd: defer SQE copying until it's needed")
---
 io_uring/uring_cmd.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index cfb22e1de0e7..bcfca18395c4 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -166,10 +166,19 @@ void io_uring_cmd_done(struct io_uring_cmd *ioucmd, ssize_t ret, u64 res2,
 		io_req_task_work_add(req);
 	}
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_done);
 
+static void io_uring_cmd_cache_sqes(struct io_kiocb *req)
+{
+	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
+	struct io_uring_cmd_data *cache = req->async_data;
+
+	memcpy(cache->sqes, ioucmd->sqe, uring_sqe_size(req->ctx));
+	ioucmd->sqe = cache->sqes;
+}
+
 static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 				   const struct io_uring_sqe *sqe)
 {
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	struct io_uring_cmd_data *cache;
@@ -177,18 +186,14 @@ static int io_uring_cmd_prep_setup(struct io_kiocb *req,
 	cache = io_uring_alloc_async_data(&req->ctx->uring_cache, req);
 	if (!cache)
 		return -ENOMEM;
 	cache->op_data = NULL;
 
-	if (!(req->flags & REQ_F_FORCE_ASYNC)) {
-		/* defer memcpy until we need it */
-		ioucmd->sqe = sqe;
-		return 0;
-	}
-
-	memcpy(cache->sqes, sqe, uring_sqe_size(req->ctx));
-	ioucmd->sqe = cache->sqes;
+	ioucmd->sqe = sqe;
+	/* defer memcpy until we need it */
+	if (unlikely(req->flags & REQ_F_FORCE_ASYNC))
+		io_uring_cmd_cache_sqes(req);
 	return 0;
 }
 
 int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
@@ -251,11 +256,11 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
 	if (ret == -EAGAIN) {
 		struct io_uring_cmd_data *cache = req->async_data;
 
 		if (ioucmd->sqe != cache->sqes)
-			memcpy(cache->sqes, ioucmd->sqe, uring_sqe_size(req->ctx));
+			io_uring_cmd_cache_sqes(req);
 		return -EAGAIN;
 	} else if (ret == -EIOCBQUEUED) {
 		return -EIOCBQUEUED;
 	}
 
-- 
2.45.2


