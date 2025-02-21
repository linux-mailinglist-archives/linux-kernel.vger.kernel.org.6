Return-Path: <linux-kernel+bounces-526410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75072A3FE53
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5C81692DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37ED252912;
	Fri, 21 Feb 2025 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IERHLh9k"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF122528E4
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740161286; cv=none; b=GcG0bZHiJuJyFtJ4Z8+e2XJ0TqN1zix4qIDONbUU2IFLVuBv+/9uIaYO+g9DAlNxs5saXdB8IsvdItU5rIWcUqutvkdxZj+mflzrC9H3/2T4moYhQidsoUJjvmf4PADWBLn7x79RJ53Hd4RBXp7p7Y5/7KlUEidUA7JkeWBNYNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740161286; c=relaxed/simple;
	bh=EAsGt2EqyVTOElAZitReGYYY5iRcKkQxdM7stcUnkZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kW2GE8Rr4YYUKaRpZvCKKPN0oJMAeUsfhJG06w9CtePgq5mpdvTmTxPFCIb+VEH+JqSFrn0tHPaRB+VSy1f2cUOpVBWKplBr2GasWPLxQ9KrcxlfCfJ1C02utxobz/CE/MfVN3n46/D12lsmTlgsdLjTIpOYud5QUmYuaXd9dwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IERHLh9k; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e08064b4ddso3380505a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740161282; x=1740766082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0AG1owJnX9rC5c7qxcIfiTiPqKW23h3ZpuLUTgVKvNY=;
        b=IERHLh9k4pX8Xq7TKJK3Z1UL2bgfXYOUD8gbBwULogezupFvaNqY3WXvL+HZw0VzpZ
         VakL5ExA7hTD/OyUqFrQp6h1A+KtL94Pn9ocbp2tGE/M/B3wF2G1RGDfo+sYGnvHy4ED
         EN72ZmH3RFE0lXubzrv2wbd7lMElnEsDPnxNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740161282; x=1740766082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AG1owJnX9rC5c7qxcIfiTiPqKW23h3ZpuLUTgVKvNY=;
        b=AMxpnaaqJ0LOWP1v5z59foxgx+Da6Cn2Wj1x5cb9Ohrftpufobly6118+LGRhA19Dz
         zsIEB+8DFBkp/tpTvGcRKIZp0cOMleaNdwPJB7v5h/m8rRBmx6+pgqFb7PosSe9B74ww
         GUeWQYUsNTZ3y4XehmCKBFSDMcGg8m570pWqgC9roxr2GDzw4ivl02HQ/VipjmxlKDKv
         gcLE6cU6KPBzg//7BrJtwzK9g5gq/JBoN21aqbogYpnwaPVEIBJOMrlaIdO7/k+LIGlO
         WRn3cqCfRt/oaGUeaQt82wHHlO8D/JjJN+UbQ7o4eCRqJikaFMmLTp0PHPZ/l1ZP9o8p
         2IjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMb2DyXWxaAsfETw0FRGVwocTYOSjVD5tiXCtGVuaWwwKMWpTyWj9au2DokCkWx609pRYk1zWywFaDhJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyQfIaTM9Rgw70a772+1uFcjA8FfRJY88rPbuso6WpW7YxWI8
	Pmo7X9ptq3/sLb11P5WVR1yZVUIpKZxE4d8lPeRnRwYQ2oVk7dLhA1eVqNgrKX6KpI1v3OIWxj3
	xCXc=
X-Gm-Gg: ASbGncvTon56i6LUJP/CA/WECejVf/1xbcjmHnnKHDJ7SwrOx3KmO72JOwalk1ZEbKG
	fUENWVasm+1lO/dZHjDZRTU+oFxtRlmAMxzkVRP03ylSUSIX7rOAixbDvCiioptherLc0a13J8I
	rcBzmvEAnR3tnP1ilQLeLlsatGb2JYnv/26QOBTCro1PEUVAtyDt2ZYntBV47Gm9FIwu3cDuClk
	gZJrKpAvyqLasnwzn/U8CeILfacjZWYHwdhOC4w7skK6aI3Iox1heboWc7lzHvVyhk6SDYa/mXu
	CashbKLs6c/Xq/rnTXN0lq6zeP+28/uJmGe7Nnp55gb5ahZ6SYL9otUd1SzkHee+H6mIJqZ6Ffo
	/
X-Google-Smtp-Source: AGHT+IG1U6OEzyqhIvpj9Tlbr4gbgRESvGRo/qXg0mq61RGKDq9GtMPMh+Rzvr/7UGqrI3/qWsvXsQ==
X-Received: by 2002:a17:907:7285:b0:ab6:f06b:4a26 with SMTP id a640c23a62f3a-abc0da33bf1mr461223866b.34.1740161281815;
        Fri, 21 Feb 2025 10:08:01 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm1148455066b.174.2025.02.21.10.08.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 10:08:00 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso367689966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:08:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7noK3lzCGJbNKJpbKQdaxRFI4h0R7Obrxbu/uC+3DgP7yfQyQVGH2Aoj+j6IVlx23nYd4Pae0EnsDng8=@vger.kernel.org
X-Received: by 2002:a17:907:7eaa:b0:ab7:5fcd:d4d9 with SMTP id
 a640c23a62f3a-abc0de0e4d6mr364513766b.43.1740161280179; Fri, 21 Feb 2025
 10:08:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh> <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
 <2025022024-blooper-rippling-2667@gregkh> <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
 <2025022042-jot-favored-e755@gregkh> <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
 <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain> <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
 <20250221124304.5dec31b2@gandalf.local.home>
In-Reply-To: <20250221124304.5dec31b2@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 21 Feb 2025 10:07:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
X-Gm-Features: AWEUYZmQJ76LofvaADGYz9wDxturcIzFXn8JOYMJIs8qre83YpKfkEfOvP9lwxA
Message-ID: <CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Uecker <uecker@tugraz.at>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 09:42, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Because they are arcane and even the gcc documentation recommends avoiding
> them.
>
>  "Note that in general we do not recommend the use of pragmas"
>  https://gcc.gnu.org/onlinedocs/gcc/Pragmas.html

Yeah, #pragma is complete garbage and should never be used. It's a
fundamentally broken feature because it doesn't work AT ALL with a
very core piece of C infrastructure: the pre-processor.

Now, we all hopefully know that the C pre-processor is the _real_
fundamental problem here in how limited it is, but it is what it is.
Given the fact of how weak C pre-processing is, adding a feature like
#pragma was a complete failure.

So gcc - and other compilers - have figured out alternatives to pragma
that actually work within the context of the C pre-processor. The main
one tends to be to use __attribute__(()) to give magical extra
context.

Yes, yes, some kernel code ends up still using pragmas (typically
"#pragma pack()"), but in almost every case I've seen it's because
that code comes from some external project.

We do have a small handful of "disable this compiler warning" uses,
which isn't pretty but when there aren't any alternatives it can be
the best that can be done.

But *nobody* should design anything new around that horrendously broken concept.

> Actually, I would be perfectly fine with fixing all locations that have
> x < 0 where x is unsigned, even if it's in a macro or something. Those
> could be changed to:
>
>        if ((signed)x < 0 || x >= 10) {
>
> If they want to allow unsigned compares.

Absolutely #%^$ing not!

That's literally the whole REASON that broken warning is disabled -
people making the above kinds of incorrect and stupid changes to code
that

 (a) makes the code harder to read

and

 (b) BREAKS THE CODE AND CAUSES BUGS

adding that cast to "(signed)" is literally a bug. It's complete
garbage. It's unbelievable crap. You literally just truncated things
to a 32-bit integer and may have changed the test in fundamental ways.

Sure, if the *other* part of the comparison is comparing against "10"
it happens to be safe. But the keyword here really is "happens". It's
not safe in general.

The other "solution" I've seen to the warning is to remove the "< 0"
check entirely, which is ALSO unbelievable garbage, because the sign
of 'x' may not be at all obvious, and may in fact depend on config
options or target architecture details.

So removing the "< 0" comparison is a literal bug waiting to happen.
And adding a cast is even worse.

The *only* valid model is to say "the warning is fundamentally wrong".
Seriously. Which is why the kernel does that. Because I'm not stupid.

Which is why that warning HAS TO BE DISABLED. The warning literally
causes bugs. It's not a safety net - it's the literal reverse of a
safety net that encourages bad code, or leaving out good checks.

The thing is, a compiler that complains about

         if (x < 0 || x >= 10) {

is simply PURE GARBAGE. That warning does not "help" anything. It's
not a safety thing. It's literally only a "this copmpiler is shit"
thing.

And arguing that us disabling that warning is somehow relevant to
other safety measures is either intellectually dishonest ("I'm making
up shit knowing that it's shit") or a sign of not understanding how
bad that warning is, and how

This is non-negotiable. Anybody who thinks that a compiler is valid
warning about

         if (x < 0 || x >= 10) {

just because 'x' may in some cases be an unsigned entity is not worth
even discussing with.

Educate yourself. The "unsigned smaller than 0" warning is not valid.

             Linus

