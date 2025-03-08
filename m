Return-Path: <linux-kernel+bounces-552606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBDDA57BF5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A43216D35F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776F11DDC22;
	Sat,  8 Mar 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Tw8hKZ7q"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2021.outbound.protection.outlook.com [40.92.42.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9277E0E4
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741451481; cv=fail; b=NZU3eZBmE0RxvoSzVKs2nowZrINVKyUNFV+MOwlfx3XMIsS+zVnZlJo5kBOlJ9o7m4C8SXq8SakifV6Yvg0zllBfl+qR73nerni4VVgNUG1k/3+k5hHRadY7MAHV2oKIX/UluPT7QRR2hx243AQIw5RerdMhUCuW8yLYAXG/BCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741451481; c=relaxed/simple;
	bh=bBrspzakdVA3XwzsEe7zjtbVLa+Z32jClR2/YDiNEhY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=arIaAqA4ukbySE2hEu2qae2HU3nNAFK1dLjZmsWASJCJf88ok2k+AyushG8EV3/9xl0nDEOVzjqsv0phuG/vMBxLIg2qa/V9/GHfEbACWBEUlGhEnoBOZPoG5eHsiY4GtsizFCOzTeb4epI++paKF9VdcZekMJmqE/L4aeYFwOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Tw8hKZ7q; arc=fail smtp.client-ip=40.92.42.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoPr2CzkcBg9PeKp0F+md1/g49Zn1w8oUGM0Y75nrlQctwYUD9eOUC/Mf2CCPwdwyCcy/HEHdso0CyxuoqyWassLY9r6kIDVN+Kk5ToQQIIQji5JBdxOIi5Tb/NzoBq45k2JpaBi0+jyariDBGJHOgNGNHtyK21qdMmtjpkaOEEo1lrmlLM+GBw1X3fMnIyEKSD0gjr+C6AgXP9ifzVFWbyI5/bGAKGMqoRfLu3Up1pKvSgkG5XMLOjw5/VIeSPW6xC3wAhFFPssgLTxlBrXNVAn4ZA0uSQBHRKGAEOtdOjJ4kLBGTCCmYHG74h89P82pkDwxr1lB9wvqKKEFMyETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVE9XyptJpbbGW4wnpt8HPgr/e6Vw7AiwouaXUdQ3uY=;
 b=mhvKa9OJuSTDn8AwAnWv2R5aUfOdNpJNJYLNIidgAK4ZweZD7CD5JF+va5arrr/WUeGyFtWoE3AyombkUlBspFlMTer+CvrQHyZW24RFslaCJ9AoVFcZNukFRPiLsZMdt+R3Wx1AKWlIg5HZWgXyNNBphXCCAM1b9306QdjG+YIJkWY0X51mDJWz93nkuEIUnkVPPzk5ZcyiGHYRA2wOEIcjv4p7rkOWteyPA9tTe1UO7bS4Yumj5uGsfGs9Jv/9/4sCNm0m9TC2z+AYV70l07rdP2BCIRnBAA7oFBNjrfht0rt6Vf+qnSIA9OfoAXdBQ582NsVk7KEf7XhLpQ1vQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVE9XyptJpbbGW4wnpt8HPgr/e6Vw7AiwouaXUdQ3uY=;
 b=Tw8hKZ7qdKBx7CunVM5KCUUSdOrvtNOayv0/juXZo+hbU6P96skj6GSe9sfUL2kiXyh2CGI2l0Cn7eFnEfxFCdnqIRVRKcX+aO2N7U5aSWzbPkLxBY9WkZ0wRUgyrebCWL6fOb3x2KwoPOTP73BGTxKcH0m/RtoQq1Z0G/ins2mpg6lKpgq8i1hj+Uz59gnsLd0f4/ZdzcgZGzr+yImfGZgJ0Kju2KJ5fXGctZiPwAW5OP/hYeyPh+05YVvK/0cIoVdfzxjX3SeMkd4KLKc3HZp/tdH3KlDgOK30nyH9VcDmwHMef5LndMFBMtA+66NIQiGWZaWGNaTVM5K+YheVfg==
Received: from BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Sat, 8 Mar
 2025 16:31:16 +0000
Received: from BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991]) by BYAPR12MB3205.namprd12.prod.outlook.com
 ([fe80::489:5515:fcf2:b991%6]) with mapi id 15.20.8511.019; Sat, 8 Mar 2025
 16:31:16 +0000
From: stephen eta zhou <stephen.eta.zhou@outlook.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] clocksource: timer-sp804: Fix read_current_timer() issue
 when  clock source is not registered
Thread-Topic: [PATCH v2] clocksource: timer-sp804: Fix read_current_timer()
 issue when  clock source is not registered
Thread-Index: AQHbkClqcnxwzclP6UmD+SrywxDJLg==
Date: Sat, 8 Mar 2025 16:31:16 +0000
Message-ID:
 <BYAPR12MB3205D7A2BAA2712C89E03C4FD5D42@BYAPR12MB3205.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3205:EE_|BL3PR12MB6594:EE_
x-ms-office365-filtering-correlation-id: 263c492d-bafc-429c-9c78-08dd5e5ea629
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|12121999004|15030799003|8060799006|8062599003|19110799003|15080799006|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?Y9wqLfuN4kP30BgH2WkhWmsnnMAaVRhTLnRETK2NQREajlUa6o5JoCig?=
 =?Windows-1252?Q?dHgty5D40R8d9i/pYKRS82rpolKvw29pz4hbd6I/Ddc6YFt/K1wmiD0e?=
 =?Windows-1252?Q?zkAEvQJvIELpBQ9H+gEg+Dy24tXhlPUsV26ZellpBR44b7TFyz/g4ili?=
 =?Windows-1252?Q?LHbaGsVSV6Oc4OPL0Q0AKDIVadoEJ74BdNnCITY5T1ulul21y0epJ8hd?=
 =?Windows-1252?Q?FMQ4H9+SFndTcbGlAvkQcz++KfWJAuB3rGEaK+M1eGJNmpKG65EgBN9m?=
 =?Windows-1252?Q?F4vq/1FoInHDwkB5VHEOHvNbBm+gFUEgyT4/32JsHUr0EG1WF4czb3af?=
 =?Windows-1252?Q?Tyhd+sMUnkmtYdOwC3BUvHOCqKmMAcwjYq8x0+jqEPpYsIEkC5E8HRLn?=
 =?Windows-1252?Q?Ue/exg6Y5ZBaR4rh43RdZi/4+DiEmHzutkGqHpMoygyj/DI5nDaSOXcl?=
 =?Windows-1252?Q?un7OXFT4nuT/JP9l/UqSJ9nK21DVdeqdxIYAVvl4aOFu+wq/QMkDVa9n?=
 =?Windows-1252?Q?b+WWAlq6SHtzHBzeS4K0KsoAGBTTjTLHn74B4lWFhF5XgSI1aYSDP0FM?=
 =?Windows-1252?Q?wIVcxLLNNcBUBDubac/L1dqKMh0HflKCg4VVwJyLljdch3xNdM+sesRn?=
 =?Windows-1252?Q?OviBdZCutJG7BXTzdH2r1g1H+pq2jcr3+HVKa2goiaUznSsneyfarSqJ?=
 =?Windows-1252?Q?x0EKnOWRg+OI7hUBkdvHkmX9i4F9QaGXovWBT0gM1IRJBuwDo4GtO/x+?=
 =?Windows-1252?Q?sFH3Vv92fpBPVZfZLRz4ZLV02fz0aGpY5+G0METXM7qUaTQ+eluACMEC?=
 =?Windows-1252?Q?ky+aHum8Jgb5PrIes9t0TnKIw/mTUfareUL/VWVpKhdpuMl5/dALc5x2?=
 =?Windows-1252?Q?44W9nYFkBtPRlF0OEbCGA29cd3QUYevmMKonZb9R+Te8Lcf/agwWBw2q?=
 =?Windows-1252?Q?URdz3OuWzUz0Qz/oFbX4AueZaHEJjoMJw575jU4/MwCSaoqWJBy+R9ZF?=
 =?Windows-1252?Q?d1U0srAM9lrrzveRUdoMmPGKrhSx5amE0re6e8mxCD7yvSpSLCMf7IE6?=
 =?Windows-1252?Q?2nS677ZSku30A4IsarYI5bbz6RFy5WmOH/ZCglq+30ijt9xH/B6e3dv2?=
 =?Windows-1252?Q?pKOcAGabQlWGUP3s/yJDIhR9UZ9TJwWWq1mlMMKcf4J2RZom/Gkno3G3?=
 =?Windows-1252?Q?Z42jLhu9Ra0mq1z83yNVxpBDHE8C1AKjpZIMnn6uhTUOQqftAk7gcQ?=
 =?Windows-1252?Q?=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?JHjyd6Ko8Yt7dFncCtbSmz+kv1la7ZQjBqZtnkA31hIcxKL82EjP1xM2?=
 =?Windows-1252?Q?y+wlgB0s/7qBz8tkAtR5o28x6WqaWvkk7UOpQy4iiLvcmp631/ABWiuF?=
 =?Windows-1252?Q?iLla5/6j08aAoz13wPsxT/9Z06L3q+ZTZI8HY+piif4iGlW4cE8a9NfC?=
 =?Windows-1252?Q?Mx6GbFhrPLjrNYK9KpmtSJqpKm/Fm/wWNB7YSOgSQCeI95qBw+aj+dXd?=
 =?Windows-1252?Q?zneln7TKqpYHeGxEzvBFjpgT5rZ78sBKrEge9hChQ136Bl93mcoxE+Pq?=
 =?Windows-1252?Q?ZZhK8s4CkLY68TL0iRsi0Axn7OLRw4y6jyH+QQx4vQPh5m7VLgMJSQgY?=
 =?Windows-1252?Q?gRTI4dAubp2x02VUcmV/WdEM6XNyUTcHwPQ0MA57U5Wgekw2NF5PVp6r?=
 =?Windows-1252?Q?D1pZ4jJ2bXvN4dNOL+17qomku4pB5SMYU+yL6jubk2akp1xmjiVw0pfY?=
 =?Windows-1252?Q?OqkGhbeeW3GJqpx5a2OCkOAvWXwQBhmpWPZXt2AWZh+w69iHGXkrWk2F?=
 =?Windows-1252?Q?ZZQOCQI8Z+q/0rR9xGLEYcF2RtoZ4fcDTHUxCGsfoVU8voyfcwlOTtTH?=
 =?Windows-1252?Q?8AuYJsVaVlIhitTYWOZRW1qxtcTq3dcjmcM0lJRuRzqRdyaF60zv+P9D?=
 =?Windows-1252?Q?ZE88sCHopilDlL+x4rnCzHMvVUIReAosYVjNOfJX7wM82Em4DVGdno1V?=
 =?Windows-1252?Q?auYaEhEZY9CGHVMObLiILSGhfbPW7IDhTuxRse1nlNuWBMeI8p9rNQtF?=
 =?Windows-1252?Q?LDc2u6BrvXe1DntrPqUAlHrac0M1Q/LrJaR/iJBHrUTcybm/TV/ldafT?=
 =?Windows-1252?Q?V98+MZ6n2yY2z4y+cvQlrOB0mN7X4rP+QtHbqFtf357zCRJPbk29hAN0?=
 =?Windows-1252?Q?qWzPWYU2PW4fNRx2HUvjOGggX15MbX4gALJ/GG3auBMqdgTfhWEhgyMN?=
 =?Windows-1252?Q?FWqBbvdQ7RiEMXfFtisYYGDObGsp/OYRmwhbmjr2lnNuEEjw0XLwW0Lg?=
 =?Windows-1252?Q?nKDvMCraFauSCgghpIqqx+R1KvLUYwLYHny4WhMYczMRTHpprre7fAFs?=
 =?Windows-1252?Q?K2xwMBQHY2G9NU4+axWn+ikrd4pEAzuqGkyXQpiXKN0+4ZuTl/tGnKBd?=
 =?Windows-1252?Q?Pagsqi14hhXvWaXQNxJBcVsAR//AzjOiopsf9ARO+Tg7xoKQPOKLUOOc?=
 =?Windows-1252?Q?VzhKe/PbF5dUbGwrAgs6ZYaY2RVAUCcRAONzYLUFbNafctEgQeS4Shrf?=
 =?Windows-1252?Q?pXCkGUBHwBEVj+2m3lZmnZUKP8dxxBrY2ecQztyNDSKzhEA+BKGsfYYp?=
 =?Windows-1252?Q?LyZzjShglDdJSHSAyLxvG6vu5JZ6LxJmQNqATOWwenhFehSws7muOHd5?=
 =?Windows-1252?Q?PoIlKw+zGAzm5WSK//sqBvtnciIBl89ftayLKwYodmux6a9bLxIbJ989?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 263c492d-bafc-429c-9c78-08dd5e5ea629
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2025 16:31:16.3897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

Hi Daniel=0A=
=0A=
I referred to the improvement suggestions you provided and made the followi=
ng improvements:=0A=
=0A=
1. Added static keyword to struct delay_timer delay;=0A=
2. Integrate sp804_read_delay_timer_read and struct delay_timer delay toget=
her=0A=
3. I moved the acquisition of delay.freq to sp804_clocksource_and_sched_clo=
ck_init.=0A=
=A0 =A0 sp804_clocksource_and_sched_clock_init has already acquired and jud=
ged freq, so I can use it directly, and in this way I don=92t need to consi=
der whether to use clk1 or clk2, which can ensure that the clock source is =
available and reliable.=0A=
4. Added detailed description information in Commit=0A=
=0A=
From cd6eedb2b117c5371b0a777e224b4094d7cbfd90 Mon Sep 17 00:00:00 2001=0A=
From: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>=0A=
Date: Sat, 8 Mar 2025 20:24:18 +0800=0A=
Subject: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue w=
hen=0A=
=A0clock source is not registered=0A=
MIME-Version: 1.0=0A=
Content-Type: text/plain; charset=3DUTF-8=0A=
Content-Transfer-Encoding: 8bit=0A=
=0A=
This patch adds compatibility support for ARM32 for the SP804 clock driver.=
=0A=
=0A=
This patch solves the problem that when using SP804 as the clock source=0A=
under ARM32, the kernel inserts a canary into the=0A=
interrupt stack due to the failure to register=0A=
read_current_timer (this error will appear in boot_init_stack_canary),=0A=
and it also affects the generation and collection of the entropy pool,=0A=
resulting in incorrect rdseed values.=0A=
=0A=
Changes in v2:=0A=
1. Added static keyword to struct delay_timer delay=0A=
2. Integrate sp804_read_delay_timer_read and=0A=
=A0 =A0struct delay_timer delay together=0A=
3. I moved the acquisition of delay.freq to=0A=
=A0 =A0sp804_clocksource_and_sched_clock_init.=0A=
=A0 =A0sp804_clocksource_and_sched_clock_init has already=0A=
=A0 =A0acquired and judged freq, so I can use it directly,=0A=
=A0 =A0and in this way I don=92t need to consider whether to=0A=
=A0 =A0use clk1 or clk2, which can ensure that the clock source=0A=
=A0 =A0is available and reliable.=0A=
4. Added detailed description information in Commit=0A=
=0A=
CC: Daniel Lezcano <daniel.lezcano@linaro.org>=0A=
Signed-off-by: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>=0A=
---=0A=
=A0drivers/clocksource/timer-sp804.c | 23 +++++++++++++++++++++++=0A=
=A01 file changed, 23 insertions(+)=0A=
=0A=
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-=
sp804.c=0A=
index cd1916c05325..3194c743ad1d 100644=0A=
--- a/drivers/clocksource/timer-sp804.c=0A=
+++ b/drivers/clocksource/timer-sp804.c=0A=
@@ -21,6 +21,10 @@=0A=
=A0#include <linux/of_irq.h>=0A=
=A0#include <linux/sched_clock.h>=0A=
=A0=0A=
+#ifdef CONFIG_ARM=0A=
+#include <linux/delay.h>=0A=
+#endif=0A=
+=0A=
=A0#include "timer-sp.h"=0A=
=A0=0A=
=A0/* Hisilicon 64-bit timer(a variant of ARM SP804) */=0A=
@@ -102,6 +106,15 @@ static u64 notrace sp804_read(void)=0A=
=A0	return ~readl_relaxed(sched_clkevt->value);=0A=
=A0}=0A=
=A0=0A=
+#ifdef CONFIG_ARM=0A=
+static struct delay_timer delay;=0A=
+=0A=
+static unsigned long sp804_read_delay_timer_read(void)=0A=
+{=0A=
+	return sp804_read();=0A=
+}=0A=
+#endif=0A=
+=0A=
=A0static int __init sp804_clocksource_and_sched_clock_init(void __iomem *b=
ase,=0A=
=A0 =A0 =A0 =A0 =A0const char *name,=0A=
=A0 =A0 =A0 =A0 =A0struct clk *clk,=0A=
@@ -114,6 +127,10 @@ static int __init sp804_clocksource_and_sched_clock_in=
it(void __iomem *base,=0A=
=A0	if (rate < 0)=0A=
=A0 =A0return -EINVAL;=0A=
=A0=0A=
+#ifdef CONFIG_ARM=0A=
+	delay.freq =3D rate;=0A=
+#endif=0A=
+=0A=
=A0	clkevt =3D sp804_clkevt_get(base);=0A=
=A0=0A=
=A0	writel(0, clkevt->ctrl);=0A=
@@ -318,6 +335,12 @@ static int __init sp804_of_init(struct device_node *np=
, struct sp804_timer *time=0A=
=A0 =A0if (ret)=0A=
=A0 =A0	goto err;=0A=
=A0	}=0A=
+=0A=
+#ifdef CONFIG_ARM=0A=
+	delay.read_current_timer =3D sp804_read_delay_timer_read;=0A=
+	register_current_timer_delay(&delay);=0A=
+#endif=0A=
+=0A=
=A0	initialized =3D true;=0A=
=A0=0A=
=A0	return 0;=0A=
--=0A=
2.25.1=0A=
=0A=
=0A=
=0A=
=0A=

