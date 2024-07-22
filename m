Return-Path: <linux-kernel+bounces-258454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC0C938816
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58731F21064
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 04:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485EF175B1;
	Mon, 22 Jul 2024 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="BtSGTRTN"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3E168DC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721622585; cv=none; b=W8U1dZLB31H3hLShJOQcnQZ46X3dnbIVESoY6WC9A/elERHX/of3q+1GwJocj7DwOmtBL6CqwMNxeL/38U3ixXvK6xuVBRw6NTH8IfuFoUfrTg7AXwMzugLc2wGwmFELwc/KU44qF2va96763JBmmZJvaDDezyrmfWMYkzFtlBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721622585; c=relaxed/simple;
	bh=EoHzIChC7xyVnZfjPK5dARKLEseBZeywgxs7JqrGwmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NFP/aL4gmrlraYngOc2qt76obT6yX6rKpnj9nJ+apdv2lq4ROYowfr92Kd8cR/Dwe3tUVExPV/zmFh5GO6gRRByyK69DAzMEq04h5RNWquUVWrrkfTjKw+0Pe2grW5QJ3ZKWThrKdy5cYg6JNbbdrIiXg1IPPTOO0zggm0bCF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=BtSGTRTN; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721622579;
	bh=b27yvvknE/8IwX1xIry3wFHnOu4KWb+IfGRGwKbTKBE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BtSGTRTN1ECYk+rjVCSvJIJUc3de4kAyJYHXDP3Y9P8RDNSSaJyFwrso76KW9FBRi
	 HftBVnUx/9iC8GWmLzfyy4UA+su44043XxAflUlBmlm1sb7slmjDyt/fpdYr2bT2xD
	 OtuXuRV4qUOI+56M/rpgsRsvFRZ3W91bu4xVztG3uRsAKgz9FLVH1mfyMlRa9KFrYK
	 4arYLSQ97tqv2/4MFQ203Icqcug7Ptp6bBe4WcL+17p5/CfaJFOdxB15YiSRvlIBLL
	 zV9t/1SCtttFhK5FHQ8kohjSHLhD4sb6bwBSQN56jcj+5rJRt5Os7of92zGGXZJd45
	 c2lajmaSqXrTg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WS6kR1RT9z4wbr;
	Mon, 22 Jul 2024 14:29:34 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Lasse Collin <lasse.collin@tukaani.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>, Sam James <sam@gentoo.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2 09/16] xz: Cleanup CRC32 edits from 2018
In-Reply-To: <20240721133633.47721-10-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
 <20240721133633.47721-10-lasse.collin@tukaani.org>
Date: Mon, 22 Jul 2024 14:29:33 +1000
Message-ID: <87ed7mvyky.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lasse Collin <lasse.collin@tukaani.org> writes:
> In 2018, a dependency on <linux/crc32poly.h> was added to avoid
> duplicating the same constant in multiple files. Two months later it
> was found to be a bad idea and the definition of CRC32_POLY_LE macro
> was moved into xz_private.h to avoid including <linux/crc32poly.h>.
>
> xz_private.h is a wrong place for it too. Revert back to the upstream
> version which has the poly in xz_crc32_init() in xz_crc32.c.
>
> Fixes: faa16bc404d7 ("lib: Use existing define with polynomial")
> Fixes: 242cdad873a7 ("lib/xz: Put CRC32_POLY_LE in xz_private.h")
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Sam James <sam@gentoo.org>
> Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
> ---
>  lib/xz/xz_crc32.c   | 2 +-
>  lib/xz/xz_private.h | 4 ----
>  2 files changed, 1 insertion(+), 5 deletions(-)

Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers

