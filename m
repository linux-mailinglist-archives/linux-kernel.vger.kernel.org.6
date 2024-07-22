Return-Path: <linux-kernel+bounces-259221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC329392D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F99B1F224FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45D916EBE2;
	Mon, 22 Jul 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AZn7RZLb"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCB28370
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721667419; cv=fail; b=PJOTUj/CLYEzeBa+SIxHO0xv745Qt5AK0HfIHUS2bf5Zy/3BFalB3JSplinZeYffi33I+tafQ5X1XrGrT/MPqChAddx+euYKmM2UnCe4U//H7gfr+1bs/CNNZzW9b3dvqf1qaLr3aXSH2tHcJ1fI5kU1KRyr8fyMrCgHbbrVnwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721667419; c=relaxed/simple;
	bh=/wCzykgko6JK8EE9TS8CGMNvQ+Pf4kmQQE9/feNTTuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JKH4+3pMedM5Rq8P5ESFL8L9hrAruJGUNwq2EFHDAQMaUhtXzO/WFBIgbQ/FeUbJXTSlB+T9jUjvuC8rav5z73HGWZZDFCQ+UDkz17T6QTwPQY9UKew/q2ssmFxk2cb/2n/M4TByTuJV7piff4TyA7lePejxbOmS2rBYcyC1n68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AZn7RZLb; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOocVqLM6711Mwq5vzYumV5J9YgKR4/YgFT04ZnjCvbI4n7LBA36YtRO6mCRYxhGKe7Nsr0+eq5yWOf+9rKGR/T8m2KF7AGn3qsd3/y4BXDISd2Ta3tPyk9hC5pO/oYglDZ+ADj5q0dwMPh+a2j4O9kJFLpEOWLFTWpb0CAXalbIsiTzdhAkJFH2ZLFl+n+o5OwcqYmCkr1zx1LSY5XcZjuleQkxPUudW96a7shvIOoNytIe3/l4uaHMwZ9Fx0K5fT+QGhW0rFS5+I+Klp1TwbtfFsXCu3eM1+CdieZAyxbJ7AFfBprOdt+4+fzywm5Ku9PM1mEcsATxfSwOdGYI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1yBN/3rehwVC2piTa/uSJ1DffY1OPxwdIZ4NJBx+Dws=;
 b=Yt7TMwsH8654VbF63RkMVISYfEkOW7RZj8AZKH9zuHoHhlzP5s0HBYD+ar0lLQZjBST6Mm6nf/RVyDaGYoKeoasfjwouijE6IH59dZQFBLwWilTn+O0IBoPp5JE/GFEm/0L1wK7CGy81wnNAbIlBS1Evm/cdYQ1TDIDTuhyaAGcgA4Sp2pkLuK5LRzJdQoFmBlDcw9evd1pdQ2649wIiZ7kpwhAo0vNGnpae+IKQf7KNh8NJCPeb3HAt0xOK3i7F63LdwW15bzkfgW930dRyp15mQSREJrhv+GWmeAklBDDO885AqRKS6dP99Lv4bMgEXYDXtAzyYnbi3MBkBbOQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=web.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yBN/3rehwVC2piTa/uSJ1DffY1OPxwdIZ4NJBx+Dws=;
 b=AZn7RZLbcO6OOPdJjITqwFB2mkyvde4aUp3PUWFJK9mrZeRHlIxt0UWvfY5RyDsRtql26QNF+qfQti3jaDnVbHMHu3qZesuIRqStOz2LrudEgd1po2T1pvfdCt7Lo+Ss1VI1JG7IoPZaac56IlWoPDZKTes18e3rrD9T6BY/mTY=
Received: from DS7PR03CA0173.namprd03.prod.outlook.com (2603:10b6:5:3b2::28)
 by LV2PR12MB5752.namprd12.prod.outlook.com (2603:10b6:408:177::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 16:56:55 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::9e) by DS7PR03CA0173.outlook.office365.com
 (2603:10b6:5:3b2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Mon, 22 Jul 2024 16:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 16:56:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 11:56:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 11:56:54 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 22 Jul 2024 11:56:53 -0500
Message-ID: <5b936661-9608-bfce-d7e4-f03cf4538780@amd.com>
Date: Mon, 22 Jul 2024 09:56:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 04/10] accel/amdxdna: Add hardware context
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, Min Ma <min.ma@amd.com>,
	<dri-devel@lists.freedesktop.org>, Oded Gabbay <ogabbay@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@amd.com>, "Sonal
 Santan" <sonal.santan@amd.com>
References: <20240719175128.2257677-5-lizhi.hou@amd.com>
 <d24462fb-b9ed-4212-8008-eefaeed8c04b@web.de>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <d24462fb-b9ed-4212-8008-eefaeed8c04b@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|LV2PR12MB5752:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b41b30-d35f-4659-24db-08dcaa6f4ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW9PbDdHS2ZyZmdjVUVCM3N3ak9adzdOQkZMMjQvOTNtbXcvNVREMzg5MFhC?=
 =?utf-8?B?L3pzbFVsQ3VpQnRpaTNtME1lZGN0cVVLSG5TYWpHNUEvVG4vWE5POWdwMFFa?=
 =?utf-8?B?Y3VCamZiNWNCR3Z3cE85dDk1WlY3RC9vVXJQRCtxZ241blZTYlZQZExLckdo?=
 =?utf-8?B?Z1hEd0pRS3M5aUE2ZFV1d0U3OFNJN1VLMHUvU2VqUFVxcmhxdnRwM2NicDdp?=
 =?utf-8?B?MkF6aWsvVGg3RFRiV0ozbDhKdVN4eUM1bEQwZVJwZ1lnWGxsS3BtK3MwUkk2?=
 =?utf-8?B?NFRMU0JZL2cwZm9jMzV1OTRPNDg4UGg3Z0VjMzA2aEgzNGFDRTlvM1RET0VW?=
 =?utf-8?B?blNtdVFvZDN2UEJoWWhjeEc1Mk5EcVhha0ZZTzRuaHhIVzF0K1dSZ0xvM3dX?=
 =?utf-8?B?ajhXVFE2RVVZZ0JXTy85UlN2OGlXdWJ6NWtGbSs4cVo2cDluVjZNYWl1K1p0?=
 =?utf-8?B?dXdoOXNrdzRiM2Nxa3N3d2xhU004YVdtNEcxb0oyTXY2ZnFaaUIxMkhDOVZy?=
 =?utf-8?B?QVJXTXpkWjJNUWRSVDJhZzJlM2ZwNDFiaDZScmtrV1J0SGpOOHJrcGRHbDd6?=
 =?utf-8?B?YlFUUm5GbjBjUkVybWJ2Q25oaUQzTkRKdlVMSzZSOTJtYk5MeVg3Rm5ETGZV?=
 =?utf-8?B?RjBpcyttNHB4RUFwT2h4TlU5RnlvYzFiMWhuRmxLdHlia0JhQzRsS3ExdS9K?=
 =?utf-8?B?OG1wVFBvWm5jSXNuVUk3QkxRb2kyaEI1T2p5bThEN2tIc0svOFlMdFYzY2dB?=
 =?utf-8?B?QThnNjJzeGlxeUh2RkdWaitkS1ZoTVdSbUxMY3BTVXJZbEJtWHZUN0lncHZE?=
 =?utf-8?B?V0NaYkh1bHRFQnJUdDVMbGo4MHgybDY2Tm50YWd5QlhUL3hFcnJXSUlSR3lP?=
 =?utf-8?B?OThQVnh0UXJMYUdIRFR2M2swQmFKYTRVNkV2YWhnZnd6amI2ZzNacDJGSjhU?=
 =?utf-8?B?aXZyYWFCcGxwQXppZWpNdEpycDFtTXFqYUNwUDV4Vm83MlZBblBKZFRPL2Fa?=
 =?utf-8?B?MmtXU0ozZ3dxcDZWVWRCVlJMZisxcGZOb2NibFVIR2UzRndYejFqWUlkNUFn?=
 =?utf-8?B?MjFGaFl1VzRBOVZQQWhxNUJ4NGJJSU5nbklLL3VIRXh2elRMUVhzTjJqM1dN?=
 =?utf-8?B?LzNQYXRpbnlYQS9KR0t4ZmZQMEdFT3U4V3RkSkNNZnVYZEF1elpncVU3bkRE?=
 =?utf-8?B?cXdGbzhwN1RXdVlUUWhKVjZPcDdIUGNqVlFOejk4bXBESFBFOG5FbmYrd2V6?=
 =?utf-8?B?MEtuOGlJaFRmQVdLWm1VbFMvTTFhK0d6S1NmMnRHajh3N25rTGJYQXF6ZDBz?=
 =?utf-8?B?eVhLWTRwSU5FczZOYTFJOTdFY1QrODdZUlZjcDN5RTlmaUdNa0RjVHRLK2hC?=
 =?utf-8?B?WTc0YlREVnlRVWM0bEJ0OEZTdEhMRXBxcHZHYy9JM3BhYk5wOW9mKzZhMmth?=
 =?utf-8?B?Rkw5SlhEZEZ6OER5N2tyeDYxam5PRzgzUVN1ZVZOaGtLSkdjN0xGR1RkcG96?=
 =?utf-8?B?c0Q2akN5a1h4aC9GK1F0OG55MStCZXJLMVR2Q2V4clBzNXNTOTJtM1hucEMv?=
 =?utf-8?B?dHd2d3M0cXNVR0FyVnZ2M29TWS9zYS9YRGJFcUlGMGRjWVQ2MUx4ODFRSVY3?=
 =?utf-8?B?QlQ3MUgraU5DT21rTy9lb01TNUp0UlhsVElubXAxRUNMQlNEQ2x2RlZqaE1y?=
 =?utf-8?B?SVlBREZjRXd1RWFKREZZamY5UTJNR1RSRlkzRExvdmEyUkJHTjBudnpxODdC?=
 =?utf-8?B?c2s0Y01pem9BWEljNUxwdDNEMVkyWHBRbUhncnAyOXBpV1RZTXpST1ZTcWc0?=
 =?utf-8?B?RjREc0RzWWFQdE5NL0pJUWdZUXptMTlKM3hBVCtZaVRINWx1N24zL2wxQTJi?=
 =?utf-8?B?eU5GRGp0SkJxZ3pqWk9BeFRMRlUvVlc2MFB6T1BhNEl0alZ6MVVlKzRROTJE?=
 =?utf-8?Q?uQ8Yzgrus6uWnSaASE4CWD64166d2Y6x?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 16:56:55.3362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b41b30-d35f-4659-24db-08dcaa6f4ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5752


On 7/20/24 03:54, Markus Elfring wrote:
>>                                          … The tile columns belong to
> …
>                                                               which …?
>
>
> …
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -0,0 +1,181 @@
> …
>> +void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
>> +{
>> +	struct amdxdna_dev *xdna;
>> +
>> +	xdna = hwctx->client->xdna;
> …
>> +}
> …
>
> Please omit such an unused local variable.

Ok. It is used in one of the following patch. I will move this line to 
that patch.


Thanks,

Lizhi

>
> Regards,
> Markus

