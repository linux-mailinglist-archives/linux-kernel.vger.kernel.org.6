Return-Path: <linux-kernel+bounces-198222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE7A8D7521
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 13:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626631C20F5C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAA03839D;
	Sun,  2 Jun 2024 11:49:31 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C103B1A3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717328971; cv=none; b=rGRURZFfEHglQ76vIiA1QotjBDEhO1kX0EJ9MQQwivyyH6AcAg09lWOoMnG+UJ0IAt6G96aY5y0kdhT9oTJExRVTMJ4VeZNjf8LlnOC3NPjk+z7769aQNIWzesCF/JNLwDEOBoN+hRbL1MOBWsAIWLyK8+zHJ8lXBArTFpDSjcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717328971; c=relaxed/simple;
	bh=5wV+SZF4zUDLsPfsXwsjRqYxuqAIQr5q9I7OT7Ws3bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVKRHDS0JB/UtScosubNyyaw9nckLdAvd9aGDmueAum0rHLx8mda54L2kaxslZebaI5JBgL9PUN1+Hmi8BhQ+28cLZNO4sflZ/FTLB4VudHOskLy1CQaoE2w5VxWt1po/B0+9kN0uvsipmvaIm/DilWdptYcXmxR8sQ5MlvC8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.183])
	by sina.com (10.75.12.45) with ESMTP
	id 665C5C3A0000101F; Sun, 2 Jun 2024 19:49:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 15494031457841
X-SMAIL-UIID: D5F0DDFA5C2245809ED9AA14FC51F86B-20240602-194917-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_inline_data
Date: Sun,  2 Jun 2024 19:49:05 +0800
Message-Id: <20240602114905.1462-1-hdanton@sina.com>
In-Reply-To: <000000000000d0d5e20619d2b486@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 01 Jun 2024 04:50:27 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    0e1980c40b6e Add linux-next specific files for 20240531
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d86426980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  master

--- x/fs/f2fs/data.c
+++ y/fs/f2fs/data.c
@@ -2854,7 +2854,7 @@ write:
 		set_inode_flag(inode, FI_HOT_DATA);
 
 	err = -EAGAIN;
-	if (f2fs_has_inline_data(inode)) {
+	if (f2fs_has_inline_data(inode) && !page->index) {
 		err = f2fs_write_inline_data(inode, page);
 		if (!err)
 			goto out;
--

