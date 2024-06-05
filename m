Return-Path: <linux-kernel+bounces-202188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 710018FC8DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17759284128
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C635191479;
	Wed,  5 Jun 2024 10:21:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E818FDD3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582863; cv=none; b=Zbrohm3jcgtCniBwY7cXKK1MJuFmj9uHR7k3yAt/Ualq+rvZrZbbl8oSw8pw6KuunXodHQ8PoXXD/CzlISKOgskPob9ejD3AZCqzTshdsZzcBreW5ei659htREuunofdOLS9FrS7+DuKRPwTbQgC68J8QE2QiovwmiZRs0hCAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582863; c=relaxed/simple;
	bh=mKZu2TsVWfel24gk5GGVXlpaHk53VCdi2sv9+kicIa0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pkGtn14WP/QpmC7CEK0IjrIrcKrzqsOwsayp2VCb0uVfoCGJhX/wnleWInc/CnvWXONDvcW9lZwje9yXF0WHdX5CYRmvS/tvPLZg2T4mWeV9pr8yxtuPQoqCnEBmGbqw+qctrN8kqt6GoyQskdAyQpb4FV77XO8H6gIz6EY5tzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-374b3e81d6dso4801245ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582862; x=1718187662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fH+Zetcf0TrdH6Eg/Hbnzc/0iC4RotiHhcppjlwNKMw=;
        b=VPYfEarNYGKQuhAhjNhcLbCoBxRuvmsW6n71wKu1vlvMVwSsvXI5vZFK1P8ehoudbu
         nrbFlfFa9sf6W4RPy8YNwTb2/zWjQVATS1/mqc8q1m9hKGTAXbET9MTcMWGuXUlM06L8
         Xk/YEoganvbw9bBGRK94V8ce+jGzhkSyP7/L7Jm1YeFUkx2BfwG0ZWd65Sj/4yKbbpEC
         YiQJxVjJkRQB8Je/0yDYyFYiL8kIgcwtinXA1ebhaqMzeSBQOiBmdYnOrZ3tAxAcZTFg
         LMgsyytCMn4dTIRiQleWc/247LHNluRbkE2FMw5eTAY/SO8nM6i3Yq8ZAHLNz6+8kVGD
         uGDA==
X-Forwarded-Encrypted: i=1; AJvYcCXxrVdPMP9e3nTTHL+3JwHxSRi5PKuP7wOtQ61193n2jlh5gmmyX5xHaWOPac6KaPGZUDSyCNs+top+p9D9bWVE1oWycjdCXZAVHuTc
X-Gm-Message-State: AOJu0YzYLU1olJ0ygIxmABjQG7YMpZKOh5jDMqD8lbEUWPxngw+CVOAY
	Cu3Kl9qxqN8sT5IIbzRk/afXi/wIjbkRLFEjZVACnr6mvetGvXX0Z+PwUuJeNjsP64Q0UuxXBlC
	0cfUIq/8ssaR2Qc/smy4h5X7nUx/7XZQpSpnyPb4mk5G9cbEcHNv5nBU=
X-Google-Smtp-Source: AGHT+IG3vMdJkUy72bl6FiyEjn1C/RymPUEXO6Zdu0OIGN1VuBMTk/OUf7CaCqmwocVKMjUvFAhy/WV+kU6PuPQentk8vT+NJLLq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:0:b0:374:a840:e5be with SMTP id
 e9e14a558f8ab-374b1e16d27mr1108305ab.0.1717582861831; Wed, 05 Jun 2024
 03:21:01 -0700 (PDT)
Date: Wed, 05 Jun 2024 03:21:01 -0700
In-Reply-To: <00000000000091ad3106157b63e6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a260c061a21ec0f@google.com>
Subject: Re: [syzbot] [bpf?] BUG: unable to handle kernel paging request in jhash
From: syzbot <syzbot+6592955f6080eeb2160f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	joannekoong@fb.com, john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	mattbobrowski@google.com, netdev@vger.kernel.org, sdf@google.com, 
	song@kernel.org, songliubraving@fb.com, syzkaller-bugs@googlegroups.com, 
	yhs@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4dd651076ef0e5f09940f763a1b4e8a209dab7ab
Author: Matt Bobrowski <mattbobrowski@google.com>
Date:   Tue Mar 26 19:50:19 2024 +0000

    bpf: update BPF LSM designated reviewer list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=142f8d64980000
start commit:   14bb1e8c8d4a selftests/bpf: Fix flaky test btf_map_in_map/..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=6592955f6080eeb2160f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f7a1d3180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b28b3d180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: update BPF LSM designated reviewer list

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

