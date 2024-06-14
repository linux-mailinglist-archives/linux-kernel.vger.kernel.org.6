Return-Path: <linux-kernel+bounces-215494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A959093A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B9F1F22B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59927148FE1;
	Fri, 14 Jun 2024 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRD5gNqg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39387A954;
	Fri, 14 Jun 2024 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399846; cv=none; b=PEVRAyI167vf0AgQMPRZHGM4wVmgvXsNYkyEyajgXuvD85MMDH8TACML6iYFONE2V+zzIdF8IOIEWNzDb3OZ4BRMyfoIYa4C8fO4sOHMPTHgiFArHannTeo4y6NmRFIfD2fw3E+D1VxIA5pzB0dNHIPfGTega8SuYFbYDy6tz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399846; c=relaxed/simple;
	bh=McBTJ+sltYsxBktEenpEv8nVR5RGDdPc4GIejXNQ7GQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gpg7JF45X+L+iAjUaliSxNEY5RQd5OZCZkgiKnJ2YikVr0twNjV2/L4lLdmHj8nIxn4r/+0ALLWgCPXbndavmwuB0Y3m5TDBQaSfp31OFEIE6TPpDUWVge3RHCW8qi7Iqif/fnr1+A2fN9X/9JTeS9VzRIH33yAQyXl9Nx9O8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRD5gNqg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718399845; x=1749935845;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=McBTJ+sltYsxBktEenpEv8nVR5RGDdPc4GIejXNQ7GQ=;
  b=QRD5gNqg+C7DKcsMZuycq8QqRuFtOOpEyrr9d23RDy10OSHfJpeUWRZC
   14cB5dr/N2Xg/GIpMGpbVc/H4mTpLtZjhwvuxF5j/4DYvuiWRGGDXKeWT
   sYxoVRCzXkXzUfUNk4JzjU/n2xy2RupNJiPxR9YdD30+vLK+Q/jlJilwM
   REI0j8cb0FstatdJ+jU80uy3OVC5P51aPd3hXsUot6V0DTR5u1p6at24O
   PcphnS04MlNhPUOh8cYt+sEy8rhlazOXhEtIPNwMTxIuI5zi7H37QvdpH
   8JwmFkxZe3CzSBD3cU2VIeX+G1dG9qnblB3HG3zynLikF5uwzzS6JdV5u
   w==;
X-CSE-ConnectionGUID: UZwarCG9Rc+oWntG4qpRKg==
X-CSE-MsgGUID: i7aELlDaQAShZsrIJOPVoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19090581"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="19090581"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 14:17:24 -0700
X-CSE-ConnectionGUID: eWxmCZTOQWO5V/nWb63gTA==
X-CSE-MsgGUID: Nm2hoDPzTV64lh3kZKJFkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="45721702"
Received: from mabueed-mobl.amr.corp.intel.com ([10.209.6.246])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 14:17:24 -0700
Message-ID: <c58a850758d106f9613c9ba5882e9988712394de.camel@linux.intel.com>
Subject: Re: [PATCH V4 1/3] platform/x86/intel/sdsi: Add ioctl SPDM transport
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com, 
	hdegoede@redhat.com, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Date: Fri, 14 Jun 2024 14:17:23 -0700
In-Reply-To: <ZmRSwpRWEgw2GxF1@wunner.de>
References: <20240608034247.181843-1-david.e.box@linux.intel.com>
	 <ZmRSwpRWEgw2GxF1@wunner.de>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Lukas,

On Sat, 2024-06-08 at 14:46 +0200, Lukas Wunner wrote:
> > On Fri, Jun 07, 2024 at 08:42:45PM -0700, David E. Box wrote:
> > > > Intel On Demand adds attestation and firmware measurement retrieval
> > > > services through use of the protocols defined the Security Protocol=
s and
> > > > Data Measurement (SPDM) specification. SPDM messages exchanges are =
used
> > > > to
> > > > authenticate On Demand hardware and to retrieve signed measurements=
 of
> > > > the
> > > > NVRAM state used to track feature provisioning and the NVRAM state =
used
> > > > for
> > > > metering services. These allow software to verify the authenticity =
of
> > > > the
> > > > On Demand hardware as well as the integrity of the reported silicon
> > > > configuration.
> > > >=20
> > > > Add an ioctl interface for sending SPDM messages through the On Dem=
and
> > > > mailbox. Provides commands to get a list of SPDM enabled devices, g=
et
> > > > the
> > > > message size limits for SPDM Requesters and Responders, and perform=
 an
> > > > SPDM
> > > > message exchange.
> >=20
> > I've amended the in-kernel SPDM implementation to expose signatures
> > received from the device in sysfs, together with all ancillary data
> > necessary to re-verify signatures from user space (transcript, hash
> > algorithm, etc).=C2=A0 It is also possible to set the next requester no=
nce
> > from user space if the kernel is mistrusted to always use a fresh nonce=
.
> >=20
> > See the two top-most commits on this branch:
> >=20
> > https://github.com/l1k/linux/commits/doe
> >=20
> > I intend to submit these patches by end of June.=C2=A0 There are two th=
ings
> > still missing before I can resubmit:=C2=A0 Exposure of certificate chai=
ns in
> > sysfs (currently a WIP) and expiration of older signatures (to limit th=
e
> > amount of memory consumed for their storage).=C2=A0 After submission, I=
 intend
> > to forward-port your measurement patch in Q3.
> >=20
> > I recall S3M folks rejected use of the in-kernel SPDM implementation fo=
r
> > SDSi because it previously didn't allow for re-verification of signatur=
es
> > by user space.

Yes, this was the main reason for not going with the in-kernel solution.

> > =C2=A0 Perhaps with the added functionality they'll reconsider?

Q3 is too late for their needs. They want to proceed with the driver soluti=
on.
We can push for using the in-kernel solution when it is upstreamed. I think=
 this
will be possible when they extend support beyond SPDM v1.0.

David

> >=20
> > Thanks,
> >=20
> > Lukas


