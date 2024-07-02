Return-Path: <linux-kernel+bounces-237291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA691EEC8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFE61C219EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B26D54FB5;
	Tue,  2 Jul 2024 06:11:57 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC9747F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719900716; cv=none; b=glvuTl7na235qL5EcAkYVYA3rIj0lhyZUHWZJlhWXa03/qQyMFm1V5E3J//xdqhxKoeBIo5sc1BokZQvPuj7H944OYlYtEf24xkkTWNegsqk9t55JFwrTjJztB2yla3nSYpnCOuq83Pch61yte8ZqnIs48TLEVa+XFTBgpazhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719900716; c=relaxed/simple;
	bh=sH/nGSx4Rr38TllMdTGi9/ODcJdW+0jHT4ObLDhUghk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsRuKED4pOrCBuaJdzNO6nzfJPuO+KVVFzZiAH0iu/YHImQ+sGK3un+wmCxZ0/yCkGIjb/w4gilSbGb0pHJMd/7vMIQUBOm4yHzhubLWFW+slx/+cDiwXfE1IiJJUR2tbHmkiz/kyYhpq/POmlmL81iz4AyIstGkK3+G6eSJDi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4626BDsl058061;
	Tue, 2 Jul 2024 15:11:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Tue, 02 Jul 2024 15:11:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4626BCmT058057
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jul 2024 15:11:12 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ec7411af-01ac-4ebd-99ad-98019ff355bf@I-love.SAKURA.ne.jp>
Date: Tue, 2 Jul 2024 15:11:12 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in __show_regs
 (2)
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
References: <000000000000a8c856061ae85e20@google.com>
 <82cf2f25-fd3b-40a2-8d2b-a6385a585601@I-love.SAKURA.ne.jp>
 <daad75ac-9fd5-439a-b04b-235152bea222@I-love.SAKURA.ne.jp>
 <CA+fCnZdg=o3bA-kBM4UKEftiGfBffWXbqSapje8w25aKUk_4Nw@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CA+fCnZdg=o3bA-kBM4UKEftiGfBffWXbqSapje8w25aKUk_4Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/02 0:10, Andrey Konovalov wrote:
> This is weird, because if the metadata is 00, then the memory should
> be accessible and there should be no KASAN report.
> 
> Which makes me believe you have some kind of a race in your patch (or
> there's a race in the kernel that your patch somehow exposes).

Yes, I consider that my patch is exposing an existing race, for I can't
find a race in my patch. (Since
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b96342141183ffa62bfed5998f9b808c84042322
calls get_task_struct() when recording in-use state, report_rtnl_holders()
can't trigger use-after-free even if the thread died. Also, since previous version
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=5210cbe9a47fc5c1f43ba16d481e6335f3e2f345
synchronously calls synchronize_rcu() when clearing in-use state,
report_rtnl_holders() can't trigger use-after-free because the thread
can't die before calling put_rtnl_holder(). The variable "now" cannot be
0, and !cmpxchg(&rtnl_started[idx], 0, now) must serve as a serialization
lock when recording in-use state.)

>                                                                At
> least between the moment KASAN detected the issue and the moment the
> reporting procedure got to printing the memory state, the memory state
> changed.

Indeed, the exact line KASAN complained at varies suggests that the
memory state is modified by somebody else.

>          As this is stack memory that comes from a vmalloc allocation,
> I suspect the task whose stack had been at that location died, and
> something else got mapped there.

I consider that the task can't die while calling __show_regs() from
report_rtnl_holders().

> 
> This is my best guess, I hope it's helpful.

Well, KASAN says "out-of-bounds". But the reported address

  BUG: KASAN: stack-out-of-bounds in __show_regs+0x172/0x610
  Read of size 8 at addr ffffc90003c4f798 by task kworker/u8:5/234

is within the kernel stack memory mapping

  The buggy address belongs to the virtual mapping at
   [ffffc90003c48000, ffffc90003c51000) created by:
   copy_process+0x5d1/0x3d7

. Why is this "out-of-bounds" ? What boundary did KASAN compare with?
Is this just a race of KASAN detecting a problem and KASAN reporting
that problem? (But as I explained above, it is unlikely that the thread
to be reported can die while processing report_rtnl_holders()...)


