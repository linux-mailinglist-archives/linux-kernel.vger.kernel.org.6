Return-Path: <linux-kernel+bounces-262862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA86193CDFA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3391C20EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA06175573;
	Fri, 26 Jul 2024 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="El49WGRJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C3B3BB47;
	Fri, 26 Jul 2024 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721974046; cv=none; b=X3Qqq6fgAWKCFGCg3r7lmKOhp+hK0FBHb8hX2IQOeUeQ5dqhD4yox3AikyC0KN0kOFGIATFlh+8EwJ/IrViddk1F+fALELMh95/JCFHS/GKQafZf4WW3a/CbvQCxCW4MAb4Wb8ZUlaA3KfkF0sybntqim8uvovZ1qXGG5lxVEWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721974046; c=relaxed/simple;
	bh=8qS+Fwd0ICFyex9iDNDVCSEocHgv9Bux9McuoOJS/Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b81d8r9Fr8rw/K+h2oDJR/LR1FhsVXFTSVXtxHC8jw32p0Nr0Jp7l0dnMojEObU33JKKtrZnV2ZkK+molX1u5a308VwolUrnGr40mR2vjAHk1YmAKemtVi1btmVhgLZ5XmCrdMRmdav//Q55hVzLoHguP84NSKJlJQjQhyQCxDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=El49WGRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7805EC32782;
	Fri, 26 Jul 2024 06:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721974045;
	bh=8qS+Fwd0ICFyex9iDNDVCSEocHgv9Bux9McuoOJS/Gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=El49WGRJ7P1Rnu7IGUp3dNr7ST1P0k9sLogyxHYGzUphJzKRrwEc9ceca2NgeJtWC
	 MURStbv79uJieMTby1mR+fzEoI2IaI/y4TFEqMa3FIaodhQ3yIQkW2/XCQIvtprqFr
	 nyA6HBARv/S9KidaMxq6FLIsL6qn2hVoaI4Qz274=
Date: Fri, 26 Jul 2024 08:07:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
	RD Babiera <rdbabiera@google.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: fix non-contaminant CC
 handling
Message-ID: <2024072659-movable-fossil-8810@gregkh>
References: <20240710-max33359-toggling-v1-1-f6dc123f3a0a@linaro.org>
 <1e650f29c2714b5f390a2bf5edf5920c2975fbac.camel@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e650f29c2714b5f390a2bf5edf5920c2975fbac.camel@linaro.org>

On Fri, Jul 26, 2024 at 07:01:13AM +0100, André Draszik wrote:
> Hi,
> 
> On Wed, 2024-07-10 at 07:28 +0100, André Draszik wrote:
> > tcpci_maxim currently never triggers the TCPM state machine when CC
> > status has not changed due to a contaminant but due to a real
> > connection event, i.e. a genuine plug event, meaning the system will
> > stay idle and not notify any subscribers.
> > 
> > The reason is that the initial state of the port is 'toggling', which
> > causes _max_tcpci_irq() to only drive the contamination part of the
> > TCPM state machine (via tcpm_port_clean()).
> > 
> > What should happen instead is that if no contamination was detected,
> > the TCPM should be notified of the CC change in this case.
> > 
> > To fix this, we update ...is_contaminant() to also allow its caller to
> > determine if more CC processing is required and then call into the TCPM
> > as required.
> > 
> > While at it, add a kernel-doc for max_contaminant_is_contaminant().
> > 
> > Note: the code has an issue where I2C errors during contaminant
> > detection also cause the TCPM state machine to not be updated. This
> > commit doesn't change this behaviour and should be addressed by
> > follow-up commit(s).
> > 
> > Signed-off-by: André Draszik <andre.draszik@linaro.org>
> > ---
> >  drivers/usb/typec/tcpm/maxim_contaminant.c |  7 +++++--
> >  drivers/usb/typec/tcpm/tcpci_maxim.h       | 15 ++++++++++++++-
> >  drivers/usb/typec/tcpm/tcpci_maxim_core.c  | 12 ++++++++----
> >  3 files changed, 27 insertions(+), 7 deletions(-)
> 
> Any comments on this patch?

It's the middle of the merge window, nothing we can do until -rc1 is
out...

thanks,

greg k-h

