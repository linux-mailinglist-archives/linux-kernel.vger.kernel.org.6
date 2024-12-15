Return-Path: <linux-kernel+bounces-446298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E489F2242
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9871886E62
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658811BDE6;
	Sun, 15 Dec 2024 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Gdvf4gk9"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF0C13D
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734239967; cv=none; b=jZy/NqsEnOGS4aJG/L3BxPZY5nZmZQ2Jvb6QLVNbf6ZBdlC6Q1ioYRqQC3cof74ixFF8ggG38rJ1Yhl84sJTdqlOI673gThjFFGpAzks1RTye5kaFeAloeiCFolF+RPwFmbXNQLyPCSTTDv7uTTviYCk6OPPL+HA0hDpViVWRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734239967; c=relaxed/simple;
	bh=QEAJjJe46UqDesEuWkjOKH9iiQgNxEe1eBhgVrPZ+KA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=a+0UpQMN7ZXL9iGMmuplLh2UuZV0DRuO3d9fVBvqlEsxHM4tHuC9+ka2s9R8C8UnGlrKUbJxAIW4pNCstRYBGlEdLUtfLPMWecKowkMNVPV9Y07MQlQYX0Vgc+RZh+r6uoZUfvLa+0Ge1o59PMZ6qp4HSbG1s7VpqH+/EBXzZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Gdvf4gk9; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734239960; bh=RGxLWxlTBIL4IiWRMN0bjGjhxTp8hi5m7uffpw6ah3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gdvf4gk9tC9vjiovXpFK8b1yO2dA3U+zBsgrwTIPxws9rw412PTpu3CHKE7qYwp8G
	 OVwph2Z3M5LxIn8oVZswnZIKrL/zxHNA0/ZDtesraqeEC/sb7/4NJtfNNPJRYowecO
	 a2RKJepQ0YtmXeVdztYs4f5gAlRbaUzd48xcs3eA=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 4D18720C; Sun, 15 Dec 2024 13:19:17 +0800
X-QQ-mid: xmsmtpt1734239957t7k94amqb
Message-ID: <tencent_8146EC92D7066E89802EFEEED48C8427DE06@qq.com>
X-QQ-XMAILINFO: MTAjqnahuprtPW4FKF7yXlhbRy453zofBquyh2c8zRW1k2MaKGcik8RzQ98ryF
	 +RX5NgkhlQdYK9ewZTFlyTUBfEkpyBqFQHniRSH9B/LCSEVQ7oytANt5isH+jYF8Ath0iN5Ug8uE
	 Z1fvYo0gMqvmG9396Utq0BTVTrDvipLTg7fPAQoheSRmn1TQh7zIR8KcPqQku1ER477qr7I4km3L
	 VqK14OZnvuYT4txiKwyWOl0p7RPWJ0njrjmHQjqRUKVHwBn+Mg1g3rQNItkHOZjFvO9D4JQLEqVq
	 eZX/8e2v1yYhZ0uIQMZlmjAP5N4EGgiK1jdAPpuJyuSCvlUhKBgygNS7r5OxWY/Z9T/x1+k8LFgz
	 K4UO5n1hezP3YKn6KyCtWCU4lCphiGkQQji4SC275QJVuAPwXcSrSFcNszhz61slVeysmXyxh9Q9
	 vwGuXwtYoA47sV3WVrVCsGgaT6SCi4hOrUcYRatDWruGcvuMrpzcSWDgs28cJwkXz8GamJKvI3vl
	 AFxxbsPbt0UnwRWLjTezE8N36AcsK9p5bSwBOi+Ydr9dhGQHUUfLQiogItaBytCbEvecu52lp4LM
	 OjDkt2KjTGxPbfA+QNgn/EK7fO1K/IzoUbfKRcwpfO166qMZvGoXwP3D1DRNitAD7iTNLEgSh6Qm
	 XCvebAKhw8b/qGdyvPAEQ96tSLCPyJYxhaNBAOioEaVArFRW0aRnvGh4HdRuql/Jl/bjs+OyQcFW
	 x6hFgMT5p1dGeNkCX5F7dzjZVrBoES6sYpFNL6ovuQ7PYExWttV6+se9QcGaVK+latXO68jYVOIh
	 PeIidC1sef/6gKa78Kcjjvw9FAzLm6WqI0viACC4nqrpF0mcGp4nO2LrhRBbWiaC0g+qpLgG9hzn
	 lRNJ6i8XRu1kSejdFvc+ItJ6BFfBxFkDFi90nZsWrDYe0G9ZW/PqOCgtQWzfzwCcW2HBJr8SCQ3G
	 mRmukutR8=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
Date: Sun, 15 Dec 2024 13:19:18 +0800
X-OQ-MSGID: <20241215051917.1735604-2-eadavis@qq.com>
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
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e83d293c3614..573f62ccd01e 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -839,6 +839,8 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 	    gfs2_holder_initialized(&sdp->sd_jinode_gh))
 		gfs2_glock_dq_uninit(&sdp->sd_jinode_gh);
 fail_journal_gh:
+	if (ip)
+		cancel_delayed_work(&ip->i_gl->gl_work);
 	if (!sdp->sd_args.ar_spectator &&
 	    gfs2_holder_initialized(&sdp->sd_journal_gh))
 		gfs2_glock_dq_uninit(&sdp->sd_journal_gh);


