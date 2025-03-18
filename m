Return-Path: <linux-kernel+bounces-565476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CADAAA66920
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2F5188BFB5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143BD1A5BB4;
	Tue, 18 Mar 2025 05:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="okb3i+Gp"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EF186A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742275028; cv=fail; b=kGPOFljUPpFc2n/D7bEZIv4g/rOssjjbqahtNQbee/8QjSXmFWR0qFwvZibYofGD5Tc9WfS1P7S/DkXpG787O4oBgF8/x+1FaLbzeLVvv53JOKSzeD2+EQ7Mi5Z5jN1bou6/eac9iAQnLeqZIHdaBjItOy1N99b9zjBdydTvQIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742275028; c=relaxed/simple;
	bh=tYU6O7AkDw1Tdd7/dT1+Do14o7aNHKK0j2lazQJojUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u5U6GvJGb76xkY/ULy8xCmQ719L5YpaQnqko9vat6ts7Hn73ZjILu/SJYzLTWSATjuKW51ZqBZ7/oTRPyGGQSR3rZLXEy+wSlssz1wGfgkWUuPzZrrDj/YLXTZrQSoFSvX0OMBNEl2WYh/fErBifwvIJE2uBQ4cFaCQh75TEB4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=okb3i+Gp; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Epup8zr3Gu2nfv17BmfwTZmrF7q64UCqxx8XlR0Nl2dLqTD4rr1WLUP1rMcvpzmMqyWf1LEShyXhxM4zOUOPWAtl1Xrr/BgTuIqN1lRC5W4naqzfK9eGJ4qwYazUw0Pp19Zi+66w5CPZ5MA4msJ9zQq7W1P2F7GcdivhPUqICsifZU50cYOqPdZqokLI9GJ+uB/Xv3IoLv4ZJCx61jItm6P52+V3qY74f6xKJR0yq7/j35DXJdqnegRUdokn7Nc38l4bSYSwEm8HANIU42aM0kMNHFbuQbhfpQalerJ9Z9jMT9ccIuexL1EX0uaGC1wuY1WRBqrRfyQgG0nh5PR/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj2ZMxxjMo6Q7XlQOvbgt56iQy37CE2SBMrHIkyZgQY=;
 b=FoGpIq5idSxk3KoAdpMgHqcW8R7RoyoB04MvQzwJ2Ra8yr9PpUtC/Baxswg9LDyIQXM6fqVY5ycR80g+ucJwgc+5dcnMyQDCadotfJ21iZHfKk+j74Id6ZjqAqAYzYYZchDvSrvsTrOwIQuVG9ig8oODHhBceD5npaQ7UW6IcdM7QvvqItWMUVW9+OlcurpP0mVe6TUcE1YwtH0tjDfeSc4837HVQkBG3Duo45Jq5/v6xhtqXE3c1mYe4/I3lq+tWjF+pC8Kzff0kJTt0DF7laXFcGNq2qHKObbqMLuB6CPn4Hx4ErF/TukaSFclXWXwQStjQNcXIVqKU5+ZmlJNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj2ZMxxjMo6Q7XlQOvbgt56iQy37CE2SBMrHIkyZgQY=;
 b=okb3i+Gp1aufxOQLEVzfmQi+5W8hvyefUjcML3FMT0MUJ7P7Y1/cB8Sy6osRd4FMzrKzyShIFK2MZhRoFnKzI28DntMO2miLNHSdAXJkIH9Dix7N/NYvRo+mYJKt8y4AdLkk495B4D74ibzn0G8jj85C8B07WGNZCLplx1qJCRSAUW6MLaM19WZFVuxQvPlyIJnrjuyEin2heRj5mRhrXNoS75x6/il93GHAdijY2j9iIAQCMoVQe1hn6ozqIJDK2Ur4ydniiLFXW840fgDojiovwh5Or+sXXUv1XRcsPhimeuKaTSmeUkk58aWAh4CF1+WZb/mpivpYTScngQfwJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:17:04 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:17:04 +0000
Date: Tue, 18 Mar 2025 06:17:01 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
Message-ID: <Z9kBzeGAnxtQIvi6@gpd3>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
 <Z9hcUSp6P72wT5ig@gpd3>
 <20250317174431.GI6888@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317174431.GI6888@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 33e166ac-ffa4-4d32-748b-08dd65dc1f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AbPoGSmiofbRv39ch5Tn/c1zPwQT6DvHanJkfP4q8CvzJSVc72ZsHV9BstTw?=
 =?us-ascii?Q?N7QauBB55Q2/gVUfUHqQCn+ifNzrqSSMIuOVjyR8zU/INgRotquXf1RYejMR?=
 =?us-ascii?Q?fttLyrPKTPtUKTalGiJ8kZ4arz49j57xvoRQxZyxN8xYNImiGbnS/w2R9YoU?=
 =?us-ascii?Q?cQ6MEdfhshwVudhOZCHlyBxMrFXE+L4QHAhlD1f02aqTvwn3ZIfySo6tw0Xc?=
 =?us-ascii?Q?zAXAnx2NjSpQs//ROksEz/vycExUvi/28IYwudmpWVdQBKIOwuQ5X2/zVETR?=
 =?us-ascii?Q?F+jpRe2hdAeuRgqfxhiduhWjc0XTWawA+Y9QSYlaKJVQ9UOS0DwjvY+/7zGK?=
 =?us-ascii?Q?df5Mdsfro6X9BCt4weUoFTpLauRcooIUESHE9C7pHm/BPdo+gOzDzUfFvqbw?=
 =?us-ascii?Q?5VjAyUa/hTFEqfTzR0wvsW0m7qft5tV6i9R7ZjsYX2XThtjbQ+xvPxZspShL?=
 =?us-ascii?Q?05C2mXNHGkcL2oYOpalQcbQwOUmaqZ7a1DxgE0oKj0bQ5eo8TU7dei4SIDxl?=
 =?us-ascii?Q?KMUGJMaiFyI7kCmNs9LDHVwWs+R/4F+uxeFEAX3Cl4Vw3kcUtPg3rlx+71gP?=
 =?us-ascii?Q?Sp1XRwFs78q2XIISsCGlh2l7Ybsg10iXxincrgBEOAb8zGcDFQjCk1YVnPQY?=
 =?us-ascii?Q?4XnpqV54ui3OMvSvc0qr9hGhPYeYU7witAVZb40M0Ttte8L9zDWCaaIBcfiX?=
 =?us-ascii?Q?bJoYTREtCXM0MGLV12m76zSmny+QRAK+OKVtGD93cfXRtg3D9z7pE7WflTwA?=
 =?us-ascii?Q?WR3GRv+wFk35Rz7BHVDY2XjArDUN1rjD9rUZB4xbVtZ4fJDjGCcwxQBDZiyJ?=
 =?us-ascii?Q?RTFOD4utWWdiJYDVcr3L2XO7+T7GNyI7fvJIcGty2ILIp/wXp2jBrX+Qxsyv?=
 =?us-ascii?Q?60NCb87EP8xdmJ4d/yaE4PARHq4KvLV5fwjIXx/ATqoQrd7SuR2TvJh4hsRH?=
 =?us-ascii?Q?qzkfbY5bBJrNk4GTCsdDDTDw0DqD9pdT3EggK4OOchSoxgznWprOFBKEysod?=
 =?us-ascii?Q?Uh+XEng7BXIeO90gXOC94tIrbJ8lEYE4i++cxG/6KZTk9YA2qYsVWfhk2jAt?=
 =?us-ascii?Q?YuiFZD3Y0NbYQmSgQuM2askoFG3XNTPTQuMygVJC24ncT0Dq/U6qggXxSa4S?=
 =?us-ascii?Q?RAI/tHKfd2oXQt4ZvCNeq7ItAL5XMI52Zabm2T9Tm/qOgoBnlfo5VXeR0f2C?=
 =?us-ascii?Q?8rY0Qtd4IP/Y8afsGTSXs6fUpYV2agV/5mYZgm1ZCrHUSk1mv493Taf/cdTH?=
 =?us-ascii?Q?sDHqT7ixdDiTUZScNFYEqmAoUdPH5dt/wdyGyv8dxlqVau5B78qNvRk1C37C?=
 =?us-ascii?Q?odym21s8z1ybV80ZfDvjz/wQcUfAdX0WZKsaidzNiwdvjH6pbpKzbWmuR9kp?=
 =?us-ascii?Q?2NXMno7r0V7ZGZ+7T/bG+4DS9LWd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4nGWviolYUIxAGX0yltoj8yHCMBSZxfUHP36kM4J/svy+ZkLTxyusjcr73zF?=
 =?us-ascii?Q?lI89lYax8u+S70ufH42zWfWcpNMsH8gYcZjT2roi4SgYeHzJP/zjDFyOjy5g?=
 =?us-ascii?Q?KVkgBd/UtpZqqX3R1miWPmEh14fwuDrJYGO8WHT0dI6q43bXAzIYUo2J3zY1?=
 =?us-ascii?Q?FF4xjdeQQQUJqqwjgqfxw391sGmiwl9aL23g1mEfHCK6vH0ktQT7wC53YApi?=
 =?us-ascii?Q?q/HWhjBVqSb8gNLqfZJYafkmt03KUHLLZXK/4X3KfUcaZeh59S8dy/Ox8p2n?=
 =?us-ascii?Q?WUOgcf27t+ASRwjKGP0pA2L+q3XTIu1yEqL0Cg54B1bmi13IONUpVIzgAHJa?=
 =?us-ascii?Q?zVBqH80cFk3SB6rdZdukZ9hi2CT2N8Qol1YCu65BhPgEZLYiPWvfE931uD/4?=
 =?us-ascii?Q?LbEMXCnPYX/i11RCzgEDBGxs3ANow32Zo+LKfPFqDbOof0W/LYE1rNha+riS?=
 =?us-ascii?Q?l5Vug1zQZwWqnkvIA/rQkSa5erHoaoMWL/W6OP9EB/ptIy6pZtyq6zfIG6h1?=
 =?us-ascii?Q?tcEnc+Jk7odVVDQBXUXlzRltQkxu4Vzh7aOgsm+dPxN9Q+0bCeh4yxSx2vEA?=
 =?us-ascii?Q?YrXWh3lNnyCU0wtKZKEeflnpLsetmaifLrfDMJE4bklhgMaMU7YxocQ91PaS?=
 =?us-ascii?Q?Z1TPVetlXmubI02+BunErfjrFVLLM1K1QCXAXOUFtuI5+2WnlI2gPfe3s2Xo?=
 =?us-ascii?Q?D1DOpgFAE0D7/AqjKHePtQliuoD8PScvoebezDNIOTvugguyaMZWqPDORa8d?=
 =?us-ascii?Q?F9G2fdvs6PYOTU48LhcY7ALI49k57q5O6zusQr2qmvV3fpSogAZgTggnQ4mu?=
 =?us-ascii?Q?wH+R+/ESLibdPKgR4+owgpesS2XoG0j7ou1sfCAycB23ePtYv7HTRIUh+8qB?=
 =?us-ascii?Q?g2BXIKKbml30kFaX2CcXZYZC30+ARQt2KumTSmBSaj9fn6M9K/kExFUs4ZSB?=
 =?us-ascii?Q?VQPe6snsqrzJECTNeWIPqgjzuBisIysZnUI60gI92M7cA8EgEKdp/mraFZbM?=
 =?us-ascii?Q?i6BryWf46pmlm/2o5c25UPnnkNsq4ehYGmPpbKscmgqsMn6DX0Wc4ONalvnP?=
 =?us-ascii?Q?9pBYl7fPG37l/p8T0zhRifPUPkPFJX1tC6G7oezRw8UTOXte2K1fzhbLAomv?=
 =?us-ascii?Q?HJP/sFykzhQGylOKTiayUGtAS1C8rzsxagUFBhUJnwiPdklw0L+iKmGoiJAm?=
 =?us-ascii?Q?MI01Y0OWUW4gaxsBbRodE0f51dQa63rykdroXFMnkFcAW/ArUSylTHHWanJy?=
 =?us-ascii?Q?UYlcUZvAubeSc+4TjIkqOI+G7Ut38NETQrRDDsdz4KG5iI7GUyHpqQZARbPC?=
 =?us-ascii?Q?lOtPzFwFVh74GvFG+mR2Nne8IisSFNU/xCdJ264VnT5vrCC+2XzlnlbzhbdR?=
 =?us-ascii?Q?U8D4drr2s0+Rs7IP6uz7JN2Upk3DQLl+0cfEhNOQKt+H8WllKzolZ1kZmc0C?=
 =?us-ascii?Q?+c9saUD5gP+bNPKVwp7TVvrm4KdI/0aCtWQ+34PyooP0rQyWDf2QdvcUJFF4?=
 =?us-ascii?Q?qMEFbLdc6c5yP2Cisx2K1PidNWeQ5TI7Tk7BSi2jv+p3wfA9w7bK4LAkNjMg?=
 =?us-ascii?Q?jyAQfUDRE+XQgCxyuw51EC3xULAx/yqouKsdJuKH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e166ac-ffa4-4d32-748b-08dd65dc1f18
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 05:17:04.6384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MuAHx+QKCxS/2aKA0/6KORP10HW52cl1X8hKFaIpnaXwiyThCXUbogOJw2SJ7iFYCSyqKiRwBKhbgmK9Ninzkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243

On Mon, Mar 17, 2025 at 06:44:31PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 17, 2025 at 06:30:57PM +0100, Andrea Righi wrote:
> 
> > I guess the question is: what is more expensive in general on task wakeup?
> > 1) a cross-node migration or 2) running on a partially busy SMT core?
> 
> That totally depends on both the workload and the actual machine :/
> 
> If you have 'fast' numa and not a very big footprint, the numa
> migrations aren't too bad. OTOH if you have sucky numa or your memory
> footprint is significant, then running on the wrong node is super
> painful.

Right, there isn't a single "best solution" in general, I guess we just
need to pick what we think it works best in most cases, set that as
default, and then leave it to the BPF schedulers to adjust the behavior as
needed (at the end this is just a default policy).

Thanks,
-Andrea

