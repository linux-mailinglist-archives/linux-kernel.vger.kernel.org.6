Return-Path: <linux-kernel+bounces-180072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1C78C69BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CDE282D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A31156C47;
	Wed, 15 May 2024 15:29:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6257B15687C
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786945; cv=none; b=Gcjp2EvyXcRVCM4DxWoBrMgS3BezPeNG8jeSQ+MrL7HgNZgVS8g1hbzlc1/DoNop9sH00KZLuEjgXXFKHtzWXdP0jP2JHzlsMgJojDYUuHNpVSOs1NrT33uAimc9qgPe5U1dx7YjbKEBttE3tivY6CWz1EAD1b9wQ2kmodEoDwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786945; c=relaxed/simple;
	bh=PqF49Gws6c8IE8QBsjCzrN5yCRLZFu/Gy9G1aU4u6TQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HtJVml2yu4CdiGn4E0uhKCIHfzknPKonlsMu72JG5rrD4kDbZL2HEgLza43diZWvhxlCi8+UNColmX2obAxpGCJm0+IjYJh5+kQg9AeAjGruRF/IZMX8s/NAhsqPf1YIqFTwNqKjdKLdxa6WmLz6y8KK/gr5YQMKxo4eMpzFvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e1d807cfbaso499405839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786943; x=1716391743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNhrORouLQq0zE8Q1N3mawbELctD4U2yYjN8CbPX7CM=;
        b=luFsGZ/KB4ZnEP5r8sbADdWZqIYQJ35NwloYT6NeLPawHbWS2J9jEMpad8xaNOPtEG
         1QxANse3F6TtzfnIxCtv8dXxjxxEeyEgYk3HaT518RtN9vm+wk8TrC9ZdEdZjjSlSxj8
         znm4q8RxlyLuWYiuuy+4e+EwhsJ5L/qJBVIW3Co2lG1U19VPasL2C853oZw5JgGl0Zt1
         cH6P3EI1rD0aJ7CeFWgM2yL/GTOZXA0CKD08M4r5ZwqzFreVCh+EDd/YMDKcMs7kv7KG
         nEkpn5zdIQSqb5gKzj4Iv8/nhxLof9ibzpvMiX/aZtHRxiC65k2CYjz6lMUVjJMo6IG2
         3SGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3j5KIuP7ywazMkIWfHNtBVBVgsrw40kAgKUNBjlBAkO17pnjWrFndBSK4eWj6hS5caY/ngjjJPRdmdSXX7oCskgZGzogeL6+CXaUC
X-Gm-Message-State: AOJu0YzYx4s4JC2894RO68/sVCza2VyTk3tM68mUeIT14ik7MIbqZ9m+
	VwfMCa3T57E6S1TEtz16w9M6/Y1NhR7tJV890PdlW5xMrieOmqqlv+DN47Ek9piJVCn2lIOPfb5
	46nyAunY0sA0vSOhJ81uIOvKGbynYmm00wJHKiAZO3dsmNsg5yW5KHGE=
X-Google-Smtp-Source: AGHT+IH+Xte0typid77mQsPKT2woVUNNSCR05/igZC6Db/CLD0HuhNNjfiuJzefv2sWGB81JP6W0lDIe2IrKsModHuY5ZxKJgzzk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8725:b0:488:cdbc:72c0 with SMTP id
 8926c6da1cb9f-489586993ecmr1725942173.2.1715786943579; Wed, 15 May 2024
 08:29:03 -0700 (PDT)
Date: Wed, 15 May 2024 08:29:03 -0700
In-Reply-To: <000000000000b97fba06156dc57b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000485a2d06187fc7a7@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: stack-out-of-bounds Read in hash
From: syzbot <syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com>
To: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, houtao@huaweicloud.com, joannekoong@fb.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, songliubraving@fb.com, 
	syzkaller-bugs@googlegroups.com, yhs@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9330986c03006ab1d33d243b7cfe598a7a3c1baa
Author: Joanne Koong <joannekoong@fb.com>
Date:   Wed Oct 27 23:45:00 2021 +0000

    bpf: Add bloom filter map implementation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1543bd5c980000
start commit:   443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1743bd5c980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1343bd5c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9459b5d7fab774cf182f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d86795180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143eff76180000

Reported-by: syzbot+9459b5d7fab774cf182f@syzkaller.appspotmail.com
Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

