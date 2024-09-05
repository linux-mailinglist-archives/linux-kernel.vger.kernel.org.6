Return-Path: <linux-kernel+bounces-316300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61396CDA3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B481F23042
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 04:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF614A4DC;
	Thu,  5 Sep 2024 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="HSwXM8pM"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145FB2F44
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509857; cv=none; b=pjGNvnu2me4fNWRtKzVRvZjzXQIPCzxjFfJfeqqfN9t9UA81UK0ZUkUYVhnzyr2yeTuJaYetKJK75XHiLRYN8rGcvVkxJQsq54f9v1TGp7uFSS85uMDQTRNYneNM7VssFfO3Z8P76C4wHM2zsCHpmW59Ak1jra0tM027D8XMs44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509857; c=relaxed/simple;
	bh=Fqd5O56HcItsOWd+CIxphksTg7QoKAyjJrEQgL7KOdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlHjZY0azYK+J64p8f8aQBn6WeeXAhmVu4OXrneHyZHLzbFflBDL/Y6rkdcjHvQb7skqNV7/mEWQLUxHcf9G0xMFYbQ3PJEtqAsMWyJ2S9ThYzXU/aunoSBiYaOSqS1n86BfeL/AykGV6ek+OPAupN8TmCGVczo1OjyfAbma9Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=HSwXM8pM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53653ee23adso45836e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 21:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1725509854; x=1726114654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZdaH3PSCdfXqojPbX1szrhoVgPytj7gd3rO+WjcE80=;
        b=HSwXM8pMdHb8sh9Hlu5zuOzQGNrzYgZu5Y2Q7nDXbtzZeN2thqqSd+kQQnYtM/DTJg
         NR3DAq8Sy07l3NOCXFszyy8wUnY5sa5qwln+y02v+jk5hgccXbZ3ka0MLA4/UR49HNS5
         ht/SyeezqV/vt1l41Jwn9Q+ul8Y9JJTD6CV5BebnZM7p5MM8bSPNAFZ89FyxR8blhsnT
         FP0DSTLUYIMUwi7r5Nt93XoTFNDMXJOmNEkvQGZY+8PNGgvO+VR32ySBDTZXAFt0zZim
         TmibVnhlDiWsPId0mUCw1q0THChjawUODCQOtbr3/hVElEgCZyBOxkKBs4leCyKR+POS
         MoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509854; x=1726114654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZdaH3PSCdfXqojPbX1szrhoVgPytj7gd3rO+WjcE80=;
        b=AjIZKItxxqs4X82wXAU3LvGM+VDR2fMkDSJGsRpv4tjaKQu3eQ7o2fvvbDKkLt/dGJ
         8tO9tvHJWgx1VNKsye+fQ47Tip1MpeQNUgxqfy94UdGF7eLDh+ZZvq1lsZ6mrICYoBFU
         wPXO5Nb0LNz7SMLRYtBElmY2MoZqOZGYKhsRREqe4I7Tl+bSaHWSDfvQ27GGTBgi+ZKc
         fTCirwbdPeaZqO47/FkvmchI/+BeR60sIO/KaJzhlBRUTYilRR3Ug4E2VwroQUg4ioRy
         4etf6UHDxJZhUmVbGlPSGnuoIxc/FPU6BDEvsya9GqvTIAyJD0XhFN9BknQ5hXukH7b1
         JyLw==
X-Forwarded-Encrypted: i=1; AJvYcCXlTVmA3Nc0+QCsmSOOCFPmE52HV2b72obz7Jl11v3h7/hPCncyOVAnd/4Q+YI5tXuaN8BAsbOuYZzhcKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxibXq0XRgASFBkp/gX3afYNhzfwVKQM9cKi08wK8Bk9X5NCtmw
	LZ2aiENnbIyYyzr/HW4o6dgSxiYnniG2/OQoBcEghxJe9zhY5a1uv765YP6CSJm1PE8N5xa21yV
	2lK0iTumNyQq2E1m2dPEPa89mTsyl/DZMfkav
X-Google-Smtp-Source: AGHT+IE73Ld+RvK+KL878z4MoxnyKJHscGUwUvnaaZmXyON2fN5Wq13RRHi88y8AHu+BjAgfFxuSSsTRy+y6fOjCcPY=
X-Received: by 2002:ac2:4c53:0:b0:533:d3e:170a with SMTP id
 2adb3069b0e04-53546b92ddbmr14763907e87.38.1725509853875; Wed, 04 Sep 2024
 21:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905031027.2567913-1-namhyung@kernel.org> <20240905031027.2567913-4-namhyung@kernel.org>
In-Reply-To: <20240905031027.2567913-4-namhyung@kernel.org>
From: Kyle Huey <me@kylehuey.com>
Date: Wed, 4 Sep 2024 21:17:21 -0700
Message-ID: <CAP045Arcn_zrQvzv+4ihCXOPgcsuMVe_VdgR-cny63POaT5g-w@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf/core: Account dropped samples from BPF
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stephane Eranian <eranian@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 8:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Like in the software events, the BPF overflow handler can drop samples
> by returning 0.  Let's count the dropped samples here too.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Song Liu <song@kernel.org>
> Cc: Kyle Huey <me@kylehuey.com>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/events/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8250e76f63358689..ba1f6b51ea26db5b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9808,8 +9808,10 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>
>         ret =3D __perf_event_account_interrupt(event, throttle);
>
> -       if (event->prog && !bpf_overflow_handler(event, data, regs))
> +       if (event->prog && !bpf_overflow_handler(event, data, regs)) {
> +               atomic64_inc(&event->dropped_samples);
>                 return ret;
> +       }
>
>         /*
>          * XXX event_limit might not quite work as expected on inherited
> --
> 2.46.0.469.g59c65b2a67-goog
>

lgtm

- Kyle

