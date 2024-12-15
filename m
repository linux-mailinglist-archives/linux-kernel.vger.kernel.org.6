Return-Path: <linux-kernel+bounces-446283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46419F2227
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322B21886EAB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBF41EB48;
	Sun, 15 Dec 2024 04:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tXgu77QK"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659A1CFB6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734235985; cv=none; b=CXHyvUm/YzU9kRWJvTkj3ymW/Ga/BRDJLmlDuQrxKnm4aTYKqkBCb8ieDEUBXynTcuajNKZV5z6srtwj5JIkh8jzcD56jkvOeRNm5M68P9RPdHlKhJX0b28pgE+ZEn5clDX/6xHbjIG221gEwjroMZ5NEIciRLj0c6MAkS8JPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734235985; c=relaxed/simple;
	bh=+DU9qUenRGC57uXD6+5RsxuyCrQnLR/9ExiCcYiNnIs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JRFd8+pYEnDyGqRxhZX8opSnrfbSSgX6GC6DZxMnLMAW9lwpVT77V46j+VDbVY3g4y/EvVyM9lv+Yc3lfojZcigj+FRhICMdKJAWKXKY0u9yvASVK37XtwOk+kolRyikiTQUoxoy7cejKXQmo806VioLHJ+aRi4eo/uLnXvhIBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tXgu77QK; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734235672; bh=k0VCZezrdl6j5Sw/CYwerlHf9QZ2M0oEhnKcmA0N7zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tXgu77QKf7xLieKYDZhNjRKpFZ95wd5F9LHIANZCfKUdrDtq0h+Ika7OwbQvukg4l
	 zMG+eX0VsaiWSk6aG9S6BPvLLOusCXou8p5vkTt7BcXNpNghwSfydwFxhh2CBvSz9j
	 cBE/THuF8CsOfdxnG78k096BdbAkyiIPQFMRNAYA=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszgpua5-0.qq.com (NewEsmtp) with SMTP
	id 1F2AD250; Sun, 15 Dec 2024 12:07:50 +0800
X-QQ-mid: xmsmtpt1734235670t5vplu27x
Message-ID: <tencent_F64B7A746D776B66F63C05363E97BE378809@qq.com>
X-QQ-XMAILINFO: NI6TJc3opC6FWa21P27onO+cXR13nnfEQRDSEjk/xL4QECW3YmRmZocMPkzSUY
	 yYzJfIp3i/UC5KAfb6ubgiJ1u5ckWL4OqihHbwi7Suv9AOKqChkPQHpklHiefBtFvgiMx077iC5+
	 aW+BTIV++3DZJuA4UHoAgHiab7zeRZzb9OlDU5qlIxUA1putSjfD8Sg5ou4ABMxZJdSMhCk6grns
	 VL7gQfCW9xwyNgM8nRvIgkfjDLn1nShWncTzXm5P50gdwJnPVwHMUi2t0RpHVxoi/ClNGdjRjBP8
	 jsZhmPt+jTZ9H3q07tvNaOdLVPRypccG/kk/ZEmBXsXjfGa68ro7gScTtjGFe6rPLc9yLGB25bxQ
	 ZDUITpy7R+KPLu3ylp/veA8s1ZhheI4dhAAqObY5I2gjyyYy6V5a0aD1PzpzZeF0jIwUGgBAyOrh
	 YAJ47rOYZgGlMCzsbdrse4GGYfmkZ/SFAOaniWk8WfZcLTYRGtJDDuHhrXOwelBnHHjYmcRw3WJ9
	 2Yjyac68ceU7Ow/zpuncSIUXVhMJGjLlxz3tyd3H3bYE1Uc3uJ7e14yfohv5OcuF4Qx9tEzuNz46
	 Yc92JI8IcSoEu0JzcD9sjoZRLec21e77qdtgfBlyp6tTKQEhI6wDyaWBjUtIZQpIY7zn+h4yVftA
	 eKOAq6ATBQOQbqT+IFCTtVpz7k21y1/vvn8MBuDuqJ/EXXj1vf4t40mVRg8Rmqsdb3PYtAQ08XVg
	 hmm/cGjIGZYP7qvsBr78Vrf7bpzulpgUNEmtdDMe4Hv6xG/IA+k5IderPm5+zzTgqlMIU0Fyeo3k
	 y9/F0sVaOa8RibbAyABJS8Rh4nYr2wEpSw75Tp38FjKw25jR3f8mFwVx7SqlzaTN9PWhZ+t8c07k
	 3aWV9rF3m0JDrND4btmSatgHvwqCE49AeLY6WLUX7mFzuAnXxwyECHKjeN73+XeuYbPJJuI3Tbd1
	 4drPXQQ+XAFOoo/kX94ZL1AJI7irZ56yYxqxCmOFM=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
Date: Sun, 15 Dec 2024 12:07:51 +0800
X-OQ-MSGID: <20241215040750.1672030-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <675c5e51.050a0220.2875e5.0049.GAE@google.com>
References: <675c5e51.050a0220.2875e5.0049.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 8c4c1f871a88..8f851ecd1625 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -267,6 +267,7 @@ static void __gfs2_glock_put(struct gfs2_glock *gl)
 	lockref_mark_dead(&gl->gl_lockref);
 	spin_unlock(&gl->gl_lockref.lock);
 	gfs2_glock_remove_from_lru(gl);
+	cancel_delayed_work(&gl->gl_work);
 	GLOCK_BUG_ON(gl, !list_empty(&gl->gl_holders));
 	if (mapping) {
 		truncate_inode_pages_final(mapping);


