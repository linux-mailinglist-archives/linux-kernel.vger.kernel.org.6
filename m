Return-Path: <linux-kernel+bounces-243752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA3E929A21
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 01:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05300280FF0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8801276025;
	Sun,  7 Jul 2024 23:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="Z49rSOr1"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12345381A;
	Sun,  7 Jul 2024 23:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720393721; cv=none; b=GkcuJAxVlO7nn2dq4wEhdQmVpA9xgFF8MjphfZjIMCzmYKnt/be3G0SOfd4tjBjTnSPfNqGoTaCUUrtY8P4GBakTb1t2+nXi67aVE/gK+tM6s3Zqstq5tOBF/HrNycTPjwjm1aOSTAOcf8UeevkZ708GoT2O0m3sV9G4eScqpy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720393721; c=relaxed/simple;
	bh=Mi3qRSu+fP8rCP3aU71ktBy75QgySZtua5ryqVZYdFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBzyNI1JkeqptaXbW+k9oWC5v5VQDDoBGyUF+p/toUHV9YtBYBWBuB8/NByJcv/VXbLJ2nLg7i2Uvktc9eOy045E3xh5Gni61GhUFV+DF3KWqSjnxjJ3jVAgviKxg5ee2hxTHY+dVaSuxK2CPmOdy7eEX3YerIWTsDfjAQ0yb2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=Z49rSOr1; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720393703; x=1720998503; i=j.neuschaefer@gmx.net;
	bh=77XSkvlQIr28+bKyNg6oFQCBJgUK3izqWxxyk+Vakb4=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Z49rSOr1B3bbxAQFbdCqiLsg8WVOSsFyL9TaaXRTBZWKsYgTnHJoLsOGPxm90CyX
	 svy2WVMPT9K85rpZiEaOOdbOSNtCAeFldZrcsbsk/Elqz1xIrweySrAt8imvuXJPe
	 rezJLps44tBqabfAbGz0V5H51hEhuKISV0tOc6hCTJPn1uv4EVUDq1kFH7ikrw9Dt
	 8tl4fkcIyxstlpyDBzbbjcNVxaELBctwxQh2vlBp8mrWRI8bfWOUJX09hqN7b4ifu
	 hjBrNzaY8PqmWWzGVN6xMBZencEf4uOhkG8pZifg4eadFVWZvHIZYhlimfjVSY7ww
	 bu8iNDtMOHV5FbI22Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.0.46.161]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTABT-1sp9iK21Md-00MWRb; Mon, 08
 Jul 2024 01:08:23 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Mon, 08 Jul 2024 01:08:15 +0200
Subject: [PATCH 2/2] ARM: bcm2835: Detect system revision
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240708-raspi-revision-v1-2-66e7e403e0b5@gmx.net>
References: <20240708-raspi-revision-v1-0-66e7e403e0b5@gmx.net>
In-Reply-To: <20240708-raspi-revision-v1-0-66e7e403e0b5@gmx.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720393700; l=1606;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=dVk42FInQTKZB02x3CBBX1O/q0YT85Unj6HDWJIP/u8=;
 b=9xw8+iBqU5IyUvOOiey/jc5QdiOiw3lfDwft94j4hoBEbfz+uNyrKlLXtoIBsx3amHlox2XT1
 hLl/WTCRtm2BZnejJfVV4GjZhV+V7ea1saNWTpPVrQ2kN7pyU0UkzpU
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:QRzrRDyeZVlzHXj/u2aw51EEVrFDtw9L3XKpSWa/lm1xhphvYjf
 yVfiD/rFDcrDNsJ+V4Iu94TxdkxCKk+c6m7O1iQETmX0V32xACl72NjGST9XDhPdmnfouqd
 xstHHHPAc77TrE/64Z8NdPV6lwAYcgIa6HupB5G6SEjl0EE4nDr9mI8ENfLv8mtiRAReUEN
 kBFquEubheDHxtNu3oMFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O8/6BaM/afY=;a7Gn5BPXgcQ23VLE19RmiArYlvj
 UGWAGrIkdGFZgGTz5dbGhz1//7QnEzTUKw8YVkucReZlNU9FcrBIdOawW7T6APmCfqaK9snPH
 U/y/ZxyYeWHz1vbDzHpqKKXMKOFb3yivE1M79+bnXl8liCgyQsCreBkwgrL0nTFIH4w+ofWNP
 B3+jkqFj6zR44QcCfR9HKJfRoMF6vFgojrT9ZCXwFOjw98+K+Vy7myLomSfUs1B3H/kGbW4VZ
 wQ96hTQRZzXlkTvFCY4XfF5iPRLVBAg4Ppw9Yh7kek+KFVTpJSEw/3B6i5/IihC+AQKheV8FR
 ztX1sxsAzmoNV/+MXDDfkOIqQyR7gas1N4GPPVuU3/O/78ysiFvlAkrJq520mA8lasxBsNEXj
 jgdA0n1+kmkiFS3dtWR9i5pf1DziafEdvqN4W447Cn8La5KYFeT5w26z0SonUzTXn4bHgF/aR
 iWaLWxH2vRXxe5pGJtJ/fhNvqbAsAmEhHQ4gQG5VEUjH9PNx04A2GP2StpqrEQoRVhyrRZgV3
 n5IIlIGKhx5yEBnYFkltgf7ckKe28/HOOpoFg2xmB+O+fVgwGbT8h96SDcVCAlBWIekswATKF
 NcXcmIj+VgNhmQybZRTFWZPXIt+ExY3WRxJzgs6ywDlFtvXTOzo+0sIKPU/0aH7QpuWLkmGsj
 Bwc0Q9byICieP3SyeazTzsW3j5AWfDHgQyoU1AN/KG0i4YGbS4UKC1IykY7iKCp3//pS7Y8YU
 CPqIpRfvXFLU9M3n774DnT+jRG0JH9JiZwj59mqLF6kI1pjsmRXMQsHWKlrQUudvVF3qtoXhB
 j8n6G3uOqIB7s+OZBrnkZeZpUtCfQflVT9FcFGtRPNHko=

The Raspberry Pi bootloader provides a revision code[0] in the
devicetree, at /system/linux,revision. The downstream kernel then uses
this DT property to fill the system_rev variable, which is exposed to
userspace via the "Revision" field in /proc/cpuinfo. Some software[1]
relies on this in order to determine the Raspberry Pi model.

This patch ports the revision detection from the downstream Raspberry Pi
kernel.

[0]: https://www.raspberrypi.com/documentation/computers/raspberry-pi.html=
#new-style-revision-codes
[1]: https://github.com/hzeller/rpi-rgb-led-matrix/blob/a3eea997a9254b83ab=
2de97ae80d83588f696387/lib/gpio.cc#L247
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/mach-bcm/board_bcm2835.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_b=
cm2835.c
index bfc556f7672039..2a7b7ba3cd6c73 100644
=2D-- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -9,6 +9,7 @@

 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <asm/system_info.h>

 #include "platsmp.h"

@@ -23,7 +24,17 @@ static const char * const bcm2835_compat[] =3D {
 	NULL
 };

+static void __init bcm2835_init(void)
+{
+	struct device_node *np =3D of_find_node_by_path("/system");
+	u32 val;
+
+	if (!of_property_read_u32(np, "linux,revision", &val))
+		system_rev =3D val;
+}
+
 DT_MACHINE_START(BCM2835, "BCM2835")
 	.dt_compat =3D bcm2835_compat,
 	.smp =3D smp_ops(bcm2836_smp_ops),
+	.init_machine =3D bcm2835_init,
 MACHINE_END

=2D-
2.43.0


