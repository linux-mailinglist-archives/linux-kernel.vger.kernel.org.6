Return-Path: <linux-kernel+bounces-438382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563989EA073
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D08328240D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B4E199EA1;
	Mon,  9 Dec 2024 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rb6LXi9N"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC51531EF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776858; cv=fail; b=k0ssWzDwoa5v+ONYBHhBPu8vi4zoAgt69ORBzJWhYRi3ilhShRSJhab4V0fr+MjCWbDs7FG7ImzD2/SkUiPBitJY93DngEY8Du8pxoD6grF3RPCPKwj7XMXx8CblOfh91pntWfCJJGssOvf9SKGiRSxUrPinzUseuTimh3RZr/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776858; c=relaxed/simple;
	bh=mubef0Fp0JK8X1sF16lRBTd6sgJR+hyUi4a/fvghN8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bs8TkGteSASso6o4POZToJoIkxEvSc4yDn0vp2hYVVXA4I2vl3QK5Z8SxJ+7HbussLBtoCRpW2AcjQywmQSjNb4Kwd9zTnhcbhTMsmHhYf8SqAaoxn6XwZhsErXTbUngmOxYjFI5Ffda4fh76RzTgOSj0AuxkIJbSmuU0rT/TdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rb6LXi9N; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEqfAZsJkQS/xo9caaTNdDmTvMtXzf4DIh6fA89TwNwcXbKt52RWrSh6d5/feDosw8nnqC8f3fPADZR9gVU/orxGsm/mWPyLpefqcq3twPwXF44DtetmmpEJJxw0tRTHHZ3xCzzAsMenyUxfhwXUTcRfrIZCy7xPEAndaMtRFfRtcX8FdHDCfGBnEEj2U4OVGF3xPB4O4kxmxZsZ/blO/OM7PExU33Pb1GY0FqUzMHsAKz9mjAn8Ob1GC0jYqRMm2D6bNPi9jajgEvwIqq4StVNMdLRxpieV2aG8a38ZJQRDvZ6e2YKFxg3TA1r+GKZXXK4I5Of3siarnsLZQ+98Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyhamfyaW3Eas6FV4Bg3cq+7zRSCtKSgs6qNGmHtV7w=;
 b=Y1+4PSGR8GVMX2mAss3g8q2EO9PHL1+Ln8cZBe6BSxMtC1rateFWEcWL1JzpHnhECOJ4PKEJqUppHMLANPz5jfJRhcd5IIoHGM/ivkvMg/ejnlV2GB9DIcnRZAd91EAt6B7NRFeMhVb9hLdKGv7uuoawM9Xej1ywQ815RR0QwDmXnJkJn3/1+liJQbeJR/LuJvg8FoCeo/u5o99xhaANt6/9++9avZgz3mOi1U8mbkc0hprwD8Q+M/5A3N/WkwHOU4dz774ebGmXHnG4Jyr/tQ3O8xZN33z17Ak/ksDVBiwIhrvhKju8rVqkIkOYCS25ASPr4dhVYnOzp3AehCJ3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyhamfyaW3Eas6FV4Bg3cq+7zRSCtKSgs6qNGmHtV7w=;
 b=Rb6LXi9N6Qd2QQpeqy4Fd/YA/X1ww8aEPt+SfR52wYx0uhohJsvbwD3lFXnmSV7liGLbIhpLAWlREJKB5zZEDxzHBp+Oy26/0goRxBbOtcAeyXCLhAZ/Q4o/k3raucKCZ0MjWtV/+0BDZMFaBeIZmSN8rbTg2/TdOZ6mSO+nRKpPiC/uy5e21V0+p7X2CydQXJewufAJ57N4E5hOCShsAuOxaA8WuWhIXRQO5PzxOnYSdwZWvTHRk8x082xNjbsPO4lHBM0YqhDMxmUQbrNF/2mv5kB4DqLVG9Jbuyyxf3xbOUc+jEqK9L3z+H/DUgfdZfzQyV8T1JSJuSzeHScPzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) by
 MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 20:40:50 +0000
Received: from DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793]) by DM4PR12MB6424.namprd12.prod.outlook.com
 ([fe80::8133:5fd9:ff45:d793%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 20:40:50 +0000
Date: Mon, 9 Dec 2024 21:40:46 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] sched_ext: Introduce per-NUMA idle cpumasks
Message-ID: <Z1dVzm0WVZSayz8L@gpd3>
References: <20241209104632.718085-1-arighi@nvidia.com>
 <20241209104632.718085-2-arighi@nvidia.com>
 <Z1dF6HuEI2nyUD2V@yury-ThinkPad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1dF6HuEI2nyUD2V@yury-ThinkPad>
X-ClientProxiedBy: FR5P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::19) To DM4PR12MB6424.namprd12.prod.outlook.com
 (2603:10b6:8:be::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6424:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: f928e8d1-5c8e-4a16-7c1c-08dd1891c4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iamA19agiNWSUIn0pm2WSsgxvxYuuce6ge1rrPCs231alOKik6a5K4vNiT3B?=
 =?us-ascii?Q?d+Vw4nlDb3IBONfgsU8++g81jbcaK8JtGLJOAlNDwq2q+WsqEDjttbIddWFD?=
 =?us-ascii?Q?du+Gov/5aSxyDlFe5B3+7MLDZPSo/ZYXgczb6XMYvovXhZlfIIfMR1YjcNCH?=
 =?us-ascii?Q?HNOtG+oopSU61MOP9BI4F9tLh2j6+BdjTkZXUS7x/kMuHiDE51o0+Bm8hP9F?=
 =?us-ascii?Q?gFR4t0poxcp5UK9ClhOsF4ARX5tUTlNaefwk3IDQlg3W5skP9rmM95oLxMts?=
 =?us-ascii?Q?IGS/Y2nwEQQ+oKk4ZFikynebJln1pXCMSnq1b2d33H72XLc/UgfN6exgPAhY?=
 =?us-ascii?Q?N3X2uCTF8QHpkkvLQS7TiJvptNMuZ7H8b4tdmm4IU8sZ8oQgCOJ3CTb8GMR4?=
 =?us-ascii?Q?ECcHg3nXthQ1ihcBgqxNly59FVc7IW6mUJwL8p7IIkrrVJeq6Pta/6Ruul7W?=
 =?us-ascii?Q?f5zKaCZZG19xUXvYBAfAQb/I5rbZAvCMWVogFH3zh53ACPjzMViLGmn4m1it?=
 =?us-ascii?Q?UoIJcArsaHmSbip4oZNCU3RZSiuiys0Unhdvup9KU1V5DcOgP4r6tnY1KPNK?=
 =?us-ascii?Q?KkjA4tdfJ4MljQznKQvFPqkCNOn3wpxrlDrfr/JdDdiFLS2se007B3F7fwxK?=
 =?us-ascii?Q?97KdCkYL1BokPB7b2Q+wK4VcZ+LDkl+cGGhFO/7tx0TMEh0Df54suKxeCpL8?=
 =?us-ascii?Q?RULLBZN32s5fQNG1QUIS9dwC7LqMhRG1CdOmd7Tvae7hmXESDyrpmJlyzPTW?=
 =?us-ascii?Q?bkZ1YpohNrfXUz0S5hYCYmTw2OiNjE+H2cAiWwK36uRaZPcep1YqLa9wmpY6?=
 =?us-ascii?Q?yxIUbcyQJMytPpNQk5dEip9M/28EG1NWwC1oJFof5dJZpxwyMW4Tg6HuewxI?=
 =?us-ascii?Q?gT2NbbVApSnU0vk/iw9Gpiw4giTdoi4aWLzDI4h497n0bc4leD0GKByD3LEA?=
 =?us-ascii?Q?Rsi/EzBFTiTCzlyTSuA4WxYVXugdh5Oz7S3mmGPDbhnhbcTT2uWmb6e8rny9?=
 =?us-ascii?Q?L5iOaeRzmW+80wWFvisj8LIGc9OBSCCOcjqnbzowmRDB/jewWSxK2Dn1xJs3?=
 =?us-ascii?Q?jY4YWJdpexCZt+tc3EXgJWrpuFQy3gqL9a65G9TpfXx5/eWfaR/WVj1LMtQi?=
 =?us-ascii?Q?7wxHww6nSSOSpjycmgSuQOkmk/+se4K7Q+byrJYfuiW1D3pIzCF5y3tZK6mk?=
 =?us-ascii?Q?g/rL1TgRB50+4NOANDEp5rjudA/aE56KgIRBYv584dbPR00hFiQxcswxg6ry?=
 =?us-ascii?Q?SnfcvtoKtjpLHRQfRfommhUXwebRqbjGT6b61hx52YDGJT+2OIdVoVcpiqSy?=
 =?us-ascii?Q?0Vb7mrGBokNlXSLZ+L/K6/pc2zF/eYIaguprTBV4hU9j2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6424.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K5Wneovqy1Qfgx+cw6OgCvag4sJ+tAFLw6gfZdec4BqBEPuaagm8iKK/l2Ee?=
 =?us-ascii?Q?HglUlmxkBRUrhGAmGLNSrKLNQ24gUMAY7DTIS8jkrO2KFxweHRunlU26Ewcj?=
 =?us-ascii?Q?fnNn3i32xAdTWUL1KhnpWO2qXBF+FTVDwLoyTQjYDxPUYH813O/fFqjiZu6/?=
 =?us-ascii?Q?Vp7urhQgc+b4jJ5xyTM7/GRFOPa9Ze+J8BINH/ge0fMCp0Kf8xKfQaBNgYV8?=
 =?us-ascii?Q?PjbJLKhUbwOZ+9TtLvIwMUKfUzPFZrG47HcDSzChHOuOl0Y3hW7rhSGYEQLf?=
 =?us-ascii?Q?t47ZPtZq6adStkAtXrYH/KZJH6DDVf1Gdc6UjRdhNxx+3s9T25fU+uORNhtP?=
 =?us-ascii?Q?vyTGQOaWin1Txufw3LWc4Lt99hs4WcpDKNxZBuPypmaQ1whwIe1T0GeuZkh0?=
 =?us-ascii?Q?b4Vj2CHQzDvpfyP36pVghu8O0JktyXSbBa3T5AzWwhwqhl/7xTKCv61EZPQc?=
 =?us-ascii?Q?JT4FfSaWRJPa2r0gBUAxfaWB39tZiC8OQndyYnzaTFV6EvdVr/DHafUeaVBT?=
 =?us-ascii?Q?pfwxLA6jdlOAxwzoKvrNJ/Sa+45L0Q5C8CcAiAWoRB2ZG7RGKo3zIS3sSpWf?=
 =?us-ascii?Q?q/8P+zEm74Pyt++PrOYTAEOUTFhpL3bJdDE7J35Fv2QRms53WQ9EIcunNL7N?=
 =?us-ascii?Q?bP0OoV6kYtxPznJIwawLxbN750+lGscDtWTv1RdvSUNiXfCWu+gKsjrn27mY?=
 =?us-ascii?Q?y4/W/b6UDjOYWAsTiyyV4ziZT6KQCSKkEh/S5PeZhmQ8C/i2kW7IM3zga7IK?=
 =?us-ascii?Q?DKwTgknopdzx9T71RjuWirPdLfSS7U3S3m8dU+ewTtkuDIYRGMgbdn7rsV2i?=
 =?us-ascii?Q?i1URU6hq0NZ2XIX3MzRSA48ktpHvnMBldY3PciGM4wISCdtlAat4x4bAQQzg?=
 =?us-ascii?Q?zBdgIkuGLczkma8G2tNiyASuoqGwo6fF4Gw5gaTA1cN9xPWGCP0W7bxd46tt?=
 =?us-ascii?Q?ZYP6ReVOQLXfo4qkvSQgXEnYCWvEvdKVPXlVhwAlWHsGlfdbXGyFQeh2aCjM?=
 =?us-ascii?Q?ctMVoPV4pAOcaIIpNkv6ASDCENGdH0CmNJuR1mpWk3w8y07sTz5VbMIXtHwA?=
 =?us-ascii?Q?AwlYy68r/Xh94hwqfBQoaC5ea9dquC4GTlR4KxiClhiwOwJYs/P77Uq68KS3?=
 =?us-ascii?Q?ekSES3ZrNTYKSkn3dxJNmNjDyKn4NKIkCHzC/mypmm00vt39ShwG50Bhpn3g?=
 =?us-ascii?Q?AJt7YMrWkrOIRO7y4V5d+dYihqIZizqjFI5UiQ6Zm+LFGapxy1Ti8cHLHp4h?=
 =?us-ascii?Q?6rIjLKMX12jRZBGJIt9Qokyz3PidyZHP9YJfvSCG9FM/XrOehwGdV/Z0rnVg?=
 =?us-ascii?Q?uZxkQW4qt2NLKKqT0nbSaeV8LtLh2BkYfEWtFry/+k40/+V8yNWq70yDqnuk?=
 =?us-ascii?Q?SCcWPrlhXdW1yo72wRmlcUqLQM+7BJtrQlkTSDGbGPnA+4nOJJ8pkrJUp+WW?=
 =?us-ascii?Q?7DJ7aR+wI/2xmrYPc3WEES/H3eZN3d9dVumxf8c+HYDT0Ck8/X+GPDZBCjHh?=
 =?us-ascii?Q?C9pQbc+rOSseeAadjeTL03mlhxM4exNybodcPhpR+6I/gmG97q/yjJiO9Tvi?=
 =?us-ascii?Q?YL+jLK4DXRb+aybAtuJpffMfOkAWlWHZ4GSNRGFu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f928e8d1-5c8e-4a16-7c1c-08dd1891c4a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6424.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 20:40:50.8111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUUeFLoDZouM55jpB2DQahp6NrtlxfNQGpPRw7oa1/jff2rsdEe2ocpoIyJjHwnDgLSdj0sGIBKdop3xKtaIgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598

Hi Yury,

On Mon, Dec 09, 2024 at 11:32:56AM -0800, Yury Norov wrote:
> On Mon, Dec 09, 2024 at 11:40:55AM +0100, Andrea Righi wrote:
> > Using a single global idle mask can lead to inefficiencies and a lot of
> > stress on the cache coherency protocol on large systems with multiple
> > NUMA nodes, since all the CPUs can create a really intense read/write
> > activity on the single global cpumask.
> > 
> > Therefore, split the global cpumask into multiple per-NUMA node cpumasks
> > to improve scalability and performance on large systems.
> > 
> > The concept is that each cpumask will track only the idle CPUs within
> > its corresponding NUMA node, treating CPUs in other NUMA nodes as busy.
> > In this way concurrent access to the idle cpumask will be restricted
> > within each NUMA node.
> > 
> > NOTE: the scx_bpf_get_idle_cpu/smtmask() kfunc's, that are supposed to
> > return a single cpumask for all the CPUs, have been changed to report
> > only the cpumask of the current NUMA node (using the current CPU).
> > 
> > This is breaking the old behavior, but it will be addressed in the next
> > commits, introducing a new flag to switch between the old single global
> > flat idle cpumask or the multiple per-node cpumasks.
> 
> Why don't you change the order of commits such that you first
> introduce the flag and then add new feature? That way you'll not have
> to explain yourself.

Good point! I'll refactor the patch set.

> 
> Also, the kernel/sched/ext.c is already 7k+ LOCs. Can you move the
> per-node idle masks to a separate file? You can also make this feature
> configurable, and those who don't care (pretty much everyone except
> for PLATINUM 8570 victims, right?) will not have to even compile it.
> 
> I'd like to see it enabled only for those who can really benefit from it.

Ok about moving it to a separate file.

I'm not completely convinvced about making it a config option, I think
it'd nice to allow individual scx schedulers to decide whether to use
the NUMA-aware idle selection or the flat idle selection logic. This can
also pave the way for future enhancements (i.e., introducing generic
sched domains).

Moreover, in terms of overhead, there's not much difference between a
scheduler that doesn't set SCX_OPS_BUILTIN_IDLE_PER_NODE and having a
single staticlly-built idle cpumask (in both cases we will still use a
single global cpumask).

Thanks,
-Andrea

