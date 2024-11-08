Return-Path: <linux-kernel+bounces-402457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E79C27CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8E21C2171A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 22:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262631E22FB;
	Fri,  8 Nov 2024 22:52:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2818DF86
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731106328; cv=none; b=D2/Us3HqI8ehsRoO8SlSD0ZslPbqH82UR5uoTAgE2jLDwLU3X/S61RZUgCcKD3jZvg30L4UrnmV7/MRSptiDh4KWgKDh9iSS19FWnYd51eY5Sx/6UvAZCvTGahzOOMBpt2oXvGh3EyHAuWgRSBf+CijYi9PnoV7dB1Ptv2xMxAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731106328; c=relaxed/simple;
	bh=gXuLGF578FK4RZlFtxXap1q1f9VhDLzruBlXgif8FQ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SG/sRfrMbAuU1Kbif+r4t8hZ+nAlzRVcMR8+FJqeV6ZIGqbEz0dHrvAf+EC9akXu2+uZrtyFsLi1WxRujiKIoz1YRq9Qoc+Z3+/OdP4cBiuyiZuGJrmqF/IZlKO1zfG9vkU2Y8b0hlTqyPBpB6HcJDm60xhviCW7jImtBEyv6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b37c6dd4so27861395ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 14:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731106326; x=1731711126;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIxqD+aLEH51VZN4dZGxv/q7c0bPHrWNxFiPAB9YqpQ=;
        b=NV37Up5cEoDTzMvVuwbyGi5HbTGlytx03wpD+bm5tG3CoNbttSpuL5G/1Ir0kpz/dr
         a54GuO7l5HXIEIChRBnQMtJICtUO8oTzywPvXhacqTUtnpfPH00+u2+G6QLnnXQDcv1g
         JpclefRrNRtHUWq89OBOtgVDTgyhf7mKSEf2ii+5CjM48jvVkLKA65XVG1h5Vxn9/xf7
         Hg5c8M+vKK36qhwxNpihdTONIHLXzWQCxRc/SkvKCCTb9esVE1Jhs8CSDuJ1PgRw5sgk
         fL/CL6ReHsrtyKJPbdjthW469LDlUMlDGgA3Fo+tJDONux6ubi2nGkYmBAbOgc4hzmxo
         TVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFBrQ1rlLHy5pbCiNKoSDWqAFzL5pnD3XofZU7H9pqcfeFl9Zr/5ediMQXm08Ob7eMk1J4zlEHT9fHMEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDc4VSK7+WvQtrajljzSoYXhqdwXD7tTUKE2RhRQJIevXrlmV2
	2x0Hzx2T/BOyXNJ7Hj3IfPXEnznTonW8s3n2FyM139s93XdkIXgpr6dkLX2HDtYQXvylpOmMLmY
	boVxZtJBMEVs26xUTdzpz7nYJTWz8sQP1NPCvAGa4XKfzJBgGENjrWlM=
X-Google-Smtp-Source: AGHT+IHYLwe/jDyb+uvjyVbo2F1hg9+ZmWROr3ediAD7vJOcWA0mv5EcUjS01nO6RSDEi6GiY7/7geX5jGYVVDzYIXxXk6JH4klM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0a:b0:3a5:e3bc:c1bf with SMTP id
 e9e14a558f8ab-3a6f1a592f1mr54177235ab.23.1731106326139; Fri, 08 Nov 2024
 14:52:06 -0800 (PST)
Date: Fri, 08 Nov 2024 14:52:06 -0800
In-Reply-To: <66e9830e.050a0220.115905.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672e9616.050a0220.138bd5.0034.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] INFO: trying to register non-static key in ocfs2_dlm_shutdown
From: syzbot <syzbot+d7935821694d430624ea@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	ocfs2-devel@oss.oracle.com, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org, vvidic@valentin-vidic.from.hr
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit da5e7c87827e8caa6a1eeec6d95dcf74ab592a01
Author: Valentin Vidic <vvidic@valentin-vidic.from.hr>
Date:   Fri Nov 5 20:34:49 2021 +0000

    ocfs2: cleanup journal init and shutdown

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=128b2ea7980000
start commit:   c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=118b2ea7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=168b2ea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=d7935821694d430624ea
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1445ab40580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1200e987980000

Reported-by: syzbot+d7935821694d430624ea@syzkaller.appspotmail.com
Fixes: da5e7c87827e ("ocfs2: cleanup journal init and shutdown")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

