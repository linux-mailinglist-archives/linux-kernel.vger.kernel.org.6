Return-Path: <linux-kernel+bounces-428656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D867A9E11DC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0176CB23518
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589C16EBE8;
	Tue,  3 Dec 2024 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVDE1El/"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58855188CB1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733196901; cv=none; b=KJnux4o5l2gC5TatFIstIt9rOzIjatiJ0CK0ZRmxiJeSCtLDGyiFAuPbaOUknEJ0nidjRT6fAo2A9JMCR67lmQsp0N7m5rS6iArzAm/V+gVv0Zm6+u36fMWBtReHr/bJ6w2FvaIOOrBwEa5UlUkdSo6mX5VG1HMIj99U49q9ge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733196901; c=relaxed/simple;
	bh=wRFFWhV51UY3eY6JPegQSq0QhJ/YS+D+vZ7fhC+pyII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fznvYdAbqurADXz/3P3yDP7dELMsjT5QxdkdP1o2HgwANCY92BQSxRjbq8Qo+p2SQVE3Lt9B+cI2eDnodhhidRo3iYJLybXgYugB4LbPadWjYb6pZdJnR4uvgExJEZ8TA9w9B/qxl9mSuVc6eKNikTew49sJmazlsqdyOWJLDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVDE1El/; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724e14b90cfso5022503b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 19:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196898; x=1733801698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y605Yoqum/jZcE7U0+5pZo9sFjv/Z/YWwjaxKaUzHJk=;
        b=kVDE1El/hkFM+uovMNJ3jR0G5dqKAHn+Vyl2d3jrJPYerREEG/+3EgR7Qnrh4b/Vwg
         NThEGxf8sG5eGwXCZTjHrnprWCTMPiJIFPl7WXuv3r3mLzqigaghwF08UgPNclgEfyJD
         e0bV+iEj0n7d03cWHFwJvEwzd1zBbhMmIGWmNemoR05AySARFNjW3tAbfKYrHm1kr/po
         C2gzhUUwGEgLnw4IEhQ/4c6Kx9LfzzuKeFXYr1G4IkaPrF4jVPV3/E/tPg0/iX6IqrTM
         5czdnTUry/nFyo5SlOLYKrpzKjmgPeX7N73pE5X3ZZiQPZIwnpHWKt1mkHAoR/lBYLCC
         Wi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196898; x=1733801698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y605Yoqum/jZcE7U0+5pZo9sFjv/Z/YWwjaxKaUzHJk=;
        b=wdPBA6CY2kveb8V4GZm1RlhbJg7LzJvyKESx65jfyMRKSgTj2FdPl8heGkaJsExz/x
         zG2nNm9QS88ju7JXP9tM/z1FVCGlh/8pfLvWVzfye6q0FufarL1tkhm2o+bNvRBU4Ypi
         eJ8Qp1bPRU0ntoeuiIi7zx5C5aukntQutDzxjBbwKoJpE/v4CqbphA1kxSrxqWlzc7iU
         U5S9rdBS4qdM/4GSotbnC13wM92EyVGqyQ0+Fns8tZXX/59poJRKCjr5qXpMY6beDM/G
         LwmKTPYZWw5Mshv4RzXmUS5Ykg46IrgClWT+/cWIV9efHWWrPEXmrkGNRR8UG9rxC9ba
         z+lg==
X-Forwarded-Encrypted: i=1; AJvYcCXmWVuZk9HSp3SvSJEdBCIAs7SGsD8Fhu/Cq8v5zITwSrkpjZYNueRqN1t7T64/8vZ6KUt53WQBStEEbbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNMQjgHQKeg8JjVm6oClS65mRdWlYf5r3NZ2ywPs6mu0UOfqg
	Cea6nd/6GcvwUCbKbcLVV2U6RBs0aME4ooV98WvFe0kbDGm4vvdg
X-Gm-Gg: ASbGncvL8bvYJqagJeOp32njOs2tVH03tR/UcIbgwbd+aBHruLadshEkF6HU6pZDqRe
	rlyMH7Tfles31O09ES/l9m8aDKTIdn7ekfnGRknxSfFUsI7rM80E5hsSN+l54czr6DpATG3BLHY
	XCzYT3ZAMLzQ2PQiFE+C/y/DA4zL578yrQcIqunUIkUgaAI1Btzu+uJrKQFhwPlXPS2Q88LdW9m
	ywAFB2yKHGviFlHG/r5ISjK7+0V7LJjZj7LSJ9xxOMm+tUP03RJPOTl3W58yQ==
X-Google-Smtp-Source: AGHT+IE5D0txWF2LyZfs5ncf+l0eY3tlyVCpC6uLbHvVEXZiiJms0ww6O9iF/3o7GF7mHDnYmdng+Q==
X-Received: by 2002:a17:903:41cc:b0:215:603c:2f15 with SMTP id d9443c01a7336-215bd0f2a87mr14653445ad.21.1733196898556;
        Mon, 02 Dec 2024 19:34:58 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm20749645ad.255.2024.12.02.19.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:34:57 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de,
	lengchao@huawei.com
Subject: [PATCH v3 4/4] nvme-tcp: simplify nvme_tcp_teardown_io_queues()
Date: Tue,  3 Dec 2024 11:34:43 +0800
Message-Id: <d2c6f0988078af74438223c31a88ac867126caa2.1733196360.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1733196360.git.chunguang.xu@shopee.com>
References: <cover.1733196360.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chunguang.xu" <chunguang.xu@shopee.com>

As nvme_tcp_teardown_io_queues() is the only one caller of
nvme_tcp_destroy_admin_queue(), so we can merge it into
nvme_tcp_teardown_io_queues() to simplify the code.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

v3: Update the commit log, no code changed.

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 98bf758dc6fc..28c76a3e1bd2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2101,14 +2101,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	return ret;
 }
 
-static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_queue(ctrl, 0);
-	if (remove)
-		nvme_remove_admin_tag_set(ctrl);
-	nvme_tcp_free_admin_queue(ctrl);
-}
-
 static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 {
 	int error;
@@ -2163,9 +2155,11 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
-	if (remove)
+	if (remove) {
 		nvme_unquiesce_admin_queue(ctrl);
-	nvme_tcp_destroy_admin_queue(ctrl, remove);
+		nvme_remove_admin_tag_set(ctrl);
+	}
+	nvme_tcp_free_admin_queue(ctrl);
 	if (ctrl->tls_pskid) {
 		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
 			ctrl->tls_pskid);
-- 
2.25.1


