Return-Path: <linux-kernel+bounces-442077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DAE9ED7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829A31889C8E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 20:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FCF23692D;
	Wed, 11 Dec 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ei0HkYuJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E52229685
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950514; cv=fail; b=twgxvQ6aexFNPRsPGLZjpteCQ/QCN/vX75lzUNSCbEgzipbFMB/jiwMK+kS0XQx/faP9VuawXJ2Djy8VEZ+R4G43Svp+M0DY5owyss/jvy+7WNyDFanRRS8gYuCIDNawN/16V65ciWBE8YQttZKMRGk3jb/73KzsvFosbCh9uWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950514; c=relaxed/simple;
	bh=cMKR/ryIfT0PLHC5g5DxtoX16VqOwqeKP2PXHg9JAVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FG+2RU9i6NFZImxLiuqBBgg8At5v0JY6UHWLcZ3cHvGnvpMznIyWSAI0VOwSqlnMgFhKYq8QkKFWrq6LltGD22eNju+BzIXWb+hY+y/6eQXIOilfADowt13//zTvoE7HCitzVOmB1n8dsYMnQIwPxap/FGMyPZhlQp7JEM9tzKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ei0HkYuJ; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/EepAqvEW71O5iWgLvLMpaTjsyYh0z6kK2odW35Rgy1MENRjduOCZfTLrzeRKN0XK1+nxyo5NzMYs4o72gA1V2K4NopSIEFZPzhpyx3HszVexJ2TmfizUTRHgDFfABpxF/TRBJ5BQbqCVaydlCecJdjR4M/zMjdd5EQAEoed4XGLfW7sXsfj5uMYD7rOQ2zutzn0Ps/81Ix4UCpR1QN46BLghjebL20GKZ0+kGTzVVOezz8YC9gcIHtA9KkCSvIzA1BHrv/YunWEZDmiYJN8S4quNk+uDky5kJ0mMKgIXHe+RNc2ChzH1Rd9HyhA2uhwn++Wj7h7Ec+steoC40tOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAv7KRx89DhcXcVv6bLoGdu/cM2Loc4RW/Vc9i+/tv4=;
 b=GZ1gC+7CIT30IlszSYdJgeYj+HbKVGlZWjjD5PKDlC9hQeCUEIn9urTrRBPXvjBtWphBRswn8bPPymf8jmn8CQPs67T5DxaFMWXwPQJfqmWqMeDzxrNQuJRQcR9YY5wz9uQe2BzpiZIXmcq1KkUp9xqHX2zF/7lpxDkwn/YlfDgR0XDlZeRUCPgkXfBCxuc0TBpA3Q5qWUQGFzPAZwPd2Dqmfokc+pW7owGYzf10GCDSib43819bsfkFejnwlUnveSaObK3PyqPnsacHDJS7qxVOGiE7hHCAmxYaQx7kRs+a3BCqRRCZhLByv+Q7LJIQqLDDsVPXu5NKlmpDZO/gIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAv7KRx89DhcXcVv6bLoGdu/cM2Loc4RW/Vc9i+/tv4=;
 b=ei0HkYuJChAuiDS0hf8XCrtE49KlcFtl2S/eTjbt6rGwySYyBgQA3Uy3VwOeezB8fgyvJuZBMFlyEivZ9wc+fr/gqmRcibUPDjs6vasC6inxQJwhruQOm+2PPLu9veQUSxP2cA+ZIeEN+D1jFB8p/E7pwEHyUfLsar3O3MeRNUA=
Received: from BL0PR02CA0136.namprd02.prod.outlook.com (2603:10b6:208:35::41)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 20:55:07 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::64) by BL0PR02CA0136.outlook.office365.com
 (2603:10b6:208:35::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 20:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 20:55:06 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 14:55:06 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 14:55:06 -0600
Received: from [172.28.102.118] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Dec 2024 14:55:05 -0600
Message-ID: <27be3779-a192-4e64-a882-cf6e6c9bb549@amd.com>
Date: Wed, 11 Dec 2024 15:55:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] xen/cppc: introduce cppc data upload sub-hypercall
To: Penny Zheng <Penny.Zheng@amd.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>
CC: Ray Huang <Ray.Huang@amd.com>, Xenia Ragiadakou
	<Xenia.Ragiadakou@amd.com>, <xen-devel@lists.xenproject.org>,
	<linux-kernel@vger.kernel.org>
References: <20241205054252.471761-1-Penny.Zheng@amd.com>
 <20241205054252.471761-5-Penny.Zheng@amd.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20241205054252.471761-5-Penny.Zheng@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bd73dd-5c0c-4121-15a2-08dd1a2617ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SndveURHc2JwOFYrdFVkUXBkakxiRm9NV1Rhc1EzeFBsZ2tzcjVjTWoyMEZP?=
 =?utf-8?B?b2xKQVRMNElRV3ZoenlGZmc2TXdSV2V2K04xUFovVzMvWTRUbGN4cEk2L3k1?=
 =?utf-8?B?OTBFRXNWNzY0Ui9RalJZOE5QYmd4THhpRHdBQ2ZtSkxZTVdYME1QNmtpTzNV?=
 =?utf-8?B?bVFkTHhiMEtibDBCcnNNY2o4cTMxWUxOdWZlQUN4YUZ5cm1Cb0FMOGtrOWlE?=
 =?utf-8?B?SUJYSWZoaUtyV1pTTkQ4ZzIrQW11VWI2WGJTMGg4ZDRzbVFPNUpOK3pRak5y?=
 =?utf-8?B?TlJqeXFZYzNMZk93QUdOb2FsOWhDb2pITWVkSW91WmlESEhMRTlIZlRpTitv?=
 =?utf-8?B?SzNKY2tPU09qd3hGWG4zalpkSHlkNWk3aUdybUlZUURrYXkydENCOXpjV2Vn?=
 =?utf-8?B?dTFnTjZUY1hVbW1YdFgzYllHcFkrYTB0M1oxb21MT3VVWTJNNElVTm1uSTZE?=
 =?utf-8?B?ZzUvSEdKd0Q2WWxvb2Q4N2wrM01oeU1WR2RiOFQ2UjI1MmdGSmlTTWJCT2JN?=
 =?utf-8?B?aEpEZk92N3FJQTRmb0QyRTlIZlVGWTA0bm1STS9Zb2hpZzhPam4reTZPV2c2?=
 =?utf-8?B?L3o1ZGxHOEVTcTgydlExRHd5dGJrRnFYWU1GNld6T3N3MzRTcGhialhXcTJx?=
 =?utf-8?B?MG1iYWorTWkvN1hkc3BNMTQrMWdub2RpZm9BVUhZRGV5TFhUZmpzRlU1UXRV?=
 =?utf-8?B?WHFEc0dLSzJSMTFiK0x3MmlwYXNObzZzWHhnOWJlWlc1am52cGlURXRHdUdj?=
 =?utf-8?B?REM2UkNZcjA2YkxuajgrOGo2aSswTVF1NmUwaUhhYWo1Wlp4Q1BSaE9ybTVQ?=
 =?utf-8?B?RGtGaFN3NUlNWlBuMnN4U1hWcjdHd055Mi91M3lUNVZwaUZxemppekNxVmZN?=
 =?utf-8?B?Y0ZLMGZNOTdNWG5BcXpYU09MVmo5bHpqQjVnd0NUN0REWVk4SUJmL2JVOGYy?=
 =?utf-8?B?Y21FNGh5MmhlWnd0d2JUMzBhc0VxM0UzMHgxbGNtclVyNHJBSTZjdFNNYnRX?=
 =?utf-8?B?VlB5djBDdXkyb0gybXJzcWdSV2RYNGVXMUY2UC9OYmlEdnY5N1dleUtaaXpx?=
 =?utf-8?B?bkdVblg4OFpVZTJEcWEyVEpDdS9ZSTRsLy91eUZ3aXc1ODBOa1MvZXpjTEw1?=
 =?utf-8?B?dFdqZ1FWWjJQQnIra1FlMDJPTU13M1l3dUR5RzhwSUxKTFRZZ0pDNktvVGhZ?=
 =?utf-8?B?VXJ3QkhJU0ZVMExkMlk3TXZXVTIrVUZFNW5JdmNJeTAybWRpYktXaDZWMEF2?=
 =?utf-8?B?M1VhcTkvUEczWTlCVDJsY2haM2M4ekY0WFR2dmw0eC8vWlJHZ3lMdUtEbXVm?=
 =?utf-8?B?djBBM0FNMXJyazJzc2JlVUpweW45TDdmZlpnN3BObXVyazhZc1AzOENEUmxO?=
 =?utf-8?B?TUhUM1orVkZJQzJrQVVQUlBZZlRQOFdERXM2aytlanZ2d1Eyem5NMVdMb2dO?=
 =?utf-8?B?R0M2VUEwVEFEK2lkcm5ERnRnckNheGozdEdITWM1cnJqRXEyOEtqRGIxUXlI?=
 =?utf-8?B?eHpOek8xWlJxcFhxZDdhM1pOTDlMV1o3N2FKQ3RQZmplcTZ2b0hndUJkUFht?=
 =?utf-8?B?ekd6L25yS1VPUVdYSzVLc21rbGJURjYxRVZmUEFVVDFKSnNFc0M1Z1dPeG96?=
 =?utf-8?B?T1Z6T1NmcXJiaTJwVGU0N2hyS0Z2OTBod0FVQ3lpOFBsbW9yRTFIdktIOE5o?=
 =?utf-8?B?V1VrU1lFREk4M3djZloyZmlNL1pLSzZ0M1pYbHc3cG5Ydy9Ock9aRjBQRmEw?=
 =?utf-8?B?Ym1SdTlBVlpmZEdLTW9wUmcvdWFGaXd0NGFQMk90SEJjZ1ZaeGR3cU1nL2or?=
 =?utf-8?B?MGNqNnhDb09kUE5xZjNRZVJGSlBQSWRpOWl6c2s3eDYyTEdBVzZMLzV6RWdW?=
 =?utf-8?B?R1NFSmt1UkdTS1ZsZjdwRlc3YlNwOUhuaWVFSmxZdzQ4TjUwTzdwbTlFWURp?=
 =?utf-8?Q?iOUzpS1LscNjIzw2xuUzXmV9SfoP+MTe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 20:55:06.8280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bd73dd-5c0c-4121-15a2-08dd1a2617ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794



On 2024-12-05 00:42, Penny Zheng wrote:
> As Xen is uncapable of parsing the ACPI dynamic table, this commit
> introduces a new sub-hypercall XEN_PM_CPPC to deliver CPPC perf
> caps data.
> 
> Signed-off-by: Penny Zheng <Penny.Zheng@amd.com>

> @@ -208,6 +213,44 @@ static int xen_copy_pct_data(struct acpi_pct_register *pct,
>   	dst_pct->address = pct->address;
>   	return 0;
>   }
> +static int push_cppc_to_hypervisor(struct acpi_processor *_pr)
> +{
> +	int ret = 0;
> +	struct xen_platform_op op = {
> +		.cmd            = XENPF_set_processor_pminfo,
> +		.interface_version  = XENPF_INTERFACE_VERSION,
> +		.u.set_pminfo.id    = _pr->acpi_id,
> +		.u.set_pminfo.type  = XEN_PM_CPPC,
> +	};
> +	struct cppc_perf_caps *cppc_perf = acpi_cppc_data + _pr->acpi_id;
> +
> +	op.u.set_pminfo.cppc_data.highest_perf = cppc_perf->highest_perf;
> +	op.u.set_pminfo.cppc_data.lowest_perf = cppc_perf->lowest_perf;
> +	op.u.set_pminfo.cppc_data.nominal_perf = cppc_perf->nominal_perf;
> +	op.u.set_pminfo.cppc_data.lowest_nonlinear_perf = cppc_perf->lowest_nonlinear_perf;
> +	op.u.set_pminfo.cppc_data.lowest_freq = cppc_perf->lowest_freq;
> +	op.u.set_pminfo.cppc_data.nominal_freq = cppc_perf->nominal_freq;
> +
> +	if (!no_hypercall)
> +		ret = HYPERVISOR_platform_op(&op);
> +
> +	if (!ret) {
> +		pr_debug("ACPI CPU%u - CPPC uploaded.\n", _pr->acpi_id);
> +		pr_debug("     highest_perf: %d\n", cppc_perf->highest_perf);
> +		pr_debug("     lowest_perf: %d\n", cppc_perf->lowest_perf);
> +		pr_debug("     lowest_nonlinear_perf: %d\n", cppc_perf->lowest_nonlinear_perf);
> +		pr_debug("     nominal_perf: %d\n", cppc_perf->nominal_perf);
> +		pr_debug("     lowest_freq: %d Mhz\n", cppc_perf->lowest_freq);
> +		pr_debug("     nominal_freq: %d Mhz\n", cppc_perf->nominal_freq);
> +	} else if ((ret != -EINVAL) && (ret != -ENOSYS))
> +		/* EINVAL means the ACPI ID is incorrect - meaning the ACPI
> +		 * table is referencing a non-existing CPU - which can happen
> +		 * with broken ACPI tables. */
> +		pr_warn("(_CPC): Hypervisor error (%d) for ACPI CPU%u\n",
> +			ret, _pr->acpi_id);
> +
> +		return ret;

I just saw gcc warn about misleading indent here given the lack of { } 
on else if above.  I think you just want a single tab indent for return.

Regards,
Jason

> +}
>   static int push_pxx_to_hypervisor(struct acpi_processor *_pr)
>   {
>   	int ret = 0;

