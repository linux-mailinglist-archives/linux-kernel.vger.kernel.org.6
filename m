Return-Path: <linux-kernel+bounces-382038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E959B0829
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E02283E06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367570816;
	Fri, 25 Oct 2024 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkoDOmT0"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D021A4DE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869919; cv=none; b=k6ddAXKgbBIekrmXxQ6knzrah0MDnL5dfKUoSBr8Ya2fCYN/JGhUbuUgU2oy30YdZzCy3eUvjTCxQbQHxGSeGFtN7ufhd/sJbHhbgmIvfycbDFeoduxLuMymgGk0dwRwZrvAjxnKnVC3TNVJ/Ca9u2VLIr8Re3rYgdLhOOxGBGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869919; c=relaxed/simple;
	bh=RRzFe9tUsjDykCJzHoZbL7lPHCyXflbAzZnuo6F+oRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QbmiADYzmeYZIcQuB9SsF6n/pZw2/L74x7XE+rkLCobtvv1AhrMKlxHjp0CARECpH+EP95aIhbIv6OeBy9oBgv6IiVim4zSe8rHLGUDD4x1y8RDKLxSFvTEn9LoDFkMg4Phj642YJXVR0DpmvcfQbX3rwhTMeZce1xWQO++vhu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkoDOmT0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20caea61132so16769385ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729869916; x=1730474716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFXeo8/I5ZSuSmBjM2oOfVhjv5mq57dZ19wKVuXleow=;
        b=MkoDOmT0kErCUfqJYaptc8i9imTM/V23B4bPXG7SjvE2+MGaBbGpuX16Aex42PRNol
         jc/eJ0hri8jcyFUtarhXNAgQv6t1qTMLkgFWzObTBQceWfNLxjBFzdzgkk8vp8qu5Z0q
         23KQS8IiJAcIA/dJJVbsW46etFiZLeGD6c5sw8xc6YF5rsbZCPNn/eer2WHrcMndFNGN
         jEZnWhlz5VqFWXD+rGITWZ1f3shDNFr7ax4QDVvvaIKbWrXidMvEUREB+ea3DTgJxrp5
         dADsXK/aRFlXWXCEMd18qzqLgF4bi/nyTiF2pVI/RFEtUuhgj2H81MNDAJpEAE4XoDxH
         anjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729869916; x=1730474716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFXeo8/I5ZSuSmBjM2oOfVhjv5mq57dZ19wKVuXleow=;
        b=OY2PTqOiCAijm0z+bc/1h6GCkJFo04nTRIIiU5kvTU/lvl/E1iikFVEO9mVVDAwSDp
         xsDQi6vDg9nzl8I8GP5c3HHsVH7lkRlrflZU25zy1aXO/CF5s6bwNGTACdIoh7JUVG+5
         CwgplMvhhcXNO4VSTjQrM1iXKOj4cY+MwpsAqokbdmjmJS6Dpltq5eiTih3A+J8I/M4W
         dps9SE9mj/EKqJcXacNHes9w0rIerNvJOG+979Qw0YOX5NI4oWQxeBUzf9WShdFEcxt2
         roqJcO0o3wcLk4iUNMorYflwRAIKZqtrYU9mIbTtVu5HHI7BUgpzsPWhPUuDlBLEeNLU
         D0/w==
X-Forwarded-Encrypted: i=1; AJvYcCUb4kCLgZ8suFBc50EY94kuEkdiw6TQAB1OEHBZoxhruzdUnKOYf+EE8eZNZE+kE7yFhzJdFoklS2MZ6kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDlvY2EVI4KB+bKlBTUSd87VJMeMBZUbqZINYlV9NqXUObtQz+
	kazq8AunxRBtV9i5rRkbRIut7F0YhTW9bxbOM4rc+5bNLesY2jQK
X-Google-Smtp-Source: AGHT+IHzjCi6zjSBygdsDkNmJ6tFYS3/lnJ4kMlhURm+u9y8ACOWIxEtCPG5z40xCu4MBUYeOmt50g==
X-Received: by 2002:a17:903:2441:b0:20c:8331:cb6e with SMTP id d9443c01a7336-20fa9e2b2f3mr140776935ad.19.1729869916409;
        Fri, 25 Oct 2024 08:25:16 -0700 (PDT)
Received: from TW-MATTJAN1.eu.trendnet.org (61-216-130-235.hinet-ip.hinet.net. [61.216.130.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d10esm10606075ad.70.2024.10.25.08.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:25:16 -0700 (PDT)
From: Matt Jan <zoo868e@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Matt Jan <zoo868e@gmail.com>,
	syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
Subject: [PATCH v2] jfs: UBSAN: shift-out-of-bounds in dbFindBits
Date: Fri, 25 Oct 2024 23:24:59 +0800
Message-Id: <20241025152459.485-1-zoo868e@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <671b3f75.050a0220.2eb763.00d7.GAE@google.com>
References: <671b3f75.050a0220.2eb763.00d7.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The starting bit number of free bits should not be >= 32 as it is
0-indexed.Assert that the number of bits is < 32, or if it is 32, the
input word must be 0.

#syz test

Reported-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
Changes in v2: Test if the patch resolve the issue through syzbot and
reference the reporter.

 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 974ecf5e0d95..b9eccf8900eb 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3015,7 +3015,7 @@ static int dbFindBits(u32 word, int l2nb)
 	/* get the number of bits.
 	 */
 	nb = 1 << l2nb;
-	assert(nb <= DBWORD);
+	assert(nb < DBWORD || (nb == DBWORD && !word));
 
 	/* complement the word so we can use a mask (i.e. 0s represent
 	 * free bits) and compute the mask.
-- 
2.25.1


