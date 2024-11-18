Return-Path: <linux-kernel+bounces-413349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C359D17E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089A0282C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB561DF72C;
	Mon, 18 Nov 2024 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="X4DqwS+S"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023129.outbound.protection.outlook.com [40.93.201.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5601DF268
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953866; cv=fail; b=KUS4k0W3YbZvWNqJu0KKbsTmm9MdvLdbLc+b0/ID6cjRJGx5eCnrnfVCVviG+ks7/eBKCCBHjAd3gzxgVobe8q7ONnkNEkDec1QRSKsSKpHrWFUqD8N44+fUfNogX0jruF1dc2ZN0MZV5XoMImk7CPWIvVV1Q1UQviY2Wvjr7/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953866; c=relaxed/simple;
	bh=SUxtS/tqyblgAJdiVTk4WeUiQe1u2XfrK2E1GKV57/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=apCyR29MGpRa6W4XNTcnrfHQ9QtzQsxm3K2Z/eHgLgmDZxUFEg+oLE+JR1BrzOcHniZ/+wLtctyOC/SK/kB1fzw56tIS+VpfTrSvRolbsmX/xxSWFJiFDQAFiN58yFDiM5CMY9I8vY0hoeDZmgUdIMufvCqHfpJDen3+h9Vkbng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=X4DqwS+S; arc=fail smtp.client-ip=40.93.201.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxmqcKc6KMJcXaq7fKtJB0fE0fd+TSCW3fRO2TO+3Su4a5ZMNsgSUqpCZFcPHvUmxfYd9RzlLIGcMuk2e73fQhq3M3yki/b5tnPIvMP1dp3Pj6MN7mXZ9xFdqrHJ6HXRsKCXD8pt2BLEz2NjP46omPrMgn5gT3ht8oZh3bMNbs9pUSVS1BNWGeaTtut5GH0GvmG4OxrwsZva0TEim86pP+G7IxMVzu4+R3ohlTF02kEztnjotm2tgaJIXBE5/cRcZGj3BFE0Kw9ZDvh9rE3T7VQwZBpJKCC07zFpfP08JY06OeSVAORbv+Y8tUOqMMLlx42Y2yxNQBJmNTdY+320OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwekJ1bvjxTbcRKIIV4Je/GlYG+lORvTJsLJLWirXwc=;
 b=Sx/yFrKuA78Mm7aP/aEQz7UieMuFjTJrdEAQbgBM5bW1w+YrRGywgooxRK0pgb5WmQcVmBilGog7ajJCsYq4OUq/T2dtcbo+3SANQ7PJT0EwE4QRXv0/S6hvVUfnXgls260HYz8bW+SFDRzxmbGk9VrVL1SErE0lVSxpLiCY+U9OfykZIkkkkzBdhk6FzMwC+9CM1M+Q5iFlK8BNGAY3itj8gWbj52Agk2XeU19URURNJZf2KaMcbFfugRxVWHM/HQnGxcUf9dUjPo8/qzzHoL4NoHwZfH3YLMytAtSmbqowbY05ey5PQe/oLDHsBZEKvfw9RWSdv9UtD/Pae6DHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwekJ1bvjxTbcRKIIV4Je/GlYG+lORvTJsLJLWirXwc=;
 b=X4DqwS+SBEOU0YsqKS7rUVy6MfI63z5Ng3M+msWougGnTa7Sru8TMrA87FivALpohY0wviZ2tUMPJd5YhLoGSZfYKzi8KiHEzOjQjZe3Zix+NHUunuWeqWoNKXA6aM9gwoi6YEnNj1m1Ty4teTrwuR25iVgypFIpiFKVzFPIppI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CYYPR01MB8601.prod.exchangelabs.com (2603:10b6:930:c5::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Mon, 18 Nov 2024 18:17:39 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8182.013; Mon, 18 Nov 2024
 18:17:39 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: cl@gentwo.org,
	scott@os.amperecomputing.com,
	yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] arm64: support FEAT_BBM level 2 and large block mapping when rodata=full
Date: Mon, 18 Nov 2024 10:16:07 -0800
Message-ID: <20241118181711.962576-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:610:b2::13) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CYYPR01MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 83eb10a0-2d19-40af-78e4-08dd07fd492d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zzrs+WYgTpFGz9Jrl1jnIGoekIMoUHlT/ap3U0RSaJyiiZJjBhmjIZVritvf?=
 =?us-ascii?Q?4GHR757dnA59nX9Z0YQWp8i67Y5NjXOcCD2iUX3FGqHrck5ESpDOxJuMoT9j?=
 =?us-ascii?Q?4vpEuYwUsxW/xc54jUDWk0RyDuyJKq5w0R+yhSoTKe1mjUFXeuPPS1bs0GNE?=
 =?us-ascii?Q?uNGsxOaNiCXjqDKsEcC12+6SvGtRhqBAriTGlmvwR0ksj4qvsIBiAkDj1xr1?=
 =?us-ascii?Q?tdOgOLrAZVJOweb8oYym8ZqXfnRfwhmh6ruTBPA/IuF9ODC/AyqXR5fFnBAW?=
 =?us-ascii?Q?T0zb2ZtzA3vLahFcdkE0HAEmNwlCgHUDZ1Wg/oirvK0QQjKv12xKR9Qbd7tS?=
 =?us-ascii?Q?5/z1agOJfUCIIyPFE7KgW5XkXrYpvpOXVVQzJMcqLICsExii6I74C8urUoFm?=
 =?us-ascii?Q?tD6EUG2ATbQ/TU3VtZW6KpIAUgJ1CCb729jX8vxA7MnlAIKPwr9qVp71WbRc?=
 =?us-ascii?Q?TVXoI3GLNU0D/aFf5s0rj65FrcB73gD7uML+FEZZ6OPSoR0eXC8ty7Z8oJ3X?=
 =?us-ascii?Q?6ajN+AahGH1LNJ+/WBj969derl4KBkDnEJ6qniYsSZt658YudHHTE5VJjXgn?=
 =?us-ascii?Q?vwg9F4LyR4ntDm+dV0FjVQmr4PDI2yWHB7f1BfIXsqr+apehfl6HchWGZKDT?=
 =?us-ascii?Q?rZU1knE5xGfzKZehZjm4RaZ232CuOjkzqeT0d6+PTWT+oYWcZoYqAnX7A2IR?=
 =?us-ascii?Q?E4KSHuGvJgZHV2Q5XFKED7SNsw+982Qdk1JwsDdIClg8Dm9ND2keHMr1ppAb?=
 =?us-ascii?Q?HnVdQGNENoegRttWBRnfbh83xxM4bDzm0FEPw5bHJ+AiLD92zZR6bRUqSd7v?=
 =?us-ascii?Q?nYuTPXLP/AldwlGO3GrHK0K5msLBuXDoRFwBHGHAnjsOLj7o6yGS7707XD4v?=
 =?us-ascii?Q?qdE9TxdfhD2qBPz+75DOcMJXNQ3/ycOcJcdpjKbSH6OJzsQyiLm4h/pP+Jne?=
 =?us-ascii?Q?1TBK6BUnGywQSZO8VNXtVSUUPuxldBLJMDt1mYBPEi/l9RGlhqXmZihSkilQ?=
 =?us-ascii?Q?p7HE0GV8ZObeucJiKt8+voefbzhu18BH+8yyngezk4vLfsw3ZIWmrd/B7mqC?=
 =?us-ascii?Q?NgbyXZik6UJ5oI8gVRCBIEJj2Rld34Mey2hZrvzL//FEvJaOGUQcJ08b8QuX?=
 =?us-ascii?Q?+A8a8QGCY6athVRt39S3xBoNgvbqn3F36mAoJMeb6kU7bGLOHwZ0ZOwiVSer?=
 =?us-ascii?Q?ILXrpuhIVKQrfP/t6rP5heJufDgzKdaKqlM+CPcwtJ/JHA3syH62YHJIn8a/?=
 =?us-ascii?Q?OMUbO2KtHTCxbCeakq0sERXq9pSfINe7RIBFFM2XnIP4cNmnCAp2WnDkLGdZ?=
 =?us-ascii?Q?btXzz/AL1Pk9BMcx1ILJsGQwJ/YlzX4yiGXkmekewns5hbHhkaeRHNV8ObiR?=
 =?us-ascii?Q?Ant0ZIk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v4oNj2Ql9INaK/GiyLk9bs3vlNp/m72fhfNh5E2eG3JQWtxcyVARyH8AP6LN?=
 =?us-ascii?Q?mep7Fwk1eV6Nek7Nl4K3vev5dSUKEz1fcjzM5lWzTZzDRU0UFjaID8hsCWW/?=
 =?us-ascii?Q?s8Wd9iXrndyjVKyEzB9edz715JZ44PrdEc52iWTKSOeY/6qKZZypAgSGeN3L?=
 =?us-ascii?Q?y+BNjBM7oiZGr6DyZ4V2kOwabRXJVhCWJp/IMCyQZ+Ym59mtqxAZMvAGBQeJ?=
 =?us-ascii?Q?8cVqfet+SJJ7Wkjpi005cDvQtus1vXLeHNrS2lvWS7g26dWia+z9nRELNMZ4?=
 =?us-ascii?Q?B/dvc61QtqZAOoA01Fl362B5s1Rt8lXhPw8hZNSJZ/GEgTdWaOZ2IqaH27qB?=
 =?us-ascii?Q?QsRgOAIb3rP30FwEgzpPKX06C/C9TCglNjieEkELO0k2Ya75GJA6F2d2HnOi?=
 =?us-ascii?Q?jwW2hldhUP8toRq038Rvq3/B9hl0+M49sPX609pYxUvCZpjhkdmDxE0a6Z7M?=
 =?us-ascii?Q?8CoHTxYcUhhQIJtkDNhainCk5qgOKQN9zXboJf0Kd9Y7o7hahNkrF0qxN/HV?=
 =?us-ascii?Q?SJIR2YK14ErTnuWFsLitQC5G2MOZSJ+YmaixvDBHwAM2pBUuYGNLX7q4DlJ7?=
 =?us-ascii?Q?Q9yqbI42tnbScap6xrC6sSmJj9AYUek+jEHG64W2dqkjNrRXvyjltGDgVqL1?=
 =?us-ascii?Q?KeyJSjXkLp6AekEHE9fYSET7Bg+4PCenweypz20WII4lyMCzttT8yCAAQ9mr?=
 =?us-ascii?Q?rs++Y3dq6fKFo4zN920jNdwyxL2ZkqV2m70hR2JysYgDTxoKcJXRkPo3EBFq?=
 =?us-ascii?Q?zOTYe4rROATijhAHMQa72AfGq3X+WuElxXLSPpuhs2SUyl7dh8Z0sIqN66Wl?=
 =?us-ascii?Q?KzTD20Ay8XQpfxaOhrdlRFwB+Ut6M/CEoEbbBLmGLuclRD3hWmMgQ1vVC8d+?=
 =?us-ascii?Q?1IWTwMZquGYAdqBVU296s1rZS5lrdZuZ9rnNz2Tax8MNC2EOY4pdzwasewZA?=
 =?us-ascii?Q?d/p9jIW+/B4kDYdq9iZjK9GY3vbuOnjZMF3wnu5VjUqwHLzD2Tn3G1sGkSlN?=
 =?us-ascii?Q?ItYtX813MPDhKjDWbxkx7f49OmytYBNWdOHlKT9HZbOMRHrJ5RQXPk+lMyIB?=
 =?us-ascii?Q?5ptDNjQKvlNo72tsZoCI+nSPAK4M7rOWMWBG87+09kPLZbEScUtXgv5F6guz?=
 =?us-ascii?Q?w6Ux+LNUUIj1DAGnwOeavAy+peAKDrmyiHEojXX3xDj3TA24i54rpJ3+LVOF?=
 =?us-ascii?Q?byPE2eM0d3gVpLw/0uA2tT1nkI/84AezGJaw8hlxGQcwKLu2WIusdPKd8hn4?=
 =?us-ascii?Q?1250D9t2wEpffQoRca5QitL+OXysigqXMWAN3xKRJJ3wXQugyswJqnh3OKnq?=
 =?us-ascii?Q?4YTn2S1/BjatGwPyOgTFvevJ6vJS7wm35uuAOzMNcWFSw603uZwB4peIDjg7?=
 =?us-ascii?Q?cTjYhVgu+Jaf+E0U0RH2efTeEp6f/Dx8EMpvI9jVL4H8tUZhY3LP+gVNDxF9?=
 =?us-ascii?Q?+T4wNPPyOFB8c/cjM7j7fWUMP1Za/7qI5CfGvvp+BbOTTyppnCsZniwDbRSP?=
 =?us-ascii?Q?1YxG80Td77vMqWElc4577Hs5hS2Df7ZfDI/a4G5851wo6X8AH4iGTl2/gMAQ?=
 =?us-ascii?Q?PIhEpzITHm7JkRAN1PGS7cRqcN/hW5jq61G5ee1hzJgjDfPylM4xXE3BBhBl?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eb10a0-2d19-40af-78e4-08dd07fd492d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 18:17:39.3919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NnOgTt6jwvJTJZPLmwsah553VTcKXwt4Vut7LPjw4rkzWz2t3f54g6uCfQJQ/WC25kn/nquy0k7BWMeQE4gDWGqjAO0852OeRAasb6I/ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8601


When rodata=full kernel linear mapping is mapped by PTE due to arm's
break-before-make rule.

This resulted in a couple of problems:
  - performance degradation
  - more TLB pressure
  - memory waste for kernel page table

There are some workarounds to mitigate the problems, for example, using
rodata=on, but this compromises the security measurement.

With FEAT_BBM level 2 support, splitting large block page table to
smaller ones doesn't need to make the page table entry invalid anymore.
This allows kernel split large block mapping on the fly.

Add kernel page table split support and use large block mapping by
default when FEAT_BBM level 2 is supported for rodata=full.  When
changing permissions for kernel linear mapping, the page table will be
split to PTE level.

The machine without FEAT_BBM level 2 will fallback to have kernel linear
mapping PTE-mapped when rodata=full.

With this we saw significant performance boost with some benchmarks with
keeping rodata=full security protection in the mean time.

The test was done on AmpereOne machine (192 cores, 1P) with 256GB memory and
4K page size + 48 bit VA.

Function test (4K/16K/64K page size)
  - Kernel boot.  Kernel needs change kernel linear mapping permission at
    boot stage, if the patch didn't work, kernel typically didn't boot.
  - Module stress from stress-ng. Kernel module load change permission for
    module sections.
  - A test kernel module which allocates 80% of total memory via vmalloc(),
    then change the vmalloc area permission to RO, then change it back
    before vfree(). Then launch a VM which consumes almost all physical
    memory.
  - VM with the patchset applied in guest kernel too.
  - Kernel build in VM with patched guest kernel.

Memory consumption
Before:
MemTotal:       258988984 kB
MemFree:        254821700 kB

After:
MemTotal:       259505132 kB
MemFree:        255410264 kB

Around 500MB more memory are free to use.  The larger the machine, the
more memory saved.

Performance benchmarking
* Memcached
We saw performance degradation when running Memcached benchmark with
rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
With this patchset we saw ops/sec is increased by around 3.5%, P99
latency is reduced by around 9.6%.
The gain mainly came from reduced kernel TLB misses.  The kernel TLB
MPKI is reduced by 28.5%.

The benchmark data is now on par with rodata=on too.

* Disk encryption (dm-crypt) benchmark
Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
encryption (by dm-crypt).
fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
    --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
    --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
    --name=iops-test-job --eta-newline=1 --size 100G

The IOPS is increased by 90% - 150% (the variance is high, but the worst
number of good case is around 90% more than the best number of bad case).
The bandwidth is increased and the avg clat is reduced proportionally.

* Sequential file read
Read 100G file sequentially on XFS (xfs_io read with page cache populated).
The bandwidth is increased by 150%.


Yang Shi (3):
      arm64: cpufeature: detect FEAT_BBM level 2
      arm64: mm: support large block mapping when rodata=full
      arm64: cpufeature: workaround AmpereOne FEAT_BBM level 2

 arch/arm64/include/asm/cpufeature.h |  24 ++++++++++++++++++
 arch/arm64/include/asm/pgtable.h    |   7 +++++-
 arch/arm64/kernel/cpufeature.c      |  11 ++++++++
 arch/arm64/mm/mmu.c                 |  31 +++++++++++++++++++++--
 arch/arm64/mm/pageattr.c            | 173 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 arch/arm64/tools/cpucaps            |   1 +
 6 files changed, 238 insertions(+), 9 deletions(-)



