Return-Path: <linux-kernel+bounces-545679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB3A4F00F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC7A1717FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0EA27817D;
	Tue,  4 Mar 2025 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Gm0RMFd2"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020105.outbound.protection.outlook.com [52.101.85.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77D27811D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126856; cv=fail; b=j4+jbO+klyJfcEew6DCQVpEX5w7qG7Vu3TXrmzAO/qY76/lmGEX+hnsDVQr+IRMzBz9p+p6P+6jxkMlDaTlESXbytf9YfLQ1vpJtsllOaqYL8FxwU0EUDrqcxD55bWs/B+JVceioYM/F3DYj9uFVOJiS8V7LvXsIXAspGI6GCaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126856; c=relaxed/simple;
	bh=2jQCITYRk88AJNp25D+aH0y9T4Ss1LwqtB/1k/H8AHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WscmyaC0pTrJ9JVGhIxwV2e9HXcJNk5cRw7NiaHUGuYMYSM0Wn9A6V5uWYZSmPlpzP262FLbpCzfyHKZKkpd0tTfhiJNbdcoOLP7u0GkhOBi1ZHWFvHDhWLZdRHTiV7pCw+5syg05wpHpQqLGbjArE2j7VMQyiUgYXBNc2KSavM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Gm0RMFd2; arc=fail smtp.client-ip=52.101.85.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUghz798qnfaVRHjKlOdBxkBlwbkh6yxheU8L4E0zQJcMKoGRsfHmGGN9yHqDKk+PQqBptdfKbi/y8+DXecVtf0KQCCQy10tatYQWO1ETC4UHvkPsS9a/DBIuUmOL810zg78MxihPulz/u2gsfa8zFjZfH/A3xyApeYEKyuq9SltdjPPfmNAxDmDplpx1M43GWl1wiDzCEygfCmPTuwnhpGoeFNcCwUrKDGmAhIjeRIDL5tYFHppddxWUiTPugBElRqNXSjpJGtpgXt6fqM0rXRpcvwmMElnqhtIza4lMlcyZOHk/M2hAFg0jpXyHgmsvKP04BmNBJ/T8u8s9xpZQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94OWQgZSNmZciVJ66VwsvsrSEv9n1ZXhYxuZKkj/4x4=;
 b=Jx3UcM729qq12JOugZYNJI2Svexk77ctIw1nKo5RVYzRGyoA3ObKsSy1yjnRn7uBN0Ib6WcHHUrFLjAuuak4TNnxQu9b0Ebh0lTDgx4ijiyKMf98v0PVUOdZwmdKBT5p10YTrskkoROAja/imNaqktzdsFani6b3TijWfC30Y5chTQCrMyKm6KkCg2ft0Y/0u0oEhrwZ5kcYEPzIlt9YVQ5lRB896+FKA5yBvWznmuyP8QJY/SSfa6cxnrhHjkA/uMhWhs9y1AWuOfOcJNAm8jt2zi8bqAolE64A/8cuNbYo8f/z1JpX1AxKNwKRJdenqfhqNHh6qLEx/0WM3M7ODA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94OWQgZSNmZciVJ66VwsvsrSEv9n1ZXhYxuZKkj/4x4=;
 b=Gm0RMFd2wXfvwKq/Akg5/igHnS27pcnJoAGBjRKDQqX9tMZlnr45cwd9UY7HNHXIgIJRLbw29+mD4xlbir+FThRobBvS135+YErTFsXSnNj2wMOsShkcChyYrK4Oytf0oE2kdFnoFX6mC5eVgTc1TOTUb8zoXz69ewzYHPt6Cws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH7PR01MB7931.prod.exchangelabs.com (2603:10b6:510:275::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.26; Tue, 4 Mar 2025 22:20:49 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 22:20:49 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	Miko.Lenczewski@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH 4/6] arm64: mm: support large block mapping when rodata=full
Date: Tue,  4 Mar 2025 14:19:29 -0800
Message-ID: <20250304222018.615808-5-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250304222018.615808-1-yang@os.amperecomputing.com>
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH7PR01MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb76ef4-9d37-44fc-d3a2-08dd5b6ad163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KQOAKu2FhjmgK2ANpIzHXVLDh/wATgYhSwwNO5e8v5mxksmid4hsycPByJDf?=
 =?us-ascii?Q?O3n9Uw+bru5hXKvhgKmQ18qmCpoaN9VrPBS1ydhQ9lusNL/0k5pdlG80Z7KP?=
 =?us-ascii?Q?XEwLhOL93UkyT22do+50qzlr0Ot/K2w3tnLP7tW8k6KDngSuO7lleFktdiNt?=
 =?us-ascii?Q?ifnzoc1O3eTiBEII5l+hXLSNXwD/50cNzNDkuKWqbA78Tffu2WhtCmrXyP8a?=
 =?us-ascii?Q?5AyXwmHfYNGYc2Nc2w6Jj9enyklZ0dDgoSQd6qCkiINVPht/Xz/diopzFKar?=
 =?us-ascii?Q?uXbGamAAZR6x+FyZUIXNvaS9R5jRfKKr9dkfHYE9Hw7XOiFG55ry7Dwa8uVl?=
 =?us-ascii?Q?Sa4Bb8NzKGTxdGgOU2JOJFEVKhx7ljDfbRNTnfAURx86/rpw9VUU69rmHyeG?=
 =?us-ascii?Q?kVp4REpbBeRxst4//Up04Myuz7cjb4F65kwsvn9Gi2/8qfURm/7JQuYIa2o2?=
 =?us-ascii?Q?2+AsQr8RMKeFpnbQ5PphGX6eDpNTnxCmSAcy/cYQCg47oC80Y7sCqQB1yjZJ?=
 =?us-ascii?Q?1ayuqFmJNSHOTvASejBU5r74odY7pdq0MtOdDeNGGOrWLfYrZHUS/HpwHtuk?=
 =?us-ascii?Q?N3injM2Jc38JPXk08Ytd0rvnVYt9zBQiiUH2dFgkFtyF0yol0cqzJFGf3sip?=
 =?us-ascii?Q?yAhVVVfd+Rfg0gzUIYHaxXGLmCJlx+2gWDO8pBwt5726JtXjZ24iI2CrL4CG?=
 =?us-ascii?Q?iTXh2laXj7irRxhiXWRcQEWeNNRt89YAvmyBTyigUmEmCxhJVIDOD9Ydxsus?=
 =?us-ascii?Q?kabY5/ViL7Ie3x1X6F9GPM9wFPkkloV9A1j0PvRcu2QlOAyZY1emeTItI9Jc?=
 =?us-ascii?Q?2W/FafOQB4K4iYxF0Vv9UA8N+RA6gDA4hSZ5Yi9m2GP7yE3mK8EtEU2xCVs5?=
 =?us-ascii?Q?5MFJKOdQTHtSpsHQVs4PylbvwgilRzAr/8gnEe/joz3P2rD2utkSxnHgXaOa?=
 =?us-ascii?Q?KgCKDV8/S7mhMuGBJKAMkXuZdMNSzQJXr37fvxOTesL2vDCjTbco5NgabTI7?=
 =?us-ascii?Q?lxPrpcG8mmJ/KCj9ywFDIqxnmldaeiU1c27EYcRLIHU01GOcAbUFbdKjNFUN?=
 =?us-ascii?Q?tswqSHYbQpB0MgQwIJPdZK/hxq3yVBcCdLtZkvHsVo0Kd1kwg5uzrijz8Tvz?=
 =?us-ascii?Q?o+mDr7Y2JQseKXHUoLsMYiWYu3mb8aE3yYN/9vJCaCRgcBCgea61E/siqAFr?=
 =?us-ascii?Q?nTbh+qaXiqlbzHP2G1HGpLl33OVu7iFrgbSoOLcDa/Pa1RR0XvZmEGs7Hs0n?=
 =?us-ascii?Q?OSxHplwaFAQ1wTfcxrsJleOnLrCIPvL0DprTemDWCXCoWUg/eAMsIIui3pKV?=
 =?us-ascii?Q?fn2L9To+XEo9f74VEsXCbGPCvFebJWVDth5r3+Lrz3T6AcHFWDGoehRSGT29?=
 =?us-ascii?Q?thfIo30FQQuK9htsfKrse4Bu95au5W463yCmpny2RmNdwHjCMSKeIjWMBJ2K?=
 =?us-ascii?Q?3bGYUgL2hRHb996hT/IH4iAd8omeNuDm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hr0WsYr/0WTVP4PD/0C7UlAXVuSk8bZp5D1apCcULKn8t1o5RwneP2jgZa/5?=
 =?us-ascii?Q?ql1flQ7aknJ6iZG782DBm4M9a+CLxpd07GfRLbdWzkvCx4Eg9SSl8OCNxJOV?=
 =?us-ascii?Q?biGEc5oAU/ta2Hwqb+vajVd1HGfxfCdQ1RrAwkejjV0FAJ8RZXpRtc+2yyyR?=
 =?us-ascii?Q?PLsf6nXEGlCeXb32ZKetVx270ST0kdejnCgxHEJVehkjPBuxZXGzISXibhaa?=
 =?us-ascii?Q?u05r7wl+xtBA+VkaLIkHAaBVR+tTNynNeyqv6R5UrggljTK59IEMG3xXTJzM?=
 =?us-ascii?Q?OBDmcJxu10OVuau7hEQEalul7uOO4fBWSHdfGnx4kg4NZly3LFn7JdyYhlGD?=
 =?us-ascii?Q?gi82FHDqm9u4UKie/IkHmztg+uZRASdtK7AjI3zl51H29Q+Ghyo1Bj4fSQ9W?=
 =?us-ascii?Q?zinfmGEVLPeuR8VVsq4kUJWERBL9QXkKb0xtCAFgcV0UZx6maPHwkY6aU05p?=
 =?us-ascii?Q?QiAZfk87pvCkYSY54TL9B14VlJRKnYmKfm4LyUgJO9kGXQsB/J/sgoVBYKcQ?=
 =?us-ascii?Q?I6iG5QDeLIEQvLV1TeUK47LF6TblApPxI2yUbebqGRt/NUtLQ96G4taJBAqj?=
 =?us-ascii?Q?Qbsfg1Iz21nTzRUqEyq7i5alvYj8gGTC2dJWaLoTa4Yl545ASLZioXUfb46y?=
 =?us-ascii?Q?cI/Nuh9y6ZnaBHc9CMsHnR/NLU7LN8cU9eCOiMw3NJH5gLK+O20S8jcr17XS?=
 =?us-ascii?Q?9lWf1H7VT0xmTa8X+bOozMs/cEEQ6RhW/L1igt4VMuN/z2lwcrGovTaVU54k?=
 =?us-ascii?Q?QepanBmmQ//1eMxI5sn4rXuwRECcGQTFOh9JJl4AHss2iOXWKGYzJ7meFo/E?=
 =?us-ascii?Q?LC9M7Atcc7G6BHo5V/FJej+eF8zipNq4mQtXDR3DMRgdiLugZ6yzc2wYH9RE?=
 =?us-ascii?Q?cwYyBv/WSnYZnmC+aD03O3g0vHAh6iqH6O8wo0Rxwf6M9QvKmHbIfnkBXHXz?=
 =?us-ascii?Q?IDJLcR8ZsncvvQlBgdAeGlr9tK70oo08aof1+s+NTFuCppLH87ROEExmZcMX?=
 =?us-ascii?Q?iWGyFqHcGejCCivaFaNA0eYDr63ZQyFYOuMY5lEmQ7KgS0fCWhFlfbKIapcN?=
 =?us-ascii?Q?LnxdtSozkeHfH9303Jz/WqYVj77QtRqt1es/7eyqkB7DK47+/qNfHort2fig?=
 =?us-ascii?Q?smee/59jB4CDkKkf0TX9jlLlQ0gzdFmxgPnsCyJQBLHyNOzMfMHjiivpXFLm?=
 =?us-ascii?Q?g6fqv8Re1T1KAnz0hx3+KKjJn1thOSpSNfTVe3lKW/Prz6C/MtpWqKsLIWcO?=
 =?us-ascii?Q?l6qabcaY4h2v5bvDc97S8a+oR1R8r5FT2tiUeBisy7W7YNcfJa5ohLdkgzVc?=
 =?us-ascii?Q?2PoP0lodO2EXgNdJcdv3YLNNHjQrlNkBC2QlEq2aO/TfGnVz5n5mFd0g6YB2?=
 =?us-ascii?Q?9sWL3bpYoOzT3nMxv+UuSYI/bObhBipkYpoLnMR+zbnhBchbj+oEG8FEnv/3?=
 =?us-ascii?Q?gOB8R9zM/PBL0ZwSU17UiOZd7nyJYI9Udbx8aEuyfKWMQQAb4irUnKTCT8hu?=
 =?us-ascii?Q?CASyT7bPvEIkybSlW5zf3s68NCMawGg27DpEQnSl40vsKA6IEWrpjdDi6sPu?=
 =?us-ascii?Q?DkBtkn8IrUOkIQEB5CoeZ45kBMzvMkCMHcGXzzZfVF8hN223yP+Q7ZCRkDqV?=
 =?us-ascii?Q?yQUEaaPE9SrsXGNAve+Tcts=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb76ef4-9d37-44fc-d3a2-08dd5b6ad163
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 22:20:49.5461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/mhj33U4nyGXBKa/qG4/dnEx3jLHA4eZ6T74xvi8Fv6/WKmILTqmKF5F+4NFcJUSCLOV+y2y1LYaMK07cIS79NnU5D0PmZzq513KSrCJ58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB7931

When rodata=full is specified, kernel linear mapping has to be mapped at
PTE level since large page table can't be split due to break-before-make
rule on ARM64.

This resulted in a couple of problems:
  - performance degradation
  - more TLB pressure
  - memory waste for kernel page table

With FEAT_BBM level 2 support, splitting large block page table to
smaller ones doesn't need to make the page table entry invalid anymore.
This allows kernel split large block mapping on the fly.

Add kernel page table split support and use large block mapping by
default when FEAT_BBM level 2 is supported for rodata=full.  When
changing permissions for kernel linear mapping, the page table will be
split to PTE level.

The machine without FEAT_BBM level 2 will fallback to have kernel linear
mapping PTE-mapped when rodata=full.

With this we saw significant performance boost with some benchmarks and
much less memory consumption on my AmpereOne machine (192 cores, 1P) with
256GB memory.

* Memory use after boot
Before:
MemTotal:       258988984 kB
MemFree:        254821700 kB

After:
MemTotal:       259505132 kB
MemFree:        255410264 kB

Around 500MB more memory are free to use.  The larger the machine, the
more memory saved.

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

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/cpufeature.h |  10 ++
 arch/arm64/include/asm/mmu.h        |   1 +
 arch/arm64/include/asm/pgtable.h    |   7 +-
 arch/arm64/kernel/cpufeature.c      |   2 +-
 arch/arm64/mm/mmu.c                 | 169 +++++++++++++++++++++++++++-
 arch/arm64/mm/pageattr.c            |  35 +++++-
 6 files changed, 211 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 108ef3fbbc00..e24edc32b0bd 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -871,6 +871,16 @@ static inline bool system_supports_bbml2_noabort(void)
 	return alternative_has_cap_unlikely(ARM64_HAS_BBML2_NOABORT);
 }
 
+bool cpu_has_bbml2_noabort(unsigned int cpu_midr);
+/*
+ * Called at early boot stage on boot CPU before cpu info and cpu feature
+ * are ready.
+ */
+static inline bool bbml2_noabort_available(void)
+{
+	return cpu_has_bbml2_noabort(read_cpuid_id());
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 662471cfc536..d658a33df266 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -71,6 +71,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 			       pgprot_t prot, bool page_mappings_only);
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
+extern int split_linear_mapping(unsigned long start, unsigned long end);
 
 /*
  * This check is triggered during the early boot before the cpufeature
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b2a2ad1b9e8..ed2fc1dcf7ae 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -749,7 +749,7 @@ static inline bool in_swapper_pgdir(void *addr)
 	        ((unsigned long)swapper_pg_dir & PAGE_MASK);
 }
 
-static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+static inline void __set_pmd_nosync(pmd_t *pmdp, pmd_t pmd)
 {
 #ifdef __PAGETABLE_PMD_FOLDED
 	if (in_swapper_pgdir(pmdp)) {
@@ -759,6 +759,11 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 #endif /* __PAGETABLE_PMD_FOLDED */
 
 	WRITE_ONCE(*pmdp, pmd);
+}
+
+static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
+{
+	__set_pmd_nosync(pmdp, pmd);
 
 	if (pmd_valid(pmd)) {
 		dsb(ishst);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index bf3df8407ca3..d39637d5aeab 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2176,7 +2176,7 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
 	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
 }
 
-static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
+bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
 {
 	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
 	 * as possible. This list is therefore an allow-list of known-good
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index dccf0877285b..ad0f1cc55e3a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -45,6 +45,7 @@
 #define NO_BLOCK_MAPPINGS	BIT(0)
 #define NO_CONT_MAPPINGS	BIT(1)
 #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
+#define SPLIT_MAPPINGS		BIT(3)
 
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
@@ -166,6 +167,73 @@ static void init_clear_pgtable(void *table)
 	dsb(ishst);
 }
 
+static int split_pmd(pmd_t *pmdp, pmd_t pmdval,
+		     phys_addr_t (*pgtable_alloc)(int))
+{
+	unsigned long pfn;
+	pgprot_t prot;
+	phys_addr_t pte_phys;
+	pte_t *ptep;
+
+	if (!pmd_leaf(pmdval))
+		return 0;
+
+	pfn = pmd_pfn(pmdval);
+	prot = pmd_pgprot(pmdval);
+
+	pte_phys = pgtable_alloc(PAGE_SHIFT);
+	if (!pte_phys)
+		return -ENOMEM;
+
+	ptep = (pte_t *)phys_to_virt(pte_phys);
+	init_clear_pgtable(ptep);
+	prot = __pgprot(pgprot_val(prot) | PTE_TYPE_PAGE);
+	for (int i = 0; i < PTRS_PER_PTE; i++, ptep++)
+		__set_pte_nosync(ptep, pfn_pte(pfn + i, prot));
+
+	dsb(ishst);
+
+	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(pte_phys),
+		__pgprot(PMD_TYPE_TABLE)));
+
+	return 0;
+}
+
+static int split_pud(pud_t *pudp, pud_t pudval,
+		     phys_addr_t (*pgtable_alloc)(int))
+{
+	unsigned long pfn;
+	pgprot_t prot;
+	pmd_t *pmdp;
+	phys_addr_t pmd_phys;
+	unsigned int step;
+
+	if (!pud_leaf(pudval))
+		return 0;
+
+	pfn = pud_pfn(pudval);
+	prot = pud_pgprot(pudval);
+	step = PMD_SIZE >> PAGE_SHIFT;
+
+	pmd_phys = pgtable_alloc(PMD_SHIFT);
+	if (!pmd_phys)
+		return -ENOMEM;
+
+	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
+	init_clear_pgtable(pmdp);
+	for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
+		__set_pmd_nosync(pmdp, pfn_pmd(pfn, prot));
+		pfn += step;
+	}
+
+	dsb(ishst);
+
+	set_pud(pudp, pfn_pud(__phys_to_pfn(pmd_phys),
+		__pgprot(PUD_TYPE_TABLE)));
+
+	return 0;
+}
+
 static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 		     phys_addr_t phys, pgprot_t prot)
 {
@@ -251,12 +319,21 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 {
 	unsigned long next;
 	int ret = 0;
+	bool split = flags & SPLIT_MAPPINGS;
 
 	do {
 		pmd_t old_pmd = READ_ONCE(*pmdp);
 
 		next = pmd_addr_end(addr, end);
 
+		if (split) {
+			ret = split_pmd(pmdp, old_pmd, pgtable_alloc);
+			if (ret)
+				break;
+
+			continue;
+		}
+
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
 		    (flags & NO_BLOCK_MAPPINGS) == 0) {
@@ -292,11 +369,19 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 	int ret = 0;
 	pud_t pud = READ_ONCE(*pudp);
 	pmd_t *pmdp;
+	bool split = flags & SPLIT_MAPPINGS;
 
 	/*
 	 * Check for initial section mappings in the pgd/pud.
 	 */
 	BUG_ON(pud_sect(pud));
+
+	if (split) {
+		BUG_ON(pud_none(pud));
+		pmdp = pmd_offset(pudp, addr);
+		goto split_pgtable;
+	}
+
 	if (pud_none(pud)) {
 		pudval_t pudval = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
 		phys_addr_t pmd_phys;
@@ -316,6 +401,7 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 		pmdp = pmd_set_fixmap_offset(pudp, addr);
 	}
 
+split_pgtable:
 	do {
 		pgprot_t __prot = prot;
 
@@ -334,7 +420,8 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 		phys += next - addr;
 	} while (addr = next, addr != end);
 
-	pmd_clear_fixmap();
+	if (!split)
+		pmd_clear_fixmap();
 
 	return ret;
 }
@@ -348,6 +435,13 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 	int ret = 0;
 	p4d_t p4d = READ_ONCE(*p4dp);
 	pud_t *pudp;
+	bool split = flags & SPLIT_MAPPINGS;
+
+	if (split) {
+		BUG_ON(p4d_none(p4d));
+		pudp = pud_offset(p4dp, addr);
+		goto split_pgtable;
+	}
 
 	if (p4d_none(p4d)) {
 		p4dval_t p4dval = P4D_TYPE_TABLE | P4D_TABLE_UXN | P4D_TABLE_AF;
@@ -368,11 +462,25 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		pudp = pud_set_fixmap_offset(p4dp, addr);
 	}
 
+split_pgtable:
 	do {
 		pud_t old_pud = READ_ONCE(*pudp);
 
 		next = pud_addr_end(addr, end);
 
+		if (split) {
+			ret = split_pud(pudp, old_pud, pgtable_alloc);
+			if (ret)
+				break;
+
+			ret = alloc_init_cont_pmd(pudp, addr, next, phys, prot,
+						  pgtable_alloc, flags);
+			if (ret)
+				break;
+
+			continue;
+		}
+
 		/*
 		 * For 4K granule only, attempt to put down a 1GB block
 		 */
@@ -399,7 +507,8 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		phys += next - addr;
 	} while (pudp++, addr = next, addr != end);
 
-	pud_clear_fixmap();
+	if (!split)
+		pud_clear_fixmap();
 
 	return ret;
 }
@@ -413,6 +522,13 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	int ret = 0;
 	pgd_t pgd = READ_ONCE(*pgdp);
 	p4d_t *p4dp;
+	bool split = flags & SPLIT_MAPPINGS;
+
+	if (split) {
+		BUG_ON(pgd_none(pgd));
+		p4dp = p4d_offset(pgdp, addr);
+		goto split_pgtable;
+	}
 
 	if (pgd_none(pgd)) {
 		pgdval_t pgdval = PGD_TYPE_TABLE | PGD_TABLE_UXN | PGD_TABLE_AF;
@@ -433,6 +549,7 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 		p4dp = p4d_set_fixmap_offset(pgdp, addr);
 	}
 
+split_pgtable:
 	do {
 		p4d_t old_p4d = READ_ONCE(*p4dp);
 
@@ -449,7 +566,8 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 		phys += next - addr;
 	} while (p4dp++, addr = next, addr != end);
 
-	p4d_clear_fixmap();
+	if (!split)
+		p4d_clear_fixmap();
 
 	return ret;
 }
@@ -546,6 +664,23 @@ static phys_addr_t pgd_pgtable_alloc(int shift)
 	return pa;
 }
 
+int split_linear_mapping(unsigned long start, unsigned long end)
+{
+	int ret = 0;
+
+	if (!system_supports_bbml2_noabort())
+		return 0;
+
+	mmap_write_lock(&init_mm);
+	ret = __create_pgd_mapping_locked(init_mm.pgd, virt_to_phys((void *)start),
+					  start, (end - start), __pgprot(0),
+					  __pgd_pgtable_alloc, SPLIT_MAPPINGS);
+	mmap_write_unlock(&init_mm);
+	flush_tlb_kernel_range(start, end);
+
+	return ret;
+}
+
 /*
  * This function can only be used to modify existing table entries,
  * without allocating new levels of table. Note that this permits the
@@ -665,6 +800,24 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
 
 #endif /* CONFIG_KFENCE */
 
+static inline bool force_pte_mapping(void)
+{
+	/*
+	 * Can't use cpufeature API to determine whether BBML2 supported
+	 * or not since cpufeature have not been finalized yet.
+	 *
+	 * Checking the boot CPU only for now.  If the boot CPU has
+	 * BBML2, paint linear mapping with block mapping.  If it turns
+	 * out the secondary CPUs don't support BBML2 once cpufeature is
+	 * fininalized, the linear mapping will be repainted with PTE
+	 * mapping.
+	 */
+	return (rodata_full && !bbml2_noabort_available()) ||
+		debug_pagealloc_enabled() ||
+		arm64_kfence_can_set_direct_map() ||
+		is_realm_world();
+}
+
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
@@ -690,9 +843,12 @@ static void __init map_mem(pgd_t *pgdp)
 
 	early_kfence_pool = arm64_kfence_alloc_pool();
 
-	if (can_set_direct_map())
+	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
+	if (rodata_full)
+		flags |= NO_CONT_MAPPINGS;
+
 	/*
 	 * Take care not to create a writable alias for the
 	 * read-only text and rodata sections of the kernel image.
@@ -1388,9 +1544,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
 
 	VM_BUG_ON(!mhp_range_allowed(start, size, true));
 
-	if (can_set_direct_map())
+	if (force_pte_mapping())
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
+	if (rodata_full)
+		flags |= NO_CONT_MAPPINGS;
+
 	__create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
 			     size, params->pgprot, __pgd_pgtable_alloc,
 			     flags);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 39fd1f7ff02a..5d42d87ea7e1 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -10,6 +10,7 @@
 #include <linux/vmalloc.h>
 
 #include <asm/cacheflush.h>
+#include <asm/mmu.h>
 #include <asm/pgtable-prot.h>
 #include <asm/set_memory.h>
 #include <asm/tlbflush.h>
@@ -80,8 +81,9 @@ static int change_memory_common(unsigned long addr, int numpages,
 	unsigned long start = addr;
 	unsigned long size = PAGE_SIZE * numpages;
 	unsigned long end = start + size;
+	unsigned long l_start;
 	struct vm_struct *area;
-	int i;
+	int i, ret;
 
 	if (!PAGE_ALIGNED(addr)) {
 		start &= PAGE_MASK;
@@ -118,7 +120,12 @@ static int change_memory_common(unsigned long addr, int numpages,
 	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
 			    pgprot_val(clear_mask) == PTE_RDONLY)) {
 		for (i = 0; i < area->nr_pages; i++) {
-			__change_memory_common((u64)page_address(area->pages[i]),
+			l_start = (u64)page_address(area->pages[i]);
+			ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
+			if (WARN_ON_ONCE(ret))
+				return ret;
+
+			__change_memory_common(l_start,
 					       PAGE_SIZE, set_mask, clear_mask);
 		}
 	}
@@ -174,6 +181,9 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
+	unsigned long l_start;
+	int ret;
+
 	struct page_change_data data = {
 		.set_mask = __pgprot(0),
 		.clear_mask = __pgprot(PTE_VALID),
@@ -182,13 +192,21 @@ int set_direct_map_invalid_noflush(struct page *page)
 	if (!can_set_direct_map())
 		return 0;
 
+	l_start = (unsigned long)page_address(page);
+	ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
 	return apply_to_page_range(&init_mm,
-				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+				   l_start, PAGE_SIZE, change_page_range,
+				   &data);
 }
 
 int set_direct_map_default_noflush(struct page *page)
 {
+	unsigned long l_start;
+	int ret;
+
 	struct page_change_data data = {
 		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
 		.clear_mask = __pgprot(PTE_RDONLY),
@@ -197,9 +215,14 @@ int set_direct_map_default_noflush(struct page *page)
 	if (!can_set_direct_map())
 		return 0;
 
+	l_start = (unsigned long)page_address(page);
+	ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
+	if (WARN_ON_ONCE(ret))
+		return ret;
+
 	return apply_to_page_range(&init_mm,
-				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+				   l_start, PAGE_SIZE, change_page_range,
+				   &data);
 }
 
 static int __set_memory_enc_dec(unsigned long addr,
-- 
2.47.1


