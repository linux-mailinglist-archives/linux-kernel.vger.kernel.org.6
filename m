Return-Path: <linux-kernel+bounces-529408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D5A425EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057A319C47F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF2A165F09;
	Mon, 24 Feb 2025 15:01:30 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307719E7D1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740409289; cv=none; b=lbWp7g7c3ScEM49TVF7vVglAwsBNlfw7SoIyJyWLmdyQ7BM98PeUADY2DzFddgNPi2qOqkS/DYeID6c2xO3nMOatrs9lvxfkSC9inTBDbe4y91nRv6dhCmufMsFX2IDkwcebslgBCBlYdpj9xNMfR3MFAz+X1q/jpS6K6ODkDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740409289; c=relaxed/simple;
	bh=3DM3rGFaBmgQcMzWCw7RKnW0aaY42yw134QpbHE2GUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOE6YtltQEan3VaXaDwGbSkJJWZLNXm3nwbwz+1sZI8UL/VSIT6Nz/PpVFLIPIJh/jomaAfxUJIR3n8rHBinj6obxp0lWDywtC/i1GaJNF8fdxQeKXUoZyrgBEt6Vns6rJyUIZ6n6J+mpA23jKZfWDLcNNA4g3r3YitHg60Nt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 24 Feb
 2025 18:01:22 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 24 Feb
 2025 18:01:22 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [syzbot] [media?] WARNING in call_s_stream
Date: Mon, 24 Feb 2025 18:01:20 +0300
Message-ID: <20250224150121.1219049-1-n.zhandarovich@fintech.ru>
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
index 807551a5143b..64dd7e0ea5ad 100644
--- a/drivers/media/test-drivers/vimc/vimc-streamer.c
+++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
@@ -59,6 +59,12 @@ static void vimc_streamer_pipeline_terminate(struct vimc_stream *stream)
 			continue;
 
 		sd = media_entity_to_v4l2_subdev(ved->ent);
+		/*
+		 * Do not call .s_stream() to stop an already
+		 * stopped/unstarted subdev.
+		 */
+		if (!sd->s_stream_enabled)
+			continue;
 		v4l2_subdev_call(sd, video, s_stream, 0);
 	}
 }

