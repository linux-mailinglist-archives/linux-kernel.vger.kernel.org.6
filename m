Return-Path: <linux-kernel+bounces-545811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83980A4F1CA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEFC216E0CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132B0200BA3;
	Tue,  4 Mar 2025 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwnpQNQI"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC191253F18
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132192; cv=none; b=pWyrmj35D2WkL/IOSmW78StcWCTSeehwdhrQEptSU3Zg8l5jky0MogTn+ekWy5n6t8zj9cTH8ifHGrRX7QC65AcnkZeAQrYhFUD/PGksHhefHOqv9REuhtSFQM23lG1tLP5Zyz+EgegWBZuGHOwvBYLK+88KRW2OIHAAj1jrhYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132192; c=relaxed/simple;
	bh=MzcidAAA2WDoz1FnZ6+miMSEMDiaMfaQvBPMDPcM/yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUiKGCx/q/jttDBfh35iQKwaOADW2E68Yd7y0YM4C9sFEa1YGXgDH0zQGq2N90jFdosq0HPCo9pgNlal/Kew+/eywd+GxgmNbsrvbyCcg4Yv/NTzksU6F+boxip46fwXAZiqHMp3GPrjexP7vAzbeut+mz2JKsHL9pRngwfWqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwnpQNQI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e4ce6e3b8cso455165a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 15:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741132189; x=1741736989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVZNT78n/RwxkIy8ddgo9iaNgzKgJM/Nw92joYKvL9E=;
        b=kwnpQNQIp+fc1KI0NHh6PiC2eKdBgiCIBUZAy2vpysA49q/sFm4FkajH46lOkGYr13
         AIfHcvR23V3nxfl0VLEUNsBBlPTVq00JcBVv/bxUQsvfh0lgY0DJa6GKvcvI7YoxGRMW
         k+zK49MBdHwfEBv5i0HW2JazI2zLTjROv/bJy2IgT0hPhiUoIbJ6HRE30mcOOyBbqtP7
         k7Sy9/7AsHQ0kQn1n3NwDnHXGQOawNfujCNtPeI0JvSKMKUI9BZPDuS+oiKpEopN/yw9
         eud5R7tkh0qXHQWLrzNa/cJW+Y+nHCttJ6VH/rResGn7VAxr+S/OMDasxDg9Lo34h4QA
         acGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741132189; x=1741736989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVZNT78n/RwxkIy8ddgo9iaNgzKgJM/Nw92joYKvL9E=;
        b=tvwrjZenyjskKOEPudnKwY/mccaFjqwV8EFTRSWrlBzALVwpI5W3TMYVvM83/ktn0o
         0ekprGakJmYyquTMhrHw726vMSEiw2IynvPDg8pZA3eyw9rgdNBOSr0LM+SuZ5nbTdXM
         nOQPSNBVmFPYyU1isy0qHZkrUhLp1Tqy20+ysHk3Ey1Zkcu/hGbnm2ZbuCo3JZSFDZgZ
         mxDUrImGufaKx1ew/SW8MmUpU76vF545HTtSgLV6sj+IA/51CD2UXTpEnDsSRvmzmqSJ
         fBTOTqhJ0pJMhZcatuXJpFxghKi42u5jJeTCjUQZDv4oaET09BoDUGWQ0I4fPlEixtKP
         BRFg==
X-Forwarded-Encrypted: i=1; AJvYcCWY1SRSSMNMeGWYHmsIVdtKlB6Kqq1hynipF2lkBKfQwetQ8/1FBW/o2C9fAGNu3bRCO8zynKDuRh2bF3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+C84OM698Os3C47LmIlYobr93ttxiFQdozsmkhYg3bp1/q65b
	U9Phkr7M6bLHBkFxM7ofXAnav2OC765yUIr7lPfiifzl08SLs1zHPmQvLvSphMQKW55PszOKqnP
	ysCEnxcVGmNjMJtwj2aORMDTeRjh00spuPYg=
X-Gm-Gg: ASbGncueUmr1iNMk/OjYm6u9wf45ppF89EymqbgN7hh39F4v39wy5wtp5h89ww+sKYE
	MmKCZQqlyPf9jGxIT0VVNGkf/1QHLoHujdqZ2doKNuCPoWzQKoVO3ttJth+H0rwCSp/Dw9UwzI3
	aIdcz+/JqWXE9NeoLpUBIkmKBR
X-Google-Smtp-Source: AGHT+IGFo/Sv81tvQjD58rJ+dQxi5hq9JKqVQ6plnq2gJfUDvHXejgBD63df7MTBLJWwFZOZepeeSlaXpQl3pvnMZbY=
X-Received: by 2002:a05:6402:4309:b0:5e4:d52b:78a2 with SMTP id
 4fb4d7f45d1cf-5e584f51077mr5077232a12.15.1741132188550; Tue, 04 Mar 2025
 15:49:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123190747.745588-1-brgerst@gmail.com> <20250123190747.745588-5-brgerst@gmail.com>
 <tns2rrzk7vs3linnjevr24qyg4sm6hakndsgqvqsowqwwlrdcj@zus5wu6u3ju3> <56A91DC4-1A8C-4134-976E-BBCBF9BC784F@zytor.com>
In-Reply-To: <56A91DC4-1A8C-4134-976E-BBCBF9BC784F@zytor.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Mar 2025 00:49:36 +0100
X-Gm-Features: AQ5f1Jr2g0eVXvOjRYArMqCEjJGFae3onDkhLpqPm8pnj09is18RjkzduriLMpI
Message-ID: <CAGudoHEQbBEbjXKfPR6+ktxj5GzBpQ+CjMXi+G7wqR-UQmW9Fw@mail.gmail.com>
Subject: Re: [PATCH v6 04/15] x86/pvh: Use fixed_percpu_data for early boot GSBASE
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 12:45=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On March 4, 2025 2:26:20 PM PST, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >On Thu, Jan 23, 2025 at 02:07:36PM -0500, Brian Gerst wrote:
> >> Instead of having a private area for the stack canary, use
> >> fixed_percpu_data for GSBASE like the native kernel.
> >>
> >> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> >> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> >> ---
> >>  arch/x86/platform/pvh/head.S | 15 +++++++++------
> >>  1 file changed, 9 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head=
.S
> >> index 4733a5f467b8..fa0072e0ca43 100644
> >> --- a/arch/x86/platform/pvh/head.S
> >> +++ b/arch/x86/platform/pvh/head.S
> >> @@ -173,10 +173,15 @@ SYM_CODE_START(pvh_start_xen)
> >>  1:
> >>      UNWIND_HINT_END_OF_STACK
> >>
> >> -    /* Set base address in stack canary descriptor. */
> >> -    mov $MSR_GS_BASE,%ecx
> >> -    leal canary(%rip), %eax
> >> -    xor %edx, %edx
> >> +    /*
> >> +     * Set up GSBASE.
> >> +     * Note that, on SMP, the boot cpu uses init data section until
> >> +     * the per cpu areas are set up.
> >> +     */
> >> +    movl $MSR_GS_BASE,%ecx
> >> +    leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
> >> +    movq %edx, %eax
> >
> >       movl
> >
> >I'm bisecting perf breakage and landing on this commit breaks the build.
>
> Breaks the build how?

  AS      arch/x86/platform/pvh/head.o
arch/x86/platform/pvh/head.S: Assembler messages:
arch/x86/platform/pvh/head.S:183: Error: incorrect register `%eax'
used with `q' suffix

Per the above, I presume it was meant to be a movl.
--=20
Mateusz Guzik <mjguzik gmail.com>

