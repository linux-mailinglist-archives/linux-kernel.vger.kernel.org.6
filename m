Return-Path: <linux-kernel+bounces-276479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9726F94945B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C041F1C21739
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8918EB0;
	Tue,  6 Aug 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wd1uw7UY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E97C2E9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957596; cv=none; b=GTbuIPWrNPAErK1VMQS8YXEC8nKjX7ScDVn5PPAONVIlqlWFlDUisfO65X5TF1ZqT2wr3VrOe45cupj0GNodxBgFbmUlCjVnK/qmR+QgRUemg040GndxJz2pJj5G7kI92K2urcE0YWPr21dGQVUqg3mYV8ZFoytlmeFKino/pOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957596; c=relaxed/simple;
	bh=6Equoa9IT4AeHq55gFaiPlhzbCooW/niUBc9M7gIps0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufvNpDuWrE8PxwG+nl7O9iIpLDG1tJgUkdVlXJqvd9asJToRRBFY1SfRDY7caW/4LnRi7MglDHhToZPjFT8Dhl5HthfpAZR9zhtPtMVvM9g1WdG+XuaX9NLCtoJ4YM0p7DPLQc6eYe5EKB1vP/eO8QmQSpfeFND5F1nTSOqqOlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wd1uw7UY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2D6C32786;
	Tue,  6 Aug 2024 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722957595;
	bh=6Equoa9IT4AeHq55gFaiPlhzbCooW/niUBc9M7gIps0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wd1uw7UYbR7GUe8zbVi/qMcQUQ1Etv6Fey61BBqbE7UOEKbKVbkPkOWjt39MJRaRl
	 SSFr/lyFqhtnDdUPxXpFMDDhU0ZKJaBGTz+BOkZWoOaSJJCGjll1ctog309vnJrcfB
	 7JqtozoNNXtvm0zOIuMLTQQptfJjMs9zeyNlhgt4=
Date: Tue, 6 Aug 2024 17:19:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: sboyd@kernel.org, joshc@codeaurora.org, kheitke@codeaurora.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next,v2] spmi: pmic-arb: Add check for return value of
 platform_get_resource_byname
Message-ID: <2024080642-pueblo-change-888b@gregkh>
References: <20240806120045.3113451-1-cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806120045.3113451-1-cuigaosheng1@huawei.com>

On Tue, Aug 06, 2024 at 08:00:45PM +0800, Gaosheng Cui wrote:
> Add check for the return value of platform_get_resource_byname() and
> return the error if it fails to catch the error.
> 
> Fixes: 39ae93e3a31d ("spmi: Add MSM PMIC Arbiter SPMI controller")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
> v2: Add the fixes tag, thanks!
>  drivers/spmi/spmi-pmic-arb.c | 3 +++
>  1 file changed, 3 insertions(+)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

