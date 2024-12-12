Return-Path: <linux-kernel+bounces-442902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153609EE3B2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DA3282012
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08472101A3;
	Thu, 12 Dec 2024 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNpeZ0Os"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA221018A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997985; cv=none; b=LxMs3iCFp5eNnw9M3rlTG2auZ4F1ddbOOoIvIgjHzfbpnY4t3hiTgO0VBPDMtwq/9FSE54CY4Xc/x3H8yu5qbF4rVORAEI3K6AjkWhtxSCh4c31mOmpk587qSBmym6psdVz0P3IJwwf81CWUXzB/6JTEsSj0ExFDOGVB7Ut5Wpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997985; c=relaxed/simple;
	bh=u2lqw8UUeZ+pB1gxUrdc+rJ/PnMeN4apvADmtF38BGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kkn3aQXdj0Dp0xxv4AFOX3/XPDfzXz4xadN9fs7XDMv19VxiJcKfEFJ2ODQclhM3p7iDD370Mh2d0gIuNJPdE4wQr7zZIArdYJscUn7hiqFJIeeG5uLq3ghoIwS26UdbTMtb3qDnLxrF14PWQGr3Z6GSjOXj7AXOrvqIBFNVTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNpeZ0Os; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8fa32d3d6so5392196d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733997982; x=1734602782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of1BFeg2KON1xNm3jFNunekzp1UDOQsJoCnNxyLjjW4=;
        b=BNpeZ0Osd1eOOMbedsNNvbi6Kh0Rqnj8d3bJPj8qZXZ4QSwHAGfRAgZhaPZybRH4ne
         noT4fnFNN9czijbAFZxC1MkAlmO7N9bPiGL+quQ7DQ+mxt5/+Q3xyVuSys0roqBe/XlM
         OcLiCIcvx3Ra55HFM5c7dTRfcAKdItQIa9du3TQDj6fq5V6qLo0kl5FQnhnsI8UFK0RU
         fy4F/4OdU6qE9UteJzcP6Cm6AyPhECDFJ0Kqd/3kqNz8gl1xDhsEWaIBiEMnqC6oCSoP
         MBJ7gihWpeUEsKKZloTB3Qbor9ktEqM3w8e4It3VYAUnLqnmwZMbwVnLyB3YmLOY60YX
         FOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733997982; x=1734602782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Of1BFeg2KON1xNm3jFNunekzp1UDOQsJoCnNxyLjjW4=;
        b=MPlJA1+1DjytKD9UuOQ9zaOhuS1ifgqK6FA0Udsmphks6MM1TcuiqOVwpDbiPQKxY5
         jqaz1s3WpBc35On4+3EMUZ5OCW8s+QrIxLAfGFVHxUzbLdm8R/nmUavmX1PvWLnauSOa
         o3ySOgz+2lFczVMHEf9ttiVQpibyB+nY9HlA+KRVk4BeCjwAW3E17FanwRMqiSSY87j6
         o2K0d3Lr6wuTgWy95aS4X9qkiGGZ0qPsuMosLjGMjfvJs+ifPDYfbyuZL5cyO6Y6f6dU
         1XnvrYvvbUg2LY3MCIwBnoJsas+dlyDqS8UNPltITKWgZ7+I4bvZUF+/hmHnZzvlPt9e
         J7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXO7aJ2SrHpITEOiBg/hQ3/0cb+eT4DNHtYkfYeijPZUdPbwS972wfLOWN/gAX20wv+z8BhusZwfqahe1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMw1d5yBQ0cy9iYH9k7ZYR1J7ay8Gc+AX2LZmNdtLAIpjQ2qG
	bwzvU1ssd7CWA2WNhKn8fkaDw618hsv0qCfliLQoaa97r4X+FziK+DXTJEL9SaFDcnIUt8trYih
	FKtgZc6Ifli+coT3xG+W7bWbaC6nhMFY6KKy3
X-Gm-Gg: ASbGnctF6h9U3pPflWzUXfCQXliEFOZjJ1kunzm1dDQNhpS6JJZNcC1NFsZ6ZCQPcxr
	JTAqwBQMhFtFbSKL4+PeBNV4LrPDxtCIbGP5wmHO7ESRq/SrDDk8adTmo2ZtW/WY2tIU=
X-Google-Smtp-Source: AGHT+IHUvvVABps1uuPMxjIXuv4cTLRDFnTx/UHIKWDoA76gNJlFIEgBNsM3HWFBYgN6SlATfLNLOarEKRNTza20ijc=
X-Received: by 2002:a05:6214:21a6:b0:6d8:99cf:d2e3 with SMTP id
 6a1803df08f44-6dae3913ff2mr41578706d6.22.1733997982309; Thu, 12 Dec 2024
 02:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108113455.2924361-1-elver@google.com>
In-Reply-To: <20241108113455.2924361-1-elver@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 12 Dec 2024 11:05:45 +0100
Message-ID: <CAG_fn=VyvPfJnPcXOOAeFqNakKKYzjuUdDqW5Z4rVQMgQA=AGw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tracing: Add task_prctl_unknown tracepoint
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:35=E2=80=AFPM 'Marco Elver' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> prctl() is a complex syscall which multiplexes its functionality based
> on a large set of PR_* options. Currently we count 64 such options. The
> return value of unknown options is -EINVAL, and doesn't distinguish from
> known options that were passed invalid args that also return -EINVAL.
>
> To understand if programs are attempting to use prctl() options not yet
> available on the running kernel, provide the task_prctl_unknown
> tracepoint.
>
> Note, this tracepoint is in an unlikely cold path, and would therefore
> be suitable for continuous monitoring (e.g. via perf_event_open).
>
> While the above is likely the simplest usecase, additionally this
> tracepoint can help unlock some testing scenarios (where probing
> sys_enter or sys_exit causes undesirable performance overheads):
>
>   a. unprivileged triggering of a test module: test modules may register =
a
>      probe to be called back on task_prctl_unknown, and pick a very large
>      unknown prctl() option upon which they perform a test function for a=
n
>      unprivileged user;
>
>   b. unprivileged triggering of an eBPF program function: similar
>      as idea (a).
>
> Example trace_pipe output:
>
>   test-380     [001] .....    78.142904: task_prctl_unknown: option=3D123=
4 arg2=3D101 arg3=3D102 arg4=3D103 arg5=3D104

For what it's worth:

> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

