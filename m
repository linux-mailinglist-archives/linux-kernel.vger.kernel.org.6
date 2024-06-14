Return-Path: <linux-kernel+bounces-215186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6084A908F58
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A931C20D67
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFE015FA95;
	Fri, 14 Jun 2024 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KFCBNwdv"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD119D8A8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380265; cv=none; b=i1fIqYeXvKhBFsjfJjyeLjl+i3agU2qwdjIAW0sEaVjH9GEs9qA51Mvywq44pCOao2FfALSA14NUUje3Ml1s4Yks+2ZprkopgnBE3DiopSmwZaYkcNP6W9SFis2mrKpQwotmZKml/oCzaTCayic13CgTyvlKWgWTr0bhBqAQ4Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380265; c=relaxed/simple;
	bh=BvjgjlgucoXkEkKLtVSOVM2pyQUuUWHW5q5svClDKlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUZJmmH+f5gSOJ0scVsd6ukhTXc1kZFTndmW4jMCGJ4Ln4tcghEZy6JLzvYWowi2nwQS715mHZ0U2yBW20NsAAmq6kQgjPe3z0wOlm0AonHe62LlkvO/cQY5RKRYt2R+pgTZKHvPdE7cNha+q/aNJLl31jydfPD7bx455TPowDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KFCBNwdv; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718380260; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YYE4KSPkg1QQNyDaGn6/ggOWuxBN59PMEdzwWo8hCNY=;
	b=KFCBNwdvZzIbvhlA9XODWGUMtpibROQlSntBYUL71BdaJliJz9Vkd2CgJZmbmsXzmc+n0Mg9Ko4CW8WVRj7IeBgPzRhrubDLGJGcurV7xMhdnoNsEUhjhGda70P80Lo9ChLA2l6wj1ZGGdzd5kUMQ/VA+ki4YD4KbHM+Zrr1DgY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W8RXOKv_1718380259;
Received: from 192.168.0.106(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8RXOKv_1718380259)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 23:50:59 +0800
Message-ID: <4fc95571-7815-458f-9d34-5109b1be7399@linux.alibaba.com>
Date: Fri, 14 Jun 2024 23:50:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] BUG: Bad rss-counter state (5)
To: syzbot <syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <0000000000007f58de061adb8ea6@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <0000000000007f58de061adb8ea6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/14 23:49, syzbot wrote:
>>
>>
>> On 2024/6/14 23:12, syzbot wrote:
>>> syzbot has bisected this issue to:
>>>
>>> commit 1c05047ad01693ad92bdf8347fad3b5c2b25e8bb
>>> Author: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Date:   Tue Jun 4 10:17:45 2024 +0000
>>>
>>>       mm: memory: extend finish_fault() to support large folio
>>>
>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106e8e56980000
>>> start commit:   d35b2284e966 Add linux-next specific files for 20240607
>>> git tree:       linux-next
>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=126e8e56980000
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=146e8e56980000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f57a36980000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a57696980000
>>>
>>> Reported-by: syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com
>>> Fixes: 1c05047ad016 ("mm: memory: extend finish_fault() to support large folio")
>>>
>>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>
>> Thanks. Please try the fix in mm-unstable branch
>>
>> #syz test:
> 
> want either no args or 2 args (repo, branch), got 1
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=4135d2688b42f097f78062ef328f3056db32e3a0

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git 
mm-unstable

