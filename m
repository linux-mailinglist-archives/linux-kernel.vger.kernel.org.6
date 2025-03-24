Return-Path: <linux-kernel+bounces-573910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB438A6DDEA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510F116AF2E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8984425FA3C;
	Mon, 24 Mar 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="D2oBLnXO"
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619CC25E45A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829125; cv=none; b=RBaNbIf5TwNIPqmxMOuQz+5TWSlyUj2EOqLNxY2cFw4IgUWXndECDttfYw3JAec0gI6PcszgvxnF4eK9AEy1V6PfVcwaLR6aJRFdP7cDui9wjBBOxbj8HAV6IBEceNMqvFqNdbPiHZYPpNOpOoEpwwb9YIMqNpzt6uFRtbfptC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829125; c=relaxed/simple;
	bh=6PyiGn4SiEiCYGvy1jMGKDenohF/ERsQojmyCgoW04c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMxBI5Nyy2eJ9Ln7+HA5TAVK6dBr80LcL2sI0imyYSUeoS9CDzzgwSvGu3mfB3UUDRUW0KnE6qgO4ZEo1n93MPNKIzKEPNKUGIGzX9cDPdkZsU33NCefGHE+ZNjO12ssyENXwOYnGU7jeru/gFB0DYMdNAcbQh7NPlF2oSEMQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=D2oBLnXO; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-85dc8b74a93so14931039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742829122; x=1743433922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/DaDTHAl/xpFy64mz/KVdnuIp1nPGqaX22/7mVtls3M=;
        b=D2oBLnXOREGQCWL5no2MErDlkJBvVi81X3KLd4ARXPo4UPzPll96+9EBFr6Ft/62Cg
         HxrRogJV73TuVhLDHA3IZoYal8NwvU9SMmSaNG02E7FKNhGfCo8aO9pgUGQQFsNRJNCV
         OYPdbZsmBEO3lH+aUH5BWQk3YwM2c0NSqM9x/N6fXKVQY95zG/LGgA2bHvzg26Th2jCg
         XYo04wNq8b/EQlgXKtaiMFcTiC4Qssua6Vpt8UBTuDuUZxv0uYZieiNv4Pu8FpNtYsKo
         0mb0X9UYP5Yw+OYiF67/PQ1tq5DsZEIrS8AgqbbblEj2iWpKu0LlgBSCuwuxf52hmEdj
         mZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742829122; x=1743433922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DaDTHAl/xpFy64mz/KVdnuIp1nPGqaX22/7mVtls3M=;
        b=RJk7UNm2gBWW9CcaypbhHDa1Bc94m6oufezF/sauUeCR/AuoWmfJ9bkqAmf06FlWYa
         V4mv4jvKvbu/4D4kYBc0jxmYLT1gNNkg70WT8np1jvGkTp361glJOsvH35xyUaPRx3lY
         3lfLmySHQ0koq/hl6F0Cnh9SvtqmzokFpxcaBNxiBe+nmqWNnXMg3X5X6CKoL+Kh8PXx
         vhAa8ru0/U1lrGNRvzXN1xgnNv7xJViuy7w9fvZ7TKvtPQoT7ILK3mPo2RtrAmacDGD8
         iyppbU8G9G4SdVm6Cjiimu1hj8cKNLtOia9Ru9k9dEfmwxob8kcAM6PhzZyUX/7k92c6
         QmcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg4oxAn5zzP6sUS6vTr+w5QRunXDX6FAvet8Vwpj+b/eDc9cugs83lksZLMSWE5saKF42TwZfbukvX/bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp8N70qkV5ppfnCkZjetLuLntfys4NrF28MfyR/aH4xY58AE2R
	M00tzxyV3QyCF1l9g2wuPm91LANU7MErBrhv4OX/1NrHNLWp2PbrQ1X42Kx5kR1rjt2cfsvUkar
	FieF6eYfrYPMCIqf5ZaV8uPwGddSa+OEdsTDq9qm+h4dIm3Jg
X-Gm-Gg: ASbGnctHCMzzdAlh3+cui2AoW7ZpzevoB4h805+o+vzjVEjX2SgN+swb4xmyxU1ATdo
	YA+KQwZzNpF1QggYY+yfOPvGlmBt/E9BDgieasQweXJTIrHP5RzmLLwmJPW1NLAfUfYFcPS7kzD
	4l088oX6p5m1Gu4SFCMgZiLeQ1xUbFB5bX5b1J8wmNinqqwTX9n+vA/3wZ9nUrsJIqavQ5QCA8r
	pIrGegBJWxngr/fUuo2dc7+2DBLC4h5RpZpFs5L+JkAyPIJwbiZ5nsav2l+We1P9lVWf7e6knAk
	2+wfpv/BIp+roXArj7pwCISz+GyFZxAUwQ==
X-Google-Smtp-Source: AGHT+IEvGhdaNr00BzWWE+mFFMquDvVXhD7sNzqsigex3tx68oVgpBapaJD6isuNNk8GdMEGzNSPd+kJk7na
X-Received: by 2002:a05:6e02:1c25:b0:3d5:8928:20e3 with SMTP id e9e14a558f8ab-3d5960bf9d3mr38272455ab.2.1742829122158;
        Mon, 24 Mar 2025 08:12:02 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d59607f822sm3708795ab.17.2025.03.24.08.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 08:12:02 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3EC3B3400DB;
	Mon, 24 Mar 2025 09:12:01 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 31926E41921; Mon, 24 Mar 2025 09:11:31 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/net: use REQ_F_IMPORT_BUFFER for send_zc
Date: Mon, 24 Mar 2025 09:11:21 -0600
Message-ID: <20250324151123.726124-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of a bool field in struct io_sr_msg, use REQ_F_IMPORT_BUFFER to
track whether io_send_zc() has already imported the buffer. This flag
already serves a similar purpose for sendmsg_zc and {read,write}v_fixed.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/io_uring_types.h | 5 ++++-
 io_uring/net.c                 | 8 +++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index c17d2eedf478..699e2c0895ae 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -583,11 +583,14 @@ enum {
 	REQ_F_BUFFERS_COMMIT	= IO_REQ_FLAG(REQ_F_BUFFERS_COMMIT_BIT),
 	/* buf node is valid */
 	REQ_F_BUF_NODE		= IO_REQ_FLAG(REQ_F_BUF_NODE_BIT),
 	/* request has read/write metadata assigned */
 	REQ_F_HAS_METADATA	= IO_REQ_FLAG(REQ_F_HAS_METADATA_BIT),
-	/* resolve padded iovec to registered buffers */
+	/*
+	 * For vectored fixed buffers, resolve iovec to registered buffers.
+	 * For SEND_ZC, whether to import buffers (i.e. the first issue).
+	 */
 	REQ_F_IMPORT_BUFFER	= IO_REQ_FLAG(REQ_F_IMPORT_BUFFER_BIT),
 };
 
 typedef void (*io_req_tw_func_t)(struct io_kiocb *req, io_tw_token_t tw);
 
diff --git a/io_uring/net.c b/io_uring/net.c
index c87af980b98e..b221abe2600e 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -75,11 +75,10 @@ struct io_sr_msg {
 	unsigned			nr_multishot_loops;
 	u16				flags;
 	/* initialised and used only by !msg send variants */
 	u16				buf_group;
 	bool				retry;
-	bool				imported; /* only for io_send_zc */
 	void __user			*msg_control;
 	/* used only for send zerocopy */
 	struct io_kiocb 		*notif;
 };
 
@@ -1305,12 +1304,11 @@ int io_send_zc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *notif;
 
 	zc->done_io = 0;
 	zc->retry = false;
-	zc->imported = false;
-	req->flags |= REQ_F_POLL_NO_LAZY;
+	req->flags |= REQ_F_POLL_NO_LAZY | REQ_F_IMPORT_BUFFER;
 
 	if (unlikely(READ_ONCE(sqe->__pad2[0]) || READ_ONCE(sqe->addr3)))
 		return -EINVAL;
 	/* we don't support IOSQE_CQE_SKIP_SUCCESS just yet */
 	if (req->flags & REQ_F_CQE_SKIP)
@@ -1447,12 +1445,12 @@ int io_send_zc(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(!sock))
 		return -ENOTSOCK;
 	if (!test_bit(SOCK_SUPPORT_ZC, &sock->flags))
 		return -EOPNOTSUPP;
 
-	if (!zc->imported) {
-		zc->imported = true;
+	if (req->flags & REQ_F_IMPORT_BUFFER) {
+		req->flags &= ~REQ_F_IMPORT_BUFFER;
 		ret = io_send_zc_import(req, issue_flags);
 		if (unlikely(ret))
 			return ret;
 	}
 
-- 
2.45.2


