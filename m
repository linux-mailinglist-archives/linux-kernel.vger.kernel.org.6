Return-Path: <linux-kernel+bounces-539549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A22A4A5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F153175CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D531DE4C7;
	Fri, 28 Feb 2025 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DsZMDuky"
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10523F385
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740780923; cv=none; b=FDnjzdtBEQaqyZAsHcSoaJoEQIm+2gVID8G/WPotgLd/+xHu3rin+Z0KhnXLHmkcNc1bezYuzB/ER5mM0WtoENdQxugxxkS4NO95/nkdjnM2EwnYVteM4giiNSBXsdZpovSEEpXNSMqo3QRPLPNqCOUSREdbB/8Mjow0cPLXXEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740780923; c=relaxed/simple;
	bh=ZAtHRud4MMjlHTqigW4Ubbx0wxFM6EXdQHtTR6ONheE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JAyvukjgLw5bsGG3BFBbxulQHDXqJbYjR2wG2tDhKThgPBxq81v3OB+S4628qw4FHDuDTKqFJhgnAuqMUPWqUT4lawBpRPsqkOw6E2VX7h7tUbXz3ZTKRJCENrsPE79KdmmyXS8YjIZDJjhzH9hBhGHPEeKK/mouDMKtKmVBTHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DsZMDuky; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-2a94159cd5cso261980fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740780921; x=1741385721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Cir2LSQzIhQDWFjN8hKDuCrYLHrrp3l+4avtAPTWII=;
        b=DsZMDukylVBXBYixsPO3AVJogk6Z+i0s8g5ff9WKGxAp2zho4cOp9MIhVJPSA85M7o
         uoxA+Ku7a4JGO39SoLVYa3mLwLjpiaMiIUr5oYJ7erUhW97/0kapfNGCeq8oi1cXSp+K
         DBezCezY/hs+haOoJmsozhu6/FIqRa15Tue6OaHT+ElgH6A+/Ns/K4DpILPK1VHpuNcN
         9SdWRcSQkoYbF2I/yin0pb9DMJxgbZutCmu5WDa5FUd6K20oemzjG1Hs/a95KOmVQa8y
         ZxnOrR6mDe42cUAwyU4YCbgJ5ZEB9DKG3xmbrjf3H13ukhc2jPfW9tazWOgA2GIbCCNv
         P83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740780921; x=1741385721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Cir2LSQzIhQDWFjN8hKDuCrYLHrrp3l+4avtAPTWII=;
        b=vWayFyb0UtvSgm8UZSmAlbTR17YN0P2S6AYFGHSSg5lxwpGruiTeeeka2Q7VNzE0Ag
         ErmTNDnZ1B1WOFhwPryiWGrGbcbA93wYHHWrIg0y0x6hS1NtWACa2z9kD4GMhVkgfu2F
         BspaSRbvmjkizf3/KZ7Xn++JmrWh22QmluGOseI8HgvM7xWeb8GRAMn4yANPo84fjjXD
         uw+pgtiXM6C9+xss3Cj1VClUNTf9nFnOViDvrdG6/CdrwCAh+UXAVMicLb8NKONHv+JM
         o5VA5CEi9m7CfWeaH3WpeMGbKxI69JV3G7HF2QNYUfQv7eisBz8NgLT1MZZozAmvNgaU
         pg/g==
X-Forwarded-Encrypted: i=1; AJvYcCXvk5XiQoEGU9fwQ5KWzPdb8v6OruzVQK9yQO3lmgxJ2SUrtfseRxcQE1KLBZaSatGyKs/91LUadCP0t1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5sDAwPr7t59tspKzTcO8rsh5Chsmwp+3167Cl+Bm6kJ/9M35F
	EuI7iGXFl2lpkqYVNTDczasWLp70WvrxMazQYFrPubpSt/J3dOZTrW6PDfwnCGlCgz3WEboDNwK
	D30GBNjRoQjMkpN4VS3/gqU3cZMJ7/MJ5
X-Gm-Gg: ASbGncvZ36c6EJ8ff/hvxEEAPgo6VkaqQUfFcxE4D0vQStckuXhhWWzhXK1WR/h38if
	rNBwkSj1RdM9xYajpHBmcvE777aerG3OWIouLKjPlcOgdvr+fGXkz2oiGng1N/wRckXxEeHeXOr
	h1PYhzDDV1oQKpz30+JptyIK2rGqWnIC7x98Z/0wXVbYIJKNXUkYqVnHfzVTpbhOubWg81NvuBM
	d8Ms5tCuuF4g58usMGwO6HRmBf4eoT2iXbBLhG12fMG5slDD8m/UzZ+SodTaRGb3BeLq2Fu5iv6
	jsiTfmNXyuwJ/RxauzKFg74hm15V1CG8RmjJdRwmby7+bcI6
X-Google-Smtp-Source: AGHT+IGM7zr5Q3iNiBBpZHeO1Fl1xOII9V2n1xyulg7j5Ht02fikpB49bBxs9S7F0Qpw0HhV5WokJdEjU5LZ
X-Received: by 2002:a05:6870:1707:b0:29e:5f79:21b4 with SMTP id 586e51a60fabf-2c178715fdemr1125824fac.13.1740780920913;
        Fri, 28 Feb 2025 14:15:20 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c15c568f0esm229187fac.41.2025.02.28.14.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 14:15:20 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id DD08F34028F;
	Fri, 28 Feb 2025 15:15:19 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CD5AAE419C2; Fri, 28 Feb 2025 15:15:19 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/uring_cmd: specify io_uring_cmd_import_fixed() pointer type
Date: Fri, 28 Feb 2025 15:15:13 -0700
Message-ID: <20250228221514.604350-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring_cmd_import_fixed() takes a struct io_uring_cmd *, but the type
of the ioucmd parameter is void *. Make the pointer type explicit so the
compiler can type check it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/io_uring/cmd.h | 10 ++++++----
 io_uring/uring_cmd.c         |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index cf8d80d84734..5bc4f0d58506 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -38,11 +38,12 @@ static inline void io_uring_cmd_private_sz_check(size_t cmd_sz)
 	((pdu_type *)&(cmd)->pdu) \
 )
 
 #if defined(CONFIG_IO_URING)
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
-			      struct iov_iter *iter, void *ioucmd,
+			      struct iov_iter *iter,
+			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags);
 
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
@@ -66,13 +67,14 @@ void io_uring_cmd_mark_cancelable(struct io_uring_cmd *cmd,
 
 /* Execute the request from a blocking context */
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd);
 
 #else
-static inline int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
-			      struct iov_iter *iter, void *ioucmd,
-			      unsigned int issue_flags)
+static inline int
+io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
+			  struct iov_iter *iter, struct io_uring_cmd *ioucmd,
+			  unsigned int issue_flags)
 {
 	return -EOPNOTSUPP;
 }
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		u64 ret2, unsigned issue_flags)
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 31d5e0948af1..de39b602aa82 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -243,11 +243,12 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 	io_req_set_res(req, ret, 0);
 	return IOU_OK;
 }
 
 int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
-			      struct iov_iter *iter, void *ioucmd,
+			      struct iov_iter *iter,
+			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
 
 	return io_import_reg_buf(req, iter, ubuf, len, rw, issue_flags);
-- 
2.45.2


