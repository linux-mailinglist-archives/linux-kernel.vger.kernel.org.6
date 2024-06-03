Return-Path: <linux-kernel+bounces-199715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BDA8D8B36
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878451C221A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E813958F;
	Mon,  3 Jun 2024 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OCaN1bWP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BAbo/R2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CA4B67D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448600; cv=none; b=adTALyAei2PoWx34tgO39SXNHApqnI3i+ZFv7QB00Z7M7//5VQiVMOS41d0MAUA+csLoh2iGSt0DNplFRmCke8Dj2kCdOlAY0ghtCppFB0A1YODzPb3KnqrlzyBIcXkPqqHZDE6AeKpwcXT5FZ9XXwE0VqxrgLfjRz9dJ91Hcc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448600; c=relaxed/simple;
	bh=IOKtAsjhuhpPBVJuIklEpdccGy88OI4+J/c5GwvtnTw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcPva8O1cLJBCMndDplQkLYFy66PVH3ckGpgN1Nvgt1xm6mytsxUDRRxgMq+apyr/qo7xuu4RuaHXOkIp4TYC1EsOn7Vw+0RHy9SmJTQaklBhDTUQ/B4uYJsv+Cw2VEZk05TNRsFAGnejZBA9/Tm1l12Pg89Hn10uxgAuoQHnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OCaN1bWP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4BAbo/R2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717448596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kuEY+Nhu3Aj5gqWX6VU4Q2n7kveaCFtmDsQ7ZDExGaI=;
	b=OCaN1bWPmzQVHXy8x3Qf2kEORBeOQO+QGXt74ItKZ2HuIoCFX/mAGLlnzFe1RQ40bQ0eHg
	idWE/CLW1TZQsDNbKvKjcZKuUxVxRLiU3Sq6+RZu9ypC/IMvM2C1G+nr/fSZWu+U4E27ju
	rrm/6onrRlcsyce47fvu1WWxEew28gq3HyNncwSVkVtB8E1L2uP8PLUwZFOo6sKPSOQD87
	K/cP0GnAqC/+yj+gABUGZSHBIwcR/eFIaAv8Wt5dV0pCBZWP47bY0ebip4pLp+UXifnd15
	Iiyf0Nj2jLJfVT1vXraCn/Z68Ov9E+DInMEqKgojySu7ZfnHsVIMyT2GjIAL5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717448596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kuEY+Nhu3Aj5gqWX6VU4Q2n7kveaCFtmDsQ7ZDExGaI=;
	b=4BAbo/R2YcGDb3kUyLcqzy3jtiA1xiDHz5V8TtvPXGnselhWvcQdOE2I+ySKKt9ZIfIxUW
	JKT/uPcUw2NrkJCA==
To: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] irqdomain: Allow giving name suffix for domain
In-Reply-To: <aea82422-fb54-4d6e-be5c-ba0a0fa7e23c@gmail.com>
References: <cover.1716533790.git.mazziesaccount@gmail.com>
 <2ea1749587d9e5a74a80a8eee7caf58c3e954a6e.1716533790.git.mazziesaccount@gmail.com>
 <87h6ea72f9.ffs@tglx> <77c64d75-43fa-47bf-bb3a-e0e49d51189d@gmail.com>
 <8734pu6ky8.ffs@tglx> <aea82422-fb54-4d6e-be5c-ba0a0fa7e23c@gmail.com>
Date: Mon, 03 Jun 2024 23:03:16 +0200
Message-ID: <87zfs168ob.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matti!

On Mon, Jun 03 2024 at 20:38, Matti Vaittinen wrote:
> On 6/3/24 19:38, Thomas Gleixner wrote:
>> Did I get it halfways right?
>
> I think you got it perfectly right. :) And, I really appreciate the 
> extra mile you went when spelling it out in this way. I will send a new 
> version where the legacy domain function is dropped, and the commit 
> message will use what you wrote here  :)

Please don't use it verbatim. Use it as a guideline and express it in
your own words. Copy & pasta is conveniant but rephrasing it makes you
learn. :)

Thanks,

        tglx


