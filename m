Return-Path: <linux-kernel+bounces-576366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10743A70E58
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570B1177310
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644AD3AC17;
	Wed, 26 Mar 2025 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/oc9jYv"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB5323D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742951400; cv=none; b=un6AM3iDq3GRX1VjukYAABq/ZzIay67Bq2E86P0WtuL/XiaLmY8cUgmBk4giDWLAKfV+J6h9uoGzgDjeE3pIjHgloPU3//kCdnC/siWTcxh+Ln9v0HaiipBDudefyvGrhnUki2ks3M2mlYxgT1k+RD7hry5LrZYYmNC9fw/a4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742951400; c=relaxed/simple;
	bh=9pMakLupZf1ZOgdVZRB8Xrg8ib6rp7vApnnpEdQilY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nk3SIN/Pg7GuyDryUxSVM7VXxt6IEJsE5969SNEUx0VbSfSamH6Eyl00EE6DqViBeNhpp92uUc9EqtZIFAt+5JAKp21KSH5v7X/f9fH0puRddjw9Is1w9D3HXck0Z0mKhaj1+iuc4uG6ts56N1bzzRbH+5LSIKCAB1Iu72QHp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/oc9jYv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff69365e1dso8664176a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742951399; x=1743556199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDUlb29vBiX6H2YK2qWRNwPg+NjBtOzJ4DqHPrOXp3o=;
        b=S/oc9jYv2LoT0iTHGukbLMmpvtoLP68PFwq5tlkctr44P1wshJQRZdujKJnICKL565
         8cnxWhPQCXIDpCyhCtKYkeAM08lcih/ot2iP0+fsfa7qniT9Yl29EMkqvTTayiL4Cdfm
         lMgU8ETTyZHp+Jaz7/8TH0w1puoJ3yZ74u3lsORmgq9B/oDgwxDp5kqrVkuW/akXdkFY
         aBF5h0TY2bGftHttTDrvBMufSC7DH/mYSS0mRWczZj9g3SlktEeunxP88er7wdlACEyJ
         xvCRCMXCrAUjln23/oLjwK8+qSnEBNgIIAWkdYN2/tP5Ju1NgCTGgEvW294MwZznG0Ny
         V/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742951399; x=1743556199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDUlb29vBiX6H2YK2qWRNwPg+NjBtOzJ4DqHPrOXp3o=;
        b=gQXxGOeIpa+z2IT+HxTw1fMu9s9zOgZq8ZG/s8WgQfukGSzWjRfhx8v7gf6/ur/tIt
         vQDtZYcOdRUuKzO0fZQ0XoYy5Nq5jvWQn3l+ZDCkMJ2iFsVq3oGdKvTeqX50bSpVq7cX
         htmFyvAvXHJ4DLSNvHA4NwSSr6UCyrycqjzJUFCcg/PCSqif9/FYFNR/2PU30WWJ2hl/
         dEVcnR9wcw1M7RbasCmOeWH8KKT8s+pxuTBrzPEXaYlFDvpM/u/JULpExWMDFS9PUBjd
         Z3zxXELVt5uNcArLbYC6N6v0reR8X5izdpf9B7n7t3oaUNkEh5trTe79aozduBXJKLNN
         9cUQ==
X-Gm-Message-State: AOJu0YzQCQim9cXyL6IBFvSLcpE/0muvC9ggs8wnhD4rLuCi/h7sEIjO
	A1Hc2uD1MhOa49Wnab2NXeVG4nGyeELMJGApTu9KnluIViH3tVih
X-Gm-Gg: ASbGncuy2M3YX6uA8b4TFdicOCmaiw7NbQK6wpmlFwxr0jv/AJPSs+BmBasLUka5El2
	IdoPH9LAYiq9m+H+9tI82/yJQJIA4Zp7p5KX7PC9WPE+7PFYl3PZrgLIYyqqSF3MBxVWt9YESl8
	hG0cVD+TR3wRg6z5mH+Wwsyg8I+svcT2WwTyeKILHu2t52d0fFfGt7deAHn7V9yQefWy49hn9qq
	O+JKGV6j1E3uex9d8lEJGo9ML7oCNg1En42tBEVVbqgwSyAksLP9AFB5VxZ7uuhKQ2uXmAIvceV
	zlaFBO5PNZtSkX/ByD5XL6QkpRdjQ1pJ85R+hJnL39Mrfk3U3zV85NfRrkGI2UWQRcZSOpdxaQ=
	=
X-Google-Smtp-Source: AGHT+IEvHx3yUiDaq1adNzrPbXDj2nNf7JlV9ThMH85Xerks1PyOMSAuFX46YRrkWA6aK7ADD4RulQ==
X-Received: by 2002:a17:90b:2704:b0:2f6:d266:f467 with SMTP id 98e67ed59e1d1-3030ff06e33mr27059465a91.34.1742951398516;
        Tue, 25 Mar 2025 18:09:58 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:7cf9:c75d:456:248c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576aa7sm15186649a91.4.2025.03.25.18.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 18:09:57 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Date: Wed, 26 Mar 2025 09:09:52 +0800
Message-ID: <20250326010952.8878-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
References: <67ddd191.050a0220.25ae54.006a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 fs/ocfs2/quota_local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index 2956d888c131..c0bbfdab40ec 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -302,7 +302,7 @@ static int ocfs2_add_recovery_chunk(struct super_block *sb,
 	if (!rc)
 		return -ENOMEM;
 	rc->rc_chunk = chunk;
-	rc->rc_bitmap = kmalloc(sb->s_blocksize, GFP_NOFS);
+	rc->rc_bitmap = kzalloc(sb->s_blocksize, GFP_NOFS);
 	if (!rc->rc_bitmap) {
 		kfree(rc);
 		return -ENOMEM;
-- 
2.43.0


