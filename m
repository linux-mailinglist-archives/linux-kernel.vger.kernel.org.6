Return-Path: <linux-kernel+bounces-188740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5FE8CE630
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DC61C21AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CA512BF38;
	Fri, 24 May 2024 13:29:44 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884526EB4A
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557384; cv=none; b=S8Qn/AOqXjCicXm3p0aW8OgxjUQBSF/Ulf8fDawMDYbfYmvDznkRzWLgsnO/0lkCs4Ni2yRJH6ecqNwVe1q+5fW1NGYFt61N8UuegmLrPfeVw174huiUYGPOf7NmFLSsSy/zBq5OFlQwceYrGNUYOrwam2UCvcuJjoOo6WT3rJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557384; c=relaxed/simple;
	bh=2JDf92Tog9KBmuidK5Ef5p9+4ys6GFSdcqyfl4DeWXU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f90waOIBkkXCcPJPjbl0Zqs2m7qYR6HbouvAmp/FMVrm/7C4Ygf9ysrmIQXZ1w1c/Ywx1Cl4AyeDMo5NhvJr2xRoeyzkVx3/5ic45AzEPzBsCQOcqOUqhOiMxs8QI25MEgh4W1MUdCmB4WX6+UBPlw2dUZeT0S0QapXc5J0VHJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44ODSJ4D038392;
	Fri, 24 May 2024 22:28:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Fri, 24 May 2024 22:28:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44ODSJD4038388
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 24 May 2024 22:28:19 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <19563aef-ed63-47b6-94c4-079db1bf8576@I-love.SAKURA.ne.jp>
Date: Fri, 24 May 2024 22:28:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH (REPOST)] profiling: initialize prof_cpu_mask from
 profile_online_cpu()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>,
        akpm@linux-foundation.org
Cc: tglx@linutronix.de, paskripkin@gmail.com, rostedt@goodmis.org,
        glider@google.com, ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <000000000000d6b55e060d6bc390@google.com>
 <7227c8d1-08f6-4f95-ad0f-d5c3e47d874d@I-love.SAKURA.ne.jp>
 <85edf211-aa30-4671-93e0-5173b3f7adf2@I-love.SAKURA.ne.jp>
 <239eadaf-d694-4dff-89b9-b476be35f4e9@I-love.SAKURA.ne.jp>
 <60011cc3-b9fc-49c8-b0c0-35aafe46f313@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <60011cc3-b9fc-49c8-b0c0-35aafe46f313@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/05/05 15:18, Tetsuo Handa wrote:
> On 2024/04/27 15:51, Tetsuo Handa wrote:
>> Can somebody test this patch? I don't know how not using
>> cpu_possible_mask affects expected profile data collection
>> (especially when written to /sys/kernel/profiling interface
>> when some of CPUs are offline).
> 
> I confirmed that writing to /sys/kernel/profiling while some of
> /sys/devices/system/cpu/cpu$num/online are 0 will not affect profile data
> collection, for profile_online_cpu() is called (and corresponding bit is set)
> when /sys/devices/system/cpu/cpu$num/online becomes 1. Thus, I consider that
> this patch itself is correct and safe.

Who can take this patch?


