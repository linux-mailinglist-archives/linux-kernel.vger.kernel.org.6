Return-Path: <linux-kernel+bounces-269462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2068994330E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0C7C1F2A474
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05641BC09E;
	Wed, 31 Jul 2024 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ovyT8T4g"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95117741
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439136; cv=fail; b=pc+rcwgKvszT/E8BBbzKZNsiDu0agUoiFHIqS6ZCCI4r9DYL/02FI08tyTKQlsfW619cKl2tgmqYzRTNb3CNysfVqviWLHVg7Rper0Tg92TL3nc/VbfJrLAxrP/pOQPmABDK04XV1cRbRtjQZ6reK4iAACuqIQnkDbqJKNj4jNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439136; c=relaxed/simple;
	bh=7YrLm0mw3dNnpCEKhL+8E3KI9KasOBBIm6d1MN8gHTs=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LwjMfYd1Swzj5IVvMID5epTbVLd2H29Ga2h2CUBz2h8uS5A6GyQfqs7jgW/6pF1yiT42VbnTYlzp2V5eozjpLHcrMuef/a9JZ28Pvd94rAFu07qP4/yNEGtnR7KAz27DwgXD/0Nw3ytfkZEAU4ZHNvfcsUFBPymGrln+kbLANUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ovyT8T4g; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1/G8mfadtWKrrWLMUMwPhT40U4+8ZRjPbtQbzFu27wuwe+gGshApCvcBaRddtpBRENvYuKeFXHw2KgspwOnIvOxCTVQw3U6siZwSqKloaOgGxBIaZghQJzb+vlFsdmwfWGqHva3+tbyUdgxyDg/qfJ0yRHzCs5XGIca7A5+73DObkpgluQqH7tWDCmH6Udwt7QjayDrcAHTgyQox8MKSlAHQzki9YnybRNNlpgnnTvgs/bKjxZOcKBQwKHSFde89SvmGb8aIgoerrijsk2ZrrQFhViIW+Eymki2glrk8aQRidKsDDkzB7h10TpYPYEOxMzDC06OmJocK6m2qcKkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbUbWOh5A5cHtKkFDWjqoqYIwXiIZHHvUOmRVLaHZ04=;
 b=OOxWqqYYy14K+gTyvqdh8RAautAVB8/LqKkxukRermisD49VJNZn0/zk40zlwlY61swt0Ym1enkKSvr8MLlsYst4RxcOCRZPdIYfQz1zNvprcBVQ46t4EHKeH8TCbWBcL67ULJGV6jeyA3kmpp8GYTuKtLJrg1Pw5wP3GxTljxs33J4e6MrqGKIyxihM5qv9C3Z0aJImz+fJQEWYkM+cHGV/d3X+uRzSO8QSJaEkGxRx1we9wGsvNZ3XOHUoUi/8WXiBFhEXrt6lAClN05PJmQ7+dZr8iajS0WAqPMxv2CDJXb3Qog/BDOzvYxA8bs1DacQ7Pzd/4dDf35PDSRM5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbUbWOh5A5cHtKkFDWjqoqYIwXiIZHHvUOmRVLaHZ04=;
 b=ovyT8T4grYs8iixNQKusvDZEqSuHy/a0G2mXuaruXE70MnrFPHwb5BmKlUjQTC6sLv9IvqnYF6putgZosxL4yqpM9zo4LwDIse6wkIvQcE9qbyPuI76cXm5ErzeHy4Q9LPyKLTlY11wqa5+UQ+9GM6o+Cvml8HFTs5VHWrUZ/nI=
Received: from DM6PR01CA0018.prod.exchangelabs.com (2603:10b6:5:296::23) by
 MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Wed, 31 Jul
 2024 15:18:51 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::70) by DM6PR01CA0018.outlook.office365.com
 (2603:10b6:5:296::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Wed, 31 Jul 2024 15:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 15:18:49 +0000
Received: from BLRRASHENOY1 (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 10:18:45 -0500
From: Gautham R.Shenoy <gautham.shenoy@amd.com>
To: Yue Haibing <yuehaibing@huawei.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kent.overstreet@linux.dev>
CC: <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] sched: Remove unused extern ia64_set_curr_task()
In-Reply-To: <20240731102737.1797655-1-yuehaibing@huawei.com>
References: <20240731102737.1797655-1-yuehaibing@huawei.com>
Date: Wed, 31 Jul 2024 20:48:35 +0530
Message-ID: <87mslxsi7o.fsf@BLR-5CG11610CF.amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 032c9bb2-5999-47c0-a2fb-08dcb17414a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PHmLa/OTBLjG7UNr/bZd1l8Wxe0GS4m0Y85O9F3bRkW3Q9yKF+ve4BTsnb0+?=
 =?us-ascii?Q?USlIE5Ibbm5l9zaBJJ/oqy21DT0hPhY2dFfZH8sVaJxUXv+05Zl49BgCBaH8?=
 =?us-ascii?Q?G9acpDJI/Tm1uV0sL54EbMdpSTtSdVrrgh4sZcl2kdCJkBjN0XA0Bpq/gbZ3?=
 =?us-ascii?Q?YFdsDAX0rZOm0LxfGb3OrQBdw6LYmfB06JNLhBV7tFCsXwHZ22wqYF4cI/B3?=
 =?us-ascii?Q?plyQE4GCPOhEkVjuuRp6UflxIWBcF5C0hhuJGzsroqIXvHY7hroj5WRbPR4R?=
 =?us-ascii?Q?UDf9pVrPeWGved6isYgBANAixAQDP878/gyqcDWRRH2qETMpV82ppbEM7K9c?=
 =?us-ascii?Q?zrAeGhQR9er7tRn8naW3jAd4MHP1msoerUrzrWUOwc2pXi1hUu0tJQ4IW6Q0?=
 =?us-ascii?Q?Y4B2ke0u6FfUm9Ka2j5ZQk4GP+/X3CZhmYld1dPAuo1zRIFRW4FVBiStq8RR?=
 =?us-ascii?Q?wpxFhaSD0TGMPCBPgCSQGTpbGbW5UnqEI/Y8vr6kN1HNSDfZ1CxTT9gR7Qan?=
 =?us-ascii?Q?tdBkrLaRbK5OWKyN10a7KSRihkwYu77WJpz+QBJJL1z1I3gnjmeHV7WcwR0i?=
 =?us-ascii?Q?XbiMjcLAT3eZ/zh9ocTOipDaYNzED3tFWePP68u37My0B0+REpZ9+4zBo1F3?=
 =?us-ascii?Q?Teu4fOoxb8ewRfpx5ldNQ9NVZarnJo2xYTVrJXlMmrxFQl3xm2msQw13st3m?=
 =?us-ascii?Q?4Frazf54jAjxJnL8rqpEUgRdAsGMdfgW/DUh3pcCCbmlgR2i1NT0PVZuaxNw?=
 =?us-ascii?Q?Kc1O2SI7hhLwnKWsOc7EU/0KhVlgqTM6cbU3Gh1TQCGOEs4k7ithp56lLMLS?=
 =?us-ascii?Q?QUonnDZIVRFeYEKLMZGqgQIi+46ZqcvHF4xdEjyczgYXjC4nmXDAony43FIP?=
 =?us-ascii?Q?kv9FHGM5JHSBbYBkfSBVzh1rvNPK7qz1qqb7s+ksDF2LWFBkxyGpaNc/3Bh+?=
 =?us-ascii?Q?O73h34uC6f9CQnqug29A0EKdcEOXf0prTukxwslGF9/YrLUPmfTAxv33kZY4?=
 =?us-ascii?Q?fnsF1o5tOQ2327N6yJlOwNUcBI7uAYIRIYbQ7dti65me38qrXVJn3Ll0FOV+?=
 =?us-ascii?Q?QTpa37XrHi1ClHV4Cl6mmxxShW9QfyV3/CTYAyyv5ebQT+XrYco+TBkvBPXN?=
 =?us-ascii?Q?pya9mZBiVIuvgBgogdrn2p3Ok8rt7wa0OENwi+QWv17dnVdDTjAt6oPMSLEL?=
 =?us-ascii?Q?YklxnLo7bTT+3xcyew1dET8SwLo9UjZLgOs6HDaWJFmJO3B2RFxJ/fhwV29A?=
 =?us-ascii?Q?5KwUnXj+hMwFqt3mBek3btW78ZeyrB8QA7kcjnMnVF//RH9lxAgt/MzeAUlr?=
 =?us-ascii?Q?dSZrP1D29v39eOpIhABCPnOjLqya5NAshOf6o/uZIHL/qwoRQTU0uF6NcCyP?=
 =?us-ascii?Q?d+YRbWLnRbSBSjsn8oisPtOd67ImGQfDPb6L5nZMOnCO0fFsCOLKo+273K4o?=
 =?us-ascii?Q?F1ieJbYwan1Mre/6C8tLgXULLWW6qCantbK0epBUB6SFZseOL3PHCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:18:49.9527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 032c9bb2-5999-47c0-a2fb-08dcb17414a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

Yue Haibing <yuehaibing@huawei.com> writes:

> Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> remove the function but left this declaration.

Yup. This declaration is no longer needed.

>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

FWIW,

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> ---
>  include/linux/sched.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 75138bf70da3..067b3a997299 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1852,7 +1852,6 @@ static __always_inline bool is_idle_task(const struct task_struct *p)
>  }
>  
>  extern struct task_struct *curr_task(int cpu);
> -extern void ia64_set_curr_task(int cpu, struct task_struct *p);
>  
>  void yield(void);
>  
> -- 
> 2.34.1

