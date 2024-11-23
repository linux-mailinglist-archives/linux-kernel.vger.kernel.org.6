Return-Path: <linux-kernel+bounces-419072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F59D6929
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D14281948
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426691A01C3;
	Sat, 23 Nov 2024 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/vTh1R+"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6292319DF66
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732366934; cv=none; b=FojFYyNZ/RMyKdEkhpHJWw6VuR/eADO9U9AgwVwauXhR44IGLM31xSYFSNxAFviByyifvtvtXNMk3g6wAF/z2x4d0fOeYHZUsQMJDJVLf+Y5AO81Zk++KqBaXaPzHSmySholaRYpFlxwAw0FDCRk8g1XCLcKE89O70R8zPGKQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732366934; c=relaxed/simple;
	bh=FfKJkZqnWIgcThXo90wxxijU+QmoSXwfVrgQvVpYeIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F20EYKt1BYqa7WVGdHeHbWPgQZpGO0J5gUUP7S3Qcld/ALtww+Fvd5iWjWeh7wPRSoQUMXdcKC1FoKSaxXcp3mJoF3wd7WiYg9n/2q1Rire0+Mq8yWqUi3BTqDZ0VGqpYtC3IXBD5d4Snd/2kwG8QF4jdGA0vaf3zZ/wBRGf6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/vTh1R+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ed91d2a245so861164a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366933; x=1732971733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrPDMuw1dFwbu0Tqru5tfNRebp4Qh9dYF1NLTgw6QP8=;
        b=l/vTh1R+2d0fc3oYg9zgRcHXdoyH7fLGCpu08RUnTlpLkdbMIxvyR766R5ldCz1gkM
         sDg63zbQJ9Ck/ZPQWzBkU3oiCpQdsBdWzQ9OvDdb2Y7PHncqUlAq5hF5z/xMtwkOpItv
         RDYG2Ebjg+qCwxulgsep8X1cVtenRTAEAOT0sDZcQQMplmMjMB9kT46HcI+0WTZzuhRL
         C2AiKu58NtstyUTo06YI8yvmZMP+xNVmJDp+AAfOYE0xsW175sSIaqVGdiRlIfr7847o
         xbWvh+jBuR9QsJBJCn+X1LNUHygT2XXeuitWnj3pcMxT8RYeBHKgJIj1wt4HSntha1I9
         iS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366933; x=1732971733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrPDMuw1dFwbu0Tqru5tfNRebp4Qh9dYF1NLTgw6QP8=;
        b=NxqKy6O9FEfoVPFhf+VScqN3idfTj+qQAFW/qOgBRt8dIj6NYs4dDBv4tf4WL9JdaK
         fneQC8WNmo5502BV0KUxJM8jf4zNLfH+oPNbyK6NeYhApy5vLJ8LuX8KuMTjaQ6pGozy
         ycsATtsp+B6aLYJxlVhlYvRzV6B6YLt4CP/nXOt+/aY8vjOTR/ZyTQjm2TsKt7io+OuI
         FLqAWD6l3MzYdw+0KzLrSrFmsuaaJA3NSSXt5EqSGT2frcfaAwgHiemfa0bkWsJ0jsRj
         /ds6oOogXzAyn74RYa6oYKO7f8SqXuURXsotEjaWLJ6LXA6xiNl4rg60tzg7dAK6Vnc5
         lXAg==
X-Forwarded-Encrypted: i=1; AJvYcCUCml3I6ffBFRw9LqYhJDwVOdLdzlQQvS3lY2mTJa7huI6puo+IWpbIsefXxbxux6exD3Pvlu4qgTZVCpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylpvmer7tdPa5PxuzR8zwshu+fhCfstfcFT7SoBUENjzykeckc
	AGIXj/RjG8khz36/zcpY92ULR5kV0rqcV9zmEi11KI0rD44+QxDh
X-Gm-Gg: ASbGncvCWRx5ujSeNbQ/wIHogWVYuY5x32bSYjLNCeWAPUa2tRfzatKRMOfsW/qJRQG
	AJo4IuZt5R1achm8QMvgFxlA5kmmw5f+G+Yi+AoGUs1ExMHzIzJm5WtmIBjAAI3pHBXwuVPL2TY
	sw4XUPEszqWAikttiGomB6F+mDQIZiRKFjWWg+EeQk/C4pQhhegn9ZWOK2pg8hlHKLXwQCbHX7A
	PJgHNlPD2ca/RhOONtXcLSxA/R1SYKb4NjmgLpcbjEPfnJlDU4TOrgpcanvDA==
X-Google-Smtp-Source: AGHT+IF3F2H3QEfzAXCRlL8SxURAgWq5rQ5oSRPQa9KvX3WmUGVygxsmZiZORju1Kw53XHpLHT07Kw==
X-Received: by 2002:a17:90b:4c8e:b0:2ea:3aeb:ecca with SMTP id 98e67ed59e1d1-2eb0e8847b1mr7505522a91.31.1732366932509;
        Sat, 23 Nov 2024 05:02:12 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:11 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] nvme-tcp: no need to quiesec admin_q in nvme_tcp_teardown_io_queues()
Date: Sat, 23 Nov 2024 21:37:38 +0800
Message-Id: <e7c1d7b531cef5fdd2764719e4ca824477579083.1732368538.git.chunguang.xu@shopee.com>
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

As we quiesec admin_q in nvme_tcp_teardown_admin_queue(), so we should no
need to quiesec it in nvme_tcp_reaardown_io_queues(), make things simple.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e416af2659f..47d8f10b1f75 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2178,7 +2178,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	nvme_quiesce_admin_queue(ctrl);
 	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
-- 
2.25.1


