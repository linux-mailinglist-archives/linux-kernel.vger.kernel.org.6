Return-Path: <linux-kernel+bounces-343547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B01A989C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F913281225
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F51617332C;
	Mon, 30 Sep 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLdfVNRm"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD531714A0
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683972; cv=none; b=h5GB9TA6ChtMXajZM8qndRai3NAyRfDkS6LWZsvzyEH++wEsyoyscDaCyq4bCoFijpg/gXU/H0wUO9mvoAF8Gz2ZuY5ol4PmsMshm8kfquAKowlR2cvVRXjxRM7jQJGQzvy+YTfq6DOVANP53WZvFxKXQATMP/fZMqWZ9I+/wMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683972; c=relaxed/simple;
	bh=sKGWQjLyEz/m15anRMbTD13sTWVi1e/YiCQ+mRpyae0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BjHuIpqQhqjb3jM2stef0pklvL1yBX54UiZKSDM3WrSqGP7AHEVOPyD62UbJCyNh9IsmiEeMXgiMKoIY+OBO4fCpz7yKJipkCYA54bLCYqUVy+qJtvt+NvTEzOIoT7lBuWofpfHmf9G3OXZzvQhll7RZjwtVqEiJGQ/9GyNiPfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLdfVNRm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b49ee353cso23817615ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727683970; x=1728288770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nKf47q4qzBnZJUXqLq9Cg9vwr1MLw2EnMAazJatgi74=;
        b=DLdfVNRmYLmWnsE1Rr0BoR3j3DNICdKuAoEcDBMVpKGONlRoPPaIC4K2/6VWSLvTGS
         L0nwKLSot9hGNIBU1OyGRv0rstTPmNd4imHIDefOgsvgjP9cXdsfFZrwHiUjoc5+vK/B
         7nIs56yS/JuT1ZYHqpyN3H8tMMRvMqp9VGG/WQLyp0Rg6FBHjsZrfNHaB1OSkrqojRhP
         amkDeyHPHgeiEFVAubmMACnW2y183N2Aejx3d97N9B9pSPwfmGNu2PsmitIYXHzSJYln
         4s2pQYBjVZ39jIAP8cxOjlinvEKisKidacaHkHHeeuQbr3Qk/TvKD4VQet8X4Ls/MR+j
         zrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727683970; x=1728288770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nKf47q4qzBnZJUXqLq9Cg9vwr1MLw2EnMAazJatgi74=;
        b=a2v7awYV9HbLiFJbOXNXHWYOz/Sw9Yp6sghLJ/bqXHHbwKve81AGNUHwboYeEZZnYP
         UYChM267RaYcQrWzMMeMrAddjxUDRtnxR3OVfor98ryYES0Y2409+U0+yiFyEPfKfwTr
         IM8dQD2ja8K7jymQNY/XKenO+qbdzF4Twcm2xW8cL6F3eK6m6KnxB2yCVfnLe4fGiP9E
         m9tX08Tsh6/fy067sCQULXwIkOLEF0QW705Z3PnrkaIpfPKvhrAN11lyzKpg4LXIUJie
         1CAQDmWRpagzPJvulnfSyJIBWpkoywQNpoJPfbHwCGuiM5iRFOtzmGFSfjHhkeZX7NRu
         tXEA==
X-Forwarded-Encrypted: i=1; AJvYcCVZaWC5NBeR6pa9/zbQE9xmwrgDZsp5p4EGj+6Od+7JnEc9DnXmZow/wCfRnxW2is6Eyg87n4B85A/eGhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBxSrj+mhIcJUhdW+VJaZpaYNDmA73NcMpEjJcFPVdkntiNDk
	tK3FKYB0PyMA303kjxn0E0hXwEVsF75SIn9G+BabXdwvbf6ngTev
X-Google-Smtp-Source: AGHT+IEvB7nEgYPcyext9HcfeNP/SQZqPskXRD17yWTaQoiKzyunJTitrYT4WJQmKOowOIy6+NmG7Q==
X-Received: by 2002:a17:902:dacc:b0:20b:8ef3:68a with SMTP id d9443c01a7336-20b8ef30b87mr29858625ad.59.1727683969675;
        Mon, 30 Sep 2024 01:12:49 -0700 (PDT)
Received: from dell-xps.. ([2405:201:3036:a902:439e:137:a1fb:3127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4e61csm50105825ad.237.2024.09.30.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 01:12:49 -0700 (PDT)
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
To: shaggy@kernel.org,
	ghandatmanas@gmail.com,
	juntong.deng@outlook.com,
	aha310510@gmail.com,
	peili.dev@gmail.com,
	ghanshyam1898@gmail.com,
	eadavis@qq.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com
Subject: [PATCH] jfs: fix shift-out-of-bounds in dbSplit
Date: Mon, 30 Sep 2024 13:42:18 +0530
Message-Id: <20240930081218.2992648-1-ghanshyam1898@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dmt_budmin is less than zero, it causes errors
in the later stages. Added a check to return an error beforehand
in dbAllocCtl itself.

Reported-by: syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b5ca8a249162c4b9a7d0
Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
---
 fs/jfs/jfs_dmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 974ecf5e0d95..f65a07252c22 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1808,6 +1808,7 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
 	s64 b, lblkno, n;
 	struct metapage *mp;
 	struct dmap *dp;
+	dmtree_t *tp;
 
 	/* check if the allocation request is confined to a single dmap.
 	 */
@@ -1819,6 +1820,10 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2nb, s64 blkno, s64 * results)
 		if (mp == NULL)
 			return -EIO;
 		dp = (struct dmap *) mp->data;
+		tp = (dmtree_t *) &dp->tree;
+
+		if (tp->dmt_budmin < 0)
+			return -EIO;
 
 		/* try to allocate the blocks.
 		 */
-- 
2.34.1


