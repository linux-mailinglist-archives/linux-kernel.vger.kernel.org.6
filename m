Return-Path: <linux-kernel+bounces-332782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717197BEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60B09B21957
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C581C7B83;
	Wed, 18 Sep 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iryBSlbp"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD81537B5;
	Wed, 18 Sep 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673958; cv=fail; b=IA9Glv6pOEglG+8q7QbGgngacjmYW83zhoeCFf+uFreyMlvKntLX6/ci8YikPwBr2YLuublpNMprhd6J9EVBjCQ5A+NfsAl0LKQNn5/E+4yCngZAZZn5LKr7F+PYR6c6WDEY3bY1UAFYCtgDyA5DyS0nrHGkp8EoiCaW9RqLALg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673958; c=relaxed/simple;
	bh=E4KHbbhm9w1EMwr+9zbJW5qKsEP0RsDUV3nhIEnk9n4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U4Pq08AIEUjujBEQ9XhkionQSJPBsrxF0OB5tLLY5AgX63UXjNqCbcDOETYuJVaGKPTzPnTCjup0sd43W3c9AEjgwM2gBMHzngVoHnesdkKpaAt0tiPt39QHfMgzopSVU7RQYRRGPBMTdJ4oeBTd/nQJxdpe4kQfcLTU7cAUQgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iryBSlbp; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRej1C7utWKZDMquCDdMCFie1ao3DAOXpf7hoQ2+6QbVun0UMa9vhK0KTENOzrqpRTi5PNpMAsE5awPTQQw24uT8A3J3xYEwB0HV1KNZvTJvlRktUGxL9hUL6OkqGu4+L7eBNqrQJIaOvaKpFZtLLr5HmsYzTN/4/oO/LYgv4qmjymBAg8MYUMe91pvkrliStexQ38iOsOIXnEahUh1fSCCShom4/787F5F4uHo3RyqswtFR+SADEkOehHy2ApI6n3qo/1N+Q3riqR1dbA+SOkGGfFsRPUQDjV365dVYA0g8VvWk7H7SVYXaP6Tulh9qhqKu/ReeAdh+XBj8HnrI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYvfQchTG15funOPifGUGg8JRAqUZ+dMyRZp8uWcbOk=;
 b=KI7200m4UsDYe+6xmq1NUabo3N4XyBpWuntMLBu8Zg4Z2CkQYsq5mmM52Kx41WFaAJqoxe5IqSOjKeKhB68GaKydfxyzgPpkSznSHZFlTD6ljj910cdsKsCghGETb4xcPnIdyspbovKRylv1mHqOBZuNq4Ktpj/yYMVxyguyqfs81Douy8+xLzcgWdot9y6B7lHwYpuUNqqhpNfJWFpHc7OeuJSQVCHqYOlYBJA9xD3REDsas1bwPz3ypgC5bmsVX2zTORSzei2IMnXQSAjn+EQPmtMV0fNqiger2C0UF7Ijfvul0v81dm4EPCm3PmbEh3TCWgNgXYVFjjNb1TWIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYvfQchTG15funOPifGUGg8JRAqUZ+dMyRZp8uWcbOk=;
 b=iryBSlbpTAnJnHeB1/6gwZoHkW9a2kK9pTrFzhaxhK+TqEiosOXDEc4joDNIQbIPTmk1OI+bbBM+YUdURFxvbLWEXgovDbq88LaWohQs1djkWPLNlcTwgSX1c17YGhNQa/PGLV0EmTqTxkMC4pnMRtmIDF4umDGxUd9zPzzookw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 15:39:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.016; Wed, 18 Sep 2024
 15:39:13 +0000
Message-ID: <bd5155ec-a90e-4f2c-8e56-da7a986fdc13@amd.com>
Date: Wed, 18 Sep 2024 10:39:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] platform/x86: asus-armoury: add dgpu tgp control
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com
References: <20240918094250.82430-1-luke@ljones.dev>
 <20240918094250.82430-3-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240918094250.82430-3-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0082.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f4526c7-a3bf-4068-dafc-08dcd7f80bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGJuSm9XWkxnWVpQbHZ0alZ4U3BqK0xrcWt0NVJSU1lhbWkxYnlhVm9lY3Z5?=
 =?utf-8?B?cHZuQ240RkFQOUJHR2VSRWZCTkt2ZHRMbTRYUDdDNGNucmZkaE9SL0laWTkr?=
 =?utf-8?B?c21mM2JYN2ZsaERKK2J0Y0Q1K2M3SXpwUmJPcHMxWXo2QUhOamg1UE1KVEto?=
 =?utf-8?B?dkVmWXF1TFFjWnk4VG10ZVNwVWpWOTkxZXUzU1ZIajc0VE0ybTFXWWVUM01C?=
 =?utf-8?B?RzFWbmV1MnM2S1ZmYjVJTzBFRzFNbXpzdVd2NnlkMHVlSk1YK0VoeTQrWjRq?=
 =?utf-8?B?YlliMk9oQzJhODBZNFBFVzdPTVM5TWpESzljb3lvWGhpdmtQR0RuZzk0dHdQ?=
 =?utf-8?B?MzY5WUpTazMzYVhocUsvVHBnRDN5TXlpa21KSG1maVpkZ0NhZ25lYno5ejBX?=
 =?utf-8?B?Vno0WFF5NEwzVUpuZ3hhdXB1amx4NG1MUGhORmhkMVhUZTh4MVRSMkNaUUdJ?=
 =?utf-8?B?emxTNG9uTnliQ1p2OUhvOEYrQURBODgxNHVkUVhNQVc2R3MvNk13Z3JPOWdZ?=
 =?utf-8?B?VHJwRWI1TWFnOWlwdUszdjAvcFkvb084NjRjUEw3em02WXNCTTR3WjA5dnU3?=
 =?utf-8?B?dmJpUmhiQVVLZFFUWWpuYytPYUQ4TEhTbHhsVHBMekkyMm82OEJ0ZVVzc3Zq?=
 =?utf-8?B?NU5mc0dRSmhJZ1FMMTc0NG41K0pYNGhkRktwWlRQN1VydVNWZTNlRWY4cGVY?=
 =?utf-8?B?Z2FIa3paaVNsMkgyNWJTcXBoaDJFWVhPQ1ovSVdCVTF5T2dEc2RtejEydUl0?=
 =?utf-8?B?Z0FEU3ByTGdCMEd1Z3NUWk44dkJwdzdXdFZwWDU2VTREVWJNeHRuMi9Wb1d3?=
 =?utf-8?B?TDBOVWVIanVTOFNyRUFkWXFMMVp3OEQxTXNya1FvZ0FrYXpLcktTYXkzck90?=
 =?utf-8?B?dlVCcjNyak9jQnhLRmttR3QzbHpJbUJ0RTYyeHJZUmE2QjRsTlQ5K0J4S2xC?=
 =?utf-8?B?cUo2bEhiOFlVMzU5SW1wTDBROE9Gc0txeWpRY2thbG12ZDBsNUJFTWRlVEVx?=
 =?utf-8?B?QlJ0elFnN05iZ3Z3RXNIMGNLWjI2TkNoVXV3bW9XS3BNMWsySFFvMHk2MGh3?=
 =?utf-8?B?ZlQvajU2V1N4MEJjeU5rVUpBK1hwRW5HQld1ZHZIeHdPTGFlSk1zZUZCY3NM?=
 =?utf-8?B?TWZBa0d0TmxKeWRBQ0JoK09hYzJWZWllRXV3WXJabUw4SlFReTIyeU91VVRQ?=
 =?utf-8?B?SXpWc1ZLdWorQUdEYjZQN2sxVklrTjVPY1NTK24wbGw4RDF4RzZvdmJ4eGJT?=
 =?utf-8?B?K091dTJFUEd2R2Nma1BIc1h3Yzh0ajBYTTRVUmdPODhRYUZVckRTUytTWDR4?=
 =?utf-8?B?QkZiQy9oRExXWlpvbCtodXNuazdncGd6VlVIWUE0MEFKT0FlaU4wOHJiUDlO?=
 =?utf-8?B?enVxL20va24rMzJ3NlBBcldYSnFvSmRiN3dmaUE2WU9EVDZIN3FyL2hBM2JS?=
 =?utf-8?B?ck5BUUtId09lQlJaY3ZRbGNxWktLNyt5NmRWNkpnMkgxL3B2Y0NNZmIwbzhN?=
 =?utf-8?B?endMS2Y4RHFNQzhYSnRmdWVENHJpcHlxRFMxZEZxWWNBcjRSUFpIeEVicWRx?=
 =?utf-8?B?Tk5DcnAzNTFMamV3NnN1elEveFNEanFGekxXaUk4NGJ5eXN5UnE2cTlmdWlx?=
 =?utf-8?B?WGEzK2FUUE44cDM4bExaVjl1UU05VVN3OEduZ3g2UzdvNDBwZ3Z2ZG5iZmJB?=
 =?utf-8?B?c1R6L3VQSTBDdGhSRElxa215MFUwREJCUW5QMVFWM0dndU9hWVRyWkt5cVlp?=
 =?utf-8?B?S3Zienc2dENuYU9TNmJWMU1wNnE4bFVVUnpjZkVrM1d5STkrUTFsUE0zalQ2?=
 =?utf-8?B?cTM5R1p2ajRXbHlKNFpxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWtCOCsrVWZtMzN4cmJNZ21IUDJZWU5kSi9QN1djeWovczdIUE1DanJNeTcx?=
 =?utf-8?B?M255bHFuTVNBVG5PMm5jbFhJTllrNER3KzhxdmlnNkZQU2FVUmg5ZllvM2My?=
 =?utf-8?B?ZGZXem9HLzEzem9EUVFKTFRFeUhTWHk3Smg2ZXRhbmtHZ3hSbGd3R2x2dFBJ?=
 =?utf-8?B?MU5WbU8wSDVFbmYxSjNHSWlHTksrTFk5clU5bHNwTVJuMVJXTC9RTk1TM09C?=
 =?utf-8?B?aGJCMU9OOEZ0YUxhVStIc3VON2p2T2FlS3FWOUt3MzVMVEx3dGt4RjMxdWox?=
 =?utf-8?B?dkdIS2xkOHlPMDMyb29reDV1NDJwTWxqSHYxUGp1TStZTHUwYTJ4b2VWditv?=
 =?utf-8?B?Y0xJckdqS04wWS9PVzM0WmYrVjRmVEFGQlZKMkROUlYvZm5DNzhRbFpSbnJJ?=
 =?utf-8?B?bGVlUFRNSWJvaGlwZmIzWm5saTJBZGl1MFc0cGt2M0ZDZTEyOVdaZWRlZ3hE?=
 =?utf-8?B?MzZUN0ZlRExjUWdBazZ6M0Vnb3NPUkJaaVBKQWEyZVVzY2cvMm5Xc29YNVZr?=
 =?utf-8?B?V3dHRC9tY2FJUlh2dXZCM0hHOWZzSnNtOXdVRE5ESlJ3R2o4OGhKdE1WWjNH?=
 =?utf-8?B?Y2JwQ0Z1eElvUDlTaUZ4aGlTdkpHV1Y0TE5hVHRPQUc3dDc2U3IyK1F3WnBH?=
 =?utf-8?B?eGFEMWk5OGRFcGFLM0Z3M2ZsSU1ZUlNKZ2FxNmV1MVh5RStxZzh0Wm1aTTJE?=
 =?utf-8?B?VGVJMG9memZKYzhFRWJCbXIzbmpLU1RxTGNja0Ezbm1TOTZwRXVkOE5hRVhq?=
 =?utf-8?B?ajJlNDl2Y011UGU1SmUrcjhZODA1VFh2eHBMN1dmWWpqTEFNSlpLdFAzdGFj?=
 =?utf-8?B?c014WllBVHNYYTh1MDdWRnc1dVhzcDBiT1ZuekVDM2Y5bU5sU1EzdVhQOVJP?=
 =?utf-8?B?YzNEQlB4WlBmUzVkTVVuVEgrbUZaMDRwUnZ4TVJFcWcrME1Gd0xwN0QxYThp?=
 =?utf-8?B?SjZPWUlPTE1Wa2dORXhEWmlLRU1Hc3dRRVpCdy85UTgzYWQ3Ryt6M0FwTUE5?=
 =?utf-8?B?bDRneVZhZUZJT2xwWHQyWmIybDQvZkM4a3BSTlZDVTIyVkxKdEZJU2RYajVT?=
 =?utf-8?B?RHg3U2NzQkExaE5OSVByMDEvQ3VOQnkxVHBXVzVqbEVaVjQzSUJyY1NXeGJZ?=
 =?utf-8?B?dnJHYUx4TDU5VjhUL1NCdXQ1emtUNTg4NytrbHVlWFZNZ3lVcTAxbUhJWk5w?=
 =?utf-8?B?Q21yOFBCRWdRNkpYZlE4N3QwazJqMk5GcE9Jc3RxTkE2eHhQYWZrMjZlUHZR?=
 =?utf-8?B?Ujh6NTBPRHYrc2NhZjRibG95QUpSdy81cm9WV2wrd3E1VjJvYVpKb3dsS3Fw?=
 =?utf-8?B?UHNhTGs5MllwSjBqcnJTMDFyYW9hcGFCT2cwMXpYdFVndmZCUk1LcDErNnd6?=
 =?utf-8?B?bjh0ckNVR0t1VTFUWnoyU2JYME83b3U0bWpTcTNTUDhXQXNQOFZmbFRnMzh1?=
 =?utf-8?B?cjd2dUpBbC9KaHBDbDB0T21aR2dubDVodSt2bE1Gdlg1QmVLM2RaK0VXZE4r?=
 =?utf-8?B?RmxNR2pZcXlUUU13OGRGaCtlb25rZzdzMFNER1ZzWjBLRk44R29aOUEyU0lL?=
 =?utf-8?B?L0U2amptU2t2VHVSUTNOcEFFdklOcGdpNTlTZXdVYTVEclk1cUlEYXdnQUVh?=
 =?utf-8?B?TDZhQkJLQ2R5cFdqSVFSNHRnYVdPYkIxSUNYc09vZjQ3UldHaFdjTEJ5NTJz?=
 =?utf-8?B?Yk82bURWUlpUR3dydm9CZUdjTjNTT2xWTlFXbEsvOUR4ak1nU0tlOXc4dTc1?=
 =?utf-8?B?SlRIWXBSV2orSjhsZ2pNa2VQbFhTMkVTN0lsR0NXemdYUnRGMGRaN215Ujcx?=
 =?utf-8?B?Y2dsWGVjZUh4Y0xHazlrOHBmYjV2eFpvMmZOdi9sd3FBVGJZNTk4aS9IV2Ev?=
 =?utf-8?B?VWJZbktjaGduNndxZHVtU3EyNzZXd2JFZWNQaUtXeEg3VnExdGpqeFhwTjlD?=
 =?utf-8?B?TFZ0dXl5UVJobGRSQWhySnppdFIyR0xUcUhRcEh5b1l3a251TlUyZmZkL2ZU?=
 =?utf-8?B?ZFluNzF3MXpwbUIxSTZSME4vaStNZFUwZ0dQQlpXVitic0dHOXd0eWMyN3Vr?=
 =?utf-8?B?RUpWY1cvT3Fxck9BR3g2Mkw0OUY1SktyLzJmNzNXL1U2UFp6d3JuWllyZGVN?=
 =?utf-8?Q?/LBcfZ3WV7d20fWPB4nwaDEES?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4526c7-a3bf-4068-dafc-08dcd7f80bdb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 15:39:13.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fT03oUcDmhFxwkV7O8f7iUQ6g1hSpjqlZ0zJynib/8BbmCSOeY/GYR2fQPGVC7QKNPwkMamWsjrsw6NBcMEXKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863

On 9/18/2024 04:42, Luke D. Jones wrote:
> Implement the dgpu TGP control under the asus-armoury module using the
> fw_attributes class.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/platform/x86/asus-armoury.c        | 21 +++++++++++++++++++++
>   drivers/platform/x86/asus-armoury.h        | 18 ++++++++++++++++++
>   include/linux/platform_data/x86/asus-wmi.h |  3 +++
>   3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 6e4507be0f05..176ab5f105dd 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -51,6 +51,9 @@
>   #define NVIDIA_BOOST_MAX 25
>   #define NVIDIA_TEMP_MIN 75
>   #define NVIDIA_TEMP_MAX 87
> +#define NVIDIA_POWER_MIN 0
> +#define NVIDIA_POWER_MAX 70
> +#define NVIDIA_POWER_DEFAULT 70
>   
>   /* Tunables provided by ASUS for gaming laptops */
>   struct rog_tunables {
> @@ -77,6 +80,11 @@ struct rog_tunables {
>   	u32 nv_temp_min;
>   	u32 nv_temp_max;
>   	u32 nv_temp_target;
> +
> +	u32 dgpu_tgp_default;
> +	u32 dgpu_tgp_min;
> +	u32 dgpu_tgp_max;
> +	u32 dgpu_tgp;
>   };
>   
>   static const struct class *fw_attr_class;
> @@ -467,6 +475,12 @@ ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, "nv_dynamic_boost", ASUS_WMI_DEVID_NV_D
>   ATTR_GROUP_ROG_TUNABLE(nv_temp_target, "nv_temp_target", ASUS_WMI_DEVID_NV_THERM_TARGET,
>   		       nv_temp_default, nv_boost_min, nv_temp_max, 1,
>   		       "Set the Nvidia max thermal limit");
> +ATTR_GROUP_ROG_TUNABLE(dgpu_tgp, "dgpu_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP, dgpu_tgp_default,
> +		       dgpu_tgp_min, dgpu_tgp_max, 1,
> +		       "Set the additional TGP on top of the base TGP");
> +
> +ATTR_GROUP_INT_VALUE_ONLY_RO(dgpu_base_tgp, "dgpu_base_tgp", ASUS_WMI_DEVID_DGPU_BASE_TGP,
> +			     "Read the base TGP value");
>   
>   ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>   		       "Show the current mode of charging");
> @@ -495,6 +509,8 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>   	{ &ppt_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
>   	{ &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
>   	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
> +	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
> +	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
>   
>   	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>   	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> @@ -659,6 +675,11 @@ static void init_rog_tunables(struct rog_tunables *rog)
>   	rog->nv_temp_max = NVIDIA_TEMP_MIN;
>   	rog->nv_temp_max = NVIDIA_TEMP_MAX;
>   	rog->nv_temp_target = NVIDIA_TEMP_MIN;
> +
> +	rog->dgpu_tgp_default = NVIDIA_POWER_DEFAULT;
> +	rog->dgpu_tgp_min = NVIDIA_POWER_MIN;
> +	rog->dgpu_tgp_max = NVIDIA_POWER_MAX;
> +	rog->dgpu_tgp = NVIDIA_POWER_MAX;
>   }
>   
>   static int __init asus_fw_init(void)
> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
> index 8bb75cf88305..95f4b6d8ab6b 100644
> --- a/drivers/platform/x86/asus-armoury.h
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -89,6 +89,20 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
>   	static struct kobj_attribute attr_##_attrname##_##_prop =             \
>   		__ASUS_ATTR_RO(_attrname, _prop)
>   
> +/* Requires current_value_show */
> +#define __ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)     \
> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);   \
> +	static struct kobj_attribute attr_##_attrname##_type =         \
> +		__ASUS_ATTR_RO_AS(type, int_type_show);                \
> +	static struct attribute *_attrname##_attrs[] = {               \
> +		&attr_##_attrname##_current_value.attr,                \
> +		&attr_##_attrname##_display_name.attr,                 \
> +		&attr_##_attrname##_type.attr, NULL                    \
> +	};                                                             \
> +	static const struct attribute_group _attrname##_attr_group = { \
> +		.name = _fsname, .attrs = _attrname##_attrs            \
> +	}
> +
>   /* Boolean style enumeration, base macro. Requires adding show/store */
>   #define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)     \
>   	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);    \
> @@ -105,6 +119,10 @@ static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
>   		.name = _fsname, .attrs = _attrname##_attrs             \
>   	}
>   
> +#define ATTR_GROUP_INT_VALUE_ONLY_RO(_attrname, _fsname, _wmi, _dispname) \
> +	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                           \
> +	__ATTR_GROUP_INT_VALUE_ONLY(_attrname, _fsname, _dispname)
> +
>   #define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname) \
>   	__ATTR_CURRENT_INT_RO(_attrname, _wmi);                 \
>   	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 7caf2c7ed8c9..86629e621c61 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -134,6 +134,9 @@
>   /* dgpu on/off */
>   #define ASUS_WMI_DEVID_DGPU		0x00090020
>   
> +#define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
> +#define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
> +
>   /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>   #define ASUS_WMI_DEVID_GPU_MUX		0x00090016
>   #define ASUS_WMI_DEVID_GPU_MUX_VIVO	0x00090026


