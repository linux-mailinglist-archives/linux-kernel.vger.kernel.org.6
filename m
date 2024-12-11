Return-Path: <linux-kernel+bounces-440658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CE89EC289
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB99B188ABE3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858671FC7F5;
	Wed, 11 Dec 2024 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewHkhgOU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFADA2451F9;
	Wed, 11 Dec 2024 02:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885572; cv=none; b=N5exLmeKt7HjrF5oyi2XUV8Rc8D8qMWYesJg88Xg4dycABKj3DmZQ5e2sj0nKDR7sff15CE8Uc4S3TyWM1JMABjAQR6+Cw+l7Ix0xo/3GpLL5dDy7SMuVDRrsGGC72l9nmiaKeLCwOHqSkcMrCQHKhY5IKoJTgDGvDNYZSKgloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885572; c=relaxed/simple;
	bh=xFrm2hF6CkNrfHRfEXGsU9ik3i3VJPSSCmlSzceltdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezJhHB2uYWem8fYoAMnTwFCjwJBRxa74E0rv7tqPIR2cyC3ELnE61EkGqfcRxob05Se3Lj9bahuo1GjSt82ZRmrTLVodpI0zXGRqg/ucINOQ/21krh7F/YApzQphriHaJTpJKq0cpFKXUGgWjRJjqVOriYB3/U70HGwkZAAYBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewHkhgOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF468C4CED6;
	Wed, 11 Dec 2024 02:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733885571;
	bh=xFrm2hF6CkNrfHRfEXGsU9ik3i3VJPSSCmlSzceltdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ewHkhgOUGlCpBev4lAFUHT0JzC4l6p1px6l3oa6OVZMayn58OSMc5y63teRVmFd9o
	 ozAIYCKSpMC/NDWSCdwurJeJOYqaDnQZ9dxFmyTZr/X97nnhMOXy97DcGfM4wLnHiL
	 sGsHOSPDLhjbkQ7VQAGv56Dv+TGtoEAXptu2NNNrmHX9AIA7v0jC38jXfC5jlLxAeU
	 yKnsbZdfaQazZw196Lp1/1t/tOs21YTjKIN/iqfF4/FwV/t3AY+A1srHpEg1v+IkdU
	 PlhjzLhmJQl6Svym3BGUOo0SkPfpqKFLDNhCBDZF1B56/1IOmyqdsLtsiHld1YWJQ7
	 m336hzA0pJDBw==
Date: Tue, 10 Dec 2024 18:52:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
 <woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, Phil Elwell
 <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 00/11] lan78xx: Preparations for PHYlink
Message-ID: <20241210185250.348e4cbc@kernel.org>
In-Reply-To: <20241209130751.703182-1-o.rempel@pengutronix.de>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 14:07:40 +0100 Oleksij Rempel wrote:
> This patch set is a second part of the preparatory work for migrating
> the lan78xx USB Ethernet driver to the PHYlink framework. During
> extensive testing, I observed that resetting the USB adapter can lead to
> various read/write errors. While the errors themselves are acceptable,
> they generate excessive log messages, resulting in significant log spam.
> This set improves error handling to reduce logging noise by addressing
> errors directly and returning early when necessary.

These look independent so let me apply most...

