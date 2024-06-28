Return-Path: <linux-kernel+bounces-233475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C904A91B77B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6503C1F22852
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86445337C;
	Fri, 28 Jun 2024 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pNnAviyq"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810DE125AC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558183; cv=none; b=M3bp+fNpRJbNylkIXuYZp9RO2TRlvxcp1eutMbeX1GOS3RLEOb5Syq0Y0zUKDBv+M59MFvaRydKkngxunDUs1IVlFRCpY9ZnVzEPyx01FnuUN5jstYurcaggfGkdq4gf5h+B1bCZD8yfjJRkonMglnCt4R2qIh1EsxTSqBUyFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558183; c=relaxed/simple;
	bh=6wK9jajmiCwtkMGJMfiVWu+OKcV6ibcE2YlazNvpDRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C/WzxkmVFDm0YEK8Jml+7PJNnC/toYMPqzq3Dzr9Ha6E107TO+iCgrwQ6Pi0uPW5g0gEDdfD246jEdmfa9v7Cr4LG8/UXoSLSfImRd7LvVgKd5e0VuIXLKkzsv2+F8m8K5JXw5+PNIROaZHksZC76u/nVo6t+nR6V53d2ghSF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=pNnAviyq; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1719558171;
	bh=yKAZtPM5GEr7CZjyMumaDPYIdeEdVpmcv/sFYuGOa9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pNnAviyq9uqhUftQyMYSIpMi22zRA/e2RLe2mk9dsbBulBptFighU+2xzZhq57gN4
	 W8OHDxJFhAozwDw9+r+KGMRvHmaBzqQ5wv/saWrhEZrSMY7vNOHytT29zPfM17nKsA
	 j/wF2y89PcCRCzBZeMvVvi6ofDNLtmKxmpFR9QR1yxuxnDNHXBIB2UU8+KumhVa1MG
	 zHu8Ww8Fm1TIpYRBTNoBEuHRTYf6MHs+VZveXwM/fsmdMgoL94c5+Wcqn6K3Mm/Zme
	 DRx6CypwoAKrLlnVrNXssY7rU/lzEcYngKoMJ7sauDbdNypraPrNybVkum3rD7EQtb
	 KXBRZe+7BCJXg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9RGK5Rg0z4w2N;
	Fri, 28 Jun 2024 17:02:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jialong Yang <jialong.yang@shingroup.cn>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: luming.yu@shingroup.cn, shenghui.qu@shingroup.cn, Jialong Yang
 <jialong.yang@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Karol Herbst <karolherbst@gmail.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v1 1/2] powerpc/mmiotrace: Add MMIO Tracing tool for
 PowerPC
In-Reply-To: <2bf90acf7d29641ba6643934ff8dbba897dbd2d9.1718873074.git.jialong.yang@shingroup.cn>
References: <2bf90acf7d29641ba6643934ff8dbba897dbd2d9.1718873074.git.jialong.yang@shingroup.cn>
Date: Fri, 28 Jun 2024 17:02:48 +1000
Message-ID: <87h6ddlfc7.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jialong Yang <jialong.yang@shingroup.cn> writes:
> mmiotrace is a useful tool to trace MMIO accesses. Nowadays, it only
> supported on x86 and x86_64 platforms.

I've never used mmiotrace, and don't know it well.

I'm not necessarily opposed to merging it, but AFAIK it was mostly used
for reverse engineering proprietary drivers, where the driver itself
couldn't be easily instrumented. Is that what you're using it for?

For drivers where we have the source wouldn't it be easier to just use
tracepoints in the MMIO accessors?

Is it still in-use/maintained on the x86 side?

> Here is a support for powerpc.
> The manual is located at Documentation/trace/mmiotrace.rst which means
> I have not changed user API. People will be easy to use it.
> Almost all files are copied from x86/mm, there are only some
> differences from hardware and architectures software.
>
> LINK: https://lore.kernel.org/lkml/20080127195536.50809974@daedalus.pq.iki.fi/
>
> Signed-off-by: Jialong Yang <jialong.yang@shingroup.cn>
> ---
>  arch/powerpc/Kconfig.debug       |   3 +
>  arch/powerpc/mm/Makefile         |   1 +
>  arch/powerpc/mm/kmmio.c          | 649 +++++++++++++++++++++++++++++++
>  arch/powerpc/mm/mmio-mod.c       | 414 ++++++++++++++++++++
>  arch/powerpc/mm/mmiotrace_arch.c | 149 +++++++
>  arch/powerpc/mm/mmiotrace_arch.h |  25 ++
>  arch/powerpc/mm/pf_in.c          | 185 +++++++++
>  arch/powerpc/mm/pf_in.h          |  33 ++
>  8 files changed, 1459 insertions(+)
  
At a glance most of that code could be shared between arches. I don't
think I can merge that as-is, without some attempt to split the generic
parts out.

cheers

