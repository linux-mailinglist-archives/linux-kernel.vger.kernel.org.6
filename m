Return-Path: <linux-kernel+bounces-534236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E23A4647F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2721635D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AD4227581;
	Wed, 26 Feb 2025 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ims9Rm9e"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502942236FC;
	Wed, 26 Feb 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583483; cv=none; b=HvHeS2AdAdOmStLbsUQpVdb89OWrXutkIRC6l/HkIo3WFfM2Tmf0/lBzrU1aqZ/09LxIWAVGJgLISjFPIoo9x1Rt77PpCc+QhH4alH+Ntvz7MU4zANTkp9Kr4CEglxTup0BK4E915PzC2gGvRRPnKd1eGbwGqF429Y4ss5z+Shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583483; c=relaxed/simple;
	bh=3/PfVD/S0beWYFNeAotOPd40DSLrT6WAE68cwuy4Z/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDFCM0tcVkoXbonjZ8YcebWXz1xTqnuzLQ2hQvRDj6g7HcNeKkmOzOMXAskwD3k1PMLtKusfP4krYB+QcqVL+0VFM2Hmlf2bMVQpHgwT+Crha+6TetFXTCdryO/WEESiO1xyEe6toZ5KKjNXwOZsbrxbrhS9HrlH8QrcQJtcH2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ims9Rm9e; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4399d14334aso61126405e9.0;
        Wed, 26 Feb 2025 07:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740583479; x=1741188279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsuCvPIYOZxMSn5nKFFEtm5mHOuqFxBxK/9CbbLtirI=;
        b=Ims9Rm9eossstZC7XUZwLgl5/Qpf0CgvkKrY53U9ee7W1KiX6wyNXPNAbtSUChKpRj
         vUFkXM0m6HFMhP5M6GGyRWc6hXlnpd1pQ6le++fZroyjF8l2deoTPeNkMM9xEU2jT7IQ
         u2rSYh9kviIPZW3JeuC5vfffAaql9yjG4pDa+ctjCr4ZXzBd4vt7G3m+HAUUmkl0hJla
         ipGQ7nmw2YHnCINgnZ08xxjGH2YqJYZslVTNx6OMZAP5ZJcMwwJvwMmzSD2khPYKCxRW
         1V5rZIyw3+sYwAH4feGE7nR+/nKwVZZb6pezUtiuPCu/PZzMlpUnJC2T8V3oyz+wJJ6T
         WkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740583479; x=1741188279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsuCvPIYOZxMSn5nKFFEtm5mHOuqFxBxK/9CbbLtirI=;
        b=IdbtgEcF2CMupQ27FbTqiCxmbQETitNZuYH080Ejt2+iZvkjz+kDok1RbHnvi8RJLP
         vo9mocBcD61kXaUTxRgEUuRJDoz86qu8tgO/dIFx3LCjK7mG0tqTwrEw8qSZ/hywm3iv
         vtxL9aU0RauHQyxqhOcPTGABs7AZyEptyOtDMSIleyU1ZqMKqnuRraIQrgNccoeOrUiu
         /jzSJIYvn0ivacYk6VjtRdhMcmcg+SjO5cFHO5mZObEUCXnkVqsfRlTHriXo7amrmuI1
         78aKtsKyQjd73iRTUwEkybKiBykgQM4mfcKgEuy7/t16O6mGwJ6+QAZpa4gW4FwjHvIU
         LIvA==
X-Forwarded-Encrypted: i=1; AJvYcCVhAQW6pXibSMhNRTomZn2RNeIUymLykBWtiIUiL8wF7GMXXXMhvpktcQmOw2QvrbVm8NByina8uFFVFJOr@vger.kernel.org, AJvYcCVy6TMBp73UcretsHRUHy0V6lAI11VF/H01M/92TImKFDfxxvQUyNVHOtBoK1Chfi6mMuGr6za+eHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqRNdP/VHl+g+inZMm9IV7vgCdjNkTYhaklsugaKPDkXtj6L+8
	DIOX2ArO+5dcTeoAAm3p8OLvz6AR+6QMwM8fw2JkXiceXHRSXBbBAaoPCasI6HB1DwcncSnN6hm
	lbVyJysfQMBQEYW1Rkh3eRh5k5jA=
X-Gm-Gg: ASbGncs8CFaHs5TuPUUlaavT3bIjCUwT+iqYQbgWhVMb29zpL2LEYQuIMkTigBdFXj0
	py9hw44tArRgo7miEvH7pzKpT2G4yys6vUTNDOT5BnalLarlJIfaSSI+N9BLc/lpSOQvbje5g2m
	0migWXimPhqA==
X-Google-Smtp-Source: AGHT+IHrvicEAjuDRUywYtjbdluORS9DbtcVPJQWBJkKvDDRVQNrfEoh71Lo3le8ngVV4cTzym1PeNRSV0ffNMSQYUc=
X-Received: by 2002:a05:600c:3548:b0:439:8a44:1e68 with SMTP id
 5b1f17b1804b1-43ab9046de3mr32060425e9.28.1740583479193; Wed, 26 Feb 2025
 07:24:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739866028.git.maciej.wieczor-retman@intel.com>
 <2a2f08bc8118b369610d34e4d190a879d44f76b8.1739866028.git.maciej.wieczor-retman@intel.com>
 <CA+fCnZdtJj7VcEJfsjkjr3UhmkcKS25SEPTs=dB9k3cEFvfX2g@mail.gmail.com>
 <lcbigfjrgkckybimqx6cjoogon7nwyztv2tbet62wxbkm7hsyr@nyssicid3kwb>
 <CA+fCnZcOjyFrT7HKeSEvAEW05h8dFPMJKMB=PC_11h2W6g5eMw@mail.gmail.com>
 <uov3nar7yt7p3gb76mrmtw6fjfbxm5nmurn3hl72bkz6qwsfmv@ztvxz235oggw>
 <CA+fCnZcsg13eoaDJpueZ=erWjosgLDeTrjXVaifA305qAFEYDQ@mail.gmail.com> <ffr673gcremzfvcmjnt5qigfjfkrgchipgungjgnzqnf6kc7y6@n4kdu7nxoaw4>
In-Reply-To: <ffr673gcremzfvcmjnt5qigfjfkrgchipgungjgnzqnf6kc7y6@n4kdu7nxoaw4>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 26 Feb 2025 16:24:28 +0100
X-Gm-Features: AQ5f1Jpqwg1oQbqitjHoWgohREHEbfWOkzeGk2nGzOh9RmhEEI44EKvWgfDP0bM
Message-ID: <CA+fCnZejp4YKT0-9Ak_8kauXDg5MsTLy0CVNQzzvtP29rqQ6Bw@mail.gmail.com>
Subject: Re: [PATCH v2 13/14] x86: runtime_const used for KASAN_SHADOW_END
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Florian Mayer <fmayer@google.com>, 
	Vitaly Buka <vitalybuka@google.com>
Cc: kees@kernel.org, julian.stecklina@cyberus-technology.de, 
	kevinloughlin@google.com, peterz@infradead.org, tglx@linutronix.de, 
	justinstitt@google.com, catalin.marinas@arm.com, wangkefeng.wang@huawei.com, 
	bhe@redhat.com, ryabinin.a.a@gmail.com, kirill.shutemov@linux.intel.com, 
	will@kernel.org, ardb@kernel.org, jason.andryuk@amd.com, 
	dave.hansen@linux.intel.com, pasha.tatashin@soleen.com, 
	ndesaulniers@google.com, guoweikang.kernel@gmail.com, dwmw@amazon.co.uk, 
	mark.rutland@arm.com, broonie@kernel.org, apopple@nvidia.com, bp@alien8.de, 
	rppt@kernel.org, kaleshsingh@google.com, richard.weiyang@gmail.com, 
	luto@kernel.org, glider@google.com, pankaj.gupta@amd.com, 
	pawan.kumar.gupta@linux.intel.com, kuan-ying.lee@canonical.com, 
	tony.luck@intel.com, tj@kernel.org, jgross@suse.com, dvyukov@google.com, 
	baohua@kernel.org, samuel.holland@sifive.com, dennis@kernel.org, 
	akpm@linux-foundation.org, thomas.weissschuh@linutronix.de, surenb@google.com, 
	kbingham@kernel.org, ankita@nvidia.com, nathan@kernel.org, ziy@nvidia.com, 
	xin@zytor.com, rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com, 
	cl@linux.com, jhubbard@nvidia.com, hpa@zytor.com, 
	scott@os.amperecomputing.com, david@redhat.com, jan.kiszka@siemens.com, 
	vincenzo.frascino@arm.com, corbet@lwn.net, maz@kernel.org, mingo@redhat.com, 
	arnd@arndb.de, ytcoode@gmail.com, xur@google.com, morbo@google.com, 
	thiago.bauermann@linaro.org, linux-doc@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:53=E2=80=AFPM Maciej Wieczor-Retman
<maciej.wieczor-retman@intel.com> wrote:
>
> After adding
>         kasan_params +=3D hwasan-instrument-with-calls=3D0
> to Makefile.kasan just under
>         kasan_params +=3D hwasan-mapping-offset=3D$(KASAN_SHADOW_OFFSET)
> inline works properly in x86. I looked into assembly and before there wer=
e just
> calls to __hwasan_load/store. After adding the the
> hwasan-instrument-with-calls=3D0 I can see no calls and the KASAN offset =
is now
> inlined, plus all functions that were previously instrumented now have th=
e
> kasan_check_range inlined in them.
>
> My LLVM investigation lead me to
>         bool shouldInstrumentWithCalls(const Triple &TargetTriple) {
>           return optOr(ClInstrumentWithCalls, TargetTriple.getArch() =3D=
=3D Triple::x86_64);
>         }
> which I assume defaults to "1" on x86? So even with inline mode it doesn'=
t care
> and still does an outline version.

Ah, indeed. Weird discrepancy between x86 and arm.

Florian, Vitaly, do you recall why this was implemented like this?

To account for this, let's then set hwasan-instrument-with-calls=3D0
when CONFIG_KASAN_INLINE is enabled. And also please add a comment
explaining why this is done.

[...]

> >What do you mean by "The alignment doesn't fit the shadow memory size"?
>
> Maybe that's the wrong way to put it. I meant that KASAN_SHADOW_END and
> KASAN_SHADOW_END aren't aligned to the size of shadow memory.

I see. And the negative side-effect of this would be that we'll need
extra page table entries to describe the shadow region?

[...]

> I think this was a false alarm, sorry. I asked Kirill about turning
> pgtable_l5_enabled() into a runtime_const value but it turns out it's alr=
eady
> patched by alternative code during boot. I just saw a bunch more stuff th=
ere
> because I was looking at the assembly output and the code isn't patched t=
here
> yet.

Great!

