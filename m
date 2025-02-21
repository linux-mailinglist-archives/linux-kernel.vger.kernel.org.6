Return-Path: <linux-kernel+bounces-525738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19574A3F404
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC8F167234
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5C20B218;
	Fri, 21 Feb 2025 12:17:20 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA094209F58
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740140239; cv=none; b=BC1G8N9oFAl5DeZpdr91iMF7HzQVgRPSMZpAESlvDZ4GvVGmDDutkYgcXId+na1pQp+Y9qIxolMwNraUOiv+ONFrvjL4kRi4CR6fQ5zwVG4SgNtZGnTK+qum+7g3JfcCu8uKYi3T3du2rgeMJb5YLtfpUv7T0ARgn0q5iJvSnhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740140239; c=relaxed/simple;
	bh=f6eSK4Iy11NrnYfaOZ6BAPZJO7NSRjeD72OmFXcfok8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGR40UE6C+Em0U+rdTVUDshjH+8DdiyFempRfy2KsvhO+faGU2WN3qrkQ5DWe+LmA9glHZp0lICtUXoSkdWqfcO1IGDzpyUEQbR4BclvpELxmvuq8sKqKR4A1z3yaM3BxC8V7b5l5gXLjC9QX0VGucuC3lIVBnKkaQlmeqNjNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.75])
	by sina.com (10.185.250.22) with ESMTP
	id 67B86EBA000007A9; Fri, 21 Feb 2025 20:17:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8578047602645
X-SMAIL-UIID: 6EBDBD0BBCFB4722A342D445B8CCE9C9-20250221-201704-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+30a19e01a97420719891@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in cleanup_net (4)
Date: Fri, 21 Feb 2025 20:16:51 +0800
Message-ID: <20250221121653.2463-1-hdanton@sina.com>
In-Reply-To: <67b72aeb.050a0220.14d86d.0283.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 05:15:23 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d89498580000

#syz test

--- x/include/net/net_namespace.h
+++ y/include/net/net_namespace.h
@@ -339,6 +339,7 @@ static inline void __netns_tracker_alloc
 					 bool refcounted,
 					 gfp_t gfp)
 {
+	get_net(net);
 #ifdef CONFIG_NET_NS_REFCNT_TRACKER
 	ref_tracker_alloc(refcounted ? &net->refcnt_tracker :
 				       &net->notrefcnt_tracker,
@@ -360,6 +361,7 @@ static inline void __netns_tracker_free(
        ref_tracker_free(refcounted ? &net->refcnt_tracker :
 				     &net->notrefcnt_tracker, tracker);
 #endif
+	put_net(net);
 }
 
 static inline struct net *get_net_track(struct net *net,
--

