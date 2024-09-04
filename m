Return-Path: <linux-kernel+bounces-314831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DD096B9AB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B5F21C21362
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D032D1CFEAB;
	Wed,  4 Sep 2024 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfW9+RN+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39177126C01;
	Wed,  4 Sep 2024 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448122; cv=none; b=aRODmfKAybqqkea+AzTVyzLygzUoRZ7XjNFdx2hQY6YWerSh5NbbOnrhF6N0fSqf1uwudtNHuSYZm7yPxn0CWCa6Qv8h0IE96X/igZnqEdZbjc9OzGfOBi1/2aQhRYh8eYdx8kxVxc4p/d/GqS8K/Y+tPvoPas+gR/4hVIlvOw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448122; c=relaxed/simple;
	bh=dUTWSTO3hsF52aKzFrTTJUzfaXRSeX4EpJWjUAwF0p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8o1HCJs5Dw251UWKkNdYTVJUmOnZmkBlPJCNmmDmfrS3wx8jM1K3BkH8uLwaB0fvkAxUWwez6cs94RZI3kqbkh9h/OSG0JzYkXrfCNin2hAP1QQ0L5wzmAR6wMcdX6Ab+Zv9v0qlj/QzuTprfEG0Efxg6NNC9IIr6+TqTzbxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfW9+RN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2F0C4CEC2;
	Wed,  4 Sep 2024 11:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725448122;
	bh=dUTWSTO3hsF52aKzFrTTJUzfaXRSeX4EpJWjUAwF0p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfW9+RN+XH80dG7A6O2FKna5i7yvH2wwLj61tJyJZLE7TYqCTLvQRXp4ez2RM1KCR
	 z9NPoqbRgHROkKhmce0Qu+/I28rOdAbMmUdu9FfdyTHcftBjFOY0YjyDEMSYIqXduW
	 bN3PDT7ehS7VF7i/aqf/8nA0ye3STjp8/c9oP+4gYwKKYNUKJb0AZR8+JYrPQQBiN3
	 7ehtjcNKwmHbvTklLx8XEqzw+aw1ik4rAU+woNIf8olQHjbgV8c34DCSPreWPmSrqe
	 ZRisHT/YUEhAfq5mz47QiIqN9m/cFJNOqQrkRwEsM0/Cfolxm7D9Ev/3Z7Y2atjsqq
	 T1dfAj0p/AzqA==
Date: Wed, 4 Sep 2024 12:08:37 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 7/9] net: netconsole: extract release appending
 into separate function
Message-ID: <20240904110837.GU4792@kernel.org>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-8-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903140757.2802765-8-leitao@debian.org>

On Tue, Sep 03, 2024 at 07:07:50AM -0700, Breno Leitao wrote:
> Refactor the code by extracting the logic for appending the
> release into the buffer into a separate function.
> 
> The goal is to reduce the size of send_msg_fragmented() and improve
> code readability.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks,

I agree this improves readability.

Reviewed-by: Simon Horman <horms@kernel.org>


