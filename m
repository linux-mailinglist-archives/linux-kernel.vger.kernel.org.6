Return-Path: <linux-kernel+bounces-302754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62CA9602D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082671C2196D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 07:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF8019DF97;
	Tue, 27 Aug 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XXXqxn8i"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCA19D894
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742924; cv=none; b=Luolzdx1hL3tSvChYuUEDhOTPtGhb0/hS0mn5yezJ6fSZGbAT1tr2ehRNpPAO7TRHyZqe/84ofl/DkV+jQ0zl78N2GVGR3cmlw+9MhSxyi4X9x6D0uVigcsuQ/2kcWCvjm9njh72Zz+1MkisPloXxTLzsr/Z8OSuVlsfq57Urn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742924; c=relaxed/simple;
	bh=RnbBCoJEDlyJofMmfRRYgxw9AmKlOvDJ7MmNg6PdKbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gQs39cNa1vJ54lo7MwwT8HZ0WbHCKAzVYieXaSF1o4hNhziFta3vyWpaACqK6rLKxt0povGsCJroCFQHq0TmhgzpXR8Pb/kMXA+gtm0ZGAOJrLyDE6895NJMv4XtBfPGPFvzIw02ExOUb+srAcwQE2asouX76vMwIOrrq4PktJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=XXXqxn8i; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1724742920;
	bh=8nSPQsJamaWd7LPmLTr+2JTlH1Cx/OAs4xpRwlVAdnE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XXXqxn8iBVpZChuOOiZCSsDd/5f9Ci6MumL+bvFpHlqfMjl8xl2ic/eEjYzntx5HL
	 bZ+31/r/NIawnN9W9leghNP25f+GNOvQpw8vl1LuWIQpLojUHlAzWhw7RF3lShXj3j
	 nPP1fpJzIjULdcZzoLwvTMto1GRRpde5Zc8elLnWuwKuR6H+zcSu4Rf+MX0dVICp6d
	 AcdjolRht9zDhGKPH1laK4LBA0PlB5zHTLo6JcooP82le+OyoIGifjhYIbxJHXrfMj
	 U4QIVetOQ+U99aZ/fVCEAos6LTkFBkSsnTFlMGLzJ6DdLP1ZsRC/rdSJ2dLrn5RT6M
	 mxjPjdYKyZKpw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WtJj464Whz4x2M;
	Tue, 27 Aug 2024 17:15:20 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <45f8fdf298ec3df7573b66d21b03a5cda92e2cb1.1724313510.git.christophe.leroy@csgroup.eu>
References: <45f8fdf298ec3df7573b66d21b03a5cda92e2cb1.1724313510.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/mm: Fix return type of pgd_val()
Message-Id: <172474289344.32718.3015990756212968494.b4-ty@ellerman.id.au>
Date: Tue, 27 Aug 2024 17:14:53 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 09:58:42 +0200, Christophe Leroy wrote:
> Commit 6b0e82791bd0 ("powerpc/e500: switch to 64 bits PGD on 85xx
> (32 bits)") switched PGD entries to 64 bits, but pgd_val() returns
> an unsigned long which is 32 bits on PPC32. This is not a problem
> for regular PMD entries because the upper part is always NULL, but
> when PMD entries are leaf they contain 64 bits values, so pgd_val()
> must return an unsigned long long instead of an unsigned long.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/mm: Fix return type of pgd_val()
      https://git.kernel.org/powerpc/c/3b1f7a46977fe2ff9384d08651a6e0d272ae6a60

cheers

