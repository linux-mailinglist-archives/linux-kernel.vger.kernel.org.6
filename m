Return-Path: <linux-kernel+bounces-340082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60E2986E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143481C22213
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7620819413B;
	Thu, 26 Sep 2024 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="d9z6kFDK"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2088.outbound.protection.outlook.com [40.107.255.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9588B192B69;
	Thu, 26 Sep 2024 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337610; cv=fail; b=O9LKhMxd7G9pZNSgO7rYY29okS642hbZ8QXgIQIJIk3EVkxW6N1cVcsyiu3B4SAcASWhNJiR3yg8QJPguqY+7LukHsdQXPF60105pgXMAXLVPbE1oBmF35VRrpWMfV+998lelhAjuUpKkaf0uG+HYe3Y/Mz0G2IVThWko8O8i2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337610; c=relaxed/simple;
	bh=r3OKKBxQerRXGZUalzSaDOsxwGMZaKQMimERuF4SN3U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MZzKWQHwrtKSbXieMs46XGeq4zl6YCEy+4q9glnIV5OYG7hvvqa4u8SEnfq/wu+1gqBFiNQse9eRAk8O8VXnCB/p4BAAdOXgi5kkMJZCgqsTk4qJSwsmkFatSEcbJogGESzfTUQQ/yHZJOomvChciWbHZ0jshcDP9Yq08bOJ08k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=d9z6kFDK; arc=fail smtp.client-ip=40.107.255.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8YF5guQf2nHFmFtYpKxmRu5ieHg6Zy74f7Rm5FLvfYWYRMcCf+W4ppdl/rGijlBKDL1AZfMpH5QbneeXdeLhlKWpW92q34uu52oHo/DqDboTjj0QsyLbMizxqNKgXIhyPtCP1+CVUL1TMKJQ0GQ/vu8G9oc9x9Au80RJfZqAkQKdPEPTb3tUYleqhKsuiLPV2aBw6FQDKxYp6Q+d2H2juWzY5p2eIDKYX/0cDrSxkE4yjrKkOWbOXIG63U+2MYkAIqUK5xkIgS5ygok6h081VZQrn1CF2euMRcgmxtjzJY86YzalcmH0zUlXOY/w5XT7vnV/hvAEhbgYR9GF3hUQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYxkJs39FULyBbtnj5bqMyOdp6ms7R7KDbDvtiRLj5k=;
 b=NNfRDVRmngBgIXoNyxtrAI5nakKy7tY55cgj1AmElRmBWqC70jACEw9nHU/4l7AbFBuoxMLASMqzZbtsr5nYFHJLB2i/XtKV3KJXFWCaptY3rcD+sUZYjCP22J+64AqOhTZEpkVUzdxqTG/AzUMMQpiRw+m2rhx8TT629UFBocStd2+W1JN3Z0rSVkRHTsbHR8rY8LWXDYVs2YX+PL2O3HvuWnEG5zOuNVS4aQ93lgGZL9GfXekRgrtuyjbz2sUOZWyh4NtH7G8I4jYiVqchOzOzDDvYImsXBYNsGOzV/Yn60B6rGZl6aPRXC0LryBfVkpd9ylWtSEtSO79TH/zm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYxkJs39FULyBbtnj5bqMyOdp6ms7R7KDbDvtiRLj5k=;
 b=d9z6kFDK2fmyBNnpt87S3ItWRpJMtUI98MPGuVfUhu/wucYYb2I8fKuRvYjOipUy2soI5TiC90tf/e3AHungfLTbJJ9+vpVOOAS3j8mWpVAaAmB/RsQW1B9EizhEKQwwhVAgJAHb8pTGosLKogiz9L15s+wIqYhvY/vkR0F17riVSIkf0DbmwiWD782/RtDlqgQ5lEAZdiBfoJ2fvrrmc0zxN0/3oJeNmlBEQGH7eQ3OWtsuD6r7wwg+Y/EIoDaPb3gnsi3GTPOVEOhi5ZulweIkLtqMXldC3O0wHcpEhBQD01BZICRJ4KO3ZS7Ucf1/WSI9dLuQ4ZQwyw8N8d9p+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEYPR06MB6484.apcprd06.prod.outlook.com (2603:1096:101:171::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 08:00:05 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 08:00:05 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: castet.matthieu@free.fr,
	stf_xl@wp.pl,
	gregkh@linuxfoundation.org,
	duncan.sands@free.fr
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] usb: atm: Correct some typos
Date: Thu, 26 Sep 2024 15:59:55 +0800
Message-Id: <20240926075955.10199-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEYPR06MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 427ddaab-1812-4b06-b700-08dcde013b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pYjpDCEMSRFBlwCx26ZkYZIS9s5NhPsmTnuxk1MAvMcekTwe+G9+WOuKM9Sc?=
 =?us-ascii?Q?KvMg++EhfniVsUYg71bfvm8eXdW6uan9JmupiYupwEvUkPRQOYgISTs0+Z7N?=
 =?us-ascii?Q?lZtsM3tbKeTya9C6q8Pvr9kqtnEZscZMQaUkxN9ypbSl0u8aiTu7/TlNE5gV?=
 =?us-ascii?Q?7BEbCXDqjzcQy6P+hCepboLpzbsHa6X1OijvSou9pSFMneO/8TQdP/ZWdhQz?=
 =?us-ascii?Q?C5T27TJlEujSPP7Clb4droG45e+xiRIm+F4gXEAFJZsWwjzr9EgQjdYRiP71?=
 =?us-ascii?Q?FA24l6OiTIM8PA3Vh1SOd2eqCOTZ3SclcWbi04JanG5EXArNgJ3Mif6pf35H?=
 =?us-ascii?Q?WB9gALNxIItvN2jt8LzC+Uzy4NH+YUdxqBzag/dWdVmddysRx3YA780zRjXm?=
 =?us-ascii?Q?z+omKL7yUn+ycAPjaG1298RNzijAiy7lVoQDPvrwnBC3XJCH9llS1ia/V2ue?=
 =?us-ascii?Q?TK+ob8gfEU4cVYTcz+zKr0Dfc5UnFonbpzKoRM7xh4Y9fVuapmWG55GSzLkZ?=
 =?us-ascii?Q?qfK+E9XfyBEdrn8RmB2OMxA48qDd0S2wCnhr/HjF+p9dr0pfNXzuU6LYIDQj?=
 =?us-ascii?Q?5U5c4zLZbwt60NjZJaErXTB/6Pum3/d7mFu5/iMdJp/8U8V0UEp/+78FixAe?=
 =?us-ascii?Q?3XGj5fLB4cHDmhNoyJ6g0c23h9olOHdfYihRRG0bUp1L2pZBLp0yh5TrFUwT?=
 =?us-ascii?Q?dxVYyXjl2c+gy36JrOoIE3KBWJeWg5FJvEMXGFul7pEMBcde2dzwsXSRsUPJ?=
 =?us-ascii?Q?gi+moR0fGb9OmDfF5yDoYtz1dYLEooCwTOoXcoZ2zBV2yq9uukJpUJAoNOUB?=
 =?us-ascii?Q?kBoI9xLXD8j5NrqzkHztcSsJyaGSkeScrh1qHI+jnvRCJrfMrE1zYPrlErtK?=
 =?us-ascii?Q?hnJkKT+/LKyFT+QmLEp6TnP+b1XaVPXG/mHZn13VBUswIrJZop1kztiJehaV?=
 =?us-ascii?Q?ed+XzXjgBLpZIW6bGFexJWhmHMsjOipxCtKVW8reuR9bvfPwFWDQPzctmVcY?=
 =?us-ascii?Q?gsQ2EpWZ3fiZq3/9Zbtcv4oqSPiomlr7sG9iXt2JCKIcUcrMqD/GwZhtpkc8?=
 =?us-ascii?Q?9tl6IOjKk2MgK6qhYDgImcvPMzEdfqMpWSyLCJVb7vivpzjNtUUEdYaR/t14?=
 =?us-ascii?Q?IgDq/4j+HbhqOAeJDXNq5LK8JvvEZcQ4pbbPQjRxkVpfCDIAF28BXIb+Z8Vd?=
 =?us-ascii?Q?tNeZXD3d3E9ClldT/EwMF7jklAozlr7HbfpJ7+WoSz0eCYYD0l5SBmPhkSr+?=
 =?us-ascii?Q?FkrpNL2G5tabC6azgmp7GDRBU+VDzJlQBzLUzp+Fa0idyFb2TP43M8AMgdlW?=
 =?us-ascii?Q?HWI4Zu8QaPXXl0+XAQQokQY12+z11qoGUcKi5+0NNoXz7VNQMpivV03DeS7m?=
 =?us-ascii?Q?/t6udK9AAnKmHvI7zmknhBY8w8rja6gbla3BLtTpQrdCWv0kCeUtV286Cg9A?=
 =?us-ascii?Q?f+sKUmTCCoa1gizk4qz7GeMuDdK4mD4f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W71dEZIrufC8EjXb5Ic48PKdLSxRGmLHDeEKZIYNlH+FOeJsGSA6ONALxlak?=
 =?us-ascii?Q?Qoe4gL7v12a1k25crabFoppL8GaluSS4nnzbdqUGB4wtdjxGrF/PNWc1o2Zq?=
 =?us-ascii?Q?uUgIy4rGNI/N7HuG1LzW7s7uzIxrFRaucR6Xdb/SH+w8KtVtZLNEXPjeTKLS?=
 =?us-ascii?Q?XxcDzUj3PlaprzfYW1XfaRAAv79sFJHVIIDPaCyojhQRJBvzR9QzymRW3WL8?=
 =?us-ascii?Q?HSwxpuqQ3Fc181I1QGaSdjVxvyAvZace6DbGAdeJws4OuiLtGVfjMXmfZyvc?=
 =?us-ascii?Q?OD65Uq3pkR9I0mStrjIq5Ux8xOaZ6RiS32vGZqNoGnXzItIxGjUn6gz6cFg3?=
 =?us-ascii?Q?CKYgcBiJLwk4dnyIqH/ZATPKfauRUJpLROXevEPvcPIKoBKgIIm0HK0IB0+K?=
 =?us-ascii?Q?bMYD6xE6Y7MmfI158Ty+eP3XB+nbjh9ubEaEmfNUA6dSr6mQlznPrNyHV4YO?=
 =?us-ascii?Q?mbNX3YbqaZMi0YujPpO7je15RVyOhLWXsUfmfUkNOTOy9DYkjxzGzuChJUVK?=
 =?us-ascii?Q?SikjVy0qO/ce5CklWggEqNwjF/rWwOkAcoGOFgrFNxcdC7khaxq8zByiF8KF?=
 =?us-ascii?Q?a0RaHrLo4FO0twu1lPtbg2PZJ6KY4DsU5xStv5D4iHSX2ru7/1FOsHNbmdUW?=
 =?us-ascii?Q?zfmUob0BjHZ/i3EozqrZBbpATgAJdJqe5DA7VYv/5jpHCgVLVQCXbZ/yBehv?=
 =?us-ascii?Q?X1IG33IwMu+WyzwmBvjiTa3BUpJLG+jcHjI/NtETw0povm2rG+Wiyj0PQ0j6?=
 =?us-ascii?Q?ZPtpp9bmeoStABxs8gdnBNuwZf5d+3X6CuBx1l1TjpbZqJwFiS2zRZ4XijVl?=
 =?us-ascii?Q?ImF5xNIrAhCVnxzDDooPciHtP/HWpaxDW0YI1vhRQCMFFtlP2sgumxILY5pD?=
 =?us-ascii?Q?x128d9uocx849RhpwQXXvkiolsw2VwQN8LupZ8fNH/UlJDj0RCQ1NgMlCzz9?=
 =?us-ascii?Q?fQFUw6V1cMA8IcHSseZOHaMnjJO51AJuEGtB3/6ryk6jvQ4s2cSgJvokHt2l?=
 =?us-ascii?Q?ndUG92OSjhhTJyX22CzDEDkZSXMqD2dnUjyzyjcuopmAsMDrKoCauMn+Vgcd?=
 =?us-ascii?Q?Dd8IutIFJSU9yAC1lCGxk3YqYlQLeOWl0pdN2ZTTTRMTSGuZA6qZD4SG3tge?=
 =?us-ascii?Q?y2iPJLZ8wcRyPXli6FwwbMMPZpZEfMkmDk+2w3KtqUtUfC8XAYizp7uRmX1z?=
 =?us-ascii?Q?vNgzI6z75UgxtuXTBh+WI3+hijNloM3+nVE0xp6Qbwq9e71JPR8vmu8M6Tbp?=
 =?us-ascii?Q?xbvCk0lrjMRwU6JAI0pNJRMkcb87zxGguanaMlcGsHTBM3xq3OMY8aFiUInm?=
 =?us-ascii?Q?nnksUKDhw1H/7yPc3q0Kq7Jv9TFA0d0a/5v/bttuhAUQoqsLly/GSQlzLEuQ?=
 =?us-ascii?Q?St5QKPWsoyYEfGsTq3cGZbISaNnFmXVYwxAzYFe4JdywIwjfYLZPLRwkDB1U?=
 =?us-ascii?Q?WE5A178VM8U2u4bxExCUEeFzddak4aB9ESYWmIvN1c2vYJJE9xGPprY0j6kE?=
 =?us-ascii?Q?6qPF+1UrUvbsvICCf/6jjjg3jG+aIPJ/VUKdZ4TEYiic7bgT7EEazdwNr7s3?=
 =?us-ascii?Q?Q6lh169I3ug0+PApqarsxIsVHXD4kL3XRLjnlof6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427ddaab-1812-4b06-b700-08dcde013b3f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 08:00:05.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IUxUrR8ItBtz+rnIE+ywijnBRm56rYxCx1J+ekDTStf5r8PGhlNaURDg8DYiQlUfHtmweMmpnS9QORE47v8v+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6484

Fixed some confusing typos that were currently identified with codespell,
the details are as follows:

drivers/usb/atm/ueagle-atm.c:811: endianes ==> endianness
drivers/usb/atm/ueagle-atm.c:1279: timming ==> timing
drivers/usb/atm/ueagle-atm.c:1975: preambule ==> preamble
drivers/usb/atm/usbatm.c:1161: alloced ==> allocated

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/usb/atm/ueagle-atm.c | 6 +++---
 drivers/usb/atm/usbatm.c     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index 16703815be0c..62bfdf142aa0 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -808,7 +808,7 @@ static int check_dsp_e4(const u8 *dsp, int len)
 			if (l > len)
 				return 1;
 
-		/* zero is zero regardless endianes */
+		/* zero is zero regardless endianness */
 		} while (blockidx->NotLastBlock);
 	}
 
@@ -1276,7 +1276,7 @@ static void uea_set_bulk_timeout(struct uea_softc *sc, u32 dsrate)
 	    sc->stats.phy.dsrate == dsrate)
 		return;
 
-	/* Original timming (1Mbit/s) from ADI (used in windows driver) */
+	/* Original timing (1Mbit/s) from ADI (used in windows driver) */
 	timeout = (dsrate <= 1024*1024) ? 0 : 1;
 	ret = uea_request(sc, UEA_SET_TIMEOUT, timeout, 0, NULL);
 	uea_info(INS_TO_USBDEV(sc), "setting new timeout %d%s\n",
@@ -1972,7 +1972,7 @@ static void uea_dispatch_cmv_e1(struct uea_softc *sc, struct intr_pkt *intr)
 	if (cmv->bDirection != E1_MODEMTOHOST)
 		goto bad1;
 
-	/* FIXME : ADI930 reply wrong preambule (func = 2, sub = 2) to
+	/* FIXME : ADI930 reply wrong preamble (func = 2, sub = 2) to
 	 * the first MEMACCESS cmv. Ignore it...
 	 */
 	if (cmv->bFunction != dsc->function) {
diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
index 2da6615fbb6f..d1e622bb1406 100644
--- a/drivers/usb/atm/usbatm.c
+++ b/drivers/usb/atm/usbatm.c
@@ -1158,7 +1158,7 @@ int usbatm_usb_probe(struct usb_interface *intf, const struct usb_device_id *id,
 		if (i >= num_rcv_urbs)
 			list_add_tail(&urb->urb_list, &channel->list);
 
-		vdbg(&intf->dev, "%s: alloced buffer 0x%p buf size %u urb 0x%p",
+		vdbg(&intf->dev, "%s: allocated buffer 0x%p buf size %u urb 0x%p",
 		     __func__, urb->transfer_buffer, urb->transfer_buffer_length, urb);
 	}
 
-- 
2.17.1


