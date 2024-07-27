Return-Path: <linux-kernel+bounces-264302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFA793E175
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 01:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A22D1C20E26
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F553E24;
	Sat, 27 Jul 2024 23:48:08 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8F225634
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 23:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722124087; cv=none; b=MQvM+bnhWqRq55LofbVLw1YwIq4Mxe0Mxhk7JwEfThofd2k92us2YPjUT1qigrNkLkJA/gqA/1bWzyH4eIpdhlwM/ccdb4yyMhpaZFfXHob8YvtFUya1eZW9CCxTUNkrpkOy4uOSiyA4dyIOglL1Z5CIdr7VoJeLFcQeVVVX0rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722124087; c=relaxed/simple;
	bh=u1LwNZMZtEUicaM10i+yfP1IqJpfhNlzUVn5c23iwm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqtUO1Lswxv037FFHGpL6bIsZlivbFpeXpYMIVbSRYs3i34HWJEJB9aEtOrryuEFVLNeeq84K3Vg0xSDYTs+USKeUJI+mDec2VWzRbGZL2zUkVpFhKuO6oroKiAm6uZTCnwWCWqlkQGFjEmQe8WKrPo1qzzGKBDeUb11URKLluQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46RNluYc080678;
	Sun, 28 Jul 2024 08:47:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Sun, 28 Jul 2024 08:47:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46RNluZp080674
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Jul 2024 08:47:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <503c1a50-ddc0-4128-b0f0-feceb43ff5d3@I-love.SAKURA.ne.jp>
Date: Sun, 28 Jul 2024 08:47:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] profiling: remove prof_cpu_mask
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <5e42ce13-3203-4431-b984-57d702837015@I-love.SAKURA.ne.jp>
 <CAHk-=wgs52BxT4Zjmjz8aNvHWKxf5_ThBY4bYL1Y6CTaNL2dTw@mail.gmail.com>
 <87a5i2ttv0.ffs@tglx>
 <CAHk-=wg-qQGB2iM1OeprikBWp9-nUEDaWNxwwJ00u1vmUJVtHg@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wg-qQGB2iM1OeprikBWp9-nUEDaWNxwwJ00u1vmUJVtHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/28 6:22, Linus Torvalds wrote:
> I wonder how many people actually use this ancient kernel profiling
> thing. I get the feeling that it's "one real user and a hundred syzbot
> test failures".

What about emitting some kernel messages for investigating whether there
are users who need this code, and wait for two years for whether someone
says "I need this code" ?

For example, hfs ( https://syzkaller.appspot.com/upstream/s/hfs ) has
many open bugs. Some of them have patches but nobody can review/take them.
Unless a filesystem needs to be mounted as a native filesystem, I think
that re-implementing such filesystem as a fuse-based filesystem will help
reducing overall bugs.

Anyway, it seems that the kernel sleep profiling is no longer working
after commit 42a20f86dc19 ("sched: Add wrapper for get_wchan() to keep
task blocked").


