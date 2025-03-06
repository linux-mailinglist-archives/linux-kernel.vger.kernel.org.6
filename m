Return-Path: <linux-kernel+bounces-548697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2DFA54849
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA2E188E527
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326CB202C56;
	Thu,  6 Mar 2025 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7c8RTxs"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4AF1A23A2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257946; cv=none; b=T630ke9MKQiMpvcGxjIyN6MJd5P9bd5v7oS/N30AEU1IMgQvxfEc9o2OFR+9QOYRR2IsXukf1iugOOudGmIlZfZBsovUENkt2/FST+oTFJyyuCbPF88hh07Nrqig9alLN6BXtUMQ5kM4vPW95EnyxXfMbO9X6vaAc1/pB8F/0G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257946; c=relaxed/simple;
	bh=bNv2kObGR5EMr/+8H5Ii/0GRC7NMFaY3b9AJsTQZiuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLbBpipnLTZSAj5O+33ammqkLoNk8slILNbP76zW8XDLNLrir77bh0kUaSZUIZOpkw/AP0/G25rQn3HChmWZ0xwqmo6QcTdGjcWXh8ErtSJEDyQt0Scage0mV5zJZJvozovWdDSg8wA5UZqqu74ikuSnNEau6ZcbVwTETVL3qHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7c8RTxs; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a59so5395881fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741257942; x=1741862742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNv2kObGR5EMr/+8H5Ii/0GRC7NMFaY3b9AJsTQZiuY=;
        b=a7c8RTxsZNT3SVX9Ce7uZwTC1TS4G3d1xZ9uvjp7oedSHZGgnm4su6MnZpFAPHefll
         V16XKEa6e4rUOYKADlokFkexA05OFQ0TN5Bilb5ZtJNO4XzoNFnLXJ0jhaQ5JeZPIDYH
         XtxdhXDAiQlLA2EXdrBVtLN8z8OHZEHl1nLW6S56dJVTQiyujbm1/r6SkqCQF4/XtAMB
         YZuiTLQDNpHb2NEnkybKx9qYvKTJN5ZZW4V3a7MMFICpkzsOs6GmI9GSBNAlwuePSwce
         CEG/dVGC6o3cbSulfS2u0O9lde4KTdUMZ+0faevLg7HYZo3gAwwJayIgFGO5GS6rCgE8
         1y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741257942; x=1741862742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNv2kObGR5EMr/+8H5Ii/0GRC7NMFaY3b9AJsTQZiuY=;
        b=Wkmirhm/7SMFhFfaDKKw84mUwTbEZwnOFv2hXWicU08IwBk+MunPsdIG+FFxNKn+9Q
         0Bfqdc+/hkrA8AtaLVAuG/ny1ZmqktOi3gQWUP2UDVNMUvCcpI2agl95SsmT/Oowt1+C
         Da1PpfUU7xQjAelYRFwvcwIHgdGyAaCAA67TStYl6rJJyg7G3fCLBi0VPuqyCVdR+XD4
         ukE1FfCAx7zyBBRncmJqo6HW55x7F9ULrL3bBHqj4hQtsdc0JwPdgDhE3RPDWi4LDC28
         6vGSQqBIjkexYbhMGwDWdmVB3NvAEu+WAUT25kzPsdic03zCybX4JOQSt8Tisi+eikmu
         irCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdtLK6VsbpspmKSFOd/hAwVgSOSM7bomR6VKxtUwVx7wJ+AibntyFT1r/XumcUhu/EtRqsUQmSEFXlPvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQG71dBDD2EGJPwC8d+l/jLZjpivJhyS3bnilJak09zKgCXEY7
	b09V3qddE2MXiRHheCj+3zsO2SaoPzU7Atv4G4CM4QlFU2IdA0INIJ/Hc3Pnmn2GIEA68WyI+a+
	b9OERA1GU6rCax4N4T8epLwO88PU=
X-Gm-Gg: ASbGnctGTzbGZADO6ptn5Bz4QB1Q+EnfPworr0lJqBJ6f/2i4AKK2nZxJOx03xTXKVM
	kH4jCjpdpDmLtHglJgKUMLJuEou5lLrfJKtgm+1dUpo1Px3gwJhCS3VrfyuJnGL+9xnc10Le7H7
	NBCJll9cLo3Oixvx5XNzWgf/SuiQ==
X-Google-Smtp-Source: AGHT+IHtr48fZTkeFEP2QP2QJIgBUVrELcSm8UZ72djIu8UdSuOEclq7Iir0pCi8Zu+PvQl6UhPw6TRTXmFxc9zAAuM=
X-Received: by 2002:a2e:9dc4:0:b0:30b:eeea:9213 with SMTP id
 38308e7fff4ca-30beeea92dfmr2750751fa.17.1741257941602; Thu, 06 Mar 2025
 02:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123825.2729925-1-ubizjak@gmail.com> <20f1af22-71dc-4d62-9615-03030012222e@intel.com>
 <CAFULd4bpHGE83qc37sbh=rpGj+SFqQrsNDLzL_-NQpo6pQH3jw@mail.gmail.com>
 <c4aca08a-95c1-48ee-b4da-55a69b74101c@intel.com> <CAFULd4YVOEtT+bsp9H7ijaoJn2e2108tWhiFarRv=QxoUMZaiw@mail.gmail.com>
 <20250301123802.GCZ8L_qsv7-WwUwqt5@fat_crate.local> <CAFULd4b=4rHcVAVSg_3yMb8=3ReiSriw_rM4vJL9_HvheXE92w@mail.gmail.com>
 <CAHk-=wgBMG7CcwvW15ULJOsVEq5QRSj+ccgaUJU+XGxJKeXEVw@mail.gmail.com> <20250305201429.3026ba9f@pumpkin>
In-Reply-To: <20250305201429.3026ba9f@pumpkin>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 6 Mar 2025 11:45:38 +0100
X-Gm-Features: AQ5f1Jr5RLTsRHKRNl-4-ba7nu6aKjXYs6WdR1kvKZUyAEyZC7JV-VIsStIL_ys
Message-ID: <CAFULd4ZzdPcnQAELpukF4vzUnQufteNqV4BzZr3BxuzRG+XK+A@mail.gmail.com>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 9:14=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 5 Mar 2025 07:04:08 -1000
> Linus Torvalds <torvalds@linuxfoundation.org> wrote:
>
> > On Tue, 4 Mar 2025 at 22:54, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > Even to my surprise, the patch has some noticeable effects on the
> > > performance, please see the attachment in [1] for LMBench data or [2]
> > > for some excerpts from the data. So, I think the patch has potential
> > > to improve the performance.
> >
> > I suspect some of the performance difference - which looks
> > unexpectedly large - is due to having run them on a CPU with the
> > horrendous indirect return costs, and then inlining can make a huge
> > difference.
> ...
>
> Another possibility is that the processes are getting bounced around
> cpu in a slightly different way.
> An idle cpu might be running at 800MHz, run something that spins on it
> and the clock speed will soon jump to 4GHz.
> But if your 'spinning' process is migrated to a different cpu it starts
> again at 800MHz.
>
> (I had something where a fpga compile when from 12 mins to over 20 becaus=
e
> the kernel RSB stuffing caused the scheduler to behave differently even
> though nothing was doing a lot of system calls.)
>
> All sorts of things can affect that - possibly even making some code fast=
er!
>
> The (IIRC) 30k increase in code size will be a few functions being inline=
d.
> The bloat-o-meter might show which, and forcing a few inlines the same wa=
y
> should reduce that difference.

bloat-o-meter is an excellent idea, I'll analyse binaries some more
and report my findings.

> OTOH I'm surprised that a single (or two) instruction makes that much
> difference - unless gcc is managing to discard the size of the entire
> function rather than just the asm block itself.

Actually, the compiler uses estimated function code size as one of the
conditions when to fully (or partially - hot/cold split) inline the
function. The estimated code size of functions that use (patched)
locking primitives is now lower, so now they fall below the inlining
threshold, causing the compiler to do more inlining. Compiler knows
the performance/size tradeoff of setting up a function call and the
perf/size tradeoff of creating the function frame in the called
function and decides accordingly. Please note that the inlining is
multi-level, so it doesn't stop at the first function.

Thanks,
Uros.

