Return-Path: <linux-kernel+bounces-540536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26376A4B1EC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E84816A528
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358B1E47B4;
	Sun,  2 Mar 2025 13:43:57 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4E219938D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740923037; cv=none; b=YYBH3Fg1YdBwxF2KJsjmoEUXiCvCdPD1LPgT5/7nBw2I5wJGE9RlMpTYthHi3eouHUkkAggOoiUmh/fSeVWYQ2CdJoKD7nXkG/tHfnxz1FZgUvU6YZsQuE/zHs+e57y9T0cG/q4WLMy4FWe/YVNDvgl+cnWGItMKAz8z8lGoJ+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740923037; c=relaxed/simple;
	bh=Xj6uYqBP3r1iJbN4tJ3e5Ht5OuaisBC4hOv+nPG9S6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W12CYdLdrSc6PqEB+O46ILiCKFfl1gmPjdd7ai5NMDZU2tpj6/jbYQnw98wS5AGsGj/4B5zSO0bz79N8mJlCRF3a2RE3IdrRsJ/AYFFVQWxPx4uadRbpN2RjNKrodO0AlWCz1fiFgz5VmOShxaQJJMF7DfuxpRKL2c22SVKAECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Sun, 2 Mar
 2025 16:43:43 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 2 Mar 2025
 16:43:42 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [media?] WARNING in call_s_stream
Date: Sun, 2 Mar 2025 16:43:41 +0300
Message-ID: <20250302134342.1598192-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008cabee0614a97e81@google.com>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Test a simple fix for vimc.

Also enable a fix from [1] to combat a KASAN issue in android (?).

[1] https://syzkaller.appspot.com/bug?extid=7015dcf45953112c8b45

#syz test
---
 drivers/android/binderfs.c                      | 1 +
 drivers/media/test-drivers/vimc/vimc-streamer.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index bc6bae76ccaf..94c6446604fc 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -274,6 +274,7 @@ static void binderfs_evict_inode(struct inode *inode)
 	mutex_unlock(&binderfs_minors_mutex);
 
 	if (refcount_dec_and_test(&device->ref)) {
+		hlist_del_init(&device->hlist);
 		kfree(device->context.name);
 		kfree(device);
 	}
diff --git a/drivers/media/test-drivers/vimc/vimc-streamer.c b/drivers/media/test-drivers/vimc/vimc-streamer.c
index 807551a5143b..15d863f97cbf 100644
--- a/drivers/media/test-drivers/vimc/vimc-streamer.c
+++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
@@ -59,6 +59,12 @@ static void vimc_streamer_pipeline_terminate(struct vimc_stream *stream)
 			continue;
 
 		sd = media_entity_to_v4l2_subdev(ved->ent);
+		/*
+		 * Do not call .s_stream() to stop an already
+		 * stopped/unstarted subdev.
+		 */
+		if (!v4l2_subdev_is_streaming(sd))
+			continue;
 		v4l2_subdev_call(sd, video, s_stream, 0);
 	}
 }

