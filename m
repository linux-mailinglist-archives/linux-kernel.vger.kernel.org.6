Return-Path: <linux-kernel+bounces-287531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B729528D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F83288046
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D5A145A10;
	Thu, 15 Aug 2024 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ymNGfzBk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F21448F6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698954; cv=none; b=jwX5eyxrWs/E0VbBCIJvye9mswIQRy09vYTKqRMH1XtPYvCK4xwOxlMWBTULQciS/qtyTatwVwJsYR81jsftLvx/UNolHns8zqHHYOA8NP1Q7S+LzqhpXJJYCJk7Fr58lU5LBSgwFEyUE0E21pxEuJaQ/WND+b/fd1GZt6nw9Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698954; c=relaxed/simple;
	bh=eX65bH9WSYWdl/C7qbD4Jvm1adj9Dm2X39qRcXh3gMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gnzl9da3E/3pJ/eUbpSgpGEOxiLvYf3Uvnftqygga4+168enSQ9rbIJcOzrLmC7USM3ZUG+TA0iI41HXsPlmBqfLJHZWAx2w9JkThm4SgqXf0P9mIURkEbrb1uFtvy733BmPNeqBMcIXGLVlO3ntZB6j1GfxlxDf3iPTR71av4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ymNGfzBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00785C4AF0A;
	Thu, 15 Aug 2024 05:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723698953;
	bh=eX65bH9WSYWdl/C7qbD4Jvm1adj9Dm2X39qRcXh3gMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ymNGfzBkCdrF+jumcB66XYUf+Na/eIKGhw/xIGPQyXsYUVWiSsfU5HeORap2imsOi
	 wr6bX1aC5wAzvgmcUBN00UoEpVYm/gg4cM6/0g4RErSpeBougbELxoRagtbFihSlNq
	 XTxKLubqW4r6LVVi6wOXIFMKWs1qw9aN4fdZMS34=
Date: Thu, 15 Aug 2024 07:15:50 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Selvaraj, Joel (MU-Student)" <jsbrq@missouri.edu>
Cc: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
Message-ID: <2024081535-unfasten-afloat-9684@gregkh>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
 <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
 <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>

On Thu, Aug 15, 2024 at 02:34:18AM +0000, Selvaraj, Joel (MU-Student) wrote:
> Hi Srinivas Kandagatla and Ekansh Gupta,
> 
> On 6/28/24 06:45, srinivas.kandagatla@linaro.org wrote:
> > From: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > 
> > Untrusted application with access to only non-secure fastrpc device
> > node can attach to root_pd or static PDs if it can make the respective
> > init request. This can cause problems as the untrusted application
> > can send bad requests to root_pd or static PDs. Add changes to reject
> > attach to privileged PDs if the request is being made using non-secure
> > fastrpc device node.
> > 
> > Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >   drivers/misc/fastrpc.c      | 22 +++++++++++++++++++---
> >   include/uapi/misc/fastrpc.h |  3 +++
> >   2 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index 5680856c0fb8..a7a2bcedb37e 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -2087,6 +2087,16 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
> >   	return err;
> >   }
> >   
> > +static int is_attach_rejected(struct fastrpc_user *fl)
> > +{
> > +	/* Check if the device node is non-secure */
> > +	if (!fl->is_secure_dev) {
> > +		dev_dbg(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
> > +		return -EACCES;
> > +	}
> > +	return 0;
> > +}
> 
> This broke userspace for us. Sensors stopped working in SDM845 and other 
> qcom SoC devices running postmarketOS. Trying to communicate with the 
> fastrpc device just ends up with a permission denied error. This was 
> previously working. I am not sure if this is intended. Here are my two 
> observations:
> 
> 1. if change the if condition to
> 
> `if (!fl->is_secure_dev && fl->cctx->secure)`
> 
> similar to how it's done in fastrpc's `is_session_rejected()` function, 
> then it works. But I am not sure if this is an valid fix. But currently, 
> fastrpc will simply deny access to all fastrpc device that contains the 
> `qcom,non-secure-domain` dt property. Is that the intended change? 
> Because I see a lot of adsp, cdsp and sdsp fastrpc nodes have that dt 
> property.
> 
> 2. In the `fastrpc_rpmsg_probe()` function, it is commented that,
> 
> "Unsigned PD offloading is only supported on CDSP"
> 
> Does this mean adsp and sdsp shouldn't have the `qcom,non-secure-domain` 
> dt property? In fact, it was reported that removing this dt property and 
> using the `/dev/fastrpc-sdsp-secure` node instead works fine too. Is 
> this the correct way to fix it?
> 
> I don't know much about fastrpc, just reporting the issue and guessing 
> here. It would be really if this can be fixed before the stable release.

I will be glad to revert it, what was the git id for this in the tree
now?

thanks,

greg k-h

