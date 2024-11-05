Return-Path: <linux-kernel+bounces-397243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAF9BD8FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3DE284047
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E39216212;
	Tue,  5 Nov 2024 22:47:16 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239ED17C2
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 22:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730846836; cv=none; b=WuDv1UwxJizfowztumuGzFILAOOjSzlYK81+i8JbmW7oC3mrF7alCgz/H+hnzEKgFW687phb7LZnYT/m19uAHZUxoI0Gtmhjwx22pz5YxfyYjnah76k7DlphVRLycU7RrPxROOr91EZnuBki7NvQl3X2B5G1ZAvzlzOBAa2w/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730846836; c=relaxed/simple;
	bh=TWIf9HYy4RG/ySkmPGLL+M6eEhadXPIFNROQt0VV66g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9jUHUu1XxMsgAOuFRaDbpTz2h61aNSoO/s1ngb5UDMFlM6yQdHDeYdqWZqk34oQ/lnGFmGvR6Cc613TeOC4oAQBHhILl0Qqt8xrLlmx4K6tXrJ3j1IQBXu1Qwc78/Ivm8KSH4RUp3K3N/628YpIQKmMwF3enHdB0Ta3H5/+ENU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.41])
	by sina.com (10.185.250.22) with ESMTP
	id 672AA06200001531; Tue, 6 Nov 2024 06:47:01 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6927157602718
X-SMAIL-UIID: 05079710ABC2469A870E802CED61A7D3-20241106-064701-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a3c16289c8c99b02cac1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] [trace?] possible deadlock in blk_trace_ioctl
Date: Wed,  6 Nov 2024 06:46:48 +0800
Message-Id: <20241105224648.3310-1-hdanton@sina.com>
In-Reply-To: <67251e01.050a0220.529b6.0161.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 01, 2024 at 11:29:21AM -0700
> syzbot found the following issue on:
> 
> HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
> git tree:       linux-next
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125a9340580000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  f9f24ca362a4

--- x/block/blk.h
+++ y/block/blk.h
@@ -72,8 +72,6 @@ static inline int bio_queue_enter(struct
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
 	if (blk_try_enter_queue(q, false)) {
-		rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
-		rwsem_release(&q->io_lockdep_map, _RET_IP_);
 		return 0;
 	}
 	return __bio_queue_enter(q, bio);
--- x/block/blk-core.c
+++ y/block/blk-core.c
@@ -358,8 +358,6 @@ int __bio_queue_enter(struct request_que
 			goto dead;
 	}
 
-	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
-	rwsem_release(&q->io_lockdep_map, _RET_IP_);
 	return 0;
 dead:
 	bio_io_error(bio);
--

