Return-Path: <linux-kernel+bounces-573087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A4A6D2EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CD73B2D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFCE61FFE;
	Mon, 24 Mar 2025 02:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cDP9A9tK"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37433062
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742781788; cv=none; b=N8ZpVwJpw47rr28/gzLA7/mcbubjos8p1Pa+0nyGG+l/OCSQwGhf7AI/p4/is/1+z4KahhOqrV30XqoNOPtfv3F7iOppvkeQZCo56ywhq4U7nobQVRSyYQ02S4n9VhX1hL61rwm1mRCsajopr0gdIUEr1xu62CLbbNc8V34RXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742781788; c=relaxed/simple;
	bh=a8wvSRzjU7XE8VYYqWB4tJ4esDBEnS+ZrcHSUQVL8P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds2tJHtvf69rF6VNugvDMwIpDtFpAmS4nm+iyVPCrsHKY8x0zwZ3L2x7jo737DZLh6T7GjpqLF+ZKobv4VJTq1+wsLh/aOu8x+D16AYxBQE+LVq70g7TULI8sqjRgNJHeARWO5LGXnko5PYb3wsz8EHhnYQmtze4lKWG383DqlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cDP9A9tK; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54298ec925bso5552899e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742781781; x=1743386581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MALJfAG5gvtESuCkLnLe7ALtEnDUMs5WOUPpt46yLQ=;
        b=cDP9A9tKL8hTPIoTZknK5nhrEyTNLNC8dX7/sfAKHZnxf2gH38npdYLvS2BSbVZpBG
         QmO9ABPVC/TSdPeXpM8aHr6hgmpb6h/ClexkKFEYr5B4o7AbSPmYWoEWXtPmNmFWCIPt
         LorMWoRtjGi6QNaq86iv321w8ZuOhop/kEu50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742781781; x=1743386581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MALJfAG5gvtESuCkLnLe7ALtEnDUMs5WOUPpt46yLQ=;
        b=n5tIFvE028/6MEVEV/VGh9DrEzz5l8ZCmKXgXVy5KTLMcMU/K3YPVlu8Scw3zoC2VV
         47g0IdhbP0OONiYbZ/885wQW1WYdwqbFMvM19WnthVUJmxmqqr/0AZsizAv4nnPIr6AH
         w5kPoPg9S1Py6B+TVSpJgvtRjcpL8ovMry+OSD07MoircL1gJpKEC8AU/7CpwInMqaRr
         7UCrB3bd2ivkcH3QmUSpiALIz+1huo+riYbhhpMB2QzBi0HBcOUErQJt+cVZYuTwJVYV
         V4nuIR19/O26FLb6xz6Lntmk4xlxdnlbrRfAsEpKctBsrYrHTo0p+hohVGnwtScSGK6L
         xhSg==
X-Forwarded-Encrypted: i=1; AJvYcCX7oaPZtcO4zlrmJMJYZSZQpLlOrY2KBcHyxWgUfg1itkZKX3u98qcS5dNJ7pIkSBkV95Xf5eilV6DnUVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCHSGOO1sSoJVjAcd+zOO4Y2bXhvmNtxXvf0O8tEGDOQ9FN6G
	kqkGeAZVHJSm6b7h7vbmhbGjsvkPmifqX7aD2ukYLZDAgfQePCrfPUxXEwSpIpZZe3EE2EPv0iM
	=
X-Gm-Gg: ASbGncu1iNSRKqlCO3ZgjkAFTYMv6Q7IOPgyladK0az1Riqc2v7NqqhbbuTaPTrARdn
	6lpjvs3cr1hprdIQWU9S6LOguz3QWIvHaww77yF1IZUQbPnPSN4yRUFGF+ccTqpecUKohcEu+Mp
	+6VyVbW7O3vw3CAdCVygcxYLLOfdCUi/qsdHNdRIGj1T7PByx/xHi9k7O9j7b3qLl3CrSmvO9e5
	3ozh1eHjwY4IKPtTCg2syQmV483CZQYo4JCObW4ze7LREX5ZDQ/KEqxrf/nN8XXpa5eGWRcwsbo
	Pi4RUjWfov2/sGzEkDl0aEdAxOjkZlpmluTvEphbiQZOZ7QHjp8m9Wsz7dDqj4ZFb7WG9Z3v3Pt
	SY4owhkNn
X-Google-Smtp-Source: AGHT+IG8SsQEcUCQ5X5I5gN2qaDEKAX7ncLh8dDgOkGpy+dI/sKA9ycnGi/t2vLotly+rODrnVqr/g==
X-Received: by 2002:a05:6512:3d1b:b0:545:d70:1d0e with SMTP id 2adb3069b0e04-54ad6480a52mr4587560e87.3.1742781781359;
        Sun, 23 Mar 2025 19:03:01 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad646872fsm957342e87.9.2025.03.23.19.02.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Mar 2025 19:02:58 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5497590ffbbso4437679e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:02:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVo6FNP8m0lXSe/XDrypsre6amj9SDeGuW6FTUjxYbAmd0NeNFYvyC1rG234mCZarJtb/5tfpSXURRR+EY=@vger.kernel.org
X-Received: by 2002:a05:6512:3b11:b0:549:8ebe:b3b1 with SMTP id
 2adb3069b0e04-54ad6480a93mr3448008e87.10.1742781777734; Sun, 23 Mar 2025
 19:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211002930.1865689-1-masahiroy@kernel.org>
 <CAD=FV=V19pgzU8NSyWwHSEs85kU_Fbofcn8uJVj-TE2DNKfUHQ@mail.gmail.com> <CAK7LNAQX03w=AVkntA=8KmSAmX91Z3BdB4Z8H5oDt3iPsJNXfg@mail.gmail.com>
In-Reply-To: <CAK7LNAQX03w=AVkntA=8KmSAmX91Z3BdB4Z8H5oDt3iPsJNXfg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 23 Mar 2025 19:02:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V355McabzO0sEwy_bbYZjPTGF=8iLU9wqQWDiFg9h-DQ@mail.gmail.com>
X-Gm-Features: AQ5f1JrVGIi5RXrUZvDS5fqcRDUYmFYIOnPrTLF5iUAPdzU68erT4ONc4AJ6NJ8
Message-ID: <CAD=FV=V355McabzO0sEwy_bbYZjPTGF=8iLU9wqQWDiFg9h-DQ@mail.gmail.com>
Subject: Re: [PATCH] tools: fix annoying "mkdir -p ..." logs when building
 tools in parallel
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Borislav Petkov <bp@suse.de>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 22, 2025 at 7:50=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Wed, Mar 19, 2025 at 1:41=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Mon, Feb 10, 2025 at 4:30=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > When CONFIG_OBJTOOL=3Dy or CONFIG_DEBUG_INFO_BTF=3Dy, parallel builds
> > > show awkward "mkdir -p ..." logs.
> > >
> > >   $ make -j16
> > >     [ snip ]
> > >   mkdir -p /home/masahiro/ref/linux/tools/objtool && make O=3D/home/m=
asahiro/ref/linux subdir=3Dtools/objtool --no-print-directory -C objtool
> > >   mkdir -p /home/masahiro/ref/linux/tools/bpf/resolve_btfids && make =
O=3D/home/masahiro/ref/linux subdir=3Dtools/bpf/resolve_btfids --no-print-d=
irectory -C bpf/resolve_btfids
> > >
> > > Defining MAKEFLAGS=3D<value> on the command line wipes out command li=
ne
> > > switches from the resultant MAKEFLAGS definition, even though the com=
mand
> > > line switches are active. [1]
> > >
> > > The first word of $(MAKEFLAGS) is a possibly empty group of character=
s
> > > representing single-letter options that take no argument. However, th=
is
> > > breaks if MAKEFLAGS=3D<value> is given on the command line.
> > >
> > > The tools/ and tools/% targets set MAKEFLAGS=3D<value> on the command
> > > line, which breaks the following code in tools/scripts/Makefile.inclu=
de:
> > >
> > >     short-opts :=3D $(firstword -$(MAKEFLAGS))
> > >
> > > If MAKEFLAGS really needs modification, it should be done through the
> > > environment variable, as follows:
> > >
> > >     MAKEFLAGS=3D<value> $(MAKE) ...
> > >
> > > That said, I question whether modifying MAKEFLAGS is necessary here.
> > > The only flag we might want to exclude is --no-print-directory, as th=
e
> > > tools build system changes the working directory. However, people mig=
ht
> > > find the "Entering/Leaving directory" logs annoying.
> > >
> > > I simply removed the offending MAKEFLAGS=3D.
> > >
> > > [1]: https://savannah.gnu.org/bugs/?62469
> > >
> > > Fixes: a50e43332756 ("perf tools: Honor parallel jobs")
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  Makefile | 9 ++-------
> > >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > I happened to sync up to mainline today and noticed that my build was
> > broken. I bisected it to this change and reverting this change fixes
> > my build on mainline.
> >
> > In my case I'm building in a ChromeOS environment and using clang as
> > my compiler. I'm also cross-compiling an arm64 kernel on x86 host.
> > ...but the pure mainline kernel should work there. Presumably the
> > environment is a bit different compared to the typical one, though?
> >
> > The error comes up when doing a clean build and the first error message=
s are:
> >
> > In file included from libbpf.c:36:
> > .../tools/include/uapi/linux/bpf_perf_event.h:14:21: error: field has
> > incomplete type
> >       'bpf_user_pt_regs_t' (aka 'struct user_pt_regs')
> >    14 |         bpf_user_pt_regs_t regs;
> >       |                            ^
> > .../tools/include/../../arch/arm64/include/uapi/asm/bpf_perf_event.h:7:=
16:
> > note: forward
> >       declaration of 'struct user_pt_regs'
> >     7 | typedef struct user_pt_regs bpf_user_pt_regs_t;
> >       |                ^
> >
> > btf_dump.c:1860:10: error: cast to smaller integer type 'uintptr_t'
> > (aka 'unsigned int') from 'const void *'
> >       [-Werror,-Wvoid-pointer-to-int-cast]
> >  1860 |         return ((uintptr_t)data) % alignment =3D=3D 0;
> >       |                 ^~~~~~~~~~~~~~~
> > btf_dump.c:2045:4: error: format specifies type 'ssize_t' (aka 'long')
> > but the argument has type 'ssize_t' (aka 'int')
> >       [-Werror,-Wformat]
> >  2044 |                 pr_warn("unexpected elem size %zd for array
> > type [%u]\n",
> >       |                                               ~~~
> >       |                                               %d
> >  2045 |                         (ssize_t)elem_size, id);
> >       |                         ^~~~~~~~~~~~~~~~~~
> > ./libbpf_internal.h:171:52: note: expanded from macro 'pr_warn'
> >   171 | #define pr_warn(fmt, ...)       __pr(LIBBPF_WARN, fmt, ##__VA_A=
RGS__)
> >       |                                                   ~~~    ^~~~~~=
~~~~~
> >
> >
> > I don't have time to dig right now, but I figured I'd at least post in
> > case the problem is obvious to someone else.
>
> I do not understand how to reproduce this.
>
> Your build machine is Chrome OS, or other distributions?
> Did you build the upstream kernel or downstream one?
> What is the build command?  Just "make" ?

Unfortunately, it's not a simple set of steps to reproduce and would
take a lot of time / disk space. :( Essentially, the steps are:

1. Setup a ChromeOS development environment. This is a pretty massive
thing. You'd have to follow the Developer Guide [1].

2. Enter the "chroot" in the development environment and build for a
board like "trogdor". This is an arm64 Chromebook.

3. The "trogdor" board normally builds a v6.6-based kernel, so it
looks for the kernel sources in `src/third_party/kernel/v6.6`. ...but
you can go into that folder and simply checkout a pure upstream kernel
as talked about in [2].

3. Inside the ChromeOS "chroot", you can do `cros-workon-trogdor start
chromeos-kernel-6_6` and `emerge-trogdor chromeos-kernel-6_6`. Since
you've checked out the upstream kernel to the v6.6 directory this
won't actually be building 6.6 but will be building the upstream
kernel.

...and that's where I see the error, which is "fixed" by reverting this pat=
ch.

FWIW: the actual build instructions for building the kernel are mostly
in cros-kernel.eclass [3].


Given how time consuming that would be to reproduce, I'm not sure it's
worth your time. Let me do some simple debugging... So I added these
extra printouts:

 tools/: FORCE
+       echo DOUGa new: "$(MAKEFLAGS)"
+       echo DOUGa old: "$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))"

 tools/%: FORCE
+       echo DOUGb new "$(MAKEFLAGS)"
+       echo DOUBb old: "$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))"

...and when I build, I see:

DOUGb new krR -j128 --jobserver-auth=3D3,4 --no-print-directory --
CLANG_CROSS_FLAGS=3D--target=3Daarch64-cros-linux-gnu
HOSTLD=3Dx86_64-pc-linux-gnu-ld.lld
HOSTPKG_CONFIG=3Dx86_64-pc-linux-gnu-pkg-config
HOSTCXX=3Dx86_64-pc-linux-gnu-clang++ HOSTCC=3Dx86_64-pc-linux-gnu-clang
CXX=3Daarch64-cros-linux-gnu-clang++\
CC_COMPAT=3Darmv7a-cros-linux-gnueabihf-clang
CC=3Daarch64-cros-linux-gnu-clang\  AR=3Dllvm-ar NM=3Dllvm-nm
STRIP=3Dllvm-strip REAL_STRIP=3Dllvm-strip OBJCOPY=3Dllvm-objcopy
LD_COMPAT=3Dld.lld LD=3Dld.lld
O=3D/build/trogdor/var/cache/portage/sys-kernel/chromeos-kernel-6_6 V=3D0

DOUBb old:  --jobserver-auth=3D3,4

...so pretty different! :-) I guess it used to be filtering out all
the cross-compiler info and now it isn't?


[1] https://www.chromium.org/chromium-os/developer-library/guides/developme=
nt/developer-guide/
[2] https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overla=
y/+/HEAD/eclass/cros-kernel/README.md
[3] https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overla=
y/+/HEAD/eclass/cros-kernel.eclass

