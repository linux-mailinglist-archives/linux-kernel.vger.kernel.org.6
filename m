Return-Path: <linux-kernel+bounces-557868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96388A5DEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB33B170D16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DB824EF97;
	Wed, 12 Mar 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="VpC7xg30"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8751E24635E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789446; cv=none; b=ffxcaJ3B4f8BY2yzLJ2Ro4wh9p+eNrE4m2TWdpiM83Jlwhn2IRh23oTPCF1B30wbFTOj2L9aIOclW3C67PQazg6y+TL/YJWV1JXexaj0Y20b0ufjuJtivqPQHD9jALKIEYT5a94rcgEwz2J0fZeCFw4v5SQmDwOGb5mUofOqaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789446; c=relaxed/simple;
	bh=ueLLfb2g6ooAKzkCZNWnsaYYsRz9CK6dnjSm/F8mDd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTgxEDWZQHm7/xjI2e96x8YPvfPofpIZrA7tNPlamVJ6FLxj2aHzOzf14WlcgECnHfgIQMceLQrQeZf9c1SdTdr0fYxyXcgWRnYKjSfkxyqSkPyS3+lZ6k39jov7BniwsWU0dF1p6jqHyG4LAqsHWsLDIpTaQ5ORFKCQLWbyGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=VpC7xg30; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22548a28d0cso47988275ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741789445; x=1742394245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xE5xU4H97yAwT+GSMKnaXD9mzHnmpKqghu02U5UNnw=;
        b=VpC7xg30l1h4FAr8iEL6sODXobJWIdIyvkZ1BftrdM+DwlLEdrzR39EZulh7SFpX+b
         3zHRWQU798dj6mW5iKFwvkED+t6wPj16rdSVFPWvwcVgYuVKko4+hmhax2kilYLgQmfw
         rtboAnV4b0ivyBMYS7zHQ3QTXjJAgCzXCbG2eNtSbO4xf0vak15Rq1WjkPUjqrqsE1TC
         5T007ewHZr7tW3+aN3qpGTmic8aKdWf+KUnIKvyFe5GEi3UMvRfo5AmFyfwEpSrWusMH
         Wbw0T5cAe3XdiyrcGh6pEdscd+g9Y2OAsr6DgLWBm9MsyyvutjcyH9bCepgGwFd/yXnI
         j0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789445; x=1742394245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xE5xU4H97yAwT+GSMKnaXD9mzHnmpKqghu02U5UNnw=;
        b=bn9woPNR+sIsz6549ot1hOdq1E8EvlYNJsWyTaT90Xp+0THIs/uMQe7FMDBYm9odwc
         542KnFS827hUBSTan4E1BVCXFsCewcJzPw1aVYK0G+vX7FsU8ZqNXYGzi9dpRzPG+f3W
         0o3NneBPT/Pv2nCw6da+RkIIZWynfBqT1mFOVrMnDzdJDwUUN2bLkZoFjlgGh46Z6dnI
         JWofEKxmHoy3EP9v2DwzqbTluXV8LMsMkJWy/JzuRKhiqvDQJbilnsIznx4jM4Wy8WSk
         IkrMGLW+VQg5KjMLhfOXSzjZegJ38iBJWfB0trj/fSaenZX43Y/HbSbgEqDe9jss1UM9
         UnDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcDxNCBMmB3uvftsp8zzmWqT/hTqxEXLp+bgEjWsPsY9QxmegX24GkpxEm3CYYdckRmAGLmxLRw0ZXi3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmsD5p3AahM22XBu87o+gqlK8ZMZ+usr1xLPBRT01pai+tp1Xt
	PX8fF18Nn/elWvoEGGd4iMdCcNLWt4it+iiX/FNc3TI3ULXNWM/3Ou6TiTkj9GI=
X-Gm-Gg: ASbGncvtTklJHyOOHi3sbGsazIpt/3qG/upuyRjmQrK7GurZ4pqlcJBvcAEKtgM/Xlt
	IbmAuwLBv3s7LOhegfZvFCmJw5/sFzqwP0RxsyDc8spGgB5gpEvdXz/MFXn8WEVHzDttNkEzXQJ
	hrc7cmT76VUCT4S2k8SDWJJd6vFvIu8/IswJmEQZOxVflC462B0UxvUlGb0P5ckDMou4rlKZ+8M
	HI3lQZR68FncSUb8roRB14206vQ2fzJhBmxXXh83R7tmF+Z0g3a2IThotbEaYwUmXB1y6/esxy7
	gLh5Z0IU9+ZOj2FMEJdrwxXPbLUHBrPj023yXODimrS39twwXTyPBbSaIBlIU0u3epAZ2bAjchN
	4eU+N
X-Google-Smtp-Source: AGHT+IEFkanN727wtkiJd8Cv9m0pOpd+cskICbFK6tPN+bU3UWDrxWUgeUfFa42vbUkQzGost6P7tw==
X-Received: by 2002:a05:6a00:174c:b0:736:9f20:a16c with SMTP id d2e1a72fcca58-736aa9e96e1mr28852100b3a.5.1741789444707;
        Wed, 12 Mar 2025 07:24:04 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cc972eabsm7413860b3a.144.2025.03.12.07.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:24:04 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v2 1/2] io_uring: cmd: introduce io_uring_cmd_import_fixed_vec
Date: Wed, 12 Mar 2025 14:23:25 +0000
Message-ID: <20250312142326.11660-2-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312142326.11660-1-sidong.yang@furiosa.ai>
References: <20250312142326.11660-1-sidong.yang@furiosa.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring_cmd_import_fixed_vec() could be used for using multiple
fixed buffer in uring_cmd callback.

Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
---
 include/linux/io_uring/cmd.h | 14 ++++++++++++++
 io_uring/uring_cmd.c         | 31 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 598cacda4aa3..b0e09c685941 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -44,6 +44,12 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uiovec,
+				  unsigned long nr_segs, int rw,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter, struct bio_vec **bvec);
+
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
@@ -76,6 +82,14 @@ io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 {
 	return -EOPNOTSUPP;
 }
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uiovec,
+				  unsigned long nr_segs, int rw,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter, struct bio_vec **bvec);
+{
+	return -EOPNOTSUPP;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		u64 ret2, unsigned issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index de39b602aa82..6bf076f45e6a 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "linux/io_uring_types.h"
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/file.h>
@@ -255,6 +256,36 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uiovec,
+				  unsigned long nr_segs, int rw,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter, struct bio_vec **bvec)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	struct iovec *iov;
+	int ret;
+	bool is_compat = io_is_compat(req->ctx);
+	struct iou_vec iou_vec;
+
+	if (!bvec)
+		return -EINVAL;
+
+	iov = iovec_from_user(uiovec, nr_segs, 0, NULL, is_compat);
+	if (IS_ERR(iov))
+		return PTR_ERR(iov);
+
+	iou_vec.iovec = iov;
+	iou_vec.nr = nr_segs;
+
+	ret = io_import_reg_vec(rw, iter, req, &iou_vec, iou_vec.nr, 0,
+				issue_flags);
+
+	*bvec = iou_vec.bvec;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
-- 
2.43.0


