Return-Path: <linux-kernel+bounces-571820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE78A6C2C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50024835F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A54022FF40;
	Fri, 21 Mar 2025 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RlyHQmRe"
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F4522F173
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742582953; cv=none; b=YF03vrW5CoptBpFEMhC/RxNIHqCT0USpCh3Yx9yu0QD045MCW+Grgo0gOcv1OwwdyYgDP4bibEFSlFDlUSI4gtpWZoTkmYEO/edmgEY95cy0udpqcXdUBZvDiju50/KBS7yBjzRIZDF0Dkp4H0kKvMxEovTwOgIG+isKZwgJVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742582953; c=relaxed/simple;
	bh=lxmcofva5//2EQ+B85qMF6Mq3NUFCy30aYIO2O9+XFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLHzvUDQW+kPieXjb15t0jZbv9F7NVZCEvRtBs5PoXsdJmgwq4qOHWBty7A5d+mw9bqq3c1WGpOhRsvOnI4W9xumqb/l+ZDG6Nhr+b0OdrBnH/tO3u2sPAkn/qNkuiIvG7S6JUV57OLQ6h7u+Ahwt1UvirF+h92KGCQQPglXR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RlyHQmRe; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-6fda19e90cfso1248247b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742582951; x=1743187751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRnlnXa062Pt8IsZFpPDsC1SEIO6IbPVYGDPK4L3Ww8=;
        b=RlyHQmReuWGk7Et8q6m4gZeXuINY97LZMswOROT5UGzKq8zW0s3BlLWvFVjdwos3OL
         ZSCl0bVacD9koCpoIEBBGHbINPQe5uQae5uGHGs8j5PYTyyZolTOrlUpPRMIFTlYtTT5
         ZPirtpQu6pn/N1uYw36k9LsoGVzyProEW9Pijwd1rn2gzX8EDXH61auyKPp36qTyP8qU
         LsVniN3KLQw2btKFk+M4rr8izzLvWWWucgNCBkZtlGPVTvOL16YBQYWJjFiisNipOPQ9
         OHMyBhfLVBawwfgNcnPpxdKBZK1K7qqfH+QwoMSZrH6LFvCkoZIhcCId8DfH4vDmWk/6
         /fnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742582951; x=1743187751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRnlnXa062Pt8IsZFpPDsC1SEIO6IbPVYGDPK4L3Ww8=;
        b=pT4uNBlSLscdTZ1Vc5l+OI3fDqy2whnjNtwT1wUIa4kFDhjpRoDCPjVMfTYBeYxnAK
         H9hSNlFOyCmpyDZhtOAr0UvA4/ivlYFAvwHdaYkqCEDW/4kQwkDGUazOKPmkvaxtBOKn
         3LALMr3CPN4XUS71yRBFgk12POcg7OHYYxHQHusoQKDLiijmEwhGqqQqnQRSmVuPv/dL
         D/JavzeZLzwgyo5OmrZsaElcfD4EiRtcHHHKNznU+a4w7jZGxhE02yhXFt/xoFcKVkq2
         oPBgNFDYZ3gGjV2YAZNPGzKnsmTNDG+mC2oC62/DxErqePBbs8ZK4ihlQZlH5OlGMNlY
         vmug==
X-Forwarded-Encrypted: i=1; AJvYcCWBcgL1CKXlckC8NnS1fldwQhfef0ny/821Qcu35tooWW6IxzuQhwDqr5fhit9YTI2PX5d7wK2W9aq2xLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1c65Wpat8+9qGeQ7lX0GcZwIgJZcTcfCNiD30+ZTV1TCIosZw
	4IkQQRybEtPO8wgu6Z427+HZkrhCvPVnLkTy+khgicKSp3JSaczCHjFTohUL2TDJW8BYwhPkSMa
	UeTj4ph3aZhkxuhQC5l18SdnbbQslFGMp8o5CtURgSbkpR1UH
X-Gm-Gg: ASbGncsc0BQvEF7sG5/0f7Bb7vek8fje3xOFzOayI1Efpnu2yVZk/NEYjls5wp7cD/+
	tm6U1NdZAgxBYBDmsmXifDza6YLJ5F2ZLFOR8Xa9l9xFzlaZDF8tfkU/ZB0uyjRx68t7lNvLBiM
	db9rlBtMWbm1HLwbRsklVcKeznqfZGWG98Y1xMZZK/Zi3+QWISOz6RqAQv3LKjjOrdN9HQYUzy6
	/zxM/7tHQGLEz/MFwLU7CtwEHQ7z2OeVb4mQQ+WYmkRcK1pcdWrO8kQMqJSYs8ctun2HSevp3nn
	W6AXbuG20wjsKMmgGiUcfmd95sfWOGIEYQ==
X-Google-Smtp-Source: AGHT+IHA/F7ZUbUO8zzTMyUKj0OJFpa6I44qHvQ3vYuRPzv9/KJDLKWorZS1G/3i1I2rbpGBvsvGgFxESclq
X-Received: by 2002:a05:690c:ecf:b0:700:a4e1:630e with SMTP id 00721157ae682-700c73ce4ccmr12634927b3.0.1742582950805;
        Fri, 21 Mar 2025 11:49:10 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-700ba739011sm864927b3.39.2025.03.21.11.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:49:10 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B6AA7340245;
	Fri, 21 Mar 2025 12:49:09 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A7758E4195A; Fri, 21 Mar 2025 12:48:39 -0600 (MDT)
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
Subject: [PATCH 2/3] io_uring/net: import send_zc fixed buffer before going async
Date: Fri, 21 Mar 2025 12:48:18 -0600
Message-ID: <20250321184819.3847386-3-csander@purestorage.com>
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

When IORING_OP_SEND_ZC is used with the IORING_RECVSEND_POLL_FIRST flag,
the initial issue will return -EAGAIN to force arming the poll handler.
If the operation is also using fixed buffers, the fixed buffer lookup
does not happen until the subsequent issue. This ordering difference is
observable when using UBLK_U_IO_{,UN}REGISTER_IO_BUF SQEs to modify the
fixed buffer table. If the IORING_OP_SEND_ZC operation is followed
immediately by a UBLK_U_IO_UNREGISTER_IO_BUF that unregisters the fixed
buffer, IORING_RECVSEND_POLL_FIRST will cause the fixed buffer lookup to
fail because it happens after the buffer is unregistered.

Swap the order of the buffer import and IORING_RECVSEND_POLL_FIRST check
to ensure the fixed buffer lookup happens on the initial issue even if
the operation goes async.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 27cb27b6d5ea ("io_uring: add support for kernel registered bvecs")
---
 io_uring/net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index a29893d567b8..5adc7b80138e 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1367,21 +1367,21 @@ int io_send_zc(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(!sock))
 		return -ENOTSOCK;
 	if (!test_bit(SOCK_SUPPORT_ZC, &sock->flags))
 		return -EOPNOTSUPP;
 
-	if (!(req->flags & REQ_F_POLLED) &&
-	    (zc->flags & IORING_RECVSEND_POLL_FIRST))
-		return -EAGAIN;
-
 	if (!zc->imported) {
 		zc->imported = true;
 		ret = io_send_zc_import(req, issue_flags);
 		if (unlikely(ret))
 			return ret;
 	}
 
+	if (!(req->flags & REQ_F_POLLED) &&
+	    (zc->flags & IORING_RECVSEND_POLL_FIRST))
+		return -EAGAIN;
+
 	msg_flags = zc->msg_flags;
 	if (issue_flags & IO_URING_F_NONBLOCK)
 		msg_flags |= MSG_DONTWAIT;
 	if (msg_flags & MSG_WAITALL)
 		min_ret = iov_iter_count(&kmsg->msg.msg_iter);
-- 
2.45.2


