Return-Path: <linux-kernel+bounces-264591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA0393E5B8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 16:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D3928185C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724DD55E4C;
	Sun, 28 Jul 2024 14:44:29 +0000 (UTC)
Received: from queue02b.mail.zen.net.uk (queue02b.mail.zen.net.uk [212.23.3.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D9B54BD4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722177869; cv=none; b=FdILvgmUU0NWjhsdl992/2BIVWTPGAkfo+qgO1kOfuYu/krFIcxFMtFVf2ral2GOX0RPUr9EtW9sj9Wvf1lMDNWlnZmYnACUk3PCW1hqbZ6y2R92fwF570KvV7bAFdyDSxQ24rg6vi4+YqLZXkNJq96zirSefOcmqfAzp2O+kPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722177869; c=relaxed/simple;
	bh=gLedHYMMxROl4wtpbb6L9x9yfvdfzURB0DuJ1796kec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt6e6zJcAlb+SPzZyksuFklDTotXuJuEaPDPQRdU3JjYvPLsLfmaHDCVlfQBQC/6E/fqZF4fR0ZgspAg/wpX3/pbyAACqkauPYsPSs9sWk7oM89eHZpOJFzE31qWD9ridOQq6hVeGR0tB6Z0GdtBW9Prl8WlaIaqKgKTLS+9l+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk; spf=pass smtp.mailfrom=dingwall.me.uk; arc=none smtp.client-ip=212.23.3.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dingwall.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dingwall.me.uk
Received: from [212.23.1.22] (helo=smarthost01c.ixn.mail.zen.net.uk)
	by queue02b.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <james@dingwall.me.uk>)
	id 1sY4sQ-003PsX-Jd
	for linux-kernel@vger.kernel.org;
	Sun, 28 Jul 2024 14:27:58 +0000
Received: from [217.155.64.189] (helo=mail0.xen.dingwall.me.uk)
	by smarthost01c.ixn.mail.zen.net.uk with esmtpsa  (TLS1.0) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.95)
	(envelope-from <james@dingwall.me.uk>)
	id 1sY4sJ-0098bD-JB;
	Sun, 28 Jul 2024 14:27:51 +0000
Received: from localhost (localhost [IPv6:::1])
	by mail0.xen.dingwall.me.uk (Postfix) with ESMTP id 0013BA67BE2;
	Sun, 28 Jul 2024 15:27:50 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at dingwall.me.uk
Received: from mail0.xen.dingwall.me.uk ([127.0.0.1])
	by localhost (mail0.xen.dingwall.me.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8YRaXTHu4zal; Sun, 28 Jul 2024 15:27:50 +0100 (BST)
Received: from ghoul.dingwall.me.uk (ghoul.dingwall.me.uk [192.168.1.200])
	by dingwall.me.uk (Postfix) with ESMTP id CB32DA67BDF;
	Sun, 28 Jul 2024 15:27:50 +0100 (BST)
Received: by ghoul.dingwall.me.uk (Postfix, from userid 1000)
	id C02D42C2; Sun, 28 Jul 2024 15:27:50 +0100 (BST)
Date: Sun, 28 Jul 2024 15:27:50 +0100
From: James Dingwall <james@dingwall.me.uk>
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xen/evtchn.c: Interrupt for port 32, but apparently not enabled;
 per-user 0000000012b765d1
Message-ID: <ZqZVZk4sUqFgX9RD@dingwall.me.uk>
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
X-Originating-smarthost01c-IP: [217.155.64.189]
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

I've managed to get the system working correctly by removing another kernel
parameter which we had needed in the past: `irqfixup`.  So without this or
`pci=nomsi` we appear to have correct behaviour with no workaround options
required.

Thanks,
James

