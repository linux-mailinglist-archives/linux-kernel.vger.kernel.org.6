Return-Path: <linux-kernel+bounces-175664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D19AF8C2358
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C84D1F25D53
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8517082F;
	Fri, 10 May 2024 11:26:25 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC016F0C6
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340385; cv=none; b=cnXndC3M67MWRPZ+V6vyxE9+Js7JJeGzjZskz1Ne7fdN3zT5EM+eplpoCIJdHh9ArwlaSaJUMMotnEAnKwYRNSeyauttBgPO7SVksDfH9dPEY3dXCLVDMvD31BvaAFMjXvyzzg0sWTEaQHmkF08xc+V7c7GXKWpt2w4arWTL5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340385; c=relaxed/simple;
	bh=1STldVQ9ytbzdRMlFlbM0PQFwnF8z17mKW67CjrCmj4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K6Vl8n9yWV8mOYbxwwodhHVcPSUtyJluQYCBfPiUmbe10iwjXEKHN6VCLrYZNBP53PgCeVvoYIx1xLjXp5dSJ+WNhUCeUCOKgTMPUgaM2D2ReYbwLG2jamwAUzT+NtmzQcSLjx86COCtMls2RbgDHKXTS/fwzvQaIKe5OnUVE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44ABPMFb077870;
	Fri, 10 May 2024 20:25:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Fri, 10 May 2024 20:25:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44ABPMLm077864
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 10 May 2024 20:25:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a4586446-2318-4220-8610-0d5a99e0ad6c@I-love.SAKURA.ne.jp>
Date: Fri, 10 May 2024 20:25:22 +0900
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

Can someone take this patch and
https://lkml.kernel.org/r/20230423012744.24320-1-chenzhongjin@huawei.com ?
These bugs remain unfixed due to lack of someone who can take patches...


