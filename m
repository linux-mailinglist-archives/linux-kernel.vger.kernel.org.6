Return-Path: <linux-kernel+bounces-348907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256398ED7D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3E81F20FE3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E701537D4;
	Thu,  3 Oct 2024 11:00:02 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C91514F8
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953201; cv=none; b=FptdL8ejdrPNdSm7fYmui4Rdmekydp62ztVVQz8grWVuKGiU8qBXgrInOgMgQaZV7XB0pHoWwUaWT9pO+vEfCUMllBL9ci6vBHSK/PP6u8Sn1YaaV9fjydVRfdZefhFJveQK9T1ccDyEYcE4A4nE+zdfrYE8JOnZx61gHgb9lf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953201; c=relaxed/simple;
	bh=2shQpvFsxnTwHTTUf84hVlytgwfSVcnak3yZAs9XOIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9b+lMyI3ZtP5iOFNAxmu8fHdVia+YSm+p5K/7TC5DibHRHe5IpI7eOhNH4dWuCvlDnQbY4aJcv1AIDufOXiAd14AAMUrsgfuKaTDZO6Ll14y22UOxOEz6MbC1PBloX9OJgXkjBcziCwNEKcMbxeOa/nH9Eqy4zBisjf5gXk5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.67])
	by sina.com (10.185.250.21) with ESMTP
	id 66FE7921000043FE; Thu, 3 Oct 2024 18:59:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1908943408369
X-SMAIL-UIID: E008E9CE2F6E44688F1E7B0B16555A2D-20241003-185948-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b7a3118f6a494674077f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: corrupted list in do_compact_page
Date: Thu,  3 Oct 2024 18:59:34 +0800
Message-Id: <20241003105934.1979-1-hdanton@sina.com>
In-Reply-To: <66fe2a10.050a0220.28a3b.0209.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Oct 2024 22:22:24 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f23aa4c0761a Merge tag 'hid-for-linus-2024090201' of git:/..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174ab580580000

#syz test

--- x/mm/z3fold.c
+++ y/mm/z3fold.c
@@ -1351,8 +1351,11 @@ static void z3fold_page_putback(struct p
 	pool = zhdr_to_pool(zhdr);
 
 	z3fold_page_lock(zhdr);
-	if (!list_empty(&zhdr->buddy))
+	if (!list_empty(&zhdr->buddy)) {
+		spin_lock(&pool->lock);
 		list_del_init(&zhdr->buddy);
+		spin_unlock(&pool->lock);
+	}
 	INIT_LIST_HEAD(&page->lru);
 	if (put_z3fold_locked(zhdr))
 		return;
--

