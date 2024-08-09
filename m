Return-Path: <linux-kernel+bounces-280617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F90694CCDD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856B1B20EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C0418FDD0;
	Fri,  9 Aug 2024 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="QAhQ+TUj"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3ED1591E2;
	Fri,  9 Aug 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194209; cv=fail; b=XfRTbpFKw1XeKEv7YAfcekl4eR/RCDCywO7uzKxHs930bwPENUfb6E5t1PkRrviEYUHSwlCGxfz8d3o+CJvIYyg3/Sc0t2+Ow2FLazzu++J78oUrWxUVY7oSS5/375fnXzI2MZjlQgT+i/svRGdYgJuLuPOKo2snHKr881/4TeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194209; c=relaxed/simple;
	bh=ohEQsPLXvgsaPkDSWngMD/hEKMskOfZtT807ar5qV00=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qum1xHNYpTGJ3csPlmooLR+DovMi3+g3yGvSQ0x7WAidA4MlfqrwM//xkodGFbKZPYBmY0pZA6LT9B0sTW+2LEOlla7uyhv9gjRBXwv9eBuXta6mGIJ6rzDEn+2YvCaxqJpv0p4JfIk26pq9Hra/U6fm5UA4OfKV9z3iNgZi/FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=QAhQ+TUj; arc=fail smtp.client-ip=40.107.104.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBmErjmAOhxRTerInB/eCfBV02kfRmRZAS+jUO5ZLzlAhnVfhMMRBZwzGn58jMPRZjfuGNU10/5sBpYKDhrsXbMQQAtq4J5DZ1A3Y/IMlq8kXnOuCH3+XSQ4vdu5ST+UNVtgCz/6h9otjmZtlFlrh5g1UyInf6QfQZ+8edp5ULucVhFA8rSkZJDN/xkLsKMIC0riHrxAfeoP1Cr1GwsSprHe65/E3+499qKqJMauJHmVu51F0XaLaRh1iuS7Xy30LClCdC2WWavfb1JJnaW6ct8o6hBSvrFXjHzyMTVhieOJLXmyyzCKEVksThw7FxI2vycmWvkEl5Mvp7v0iYzejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NYIlVnP9x8qKqGiIp7Ra/Dj83Z9DOntTjUfjK83fOo=;
 b=v1ySqZdBcKMHkwdRX2DoqdcWCT+KQ2dFkliKsoUzJ+hFJtvSk2FlHKFpHwSW46AAfUcCw8gVg6G/YEVaHro1NEN91QcPyEWcV1CqlAzmTmx7RwLwxo2DTSXX7sswhLn1mMmPaWMK/rZmVUZbxF3UJ5u1hB8oSRKgy//HuUWlQWvwI4dGgwgRyAQP5QfLOgF3dAnj9eULyPMAst5j4X/7TcDkLxRfc8WwcTZ4g9g78Aj6MFqnO6+ZPf9pIOgScKgmOKkYuV041hkK+zVFdgtkGkh1jTuVezGJnU0flQFe60Qf2X+f+cMiVV+KolztHshaBZpoi7uZUhqOCKW53Fte2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NYIlVnP9x8qKqGiIp7Ra/Dj83Z9DOntTjUfjK83fOo=;
 b=QAhQ+TUjK5zYBDVaGOqzTC3WHY3U/Q/klU5msedlX3+PXeRhqD6WgftEVz2X7FJ5Bw5EKuxWUzTri0AcKe77Mn4AMqvt4oDPxijMbZU8tHSKsOxOsQrYcCQOKKvvzIRInCHdJZpvADiJYL3GzVB+zeyWWqln39mvC/FwrfZfBY3mfSweZ/POM7LzHUY8HitYkm7nDLzU+7uEntjtp73iJk0PIXR+v0RuXuau4hJyHEE/z+fB2G1VRSSCObB2og+BXLUqDfQNc1mxWDP9dhHxE5gnFaKqLzUwbEJY/51FgzhADGmszVsg9gCczHegObHJ2vsnQh/cHp2X9Z/hmjcZXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DU0PR07MB9090.eurprd07.prod.outlook.com (2603:10a6:10:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.10; Fri, 9 Aug
 2024 09:03:23 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%5]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 09:03:23 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH v3] of/irq: Prevent device address out-of-bounds read in interrupt map walk
Date: Fri,  9 Aug 2024 11:01:59 +0200
Message-ID: <20240809090158.3267481-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::15) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DU0PR07MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 95eff27d-af9d-4c3d-8b60-08dcb8521f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3lRIx42HOydn2vHyukPxTzDMT/lHCZsir9VyOadTqH6htyfEbKs8/tVmS/SP?=
 =?us-ascii?Q?15GOSr/tBhCOluIO+GJekROsDKPBEbLQpPscZ376KxT5jmUyoX+d0Ss+DG/G?=
 =?us-ascii?Q?CIHTxCdI9Y9B7EtLyHL0ulb9/bvDhoe2d9yBx8RBHV4iQuNOTqntsDVAuCG9?=
 =?us-ascii?Q?Dafgv/m/nwsCIzhpjBJ2yfGFmCbqD6MnSlzr2utQUksgVRAh3StdXBdmLpKw?=
 =?us-ascii?Q?HfdHtK+afNLZG3DaDKmsJ6Rb7RPmtGCM7oaQo/xBfVfnHFw35hD4Bglf9Sgs?=
 =?us-ascii?Q?tPEkgXGlp0pqPWiQdvbG4CMVvcgsyPY6eD7cM+QqOnSO9pEF8Hm8pbDgbhrc?=
 =?us-ascii?Q?GuI+zmd07sO3xin9BHhXZQ/EU+gaGvn37XX4fL95zmFVa0RCAywNi7EugL2z?=
 =?us-ascii?Q?GpA2yLa+kCYYm97Jt4tBI4UZ/AAd5Nz6wiKuuW26bmvYvtnKceO8DdnlAb5Z?=
 =?us-ascii?Q?wt0Vx2Eql6gzSCCrqoNitUybOmtYYignG3gfz+qzcO+CG3oAU2GRA6RBLPYR?=
 =?us-ascii?Q?lEplD64n60zZd5l8759kYGu4CE5K7V41r00xt2v5d2sjfqz9DjxAIlEZLQ1v?=
 =?us-ascii?Q?mAQnKAE7t2mqoc/3tzV3nNR3VtlFTuLsaAoFf5o0NtFLLYEK/34OTqMZ+22p?=
 =?us-ascii?Q?9g5fm3ebn3XNxPzYGrFvGl2H5LTPBKGcRn6eclv4bRfltJ+jpEb3ofWOQJy+?=
 =?us-ascii?Q?jcFq9JFEHbFJ9fv8oRBT+NpEI2GtEqLmsfaCGZ8mMvDN3s5PHihSggEn1Vkv?=
 =?us-ascii?Q?FhZbMVFpeM6I10MgK8g8UIDrWqXTOuWSqnlsUaUWIRH35SGShQ7S/kWI2O7J?=
 =?us-ascii?Q?q5F5UmBqyjn8dPAD9XfYC1N45cz2hjqr8fmcbBs/aS5bGLPrC2Z9dw/DGuw/?=
 =?us-ascii?Q?vXZIsGfsVdqIeKOSu/0gQGtBso7+2vwIv+i2xP9Q7egcd1XYR2NjKGEDTOF1?=
 =?us-ascii?Q?I1xCtpHxSw8WGJVmnf8AUqiMGKEID7+Nbi3YX0C/yJVcRW5XV460fD4Sn0P1?=
 =?us-ascii?Q?8jR8szi5rkxqwv+/5zM8jE8Drj6Pvxtg+bpv0c8akJVSRAcgmpqRwI4ZXNEN?=
 =?us-ascii?Q?mU6Cz/6+ZJ+cypV6wNP9Cw+F7YcNOVkW0QkSsyFQz7e5vzk+zPKjjL39obbD?=
 =?us-ascii?Q?gRaR9E1wnno95gygVxbWuUb2GHUEUAWZ83MwoMd7f7k7WYSz7u7QCSOWsZLb?=
 =?us-ascii?Q?SKM46466h4bcvBJ2MuvywwlCdNK0w1kKKrLCzdXP5IEpvi0SgPSk6Vjpv0qN?=
 =?us-ascii?Q?CRvlSJdoaCtNmBHOymG8cYGHtSUg4hHt0qhlcWBOXGIFCQna2SN5j/M9Qjjj?=
 =?us-ascii?Q?zB1rNTt2gEkiNmN04IPMuCL/GbYvlh8SPfCgALzmkx+HMuCo4uY5Nqplk9nS?=
 =?us-ascii?Q?ndtgGp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sNoqDVGtRRptCbgJmlO8eJremMqGWKPg7KmBZUkTvIcwYV2Bq6u0Kxi/YfYb?=
 =?us-ascii?Q?VZhUJi4uI1pAk/mSTkD6mWKE/j7e6MlyLAEGUJ1LCH+qkEEdF4nDw4+8nk3X?=
 =?us-ascii?Q?oQBNzAD10aSQPoSKc0w7TZdnMcHvzwBSMK0zwffymAVuK5xHGIOomA/5rydN?=
 =?us-ascii?Q?Biw5tMO/TTbdEL6X3ght/A6MjWT+DyhO88zXqkj5Z9g6nCrlY8myeHWeWNQs?=
 =?us-ascii?Q?4dHEIFKC6uED+jhNDnP0nFFM2bg+HD7uqoWZBRyNounU5ND5u6oOFcLBZnRt?=
 =?us-ascii?Q?2TiUZ2mfzyQKs5py2yWuPZWe2tsuiF53SuFK/vhjoPRcqOUAy7xx3giYsorv?=
 =?us-ascii?Q?3KXwbBizSijUvyX9ormheHRDVQR/4hsfYWm8FHf9OMyWitnQ1crv7IQzHUZs?=
 =?us-ascii?Q?GmdO295FUI5nNaEqLa+OS95hTSb/XI68XPn13GwzxIDmIsqvyQWETCUo9b2N?=
 =?us-ascii?Q?Py3Sc1VHXFoTdQjSpVIw+VV/vWXtl8yjALgqb8vshdnbpho1cDMuhP9oD7+p?=
 =?us-ascii?Q?vm8cvzBoQixVj0gBdUFjWa17rfnhjdtrXhyILXMxDnU+68EihAxEzQPcvCFL?=
 =?us-ascii?Q?3pRVqsrpuF2MLH27mUUjZmsqP9q3ax3fF2gZjYucN98XYS0nDgo6LF9nzPET?=
 =?us-ascii?Q?OQrB2E+WXSLJStYWDuIOatwcvnJkmfQl26PGgUsgCS28ESiZUvH6FtYZx6PC?=
 =?us-ascii?Q?rxodt8WuJAOlWmG3voZNP5tO0tuAv4ZkpL+CKl8pt4+TXSD/2XeZRlLdUCwp?=
 =?us-ascii?Q?cufEYpQBgx58BRcY+sqT/hawDQ6QG86iYJbPGWieNjMATZgSiOLI+TOimjBe?=
 =?us-ascii?Q?9j3mJzrChHDIhDlAC8zwQlyzpvoNYF+JkM3VstoZnS7P6sH1t4twD52adVPR?=
 =?us-ascii?Q?UXALI3/GfPUyfqALEBasS5UvvQt8vfvSwbhsg1Hpnm6TXBNUDPhhc6nF7hej?=
 =?us-ascii?Q?v7b3cPdC7HjEHCvkc8zddvx4l0ixpt6+Ft1AOk/pYTW4WMalEL7jFIjrrM7Z?=
 =?us-ascii?Q?75QF/cW4jfsZwUJoMAF0dqlPSb03K7PRVRXF/ABxP0dWaoMuGU6a3+qTaa27?=
 =?us-ascii?Q?Pv2VdXTVjQz4X/pBFluefZuJD0JjgKKIb4HVUo1IRXgegE6ksJSwJWFJkU7X?=
 =?us-ascii?Q?vPhVXyruos8pmt2UhNrOgzeJvQlepmeqiAVCupI3goMStwtlx0iuwYXMWFaR?=
 =?us-ascii?Q?Ys+JT7d6R4TJKNCk8gp5G0x8bNvK9FFvu5+6ja4wFpEFUbWkM0Vl0MstFXCG?=
 =?us-ascii?Q?J/tOYWClzXjElUcMja6C2RoQ6zmbdldBxcWvnncdx7iH7BlOt2dNC3NRTGAt?=
 =?us-ascii?Q?ACIU/bnPT3ApvDo8+5Qo1T57he/arq+EUxfxwJoJdzqvz7pB0OuuUo7oTzgk?=
 =?us-ascii?Q?ygN7DR4nGTzAXQjK01HsYSbZe0doIZX+LzcrGqJIDx62XOX2V0IDxpYPf2+l?=
 =?us-ascii?Q?V3SZFMIXpgM07h7Rxbp4qL4+8xdZlz/ib6eEib+LLhrMya+ag/lWvaA1Uzbo?=
 =?us-ascii?Q?zPiIYUS+HCPu4HHTOGAQEcGt0xEafQ7aKsGlyY61r53CB3Qmqx+VzJ5KKohu?=
 =?us-ascii?Q?ZudvROvXQyirBuprAje25PnNAjwsG/83EbZ+Lcp6FVlt0KZTkkH1afY5hpua?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95eff27d-af9d-4c3d-8b60-08dcb8521f27
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:03:23.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFNSTcVbcoETrb/bYKK3MWOmHo3sfIO6v9hFS0Ghb2cptGm8/W7/KRvUKUINTHBrL2EL1IYLJpukecEl1BmWvt/h1wvj+eAel4d8KYpkeG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9090

When of_irq_parse_raw() is invoked with a device address smaller than
the interrupt parent node (from #address-cells property), KASAN detects
the following out-of-bounds read when populating the initial match table
(dyndbg="func of_irq_parse_* +p"):

  OF: of_irq_parse_one: dev=/soc@0/picasso/watchdog, index=0
  OF:  parent=/soc@0/pci@878000000000/gpio0@17,0, intsize=2
  OF:  intspec=4
  OF: of_irq_parse_raw: ipar=/soc@0/pci@878000000000/gpio0@17,0, size=2
  OF:  -> addrsize=3
  ==================================================================
  BUG: KASAN: slab-out-of-bounds in of_irq_parse_raw+0x2b8/0x8d0
  Read of size 4 at addr ffffff81beca5608 by task bash/764

  CPU: 1 PID: 764 Comm: bash Tainted: G           O       6.1.67-484c613561-nokia_sm_arm64 #1
  Hardware name: Unknown Unknown Product/Unknown Product, BIOS 2023.01-12.24.03-dirty 01/01/2023
  Call trace:
   dump_backtrace+0xdc/0x130
   show_stack+0x1c/0x30
   dump_stack_lvl+0x6c/0x84
   print_report+0x150/0x448
   kasan_report+0x98/0x140
   __asan_load4+0x78/0xa0
   of_irq_parse_raw+0x2b8/0x8d0
   of_irq_parse_one+0x24c/0x270
   parse_interrupts+0xc0/0x120
   of_fwnode_add_links+0x100/0x2d0
   fw_devlink_parse_fwtree+0x64/0xc0
   device_add+0xb38/0xc30
   of_device_add+0x64/0x90
   of_platform_device_create_pdata+0xd0/0x170
   of_platform_bus_create+0x244/0x600
   of_platform_notify+0x1b0/0x254
   blocking_notifier_call_chain+0x9c/0xd0
   __of_changeset_entry_notify+0x1b8/0x230
   __of_changeset_apply_notify+0x54/0xe4
   of_overlay_fdt_apply+0xc04/0xd94
   ...

  The buggy address belongs to the object at ffffff81beca5600
   which belongs to the cache kmalloc-128 of size 128
  The buggy address is located 8 bytes inside of
   128-byte region [ffffff81beca5600, ffffff81beca5680)

  The buggy address belongs to the physical page:
  page:00000000230d3d03 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1beca4
  head:00000000230d3d03 order:1 compound_mapcount:0 compound_pincount:0
  flags: 0x8000000000010200(slab|head|zone=2)
  raw: 8000000000010200 0000000000000000 dead000000000122 ffffff810000c300
  raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffffff81beca5500: 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffffff81beca5580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  >ffffff81beca5600: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                        ^
   ffffff81beca5680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffffff81beca5700: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
  ==================================================================
  OF:  -> got it !

Prevent the out-of-bounds read by copying the device address into a
buffer of sufficient size.

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 drivers/of/irq.c | 51 ++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index c94203ce65bb3..34fe0593036d8 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -151,6 +151,26 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
 	return imap;
 }
 
+static u32 of_get_address_cells(struct device_node *node)
+{
+	struct device_node *tnode, *old = NULL;
+	const __be32 *tmp;
+
+	/* Look for this #address-cells. We have to implement the old linux
+	 * trick of looking for the parent here as some device-trees rely on it
+	 */
+	old = of_node_get(node);
+	do {
+		tmp = of_get_property(old, "#address-cells", NULL);
+		tnode = of_get_parent(old);
+		of_node_put(old);
+		old = tnode;
+	} while (old && tmp == NULL);
+	of_node_put(old);
+	old = NULL;
+	return (tmp == NULL) ? 2 : be32_to_cpu(*tmp);
+}
+
 /**
  * of_irq_parse_raw - Low level interrupt tree parsing
  * @addr:	address specifier (start of "reg" property of the device) in be32 format
@@ -167,10 +187,10 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
-	struct device_node *ipar, *tnode, *old = NULL;
+	struct device_node *ipar, *tnode;
 	__be32 initial_match_array[MAX_PHANDLE_ARGS];
 	const __be32 *match_array = initial_match_array;
-	const __be32 *tmp, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
+	const __be32 dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
 	u32 intsize = 1, addrsize;
 	int i, rc = -EINVAL;
 
@@ -201,20 +221,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	if (out_irq->args_count != intsize)
 		goto fail;
 
-	/* Look for this #address-cells. We have to implement the old linux
-	 * trick of looking for the parent here as some device-trees rely on it
-	 */
-	old = of_node_get(ipar);
-	do {
-		tmp = of_get_property(old, "#address-cells", NULL);
-		tnode = of_get_parent(old);
-		of_node_put(old);
-		old = tnode;
-	} while (old && tmp == NULL);
-	of_node_put(old);
-	old = NULL;
-	addrsize = (tmp == NULL) ? 2 : be32_to_cpu(*tmp);
-
+	addrsize = of_get_address_cells(ipar);
 	pr_debug(" -> addrsize=%d\n", addrsize);
 
 	/* Range check so that the temporary buffer doesn't overflow */
@@ -343,8 +350,9 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 {
 	struct device_node *p;
 	const __be32 *addr;
-	u32 intsize;
+	u32 addrsize, intsize;
 	int i, res;
+	__be32 addr_buf[3] = { 0 };
 
 	pr_debug("of_irq_parse_one: dev=%pOF, index=%d\n", device, index);
 
@@ -354,12 +362,17 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 	/* Get the reg property (if any) */
 	addr = of_get_property(device, "reg", NULL);
+	addrsize = of_get_address_cells(device);
+
+	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
+	if (addr)
+		memcpy(addr_buf, addr, addrsize * sizeof(addrsize));
 
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
 	if (!res)
-		return of_irq_parse_raw(addr, out_irq);
+		return of_irq_parse_raw(addr_buf, out_irq);
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);
@@ -389,7 +402,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr, out_irq);
+	res = of_irq_parse_raw(addr_buf, out_irq);
  out:
 	of_node_put(p);
 	return res;
-- 
2.42.0


