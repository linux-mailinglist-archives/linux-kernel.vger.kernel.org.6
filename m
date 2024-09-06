Return-Path: <linux-kernel+bounces-319520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 217D296FDD8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 00:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8A91C21BE3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37D15A87F;
	Fri,  6 Sep 2024 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN17R/br"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3E14883B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725660779; cv=none; b=TZv9O2HEeGMOEtaSOpI0VDuTRHn/IokoQsCrlFD8VMGOT8YcxjqcUrOVa7az+g1ws0T7UfFflkvk0mv4em2tMxtaZrxzgFnowR4I0fiZcjZGRiLjpIivOrEmrp/L5Uub8QdCU3zlG9+h1p9b/oozP9YB5Xca1kbmuSZhuimaB8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725660779; c=relaxed/simple;
	bh=vC2jlXeWZrkHd67rtbyK0b0IevP8+AsDT09vOfr11qI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M+J5612a+huo1wbQHvTSPJ87KZFtQ84yxIrpJiULnKt6gNr9HC00LrbpxgvQMBtV+GMkK9jfe3TrVA/uHxL4/zI6+/5e8+OgRUcttHNrOBMqP8l5ClliGMJ+9ocC7nZ5Ft4QlYW0H6aQDjMGF6hy6xglE6JPS1B6/TR2nhhRCu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN17R/br; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-717914d6c95so1674143b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725660778; x=1726265578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NlEhQbcrtuiKn41rbnp2orLFJEhAmkBROEPy0RN6ODk=;
        b=MN17R/brlECwr3X6hhsRp+EzW9BUglI7wgpfhO0aPZU9HZ+4PXjg0pf9McXL4wlrpj
         gB6cxfuFwtDWaqQWHWPqYOjlyvCVwx/NzEOLviBtuG6NNUcfMme+r8I0b9RX+Ue/TV5p
         ybYhm3bIjh6qlRqXOYpA/ogfbdh+LHCax7SzTSFKyapenLeQcIFyV+Uk75syIvwEOWX3
         1gIgFsSEz65J8kQr+zgTE4Vj9fJyLETqYB0H/GVu9yQZmBxtVgMUh2DtAXYMS1KlWqAw
         HjufRuwpYK9lf956dSHjm9nX3XpMfy+qFWIMga8iCxx4890XmkYrG7mM2INUnS0ilT8e
         zx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725660778; x=1726265578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NlEhQbcrtuiKn41rbnp2orLFJEhAmkBROEPy0RN6ODk=;
        b=Gwrt4gSpDN2P3uks7qo2yB5eQzqlu35Qp61bWWAuIhMAFkUzrt7rwZeLSnkSVJJyuC
         gTuA251FarbjVGmmRoMLDcjpeJA5x2JxyvEd4VoBjl5MpLOefZrFVfCvcw7P+4PHI8P4
         JlrLaJARqe6HrsDkBn/mqHlOLAIwTlAXnsc4jhlEQqXbSvJj5PdLmxIrIDJWJ5UYpK0Y
         915PpEBOn5H+MvSm6xvLJ3y4fAiZaV5eqR/civDTe5Ho3sVJJFNAt0P02DnXRkXAUPc1
         U8QMUSSv8bc/yETAkoKxmBPpwJCyCf918jWQQgRRaPb08J+2Zx6BBnWpjsL+pBVadlQC
         6QbA==
X-Forwarded-Encrypted: i=1; AJvYcCVTlzJq0rDTD/W2JS3rl1cW1SeWSs1kPRQdB+TUP3WdVe0jCQnhxLjjmJhkmVZ8DyWNEFO1KLGN4VDXX/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXzVX1YgReYMWdYsOeokRU9IWcm3em2G9wt+fyTN7cR0uUcUG
	8E1I4BXOLMHT0AWP0iiMXInRYZc2WKBKwP4ctaQJ2nViUGhsv9u2lYEp4Eo1
X-Google-Smtp-Source: AGHT+IHzXyCRUhCCBbe80Dj6g97lXpPOvAy5LlL8HhBXDrgzfOw0Sxs5IjLy0ckCz+8zztvbUszXzg==
X-Received: by 2002:a05:6a20:d70a:b0:1c0:eba5:e192 with SMTP id adf61e73a8af0-1cf1d136daamr4439410637.27.1725660777476;
        Fri, 06 Sep 2024 15:12:57 -0700 (PDT)
Received: from dell-xps.. ([2401:4900:51d5:dcdb:d33e:287f:e196:82ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71782eb5352sm4309382b3a.154.2024.09.06.15.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 15:12:57 -0700 (PDT)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com
Subject: [PATCH] ocfs2: bug fix when bh is null
Date: Sat,  7 Sep 2024 03:42:08 +0530
Message-Id: <20240906221208.136692-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported-by: syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=adfd64e93c46b99c957e
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 fs/ocfs2/buffer_head_io.c | 1 -
 fs/ocfs2/uptodate.c       | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index cdb9b9bdea1f..e62c7e1de4eb 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -235,7 +235,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 		if (bhs[i] == NULL) {
 			bhs[i] = sb_getblk(sb, block++);
 			if (bhs[i] == NULL) {
-				ocfs2_metadata_cache_io_unlock(ci);
 				status = -ENOMEM;
 				mlog_errno(status);
 				/* Don't forget to put previous bh! */
diff --git a/fs/ocfs2/uptodate.c b/fs/ocfs2/uptodate.c
index 09854925fa5c..3242291402c3 100644
--- a/fs/ocfs2/uptodate.c
+++ b/fs/ocfs2/uptodate.c
@@ -471,7 +471,7 @@ void ocfs2_set_buffer_uptodate(struct ocfs2_caching_info *ci,
 
 	/* The block may very well exist in our cache already, so avoid
 	 * doing any more work in that case. */
-	if (ocfs2_buffer_cached(ci, bh))
+	if (bh == NULL || ocfs2_buffer_cached(ci, bh))
 		return;
 
 	trace_ocfs2_set_buffer_uptodate_begin(
-- 
2.34.1


