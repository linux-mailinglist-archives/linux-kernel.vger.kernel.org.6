Return-Path: <linux-kernel+bounces-311802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1F2968DDC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478931F2289B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829AD1A3A97;
	Mon,  2 Sep 2024 18:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fA6Y7uNm"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081A1A3A8A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302832; cv=none; b=O2SdfAyfPbHkZ5uGEmUsG9RMd2VTRm/nd/9+RrIO2UjFHz+Ous1/ZKQjabDwMMON+C+1i35OcdB0lNlprglsWCo0kEThIfidY2VNdlUfffXsgPM54dMnJy9lVAnJvp3jn9/0v3oUANqsgrW2VU860mbfUwRPiHS6v05On3D9mZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302832; c=relaxed/simple;
	bh=LI900uzgGCQElfJqtf01iHNZkLmSZEe/42LMd0+O44Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PunhJsaCmeyWpkh7Gsdb9nIM/V1XnvtuT5tpPhcKaZD3CFnNTuV+XEn49hKKiygTNR5uTo+ihS9swv7KZQoMQYlKytfvLCbypUDD7zTzx1q8CZbqQNb4/HWVv4TlirxbtIZU/isRzh1JbJUrwvYLo9WhqoBiI/Rxxg6l6xtusWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fA6Y7uNm; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-534366c194fso4117673e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725302829; x=1725907629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NCSu3cKIwSHt25rKzyc3TLGkgrpQltQSLr6RUpbw+m8=;
        b=fA6Y7uNmbZiF+j5NZnnjA6qUmiMpsceMQWQzFk6ssH5bMcWKGpxR1l7e38MmLJiQy0
         9RNwNGSwavhQCnWaa/Lii/juRmEJW9CjH29TGM2F9ddCB0j/KmhSNbeFOsxTXaPQEJpW
         XFyztRIEE6/m60saEeaRue9sPU/TkK6TQ3OGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302829; x=1725907629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCSu3cKIwSHt25rKzyc3TLGkgrpQltQSLr6RUpbw+m8=;
        b=BUXK9SO0c2EDv1baHRw+OnlpftvEgVEZTwAhOQNN0lfOZf5MuMReOUu1BgVY7zVj9Z
         Q8nd6dO+em2WIsNNpqAvqpbmppV+eWvIIexr+QSWwyUh5mugnq0oZotAA8zxNNI3Mjfr
         9PqbstlplrFrM+VoTDVPPHGxdpBJWhbFt2OGjJ0902W7LqSh5P/mJQeUS0f9LiS0Tjn+
         gg3dhOp1OvU5TyPWu8CGND4H2/NxyfRRTnZJlZyQmrrflTkmOhztMA2cNmYalr5z1rzk
         pjpmg/fJDwTHEj/fW/FFHv7kJzWsGrdZXINDQe261ZZRS2REZkdMHm2CbwYRYyI2F7UB
         I6iw==
X-Forwarded-Encrypted: i=1; AJvYcCXLEM1Nmo7+6JihBWdQKGSDuIA29kuT4sUOaH31FQn3tlLFpvUUL9Cax8/4boOIPlT50W/MgbivKabr/s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlT2ofU1qhOtzl2EKf6/WWzCmrldVc7K4Es0k6DrmyTigyhimx
	qsPbjzwG0S37REFjeUpjXBnwReOEEr7xdTfl71CdKBvfao3C8jSB/e+9Hcua/QAiEOlYiZG5Ug6
	+ras=
X-Google-Smtp-Source: AGHT+IFigKHWbj+tbTawnCNfkQ9YqXrQFnSKYAS7BZDYoMHiqLNNkw7SKAOWfoisjwnmFvMft2iknQ==
X-Received: by 2002:ac2:4f03:0:b0:52f:413:7e8c with SMTP id 2adb3069b0e04-53546b32c95mr7900705e87.14.1725302828318;
        Mon, 02 Sep 2024 11:47:08 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540841512sm1726304e87.212.2024.09.02.11.47.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 11:47:07 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f4f8742138so50743121fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:47:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSumz2goSuHhXsR9QThAM17NIVWKu763OLiJx7IYGiIq6YSaEDFcrrmQs8LvqNc7++cKtwVtEHNpmRXNs=@vger.kernel.org
X-Received: by 2002:a2e:bc0e:0:b0:2f1:6cd6:c880 with SMTP id
 38308e7fff4ca-2f610890881mr116441241fa.37.1725302826121; Mon, 02 Sep 2024
 11:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com> <20240902154334.GH4723@noisy.programming.kicks-ass.net>
 <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com>
In-Reply-To: <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Sep 2024 11:46:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
Message-ID: <CAHk-=wgRefOSUy88-rcackyb4Ss3yYjuqS_TJRJwY_p7E3r0SA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and activate_guard
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Sean Christopherson <seanjc@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	bpf@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 11:08, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> If Linus' objections were mainly about naming, perhaps what I am
> suggestion here may be more to his liking ?

Most of my objections were about having subtle features that then had
very subtle syntax and weren't that clear.

And yes, a small part of it was naming (I absolutely hated the initial
"everything is a guard" thing, when one of the main uses were about
automatic freeing of variables).

But a much larger part was about making the new use greppable and have
really simple syntax.

And the conditional case was never that simple syntax, and I feel it
really violates the whole "this scope is protected".

And no, I do not like Peter's "if_guard()" either.

Honestly, I get the feeling that this is all wrong.

For example, I searched for a few of the places where you wanted to
use this, and see code like this:

    #define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)            \
    static notrace void                                                 \
    __bpf_trace_##call(void *__data, proto)                             \
    {                                                                   \
        DEFINE_INACTIVE_GUARD(preempt_notrace, bpf_trace_guard);        \
                                                                        \
        if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                        \
                might_fault();                                          \
                activate_guard(preempt_notrace, bpf_trace_guard)();     \
        }                                                               \
                                                                        \
        CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data,
CAST_TO_U64(args)); \
    }

and it makes me just go "that's just *WRONG*".

That code should never EVER use a conditional guard.

I find *two* uses of this in your patches, and both of them look
com,pletely wrong to me, because you could have written the code
*without* that conditional activation, and it would have been *better*
that way.

IOW, that code should just have been something like this:

    #define __BPF_DECLARE_TRACE(call, proto, args, tp_flags)    \
    static notrace void                                         \
    __bpf_trace_##call(void *__data, proto)                     \
    {                                                           \
                                                                \
        if ((tp_flags) & TRACEPOINT_MAY_FAULT) {                \
                might_fault();                                  \
                guard(preempt_notrace)();                       \
                CONCATENATE(bpf_trace_run, ...                  \
                return;                                         \
        }                                                       \
        CONCATENATE(bpf_trace_run, ...                          \
    }

instead.

Sure, it duplicates the code inside the guard, but what's the
downside? In both of the cases I saw, the "duplicated" code was
trivial.

And the *upside* is that you don't have any conditional locking or
guarding, and you don't have to make up ridiculous and meaningless
temporary names for the guard etc. So you get to use the *LEGIBLE*
code.

And you don't have a patch that just renames all our existing uses.
Which was also wrong.

So no, I don't like Peter's "if_guard()",  but I find your conditional
activation to be absolutely wrogn and horrible too.

                 Linus

