Return-Path: <linux-kernel+bounces-211100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD2B904D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC44C1F220FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6024C16C436;
	Wed, 12 Jun 2024 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="owgj1tK8"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB2417C9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718178516; cv=none; b=qYHTJYakqmm5SDX0Vfs7FeGYM+4hRlqxTCR8Jt7ZXX3PupmBcdhfd1Kb8uwL+oGD+ZldD9HUJWA4KTZSBl1sC0NqkUL4QlK6l5/A73Y9Aj4+ceEi3PrbPQ/BWsJhD4Xy1mif55VnoX1Z5q08EhKE0dJnQIVWlhwdDYKEEPbn01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718178516; c=relaxed/simple;
	bh=lBUAuCh6WQTSc26sbqbHcPEdHufPV6icZ6onUz+5Vaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHSLAHNe5HNQWzh7V8svH40QkqzdXIMrLYDSlCL5YI0xPcfirOGO7G8C/V2U1QkUatW++If3CAI4vsZjRyDVqJwZBKltbF1igWdQ0o8BYRmKyw7RSJBspPzF7tt1Oa+QBxqS+t/XWMUzbUUPdJsKO1cFCEYV5tvv62QZna49rdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=owgj1tK8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c32d934c2so4015261e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718178513; x=1718783313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBUAuCh6WQTSc26sbqbHcPEdHufPV6icZ6onUz+5Vaw=;
        b=owgj1tK8aFPFVvcihFZ3Vb9aoNIkduMy4hIEWAMe/slmZrh+1y4pFthSsVuhILzaQH
         MBvSSam9A88BIR2J9XAb/VmqwzBM0OoBE9wgGfrF8LYBBzpgblnHbmmGVp4iP6ivScuU
         BdTL8shi+gWTtvkdRWT2AzakeO3PgAqpywvpa+YKCfcx561OwMzghvyM3+W6Z95sR4VP
         RvG1g/TzmpmH53XkqEEBe8ORO2/zNg77cm5YVMzVqLPmYvCmnKDMAjJVjh77FSEIP6TZ
         iHLZZ/3bHJwxX2gJWvyaVDdgZbs6k1uJZ9n9fgIJrMKgboK+5k9mRWzYL9v0gDc6or4F
         vxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718178513; x=1718783313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBUAuCh6WQTSc26sbqbHcPEdHufPV6icZ6onUz+5Vaw=;
        b=iO06TPp+jR9/Lm6pe4YTXkUoMS+c/jwVr0fZjWmDgT+dKZ34dsB0Zvf8jYyLyx01PP
         3fAr1SWZj6C+DGVABpI3oeHVSqL0Zjg4cHzPesQaMBaRnR3hqgbBw1vES0Lv5jwot1tJ
         VeEPYNKzfHRw/xcB7jVqKW7CSDLgGKs7zgkJS5kV1zHFiCIiemYejZXlKtvHJnsexeM0
         7+UyUGZPFqWQOkyFqERhckmWIYfelWL2TLEoM1ihbEqhtWWtWZ58NDW93lqPYCneZruZ
         r5lETQSxKvp7leGskqWI71+hqwUD6M4h47Wk7mnSQl1OUwVLCTAsGRs7ohOiA9NH+CpZ
         WljA==
X-Forwarded-Encrypted: i=1; AJvYcCWIBXnrVPRbQlYtVveHYGYBsD13nhO7JnyX+gnsqVVevZ9ShmoYfzTZylcVrbiZ+sFb3zNkDg3U+5pipL0oeSKDneJ+c2FFXOMoxBqr
X-Gm-Message-State: AOJu0Yw/CSMJyNuTnLB47Iy1I5tc7G3FfuZ4yn3Vo9M7IEvNn/aC/Ejd
	GwhbJw23ZI16TFBA+Fj1+w955MFts5toagXFgmvv3BgFkI3q7rlyIiAv2+gdXwlrf+RiheHryvn
	DoR64t2bs2Nup0xXORi1ONchOsIAIwQvICk7jwQ==
X-Google-Smtp-Source: AGHT+IHWXOJ9zxK0Krc87a/DuMPE/dT5eubjqMnGYirztcGtqyAnVDLkEa2c9eodnVUEVB7B066Wp+GO25Q/2WayE1w=
X-Received: by 2002:a05:6512:1284:b0:52c:7a2d:5d5d with SMTP id
 2adb3069b0e04-52c9a3b9e12mr725836e87.3.1718178513041; Wed, 12 Jun 2024
 00:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531162327.2436962-1-jesse@rivosinc.com> <20240531-uselessly-spied-262ecf44e694@spud>
 <b199fde6-c24e-4c18-9c38-fdc923294551@ghiti.fr> <20240603-stinking-roster-cfad46696ae5@spud>
 <ZmNWmxak9Rc80Kpb@debug.ba.rivosinc.com> <c288f739-2a1a-4fd7-884b-12e360a33142@rivosinc.com>
 <20240610-qualm-chalice-72d0cc743658@wendy> <01547275-8c8c-43cf-9da0-64825c234707@rivosinc.com>
 <Zmdq6kszPBxAvLdD@debug.ba.rivosinc.com> <20240610-earplugs-anybody-ebd04a5fa777@spud>
 <Zmht+h75GgxP3ocz@debug.ba.rivosinc.com> <c1f5a958-1130-4bdb-a154-0c0eeb06c8f9@rivosinc.com>
In-Reply-To: <c1f5a958-1130-4bdb-a154-0c0eeb06c8f9@rivosinc.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 12 Jun 2024 00:48:23 -0700
Message-ID: <CAHBxVyEpfdpnazufL-oC=r1BoMzyXGdUhSbHPMOZfOj=cb6XkA@mail.gmail.com>
Subject: Re: [PATCH v0] RISC-V: Use Zkr to seed KASLR base address
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Deepak Gupta <debug@rivosinc.com>, Conor Dooley <conor@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 12:15=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
>
>
> On 11/06/2024 17:32, Deepak Gupta wrote:
> > On Mon, Jun 10, 2024 at 10:56:35PM +0100, Conor Dooley wrote:
> >> On Mon, Jun 10, 2024 at 02:06:50PM -0700, Deepak Gupta wrote:
> >>> On Mon, Jun 10, 2024 at 11:16:42AM +0200, Cl=C3=A9ment L=C3=A9ger wro=
te:
> >>> > On 10/06/2024 11:02, Conor Dooley wrote:
> >>> > > On Mon, Jun 10, 2024 at 10:33:34AM +0200, Cl=C3=A9ment L=C3=A9ger=
 wrote:
> >>> > > > On 07/06/2024 20:51, Deepak Gupta wrote:
> >>> > > > > On Mon, Jun 03, 2024 at 01:47:40PM +0100, Conor Dooley wrote:
> >>> > > > > > On Mon, Jun 03, 2024 at 11:14:49AM +0200, Alexandre Ghiti
> >>> wrote:
> >>> > > > > I don't know all the details but on first glance it seems
> >>> like instead
> >>> > > > > of ACPI,
> >>> > > > > may be FWFT is a better place for discovery ?
> >>> > > > >
> >>> https://lists.riscv.org/g/tech-prs/topic/patch_v12_add_firmware/10647=
9571
> >>> > > >
> >>> > > > IMHO, doing discovery in FWFT is not the goal of this
> >>> extension. I think
> >>> > > > the "real" solution would be to wait for the unified discovery
> >>> task
> >>> > > > group to come up with something for that (which is their goal I
> >>> think) [1]
> >>>
> >>> Yeah I understand the conundrum here.
> >>>
> >>> > >
> >>> > > I'm curious to see how that works out. The proposal documents an
> >>> m-mode
> >>> > > csr, so we'd have to smuggle the information to s-mode somehow...
> >>> >
> >>> > Ahem, yeah, I spoke a bit too fast. Looked at the proposal and the
> >>> > mconfigptr CSR will be accessible by M-mode only so I guess we will
> >>> have
> >>> > to find another way...
> >>>
> >>> That's not the only problem. Even if you get mconfigptr access,
> >>> parsing the format
> >>> is another thing that has to be done. This is early in boot. Although
> >>> its strictly (pun
> >>> intended) not a firmware feature extension, I think it's much easier
> >>> to ask underlying
> >>> firmware if platform is `Sstrict`. or may be expose something like be=
low
> >>>
> >>> `ENABLE_SSTRICT`.
> >>> Platforms which support `Sstrict` can return success for this while
> >>> platforms which don't
> >>> have `Sstrict` can return error code (not supported or not implemente=
d).
> >>> This way its not feature discovery.
> >>
> >> I mean, it's feature discovery in all but name. You're calling it
> >> enable, but the behaviour you describe is feature discovery - not that=
 I
> >> am against this being feature discovery since it gets us out of an
> >> annoying bind.
> >
> > Yes I know it's cheating but at least for this case, it seems like easy
> > solution which
> > doesn't break anything. Neither I see it creating any future problems
> > (except FWFT becoming
> > to look like discovery mechanism :-) and Clement/Atish hating me for th=
at)
>
> Ahah no worries;) Thinking a bit more about it, if we need only a few
> extensions to be discoverable, it seems manageable (ie add a "locked"
> feature that report the extension availability itself, get only will
> work, set will return SBI_EDENIED). But if need more of them, then a
> dedicated mechanism should probably be designed.
>
Retrying again as gmail switched my default to html again :(. Sorry
for the spam.

Yes. Once it is allowed, there will be many more in the future :).
Reading this thread, it seems we need early detection for these 3 now.

Zabha/Zacas/Zkr

Is there any use case for obtaining additional information related to
an ISA or just extension presence is enough ?
+Sunil (in case he has some tricks in ACPI land for early parsing).

Otherwise, we may have to come up with a separate mechanism for early detec=
tion.

> Cl=C3=A9ment
>
> >
> > Another solution to this could be introducing a riscv config
> > `CONFIG_RISCV_SSTRICT`.
> > By default always select `CONFIG_RISCV_SSTRICT` and any platform owner
> > who are not
> > sstrict, they can build their own.
> > I expect distro (ubuntu, red hat, etc) would want by default
> > `CONFIG_RISCV_SSTRICT`.
> >
> >>
> >> I forget which extension Alex and I discussed previously, but there's
> >> some mm-related things that you're gonna have to probe super early and
> >> we need to figure out if we can get that info from ACPI or not. I know
> >> we discussed it w.r.t. one of the T-Head vendor extensions, but I thin=
k
> >> another standard one got mentioned too.
> >>
> >>> It seems like arm64 parses fdt and it reads certain CSRs too
> >>> (`arch/arm64/kernel/pi/kaslr_early.c`). Although it doesn't look like
> >>> it has to do any
> >>> discovery for them.
> >>
> >> A decree from the Palmer that we don't support things that do not conf=
orm
> >> in this manner would allow us to do what arm64 does. I brought this up
> >> originally because it's been discussed before that we cannot rely on
> >> conformance because we want to support people's platforms, whether the=
y
> >> comply or not. I'd be wary of making this an exception now, and then
> >> later on someone makes a platform we want to support that doesn't
> >> conform and hey presto, we regress KASLR support - even if I think it =
is
> >> pretty unlikely that someone is going to repurpose the Zkr CSRs.
> >>
> >> One of the problems with only supporting conforming platforms is that
> >> the definition of conforming changes over time! This has happened with
> >> the Andes PMU for example, which I believe uses an interrupt number th=
at
> >> was later co-opted by AIA spec. That conformed at the time, but doesn'=
t
> >> anymore - do they get to mark themselves as Sstrict?
> >>
> >> Maybe we can do this on a case-by-case basis, but it's up to Palmer
> >> whether or not we can do that.

