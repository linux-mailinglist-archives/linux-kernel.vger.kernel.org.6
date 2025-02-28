Return-Path: <linux-kernel+bounces-539640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010A2A4A6C7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 01:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C588D3BC31A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20EB1DF98E;
	Fri, 28 Feb 2025 23:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QeCRZzBB"
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824101DF747
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787194; cv=none; b=HteN1reoKKItqAP4+yu5ed/sVbruexyHfEfUlprZUMMH5xQ6kD32LtNiKv82/yvOpJtU2R2dYM/lMpLK3nzGB8GUxzaf4VDcLOqzH/IULzsv1gFSCDY8t/Rr/d1csChAl8qmmUpo01F/5BDkpazBwcokTcpRQNsPtqqSbzfhkcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787194; c=relaxed/simple;
	bh=M19kqPwNW3vIXGn+RbcnqMl8wOB9w+/nhDOK8KFUgxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7n+XCWkDQeT8CgTpUsyqeOq/W5J5TZ5RjyKpb7+pXigUqRsNEKxR7BZU0biQ4j8nzdysTSEYd4X/wn4FE4QcLiHg3393MJ2ZVTEuSDZVsc7SCgElKiL+havgVKuw2MG6/cBVnV0qVQG8FPlRnuAGA1In7nnoVJgms+/VVtY9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QeCRZzBB; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2232aead21aso6696515ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740787192; x=1741391992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JSAJMXS5kmM5iwGMwe4iAEt0SbX+ffh78y3gp8LBwPk=;
        b=QeCRZzBBjv67C1z6Ur4k1aan8mf2RiEZL1RAvXNWeTm+4Xn/p8GKEqJCp61s4vwo77
         V3Yw4CByOVqjDbbDHt4KC1NNq09SbuxDMeJtngwf/1wKjzfuPEvMYghP9peDBiELIbCi
         deB0J1S8IXuVxoJM+E9Nod9NxEzdYFGQfwg3lRt1gMnn6wfWh/CmAVQz54zOu/nibnXu
         dvBY28CisI6EajoA7+NFNGmf0y03XyIm4wgRGDnEXt8jGrolUhr4N+vyyNaPobHbYhN+
         cU9+E+Auc4dRFV5jCst0jayLiIIcQuVzDyIeOuMisSLij0h9avm8d9NyvI8CtdVNBGNw
         x8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787192; x=1741391992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSAJMXS5kmM5iwGMwe4iAEt0SbX+ffh78y3gp8LBwPk=;
        b=O7VkA6Q6k+j8gbhsRTQj8Q6OgAH6WTZOHUM3A7l56QhvGPTXmDT+yYOOFNDB14Dvc9
         am3yd97F1aFb4f6EOaeMT8jJzJK5jILiMq50MBW8ELQ1oFZcnvGfs6P9CQOMLrLTyEus
         7rn86t/a4Iu2xDRNur8ubtS5Cqo9KHTEcj1EGEjSff4FIaBEy7mzcqXf+EIVZ4AeQqI5
         k157aBaBhJSc9O98CZ90JiEu5OwgYzVkFsiGt9NLuJiAssfZFMRdpvC8v0sCGhcQ9uXK
         paH0SuMbdMBjYgsz4nLKY+I2Kf1ZNMyWteUi8T6NYgec9s5nSRxnyXM3ZfiJ1n0qbW44
         yZJA==
X-Forwarded-Encrypted: i=1; AJvYcCWI3fpFa16ntTddluYpr487olkfASrDcTi5dXwaZJ0KKcvqudILoHfV75ixh7RXj9WQ8bpFGJcgYLI1ibw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOxMIcxkWAn/Q1/f2582roE/zUSvE/GB/FBp0PKlRoW5Dc4qr
	xeN5O5rk7F7RtH632XwR3yH+AmsNQtid76FDnJPzyLO3d7n4/EuFOx7NbBIfhkC1DACLY9jMggY
	MRnFKS9xhFgxCVSXLfREItRd4AeSk6jLx
X-Gm-Gg: ASbGncs9tH+rahJquYoGmvGrW1mI4zn5XqVRL8hVz9R3sgUQ9xCv/NExo9RhHWSDsBN
	2bMnhEBiQmHz7E3EMJyU480hIPeSvBoV3b3EysBy4Iotte5Gamz4BmDMFZW/tpnRjfsw+pwHGGc
	NGBbjzIg0R0X6aJsme/PC4WDPIutHSwQagceYqp2P/2NYob3Mp4gzwDvH7pGTZlnHoIuTSWGTA+
	zA5pL7kMmaE5ereU732vFjTFsj+0Xfl97IRf33Rz9fxNk7KEIczY+QavoLZx9ND8zJPPh6L+Pzz
	eSReSkcOZiXnHD0IiBS83J3ogCF7B/EwqLyJghh/iaseahPN
X-Google-Smtp-Source: AGHT+IFXwoTbx+UT09HA0mseihQdFnNVZNlDZ+Vyxp4n3cmTdkTekPi9axOJaI12Kcp3hl9Tn51ew5XmZClo
X-Received: by 2002:a17:903:f85:b0:215:3862:603a with SMTP id d9443c01a7336-223692477f6mr31720455ad.10.1740787191655;
        Fri, 28 Feb 2025 15:59:51 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-223501fb591sm2330175ad.44.2025.02.28.15.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:59:51 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 36D4B34028F;
	Fri, 28 Feb 2025 16:59:51 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1F621E419EA; Fri, 28 Feb 2025 16:59:21 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] io_uring/rsrc: split out io_free_node() helper
Date: Fri, 28 Feb 2025 16:59:10 -0700
Message-ID: <20250228235916.670437-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the freeing of the io_rsrc_node from io_free_rsrc_node(), for use
with nodes that haven't been fully initialized.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 45bfb37bca1e..d941256f0d8c 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -485,10 +485,16 @@ int io_files_update(struct io_kiocb *req, unsigned int issue_flags)
 		req_set_fail(req);
 	io_req_set_res(req, ret, 0);
 	return IOU_OK;
 }
 
+static void io_free_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
+{
+	if (!io_alloc_cache_put(&ctx->node_cache, node))
+		kvfree(node);
+}
+
 void io_free_rsrc_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
 {
 	if (node->tag)
 		io_post_aux_cqe(ctx, node->tag, 0, 0);
 
@@ -504,12 +510,11 @@ void io_free_rsrc_node(struct io_ring_ctx *ctx, struct io_rsrc_node *node)
 	default:
 		WARN_ON_ONCE(1);
 		break;
 	}
 
-	if (!io_alloc_cache_put(&ctx->node_cache, node))
-		kvfree(node);
+	io_free_node(ctx, node);
 }
 
 int io_sqe_files_unregister(struct io_ring_ctx *ctx)
 {
 	if (!ctx->file_table.data.nr)
-- 
2.45.2


