Return-Path: <linux-kernel+bounces-223604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF15911571
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245A31C2267B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4465312FB31;
	Thu, 20 Jun 2024 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="onI9jwKU"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4D823DC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921515; cv=none; b=dy9l1fhRXUxCyYkPQNpO4Q8x9Qr3/Gc6HxB57C8Baa6XZ1fURpXeckpDfRVfPZGagggTUNQdQclr/dfUK+3SxDhertrUh1DgUUFdAztMe07z+aIbnw4xsKUJCxX0DuuzdrykW/sAyeoAVu0TDissSIsFkbd/gJX7KGMbmqfK4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921515; c=relaxed/simple;
	bh=43jVAsr+RH7Kb5bm4trBcVWqihxvkRbIbxWMNiHmxzM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=a2o2q0Dv1oIPONTdQ5FJfrfXjYl67gCHzz6V5+aesoTwLiH6Hk0tROuAecILEPWtef55bTiRVvt4BL6wABMZP/izGS3Ptaa0h5eNRGCxZctxw+NeiDwDPOJItwvHeF7kf8TZ9H5Ato4G7w34vr746/sJteL4Pu0OiZ0sF5K5Onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=onI9jwKU; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 52E7D3E6;
	Fri, 21 Jun 2024 00:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718921493;
	bh=43jVAsr+RH7Kb5bm4trBcVWqihxvkRbIbxWMNiHmxzM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=onI9jwKU1NofwySFLB4YL46fwi3axD0HCV4s36LRZq++0cQ/kqn4ejImlT8F4tdee
	 lRXdSW9mwxnqzHSItElYh+jb2ReZm3MB6j16YAzydz9cDx7UMGZ6vbplYQmKhnIBtV
	 xdk4tRjELcPm7KDHopXM5K8FFKiIiql74Z3SOLJU=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a2f08c04-ff9c-4854-b5a6-a3b84e20b50c@gmx.net>
References: <20240614104339.3858830-1-kieran.bingham@ideasonboard.com> <37779db2-114c-4df6-97fd-2444bdad5529@gmx.net> <171836466631.2248009.16741779932900773222@ping.linuxembedded.co.uk> <a2f08c04-ff9c-4854-b5a6-a3b84e20b50c@gmx.net>
Subject: Re: [v2 PATCH] staging: vc04_services: vchiq_arm: Fix initialisation check
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Stevenson <dave.stevenson@raspberrypi.org>, detule <ogjoneski@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>, STAGING SUBSYSTEM <linux-staging@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>, linux-rpi-kernel@lists.infradead.org
Date: Thu, 20 Jun 2024 23:11:49 +0100
Message-ID: <171892150987.2721985.9430352477415470900@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Stefan Wahren (2024-06-20 17:59:39)
> Hi Kieran,
>=20
> Am 14.06.24 um 13:31 schrieb Kieran Bingham:
> > Quoting Stefan Wahren (2024-06-14 12:00:38)
> >> Hi Kieran,
> >>
> >> Am 14.06.24 um 12:43 schrieb Kieran Bingham:
> >>> The vchiq_state used to be obtained through an accessor
> >>> which would validate that the VCHIQ had been initialised
> >>> correctly with the remote.
> >>>
> >>> In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state =
to
> >>> vchiq_state") the global state was moved to the vchiq_mgnt structures
> >>> stored as a vchiq instance specific context. This conversion removed =
the
> >>> helpers and instead replaced users of this helper with the assumption
> >>> that the state is always available and the remote connected.
> >>>
> >>> Fix this broken assumption by re-introducing the logic that was lost
> >>> during the conversion.
> >>>
> >>> Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to =
vchiq_state")
> >>> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> >>> ---
> >>> v2:
> >>>    - No change, just resend
> >> what happen to my comments for the first version?
> > Err ... i missed them ... let me go back and look!
> sorry for pestering, but could you please send v3 of the fix? I want to
> rebase my cleanup series on top of that, because bisecting vchiq is
> currently no fun.

I can imagine! Sorry for the delay, should be out on the lists and in
your inbox now.

--
Kieran


>=20
> Thanks
> Stefan
> >
> > --
> > Kieran
>

