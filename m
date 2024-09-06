Return-Path: <linux-kernel+bounces-319430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EFD96FC81
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C461F2692C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E51D54FE;
	Fri,  6 Sep 2024 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kteexOVA"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919131CEAA5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725653293; cv=none; b=bmtyvU218bPr++zoaik0HeMBu8uur4PsupRRa9qXVdmE5k7uDTpx/ZYatUUAKzH3ZJSvSiMKAALlVDtytlrzRsiHnKx41HTGNsvGHeYCSh2+K2OK/wyIeVQBf+iFtKIPMhyDMTvdp7038zxt8KbJUM4lnOHD3ZvS87/7ng3RsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725653293; c=relaxed/simple;
	bh=vBYLQJ62bZux/zvwkTx6NUUChqVYC+O9fTF3DyGAfnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASae3VZah0/5nHVo+il6l+ckx0AlcdM0eQDoj54fmPFEVWFYnarTPc/A/PcwhkxjwFwgyE11GdSimZ3sSTXF9pteE955aWgqx6gIiWUpVngoPz/qDBAbi7zFZFnM64NrvHFBiL+4j+iMk6rNKtkU6IFDM1gkywGyHI8G/6cTPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kteexOVA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0EBA220B7435;
	Fri,  6 Sep 2024 13:08:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0EBA220B7435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725653292;
	bh=BXepEVb4kfwn/te77Ap5G3dOezJBnoObb1ZnjTuI7Lk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kteexOVAkfXtBwcr/tvML1XfrX08HlX42II3l2sxG03FCHK4S7huNas3D2IDi7lIw
	 Ai6hffe9/mhzRyzOejWJ1QNXl1rHv9dQZOOYS3raZ2Yv06/Ep3NBOlwQnmRJx14GQj
	 2mc3pEAzmQ1Ppil7goabJTqvERZJjFSMwl7dP0cw=
Message-ID: <da4baf5b-19e9-474c-90f6-fe17dd934333@linux.microsoft.com>
Date: Fri, 6 Sep 2024 13:08:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240905212741.143626-1-romank@linux.microsoft.com>
 <20240905212741.143626-2-romank@linux.microsoft.com>
 <20240906112345.GA17874@redhat.com>
 <CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <CAHk-=wjtMKmoC__NJ5T18TaRCqXL-3VFc6uADJv_MzgR1ZWPJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/6/2024 12:09 PM, Linus Torvalds wrote:
> On Fri, 6 Sept 2024 at 04:24, Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> Add cc's. Perhaps someone else can ack/nack the intent...
>>
>> This (trivial) patch is obviously buggy, but fixable. I won't argue
>> if it can help userspace.
> 
> I think the "what's the point for user space" is the much more important thing.
> 
> Honestly, acting differently when traced sounds like a truly
> fundamentally HORRIBLE model for anything at all - much less debugging
> - and I think it should not be helped in any way unless you have some
> really really strong arguments for it.
> 
> Can you figure it out as-is? Sure. But that's still not a reason to
> make bad behavior _easier_.

No dispute that altering behavior based on whether a process is traced
or not _is_ bad behavior. To be precise, when the process is still
doing work, it undoubtedly is.

When the process has run into a fatal error and is about to exit, having
a way to break into the debugger at this exact moment wouldn't change
anything about the logic of the data processing happening in the process.
What's so horrible in that to have a way to land in the debugger to see
what exactly is going on?

Another aid of a similar kind is logging. Sure, can figure out what's
the bug without it. It is easier to with it though, and logging might
change resource consumption so much more than the check for the tracer
being present when the process is dying.

All told, let me know if I may proceed with fixing the code as Oleg
suggested, or this piece should go into the waste basket. I could make
an argument that providing the way to get the tracer PID only via
proc FS through parsing text is more like shell/Perl/Python interface
to the kernel, and for compiled languages could have what's easier in
that setting (there is an easy syscall for getting PID, and there could
be code changing the logic on the PID being odd or even for the sake
of argument).

> 
>                 Linus

-- 
Thank you,
Roman


