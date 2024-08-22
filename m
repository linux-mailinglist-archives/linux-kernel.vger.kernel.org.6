Return-Path: <linux-kernel+bounces-297828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A442095BE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25569B26CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87911CFEDC;
	Thu, 22 Aug 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSIiCtSr"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4812FB1B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350957; cv=none; b=morl62XZeb0JsiMqbkwNwYGextRwyY7vDfG9T+ceRJHZo+QnTC0gngT01T0wDtAQWDJH6Of5oX/y+CVfQZCdQ85Z/IAurFOvQ6Y4XCF8rsbtkjHQjm3suWGxjP9mQqCAZBDqtL4FkNmZ9VqtvJOEOcP/fj8dJ7Ilufs9hvvx/Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350957; c=relaxed/simple;
	bh=8AaFxJBdDfuuSQorSwGuqnL6mAG545GzLyJgufi+ciE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/ddTd46XFo/TGlD5CkTwsnPIndvSEqMm/4KURQfq7sWwLioro3xS7zUbUzm3iJso1te5BCGOjA7+933kVVNf8GmCg3In0y22xvfLvtj94E30ubrLsfb+sH89yFc7PINiD65YixqrdZK92Yta2sRqNMD1VNraZlEAiNZX6jdr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSIiCtSr; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fee2bfd28so37301cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724350954; x=1724955754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dqn2V80u3kfHC/0zkp/qWJvODxJTdLLWbBCfitLm7s8=;
        b=bSIiCtSrjNnHR/wBFRwgru+72jXnQTAB+bjd2PHYFSSzqz9zKSDhcuDMm8YXKCptiH
         T50g5yzGcii8HPUfOrSZ7WX3He0eyEpEweOWfoGUSckJwppeofDjzSA+maL5IGNvq5FY
         Y1xrDe2j2C4peUBWssStrBvAacTYPXEdu8+FT65gzc9HrnjObg1ie1+EUgnMMDxMsPTc
         aWTQ/3pPvZHEVuPF9RoYN1gk/XmpmJ6OESNK5/3xshKvKoMgPfFiM2j39UwJL4hHlo0p
         ZUXQ4EO51HmxGkEOHheTwrZ0RTlyCT2/vGb/tMnwXaCz+QdZ+6TJVkDm5xlKtUySfWbp
         bybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724350954; x=1724955754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dqn2V80u3kfHC/0zkp/qWJvODxJTdLLWbBCfitLm7s8=;
        b=wFmyu08JzFhJltMXLPP4ex8Jmkpxi1BpBHB7oLLV5iUf2obYdNCocawGbAYxOYCgDh
         sulaObQlcf3zwM23/KJakjrpBUeEmD9uFQPd70WR1YkPXwU1Uuf1fZ5lHQEq0RNKXz8k
         eSGXhbUl7xscNK0QyuY4VbOjijL0BZqmq0fXUAocvn5vCjz8fgtr9IuYFkfoUPgNPZAx
         wR96Jx3MiQlNoWSDlq7VmQ1qQnpssRxlwO4+yw9NO4oWPU7iIPw7xaOkMCrQkYXNkN4X
         KRj/biYHNS7tr4t1A6JYmhC99Vd40yWNPg3ceE/NGLzRFvQaeuFtaLJYae4eYi/USyKZ
         qdxw==
X-Forwarded-Encrypted: i=1; AJvYcCW6JitDjVNwdwdn0pkxnQAI7Ob/VQfuQm9Gq1/A+ZgT1r+QjjClfZD9OYioUoBhzio6TcLZ+AWTexUWL9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJigg4qCGYr0HPbQSjG8oYGY/F3yKYa3bFiRlEvegxwc8qZYcM
	9ll/lV5XeX10ePr4178DjZIKBSP59M8fR9VLx3uU6jH41EvqdRvBU/RSac7HbIvrNDGoeaNU73G
	WXEp2E/4a0wUbT89gC+jjiDrPM6O/Ib09E7on
X-Google-Smtp-Source: AGHT+IFYGfaezjyjEqYQB3pI2kWejCzKz9jLeGF4X9rS5dsdgTvBJ5gQkACpK5kCBi/bcGIWug9I4TFT2RW+UfyedA4=
X-Received: by 2002:a05:622a:1183:b0:447:e0e1:2a7b with SMTP id
 d75a77b69052e-4550858300amr110241cf.23.1724350954184; Thu, 22 Aug 2024
 11:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703095712.64202-1-dapeng1.mi@linux.intel.com> <20240703095712.64202-7-dapeng1.mi@linux.intel.com>
In-Reply-To: <20240703095712.64202-7-dapeng1.mi@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 22 Aug 2024 11:22:23 -0700
Message-ID: <CALMp9eSEuA70itad7oQUo=Ak6MVJYLo4kG4zJwEXkiUG6MgdnA@mail.gmail.com>
Subject: Re: [Patch v5 06/18] x86: pmu: Add asserts to warn inconsistent fixed
 events and counters
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:12=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.co=
m> wrote:
>
> Current PMU code deosn't check whether PMU fixed counter number is
> larger than pre-defined fixed events. If so, it would cause memory
> access out of range.
>
> So add assert to warn this invalid case.
>
> Reviewed-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  x86/pmu.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/x86/pmu.c b/x86/pmu.c
> index b4de2680..3e0bf3a2 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -113,8 +113,12 @@ static struct pmu_event* get_counter_event(pmu_count=
er_t *cnt)
>                 for (i =3D 0; i < gp_events_size; i++)
>                         if (gp_events[i].unit_sel =3D=3D (cnt->config & 0=
xffff))
>                                 return &gp_events[i];
> -       } else
> -               return &fixed_events[cnt->ctr - MSR_CORE_PERF_FIXED_CTR0]=
;
> +       } else {
> +               unsigned int idx =3D cnt->ctr - MSR_CORE_PERF_FIXED_CTR0;
> +
> +               assert(idx < ARRAY_SIZE(fixed_events));

Won't this assertion result in a failure on bare metal, for CPUs
supporting fixed counter 3?

> +               return &fixed_events[idx];
> +       }
>
>         return (void*)0;
>  }
> @@ -740,6 +744,8 @@ int main(int ac, char **av)
>         printf("Fixed counters:      %d\n", pmu.nr_fixed_counters);
>         printf("Fixed counter width: %d\n", pmu.fixed_counter_width);
>
> +       assert(pmu.nr_fixed_counters <=3D ARRAY_SIZE(fixed_events));
> +

And this one as well?

>         apic_write(APIC_LVTPC, PMI_VECTOR);
>
>         check_counters();
> --
> 2.40.1
>

