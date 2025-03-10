Return-Path: <linux-kernel+bounces-554939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A43BA5A3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A377C3A6D68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D278B236426;
	Mon, 10 Mar 2025 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZE1OGlx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020B2AD16
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741633715; cv=none; b=Gr4BcAuXHCF+h1/sarJVBTnvbYw++8mneb+aYBpxBZeEeunbigOSnKX8JLOX7blZMwLsgdDgzt/aixeQa34cPn0FzFFr43Qo02BhTxVqEb4MElvc88Oj4F1IrGLrnyCKi1Rij/cqRm/7fj3vPVl6gxetk06tt0pL5xTUZ82vKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741633715; c=relaxed/simple;
	bh=GqmO+njjlVZaD53TkAjsULATLMQpxKPpyMnJa0HozUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LiL09NkuX8Rc4cZDKhnIc1EGoMurbdKlbxnPLGPI0LG/A1eyT6dgZhkZbLveu6WE6OIOaPZZkmXtYKXSo7kEVpJXa4cJ6Ft3xNO+1aUB5i4R3lWNaM+ZoMpyehd81cmNC4iRexrFyFxHfYpSNuzkcVjnJHgbnfiIUNpXTfiOuPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZE1OGlx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CD0C4CEE5;
	Mon, 10 Mar 2025 19:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741633714;
	bh=GqmO+njjlVZaD53TkAjsULATLMQpxKPpyMnJa0HozUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VZE1OGlxbVyHaKZEYerhJqaBrWHZIVVvrjv/y3wXC88U3VbdOtZn69yDwqPKl7lli
	 8mo1IPVUa07rdI5o1mvhDYkYZVKr0Ip++7TPOsT5/HkgQRdZ1XQImlSy3mq7H1X3PH
	 pUlm7iIDz5Dhckyz8QJdpXy3oufTO+PhTLtJeyooXQOjnMu+KDbR4Q37xPyjACmRvd
	 tTCh6TvQ3pafHivknrHy7LUqAvjwv52mI0mKby8BN6pWjDn6vR9CzF9piRYtDyBwdM
	 yfekuSTnCiU03ceywhF3/UoolrvLhxpZGTcmr4NONkInh2Z6Ai2v4t3o2m8JB7V3Ch
	 wY/v6SQs7a3cQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andybnac@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>
Cc: Andy Chiu <andybnac@gmail.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bjorn@rivosinc.com, puranjay12@gmail.com,
 alexghiti@rivosinc.com, yongxuan.wang@sifive.com, greentime.hu@sifive.com,
 nick.hu@sifive.com, nylon.chen@sifive.com, tommy.wu@sifive.com,
 eric.lin@sifive.com, viccent.chen@sifive.com, zong.li@sifive.com,
 samuel.holland@sifive.com
Subject: Re: [PATCH v3 6/7] riscv: add a data fence for CMODX in the kernel
 mode
In-Reply-To: <20241127172908.17149-7-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-7-andybnac@gmail.com>
Date: Mon, 10 Mar 2025 20:08:31 +0100
Message-ID: <87ldtck8k0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Chiu <andybnac@gmail.com> writes:

> RISC-V spec explicitly calls out that a local fence.i is not enough for
> the code modification to be visble from a remote hart. In fact, it
> states:
>
> To make a store to instruction memory visible to all RISC-V harts, the
> writing hart also has to execute a data FENCE before requesting that all
> remote RISC-V harts execute a FENCE.I.
>
> Thus, add a fence here to order data writes before making the IPI.
>
> Signed-off-by: Andy Chiu <andybnac@gmail.com>
> ---
>  arch/riscv/mm/cacheflush.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index b81672729887..b2e4b81763f8 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -24,7 +24,20 @@ void flush_icache_all(void)
>=20=20
>  	if (num_online_cpus() < 2)
>  		return;
> -	else if (riscv_use_sbi_for_rfence())
> +
> +	/*
> +	 * Make sure all previous writes to the D$ are ordered before making
> +	 * the IPI. The RISC-V spec states that a hart must execute a data fence
> +	 * before triggering a remote fence.i in order to make the modification
> +	 * visable for remote harts.
> +	 *
> +	 * IPIs on RISC-V are triggered by MMIO writes to either CLINT or
> +	 * S-IMSIC, so the fence ensures previous data writes "happen before"
> +	 * the MMIO.
> +	 */
> +	RISCV_FENCE(w, o);

(I love the submit/review latency here! ;-))

FWIW, the for S-IMSIC the write is already writel(), so we'll have the
text patching and IPI ordered. Regardless, there's more than one flavor
of IPI on RISC-V!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

> +	if (riscv_use_sbi_for_rfence())
>  		sbi_remote_fence_i(NULL);
>  	else
>  		on_each_cpu(ipi_remote_fence_i, NULL, 1);
> --=20
> 2.39.3 (Apple Git-145)

