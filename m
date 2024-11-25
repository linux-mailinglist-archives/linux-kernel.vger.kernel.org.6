Return-Path: <linux-kernel+bounces-421473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853D59D8BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026D6162A46
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B8A1BBBDD;
	Mon, 25 Nov 2024 17:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gQrA9CMm"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3801B81B2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557543; cv=none; b=qvueH+BasUsUCtTH/Pidm7B2Q/HMNi0ObjypDSlPFM1CeAa01YjethA3mWpDvyWqoY+Hpw5Y6WS56RQ94E4oFV5i0/2IyFop47cNu0o3ZqpWdm/O1jSNMu+NcTLwrMDuHC5NnkXC8AwS7zqZAVVZUFRvJM1y1cJgd984gXMekdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557543; c=relaxed/simple;
	bh=iqPKUKL9ELh3ItkoROVJPLFbP84xRrkUj8+Scx+N17c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVIgaeC70Ac3nf9u2H24Oe9uGZV+bSIAOPm4bI97CzHwVODIA+1v/ld8+s4n1qrlKqWUjXOHe47VzvinhK1wf9ynYwieugmU6kP/poX46AUlrVVIoji5FnYrEk0ojFIY+5ZcNICd7dgdJikagv/0lLlWxei5okhLWXz8h/0t8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gQrA9CMm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a68480164so671073466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732557538; x=1733162338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xXLqvBkzwwQHV9WjuiXet8nTMU/3s9BgOxGDDiZ4odc=;
        b=gQrA9CMmCaWZwVSS/xT05BFBWm1NfFY4CVgMqNeh0Ng00YsDHz+P9hgB/CKtiqaMSg
         t+Rca45yl2T0LTACo3BM3I3H/Pe3m3HtrJbIMJINymWcgkzUwnxq/clKvdh2SpXmeyPj
         WItr0wkLE1le5RSv0wESTigx2NQlKFWykrrJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732557538; x=1733162338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXLqvBkzwwQHV9WjuiXet8nTMU/3s9BgOxGDDiZ4odc=;
        b=v8EgmeK4EasNJYQqQxEvdJp8gOIlwJqVI4CQVf2XE1cTqaaYRgpS2p9UkqfqdebPaS
         uvadU3GVfySy0vQKJZol7eI1V+1lxLoibXiz5AnDZJKBfEGdc0zinXN97SJpK/hxcUni
         0vnEk3lk0WYMyANgZ9VDfcT+WkUR53JlTEn6D1QsRkDN6XKtoRtoLynR9BuDyJaHxYtl
         i2Ssfw9ChpdSGg/4Ncn3ekEqvYL1nVWBDwmR6mNLyZupzevWWDNbWkyC4goj1R/sjNYu
         X78GFe/byrkr1y/tw1DNHgfDmB2jcatopmTXHbX+lUvWHlQKyy9G07V7WD5YuxqHe7hk
         MXVA==
X-Forwarded-Encrypted: i=1; AJvYcCUDMaLEW19WHIMTSZdvv5nwkTstSZgLI6o2w2/9vdbzRURV7bI4aM51vI+B61hCXL30puFnGxTWyx8Rs/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBu2bWy1hkjUDQzoEqHDR1xM60bOM1eIdo5y7FfpUOZLGqhes6
	LHIZrN3p0Fwdu/ppIbfR3VUzNJEFpRRinmpRXvA6b0FwjgTgsgCwYMW3dzJMG7fiuCd7WuByQ+H
	O+8c8Rg==
X-Gm-Gg: ASbGnct9kY1tlq01M7H4a+nv+5Pq+gs04uAPbDfryeWxsq5jpUmVNZkbieM27/264Dl
	HTo/UtIavNu+FMcZQAyhCqvg9Y1Y7KTAYcAjd/jjUKibuEKJo8qwKqbIp86ZsYQV5npJeEEdXCH
	GGkM6YIJ1xlYh9T7vDXng/gfte3i3hFyxEcFGmIcBvMRzPUUnEKrDs384s/m2e63gqvzbiiuRp1
	C2vDcRTAhxtvfFTuBu2ge65/Kll6fKqnmfCAXdUvVbXVb+msbMBOa9lB/LMUTJ1+0LdH63/X/Zo
	DNn5ZxUdDMLeOfNJkAYSdvlu
X-Google-Smtp-Source: AGHT+IHXUHi9QCxLZBaekZ2P1EPkR8ukyg58vpOgVkl0dhyGfIBMdQccT1s7JAxY0foo44Vwp9O3Lg==
X-Received: by 2002:a17:906:3187:b0:aa1:f73b:be43 with SMTP id a640c23a62f3a-aa50997d791mr1283526166b.32.1732557538510;
        Mon, 25 Nov 2024 09:58:58 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b28ffc5sm485608066b.15.2024.11.25.09.58.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 09:58:58 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a2033562so5757515e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:58:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwJN6MoDH/hFDXRDF49x1T8SjNdJ9UbTxzEmQ4Y9un4N8jPhFflBZOlW08YF7I9HiAY1gHhRY/gXGLz9s=@vger.kernel.org
X-Received: by 2002:a17:906:18a2:b0:aa5:3b5c:f640 with SMTP id
 a640c23a62f3a-aa53b5cffafmr703474466b.54.1732557119666; Mon, 25 Nov 2024
 09:51:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com>
 <20241123153031.2884933-5-mathieu.desnoyers@efficios.com> <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
 <d36281ef-bb8f-4b87-9867-8ac1752ebc1c@efficios.com> <20241125142606.GG38837@noisy.programming.kicks-ass.net>
 <c70b4864-737b-4604-a32e-38e0b087917d@intel.com>
In-Reply-To: <c70b4864-737b-4604-a32e-38e0b087917d@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Nov 2024 09:51:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
Message-ID: <CAHk-=wjcCQ4-0f68bWMLuFnj9r9Hwg4YnXDBg8-K7z6ygq=iEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Michael Jeanson <mjeanson@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 07:35, Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> At one point I had a version that did:
>         if (0)
> label: ;
>         else
>                 for (....)

Well, that is impressively ugly.

> but it is goto-jumping back in the code

I'm not sure why you think *that* is a problem. It does look like it
avoids the dangling else issue, which seems to be the more immediate
problem.

(Of course, "immediate" is all very relative - the use-case that
triggered this is going away anyway and being replaced by a regular
'guard()').

That said, I have a "lovely" suggestion. Instead of the "if(0)+goto"
games, I think you can just do this:

  #define scoped_guard(_name, args...)                                   \
         for (CLASS(_name, scope)(args), *_once = (void *)1; _once &&    \
              (__guard_ptr(_name)(&scope) || !__is_cond_ptr(_name));     \
              _once = NULL)

which avoids the whole UNIQUE_NAME on the label too.

Yeah, yeah, if somebody has nested uses of scoped_guard(), they will
have shadowing of the "_once" variable and extrawarn enables -Wshadow.

But dammit, that isn't actually an error, and I think -Wshadow is bad
for these situations. Nested temporary variables in macros shouldn't
warn. Oh well.

Is there a way to shut up -Wshadow on a per-variable basis? My
google-fu is too weak.

Did I test the above macro? Don't be silly. All my code works on first
try. Except when it doesn't.

          Linus

