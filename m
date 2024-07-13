Return-Path: <linux-kernel+bounces-251415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13089304A8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 11:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295C41C214C7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 09:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F8D4AECE;
	Sat, 13 Jul 2024 09:08:06 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35D641C77
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720861686; cv=none; b=OnFEKNzgONSjb/nqNaz0mLcJilxUfKr70W/Yg/ShOb9HvCiyjAV5elqAGJMA9gwOCA++imny0kngWWyyrbidkuLJTwHSfp+xygflZQzzuy62kKuXmW5oBxKvjAZc76uBnI9XxXGFiy+KwBAE43BosF29knPRwbj2Bl/6b0uHCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720861686; c=relaxed/simple;
	bh=F97KmSYr6BVNzF7rCK7Sa+kxRwzbEhhAf/TEjNrGfc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V4W0lGei9MLLiLjYqph1ou3GmwGvulylBAcLvC7QgT3/LPuQcet17mkY4rq3hCCp1UbQffa3F/yncOYUJOH6Rq7Ptg+FxtVbFxVLaBESzX3CXWOa82ht5bBURBsmLl/tncgHwuw8Md0YpDxC/Gz3frwxbwpvg91N2MrXjP4Tq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.52])
	by sina.com (10.185.250.22) with ESMTP
	id 66924354000008D2; Sat, 13 Jul 2024 17:05:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9744697602725
X-SMAIL-UIID: 4677006D4DA542B1862B570227BE2FDA-20240713-170526-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in list_lru_add
Date: Sat, 13 Jul 2024 17:05:18 +0800
Message-Id: <20240713090518.866-1-hdanton@sina.com>
In-Reply-To: <0000000000002d320c061d0ff813@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Jul 2024 10:11:25 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    43db1e03c086 Merge tag 'for-6.10/dm-fixes-2' of git://git...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b1da7e980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  43db1e03c086

--- x/mm/list_lru.c
+++ y/mm/list_lru.c
@@ -55,7 +55,8 @@ list_lru_from_memcg_idx(struct list_lru
 	if (list_lru_memcg_aware(lru) && idx >= 0) {
 		struct list_lru_memcg *mlru = xa_load(&lru->xa, idx);
 
-		return mlru ? &mlru->node[nid] : NULL;
+		if (mlru)
+			return &mlru->node[nid];
 	}
 	return &lru->node[nid].lru;
 }
--

