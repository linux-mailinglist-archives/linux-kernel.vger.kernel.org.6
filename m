Return-Path: <linux-kernel+bounces-348991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E97C98EEFD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809C31C225FC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622C0170A15;
	Thu,  3 Oct 2024 12:18:22 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905BF16DEA7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957902; cv=none; b=Fne4i16bjfjoMgGTnmJxsI4SSL4UT7yBr2cRWQ1n7iH91iDYFDtVK4q9cLWarg30bjH7mr7f/yslYR0ngVn3sZxLrx8ycaIcMoS5lPrcQS/gZw7/UIBcqzj6FE9urmIUJpdYzKXfo0VM09BSP9ogt1M/GYd3MNenvn75d91y9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957902; c=relaxed/simple;
	bh=lmkrKFWOggsANYGO2he9RvEnaU4dPFf8dkhPFZnIWL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETNuHPqgZq5Kf2Uo6m1SiDiwG5poR0Rt/9CpgqwfnfVTgrk+ncZE0kAbocaKm8dl3To8+TZNcFevWr+u2NiV0uuxX7fBDXP43gnyzjldY4NUN8GTO1VZ1VS63pGDDeFp5z/Uh7/3bp26T2+Yr6ga4hZtwL9yZ9ADu5Gz+MKLvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e25d11cc9f0so710341276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 05:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727957899; x=1728562699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzUgvjunHCQ7SGE8sSbs0EkkVci5m3mEYQoZOaGdKHI=;
        b=lLZYdDWuYihMZwE0WJP84R2qqUkkVZUWqC/TptM6GJiQbimzuHwlPB5FHW7UwVf6t7
         n+2SRGbNH4FKCliEt5YjLs9J5dYIYOysExgRzLqXS/yu6EO0Gtb7c6eXS5JJDDL3bHDR
         W54BfnNxikGxgb7VStrm22tO+mXvOSXixT3Jw+9nRD64CiD3MJ465CrqzEJvn7v/Pl2B
         MfntZzujuBySofUI3+ZSCUKAUP8tWBA0VzuLBjoDAlRauNk4+x03GxxzftuXew7a1EV4
         k7DQNGnc4+JOvZevq0bOdFeg42I2IdVmAXVbPROVWgQrgcojJy2ecO3xW4oDp4y0ZASl
         38Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVl9TYxHgYUfPgLPVwmzgW8IenETaT/mMStiLgzb3LdXFBHFMu2Dht+Z6ZRUulqrftSKnshGBI72hfMj7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3w3hS2liPy7YR0u6RCVw9FCVG5mQBPPMb2+XCKbqYWZxclZ3W
	1Bdh4+uM6zUVAQXegaMJIFXpBIhUAorVab9Lxw0z7tqt0biS/oDDQyNZ+ASFcLo=
X-Google-Smtp-Source: AGHT+IGoaDDizsOkhWyeFBNZzTUgvQdWOScZeFPjneUp7x3SgpCi11kBWR+qLaYYvgmigC44QfAGAw==
X-Received: by 2002:a25:c584:0:b0:e28:6844:e55d with SMTP id 3f1490d57ef6-e286844e68dmr3033463276.17.1727957899247;
        Thu, 03 Oct 2024 05:18:19 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2885ee2675sm180075276.64.2024.10.03.05.18.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 05:18:19 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e2b9e945b9so4780137b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 05:18:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr85LRTZRUjc/vd4jMpzYb0UAZsmeK37LIeSNDdFZkBbSkftEUssOlMaxzBP8L4QL+S58hXeJq9ubkz48=@vger.kernel.org
X-Received: by 2002:a05:690c:dcc:b0:6e2:1090:af31 with SMTP id
 00721157ae682-6e2a2ae01c6mr51545727b3.3.1727957898830; Thu, 03 Oct 2024
 05:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
 <87zfnmbfu7.fsf@igel.home> <CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
 <87iku9r300.fsf@linux-m68k.org> <CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
 <87ed4xr22r.fsf@linux-m68k.org> <CANiq72k3BBCCChVhDRALxX=mrtq2dZYR1RzdVU00n2LU=sGXjg@mail.gmail.com>
 <87h69t75do.fsf@igel.home>
In-Reply-To: <87h69t75do.fsf@igel.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 3 Oct 2024 14:18:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVkw+G6-YjDO_7F6xtgJCBfjKF8T=HuHzQuHbcJK6sp4g@mail.gmail.com>
Message-ID: <CAMuHMdVkw+G6-YjDO_7F6xtgJCBfjKF8T=HuHzQuHbcJK6sp4g@mail.gmail.com>
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 2:11=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
> On Okt 03 2024, Miguel Ojeda wrote:
>
> > Otherwise, does it mean we need a build-time test?
>
> A simple gcc version test definitely does not suffice.
>
> The suport for retain also depends on HAVE_INITFINI_ARRAY_SUPPORT, which
> is usually enabled by default (depends on glibc support, but that is
> much older), but can be disabled with --disable-initfini-array.

FTR, no --disable-initfini-array seen here:

$ arm-linux-gnueabihf-gcc-11 -v
Using built-in specs.
COLLECT_GCC=3D/usr/bin/arm-linux-gnueabihf-gcc-11
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc-cross/arm-linux-gnueabihf/11/lto-wrapper
Target: arm-linux-gnueabihf
Configured with: ../src/configure -v --with-pkgversion=3D'Ubuntu
11.4.0-1ubuntu1~22.04'
--with-bugurl=3Dfile:///usr/share/doc/gcc-11/README.Bugs
--enable-languages=3Dc,ada,c++,go,d,fortran,objc,obj-c++,m2
--prefix=3D/usr --with-gcc-major-version-only --program-suffix=3D-11
--enable-shared --enable-linker-build-id --libexecdir=3D/usr/lib
--without-included-gettext --enable-threads=3Dposix --libdir=3D/usr/lib
--enable-nls --with-sysroot=3D/ --enable-clocale=3Dgnu
--enable-libstdcxx-debug --enable-libstdcxx-time=3Dyes
--with-default-libstdcxx-abi=3Dnew --enable-gnu-unique-object
--disable-libitm --disable-libquadmath --disable-libquadmath-support
--enable-plugin --enable-default-pie --with-system-zlib
--enable-libphobos-checking=3Drelease --without-target-system-zlib
--enable-multiarch --disable-sjlj-exceptions --with-arch=3Darmv7-a+fp
--with-float=3Dhard --with-mode=3Dthumb --disable-werror
--enable-checking=3Drelease --build=3Dx86_64-linux-gnu
--host=3Dx86_64-linux-gnu --target=3Darm-linux-gnueabihf
--program-prefix=3Darm-linux-gnueabihf-
--includedir=3D/usr/arm-linux-gnueabihf/include
--with-build-config=3Dbootstrap-lto-lean --enable-link-serialization=3D2
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04)

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

