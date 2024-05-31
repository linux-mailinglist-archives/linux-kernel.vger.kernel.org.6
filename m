Return-Path: <linux-kernel+bounces-196225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E583F8D5919
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A255A284F06
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BC578C80;
	Fri, 31 May 2024 03:41:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F9117C64
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717126866; cv=none; b=F6yuIyDREivPneSz06bCF1j2fVe5Kpy2XyctEhSBNthU8KP/htWseJr45kh0e16OVljbQ03MjJ8cT3T+BITR1cvyaA6qZ8aiTqI1hxF6UM2Y0SZXTEQ9ZkdC7rkuJTO8XJ/vJN40kJoOAWVEtVQJ7ke4nYSDNRBrcj5RvRWxwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717126866; c=relaxed/simple;
	bh=1rC0NKAONkLy0Oylwnzz5uBXjuFKNURyJe5NXU6R/yQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H3ftyUlYlUnnQhlHSSwOc8NmCSMt6Gy5QmPgwY7dVG1F6Pqas1zUpvwWbC7oPInwWXRAVEcfwHra9vYNFI25WgWayvrep6kWJs7IDMyUfwD6ZcgJzJ4wc+zjCZ5yGzq6VBU9ccdeDSIGyBlp6rDRabY4tYQrZEmIwoK9sRWpklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3737b3ae019so16905375ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 20:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717126864; x=1717731664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87j8o62HbkkhT6SZnt8wHJxPfsDOYjfW8V8a3wMHqjk=;
        b=T4JWiRLQe1Af5EAr1w+pXaY1l4BjUYgsy9sJDJtI1ndBuOmbBPOBPD0r1SQTr1YkcQ
         jWIp6TD7Re5lccv+meZQ0Ndssxx2AS4kFuGHrE56zuV0hFKCJO7e66PK5eh5fAxk9V6x
         xJ3S/txwObC6qlSWfws/aPITUpSnzpEw88es95Y/Uj1HcFDpzn/cYTaLSMptMCr1YSA+
         69sscosjn5Bww80DVvpFmTXV0/5MZyVnTtKcA9o+20tz3AASPiFX+cT1Joc88kiaxoax
         ln3+aiv+1pxnS+Ucnw3u1dOUDgKCKE7XlkbPwoZXnImS4JMPTrSzrwq2mRUolm8fmrtZ
         pgLA==
X-Forwarded-Encrypted: i=1; AJvYcCVdKbODx2iaznaVQFg/0Dwrazg35bx8Z9zm/WbWbRxIGjH7GUiSCmfSxRk9VO48enN9+5UxK6cZilv/FywRqgKhfSvITaNayB/gciM+
X-Gm-Message-State: AOJu0YwRA3PTN8MbjLkfkZgNXoHOUqMYB27WzB9JqV5QsNBcidizQctr
	Bz2+K7VGBVzaONP3AOx49+Cw8RFFsVOq3/lCWxNko/Z97wC2IUnBko2PIJyYkUOTtjgYBLxncol
	kp1XDMXgNsFjbNzL7YI5lTJn4/JWvV1GqLA9uUSgOPhRCHvnSt2yTmt0=
X-Google-Smtp-Source: AGHT+IGCsBUAVeOUsq1Bd0MSppgJvFf3Y3DrIaiDcrLOlhPfacoqnuTlaSqh8WRL67WxbHmUn3DdOa1DZgLuDjt1aCDR7Qa0FR43
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:373:89cf:c491 with SMTP id
 e9e14a558f8ab-3748b8f3693mr101875ab.0.1717126864795; Thu, 30 May 2024
 20:41:04 -0700 (PDT)
Date: Thu, 30 May 2024 20:41:04 -0700
In-Reply-To: <0000000000007628d60614449e5d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf8dba0619b7c0db@google.com>
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_check (2)
From: syzbot <syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com>
To: andrii@kernel.org, aou@eecs.berkeley.edu, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	olsajiri@gmail.com, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	puranjay12@gmail.com, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 122fdbd2a030a95128737fc77e47df15a8f170c3
Author: Puranjay Mohan <puranjay12@gmail.com>
Date:   Fri Mar 22 15:35:18 2024 +0000

    bpf: verifier: reject addr_space_cast insn without arena

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e17d3c980000
start commit:   4c2a26fc80bc bpf-next: Avoid goto in regs_refine_cond_op()
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=ba82760c63ba37799f70
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e6bbb9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12941291180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: verifier: reject addr_space_cast insn without arena

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

