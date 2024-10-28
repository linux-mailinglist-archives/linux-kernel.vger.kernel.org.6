Return-Path: <linux-kernel+bounces-384803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 400279B2E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8EB1F211A3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E821D88D3;
	Mon, 28 Oct 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i/F376S2"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7C1D223C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114016; cv=none; b=N6Y7fE0zTi/oilFFuSm0ZF0tD1AtrrE7Beg1YnDvJ3XXyylFz/9dgM42Hp33IJxnSNrsDbrp9MgExiaPexzMhctUnlAfuwR8sUIID5Gh5JYA3kj6eBiWG1wOdBn2w5lzTFmx5yLD/xWvNYvPvMfOYbyRAkuoxfbrXUECCCIOXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114016; c=relaxed/simple;
	bh=NDaI99AhgBFWa34DzClcPAICbyApKXJLL06DCw7Bvk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HqdVB04PiyyAxbk6hw1qXlgo3vqM+fGz68/ZuhyiHdrN6UkbUb3rRNZ8TE3tXaaD6U6kBc12VLv8ZJCBLIPX2nmyjtKR6CHDdYAG0bkUrZYrPEEpkRN1CzmK9T964ZlURCAV0dPnndZ72NErtbgmboP8842l1L35zcgJhAwWOlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i/F376S2; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730114010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LzRs0q/0tQyiW8Vvg1wCm1ZdQPd1qYE7s2gqV/ibHLY=;
	b=i/F376S20eO5IHZaY+lVxqg+2yn/mriiP0DG5CSmYoOTi44u2VInsYFrWqm6UoOr5594Ga
	iJoaBy6Drrhrg3upCSVFPBFkgYJmZuvPHKo2ivzxyn/Q5e5zUC8Z3/0FlkRpBMHbcX+TLq
	2iFkUD9z7R/fqLlHkUy0g2F6pUxwqbQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH] nfs: Annotate struct pnfs_commit_array with __counted_by()
Date: Mon, 28 Oct 2024 12:13:12 +0100
Message-ID: <20241028111312.2869-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
buckets to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/nfs_xdr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e0ae0a14257f..e74a87bb18a4 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1331,7 +1331,7 @@ struct pnfs_commit_array {
 	struct rcu_head rcu;
 	refcount_t refcount;
 	unsigned int nbuckets;
-	struct pnfs_commit_bucket buckets[];
+	struct pnfs_commit_bucket buckets[] __counted_by(nbuckets);
 };
 
 struct pnfs_ds_commit_info {
-- 
2.47.0


