Return-Path: <linux-kernel+bounces-307311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C61F964B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96531F2180E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E46E38F9C;
	Thu, 29 Aug 2024 16:23:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F0418C032
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948622; cv=none; b=hpQmmKSFW1uEAouo3nVaxPORASo9kNizU4Nhqi9QXB8BzLKPOaHGm6of4y9PWhClzsGC3XelhQnQgdHDJaaufc0dVkP2VkodBHL8SIGrHJ+IIE1n/8nfah2DZ/9WwqVQ72asoVqMgRTQyvpe25GViR2QeDRxT7tjWE6JLtZq0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948622; c=relaxed/simple;
	bh=Ml2Eb3Spu9o8mnCkLAs4MhMbOh9QmCQTIu+aR8VJPgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFQIVWuDbqthkAsRVysc9s2WDQHNa5pQG7rQO4Qx+2EfgfwkJp856Q05xfvY7ttmrJDoj6gqvbUc6zNFGgMjYRy8doQb8VvlYa2AWGG1jd/5kYjMpu2SK/R7lSPdQ6pJV1NjWx3Fcf4ym4ISO3lCYxwwHtlGy5QUO7OvhmhzwRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A81B3106F;
	Thu, 29 Aug 2024 09:24:06 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56AFB3F762;
	Thu, 29 Aug 2024 09:23:39 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:23:37 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: versatile: fix OF node leak in CPUs prepare
Message-ID: <ZtCgiSIGmQzA4EwG@bogus>
References: <20240826054934.10724-1-krzysztof.kozlowski@linaro.org>
 <ZtBqqXWvVWDtaeE8@e110455-lin.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtBqqXWvVWDtaeE8@e110455-lin.cambridge.arm.com>

On Thu, Aug 29, 2024 at 01:33:45PM +0100, Liviu Dudau wrote:
> On Mon, Aug 26, 2024 at 07:49:33AM +0200, Krzysztof Kozlowski wrote:
> > Machine code is leaking OF node reference from of_find_matching_node()
> > in realview_smp_prepare_cpus().
> > 
> > Fixes: 5420b4b15617 ("ARM: realview: add an DT SMP boot method")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 
> I think Sudeep is going to take the series through his tree, but he might
> be on holiday at this time.
> 

I am not that lucky 😉. Anyways I left these to Linus W as he deals with
versatile platforms. I have only seen them but never run anything on them.

--
Regards,
Sudeep

