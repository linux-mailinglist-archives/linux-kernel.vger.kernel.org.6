Return-Path: <linux-kernel+bounces-546247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAB9A4F85A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A1F3A71B0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B161F4276;
	Wed,  5 Mar 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWpWHrmM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27E1547E2;
	Wed,  5 Mar 2025 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741161457; cv=none; b=fU4GSsX8sn1Aw9lR4OqG6GV03B04krGnt8fxzZ/ZCSIwhCDfikU7wh+ySZmM+Q5kJi7pTUyPftwgoCqCQzs/nVwlQ2djxd4SgxUxfNJwulE2JHKINLC9NmnLXie/bjlhdAVFf1AsBXDU3qGCtYH11+fMRfJMIujgLThqRZN1bt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741161457; c=relaxed/simple;
	bh=1qfqTAY5g4rU5BKvohe/wSQnKZRFwIwUMMFb18lwqUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2x/QL+6xxtCV8b9HJS/q6x8FSan1fJdxmHOzPJPIE8JuCwGloFQ5tiFhv2flKi7VLsz4Ra3UmX6DlPskJ1qf4HRHXpSN/k0unX7kiA1lajfJHI0vbc5f/bklw8I5Ns8+EbiEcMJsisYUQhyW1bqIp8GeHnUQKapu1XO3/Af2uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWpWHrmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E045C4CEE2;
	Wed,  5 Mar 2025 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741161456;
	bh=1qfqTAY5g4rU5BKvohe/wSQnKZRFwIwUMMFb18lwqUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWpWHrmM6FO5slFEe1awm0P61uonDdfX3ReUfsTLsL7J86m5wr+uuhUcH+qImGhCX
	 SB46SjNYa6B1UYlZl6TrKQDxTT9vpRnYwNXt65iGD+vs1lRX5+4k8rilVsH1TF0Rn7
	 WnAmmnavwtnnrgNysNzXEnisr77zmZJ+hv5bcsX8=
Date: Wed, 5 Mar 2025 08:57:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, "cocci@inria.fr" <cocci@inria.fr>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [v2] mei: Improve exception handling in mei_cl_irq_read_msg()
Message-ID: <2025030508-iodize-diagram-3e0f@gregkh>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
 <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
 <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
 <ccdac63a-4a04-4243-9350-05acc23f413b@web.de>
 <CY5PR11MB6366E6F52B68E8258EE47F3FEDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB6366E6F52B68E8258EE47F3FEDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>

On Wed, Mar 05, 2025 at 07:41:25AM +0000, Usyskin, Alexander wrote:
> > >
> > > In general, why not, but the label naming is bad.
> > > It hides the original intent to discard this message.
> > > Let's rename existing label to discard_nocb: and leave a new one as discard:.
> > > Also, the patch will be smaller in this way.
> > 
> > Do you expect a third patch version according to your naming preferences?
> > 
> > Regards,
> > Markus
> 
> I prefer to, as the current patch reduces this code readability.
> 
> - - 
> Thanks,
> Sasha
> 
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

