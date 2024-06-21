Return-Path: <linux-kernel+bounces-224668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9C4912588
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABED71F23661
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2851015B15F;
	Fri, 21 Jun 2024 12:34:53 +0000 (UTC)
Received: from norbury.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4015357A;
	Fri, 21 Jun 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.24.177.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973292; cv=none; b=hby64rXK4GMl0lU7l2cV1NFwc0ya1h+OOs2F+4pxZMI/R+g5TXcxPFYomMpn3CeqRTHG5jwz0/6o4GHgBtta9uXK8DWD07kXSWRbD13FNhcO9zD1WUOVUjiOdHWJiMpgt+rK4mmhGS1OP2pI/P3sxVF4p3O4l/xeE3RwlcSM5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973292; c=relaxed/simple;
	bh=AQ9GH2ZCzhW91gDkmq4xh3yYlkTy31jr+FbxQLfS5Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TODjP6JoIsoW4FSefp801uFSdjwV+UBDQ5XEhMAhSTFMOoBohBCbN5ChM4WuiS/GDl2e5F9rV6qYNsMDcoe6c1zcWDXknWOHt/qztLoy9iQX2MQguE20GHg5ZLuykhhEuQTJazqZ4nkzxFRTE3j6RJgdmPE22IcOmgYrghBEYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=216.24.177.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sKdTN-002eoo-0A;
	Fri, 21 Jun 2024 22:34:34 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Jun 2024 22:34:33 +1000
Date: Fri, 21 Jun 2024 22:34:33 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] crypto: lib - Use swap() in mpi_powm()
Message-ID: <ZnVzWRPBPQZ29Haa@gondor.apana.org.au>
References: <20240614030912.10736-1-jiapeng.chong@linux.alibaba.com>
 <20240614030912.10736-2-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614030912.10736-2-jiapeng.chong@linux.alibaba.com>

On Fri, Jun 14, 2024 at 11:09:12AM +0800, Jiapeng Chong wrote:
> Use existing swap() function rather than duplicating its implementation.
> 
> ./lib/crypto/mpi/mpi-pow.c:211:11-12: WARNING opportunity for swap().
> ./lib/crypto/mpi/mpi-pow.c:239:12-13: WARNING opportunity for swap().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9327
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  lib/crypto/mpi/mpi-pow.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

