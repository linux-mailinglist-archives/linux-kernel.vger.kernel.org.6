Return-Path: <linux-kernel+bounces-418768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3179D6579
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0172831BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA618C020;
	Fri, 22 Nov 2024 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LDDJDl70"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9130189909
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732312514; cv=none; b=p6CKXghPG7YyB8RG/GwqHExMQlF/m5QOPhHOCy6o12tw70norGKHsqcat7DPPkyzQapwPV53xcG9y5IdYUc1yO0uMrXnGiuW505T0xHQD/car0/pt0w6d+i+947FVw8XyElymzq+queIQoiDeejtNfAYwiemQzigBqb83Tk2TYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732312514; c=relaxed/simple;
	bh=vGkG8fkCIoh53UmesuxXWTmTKOBPvNCBha+udWNY6yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIlV61ESaB52c29mrTJCbgfuhqesJ+UlU/amlffH4YHXzujvcK7m+cVmiJaZfJ2kLB+ilqM7BtmLBI3Aspl0KDuNlY1hUfKv0d8W0un3bqBVU+PwqO6fiy7AjUv2lnNdNCmBscuPU2qO7dh1p9vPfcaN0anGbMBfi6hEvFC0mP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LDDJDl70; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa520699becso124545766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732312510; x=1732917310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ERpawYAxA3WynYSStlQIZ0R+VROesHhCWFjMfsk4dfg=;
        b=LDDJDl701e1sxQJr75NeT+0TP3sVeXYNF3XcCZGFs/Un0iJ5m9q5laCdPSSYnPQsiO
         TtW4xVJSbJNlLKzWNZdl+mAiahEvOaTbBJ3MrcpnRYOYYPE2heYtLA1WSGDf2Oy0JOux
         mvAtS7zDOd4UqeHhbTxtC9j/Ef10Po6WsFL9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732312510; x=1732917310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERpawYAxA3WynYSStlQIZ0R+VROesHhCWFjMfsk4dfg=;
        b=S/Jz5/79/bSKOxWJMDntiWfBiKNdKbuF/kjrENyPj40zrwNiQXkxCNm35Ow/wbB/oa
         rfH1NcHjXKYRSP66w4NTCaIHgcwH7w9XSGyZVcNXYlBED2YSttGv+bzAL/9Qj84BG4c9
         801/diqxOTNGwtNXDQQHea5FpqmYX2y1XIrdDhJ/7VzdC2MwvPPAbXzsat2ySrheRZNU
         KI4UAZmkiXhN7pR1whvFaFM2+i3TFc8rOh2BaFdeGDFrwa1TvYU17ceGVg7xsSRBljoW
         7uG95KdSp2QwiVKlc2CIVNoFQeJM3urJQoS5y305eAge68tiIe6+GABgBJ16/xamsNSp
         vvVw==
X-Gm-Message-State: AOJu0YwkqAhcM6Y9eSgwEL898Hnc0ccpxn458M7i3NbRpDM0VoGZKEt5
	MG3QPOg4Qt1FvzXC8v6adcxXZSFkn1Cv4PoflC6IYFmxqROP8MF8HojbOYH5WSryoKcvnViOJbf
	qJ8P8rg==
X-Gm-Gg: ASbGncv6bcev9r4MDWCOLYTCHa6S/R09UelKKV+dJSFt7OxFjWAPbx3bmZlfMd/2s7t
	FfQNa7OtFIi44SXjDoLcn1poqiAs1X328z65rQNk8U1rctekJsGT+zJEsKhLinIIvqcbEF2WRNX
	fnGoZEfFYGZjWSWnr5POkmSzT1S228WqUO6qsi3oWYai/Dv5JLuPYRe6I4T9uuUqZdN+QV/WSAe
	I8+79xfQABM1mRpZPkoPYKERFOb78mMDNkuhrYMa6mAVWDUIbMNI8UBOFcXNeS0BiYfYGxFasLi
	T3NX/QCARgmFV7Jos76B9IDw
X-Google-Smtp-Source: AGHT+IHCznOpilE5AU6D3f/XYNi4BWyfslcFFXF2bmqPf0QO0ZByLFIQvZkWRxWPR9BH9CFqMBZ1hA==
X-Received: by 2002:a17:907:61a4:b0:a99:482c:b2b9 with SMTP id a640c23a62f3a-aa5099fc20fmr335839066b.29.1732312509964;
        Fri, 22 Nov 2024 13:55:09 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa512e045f8sm125304066b.194.2024.11.22.13.55.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 13:55:08 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso122785966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:55:06 -0800 (PST)
X-Received: by 2002:a17:906:32cc:b0:aa5:2e09:ff0f with SMTP id
 a640c23a62f3a-aa52e0a191cmr65873266b.37.1732312506210; Fri, 22 Nov 2024
 13:55:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120214531.45d75a60@gandalf.local.home>
In-Reply-To: <20241120214531.45d75a60@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 13:54:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com>
Message-ID: <CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.13
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Jeff Xie <jeff.xie@linux.dev>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Li Chen <chenl311@chinatelecom.cn>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tatsuya S <tatsuya.s2862@gmail.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Zheng Yejian <zhengyejian@huaweicloud.com>, 
	guoweikang <guoweikang.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 18:45, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> - Addition of faultable tracepoints

Christ.

I had a discussion about how horrible conditional locking is in the
original series of this, and I thought people got the message:

   https://lore.kernel.org/all/CAHk-=wggDLDeTKbhb5hh--x=-DQd69v41137M72m6NOTmbD-cw@mail.gmail.com/

In fact, some of these commits *do* seem like the message was received
and understood.

But some of the code clearly DID NOT understand this at all, and we
end up with that horror in commit 0e6caab8db8b ("tracing: Declare
system call tracepoints with TRACE_EVENT_SYSCALL") which adds a
"syscall" flag that is initially unused.

And then later in the series, we end up with the insane and horrible
conditional locking anyway, in the form

    if (syscall) \
        rcu_read_lock_trace(); \
    else \
        preempt_disable_notrace(); \

so now the actual locking rules are based on a conditional anyway.

And yes, it's a static conditional, but it's *STUPID*. And it makes
the code just harder to follow, for no good reason. The difference is
literally this magic

                        __DO_TRACE(name,                                \
                                TP_ARGS(args),                          \
                                TP_CONDITION(cond), 0);                 \

vs

                        __DO_TRACE(name,                                \
                                TP_ARGS(args),                          \
                                TP_CONDITION(cond), 1);                 \

in the two users, neither of which explain the strange 0-vs-1
difference that is actually very very important.

Why am I upset? "It's static, it's not a real conditional". Yes, true,
but it's static only as far as the *compiler* is concerned, from a
human angle this is a random flag that you have to follow back to its
use and check all callers.

And equally importantly: it's actively stupid and non-productive.

Look here: pretty much exactly *half* of the __DO_TRACE() macro is
literally that silly "if (syscall)" logic that I'm complaining about.

It would have been both cleaner and simpler to *NOT* make it a flag at
all, but simply have two separate macros of __DO_TRACE_SYSCALL() vs
__DO_TRACE() that didn't *need* that stupid flag.

Make it very clear that the syscall tracing path is *different*. Make
the differences *explicit*.

Don't add random hidden flags to "share" code, when sharing completely
different locking rules is *BAD*.

In other words: the flag is pointless and actively harmful. When I
said "get rid of the stupid TRACE_EVENT_FN_MAY_FAULT thing entirely"
in that original discussion, I did not mean "replace it with another
unnamed flag instead".

Stop doing conditional locking. It's broken.

And stop "sharing" code that shouldn't be shared, when the
straightforward non-conditional non-shared code is simpler and easier
to follow.

The code would literally be smaller if you didn't do this. And you
wouldn't need the silly comment to explain the '@syscall=0' argument
situations, it would have been sufficient and clearer to just state
that the system call tracing is done under a different locking regime
that allows page faulting.

I have pulled this, but I expect this horror to be fixed.

And equally importantly, I expect people to actually understand that
conditional locking is not a good thing. If the locking rules are
different, USE A DIFFERENT FUNCTION OR MACRO. Not the same function
with a magic flag for locking.

Replacing the old broken TRACE_EVENT_FN_MAY_FAULT with a silent 0/1 was not ok.

            Linus

