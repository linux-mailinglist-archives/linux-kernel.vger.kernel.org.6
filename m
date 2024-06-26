Return-Path: <linux-kernel+bounces-231393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4752B919837
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DB5B22D68
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCF3190690;
	Wed, 26 Jun 2024 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMGxHSIq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5218A940
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719429601; cv=none; b=mYP8FOkrNv5/v3jArPsdKEhpklnBC2vZ4xK1PmBGgB8w8Roj/j7mfmN5xmSYhYSZNrWVsNzDUDPrOGcoyACmarq+129BPsHZXOLIKzpstNbzUrPpB6v0Yv144gdhlNVKx39sYlLCzMB10Izx4Xmsc3uHOeAVnSn/NXRcNzmSKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719429601; c=relaxed/simple;
	bh=hIkcWUXoLSx+/dWU1QT6Gx8IpyIsqrFebpLh4+xLXNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/PU0cShs+IbBZEtYYY+8Ykk5oKTGzVARGKKu3jwdZ0WIR+EGoR/Ky9huGhXOQuewZ3pDSYJeabgfRR49rh7Ha7UXtC3UVFk+CZ35wQYq490jYETRTxOmeHmUKpx85dNG8UiYs0A/0AEhQy+woR+2pwhbiz27M1s4dab2Md+CvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMGxHSIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF80C116B1;
	Wed, 26 Jun 2024 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719429601;
	bh=hIkcWUXoLSx+/dWU1QT6Gx8IpyIsqrFebpLh4+xLXNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMGxHSIqRbjXVkJq9WpYkLFgiNkgnBODcHExKb9k5Z21BuCjP9hPlqKakHL9d/YRK
	 rs+Eqr8U2GZJ9UhCISJfc8AFacvscONe08Xlp8z8Q/xJLo1EuH92i2GpsYgATcvauS
	 vuQTD/T9vrFR0P4f3hcCoEc2EM9l8YFvUWYJbphLrU5IsAOhy1UGjmsYUGm3tAs5/q
	 fixuqQ5Y0YGqeq1qYeO65/eiCepld4SaOKmNWGW6jh4Hsv121YS2p+zTLgDcu1jOZo
	 NLRtZaVj6iEFrud/2fX+OVd9MxEXAjxMkwKaKkw2TYhSkpync0jOg0Zi+1vjJsOzOw
	 yUTDgxCLcGMlw==
Date: Wed, 26 Jun 2024 16:19:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@x1.smtp.subspace.kernel.org
Subject: Re: [PATCH 1/2] perf build: Use pkg-config for feature check for
 libtrace{event,fs}
Message-ID: <Znxp3bpc-5tvaa3m@x1>
References: <20240606153625.2255470-1-amadio@gentoo.org>
 <20240606153625.2255470-2-amadio@gentoo.org>
 <171925142502.1926937.5367954849470450249.b4-ty@kernel.org>
 <ZnscQ_nrxWTLHh8k@gentoo.org>
 <ZnxpvZE3dX-IwTLy@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnxpvZE3dX-IwTLy@x1>

Sorry, forgot to CC the mailing lists.

On Wed, Jun 26, 2024 at 04:19:29PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jun 25, 2024 at 09:36:35PM +0200, Guilherme Amadio wrote:
> > On Mon, Jun 24, 2024 at 10:50:56AM -0700, Namhyung Kim wrote:
> > > On Thu, 06 Jun 2024 17:33:01 +0200, amadio@gentoo.org wrote:
> > > 
> > > > Needed to add required include directories for the feature detection
> > > > to succeed. The header tracefs.h is installed either into the include
> > > > directory /usr/include/tracefs/tracefs.h when using the Makefile, or
> > > > into /usr/include/libtracefs/tracefs.h when using meson to build
> > > > libtracefs. The header tracefs.h uses #include <event-parse.h> from
> > > > libtraceevent, so pkg-config needs to pick the correct include directory
> > > > for libtracefs and add the one for libtraceevent to succeed.
> > > > 
> > > > [...]
> > > 
> > > Applied both to perf-tools-next, thanks!
> > 
> > Thank you very much!
> 
> So now when we don't libtracefs installed we get (with current
> perf-tools-next):
> 
> ⬢[acme@toolbox perf-tools-next]$ m
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
>   BUILD:   Doing 'make -j28' parallel build
>   HOSTCC  /tmp/build/perf-tools-next/fixdep.o
>   HOSTLD  /tmp/build/perf-tools-next/fixdep-in.o
>   LINK    /tmp/build/perf-tools-next/fixdep
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
>   diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
>   diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h
>   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
>   diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
>   diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
>   diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
>   diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
>   diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
>   diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
>   diff -u tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h arch/x86/include/asm/irq_vectors.h
>   diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/stat.h include/uapi/linux/stat.h
> Package libtracefs was not found in the pkg-config search path.
> Perhaps you should add the directory containing `libtracefs.pc'
> to the PKG_CONFIG_PATH environment variable
> Package 'libtracefs', required by 'virtual:world', not found
> Package libtracefs was not found in the pkg-config search path.
> Perhaps you should add the directory containing `libtracefs.pc'
> to the PKG_CONFIG_PATH environment variable
> Package 'libtracefs', required by 'virtual:world', not found
> 
> Auto-detecting system features:
> ...                                   dwarf: [ on  ]
> ...                      dwarf_getlocations: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libcap: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                      libdw-dwarf-unwind: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> 
>   GEN     /tmp/build/perf-tools-next/common-cmds.h
>   GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
> 
> Which is a new behaviour, we never had those kinds of warnings from
> pkg-config, and when something wasn´t available we would reflect that
> somehow in the "Auto-detecting system features", additionally telling
> the users which set of features would not be available due to some
> system component not being available.
> 
> Further more we would suggest the name of the package to install.
> 
> Now I have this "virtual:world" thing that I never heard about (what is
> that)?
> 
> Ditto for PKG_CONFIG_PATH, I probably guess what this is about, but then
> it is a novelty for people with just enough muscle memory to build the
> kernel, build perf and use it.
> 
> If I try:
> 
> $ sudo dnf install libtracefs
> 
> Cool:
> 
> Installed:
>   libtracefs-1.6.4-3.fc39.x86_64                                                                                                                                                               
> 
> Complete!
> $
> 
> but then when I try to build perf again I get those warnings again, but
> a full build neverthless:
> 
> Package libtracefs was not found in the pkg-config search path.
> Perhaps you should add the directory containing `libtracefs.pc'
> to the PKG_CONFIG_PATH environment variable
> Package 'libtracefs', required by 'virtual:world', not found
> Package libtracefs was not found in the pkg-config search path.
> Perhaps you should add the directory containing `libtracefs.pc'
> to the PKG_CONFIG_PATH environment variable
> Package 'libtracefs', required by 'virtual:world', not found
> 
> Its only when I try:
> 
> $ sudo dnf install libtracefs-devel
> 
> That I get a build without warnings.
> 
> So, what is the feature detection that is failing when libtracefs-devel
> isn't installed? What are the features that we lose in such a situation?
> 
> - Arnaldo

