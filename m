Return-Path: <linux-kernel+bounces-446291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C159F2239
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21B61884746
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A5628379;
	Sun, 15 Dec 2024 04:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uZMXzx3E"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EA127702
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734238434; cv=none; b=sPH/9uPfWK2wh2zJ/D1/SsWkn9wN9anKWuK1ayuXJd8bN7drrY2TieSejZ15ul0KF5D/weZ4qVwh/ffVkZ9JmW+jCfJCQ+KQVfbyIo9owDgYcXvIPOscY1A79CMHty4eOb422KoVIqvo6+n8QJu7MlshxrSDRPHMa8ejUU/OEEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734238434; c=relaxed/simple;
	bh=gqLYckmoEKnwhUebvVWys28B1Gh7viRB0Hw+Jg5gxRY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DgeNCvKsDjA4VUpS2paA43kU22aFCy7gotFBwRG8ARQ711OY5QceOTCMSHsHi6kh0luT0Fwtv3/Dbzx0Uc+UViPGZAAbRJos2eFXp9S7IV1iR5c/xluK3qKBp0TWS44ni4EXi/ji/iGrslLA4TYIUFg/jDIqOEqxznFW0ViMhOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uZMXzx3E; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734238120; bh=2or7MJlve9hpdEfcgo3l8CzcgTz03AF5vmrj72b6cok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uZMXzx3EK7qwEkkODJna/85iR4FPFXw2LHMuhwjciR0BLLmbn2BMP/m6MVbd/eUdw
	 VYd8oAw6B0xttLSFDMtAjaG6Jbcip7wXli6S8ncvWBb7L36yZFAmg9DDTkNeS5uCKw
	 +gjM5wxqu3HxISTyyvyJ3qZGLh0sFniVBwEl534g=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id C261AC0F; Sun, 15 Dec 2024 12:48:38 +0800
X-QQ-mid: xmsmtpt1734238118tni3z7oxv
Message-ID: <tencent_71F8258A8DB0123FDDAB5DE099444F878D07@qq.com>
X-QQ-XMAILINFO: MKPSrEIbElLqX4JK1zsKjAUPl5IkWLMpszGSCMVCA5bc5zieMfEhCWEWRffx24
	 h/Ztz9sHE05IHTfSLJmEdIQMqc4weRuCRHWKqp34PtUlQBa2Lv4M/sniVdz4aXCJhPc19ry0GuaH
	 gcWUmhmGu1831Iw77Udj2Vnz3/DJauakhKB9oQAWZzMZZIv8veG2JLAXCWhyjaZkPazv/sv8DhbZ
	 YIIpQPZnUS4WkiboPUS0caAaEVfT1JihYFXumruXCc1SXubflxPLNbwfptNERcF9X/e6fLHvA+lt
	 BQyciVlHsI3tuepDsd82dzarEShI4lgu8a76ytakGEAK1MPF6n+67VsWEWY0adhcgdY1+yBNmav2
	 SiYQTOLaZ2wyVIfkmOQkTd3Tn3hBxBCk2mq9sKLUjpqipgHz3irVIM3eUPLcahoPfkuAhJBrDIbl
	 KqUBs4NWrdIhDrsQiBLHsV22IVhoCOvWEiW6pfBQ8L/gtSG+bIE7aZJyjTclaqXhg6StEXiOTxB6
	 XLJXo403SiNPCi0lukmUjIIGH0LH7idqP1SCmZxWXs7/4R1BhP1tft/i/UFSKhfSFCGQqd7+gC3b
	 QRkfq6R9OHU6Sb2kjSHR4uXt2vdGtMc1baTAEjQbA4gFu1KiOV7g9YhjSpNXSmV4Il09ef2OH5cR
	 6Eg0p6C2Xh2EZKoxLBGRSpJ8MhoED9dmtJbU2zllrUd29Z9ulmUsLy9EpYOn0Gw3c/HM9CLdTsyW
	 dZuxJMis/NHoIyftwr5icJbGu0TkyPJ++eMVl36NbfozO58AG58VMc0XFwGYWfs4MeWrg5d2eWZW
	 hOd+UXmYtmAhNGHkMtFqe8TC8OXET7/+TEWBvg/9P5P1c4O9Jm233138XG0DJ6xnNYj6wV0QnJl9
	 UEX7lzORyKP1y0jQuuK2akG6YxYMVihNFtMQ5aWO4Bb6UOPl03+ljxeNfbTO4RJrjGXLG/T20z
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
Date: Sun, 15 Dec 2024 12:48:39 +0800
X-OQ-MSGID: <20241215044838.1708606-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <675c5e51.050a0220.2875e5.0049.GAE@google.com>
References: <675c5e51.050a0220.2875e5.0049.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 8c4c1f871a88..8f851ecd1625 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -267,6 +267,7 @@ static void __gfs2_glock_put(struct gfs2_glock *gl)
 	lockref_mark_dead(&gl->gl_lockref);
 	spin_unlock(&gl->gl_lockref.lock);
 	gfs2_glock_remove_from_lru(gl);
+	cancel_delayed_work(&gl->gl_work);
 	GLOCK_BUG_ON(gl, !list_empty(&gl->gl_holders));
 	if (mapping) {
 		truncate_inode_pages_final(mapping);
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 042329b74c6e..3dcef4bb0427 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -222,6 +222,7 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 	bool need_free = false;
 	int ret;
 	struct sbitmap sb_backup;
+	unsigned int flags;
 
 	depth = min_t(unsigned int, depth, scsi_device_max_queue_depth(sdev));
 
@@ -243,10 +244,12 @@ static int scsi_realloc_sdev_budget_map(struct scsi_device *sdev,
 		blk_mq_freeze_queue(sdev->request_queue);
 		sb_backup = sdev->budget_map;
 	}
+	flags = memalloc_nofs_save();
 	ret = sbitmap_init_node(&sdev->budget_map,
 				scsi_device_max_queue_depth(sdev),
 				new_shift, GFP_KERNEL,
 				sdev->request_queue->node, false, true);
+	memalloc_nofs_restore(flags);
 	if (!ret)
 		sbitmap_resize(&sdev->budget_map, depth);
 


