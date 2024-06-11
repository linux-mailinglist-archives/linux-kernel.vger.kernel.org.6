Return-Path: <linux-kernel+bounces-209215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B265902F08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B5D1F22811
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8BF16F915;
	Tue, 11 Jun 2024 03:18:00 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8B21E488;
	Tue, 11 Jun 2024 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718075879; cv=none; b=L8KgButn5ArrP5fTrxKfNKuGZjYD8keqwd4hUnzCdTdzO0KIkmmKzd9NyiQRUPA6eQ7i+Z5BhdELe4kL71zRne43LzQ5f8RuNhe9F+ln6PmWX5bQp43upgh2/G3NNJuwENU3Ymd33r2nyfLplJ5HOlFqM6rG4tuJxQNNGTqB7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718075879; c=relaxed/simple;
	bh=Ydif14KSaL2dZXCQ1/SC/U8ZjtqX5kvy/Hgk1NSTczc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgKF/LnXdlfepuq5M8FrNtZnmHM7C/GX6gM3ZVnEgNipdWkMFhh9Ob4sUYoQgL8C7TnzwxFy4iuUzUuXZIuLb7nF2bSGBupAsO7m5afm7SHKO18ZObxA6JqYUwyLXCENMcd1ex0Uc/nxaKB0TLkbfRuNtwXdsX8ORuGlvhHcQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sGs0f-007rxS-11;
	Tue, 11 Jun 2024 11:17:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 11 Jun 2024 11:17:24 +0800
Date: Tue, 11 Jun 2024 11:17:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Kamlesh Gurudasani <kamlesh@ti.com>, kristo@kernel.org, will@kernel.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, vigneshr@ti.com, catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Add support for MCRC64 engine to calculate 64-bit
 CRC in Full-CPU mode
Message-ID: <ZmfBxLB8RC_KNUlx@gondor.apana.org.au>
References: <20240524-mcrc64-upstream-v3-0-24b94d8e8578@ti.com>
 <87tti098af.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <Zme3EcW4Uz8kTbTt@gondor.apana.org.au>
 <20240611031314.GA2557@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611031314.GA2557@sol.localdomain>

On Mon, Jun 10, 2024 at 08:13:14PM -0700, Eric Biggers wrote:
>
> I thought the rule is that there needs to be an in-kernel user to add algorithms
> to the crypto API?  Is there any precedent for adding new algorithms purely so
> that accelerators that implement them can be accessed from userspace via AF_ALG?

I agree.  Perhaps this driver could instead be added as a simple
char device that is then used directly by the intended user without
going through the Crypto API at all.

That would make it a lot simpler.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

