Return-Path: <linux-kernel+bounces-566688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62093A67B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3597B3B362C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F506211A1E;
	Tue, 18 Mar 2025 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M0V6ldgY"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD91917FB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320001; cv=fail; b=Luv2ZSfnHFcnIzhEN1aa5Mx1K3Tte3fFTIw/aB1nbs8S1jx4poHGWhM8ss/i2JRPfkbj/Ie023YNR4gxUS6fZSlDNxmUn6sV8Sfwbs/CEHmIfv2m9uiLabjL1ARspqKRfPhIb24BD0/D4K8HOpkl9LST6SmYE4nkay4zb1j0XRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320001; c=relaxed/simple;
	bh=WLUwKe/6h6Gd3oHMzfys237Avxu1UyZ3f4tV55SWE+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AUPw8pMlHiiFE2qOOLky+ac31MLXqOnshVaCiPCiJLGO7LVgu1Me/jaaXP874qBgWwA62042poGBIf1BzM673jTZgJF/xQtM8JolxWLmVSxENLh9fgjmKHPJTs4qySAN0AKbHFhLMDboOSwejEKDlsBYe3myjAqaUjkNWv6VGtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M0V6ldgY; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puBl93EIrkHNjnIaJGqsyHa/8XnxPAcJBsC1vqSGLp3L9ORtXONJPmx/4zjBWZFwSGQqr3i/Nu/7EHnafL13LdgenYTamOoYu1fAy3/wCBg7QfG2Gi5e3nbsujf8pUA858f+sLVhebqsHIxLjp0yVfc/5yJcuS3N3zFOaZd0C4uvneTQ9JOLXAQiINtbWmEcjU8201x+GyITlHG3+Xr5utUMWlCVg+OhA170Qi+KKfe22kNi9sYlb1joE26cf2ZhdH+DLYMFeYT5Wf077hKF+/xSmE1i1+xcDsL8s6Vgq9EiyFMm0hw5Ofo5Q8bVMK0Z7Dx+R0xZQARfWa2IjqzzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8BLivPOQTntiCkXrXtWz0VaBOP4/OfxowHwKbWI3r4=;
 b=ljNfUCVnWkOJURdu6E9FyCan3VF1mEGQ4bhBkQTN4+KvsQ11SLo6SEjkn6bacXtu5CkvPj4F3btilVu2NGcvJwx+8tfkPeWMBsRO1ZQso9bTKV1AEpPpuNGx6aXKznqvPUknnge6W1LdCgvYF8d7tcZqOBvM0ltCq/zUNENlcvIZmgkwcaCBpS+AtmRd/eYrwr4ScwV6+izQci9WhuHc9VnDI5Mx+dqajNIpQfT366kmBfNP7DyeIk6rDeGKpiLt3K7nE44p8Zt7K1PGPd4SktpSNoPhmrYt1VsWrrx7Y219sB/w8hnvKbgUqpeScP6rfDoNix+SNYDlGurAGK3sZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8BLivPOQTntiCkXrXtWz0VaBOP4/OfxowHwKbWI3r4=;
 b=M0V6ldgYub2Gwoq7SZCme7zebAo17Rv84ZdbmGgL/xvUxWVRJs3ogEboD4s8T5p6aLGreH8RLd7Hg/l6zYoQk1ClVCDwvDsAExVG7zjYFotzgYKF24w+gLPU/kL6tMQiKMZ18LocBEKcHJASFsQCY6YW0J16mEQhlMgCoYM2qIdNQIH3hqpRFsrgqV0/wOuSraw0uwRMF9BLmVemgKM0S275ntatlbDr3tlHK9eKAe1Ry+r7hp0tib29fztcphgu4otSK/ZbyYKjROnRECmFtqox3XLZGS0Mg4Z8jCFgxK4mzDytYuWYVj3/N4jY/aaf+NADWEhnhpE596xDwtQgig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 17:46:32 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 17:46:32 +0000
Date: Tue, 18 Mar 2025 18:46:27 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
Message-ID: <Z9mxc4lzDTHSpLq4@gpd3>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
 <Z9hcUSp6P72wT5ig@gpd3>
 <d9bbbf0c-64ad-4304-aca9-ea48febba402@nvidia.com>
 <Z9kAFnrTvqH_AzEj@gpd3>
 <20250318170047.GA3467630@joelnvbox>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318170047.GA3467630@joelnvbox>
X-ClientProxiedBy: FR4P281CA0351.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b28a1d0-ddc2-4ddf-6e6b-08dd6644d1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bX5aIGb321wqHqGh+ooMO0zHdh1x71YHeVnHbOgnWL5BN0sQl8+cA8aLkI3T?=
 =?us-ascii?Q?tAX/BevEvT0Y2hmVC1PAmiYYQAJvLr5Dh90A973ak4NpwpcaNy3z6ZWcXEHz?=
 =?us-ascii?Q?RDIRGN7a9xGTPNhFV3xXKd+7+9Y+9hOIr0gZ4aVKmcXJyo3c3eT0+fjOuI00?=
 =?us-ascii?Q?O4QeRH9vCt+YmUMebn9B7Hgr8J367WLYUpG+wii3awiPnsnQ+xbnaO9oDQYB?=
 =?us-ascii?Q?rxblWhPcQSjBDJL/eQDsQ13Rwr5+5A3806zgz7NBegVW1oV+2cnivD6cyFf6?=
 =?us-ascii?Q?tsNjM5LPa8UtjcFhWzGPz8rky+ZUUEX9CH8TWiA3L3BQwgknOLeQjd+6Pq0o?=
 =?us-ascii?Q?7LWIX6PP+mwM+0Ly5bhmJ966PTvrZZP2Ds3DV4oOeTL7UAdazgDYmQigDWD0?=
 =?us-ascii?Q?PuZn08PVMG2Ys8Ap486Lg3pOIuOYAkUsrD9FfpwVriUGgSFo/zWtOlfFLRy5?=
 =?us-ascii?Q?zrTPvZ3K6qCOz/9+2k7gTiRjoK9DKzOVhj4G87ohQm0Bb6m5qdm7UebkNo9P?=
 =?us-ascii?Q?2ty3DlZrN9duv1sEG8NS6NwJqwlfBZWuJLkMIWCGrPW8YGmn4uicUMkZUpgi?=
 =?us-ascii?Q?v4CT1Or5tdi1iV6yXcvC16A0pzH7GU2b/jLFMw1lMDU8n86B3pptdxg1hPSZ?=
 =?us-ascii?Q?TW3m6fmpJB5jgvQVspjhzOK7eXThWecVjj9d0xy86B4GaSOBXuzPaP+D90uy?=
 =?us-ascii?Q?JVg6r2DFhkoqE+sKdkosTCEAvIV1Oh4ONznCM0NAB1ezHoHpe4L8uar5tVTg?=
 =?us-ascii?Q?SVJem2aTonPzNoR4GRXszgGXNx9shlYs32i2vS1MQWpPME0+5GpqoYuNWrEV?=
 =?us-ascii?Q?xCvQrhGGMG5zay4Zb4aBZHEQTbbfuD5nLNPjS9IOMjQ8Tr5mlF/lg6BzGRX+?=
 =?us-ascii?Q?H3V34gPH92O4DiTsKNaxcDLsewCKMCNBjrbZs3pCElvHT5xI0ykwSW5GPguQ?=
 =?us-ascii?Q?79I0YWQpTPamyR8usFwssbnzpX0aqDtURKuOpOufu4Hjqh/LoU/iymxw5D4y?=
 =?us-ascii?Q?vcFdTCQDZ03fGj5vNwgyc5ibdZVUEBUumACtzM4NYatXl56PYDpCI51Et2j8?=
 =?us-ascii?Q?IOBlDr8i6tfek3BEP0I0qVM4lrjdHCUC2NebYlPxX+oLbRp50cG/m3z/prwF?=
 =?us-ascii?Q?0oBo4xNLFTYETm5Cg5Np4/m/VQce1lltMgkku9WblhPKvzwJSBo+QkUMYdU2?=
 =?us-ascii?Q?E74xUVh6r62f+39DRHLI799fGbai4zvlWbxltfvE382LG3Z0+X361PkNCBJV?=
 =?us-ascii?Q?OcXIOvqDp1sM8eXsGrdmlv0AKrpQDWJr3QO1+mE4/6PQK4zDjf9Bdylz/KXS?=
 =?us-ascii?Q?aM5XEnbQl3yz4AmSanmS3TprxlJ+L0H5iaiBGbZulfDK/bMkKX93D9/+wiXK?=
 =?us-ascii?Q?FEPMQKRxCrlcDHqPl6KjBhsuPXtg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v7qfYenZvGtRLbAr6vTTYbvLeN2LPXtOnNJmRTodhlO0nDM1DJbyAd+o9eTP?=
 =?us-ascii?Q?U2zWeGfHJw4/5k1jeu84OvyPnPDaFptDHkYdTeutF1znIMFzixVcLPdU26zJ?=
 =?us-ascii?Q?xGop03F1ejxN7ywYSQCt4369v0efIyL0od07vEqVUlsGZ8e6+D2AVTZyad5r?=
 =?us-ascii?Q?PP8HW0vZrLCqVTgGZXig7SQwm8TSOVF8UqNjdEEQnm9XJHdGMTpM87WjTuLY?=
 =?us-ascii?Q?qvpzkfNkDmMWTRuehskZk/7y6vpepVuu9yo/bR4qhaz/hsOrOdViSPY6+Kw7?=
 =?us-ascii?Q?hUTBxKq4P80TzTknCdWyM5yG+6+5yC+kB9HttIsLrKGPn+ra5FgyjDs4lAXe?=
 =?us-ascii?Q?WQoERSSS4lRSgdaiILCJaytjlYAxQLhkQ/hPyTOjtoPhM69hU9ZITPfJCJrL?=
 =?us-ascii?Q?0MiRkFWNE9P7uTCoQQh9m6RTxmRM/acxVoziAAS19v/HqdPaewKjLBPy9lsv?=
 =?us-ascii?Q?v8x22mee39pLg0n07Bubl9zm8454M+6ZtYEPSUnMz2FLE1IkXko+UMysEBfz?=
 =?us-ascii?Q?1759ao+6Z5iZxSp+CB/edb8Cg1a9bJxKftFpfnwKYbvPHvAPOwOcyPvq3y0P?=
 =?us-ascii?Q?gqUBaOS3qeM1Kshd/7lnPIPWMCJ3N3zdlZoBQLqGOtEhHHXenDpI/2tL2oKt?=
 =?us-ascii?Q?u4hG77I8eMH+tzB106+XrqS9AjG3aBG/aRHuABOpWdghZbClgYgqGe12joMP?=
 =?us-ascii?Q?MxoGsoHZonF86+rWqyH9vLgZrtWL/wbZ6iLBGPs1Vde4hJ297H/Q/g5gjAmV?=
 =?us-ascii?Q?HIQYmwK7nl3ywO155whEcDCIc7Pd/NvtJbGCeifLr6BildHz/98o3yAOrPIF?=
 =?us-ascii?Q?foLJhiY2inccL9c6gABFW+Hi8ip1QWQ8veU6fF5xbPjTwf8gK5xu60KxyTrI?=
 =?us-ascii?Q?0kFXG9ZmckeDMKpwyap4fdgmcVaGqO/rsBwmm41GiVN7dV/E5Xyk+gMnrQzH?=
 =?us-ascii?Q?YVdNwAkMA25671jAnSf3ruV6WSV4ZTK6tmg0sBcuwI6y83KHPdQrv/FbR2w2?=
 =?us-ascii?Q?+mZJiSbPKYQILxwPku3jusGk2GrKuxHbyWSf4xomnkjjbzB1p1/QVUyndrrQ?=
 =?us-ascii?Q?76/Qr4vwRXw53V9WsKM5mlKVmEBZDQVJfJmMRUv8bTOWpjj/nDV9MqLL2N8f?=
 =?us-ascii?Q?qdsjbIkNksw4cjpbKBQBCQORE63pyCVPuOoo4eze1ynKWjl9Ehc0hljNyBuf?=
 =?us-ascii?Q?sjlMGV8K1ve1eWj8MY+KNVnslu6J5q8TOhkOqIqs8APbsSLDZ7jKgOSnSiGJ?=
 =?us-ascii?Q?teSg/E0H2oGpDuTn/G8OOMPrMVlJR16/eEG3Qs8uoEowlOjxjCnKEaCVAeDc?=
 =?us-ascii?Q?lwvt33YUx4AHXjTBQOi+ao2iV2vUPu5zkIjL80ZuK6p5mOxPgEH//oFvH2/0?=
 =?us-ascii?Q?OAz0PXz05edLl8jlldq1bWNMyvC13gLz1B3g93WOMxZEtvq4e0FdTRvAzIHG?=
 =?us-ascii?Q?eQhVZsJc4TEyYjCCJLyBC+f4QYvtR9GP1Ivolu/qDoMqZWkc76f+NBEEQ/SJ?=
 =?us-ascii?Q?zWolCVslkU22t5TkRNDzCmFlclNP9Af9ClZ8UlcYDVrROBlIyw5p/gt2jhHz?=
 =?us-ascii?Q?c8JPwPiVwsVbjdRu4P9wzoIsWO+rzGVmnyaTqlTn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b28a1d0-ddc2-4ddf-6e6b-08dd6644d1f6
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 17:46:32.4063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duod5htm0L7G7LcZC2lYvW9LCCUWVi23W3tCDSkWEBDf0eh06KVwyPxh7dKjpzyMSUKmuIT839vZpoK42wCaPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767

Hi Joel,

On Tue, Mar 18, 2025 at 01:00:47PM -0400, Joel Fernandes wrote:
...
> From: Joel Fernandes <joelagnelf@nvidia.com>
> Subject: [PATCH] sched/ext: Make default idle CPU selection better
> 
> Currently, sched_ext's default CPU selection is roughly something like
> this:
> 
> 1. Look for FULLY IDLE CORES:
>     1.1. Select prev CPU (wakee) if its CORE is fully idle.
>     1.2. Or, pick any CPU from fully idle CORE in the L3, then NUMA.
>     1.3. Or, any idle CPU from fully idle CORE usable by task.
> 2. Or, use PREV CPU if it is idle.
> 3. Or any idle CPU in the LLC, NUMA.
> 4. Or finally any CPU usable by the task.
> 
> This can end up select any idle core in the system even if that means
> jumping across NUMA nodes (basically 1.3 happens before 3.).
> 
> Improve this by moving 1.3 to after 3 (so that skipping over NUMA
> happens only later) and also add selection of fully idle target (waker)
> core before looking for fully-idle cores in the LLC/NUMA. This is similar to
> what FAIR scheduler does.
> 
> The new sequence is as follows:
> 
> 1. Look for FULLY IDLE CORES:
>     1.1. Select prev CPU (wakee) if its CORE is fully idle.
>     1.2. Select target CPU (waker) if its CORE is fully idle and shares cache
>         with prev. <- Added this.
>     1.3. Or, pick any CPU from fully idle CORE in the L3, then NUMA.
> 2. Or, use PREV CPU if it is idle.
> 3. Or any idle CPU in the LLC, NUMA.
> 4. Or, any idle CPU from fully idle CORE usable by task. <- Moved down.
> 5. Or finally any CPU usable by the task.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/ext.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5a81d9a1e31f..324e442319c7 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3558,6 +3558,16 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
>  			goto cpu_found;
>  		}
>  
> +		/*
> +		 * If the waker's CPU shares cache with @prev_cpu and is part
> +		 * of a fully idle core, select it.
> +		 */
> +		if (cpus_share_cache(cpu, prev_cpu) &&
> +		    cpumask_test_cpu(cpu, idle_masks.smt) &&
> +		    test_and_clear_cpu_idle(cpu)) {

I think this is always false, because cpu is still in use by the waker and
its state hasn't been updated to idle yet.

> +			goto cpu_found;
> +		}
> +

-Andrea

