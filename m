Return-Path: <linux-kernel+bounces-394126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA319BAAD3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDE81C20952
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F216C695;
	Mon,  4 Nov 2024 02:29:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156A5661
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687346; cv=none; b=GLYuA2f1tPMdQYPYLXC5xqK4uO1HT7Z+MvQxeo2O17KQIbrzbEaahKux18KZhXPQIkR2hq/aq4V++QZVAoFDEx6wkjH97UxkYrXcxO/n/648xBdR2t0s0dkem0vn80KzDA6ssk9NbEHxZpL5LVItSobn5fxZjUddn0IIWNkizJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687346; c=relaxed/simple;
	bh=gNwFf6iiaIorcTcYBVfjA8vphuKqxAih7Jktl7OYBPw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RG1DQfy4BtCadHw1WX2WyQIMxDB7mmdAWw7K5rB5lFrIa9JjHW6qn1Pkdc666BL6VHByqv1L1joYd9oNHKCxl9vSZS/5jK8q6D31nGfDpCvJM0+QzUW9hsVvrLAd7NUlx7pezBq2E0D04bayTKHnDo6/2hW6pYbduxc0o1DP5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso48331155ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 18:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730687344; x=1731292144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0kIJcY+bZlhPtz14UFFslZ5AL1aCNsQ2X/ataYQ5n/Y=;
        b=XdRrkQp/mzU4AIX/ytwS+5THk9fz05p6Vgupo12ZwUXuaiegScir8HRsyTXb2KwRaD
         tbuEcBqqtHZY8SE6tMEvKMofLmbHkeWJSJ0tKkZzF1PmSugk0KDgAy7ykMJr0BsmUPn1
         qxYBqnPSZC5OEXXfXCjLbTLI90CgA8CbZ8eJTNRq2wiJp5aJRzpkJvXSZ0vOh3vXd+K1
         zyq9QnlGoT3gnAAZVGLfnMs8w/A3+Xk8CVuviuMrfD8/Ez09gao79SHP+z/bnI1i8U3Z
         qzxaoYG04s4zfE/0/2+3QH+ku13z0RuP7dOu5j+la9XMaSWBmWC2XvaVV8VRI0DBokY2
         zP+g==
X-Forwarded-Encrypted: i=1; AJvYcCVq9BbWOYd45XjOQLmnW5Lt4DdkkgIkeL02DK4B/N+V5LX4PIDnBCzG56PXyDQxR1zTMqgIwMWSFVTjyso=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUm7gFPUuz9ZKKjnq17cp7CJYYS5b9nOR36OW4PNta8gSIGhu
	RR2VBQ2lIu4/QulIpEotUrB8wjDnrCr1ocxXZ35wK14nI35HXcZM/0LAseqDuWN7qwFU6WURvbC
	Shv8GlmpvqK4FF2NvD2WMsHJVF8gHzDskqbT42O6McGlCjyudZEJOn48=
X-Google-Smtp-Source: AGHT+IFgG5tFqR3kE+12iet3a5ZIvV3jfp0ny9MNGbZg0Bp3oS/ZBaSHALXZj3g22FqKLLRYvMLq0hJieO8KAgf6NiwA7GqKqrfq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:dd06:0:b0:3a6:ac17:13e0 with SMTP id
 e9e14a558f8ab-3a6ac171705mr93992295ab.14.1730687344309; Sun, 03 Nov 2024
 18:29:04 -0800 (PST)
Date: Sun, 03 Nov 2024 18:29:04 -0800
In-Reply-To: <67251dc5.050a0220.529b6.015c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67283170.050a0220.3c8d68.0ad6.GAE@google.com>
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
From: syzbot <syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de, 
	boqun.feng@gmail.com, bpf@vger.kernel.org, daniel@iogearbox.net, 
	eadavis@qq.com, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, longman@redhat.com, martin.lau@linux.dev, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 560af5dc839eef08a273908f390cfefefb82aa04
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed Oct 9 15:45:03 2024 +0000

    lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122a4740580000
start commit:   f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=112a4740580000
console output: https://syzkaller.appspot.com/x/log.txt?x=162a4740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=d2adb332fe371b0595e3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174432a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ffe55f980000

Reported-by: syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com
Fixes: 560af5dc839e ("lockdep: Enable PROVE_RAW_LOCK_NESTING with PROVE_LOCKING.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

