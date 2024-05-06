Return-Path: <linux-kernel+bounces-170266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 105DF8BD44A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92061F23A7D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0744B158A1A;
	Mon,  6 May 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k7fSDQaK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vHAV4Ky1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479C197
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018490; cv=none; b=J4XAkOcT7no15ks+h7zUQw0eyKZsnI+IUdcKJ3GRtodCIcZZ7AIl3+roZdO+NKC4DAx54RfpDdCj2Duz9xmnIui0gGx+hKo4/h0oHcQDktZuPMw7wm9UC3jKFHiwQuxYTi/Su6qSQeBq+ERpYLy9B0D73nPqTGo9un7Nnd+aYEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018490; c=relaxed/simple;
	bh=7N+REMc4zvb+uMii4vy3Hs+O/HYMyAG62ctzR9wojo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=udsgEQW8wtSBi+1BURx5TtNU+7lXSAJMF4PeKCmdYdLIQhYxB8SBfFxSXYqn2hKW2oL7/cZYQwMU6xzz0GDrOYpG/QtVLGxCd1rtYL6kdzkyHMILXBZwo9ED97cktQKjgTMj9OqQhN/DBrlSxvTs+gYljyt7Hua+GdqqMalGGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k7fSDQaK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vHAV4Ky1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715018487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mOsFk8JYA/hRSXPw6ETncdgH91U/gXtdxgFmZyAkpwI=;
	b=k7fSDQaK9zKAyyW6VKqkj42mPiBsdcZXdtCsMvpoYwxz39Ay0zPp7/OMApzp98/HOiSG1T
	A0QInuknsKfy7hWawqpXjaBDGw4jAbc3/FmUmSBoJSfl/VxVdFnim7sYD1VhocPt7Bn0sT
	0DTPvQNAvsLaFIXn5SFyqpTh8jjM/lPVCAK9jYw+a5PyXtGlJ5waMOOm0VGAEgpL8eYMCQ
	xAaS4xJbiBjdDvNaMrQLQwb8btZibz5j0zZVZ/hCACNWpxDOsnK8duHDbdGFA5Wg7B3fzw
	uqpkFHcDUDqx8swOWOmWoD8X8vFfRShGalACsbCcXeIGqvSekmFDzlGouOJ20Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715018487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mOsFk8JYA/hRSXPw6ETncdgH91U/gXtdxgFmZyAkpwI=;
	b=vHAV4Ky1ZcTVFCI9eG2UsbymomSvOWUYKxmkVwG0wDqZNVwGd7moYK0vsAcUXr8chYebGS
	wZGGNzLYFSMMaqDw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH] genirq/irqdomain: Clean code for __irq_domain_create()
In-Reply-To: <20240430093353.1919862-1-ruanjinjie@huawei.com>
References: <20240430093353.1919862-1-ruanjinjie@huawei.com>
Date: Mon, 06 May 2024 20:01:26 +0200
Message-ID: <87pltyrf9l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 30 2024 at 17:33, Jinjie Ruan wrote:
> Introduce irq_domain_alloc_name() function to handle name allocation for
> the irq domain, add "out_free_domain" label to free the irq domain, and
> when "is_fwnode_irqchip(fwnode)" is true, "domain->fwnode = fwnode" is
> the common action, so do it outside the switch, which can make the code
> more clearer.

First of all changelogs should describe the reason for the change and
not enumerate a list of things which the patch does. The latter can be
seen from the patch itself.

> +static int irq_domain_alloc_name(struct fwnode_handle *fwnode,
> +				 struct irq_domain *domain,
> +				 int unknown_domains, char *in_name)
> +{
> +	char *name;
> +
> +	if (fwnode == NULL) {
> +		if (unknown_domains)
> +			domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
> +						 unknown_domains);
> +		else
> +			domain->name = kstrdup(in_name, GFP_KERNEL);
> +		if (!domain->name)
> +			return -ENOMEM;
> +		goto out;
> +	}
> +
> +	/*
> +	 * fwnode paths contain '/', which debugfs is legitimately
> +	 * unhappy about. Replace them with ':', which does
> +	 * the trick and is not as offensive as '\'...
> +	 */
> +	name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	domain->name = strreplace(name, '/', ':');
> +
> +out:
> +	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
> +	return 0;

This function is horrible. The only shared thing here is the
domain->flags manipulation. I'm not seeing how this is an improvement.

Thanks,

        tglx

