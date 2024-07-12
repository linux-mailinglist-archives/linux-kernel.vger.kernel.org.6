Return-Path: <linux-kernel+bounces-250199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF892F519
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB16283898
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBBA1805E;
	Fri, 12 Jul 2024 05:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQ4TJIY/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436D17BBF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720762651; cv=none; b=aZClqNaFODu5/0j0qP59YNs5Tq9xlnvbxh/7/26LlTjEZzXDc1XAj2aRbu33ws7QwsrbxwWMvSndIJT+Rjo074wAAR9YX9WBoFa8U5+QC1+0t733/LE9Hfijk1huCmquF1vPRI0PKWc34pe1kZQyPoHI7XBe2vKT7iLyLVN2+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720762651; c=relaxed/simple;
	bh=ycW3MshNjKteaBVobCSDIboGwAMJeZ4dK2sEPd7PzzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKsn3Kra0c7lR8/OP/liXFR/W0j0yTriZt/740ehGEw3SaIeUCm+JKI4jaoQ4hifQRL7k3n+A9f1d0srMOdjMuJ3fbfpULa1Qnea/c/8kKBEQLiWz037jckJIxG2fZRjvvpgMqflZWTVzL55zcQo6FvEQm7l0ia7QBl/5DUoWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQ4TJIY/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fb10519ae3so72405ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 22:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720762649; x=1721367449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH3qZ/7Le7SMeUq7EqrX+ajUtlSjo++wTXKwFvqTS3I=;
        b=XQ4TJIY/QxcPryFluAfpBwbyegjoGifkQUMtqOz1/yccMoSQa3DpETUvIflvc42qJd
         5kPfMOAxZ9HAbrnKNNQuWFgHzF3M/8ANim3CedF067XoHTZgMbn/Oa+Is9e1t+6q1FfI
         O1ozNcVSKzh5lkv+3VXzHmF9S6HIUsjyTKy/+pYZJYYAYXmpJR8ZmpnoUW/WIBCePOOp
         SXdjv6Ua2swifB5vKlYMG/9QTauZ7s9tJ7XePUS8AVDARDGyT2+0WNOTDvt0Dc9g7L3a
         Vp06pF/g8TIKCSpE6IIw3maL0siYGHbe+cA8idQGV3km0VKzpp2L/Vr/6PvWNDGJc4/M
         Klow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720762649; x=1721367449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH3qZ/7Le7SMeUq7EqrX+ajUtlSjo++wTXKwFvqTS3I=;
        b=ikqqEvbfQTWgKprKTBnF8uWFkh4gBxpKuE8c0uv3Bzhfbo1NNNhLVFKf/vj2LIbSwY
         khpGE4pJjiHkJlG7WfEvjl22Tegumtiw/Kr2D9lGOh3YHhwACSrTpOqwNIuVG0Ycpeh/
         h1UFs70rLWHJodW/Yww2/1E5bvno/TFoBlsRCRGbBkdZ7TV/iaQjig3bNeCEZk0R3p8T
         S4rTrvaN/ZDoHeJNUU4BTyvgG/IvYXFAdrM1PGKUXDey3ZPr0TltpzXFIt4i8ijIpEej
         bRaj3Byt4tJyFrlDSWxksNoSrlszyFV8VjTT3Sb99CihGl9hd8RHaAVJlHyx3QVvQSBw
         NbWA==
X-Forwarded-Encrypted: i=1; AJvYcCVvyHJ625Jfk7HYQG+Q8FDbCE1rZOR5ZG3vuwgUTtd1TiBwQs86Zh91YHNBuDJTQNdTcclLQXxYdiUWGMDZr6XlvkVH0mGHEATsjXQw
X-Gm-Message-State: AOJu0Yx0KjPuggLz6PS/sAy8/ee3krRn2uBcB9zm4gttZFfFGx4pQzBQ
	7wFl69ytixvht8C2OAqEJgx7iRspC/QKtKJMU3vWvRrsyoWFWYkTla0ryFULFmhIKDomBbXJjLY
	IFaveaP/JX9vsEggeOoqeWCleFS4K14TFpjaD
X-Google-Smtp-Source: AGHT+IElXIRXWUBJFFoKWg9ej8d296ASuBabnWfhRhCAdVw/f3nWgnCz9mk1c7X3KAIhxGPRWD4EL/SE8GxpGrquGCg=
X-Received: by 2002:a17:902:e850:b0:1fb:1a7:a64f with SMTP id
 d9443c01a7336-1fbf24bb3edmr1876795ad.20.1720762649164; Thu, 11 Jul 2024
 22:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706182912.222780-1-leo.yan@arm.com> <20240706182912.222780-8-leo.yan@arm.com>
 <ZpC3-p0kG7dGkp_5@google.com>
In-Reply-To: <ZpC3-p0kG7dGkp_5@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Jul 2024 22:37:17 -0700
Message-ID: <CAP-5=fXsN2Z+0T-7kS-pub2i_X8RgRQeTPh4QcxAkWeSL+PuPw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] perf docs: Remove the Android cross building document
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Changbin Du <changbin.du@huawei.com>, 
	James Clark <james.clark@linaro.org>, amadio@gentoo.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 9:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sat, Jul 06, 2024 at 07:29:12PM +0100, Leo Yan wrote:
> > The Android NDK (as time being the latest LTS version is r26d) changes
> > toolchain to LLVM / Clang, so GCC compilers is not included in the NDK
> > anymore. Therefore, the Android document contains obsolete info for
> > building perf binary with NDK.
>
> Do you know if the version prior to the change is still used?

The git log last mentions NDK 12 from 2016 working. I suspect these
instructions haven't worked for a good long while.

Thanks,
Ian

> >
> > Furthermore, the Clang included in the Android NDK is problematic for
> > cross compilation Aarch64 target. The building reports multiple errors
> > with the compiler aarch64-linux-android34-clang.
> >
> > Thus, delete Documentation/android.txt to avoid confusion.
>
> If so, maybe we can keep the document little more and add a note that
> this works only for some old versions.
>
> I'm also curious if it's still broken after your fixes.
>
> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/perf/Documentation/android.txt | 78 ----------------------------
> >  1 file changed, 78 deletions(-)
> >  delete mode 100644 tools/perf/Documentation/android.txt
> >
> > diff --git a/tools/perf/Documentation/android.txt b/tools/perf/Document=
ation/android.txt
> > deleted file mode 100644
> > index 24a59998fc91..000000000000
> > --- a/tools/perf/Documentation/android.txt
> > +++ /dev/null
> > @@ -1,78 +0,0 @@
> > -How to compile perf for Android
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -I. Set the Android NDK environment
> > -------------------------------------------------
> > -
> > -(a). Use the Android NDK
> > -------------------------------------------------
> > -1. You need to download and install the Android Native Development Kit=
 (NDK).
> > -Set the NDK variable to point to the path where you installed the NDK:
> > -  export NDK=3D/path/to/android-ndk
> > -
> > -2. Set cross-compiling environment variables for NDK toolchain and sys=
root.
> > -For arm:
> > -  export NDK_TOOLCHAIN=3D${NDK}/toolchains/arm-linux-androideabi-4.9/p=
rebuilt/linux-x86_64/bin/arm-linux-androideabi-
> > -  export NDK_SYSROOT=3D${NDK}/platforms/android-24/arch-arm
> > -For x86:
> > -  export NDK_TOOLCHAIN=3D${NDK}/toolchains/x86-4.9/prebuilt/linux-x86_=
64/bin/i686-linux-android-
> > -  export NDK_SYSROOT=3D${NDK}/platforms/android-24/arch-x86
> > -
> > -This method is only tested for Android NDK versions Revision 11b and l=
ater.
> > -perf uses some bionic enhancements that are not included in prior NDK =
versions.
> > -You can use method (b) described below instead.
> > -
> > -(b). Use the Android source tree
> > ------------------------------------------------
> > -1. Download the master branch of the Android source tree.
> > -Set the environment for the target you want using:
> > -  source build/envsetup.sh
> > -  lunch
> > -
> > -2. Build your own NDK sysroot to contain latest bionic changes and set=
 the
> > -NDK sysroot environment variable.
> > -  cd ${ANDROID_BUILD_TOP}/ndk
> > -For arm:
> > -  ./build/tools/build-ndk-sysroot.sh --abi=3Darm
> > -  export NDK_SYSROOT=3D${ANDROID_BUILD_TOP}/ndk/build/platforms/androi=
d-3/arch-arm
> > -For x86:
> > -  ./build/tools/build-ndk-sysroot.sh --abi=3Dx86
> > -  export NDK_SYSROOT=3D${ANDROID_BUILD_TOP}/ndk/build/platforms/androi=
d-3/arch-x86
> > -
> > -3. Set the NDK toolchain environment variable.
> > -For arm:
> > -  export NDK_TOOLCHAIN=3D${ANDROID_TOOLCHAIN}/arm-linux-androideabi-
> > -For x86:
> > -  export NDK_TOOLCHAIN=3D${ANDROID_TOOLCHAIN}/i686-linux-android-
> > -
> > -II. Compile perf for Android
> > -------------------------------------------------
> > -You need to run make with the NDK toolchain and sysroot defined above:
> > -For arm:
> > -  make WERROR=3D0 ARCH=3Darm CROSS_COMPILE=3D${NDK_TOOLCHAIN} EXTRA_CF=
LAGS=3D"-pie --sysroot=3D${NDK_SYSROOT}"
> > -For x86:
> > -  make WERROR=3D0 ARCH=3Dx86 CROSS_COMPILE=3D${NDK_TOOLCHAIN} EXTRA_CF=
LAGS=3D"-pie --sysroot=3D${NDK_SYSROOT}"
> > -
> > -III. Install perf
> > ------------------------------------------------
> > -You need to connect to your Android device/emulator using adb.
> > -Install perf using:
> > -  adb push perf /data/perf
> > -
> > -If you also want to use perf-archive you need busybox tools for Androi=
d.
> > -For installing perf-archive, you first need to replace #!/bin/bash wit=
h #!/system/bin/sh:
> > -  sed 's/#!\/bin\/bash/#!\/system\/bin\/sh/g' perf-archive >> /tmp/per=
f-archive
> > -  chmod +x /tmp/perf-archive
> > -  adb push /tmp/perf-archive /data/perf-archive
> > -
> > -IV. Environment settings for running perf
> > -------------------------------------------------
> > -Some perf features need environment variables to run properly.
> > -You need to set these before running perf on the target:
> > -  adb shell
> > -  # PERF_PAGER=3Dcat
> > -
> > -IV. Run perf
> > -------------------------------------------------
> > -Run perf on your device/emulator to which you previously connected usi=
ng adb:
> > -  # ./data/perf
> > --
> > 2.34.1
> >

