Return-Path: <linux-kernel+bounces-398275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487499BEE17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064D3286A9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CEC1F1318;
	Wed,  6 Nov 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RjbBUKCA"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCC1E0B84
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898800; cv=fail; b=TeHba0k+YBPkh6mFMAjQp83kLOFwHWLbupOYsHr7V6Gh/m3RnRAf2pLpAInJ2xGW58p6dauwdsLOCCo3dM+IdqkaJ+enud0xMdo1n9T+6FGlVsgl8cZtQzmSByRLB/vNJa2MCrHa0ZArhIZrkGbeAHKvFganwjig8GTNT5FcFXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898800; c=relaxed/simple;
	bh=amgVb/CjMGKlYSjsFiTU8y9sd5UoY41mQXhRcCDR5AI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RGVgrl0SNf9HvkwFv41u5ELYXLpWo8YPuKvE8SovfSntKQnoiDXs8XJtFE9/1cQfNrs7iaNnmp4jnhb1E/E2DYiXNia32h3+iO4Bc+gRH0QpOpLQBZsU5Y1UABoXbU2t5FUzgdVi4LBgBF2MA9V/tzoq4KvqCRS/G7nrqR8KMEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RjbBUKCA; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BolG2Kampt9VnpQNzpqVLysRmoIGDhmoPgdVZr3SnlV2TnlE9ePYE7UPdSdSeybYnNcsMr1tX/2JBGIeVXZi+G+ysqURjcurUTbauZcEaLttsep9//luDJKa3dNaX5/mvW73KPUMOE4EDNZ+eMSGE+LA0c/GEN8Sd0dBdWd0Z9DDDoM5/z0zeAPI1ICjCoJaU4iMDXz5C7lg501ed1HMhKBt+IhpLkkgvszwiFX1TcFwLz/e27A0diUKwAkYFKbha88jDmyP8+S04o3veI4S6VoC2igSa0QXP1x7CwaCidARhtc8nO3kzElvAOgiKGnAllcnKKilZhW54z5UusCs/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxTjiESa/EtlpKBBdYZvysBEPxUkLTupxv9LV/3K76Q=;
 b=tHXXD2aXymOUduGDzNfpoQ+TTDhCjtK92oAFp0NeFEGA5beRNNQK7UACI/SCVTbH3KeP/snzbclQiLEpLPjSzWNv9dFYxcHMKIK7d4mpEkP8p7cA5hSec4B5XoDzHzgehksVm6Ct1MysQQaUuZJcpi+e/kRUqHzaLc7y/rVvALcFWwb7Ior2wIMEE2BtBka/WyCiNti2mEtgQNHZ3CHp14kg02PW5o23RA+ovclpKGow5uH06U8vpSWvYzVAAYDo/ljUGch1emD/lFRgnVz3OiKsWAXdWgK3qIN6td6BdTUSgRXXf5Fy3Hf3e1b4LWaQjaoUqoKKaFij5MRfQnMStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxTjiESa/EtlpKBBdYZvysBEPxUkLTupxv9LV/3K76Q=;
 b=RjbBUKCAH3iQtPKpj+mrmetrUN7ekm0+ryiiGzumrpj1IAmmbLi7PfsA8LW5MAxt4O7FmN+tvnHbmZOcF0eWAjuEkQy/TGVJfyBLChd33WSuG2PM2JgUxadLyPsxK7F1lLRu0l7YKYd5A0v0IVcZrLzFciqNj4XTZorez9mF6GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Wed, 6 Nov
 2024 13:13:11 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 13:13:10 +0000
Message-ID: <4221120d-8859-4444-89c9-f1ada539c92b@amd.com>
Date: Wed, 6 Nov 2024 18:43:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] i3c: dw: Use IRQF_SHARED flag for dw-i3c-master
Content-Language: en-US
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
 <20241023055118.1400286-3-Shyam-sundar.S-k@amd.com>
 <9eb7c88a-c448-45cc-aeaa-88ab59cdadc5@linux.intel.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <9eb7c88a-c448-45cc-aeaa-88ab59cdadc5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PNYP287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23d::17) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c98f7f6-f8cd-40db-00f7-08dcfe64c332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjNWdmJPUE5WUkd3WmlaYjk5Q1lJWXMzWGtwd0lFVGtDeUJlQmtWaitNZE4y?=
 =?utf-8?B?ck9LU3ZaWDBTTDR0N2hubGFsUGtSbnNPNzhmSG94bmZ0elhlUW9RcnMxZE5R?=
 =?utf-8?B?MnU3RituSCt5Q2ZGVGNBaUZESDhNa0Fwc25semFVdnU2S25lalp0S3NMNGtX?=
 =?utf-8?B?QjRPRGNQSllnOVdMZzZIVmhlb0RjRUY5TFJtc2hWM1d5RDhNRjM2VExDWGJ0?=
 =?utf-8?B?Mk5TMjhYZXdGdjNNZy9uTzZTZmFOdWhOcmJJUFVwOHpDbkF5Z3NicjhqcTZI?=
 =?utf-8?B?cHY4emRWVFpDMWpLTjllejlVSGlyL3NxVzFzM0NOWnZrcmh0QmdvZm5ZdUFI?=
 =?utf-8?B?ZHQ4OTBuTFAzOXdEajlZUTlTeFNpNWkwdEVMRlNJcHFkbDc1d3dDbXZCaHRy?=
 =?utf-8?B?QmJVL2dQcis1WkJPbTBFSU1qQk1oQXpCUHlEelRWZXU0d3FyZzJlRDZiSUE5?=
 =?utf-8?B?N2xKOUd6Q3FvTGhHaFZXSlVsbHV0MlhuMnhHM3RoeUszNmQyLzdBcTBMdjVS?=
 =?utf-8?B?dVU4SWxYUWFOTTlTYnRZY3VIWGRSV1BOZTRJcjZDclhrZ1pYYm1COVg5TTBG?=
 =?utf-8?B?QWNTMWFxaXJ0UXFmc1JGY1ZFcFFwVjQ5K1pNekt5ZWErV2gwdkRvaUwxVkFx?=
 =?utf-8?B?VGo2c09zQzNrRDkyb3RoZHpSaUdvV2xicTFVd1BoeTJjanREM2FiZGt0MEl3?=
 =?utf-8?B?dzdva1YvMENtdk53UUFsZlJaYzJMWlA4eldMdmUwK2wrcnNFMFMrZHdOQ1A1?=
 =?utf-8?B?Tmlmd3J1OGFKNWVzd3JZWnBlaGRSUGxLVk8yWTZPY2x5UWg2OVM4d2FWcDVZ?=
 =?utf-8?B?V1IyZkI5cDQ1b0FoNmJoaktjUjV0bnd1amc1NDZ5U1p5eGVkS3pmV21xZU11?=
 =?utf-8?B?bjdvRXpyV0FyQ3JvbGlwd1QrNE5vV2hRVm9xY3hCanY1QjFLWTk0OEF4LzEx?=
 =?utf-8?B?STRyRWVsa3FEK0l4RC93eHR0V3V5OWdSSFpDSkh3cktEL0c5WitEUjdDQWNm?=
 =?utf-8?B?OUluZGh2ckVickZlS0JFTnlRc0tqZUZhQXVOQUkrOTdzcTYvbS90MlQ4aWdN?=
 =?utf-8?B?bFlnOXZVY3dXeis5cHZkaGhPUDcvbHg1RStvaWsvUG04dytnVVI2cFIwYWhs?=
 =?utf-8?B?Z3FhU2xZTllOVkc3OWNjVVVJeGZaTGJhcnE2WHFvVzNObGlRRkJDbkt5VHZM?=
 =?utf-8?B?VmM5TUtjbE1zTnRQNEdGRjQ0VUw4TE4rY01sL0RoMXBiNU5KTG5NNEdydk96?=
 =?utf-8?B?b3dLL3ZTQlRPQmpwOGx3cUZyZVpqZ1c2a0ZURHppeGUzRTE0SjR0REFWbUNU?=
 =?utf-8?B?b0lLS0FIbFQ0cW5VSWYvK1ozUE9QeURXSEorU09vSWR1Q0JMa0JRb1BDMmpK?=
 =?utf-8?B?eWRvQ3R2MUMyY0pzRjBLTk5SSFBXOWtTcGhPK1JZcFFQQnVCSDkrWUN6dDlY?=
 =?utf-8?B?SnpESlhJbmExY1AwbEpOY2hzVHhJSURvMlFVNHNUbWJMdzRtYmhGRndydzhE?=
 =?utf-8?B?dzJnMVVBbGR5dTRNbnJSQkd2d1dJcWJLM0M4akZlcERiNnpaeGFXaktGeU9x?=
 =?utf-8?B?TjZ1ZUNOcGF5dlQzNFNCbEd2NkNzWCtwUTV2bGVFVzBIZ3hFcTkybHcxOEdB?=
 =?utf-8?B?VzhPUDU2VVRFU0JtUUlvWTJkUGFDK01NVzJDRkhvT3VyWXRjQnYvaUVabU41?=
 =?utf-8?B?RkhVSU10VDkwdFRXNmUrU3N5YzR2QmdSMmJJZURlM2M5Rkd6RVpHbUNuZTVp?=
 =?utf-8?Q?FTPLTQl50+6d1TvHprDInWF79KvkUnzrBEb3UiB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2llTVhxcTFncE9IYmFpWXpGVGphemY3L3hVVjBhUlREVUVPbDZiWTB6cnR1?=
 =?utf-8?B?T2IydVFoZ2dvcDNhd3A2MS9PaXdEV1pYTnp2WDFwNjFzWWxOdTlQUnZlSVc3?=
 =?utf-8?B?YklIRThQVUFrTmczdURuR2NwZ3JlbVEwbXlWZXhUUkJwcm5zM1Y5WjlSNkwy?=
 =?utf-8?B?KytaRit2bzZ0cWdMeXZnVTBnT01mYUc5ZnJtWUg1V0pZRUEwWis2R3dvVUt6?=
 =?utf-8?B?eWJ2TUl5K3MrTlJIaFhuNzI0ZGVXR3loMU9FY3FRa25YRTU2OCtVM1ZYelg4?=
 =?utf-8?B?M3pMZXdQczhqN1NZVWtYSnJRUEZvSUo3eEpYL3VWZFFFMHYyNjcrenAwTUlx?=
 =?utf-8?B?R0V4Wm9OdEJ6bVpMRUtyTTJWNm1pOFVaZG5COUp3MnZYTkl4eHZoSjBIZW9N?=
 =?utf-8?B?dWt3alVkS045T2wxQWpHQkRESnJIdkZ3eUpJcTB2UTF4bHZuTWhJMzdnZHdk?=
 =?utf-8?B?cERwa0NQOU96eW5QeHF6RmU5V1h2bEord0JYbiszK1FaK3pQWUphTFNnOXRL?=
 =?utf-8?B?b0NMNEtHL1YrSldkWExpVHA4eitseW1PdGE0M1NLajBObldwVDJOZHlUYUZ4?=
 =?utf-8?B?QVdPTTZGbFErcUFCQmI0VHJEYUhDRm1uR0k4WGdSdXZRbjVvOGtsNjVNUWE1?=
 =?utf-8?B?VXVGeHEwekc1OVFJS0xqL2FDMCtFTFRMQ0dvTWNCME5BWU10UHVha0xsK2My?=
 =?utf-8?B?WXpxOVlIZ096Ny9kTWdZaHpldk1NQjNwQmR2Q1NWT2xuQmFvY1hyYmxCUENh?=
 =?utf-8?B?UkpvT2tWaFdnbWtrcHV3SGs0clQyOXBJditSaVlKd2sycWpmdVhoTHlhVFVj?=
 =?utf-8?B?cjZleTBqakVXSzhYOFRzM1NkNXR5UnFDZFlFT2JnS000SjZHV0pJRjdsaXE0?=
 =?utf-8?B?OFBBUUlrdW05Y1FJMWdyR0VNbDNFQTAyb25ONU41TFpWMmZ1NXEvaFJiWUlF?=
 =?utf-8?B?SUpFQWNnQUh5ekJaL3lsVFFBbkZ6YjM2OXVQWUxxVHFjdkkxS3Z1RkVqbjdz?=
 =?utf-8?B?bzhKL3F1ZnovZ3VqM2M0ZHVxOW9USXlLSU9rM2UxQXppYUlGVXpJUDJMdE9F?=
 =?utf-8?B?V3RaWWhJWFk1cDhBMktmM3N4RG84YmoyLzYxZHhmSjB5c1VTMVhSdTlsTmR1?=
 =?utf-8?B?cW14cjJDTlIxekhyZnptMklGQ3loajVwTmZ0UE81S2gya0JoTVN6a3QzRGJM?=
 =?utf-8?B?Nzl0RDJqUEVRSFpnTGtFMDgxR3JBUFdiY1hHQThWUUUyY1RzUU80YUlrLzBT?=
 =?utf-8?B?ZDFvSGVhcVROZ3phUnpMNXFDeTJaRWo0ZUtwMUJ1b3FIT3ZXTEZNZFh6Q1J5?=
 =?utf-8?B?elZFRXpEK1FTY1UrbkcvampGSDRLK3pwVk9TVUtkZjBmcnMyZ0pqSnRtWkZz?=
 =?utf-8?B?QU90QUpjM3JiaEU2SmgrTDNFNEVxanIwQ0tuWmdFZW5kdk5CUFE0NzNMV3Iv?=
 =?utf-8?B?SzBvVFFjdWF3MHpScXp3Ylk4LzI4bjIvbllISmhCN2FUMms0TWNBTjNhdWJR?=
 =?utf-8?B?ZnFvdW5nNkxpR2R4a0EzZzhQWWFWZG5FWjdoTFVYV0lpWEtuMTZYamRjdlRJ?=
 =?utf-8?B?V252RnNWaStqSXJSTVk0eldjV0hDbXFTZlhoZzFvMzBtR0RaMkgyZTJ4WmpZ?=
 =?utf-8?B?dzNBbzBuT05WOSt1OVkvYklXek51emxieHFCdnlwUUZNMkRlOWhLZW1EWW5H?=
 =?utf-8?B?WCtWNU1ZTzZHTEhtaHFzNjNsS0hkTGdEemU1c1QwbFNxQVJkVDFGak9qTVUy?=
 =?utf-8?B?NTZFTmtERGV6NUx5ZkhVbHRiaUlxNUtVWHQrVG1sWEFDcU5KbGlxRzR1MDdP?=
 =?utf-8?B?UFlWRld0aVhJTVBkeXFpSFBudCswdjlCUDFYaDhWMGZjVDZUUmhSMDZENGt5?=
 =?utf-8?B?UUplbkRmYjlDN0l6Zk1EVWNRVU8xWDNPY0JRUFF3RTA2b2JRUlkweVA5ZHZP?=
 =?utf-8?B?bUpvRGlrL1RQckRXU1VrbHVTMXdoV0NadUlvcTEvamVRSEt6ZG9Xb3E4c2xP?=
 =?utf-8?B?S2drSEJMT3VvTjQ2c285K1FRQkNkUXpqY3R0M0dWbldydERPZEJ1MWNRUDBu?=
 =?utf-8?B?MEM4NEFxbDJCWHNyY05FbXNTZmFnRlJIcTZMVjcrcVpRSzJvY2o2elZTbnYx?=
 =?utf-8?Q?rwhSrjEY6MQN93uv5JqKhc9ik?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c98f7f6-f8cd-40db-00f7-08dcfe64c332
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 13:13:10.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLOIWn95oEUNIcaBIZboM56n7EjB536Yxr38mHTT+G12JNSprtpB75EpQLBQsAiC+BX56nosoh7icabsaFAcbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235



On 11/4/2024 20:04, Jarkko Nikula wrote:
> On 10/23/24 8:51 AM, Shyam Sundar S K wrote:
>> On AMD platforms, the IRQ lines are shared between two instances of
>> I3C.
>> Add IRQF_SHARED flag during the interrupt registration process.
>>
>> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> ---
>>   drivers/i3c/master/dw-i3c-master.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i3c/master/dw-i3c-master.c
>> b/drivers/i3c/master/dw-i3c-master.c
>> index 1a7c300b6d45..fd58a95ae1c3 100644
>> --- a/drivers/i3c/master/dw-i3c-master.c
>> +++ b/drivers/i3c/master/dw-i3c-master.c
>> @@ -1578,7 +1578,7 @@ int dw_i3c_common_probe(struct dw_i3c_master
>> *master,
>>       writel(INTR_ALL, master->regs + INTR_STATUS);
>>       irq = platform_get_irq(pdev, 0);
>>       ret = devm_request_irq(&pdev->dev, irq,
>> -                   dw_i3c_master_irq_handler, 0,
>> +                   dw_i3c_master_irq_handler, IRQF_SHARED,
>>                      dev_name(&pdev->dev), master);
> 
> dw_i3c_master_irq_handler() seems to be otherwise ready for shared
> interrupts but reminded me it might have a similar issue than
> drivers/i2c/busses/i2c-designware-master.c had [1] because both are
> runtime PM managed.
> 
> To me it looks dw_i3c_master_irq_handler() may incorrectly process
> interrupt from other device if register reads return all bits one when
> device is suspended. Worth to check.
> 
> 1. Commit cdbd2f169bf1 ("i2c: designware: Do not process interrupt
> when device is suspended")

Makes sense. I will remove this change in the next revision.

Thanks,
Shyam

