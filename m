Return-Path: <linux-kernel+bounces-326700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B312C976BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3AC2841F7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810521B983B;
	Thu, 12 Sep 2024 14:24:32 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA851AD271
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151072; cv=none; b=GEERyRfZbRGjHL9lkyMiAm9hIcuOExrUNL4wEMDhyMLf+8LySLIS62c7uvfH5TP4+FNWWBiifzrm2ik/KFmBIAxMIOMAvDhM2Z+afYixtWNHJ+Pa4xY9kfQP5uaHjmApN5BM7cCczei3OFiOlVn63wULnCMRKfd8BzM0wqyrOHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151072; c=relaxed/simple;
	bh=HmoVO7AWw8iifs7zg6YjDbVicGl5IFM0P/C7b1+2A3I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qn5iPu4njFdc8SPLfUW4mRKVkX9Dmp7rRn96g/D5LFSyj1RSt2uZQ9U9eSDq93SRSAmaicI4SFEjq51ifK8ZoaPHTj2a14SbWkIxBDripDX70B/5Y8XkjFlqEU3+5tZIyyY+rolpVeRqer6B/47oDzS7jNJQTHn+Eb7LPErYvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0570aa7b5so14986455ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151069; x=1726755869;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OuQKzZLpf5NGkYThLq5i18wfitTNOX4EEkZm7JE9LoA=;
        b=il5ugdNC82tljJwoNDHnCLMGur3G5gkzRLFgfqR+KhNOjfe/Ma27lCdHM3TOnAJ87L
         xb4Z0/1YjskHz2saMxrYZAkDm9gZFi0pXtlisSrz44fjgB1ElXa1O/HkTvW4k1L/dlXi
         ZztkYkXpfYLa6NrHavK/MxuUtpkfsxHmjKEyMxwdMXupg4Uv3M9Lqjq/wKSb1fy5UpEN
         ydoA9FhoXk9mYJHqXOvPQgA1mfmNsLt4zmt9CmCbilO1fyYlfqMcQatMKD6m5iMPJUz+
         cPT2WUqN6TbOU73a6EEA9FkkzYs6jBHiS5qc/K/6sJly0tI10W+iAsnESZUDNUeiIU3M
         nr8g==
X-Forwarded-Encrypted: i=1; AJvYcCWTGqde4mwvHu0uLYlxRDbtRJVinwtzAH5Wxud8JzaeRx5sFHOxbvC/1YwRN+uCXoljIAzGFy0pocUHItc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqfBE3p1TAkNXZw3WELvbN8BFT3Bp2sMF+OY4R2H302xsGplFR
	OqfEhAqEAPlHuBXK0FzYLsv00jfR89L6A6IvO+KosCyZdHqg7eRm032YneVlbDuq4s02kG4uKsa
	TAWmh44hbqJz1nxrYz6JCU8+Hxol352fv4Ve3MC/ptQhwD0jUa7Xg0wI=
X-Google-Smtp-Source: AGHT+IGtAMEBFXov4olRqQ8fx0hqnNccYpwhxRwwRoVYQbK8zJ1FGNMi9MrcukcWzJrCWidjuVJzWAd4yDB3IDF5mxgQhB5kVjSX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a68:b0:39f:5557:857f with SMTP id
 e9e14a558f8ab-3a084900bc8mr31537715ab.6.1726151068912; Thu, 12 Sep 2024
 07:24:28 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:24:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004acdbb0621ecdd59@google.com>
Subject: [syzbot] Monthly dri report (Sep 2024)
From: syzbot <syzbot+list2bf3238f8b427087cb3d@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 0 new issues were detected and 0 were fixed.
In total, 18 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 569     Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 292     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3> 66      Yes   WARNING in drm_mode_create_lease_ioctl
                  https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
<4> 17      Yes   WARNING in drm_gem_prime_fd_to_handle
                  https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<5> 11      Yes   divide error in drm_mode_vrefresh
                  https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
<6> 8       No    WARNING in drm_wait_one_vblank (2)
                  https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
<7> 4       Yes   WARNING in drm_gem_object_handle_put_unlocked
                  https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb
<8> 4       Yes   divide error in drm_mode_debug_printmodeline
                  https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

