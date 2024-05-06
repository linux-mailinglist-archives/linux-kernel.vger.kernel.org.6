Return-Path: <linux-kernel+bounces-169876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7AB8BCECF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472E3B25600
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45978C61;
	Mon,  6 May 2024 13:18:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99446CDD0
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001515; cv=none; b=IMDew/qho+MtgAGl+ybWIco4hxuPA4DN+7aYBbH3KZDOW5YZChZLSt6LhV+fBYXa84hRyT6QuuGt+TTGQlgGaQ56TVP4xm6LlZcACThz5UoC4MXov22OqbsTWjs4TrTWunT01S3MV3nnQuE3tPaQLSj+Pp3g7nywJUxvy5BpYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001515; c=relaxed/simple;
	bh=+TUC9SWXsyjSANIJhcOwf2k55ubxw4wlvbJuCPBnSHo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TqinPi0Mz6/uye7JeF6fjZTZRYMzqYh+3iiMSeqkPvIhfmN5nBhO89/wfz0YSryKJfyimhfWWKnsjJ6CojqPcJ29XMgIHecEzon5n+cyjANSYMVzc9XON8KC5rh6OJ51s/kJlIhDExycPdGqzQr11WszmDVAiMOEmQlHAYG+oIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c5d1c48d3so19098475ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 06:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715001513; x=1715606313;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7c7YmJFMZ55fSg7XNpDcD9Os2ihwoVxri7SE7ViUc0=;
        b=e11SJk74yZ74hb4hdPiYSJ/UClg+1j5r399mhfphssBJsA6rCCpVuYF0B5JhLTqWq2
         8McDfSamUMMTGTPigMtw+4C2zYg5BoTdPUX/51MtuxfSMc5lrok3NbGyaXxJK2MgRzLD
         6wHjR7hpjD/3W5Ki3kkJea8gMuiqPxMiCEcMe0S9eJGGarSWw4Q7ea99gTwW5HZ9rF+I
         X0u5F4KdfL65CNM+ARj3cpdcfbQirPwN3vMjauz9hn0rWBJVlvTpRBv5U9RbLOaBvUvT
         3wcnAVM889+yTJl2aCn/N0mPTjoY+08UCcej2huYpFwV6bOytR60KFdSqfHWe2O1rw1u
         Yeew==
X-Forwarded-Encrypted: i=1; AJvYcCU5LQSlg5VFxdiOCUQLpdyiXotRQhfLGxfj/cp+g2/gc480lWwAi/eOBK7Fq0/8Lq9EFvjl8Sola+gyS61ga610PbkQZ0vh6f8ZXplq
X-Gm-Message-State: AOJu0YyR8wbMeIwSolPo9SYIkcXDFyVnG2aVbz0B3mkBYS6ljPE4EK5N
	0lO1mgcGOciS540bbJqT23rUf2z13ovln8hed62B7k7ZbwAAQ8qXmIw3jyxE0T9CfUQfwrIWa6w
	jOxc37JQA/4F8E6VAL4aS4EXb1KptKpsC+W2ooaNWGIX5IOeH/UHsOD0=
X-Google-Smtp-Source: AGHT+IE1Ro9qu+2Njle1sjA2cJLVkJudsME18R61IwZ4lgFiIPj0JN7vrupYRV9kn5vdZdLi2EpYYZaR3ePIt830GsucvgQq9ZeE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c268:0:b0:36c:4c63:9c93 with SMTP id
 h8-20020a92c268000000b0036c4c639c93mr403952ild.3.1715001512900; Mon, 06 May
 2024 06:18:32 -0700 (PDT)
Date: Mon, 06 May 2024 06:18:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f748120617c8e723@google.com>
Subject: [syzbot] Monthly dri report (May 2024)
From: syzbot <syzbot+list81f184520f9f481c9488@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 0 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 460     Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 258     Yes   inconsistent lock state in sync_timeline_debug_remove
                  https://syzkaller.appspot.com/bug?extid=7dcd254b8987a29f6450
<3> 253     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<4> 206     Yes   inconsistent lock state in sync_info_debugfs_show
                  https://syzkaller.appspot.com/bug?extid=007bfe0f3330f6e1e7d1
<5> 24      Yes   kernel BUG in vmf_insert_pfn_prot (2)
                  https://syzkaller.appspot.com/bug?extid=398e17b61dab22cc56bc
<6> 16      Yes   WARNING in drm_gem_prime_fd_to_handle
                  https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<7> 9       Yes   divide error in drm_mode_vrefresh
                  https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
<8> 4       Yes   WARNING in drm_gem_object_handle_put_unlocked
                  https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb
<9> 4       Yes   divide error in drm_mode_debug_printmodeline
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

