Return-Path: <linux-kernel+bounces-547088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2DAA502DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 610923A3FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E1724CEFF;
	Wed,  5 Mar 2025 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YB/owQ5w"
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB22356C2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186301; cv=none; b=Ah2kwKiPeN/vUVQ4PNFR/d4VS9uyabJY53ntjBl9qug5kelLRDF2srUNGBrQf6yzeN3sL9bh3PNQKUtxCb2QgdSy5amr/b5epESvKR+d875l75NjWQ5CQTThMCrvNDXgA93LdAbYOe1xWpFAadzxD8l/2PtaZsqWE74FNFoHLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186301; c=relaxed/simple;
	bh=wtCQCt8rqx4GWg+NIjRWlE4uT8FTJXn46WICMMX4aAw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p0ETTrHi29TQWjeVADUasCoODegk+BXi5UfJroGTmoVBQH9Ql60RGuH2HzHsAVf62tl92rnUwUGAXDQd+vQsIrmaBnfAjbNwIA6LNUYuGgjBvB9jyuQSFk6Ex9QQITMsjop+/Ixtwu7qJfkKqQyJXVJKv01gvjwrhS9+UapFUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YB/owQ5w; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:e2ca:0:640:d17d:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 6E28160963;
	Wed,  5 Mar 2025 17:51:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id IpljNB2Ld0U0-EkQCOSyO;
	Wed, 05 Mar 2025 17:51:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1741186294; bh=0r5+HT8HtqrM7TFlRiKy0pBw/O4oRx1d5/NdhYN0g9k=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=YB/owQ5w1XVBleEi96AYKFrwm/VlsQy7/mgLaK0SN8vDvqkSClWxWC4IZ1U5K/5QZ
	 CilMKvMwj+MeuagrBg4mQ3KuRiJQ+TYMQSWq/RHUrUvGksrUCnhcyD21loLEBJnlgV
	 WAqogSXmot2pWic+2oVtYcrFM3YXt+26kxoPQyMw=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Andrey Tsygunka <aitsygunka@yandex.ru>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrey Tsygunka <aitsygunka@yandex.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] misc: sram: Fix NULL pointer dereference in sram_probe
Date: Wed,  5 Mar 2025 17:50:45 +0300
Message-Id: <20250305145045.1293159-1-aitsygunka@yandex.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added check for res for NULL value.
If the passed device-tree contains a node for sram-device
without a specified '<reg>' property value, for example:

    sram: sram@5c0000000 {
        compatible = "nvidia,tegra186-sysram";
    };

And the of_device_id[] '.data' element contains a sram_config*
with '.map_only_reserved = true' property, we get the error:

[    2.130808][    T1] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    2.133389][    T1] Mem abort info:
[    2.134319][    T1]   ESR = 0x0000000096000004
[    2.135484][    T1]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.136816][    T1]   SET = 0, FnV = 0
[    2.137883][    T1]   EA = 0, S1PTW = 0
[    2.138954][    T1]   FSC = 0x04: level 0 translation fault
[    2.140203][    T1] Data abort info:
[    2.141162][    T1]   ISV = 0, ISS = 0x00000004
[    2.142246][    T1]   CM = 0, WnR = 0
[    2.144038][    T1] [0000000000000000] user address but active_mm is swapper
[    2.146003][    T1] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    2.147589][    T1] Modules linked in:
[    2.148735][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.96 #1
[    2.150051][    T1] Hardware name: linux,dummy-virt (DT)
[    2.151492][    T1] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.152996][    T1] pc : sram_probe+0x134/0xd30
[    2.154517][    T1] lr : sram_probe+0x114/0xd30
[    2.155710][    T1] sp : ffff80000efdb820
[    2.156443][    T1] x29: ffff80000efdb8d0 x28: 0000000000000000 x27: ffff80000efdb878
[    2.158173][    T1] x26: 0000000000000000 x25: ffff0000ff816bc8 x24: 0000000000000000
[    2.159828][    T1] x23: ffff0000c0cb0480 x22: ffff8000099be080 x21: ffff0000c0bc4000
[    2.161554][    T1] x20: ffff80000c14cac8 x19: fffffffffffffffe x18: 0000000000000000
[    2.163148][    T1] x17: 203d20647561625f x16: 65736162202c3331 x15: 0000000000000028
[    2.164850][    T1] x14: 0000000000000d2e x13: 0000000000000d2f x12: ffff80000e410d00
[    2.166514][    T1] x11: 0000000000000003 x10: ffff80000ec93074 x9 : ffff80000e406000
[    2.168194][    T1] x8 : ffff80000efdb518 x7 : ffff0000c0a50000 x6 : 0000000000000000
[    2.169306][    T1] x5 : ffff0000c0a50000 x4 : 0000000000000000 x3 : ffff800009946e88
[    2.170646][    T1] x2 : ffff0000ff816bb0 x1 : ffff0000c0bc4010 x0 : 0000000000000000
[    2.172457][    T1] Call trace:
[    2.173114][    T1]  sram_probe+0x134/0xd30
[    2.174334][    T1]  platform_probe+0x94/0x130
[    2.175589][    T1]  really_probe+0x124/0x580
[    2.176706][    T1]  __driver_probe_device+0xd0/0x1f0
[    2.177885][    T1]  driver_probe_device+0x50/0x1c0
[    2.179037][    T1]  __device_attach_driver+0x140/0x220
[    2.180274][    T1]  bus_for_each_drv+0xbc/0x130
[    2.181423][    T1]  __device_attach+0xec/0x2c0
[    2.182580][    T1]  device_initial_probe+0x24/0x40
[    2.183734][    T1]  bus_probe_device+0xd8/0xe0
[    2.184826][    T1]  device_add+0x67c/0xc80
[    2.185800][    T1]  of_device_add+0x58/0x80
[    2.186752][    T1]  of_platform_device_create_pdata+0xd0/0x1b0
[    2.187923][    T1]  of_platform_bus_create+0x27c/0x6f0
[    2.188998][    T1]  of_platform_populate+0xac/0x1d0
[    2.190030][    T1]  of_platform_default_populate_init+0x10c/0x130
[    2.191409][    T1]  do_one_initcall+0xdc/0x510
[    2.192441][    T1]  kernel_init_freeable+0x43c/0x4d8
[    2.193485][    T1]  kernel_init+0x2c/0x1e0
[    2.194496][    T1]  ret_from_fork+0x10/0x20
[    2.195972][    T1] Code: f9002bff f90033fb f941e822 f90003e2 (a9400001)
[    2.197354][    T1] ---[ end trace 0000000000000000 ]---
[    2.198333][    T1] Kernel panic - not syncing: Oops: Fatal exception

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Tsygunka <aitsygunka@yandex.ru>
---
 drivers/misc/sram.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index e5069882457e..c8ba8ebd4364 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -410,8 +410,13 @@ static int sram_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ret = sram_reserve_regions(sram,
-			platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(res == NULL)) {
+		dev_err(&pdev->dev, "invalid resource\n");
+		return -EINVAL;
+	}
+
+	ret = sram_reserve_regions(sram, res);
 	if (ret)
 		return ret;
 
-- 
2.25.1


