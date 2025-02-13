Return-Path: <linux-kernel+bounces-513990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BABA35114
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BB1188A8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1C20DD74;
	Thu, 13 Feb 2025 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+yBzUM2"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1944C7C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484989; cv=none; b=QwQQdweKLdEWEB/wDfPMs2jpjSYUnXPrTL4ymJqMQy2djI1cTZAn+0LoOQnoykdaYmP6CuS+nY7IgIKgi+L8DXCPjsVLEq3hey1oT8nZCbjk3cdJI1m474s0rw+RD30IPkK4NIvvBEd1H3TcvoRqIQ6ihlzr2eclXBGXFmsOooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484989; c=relaxed/simple;
	bh=1Fz1RtUXPFobVz87/yFbKQq+ysQWBDo8vvhwHHfaRrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lQCPY52aysWwbNmtZxIsrgH71h9fcT0dEnFlwMKCZ6/osNyeCCvZowavUbvheujNRi5qdyX0KlE3fnIeqBd96Xx7qYZqUinT2uRRCcDY4CZTcawu6zDAn7HCuL/VR++TyC/iNbTpxntQbMo45j9C2kjryK+VPkRe8Y83CeCb6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+yBzUM2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dd93ace00so779610f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739484986; x=1740089786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HcGHwBHCshi0yz2RQGryrnPpLkVHnABt1yCMpCIlUPI=;
        b=G+yBzUM2pqDGK59ZeAu4mxiDFx+rgsBELTe/TasveNrKQx8lHHRdoxx9+zMz4YumtU
         gSLG9DuIO/lJh0LxnDZc81juVZX62/ffAZG2LPSUjF8+rej25K7C1ExzL33R+xhWdALY
         Wp11hYA9q3qQAfdQqScbYJPkwU1WxYR6csTHBhRyBllUM3USS+BB3MZ7cVTBHCPOQgwz
         B3BdbEwNcRignfmDlwfbqjCONhV6cPxVreWcgNmDoVrKnVOluNcyqBUn5nGOeVjFT/AX
         M/r2yTv5YxFAQHZnwJwAO5AT0+KLkIJxbmiSQxrmC1uaGCUSY1lN1+6BENQeVOS9QMgH
         CiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484986; x=1740089786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcGHwBHCshi0yz2RQGryrnPpLkVHnABt1yCMpCIlUPI=;
        b=PxR95e3+1U0lG56ooku7btyxAlL8ZCYzRo2+HvoluolZoLYRoErgVMotT/jahIizl7
         vdgNuxjzmmTWM7TfBilpXy3UM5gnEEoBx2tTc3NGSY/z+5JQ+BcCcidkzi1o607HoDtB
         uB+O0xIGCtVDjIqVnDXyWkyUGBWUnUo+5mUkrrhX+kOcjIzeH/2h0WLXfPRmPOniY/Gt
         ue0AaoOvCcU26dJD6zdDMPmmkIa4zvI0lCDkxandHFwwqn5LzkVYzDgSwrReI6NeCAvj
         BjVxGot5Oktj2ePtTapINpPi/jpa1jIpSdG4Mt/qLTmfUuofxijDX3uZbYMERj9s5sAv
         yL4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIpnpWVv3QCTti5ruYhsKqFbYatxIrPnoyklUJSU92tbvh6mM1w0aELWzxpxhkzqpLH89F8caE4+ZcrLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHC+Rydyl525ArjmxSqz6tv9yPWTrI1+T3Z7d66GyqQRyTckiQ
	fA9NGu20Gwaup4xOYigejd+ghs89pwTrpme2r6EH9zciLPLvu6wW
X-Gm-Gg: ASbGncvpzZvaoyInZCGqdPtvTAoaStVPa1dyiEaDJq0EzDbYIJ1kvVOey46zxlbNaFw
	XSub19/ucxP9fPgLtqhD7wcIS39he5Cik9XeJRVugePEjt3zZSQEd9BahQ8osDpnwWh5XgmrkWH
	0bLUa5kozF21tZeUa0bVKFQFcH3oUEp6hqLwHIVXnHXzXIwHQ/hbdFnX12vAqlX68oTFFP4ITpN
	XGsI0tEDKkXqHfx3z62cNvseD17xTo63aq5niYsSPWFmgZap4lPfGpfEvvGqWdQ8ef6wMCFH9Kl
	e4U31nHrV3NOCVAu
X-Google-Smtp-Source: AGHT+IGECzW3fSF1xoqweSC//Ej3VoquTbE09pIlohYYLP6905BQnHOPle4p2ajo3BzRgmjrjGxIzg==
X-Received: by 2002:a05:6000:186b:b0:38f:278f:58e4 with SMTP id ffacd0b85a97d-38f278f5963mr2846752f8f.12.1739484985733;
        Thu, 13 Feb 2025 14:16:25 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:594f:c4b7:a2b1:c822])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc45sm2974803f8f.33.2025.02.13.14.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:16:25 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] nvme-fc: Utilise min3() to simplify queue count calculation
Date: Thu, 13 Feb 2025 22:16:22 +0000
Message-Id: <20250213221622.81457-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor nvme_fc_create_io_queues() and nvme_fc_recreate_io_queues() to
use the min3() macro to find the minimum between 3 values instead of
multiple min()'s. This shortens the code and makes it easier to read.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 094be164ffdc..4fd1669231fd 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2897,7 +2897,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;
 
-	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
+	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(),
 				ctrl->lport->ops->max_hw_queues);
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
@@ -2951,7 +2951,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;
 
-	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
+	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(),
 				ctrl->lport->ops->max_hw_queues);
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
-- 
2.39.5


