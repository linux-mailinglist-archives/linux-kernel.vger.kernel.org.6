Return-Path: <linux-kernel+bounces-557683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A681A5DC64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D6F188DE39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A052417E4;
	Wed, 12 Mar 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="r/v0NETr"
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF6E226CF8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781643; cv=none; b=RY2RWCcxwEqnZV93DqnISCUp0mSP9gYJtAEA+z4pEjObohhBDqeeXGMH4sAFmj27XpHIxlmg/RE2ErXpJC9GlYKV3qNQbCTKqj+WgVA6k+KW24g/hq0IIg7Is1zjiV+S6DaD0w/fXgsCZEOdL8Uzj6RXJ0CClJ6uzafaHpRxlOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781643; c=relaxed/simple;
	bh=2WxcF1Ap6DKCim6A6UplxZhJw6IpUBv9NIqCy4lIlSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkZRBzQV3Wr1IK+FAuYN/ixvJBiTzubYRz1ZK1akxcHD8XCP+ZoZuK4h7aizYOEX0RqiGMZK5iPBqtGvrO4MN5YeumCgtMi5SAUT7pdgWj+F8MNQfsDPKEPQISl3QkrdztjJrgXz3sh4iAUMWxa9pmGzJQnaVXgf6XAtUcdAtT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=r/v0NETr; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 86F9314C2D3;
	Wed, 12 Mar 2025 13:13:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1741781638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fav7QHPJLFYJX6IazWEN8Wh4VYiGppIfRG3xbT9MEGg=;
	b=r/v0NETrfHxZ+xW4H0HZd5Hn82azCeLT5F+NQzAXywtmby0sZO9hqu/Pglq+jfVLu6b3T0
	arvu2kZbGfP6/fvMbFZs9k4jNMNIArPXTCZN4wG3fkQ+LcQVDS0woifMUeeYxBl890p+a0
	fmfwiazF/CfOUPpS68HBGpe3fywVBZTq+WZZQ5/4Wj7mxGZKZtkclA5+YaAHXUt9YYSCTG
	2zkGiCX2599jECblcFANj9eUZU3yEWANz36ABQraxqPpqBNrPuEkcA9zHAGF4PMC1tSv7c
	E83zRTXUyJF8oboOPzuLtIOnzWJ8OJ14ly9sx8pkX+HZySJEeHq0vKMDVLordw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e08bdb9a;
	Wed, 12 Mar 2025 12:13:52 +0000 (UTC)
Date: Wed, 12 Mar 2025 21:13:37 +0900
From: asmadeus@codewreck.org
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: ericvh@kernel.org, linux-kernel@vger.kernel.org, lucho@ionkov.net,
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
	syzbot <syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [v9fs?] general protection fault in p9_client_walk
Message-ID: <Z9F6cakkpF26_KJu@codewreck.org>
References: <67d12512.050a0220.14e108.0024.GAE@google.com>
 <34836920.9mNPFRc1x4@silver>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34836920.9mNPFRc1x4@silver>

Christian Schoenebeck wrote on Wed, Mar 12, 2025 at 10:36:15AM +0100:
> > RIP: 0010:p9_client_walk+0x9a/0x530 net/9p/client.c:1165
> >  clone_fid fs/9p/fid.h:23 [inline]
> >  v9fs_fid_xattr_set+0x119/0x2d0 fs/9p/xattr.c:121
> >  v9fs_set_acl+0xe6/0x150 fs/9p/acl.c:276
> >  v9fs_set_create_acl+0x4b/0x70 fs/9p/acl.c:306
> >  v9fs_vfs_mkdir_dotl+0x517/0x6e0 fs/9p/vfs_inode_dotl.c:411
> >  vfs_mkdir+0x57d/0x860 fs/namei.c:4313
> >  do_mkdirat+0x301/0x3a0 fs/namei.c:4336
> >  __do_sys_mkdir fs/namei.c:4356 [inline]
> >  __se_sys_mkdir fs/namei.c:4354 [inline]
> >  __x64_sys_mkdir+0xef/0x140 fs/namei.c:4354
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Just had a glimpse on it so far. IIUIC the trigger is in
> v9fs_vfs_mkdir_dotl() [fs/9p/vfs_inode_dotl.c:411] ?
> 
>     // NULLs out fid (since dafbe6897)
>     v9fs_fid_add(dentry, &fid);
>     // expects fid being non-NULL
>     v9fs_set_create_acl(inode, fid, dacl, pacl);

Sounds about right, inverting the two calls probably makes sense?

OTOH I don't get why all mkdirs don't hit that.. ah, it's only a problem
if the parent directory has some ACL and none of our tests hit that :/

Well, it shouldn't be too hard to trigger & fix anyway, since you've
done this much want to send the patch?

Thanks,
-- 
Dominique Martinet | Asmadeus

