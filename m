Return-Path: <linux-kernel+bounces-532034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB23A447D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D5C17911A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF345197A7E;
	Tue, 25 Feb 2025 17:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D5A/52zX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E8E194A59
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503663; cv=fail; b=NXq+c7Atn482Eh9vJXfmcfTqVvAUE94fWM38Y8D5vBLByCp1deaxYEwzlgoAKBm+PTP3/V2sJY0YIGnA3OZU/r302lpTmXoHwPlnP4SoEnAlJxrd5ngYxLENEzcn04/pyjy3KWTRv46jVF+T8VIrbLpzCkCgJ9piEgfkHxHdpz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503663; c=relaxed/simple;
	bh=a5ODSjDsnbIqsobj4fqBpANfcSz0dEWdgs21ZjgBbA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bZjm17VLhYfzmaPnyCgqUhhhpyq3KogHtsqan1fiupplA7OZzs/Li3cf2PQS7g2aBRGLojRmMVgrhLvxNPcCEhcSNZY408c8qHIGsijWIXtv48uPx1n+jULPoVIm03/HjAnxboiNFSFJZJLJz7V0n+kHKJ3V2GYNeZKPhUf7SkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D5A/52zX; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehOryWEfHrGEiDy3cKN8wfNJD7AfQhFbH0JXAtWgYV6pTD1Ha1H79G6VAmU3a4DpbQ9V0WwfmfRNCcW1ofLeeqQ3MYYvrN532lFrNYB1IAVODJoEW3mWQ9uJyDopeIuUYYBJb4It7agwIiNdZHWHZdIRv0i4sk8q3fXYizO8zzMX0Dv3QkylDwg0MiMzDcPfWI5507b0Nm1HgDvR/3rOh34EdFx/89jn2vh57sPAfqpNxlOzdhoX3WJdwM/9+nj/7iezLT2PTNjuG/QKkrWdGOAWblstibqBJUM6hxW0H9RBSxVMixLsVFKZRmdw/fSJlYWOPii0U/KRVTVi3gLKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be2lX0gJdFfahy2F6NYToUsX9dx0WFfK+/S6spJRmF4=;
 b=jFQI6R0o0zP2b0O8iTpDvLX95TUdgK2luWw26nfeDG0O3V/rbzzAufCtxfbXhR+Yb6nVIapxY5GSfKjhmPLIm+h79JOLapggOv/MnjxF1ha8H3IRbd45hthfiGel9snUFpRZODNcn9XhNTzx1wtamX7OhL3DkS7mwTH3RhEyvEc30gw1G2CtNpbFwWSdu1h/vWOd4lQVhjUKrNLDbGJ3o9xC/yYTzMjuJiwOEsWvLoaqH32BfCPxx8b3jXrHUEgK8ucWK9VCBv4F11WiiSbSWudmuX2+7kSFHeiBzrxI5oz2CpApm1izUNlYCjr1hQl2HoGOfRulVbV97Eh1UCln9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be2lX0gJdFfahy2F6NYToUsX9dx0WFfK+/S6spJRmF4=;
 b=D5A/52zXSotvl65tZNKBTRkDwUZBSPdv5KexmQ527rzlyMdsqHFslBVZ2UqHMuOuY90ZRBLfCdBV7A7bdIPj9WzGdy/FuzfLN8pSA5LtdhrBx3ArA0eGwajxhE56DETr2h9zNvs+52Toob7vDSe+e+iN04MgeROWLKLfL9H+kCHsOWDkBkwcd5UC/zcAMk5jx/ivE3rRmNZluPsuD/L6ZTk5zFFJ8UGcWYrYa8VCPpEFytYoIpSk+S3XB2lR/53uxW3e8JknijD6cu9HdXwfyCPPtUPSNmmThABP6vZpYdeE2UeuI3NalYgBvHu0MAw8yrsqFxTzhDouVYZKtPemBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 17:14:20 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 17:14:19 +0000
Date: Tue, 25 Feb 2025 18:14:15 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.14-fixes] sched_ext: Fix pick_task_scx()
 picking non-queued tasks when it's called without balance()
Message-ID: <Z736Z48iRdjGgzK7@gpd3>
References: <Z73pjysZYNEIbkiy@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73pjysZYNEIbkiy@slm.duckdns.org>
X-ClientProxiedBy: CWLP123CA0235.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:19f::23) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 0108654b-0680-4c92-c6bb-08dd55bfd73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g9Gx9OZVbOauJaWd0GK/pU94furMuAlhDAzZeE+gFyRl5AW1ZzVzQOyM7X2m?=
 =?us-ascii?Q?UvsSDwPFbf/g3DJzVQKxQuH/vGIqMjG5g35Gwl7MHK5nGmUH6B029vdj/vpp?=
 =?us-ascii?Q?/dda+b1FBkEjQMewgX7F79iyjmazlbzMOMD/Qih6oBbxJAcB3wkzu9HEIVnF?=
 =?us-ascii?Q?R+bqOZ4L2moBzornJbaCgz0+9yd/Zff7BQLttV3dhJYJgDI5lhAA5ab6LwmH?=
 =?us-ascii?Q?KI9QkqmOn7VT8lx5BM2NtHLhVsd4HWrGSQ+JPTlG7FIliKvrJCVWnBIA1WqG?=
 =?us-ascii?Q?iQPKfT8D8oKeAJwJEt7ZD7pjeQeIZoV9s7iv9NVOf5PkQMNC7ngP6u9VyKWf?=
 =?us-ascii?Q?OHi6NEfouCKXYWEr6yuACV2s1KAF8v2Jz/DuDQCPd6YPrqNW9zwB8cJcFbor?=
 =?us-ascii?Q?tlPTUxOkTi3RBQlYc+uJnhALHGMXej69CdBv928fkyb74acAkfVqBQ8nwdRy?=
 =?us-ascii?Q?70EfLu6O8bRdWW1S1D1scDGFam7UqidAuzZZHChOCIbbcTGldbF4IxJXnBcd?=
 =?us-ascii?Q?aHObLjUvRJxXlHJZpIO6DibmObZm9zEvBj6N1kMQzqUpNxzf+yhudwyHSoM6?=
 =?us-ascii?Q?QwjeoE9N3XkDCOWy+s5J1MaadaZjaZX5ORFM2Kq7NpVRlJQlyL9mt2ImFmeL?=
 =?us-ascii?Q?iYCW75oDjrKbvyrttR/CF8s1kV2aJX27mCj9iNJxOTJjuVtJMav9WRM1m3p3?=
 =?us-ascii?Q?16dcKtyTLom0GSPXW+1UibevKQw6C/mDqHtHSY44eBsXT04ArDR4bZSQC/vz?=
 =?us-ascii?Q?sBBgxNmI5h4ekBjQHYzJe46Xwz0qTPxfoG82YDjSNt+lk/TuUjOCyomVDZWh?=
 =?us-ascii?Q?XRhvFRlfXCqfWsxdFKw6Eg543PxU5lz9KaWEwtCOs54iOkmeZwzaNlxbYyOY?=
 =?us-ascii?Q?aCJrTWHLEaVJmAp6c2ofyzufFmjfbx6Y5u15uepZGfZhV7OmJT3LSfiYwpmc?=
 =?us-ascii?Q?vJMlVDtbUiZICt5Bhvh8M8cYsVh4ljptbQ2OG4SnkDyO9NKZW9/Z/AB+TAQx?=
 =?us-ascii?Q?4fE55+b8vtLaKHCvH9Al9j0Q5s2OpeSflkpiXjt0cQGqdSeTieXk3IMrWKAw?=
 =?us-ascii?Q?d+TBP9eqHYbiZcf0FRKmhFhPljxDukEf6HQpOE9xnJE17OwFq6vzsPfGFfk/?=
 =?us-ascii?Q?WfIZaOHib1AwOqq+99dBywjpHD5Px4DpO8rOwwgAfnDcqCLT1shANnLJ2W1u?=
 =?us-ascii?Q?LqCnO58wqPD2My6ZsPMl/+VoHiHjSwy9mr5VY/djxGbFlwmerwaLq2tyEr3V?=
 =?us-ascii?Q?SuTML8AvXwLuK2L8WQGfL4I+b+TbDIZx2UAznnAmtHBJ53QpAyrXP+YB6UV6?=
 =?us-ascii?Q?fRzI4eLQTF/oQlCCUmqW+arzWyjNdFmcpo98FdptG0jC4sjj4SRHMh19RCyC?=
 =?us-ascii?Q?AHrVAP88evybUxX2s/rmeq7rZN9V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s142pHq/7WxMfmtLfXh+NPsEh8mImemc2HUDpeWzRj8piwycL2zLKMamXaqk?=
 =?us-ascii?Q?O5wEMKUVzsKpHoCs+U7Fk2MEAN4KJJT3+LeevoP0kZbcSkkBea/QPQW/Odjk?=
 =?us-ascii?Q?RScqoJAhkuO/R2FJCpSmHkMo54q0fIdSKfCzGsNN7SD4ivwiuCbDe+Sc+ILs?=
 =?us-ascii?Q?oGyJOVekZrwEUIL/pfmLnpZ6h8sBGtCNzSi2raTcHZZQEUS5vFHkTRej04t0?=
 =?us-ascii?Q?E7z8Q6TGV2nbde6HHecVLJhPc9hLS4DAjH4aIJg7OKbCUhcjk8FD8GQQtYQn?=
 =?us-ascii?Q?4mLiLjE8FtSfSnVsDgtETqCutI1BSZuEAjSc6il0OKSB3Nzv2U6DVAHRrDa3?=
 =?us-ascii?Q?uvzP4ZvbVWoclVjgUqxLMOPg8A3nj7x1TtbCeN2N/kOI27DfmKKUre4X6yus?=
 =?us-ascii?Q?siIHzP54hK5yi3SvIxl/PCO3RSecX9Wjt3YLkqBvVY5DnIOfuMD/M576nPvY?=
 =?us-ascii?Q?HuSrknw854NmiKNYLHR8dVwcgK/U+fz2EIsX2fe2YzgdckeixN4AtMg9qAfI?=
 =?us-ascii?Q?dMFfA98Zzvs8x89Hrgd7FnaPEcrXPxDxIHw91OaVLjfiQWssZ4UBnK/D9xju?=
 =?us-ascii?Q?SgX8tKPnMKfKsv3NoROiPl9R44bMl9xczIVP3UdJzmtq9TOkZzCpI0cPZ1yU?=
 =?us-ascii?Q?0W2BMf1elpB14x10LfFnSqF8u1Y8NK1e7Z7YPfO4JE3RV/cAmZ6bPDQpMLhu?=
 =?us-ascii?Q?63OhI1YAV+poej+kb4C46EcwR/ND5YSM6iEDbNwreVB4l0GEwttyXMo1tE+p?=
 =?us-ascii?Q?bfAW1pS6sMFUw9zqR6SDBZy5pnBaQDCNW58ujY8lJ1zYlxYgi2VpIGiOaS52?=
 =?us-ascii?Q?5Ncjuf+8QRcsmAeClw3Q24RuTmZEGId2ClDW/rRijBVkF4lApLHeaoLzPDS9?=
 =?us-ascii?Q?pSyGnwossaVPklayKWRu2quac9z2uVQWNun9QkNltAS35JNxk37aSvUJ7c5O?=
 =?us-ascii?Q?sld1O9jR8SbxjeEYqT8xVsETL+7nSdbSnqv9Os1IzS1r4ApgTUmlRw8xUd2X?=
 =?us-ascii?Q?U++Ajoo7YTDEY9UayiBBSaUzBiIRCIBerU2VLe8RQFemvo/mR9/WeCfPT2Lb?=
 =?us-ascii?Q?kjFHPRj5XuYrFVeqA0Y/Is6nKM/jBD82337My/CWjgLiE1nghWkom+BGUQYS?=
 =?us-ascii?Q?RqqB0O5hncE/bTOR0dbJGlcc6VUI/AzZLHkI3H6R07z3AMY7CJ50i+zQ9zFF?=
 =?us-ascii?Q?ab45RWCEXFT2KokaajbPcBSlk6h1kbLywamt4EtPAPbBQrUaZX7CW3hCCjzc?=
 =?us-ascii?Q?czGQQy5gN3EUykDILKjXexSTUhtfMO8oXW4gQiIkGIzKEz6L5KaRKrinO1cc?=
 =?us-ascii?Q?qy4XPZEHHGIy43rG+8BCSmAq9TPywIFqQE0+wntNXteGqqLoQzJqS73n6nHF?=
 =?us-ascii?Q?RGIxja/nmYVrkYYHJxSYA6P8Ns3+/4mcaoa2vpyCwYE5kJ6A7sGiH8q8q1V9?=
 =?us-ascii?Q?fu2jpJFmh9VSrFdmujs4VI7GeCmpOzlt6e2+qj5OI1TlAuDy0AG32ilOYwwS?=
 =?us-ascii?Q?iifmWV/R/Ff34oVndV/iw6wMKVI6S0ufskBgK7Z5FCFvPPN45IqaMaIdS8wS?=
 =?us-ascii?Q?6+nX7V5ZobdfzXVH3RYrxg+F+E1dFsGqc1208K1U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0108654b-0680-4c92-c6bb-08dd55bfd73f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 17:14:19.7513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7oQE919QY1Ea8qBx6ObBHEGsPWfwNAkR17GZ4YC+xegZ4eQgtEeynq7l0OgoZ9TRfSJbpZ/TLhvqallyESHEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509

On Tue, Feb 25, 2025 at 06:02:23AM -1000, Tejun Heo wrote:
> a6250aa251ea ("sched_ext: Handle cases where pick_task_scx() is called
> without preceding balance_scx()") added a workaround to handle the cases
> where pick_task_scx() is called without prececing balance_scx() which is due
> to a fair class bug where pick_taks_fair() may return NULL after a true
> return from balance_fair().
> 
> The workaround detects when pick_task_scx() is called without preceding
> balance_scx() and emulates SCX_RQ_BAL_KEEP and triggers kicking to avoid
> stalling. Unfortunately, the workaround code was testing whether @prev was
> on SCX to decide whether to keep the task running. This is incorrect as the
> task may be on SCX but no longer runnable.
> 
> This could lead to a non-runnable task to be returned from pick_task_scx()
> which cause interesting confusions and failures. e.g. A common failure mode
> is the task ending up with (!on_rq && on_cpu) state which can cause
> potential wakers to busy loop, which can easily lead to deadlocks.
> 
> Fix it by testing whether @prev has SCX_TASK_QUEUED set. This makes
> $prev_on_scx only used in one place. Open code the usage and improve the

nit: @prev_on_scx?

> comment while at it.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Pat Cody <patcody@meta.com>
> Fixes: a6250aa251ea ("sched_ext: Handle cases where pick_task_scx() is called without preceding balance_scx()")
> Cc: stable@vger.kernel.org # v6.12+

Makes sense to me.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5a81d9a1e31f..0f1da199cfc7 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3117,7 +3117,6 @@ static struct task_struct *pick_task_scx(struct rq *rq)
>  {
>  	struct task_struct *prev = rq->curr;
>  	struct task_struct *p;
> -	bool prev_on_scx = prev->sched_class == &ext_sched_class;
>  	bool keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
>  	bool kick_idle = false;
>  
> @@ -3137,14 +3136,18 @@ static struct task_struct *pick_task_scx(struct rq *rq)
>  	 * if pick_task_scx() is called without preceding balance_scx().
>  	 */
>  	if (unlikely(rq->scx.flags & SCX_RQ_BAL_PENDING)) {
> -		if (prev_on_scx) {
> +		if (prev->scx.flags & SCX_TASK_QUEUED) {
>  			keep_prev = true;
>  		} else {
>  			keep_prev = false;
>  			kick_idle = true;
>  		}
> -	} else if (unlikely(keep_prev && !prev_on_scx)) {
> -		/* only allowed during transitions */
> +	} else if (unlikely(keep_prev &&
> +			    prev->sched_class != &ext_sched_class)) {
> +		/*
> +		 * Can happen while enabling as SCX_RQ_BAL_PENDING assertion is
> +		 * conditional on scx_enabled() and may have been skipped.
> +		 */
>  		WARN_ON_ONCE(scx_ops_enable_state() == SCX_OPS_ENABLED);
>  		keep_prev = false;
>  	}

