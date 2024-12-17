Return-Path: <linux-kernel+bounces-448691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C62869F4457
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9AA16435E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2A1DC999;
	Tue, 17 Dec 2024 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pPJ8kf2x"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A21DB933
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417850; cv=none; b=V9UDeQ53gM7RNqsL2gJ1sJUa2GECMio0UncAhFWJsoxkuwmY1jqOAlPIrUGLx06NJCqxCjyotfV6QTURgdSvQXpt8NN+SZ8HStT6bagB8YHsaSgF9ZwyhYZGFVP/yI96/hsUT9Mqdown6N+A4WwCIU1iOa9jylseLdwnwIjBg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417850; c=relaxed/simple;
	bh=XM6EdApDEzksuMmtbmXfUCRcI+WD33NtLIPMOkhyeDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V97Ds5+nD8gqSpF0IS6BQYmwNtSKnvNSay5j6UmnwkoIGArGAP8pP5HfjTqFF+lqr1bq1XqxkfSR2CUCtedpMnrPBPgTciM6SRwpCi9lBCQDnO/skDYAZzSPq5I+HC/ocz/Gnvgfjb+4LyHsngptuCJ+lB1wMs9ntDyBStbr3nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pPJ8kf2x; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166f1e589cso50904415ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734417847; x=1735022647; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sptCrX+fdOk7TfHGeXVf4O4ZKbAw/hvz5tMzXM5QRWU=;
        b=pPJ8kf2xnBe8hCzY7j+cNwCDDWX/xrw6NTCPVg6r/6fMr/ZyI9sfwuZ+ntElJSdTWZ
         ZhCeYwVODP25g9JqlF9g69CnE57SuasPlm+ZY0/r9lVUr/enbHje8ZxKfgXgXfXuDmV8
         mO2Xc+LvvQ0HsnMNRlF7Pnf1Aqb3jpiF8/xw7rCugs6XAuCcSMH+H+Qpi/DSN4HwY/eG
         CdUxgyMQj3MJFIBo0nAWzVOAyU8BJRN64wR27IGgtc5x8GrjArGUtz3HtHx+PPuIDPUx
         ifGB69DweiNwetpCZuDy1R4nyKMkBNg26RYNqX5WXwMYx0dgRO7Vl9CDklcds2glDjbC
         OmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417847; x=1735022647;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sptCrX+fdOk7TfHGeXVf4O4ZKbAw/hvz5tMzXM5QRWU=;
        b=az2MFnX+Wl7bgvDbNjs/xTi+F7rZE2EU6ji4w/suqTvZfRwqA4OgEYtavLstzlHLpV
         jqDayinOYoV2NeB1A8vEwhs7UF2KVOEboc/YbiuKy8/hXA1VLfEYuIaHll1Yu7APdKfO
         3drDxkGRV/FYkRRI343ZspEvGsJkiY24A0QxSHafRPdm9DzjE+LXodI4vpKASRaxP2OA
         mJhTvF4XU9uM3b/sshnZFCErUxJ6c01y1COXViV1E8KI76LnRne+1sQ0TJLKqm+kZ6Jh
         I5HD+lElyjjUPLzA6Yf/O/VqAhhSOY85iQ9IkY5dfQXY+lZYuQwkLvUXeMcCMhKhzGM4
         zSlw==
X-Forwarded-Encrypted: i=1; AJvYcCWRGKwZOt+GbM3DIBFXong7MHuZF7FITbkenZVq0YTCXIR3/uVAGxdQKyifnDvULDW2PT02JdUsnvo6kac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYJc0Wb6ebl3tEYEQ4wXo0TqacmVH5GH3iQpXBsLuznL41kQ2V
	FJy1ftZNy7ktsFWYT9K1asHszJmhiT96ri7t3oz9rlCuFL7HLmrWQED8i8qHq4M=
X-Gm-Gg: ASbGncsnarG2+5lsyllLo1vs6f3CW1OGw+p5GabUlttHgCX8b922XtBcxBpMCpX2ful
	DYtG00JlKl7kG4QdOIMDy6x6lNtyJC/i6blFcdtKWptGnuHNLnI57JpNE/Wqfs4N6CnLXviWXrs
	ZnB2lLwDbtWVZkxpqR2l8okJ0GPP6TniYm5792vLT0pRr4WEGDXu0D9e7Y8gzIVfvjhcNF+oqpY
	74cpOS1GEbEahL4wfqb/i75cJSpQV+UmclMmZkMuQwYo9C+2j0=
X-Google-Smtp-Source: AGHT+IFbTJRs0BXv1Y7k1oAF2gI2HiBiChGf9jttH4DB2JoV1zZ1F2nYln3NdWZebP2jJGmxHiY0Vg==
X-Received: by 2002:a17:902:cec4:b0:216:2e6d:babd with SMTP id d9443c01a7336-21892a0dfc5mr201253875ad.15.1734417846715;
        Mon, 16 Dec 2024 22:44:06 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:9708:a71e:40e6:860])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e643d5sm53002335ad.235.2024.12.16.22.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:44:05 -0800 (PST)
Date: Mon, 16 Dec 2024 22:44:02 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Nelson Chu <nelson@rivosinc.com>, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] tools: perf: tests: Fix code reading for riscv
Message-ID: <Z2Edsv2VB7D1hq3n@ghost>
References: <20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com>
 <20241216-perf_fix_riscv_obj_reading-v1-2-b75962660a9b@rivosinc.com>
 <CAP-5=fVvLv-OtkK57ri1EpM_v=PQZDZijYBpGv_9Smyz8EOm2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVvLv-OtkK57ri1EpM_v=PQZDZijYBpGv_9Smyz8EOm2g@mail.gmail.com>

On Mon, Dec 16, 2024 at 08:57:20PM -0800, Ian Rogers wrote:
> On Mon, Dec 16, 2024 at 3:13 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > After binutils commit e43d876 which was first included in binutils 2.41,
> > riscv no longer supports dumping in the middle of instructions. Increase
> > the objdump window by 2-bytes to ensure that any instruction that sits
> > on the boundary of the specified stop-address is not cut in half.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig              |  5 +++++
> >  tools/perf/tests/code-reading.c | 17 ++++++++++++++++-
> 
> Files under tools use a different Build system than the kernel. The
> Kconfig value won't have an effect. Check out Makefile.config:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Makefile.config?h=perf-tools-next
> which is included into the build here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Makefile.perf?h=perf-tools-next#n313
> 

Ahh okay, thank you. It was properly enabling when I was testing, is
there some bleeding over?

> >  2 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d4a7ca0388c071b536df59c0eb11d55f9080c7cd..f164047471267936bc62389b7d7d9a7cbdca8f97 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -229,6 +229,11 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
> >         def_bool CC_IS_GCC
> >         depends on $(cc-option,-fpatchable-function-entry=8)
> >
> > +config RISCV_OBJDUMP_SUPPORTS_SPLIT_INSTRUCTION
> > +       # Some versions of objdump do not support dumping partial instructions
> > +       def_bool y
> > +       depends on !(OBJDUMP_IS_GNU && OBJDUMP_VERSION > 24100)
> > +
> >  config HAVE_SHADOW_CALL_STACK
> >         def_bool $(cc-option,-fsanitize=shadow-call-stack)
> >         # https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
> > diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> > index 27c82cfb7e7de42284bf5af9cf7594a3a963052e..605f4a8e1dbc00d8a572503f45053c2f30ad19e3 100644
> > --- a/tools/perf/tests/code-reading.c
> > +++ b/tools/perf/tests/code-reading.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <errno.h>
> > +#include <linux/kconfig.h>
> >  #include <linux/kernel.h>
> >  #include <linux/types.h>
> >  #include <inttypes.h>
> > @@ -183,9 +184,23 @@ static int read_via_objdump(const char *filename, u64 addr, void *buf,
> >         const char *fmt;
> >         FILE *f;
> >         int ret;
> > +       u64 stop_address = addr + len;
> > +
> > +       if (IS_ENABLED(__riscv) && !IS_ENABLED(CONFIG_RISCV_OBJDUMP_SUPPORTS_SPLIT_INSTRUCTION)) {
> 
> It would be nice if this could be a runtime rather than build time detected.

Hmm that is a good point. I will change this to check the version at
runtime.

- Charlie

> 
> Thanks,
> Ian
> 
> > +               /*
> > +                * On some versions of riscv objdump, dumping in the middle of
> > +                * instructions is not supported. riscv instructions are aligned along
> > +                * 2-byte intervals and can be either 2-bytes or 4-bytes. This makes it
> > +                * possible that the stop-address lands in the middle of a 4-byte
> > +                * instruction. Increase the stop_address by two to ensure an
> > +                * instruction is not cut in half, but leave the len as-is so only the
> > +                * expected number of bytes are collected.
> > +                */
> > +               stop_address += 2;
> > +       }
> >
> >         fmt = "%s -z -d --start-address=0x%"PRIx64" --stop-address=0x%"PRIx64" %s";
> > -       ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, addr + len,
> > +       ret = snprintf(cmd, sizeof(cmd), fmt, test_objdump_path, addr, stop_address,
> >                        filename);
> >         if (ret <= 0 || (size_t)ret >= sizeof(cmd))
> >                 return -1;
> >
> > --
> > 2.34.1
> >

