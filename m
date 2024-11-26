Return-Path: <linux-kernel+bounces-422705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 444079D9D36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A30B25AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A30C1DD9AB;
	Tue, 26 Nov 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PGbdgczg"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD981DC1BD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732644845; cv=none; b=sj/CYb+4mC0GX/XTPfTjpL8loGSmWYKOnGpEUCbtZl+78G074vNPrC+1Pa9OuhLQJqyTOpiQYL1Fqa0xkzW+Z+UtKjaq3JHO4F4m2R9H35WwGQFaM/r4F5vBz2B4MidFw2lzTo1GhllpTLJ9ZZ/9VzIaPNv1YBVYRehPvVA5L/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732644845; c=relaxed/simple;
	bh=4wpJhlYdPmaupiMAB3djRyWBKlzCNM61MqWp9mDP/DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6oGCQYTHg2KbWchtEHdKvRJn0C6PZYB9b6MD2xr5N6ckC5D+QQ1wGT31rm1gWUKJ4hi58dUZInBccO2UxYec5R6c/ZVpeX/M31mnAuj2waGnvs40dNrke1dTn4XbGZXA6GOqiYrjtPaks6LqY1XhjeUwXv5jkjQkPD3nn2P6r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PGbdgczg; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ff64e5d31bso56218801fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732644842; x=1733249642; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dNamshPaCUTPte8AHmdb3Dr6lmIGJc8Mesv/4U+ExVM=;
        b=PGbdgczgKxYD+yCjjoZUbfQsih10FIQPQ2jiReOm+EGFCd/zV7NeaJ8tJzUV5W6qth
         TkK0olk8kSY0i4jFBD4PE9WLgrDHbLg8g4hb4Aq9Vux9pmkEUQxyB4hTelpFpY2SqnZ5
         1kyJHXPS/E4CbMZbQx8C5N3b0Fw6Htf8bxziA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732644842; x=1733249642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNamshPaCUTPte8AHmdb3Dr6lmIGJc8Mesv/4U+ExVM=;
        b=H4BJNgRST40/u//NA1GTcxsQUXdJTv9J7g4kQo9jT+okt57sP9N3KXMxsv3r32pz7P
         5IHQ1aGr+XQeRPhGlZCnQrIzj3IyPT9YtrJgJrSRZaj35pSTbtZG+/ZZ3iIeVdJ4LCL1
         I7U4YXbOEQ5LzpxLyB/da7mru/j+Ldcm39lnUpTRyWdD3P8G8V+VBE9yh5rzfydzOyHc
         qziwO7jMGyOm/6hvFRVUprjQwtTBWJ7GSDak18nD+iPPSe+pkk3Gvl1AmdE1WRR7dSAr
         s9jyHybWy4F+v11w4szLOR6o6UZMohusSJgrz45sYGhKv75Cm0v3qgV/9RaYH+flEpqk
         YWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVag58bxEw0TFFq0KQLJ6pf6a/pHSXQzexWUl7ok8K8SM6RHmzc2ccde2UHHK/SNnKGAnOj+NkZaJo2GxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmLzdAB2ZyhD3+6ydcojY2NubOkkDU462foWvCLmyOpDYi9D5/
	Wdpn8diFtINwp/Y2WrKUwJQhT8nBhm4qVrVjgL6LFiwLXPrFaRy5QijWPYl9qfoBOOurvkSGVj9
	FzyY=
X-Gm-Gg: ASbGncuwPT/UkfS+GaEMQ9aCgfqNPJclc4KjMvupWWiv5Ysr7GSzkXjKW4aAPO67dgh
	ZoB1ggS9HINeQ725HddzupGFlMKchcXFQ80tWwfAbpAIF3RCluLGH5Cb1WtorPlZnea6A7wXGBa
	ae6CoTT2s/AqHQPdGP4xw0VX5MhHwjsdaETl79WweyaOk9grmsJwQAzpwdE38OgOfasJBXYl/oM
	jlMXI0MYRjM+9Rj87UjDXINccSBMFyvZyKEo7XHQM6TXO4B7ww9YNPAeuS1iQfWOfScBolt7N85
	KXAgoyjuoP0RcpWrOYpvyuli
X-Google-Smtp-Source: AGHT+IGdzoEyxKwZ6u6pAk3nPbhMgSnLAyr9AR+HkhCU8/JVupoDBsCi5/sHaIzOn1+lF3yaAyJw/Q==
X-Received: by 2002:a05:651c:b14:b0:2ff:c4b2:4961 with SMTP id 38308e7fff4ca-2ffd5fed677mr548441fa.5.1732644841783;
        Tue, 26 Nov 2024 10:14:01 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffcca2f9bfsm3141091fa.42.2024.11.26.10.14.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 10:14:00 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53dde5262fdso3911130e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:14:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW80bKcrs/Rd1yadAj8S3xJt69xVm9Q+4lTCWxJ2eKAXCXQQ99sBj3IVYtSPBpRflCeIoctnsxAEtZTCwc=@vger.kernel.org
X-Received: by 2002:a05:6512:baa:b0:53d:a95d:982f with SMTP id
 2adb3069b0e04-53df00c78a9mr44040e87.5.1732644840155; Tue, 26 Nov 2024
 10:14:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com> <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com> <20241125142606.GG38837@noisy.programming.kicks-ass.net>
 <c70b4864-737b-4604-a32e-38e0b087917d@intel.com> <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
 <20241126084556.GI38837@noisy.programming.kicks-ass.net>
In-Reply-To: <20241126084556.GI38837@noisy.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 10:13:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
Message-ID: <CAHk-=wg9yCQeGK+1MdSd3RydYApkPuVnoXa0TOGiaO388Nhg0g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>, 
	linux-trace-kernel@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 00:46, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Using that (old) form results in:
>
>     error: control reaches end of non-void function [-Werror=return-type]

Ahh. Annoying, but yeah.

> Except of course, now we get that dangling-else warning, there is no
> winning this :-/

Well, was there any actual problem with the "jump backwards" version?
Przemek implied some problem, but ..

> So I merged that patch because of the compilers getting less confused
> and better code-gen, but if you prefer the old one we can definitely go
> back.

Oh, I'm not in any way trying to force that "_once" variable kind of
pattern. I didn't realize it had had that other compiler confusion
issue.

         Linus

