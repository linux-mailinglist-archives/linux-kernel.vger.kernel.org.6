Return-Path: <linux-kernel+bounces-227386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E857C915066
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A4B1F21AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF3919D068;
	Mon, 24 Jun 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ba15pKeD"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3D219CCE6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240246; cv=fail; b=u2MS5MUlTTsCp6kOmNKEAOri56xG2yw2OzJsqc50ffFHmzxCgdOXaiF8U6l+sT2Cd7Z5AALgf6DswTPVJREtJ0/X+2RSkNkhcPknJPexTSLbcQPFTz8KAFPmISiuwXDHQD4+R3IL39pJEpaVXSad1DMFTmR6cHi/VsufoAmKI+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240246; c=relaxed/simple;
	bh=qkSdkVcGqRv+ssZ2Ua7CFmgHG60VX1iJPjPMXHnIk14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wq002eJuI3RPjqkJrNmRk6/xN1B8Q3rWTvNAp405rXJz/+BWQkQwrDvdK9ffXYaxJ+dnv1Km/zQTEvhGWzzctxfqtB+kf9iYwMVmu0GRzwbP0pYxBDO069Hsqsbl3pobrqLZSNiJeaNU163SwLLt0B2l/KmRBIriT6Q7eKVSi6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ba15pKeD; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/t6SCMsaY0zKcxNbEfYKitIgxT9NG3RGXqtZMooENJ40a91TDdIr4UIoaHf/8f4mmCIIUcVoevk2UDxWzLlUYDWspcJUD3G5cKYMV7fd2ukE8rOrLvcf1m9vNQMXrJpffnVKD2X5e6ucx/s1xejTondYTEI2tTAZsW5kw6CgGlpTMYXwzuzwd4iBz5ZUFJQX2pCyHNQO92oBOx7B6js4TBX/ql7WBhh/lWN1Bp10HQGqfUkyoxVL47WQsohik0MyXaaPxNdGKSTiBb3CwcpJUUuQXJmwI/RQ3qOGphVxpJ0jEAaxvaDa/6ldO2zuKaT4iHtxhDyHHPtRtXKKgHwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw6F9VJpmVw2ju7BzoBnigwJwJRJzvIfJ+SaQ/pO4Go=;
 b=Bx4XXZy2mAisjB+WCCOtQnHFJskB1C9klkkfPBca6BBbh9FgtvHzq/yw9ZATub2bq2fnGbzFjWLvkS3NQoIU3GcxE20UT+lJxIw/71iVly1D7yvVcBMmM4JUyntOZ4BCc43qDFFf4q8IuHVz3KsZpN7MNV72mfhc39HvWKQyoHSkrpixbyPKYRAfDg690sMngutd1RbKHJfzcxtKpDcUZsbUJ/9Bq2X8mXHiJecMTzQ9YnqYJJNxYjji0ltoXaI/A4RHWbJCpBpUOI1tXtoXGuW0ONOaUaAYisbhaKSaEDyYYswPUEs2xeaKRS18F3rOGCYstQkoVbrZKJHeZ1muSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sw6F9VJpmVw2ju7BzoBnigwJwJRJzvIfJ+SaQ/pO4Go=;
 b=Ba15pKeD//WSN34uorMV4P1sAWyxWilKOHAxrRJjAqdIymAubrcZ9a0pugYOxGcjP06UULuNnjTlsd54rgrrXk5Nsmu5Kn+B5V2Fle+GPBkLTqEu9SYqFdmU/riBZsf1nQz6DF64bS7Rhlfgd4kaJVmtUy7gfkvyI/aKLKfqTXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 14:43:59 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:43:59 +0000
Message-ID: <264f6409-1b07-4608-aee6-26a737664dcb@amd.com>
Date: Mon, 24 Jun 2024 16:43:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] firmware: xilinx: Add support for secure image load
To: Mounika Botcha <mounika.botcha@amd.com>, arnd@arndb.de,
 gregkh@linuxfoundation.org, michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org, kalyani.akula@amd.com
Cc: linux-kernel@vger.kernel.org
References: <20240610161313.14889-1-mounika.botcha@amd.com>
 <20240610161313.14889-2-mounika.botcha@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240610161313.14889-2-mounika.botcha@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0035.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4b2c6f-3a98-4f1e-8e36-08dc945c150f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekI3aDVqWVQyUUloVFNFb0NnNUxYeVNGcFNPMGhwZVU4VWlHN3NRbkFSV0lX?=
 =?utf-8?B?YjdRL3J3UFZ1VE1xSjk2TkxvbHIrMlN3SlJyZ3ZHTUdEZDZNeWp0K1F4Rjdm?=
 =?utf-8?B?U0dPakZYZmU3WVdZd3hncFV3OXJoaWpxUHRsU01CTE9aTE9BWWdGNzdMQjJI?=
 =?utf-8?B?ZFFkNVZNcG5STkZkeS8wc0diazU5eTlCNWpJenZQTUlTRGhFRTI1Wjhxb3Bx?=
 =?utf-8?B?VzdDR3MyTjBEQ3l6bUkwemxsY3NhYTVNQjVWK2QwZHkvU1daeHFtQWF6bkFY?=
 =?utf-8?B?QlJaQVEzcUYyaWRPdHlHR3RJWnRPUlp2ZlZXSVVKTW9LZUQvaGExUWoweDE3?=
 =?utf-8?B?SStVTThnUy9LQVd3RjNFL2VVOTJGaGpJU1NlaWh0SE0wVHhITnlJZk14cSth?=
 =?utf-8?B?VlJ3V3NEa2JJMGJPSXVJcXhSV2N4YndlQS9pV25ZNG9rU0NQMVYrWllkbUln?=
 =?utf-8?B?Y2hJTFNyNnRWekp6UXpVOEwwM2pkZ0Nsa08wN2U4Tit4MmNZWEpFaDg5Q3Qr?=
 =?utf-8?B?OXRIelArWFk1aG1JM1R4UkM4c3RZMDdQcUFjYlVvYjg0OE9yNGx1OXZhdDk0?=
 =?utf-8?B?MjhQaDU5MzZXSUlJQ2RncHNNQTFwcEZpRjhyNEJMdEYwTUk2dzZxUjNlVXds?=
 =?utf-8?B?d0lmR1FDZWdQUWI5dXNqWllQV3FQdmhoNmp2eHlhckIyeFFBTmRqMytkdHE4?=
 =?utf-8?B?TWM1alZ1ME5vMHBlblgveXVBeG0wSDNQOEtDdmd3Q3BscEJFMnR1K0VIeGha?=
 =?utf-8?B?TkFpTE5oTHh4aXQ4YzdIbm54TEFOc3N1QTd2VFlpUDZpeG1OQVdtS1RFSTRS?=
 =?utf-8?B?NmRZU3RNTWF2SEoxQUpEYUZMZEsrWmxacVlzWXRsdkNNcDlNQ243RG5ROW5C?=
 =?utf-8?B?SFlBaXBjZ1pOOTBnc0Npekd2cmhOMjlEVUhuTEN5aUtQeWF1ZEI2UFdlL1dw?=
 =?utf-8?B?b1lUNXdXZkJjb0ZsQUNoWituUmMxWFJhZ0ZpSXp4eE5iSFNpZXdPN2J3RXVY?=
 =?utf-8?B?S2swZmQ2cndhS1ovMUd0ZU4rNWI4ak1WTE1hUXczaUxKSEsydFVwbGZQMkJ5?=
 =?utf-8?B?V2ZNdWw3NzNVdTJyMVMwNUVwSFpmNGlldHhSUzcwNjF2SklOWFlIM1FaMys0?=
 =?utf-8?B?VFJXM3drNDMzTy9SMFQraVNYZUl3WWtWRVFhbklrOS95TVVnN1BOcEw3UFBo?=
 =?utf-8?B?T1VSQ0hlMHU0b3k2TmVId0lBSUEzbHo3VmpLWFhtSU9uWk9JbjNLRXJ2OTRF?=
 =?utf-8?B?dnZxcGh6WTZyTmsrbDl6N2p2dEF1S3F0Ym1Fa2JYU0drdnRqV3ZrNGNUUkRZ?=
 =?utf-8?B?QTc5Tk1VMFZnL2xwS0FNNkZnQldBSHg0eWVUZUdyL0Vic2hsU2xEa2F2bVdz?=
 =?utf-8?B?WXpyZ09wTmJZMm0wSlFtYjlaTlJoKzA1b3N6K2VqQnAxREZuZksvODNvcG1n?=
 =?utf-8?B?RG1Wb25ZcGdBVkxBaThmamEwTE9JOGIySENzRUxLdkd3ck14Q0dzWG9xK3Ry?=
 =?utf-8?B?NFhHWmNSZ2d2SGNMRUJmeUpKRksyeE4ranhKa1Q4bEkzQjRBbFl1TWRiQVI5?=
 =?utf-8?B?dWw3c1djT3NvUW5UWjV0eVhFbXFUMGNCdzNCNTBVU2h5bE1uQW5USXl4Z1Yx?=
 =?utf-8?B?U293SjNLS012eitmVHdnYzVGVHNGcjhXbm9DWHBYaFNQa2FsM2ZQTVNPLy8r?=
 =?utf-8?B?dGpEOEs0ZGg2dDBQSFJVT3VRRTIwQWhSODRBSmhTZDlYQkt0Ulh5dVpVMDda?=
 =?utf-8?Q?j3Wd7sftXjRxBkGa6fQhfN7nh9Kr5Yksx0tguDE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXNFVTd3bVl1S1ZGRnFoY1R0Y2w4c2dCRTVUM3UzbHVwTG5Qd3MrVFVtNm1O?=
 =?utf-8?B?cjRtQ3piLzRqOW5nM0JrSS9wQjZTNXVpQ0xVNXdHM2dVbHZna0pKZ2UvSFI1?=
 =?utf-8?B?SXkrUFgwK0ZaM1pJV2JXZFZrK3VnZEwxbnJraXlpZUU4THhPUXBnaEtUdWVy?=
 =?utf-8?B?aGVVUFhMencrVVNWYzBrUHFPcVFMNUNyRzZKNFNiRE0ySGZYYUJRTldXWTl6?=
 =?utf-8?B?b0MvTUtUY00rb2NWY2ZmbmdCaXdRdVRPODYwVTRIcTczeWhOWFp0ZWYyUS9a?=
 =?utf-8?B?UzVNeGRrOEwzelhBRTQxb25Dekx5T0JLQURRdTBDSi9QcVBrSGlLTHpYRFZF?=
 =?utf-8?B?eHVJTXdQRlo3VmRrOSt6Y0hJVkkrbzRVeHBKRVFwMnVWMGx2NjZ2Y1owUnVG?=
 =?utf-8?B?Z2JVVEhFQm5NbW82Z2d0Nm1BelptVEtvVGgrRFhOT0lybkx0aHZWazg3eGFB?=
 =?utf-8?B?ZCs4Zzd5aFF1MHJqRzRiZlFudUtvaHBlSTBMQk5jTU8vdTFsZHEwUVpNYm5y?=
 =?utf-8?B?UE8yMm9jcUkzMzkvblJURnZhMUIyUktkQnFXYUk0S0Iyck9ITGJqZGo0VEVD?=
 =?utf-8?B?K1hjMEhGaWlxNTAxYW1Na0xCZnFSdFZHNUk2MnpYVjlBZi9RQ0NFcFd2cmw2?=
 =?utf-8?B?Ymd4RiszbSt4d0xTUlkrOUZNNmt6NkQydDEyTk5DeDFHZlNsSTBNZWRWZ29r?=
 =?utf-8?B?bzc2cG41SUhFTlFZaFpTUWpFMFZ0RGUxMGFpb1IvVGR4eWNyRjhUZE41bGQ1?=
 =?utf-8?B?UTBsL3BJTnNjenBQVEFHaGdOQ0NncW5LMTZiRDN0Y2dRblo3Z1hZU0F5aE1i?=
 =?utf-8?B?Wk5ReWtIR2wvQWV4SmN0dVBqWUVtVldVUTlTU2hHZjVSM29qYmZxNE5JdUZD?=
 =?utf-8?B?bEk1RDBGS004UHhsZ2tWMVZDajVrOFgrYjRQVTZScmxqOG95NU4vZm9QWUVZ?=
 =?utf-8?B?Nk9aSzVsK3dSY0g0ZDdndy82bkhTU1prTFArYldBU2d5citqSHJrYnhoRWRC?=
 =?utf-8?B?ZnVYcHF2c3diVXBTbGdKalFSY0lxS2FNWVU5UTJLbVVRQmdoSkZsMjZOYXBl?=
 =?utf-8?B?K0MvOVk3NlVsVUtSUWI4VHN2bG1Nb25XeU95VC9OcE84RlpTc2hZMXN1cG1Q?=
 =?utf-8?B?L1hGT2I2T2IrSU4weFplUDRLS0FyZURBOUhRNDI5SU1kMWs1WnJRaVgvcUF1?=
 =?utf-8?B?QWludFNlSWxlREROdXBWRWhkaW81UTVOUnN4T3RKNWphcFdLUitFVm8xRFRj?=
 =?utf-8?B?V2FoUlNWV0ZNSllxOSswMG4rOW9tUE90MXhJcVdMcFc4YkVPUERTak8yZDhu?=
 =?utf-8?B?S3VVUTJEbm0waWp5UkExbEljWC9uQlI0T3hYTkZPVGlUZjNGUXl0QzRBWHU4?=
 =?utf-8?B?L1MwaitsZFJkN1JNN2piaFdtZCtzSWMxQ0tPZWRXYnRiNTdnT29kem9lOHox?=
 =?utf-8?B?THBlYXFObzA0TDFoWWRiV2dOMmcrak9CYmI1dDV6d3hHSXNjc3hhVU9IaHJ5?=
 =?utf-8?B?aDFFcmcwcXFUTEFqMDlPMTRpcjZKQ25mM253bE0vRUM0c3doaElDMm9wZlVn?=
 =?utf-8?B?QzNaWkI5Z2MrUGxnRDBLdUM4cWZTMjlpYld0aGdSeEtubEk5Y2lKUXhOU3VQ?=
 =?utf-8?B?Nk0raWFOYzNhS1VPQlQ0VFdVMW1vYlNNNURUOHBrL1pDZnhvOS9iQXI5L2Zs?=
 =?utf-8?B?UlRBOHJOb3o5aWxlaDNmd054VzEyWG84SFVwS0pMb1d2akVEcDlPdDg0Y0tY?=
 =?utf-8?B?ckVqT2ZiRTNjdER2MVRlRjQ0bndKK0FZVVFjV1NvQVZCcFRTZFhHeG9HcThE?=
 =?utf-8?B?Mi9YUTBPYWlyZGlpckZwdm5ETFNrb0tlKy9FdkVDbmFHNTlLdERvNkJMeXpV?=
 =?utf-8?B?SXFLaHNNVWlyeURhanNjczhEdElBTWpGMElvcXViQzh5d012eStBZHYwV0da?=
 =?utf-8?B?L05GZWYwR0VLODlEU0ptbUo0ZkIrMC9NTkRqQkR1ZFlyNzJSamNQM1BGLzR5?=
 =?utf-8?B?UFpPMlpTU0RUcUFoS0dxaE01WUNJcEp0TXpYeENFU2MzL3Q4OUUyTFVMaGRy?=
 =?utf-8?B?YUFiaWFSWVI3OTNLMVVBSlJRS0Y0U21MYllnTkxqRmNZOWN4N3IybkNuVGNq?=
 =?utf-8?Q?eOdjZTmWi6lykGKFKbSEHqc1+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4b2c6f-3a98-4f1e-8e36-08dc945c150f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:43:59.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0awof1y/3wHki8tw+wOJdSR1U3KPeWLa95KZ2IqzzSOfqoucPHihlTQOLQVUNY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589



On 6/10/24 18:13, Mounika Botcha wrote:
> Add support to load secure image from linux
> 
> Signed-off-by: Mounika Botcha <mounika.botcha@amd.com>
> ---
>   drivers/firmware/xilinx/zynqmp.c     | 31 +++++++++++++++++++++++++++-
>   include/linux/firmware/xlnx-zynqmp.h |  9 +++++++-
>   2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index add8acf66a9c..c46280241589 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -3,7 +3,7 @@
>    * Xilinx Zynq MPSoC Firmware layer
>    *
>    *  Copyright (C) 2014-2022 Xilinx, Inc.
> - *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
> + *  Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
>    *
>    *  Michal Simek <michal.simek@amd.com>
>    *  Davorin Mista <davorin.mista@aggios.com>
> @@ -1358,6 +1358,35 @@ int zynqmp_pm_load_pdi(const u32 src, const u64 address)
>   }
>   EXPORT_SYMBOL_GPL(zynqmp_pm_load_pdi);
>   
> +/**
> + * zynqmp_pm_secure_load - Provides access to load secure image
> + * @src_addr:	Address of DMA buffer where image is stored
> + * @key_addr:	Key address
> + * @dst:	Destination address where image is verified
> + *
> + * This API provides support to load secure image from linux
> + *
> + * Return: status, either success or error+reason
> + */
> +int zynqmp_pm_secure_load(const u64 src_addr, u64 key_addr, u64 *dst)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!dst)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_SECURE_IMAGE, ret_payload, 4,
> +				  lower_32_bits(src_addr),
> +				  upper_32_bits(src_addr),
> +				  lower_32_bits(key_addr),
> +				  upper_32_bits(key_addr));
> +	*dst = ((u64)ret_payload[1] << 32) | ret_payload[2];
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_secure_load);
> +
>   /**
>    * zynqmp_pm_aes_engine - Access AES hardware to encrypt/decrypt the data using
>    * AES-GCM core.
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index d7d07afc0532..6e03f0f72427 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -3,7 +3,7 @@
>    * Xilinx Zynq MPSoC Firmware layer
>    *
>    *  Copyright (C) 2014-2021 Xilinx
> - *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
> + *  Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
>    *
>    *  Michal Simek <michal.simek@amd.com>
>    *  Davorin Mista <davorin.mista@aggios.com>
> @@ -173,6 +173,7 @@ enum pm_api_id {
>   	PM_CLOCK_GETDIVIDER = 40,
>   	PM_CLOCK_SETPARENT = 43,
>   	PM_CLOCK_GETPARENT = 44,
> +	PM_SECURE_IMAGE = 45,
>   	PM_FPGA_READ = 46,
>   	PM_SECURE_AES = 47,
>   	PM_EFUSE_ACCESS = 53,
> @@ -587,6 +588,7 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
>   int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
>   				 u32 value);
>   int zynqmp_pm_load_pdi(const u32 src, const u64 address);
> +int zynqmp_pm_secure_load(const u64 src_addr, u64 key_addr, u64 *dst);
>   int zynqmp_pm_register_notifier(const u32 node, const u32 event,
>   				const u32 wake, const u32 enable);
>   int zynqmp_pm_feature(const u32 api_id);
> @@ -854,6 +856,11 @@ static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
>   	return -ENODEV;
>   }
>   
> +static inline int zynqmp_pm_secure_load(const u64 src_addr, u64 key_addr, u64 *dst)
> +{
> +	return -ENODEV;
> +}
> +
>   static inline int zynqmp_pm_register_notifier(const u32 node, const u32 event,
>   					      const u32 wake, const u32 enable)
>   {


Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

