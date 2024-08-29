Return-Path: <linux-kernel+bounces-306459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6E1963F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493E71F21061
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E56018C923;
	Thu, 29 Aug 2024 08:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY7gNazz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C037F18C34D;
	Thu, 29 Aug 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921926; cv=none; b=HrG288sO5uS5LTM8BInvpE5fxzcrUd2Y2UXo2sVLSkKEEd2t+gBFAdLOxK/UZ5G8utwjl53F2jvniQnDEgK19IyPogFqA6NdXFh5l1vuust0zaRnrcAOPJmSrnV86bEqopVrOELPUxmalFTw7Ks5k+NWzzUVm0/LQLpL9OG//Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921926; c=relaxed/simple;
	bh=GprZvx6QsOS5L4srpHfq+udTVm6mZ3q8Rn2G3wMDocE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaTcJ7ptVdsufOPhStdqaXA3kknkRKvN+NzKpXbwsTclOpXJF3Ow/mcN4muPBkXBs3G6c5l/3+WtRSm8gWwpsXY8KSEssg9CclNnrWAk3X8dpy/J+g7N1DjKzSFvUJmujY2Y7N1cn6g4gLktdBISxpjmIAa9JrukuCZiFjgIy0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY7gNazz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA77DC4CEC1;
	Thu, 29 Aug 2024 08:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724921926;
	bh=GprZvx6QsOS5L4srpHfq+udTVm6mZ3q8Rn2G3wMDocE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nY7gNazzpoo1mwpZ0dpnTtzob9Xqa/G/JgwSI/u+OjyqGO6ZEOQMNJ1umlY0L13rG
	 rnp/A1pFi8PUN4I2ev3pSXQBlAhkC0wxNWUOfe7/R3YJ8iDEU8NtabpFqLmFot8zXs
	 vrIwXG6XbsN3sBBUaDGMvr3s9WZRWyL0kTVgm5i0M8DEgEPusGk4f0QgGsXY8e+kAs
	 tQKLgtJ5FmXUP0/Jazw0sjuG2t2zUyjwfa5h0U6G5l77i/0V9fmprDib1pi3/1gUfo
	 9OzYwpfHf6TmRcnYllzu0WZMEcjph9EJN/hJz1kSQ4UUB23UF/0OjUMl9EceuuWEdy
	 aqK75MdO2lKfg==
Date: Thu, 29 Aug 2024 11:58:42 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Shen Lichuan <shenlichuan@vivo.com>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] IB/qib: Use max() macro
Message-ID: <20240829085842.GA24019@unreal>
References: <20240827082254.72321-1-shenlichuan@vivo.com>
 <8a113fab-d58b-42e2-9c7c-e84dd2f27d99@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a113fab-d58b-42e2-9c7c-e84dd2f27d99@cornelisnetworks.com>

On Tue, Aug 27, 2024 at 11:00:11AM -0400, Dennis Dalessandro wrote:
> On 8/27/24 4:22 AM, Shen Lichuan wrote:
> > Use the max() macro to simplify the function and improve
> > its readability.
> > 
> > Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> > ---
> >  drivers/infiniband/hw/qib/qib_iba7220.c | 2 +-
> >  drivers/infiniband/hw/qib/qib_iba7322.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
> > index 78dfe98ebcf7..4c96b66a93b5 100644
> > --- a/drivers/infiniband/hw/qib/qib_iba7220.c
> > +++ b/drivers/infiniband/hw/qib/qib_iba7220.c
> > @@ -4094,7 +4094,7 @@ static int qib_init_7220_variables(struct qib_devdata *dd)
> >  	updthresh = 8U; /* update threshold */
> >  	if (dd->flags & QIB_HAS_SEND_DMA) {
> >  		dd->cspec->sdmabufcnt =  dd->piobcnt4k;
> > -		sbufs = updthresh > 3 ? updthresh : 3;
> > +		sbufs = max(updthresh, 3);
> >  	} else {
> >  		dd->cspec->sdmabufcnt = 0;
> >  		sbufs = dd->piobcnt4k;
> > diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
> > index 9db29916e35a..5a059ec08780 100644
> > --- a/drivers/infiniband/hw/qib/qib_iba7322.c
> > +++ b/drivers/infiniband/hw/qib/qib_iba7322.c
> > @@ -6633,7 +6633,7 @@ static int qib_init_7322_variables(struct qib_devdata *dd)
> >  	 */
> >  	if (dd->flags & QIB_HAS_SEND_DMA) {
> >  		dd->cspec->sdmabufcnt = dd->piobcnt4k;
> > -		sbufs = updthresh > 3 ? updthresh : 3;
> > +		sbufs = max(updthresh, 3);
> >  	} else {
> >  		dd->cspec->sdmabufcnt = 0;
> >  		sbufs = dd->piobcnt4k;
> 
> I don't see how this improves readability or makes the function simpler. I'm not
> opposed to it, just don't see it as an improvement.

He got same comment from Jakub K. (netdev) too, so let's drop this patch.

Thanks

> 
> -Denny

