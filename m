Return-Path: <linux-kernel+bounces-282120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8894DFCB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 05:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F87F1C20A96
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 03:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618B7EEAB;
	Sun, 11 Aug 2024 03:13:50 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC6DDA1;
	Sun, 11 Aug 2024 03:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723346030; cv=none; b=nK6yXMLn/2LVMTNFz2OzlumaPhlTurF2KPNhNgoKAhMvYf5KOcS3ESOjkCc7W0734eEeBDwldKla2oGEXSWjYJljz1B+F3I+QSogDiT5DgzLe1SxCNF2xveJsua7gSr33eg4Z94eC1ISZ/JMMWznQhhyLtxtd1W/oWE0PmbDbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723346030; c=relaxed/simple;
	bh=2LbTujiM82hlx4Eqh31WE2r0gO2k+ci670+CnPgomYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii+uUB/POL/3QjryNgEjyGzjAMqTYjgpB+lZ7KlRGu6UtpSmnVhQjyjlBGZkHPHj+emabrznPvOpUyLqCN9s5EDpZPJ1Lp/6EWDnFE0AJhN+5J7DS4zgxhCi49W1IB+iZIiUAoW4mAEuJ8FaFCkqw7tXBBEXCZMFucDcOBPPGtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1scyso-003qsW-1H;
	Sun, 11 Aug 2024 11:13:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 11 Aug 2024 11:13:23 +0800
Date: Sun, 11 Aug 2024 11:13:23 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Waiman Long <longman@redhat.com>
Cc: steffen.klassert@secunet.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: Fix possible divide-by-0 panic in
 padata_mt_helper()
Message-ID: <ZrgsU-1PdxvUVMOW@gondor.apana.org.au>
References: <Zrbm--AxRXgfHUek@gondor.apana.org.au>
 <e752f094-adb4-4448-8bc8-e2460330eaec@redhat.com>
 <ZrgXtLI1R5zJ9GFG@gondor.apana.org.au>
 <91d29649-ca88-4f6c-bf1d-19e49c9555df@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d29649-ca88-4f6c-bf1d-19e49c9555df@redhat.com>

On Sat, Aug 10, 2024 at 11:11:07PM -0400, Waiman Long wrote:
>
> > Unless I'm missing something chunk_size cannot be zero before the
> > division because that's the first thing we check upon entry into
> > this function.
> 
> chunk_size is initialized as
> 
> ps.chunk_size = job->size / (ps.nworks * load_balance_factor);
> 
> chunk_size will be 0 if job->size < (ps.nworks * load_balance_factor). If
> min_chunk is 0, chunk_size will remain 0.

That's why I was suggesting that you replace the division by
DIV_ROUND_UP.  That should ensure that ps.chunk_size is not zero.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

