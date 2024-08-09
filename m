Return-Path: <linux-kernel+bounces-281574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C9E94D853
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 23:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31605B21DC3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9E1684A1;
	Fri,  9 Aug 2024 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FJb1JRJ6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fgfn9Aq7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469BC160860
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723237764; cv=none; b=WBZ6c/r+tCAMa6/5adRO2jZNEb9a5SWtd5HeRCdRCj7gm72gi7lFyjrrZzMhtAZirX8/SGI6mQsvJYjeRAhEukud7GQzPCJz8ZWAzBBGBflqy7uTMJHww50GxcQuXSCaOYoOpCAEaBmDGVg5vzhnpoEyC0xBJJ0MiuKH9mKRQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723237764; c=relaxed/simple;
	bh=VmkTMmDYd30pCmFWbYx1cEuJmYxp1RaDTWTcETWss7k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GByb81iQ5+1izvboFT9aWXpMp3SU1gelmMxRKESlowh0Ukxrt4Bj4UjGW+lbj/SlZCN+/NnKl5AocKlRKv65kbRZ1AWe9IGvHdhkr++CJXITTo9m17J1k4JGKUHGUg/sEjZm2xzxAxocb7gDToyAfTSyALLq3K/bqKTz/TcWQwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FJb1JRJ6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fgfn9Aq7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723237761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t52MQd1DwaRXeIOQXDVlhk0ap14Ll3STyFL3WJhvm3A=;
	b=FJb1JRJ6BNKVpjDXeCTsTuFfkOn2tjGuZw9WvyFlfHjFnxRZi/ErffTsI7ZjB3NB3PrUpd
	kYbHl00uf+r+Dj9obiF60IJAO2ZWSdTmRBc1LF5ksu35VHqi4cEUyUcQT3gT/SjhtTTzZp
	P1ShLdqP6NBz2XGLdnoiL7eOTw6+TYD2XZgjRcAuVi/f2csFU9PcHPBybsTCeDm7DsfW05
	aHVayXom/LTT+4ya9gPe2qP5tSnPKAzmq87n0kixZyoYdoIloFvVpLRY4vQ02XL/uTnI62
	+DHu5ykVs728ilDazmzZlzg7o24KViJZ91HBTAnli/mmNContUBAFqOMfnqjUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723237761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t52MQd1DwaRXeIOQXDVlhk0ap14Ll3STyFL3WJhvm3A=;
	b=fgfn9Aq7Dm13DUq4nec8hgAR6IrHWeoJIEmOoi/yZ2DtxNrfmlLveWo3OofAhpsE0SWKTv
	xjWJmMqbzCUHBmBQ==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] regmap: Allow setting IRQ domain name suffix
In-Reply-To: <776bc4996969e5081bcf61b9bdb5517e537147a3.1723120028.git.mazziesaccount@gmail.com>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <776bc4996969e5081bcf61b9bdb5517e537147a3.1723120028.git.mazziesaccount@gmail.com>
Date: Fri, 09 Aug 2024 23:09:20 +0200
Message-ID: <875xs9tncv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 08 2024 at 15:36, Matti Vaittinen wrote:
> When multiple IRQ domains are created from the same device-tree node they
> will get the same name based on the device-tree path. This will cause a
> naming collision in debugFS when IRQ domain specific entries are created.
>
> The regmap-IRQ creates per instance IRQ domains. This will lead to a
> domain name conflict when a device which provides more than one
> interrupt line uses the regmap-IRQ.
>
> Add support for specifying an IRQ domain name suffix when creating a
> regmap-IRQ controller.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

The change looks good to me.

Mark, I assume you want to take the regmap change. If so then feel free
to pull the prerequisites from

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-domain-24-08-09

into your tree. It's based on 6.11-rc1 and contains only the three
irqdomain core changes.

If you want me to carry the regmap change, please let me know.

Thanks,

        tglx

