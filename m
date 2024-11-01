Return-Path: <linux-kernel+bounces-392880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CE39B9931
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8351C20F56
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2070C1D9667;
	Fri,  1 Nov 2024 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXNwz71D"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF91D0F49
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491735; cv=none; b=efK434Ty2pZdV3grhScPuJO3JrXK4pnJR3JD//SigjCzaq0IUaHgkWzPbfPWF3X0PXYqyaKd1HeciI6JTd2b+JoPt7SiTAYNng1U0SEwwL3BFtyTRrXt0yh+pxsPiG8fUsxT8ilefFY/UfbnL2z5wIo/C+v9OTKq1sdicK1ZAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491735; c=relaxed/simple;
	bh=C3bK9lq2Iat+ytyW1C1WkA7TwIFFMRn5QKSxbvhI+cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nde5qJSHYe7GGW5rcyk0EIjgqGgdtOeneeDsla++M9f2TZKEpitUN3wCD+VTYdq471kTzbtrUd7ygga5G4BXt82L8zUjOkiEKbGk/SkwroKU1ntLTmQjMSATrQCdGhQPwxwWORYm2qY5HZK/k0589hphrmDBldcazxNY82IY+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXNwz71D; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4608dddaa35so74741cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730491732; x=1731096532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBhvgsyP68AaFdlci9462ArR+t5qoTnQQ8nehGqn+cY=;
        b=zXNwz71DBFYPz1sP5tfi2wFU+rcqCxWNhXVt2i2142V47hg70xrU6vguW7SsouXX7r
         Zyqc37ECf0g/6Ws31Gy/T9wCErubS/LXrbzp2jJUgp3CR0i6mZfArpC6O1rjG8q3FJxW
         d1TFY/HsqQF5DHQL1bLEMwC3ex1Al6xI2tqEKITA14oGphNGm90PA9JyNHHzv4VFc7Tz
         SCgcrLj0pGdRigYvgQJ5q0Pbo8vfGPkKmTxrXf68CypkgzJ40jRgbkudCemnIRzbGlSZ
         a6hVjNGCACYFOVkQXGWoD7rxzdpDHAwBtLf6l5KrVSXaoWx5WrEClQqgorYlL/SmrsUG
         d2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730491732; x=1731096532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBhvgsyP68AaFdlci9462ArR+t5qoTnQQ8nehGqn+cY=;
        b=S1Q2F7E7wnZaJTXNoQEzH4qMQ2w6nvhutyrTkxplgOAgR5YLrnWPT8osSY3tb6PquQ
         8Pas7NAelw/ZF3EDV8aAw/AdDRXUvxGXeTZwTB/jHqJN8i/IVp8ihTMa1F/fH/LvHEOE
         eI9UGYPI1f2dH6RIJs3Y7VckYkMEUYkIHKiexDBertCc/Vek8NXKVaeYrXmR2t1+Evxh
         8NQvfya/Z+0a/KXTtfBwt7tI0vuKy7A2Pd+0zaN1TIAYLsdIv2ykSjFXrQhtIUnvdCpO
         L8lXVfEQj3cdST0aUDZybQ1Jq6atpE8so2XavKVPyXBVrTSbMMVvVvknsFaV23UrN5ue
         e0Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUwPswgOGOjYTuPfjLcCtLBfML+/Qs/tmkmT2fzDJrmPaYWsIH3guugGcFKM0U/5HkQN6Ha+7yBXtkFDmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcy0H7T1J+X8Olqoo8Tdk67g2nG/ECdtYBmsr/Q2uVi1rW3cki
	rJ6fy8vAecRQvbhVUhADIh142k/iqF3JGAtGD/9GM4XpJmWvtWnPcFCIcpECoSTbhNP+i9ulxFM
	f55ffzyrKY9LKC3RDKlHGNzYS0LGlqWUu7uTu
X-Gm-Gg: ASbGncupwsV6mtDekUVZKQEoE9HX20RFrkpj45C8fAJ1PCOTLN9g8AQRYAs6TnN3LrI
	5KC7psk05w4U+hCXqmaEeDh3Ba2r/NhFwOT2fedGeb1wd+xmNy2gZD3X0oBCF
X-Google-Smtp-Source: AGHT+IHLzbr5jZfQL/RFF11+CfvITxPQwh4PBiAl7YBrfB0o/NYh07B9/QUFW2fV1iv3quuB+T2eISwzjxXYEChmiRQ=
X-Received: by 2002:a05:622a:5289:b0:460:77ac:8773 with SMTP id
 d75a77b69052e-462c60000d5mr609401cf.26.1730491732027; Fri, 01 Nov 2024
 13:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023224409.201771-1-xur@google.com> <20241023224409.201771-2-xur@google.com>
 <CAK7LNARiEhNBPikEv--YpdKTPt5B5tFF_J0T8+xbi1CS6WJBFQ@mail.gmail.com>
In-Reply-To: <CAK7LNARiEhNBPikEv--YpdKTPt5B5tFF_J0T8+xbi1CS6WJBFQ@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Fri, 1 Nov 2024 13:08:38 -0700
Message-ID: <CAF1bQ=QvQ=NRCOky3-k_9eoo4BVgW+_C7g6TBmSw=qNurPW9uA@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] Add AutoFDO support for Clang build
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>, x86@kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 11:02=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Oct 24, 2024 at 7:44=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
> > Add the build support for using Clang's AutoFDO. Building the kernel
> > with AutoFDO does not reduce the optimization level from the
> > compiler. AutoFDO uses hardware sampling to gather information about
> > the frequency of execution of different code paths within a binary.
> > This information is then used to guide the compiler's optimization
> > decisions, resulting in a more efficient binary. Experiments
> > showed that the kernel can improve up to 10% in latency.
> >
> > The support requires a Clang compiler after LLVM 17. This submission
> > is limited to x86 platforms that support PMU features like LBR on
> > Intel machines and AMD Zen3 BRS. Support for SPE on ARM 1,
> >  and BRBE on ARM 1 is part of planned future work.
> >
> > Here is an example workflow for AutoFDO kernel:
> >
> > 1) Build the kernel on the host machine with LLVM enabled, for example,
> >        $ make menuconfig LLVM=3D1
> >     Turn on AutoFDO build config:
> >       CONFIG_AUTOFDO_CLANG=3Dy
> >     With a configuration that has LLVM enabled, use the following
> >     command:
> >        scripts/config -e AUTOFDO_CLANG
> >     After getting the config, build with
> >       $ make LLVM=3D1
> >
> > 2) Install the kernel on the test machine.
> >
> > 3) Run the load tests. The '-c' option in perf specifies the sample
> >    event period. We suggest     using a suitable prime number,
> >    like 500009, for this purpose.
> >    For Intel platforms:
> >       $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count>=
 \
> >         -o <perf_file> -- <loadtest>
> >    For AMD platforms:
> >       The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
> >      For Zen3:
> >       $ cat proc/cpuinfo | grep " brs"
> >       For Zen4:
> >       $ cat proc/cpuinfo | grep amd_lbr_v2
> >       $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a=
 \
> >         -N -b -c <count> -o <perf_file> -- <loadtest>
> >
> > 4) (Optional) Download the raw perf file to the host machine.
> >
> > 5) To generate an AutoFDO profile, two offline tools are available:
> >    create_llvm_prof and llvm_profgen. The create_llvm_prof tool is part
> >    of the AutoFDO project and can be found on GitHub
> >    (https://github.com/google/autofdo), version v0.30.1 or later. The
> >    llvm_profgen tool is included in the LLVM compiler itself. It's
> >    important to note that the version of llvm_profgen doesn't need to
> >    match the version of Clang. It needs to be the LLVM 19 release or
> >    later, or from the LLVM trunk.
> >       $ llvm-profgen --kernel --binary=3D<vmlinux> --perfdata=3D<perf_f=
ile> \
> >         -o <profile_file>
> >    or
> >       $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file> \
> >         --format=3Dextbinary --out=3D<profile_file>
> >
> >    Note that multiple AutoFDO profile files can be merged into one via:
> >       $ llvm-profdata merge -o <profile_file>  <profile_1> ... <profile=
_n>
> >
> > 6) Rebuild the kernel using the AutoFDO profile file with the same conf=
ig
> >    as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
> >       $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file>
> >
> > Co-developed-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Rong Xu <xur@google.com>
> > Suggested-by: Sriraman Tallam <tmsriram@google.com>
> > Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Suggested-by: Stephane Eranian <eranian@google.com>
> > Tested-by: Yonghong Song <yonghong.song@linux.dev>
>
>
>
>
> > +Workflow
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Here is an example workflow for AutoFDO kernel:
> > +
> > +1)  Build the kernel on the host machine with LLVM enabled,
> > +    for example, ::
> > +
> > +      $ make menuconfig LLVM=3D1
> > +
> > +    Turn on AutoFDO build config::
> > +
> > +      CONFIG_AUTOFDO_CLANG=3Dy
> > +
> > +    With a configuration that with LLVM enabled, use the following com=
mand::
> > +
> > +      $ scripts/config -e AUTOFDO_CLANG
> > +
> > +    After getting the config, build with ::
> > +
> > +      $ make LLVM=3D1
> > +
> > +2) Install the kernel on the test machine.
> > +
> > +3) Run the load tests. The '-c' option in perf specifies the sample
> > +   event period. We suggest using a suitable prime number, like 500009=
,
> > +   for this purpose.
> > +
> > +   - For Intel platforms::
> > +
> > +      $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count=
> -o <perf_file> -- <loadtest>
> > +
> > +   - For AMD platforms::
>
> I am not sure if this double-colon is needed
> when the next line is not code.

Thanks for catching this. We don't mean to use "::" here. It should be
":" and there is supposed to be a blank line after this.
Also a blank line before "For Zen3::". I will fix this in the patch.

>
>
>
> > +     The supported systems are: Zen3 with BRS, or Zen4 with amd_lbr_v2=
. To check,
> > +     For Zen3::
> > +
> > +      $ cat proc/cpuinfo | grep " brs"
> > +
> > +     For Zen4::
> > +
> > +      $ cat proc/cpuinfo | grep amd_lbr_v2
> > +
> > +     The following command generated the perf data file::
> > +
> > +      $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -=
a -N -b -c <count> -o <perf_file> -- <loadtest>
> > +
> > +4) (Optional) Download the raw perf file to the host machine.
> > +
> > +5) To generate an AutoFDO profile, two offline tools are available:
> > +   create_llvm_prof and llvm_profgen. The create_llvm_prof tool is par=
t
> > +   of the AutoFDO project and can be found on GitHub
> > +   (https://github.com/google/autofdo), version v0.30.1 or later.
> > +   The llvm_profgen tool is included in the LLVM compiler itself. It's
> > +   important to note that the version of llvm_profgen doesn't need to =
match
> > +   the version of Clang. It needs to be the LLVM 19 release of Clang
> > +   or later, or just from the LLVM trunk. ::
> > +
> > +      $ llvm-profgen --kernel --binary=3D<vmlinux> --perfdata=3D<perf_=
file> -o <profile_file>
> > +
> > +   or ::
> > +
> > +      $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file> =
--format=3Dextbinary --out=3D<profile_file>
> > +
> > +   Note that multiple AutoFDO profile files can be merged into one via=
::
> > +
> > +      $ llvm-profdata merge -o <profile_file> <profile_1> <profile_2> =
... <profile_n>
> > +
> > +6) Rebuild the kernel using the AutoFDO profile file with the same con=
fig as step 1,
> > +   (Note CONFIG_AUTOFDO_CLANG needs to be enabled)::
> > +
> > +      $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file>
> > +
>
> Trailing blank line.
>
> .git/rebase-apply/patch:187: new blank line at EOF.

Will remote the blank line.

>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada

