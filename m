Return-Path: <linux-kernel+bounces-446258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9229F21EA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D00188379C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 02:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9057979D2;
	Sun, 15 Dec 2024 02:37:42 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D35440C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 02:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734230262; cv=none; b=H19B/eVymyY+MLzVmm8EoZfxBxstTRPYJ1Cj9q7vH/lHRzSxRG/WC8kJQMU7dgiEs1W6vKUkvycuoe/XYBRmMl1URLPkfx6p0VBnb69E/wyQ3cqFUoN3o1lZDT+1W8JWYBeNIuQPt93Hqu3kwGaL/fZO5qAlEZovdh8yKLaq3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734230262; c=relaxed/simple;
	bh=TB1wVixFXdlGu9akKALJ044gw3GijNZ93/Bm1FW4rkY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s99tHvY2p/uLhgLqZ/f36orEhxqhRNMNHnvn/kOrWFtFnxZqzKZF4q+iQ41qwuxsEYpEM5ef3eO9GLlhrUyUBuwg7SE49Cok8ypjdeKWo0/wJgvMGfS2YDIxpBhWg7+/UX9qY0/fWXZlOjZf99eZ+19sLYDhQ77YjD3RZWS+QQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a817e4aa67so27451455ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 18:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734230260; x=1734835060;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNvB3blcDStCceVeRB+zOiDFtvHCvB5Snn13kn6G2xo=;
        b=o9yFns2wRDDR6A8TyuAkCkD3isd3WfCGdq5ZITHPGG0Z/PLly9xCux3G8KMqbrDxoM
         9GF+vA9yvapLM9ijUQ8MBX3L1dP6Rqbmo03ny35jk8koJeH/354R5YZ4DPvzhZ2+uVv+
         on6hvmj6b7EcTomkyRawlC6Mt2UfMSZsI98zx//CEg7Au0Cp8Wtc2jXad0a89ViGyD5U
         aUuG+ZLygHVIEpInM7cHmyefMNws2ZI8WNTXtZPES52AJQWNAY96mt0hzUJCYyRFFwCT
         uKquRuyPeU5dpq7Z57gcWs5lXaE7ky2FYdksf0AzuQxXvaB+/mC9iRVjS0h4r2329gaG
         xiqA==
X-Gm-Message-State: AOJu0YyqnS0TOL71DiE5bai3jh175Qi1b29gH1E/J65yzftjp0+4w8US
	1vq++Zn2WQVTPm6MiSBRCWnCxWDdEeIsw48UEAGka9lefal+Ph40yeTdcDK/ZvXiT0MXlrLf53N
	KutHxMDoEAbHoTzmoaua7gzUqD60snIGhrUmyasUxoIpUVz6ux7QUaJI=
X-Google-Smtp-Source: AGHT+IFAzh/HTGktq+alfgny3t3XQj19/J3fa/ws9QxRsIDtDptlQXU/vNOHOsZn9YRTGo9C9TBMw95IDbUT9dCvf/cf6jDqmQZW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:3a7:e67f:3c58 with SMTP id
 e9e14a558f8ab-3aff6213becmr85394995ab.3.1734230259881; Sat, 14 Dec 2024
 18:37:39 -0800 (PST)
Date: Sat, 14 Dec 2024 18:37:39 -0800
In-Reply-To: <6731d26f.050a0220.1fb99c.014b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e40f3.050a0220.37aaf.00e7.GAE@google.com>
Subject: Re: [syzbot] [PATCH] ocfs2: fix use-after-free due to dangling quota
 pointer and checking suspended flag
From: syzbot <syzbot+d173bf8a5a7faeede34c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH] ocfs2: fix use-after-free due to dangling quota pointer and checking suspended flag
Author: dennis.lamerice@gmail.com

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
#syz test

 fs/ocfs2/quota_global.c | 3 ++-
 fs/ocfs2/quota_local.c  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index 2b0daced98eb..c6d38340d6d4 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -893,7 +893,8 @@ static int ocfs2_get_next_id(struct super_block *sb, struct kqid *qid)
 	int status = 0;
 
 	trace_ocfs2_get_next_id(from_kqid(&init_user_ns, *qid), type);
-	if (!sb_has_quota_loaded(sb, type)) {
+	if (!sb_has_quota_loaded(sb, type) ||
+			sb_dqopt(sb)->flags & DQUOT_SUSPENDED) {
 		status = -ESRCH;
 		goto out;
 	}
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 73d3367c533b..2956d888c131 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -867,6 +867,7 @@ static int ocfs2_local_free_info(struct super_block *sb, int type)
 	brelse(oinfo->dqi_libh);
 	brelse(oinfo->dqi_lqi_bh);
 	kfree(oinfo);
+	info->dqi_priv = NULL;
 	return status;
 }
 
-- 
2.47.0


