Return-Path: <linux-kernel+bounces-551291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C926A56AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078537A5D99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981E21C172;
	Fri,  7 Mar 2025 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Z02gXctY"
Received: from forward202b.mail.yandex.net (forward202b.mail.yandex.net [178.154.239.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F11922EF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358499; cv=none; b=VMGjWCqkpD1cB4bQ1a03/HN5Tu5ds42UQe2B/bMMxeDJ2n5aGB1sF1NislyXHAiQYJw1RPfYOOYDpYUo383oc8cdSupyJsjTQA5ILp/Xg4imL0alhe+E1oqU5shIjDBfQhFSdghjxZbIpBpPYMSWrpaZTeTmonnxY9Q1Lxshzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358499; c=relaxed/simple;
	bh=9/YOTw+hwlAppabGdlW1lcCBKvn6z3aahdbUZH9TUDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HrMTkyJeNke1SI/PWeGb0scTAKTGv5RTQjJNYonRcg9TEV7yF73urld2EZECdkHRjWncaeEIj+A6nqVq6b2/szU6lZxVQZDSgu3huCTlSuvHFaxs/n/ITxa3XUx3BWJWqpuajVzPPoX5Kof8+sF/7CaDuM71Qi3cVvnpDTjzgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Z02gXctY; arc=none smtp.client-ip=178.154.239.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward202b.mail.yandex.net (Yandex) with ESMTPS id AA1E564D5A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:35:16 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1e:3990:0:640:808c:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id BFF3060D8C;
	Fri,  7 Mar 2025 17:35:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0ZnwD2MLoSw0-vZ61V53i;
	Fri, 07 Mar 2025 17:35:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1741358108; bh=8GeJNa6VgiFIh/C+Y/1mk9oen77NnBJDUbFFTfIyHuE=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Z02gXctYbnuUHb0I7qaIZ4qtq9rEp9swVGI3+DiBUfZ+nlwb6jQr4EG36XSF1HEDz
	 wOXNy+5hoD0bz0Az19LccEKlnjELGv4OxD7k0N7d3TlRI4CS6kWrlyKokOqD5OeFV0
	 vPvGR75YFOrZhAI1wQneBAkF3H0NB5A0FyqSwBmE=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Andrey Tsygunka <aitsygunka@yandex.ru>
To: markus.elfring@web.de
Cc: aitsygunka@yandex.ru,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] misc: sram: Fix NULL pointer dereference in sram_probe
Date: Fri,  7 Mar 2025 17:34:42 +0300
Message-Id: <20250307143442.4125844-1-aitsygunka@yandex.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <84969aba-67ba-4990-9065-6b55ce26ff92@web.de>
References: <84969aba-67ba-4990-9065-6b55ce26ff92@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for the return value from platform_get_resource() call
to be NULL.

If the passed device-tree contains a node for sram-device
without a specified '<reg>' property value, for example:

    sram: sram@5c0000000 {
        compatible = "nvidia,tegra186-sysram";
    };

and the of_device_id[] '.data' element contains a sram_config*
with '.map_only_reserved = true' property, we get the error:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.96 #1
Hardware name: linux,dummy-virt (DT)
Call trace:
  sram_probe+0x134/0xd30
  platform_probe+0x94/0x130
  really_probe+0x124/0x580
  __driver_probe_device+0xd0/0x1f0
  driver_probe_device+0x50/0x1c0
  __device_attach_driver+0x140/0x220
  bus_for_each_drv+0xbc/0x130
  __device_attach+0xec/0x2c0
  device_initial_probe+0x24/0x40
  bus_probe_device+0xd8/0xe0
  device_add+0x67c/0xc80
  of_device_add+0x58/0x80
  of_platform_device_create_pdata+0xd0/0x1b0
  of_platform_bus_create+0x27c/0x6f0
  of_platform_populate+0xac/0x1d0
  of_platform_default_populate_init+0x10c/0x130
  do_one_initcall+0xdc/0x510
  kernel_init_freeable+0x43c/0x4d8
  kernel_init+0x2c/0x1e0
  ret_from_fork+0x10/0x20

Fixes: 444b0111f3bc ("misc: sram: use devm_platform_ioremap_resource_wc()")
Signed-off-by: Andrey Tsygunka <aitsygunka@yandex.ru>
---
v2: Description changed based on comments from Markus Elfring 
at https://lore.kernel.org/linux-kernel/84969aba-67ba-4990-9065-6b55ce26ff92@web.de/,
added tag 'Fixes', removed useless information from backtrace.

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


