Return-Path: <linux-kernel+bounces-275055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1EE948019
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6AA284611
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E515ECC2;
	Mon,  5 Aug 2024 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AkzqaI0o"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D7155351
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878023; cv=none; b=oTcf2PKcJPLTE6GNMth5rHJRR83YQQ/d+HT9sqwCRb4D/Q1fxsvyvc2qfTTUL/lzvFDh93JDdbkm1SE9B7E9Tw00bUqipqfh1kJ3nA9qhMvazkFtYyeyk5prWcZIUpR1elkPfK02J5yHYz1drJugjbaONYxkIwsspIBTWy9t5XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878023; c=relaxed/simple;
	bh=yfWYEXxdeJwgAdLFY31FsjB5SlxcoS41niHTgjnNpUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXq+e6hlqOZgnMdyFlYMAsAuZiCnreHt2s7XvDC4+fk+0i5aGo68TARghVTG0xJO0NbZElx1h5H9VBgaOAIr2qFQLrY6KJtOoHNNKjf0tJOmR0BF2MOZgrDvdTHe38DXXb9wrEzHk/bMHYKrN+xfrYTHcORhu2rq9enqZEbrESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AkzqaI0o; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a20b8fa6dcso341716285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722878020; x=1723482820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxGPkBBIU/UYFLm9bnOMyrs15Eqxvamgnzbs4RGwsYk=;
        b=AkzqaI0oAjB4vocbylCI4/4Ym2XSgWzLX27ruGXlqkU4E3g39mhUkrh8+RBQ6OleCb
         bd3vnX/irWznkxyhkobssKUuFvfrHWvJUdrzDWj0aSdX0+zrtdxBTwgbsfhj507PbNqD
         r0MJ+HLXQLpR4Yrlf4k/dPF5L4rKSjfCGvK9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722878020; x=1723482820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxGPkBBIU/UYFLm9bnOMyrs15Eqxvamgnzbs4RGwsYk=;
        b=EVZPh0NggLIZyrmrG57yEbO/WVhSU2g1mIGMBcs3ilfomwxU4F5Qp+ReNky1TCtTAR
         IACuOfSFyh4vb7grAnqUssP2izhRY02YjmKm1/8WyWVpC2mnRUqpyASvBfwrxPy2ASvK
         lk612lb58ACWEDwqS04YXJ0GtGR/Gef3eoTctakSiqcFn6YRuiWIOSB+M8mgni+T6tqL
         DZr94MzSU+yLCsU7cHYIVMfaevhdlbPgL5UmCVQf6sEiQudn0lxQFGwOLGi+wThCFlRN
         0m+rQN0FcvD41V6nvxo77K/VE+IBezIrbZozEiRt2N+d4C9eNh+VMn5EtrX7CnhNmvH5
         JYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhoPhNEF9qWDadWZ4PmTuMMjTuqnS3vI1yFRl0Vhoq1+HAHSt9GZADLkdaE5R1wQnfZwnh7NL2seHuf9xpAmm6drzBJuxNXZ3oTyCQ
X-Gm-Message-State: AOJu0YzH/d36hhc4bcvLL4SXOHCdb+NtrQkSNbChAxYgfyjabY203m9M
	a/HV9ITXM9GXoh0gcsKHkyI4givw9FPGtTqZUhkvUoOTG0lqgYQt02ifkgsxRYcSmnAXespMNFE
	=
X-Google-Smtp-Source: AGHT+IEbpZySP3CSZP4SkMHFeW+eVBHY96N5iViHqn3WJVEBC2PyQLac04Rl3oWDP96+Yg9Sp0TuPQ==
X-Received: by 2002:a05:6214:3bc5:b0:6b4:4470:81a5 with SMTP id 6a1803df08f44-6bb983102famr152270256d6.2.1722878020310;
        Mon, 05 Aug 2024 10:13:40 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c76f8ccsm37434726d6.4.2024.08.05.10.13.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 10:13:39 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44fdc70e695so30371cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:13:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/xzfgD0VkLari02aKFSK3KftmyDBwHNu+MaRn839QtA+m+erXUviqg0qWePVLnQFxyFIunUe3hSJpAumV0bXY8P07YkcV1JWeQLvW
X-Received: by 2002:a05:622a:301:b0:44f:cb30:8b71 with SMTP id
 d75a77b69052e-4519b663469mr5297181cf.25.1722878007233; Mon, 05 Aug 2024
 10:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240805165336.GA10196@willie-the-truck>
In-Reply-To: <20240805165336.GA10196@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Aug 2024 10:13:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
Message-ID: <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Yu Zhao <yuzhao@google.com>, 
	Misono Tomohiro <misono.tomohiro@fujitsu.com>, Stephen Boyd <swboyd@chromium.org>, 
	Chen-Yu Tsai <wens@csie.org>, Marc Zyngier <maz@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Frederic Weisbecker <frederic@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, James Morse <james.morse@arm.com>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 5, 2024 at 9:53=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> Hi Doug,
>
> On Tue, Jun 25, 2024 at 04:07:22PM -0700, Douglas Anderson wrote:
> > @@ -1084,79 +1088,87 @@ static inline unsigned int num_other_online_cpu=
s(void)
> >
> >  void smp_send_stop(void)
> >  {
> > +     static unsigned long stop_in_progress;
> > +     cpumask_t mask;
> >       unsigned long timeout;
> >
> > -     if (num_other_online_cpus()) {
> > -             cpumask_t mask;
> > +     /*
> > +      * If this cpu is the only one alive at this point in time, onlin=
e or
> > +      * not, there are no stop messages to be sent around, so just bac=
k out.
> > +      */
> > +     if (num_other_online_cpus() =3D=3D 0)
> > +             goto skip_ipi;
> >
> > -             cpumask_copy(&mask, cpu_online_mask);
> > -             cpumask_clear_cpu(smp_processor_id(), &mask);
> > +     /* Only proceed if this is the first CPU to reach this code */
> > +     if (test_and_set_bit(0, &stop_in_progress))
> > +             return;
> >
> > -             if (system_state <=3D SYSTEM_RUNNING)
> > -                     pr_crit("SMP: stopping secondary CPUs\n");
> > -             smp_cross_call(&mask, IPI_CPU_STOP);
> > -     }
> > +     cpumask_copy(&mask, cpu_online_mask);
> > +     cpumask_clear_cpu(smp_processor_id(), &mask);
> >
> > -     /* Wait up to one second for other CPUs to stop */
> > +     if (system_state <=3D SYSTEM_RUNNING)
> > +             pr_crit("SMP: stopping secondary CPUs\n");
> > +
> > +     /*
> > +      * Start with a normal IPI and wait up to one second for other CP=
Us to
> > +      * stop. We do this first because it gives other processors a cha=
nce
> > +      * to exit critical sections / drop locks and makes the rest of t=
he
> > +      * stop process (especially console flush) more robust.
> > +      */
> > +     smp_cross_call(&mask, IPI_CPU_STOP);
>
> I realise you've moved this out of crash_smp_send_stop() and it looks
> like we inherited the code from x86, but do you know how this serialise
> against CPU hotplug operations? I've spent the last 20m looking at the
> code and I can't see what prevents other CPUs from coming and going
> while we're trying to IPI a non-atomic copy of 'cpu_online_mask'.

I don't think there is anything. ...and it's not just this code
either. It sure looks like nmi_trigger_cpumask_backtrace() has the
same problem.

I guess maybe in the case of nmi_trigger_cpumask_backtrace() it's not
such a big deal because:
1. If a CPU goes away then we'll just time out
2. If a CPU shows up then we'll skip backtracing it, but we were
sending backtraces at an instant in time anyway.

In the case of smp_send_stop() it's probably fine if a CPU goes away
because, again, we'll just timeout. ...but if a CPU shows up then
that's not super ideal. Maybe it doesn't cause problems in practice
but it does feel like it should be fixed.

-Doug

