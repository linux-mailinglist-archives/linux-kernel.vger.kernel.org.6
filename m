Return-Path: <linux-kernel+bounces-274704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4E8947B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10951C21B5F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C2E15AD9E;
	Mon,  5 Aug 2024 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uVw7iw9Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v01jYsex"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208A159217
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863497; cv=none; b=lhdYzBTj+xqlYpNscw9f/UFP09zo3BN7/IF7dumRyBmpZ0EzcxMlYd1xanoOC1Y4JkvJvBP8R3VlGvbEgN1AKKN6eNn6sKlOFGEhU0EqRuTp0nxFRlImREGgVSotk0CKw8B5Y3JYYClDZh4b0YpB8GRj3sOS/lFbclVyOYXfOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863497; c=relaxed/simple;
	bh=QYC+QyuP2WrIO3s7AXadfe2Nev/Gz47fe/wm/37JO9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MSUzMit4kIQ4yFygwdrXhUSL3a7XPbB4oFVQ3tpYMdTMP33nW/itEDnkLA8qJkynYXM1d/4oLFp4X5KQSsJE3s+03pkEfoCpSKnradaekC2oY2MeGY6pc4QApHrsxv6ZZoEH8v4BRZWWUiVbsHnAFXtUkRSlE2Xs7XQnbEjFTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uVw7iw9Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v01jYsex; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722863494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMr6WkEJILx9aM9pYo3XHvw8WEzS8N4fTDK9F4cFQ84=;
	b=uVw7iw9ZeWKrrcRqzc1xukC5c82+5xJ3POVwfd0586nYvvHU48PPcLaighIKxhWu/RsVQe
	h78TJxYE8h+71TzDkQeyoRdIXIpSzHa968DhHh/EIY1itGClnZ+o4CnuIjGHk2MNUUt+qs
	QOBGyrWX2B6XexMLJCKrXl0r5C5rqMujQ0Cu5IGNnuPxu/KY+ige3eDMv1MsY8YvCEeBli
	f7xR+M9o8/7yXhRJeh3czh67z2fomJZ2jCZxVZvl01tfRekLN2cvqBiVQkOTpZS9avOkqL
	K1Zvg7O3hZQSYZV9O+L1rNieIalwcCshW2CfD2BVcKGUiDWHD6zUT8D2uS0lSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722863494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMr6WkEJILx9aM9pYo3XHvw8WEzS8N4fTDK9F4cFQ84=;
	b=v01jYsexHvrTINrHHy83pgpVA9td7Kx9xQFScLw6Vum708kv8FX2FpiGwttk6yp7hQy4GI
	fdezPZwDsr0+KuBA==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regmap: Allow setting IRQ domain name suffix
In-Reply-To: <dd2f4a1e-1861-4838-9ba2-668bcde0e2b5@gmail.com>
References: <cover.1719830185.git.mazziesaccount@gmail.com>
 <fd13fcc9dd785d69b8450c8e9c26d860fcab7da8.1719830185.git.mazziesaccount@gmail.com>
 <87plrpvzmg.ffs@tglx> <12228ec5-cf2f-47b2-842d-ce336d921260@gmail.com>
 <87jzhpscql.ffs@tglx> <dd2f4a1e-1861-4838-9ba2-668bcde0e2b5@gmail.com>
Date: Mon, 05 Aug 2024 15:11:34 +0200
Message-ID: <877ccv5d2x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 05 2024 at 16:04, Matti Vaittinen wrote:
> On 7/13/24 15:22, Thomas Gleixner wrote:
>> Something like the untested below should work.
>
> Sorry for a very late reply. I have tried to minimize my "computer time" 
> during the last 1.5 months (I really needed a break) - but now I'm 
> getting back to the business...
>
> I used your patch below with the BD96801 driver and tested the changes 
> to the extent that the IRQ domains were successfully created and names 
> and numbers seemed reasonable. (I didn't yet try to make the PMIC to do 
> a real IRQ though although it should be doable using the WDG.)
>
> Do you want me to include this in my series (keeping you as author), or 
> do you prefer going through the patch process yourself?

Just pick it up. Make it work and add a change log.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>

is good enough.

Thanks,

        tglx

