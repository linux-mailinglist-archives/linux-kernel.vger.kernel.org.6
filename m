Return-Path: <linux-kernel+bounces-342513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C5988FD0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16E061F22059
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E8F1DA23;
	Sat, 28 Sep 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NKpd00nq"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789001C6B5
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727535697; cv=none; b=Ulri3CQPV9jmUGAJ0Gueto31skPkcu4HRYc+bbxCsQpp6jxwStulAI6YZekl23kQmmYKcIKqItZz2VjEVSLVpIopnxzGp9h9qGp8q5WLh37XNPsb29r+sVt6xWbkvC/9Zmc0QhdJ/W6G9rTeGXEskMye7MIO+eGHpDzBrX7J1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727535697; c=relaxed/simple;
	bh=hQbNGU+VoX7SrygvtUBPpfRaQb5XWKk/IVkjxCjnCZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iYjwLaPzn9f2sg2eHs4nE+J9io58LMrreRCx+0oz0ECPd2OIo6pljG21/sBO0jiuDEZkKT22VjsuSWX0SJg/sopO7tPn6S/3cgoPIw8FAZxDehDql+6nA/ka1IVES2VvY/CQMc5eIXKy/9OiGslMlytAXqBPHjtqTIluJlfxSXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NKpd00nq; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727535692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FEgxMd7iJWObOMaqxmGr+avDbf/vb2+1l6khmidZT+U=;
	b=NKpd00nqs1RcAhOEZMMQPj3AmVzP32EtusjN2EIY/PIeoH3KZFk/40qoHv8YMC9D6TxmoR
	zBO2SNzlwISr8ZOzHtSQuetPlY2rS0QkkZc2xnyXzm/ywEK3BvLsM/B2pYZHra/qj0E0cp
	8kMpUR3Y6iWMRcosJDohLcb0sdF+yrA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ksmbd: Use struct_size() to improve smb_direct_rdma_xmit()
Date: Sat, 28 Sep 2024 17:00:30 +0200
Message-ID: <20240928150030.1217-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use struct_size() to calculate the number of bytes to allocate for a
new message.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/smb/server/transport_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 44c87e300c16..17c76713c6d0 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1405,8 +1405,8 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 	/* build rdma_rw_ctx for each descriptor */
 	desc_buf = buf;
 	for (i = 0; i < desc_num; i++) {
-		msg = kzalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
-			      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
+		msg = kzalloc(struct_size(msg, sg_list, SG_CHUNK_SIZE),
+			      GFP_KERNEL);
 		if (!msg) {
 			ret = -ENOMEM;
 			goto out;
-- 
2.46.1


