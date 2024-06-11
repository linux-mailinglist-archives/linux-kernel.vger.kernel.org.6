Return-Path: <linux-kernel+bounces-210033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7C1903E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431371F22041
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15417D37F;
	Tue, 11 Jun 2024 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Wt+tDmjI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FC1DDF4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114757; cv=none; b=gJfV7fnAF0h0K9SfyPqekS80+AKJuGPggI8ZC0dZXl52XUOMVG6c8fbLja+gY/GVSpWPGmyU6r6xi7nM4wPcuFj8bzxyxV2pRxBKB5O3UU7hR442W4jsasJEPEvT7rDHnVaVKw9MSNDfjqX23Cia3bVqLJkIUh1rn+HhSrcKR5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114757; c=relaxed/simple;
	bh=fb9h/s1OdFP7eRPaSrSo2uGC1HXvmDGSTyWKkCdOi0E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Q9BuPKCBHB2+MVyaNurtgiOp9OgaiSnM2/JMooDL/gxqAZ7dKdGG1idr8E9fPNdmgaGtEqJCv/hmNxm6s81quEQH7VF9GxMbMzn+Q8F7ep5LceOApduAgHb+eVwLJU4raHHzMkO4aE2LQ8Js/+vD3Qrkmk42LWb0+3GP0rU4UwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Wt+tDmjI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 999EA40E0176;
	Tue, 11 Jun 2024 14:05:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Bh3dWK00moCE; Tue, 11 Jun 2024 14:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718114748; bh=H70qKEsyywdGIzZyFtIxa1Xk8eZnGnp/jCfVMLZyi+M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Wt+tDmjIyG6q3owvFDUPoVEa9ZbwTDyr1D2mpF1518ZWSZZwKRBrvsKVJqXd/VYZ8
	 kJOXKE6Rf2o4tkP0obr+nkETGmxwP6Npre5LVuuyxL9InE0UMp26SKOpO7i1QX0xwh
	 FNqXLVU+vvDhZ1qLqX4cvZ7mDEtzLza/icSMmIHn2eKhsNPG6C+rQlw5j9R5pMa74W
	 ojKSkzewEg3yYuOA9014cJLI3ZDa2vxY7SgUhTtmeXi9g2IityNt1ueAEPM0sxk1sX
	 nZOhLIaYDm8lAcRteCOnyWhVxjevHu+xT9Je9k8XaJCtrxwLcTejPI2xpCVGpfSlKg
	 0Eqh6wtUGzjkadoqRSaOZBS4Ql2OWImEomCqXKvwoqQqBHLL9Z9CgjcrrhLpc2MyFL
	 Ru2R/HC5TAskSXea1DQqzhU3c3hb4A1BXu8u+4sNY+haTVRKhK/deofj8/qpx32cEk
	 JAbC3dqYmutceJi9XZnxryiFthPz2qYLcjy2CLdbdeymbq1Cq8146Vx6VqWHSDz3rS
	 8gO1MlHic1aswffJk2gMmqB7D54Kz1OqzmOLiXMnO4ojHCFyYH5wYacV8nU1Rx8qBG
	 d5ju0zslFgnaeKcmDoZjiZNCinVFtpopsrIRIwO2Tu9IENot+BlFEEBbUuDpQ3S+ts
	 GITEAm9xcrLa0A6DtCh0kWDE=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3038:204:3eef:78c3:4ef6:d0a7:2ead])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB91240E0081;
	Tue, 11 Jun 2024 14:05:43 +0000 (UTC)
Date: Tue, 11 Jun 2024 16:05:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@kernel.org>
CC: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 00/14] x86/alternatives: Nest them
User-Agent: K-9 Mail for Android
In-Reply-To: <20240611132609.GH8774@noisy.programming.kicks-ass.net>
References: <20240607111701.8366-1-bp@kernel.org> <20240611132609.GH8774@noisy.programming.kicks-ass.net>
Message-ID: <7C4F08B2-70C1-4A63-B901-33D197A2BDC4@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 11, 2024 3:26:09 PM GMT+02:00, Peter Zijlstra <peterz@infradead=2Eo=
rg> wrote:
>On Fri, Jun 07, 2024 at 01:16:47PM +0200, Borislav Petkov wrote:
>
>> Borislav Petkov (AMD) (13):
>>   x86/alternative: Zap alternative_ternary()
>>   x86/alternative: Convert alternative()
>>   x86/alternative: Convert alternative_2()
>>   x86/alternative: Convert alternative_input()
>>   x86/alternative: Convert alternative_io()
>>   x86/alternative: Convert alternative_call()
>>   x86/alternative: Convert alternative_call_2()
>>   x86/alternative: Convert ALTERNATIVE_TERNARY()
>>   x86/alternative: Convert ALTERNATIVE_3()
>>   x86/alternative: Convert the asm ALTERNATIVE() macro
>>   x86/alternative: Convert the asm ALTERNATIVE_2() macro
>>   x86/alternative: Convert the asm ALTERNATIVE_3() macro
>>   x86/alternative: Replace the old macros
>>=20
>> Peter Zijlstra (1):
>>   x86/alternatives: Add nested alternatives macros
>>=20
>>  arch/x86/include/asm/alternative=2Eh | 225 +++++++++------------------=
--
>>  arch/x86/kernel/alternative=2Ec      |  20 ++-
>>  arch/x86/kernel/fpu/xstate=2Eh       |  14 +-
>>  tools/objtool/arch/x86/special=2Ec   |  23 +++
>>  tools/objtool/special=2Ec            |  16 +-
>>  5 files changed, 125 insertions(+), 173 deletions(-)
>
>The whole back and forth with the n_foo things ia weird, but sure, have
>at=2E
>
>Acked-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>

Thanks, yeah it is in the 0th mail:

"For ease of bisection, the old macros are converted to the new, nested
variants in a step-by-step manner so that in case an issue is
encountered during testing, one can pinpoint the place where it fails
easier=2E Because debugging alternatives is a serious pain=2E"

If you remember, your original patch had this issue where it would confuse=
 two back-to-back =2Ealtinstr entries for nested because you were comparing=
 only the offsets and they happened to be equal, by l

Now debugging *that* was insane and I managed to find the issue only when =
I started converting each place one-by-one and booting each one step=2E

That's why this superficial split is all about=2E We will appreciate it la=
ter=2E I hope not but if something explodes, bisection will be a lot easier=
 this way=2E

I hope this makes sense=2E


--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

