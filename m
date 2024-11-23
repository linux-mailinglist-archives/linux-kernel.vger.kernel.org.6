Return-Path: <linux-kernel+bounces-419073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0489D692A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3505B21E4F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D131A4AB3;
	Sat, 23 Nov 2024 13:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKl5H+wR"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81391A0AFB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732366937; cv=none; b=mLn5F5shywjAQBPGQTySsCZ5sfTvlf79XTbteaFMiWQ4kiFOX0Q+P+Mwhg8M/13oDgZYUn6xYrD8cB5+xvdMg1DulJy3Z7Dh5gyIfDew4JXlh3pNC8idXAtlfRqD8/yYXhq5MvrMQnx6qnD9ybkgDDTcAhjpOsp9jOJw3aNVzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732366937; c=relaxed/simple;
	bh=SW7ceukiGOAMg6oCej/pCsQsEIDXQaHTri1X/PCKtsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cwiHsj7nETDpDdPJaeSQw/FEnFgVWt3ZX767TRKG4hYlqbj1AXFzRCddgJpMmC9jG5PbQZM6Dh95ZtmgSr1pVYuazrQHDAJTGwWRm3CIcNqcPyBvpDexWUlLbPl3J4cunBVWzi0+h+N8BK1ZLk9DoD/bxW42HTe6RXxFuQVcTG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKl5H+wR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so1471719b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366935; x=1732971735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAAeUPzSxSLE1/Jv8QrW5Nda66nIWoJZku8hKTRv9U8=;
        b=MKl5H+wRpU3Km+3zPld92a/bOtAWpjEeNXH9uqCySjEwi/g4N7feQbJP7Y49NNfGz8
         Vkxd5JiFzHdcnah3M5FIvBSD1mcYDA9rcreVk6UH0eZBveWjE7BNarlJURA4nVlEqblH
         8aNwAQ+ywxp/KTYo0xGtzhPpLLxul7XtCBzqyIYRS/gHYG/70VRApyxs2641ZluCpYS5
         qCm8oizIwn5ViBTGr27ioQiXqjA2uH/ytP588lkgKS9bz73eN2C5mlO36FK1AHZalRib
         2trwXncSpAzJ3scjY8K4DAYP+npCrzHBglVhDt5DJ89vEUHguSOn8E9zEK6uqfnOxQ8o
         P70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366935; x=1732971735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAAeUPzSxSLE1/Jv8QrW5Nda66nIWoJZku8hKTRv9U8=;
        b=DICEo/pn8D8PM9sSK18VADzkGprHPwVejl0BvyKO/fQte7ZKcnyjp4cVRC6AujAGy1
         7lYNFcvTqVNIEJwwRitypY+PnsbXSxXq5eD0jhrh6Hr6FNwd5mr5sOuDQuEF6wvPagkR
         l5ZKhmV+hkcvv7ku+N5aZIlaBtTSXxK1pgffOUe+ipzAYVyCiLBBWOYs1QZOlrXcQvrq
         8jfg7Peiru8UA4OQNa9ZCLPnsfqSPITMHblh0cLFNGvBFQZOczOQkL94rjWgmoTtETWN
         9NO+gGolE5wP6/pY+0CFEY52zfYX3WNnTw/9aSPsN3oWRbFNYWTwu6ZXpti69ZNhbk3Q
         UHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwWaH56x95aS5fKt6sDSTVvfCLXVuzY9UcYmO4oEFc45ykjEVS6q+LpjfgjndS2+qMuM4wLtbusUX21is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg7LkoTFvZ+03VqfbthXeZhtmm2HoXqsaHJmfBC8BSHW+YMEht
	FqCQOaFAhXMp5qhr69o1ZMNf4BPniV7yDx2I7xhfiQ7C+UM7GVX5
X-Gm-Gg: ASbGnctt15Oo71+Y1q+fsDStuXySql92Zc/RcoeZR4x9jL/QViR60NMaD56Kvnk2kER
	FNRYkcRozYVCZ6BpXSmepbiR+e69FaW9YZrL6M17tgpwKS9nhBmXKpnxkwh3FBlfuHPIdJMK+F2
	OpAqNk9a5cMgWT4bbQwBbFijyMNWIoNzDFwLxdwQyyyooh6gHlvsXCsYJ6dDHMtahaldG8B1WF7
	VCotXDHOOBuAcA8BZ0+Q/GBHsq9j7kpHZmP1eYPOsDmCM0ed4tYaEhTttQyuA==
X-Google-Smtp-Source: AGHT+IGeTBhVsRC+WU8nIRo9X5kw2aNF0fkUaU1iy4LonaEXqWjjHBK7t8Gq4b+rktmOmvKBNHSBbg==
X-Received: by 2002:a17:90b:1e0e:b0:2ea:a9ac:eef2 with SMTP id 98e67ed59e1d1-2eb0e233942mr7446552a91.13.1732366934863;
        Sat, 23 Nov 2024 05:02:14 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:14 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] nvme-tcp: simplify nvme_tcp_configure_admin_queue()
Date: Sat, 23 Nov 2024 21:37:39 +0800
Message-Id: <c7006c36681afce811e01de7686d6e2df2c4ab0e.1732368538.git.chunguang.xu@shopee.com>
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

As nvme_tcp_configure_admin_queue() is the only one caller of
nvme_tcp_destroy_admin_queue(), so we can merge nvme_tcp_configure_admin_queue()
into nvme_tcp_destroy_admin_queue() to simplify the code.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 47d8f10b1f75..45cbaa7523e6 100644
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


