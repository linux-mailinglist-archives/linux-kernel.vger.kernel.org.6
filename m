Return-Path: <linux-kernel+bounces-545828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF5BA4F208
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F0F16E708
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCB4524C;
	Wed,  5 Mar 2025 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gm6eIZ0T"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BE802
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 00:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133071; cv=none; b=vAHcuH6gJKZ//JInENEaaSyGr02QcTuprWGalOjF3QjJZOISp8RdBpPq8eZYwmzRfk/9rmc/7PzfJzMjpD5MC2FIls4HxqDHzB8fD5T4BoS+JkiYfXm8QHP+KO7VaGZSBtjTFs1OE0juaT0oL3E6E+8Wilh9LttVsW7ZL6ik++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133071; c=relaxed/simple;
	bh=obB0h8AHDTv9/LrRGXUTQqWYXLHGR7G5bwHes9VJzA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZWTFhtJsxb7RGM+JrpwBcVlnD1qKeYTb7+0KaGL2Wf/lY4ox1hkM6iuvU0O2C/ZxMVeix9ZQ8xGehbqWbw1uRg686aXuMTAuNkN1zNPbI9eClsBCNIhix7TgPfcdJzs0lJnS38dBybApo2qEziRylaWGOwYx97MaRktVYEOiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gm6eIZ0T; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so9922343a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741133069; x=1741737869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LM4+VbDeQgzb/55NI3t+9R4dHqP/5jKcZhBFBtOBqBA=;
        b=gm6eIZ0Tz5znH7+Y+X9dk2eBqkHgynYAWQfqsjqVyBF8ETXt8cfDR5xgZFJguu+liJ
         8UrZjVBOhKjFgaGTiE+fgb4SQaOud+QtD4LgHwdAiGikppuFoTcKHFMfO7FErBFvaOU3
         k7sjNIM6Uvw7qe3QlkyhhLQJ2lwbReohwIgL/nuslOM2fdpVaDluJvOh/xKa0L+TxjTV
         Pso6g6MXXTeFjIF3p7rkDHtr/bXIdwR+4YgGLM5Eku29aAb4yxRgjWxEaz4qSFq1NmKI
         USzp48uboOzSHTV5WDm5h6VFxJ65E5qX4Z/cChJ/SLJ2Eine6Bnymdhnynz0ryQFnLOU
         SWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133069; x=1741737869;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LM4+VbDeQgzb/55NI3t+9R4dHqP/5jKcZhBFBtOBqBA=;
        b=D1bqSm67WV1sBv8W/yLxW2/XxZYdY4MeWMbWoadQEObryn+DcXCAJt2Rg+WSKX59b/
         yDaZAHIkt09snv2XyKp8HbByTjQUhYfqrhFswowaZe8ZZ5LEaFYrbd6kKcgzLxfWvtlP
         XzA8lB52g4FKsVAtN572wEqeU6bj85W9lRGYWBY0nuP2YMXSpt0syG0Bt20GKKuF7tdJ
         zw1FxY0FCZzIDZd3SXmCfPrSWkGOfEFhKxfnA7CWwco1Es6dfBZdK5sKIwvQasQGz614
         FxlHjcd/u2sfqVg8WOJS1V9oHgBt+cEv4N5GDh3+jLLMB+4IY0eFGeGtl5y/Eu6RwXKK
         CLyA==
X-Forwarded-Encrypted: i=1; AJvYcCUWbRmoC8b6ej4I0ulr8ztx2w/jklfz2K/iuzDBR5qDJ4P4NdYGD1018Nw3orCfMnWEuBXlq+VDOAOQ8M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdzJ0DjYV/jq16JuOQR505zcWtKTkBcvptp04t4kZCq+o9h44T
	JnAYdwFApBU4bO3zYFQboW+hpQjAGNis/Xo0q2iwmYnIJEBG84iEjNqnm2nFGlhKCuusqqRU6FY
	gX5noPsadwyyNEKIGzw/v7/vyUFIRuTLH6Rcd
X-Gm-Gg: ASbGncva5BRMbhObvZ6rgW4eDPK5NUEw+ElaqRm4BThi2f9dNvOlQMpKohcnyX5E/Yc
	m7gzeffIV/Ylox+TGz7WhDRicNGn2Ae64Cdv8e96s5Wihh4rKTE60qCdIOFtAm7utG7DSWYSi/W
	56ON0QmY7dh37cz82rJ08NF54zzfIlbKS9sd2hieck9UXDtL08s1cLk0j6
X-Google-Smtp-Source: AGHT+IEtISi7Tlt5kX4zmOO9FEZtWXEEe9J/QPKTHvSqVUkwchS3k7u+aPOlcVNfd6t4Doh8lMUn/x9+fE5ZVoRcpzI=
X-Received: by 2002:a17:90b:4ad1:b0:2f4:423a:8fb2 with SMTP id
 98e67ed59e1d1-2ff497cce8emr1999183a91.20.1741133068525; Tue, 04 Mar 2025
 16:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com> <20250304092417.2873893-4-elver@google.com>
 <41a14b09-9f09-4abe-8caa-89cfe2687562@acm.org>
In-Reply-To: <41a14b09-9f09-4abe-8caa-89cfe2687562@acm.org>
From: Marco Elver <elver@google.com>
Date: Wed, 5 Mar 2025 01:03:51 +0100
X-Gm-Features: AQ5f1Jpv14gcn7aAs4yWXHhRLBF4i5EQTdXxL-iYYKY2gY0B-tX3E5j-KtDZzBU
Message-ID: <CANpmjNMYoRTj3F1L9UCp2gHVbVZw0ieNnk0xPZ8Q--BhFCy7Ww@mail.gmail.com>
Subject: Re: [PATCH v2 03/34] compiler-capability-analysis: Add test stub
To: Bart Van Assche <bvanassche@acm.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 00:52, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/4/25 1:21 AM, Marco Elver wrote:
> > +#include <linux/build_bug.h>
> > +
> > +/*
> > + * Test that helper macros work as expected.
> > + */
> > +static void __used test_common_helpers(void)
> > +{
> > +     BUILD_BUG_ON(capability_unsafe(3) != 3); /* plain expression */
> > +     BUILD_BUG_ON(capability_unsafe((void)2; 3;) != 3); /* does not swallow semi-colon */
> > +     BUILD_BUG_ON(capability_unsafe((void)2, 3) != 3); /* does not swallow commas */
> > +     capability_unsafe(do { } while (0)); /* works with void statements */
> > +}
>
> Is it guaranteed that <linux/build_bug.h> includes the header file that
> defines capability_unsafe() or should that header file perhaps be
> included explicitly?

It doesn't come in via build_bug.h, but via:

  scripts/Makefile.lib -> "-include
$(srctree)/include/linux/compiler_types.h" (all TUs) ->
compiler-capability-analysis.h.

The things pulled in via compiler_types.h are treated a bit like
builtins available everywhere implicitly.

