Return-Path: <linux-kernel+bounces-264028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8579D93DE11
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89DFD1C2155D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7AE4AEF5;
	Sat, 27 Jul 2024 09:16:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D441C64
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071765; cv=none; b=lFJeYK1G3zwOdE4TRVXxs8ksG0ZchD25Dep7QIt/AEobBNx6OPF6epjRdmBtWY8ZQe1SPoRFAvJWbBTvitqLsCEnpGiIELaecAvEQcvmkgrxbtx3aAYQDW0Mb9rpFv248tK5/y6/Xwn15xm/sV9PiIb1498c497hHzwtUQsoZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071765; c=relaxed/simple;
	bh=dtvUBiAawgrbk/2NPnFXCKh/rwYKsAYierU6VX78Dls=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qqElQnla6Nqh7WI13wAo8barjqyWCOU3yreHIzKmugbvAHzOqusZTg1dKUGMivnAPtsdxUb6fmZA3oF65CdNeqgfPo84icQOKTsFL9RkaX7+5H02iIq2sfSe/BX/yGEJAddIl4Fwqjklu8h8jpqQvOmaCV5xwkbPjjhI12lxHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-396a820a8a3so32074875ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 02:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722071763; x=1722676563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtgwoy9Z2Qa1FGZaJIoMnbuyZFsJQYJvV6j3oH+HdZo=;
        b=F8fAjpm3Ye/T18hPTYbCpwoq4CMIp4mWjTGAMBkIL6L4GkjxoFn9YyL290Cths9gyf
         27xVW0VyQaBzmoud+lMoVwyjT5mC2LRgud3XuKKEtXQ8A2+fzWe2N+Y1hrHAvprmrQzq
         QNgb1QbbdBelQgd29Tu4mwFnEXkDCa/I+zBPbb5KSNRm4j2nI7sG0PHnhDVqTIbkYpti
         uAp+nN1DRLXM3M0/ZWWCUnFG/9MBRAVTUcgBWHR12/8rjD+j5CeMK8SD9N9ANS2trRxa
         ap2nUTZFCch1r6Gl2uwVjYUTIVw4JrVUIwR5VR6RQuJpahlEhgleAUZquQVQGC3deIkF
         UwuA==
X-Forwarded-Encrypted: i=1; AJvYcCV//QsQAQctj0by5GZKz/wDWaMKiWV27Fhr/gWXcuEyDhC1nEM6KyzIT9rcypz8pFoEFk5RmMbdKhHMgwgzMXhboL4apUiZ47Qyq9gY
X-Gm-Message-State: AOJu0YwqI6MJnjXbVU9+wlNkZykeQjhVtWcmoJF20TBTat3WeVk5WzXo
	sWV2fToJsn6m6O4XNQr4HHbfqk/S4WdWsv+gnwVXCnEWJt3xbXxQi+vpW0gGObAtn/h/nWp8qSU
	hKyywx7zyquKeP52CKz/JDNU4vZ8VQBYN4ls+UzJlS5TDcsJCGsL84ZQ=
X-Google-Smtp-Source: AGHT+IErWPbCOrtbq/dbUnqctTf2rtdkbh1lbkPC+maSPidZr2xjge9XRYxMaBhgfp08AMHsfmVRold/vyjY2spnOGlOdDgWTLkS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8c:0:b0:395:fa9a:3187 with SMTP id
 e9e14a558f8ab-39aebd77810mr1691265ab.3.1722071763015; Sat, 27 Jul 2024
 02:16:03 -0700 (PDT)
Date: Sat, 27 Jul 2024 02:16:02 -0700
In-Reply-To: <0000000000004fe821060e0a68d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b66dc7061e371339@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in ipv6_rcv (4)
From: syzbot <syzbot+d9b3e95a78490389cfb7@syzkaller.appspotmail.com>
To: davem@davemloft.net, dcaratti@redhat.com, dsahern@kernel.org, 
	edumazet@google.com, jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com, 
	shuah@kernel.org, syzkaller-bugs@googlegroups.com, vinicius.gomes@intel.com, 
	vladimir.oltean@nxp.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fb66df20a7201e60f2b13d7f95d031b31a8831d3
Author: Vladimir Oltean <vladimir.oltean@nxp.com>
Date:   Mon May 27 15:39:55 2024 +0000

    net/sched: taprio: extend minimum interval restriction to entire cycle too

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179b2623980000
start commit:   2cf4f94d8e86 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=314e9ad033a7d3a7
dashboard link: https://syzkaller.appspot.com/bug?extid=d9b3e95a78490389cfb7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1487fc06e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e5b4d6e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net/sched: taprio: extend minimum interval restriction to entire cycle too

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

