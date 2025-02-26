Return-Path: <linux-kernel+bounces-534527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9676A46800
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4971118862A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08B02253A4;
	Wed, 26 Feb 2025 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SwhdyW2b"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2133221701
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590700; cv=none; b=TZ2I9p2kLwZVz1/qm8nD60bzy0KHSBan0t1Gb4Z9jHwlFxrzTpTbhiFj7jKlA1CxyVDl1WSYr1fo9BCuPOHiwmT/WrI/my9bwXI27H70DHq3hmSxsZt4+knzoSMoqh+YWgirAYKkXsGoxy9hklqfAQbLnSFda9XvkFcoB/JRFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590700; c=relaxed/simple;
	bh=j1AhO4uRLIvoKyVMs6jyRJ3dcn3pXHKKN2bKg/SL96g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=an3Py/YbhAnodAUdJarn5kwYbFXuJqkwcxTwvAUlOWiPzK475EcpZ9JNnqAeo6fQJdjIjnncys+xIbjyQ8rD3jSpl+TStp0eop03WLw71VlhYGqjDXK0X7gKF8SQWdWNe1iGtgEFVl6qvOrB4gSXSxI+n28eHdKf709/P9fvbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SwhdyW2b; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35543443FD;
	Wed, 26 Feb 2025 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740590690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjI2DTiQMlxYIRwQH9QR/Cwawyd3pO3A4ovumf0p0Ys=;
	b=SwhdyW2b5K5TWoop/kt3UewfglCdpJoJpl5wr3C5G3TDZD9QFVAvfOsKUPYGlddnhyUbe2
	KpOa9ApSOwxH9BQZnXGKeizn2nXiLjjR0++5eFAOZfesDIejdTMlJcYH6OtDqSCDs0oZWn
	AQfISdyJeUvfTkp4ndXf47y7Mbm6RsNUsbvI9DP1nJLCmj+E3hbuidMhcf/u9K1yflxx2A
	HzhXb+SLCvKa1y9V+1d2owClg409Jj4h7feXSfuvDd5mnhfpeiLldvXoYM654c5P9R4b4Y
	b0t2Ud4P9B6jAGggC3SgR9muV5LE5wGFVNz7heNSF/rGKSQRpTF4GP6QGwIFKA==
Date: Wed, 26 Feb 2025 18:24:49 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Horatiu Vultur
 <horatiu.vultur@microchip.com>
Cc: Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] reset: mchp: sparx5: Fix for lan966x
Message-ID: <20250226182449.61a126ea@bootlin.com>
In-Reply-To: <5cc5cd05e0a481773212fff0bce574dcfea3f74d.camel@pengutronix.de>
References: <20250226144645.1950451-1-horatiu.vultur@microchip.com>
	<5cc5cd05e0a481773212fff0bce574dcfea3f74d.camel@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekhedujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthekredtredtjeenucfhrhhomhepjfgvrhhvvgcuvehoughinhgruceohhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeviefffeegiedtleelieeghfejleeuueevkeevteegffehledtkeegudeigffgvdenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehprdiirggsvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehhohhrrghtihhurdhvuhhlthhurhesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopefuthgvvghnrdfjvghgvghluhhnugesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhop
 egurghnihgvlhdrmhgrtghhohhnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepfgfpiffnihhnuhigffhrihhvvghrsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: herve.codina@bootlin.com

Hi Philipp, Horatiu,

On Wed, 26 Feb 2025 17:32:22 +0100
Philipp Zabel <p.zabel@pengutronix.de> wrote:

...

> > Fixes: 0426a920d6269c ("reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x")
> > Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> > Tested-by: Herve Codina <herve.codina@bootlin.com>  
> 
> Is this still correct?

Yes, it is correct.

Reviewed this v3, saw Philipp's comments and I have nothing more to add.

Also tested this v3 and no regression were detected.

Best regards,
Hervé

