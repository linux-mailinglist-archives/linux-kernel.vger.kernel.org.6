Return-Path: <linux-kernel+bounces-446306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CA49F2261
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 07:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EBA1886C85
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D60D14F90;
	Sun, 15 Dec 2024 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BGF+bqCl"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0BCA6B
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734242699; cv=none; b=onOqJ+9hfuGqssCWX910J+NsoowhdrStbHkyK80O4PNFqfZZjJQXghzaQMQi2iBVskljUc/03bd1xzRFnF1mwdJ2QBXU/CZ1O91ZobjvkDjk25usOim4gm0dxqIFPERgHCu4xLSCsgI+wgfj7D5GBHpVZKf7FGlkTS/rgWA5p7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734242699; c=relaxed/simple;
	bh=bb6INrdqMpVJG+W5DhcHiB6VePihaVfRkeByZggfIgU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pkR8qeoIKLKtpKbiYLIZiZmLO/blQEhHebK/UxduRZPXjf3SeTgijOvezrHffw7HMUQOBH6E6/a3qbC318q4s+bTvdEefQ4ek6JIi2Ztx6aEWJDhiA7mx73vcx2q22rkg2wXgYh9kBKLGZEilehKoY6mMo+XvLaTP9tV9SoEu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BGF+bqCl; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734242383; bh=y+64raaEfYfOLxSNXdqA992eSu7VSBem2KvYGNYdKWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGF+bqClp3aHWxZTWIPEwFh5IGJZuRfUdvCOoLoLphTuIEjcK2C5GrMbY/c4al8Sa
	 qFpuH/6vKih8RYbObdMjG1y7rQyu66EmPExYTcg78wWcAVfcgft50Uj5vZU8EIZSNL
	 odfhLED5uAeDreAEQ0HyVkqAn8ovSh0waTxeNbRo=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id EE9A12F3; Sun, 15 Dec 2024 13:59:41 +0800
X-QQ-mid: xmsmtpt1734242381t2a4yf1lk
Message-ID: <tencent_85066049912EFAEED3CC8D67C146C112EA06@qq.com>
X-QQ-XMAILINFO: Oc3TLAADIdlpouIwiZIMNg1+GaHJPbaSzp2bG8zKJeXKGC9ZLwB47uqPG5QAaJ
	 7Wyc5LF26Meh/rWzouathhUO1eqw4oAN3i0ZC7Hgwk0AM5mbBqu2flNmOvneYYlks7NydJ1wYGem
	 3KkHutFgNLPy9WCgU2Z8ELTZcBKoGIMyO7PGKZp610GvP5TT+wpPjI3cQHc+U3qsXC+vKw4FkKT4
	 mMmXQXz9xI6TyH4QcoXEYiUSEszZmRn59K+sPoAwuBegEIq3wPxAyPjfbDbmZIWy0FaEt+FPIhzN
	 1JUL7JkVJBlGexuswC5X631GDTLPLgEOxeDxXfSatHKiztio86ujObcPru0v9ZDo9rLquQeJQJXZ
	 1nR/kN8dG+oStOXEyP0P6Iv+4enZHKvbeALN1vxWqlYIxrZyP+6jNYLk9gYd7PpJ0Vqj0OwNl+fK
	 XodHrkvotBqLJP8I5v0vYiFU1ksxsgUJuvPJVnGnNYt3SLbv+wurp5Y24gcjlDBCeozHWtKLechU
	 fYPIj/XxytRYOl63EbU3+GKsz8STut9QfEWClfCyKqQubYfk9P0ic/7+fEsnO/79Zd0YxisKtlfy
	 kqNPAHxgmdpr76PTa1W6LfNQa5kRYdWkFwVoumRbpG1kaMt25vD9euLo41QOFbVzNz3yuZ62GKIo
	 xKeCqpBlIPmfJgL1bGcl9IGSM3EonlLbucONu5arnP3gsCUfzxerEFUtrJH3nzMhFIHE5bUn143+
	 3RSbCEiE+PbWaimy5E4zZJ8IWy20ecZxziqct1UtgKula1btJF2i0Dln4qObU5bbthASSIFYN73n
	 1FoXcarNqkIdwl+stSYZKzh91QdmpsOc1S1NETxa2Jt+Gwc303BgpgZ1EMhfBSrsGxOZnSLkTdyQ
	 w8SoLbez+kZIx/bIy6HPpw2Zj2MNHKGMn+KXAFrkqmuHFtnahRMq+KwVvabneC7+/bSLaunANDr9
	 7fDJHkIa7u+3YUEAkjeYI+XqiTigciqB1PPOW0m3k=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
Date: Sun, 15 Dec 2024 13:59:42 +0800
X-OQ-MSGID: <20241215055941.1774691-2-eadavis@qq.com>
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

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e83d293c3614..a87c1d5547e5 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -839,6 +839,8 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 	    gfs2_holder_initialized(&sdp->sd_jinode_gh))
 		gfs2_glock_dq_uninit(&sdp->sd_jinode_gh);
 fail_journal_gh:
+	cancel_delayed_work(&sdp->sd_rename_gl->gl_work);
+	cancel_delayed_work(&sdp->sd_freeze_gl->gl_work);
 	if (!sdp->sd_args.ar_spectator &&
 	    gfs2_holder_initialized(&sdp->sd_journal_gh))
 		gfs2_glock_dq_uninit(&sdp->sd_journal_gh);
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
 


