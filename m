Return-Path: <linux-kernel+bounces-287774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B21E8952C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CFA1F234AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A221B375C;
	Thu, 15 Aug 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HNeir2T/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED611714C4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716169; cv=none; b=Ltb3QgW+FvyYJqWr/e405JSRnYw9F8TXSU9eEJvBxauQorURSZTBWk8bXEDfsFqat0PlbHfY1QCtx/+nZhP6e+aU+quNBx1VcV4QRhq+3OQCFYbfrvotLEqMo6rG8gftSXPZ3mpXD3X8SMAWkHa/8me1PN14mLQ31jACvl5YS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716169; c=relaxed/simple;
	bh=R77NbRHmLNeZrVwNwOkN7Ns9+d+sTZcLnFwgFsEaIpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCV5vAKlNgqTKUp4kg4PFFnWwrzf5dEEIWj6+3lZbyMNhALIYkoFb7sybAZP5lo0dYH5fD+DWFwM6A39CabHZJBnjgAokwlzLmhIdMKGXiKhcnMfMSqMBet0LvaHBmIWYL66LuTGND3aRgPm7SSMQIrDKo64hE10hhJbRRpgSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HNeir2T/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3F8C32786;
	Thu, 15 Aug 2024 10:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723716168;
	bh=R77NbRHmLNeZrVwNwOkN7Ns9+d+sTZcLnFwgFsEaIpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNeir2T/E85ymRLbOO/KnLS9PC+SJRKtUYmADz+Yca2GINu2RTEsfleBSQFN7TMTZ
	 Hbfd7H124UZPtL5HUD5Oztllhmm4rqOdg/gAisGkAziPvcMMS52ZaPoqvH3fbHEygR
	 W9RvW/mVtTB6AQuXlyVhqOirKcuLouijLehsRMXc=
Date: Thu, 15 Aug 2024 12:02:45 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 6/6] misc: fastrpc: Restrict untrusted app to attach to
 privileged PD
Message-ID: <2024081531-vision-broadness-daca@gregkh>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
 <20240628114501.14310-7-srinivas.kandagatla@linaro.org>
 <9a9f5646-a554-4b65-8122-d212bb665c81@umsystem.edu>
 <2024081535-unfasten-afloat-9684@gregkh>
 <362eea30-7b6d-4cd5-aed9-88c0d014dd91@gmail.com>
 <2024081513-aware-tutor-e119@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081513-aware-tutor-e119@gregkh>

On Thu, Aug 15, 2024 at 10:41:15AM +0200, gregkh@linuxfoundation.org wrote:
> On Thu, Aug 15, 2024 at 03:35:13AM -0500, Joel Selvaraj wrote:
> > Hi greg k-h,
> > 
> > The git commit id is: bab2f5e8fd5d2f759db26b78d9db57412888f187
> > 
> > But I am bit hesitant if we should revert it because there is a CVE attached
> > to it: https://ubuntu.com/security/CVE-2024-41024
> 
> Not an issue if it is breaking things, let's get it right.  We can
> trivially reject that CVE if needed.
> 
> > Also, I am ok with changing userspace if it's necessary. It would be nice if
> > the authors can clarify the ideal fix here.
> 
> No, userspace should not break, that's not ok at all.  I'll get someone
> to revert this later today, thanks!

Now sent:
	https://lore.kernel.org/r/20240815094920.8242-1-griffin@kroah.com

I'll queue this up later today.

thanks,

greg k-h

