Return-Path: <linux-kernel+bounces-212353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6C905EFE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1621C21D39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E721712C465;
	Wed, 12 Jun 2024 23:17:03 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1210241A84
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234223; cv=none; b=Z+sktED7E+PZvFa8Wb5MCAAcBG60ZaGmPGVyPQc4AQOW5sfV4VEWskcNMIHOhzMuDoQGM/bLheUK72cVQjauf38swLxCsQgDRYul591g9L4YuFQlazRRLPM/OHAt7IfKir035WBXoBywvitpcOm7gYq7ralTx07ASp47o20Oxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234223; c=relaxed/simple;
	bh=GMYBDiIRO4QCtnSJYbtRbqxSJT4qrtVLyXUm49d6ezM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=besYt3BjsHMnwc1P5jgO0i6KI59+2TBXJgtoyd1oOMP6w76Eau0QwfvDYZfTjr94OUlCXmQfJfTKYt/0bWbDpVn9QZtg9mANtAkG5ONmctYtoyoPg/mYYog0d/K6pUSF7QGYH2QewlbaMZZZuVb738LItUBwp9xlPeuJ4pJRiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.164])
	by sina.com (10.185.250.21) with ESMTP
	id 666A2C5B00002451; Wed, 13 Jun 2024 07:16:46 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 706263408424
X-SMAIL-UIID: 1CF89B0D61EF49B9A9477140D6C28FBF-20240613-071646-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] [mm?] KASAN: slab-use-after-free Read in lru_add_fn
Date: Thu, 13 Jun 2024 07:16:34 +0800
Message-Id: <20240612231634.2311-1-hdanton@sina.com>
In-Reply-To: <000000000000cae276061aa12d5e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Jun 2024 11:10:20 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    83a7eefedc9b Linux 6.10-rc3
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c645e2980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/nilfs2/the_nilfs.c
+++ y/fs/nilfs2/the_nilfs.c
@@ -922,7 +922,6 @@ void nilfs_put_root(struct nilfs_root *r
 		spin_unlock(&nilfs->ns_cptree_lock);
 
 		nilfs_sysfs_delete_snapshot_group(root);
-		iput(root->ifile);
 
 		kfree(root);
 	}
--

