Return-Path: <linux-kernel+bounces-557960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051FDA5DFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B70A3AC9D8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC912505DE;
	Wed, 12 Mar 2025 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SoAHfALC"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094A24E00B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792324; cv=fail; b=Z5HSZ7OJg3p0YF4faChBumZn17NK6uVg0FTwh8iWhqzS5c3BGd3M+pVwHKdm3NJkT4++xlkA7RdhXeRzKOmPIUFmaBIVe9Cp0xTZ3Bazv/1bcbPeQUi1AFhxEV09cXxB3HnoZI1mzvDhgiZBcGdLI61aj/QfhAxBlKdIhYkmpwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792324; c=relaxed/simple;
	bh=q2V7kiuZnURk5C0N6tJy0axp7q/Pwp5+Lj8ZhRzAE/s=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=mx0ZLwpkG2Q4wVEo8YqhggLdwW88l0DfqWLrAuBk4fg7ixDU2scQHItn+Z3Tg+293RRIZkCSKcRp42YByWX8kLZlBEtFW2Uck3blRq9DtR7S3UCrDMpMcx8hKnSHCy9nUYFbyfnlU7E4INB8zGnQVsnT2wgfxIOQjwKhrhJHoMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SoAHfALC; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNqgflEjC/hfQ3W6rABvI09uifdWXXWP1UidU5Ahfb5O+hEOsL3j7mWtPDpBBu9OWHQC6wCD8cdjuHmsWDoarn/8ABcKmH7dxLjEIc5Meiz+njONJAB7QUGXc5b20f+7Uiu034KTD32/1JsJWePLTJcphOAsgPW6pS9bHGQbG9DfDn18CP10nC2dX/huY+Nr4NZyWtM9mAcCICc0Rl1VGvkqeBDXpg2VFEcSlLwvSTz6ZtXt2KRoGVTWpELmjUPQCUWf1x7KMZ9/zBxsczBEIx/z8lWgT3L3WFuzPc2jHxg+LzR32Jm0Hn1oDrO18YHWhk74mVNDZA/N1vlfuEsX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyMt5YeetYhw+SCX/tP6qfEM/3C8QIpz6fyynhQLnGs=;
 b=S8WS4WfN1t4rN2vNEEN9fVI4QWmGSK/xNN3LkpalMTr9v5DZmq5VFSL3C1OoBZpjqeKEYu8ldfhQTN/085jc/j8j30PV8zYy1bLNc22UiTX8HrB0SbBL8bE1WUCkL6IYFed1AwOzdSbHj0K6vbZ9FOfkz6X0feZ44zZ9Bxgd5yeGDo45jZorefTT2x+2PWGppiGng5hOYisDQkLVdAX8+uXAnYqiHystrGkRhScV7H5jSNi3tSt8FKzeB4u4hjHQ7xPPTIhCnSXabrZlbJA0asttqhs+j9adps3G8cPAY4cGXSw2XJC99Lblfz5Ri/NBLrYrIGOTrTmWv6BphdoOAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyMt5YeetYhw+SCX/tP6qfEM/3C8QIpz6fyynhQLnGs=;
 b=SoAHfALC+J7PoqdK0fwirDX1X+VjnLParTfONTshAdS3mmEbZEQKiGr21W+m26JFpXhv4oq08V3wts1aQEQ9s2UKCQyeabweDuGCWnoSPUkYI6crigh3aKYsq+wuJcleggUqehfGSO1wUsfr5ZZIahvLPg+iysb7APmcNNPOh9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:11:58 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:11:58 +0000
Message-ID: <6f2d0c92-2614-ead1-0b97-6d1cd4fc07cd@amd.com>
Date: Wed, 12 Mar 2025 10:11:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, x86@kernel.org
Cc: hpa@zytor.com, Nikunj A Dadhania <nikunj@amd.com>, Larry.Dewey@amd.com,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 Juergen Gross <jgross@suse.com>, kirill.shutemov@linux.intel.com,
 alexey.gladkov@intel.com, Joerg Roedel <jroedel@suse.de>
References: <20250312144107.108451-1-joro@8bytes.org>
 <20250312144107.108451-2-joro@8bytes.org>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 1/2] x86/coco/sev: Move SEV SYSFS group to
 /sys/hypervisor/
In-Reply-To: <20250312144107.108451-2-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::16) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: fed6987f-f924-4ca9-5826-08dd61783b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WG9EcWlTeCszSFN2ckM1cVpDZDc2YmNXZkFET2xsdWx0L1pWanRKRXNZUDNR?=
 =?utf-8?B?SGpaNnQzSDRUV0ZmM2ZqZ2hkb3hGZ2Vvdy9WSURJUDJSUFJ4Q2dIeW9OajFs?=
 =?utf-8?B?d3p6UlY1aklzR2p0QWp1V3gxOENjRHlWR0xXemx3a0lOQ0tuZXRpK3NybzUx?=
 =?utf-8?B?Nzh0MkZLYVl5TERkT25IaFFnb0ptemduWHNIKzRSdGJFbXVobTAydkJCNGRO?=
 =?utf-8?B?L3VBQ0ZSQisvK1dtdmNSV3BGaVdPcmQyVDU3RDJSdkpGTUxTck1GZWJBRTFz?=
 =?utf-8?B?Sk8zUmZLNEpvNkFXVURXOERXL1BpQkh0cEs1VmYxcExMVE9QMEY0WXVhZXlx?=
 =?utf-8?B?WjYyOWlQczBpR3ZIaVcxeTYwRjREVTBZblk4QlQyTk5XQUJBTldyY0crSjlJ?=
 =?utf-8?B?VkVOTjV0V24rdVExc0JnUFBPWHJyMFY4ODZOU0tRQnBOTTVYSTJSZ1EwWmdY?=
 =?utf-8?B?eER5Q3EwV0VJNTkxNFpYTXFFVnptM1BPWCtnYUpKS09aQTNWSURtSWQySjNI?=
 =?utf-8?B?WVhOSjNQVzEyNHpNWjV2Y3k4azhEYUpmV2xCYjhIL1R2VEZGTmZaK0FxZDFL?=
 =?utf-8?B?bDE5SjlNK2w2MWRrVzEreWE4VG5sT3pqSTkzUjBKd1I5YlRFYlRrbTlYUDdG?=
 =?utf-8?B?UG9EeCtzQ3FQUnljNTVJVkJMNEZaeUxzeW5tR1l4RzBuTU5MNkx5VTNETVF4?=
 =?utf-8?B?ZU0zRjV2U3Q5M3hjZFplVTdXY1QxdnNkU3EwaVQwcmUvd1N4ckNJZzY4VGEr?=
 =?utf-8?B?VVVtNEtaRXNiTVRqWFhFYlhlODZsZ1hPeWRSek1ibnpKb25IdVVlNTRGM1V3?=
 =?utf-8?B?LzJOb3ZsUzlmZGw2OFcxd2R0cFBMbkUyT2R6Um9aQWE0MFNKbExiV0ZmS0dY?=
 =?utf-8?B?bjVZRFZKZEFsbGpkWlRCYlhaaFVHTHB0QWNzN2F5TE5KMW5iT3ZrUjNXa0ps?=
 =?utf-8?B?OUlWOTZmUFpSQ1NocUpFekQrQU53NC9VK0pUbldMTVVPN0dJK2lKQzhRVGxj?=
 =?utf-8?B?TXAxVzhmTkduejdXTnVZVTNHQWNzYnNvT3N1QUZTeUlsUnJLZitQRU53UCtN?=
 =?utf-8?B?N2lMSVMwYkttRGpkTDlEZ1pTYkJLQU45OXd4Um5WbkFCMFlzUmJpVTR3dFB3?=
 =?utf-8?B?OUVQQXZzVllOZ1dXV1hOTnJLT0FwZkZuRUF1R3lvUDJjZVRTYmI5VVkzMzFT?=
 =?utf-8?B?SE9KV1JhMEhWcnRvTVRnMnJUbkVPNmttL1hQMHl0a0xycGhDSStaQjNacXB0?=
 =?utf-8?B?V085QU40TmJrc3VMOTVwelh6ZEZ4SXNhSDJhZlNtc2Z3OUdZMldONFdsaVg2?=
 =?utf-8?B?KzM5SXM5bGhKTUZJL1hydDJrblhNQXZNWGdYMndYa3ozWkZVa3NZY2pFRzRJ?=
 =?utf-8?B?VnFzSWpOanJuMFVjUHhXRzFzMXlFSDdrRmc2aHFFZmtwYzg0dWFIRm45Tmov?=
 =?utf-8?B?cEo5ZVQrRHp0eHd2ZG5UQTR3bDZrdjhIVHZQZE5VTmtGSCs2cWVjUWQxdElL?=
 =?utf-8?B?dnp1Q09waVBPdktBSTdmcy9iUk1oVkF0WVRjbG1MZWk2Z29oQk5iV2VBVDJB?=
 =?utf-8?B?TlBMRVhRYWJaeEtVTEMxeURCa0F5NkcxWEkvR0tJVnVtTWlsVWQ0MDRtRFlY?=
 =?utf-8?B?WWpwL1YrRCtCbXBUdEdvRU4vQlI2R3RWeUtrK1JHbTNqV2VDc2Uyb3JneDNr?=
 =?utf-8?B?OTJCb1B4U2ZLU0UyUHhwSFBpZGx4bVR1d1VIQjd5WjUvZy9zQ2MrM3JXZE56?=
 =?utf-8?B?Vm45Mk0vVEx1YmIrNjRrdHpNQWJhdWQ3Y2g0SlJiZS9BdERpdFBwdEwvcTBy?=
 =?utf-8?B?M21oUzlBOUpGYkJBajdoNWVmNHVwS1RmNG5ybzRKSUxoQlE0K2tjeUZUV3FS?=
 =?utf-8?Q?QDsyUNYrHf02d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3JkK3FNdEJhbTRsd1hIL3N6ZzNVdTdFbDcrdXJQN2hoV3RyNXM2a21Cb28z?=
 =?utf-8?B?MEZQNS9VU1VxZGNjaG9UYVEvTzRSTzRGRzhIbWlua3Irc09RY3phUHRqZzd4?=
 =?utf-8?B?TGJUN282UHhtd1FrdGJYejh6aHlhUUJpY0tGak9ZZzJXODUyYnZaMzFXTWEz?=
 =?utf-8?B?OGhPclRhQnRSdis0bDRzS3VIWVBwS3dzdzBFNjBlaVdYblg3SWxEcHcwbnVR?=
 =?utf-8?B?WnZ2L1BESjBsMXJ6QXkvNjI4RzRwc0N4TCtFYnhZSjJ4bWU3cnBKUHhXcnNx?=
 =?utf-8?B?Tm5yQ3VDUjQ1b2QwV1VLd1dWQnBDbXRkUnkvd09rQmpDZnBpWlZHUkRVVEJi?=
 =?utf-8?B?OUxUdFJRYTN6SVFaVHg2eWErZ3lpdlRZNDVDUE9taHNXdnVRWkNCb25wWVZN?=
 =?utf-8?B?dURHVnFjWVBuVWlGd0pRWlJNQnFnNHM5bkdMZnp5WXlTdTdxbHFHT1BrM0dX?=
 =?utf-8?B?ZjhaSjVXZU1kckRXMWFuN1g0Wk5iWVMvYjB3SmRUNHVGUHhyTG0zOFdFQXBu?=
 =?utf-8?B?ek0xbVlYVFQ0UmI4Ym5TZlJCNk0rb1dKTUp1RFA3SUFzQStjc21IR2lmaGxt?=
 =?utf-8?B?UUdJdTR6cWh6c09KMWFBVlEzeXJZa2VtUzl0dFFVa0tPTFNvSjgxYm10Rzgv?=
 =?utf-8?B?VkhNcXBLSkRzcldwYUpxdXN2T292ckhMVnNoMnJ5Z0pVTzZCR0ZMSWp6S3VL?=
 =?utf-8?B?QmhBRjd5ZDVjSk9oS2VlZVFockhscjZoZUVEbjdOR3Z6MlBaTGcyTldscWNl?=
 =?utf-8?B?UVAxWXJQQmtjTmVJdldFOWFaYkZPdStmdEo0b01VSTBGTTVNRVoyZEp5aldT?=
 =?utf-8?B?ZGFIR2VhUnNDQTZZbDUvaEEzVUxDRHpRakw2YVhITnl5eThOL1NISFFTd2dM?=
 =?utf-8?B?YnJmcHlGUkROUmVicWVSTzZNcEdSZGlsTmxCcUV4QWNQTWVVM0lBSzV2KytO?=
 =?utf-8?B?RXZHRmh4b1FXV2k4SUYzMzdOR1RneTBWeElLaHlTNmZQbm95aDlKYjk4NWF6?=
 =?utf-8?B?dWpWVUlKNFlpNjlybzg0WXQ1WXdCeDJBNjFGR2lPSWQ4c0ZKQWZWN0dkbnNR?=
 =?utf-8?B?c2JxWjlpcUJKM285RXg1R2ZiVmNraDdtNkRiYzlVNWp3dkNBWUhSbTUxVjJJ?=
 =?utf-8?B?QVBjZU01eEFqbjBvS244QjFrU1RyNW9rOEx1WnpPRmYyVko2aWIrS3l1dThS?=
 =?utf-8?B?SkFManZOS05QWnZhUkh2ZkpZQnFZcFpWcm5NSnFDUDNyandwcTFCRFc4d0xI?=
 =?utf-8?B?Q0E3RytFRVArVEZ1MWFWQ09Hb1FxQ0NXMXJ2YUNBNmdSSDY4US9IRFZOc245?=
 =?utf-8?B?ZGJpb1l5VXNyTS9IUG5lay9HRWVxN0IyWVd4U29ZQUV4aS9MZUpYTkx5QlJn?=
 =?utf-8?B?Z0hNdm9BUGtRNFFqenFWLy9scm1mU0NQa2RuOEczOG9TTElnaTJFL3hMRkt6?=
 =?utf-8?B?R2kvc3RZUkVoMHNxVm5YeTlNN1JFZjM4UkJnczVqYWVtT212eTloNUFTYkRS?=
 =?utf-8?B?c0x0Y3dwQ1VsVGFXUFlJa3lYZFd1bENqVU5tZy9ZNmJkYWdVaUI0dE1yWko5?=
 =?utf-8?B?UXNrY3Y4T1BTL1VMUlFEWE52VDNSb3MrSmpVeU9MSXNkd1JNRks5ekc2TEpv?=
 =?utf-8?B?NDArQnJFMDQyZHA4ZTAxVCtCeVlzZCs5SGdLbmNmSHNrUHhWWUNlc3hPcmZN?=
 =?utf-8?B?bGU3ZE45T05JWm9yS0tVbFU2cmdOdzlWYmF2eEVUd05rRWR2ZWpSeXB1Y2NB?=
 =?utf-8?B?MExYZ1UxY21VSHp1Lzc3TDd4T0lQelVZb3FEZVZLczg5Q2dMTlpWa1FFdjlS?=
 =?utf-8?B?K2Q0Snc5Ynl2TDNDU3RHU0NPYm1QQ0JRK0xCZVVEa0s5R1pzNW1lU1dzY3o0?=
 =?utf-8?B?NVJRYTJOc2xZK29ONjlSdURsdjlKOURvYmZEb3p4eHM5L3MvK1pPYzE0QS9L?=
 =?utf-8?B?N1BqdFFuVnJpRlJtK01pb09XRktubDNuN0VOc0dYeDJGMTU5ZzhmV2JQR05h?=
 =?utf-8?B?c2Q3MjY0WUxhVHNkWVhBUHVsb1FsSmlwN3NUbVVrckxJalZpbXRONm5TTmdl?=
 =?utf-8?B?Rk02Y0prWUpQeXErRCs1ZUx0Z0VNN2Qrem11MCtEMlBGbGVsa3hkL3RlUjJ3?=
 =?utf-8?Q?KdrYLMKZnTf+liqdPdJgUpuWV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed6987f-f924-4ca9-5826-08dd61783b93
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:11:58.1601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIYgffw3kPuh9q7l99mOR7/0bC/7pY1PMtASSAzXBV2pC68ywHmQfsANpkuI4l7SISR10fLqt+TisZUMOrus7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270

On 3/12/25 09:41, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Move the SYSFS information about SEV to the /sys/hypervisor/ directory and link
> to it from the old location. The /sys/hypervisor/ hierarchy makes more
> sense for this information, as it is only relevant in a virtualized
> environment and contains values influenced by the hypervisor.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

One minor nit below, otherwise:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 11 ++--------
>  Documentation/ABI/testing/sysfs-hypervisor    | 10 +++++++++
>  arch/x86/Kconfig                              |  1 +
>  arch/x86/coco/sev/core.c                      | 21 +++++++++++++------
>  4 files changed, 28 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-hypervisor
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 206079d3bd5b..f056c401a550 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -607,16 +607,9 @@ Description:	Umwait control
>  			  Low order two bits must be zero.
>  
>  What:		/sys/devices/system/cpu/sev
> -		/sys/devices/system/cpu/sev/vmpl
>  Date:		May 2024
> -Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> -Description:	Secure Encrypted Virtualization (SEV) information
> -
> -		This directory is only present when running as an SEV-SNP guest.
> -
> -		vmpl: Reports the Virtual Machine Privilege Level (VMPL) at which
> -		      the SEV-SNP guest is running.
> -
> +Description:	This symbolic link to /sys/hypervisor/sev/ is only present when
> +		running as an SEV-SNP guest.
>  
>  What:		/sys/devices/system/cpu/svm
>  Date:		August 2019
> diff --git a/Documentation/ABI/testing/sysfs-hypervisor b/Documentation/ABI/testing/sysfs-hypervisor
> new file mode 100644
> index 000000000000..aca8b02c878c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-hypervisor
> @@ -0,0 +1,10 @@
> +What:		/sys/devices/system/cpu/sev
> +		/sys/devices/system/cpu/sev/vmpl

Shouldn't these be /sys/hypervisor/sev ?

Thanks,
Tom

> +Date:		May 2024
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	Secure Encrypted Virtualization (SEV) information
> +
> +		This directory is only present when running as an SEV-SNP guest.
> +
> +		vmpl: Reports the Virtual Machine Privilege Level (VMPL) at which
> +		      the SEV-SNP guest is running.
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1665ebaba251..5b717f6ccbbb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1497,6 +1497,7 @@ config AMD_MEM_ENCRYPT
>  	select X86_MEM_ENCRYPT
>  	select UNACCEPTED_MEMORY
>  	select CRYPTO_LIB_AESGCM
> +	select SYS_HYPERVISOR
>  	help
>  	  Say yes to enable support for the encryption of system memory.
>  	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 96c7bc698e6b..51a04a19449b 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2698,12 +2698,10 @@ static int __init sev_sysfs_init(void)
>  	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>  		return -ENODEV;
>  
> -	dev_root = bus_get_dev_root(&cpu_subsys);
> -	if (!dev_root)
> -		return -ENODEV;
> -
> -	sev_kobj = kobject_create_and_add("sev", &dev_root->kobj);
> -	put_device(dev_root);
> +	/*
> +	 * Create /sys/hypervisor/sev/ with attributes
> +	 */
> +	sev_kobj = kobject_create_and_add("sev", hypervisor_kobj);
>  
>  	if (!sev_kobj)
>  		return -ENOMEM;
> @@ -2712,6 +2710,17 @@ static int __init sev_sysfs_init(void)
>  	if (ret)
>  		kobject_put(sev_kobj);
>  
> +	/*
> +	 * Link from /sys/devices/system/cpu/sev to /sys/hypervisor/sev/ for
> +	 * compatibility reasons.
> +	 */
> +	dev_root = bus_get_dev_root(&cpu_subsys);
> +	if (!dev_root)
> +		return -ENODEV;
> +
> +	ret = compat_only_sysfs_link_entry_to_kobj(&dev_root->kobj, hypervisor_kobj, "sev", NULL);
> +	put_device(dev_root);
> +
>  	return ret;
>  }
>  arch_initcall(sev_sysfs_init);

