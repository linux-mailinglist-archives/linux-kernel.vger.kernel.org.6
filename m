Return-Path: <linux-kernel+bounces-509955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C482A31684
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89711188978F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF1262162;
	Tue, 11 Feb 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e25u7Awp"
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E026562D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739305252; cv=none; b=GL4+SmlXg2/FzL+4MD15CKkVNXP0VV7VjQcuuVl69VDoSOng9Y0Wh7i2lUXpPkrL8ZyxS7SYLXOYrAs1aWQelU4rKcqFLHV5FjHHN4P+EE0Y6yq20Vsb77oeywucVcjR4ioF8Y+Z8/YRtJtnNoyuXwbKyPGXLra7o8Q/Ps6PafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739305252; c=relaxed/simple;
	bh=PU/4T9e5pHugUm+/ZNeeDqDdiuPHBuEOUvo8/mnQE9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uh5yf8TksGNHs2XmRhL1KExn8hTV6pRWZ3a38Y1aYjP9O3a7BTcy1xqOgh/hFSAaT00Lk0sC14rpnvE5LRBmofLz70aC3+F91bhDW8u3YcnVRJHdK5CfbpidbOVIAjfy1v9dNPInJvtmu7RqCFIOwxZrXK8Dwahmq7JLLfSXNbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e25u7Awp; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-8552944e0b4so8515839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 12:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739305250; x=1739910050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=csJ7f6rdwklnGRErPjOt9JKitwpK8CwkZyN2fZNR+N8=;
        b=e25u7AwpN460hhdt4i2ViH9/bz6ojk36ckyTWTl7Ql7+BGhj49LhsG90/+Hw0AUJwX
         /HRN2//HYcjsk3HsjojPoGVO/L6xgjA7RG4CLSY9QjOksAsMuG7CCfKKv0L7PVlCT5Wb
         g4k02gDZ8ehX4ozE1oo3j1cNwbAjaxpVJcXvSX7liBVARqd+3KUXab1BbNmoxP61ML6G
         JkFo1DYw/kVAX2TdRgJMR10O3TGLaksoAy9aEZNsoiv1gvAay0xeOitCFLx6Tikz3ZFt
         4fmJcRr2mcCvbnB+fAtOaEDjWh/oSFwJYGHq5vBPU3CjEzoWHsutOX+fG/GsojpwhvfH
         8CbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739305250; x=1739910050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csJ7f6rdwklnGRErPjOt9JKitwpK8CwkZyN2fZNR+N8=;
        b=ozce+uWtI2By0yzmMHrBFvsdMssoEmeeUFSNilScweJCTU1YS1k0eTgiYlgW54uZT5
         HeEGBxi9DriKz0zJmh2jhag1gYFHeIWhxBoCxGrSjRM8QBlBUuYOYAaPH+JDooV3bvKK
         roDnGCF9radkvsFHpNK1ymtFJ9pLODS3rGOuiFFqk8DdAUVXRB7yqFvg8hDxBXRsu9cf
         nQfIumBK7/HsP88BqT9MunA86zTscsDBZ7M095AiLKe1oONBO5YSuaZnlyx/jmn/ehf9
         g8oMV2Rb2fzbMIlBRxJRIORXTHNvt2QdI3+Qk3k00Csrv0isloNn9pFy40vnmEuJvqoT
         GsQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtqOXwBRfZJlRzJzG6X9KkG+DTyV+JrHDlWV0i4u+c+dmUKXJdF4Vafdkg5QO+Iy8VLdYsfhumrLN4A8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3qbGshRqrIdjFu0U1z44pnV+p2H31Kc9F7lXR4RL0SQRNRef
	m/ylZctE5nq2/xd/VHbedg6NbDckQk8y3HF6q9NfTPV3aGa9QbOPw/STPJnfXz2qaCDnHsbfzv7
	gnQLlLddByYEyJ64qMJjN+YtgVw8+jUdq
X-Gm-Gg: ASbGncvsDt8sCXAIQhw2EnuyG3zef1rtzKOmgJO+41aQMR7TahiWveg0kiCp9KPpbA3
	3PzQb2VrBqafGOr7ic7NdoCU64EOSVs6SeNCamL+pkAAv94apSst8KqNClANLhM4J5IG3XIAyUT
	+jQ3Dary2Nr4+b2M4Lp42LHHa+Tnk3uhaBC24A8K6g06ltM6puJbVayKyG2Kz6Em9n16owJyZUs
	zDOnTLgufGn+Ufrf+vz9AGNR9FeDnzP4vTZ/dEoeHC005KQaBrNToGPnNR7w4+v5JJMdcm0kAKm
	smv5TRWsj/C4/3AnScOGWzU1E/YPJvRGF/aKyQ==
X-Google-Smtp-Source: AGHT+IHsTrPbdU/3vEFLg/XqPk1UsqIU4VwKugBocGrCcrJHn8lsYoNhUdDT/80cjTS/VgudnAQcEG0cfPfN
X-Received: by 2002:a05:6602:13c2:b0:854:a5e8:3294 with SMTP id ca18e2360f4ac-85555dad5ebmr23112439f.3.1739305249960;
        Tue, 11 Feb 2025 12:20:49 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-854f669af2asm61994339f.18.2025.02.11.12.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 12:20:49 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E2C543404B6;
	Tue, 11 Feb 2025 13:20:48 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D1687E40DF3; Tue, 11 Feb 2025 13:20:18 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: use IO_REQ_LINK_FLAGS more
Date: Tue, 11 Feb 2025 13:19:56 -0700
Message-ID: <20250211202002.3316324-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the 2 instances of REQ_F_LINK | REQ_F_HARDLINK with
the more commonly used IO_REQ_LINK_FLAGS.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ec98a0ec6f34..8bb8c099c3e1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -108,15 +108,17 @@
 			  IOSQE_IO_HARDLINK | IOSQE_ASYNC)
 
 #define SQE_VALID_FLAGS	(SQE_COMMON_FLAGS | IOSQE_BUFFER_SELECT | \
 			IOSQE_IO_DRAIN | IOSQE_CQE_SKIP_SUCCESS)
 
+#define IO_REQ_LINK_FLAGS (REQ_F_LINK | REQ_F_HARDLINK)
+
 #define IO_REQ_CLEAN_FLAGS (REQ_F_BUFFER_SELECTED | REQ_F_NEED_CLEANUP | \
 				REQ_F_POLLED | REQ_F_INFLIGHT | REQ_F_CREDS | \
 				REQ_F_ASYNC_DATA)
 
-#define IO_REQ_CLEAN_SLOW_FLAGS (REQ_F_REFCOUNT | REQ_F_LINK | REQ_F_HARDLINK |\
+#define IO_REQ_CLEAN_SLOW_FLAGS (REQ_F_REFCOUNT | IO_REQ_LINK_FLAGS | \
 				 REQ_F_REISSUE | IO_REQ_CLEAN_FLAGS)
 
 #define IO_TCTX_REFS_CACHE_NR	(1U << 10)
 
 #define IO_COMPL_BATCH			32
@@ -129,11 +131,10 @@ struct io_defer_entry {
 	u32			seq;
 };
 
 /* requests with any of those set should undergo io_disarm_next() */
 #define IO_DISARM_MASK (REQ_F_ARM_LTIMEOUT | REQ_F_LINK_TIMEOUT | REQ_F_FAIL)
-#define IO_REQ_LINK_FLAGS (REQ_F_LINK | REQ_F_HARDLINK)
 
 /*
  * No waiters. It's larger than any valid value of the tw counter
  * so that tests against ->cq_wait_nr would fail and skip wake_up().
  */
@@ -1155,11 +1156,11 @@ static inline void io_req_local_work_add(struct io_kiocb *req,
 
 	/*
 	 * We don't know how many reuqests is there in the link and whether
 	 * they can even be queued lazily, fall back to non-lazy.
 	 */
-	if (req->flags & (REQ_F_LINK | REQ_F_HARDLINK))
+	if (req->flags & IO_REQ_LINK_FLAGS)
 		flags &= ~IOU_F_TWQ_LAZY_WAKE;
 
 	guard(rcu)();
 
 	head = READ_ONCE(ctx->work_llist.first);
-- 
2.45.2


