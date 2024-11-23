Return-Path: <linux-kernel+bounces-419074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE919D692B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F74281DF7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F861A7AC7;
	Sat, 23 Nov 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S58L6TMU"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102501A4F21
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732366939; cv=none; b=eRUZaw2GvBUEO9/Gs343NgONzNzL3mmzUaCzWvRmVQJI29pDzcy+YuTMmwwB78vPFtemweBe1VhGvF51cWoUEdSjAqvYHZWlytAy8S+QfBCBdlBxigEcOF8KMZwUJu9lbG54gAVCG+wS5RCm5y7iUzRkS0fgYCnA2+h6cBkJOYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732366939; c=relaxed/simple;
	bh=2U105BgHfOu0jcF095fHzRPBGeY2Zlzfx6tK5rB86ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sBlgNwhkDfXp13WoxiyDm5Kn/129JcE9CH2wtCgzck0KaS/AbOa8i0Og7AL2WaxdVNpR9kd7UTyCf1PF0omr8OTxrSeVifFthTLvEY1zt80RCcxRsooePlTQNdbuO/Y412rDpmEAz275WSz7Me7D+9DX2bgk0SV25jW4SY/9wmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S58L6TMU; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fc1f1748a3so166429a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366937; x=1732971737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd9a/be5zPzPzHX2bMJ+1WldLBEiKm1H974p4wdOY3Y=;
        b=S58L6TMU0LglVJTwLN7m9A8miHzG08I0x2w+wYPea1NvwzIpdzd1helirzRmk+4fUh
         jGaKfwalbc4JUQ01rkXpfWjKfqZ1W0jP6iZ7wuGNNViYJLy76lYddn+QWvwkZFxMrhoR
         8rrCKwtDj5HGY8NTTXCp3WiRdiS/WqUbRde18rNbPxKvp3QixCRJCpyJoPknA7uC7JeO
         HA1zP//9/3BVAyqNd7CncfXYdyL+v/8MMxIUGuPTIWq2i4duS2KnkYaZWRavLAAW9eb/
         Dm9hEbHRRs9gjZubm7Q9VsKDMamC61M0T9y3YzKyyOqPnxcV3JQ2PHPV5w+GWaTmqfjo
         6hvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366937; x=1732971737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jd9a/be5zPzPzHX2bMJ+1WldLBEiKm1H974p4wdOY3Y=;
        b=LERR/iS7UAn0yv9pv6nBGIeaj06RDS0R/DY3TdGn76MOSB28Ev8qQbVENEtgSiVO3H
         Tl8y5s6t/ju6wXuTduOOWPA2ctPHVVWenJL6ekdifz51tINfvx0/D3Wo3hEUkVfLPm4C
         5LU9NqTO01c1Qv/vrXoKB2fO1rMvmq8BBy5Rfm0DCP0ozl6Odvh53Qe2wJSxLpZKG0BU
         LcDFVZHMmUb/5xIFEaeKBFu3DOwWepAekispFIcu/z2cxwVUppYT2KrncjWsAPayTNs1
         aLLOLnwLyHjEPCP08Mf4O2DwuP6PIqBAVlBeLuyRBKWquz3ZSLJDQrK29ffX448QAf8r
         T+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3j0AI9sy+SQq5Wkr9KGuFbTPDVaGTHkcCVI9Y5nO6F0oDlFP4vW3gQwnQUfN0/vn1N2SxMYIqZsogNMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr7I9pxyuPwpVMz1dxfRiX4cG8PXJI/lv18/jrLJ7mf76qCuX4
	1RFBTtgn/um4ssGMJ2KTJSWu6P+qZFlkHw/2RH1crzI3e3YZiFdl
X-Gm-Gg: ASbGncvnLCw1MatAmJkEV00K1uKMEtY4Z3Z4WTeS0rCTRcUc0TO+cyNedBkbrBOvF2V
	jaS6IQ15aCXBNgIaDTTIgaaUdG0XlfUciTIlcqQOteMjTW0Vyh04bS1gDSF9Qi+fTwfPNPp9Vmf
	ebQy2AaCvIzCKkRZFYDjTYd0UsPyhUxJj9Y24thHfAHVKoOti9ftjKRwkLnir7LiiHO2Du8ovBh
	TtB3nxq+Is01e5mvnG7kJQklYTvh7Pvf276Sfmrs1gxZh2Q4YSCu9aE2Sdnlw==
X-Google-Smtp-Source: AGHT+IEZYYlYvDwl/+fsjo2KFtg8yQ5hbXqNTsiSgl63OWsqCTdHbVAL3ymVk7gyL9arAvb6Nw6tnw==
X-Received: by 2002:a17:90b:1b4d:b0:2ea:aa69:1067 with SMTP id 98e67ed59e1d1-2eb0e024c02mr7965691a91.3.1732366937238;
        Sat, 23 Nov 2024 05:02:17 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:16 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Date: Sat, 23 Nov 2024 21:37:40 +0800
Message-Id: <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732368538.git.chunguang.xu@shopee.com>
References: <cover.1732368538.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now maybe we can remove nvme_tcp_destroy_io_queues() to simplify
the code and avoid unnecessary call of nvme_tcp_stop_io_queues().

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 45cbaa7523e6..57f0f0290cc8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2024,14 +2024,6 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	return __nvme_tcp_alloc_io_queues(ctrl);
 }
 
-static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_io_queues(ctrl);
-	if (remove)
-		nvme_remove_io_tag_set(ctrl);
-	nvme_tcp_free_io_queues(ctrl);
-}
-
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
@@ -2170,15 +2162,17 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	if (ctrl->queue_count <= 1)
-		return;
-	nvme_quiesce_io_queues(ctrl);
-	nvme_sync_io_queues(ctrl);
-	nvme_tcp_stop_io_queues(ctrl);
-	nvme_cancel_tagset(ctrl);
-	if (remove)
-		nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_destroy_io_queues(ctrl, remove);
+	if (ctrl->queue_count > 1) {
+		nvme_quiesce_io_queues(ctrl);
+		nvme_sync_io_queues(ctrl);
+		nvme_tcp_stop_io_queues(ctrl);
+		nvme_cancel_tagset(ctrl);
+		if (remove) {
+			nvme_unquiesce_io_queues(ctrl);
+			nvme_remove_io_tag_set(ctrl);
+		}
+		nvme_tcp_free_io_queues(ctrl);
+	}
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
@@ -2267,7 +2261,9 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		nvme_sync_io_queues(ctrl);
 		nvme_tcp_stop_io_queues(ctrl);
 		nvme_cancel_tagset(ctrl);
-		nvme_tcp_destroy_io_queues(ctrl, new);
+		if (new)
+			nvme_remove_io_tag_set(ctrl);
+		nvme_tcp_free_io_queues(ctrl);
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-- 
2.25.1


