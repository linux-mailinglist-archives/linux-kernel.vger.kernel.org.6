Return-Path: <linux-kernel+bounces-215839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948E9097B7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB441F2253B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A113A8C0;
	Sat, 15 Jun 2024 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CKc57iEL"
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C42E636
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718448509; cv=none; b=u1nhbGfcDUFZYkaGMYTcqO5pHvDwlObE1Z7NDhaTKBBLgkDk59JvissmGBj0RuizaJGKBAoNxd/OBNHJtmUUpmZO7+5GhhUh8DwPDIi+ptFvsSom55w6bSgCk+Vly5HxOq2huzsvFwBeArvTK6Cvj9rskLcfM52AX4HLjXf71t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718448509; c=relaxed/simple;
	bh=VwTrliKTbTH410swrzcifej76Gp95GBHlCMjmz4+YA8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ENjU5n6MCBB5J9/zikhrg9a0g4K3jQMNGT00JQaZmYfWPsATIJ5mYReFHP6M6Q3GvH9IEObpgoX2Skoh4S1DQvBvrYqDoisXQQWLNR/z+CS7NTziu/i6bJnWlDXcQhfow4bZjEiJRBCoEMZ7PUc95MZR/FlyaYqCvU+Ux03kWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CKc57iEL; arc=none smtp.client-ip=203.205.251.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718448203; bh=BIU2wRIRshkfBMc6apYvjP02EdDFfqfnispnkRn2itA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CKc57iELuTMjH64aUB2k4plj1eOdJ6QF7hcsMd5n65zQ/bzwWvVHvHUeC/p5DG2bz
	 URxmStrzeGMb9PWb4SnOjKAABGNwlr5aLPffHXp9WS0hbdwLgoJAFT3SSOUohm+uu9
	 RGod0JHbt7KK7cBHFkHeO/OgsYH29fOdYfjce1v8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id AD5B6A39; Sat, 15 Jun 2024 18:43:21 +0800
X-QQ-mid: xmsmtpt1718448201twuufkfrz
Message-ID: <tencent_A2AE25998DF812235DBE5DFD99584FD18D07@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCIsCnlOnwJTS0MgY3pV92z1s8rBKkLX3Lsnvb/s90DE9zGRXhvx
	 Q4r/poZEAM+A9DkGXbtIx2oHyF+BIXJukDqBaABikLj1NgZzmtGTk8cOYJ1TLTh5OdN80EioI8MZ
	 OnS8g0foqzn18HR+ozRLsEba654ijNRrj40LMwFald8CzgAQadZ4CM9fOQUBKW8Xe3CBJvZeQP4R
	 3Q/sUeAl/gUBvSQsDcbwsUbVROGPvG9Qyt/2SON5s4FoirBh40w9G7u4mXlxKH7tONv50S5z72NJ
	 CFSnKebJjMpz1XlsNZpKw6AiFb+uffsD3fjvD8xiRxRf0afWHQTkbk3q8+iZvCu3wtsv/ckkHsNB
	 BYplWRN4mAjyhbpAMejXnJAknF5sF5y6QDpAjPVo1kyiFlfHnoGWqIpPREiv5H1E2kixMdkJt+go
	 /CmSjozLjlJTRyMYar2l3L85HIc3Zhb3KHqNSrs5PoOkU5i/0KNeil7UsqlgVJCWxSzfx497wr+V
	 HAuW4wjahh8cViCpRkRQdcMjJ1XJaAM6m+PgB73IwYigEeGqFvHQRMcfxoh6fjRW578EM557Om14
	 /GtkkhOgxNlXpI2xqOGk5Lt9pzr15G7O3vGCbRSjYxVK4Z8XXGs9sX8ZaMDUdbWn4Pv7D/u7tsEo
	 f5qJOpzDCiWut9Womq6IhU19X3yU2yV6uo9Yc9QibxFzIVfQsB66qmDxNX4GQsnUYNNnALsD10aW
	 wku7wWUZWS1Ir3MoXKmnhVX0pZoZdnX/EYr57RY8RAK9ObUHUspzB/aY85isxDPgRxdWplDluOHc
	 5tUr+SgQEMByFOjbg/4FCEyA//aVryOVsf180bYQ6xDgkpH43zpnwfeyaLYEXuece9W68ca+Qik6
	 MjD6Y6ATSKTxE1pWfPOQYILoVHx7ZDax+2XNfrlwupzBYfPwBlxTc0CgNfCcdqCKPDycrqrml6
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4366624c0b5aac4906cf@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_read_write_early
Date: Sat, 15 Jun 2024 18:43:22 +0800
X-OQ-MSGID: <20240615104321.3870023-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000053e574061ad89521@google.com>
References: <00000000000053e574061ad89521@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test no write lock in bch2_fs_read_write_early

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2ccbdf43d5e7

diff --git a/fs/bcachefs/snapshot.c b/fs/bcachefs/snapshot.c
index 51918acfd726..b27a4327274d 100644
--- a/fs/bcachefs/snapshot.c
+++ b/fs/bcachefs/snapshot.c
@@ -1566,7 +1566,9 @@ int bch2_delete_dead_snapshots(struct bch_fs *c)
 		return 0;
 
 	if (!test_bit(BCH_FS_started, &c->flags)) {
+		down_write(&c->state_lock);
 		ret = bch2_fs_read_write_early(c);
+		up_write(&c->state_lock);
 		bch_err_msg(c, ret, "deleting dead snapshots: error going rw");
 		if (ret)
 			return ret;
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index bbe9000260d0..cbccc0bbee76 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -99,9 +99,9 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 #define MAX_STACK_TRACE_ENTRIES	262144UL
 #define STACK_TRACE_HASH_SIZE	8192
 #else
-#define MAX_LOCKDEP_ENTRIES	(1UL << CONFIG_LOCKDEP_BITS)
+#define MAX_LOCKDEP_ENTRIES	(1UL << 19)
 
-#define MAX_LOCKDEP_CHAINS_BITS	CONFIG_LOCKDEP_CHAINS_BITS
+#define MAX_LOCKDEP_CHAINS_BITS	20
 
 /*
  * Stack-trace: tightly packed array of stack backtrace


