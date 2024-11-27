Return-Path: <linux-kernel+bounces-423198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563959DA42A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC897167EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0C318EFED;
	Wed, 27 Nov 2024 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1FTM1/0"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3A1925AD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697549; cv=none; b=ri+yCm9DrtsGSE1T/dJmbwG69tV4RQkMgsQPLcpv4mCv5fFOJXKYJBQY0atFwXgW2i/EbBbDptTa2hCP2zFFjiS1bU+GIsQKMyWKp3NGCay5+JRGWR0XPIjnvlF8MI8ePjL1vdWoVig62T1wcop0G6Z9tskuD1YkA+zwy4D+rCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697549; c=relaxed/simple;
	bh=1HDKk/Dd+pkpZa+2tIr+DaBy6svxJk9HZbJm/yZlWJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=czyLgkFN28aSHZw3AUk+wUwLLjPsPUwv1PXv2BRKI/fJIOiptRTyY5hxVDe3ueLg4YBe4S1JDz8PUnl0ZeGiphLbA0JKtyYCuPC/TpBWTnx48f2TwGzgybkwvGEDccZ3VS/za64dpen5cccdaheLMKY2cGJ4FibXHmLGN3/wf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1FTM1/0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724fee568aaso3611142b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732697547; x=1733302347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RSIHKTpy8icvDsa4C0bncAYt/fFFkTLxjGVcQzpyx0=;
        b=m1FTM1/0rweG1KX5S7l2Af6IpTesBnYVxFXGfJ6RhL3gODRx4OjMU/cQCW+e4XnZ/P
         4qHqiaNzjZQN5IgXDHtINZlBxgMGZLU9LULP5HMfgDCbA+JdKQlJiafK5C3YtYwOLh5r
         kyoD2qDpMNOlMTLdvk2nehpHASDj4teewREaJdRmlqrhzvToE72ChSjZyk+ppxvGtLa0
         EMj9Aut6Fp6q0EiyAWG0EnPLKfxYcN24Qg4HewJEAATYIZ+3n+dB+YGjSTgkELyaCm6H
         F00VY4VWyCV2d5bXuxiO7QezYtdNmGz/CbHKiDSKMTUY3ZFCZkZ3/089tkcyJToR8TM5
         tdmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732697547; x=1733302347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RSIHKTpy8icvDsa4C0bncAYt/fFFkTLxjGVcQzpyx0=;
        b=k37rIPg3dHaGMXPs3Vrp1oTEAu4Oo1HSgMDBJj8jjfd2fNMOxf2oKbDFCs6+Evifai
         QPA+ACN+NF/cznMQQT72vmw5j2XbEfQCVz65QXoSxiV4L5PbbS3YbFJvTy1jG6O1c2lI
         wr5vpH5P7Q2m4kYge6lxqzEfZcvTiqGGOZCkxkeSykKQi+JdqNwVJ9m36Rwk/22z1LBK
         A+rzB3iK/CHC06/qJ69UYzerHGirEbf+4L/Rvm4taBkN5ZtqrYw5Cti23Bhbzuj7JVFM
         IWq25J8pvuj626uWbVYHx2roodyuJLaeDnNQL11S4MN2CzW7cuS9ar9AbBlm2OQvd/EQ
         WYRw==
X-Forwarded-Encrypted: i=1; AJvYcCWzWyTXBQ0hgPrgmCO9cZJXXo2d4RGWgPUp7UNco5Kivix6FChBOOJ2tliPy5u3GBr/U7eqgTtVH8ZhADM=@vger.kernel.org
X-Gm-Message-State: AOJu0YztPBtnA+J79EUo+HiU3GMjakh03ciLbZJTBh6mRk9QChrIMJ3H
	z1Snaf17WZJETtSscKwL3cniUhVzfz7G8XwVB6n/iHFvTadIlNy1
X-Gm-Gg: ASbGncvHa1GlGkF5iGjm/h8Xj4o17SM8fSPv9smq1yPY27do52OC2138Cb0/gDveCdw
	chwKhV2ihwhZMUjsmAyyvZ36IKxLEDj/s3Hed6h8VLAjL4Atb7kxa6qTdFvCPaIbH2tgrT0uO5s
	KtYtu7ai/WPa9bYNL93/nLGEq5iHcxdKetF9QxFAmGIxzjzSoi7CwIbj0SZ8Czlcd7jKy8jZnaz
	yrwCLrAltHnfC4s93dpRXF2Xb/SJ76vMTGRFkMCEaKDK7nAvd1UVgKYfkAZHA==
X-Google-Smtp-Source: AGHT+IFnDmXR5zcT1/Y9Mc2kxjwApnxXnOIz6wmA06+t0D7T3R5QzG3gdIfmwN80A+SWqMRjZsk87A==
X-Received: by 2002:a05:6a21:9986:b0:1d9:c615:944f with SMTP id adf61e73a8af0-1e0e0ac35b8mr3936370637.11.1732697546789;
        Wed, 27 Nov 2024 00:52:26 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa60091sm960531a91.20.2024.11.27.00.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:52:26 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] nvme-tcp: no need to quiesec admin_q in nvme_tcp_teardown_io_queues()
Date: Wed, 27 Nov 2024 17:27:49 +0800
Message-Id: <7e662471e392c6b45fc37de94139e886c53c9cdd.1732699313.git.chunguang.xu@shopee.com>
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

As we quiesec admin_q in nvme_tcp_teardown_admin_queue(), so we should no
need to quiesec it in nvme_tcp_reaardown_io_queues(), make things simple.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 55abfe5e1d25..98bf758dc6fc 100644
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


