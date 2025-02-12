Return-Path: <linux-kernel+bounces-511092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E8A325B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B87188BC51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C88271831;
	Wed, 12 Feb 2025 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IOFGbOKP"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB627181D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739362581; cv=none; b=dlsZSJUoZpLVUJTX4DZjV0DQk4KSh6PXf7aVjk/yv84o+kGsoV4goHx1lu1IpSQ4psGHGNg2giwuo5VPfUGbYwbqhTNEpTG8EO4la/3qZHmrMusslpov8hEEC1mQJJ+EEucvj3zKmRFH0HDkVhxIdb+k9LUedqx+24WImEKtIXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739362581; c=relaxed/simple;
	bh=IN8Pt7VpLQIzvHLgaBpXpGJky2YGCtWwMLRj2mJiMwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DH8tgw/NhNO+P9blGXuqRkS5cRuj8ncR5B7zYjrl9KTM9NdZHhWb+xIOzpTjcT3Icgee01dgttsAVZMbRrEGda+UOVibXufHBOigEFiNtHg8ZdNKG8arLW3Yrzj9Ie9mhGciilswaT5w9zKeh6oNlYazGR7xky2Q9eNoBi6etRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IOFGbOKP; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739362577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w8v+W5qKG0FRQRTW2H8mBvyW6V4jA7wqbBco7O0n7Y4=;
	b=IOFGbOKPZsiMPsodyoVt34DWKU8aFpw9cXqo+zzYGqb2BdCaUwwso4qm1+CL71isMzFC8A
	P2Q0yK7oDK5PYMbSZDQ/BBHdEDwJCyQaBRuXw521t9o1jekLSBiuJOpnfk8zmMtSQXuicQ
	NuXiQJKNKGnQwYYHJhk0zG/FH+oeM6Y=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ksmbd: Use str_read_write() and str_true_false() helpers
Date: Wed, 12 Feb 2025 13:15:16 +0100
Message-ID: <20250212121515.112430-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_read_write() and
str_true_false() helpers.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/smb/server/transport_rdma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index c3785a5434f9..1b9f3aee8b4b 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -14,6 +14,7 @@
 #include <linux/mempool.h>
 #include <linux/highmem.h>
 #include <linux/scatterlist.h>
+#include <linux/string_choices.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
 #include <rdma/rw.h>
@@ -1396,7 +1397,7 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 	}
 
 	ksmbd_debug(RDMA, "RDMA %s, len %#x, needed credits %#x\n",
-		    is_read ? "read" : "write", buf_len, credits_needed);
+		    str_read_write(is_read), buf_len, credits_needed);
 
 	ret = wait_for_rw_credits(t, credits_needed);
 	if (ret < 0)
@@ -2289,7 +2290,7 @@ bool ksmbd_rdma_capable_netdev(struct net_device *netdev)
 	}
 
 	ksmbd_debug(RDMA, "netdev(%s) rdma capable : %s\n",
-		    netdev->name, rdma_capable ? "true" : "false");
+		    netdev->name, str_true_false(rdma_capable));
 
 	return rdma_capable;
 }
-- 
2.48.1


