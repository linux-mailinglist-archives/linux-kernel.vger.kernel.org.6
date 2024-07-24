Return-Path: <linux-kernel+bounces-261405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBA893B6E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2F6281488
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD9316B3B8;
	Wed, 24 Jul 2024 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecjaigUx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6661591F3;
	Wed, 24 Jul 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846405; cv=none; b=GgLcByVcBM3uD8O7YLKP4eoDP/ATTuznEr9VK4IG3YQnPQHuCFPxPi6BricQswdYOOYilmMBeYFf7zdKs0la84aRAKzNnPmp5PQTZcGIS+qUvd6nGPCy6WUSNYDVbPIXEw2XvpcPsx4QparUe4hlb5PZqFMSkHNUin8CPQXFtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846405; c=relaxed/simple;
	bh=565KS7O26irjkXREQVOn6f2CuwjZIq4/S/bt/80KYUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pntzTe6oVz/9E46Kg9hIFCK7GCPn6Fd30yA1gi4dV7zjBZ9NtgemKgOddLbkdPI6aCPwfx5ePzEjn7ZITa1Mzh2UiK8mIV0wVOUkZ7t6K6DFpqaIGDMxVZn5S+0KCOGHlxr939lOOrJvoaAccDkjRb0qARPrbsrh1DzjgBuBcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecjaigUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4323C32781;
	Wed, 24 Jul 2024 18:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721846405;
	bh=565KS7O26irjkXREQVOn6f2CuwjZIq4/S/bt/80KYUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecjaigUx8IkNY4P4NYzL8HgLtgMwW5e0YpI1Iy7G5JdKH3FWzQTvtI8fHe98jX8KG
	 XS1enFIzaU/hSa9HfQ6dlkXvGslnN7dlnDfZHjvk1hNJhlLzQjDd4V7asdnU6ic4fL
	 4ndV9nlrYC2g0Gk8H7ABwYJbh12s+GOj1a1iPKdvD2tbef+MGaUSLWrRoQOmsxKYN1
	 r5wb05qOyEkAk3wXy4AkkwPFxjVDNaxBx1SGhJ8/WIvOEzy9EDyaAo6DZCGyQPN6b8
	 1JmzgeptdlyY36UvqvSX2C1cl9oFaTgfrVkTkJx9uzs9k4EHVwRLApjZneBM3FxoRB
	 WiejuQ81NT/ew==
Date: Wed, 24 Jul 2024 19:40:01 +0100
From: Simon Horman <horms@kernel.org>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] macvlan: Return error on
 register_netdevice_notifier() failure
Message-ID: <20240724184001.GG97837@kernel.org>
References: <20240724135622.1797145-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724135622.1797145-1-syoshida@redhat.com>

On Wed, Jul 24, 2024 at 10:56:22PM +0900, Shigeru Yoshida wrote:
> register_netdevice_notifier() may fail, but macvlan_init_module() does
> not handle the failure.  Handle the failure by returning an error.
> 
> Fixes: b863ceb7ddce ("[NET]: Add macvlan driver")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


