Return-Path: <linux-kernel+bounces-413459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BB59D194C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65585B217DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CB11E5716;
	Mon, 18 Nov 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j5PZHrdv"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537E4191F99
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731959467; cv=fail; b=Ck7iUkZKBm3BNbstru74jl+8vAEsgsxJ+9IqC2ho3f6GW/Y+FJxKEuH0cUtYHZDmsHzseM8rPvByDR0Z0xUuUwEQD8urOaq/52KC+OQpcZxYsRMahSi4MGSDWtgPrbmkHC6tThoy/e5+V0wpyrklXx3mTlN1SpvcyAynpCMiMpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731959467; c=relaxed/simple;
	bh=hw4ZJ+GvHEam4TTa7rQ/kFuUbNjgQKgPRzNuXI2FAcQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I6szaegLftN5ZJfJa03IXNND0pfEhvFyqz4jLbXW61xBRlJahXONqmgQTXgbWmTODVmEF2ooOT4QffYc2VbyHP6xOemQfWK0zV2acBdbPd1cNq0mZHFNTTIFeWVN379hfELo/5cUDEIKMe7rwJzfoNTuaWc/xLLRhC99pR7EH5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j5PZHrdv; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqv1wfdPR5eQ5NAPSk01I4fOI4VNLCIpnVN2+WVXmEw2mD0j+iSB6jCG0cgU87NmPvxEupoNSurSNYcz25AIDRYNR10UEI8qeVbg4hfTeGADN78wjuu1HshRYgTi4T8ADKbdvv4G5L9nTt/whxvVpDu6gCILGS19Nh0Eg8hjg7iU+kaBz0Ad8psl5e8acy2iNoSifDlNaKAcY7TZaobBj/fuCSMvqsv71/oLjLcKyw7iNIL9wAuRGYKjTvkk4wwI8YbybcNlGI3qEq96sq2bS5ClQLosX7prUSVICsFU0OadnfcxeP1AvVCSF3rbJ8+NJj3TCLXgKjS0wfN69iYYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vjy2GRFjVv8URAQRFqZZGtSTL/1kzwNlW8p5CA7Epqw=;
 b=Z9O0Aa5qXdGf/TVyd+1Pe1VVy2nEZyJi0g3Cjojf8+wd7iYfgbGx9TrxW5aU+QuR9nqUzufobbw4u3QUUhGsJ67AwASi6Tldd22sLhS8V+RwsX9NzlakJ6j/GuQeTuWOoEkkQam0cD8lPmML34/ZnjxJNY85FHo4zDuEBBnaRrhkrHUF8eJzouzU0PXpzsII/G7gLI5d728lLrZtIUwTjdzvCdcHlFTVB4RhK30txiNbDkE/ni62zG6U5obkJD2ZBkDcx8go4RcGmZG4HIlXciuJwv9jel3V8zV1npX7CGAE7nICyQAM11lcn7vk6+QbOPT6w6BXyYz2kgk/iUUN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vjy2GRFjVv8URAQRFqZZGtSTL/1kzwNlW8p5CA7Epqw=;
 b=j5PZHrdvbeRauYa6QLRgPMntNTUDVeMX9MegKxD+JvEHR2F1SbYtFdffcII5cdzjZymVFpcpXa/MxJ97oSSv9q/OstqdEk55dryVED/myg1aEgYNVnz9am9Tm9cae9ETKhAWVyQ+zpD9dVqjWPLippCo45fWY9WSpWo0VLpplFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 19:50:57 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 19:50:57 +0000
Message-ID: <182fc3f3-2b9d-5c86-b058-5d1208305cbb@amd.com>
Date: Mon, 18 Nov 2024 13:50:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Content-Language: en-US
To: "Ragavendra B.N." <ragavendra.bn@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, ashish.kalra@amd.com,
 tzimmermann@suse.de, bhelgaas@google.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com>
 <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>
 <ZzemwFBfEIgFhrD-@desktop>
 <CAMj1kXHPut9qv7dT9Xv=xhbS6AP3HRP0dikk-G690AKfLuNLGA@mail.gmail.com>
 <c7a9748e-aead-b252-dd29-48dd0d2da9be@amd.com>
 <30558bc8-c22c-1ce1-f59a-66c057fdd06f@amd.com> <ZzuYy9KHwlLa9HLY@desktop>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ZzuYy9KHwlLa9HLY@desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0187.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::14) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: bda64655-b1cb-4bb5-6ad2-08dd080a51ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sks1dUE0T3h4Y2VRYStSSE9tMy9ieWhYVnVBYTJhTmh4cnh4VWtCcHZnUlVJ?=
 =?utf-8?B?VHd0bmxnckM5N25ma0lWNUF3S3Z6SStWdDJRa1JwZEdkVGI2QVBwVVdOV2Qw?=
 =?utf-8?B?c2ZjMFl0WnRUeUxHL3UwQ29QNWw0eTlQMjc3RGRUeDZ1aEFDV2hLVDYvMDY4?=
 =?utf-8?B?b2RGLzN3V1lpeUU0S3BpWVhEUnpRaEI3Yk5zc2NPN01RV1dWcFIvUGtTb1No?=
 =?utf-8?B?U0VKWnBOd1dTRUtlVGY4UUs2c1YwWnE2QXJzYmV0bEJROTV3bjgwaXBCNVpz?=
 =?utf-8?B?QW1yUnhXYjljOHc5OGRkb2VvNVcyMFBlTEZvN2I1b09CUFhNUmNGbHpYK2RZ?=
 =?utf-8?B?QmdZaDY1SEM4UlRvdXlPRzV3UmI4THE0Q0o4NjNFeFJ3TkUxQkFRdGtLc3Q1?=
 =?utf-8?B?cTcwSzhOZjJwRFpxSngzMkJQdzBLK1ZXQy9KRjdRUkpJNHhtUzZsdFFzNFFS?=
 =?utf-8?B?WlVVSHo3UkthQURKclNwNDdEckE2WkVIWlZROUVZNHVBYTUyNnI5Mm1vVmly?=
 =?utf-8?B?NjFCR2xXVEdmbTZ4WEFsdGswY00va2VubEN2V29FTEh3clRIclBlQmkwZFdR?=
 =?utf-8?B?bGtRZEg0ME5HcWFVVVNIWkNGekpHQ2NZeGdPQ2JHOFAzak9ZeUZlaEJqWUxO?=
 =?utf-8?B?NG1SNExrRldJc0QvOExwZDhFWGNPOGQ5OFNwTThWQmNjY3NpU2g5NjN0d1py?=
 =?utf-8?B?WG9GUEcwalhlYlV4S3JwSHAyaEFSWGFSanFQelZnZmFvdHMwZ0t5OHFUWlBI?=
 =?utf-8?B?TmwyMWFsYmRoeUppMFRBZ3RjS1pTVmt1cVVnZEQxUU4xQmlKOCt6QUdoRm5k?=
 =?utf-8?B?Y2c2cnNUY3M4Mkd6UnpQVkQ1RHJieGFDTFdhd2RRZzk4TXNXRFgyUHVhOGJm?=
 =?utf-8?B?NWhIaFRlNkFBbnB4L0s3N096NUlhYTN4MlhBSFB1MzdBMUpUYm83VHQ1aFgw?=
 =?utf-8?B?TjlzZXEzVkZrYXR1dTRCMkhWRlE4cFNnU3JWQ2hveDV2TkdadGhaU3VsalBu?=
 =?utf-8?B?bll5cTVvMHp6VTcrQlZBNklvMDUxK2lGcHNOditVZXhXL1NGQU80TFNDMTh2?=
 =?utf-8?B?MlV2aVZXNHBTZW0yaTZsSDVhMnFjMUpCbnBneVVuL0RuQnpXT2xYditmVUlM?=
 =?utf-8?B?U0dDRDZmUVZHYWxYVm1qMTJuc0tVYkt0L0wySVdMZFczN3RmSEZzb3F2OUYr?=
 =?utf-8?B?T3ZlTGdXb0tzeDNIVmdBTCsxMk81YzJScS9GbFk1YTdXclNGUjVNMWNVN2RV?=
 =?utf-8?B?UW03Y0dkRE5FK2I5NVRTUVJhRzRPSVRnMjViTXgxMGk1bEExclpEa1dkazh0?=
 =?utf-8?B?bHdBVnVrc25qdE80d1NCOC8rbVFGY0kyQVV5ZlhtdVNuTUE1aVV5UDg1NkZV?=
 =?utf-8?B?Tm9zb3dEN0VNYy9XVUdOeGxvM281M1gwUlkrdVIwU2dsQnBhZlZXYWw5Z2N6?=
 =?utf-8?B?K2QwRnlNVWlWTjhFQ2lrbnppcmlpMEI2VFZVU2V4bWp6V2FabXhONyt5SXpl?=
 =?utf-8?B?K1QxSnpiKzdWem1SYlcxbWVJWFJvRGI2ZG9nc0pnNU40L0FDYkhsOFhtQk5i?=
 =?utf-8?B?ZXZOQk5QTE1BWEw4VzZQWkx4bzJHSzJzT09waUZYMEx2WU9JT3RnWXJxMkg0?=
 =?utf-8?B?YjNMVHJ2MitxSUtDdHB3TGxCZTcyZXdyUnB0ZG4vK2hGOVNHMy95TEpBU01l?=
 =?utf-8?B?TCtMUlF3UFBQSkJvYmFnSFVDeXc3S1RtZkRSdW5RRU94eTRRNFk5UGtCMnRj?=
 =?utf-8?Q?Nvxeqt1EpLS6/de6Gdul9TKtoh6iGcwn8TA08cn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzVJZ2xicXJDVSs2T1JwMncvdU9peDZCS0NONHJQdWQ2dGVva2t1ZlBacmpU?=
 =?utf-8?B?Ykpma1JnbFhzSGc4aDVZV0xMa3BhZDJiVmRCelcraHplWlQ4d2Z3SjlIZ29K?=
 =?utf-8?B?c25qVXk3bTRZTStKRHBCdkVOVmQ1QlEva2d3REZtaHE2aVp5dVpwV1hBOEcr?=
 =?utf-8?B?ckgyNmdQaVYxZUsrVWpuVDNzekw0VmZrbU5teWVkUW90MFdXN2lZZmpoTUIx?=
 =?utf-8?B?aWorVkQ0S0NRVGRqcjBiOTVuOGdEaEUyaDBtTjJSVnlkQWg4M3dtMzhBZGZK?=
 =?utf-8?B?YUI2T241aHhUYzNzVXc4R3ZpVzRYd0xubXN0L2JYZUN6MXVBbDhac1ZuclV1?=
 =?utf-8?B?YzdHMCt2emZheENVVVpTM3AvNnRWR3ZNcWRFMUVnN3BMelB1SzB4bGtkV3Nt?=
 =?utf-8?B?TDdKVmhaRW5zcm5uMHRXWW45MW1oOHpyTU00bU5UZ1h6VWVSZzdnUnBXWG5N?=
 =?utf-8?B?RG5Mc0lQV3ZrUEpTN1lDRnc5WFRTbXVFSVI3aWNOWC9JemZ5Y1VWSGQwY1Nn?=
 =?utf-8?B?Qzk5OURKVTNYZHQxSy9iUGZpcnhKZWkyOENoMDNHaW5wY1d6TXhKWFJ5eXhl?=
 =?utf-8?B?cjJTTXBwRDk4NG9Fell2K3cvZnRicU5mZjZTRjRjdWpKR29DMWoyTVhId2Y3?=
 =?utf-8?B?QnpQUkFLL0NrdFk2Rm1rbFZLZWZlNFlrbnE1Y0FyZW1ETnlESURIb1lPQktu?=
 =?utf-8?B?TVcrZ0ZheDg3Zm1JcFo5OEZUMEg4SW8vSHJoMGV0OHY3NVFuWnNVRXlZQ3FT?=
 =?utf-8?B?TWJVVWRIYnRKcXUvYVVFZkQyVk0xYnB6UzduUGJtZE9xRlJydEkzeFY4clcz?=
 =?utf-8?B?b2x6VVlVc2pDeFJtZWF1cTZiVlUxMEV2K2VqUmJiSGVEZ0FRUlVTSEowaEhO?=
 =?utf-8?B?b2E0Unp4cFRLQitPNGpsOXQvU3NJQk9nU2dZNStVQUdFMnFueTBoNXJBVFBl?=
 =?utf-8?B?bUZNQitJOGNrVXFnakZQUUlxTTNvT0JzeUN6Vk4xN3BxMkdBZVBIVnNoa2I0?=
 =?utf-8?B?T2ZnN2x3M0ZhREQ3bnVKSXExdW45amhGeU91MndmelhtNWJtNEVzd1lvUVZ0?=
 =?utf-8?B?V2daSXJTdCtEQkdQWVYxNkhsS0FpNGJabkZBeXZVdFg3aVR5YWhOWkNFU0hI?=
 =?utf-8?B?S2NOM0NuSnZlMUFmdGdpQXpUM0VUZWtzRmFlOW5BaHY4elJnbHZkc3FzdHNo?=
 =?utf-8?B?VW9lY0FSWEpYQjdHT3Vpdm42djNrRnZYUnBFaExwL2kzaDJXTjNtanloNUJY?=
 =?utf-8?B?SjdWZEsvU1hCYVNyUzJaTkpwTTR3aFZQOVNsaUc0bzJpRjU1em1KYnJURGJO?=
 =?utf-8?B?bSs1NTRIdU9GWUVHTWExNDhFcjV2Nnc3UHlMM0N3d0xhMGZPcW5oblRJTWkv?=
 =?utf-8?B?KzkrOHhjOXJORDVlaGh4b29tbTZibnFLYkFHdStFbktKNllwZUFoTG5vTGJT?=
 =?utf-8?B?dUhjemh1RXA3SWgvejJIcjdya3dqWm1VeW5QR1Q4VTN0NEl2VGNYZ2tlT01S?=
 =?utf-8?B?eFJpNTNvSEFyNnBuVnZrUWd2MHN4S0lpcm9CZlpsaHNCYXIrNXkwejVZM3RU?=
 =?utf-8?B?eFBIL0swZU1kbHhSOXpUUzNodHFCWlJjWkVLRyt4QXR5QzJ0MHR6b3pvOWlZ?=
 =?utf-8?B?WktnVGZQTWgvT1lOanZoM1BTb2hFbkRsL2RYZnlXZ2c0ZnFhUG95THZTd3FM?=
 =?utf-8?B?dTlvU3hyd2QySkFmZW5CRGhSUWYrM2NNNTluM3NMRlpVR3MyclVYZmp3MFVY?=
 =?utf-8?B?N2xiT2NEcVdjdFEySmJRbEgrbURvTTNjWkpSYWg1a1p3YmdXdjE2cUQxS2Jv?=
 =?utf-8?B?c0JHOWhiaklyaHlEYWQ0Sk43ZGphVHBJc2JwNlhXb2FCN2lHY0VIWkEzUDFi?=
 =?utf-8?B?a0IzZDY5Slk5NkhFeDhCdWNmK3ZhOHFLT0R3VmhqL3dwZktQRTdhZnhzU3hj?=
 =?utf-8?B?R1gwR3laWGFtYnhhWHhXWHZ3UEJJSEZGVHE3RGU0cEtkM05GK1RxSDNrOSt0?=
 =?utf-8?B?TEVpODY1ZzIwNm1CUHAweGJGUGlZbkg3K3NYL21JYytuK1hRV1BYY2x3NXhs?=
 =?utf-8?B?clBRa25RLzJMNGpEYzN3NDVKVUt2b2U0aXhyRFhrV3ZnOUdTWUtiK0c4dlBG?=
 =?utf-8?Q?udBA2M5OfgLYnEwNPDHsE1iTT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda64655-b1cb-4bb5-6ad2-08dd080a51ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 19:50:57.7240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vk+cl5YDF/qzewvuAeKEX8CsdSDb8Hj/RTJHJuZ1YtB4X2HABu2S8Zxmy2tmizaNJbQTjtn8OBncAhGGBGGP4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797

On 11/18/24 13:43, Ragavendra B.N. wrote:
> On Mon, Nov 18, 2024 at 08:53:04AM -0600, Tom Lendacky wrote:
>> On 11/18/24 08:44, Tom Lendacky wrote:
>>> On 11/15/24 16:55, Ard Biesheuvel wrote:
>>>> On Fri, 15 Nov 2024 at 20:53, Ragavendra B.N. <ragavendra.bn@gmail.com> wrote:
>>>>>
>>>>> On Fri, Nov 15, 2024 at 12:02:27PM +0100, Ard Biesheuvel wrote:
>>>>>> On Fri, 15 Nov 2024 at 12:01, Ingo Molnar <mingo@kernel.org> wrote:
>>>>>>>
>>>>>>>
>>>>>>> * Ragavendra <ragavendra.bn@gmail.com> wrote:
>>>>>>>
>>>>>>>> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
>>>>>>>> it was not initialized.
>>>>>>>>
>>>>>>>> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>>>>>>>
>>>>>>> This 'Fixes' tag looks bogus.
>>>>>>>
>>>>>>
>>>>>> So does the patch itself - 'struct es_em_ctxt ctxt' is not a pointer.
>>>>> Thank you very much for your response. I am relatively new to kernel development.
>>>>>
>>>>> I know we can use kmalloc for memory allocation. Please advice.
>>>>>
>>>>> struct es_em_ctxt ctxt = kmalloc(sizeof(struct es_em_ctxt), GFP_KERNEL);
>>>>>
>>>>> I am thinking to update like above, but like you mentioned, ctxt is not a pointer. I can update this to be a pointer if needed.
>>>>>
>>>>
>>>> The code is fine as is. Let's end this thread here, shall we?
>>>
>>> I was assuming he got some kind of warning from some compiler options or
>>> a static checker. Is that the case Ragavendra?
>>>
>>> When I look at the code, it is possible for ctxt->fi.error_code to be
>>> left uninitialized. The simple fix is to just initialize ctxt as:
>>>
>>> 	struct es_em_ctxt ctxt = {};
>>
>> Although to cover all cases now and going forwared, the es_em_ctxt fi
>> member should just be zeroed in verify_exception_info() when
>> ES_EXCEPTION is going to be returned.
>>
>> Thanks,
>> Tom
>>
>>>
>>> Thanks,
>>> Tom
> 
> Yes Tom, that is exactly the reason I worked on it the first place. The issue was reported by the Coverity tool.
> 
> I can send the below fix if that is fine.
>>> 	struct es_em_ctxt ctxt = {};
> 
> For the es_em_ctxt fi member to be zeroed, I can go ahead and assign 0 to all the three long members like below in verify_exception_info()
> 
> 
> 	if (info & SVM_EVTINJ_VALID_ERR) {
> 		ctxt->fi.error_code = info >> 32;
> 	} else {
> 		ctxt->fi.error_code = 0;
> 		ctxt->fi.vector = 0;
> 		ctxt->fi.cr2 = 0;

But then the cr2 value isn't set/zeroed in the true path of the if
statement. I think a simple memset() at the beginning of the if path
that will return ES_EXCEPTION is simplest.

Thanks,
Tom

> 
> 	}
> 
> return ES_EXCEPTION;
> 
> Thanks,
> Ragavendra N.

