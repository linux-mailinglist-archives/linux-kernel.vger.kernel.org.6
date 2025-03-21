Return-Path: <linux-kernel+bounces-572044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F38CA6C5C9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8582E1B60503
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D80123372F;
	Fri, 21 Mar 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C/cBIb7w"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08AF2356A0
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595335; cv=fail; b=TNC1oRHnJ21fh/N3Fwk52/LD4RgKUYOYRDRwtwKRA/2CcCxO97GO2Jt0OaPZUyoUdXq3G5g7yeG3bDFfHti2ttmccI3tsaee0RILDwXKVZDL4uBLiYB6RogQP3wL6AufjSZaEYaBxCdVJBDwh7SGQqEfuQIrgQFpuKaOwvv2cgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595335; c=relaxed/simple;
	bh=oL8zJvICipkWzywPC0I4qiDnvaUh2fpG2qX/5sfcwRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUJAV3hN0efSqHQDScZNzIUqsDzfH50sG5g7qAEkCLYMx5x2guZKezU6PRrcRFX1stmG9uHTLzRwXL3mg7XDI2NRTrmBZ71mIBZllUTECo3fHdOAiGj5xVOrtCHPraV0nhoN2NzMeIucc3P0W5QyVxsNryGgTkgcu03ACQnPlfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C/cBIb7w; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaovNTxDqdAB+b15ovYjYDc2NJIlHS5NBfXda2jGDGUwoA6l3f4G4l9YfBSIs6NcFiVfYEAhhksUncP965OnPY8HhyAb/RjmWGYtmOhII9DMPose0RotbmT+gbo4i271l9zxertTqmbsr3pwrSWADIpsXzFnHC4J4C+ULU7FabLbNa8PP/3jt0bQme1hiXVoNbVixKiPtlZtwiTyyR4rdT/FO4HU3T0aavkBLJB/UBdE5Tq+4tY/NKOZqdF43mMuN7uuIiN96ek+mTOT700nBhBcaQ3lq3nHZ4h7bdr2MUQypBDXiniNuInkeisL1cGGChqb3LyAztsR50xDztN5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWukKYLx6dxV9P9+y9+WKEyqygay+dBRvMUc0FVjWo8=;
 b=pNbrfmdZpIKz3LZEXlIGHsTKaE5Di8V3h7w48ZvR4A5j9gKMnZwg8jYMIxdhL+B5yl6BXTlWiLdkSo20u+uWrIBNyPqFO7lNFbc8EaN5nZZCJfuQ2sh+3dT1XO8dYmHVD4BxoTN1Z8mCnerANNE0CrqNSzVguXYR4cRf2FN8xYenJV6sRyVwJxBCoCdwPewyaZO+6H+MSHD3lGh7+fqpfqm4Hvy6z9Vr8rqlGHuWtFgPG6nhCnCgxXZqM3NtnWXp1fCN+G5RQq38lNqG0r1i4yoibE4jZQCqpgiP1Ul3X9DJY5lIoFase/XRSrz0EMVxqG2C2fQI/tRIAqKj+PIl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWukKYLx6dxV9P9+y9+WKEyqygay+dBRvMUc0FVjWo8=;
 b=C/cBIb7wMs+C7LWUW3rYyAZpKeDWPnp1/x5/mPUuEkLJhG06HMOC93qbuU/6OR5rzQpPnE10z+cM19m+8hQkTS0/0vvM+kCYgMLQkZy2qKs+QOG1Mqxz4rnh3QyOD1wdaB6iq2zMozAncydLWxMUL/lXzqVzHEHF/CZFt63ML+E2O+g2NUub9DQgNqwrEIDHdlOHlVQwNUKPF6XYKSOASTn+MDFk/qvmPv8VR7C0Elq4RcN60yr9NvBWBajswUZbZSvqEXuTkFg/AU4VHQS8DoumFpsOpjgpxfivZ4tVEJMrJ4h22pxxC7FzZyVOGvG2o8QHA3EBdyO9fvE5W4iSCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 22:15:31 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:15:31 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] sched_ext: idle: Introduce scx_bpf_select_cpu_and()
Date: Fri, 21 Mar 2025 23:10:50 +0100
Message-ID: <20250321221454.298202-5-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321221454.298202-1-arighi@nvidia.com>
References: <20250321221454.298202-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0107.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::22) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 94558667-d2b5-409d-f983-08dd68c5e4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mMaDU4NABpddhO2U8gcWvrZlthLUBTcmXk1HgE85XYX8pf9nrP7GOUoj4qFF?=
 =?us-ascii?Q?ncDvoOFToEEBpxDMs/8cfQr88TCt8oD/h+cO/I8rFF1ZQeugIFuXsm/vEAtN?=
 =?us-ascii?Q?QSAllB2y/StqLPLNpzOwLGNhtDn+AczDjLjbJv98iRiS8F6wcog5KYuMbDPW?=
 =?us-ascii?Q?wDrshn1Eqs95PN+TD4+DgYmfYQ7TiOtcviRJTluBevZK2LeVx+gqKld3/TVs?=
 =?us-ascii?Q?Y+POlTV6pxCTfGs5JlX3zDSSHjeC+vM3pQ4CMXyMurQWBl1qiNpYivxi1hhb?=
 =?us-ascii?Q?GuSSnUf1qDHepxPcjaP2N+ggHVf4bmwIk5T2HaAdusXd4Fuv6Ds3tQBTJa4b?=
 =?us-ascii?Q?DsKm4QEAEB86pSZgz26kbFRTpBcbWvSgA1JF7LN7v1Hz4CeYaCfDuiAs85/b?=
 =?us-ascii?Q?L2s8sy5clAgC+KpqnquoaVxXFxrukpDQag/wEcF1ma4NIMf0o2JSxns3ybN2?=
 =?us-ascii?Q?qBG8Nt37LvX2+35bXy98GYx/DG6sLf8RVAELRJzWpHbn8r+iWAlWUvg1bs7m?=
 =?us-ascii?Q?MtBiTD3JHX0sCDT1Drx4+/0dVZVDcSCDOFNvzfn5mTS/LjfnVCxmmGeO2C7J?=
 =?us-ascii?Q?CE21eZxQ53W3VGIl1rgDQf55hBKmk10Kx9fgqM2VtLDpvMBY3tANwRCxZN+2?=
 =?us-ascii?Q?BvdT7JlP8KSMNV0AFp13LYvLkJXGXoOlnUVBFfF1WDP+gFND5Y4PE1bwXHOI?=
 =?us-ascii?Q?M2nmAiDxOHxRMQkX5a0a+sh2HXKBI/hESzHBRxw/i57iPR4jV9t9pZH2F/cs?=
 =?us-ascii?Q?Bm3xgwA+KU4vTKzyIo+80+4DSlgsIvGDBvHmmT5U/twV/M0tesyvj8p4aBRc?=
 =?us-ascii?Q?0Mh1gQfYxA24c4QYZ9/vvJwwj2+82vEPw6ljgtDSsJHlB5Dl4orixyogpUqL?=
 =?us-ascii?Q?n4DH7z9G81UO28drudlbhnRvaR9Wc/XA6Q0AgX8CIAJiHE+nt3kFUtg9DlOJ?=
 =?us-ascii?Q?U9H3E4tx804BoEbIAn9fOTIx3+G9Cu9hwyP7pjMR+PyVLaA7/qWv+P/69e+i?=
 =?us-ascii?Q?jbgmBlD+xcqqVTug9CfCNQmyXCRDNE3Iqdusd5ParFeqf9wo/50MEoatBalu?=
 =?us-ascii?Q?mlflz1xrYc5ETVDYeyuxgmGaGkeebaOg2Ib4GXRxLGSp5dGdw6vmFDmRU6Jj?=
 =?us-ascii?Q?HcFlQWVgS24TpjkPCAM1uGlxldrXIDUj3gSKesIU5vVVEJZDtrXKcH2yYjCj?=
 =?us-ascii?Q?vJnUXKNbrOq+RUsWncRtFYVfyXGtVOSdxRIxO6IwpqgAW3Cuu0gBL0pvKo50?=
 =?us-ascii?Q?ON51IPZCHc0gBGR8uOQruZUuLo7GDt3wX4iLj+p/6/xK+Td4Uybww+HUgnsa?=
 =?us-ascii?Q?oToJn3dI4CLpOczTO/b1m5ZXZfu488RoOcylbPYn9sFBmXR0F2EVA9zKvswI?=
 =?us-ascii?Q?D5pki59BptyE6ock0pNFvyI/e7vxlmd7CUlnkLx03x+3cNyC2Jk8DyNl8PYC?=
 =?us-ascii?Q?IhdBEcVxoqc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zXJMTRCBehYTJzCMhG6DYabfu5vBaRjTJFNxxBBNoGGJFufdp/dxKECT1NoC?=
 =?us-ascii?Q?YHDEHeiglrJx8kjh0L9abWjDRMA4M81apNQjNzNbhRkcoqP8B1O5DwHYx+8U?=
 =?us-ascii?Q?ttR9vOexbX6pCCq066cH3r9qpD6rxj+/tT2wkJDh4LwFGT7WICbwGgzpLgdR?=
 =?us-ascii?Q?oAMMIyCZe7v0dsxnCAD5InFegh1oYzTwaLKIYBzV9+0cOE9ZHaj8uZBXBzM8?=
 =?us-ascii?Q?yq9INDI+Yu9RUA2/a2YofRk6OJRhzMa32nZjBFBeJ9yflpVd0MKg6LFSz4jb?=
 =?us-ascii?Q?z4UhNAiJu869pAdesdry8llAkqXhOlMU10uhf00oNhVMgBECDbgQIajTso8P?=
 =?us-ascii?Q?sM+q72b7jwXlUjyBpafloHOmUHY446WvRnhnX97iDsfk41TEKfCEThwcS5Rn?=
 =?us-ascii?Q?9489mfGaCdtByovuZL6DznlL8VXLcbMxl99u+MzCy48W/ZgAuZS++UtYGmpv?=
 =?us-ascii?Q?iOl8DszucTAkSU86gx6FoG9D69YWWMTervxV+i2tFfJnBtpdY8oZcjYWxyrf?=
 =?us-ascii?Q?HHLkrl3+NftpItzbxFQ26H1hRBrcbZbczBSD3dpm13SmGrsdmI7rrrnUxNsW?=
 =?us-ascii?Q?espJtdeDOykRLPpfh/MlFdmcLcE6rKuyof524DRN89KshuqPGbafhu8+Kz6i?=
 =?us-ascii?Q?qR9BXWRXsOzCOyWpQa81H3ELh6GuYRY+Hyj23IqNUIQkAX/uoS6buAqlG4PL?=
 =?us-ascii?Q?KTatWQWPRLcO1t0M9I/1h3bqSHtRSLyx70UqbyPjom/rfXHqeJzf2zLAPjaF?=
 =?us-ascii?Q?Sk4rbaiejzvJkumY19OraBMhwV9VGqQaTD0ttbdhk3fU9ZqpA4IjEIH3YpoS?=
 =?us-ascii?Q?lx1racvsp8UXXJngoeCEe8GfB3h0eg7Tbo7PRDOP4Kh/yQBCdBN/dI2xovZ4?=
 =?us-ascii?Q?RNlTFcRxIBZXQLyzADTABsfNcUPnQlDCQdoNMtsWrcYHAFqmMp9W/97hs5rI?=
 =?us-ascii?Q?pCdz2uY1MeklxK7grKvkkz8G+AuUPv8wZtV4znxDeae++faVor5wuYW+HC3j?=
 =?us-ascii?Q?pS6q+sMDM7QFvq8MO0dxIyUsK4yHKYNYSAKuIdeKuIXp5zMpbpxVHmNl3DSj?=
 =?us-ascii?Q?dnOEn2/Wvg+UEhmRaFi6OY+Rn12bOqN3KlteGuoU08gwlo9aqdiz7kXMvcjR?=
 =?us-ascii?Q?D/RzrLmRdRK3ezXvg+BEoNNHDDEJZUnyDuhIPiyxTuqXMhMPKxNzpKLhaxYD?=
 =?us-ascii?Q?JGY9Htgif74cCrSGO8ryiARrvGjTTah++tO98aediFwwRxyevxD541JpCiGO?=
 =?us-ascii?Q?8um1cZlm2wS66tidMQ8scE0MRVHcGsQjwHGMcxXvfns6JwVRgqJlJRSVpyvY?=
 =?us-ascii?Q?VangxH1NY87HEcqDE3sXeSXHZt+wTCABLXOHDvcrWnxI0h0GUW6YAAwnuQ1r?=
 =?us-ascii?Q?TedE1wHHwyKZEZveO/uCSagandLvNl55hBwxZik3S3TqcgMTvhL9UJw43d+5?=
 =?us-ascii?Q?BHTaVvvtKT2PJX5x2M3HQgIgrdIGbqPNlsEj2DdPVCAe3Sa6qwW9fe/vOYT6?=
 =?us-ascii?Q?rZ0GSjRFP/6NAdtYF4CZm0D6ssGgHLCH1zJOMh577XaiG60tycz+qu8fBhh7?=
 =?us-ascii?Q?cFtTKcKesHYgVg9eb+TotunRLZxrtmhLHIxrnBtF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94558667-d2b5-409d-f983-08dd68c5e4cc
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:15:31.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VtnAb+SPPGmWYxQ7Qou6dVUsaJl9e4P/KAhAUk6p4buRl3qsO7HzAa2L3q7L21NLOmE2vyDIy8nVpSyU3a3Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Provide a new kfunc, scx_bpf_select_cpu_and(), that can be used to apply
the built-in idle CPU selection policy to a subset of allowed CPU.

This new helper is basically an extension of scx_bpf_select_cpu_dfl().
However, when an idle CPU can't be found, it returns a negative value
instead of @prev_cpu, aligning its behavior more closely with
scx_bpf_pick_idle_cpu().

It also accepts %SCX_PICK_IDLE_* flags, which can be used to enforce
strict selection to @prev_cpu's node (%SCX_PICK_IDLE_IN_NODE), or to
request only a full-idle SMT core (%SCX_PICK_IDLE_CORE), while applying
the built-in selection logic.

With this helper, BPF schedulers can apply the built-in idle CPU
selection policy restricted to any arbitrary subset of CPUs.

Example usage
=============

Possible usage in ops.select_cpu():

s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
		   s32 prev_cpu, u64 wake_flags)
{
	const struct cpumask *cpus = task_allowed_cpus(p) ?: p->cpus_ptr;
	s32 cpu;

	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, cpus, 0);
	if (cpu >= 0) {
		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
		return cpu;
	}

	return prev_cpu;
}

Results
=======

Load distribution on a 4 sockets, 4 cores per socket system, simulated
using virtme-ng, running a modified version of scx_bpfland that uses
scx_bpf_select_cpu_and() with 0xff00 as the allowed subset of CPUs:

 $ vng --cpu 16,sockets=4,cores=4,threads=1
 ...
 $ stress-ng -c 16
 ...
 $ htop
 ...
   0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
   1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
   2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
   3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
   4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
   5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
   6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
   7[                         0.0%]  15[||||||||||||||||||||||||100.0%]

With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across
all the available CPUs.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c                       |  1 +
 kernel/sched/ext_idle.c                  | 43 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  2 ++
 3 files changed, 46 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f42352e8d889e..343f066c1185d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -465,6 +465,7 @@ struct sched_ext_ops {
 	 * idle CPU tracking and the following helpers become unavailable:
 	 *
 	 * - scx_bpf_select_cpu_dfl()
+	 * - scx_bpf_select_cpu_and()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
 	 *
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index faed4f89f95e9..220e11cd0ab67 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -914,6 +914,48 @@ __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	return prev_cpu;
 }
 
+/**
+ * scx_bpf_select_cpu_and - Pick an idle CPU usable by task @p,
+ *			    prioritizing those in @cpus_allowed
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @cpus_allowed: cpumask of allowed CPUs
+ * @flags: %SCX_PICK_IDLE* flags
+ *
+ * Can only be called from ops.select_cpu() or ops.enqueue() if the
+ * built-in CPU selection is enabled: ops.update_idle() is missing or
+ * %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ *
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the selected idle CPU, which will be automatically awakened upon
+ * returning from ops.select_cpu() and can be used for direct dispatch, or
+ * a negative value if no idle CPU is available.
+ */
+__bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+				       const struct cpumask *cpus_allowed, u64 flags)
+{
+	s32 cpu;
+
+	if (!ops_cpu_valid(prev_cpu, NULL))
+		return -EINVAL;
+
+	if (!check_builtin_idle_enabled())
+		return -EBUSY;
+
+	if (!scx_kf_allowed(SCX_KF_SELECT_CPU | SCX_KF_ENQUEUE))
+		return -EPERM;
+
+#ifdef CONFIG_SMP
+	cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags, cpus_allowed, flags);
+#else
+	cpu = -EBUSY;
+#endif
+
+	return cpu;
+}
+
 /**
  * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
  * idle-tracking per-CPU cpumask of a target NUMA node.
@@ -1222,6 +1264,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_idle = {
 
 BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
 BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_select_cpu_and, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index dc4333d23189f..6f1da61cf7f17 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -48,6 +48,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
 s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
+s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
+			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
 void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vtime, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
-- 
2.48.1


