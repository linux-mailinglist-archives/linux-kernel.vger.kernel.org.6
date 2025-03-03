Return-Path: <linux-kernel+bounces-541399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA8BA4BC8D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5251886598
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D561F30A8;
	Mon,  3 Mar 2025 10:39:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E81D7E4C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998370; cv=none; b=a6qD4pcx1QuLVf5xmEIcTQ0vJCi0H/qWzEtSR3pebye7BFrEzckCQMUjH89OyFy8YhJ7RnugMM4pMah0lNg3x1UU5Lob6F+DLemT+5ukdmz75hTsdsIo64sEoooFFs/VV3IjRL03ag4I3/IqyRXWaRdnjhD63vODS1Z61PmW0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998370; c=relaxed/simple;
	bh=5w6pA4eYiBnHNqpcmteMeSrZV2g2L1eyHkQ8+j6h8f4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dXP1ydEMyrD4mRoOe42tj/q/j4rUMpwRCxgVH7ePN9EnwWx5/IdyRhoKl3LgtOyF6vReBg3ekiHKQid7d3U87Fw0gZdhwQQbKPmM/MEWqUDP7SiTmkJKg3MVeq010fFqwy6cFF2TNX3548UMq6PZIa3vM16T6fSGE9JqzdpfrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85ae33109f8so34328839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740998368; x=1741603168;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94B1AldC1Ra+VOi32bZczZH6eYO+XQiGIIy01bId2WI=;
        b=V7wOBcRUBkjivfmCcg5LPCuO/xHGIMPKvMjypOrkrtEn/mC9OgKyqWYAu+FjIfmkQ5
         wF+bUENS2eT8kVqO1jWoxDFwpOThAdewzgklTBh2n6kmQhAhebaUfp/DnS6uymAeBfd0
         0msHx6D58mqd5EJPVxyKVCQCpaYrjE7OUwAtPLjSiCmoWG8fFUG00+vyoEDHurjC6IdY
         AlBNCMFTJqZsuWt8RoH5HZT+jK0zXBsMqpXgW1K7Ha4+ewdWLI4ruN1ODYEDC6QARMvn
         ma7kTrW6scWyC1Hb+fvZi7uRuDqRLcArxweO6qLwMihLFOYe+oqOGT4HDWwiY+tyd/4L
         LzXg==
X-Forwarded-Encrypted: i=1; AJvYcCWxxWqKPCDuULxJk4KOnXoeOclmuacyDvf9e6lVloIgwH2lamW9Kcz2oP+PbJabwPnDDZTzUI34wH+cXPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwe6C9XMNPU33L0eay22k1x+0rXBJUHvl4wYTQmr3i1hzljIOo
	5i3KQ+Y0QDiberm7/iFcmn9nDHmGd807zP/1gVHXyx47LlTH+7zQxoqHCtztXhcazFA0QLy3Ba/
	orx3dKhGluSeFi9fLISZo5pe+6fPZYp3amuPhxDqq9USsniGSx10oQ1M=
X-Google-Smtp-Source: AGHT+IHXGGfJycEVF1C0NA+tWbF57mYYWAfRa3uH7yonYPLILGd0Xs6oQjnQHhZiPUqQSby7mDcwV8F7CrVZ/77JAIhHK7ysIbjU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3111:b0:3d3:ff5c:287 with SMTP id
 e9e14a558f8ab-3d3ff5c06f9mr41959675ab.14.1740998368052; Mon, 03 Mar 2025
 02:39:28 -0800 (PST)
Date: Mon, 03 Mar 2025 02:39:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c586e0.050a0220.1dee4d.0124.GAE@google.com>
Subject: [syzbot] Monthly batman report (Mar 2025)
From: syzbot <syzbot+list0f38ff37debbbda9dc0b@syzkaller.appspotmail.com>
To: a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, 
	linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch, 
	netdev@vger.kernel.org, sven@narfation.org, sw@simonwunderlich.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello batman maintainers/developers,

This is a 31-day syzbot report for the batman subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/batman

During the period, 2 new issues were detected and 0 were fixed.
In total, 6 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 555     Yes   INFO: rcu detected stall in batadv_nc_worker (3)
                  https://syzkaller.appspot.com/bug?extid=69904c3b4a09e8fa2e1b
<2> 136     No    INFO: rcu detected stall in sys_recvmmsg (3)
                  https://syzkaller.appspot.com/bug?extid=b079dc0aa6e992859e7c
<3> 14      Yes   INFO: rcu detected stall in rescuer_thread
                  https://syzkaller.appspot.com/bug?extid=76e180c757e9d589a79d
<4> 1       Yes   INFO: rcu detected stall in batadv_bla_periodic_work (2)
                  https://syzkaller.appspot.com/bug?extid=fc38cf2d6e727d8415c7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

