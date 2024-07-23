Return-Path: <linux-kernel+bounces-260405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0193A87F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66581C22A21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA3E14373A;
	Tue, 23 Jul 2024 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gd7NHDNQ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C349140384
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721768854; cv=none; b=hPws5rS27xRAcrrmwCmfMfawVceWuH9RhBUXy9+wsNG0JLb1CmMuTwiSRoGon3V2Oy73PXxOsb7XXsJC8Ylo9lgOHRq36Qph0yd0jBX2eUG0jWc/MliUiMMQxm0edB3klBajwEAu05+5BBoGEPitiDR+b/pjID/7eKyb5hiodtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721768854; c=relaxed/simple;
	bh=F7iLMW3rJLqXlZUzeoBPhqh75CjXvVXCPj8M/vQCtuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZajKhZnzKO5VsnshOJwvN33TwuyUwS1ciPU33etB5WdHvOVA8CPMctUQsoPEu6W5tp4aGmNofofH2GGpM6pQIMqWm5Jq6rl4WUsFnXPX49FZaPULj5E39TGbFYwnBN0dckER8r7nH0gbDJtwCd7B4MUE+rpsvVFWk6wD3eYqjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gd7NHDNQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52fc14d6689so2391210e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721768850; x=1722373650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=echzYBfPOzOcg9v7iQfcS5oYmvkbZgxPwE2bf82ps3o=;
        b=gd7NHDNQcji3UEnQMsviRDUFiRJOd6ml0g8KCc8NckzPzGZlExIrpWeGx9ihTCbvo1
         1C5HmfeKsh1uy3BtWcmztyvR5XUxCJBIJi09beL4vWmubC+XNeYT6vgu2WRUPmdlKj0d
         C+6V5ETmmUM8Z+uCtgvY4+GYEJqZ1npA0aA7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721768850; x=1722373650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=echzYBfPOzOcg9v7iQfcS5oYmvkbZgxPwE2bf82ps3o=;
        b=XFPtNLjpOlwQmrbpZoYYRlpuIvZSYYtHWhlEdqk3FQWJemxnN5RXFFyEXfrAVI4Nqw
         vOAdt995Op6gteyIt7iAnDK2bYOa70uMEYlqdyGZZRbdtfMBneqcsbwR6LBiu4pc6M3H
         1Cf16bZsOZdXHATfNihK7Ghc29tL83EWLRMsHNFNmhMh/72tHOEiD8ZkuPuCB385+VTd
         ituH6guX3s+kUMM4tAMlabgB4J5gLIi722MpjKxje4lOX19Y7NQull4ljPB+kpw4Q9kd
         KoVogTX7fBOH0LPi0XF0gWKDoGdIOTXYLYkBRdqvWyBua3dtHpCNisxXbvOUqsXYRtWY
         uY5g==
X-Forwarded-Encrypted: i=1; AJvYcCVJR4f+nXlggoTPs9/Cj/3+Ogw+bIA1wCMRCK+bnLJPtOEbe5+yyePnEAhv1SuABEoFxMCTNMP4kigESbweCdl2Hrz1X+I4LPgLSIfG
X-Gm-Message-State: AOJu0YzgSo3rJKqxO/FufRy92saP9NQMjklpi2pxa2XApGX4sS9Q51cC
	KIv7wYvG5/GnnXDkGAHWx25RIvIBtFmmYojE0edEdMY9PjsAC3Hmrdz9k+72jFgHrk2X6ttOIg1
	HzrTC5g==
X-Google-Smtp-Source: AGHT+IE3t2dSHNiyQdtY7NDy8pSsxcwDRNX4+RdRdJxwXTXAPjEjakJQb2i52f7WPjdgzBdncSWa4A==
X-Received: by 2002:a05:6512:1323:b0:52d:215b:9028 with SMTP id 2adb3069b0e04-52efb86de9dmr6571050e87.60.1721768850187;
        Tue, 23 Jul 2024 14:07:30 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fc2cb0ca5sm567836e87.292.2024.07.23.14.07.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 14:07:29 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso30971891fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:07:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9kaEK9KYRfQ9y+mA8yKlQOsUuGGg3kovZcgO0paTL6Am5JI+eSOd450dNn1ACLjryWFJbDCA/5vGEVoccqGXYLWfVJFeKhjUhJb5O
X-Received: by 2002:a05:651c:50d:b0:2ef:17f7:6e1d with SMTP id
 38308e7fff4ca-2ef17f76f31mr89418101fa.4.1721768848674; Tue, 23 Jul 2024
 14:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zp-_7R49fIHgIhaq@pathway.suse.cz> <CAHk-=whU_woFnFN-3Jv2hNCmwLg_fkrT42AWwxm-=Ha5BmNX4w@mail.gmail.com>
 <87ed7jvo2c.fsf@jogness.linutronix.de>
In-Reply-To: <87ed7jvo2c.fsf@jogness.linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 14:07:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+cxX2Sxc6RPBKkgYO67o2mdVfW6sQNMYc_x2QoP4LOQ@mail.gmail.com>
Message-ID: <CAHk-=wh+cxX2Sxc6RPBKkgYO67o2mdVfW6sQNMYc_x2QoP4LOQ@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 6.11
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 13:41, John Ogness <john.ogness@linutronix.de> wrote:
>
> Petr's pull request provides the functionality for a CPU to call
> printk() during emergencies so that each line only goes into the
> buffer. We also include a function to perform the flush at any time. As
> the series is implemented now, that flush happens after the warning is
> completely stored into the buffer. In cases where there is lots of data
> in the warning (such as in RCU stalls or lockdep splats), the flush
> happens after significant parts of the warning.

I really think the flushing needs to be *way* more aggressive for any
oops. The "flush at end" is not even remotely sane.

Some amount of buffering can make sense, eg when printing out the
regular register state over a few lines, there certainly shouldn't be
anything there that can cause problems.

Let me pick a very specific example of a common thing:

   int __die(const char *str, struct pt_regs *regs, long err)

in arch/x86/kernel/dumpstack.c.

Look, do I expect problems in "__die_header()"? No.

But the *moment* you call "notify_die()", you are now calling random
debug code. The register state NEEDS TO HAVE BEEN FLUSHED before this
point.

This is not something I'm willing to debate. Some of the most painful
debugging sessions I have *EVER* had have been due to "debug code that
failed".

Are these things rare? Yes they are. Very. Thankfully.

But the scars left behind by things like "buggy kgdb hook meant that
oops printout never happened at all when kgdb wasn't even enabled" and
having wasted literally *days* on something that would have been
obvious had the oops printout just happened means that I'm very much
in the "once bitten, twice shy" camp.

So that's why I absolutely *ABOHOR* that code in "oops_begin()" that
stops printouts until "oops_end()". It's *EXACTLY* the wrong thing to
do if there's some problem in the middle.

And yes, those problems have happened. Again - rarely, but it's *so*
painful when they do, that I refuse to pull something that I consider
to be this broken.

And yes, I'm convinced we have many other situations where a problem
during printout will silence things (the obvious one being locking
issues with the printing itself). But I refuse to have that silence be
an integral part of the die() code.

                 Linus

