Return-Path: <linux-kernel+bounces-336896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC9E984240
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9A4282C42
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F34126C0B;
	Tue, 24 Sep 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk+4kwmR"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BF81ACA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170404; cv=none; b=IHwxgD+l6wtAdgwZbNS6cQoFl92vZ+WJv+OdelZo8NRIDzlaS0aPsesXcauLU6YoiD00LShNVEnmjI+0ewG+TY3jmHpFfn35J4IqSkRUAVVLv/ZWMCnf6jCB3VTb8GpVne9OIw3qVgj4KIt+VguIWKoZoqoxWgatmixVBtJ5t6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170404; c=relaxed/simple;
	bh=ybic+sCgpR/QC33pW8bXAKOWuMIhYF5HrHX0o9G9U2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IIbd4K6nRTTCj2nA6LK8UWGC8n9EXtQ0bFT3GgCjjIr/MYlV5cvxckT6Afb91+oNnf6bUx0FOniCmI81NchtFIiFyCZGQAWaocqp9UDegseq0k7XRjSkp/wE0yJqJvP9RCxryzjWhKgdInxXIEf5XVGPT382hnwGGakpFiIkkbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk+4kwmR; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso4153002a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727170402; x=1727775202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s9w2nHZP8l77rsPJ1L+c0ysp873CjxK+gREviiZn4r8=;
        b=Hk+4kwmRI0p6YY5hZCQexNDEHJP2sNqzvc4QtX3tkaK9vzQZfbSib1JGeO49sl5tTC
         8/n1FpJU6KOM0rONLN4UaRIHxyauEexNE7VPBahwYzmY8ApOiTNER6+XwCyJ499Ycy5Q
         HAlmA5L0IPVY5F8Mf3vazCDIOFq1fiSBYmiylrPq+t9EYLeCCkG/u1PrreUP4S65jd+z
         cZzL05DxmbhjlG57GCe6V9T+0PgQsgfI/f6TJkdi0093fO5PPoDjR8GCauUh/e5mm/qT
         gkFpf5PNPDI8pSTxFMuCKTTRPzl2Cv1IGid04+hFj5Njd3cIFf/eRk7U0DP54+iI+nru
         e8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727170402; x=1727775202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9w2nHZP8l77rsPJ1L+c0ysp873CjxK+gREviiZn4r8=;
        b=f8nhuakLaPOBtHzqfzX1cc9UtOY1Pwo6xQ5TIEMETu9dUh2wcac6JNPH2E5sDfpbhY
         K4QEPLG35bym9JPYGc4KFfsl7lPGbLDF//HLUny4Vm3MTxXEFb7XwXJTy9uKcZ2CXU1L
         f9KQ1dTxXeQtOJFW2iJeXrU27VVvOSyOuDkbfHwv+uAowxduiq3QKkSElpxSmHbOZsXG
         FlDpnPOUHK+D+Lb7HzqKFdhH82nxwM1X2G3oJkC1r+NI2V5ZLmZfRzLA264gVxReQxMr
         syJDYqK5mYYzxM19NJMU2e9X08vX2pRB61ThiR4ZjI2iH3aCHMvFksw/i+xBMdLBPxD4
         Zm/A==
X-Forwarded-Encrypted: i=1; AJvYcCVnE4xDT8m1Ms2h6ypUKnEz4iOUHPgSDk4FIxmWLPBR20zy6FmfGZUQTuITSP/+cNlzzLLCPOOaRYxsGfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt1suURRM1+6J6oTBSB9J6689qky6lLv7ZR5tvJJPBV4yVbJjv
	WyW6S+J0R2wskufh5+zGaZZXINH87BT1ZSXDNp+J2RWfHIeoT94f
X-Google-Smtp-Source: AGHT+IEUTmu8LdfTUocvphq1s92C+7rCJBcnIf+Z7si29T6cXZ28HH0iLRJbenbJAQ3LYa0z1dWdMw==
X-Received: by 2002:a17:90b:80c:b0:2d3:bc5e:8452 with SMTP id 98e67ed59e1d1-2dd7f71b8ebmr18331729a91.32.1727170402262;
        Tue, 24 Sep 2024 02:33:22 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef95903sm10818845a91.53.2024.09.24.02.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 02:33:21 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>,
	syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Subject: [PATCH v3] ocfs2: Fix deadlock in ocfs2_get_system_file_inode
Date: Tue, 24 Sep 2024 09:32:57 +0000
Message-ID: <20240924093257.7181-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot has found a possible deadlock in ocfs2_get_system_file_inode [1].

The scenario is depicted here,

	CPU0					CPU1
lock(&ocfs2_file_ip_alloc_sem_key);
                               lock(&osb->system_file_mutex);
                               lock(&ocfs2_file_ip_alloc_sem_key);
lock(&osb->system_file_mutex);

The function calls which could lead to this are:

CPU0
ocfs2_mknod - lock(&ocfs2_file_ip_alloc_sem_key);
.
.
.
ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);

CPU1 -
ocfs2_fill_super - lock(&osb->system_file_mutex);
.
.
.
ocfs2_read_virt_blocks - lock(&ocfs2_file_ip_alloc_sem_key);

This issue can be resolved by making the down_read -> down_read_try
in the ocfs2_read_virt_blocks.

[1] https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd

Reported-and-tested-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
v3:
- Removed multiple if conditions
---
 fs/ocfs2/extent_map.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 70a768b62..f7672472f 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -973,7 +973,13 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
 	}
 
 	while (done < nr) {
-		down_read(&OCFS2_I(inode)->ip_alloc_sem);
+		if (!down_read_trylock(&OCFS2_I(inode)->ip_alloc_sem)) {
+			rc = -EAGAIN;
+			mlog(ML_ERROR,
+				 "Inode #%llu ip_alloc_sem is temporarily unavailable\n",
+				 (unsigned long long)OCFS2_I(inode)->ip_blkno);
+			break;
+		}
 		rc = ocfs2_extent_map_get_blocks(inode, v_block + done,
 						 &p_block, &p_count, NULL);
 		up_read(&OCFS2_I(inode)->ip_alloc_sem);
-- 
2.46.0


