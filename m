Return-Path: <linux-kernel+bounces-175780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B508C24E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49BB285467
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5416DED7;
	Fri, 10 May 2024 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHecGKTj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B8DDD4;
	Fri, 10 May 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344190; cv=none; b=BKVWbU6PsQhQ8LZTYwl8CqCQ+ya6Z0klRWP490qQVxdJQ9xFTsWM0wtzadlv9HtC/lkumM2QNjKz1vH1Iz8bck11qAEl9uGV3QA41U0Nbtt31uyXRy3a3pjnN4MHhQb76RK5hckTol1hJ0SXZhM0xeB+KBzhZrdWiDhz2HTfB4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344190; c=relaxed/simple;
	bh=AFBlIuazUanvtZ5KZTaWmtND9t+BwojILZ/jfxE+nT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlkO9XbzbvDb8ANwt2a7TB3M9b4vxohE44kFevgplITSgAmjtg9/jgM2MFG26iQ3kjaUC4b54oxAQhlID6ePtNN7z7JszTRAIsx03D70XXyCQN1oKj8gio1YMJPGc7oyi458A7rDStmM6tHPZoesm/eXdK9k1qegEbd9U77+WJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHecGKTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB653C113CC;
	Fri, 10 May 2024 12:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715344190;
	bh=AFBlIuazUanvtZ5KZTaWmtND9t+BwojILZ/jfxE+nT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHecGKTj4vT2yO3Q41kONu7DsXxyztXZMhic0K20PSeE+zkFqkN+vKbISWKV9O0KO
	 920S3JqEd6lP3ZOgGX3Ft1AzLJ61J6v6QXEpliE75CT13F8Q50dzsvD4HAMdu24ktg
	 ShERuY+GMhEM5Ex+d3HfV409nI5HPECZtr+0SBXjeFcjE4OIB9h+BKL3EXBYeUY46M
	 60pP+ZDSRZDPDfbeqxXcKdj0jxHdpn5y8gqj9AJ2REgEBhZsBYTH9jRj5vbEkhIWdU
	 37+GWvfn8Xz1zbt6bwYMKUiEQalS4Mrhi8hwLgl+Egqe/oegqWcvVxs5I5tkIPr+tE
	 yDLGU93crqgrQ==
Date: Fri, 10 May 2024 13:29:42 +0100
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v3 3/3] net: dsa: microchip: dcb: set default
 apptrust to PCP only
Message-ID: <20240510122942.GX2347895@kernel.org>
References: <20240510053828.2412516-1-o.rempel@pengutronix.de>
 <20240510053828.2412516-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510053828.2412516-4-o.rempel@pengutronix.de>

On Fri, May 10, 2024 at 07:38:28AM +0200, Oleksij Rempel wrote:
> Before DCB support, the KSZ driver had only PCP as source of packet
> priority values. To avoid regressions, make PCP only as default value.
> User will need enable DSCP support manually.
> 
> This patch do not affect other KSZ8 related quirks. User will still be
> warned by setting not support configurations for the port 2.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>

Reviewed-by: Simon Horman <horms@kernel.org>


