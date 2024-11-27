Return-Path: <linux-kernel+bounces-423440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA809DA761
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6355116524A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C321FAC57;
	Wed, 27 Nov 2024 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6/MC30S"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A01FAC49
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709251; cv=none; b=M03H+uex54mDCa4YgGgXJtg2aqEiiVssKrjo8bdZ+eHyT/QtmXpAY0aNeHBp6q0qGdtmTC0ChTdx9FvebXmICZgpX1WZT4EOVKejUH6DdrxFVGdPlRaD4AlslhwkqpyXWcnnAbm9vWGNzuptJFqdIhAaU3DctFGNr3t/f2WvBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709251; c=relaxed/simple;
	bh=xGH2otcBVgI7ZNii2v4VTVGd8E5+SfRgGy1VfVtc73M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5efqolwc15NtpjxLkgRFzMKinPoQ2juiS8sI28MkOMjxGudHN4TvSRX+wxzVkpwzl4EnikdOyvou34HUNhclwzv1NWy100Tvs4C4ZLlMuPz2XxQmJvwAmB7dMQfk0w8focrCnjyx37poSwlVm+hZY3MyXp0FvNU5QUx91rv5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6/MC30S; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so4927809b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732709249; x=1733314049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4AXKwflDoZON8uZoVsJO/jcP453CSzNx76GT1Wo4MM4=;
        b=a6/MC30ShRdNJOEP/o0oWpovXhVZVL5l5b0OUMTgOcYIpiO80QiDYHvF+9goJ1cWZ+
         I2yUkInsowopj58dDH1Z8bP6IQuKwwrcrmQHQXYwP21+Z570MjY0W9Uqw7hTya4zDiqK
         sdqIhc0V3CQ/U5/3JYLL11xz+9J/WdgJEf0BgLNsuk9nG1ZNINCA/3n7C/HeZu/gRKpf
         g9hl3Vnd5Q0PAw1dQhHJXkirS9Fx6mRL6XS0aSyhql6MigWwQtrn7Jylu5Nup9r6mBHH
         322guCfG+r/AGOsnDOcozxtosZ8y+eslkUMO8/oeIqq0W0kdLOcg7amnQBQp3PgbXtx4
         DWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709249; x=1733314049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AXKwflDoZON8uZoVsJO/jcP453CSzNx76GT1Wo4MM4=;
        b=niQEEqUiQgCnp7WKdijiKaDOVMSFbZKAj2GQ9BwhRAFfBt7KrsItZybvuycKmP4WJj
         fgvTJUiDshRgL2V2QaYhP0q62cYHqGd6SXnzFRrflkcaobM8ZMdpU0jbBPmBgLFZT1BJ
         3u8JMKmPqPxaYLCTYv4wk/ck+c9HsDcNDvRs8KjqzEFiYCgW5wwT4gIjCE6wpO0UgWoo
         T82pZ4w4nuMuiUEbVlH4NLAS8fBCsIKYNi+1ITSxeUbtvdqhGTiu28hEBSM7qLwbegAL
         bbcHGX0jOB0tn/jJG+HnFU0dFgkiiMPEbAco4pQBsiZSLoKYRF+MPzoPwQubd8O09UoR
         CBog==
X-Forwarded-Encrypted: i=1; AJvYcCXd1/OEYvKuOEw9hNbdi3USIghVKHR0SYDcSBEDME3gLmiFzaNgVXufR5P78GkYt7EVWLLpTRt68QMTfiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7M/S1euIu26Ff5xBBnDqauiIQ+3zKpZyr+bEEytRrI8C0Oip
	236OALLNRNgvW/vGAiPgp8LhkXCF4FNiC3JHGaTlt5i6ikApchulxA/ZOYwNaSn5D3+L5lAxO5S
	c4BAx8xF2hkvcIGb8GCTbmbdk/ueY6RvmS+a5bZi0oORbX7phHSEPwyM=
X-Gm-Gg: ASbGnctrFHiAmecACJRn3MEHTcSiysbuZDmrrfET7q/LyLsscneosM99dS3QdWT8IZJ
	RjPujsHvsv9TlWYVaLCow6BzLVNejNaHm/KZ9XjZxSnQUQ7Wzec9crxiKL4MT
X-Google-Smtp-Source: AGHT+IHwICfCYrviS08kFGNRMVpuL3ujNRVHSRlu6OtVk1kmMBM8BBst4vSPlPTaleJxA8eHXG8PEgN83xzT+6HzfII=
X-Received: by 2002:a05:6a00:230b:b0:71e:74bf:6b1a with SMTP id
 d2e1a72fcca58-7253011ef5amr3365444b3a.16.1732709248940; Wed, 27 Nov 2024
 04:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127111020.1738105-1-elver@google.com> <20241127111020.1738105-2-elver@google.com>
In-Reply-To: <20241127111020.1738105-2-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Wed, 27 Nov 2024 13:06:52 +0100
Message-ID: <CANpmjNOpY0zjpVJe8zUYZR2oJ--=OtWdHnEp70SxmAnb5ubwbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Refactor bpf_tracing_func_proto()
 and remove bpf_get_probe_write_proto()
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nikola Grcevski <nikola.grcevski@grafana.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 12:10, Marco Elver <elver@google.com> wrote:
>
> With bpf_get_probe_write_proto() no longer printing a message, we can
> avoid it being a special case with its own permission check.
>
> Refactor bpf_tracing_func_proto() similar to bpf_base_func_proto() to
> have a section conditional on bpf_token_capable(CAP_SYS_ADMIN), where
> the proto for bpf_probe_write_user() is returned. Finally, remove the
> unnecessary bpf_get_probe_write_proto().
>
> This simplifies the code, and adding additional CAP_SYS_ADMIN-only
> helpers in future avoids duplicating the same CAP_SYS_ADMIN check.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * New patch.
> ---
>  kernel/trace/bpf_trace.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0ab56af2e298..d312b77993dc 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -357,14 +357,6 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
>         .arg3_type      = ARG_CONST_SIZE,
>  };
>
> -static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
> -{
> -       if (!capable(CAP_SYS_ADMIN))
> -               return NULL;
> -
> -       return &bpf_probe_write_user_proto;
> -}
> -
>  #define MAX_TRACE_PRINTK_VARARGS       3
>  #define BPF_TRACE_PRINTK_SIZE          1024
>
> @@ -1417,6 +1409,12 @@ late_initcall(bpf_key_sig_kfuncs_init);
>  static const struct bpf_func_proto *
>  bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> +       const struct bpf_func_proto *func_proto;
> +
> +       func_proto = bpf_base_func_proto(func_id, prog);
> +       if (func_proto)
> +               return func_proto;

As indicated by the patch robot failure, we can't move this call up
and needs to remain the last call after all others because we may
override a function proto in bpf_base_func_proto here (like done for
BPF_FUNC_get_smp_processor_id).

Let me fix that.

