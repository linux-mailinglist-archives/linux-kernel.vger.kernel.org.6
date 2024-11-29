Return-Path: <linux-kernel+bounces-417943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8589D5B16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B552831FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3046D189B95;
	Fri, 22 Nov 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="RG2bKg7U"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315316BE0D;
	Fri, 22 Nov 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264646; cv=none; b=Hh0AhkSk5BV42/MDSJg1F0kvTW0nEz0t5kDcZD49YbKEAlijHr/bOPNmqIH6+S+t65Fh1EIFrVEpw2ZsT3EfonVKOXdVxnE68yVhwxqmpNJ+GgwOUWjH/V31fEEXj7oo4vjG2Ke6KF24T3DyYUdQFykjrNG5wyGbuNCPfKSR4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264646; c=relaxed/simple;
	bh=eJwBFSc+VSGtSBmQX5zNF6jaB3qJEZjYwnCtPHAcxhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7V/AxULC/4azPnkR8BVOhGOHprhCF9kJkO0jPv/+gNxeOlK4mBRpTd7A6w0+atSNi8Q/vHkFQhKOBwOUTDAFjy4lg49mrPYGdt8CPY9eYmikx+4Cu3coDL7xqy4vqR/QHy9jAnj68ncMdiu4INCMyaRUK1ansn2xgtxtoaSNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=RG2bKg7U; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hQFyjGxVbbAJxhO1KpGCzDqp5uIWXAEAvmxs7zwQrB4=; b=RG2bKg7UlG0LXZJQgpPplNHqfD
	ZCKWATmPN9fD8sFoQf7I+AcmQTKKiacuKtdw9UEsTZXNar6IildtQC71ce4E3quBPHecJf/D1YmCM
	aP1hv+cqc5VT5qQGQxpq0Hn+atwdXlceS5LBEZVKtWusq8lW6cfBOabzG46bkcNAwDt2tEAbD4/+e
	fvxL//1AdXePc+2zL24Nabs58uhMeyZeyd3G5aXBYhAjzfLLhSqcPESd+meOsAV7zRloPORSklO3s
	TAyliwoqRSzHcwWQCxtZeMitiZNxw+O5fgF2lUM2uE2T6jdXS5ccyYQtSXLjfWladSBskUB3Pi6H9
	NisS762Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tEPA5-000vGI-2t;
	Fri, 22 Nov 2024 16:37:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Nov 2024 16:37:09 +0800
Date: Fri, 22 Nov 2024 16:37:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ard Biesheuvel <ardb@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc: Zorro Lang <zlang@redhat.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Bug report] kernel BUG at include/linux/scatterlist.h
Message-ID: <Z0BCtZi2YJywGJAk@gondor.apana.org.au>
References: <20241122045106.tzhvm2wrqvttub6k@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAMj1kXGAuJSdDWvu7D5-PT6mSbNG9FeLObnYmpHeT08eNxaJWQ@mail.gmail.com>
 <Z0A2W1FTTPt9PeI5@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0A2W1FTTPt9PeI5@gondor.apana.org.au>

On Fri, Nov 22, 2024 at 03:44:27PM +0800, Herbert Xu wrote:
> 
> This is a bug in the API/driver.  Users should not be expected to know
> what kind of a virtual pointer is acceptable.
> 
> In this particular case, rsassa-pkcs1.c should be fixed to use the
> crypto_akcipher_sync_encrypt interface.

Lukas, could you please take a look at this regression?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

