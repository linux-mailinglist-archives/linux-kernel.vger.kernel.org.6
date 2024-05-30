Return-Path: <linux-kernel+bounces-195473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF638D4D53
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67769286131
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79D186E39;
	Thu, 30 May 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="LMgNvkDa"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F201DA53;
	Thu, 30 May 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717077446; cv=none; b=KWXmktQdTr5Iyd5AqdIpl7oC0OY2PnL2fPJXnUgt6N67F7tZlXp4af0HEg+00w6PXiTTaz3B7u+eSv4Egxeh0fcYHEM5tP0Z3hTiz6uIODZcPBwej0Da97XJBOkS2CSd0NmZXY/6DhGbrjodLXzHzi3PTmSMS8vDkzcrDz86trA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717077446; c=relaxed/simple;
	bh=X/4tvSc6exJycujJ6Oy02jJMwIqe7aAn9t1ImHOdTkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sw2WKlUU/KKVb6Cd7AEWX/GzkhlV26YO8WjE8f0ap+geFg5830cBhStj0amMH9pcMU0YnQ3wsG2Hae1ZCv8/Hhskj5cb5pkHoIIPc4gMAbW18vRNWWrq/tcyfc1WIelOdSjKJrbGKal78V1d45MLVTgTPPBfxNuMLV/tPt4Lq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=LMgNvkDa; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1717077442; bh=X/4tvSc6exJycujJ6Oy02jJMwIqe7aAn9t1ImHOdTkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMgNvkDac3vrvSUVNdZ9fHYPejRd8uhV/SaZkePvh/vy6hEWGi37691f+xSUzGS6B
	 WEWQs3r41vYc8dJHAM03a8VfAcwK4ie00mV8Ol4zZTB6ZNP6KgrQi2CU5eL3go7V2G
	 3ur18Yj0ISfk1EaAEx5teiZY3+tYpo+r5ZxWERGE=
Date: Thu, 30 May 2024 15:57:22 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>, 
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
Message-ID: <1258a064-e23f-4079-b1f5-59017c28a210@t-8ch.de>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <6d5c2ee5-6e0e-4d13-a977-493d2ee2c0ed@t-8ch.de>
 <9c7e050b-0e73-4388-bc58-5c4d3ed4f50a@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c7e050b-0e73-4388-bc58-5c4d3ed4f50a@roeck-us.net>

On 2024-05-30 06:47:17+0000, Guenter Roeck wrote:
> On 5/30/24 03:51, Thomas Weißschuh wrote:
> > On 2024-05-29 13:52:03+0000, Guenter Roeck wrote:
> > > Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
> > > sensors. Such sensors are typically found on DDR5 memory modules.
> > > 
> > > Cc: René Rebe <rene@exactcode.de>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > > Tested on MAG B650 TOMAHAWK WIFI with CMH32GX5M2B6000Z30
> > > (Corsair Venegance DDR5).
> > > 
> > > René: I included you as MODULE_AUTHOR since the patch is derived from
> > >        your driver. Please let me know if you prefer not to be listed as
> > >        author.
> > > 
> > >   Documentation/hwmon/index.rst   |   1 +
> > >   Documentation/hwmon/spd5118.rst |  60 ++++
> > >   drivers/hwmon/Kconfig           |  12 +
> > >   drivers/hwmon/Makefile          |   1 +
> > >   drivers/hwmon/spd5118.c         | 482 ++++++++++++++++++++++++++++++++
> > >   5 files changed, 556 insertions(+)
> > >   create mode 100644 Documentation/hwmon/spd5118.rst
> > >   create mode 100644 drivers/hwmon/spd5118.c
> > 
> > With the Makefile and detect callback fixed:
> > 
> > Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> > Tested-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Thanks a lot for the feedback!
> 
> If it is not too much trouble, could you send me a register dump ?
> The one I have is from Montage Technology M88SPD5118, and I'd like to get
> a few more to improve my module test script.

From a Kingston KF556S40-32:

# i2cdump 20 0x50
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 51 18 0a 86 32 03 32 00 00 00 00 07 ff 3c 00 00    Q???2?2....?.<..
10: 00 00 00 00 00 00 00 00 00 00 00 00 70 03 00 00    ............p?..
20: 50 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00    P?..............
30: 00 f0 01 00 00 00 00 00 00 00 00 00 00 00 00 00    .??.............
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

