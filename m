Return-Path: <linux-kernel+bounces-261411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1393B703
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59771C23BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE0F16B72D;
	Wed, 24 Jul 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMMjvUI8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D4222089;
	Wed, 24 Jul 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847013; cv=none; b=BBWgfWZ4baiwupzJRammqpzQzKe4PFpDGfGNC4Rq1etzLQDQY5buV+2fooi3EbiYb2O4ve1HY0FT6ao2JKJZVcOCcn1JzocVozZefu5uIz5/quaDewpKrH57Zs0+6Yy1VYMdxLPpqYSgyE39ezohVktTfAIMGAZV9c28uHsNd48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847013; c=relaxed/simple;
	bh=YM6uAcYcUTmEs9sx5YeWtzGmC+FZL1c6liKeC0Q2yVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i//mOgY8mGPx7xeKspRNNM/HAJEZEZb0B82UwfMJLVvC/cBGq27TFLW4r5wovAQWIknNHnyevvAu6q+SuBRVdWQJZI8U957zxu33gIGQnPSZ1/2P+48r/v5IokFA+nJ5+JeEjFmDJfKJqB3wunGlfWWXQrMuXSftcKK/r/rIqJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMMjvUI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF91C32781;
	Wed, 24 Jul 2024 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721847013;
	bh=YM6uAcYcUTmEs9sx5YeWtzGmC+FZL1c6liKeC0Q2yVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMMjvUI8ho1nSA1R+Y6JdyEyB33/ArBG3L8dahyu36PtA/AGM7ZVlxtDVw9rphl8X
	 7YywP4kjObVjmMmENYPNGCZzw+9+qx0kZWO/z3dW9O9pwkZVDwiYOsNAGMMZYR0I/j
	 AeYF94W4VPYnIS1OYDKIUi5My/PFuXgrYTRYLsu+bTRpjWAd/n75HXJf1jM1/byKcb
	 4dLDWohNiCl71S1vm+7i/q00Cb3XVTwb7P2D4dEXNBdiLwLHxPtymkSzDgEdQKiUvV
	 NM7Bpa1N5iLpXb/AfAUS/rNRUHeXL6rMB6wITTc5HXFP9ZKo9uhNQ81iKQxYFcfG1B
	 PjTm7wI4XUVUw==
Date: Wed, 24 Jul 2024 19:50:08 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Stefan Chulski <stefanc@marvell.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: Don't re-use loop iterator
Message-ID: <20240724185008.GH97837@kernel.org>
References: <eaa8f403-7779-4d81-973d-a9ecddc0bf6f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaa8f403-7779-4d81-973d-a9ecddc0bf6f@stanley.mountain>

On Wed, Jul 24, 2024 at 11:06:56AM -0500, Dan Carpenter wrote:
> This function has a nested loop.  The problem is that both the inside
> and outside loop use the same variable as an iterator.  I found this
> via static analysis so I'm not sure the impact.  It could be that it
> loops forever or, more likely, the loop exits early.
> 
> Fixes: 3a616b92a9d1 ("net: mvpp2: Add TX flow control support for jumbo frames")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


