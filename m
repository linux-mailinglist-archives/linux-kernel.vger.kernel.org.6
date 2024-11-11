Return-Path: <linux-kernel+bounces-404125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB49C3F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3BA1F22EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDF819CC3D;
	Mon, 11 Nov 2024 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O4sgV1/g"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2314F126
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731331013; cv=none; b=siUKEEtsIOGm9WHVvyyeYYXhascLRWr8IWmCj8SoUTkjilu+MAz1s1psDrNLt3kEJ0rKQr6csse6eW55tvv2zQb0bxGW9zNL4trUPGVt7IFNemOg10GcTUg/Ec6h+goSIp+V1mf4iluMuvC5GJKMcadtXXegrt/9emj82QIsxwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731331013; c=relaxed/simple;
	bh=3DQXfyD0tt+xK3kz9FDh6A2vAtIkq03S6d7sqN7yCto=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uEO/PYNepjqYXxUVPdRwFj+tLvG1eZ44JceyLXNXFd0gF9+2Sa1Dfmg3z2U4RqN7ei16cRvg56AI5k9NYQxcWP+ZSzePcW8hewSEGtWsc1oOXCDWpwl+Mv0r2BL0fnN4+/1XXT8jsjl+1PX61Qr9f//y8WsEFcqhTEzFjM7Xtmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=O4sgV1/g; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731330697; bh=1rV+5Yd+aBNza93Evyh2p4SGvk8mi2yyFZM8rHW5tws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4sgV1/gI77QYuLVIutYnh9sm8V5yQT8yZpEnLyodNG2XWhehDKQyx9qkvdFZfayg
	 nfjWw1Vrex382g4EGCDLLWmxHVfB/ZAv2wpybv12Zicc9POKDJIBcE6sPtK57toQhc
	 xe4V6ws8ZzuRuyWzZhhtCISXYvqvAdP85gM3QXV0=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 2E40B011; Mon, 11 Nov 2024 21:11:36 +0800
X-QQ-mid: xmsmtpt1731330696tro990g5q
Message-ID: <tencent_29BA7ABBA933079E391B774B921B61255908@qq.com>
X-QQ-XMAILINFO: NMguc1TmhkUh/5jRMyx8kGjZXOM6GM+k6oaY8uczVex8P2Isrtz1x/DroY12s6
	 g7K6SRrurQoq3qZsHulQ7H643y4f+sPOtdE/6AMaWf9YzvfHYORycGGyAaIIvVt6vJA7aLkovEF0
	 RuB5VSK+AdJIoHHzFMBrKnQaiIM+Xwf/MUKZG6HjawaJv970rSWaYfa0HUzb5WR/rzgt9TC4Y3oj
	 vjnZreOP0Q34FZzqUd5RjMUWZ5bHmiymBSZVZmmmU7ZTZffFkO9iLJtEY+KMFciy2LiENRMZoXMR
	 ZKJTF2lauD27jeEYQAVNYFI/MxDt7nZUuTTkqdcqVvYIW75PKZcMJOZQLJGkqnmi0T3/pjuB70YH
	 iigqK0ZWaGgbRZGs29aXwbtwihsbbJrTNDY/GP67DxJucCm9jYafBOKwIZUjO1Z8lC+13PomveGy
	 U2ho5fZPZTFJfK5a3fyRGgRoYYyikEt4Cxc/QTobiHt6gn5xwSL+5wFdxdEwtUyTnJAL/zc7U0TV
	 W8r4zu3g+1ktQ6XVG/dD7/3CD+aD4BZkIpCAA3DuoyXDqNxfdlKrju6MRJjUrFzNXNQkjr4XPUR5
	 corLd06toMGjozYttPTIUtzVYpEtj5BNErfjgZwU+Vj6FVi7a4QUg3zGsMipjyzLV+iAIm9PxxDf
	 n5e4brFUhI1ixgFMq2Bxi9eqFWuDBbIMgBGPrr+ayy1X7GI8HX5TUXJ2ckPtLye75wQ8KtkpL9vV
	 LwrBDkb8GgZZ0ab4dYcdmZQXVzqtoq9759lDEGf57x76N+rW8HJDxjyxT4EIoZmUFm1yiDDkb//u
	 Ca6kAC0JzBcLb28tykUiv+S715JCrQQq6LyKFhSH52ObVVqmUM8Nrn+s284TyTU2BTqS8C93biH3
	 wZ6gW3KP+vM0ag2hghapuRNTzh48zwqsaIHVvpWAVnW2PKEL+upuWWv9+DjwK1pN2aUokJIrNFD3
	 AKBiLVuacn2M9wqkV97Q==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4cba2fd444e9a16ae758@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend (2)
Date: Mon, 11 Nov 2024 21:11:36 +0800
X-OQ-MSGID: <20241111131135.848273-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6731ef89.050a0220.a83d0.0013.GAE@google.com>
References: <6731ef89.050a0220.a83d0.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AA lock, unlock for hfs_bmap_reserve.

#syz test

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index a6d61685ae79..1742e43ece58 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -101,7 +101,9 @@ static int __hfsplus_ext_write_extent(struct inode *inode,
 		if (res != -ENOENT)
 			return res;
 		/* Fail early and avoid ENOSPC during the btree operation */
+		mutex_unlock(&hip->extents_lock);
 		res = hfs_bmap_reserve(fd->tree, fd->tree->depth + 1);
+		mutex_lock(&hip->extents_lock);
 		if (res)
 			return res;
 		hfs_brec_insert(fd, hip->cached_extents,


