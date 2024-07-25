Return-Path: <linux-kernel+bounces-261940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD093BE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC39A2841D1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE0182A4A;
	Thu, 25 Jul 2024 08:35:29 +0000 (UTC)
Received: from queue02c.mail.zen.net.uk (queue02c.mail.zen.net.uk [212.23.3.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989B17838C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721896529; cv=none; b=odDFeCXMJ/fubmHR5wukaZ5m2eYnPXwddQfcZ+Rfpe/lDr2WUKN9Des+PCobYsfUZ/ZXavluIYW9pY1PqMAWVhQgb/mdGAcF3YxX14dy3k77yIDW6FK/F6y7Lzbi0RPSZW8C1s2M3gwjsAsi9xKjndLKPqPmHG9TpKxOdamBcG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721896529; c=relaxed/simple;
	bh=gqDo4P9dLW18uyVec7usjdXq0RUm77HCp5pDOwOKQA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djIh/jutmeac68WaC8A6Q8rcJhnrZCREsKkSQnjSsr0dYzV6dcyd0ogfim9dBExpjrTHe4RwZaLU4pdj56zSRYCBfszLDGbZuf2DirwxwgEy4nLWptcnDSURHeSMEh5pSvZWbro0g7VKUKmnNrb7R7/XmJV7pVlpmiMT4PlLq0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk; spf=pass smtp.mailfrom=dingwall.me.uk; arc=none smtp.client-ip=212.23.3.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dingwall.me.uk
Received: from [212.23.1.21] (helo=smarthost01b.ixn.mail.zen.net.uk)
	by queue02c.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <james@dingwall.me.uk>)
	id 1sWthX-000y2w-Ig
	for linux-kernel@vger.kernel.org;
	Thu, 25 Jul 2024 08:19:51 +0000
Received: from [217.155.64.189] (helo=mail0.xen.dingwall.me.uk)
	by smarthost01b.ixn.mail.zen.net.uk with esmtpsa  (TLS1.0) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.95)
	(envelope-from <james@dingwall.me.uk>)
	id 1sWthP-002WFj-LT;
	Thu, 25 Jul 2024 08:19:44 +0000
Received: from localhost (localhost [IPv6:::1])
	by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id 265C0A63B15;
	Thu, 25 Jul 2024 09:19:44 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([IPv6:::1])
	by localhost (mail0.xen.dingwall.me.uk [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id hW1WW-2RckBx; Thu, 25 Jul 2024 09:19:44 +0100 (BST)
Received: from behemoth.dingwall.me.uk (behemoth.dingwall.me.uk [IPv6:2a02:8010:698e:302::c0a8:105])
	by dingwall.me.uk (Postfix) with ESMTP id EE0C5A63B12;
	Thu, 25 Jul 2024 09:19:43 +0100 (BST)
Received: by behemoth.dingwall.me.uk (Postfix, from userid 1000)
	id C6646D7BA63; Thu, 25 Jul 2024 09:19:43 +0100 (BST)
Date: Thu, 25 Jul 2024 09:19:43 +0100
From: James Dingwall <james@dingwall.me.uk>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xen/evtchn.c: Interrupt for port 32, but apparently not enabled;
 per-user 0000000012b765d1
Message-ID: <ZqIKnydM6hjt/CEG@dingwall.me.uk>
References: <ZqEA5BnhTYsxMq/f@dingwall.me.uk>
 <bf1f5bfa-446c-4aea-a092-8cd9e7a786c3@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1f5bfa-446c-4aea-a092-8cd9e7a786c3@suse.com>
X-Originating-smarthost01b-IP: [217.155.64.189]
Feedback-ID: 217.155.64.189

On Wed, Jul 24, 2024 at 03:55:40PM +0200, Juergen Gross wrote:
> On 24.07.24 15:25, James Dingwall wrote:
> > I have built a kernel derived from Ubuntu's Ubuntu-hwe-6.8-6.8.0-40.40_22.04.1
> > tag.  The logs are quiet until I start the first guest which has two network
> > cards passed through.  At this point the kernel log gets flooded with the
> > warning below.  This appears to the same warning which this commit was
> > supposed to suppress:
> > 
> > 51c23bd691c0f1fb95b29731c356c6fd69925d17: xen/evtchn: avoid WARN() when unbinding an event channel
> > 
> > The tag already includes that commit and in my config:
> > 
> > $ grep CONFIG_DEBUG_SHIRQ /boot/config-6.8.0-40-generic
> > # CONFIG_DEBUG_SHIRQ is not set
> > 
> > Could there be a related change which also needs to be picked or is there
> > the possibility that there is another trigger?
> 
> As the original reporter of the issue tested the patch to fix it,
> there seems to be another trigger. :-(

I've done some more testing, if I don't pass through a pci device then the
warning does not get emitted.  It looks like the existing patch works for
actions via the xen/evtchn device.  Does xen-pciback perform operations which
bypass the functions where either `evtchn->unbinding = true` or
`evtchn->enabled = true` get set?  Perhaps when xen-pcifront is being
initialised in the guest?

Thanks,
James

