Return-Path: <linux-kernel+bounces-351671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3431299148B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664641C21794
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E72838F83;
	Sat,  5 Oct 2024 05:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="pH61075k"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A752F88;
	Sat,  5 Oct 2024 05:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728106305; cv=none; b=cjzqOLiT4ChB4gwhmQn+ReY3AKSmmRITwOJukHb+wH8DXv2VeM0BW2Mjbhd2kuxMJBleUlFjtX4Fht6TyKWRmXU6E6SVaYQQYY8et2gMA1zLPbLot6huZwtzaJvOSQc28d9fFwZTHjIdpqwxLmmIPP9vHq5yv26KxH65KRcMzko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728106305; c=relaxed/simple;
	bh=Ig9Fi65DJmEcDPzNna6Yc8XYAplLtYNpA/f20S5anIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxsprUFWbeEcE1HdJ3BAHRcD7uFaGlMCdTJOmifqHgOBE0OtUDx+QkbzO2Kp7cwateS0i8Yrui/r1DfxxGb6yA6MPNY+jfTiQ5nudoUMhU6Liisdi5nktsyY5kSliP6yibK37YJ8n71pcnfk4nlKLgqZtorAXzFZbePQNGSn6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=pH61075k; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=X3KoJrtb6yoThvvU3ELEtrzg6xFMWejMoQFw47unGrI=; b=pH61075kDWCyc5gRKu1HGU6k8X
	FNyPP3oKll6BKSxgPzbQTfWy0IkS3wmw0BkA38JDRJIE+ZnpzkWSXx84DxAHMcUyepqXNZ0AsNtJR
	/9ojumxlWIJ2NP9die7qsNPG+IKswoPzf8lqe6OXmb5hlbuy6dFc2B9LlCSGeGo2FY6TuwBJJX1Hw
	4FKSrapeUu4XWRjDNbDPNFep/7BE/iS1M2Xyzx6+h0OzkhQgZMwzx7whvxF/mQEArJIgORQrI8mj/
	oM+N7MFyhLN9juQZXUtXSsb52Uxfztou0yurhsZOG9J+V95iohFCJJUIUdv7SwktI6FLQ/xj4TSrt
	XBgM4RoQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1swxEM-0071W2-0f;
	Sat, 05 Oct 2024 13:31:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2024 13:31:39 +0800
Date: Sat, 5 Oct 2024 13:31:39 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Weili Qian <qianweili@huawei.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	liulongfang@huawei.com, shenyang39@huawei.com
Subject: Re: [PATCH] crypto: hisilicon/hpre - enable all clusters clock gating
Message-ID: <ZwDPO1vXNTM_myIK@gondor.apana.org.au>
References: <20240914105716.20840-1-qianweili@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914105716.20840-1-qianweili@huawei.com>

On Sat, Sep 14, 2024 at 06:57:16PM +0800, Weili Qian wrote:
> Currently, the driver enables clock gating for only one cluster.
> However, the new hardware has three clusters. Therefore, clock
> gating needs to be enabled based on the number of clusters on the
> current hardware.
> 
> Signed-off-by: Weili Qian <qianweili@huawei.com>
> ---
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 40 +++++++++++++++--------
>  1 file changed, 26 insertions(+), 14 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

