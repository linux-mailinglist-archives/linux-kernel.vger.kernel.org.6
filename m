Return-Path: <linux-kernel+bounces-214834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC23908AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0C528174E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9978C90;
	Fri, 14 Jun 2024 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sjsktzDM"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97721192B8F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718364673; cv=none; b=dtw/WM/eT72C5a1lALGuK9nYNqqVa67kNvmnqhegXLPcEPWdO+aHpQAXxcVdsz685a67DxOeOsIv2cg2hQkplDysymxeRu1DWKkuyTxokUfPQYNIKYPA4m+4B7o/qof8yp2uy0eZhGvw+tQ4X0/icC+1tV4iyLQPaMyvh80NihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718364673; c=relaxed/simple;
	bh=IJo0FAkQ1EUXfJg9WtcGbgCGmKYYwaHsN9tJBx1WxvM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=d69iwD9fJbtsjMd/vBcOqOAsBvonDRBwqCBXj8y2eKRxAyCBkQrOlExQfHgf9ldZkkaZNRGPCY3tEVlemvAg0CZR1Q9YkVEGN7Tb2HXh28O9CCyJ6drSEpNMbS8hVzH+XXs3o8w7LoYepESkc7+P0ZLzY/b/OMc1qhZbEgFahFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=sjsktzDM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BD9AD397;
	Fri, 14 Jun 2024 13:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718364654;
	bh=IJo0FAkQ1EUXfJg9WtcGbgCGmKYYwaHsN9tJBx1WxvM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sjsktzDM3GijgQAIAxtA0FpmeV+K5XjihjO/ayU2AbQuDJM3FcJuEQhrRuWUVPD5W
	 BvTXRHLs/HeRFj44vryU8PFNqYMkTT3vjvaSvT/0MYK42T01Sa6qiKlOikCviR/yBA
	 3JNCuDKOgfuKWqvqxlNVDag6JI6+nvlw2Dl/4ytw=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <37779db2-114c-4df6-97fd-2444bdad5529@gmx.net>
References: <20240614104339.3858830-1-kieran.bingham@ideasonboard.com> <37779db2-114c-4df6-97fd-2444bdad5529@gmx.net>
Subject: Re: [v2 PATCH] staging: vc04_services: vchiq_arm: Fix initialisation check
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Stevenson <dave.stevenson@raspberrypi.org>, detule <ogjoneski@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>, open list:STAGING SUBSYSTEM <linux-staging@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>;
To: Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>, linux-rpi-kernel@lists.infradead.org
Date: Fri, 14 Jun 2024 12:31:06 +0100
Message-ID: <171836466631.2248009.16741779932900773222@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Quoting Stefan Wahren (2024-06-14 12:00:38)
> Hi Kieran,
>=20
> Am 14.06.24 um 12:43 schrieb Kieran Bingham:
> > The vchiq_state used to be obtained through an accessor
> > which would validate that the VCHIQ had been initialised
> > correctly with the remote.
> >
> > In commit 42a2f6664e18 ("staging: vc04_services: Move global g_state to
> > vchiq_state") the global state was moved to the vchiq_mgnt structures
> > stored as a vchiq instance specific context. This conversion removed the
> > helpers and instead replaced users of this helper with the assumption
> > that the state is always available and the remote connected.
> >
> > Fix this broken assumption by re-introducing the logic that was lost
> > during the conversion.
> >
> > Fixes: 42a2f6664e18 ("staging: vc04_services: Move global g_state to vc=
hiq_state")
> > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> > ---
> > v2:
> >   - No change, just resend
> what happen to my comments for the first version?

Err ... i missed them ... let me go back and look!

--
Kieran

