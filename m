Return-Path: <linux-kernel+bounces-423199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2489DA42B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041AF168123
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11024193063;
	Wed, 27 Nov 2024 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzX65IEx"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B9192B89
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697551; cv=none; b=UAwjgrF4MUEc5zZfyA44cfRTU7KgtlBNq5DsetoEd3jwRcJ5jv+zmtzmP+4pnqaE8av0Q93ZIGtsiS6l1v+JwHXBBTEOvACrGVYS9pnzUcrOQHjJ/utlekYEReyZYAvnCDswXQufPhJivHE47ZuVK8nT3n7QG3MoDn0fF+DdDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697551; c=relaxed/simple;
	bh=YIACx/HJt7huWs2y8Xhx9617l3vSSaHOP1w3p8OeZ44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RobjcBUs7NSRvKYhAn8UKm9CIBKh2z7/Qbk85LEGm/FpV7v7SM6RGMPv5ndN8H8nzNOyBtv49Uu6v2FuCmLIkf9REVvXOM2wM0X/OexER65FrelGU2d3Eho6X/CzWk+/ej0zTcCurX4L5pavn4eEgeUY0wm2vCWryhtj11KYbtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzX65IEx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso5602109a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697549; x=1733302349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WpxC1ak5i/GsjHW0+FMk1rTOqPJjGGRzFkrWXfXPjw=;
        b=ZzX65IEx4cxxZTrcpakq7HzAGJFRJldY1DBZ5vdgqEmUiuE8LLV0F2RIy6boQLGF6X
         TWJZ/e4XmQbe1rN5xRKF3i12mfJhJhi9U7PM79NUJboqqU9WKb2cmtNySJRLKW/7dzo4
         Ks+PFhpI6tL1qfireQL7zW1SSgyJX+V/7wnjKE+Mfg65iFkcI5vCngu/npT4l2gnpO3r
         +1KSinrF/G4ZS7E4pKoKmJxeBQBJwCenWYRq6rKIFsvYVQtOiZ57sUhzydtkAp7LvAuJ
         yHS12+SvUqzcn6spW6+10Q2SOxT/vuEbIBuaZmjywUqdGZ+gJ6iUtH+z2B5A1iXreC+T
         sUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697549; x=1733302349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WpxC1ak5i/GsjHW0+FMk1rTOqPJjGGRzFkrWXfXPjw=;
        b=pOzmQtFfk7NDLxGK2sAJbJFrEzINrSo+hDfA9VPVtCB0ARi7aXXFgNNYwmBAJHn31D
         VbYZV+ZmJIaFU57fW/BzbLH5fvqhxpNjP4sFi4/9kAsp8WhBI9dJBzCA8JNRuyvh2j2V
         ZpfsXLXFq+FP/pvFYSLaViXmQKQDtVFomklU8gN9EwoTUq226qOz8beXPtqe6x4m+g9q
         749TTXHFvRq79wBVySUxgMZAreN8OOgo4rNlSZVJAilzCU4zGXbe4F58uiUgeToVaI4o
         /VN3fJdAIc3EWbknDugHdn4qroJvySemXqoGwPHhQ35ZwrQ/QqLmpmjxM6y2YAyPZcJ4
         fmsA==
X-Forwarded-Encrypted: i=1; AJvYcCVlUhHILQu3OGkkGTscjg5LGe0xYxWojCFDTIOUk4UmYcJPijMzM+kqgNM5drHfZUZ3omoFqle/F7NGs5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4zNljhQqKqHpc2aAtGQsgv1dS6sUzH0Jw3HFwAyYFK+drVgPb
	6OX4xojqSy2uqMBdnGyNAl17p4w5lDvnuDGEIOmePhhbsbaZZlZr
X-Gm-Gg: ASbGncs30PWn6g1USwqaqHCtQEkdEJt0OrKiyI9v7sor6f3pepCzJnuQuME6zuflD59
	Gq3dz6sXK8On3Tlk1Z4znVr6kCKzEucCyq9+3GMK1KdW+jYNNqhg7AVcgHoOqFvzvn7I2sokDms
	tOJAQIG2jgYaUjHwDZKRsS7OdhTTVnG7V1Q0/Swaf7jTOD302OGPxbs9QV4Q5d0ncgzJCr8B9kE
	mvgx1SRBF0qyXy7MyRPaoM5ePh1ywPcGNRiCym5rIuP9SIIepoETeRf05rpZw==
X-Google-Smtp-Source: AGHT+IE7W77IZPGT6pO6nsofu0SApJz/06UMb2dL6eXuQw16iAZ3rYd5M/ikmsqDsnhpiwQuFqFmdQ==
X-Received: by 2002:a05:6a20:9144:b0:1e0:c50c:9842 with SMTP id adf61e73a8af0-1e0e0b5cc99mr4084950637.31.1732697549421;
        Wed, 27 Nov 2024 00:52:29 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:28 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] nvme-tcp: simplify nvme_tcp_configure_admin_queue()
Date: Wed, 27 Nov 2024 17:27:50 +0800
Message-Id: <8282314c0d688f51be9f9ee90cd3463ff76baa1f.1732699313.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1732699313.git.chunguang.xu@shopee.com>
References: <cover.1732699313.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chunguang.xu" <chunguang.xu@shopee.com>

As nvme_tcp_configure_admin_queue() is the only one caller of
nvme_tcp_destroy_admin_queue(), so we can merge nvme_tcp_configure_admin_queue()
into nvme_tcp_destroy_admin_queue() to simplify the code.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

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


