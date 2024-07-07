Return-Path: <linux-kernel+bounces-243689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B418D929946
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 20:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A79A1F212CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C089459164;
	Sun,  7 Jul 2024 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z6/SJfFG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z9pMlNF2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239535381A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720376044; cv=none; b=PHQveAZHdEP6RFe4RvPPb9V5NUbexGjbkrGH9nlKUfpNxQZSyqSemJOFd7fvnqK6dnHFq7Ph7czBokmNvHJNCsyezZ4CuuWEeb4kDjOf2k1Wtt+7b36siRDyJXqjtmfc+nFkkEV1j6FvbD/lD9alg9t3FMZOM2Db59Y/SAr1Uc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720376044; c=relaxed/simple;
	bh=a5IreKI3rL7dojzavwqxSSYX+suevjMvZWzIhGxEeoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KDNpmpDNbudSemPfjTZ5sf+UWwDBYfS1Ow4BmUr7ClUKdvMF4G+/QjwUzHYvC8YGrehVpoh4pkm8bF8acdPt4ZtDgrZYShALDUkES5s8um7UEK69Is+T1ovb1RY+YtO6IYLlyT9AP35tIXAfBZv/YEzJ5f1lu9iwIVnPKytExf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z6/SJfFG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z9pMlNF2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720376040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WOkHRTWseWw866iHnKch0XOvayohYD6Y4JqG0pE2kZw=;
	b=z6/SJfFGJnqLnN/6E2UG1DVH+2HTtp2BhaEu7pXD3ES0hPOkTAJYAzNuNW88nSh6ZLJbdt
	yl6LScMuUsyVL6wMwFy0upxyPi6sJEOLLsAtS5H4UgFgc/Vo9GHHlZAY6l1f+drXjojtlU
	dh75xHY86gtOMegjZ+nOs7mVDrI8BKw6OoVT/JcHWWUMiSrV+hVtnnIivziq+t1lWtQt+/
	6L+1X6hgqE7Q+uKL1oN4rKzRit07AaULaXpcZnhsCsM2EvoveEjlTZUHualGpPe+eUq8Bu
	9cg/c10edfcfJ5aU2O4kpTLDAYTvdo3MJt0nIFI+tqXztn7VrXy5qnX4sToQFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720376040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WOkHRTWseWw866iHnKch0XOvayohYD6Y4JqG0pE2kZw=;
	b=Z9pMlNF2dem2CCLICtMq6XZhs9TNP/NbF4RcgnbeaFljSi1xJSmZnnXkwW2DJtWsdGzQ5Z
	3B9dwd0S/zgA0zCA==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regmap: Allow setting IRQ domain name suffix
In-Reply-To: <fd13fcc9dd785d69b8450c8e9c26d860fcab7da8.1719830185.git.mazziesaccount@gmail.com>
References: <cover.1719830185.git.mazziesaccount@gmail.com>
 <fd13fcc9dd785d69b8450c8e9c26d860fcab7da8.1719830185.git.mazziesaccount@gmail.com>
Date: Sun, 07 Jul 2024 20:13:59 +0200
Message-ID: <87plrpvzmg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 01 2024 at 13:59, Matti Vaittinen wrote:
> +static int regmap_irq_create_domain(struct fwnode_handle *fwnode, int irq_base,
> +				    const struct regmap_irq_chip *chip,
> +				    struct regmap_irq_chip_data *d)
> +{
> +	struct irq_domain_info info = {
> +		.fwnode = fwnode,
> +		.size = irq_base + chip->num_irqs,
> +		.hwirq_max = irq_base + chip->num_irqs,

This is not correct. irq_base is the linux interrupt number base. The
first_hwirq argument of irq_domain_create_legacy() is 0.

> +		.ops = &regmap_domain_ops,
> +		.host_data = d,
> +		.name_suffix = chip->domain_suffix,
> +	};
> +
> +	d->domain = irq_domain_instantiate(&info);
> +	if (IS_ERR(d->domain)) {
> +		dev_err(d->map->dev, "Failed to create IRQ domain\n");
> +		return PTR_ERR(d->domain);
> +	}
> +
> +	if (irq_base)
> +		irq_domain_associate_many(d->domain, irq_base, 0, chip->num_irqs);

I wonder whether this can be handled at the core. Let me stare at it.

Thanks,

        tglx

