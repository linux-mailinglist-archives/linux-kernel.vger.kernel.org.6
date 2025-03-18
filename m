Return-Path: <linux-kernel+bounces-566356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11424A676CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E407A07E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6520E016;
	Tue, 18 Mar 2025 14:49:39 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340002F30
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309378; cv=none; b=sX9YHZznIZ5HjC/mb0CLZMsmcw7HiJZIrqPTzkGAoBacGlFwCj/6tUpatrX0yHsDFqGqvJEYhxGRBFdMYXgyZfl4tdxCtp2wSHsE4trTafdDcXt+P31zXyO0+IiSbDTu1tT3Yo08QcdBPwU8fYL3T+Ypt8GgXkDL1xgoVM9xMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309378; c=relaxed/simple;
	bh=uogqIgTw/zsOH8C9f4XS92uimFHXBGr+4iWRq4Y+39U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B6Co7PS8YVuvlU0u2nGrQHos2mJJ9fMiV5COm3Tn+ekGYn1j2mS4K0WvpaDbKMLQAyUylfZT3VPxzsOuPKCX0Yz+NPlJbsKtAyDXuHIRStjCsLBI3iexeF/KCTXUUeuXqugic7taH6unsTbEsXligg5dF/zk9IYbBmgsHrtNvNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d438be189bso64217705ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309376; x=1742914176;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owns3MQx8OMxQ042xxfJ8G7cCdorT/TwzY8tU9cVcAM=;
        b=a39tfegaBvRnXzkExySIsIPVGQagFtpSui1h0zLpVnPUllKKtBuZvJhCUKs4TEZ7mf
         NX0ZF8W07ZWCnPNEWGrILQaL8hC+Ce5Yb20ejL8bAEHnL1HLUD2LOEOA9Wn/iYmBLD/T
         zE6NsjZQdmfQPWv1ZOaIEDYZ/0zDa5ZF4f88qPJfXM1jEbaAgw199fJB2hG5rq8fl6WM
         seNc/XTw9aO2F0XhCNDsLruPKgLxFqZSJtSlwAebmTQZuKMt4VBai07LHfEeLp2o4B9Y
         9V976UwODtUvqiXnyKJQ7Go3SPtAGHVe2MoOXfF56W4VlDz5U4IbXvt9B1ff6R2b6Ybj
         4QWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdspOwNgOIYFS3BUpAFjD19x3lt4wSzuMyHq4YO/3ZoT3jxy+egmw5kMp+5liPqRkv2SyXWAnmAI+ZNmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlh6/sSfygCvkqN5puTTm72wPQ8KrKCwWxU1mICC2u4Fp/HN7g
	0h+xlo1dZo1YJlf94oHudRWUEGBaWKB3SsrMvcOKL3NOxeC999t53H6M0oOMDDK5C8hGCQAfpoa
	Kaibsx8HaJUv2lWn4h+4XvG9/cwLOJSBje+PoXPeM5PcTn5crw3J8uCs=
X-Google-Smtp-Source: AGHT+IGK6QUJ36AlLNe6pV+Q9uEN6DQ3URrTDAjooDK9umxQn2Xz+fhzj3RR39gTkV4lwzHB2t9HwBr4KAfn/JJ8HqvI+A5gbwxf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3686:b0:3d4:3ac3:4ca2 with SMTP id
 e9e14a558f8ab-3d57ba0ed3fmr43303085ab.16.1742309376265; Tue, 18 Mar 2025
 07:49:36 -0700 (PDT)
Date: Tue, 18 Mar 2025 07:49:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d98800.050a0220.2ca2c6.0189.GAE@google.com>
Subject: [syzbot] Monthly dri report (Mar 2025)
From: syzbot <syzbot+list7c58dce58b182e36cb31@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 0 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 32 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 383     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<2> 73      Yes   WARNING in drm_wait_one_vblank (2)
                  https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
<3> 72      Yes   WARNING in drm_mode_create_lease_ioctl
                  https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
<4> 71      No    INFO: task hung in drm_atomic_get_plane_state
                  https://syzkaller.appspot.com/bug?extid=eee643fdccb7c015b3a6
<5> 4       Yes   WARNING in drm_gem_object_handle_put_unlocked
                  https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb
<6> 4       Yes   WARNING in drm_prime_destroy_file_private (2)
                  https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
<7> 3       Yes   WARNING in drm_prime_fd_to_handle_ioctl
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

