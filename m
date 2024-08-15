Return-Path: <linux-kernel+bounces-287536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E966B9528DF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503A5B24728
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 05:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DD915350D;
	Thu, 15 Aug 2024 05:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1u7d3bJC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60971514DE
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723699042; cv=none; b=R3jSQ95F2H1uqUFlIGuumtNO2goBq76kuZbIVFPTxgWSptcYZSAwtxnCLtSsKoLOh3sHeDj240Cjafne5qW8pTeOoTlAERjBuOkqjUQtE5EMe9YUjT8/rqFbOkAv8W4NH6m3IvkALDKdZH/KGr7vXkjF59VNSDfOE199XfaCYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723699042; c=relaxed/simple;
	bh=+BnD2c38s9xZBiSZqb926Fx1ErG+I+ErBFX7hmzMzh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNBm2wZdVaUA0JgFoN9if8wFpX5jFD4gQ4oxzYU+ItM69F9kALDORILind2XtzwyOIKO4/Hq4r/uLebl2Eq9QxSS/29DcUNMQpPBx59vqyrONKm7T/W1StM4JbBet7cYL4WfT+5b9FHZhpQ9J/y7Jqcu6Z3ix4d/rpDGaXQ+gJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1u7d3bJC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D61CC4AF09;
	Thu, 15 Aug 2024 05:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723699041;
	bh=+BnD2c38s9xZBiSZqb926Fx1ErG+I+ErBFX7hmzMzh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1u7d3bJCpWtJ4i2bFX+KxkrgquNWSlY1F5gmlXU50OAtlxG/MzMRz+Ree3UFLZLZ4
	 qNVxKv2OTfYfvAAO3BWhtP+FvK4w4WahjV0frxX5zxgYb7TAO4Ep7rhM2NmRUbFY6j
	 PCSvlF6RMi0Gy4DFO53Qf856RYOttFd6/9yjZuIs=
Date: Thu, 15 Aug 2024 07:17:18 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Selvaraj, Joel (MU-Student)" <jsbrq@missouri.edu>
Cc: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
Message-ID: <2024081545-crafty-pummel-573a@gregkh>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
 <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
 <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>
 <2024081535-unfasten-afloat-9684@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081535-unfasten-afloat-9684@gregkh>

On Thu, Aug 15, 2024 at 07:15:50AM +0200, gregkh@linuxfoundation.org wrote:
> On Thu, Aug 15, 2024 at 02:34:18AM +0000, Selvaraj, Joel (MU-Student) wrote:
> > Hi Srinivas Kandagatla and Ekansh Gupta,
> > 
> > On 6/28/24 06:45, srinivas.kandagatla@linaro.org wrote:
> > > From: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > > 
> > > Untrusted application with access to only non-secure fastrpc device
> > > node can attach to root_pd or static PDs if it can make the respective
> > > init request. This can cause problems as the untrusted application
> > > can send bad requests to root_pd or static PDs. Add changes to reject
> > > attach to privileged PDs if the request is being made using non-secure
> > > fastrpc device node.
> > > 
> > > Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
> > > Cc: stable <stable@kernel.org>
> > > Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >   drivers/misc/fastrpc.c      | 22 +++++++++++++++++++---
> > >   include/uapi/misc/fastrpc.h |  3 +++
> > >   2 files changed, 22 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > index 5680856c0fb8..a7a2bcedb37e 100644
> > > --- a/drivers/misc/fastrpc.c
> > > +++ b/drivers/misc/fastrpc.c
> > > @@ -2087,6 +2087,16 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
> > >   	return err;
> > >   }
> > >   
> > > +static int is_attach_rejected(struct fastrpc_user *fl)
> > > +{
> > > +	/* Check if the device node is non-secure */
> > > +	if (!fl->is_secure_dev) {
> > > +		dev_dbg(&fl->cctx->rpdev->dev, "untrusted app trying to attach to privileged DSP PD\n");
> > > +		return -EACCES;
> > > +	}
> > > +	return 0;
> > > +}
> > 
> > This broke userspace for us. Sensors stopped working in SDM845 and other 
> > qcom SoC devices running postmarketOS. Trying to communicate with the 
> > fastrpc device just ends up with a permission denied error. This was 
> > previously working. I am not sure if this is intended. Here are my two 
> > observations:
> > 
> > 1. if change the if condition to
> > 
> > `if (!fl->is_secure_dev && fl->cctx->secure)`
> > 
> > similar to how it's done in fastrpc's `is_session_rejected()` function, 
> > then it works. But I am not sure if this is an valid fix. But currently, 
> > fastrpc will simply deny access to all fastrpc device that contains the 
> > `qcom,non-secure-domain` dt property. Is that the intended change? 
> > Because I see a lot of adsp, cdsp and sdsp fastrpc nodes have that dt 
> > property.
> > 
> > 2. In the `fastrpc_rpmsg_probe()` function, it is commented that,
> > 
> > "Unsigned PD offloading is only supported on CDSP"
> > 
> > Does this mean adsp and sdsp shouldn't have the `qcom,non-secure-domain` 
> > dt property? In fact, it was reported that removing this dt property and 
> > using the `/dev/fastrpc-sdsp-secure` node instead works fine too. Is 
> > this the correct way to fix it?
> > 
> > I don't know much about fastrpc, just reporting the issue and guessing 
> > here. It would be really if this can be fixed before the stable release.
> 
> I will be glad to revert it, what was the git id for this in the tree
> now?

Ah, nevermind, I found it, it's bab2f5e8fd5d ("misc: fastrpc: Restrict
untrusted app to attach to privileged PD") and is already in the stable
kernel trees.  Do you want to submit a revert or do you need/want me to
do it?

thanks,

greg k-h

