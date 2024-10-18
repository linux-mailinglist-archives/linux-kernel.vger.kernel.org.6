Return-Path: <linux-kernel+bounces-371344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF89A39DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589291F27AD3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B2B1E883A;
	Fri, 18 Oct 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfTpNufx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5483192B94
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243334; cv=none; b=e+2reMYrG1oGrKJ3OQkLb19jYa1oMGfZzgUtM9oP7FI5UH67VmOTXYUHnPelRi13VL0Q2O6FHWV+hNBKTlSUJTtccrBrcd8Gmnn/M6g82ovSY2gckvw7hJnF7DLqY7PMcGb7W6DoY0besmGJJdOI7FJJgUbHJyZGkbv8IFmiJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243334; c=relaxed/simple;
	bh=iQtFXyu+eKmRsJRQ50JW/Pwh0OvPOcYrT9Jj7gapYzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K6lC7XatX+Rl3DwPMMCZQmbSZoUjQq4hVYBtplICk5QQex/8Q1IopMjbIRvLamkDicJp0lB+UlgXf73QOA0bxtf5ZUHQAnYQNDOxeIiV4E4sr8uWjB3CLYEUAa0td3t7bn5M0KZX+DwYeIvHxiqEMQUg/SWHeXOOT45cpJWTLZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfTpNufx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3821EC4CEC3;
	Fri, 18 Oct 2024 09:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729243334;
	bh=iQtFXyu+eKmRsJRQ50JW/Pwh0OvPOcYrT9Jj7gapYzY=;
	h=From:To:Cc:Subject:Date:From;
	b=JfTpNufxh2i/J1ts9O+yGtlQldp4//A/HIMiJbixnq1P9QpwqfibMf2FG7ktkFbgY
	 lcoEAgBiBlGRRcOkZ1J0VyKQSoGysHk0EzqefyJOE8n0l1CCBVwTxaBgLAtzMaoFRV
	 cB63ArDaCAKfnZZEwegEy2r1fY+UhxQv/mJJXCJRdE5Oj+n6TLPcsGimxW7TKO/xbt
	 ND7x2uHZBxPG9YtPMcuLvFoJ3EY3uPwXaS32ZUg34BSTiDJU38O5qCCDLm5FW1Byc8
	 b9WkxAruAQdP8DVYqTJv7C/MetVJyUzg9PnXE5LVKfMEtJX/8lNsBAQzBpTNz9gdg8
	 NPOqc8jANQkZA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to convert log type to segment data type correctly
Date: Fri, 18 Oct 2024 17:22:00 +0800
Message-Id: <20241018092200.2792472-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a new helper log_type_to_seg_type() to convert
log type to segment data type, and uses it to clean up opened codes
in build_curseg(), and also it fixes to convert log type before use
in do_write_page().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a1806976f4ad..e172b3d0aec3 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3836,10 +3836,35 @@ void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
 	}
 }
 
+static int log_type_to_seg_type(enum log_type type)
+{
+	int seg_type = CURSEG_COLD_DATA;
+
+	switch (type) {
+	case CURSEG_HOT_DATA:
+	case CURSEG_WARM_DATA:
+	case CURSEG_COLD_DATA:
+	case CURSEG_HOT_NODE:
+	case CURSEG_WARM_NODE:
+	case CURSEG_COLD_NODE:
+		seg_type = (int)type;
+		break;
+	case CURSEG_COLD_DATA_PINNED:
+	case CURSEG_ALL_DATA_ATGC:
+		seg_type = CURSEG_COLD_DATA;
+		break;
+	default:
+		break;
+	}
+	return seg_type;
+}
+
 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
-	int type = __get_segment_type(fio);
-	bool keep_order = (f2fs_lfs_mode(fio->sbi) && type == CURSEG_COLD_DATA);
+	enum log_type type = __get_segment_type(fio);
+	int seg_type = log_type_to_seg_type(type);
+	bool keep_order = (f2fs_lfs_mode(fio->sbi) &&
+				seg_type == CURSEG_COLD_DATA);
 
 	if (keep_order)
 		f2fs_down_read(&fio->sbi->io_order_lock);
@@ -4845,12 +4870,7 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 				sizeof(struct f2fs_journal), GFP_KERNEL);
 		if (!array[i].journal)
 			return -ENOMEM;
-		if (i < NR_PERSISTENT_LOG)
-			array[i].seg_type = CURSEG_HOT_DATA + i;
-		else if (i == CURSEG_COLD_DATA_PINNED)
-			array[i].seg_type = CURSEG_COLD_DATA;
-		else if (i == CURSEG_ALL_DATA_ATGC)
-			array[i].seg_type = CURSEG_COLD_DATA;
+		array[i].seg_type = log_type_to_seg_type(i);
 		reset_curseg_fields(&array[i]);
 	}
 	return restore_curseg_summaries(sbi);
-- 
2.40.1


