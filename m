Return-Path: <linux-kernel+bounces-170813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9188BDC5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A652D2826EF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9DF13B790;
	Tue,  7 May 2024 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY5iYGis"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D13D0BD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066712; cv=none; b=lnbkLkEwwkYUxiyDc7ThKJEpWRdB+zV/gQCXpEJt6jg9+aj3eb2XOR3/9sCLgcdiAjSfYJJt6lH1DLJ88FgqtyDPS1aTCnYNl26DWLJnm6eMmOGVhXKFBxd2g0FbbVHdnb96xAw/ChV8XfqC0TQPgFjcDZAD/NATYkiIkn/WxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066712; c=relaxed/simple;
	bh=Gs3j7oXYZ/cnYw3Tvuveo6X7cpNx8lLk7xv/YA5SssY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WGxy+ttZpIp6IitnESSkCEsBEjIv1q0qmv+hcpP6ovz2H1v2JRINV7uqPlnMg8jufFuHfAfh2kOf0VCFxty08J0xx2V9LlK+Tg2+bGiAMnCj6w5a0xmRg980uRifwmK/HMrJpGWGDoEb943KKrNQ0T7i3mqMHlzUnK6GjHdgV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY5iYGis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28A5C2BBFC;
	Tue,  7 May 2024 07:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715066711;
	bh=Gs3j7oXYZ/cnYw3Tvuveo6X7cpNx8lLk7xv/YA5SssY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FY5iYGishy4InMmdRopsf1fysYX4wjmy+Af5T4ogIpLQyIQhMSTNdQF1ns6VjyAwO
	 5uF6LQMYTKXg1CipA+pKvbo7oCz0jKGsff1lialhFUkztmWTNNEFDv9agnmXEDOLWZ
	 YelITmVmKQdp94GinpG7y1q92sxn2h93lJ4i+xSvEBQ2Nh3ZcqIqir2GS9Yg8DQEHj
	 8KbzWOOlyYaZ7+tG4TKiRoIa6dy/1Z/2Kl5KlNsk1VDhyBqK47ZOCyMiCZaOkNNQxX
	 K3qypsB4GiaM/G/vUagj3i5zjMkUyEApm4xkQL3YDZOZKwrWU0ajgbiS2YPmch9w1p
	 WaLXxbT6PRu1w==
Date: Tue, 07 May 2024 08:25:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor.dooley@microchip.com>, Song Liu <song@kernel.org>,
 Xi Wang <xi.wang@gmail.com>,
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
 =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
CC: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] riscv: Support compiling the kernel with extensions
User-Agent: K-9 Mail for Android
In-Reply-To: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
References: <20240506-compile_kernel_with_extensions-v1-0-5c25c134c097@rivosinc.com>
Message-ID: <12808AB2-0308-4013-9624-E3DEFCC584EA@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Charlie,

On 7 May 2024 02:40:41 IST, Charlie Jenkins <charlie@rivosinc=2Ecom> wrote=
:
>The kernel currently has the restriction that it can only be compiled
>with the extensions that are hardcoded in arch/risc/Makefile=2E
>
>Any extension that is not listed in the Makefile can still be used by
>explicitly writing the assembly and using alternative patching=2E
>
>This series introduces Kconfig options that allow the kernel to be
>compiled with additional extensions=2E

One thing I don't see in the commit messages or the cover letter is what y=
our actual motivation is
for making these changes=2E
Are you effectively looking to evaluate the alternatives at build time, or=
 are you looking to
let the compiler use the extension where it sees
fit? Or perhaps both?

Thanks,
Conor=2E

>
>Signed-off-by: Charlie Jenkins <charlie@rivosinc=2Ecom>
>---
>Charlie Jenkins (8):
>      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_C Kconfig option
>      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_V Kconfig option
>      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_SVNAPOT Kconfig option
>      riscv: Add PLATFORM_MAY_SUPPORT_RISCV_ISA_SVPBMT Kconfig option
>      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBB Kconfig option
>      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBA Kconfig option
>      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBC Kconfig option
>      riscv: Add PLATFORM_SUPPORTS_RISCV_ISA_ZBS Kconfig option
>
> arch/riscv/Kconfig                    | 135 +-----------
> arch/riscv/Kconfig=2Eisa                | 393 ++++++++++++++++++++++++++=
++++++++
> arch/riscv/Makefile                   |  15 +-
> arch/riscv/crypto/Kconfig             |  14 +-
> arch/riscv/include/asm/arch_hweight=2Eh |  33 +--
> arch/riscv/include/asm/checksum=2Eh     |  18 +-
> arch/riscv/include/asm/pgtable=2Eh      |   3 +-
> arch/riscv/include/asm/simd=2Eh         |   3 +
> arch/riscv/include/asm/vector=2Eh       |   3 +-
> arch/riscv/kernel/cpufeature=2Ec        |   3 +-
> arch/riscv/kernel/head=2ES              |   8 +-
> arch/riscv/kernel/probes/uprobes=2Ec    |   2 +-
> arch/riscv/kernel/process=2Ec           |  14 +-
> arch/riscv/kernel/ptrace=2Ec            |   6 +
> arch/riscv/lib/csum=2Ec                 |  48 ++---
> arch/riscv/lib/riscv_v_helpers=2Ec      |   1 -
> arch/riscv/lib/strcmp=2ES               |   4 +-
> arch/riscv/lib/strlen=2ES               |   4 +-
> arch/riscv/lib/strncmp=2ES              |   4 +-
> arch/riscv/lib/uaccess_vector=2ES       |   2 +
> arch/riscv/lib/xor=2ES                  |   2 +
> arch/riscv/net/bpf_jit=2Eh              |   8 +-
> 22 files changed, 511 insertions(+), 212 deletions(-)
>---
>base-commit: 2f47357557b7aa98d9d9002688aae480864ca3f6
>change-id: 20240429-compile_kernel_with_extensions-92dd2403d325

