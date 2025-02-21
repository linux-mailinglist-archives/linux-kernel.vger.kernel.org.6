Return-Path: <linux-kernel+bounces-526805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327D8A40387
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D3D7A93E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B20E20B1E7;
	Fri, 21 Feb 2025 23:36:06 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D4018DB0B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180965; cv=none; b=sAtap5N4UjARGDCVtvXODBWdhQ+a/7fLZwR0M0dN7kBvLnhKLqmvgBaW2UhSYdi1RBAC9RBBawGgva6E4WPTg68jPLIgSYLPGDsPx8/sEAfIx663amdkXdX0JoVY/MLEBGwRy6i6yHk/7XFdk+lfM9QRt9YjBKKE03Ko6rM1JJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180965; c=relaxed/simple;
	bh=y7ZOoqrYTZQjgRqISzGn0y1xKAr5qa2/QnSg3qdvFwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ps7S80CyLGxdYsf5/59NS69CXjId1XraLGMc0P2sa0M6XrtJcocg+DO/6X1wa+ulm0KZgpIfgzkzPZEwBFTNCz6RQM+CMCqIV4zVRaPqFqLkUTmMxK0ZzW2bucx9JuRkV1UvLbafj1KW51ugcV4nAvxf7BrLvSbOLBRC94+WAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.91])
	by sina.com (10.185.250.22) with ESMTP
	id 67B90DD400007BB5; Fri, 22 Feb 2025 07:35:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4431177602740
X-SMAIL-UIID: 7268496CB2404F68BF68778890C531B0-20250222-073550-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c0dc46208750f063d0e0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] kernel BUG in folio_unlock (3)
Date: Sat, 22 Feb 2025 07:35:41 +0800
Message-ID: <20250221233542.2507-1-hdanton@sina.com>
In-Reply-To: <67b75198.050a0220.14d86d.02e2.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 08:00:24 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=141b4ba4580000

#syz test

--- x/fs/netfs/buffered_write.c
+++ y/fs/netfs/buffered_write.c
@@ -338,7 +338,7 @@ ssize_t netfs_perform_write(struct kiocb
 		folio_put(folio);
 		ret = filemap_write_and_wait_range(mapping, fpos, fpos + flen - 1);
 		if (ret < 0)
-			goto error_folio_unlock;
+			break;
 		continue;
 
 	copied:
--

