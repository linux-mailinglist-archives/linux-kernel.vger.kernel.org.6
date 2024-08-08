Return-Path: <linux-kernel+bounces-280090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7AF94C58E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A05A286BFA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF66155A5B;
	Thu,  8 Aug 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZNsz+9ci";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GmNbjIY7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F75BE40
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148241; cv=none; b=TQ3wlsOm/4CfvrcW59gw2L+88kMRMO2jFfHiqzyhFIGqZ0iDiOs7UDnoPT+9Xq+sHj5hLVjEQ1IfwsfK4WvnlyXZ8NAU/e6DSZG4cnb+Agid6dG5kxtpMj1i+yndA2+zLxpBPMjdR6qn2LMujJ4pRPWcXRk7W2w4JB2suPQjvgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148241; c=relaxed/simple;
	bh=14OY1ypVBgTqOcpMBqdvyUUvbZxh28F7lZ5QrnHMcow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gvFmzJ5UX1BcuTEDuZzGugHFBNR2yTk+26gb2xoSRetU2jKOCWH3EZuV5wnfR0bp6u62SBFRjTFtdEPry1BQgqEPxTuOovA1xAuLo+PG3Ee1Y4h1ecmVHf2eJ8FiUgUWA4FIyKDsS+3U0VI54nGGSLDGiarZ9No94YP39aqxp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZNsz+9ci; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GmNbjIY7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723148237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=So4w+kZMOXOH/iE7MMpjSgVya3hbi+bnHZNcOVYuXJE=;
	b=ZNsz+9ciEAjcnVK9mNPSgd4p5LNPMQwcuIPhTjw7kMLs2l2CfBxAoIb/SiCNOGuoNQSxWZ
	rmeD5cQ4WPR2htQo/NHRaVQp40BvsBlqmw3s8UjhcC9NNg3FyvDjqAOEm4hPT2SEwoZ86b
	c+e5idVR1kfxTsIP6jEuZopEhSDaokngT287hAmjdV/sp6vaFbDBo9Nv0ODcPJHfMb3rgf
	0xSEDSGMnnGVxux2OLWWSOoq3y1osul6S91zs2yZB9n2s1DvIsZ7fnMso2ZMTU7nfuQr5D
	LCKEcjCrb2cHHhrfp8qdkc9Dfc0GimMQAxyKIaDz3xcQxOkXIxtIzVsIK1LWsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723148237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=So4w+kZMOXOH/iE7MMpjSgVya3hbi+bnHZNcOVYuXJE=;
	b=GmNbjIY7sqcRiNLXuM6oqEuV83tLNIKSVn2rj4qFKAplpwTK/FScTAlMfWLRg1h7bWlNHe
	v1nRlVxFATzqhGCw==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] irqdomain: Allow giving name suffix for domain
In-Reply-To: <7a048c0139e79beb46d887b0cd5a620963ff8ef8.1723120028.git.mazziesaccount@gmail.com>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <7a048c0139e79beb46d887b0cd5a620963ff8ef8.1723120028.git.mazziesaccount@gmail.com>
Date: Thu, 08 Aug 2024 22:17:17 +0200
Message-ID: <877ccqvkfm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 08 2024 at 15:35, Matti Vaittinen wrote:
>  
> +		if (info->name_suffix)
> +			name = bus_token ?
> +				kasprintf(GFP_KERNEL, "%pfw-%s-%d", fwnode,
> +					  info->name_suffix, bus_token) :
> +				kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, info->name_suffix);
> +		else
> +			name = bus_token ?
> +				kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
> +				kasprintf(GFP_KERNEL, "%pfw", fwnode);

This really makes my eyes bleed. I know you copied the existing mess,
but that does not make it less tasteless.

I'll send out a cleanup for this horrorshow in a few.

Thanks,

        tglx


