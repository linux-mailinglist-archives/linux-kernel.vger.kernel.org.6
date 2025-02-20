Return-Path: <linux-kernel+bounces-524797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02824A3E73F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552BC188924E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420461F03F2;
	Thu, 20 Feb 2025 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nG2X6ttG"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D213AF2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740089350; cv=none; b=sKxyzxaO1DEc5mwvhr2KQlrbKsvw9DL6gk8dMccppDmKLicnBQaxQn1rFJ+TXFweQ1fpkUz+A2QLbe/Zra7AWeRdb3x0FmcEokEe3ZaFIgdkHNnyyWGvdah7KjSeobhUBYhfyRkqrc+x2ky7dEc7zhNaABv1/AC0kY5uW1BH/F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740089350; c=relaxed/simple;
	bh=qg39igZdoWLj9KAR0AXDyRMEiq/TTYiIhy593yjnU18=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONMJsp8jFFYbgFDBZd8oFzxcTK+p13yxBH3PsN8dzrarpp1z34KmTseMMYLul8fqxI+MNLbqKT+5hJKuj9DgaTx0m+sLga3+n4/B3urC9UQBejkU0qsXHt4fx6p3bP4e8s+bEAN8nzBolW7dwwTtyn6y9+SpKNB5Qa1bqc5mScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nG2X6ttG; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE6F14432B;
	Thu, 20 Feb 2025 22:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740089345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=prYd9WYZKRHGS7LV54FbDr3RFy3sG6mO4TKryM0mPTE=;
	b=nG2X6ttG2gFqoWgw90E+46IJ6zyYa0GDlWpG35te7uJGnK/ygE2fjZnQ9w0pWHKZrBfMgJ
	grYczvgO7TsnAsMX4nLrWsYPDNg3uPcW0g6GIoSaFpvaVSvdfaWdoDGsIP9qU5uHLqaWZU
	sjtIgmrWH0znlyhOYO4ckXyT8ayEkh/ZmMJbzWH4Z49I7HioVsfV1NI1Dhao4SLmoVvASi
	XfbJfhU7IrMdsWcOHyQjEupLXMDc3cdbHLBiezMZxcPkB+2I/csnA8MQ4JcjnUUlVspr9N
	FJ7+mquFpTjLBpVWLS+Ewe9cwR0nz2tG709MhWSZaE4B5A/xmDzTv9IGo8OIzQ==
Date: Thu, 20 Feb 2025 23:09:01 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: pgaj@cadence.com, miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
	aniketmaurya@google.com, Shyam-sundar.S-k@amd.com,
	jarkko.nikula@linux.intel.com, wsa+renesas@sang-engineering.com,
	xiaopei01@kylinos.cn, Guruvendra.Punugupati@amd.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	BMC-SW@aspeedtech.com, Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH v2 1/2] i3c: Remove the const qualifier from i2c_msg
 pointer in i2c_xfers API
Message-ID: <174008931866.597348.5955807457393482145.b4-ty@bootlin.com>
References: <20250204091702.4014466-1-billy_tsai@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204091702.4014466-1-billy_tsai@aspeedtech.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeikedvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuddtgfehteevtedvteelleefffekhfdthfelgeefueelgeeuueeggfehheelvdegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehpghgrjhestggruggvnhgtvgdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhto
 heptghonhhorhdrtghulhhhrghnvgesshhilhhvrggtohdrtghomhdprhgtphhtthhopegrnhhikhgvthhmrghurhihrgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepufhhhigrmhdqshhunhgurghrrdfuqdhksegrmhgurdgtohhmpdhrtghpthhtohepjhgrrhhkkhhordhnihhkuhhlrgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeifshgrodhrvghnvghsrghssehsrghnghdqvghnghhinhgvvghrihhnghdrtghomhdprhgtphhtthhopeigihgrohhpvghitddusehkhihlihhnohhsrdgtnh
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 04 Feb 2025 17:17:01 +0800, Billy Tsai wrote:
> The change is necessary to enable the use of the
> `i2c_get_dma_safe_msg_buf()` API, which requires a non-const
> `struct i2c_msg *` to operate. The `i2c_get_dma_safe_msg_buf()` function
> ensures safe handling of I2C messages when using DMA, making it essential
> for scenarios where DMA transfers are involved. By removing the `const`
> qualifier, this patch allows drivers to prepare and manage DMA-safe
> buffers directly.
> 
> [...]

Applied, thanks!

[1/2] i3c: Remove the const qualifier from i2c_msg pointer in i2c_xfers API
      https://git.kernel.org/abelloni/c/6866c91f8c23
[2/2] i3c: mipi-i3c-hci: Use I2C DMA-safe api
      https://git.kernel.org/abelloni/c/effed5dac8f8

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

