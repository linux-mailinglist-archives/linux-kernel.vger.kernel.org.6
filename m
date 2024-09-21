Return-Path: <linux-kernel+bounces-334759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E697DBCF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05211F21DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 06:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0BD26AFC;
	Sat, 21 Sep 2024 06:01:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32D18EA2
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726898464; cv=none; b=PcqgP9D6RU49x6b5c2X/gmpr9/E/ArqqF1spY39K9vCWxrQoneSGMCXdQH6Uk4EblhMoBWQvNbS/j1w7M68/1lGptdBFmfhDzf6cLKjcSI0Oea5KCHIDlydPNRrDkHdq0TA2AqNWt0ygA/1WGxPP+DrSatsXl9lkyYNoK3HU6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726898464; c=relaxed/simple;
	bh=vN88r/MWcIw5d13Xx8PMvww6v1/dCuW8rflRaYlS16Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AFGyPmq7EppK9gg+0jlphUjXXMiE7v1cjWjYm6dndxYpwCeph3DHvAwzLCXQsltM+19QjkV+GeCpVfN7KNHL063GqE4E2kSUWNG9NK91UMudmoYFTMqWtsnTChFOF0kur2wjCr+aosponN/tqOtGRIYWsZS/xWSGGJ02e9Y8GUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f53b1932aso34274365ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 23:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726898462; x=1727503262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPE27Bxeqa1YzxxNvweV1dkh1rye+Erw/a4Knu+irIo=;
        b=cjNlY6Wb815gL8Iz//r/vxzJWhwN5M9kP4e3XBN0jgFAzR9u/N0eOKeDz/3IPdcNE0
         VzgS93Q9Z0BdL49zbifanX0O2x9UYIketEJ//Koy8JrJIT+lEqU07pzXqscxnsJq2Sca
         Saw79aYiCaPcVFVHsdwFculxcdocRah2Zyexad4t1R1qL7Bz/v1NXtTB3DNeYynrBTrm
         x0CRSXMyJSp3MbBRzP0yoEXqjPfojW0c3BBlD8oUV+Ug/X+OUkA3gr/3wZQ82Z4zmK8G
         eE0t3XyprqPk0d+llbrTrAUkSYfSHtgugy9bSsXIX4DqyCUOvvZAKGvO2+0WE32ZmLD0
         MsSg==
X-Forwarded-Encrypted: i=1; AJvYcCVROMoeiztcC6fiXEzFDNgvQxtlbAfZL2f/8/E42XdCN24dlY1UthexjVuncWSw2FviinGgr7xZLkQmlXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaqjv3MQHtahe+y6OhueZ5mqIgxsmWZ4Ip6CgcyfksgP/u+cQb
	uUyWYnOaGcNMESipwL4PeSyxAL2eDVqGWcC52+1Fw1c0fpPutZHifrQdQX9dTrEv/OrsIXM1sDf
	RrncxdMVQ9abdX2A2ODOeR1ZBvjGcvG1P499euS2H+TlHUqfrkgaCCp0=
X-Google-Smtp-Source: AGHT+IHiU5ABqWw8MT4I428svEJdSH46l8oMw5JLZ7htSE0pJmmsAQ+YsW/7MJb2Gh0BtC/vU5A2OlT/Tu2dUtk8Wth0nY9hYDL5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e3:b0:3a0:a311:6773 with SMTP id
 e9e14a558f8ab-3a0c8d3ace3mr51673275ab.21.1726898462441; Fri, 20 Sep 2024
 23:01:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 23:01:02 -0700
In-Reply-To: <00000000000070a181061bc8b256@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee611e.050a0220.3195df.0035.GAE@google.com>
Subject: Re: [syzbot] [kernel?] kernel BUG in __jump_label_patch
From: syzbot <syzbot+03cfa0c5a0bcba3bf195@syzkaller.appspotmail.com>
To: ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	djwong@kernel.org, hpa@zytor.com, jbaron@akamai.com, jpoimboe@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 224fa3552029a3d14bec7acf72ded8171d551b88
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Jul 31 10:43:21 2024 +0000

    jump_label: Fix the fix, brown paper bags galore

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1719ff00580000
start commit:   2c9b3512402e Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f463ee48656fea03
dashboard link: https://syzkaller.appspot.com/bug?extid=03cfa0c5a0bcba3bf195
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128eca3d980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: jump_label: Fix the fix, brown paper bags galore

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

