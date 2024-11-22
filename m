Return-Path: <linux-kernel+bounces-418806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9645B9D65CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0042FB21E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB818E76C;
	Fri, 22 Nov 2024 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c5WZ91j5"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8FD1865FC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732314633; cv=none; b=Jmn0gmUN1ejfyCD2xVofd6T12ObHYjW+KOqqEikbF8hw39E68CzMLGv84xtDbdOsVJWgALimogdgaqt2mDjHbW6NfHEZBbljXEofkmPDDfnxPcn5n6lJc8zkTRz+Y0+P6MzcnGer8g7KpKHdTFYNV4lkbWGktyy79v8K1tAhTSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732314633; c=relaxed/simple;
	bh=Oh2Eo0RBHQsIu0jduIUhDXoQmXc/zWXfUWN94SFyeBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TE6VMIbDoJfjvxYYTSuUdyoZF0cfIRhKcZAe8INdmVP0o6cHh13Jnt/1/6ku9XEJtG0nF1RAsm5pUBN/UAMYNLLA/4lnxXVX5ZVJqIApIL8pn1ym7X2ESeTgcN9TbLeyqZ2R6cRsfuVdliVYJMpQea5pwqaMjFRpNfkLNssOjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c5WZ91j5; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so2992731e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732314629; x=1732919429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HG4wGILRg6YBBp2BXI+l78FeeidFjgpeRG03LjugAF0=;
        b=c5WZ91j5S6HW21N+Tlsx9yC9UfT+dV90qTE4BeAXDVAsFiHkQumCVITWqLQAz6k7cd
         +n6mILSD7Vrpn7XIRUIZmk5uJsWCnCExO90KBBpg+elf7Y3StkXOiG9ogd0h0WRC4dvF
         VQFERU1hgjlQeWA9cE/WkACs+WDn1M5JF+A4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732314629; x=1732919429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HG4wGILRg6YBBp2BXI+l78FeeidFjgpeRG03LjugAF0=;
        b=qnWfEu+3lBKXLOJL5zyIMj0Ym99Cu6SkMeQS7JyfbRTfROFcKodKfmU7eftFmzKSuB
         5w8jS+mduQ/hSRbRtE6duGyyiIP9RfXS4U8ffz4m56Zi/RjbgnWcNKWNxWnYJCgZ4Zev
         7Ua+pLhm1Lub73JFsZyOGqMY9xLyGDT9ZpZKcZ59IMaySUmkjbWf1+Q6p9063CAf5p0R
         kAF51fvIo+8p8puS5E+RN2N72gIXkcBD6xz5sKGmQ7J3Qfn4Hvg+byy5h6YYwrP3AqQ5
         HMNiI3326y/Aq9OAn+dhNWJ8luW2GlIPb7BjjNlo63odVlnud8m5AdJUn5Ptxt1uAtgG
         rtBQ==
X-Gm-Message-State: AOJu0Yy3HbsQ5ixmE1TGY5dbt+CQldXd8doUWI50dSj7bv/O5jyCdRBe
	kNF4VYInizN6/IbFSnxm0OOZuvjhInakJo+z1Y0PKqP7MZUlbtD9KWbMrpwxKa4hr3f1VwXwQA4
	AD3uPow==
X-Gm-Gg: ASbGncv6NQAOv1wD0AB9HI6+65fiLQrYGM3TrK9riq+gFEnZz9Z8YfWCwcZuEoS8TZ0
	t8I+40pHFevmWghPudMKrjG4ls78HJTS0Gj7Qwz7GUXwTiT+F7xHogXDk8AR9lCT4IEJ4R1WUyz
	mly70n8PCE75CX+YSloWSi15VAZrQowkamX2D2fa/fk0FqkYvR1+BHTsNqAdW7Cr2wkJ4vseAmo
	X2jsMZpw0NYKpKyV9awB2WMkiC42jQDFPjD0NO/cTL554Vo36UwzlVt2LOesgwMiwsOmvrn5qN9
	5WVB4/jCj8+F/EdmFSSnUhYf
X-Google-Smtp-Source: AGHT+IGaCZBdK5BGKRHPQmuC7mHeJaRrgNiU+WySWIORTMTWihUuNDjgoElRBzbc5t7kcKt139UEUA==
X-Received: by 2002:a05:6512:3b90:b0:53d:a321:db74 with SMTP id 2adb3069b0e04-53dd3aaff72mr3013211e87.50.1732314629275;
        Fri, 22 Nov 2024 14:30:29 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd245190esm574415e87.111.2024.11.22.14.30.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 14:30:27 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da3545908so3159657e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:30:26 -0800 (PST)
X-Received: by 2002:a05:6512:3191:b0:53d:dbf5:e082 with SMTP id
 2adb3069b0e04-53ddbf5e085mr129185e87.34.1732314626401; Fri, 22 Nov 2024
 14:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120214531.45d75a60@gandalf.local.home> <CAHk-=witPrLcu22dZ93VCyRQonS7+-dFYhQbna=KBa-TAhayMw@mail.gmail.com>
 <20241122171323.1dd0efc9@gandalf.local.home>
In-Reply-To: <20241122171323.1dd0efc9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 Nov 2024 14:30:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+bbO9nYxCz5CPf6oGB0upCFH4jx9Bx36f1f3+_DcDUQ@mail.gmail.com>
Message-ID: <CAHk-=wh+bbO9nYxCz5CPf6oGB0upCFH4jx9Bx36f1f3+_DcDUQ@mail.gmail.com>
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

On Fri, 22 Nov 2024 at 14:12, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Hmm, if we make a __DO_TRACE_SYSCALL(), I don't think it needs to even have
> that condition parameter.

That was my point. The whole conditional - and the parameter - seems
to be completely pointless as far as I can tell.

That said, I think you can actually simplify things even further: if
you move the TO_CONDITION() checking into the caller, you could move
the locking there too.

IOW, instead of this pattern:

                if (static_branch_unlikely(&__tracepoint_##name.key))   \
                        __DO_TRACE(name,                                \
                                TP_ARGS(args),                          \
                                TP_CONDITION(cond), 0);                 \

you could make it be something like this instead:

                if (static_branch_unlikely(&__tracepoint_##name.key)) \
                        if (TP_CONDITION(cond)) \
                                scoped_guard(preempt_notrace) \
                                        __DO_TRACE(name, TP_ARGS(args)); \

where __DO_TRACE() would get neither the "cond" argument _nor_ that
locking argument, because both are just done by the two users (the
other one would use "scoped_guard(rcu_read_trace)" of course.

And look, this is another reason why unconditional locking is a good
thing: now you can use the "guard()" model for the lock, and don't
need an explicit unlock, simplifying the code more.

Of course, you want "guard(rcu_read_trace)" (for system call events)
and "guard(preempt_notrace)" (for the regular trace event case), and
we don't have the "notrace" versions of those guard classes yet.

But adding those would literally be trivial, ie something like

  DEFINE_LOCK_GUARD_0(rcu_notrace,
        rcu_read_lock_notrace(), rcu_read_unlock_notrace())

wouldn't that make it all look really nice?

NOTE NOTE NOTE! I didn't actually try any of the above in real life,
so I might be missing some important detail. I'm just pointing out
that making this all unconditional and not based on random flags has
the potential for even more cleanups.

And I might have gotten the different lock names confused too.

              Linus

