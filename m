Return-Path: <linux-kernel+bounces-242746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D839928C84
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8FC1C2442A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C8B2B9B9;
	Fri,  5 Jul 2024 16:53:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3216CD00
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198384; cv=none; b=TeBw09VBVWei6V30I5tXj1hYh53xhl8N+biLE+V6L06lAiIluBo2h9Lsb6KZNYvEYCQJUD1PvmnTnrc8IHUqqLWDcAQWE83UZNROxfc70laS8R2gPFysDkdBUNgpPXO2M9y9y4LlSzlq6oYrYSwKlErg1smHhSnWHbJCOqYnhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198384; c=relaxed/simple;
	bh=UaM93TGN4iYPCN5uZ5z2UKlaHCz9b8vpxwC7j9MOd+U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DJXJYZyRrM+DVSJUW2uuCU3jeHWKaT08ZcIoa5U+44sCTp9IkjVr7NaL+Bwwk3HvEm4IrvvZuqFy1Nd+WBV/QWJyqtczP+4RDdT2vfdRwGxg9VRf2Io8rU060SxLZdLHzSznQ5YJBBPNCGsokilOp+BljNGRm06Ey1sCb6TCvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3ccfec801so207223439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 09:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720198382; x=1720803182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3kqwbkZY7L2l8IVXTuQ2qgComWiD7Adz9v9kn/ngmI=;
        b=jwqNRFabet0uerWhQOuR9R/IeNdh795gZeZvD2k5+BRVPXhfkP29BYatzz9GSoBy2v
         djcRt7OPQnwHiEutQn8hbwhguTteDShp4H689ODTv2U4kPtKW3Cx3h6hJ9zLoBtuR43z
         iq3Ta3Q6jYbAywZaC4p8ykQJ2xByztwLqViZ9Ie+9hAtyab6YjCD4Kp9zIbf0Un2i+Sk
         dDoLZN+KZQObzmpJh3v6LfK4ugMY7i9coW9FOJxu8I5769VUj4bZTvcMqs/Nxli6FK46
         EJIQNhagbNWkOBtdiJKRdd2Zzm6TItJc9HcImkEX2TowTlBSKAWCfg2ASlCRvLGryCvY
         dIHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTTusdf6CHT9Xz0rKHbKfGKCk1C7FW/jymHixKnfRvMUAIXqeuE6UnaZSpBcp8ZRI6EmmwauO6gik+OoqEkAZfiNO6DLPRUmnasyMU
X-Gm-Message-State: AOJu0YwoNxwNqRW+gmTRvkOM+D0aJDwISHuBW8k2q4UldRTZmSNhnc1n
	NoAto4jQvIjP6Jpec3ZuGhEqF4x6BEYNOdmgvheWWJtTaOe6+1PvxeaHWNQbM2OnTY3XAFNngdu
	81pXdGmrX3HwduX5Fo+g8G3vkzLqUw0DbMnz2gUe33v3DvgEhGcvbfTo=
X-Google-Smtp-Source: AGHT+IG/yEhFXD6qQMI81WxcPhdywfcFpk+5U3Vl9g/NRzi3ksxB+siy5qOyZMOIM90GcuOG5Z/mFSN26sRXwVYlJNWTJCpyEAGZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144d:b0:4b7:c9b5:675c with SMTP id
 8926c6da1cb9f-4bf63c2f6efmr705928173.6.1720198382283; Fri, 05 Jul 2024
 09:53:02 -0700 (PDT)
Date: Fri, 05 Jul 2024 09:53:02 -0700
In-Reply-To: <0000000000005c2f9906153555b1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084fd82061c82e523@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in emulate_vsyscall (2)
From: syzbot <syzbot+1a55be5c9d955093937c@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net, 
	edumazet@google.com, hpa@zytor.com, jhs@mojatatu.com, jiri@resnulli.us, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org, 
	mingo@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	praveen.kannoju@oracle.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 33fb988b67050d9bb512f77f08453fa00088943c
Author: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Date:   Wed May 8 13:36:17 2024 +0000

    net/sched: adjust device watchdog timer to detect stopped queue at right time

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1163e569980000
start commit:   480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=1a55be5c9d955093937c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a64776180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142939b1180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: adjust device watchdog timer to detect stopped queue at right time

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

