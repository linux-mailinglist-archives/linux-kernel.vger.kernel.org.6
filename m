Return-Path: <linux-kernel+bounces-241105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F057927713
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB7A1F2375C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB51AED5B;
	Thu,  4 Jul 2024 13:22:01 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522341AED4C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099321; cv=none; b=VSG+589iJHaqhV+gqpQX4xTJ3KXlh1XE+pxnxI/6wKxsDiJqc51UzbTPnBK3kpEdrEZWWDlO3DUkBcyWn6dQSS6ZLwvN9lw93AVyCml/VwrTh//PlXudJIguKAkJa0b+dpy0naUa99wPLbCgbG31xnie3WAPxeEp78Rrb2smYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099321; c=relaxed/simple;
	bh=Muph26Et/g7iLxzsg6geI7Jw3wTi8VRqF0z9G11Rd0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgW9tlkC4k7wgQxTL22ERo3ARQyuU9YJYs68aQsOwoNVAQNE7SnAfybCJqAriOMNRm0VGlWKkcKiyUWVlT/Cz5rn3Q4snU4RG5bynnTcCzycY0cNDqm7Cr6GK96VDABE2dvnai1qBsIXEgaHwYgvN4JTpelT4V7e5died2AGeSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 464DLo5W045136;
	Thu, 4 Jul 2024 22:21:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Thu, 04 Jul 2024 22:21:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 464DLorq045133
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 4 Jul 2024 22:21:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e0c7a2f8-9147-42bd-b531-f51c4d0c5082@I-love.SAKURA.ne.jp>
Date: Thu, 4 Jul 2024 22:21:50 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_released
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: syzbot+16b6ab88e66b34d09014@syzkaller.appspotmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        nsaenz@amazon.com
References: <0000000000002be09b061c483ea1@google.com>
 <98dcfbda-6237-4bf6-bc66-6f31cf12f678@I-love.SAKURA.ne.jp>
 <CAJHvVcjOjOTyrf4K+pTQ30doOx7hqheTExZY6_U+PCcdLigg7g@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAJHvVcjOjOTyrf4K+pTQ30doOx7hqheTExZY6_U+PCcdLigg7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/03 7:35, Axel Rasmussen wrote:
> But, note that stack_map_get_build_id calls mmap_read_trylock, so I
> would expect in the recursive case that call will simply fail, and
> then stack_map_get_build_id_offset appears to deal gracefully with
> that?

Unless that mmap was already held for write (or someone has started waiting
to hold it for write), recursive mmap_read_trylock() will succeed. Thus,
unless there is a guarantee of no infinite recursion, we should implement
a safeguard based on the worst scenario.


