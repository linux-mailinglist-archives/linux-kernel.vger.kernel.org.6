Return-Path: <linux-kernel+bounces-530123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A740A42F67
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937963B1283
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5741A1DDC37;
	Mon, 24 Feb 2025 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIB7i5RP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F63594C;
	Mon, 24 Feb 2025 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433524; cv=none; b=bCx0BofVNxbq3CqqR9/f+cELaBtboQehZUeGD/BQvEx3le5eBH/z77QYlMqib0qK+9t3Y252jZuFEJpd5Pfp8LXVnsYInTMlkHIi5EXMyDsdZYoHcWnIzQu5PeVq71afBLxfk0LR2H46wrI3dmR+craWS7U1rFoY+grcXqCPoIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433524; c=relaxed/simple;
	bh=iU6990wlaBJJjMr2f7k4zDhaWpcZuf267xoOSP2xCXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebXE2DgOSqFGRe7wffuSkN4GwSgSV47C9o5u6EoLULKn+1F99Pinv+5dCi1JSuRf6RNMvi6oRXzcdJCJvGsJuT2HiRKF8mponmVhSQzlimc18d3bofo+Jc5md57s1M9k1MtRe60q6GBLz++0JbeJY4TFevprhneD5lV2hanVTWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIB7i5RP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539BBC4CED6;
	Mon, 24 Feb 2025 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740433524;
	bh=iU6990wlaBJJjMr2f7k4zDhaWpcZuf267xoOSP2xCXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cIB7i5RPAUqejYq0sQFEv3FZ3ys8Y59jbT2Ai+7PtJHLEAKK0RhzRAGUtVZottdEM
	 h0YSvFWD4WcvecIlmZBknnM3E8SicNiiTpQGJx5uGgdyj349Ls9jS+g8fi35LsYXdz
	 85p9uUSPDWcb62QtOHej6/TLls/4rXL6Rwm3E344DtD0d8Sz4i1WQmusDpzNMsiUaV
	 hqGUjSqW+tulEByCm0rdYOxQiRCwDbNeo30bnV00PjPc2gCVOPipJvRzh+n8s4pY50
	 GpEV5GSkVedPLYcqU7NOKjifltPK3ZtN7cl4XkXqbcrG2n3FTq7SlnucbDyLitLgOT
	 P9AnkoO3oD9RA==
Date: Mon, 24 Feb 2025 13:45:22 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250224134522.1cc36aa3@kernel.org>
In-Reply-To: <20250224141037.1c79122b@kmaincent-XPS-13-7390>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-6-3da486e5fd64@bootlin.com>
	<20250220165129.6f72f51a@kernel.org>
	<20250224141037.1c79122b@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 14:10:37 +0100 Kory Maincent wrote:
> > The "methods" can be mixed for ports in a single "domain" ?  
> 
> No they can't for now. Even different PSE power domains within the same PSE
> controller. I will make it explicit.

Sounds like the property is placed at the wrong level of the hierarchy,
then.

