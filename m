Return-Path: <linux-kernel+bounces-257399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABABD937972
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA6FB21E85
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089CB1459EF;
	Fri, 19 Jul 2024 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="h1qbZChk"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63921143745
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 14:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721401182; cv=none; b=tYtFR2ePhEI8v+85xFnT06i3i37XKoTuGteYbQHKW0Wc3bySzrF2nWLOXv0zcjc9ObO1XwQma4D6tGxDYXBcBy9mBF2NUMIW+pf/8TjIcZ8qZxKWpSUwJGQm6FWD9fMN5Sfag7lGt3zYnAlGZS/o/uTR8E1btNEvCIbrDQLgSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721401182; c=relaxed/simple;
	bh=1PJRt/I+M1/50MiURrjddfN0VS0fOCHmuyFSssHB+eA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGEYGNY1OL/MdeKsmjYyKzkxHwpwdMvQxP166nOJhGC/C/iL9Qxij/hN71ZO+0gwReAcTTz34jLFzesIJUzA50lvC4cpY4xo8cejCHjVGvNSisSkg5sXbbpfFZgrX6SPdBeauH+7eG0JKHgKAFTHSqH/D8VA1MM1sKDLOz9eNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=h1qbZChk; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1721401178;
	bh=1PJRt/I+M1/50MiURrjddfN0VS0fOCHmuyFSssHB+eA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h1qbZChkKLg/BUhaeHE4ogZZ8ai7fvzjVZTQfZeeJGJH7Ykaann0iyVtPNr9BFiru
	 hCWY6BexDhJCepZ7C2u6uSOI1jGLn3xXEx/36djrWFSD3bSk3CK8a8lPCKgY8C8d3y
	 pkS4ykrS6sS8uRLG4fW4t8ZUR8kxyDMMhhCsRYuSAutsbEhdPZlShdTRTZXBayRhL/
	 5/7/Sq8GROxp5mSvMGFRnNMMnWmIzsfVOhunDrz6jyOlsa4RSzzHcPSXq71NB6WB0h
	 EHKkSppdIJSSmtrbXY5B22t/NGE6o7UuCv2l00HXBMZ/yNwNPPQkLQANYbJdQZxaIF
	 JovQC9pE2R9aQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WQXrn6zCBz1D7p;
	Fri, 19 Jul 2024 10:59:37 -0400 (EDT)
Message-ID: <7e29c303-c91f-4229-9b9d-b60d8a60c38b@efficios.com>
Date: Fri, 19 Jul 2024 10:59:37 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ring-buffer: Updates for 6.11
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Thorsten Blum <thorsten.blum@toblux.com>
References: <20240716155118.152dea35@rorschach.local.home>
 <a71100aa-ffe4-477e-814a-1564e00cb067@efficios.com>
 <20240719103218.6c1eedfc@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240719103218.6c1eedfc@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-19 10:32, Steven Rostedt wrote:
> On Tue, 16 Jul 2024 16:05:26 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2024-07-16 15:51, Steven Rostedt wrote:
>>>
>>>
>>> Linus,
>>>
>>> tracing/ring-buffer: Have persistent buffer across reboots
>>
>> Hi Steven,
>>
>> Perhaps I'm missing something here, but we discussed previously that
>> you would document the fact that users of this feature are expected
>> to run the same kernel before/after reboot.
>>
>> Looking at this PR, I fail to find that documentation, or in fact
>> any documentation at all. Is this something that was overlooked ?
> 
> So I went to update this, and realized there's no place that actually
> mentions anything about this being used across reboots (besides in the
> change logs). The only documentation is in kernel-parameters.txt:
> 
>                          If memory has been reserved (see memmap for x86), the instance
>                          can use that memory:
>                          
>                                  memmap=12M$0x284500000 trace_instance=boot_map@0x284500000:12M
> 
>                          The above will create a "boot_map" instance that uses the physical
>                          memory at 0x284500000 that is 12Megs. The per CPU buffers of that
>                          instance will be split up accordingly.
> 
> I do plan on adding more documentation on the use cases of this, but I
> was planning on doing that in the next merge window when the
> reserve_mem kernel parameter can be used. Right now, we only document
> what it does, and not what it is used for.
> 
> Do you still have an issue with that part missing? No where does it
> mention that this is used across boots. There is a file created in the
> boot mapped instance directory that hints to the usage
> (last_boot_info), but still there's no assumptions made.
> 
> In other words, why document a restriction on something that hasn't
> been documented?

AFAIU the intended use of this feature is to convey trace buffer
data from one kernel to the next across a reboot, which makes it
a whole different/new kind of ABI.

Having no documentation will not stop anyone from using this new
feature and make assumptions about ABI guarantees. I am concerned
that this ABI ends up being defined by accident/misuses rather than
by design if it is merged without documentation.

Very often when I find myself documenting a feature, I look back at
the user-facing result and modify the ABI where it does not make
sense. Merging this ABI without documentation prevents that.

So if you ask my honest opinion there, I would say that merging this
ABI without documentation feels rushed.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


