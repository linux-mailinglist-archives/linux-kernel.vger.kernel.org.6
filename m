Return-Path: <linux-kernel+bounces-402876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1869C2DF0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 15:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A941F21A5D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA6E197A98;
	Sat,  9 Nov 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X3Vps4/n"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332C13DB99
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164199; cv=fail; b=l1aajjLEcLbQNX2XQKMBY3yy/6TUQr5TSQQOMBeFDPEVxH/TEy3RwYVtmTlrnd8Bue+exeOGrJ7cIr6Ae6PMLBwYsrqvhJJjxduvS9hDqKLLgvDro8luUi5qE0yU4T6YXNzRU7ub9jxgc2yOgHEo8YwFnm9e3C4HFWxJD6D+9Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164199; c=relaxed/simple;
	bh=gcdXDrO2HdUNKwyEudRV1gxa2dGQedKMg2zBUtpluVA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lOLej1qzGwkJh38NXr7teK7zA+rrzJBAp5XdpuQiM3uyjIItgJxMfYkYlx0cVQn3y7bkPg9q9fYq1YfVVgYQJwdZHbBiJDlyfMRpv84lUQeKD/PIgXZ5v4nSS2iJpQ0L9AopXbynAMCXm6u1dpxFY+cCIv7z6SRvY7PiJHLLGmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X3Vps4/n; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHu4JUKLqfdoKHYNZp4JffV4jH5+xsP7BYYh82FwlOKUoZBiM1jU8jxTf2UOqK/v/2S+IhPegXHVRrghP91qBsENmGNBnQ+EaDt0vYJ/YznD9CWp7K3mOSXNm5vmpB/eDS1bebR5/b27AqquvCVDwt/Zq62JU194RtmX/qBNF7BT8h3LZyW5NPOKsI7x5G/rFUBxFIocq8Fc8wUoavuIrt9a3i/3uwF8MPOFEAweHA9w1xZeMx22UqjoBFfI+vimPWtc5kFzhwye82bK8ze8XGFIeC0U6q0vUVBAGFUowUQ+KBCJh24hpfDXXe7NJQhF7fTXwDk8foYUX2W6EH7qBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1ucSF+4Dvm31Hstv5KqYNKQzOBhsMgK4Nrmkykn5pQ=;
 b=K4f10OK4jMMeqC23muIpL+uf073Zs/bLLt/4IAhEWWarcAcYEYZX9oCazIfBJkQFLyJACnbr6+4fgrFqrqn7WZvtdAQv5QuHomIhqxOL9eclVFEQYMrDkcIrfOvXaVJexup7cP7QUKLKMB+n/lbLPtycAlZI+8XB5PfA5M0L9Fc959KAJ3+o4S/PBzfiXwpy+30PN3jR7zJw2kNxPyTgaghnVc6G4sa9+6s/5BobbTqegqbNhY1j0HYFs7l5EdulCuXaEDUboPd7GlnIE6RTk28+Tz01s/J48Qc2VwgK53CuKc5nD6e8jagH+9/Hfgzp3gbgBvBe84yEVZJbpSu7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1ucSF+4Dvm31Hstv5KqYNKQzOBhsMgK4Nrmkykn5pQ=;
 b=X3Vps4/ntrMQX2jkgGGc0KnPM6nb/imB0lCQObnJTIz05AljguiGaxPg9S/rcu3SoWb9zX08Ok6xsUpPNMq70vLHOQEtavm0HIHmkyak6isnUGmIw/HZ/0TuB9XDD2jy+RMyiWtAabJDCx3u0FFIyglui7xmyNUvzS7guuRd7djVVqPOGIePu9ClLLqR/aI/TOJ6dvWrMwaTLzw3lQbbDaKSdDJV3dGf4rj6jlhGgfYjGR63lpbo+WIXPUNHkh8JkvClEUj+EV2L0YBSbS4Jmbab15Bkdzawm8YVow+BDWJVKkSml+GyDwjhjuOGYHt+6PXDtQCsc4BCONTJO+RwgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7132.namprd12.prod.outlook.com (2603:10b6:806:2a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Sat, 9 Nov
 2024 14:56:33 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.021; Sat, 9 Nov 2024
 14:56:32 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/topology: Correctly propagate NUMA flag to scheduling domains
Date: Sat,  9 Nov 2024 15:56:28 +0100
Message-ID: <20241109145628.112617-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: cf466d7a-a7f6-4475-9c4c-08dd00ceb320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tcFfuM815gw4WxXvnDe1ul/gtcxCcldphB3qdmryO7iZgfWADc6vre7Q0ulV?=
 =?us-ascii?Q?QLyZoLMLF2Q7Qq7qaj93o4XaZzoP3i3rVnpwRY85bmt0mBM7B5CZPsAh0fCy?=
 =?us-ascii?Q?Coj4ExoeK98+LkuwmY9y8pYTj12zWtyXEcWf73YC1IJQ0xSNB325xxvzyb9W?=
 =?us-ascii?Q?trbVgijSrA/W3+NGlW6aItHMdLHsK1GjvT4Dj2k9q0Q2RjT4Dr/jvV38sazt?=
 =?us-ascii?Q?MbW/4ZcXeZsXhX4AHNw1cjCZ8GfZoNy8VJoCCpCf73e0fO6KhQb57rJVnXPv?=
 =?us-ascii?Q?wSz/l7ksqBy+3hFlJarHF6zq/Cvh/W8s0nVHHJPI0qCH/iEz5uPIDztS6vmD?=
 =?us-ascii?Q?4Kq4FIffqXMWycgJFdpMlDXZ8vBXnmeD3cmwj8N7emCaOawzQ0HX+FNmqpAU?=
 =?us-ascii?Q?fLnGPSaLIbZ6YXk6dQ7PhbUOpWszuj2eGOnYO6HyTGV9mkVIXdW2kcMemLF9?=
 =?us-ascii?Q?ING/8ITjUktAgYKnE8JAbf0QEVCsGtFiD4x00xT7xBjzi1sBhjeWep1Qe0Zk?=
 =?us-ascii?Q?KF5YM8AHMK9l9GHJYYqexvidMDfh7vgXsiFGJVFNSAf/+8WhiIpqLiU5ZpLk?=
 =?us-ascii?Q?IHJX7QlubUkHo33ATHU8B77x+6PlUtqADN6V9ubwUVAtj6W78aICgMsuuikm?=
 =?us-ascii?Q?TPhZXjT8Flt6UtOi6JZKDSzcBNEPpsVLTw2XTuB6GKMsAOUpSQab6xu5BFH0?=
 =?us-ascii?Q?siocma9GN7TZ+NFj158kJZwxz9MQeT1Hrklb6NXAy8I69Chhr6i4M711NAFW?=
 =?us-ascii?Q?Z4wzKrA3HNlhyHI0ImA/LE80W/+SSim3/kXfMBL9SO2S8kWO9ta6Lm/lUB21?=
 =?us-ascii?Q?DfswIPdfMLhlzsAxHA3/dSbCwEfunDj+Orq9aLnYZ4c9y1+K5L24j6SjaQBB?=
 =?us-ascii?Q?kuXhPcrJ2bSlUIRP9WIC2XbdHiOjk31E78HN1iKWnW17QojV6T10BFg+B23p?=
 =?us-ascii?Q?5ryA8Ebn0t1mvc3IXLpsfObnZCvIt4v+pkfc3vn/zsypw4SuAXxuJT974CLA?=
 =?us-ascii?Q?hvADBbk5e5YhZI32g+Y373LY7UETXhjsXRwnAsQhbIfKeq60J36gn5P6uZwF?=
 =?us-ascii?Q?iUuQXp2orLXvxyWD4yWq1vymgWau4esXkbMgVs8rINavg8mDo2LRDh6qvoCO?=
 =?us-ascii?Q?BzuE+EO/Ko8wrEH72X9sRbR8ZhHOspwrJTWJ2t0cGVbYz2MCtrp9t8zeuvGo?=
 =?us-ascii?Q?wMTWAgcbMTnFSzpnrUOlTEwPIrNqh9nkPca1xmyQ/rBiJ2b9zTzAx+nQDkmY?=
 =?us-ascii?Q?qGroH/It0s9rRYi91IpqQydR9MFjPOVWYvQBQxk9oPba5qrhdSD6PB+wOjHw?=
 =?us-ascii?Q?w5yCCBmtlnSCHor7jKml4FlP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c8H+IwfgNZ4Vf4gP44U9iGzMXZF42/sjSbhqwCFnmabNJePsJvmH5Il91Qoe?=
 =?us-ascii?Q?zfgOG/P0LQYfwRH2wo3SOcywuobdJisvAFz5UAG94cRqtOTo8gVJLg60oB8z?=
 =?us-ascii?Q?5hoAnZOk0Ki/uOeDMnII5H/m3PCyFUBTBHIug6BEpjuXVFZvwxcbM5lTv1I/?=
 =?us-ascii?Q?GgoTkxL2GcdSRB4mk5OeTMqpsb8et8txkGOY/QS/iTewkkZ1j4ov3NZJYZtE?=
 =?us-ascii?Q?7RayI63y4jWIhdqLSP6pl5e2lpc5xO4STFeFK/z/+Lv4PwQfqW0TMyxOJvJB?=
 =?us-ascii?Q?B/fXGRanoqWzRGB7XX8W1QT2Zs7wngGSRIKJ3Ij+r/EUcqo++sw2IZaAuwq9?=
 =?us-ascii?Q?f7zGmgwRli2Vid4ak7uZV7s0AhMVnuGQ6D/1YrHceHzSwDNEHKsZQz1+hhrz?=
 =?us-ascii?Q?r3ehJjHHv3ObCRgxLzrmFDZhQU6hV7ct65Y9ca850bsuvMJlQUoU5X6nPqTQ?=
 =?us-ascii?Q?aS/Z12XI3lw6vvnwCayn8oEJbVWp1/F7s+q9cdCBjTxyY4f3iiTis0szpvA1?=
 =?us-ascii?Q?gwBDfhweBkxBmHpfjyxAmhuCgW/aDN6RYVQFT84kegaVCGjRbLPXhHw0tmpE?=
 =?us-ascii?Q?fzjppivBqm/Pa57VzsvhLjSmakTQHvlQmoumN4sw1udJsFleVj/Ni+K9Un5y?=
 =?us-ascii?Q?4WQKeIORg0JUVFgesTB2vX//AAEyqMCsn9JNv7E30peOcFIih3eJ6VAX90i0?=
 =?us-ascii?Q?/D/Qgf98LkR0rJa44q53Db7T4mJU7xYcOLIEh1Q8KqPFPYgK6uPQ9aH/nDsH?=
 =?us-ascii?Q?QzGSouNTcbMW2giqQDMeWANnmXJ/+YCwkAAFp+WwhUDp2Zbn0Io23/wPm3oV?=
 =?us-ascii?Q?rbiM5kIAsqPicKkNhbcDLfKyeSeyVfD4n5Qwvi5bCBBy/O2aKZTGwEDXXKtF?=
 =?us-ascii?Q?yKkawVCf8d0pBoxWkLlhHp+uXe5Pcm6ECV5eymEJ8ap2zkgNnwDDTfNFPaaA?=
 =?us-ascii?Q?RmXTB3qh9ZRW3tHMy+B3WZs03lZMF87WiXDlbXD/bI1fsAOEK3CANyEmLuYh?=
 =?us-ascii?Q?uMFxL8YpgmpNr9gZjFg7N4i9XuYDN9U8Y20C7kQXuAXvIy3vFhDydhqLBXOd?=
 =?us-ascii?Q?cxMlk/MaJlVqg1fMZfKshOniAFik5OQT+4WTyypvUONSsf00cmV3wbVZ2jkq?=
 =?us-ascii?Q?LeujSN6TTHDFzfwiHOEi8RD5LSeC01SVsHyAgQ4cOh8eCte4UcVdTDvgPzTT?=
 =?us-ascii?Q?knZFXAFhuYJlwDuOA93cZ2fELoFDfUIMXtlJMZ1H5MQx6nU/momvM3MdK+qO?=
 =?us-ascii?Q?pcrQRaiX9+yKfUI0LzCOrjBeZNLsGWOZljP0OxK7y846up656eMyZZo12Syt?=
 =?us-ascii?Q?8iq+OZnevQs/EQgW9ghzrirTojxW/nVgCCDvPQk03liHGvZEoWvJzAPoPN/h?=
 =?us-ascii?Q?KjdnJnSM2eOAsH++HjV+8RGgb9RvhGAjofBwE6B5BbvCF1UMjMgeF8SZhJLd?=
 =?us-ascii?Q?FlkWD3EuF5RW4JpiyUiLQbRbgw21QCbPBpdUBJfpobrdjdtlKygAw+gVGAdv?=
 =?us-ascii?Q?9LrJnoKaa5sz8Ar4ELRqz2zf19hngeA2zsEoEzIwssSgggxyMqG+tyk5YIk6?=
 =?us-ascii?Q?dN6iRxoyDLwUyJPlT3IdJFEzBaqDMi5RG7Z1XXPX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf466d7a-a7f6-4475-9c4c-08dd00ceb320
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 14:56:32.7498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uejNi/4IMU/ea4RbliJBebmcTle2JKL59zoFs+gGDSNaD+Gkih9D34126aDvPZmQ8igJiRp0W35+bO+xqp5cSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7132

A scheduling domain can degenerate a parent NUMA domain if the CPUs
perfectly overlap, without inheriting the SD_NUMA flag.

This can result in the creation of a single NUMA domain that includes
all CPUs, even when the CPUs are spread across multiple NUMA nodes,
which may result in sub-optimal scheduling decisions.

Example:

$ vng -v --cpu 16,sockets=4,cores=2,threads=2 \
      -m 4G --numa 2G,cpus=0-7 --numa 2G,cpus=8-15
 ...
$ lscpu -e
CPU NODE SOCKET CORE L1d:L1i:L2:L3 ONLINE
  0    0      0    0 0:0:0:0          yes
  1    0      0    0 0:0:0:0          yes
  2    0      0    1 1:1:1:0          yes
  3    0      0    1 1:1:1:0          yes
  4    0      1    2 2:2:2:1          yes
  5    0      1    2 2:2:2:1          yes
  6    0      1    3 3:3:3:1          yes
  7    0      1    3 3:3:3:1          yes
  8    1      2    4 4:4:4:2          yes
  9    1      2    4 4:4:4:2          yes
 10    1      2    5 5:5:5:2          yes
 11    1      2    5 5:5:5:2          yes
 12    1      3    6 6:6:6:3          yes
 13    1      3    6 6:6:6:3          yes
 14    1      3    7 7:7:7:3          yes
 15    1      3    7 7:7:7:3          yes

Without this change:
  sd_llc[cpu0] spans cpus=0-3
  sd_numa[cpu0] spans cpus=0-15
  ...
  sd_llc[cpu15] spans cpus=12-15
  sd_numa[cpu15] spans cpus=0-15

With this change:
 - sd_llc[cpu0] spans cpus=0-3
 - sd_numa[cpu0] spans cpus=0-7
  ...
  sd_llc[cpu15] spans cpus=12-15
  sd_numa[cpu15] spans cpus=8-15

This also allows re-using sd_numa from the sched_ext built-in CPU idle
selection policy, instead of relying on the NUMA cpumasks [1].

[1] https://lore.kernel.org/lkml/20241108000136.184909-1-arighi@nvidia.com/

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/topology.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..e0fe493b7ae0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -755,6 +755,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			 */
 			if (parent->flags & SD_PREFER_SIBLING)
 				tmp->flags |= SD_PREFER_SIBLING;
+			/*
+			 * Transfer SD_NUMA to the child in case of a
+			 * degenerate NUMA parent.
+			 */
+			if (parent->flags & SD_NUMA)
+				tmp->flags |= SD_NUMA;
+
 			destroy_sched_domain(parent);
 		} else
 			tmp = tmp->parent;
@@ -1974,6 +1981,7 @@ void sched_init_numa(int offline_node)
 	 */
 	tl[i++] = (struct sched_domain_topology_level){
 		.mask = sd_numa_mask,
+		.sd_flags = cpu_numa_flags,
 		.numa_level = 0,
 		SD_INIT_NAME(NODE)
 	};
-- 
2.47.0


