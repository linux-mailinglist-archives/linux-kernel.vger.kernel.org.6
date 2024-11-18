Return-Path: <linux-kernel+bounces-413155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6949D14A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8039FB2BD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F38F1AC45F;
	Mon, 18 Nov 2024 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sq8+M2Ri"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B91863F;
	Mon, 18 Nov 2024 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943182; cv=fail; b=ThPwVHXgfNS8EMxfMISJfnRtGRwgJsrxiDaLl65Y5dw8ilz81vecJJI1xNu51OLMIAvuWkeL+5lhaatwXvTKUfUy4dljIUBFAC2a0/Lk7aDw/fncSf07Pmmq9PDWhWZDMzhG7suAAft1WyNf5xMzWTUL2ZExv16IIPIXqUOrusc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943182; c=relaxed/simple;
	bh=GOV7nrlNprPrsiGHp8QA/Ko7FL+QGCGd+NzSndSNdhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=efVwmIMThIqVABiHtzzEwkBDa3c1PNDx2DMKmKb9S1PBjDip5f+YX/PE6SNKm+oUCGsiEDFNbyGzVRie4TJkpowvfxA2ABqDNVQVCWZZ6fJ9ai5NejAM68h93UPM2NA1SuyWBSUfVz2+O64fUhPP9jucheVb/hcsg3tqwaPB/ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sq8+M2Ri; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYIDesD3WUYm5pmUIo/pKVJNLhOmNZVg4ak40t4dCkMygS3yYCVCHs4M/XGb/Aud8jrPKy1D8dsWLnXjRaBdMQ9ateEBeb2TevMzzBUTM2gxtZZgKAwVqydvkPxoU2lPmM7Qq9KjSXD3Ef8IffDRbK0IBrDm1MKGjYm3D89DCDV6uWw/SN3JowFpmS93MUzRICpJIyZ9llo/OJ10JeQzZU7fL3t53oF8G5VnKgGC6WkYoleUJ1KGMm+S84yuD1vLfm+GKvLFjiDEmCEWwdLvDIEYtr9IrwtlEq+AHDiTrsjeaUs3WdZNTqwKWX12jxjV05ipJa4fcMSgubtilKGXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGqXbFIRaRsVxvGhYQQiMGuHIbj80sG66gigMOs4sAg=;
 b=xxvWMbeMTVYTbxj5pt7hXAzoK3ffNwQrkUzL4LcE2RxCqSHMVeiEuzNdk6SsZEMZjsOEywWYk//Q+vhylPWx2VHeGWQumzRwrjTQEm2nzrwP2jUED6lpGJTkX9eOxOU1x+9baM7R0mOLXMQ13J6wJYEnicHSAI5GByDDdoeOvZ3p9KBMXDygrCgPuIaZ800SRbQsM4yP/CtD88G1qNVdQ3aJSibeePQCIMVH2NAETUcjawfNVprs5ELDOngsj8fRjymewCHA7XouGSBZxMXyYk9m4tmpa2d1U7z/PZkSI+I6tkW/wvpEGhvTLsYW+bgCfdeutATzH6a9OdpMco7M4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGqXbFIRaRsVxvGhYQQiMGuHIbj80sG66gigMOs4sAg=;
 b=Sq8+M2RijIHeyKv1MCZA72P5Unerhn0CrG9ED1jFUzGJhX7eLlPip/VjRjAI/HhNP2xNzLnUtmPB8BPScndiEjh4jrX0XOP6Nf0JSdPkuXxVR+wzq5WWLevzaLMIuX1WPGycRPUvDXGp7AQ5i1imTXTk90q3lrBU8quQWX8M+Lw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Mon, 18 Nov
 2024 15:19:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 15:19:35 +0000
Message-ID: <cfe6dfa3-2a03-4dfa-83d0-3e502a2d0a96@amd.com>
Date: Mon, 18 Nov 2024 09:19:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Lenovo Legion Go WMI Control
To: zhixin zhang <jonmail@163.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhixin zhang <zhangzx36@lenovo.com>
References: <20241118100503.14228-1-jonmail@163.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241118100503.14228-1-jonmail@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0040.namprd05.prod.outlook.com
 (2603:10b6:803:41::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: a49006bb-a495-43e9-ee54-08dd07e46942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEFOdU16b2pnRExmTWlwTHhJUDJYSTcxeHpXWUNya29DVDJheHQ3dERzSmg2?=
 =?utf-8?B?dDAxZ1ppS3dUeDY5OWorakM4ZkVJd0JlOTVOV1ZQWmM1MER4WExPZXlCdXJJ?=
 =?utf-8?B?aWJEaUNteFVYS3Q3a1J4ZFhraWVSSi96VDhBTzdoYkdvSm9IUDNDOUdSN2Qx?=
 =?utf-8?B?VUtoa1dlOENaR0pnUUh0RjdXWU4zbnRaU2dqLzlHRWJ2eWtUVDlNQS9Mcjhx?=
 =?utf-8?B?STJVeWRaZTV5T08wWURJc05YZ2hmZEVOaTB0OWRTRDVXbHZ1ZFN4dXdCSWZv?=
 =?utf-8?B?cDhLdS9Rc1lsaXMxdEpTd1BWaFltYXJyN1RBMmRDY1FUSlpDNVl5djNzZ0RR?=
 =?utf-8?B?ZkltSHZob0pyRHVReTY0VG9PcmQzMWQ0ZUlMQzBWejFTZFE1RHRKY01yRjg3?=
 =?utf-8?B?Wjc0cnZqNVR1bDBDeU4wczNFakJreVFYYjk0QU1tT2dabGQzdlBFR0thZVJV?=
 =?utf-8?B?QlE1dXpIOG5IQlNOSE5kWXBrY3prdGkyckFBTDlaV2tkV0VleXFzbGRITFhn?=
 =?utf-8?B?U0lQTVVsdmlicmxid3FCcFlGeTBGYmhFdzJZZFRwNFRGQTNoZVAvUE5NVGh3?=
 =?utf-8?B?aUljSnFnNFQ3c1FndDBEVnJiSXV2U1YzM1pNTmFVbHhXTmp1dUpFTldGVWla?=
 =?utf-8?B?RWt3aExJZ3BYL2VFL2FsZkpyZzZvd0o3Zkcwa0VxZGdlVGtjQTZMdnhLN1JR?=
 =?utf-8?B?WDdtcUxuU2lJdVdNM0laN1NzYXZ0WlFOdkw5V0xXYk9WZ2htVnhaMWxuSFA2?=
 =?utf-8?B?Nk5YanQyVkZJK1lpVG0zc3ErNGNmeG5tVUIvL3lOL2xuUnREQ0w1V1h5MlhX?=
 =?utf-8?B?Y2c3N0J1RW84NmhMOGdpMTh0K3hBUXZtSTN2QXlJRGQycGZmdVVZSzBPWTgy?=
 =?utf-8?B?SVQvNlpaclRuZ0RQRnlkYWIvNEdvVmtFMFZPMGRMMTRZMkdoL3ZpNUFRRmM0?=
 =?utf-8?B?Y2t2T3JyRXJXNFNZakNqT0kwYWgxbUcxd292NTVpUGNPN2xQR0EwUEI0Mjlt?=
 =?utf-8?B?anFROW5OMU83R3c3TDJWdFRDTmp0MUJQcnVXM1ZrWGNxRS9VNnM0MzNzSVNC?=
 =?utf-8?B?bUJaRHJQdUtZWWxOT0FzLytISnJyV3ZuU3YxQ2NXNXh3cEQ4MGs1Ly9IVDhi?=
 =?utf-8?B?bTVpTmpjNzQzU1Bya2doN2ZrQ2dxNHR5UlRCWVdKOFNOd2daSGlxWncyaWFv?=
 =?utf-8?B?L0o0dEp1enNGbXZyMnRIZE5xVDFLNU9yM0JyZHdlbmZQRVdJbWROUUxlbTZy?=
 =?utf-8?B?T05ZYVZ4MmZCTno1UVZ1UDFLdzdLT1plQk9wckoybS9uVGZ1S3dQZ201WWhx?=
 =?utf-8?B?MHduT0kwNU9ENUlYaHJhWFgrV2FyQkpSQ2RZcGNXVERjK1orb3pOanhYU2FT?=
 =?utf-8?B?M0lmelQ0RDFxWlpwVk4wM2cxTVVHL3MrV281U1RkbVNBdHBKSXdMV210NnpH?=
 =?utf-8?B?NVB4Ky9jamFFTXZmWmlmWndqNkNDeE9jeXlNbGppMmVlbUR6d2xKK3hGOGVh?=
 =?utf-8?B?ckg1S3RuZTZUS3BvVm5Ga1g3clF2anVVd2M2RHpzWlFmVmRFTjBsTUU1RzNh?=
 =?utf-8?B?eUFDd0loclNlSXJPUUVpbVpKZjBSc085OW5LVzRDTFRxUG1kU09wWDNSWnRu?=
 =?utf-8?B?NkFha0pTUkUvdE9OMmJOWmhMT0FyMlA0aHV3WHZ2aEplOSt1NVFQdUsvUENM?=
 =?utf-8?B?U2d2RTZNRFIwK1NCUXZZdEtYSHhwTmVsQmltZ3dFS3d1T1lnN1ZyNTFaclVQ?=
 =?utf-8?Q?7az6W1bVgfEgg786uZ87YYFS/V5/fbWYZcDCHMF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0tLcklaazNCNFhHSk5Dd2QzYWNqeFF2SHg0cXR6clpCNDRMekdyNCtBZDNv?=
 =?utf-8?B?U2paUWcra09SQW9zUmgvdG9GbHR0VTFQb0FTUHZrdVFZcHYzVkllZnFDRmI4?=
 =?utf-8?B?b21oMDdpekVmS0RpYkVXRk9OaWU4aHRpVEdnTDg1bHEyTmZTOTd2U3RXTDhQ?=
 =?utf-8?B?QzM4Nk9FSUd5ODAyc1hrVEREa2lVZG1NNnZOeVovZXE2WEQ3VVVIOVZybXVS?=
 =?utf-8?B?N2pyeUpmR1pCL3FuRFhla2wxT2xkOHhiYmpDbDIvOHBMb2NWZGl5WWlqSjE5?=
 =?utf-8?B?NEZ5T3ZKa3dROFpVTS8xQTNkaUUzMjg4VHUvYnF3V2w5T0Q1UTVsN1NsOU9H?=
 =?utf-8?B?dkJTOWkwbzFYUllPOUg2T0ZXZVV4dTJJbjg1RVV4VnJ4SWw1QmRSS0cyZEF1?=
 =?utf-8?B?OWdkRm5wa0hLU3NKOHpMZVZyT1hWcDJkL0J6cEtWTldLUy9HZ3VGQlVHOWtm?=
 =?utf-8?B?Q01zdUZ2dEpUNS8rSFNQTWJpRTA5Q2NVNmx3di9nV0NCc010bUNQWUM3bGwy?=
 =?utf-8?B?SFVQZjFMYXFNbmZzRUQ1UGZYN01PQzJNWWdJUDNjbEsrdVY2SE8xelo0bzRS?=
 =?utf-8?B?NXprb3FzUDZ5WW93dWw5WEZpaDlGSWRPWXBiTkhMaW9EM2NnbjBIRWFaYWNy?=
 =?utf-8?B?QUd3Z2JsOTAvUEdOMGowYThVbFI3S2JQM1hRUGRRRUhxN0o3OXVqU1ZwbW5E?=
 =?utf-8?B?OGQ2REtlanczUE5vR2FTc0ZwQWFDbjljL1ZVaFpxRXBZTGlLbkR4N21KK094?=
 =?utf-8?B?V2cvY0RvdU5Ja1RZZGVWS1VITm92TGlVS2szM3hlOFZQVXlwMHhEaTJGZDU3?=
 =?utf-8?B?RWIrZFZMMFgxNGMyL3Zwbys2UnRSU2daamt5K0pKd0FGL3FoTUtvOXJOMXkv?=
 =?utf-8?B?Z1g0MVV2QXc5aFVXazMyWDMwaWo0ZzAzUnQ0MkphbExiZ0tEK2I5SWNYdXJk?=
 =?utf-8?B?RFFBUWtPU1E1azFBQmJYZ3ZQeEFOVVN2ZHBWQkpuT2gxUFNOUERsNHNodCs2?=
 =?utf-8?B?ZmhMeXgyeU80eVVJbm16Ymw1R3hGdmxEMEZ2OTMvNS9lN3JLNUNPd3dKZDNt?=
 =?utf-8?B?OE0xR1N6bWZXSG10Y0xDNDIwTHFZRDhLMmdVczVIeHIyQmh5djhML3lEWXBs?=
 =?utf-8?B?Vk1PclhHRGU4dml4N2ZGT2RMYUZnRVhETU5yYStnb1N1NDB2RHpNZjdUNU1m?=
 =?utf-8?B?b3pUSlphanR4aVgyMCs3SXZHcTFXTVN5STArN05ybUh6aDFFTUpwNzN6UHhF?=
 =?utf-8?B?amdlQi9SRG1NRUZlckFEQXVUQzI0c1MwdjZjbTRRUm1IVE9GZ3BtUHYvY3E0?=
 =?utf-8?B?REpDUkMvV3ZBc3l2R0lCQm5iRm1LNlFXWDNuZ0doMExTZmtjNkpoLzM5aURF?=
 =?utf-8?B?YTVVOU9TTndxV1BsWElvZ2JqUXpiaHZCS0VBUVJ5OSt1Snp6M3I4TlkvaXlu?=
 =?utf-8?B?Q3lXSWh0YVZhbjZITDByOVZha3FsM0xKSUpFYS9LK2JiQjNmY3prREtYRkE5?=
 =?utf-8?B?bUg1VEtyMVk1Mk5QMXlsVVVKUlhRTEpYSm1WM25qZmJvbkRNU0xwaUNyaUt1?=
 =?utf-8?B?ZGdiNXFmQ3Zib25VRkVYczRWenJ2VFUwNHN0NTEvdFFpOXNiWDMrVVFINzhZ?=
 =?utf-8?B?eElNYXNzZjA1YURHZlZ2NzNVdnpkTldtV3hTdGZxd2M0eU5iTlQxb0ZaWUlW?=
 =?utf-8?B?My9DTjVoUlJIWGVTd3BlVW9wZEpMZTdCM3NiSzcwbEhzZlFBQWdZVkFPcU8y?=
 =?utf-8?B?dVRRODlBUjNjOS9uWEY2ODNUalQ1bTB6UU5vanpReTN2TEhNb0JaMnZIN0dP?=
 =?utf-8?B?WllzbHFBWHpGR25xVEdENmVCRkwvNFlrMnRoUFZpYXFzcUZ4VHhhMG00RkVx?=
 =?utf-8?B?ak9MMHlidVk1Ynhnc2pNTzIxMGxaQXhvdWdsREdpNFJYV0Fha0dIalQyVFRh?=
 =?utf-8?B?dXE2L3ZQS1NPMFNsQkMvU1g4eHFXUnZxNm04SWZWVW56aW93TW4zUmhwR1Qy?=
 =?utf-8?B?M3dVdm5waTk4citWaW0weSsvUDMxQTY2Uy9KcnFYUTQ5ZGZIdWw4V0hkT0tr?=
 =?utf-8?B?SFNHb3JaOU1BVGtYdUc0MzFXV01BMVlEL3kxSGNieFBSUVFtYlNCSkROVk5Q?=
 =?utf-8?Q?LcF0nDWR91mWtGrBH+Ail2qUb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49006bb-a495-43e9-ee54-08dd07e46942
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:19:35.7701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewQ7UDemwkBB/oNQY3qD9RwsXMh7G9mx3qy19WrAQCTLtMs9wGXdMDwD6Fya00DY1OIvqs1sqszhdJPJrcTQyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050

On 11/18/2024 04:05, zhixin zhang wrote:
> From: zhixin zhang <zhangzx36@lenovo.com>
> 
> This driver provides support for modifying the performance mode
> function of Lenovo's Legion Go series.
> 
> Signed-off-by: zhixin zhang <zhangzx36@lenovo.com>
> ---
>   drivers/platform/x86/Kconfig         |   9 +
>   drivers/platform/x86/Makefile        |   1 +
>   drivers/platform/x86/legion-go-wmi.c | 552 +++++++++++++++++++++++++++
>   3 files changed, 562 insertions(+)
>   create mode 100644 drivers/platform/x86/legion-go-wmi.c
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 3875abba5a79..d04018f69dc6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -483,6 +483,15 @@ config LENOVO_YMC
>   	  This driver maps the Tablet Mode Control switch to SW_TABLET_MODE input
>   	  events for Lenovo Yoga notebooks.
>   
> +config LEGION_GO_WMI
> +	tristate "Lenovo Legion Go WMI Control"
> +	depends on ACPI_WMI
> +	depends on INPUT
> +	help
> +	  This driver provides support for modifying the performance mode
> +	  function of Lenovo's Legion Go series, as well as the ability to
> +	  set CPU power consumption in custom mode.
> +
>   config SENSORS_HDAPS
>   	tristate "Thinkpad Hard Drive Active Protection System (hdaps)"
>   	depends on INPUT
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index e1b142947067..74b1f107084f 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>   obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
>   obj-$(CONFIG_YT2_1380)		+= lenovo-yoga-tab2-pro-1380-fastcharger.o
>   obj-$(CONFIG_LENOVO_WMI_CAMERA)	+= lenovo-wmi-camera.o
> +obj-$(CONFIG_LEGION_GO_WMI)	+= legion-go-wmi.o
>   
>   # Intel
>   obj-y				+= intel/
> diff --git a/drivers/platform/x86/legion-go-wmi.c b/drivers/platform/x86/legion-go-wmi.c
> new file mode 100644
> index 000000000000..e319219c3ace
> --- /dev/null
> +++ b/drivers/platform/x86/legion-go-wmi.c
> @@ -0,0 +1,552 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * legion-go-wmi.c - Lenovo Legion Go WMI Control
> + *
> + * Copyright © 2024 zhixin zhang <zhangzx36@lenovo.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/printk.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/proc_fs.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/version.h>
> +
> +//extern struct proc_dir_entry *acpi_root_dir;
> +struct proc_dir_entry *acpi_root_dir;
> +
> +#define BUFFER_SIZE 256
> +
> +#define LEGION_GO_WMI_GAMEZONE_GUID			"887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
> +#define LEGION_GO_WMI_OTHER_GUID			"dc2a8805-3a8c-41ba-a6f7-092e0089cd3b"
> +
> +//wmi_device_id context string
> +#define LEGION_GO_WMI_GAMEZONE_CONTEXT	"GameZone"
> +#define LEGION_GO_WMI_OTHER_CONTEXT		"Other"
> +
> +//funciton name
> +#define CMD_SET_SPL				"SetSPL"
> +#define CMD_GET_SPL				"GetSPL"
> +#define CMD_SET_SPPT			"SetSPPT"
> +#define CMD_GET_SPPT			"GetSPPT"
> +#define CMD_SET_FPPT			"SetFPPT"
> +#define CMD_GET_FPPT			"GetFPPT"
> +#define CMD_SET_SMART_FAN_MODE	"SetSmartFanMode"
> +#define CMD_GET_SMART_FAN_MODE	"GetSmartFanMode"
> +
> +//function arg for ids
> +enum legion_go_wmi_ids{
> +	ARG_SPL_CUSTOM_MODE = 0x0102FF00,
> +	ARG_SPL_GET_VALUE = 0x0102FF00,
> +
> +	ARG_SPPT_CUSTOM_MODE = 0x0101FF00,
> +	ARG_SPPT_GET_VALUE = 0x0101FF00,
> +
> +	ARG_FPPT_CUSTOM_MODE = 0x0103FF00,
> +	ARG_FPPT_GET_VALUE = 0x0103FF00,
> +
> +	ARG_SMART_FAN_QUIENT_MODE = 0x1,
> +	ARG_SMART_FAN_BALANCE_MODE = 0x2,
> +	ARG_SMART_FAN_PERFORMANCE_MODE = 0x3,
> +	ARG_SMART_FAN_CUSTOM_MODE = 0xFF,
> +};
> +
> +static const struct wmi_device_id legion_go_wmi_id_table[] = {
> +	{ LEGION_GO_WMI_GAMEZONE_GUID, LEGION_GO_WMI_GAMEZONE_CONTEXT },
> +	{ LEGION_GO_WMI_OTHER_GUID, LEGION_GO_WMI_OTHER_CONTEXT },
> +	{ }
> +};
> +
> +
> +enum legion_go_wmi_gamezone_method {
> +	legion_go_wmi_gamezone_method	= 0xAA,	// WMAA, DSDT
> +	LEGION_GO_WMI_OTHER_METHOD		= 0xAE,	// WMAA, DSDT
> +};
> +
> +//wmi command
> +enum legion_go_wmi_command {
> +	// smart fan mode
> +	LEGION_GO_WMI_GAMEZONE_SET_SMARTFANMODE	= 0x2C,
> +	LEGION_GO_WMI_GAMEZONE_GET_SMARTFANMODE	= 0x2D,
> +	// set bois feature
> +	LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE	= 0x12,
> +	LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE	= 0x11,
> +};
> +
> +//wmi call function
> +enum legion_go_call_function {
> +	LEGION_GO_FUNC_NONE,
> +	LEGION_GO_FUNC_SET_SPL,
> +	LEGION_GO_FUNC_GET_SPL,
> +	LEGION_GO_FUNC_SET_SPPT,
> +	LEGION_GO_FUNC_GET_SPPT,
> +	LEGION_GO_FUNC_SET_FPPT,
> +	LEGION_GO_FUNC_GET_FPPT,
> +	LEGION_GO_FUNC_SET_SMART_FAN_MODE,
> +	LEGION_GO_FUNC_GET_SMART_FAN_MODE
> +};
> +
> +struct legion_go_wmi_args_3i {
> +	u32 arg1;
> +	u32 arg2;
> +	u32 arg3;
> +};
> +
> +struct legion_go_wmi_args_2i {
> +	u32 arg1;
> +	u32 arg2;
> +};
> +
> +struct legion_go_wmi_args_1i {
> +	u32 arg1;
> +};
> +
> +struct legion_go_global {
> +	struct wmi_device *legion_device[2]; //0:"GameZone"  1:"Other"
> +	enum legion_go_call_function last_call_function;
> +	bool first_read;
> +	struct proc_dir_entry *acpi_entry;
> +	char result_buffer[BUFFER_SIZE];
> +};
> +
> +static struct legion_go_global g_Legion_Go_Global = {
> +	.legion_device = {NULL, NULL},
> +	.last_call_function = LEGION_GO_FUNC_NONE,
> +	.first_read = true,
> +	.acpi_entry = NULL,
> +};
> +
> +static acpi_status legion_go_wmi_perform_query(struct wmi_device *wdev,
> +		enum legion_go_wmi_gamezone_method method_id,
> +		const struct acpi_buffer *in,
> +		struct acpi_buffer *out)
> +{
> +	acpi_status ret = wmidev_evaluate_method(wdev, 0x0, method_id, in, out);
> +
> +	if (ACPI_FAILURE(ret)) {
> +		dev_warn(&wdev->dev, "LEGION GO WMI: WMI query failed with error: %d\n", ret);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static acpi_status legion_go_wmi_query_integer(struct wmi_device *wdev,
> +		enum legion_go_wmi_gamezone_method method_id,
> +		const struct acpi_buffer *in,
> +		u32 *res)
> +{
> +	union acpi_object *obj;
> +	struct acpi_buffer result = { ACPI_ALLOCATE_BUFFER, NULL };
> +	acpi_status ret;
> +
> +	ret = legion_go_wmi_perform_query(wdev, method_id, in, &result);
> +	if (ret) {
> +		return ret;
> +	}
> +
> +	obj = result.pointer;
> +	if (obj && obj->type == ACPI_TYPE_INTEGER) {
> +		*res = obj->integer.value;
> +	}
> +	else {
> +		ret = -EIO;
> +	}
> +
> +	kfree(result.pointer);
> +	return ret;
> +}
> +
> +
> +/**
> + * procfs write callback. Called when writing into /proc/acpi/call.
> +*/
> +static ssize_t acpi_proc_write(struct file *filp,
> +		const char __user *buff,
> +		size_t len,
> +		loff_t *data)
> +{
> +    char input[2 * BUFFER_SIZE] = { '\0' };
> +    union acpi_object *args;
> +    int nargs, i;
> +    char *method;
> +
> +	u32 prod_id;
> +	acpi_status ret;
> +
> +    if (len > sizeof(input) - 1) {
> +        printk(KERN_ERR "LEGION GO WMI: Input too long! (%lu)\n", len);
> +        return -ENOSPC;
> +    }
> +
> +    if (copy_from_user( input, buff, len )) {
> +        return -EFAULT;
> +    }
> +
> +    input[len] = '\0';
> +    if (input[len-1] == '\n')
> +        input[len-1] = '\0';
> +
> +	printk("LEGION GO WMI: procfs write is %s\n", input);
> +
> +	char cmd[2 * BUFFER_SIZE] = { '\0' };
> +	char arg1[2 * BUFFER_SIZE] = { '\0' };
> +	int arg1Num = 0;
> +	int retNum = 0;
> +
> +	int pos = -1;
> +	for(int i=0;i<2 * BUFFER_SIZE;i++) {
> +		if(input[i]== ',') {
> +			memcpy(cmd,input,i*sizeof(char));
> +			pos = i+1;
> +		}
> +		else if(input[i]=='\0' && pos != -1) {
> +			memcpy(arg1,input+pos,(i-pos)*sizeof(char));
> +			pos = i+1;
> +			break;
> +		}
> +	}
> +	if(pos == -1) {
> +		memcpy(cmd,input,len*sizeof(char));
> +	}
> +	else {
> +		printk(KERN_ERR "LEGION GO WMI: cmd = %s, arg1 : %s\n", cmd,arg1);
> +		retNum = kstrtoint(arg1,10,&arg1Num);
> +		if(retNum != 0)
> +		{
> +			printk(KERN_ERR "LEGION GO WMI: arg1 = %s param error!\n",arg1);
> +			return -ENOSPC;
> +		}
> +	}
> +
> +	if(ret == 0) {
> +		if(strcmp(cmd,CMD_SET_SPL)==0) {
> +			struct legion_go_wmi_args_2i args = {
> +				.arg1 = ARG_SPL_CUSTOM_MODE,
> +				.arg2 = arg1Num,
> +			};
> +			const struct acpi_buffer in = {
> +				.length = sizeof(args),
> +				.pointer = &args,
> +			};
> +
> +			g_Legion_Go_Global.last_call_function = LEGION_GO_FUNC_SET_SPL;
> +
> +			ret = legion_go_wmi_query_integer(g_Legion_Go_Global.legion_device[1],
> +					LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE, &in, &prod_id);
> +			if (ret == 0) {
> +				dev_info(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetSPL result is %d\n", prod_id);
> +			}
> +			else {
> +				dev_warn(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetSPL query failed with err: %d\n", ret);
> +			}
> +		}
> +		else if(strcmp(cmd,CMD_GET_SPL)==0) {
> +			g_Legion_Go_Global.last_call_function = LEGION_GO_FUNC_GET_SPL;
> +		}
> +		else if(strcmp(cmd,CMD_SET_SPPT)==0) {
> +			struct legion_go_wmi_args_2i args = {
> +				.arg1 = ARG_SPPT_CUSTOM_MODE,
> +				.arg2 = arg1Num,
> +			};
> +			const struct acpi_buffer in = {
> +				.length = sizeof(args),
> +				.pointer = &args,
> +			};
> +
> +			g_Legion_Go_Global.last_call_function = LEGION_GO_FUNC_SET_SPPT;
> +
> +			ret = legion_go_wmi_query_integer(g_Legion_Go_Global.legion_device[1],
> +					LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE,
> +					&in,
> +					&prod_id);
> +			if (ret == 0) {
> +				dev_info(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetSPPT result is %d\n", prod_id);
> +			}
> +			else {
> +				dev_warn(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetSPPT query failed with err: %d\n", ret);
> +			}
> +		}
> +		else if(strcmp(cmd,CMD_GET_SPPT)==0) {
> +			g_Legion_Go_Global.last_call_function = LEGION_GO_FUNC_GET_SPPT;
> +		}
> +		else if(strcmp(cmd,CMD_SET_FPPT)==0) {
> +			struct legion_go_wmi_args_2i args = {
> +				.arg1 = ARG_FPPT_CUSTOM_MODE,
> +				.arg2 = arg1Num,
> +			};
> +			const struct acpi_buffer in = {
> +				.length = sizeof(args),
> +				.pointer = &args,
> +			};
> +
> +			g_Legion_Go_Global.last_call_function = LEGION_GO_FUNC_SET_FPPT;
> +
> +			ret = legion_go_wmi_query_integer(g_Legion_Go_Global.legion_device[1],
> +					LEGION_GO_WMI_OTHER_SET_FEATURE_VALUE,
> +					&in,
> +					&prod_id);
> +			if (ret == 0) {
> +				dev_info(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetFPPT result is %d\n", prod_id);
> +			}
> +			else {
> +				dev_warn(&g_Legion_Go_Global.legion_device[1]->dev,
> +						"LEGION GO WMI: SetFPPT query failed with err: %d\n", ret);
> +			}
> +		}
> +		else if(strcmp(cmd,CMD_GET_FPPT)==0) {
> +			g_Legion_Go_Global.last_call_function = LEGION_GO_FUNC_GET_FPPT;
> +		}
> +		else if(strcmp(cmd,CMD_SET_SMART_FAN_MODE)==0) {
> +			if(arg1Num != 1 && arg1Num != 2 && arg1Num != 3 && arg1Num != 0xFF) {
> +				printk(KERN_ERR "LEGION GO WMI: %s arg1 = %s param error!\n",
> +						CMD_SET_SMART_FAN_MODE,arg1);
> +				return -ENOSPC;
> +			}
> +
> +			struct legion_go_wmi_args_1i args = {
> +				.arg1 = arg1Num,
> +			};
> +			const struct acpi_buffer in = {
> +				.length = sizeof(args),
> +				.pointer = &args,
> +			};
> +			g_Legion_Go_Global.last_call_function = LEGION_GO_FUNC_SET_SMART_FAN_MODE;
> +			ret = legion_go_wmi_query_integer(g_Legion_Go_Global.legion_device[0],
> +					LEGION_GO_WMI_GAMEZONE_SET_SMARTFANMODE,
> +					&in,
> +					&prod_id);
> +
> +			if (ret == 0) {
> +				dev_info(&g_Legion_Go_Global.legion_device[0]->dev,
> +					"LEGION GO WMI: SetSmartFanMode query result is %d\n", prod_id);
> +			}
> +			else {
> +				dev_warn(&g_Legion_Go_Global.legion_device[0]->dev,
> +				"LEGION GO WMI: SetSmartFanMode query failed with err: %d\n", ret);
> +			}
> +		}
> +		else if(strcmp(cmd,CMD_GET_SMART_FAN_MODE)==0) {
> +			g_Legion_Go_Global.last_call_function = LEGION_GO_FUNC_GET_SMART_FAN_MODE;
> +		}
> +	}
> +
> +    return len;
> +}
> +
> +//read other mothod
> +acpi_status acpi_proc_read_other(struct wmi_device *wdev,
> +		enum legion_go_wmi_command cmd,
> +		struct legion_go_wmi_args_1i* args,
> +		char* funciton_name)
> +{
> +	u32 prod_id = 0;
> +	const struct acpi_buffer in = {
> +		.length = sizeof(*args),
> +		.pointer = args,
> +	};
> +	acpi_status ret = legion_go_wmi_query_integer(wdev, cmd,  &in, &prod_id);
> +	if (ret == 0) {
> +		dev_info(&wdev->dev, "LEGION GO WMI: Integer query result is %d\n", prod_id);
> +		snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,%u",funciton_name,prod_id);
> +	}
> +	else {
> +		dev_warn(&wdev->dev, "LEGION GO WMI: Integer query failed with err: %d\n", ret);
> +		snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,error",funciton_name);
> +	}
> +	return ret;
> +}
> +
> +static ssize_t acpi_proc_read(struct file *filp, char __user *buff, size_t count, loff_t *off)
> +{
> +	u32 prod_id;
> +	acpi_status ret;
> +	int len = strlen(g_Legion_Go_Global.result_buffer);
> +
> +	memset(g_Legion_Go_Global.result_buffer,'\0',len);
> +
> +	if(g_Legion_Go_Global.last_call_function == LEGION_GO_FUNC_NONE) {
> +		ssize_t result = simple_read_from_buffer(buff,
> +				count,
> +				off,
> +				g_Legion_Go_Global.result_buffer,
> +				len + 1);
> +		return result;
> +		//return -EIO;
> +	}
> +
> +
> +	switch(g_Legion_Go_Global.last_call_function) {
> +		case LEGION_GO_FUNC_SET_SPL:
> +		case LEGION_GO_FUNC_GET_SPL:
> +		{
> +			struct legion_go_wmi_args_1i args = {
> +				.arg1 = ARG_SPL_GET_VALUE,
> +			};
> +			ret = acpi_proc_read_other(g_Legion_Go_Global.legion_device[1],
> +				LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE,
> +				&args,
> +				CMD_GET_SPL);
> +
> +			break;
> +		}
> +		case LEGION_GO_FUNC_SET_SPPT:
> +		case LEGION_GO_FUNC_GET_SPPT:
> +		{
> +			struct legion_go_wmi_args_1i args = {
> +				.arg1 = ARG_SPPT_GET_VALUE,
> +			};
> +			ret = acpi_proc_read_other(g_Legion_Go_Global.legion_device[1],
> +					LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE,
> +					&args,
> +					CMD_GET_SPPT);
> +
> +			break;
> +		}
> +		case LEGION_GO_FUNC_SET_FPPT:
> +		case LEGION_GO_FUNC_GET_FPPT:
> +		{
> +			struct legion_go_wmi_args_1i args = {
> +				.arg1 = ARG_FPPT_GET_VALUE,
> +			};
> +			ret = acpi_proc_read_other(g_Legion_Go_Global.legion_device[1],
> +					LEGION_GO_WMI_OTHER_GET_FEATURE_VALUE,
> +					&args,
> +					CMD_GET_FPPT);
> +
> +			break;
> +		}
> +		case LEGION_GO_FUNC_SET_SMART_FAN_MODE:
> +		case LEGION_GO_FUNC_GET_SMART_FAN_MODE:
> +		{
> +			struct legion_go_wmi_args_1i args = {
> +				.arg1 = 255,
> +			};
> +			const struct acpi_buffer in = {
> +				.length = sizeof(args),
> +				.pointer = &args,
> +			};
> +
> +			ret = legion_go_wmi_query_integer(g_Legion_Go_Global.legion_device[0],
> +					LEGION_GO_WMI_GAMEZONE_GET_SMARTFANMODE,
> +					&in,
> +					&prod_id);
> +			if (ret == 0) {
> +				dev_info(&g_Legion_Go_Global.legion_device[0]->dev,
> +						"LEGION GO WMI: Integer query result is %d\n", prod_id);
> +				snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,%u",
> +						CMD_GET_SMART_FAN_MODE,prod_id);
> +			}
> +			else {
> +				dev_warn(&g_Legion_Go_Global.legion_device[0]->dev,
> +						"LEGION GO WMI: Integer query failed with err: %d\n", ret);
> +				snprintf(g_Legion_Go_Global.result_buffer,BUFFER_SIZE,"%s,error",
> +						CMD_GET_SMART_FAN_MODE);
> +			}
> +			break;
> +		}
> +		default:
> +		{
> +			strcpy(g_Legion_Go_Global.result_buffer,"LEGION GO WMI: nothing to write");
> +		}
> +	}
> +
> +	if(g_Legion_Go_Global.first_read == true) {
> +		char temp[BUFFER_SIZE] = {'\0'};
> +		strcpy(temp, g_Legion_Go_Global.result_buffer);
> +		strcpy(g_Legion_Go_Global.result_buffer+1, temp);
> +		g_Legion_Go_Global.first_read = false;
> +	}
> +	// output the current result buffer
> +	ssize_t result = simple_read_from_buffer(buff,
> +			count,
> +			off,
> +			g_Legion_Go_Global.result_buffer,
> +			len + 1);
> +
> +    return result;
> +}
> +
> +static const struct proc_ops proc_acpi_operations = {
> +        .proc_read     = acpi_proc_read,
> +        .proc_write    = acpi_proc_write,
> +};
> +
> +static int legion_go_wmi_probe(struct wmi_device *wdev, const void *context)
> +{
> +	dev_info(&wdev->dev, "LEGION GO WMI: Probe is starting.\n");
> +
> +	if (!wmi_has_guid(LEGION_GO_WMI_OTHER_GUID)) {
> +		dev_warn(&wdev->dev, "LEGION GO WMI: No known OTHER WMI GUID found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!wmi_has_guid(LEGION_GO_WMI_GAMEZONE_GUID)) {
> +		dev_warn(&wdev->dev, "LEGION GO WMI: No known GAMEZONE WMI GUID found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (g_Legion_Go_Global.acpi_entry == NULL) {
> +		g_Legion_Go_Global.acpi_entry = proc_create("legion_go_call",
> +				0660,
> +				acpi_root_dir,
> +				&proc_acpi_operations);
> +	}
> +
> +    if (g_Legion_Go_Global.acpi_entry == NULL)
> +	{
> +      dev_warn(&wdev->dev, "LEGION GO WMI: Couldn't create procfs entry\n");
> +      return -ENOMEM;
> +    }
> +
> +    dev_info(&wdev->dev, "LEGION GO WMI: procfs entry at /proc/acpi/legion_go_call created.\n");
> +
> +	dev_info(&wdev->dev, "LEGION GO WMI: Probe is exiting.\n");
> +
> +	if(strcmp(context, LEGION_GO_WMI_GAMEZONE_CONTEXT)== 0) {
> +		g_Legion_Go_Global.legion_device[0] = wdev;
> +	}
> +	else {
> +		g_Legion_Go_Global.legion_device[1] = wdev;
> +	}
> +
> +	return 0;
> +}
> +
> +static void legion_go_wmi_remove(struct wmi_device *wdev)
> +{
> +	g_Legion_Go_Global.legion_device[0] = NULL;
> +	g_Legion_Go_Global.legion_device[1] = NULL;
> +
> +    remove_proc_entry("legion_go_call", acpi_root_dir);
> +
> +    dev_info(&wdev->dev, "LEGION GO WMI: procfs entry removed\n");
> +}
> +
> +static struct wmi_driver legion_go_wmi_driver = {
> +	.driver = {
> +		.name = "legion-go-wmi",
> +	},
> +	.id_table = legion_go_wmi_id_table,
> +	.probe = legion_go_wmi_probe,
> +	.remove = legion_go_wmi_remove
> +};
> +
> +module_wmi_driver(legion_go_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, legion_go_wmi_id_table);
> +
> +MODULE_DESCRIPTION("Lenovo Legion Go WMI Driver");
> +MODULE_AUTHOR("zhixin zhang<zhangzx36@lenovo.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1.0.0.0");

Besides the comments from Ilpo and Kurt I notice that this driver is 
incredibly noisy.  You've got a dev_info() or dev_warn() in nearly every 
function.

While going through all the comments from checkpatch and Ilpo please 
also drop 99% of those.

