Return-Path: <linux-kernel+bounces-215182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A62908F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15BF1F23762
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7F116D9D7;
	Fri, 14 Jun 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZMXjFftJ"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489392107
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380158; cv=none; b=q6mSu3g9I0oIS1riwzUjlDBrWhl5EsQxMrF23lBtOK847HMZg6cPKP3E9HxtGIeut3DZwpsh277U8z4MYFW8t6uxdze6mrwQmo7ritYSBuOF14ayNBwA10Ntq/dAZEUuQpXcWK54KX2fFKC/knMF/N3SIpqEoA5esMOs9yxcKu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380158; c=relaxed/simple;
	bh=9PmR7F+Bi1g+pVCwXJrtc90gmS5iJmU+BBoImjZ5fnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hSFA5KQtENM7r86pZSI5X2XsI8bFxzVjxgP6yU/z494UDlSh2cSvsCm8EIc9nY0+M0I48y/v06HZue6rgtE2uQbRXlXiNs6IdhKho8vuGtNdvBEkw1p0sleTyNd2NrJCnSI12U0RkrEe9FGy98AazMB1R/mPadsRZo8kQaUVsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZMXjFftJ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718380146; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6xVGwp8iy7Y73XJ/FZxwAl9aWZGWYwT3YWwofkeVyjA=;
	b=ZMXjFftJFWpdCRaUkD9Kems6qqjbZdgStp7pXqzjk3CM1hLFxSK6q25OOOIlIF1Vlk+c08sDYdL9L9XRfrs1O0g5EhU9OJdCkPr5T5iPTWEGry13FklpBakQ1DnE191coh8WICkm2iaGew3m0mcW+rrhjmwEaobVbETD6f117e4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W8RY7Sm_1718380145;
Received: from 192.168.0.106(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8RY7Sm_1718380145)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 23:49:06 +0800
Message-ID: <4dce1443-276b-460c-81a8-53a8008307bc@linux.alibaba.com>
Date: Fri, 14 Jun 2024 23:49:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] BUG: Bad rss-counter state (5)
To: syzbot <syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000c2c1fd061adb09d1@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <000000000000c2c1fd061adb09d1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/14 23:12, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 1c05047ad01693ad92bdf8347fad3b5c2b25e8bb
> Author: Baolin Wang <baolin.wang@linux.alibaba.com>
> Date:   Tue Jun 4 10:17:45 2024 +0000
> 
>      mm: memory: extend finish_fault() to support large folio
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106e8e56980000
> start commit:   d35b2284e966 Add linux-next specific files for 20240607
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=126e8e56980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=146e8e56980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
> dashboard link: https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f57a36980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a57696980000
> 
> Reported-by: syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com
> Fixes: 1c05047ad016 ("mm: memory: extend finish_fault() to support large folio")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Thanks. Please try the fix in mm-unstable branch

#syz test: 
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=4135d2688b42f097f78062ef328f3056db32e3a0

