Return-Path: <linux-kernel+bounces-205131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3858FF7DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001971C23BD8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8EC13DB92;
	Thu,  6 Jun 2024 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sa+gk6vi"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EED73444
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717714495; cv=none; b=DOZfrwA1ZodcaIGRN4DzzhoQlhovhdF4F5zF1Npq3db8reuDy9t88wGodIAuVHXCofn9PzZYDqfaOHCoajCzgXDBRH1v40tnM20IWGqtKGcXskgDfg9sEb1wfgos6IhMBsHbCrd94ug9r3M7U0aGHzHBgYHbV3n+bzbp+r+bmpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717714495; c=relaxed/simple;
	bh=Lxzlza9jgDlabck8CiE3qolZxkH8K8galjemXpD3Ebw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjiAv4PPsyNPOzmdQbOGGyPWlUMXX4USWGwAe4JJF9YnQHTR/ka1cAn5nJyezdYxA/nMLWdzHL5DKCapbgcYsj0RNLyQKt+QQeWiGB+2QP9cKepKTDYf3Z2+YCQf+2XDfpjA9B/YGrqGZn4vgnHH2fVZOLEQ0eFfdIGy1adTbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sa+gk6vi; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a2f27090aso4319809a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 15:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717714492; x=1718319292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OOpYWXQw4kPQwD9gtCB1CUuVHZCIELcU3LjU5EZ/aUg=;
        b=Sa+gk6vieT8XKw1qvyj+A2v9sO498haM6INq/ofzGzLFKpJD4eKULlmaXQVjd++UGo
         TTDe0t/aJkHUvM/af6c87Ipu1+jujeifKKWyxNa2vuHxSbTNOXuwqDrqDXgz7OOFdiQb
         DmoaWaXfHpLb8Uw7pB3J5lKo6Y/1Md4MiUBV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717714492; x=1718319292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOpYWXQw4kPQwD9gtCB1CUuVHZCIELcU3LjU5EZ/aUg=;
        b=qGO4kWMmfHb+FEVM03YV33eL88RT+je2epEKqVNqmBazqtJQ5yv9bJXpsCXjBZzY1a
         pyFoFYpBwbF6IoaNVsq84R0CYEWjDaZtRiRsMsT4sMmkUnGWD2i/1/61LOj91RHNR7VF
         0EJB2glAIAvgs9HGYxtfA6NXvEe0cNUapyMjEo9rmM2iFa6AXmykzkxV6ZupruJJFXBm
         7Niq9c9IKuk2p0DPWvvg+ZQEWllRw6cMZ028t6iR7IYVGN6guqjEoCeLrSoDoorVPUxG
         fwEZL1Q/vHYLpo2N/x9h78taxIYKs59BPyYHfU3FUpY9d22W6txDy5tMM4fynP0iWKoX
         yGTw==
X-Forwarded-Encrypted: i=1; AJvYcCXqjg8QVgG1GKMbcydVG3XMsK7PLYe5ZuTj6+P9mrO6NJDOjO/ugdyP4HcNS3yemO4yp2McjJv8U4ZHhGkB65qiIDwVsrVsGo9mWlrY
X-Gm-Message-State: AOJu0YzDxABUa/TESnvQuQ6X6kzufPadDt5/5mz8SHkGenyncHfKvVHd
	Z7T8xOhBZ2VZYad0jlCGQfAjhWymNyhWQH96touU05g3sWlPtj4W+yUe3En65gj6alKtdHJzfb5
	rRcA=
X-Google-Smtp-Source: AGHT+IGklQyEii12zY/j7GH6OUqC7/znfUYv4GjS/x5WZi7QabHyloziyyiSsQH2TmUwtxI7dyDWkg==
X-Received: by 2002:a50:9f29:0:b0:578:ac24:7f75 with SMTP id 4fb4d7f45d1cf-57c4e422c70mr758012a12.21.1717714491683;
        Thu, 06 Jun 2024 15:54:51 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae202396sm1768554a12.74.2024.06.06.15.54.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 15:54:51 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a68ca4d6545so274708666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 15:54:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhq+ffB39swLHJWGMgABL0CT95wX/Q84Mbn54al9rqraoWCNdHFbaWcKy2w4uHYvbkoO87LW3/HkqgIU4SjkyP0NzZkzBaa7yRDcm+
X-Received: by 2002:a17:906:f74c:b0:a68:c70b:5555 with SMTP id
 a640c23a62f3a-a6cba5cce0cmr78785566b.17.1717714490810; Thu, 06 Jun 2024
 15:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjHf6C_74VQPxmge-sMmu5yuhmNor1TaO0Uq--zrA13HA@mail.gmail.com>
 <20240606194525.cdnnidxurejsjtx4@treble> <CAHk-=wjdrJ1H7sbsaL8_bLvRmt26_io=5_b3k_g33kd+bwFHzA@mail.gmail.com>
 <20240606221856.g3iboxfkkgzp6sd3@treble>
In-Reply-To: <20240606221856.g3iboxfkkgzp6sd3@treble>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Jun 2024 15:54:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEcPQQ108RFw8Tk6oxfqcystVS94tRyVZCSczSBFMTDA@mail.gmail.com>
Message-ID: <CAHk-=wjEcPQQ108RFw8Tk6oxfqcystVS94tRyVZCSczSBFMTDA@mail.gmail.com>
Subject: Re: objtool query: section start/end symbols?
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 15:19, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
>
> The "key" idea was probably misguided.  I didn't mean to suggest to make
> it all complex like static branches/calls, I was just hoping there's a
> simple way to implement "static consts" without needing objtool.

I don't think you ever actually looked at the patch I pointed to, did you?

The patch already works. This all works without any objtool magic. See
here again:

   https://lore.kernel.org/all/CAHk-=whFSz=usMPHHGAQBnJRVAFfuH4gFHtgyLe0YET75zYRzA@mail.gmail.com/

but in that patch, look at this part:

        while (start < end) {
                unsigned long where, sym;

                where = start[0] + (unsigned long)(start+0);
                sym = start[1] + (unsigned long)(start+1);
                start += 2;

                if (sym != (unsigned long)addr)
                        continue;

where we traverse all the static constant uses (for the right size),
and where that 'sym' is the key that we then use to say "this is the
one I actually am modifying".

Is it complex? Not really.

But it's *unnecessary*.

It would be so nice to just have a "this is the start/end of the
section dedicated to this symbol".

In fact, the only use of that key is exactly that fixup code. It's
literally only used for matching the address of the "constant pool"
entry that we're replacing. So if we just had better link-time
information, all of this would just GoAway(tm).

Now, the part that really made me want this wasn't actually that
existing patch that has that one extra "match symbol address" thing,
but thinking about making the associated helpers cleaner.

In particular, this part:

        static_const_init(1, d_hash_shift);
        static_const_init(8, dentry_hashtable);

that initializes the constants has this very ugly hardcoded knowledge
about the particular bucket that those constants are in. And it was
when removing that magic "1" and "8" that I went "wouldn't it be nice
if I could look up the bucket data for this thing directly"

(Note that the 1/8 is *not* "sizeof()" the data - it's the
architecture-specific size, and it's combined using preprocessor '##'
magic into the right address).

And yes, I can fix this with some more wrapper magic when declaring
the variable. It's not going to be even remotely as nasty as static
calls, but some little objtool magic would obviate the need for all of
this.

> Aside from the idea of avoiding "magic", another small downside of using
> objtool is that isn't currently supported on most arches.

Honestly, I don't think that's a problem. If the requirement for
run-time constant support is objtool support, that's more than fine.

> So while I'm not yet necessarily conceding that objtool is really needed
> here, I could work up a quick objtool patch.  It would just be x86-only,
> is that ok for the time being?

Absolutely.

Yes, this kind of "section start/end" symbol would be possibly useful
as a generic feature across all architectures, but even as a
x86-specific one there are already other things that could use it and
not just the static constant hack.

We'd be able to simplify the x86 vmlinux.lds.S file - even if we
couldn't necessarily simplify the generic one. There are several cases
of exactly the same kind of "start/end of section symbols" in that
file, eg

    __x86_cpu_dev_start = .;
    *(.x86_cpu_dev.init)
    __x86_cpu_dev_end = .;

    __x86_intel_mid_dev_start = .;
    *(.x86_intel_mid_dev.init)
    __x86_intel_mid_dev_end = .;

    __retpoline_sites = .;
    *(.retpoline_sites)
    __retpoline_sites_end = .;

    __return_sites = .;
    *(.return_sites)
    __return_sites_end = .;

    __cfi_sites = .;
    *(.cfi_sites)
    __cfi_sites_end = .;

    __alt_instructions = .;
    *(.altinstructions)
    __alt_instructions_end = .;

    __apicdrivers = .;
    *(.apicdrivers);
    __apicdrivers_end = .;

just from a quick look. And yes, they could also just use the
BOUNDED_SECTION() macro we have for this pattern.

Imagine if we could just *not* touch that magical vmlinux.lds.S file
at all when we add some new random section for some random new use -
CPU bugs, firmware tables, things like that. And when we want the
beginning of the section, we'd just use a generic section name, like

   unsigned char __sec_apicdrivers_start[], __sec_apicdrivers_end[];

instead of those magic hardcoded ones that don't even have a pattern
(it looks like start/end is about a third of the cases, and
nothing/end is two thirds).

So my real point here is that this pattern isn't actually anything
unusual - and the only thing special about my static const patch is
that I don't have one single fixed section name, I have a "section
name pattern", which is why I'd like to automate it rather than list
them individually in the vmlinux.lds.S file.

Because yes, I considered just having another helper macro and then
just a "list each constant name in the vmlinux.lds.h file", and
decided that that would be just too ugly.

It's clearly what our *existing* usage pattern is. But I think we can
improve on it.

                Linus

