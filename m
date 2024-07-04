Return-Path: <linux-kernel+bounces-241264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D40A992792E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0DFB1F251BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08C51B11F5;
	Thu,  4 Jul 2024 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s5TNljgv"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5251AEFF7;
	Thu,  4 Jul 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104456; cv=fail; b=irrAHxOv2omf/xcffKjQRCP4ECaYua5s6MUpteS1oscFm2SJ6/v6XBXGUkViHMbR7icbYooVqcLKvHPe4OJ545zn7LZCq2EwNtzaojrzb5EgTZrtMPv91evhkurtjaEqN58FaPfD9AtwgSXMQ8DxcOTnO6HHOT/w7KQGWHDWEWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104456; c=relaxed/simple;
	bh=PZ1VaqxHTIObRvEC3mwMfbnUsPco2V1ASP6y5/rXHEQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/O6zFqSJ7iA13khJ+jnseHepD8tEcG588fbuk+sDCXLyUhQjWvggTD+L8UbJEBDYtX5pQ579K0PaOHOXtwT4HVPmxhX7tuDNLZ7nGtCJ0FJ7GNM5OmEZ3WRfZd/WR1AtC6X0ioIyMFjjva4lIFnHi0UYriWfLEmpHY3Y+DFcX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s5TNljgv; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV1R4DsBqgH8LUWtT0WBS/c+se6chQka5smg8XDRGbsxY2v0XJjAj9g2p41QN89etgd6IHiTdZV5/szn53959At4j6fZm1wENEQPCQl4wS36BUeKAof7li/YqW0DyrT7Il3uiT/CpZyV27P5Wm0+R51ALIL8gYHejdAUhPliv5ijnlQM5qYANxtp0BvQPXjOcp/cYaA46Kw4uaZBNi0r0Hi5HcJJdkMVO0ApFqELftJGulyI8mJwvhMy0+MZXEmikJaAbnzOGB24JnO009wLN53HEypExVCxW4Dk1Ps/m2pb5HJU8+tXiPKb0EMhNv3RSDcCN+J1VKggwS3OjEYk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QcI45qMc8gXgfX3Lb7Wo31TBq/uuFM5J6uidlIvSLk=;
 b=OAvJUdKnOhPJ3B179RA308iniWvLLOVV+FBkIELz/4gjApC1R9r5Ek3wbJ3f9xLadZJFzwHhskgzZLAo98DpaOiZw/avcJNbBXkGlpwpDHtLF62VNID0Jd06eFv8iyZpgsqm8zZ5xtlsfVjKZvMH8Nj+j4t+IIfcii40vswChyibPWDrBx/PHv9WpAb8PISWDReJbcKunvsdgn+rHdUjGCvvTnNz/qw6Rz8CMCq4d+OeYUfEJpr/SD1dlC6504Rtv2ZADctso9zupk1TQoyY7Fr2AQ27WTYGtffNHUPBTbj4jnmPXWjz+n7XtHNF1t5WfpN5DzCyzeAd32FBGnDXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QcI45qMc8gXgfX3Lb7Wo31TBq/uuFM5J6uidlIvSLk=;
 b=s5TNljgvCdzHykKrLXps7/AQ6UTjsHq/G1ldsFENAhVMBC60EER5Sy03CbH7tehJSnkVPH1CSgWyYAa8S2FAXNPHFP7gx4ryMXOCFT59LAZYRzHmE9QtOBD8UYKmOdHRQ8wBgM4iV6eVktYSZVOF9p3Vh6RMxvpazOUl6P3v9t8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 14:47:30 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 14:47:30 +0000
Subject: Re: [PATCH 0/6] misc: add amd side-band functionality
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
 <2024070416-cosponsor-barrack-6125@gregkh>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Message-ID: <9b108208-cb52-68d8-8a16-8a33c3824d74@amd.com>
Date: Thu, 4 Jul 2024 20:17:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2024070416-cosponsor-barrack-6125@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN2PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::34) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2d6a21-4d4c-437a-0eb1-08dc9c383b08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlNSTno5dHZYeXBmMFpSUUN3L2RrMmp0cklWNmRvSlhJNC9TM25YZXVsLzZ2?=
 =?utf-8?B?ZWYxcmtPcWoyT004d3YrOXdMSnpzNTc1aDZVSDBtOGVpd3plaElLUTZnMTVa?=
 =?utf-8?B?UzF5NnFJNmQ2UW9RZ25WM3g4MmV2U2tjNkRtZTJlM1RqZU1XWVlYNlBQY1Jw?=
 =?utf-8?B?MzMzV0dKNVNLb0JtblZkTkczSWJTUlNGeXZsMFVvVkk3RmRRK2NHR2lJUWUz?=
 =?utf-8?B?dmtxc1BVNmQyTGxBcit5ZHIyaTl3Q0lPMkZtZ1VueklBQWVsUWZ2M29SM2Jy?=
 =?utf-8?B?bFVpUkRYcm1BTE9EWUFQajdUYkUra1ZFVC9acVdIa1dTMVo3c3NxbjJNNVNj?=
 =?utf-8?B?MXFwOGUrSTFlUmp0RGtMTnRJcFVidGxSd251cTRPTFNkSEQ0RzYvK1JUcDNQ?=
 =?utf-8?B?Y2ZDZU1jOXJRRGRwY2RGZkR5Mk9paTdIU3o4RHNmWGhzYUkwUGM1UUw5alJp?=
 =?utf-8?B?TFlmblF5eUtBSWt4YW5BTSs5V2dEdEJLTVpnTU1wbkpxRTBHNEgwRXk1YTl2?=
 =?utf-8?B?MGoxbTVqOHZyWUtmWDhXNUo3M0Z0YTlZdC9UNlhSMkhyM1h1R1pPai9UcnBB?=
 =?utf-8?B?TGEwRmVRZEEvbUNSSXdnM21FSnJ1TmFhTE9JenE2anJrdkxJa0ZIL2lWN1FC?=
 =?utf-8?B?NkxvUlU5MHB2ZzNVV0JwTDFNeS84MjJKb0M2WmsxU1FMTkxVd3I4eks5UUhZ?=
 =?utf-8?B?VkQ5c0pYNmhTbVBxR1R0ejNrM2k2anZKOXRVVUtIZDNNdXgrelFsWVBmM0o1?=
 =?utf-8?B?aHdBK2RWLzlLOWNkdmx2Mmx3Z3hQRW0rSGZhdnpFaWlwdGQ0NUZPckxIOUlG?=
 =?utf-8?B?bW0wOTdCK2hRWTBwUkdtUUUraHMxSGg2Z1hqNWh5UW1XQTdSUXBsR1k0dWJX?=
 =?utf-8?B?TklSZWRnZzBONUVRTmpKL3NxV3pNaktCdHJhSTYyVC9tRkZQNnB4Q2JMUzBC?=
 =?utf-8?B?eHEzTDI5L21BUG9rc29XcGtZelJTSnBQTUdyd2pjekVVeDlTeG90OXBDM0xi?=
 =?utf-8?B?REZ4UGYvVW1qcCt6NDlNL1ozNjJ4UTEzQk5ONCtaUCtHVEpHQjVXTTZZMzFi?=
 =?utf-8?B?OHJ1bDJkODlUZlJ5Vk8weWFVKzJtVWZaTjR5eVAxbEtUVHB0bVpDUkFvalRU?=
 =?utf-8?B?VG9nRG8yTFpVOEdDMWg2cDNaa1ZDYzY4VzdGNFRvdkU1aWNkcDdNQk8zTFJJ?=
 =?utf-8?B?MHVNWTAzK2Zmd2FBdjR4STRzOFhLYkNVRWdJRkpNNmhieUVsVzJVdU9ZWklm?=
 =?utf-8?B?akFNYU9uZytFcURsQWRVYUJzdFNZR0NEa3YyeXVDWGkzMkxMdWdDaDNZcG01?=
 =?utf-8?B?Sk9lT0k2RWFPWElPUmM0S0kwcCt3bUlpRkxWMjRXRWlwYUJEaDFzSFlzZk5S?=
 =?utf-8?B?SFY5amRKMUpVRDl5VGJYNkJKckpSR0Y4TlJBbkh5K1AvR0NCZ3ZPNnRDZHhW?=
 =?utf-8?B?R3cvajQ4bUdYL3pYbHJ0NXVleTVZODA2L2FpT1g4WG1MK0dPZ050ejhxMFM3?=
 =?utf-8?B?cDJyMGZYV21IMForeDJZdXFITFlldU5weFI4TnJ2c3ArczdIUUhiZzZmdmZt?=
 =?utf-8?B?RWNlSHJDZjE2M3c2S1BNdHlGVmR4OXVhZDFmb05VcEUrUjg0bVEzVlRrM28z?=
 =?utf-8?B?N2dNVnl5R3BVQmZVTHllc0UwNGFqN0UvYzFGTUF1OGdWTWZCNDlrTWZjU0oz?=
 =?utf-8?B?S3BYSFBiZjJRcmpvZk5ONmc2SmJkOE9HS3BOeVpSWnBWaFRBVjNoUUE4L3Rw?=
 =?utf-8?Q?2DIZymbQo/IJOPSy95mu+N5OTLj7dAWaGdOS5rn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zzh1bzJxM3c3TkM3M3Q2ZS81TjVSejMrK0ozdkdWTW53VDRoMktUblM3TTE2?=
 =?utf-8?B?L0tyWVduRXJ1dXZhYWRLS2Z3OVB1UU9XOElYY0dBQ1lHK2F3b01iRGZScHZk?=
 =?utf-8?B?MTNHbmh0aldYems1R2ZURU93elUzVFQ4a1gzcE52aXRoQ1RqNHhYd3BSd0dO?=
 =?utf-8?B?VVhNSk00Y3RHTDJsQ3JWYXhoa0hWSkR2aCtUSUkrR2VLalJRaks4VEU0Vndm?=
 =?utf-8?B?ODJ0YzFHdjV6U3VGZUFINEQ3OEtEWDdzSGs4TkxXenZOVXJkdlV4V1hDYzlD?=
 =?utf-8?B?bnFJZDdxU2xGejBEb1JaY0FQYU95OW41RDRFanI4enVDYzgxcHk4aEZ0blZq?=
 =?utf-8?B?Ukk3VU5TdVVVK29IRWd2YjZtWnRCUWpHRzRtaUJSN2Q3QVlBSC9rZDB3a2Rm?=
 =?utf-8?B?QUJrdjdmR1g2RTM1cytWdldyano5aFREMnBsVGxCQTVPRnhZUlY5RVA4TnpV?=
 =?utf-8?B?bzlDU1FPMHVLZkgyMEM2emN3bXR4ZEpRZGoyVkhVMHVYRnl2UnFWYlJOeU9z?=
 =?utf-8?B?ZEhNUjZYRmQvSU50SVBOTFJDMmxvYkJZSWQ1Y2Izb3JLTDFmb2JrSXhleCt3?=
 =?utf-8?B?S242NXJhQWt4V0JiVURYcjMwcDR0T3FiYndCWURkWmYyZUtwZ3UrQTVGTDg0?=
 =?utf-8?B?N05iOXZTSkhzeHRMUTNxN1dWSnQwYU55YXJYVVF2cnhSRm9DZ2w0Z1pRSUpt?=
 =?utf-8?B?UzFMNUZvdkdBN0hObW5OdFNKTW9iYzVIdkJiUUtXSzlHYThOajI5YnZVUkNu?=
 =?utf-8?B?dFZiNlJTSmczVmJubXZIdHJPanYvKzlyMUpXbnA3YXhiYkt2NmltUDduYkY3?=
 =?utf-8?B?SkM2cVFZVzNkc3JFcjJWVzZTR1NWYnhLNXVlQ1NRemNzRGJuMWFlMTdFYzhB?=
 =?utf-8?B?c0hPc0hLL3NhVjV6Nk1keHlUSER0Y2FQOFhhL2Nad2ptYUpzdGhoUjVYazhh?=
 =?utf-8?B?VFJkVmt3VkpFc2V5aVFzQXpXUU5ScnRLSXFSVVZnT2VsY1lRcTRhdUdXN0NJ?=
 =?utf-8?B?blliR1ZZdThrMzRTY1J1TFpUdlJyOGpBSVluNHY3QUxKUENJN2VUc2kwMUc1?=
 =?utf-8?B?TXJRd1hiK3R6TWtYUzZyYVoyZXJwcURUSllxS1oyeGJHcVFnZTA4b0hQaTZj?=
 =?utf-8?B?WXpaeVhEUGR3YVp3ZFRVcWFoc3A2NTFpeXB5U0pKNjhGOG5VV2lxSmMwUURn?=
 =?utf-8?B?aTh0bUt2RkRQK3JqZEJiT1Z4RTdIZ2RxNkcyN3NXYXVWY2VPNG9jN29OSm9J?=
 =?utf-8?B?cTFkTjFyWVlOaXlYSlBHZUV5QWlDYjJFelU3Vno1am92U0kvdFBpL3BoelVs?=
 =?utf-8?B?aFpYejk4ZHo4UENxN3FRbUw4NnFMMFE4bGNheWtQc1J4UFR1WGZVTG9pazFM?=
 =?utf-8?B?MlMrQytNQ3NyaVRPelZPSGlzdWgyV0VKUStsRnRRcEdUV2lnUUVWRFRrTWhs?=
 =?utf-8?B?NXh0YjFBN0ZnYVdUalJZb0FWOEFsZGk2RU5zUURaN1JSYWMwa0l1dUo3L2tS?=
 =?utf-8?B?UmhZK2xMVjVzbEQ2ZGVIVTIrV000U0xPa3pNNk9Ic0xieWRYbzBNUnBWZWQ5?=
 =?utf-8?B?L2dTUllzTnZmdytOMzNtci94Tk1QMUd4dHN0NnowZ1QvS2k0SUJnL2dCSk5h?=
 =?utf-8?B?anc5T1JvT3dXeTNLSVZDRGJIc1ZBc0lIVW1BSHAvWFJSNHRJdVJuRVV0UDk0?=
 =?utf-8?B?K045NGcvTUZNNWJsYVYvWFE2OFhYa1dBVmFKZVpYMm0yMnYzd3VoVHg5MUZx?=
 =?utf-8?B?S1dGR3I2SnhlR2xoLzBldks1WitjVXQwQ2VCWlprdzBRS1RESytMY1l0TzRP?=
 =?utf-8?B?ekZkM1J3OW9FMkJwZUh2SHlCSWtvbjR6TnBCdlZPYzVuZ2Q3bTBqQzJVeUNh?=
 =?utf-8?B?aVdUUC9rRVlaYVRRZzc2dHpmajNJa2ZGdlYxbFpLaFhQb2F1aXVxbTM0NkxH?=
 =?utf-8?B?N0YydllkUFdYZENqQjVmOTEzVnRMMFlrczNHL1JQZmhFMzFLTHNJY1hleDVK?=
 =?utf-8?B?SlZlYjJNMzJEelQxdVFsbENadmUrNmZZY2h3bzdVVnVTVzhiQU9ScmFoTmZY?=
 =?utf-8?B?SDRwcEdicGtndEtIbHFIdkZMRm1ZTVcrZ0VGMzVJUVI3TTR1cUpONXk3M0ZS?=
 =?utf-8?Q?JzTy18z7IA2c7ye4oxPwVVUXz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2d6a21-4d4c-437a-0eb1-08dc9c383b08
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:47:30.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEwoqjJn2RJHUo6rm9dCITkkgcIeTHnc1hGVQpKhzchwuf6KnbanH1UZ1TS+DxcOVyaGLxCSb+5moQlw8sRVLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373


On 7/4/2024 5:18 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, Jul 04, 2024 at 11:16:18AM +0000, Akshay Gupta wrote:
>> AMD's APML interface provides system management functionality accessed by
>> the BMC. Sbrmi driver under hwmon subsystem, which is probed as an i2c
>> driver and reports power using APML specified protocol.
> What is "APML"?  What is "BMC"?
My bad, I will provide expansion for the acronyms in the first usage.
>
>> However, APML interface defines few other protocols to support
>> full system management functionality out-of-band.
> What is out-of-band here?

Out-of-band management is term used for Baseboard Management Controller 
(BMC) talking to

system management unit(IP in the processor, AMD's documentation called 
this link as side band interface.

We are using the terms out-of-band and side band interface as per context.

>
>> This patchset is an attempt to add all APML core functionality in one place
>> and provide hwmon and user interface
>> 1. Move the i2c client probe and sbrmi core functionality from drivers/hwmon
>>     to drivers/misc/
>> 2. Add a platform device, which probes the hwmon/sbrmi and continues to
>>     report power using the symbol exported by the misc/sbrmi-core.
> Are you sure this is a platform device?  It better not be a pci one...
It is not a pci device, will remove the platform device and register 
hwmon device in misc.
>
>> 3. Convert i2c to regmap which provides multiple benefits
>>     over direct smbus APIs.
> What are those?
We are planning to add i2c/i3c support and 1byte/2 byte register addressing.
>
>> 4. Register a misc device which provides
>>      a. An ioctl interface through node /dev/sbrmiX
> Why?
>
>>      b. Open-sourced and widely used https://github.com/amd/esmi_oob_library
>>         will continue to provide user-space programmable API.
> Will this use the new ioctl api?  If it's not present, what will it use
> instead?

This is an attempt to upstream the out of tree kernel module(which 
defines this ioctl), open sourced at:

https://github.com/amd/apml_modules/ and continue to support 
https://github.com/amd/esmi_oob_library

which depends only on this ioctl.

Thanks,

Akshay

> thanks,
>
> greg k-h

