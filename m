Return-Path: <linux-kernel+bounces-419192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A479D6A9B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 18:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39A6B21244
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3DD146588;
	Sat, 23 Nov 2024 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UMDroGWF"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50411CA9
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732383534; cv=none; b=Aq2kBLEs8XaYeMMEABdcs8iE6Nyd4uKQHIftNI92xTC4xguW7Bb8F6pgc3ifOoIhSxdtML7e6ceJ9ffXlrQzXrzi/CBW1Vl5Jyj8OBNWFFiaWjNGTvBkaguGonFKbCeNSlovywKPXWOvE1FM2KqGOsegwY1bVthR0cnYKPd8W+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732383534; c=relaxed/simple;
	bh=Z2N+kTJzZXoQJzfXPyysOgIn5Wbo9WbTTSH/hpfAXyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHGVl2zIq09AKxcRvmGyHPZyOLbbPIa/tAOGZfj1Y96kBJlGDIHVUSP/3ktYBHxP15G6UBgev1TGacZ03hG4X7JidIGrAKUzBZxYklE3nrRbJHY172QzluGLSbjL/8xO9wfx9bfv7ln0ThZnSqfYqxDxi0l1amhyQoR6TfGXUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UMDroGWF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa20944ce8cso758688766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732383531; x=1732988331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vpM1fsZfdZBok4MSDnesEhvbM53AiXvjDwKI+kJlxP0=;
        b=UMDroGWF1+7vELjsmAXzd2LAZEjNp880pmEcFq6eKCbmgRJZNH2uzdXNlaj+5T90L9
         iknr/bZ82UM8jLlcWT+7cMvoDniVtGVeP2YeewGqfmf5Q/ZYVaRiFcMvIt1o/Rwnt3+b
         NiwXL7qcOgK8k6V8k+2YaJif9xh1S0p49PNQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732383531; x=1732988331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpM1fsZfdZBok4MSDnesEhvbM53AiXvjDwKI+kJlxP0=;
        b=WRez5DjXaMueFIufQrQbdfLXHqk899JtxsdKr51nnA9cA9RyWa663AhPBZX9qc92Wm
         W1Fz8FO4Sr4EPTq/Nv7EqsHnzMyEygUUmGqEXTOXyJW26upVCjeL/CQwLF13C7ZvNdZI
         QBdyBhuEYxzLuga/5cgbrYNCEv4Jk8N6pZ+ZpwwMTzs2Mq8iBIkvGUpFd4R9YQUQjk55
         kQ6oLKzkJPH1Z8a9zlqiJu7Nvsm+4pdxLak81IU6JIVMD1i/MWgO6pdmjTwWx0hrmbM4
         jzqA8Ijm6u9/OAgga46SxbbQZHX2XGNvr1OZ6y1VdWovg5R1hINO2rnlcTMZ8d+8XAL3
         UYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVKao3A91uAzfdR4nKXFN1gR4RYjlcLDU3lyKVu6a+yEFkDLQo4HJcNVWOe0e2RlWBwsmP61UaVXyNDts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaY3SvT9ldmbtLejwukNtOkuUU7rnMFBN/4jI+56H1QcT+VKKS
	Lp0QSq+QsxqThVCNPNUXC4yif+LHVZKITlJhLCh/furqozrX6xiTqmDsqdJieGhN2ngbfUpJXXl
	hT/fAqA==
X-Gm-Gg: ASbGncsNsQCp7tm1jE1j4jcps8A15GzR4z32UNspLUvQ1QE2/Tp1s4FcqN9wwxX5J2w
	CskvXqHw1LeeQJBwy4QvSSYqURTugGnsCc91gqcyJhHtOexWMH6xHOiBtLLyEGtlYWjXhtAPq2b
	HL/U75XhwlXV8tFMbxXuQAJg93E7Jr/MEOEIZe1OTW0LEmr1hWk5JAEF8Lc/6iACUqsebUItWlX
	i0+epjWttdprFrjpXIpJuYffd1DuGdxTGaBjE5qma5ex398REulIGpgvZtm9/HyyrFnQavlI+Mk
	498wAjkDzLYyMKsMp3W/mXaY
X-Google-Smtp-Source: AGHT+IH6S7My9w4RWoT/7DMQb9U+nsuPqGXL2AGSGOiBR30w3UKYBYwOTlIH7LR6EenhZlUu8HVm5Q==
X-Received: by 2002:a17:906:32d4:b0:aa5:ac9:ce5f with SMTP id a640c23a62f3a-aa50ac9d235mr848686166b.0.1732383531209;
        Sat, 23 Nov 2024 09:38:51 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b2a49aasm250493866b.1.2024.11.23.09.38.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Nov 2024 09:38:50 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso7188015a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 09:38:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5dsuvUq9dG5UhC85+8wv+ZddUg+tPTxHt1aU2sw2bnI1jJNz3lJpjUzHL0vUSoSLWgfdCKiYGS2ZGeI4=@vger.kernel.org
X-Received: by 2002:a17:907:7853:b0:a9a:17be:fac7 with SMTP id
 a640c23a62f3a-aa509a07836mr857912866b.14.1732383529933; Sat, 23 Nov 2024
 09:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123153031.2884933-1-mathieu.desnoyers@efficios.com> <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
In-Reply-To: <20241123153031.2884933-5-mathieu.desnoyers@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 23 Nov 2024 09:38:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
Message-ID: <CAHk-=whTjKsV5jYyq5yAxn7msQuyFdr9LB1vXcF6dOw2tubkWA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] tracing: Remove conditional locking from __DO_TRACE()
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Michael Jeanson <mjeanson@efficios.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Joel Fernandes <joel@joelfernandes.org>, Jordan Rife <jrife@google.com>, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 07:31, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
>  include/linux/tracepoint.h | 45 ++++++++++----------------------------
>  1 file changed, 12 insertions(+), 33 deletions(-)

Thanks. This looks much more straightforward, and obviously is smaller too.

Side note: I realize I was the one suggesting "scoped_guard()", but
looking at the patch I do think that just unnecessarily added another
level of indentation. Since you already wrote the

    if (cond) {
        ..
    }

part as a block statement, there's no upside to the guard having its
own scoped block, so instead of

    if (cond) { \
        scoped_guard(preempt_notrace)           \
            __DO_TRACE_CALL(name, TP_ARGS(args)); \
    }

this might be simpler as just a plain "guard()" and one less indentation:

    if (cond) { \
        guard(preempt_notrace);           \
        __DO_TRACE_CALL(name, TP_ARGS(args)); \
    }

but by now this is just an unimportant detail.

I think I suggested scoped_guard() mainly because that would then just
make the "{ }" in the if-statement superfluous, but that's such a
random reason that it *really* doesn't matter.

             Linus

