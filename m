Return-Path: <linux-kernel+bounces-450024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1EE9F597A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC27A1636E3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C881F8ADD;
	Tue, 17 Dec 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hKrjvHQJ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9372E1D9A63
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734474270; cv=none; b=gjMrPXZdoiWkjca68eQ7BSqlPVjutYg54hSHLXvUsa0JgmCvIP5U53pPG4Z38PeDH+UFOaH0drmwljL2nxko7OG4HVlylu4VTWRVAdAPKNyVs/sq12VAtT91/sczCX5TUKEiWjcJLgBvvqh8718hSn1jgbpvs6wzoleFTwYKk+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734474270; c=relaxed/simple;
	bh=tBC+aTX5XAIGgGHuDRt0Rt7ji1vMfYTw+73UoqI64Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PabCboekxbk/ACnxuy7QQJ3m6azizyGO6fQ/g2gV4JGoZKejanoMDJ+XgSp77FbzlucLyThDXw3MT7QecWqjyVzL0rHDt2QwFRzW95+z02R/X57xsXwrCwKpjYKf+1TYH5c/lO85z+QI4RQdI2VuUkOQXgDdJu2duFIcNvdjIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hKrjvHQJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa696d3901bso1120661666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734474267; x=1735079067; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CR25to9Z7LCRWh3Dep4GmmASyUYDd1JTk1/fy6GdpKA=;
        b=hKrjvHQJZ+4+FUBJpcN6qnuDBeJSczunP/1PeF3/k10kFxieOcRwaIF0Tmum+cs9Cj
         5Ase2V6dxp7997eXWN0b4yKM+vOunLCWWLehnl1T7jD3kf0EchoAFwLNDb5jP9DOOdyH
         bdwFDpMHh9Skv4lv4LYoNsTJB17p3wQJR2KwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734474267; x=1735079067;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CR25to9Z7LCRWh3Dep4GmmASyUYDd1JTk1/fy6GdpKA=;
        b=f0iVc21FRQUy/Uzw4yggMPMifGLUjDUCDgiRpxt91oCJNjTYe47ZyAhyL3w2EunnD5
         b2dHJm/bIazYu0elJhJyhv1xLSX27rcx7ifm/Mpif/YAKO78eEuHkQHqCRxrEgaHTvkb
         keePmoQhgLwcw4eIGNlShj9oO1UYL0dhv+a1Aq11jTI2bF5vZ+WdyX2nm+iF0J0r0c5k
         bt8pfUgURF9SiqkSejtJp+8fyve2RhM0hFNEVkO3UgUkl/IWgEyC37VduOVu4dXW6h+V
         tRy78ZqBwgoCIBQJEqO8bZnfneoWHdP0phEBPNskHnoCLnSMJ25LFasfpeQ/Q6wxMVjM
         1eWg==
X-Gm-Message-State: AOJu0YzyDPawqnLo4kYXg/1j62xEBiDa+o9YRvuWiKQLjoYy0vmmDDSw
	VxTl9u0aNJVoPjGe5IueIycpMPaWgeO+lqitWJlspBrVq1hyKtJovS8CSLEvM/Soltw417D6xsj
	x+4U=
X-Gm-Gg: ASbGnctQ5jFP/oTsHR2dMT+QSo2uiUfGD01moO5/Tz/9r8V0pdZLoulY8uOyql6Mwcm
	im7O3LXeFAOtbLpdCWwggX2jnv+HPbvLCa5+fJwz8pvKQhDzkmocz7Elu9aNMuV4N6/iAGDzC0W
	ZIJGXsCffdgVQS4W1gul20NgJSWf/wZkMfXlSrKgck/1+2JlYX4p3Xi2IWOPDoGpAAlOSGoqNKM
	xw4iHMnUpdiJXh4zXbX+eZ0elq3+P8oDdujS8USmEZsmGOlMShmOVVK5n5JIopKwpZEb2PwIk2U
	LvE4ysGHt7zEp7q19tE/qBnLft2esKw=
X-Google-Smtp-Source: AGHT+IGJ3qREkMQv4oA4Zg2ca/Cm3aOZXwTJCheXXk3cCqSWoVXKoSoXP30iLOKMumz/X8amYWjvOw==
X-Received: by 2002:a17:906:3151:b0:aa6:a572:49fd with SMTP id a640c23a62f3a-aabf49079damr32009666b.54.1734474266715;
        Tue, 17 Dec 2024 14:24:26 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96391366sm488919166b.167.2024.12.17.14.24.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 14:24:25 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa670ffe302so1077608866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:24:25 -0800 (PST)
X-Received: by 2002:a17:907:7f92:b0:aa6:bcc2:4da1 with SMTP id
 a640c23a62f3a-aabf46ff26emr33780366b.7.1734474265031; Tue, 17 Dec 2024
 14:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home> <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
 <20241217144411.2165f73b@gandalf.local.home>
In-Reply-To: <20241217144411.2165f73b@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 14:24:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
Message-ID: <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 11:43, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But this will be future work and not something for this merge window, as
> it's more of a feature. The only fix is to add that print_field() code, and
> the patch series that removes trace_check_vprintf() (which fixes a
> different bug).

Side note: I've also been looking at the core vsnprintf() code to see
if it could be cleanly extended to have callers give more control over
it. Some kind of callback mechanism for the pointer handling so that
there is *not* any need for crazy hackery.

That needs some basic cleanups I want to do and that I'm playing with,
but even with some of that code cleaned up it looks a bit nasty.

I really don't want to expose too much of the internals to the
outside, and vsnprintf() is actually fairly performance-critical, and
indirect calls have become so expensive that I really don't want to
introduce function pointers in there.

But I'll try to see if some more cleanups would make it at least
possible to have a separate version. That said, we already have the
disgusting "binary printf" code, used by bpf and tracing, and I'd hate
to introduce a *third* interface, particularly since the binary printf
code is already doing things wrong (it puts things into a "word
array", but instead of using a single word for char/short like the
normal C varargs code does, it packs them at actual byte/word
boundaries and adds padding etc).

So just looking at that code, I'm not hugely excited about adding yet
more copies of this and new interfaces in this area.

(Aside: are those binary buffers actually exported to user space (that
"u32 *bin_buf, size_t size" thing), or could we fix the binary printf
code to really use a whole word for char/short values? The difference
between '%hhd' and '%d' should be how it's printed out, not how the
data is accessed)

               Linus

