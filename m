Return-Path: <linux-kernel+bounces-344497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F1D98AA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E861F21641
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA2D190471;
	Mon, 30 Sep 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fkqg2yN1"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864F5103F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715659; cv=none; b=RX+nn2oKNJDh9o3FrlyRuDpeZC2rCBMe15lDHL7/J8eOguQmunCoabWvVNVpTeNubL4k141DCnJ6c17Kn2dis8M3vAiGEkHKCOQ0sNOkvoLT0t27nWGThnZWabVkBTC2PxQ9HPX+FQDu+cs6fJsTfzfbu/iq0nQV3qpThUYldUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715659; c=relaxed/simple;
	bh=H7ur/T7iO6R88OthARaE995lBV+/8aFowb8cMGfmGUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENIz1s/x1NqexpRQuWqQZkqkyQxTTlqSc6fA+AtRj1anAARs9/GjI0u1Bjjd8MB5+QX6KBTu1OcPGzSKRIwK9cRgweqsUmLNbrAYltglRSqHw34oCDAXdODR9mn11z2dsy0qdl1TM0mgP/4yEzJZecXgTdm09GrOxttGfRKNh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fkqg2yN1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d60e23b33so693239866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727715655; x=1728320455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3znAsBCdzS/c5Od2Q2Rl5tlqscdVmIevB90CYR5iKU=;
        b=Fkqg2yN1ACI+U6Ebb8dlq3z8paQo59Ke4oklq4Dh5GqFpwOFYVIKiMoZlSygkYvo62
         gvWsHKEgRYxrOfCNIn0ACdEZej0VP494kTBpLQJwPbmIq9oI/Igr4mMkGeD12/wOZIV9
         gWVnjWKwUfYngCJZAxuZE5nkGp43XbUu4hBa1nq822+sZPaLy25PpOk+1UXPibTYx1Zf
         pTA0mMTZ5EWDNr7Fy4ptRyRTD/Bp9FXUr0jpZtlhDoRcNQHRvMN8Ahn/qeUTYSGAPGYn
         aT1Vftb70/jPxsh8/+K0ojehLJqQnS/dUAayQztM/rrXeHWO5d+9YZdKMGzfesw6mo38
         Hjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727715655; x=1728320455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3znAsBCdzS/c5Od2Q2Rl5tlqscdVmIevB90CYR5iKU=;
        b=EE6KnbCPzjShKzljRAOaM3tCUFQVF3fS9c+ItXTUl5Hwnbo9h9yhaMIeew7P29gEeh
         PO9m/5Q4iSHfIUZ/k2AR6X8Re7hMmq+/V0xMx5iTD83+1rdz7uaFLkCBAKe+bAXY0izp
         2Mls18VpiAvGqdk5UrgZTOXFuRA0dpLqa/pkjN2LVPwtsNxqzunqDHW0v4OCNW1BhXyd
         /y4rX+DLuHxJzy1zK2LnF8vOIGIQZ88zSKTuyRefqf6zBiJjn3hLrkVVhMMlt39eBCoi
         ouNdg9cJ9dWw9ps58x0OYepMER+9c3wXzzUNgoBRkxD72b6D9z4d74M5MamY+qRjypTQ
         yC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVs+j+fjBWTP4p96z/WXr0hb4hRh4ez6Rdaom2XNTotRxo1YkE1mP34tM64nW0uqr1QgY68WaAUkVdyDcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLAGXyMivHS28D9CuRjnZbMqNmibi6Kejl54FjVi1ibj6WzXp6
	UjGs9k1tLrEwJ9vr0nD7TupxX4xk1PTFi9Fc1bGDHzKzQ6iMA5PbX6YEedBCKMfI5TJ/9mJEZbO
	W1mXv4YEv0HwoKsYZPnl4Y22V4/U=
X-Google-Smtp-Source: AGHT+IFIxp8IUZiIfR+LjL4xzRFDTGuCKnOuvq0lQfvlgXiPjOYm2d5npd8wBRxu4/ngy7CN79KkIf1s8oQrJCO+iyk=
X-Received: by 2002:a17:906:4fc6:b0:a7a:8586:d36b with SMTP id
 a640c23a62f3a-a93c48f6664mr1390078466b.3.1727715655000; Mon, 30 Sep 2024
 10:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927194856.096003183@infradead.org> <20240927194925.283644921@infradead.org>
 <CAADnVQ+qDAzjyRuN6sdpw8RjB4XQ1EyyMJ_uYXeDspbW58fC3A@mail.gmail.com> <20240930082314.GE5594@noisy.programming.kicks-ass.net>
In-Reply-To: <20240930082314.GE5594@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Sep 2024 10:00:44 -0700
Message-ID: <CAADnVQ+26b2t9LSwsSZuhL3CppvJvaucqU3UvO=ioLNdC67cyQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] x86/ibt: Implement IBT+
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	alyssa.milburn@intel.com, scott.d.constable@intel.com, 
	Joao Moreira <joao@overdrivepizza.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 1:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Sep 29, 2024 at 10:38:58AM -0700, Alexei Starovoitov wrote:
> > On Fri, Sep 27, 2024 at 12:50=E2=80=AFPM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -555,6 +555,8 @@ static int emit_patch(u8 **pprog, void *
> > >
> > >  static int emit_call(u8 **pprog, void *func, void *ip)
> > >  {
> > > +       if (is_endbr(func))
> > > +               func +=3D ENDBR_INSN_SIZE;
> > >         return emit_patch(pprog, func, ip, 0xE8);
> > >  }
> > >
> > > @@ -562,11 +564,13 @@ static int emit_rsb_call(u8 **pprog, voi
> > >  {
> > >         OPTIMIZER_HIDE_VAR(func);
> > >         ip +=3D x86_call_depth_emit_accounting(pprog, func, ip);
> > > -       return emit_patch(pprog, func, ip, 0xE8);
> > > +       return emit_call(pprog, func, ip);
> > >  }
> > >
> > >  static int emit_jump(u8 **pprog, void *func, void *ip)
> > >  {
> > > +       if (is_endbr(func))
> > > +               func +=3D ENDBR_INSN_SIZE;
> > >         return emit_patch(pprog, func, ip, 0xE9);
> > >  }
> >
> > Makes sense, but it feels like it's fixing the existing bug
> > that we somehow didn't notice earlier?
>
> Before all this func()+0 was a valid call address -- as it's been
> forever.
>
> While it is true that with the introduction of ENDBR some compilers will
> do direct calls to func()+4 to avoid the ENDBR (less instructions, more
> faster etc..) this was very much an optional thing.
>
> Notably, up until this point we would use a 4 byte NOP to seal(*)
> functions, specifically so that anybody doing direct calls to func()+0
> would continue to work.
>
> These patches however change all that by sealing with a 4 byte UD1
> instruction, which makes direct calls to func()+0 fatal. As such, we
> must guarantee all direct calls are to func()+4. So what used to be an
> optimization is now a strict requirement.
>
> Indirect calls still go to func()+0 (or func()-16 for FineIBT) and will
> go *bang* if !ENDBR or UD1 (depending on the hardware having CET/IBT
> support).
>
> (*) with sealing we mean the explicit action of disallowing indirect
> calls to a given function.

I see. Thanks for explaining. I would copy paste the above details
into the commit log.

