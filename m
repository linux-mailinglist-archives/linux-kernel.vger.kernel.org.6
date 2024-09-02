Return-Path: <linux-kernel+bounces-311722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAB9968CC3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCC31C21D0B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF71AB6E5;
	Mon,  2 Sep 2024 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huRSnvXO"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF919F129
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297606; cv=none; b=kSf+fuUQL8NxvYJDmNXFjdiQ64QE2lnYOaS3VCuzB3H6opfmDlQFDouPFPmwMPAW6b2iHPEePizP80ownSG35YsV4aK1F/xfSBr8J5ENpJhz6B/vDERT6yHtqw9fDUhLu1qchvlC/mSLQeDVRTXiArExX96ZMb1ZPEXgfXei0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297606; c=relaxed/simple;
	bh=4Qhsku91lFKJ8KjbB5aFPJSDK9oNgKbdpsT1c9CLkqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b/tlLXpIzVuD63jXWLdIbQ8YFr8+WJss2YDBLaevK4/lURJLcPDfxlGbQ+ajNK0AU5EQyJS7kABeW32B/veb6hN+iJnobw/43vkc92kcDPeGioe2KT8KQA11jYQ7CUps55tUwBnriV35KSwF5JIGNlo5xsDNmzCKObed4idQZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huRSnvXO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7141d7b270dso3446001b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725297604; x=1725902404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5tfqQDexu4Vmpn8wv3LnZmio6F6PpZY2ba5RnBulZUU=;
        b=huRSnvXOT11RMp+j3FV3ga8clt2nIssOzewPn4gUBhSUP33VUQ9o7K8hkBf96Ne6Jq
         IYtmwGh/37Pn7I+iZ0NdqfODTjjrNfBGHCovEJnsERgPkCAAQdC/xQ5iGAiqrJ5NpaCw
         Coqrwkz2kfmKV+NkC4op9StSk9T0gcd6f/ABmBzIgGPVHitiGqVPLlOvu0+Dnf4PsR9Q
         eYneiH2wT/gZfBr2GYR0N94+C10/SgbvEnL4+chwPjEQrCReOM02OxHq3A9iifVdxZnJ
         p7jkKmUiUK1LSAMFSP6vFBJ5Zxp9/aEs+ZNL1OrVd6+Qv6ZAjdKYgmaQAXOOL+NslMyf
         DmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725297604; x=1725902404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tfqQDexu4Vmpn8wv3LnZmio6F6PpZY2ba5RnBulZUU=;
        b=cjYLIbSA//noe9UdlZguUVedNeKVTraa8hiJaBhy5pSCcPZZvrlNQqQ74aeJEqHaXm
         VOS4BluR34mVDQSlbfh7lHV7ajFESTd2dzmKtO9T0Ctb3TZO6pLTVJ1+Utwnb87F3r4c
         +0PREM6ZsoMHem2yS7U01qKjvl+jS1iDFxQkaJa2YePtlBqcVAiEn0eNniL/okoaOkTl
         C98RIZv0FrmJNsdw9xyMJtTXwWfjwo3DGyzIjs/rgEkNL4ne8AusN7w0jVOzivggYFHB
         pIx6DBSkK5M5sAmtyJYvu4BsV7xpk1tE0shaxLyp2P2Zv7qkSy9pi5Xd9FvkQ5lEYFBg
         kM0A==
X-Forwarded-Encrypted: i=1; AJvYcCUDiU1uEE/Dp7ODj3HqhpF6ZGOokBBF/+3Q4XoSufDWWo8Q3OuoU2jBYW/xgWMfZK5nE9moti+GQ00yLLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcLvPkc7Mf4jr4JUIJNhXM9otg86AwHPn+Xncst57h0GHb6z2x
	qkgVInxysmMnRJ3W+mFW7AmVbWW3JFEaCcH2cuyLhL4xycEqU+IW
X-Google-Smtp-Source: AGHT+IHiDPD5RuKVFF7mAaes5/kv8Ofzqhd+37iBeLG1Tx/crY06VSDQ+QBSi5kzkfUxASSlQlYYrA==
X-Received: by 2002:a05:6a21:3213:b0:1c4:a8a6:a85f with SMTP id adf61e73a8af0-1ced62a2b24mr6259929637.30.1725297603805;
        Mon, 02 Sep 2024 10:20:03 -0700 (PDT)
Received: from diogo-jahchan-ASUS-TUF-Gaming-A15-FA507RM-FA507RM.. ([200.4.98.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e575c0a1sm7096907b3a.194.2024.09.02.10.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:20:03 -0700 (PDT)
From: Diogo Jahchan Koike <djahchankoike@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Diogo Jahchan Koike <djahchankoike@gmail.com>,
	syzbot+7f71f79bbfb4427b00e1@syzkaller.appspotmail.com,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs3: change to non-blocking allocation in ntfs_d_hash
Date: Mon,  2 Sep 2024 14:19:32 -0300
Message-ID: <20240902171945.79656-1-djahchankoike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

d_hash is done while under "rcu-walk" and should not sleep.
__get_name() allocates using GFP_KERNEL, having the possibility
to sleep when under memory pressure. Change the allocation to
GFP_NOWAIT.

Reported-by: syzbot+7f71f79bbfb4427b00e1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7f71f79bbfb4427b00e1
Fixes: d392e85fd1e8 ("fs/ntfs3: Fix the format of the "nocase" mount option")
Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
---
 fs/ntfs3/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index f16d318c4372..0a70c3658546 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -395,7 +395,7 @@ static int ntfs_d_hash(const struct dentry *dentry, struct qstr *name)
 	/*
 	 * Try slow way with current upcase table
 	 */
-	uni = __getname();
+	uni = kmem_cache_alloc(names_cachep, GFP_NOWAIT);
 	if (!uni)
 		return -ENOMEM;
 
@@ -417,7 +417,7 @@ static int ntfs_d_hash(const struct dentry *dentry, struct qstr *name)
 	err = 0;
 
 out:
-	__putname(uni);
+	kmem_cache_free(names_cachep, uni);
 	return err;
 }
 
-- 
2.43.0


