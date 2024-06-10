Return-Path: <linux-kernel+bounces-208723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C589902883
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E51C1C22CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC0C14A0A0;
	Mon, 10 Jun 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AbOR1fBL"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11DA15A8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718043643; cv=none; b=O5Xt6Pj/WZsjZ+PoP1ir/legdsLyEcE1iRA5ni4O09P9FBRxykWwblWuf1NznL4RVWoK5WZCzVi2OLb0RcpT4QoHJI2zopwBE17FLYOZxDp7ITK/Yd0G99YTh50jMgKqV7qwcirxvL+n9KrMKHREyDAwcS5oQuY6f3ltBwLpnhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718043643; c=relaxed/simple;
	bh=YdPpztgDQSSz/ui84/o+Jq7wpxjYCYfXyvlmA14OBXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FkcbK/BNdDbIeMZBrF1+zfqdwBeWj7VwaCh2vmMPI+k48GCtWJYMfqIhQj7RflKds7R0T1KLt+3+8ty9VvmCvaEByMJwX5XprZYZVZ2nL1xE5vT6dnRV8QjRAj88wYi1i6yaXz8s5n7PQWTkEFhGna1G7io9+EplXcEpB0rEiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AbOR1fBL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c6994e2f1so1626171a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718043640; x=1718648440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aYJqDCT/kt+Lupsq+l10eN+h11oxsZOu7xdU28kZFKE=;
        b=AbOR1fBLkcltJ8xXLPJvh/K4pdJWAy+W0eqvPVnXe/CFhRnpDQxpg/i0oX8XuxPIQS
         0029h2RTYILDjqAgfp140YevEmouo+3K+vRlVM/D2u5bK0C227j5mjQwETFp3aX4E7mE
         9+QWP2Xiklc7Z9ICYFBej0Y2L/vManj4owiPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718043640; x=1718648440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYJqDCT/kt+Lupsq+l10eN+h11oxsZOu7xdU28kZFKE=;
        b=q/xkpFO7JVOkUdr4q5IKFw2Uy8SMt5yGszA+zVt9PwROcrrgjrqXMPdCplG7MfyeEx
         QxI89cGGFlBDsLuftvFEkwlKEWnetL6oMOruRQ8OITXOUroZBP2Cvx9FEGaSljZ6VyAU
         Q6N4W1e1cUGbmklTRIDfgywjHERvaegi3r/TiwV7QFBH3saKyGR6mOi2DewvhEXLXiJs
         Y5TSqBExaF7S7d8a+YGl8weBMDOCoaexrreuKBJkXUq63r77W/EV0viDU3f584hYqKEm
         JenEzFlNon6JQTzFHfLo9fzhEhRWdAmW89KTs11bJjPStVrOdJKq2arFnctQJXY6CFNz
         Pi4A==
X-Forwarded-Encrypted: i=1; AJvYcCWPx1ryGQ4rVWnwS/6ekn1HZOAD3C6NsetrorD+hl4U9/ggG0CUyhLKfmAw4uo2oFoP+LW60haSd3/AGY/lJxzU/xvZvgihjhOaSXqk
X-Gm-Message-State: AOJu0YzYnNkAfupISBAEPPM3hu2l/WxPy/46gCKplZcFQlrGoweA985O
	qMdC/MrPA+BbBDkg8gI4sWwmQFA40EKTDwgzCCpnMfgG8wiacvZ7Ek1GDF27p635J9Q77gCpMk3
	Cu7E=
X-Google-Smtp-Source: AGHT+IEEeeLKlcR1yFz2slwic8MUdLRMqw8VSMr7sKsZmeTYOdzpSKzXv4XvOg/c/BV+JhmP/Y7U7A==
X-Received: by 2002:a50:c2da:0:b0:57c:7c44:74df with SMTP id 4fb4d7f45d1cf-57c7c447531mr3404673a12.29.1718043639624;
        Mon, 10 Jun 2024 11:20:39 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c866a3d50sm1498613a12.77.2024.06.10.11.20.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 11:20:39 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a5bcfb2d3so3366475a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:20:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7DI6mNkQ/S3uaIEb2SlmM8iphoUC/zOTpDWCN+PDO27xVP70Yo6XhZV9EIrbPs0fbXCnP//L+qSpwEJ29+Y28RgDyta6EmU7f915r
X-Received: by 2002:a50:ab59:0:b0:57c:5f77:1136 with SMTP id
 4fb4d7f45d1cf-57c5f7711f5mr6877211a12.24.1718043638768; Mon, 10 Jun 2024
 11:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net> <20240610120201.GAZmbrOYmcA21kD8NB@fat_crate.local>
In-Reply-To: <20240610120201.GAZmbrOYmcA21kD8NB@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jun 2024 11:20:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com>
Message-ID: <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 05:02, Borislav Petkov <bp@alien8.de> wrote:
>
> I think we should accept patches using this only when there really is
> a good, perf reason for doing so. Not "I wanna use this fance shite in
> my new driver just because...".

Absolutely.

So for example, if the code could possibly be a module, it's never
going to be able to use runtime constants.

If the code doesn't show up as "noticeable percentage of kernel time
on real loads", it will not be a valid use for runtime constants.

The reason I did __d_lookup_rcu() is that I have optimized that
function to hell and back before, and it *still* showed up at 14% of
kernel time on my "empty kernel build" benchmark. And the constant
load was a noticeable - but not dominant - part of that.

And yes, it shows up that high because it's all D$ misses, and the
machine I tested on has more CPU cores than cache, so it's all kinds
of broken. But the point ends up being that __d_lookup_rcu() is just
very very hot on loads that just do a lot of 'stat()' calls (and such
loads exist and aren't just microbenchmarks).

I have other functions I see in the 5%+ range of kernel overhead on
real machines, but they tend to be things like clear_page(), which is
another kind of issue entirely.

And yes, the benchmarks I run are odd ("why would anybody care about
an empty kernel build?") but somewhat real to me (since I do builds
between every pull even when they just change a couple of files).

And yes, to actually even see anything else than the CPU security
issues on x86, you need to build without debug support, and without
retpolines etc. So my profiles are "fake" in that sense, because they
are the best case profiles without a lot of the horror that people
enable.

Others will have other real benchmarks, which is why I do think we'd
end up with more uses of this. But I would expect a handful, not
"hundreds".

I could imagine some runtime constant in the core networking socket
code, for example. Or in some scheduler thing. Or kernel entry code.

But not ever in a driver or a filesystem, for example. Once you've
gotten that far off the core code path, the "load a variable" overhead
just isn't relevant any more.

                Linus

