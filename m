Return-Path: <linux-kernel+bounces-192497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EC38D1E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E180FB2150D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AE416F84D;
	Tue, 28 May 2024 14:10:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F046116F836
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905406; cv=none; b=lB0j60uhwK6Z5kRoDRY5lo3QGQMWyS4WJwwXHlL99sHeyvqSV/k5zkzQyae/yDhlhJDMcyZu+Os9tS9uC8x0K3rCExnx3y02LDNkcIh65y7Gg4+nxqdaJnJ8TQZct9OjqVjHOkiCWbpNIX8nq/aFHIJyvTr+GIrm2P1KeoTrDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905406; c=relaxed/simple;
	bh=h/gURcyiroXERc30tAsjPBSZVuF3pg0jAqJbgtbiT0k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nt8Y91yabYxZHp5mBzptNoce/APV+FXZBlPhEMK09RCXbIS+rOnQ8EbLuMPCHhx7vVw5joZRfDwvyoGmbPYyM8MHzYcnFe+jjRwreC6FHFHFCfqJE2tWX9WUVt5+rweTTL/DnKA79qHqev2r0AET4L0y6OZButBIRiMcBi6dOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3738732f988so8457355ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905404; x=1717510204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WelPM0YOgva6j7b8RyCxFfD+qVIUmvNqXXrqPoDhdgY=;
        b=ZkHjALo3f9jweKRlNs2YRr0WS4yqKPqT8hA6z72uVrZOpSQ4lFqY4OsHqdgnsiQMq5
         4hhdfp7YH7hkFAvIZMHCdKSYRLx0A+/U6zewfiidwUuG7PJhXZku+TAI6sRqhYNRPQHr
         kDGvEW+hQsnh8w3UrV/xj8r0JgnO1OpkTpHwb0GzGvWg9PIzkkTT5/UNNruPXOFBHNS2
         K5Vuc2KI18rOqC6ilkdtr7xBcgISS+IQldiiBarHcHI1dVA5/+xYUiZi2fcW5HTuxG5I
         ifqiv9FfylG0U5bv+mRBj1C/QSZXl+pkOYQz6jOS92xY8XoXPDO/Mkb+h3lKq0HEvcZe
         7p0g==
X-Forwarded-Encrypted: i=1; AJvYcCX7iZv2R7vl412QUrW6fcchKDiWPUB8R5VeXDjlfHcGfIeZiocPRnoHQuIZATzjLgmSWgUDBjtOh+/lU+ZSl5r9JdJCUCq2HtzIT6NS
X-Gm-Message-State: AOJu0Yym1CRKiWFAd9YHen4kCeLCSJSXD0nukTAxT2KDIOimjzMeZkxD
	rvvLglQ14VEvdPPUwvI1WOKOaQCKObred7oxtch3knZBfThA6vRM3EBNiXQup/yahLmdNTup6Ux
	nPPUOZOMPpHjce7a8zrQu3Cuztl2mw1ZIdaizHNOnkPESSd7L2eAXZHU=
X-Google-Smtp-Source: AGHT+IGYxSLRdYdSIj6V1X50DGPsuaMd0GZg6XGsMCIH/LkK6jYr0HVeJzFN9W0DOKbFyaxhbmGnpo9uLKXYNy7mw6IEfD9syljH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:374:491c:654a with SMTP id
 e9e14a558f8ab-374491c6dd3mr3454075ab.1.1716905404172; Tue, 28 May 2024
 07:10:04 -0700 (PDT)
Date: Tue, 28 May 2024 07:10:04 -0700
In-Reply-To: <0000000000004fa7ab061966d1b3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba9d9b06198430d3@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __lock_task_sighand (3)
From: syzbot <syzbot+f2ed7d5888894fedf676@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	clang-built-linux@googlegroups.com, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mingo@redhat.com, nathan@kernel.org, ndesaulniers@google.com, 
	netdev@vger.kernel.org, rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit fbd94c7afcf99c9f3b1ba1168657ecc428eb2c8d
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Wed Dec 1 18:10:28 2021 +0000

    bpf: Pass a set of bpf_core_relo-s to prog_load command.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149b9a2c980000
start commit:   30a92c9e3d6b openvswitch: Set the skbuff pkt_type for prop..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=169b9a2c980000
console output: https://syzkaller.appspot.com/x/log.txt?x=129b9a2c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=f2ed7d5888894fedf676
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c203f0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12046634980000

Reported-by: syzbot+f2ed7d5888894fedf676@syzkaller.appspotmail.com
Fixes: fbd94c7afcf9 ("bpf: Pass a set of bpf_core_relo-s to prog_load command.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

