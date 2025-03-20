Return-Path: <linux-kernel+bounces-569892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D83A6A91C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B501A188E903
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BB01DF984;
	Thu, 20 Mar 2025 14:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ouC1/r1m"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF991DE4E9;
	Thu, 20 Mar 2025 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481825; cv=fail; b=Y8mgs4LGXT5A9hlRYWCVWbW6Zelpa+yg4H1BYvTu0xb3a31YMXCwBi4yRNOTIgnz58DSuf5DkC4wg//upgyW8aIHxrLgHIvRDw8tGJqKeb3zO+MBZPXy+QXO6KBepZAzaUmLSw4ldgtwr4khlBgwMOEdjVJDnxMmtrylYcJLjUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481825; c=relaxed/simple;
	bh=WOPcQzeD2zssJFAMdcwnaMz441qr+LntNNgRnALfIYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PKbFxyziW/l0v6Bm5921BKrKxbzlSDcmo5EPU8gP36CgA2sk3Gzn2XtDcw/ZRtRheGao0K4cRgRSadNa/NeLmdzR7+41S38kF/NAndSqtDJAZKR9Z2/CUpcPOaQPYGNqFKVrnpr8E3fk7mvLKzTP1N8pATdgzu7hsKuW7++2afs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ouC1/r1m; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5FBl7INbQyePOnb9yIayvWWKrVMXQKkBWeNPZF3ECOsfrtqtCU7r48qk0DABkPnYGHNP5GozqywhlzipYic92zizAD/3OJNKrtvP2ALE/nLjlPDUX0M91U2tdPPJMyBxPcmIO86bAg2jWPWmDFnzR3pInWxdx4x7dQXknynkBUpgTJDVAiPXBCEmNUEXokXEq02nAwfGtOYvP/Msfi2VESWU3n+GV25vzpyXdffQjsy+oF2CIohtMSCs16oFMsaDTd3HrnrZYJGVAk+GQKEcA1by54aw0p7fD4S9FjwY+hHv2HzemsWUa9c99vJvHG3PYGJWO06aZAPqnNjwO7LLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83ekTyWQ4jJ8gw4RW6jW9PfIubf3Wvsxg9T37hoaGt0=;
 b=Kfpg0CS6LK+Q7mHZokd5bcl6rNn3viKC9KkNI/zg2GU55vU+oNHmqTEoTCLKLZgPy6HDVKMPkiLxH623n9u2oKsQ6ncAcVfu5D04QXbutHrtYGmeXl+Mf3zuQBmBdcG+UAEauaeTtYwj9x4O8hxx/JcX1/egtfh1bElldv8/Cl8MJ0gcKOiSMDAThTSYSoEsC1yL/LFhREZc8fAmWz0/9jr0wkWc8fsa+ddIbDnLtiTTYL/k+KWw7dfySHJIPI9dRq79HKsuQKnOcXZrFE4V/rj6F+tN+47Ts/FMbpOHcWamLpa9HgZId7ZNgSvGiXTTOEmdPhW+71aVlcdqVP9Ezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83ekTyWQ4jJ8gw4RW6jW9PfIubf3Wvsxg9T37hoaGt0=;
 b=ouC1/r1mqWuYAU/WTdT2ZsmPp4lCqAlqx4c27vf9uoh2JCZ4D7fwrP5EDew2dcmB0Rqo6oN/s3Xx7fnEuBSubJZoFr/Ut2ENzgx037Jbaxd4GORUgk0RswMH1guMjJRoW3JzeO2f2qHTxqcmmOlezkYADYgcd2EfEyi7OUcduSaKIHisbk+Nz2yYjZF/XOkGWEn3L9lT+8KOXTs+1TIrcJVPxesGh1nG4lBzH4o8J3u70UQQXrdJ5gw1bsPY3hVGP3HNAGde1uz2Cf8Kn/EknRaQtFfM/eKzpxtPq+jirKUKqfR2bGqgC0dNO62Cmbb6s/mLGeiwYagz3ZHQsdcPKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 14:43:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 14:43:40 +0000
Date: Thu, 20 Mar 2025 11:43:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, jgowans@amazon.com
Subject: Re: [RFC v1 1/3] luo: Live Update Orchestrator
Message-ID: <20250320144338.GW9311@nvidia.com>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
 <20250320024011.2995837-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320024011.2995837-2-pasha.tatashin@soleen.com>
X-ClientProxiedBy: MN2PR01CA0042.prod.exchangelabs.com (2603:10b6:208:23f::11)
 To CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: b60cac7d-386a-461b-6747-08dd67bd9af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+LVjDCkiCILzumIN2xM+6Pyn0F9uRXZHAJVBb8iyVAaQ8FmfQQe1SeOmjmfZ?=
 =?us-ascii?Q?V5F5lxH7Svmk2a6CS73EIegZKRdHn2CA+C/fEpXlLumJ5weL7T/ovcJZ/d8W?=
 =?us-ascii?Q?uOqBvU8bRE25yGHPx2mt0z2mT0T7rMRzXSS0LU6mkSN4R4nIylis/INg4Sdz?=
 =?us-ascii?Q?UaB9Rf4Wmzc1BA/DeEXPjtVp9bz87U1d27D/X6lBsoK0Q4Hs6A8HOONWW+dl?=
 =?us-ascii?Q?nQVrwfwodimrGiqGNo9+x6kOQpl7i1ERdvvZpgWXSi/ntqf0PYlu9yFI0yuE?=
 =?us-ascii?Q?7aRYwb56nx7E0cIjzvLdWALND5XEkgQwJjOrbPPzAAeJFOeu1x0rmNCIF9Yp?=
 =?us-ascii?Q?+1wED+2/1b4d/2sQlXs+mirU72YfX51cJ+ws+/BUYuHmf1S8YNgHJt2VSle2?=
 =?us-ascii?Q?0u67Ot71yPMkupyJZ3ih8WpF0t69GetDx2hJbI7BcKWcBG7EWjCl1aTGvk/N?=
 =?us-ascii?Q?VIfvfYBCI+dgxBY2Xz90LECuZ+Mx2TPxru8tgosbkxfo9wX9/Z+1zxrsL6Nw?=
 =?us-ascii?Q?7n6uNWmGluIwqjrm8P85ljod8f4Kvh0EREPXlBp7tTyvD7qVFHNlDhNNFScm?=
 =?us-ascii?Q?qB8x5hPxHrBUkExH36hERjSQShh6UswcSwNM/RWlsn8rXwilAVXMlQqDxU4M?=
 =?us-ascii?Q?Lw4s3sA1JdoKyXpEysu2P1MXTTMmzZpK1fEY7rbWVrbjvnxwyB5U7+MqEFjP?=
 =?us-ascii?Q?SgYoMwk935bvIwvKQmsMrR1/eR3N0C/7oyv4mJytslt0mHvbMAIsM4ellqb2?=
 =?us-ascii?Q?XZRtWGuruI9FQTLQ5RbkxVZmXquUfjeOrz5s4kWB1x2yNk2LCR8VIK/Icykw?=
 =?us-ascii?Q?LureBgQfTNaxh/Du+6AWZI1ktSrjeD6j9jHEvlKddJWGsBUBqdGyOdYb2KGR?=
 =?us-ascii?Q?LhRmpqDJQs/wSYnu08AifQt0WVjmIHmcVSPfxeSjoywO0boW901TxqCRNanl?=
 =?us-ascii?Q?abIOxoxjY4dyMLk8g088OU8E/g3J9wTLwN8V6bg6tkfZm0lVmOKKzISs9wTf?=
 =?us-ascii?Q?gX2DRjx2RvLU9ID0mgrVRlMaWPzeiklzAkMUdNSQH/R0Iwz2XV6qp4MrUe6e?=
 =?us-ascii?Q?3LBUwgBUO8Q6i1CCtH/cK9fFPFZ//rH6Oo2W3SU89DGPpotIMsOOLCpMbZen?=
 =?us-ascii?Q?lLOG8WGXVIT4PGn32Q0tpOyn6XYpoNu4nznsuaxd0KwL+w0HZj36ShAQCg0S?=
 =?us-ascii?Q?uMSg4subWAIPH0DTMh3aJcd3zSdnbuhv6OZoq+Tk6jE3+GF29AJ2l2UBhgtQ?=
 =?us-ascii?Q?Eo5uoN1fugjyJHr9XBzHTS398aY+kPttuGiReMP+GxDs1kDwEZjkLmhELOIW?=
 =?us-ascii?Q?uiDwPue2o5QjlOn6eYamUUaJyGXK58qC4DRA6THp/pLg/B+oQjNudqVlZYCA?=
 =?us-ascii?Q?dRzBAZq2YXQbb4O3/hgCWrEFAbEH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJzr8Nudz+9/Kh02oIQeSmAWVcb9EIv6Q73+sceqRzq6JAX0TTnE81R8SOUI?=
 =?us-ascii?Q?P7eI/D2vgdNCsVjr0vGomnLBrNh1RUmWPZ9Ydp9D95hXYfE3SegjZckq67zM?=
 =?us-ascii?Q?coWhSMv8FpnrjYaO4UtucYxlQZMdMVNGhmKV7EsY70hW82F/ZrCjQA2yEa1T?=
 =?us-ascii?Q?gsI1qIKtchZAaMiNzLrsEpnN1okRU08Wco4f7sHL0DWaG13CAOsx4edaO4/0?=
 =?us-ascii?Q?q7CExpYaU0aIp7GCNMreMN31dPjul8i67pqJtmxyE5lWxJ6wPkdcpCSYuCtB?=
 =?us-ascii?Q?/0AacaltagIj2uGg1eL+P3nuQOAm5QynxPLqbYB2uzf+ZGsh7/B0H2HAax3h?=
 =?us-ascii?Q?KDiOHR/U16nNff69SBd9dILBwVM9Jx2VSS0w81BhTc2WCONP3H3/XGqe9S9i?=
 =?us-ascii?Q?lvGXo8akeZZ7BPXjoTjIZef1S/OMPVD+bmSW1CzFU1XMaY6IrZS0E/A4SAOr?=
 =?us-ascii?Q?kd+8RbXPVLaurhlKuUGkiSVnQcrjjSDzS0FivZl/TfeUd6CRivOAYKj4WeKr?=
 =?us-ascii?Q?AaQwqR0UvKb3wafLEwuMMIZuGGnxjGQX8OFjVSB3HNR7OZrBz3r3TcjofLYQ?=
 =?us-ascii?Q?fqu1s6/+syy3qRXuJ3XLpXqzVHzGa4LR6tVBOhh/uVUfMHrr1q7S1SfzzDwI?=
 =?us-ascii?Q?Q8mnHtYijqP5YGelWjIIP+dxx9gp+oXZZWnyq1RxvuUZyOKMcWNaE1eoGVb3?=
 =?us-ascii?Q?Paz1WBaIL0LHFqCpB0IK6amhXmfINQa0iPvpdy4H1fNEARdwXQLrrR8NRKWH?=
 =?us-ascii?Q?Uf0SfA5ndA+QkzRAZLpaTrdf8Ln921ZGHcVJI3hjldzwZPvA5Rt236lb/yry?=
 =?us-ascii?Q?xAD5kCnxOA4fj+4k/LHxsn6W36VgSxqXVnDKdbE1cJ6QDlpY1Y+oDqD9v7W0?=
 =?us-ascii?Q?5QpsggR/Mv7f4xsoxyWOgkI4F+OHDfREw1nL6XvQe96xpE3bi9wXPAdAhzZa?=
 =?us-ascii?Q?wiRmpXLogoYnAxkyxggBz3XKOPV95plKz3UTMPU2DWQ/qYu5Q0M8DW2X++h1?=
 =?us-ascii?Q?6PAOOv2Ju/Ll6HaHlL9oUiPHBUHPR8ndf3TcPkGME4b8qVYkv8bW9IDoEsFs?=
 =?us-ascii?Q?1VzeeDION+E8huO/bXsCvcHboPclW2DpEQCM4T6Sx7bYFeDJ+CIQ9gz/jKBk?=
 =?us-ascii?Q?egkybRzyg31CjZu95XjMbSCjlhZys199I3yCbdasXZgkUmpoI5VeOhgCQ71B?=
 =?us-ascii?Q?iHHwFO94NTQO+bUd5aPPJfnTC2LKuaq5TecY034vkOPfPD7WyZWl7lIpRiDS?=
 =?us-ascii?Q?5z2FP80Uy8PYHJiBFjgDVS79M7Um+7NIZsLWBIBb5sP4P8UrFtNv3B6W+y6u?=
 =?us-ascii?Q?Fd7JfJRcSsbYOjEe8Isz9vDRY2ksry8KzoyrvnKe3sHk4DXhk/JWKECk2MQL?=
 =?us-ascii?Q?Gc4GTJgVFI1P2oYqfdaQfoWsmSFKw4A+4ZvY5znT169qJSvj4nTysot5uD5z?=
 =?us-ascii?Q?+m3eI69Y9yEID9b2x8tqhOPAMwhvEuiDslZi9sxqQHl+gqWitQJ4rgh4LYtY?=
 =?us-ascii?Q?UsUAYrSlWk6EijoI8f3QjgR2M0nHBxHR9Xe4NAV7FwLxPUC6UqdjBS5dia/W?=
 =?us-ascii?Q?0JT/olxWHp77iuWkOWg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60cac7d-386a-461b-6747-08dd67bd9af1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 14:43:40.4396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MeGAPRvB6yf3gsj5kZjLwFE5VeDMGMp02gRwRm3Rw7QKpWupoRnBIqzrjGMNhi1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

On Thu, Mar 20, 2025 at 02:40:09AM +0000, Pasha Tatashin wrote:
> Introduces the Live Update Orchestrator (LUO), a new kernel subsystem
> designed to facilitate live updates. Live update is a method to reboot
> the kernel while attempting to keep selected devices alive across the
> reboot boundary, minimizing downtime.
> 
> The primary use case is cloud environments, allowing hypervisor updates
> without fully disrupting running virtual machines. VMs can be suspended
> while the hypervisor kernel reboots, and devices attached to these VM
> are kept operational by the LUO.
> 
> Features introduced:
> 
> - Core orchestration logic for managing the live update process.
> - A state machine (NORMAL, PREPARED, UPDATED, *_FAILED) to track
>   the progress of live updates.
> - Notifier chains for subsystems (device layer, interrupts, KVM, IOMMU,
>   etc.) to register callbacks for different live update events:
>     - LIVEUPDATE_PREPARE: Prepare for reboot (before blackout).
>     - LIVEUPDATE_REBOOT: Final serialization before kexec (blackout).
>     - LIVEUPDATE_FINISH: Cleanup after update (after blackout).
>     - LIVEUPDATE_CANCEL: Rollback actions on failure or user request.

I still don't think notifier chains are the right way to go about alot
of this, most if it should be driven off of the file descriptors and
fdbox, not through notification.

At the very least we should not be adding notifier chains without a
clear user of them, and I'm not convinced that the iommu driver or
vfio are those users at the moment.

I feel more like the iommu can be brought into the serialization
indirectly by putting an iommufd into a fdbox.

> - A sysfs interface (/sys/kernel/liveupdate/) for user-space control:
>     - `prepare`: Initiate preparation (write 1) or reset (write 0).
>     - `finish`: Finalize update in new kernel (write 1).
>     - `cancel`: Abort ongoing preparation or reboot (write 1).
>     - `reset`: Force state back to normal (write 1).
>     - `state`: Read-only view of the current LUO state.
>     - `enabled`: Read-only view of whether live update is enabled.

I also think we should give up on the sysfs. If fdbox is going forward
in a char dev direction then I think we should have two char devs
/dev/kho/serialize and /dev/kho/deserialize and run the whole thing
through that. The concepts shown in the fdbox patches should be merged
into the kho/serialize char dev as just a general architecture of open
the char dev, put stuff into it, then finalize and do the kexec.

It gives you more options to avoid things like notifiers and a very
clear "session" linked to a FD lifetime that encloses the
serialization effort. I think that will make error case cleanup easier
and the whole thing more maintainable. IMHO sysfs is not a great API
choice for something so complicated.

Also agree with Greg, I think this needs more thoughtful patch staging
with actual complete solutions. I think focusing on a progression of
demonstrable kexec preservation:
 - A simple KVM and the VM's backing memory in a memfd is perserved
 - A simple vfio-noiommu doing DMA to a preserved memfd, including not
   resetting the device (but with no iommu driver)
 - iommufd

This all builds on each other and introduces API along with concrete
and meaningful use cases.

I see alot of confusion in the various review comments in KHO work
that I think mis understands the scope of what would be brought into
this. It is not hundreds of FDs or hundreds of devices, but a very
very narrow and selective set that can work like this. Showing each
step along the way would help narrow the thinking.

Jason

