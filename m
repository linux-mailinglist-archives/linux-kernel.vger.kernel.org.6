Return-Path: <linux-kernel+bounces-214807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73266908A53
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7C028C9D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF5C1946D9;
	Fri, 14 Jun 2024 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pOz6eajc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F57194AF0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361670; cv=none; b=KjOQY5pMIONYdn9tNzM8QZu1d7ydh9UIRz9kmpxiFgw3DRDHkgzwlGuNLbgA7imirzXUFr42phm0Drig3q4ckpJGO6+eJIeBT4wJcEsa3PYsGRElhonDnOUNftDPrEKqAjMDJNtrymQvoI+2hBTuXuGR0ySa5pBvMIefLudxGt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361670; c=relaxed/simple;
	bh=fR5O23eHFUud678VEBckctrC86/Dv5g0dvv4PUadpzA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=IgUvoDK8DacweyKAxz3gbkwuEyCwgEOHpKZjjomHZrAwHFDfSXkUjlDqkgLaU/yqxXutyzkS2WjzhXiPYbVfKSL/YjLh2K0UlDO4a++fDIiQ6Nj/AtlbOgFMRlC02yBn9heiN0Yp+GNWK4AAIoKeN143njFruYW4zDxrbKaf+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pOz6eajc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1EE88B53;
	Fri, 14 Jun 2024 12:40:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718361650;
	bh=fR5O23eHFUud678VEBckctrC86/Dv5g0dvv4PUadpzA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=pOz6eajcv2YAkl8f4GlFN7CGZVF1hq5qrUsUky03sFd6sPPsSy5cL+lNTBCGTWTzR
	 A69m1n/8xI1VNTT33zwGv1IuKDaa6uGFxafOevwIA1CStAPgW9HMr3g14FdBuMkzF5
	 pqPjUf2q/YDqZhiYylgonSwxjwKmSKy9e4Z3nFWk=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2024061436-twister-survival-a05c@gregkh>
References: <20240613194150.2915202-1-kieran.bingham@ideasonboard.com> <20240613194150.2915202-2-kieran.bingham@ideasonboard.com> <2024061436-twister-survival-a05c@gregkh>
Subject: Re: [PATCH] staging: vc04_services: vchiq_arm: Fix initialisation check
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>, Florian Fainelli <florian.fainelli@broadcom.com>, linux-rpi-kernel@lists.infradead.org, Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Stefan Wahren <wahrenst@gmx.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Stevenson <dave.stevenson@raspberrypi.org>, detule <ogjoneski@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>, open list:STAGING SUBSYSTEM <linux-staging@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>;
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 14 Jun 2024 11:41:02 +0100
Message-ID: <171836166207.2248009.279146431554771910@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Greg Kroah-Hartman (2024-06-14 07:50:08)
> On Thu, Jun 13, 2024 at 08:41:46PM +0100, Kieran Bingham wrote:
> > The vchiq_state used to be obtained through an accessor
> > which would validate that the VCHIQ had been initialised
> > correctly with the remote.
> >=20
> > In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
> > vchiq_state") the global state was moved to the vchiq_mgnt structures
> > stored as a vchiq instance specific context. This conversion removed the
> > helpers and instead replaced users of this helper with the assumption
> > that the state is always available and the remote connected.
> >=20
> > Fix this broken assumption by re-introducing the logic that was lost
> > during the conversion.
> >=20
> > Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vc=
hiq_state")
> > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > ---
> >  .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c  | 4 ++--
> >  .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 5 +++++
> >  .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c  | 7 ++++++-
> >  3 files changed, 13 insertions(+), 3 deletions(-)
>=20
> You sent 2 different patches here, both with the same subject, which one
> is correct?

What in the git ... ? (history formatted to new lines..)

kbingham@Monstersaurus:~/iob/libcamera/raspberrypi/sources/linux$ history |=
 grep send-email
 2427  git send-email \
 	./0001-staging-vc04_services-vchiq_arm-Fix-initialisation-c.patch \
 	--cc-cmd ./scripts/get_maintainer.pl \
	./0001-staging-vc04_services-vchiq_arm-Fix-initialisation-c.patch \
	--to "Umang Jain <umang.jain@ideasonboard.com>" \
	--to "Florian Fainelli <florian.fainelli@broadcom.com>" \
	--to "linux-rpi-kernel@lists.infradead.org"

I .... uh ... somehow specified the patch twice...

So both mails are the identical patch. Would you like me to send a third
identical one as a v2? or pick either of these?

in fact - never mind - v2 coming.

--
Kieran


>=20
> Please send a v2 so that I know what to apply, I've dropped this one
> from my queue now, thanks.
>=20
> greg k-h

