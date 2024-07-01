Return-Path: <linux-kernel+bounces-235791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34E91D9B1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91971F219DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D33823DE;
	Mon,  1 Jul 2024 08:09:34 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBAD347B4;
	Mon,  1 Jul 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821374; cv=none; b=ltG2LVnsM1vllnYqbYXDuEQSNxWdt0iwdRA1523s5isFp27MLHq9XpMnbf3SUE5wqAxdNYa2Yx02xV4xrYWOPh7kMvi5gceE7Oa0EuzExboVNPr0B9XLBBsj/lQs85J4piYNk1/l5CWT8GYFoVGX1dKgo1m7MEUrE5B+QnyICCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821374; c=relaxed/simple;
	bh=lusB39eljmjkSeTzESJvKRNx1NioaIrYok+tE4tYOBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPC9GObC3FZtRqYY1mnae+JKfRIG68CZVM0v/wsuSU1S8Poehm4F2oYFFkBL0i65zC0+iObc/nmpH7qanANVsOl/30gze5QtwCbmu39Py3Wd1vr5V2S36+3sbjSoYn0P9jZFM7XzR3aE+9bTRLuXl2qEyWKrRuscn+PqGl8rhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 974822800B1D8;
	Mon,  1 Jul 2024 10:09:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 78EA34D3E0; Mon,  1 Jul 2024 10:09:29 +0200 (CEST)
Date: Mon, 1 Jul 2024 10:09:29 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH V4 1/3] platform/x86/intel/sdsi: Add ioctl SPDM transport
Message-ID: <ZoJkOYwmvx3SnEr6@wunner.de>
References: <20240608034247.181843-1-david.e.box@linux.intel.com>
 <ZmRSwpRWEgw2GxF1@wunner.de>
 <c58a850758d106f9613c9ba5882e9988712394de.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c58a850758d106f9613c9ba5882e9988712394de.camel@linux.intel.com>

On Fri, Jun 14, 2024 at 02:17:23PM -0700, David E. Box wrote:
> On Sat, 2024-06-08 at 14:46 +0200, Lukas Wunner wrote:
> > > On Fri, Jun 07, 2024 at 08:42:45PM -0700, David E. Box wrote:
> > > > > Intel On Demand adds attestation and firmware measurement retrieval
> > > > > services through use of the protocols defined the Security Protocols
> > > > > and Data Measurement (SPDM) specification.
> > > 
> > > I've amended the in-kernel SPDM implementation to expose signatures
> > > received from the device in sysfs, together with all ancillary data
> > > necessary to re-verify signatures from user space (transcript, hash
> > > algorithm, etc). It is also possible to set the next requester nonce
> > > from user space if the kernel is mistrusted to always use a fresh nonce.
> > > 
> > > I recall S3M folks rejected use of the in-kernel SPDM implementation for
> > > SDSi because it previously didn't allow for re-verification of signatures
> > > by user space.
> 
> Yes, this was the main reason for not going with the in-kernel solution.
> 
> > > Perhaps with the added functionality they'll reconsider?
> 
> Q3 is too late for their needs. They want to proceed with the driver
> solution. We can push for using the in-kernel solution when it is
> upstreamed. I think this will be possible when they extend support
> beyond SPDM v1.0.

Fair enough.  I've submitted v2 of the in-kernel SPDM library yesterday:

https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/

It would be good to know if the ABI for exposure of certificates and
signatures makes sense and would integrate easily with SDSi user space
tooling.  Or if it does not, how I should change it.  So I'd love
to hear feedback.  The ABI documentation is contained in these patches:

* [PATCH v2 12/18] PCI/CMA: Expose certificates in sysfs
  https://lore.kernel.org/all/e42905e3e5f1d5be39355e833fefc349acb0b03c.1719771133.git.lukas@wunner.de/
* [PATCH v2 15/18] PCI/CMA: Expose a log of received signatures in sysfs
  https://lore.kernel.org/all/77f549685f994981c010aebb1e9057aa3555b18a.1719771133.git.lukas@wunner.de/
* [PATCH v2 16/18] spdm: Limit memory consumed by log of received signatures
  https://lore.kernel.org/all/2e6ee6670a5d450bc880e77a892ea0227a2cc3b4.1719771133.git.lukas@wunner.de/
* [PATCH v2 17/18] spdm: Authenticate devices despite invalid certificate chain
  https://lore.kernel.org/all/dff8bcb091a3123e1c7c685f8149595e39bbdb8f.1719771133.git.lukas@wunner.de/
* [PATCH v2 18/18] spdm: Allow control of next requester nonce through sysfs
  https://lore.kernel.org/all/ee3248f9f8d60cff9106a5a46c5f5d53ac81e60a.1719771133.git.lukas@wunner.de/

This doesn't yet contain measurement retrieval, which I understand
is needed for SDSi.  I intend to add it this (third) quarter.

Thanks,

Lukas

