Return-Path: <linux-kernel+bounces-404219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E699C40FD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB96D282A86
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C06119E7F7;
	Mon, 11 Nov 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h6qFonHI"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015331E4A4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335554; cv=fail; b=bcX/0f/r/axQabgtK1+AjS7uwJCs6TAELMO8UvrmSSsTyJkllGJaYmxnUVO9+BliLgG0o5/oiDFbhsciJ+aYVcgzEgwJ+9wJ9ESGDwweceQLPl0+P5esjD9+ICIYbN8DdvfQLtCU4S3JWzKyh67NWcjTtYwqM2/mI2piTWlRV7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335554; c=relaxed/simple;
	bh=UhHgHdkftgP1p1oyUEgQxv4eyhzLenEiz1cGd8quN30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tmRgobMN6jn2euoq9zVenMJrT8W3QY1cCDx8TvGlzAYN+zJcEMXNghYVNEytsdfQxW3bEpMwV5nhQpDx2X5c+4q2njIRKND8Bh6uQNZdUKAFzWmG+8P/TPPTjeu0xit+FrU9gN6o5gem3JpI1ijFW5BbBs3FCfRUFgNm0+2Xglk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h6qFonHI; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwQhHb9qIBxLery+w92jywfy8jwSql/Da51M86hUoabeRAX78Xa3dqt9YA3oBhFynKlSdMRVVM/cTWr5NIY9h2/6epvv1dz/5PBTcFfmuuamG5koGdwC9LgWz8Ho1wnuYpgbb+3ZcLtXdZGP79PC6FdowOeci7BVNgLMR1XBbuezPWpw9Vg156yYKfibDbD+W6ByqrVa/dKSSZ3jtxfD11hl3RD/l4Qax20CDjcgCPRdpa0SkjCoQQzniCBUaJ+F9495Vd51PW7M7gsFWR1IbFGDBdcJwxARUsNEDQ+dq9KB8ts2e8xzQZ0JsAy9hOaLfj6k4KNmInI/TznI5LBrDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54T+haoTZukrVqiIybOg8+orerVibz+HLeXbjcQ19WY=;
 b=gM2+w1gszHNM30eoJLllO35yzNVCSOXIEkMApJN6VEDw/Q1B0nGQDFpUX706axFhK3DkWKbddBQTZIHNfV3uzC5rb14fIa1CNqnSa5EiGkGTamWsGWnYoKyAME9Zyp2+3u8kwaOhp9OIJF5ZASNYluP4vBxmImsc3ZWuhbUyJKc/QnhEvauBdO6g68rAayf06i5FJ1KwKyiBaRwnjrM/0yS0aPQfdKrPNpU6XgwkYbDaJbV4OCdbzFcNdriZKuvh+iRq0s/aG14qxGsm86ERbojGrIXNTD0S6vPW/lyKhptBzATXcmjjpYv/ICtZRIsLpe44+ClDyuBsGtMzLhdiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54T+haoTZukrVqiIybOg8+orerVibz+HLeXbjcQ19WY=;
 b=h6qFonHIk3BJf/PF9Jj+QR8922J78HJgR+ZaCnWR7Wh38nGM7Hhp0s23tWxStm8X7f4AcxxfUlaRmieT6WV3CqEbcV4QCmEik15fCsMwJ3tXGsW4oUAflghdUrf+pFBAAM5/eu9w0JXTc+Zk+j+6vfkAqXofpYqS5FdeogjL0Lg+Zf3YIu0WTaJdxcN7FcyNqSLsjIpu/Yx9tk/AyCpBJxqCwyOh6C7byTqNdOUYCb6fdmSeVgfDqwJbyptVSSCsE36oMV8L74uizZZPPLiKO7PLk+payFoEIWr/AKXW/37g8IwXhtDbYSm7xTlHgEM/Ba8fqn2FR6nmvBniih2StA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 14:32:29 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 14:32:29 +0000
Date: Mon, 11 Nov 2024 15:32:24 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/topology: Correctly propagate NUMA flag to
 scheduling domains
Message-ID: <ZzIVeGbKjUQ5QnQB@gpd3>
References: <20241109145628.112617-1-arighi@nvidia.com>
 <20241111092246.GC22801@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111092246.GC22801@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: FR5P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::11) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bb61a0-e57e-40f9-4e6f-08dd025dabc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cEWZXDkXtjVd45v7SHuEwCTHEcHFeyveO81MJ5bNzXr7nqsNDZT3XWx64dNK?=
 =?us-ascii?Q?u/+vVR3J9+zLLW6Dv57O8zuqSbti0vulh2GlAmgae2XVCIJ4EgxnGmW1mCsU?=
 =?us-ascii?Q?aOoDKubb39eOoGw62VMt8glSLF5jFat+44M9hcuGDQpOj1AX9QOrSeIA6CDm?=
 =?us-ascii?Q?O5qkr/Vf8KQqQrqFPwVrEJdP0RP+av9Lm99GoW6+yA0x0WdUWHsIUP7EV6K+?=
 =?us-ascii?Q?qaSMz0iZsRJW4oxRxS8iGc6+KFuTiAMpWmFaRCerTXYctd9cdbgIb1smBVVH?=
 =?us-ascii?Q?/jZv3Yk6xnxrrDE7CQOrYm2BfiBeHFWydXMPYtE6OH+Ue4QYWMhX6DT8YkRD?=
 =?us-ascii?Q?Cx5m24Sfe4zzu7XLOHR0hYhdtnu3KKntWq8vxqYKOJnLIj5LcCwTcesYTS9h?=
 =?us-ascii?Q?sZXdZCsF26Cg11xxraG95Y3dYvZP06GmiljXJD1XNVmZoEGzaXCgqn7zcRTS?=
 =?us-ascii?Q?DgbZ09ELswFtRS3F+wxie8s7jhSxbPYlaNOWmwNgs19S8+MZkX9dqzXGMX54?=
 =?us-ascii?Q?X04i5ws8s9jqetqTffEVweGaXW1UJrjwDGjfIqgMdKxRmHQZuAeYFtKT+Ju6?=
 =?us-ascii?Q?BQYuvE1LR/DauqF8o5d+TFudRdQkdMshMQMCln2grmc4m1MiniBihWstwn98?=
 =?us-ascii?Q?U5JpBBBHi7oeRhkp0KHRxtRhclj2RqFNY1stykxsH9JyTO9o7wdLYW0N57xy?=
 =?us-ascii?Q?GVZT+ZsJebBZjqWee4T5LuhUXoHBkd6YDC6V+RKNGdnJ2+rdmI3i51NXBQ+Y?=
 =?us-ascii?Q?nnWsrhZy0Yr94/tiQJKyZDbJ6MJ7pm/hSdLKhOALyvHdGr0Yhu+7UU6bJBUc?=
 =?us-ascii?Q?/I4Lm6JHncKKo4TTBN1z+KluN8Yd09zqOLMapIy84UtMSH23TuiQnZET+IGe?=
 =?us-ascii?Q?pJV1vzI/e3dLAq7/zKLgVEmBxo2cvNtTmxp8kawwnwc090TXEt/E+IeVdZkH?=
 =?us-ascii?Q?/tCsgzM5bfXsiq192FQ9kLGAhkindOrwQ+rgqm6tmEVgP5AvewyUn8kO/RkJ?=
 =?us-ascii?Q?ZWKjae9Mmru8RBAfP8dg282hPmY1uSV9MNa0j+a4SJy4WLPIUmkfX85JCv9u?=
 =?us-ascii?Q?BGReu6mC01vVG+t3hBlNgXhXhmkJo9xyzpFYMNk9669eiDqGYWWfNR3yoca+?=
 =?us-ascii?Q?bQeIlFkqnfyCWC52ixmm+PRHwVwj8Y9bKm3I4rsQafdXl/dRPnRIo30VZiD0?=
 =?us-ascii?Q?hLQF8Tq6rWYlyot9XLRI8WRCONR4MeRlr2zYfk87q+JKyzdwsCEZYsD6qKuu?=
 =?us-ascii?Q?KJVRbQhRHxe6bIL9bXQUxCO6NuUJye/G60cAjD4h1zclIk4G7YKYNmoeYE2d?=
 =?us-ascii?Q?90oPaUPsB6MndwkpW1Itakb0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GKG0EHb3kiDavh1xYQgLhl4fS2shAWDuJ5ZXWq7VzK6dqBUm6A9E/iqZCVSA?=
 =?us-ascii?Q?HcXOpTuEkFh7gYGa490EL+MjP0vKh2kXclfl67cZn5YMAbLoytTyRDve+ACB?=
 =?us-ascii?Q?J2KsZgNv0C07uKScTHp+3RXx7BqxHLAE2p0IZUDRvZm0jzxuXrw/2dQu2D8r?=
 =?us-ascii?Q?DgV14dZ3nNSHI0OweK02r3axZ7kkwjF+0nKVPGZckQdCLLYENtDuReKa/PMR?=
 =?us-ascii?Q?VK+vqUUocoLmlpm5spl9Vgdx+QiKqt6dZ+bQ0OqwNScsmrWv2pnde8St9usW?=
 =?us-ascii?Q?05P6y54pzEbmUoZT9CdT/X8RTstK3YQOe4uwQNjW1twrT00l8EzG0hBv6lm0?=
 =?us-ascii?Q?4NNUHmkJLBBhc3CG0uscf6MkfHSjbG50iSXTyVfly4oCK7IeItmfyL5VQWMQ?=
 =?us-ascii?Q?6STkMt8hdt4/GG5e+KrNgOlCDEL4OfCm8XopsgoDHOuYS88SX7bDOEYgoLqM?=
 =?us-ascii?Q?6aQ7JiBDEQVLf3wIbjKNvD83b2rMqVSnM2dPbRnvJaOcYrZrs18P01+nLUli?=
 =?us-ascii?Q?ZQ1M1/THMWM8+tqnoyYPRiSLEPYnbQFbqi3L4FNAk4/awlDGpFdYo4a2JBUy?=
 =?us-ascii?Q?UvSBRYCC77GzYGSfXEvWW59StortjabWfUnfsj9bciTI6lVCqVsyZvwugHy1?=
 =?us-ascii?Q?gcvTw31nH19V6gG9eRXxS2exTzQ3ocJ2cl9E40nhZ+g1B7zgEOtg3/DFbvSV?=
 =?us-ascii?Q?X3AgIjIGbFjp2Ny03CPOrbY/cThYXeoe99GkbWK29esaDmfAPIzrhJbrq6HI?=
 =?us-ascii?Q?i4blCuBfdhI5t08Hhq6UTUu88Z8U66X/fQYbkiuHXjZKqvHTZ1UnNt6jLWLH?=
 =?us-ascii?Q?lmQ6gKN/G7Pwc/krZSUxyr2JGWmiWh75arB5OZ2a3AlvQteUGY3t7KrLpBi0?=
 =?us-ascii?Q?YW40hRC1Mi7cBFXWBfOfWLs9WEQLu4hDTMmb9gqX2cAoOM1SVweXEFuZuViR?=
 =?us-ascii?Q?+ODtRUMBVX5LEA3jxJ/6hN24G5abAROGEVMP2q0KKEUXV+HttdYnLBK8enN2?=
 =?us-ascii?Q?EBt3vK5Ay/sYkpjO2XnpRXhUDGDBphgbapFFxjCc9nScOlk77EFNGAIPbzPu?=
 =?us-ascii?Q?s4DPCwDFULFil272qEKA+trvwu+ZwspltOH9ZU3wryw49lJtv7nNODnX9xuV?=
 =?us-ascii?Q?5rwpgkoMrtGEr2v+8AMDnAMScRshQIBbYy/xRBZW9CWOO6TKXW8/OQ5isvt6?=
 =?us-ascii?Q?GfanqlLIt7f5oZ5W68Drv3ITb76o7GveY+0JYbqxySreWYz8eNbZx1gySa5b?=
 =?us-ascii?Q?/Ra7t8wY7oL+63T0gE8E2uoos+b5B0tdgFpA37j371X9x4AVDTgFPEyBQac7?=
 =?us-ascii?Q?1oz1qZSoLTPkXPN9CMIiHL4URpT4BYZsVZdNXI5gXOxBFKgys0SyR01oJIwg?=
 =?us-ascii?Q?9KdK1l1pDJr95eTGVv0koMb+gJLtbutV/10F7zc6PvUVYPFQUw+4fkhaHiFZ?=
 =?us-ascii?Q?9Wk+A99+o5sFuwGkxnUew/9babcqM+n5Ma/NAgsVZF3bYFgN9m0Hh26rEwmD?=
 =?us-ascii?Q?AO5A5+N84wcWZUFietruB7oCZAchR/wwf7pRG9766O+cjULWTWoEklVLbSsJ?=
 =?us-ascii?Q?BvBcpVxLrxJVWSsNfWrsPeiCzJOD/0eMxog4NNkN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bb61a0-e57e-40f9-4e6f-08dd025dabc0
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 14:32:29.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Nyc5/In92KznPqTqupWlAROnJPt0d3xZXUdjgIXzwUDLi5z1o8fC5JiWf/fqGKnREzhnf/I8z6ehpr3Tw6zdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768

Hi Peter,

On Mon, Nov 11, 2024 at 10:22:46AM +0100, Peter Zijlstra wrote:
> On Sat, Nov 09, 2024 at 03:56:28PM +0100, Andrea Righi wrote:
> 
> > @@ -1974,6 +1981,7 @@ void sched_init_numa(int offline_node)
> >  	 */
> >  	tl[i++] = (struct sched_domain_topology_level){
> >  		.mask = sd_numa_mask,
> > +		.sd_flags = cpu_numa_flags,
> >  		.numa_level = 0,
> >  		SD_INIT_NAME(NODE)
> >  	};
> 
> This doesn't seem right. This level is a single node, and IIRC we only
> expect SD_NUMA on cross-node domains.

Ah! This is the part that I was missing, thanks for clarifying it.
Basically I need to look at sd->groups of the SD_NUMA domain to figure
out the individual nodes.

Please ignore this patch then.

Thanks,
-Andrea

