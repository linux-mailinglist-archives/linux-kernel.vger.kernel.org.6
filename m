Return-Path: <linux-kernel+bounces-176535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3CB8C3148
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF372820B9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4E942044;
	Sat, 11 May 2024 12:37:24 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F27E9
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715431043; cv=none; b=N8Dp+xBOBHBIx5mHe0w5oQP+ppZ9pcu+zAqrYBEgJIliejkoxrzcXqEEhfz6izGCJhe/oFb5SwiCS2jiG76Dg4vXmXJd1aybazcfUDm3tO9yH+aSI5YJ6e7CG3dJFuBD6hN+ys3X6Q6fSy75me4x95OgBM60FNSY5o0UxM9YFUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715431043; c=relaxed/simple;
	bh=YZp0Vxr+BdcJmQj8h5VeqKm9gQxsitTweWe1L5eYZyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hI/595hT3umd+MvwmUglCQZ3g1JYRq+91TqET/Xa1T1RvOJQ34VIO6wdFpKjAXbuSkM5AoEGrbuLqK8Wc8sTmEiXVzzggzqdZYAEaFh2imPFDRN8l3mSiQ2J6SpExy+qs7hiEKaK8BQli4KaASoKxQCySMWiIyLnPgWgGn1AxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.48])
	by sina.com (10.75.12.45) with ESMTP
	id 663F667000005FC7; Sat, 11 May 2024 20:37:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 20263631457984
X-SMAIL-UIID: 53D43FB6FA354760A0B2D4506500B9EB-20240511-203708-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] WARNING in fuse_request_end
Date: Sat, 11 May 2024 20:36:55 +0800
Message-Id: <20240511123655.2700-1-hdanton@sina.com>
In-Reply-To: <000000000000c27c85061828ca26@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 11 May 2024 00:42:19 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119603c0980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  dccb07f2914c

--- x/fs/fuse/dev.c
+++ y/fs/fuse/dev.c
@@ -1267,6 +1267,7 @@ static ssize_t fuse_dev_do_read(struct f
 
 	req = list_entry(fiq->pending.next, struct fuse_req, list);
 	clear_bit(FR_PENDING, &req->flags);
+	clear_bit(FR_SENT, &req->flags);
 	list_del_init(&req->list);
 	spin_unlock(&fiq->lock);
 
--

