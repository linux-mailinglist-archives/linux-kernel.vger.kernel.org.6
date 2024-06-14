Return-Path: <linux-kernel+bounces-215181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A49B908F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F6D285E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58C9146A7D;
	Fri, 14 Jun 2024 15:49:13 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033C2107
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380153; cv=none; b=Ze6a+99mVpwvcDRL6Y6BovIzi2rWwO2EYCOAtTjY3nDeJ9xoxib6c31fGuNv3dhvE8m7Xp/muCNF0xIZmYLZNHKed3YYYELlEe516pA2RTR/cRttZvqdL8JuBCFA9IjqV8FyjJczUu1Va2n8XjP6zzL8W1d50OI2ksucJ9vC1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380153; c=relaxed/simple;
	bh=5IwPij49zPLYJfwIRx/ydFGwAAvPC+RPcWbTlBcpzlQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=hN2jZLF7CT04JaOqVL4Izbz/ak+S+VEH+bctphtqbOmCoVSzRJIB/IczmuiF7/D8P8rBFyaKtetubSEwfZY78bfNpBn2AcJrZDOIcG+14utzHd78agMsAZMoSF/xAzmKTKXLAUP07ijg6aSQi2yPLDYt6hBWYaufTxHVZbr62Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb5cbe815dso227243439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718380151; x=1718984951;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Abg9n/ElDJL+yni4YpyLc6J6VbdAVWJrogKkZMdMGYQ=;
        b=d5qb2bzJmFhAeBeflYmcbdg6TbRzeybQik8JdBmbaEbShF5tbBIhz8bMsw8/AXz+cK
         51Yz6EBdKwscaqCIYQBzOc5XxmNFO7tUAw4XDyo4FnRqA2AXs2B+EfwPZ8lC0/WVWaPZ
         0ikNQhAg8+4Ct5AB7y0VfhBneTHhzkxbVJaMPOnew+TjMih3GI1NZp3nqSSNlHMMKRrM
         nPhis5vTFwWvmxfq770Q1Vy8bqhrawPLBMZ2hhSOlJ/Z0AbQBEq81T3WdC9oR+qzgy0u
         Om2f4E/BGJBDhHLTY4DuqtSSEDRlry9bN2txgF034wNqYfHUs3ZhxfoPHhRC6AAFGbJx
         e5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL3W+EuTCM3bgxqzHLBUgJb8kqaadFrdvoVdzJ6J3ZluIu3UZX4utcQppvPaycrGtmVm0Vn6+ZvN+Ix8WeF+0n17EtYd778MNwjEwB
X-Gm-Message-State: AOJu0Yzf9z4X27Qownq7X2DAcS7PFIRiKgZ6zSZGNII0Hu/nN72DJvRA
	Uc6lAZlSrlurpyfKXju3j9uXiKc4VmbnOWZdQJqHuxWd7YBgjzjiu0XnrSChqOB3zuOlDX/1Fi8
	dOIZlObDq72ne09VQssJE4763bp6lFfadTO3amn3v541thH40V0vR++w=
X-Google-Smtp-Source: AGHT+IEajDsHQ52fEC1a/6WOA+gLuotF+8ot3FDIdcTh4F2HZoGR5OM2N5pKJmMxX0MIDAy7st9I1OiXsbBtdPICPFKRt4CepzWa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3426:b0:7eb:a74b:8895 with SMTP id
 ca18e2360f4ac-7ebeb64ba4cmr5391539f.4.1718380151129; Fri, 14 Jun 2024
 08:49:11 -0700 (PDT)
Date: Fri, 14 Jun 2024 08:49:11 -0700
In-Reply-To: <4dce1443-276b-460c-81a8-53a8008307bc@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f58de061adb8ea6@google.com>
Subject: Re: [syzbot] BUG: Bad rss-counter state (5)
From: syzbot <syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com>
To: baolin.wang@linux.alibaba.com
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

>
>
> On 2024/6/14 23:12, syzbot wrote:
>> syzbot has bisected this issue to:
>> 
>> commit 1c05047ad01693ad92bdf8347fad3b5c2b25e8bb
>> Author: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Date:   Tue Jun 4 10:17:45 2024 +0000
>> 
>>      mm: memory: extend finish_fault() to support large folio
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106e8e56980000
>> start commit:   d35b2284e966 Add linux-next specific files for 20240607
>> git tree:       linux-next
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=126e8e56980000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=146e8e56980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
>> dashboard link: https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f57a36980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a57696980000
>> 
>> Reported-by: syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com
>> Fixes: 1c05047ad016 ("mm: memory: extend finish_fault() to support large folio")
>> 
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> Thanks. Please try the fix in mm-unstable branch
>
> #syz test: 

want either no args or 2 args (repo, branch), got 1

> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=4135d2688b42f097f78062ef328f3056db32e3a0

