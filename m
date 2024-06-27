Return-Path: <linux-kernel+bounces-232567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 510C391AB11
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55D9B25817
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A3E1990AF;
	Thu, 27 Jun 2024 15:22:38 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9030D198E9A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501758; cv=none; b=C5c7n3ALiD+0JxmguvltGboKgNQiaqy3HBiWqvP8wLhBI29btaTRkPP8eBt/gIpT6aMdcleuLSlm9QU4G3l6AtuMzxDkgDhjClFehjkCO2coE1s5jj63gAb5plhx6VSL8ncblGOLtt+4ckQKcg9o5Z0ne9KCegmcK3FVOqguQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501758; c=relaxed/simple;
	bh=VnAXUe4bS2tugzY1r84uIJLO1rUfNcDiyqv4SDfcYGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVtkIleK3lA5mhFn5hbGK/E46FtVWI+yHxEh/XrOkZ2y2qLAyztVBt2Ejr9lAmmRVA4A2woTJZYwDfiKpScLYuDwsQtkr/BgzCjGL1X5LLx+I/qzwvjWqA6HRvXdia8a5xeruMENfI+kSN+5kAQez9lbD5nTBq/aNg6AdV6hO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Thu, 27 Jun 2024 17:22:31 +0200
From: Guilherme Amadio <amadio@gentoo.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@x1.gentoo.org
Subject: Re: [PATCH 1/2] perf build: Use pkg-config for feature check for
 libtrace{event,fs}
Message-ID: <Zn2DtyyYpoViIJ-S@gentoo.org>
References: <20240606153625.2255470-1-amadio@gentoo.org>
 <20240606153625.2255470-2-amadio@gentoo.org>
 <171925142502.1926937.5367954849470450249.b4-ty@kernel.org>
 <ZnscQ_nrxWTLHh8k@gentoo.org>
 <ZnxpvZE3dX-IwTLy@x1>
 <Znxp3bpc-5tvaa3m@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Znxp3bpc-5tvaa3m@x1>

Hi Arnaldo,

On Wed, Jun 26, 2024 at 04:19:57PM -0300, Arnaldo Carvalho de Melo wrote:
> Sorry, forgot to CC the mailing lists.
>
> On Wed, Jun 26, 2024 at 04:19:29PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Tue, Jun 25, 2024 at 09:36:35PM +0200, Guilherme Amadio wrote:
> > > On Mon, Jun 24, 2024 at 10:50:56AM -0700, Namhyung Kim wrote:
> > > > On Thu, 06 Jun 2024 17:33:01 +0200, amadio@gentoo.org wrote:
> > > >
> > > > > Needed to add required include directories for the feature detection
> > > > > to succeed. The header tracefs.h is installed either into the include
> > > > > directory /usr/include/tracefs/tracefs.h when using the Makefile, or
> > > > > into /usr/include/libtracefs/tracefs.h when using meson to build
> > > > > libtracefs. The header tracefs.h uses #include <event-parse.h> from
> > > > > libtraceevent, so pkg-config needs to pick the correct include directory
> > > > > for libtracefs and add the one for libtraceevent to succeed.
> > > > >
> > > > > [...]
> > > >
> > > > Applied both to perf-tools-next, thanks!
> > >
> > > Thank you very much!
> >
> > So now when we don't libtracefs installed we get (with current
> > perf-tools-next):
> >
> > ⬢[acme@toolbox perf-tools-next]$ m
> > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> >   BUILD:   Doing 'make -j28' parallel build
> >   HOSTCC  /tmp/build/perf-tools-next/fixdep.o
> >   HOSTLD  /tmp/build/perf-tools-next/fixdep-in.o
> >   LINK    /tmp/build/perf-tools-next/fixdep
> > Warning: Kernel ABI header differences:
> >   diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
> >   diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
> >   diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h
> >   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
> >   diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
> >   diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
> >   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> >   diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
> >   diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
> >   diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
> >   diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
> >   diff -u tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h arch/x86/include/asm/irq_vectors.h
> >   diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h
> >   diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
> >   diff -u tools/perf/trace/beauty/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
> >   diff -u tools/perf/trace/beauty/include/uapi/linux/stat.h include/uapi/linux/stat.h
> > Package libtracefs was not found in the pkg-config search path.
> > Perhaps you should add the directory containing `libtracefs.pc'
> > to the PKG_CONFIG_PATH environment variable
> > Package 'libtracefs', required by 'virtual:world', not found
> > Package libtracefs was not found in the pkg-config search path.
> > Perhaps you should add the directory containing `libtracefs.pc'
> > to the PKG_CONFIG_PATH environment variable
> > Package 'libtracefs', required by 'virtual:world', not found
> >
> > Auto-detecting system features:
> > ...                                   dwarf: [ on  ]
> > ...                      dwarf_getlocations: [ on  ]
> > ...                                   glibc: [ on  ]
> > ...                                  libbfd: [ on  ]
> > ...                          libbfd-buildid: [ on  ]
> > ...                                  libcap: [ on  ]
> > ...                                  libelf: [ on  ]
> > ...                                 libnuma: [ on  ]
> > ...                  numa_num_possible_cpus: [ on  ]
> > ...                                 libperl: [ on  ]
> > ...                               libpython: [ on  ]
> > ...                               libcrypto: [ on  ]
> > ...                               libunwind: [ on  ]
> > ...                      libdw-dwarf-unwind: [ on  ]
> > ...                             libcapstone: [ on  ]
> > ...                                    zlib: [ on  ]
> > ...                                    lzma: [ on  ]
> > ...                               get_cpuid: [ on  ]
> > ...                                     bpf: [ on  ]
> > ...                                  libaio: [ on  ]
> > ...                                 libzstd: [ on  ]
> >
> >   GEN     /tmp/build/perf-tools-next/common-cmds.h
> >   GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
> >
> > Which is a new behaviour, we never had those kinds of warnings from
> > pkg-config, and when something wasn´t available we would reflect that
> > somehow in the "Auto-detecting system features", additionally telling
> > the users which set of features would not be available due to some
> > system component not being available.
> >
> > Further more we would suggest the name of the package to install.
> >
> > Now I have this "virtual:world" thing that I never heard about (what is
> > that)?

We are calling, e.g. pkg-config --libs libtraceevent, but the package is
not there. I changed the Makefile to only add these calls for the
feature check if the package is actually installed, by calling first
pkg-config --exists libtraceevent.

> > Ditto for PKG_CONFIG_PATH, I probably guess what this is about, but then
> > it is a novelty for people with just enough muscle memory to build the
> > kernel, build perf and use it.
> >
> > If I try:
> >
> > $ sudo dnf install libtracefs
> >
> > Cool:
> >
> > Installed:
> >   libtracefs-1.6.4-3.fc39.x86_64
> >
> > Complete!
> > $
> >
> > but then when I try to build perf again I get those warnings again, but
> > a full build neverthless:
> >
> > Package libtracefs was not found in the pkg-config search path.
> > Perhaps you should add the directory containing `libtracefs.pc'
> > to the PKG_CONFIG_PATH environment variable
> > Package 'libtracefs', required by 'virtual:world', not found
> > Package libtracefs was not found in the pkg-config search path.
> > Perhaps you should add the directory containing `libtracefs.pc'
> > to the PKG_CONFIG_PATH environment variable
> > Package 'libtracefs', required by 'virtual:world', not found
> >
> > Its only when I try:
> >
> > $ sudo dnf install libtracefs-devel
> >
> > That I get a build without warnings.
> >
> > So, what is the feature detection that is failing when libtracefs-devel
> > isn't installed? What are the features that we lose in such a situation?

I added a warning for when libtraceevent-devel is installed, but not
libtracefs-devel. So if someone forgets to install the latter, there
will be a message to remind them now.

Indeed, this was not very nice behavior which was introduced. I've sent
the patches to address this to the list. I tried to set the reply-to to
this message, but it doesn't seem to have worked, unfortunately. Please
let me know if the new patches are ok or if you have any suggestions for
improvement.

Best regards,
-Guilherme

