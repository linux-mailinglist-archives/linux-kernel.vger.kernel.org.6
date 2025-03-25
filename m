Return-Path: <linux-kernel+bounces-575953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C8A7094A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E9F16166F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB3A1C701C;
	Tue, 25 Mar 2025 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+PYKNhJ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F41F03D1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928151; cv=none; b=KyE+G9yEt3D+iiunNAyvdD81WCH95Ren+QZThivtOjxwnqhjWYq8i9rQOY8hMCmYAi+d7FiOdp6hRnEhOzTHE60cLyOJPZFL/od8+VKHgN0Pvl7fmn+TjSIY6bFAA5QkJG+ssXuxXPlZaRmB4BHbT61boJqr3chesIGYK1jIXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928151; c=relaxed/simple;
	bh=EmA40F4/20MOXQFbjxKTM15ghk+QohARugBibWdivjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hv60lNQDckboqjZyyNiNNfes9oqC5IzM8tX/C9XVYff9YB5Z1nc2PbF7aey59OECzcGYKFhmHSsFm0KWix/vQWmwYtJs1ieC51VaFn3PPCm7fFfDQQbbuC2BVcDQYWgyWOcDIadjl1pgaluwumv6LWE48CbakxRBS3N+xOEqVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+PYKNhJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso1974a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742928147; x=1743532947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohWbm/UuIc3MDUKHoYt0YitrpdOZotQW09VJZwN6f+A=;
        b=L+PYKNhJRvNw4YZ/I8E65hNqLgDMagcr4h2FIqcWH4zkCdD/vD0qi+O8+QeEhDothb
         AIlUmz/UoTdfX6ysvsEktgG6lYgerNsM/s06e772Noal2QGoo5Ikosv5EVj/NE6QZzSu
         tPc8nhbVNqWgVvsCpskd8S+FvzoSILEb2H8v1Vy8IilB/BWL/1yq1tqWPFfnAXqx/K19
         52OowOBeNMK4uaC/nArk9hN8FoaZK2E2jZ1zHk8mTKJE8BHF4PZT1svX7q+Dl7ge+Kj4
         zb5l6sIBelpTI7sa+I/n6chF1kJwqFT0KjvAam6tqAkzDEOlt4GZEl0MPas10RGFQbj3
         zeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742928147; x=1743532947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohWbm/UuIc3MDUKHoYt0YitrpdOZotQW09VJZwN6f+A=;
        b=pYD9gFRgNv9VC0+1iQpZKP3Y84Fga9INJikjfIoWj6PzuM/zqItX8nV3zzcwjcLEsK
         uRv5NiySYFClEILA0PzoemLq4XLhM8vtyBc3tSCdGo1tu+F/LMN6upkoMmHztvyPzGtR
         HsiSnE7+dxjdLEwtIO1DOL6bcF5CwcGxzrLCgkKeOpUoCihvNeAcxt8C4fUVZl96u27Y
         yj0QzCwpdOFra/1FZfDQnkQH6aF2PW6wsw9C1R0cMXqUr78RVMAlpIwRMAqNkgB+FE50
         ETr5mOv4Xidd/eoUZtANLVi6S3bAENXypgFgGdt9vrJ1cochJ5SduDUFLYybT7ruQEhI
         4CrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXpXNsD4DGmf1lS8ZLTzboxScs2jDZDkE40osErFD0G7nWS2fnrhq0Eqycdoz2EU6k0FZyobW/m7iQFhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyp6lHteNc4YiP9s2WZ0xBAMHNU9lPmqCB9uUjZshMv5j6xz8+
	wAA+srzfpm0OLw/njSD1f/NMz3kglfUbM7BtBHHKKbE8wdGC04SkmoJU/h5njLRCOhesntUYTFZ
	YjPMPJdW0Y1IOrN0Wv0ewT7E3LW/5DDitWjmS
X-Gm-Gg: ASbGncsKCLX/b5Uf2CK8gZsLaMVTJ8pP5kbvIdRoAOci/9EtwiGWi5pbNuNk1HaPFOC
	xDxe9K9Ikcp5h+z325zCj1m3simNho0FQggf5KqRpmCoHWVOP/0H7DODOIY/lm4COaY5QD3ADWT
	BzCaquiyYSWxKBvlDs2aJ4YMOXg/K8U4ecLus2wvzz7O14+pVJ5a0L3CowdwVAnFyL
X-Google-Smtp-Source: AGHT+IG/oxMHsUwCe/Pv38c6tGHW1E+mjtkA7yC/Fgzn+9xwryPNKquWqjWfGFAmY6c6RcrvuYp4RqLtrV1djsqY7q0=
X-Received: by 2002:a50:ed83:0:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5ed53ee96e9mr10451a12.4.1742928147101; Tue, 25 Mar 2025
 11:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250114175143.81438-1-vschneid@redhat.com> <20250114175143.81438-30-vschneid@redhat.com>
 <CAG48ez1Mh+DOy0ysOo7Qioxh1W7xWQyK9CLGNU9TGOsLXbg=gQ@mail.gmail.com>
 <xhsmh34hhh37q.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez3H8OVP1GxBLdmFgusvT1gQhwu2SiXbgi8T9uuCYVK52w@mail.gmail.com>
 <xhsmh5xlhk5p2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAG48ez1EAATYcX520Nnw=P8XtUDSr5pe+qGH1YVNk3xN2LE05g@mail.gmail.com>
 <xhsmh34gkk3ls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <352317e3-c7dc-43b4-b4cb-9644489318d0@intel.com> <xhsmhjz9mj2qo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <d0450bc8-6585-49ca-9cad-49e65934bd5c@intel.com> <xhsmhh64qhssj.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <eef09bdc-7546-462b-9ac0-661a44d2ceae@intel.com> <xhsmhfrk84k5k.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <408ebd8b-4bfb-4c4f-b118-7fe853c6e897@intel.com> <xhsmhy0wtngkd.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhy0wtngkd.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Mar 2025 19:41:49 +0100
X-Gm-Features: AQ5f1Jo2l3CP6X5vd0V2T3oskBTdoXupZsoP0HqqqOWE1sDQ_J5UAMa3wCMvDAw
Message-ID: <CAG48ez2bSh6=J8cXJhqYX=Y8pXcGsFgC05HsGcF0b1sJK2VH7A@mail.gmail.com>
Subject: Re: [PATCH v4 29/30] x86/mm, mm/vmalloc: Defer flush_tlb_kernel_range()
 targeting NOHZ_FULL CPUs
To: Valentin Schneider <vschneid@redhat.com>, Rik van Riel <riel@surriel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, linux-arch@vger.kernel.org, rcu@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, Juergen Gross <jgross@suse.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.amakhalov@broadcom.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang1211@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Clark Williams <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, 
	Tomas Glozar <tglozar@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Rong Xu <xur@google.com>, 
	Nicolas Saenz Julienne <nsaenzju@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Yosry Ahmed <yosryahmed@google.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Jinghao Jia <jinghao7@illinois.edu>, 
	Luis Chamberlain <mcgrof@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:52=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
> On 20/02/25 09:38, Dave Hansen wrote:
> > But, honestly, I'm still not sure this is worth all the trouble. If
> > folks want to avoid IPIs for TLB flushes, there are hardware features
> > that *DO* that. Just get new hardware instead of adding this complicate=
d
> > pile of software that we have to maintain forever. In 10 years, we'll
> > still have this software *and* 95% of our hardware has the hardware
> > feature too.
>
> Sorry, you're going to have to deal with my ignorance a little bit longer=
...
>
> Were you thinking x86 hardware specifically, or something else?
> AIUI things like arm64's TLBIVMALLE1IS can do what is required without an=
y
> IPI:
>
> C5.5.78
> """
> The invalidation applies to all PEs in the same Inner Shareable shareabil=
ity domain as the PE that
> executes this System instruction.
> """
>
> But for (at least) these architectures:
>
>   alpha
>   x86
>   loongarch
>   mips
>   (non-freescale 8xx) powerpc
>   riscv
>   xtensa
>
> flush_tlb_kernel_range() has a path with a hardcoded use of on_each_cpu()=
,
> so AFAICT for these the IPIs will be sent no matter the hardware.

On X86, both AMD and Intel have some fairly recently introduced CPU
features that can shoot down TLBs remotely.

The patch series
<https://lore.kernel.org/all/20250226030129.530345-1-riel@surriel.com/>
adds support for the AMD flavor; that series landed in the current
merge window (it's present in the mainline git repository now and should
be part of 6.15). I think support for the Intel flavor has not yet
been implemented, but the linked patch series mentions a plan to look
at the Intel flavor next.

