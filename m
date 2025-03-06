Return-Path: <linux-kernel+bounces-549114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0961A54D92
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB8F1896AD2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2D17BB16;
	Thu,  6 Mar 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aIIyJ5ia"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A716DEB3;
	Thu,  6 Mar 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270945; cv=fail; b=F/kI3oEA6uJ7YS7D2l1ppTxJLrTRW9teALEvVXWe5csfa75iFMXETX/PYOskqXjO1PcG9IDj7NTX/JVPzGd6v3F2Envae4T4Nkm5WTg/k5sKIsP9+hDreUoPzhlSLngkhXvU15Mtmr+TKh515Oa7wUG/30YuQ3Uhp5nIN+qVMyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270945; c=relaxed/simple;
	bh=+HmyCget0sjxqt8hCz4h0rFXd4+3SfzsCaUscNECu40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EkfsRvD3aShUeWygII2GsychpAjX9CZvOJscAfoxPVwOviO7queTHQvs/XFgprrjfWh49WpszHqZJbpk5DhwTAzlU9KaPo3D/yaWD4lmEQTIQtEifQRka1YXlp5G6xwWxjpVDsixKDs8lXPnaKazGwtbvE21/EU8Dxz2i+mhByQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aIIyJ5ia; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSqftTubxwE0DcXgBMoh6c8Bp1iQZWCN0yyBtY3lJNM9cWxh9d1ApkDOPVaozQ+2YuvUw52OCuUrUxGS1KYVPoU5RQtTs2HBJh1k/onf2H8aRcnF7QkBaMwL8JkrKkOcyzBlXuRTTFPaxzdvLyqmHXtDLoOluTpq5PK/qVDeUmxqEiI5rCiaVWJuN7yvdWtg3pXB6CoGfgVXCe99Qu+1NFA1/dmDmMiP/oDEYr8l5ZtuYYlDi7+CROQA+Zwkr5iFKd7Mt6+B/EvGzqT34JcrnbQ8X6+j062zgjj19o3EsOIxcv+iPDb/DnmnY0OAe9o0GdPwaoeL/8eOf+qD2kF4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7NXEypW1uRYxxuKX5dlkm+ubizvOOeiAFKZlL5EifY=;
 b=CfdRBXulqReu9slGc27mYRRb4/4pPBJM53CXk+mT03CbDObJRHTAtxIR3VCBbIox06kmWsmKvcW2Cb9N+9h64+65gR3HoIspcoceJl0g7AnnynRirGFvt/enhzUphuKPCR6An4OSQtTCJmP2Pk6fTJSb0q0pGXZET5JqGk+CNTwcFJagkd9p7tfDPDA50M2VCN3/a7eq3eRrK8p3sIhpK5ahtPmW1PO9tSG8Y7+O/8tAKZegC27qi3G3qHpPL3fpxE/tPGshJR8jnYoD5qmpVKsr64MzIQbFVjeVXjeZpv9yhewfcjKP0+rCMg5qieO2MvvUBtwd5HbREHOYuN+NaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7NXEypW1uRYxxuKX5dlkm+ubizvOOeiAFKZlL5EifY=;
 b=aIIyJ5ia6TDs2YrinDVDHhLsrDuKPH5VxEHZFHPOueKHQKCexgCBv+7Y7wmOiQs/LdiyG5tA9TSHdLoiRaesY6MD4MWlQ18wmzmgBiKw0c2AgHL5ieStHRSSOatMd253buuYYWBYuvo0NC7vd1dMXwe9qoSt786RU4WjXmA1IWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 14:22:20 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 14:22:20 +0000
Message-ID: <274e6669-adf1-4bb3-9237-2313b0d7fe09@amd.com>
Date: Thu, 6 Mar 2025 15:22:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] usb: chipidea: udc: Add revision check of
 2.20[CI_REVISION_22]
To: Junzhong Pan <panjunzhong@outlook.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, peter.chen@kernel.org,
 radhey.shyam.pandey@amd.com, siva.durga.prasad.paladugu@amd.com
References: <20231102070603.777313-1-piyush.mehta@amd.com>
 <ME0P300MB05533B11B123B7C9188B699EA6CA2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ME0P300MB05533B11B123B7C9188B699EA6CA2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0124.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::27) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 314b6091-e412-4ff4-30c4-08dd5cba4e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVJEK1gvWm82c2xjbHpnYkZkRERmYkFiNnVkSmlKeUxhWHFZK25VL2EvdEUy?=
 =?utf-8?B?MGhqSkU2UVFWTUdocGI2RXBxbVhXWFoyRWZxQkdmMnkrRS9WSmU0REM5am92?=
 =?utf-8?B?MTFld2lEditCNlpWd3ZPVERjNE1UVk1KOGNxblExN21TaE5kR3BZL2x6QzYv?=
 =?utf-8?B?VDRGS2tHbmF4bzdCYS9GU3I1Q2NqWnMxQmhIOUJSYmZnN3VJOXZyd1pWVWdj?=
 =?utf-8?B?SW8rVG1lYUhWZ01mY2syQ3NtcHNOcTdTTVVTczgwYlNSd2NtOEE2anJuVGZZ?=
 =?utf-8?B?Y0dJS1liK21wdndDaVc5cVVza2ZoRmFQQTQ0TDBVbnlFZVRlSnl2SmtRS3JY?=
 =?utf-8?B?VlRiSnE4a2FKa2pINUF6RzZncHlBQlBJN2tvYThYWk12WElxNkZSTERvK0RC?=
 =?utf-8?B?NWtiWGNhTmtFQkFqY2hNZHlDYXlDSmNjczFhSGpuUjRNc0Zua2NCdzdTY1VJ?=
 =?utf-8?B?VG9menVsak40R3htNDF4OCtWQnhXUGdEUWM4QnpJTUVHZmF6U2VsVGlXdVhv?=
 =?utf-8?B?YnA4ck92SGhKVVpTa0Y5QzVjc2sxa3JycDlmWXh4Q1JRb2Q4NVlzQzBUTGFX?=
 =?utf-8?B?NmhJMGJIUGtYTC9zbVhSWnhuczFoUkxzZEV6M0YxMlpmZGdzTmQzaDVHcURk?=
 =?utf-8?B?eUFnNzJmeW5nRStLQVBEcXFsb2VSWUZzRC9ESjBYYSt3RFFFK21DZk1jNkN6?=
 =?utf-8?B?blk0Ym9GbDRkbkJ6cVNMMHp2eDdNU1M4dFFrYUcvRW1MNy8yaWVCbU9LbzF4?=
 =?utf-8?B?ZGhRemxnN2dDWGVaVjdITytzK015cnN0aE5xU0s0TVVJa1doMEFMNU9nZGZE?=
 =?utf-8?B?ZGFaeEgxREFVUHRVYUdCc2loTXpnbTQxZ2hxRlpiTy9Tdnp3Y1Fadkl2K0E2?=
 =?utf-8?B?amMvc1BYWEJlYVcvaWh3eWJKQnVpUklZNGF6S2ZFaENjQ3k3NzR5QVM0TG5W?=
 =?utf-8?B?V29BM0tvNkh4eUQ5REF3NWR6SDFQUWVOaUQ3Wk1nMWNUdEg4NmJrN1I4K1d6?=
 =?utf-8?B?TE9BaVRhV2FhYnFyNWd4c25lVWNlVEM2TG9kVTZiMW9WUjNnZENZU0duRTNP?=
 =?utf-8?B?UVBkRStGTXlRLyt3eVJaUlNUMG5HTXFuSUZOV2lWQWVQQVFhZjNKN1d2cG1E?=
 =?utf-8?B?VStjRkx1VUJ2ZmZDVGw3bUszSkx1aWkraVJrWFIxK3JtZ2xYMlc1SnFqc2hJ?=
 =?utf-8?B?bWNjUXA3NjJzM2lDRGZ6a29MNnlLTnhGOTVrbW5uekNlVkRKck91cUJkbHk3?=
 =?utf-8?B?ZUJtbjhRYzhOMGRLRG9xTFBNZnZNQWNhZFFlcmtzd0l5RjZDaFplR25udDM0?=
 =?utf-8?B?N29TbGJmZWNGS2x4ZUkwdTQwK1oxb2RrblllOUN4Z1NnU0JsNWtCU2tHWVIv?=
 =?utf-8?B?b3Brc2QwTW5nNmM1Z1pacjlicUFWd2VNR0JBVzRPQ1QvYnlMakFEaHA1LzFQ?=
 =?utf-8?B?SDRudGwxcW9PQWhQcVhvQ05qOW4xQ2VIWmx6bDVqZkM3TUsyWEp0bisvZ2l2?=
 =?utf-8?B?UzJidmVuZzlZUmg4dUJTUjBYNzRPbFpEak5HaHVhamJndG9WNVd5bnVFRUdE?=
 =?utf-8?B?RVFFelM2d3RvbGVLdURYUzdQU3VKZng2S1Z4Tng2TzlrZXF5dWdWUi9CcnJa?=
 =?utf-8?B?MjZQK0puM1E2ajBPbmFGcnNpV2VTOC8wbFE3ZGFEbVVjWFY5RmRuVTg0ZXlx?=
 =?utf-8?B?NWNLL2w5OHhuYjhQRlJqM0xSdzVLUmNqaG1RaTc4S1lIR1dIZzVxMjk1M0Vt?=
 =?utf-8?B?RFJyR3V3RGdhSWhwakxZSTFGR0VTa0FoVkw2NWxIUmJYVW1OM0dRUVh0UDBI?=
 =?utf-8?B?ZVZlYkhYQlBmVHRTQ0lVVGZhejFYV0ZPTy9hcSt5amhzb2hzWnRaZk1wWTNN?=
 =?utf-8?Q?vuIDZ+AAqpBOV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N25DaG5iMkVrYlhneWhsenJRWkVudFJZRGhxVGpURmdwLzA4MzN3bFVaUGZR?=
 =?utf-8?B?Q3pnM2RpRFR4Vml0VWVvdzV6RFRaa1VvVFdqV3VrbEdXK0FyWVk1WDFNcmVm?=
 =?utf-8?B?cHF2d2xxTVZJczgvemcrRUxGTjFXZXZ5a0lCK21SeDNmQkkyZytKSkd5dW1p?=
 =?utf-8?B?V2dEMDBCUmgzSDZsSGtnYjdDL3NvSnNXWkFVK0ZOSUUwYWwzK09tYW5UdlZW?=
 =?utf-8?B?ZERsUXFiaEV1WnM3UWVKKzg4bHJQU2ljWGRUZlZBLzB1aGhEb1h2WGhjMmxa?=
 =?utf-8?B?VGl3TU01akUwWVdrcndzTWhTT3hOcnpOUzBaTzBHSGYyTTVoS2NEMWJDNytt?=
 =?utf-8?B?NXBqakdoKzJVdzBJMDF5RmNlMzI0VVlPUE5pYTlibmlLTnRqTytMUGZzMHd0?=
 =?utf-8?B?UVdlcWpuTVVDVE1EWHE0RngyQWttTmovSWNlNUpTUDBKdE56Wk1IS3JwQW1H?=
 =?utf-8?B?NXJjL1VzRWJ6S2NkNS9ycHAxQ2dnN1hvTXpYMmkvVitnQ1FaZ0xValg3K1ZH?=
 =?utf-8?B?akZXWDIxTkJ0a21rcXk2OU9wSU1oNGVlc1FMbHJrb21pWUk4dWFiVDVDWS9Q?=
 =?utf-8?B?dkVxMW53SGEyRUZGQWxYaUdOTE9MclJkNmJjS1hPVU9lbUF3WEdNWlVySy9D?=
 =?utf-8?B?djFvZ09iS2RrN252c0dpK0xyR0krUlZTeURxQmFrd3ZnSEduOHZKWmJBMW9n?=
 =?utf-8?B?N2RLRGtkd0JvckJqSWVZTENPcHIwS0UzL1J1WElPZDdUN2dWSFBGdnRaK001?=
 =?utf-8?B?bTcyWURIMWRiWVZlVHI3em53b0pKcmkvUk1sSTFUQ2J3TGcyUkNBbXYrRmlO?=
 =?utf-8?B?VHpjaEVlY3FuNEdvbzZjUFpjS25GOGw4Z2t6dFRydGRIZTJNemxDekRERnRW?=
 =?utf-8?B?dnNYYlBXRFRic01LV0ZZUnBGbGkzZFZ6ZlJJbStqay9ESzd6YmJzY01ZbmZU?=
 =?utf-8?B?QnpkUUtnR1did0hRMXJ1NWw2cDNZT09NeU9ZeEhocHpnQTdHK2w3S2hVcjNY?=
 =?utf-8?B?N0ZQTVBFMDNGakdEcy9POVZ1b2sxNm03b1QyS1V0L3F5d2lLZEQ3b1p6bXJa?=
 =?utf-8?B?eHBDVmVPRWFBMnVxb1hKdDB1Q2hOOXdwZ3c0SlEveVArazE2dldIUjB2QzA2?=
 =?utf-8?B?V2JZMlUrV3RJY3VtTUVxQzlUR1oyWFdXMlFOdExqZVRhV0ZrUHpVWnR6bGlj?=
 =?utf-8?B?VzBWYS9nQysxcjJGaWxoNVk0OERxendvVVgrUm9iZlh0dDJqazluYWQrRXN3?=
 =?utf-8?B?S3VoeGwzYTJtU0pSVEY3L3pSeGFTYlRTN1BOVjZtTUtmQnZPaC9iSzM3Q1JZ?=
 =?utf-8?B?bDJOd3RqeTVRN1FuSzRLZ1lxUVlWWmJrYnc4MzFMOTdvWis4bnBvRHRpdGdZ?=
 =?utf-8?B?bXNtYUhJV2g0ei9FRTVFZTlacTM2N014Nk1VT1QzVGtMN25XL1VaN21vbDEw?=
 =?utf-8?B?OXcyc3RKNUF6Q1lKYThMQ2NKN0FxRlJVdm9XYTJJb3pWTk5wVkRKZjZjL0pD?=
 =?utf-8?B?RERoaEE4akp2ZTdUL3dSYVdFQVZDek5QT24xQTcrZUFDY3YzN3BGS2J0Rll3?=
 =?utf-8?B?ZUE4M1RRVXhqWkdZMEh4SEN2L0hGSWVSbjRNQmVXWWZ2R1ZqUzUyUXpIM2N5?=
 =?utf-8?B?N2k4MllTZHZuc1NBSmMyc2xaaDVIajR4cEMvdE13b0JqV1ZIckQ1VnVXb2J4?=
 =?utf-8?B?NmZCYXZ2ZGtIV0lqdTBhTUdOZHREVFNVL0ZETW1kSk8yWUI1VTN2clplcVZk?=
 =?utf-8?B?TnREczNlYUpHTTdYNTBrSjE1czY3bzZxQlNSYW9tbmFRUldNeHRZYlNuU1lQ?=
 =?utf-8?B?dHFmdFBpbXNWdkdOam9GRk5ZV1RRNGlYUEVCcDVPZTZSQ28yQUpKM2ErekxH?=
 =?utf-8?B?c2ZNNDVrVWJXNzBpODEzV2pMY0ZyOFQrb3lacUJyeVBsblExRHFLeWVuT3hu?=
 =?utf-8?B?Sm55UytLcmxtTDJiQzNzdStoekhqcENZdWhkMlloOTlIbnd0L2xYNXc4YUhw?=
 =?utf-8?B?eDlPUkNxL1BlNUhXOWFqd3IwMkRoMXhOZk8zc1RqZ3VqakVlSWd1dmNWNUVt?=
 =?utf-8?B?M0IzVWdUam1rcVdTMytWS0xDVkpzKzc0a1J1U1hxbUxjQzR2RWIvdWtqcFhZ?=
 =?utf-8?Q?AXrhZFRJWiuY7Q+GCU69nUoDL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314b6091-e412-4ff4-30c4-08dd5cba4e88
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 14:22:20.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwIW3Xdke8jUBhQsjD0948KcuBP3ZD7RdWyyfuCEXeFnpBGxPb5GQJHnACUPiWZq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

+ Radhey.

On 3/6/25 15:12, Junzhong Pan wrote:
> Hi Piyush,
> 
>> Issue: Adding a dTD to a Primed Endpoint May Not Get Recognized with
>> revision 2.20a.
>>
>> There is an issue with the add dTD tripwire semaphore (ATDTW bit in
>> USBCMD register) that can cause the controller to ignore a dTD that is
>> added to a primed endpoint. When this happens, the software can read
>> the tripwire bit and the status bit at '1' even though the endpoint is
>> unprimed.
>> This issue observed with the Windows host machine.
> 
> Sorry to dig through this old patch email.
> 
> May I ask what does **the scene look like (bus condition/dtd status)**
> when this issue observed with the Windows host machine occurs?
> 
> I want to know if it's relevant to an issue I encountered recently.
> 
> I met this a tricky issue with an soc have a marvel udc (driven by
> mv_udc_core.c, it's a same chipidea IP accordingly) when running rndis
> gadget with the Windows host machine.
> 
> When the rndis gadget running for a long time (randomly), the udc would
> suddenly stopped and no longger response to IN token sent from the host.
> 
> The bus trace looks like this:
> 
> BULK IN:
> 	IN
> 	DATA0 120 Bytes
> 	ACK
> BULK OUT:
> 	OUT
> 	DATA1 98 Bytes
> 	NYET
> BULK IN	??
> 	IN NAK
> 	IN NAK
> 	IN NAK
> 	.....
> 	IN !!Propagated Error!!(Turnaround/Timeout Error)
> 
> 
> 
> The driver doesn't receive any further interrupts when it stopped,
> though the IN 102 Bytes transaction is finished on the bus, but the
> TD_TOTAL_BYTES of that dTd is never updated.
> 
>   ep num: 1 dir: 1(in)
>    qh of current ep: 1 dir: 1(in)
>      qh maxpacklen: 0x22000000, token: 0x668080
>      qh td_dma curr_dtd_ptr: 0x658403c0, next_dtd_ptr: 0x1
>      qh buf p0: 0x672dcde, p1: 0x672e378, p2: 0x672f000, p3: 0x6730000, p4: 0x6731000
>    req 0xd81e245540 len: **102**, first_dtd: 0x658403c0, last_dtd: 0x658403c0, dtd_count: 1, actual: 102
>       [qh->curr_dtd_ptr]dtd dma 0x658403c0, token: 0x668080, err: 0x0, dtd_nxt: 0x65840540
>           buf p0:0x672dcde p1:0x672e000 p2:0x672f000 p3:0x6730000 p4:0x6731000 scr: 0x0
>    req 0xd81e245b40 len: 1558, first_dtd: 0x65840540, last_dtd: 0x65840540, dtd_count: 1, actual: 1558
>       [---]dtd dma 0x65840540, token: 0x6168080, err: 0x0, dtd_nxt: 0x65840080
>           buf p0:0x20ce50de p1:0x20ce6000 p2:0x20ce7000 p3:0x20ce8000 p4:0x20ce9000 scr: 0x0
> ......
> 
> epnak: 0x00070003
> epsetupstat: 0x00000000
> epprime: 0x00000000
> epflush: 0x00000000
> epstatus: 0x00020002
> 

Piyush is no longer with us but Radhey will take care about this.

Thanks,
Michal


