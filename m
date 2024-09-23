Return-Path: <linux-kernel+bounces-335615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEDB97E815
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0CEB21EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D92D19415E;
	Mon, 23 Sep 2024 09:03:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC24194120
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082205; cv=none; b=Hrn2X1l03fQx4TOWXCrVEzt3VkrSA+nIYezj3H7uIZoDS1t430/MhsO3mwHsQAeWsfS5Q54Lu7OdTy55Q+EwlBJR6Qix8vDFhO6J1if/y4izr1U0I7coJP1pD3d7kGOqcFk8FkAodZclw2Az23urAeWWGPp/A3SAS3oaZKFEKpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082205; c=relaxed/simple;
	bh=xn9P+BXue5kA2yv7kYUdvO+JxKsacy9SXOwPhCle9xw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NzaKSN/hknBIMWgUZK54AoLIVFkmiqgZhBeiZI7TiDc4kFYJ2ji0LAWbi5uvLi5gz/uLRKdf9JlyDTgEhEbOAP2vUCcp0oGEs1lwJlpmgDGRZwGiqw2QhD4LgSY0TufahDDRQcP7DJb3H+UNAqTxzaHeaUV5uzqKX7IITY3m1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f4e119c57so39876305ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 02:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082203; x=1727687003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pGPXvPWs6tQjlbmfR8dIzPo3akjS+xpC3EdLlvl8Ts=;
        b=nY0oSENeurYttFvTTnIoy6kOcJ93fRdze6WesUssjaGmJ6hvetos2i+OFkiNVYqnFn
         7jvVasp1LXan4bzJhWP0iYuXptLITKcoQt6ZeGtQMPdvuBGB1vwXpARUD4AoFt3aZJC7
         acvtEjMOhZaeLr7hku4t/96YjW8HyBNajDw1A5+9c19yfLc94V22fgJ3V5mUWmUu61pE
         fOx1eNg0DAqSJCBfquJud0+RH+ar9kCYWZ1xLEHwMuhj3knXN1rWiGVsffdhQkFlPpl5
         tIClbuxDkL+lcr9ePIeZOygVsbcaa2MqESAyr9T3Umznz6XnQOp9buHINq44qE1ofR2w
         R3EA==
X-Forwarded-Encrypted: i=1; AJvYcCXxO2qXCrBLfUTQGj4+g9cTHM5ajRXeubcR6NJSXDTX/QE+dX1o5A9/bts2aspPJKVQjWPzWslg2apuV2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoDmF36/vLp5WxfTo1F1htkiYpA7VhlEZUqJrhb2bWhMOaU9k4
	3YiJqRI+hfHshofZ/I35Qy8WsQiq0ZSOVoVlHASyWNoYdQQmzSvScIxLjAFh3w6WZimqSJvHTO0
	Dn2+9S+dFrAkNky3p4t/sAUqCp1nfNymZh0358C+zRTnugNnIAhojfqw=
X-Google-Smtp-Source: AGHT+IECaPxN1xbHfV+FltzIPfEbCo8R0YKJnUkDUgat5BMBOqC/clTy/55btm0hrM72+kRpxBBVV7nPqiz/yev/78YYUPDZPUeW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0a:b0:3a0:9050:702a with SMTP id
 e9e14a558f8ab-3a0c8d091b9mr93008285ab.17.1727082202782; Mon, 23 Sep 2024
 02:03:22 -0700 (PDT)
Date: Mon, 23 Sep 2024 02:03:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f12eda.050a0220.c23dd.000d.GAE@google.com>
Subject: [syzbot] Monthly ocfs2 report (Sep 2024)
From: syzbot <syzbot+list211859bdf2f8ebff42fb@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ocfs2 maintainers/developers,

This is a 31-day syzbot report for the ocfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ocfs2

During the period, 17 new issues were detected and 2 were fixed.
In total, 32 issues are still open and 3 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  5169    Yes   possible deadlock in ocfs2_try_remove_refcount_tree
                   https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b
<2>  679     Yes   possible deadlock in ocfs2_reserve_suballoc_bits
                   https://syzkaller.appspot.com/bug?extid=5d516fba7bc3c966c9a9
<3>  379     Yes   general protection fault in ocfs2_prepare_dir_for_insert
                   https://syzkaller.appspot.com/bug?extid=5a64828fcc4c2ad9b04f
<4>  312     Yes   possible deadlock in ocfs2_setattr
                   https://syzkaller.appspot.com/bug?extid=d78497256d53041ee229
<5>  278     Yes   possible deadlock in ocfs2_init_acl
                   https://syzkaller.appspot.com/bug?extid=4007ab5229e732466d9f
<6>  44      Yes   kernel BUG in ocfs2_iget
                   https://syzkaller.appspot.com/bug?extid=5bdd4953bc58c8fbd6eb
<7>  34      No    possible deadlock in ocfs2_fiemap
                   https://syzkaller.appspot.com/bug?extid=ca440b457d21568f8021
<8>  24      No    possible deadlock in ocfs2_xattr_set
                   https://syzkaller.appspot.com/bug?extid=ba9a789bd1f4d21fcefe
<9>  18      Yes   kernel BUG in ocfs2_set_new_buffer_uptodate
                   https://syzkaller.appspot.com/bug?extid=453873f1588c2d75b447
<10> 14      Yes   kernel BUG in ocfs2_claim_suballoc_bits
                   https://syzkaller.appspot.com/bug?extid=96d38c6e1655c1420a72

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

