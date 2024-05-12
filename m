Return-Path: <linux-kernel+bounces-176930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2158C373A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CACB20E4E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E734B45BEF;
	Sun, 12 May 2024 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fh9xyVOl"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61640BF5
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715530170; cv=none; b=aVgYks5rwOw+qGYK2nx9MuTpJf9MiD6plbZMHyn08jR+AIfnGQcJxbPAUjONXyKgYfjflGqe3I9Zc41GY72SG31ktTEa0p8154OPKEs7ETHfN+A4SmyhCMrCgPPj+ZPF6hMKHs5B4qMzsX7k7oxtiuMvzvoV47R9Wxd747CtwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715530170; c=relaxed/simple;
	bh=yYPbKdVLK3KqBVezWJQgrH3PxS7gpCu36SsGnL1rAGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p81AMH1juc9PxGtJMPnmSNeSYna3lVFPWorr6+vKO3IVVBu6aYfcLk7SyzF2u1Z82o/XSXlL2+Zxix965OmzEVhzCy3mlKh6fw3VAJGN9P0JKV1Ru0au1cwQ8jwBKHZITyGulpj4u4E05Ap/hRcr0cOV0LIRfmXbM+AVzxyqVkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fh9xyVOl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a599c55055dso903246466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715530166; x=1716134966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mbkMcvIOlR39VVMi6Mj2FfAAerh3AUWOCxZbcMMDx30=;
        b=Fh9xyVOlMFTkVhELbR36sonWrO28ZVXptf17h/D0rye1Vd1LHS5MoxZhXbQVQPwfdc
         t719a9yZIaSDvYAUKnvPYnyKq/QKKd+4IWHLLnHRgwrkxSEyxwKTbcqbpNAKcKGqQOL3
         uyPXHFCalRHM30IlAb+5sTl+J2be2HLBjJhsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715530166; x=1716134966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbkMcvIOlR39VVMi6Mj2FfAAerh3AUWOCxZbcMMDx30=;
        b=vW3iVv9hEnnvw/PrBSsbbrIC7wdBsLsjPamN8DCnJi3xwMV1jjjK0Av920Pn12joy+
         m2Golqrqh153zw9RkLFZfP07b+GARgqPh4c3hMoAdeUlaiF0JrczFz0PgA7Lwe3XzctW
         cCV7uG0bIjtf/smaq3Xy7+J1dWyxurx0Q2C5fF6kv728qbW6/wnGIPoxuxwQAwjyX2MQ
         tUQNgNhqP+FbFBz1gwYpb5S2zzcobSgm7YJfa0vjDoWD98w8Vfirfg7vIVu27PX5XYZ2
         4+9VpLF5/m/Ywbd9vn/L//rHZ8oIwdvDMI7k8Q2vK6b0s3Pf4dgqaEFwsNzD/GubyclG
         ismw==
X-Forwarded-Encrypted: i=1; AJvYcCVqGwrBarL/JOIS3WB/V9fe82tWYRsP8jOC+9PYofqmGceQaxrTcg91pPw2d5PJmVIuXdW06Zxw0QERuRsr8SVG+smqkMq+aDC5fHoN
X-Gm-Message-State: AOJu0YxEbqPKO5GgD+IWt9a29eZMZusPEGgcH2wFeMR7TU3Sg7q5+WdK
	2p7SBRzLzOL6jRagFwCkMdMqz7y6b5TFUWWtD93kO39iTsqEeweme8QpKS51TeaLP79fmAv+fCj
	9lhQ=
X-Google-Smtp-Source: AGHT+IH0iR0aXDdhfxZZAh49DIW61bRst2eKF0JBShvVzIdQZp8z25l4rSEs8mayEXg89Um0RZ+m8A==
X-Received: by 2002:a17:907:7805:b0:a59:6f89:1af3 with SMTP id a640c23a62f3a-a5a2d6796b1mr430661766b.77.1715530166250;
        Sun, 12 May 2024 09:09:26 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1787c6b1sm471876566b.57.2024.05.12.09.09.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 09:09:26 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59a9d66a51so812769466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 09:09:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW31WuvnVUQ9x4SA3wM7UC1qQxLQU7UhveMdiqHa2tZV2hSVet90MWfYS69ccPIGsl6mubEqPltxcqppt4TkKaqXHe33C+usu/g8dFA
X-Received: by 2002:a17:906:7192:b0:a59:cdc9:6fe1 with SMTP id
 a640c23a62f3a-a5a2d55ef06mr502053766b.19.1715530164768; Sun, 12 May 2024
 09:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404291502.612E0A10@keescook> <CAHk-=wi5YPwWA8f5RAf_Hi8iL0NhGJeL6MN6UFWwRMY8L6UDvQ@mail.gmail.com>
 <202405081144.D5FCC44A@keescook> <CAHk-=wjeiGb1UxCy6Q8aif50C=wWDX9Pgp+WbZYrO72+B1f_QA@mail.gmail.com>
 <202405081354.B0A8194B3C@keescook> <CAHk-=wgoE5EkH+sQwi4KhRhCZizUxwZAnC=+9RbZcw7g6016LQ@mail.gmail.com>
 <59f731ab619673afec4956fce6832a1cd5324fb8.camel@tugraz.at>
In-Reply-To: <59f731ab619673afec4956fce6832a1cd5324fb8.camel@tugraz.at>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 12 May 2024 09:09:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjERv03yFU7-RUuqX1y89DYHcpdsuu++ako2nR41-EjYg@mail.gmail.com>
Message-ID: <CAHk-=wjERv03yFU7-RUuqX1y89DYHcpdsuu++ako2nR41-EjYg@mail.gmail.com>
Subject: Re: [RFC] Mitigating unexpected arithmetic overflow
To: Martin Uecker <uecker@tugraz.at>
Cc: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 12 May 2024 at 01:03, Martin Uecker <uecker@tugraz.at> wrote:
>
> But I guess it still could be smarter. Or does it have to be a
> sanitizer because compile-time will always have too many false
> positives?

Yes, there will be way too many false positives.

I'm pretty sure there will be a ton of "intentional positives" too,
where we do drop bits, but it's very much intentional. I think
somebody already mentioned the "store little endian" kind of things
where code like

        unsigned chat *p;
        u32 val;

        p[0] = val;
        p[1] = val >> 8;
        p[2] = val >> 16;
        p[3] = val >> 24;

kind of code is both traditional and correct, but obviously drops bits
very much intentionally on each of those assignments.

Now, obviously, in a perfect world the compiler would see the above as
"not really dropping bits", but that's not the world we live in.

So the whole "cast drops bits" is not easy to deal with.

In the case of the above kind of byte-wise behavior, I do think that
we could easily make the byte masking explicit, and so in *some* cases
it might actually be a good thing to just make these things more
explicit, and write it as

        p[0] = val & 0xff;
        p[1] = (val >> 8) & 0xff;
        ...

and the above doesn't make the source code worse: it arguably just
makes things more explicit both for humans and for the compiler, with
that explicit bitwise 'and' operation making it very clear that we're
just picking a particular set of bits out of the value.

But I do suspect the "implicit cast truncates value" is _so_ common
that it might be very very painful. Even with a run-time sanitizer
check.

And statically I think it's entirely a lost cause - it's literally
impossible to avoid in C. Why? Because there are no bitfield
variables, only fields in structures/unions, so if you pass a value
around as an argument, and then end up finally assigning it to a
bitfield, there was literally no way to pass that value around as the
"right type" originally. The final assignment *will* drop bits from a
static compiler standpoint.

                Linus

