Return-Path: <linux-kernel+bounces-429359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD029E1AFD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 407FD166D5D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF801E3DF9;
	Tue,  3 Dec 2024 11:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bxq5elKu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5i8YeLOO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008251DE886;
	Tue,  3 Dec 2024 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733225530; cv=none; b=taTSWZRdDIT/beP5WCq1RJsVCcPnnxkvIgJF0BSMd7dBn8Vt7QPrYcu2fmyp1lzNeXFooDqzqY8umT/ISFRa/rDCP5M17e8zvhI7oDDo3MNwcWcP/+Yd5WhPEzPocr6dGJFpesIiT6HIXggp9deUhzrs+Q6K2gJ95PEnRbGU0/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733225530; c=relaxed/simple;
	bh=K6ijxO0gXH78pOXoR8+Xo33G/eCfKwVBDGXfn6chPRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eK/NxCOJZ0En/hvR+v8+pP0BrC/OiQoIW+rq19izPkx2s1B8H1uf2aoBsLstpMQuj0K3EAWhlFGZycyng60Oc26zN0yb1XcULW81mHS2CvrOT0ImF0ILFySbXs/A6bguleo9ZbzwaaKNVceu0f+UY2gSfINlBzUiM04r5D+yRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bxq5elKu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5i8YeLOO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733225520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ktSVIsbQKLhTywMFEOvb1oorUxhayzju3lEIWyEjltM=;
	b=Bxq5elKuwaPBAfC65MfyZrOxZwDgx4ET4ZKyxZyF7pQIhh1LHtc99dDeYOxgEYF+UH8ISn
	0G8wbLUoOcloMRv/OPFMoGikh1y3qQRjjEVaNV5hXt1trzvTYyqSUwfJojjx5PBa+f0SXM
	5+1dMglBCqVJ7yyB8tABhytEOnhYrAWpTReI+C9BDff9TGBirHwD9lXzbLWxDzDbZQ9vE2
	p+e8qAa5H5DQdqijcZb/9DiZxWYb45xFHKyizdTM9gmPdxwXla2DOt+YRFTWN4vupTut9w
	pXbPq3MyEFguOoS2mtYWmLFBhWCBj0/mo/imp7wIlFlXzMwiN94El3WnbLMn0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733225520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ktSVIsbQKLhTywMFEOvb1oorUxhayzju3lEIWyEjltM=;
	b=5i8YeLOOIFBApZ/l1KLSPrPV6fx1UFY5qf8B9u0NibyAPJIUyeD9NU5tBIOHfmf4NHDchV
	jIvNXthVlJETCXDQ==
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 4/5] irqchip: Constify some irq_desc_get_chip() usage
In-Reply-To: <a683ada6749705812e9cfc4c36ce36386362d814.1731835733.git.christophe.jaillet@wanadoo.fr>
References: <cover.1731835733.git.christophe.jaillet@wanadoo.fr>
 <a683ada6749705812e9cfc4c36ce36386362d814.1731835733.git.christophe.jaillet@wanadoo.fr>
Date: Tue, 03 Dec 2024 12:32:00 +0100
Message-ID: <87plm9t32n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Nov 17 2024 at 10:49, Christophe JAILLET wrote:
> When irq_desc_get_chip() will return a const struct irq_chip, the const
> qualifier will be needed for local variables that store the return value of
> this function.
>
> So start to add some of these const qualifiers.

Can you please create a coccinelle script which does a tree wide
conversion of all irq_desc_get_chip() and irq_data_get_irq_chip()
instances?

That script can be run at the end of the next merge window once instead
of having to chase 240+ places with individual patches.

Thanks,

        tglx

