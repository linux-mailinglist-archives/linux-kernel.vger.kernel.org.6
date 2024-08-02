Return-Path: <linux-kernel+bounces-272505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05063945D46
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B516028302E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C931DE852;
	Fri,  2 Aug 2024 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yGEddpXC"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2214B967
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598373; cv=none; b=b67EDDtlCXbsGraYaoHWNguo7sSsH4IIAU8KhPm+j9OR/kVADXHekLK+/X0Cczy9FFN6DQaSGmrtxthelPtt61SiyGX+QbsOHPg0w/K4mcD/mojQatmaL7J0jXDKQlzJ7cCyDmXRrp5JYYfnr9GoP/Sa9QbSJi3/l3tMxCZrdCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598373; c=relaxed/simple;
	bh=BOdWC3n/nND9BLq5ifRqZItEfEmAAbhhfUAWd4XnD0U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aPOvfqnay4ejdJJBja5I5tVzg9SKIT8QJODQ7jqI7OdxC4Kb00+megJaYUlaCY4tiStsujPyGpEQ8IQnIv9eDr8MeZPAs6clHL+whqP843ipFR2p/QWEsGnoEjyv+vB9qqMff810lnHGUPkuIsgra/7o6VMk6jmmGo52f3FaAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yGEddpXC; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722598060; bh=BSJscLmZUjmwe2ZBzmCzPr7mslzRTWjGMA0va8va6j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yGEddpXCRfpVQM8UND4oIqAUO85oistthzwmRWCfLR0h3ueriU8kvhLPQiTBTaPZL
	 yONRXWxTQ6Lzj+ViaoNa11PJ5IX/a6qobT8bC3z5TOOXV6D8jTLKFyVQMK3pdZP7GW
	 YbRTxSAMcfkft9YQjYoJGoourBGFOqMdslB1vy+8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 6E620AD6; Fri, 02 Aug 2024 19:27:38 +0800
X-QQ-mid: xmsmtpt1722598058tedo58p08
Message-ID: <tencent_F0F725A60DFF92165D88DDBB9960CF878D07@qq.com>
X-QQ-XMAILINFO: MOpJcPT3Yy24oUPJu9tRtN0Csz1JSgEEA5knYsHaWQbzWvbIIhwJpOn4afPuaj
	 ++RfAHtQMqVLHAJkChuxjV35mpBwI6WVo5bBq1eqD/lt+2Z8vzQTMBj3xKUo+ZztEv4ZCcFtBD8R
	 FLbnAmYZ4dS+tQTNm/NJEdrd1/f6/8SKfHczLcS0LLxuv+95Sezk7CDyOh4aFjskVuDV7X/y+XQu
	 UJzuITC6mkJKVXucHIbnOaRhmNgow0KFLm5Mvp4uvcnqtaRIbEVtGn34USty6zhvR+023HGx4FsU
	 Hks1ENJzhh2Q0Ebj1Xh3lsUMzd+QkPPhdyCDiqpMU0C8p8yHwbkmMw5MyL8NNomwmzRK8nu889Lp
	 VQjoXC/vHnQeRxLAJzBT8k/MgIeISi11D/Q7sEBEUXxkHXk58t4I+aRgfX6JnPvL24Z1o2V4XuRK
	 mMvwldCHy7ffEtbEVWf0Oas19AuMuFGtoZLksy4Bazva5o0xW8+hcwPl/YWBaTUt9NxnGupPm+Ev
	 VAfe2ZfrChogajhliKEtQze6zKOKukAPV7ajc+QReEWh7dk3cL5RROO6tBMmR1fXYdKappjoMc8y
	 6vO5sKuXdo7vtPm2YbeIsYb6S1XmwvngS0BakHYSloc2BMz6VS8TBon8ItpSdQrsooSB8UqpDmF0
	 +RgQoKCYmr0yttfCmDbLPS/QQ8Soh7SYLABA2tNvXqIq2hzVGTMDIqMpQkB0EIytUuy20k6dmGcG
	 0I0PF80T5vD2rhX1Je71LQcJ3rmfZeIgt0Y56rgKFS3o7klc8wpI2awgSCxygCFycaOuXCq3oevi
	 ZMV8U0e4oIA7yMf3XI1sbuo23dsTcl2xIh9QAcSitXvEgjKwAeOoRq4/8NMzi+xGy3wISQEj28UD
	 mtAGrcPMA+5gmkUV8E/fOeLcXwLzFMpeW2d9VpvGUgrOLLcE6XSjU=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING: bad unlock balance in btrfs_direct_write
Date: Fri,  2 Aug 2024 19:27:38 +0800
X-OQ-MSGID: <20240802112737.1103619-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000dfd631061eaeb4bc@google.com>
References: <000000000000dfd631061eaeb4bc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_sync_file didn't use skip_ilock to split up_write and btrfs_inode_unlock

#syz test: upstream e4fc196f5ba3

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9f10a9f23fcc..9914419f3b7d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1868,7 +1868,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&inode->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	goto out;
 }
 


