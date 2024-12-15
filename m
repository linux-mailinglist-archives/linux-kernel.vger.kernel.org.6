Return-Path: <linux-kernel+bounces-446279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17B9F2223
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47DE1165CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE3AC8CE;
	Sun, 15 Dec 2024 04:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpSrJb1P"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55668F40
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734235232; cv=none; b=dsPtfWYIHEvgJl7sIdYVtzVRDpv3DIK0ZYExNM0+sxz8xCZz6Uc51/U2WhbAqnbZAR/mvZn3yH9OLbRLh5lEsT1m6DhVGMy/nJuV5QL9ZJNbBdhxrPrBKKLp6xoLikFuflrsCPOaDZ6GKIFzak44JcfFdixUB73KhrvavU6LUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734235232; c=relaxed/simple;
	bh=AhHs8wDXptTDXqO88AynHTjfp9xWvm0BZ1ABm1nrtek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tb2HCnDuDwyaJIJiLZ2iD2qV5ixCpUn9qnE5C2xrVnBE39wXRfsU0s+A/IgGxIHVvyn+IX/REzi6t58UKPyoPhVTxW8Qzm2xTcj+68eD8W/NEKehotIOJqsFzG1R+7dMmKYRdKoUNNFBuqc6i22f9NMKRY4DfOiEFWGMwbMelGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpSrJb1P; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b15d7b7a32so320290685a.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734235230; x=1734840030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9GqpNH/QUF1rjt8cgarwiZ2r7vZlmB7WaQfeZrmbY8=;
        b=cpSrJb1P5xre3gcOE8fZWK6GoAw7OJF6zDr5sqCmngZGwGmtUXIu6hgVJhALSDzrKh
         +qA7aw+/5Lb2fqbRFNYURsmRguXwwWVuxM/OEPJ2fZOaeOyczZj21YZ5Q4XQafDqETAd
         EG54NixqAPliZKZ/AXFjOM151R1C4+mHwiBT3vD750OdJ5qWH6+yCRibmrFusdi91YBx
         2p6a8W5E2964HhpIX3cRGf68YrVjvEpVTX3lVcZuklu/U2v3h5yy8Em9pBc8zQTYNVK5
         9ZBcbcD07cSK9KmB73mknvKwSn80b8hT2BwZe7Qy4WSFNdzcTZyw1JpOcdvZJGPk6KnE
         7MkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734235230; x=1734840030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9GqpNH/QUF1rjt8cgarwiZ2r7vZlmB7WaQfeZrmbY8=;
        b=oQcvCVoMuHzJt2A9PDIh2+dHJWNrVuD2/3uBrysWUHnIypOT1moCXS6ZQRzNjrQ1+X
         KruiWBw2vYy5TeMyDe2KEosNBxGAXCrqjZcEf8d1liRmGf8Gh9KBOLWnmDLVZHIRvJwk
         r3Ly3d1f0SYVkn6Clu/7GE4RE/kANttl7PnTYCjZEyUPR/m/DB39aKxBWGoQkp7VqHgL
         QiN1N5FbG3CFBGhpVpfl9w3FnvTunemVrR7xcvzXtC9aJ30aVl1bTDgMhTLQmMXfBs2w
         uTygDWDQ+ow+7xxZgWbdec08JGE8sshiE28+L6Jx236aheJ8Whqq3UoVY4TL9T5E1e4S
         /anA==
X-Forwarded-Encrypted: i=1; AJvYcCVEZ90QUryTPEYFJOw+mUPJJ/r+07wGCd18PNnE7PA8cvrz58YSWR+DL8uT1k16f6cVWQ4IOB8ChNdMJgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTFSRIgjM9sVhlIwlmNF6lWlefez3rLcozKsgO5o/eFTaKqQul
	8dMXngsBavVTUqraslI4wFcWWxLVaXMkIW7aidsiMoVr4R3XALd+
X-Gm-Gg: ASbGncseKKH6jpnDV2v1kvf6C2uT1X4csuR2k3xEmt+9gVdj3J39meJ59X7uCtZyE2b
	m+bXJGiymyISdvtfEXK1b5TI3qeFVU2rFbw58U2jSQ6JMjs1q5Y6YQkXPxr/1aGQnvAw4wZmajT
	A3RyqZq6BBzT/iZDd9Do/+CcF+TA1pozp/YuXJrZ9RsrTVuk1ZT7bC3jA7BLxn0OB0+4qnMv1CA
	oMGaE+e1K5Xf2u2u90QYzIIfEGaUid9E+tF/axqpS5bc8CwLD+aiNNVDU5BmmfonJkH/piw37vK
	3rWwsmUQ3RwncFwIfLZ2dKJCrU3kAg27z+Y=
X-Google-Smtp-Source: AGHT+IHxa9F8PDQJ3jj9NFmjBJdz4vd3H5LBFlmQ12JfK1aWCMiYBrBOyDF7CcAl9/TzRYCuB71UrA==
X-Received: by 2002:a05:6214:508f:b0:6d4:243f:6c9c with SMTP id 6a1803df08f44-6dc8469848dmr143052216d6.9.1734235229718;
        Sat, 14 Dec 2024 20:00:29 -0800 (PST)
Received: from localhost.localdomain (d24-150-189-55.home.cgocable.net. [24.150.189.55])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6dccd22fed2sm13365546d6.10.2024.12.14.20.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 20:00:29 -0800 (PST)
From: Dennis Lam <dennis.lamerice@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+d173bf8a5a7faeede34c@syzkaller.appspotmail.com,
	Dennis Lam <dennis.lamerice@gmail.com>
Subject: [PATCH] ocfs2: fix slab-use-after-free due to dangling pointer dqi_priv
Date: Sat, 14 Dec 2024 22:58:29 -0500
Message-ID: <20241215035828.106936-2-dennis.lamerice@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mounting ocfs2 and then remounting it as read-only, a
slab-use-after-free occurs after the user uses a syscall to
quota_getnextquota. Specifically, sb_dqinfo(sb, type)->dqi_priv is the
dangling pointer.

During the remounting process, the pointer dqi_priv is freed but is
never set as null leaving it to to be accessed. Additionally, the
read-only option for remounting sets the DQUOT_SUSPENDED flag instead of
setting the DQUOT_USAGE_ENABLED flags. Moreover, later in the process of
getting the next quota, the function ocfs2_get_next_id is called and
only checks the quota usage flags and not the quota suspended flags.

To fix this, I set dqi_priv to null when it is freed after remounting
with read-only and put a check for DQUOT_SUSPENDED in ocfs2_get_next_id.

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
Reported-by: syzbot+d173bf8a5a7faeede34c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6731d26f.050a0220.1fb99c.014b.GAE@google.com/T/
---
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


