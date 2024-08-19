Return-Path: <linux-kernel+bounces-291534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D99563C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4E22820DD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2330F14B97D;
	Mon, 19 Aug 2024 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HX9ZNnMV"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95BDDDC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 06:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724049166; cv=fail; b=LEz5jqcgbebJS6gc68gcTkRZv9OxZSWRmYCXB6fprEdLQtb5sMZo1OnUSbTyQF4ksEpChYVd8xDkafmnY8TpohvWspIAPYIn4HBlYJMNogaSoG+LkCK86Une13fLnVrbhSg529XA7lmrEPIexq3wzVgMdgG341L1tavQID4od18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724049166; c=relaxed/simple;
	bh=35oUp6WWRY2FnmgRy0xRDw1JVymr+G3U/aQO9vcQJz8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=clNRPnL6BHQpgAK1Pbb1bSFRjqbIFcBG7/SSGjcp1i+e/Nus3qOryzjqrQ0+9nsYP1KzJ2BRndEHPzyHI0kA0pnGANUiWlYwzy7EOQcz6dSnTbEXbjqZas4s12mCg8r0IGxbMWaJ+CM8Fwpdeu6CLfgN6rrIxPEi+GXf/mM8u7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HX9ZNnMV; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9nXUGIP6mcdxtKqSphPiLWCN3htM6ODRZl3EQRnwROY/MxRbKPDHJUpxtfV04NR7JbBtrDbFQt4hq1vHLVP/wJtGxeVy9ZPQ6s8sincv/xGPBAU2zyftMMnb5vN8oSTF4FcDDjWfQM70cgR8LzcCnFLb95fA0PxHywffxO9luHcCsEDd1hCSDuJwJJECJka3s1IOZIlinNK/O8gZoH/U7GcK7Q6MBJ+AaQkQ6qPwcXcmH8li9nc/+xPqUE8uG6AXzuPxeSjJD6bMkkN9WSjVRSYN0H6GElr6CrDUof1nv43Z8HhUeex7S6RIIwr74MuY0rodroTgo5iuJqSoB/Q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or3kB1tWkVwZQ5GufLHz+QJEZn862jt0O1AwKTJPD1I=;
 b=NPFsnMx2e7J/XMX0w5qpDn4taQ1KyKzinBR4x2qZVnqdirS0aG5XrUbzyXRC9hQa2XwMNJTY5Hw0lgQGPD/1/fGSnQIIaRVmV6TbY3Q83M9dWCMtmjjoZSO6DvAhqHrVqUXwTHpVVOkCPfvrqpnQ7RQ3rfP27tfYqDHACtbjLARGg8kqac7W682DjlV4na5bm8hYWKGZwCi7EBaLdxLJw4Gc78B8WETgilg/6aiKaiK9nE5JR8fkQ12oCzY21BUxW//swfqynx1sjLDPX6NCUlci+N93y8wjPHUVhnyrcMj1CSL+T2mOBMOeZgn599o+P/6TvEtcjcuoPo3MTZBUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or3kB1tWkVwZQ5GufLHz+QJEZn862jt0O1AwKTJPD1I=;
 b=HX9ZNnMVUByeFBPa61DQT5fVam6B3QlcQrVhU3LkBKrZMhc5n6W8JvhY02/19i/9kUM+Iu78SKYZjw48LL+6OP0+YH2D5xOcKFJtlBspX2Zz2jhOuxXo1xXt7UmmYtmRPahI4XI7b8ag6FDflGqVzM+G5DeFkbgX6NA+ldy3uS4ajqUTmeloHwhv3aIiJneuRri3f6Rs3/os2GdPQsPt8IFxmQOqkp8U7bDjTm8gNMxu3arGhNegoQ1Vrrazs3V6c7FdlzLVoUk3dvzAW8ciGRYQ95wg81I5bO3xuJvpLqdiDSYf8dCZ9MfGaEGKPVPljw+9ECUOXHUPHL1YPFdpQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 06:32:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 06:32:39 +0000
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
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-mm@kvack.org (open list:SLAB ALLOCATOR),
	linux-kernel@vger.kernel.org (open list)
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [RFC] mm, slub: avoid zeroing kmalloc redzone
Date: Mon, 19 Aug 2024 14:41:14 +0800
Message-Id: <20240819064115.385086-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaf178b-7633-486b-8557-08dcc018b873
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ix1brfipdgJp/qebgx/whsFjvGgu/95QkcOMO1Y+tCL35oDe0jDCfIaJ0ZK?=
 =?us-ascii?Q?Gm6lipT0EYsNBZhPIH4hrwgcEhpgiaxGJEWdRJyp9Fr7Za25kCBup82HOPXz?=
 =?us-ascii?Q?igow+bmfdgsDYQp6+7XcNk6d2RIDd6VTolydHmEFH31zI6lsFVlAZTGmCYUc?=
 =?us-ascii?Q?7Rqr/+0X4tIEbLTIbR5ie9y2VHVB1WQfE842DugDn0Wo0eLQeB1IVg/CvV+j?=
 =?us-ascii?Q?qA6vHbEOPTa0qMMauad06O2ybpvFTZxtI6Dm7axiA3SguxBXlZZu4/JRvKH2?=
 =?us-ascii?Q?1hZbMFwb1SrAq3etEHdmQa4hrPksa1zncPkIlpHiz1IDdjbqkhhRZkYgXnUU?=
 =?us-ascii?Q?ulZjplyWo20JwwIJmM7Q0edOeit5UT7KDRntGC6Yu0QBJl8obGJUlLUyGfxi?=
 =?us-ascii?Q?9gOrkvAjToicv1LSRNQ9GFxX8xX4yKWnUXnFWrHP+g1xEBh/KdkS4JvYoZlF?=
 =?us-ascii?Q?WhjYSSLPeaGjIU+SWq3ckuFnGohj3405TOMx3Pw4f5MU3YMVMQHMV5Vl+9ZM?=
 =?us-ascii?Q?6d+2Cf04UoIfuGxeWHkFg9/hmAupVShYkLO6AdZeNexcR1ePcBO2fALeDrdE?=
 =?us-ascii?Q?H7YL3Ba3zEkAUheIZwYdbh0Tupbwfn6VC811G+s3VhnnYwVtAm05DunUMvjT?=
 =?us-ascii?Q?kI/QGjrFqLP4/56tQdnAzZhhrsZp79fehTSJQ/6tZuNbO+WcXdvSjgYyjM5F?=
 =?us-ascii?Q?f6fFVzFA7Eo+kLjFqPTuVJVwWWg6FD0gvqTrbg0x67KMsAXWboj1mkmX9VnD?=
 =?us-ascii?Q?Jea8mk/5/cLBRtd/xbtahDJUGpFojD16dP4IiIPemVU2dPXfjiNUypVJKw9S?=
 =?us-ascii?Q?oXvxrnASZx1F71uY9I/oaBEGClc84urvYqsWd9wJuYVsuAjkM4xjbhTCVZt/?=
 =?us-ascii?Q?P4TMES32Yj3KXVwCBfT3ZfXRzbawcQRQX8zKJDOjoSwiZpRajYDAe351UlCa?=
 =?us-ascii?Q?9XwYG4HCC7MFcMkc+F81TCdJpvBPG2C63STgrRTpOJhfH5cs++oGDqiwl5tk?=
 =?us-ascii?Q?i6LA7CzHg6d2y9/c53pwKR9YLIDtXA9yFGNyuEt+D3pOTdOpP99nyNFw+Kc0?=
 =?us-ascii?Q?iiMVfq6BVBkv9LaM0o0lTM5XKoWQmdRIL27lT9xyYaYgpjSxgNk4Dk6KBn31?=
 =?us-ascii?Q?s+2LYt+pQ1ocH2daplFV1FSHMfiLoj6r+k3cUx5DB1ay5NRMB87DQNaEbWRP?=
 =?us-ascii?Q?4jX73nh3PnTu5c4jR71qQFiSmc7QhS8IMLPU5QqVpZYs9/3MZ66WhoyiDmbR?=
 =?us-ascii?Q?tStvXz3RBQYF1cID+v4Ywbu04yLS2F/HVzFxw1c0LnOpAQjIjgEBAV4Cx3Bn?=
 =?us-ascii?Q?mI9edLnNa9tcXu9DkkFbpxAxCCKjiOZ6M+49cNWkkbe1kM75qXaXF85sxCSD?=
 =?us-ascii?Q?UYZUtElc8VokgYRJeJtRhFQKxC5uFuOxhXgEhpStXW/QpZgCdC9E3vjsnUad?=
 =?us-ascii?Q?htiTF0oDnEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qOmc8I4YfLPPbuDLQB4+eFFf5TdDhz1yKttYh+DlQx19MiMfmbpTSuSnqhNl?=
 =?us-ascii?Q?E7vVtZ8Ga3tFFYd2vdwEV1seuBRqWX6iRpwli87nHOUi+gpHlfjJA14qoGJf?=
 =?us-ascii?Q?EkryQ8PczWGKgKxzaPQZe2SgnJWoXjXf1tpavNMctcWLgZqPD5aebVjnfkkE?=
 =?us-ascii?Q?wK0Bif0jCXfJwbgaNc9vRJhvfCM0M5Te6A/7GJ9k3nq94hZrwsUSq03YnNLV?=
 =?us-ascii?Q?rCsIq7OxUhb8HxGuOkCLlGThtMPOVIFlF3edyLMdjefIKbfj9lR7SleFlhhe?=
 =?us-ascii?Q?IM7hkEgNavcnY4uNqO55lypYFx5uxkf3YT7q6ETP7rn0vjYV8q+DK/2zgH3n?=
 =?us-ascii?Q?E3mhMBFjIwDLwD0QDIwKvOn0iBsESqQ6NhcLckxq9dLWoDUURsP1h5ge/puX?=
 =?us-ascii?Q?B5J7PETuBRZJgKlJ9x1kzxkS/1rdRG7KZSyOqpT7Jw692XVaj5vhbaRZYmX5?=
 =?us-ascii?Q?78rtqnJ8KoVUiKNzy8xV/4PafZiEHO7sFvb/OBtEJ+Tch1TXPcrfQiWFjm+X?=
 =?us-ascii?Q?8MiuJL4+MTNdJOd42sIh2QPZC9BVRq9zlEYEVTfD7EB9iPw7a75dJKD+ugU7?=
 =?us-ascii?Q?gqH/wAzEE4tnV9HfexHaDer4Nz1e7X+rTBEzowZ1I95EM1LZct6m1z8J0ZTg?=
 =?us-ascii?Q?x293aUpGgemJ7zLLWWQQLFC4W6P0xjeJuioknxkw27i55utulIP6e2BPuo/j?=
 =?us-ascii?Q?XbNExE8Z64Oaq2Ox0L9f+ajzdM3doVfPeLZ9vIcB8AhgSAInFfPTy1Gk+kzo?=
 =?us-ascii?Q?IJypy4m3iz56QFinET/q3ybrZpc42LEypBekJgQNx2ojwPzxE502jHJyJwFT?=
 =?us-ascii?Q?j1VeqYAXY5sVlcXpC9PxCSPt39hzbG6ugxyrAfDyWQPw9dHwYuomElleKtAC?=
 =?us-ascii?Q?SQ1TcVknG2jckm6MD71gv1poDYLRbPsHSMgOzkK15rzE2+AQK5LQbYLoHch4?=
 =?us-ascii?Q?y6inMGeIwqqdN7esjkItUQo6fomhA1aj2IixY+Dzr01zQNaohk3uwE60Hji+?=
 =?us-ascii?Q?E+1RUfbZluqzwjrCbixX466LfsDegbPv90fhjHUxGvKUNFup6q7DNj6LStp2?=
 =?us-ascii?Q?zHGpVXWcR5MSgrZfRfgqJQfHo+UNtZA8rsP2aT2SzZ2KgwkkzxOPDZtnqE3i?=
 =?us-ascii?Q?YgBK3HSkJ4dA1fSg5hZc/RG7q6L7cnKdXN77ACq0gmtRIKTdcz05OoWxia68?=
 =?us-ascii?Q?SuC5ZpTP8wdg8Cv7vmog6ZX3usfO3pfxP9+UXhn3LUv8OutM4HR3Hg3iWQFZ?=
 =?us-ascii?Q?g9RWIJeyH6OTVURmIXBudFfDu3h/F5c0cTgDCCxbjlOHbBVwWrhqUwtPsRPs?=
 =?us-ascii?Q?PQJwjRNjpnbiX+5iEkdqlR9QiQRJ4RVl+7hkOgZPuDmqK9koBCIP4/zXc3q7?=
 =?us-ascii?Q?6lXBwePxPzmPjEIzu/ym44QGOIIdlR4SBoYf3tiE1+9GP7Zai/WjKALngYk8?=
 =?us-ascii?Q?Rcf0VNTSyycLjpAEswR2NPttNS1hgJgFm4xhNkQGqQbHAgfjloLGIO2784Wd?=
 =?us-ascii?Q?IH+Xd0RdkBl4PukL12qdKjG/BgqPwfQCsrwoNHk3FuEo1nfZTIEkSFOWifyU?=
 =?us-ascii?Q?MB9p8SsJvq1PH7CCqfZ8O2Amt6LqT1ekkDpdXZif?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaf178b-7633-486b-8557-08dcc018b873
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 06:32:38.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUxGQcwCxjo9l6XqmBtnRJCckEJTGMqHEVht10pViuUyDd1Mgy8KZJYvEugfhZ/j8WO0d2Ft29apL1B5t88mvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018

From: Peng Fan <peng.fan@nxp.com>

With "slub_debug=FUZ init_on_free=1 loglevel=7" set in bootargs and
CONFIG_SLAB_FREELIST_HARDENED is set. There is kernel dump:
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

It is because the kmalloc redzone area is cleared or orig_size is
cleared. When s->object_size is larger than orig_size, just clear the
orig_size area. And restore the value of orig_size.

Fixes: d57a964e09c2 ("kasan, mm: integrate slab init_on_free with HW_TAGS")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 mm/slub.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 94f5a4143825..d03957d15bbf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2282,14 +2282,22 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
 	 */
 	if (unlikely(init)) {
 		int rsize;
-		unsigned int inuse;
+		unsigned int inuse, orig_size;
 
 		inuse = get_info_end(s);
+		orig_size = get_orig_size(s, x);
 		if (!kasan_has_integrated_init())
-			memset(kasan_reset_tag(x), 0, s->object_size);
+			memset(kasan_reset_tag(x), 0,
+			       s->object_size > orig_size ? orig_size : s->object_size);
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


