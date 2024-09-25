Return-Path: <linux-kernel+bounces-338334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB48985690
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC911C23542
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56B15F3EF;
	Wed, 25 Sep 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ytgoIxhf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB1156257;
	Wed, 25 Sep 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257350; cv=none; b=Z4i7/j3XcMefK5brFCXLZLRc54OduHCVKGFFKgWp1L4zzg3o9F4m9JYcNaKhr2WlP/zrgGyoywkXgsIpsR412J9S5cKCnXSZd135vIWLsdq75FRpn9vMFWg5nSrYY5j3IiAY6P1vUu8HqmwpPjq5oo1KurYI6kwnArnBgLmIogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257350; c=relaxed/simple;
	bh=z43cm35NTQKjkq8L/gKFKS5OWkLXSBRu1T2N619A1us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwtCDXO15gK6JDwELZSbpJrhcVqBtn3eCGBuAaINpwuXv4b/HO22JBQdWGOENLFNaKhi+NGouzIHvJsXHlLJGRL7yKIx7G1ppnWRqlwcTx3ZHFxLRBLYcOlVwsjVZ4osWthQbGAIzVcieT4CbUpPacRzHVY+jQ6+CtStIyiGZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ytgoIxhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA88EC4CEC3;
	Wed, 25 Sep 2024 09:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727257349;
	bh=z43cm35NTQKjkq8L/gKFKS5OWkLXSBRu1T2N619A1us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ytgoIxhfAXmrgBFBqv+2lBKcnRBhG1/77pcFmOLZ16VBsecSVirvnz01DDWDajZQR
	 tveaSpYnNAyV5WsZArj0dxGpKniezFrGjITuK+2GY5E8Qgi5T6LXcuGw0emu32kQPN
	 LxcceCP+RobNhaGlAX73Iq7/5fHxjLZ76yeq9VVE=
Date: Wed, 25 Sep 2024 11:42:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-usb@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: thunderbolt: Use common error handling code in
 update_property_block()
Message-ID: <2024092511-eloquent-unselect-a0e8@gregkh>
References: <26b7f215-4f83-413c-9dab-737d790053c0@web.de>
 <20240925084501.GY275077@black.fi.intel.com>
 <a0c37886-cf9e-4c4c-8ff2-db8735f97cb6@web.de>
 <20240925093538.GZ275077@black.fi.intel.com>
 <10630d7d-9cea-40e1-8140-eb79c06f5c0f@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10630d7d-9cea-40e1-8140-eb79c06f5c0f@web.de>

On Wed, Sep 25, 2024 at 11:40:09AM +0200, Markus Elfring wrote:
> > It is fine to use goto as it is described in the document you linked but
> > this what you are doing is certainly not fine, at least in the code I'm
> > maintaining:
> >
> > out_unlock:
> >  	mutex_unlock(&xd->lock);
> >   	mutex_unlock(&xdomain_lock);
> > 	return;
> >
> > out_free_dir:
> > 	tb_property_free_dir(dir);
> > 	goto out_unlock;
> >
> > This "goto out_unlock" adds another goto to upwards which makes it
> > really hard to follow because the flow is not anymore just downwards.
> 
> Would you like to benefit any more from the application of
> scope-based resource management?

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

