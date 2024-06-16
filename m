Return-Path: <linux-kernel+bounces-216232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD805909CEF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDDD1C209EF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C341862BC;
	Sun, 16 Jun 2024 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LMc6TE1Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D03A8CB
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718533056; cv=none; b=eVfMkMho4CIZOhx6wBTzDF5FKnyhRvYSdiSYpK/EkGi1Rpr6luc/62gQ0AympS7Go+PrgktnssuqyZnGRdz2SuDZ13lNUCcB9pHEQHtVoIzqGR/7w3fto//+8G9oSwxlUZMZcf3WQn/4Z2pKMFmGRzZKwdLDiQakefbKo6AergI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718533056; c=relaxed/simple;
	bh=bOEN/u7pYiKgtP4Y4pNIsuRPr7dd6tBtflnqUiQL3hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNVJ71fhB04oWG635D8nKz666QDwZPuKqOXP1c37fdDEvBDATSu/DUkWvpPGdz7FVzvHVy3qCNH8Px3xZpHS1GjJ4HaExw7+Dk/C8OoND+hf/tUVR4WeJCOafPruB4kRO4aBwSxlXLQiYqCfKeTEkMG7rIDqz94Zxzj4+S0sAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LMc6TE1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8964DC2BBFC;
	Sun, 16 Jun 2024 10:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718533055;
	bh=bOEN/u7pYiKgtP4Y4pNIsuRPr7dd6tBtflnqUiQL3hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMc6TE1QenstXtavqQ+fxCwuQsDp+FovTFs+JbtrjgGkGCoKlrGpcE+M3Rxh8NvgE
	 diRMbIJ+9WMPHqbFLKEizojYMjXTmTkCxGdX7EI/n0zjlnV6r9b0jmWapIB5JrP658
	 VsvyX3E73lrt5gLBdKGWMILa5pa9m45ownVKGOrw=
Date: Sun, 16 Jun 2024 12:17:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, andriy.shevchenko@linux.intel.com, brgl@bgdev.pl,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] devres: Fix devm_krealloc() allocating memory with
 wrong size
Message-ID: <2024061611-cyclist-hardiness-c15f@gregkh>
References: <1718531655-29761-1-git-send-email-quic_zijuhu@quicinc.com>
 <2024061609-breezy-magnitude-8edf@gregkh>
 <4f691c9c-8882-4bd7-ba60-3fc665d0808c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f691c9c-8882-4bd7-ba60-3fc665d0808c@quicinc.com>

On Sun, Jun 16, 2024 at 06:10:02PM +0800, quic_zijuhu wrote:
> On 6/16/2024 6:02 PM, Greg KH wrote:
> > On Sun, Jun 16, 2024 at 05:54:15PM +0800, Zijun Hu wrote:
> >> Kernel API devm_krealloc() calls alloc_dr() with wrong argument
> >> @total_new_size, and it will cause more memory to be allocated
> >> than required, fixed by using @new_size as alloc_dr()'s argument.
> >>
> >> Fixes: f82485722e5d ("devres: provide devm_krealloc()")
> >> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> >> ---
> >>  drivers/base/devres.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> >> index 3df0025d12aa..1cf87ddf1f55 100644
> >> --- a/drivers/base/devres.c
> >> +++ b/drivers/base/devres.c
> >> @@ -898,7 +898,7 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
> >>  	 * taking the lock as most probably the caller uses GFP_KERNEL.
> >>  	 */
> >>  	new_dr = alloc_dr(devm_kmalloc_release,
> >> -			  total_new_size, gfp, dev_to_node(dev));
> >> +			  new_size, gfp, dev_to_node(dev));
> > 
> > Wait, are you sure?  Did you properly test this?  What is the actual
> > savings and how do you handle the fact that you are now not allocating
> > the space reserved for the devres structure itself?
> > 
> sure even if i did not test it.
> beware that alloc_dr() will call check_dr_size() to reserve space for
> devres structure.
> 
> it will reserve the devres structure two times if using wrong
> @total_new_size. it is obvious wrong.

Ah, I missed that, that is tricky.  Please document this better when you
resubmit a new version.

And of course, please test it.

thanks,

greg k-h

