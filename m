Return-Path: <linux-kernel+bounces-259443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F21939640
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624981F22053
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3307F3C488;
	Mon, 22 Jul 2024 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lgJMC4De"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0241838DCC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686107; cv=none; b=ckjdUjDQS8EfqpBv8B/zO17g73drzshdVwAfCENQufG78RT4H5QdAA51cSqLp06FyjDWzcjJPtUP+j030yEctbbclimNLhHHJ0sx0qXq5uJkXTkcPsonT6PjsPYzAgeL9/HhIqDqlY0gq3VaEDj+ePtJsuMnMNefKhrKVG8+asw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686107; c=relaxed/simple;
	bh=5jXJcvZnIJmi0Gtk92mhNC9bTi+aOWLjUB7i5x1e8JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzAEL3qzmmN3V3z2p1iFkyE7M3HjPTb39uWynAoIizWwRZW8Df2rfdXZ+BNENz96l470EnIfFt8oD/m9HR581W0Td5viSWV/PMQajH/3aC8L7dcUKm6TQZEF+Hgv++bGKSNjBkUMCwdR8kjWXPnPsC0KFiUPXweHhrKl09h84gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lgJMC4De; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b79c27dd01so28070626d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721686104; x=1722290904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWkf3HH1tp0DsKyJLpS4yaHfwlf3QF0BPJJ770sq1hg=;
        b=lgJMC4DeH/Mwv2gqImoh3/DeZ9iXcEgzcViopf+UmeFPsSF20lzaoqE9tAy8cfb366
         b8B/eLHJDX2hjqpOeZBqnphI6qWzdFvOqFLONmou5AuMJujt4LaEMUXJ4kRbYtXtz+0M
         CDrC+Q6s7mbIbmADThcFqBqA0h2jtew6Rxrm5LdznFclub8bURl45FXols5VTeC8jHFO
         HzJ/k7Mj7VgnLbRIkR3v4BuU0MdQUGJ5NIb1YhCNFVNplalq/J9fM/ZXhW9iH//NzF1b
         /GyHf3qjIDCla+TJtTFcrY0es6VaCcrWAmmGLNniTM/YOvjX7aRM376psLHWP3R5D/wn
         rs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721686104; x=1722290904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWkf3HH1tp0DsKyJLpS4yaHfwlf3QF0BPJJ770sq1hg=;
        b=PDWYCjy+yyOP9VweFEk5CzF0YlnEV5onuqtydDGcch6cahu90yqCPXWtjzJTWkmFzS
         qHg1kgval7nrYuH9eo2Y0fGOBADsAyjGg6+nD5W0wmwxMxG4iHCiIlerVltjY9LldqxP
         I8Xdam7zPoXY5eYvkzggIJZiFElv1mopydRcdJcB/O1xg9ln4pva/3Kp31YmsE/8b5wg
         rnJ4NK1O8hKOeTr9GvbBVtvmQkD0UAShBvvbaFs0huDx0Ubyn1tybxHdRZBJs58FSHmP
         joEtJSNup20pYO9K3YXO8IMlD9dbLG5PG0EePGKmWR/EP048k9oH5TKVYaSJY2+yiYnX
         ymVg==
X-Forwarded-Encrypted: i=1; AJvYcCWgnUpE1ss2rn7GyIbR9KrkJM+V+niJXPDlR9RtP7ySEb341zlUaiwuuNH7pKoa3Ai+IF2o9OqljL54EagxgSfUBP+Xd0nJvRFXQCth
X-Gm-Message-State: AOJu0YzLFmEGyp2sRWui87L+h52TXxi2WvzeMQ45Ahure7qZ8zepLXuP
	4GLOU2H3v/xr0U5vfL3V8XzbI4X16yovMVhK++2tqQWWB+BXzooCRFWTruEYC5k=
X-Google-Smtp-Source: AGHT+IGHLCwp0hGqtqL1q8f5M6PmDSweCC+kXH8yPvsoAi0ErhWstRGT1kYEy1C5OxbQyy+l7RVM0w==
X-Received: by 2002:a05:6214:767:b0:6b5:4865:948e with SMTP id 6a1803df08f44-6b95a3a2195mr93587836d6.32.1721686103802;
        Mon, 22 Jul 2024 15:08:23 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cd040easm37577341cf.30.2024.07.22.15.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:08:23 -0700 (PDT)
Date: Mon, 22 Jul 2024 17:08:22 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>, 
	Jessica Clarke <jrtc27@jrtc27.com>, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 12/13] selftests: riscv: Fix vector tests
Message-ID: <20240722-86a2b1fa474d71c4dbc557c7@orel>
References: <20240719-xtheadvector-v5-0-4b485fc7d55f@rivosinc.com>
 <20240719-xtheadvector-v5-12-4b485fc7d55f@rivosinc.com>
 <20240722-0940cd64c0d8bb03f2427022@orel>
 <Zp7LxAWkDQMQhVLq@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp7LxAWkDQMQhVLq@ghost>

On Mon, Jul 22, 2024 at 02:14:44PM GMT, Charlie Jenkins wrote:
> On Mon, Jul 22, 2024 at 01:47:29PM -0500, Andrew Jones wrote:
> > On Fri, Jul 19, 2024 at 09:19:07AM GMT, Charlie Jenkins wrote:
> > > Overhaul the riscv vector tests to use kselftest_harness to help the
> > > test cases correctly report the results and decouple the individual test
> > > cases from each other. With this refactoring, only run the test cases is
> > > vector is reported and properly report the test case as skipped
> > > otherwise. The v_initval_nolibc test was previously not checking if
> > > vector was supported and used a function (malloc) which invalidates
> > > the state of the vector registers.
> > > 
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > ---
> > >  tools/testing/selftests/riscv/abi/ptrace           | Bin 0 -> 759368 bytes
> > >  tools/testing/selftests/riscv/vector/.gitignore    |   3 +-
> > >  tools/testing/selftests/riscv/vector/Makefile      |  17 +-
> > >  .../selftests/riscv/vector/v_exec_initval_nolibc.c |  84 +++++++
> > >  tools/testing/selftests/riscv/vector/v_helpers.c   |  56 +++++
> > >  tools/testing/selftests/riscv/vector/v_helpers.h   |   5 +
> > >  tools/testing/selftests/riscv/vector/v_initval.c   |  16 ++
> > >  .../selftests/riscv/vector/v_initval_nolibc.c      |  68 ------
> > >  .../testing/selftests/riscv/vector/vstate_prctl.c  | 266 ++++++++++++---------
> > >  9 files changed, 324 insertions(+), 191 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/riscv/abi/ptrace b/tools/testing/selftests/riscv/abi/ptrace
> > > new file mode 100755
> > > index 000000000000..2b03e77b4dcf
> > > Binary files /dev/null and b/tools/testing/selftests/riscv/abi/ptrace differ
> > > diff --git a/tools/testing/selftests/riscv/vector/.gitignore b/tools/testing/selftests/riscv/vector/.gitignore
> > > index 9ae7964491d5..7d9c87cd0649 100644
> > > --- a/tools/testing/selftests/riscv/vector/.gitignore
> > > +++ b/tools/testing/selftests/riscv/vector/.gitignore
> > > @@ -1,3 +1,4 @@
> > >  vstate_exec_nolibc
> > >  vstate_prctl
> > > -v_initval_nolibc
> > > +v_initval
> > > +v_exec_initval_nolibc
> > > diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testing/selftests/riscv/vector/Makefile
> > > index bfff0ff4f3be..995746359477 100644
> > > --- a/tools/testing/selftests/riscv/vector/Makefile
> > > +++ b/tools/testing/selftests/riscv/vector/Makefile
> > > @@ -2,18 +2,27 @@
> > >  # Copyright (C) 2021 ARM Limited
> > >  # Originally tools/testing/arm64/abi/Makefile
> > >  
> > > -TEST_GEN_PROGS := vstate_prctl v_initval_nolibc
> > > -TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc
> > > +TEST_GEN_PROGS := v_initval vstate_prctl
> > > +TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc v_exec_initval_nolibc sys_hwprobe.o v_helpers.o
> > >  
> > >  include ../../lib.mk
> > >  
> > > -$(OUTPUT)/vstate_prctl: vstate_prctl.c ../hwprobe/sys_hwprobe.S
> > > +$(OUTPUT)/sys_hwprobe.o: ../hwprobe/sys_hwprobe.S
> > > +	$(CC) -static -c -o$@ $(CFLAGS) $^
> > > +
> > > +$(OUTPUT)/v_helpers.o: v_helpers.c
> > > +	$(CC) -static -c -o$@ $(CFLAGS) $^
> > > +
> > > +$(OUTPUT)/vstate_prctl: vstate_prctl.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
> > >  	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> > >  
> > >  $(OUTPUT)/vstate_exec_nolibc: vstate_exec_nolibc.c
> > >  	$(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
> > >  		-Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
> > >  
> > > -$(OUTPUT)/v_initval_nolibc: v_initval_nolibc.c
> > > +$(OUTPUT)/v_initval: v_initval.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
> > > +	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> > > +
> > > +$(OUTPUT)/v_exec_initval_nolibc: v_exec_initval_nolibc.c
> > >  	$(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
> > >  		-Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
> > > diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> > > new file mode 100644
> > > index 000000000000..74b13806baf0
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
> > > @@ -0,0 +1,84 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Get values of vector registers as soon as the program starts to test if
> > > + * is properly cleaning the values before starting a new program. Vector
> > > + * registers are caller saved, so no function calls may happen before reading
> > > + * the values. To further ensure consistency, this file is compiled without
> > > + * libc and without auto-vectorization.
> > > + *
> > > + * To be "clean" all values must be either all ones or all zeroes.
> > > + */
> > > +
> > > +#define __stringify_1(x...)	#x
> > > +#define __stringify(x...)	__stringify_1(x)
> > > +
> > > +int main(int argc, char **argv)
> > > +{
> > > +	char prev_value = 0, value;
> > > +	unsigned long vl;
> > > +	int first = 1;
> > > +
> > > +	asm volatile (
> > > +		".option push\n\t"
> > > +		".option arch, +v\n\t"
> > > +		"vsetvli	%[vl], x0, e8, m1, ta, ma\n\t"
> > > +		".option pop\n\t"
> > > +		: [vl] "=r" (vl)
> > > +	);
> > > +
> > > +#define CHECK_VECTOR_REGISTER(register) ({					\
> > > +	for (int i = 0; i < vl; i++) {						\
> > > +		asm volatile (							\
> > > +			".option push\n\t"					\
> > > +			".option arch, +v\n\t"					\
> > > +			"vmv.x.s %0, " __stringify(register) "\n\t"		\
> > > +			"vsrl.vi " __stringify(register) ", " __stringify(register) ", 8\n\t" \
> > > +			".option pop\n\t"					\
> > > +			: "=r" (value));					\
> > > +		if (first) {							\
> > > +			first = 0;						\
> > > +		} else if (value != prev_value || !(value == 0x00 || value == 0xff)) { \
> > > +			printf("Register " __stringify(register) " values not clean! value: %u\n", value);	\
> > > +			exit(-1);						\
> > 
> > I think we should ensure all tests in tools/testing/selftests/riscv/ use
> > TAP output, exiting with ksft_finished(), or at least exit with 0 for
> > success. For example, vstate_exec_nolibc exits with 2 for success since
> > it exits with the return value of prctl(PR_RISCV_V_GET_CONTROL). And
> > vstate_prctl.c exits with several different negative values, which means
> > it'll exit with several different values around 255. To figure what went
> > wrong, one will have to convert those exit codes to the original negative
> > values in order to look them up. Having these types of inconsistent exit
> > values complicates QA.
> > 
> > Thanks,
> > drew
> 
> I do not follow. I am using the kselftest_harness
> (tools/testing/selftests/kselftest_harness.h) that does output using the
> TAP format. vstate_exec_nolibc is not a test in itself but is a helper.

Ah, this was my misunderstanding, as I'm used to all files with main()
being independent tests and I only grepped exit codes. I'll have to look
to see how this all fits together.

> The Makefile for the vector tests describes this as:
> 
> TEST_GEN_PROGS := v_initval vstate_prctl
> 
> If you run the riscv collection of tests with:
> 
> $ ./run_kselftest.sh --collection riscv

I'll look later, but I hope those tests can also be run standalone and
still get TAP output.

Thanks,
drew

> 
> You will see that the only vector test cases are v_initval and
> vstate_prctl, which both output as expected in TAP format.
> 
> I do see that I messed up the return type of the is_vector_supported()
> function, I had meant to change that to a bool from an int since
> RISCV_HWPROBE_EXT_ZVE32X is greater than 32 bits. I will send a new
> version.
> 
> - Charlie
> 

