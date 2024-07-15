Return-Path: <linux-kernel+bounces-253028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5927B931B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB0B282E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45013A86C;
	Mon, 15 Jul 2024 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Au//Wmy8"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE25282FD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074015; cv=none; b=sbG6o08+bcLmZ46y1i5jWpaJdcAhqwOzln5XaH8o2O0FNsSirYA/3XewLAGNGmkjfmDmQ+fWVEYMMCDoiv0d7JmqP/vZQflb0tMCROSJxbztofJhhY4n16WVgpHTayZDiQ6NEEau7A5KIHFS6LcvDnLhL55Akv+eS++ykTR3hfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074015; c=relaxed/simple;
	bh=B2vc3DD4WEO38QwQ6jCz/5wTOqrbE0d/Etel5IBpfSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHEFRzUyNa6E+7mG4F7jdjaVHe1wNwQnMBa+mXmQwIxdWrRbU6SXpOBazQyk9iQkGnJgX3ijK537sY/WDZDLLjzcyzNnH38VMOO2H3f74Tz9Vd7F5k4z6BCjenDbAXvoF4q175QG+cQFg+4Ay88m1ku39cku3by78AetfhNg788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Au//Wmy8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb2936c4ccso52705ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721074012; x=1721678812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aY4+U43jGU+PWdE4qdb6IhADmBDsCqbuinl2mj7BM78=;
        b=Au//Wmy8kpEa2UQ4wqbN7fFnLtiOVYmn+FSKlKITABclfI4Pvhi7ZKIn0aNVGQMSkf
         VyxlC7y7RkGtebqzDo6swWDydWiru1IbqJpdqXkmL3ZPkUcqQvcwt4UslDPyRG0lxIEC
         HG9G2Z2n/FUDsZwEzIyOeVK6q6/XYLx6U66ofR9NGnNZZIsp6eopvNXftozzD96tUm2r
         5SV+Ej9/Db97lyolq04ZFD77DUFnF7erph75wdEXT4+gh1iwR5tj+oarx71hf29Letkp
         bLrX9UrrS8UbRPkTufxeB7OEyJSk4AMu3ZvUnyDd91qzqjePlLtmOsgKdNGzAaymONT7
         cu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074012; x=1721678812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aY4+U43jGU+PWdE4qdb6IhADmBDsCqbuinl2mj7BM78=;
        b=InJXobCX0+e/qw93Z9DTnrJNJQBFmInfoQCyzDsH89Bqjo/8DaDDI6wP6wNHDbySmT
         mer6wLPrx0mEuJOr7ev4cCyoPeGgh00kBuZNPmvHbzh9kFjbNo05KxD/8ZTy7eYZRq7R
         ZjvlP8LREpsv0oxGQ5OJoo4e8pcreAa2jjDoz0NFeIbjsf9NM+OD9i/A0nOqe3VgkBIZ
         QcgvujNer8xqDzoZe5h0iHUcxeYBeX1T9Ozz1wLsNyiq8hFVAIti8RMRcoMg/O6pCsQ6
         1BHQGtBDlFl5TKZgCLnYcA2TLYXWKVc1A1lLRLvB5tDWdvN3WE6e+FgVPrPai7RGo7Mq
         ajcA==
X-Forwarded-Encrypted: i=1; AJvYcCUcyq7Dwnt90GBW3aKxQAz8fUupgwb5i/4gk4SJo3y5oPUK7UFS5kk0E2NvOwmBBgdhg9v5WoEUWdoLZrbFJW7fkoSUo2nXL9l7KKsE
X-Gm-Message-State: AOJu0Yz2kXJ4wlIrguMuOBsAiilAAbhCdDmnwdXVVVn1oclbjwHXD469
	RtmaNV0DFVbenp0PCJQ0bRtfXXDSQKHupxn79whrcLs7rKWaDuCGkgcGcC315QSLCb56//8Xrfh
	aeP6CMSzPUSdbuAZt8uuN86Zjn4gqHnI4zJ+3
X-Google-Smtp-Source: AGHT+IE9X+/7yVTBiga6aYvWLxoZE0vEJPOU0mE201Fch/w83/X5UvqY6SFMKwI1W2Ejzct3v1Vwp9Bcc1F+lHnpGIc=
X-Received: by 2002:a17:903:230a:b0:1f8:782a:39a4 with SMTP id
 d9443c01a7336-1fc3c73f74bmr729865ad.6.1721074012265; Mon, 15 Jul 2024
 13:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715143342.52236-1-leo.yan@arm.com> <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
 <1487da55-24dc-40ef-a6e8-4bf4b153fdc3@arm.com> <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUGJmOr9XcsVWWCREjr1A7rUFaMk0VPkQAKDAEjTLKJVQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 13:06:40 -0700
Message-ID: <CAP-5=fWY4AeMxfNGh_jB4gss_qtGSgfX4pvv-D-fpCWuqamVfA@mail.gmail.com>
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:44=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Jul 15, 2024 at 12:31=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
> >
> >
> > Hi Ian,
> >
> > On 7/15/24 18:17, Ian Rogers wrote:
> > > On Mon, Jul 15, 2024 at 7:34=E2=80=AFAM Leo Yan <leo.yan@arm.com> wro=
te:
> > > [snip]
> > >> +Android NDK compilation is deprecated and no longer supported.
> > >
> > > I think this is objectively worse than just removing the file. It is
> > > likely the perf tool can build with clang/LLVM, I do it every day
> >
> > Just curious, are you using LLVM/clang for cross building (e.g. build
> > aarch64 target on x86_64 host) or just native building?
> >
> > Clang/LLVM is a natively cross-compiler [1], I installed Clang-15 in th=
e
> > offical package on Ubuntu, but I failed to do cross compilation with it=
:
> >
> >    make ARCH=3Darm64 LLVM=3D-15 VF=3D1 DEBUG=3D1 -C tools/perf
>
> So we're cross-compiling in bazel, so it is a different set up than
> the makefiles - I'm happy to work to share the bazel set up if other
> people care. I'm having a play to see if I can get the Makefile
> working, my first attempts are clearly mixing x86 code into the
> supposedly arm64 build, which would appear to be more of a build
> system rather than code problem.

So if I add (somewhat taken from tools/testing/selftests/lib.mk):
```
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5271a4c1d2b3..9edf5f41d6e4 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -19,6 +19,35 @@ detected_var =3D $(shell echo "$(1)=3D$($(1))" >>
$(OUTPUT).config-detected)
CFLAGS :=3D $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS)=
)
HOSTCFLAGS :=3D $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))

+CLANG :=3D clang
+
+CLANG_TARGET_FLAGS_arm          :=3D arm-linux-gnueabi
+CLANG_TARGET_FLAGS_arm64        :=3D aarch64-linux-gnu
+CLANG_TARGET_FLAGS_hexagon      :=3D hexagon-linux-musl
+CLANG_TARGET_FLAGS_i386         :=3D i386-linux-gnu
+CLANG_TARGET_FLAGS_m68k         :=3D m68k-linux-gnu
+CLANG_TARGET_FLAGS_mips         :=3D mipsel-linux-gnu
+CLANG_TARGET_FLAGS_powerpc      :=3D powerpc64le-linux-gnu
+CLANG_TARGET_FLAGS_riscv        :=3D riscv64-linux-gnu
+CLANG_TARGET_FLAGS_s390         :=3D s390x-linux-gnu
+CLANG_TARGET_FLAGS_x86          :=3D x86_64-linux-gnu
+CLANG_TARGET_FLAGS_x86_64       :=3D x86_64-linux-gnu
+
+# Default to host architecture if ARCH is not explicitly given.
+ifeq ($(ARCH),)
+CLANG_TARGET_FLAGS :=3D $(shell $(CLANG) -print-target-triple)
+else
+CLANG_TARGET_FLAGS :=3D $(CLANG_TARGET_FLAGS_$(ARCH))
+endif
+
+ifeq ($(CLANG_TARGET_FLAGS),)
+$(error Specify CROSS_COMPILE or add '--target=3D' option to lib.mk)
+else
+CLANG_FLAGS     +=3D --target=3D$(CLANG_TARGET_FLAGS)
+endif # CLANG_TARGET_FLAGS
+
+CC :=3D $(CLANG) $(CLANG_FLAGS) -fintegrated-as
+
# Enabled Wthread-safety analysis for clang builds.
ifeq ($(CC_NO_CLANG), 0)
  CFLAGS +=3D -Wthread-safety
```
I was able to build with:
$ make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -C tools/perf
O=3D/tmp/perf NO_LIBELF=3D1 NO_LIBTRACEEVENT=3D1 NO_LIBPYTHON=3D1 CC=3Dclan=
g
CXX=3Dclang++

Obviously not a complete fix as it is unconditionally forcing CC to
clang, but I don't think we're too far from having a clang/llvm cross
compile build that can work.

Thanks,
Ian

