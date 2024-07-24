Return-Path: <linux-kernel+bounces-260920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A3F93B03E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B7A1C20A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04AB157484;
	Wed, 24 Jul 2024 11:17:17 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B25695;
	Wed, 24 Jul 2024 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819837; cv=none; b=D6gIrhfBEsAUwNCbyLuFwVgaK7V6HfgyytuNy6kpTJA5DURQSfa51Q6diYUif/BEmDTW+Rn8OX5oOsO3y1E6MqIL+MfgBjn+RKK0T+pptRV4+j9T3Emb+EjA6PsELhFVzF1qsOXCTHU5gsMU5zT7MxDoB3NNVmytt+p7CeljUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819837; c=relaxed/simple;
	bh=NXMjWIjkbyNP+GMCDU/nnlIK03u7fA8we18RZAAGeHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqkQyBVR8q4/mykFfP8L/dvLKjYklD+YBf5NX5TNyvsbgmJw9676eDdK4C39w76FiWkWUPAsvtQwxSr5CzbzQMHJo9DkIacNF0nWAjAlS/knWwXXXrX8b0dygtnjzyjZwmv81GbrN+/1T7XQSsX9hzJo991nKiUO3+dKebHNPE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.molgen.mpg.de (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5A16E61E5FE01;
	Wed, 24 Jul 2024 13:16:46 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Brownell <david-b@pacbell.net>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] USB: core: hub_port_reset: Remove extra 40 ms reset recovery time
Date: Wed, 24 Jul 2024 13:15:23 +0200
Message-ID: <20240724111524.25441-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This basically reverts commit b789696af8b4102b7cc26dec30c2c51ce51ee18b
("[PATCH] USB: relax usbcore reset timings") from 2005.

This adds unneeded 40 ms during resume from suspend on a majority of
devices, where it’s not needed, like the Dell XPS 13 9360/0596KF, BIOS
2.21.0 06/02/2022 with

    $ usb-devices

    T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480  MxCh=12
    D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=1d6b ProdID=0002 Rev=06.09
    S:  Manufacturer=Linux 6.9.0-rc6-00047-g25a99e110f17 xhci-hcd
    S:  Product=xHCI Host Controller
    S:  SerialNumber=0000:00:14.0
    C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
    I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
    E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

    T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
    D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=0cf3 ProdID=e300 Rev=00.01
    C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
    I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
    E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
    E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
    I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
    E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
    E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms

    T:  Bus=01 Lev=01 Prnt=02 Port=03 Cnt=01 Dev#=  3 Spd=12   MxCh= 0
    D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
    P:  Vendor=04f3 ProdID=2234 Rev=11.11
    S:  Manufacturer=ELAN
    S:  Product=Touchscreen
    C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
    I:  If#= 0 Alt= 0 #EPs= 2 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
    E:  Ad=02(O) Atr=03(Int.) MxPS=  32 Ivl=2ms
    E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=1ms

    T:  Bus=01 Lev=01 Prnt=03 Port=04 Cnt=01 Dev#=  4 Spd=480  MxCh= 0
    D:  Ver= 2.01 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=0c45 ProdID=670c Rev=56.26
    S:  Manufacturer=CN09GTFMLOG008C8B7FWA01
    S:  Product=Integrated_Webcam_HD
    C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
    I:  If#= 0 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=00 Driver=uvcvideo
    E:  Ad=83(I) Atr=03(Int.) MxPS=  16 Ivl=4ms
    I:  If#= 1 Alt= 0 #EPs= 1 Cls=0e(video) Sub=02 Prot=00 Driver=uvcvideo
    E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

    T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=5000 MxCh= 6
    D:  Ver= 3.00 Cls=09(hub  ) Sub=00 Prot=03 MxPS= 9 #Cfgs=  1
    P:  Vendor=1d6b ProdID=0003 Rev=06.09
    S:  Manufacturer=Linux 6.9.0-rc6-00047-g25a99e110f17 xhci-hcd
    S:  Product=xHCI Host Controller
    S:  SerialNumber=0000:00:14.0
    C:  #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=0mA
    I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
    E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=256ms

The commit messages unfortunately does not list the devices needing this.
Should they surface again, these should be added to the quirk list for
USB_QUIRK_HUB_SLOW_RESET.

Fixes: b789696af8b4 ("[PATCH] USB: relax usbcore reset timings")
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: David Brownell <david-b@pacbell.net>
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4b93c0bd1d4b..487d5fe60f0c 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3110,7 +3110,7 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 			usleep_range(10000, 12000);
 		else {
 			/* TRSTRCY = 10 ms; plus some extra */
-			reset_recovery_time = 10 + 40;
+			reset_recovery_time = 10;
 
 			/* Hub needs extra delay after resetting its port. */
 			if (hub->hdev->quirks & USB_QUIRK_HUB_SLOW_RESET)
-- 
2.45.2


