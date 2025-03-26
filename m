Return-Path: <linux-kernel+bounces-576373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9FFA70E67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08E77A7205
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CC02940D;
	Wed, 26 Mar 2025 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfcB7tOS"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2168EEA9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742952262; cv=none; b=XGKX1reGqKsJHZt7BFIOb5+xjhMdbw+D4WCGWfsCfxn+L/blsoKfpBkWXDzIC8UjXdITSlOVgcGQ2raBd++xDKr55YH9ttmLDixi9eBjzouBngT0ZFBwujY+3ueckQ/I0H5tAwwNX1s3kcCtpXXb9/38nnw6Cv4zsf7Vyclk63U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742952262; c=relaxed/simple;
	bh=Oi1Z22yZJA1yS6YPQXUV6cXCGUgnvPfPGqlZ4rgGyp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOoT4HxeyfL8lqQGvrR7M5TkpGUd249LgTO+l4k1nVIbcyb8pn6KVVFRVhnkWWN1lWH+i8Y4Eo6XgMLkS/iI3ZW5LuIeLpO9+30xkbkjF6BYORGO1rDgdv6ja8nJIlKGhICNk8nBAhf2eH42kCxMd6X2gURCvyF6hLQ+uuG/hmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfcB7tOS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224019ad9edso5932535ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742952260; x=1743557060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYrG1/OuLUFFBlcwhHmejvyl9EYkI835zqF6w04LsWs=;
        b=LfcB7tOSINO6fqUWj97AlV9NgnWmgWzqbmL0TCk4NHxpmMCx/80vhyNIJXFGBnSSbJ
         FeWPndbJoAPnlMfRzoBjzL/18SY+ad2i4SoXclLuXOXxkpavPp+yoWgrp5t3RZFBxXFS
         YdZ1xwxDNnNeCKTen8O7Ugsd6/vVevjwq5KXisCXP8T06e16TNBhREUm+lCa6m4w56Si
         4ZxXh7iFqaroIRVz/uJTn0P8BNPBL0vA1ZqB2kiDvV/KaHMeXQQxtye2gKqmX451KEhQ
         U65hO/DuV8UZXhq4+6v0kKIDvkZOVkIbNRktaGJft4G2XS4/j27yOaV3Zd/8Ks0weH2Q
         JXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742952260; x=1743557060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYrG1/OuLUFFBlcwhHmejvyl9EYkI835zqF6w04LsWs=;
        b=N+oezLvnTV1vu6iOkRG8A5xF689SgJCQgX/O0tbputaWomXdyWBjhAopSnWLvKFzK5
         WSRqV3CqqqoTln5BTNIrrtUIdg1hKgXE5fO6QjauWsM3HX48JC6uiYjr6NGtlH8LYVSX
         ivJN7CMbeB+jE4ldIHFc7wK/5UMn9iaTF8xVoERjLeR+qFh1T8dHzcaEJW2pyhXlNcge
         JAzc5fkNAsjHIhF8QlVJYd12w55GOR8GadCOr9n/y58BN1vSAZsz2b5FzLKpFnIz7T4x
         nH5zOxn8YtHFaS+/CWFpzaG9/UqzhBxCK/R1izCOqznQigX4J50ZEz+TBWKFSEyQOcr+
         /V+A==
X-Gm-Message-State: AOJu0YydDR4IHqpSyJm/g0sYFn74ZYiw3uaaNW1Qq1DsXGgRqmAIRdEd
	FyyAquaqntOQzvKj45oT7HQxHlEAFhEBnmKe78G6FF7Z0d5znZ0+nRl3pA==
X-Gm-Gg: ASbGncuWSp/5xcO7iI0vFTT4KfayDB/wXO9a8IQ5FsSSU+8FanriqZ+FOqQ+2OH3df6
	CjosRZlWtrO4RBdNHKfGWhoeBU3RDNW2TEEBa3oT+l/8CdLuJmfbZxELY09DFsatDl7YV4g/wTn
	N4Y7kKYH41XpdJz8WtIck0gPAGA0evOi8tlqeWJ0Fp6pTMKLi0BKwoSrffbvvBKIIb2NTXpO2Cb
	6tKov7mFetNxijnkgRTwjoaIVvG2E5ZpcLz1ZRCBLe5H/ItZjVFxtfQoGGFN7sJnfBqKE/5Op9x
	xPBLzLWqlcoLeTn/ULeOaJJEgFRUSYAex0nw8XgolZEYU7JXs843SAsM6SKrubMTi5iGE42MMg=
	=
X-Google-Smtp-Source: AGHT+IESWh02EZmuZOrl611kqR40Qv2PFZj3Zdm4xfFDbMryIvQlaRN2oCSf3GJp4xI81j9HNKdmgw==
X-Received: by 2002:a17:903:2346:b0:224:5a8:ba2c with SMTP id d9443c01a7336-22780e1a5a7mr219092775ad.52.1742952259887;
        Tue, 25 Mar 2025 18:24:19 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:7cf9:c75d:456:248c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f45a06sm97962765ad.69.2025.03.25.18.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 18:24:19 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: syzbot+7ea0b96c4ddb49fd1a70@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	syzkaller-bugs@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in _find_next_bit
Date: Wed, 26 Mar 2025 09:23:56 +0800
Message-ID: <20250326012356.9099-1-richard120310@gmail.com>
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

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

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


