Return-Path: <linux-kernel+bounces-206951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB78F901069
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 10:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DD7B21CEE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 08:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0D9176FB0;
	Sat,  8 Jun 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdMFvMPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F7167DB2;
	Sat,  8 Jun 2024 08:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836093; cv=none; b=BHmo5ZomKTgkUHPYpdLS2Jcc/2TAJC1Nxl5v04oqbOV/CxjoABGOxL7tPJxfVHLv9og9AwFBoGHw5haJk64+0BUHAytNavacIa9DWJ+OrltAvq7gRQr9IbzcH4Wz5vTTgQRlDrIWWrTR3jrBEPHK04D+JvTfxe78SKzP7XzsM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836093; c=relaxed/simple;
	bh=N11CMXGnF9ARu0XlXSqTeYCla3Hy4gfRhSY5hCeaGbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK643ugySvsSC8AO5rre4oV4v2gelW0CrJdn7/gQiEzyjRJXV4WLEnajQEpwhGIA94swHU5YtzXsrak/Qf39DlHM8OnPUuRhG9kjooDV5edf1PW2B373ivqDofcPiWvalomInUmRvAj7dsrJx47hwLchhVW9+BN2oUtyKGgL0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdMFvMPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B259CC2BD11;
	Sat,  8 Jun 2024 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717836092;
	bh=N11CMXGnF9ARu0XlXSqTeYCla3Hy4gfRhSY5hCeaGbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdMFvMPI6CK5AyfIJYC+od03cUXnjZTb8JE7+CZImm04kVDGo8K/DKn4bos4Q56Xt
	 quDCXQbD29svdiBXk5+/sX4Z6umuu06/9GaTgPkGbXgpxLPyiTPCDBqSF2kYnkcmZC
	 GPdYd9WRR/5IEQiE3Ah5og81QobtQMlmHWwQo7T9ktpMsMOP3bPUPCWzKvsBv5qAwB
	 AXj9VXVrBc4yEIVb+wLigWrS5JafVszrvJXCywRcGL22UZ9TcSjs5gfDSDs74/NURQ
	 3YXkBOqr2Bf8ybpWLucz42OD81EclEjbhO+4XiSQSc1PViJaIgsxDMK/AYql56GE71
	 MllNIZOO/m3Tg==
Date: Sat, 8 Jun 2024 09:41:28 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, sbhatta@marvell.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] ip_tunnel: Move stats allocation to core
Message-ID: <20240608084128.GJ27689@kernel.org>
References: <20240607084420.3932875-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607084420.3932875-1-leitao@debian.org>

On Fri, Jun 07, 2024 at 01:44:19AM -0700, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core instead
> of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Move ip_tunnel driver to leverage the core allocation.
> 
> All the ip_tunnel_init() users call ip_tunnel_init() as part of their
> .ndo_init callback. The .ndo_init callback is called before the stats
> allocation in netdev_register(), thus, the allocation will happen before
> the netdev is visible.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


