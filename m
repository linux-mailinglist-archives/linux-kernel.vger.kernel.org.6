Return-Path: <linux-kernel+bounces-318822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1662A96F3BD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965F0B26406
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC01CC89C;
	Fri,  6 Sep 2024 11:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lsJQzI64"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50681CBE9A
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623733; cv=none; b=XXRqeliXbIKjzWgLj++GPaYdUy84ics6DbzBVlSPlzB3tAQ2TjwYEMYXDh+9dsZaKKMzNwppdsJpUtNv/54541UemEZgdfDAgIzIJ4osGJ8lD5N7yukzbMoYs/iqNC90bfevtmwb2nS9aKKu5F0jej/vZSBHaL/szmJnxgTirw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623733; c=relaxed/simple;
	bh=WKUq6YmPnB7VoX1iFUIiMFkuw4y2hoGfJFLPv5dBGdU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bcUGdT2K93WdgmsyamWI0pQnGpGL+vRcaiEJkMArAK3OAk/R+WvfXYg3pKtvP3DYuJ5K6mtdzayY+mS5cYQ3paaGKef8bkzGzv3Xyr/Yu9riUvuR0KN/VdqAzb1Zz5a5TLCZXMPjZ86gC2/Su/wFFSABGOLGUS/j9StnvxjB8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=lsJQzI64; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725623730;
	bh=pESwynHQSNkY0aLaokNxE0tjc/kRDrUjm1a7r50uJDE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lsJQzI64a+H9g6i/EQmj2dWh4rPPA6DWdjn+b82AcCcduHinyhntIsN52GXMPnXCV
	 ZUX1fgO1Bb8VOlq866KLu74P1SSPuvh+7/cazg7iCwJFdMkvvMKZN9U+li5OWn6wl7
	 nTLD7jn+ee2LG2RQ2uIgRVmrfH5ySUNON2AApehBOyC4NirXdwb2Gs+SuKPmL+6/Nj
	 GY9INNsr2i/dW3fQv7P8MFZNUBfYUU9QHfxgNO83B0QjRo7F5FVH1d43hTFRo0O9uf
	 /KmIkURjqyczGrRUTRJeY/z8GxrhkszXWcY1ePzr27Bsb9YuT5ZmrgWgUuzKgkPkb/
	 N5y4c1GVrLAvA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X0ZRj6wzlz4wxx;
	Fri,  6 Sep 2024 21:55:29 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 00/14] Reduce alignment constraint on STRICT_KERNEL_RWX and speed-up TLB misses on 8xx and 603
Message-Id: <172562357202.467568.4096138067751916114.b4-ty@ellerman.id.au>
Date: Fri, 06 Sep 2024 21:52:52 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 19:23:44 +0200, Christophe Leroy wrote:
> This series does mainly two things:
> - Remove the 8M alignment constraint on STRICT_KERNEL_RWX on 8xx to
> avoid wasting memory.
> - Speed-up TLB misses by duplicating kernel PGD entries into each
> task's PGDIRs to avoid the address comparison in TLB miss handler.
> 
> On 8xx, the address comparison takes a significant part of CPU cycles
> as it requires saving/restoring CR, and because a taken branch
> requires 2 cycles.
> On 603 it is less significant because CR is saved automatically and
> has to be restored anyway but it is still worth it.
> 
> [...]

Applied to powerpc/next.

[01/14] powerpc/8xx: Fix initial memory mapping
        https://git.kernel.org/powerpc/c/f9f2bff64c2f0dbee57be3d8c2741357ad3d05e6
[02/14] powerpc/8xx: Fix kernel vs user address comparison
        https://git.kernel.org/powerpc/c/65a82e117ffeeab0baf6f871a1cab11a28ace183
[03/14] powerpc/8xx: Copy kernel PGD entries into all PGDIRs
        https://git.kernel.org/powerpc/c/985db026c34dfc45213649023d5505822a5dcd78
[04/14] Revert "powerpc/8xx: Always pin kernel text TLB"
        https://git.kernel.org/powerpc/c/1a736d98c84acd38e40fff69528ce7aaa55dd22d
[05/14] powerpc/8xx: Allow setting DATA alignment even with STRICT_KERNEL_RWX
        https://git.kernel.org/powerpc/c/bcf77a70c4ffc9b01044229de87f5b6f9c1f7913
[06/14] powerpc/8xx: Reduce default size of module/execmem area
        https://git.kernel.org/powerpc/c/c5eec4df25c34f4bee8c757ed157f5d96eaba554
[07/14] powerpc/8xx: Preallocate execmem page tables
        https://git.kernel.org/powerpc/c/16a71c045186a11c1c743934e330de78162b86dd
[08/14] powerpc/8xx: Inconditionally use task PGDIR in ITLB misses
        https://git.kernel.org/powerpc/c/33c527522f394f63cc589a6f7af990b2232444c8
[09/14] powerpc/8xx: Inconditionally use task PGDIR in DTLB misses
        https://git.kernel.org/powerpc/c/ac9f97ff8b324905d457f2694490c63b9deccbc6
[10/14] powerpc/32s: Reduce default size of module/execmem area
        https://git.kernel.org/powerpc/c/2f2b9a3adc66e978a1248ffb38df8477e8e97c57
[11/14] powerpc/603: Copy kernel PGD entries into all PGDIRs and preallocate execmem page tables
        https://git.kernel.org/powerpc/c/82ef440f9a38a1fd7f4854397633a35af33840a5
[12/14] powerpc/603: Switch r0 and r3 in TLB miss handlers
        https://git.kernel.org/powerpc/c/31c0e137ec609f36877ea39cd343ef2476d080aa
[13/14] powerpc/603: Inconditionally use task PGDIR in ITLB misses
        https://git.kernel.org/powerpc/c/3f57d90c231d3329aaed7079dd05b5a2f7692a58
[14/14] powerpc/603: Inconditionally use task PGDIR in DTLB misses
        https://git.kernel.org/powerpc/c/062e825a336017c0334c7497690826c95aa1a84f

cheers

