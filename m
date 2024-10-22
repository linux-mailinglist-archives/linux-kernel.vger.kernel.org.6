Return-Path: <linux-kernel+bounces-375844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E19A9B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9958282F64
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644C3154C07;
	Tue, 22 Oct 2024 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vPVWn65+"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE3132120
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583873; cv=none; b=f+3ZWBWiOljBodKBDx4Dsq132w44nJVxXDrayjT2LHiJErnyNfpwFE5rVLrHY50WymZfb3oZV3AfqUSWc2jyRjYQPBlOuwqbu0R+aM1L92UsSuV5ks7ZegZ2JIo/vq8+3hkYdX8MwReXLKhKi7U0FrLUvOUGTbBum+cJ38QlHDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583873; c=relaxed/simple;
	bh=cIMuP7WCyt24tGuPML+XaNscbZ26ovd0hn6a8KtrjLE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GFJ1ge7/PigkVRNC8NtcVlsjSrMFwPaz4DEJUlUOydinlr0G/2OFJxugSD2gn1eTN7uqCjo6Y26x4++Cb4NaGEI3CIXEpsIbUBfpB21OdZu76e0I9+ePSvdjqvHJP4rn8IuuQtPbtXi9nItf4ZngDog5HCFIsIRXvjxRmoYhoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vPVWn65+; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729583861; bh=cQX4zmQ3JZpJligQAgb5LAogmr4DT45EMpZD569++A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vPVWn65+GONZC81ULUtk/1X9PqOj6IrEEIDHPl83cEOiCrKtyH4Px31/gZ7twHzLr
	 tiSb0ByIxqRIWvlEztIqGm17PqbgiRCt9HpUdANlZLC1tkHZC8dg2RuskgaD2SnNSg
	 YKeUtJ6OUlgI7nAGAdfEQfjBjQul9nEgk2EtJAcg=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id CDB068E2; Tue, 22 Oct 2024 15:51:27 +0800
X-QQ-mid: xmsmtpt1729583487toip664ki
Message-ID: <tencent_85E3BD8449176BF76DA6DE736BA36E097705@qq.com>
X-QQ-XMAILINFO: MmGwrenOE7FGGUE2YaI0xVeTcxrim8uxioOhst+zM9dvyUq18NYh1nNjYmFNa1
	 09VFw/wRY5NG7elBko1pBQvkS0qIQpgI5gzcQ03prYH6oFYhdIlx6DMUrB4gOCkz8uIeZ4EYkypW
	 78dOv/uGBt8rcg/3IopguMlENa2LbV4rfRghX+eyWayF5DGItTgY5qLXE+TBQQXiyoWVwXNTrJas
	 tmgcqbRWd/U+y/yCBbR26IzRbH2kPkFotLCLdBU0XlDCg+5L7xAr1gPxDqbwY0Wbm0S3I9xlVo/B
	 gSspTYmSgiK7acz5Z1g7OGIJ0hcTEo1O7VAMaqoVOpc2AbhKlh7u+y+2vQ/oNukF9ne31vvRUL9/
	 e7asPcM72yD2nYH5ZUqRmCXn1AIRN5K1OJ+hAwDKphSjqbnErTsoja9Y+hvwqey9hRjL8zGSd6pq
	 I3eb4el0DCuBbPdTLsUJkGOg2EnGKHDUPxR507fpYJUr6wngclSnWlouzDB5u2vx5i3Rn3VJPSNl
	 FEr5ne1dwxGdgCJvvZgxQ/whCzDilNVwvTkIlB3g/r0zI0bUd8chFTTJtEVABPF+nLtfol+b7VEV
	 +VidfXZfXkiHy00PADFKSETKqqGToi87oSUv0hdblSx9DzCfwgWvs4XpStkxDp66xtebzGNi6/M2
	 KNfaWqeZaT88wb8clcLbRhU4qKE0kMQtyQjqYEpEa+7J1ZAsKNxVUpPszKiDXuAOcjxKQMGBRXao
	 cntiYYFQlhk0Xr7LY4PCSNwHKcgX1lawiQIEisD/zlrkIvrgqTh+qqPc+u5I/BTa9LZF5uq+2IaI
	 t+LT7+OZVJKq2CGjabKfShSy2dn5WuZKVg55TIdziqBDnb1Qlx+F7VrtgUSgV6bOsH0DbaRoa2sW
	 929epe3lERGrPc6v6eaEoSawcZxMl+YcLRAFlLS4M3Rlyasmbhl5I=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a234c2d63e0c171ca10e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] BUG: soft lockup in debug_check_no_obj_freed
Date: Tue, 22 Oct 2024 15:51:27 +0800
X-OQ-MSGID: <20241022075126.3462235-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6713d23a.050a0220.1e4b4d.0029.GAE@google.com>
References: <6713d23a.050a0220.1e4b4d.0029.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

directly use the simpler _irq() lock/unlock calls instead of the more
complex _irqsave/_irqrestore variants

#syz test

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 5ce473ad499b..936c94655e35 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -958,7 +958,7 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 #ifdef CONFIG_DEBUG_OBJECTS_FREE
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
-	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
+	unsigned long oaddr, saddr, eaddr, paddr, chunks;
 	int cnt, objs_checked = 0;
 	struct debug_obj *obj, o;
 	struct debug_bucket *db;
@@ -975,7 +975,7 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 repeat:
 		cnt = 0;
-		raw_spin_lock_irqsave(&db->lock, flags);
+		raw_spin_lock_irq(&db->lock);
 		hlist_for_each_entry_safe(obj, tmp, &db->list, node) {
 			cnt++;
 			oaddr = (unsigned long) obj->object;
@@ -985,7 +985,7 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 			switch (obj->state) {
 			case ODEBUG_STATE_ACTIVE:
 				o = *obj;
-				raw_spin_unlock_irqrestore(&db->lock, flags);
+				raw_spin_unlock_irq(&db->lock);
 				debug_print_object(&o, "free");
 				debug_object_fixup(o.descr->fixup_free, (void *)oaddr, o.state);
 				goto repeat;
@@ -995,7 +995,7 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 				break;
 			}
 		}
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+		raw_spin_unlock_irq(&db->lock);
 
 		if (cnt > debug_objects_maxchain)
 			debug_objects_maxchain = cnt;


