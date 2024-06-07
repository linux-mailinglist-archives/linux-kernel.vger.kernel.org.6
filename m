Return-Path: <linux-kernel+bounces-205965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7ED9002B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15FF1C22402
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FE3190688;
	Fri,  7 Jun 2024 11:53:42 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2A190672;
	Fri,  7 Jun 2024 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761222; cv=none; b=XpVMZw41YJrqH+NrBPdU/zIwd6pGCC9uYr/uW8cVVCrZsdkZD0Fq6/SLym9PVe+I8+6Qf1fN/EvFLqAC07z7EDmZ7FC4nPDF1XLMKQUPz0Vr7LzPXBPAojPm4D44seirBkzzVvv3S8OaWk0tL4ZYDyTPO/b0+Ckb2AQCP04/TUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761222; c=relaxed/simple;
	bh=P4Hsf/rFz5BGJhW6Rq8FXy89oBV6cUyMDNxo4wS1D0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBfgZFkc4xGRxf9n2xIJzHWIvv88VbHEBMLelUeZEIqVA/L38RlpmDiFj9Ifxkt4QWtfFhmkRWkUGW9VH3HDYDXaq5bVx9+w6nrW/prtaq6MGvlDS2O1RiULdowsPsbrWhXDv/DK+zYWcjPXNd+PKO5HzG01YfdLL5hv24Xp0TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sFY9z-006p9X-16;
	Fri, 07 Jun 2024 19:53:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Jun 2024 19:53:33 +0800
Date: Fri, 7 Jun 2024 19:53:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Stefan Berger <stefanb@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: ecdsa: Fix the public key format description
Message-ID: <ZmL0vciwMYCEQeIT@gondor.apana.org.au>
References: <20240527202840.4818-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527202840.4818-1-jarkko@kernel.org>

On Mon, May 27, 2024 at 11:28:39PM +0300, Jarkko Sakkinen wrote:
> Public key blob is not just x and y concatenated. It follows RFC5480
> section 2.2. Address this by re-documenting the function with the
> correct description of the format.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc5480
> Fixes: 4e6602916bc6 ("crypto: ecdsa - Add support for ECDSA signature verification")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> It is a bug fix that does not really need a stable backport. Still
> categorizes as a bug because by following the existing documentation
> you end up with an error code.
>  crypto/ecdsa.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

