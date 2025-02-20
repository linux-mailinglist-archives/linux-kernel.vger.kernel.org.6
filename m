Return-Path: <linux-kernel+bounces-524810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF7A3E76B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B3F19C3CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD74264624;
	Thu, 20 Feb 2025 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HXwlGTfl"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F4213E7C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090058; cv=none; b=ER3Vv8zVRebJO7VYVTV7w37z4iDw7h9s8Xx9SkUj7eV2c2XIOw7Ml4WPy5vdQw8C8d9wu6QQFCyLIs/OEzlZwSlpiG13uMt18F7SztT20qwjfCqdsiVU5WynRRPuOM2u7NKbtRvnCU3sV33M+VJyoi3co6Cb56aDW4zH4IN36UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090058; c=relaxed/simple;
	bh=1DSkzqSj3AIzvFLMcIq8rSXAYhwHlidlZp3mBjFvf9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6zCsYbDG6rDH51RGiuu3vQLY7VldPN5FgUo59hmTFDVZQtqK4CEwEqIczbmmzB4Xu6tQif7oG1BYJ1AsbdVcJzg74sZEYRNUXbv7/uZ0WzG6Fzz2R4oRoOvoeE+VGjguFDfeo0CNRzKPnukiXjj0NdXFflcDaLih6pFW9gmANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HXwlGTfl; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D65864431D;
	Thu, 20 Feb 2025 22:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740090055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X3LtfwD9Pn+Yvmkz2n0LKCzfssZAUMxpskFJUZ2RaJo=;
	b=HXwlGTfls/SK3S7ZVZTiUfOSL3GfSpUNkHkNt9WId5AtxQQHyrfRVYv+4vS8kZxJ5cBCu9
	gZ4O7HiR6vjMoiyfCxzuAtREnXdgdSun3nCQCwqRS36DmqDdKF6MY9NQWGIw1kDyfzUDwm
	qEjMAXtMcJhKA0vMabxWE896XtnTKIlM1WpVM9j7qFhLI4pPKYXKVoIUdnFtTUM5aErRwV
	bCFsPe5sT39mHEF8E5goMASj/teoxqOOO/UJMLZRjVwYWZuMuKOYGKY85F8vDpcsbR9RNy
	qhr3eHIYqAc/m7zkiXRFiG0jivZbF1jQg3TVjQikmKhh0kYKzrnzrYAlRvCd6A==
Date: Thu, 20 Feb 2025 23:20:54 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: master: svc: Flush FIFO before sending Dynamic
 Address Assignment(DAA)
Message-ID: <174009003834.598401.3147547459483423784.b4-ty@bootlin.com>
References: <20250129162250.3629189-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129162250.3629189-1-Frank.Li@nxp.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeikeeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemvdgumeeifeejtdemjeekvgdtmegttdgvkeemvdektdeimeekrggtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdgumeeifeejtdemjeekvgdtmegttdgvkeemvdektdeimeekrggtiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqiheftgeslhhishhtshdrihhnfhhrrgguv
 ggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopefhrhgrnhhkrdfnihesnhigphdrtghomhdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghv
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 29 Jan 2025 11:22:50 -0500, Frank Li wrote:
> Ensure the FIFO is empty before issuing the DAA command to prevent
> incorrect command data from being sent. Align with other data transfers,
> such as svc_i3c_master_start_xfer_locked(), which flushes the FIFO before
> sending a command.
> 
> 

Applied, thanks!

[1/1] i3c: master: svc: Flush FIFO before sending Dynamic Address Assignment(DAA)
      https://git.kernel.org/abelloni/c/a892ee4cf22a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

