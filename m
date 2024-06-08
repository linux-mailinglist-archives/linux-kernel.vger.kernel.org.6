Return-Path: <linux-kernel+bounces-207035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D871090117E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 14:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7111B2826AC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 12:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6511A1779AB;
	Sat,  8 Jun 2024 12:47:12 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A9E57D;
	Sat,  8 Jun 2024 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717850832; cv=none; b=Ub1gRC9bE3nWONR5PlyDDZIXghEBsotQ8KE1bJQGNoC2XK8fQ+cv8haOLCJf00XPqADiJdYFb1PJr1sKniDrzdTwuRf53eQDW5vSeCXNasu4amOYyy/1xY9gw0wsg/uwv+A39LkwPlYirXyqTtvt9w1fzpdgsZzRuYllG9ZwGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717850832; c=relaxed/simple;
	bh=ac9mwoDB9T++uWUEsjCagCvdVLFqoGK/o1b2Dp4iTls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN4CGKuMTm+5yOaV1F8bMRRSGPklq/StP0Bb1UJovnOdh8s73ft3F/4jR+YuAAs/LFJwaFfzXP1Teq1MwPtDseDA2tXZZSqnYbRlWBLclXAElYP5BvJTFKw2JgrAn6Nh+gZatlrNlXJXkm3m7dAdQPonvR8TMrLAxZBea/kXZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 126263000A47C;
	Sat,  8 Jun 2024 14:46:59 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E6E2A67565A; Sat,  8 Jun 2024 14:46:58 +0200 (CEST)
Date: Sat, 8 Jun 2024 14:46:58 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH V4 1/3] platform/x86/intel/sdsi: Add ioctl SPDM transport
Message-ID: <ZmRSwpRWEgw2GxF1@wunner.de>
References: <20240608034247.181843-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608034247.181843-1-david.e.box@linux.intel.com>

On Fri, Jun 07, 2024 at 08:42:45PM -0700, David E. Box wrote:
> Intel On Demand adds attestation and firmware measurement retrieval
> services through use of the protocols defined the Security Protocols and
> Data Measurement (SPDM) specification. SPDM messages exchanges are used to
> authenticate On Demand hardware and to retrieve signed measurements of the
> NVRAM state used to track feature provisioning and the NVRAM state used for
> metering services. These allow software to verify the authenticity of the
> On Demand hardware as well as the integrity of the reported silicon
> configuration.
> 
> Add an ioctl interface for sending SPDM messages through the On Demand
> mailbox. Provides commands to get a list of SPDM enabled devices, get the
> message size limits for SPDM Requesters and Responders, and perform an SPDM
> message exchange.

I've amended the in-kernel SPDM implementation to expose signatures
received from the device in sysfs, together with all ancillary data
necessary to re-verify signatures from user space (transcript, hash
algorithm, etc).  It is also possible to set the next requester nonce
from user space if the kernel is mistrusted to always use a fresh nonce.

See the two top-most commits on this branch:

https://github.com/l1k/linux/commits/doe

I intend to submit these patches by end of June.  There are two things
still missing before I can resubmit:  Exposure of certificate chains in
sysfs (currently a WIP) and expiration of older signatures (to limit the
amount of memory consumed for their storage).  After submission, I intend
to forward-port your measurement patch in Q3.

I recall S3M folks rejected use of the in-kernel SPDM implementation for
SDSi because it previously didn't allow for re-verification of signatures
by user space.  Perhaps with the added functionality they'll reconsider?

Thanks,

Lukas

