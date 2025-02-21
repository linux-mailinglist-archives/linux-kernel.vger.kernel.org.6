Return-Path: <linux-kernel+bounces-526591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D0AA400B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B169319E163A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B55253352;
	Fri, 21 Feb 2025 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKipNSvy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A71DED6F;
	Fri, 21 Feb 2025 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169388; cv=none; b=CQHQrmozgWyBgXzLEUhRLNZ5iCAoaSBWGtko8GY0Y8qhg+sjFKhRZN7cSr1/vLM5oyPGGry7f5MqS8BCTBSHr0vy1NHmwYf9CSTUomuwQwdkukrZmf+F5FQLEvyj80ylsLpwjrdmLhyj3LPFjmwYfkWKzkGQWZ6KPFv1mSRpQDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169388; c=relaxed/simple;
	bh=5UVbj5X1SwTrcgQ04/E/Vjuw1gEEFd1mtvfu98G7pP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOGX2ZfhEYIs0Oc1TgDqNMFGE30/uGNaV/qRbbSGALiT1FCubjZZ98vauTALtDq6vOB8j+02wIZ3E7Npi0G9EgFYFwgAmPwCDMg2GppAx/2GEXQADtb2Kb0k+ekxklasWTy0xLPi2jCgjiLcMiClP9LMy9lq7xHWydshY8tw4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKipNSvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BF5C4CED6;
	Fri, 21 Feb 2025 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740169388;
	bh=5UVbj5X1SwTrcgQ04/E/Vjuw1gEEFd1mtvfu98G7pP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKipNSvyRoqaiJEQQVdtuW2AuP8Gtg+YGmA/ltmU/kwkJpBrXWQwFVjkcfmzcZZ5A
	 BgvOr4bvVEbc1nbPPgAk8FrnlQ3ubyfdp07T4T+DnW8idjf+SVtHGGwoCRBZ2ITw6W
	 7NYKya7fYrXcylmmxGhCoQMFLfQcWSWqDAIMvhw1eifBkXVzWlrE2bMNAbDwx9TTuQ
	 kl1q+ugWFAwuyQ5mMwmYljWFu0F2/kAqPWwSW7HBxtaKywExII7oyQhO0561SZ9Deb
	 xrx6eVePUIVYiXYiBY4SBQHo3bzrmpMUKGiyK4M/Pi9Dl1acaSE9zYqDoIrByOIu4O
	 ZYqLs5cOk7fkg==
Date: Fri, 21 Feb 2025 14:23:06 -0600
From: Rob Herring <robh@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH RFC 4/5] clk: bcm21664: Add matching bus clocks for
 peripheral clocks
Message-ID: <20250221202306.GA15720-robh@kernel.org>
References: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
 <20250216-kona-bus-clock-v1-4-e8779d77a6f2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216-kona-bus-clock-v1-4-e8779d77a6f2@gmail.com>

On Sun, Feb 16, 2025 at 05:12:39PM +0100, Artur Weber wrote:
> Now that bus clock support has been implemented into the Broadcom Kona
> clock driver, add bus clocks corresponding to HUB_TIMER, SDIO, UART and
> BSC, as well as the USB OTG bus clock.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  drivers/clk/bcm/clk-bcm21664.c       | 107 +++++++++++++++++++++++++++++++----
>  include/dt-bindings/clock/bcm21664.h |  19 ++++++-

This is part of the binding, so it goes in the binding patch or on its 
own.

Rob

