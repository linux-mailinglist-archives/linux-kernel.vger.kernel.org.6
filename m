Return-Path: <linux-kernel+bounces-217685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739ED90B2ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DEE2873AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC851684A8;
	Mon, 17 Jun 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IRXQAY8i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWmw9Z71"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0B16849D;
	Mon, 17 Jun 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632668; cv=none; b=Y6E8hKDhmnWaHxLvlWk1h9dsIahz5V9iqj1Le1MyI8jWGpFC9L/OhZdu20I3Xi0dkb4m1dtIjuReCt3FSOnOAxAdIdfa4pV+0IhV6sRNTMSsf+YXKl9jgQKQQ8HKoKn7LERhi4aPU7rJ4gtDrOhioOLUw5wsNyzZ4H8t78JgyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632668; c=relaxed/simple;
	bh=7+/yv+wTD2aNMSmrXyx9DJ9AKU2xChf4GXVaEZFVr0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eok1/MP6zw7gOXn4XtPvE8jv1RuxZx8AN1yoIP9sAqbGn2xegNNgBShWy73uVzWfGiTzJSUtf0UXG79BoxpmFaExaqroB24Sy2cQErVDwRGof9DAc8UMh6epfHfqQNRzEUWaiMGio3U9QtkAe4BDcRW3TPXJNhuzpoEZFFe3pVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IRXQAY8i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWmw9Z71; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpEnzyvYl+YaVf9FbH6u/ZTNCFgglA8tqPD5TzNXa4g=;
	b=IRXQAY8i5u5H3G0pEHAgIlBooeneGbOUR0SHLVdD7vlW1S3L2eB9ph9FXzRVVrKWnZTE+G
	fhCunBPiXPk8ejBEHBEQ2uq0dJN7FXf04PifvhPZsK9B7qMHek7ABXDl8dg4RDbG3xsWKq
	h/eea0gbYTTFW7vlcIFBoUSlS0YRQa0CdOaWYO8ddcZHhG0USmcgDr3JIsMAbGs31d7E90
	vPSwYSgFqCxom/DKvX6jgmLY8n83UPV0EgbSsjd8fKjOi/X8V2xy8H4ACUpmDVWIvR66pJ
	NSbsN6Xu5k8ggMMtWVlfqwEPcnGODO+L0vY48V26wVG/Aqn6Z9Ne8WkqeNhsQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cpEnzyvYl+YaVf9FbH6u/ZTNCFgglA8tqPD5TzNXa4g=;
	b=HWmw9Z71jW4Ide4RbHzhgnJE9N2UmiLH3ab9yWM7XZcnwM82VMVdofO/Chd7raYj5Oo0Ou
	iOlD+/JFzznXBoBg==
To: Herve Codina <herve.codina@bootlin.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Herve Codina <herve.codina@bootlin.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-um@lists.infradead.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 00/23] Introduce irq_domain_instanciate()
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
Date: Mon, 17 Jun 2024 15:57:44 +0200
Message-ID: <87msnju0x3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Herve!

On Fri, Jun 14 2024 at 19:32, Herve Codina wrote:
> During the review, it was asked to rework the irq domain modification in
> order to avoid more wrappers and a new irq_domain_instanciate() function
> was proposed [2].
>
> Also a patch [3] sent by Maitti Vaittinen can benefit of this new
> irq_domain_instanciate() function. Even if Maitti's use case is not
> handle yet in this series, it should not be a big deal add support for
> it on top of this current series.
>
> So, this current series introduces this new irq_domain_instanciate()
> function and migrate existing wrappers and functions to this new
> function (patches 1 to 20).
>
> It then introduces the first driver that uses directly this new function
> with the init()/exit() hooks set: the Microchip LAN966x OIC driver
> (patches 21 to 23).
>
> Existing irqchip drivers are not converted yet to use this new API
> function in the same way as the LAN966x OIC driver does.
> I prefer to have this series accepted first to avoid doing and re-doing
> several times the same modifications on existing drivers depending on
> changes requested on this current series review.

I'm truly impressed by the quality of this patch set.

The only nitpicks I found was the formatting of the struct
initializers. I fixed them up for you this time. Keep up the good work!

The result can be found at:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core

Matti, can you please build your extensions on top of that?

Thanks,

        tglx


