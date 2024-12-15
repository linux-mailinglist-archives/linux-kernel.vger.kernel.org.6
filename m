Return-Path: <linux-kernel+bounces-446240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9499F219A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 01:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AFF1886875
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 00:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604CD1C27;
	Sun, 15 Dec 2024 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S3wCP1Sf"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99E36C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 00:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734223082; cv=none; b=U9+4+hUt25oYqOMuRkK/JmjM6aw2MulOxwAphro664Hh3Nmh4ITvPiDcr3JKwlU4YVC3jyvTpLU1hryYigKutHobS7Z8KfJWYI/dvJvYmJHxQWI1scRhk7w583ivgT5U0MHcXIbqV4G5ANhvHzg5F+iFUopgAInLbSfKYWwTOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734223082; c=relaxed/simple;
	bh=G2LKWQr1J6nfI88bqaGvpEmyXxeJu00LiqMMfKxVkRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmfBEjco6W+IwO6UC7GgrMUl7duTlZ/51Q+qzfIfHeE6JZFQvZnT4LjOaO5cEwXgIeHSzcR18+gw+umQSv+0zvnpS6quXE/D/+CMIf5TWRSCMXydW2ZuF8pA8aAF+FE+V39vvgs4eAhR+k8KLXbkwN6yGOiWoV/iIpOmGHjpW1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S3wCP1Sf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso5403691a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734223078; x=1734827878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lek2a64UVzeNy0p4/Sh+8fSGQa+3tUGdFQWLgqLbCoI=;
        b=S3wCP1SfKMxnuEY3w6peqn3Dp5g/AA67QYE33XqWR9a+XJBUU97SjIpgypHFJLQ1cS
         7+vpPFRqdJwRsGxmoloGD+7KNXAt18n4h9JOZcmIDngJkR2we5BZ/WfTQtPCuOVq8dup
         iS7ij9nDQSfrrBsuP0q/7dbDWTElkGdCMRP5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734223078; x=1734827878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lek2a64UVzeNy0p4/Sh+8fSGQa+3tUGdFQWLgqLbCoI=;
        b=LM7hPFVp4u9AVRcDAflpfICgVLdP/WA+xBdiA+BCfUMiSOI5SdhB2dDb284O0v3z75
         KedY734fOdjZxrZPgnGephjWbUHW0ZsA/9r4COom1XibTdX/hE23bKlI7UaxISJkGzn2
         6yuQTQ0PIoVSop9dnemHXuVV2lK+WK4tjdeTx9m2zQLjyoWSkZjvpPmh0kDhYR9SJy2A
         WWCdWXBdqtS9WGJNSoKQVE/7YF/SgguEakMHRPXhc14u2LxfJ17rXu4/hl/ogSDy/Kbh
         91VPgele5c9Oa3h2+gI9TB0KRyibC090IkqK1tgAIeDlclayxzAXnRkWPGuk/BO5DSzm
         bYDw==
X-Gm-Message-State: AOJu0Yz3OKGmmpk0GR5TTFtmJiHzUq4z4PFxMPkpSGbItcCcKXGff2QN
	nxKmynzkghomnhqcAzUXFJTEy+yvnVEzUAZudKc3hfbofk324RFmelnajAcVyUEHe1aNjE/7VdC
	ZR/0=
X-Gm-Gg: ASbGnctTe+QQ3ZniaMtX3garJWKlRK3LUACOhp8Molq9t6w7wbsg1+jIQPgK/Vn18g+
	PSIcTCctqzUu9AoGMrBjeCSsYDBzHM95Ve6PjbmojM62alxo7A8fFT4PzFPFqBBvu4EfeOP158I
	rsWplFCMkWMoDL0E2cYKMKkVWev/r3+OCXdIquk48953jepHharK5V5wF/gLkMokeDgrQiAqaXo
	rnR0fXaCK5fVcvjYl3U71AmpU9/M3Z8NRbeuxk1COS/McmaC7QDqTb2Jv+4y/oWnpoHQIX617zr
	sQN3UuPBKq+UCGtdNE7kZXbzvbjgNxE=
X-Google-Smtp-Source: AGHT+IGYlFRksiZqXgyupH84hhlbKxc4/G/f0gaDV5wGnltSqCm2zM794LonadSDutAB4N9kuhWyjw==
X-Received: by 2002:a17:906:7953:b0:aa6:a53a:f6c7 with SMTP id a640c23a62f3a-aab779ba4ebmr928516566b.31.1734223078502;
        Sat, 14 Dec 2024 16:37:58 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96068adfsm153015966b.63.2024.12.14.16.37.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 16:37:56 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa670ffe302so557195766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:37:56 -0800 (PST)
X-Received: by 2002:a17:907:1c14:b0:aa6:6d2b:cbeb with SMTP id
 a640c23a62f3a-aab779c146bmr683840566b.28.1734223075690; Sat, 14 Dec 2024
 16:37:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214182138.4e7984a2@batman.local.home>
In-Reply-To: <20241214182138.4e7984a2@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 16:37:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
Message-ID: <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 15:21, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Fix output of trace when hashing a pointer is disabled

Christ.

I'm looking at this, and my reaction is literally "tracing is doing
crazy things AGAIN".

This stuff is full of crazy special cases for things that should never
be done in the first place.

And - surprise surprise - it was buggy in odd ways as a result.

If I read the code right, this hacky code literally only catches stale
strings, but also has some *insane* code to do "text_delta" to
'%p[sS]' printouts.

And I see how it does that

                text_delta = iter->tr->text_delta;

but I don't actually see where 'text_delta' would ever actually get
set.  Where does tr->text_delta ever get set to anything but zero?

That code should be *removed*. It seems to be there entirely as a
sanity check, and when the sanity check itself is buggy, you don't try
to fix it, you remove the whole crazy garbage.

What makes '%s' so special in trace formats that it merits this
horrible hackery?

What makes 'text_delta' at all sane, never mind where it even gets set?

And why should we maintain that horrible hackery and make it worse?

This code shows a complete lack of taste. This needs extreme
crapectomy, not some alleged "fix".

If "people use stale pointers for '%s' and we actually care" is a real
issue, we could very possibly teach vsnprintf() about that. The code
already has a "check_pointer()" thing for just NULL pointer magic
printouts.

                  Linus

