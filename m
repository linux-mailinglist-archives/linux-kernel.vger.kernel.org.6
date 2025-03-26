Return-Path: <linux-kernel+bounces-577632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBDEA71FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAD21899A15
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06A24C676;
	Wed, 26 Mar 2025 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZ7ATmg1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE9E1DD539
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018898; cv=none; b=P5BGwPYMDyO325a1ldpUP+dEfTuwr7Rt3kHIHCsOao4sr3qoLv4lOaNLG4+X5OsRHchQlhU2pOS+DWFdoMRzsD3Bztq0mq/KQYldyc1VOMdRcUf1SJd0kaDGuO1DEUoqVyr2d/vGcAFstctqdWuFMnt51qlQi9VUIvszko6pAJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018898; c=relaxed/simple;
	bh=nJdi+8s1W+HMSPaTDyc5/leo0zsB9OTHXjIF969gMCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hIjCgwOiOcKzb9MMDCxh3i0kZjLf/TP8M9mTOhEvnBuPorvNeBC5wwpAvh0omedyip15fWqnwNbbWwdFICw1nshqcA1WDQ+sXDsgIYTSWRvhA5ddQ8wdD7s2s90INwnFOIz/N3YrKqQ5MlSrRv6ZWcXnfnSeMpZhn4I9086Bdw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZ7ATmg1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EBAC4CEE9;
	Wed, 26 Mar 2025 19:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743018897;
	bh=nJdi+8s1W+HMSPaTDyc5/leo0zsB9OTHXjIF969gMCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PZ7ATmg1MTJY8x0AB42UeFq2UfnmXvGnw1JeL3woN1O+dyTTvoQZJRpvL7Mmx6k4g
	 9DUqaQmjFCdsok+YC1sqc+3pUWs8lxH3gY6zJqpXc7OtNKRHausY+EKyQwftkgEA+6
	 Uxyn7VaVTjR4Fc8t1c3MRcceTXM74iEn6fb9hEzC431vtOoqrvd1Uo15iIilOEl0Xt
	 NRM8aP99dWiogqt6gid3He65o8XFBOldC6O3fyvNVlxfF6f/T9pre2Z3p2Ojk9en5Z
	 lwo14PbhT19hp+sz8y3Xdl6OibVlXb60BRoVlW1wISccuVivkiRr0D8sgxSwOsHPnL
	 DMHvOiXpdnBsQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Yao Zi <ziyao@disroot.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Petr Tesarik <petr@tesarici.cz>, Ying Sun <sunying@isrc.iscas.ac.cn>,
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Han Gao
 <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH] riscv/kexec_file: Handle R_RISCV_64 in purgatory relocator
In-Reply-To: <877c4bg1us.fsf@all.your.base.are.belong.to.us>
References: <20250326051445.55131-2-ziyao@disroot.org>
 <877c4bg1us.fsf@all.your.base.are.belong.to.us>
Date: Wed, 26 Mar 2025 20:54:54 +0100
Message-ID: <87y0wrk1o1.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Yao Zi <ziyao@disroot.org> writes:
>
>> Commit 58ff537109ac ("riscv: Omit optimized string routines when
>> using KASAN") introduced calls to EXPORT_SYMBOL() in assembly string
>> routines, which result in R_RISCV_64 relocations against
>> .export_symbol section. As these rountines are reused by RISC-V
>> purgatory and our relocator doesn't recognize these relocations, this
>> fails kexec-file-load with dmesg like
>>
>> 	[   11.344251] kexec_image: Unknown rela relocation: 2
>> 	[   11.345972] kexec_image: Error loading purgatory ret=3D-8
>>
>> Let's support R_RISCV_64 relocation to fix kexec on 64-bit RISC-V.
>> 32-bit variant isn't covered since KEXEC_FILE and KEXEC_PURGATORY isn't
>> available.
>
> Hi!
>
> This patch does fix the vmlinux loading for kexec-file -- very nice!
> However, I haven't been able to get kexec to successfully boot a kernel
> from qemu, i.e.:
>
>   kexec -s -l /path/to/vmlinux # fixed w/ your patch
>   kexec -e # hangs after "Bye..."
>
> Same when I try vanilla kexec (kexec -c -l /path/to/vmlinux). kexec with
> an Image works for me in qemu.
>
> Before I start to bisect too much; What config/qemu did you use to test
> this?

Nevermind! Got it to work; Sorry for the noise.

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

