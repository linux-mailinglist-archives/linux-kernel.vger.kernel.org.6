Return-Path: <linux-kernel+bounces-344740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 935C898ADAE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43AA01F23DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C2F1A0B12;
	Mon, 30 Sep 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tsBHKcDz"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D0168488
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726536; cv=none; b=MC5JWfFYOeJ92PaEebJgEVR8B/sklHVsxcvf8CStgQ//hyVc+WCiHfWesmAdYYiDileAoLmAHI902Qm0K0h/0CqvpcKQMfneQ33fOBddI/MF10i9QPXs3vjESKgD1Li3asgdsZQwyFeke7VLLslP1mCjQm4IAxtrc3ZogHqPX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726536; c=relaxed/simple;
	bh=wIuUYfSVT0XI2jcbvK+amodwFkiUndP0Ha77iJo6WCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UahPe2L3z1KFMVs+XyZ2No9CYjYeG1P+BUbLENAP6Cj6YgBBYIAGW8ehVosX4Hrw1j+o21hrBDG3Yl/G+nrbdSaxPxGzfvkTtVK/Cd0H2oDFheh/rZdm9lf4DQWDYCfSugtj3nJcXnTDjKOvgeE7HqzNVMrVXzWyABnFAWRnVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tsBHKcDz; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727726531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e4HLf3EEwMx5ef4BEW299GgzqvGUU0zCZtHcdl8wNf4=;
	b=tsBHKcDzJvbtDa+O4EkUucZLumrBF9EA0XMxlcQfKg/JgUlcQXJOMqjujXZnVPk6Zewhl5
	VJEWxB7+eGUo82ta4XnZHKlcRYUnD1FHhd+JtMdJx52ZEkxF+r+uTlkFuvBqrWSYkT2Oeb
	4Br/MN7BUqeVp6+j5rPUaOztJPGyAUg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jiebin Sun <jiebin.sun@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipc/msg: Replace one-element array with flexible array member
Date: Mon, 30 Sep 2024 21:58:22 +0200
Message-ID: <20240930195824.153648-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct compat_msgbuf.

There are no binary differences after this conversion.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 ipc/msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index fd08b3cb36d7..ee6af4fe52bf 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -978,7 +978,7 @@ SYSCALL_DEFINE4(msgsnd, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
 
 struct compat_msgbuf {
 	compat_long_t mtype;
-	char mtext[1];
+	char mtext[];
 };
 
 long compat_ksys_msgsnd(int msqid, compat_uptr_t msgp,
-- 
2.46.2


