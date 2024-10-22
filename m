Return-Path: <linux-kernel+bounces-377003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA97D9AB8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8742E284B18
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2781CEE9F;
	Tue, 22 Oct 2024 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oy8EeyuQ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C811E7C10
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632840; cv=fail; b=OpW93EYhP3M4Hy6bkIVuYGGHUZgppa15bjmUBNWP5RfJKmaeFG4FLDEUmkvaE8T8lqlfUzuv+j1nhd+j4JolfTtgpjGgXsAwKZhnhNEUHZoOro8E47Odw1ivmKq/3ded4EmRV4rAmaw5rIkVBErbOmgD8378F0RBtBpKOPEpvn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632840; c=relaxed/simple;
	bh=EwAf7eoP52feLdT/+HqVpMJunz2bxchVQ3A4uGbWSi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=htHxNtCTsmxCokmWBWxnlKXzeNNOuOJHfiLap2qWNnJXpOXeZc2yQ917+HKaGZ9EHxYeHaqqSB+WQM7ROqV8a76Ju2ciYn9EJfvHssjMknYQeny/ytGfgzPo24/MrP8EPUU5P3EZvFdS9Ej3FiRMBc7f27wyAo5W2X0FZJDwtBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oy8EeyuQ; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvrGAnREFsWoQHDLDgCvCqtl/6l8kWAcXEOV8Rmw51r0QqILGO/XQhpFYF2CqZei9gqD1ohpybWCl+RXA5npgOmqnu9Uqi6aDZSR205xyQ6a9n+ZWAK6JjiSa2yJ2CHxjabPApMoOd7bEqKtf9lKARzR3o4B6aCDFxmDh4gISChp337UWNZqCGFdgVv4/rQdSs0UJykTv/4jHPfuDa2DjYlWAavu1/UN1yJwyefxPSgYKhbq0+gGi/5A6yxHKpAnlTQaEVF7Ek7j695rdbioGWYC4zLUzf8tmJgNg1dh2ElRRmHHMJZMYziCDTMFLTV03+vsQB+8vkzoXQRF8Jc7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLQ9Bt7ZKTvhl3/u5pk4ruQ/NvtTyNftdAscDr4cQHo=;
 b=PLK4A0CkG1Tme6xypUp1ZyRAMKTpE/xDAU5zQw2ALndw+4QXNLlpsLjH2GHeBAFfiuquwwZwJwEDvhrX1uaOph3WZcOKSsGQcb2+w4br3s4moPOzYuzmqLQu3K+1LF7iSXusevVeKpaIRXWaKStmFvM+OFciw+gRgneViHahR7K/x1l1HsZGxxAYH9Z73gCCzawYoKh2rJ0maEckZvWK0JAb02eSk5xklzh0GMsoSkzkscZbGc6hrgSNB7mI7zHTwYhrRHgwpOsvuxanvOXSVo4nT5ZyOIQVhpxgySRp98Kd2g92dPcM11BjHkGegSMrPCED4zzen5L+QYSJY4v9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLQ9Bt7ZKTvhl3/u5pk4ruQ/NvtTyNftdAscDr4cQHo=;
 b=oy8EeyuQlyjVEcSoaXmFHEfLn9TPatrbCkx2n1uyhefYh/d0/K99ajYyw873W9rDkoHu9lc1J2rTwKAz4APDhQFkZM7/uFd3RznvSLjmS+Do3kXXVRRRb5dIsLTUQlu65RwhwUYyBb4ZJWo5xcTLO3A0DkSZ7zP5+ySXdK5oHgfZUwjihjG5Iv9eccmhWf6z5ibayQIf1qJNf9jmim6YhZaYmWA23dSeMW+9J1wZJg8yCfABLNpxbQD7NQDid9jU3gdoEjLf4nMr1GZkD+x68r0idsCBVNoPcOWUvzANFuYUCnh8J43Lvc36r8bdVK6M+3teQ+3Alses1oAMzqGjmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 21:33:56 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 21:33:55 +0000
Date: Tue, 22 Oct 2024 23:33:50 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Introduce LLC awareness to the default
 idle selection policy
Message-ID: <ZxgaPqZNtouBcXHa@gpd3>
References: <20241022101422.212810-1-arighi@nvidia.com>
 <Zxe89zvC5uhI7ZxG@gpd3>
 <Zxf4-DewpSO8Lcsg@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxf4-DewpSO8Lcsg@slm.duckdns.org>
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH3PR12MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f4e9c8-c973-41c8-9a74-08dcf2e13b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RvxpFuyh6EV1vHufciqE3n8nT2i2l3RdgHCErxlajbbImo1uXaN0UBCKJYTe?=
 =?us-ascii?Q?5uErD4R41UvienDBGlIkE8RZ6JTdog2GpW/tNr13TOfayp0dYl9uRDCBT+BR?=
 =?us-ascii?Q?etT2Vn5cK8TYBluPXxWRE+qofFKF7N83kfRL3CPGxsTqX2IZkMLEn9pYhnff?=
 =?us-ascii?Q?GLKn0ow1nTBuhcMgfwA+aibgRJOWBe9zcEsmXNCDZ1bfWpqawLA4A6Xx/cy1?=
 =?us-ascii?Q?9JigHWdzbwP3zL5E8OzHspbJVQ/hdri4aRUSGRjgdAaLoAY/j4HJXeyEiZin?=
 =?us-ascii?Q?I7XvZ0H0SHS/SG5Jl8vXQ6CI40OZno3HpGo7hZXY09wmUvIoPJN43YMeGn4K?=
 =?us-ascii?Q?bpc0UJSKdy7z2d6QrF7IH1ZRAgQWVcSmEfgiGIWdHFXMX1TdZ5vqlkgmtYqw?=
 =?us-ascii?Q?MwUQ8p96i/+cipuUYhfPJx63WUEyF3iLA/6FvlL6fyA2WagjGFNL6f+MDXiW?=
 =?us-ascii?Q?CyWU8WOKBjKgD3aLAFiWuXBLqqkqk0DmeO0f02cP7i6QsVtN+UDWRcc96bC5?=
 =?us-ascii?Q?TIjNsEwf8ReettxGQ6PXEl6ASvAejkYSdHu6P8mNFs+1jZycjWyMpgdoVes/?=
 =?us-ascii?Q?mRIxGJLIUdSvlCynsSmhXZHGpCOWjbBM93B0OF8nr7ArQEOE3Odp/2rwpq1y?=
 =?us-ascii?Q?ScMUC2/h96S4K6IeVglRHcZb3zHeyVTFIyv5ARuRdoQ+Cp630bKI4PjiK2e/?=
 =?us-ascii?Q?jq55TQSsuFzu1Jdb2tDWfzkuSzLHEq3n3N6v6HtEXJHihOOQ4bRRz4px9wfM?=
 =?us-ascii?Q?fgKerVc6r6kNRAhwZVqh8/BqwmRWBhUGSdQwpO069PqRe6yux8G2RIyib+H5?=
 =?us-ascii?Q?XsnuYXmxURh/+SBUQHCQLtmHT162d0c0O00DMdHTpWdvCNOxlWakrrrswsVc?=
 =?us-ascii?Q?AYK2yBAi/bzwmSrpCjoASXk8DVbMuHYkni8H2wNhbQpZTBLyBrWicFiOp01P?=
 =?us-ascii?Q?vcw7HmSDjP9iG5ZDxKI9nJLgJfcRuBvxxZr1sBuzSjwY1SmDBK6IgmVfyRPR?=
 =?us-ascii?Q?mA2uj1An0WEUxRuwilTEsqdX2JcEPTIVYcBT28VMDk1L5uB/FpV+AVnc8E/m?=
 =?us-ascii?Q?M2G3J35AUNaloTlV/pRBcDXNxo45hX9Ektj6yRpmySAUm7KPod+7hy9w8eWQ?=
 =?us-ascii?Q?JL7NzXxMU46nIEJRbt36zZxkygOKlTqoOh6hqqz+4rfva7jZUmO69sBz0vlN?=
 =?us-ascii?Q?cE139BAmOSqE2YEhO5Y+4Nn8T1dxkPlfwp6qLrTWgpqeJF2hJzMx5+KqMRYu?=
 =?us-ascii?Q?QkoBYkeTVr6PyOCeZHJRKCr/jGaqmpG3u1Ng5lyyMIqYNsqLMsFlCYchno7M?=
 =?us-ascii?Q?vnmGUshpoxZ2KEQBO8ZPqV8k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mNwWhCaM+fMgeLRzlV9nW4xBGZmXSqQMMofME1DCEw033S2onnmqZjCQKwz6?=
 =?us-ascii?Q?wFLdDMuIQr7ZzL0TpnPi4vjJORU2WE40n1Ki4MG4yXvAvELUWNAH9wUC7wh1?=
 =?us-ascii?Q?x4dEeD0uS67JXRRGnq+pn/1Aqo/YCSf6EJSK5tqgJoewrz2qeHFNwWYyF0xj?=
 =?us-ascii?Q?0+2qPb81jgcRJcMyI9557KoRscyJlCif0vz05PrxGN5zTAf2+LYtPUrqUkdx?=
 =?us-ascii?Q?NumO9DOn1/eCB1LTFSGv+QVONeHDelgkfqlXJloRa3aA77a8+K6AlO3jGSYt?=
 =?us-ascii?Q?4YyHZ3dBxOe5uM/abEtRKEAGGuulpoENc/VbPROKVy1EwWMNew3EX+UHDOLb?=
 =?us-ascii?Q?MlOloWE2eu2pncnKXRStLusvQrJTZg12XrQSZ7OLAFCcwJOwKbLfHscxxrky?=
 =?us-ascii?Q?QJNTofbVXdHxWyV8129FZohoXTDVcwSqTVBLnC2mhZE97q6zZF0tmt6Tkirl?=
 =?us-ascii?Q?OnduiH5HYgOswWSSe6MhDifuudAdPmlXuktPYb7yJp0xthN6BBXmV+S6YCFf?=
 =?us-ascii?Q?DhHfqAjkRYJLx9eVVWoW0iVi95B4FSutg17ggB64PRZkSsEokdm3naVY3Mch?=
 =?us-ascii?Q?B9KZT40FPDsHKaQbiuKPe6oMcMmlhg7b9SdZKKRCRMBJRgxhq2CSaThF/mDc?=
 =?us-ascii?Q?2kXWP+bboUcc/MLc2PaEUaUQTuJihSbqCNMiEPOIriBzWBJfZ/PupaU7V0Tq?=
 =?us-ascii?Q?0tArkBOJ/ZIh9Hy7E1Z0N6Yq5x5mDRH+T04pP4s59ISdTxGpnejfH3wXFjx2?=
 =?us-ascii?Q?0vRVtSbcU180BqatgEwy6VG/Lr4iPfrt4Yc41dVhg0zzzrweybsTNUKthuU8?=
 =?us-ascii?Q?DqMdoPxro6isVx6VMhxjcYiJTCPG6B+OWJXfDiyHTvQADHXPDPtvU0a/9Rkk?=
 =?us-ascii?Q?k5xV62SJVe9RLTsz8lfRLNBaY7ZT6T8xwJ++LG4nZJWgRKqM99kiJYdSKV6q?=
 =?us-ascii?Q?NLLCktvuiTWMEqlc8TMHDWoEVzv62zT91uXRrtrtsdKNvRdKMdWPF2usGBlO?=
 =?us-ascii?Q?r4iJEJUakeRiwX/ioURjz/O4v3WjGEfwGmpKDt/q1hc4YYZNg71asxGDoAcd?=
 =?us-ascii?Q?f3Pa/7lz2Y2ceHftTFFKvstx8PknyXo/QqDbMsqnwOEmnkRdFBR77KuEHFc5?=
 =?us-ascii?Q?Dr4LanQkEmxrckqUDBwTn+8PDW7HaHzFl6rkSDo7t2WzDHdyj83lYzqE8zgU?=
 =?us-ascii?Q?mekQTXiuI8CGWNUKtcqv/veID8pJV/6FTsJbrNAXtOD1VKXa+l92J7PMDoeX?=
 =?us-ascii?Q?YOvWycCjrlS62tp4FGa3e151WT768fwmxviWJvkfD+OzLlkloRlFXbkB7zs+?=
 =?us-ascii?Q?dB3lvl5iWpx4N9KBObvlpfo38OCcC2bmmaWHqpkJVQCmF77Q03x3xV+HuJDP?=
 =?us-ascii?Q?2xxDEfOWJTg+dKgxv/CAf35fwE2VtP65PQ9uYhVO/Kcma2EU1Z0kXAVPO5lC?=
 =?us-ascii?Q?bS07iDn/ur2lVAfdjgvuFOhAaAGCwsQ90C8CUP4FRrUWWGqoCacp7LrgZpUn?=
 =?us-ascii?Q?WiNTuLaXbLLR+L2j46hVKkKG/qycKlKmmmPPs9RkAJnOAhAppbLAJ4Yhb6+u?=
 =?us-ascii?Q?VhtGOUZL1iR0kTRvLEtledgB0KM4sDnZI5h3lRoe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f4e9c8-c973-41c8-9a74-08dcf2e13b13
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 21:33:55.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxifESEhSF9v9tnv80bScuS3IKEvnY+nDnW451Ny5+3V20X7YlCaLhmxKswelRCCYSmpK3fTxiv3DBd9YgbdOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8583

On Tue, Oct 22, 2024 at 09:11:52AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Tue, Oct 22, 2024 at 04:55:51PM +0200, Andrea Righi wrote:
> ...
> > Thinking more about this, we can avoid re-generating the llc_cpus
> > cpumask when the task can run on all CPUs (likely the majority of the
> > cases) and it's probably more efficient to check for
> > cpumask_equal(p->cpus_ptr, cpu_possible_mask) and just use llc_mask in
> > this case.
> 
> At the simplest, we can just skip llc-aware idle picking if not all CPUs are
> allowed. Also, it's probably cheaper to test p->nr_cpus_allowed than testing
> cpus_ptr.

That's probably the easiest and most efficient way, at the end if you're
restricting the CPU affinity from user-space, then you can just set the
LLC affinity as well. In this way we can completely get rid of the
cpumask_and() and just use sd->span directly. And rely on
p->nr_cpus_allowed to detect when the task is allowed to run on all
CPUs (and receive the LLC awareness optimization).

> 
> > We could also optimize tasks that can only run on 1 CPU, but we never
> > call ops.select_cpu() for them, they're just skipped in
> > select_task_rq(), so I'm not sure if we should handle this special case
> > (maybe I can add a comment, to make it more clear).
> 
> Yeah, a comment can be helpful.

Ok, will add a comment.

Thanks,
-Andrea

