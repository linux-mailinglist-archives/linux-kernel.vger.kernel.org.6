Return-Path: <linux-kernel+bounces-262272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 179C293C350
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A053AB20E58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6419F19B3F9;
	Thu, 25 Jul 2024 13:50:20 +0000 (UTC)
Received: from queue02a.mail.zen.net.uk (queue02a.mail.zen.net.uk [212.23.3.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D6819AD6A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721915420; cv=none; b=C/JF9DmamXqyY82hJ7ztpfgTvBEdHHZl2pp1jd5PN3E0ghHSDiji8a+ciFmxAX3A63W9V/9jbAtIM+sTzN4SOLvOZMG+P67lsxXawGVizx7r2fWKk7CaglqjbZNHXSOZag3cWJ3wBT/UBhySHpJ0MLWAWxnaKUDnMVy865l5D/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721915420; c=relaxed/simple;
	bh=69/EOHSFFTeljVAy2BODU2O5TZOfOAwXRywKRiWAny0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3DV5uGVvU2vFCf7FheXEF3YyckJCxHl1XGW9kVipMixTfdaLaqkggwTHPMDEN2k6HtYDBjqLsFvwGzwuu3gVmx27155x8dfCONLaSW0gGo9AX5X0IVNObkZI+JdQssicn1k7snXLMevZ9hGrXnDXZMupMLFUTKfmxTdvPQJRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk; spf=pass smtp.mailfrom=dingwall.me.uk; arc=none smtp.client-ip=212.23.3.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dingwall.me.uk
Received: from [212.23.1.3] (helo=smarthost01b.sbp.mail.zen.net.uk)
	by queue02a.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <james@dingwall.me.uk>)
	id 1sWyrB-002ol0-AN
	for linux-kernel@vger.kernel.org;
	Thu, 25 Jul 2024 13:50:09 +0000
Received: from [217.155.64.189] (helo=mail0.xen.dingwall.me.uk)
	by smarthost01b.sbp.mail.zen.net.uk with esmtpsa  (TLS1.0) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.95)
	(envelope-from <james@dingwall.me.uk>)
	id 1sWyr1-006iwt-VG;
	Thu, 25 Jul 2024 13:50:02 +0000
Received: from localhost (localhost [IPv6:::1])
	by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id 5154DA63F4D;
	Thu, 25 Jul 2024 14:50:01 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([127.0.0.1])
	by localhost (mail0.xen.dingwall.me.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JWIUroc67gqP; Thu, 25 Jul 2024 14:50:01 +0100 (BST)
Received: from behemoth.dingwall.me.uk (behemoth.dingwall.me.uk [IPv6:2a02:8010:698e:302::c0a8:105])
	by dingwall.me.uk (Postfix) with ESMTP id 34360A63F4A;
	Thu, 25 Jul 2024 14:50:01 +0100 (BST)
Received: by behemoth.dingwall.me.uk (Postfix, from userid 1000)
	id 197B4D7C268; Thu, 25 Jul 2024 14:50:01 +0100 (BST)
Date: Thu, 25 Jul 2024 14:50:00 +0100
From: James Dingwall <james@dingwall.me.uk>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xen/evtchn.c: Interrupt for port 32, but apparently not enabled;
 per-user 0000000012b765d1
Message-ID: <ZqJYCHDjtnpfPjKw@dingwall.me.uk>
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
> > Hi,
> > 
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

in evtchn.c `evtchn->enabled = true;` is set before `xen_irq_lateeoi()`.  In
the pciback code there is `xen_pcibk_lateeoi()` which adds a conditional
around `xen_irq_lateeoi()`.  Should that or perhaps just some callers set the
enabled flag for the event channel?  I don't pretend to understand the code
so I might be off on the wrong path and lost in the wilderness:)

Thanks,
James

