Return-Path: <linux-kernel+bounces-411955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DB89D01B8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 01:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720E7B26868
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5EED528;
	Sun, 17 Nov 2024 00:26:22 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81596DDC3
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731803182; cv=none; b=SvO+aX3w5mLhn0X03lCcOSHS2JGuA0YBhyKmxoCpRX0kkYrP80ITWiWLcrQXvDHjn0a83zKXyZtnZsaq0rdyIJaOtRSeLBY9iGXiQFl2dRoGZO0UsXICbfrN6q77UOG1QpNMom75VpYhqvQgAANprv6wZbDzs1xgxCYWeErofKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731803182; c=relaxed/simple;
	bh=jyTuA5KuNW7U5OYjyzVEKZOpcFP/oUthdbbwYK425lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bu+hIrMY26t4IN8vrw1q4AAMCvrRvqcIMhbZsna4KIRBAdGMqGeqf92I8GNfm1PhZGkX0r+p6n7EbPAK8gJJmmJf95l+xx2kmmxt1PXGtkZAJmNipQP1AAwCT7lavjmQPqz2RTxbFJoLKPY5KPQFzPo2tVHRkadbF+xmYmWJhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.242])
	by sina.com (10.185.250.23) with ESMTP
	id 6739382300003351; Sun, 17 Nov 2024 08:26:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9061028913242
X-SMAIL-UIID: C7F3CF17DEE84FBCABC75CE195795BBA-20241117-082614-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+823cd0d24881f21ab9f1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] WARNING in rcu_sync_dtor (2)
Date: Sun, 17 Nov 2024 08:26:05 +0800
Message-Id: <20241117002605.1398-1-hdanton@sina.com>
In-Reply-To: <673866ee.050a0220.85a0.0013.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 Nov 2024 01:33:34 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12188ce8580000

#syz test

--- x/fs/exfat/super.c
+++ y/fs/exfat/super.c
@@ -46,9 +46,6 @@ static int exfat_sync_fs(struct super_bl
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	int err = 0;
 
-	if (unlikely(exfat_forced_shutdown(sb)))
-		return 0;
-
 	if (!wait)
 		return 0;
 
@@ -189,7 +186,6 @@ int exfat_force_shutdown(struct super_bl
 		set_bit(EXFAT_FLAGS_SHUTDOWN, &sbi->s_exfat_flags);
 		break;
 	case EXFAT_GOING_DOWN_NOSYNC:
-		set_bit(EXFAT_FLAGS_SHUTDOWN, &sbi->s_exfat_flags);
 		break;
 	default:
 		return -EINVAL;
--

