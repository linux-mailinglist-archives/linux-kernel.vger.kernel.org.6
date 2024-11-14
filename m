Return-Path: <linux-kernel+bounces-408944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E316A9C8568
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A760228412D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCF21F757F;
	Thu, 14 Nov 2024 08:59:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9EF1EB9FD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731574765; cv=none; b=uF+YuPuNFes/1pHMBKGll5qiMPe5amF2B3RzbInm1jT9FUXFbiVwrJf+KoRdrJGayD3QvO7mZcnDO6eaE5XOABhCMWgWVIXAQf1BTuR+dxbVT6oIFl6J7d4ln1o7b1Iw8MH3Vj1qov5GUOvZwkyZO2QuyIaH3VkPdZdNruVNGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731574765; c=relaxed/simple;
	bh=gYDuRZ7ArX0jwUK07o3HSTIuBbTk2z7r5joz3LW3tCo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bmCjpnM0syi0CEYDm4e5H/HP1bfFthLPXg3472prZDWeMvKrrPdp/bQZ5JZEPfrGivOodNMK447nbsqktl1WdOlqoSTvFsDfH1DDmdaSRhRStXaykd5U1JAljXwWBJteH5Soos56R3EbiiJD3XJhTBYiMc0VvsxPYVopbEzmm0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a715ac91f6so4227365ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:59:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731574762; x=1732179562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zssj3quVVymKSXh7PyrXcZgz1qXWIQjEuhOq5pZc/Y=;
        b=walzYpYNWBtFFhTtG6ajRXx0H8h2UCEWW/xeU2qvTrNKhzNq/C9gQgbsgxpucU+omr
         /AeVsWBZo0ZqNvZ79RopcI0uRR4d8WWAU9XQTldD1j1qT07nuHHmB3rZnWWJ+SeXDJxB
         xcDWySmJdrqjdz78KM3uX2WFbMPNbf7hnoR+0XV3JGuLjXdom1TrmeI+z570PJeUCWQq
         RpZBNu0Y1Ed3Dmjs/ucAmh3ltU6sRylRFaf+Y2t79AHjWntbtrizNAsnk//N6OkZ2YDu
         4KtTneXdKh5Okwx0DkL1E/eXn1pUU5ut/Ci79vtlEHABCbX8R+W7GWeQD5hqMqjr+5ZQ
         ar8w==
X-Forwarded-Encrypted: i=1; AJvYcCWHQfG97zurUrASXreaUV6gJhkg+qc6bNMVeNmhYvuWLy/UM5y3l1J5v5gNRSv3OzmMH3h2C+pItWS3S2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YySp9d9evHAFPLpGiJiKlVo4/qwA5lvr3+N8Agn0eLYuCaKMzqb
	FlG5PsFODh8G4gWfkgwig1LV7kHReG6P8SSHzEZggjb2hnrQGnR+Wg4kNWqncqXPM98ygLVJhQN
	P4DVD+Jq+c/55GdAYWCsNa99jHTS3ae66umZponUxrseqNBttWGS9iok=
X-Google-Smtp-Source: AGHT+IGLqFcQ2N114zaO5uZSvOpK4WNf3i7F922a3Pi+SDIsMrogj0l6hi3tzJPiqLwa/hL2lYKh7nuceo3OEb2uWfJ7RLcqSm1V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154b:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a7156d7c91mr73999395ab.3.1731574762607; Thu, 14 Nov 2024
 00:59:22 -0800 (PST)
Date: Thu, 14 Nov 2024 00:59:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6735bbea.050a0220.2a2fcc.0065.GAE@google.com>
Subject: [syzbot] Monthly dri report (Nov 2024)
From: syzbot <syzbot+lista02f0bac45ff1b3f6031@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 0 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 31 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  841     Yes   WARNING in drm_syncobj_array_find
                   https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2>  318     Yes   WARNING in vkms_get_vblank_timestamp (2)
                   https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3>  68      Yes   WARNING in drm_mode_create_lease_ioctl
                   https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
<4>  62      No    INFO: task hung in drm_atomic_get_plane_state
                   https://syzkaller.appspot.com/bug?extid=eee643fdccb7c015b3a6
<5>  28      Yes   WARNING in drm_wait_one_vblank (2)
                   https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
<6>  18      Yes   WARNING in drm_gem_prime_fd_to_handle
                   https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<7>  12      Yes   divide error in drm_mode_vrefresh
                   https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
<8>  4       Yes   KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
                   https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b
<9>  4       Yes   WARNING in drm_gem_object_handle_put_unlocked
                   https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb
<10> 3       Yes   WARNING in drm_prime_fd_to_handle_ioctl
                   https://syzkaller.appspot.com/bug?extid=0da81ccba2345eeb7f48

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

