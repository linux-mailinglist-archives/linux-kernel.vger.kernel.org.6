Return-Path: <linux-kernel+bounces-564294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A79AA6520F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E3C17638C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4266245011;
	Mon, 17 Mar 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="DzF7VrMR"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C6242924
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742219884; cv=none; b=JElXMlsefhA8FejvUvYYabNBJSzKsdUrkM2JhN4wqAWoNTThg4kB06sB8wQrHTlzlQBE7fN2euS+eNLckxopI6591ehZTX4Qa9ZrmqyWzoR3c+DULrbaUiD/nXjUYBep1Qx9ebP01UxD3CI6TLZSBfnqtZUiIHEYWzsnJwecr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742219884; c=relaxed/simple;
	bh=r1Vjqf1oCP/p83aYpJWj+A3gopug7Rxe//nacHp5G/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8GfVVRQJdjefVsoF1sr5VxCF5PTQNdjYLm2zZG0BqX3vffOMmX8eWKgJ3P1ZoYhff9YRAZL00NpA8Bf3eLqIiGW7caUGNSGU6IcW8tESqrp/Eo5XdGQsRlcJD3mZZ5n82OlWbycudyrypo60t1dqZcfyW29djMLGs8N9OVBz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=DzF7VrMR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so2321994a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1742219882; x=1742824682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7fOqEAGiDFRx1EvcNylApPOY9CX77o6NfjwJaTL4ZI=;
        b=DzF7VrMRZRL8DfFJrTsfEAVU7WbBBNneR2QRK0SEqzTJfYSC/W7eJgqsj7y59YH9a7
         0DWz4hUEuZ6iy3SASnFtgukSlwhIWBFBGAyALBw/pOVVlQGdnHF9lZfKVlHI5xZiS/Zz
         +eV8Dh3GS8HX9NYzeGu60LPJM+cqVPZCZJVVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742219882; x=1742824682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7fOqEAGiDFRx1EvcNylApPOY9CX77o6NfjwJaTL4ZI=;
        b=Ih8CuYMLAw1bzef4jTZDfMYVZds7cpRQ78FL8SupSbvHtNPs6FkLaiYuNywMk6ZzRa
         lPan9xxiGbvBAiOPnMFUSkGWu+Ip+aobR+GQFmGOmbX1McLRdd1laHh/VegJ7P8OMsXy
         8pGLTEtevApZXZAvLkmFotsYi6tmAgOqbOC4E9GfszYRNBBLHrDEhR16bG3wXIOyLg1p
         h91hbcNOCt7+RqYFuc/j1NsxeQpvg2mHtCmW5FEh9EcsLqk8/Bts5/o95EIh8SloxbRA
         vndX6POtezFT9OM6TgMBQr8i2ruGx8cVO33g/7/nKehjWmhQbscR0tSBP3xf/DV641fl
         +jKg==
X-Forwarded-Encrypted: i=1; AJvYcCUcsQWgFaIYpkFd9UW5Dq18E3/2QXkfEZc/SMzbfOG5LM6f1334+1189w4uZCl3zxLTAjPcHDgnXuZ0r8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBm6n4GnjnsQC1JY6/fJAp+nG8y2SSHMq0AltTMid9ch1RGVIo
	0/nuuJYJx2RzBpkHrZYCFLJgM//da9Em7pOCwJp12vxr97hRQSqaMc2Wrmh8r0I=
X-Gm-Gg: ASbGncsxfQtmPtsFi1Bz63qTPZ/MPwgcXfnsTdovlQNbou5KdV6n0g8zTb7xj5OY+TU
	omVJzW1bt+xhMl6Ymjgwqj923JRI9Jic5gQRhcqRrymUEDUcRE3INsUEAoT6/nLjd/SuLO/lDM3
	NwZelhR8ZH64kDGZoIeMRy/6nxJDIBfE2n/vnCpXYXTAfSNuEjIh0OmynbFSn3i3Azu+1VgDpME
	+yzGJkGn8lK47YY/pTG6QNHlBbb3GoP7F8dHKt1sXSDx71iz8AI85oBG6rPvkQVQajwXvCgrNT6
	FkzC5T8yqse2XaGUW/tn2P+Q3R5Avg+p96lRJ6FQBzMLRhVzcI/R1qrIs8vL9pgFzlIH8n/rkJk
	3kiOu
X-Google-Smtp-Source: AGHT+IEwHFUXeuCpBUyeil9Wg5Oba6oRQ9mFosTXz52ACT97GF4NSEeGLEXjUVwa2P9T2GloeiXqeQ==
X-Received: by 2002:a17:90b:520e:b0:2fe:baa3:b8b9 with SMTP id 98e67ed59e1d1-30151cb4009mr15615142a91.4.1742219882048;
        Mon, 17 Mar 2025 06:58:02 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153b99508sm5993742a91.39.2025.03.17.06.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:58:01 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Sidong Yang <sidong.yang@furiosa.ai>
Subject: [RFC PATCH v4 3/5] io-uring/cmd: introduce io_uring_cmd_import_fixed_vec
Date: Mon, 17 Mar 2025 13:57:40 +0000
Message-ID: <20250317135742.4331-4-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250317135742.4331-1-sidong.yang@furiosa.ai>
References: <20250317135742.4331-1-sidong.yang@furiosa.ai>
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
 io_uring/uring_cmd.c         | 19 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
index 598cacda4aa3..ab7ecef60787 100644
--- a/include/linux/io_uring/cmd.h
+++ b/include/linux/io_uring/cmd.h
@@ -44,6 +44,12 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 			      struct io_uring_cmd *ioucmd,
 			      unsigned int issue_flags);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  unsigned long uvec_segs, int ddir,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter);
+
 /*
  * Completes the request, i.e. posts an io_uring CQE and deallocates @ioucmd
  * and the corresponding io_uring request.
@@ -76,6 +82,14 @@ io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 {
 	return -EOPNOTSUPP;
 }
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  unsigned long uvec_segs, int ddir,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter)
+{
+	return -EOPNOTSUPP;
+}
 static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
 		u64 ret2, unsigned issue_flags)
 {
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index bf4002e93ec5..effcd01b8a35 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -274,6 +274,25 @@ int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
 }
 EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed);
 
+int io_uring_cmd_import_fixed_vec(struct io_uring_cmd *ioucmd,
+				  const struct iovec __user *uvec,
+				  unsigned long uvec_segs, int ddir,
+				  unsigned int issue_flags,
+				  struct iov_iter *iter)
+{
+	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
+	struct io_async_cmd *ac = req->async_data;
+	int ret;
+
+	ret = io_prep_reg_iovec(req, &ac->iou_vec, uvec, uvec_segs);
+	if (ret)
+		return ret;
+
+	return io_import_reg_vec(ddir, iter, req, &ac->iou_vec, ac->iou_vec.nr,
+				 issue_flags);
+}
+EXPORT_SYMBOL_GPL(io_uring_cmd_import_fixed_vec);
+
 void io_uring_cmd_issue_blocking(struct io_uring_cmd *ioucmd)
 {
 	struct io_kiocb *req = cmd_to_io_kiocb(ioucmd);
-- 
2.43.0


