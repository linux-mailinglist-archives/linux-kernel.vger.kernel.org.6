Return-Path: <linux-kernel+bounces-279985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C564D94C42A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B76F1F22657
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7014883F;
	Thu,  8 Aug 2024 18:20:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAE78C98
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141205; cv=none; b=KCSNQlWox3Sqcx9kYll3LoMS8Y/n13/w3zkR4ln22wWN7Q4acv3+hbX9PIpaipLWUvhxsIivvmy5LeMHq1Uoyj1V8gXXt74fXaoxJlHMQ81O+V8UGEEJDWnzUI6jxaEly2Ao/t0WHD66jD5MD6iGRm/Gy+AI7rVYe5cIvuPHTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141205; c=relaxed/simple;
	bh=A4csGmWCoPZ74aoudsl4h8T9HLs5pNqrw2WZK4uPKRU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Tf2JAvhAXYNcs0Drn/wpPaJ01SoV9cPrC9QX+FIV+8utHUclrdRmi4NjpLLJPVnHwT2MptMkObaQ1LkE4DW8AC43tvf7HkNlLVDjvny9erGAeXwdA2pfkxy/WKbvcm4ununyHx3PwYxYy/0h/mDqgco1qLqxl40mTSIQq3+qfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8edd7370so142965139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141203; x=1723746003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ncqslw7BK1CqqZmrGSWzwTBOiICY9xk/ffH8fZ5hP68=;
        b=bOUDfmIC70R2hGllBxtk/oCjhwU4dBPh+2yxGxtoLYaBZLw49uAoDz2ZfYNMHrpBUB
         qdy4zQOoDrbWxKFNP2FSCN6mO+O2Oio/zdHaKwCznN4ROoIvNWlAnlcSq4XtFCJFKlvV
         6cMn5kwqbrgB9QtgIAVuQabNOuAFiB6bUFjjiGHMpbJF7uVwa3zd+X1Qmx0SkbXKX+mJ
         78nMgxme90Mos9fYvB8Qn2pTfQ+zYDzDYdMDCqbpL2VbXL7xYOjHpmn53HsqaX1yljXH
         ME4nKrpIRi6vOE25yPJaDZ4seMRsfgoy5A+ZCgmwB9ApMJyuWMC1X5rufRoMKDbWs5RP
         ORFw==
X-Forwarded-Encrypted: i=1; AJvYcCXZNGUv9YsJKno0S9Rjv+ZDh7paFTROrT1uKy7HKgHxosw/llJB0Bsmz1KvCvf+xB+U0E6enCL8H7Rq3aRBhwP49ILUAYdGzH6w213v
X-Gm-Message-State: AOJu0Yydk6KJK1fdexvvyQCjSa3M8j6WuqFstav8JmzwYeoD7Urc9C0/
	ahn117Na8Df9Y2BdTzEVKRwbg5nVy362YvGMrLMot360WYfe+XChJL9oYRVJUXzS3NNLRQZOPDk
	c07QJki0Gjgu9ffVzEqXRX5YSRlyc3j1RAfux02R8ylGehIRuGFQFE0M=
X-Google-Smtp-Source: AGHT+IHbhNaK62W4K7+QUWq3BdqL/7ruRlRKk3wLISGUKGyTl1h6WiBzkoJhNDWZunJHnppnZq8wpHW5FFDkYjLuN+LN9lzK035j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fd1:b0:803:85e8:c40b with SMTP id
 ca18e2360f4ac-8225383303dmr7731539f.3.1723141202901; Thu, 08 Aug 2024
 11:20:02 -0700 (PDT)
Date: Thu, 08 Aug 2024 11:20:02 -0700
In-Reply-To: <0000000000004cc3030616474b1e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c081f061f3013d1@google.com>
Subject: Re: [syzbot] [bpf?] [net?] WARNING in __xdp_reg_mem_model
From: syzbot <syzbot+f534bd500d914e34b59e@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, d.dulov@aladdin.ru, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	hawk@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, lorenzo.bianconi@redhat.com, lorenzo@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	toke@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7e9f79428372c6eab92271390851be34ab26bfb4
Author: Daniil Dulov <d.dulov@aladdin.ru>
Date:   Mon Jun 24 08:07:47 2024 +0000

    xdp: Remove WARN() from __xdp_reg_mem_model()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10df4a5d980000
start commit:   f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=f534bd500d914e34b59e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ac600b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1144b797180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: xdp: Remove WARN() from __xdp_reg_mem_model()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

