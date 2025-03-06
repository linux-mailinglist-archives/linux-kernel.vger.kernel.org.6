Return-Path: <linux-kernel+bounces-548156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7946AA540EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E523A8CBE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A499191F91;
	Thu,  6 Mar 2025 02:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XBirJK3P"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1671750
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741229998; cv=fail; b=GMk33G+SKGgZA7zHKMbL7jkrhgkP9/9h9T7Wwj38JzZcIwMVic1DpLC3RnqU9LZGRHfTjgFCgK6x2MUPMtVjF7gJXhA4RluujXce+ua0dwN3MlvRYMKfm0oShm4E+EWEmvWIelhV4feo8mr6jzRchPjl4mAgYGqI6kgNzGFoMOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741229998; c=relaxed/simple;
	bh=qWJr0DMGzZQJZtSblXCgme5OSaJAAgTVkfKEmMsHXgA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDAhFDBXM0n0FtYfjpYq5E+vyJczxJ16//7g4TF1zRyS7WCvYh3YVR2KSDT+wP86Bh18rk4ouIQQK41lROJqhgkX70LKwyj/Uv82/mygTY2jVNWhvwLmFkM8gJMgcna//rpPXHrc+6u9u+n2JM6gwGHmxoNQ1OJT/VXxGiQVclU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XBirJK3P; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5eD1O8GYZcpTxJV5lWclXRQ8YE9FCbMpw3cd2o25GBcxiBAInO/gpofE4Ka+BlQwOEQpC07UTIlyP0i+dJMdm460ckhMyrpPWlTHqmtWzeCO6o6cM15WaCJyhCBHAtu7fwBS4HSGXPOermQfqg3S/Zn7Fnvd4JNRdbwu2L4G6A5s4+Oj2avOrQJProL7llf1GzGygZ1apjfv0FZQe6gtcTOJry/NkkJHfmAbpPI9lLbifgiY7B6Fnx9L4tDmfE5tYdLisu6t339iJmgscrs+m8IIoGeNFEGNqWA6FfleoH6eDsVSfcI4XY5Y2y74oFKpY654ZHp2xe3g4RXr/byfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYr4HvnrrsqKdrZ4wDogVF5l/RG14Je6HNXERQhLiwM=;
 b=sbwD5pFLn2xG2airNYzUu2eHPxZyBP7A3SEkQyt54XG7JZ26069jv0ebOu/5yXSvu9gCXYu3HwPwKFz9an30fjSdFvwfQwW+a+s6H48Y8v7zY+HKcThHkDa0kzLtfOes81JoqQHLhNh6Hh+ssn2ImPZMvhTwTHITo7ffaTBDrKDceCYJ9P24WbSAaX2L8sTzQrpbLysrdUoeUhbUrkYVgBE8JeydLHjRfSOtyJtH2Dvi/LdVnH6W7Y7HZQCNaD0UmrBlSe3vlyw4/91HMzOG3Yn+iHtskMBdqroXTgeWJObgN5SqPII5xH5DM6sLzxGX2NhXe7qVoeoQTdiPydsD4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYr4HvnrrsqKdrZ4wDogVF5l/RG14Je6HNXERQhLiwM=;
 b=XBirJK3PwC+WeBWWPaQDuMhJqI7XtBscyY98N2HrAaGoalbT6VGU1ApobPREE19t2g1GVsq8caJefOv0xbhfmGua9n2HxHWHI4ARtIHBODBQrmExEBSW+4BIKjYstVMgaDNJoY6jGgm74Y+I5jhF6BtH9z0d8QCMSZTfHbC/iDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 02:59:45 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::1fc8:2c4c:ea30:a42f%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 02:59:45 +0000
Message-ID: <faadd6ad-3b85-4ad3-8d17-acb5e0991a18@amd.com>
Date: Thu, 6 Mar 2025 08:29:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ktest: Fix Test Failures Due to Missing LOG_FILE
 Directories
To: Steven Rostedt <rostedt@goodmis.org>, Ayush Jain <Ayush.jain3@amd.com>
Cc: warthog9@eaglescrag.net, linux-kernel@vger.kernel.org,
 srikanth.aithal@amd.com, kalpana.shetty@amd.com
References: <20250305041913.1720599-1-Ayush.jain3@amd.com>
 <20250305190159.7c590242@gandalf.local.home>
Content-Language: en-US
From: "Jain, Ayush" <ayushjai@amd.com>
In-Reply-To: <20250305190159.7c590242@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::6) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba28e32-edc6-437a-6034-08dd5c5af2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW85dC9QWU9zL2NRalpRaHRyeldaNDFKSDBjbk03M0Q3Z2xZQmZvam0rVjdi?=
 =?utf-8?B?VUk1NG9Sbmdsb2ZscHl0aXBGaytKZVBTd1ltQi9rR3hzaUJ6N254SWJhcXJ6?=
 =?utf-8?B?WVVYRkpEREFoWlhYMy8vNUdkMFlKb09MSkRXVThZWUhwZ05BRGhrbGRubTB3?=
 =?utf-8?B?andnWGRNSnEzcHhSWDVYeU9wVzFrbGt1ZmlDL2t0UFdET05pTWtjbTdSR2Ny?=
 =?utf-8?B?TC9GL09hcWZ1UWJDWkJQdmZ5T094WC9KbXZMTm5sQm8xVXF3UXZEaFRPMDg5?=
 =?utf-8?B?UHY3dzdQS1dkOU9TVjNlWGlzQjNETTUwMjFVazY1L3Y3c0ZKaWJrdTFoQXBV?=
 =?utf-8?B?TmR3U3orLzFuOXMvdFRZM0xpSStNNXZTM0xWRFNLbG95dEM1TThTdFgveXhr?=
 =?utf-8?B?Y1ZaeEFwSThhTGJIZGdiTHRoUS9aSGpkTDd4S29WOTk3ZEI5VmhNZ3JMa01Y?=
 =?utf-8?B?bDQvQ0lFY2dobGszdy9XRnJjL3BIT2ZwMC9GSzZ5L25vb0J3Yy96dkZ3OS9R?=
 =?utf-8?B?Z1FXNmtqRGRhWGxEajNUTXRFQ2sxdCtvSnkyODN3U0ZubEszdDBsWkp0WmlB?=
 =?utf-8?B?NFQzK2w5Tno2UGhMR3FGa0t5ZHFHSHhTbjJQN0hLanJDRkhFMFJ2UWoxZDhI?=
 =?utf-8?B?b1I0SENLeUcyZkh5QlFWenNNV2poMVpuTklOaEFud2pQYXNSa2x3QTVScUJT?=
 =?utf-8?B?cThJN2dPVGw5dVJXTnpRZDlWZVJiWC82bmwyTm1nUmJUZzBJWWt3d3I0RWpS?=
 =?utf-8?B?eW9JVDhPVUNia0p6UmtSS1dhSDlVUVRIZCtkREdIMjBLV0V2U3JWeVhvZGdX?=
 =?utf-8?B?emw5YXRQVGlaa0NhTG9Vc1dPUnZRL01jQzAyM3RiQm9lZkU4QjExSG8xbHpJ?=
 =?utf-8?B?emFyeWRBellFV2k0ekZHR3ZqTStvS1g0eW0rZEp4OVNkYTZZM3RUeEpmcTVu?=
 =?utf-8?B?S0NuUkJISmROZG53eEErZk94NkVZbnlmMkJPZmVMZW50NlVUTURGTXlqaEVS?=
 =?utf-8?B?anVVR2pKV21uQkFobGsyN3o2RlJvUm5LdGV2eTNkME8rKzZYbTVuWFJCSHlv?=
 =?utf-8?B?eXliajl4VVNib1lkbHlpMkR0cmdyZkNvN21tNk5FQlB0MFk1T05nMFdBVDBl?=
 =?utf-8?B?S0JhdkJRQU9RNFV5UkhXeHoyUngvTnBiOGhhdUV4blg3OE1FekxUckZpOTZN?=
 =?utf-8?B?cURBZ2VNNVlob252U1FtamZHRTJpZ21SU0Y4eXhGRCtmbTE2Qnp2dFE0bWFw?=
 =?utf-8?B?K1Z3SXBWUkYxUEF4WFdDUnY1WFFjckpRZWpneXhLUGJ0Unl5ZWhwUWhxZ2dL?=
 =?utf-8?B?NktYUmlSR0dkZWZpODlUd3JVZkRhSzRSZDBHNE9BdDAvMkI4aUpQSUQyekxu?=
 =?utf-8?B?aG52V0ZNKzlRUFVUd3c0SGhNTFgxZFBNdnNZSDBxRUkzeHZ3RTQ3QlRqUWJR?=
 =?utf-8?B?NHNxcFZLYVAwYkVjbElrL2dGMnJVUmRaN2hNb1c2RW9zN0I0QlFRaGRaVzJU?=
 =?utf-8?B?RVBOeCtjemFlVWl1d0lDYVpsNWRnZDVyUU9yM1VIQmNWSnppWmlpZ3JiVzRR?=
 =?utf-8?B?VzZOT2c0SWp0Q1ZvejA4bndPTysrR3BnSStGT3dXaUJDbUgyZXdqMkVCUTFW?=
 =?utf-8?B?SkI3eUhybXFDcndER1RHanRyUGR6LzFjcVV6d2ZZWjEwSnJwY2J0azF5RmVX?=
 =?utf-8?B?SFdtbmhMMXh3NkZ2Y3JQWDQ1cDRubGsvREJWQzdXNXBhbHVqYlJrL0VhRmdI?=
 =?utf-8?B?MGZSTHJMeWo4WWx3M3A0TWJZbWhPd09ZcWhJQ3cwelJ4cGx0NUttdnJiWUhH?=
 =?utf-8?B?dE43T2dWYldRUnhJMEp0T1pHSnM4UnhCdnZtaEozbXRoeTNlQ21hdXMzdDli?=
 =?utf-8?Q?Hgno1ck/FJIR4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3FTMHVmM1ZEWjZQUFcrQ1ZENllFMG9PL3N5R0p0ZXhKVnZhTnZaZmxyckY0?=
 =?utf-8?B?NnFTenJiZ3Y0YU1tdXk1djNSSFJMN0V2Y1htU2lYOFN5c1RGTmFiZkQvUngx?=
 =?utf-8?B?T2dOLzBaU3AvdUZZRnczcWcwUlZVZ2VoUUZNTmtYd094UzJXWmdDeDFOaFVn?=
 =?utf-8?B?aEY1UVkzZVVFSU9WdytGV21waVdFZ0xDMlpONS9kVXNhKy9pMTEyWjRlcURo?=
 =?utf-8?B?MHptS3BQd1dHZVUyWm1FVE41VnEvWVZYb2pYMlI4bFJCa1BPekd6SDQwR0Vs?=
 =?utf-8?B?STdVTDRMQXFUenU3dEU2dGtTQlNGV3VSSThWck9pNUlRSkZ4Sm1zeXFoY0F2?=
 =?utf-8?B?OHFKL1ZoV01GK1hsalNPdnEwem5VV2h0US81dGdPOTZsT0ZGQlhqeDRrbmFa?=
 =?utf-8?B?Ulo3clpWT3U4c1dZNU1oL0tpNHFLTE90d1ZSZFdJL1oyZmVzbjNaYm1JTkVP?=
 =?utf-8?B?SDB3bUFURGRkMmFuS3RjNEFTZHN2V2gxQTlWOFNDVDJnZlZYTTJ5M0ozekZ0?=
 =?utf-8?B?SnlaeDBEVUJpVHBmYldiZ2pxYVh5Z29uZ0gwMVQxemxHNUtmUEFUNG9HQW1J?=
 =?utf-8?B?bUs0cjQ3ZmxNUU5QWHAzM2YwcnRUUmhtVkpodldPVnBJYjBGdVRhMHYzeXdZ?=
 =?utf-8?B?emw1R3JHd3pKV3NIZkpLVTZIQVcrT0J0bzdTSFdIWmQyM3pLNXdYTDk5V2ZS?=
 =?utf-8?B?MndZUVZlendxY24xVjlOZ00vOWNPWDl4RVRoZFNCemVzMklGaE5SRFh5Y3Mw?=
 =?utf-8?B?OU1MSmhaR2ptamhUTzhabzYxdUdwUmI1ZWUwMWw2RTFCL2dybnQ0TlJ3VWNr?=
 =?utf-8?B?ZWZZRmgwS0RSQkcvSHhYRlVvZFIzVEZtL1lZSUxvZ21iMjZiRy9rU2EzeXRz?=
 =?utf-8?B?eUM1ME9zcGpRd05NUVNuaDhXM092SUZUQzNteTBDZmhiaGNmY3h1ZUljTGxx?=
 =?utf-8?B?VktSODJGWFJhcEdGSWhYb1F4WUZKS0pEWnVzWEFPSkFVK1dPSFJQTmZOYkFO?=
 =?utf-8?B?WHpzQUoyejhrM1k5OGE3anRQQnNHTW44RjhCTyt5UUR5ajhxUWoxNjZ3WVhy?=
 =?utf-8?B?bHp0MGFESlc5MkxvcGF2MlcxMStoS3IwenNXZHdhcTF6bndZRFJydjN5RUdo?=
 =?utf-8?B?VVl5ZFZHb3c3MWlXbXZ5bGZFWU1rcEhpMmZWbVoxTEVhTGRPK3UvY3phS2Vz?=
 =?utf-8?B?cEU3OGxrZnIxKzc5RjMxaGtYSnpocGppdk1KUEJ2RlUwV1hCNW5Ob0hLdmhr?=
 =?utf-8?B?L1JwMWh2SlNsZkw5WklpVTJ0NkdoRDRCVzlBcyt0cVBlbGdyVDNSTlpzbk9W?=
 =?utf-8?B?ZjFHcmREK0tpV0UwUDFQTHh3eXhKVm9UVU5LMWtQSXZtcmJFZFZWc01NNDR2?=
 =?utf-8?B?emhQbHF2Uk9HZ3l0blNMT3BtWVQ0UTZqcWRyUGtEdlFBOVVucG9mV2s4ejFL?=
 =?utf-8?B?NWhYN203R1cyMWZPZ0VQRzFZeGY3Y0NFYUZSMGZXK05GU29MVXhjbUNNUzJL?=
 =?utf-8?B?QVd4ZHp3bjR2MHdhZlgrMkp2NmhHazZqVXdVRHNBdVBnOVhOYjJSbkMwVjk0?=
 =?utf-8?B?V3B1a25KWjNYUnlkM0dVVldrM2xBU3k2Z3FRdnE4YWlCYkE4RzlTNElsWWNI?=
 =?utf-8?B?L3JzNGNtemJnRUJsYzRabEpZYWFydUtKSlNrZkQxbXExQk5YMU8wai8zeWpl?=
 =?utf-8?B?L0MvVldicHVWR1kvUDMzdUlDcDJVMldpZkIxRnltMGNmWGtpb25iSFNUaGh1?=
 =?utf-8?B?SzhKazJxS0c5ek1yYUJrYmJBRjVJSjROWFFPa2J1T3VBa25rZGltWG5xOFIw?=
 =?utf-8?B?NkdUdStGbVYxSGVjdVc1V2xiMzg1dk03ZlJ3eU5UOU5GTUVpaWhuWHdIc21N?=
 =?utf-8?B?bjF0YnlKYXVFdks5Q1NkNEJ5anZ6YitrTkJiUG9VeGpwOXA2WHh4d2dIQzht?=
 =?utf-8?B?cGMvaHlNVnorVEpPWDVCb2FMZTlTeFN3dlNDc0VJZUtFcVR3V1FnZTQ2UGRU?=
 =?utf-8?B?WEI4cGRuYVlWK2ZDODB3ZldnUk1OSWlEblRXK1BxdXdEeHdpZWN2akFzajVF?=
 =?utf-8?B?aTVRcjN2M0hnVk1JMTVzblVFS0V0UnExOVkzRWl3bFlaQVhiYllKSVp4aFBL?=
 =?utf-8?Q?udqZ/yMUhr/T1+YXwMfjyWAJL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba28e32-edc6-437a-6034-08dd5c5af2fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 02:59:45.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEGOAKXWFenrlQN7xa4UcB41WCzntElQ8HFRUx1ejMvuwu2+OmkJ2ER81mcP2yrwd/AcgSAdNhtf49d7LrtM/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127

Hello steven,

On 3/6/2025 5:31 AM, Steven Rostedt wrote:
> On Wed, 5 Mar 2025 04:19:13 +0000
> Ayush Jain <Ayush.jain3@amd.com> wrote:
>
>> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
>> index 8c8da966c641..13b97e6b8459 100755
>> --- a/tools/testing/ktest/ktest.pl
>> +++ b/tools/testing/ktest/ktest.pl
>> @@ -4303,6 +4303,14 @@ if (defined($opt{"LOG_FILE"})) {
>>      if ($opt{"CLEAR_LOG"}) {
>>  	unlink $opt{"LOG_FILE"};
>>      }
>> +
>> +	if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
>> +	my $dir = $1;
>> +	if (! -d $dir) {
>> +	mkpath($dir) or die "Failed to create directories '$dir': $!";
>> +	print "\nThe log directory $dir did not exist, so it was created.\n";
>> +	}
>> +	}
> Hmm, somehow the indentation is messed up here. Should be:

Sure, will update it in next version

> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index 8c8da966c641..13b97e6b8459 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -4303,6 +4303,14 @@ if (defined($opt{"LOG_FILE"})) {
>      if ($opt{"CLEAR_LOG"}) {
>  	unlink $opt{"LOG_FILE"};
>      }
> +
> +    if (! -e $opt{"LOG_FILE"} && $opt{"LOG_FILE"} =~ m,^(.*/),) {
> +	my $dir = $1;
> +	if (! -d $dir) {
> +	    mkpath($dir) or die "Failed to create directories '$dir': $!";
> +	    print "\nThe log directory $dir did not exist, so it was created.\n";
> +	}
> +    }
>
> -- Steve

Regards,

Ayush Jain


