Return-Path: <linux-kernel+bounces-288126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30189953616
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5811F216D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA0E1AD3FF;
	Thu, 15 Aug 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q1tFS+DA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236401AC422
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723733073; cv=none; b=oQjX+fr9oPEJbUdVhIDbVORXf72L4z20+N2QOWqblAiJ2oIUtsWOw4TTkvxhbtJ6ss3trNq+frKmiFdFdGylEYLSTgGE8ZMBc2WP7j50tJbmWHwqgIPRFXEUtfm3JlJcmEn4ji0EmihvE7P9+iCof/JZt9XSFkKQSiiXYTdAe9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723733073; c=relaxed/simple;
	bh=G/Amnhfl/0CV2xcYGKWy1HCd43uoH4QCoU2XD2AHW3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWusE4DkpNfNgA+fzi2BkH9aVpfzzZMdpZ796vIBT12rnDPoC7e+5nnTD1jGs5jM2WZAJevP26FtaCOJjzkZlktpAHXFG3B2zFTy2+WMrfLgk/II28yJNX80Mk3GgVwQRxbVLxSA6ioXcOD4XJylDFaIR7vJadyL/DtKLmW3cPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q1tFS+DA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CD5C32786;
	Thu, 15 Aug 2024 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723733073;
	bh=G/Amnhfl/0CV2xcYGKWy1HCd43uoH4QCoU2XD2AHW3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1tFS+DA/X4AScw/avb731JL30czObaxKBlynvMssJrrHrnXcmjLwo169vfR8hVgA
	 zYvwkLS5V6YmkAK8qHVWzGF1NTdapcxpWNizkKp6YP9w2E41RN2saKaxS4CWpMiUnF
	 H8Q5sOC+/NBxALv0i7aw+QVnMndu0b+jHZj0/fpQ=
Date: Thu, 15 Aug 2024 15:43:08 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: "Selvaraj, Joel (MU-Student)" <jsbrq@missouri.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
Message-ID: <2024081549-cardstock-oversleep-1d04@gregkh>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
 <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
 <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>
 <fde72c34-889a-4dd7-a1cb-fec1d1b3c6a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde72c34-889a-4dd7-a1cb-fec1d1b3c6a3@linaro.org>

On Thu, Aug 15, 2024 at 02:30:19PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 15/08/2024 03:34, Selvaraj, Joel (MU-Student) wrote:
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
> > >    drivers/misc/fastrpc.c      | 22 +++++++++++++++++++---
> > >    include/uapi/misc/fastrpc.h |  3 +++
> > >    2 files changed, 22 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > > index 5680856c0fb8..a7a2bcedb37e 100644
> > > --- a/drivers/misc/fastrpc.c
> > > +++ b/drivers/misc/fastrpc.c
> > > @@ -2087,6 +2087,16 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
> > >    	return err;
> > >    }
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
> 
> Yes, this is the ideal way to fix this, Audio DSP and Sensor DSPs are by
> default secure DSP's.
> 
> usage of "qcom,non-secure-domain" has been abused on all the platforms as
> the device tree bindings are not enforcing this checks to any new device
> tree entries. This needs fixing properly.
> 
> Ideally this patch has to fix the existing dts and update bindings to
> reflect that.
> 
> Sorry this has been over looked!
> 
> On the library side that you are using consider non-secure node as fallback
> only when secure node is missing.
> 
> given the mess with the current state of patch, reverting sounds good for me
> to start with.

Great, can you ack the revert then and I'll queue it up to get to Linus
this week?

thanks,

greg k-h

