Return-Path: <linux-kernel+bounces-444198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217E19F02C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE1618846F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 02:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47933136327;
	Fri, 13 Dec 2024 02:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tW5i/i+7"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F57868B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057888; cv=none; b=Dsq6k5duoPWmO72tDg5scQu46L83/oupvqgqbeyZiVtHaAH6w9r7UWbBjAGA/OFSx1kwUUv1xl0dvMBZ0AG7m19JMNaKIRnoU38+k2lhSaHVyW4cL1FdJZpQcdlkBKXoE7hJt/3qsStlISO1Ugn1CckFmP16nFc82qLSkDoyYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057888; c=relaxed/simple;
	bh=8UumNtP31CgCc14zvAbGpN/Y7y/84vcSUcdcyy312UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKbtWEzQbSXcClIT9lgzD2gaMxfGWdobbSCk8Zc4PSUtBKOm1twfN+NolvBpJbzlEgGTyC3PJl/vQVRLizdXNxoFcu8THSUXLPK7uXQy6rLX59DCnh41gLVbbcPr2lvWrDbREM6j9QazZWTUr+YgqqTt2qJDDLe4JGjsirAHDvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tW5i/i+7; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4679b5c66d0so78981cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734057886; x=1734662686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J77mR7lV5FZAxzlkB0a05Nm6eBULB0dl5ZV23bmS9bY=;
        b=tW5i/i+7JFoyNNekshLab6I0lXYBH1n4tDKG49TbOW6pMThlESMAEa8ahZiNGrmnMP
         Ox5eSB6EBhZR459v/IxRjdUbgGvTvkd9R4GetaxCMcJkKUHiHnensNGMr7pfIA4n2DP4
         VFiz4EkW19eLc2aJ4EVam4dAtgUx1CCwMKfvl/VLEaXMtsWCrd2VT1NoI0q9dPw1WCQm
         lPub9Hh1k39cDjhE+KrUaBPqRNH6Fw7SdHpo0eWm0yFMRCHdmcqM+yAp2RL2ar0yhGPH
         BnRmsv6HJ8EerKk0Z1YiIY/bqh1jcnZtsiaJj7FXU1YeCerlRMWe0HYO6uVolmtOkw/U
         1fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734057886; x=1734662686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J77mR7lV5FZAxzlkB0a05Nm6eBULB0dl5ZV23bmS9bY=;
        b=DxokGc3YgVnqe/T3EZln5jdSaNMQS7lUu5d3lNZ8tHT54r+2rBy2Ay3GJwhdxpVlzS
         XTflJ3eV5qRJxWGATDpl0+Hg9bWY1XCMFEDQO4v0e7KwTo6PFUwi3oJtJE3HxRyLiKoL
         GkVRmCpteR/aquDTmZQNauJyyfnZPvZrMvtfyRagvyFAXrRtYY8WnML54lK+yP5/bTHl
         ntbHW++OjT4g+SUAeXVzlzSw0rbdZvhZ7EJu9pkSQkJv3zTLOa5a+ptAmQmp9BBqR3oc
         AMXJBFvrlEOuR25i8Z4EjspjsI2ueQKyQlkMceXiOxV93D0nywUyM7HAIxCLhlH+OzMD
         43qA==
X-Forwarded-Encrypted: i=1; AJvYcCU+W122xKdVRhQ+0xNGEEz19ReXwPo0Pha62e9h3Hv/sRE0H81v/bABMNW4ffG40MtHpybgDVmqd2uHnBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRPaIIrkXDdqKv3dMV6bdbtNP7JleO/G9BBVpCt2fX1SaVZUgS
	kltD8P56mgPWHCy2PfI37JnXkBAEIjzQQvKkv7vro3JujbSqDFrlloot/VvWLb1A5EzCdJF3Uv6
	ypkeZW9uIPxmzP5RbqrxerSTNz70zCXkla7dX
X-Gm-Gg: ASbGnct68sgkGgduE91qmvNb5l/2xBiYQK3zz48yaP2caw5TC5hO9vpDCZzD6SkdYO5
	KKT5Q8ycZE7u3dfeEejx44Xb4CoW4z9DXl+TaOQ==
X-Google-Smtp-Source: AGHT+IG1/MZN2i5l6ktygO3stTpJyYfOJed+z3+lyx4SJkct22STzOBYMxJ99IdhJInFE7RmorqNZ+NIZvCT2F/cygE=
X-Received: by 2002:a05:622a:579a:b0:466:8a29:9de7 with SMTP id
 d75a77b69052e-467a424b97cmr1803241cf.12.1734057885517; Thu, 12 Dec 2024
 18:44:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211085616.2471901-1-quic_zhenhuah@quicinc.com>
 <CAJuCfpHP2QAhiYmzaAJgxy7A4H3mYep5NKL-iQRy3xSazZ13LQ@mail.gmail.com> <ca2aa662-e05e-4ad8-b4cf-33dd2d498af7@quicinc.com>
In-Reply-To: <ca2aa662-e05e-4ad8-b4cf-33dd2d498af7@quicinc.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Dec 2024 18:44:34 -0800
Message-ID: <CAJuCfpH-qXf7unhzr7PKY9iX0AcwDrpuKCoigQM+edV=AVYXJg@mail.gmail.com>
Subject: Re: [PATCH] mm/code_tag: Skip displaying the code_tag if it is not called
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:50=E2=80=AFPM Zhenhua Huang
<quic_zhenhuah@quicinc.com> wrote:
>
> Hi Suren,
>
> On 2024/12/12 15:16, Suren Baghdasaryan wrote:
> > On Wed, Dec 11, 2024 at 12:56=E2=80=AFAM Zhenhua Huang
> > <quic_zhenhuah@quicinc.com> wrote:
> >>
> >> /proc/allocinfo is full of callsites which are not called at all.
> >> Let's only output if the callsite actually been invoked.
> >
> > No, I disagree. Allocation that was never invoked is not the same as
> > no allocation at all. How would we know the difference if we filter
>
> But it doesn't affect further display when it is actually called? why we
> need to know the diff here...
>
> The point from me is: up to now, the callsite hasn't been invoked, so it
> can be ignored in the output.. The original output is really huge..

My point is that with this change we lose information which can be
useful. For example if I want to analyze all the places in the kernel
where memory can be potentially allocated, your change would prevent
me from doing that.

>
> > out the empty ones?
> > If you don't want to see all the unused sites, you can filter them in
> > the userspace. I also suspect that for practical purposes you would
> > want to filter small ones (below some threshold) as well.
>
> Yeah, that's the expected way from us as well :)
>
> >
> >>
> >> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> >> ---
> >>   lib/alloc_tag.c | 10 ++++++----
> >>   1 file changed, 6 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >> index 35f7560a309a..06fb7eb5c0bc 100644
> >> --- a/lib/alloc_tag.c
> >> +++ b/lib/alloc_tag.c
> >> @@ -95,10 +95,12 @@ static void alloc_tag_to_text(struct seq_buf *out,=
 struct codetag *ct)
> >>          struct alloc_tag_counters counter =3D alloc_tag_read(tag);
> >>          s64 bytes =3D counter.bytes;
> >>
> >> -       seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
> >> -       codetag_to_text(out, ct);
> >> -       seq_buf_putc(out, ' ');
> >> -       seq_buf_putc(out, '\n');
> >> +       if (bytes || counter.calls) {
> >> +               seq_buf_printf(out, "%12lli %8llu ", bytes, counter.ca=
lls);
> >> +               codetag_to_text(out, ct);
> >> +               seq_buf_putc(out, ' ');
> >> +               seq_buf_putc(out, '\n');
> >> +       }
> >>   }
> >>
> >>   static int allocinfo_show(struct seq_file *m, void *arg)
> >> --
> >> 2.25.1
> >>
>

