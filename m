Return-Path: <linux-kernel+bounces-441446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F62A9ECE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84819188261B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588DF15A858;
	Wed, 11 Dec 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9apzlzy"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D6246326
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733927000; cv=none; b=d2AZVGGDXcmqD4SfJTeuQY11KUm+7zjllKCcdyjzv7enRGpweFSiqMS9U9ZEYqUj55J3519jC0J7AJUJkCfrYxOUV600SuytpHykNjzJFfedpxR61uU7aM03dVk0KOd/dU4OANMqjetmdiZdIzCvTutriLQmAprwVTnH5sZNRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733927000; c=relaxed/simple;
	bh=sbh7AWaShd2GfI0imEetw26zJRmTeK0wkuB3XXGUF6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSsPMl6dsnyOUqnV7yTfh6A1eYiska1DovD/2Fw6QqJXJCzSRc6RqBiPTinBSNwNzhzd5fz4p32zc/ZGaQf1ojDcejtHezQOt6TdAoYVf35DvSJqftEIbnA+cq5FrPn17iC0XvTLzrExSxRVekv6XJCu7FmVlbvkHGPKoKv0zoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g9apzlzy; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53f22fd6887so4125375e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733926997; x=1734531797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbh7AWaShd2GfI0imEetw26zJRmTeK0wkuB3XXGUF6k=;
        b=g9apzlzydgJ4Q6ULFHgnRbTsqlj5aB0C5meVMSK/UNmDqyc/uQbfs5PQAtaCz7K7ja
         FslTws/n3vsJ1uTp8N4P8ryGEvGlNOn32LK1NjPHQp1YTN37naNtQtJO74iy+/9XeGKW
         Bz31Qx5DQjQUYfoJqhGsuPaJJy+4sF0WqZZpxgar/5vPUfDfwAQeE3Ox3rpxRcofCqHY
         fd1j2dxIQV56PQq8Z5wmeHtasKMFRG0STSNmaink+s3SLcKCwZmJkIrSwXI3LFO+NJ3r
         VDmhohhZR9mSRoPR25jxYQjV9fbwdwZZmGNYJi9rP/3yMYDZNqc+UibLYZrQSiCurd5e
         UK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733926997; x=1734531797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbh7AWaShd2GfI0imEetw26zJRmTeK0wkuB3XXGUF6k=;
        b=xGWs6+y4ETFjK6MVjgIW1W380mrAFDeTThPlH7/SCyvBsNDw3uYU9dRh7thzil/ZMe
         0S15RcTD2t0mc79bSJw4aFrP2frPofVhz5NWVoso5cYTxnY9nAW/OFYIp6sfVo3NJ+o1
         XQ68vKz3g8puDmThNHLamQUiseECJtl5rZnxnU/J7qMM0FHeJUyfQEHUA3ekyRtRZynU
         TU/k5szkmHZXhgRMGknQYzKYc6C0TEhhLb5JsiKikeS/xBMmt1YrvjByc9khILhT8qQg
         FFte6NXi1NfCRdd6Y5bMYoVXyYmyUe8+FhyZQ2Uun5AtF7mm+hJacd0+PJiFrxtQ1mYV
         QSXw==
X-Forwarded-Encrypted: i=1; AJvYcCXXhZEcrRIV4V1t07jm9wt1y3+LYz3+tHsR0gOhV9B3JI5OHGJPc+R/lQ4BAryRqX9HbGx0J7J1Ba3d+CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYo1J2LQyPw+Psvoboy1ZcJfNr5R7AV+47t9i9X3JUDN7eE40X
	UdRuGJsSdHpE+BIggGlD18w3kCe8sq02zommOT0vrsOEHlrZOtOP1Cg4zTND9+P2ZZmP/6bhxdG
	1oreq9YzijziMrjUhXg1mtwknWw4bHWYAx8xYKw==
X-Gm-Gg: ASbGncvMGdsRakVTuLWQSDImWgzakvbFcQpq8VEskKFX/MEnbokv08PWJHTrcyeEMl5
	8oWSG6FrvN8sanxTPsEsq5UHEGusIXutJlQ==
X-Google-Smtp-Source: AGHT+IFwc3R4PMoFIypjPPrlyu+bP54qbrkqb6SdTFcVtmAjqvNQet3Sk08y9AmHyRfPr3eq0SXHvcppFqWjVobZmrI=
X-Received: by 2002:a05:6512:6cc:b0:540:2292:50b2 with SMTP id
 2adb3069b0e04-5402a60af0emr966019e87.52.1733926996913; Wed, 11 Dec 2024
 06:23:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018214300.6df82178@rorschach> <CACRpkdaTBrHwRbbrphVy-=SeDz6MSsXhTKypOtLrTQ+DgGAOcQ@mail.gmail.com>
 <20241211082427.01208632d3dd5486abb3e090@kernel.org>
In-Reply-To: <20241211082427.01208632d3dd5486abb3e090@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 15:23:05 +0100
Message-ID: <CACRpkdaEXUxSuVzztcVOh2VMzPHr+6jsrEC1w6ecWEd0qzgU4w@mail.gmail.com>
Subject: Re: [PATCH] fgraph: Use CPU hotplug mechanism to initialize idle
 shadow stacks
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:24=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.=
org> wrote:

> > cd /sys/kernel/debug/tracing
> > cat trace
> >
> > Gives an empty trace :(
> >
> > And:
> >
> > cat current_tracer
> > function_graph
> > cat set_graph_function
> > do_idle
> > cat tracing_on
> > 1
> >
> > So all *is* set up, just not performing
> >
> > I tried to figure out why this happens but I'm not good with tracing
> > internals. Any ideas?
>
> Interesting. Does this happen only on boot-time tracing or after boot too=
?
> If it does not work only for boot-time, cpuhp_setup_state() may not work
> before starting boot-time function graph tracing.

If I boot without any tracing enabled from the cmdline and:

echo 0 > tracing_on
echo function_graph > current_tracer
echo do_idle > set_graph_function
echo 1 > tracing_on

I don't get any output either.

It works for other functions, such as

echo ktime_get > set_graph_function

It seems it's the set_graph_function thing that isn't working
with do_idle at all after this patch. Why just this function...
The function is clearly there:

cat available_filter_functions | grep do_idle
do_idle

I can also verify that this function is indeed getting invoked
by adding prints to it (it's invoked all the time on any normal
system). Does this have something to do with the context
where do_idle is called? It's all really confusing...

Yours,
Linus Walleij

