Return-Path: <linux-kernel+bounces-295239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A13479598F4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED971F223C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7F1F2FFF;
	Wed, 21 Aug 2024 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="MW4QyXvI"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EED1F2FF7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233057; cv=none; b=FM6N0YjxRblTAN1HJrFAT1mGiFrHI9DbXfLvtLSoRl5PKP5d6n8r1M9ZyGI6xSOqoWrxgoFn1uv0gYMWtuyJ1nUREdPg9XdMHDeofN+p1bGma3X9ZhK429hSzeEj5tfDvmFe40fm/Ym3Ij8XjfGZH21PqYiX1ZyrOzQ/eR8fb+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233057; c=relaxed/simple;
	bh=2ZZgOLJgDqZekim7e05jVP9S+hgUN2EcuqldTQjPrDY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KpG/fRSYf3gxc2IsiybqzOKNGDQMx31m4LebdK8YKRthKheulFTVqpxtyPBE7oAluDHpzn4lOCoKJPm0DIkTEzIbTY13RtZ/Oo6RQwQ6QwHHPaEOM7mfTFSkArtUkW2mdCrQN45qhEDWw37HHkEE9v1C5mip4FAZFhRTRC0VXmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=MW4QyXvI; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724232738; bh=EGzNTf7mYT7EcPJXLX4yrtisRC7op8gi44E0kTb7W8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MW4QyXvI+yEA75VUZMY75lM7TO/qO2xwvoadyPnmoChHuUPdG0O0li320mLCnIJLo
	 4zT+xD5RGbMUE+kcOUQrDrqkAI1aPQ88WS2jg39Y6X+J9mpD2WVWfQvsAOvpPeimOX
	 DIu/V4KcjF0mgGEZFmvfUvHETHFGFvUDIREs89P8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 80F9020F; Wed, 21 Aug 2024 17:32:15 +0800
X-QQ-mid: xmsmtpt1724232735tl7br2q7f
Message-ID: <tencent_3BC9CCA2E7ED86CB52D9C66449BE2EC72E06@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3Hd9Afrt5jqCFIVaVWzeRp+HEDbS3U/PhPLtCb/ZMq6NH5DhNXJ
	 pUo1amIYO6xtt8V0cpXCagZrMAZBrsFUnWa9Rio88fq6Z5Ja8/NDQABoA3G9TlvlS20u5XrNwyRA
	 Xeds8k5mxZwZKh/TlwkFH/Hlr/oXbNPUheaGI3SymZclvWQeBZzJS9k+dr4FKEs0uIIl08DjqSzB
	 jOYhSN9y+WkWgS2VCJfT1f2NR62Ms50MO2mk7lCbJszPeSQoqcYJxhRWxwNoyp8N3rL3tq9LHzXz
	 vtMfn8zvmHdZnHCjF/eFTOHnzQoCUqFpOHBesvZD3GButo/UnRBiVpH3bVVYH0IYJ7VmxoiWjsS6
	 JgsSFNKyqQ8Ewa3uLcdRq5bQVWdD4HFbzJLihbbIkwGjF6jA4fbxLjIYFi7fgh+YzOl4aFBJ8+Vz
	 u4KMDrSvYCqpqwtQ71PrRED7dhB7PhuWMhN6CYnU+sqNpZa7nKIUY4cxUPJCQEDM5xbLqVGI+EVR
	 VV3cVx6FhiS/KCq2GiO47ejNHOL2cn9NiWdcsI0rj8b384P29SQJGyfEhEvZfHj1YV9lmX9YuMR/
	 4Vy9Fp8jowLJGjr9dKq0F9gkH+n0A3d49tx6PwuqE2En1c/ZuWTCZaIDE0WRjKl4JEc8qecdO59m
	 6A+mooDMUVL7UagjmZrJUJc54K/4iIeathc0VItWsh+9EKBSWPgCTUP4TjZYdFchmcUHHHRy594G
	 SZyNs4gdS2HXFENlfrO9ecTxb/0xxT6HKBKdsMEQ4UN2STss6lX6hbfYsu0TIBLvgo1tXMRm1MEb
	 ZZVbt0k2YT0mnviRniAP55LP6Y786dYQgtUXkG/FcineoWgotQp/XP0u/xr8+YDTPYkikbcdvMLg
	 AmiQWcnd6r09cOWnokoHKv6HzVJSb8zMZfd26szihNlJsy2hJpyOX+A+0leospFjQ73YRyjk6y
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1fed2de07d8e11a3ec1b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_try_remove_refcount_tree
Date: Wed, 21 Aug 2024 17:32:16 +0800
X-OQ-MSGID: <20240821093215.463409-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <00000000000032dd730620055fde@google.com>
References: <00000000000032dd730620055fde@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use trylock to replace

#syz test: upstream 1fb918967b56

diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 62464d194da3..f60e3178fe74 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -363,7 +363,8 @@ int ocfs2_init_acl(handle_t *handle,
 
 	if (!S_ISLNK(inode->i_mode)) {
 		if (osb->s_mount_opt & OCFS2_MOUNT_POSIX_ACL) {
-			down_read(&OCFS2_I(dir)->ip_xattr_sem);
+			if (!down_read_trylock(&OCFS2_I(dir)->ip_xattr_sem))
+				return -EBUSY;
 			acl = ocfs2_get_acl_nolock(dir, ACL_TYPE_DEFAULT,
 						   dir_bh);
 			up_read(&OCFS2_I(dir)->ip_xattr_sem);


