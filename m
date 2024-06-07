Return-Path: <linux-kernel+bounces-205601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00DE8FFE01
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6EE1C232B3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105BD15B10F;
	Fri,  7 Jun 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DSHbEEAe"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62E15B0F8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717748950; cv=none; b=LfJNGZ5tE0orLDnfxWJHOSievPIwlYeWsXDPMoEOp5ldyeLLpmA8oHHqLEMyNsmjQ+2xezgpoyEXtTwLSMZ5FPywTPoLZ1CryQ5o3wMzZkwXFzZDYTbu4qVZStIXb/emYgOULdK/TmBnlhEjlm2bVdYg0G9VOF1LTUnjmwm6EqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717748950; c=relaxed/simple;
	bh=QATZmHP34GTT8tosT9gK5RtxZXN64Ern4IqkCYoKwlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITaVumAlPw6GOtIiaxLrL2RxFExaaN2Hfo/7wtOBjmATTVh4nh+65ceFmAP/jSoJb5QVx63P+jiivA2dmJyHo9obKyK6Gtm+bfE9XIITiAUqSVgpxk627gNVEzX9D6dJ/UieNRGZMJwQ7gvtWA1mDvzxEjcbzV9EyLm1nCws8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DSHbEEAe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so19966835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717748945; x=1718353745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSxiQ+5CYM/BoywAPnNuMbG49canrkXeNSJBPwAeVdc=;
        b=DSHbEEAeT/RjvnUybtM1ToTFamakMfMweQLycKwVfw2EqSGENadomJL3ZMognB7oca
         oVkxRFEnrl2MNegT28SVWCwOqTrqJhSMoWCKJUXbFKUWpLklSgTCXkewG1LxrrVmFyf0
         SO/+2kXQQ2zMnf2+xUZz6x8Xp+vV1XubC2WFeEaiDsuwsOKMZPLyiLjSTkNkJtimHqak
         tBgxj0fkLsMI1PjNQusD2+EoPpDCcM1gp1Nkmg55sQ3eVWTc4h7boWq2k49Oyt60KfbW
         Innh1v+FNmH+l1o5H4saxB5H3iUbGwxvr6ognvXTcoY7Iu7c9sVC9jLam7KqAIc2nB3D
         sQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717748945; x=1718353745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSxiQ+5CYM/BoywAPnNuMbG49canrkXeNSJBPwAeVdc=;
        b=bOcMIPBA03qOykDnZDsuhfXEZFXt0bv4J5hJEZ6VFz9j2aLGc5j/PNkocXl/559M6K
         xmo6PGwl/kU9TDm4V133llqcM6KA3gyeItIGT9UJmcG8eZGEXh4Td7Z+O/84OrD6A3A9
         ITREskKuW5jwgxTBqGiGATAQcDhxYo6UncJfUb+pLCod4o/Pc8TmaD14yCTO7+mLuzRY
         bNdu5sDFYX0SJmq0G2TWrhGVMY1uYGINf4nSbQJgExJxG7aaqfir/nn4xeN1q23kpkDI
         o9qh9tlnGnFjU4BogZErxAynuHoIe5GYWHlENrJEMT09/wnEknPfdKGmExpb410rQFh9
         mj+w==
X-Forwarded-Encrypted: i=1; AJvYcCXZomPsAzCOBEMuf02TLmMm2WKoy0ndLkjUuzv2S6JfoHMeM4Ss3oVvaXM4z2g8PL9OR7Njh48HEKZimCX5kZNn74XDX+vqaQ7okBjj
X-Gm-Message-State: AOJu0YxqZev836dEOXyXlc0seKrVkQnpa1sLk9Pkc8bC15fBOey1zydA
	U7fCiFy35Q2pyPfE048DxNO90MJ31kge0eNkGdcnwIzENNGi3ZFZrSS+PfqTT7c=
X-Google-Smtp-Source: AGHT+IFrzHtybL1xMi2IzJGSx+essiIdz77G9veyJjUyflJ49lylbDU6tgHyqxqyeVZd90W+7k5J+g==
X-Received: by 2002:a05:600c:4449:b0:421:4f71:6ed4 with SMTP id 5b1f17b1804b1-42164a207bemr16318865e9.26.1717748945051;
        Fri, 07 Jun 2024 01:29:05 -0700 (PDT)
Received: from [10.100.51.161] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2cd2d3sm45358385e9.41.2024.06.07.01.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 01:29:04 -0700 (PDT)
Message-ID: <8f5dca5a-330d-4258-8e01-0734ffda361d@suse.com>
Date: Fri, 7 Jun 2024 10:29:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ring-buffer: Fix a race between readers and resize
 checks
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-users <linux-rt-users@vger.kernel.org>
References: <20240517134008.24529-1-petr.pavlu@suse.com>
 <20240517134008.24529-3-petr.pavlu@suse.com>
 <20240520095037.33a7fde6@gandalf.local.home>
 <2b920bab-23a2-4a8d-95c2-b69472d38373@suse.com>
 <20240527194356.5078b56f@rorschach.local.home>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240527194356.5078b56f@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 01:43, Steven Rostedt wrote:
> On Mon, 27 May 2024 11:36:55 +0200
> Petr Pavlu <petr.pavlu@suse.com> wrote:
> 
>>>>  static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>>>>  {
>>>> @@ -2200,8 +2205,13 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
>>>>  		 */
>>>>  		synchronize_rcu();
>>>>  		for_each_buffer_cpu(buffer, cpu) {
>>>> +			unsigned long flags;
>>>> +
>>>>  			cpu_buffer = buffer->buffers[cpu];
>>>> +			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>>>>  			rb_check_pages(cpu_buffer);
>>>> +			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock,
>>>> +						   flags);  
>>>
>>> Putting my RT hat on, I really don't like the above fix. The
>>> rb_check_pages() iterates all subbuffers which makes the time interrupts
>>> are disabled non-deterministic.  
>>
>> I see, this applies also to the same rb_check_pages() validation invoked
>> from ring_buffer_read_finish().
>>
>>>
>>> Instead, I would rather have something where we disable readers while we do
>>> the check, and re-enable them.
>>>
>>> 			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>>> 			cpu_buffer->read_disabled++;
>>> 			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>>>
>>> // Also, don't put flags on a new line. We are allow to go 100 characters now.  
>>
>> Noted.
>>
>>>
>>>
>>>   			rb_check_pages(cpu_buffer);
>>> 			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>>> 			cpu_buffer->read_disabled--;
>>> 			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>>>
>>> Or something like that. Yes, that also requires creating a new
>>> "read_disabled" field in the ring_buffer_per_cpu code.  
>>
>> I think this would work but I'm personally not immediately sold on this
>> approach. If I understand the idea correctly, readers should then check
>> whether cpu_buffer->read_disabled is set and bail out with some error if
>> that is the case. The rb_check_pages() function is only a self-check
>> code and as such, I feel it doesn't justify disrupting readers with
>> a new error condition and adding more complex locking.
> 
> Honestly, this code was never made for more than one reader per
> cpu_buffer. I'm perfectly fine if all check_pages() causes other
> readers to the same per_cpu buffer to get -EBUSY.
> 
> Do you really see this being a problem? What use case is there for
> hitting the check_pages() and reading the same cpu buffer at the same
> time?

My main issue is with added complexity to check the new read_disabled
flag. The rb_check_pages() part is simple and you showed what to do. The
readers part is what I struggle with.

I think the read_disabled flag needs to be either checked once in
rb_get_reader_page() where the actual problem with making the list
temporarily inconsistent exists. Or alternatively, it can be checked by
direct or indirect users of rb_get_reader_page() just after they take
the reader_lock.

Looking at the final rb_get_reader_page() function, it currently always
returns a valid reader page unless the buffer doesn't contain any
additional entry or a serious problem is detected by RB_WARN_ON()
checks. This is simple to handle for callers, either they get a reader
page and can continue, or they stop.

Returning -EBUSY means that callers have a new case that they need to
decide what to do about. They need to propagate the error up the chain
or attempt to handle it. This involves ring-buffer functions
rb_advance_reader(), rb_buffer_peek(), ring_buffer_peek(),
ring_buffer_consume(), ring_buffer_read_page()
ring_buffer_map_get_reader() and their callers from other source files.

It is possible to handle this new case in these functions but I'm not
sure if adding this logic is justified. I feel I must have misunderstood
something how it should work?

I was further thinking about alternatives that would possibly provide
a less thorough check but have their complexity limited only to
rb_check_pages(). The already mentioned idea is to have the function to
look only at surrounding nodes where some change in the list occurred.

Another option could be to try traversing the whole list in smaller
parts and give up the reader_lock in between them. This would need some
care to make sure that the operation completes, e.g. the code would need
to bail out if it detects a change on cpu_buffer->pages_read.

Thanks,
Petr


