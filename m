Return-Path: <linux-kernel+bounces-532493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D308A44E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2612D1885566
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F5E20E31E;
	Tue, 25 Feb 2025 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="lzaH+gN1"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9018C32C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518048; cv=none; b=j0TfD/upHMkJrNI8JaJ1QLBlYA8xnMnuTDilK0oQ+7MkRJBjph3tTbPwsbpjjMqQIKSpKdNKcc4Q2ShiIpnAqx8U+A8Pu8cbJ65+OsL96BYYAWVIt24jEYRD1wEg2JEovDHsqDA1Lex0hEuY4+NUFrdDlYoRHT3OJnJUN9nF8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518048; c=relaxed/simple;
	bh=UwV8tIzQ/kkRrMjPobHsQMREbEg8Jr5i7VKUMg0xJ4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfPKgbBqBhcJXVDK82SUg55r/Iog+DASoRbh0Kew9ZuIOhhwdhKV9Kjhwy40Uif3MA8qES5EzvWihSSQ8j4NVnAoekOssxBaP3OTB7BGkRn7WCUJQk2xBInIWfNMidwXZGmqfD+13Opk9TktgT/tyQo28QuTMNNYuzxyVxY65fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=lzaH+gN1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f378498c9so5999919f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1740518044; x=1741122844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UwV8tIzQ/kkRrMjPobHsQMREbEg8Jr5i7VKUMg0xJ4Y=;
        b=lzaH+gN1ASLshUcCBHVeGevBy3OqSuPe0MZnCsAHpEbSeia62WOWUvZ9CJ2hzE4BkP
         f5HTlMyfY0AFmwNnCHi+deQ0ltNyI4iUl+WbZRkhNacTUPkTYB8FZeKASMXjnS2N/QT1
         VnaPcTuhQJ7bw8s4tlOHFGKHk1X0VXgHqP65I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518044; x=1741122844;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwV8tIzQ/kkRrMjPobHsQMREbEg8Jr5i7VKUMg0xJ4Y=;
        b=vEVuwYff/LaUYakDqlR5yUNt/xqo91peihHBoW+W9l89o+cxB7kMhG0IvPPB2KZaGf
         lPATVhZcqzuxd+kCLuhoe9RUJyo7kILgbgmnI8LpAn39ugzkUMGMrbTkloVY8FfB+yJk
         nC00H4xJptwgvcJbsdUVDnBJ8IZnqIiIs54NY+0enKa8PcRdDxI/31zMV2YwKhHy71Dk
         CEChBCy8XoJmYi+mmsX7k5cXt4fV3KUzjQq+WB9iRi5w9XZP9HLP7onslCLqyw5s2I7s
         pyWeiTh+QszgmQ6RdLHA1qraMDg7si2gyXscCR+1UraKRFUL0+dq7T8T2gFJySdnBX48
         5Ohg==
X-Forwarded-Encrypted: i=1; AJvYcCUernKyi2eisWzj2Oiaw3oMmU5gLoaSAVoTJaUBOwToj9UgTvd7scyj1KeGE3MZ61h2OwBo2WWtpT/mr9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgwR1jBpRLpTPr5hgg+ugHvM0zznfRQnBI4ORaaicpEi+35Bk
	WgYwj9aZyEG8Ubu+wjqoFZituOyluOVIC/3o0isHz6RcE40lWir1HOnE82NAAEY=
X-Gm-Gg: ASbGncsaNR2uEL5jqm6xG4CP3EkpeH05cMxPfU3KZw5q3U/4dADpbhci4woo/gOHAO1
	a20/LApQNzHzvWqM3Fvt1r+qkmSw74RK4ZCWWMpCYmv4Do27YRgZHsqmESHG1EsDy6ZHCKCebMo
	aSyNMWRzhpYi2RZ0mzzC2NP3M8QCvAXmu1k8xEqQzbihnxXrak57OJyk1NgGWPWmUFK3zDkciT+
	BXC/iKrT06QOcp78inXIfnic6C4bhB9twMhIHgS/Swv7FLovUVLfdnVdv6dPT3sUjC3IAFj0uKv
	1dq0AUQN7aXtjCQKomfTUD2MYjh1tW/ATTYz53WS3M7sY9bUO14eDp7G/aoA7/9V/A==
X-Google-Smtp-Source: AGHT+IEWYxKQ9QzWVT7ZqwAXeMq2j4PIhd0iSWqTf6Pa3b6xmSis2v9Yhrtwfjpn04n1UI19T4mkGQ==
X-Received: by 2002:a05:6000:178e:b0:38f:3ee0:7026 with SMTP id ffacd0b85a97d-390cc605060mr4692130f8f.22.1740518044362;
        Tue, 25 Feb 2025 13:14:04 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm178165e9.9.2025.02.25.13.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 13:14:03 -0800 (PST)
Message-ID: <8b82b394-3f54-437b-bd3a-7ac0eabda687@citrix.com>
Date: Tue, 25 Feb 2025 21:14:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Rudolf Marek <r.marek@assembler.cz>, Jann Horn <jannh@google.com>
Cc: jmill@asu.edu, joao@overdrivepizza.com, luto@kernel.org,
 samitolvanen@google.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 linux-hardening@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 x86 maintainers <x86@kernel.org>
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
 <CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com>
 <1cf8d5a5-bf3e-4667-bc6a-d1b1d662d822@citrix.com>
 <e46ca730-8858-4f57-bdd0-2fd0db086500@assembler.cz>
 <fa66e2f1-4770-45f5-aa4d-1a0ebec8a912@citrix.com>
 <d50dac43-51da-4b18-9fab-214896bdc9a5@assembler.cz>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <d50dac43-51da-4b18-9fab-214896bdc9a5@assembler.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/02/2025 8:06 pm, Rudolf Marek wrote:
> Hi Andrew,
>
> Dne 25. 02. 25 v 19:10 Andrew Cooper napsal(a):
>> Very cunning.  Yes it does, but the state needs to be safe to IRET back
>> to, and ...
>
> ... And intellectually very pleasing!
>
>>> Would it work to have KERNEL_CS as last entry in the GDT table?
>>> Therefore executing SYSCALL would set the CS as usual,
>>> but the numeric value of SS selector would be larger than GDT limit?
>>
>> ... this isn't safe.  Any exception/interrupt will yield #SS when trying
>> to load an out-of-limit %ss.> i.e. a wrongly-timed NMI will take out
>> the system with a very bizarre
>> looking oops.
>
> Hmm I was hoping that "the reader" will perform this NMI/#MC exercise :)

As stand-in for "the reader", I'll point out that you need to add #DB to
that list or you're in for a rude surprise when running the x86 selftests.

>
> The SYSCALL/SYSENTER startup has interrupts disabled, so it is the
> problem of NMI/#MC
> handler which would need deal with the normal case and attack case.

Right, but in the case of the attack, regular interrupts are most likely
enabled too.  And writing this has just caused me to realise a
yet-more-fun case.

An interrupt hitting the syscall entry path (prior to SWAPGS) will cause
the interrupt handler's CPL check and conditional SWAPGS to do the wrong
thing and switch onto the user GS base too.  (Prior research e.g.
GhostRace has shown how to get an hrtimer to reliably hit an instruction
boundary.)

i.e. you'd need paranoid_entry on every vector, not just the IST ones.

>
> It would need to check if it was executing that critical part of
> syscall64 entry
> from endbr64 to checkselector section, and if yes, the saved %ss needs
> to be
> "impossible" one. If it isn't -> panic.
>
> For non-attack case it just needs to forward RIP after the check...
>
>> You can do this in a less fatal way by e.g. having in-GDT form have a
>> segment limit, but any exception/interrupt will resync the out-of-sync
>> state, and break detection.  Also it would make the segment unusable for
>> compatibility userspace, where the limit would take effect.
>
> Yeah couldn't figure out what else could work "vice-versa" :(
>  
>> Finally, while this potentially gives us an option for SYSCALL and maybe
>> SYSENTER, it doesn't help with any of the main IDT entrypoints which can
>> also be attacked.
>
> I see, sorry I wasn't aware of this. But if I recall correctly only
> "paranoid"
> IDT entries do something with swapgs. But is there also some stack
> pivot where
> it would depend on GS? Or is it somewhat unrelated issue, that you
> might just
> redirect to "any endbr64" which are IDT entrypoints?
>
> Maybe you can share some details of how the attack would work in this
> case,
> or point me somewhere where I can read about it.
>
> If it is "any endbr64" case, would it work to just do "sanity check"
> of the exception stackframe?

The problem is type confusion.  Because ENDBR marks both the regular
function callees, and the system entrypoints (256*IDT + 2*SYSCALL +
SYSENTER), a function pointer corrupted to refer to a system entrypoint
will pass the CET-IBT check and not yield #CP.

All entrypoints then conditionally (IDT) or unconditionally
(SYSCALL/SYSENTER) SWAPGS.  For the attack case, this switches back onto
the user gs base.

Interrupts and exceptions look at %cs in the IRET frame to judge whether
to SWAPGS or not (and this is one of the main things that paranoid_entry
does differently).  In the case of the attack, there's no IRET frame
pushed on the stack and the read of %cs is out-of-bounds, most likely
the stack frame of the function which followed the corrupt function pointer.

The SYSCALL entrypoint is simply the easiest to pivot on, but all can be
attacked in this manner.  Fixing only the SYSCALL entrypoint doesn't
improve things much.

Peter Zijlstra has added a FineIBT=paranoid mode which performs the hash
check ahead of calling the function pointer, which ought to mitigate
this but at even higher overhead.

~Andrew

