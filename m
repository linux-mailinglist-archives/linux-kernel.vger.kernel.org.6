Return-Path: <linux-kernel+bounces-253125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE4931CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DDB1C215A6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D5813D53E;
	Mon, 15 Jul 2024 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NyFwTbqc"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C2B13CF86
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721080102; cv=none; b=nXROkmHM5oiB47PxhOQElXvwgrBsVMOrvpjQmZQyg+y1soyxksyffSECAVpk+Rvbw3/tBANRvR8TO/ty2BTnKayWcFu2AUKduMbXnX8zOvutiB1aPS979hOtBX92jP+IsLBgkQ0mac822HhpyQYa6iBAxSN0Ba4bkvTu9mGb8sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721080102; c=relaxed/simple;
	bh=ZBqo+HULYwwER+14CNXRyKt/Uy8m25IsZJT6gIRcM+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb3oJ5JcKUYSwbKyCPmyeOwK9G2hpYA/umUA9hC7ArRi8zfw+4R20UFRYurc+CqLUBK43KRK870LOnueBXliLI/PPLpM3KDMXn7KunBqbMvMI/NHy53kCnenDBqE74yepySSnX+E10bKTqR4sylAz8yM2mvozEeqrE+bx1v60uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NyFwTbqc; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7F3A40004;
	Mon, 15 Jul 2024 21:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721080091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bu60QzsM2TFLIWO0vGxknFJil2R7GrMrQFYycAY9a7c=;
	b=NyFwTbqcN2AQwDW+pQuN6pl2iS4y+CbLCREiPmgvmKuLv7V+XiCXzbJH8Z3ZNYu56A5TCu
	BkqzuSrZ2te5r74lr//ZqjLVwyo1Pd251RfYp5D209qSft6a94ZoFtKU+md+Y/bVkKNUUT
	ShKVpWrqPMDZEK6+4CgKxvtEr/W+Vf8rtZIChUJLXxr9VbAqPNRNIKRdAplQnPzccqf1kk
	ViQLLKqVMUoML2JJYY7WklI6nfKMfe+r887JN7du8YY8guCODe6FOfwooMkEq46zAgRwmT
	rGJbxmL/7axGrhIQUupsZKJLWU4wmPFsoE4C40zcbPq4j4QS1905IgYfsK308A==
Date: Mon, 15 Jul 2024 23:48:10 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
Subject: Re: [PATCH 1/1] i3c: master: svc: Improve DAA STOP handle code logic
Message-ID: <172108005328.1453338.6420836318188767994.b4-ty@bootlin.com>
References: <20240702223107.403057-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702223107.403057-1-Frank.Li@nxp.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 02 Jul 2024 18:31:07 -0400, Frank Li wrote:
> The REQUEST_PROC_DAA command behaves differently from other commands.
> Sometimes the hardware can auto emit STOP, but in other conditions, it
> cannot.
> 
> Improves the code logic to better handle these situations.
> 
> Hardware can auto emit STOP only when the following conditions are met:
> - The previous I3C device correctly returns a PID and ACKs an I3C address.
> - A NACK is received when emitting 7E to try to get the next I3C device's
> PID.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: svc: Improve DAA STOP handle code logic
      https://git.kernel.org/abelloni/c/a7809cb368b9

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

