Return-Path: <linux-kernel+bounces-298290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA8395C545
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04F41C21D14
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4EC5381E;
	Fri, 23 Aug 2024 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uQTSByCU"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F514A08
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724393741; cv=fail; b=Umof0rh1yFBfTxBQqPYq29J9j/efFzEs15E4BCma+MKgk+Sv/h1lqAQMWa4DBrSoz65AugcpMM1aQiASTJ6qv87aZAg0E/jQAT3qxiudGjnoUPyOM0YhH8h0DcTEACQxMhEgNNDNzRwF/KMu8PL+6I35ls9EelCO9MzKAXbtTrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724393741; c=relaxed/simple;
	bh=fVxb0JlG65Im8etrws1aAnsq+U5lr4F4ylZt7smcS/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kEhEqhTzQOhJNsK77qtAA4LDHyNnX85qI9a9WIlXMBJ3+vA97nFdvE9R1bPkG5J/KHQM4HZZ5bcP/BDvKOtFIkC1ahi5Rnkm7nLbDgdWWHq/1jJOq0+BPXYdzKPBQq7o/6pj6Z4XgipHCHsgd6JbR9yM/km7uHuD0kEUDTh9UrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uQTSByCU; arc=fail smtp.client-ip=40.107.105.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCTDQOlGIwt8ISZf1y12M2CPTtMYeHUflxFcXkgFEYlSHMyxczwHH76VOjC5w1CfoFRGP1uUQWQhm08IqGQTccoBovVRI+9xX/tEs50JZoUPpb1QTfirVxK+ajFVdHy0fN/PWMaYGNlxI+CEqg66cdBlQum7Jw31TALRuSeSecK7fVt39OZRQviaEdSihS8J0Y/RpW8io4BncLPTF0u9y0K8kH/N9mPTLUvDUXkftMvp+0NqQHRrn4xZgNjcT9kEfln2R/79PklBtM/8bj9CTW9VNSslgV9ylMCorIFytbifDTVfOqkb9cUQgdgeMxlz3tWaJ24ldsiw151LynEWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwPworFSrTxprqkjrTZuERbwpCCyRNtbk54DCKDLpcs=;
 b=kNaEJi2y9cvTimW7/HkFadTMltS0f7oljooII2Sa0f62r+/LXbfdBl7ey9kbzrtog/MvP7MpMS5CPqkFz+KZTbMFb5g0Pd/f4At1sHtYh9MdlC6+ugW6PI+RMcXH4ZXFWxx+0XFzlPLgsayt0AFp5MVn2tnmmDDqEXwSLQu9Adp3YjPhJP7hbgdpdwtYSDvWVsxTVNX95m2TzKMan5YQtQ+N2RAwCPPVqT54kqgOMj1gTuTOOVFGqDQo0db3t2iDi+dhXAF36hfl3mWWuWnjIGyI7Bd030bYxuWpsBlwAoupc4uBFI4P4NBPb011mFvDeMiWwOQzr1WMsvKV+51wnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwPworFSrTxprqkjrTZuERbwpCCyRNtbk54DCKDLpcs=;
 b=uQTSByCU264MQPA6sMNM8A+tJ/eNc2NssTAqKTfKBHFn27i1/ZLjEmLyujJ4vkakoZG8b0mghVTk0JVk0GAcYkMx1VK/FH6OvgDY4zjdGlWEEYycJWHWaUHGKpHuacxQrtUKr5pSguLwQ51cqOX53VLUtGEBqusifs3W6NsFEDhfueql1CPrveiLUTJdj5Y2I/rdIXqDoe2T8xq57BsGkD5Xxo88J9srJ6FU1GbC/Bz/vwrrJhkYu8o0eg/4RAeWsoCwzNrfrQck9KFhRXnV9GV4ecv8Zx1Kjp59x7LRKlao1SyEALA0Lo4UoFsFEHdksqDEz17BuL9NuK+0okZYMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 06:15:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 06:15:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: nicolas.bouchinet@clip-os.org,
	chengming.zhou@linux.dev,
	vbabka@suse.cz,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Feng Tang <feng.tang@intel.com>,
	linux-mm@kvack.org (open list:SLAB ALLOCATOR),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V1] mm, slub: avoid zeroing kmalloc redzone
Date: Fri, 23 Aug 2024 14:24:15 +0800
Message-Id: <20240823062415.3632189-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ae3e7d-5d85-46f6-d089-08dcc33affca
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vIV3YMpXJOSSZxSmmF6FlpakCOmSG3SZEM5xeBapIxUzU7+IdjiseTRNu5ym?=
 =?us-ascii?Q?qhio026Y7tsZliYveRaF+YSHtvbxdxGVO+frlZmhxNfibtBzN9OCe8tCxqhe?=
 =?us-ascii?Q?koiHAXtPiPPSzR36YH2tK2QqcpQUYZKSqAZVxy0sSE7xfw3JDBwc4FlBL9+9?=
 =?us-ascii?Q?5Gs4REJr2nzikRVmyZhtWy3KiZFjttlIIA5GlZ5K26KZDyLvTdCSaUrxpE0c?=
 =?us-ascii?Q?OMeVOubkfyByeEkMiFZux9CqFtZ7PQzeTl3w87qcsI8xjt57Iv31TlxbWley?=
 =?us-ascii?Q?K4cIvym2H0R85kbgXuDKc8raKkP7RpQb8gHxqm61eccAgGC6r0EV9qBwb+Dl?=
 =?us-ascii?Q?h/O8spe8Itf2TF6Q+7JWm89IkE0yOjFAMuYGKKyJstLu49eUqhFdjnnTH8n1?=
 =?us-ascii?Q?62s3B+AEzyS1TLs6OYzY1uS4ZXd7YX0nH/UJA6gKbnbwTkSChsh8sIVPEV0R?=
 =?us-ascii?Q?ltYMfjqRej+hprW/MU3QX9pn0g0/8YfyXI5r/nsC5oYIvq8VrGKiRFwHT7f7?=
 =?us-ascii?Q?pBcXxoY4yVIM4qBsFAlDNrgcHn9PeWpect1vMhyoH+ntk6R9gBmoh+K5UMgz?=
 =?us-ascii?Q?vyk6vEa2zqXT/0/dREX6ezqurfs4DGiwXXZU9zniZWwgrQiQIM7vMxbgZco4?=
 =?us-ascii?Q?5vLxrjnAIUfXi0CSkhjn7iLTiD8V+UvXNzunBn1IbJ2n3irCIXoxN3x0AAgL?=
 =?us-ascii?Q?tJekcjYA2HB7+2lN/ckC39Q/+iNoea2P4Jk4PkIy5U2/bWIEFiyt+c980lKT?=
 =?us-ascii?Q?mXwfQ5+rhry9AVbSacwv13yRBQv3YrHz/ZoB45PzY4gRDVP0iCVfZ1c3rPxf?=
 =?us-ascii?Q?3J0ZvErOBlFMyXaV2XEy6VQw7WX1luCS34YvCttjkSTM1NOpedIIHE9clSbm?=
 =?us-ascii?Q?fGe5ZSpkEPHgPE69VfH4cVR2RNDjl+ta5cBZkvbtf04GGvLDo07PKPNhnb2q?=
 =?us-ascii?Q?XrjpLPCQWR4ZhwxdISkNBDvLRL1rvy+FNvh7IIrUIMG1jVveTApie0OT77GJ?=
 =?us-ascii?Q?5tY557eNlJlZFSQl78pGrCZ0bS+V0NM2XMzrzXs1QzTtwELo3sbQ627MCSKb?=
 =?us-ascii?Q?boOa8U/C3VzUJp0uchGUgHonz17a9dJy/QuXerBgPS93Lqmp3S9rOqpCLAWs?=
 =?us-ascii?Q?JNmPATmRRbkTwZrecqtmcC2lV4ygZgPWyQTL+GWWGY4KchntGK7g1awbdlZM?=
 =?us-ascii?Q?kFWpN0xl/bC9Q8ybWwQ1kHzf/3Icejkw2ZRY7TvdD7zHYX73bKYexwQnN9ln?=
 =?us-ascii?Q?gOKH2OGUx/NAf/hSWoHsWqEUvBf4MqYVADg+g0gtituKG1Sw4Yo/hZdy/3g5?=
 =?us-ascii?Q?ASEJ5OD/qlkgddhWSwiYFkeGatycpK3uDjbUWbd97qWlC7b1ibINJm9WqyfI?=
 =?us-ascii?Q?/BGnFRpoeFIChGu8pL+LMaNO3Qwj6/EnGHO+xMh/3bclj6oSDDiLRzfSKDVK?=
 =?us-ascii?Q?RBdeddt//XA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V1kGHmor+wQyLlHQHcAjwg+5it9qoIjpd/nmBQDXpJOTImtjzhFJpCvQVnw/?=
 =?us-ascii?Q?M3QXaBUGNBVajMhUmWfEPCe+eXttGXCM/+FphdBuYb5+gpX5f6a7zyRvIXuW?=
 =?us-ascii?Q?Tf9OqCqBBhZ6fb91Alv9u8aAHTe00DGoy7adl9Y+nNU/5temY0ULxazsiLXg?=
 =?us-ascii?Q?7Fa0F3dj5k3ITdcLvfLSqT7gisCdfvI+OQsp1L3JblX+2CHLiyOoZ9ciRUkw?=
 =?us-ascii?Q?QIMrrziAc5y1aGemtDoe+PbIycRsxFQbUt4hALpntgOP18j5Ixx+Fnh1lH4y?=
 =?us-ascii?Q?s5aTStT+2wt1LOlB/gM99H2EtBsIncskKiUfFQH+NZIRMHxjg9FQmC9rCDlm?=
 =?us-ascii?Q?k12NEBZYYlW07Sgrx4posHZ20NZzvOtViPdqoTLPTbK4yC1Wqq0TclaJzY+R?=
 =?us-ascii?Q?LnVnc1xZk0uq99PfkE4QIPdJ9YTjT0DXhrjN/gBod7lcnU4PXH0jm34WuDrg?=
 =?us-ascii?Q?nheBU+Ctf9ej5sabo1AVvDm6gdt/vEHlLMJQr8uhRtgRtB7Hvuo0vs2PfLiu?=
 =?us-ascii?Q?MNnOYrlu5MHlJaWaomCNYJkVqTEspWNIjY1PYq7GfwA5G8onYn2bQU8i6Y3K?=
 =?us-ascii?Q?TApN+aSSFmQwf3WLoAF0T3KL9Xs/sAryxqgbFnYvjWW5rN8DUv/laYc6fZor?=
 =?us-ascii?Q?LrPt8z9SUW40bPcLTfQGlGsq3zjqBwg35ODjgXoAWsu1JWRLrLMCIVaHAC3l?=
 =?us-ascii?Q?tESv1+nCtXTTHk/oOTvqIBD1TqcXc37Uio6DsvQLzhx/a6G7Oaq6CRZmKRhP?=
 =?us-ascii?Q?VvpRjwuzBlZbErjrQ4AsrekFBtBxsvu+bGyhTChMW/+88zqZeZLOSaiyZ130?=
 =?us-ascii?Q?ebRKlfawY0L19cUtGj2zLWE5ODhAPw1CVVvnWOuyAPBdbzV6rTjI78jeHF/5?=
 =?us-ascii?Q?Z8wEbDasFP/Sd0CItvFA9LJ1/rDflVLi9OF/UmIpcxOUKOXS6eKd15qmSz2D?=
 =?us-ascii?Q?LwaY5oWYS1Xh+gLk4AEaVFMNA7RzU9i2UIYdoO43h98mcwIHq1nWL7yWH05X?=
 =?us-ascii?Q?XWzhwZZwl0jOdrs5yYcLljW5q4GDsnHEAANYWQrKLX4F/jcZSoRHH60Le4P2?=
 =?us-ascii?Q?liuBmyGExsZnK6lneSVInnDg9PX7kMV8HMTicfjJZ0gHIElHx8MWt8Aw8+0r?=
 =?us-ascii?Q?Z2oEEaohL6WZ7UEVTQKDtFT4XB5ZAEaxRlWawNDPrywKn8Mlzrfu+qwnuc+o?=
 =?us-ascii?Q?oyRIHQooyvF+R9T+Mdnr/Z+gcSFRU9YeYh6pouk4wY71n3RV4aEL0gZ1wiHr?=
 =?us-ascii?Q?kh5xex4PZx7sDBQOx1D5NGw2OQbRsjZsSvdsXPLor+vA1zzr0ed6xmdBxQpZ?=
 =?us-ascii?Q?S6iJiiNNDrZ3Iayfk7qk/jALvP5Z9A1fydP6FPwESfTJhiYaKoXF6KiswkpH?=
 =?us-ascii?Q?qBd0hhGS0AMT1MERpxFiNrqK2zlMGaiq5aEJck+8wPgDo40jk56PagalaB32?=
 =?us-ascii?Q?Ct3rNcMPhsKTNkUfTInyvRi0qo8i/wUYe6zDbkn+l3D+H/sCyE6ZHM46pKUk?=
 =?us-ascii?Q?3BEcojln1/CquI7VlXvIoLs3pslj37Qtm8CGk21gQgBArHUfKXwwcUgG0A06?=
 =?us-ascii?Q?r27CY8urP0nWwKKa3ccyxxRPoTbQ84ayaFGDi3/B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ae3e7d-5d85-46f6-d089-08dcc33affca
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 06:15:34.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RaDb2kIlN9HZoyOE7fqN1o099f5xsYUW4ZcbZx0G67uoLKTQ23kcUo1PnJg2hDl2hXD6YDB8GDBwVBk+98XXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

From: Peng Fan <peng.fan@nxp.com>

With commit 946fa0dbf2d8
("mm/slub: extend redzone check to extra allocated kmalloc space than requested"),
setting orig_size treats the wasted space (object_size - orig_size) as
redzones. But (in check_object()) when orig_size is set to zero, the entire
object is perceived as a redzone. To a valid allocated kmalloc space,
when init_on_free=1, the wasted space and the orig_size should
not be cleared to 0, otherwise there will be kernel dump:

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
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

RFC->V1:
 Update commit log (Per Hyeonggon)
 Use orig_size to do memset(Per Hyeonggon)
 Add get_orig_size and set_orig_size when CONFIG_SLUB_DEBUG not enabled(kernel test robot)
 https://lore.kernel.org/all/20240819064115.385086-1-peng.fan@oss.nxp.com/

 mm/slub.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 94f5a4143825..a5fbeb2835b1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1895,6 +1895,15 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node,
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
 
+static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
+{
+	return s->object_size;
+}
+
+static inline void set_orig_size(struct kmem_cache *s, void *object,
+				 unsigned int orig_size)
+{}
+
 #ifndef CONFIG_SLUB_TINY
 static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 			       void **freelist, void *nextfree)
@@ -2282,14 +2291,21 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
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


