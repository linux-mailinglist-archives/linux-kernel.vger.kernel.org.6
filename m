Return-Path: <linux-kernel+bounces-260908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B693B014
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52AEB2851D6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4437156C69;
	Wed, 24 Jul 2024 11:05:53 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976BB2595;
	Wed, 24 Jul 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819153; cv=none; b=OsSB/k4cgzs80+73jG5UDWeuQMBnXVtGxoRvLKMAW5AMI/pX0qIeZvcuWnd8uDbESU4bxag8s7i6bsTis0T5f4NluXgwqAXWWPH+KnBJ4yLBblaoySUkKMOkJ2dl1jK3pjR1pUyItiH6b0a9UcTM7SgiZ+NFXkEP0VOd2EfADJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819153; c=relaxed/simple;
	bh=pHp6OPqdJsXqJDCyfex8/uK2iFqAW/O5P7YYz3Gl7ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4GHxzhfAgCeEf6UkqoOfXpgiLFtk3Kb0nG0yAONJJUNZC12g/vb6afArocyf0+LKanJm7jBtsNxzIH/bT9VYoh6zNQlC875euHC3vN0wjbTKam+pfl+ulA1qBGC2NJmQSv88WLMY5Bh2Fc3kO9BimYtmzS+MlI/q47r7N1iEsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sWZhL-000eHM-1J;
	Wed, 24 Jul 2024 19:05:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 Jul 2024 18:58:22 +0800
Date: Wed, 24 Jul 2024 18:58:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: stsp <stsp2@yandex.ru>, linux-serial@vger.kernel.org,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [regression] ENOTTY returned for tty fds
Message-ID: <ZqDeTlq-1NP3dne_@gondor.apana.org.au>
References: <b6f4aa5c-10ba-411b-994b-6dbed2bf63db@yandex.ru>
 <2024072452-pegboard-undying-4245@gregkh>
 <c74f1e3e-a376-42e3-86e0-a804f9a7da2c@yandex.ru>
 <2024072401-spearfish-gnarly-a09e@gregkh>
 <be1a3839-23a6-4726-9018-3d18a27163be@yandex.ru>
 <2024072401-obtain-heap-6d8d@gregkh>
 <ZqDdDPF_N9tcbu_S@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqDdDPF_N9tcbu_S@gondor.apana.org.au>

On Wed, Jul 24, 2024 at 06:53:00PM +0800, Herbert Xu wrote:
> On Wed, Jul 24, 2024 at 12:15:39PM +0200, Greg KH wrote:
> >
> > -ENOTTY is the documented result of invalid ioctl arguments sent, I am
> > pretty sure POSIX requires this somewhere.  So this was fixing a
> > requirement here...
> 
> POSIX does not specify this at all:
> 
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/ioctl.html

In fact it says:

If an underlying device driver detects an error, then ioctl() shall fail if:

[EINVAL]
The request or arg argument is not valid for this device.

[ENOTTY]
The file associated with the fildes argument is not a STREAMS device that accepts control functions.

Of course this is all moot since POSIX only specifies ioctl(2)
for STREAMS devices, but this patch in question is literally
going against the woring here.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

