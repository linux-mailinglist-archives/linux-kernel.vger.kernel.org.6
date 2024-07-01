Return-Path: <linux-kernel+bounces-236071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F3991DD18
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C832833DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562911411DF;
	Mon,  1 Jul 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWY9mvgW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B05F12D747;
	Mon,  1 Jul 2024 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831075; cv=none; b=ilgXTW7zfZ4iMgeBslybLjvULO4ERT0e7+/ZxoZeLQeanIDNERmXMT+rl5esqb+NiymR8kcCzgLIcm15bKuHiLK0F3hfHDlJy7PRdw8hy8rNQLWaN6QqrHJdu3qAaokJTKsDznkcw6u12V0Ze/54uDihEC/ZUhLfRU9I6PYMA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831075; c=relaxed/simple;
	bh=3ACX45KsJMwpKd54e+tqOBQlYxjLoHnDp4uXcuq4jD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRU7PnMEhWGCf8Z3EpBJhr4PfJ9MXay1HfxJa8SDWsRrKpZIJ6LTfLpwCmn8rgPs0MKVnT+g92kNBhE/9pWxotOwKWCfi5xTpXSHrWLMsvnE/YVy0Ghfw+Xt/0AJ+B5DKBWXXqFpLzFWrnjRvk/vSwh+ruyaxqGifVcsjbydfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWY9mvgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E6A7C116B1;
	Mon,  1 Jul 2024 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719831075;
	bh=3ACX45KsJMwpKd54e+tqOBQlYxjLoHnDp4uXcuq4jD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UWY9mvgW01eYPwJ/gpSqwrPa32E5ePUV2Bkpp2U4DG93r+q89B1Ess9OTRkloxL9g
	 I7T87r9t+m8B31WxA5+j6WS8fAvHaYGZSNfiGa1cxLBxmZ4PEy4gDYTUVmDIk7zzXn
	 6RxLx8lGcPaK44gvCPFqUehjI0ylMZuuJIGAYfEfHWYFQPcKsPc1+ndy69gmiqL4u0
	 vWrqGfhV+jllQBuNpsphBFZMZcAWzyjgvABaBibrvMKNaKLbCmkCGrOT6FnqmSewNV
	 81E78nYswYLUX22TLO5F5gy/s0M6eo32R4vkQGiQvNw3C5eGvVyOBH7SPa6hdoDtxu
	 GODqqV7m/z8sg==
Date: Mon, 1 Jul 2024 11:51:11 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v7 09/10] octeontx2-pf: Add representors for sdp
 MAC
Message-ID: <20240701105111.GU17134@kernel.org>
References: <20240628133517.8591-1-gakula@marvell.com>
 <20240628133517.8591-10-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628133517.8591-10-gakula@marvell.com>

On Fri, Jun 28, 2024 at 07:05:16PM +0530, Geetha sowjanya wrote:
> Hardware supports different types of MACs eg RPM, SDP, LBK.
> LBK is for internal Tx->Rx HW loopback path. RPM and SDP MACs support
> ingress/egress pkt IO on interfaces with different set of capabilities
> like interface modes. At the time of netdev driver registration PF will
> seek MAC related information from Admin function driver
> 'drivers/net/ethernet/marvell/octeontx2/af' and sets up ingress/egress
> queues etc such that pkt IO on the channels of these different MACs is
> possible. This patch add representors for SDP MAC.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


