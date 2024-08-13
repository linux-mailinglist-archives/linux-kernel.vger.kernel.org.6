Return-Path: <linux-kernel+bounces-284328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932BB94FFEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D34A1F25126
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC4013A888;
	Tue, 13 Aug 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0viyZsIx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPtvMgUt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EA86BFC0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537967; cv=none; b=t00cQLhT4DFuM8svUYNxFOg2tIqALxj8EicD9W5vodDXwcIyR7Mn+bN6K/lNi0lNb1M3vTt20YI+4uo5ybmfcp91xXLHZ01mUR6xznvZExuEomPbEsJCwp4TI6jdF/knZDOJmNcw5gmHgs2O5nF1KtW08EoqRzQG9TPTgDN3vDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537967; c=relaxed/simple;
	bh=gcwMyVmIie1YHSkNUh7M2SXPnib/2BebV8hlry2PKlY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GRu639bze/6FIYMosVH5GJXa2qtwSOxLNf0ovj8BF8wUzbZQpbwEZ60SgyOf9UkFifj1JU3nfzw6wOvASzaHdBGJcEEe+50SyDsCJhZMtTu2WCC7tAY3KeeBhnT4GX3kcWneJxLurL5MdgJsO1J2n7dChr76rjWg1xP9FthIh38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0viyZsIx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPtvMgUt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723537964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gcwMyVmIie1YHSkNUh7M2SXPnib/2BebV8hlry2PKlY=;
	b=0viyZsIxbM51bEsCpG9ji9cxODaBPPCvX2Tbnh5rQEFJYlDmczo56hXVZPFwdSdv9sn/XP
	1y5+IGF/n/EnBuBk+ClE7AMKRKSNNAFC/AX7g7UztHiB2qkLmMQBV8JE2mxSjnKkf6iK9a
	0ZH3sVw2d2nk0xFJ5AAL7kOEWyePa1Y7QInkc/y2bT4VoJJ/tP5nCkUnMuJokmhG0s/PWM
	4dNI0yhhJ+RLxFhfzzkKMvUmZ0oeVvk9ekeAewc1wecbnDfMDwO6ncgYOhiBjFI8EctD7r
	KWTPwmeBUtbLi/RbGHPeWe/u3atlm9XrENdkL8ewT7uUoqZc2ol0BQrepLpyFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723537964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gcwMyVmIie1YHSkNUh7M2SXPnib/2BebV8hlry2PKlY=;
	b=JPtvMgUtjEpnEdBBe9SVZ6DUyJzXW6jlXBVMIr3DgNKbLwmClsMa5+W5fsSjTZ0FP0nx08
	OXtilZa4/LIY5xCQ==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org
Cc: Herve Codina <herve.codina@bootlin.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Mark Brown <broonie@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] irqdomain: Unify checks for bus_token
In-Reply-To: <20240812193101.1266625-2-andriy.shevchenko@linux.intel.com>
References: <20240812193101.1266625-1-andriy.shevchenko@linux.intel.com>
 <20240812193101.1266625-2-andriy.shevchenko@linux.intel.com>
Date: Tue, 13 Aug 2024 10:32:44 +0200
Message-ID: <87o75wrff7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 12 2024 at 22:29, Andy Shevchenko wrote:
> The code uses if (bus_token) and if (bus_token == DOMAIN_BUS_ANY).
> Since bus_token is enum, the later is more robust against changes.
> Unify all checks to follow the latter variant.
>
> Fixes: 0b21add71bd9 ("irqdomain: Handle domain bus token in irq_domain_create()")
> Fixes: 1bf2c9282927 ("irqdomain: Cleanup domain name allocation")

I'm fine with the change per se, but what does this fix? It's correct
code, no?

