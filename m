Return-Path: <linux-kernel+bounces-307958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E196559D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970FE1C222CB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859613A261;
	Fri, 30 Aug 2024 03:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="heCYhkrh"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FB933C5;
	Fri, 30 Aug 2024 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987893; cv=fail; b=Jy/6iQQz7TEvmPM6MPAhadF2FCU0GB2ASZyuZAGlOvHcK8m+zXcjQLn74cmKRuKrai6Kbsn5xJGPS44Yq7mwyllYnBfGjXMcG0I7FpaIbvk1yymbynxjMn4EWT30zjEVOzfN76dASDnWDZG5Dd1wieVSn2r+/QWtPq81GSFW8fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987893; c=relaxed/simple;
	bh=J4TOaCm7nkNhZi79kXCU+JPobvpKoSabUtm33ZxOZhI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dFtlk1N2Dl4MJzKWpj5vk1A0WEpnoMdxwqFCTOl9hNPiguu4IHXgUAr/zNdovP41LQSVi3FrVyDDus0hKUc4RJBT5VIyOeF+M1G1bY8MnRu+DKqwG8mFM9L9v3k0bhNUjqSqepxkT8e0PvT7EZTzTgNevEXxApUoXelgKnOOjKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=heCYhkrh; arc=fail smtp.client-ip=40.107.255.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyGwJ0WvxUFitzEQSallvHqJNZ+b9det33E1po6XCf6aKt0Hnu6rDpIOgqmgnvc8JZvfEvLDheyQw0S9MVWDAU8h+sgl7YkVAfxVVsaT7VNkspSm9zUU2aj+O6kYpvuy2AjrKHwKlj33Y1O9Y5oAUw0rF7svvz0ZX+oEz0Tz3FnUhlQucHkE6hNqK3ET5WY6dRuO68CP/+S0YfOuyp9+c3SO906fTpFUZHS9MzqPuVye1B4fkoOj6kBj2Vo/w3tq7Ff9XNVZfcVqIH/TiQPVQW1oP2G7L8wyuhhBtFoT8llPHpZv4V9KtCnfkj7l6kxK3VXS6xt6o4n4YTIan2ZqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YWNZcowbdPwr/iutCfl5/chdd1p2ltUuY9l76Hda40=;
 b=kR7S4eI3WL7FT9VndkfuJ/79r3U82J0CzNjeTopPKTBdNVSrRpUEx3i0j2deJdO4LvtlDA3dUGzU67INXJscWL4eIM3OMXI/PX5oRHP2FnLuatSt5mKx1WgGR+q8bOW9Bq+iEtXxISw7swGnP1fSVyzlNjeNOPfabO7bK0Egt0sncdsxN3eDSVAZElNwTaOVpqTh81ovQtkXybRwGjL47DHGmNaUImGoFA5IOhn4hZyskZjDnDjtUjhU0/yfnE8gG6mVF2PW8IzdgYTgG4yLPcSl/k1BUmdxVWFfgy70BI8J/iKq3wTRl6MdA96E/234RdlmBvcWaZClKBHNKDmD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YWNZcowbdPwr/iutCfl5/chdd1p2ltUuY9l76Hda40=;
 b=heCYhkrhyETxEHFs4iWv3Sukh3YNB7rKYpIB+huvykcPrirh506dMusfMVJeh1z+KE1NxRxgQK65ojO4jYqqeGRsa6gMkXNe7Wlu2zXw/yD0kd5bcZid3phFlCYjD7jINQ4y4qpVxTyEXBDNbHFjH1fotQw3bepJgOByr0BgrRhTs+gVceGacaG4ULWFA2MlD+hcEZJ4R/CzhYHjNrcSQ73uhgf4eRQVGlm1vPfSv3zNQ872oS1b6DHbe1or63DyI9HJzCk1FAl/s3mycDMOxNj2D7Vpg2ApwQ+YIJcmXB+mxqGeVKK4gLIRAEfiZr0OOB+yGc1TFEzZfxjcSRIsUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com (2603:1096:400:29::9)
 by KL1PR06MB5996.apcprd06.prod.outlook.com (2603:1096:820:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 03:18:03 +0000
Received: from TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367]) by TYZPR06MB3933.apcprd06.prod.outlook.com
 ([fe80::9b60:a415:f5ed:a367%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 03:18:03 +0000
From: "Shawn.Shao" <shawn.shao@jaguarmicro.com>
To: hminas@synopsys.com,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: xiaowu.ding@jaguarmicro.com,
	angus.chen@jaguarmicro.com,
	Shawn Shao <shawn.shao@jaguarmicro.com>
Subject: [PATCH] usb: dwc2: Adjust the timing of USB Driver Interrupt Registration in the Crashkernel Scenario
Date: Fri, 30 Aug 2024 11:17:09 +0800
Message-Id: <20240830031709.134-1-shawn.shao@jaguarmicro.com>
X-Mailer: git-send-email 2.37.2.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To TYZPR06MB3933.apcprd06.prod.outlook.com
 (2603:1096:400:29::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB3933:EE_|KL1PR06MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: c467b1a8-63b6-49f2-61cf-08dcc8a25bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MPGhAjxLYtJaM1pR8XTV763zlVb8qRamItKGRt7nXt4JQHUQ4F0bJp2LKlot?=
 =?us-ascii?Q?cJnZJcZ0Salw00S80w0IrSugEUPC94wggwhDRGsTr1T3TFdgk6uoynTaf/IY?=
 =?us-ascii?Q?/LgGB7ruZ9lHJWrsrtwA/h/GZmEB9uIM4FeVJv+zVqm8Td21ttAQT2CCDCk5?=
 =?us-ascii?Q?nsnXdEwnGDLR6t+0QCME61UGN25hcKq0mXR72ZxKpNpFAP7DujI4k3wBiCBQ?=
 =?us-ascii?Q?bIsj35MIHtvOTXsdhqsGs7jSPU6uKqDHsFKe++RgRP3gBfvs4UW6iPTWSiIf?=
 =?us-ascii?Q?C8qtFDIY91Z3iwxHoDE42KwE4KOW46wv5FLphhBcoCbUyLgDAafju/fpqA8M?=
 =?us-ascii?Q?AIbwVG+DIUvnKxXeT2/FzJ5G73uVQzRpUTrV/Aw1LkZNnpJCRcM8x8v7KOGy?=
 =?us-ascii?Q?JLrkY8207+eAnpMB+awPzubyeyqypgg3UOB8QBmAzN7a9XE0XsVA1dLkgehE?=
 =?us-ascii?Q?XFbQC1iUrdzsWgv++bkvVsxVkG4g7X16DmuMQWtMW3q2tzD8OsESqfGTVas4?=
 =?us-ascii?Q?wJcrimrV2629E03H+/3ARw11KRXpmTNzxcJ4HcPlgvg2/8pPhRBcrY1y6Iwn?=
 =?us-ascii?Q?rtZ2cH7RaHdglR0FCtVG1AbCmlXZfFjmzpzq4dS+6QxZcSIdn9WQ+fCHDk96?=
 =?us-ascii?Q?cyz7nk2SsC+SSoSAqVDQ9KL8Ev+TV4iW7clKtHTGqUS4/rzx6N+KMm963uwd?=
 =?us-ascii?Q?dyEC/iV9lf3tgbTUAInXLsqth3gcNdl/MyPZVBh2RlmIQ5XAaxsApHuUHlH1?=
 =?us-ascii?Q?iz9mnDiKlzUHfOFvB982xitR4BZx+ZzNBby0RojtnwjURriSRoCRvqt6eX8t?=
 =?us-ascii?Q?JHWvonOtfiha/LW1VatAsI3rHTA83Zx30jHybXnwr7zRa5icCcm5BwAIEUba?=
 =?us-ascii?Q?kRvI4lDwOX4NCs/Z5gumS6+/vrliGWhHj5SkcR0VRcmHXg4Lk4JXI3ooVn/L?=
 =?us-ascii?Q?3WPscRTvpr36LXP6xc3Q8mAxQj3VBfPLtnOhEyBImyZUjPrWcAXyxx+d7pW+?=
 =?us-ascii?Q?0lQbQrFmKGS78GL5Z3dB9a/7raFm5rgY2neIroEIpsvu3SyDuAhOU2WQUs3J?=
 =?us-ascii?Q?Ek3HEy3s5fQQqJgXJUucwbqlMjI9T/SzDRHgO/z7EUEIhpf3wRUupM3rx+D+?=
 =?us-ascii?Q?PTmhRC6P5N97R4u+BrQesY8QpiddF28f9U9nv06m84icTfttJMC3Y2KA1ZVs?=
 =?us-ascii?Q?fwFBV/xNiwYvLQVsbP5TM4tzKW6bwjoRjt2pwwrZZz9A0x6YJ7Xxy8QUr+uz?=
 =?us-ascii?Q?jHuOZ9vd/1ukZFG6Nq+Vz1yfb7nqAsvpjUk9G3LhU3hgaQad7uHY2sfM3We6?=
 =?us-ascii?Q?n0B1CkET6JKJNR4YGFZ1YGmLDROB/PQ2vbNHjJsvPt3LMEsIPoFnwIgg4Wpg?=
 =?us-ascii?Q?4LymDWnKZz9Jm+AazqIsHTVNawW5Y9HkIrsRxavzEzMTQ07Xrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB3933.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?waFbDgXzQDsxZX66Iz4z4pBjAc/30PG9wswp74kwe3TosO/+a9kf1yMZuVQ8?=
 =?us-ascii?Q?8DmEHua5T+/6TZvWsYNOFt3SefUhQlHcmKQrA8J8T/1c2AzAueSggq/DzHpg?=
 =?us-ascii?Q?8jBJoplnYgXMmf7GKAju1Nm+iKlZIx7mQdiTv/41QcM2L10dzZX1oKs78ccu?=
 =?us-ascii?Q?SyM5QtyEaX+PusrE98AD6DZvhHr3G/NkEL1JW5lfVPjfMQ4/+towukjxeHVc?=
 =?us-ascii?Q?9kTKNGvAl+w2jDmNl/Bbc9LM+9fWsZM2DfsiniUSHJw5JVwrHZb5tOQRhiHw?=
 =?us-ascii?Q?fEEhve4eSrOi1y+tKrVBeIRDM5xaT4WqPpzYyvS9t/bw7K5RjRS6TZQwjjtl?=
 =?us-ascii?Q?LnDS5u8kZSbgQMQxEh1hQpBzFTmEd6U3Ii+1FKTh8y0XhhztWhUrqMXoP4YN?=
 =?us-ascii?Q?Hhg5qYNbChpTRT3/PC/KGVIeDmV5nj4j+XXFpizeIoF5RFEt53J9mflcId9H?=
 =?us-ascii?Q?DG+LWwiz3Q6y+iuBdXO7dhWPUliNCNgyyn8HhuqJ3iYqHv+CymRhMMRzkBLo?=
 =?us-ascii?Q?3IZWEnHyl8FeIjF+2Taq+omk4oay6RBSJ4t9+7ONT5sf39JrB5TPtT/FWSiZ?=
 =?us-ascii?Q?Dn4TDDRAH/xAkX3HiOWWm8CXRFx23mNes1NkLJUWaRR5FpBMNqtLHSWEv8bF?=
 =?us-ascii?Q?BViFc4mrvw1SON4m4Eoa+8Hm4jYdFVC1xV9ePeZD/Txw4eVP9ZQUgSb5QGfq?=
 =?us-ascii?Q?6DP4xqQcEoO9RNMuuIcrQSQNOU60/gLamQTRc3rX03F+LJt5N6x5GjD26H2a?=
 =?us-ascii?Q?Qh95hdBLSAaQuMSDm9phbc6v+FIo4SHNCqqT0yn34godNpllyr7gS/GyMC0t?=
 =?us-ascii?Q?GnyZesysD4SiL7op8tu638LsrWpDa23T+B9k0wwfktTiouZ0i3oqC1+ESgC5?=
 =?us-ascii?Q?7q2QqVFOCjAzD3ApR2za4RruhbXDgcZ0vs7Cbnep921zxqghGcsgI+vYNuH5?=
 =?us-ascii?Q?z96UY5Mk3uG1bFCEaSlmDg7KtfVp9G7I0iKek5XzOvDTEEUqyNZhqnKX6kc1?=
 =?us-ascii?Q?OWCNym/sgYMaNus4xwCMLZO9GIP44YqfYaJ5A1ywmwuOB932+PuoHLltfQ4h?=
 =?us-ascii?Q?mh8PrN4d99W9FXin2whpPVjjfBxegUztMTWdvwP2rVs/8kvSktMn6Cat7/E2?=
 =?us-ascii?Q?Y6iaEjqMIUqbhEnHzyWpGIaGrHAOzaDKzECXbSjEQq/BT69o8PtK6cv5quCY?=
 =?us-ascii?Q?PxtoF1ZUEoxrk2snGVOLg9XNGnEu+EVwZ4UkXHSe/gkkQht3UkA6hSbuZxoe?=
 =?us-ascii?Q?c3CLTEtI3Jp/O0dCCfd7ORSj/YxpvuTo1n7gJfSyBICQ+P2jaBbLP44D6f56?=
 =?us-ascii?Q?Zw2gC72CM0ROXn+gcwttJOhwSfZO00QlTVCsWSxLjaYr0SMxlwCy8SFKYa2l?=
 =?us-ascii?Q?rRTXCjzZnnqZwpX2LCKcAHj3VCW6kJrg9U/5WkJBXLcEkzw64EObXKXyBuuH?=
 =?us-ascii?Q?HkQz58DdrZBGQ/TdJaSM+0AjMQyC4LHpm+GXzOeBdvMAvuuMVil8cnT9KuuR?=
 =?us-ascii?Q?kiL2w3brbk6c/bBCl4w60NeBNlAspW53T3E5zlp1y8y8P81q6RUwUnC3oLZB?=
 =?us-ascii?Q?cTl8T3eE+rruqGdvLIRNPoE2lsoPiCetrLS3uyecjSb3ei1pIeumr58wna/g?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c467b1a8-63b6-49f2-61cf-08dcc8a25bf3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB3933.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 03:18:03.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RACh1X1Ulcrblwt/iA+RxpQm+9nDqscxvfmOu2jp5g1K6nX9P9w7xM5X928Jmmc0/rumWJPG6u2QCV2SzzXWLvsPywTmJTBOPp5WDzOXBvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5996

From: Shawn Shao <shawn.shao@jaguarmicro.com>

The issue is that before entering the crash kernel, the DWC USB controller
did not perform operations such as resetting the interrupt mask bits.
After entering the crash kernel,before the USB interrupt handler
registration was completed while loading the DWC USB driver,an GINTSTS_SOF
interrupt was received.This triggered the misroute_irq process within the
GIC handling framework,ultimately leading to the misrouting of the
interrupt,causing it to be handled by the wrong interrupt handler
and resulting in the issue.

Summary:In a scenario where the kernel triggers a panic and enters
the crash kernel,it is necessary to ensure that the interrupt mask
bit is not enabled before the interrupt registration is complete.
If an interrupt reaches the CPU at this moment,it will certainly
not be handled correctly,especially in cases where this interrupt
is reported frequently.

Please refer to the Crashkernel dmesg information as follows
(the message on line 3 was added before devm_request_irq is
called by the dwc2_driver_probe function):
[    5.866837][    T1] dwc2 JMIC0010:01: supply vusb_d not found, using dummy regulator
[    5.874588][    T1] dwc2 JMIC0010:01: supply vusb_a not found, using dummy regulator
[    5.882335][    T1] dwc2 JMIC0010:01: before devm_request_irq  irq: [71], gintmsk[0xf300080e], gintsts[0x04200009]
[    5.892686][    C0] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.0-jmnd1.2_RC #18
[    5.900327][    C0] Hardware name: CMSS HyperCard4-25G/HyperCard4-25G, BIOS 1.6.4 Jul  8 2024
[    5.908836][    C0] Call trace:
[    5.911965][    C0]  dump_backtrace+0x0/0x1f0
[    5.916308][    C0]  show_stack+0x20/0x30
[    5.920304][    C0]  dump_stack+0xd8/0x140
[    5.924387][    C0]  pcie_xxx_handler+0x3c/0x1d8
[    5.930121][    C0]  __handle_irq_event_percpu+0x64/0x1e0
[    5.935506][    C0]  handle_irq_event+0x80/0x1d0
[    5.940109][    C0]  try_one_irq+0x138/0x174
[    5.944365][    C0]  misrouted_irq+0x134/0x140
[    5.948795][    C0]  note_interrupt+0x1d0/0x30c
[    5.953311][    C0]  handle_irq_event+0x13c/0x1d0
[    5.958001][    C0]  handle_fasteoi_irq+0xd4/0x260
[    5.962779][    C0]  __handle_domain_irq+0x88/0xf0
[    5.967555][    C0]  gic_handle_irq+0x9c/0x2f0
[    5.971985][    C0]  el1_irq+0xb8/0x140
[    5.975807][    C0]  __setup_irq+0x3dc/0x7cc
[    5.980064][    C0]  request_threaded_irq+0xf4/0x1b4
[    5.985015][    C0]  devm_request_threaded_irq+0x80/0x100
[    5.990400][    C0]  dwc2_driver_probe+0x1b8/0x6b0
[    5.995178][    C0]  platform_drv_probe+0x5c/0xb0
[    5.999868][    C0]  really_probe+0xf8/0x51c
[    6.004125][    C0]  driver_probe_device+0xfc/0x170
[    6.008989][    C0]  device_driver_attach+0xc8/0xd0
[    6.013853][    C0]  __driver_attach+0xe8/0x1b0
[    6.018369][    C0]  bus_for_each_dev+0x7c/0xdc
[    6.022886][    C0]  driver_attach+0x2c/0x3c
[    6.027143][    C0]  bus_add_driver+0xdc/0x240
[    6.031573][    C0]  driver_register+0x80/0x13c
[    6.036090][    C0]  __platform_driver_register+0x50/0x5c
[    6.041476][    C0]  dwc2_platform_driver_init+0x24/0x30
[    6.046774][    C0]  do_one_initcall+0x50/0x25c
[    6.051291][    C0]  do_initcall_level+0xe4/0xfc
[    6.055894][    C0]  do_initcalls+0x80/0xa4
[    6.060064][    C0]  kernel_init_freeable+0x198/0x240
[    6.065102][    C0]  kernel_init+0x1c/0x12c

Signed-off-by: Shawn Shao <shawn.shao@jaguarmicro.com>
---
 drivers/usb/dwc2/platform.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 7b84416dfc2b..c1b7209b9483 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -469,18 +469,6 @@ static int dwc2_driver_probe(struct platform_device *dev)
 
 	spin_lock_init(&hsotg->lock);
 
-	hsotg->irq = platform_get_irq(dev, 0);
-	if (hsotg->irq < 0)
-		return hsotg->irq;
-
-	dev_dbg(hsotg->dev, "registering common handler for irq%d\n",
-		hsotg->irq);
-	retval = devm_request_irq(hsotg->dev, hsotg->irq,
-				  dwc2_handle_common_intr, IRQF_SHARED,
-				  dev_name(hsotg->dev), hsotg);
-	if (retval)
-		return retval;
-
 	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
 	if (IS_ERR(hsotg->vbus_supply)) {
 		retval = PTR_ERR(hsotg->vbus_supply);
@@ -524,6 +512,20 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	if (retval)
 		goto error;
 
+	hsotg->irq = platform_get_irq(dev, 0);
+	if (hsotg->irq < 0) {
+		retval = hsotg->irq;
+		goto error;
+	}
+
+	dev_dbg(hsotg->dev, "registering common handler for irq%d\n",
+		hsotg->irq);
+	retval = devm_request_irq(hsotg->dev, hsotg->irq,
+				  dwc2_handle_common_intr, IRQF_SHARED,
+				  dev_name(hsotg->dev), hsotg);
+	if (retval)
+		goto error;
+
 	/*
 	 * For OTG cores, set the force mode bits to reflect the value
 	 * of dr_mode. Force mode bits should not be touched at any
-- 
2.34.1


