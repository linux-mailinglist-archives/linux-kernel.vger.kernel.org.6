Return-Path: <linux-kernel+bounces-333638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D487997CBB2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC76285E60
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F0619FA77;
	Thu, 19 Sep 2024 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="nZMrWtQS"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2068.outbound.protection.outlook.com [40.92.42.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB711EF1D
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760650; cv=fail; b=CZet7skkjyqoczxEYo3bXB2LImBNQ8fOa7YA9j4I7VCvs6b+vI+NoRcNQFQZ6/275PW0vGASK3kwjLB4OIoBeAcSN0PS6/+V9wsnT9KPEVvwwrDgqvXF6Qo/g9nRh8NGYzgRxtYeYuNmrYCZaI7MWs/jtxK603LUEIVE0CAdmK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760650; c=relaxed/simple;
	bh=HGFC9UrhKYtexOt7+RP6uY6UXHq+sMcZKZZm3M03GXg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lNthDjNl12NUVShMSiEMN5WTa6I9wZH4mQUQLj3kYon5FwZQXu75Dok+ImdCVaBVMHcjHYD66OFy7Xlx0SmSKMvCa1CtL07EUXGMf0ppXOle9CbkT9y8oSumJ/hPUGZUPwRb0nqk1lI/hgDv0nQkkbM+HFWNAvlTOPVRBzND7Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=nZMrWtQS; arc=fail smtp.client-ip=40.92.42.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eW1gIcXQ/si/RhV7NHDfZ8MuYxn9oTNF0IAsIre5QgFCWId2/6rpWYWCbM6fTFWcfO7piCct877kZQLRsvJnz6XlwzMmgHcqQ7VxzZG88c/Gz3DhatC8N4277KP6CJicsb2BiVyY/SK7upUn/y6jltWIN80V7vjBoiR5Oyu8+b/Cg/MDpinVFg4zdf7+qH5iguowN36wwY32xYWxhJP+VUNYumutGO4FupeuYKBtDJ1YWF+I++JTtA8H4ipI7Z00R+J+fnIpS9aioGq7yWsdM7NUwKbK4xUD2ZKleZrezQscydP29WVeGsmQ1HDm22OrihWqk2YOLWbRkFS5VV0AHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8f8IOK4rBYKznOxA8SOct01/M66ZdF4BsYUOleGMX8=;
 b=S1sVFUeFVP2x0+I/JJWkM92c8046Ji3iUN2VWO/LpC9D+33kPJmlQBbrj31v2FWEnK6vyqpMojsr6d1ulI/TrhXyYaezL9lC4U04PtHB27LZFNhRNfiIH3RRnmQFoAtIam8fW2BcFj1CvOwZIOHPiTccnHyQdVupRN0wjAlHhIYsd1GaC+1LzRB9ODHefUz6z8eiYykxT1s0K6a2a1WJkEq9l4/ZYGAMuKFlDORo99hxObwniIl/Wp761WbraWN9RVllqH9c2ronD2NRj6Y5HHHQqL/seufGRrGxsko3+cI1gFqGxv7H/KSdkEo9WJyOmN1JBDBoJPfhH44SdRb7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8f8IOK4rBYKznOxA8SOct01/M66ZdF4BsYUOleGMX8=;
 b=nZMrWtQSUw4VB7TOlz3K7fkkK1yp3JsDnNhJxE4XLUPJ4hYQy0n/kNqt7ioe41gG+n9k+3w8d6Ik2CmW4WHHXnX5m6N5jlPbmr/sVCjcAEqs8WMsKODoxMnCAJPdcux0Cti7jqQJtMaEV925UzlcRlvQt03evTJIzPHac6B8Riw4g4Seh7bhTALcDt/4ALm80ILthckClJ4Ajgn8sO8CIbYjZ/8HH//RzXMMXPI0Frir3e1HFCteNAdvucADMKDVD2ufCiYyVh8K1sfAZZQOPeZ4jQgU8cwcW4wvmruIq1VZMB5G+oyC7uWDPyYU8J7l7d6+6zR2EJ+lFok0ACoMSQ==
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:a03:570::8)
 by PH7P223MB0569.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Thu, 19 Sep
 2024 15:44:06 +0000
Received: from SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd]) by SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 ([fe80::b5cd:c37a:bd3e:e3fd%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 15:44:06 +0000
From: Steven Davis <goldside000@outlook.com>
To: akpm@linux-foundation.org
Cc: ankur.a.arora@oracle.com,
	frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	Steven Davis <goldside000@outlook.com>
Subject: [PATCH] irq_work: Replace wait loop with rcuwait_wait_event
Date: Thu, 19 Sep 2024 11:43:26 -0400
Message-ID:
 <SJ2P223MB10267BCF19A4A37747A52330F7632@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:610:118::18) To SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:a03:570::8)
X-Microsoft-Original-Message-ID:
 <20240919154326.4383-1-goldside000@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P223MB1026:EE_|PH7P223MB0569:EE_
X-MS-Office365-Filtering-Correlation-Id: 10dbfa6b-5f4e-4b05-6e02-08dcd8c1e512
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|5062599005|8060799006|15080799006|7042599003|5072599009|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	rKfb/mCWqtkd4amGCok1Bij0yeMkPX4245E0XYe2XTp8Jofj8Ocso8TDmQDnOEc4HoloHK+gP+cHPS2iCHl1Wvc06jhs7LKpQ4jpN90DIkM1EUj9hUk0/Yw2GBlkqAXuO3YRpkvSh6wn2RYSP2jc3/z8KjJWsAjUSSzH0g3uT/sPQWdwdg05oZ7qpHowzZ/XoRzobnHuYQfJqarkQ4Ja/Msp8SwuHQj7Uv2dpv1Nm74udbdHG1E3IufAgCxAYmbC2Dc+Si1zDwJ+OWhbAQh/rgIFyd/3Mj3LOe+yUmbkHcGOEBd5x1M1xKvzdK36wISN4GGs15ZED//6sJFUnK29/N3aEANrPINSouNyqHdv6E5xgf4mezkktULdn7o3Z+FCPUPOkNSmkRLN1a1/A3bk/h9NvcXUAaTtEMRK8H/ykR+csSGNEkrN6DIayEmBa34Aqx/KDi2PHEadBfaSzLrKHjw3xKSawo7yZQaG4md2VvgNcJWreS6v7A3itfxZNvGAnU9SePD83vIeUxosXuQ/DdpOsO/CjGCyCSkesdMIqmLoA6Fve77AW/rGWJeBanHixI7C1GdsokVmn+YlpNAFd8+5CUoPi+g/0gR02p0DA8vijEjd/ZiJplnkXWwm/+6gaW8KpRCDlPvztb3TaIyi8gRO8ycf18fvMCVISzP3usjtjs7izxB5Hwvk7npSo5dZCgCT7Ta0JiurbOgPAtd5WEJTGl+WlEsUs0kDvqNKFLS0XvMDSKSr/DkKl7/EZW1Eu9uWUYPUxrkaYI+hXFgMfq4CAbxdptAAs7duKdDOY4s=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ggKdQqK5Uap5VUWeLII/iQgpV53O0RMJ4TTyv2e/QYW6oPni2ncXFQAlMii1?=
 =?us-ascii?Q?I5AggzoZ4oKCguH7Y8vfsYusduSAYwMgH3hZLy2iPWd/QOkhus/JAixqGMIz?=
 =?us-ascii?Q?NPFNBJ7003WrAl4VfuJnLqj2NBiQvOEQ7yuDXXFYLSkQOY6YtOyBcbSjcq//?=
 =?us-ascii?Q?UCzuYrOF/GuMArtBJRUJ/VLh21Hf+RJ2fw0oMlvdeUIKG1sPnnc91diF5k5u?=
 =?us-ascii?Q?kkl4s9r/5bCUVnrhXyGOkhvFI09c1iLxlarHPkMkOewxLq8H1Ukih0zimtOA?=
 =?us-ascii?Q?E1rm7RGD9bkhIBZzcpUj3Cw8Oaih7EjSBjZheOVQKrRbtBYmINHD8PTWOzJp?=
 =?us-ascii?Q?5yA6YrQ9zGNpVxsbV98Bc5RVPPPWYEE2ebvSdN91fQOnsi7oAh4vEJbdQR2L?=
 =?us-ascii?Q?7GO6VL9tGiYMX1uCC0a9RnfDoNRrfLSfUwagV3ArpgQH9nbJ3Rs+vr8Nx2Z+?=
 =?us-ascii?Q?cNxWrrkNZxkKBEL8PC/u1hH8mK/cgv17e6DBMcUVZ2UGpASiXRZHCDILoxyp?=
 =?us-ascii?Q?4bKGyuk4I0znXKHuA3K4Vvvuq+U0Y98OqnAxJcBzUajdNSh/pU/LGdKhL6HY?=
 =?us-ascii?Q?vAa+1oXTwWqBYPbR9JM41bXOvVywLqSUF35GwPh5usi0xqR+SyxULxx2kKgQ?=
 =?us-ascii?Q?noSilZ13FktKxC4IpLJMOQiV94cXBbSUO5GIsnQoDrp6xwmWWQy3pkNh01eC?=
 =?us-ascii?Q?H+GNQO7MyU/xtKeQ71D1ZqpdjXJAW73CYUOFpq+cTYYJgRm/jLBCEWjq/fD+?=
 =?us-ascii?Q?LqWIKFq6P8aoazLWovz0KRlDki4HmRo8vpmyMI5stAb9OIXh6OGONLzs9kZz?=
 =?us-ascii?Q?B13Bw6BWIz5igWJNQzjGOUwxAMNG4jDb7gCAXeOZ4NLHDe9CkS2HIm+4QP2B?=
 =?us-ascii?Q?A2peRhdB72F3gwhKYW3BNrfD9g/leNGr9o4lR87FwQ64t0P3ksSWOvuE0PqA?=
 =?us-ascii?Q?lAn5HgfsHOl/IcU6MKEGagUCF/RT7QkzUL2XVu6DsDqxQwzWcsYT5X0wjj+l?=
 =?us-ascii?Q?ywli4aK74+tKRPEHJhxtPmyeKe+Ju7VdifAeuGofTdRzPqsPS1pfZl3f5C3j?=
 =?us-ascii?Q?Chf3x840XLU8NAUozhebNA5SStK4TwlYcDYdzEGaTwNBenTSFSwliryGt+i9?=
 =?us-ascii?Q?0wmhqA8qNCEWgktWPdnCXeewFHldBfwJ1G/ydI1RKmwrgilc3PSp57gjhdaD?=
 =?us-ascii?Q?PAzNHRM7p6HXjIAft/IqzIGqaNQMv3GSnMAH7AgpvedyFD+MeVUjcZztGbSS?=
 =?us-ascii?Q?eZZ16wFqjCCDovMNaqcM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dbfa6b-5f4e-4b05-6e02-08dcd8c1e512
X-MS-Exchange-CrossTenant-AuthSource: SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 15:44:06.8128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P223MB0569

The previous implementation of irq_work_sync used a busy-wait
loop with cpu_relax() to check the status of IRQ work. This
approach, while functional, could lead to inefficiencies in
CPU usage.

This commit replaces the busy-wait loop with the rcuwait_wait_event
mechanism. This change leverages the RCU wait mechanism to handle
waiting for IRQ work completion more efficiently, improving CPU
responsiveness and reducing unnecessary CPU usage.

Signed-off-by: Steven Davis <goldside000@outlook.com>
---
 kernel/irq_work.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 2f4fb336dda1..2b092a1d07a9 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -295,8 +295,7 @@ void irq_work_sync(struct irq_work *work)
 		return;
 	}
 
-	while (irq_work_is_busy(work))
-		cpu_relax();
+	rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work), TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
 
-- 
2.39.5


