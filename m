Return-Path: <linux-kernel+bounces-559135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAC0A5EFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8159117DA61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C3B23C8BE;
	Thu, 13 Mar 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="OyGQ53mB"
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A914AD20
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859237; cv=none; b=h1UKBvacoWqmQlnH08x+gb+lLO6LbicNcrdNwMF5UZ8TemF1HLKKtJz5lBBdfHKqlFs1QLHXfLiE6VLm/NcvLjKWKCSzOZV7OwKUyrL8MkQH9qayx5kDBjMMo84aQZ0xo8XqJjRjB8UpbE70MXgd45paLCMop+ujWmT+WzIcY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859237; c=relaxed/simple;
	bh=e/YRPj6RUaOq76Rd/cALVFxmh2DBSQ4Kxxlj2FhISN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CuzVx7LV0lIv+36ND28v8yYAAE5dq0FHdI0IR5si+byg/MsoSIKJU2w8TYuW57oDAzSCBNsh8txNa3WKslaxyuqR/H9lZSZSblFXzS1jEP3NEns50NtNQ2OnDrDKCgq1CdnqiI+XylTr/AqEQcoFemOfZqfTuJ/URaCNdFYzQT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=OyGQ53mB; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202503130947118435b45ee901dea5ff
        for <linux-kernel@vger.kernel.org>;
        Thu, 13 Mar 2025 10:47:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=kF4icJdfP5lYpb8j8rEZ0/bmq66zQh7c61dM/j9rTKo=;
 b=OyGQ53mBnlX/kxdCGiKDZ/Bdh0HnbzuOlKTqe0CaVPs+HtUnX0aRcIWo00h9uBYNaVkFwa
 yyM0o0D5DrgQMAziGVk1BZG0CCyksS0YBM3blo3t1w7ltoZ+aoaSuP6fY7pGWhk9sXGMT1RR
 JcduQxAP+dbk2OLxJI/uYmBeCBNopGxql+xKBHRVmhIt7ZtwXZb+cZrPYVWSS4iHHvgBWxQx
 bIEKEJ/hK5ZU5EdKKDtqD0rCtIjBcOUOz+knSOj2UWe8iLuihbDc8diySnEoEu0rqxNA62m3
 4gSbfwsXjyO7oPpnm/l/y0AQcvPrU3jV0zxMTgg4EX3Jyr2jj8WbQazg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "bus: ti-sysc: Probe for l4_wkup and l4_cfg interconnect devices first"
Date: Thu, 13 Mar 2025 10:47:06 +0100
Message-ID: <20250313094708.1003092-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

This reverts commit 4700a00755fb5a4bb5109128297d6fd2d1272ee6.

It brakes target-module@2b300050 ("ti,sysc-omap2") probe on AM62x in a case
when minimally-configured system tries to network-boot:

[    6.888776] probe of 2b300050.target-module returned 517 after 258 usecs
[   17.129637] probe of 2b300050.target-module returned 517 after 708 usecs
[   17.137397] platform 2b300050.target-module: deferred probe pending: (reason unknown)
[   26.878471] Waiting up to 100 more seconds for network.

Arbitrary 10 deferrals is really not a solution to any problem.
Stable mmc enumeration can be achiever by filling /aliases node properly
(4700a00755fb commit's rationale).

After revert:

[    9.006816] IP-Config: Complete:
[    9.010058]      device=lan0, ...

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/bus/ti-sysc.c | 49 -------------------------------------------
 1 file changed, 49 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index f67b927ae4caa..e5c02e950f2c1 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -677,51 +677,6 @@ static int sysc_parse_and_check_child_range(struct sysc *ddata)
 	return 0;
 }
 
-/* Interconnect instances to probe before l4_per instances */
-static struct resource early_bus_ranges[] = {
-	/* am3/4 l4_wkup */
-	{ .start = 0x44c00000, .end = 0x44c00000 + 0x300000, },
-	/* omap4/5 and dra7 l4_cfg */
-	{ .start = 0x4a000000, .end = 0x4a000000 + 0x300000, },
-	/* omap4 l4_wkup */
-	{ .start = 0x4a300000, .end = 0x4a300000 + 0x30000,  },
-	/* omap5 and dra7 l4_wkup without dra7 dcan segment */
-	{ .start = 0x4ae00000, .end = 0x4ae00000 + 0x30000,  },
-};
-
-static atomic_t sysc_defer = ATOMIC_INIT(10);
-
-/**
- * sysc_defer_non_critical - defer non_critical interconnect probing
- * @ddata: device driver data
- *
- * We want to probe l4_cfg and l4_wkup interconnect instances before any
- * l4_per instances as l4_per instances depend on resources on l4_cfg and
- * l4_wkup interconnects.
- */
-static int sysc_defer_non_critical(struct sysc *ddata)
-{
-	struct resource *res;
-	int i;
-
-	if (!atomic_read(&sysc_defer))
-		return 0;
-
-	for (i = 0; i < ARRAY_SIZE(early_bus_ranges); i++) {
-		res = &early_bus_ranges[i];
-		if (ddata->module_pa >= res->start &&
-		    ddata->module_pa <= res->end) {
-			atomic_set(&sysc_defer, 0);
-
-			return 0;
-		}
-	}
-
-	atomic_dec_if_positive(&sysc_defer);
-
-	return -EPROBE_DEFER;
-}
-
 static struct device_node *stdout_path;
 
 static void sysc_init_stdout_path(struct sysc *ddata)
@@ -947,10 +902,6 @@ static int sysc_map_and_check_registers(struct sysc *ddata)
 	if (error)
 		return error;
 
-	error = sysc_defer_non_critical(ddata);
-	if (error)
-		return error;
-
 	sysc_check_children(ddata);
 
 	if (!of_property_present(np, "reg"))
-- 
2.48.1


