Return-Path: <linux-kernel+bounces-524534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6BA3E437
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207A44213CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D4426388E;
	Thu, 20 Feb 2025 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJWge50s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB62214215;
	Thu, 20 Feb 2025 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077418; cv=none; b=FBunq5O7cx7ZpNz70glxWtlB48TAdb/UqggCrgCvN6DP/qC+Z1aRd3+SsEmLK0sxryl3sUhAQKdyMZQsqGHBDBSX/jT7fo86sPFsGOOruSeVe8Sg8ElVkmrW8ngi+7uQSZ9G1r/OrmVFIMU3XVCJTr4pj0Im0EQ+qlkApe/92Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077418; c=relaxed/simple;
	bh=SK4Zico4JQV0LnYa0MLMIEVt+yiCjL0RV5gb4xvU9v8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5eYnsd6n72ALgLh7AJ1u63oZj/oqPeDDRyegzCbWkehGHUDz+y1jkdNRyCXn3GLdH3KPCI3wxbE+0wxVZvBBW86wtfWEkMq3F0gJSfc0xDy9UZfnw4auJVfztyiJzlqlLg5tFzCqVWsqyLX5/vV6EC3JX4xhEXdMMxvh2R7TAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJWge50s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77435C4CED1;
	Thu, 20 Feb 2025 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740077415;
	bh=SK4Zico4JQV0LnYa0MLMIEVt+yiCjL0RV5gb4xvU9v8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WJWge50s1GZ7yR3iuF0QzH3F023MlHKpNKjjwq1g4s9QGkQbpQHunJHV/SXQ4YzZS
	 1+GNGF83CL6WoG0xlcIBiDPTuzd6DNdn6T5DO3NxKBmz3Teo0xURHWvEsBN6szOtUF
	 daWGQ5f/HXbI9DJbY3v3YmFY3Ht2TQUKyUKmZDiihlX+9+QRdkvY2zkXHEK0LS3wBE
	 d22QOvPTYC3LT+lCX14/SZTU3WdBE+n+bmJyMc7B9XjPf+jv+9i3YiywkEN8fqdUic
	 kKZbO2kaCtSv/paEHC7dbA+VFZUABzUsq3LztsIMu95W+Xm0VfU6JOm9c/VCNMaHdK
	 0wCUWCaQ9EOFQ==
Date: Thu, 20 Feb 2025 10:50:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: patchwork-bot+netdevbpf@kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: cadence: macb: Modernize statistics
 reporting (manual merge)
Message-ID: <20250220105014.736e21a6@kernel.org>
In-Reply-To: <f3de1e79-9732-451c-a973-e94e27703a65@linux.dev>
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
	<173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
	<12896f89-e99c-4bbc-94c1-fac89883bd92@linux.dev>
	<20250220085945.14961e28@kernel.org>
	<561bc925-d9ad-4fe3-8a4e-18489261e531@linux.dev>
	<20250220101823.20516a77@kernel.org>
	<1510cd3c-b986-4da2-aaa3-0214e4f43fe6@linux.dev>
	<20250220103223.5f2c0c58@kernel.org>
	<f3de1e79-9732-451c-a973-e94e27703a65@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 13:42:25 -0500 Sean Anderson wrote:
> On 2/20/25 13:32, Jakub Kicinski wrote:
> > On Thu, 20 Feb 2025 13:22:29 -0500 Sean Anderson wrote:  
> >> OK, what's the best way to create that? git rerere?  
> > 
> > rerere image or a three way diff will work  
> 
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

That should work, thanks!

