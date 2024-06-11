Return-Path: <linux-kernel+bounces-210601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B158C904611
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CAD1C2346A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450C152E12;
	Tue, 11 Jun 2024 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cxm9zCv1"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF4C763F2
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140135; cv=none; b=GLwwF80FWav0vLFgdXZ0D/lAftcMu2djFWncFOQEJJZcF4KaPS3mjzkUmozXOSi97J2jwNUDprn1iF+P+Sbshn6IoizaUM4+43ofbQejgG4r2jMqGXr0vLx/RPumwtSV2WewTfCfdR0khPk8cGJVrFChDRcCwNFzcgeUIMe4IDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140135; c=relaxed/simple;
	bh=s73kx/qkmllyoFJabQ4swMZUTOUEOOuq9/NOP0odZQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCURsK/0g4ZIPgMsGXvO66XzxgyF0C/p6x1TNdr6qveE7zsbcSf2jkpN8185fB75gYyA3zzJFx6fa45DWL6n2hJUir6zpHuFoNj4dnmDcgNqtnkPbBd/h9V3V/wJXWBUOgtZ54F919ez4vRQS5ZNTkfy6ZvY1yOANZqDhuZ5xKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cxm9zCv1; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so2144317a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718140132; x=1718744932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=alDbuvqzhZBPPdXqSWlCg+9FBjnZcAzHPWh0nIeAhME=;
        b=cxm9zCv1WDbislCMFQE64XdroGAxxRXKzYQhEVJsRDxKFk6dF1yssrLK3YNHf69cJA
         pZrMKyGVB6+VxBVnUuzUkUzJD+3QrJtcxZWrAgG6Py5tejj5TEDm86UmfZ0kuwobxqOc
         bg9hqIjPLgAMxy0tn5Hyjo9gL6l7MgRV93r3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140132; x=1718744932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alDbuvqzhZBPPdXqSWlCg+9FBjnZcAzHPWh0nIeAhME=;
        b=ciLy41V2mAapiZVgD8KrDQxSCBwZXW0M2ry2+H2CSuxUBR2yxrmFUS10TdY8k1YjXs
         uMJyIJNiLYWacVNaNKSERdRHV9J+rJXmXT41gh59PcH23DoqozcPCkmo8DBSsDzB873w
         r2ERBvKyGmKSUhALrYuThs2Ks/tFSu7GdKRiorQ/sQOSNhG65fQqQHcJ8BD+DZm4mnfz
         PuzfvK42iMeWFfjw5vdY5ze+cYMEl44+ll2wmt3gLCPhzN0tABC8kEPAImpHvYytkjPw
         yR/e5b3UBMTfmvVBUJYMIKIucvuEEM+R8bHLaam8qcLOml/MHcfrsil38khs/1b078ae
         vxWg==
X-Forwarded-Encrypted: i=1; AJvYcCWha50hHP11YkN5qHbeZowH/LzSdHiZ+JkL/IAQZSrydk6q7A0z+bLloP3+KdRadXk/DQDE3xUwYaRtZYzlTUJsBvylr2vfIt/nVdIN
X-Gm-Message-State: AOJu0Yzo+x5C5rqmxwt0wdz8hDKXSzXC7hEn/pTSdNz2IHTRiIFCFgG5
	AYn+t392qOUaJVcSwM8v1j86C9Sl8GdCHpF1xb/VZjR+XhowJuhDaJ1Gy2ovShWUng9y7ZzhRZ0
	fm+kC+Q==
X-Google-Smtp-Source: AGHT+IFeGDO0YDqRUAw3SuT4Zp6vXKgylnvvo4B8TxiiqytK/3hmkIeCk+7JtDfnHROb/yK/ULhmdw==
X-Received: by 2002:a50:9989:0:b0:57c:6461:9981 with SMTP id 4fb4d7f45d1cf-57ca9751860mr54531a12.17.1718140131777;
        Tue, 11 Jun 2024 14:08:51 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c855b959bsm3660348a12.38.2024.06.11.14.08.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 14:08:50 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f253a06caso175030666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:08:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXy2I0REU/Jjc7PPkj0xd9P65IH0Pz5kp5B5wkE8zAEEYRmxAJC2hnKd3FQpydKzntjYjk+78KpPUvVI/aUWs0B0RvaOQ/S5X1WuUB9
X-Received: by 2002:a17:906:f191:b0:a6f:37b7:52e6 with SMTP id
 a640c23a62f3a-a6f37b75431mr247440966b.2.1718140129865; Tue, 11 Jun 2024
 14:08:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org> <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
 <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
 <ZmiN_7LMp2fbKhIw@J2N7QTR9R3> <CAHk-=wipw+_LKyXpuq9X7suf1VDUX4wD6iCuxFJKm9g2+ntFkQ@mail.gmail.com>
 <CAHk-=wgq4kMyeyhSm-Hrw1cQMi81=2JGznyVugeCejJoy1QSwg@mail.gmail.com> <ZmiyA3ASwk7PV3Rq@J2N7QTR9R3>
In-Reply-To: <ZmiyA3ASwk7PV3Rq@J2N7QTR9R3>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 14:08:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=widPe38fUNjUOmX11ByDckaeEo9tN4Eiyke9u1SAtu9sA@mail.gmail.com>
Message-ID: <CAHk-=widPe38fUNjUOmX11ByDckaeEo9tN4Eiyke9u1SAtu9sA@mail.gmail.com>
Subject: Re: [PATCH 4/7] arm64: add 'runtime constant' support
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 13:22, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On arm64 we have early ("boot") and late ("system-wide") alternatives.
> We apply the system-wide alternatives in apply_alternatives_all(), a few
> callees deep under smp_cpus_done(), after secondary CPUs are brought up,
> since that has to handle mismatched features in big.LITTLE systems.

Annoyingly, we don't have any generic model for this. Maybe that would
be a good thing regardless, but your point that you have big.LITTLE
issues does kind of reinforce the thing that different architectures
have different requirements for the alternatives patching.

On arm64, the late alternatives seem to be in

  kernel_init() ->
    kernel_init_freeable() ->
      smp_init() ->
        smp_cpus_done() ->
          setup_system_features() ->
            setup_system_capabilities() ->
              apply_alternatives_all()

which is nice and late - that's when the system is fully initialized,
and kernel_init() is already running as the first real thread.

On x86, the alternatives are finalized much earlier in

  start_kernel() ->
    arch_cpu_finalize_init ->
      alternative_instructions()

which is quite early, much closer to the early arm64 case.

Now, even that early x86 timing is good enough for vfs_caches_early(),
which is also done from start_kernel() fairly early on - and before
the arch_cpu_finalize_init() code is run.

But ...

> I had assumed that we could use late/system-wide alternatives here, since
> those get applied after vfs_caches_init_early(), but maybe that's too
> late?

So vfs_caches_init_early() is *one* case for the dcache init, but for
the NUMA case, we delay the dcache init until after the MM setup has
been completed, and do it relatively later in the init sequence at
vfs_caches_init().

See that horribly named 'hashdist' variable ('dist' is not 'distance',
it's 'distribute'). It's not dcache-specific, btw. There's a couple of
other hashes that do that whole "NUMA distribution or not" thing..

Annoying, yes. I'm not sure that the dual init makes any actual sense
- I think it's entirely a historical oddity.

But that "done conditionally in two different places" may be ugly, but
even if we fixed it, we'd fix it by doing it in just once, and it
would be that later "NUMA has been initialized" vfs_caches_init()
case.

Which is too late for the x86 alternatives.

The arm64 late case would seem to work fine. It's late enough to be
after all "core kernel init", but still early enough to be before the
"generic" initcalls that will start initializing filesystems etc (that
then need the vfs code to have been initialized).

So that "smp_init()" placement that arm64 has is actually a very good
place for at least the dcache case. It's just not what x86 does.

Note that my "just replace the constants" model avoids all the
ordering issues because it just does the constant initialization
synchronously when the constant is initialized.

So it doesn't depend on any other ordering at all, and there is no
worry about subtle differences in when alternatives are applied, or
when the uses happen.

(It obviously does have the same ordering requirement that the
variable initialization itself has: the dcache init itself has to
happen before any dcache use, but that's neither surprising nor a new
ordering imposed by the runtime constant case).

There's an advantage to just being self-sufficient and not tying into
random other subsystems that have random other constraints.

              Linus

