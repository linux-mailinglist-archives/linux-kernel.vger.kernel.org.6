Return-Path: <linux-kernel+bounces-539961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E5A4AB56
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13AA03B847F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939241DE890;
	Sat,  1 Mar 2025 13:48:07 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073E2FC23
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740836887; cv=none; b=Hl93ycDxr5Qdq9j33R3FbxBS2moumXZwKi8r3nnFZOGEuN5sktSmu7qBH9UXmm/DYcTDPuKuO557dFRREsy/AWdeyu8uJ0wjK1pGUzCHtevwrSHANiAnwcdCzikSOV0JeefHOzGvtyQot0zr15X+mep0zCkFgJn2fYWv0KGgFJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740836887; c=relaxed/simple;
	bh=cGgzjxm4Hol7XNW5a4HkXD8Sz4P0IRzUGnK4Ch1H758=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j81/nESsLwSNNgEKQF2LtjJo0ONMQ8+y2/a/YJ1QE4MMaTEsCHXn3TNaG2rAeu6YFO4UUKz7wW+Kz5UHQNRK7dQZ7nsxnFNpzjHHg9VW4PWIuzJKAJi/61JJuWf0D1memCcqn4l0E8JQsg5NS8dkp2qYyirfNH+BtzUH3oge0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.41])
	by sina.com (10.185.250.23) with ESMTP
	id 67C3100600001E76; Sat, 1 Mar 2025 21:47:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4989658913198
X-SMAIL-UIID: 9DFB72EE445947908EF935066F9C962C-20250301-214752-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in loop_set_status
Date: Sat,  1 Mar 2025 21:47:39 +0800
Message-ID: <20250301134743.2874-1-hdanton@sina.com>
In-Reply-To: <67c2deef.050a0220.dc10f.0164.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 01 Mar 2025 02:18:23 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    276f98efb64a Merge tag 'block-6.14-20250228' of git://git...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f2c864580000

#syz test

--- x/drivers/block/loop.c
+++ y/drivers/block/loop.c
@@ -1286,17 +1286,16 @@ loop_set_status(struct loop_device *lo,
 	lo->lo_flags &= ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
 	lo->lo_flags |= (info->lo_flags & LOOP_SET_STATUS_SETTABLE_FLAGS);
 
-	if (size_changed) {
-		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
-					   lo->lo_backing_file);
-		loop_set_size(lo, new_size);
-	}
-
 	/* update the direct I/O flag if lo_offset changed */
 	loop_update_dio(lo);
 
 out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
+	if (!err && size_changed) {
+		loff_t new_size = get_size(lo->lo_offset, lo->lo_sizelimit,
+					   lo->lo_backing_file);
+		loop_set_size(lo, new_size);
+	}
 	if (partscan)
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 out_unlock:
--

