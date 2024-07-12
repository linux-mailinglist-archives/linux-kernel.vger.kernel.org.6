Return-Path: <linux-kernel+bounces-250506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF3192F8A9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98F0FB2191D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253E158DC1;
	Fri, 12 Jul 2024 10:05:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95677156F53
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778723; cv=none; b=PESLCfgjzl49JRESWubW5EJvHVP0KLWvr/LpIJjRyVujp62wROWNRqR+GMfUpPYjeTivjLkjtYSplrNwRfblLP3pl7QHHnJ/5e5L2lrY2bXQuhGDp46jrnqORTwJfkx+FYn9hVEOa8csrFS1fejmyHxxeEc/FelCKIHa8G7TdCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778723; c=relaxed/simple;
	bh=8n//yCu3buR4+e1lv5PjDX0ysI+RLwDYqkS84oE1H/E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ekAu4lInImmpCRsmfvlmROdOIr+LHprWR/xZWvfOBeiLfV1OG0ShwW/3ZMLdAUwgfaIIG400PDMBx+3qvb+rxX1Jzc5or64bNu3eUQvs4FNq7k1hOdHDRcfK1grx8jnYxiF5swY4xhOT7VFUB/xQ6DLxX6GAXI6x6jEi9D+secY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f12ee1959cso207856939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720778720; x=1721383520;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0uHsZOblIlCto3szinYzdnH/4DK64wZXbj0uuuOWfuI=;
        b=EWhJ2kJSZ5cUw9C121Ae0oywbDA46AH904h2heTwvPprwkokFcLEIwEgVe8G6q+MXo
         yDxX4Rhymi9qIOPOdbCN2OjQAvqF4iheBFzNumLjA2xf1vg6gXm46ix6cS8pMf/PNi7D
         jjQVgBd6oEc8CYyO54z24aLFMmEAEv9BaILCXA0kPUm66ccwTXqR/lexJ1pRnpXOM5hn
         ghSVFbN3bkjy943Fau1xgydpBKqRWvnRb7kEhjtmh/7ooHnJ4wGE1JkDBkmNG9y6IXHF
         f9o68Mewjh3FcijdEORhqpe7RegiyFU4NDVCRTnx4AkhFqDsOtW1g1M208OOJeK0v7zY
         AbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtMeqPbLYXS+EMx1AGPHeSIybhXcXBeNJhvlcvvoiyQV30FivUc+GoLYMmDMxNM7WrdEHvHx+8IxfasoKAIaEcXiSdoujqAMg8YAT3
X-Gm-Message-State: AOJu0YzJLAp8+91WfPKgLos7xLCyyoIFM+9qN2VI7r4gc3+ObSLvHK7i
	ZujfSgtkSVGq2H9eEEt73L79PVOQAvhPcZyiBklxBTBJynZdKVFAt9DXNLdv75LgwShkBQz+JV5
	/LmuEOMMwuKET1cC/0iIiRLa/Mb5Cn401aooXzTaO8jcHRoDy2jNwRcY=
X-Google-Smtp-Source: AGHT+IEJllwVtrrFwnlf4BoFNXUnBWp3r4bVSoixFZy6CM+73QhjZ8xzls6n+RjZvrZx5GGA3gEPZlVcxvmnm2yuvSaIGcaFxOCV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:840f:b0:4c0:9a05:44d0 with SMTP id
 8926c6da1cb9f-4c0b2869dd6mr809708173.1.1720778720634; Fri, 12 Jul 2024
 03:05:20 -0700 (PDT)
Date: Fri, 12 Jul 2024 03:05:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000617cd8061d0a0448@google.com>
Subject: [syzbot] Monthly dri report (Jul 2024)
From: syzbot <syzbot+list557ff60c2cbd295a5cc0@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 3 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 468     Yes   WARNING in drm_syncobj_array_find
                  https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2> 278     Yes   WARNING in vkms_get_vblank_timestamp (2)
                  https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
<3> 38      Yes   WARNING in drm_mode_create_lease_ioctl
                  https://syzkaller.appspot.com/bug?extid=6754751ad05524dae739
<4> 17      Yes   WARNING in drm_gem_prime_fd_to_handle
                  https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<5> 13      No    WARNING in drm_atomic_helper_wait_for_vblanks (3)
                  https://syzkaller.appspot.com/bug?extid=0ac28002caff799b9e57
<6> 10      Yes   divide error in drm_mode_vrefresh
                  https://syzkaller.appspot.com/bug?extid=622bba18029bcde672e1
<7> 4       Yes   WARNING in drm_gem_object_handle_put_unlocked
                  https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb
<8> 4       Yes   divide error in drm_mode_debug_printmodeline
                  https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574
<9> 2       Yes   WARNING in drm_prime_destroy_file_private (2)
                  https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

