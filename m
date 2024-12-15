Return-Path: <linux-kernel+bounces-446280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACE79F2224
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8000A7A10F9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66504BE46;
	Sun, 15 Dec 2024 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cPtigQQk"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310478C1F
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734235280; cv=none; b=fm7aW0EOBQZXhqJNaUQKOydRzBSWn7kIui1z6Cjiq61j47S8m6vuV4dpHqT+MIKL1ZzDos+zZFqJPAKY6h0JHijY/V+zmU7tlWCyqdTOgr2wxKlK1b2ldOpD7AbZOdHzeUYV6vPUjM1ROMlBtYuO9jRfpA1QtNbuQUuYmcdKXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734235280; c=relaxed/simple;
	bh=kyleIBe2tqdP/TV0r4GyxjPeVER12PM5hqPkoDNcCcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs4domeaMVZVPGGUi8j4Z3/l5wcqNujgyKPQvIJgD1NJGFPjZvP7Mo7SRdZafpzir+2HR8aVUpzN2Pc7JXQpuVGZf4IEXrM3+vTgm3EytGYerY3GINvRWWPYkiACoVXR0r4s58P6fvULmDu8VnY4IdjIpV4Ia3JFSWnucKjZ7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cPtigQQk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so5478455a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734235276; x=1734840076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aTsLFSZm5JQLdIQ2E1z/5I1HWqjAyZRS24rBnGXrhAI=;
        b=cPtigQQk6LlaTXQlePoGcYuc5VxKBqN6aR+aMm4MmJSGUMTsI7m6AnD0oCRpwkkrAy
         H9T46ZLt8scVjtx1zoOYt5hZ4dOpCzmL3caMQx5v7usQGvu4U+VhLfmx+AZX2mNbgWUi
         QI4nWPxtm0buoeK4iWdT72E5cF1B+jHyv+eLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734235276; x=1734840076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTsLFSZm5JQLdIQ2E1z/5I1HWqjAyZRS24rBnGXrhAI=;
        b=s+szfsrJljl4QrUUzbOAA9OvCXGmrsOt6Ff1mW6TjUZ0B1Ks4Ohjv3MIBWa+BSNjkN
         ItT8qm/XTE0H1pJuyDYRam3RcqNPTKAvZwQr17aYfjatYee6bf+VOrZWTQtzBTFr1Uu2
         zvPsefaWOedwqhvUTTnMoy3air16V1w3yLOn+mhWH6xO1/W968XmoY30IAHra57Ia2Jd
         4dP7npEYXp7LXQ4rfbGn2pkfY730OnNs5i07yv9YF+MIFFWz3UNUmGAN9Mg2VTnZ2Xdb
         IGGb8P11h+TTapWZzQFiXYk1rS3PUFBbj3B/YdSGbDp0WBVXC3A2lSUARDyYJoAcCM+E
         +AUA==
X-Gm-Message-State: AOJu0Yx4iDlerLSe0UsiWSO8/h+0vbsHRtxyULM4kdst65PX1LSrATrD
	RgRzorLXLrD9htxlr5pGOz34NjUlGQzCzXZ7Z+uIBtwMvx5SXHfuAItJrfRpY9mkWT+LwjeB1sc
	0mpA=
X-Gm-Gg: ASbGnctGqdoO/0uMmD9sAP1ps/nUjwFjZLMhbe4kC01Wl9vZJkKuoP36iLPC8UR25xR
	G38Yh9XRV28cbfegPsGl1q0Ss5j6xG/uOIz4hNFjXlBZfy9/it0ICmMf4XBn9cmwI9Np/Epbw79
	hF0tVnTza7oOzEwYt0UyE4TqGzlhE536xC11FntCIS3oK4xQ6ioYawdqYULauv0YemUvV3XjSAE
	GsDpkDpkr3kHK4sJ+RFjlneQOlHaPPGX84j8rezpauUeKpdL+UX/Hs8B2mqqtnTH4udPcBp6IS3
	EfRWR73E4sZoK1zelojWUmyG6uIpR/0=
X-Google-Smtp-Source: AGHT+IEOqvQDGZsnqGhbTfxHVu+rsvBy5Oo9BQP/Cyhx7MyourOXjbyHmZFlXtVl16r58Ppym2UYUw==
X-Received: by 2002:a05:6402:35ce:b0:5d0:cfb9:4132 with SMTP id 4fb4d7f45d1cf-5d63c33b728mr8129503a12.18.1734235276298;
        Sat, 14 Dec 2024 20:01:16 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ad187dsm1674407a12.28.2024.12.14.20.01.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Dec 2024 20:01:14 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so5478405a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 20:01:13 -0800 (PST)
X-Received: by 2002:a17:906:c142:b0:aa5:4672:663b with SMTP id
 a640c23a62f3a-aab77eaf931mr774912566b.55.1734235273281; Sat, 14 Dec 2024
 20:01:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241214182138.4e7984a2@batman.local.home> <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
 <20241214220403.03a8f5d0@gandalf.local.home>
In-Reply-To: <20241214220403.03a8f5d0@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Dec 2024 20:00:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whrxZwrdm2zHrTmEdRoiC_29XR+0nJpq2CkZjm-ZdOTNg@mail.gmail.com>
Message-ID: <CAHk-=whrxZwrdm2zHrTmEdRoiC_29XR+0nJpq2CkZjm-ZdOTNg@mail.gmail.com>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Dec 2024 at 19:03, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It gets set by the persistent ring buffer code, via a call to
> ring_buffer_last_boot_delta().

That seems entirely broken, since it basically depends on the kernel
being the same one. Which isn't even checked for.

Not to mention that it wouldn't work for modules anyway.

This kind of random hackery needs to DIE.

Tell people to turn of KASLR for cross-boot tracing. Or just not do it.

> > If "people use stale pointers for '%s' and we actually care" is a real
> > issue, we could very possibly teach vsnprintf() about that. The code
> > already has a "check_pointer()" thing for just NULL pointer magic
> > printouts.
>
> The check code was added because I was sick and tired of fixing bugs in
> trace events. People would use the TRACE_EVENT() TP_printk() like a normal
> printk with things like:
>
>   TP_fast_assign(
>       __entry->ipv6 = ptr_to_ipv6;
>   )
>
>   TP_printk("ipv6=%pI6", __entry->ipv6)

I think you are confused.

You are talking about the checks in test_event_printk(). That is fine
- that's a sanity check of the trace fmt string at trace event
registration time.

But that's not at all the code that the new "fix" is all about.

The new "fix" is for the disgusting horror that is
trace_check_vprintf(), which is the "I'll take the trace format
string, and I'll print it out partly using the regular vprintf()
machinery, but I'll partly dig into it and do horrendous things to
it".

And *THAT* is the disgusting code, and it only deals with '%s' (and
the odd symbol relocation case that I think is completely broken).

And the '%s' case we could at least partly handle in lib/vsprintf.c -
not the odd tracing special cases (that you might as well just handle
in test_event_printk()), but the "we can check that it doesn't fault".

           Linus

