Return-Path: <linux-kernel+bounces-306064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EEA9638BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825D81C21D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC9E41C62;
	Thu, 29 Aug 2024 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bA18HkAt"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105E134B1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724901648; cv=fail; b=I8BdRs9E1ytbCed0mXXjSq4rbPefBxBfsWuzb+kGht2cwIHm3BdP9mRTFtgasf1iD/DaMQUeZBx8ZC3w8HnNu52lwsj82eipkGg07QFD2VkKMs+Mr+KMc+glnMSQAssqkPBA0SWv16rFY6JE4IfN50i5fd5axkp8olRgjhXtKZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724901648; c=relaxed/simple;
	bh=Dvb//RiPfQvdQ2t5EeTFDdTNMQ7ScHPXaothhrJyBpc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k6zEf0S1C+Cd+YNyhiwAZURX+7eE4yIbysX45qRoASQbrGepwBIzn2JmvEe/dRx+9NKD9nyGg4gXsUCg8DnWx1kXazqehzTGMmoBgx3CT4PlHUPkjjq7A+Sa7wMRfGSDY/ueFraNn5EeEVdAhQXKKgCgPIwErkbwXCEWNXHuNqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bA18HkAt; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRvf+gqDWDXonogjaCAtmaxdhHoYNOMiXnSyxnBjxuXItS3j/HQB51ioAFJyE2a2WTnJPEYk8OHLf+JTJEW7o2WGBBbnyFiagMiOVU/vmdzZ1m00ZDofgnXO397RkHX6OEgcG6x1b5PJOwheJ+pqCknpeS05k37zWE2mSCl42YyYY51NLiPQ6QnSqztrs7R6mBn6UYzaktBm7gK7Vl4e3lnT+lTkstq+hM0ufIiJAJ2nt5gpbCwDa/AB6wF38CW4WpO9zVRBphyG9MY7OcsLvF0wVf7x8QfX4M5wiHBqSQo47yjvSusw8cqCgWMuwzwCxTbdUx4v53dmc8nLzIuV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNKmRDb7oPfYXiGt9ClVeyzklnTPZO4EuI7x17N4V88=;
 b=rHDKPS4lsZ/FAkPSmbglcOZzoaK1wcDtl6NWTUwu3gSsPesQf84MU+QYifUyq/bvxJlj7Ci8vTz+g5qHCcv33msObCiL1EijhmyFvXzImrIobxUojGje4zLPSpjnC4QKVSGed4WFEOW1ZuVh4r3PJqHQRJTOYZby8W+qErOXjHuQEdP0w8CQDiYyNxZwXQGK0Q+TMjhLoY8n/wSXTbzHDBKN1lxQY/xEp8COLNl3oU7W65+9sJH/Yn/WJLc6dhwAgwlLRG3V9LC56LalkmM1tyQfcyMKiwkv4mnY/KZnmsZ1LSQ85JReWYY4U4x7PZhoOd0yq41FfSSr3gGViyg66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNKmRDb7oPfYXiGt9ClVeyzklnTPZO4EuI7x17N4V88=;
 b=bA18HkAttxKV27CyIFFc5QGQYC36YNIziFO/tdxhuoSuQ1G2maX4k7WdHwGdbmDomu964N91C8XgwJlQC9tr1dRrK0Eda7RKe2pKMJw+gOKVFDTrHQbn5DEAgZdtILCpXpN1jmlCys8aSIJxhCD+ua4PGt0A2U1OxKSpFouYa75Zqa3unBbUnUquILMJO1kLcCsgyNx8pSAxjhiC2HGBWgiNzjAP/bZ1kCcdRxFTJ4DDyCNgg+Jxxj7psML+wfkX164CDVBT3KrRBF4l+NPQqX7TszcAiYHCHJYhEO1V2A//B9/f8kHEKPo4sUlTVPUVWyHJGvuSgygs+6vm6YaWeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 29 Aug
 2024 03:20:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 03:20:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Feng Tang <feng.tang@intel.com>,
	linux-mm@kvack.org (open list:SLAB ALLOCATOR),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] mm, slub: avoid zeroing kmalloc redzone
Date: Thu, 29 Aug 2024 11:29:11 +0800
Message-Id: <20240829032911.2801669-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a1eae8-712e-4f57-e0f5-08dcc7d98f34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CFZqJ4Y/PkjiALOCcyK+dyPF+9ywSshSrPpveYnx9DD2s880wIfi04BSZhs0?=
 =?us-ascii?Q?XGPi1G0JFJgeQwFBGgLx9ZI4lqw3vmTwWvCCP86CSOSh88OOGXIRrtiBRi7C?=
 =?us-ascii?Q?BMPKgbNDP7CjKL15gYEVd+HQ5VP/5oUQuySnzjUNJZKx0T/4X1VURhlfOscX?=
 =?us-ascii?Q?RjCxPa3WldzSihSJILFwFcqXmbAYmcahVXaTlv8fa0mQ2QZ158B8bLpst6c7?=
 =?us-ascii?Q?KrxScYJ4J6hQ8hqyVwdgHNjXxYIKgLCZGCkTQFc5do7uu24lPjYydXIZ3zcH?=
 =?us-ascii?Q?5VObW8waDZlxR8lFIWp3LQXG/3jyNHOoOZqs2+CeS9BJU+7NmKCOmloAy771?=
 =?us-ascii?Q?+ytZ5JqTja1OjH5HgIRTnqMQmYrdFkSgm2QfhU2CFWS8nAwfKBPB8xJo+rpq?=
 =?us-ascii?Q?uXKl6vMSNbBBIrx81GA8rvi3BHxLqGyg7vf/0DP7h1gnYLkGuDjDEvDG+XMG?=
 =?us-ascii?Q?ESQlv2ZcR4MqSlXx4XYS0hJxdrJIwBed3uNWyVNcPHK8gMiS+x7tsV7aACkr?=
 =?us-ascii?Q?tb7ND1d+coQocHg01cFBNe8fo0JbVC3mKuHz2XbLJC59pdjZ4MsQ3jZmKCoz?=
 =?us-ascii?Q?1hp3ytDuoBdmRQ9UUgUPyr+Qn+FKnVXuKCQz6BN4eIIPomX9/2ZaO7kuSaft?=
 =?us-ascii?Q?gWU+/yCBgzJp1q+QxmLsI1AiR2VC8JcXdSi48tG7vmvQMhwq6wrfbXV3Qu3g?=
 =?us-ascii?Q?Azwardznf3ywrfYauy4C3ohQ1v6/GENoOwkzV7qPMiCyBHkdES2ZXnWdCq43?=
 =?us-ascii?Q?kGx6NVAxHLEbQp4X4ziHRWhv4QkvGp3YDV85gahJTtQbOoiS9FTz4NU6gAij?=
 =?us-ascii?Q?4bKZR5FLOaJbOc30tbrK+qIh/s9c8rey9UJGLv2l0hqLEc1TpurrdDQ1b7S7?=
 =?us-ascii?Q?Ka07ExIIiiuR/f16xQStPEADkwq5qOxHF5AhX+09zMnbA0Dfxy9WnZE83wfF?=
 =?us-ascii?Q?OvofSk5Opif9fblCBVBB5F3YMEezQ80Aa8wHZJe5Zm9akTWP9OIRJL1Kk50r?=
 =?us-ascii?Q?v+IpJE9Vg0THSTRXQyG6kdr2IFrc/M8tehayNUhWFH73l+nj/2P1MkwiK+Gj?=
 =?us-ascii?Q?ylUC8CAT02y+5Jvaqt/iuvu2nxqo1mxM6/vsClYaD+MoIVmJ3jdu5pJqHX6P?=
 =?us-ascii?Q?XWGEvKs3mVAVv1/o94NaAwNJWA0AkWXbxacXxVp+6Imgog9CWbfv0Bb+fUdq?=
 =?us-ascii?Q?TuVn3b7HatH1flSkLVwQvCnjxjZs/HYcANPMsChPdjJ84IK/OTBe0yamXP6D?=
 =?us-ascii?Q?ku6bq8Y1AuoSFoW/s4v75RgzcgGK6QXXWJfzqVByRcVJnMqsJSj+X/x2LvM1?=
 =?us-ascii?Q?wfiMIm4/9P9u3JabqmCx03JHzDdkP7AM/GqF7G9jS2qcUHbYsLHTJ0G3zAHQ?=
 =?us-ascii?Q?AbUbsDfABdQeRpmeuocmCBaImZ+cNcW0qyTmP7veWhFHzKAMmXXc2KncnOGj?=
 =?us-ascii?Q?9IPsQSBqd4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ca04lx4YD88WuZwlrpevsQwT6yReJsEKYunnhNs2fMcc8AR4guEPgUYZ/r2c?=
 =?us-ascii?Q?nlxBNK3W8L/bsjSvQ1nvXkZ6SOjcBuvDFY7eblH8f1j8UMVEa3FhhcJW2GXc?=
 =?us-ascii?Q?6aGqIbJUIUBmxsK3vKV1k1wJ9SMvqXt9rfHrRJENOXxadbG/5ntVIrVncqt6?=
 =?us-ascii?Q?Je3ZUchfSOodXAVdA+9kkWMDLY3/h+Jnajq95uYNAuULv85TcQW3a39hd2N0?=
 =?us-ascii?Q?gDcRni00zb+SjIao8svnUJ/lqSsPLVOvMObJJiRLKp60cIIKMI9heEVvAlma?=
 =?us-ascii?Q?TIuO7cUS9n1g46p6AnJwj6tbyS2y0OcRpMtmDeX+Ao4eIUktu0QS4SX3y/Lf?=
 =?us-ascii?Q?wJYwjU1xvH0pWyewWC8klm9pg7+5NIZ1+Xn1WePoraYzPLDp69sBtXQpi2JI?=
 =?us-ascii?Q?1Rb0hk3J+FDhruN8+pThbA780+z+eGNwmIqVWHjBGkaHu/tD1LRhQenYxNF1?=
 =?us-ascii?Q?84xyMDbzws66wXcd6Mh+naDwdYxaF+TAVT/T4oi13QLfDhvaMgLrexSeTJrZ?=
 =?us-ascii?Q?XWHPrEq73l5gTnz2CsDsLgaGzSWMsWx9yr3AFw/+89dA1r1I7u/J2i/5JW8T?=
 =?us-ascii?Q?MscVSLYoIxLGVGOQqWBXD3XOMyflLwU4TEJTZBvHvC3ekDORK8XzGiguAgU2?=
 =?us-ascii?Q?QRLvCv42PRKMEZFqmbKdqvVZrjX/VSUN8laW7ZjhfQgfmqmvNIg4P7ajyUMa?=
 =?us-ascii?Q?zvfspzE19pmMqMNrjpYlM0JA8+OxknQW3ZxIRP3ADgp58Vv8Ms5ZmyPdlXLX?=
 =?us-ascii?Q?7Le1/BjOwdQkmifrE1zcpi5Yd9sOowHfscXk7kIwaWLYzEXXPcpaBspUoDn1?=
 =?us-ascii?Q?RWH4q/KnsJW5PfNsiATijlEhjWC44IFHPj3qV32AYCrbmmRHxdPiR6VsEGys?=
 =?us-ascii?Q?bCpD02aQyJk235Ndx2RaluGMOoAHDcmmZHH/Aa8l+fUdZ7V86aSh2Fnogam+?=
 =?us-ascii?Q?kcmk6bAdAcG8WEVM9w8H9MV0t6d+rFi39hi7KK2iI33Fk0u0eTGM/6EGDAk7?=
 =?us-ascii?Q?KIe7+N8NyJni0p2SYntEsZ0RAW7OvuK400cIf+Dp1DDz6G12w+cb85k8W+kU?=
 =?us-ascii?Q?nzALnsoGE01YYK+KGteLfYh7jz1m4S9L4ew2J8IK6CHQVsbS4CN1cr4dBMHZ?=
 =?us-ascii?Q?No0pMsKgaZg7IUgtlXeuXAKh0qYhNpEJuzEr2yS1SgAaFgwBcZfQ4Xl1A7BK?=
 =?us-ascii?Q?qEwcEY8ZapebCoMDyOqPYtHBhq00zw33up4EHGyexVpwmYnwKNScWDfOl7r3?=
 =?us-ascii?Q?tqDiCABKGVZDnFzI1gGl3FbPbDM6Nf5thGqorXUKrQNc6cC7XZ/KsyK+KpWx?=
 =?us-ascii?Q?cdih+ZYnJyMuGNEDL4hPeMH7fVKjwT0I30GL8nWjn28mlK5nS98JHDSndUkR?=
 =?us-ascii?Q?HaKvtcEemThzxh20MO/AUyG+0HnKiR1OqSsFjNgeNdCPw3p128LgszVqdGyH?=
 =?us-ascii?Q?A42AaIxOyjLemaFF1WO4FmbDk6gh7lzw+qIeW3yz8BANMyyXyfapJMnWK2A5?=
 =?us-ascii?Q?g9VFNB38rMxIw1bmmaYIE4db+Uznvx+zkAHvlJdi73hqHX+QKxnowlwPhu9a?=
 =?us-ascii?Q?k878QHgsQU6JPnCPGX8k4k0opxVMDi35r1RzmMpo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a1eae8-712e-4f57-e0f5-08dcc7d98f34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 03:20:40.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPfO83ElTBB+KAU4IMHCNt/BJyF53xQ0fYR74brr3xkl+mKo4TJGtWbbcYKdMgVn99gN+ITGMCUAvyOEstPTAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223

From: Peng Fan <peng.fan@nxp.com>

Since commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra
allocated kmalloc space than requested"), setting orig_size treats
the wasted space (object_size - orig_size) as a redzone. However with
init_on_free=1 we clear the full object->size, including the redzone.

Additionally we clear the object metadata, including the stored orig_size,
making it zero, which makes check_object() treat the whole object as a
redzone.

These issues lead to the following BUG report with "slub_debug=FUZ
init_on_free=1":

[    0.000000] =============================================================================
[    0.000000] BUG kmalloc-8 (Not tainted): kmalloc Redzone overwritten
[    0.000000] -----------------------------------------------------------------------------
[    0.000000]
[    0.000000] 0xffff000010032858-0xffff00001003285f @offset=2136. First byte 0x0 instead of 0xcc
[    0.000000] FIX kmalloc-8: Restoring kmalloc Redzone 0xffff000010032858-0xffff00001003285f=0xcc
[    0.000000] Slab 0xfffffdffc0400c80 objects=36 used=23 fp=0xffff000010032a18 flags=0x3fffe0000000200(workingset|node=0|zone=0|lastcpupid=0x1ffff)
[    0.000000] Object 0xffff000010032858 @offset=2136 fp=0xffff0000100328c8
[    0.000000]
[    0.000000] Redzone  ffff000010032850: cc cc cc cc cc cc cc cc                          ........
[    0.000000] Object   ffff000010032858: cc cc cc cc cc cc cc cc                          ........
[    0.000000] Redzone  ffff000010032860: cc cc cc cc cc cc cc cc                          ........
[    0.000000] Padding  ffff0000100328b4: 00 00 00 00 00 00 00 00 00 00 00 00              ............
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc3-next-20240814-00004-g61844c55c3f4 #144
[    0.000000] Hardware name: NXP i.MX95 19X19 board (DT)
[    0.000000] Call trace:
[    0.000000]  dump_backtrace+0x90/0xe8
[    0.000000]  show_stack+0x18/0x24
[    0.000000]  dump_stack_lvl+0x74/0x8c
[    0.000000]  dump_stack+0x18/0x24
[    0.000000]  print_trailer+0x150/0x218
[    0.000000]  check_object+0xe4/0x454
[    0.000000]  free_to_partial_list+0x2f8/0x5ec

To address the issue, use orig_size to clear the used area. And restore
the value of orig_size after clear the remaining area.

When CONFIG_SLUB_DEBUG not defined, (get_orig_size()' directly returns
s->object_size. So when using memset to init the area, the size can simply
be orig_size, as orig_size returns object_size when CONFIG_SLUB_DEBUG not
enabled. And orig_size can never be bigger than object_size.

Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")
Reviewed-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V1->V2:
 Update commit log (Per Vlastimil)
 Move get_orig_size/set_orig_size out of CONFIG_SLUB_DEBUG (Per Vlastimil and Feng)
 Add R-b from Feng
RFC->V1:
 Update commit log (Per Hyeonggon)
 Use orig_size to do memset(Per Hyeonggon)
 Add get_orig_size and set_orig_size when CONFIG_SLUB_DEBUG not enabled(kernel test robot)
 https://lore.kernel.org/all/20240819064115.385086-1-peng.fan@oss.nxp.com/

 mm/slub.c | 100 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 668ea1e998a4..d63f39a5a1f8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -756,6 +756,50 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
 	return false;
 }
 
+/*
+ * kmalloc caches has fixed sizes (mostly power of 2), and kmalloc() API
+ * family will round up the real request size to these fixed ones, so
+ * there could be an extra area than what is requested. Save the original
+ * request size in the meta data area, for better debug and sanity check.
+ */
+static inline void set_orig_size(struct kmem_cache *s,
+				void *object, unsigned int orig_size)
+{
+	void *p = kasan_reset_tag(object);
+	unsigned int kasan_meta_size;
+
+	if (!slub_debug_orig_size(s))
+		return;
+
+	/*
+	 * KASAN can save its free meta data inside of the object at offset 0.
+	 * If this meta data size is larger than 'orig_size', it will overlap
+	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
+	 * 'orig_size' to be as at least as big as KASAN's meta data.
+	 */
+	kasan_meta_size = kasan_metadata_size(s, true);
+	if (kasan_meta_size > orig_size)
+		orig_size = kasan_meta_size;
+
+	p += get_info_end(s);
+	p += sizeof(struct track) * 2;
+
+	*(unsigned int *)p = orig_size;
+}
+
+static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
+{
+	void *p = kasan_reset_tag(object);
+
+	if (!slub_debug_orig_size(s))
+		return s->object_size;
+
+	p += get_info_end(s);
+	p += sizeof(struct track) * 2;
+
+	return *(unsigned int *)p;
+}
+
 #ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
 static DEFINE_SPINLOCK(object_map_lock);
@@ -985,50 +1029,6 @@ static void print_slab_info(const struct slab *slab)
 	       &slab->__page_flags);
 }
 
-/*
- * kmalloc caches has fixed sizes (mostly power of 2), and kmalloc() API
- * family will round up the real request size to these fixed ones, so
- * there could be an extra area than what is requested. Save the original
- * request size in the meta data area, for better debug and sanity check.
- */
-static inline void set_orig_size(struct kmem_cache *s,
-				void *object, unsigned int orig_size)
-{
-	void *p = kasan_reset_tag(object);
-	unsigned int kasan_meta_size;
-
-	if (!slub_debug_orig_size(s))
-		return;
-
-	/*
-	 * KASAN can save its free meta data inside of the object at offset 0.
-	 * If this meta data size is larger than 'orig_size', it will overlap
-	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
-	 * 'orig_size' to be as at least as big as KASAN's meta data.
-	 */
-	kasan_meta_size = kasan_metadata_size(s, true);
-	if (kasan_meta_size > orig_size)
-		orig_size = kasan_meta_size;
-
-	p += get_info_end(s);
-	p += sizeof(struct track) * 2;
-
-	*(unsigned int *)p = orig_size;
-}
-
-static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
-{
-	void *p = kasan_reset_tag(object);
-
-	if (!slub_debug_orig_size(s))
-		return s->object_size;
-
-	p += get_info_end(s);
-	p += sizeof(struct track) * 2;
-
-	return *(unsigned int *)p;
-}
-
 void skip_orig_size_check(struct kmem_cache *s, const void *object)
 {
 	set_orig_size(s, (void *)object, s->object_size);
@@ -1894,7 +1894,6 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
-
 #ifndef CONFIG_SLUB_TINY
 static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 			       void **freelist, void *nextfree)
@@ -2286,14 +2285,21 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
 	 */
 	if (unlikely(init)) {
 		int rsize;
-		unsigned int inuse;
+		unsigned int inuse, orig_size;
 
 		inuse = get_info_end(s);
+		orig_size = get_orig_size(s, x);
 		if (!kasan_has_integrated_init())
-			memset(kasan_reset_tag(x), 0, s->object_size);
+			memset(kasan_reset_tag(x), 0, orig_size);
 		rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad : 0;
 		memset((char *)kasan_reset_tag(x) + inuse, 0,
 		       s->size - inuse - rsize);
+		/*
+		 * Restore orig_size, otherwize kmalloc redzone overwritten
+		 * would be reported
+		 */
+		set_orig_size(s, x, orig_size);
+
 	}
 	/* KASAN might put x into memory quarantine, delaying its reuse. */
 	return !kasan_slab_free(s, x, init, still_accessible);
-- 
2.37.1


