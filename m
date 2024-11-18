Return-Path: <linux-kernel+bounces-412733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE68A9D0E70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC981F21BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B19519259B;
	Mon, 18 Nov 2024 10:24:00 +0000 (UTC)
Received: from sundtek.de (sundtek.de [85.10.198.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3054405FB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.198.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925439; cv=none; b=Q4xCm79NTPgaJCLv/hB3+z+s6Hiy3c+bqwC9qjUUB5rgQv8ZpUBcv9LdHGUugGi5EwoKG7M9zPJxkwYPihCLYuEplPG/Ha7fBHyQXL86Qj83FVg/Db77dCyRG7j7H0m1S13gFyMwH406IlsC8aRDq+haYZzHRNhxvFjb3GX1tMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925439; c=relaxed/simple;
	bh=4k5nHpQh5+fmekx6Pcnk6Yc+75yX5C7DdKVM2SLYAsg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FqyfpU6SgXURj6IMFuJzFe3ZsXeSkG75zYhOf50mam0u5UfPYbK6WquHY/sM7EWXBuCp0R55mLXvzhVPkUVa7F61ia7SLdTHcMNswxX1xDGTfrASyXWUoO0gmV3TStM+9l8+CZAfPj76MsuXQlgKrIhmwkUeIFNB7ovCS1ZQJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de; spf=pass smtp.mailfrom=sundtek.de; arc=none smtp.client-ip=85.10.198.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sundtek.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sundtek.de
Received: from Debian-exim by sundtek.de with spam-scanned (Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tCyvC-000BTY-8R
	for linux-kernel@vger.kernel.org;
	Mon, 18 Nov 2024 11:23:56 +0100
Received: from 220-143-194-41.dynamic-ip.hinet.net ([220.143.194.41] helo=[192.168.2.197])
	by sundtek.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <linuxusb.ml@sundtek.de>)
	id 1tCyv5-000BT5-Q6;
	Mon, 18 Nov 2024 11:23:48 +0100
Message-ID: <16f3a291439a94751b1b68f21507bae4de8dc011.camel@sundtek.de>
Subject: Re: [PATCH] XHCI NULL Pointer check in xhci_check_bw_table
From: Markus Rechberger <linuxusb.ml@sundtek.de>
To: Mathias Nyman <mathias.nyman@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 18 Nov 2024 18:23:42 +0800
In-Reply-To: <4ce9b10dff6eecf78cee53b6f34d4e6f8df37b59.camel@sundtek.de>
References: <b90d48df16cf74bb682af870cd71d7c5cc4a9d97.camel@sundtek.de>
	 <a02cfe06-b227-431f-baa1-a504857a8dea@linux.intel.com>
	 <4ce9b10dff6eecf78cee53b6f34d4e6f8df37b59.camel@sundtek.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: linuxusb.ml@sundtek.de
X-SA-Exim-Scanned: No (on sundtek.de); SAEximRunCond expanded to false

On Mon, 2024-11-18 at 17:51 +0800, Markus Rechberger wrote:
> On Mon, 2024-11-18 at 11:36 +0200, Mathias Nyman wrote:
> > Hi
> >=20
> > On 17.11.2024 17.32, Sundtek wrote:
> > > This patch fixes a NULL Pointer exception when a device using the
> > > XHCI
> > > controller driver is not properly initialized. It's relatively
> > > easy
> > > to
> > > reproduce with a faulty connection to a USB Harddisk / USB
> > > Ethernet
> > > adapter.
> > > The way I used for testing this patch was to short USB D+/D- and
> > > pull
> > > them to ground.
> > >=20
> > > We manufacture our own USB devices and use Linux for testing,
> > > lately we
> > > upgraded the system to Ubuntu noble with Kernel 6.8.0 and our
> > > system
> > > also crashed multiple times just when plugging in some devices
> > > (no
> > > commands need to be executed).
> > > We connect/disconnect devices > 100 times (eg uploading firmware,
> > > do
> > > electrical tests etc).
> > >=20
> > > I would rate this issue as highly critical.
> > > The problem is triggered via some fallback code in hub.c, a
> > > second
> > > patch will follow which
> > > removes the endpoint reset in the particular fallback.
> > >=20
> >=20
> >=20
> > > 2024-11-16T22:14:12.122224+08:00 sundtek-UX32VD kernel: RIP:
> > > 0010:xhci_check_bw_table+0x100/0x4d0
> >=20
> > This looks very similar to a null pointer issue I fixed recently.
> > Patch should be in 6.11 and recent stable releases:
> >=20
> > af8e119f52e9 xhci: Fix Panther point NULL pointer deref at full-
> > speed
> > re-enumeration
> >=20
> > What kernel are you running?
>=20
>=20
> thanks for pointing out to that, I was testing this on Linux 6.8.12.
> I will recompile the latest kernel and double check.
>=20
> your one:
> [46711.125623] Workqueue: usb_hub_wq hub_event [usbcore]
> [46711.125668] RIP: 0010:xhci_reserve_bandwidth
> (drivers/usb/host/xhci.c
>=20
> vs my one:
> kernel: Workqueue: usb_hub_wq hub_event
> kernel: RIP: 0010:xhci_check_bw_table+0x100/0x4d0
>=20
> https://sundtek.de/support/uxvd32.txt


I just added your patch to 6.8.10 / 6.8.12 it also fixes the problem.

CVE:
https://www.cve.org/CVERecord/?id=3DCVE-2024-45006

Nothing to do for me here great.

the issue is resolved but needs to be addressed by the distributions
now. Ubuntu is currently shipping their stable kernel with this
critical bug.

Best Regards,
Markus

