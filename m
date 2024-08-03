Return-Path: <linux-kernel+bounces-273313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2517C946747
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 05:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5EA1C20C41
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 03:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA5D10A11;
	Sat,  3 Aug 2024 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITQHbYLW"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E6D27E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 03:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722657351; cv=none; b=abdZqg+I3x6sBfcxnDobiLbGTlvDpy1UjUMtQSUUZG05HNm46CbJgar1QKUgau6eZHGUhk6s3mj9hLkXA5UH8YB2mdDU8RLiruOpnf+LooKhHkmfkJvTEiy3wbFabLYOBz4pO6DhgFirN3haYhSH7HKSdyW8pGTRkt5XwgTF08g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722657351; c=relaxed/simple;
	bh=+KrWID0i1d0ItTzSportrgwrVEDsu2q94O2Vgk8NVcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bZKiuWyfdh3Vng7zZQesI7iH1sS2jJf2K6xO06NbLv1V7vahdmCahdwW1bPRMNGExLoFdND1giTMoE0qHmTmIPMrzVgq2KO7aXaKVn8VFAx095wM+c5nkzPrbz8KFntdZXYzCDdjUljnHGNxAiIxFYoZfRnL/ATcufgXAvnTNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITQHbYLW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc5549788eso71413505ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 20:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722657349; x=1723262149; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3/+x9XhUXosbNrXjh6n2j3KWfC39a/aOnVbg2u5Ppo=;
        b=ITQHbYLW0CM2XOgaBVekLscxRLz3cGT6+RHguIPTlASe3O87qUfDdIGez3krVPqTf2
         h987mpNLrLzlzZtdG9fPxXUFdiQDZ++EpSQkxELYCnRljr6CloFpZBjujkm4FeqEJHoL
         UQL8XMDI9BlGNr1hOjM2I4pAG8fekV/UEZAITKPaZafjMKbBJEO39rChXLhXQETngo7C
         yFzhlv+H1oizu75TdiB0o3bIEJ5y0vv+ZDeO1ds30gDj6vwmpZm31LcgwIp2s2i12f5o
         7wS2Pfnlkh47kaqmeVHg30VLxDTeOL1RAmgHiid2qRJFuzJbC3abIB18zG7to4sZHqoD
         yfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722657349; x=1723262149;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3/+x9XhUXosbNrXjh6n2j3KWfC39a/aOnVbg2u5Ppo=;
        b=gKDekYKfWnd0RMYREs62mQ+seYBhqG9DTDe3exVq/ZXWAy135Y0ZXdoHKK1uvEC5eh
         ZxdB4XEQOY5uf76Lu3jVh9VqVdZ6hqD+xBEqZcet2bdu8L2LxzXQD4RcLdsKJR2t++a4
         dogCFXT3/mh1/TCKXadnocKyJ4mCbg5YNV43ARAKp3VIZTaZ94QNsh3JaKIXWqG+bQo/
         gDku8CAChjO63NSeAZg0wqfrQXr9yIFkQIwYpQzzBnxdajXVxC1++2DwNRNyKyHFCd8j
         JQhni13y1uYvlo32OFrvEloFahbXKMfEc7PgZyi67QZo15kN0pHzakCtUFv92epVJkUM
         RTgw==
X-Gm-Message-State: AOJu0YyXJHeo/B60IwfHKkFQDVUfuH5bQBiCj7F7VrwoU6w9Xzwq6Hh9
	7xhXdbxJzi3aSKIwPdS8zJ5xJIzzwoxWqYJHMwMelfQl2UIocSZk
X-Google-Smtp-Source: AGHT+IGDEvN+1yqCBkh17jjFy05oGxGAAFOv59twQ8CM7Dev5NXswcpDGSy4dv+zoadV9LoJ1Qi9bQ==
X-Received: by 2002:a17:902:bb96:b0:1fd:a5a2:5838 with SMTP id d9443c01a7336-1ff5725228fmr57085265ad.6.1722657348669;
        Fri, 02 Aug 2024 20:55:48 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f57160sm25261575ad.96.2024.08.02.20.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 20:55:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id ADD904A24169; Sat, 03 Aug 2024 10:55:45 +0700 (WIB)
Date: Sat, 3 Aug 2024 10:55:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	x86@kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Takashi Iwai <tiwai@suse.de>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Stas Sergeev <stsp2@yandex.ru>,
	mrwizardwizard <terrym3201@protonmail.com>
Subject: Fwd: error: 'const_pcpu_hot' causes a section type conflict with
 'pcpu_hot' when compiling with -flto
Message-ID: <Zq2qQW62G63dr70s@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdWkxgM3dJYn/4Um"
Content-Disposition: inline


--sdWkxgM3dJYn/4Um
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

mrwizardwizard <terrym3201@protonmail.com> reported kernel FTBFS on bugzilla
(https://bugzilla.kernel.org/show_bug.cgi?id=3D219099) when the kernel
is built with LTO:

> Hello,
>
> when compiling linux kernel 6.9-6.10 with -flto
>
> compiler outputs:
>
> ./arch/x86/include/asm/current.h:42:25: error: 'const_pcpu_hot' causes a =
section type conflict with 'pcpu_hot' const_pcpu_hot);
>

He could reproduce the build error on mainline:

>> Can you reproduce above on current mainline (v6.11-rc1)?
>=20
>=20
> same messages
>=20
> mkdir -p /home/mrwizardwizard/Documents/Kernel/linux-6.11-rc1/tools/objto=
ol && make O=3D/home/mrwizardwizard/Documents/Kernel/linux-6.11-rc1 subdir=
=3Dtools/objtool --no-print-directory -C objtool=20
>   INSTALL libsubcmd_headers
>   CALL    scripts/checksyscalls.sh
>   CC      init/main.o
>   AS      arch/x86/entry/entry.o
>   AS      arch/x86/entry/entry_64.o
> arch/x86/entry/entry_64.o: warning: objtool: __switch_to_asm+0x18: stack =
layout conflict in alternatives: .altinstr_replacement+0x1d
>   CC      arch/x86/entry/syscall_64.o
> In file included from ./include/asm-generic/percpu.h:7,
>                  from ./arch/x86/include/asm/percpu.h:616,
>                  from ./arch/x86/include/asm/current.h:11,
>                  from ./arch/x86/include/asm/processor.h:17,
>                  from ./arch/x86/include/asm/timex.h:5,
>                  from ./include/linux/timex.h:67,
>                  from ./include/linux/time32.h:13,
>                  from ./include/linux/time.h:60,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:13,
>                  from init/main.c:17:
> ./arch/x86/include/asm/current.h:42:25: error: 'const_pcpu_hot' causes a =
section type conflict with 'pcpu_hot'
>    42 |                         const_pcpu_hot);
>       |                         ^~~~~~~~~~~~~~
> ./arch/x86/include/asm/current.h:38:42: note: 'pcpu_hot' was declared here
>    38 | DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
>       |                                          ^~~~~~~~
> make[3]: *** [scripts/Makefile.build:244: init/main.o] Error 1
> make[2]: *** [scripts/Makefile.build:485: init] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      arch/x86/entry/common.o
>   CC      arch/x86/events/core.o
>   CC      arch/x86/entry/vdso/vma.o
> In file included from ./include/asm-generic/percpu.h:7,
>                  from ./arch/x86/include/asm/percpu.h:616,
>                  from ./arch/x86/include/asm/current.h:11,
>                  from ./include/linux/sched.h:12,
>                  from ./include/linux/ptrace.h:6,
>                  from ./include/uapi/asm-generic/bpf_perf_event.h:4,
>                  from ./arch/x86/include/generated/uapi/asm/bpf_perf_even=
t.h:1,
>                  from ./include/uapi/linux/bpf_perf_event.h:11,
>                  from ./include/linux/perf_event.h:18,
>                  from arch/x86/events/core.c:15:
> ./arch/x86/include/asm/current.h:42:25: error: 'const_pcpu_hot' causes a =
section type conflict with 'pcpu_hot'
>    42 |                         const_pcpu_hot);
>       |                         ^~~~~~~~~~~~~~
> ./arch/x86/include/asm/current.h:38:42: note: 'pcpu_hot' was declared here
>    38 | DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
>       |                                          ^~~~~~~~
> make[4]: *** [scripts/Makefile.build:244: arch/x86/events/core.o] Error 1
> make[3]: *** [scripts/Makefile.build:485: arch/x86/events] Error 2
> make[3]: *** Waiting for unfinished jobs....
>   AR      arch/x86/entry/vsyscall/built-in.a
>   CC      arch/x86/entry/vdso/extable.o
>   LDS     arch/x86/entry/vdso/vdso.lds
>   AS      arch/x86/entry/vdso/vdso-note.o
>   CC      arch/x86/entry/vdso/vclock_gettime.o
>   CC      arch/x86/entry/vdso/vgetcpu.o
>   CC      arch/x86/entry/vdso/vgetrandom.o
>   AS      arch/x86/entry/vdso/vgetrandom-chacha.o
>   HOSTCC  arch/x86/entry/vdso/vdso2c
>   VDSO    arch/x86/entry/vdso/vdso64.so.dbg
>   OBJCOPY arch/x86/entry/vdso/vdso64.so
>   VDSO2C  arch/x86/entry/vdso/vdso-image-64.c
>   CC      arch/x86/entry/vdso/vdso-image-64.o
>   AR      arch/x86/entry/vdso/built-in.a
>   AS      arch/x86/entry/thunk.o
>   AR      arch/x86/entry/built-in.a
> make[2]: *** [scripts/Makefile.build:485: arch/x86] Error 2
> make[1]: *** [/home/mrwizardwizard/Documents/Kernel/linux-6.11-rc1/Makefi=
le:1927: .] Error 2
> make: *** [Makefile:224: __sub-make] Error=20

For the full build log, see Bugzilla link.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--sdWkxgM3dJYn/4Um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZq2qOgAKCRD2uYlJVVFO
o1SQAP4xb5TVA7csUgsmZhs+FP2mHhnwmw90if2UOUtWXkbWHwD/UnaMOSx/7F6z
VGz7kN3KxdUbcvDD9LJTFmf9wGFQRgc=
=WdPW
-----END PGP SIGNATURE-----

--sdWkxgM3dJYn/4Um--

