Return-Path: <linux-kernel+bounces-420233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D888C9D779D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 20:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42376B2F094
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E3140E3C;
	Sun, 24 Nov 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H6G2n2Gi"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18232500AF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732472190; cv=none; b=PNKOBOF1GDTCme1EzbbO2jN2f3zeN9ZAiB6LHKzSiW5qfTjYjH+d0JOgf6YO76pveTOOmuERpclfXGHBFnsQxWCMvRRvP329f23ug2w7S2Pefx6bzP3q9imRhpOFk/DUEcSMchPCepPTFiAR2S2dWLau0ldSkg58uvDs8ryjfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732472190; c=relaxed/simple;
	bh=o4MjSo4mZwOargpNyRXKDM3WAx4EGKBua34HXhvV8V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cblsSDVee4JCAFqTwXw4fiyPe1hBoh/a9cqdr3vAYordEo2EwHKOlwiGrN/QUZI2mklSAr1NPvcCCiuWcGt/Xy+I/sSvtYVokxnMTxxPzxFjicYVZdZ8zOyUP4hyuFZql1eKbsmSc9k5Vkz6klfg/UGYtLMImw8DVvpFJc7wx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H6G2n2Gi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa543c4db92so113854866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732472187; x=1733076987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9nEvmX/RSuTdFkbcUkssWby2DmD3HY/Zsgoyaq7a18g=;
        b=H6G2n2Giqq46Pwuhsi9yoFEiOm2Nb534rrMwP3Nv6ItWmCL96dYAdFE1DkCBP2xJ/Y
         32/Dylu8HLRu0qETVmmWMdg8DiNiBqr6vsg0Y3RsnsV4Y/DsUQsoJv4wfOrZneBRF/SP
         GHy3vwDlT3GHF1JuQh42tQjHcBFFLfv7SrgBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732472187; x=1733076987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nEvmX/RSuTdFkbcUkssWby2DmD3HY/Zsgoyaq7a18g=;
        b=Ljh05lqFVFNwpAGANeDFMLc7dDAbXcxnRMmFEJpsIGnn8rCd4PByFsGszkVOEEkd8h
         avAKcDsl5n6Pmz0UC2tTcBy0Z2x/V2h2fDZdEbb+j/lTDSRC58IMRh14LAqk/ssGv//p
         aoObNZyMTzqQbUAKnqIMm0D0lGa2xucwa5WcHJnAMX1P1g9lin+IZ/a2Hf7tl6KjvMtF
         AAECopHPs+odpxKb4aCqbV/4ECDrbJF3GrhM63ipwkB+GnagXRuMkcxTnHEx7dDucME4
         BNLGUmKdmSTN0f3xv6HrfiecQeeqJGqjqKHENLIEz8LqqJHqpMfsllfZiH6fE3arj0Mx
         HAnA==
X-Forwarded-Encrypted: i=1; AJvYcCXeo17wU7doLBcRXRPcJjNGzyctS/F4Girc4Xhh9eY2q1XEnB7SH9cXSGJmVxehh1sMwTs0MFHa52W7qk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDM3E8mnhjsfttIBzRnNOmaBjPLbL1WHx++V6+oajiT28qlm2
	ziyZK7UaseGbLuReOr1xyuD+QufbFFvP7ed0rcYsyzEyO8T0dA6L+ItSoP+ziwdk0O+0Xg5KGyp
	ie9Y1vw==
X-Gm-Gg: ASbGnct9x3TNCayiSZJXjTYPxW8ovU1Pb5bTh+NYuN1LWxXQMHseJMLVrk5RYttE2wZ
	agpKxI09zExwtnfHQf8ePDR0fuIK40VoG5xDT72lOvarHbifUWqRJUNa/2ySOGSv6zRVwphD1Y0
	C3EJwJtcUJtiraGI978jBhmNFa6o7EpW1eCTFbN4/eyf5IRGOavtHJkbJpRuLpdr+XO9r/r4X1T
	BiLP9f2qAJ/yffsr20q7J7bC7FpzKmygTJ4pC0OC8hxOdv/B6M41MFvJiU2CTpWkTAkLPvrpjmo
	pIUCWkCCiELDw7QfQuIQtC80
X-Google-Smtp-Source: AGHT+IGFxFiXmFjr4813nlw99H7PPjjetltJZznt/7XBVRymL9uKcwOE3W8+SdAuxlVEIoTJDjnntg==
X-Received: by 2002:a17:906:32cc:b0:aa5:2e09:ff0f with SMTP id a640c23a62f3a-aa52e0a191cmr500969366b.37.1732472186766;
        Sun, 24 Nov 2024 10:16:26 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28f6b3sm373997666b.23.2024.11.24.10.16.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 10:16:25 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso292160666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:16:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjUzdCBvCuSHrisAkViiTjdTSMErtWoIkMfPFrgVpjbw8mRkOxC9ZS/fxdPEMmTZZ/H3mcDOwHUhal264=@vger.kernel.org
X-Received: by 2002:a17:906:3ca2:b0:aa5:1ef5:261e with SMTP id
 a640c23a62f3a-aa51ef5266fmr695134766b.17.1732472185004; Sun, 24 Nov 2024
 10:16:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730166635.git.jpoimboe@kernel.org> <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net> <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe> <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
 <20241121214011.iiup2fdwsys7hhts@jpoimboe> <CAHk-=wigHm2J4LkUL1=y_H8zGwM0JsK2CrWyLNbz9fvXfbaBQA@mail.gmail.com>
 <20241122001223.t4uywacusrplpefq@jpoimboe> <CAHk-=whm4fEYrzrrRrqEhELLFz2xNCMT9be+J0uiR_EwXwa0DA@mail.gmail.com>
 <20241122031115.5aasuktqrp2sidfj@jpoimboe> <CAHk-=wjJt49tgtmYv42bXU3h0Txb+mQZEOHseahA4EcK6s=BxA@mail.gmail.com>
 <CAHk-=wiL0TepguMNaR65ZdkkiBEoi4hTE7PwG3bBO1c5SOXmWw@mail.gmail.com>
 <CAHk-=wj4LHCiD8f75q-jf7mu7Jyn-wHgGoni6WSQtdh7+HtGNw@mail.gmail.com> <2d7744d7ce504b288c3f1356f27910ec@AcuMS.aculab.com>
In-Reply-To: <2d7744d7ce504b288c3f1356f27910ec@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 10:16:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCDMrjKc7foeV5zHRL_ioRZqqu-XKN5q9fN5NFCpgXZQ@mail.gmail.com>
Message-ID: <CAHk-=wgCDMrjKc7foeV5zHRL_ioRZqqu-XKN5q9fN5NFCpgXZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit __get_user()
To: David Laight <David.Laight@aculab.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Waiman Long <longman@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Mark Rutland <mark.rutland@arm.com>, "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 08:11, David Laight <David.Laight@aculab.com> wrote:
>
> Is there an 'unsafe_get_user_nofault()' that uses a trap handler
> that won't fault in a page?

Nope. I was thinking about the same thing, but we actually don't look
up the fault handler early - we only do it at failure time.

So the pagefault_disable() thus acts as the failure trigger that makes
us look up the fault handler. Without that, we'd never even check if
there's a exception note on the instruction.

> I'd also have thought that the trap handler for unsafe_get_user()
> would jump to the Efault label having already done user_access_end().
> But maybe it doesn't work out that way?

I actually at one point had a local version that did exactly that,
because it allowed us to avoid doing the user_access_end in the
exception path.

It got ugly. In particular, it gets really ugly for the
"copy_to/from_user()" case where we want to be byte-accurate, and a
64-bit access fails, and we go back to doing the last few accesses one
byte at a time.

See the exception table in arch/x86/lib/copy_user_64.S where it jumps
to .Lcopy_user_tail for an example of this.

Yes, yes, you could just do a "stac" again in the exception path to
undo the fact that the fault handler would have turned off user
accesses again...

But look at that copy_user_64 code again and you'll see that it's
actually a generic replacement for "rep movs" with fault handling, and
can be used for the "copy_from_kernel_nofault" cases too.

So I decided that it was just too ugly for words to have the fault
handler basically change the state of the faultee that way.

            Linus

