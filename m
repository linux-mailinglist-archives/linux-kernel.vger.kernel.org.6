Return-Path: <linux-kernel+bounces-228632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1558C9162ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C535528A4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D86314A0AE;
	Tue, 25 Jun 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b="eO1NX8rI"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06FE1494D1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308444; cv=none; b=KrlfaHSLnB5XRrc5PLyBWLVpPjE/Q537Hr/lUJ8ljWROBdEvi+ZIkhpOHglEuVS7OtzM3RVMSf4A3cDNwyJlfQP6GAB77+BEjiII6tk7uf4Ci9LMVGCh/1Gvk8hR2Cr8O/ORBQ/XgO27jtfMmRJoOXGs/1x0xqEqf0Gh8h88mU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308444; c=relaxed/simple;
	bh=WaYg5klofIWABaqWjZk2c9l4oFnzkHgFeG9BFvcvXAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bT3gjVoUtMQc5luQbrgVbwxOUMv/ZqIl/awjpvPajVMQ7ZkQ5DBwm73v1basm59QaIEjgxDQzYNXXKaKv5HLC8P8oL7YA/1gFEKbp69uZJtcDrnSCcDjzx9pdCgQ18Fg0mr60/bISFi4z+WTTGeN4nYC4aQAmuEec9sHmONQRyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=cloud.com header.i=@cloud.com header.b=eO1NX8rI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70675977d0eso2101252b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1719308442; x=1719913242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4B1oeXyzx6eJDWzTUk9phcByQ/k/uCsNJ1COo/jc8Q=;
        b=eO1NX8rIKcQu5EMkAJXgyBuyppkEZ9UYhlBdIvOuO50DIoEQD2XyqNoN70oJdKSll6
         pOrH7wRviwJtD0kOGMn5glu6jE+Lsuwk+TXVdW67qetsTh74Lj9PbXnqnt5l2RKztMfk
         BzIZVRxEOWBsgQqVuL8PJb8e0mF4h2gnLFgrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719308442; x=1719913242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4B1oeXyzx6eJDWzTUk9phcByQ/k/uCsNJ1COo/jc8Q=;
        b=UJs3s8oJ0YldOLeBCzBzySQcpAkMFp/i8yqwqXl7bFzaJIZlGisn3daA8wNB9cb6Jr
         /QwjSzmdrLQE51uttPoFQibW57s1hwG9rWxBP///grltyfoC1b3dkdO0F/ASK4hHUyi/
         w9WY0okfEhOg8lbZWHcOqDdKnhLTSVbnte3mp0WRhf0W3gO/CzKqvDHYv82U8ez6u8Yp
         H/sxnZmGyJa5uvxdtwdaWCcIp4XR+q4yTK7iPuBeso686a9RzWQJqXYc5Oj++MLVDT1w
         kTWWvLFoEvEwwav6zzSGGX9uCXZlNBxYK7X4F1Zh3gS57exExN/c0vDDHEjNBlavf/gq
         z+6w==
X-Forwarded-Encrypted: i=1; AJvYcCV1GP38ldOW4Ln7AhZC7Kl6pV0zEii9LoDuzeS8NoKErv1Zk1lc5rnnnZSwMWh38O0cLbElOIvwJJpRVc06LmAdXv7LyXmRV++CDXRN
X-Gm-Message-State: AOJu0Yx5mGLCYv7xm1mrwT/bI+oCVb0cTV35niTsihlRhgB5vjyeG6Oj
	aG5u/IGsQEKK/aNRItoNBXkf921uGgqKLn7NTb8xGhmfm6IrZ21q0k3XektGWlU=
X-Google-Smtp-Source: AGHT+IFu172QjsdiL/zGnN/a5lVwXhLOTMqaW0Qcl895+4TiZn5leNklmHJ8SiddKN1zoAHC70XsTA==
X-Received: by 2002:aa7:8ecb:0:b0:706:57ce:f042 with SMTP id d2e1a72fcca58-7067455bfd2mr6173153b3a.7.1719308441567;
        Tue, 25 Jun 2024 02:40:41 -0700 (PDT)
Received: from localhost.localdomain ([154.91.3.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7067e71fa78sm3847194b3a.125.2024.06.25.02.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 02:40:41 -0700 (PDT)
From: Chunjie Zhu <chunjie.zhu@cloud.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chunjie Zhu <chunjie.zhu@cloud.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] revert "iomap: add support for dma aligned direct-io"
Date: Tue, 25 Jun 2024 09:38:51 +0000
Message-Id: <20240625093851.73331-1-chunjie.zhu@cloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit bf8d08532bc19a14cfb54ae61099dccadefca446 as it
causes applications unable to probe a consistent value for direct
io buffer alignment, see an example,

                                 buffer alignment: 512
                                          |
                                         ext3
                                          |
   buffer alignment: 4          lvm (dma_alignment: 511)
           |                              |
          xfs                       device mapper
           |                              |
         sda1                            sda2
           |                              |
           ---  sda (dma_alignment: 3)  ---

Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
---
 fs/iomap/direct-io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..448b563a634c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -277,7 +277,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 {
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
+	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
 	unsigned int fs_block_size = i_blocksize(inode), pad;
+	unsigned int align = iov_iter_alignment(dio->submit.iter);
 	loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
@@ -288,8 +290,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
+	if ((pos | length | align) & ((1 << blkbits) - 1))
 		return -EINVAL;
 
 	if (iomap->type == IOMAP_UNWRITTEN) {
-- 
2.34.1


