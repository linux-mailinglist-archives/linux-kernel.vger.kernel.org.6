Return-Path: <linux-kernel+bounces-576672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9415A712DC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B541C7A5F00
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F253E1A2C27;
	Wed, 26 Mar 2025 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="KyCrqoNk";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="h2goKGQl"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29919F48D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978439; cv=none; b=PaLWHdTKN4SAJ1r48iJQh9F0PiSzMprErwhDNnB//luR8lKw6mQpNixJFwLmzwpIZ8gf35trTuBQAIBYMyDCvl41B7PPdTG4OKNmBkzJ3JNAwtYu8xIwMm8K/cyE0dtwRme9SERvdHaHwkmjX6eCySKFVMupAm3vOHkSygXUOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978439; c=relaxed/simple;
	bh=0cRbGra4b0bceGn7QIieNJyYHJGW+QjN+ZSB/kGRFrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nc66Mh7UJ3JJ+tkw0u6p14pcr3XIaNXgGn7tPpXKJfB3VgvVQuop2AsLOvqPtuaesyQWtlCoBaqZJkcKh2yB7u1g9XsKvvUGpC24taoeKviIQL2FmShJJKxRkOSmfooPac4/FD5zjmAYG2sNnbZlghjgDwk9ebG3dLS+Au9YwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=KyCrqoNk; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=h2goKGQl; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1742977962;
	bh=0cRbGra4b0bceGn7QIieNJyYHJGW+QjN+ZSB/kGRFrs=;
	h=From:Date:Subject:To:Cc:From;
	b=KyCrqoNkC/Ia0M/HbiXwWcLsxM8OrshBP9wjlnNgcWcxZj5PwXtNIoAj2w+CM2TLq
	 1oTpVat0ToFbCoGNSzJmTW9ZOdZrdhKd4GP2C4+ieuVlFL1FSonDLrGqv+e9fMTo/L
	 UZP7ToyIt0LggI+GOIMGc9EL866E3OOj/rH9/qMMzqB/buhKcOwsv7oV0cULSqGN8e
	 hcwcPuIlxQTiez3Ygo2GsBL3ef4d1TJg87loQ222xei3n2IKQrtwe1DolOv0ExumMa
	 X+h9je/nTKdEc+ICXNqjNq/V2LIRXRwI0Y1TOIwskr2IFLa/de1EM9HDcOFubQ2Gzx
	 DtviG9Evqls/w==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 933F96BD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:32:42 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=h2goKGQl;
	dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 26F726BD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:32:41 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224347aef79so167252995ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1742977960; x=1743582760; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5X6bjgAmnqJeE1zDjlF2ZnFDYz5C8T4cY+6ErJYvhHI=;
        b=h2goKGQld0eoGhF77+DQSgRmo3kWimf+unycQe/Bdn17nVOWYEmD0tvB6pwJTmlp3i
         jfKhfGjCXlx+EjdZuV3Iq3ixmJgRr2FUj4TunOt4NXH5Ddk+6aX9tTT4otStGETiON/l
         i1QQLi6IuyfN4ZHs55vqvU11mjMxYHM8Ncmn4oAiUeYIhWRc90X1aebbujkjnAe638r6
         iEPfHzk9rGETDzXyhgIEg8wRj2UDCOv6q3odsKZ+8bXEvEhsnMrKbblGEvslCXXrsxPQ
         qBC1DUUE0S6U+IBLX5bg/BBQUw5tfvE6E/KU9YDqAjD3wtpf7MwYM88XQbhusLd8v9od
         Hnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742977960; x=1743582760;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5X6bjgAmnqJeE1zDjlF2ZnFDYz5C8T4cY+6ErJYvhHI=;
        b=BMIC6yOqeCdCCxb6WPqqtVjLhmU7BtFPjWW4mfM+y1mdKaREEZFLec+rH8zDg0rJI5
         WsJ/9kLsGRF+1Dn8/9wRb8Insq2vHMF/xhWg8u7ATVT2jqUEYZtOALhm2jXCIGqru/ou
         cg6eLFphiC3UU1BWwE6LjCRWarYcDhA2QO7b/QteSuNquGPmYVnfxKiDLtZRN/ZTKLIl
         EUoY/xeoSfsvMAhVvUDZYzNxH3cF0PcRDqQDZRQRxeH4LTfXz+OrVwuAgTbkOOitR3XW
         66x8aICfJ2JZt2Fz18hm8ZUOGjMDAOzVU4D4cYzQ4IYkvdbU87wFQGr2HzFfOikqRJNq
         7gbg==
X-Forwarded-Encrypted: i=1; AJvYcCVdO3OJKcSkofiDULy7HzMNzY6fHqplW1MIeTwNXReeXL6/VbbqcfRza+lviZXwCHHRWyn24CIgd2KX+tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9SZNPweFRtjNvyclfL7xXM6dKzowQXy/ySvxSndB/tCMy/iP
	2/UXJwynEYSpWTsLPL4hLzoXMxVpwphJHHJEEL+OeE2INHhkJ+Fuj9hK6WfW0z6jac4e29xGgsG
	qFekmGloISTQC4kTegK21zweECe3KLnw/wt5mxBFFUryQDvdlX9nCbJb5A1MVPm4=
X-Gm-Gg: ASbGncv37ertmcxjVGXU9eVad1t++phb94MyRSyc2BxOzuQV29eLTY5QNLGeh6OyoiM
	mk6o/jGrQuExfsOvgjcOIXoP7/P1WmLZxS3X2U0IIVzO5UXfLXadR95RJhXs9ieziNI3tniG3DA
	yLP0OTL0YrZPvXjYlAZDXjr/cXfhNU/qrSaDLErlxH8HZWN/M0KR2TYktaati77dlOgiMXYUhv6
	nKwggkwowJnq5HVALPYZBEoM/ubV4iAZpn3kodY0P8TECrMyeN2ET/1S+QqsviEs207JZqcYZ/q
	Bn/btPhJCvxn7IeiU8ZydbMfOT8ZGBv7l25Kjs+acAR20cNyh6p3sA2wMfmQafs8t7kUgHC1Xsc
	=
X-Received: by 2002:a17:903:1790:b0:223:90ec:80f0 with SMTP id d9443c01a7336-22780d7ffafmr331282005ad.22.1742977959944;
        Wed, 26 Mar 2025 01:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl/5IlHXqH0aB13xDFaYCORfVdtz8hAaULYBSzwHSWdGQtUhQFGCFwqrNs+4G3fTBWpyPAKA==
X-Received: by 2002:a17:903:1790:b0:223:90ec:80f0 with SMTP id d9443c01a7336-22780d7ffafmr331281685ad.22.1742977959446;
        Wed, 26 Mar 2025 01:32:39 -0700 (PDT)
Received: from localhost (117.209.187.35.bc.googleusercontent.com. [35.187.209.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811faae6sm104137995ad.245.2025.03.26.01.32.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Mar 2025 01:32:38 -0700 (PDT)
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
Date: Wed, 26 Mar 2025 17:32:36 +0900
Subject: [PATCH v2] net: usb: usbnet: restore usb%d name exception for
 local mac addresses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-usbnet_rename-v2-1-57eb21fcff26@atmark-techno.com>
X-B4-Tracking: v=1; b=H4sIAKO742cC/x3Myw6CMBCF4Vchs7akNyC68j0MMZUO0BhaMwOoI
 by7leV/kvNtwEgBGS7FBoRr4JBiDn0qoBtdHFAEnxu01JU0uhYLPyLOd8LoJhS+75VCK5vaWMi
 fF2EfPod3a3OPgedE34Nf1X/9S1ZpaZSRtmrKs7RGV0IJx5PzuPC1Sx7fhN2zTDRAu+/7DweKv
 MCmAAAA
X-Change-ID: 20250326-usbnet_rename-dff11e407634
To: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Ahmed Naseef <naseefkm@gmail.com>, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>
X-Mailer: b4 0.15-dev-7be4f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3726;
 i=dominique.martinet@atmark-techno.com; h=from:subject:message-id;
 bh=0cRbGra4b0bceGn7QIieNJyYHJGW+QjN+ZSB/kGRFrs=;
 b=owEBbQKS/ZANAwAKAfKKYH/WjHEHAcsmYgBn47ulGDPu0y4xObg81ZeM/RGWZMEWrb8QgxT73
 LoFtKKYgBOJAjMEAAEKAB0WIQQoFSiLMD+txr0veJbyimB/1oxxBwUCZ+O7pQAKCRDyimB/1oxx
 By9LEACUn0d0TrNeqwWIw2qkse0TqsuERFt3yevQMkJbWUaS2XYL8ghnOPm84VKxBxllN8QBeC4
 ONXojVb5taUPBWbBaG0hQOMXDC8eEHdMAhBvYvezEHLC6DEadWg6WBHGFPT7IK9KaIx/PQ88I0Z
 bLFJ5utzVk6qi+V9NYvI82qTvv/SmDNzR1X5u9fHo94g7xz/bTDG1VXTYDqqCXjSd9Do3XFwmZr
 0PCb1OlERU0xg4udUZd24YwGT+r9A/I4jbSEkY+CdQE6MpOkxApZ6SzmAwgdM4jujAkQVZjOgR1
 YMWHXH/QkZDnbmSSX+Pb/Acsl90jDm/IZuGDS8P4PgQP0QDH8c9PnatPEm4Mi1QGt+qjfeTs1ol
 NnqeEXpl9DS0/YVKGyFgYd+D9ut5Tla1OS0uqbmW8kK5ED5YeUfCAPBNacb9beTc/didmW369iN
 oFbfaxxfoZtHCXvbNfRqLTnj571uoX45/dz64m1e2jcvIRHEaLglaUFsGpO801+9XYrIk1USY6c
 4Sjv52xgDr2miXkVcVHoXWb+d5rsz+9vrzYo9JZZ2vKVUW800CaPPYAo9tUFOc0iBDbMLZGl1dr
 dXE13tC6yobHnPrOWAFc5ruyHDXa1XhzLK8AXhQeE+JTpk+TVV5DlyuTYQkpm+5tltAa6xm2L/x
 sHz8VJHReSVsAdg==
X-Developer-Key: i=dominique.martinet@atmark-techno.com; a=openpgp;
 fpr=2815288B303FADC6BD2F7896F28A607FD68C7107

commit 8a7d12d674ac ("net: usb: usbnet: fix name regression") assumed
that local addresses always came from the kernel, but some devices hand
out local mac addresses so we ended up with point-to-point devices with
a mac set by the driver, renaming to eth%d when they used to be named
usb%d.

Userspace should not rely on device name, but for the sake of stability
restore the local mac address check portion of the naming exception:
point to point devices which either have no mac set by the driver or
have a local mac handed out by the driver will keep the usb%d name.

(some USB LTE modems are known to hand out a stable mac from the locally
administered range; that mac appears to be random (different for
mulitple devices) and can be reset with device-specific commands, so
while such devices would benefit from getting a OUI reserved, we have
to deal with these and might as well preserve the existing behavior
to avoid breaking fragile openwrt configurations and such on upgrade.)

Link: https://lkml.kernel.org/r/20241203130457.904325-1-asmadeus@codewreck.org
Fixes: 8a7d12d674ac ("net: usb: usbnet: fix name regression")
Cc: stable@vger.kernel.org
Tested-by: Ahmed Naseef <naseefkm@gmail.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---
Changes in v2:
- Added Cc stable as requested
- Fix block comment style (checkpatch warning)
- Added some more details about the local device handing out local macs
and openwrt, thank you for the reminder Ahmed.
(FWIW this commit has been in our downstream tree all this time and we've
had no obvious errors due to it)
- Link to v1: https://lore.kernel.org/r/20241203130457.904325-1-asmadeus@codewreck.org
---
 drivers/net/usb/usbnet.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 44179f4e807fc350f3d5710f0bc5f42e6414fd6e..aeab2308b15008185336f717172b090739f4f9d0 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -178,6 +178,17 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
 }
 EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
 
+static bool usbnet_needs_usb_name_format(struct usbnet *dev, struct net_device *net)
+{
+	/* Point to point devices which don't have a real MAC address
+	 * (or report a fake local one) have historically used the usb%d
+	 * naming. Preserve this..
+	 */
+	return (dev->driver_info->flags & FLAG_POINTTOPOINT) != 0 &&
+		(is_zero_ether_addr(net->dev_addr) ||
+		 is_local_ether_addr(net->dev_addr));
+}
+
 static void intr_complete (struct urb *urb)
 {
 	struct usbnet	*dev = urb->context;
@@ -1762,13 +1773,11 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		if (status < 0)
 			goto out1;
 
-		// heuristic:  "usb%d" for links we know are two-host,
-		// else "eth%d" when there's reasonable doubt.  userspace
-		// can rename the link if it knows better.
+		/* heuristic: rename to "eth%d" if we are not sure this link
+		 * is two-host (these links keep "usb%d")
+		 */
 		if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
-		    ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
-		     /* somebody touched it*/
-		     !is_zero_ether_addr(net->dev_addr)))
+		    !usbnet_needs_usb_name_format(dev, net))
 			strscpy(net->name, "eth%d", sizeof(net->name));
 		/* WLAN devices should always be named "wlan%d" */
 		if ((dev->driver_info->flags & FLAG_WLAN) != 0)

---
base-commit: 0fed89a961ea851945d23cc35beb59d6e56c0964
change-id: 20250326-usbnet_rename-dff11e407634

Best regards,
-- 
Dominique Martinet <dominique.martinet@atmark-techno.com>



