Return-Path: <linux-kernel+bounces-418929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901189D6758
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 04:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B04FEB21C06
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 03:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540512AE90;
	Sat, 23 Nov 2024 03:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="CyDCe5Sk"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44498800
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 03:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732330889; cv=none; b=la5taIYUGJ7e5XEmFXdB1lc8a2KVYzI0S3oSG82Wu0JBFpqai5jmogBlMrwxZkrrg+zg66QyV2CZlYkGytkyczDfGqkXaX6FB6MjxNvPLSMRg8m0/m6A8AqyYKDwwtRHCe9HdsrqSDdjIZKw46A0jgvw+aLz9SX6oEtGOwSKOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732330889; c=relaxed/simple;
	bh=xmf/pB8Fle7JNevkDE4mxBCzTeF7nVLdcwwlB25iz/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YMIfmpS4AW3+o1zYfAE7R6OWQ2Odp3agGPUTsqm1h0qMGG+KKOc4T9PpG/rLu7VA8bsZiZS/UWkBuEsOOeNqUTaqK5HsvHjJ+8KvYMsjmxxV1nzVKrmpAq80oEKSoHsuyfoIB6tGllq2SMfgUIznWLE8msxhPKGAmaC97p+ycwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=CyDCe5Sk; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1732330876;
	bh=xmf/pB8Fle7JNevkDE4mxBCzTeF7nVLdcwwlB25iz/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CyDCe5Skr1mmCIYEMYoLjSqCO2bD8/v+uEtWYHAFi2zk0D6BvxvGqTwSNGW6U9Hj2
	 WeCm+pf/Fpx/zwvEMc3m5XZz/rDCBeUrwO6hWXJ0Ja2VISDrqjQTzw5Kz3dxiCmuK0
	 i6DhPpf1Ns8/RqJKTfnN5bnYJuyNBRCSzWW+xAkOkiF526AzoeKV3HmTXPfOvBWrzO
	 HhxWom2nNH+WqjLKDf45yUf1mpMfrsqvHLGx6wUwtoBzEkJ1DGILDsDurhSZVlGseS
	 RZoSEsgq5O9FgDaXK7jFwhNvFJnTNAMuUQrlk+j4js66A9ADLjVCnQCmOi8HJwB6GG
	 Ms70vkt2RIwcg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XwGvJ023xz4wcr;
	Sat, 23 Nov 2024 14:01:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Transliterate author name and remove FIXME
In-Reply-To: <55B1EE24-BEC9-4A8D-84B0-ED32FCC070A5@linux.dev>
References: <20241110162139.5179-2-thorsten.blum@linux.dev>
 <87v7wuy3p5.fsf@mpe.ellerman.id.au>
 <55B1EE24-BEC9-4A8D-84B0-ED32FCC070A5@linux.dev>
Date: Sat, 23 Nov 2024 14:01:04 +1100
Message-ID: <87v7weodqn.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thorsten Blum <thorsten.blum@linux.dev> writes:
> On 11. Nov 2024, at 02:11, Michael Ellerman wrote:
>> Thorsten Blum <thorsten.blum@linux.dev> writes:
>>> The name is Mimi Phuong-Thao Vo.
>>=20
>> Is that the correct spelling?
>>=20
>> The github commit below suggests it's Mimi Ph=C3=BB=C3=B4ng-Th=C3=A5o V=
=C3=B5.
>>=20
>> And presumably the author preferred that spelling, otherwise they would
>> have just written it in ASCII in the first place.
>>=20
>> https://github.com/bminor/binutils-gdb/commit/6603bf38d74409906b3814f6a2=
6c0483a5d32e41
>
> Hi Michael,
>
> Are you suggesting to keep "Mimi Ph\373\364ng-Th\345o V\365" and a FIXME
> instead of changing it to "Mimi Phuong-Thao Vo" which is how she spells
> her name on her LinkedIn profile and other websites?

No I'm not suggesting to leave it as-is.

But I also suspect they spell it that way on LinkedIn etc. because it's
the path of least resistance, not because it's the correct spelling.

I was hoping someone who's more familiar with Vietnamese (I believe)
spelling would chime in and tell us which is correct.

> I doubt anyone prefers their name to be spelled with octal escape
> characters.
=20
Sure, but it wouldn't have been octal escapes in the original character
encoding, it would have appeared, I believe, as Mimi Ph=C3=BB=C3=B4ng-Th=C3=
=A5o V=C3=B5.

cheers

