Return-Path: <linux-kernel+bounces-351673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74B991492
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB231F23EF4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 05:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18480481B7;
	Sat,  5 Oct 2024 05:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Iq/k3omc"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D920322;
	Sat,  5 Oct 2024 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728106420; cv=none; b=ET2tk02hKG26YPVzvpJWpqlAZdTnaaVVw77fcUxCITFvX7Wb2k7M9qYl3rKDg+AfdbpLLG6h0waS38ECVDKkQG5nHmIIgktyqZKAKKBpECwKv2TCyi5o7G4o8souyY/nUiYj0WRBl2ZhuqnGtGJWNOK8T//3UnfbOL+EuJiz2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728106420; c=relaxed/simple;
	bh=JLAHUlMGK64tSZS78sK2PdZORF9TTxDPVoLMTDNWlUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3KjjmIKSD/HaWw2rNGj5BPcSD1wEQ8DacNJTDOBD8jlDeFxfh4J6p4IRXVLV0DDwfNZPVGQMN2k9GhdKSimvnwSQirBqBbNE0/9PMvTvFidz6LDsmg0Aj/Q9YSXY5VTqIU09IfQ/QDGIAPWAwoxtbZ7pJ/0h1xOQArrPq/mm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Iq/k3omc; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=X+KSg5pqVuDdlzPZYx3Ft/0ljTXwMqHSn6caduN4iRw=; b=Iq/k3omcJppIOUY/n4izstSu4e
	+kXnkkDqgtthRdQ9+hGMkbzHce371sahpMI/eY1uzIvQUtabDVRfDbGfesEbrQhJrCOrAtZ3SfWvT
	khEZ4tFP2unBcqtjuY8ZHjRk+yl97aGMQu7UR5nHCz67k9UZpN8YHFtrFc35REE4FiaqI2s5ZHG1C
	df9FBpquF0Z6XgmI/9AN5tesr0TqgUrgPrAvhx4qpMSDputrqvl3B+JeEZTPkLrjfIXAjC8qiCrCF
	kRyf0LgN4asqAEUB47dR7QCLPf68eHft0bGsgBGW8GzVUjc54Diot4z0rSW83QqF4wXOIDu1bAUjf
	GD+kL8tQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1swxG5-0071XI-39;
	Sat, 05 Oct 2024 13:33:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2024 13:33:27 +0800
Date: Sat, 5 Oct 2024 13:33:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] crypto: lib/mpi - Extend support for scope-based
 resource management
Message-ID: <ZwDPp4bU1J5uEgQe@gondor.apana.org.au>
References: <bc5ce9ad-acbd-4f3b-91d6-10cf62bf5afc@web.de>
 <202409180725.ZV8DCvII-lkp@intel.com>
 <91d10516-4ba9-4fe0-8f63-86205cc4f88c@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d10516-4ba9-4fe0-8f63-86205cc4f88c@web.de>

On Wed, Sep 18, 2024 at 11:26:23AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2024 11:06:35 +0200
> 
> Scope-based resource management became supported for some

This patch needs to be sent to linux-crypto.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

