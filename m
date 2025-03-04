Return-Path: <linux-kernel+bounces-544149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE78FA4DDF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9A8178AEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D10202F8F;
	Tue,  4 Mar 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DCq+KqUO"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A8A5228
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091462; cv=none; b=V+pSAsOgfrj5t2jvcFCidG8EDUvzI5qv5voqTOvezu37f2C9CQlPZ2mPQ2Co6r5hfr9IN4rjQs/eVA3Yfowjfv4C/j8toaNtIdDcyNCOeohNwsfedCHPUzxiArbL9jqEkK7F/uNPQqLolJSKa+pUT3DgZEzr/32NCq0sovZ5mMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091462; c=relaxed/simple;
	bh=n9iWgf5SMNp03OtwUR3CiJyjcZjrPVgAVOi5pzEkZhA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VPbWZL4066D9fThg5OqLBGL0eKSMXtzpdJOK+DjPCc/oNWDN28w4g7dFVbBZhLjJlFlhgRPzSE7RaWWNmrzW/dWxxr2mvtF17k85aEUrYr/2Go+Pxj0KLYRqlNOMJRqTD3q9Whq/OkPq8nbGTfSt7USHE68GnqIAxE5RBE7XcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DCq+KqUO; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741091151; bh=WCztl+HeBYJWM3ssDFTF3w6Tv1bQRSVDrElxGp+t9As=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DCq+KqUOLLSRxl59DlLk6db/e24Qee2L49re+ecOYbZ1x7sazHBEuKopGfeGOWWGJ
	 7123U1V4U9rRrThNtmLIh+IxBE7Qf8JWdwlv8JKK0Ls4dqsu8gyi5ThHMNr1+m5+T1
	 wrEX7Gq9u1AP7mcejPIoFYpinhg+imSqprJR7wfs=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 67138484; Tue, 04 Mar 2025 20:25:49 +0800
X-QQ-mid: xmsmtpt1741091149tccsw8239
Message-ID: <tencent_D86ED06EEDCC9767C7C6E012F1065F09AA06@qq.com>
X-QQ-XMAILINFO: MYj4oRzRRyycWuy2nFsXpA6cZsbrAHK90oNry43Nzr+oWCjE8l3b8uh6ykjkrT
	 H9ytivQ1DvRxtZx2JZ2GZSPoeL0odEj7O3d+AS7iN8P9BymIVTcvFNjfFGdEzY5Slwhz0S6BfQJR
	 G3o25BvGx3pFdILRBxTtn4AAGkK8pYAxBiXzniq8sMyPJZh+gF0n240CC8M6LrsimFEixsBCxhrP
	 QiBCw2XbP7Kttj/CNPeek7B1Gqn+pTRxDYT6RA4SDXmGN6EZomuhY866IfoBF9lQTw9TvNwdES7c
	 A13KUhyA6zh1BtdIDEmyGXuBQ9vvoMEVRoAkmjbQb+pkq92PkzJDGqKfXrnIdO2wW7fNYSc6JgTw
	 YlDJmy+cKzAFeteYCYIs/Xt8JbJzK0j0tAM9FMDTEszqQ2biBlMc7Rx/3tE04/mbUnfeMf+UmkgZ
	 RkmJDAciPlAJZ5O6kT9GLPufOePz5+Kyq1Qe2OfKVQpY9iPETRHCXIPWvvTUrbLUKwBH6xo/1Vxq
	 rwiQM3ZYiYZfds990dom6V7Ml2025WljGJMRv8BXQh9jfwvCqRG7o4K7MgJuSARtKm9f/HHII7TB
	 qTgVtlCkSH4J/JDSowfTa0GYhxS8z454CmKHqxbVALYjYO4g5d9tUYHyZAlTYnR3QEwDIrC4Xsk1
	 3jbxJCi6TvLncpko/fTjR4hZEDKNci7VCw2jFjrPkWBjfz8kdRyGH9G7rsR6YpYGP7T1+gzM9HPA
	 AASh/9Cm1s30ckLtGth1XjEIzMpy2zx3xhJ3G7iaGee4FMP1fVTA5HuwajqHKS+XdBjwIyO/e5yf
	 gD9BEi8+MMA2xo0Cn5AsiQbiPDzurHV/NbNnBpPBeRr+ZDS6KEs0a9qmzuZXxYJFNYv3ANGETjN/
	 cEJqyEr0AnH9GQH96ODK34uTNo0SYJDN1YYAFzNY5Qo2u3sRKTOUQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
Date: Tue,  4 Mar 2025 20:25:48 +0800
X-OQ-MSGID: <20250304122547.590658-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67c49230.050a0220.55417.04d5.GAE@google.com>
References: <67c49230.050a0220.55417.04d5.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/mm/gup.c b/mm/gup.c
index 3883b307780e..290fcdb760a1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2030,6 +2030,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * if the vma was already munlocked.
 		 */
 		ret = populate_vma_page_range(vma, nstart, nend, &locked);
+		printk("mm: %p, mmap lock held: %d, locked: %d, %s\n", mm, lockdep_is_held(&mm->mmap_lock), locked, __func__);
 		if (ret < 0) {
 			if (ignore_errors) {
 				ret = 0;


