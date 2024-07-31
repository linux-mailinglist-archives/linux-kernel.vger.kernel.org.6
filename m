Return-Path: <linux-kernel+bounces-269076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A36942D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFC81C22872
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308E1AD9CA;
	Wed, 31 Jul 2024 11:29:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CE17C8D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425344; cv=none; b=tpY5Vjqa9Yno9rU7cmyIJBDuv7+dVJ0KdE5sx9HWLpNIPvL8nlgIJDm9gnQAvjU87/EMbfzhgzn4sq9us1xlNkUp65XNCMETpqcEmufydXh5Xz4LDP5tG/BCkN6oKOR0UdlGJMHfz/PDIY/bCPDOQJQcqvUpkNovQF9FlM/dZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425344; c=relaxed/simple;
	bh=OK7WX/muKuh6dpkDn2zXahHg3UGskfsjB8El7VDxsHY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KzlekmAgeX6V6CWtB5DWdbEYKP0af0+ZJGJSTPOC+oNrS4qg9HGo31JLJYbY4q+5jQ8TRruMa21T1YbVGmlBikOhREr7Nvq/ryZ5yGXTNNJrmZJQQ+VCdZbJfP31qBtVfZLeXhYzlO4Kw+pRCwrk8Y6eyoIKiHpMnvbEC1GnuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a16e61586so99545685ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722425342; x=1723030142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjzzuWVUEho2Ours+r6fecgDmbHgxzM1dNtvUYCPhdM=;
        b=ALz43wjD1yQY92LG52vPm99rypCXDJpDifs3WAgFpySbGVtVwDJowIooDX4Szavgw7
         9aJAQvMCJmWw/BzUt5HYKCBb/8pI4RGXkl9e7rvnqMzLrkn4av6Hdi74hLRyDwD7j5+v
         G0EpyZqGXpDUP30OABunD8u/5Pp9DKLBWiXUvCrRz8vVzNKM2M6gbsxFb+0PuBMlMnjF
         qmxrnX0k8G6xcICMfKCvFyHv158Jgg3qG4C2UqQ6Elavn+O10uGudp7SxhaFDmeQdloh
         ckKBVrj6yd9asnmj5AVsSPDccyxJBLFt7Yhxe9OtuvoWaS8ZXRBZej8Atm/AG1adJ8Uw
         Jczw==
X-Forwarded-Encrypted: i=1; AJvYcCVX7YQjznjGgVYY9iGKc3aid6uSVGPvxKbvJpTkgjMHLtuV2eeX6WDfwHBXfbtU4vSN5jAw4ExzYtqz4wAb3b0DXohwGemrZi02CSW0
X-Gm-Message-State: AOJu0YybljQh4nsZlAblVHW/CGUnKT04Cr5h8qSIfkllnrY+XD6AkhxZ
	cKFD22Tst5LcPY8vApVTcHrMlvyRS+IW94T8xF7zegqNlpR0BynNCnl6uidng0FNd4+nkGRQIiJ
	jfl6cp5Zsezoypigt62JNpH6M6rtBRvHCu0xeHEKNw2sB+bmaTjkEipQ=
X-Google-Smtp-Source: AGHT+IHrKncooR166gHaZnh0WAP35fqHoxI+Txal5KchHA+KPdWm7hVeDgT4YQdVUEJdOccfI1b4Ql5NzHi1qafsRiTBM/MhEQ3M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8e:b0:39a:e909:29f6 with SMTP id
 e9e14a558f8ab-39aec25a614mr11669535ab.0.1722425342368; Wed, 31 Jul 2024
 04:29:02 -0700 (PDT)
Date: Wed, 31 Jul 2024 04:29:02 -0700
In-Reply-To: <20240731110501.2425-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af4044061e89668a@google.com>
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
From: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Tested-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com

Tested on:

commit:         dc1c8034 minmax: simplify min()/max()/clamp() implemen..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1264b511980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10fe9911980000

Note: testing is done by a robot and is best-effort only.

