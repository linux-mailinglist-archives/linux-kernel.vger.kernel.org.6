Return-Path: <linux-kernel+bounces-268434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECF994249A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 04:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07868B239A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3517996;
	Wed, 31 Jul 2024 02:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Upz+bJUv"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2094.outbound.protection.outlook.com [40.107.105.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08611798C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394548; cv=fail; b=ArhKPcuYAymIFng4Wc4t3L+IAfgBfNnXPmTZZsdr5WPqmBe6+H5iTfmr3I1o4pC6vVsOTtFbWbcq1ae9YSiJJYiBLOe/947cx8LKGU9xPTgVbAZOF6LXNLX0gLgTjpTfL4jH0KbiqTKcBg9wQ4Uq9/64wtZec4UtGxNA3ZjGIlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394548; c=relaxed/simple;
	bh=amum14a7u82OKOFkd8/jGtEKb9SuvdtTz2SmVhkmN48=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b4JbI2luOFb510ZFjFyLcv0Gu3tnUn+suivP5L/OgauyTosDnC6nAQD6nBFIcXEw47aLEdDvtp5TgBAETKWBcVOyNPN95aPX5zAS0dMChV32MHJ4zqp4dyAGInESOsXKrB9XlLxAMnXc+T/S1x6ssMaCsRrYzOjDSGyTSp85tkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=Upz+bJUv; arc=fail smtp.client-ip=40.107.105.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKf1zgLVKmNJ6JlGdas6GFAfp5ojpLI5UuRcFAARQGRfyzQg1n9CiF2N4IcQUk8IbjPmrfLhWehH5gRAIZhMabh57TjMSD57csxU5Ii6ocRL1w2FMGYa0NN995hLVQBAI6ILhzljVwd48A/jB5H1fy0RsCqQLcI81V20Ju7UfXE+Iw+WLpZNM1e0r5W8Qyr+XtGOLGJSy13eEzNeIppSfOpX6g4ocREywAvQ30zSPSTGevtmc3oHrjG5OJ/hd2jjcBwWMlhONz7vfVDcjBa7neGThS4SCJwttjlLuoPMzKOJpv9Tcc8ZeUNrO3cQRtbV1nhAUKb3i8dM4vtsGzsmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRODul/gSalLQ3/wW/OJKz9CCCurFC9o0jhqDChdRNc=;
 b=exEX4qBCMD5p89FhzEEbRFmtShA+lse1CNZH6KXjrfEwdUh79HTAdPsJQYHTgbUS5MSKu8WtchgAA5pSxzDsOCZaxUjFVsOPNLCtU/ybLOjibCV+a2s9HkbGgrfQjtEJjJMIfRkK/VrPCzhduGr5w3TIEsTj4YIYapn5pEJYre1f8+f/RP2c/ZVZJhBYYEdA2PjF4Igv+Bw3qJACyIPm5jRBLCJW/EaWOvx8iWes/TnQcZsl+IKwKISLJ4tlRvgPlyyHvfOfOPHOk7Ju+6BOgeY3GoRmCXhccJ05tiHsz906UPcnIXtAvOIJHvkv5Tk7GxXMfDlpwfzh7s6g0MhcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRODul/gSalLQ3/wW/OJKz9CCCurFC9o0jhqDChdRNc=;
 b=Upz+bJUvtLbcBAKQQzMvcywAyV+nTSSkwgP6frkgKrAfxfiRPazfQjT6Co9HsfvQdfTnUDZiAGiAxSz7Am5lydYcYPttzOtBA3u2xgcydNTNR4nsV25A8F+3jcMIfD5prWtYV8IXY9X9/tNGD8glH0wROQxTcrJMH89orK5/Hv1+D7wMDMrIegX4BbP0y0DOspxlgsaj36HAAEucEnH5/g+nll4ZfasXmSvBlcg48QJdv8xH0QID/hbQh4dV64X+6YNuH8sMX+BaJmP45LuTJfCfquxe8QTL8LmDftuCn2IJclinQfwc8eq51fR/lu89tYTR799R1f20MfVsXIl/cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by AM8PR08MB6483.eurprd08.prod.outlook.com (2603:10a6:20b:315::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Wed, 31 Jul
 2024 02:55:43 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%4]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 02:55:43 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yongjun <weiyongjun1@huawei.com>,
	Chen Jun <chenjun102@huawei.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	kernel@openvz.org
Subject: [PATCH v2 0/2] kmemleak: support for percpu memory leak detect
Date: Wed, 31 Jul 2024 10:54:08 +0800
Message-ID: <20240731025526.157529-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|AM8PR08MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 411af27c-75dd-411a-c801-08dcb10c4483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TiS6heEkQWgXCalU+8v8ZgzbBjGr6sqB4+ggoNIOQCxCtRP7m2kpM3QkLi3k?=
 =?us-ascii?Q?S8Ds50G0cOKT/quvBgUxrzfFZEnTq3oNiNgfhOjWKzDb4pd3zMBWFEBqfPO1?=
 =?us-ascii?Q?HAbRItN8Oon/7rla7lrPdiXoUcW43QiOML3G7sZljDuBn9Dhqh+/DTIXelo8?=
 =?us-ascii?Q?Na5awYn4vwJ61XVXsB4EvJU4GcY+9ExVNZzMMHcs0T+NRsBwBBKUpdsiPl6k?=
 =?us-ascii?Q?Ty6uZMXonQgCbVaRcL+0zCmUvxMyjfld3uA/+WbuFh3yAom4qCSq04yfRK2p?=
 =?us-ascii?Q?CKRJjpgXf33yGXrY+cOK5GBHNRTZSknGlDjm1f7/xwDsuMNPMPsdr+WM46ya?=
 =?us-ascii?Q?qzZAUkJJjHL3WXatDRrAwhmb6aXJuvR4vYn7DL0hD5OQr26A72VbmE/xRgA1?=
 =?us-ascii?Q?xSJ25YI9IiQs3vXgJD2N/zBHUvl+cYoacTlNEL0h51/xOo8AcTi2t7dSa1sm?=
 =?us-ascii?Q?pvmQlK1TUP7deubhtrnHDjzLfIXOKx/xnLdjSu5v+xawOv5PpUkl7/ylWKse?=
 =?us-ascii?Q?blBAcigeBMC2aTP1T4BHtNcc4/Ld7/pfY7+gLjYOvxkPfDM/BcyDrEtnG+d5?=
 =?us-ascii?Q?lCTURYbQc3saDfSpT8WAnqtCZ9z6hSxkeEaDNWy7r1Vdn886Q9GMzuBWNnfP?=
 =?us-ascii?Q?pUPxDRT1/N06426ywMaON8UoU+CK8tanYrFIzdX4n/N+aeChctpTPf/7E3xH?=
 =?us-ascii?Q?FuXkwz4ixPX7hAQBtLiLf4SEktQeseHjgloHNnWjTjHbhfT8+wcU2jHGs7TO?=
 =?us-ascii?Q?JMUCBYxsFi3JW433Oio9s3zxQESFcfnksrWxVgohUR3pPLLPd6erSdk6DJsm?=
 =?us-ascii?Q?4Yayb9uxTvGvCJXLZP+PdTizVUk8C5UUU+A3WcTk5FaZ2JxHxIsd6Sdm3oIa?=
 =?us-ascii?Q?dXGInSBHItzns3H7zYq0UYiY0GKxQbClF2NxJcYeNqL30tPiLBqNa3/5RhBl?=
 =?us-ascii?Q?eaAe4RPabN/0yLGVnnx28Xg52He88v0Q1tqAnMSufY5b7tjEDLSp4JY4Kuf7?=
 =?us-ascii?Q?e0PcaTZFV2/BQHakVdzM4vwEQOHrVRk+tmt07LrH+tAjZoT9sraIUkumHHGk?=
 =?us-ascii?Q?voZ/OzKLRLe+G6F38ctQdEukG9914n1sOPwrEnaloSFw+uJM12sCA3a2N7pv?=
 =?us-ascii?Q?PF7uTFbCq2ummCOfRAe62oERh7ca55jQ9RBBxavFL88HpXdbgTnWjfFZsxpB?=
 =?us-ascii?Q?c0a/Dwmr8oGkc97Gh+IOfCVBC/X/QSgMmnVo+6tHZCOUvjwiyizNqxh6a2Sd?=
 =?us-ascii?Q?QsVwM3zihWJ2RzpewWfztpTNNdAWRY/xpKA+mK+mGXvAPB7pw3TmN1u5QF4v?=
 =?us-ascii?Q?J/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IFUaLAurR0WzNJcE72vucTFqa/MWtHR2WLYfOEtNbtDrQh6oJLe2E6+bMidI?=
 =?us-ascii?Q?tM92mwBH6FUGeNKcpGvWbwr8bo8hcq4AqxeVKRn1TunglAQ3X/D2ONtczJ+t?=
 =?us-ascii?Q?cZeEBH+BbL2ISdQDZb0ngV2j4bMuNC5/dOl8fWKygRa2nb4Nf9rtkAJvdYd7?=
 =?us-ascii?Q?5zgGJbsrI2S9GzQ+zsN+xu2lYTn+WH0CHJeMbTNmlw0DcxJDU6HAzo7s66iN?=
 =?us-ascii?Q?DYJQ2Tjg36HWeQkZ1yfBSVpNqUwJsvWVZ2SfXqaFZZ7dBh/UiJ/QZ1a/nI40?=
 =?us-ascii?Q?fc3esEIwJkih/XhhjOmScuXVc0QOrsJkBjVk5es88OdAvD3sJw81dISDJAqS?=
 =?us-ascii?Q?vsdgNWSv0HkaTsrcDCajLGHfUm1uPV8ErTnOTpT6d7RNGvveUYZT3tAaJ8kE?=
 =?us-ascii?Q?0+2e5jABz0Wh9guRttsGNFRORYpchHSPSDFuRfchrtmza4k3kwEAzwgg23NS?=
 =?us-ascii?Q?ja6LSRId5xn/6alv8BSr4sWYvdrvObzK/amU5IeRwxo1PLm16ezoBLrzEjBt?=
 =?us-ascii?Q?XascWnFHJ9xGji7RwG6ay1vD3WCRoHE1JHUWU03kSxLkoHmR9TpLJN43kHRR?=
 =?us-ascii?Q?qo44JHhnUNGz9SQymg0StaoJTv/+MJI+xGF+ivHDXHuiyM2S0PkZ4YgTwfmx?=
 =?us-ascii?Q?Sttab9UtMcbZiD+BSclssXJ0G0fXZYtVODMOFTg7i/RiOnOBjcORHE+dKGiX?=
 =?us-ascii?Q?9DgJassLL0avUi8OWo7xZ7TRV6qdfpkUjrTD1Uh6uT5QFoHpbynxKXEoQtb9?=
 =?us-ascii?Q?izL8qBvqrisSC4AnaFfv30eDMctDgHuY6yJuzyfTFmQV5bYYXPUI1yRjKdqP?=
 =?us-ascii?Q?ZbfHs4AFD/OfJk3q3TTZB3/PLY3V5bbnaARLn8CnFIZSueepn3HefTo4VOBW?=
 =?us-ascii?Q?7i+jhpJMPGLPO6FeHRk6prYBtl8gT39kIGmkebvBl8HMIQ0U1pb1qJs/IVVC?=
 =?us-ascii?Q?D4Q7roQ6mrc4qNSDEI/EgFeoH1gjEvdpqi0UzFqysTqUnz3HaRaAD9AbOTNF?=
 =?us-ascii?Q?hnPMfGnqDKmZlZ6wKSMYBrtGafMG0+IQRwOGpHcMwB5Sq3HP5tHdDKXstE0v?=
 =?us-ascii?Q?+BKXikmU+D9/qfIxaTrkE4ukN7xbmSuXcdRe3uO+IoNm5jYGKaNQFfbgHp8p?=
 =?us-ascii?Q?t0a6EH1mJ2gFq+uDT30pwxnHWIVyAQBSEswVu0S5q9+zwTc/0KTU83CG9Kqf?=
 =?us-ascii?Q?Oh5xR4PWIWFQLh4ZgXHqB3UMhx3a5ShiLuDcaAz2RMyC1I0pGd/EJQpRQcWB?=
 =?us-ascii?Q?MGVhGasGFeEhhn2rGG+aMMV80H3eN6IXJu343PPxBNQSgpVBBdBZ+uNuyo0f?=
 =?us-ascii?Q?QwEvM/cX/EhZcIpkPDNZnZkh9I19nOegeM2OowQX0VnuJ82Pb46OjUqEuqSA?=
 =?us-ascii?Q?8PmPSHziG++H1fErK3SGkffNCARwaiEn9/LWuLyv36C8sQdH9NQ3uKSOj9c5?=
 =?us-ascii?Q?+93k6aX6Q0CEQTsiYuJxqTgElNM0iuxDc9+mm/Wcv5Mg3wb5O1O+FhSEO+Ks?=
 =?us-ascii?Q?b36lOkofrGwn88eTlNS6vd8GBJCu3f1coUeEmFgRkEtArNNREIcTfD+l2j9+?=
 =?us-ascii?Q?Dmcm484v96Y/ITiI1aUaOcFBzzWps1XRe66KEL+iFaXnTlenjIm8R/l74YZH?=
 =?us-ascii?Q?Q5v/j07T8usVgp+bQfnnYwubd8iqeu7LFoAyOQJx32/v+1rG/lz96J1OW6/P?=
 =?us-ascii?Q?sGMWLg=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411af27c-75dd-411a-c801-08dcb10c4483
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 02:55:42.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCcS8b27bCaffwYoX/uPWZWTUf83u713HFABREfUiYu2cUJ+dGZpHWQgITxgCCbNkzbPFQXc4ldgTwKng3AJ9hxaU5uUuRnmxFnxffWp328=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6483

This is a rework of this series:
https://lore.kernel.org/lkml/20200921020007.35803-1-chenjun102@huawei.com/

Originally I was investigating a percpu leak on our customer nodes and
having this functionality was a huge help, which lead to this fix [1].

So probably it's a good idea to have it in mainstream too, especially as
after [2] it became much easier to implement (we already have a separate
tree for percpu pointers).

commit 0af8c09c89681 ("netfilter: x_tables: fix percpu counter block
leak on error path when creating new netns") [1]
commit 39042079a0c24 ("kmemleak: avoid RCU stalls when freeing metadata
for per-CPU pointers") [2]

Pavel Tikhomirov (2):
  kmemleak: enable tracking for percpu pointers
  kmemleak-test: add percpu leak

 mm/kmemleak.c                    | 153 +++++++++++++++++++------------
 samples/kmemleak/kmemleak-test.c |   2 +
 2 files changed, 96 insertions(+), 59 deletions(-)

-- 
2.45.2


