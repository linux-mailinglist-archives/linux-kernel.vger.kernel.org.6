Return-Path: <linux-kernel+bounces-525147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73921A3EB7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5B7A637F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5425714A60C;
	Fri, 21 Feb 2025 03:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oO6+Xkro"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2074.outbound.protection.outlook.com [40.92.18.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A899A2862AC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740109574; cv=fail; b=BdRu3XI45uomsrVWWib2XK6wigJ92V6CFhIFRXoCFfWAA17a8Dj6udVhIYh4o7Be3Ff9D9HqgA1E++cXM4LBW+ilIrgEp3wg7WvzNjbhwn1bT7o4q4I+hJudLZcwSyygMOtuSaIn1usB4mXfJEu43udEgeEWvEGm/UcnFx7HFkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740109574; c=relaxed/simple;
	bh=0Jw1cGlt9+fLzVNw0dbPqUcuxYs4dXnwNPv4p/lU8bM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=btFnKiiwV+970D6hRNWEPKwCLubiYRcn3i1nntvhft6NbBQfHLEGR0mGRmxh5SQn5HVYvA+9Qe7g9fkYAJ8WkzFbja1DqrzlfvvzPNGPb1sfTbpPTt4u2mNcrm2FUhbvpqDPJrslhw/ija7ZFQuTB2266qLsXi5JpgVjr+lEP08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oO6+Xkro; arc=fail smtp.client-ip=40.92.18.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTvYCAV3HQWEYbILAbdxjG7i/aiVMzfp0NBgTtarlpHD9mq57I+lXTyKtE86f7ggQuvCKsQzKpVJAKbyw3lD5l+0gc7HAR8pWsT/LPameIhXxD2FkA+wZCqUsxlT23h7SPWr2lec2Xjcg566bwZWbPMbt1NQl5sF3ZWeZv5tAxCVkYMxXCI7OnhquqN/926HPLSLeynxhhOvpx9iIRacovTYBN0BFx3zgvy8e4YzOsTsVpPgUs3i9CCbUV8grfmFp5KTXV4pMDDJQE1Pe2Qs57ORURNrEYIRXLO/uH6gCR0soJ3dCpjr9JBHZCOhklGADQoY40YX1Y3awoXtKGOg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOEIsx9eiHRl3lbJR+VDtpYt8+WRiwez6kABkrkkOss=;
 b=CTMsqh6Tpy0fvbumqIlC0W+fW6wiEjvqgqAEUVaAvSK6zuyBPUCCdVVJ4CZLjMnkKtBC6vbx0C1/XRWOwQej9QDIvZui09uh7CLXPXNAYwk6NmMeHE9uOTKk/Uw/KM9+K3t2PBOPXxAtgoxMBP+aBEvJKklepJbwTfk9XdkepEvaUuWcwMgogdiCidehIhdk+zcIOl8kSVu7JlE4VFbZQuznspKg+ndVtGePhsGMIOX0B+KruMS7wW2KqJZEXm0HIrJkWwALvnHEloGQNVZcSyIp9yGSUQgVyqRy9kjZWIQg1Jdl/MKV+LEyEuT54fPKZfjnfTbAFE/XtPOL94U8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOEIsx9eiHRl3lbJR+VDtpYt8+WRiwez6kABkrkkOss=;
 b=oO6+XkroMXUdOkdBKyDPVhU/o0pV36MczvhRVlzI5ip1wwlgCP/d6BX5BJuTg/2H5ES6VNzufoihOukbeDG0eR1flouWYuksBPs3owKOxuTVACadWcnAUW5H5JTvPpjPHZgjRvsFZhlHBbOelIHoeIst/I/4F7WXKOvd9RAdj2WH+MUVopUjmJz4aFa1XglFXA5PbN7jCEpNBIp/SqFBZiP9wxTSB/Oq5HXOObffTlg82hrcvlJKJFBrl4guSbNdWHB+kK6vropdGgpncLKeDhWrowWoBw5Xq6/nauUUH1b/jKxsbh57FIXxbAf1ZDCixnd1ENcAPHQjMw43HPeGJA==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 03:46:05 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%5]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 03:46:05 +0000
From: stephen eta zhou <stephen.eta.zhou@outlook.com>
To: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue when
  clock source is not registered
Thread-Topic: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue
 when  clock source is not registered
Thread-Index: AQHbgQZ+G5w2kayGkEia0UUYW9r2hA==
Date: Fri, 21 Feb 2025 03:46:05 +0000
Message-ID:
 <BYAPR12MB3205C9C87EB560CA0CC4984BD5FB2@BYAPR12MB3205.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|LV3PR12MB9167:EE_
x-ms-office365-filtering-correlation-id: 01cf68a2-a4c5-4a01-52d6-08dd522a44fc
x-ms-exchange-slblob-mailprops:
 laRBL560oLQowKaVx7aWRf9b2EXVRKJlVg9TXhFxn3X7ge/aCf0w/j/2oEJkVGLCxrgxzGLD91VFBwY+3mLRYHul0ypD1+anKX1hcReh0CCU+RsIcTUTmR2os/vUc53C0fCjHuW5GOfUTZ/NSjVdd9L/k7uz0nUgYriw7zODheMHTiX2TZQ4cob99C1U38PqKHxonoZQ44766a1+FgLC/1bxj2tqRu7ZZonPnPo/UGXShjZj4/5LHwLC8f97PxF+CctPasqu3uDW0odMN2TzTl+kvWxGkC/UynZx1JIkopxOa7bk5yldAkAkqsuzt9Ml1NLoA2KGHXbpqNu9YI07oChLkiyi3mUmwa3KT4NsLsM6Dj1CxXyP334KPNv/s0JiKd2+LAEbhrtH8h0/vTSwHAinAUcpOKJelkFu1fG6zRBtA8AIIioDlDkA2liDb4f3//EFV78z6BxpIz6wKfnBJC1vkZQOEkFckujzYUCxJ4osqo5IIwdDdeQz6En0BvUSjzNEZBMjoxFLboqByxNlRrlnh7w0Kd7gzK8G1x8JG9UV8RGA5Tr+v+990MTcq4MmFBzHSWIGrt8DqB+5fPxXjo6NcFTje5k941su9AUOeE7uVB5O9BybSx2zst1k4Chw1cL0sLit1BTPmbZqrUM/ZokRt95qTf7pNLWjLSpx974CnpxDjlgn4Wbax+rWSrVXwz9Y1YltSlb8hiGFFPAud3vWmQMsFUr3nVtd8QKbbO1p2LZgdCXjnkU0paDyQooRD4w/MiEUsKpykLH0AxyudFT9w9A/O8y/
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799003|19110799003|8062599003|8060799006|7042599007|461199028|15080799006|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?KqkVIS+otQnJaLQIEWG7Rr6DoPUQfzZ9XvX9l2231hENI2LRhdoBJpmY?=
 =?Windows-1252?Q?Ua2dl1E7tfRxrsh1rw873kBOHXSs9HHqOcg7tVNFNai1JOqK+TayXQlA?=
 =?Windows-1252?Q?Su2brI5BeuZcWH9OGAZ4ENqentvVwe5xkPxig7Iu1itLZqIidlPK0Bcz?=
 =?Windows-1252?Q?fkE9DsDFQwYZPebkPy08CZ7VsDDq6GdoyLXDk/vhiuheJWvAzwYdER7O?=
 =?Windows-1252?Q?WOci6mvsU/dvo6qr3BYFycUk7Xqyen4qjhaaO3LK2NyEI+MseBgcAecx?=
 =?Windows-1252?Q?gJdWGQcqryGaiIYYQeeg1s1+VgQlHBPNAbqlna9NPtPc7R+ZmL3lsS2S?=
 =?Windows-1252?Q?BQa9AEMBljCn6VrUSgRZRQQvtNMBbJanBlyFK2OaG++dncGiKnL3tqGe?=
 =?Windows-1252?Q?U84U5OTw/Fu36XshBZjgA9ZDcBhQ0G8A4A0rbPBoYULVGMvtJP4FH1cE?=
 =?Windows-1252?Q?wR6tkEhCB97ZZjsJKbK5n5Fmsmiz1jJmQsw6VS9AV30/40SJTsvTyP1R?=
 =?Windows-1252?Q?XhPhfxyxdFU+tmmD2c9/SvfsdmUS+WK8myyKXpbTGtvVmNFntNckEjRK?=
 =?Windows-1252?Q?R65fVCkHNFf7wgU13DqsNxVLwlBPLE66QtR8poIgTsAydVT0rVkIYBJq?=
 =?Windows-1252?Q?aI1P4GmTZy4cXmMf/X0st/LgK/tiwNONb45C/C2JmfIXQBPHvZx5+Kzt?=
 =?Windows-1252?Q?xjdlLxMlUPW/4K2yQj6/zPgezfiszyHH3yNYqHm4EG2cXIVrj7z2rGtX?=
 =?Windows-1252?Q?Kfe+0HG2z8n/LwU62K5GkKgZO2UXHXgzKna2XEbwTF8XYehZkiGWIZP0?=
 =?Windows-1252?Q?8VWg3xGJrRh9ZaxjysmgPF0YGIb7ZIS4OktzU5GspqVMA4u1ceKdD71t?=
 =?Windows-1252?Q?76k6rqgqZAr7Uai84bQaLWndtXaGOsuQSKBzP7r16XqD1+9CpTn4FeUH?=
 =?Windows-1252?Q?AMlbLAFPnx2yLPGgyoDZ8U62YK680Lc18Gp6SP22dj5zZW9oIy+duYKn?=
 =?Windows-1252?Q?25qJu71ijxg1IQY/Fs+uaNnU8zIncX3eO6Pc+sWQzBJYqn+B701ojDSj?=
 =?Windows-1252?Q?HYu//ulHGXaEzrZ7Ba9Gi/DLquDQWrg5kbS4fhFHTYP1vIzVw4c2lBQj?=
 =?Windows-1252?Q?1G2sPNE6MmgNXMmDSxlV/wwnotSTYNlBpLwk8IiOAaxZgHGaJgn4Szvw?=
 =?Windows-1252?Q?zyWWrjLbuldOCuEjmtQ/BJGVlCy9entb3dGSN4EcOiaFHUthJ6e+dw?=
 =?Windows-1252?Q?=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?r+xSfm3fTVg6266ADjpRu52o0IPUUfpIoVdpk+Ysw9dXgjZk2B4vrmAR?=
 =?Windows-1252?Q?20nFg2eAevoW5EKyC6gORHCMag4SylVjkB1FunpgrfOeRfyNzoDQuEF7?=
 =?Windows-1252?Q?S13P/x8lJxL6j/FQrC4ASG3wB6QeDjfRM7ROxgoc6WmvQdsORqzLGfrb?=
 =?Windows-1252?Q?0dG6IQXFNeGk2fZP7vJtOkhv1pwAVRUn3ECN9FR28e4LA9eZiFvsn4Ax?=
 =?Windows-1252?Q?pKVqQxUrU3qZ4jcSaNRkOdFmPL4cUDdX4zMEWcY6O0WmjhRcrR05tiWr?=
 =?Windows-1252?Q?0d/SnRwZWrgluKsVh+fEP13gmukDpi3dhgWjbE5sI8T1s4FhmPsRP3u+?=
 =?Windows-1252?Q?q3SpPj4Y8WQUNQ8fozVRs0byOhtZOuZjZE/Tty+nb61BxdlizERGSDbX?=
 =?Windows-1252?Q?M3cf01Xnjf830OPPSVjEMdK0vGfxdba08dAMeEIpC04w9yF3bfk+Zs1m?=
 =?Windows-1252?Q?47AYFX7QDl+/tW8G/Fja4oS9jCk0RwX1Bup9TNLzpFziRrCFH1Sc8ukN?=
 =?Windows-1252?Q?rhkYZLK+hJHYugh2hDsfnbweL1rCGZ0IxjuEnXjmrZCXi7l+GCgdLkOC?=
 =?Windows-1252?Q?u3PQKvZmb8eJklV/iCLODIxDCbi9ItQ3G4B0A4wy0z+XurBHebNYp4Fd?=
 =?Windows-1252?Q?pzg65mXPnev8u5kMLiu5jDIW43aQmUCdl9CnN/I87fa55NgAQGkwOk6C?=
 =?Windows-1252?Q?Bm4Lzm7rcMFUxE/PDRbGcM2iWqV/RnutBmgkxsHramrNNeZQllY5f9HF?=
 =?Windows-1252?Q?irOG2mRSghnY8B34GFhko0vFguObbkLiN497Uy3Ra0ESWNKxYZTybTGY?=
 =?Windows-1252?Q?cb8l3csXRL07SMOxmvu49xgqDXixOU11TACI3BUiLtil3axE51+6X48A?=
 =?Windows-1252?Q?depokVUyjkhRHNRnmJJhdt7BQiMdo7AXMBnGg/nzT4zlxP6F/U60IrzZ?=
 =?Windows-1252?Q?2NlTiPtax8An4ChEbQe0Z/kKMCpFeq2iDHVzM/dhwa00yRPnabFiDkTL?=
 =?Windows-1252?Q?w0yTnJ3cXRDBJHS0ap5GhA+OO13qqCfSnzOm5SHICdajVFB8W+PELLkd?=
 =?Windows-1252?Q?8a94rxBUifpIEr3lJqEtuV+tB99RvqsoCGzVqRhGlqlpJtGPCbEosDK6?=
 =?Windows-1252?Q?dUzctunsH9qAPPXmsdnY86pydrPqIzhlhmxDDTi9n2cKKa/ijdAYmcFD?=
 =?Windows-1252?Q?F/1wJam5SLpN4/8tqOOYDIq9l50XOttsjWsoDen+f3hWjwjfMX4AlKNu?=
 =?Windows-1252?Q?SoZxj9QNwByiniX8q+sShrL4jSgaInRRvPIv5i2+5Cj+KRXAXzXW/Tfg?=
 =?Windows-1252?Q?pXmCqKgVP1LuaKl4z5yN8jrh+SUPIfQ8fQNXRvJl56r0B0ev?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cf68a2-a4c5-4a01-52d6-08dd522a44fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 03:46:05.5788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167

Hi daniel=0A=
=0A=
While debugging on the vexpress-v2p-ca9 platform, I discovered that the rea=
d_current_timer API wasn't functioning correctly. The issue was that the SP=
804 driver lacked ARM32 support and did not register read_current_timer. To=
 add ARM32 compatibility, I=92ve submitted this patch. Without it, using SP=
804 as the timer on ARM32 causes issues with boot_init_stack_canary when in=
serting the canary value into the interrupt stack, and also affects entropy=
 generation and collection, resulting in incorrect rdseed values.=0A=
=0A=
From 9dd9b5bd7ab1638990176f7171417c83ddb7a221 Mon Sep 17 00:00:00 2001=0A=
From: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>=0A=
Date: Fri, 21 Feb 2025 11:15:40 +0800=0A=
Subject: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue w=
hen=0A=
 clock source is not registered=0A=
=0A=
Fix read_current_timer() on ARM32 by adding support in the SP804 driver.=0A=
=0A=
Signed-off-by: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>=0A=
---=0A=
 drivers/clocksource/timer-sp804.c | 36 +++++++++++++++++++++++++++++++=0A=
 1 file changed, 36 insertions(+)=0A=
=0A=
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-=
sp804.c=0A=
index cd1916c05325..b98a14d24874 100644=0A=
--- a/drivers/clocksource/timer-sp804.c=0A=
+++ b/drivers/clocksource/timer-sp804.c=0A=
@@ -21,6 +21,11 @@=0A=
 #include <linux/of_irq.h>=0A=
 #include <linux/sched_clock.h>=0A=
 =0A=
+#ifdef CONFIG_ARM=0A=
+#include <linux/delay.h>=0A=
+#include "timer-of.h"=0A=
+#endif=0A=
+=0A=
 #include "timer-sp.h"=0A=
 =0A=
 /* Hisilicon 64-bit timer(a variant of ARM SP804) */=0A=
@@ -59,6 +64,10 @@ static struct sp804_timer hisi_sp804_timer __initdata =
=3D {=0A=
 =0A=
 static struct sp804_clkevt sp804_clkevt[NR_TIMERS];=0A=
 =0A=
+#ifdef CONFIG_ARM=0A=
+	struct delay_timer delay;=0A=
+#endif=0A=
+=0A=
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)=
=0A=
 {=0A=
 	int err;=0A=
@@ -102,6 +111,13 @@ static u64 notrace sp804_read(void)=0A=
 	return ~readl_relaxed(sched_clkevt->value);=0A=
 }=0A=
 =0A=
+#ifdef CONFIG_ARM=0A=
+static unsigned long sp804_read_delay_timer_read(void)=0A=
+{=0A=
+	return sp804_read();=0A=
+}=0A=
+#endif=0A=
+=0A=
 static int __init sp804_clocksource_and_sched_clock_init(void __iomem *bas=
e,=0A=
 							 const char *name,=0A=
 							 struct clk *clk,=0A=
@@ -259,6 +275,10 @@ static int __init sp804_of_init(struct device_node *np=
, struct sp804_timer *time=0A=
 	struct clk *clk1, *clk2;=0A=
 	const char *name =3D of_get_property(np, "compatible", NULL);=0A=
 =0A=
+#ifdef CONFIG_ARM=0A=
+	struct timer_of to =3D { .flags =3D TIMER_OF_CLOCK };=0A=
+#endif=0A=
+=0A=
 	if (initialized) {=0A=
 		pr_debug("%pOF: skipping further SP804 timer device\n", np);=0A=
 		return 0;=0A=
@@ -318,6 +338,22 @@ static int __init sp804_of_init(struct device_node *np=
, struct sp804_timer *time=0A=
 		if (ret)=0A=
 			goto err;=0A=
 	}=0A=
+=0A=
+#ifdef CONFIG_ARM=0A=
+	ret =3D timer_of_init(np, &to);=0A=
+	if (ret) {=0A=
+		pr_err("Failed to initialize the Timer device tree: %d\n", ret);=0A=
+		return ret;=0A=
+	}=0A=
+=0A=
+	delay.read_current_timer =3D sp804_read_delay_timer_read;=0A=
+	delay.freq =3D timer_of_rate(&to);=0A=
+	if (delay.freq <=3D 0)=0A=
+		pr_warn("Failed to obtain the freq of the clock source: %d\n", ret);=0A=
+=0A=
+	register_current_timer_delay(&delay);=0A=
+#endif=0A=
+=0A=
 	initialized =3D true;=0A=
 =0A=
 	return 0;=0A=
-- =0A=
2.25.1=0A=
=0A=

