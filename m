Return-Path: <linux-kernel+bounces-539573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD63A4A5EE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271B2177410
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230371DE2B9;
	Fri, 28 Feb 2025 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZqvA/69B"
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C014375D
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781893; cv=none; b=YnY2N7erVe/VPgecopfbzyblHJl927tPbW2sgMJU7Z9Y2ehiQDV6cR10tiyzwwKLT0XjFDRTRyLbhA1QJQO0EtDjvvZsXdojbNPKrNRUIu5CZRgf0tiVR8Asadx1peFNoFPD8Av+nEPdbk+7ee3VwC5pZYFIoazAicGzz7/4onY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781893; c=relaxed/simple;
	bh=doQuaoN9u7OELR40CVjM5Wacan+eeA7kQjC+1Mvrbao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TOmXwsFaclPOrvZ3Ejh+rS3D+UM+yWfI6aNjVc9JO9rkjLYrm9XBQRsB/HKzu4M/VGJRhuI02jveE1k98imnTHSa35nAReYsJRiDN4ylM/g7c06y4JuNUZYxnzmlolKHcsty8F8M/udy1Y7EDIVCI2EHqlR/3LC7m7QMg6wDI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZqvA/69B; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-844cffa4f9dso6921739f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740781890; x=1741386690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+2T1gHynTazYnP2hzcbY2sNMNgTOV0NNTMpa17eKN4U=;
        b=ZqvA/69BIeuGmkQ2dhlqb5mb0DpkRhOvF40MHhBd/xFHRLoKsJar6wuYLdKjhlr/be
         /fUc96MHmEmvUTnFy5yhGv9StY2PaNrQ23P0/5FM/M6uprBBSBfgI8wk1YtVC+/IEMWL
         tvwEj65CKNaYgVoc/i/uj3DxLrFt60iIZLl6DDmwFjBlhRa1wGPbJcEjJSLHh1x1VGzE
         HBtSdvEFuzEsG1uo4GcvDPt3mS3Vm1njBRnzV6iaj23/7ekvl9qUeSTShe0X6lfbVfLO
         HPwlsiLVLjaM9tXcd3wdBJX5JHpwh1FMVusrJ7/sQ+6+kim4/VVnjyFA0Ql9HZz8Qjd7
         wuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781890; x=1741386690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2T1gHynTazYnP2hzcbY2sNMNgTOV0NNTMpa17eKN4U=;
        b=ZrK6L1KDRPT8JCXHDxWV5P/fSlfICbgy4uMHb1ZPdL/Ohlgg3gYRoE2C0KZ9T/JUaz
         SyL0xq438T/ThibgKkxz6OLgylEF7BBYYhTnnr6lvdXzrIqSg97iUCjGyggNMhWZQYii
         ZJ8aLloSe4FGRlZh8nsSg1euBdClRn5qs2MrAeFzZduSxTM7FQo1Ynb8M2PTOWp8ihcS
         sGEbUvPgMO42c98V01PQ+HkaftVD7NnPRAFpY5NDQO83lkALRAmQArNZ/0cpR+Z/YUYa
         O1TLPoo4dRbFrmdS5IOWXlJn35YX4+xV4SgqjMbEsxj8xuaFnox0lwRCbtHR9X0uy7v8
         ZRgA==
X-Forwarded-Encrypted: i=1; AJvYcCVTAxe3fefCNoKe7DdTc2ukKLUBEaN7CHigYaGxskXQ9w1wW7WbfgBAvQ6Hf3U9ATH2kkX/BaxwFE5+TTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1C9lVhM0PkmwdKaqOiIFUhygCFA4qF8Me9wMwOgk2+23/NPp
	/B++HGy6gZbawMOlCOjhCfQhgcuWiOq0YpatxyyG42DofB/PpfQzhKCi5NdbaGNQP/CLqkF4dE1
	Ec9RU0MT+npLRqrlRF0zGdiQJNhUT1cFm
X-Gm-Gg: ASbGncvu+eYMU8MgH+hiSeP3rYHMBZmvzzwWwuiHa3Q/Uz8g1ea6nggYdiOu93+ZcL8
	5LKlPKioXC7b4TULKYHdsH+TBgkBKQ4MgMPw/N4R1MZgLpbssHnpUz9uY5WH/cWpLymhRFS73fL
	6/zEM3blm2E4HrtlzwI8qSL4aeo7Lc4FhHaqHuBFX6QpljAMCouRDdhes/+gIGSQdrSGr0miti9
	L9CnO0boCkhWhgCFRZartmV63wp98hdn0JpFX+t71xghQappIYsO9hRC2mF7oUH6x4IkKtgMtEb
	i0G3ntDUJV5KW+Z0ibsWeNU4T9XB6tv7PluvlG/Vk4gg9CYG
X-Google-Smtp-Source: AGHT+IGlrTCdO8WZvksVSjTwN72/t2bqEU9x93lBJ54pXZl2ReyCbDq7nfRgjsOsu7MOcrYaXpdeJCTb1pEd
X-Received: by 2002:a05:6602:1490:b0:855:c259:70e1 with SMTP id ca18e2360f4ac-85881df0152mr149012839f.0.1740781890680;
        Fri, 28 Feb 2025 14:31:30 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-85875116281sm25664539f.7.2025.02.28.14.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 14:31:30 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CEAC934028F;
	Fri, 28 Feb 2025 15:31:29 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BA052E419FF; Fri, 28 Feb 2025 15:30:59 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/rsrc: use rq_data_dir() to compute bvec dir
Date: Fri, 28 Feb 2025 15:30:56 -0700
Message-ID: <20250228223057.615284-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro rq_data_dir() already computes a request's data direction.
Use it in place of the if-else to set imu->dir.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 45bfb37bca1e..3107a03d56b8 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -957,15 +957,11 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	imu->nr_bvecs = nr_bvecs;
 	refcount_set(&imu->refs, 1);
 	imu->release = release;
 	imu->priv = rq;
 	imu->is_kbuf = true;
-
-	if (op_is_write(req_op(rq)))
-		imu->dir = IO_IMU_SOURCE;
-	else
-		imu->dir = IO_IMU_DEST;
+	imu->dir = 1 << rq_data_dir(rq);
 
 	bvec = imu->bvec;
 	rq_for_each_bvec(bv, rq, rq_iter)
 		*bvec++ = bv;
 
-- 
2.45.2


