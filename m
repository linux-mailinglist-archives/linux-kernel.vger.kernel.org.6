Return-Path: <linux-kernel+bounces-524565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71735A3E4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6DC17610C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821612638B4;
	Thu, 20 Feb 2025 19:03:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587DA2139CE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078206; cv=none; b=h4jaywxMXfobYyeLUbWHua7SnFFah7+Amz3VkZIAjD6fLB607jIv59X0TwHOsut6TkKPeG6tVCuw2EnK0unTzbuJ5AuPtQaJZPL5GpFueix5f9n1U3Xd/H0z6iHf2c4TlJdBcWxYH4dARKdVI2uH9mxakhmXX5jaYn2jQ2uGNr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078206; c=relaxed/simple;
	bh=lQjy5Tbt7SOKgHum3uUoO2fOLJDZZlD6bMZGv7JUG2o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=t1jviKMlAJBrDlYUgZ3lH071EDgWUpePITucOrhCbv5B6G7XhNl0KMbTXiWLYs/r7P7qfWTJl4a3ZhmWRJY52p3FbyN8Vl/0p2MURQyYpkoYUt0HFxTFzB9+aEv4VHnnGQhIfAcYMrPn9xeJippcXM3PLpiAdNGTkqL9zXrQUL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2b6d933baso27638845ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740078203; x=1740683003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHPONpBhaL8KVkMvvXywPynT8Hy32yQffO5v7e4WWk4=;
        b=fowPVuChY/OC/Vl8nj72apBDmfpIYOBE7e8bE1X6D3g6toIMnXvb77xhDKdYzL89+T
         cItr8jCo0CwHL2e+1Xu99JcehSgwR9Jf9NiCikRJP8h/3H20Cc36Gy35VBGs27VSy7iu
         mWmVuycWz8D1Q+R0oC7AmlfcS5R4Eq8XE3UQwlBKzJgKOtcCafa+8j1cEwTIhoFC36zS
         E8kqrs1ggiC9OH9Crc1bzJgVF+v4wJ4GVutc6Io1Pz28zCbWEvsOnZH3fyT9VG++YzHy
         OJuOvDGyzcF63LcYD0gw7N/ZTIAEQ+V+VqmyTI6oGwVSELKt6U+Da9x2o5h1s8qptLoq
         kBsA==
X-Forwarded-Encrypted: i=1; AJvYcCUwsjE1DYLAK2r6297h3IwMOlzHT3YASg+6/dyucro+E0VLOBVFt55iVvoMh2nQH910a5OoIwPfjP+dtgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrTOksOa4ZH6Jmr5AJHhX2tJXOODMBl07WJeSIKPKcS9Ci8Ek8
	6NRk6Z+yuHFTyfb6FnVrUuS6owjVv+K1ydlvEyWI/8c9ckbyjZzNsjX+r+Kfy6ryKv4xjuDh5Uh
	WucKQOt0lM5Uuh+wcQBUQgbw8Fwtqhoe3RVKadblVyv+zI15PBpjc184=
X-Google-Smtp-Source: AGHT+IFbeB0rKTkfnKixOR1ULdMQGD+e+nLetXnqw/agrnFULWn8S5n3wmktH/6G2fxeWduuFbPVi7GW8Ihc//NVyD8BAsxI/4cN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:310c:b0:3d0:4bce:cfa8 with SMTP id
 e9e14a558f8ab-3d2cae4cefemr2978485ab.3.1740078203645; Thu, 20 Feb 2025
 11:03:23 -0800 (PST)
Date: Thu, 20 Feb 2025 11:03:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b77c7b.050a0220.14d86d.02f6.GAE@google.com>
Subject: [syzbot] Monthly bpf report (Feb 2025)
From: syzbot <syzbot+list291bd82fd4f9cf97dab3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bpf maintainers/developers,

This is a 31-day syzbot report for the bpf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bpf

During the period, 0 new issues were detected and 0 were fixed.
In total, 32 issues are still open and 280 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  21436   Yes   possible deadlock in trie_delete_elem
                   https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
<2>  2116    Yes   WARNING in bpf_map_lookup_percpu_elem
                   https://syzkaller.appspot.com/bug?extid=dce5aae19ae4d6399986
<3>  1993    Yes   possible deadlock in __bpf_ringbuf_reserve
                   https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
<4>  232     Yes   INFO: rcu detected stall in sys_clone (8)
                   https://syzkaller.appspot.com/bug?extid=c4c6c3dc10cc96bcf723
<5>  177     Yes   possible deadlock in __queue_map_get
                   https://syzkaller.appspot.com/bug?extid=8bdfc2c53fb2b63e1871
<6>  71      Yes   possible deadlock in queue_stack_map_push_elem
                   https://syzkaller.appspot.com/bug?extid=252bc5c744d0bba917e1
<7>  52      Yes   possible deadlock in __stack_map_get
                   https://syzkaller.appspot.com/bug?extid=dddd99ae26c656485d89
<8>  32      Yes   INFO: rcu detected stall in sys_unshare (9)
                   https://syzkaller.appspot.com/bug?extid=872bccd9a68c6ba47718
<9>  23      Yes   BUG: MAX_STACK_TRACE_ENTRIES too low! (4)
                   https://syzkaller.appspot.com/bug?extid=c6c4861455fdd207f160
<10> 16      Yes   INFO: rcu detected stall in task_numa_work (2)
                   https://syzkaller.appspot.com/bug?extid=06d48cbf3e767907cec2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

