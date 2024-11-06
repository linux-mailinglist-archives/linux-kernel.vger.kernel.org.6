Return-Path: <linux-kernel+bounces-398778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB09BF5F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0071F2243F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31A3209F22;
	Wed,  6 Nov 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1n+6N/47"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28855209696
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919647; cv=none; b=bSUp6xLHvZb+nURDe/POjcb/NY/6bsUFSHrxHmHRthIMB5hBj9J1W99JfFkhZi6j1MYRZTQ+mrMnUC4PXXEcSlb1FTQGb0OdImEEz/PW3Ynw0M//PIGD2XB7cAw3Z7L7+2afd+GFwufJ0gjUJNMNXi0jc6S7Ay4Fxez5T0InfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919647; c=relaxed/simple;
	bh=bxYqRa17reDCR3qi3gqKwOHIfaaPVANr77NN2TmRhAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haz1nJNlwyP0hD0H1c3IY1d6imCAGw1c0hrQZCTRVLUfgdgdlVz6RgfeoYF/2XfWj47Cli3N/Py6EkLRpzPAtgTDooSsd7hHMw2HDuhjjykBvGKR61eWcq5ihSSpGHRD15i1ROFSqxog8emU0pS79rhnW9qb+aus0q/21rpxDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1n+6N/47; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460b295b9eeso20851cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 11:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730919619; x=1731524419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9fh4bhhNbF5bLblOSaq+n0wJRTjplH0ZRkQKHqc2Jw=;
        b=1n+6N/47KBzFSX43AqOtab7PPrEEA866+PTuiQxQ34Lh17HHLEYoMk+5DuIARyPKvq
         SlhRX7cDffuchzSx+rcaJ3qCE6M//kBgnLvvx77Y0lOr2CQyFzjg7HEDEsrfUSJaxrQx
         wbOGT/JdV3rzj+8oOFOmt8o4b7Psmrp4Zn4GuIOIbmTGHjWyktCzOzwL3+j80W5wC7hI
         maXdlJ9dARq9/i+JOtQexQQy/kJRhw3kIkdamsRVBNb1YzGmo4MVD6fsHX04fF74ir44
         O3KgAmCyTN5fAIbqG9JD8XZSiJXO6zViuPBUJlSO9XHGM0c9+hrVfoQsrRg+4a1ska/d
         tsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730919619; x=1731524419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9fh4bhhNbF5bLblOSaq+n0wJRTjplH0ZRkQKHqc2Jw=;
        b=G6g+2qaPBJ3efZBxcgz0Rcbbk0doR8+R7MwA3dq8cDNOfsAuPVelyRywOASh9ituSd
         0jfRhWrAY58DKfjV8fswyV+NEqgah1w6gOcn5KtMItRI9jtNYYI5HEoww+NRwao4X1I1
         jVJUiK2fA5Nu3DDpu250PzrkEMe5A7ROpPdbixLuNUNu8VYSmy5uuJem9L8JqigQLTcU
         jtHH/iq8lsnL4Uepvor5mroCygaIgGNP73SWrl+p0hlZ1kXwLy92c5QZdy4T9XxL05yT
         s+UHpCHieenreAx/yGanAZ+Og3u/997G5HVeX+XooPDRR+o1g3n4ukAa+MDyergmgk1a
         8Jig==
X-Forwarded-Encrypted: i=1; AJvYcCXXIzXMLrbp4H2hsNhRAvsktbGwoz+0Kh1cejKW+wgYjUPeUayPBoGNY94HgvEtsLFQP6zK70qZKMg6VcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrdCW2CZ7olffO2vBnWFYtDQtsFEwPc95sjSrydi41Hub16iwR
	lyqwuLi4FXUSPQWRjs6/MythZ5WbzxnEVbx7T8K8mNGBTO1Eh+8hafvJOLwjWrqiz0DBHqi9W6p
	B8pOGk+4Yyh/vJvxkIL7eME58CFuxgc55/ekq
X-Gm-Gg: ASbGncs3TOjIkMs93QlskGZQSTiP1DP6KnGOnSPEe4ICkfIOeTDgRJGTp8hunCMmEQ5
	caQpVJlVT3NmebBmHU6XhgVGA1RB0ZqEEfO8PY0vyY2E/SOabEAo2Ink4PfIJGQ==
X-Google-Smtp-Source: AGHT+IGmJPKzMHGg7M75nIDLes/dj6VeWqdxQ5VXcaPURxNxzrC5fWIx3w4oUPysqvDGrtdU7x3+PgaWkDnF08Swq5w=
X-Received: by 2002:ac8:5d55:0:b0:462:b44c:42ff with SMTP id
 d75a77b69052e-462fa58ed21mr1232211cf.12.1730919618655; Wed, 06 Nov 2024
 11:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com> <CAK7LNASdBPtq4vaK0XZQvxicOY15qJFsnqkO2_us4AU4ppHw6A@mail.gmail.com>
In-Reply-To: <CAK7LNASdBPtq4vaK0XZQvxicOY15qJFsnqkO2_us4AU4ppHw6A@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Wed, 6 Nov 2024 11:00:06 -0800
Message-ID: <CAF1bQ=R-7z9+57fji4Mn=ZVUgwSniGQ-8H4=42tFunxyp69Wzw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Add AutoFDO and Propeller support for Clang build
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
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>, x86@kernel.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:09=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Sun, Nov 3, 2024 at 2:51=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
> > Hi,
> >
> > This patch series is to integrate AutoFDO and Propeller support into
> > the Linux kernel. AutoFDO is a profile-guided optimization technique
> > that leverages hardware sampling to enhance binary performance.
> > Unlike Instrumentation-based FDO (iFDO), AutoFDO offers a user-friendly
> > and straightforward application process. While iFDO generally yields
> > superior profile quality and performance, our findings reveal that
> > AutoFDO achieves remarkable effectiveness, bringing performance close
> > to iFDO for benchmark applications.
> >
> > Propeller is a profile-guided, post-link optimizer that improves
> > the performance of large-scale applications compiled with LLVM. It
> > operates by relinking the binary based on an additional round of runtim=
e
> > profiles, enabling precise optimizations that are not possible at
> > compile time.  Similar to AutoFDO, Propeller too utilizes hardware
> > sampling to collect profiles and apply post-link optimizations to impro=
ve
> > the benchmark=E2=80=99s performance over and above AutoFDO.
> >
> > Our empirical data demonstrates significant performance improvements
> > with AutoFDO and Propeller, up to 10% on microbenchmarks and up to 5%
> > on large warehouse-scale benchmarks. This makes a strong case for their
> > inclusion as supported features in the upstream kernel.
> >
> > Background
> >
> > A significant fraction of fleet processing cycles (excluding idle time)
> > from data center workloads are attributable to the kernel. Ware-house
> > scale workloads maximize performance by optimizing the production kerne=
l
> > using iFDO (a.k.a instrumented PGO, Profile Guided Optimization).
> >
> > iFDO can significantly enhance application performance but its use
> > within the kernel has raised concerns. AutoFDO is a variant of FDO that
> > uses the hardware=E2=80=99s Performance Monitoring Unit (PMU) to collec=
t
> > profiling data. While AutoFDO typically yields smaller performance
> > gains than iFDO, it presents unique benefits for optimizing kernels.
> >
> > AutoFDO eliminates the need for instrumented kernels, allowing a single
> > optimized kernel to serve both execution and profile collection. It als=
o
> > minimizes slowdown during profile collection, potentially yielding
> > higher-fidelity profiling, especially for time-sensitive code, compared
> > to iFDO. Additionally, AutoFDO profiles can be obtained from production
> > environments via the hardware=E2=80=99s PMU whereas iFDO profiles requi=
re
> > carefully curated load tests that are representative of real-world
> > traffic.
> >
> > AutoFDO facilitates profile collection across diverse targets.
> > Preliminary studies indicate significant variation in kernel hot spots
> > within Google=E2=80=99s infrastructure, suggesting potential performanc=
e gains
> > through target-specific kernel customization.
> >
> > Furthermore, other advanced compiler optimization techniques, including
> > ThinLTO and Propeller can be stacked on top of AutoFDO, similar to iFDO=
.
> > ThinLTO achieves better runtime performance through whole-program
> > analysis and cross module optimizations. The main difference between
> > traditional LTO and ThinLTO is that the latter is scalable in time and
> > memory.
> >
> > This patch series adds AutoFDO and Propeller support to the kernel. The
> > actual solution comes in six parts:
> >
> > [P 1] Add the build support for using AutoFDO in Clang
> >
> >       Add the basic support for AutoFDO build and provide the
> >       instructions for using AutoFDO.
> >
> > [P 2] Fix objtool for bogus warnings when -ffunction-sections is enable=
d
> >
> > [P 3] Adjust symbol ordering in text output sections
> >
> > [P 4] Add markers for text_unlikely and text_hot sections
> >
> > [P 5] Enable =E2=80=93ffunction-sections for the AutoFDO build
> >
> > [P 6] Enable Machine Function Split (MFS) optimization for AutoFDO
> >
> > [P 7] Add Propeller configuration to the kernel build
> >
> > Patch 1 provides basic AutoFDO build support. Patches 2 to 6 further
> > enhance the performance of AutoFDO builds and are functionally dependen=
t
> > on Patch 1. Patch 7 enables support for Propeller and is dependent on
> > patch 2 to patch 4.
> >
> > Caveats
> >
> > AutoFDO is compatible with both GCC and Clang, but the patches in this
> > series are exclusively applicable to LLVM 17 or newer for AutoFDO and
> > LLVM 19 or newer for Propeller. For profile conversion, two different
> > tools could be used, llvm_profgen or create_llvm_prof. llvm_profgen
> > needs to be the LLVM 19 or newer, or just the LLVM trunk. Alternatively=
,
> > create_llvm_prof v0.30.1 or newer can be used instead of llvm-profgen.
> >
> > Additionally, the build is only supported on x86 platforms equipped
> > with PMU capabilities, such as LBR on Intel machines. More
> > specifically:
> >  * Intel platforms: works on every platform that supports LBR;
> >    we have tested on Skylake.
> >  * AMD platforms: tested on AMD Zen3 with the BRS feature. The kernel
> >    needs to be configured with =E2=80=9CCONFIG_PERF_EVENTS_AMD_BRS=3Dy"=
, To
> >    check, use
> >    $ cat /proc/cpuinfo | grep =E2=80=9C brs=E2=80=9D
> >    For the AMD Zen4, AMD LBRV2 is supported, but we suspect a bug with
> >    AMD LBRv2 implementation in Genoa which blocks the usage.
> >
> > For ARM, we plan to send patches for SPE-based Propeller when
> > AutoFDO for Arm is ready.
> >
> > Experiments and Results
> >
> > Experiments were conducted to compare the performance of AutoFDO-optimi=
zed
> > kernel images (version 6.9.x) against default builds.. The evaluation
> > encompassed both open source microbenchmarks and real-world production
> > services from Google and Meta. The selected microbenchmarks included Ne=
per,
> > a network subsystem benchmark, and UnixBench which is a comprehensive s=
uite
> > for assessing various kernel operations.
> >
> > For Neper, AutoFDO optimization resulted in a 6.1% increase in throughp=
ut
> > and a 10.6% reduction in latency. UnixBench saw a 2.2% improvement in i=
ts
> > index score under low system load and a 2.6% improvement under high sys=
tem
> > load.
> >
> > For further details on the improvements observed in Google and Meta's
> > production services, please refer to the LLVM discourse post:
> > https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo-i=
ncluding-thinlto-and-propeller/79108
> >
> > Thanks,
> >
> > Rong Xu and Han Shen
>
>
> I applied this series to linux-kbuild.
>

Thanks for taking the patch!

> As I mentioned before, I do not like #ifdef because
> it hides (not fixes) issues only for default cases.

We followed the suggestion and removed most of the #if (or #ifdef) in
the linker script.
I just checked: there are two #ifdef remaining:
(1) in the propeller patch for .llvm_bb_addr_map
(2) in linker script patch for arch/sparc/kernel/vmlinux.lds.S.

I think it's likely safe to remove the checks for head_64.o in
non-SPARC64 builds and .llvm_bb_addr_map symbols in non-propeller builds.

SPARC64 builds should always produce head_64.o, and non-SPARC64
builds shouldn't.

Propeller builds always generate .llvm_bb_addr_map symbols, and the
linker will omit the section if it's empty in non-propeller builds.

Keeping the checks is harmless and might slightly reduce linker
workload for matching.
But If you'd prefer to remove them, I'm happy to provide a patch.

Best regards,

-Rong




>
> --
> Best Regards
> Masahiro Yamada

