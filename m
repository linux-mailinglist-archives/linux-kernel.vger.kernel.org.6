Return-Path: <linux-kernel+bounces-574967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70109A6EC1A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D1F16CBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C311E9B06;
	Tue, 25 Mar 2025 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f1LnLMCX"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4F2F5B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893509; cv=fail; b=ouMFhY2oCsjkN8R3mrT6K2G02tB5XBCVEK3TZzuDCTSjLXnda6kClfd5xSlZ/IEIghKk9DXhZHhTqxUn/LSg/nFa4ljpEnb4iQc8mJmn95BuZiSZI3iJlyrxWL2scGLBNhI7MeHAYZbxCyvkDkk5YOFSjzvL5NsgLCj320CBiLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893509; c=relaxed/simple;
	bh=6qN+CQNxiUCWHOT3H60XYXkn1kSxVDSdZ4pdkhUEug4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ktSYUnCi8ndGx9ThyZVG+uYyYCN8kWOHo8S8NcBjX/MtmW08DqfvnCXO9IE0iqKx1cWoMxYC8VINFXyr0yzL4u28AkLgXql8yApP9GyQlW0d/pADsNyl4uv9ZIdwKr8CdeoCRsIrc6Qey8d1Wfsy6c/UQbRyiguQ7gXRnr47VVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f1LnLMCX; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qq2sXhP8qBMe9GGMVWSM0eapS0KEFYnE4qiPKGljQj37hBKUIxXRsNMjmwWYOa/XCA28ga/Ejhxi8Wn05dbNH6LpQGU2jtsVMf08WFm68eYWnEgb4GInLESCQlaOMuYFmWovkt2ig9698E8/3SqRZkknu5Gz4AeEN2E36K9Guo7F2rbVUv8WvzFyveR4CcxVjCzDsO15J+4FrbJgF3anO0Rh12ipN8AM0z7muraXxrVRqztd+qNUJXMCLnY4koZpL+pEWUAAqhGbUgiZhexwmthTCQkwmsG2I/r/5spquffDXDDBMtpWQ14uTS+uhSguIHSmal2SwtVqD5jDXK7vvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW2DIwSJgvSbuxwNims9tpKRcT9+Zs470lm+Ia8MzgM=;
 b=HUReAiaY/wkiHhSv/3QtSq34QavCBeTu80+H3hEgJbEbGBOIU6dEfFE347zmQu2nHKh8exeP5/1QaqXlphJ8wVWsKOQ5BwHXci2PEe6BNO1/0frM42BpTj957sAOygI6WKgiArJ8qg473GhQKSPFpocnH7aPWOSeJS53YklBXODtVwks8I6SxuDam/4yp82s5Zb9/AF0eJ/6/zeWpnNY4Bghal54SHdgmITjIp8jK+3cW3xmVxEt0HO09t24FlmEht2L7+T778qWh3n5nHZgNWQfEIKPP4PI3OJdLeXfTARuHgz+xtRy/C0xX+f1hZkixK5G+rDg26/927996H/SQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW2DIwSJgvSbuxwNims9tpKRcT9+Zs470lm+Ia8MzgM=;
 b=f1LnLMCXt5LuqN+YWxUGVuqwiHZBkE+MoVlu4iLjF789NIT009R4WDqo7k5n5RbORBkB7NvZJAxdPXweUPFhP6j3wE6DGLEACyzPMplErqjfWsGT/3WF0jnLpFo0qPMiXC+D3ULPvpt1rpLi1TXq6hUQiIrdMk2pXw9iG9OJndlKOFcX8HSThP8vS5oHk5hasL8QHzOfgaZlIYNAT9utYlj8ovVPeZo4FFTxYTjM5+Y6li6s46gDzfT+piqNG8guaJ/pTb2eQuETnvjP0JK1TdQzvSMZYcUQCencALK9MYBRZqHeTCPfLJHu4lCuBr9yz8T3XS0L+Rg2YxOzib6f6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 09:05:05 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 09:05:04 +0000
Date: Tue, 25 Mar 2025 10:04:55 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: initialize built-in idle
 state before ops.init()
Message-ID: <Z-Jxt3n6clbABIr9@gpd3>
References: <20250324085753.27112-1-arighi@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324085753.27112-1-arighi@nvidia.com>
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e9ef85-0c95-4322-5a03-08dd6b7c21c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aJKeSvlitQ+FWGDMnrvDNDRw5MqYa9ksoeO+l/4/uxzW1Vx8bmgYX87jLazA?=
 =?us-ascii?Q?Kw58q1CfLxVfhKDwXoNdn+2OhOoEPrez2/qv1U978z3f7d/Tb22TZMkxHGYO?=
 =?us-ascii?Q?qZHBSbEYH+yyXC5ATuH/gXWGKhJwYkIQ4Qdfc5XfLAhDEF389VEQU6rnSjOh?=
 =?us-ascii?Q?EaXaajuQFDQwSssy8a4FYys4SmtjCkBagi/9iz+yfMgcpeHfrCE2M7yTaCES?=
 =?us-ascii?Q?6furxj/lP9XxpFIYrJJaQuhFmjDjBJyZO42J07dafXw8e4lN8G+PjC8CTv1p?=
 =?us-ascii?Q?PrUGO/jb4EEhN3TXoM77+GWGI0MmtY0gOkbPdarQfj3evaLtlujpcdQW0h/J?=
 =?us-ascii?Q?izQrpq9kjLCD3R1Q5JBhrxwvOiNMwx4P1okTgLqSbuEQOQ9JfXMoGjLvAm3e?=
 =?us-ascii?Q?W05acev0TmAldULV/Z+FIs4cI5KUunDSs3OIb9yNUwRGtUy4MEuMLP0wUjM0?=
 =?us-ascii?Q?m9XMvgMJy7fK9dw7Sne1rAfsMJX3FrR3qeb76iGDEPhw3TFbQqQAmz1KMc7r?=
 =?us-ascii?Q?g1oivtCdv+yd4n1EHnVnexAea10UyleewixNolvBYIxQrcx7sc46RRPg4IG6?=
 =?us-ascii?Q?Ui3st+3cd6U39VJu5sZRi2Kh31BemUhhooVNYjJUIWOOX57//yY6iweZYByM?=
 =?us-ascii?Q?dsBZC3wzavdCkDt7hkwSQL2uVo1UqotLiarnFj5IHkghgByeMDn/ua7Aq13o?=
 =?us-ascii?Q?FtmgNQnENdMGX4wMgMWSBIQmraK/6HA3+blDWcThE4C9XAnHwc+3eUVlJBxz?=
 =?us-ascii?Q?YlR/4c3i8FgreTLtXhPI+ohzz1kyhBoksIm4adgxel2t9PG5LKf77HtpzA5E?=
 =?us-ascii?Q?7iNot6Rt4r9/wuclIjpjwZcY6PNcM3h1TWI9f2nsI23ZJWOuy47m8KORtjag?=
 =?us-ascii?Q?YhjM/N0wQdLKtRw97R1x8AlI6kg/sUXx8r6vHXMvcCN1c4RpUdb13caQg2Ki?=
 =?us-ascii?Q?XzhPyWCKhl6UKCKBcUlXIMSvXrXMJs6jks7KX81hT2FZpFNGG8H/ghOlXqAC?=
 =?us-ascii?Q?kSUOLUjZ/NGmx60Yw9aH0DPKjkpvmJfmZ38ZrcyXP/RF/9M2V2PXjDiTty2r?=
 =?us-ascii?Q?CFYPDe7ZunfkMFL1IjRcb7yvLbtjCEkAmokdlVyQloi+6xWvRJLQydHcZrh9?=
 =?us-ascii?Q?2jdLb3IjtgJrrr52RpTq48Ov3jEEqmDTqoLng9fDSsl27ROPwTMeihHajTPH?=
 =?us-ascii?Q?AkH14yGHMMU4n05pv8XY/42k+7IEu4NflSfK9v1sLrV2P157muGdPXmPWhGr?=
 =?us-ascii?Q?L80hW6TyRSOhVIvffODJHpgUbGuVksWHTICg7RIxbmfITi6XYQpbHMTYqpXD?=
 =?us-ascii?Q?psPK7gf2OnpA6hvTr8f9XvsDpBg3Hs/OXCUSLFxi7o8vB1HBU8H1tmVQ6HzO?=
 =?us-ascii?Q?dFwCArsdiLos0TN38S/hPo+4Xc0A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2KVDCXNGrnxdM7430xbcPEum8zOjE7sJ+YIfCGpVJaMpKsHvFmuXrFk+sgfE?=
 =?us-ascii?Q?BN40y+6m+dEmllsBUHM8DaH8FrPLzzRCscFtf9S4/eIWU/mUqn0air5D+rMQ?=
 =?us-ascii?Q?df46bzaZnk+L6MCuvGzjMllnZgp+jFDlDpd/4j+YR2VO+pmb6NfA2NyOWwZF?=
 =?us-ascii?Q?9bineQi+f1D6Dvp06uRnXp/ICbFHKx1FRX3uTMeK0Z4oGBCjoK4b0+IqB6mC?=
 =?us-ascii?Q?IICmwefF3KPUJfNg74IBXNHrwgJpYrSnCGFEDSad6HHU32vVxqxBxQxoUwo8?=
 =?us-ascii?Q?yv1sW2s/lJRLkXUjHdyQhP0XbUHeyduImbwhEUnUqmrf7PuCOpIRgdt5aqHw?=
 =?us-ascii?Q?5TqDfSmI49ah5IrKjsTC3/39P6APxSGq6x4NTDEHdZD2n1QvoJNW6pTtXWlj?=
 =?us-ascii?Q?CguxyC9vmspLYHvwoRHR5xXe5RMnysZMqSCtmczs3Sn7l8H0hwSl+HmgM4tq?=
 =?us-ascii?Q?mvPxJOpzcEacwFhvEiFVjN2WKsGbPMa8tlDdpNM2g96K7Jn1I8UxKcCGXi7Y?=
 =?us-ascii?Q?84rMks7TRZJSdCQoHKtR8EPcCuRlg4BGpMEKRcQkXWyDiCsh8sCKqKUNi4BW?=
 =?us-ascii?Q?aG0TKGloHCXewJq9hQzlBGm2quTCuUq5b0jb46admqc27qK4vzkbe+xStrcS?=
 =?us-ascii?Q?7Ic1Admog6Xu1UieVKLo8rMG40FYzx8Aae/yS2sosWNBzMwCMzNN5d80MPWs?=
 =?us-ascii?Q?f6/9Ub8i2F2Ub+SwCDRFG9wkO3INwQkirmNZyLMmLcfVk2fEoxX73owSBv88?=
 =?us-ascii?Q?R05uSt3wAO9C1aEJ6U2Xpd5GrBJhhHxruSGtIWMN/5qHZ6LHDftcdh2tlRTQ?=
 =?us-ascii?Q?7+W66M/SJq9mVSKyMKHf/oxKlsnooyEbbDCnDG0gjOIoeV/9KvIZL+If3h7K?=
 =?us-ascii?Q?4a4eTWN9vTrzfV1tX+g8Z8JJcpJ/jfG1TEHRJnZ7mIIFgQfGdxrCjnZ+sYT+?=
 =?us-ascii?Q?jp+3HxdJRn2WTCEDg1vo8+8DAOC2j7c46DehC7FMkShjtODzSkB6WkBXhtyR?=
 =?us-ascii?Q?rOIofPv0r9lrbXTp+61TAWVPVrHpaR49mRbfhYpkqcqq8obzEibjK/OxiCoJ?=
 =?us-ascii?Q?7TCQ9dcGZ/JYPLguv7nZd2vKAP+vflBclwCF+2jL1ItYVSHY6qKiVqjK8ybu?=
 =?us-ascii?Q?UaZJTru2Kz4rlUZnFOqibQBPj6unOldPYG8VgD790RA0ocP/Wrsqg+dzesjY?=
 =?us-ascii?Q?xyhQkaKuy8CqD+fTPlET9pw+5zAqNF0bJW62xU4BdLeMEZ6CT+HGi5z/lh6M?=
 =?us-ascii?Q?PGgVEW2hL09QUkp3haC5ybbuodtc0zWknnQKWbTyGcepS6d9EUbvM8/ICJ9E?=
 =?us-ascii?Q?DzI8j56PMxOV6/qUnFpSm4mMy3+w3erZhCCju5Y+dN7X37hF0DM7LWhJMhQf?=
 =?us-ascii?Q?BHxL2bE+VQ0xe8ML9elwB0sJmnBPP684uPFUfAjNOCrZAW1fSLr+1syjzW7M?=
 =?us-ascii?Q?fejaulc8FmEgst3torvIm7B0tHRF1PpAsuNPtVdCDBhKrQjLzOyBUeWl5iE3?=
 =?us-ascii?Q?1uW+3nU2gxygp0Zd6we7qjMjBX6NE7lRaxSPJ/vFMp+u7/fGW7QsQ+ocs5Qj?=
 =?us-ascii?Q?8Hl1C5zpLV4NnAE9aElEu70bHAIfoRdODMtzgvIa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e9ef85-0c95-4322-5a03-08dd6b7c21c6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 09:05:04.7807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX7+17drAZMbIDBEwhyUDLK/fdPZU62z2a7y9v2/50VsO82daHTqXbiwlChJ8+E1BoOuXQ6aA6/ceAm8lbJF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887

On Mon, Mar 24, 2025 at 09:57:53AM +0100, Andrea Righi wrote:
...
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 06561d6717c9a..1ba02755ae8ad 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5361,6 +5361,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
>  	 */
>  	cpus_read_lock();
>  
> +	scx_idle_enable(ops);
> +

Actually, I just noticed a problem: if we call scx_idle_enable() under
cpus_read_lock() we may re-acquire cpu_hotplug_lock because of the
static_branch_enable/disable() calls, that are trying to re-acquire the
lock, which is not correct.

So, we either need to use static_branch_enable/disable_cpuslocked() or
place scx_idle_enable() outside of cpus_read_lock().

I just notice this from a lockdep splat on an arm64 machine (not sure why
lockdep was happy when I was testing this in vng):

[   65.974439] WARNING: possible recursive locking detected
...
[   65.983540] --------------------------------------------
[   65.989039] scx_bpfland/3883 is trying to acquire lock:
[   65.994447] ffffb80a490991d8 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x18/0x30
[   66.002941]
               but task is already holding lock:
[   66.008978] ffffb80a490991d8 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x18/0x30
[   66.017455]
               other info that might help us debug this:
[   66.024212]  Possible unsafe locking scenario:

[   66.030338]        CPU0
[   66.032855]        ----
[   66.035372]   lock(cpu_hotplug_lock);
[   66.039154]   lock(cpu_hotplug_lock);
[   66.042935]
                *** DEADLOCK ***

Anyway, please ignore this patch, I'll send a new one soon.

-Andrea

