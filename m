Return-Path: <linux-kernel+bounces-428662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5099E11EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0961614AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A579E15E5B8;
	Tue,  3 Dec 2024 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jboWcjBA"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68E2905
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197201; cv=none; b=g/D+2S+HLlH8zfXeeDED+yqlP0gh5AiG17L9udos/IC0NoCBlR5ttEY3/xuZC1DDSr1S3nkTUS7lS0ihG0MvaTHG7NzWAApnWxFIFZjjSI9XVqV5CG0Cv6M0bLVlwGixXaa7omRuMW4zEglFVzBsHnMXKr3yECF5ib4eg0g5KbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197201; c=relaxed/simple;
	bh=TlJOafOkkv/+eUbDu+EfPBmOGYLet8/C38Fwwo8nGTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nx8VAoKL51nEtEN0qeLRWPEcBrUZ+vy4r+ceVcUhtFbT75AWo795xR3DtxDHKET1vwYvKfxcaCRQcwfYNFNbitvXwbtFENUAbJa7MfWAiebhw2h0pm54LCObxET01zGmRWOaq3sepD2z+1qwhx2dp+elxrilbDkUd1N9CyVEetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jboWcjBA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-211fb27cc6bso39986525ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 19:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733197199; x=1733801999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BHuI4q2u3Xl91rfhMIm9f5VhokkqjUJEzUCp8oqzmXk=;
        b=jboWcjBA2Wt2f+Xwh7kKGRljsJczYTRApRK49WiDedpvfGE11xbXP+3fbR0ciHpI6j
         623u7mayKGAyT2v4HtbOgHetg9tNU01EdQx+8i5BXZibuZHz+EwAIB/HjdqRaCIhgEeS
         aTbsxiUUP/Sx4HMfdxOE3DrBoDTfyGS39X1lBqWTmKRgmPGFFnXEzHsuZpT362X92Sq1
         FY8f4XsQ32TKFEbG3DFXd2x3xDs9j5pFzS4UQKNE1bkGx1PLn32y7A6eCuml0T1boy0V
         Mq/EsW2Z+XAvE2I15pxcQm+L3O3Mrd/ncDqGraj2Tx4b+odaUCPqxjBtMmRwJuj4/sud
         XxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733197199; x=1733801999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHuI4q2u3Xl91rfhMIm9f5VhokkqjUJEzUCp8oqzmXk=;
        b=BVM1gKgUYc09OEGWbDoM0YxqxwHRi87Rehxgrs+Uf1RXuuVxDJrhNpTIaOzrhdoB3d
         YWC+DFuY5nw6SNj4kEm4dBpZbkQbh1MJCbvkuXqTbjnZW1R+tx8u0YVqQbYxFM4MKNaW
         JEcYNFxjpY1HQrrg8lcuRNp7d432VQ4/MW1NGI1+FaTUGrU0EpZ6fJvumKYUSTBW78Gq
         qxzx3DADcv6sN0oID/Ffh4o/smt8djpOfMbJVlTykro6v06J29LKEUASasc+6RaASDzI
         yi9q4Xy5Vc6c8mZFQ29idQNd73xge66lBRFkJzKfTJvJZQgCV69LXQ01zNI/sH9zqTg8
         xNYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjzrHSBwn28hKzvfP5qEl2TyFP9NW/i6DQeZ2X1YWGpNsmxxrMCLWGiMV/Lw8MRh/bXA2nxyU/Fvysg34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfRS+DErYg3sTTKZTcEOPtt3ESb/4ot7CK2uHIUHepDNDUDnlO
	G/Oa4gsjQac5DCjWdbytmc7iZYheaiTAiOCZC363O5950KR0AEk/
X-Gm-Gg: ASbGnctijWXxQ+4bbH1M9zA7jiu0jJAdMevLj2FGAyRGAKOcCgOBQB5s7opza/t0IGF
	+NJ7uhkuKTHSL9rrb2aLlU2644fyol96DSxG9UADqPX65GJQJClnxCH0e2lNJ/9+J5EJb5OeYDA
	FBb9XF2+h0ZRt3HYRPpPM7PCaRky4yehUnBCQFdoiy93GV8B9lcnG6M8WZIvJ/w3B84g8WWr6nQ
	C45J4BDcvzUJRdLqRXeXEiyU2yzrKackHAEO9GT0CWIvab2zna+1gffJKatGA==
X-Google-Smtp-Source: AGHT+IFdiELg8otAdb63Wp3uKOJdKRAdTD7LtaAi/HuX4oHsglR1rRUYPytDrXhRXE/C8BQ0mZejzg==
X-Received: by 2002:a17:902:da86:b0:215:6cb2:7877 with SMTP id d9443c01a7336-215bce9d120mr18082965ad.4.1733197198990;
        Mon, 02 Dec 2024 19:39:58 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f4787sm84909765ad.53.2024.12.02.19.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:39:58 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de
Subject: [PATCH] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Date: Tue,  3 Dec 2024 11:39:55 +0800
Message-Id: <20241203033955.394595-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now when destroying the IO queue we call nvme_tcp_stop_io_queues()
twice, nvme_tcp_destroy_io_queues() has an unnecessary call. Here we
try to remove nvme_tcp_destroy_io_queues() and merge it into
nvme_tcp_teardown_io_queues(), simplify the code and align with
nvme-rdma, make it easy to maintaince.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28c76a3e1bd2..b127d41dbbfe 100644
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
@@ -2176,9 +2168,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	nvme_cancel_tagset(ctrl);
-	if (remove)
+	if (remove) {
 		nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_destroy_io_queues(ctrl, remove);
+		nvme_remove_io_tag_set(ctrl);
+	}
+	nvme_tcp_free_io_queues(ctrl);
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


