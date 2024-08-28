Return-Path: <linux-kernel+bounces-304271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E8961D06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0E9FB22F99
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2108313DDD3;
	Wed, 28 Aug 2024 03:31:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438D13C67C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815864; cv=none; b=ELvXfvV603gS5JtdRN6Tlr4hfeS/u9rPv/EElM3RSzs52DXy10iRmHXRbngs2t0SuNtEyHaZj73Vabz19+EEhiA9FD/KHXt0GLukTaECrABdzH0Cix1zTO3HvKwqGyzOFs5SgaJc3zaRcpwOFAqhn8vq3E8IZ8UxHf1nnK7BvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815864; c=relaxed/simple;
	bh=rGfTbjB/IrseFEx3IwAHyLUhBJHgnuEKuPFplJBEDm8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D3fHZPA4WYaTLRpfPcGg1f0x0Zwp84p/rOB/o/iav3E/ik3GcSM4kLK1EcmXMoCwUFg9NmHVh6hbQwXxxVWSmwpNLPHhO+4Wwdun5DS1cgaPMQUzjRySkZuMgkZYND/DrrvZkEHvPrCbtbPnIHaWZc51jdnmOTsfoGtWQS2sgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8edd7370so732951839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 20:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724815862; x=1725420662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu5uJIf/8g8dj3Yf1bX3ohQRMUDAmS7B1nSWGrngtyA=;
        b=KngyJMZIgGgGqiHAHSrlRR3zzQMwx2YhfdE8D2hzfmD0kvBNkqhIA5QtAqKK5dBzvD
         D4FnqHh+OimCmZW45seAtxZh8tusDwHrhE2DPVY1t7Veq8Klb9vCpM29oldHJl25DViX
         TM6KDjB9HFZKGPDPabuaAvk/iiLVzH9CrzCsf8YWSiji047l+eDEf0KwrRknwIazGcMZ
         0l2Z9F7dq4VUljIoz7/eOt+xP/V4ETbW6hfLTMT0+wb/xCd9e3zuyidcOCIElpWE+yEg
         0+uaf3faClo/Z7HpJJ0ZgOzfaSeN4SFY8UOVjlwjOe2OLiSPKsENKffU61byvIBgx6/5
         07ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJP1MiEHumJq0hg7sCjafPvQiEfRU6q0W+qLKJQ3d6CZF6goP18N1QkFcB29gISQ5A8++1A3SmRdO1BBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OMBw2CUqGY/+ldX2lGtsbtg/0WsHuhtTQrjcYx2LsWVS+fG4
	00BzUSMYYgUuJDLOi42tVXyxjJXDdMK0AbZ8ndux/RRH14O6Y+gjRnJaQ1oUvGqUFlOmxadFW9j
	J5iCs44/SRRQAK1BHZ/RG8EzRNxqsxR3+R34ZLNfNAWyJPGKiD0pw54c=
X-Google-Smtp-Source: AGHT+IEq8u5/q/T/KHaia+Jqn7A0HsIJt8R9RZERwYw9F9VvKOGMfK5bKs62RG9i16fQQ3jpz+ESgjyw7fdzdoTzuweYCtivkz/x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:7306:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4cec4f922cbmr24918173.4.1724815862301; Tue, 27 Aug 2024
 20:31:02 -0700 (PDT)
Date: Tue, 27 Aug 2024 20:31:02 -0700
In-Reply-To: <00000000000041df050616f6ba4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c69eb60620b5fc4b@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_start_locking
From: syzbot <syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, hawk@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	longman@redhat.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, 
	penguin-kernel@i-love.sakura.ne.jp, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7d6be67cfdd4a53cea7147313ca13c531e3a470f
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Fri Jun 21 01:08:41 2024 +0000

    mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1412f697980000
start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=6ff90931779bcdfc840c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585acfa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bdb7ee980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

