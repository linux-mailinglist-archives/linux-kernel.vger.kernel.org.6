Return-Path: <linux-kernel+bounces-332280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B013297B7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC27B20BDD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7252414A086;
	Wed, 18 Sep 2024 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVsBV5Mj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D133DDF6C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726639956; cv=none; b=T7oz/21znN/CGjPrISqWqg/5jiFgY1Cn/UzeDyfono30nH71X+eh3Ny5CW81cIkJrE1MXOCvcz9BcKdT+y9gQWLKuldeh392zjsUfELLTlsTOQHpm5eax6SJfo6UDIvowF1DA/Dd3mKWmg9I5WG5C8y/BLwKDxxgINJqpw7l17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726639956; c=relaxed/simple;
	bh=0cMDnLfawnNrBsiNhzS/y1l/gwhUjiP67PgaOZ9uELw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih0MTCmxs7qyd3ineTYBSO+5KWS7YYkGVyVufKqYVM3ifem8Za98/O3w5+8TrG10mfTRnqKPL30OyCfMRZjds863ndmNTnmBELWI1PLgHEvd0JbGeBVQamehOQOs4C6PNCZw5od4ePSonW5VA2jMp97bXsaisZk+YeSy2IFC9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVsBV5Mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15A3C4CEC3;
	Wed, 18 Sep 2024 06:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726639956;
	bh=0cMDnLfawnNrBsiNhzS/y1l/gwhUjiP67PgaOZ9uELw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVsBV5Mj0MFrRPZiQ6YO0gJf0djPToMIrwWJZnu7Y4FRGnZHTuRdNJMv+l1jdE6e9
	 aVk1DFoyMNaihfLUh1BEMRS5qWay9IM2chiRfV+WeHDccePwM4zjiy6o9C8mu3f/rS
	 mcreKg2WfWQCiEWZN9AnKsenpAODv8sQVVq8S2IY=
Date: Wed, 18 Sep 2024 08:12:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>
Subject: Re: [PATCH] driver core: fix async device shutdown hang
Message-ID: <2024091838-keenly-scrabble-8cce@gregkh>
References: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
 <2024091753-estate-legroom-5d62@gregkh>
 <751d4ba8-1e35-47a5-9a94-9873ff2619ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751d4ba8-1e35-47a5-9a94-9873ff2619ae@gmail.com>

On Tue, Sep 17, 2024 at 07:20:41PM -0500, stuart hayes wrote:
> 
> 
> On 9/17/2024 3:42 PM, Greg Kroah-Hartman wrote:
> > On Tue, Sep 17, 2024 at 03:15:17PM -0500, Stuart Hayes wrote:
> > > Modify device_shutdown() so that supplier devices do not wait for
> > > consumer devices to be shut down first when the devlink is sync state
> > > only, since the consumer is not dependent on the supplier in this case.
> > > 
> > > Without this change, a circular dependency could hang the system.
> > > 
> > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > 
> > What commit id does this fix?  Should it go to stable?
> > 
> > And what driver is causing this problem, is this a regression or for
> > something new that just got added to the tree?
> > 
> > thanks,
> > 
> > greg k-h
> 
> This fixes commit 8064952c65045f05ee2671fe437770e50c151776, in
> driver-core-next & linux-next... it's problem with code that was just
> added to the tree (in drivers/base/core.c).  It is not in stable.

Ah, that wasn't obvious, sorry.

> Apologies, I should have mentioned that from the start.

Can you resend this with a "Fixes:" tag in it so I can just take it that
way and not have to edit it by hand?

thanks,

greg k-h

