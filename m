Return-Path: <linux-kernel+bounces-370921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D79A33C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF151F239EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAAD170A0C;
	Fri, 18 Oct 2024 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OAo/DWze"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498EE165F1E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225598; cv=fail; b=E5XzohfuKsqX1BwD1KX5DVLJayYbzig2QgKIBIjOBXqaF5+htWr3wP/0ODVkdUSQwsGTP4cK7o8hddGPqwWPfRyztD1J4lplfLohqIi3YR3j5ulbzjyR+9ZaTUaeqhAYcGBCejmwEKMaTixJ4POK1NQZGXZ+TKqWxEQS15boiUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225598; c=relaxed/simple;
	bh=ULrODpLeeOq9WwJDu0D8GMZxVZWbzUQIp2o8Mwtvx8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LqtT7jBbNZaZ5z+SzsOnFLJa0ZGrrPUV7fZXD1XOhqcKCibSc3DczCpgM4evIVNExzdkMvhOB+6rBpVIx7ef/stmzSjO+w3ZSO/EPlK4JhCpDct0mCZxzVRQHq1t1Ysr/haTXEfXjxKMGwhWYuWW0kH1FusmmcBSwO+GDvVX1iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OAo/DWze; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjAMQMX+zH5nGxDI9ev/M9X7bf8+O+9gS9lBPerT9e8VIxCysSQxP+dyVB/tH6P5ExKsrlar2eTfeZdmb7yA2x+gprT3VMD4AZkuFF1CQcM+RJ6b1RfJzhztQBUAB+BFrKitzJD3YD1wROZPFSt/6wmKFEMSgP8ws7DSx8SxIyrAX9gt3SC/7hfUskN/dgFoDc1aXYa7VIMSMnOSndz8CIOt5Dv8bkzrnAOv+YrbbOOOofh02WmtiGd7/W6yVo3qfP62OUKp+UqPBLfqTQ88J9+YYjHuSNpbB0FOV5bzcTgP5y4FTplnioFRllyX41FJvfa0NK31O4qbq6bglZnCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6spD1Z6FEoJBHqig7v2GxF4mFzWIMWUx+c310fiSUE=;
 b=R6QysnbmFRPFH7EElNqofmgRVx4AlH3E0mCjxarLpFoRZB6AbHSDpVb6luH7m5wPv45CVD1QHNTZNjHw1oojqDQyl0NIbd3ZVxWftAu2c+NKX4mnNwIzcVWsmjtObwa9YOuY4Waa03AVU4p9LXmVJMX+6wHWILBgM9l+KqtCLOAn6NHwX0QkSBg8lMEGzFaizX66xS4XZzi3l+ODNgfOszzjYpPzu68yvmUU6duI0uOduMwwl0mop24ZppL1n03jnoOzbrrpw4+FM4/tEdp5CsAzcTXISKXwJKEDslEL9ZWJM2FnVF4QB8lTpNQ5WG2AqgarBdPH1ztUwKRYqD5epQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6spD1Z6FEoJBHqig7v2GxF4mFzWIMWUx+c310fiSUE=;
 b=OAo/DWzekF7V++CPcekXWd7CofEagUc4CB3Q/rJ5B9BnR47E5dRQjHKUrpeEDvY/ZrEs1zjFNGgYyp/0bmym+MqrW/IOungXf81mCGubX2AMTUxSJgWUAA5xnn/GJky2t7LvIKDmXW6ZTgM01p4hvrHjNteXXyAvRQOv1GmXeT0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 04:26:34 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8069.019; Fri, 18 Oct 2024
 04:26:34 +0000
Message-ID: <de96cad3-6591-4084-b02a-e0b2c27c525b@amd.com>
Date: Fri, 18 Oct 2024 09:56:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] x86/sev: Require the RMPREAD instruction after
 Fam19h
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <a8aa2542fb1b65371ca08ce2be40a5179aec6dca.1727709735.git.thomas.lendacky@amd.com>
Content-Language: en-US
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <a8aa2542fb1b65371ca08ce2be40a5179aec6dca.1727709735.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::23) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 545763be-8fee-4ba7-51f3-08dcef2d0caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXVybGI0Vll4bVZSRFp1dkxNOXFpR2xjeHlUWjRpaHB6V2J4VnQ3R3diK01a?=
 =?utf-8?B?eS9yN0F4U2NLUzRZT1ZESTZPOFMzT3NoOEpmV2NCMUhBSlBjd2dvQ04xemJm?=
 =?utf-8?B?NldrSThaVno2M2g4UEVLY2lsa2RmN1F3L0hYZ3pZSURPTGM1TDdzS3lYRkRL?=
 =?utf-8?B?WUxydytQM2d6Mi8rTW42TDJ0c0xQSVZHK3N4amJ1S1psQ3JKS3dLZUFvWU5I?=
 =?utf-8?B?OFhReU1mYXZhdFhJWmp5cFhZeHAzWGhEanhrb2hGYlFRVXRJcXVyL2VIZjM1?=
 =?utf-8?B?QVlCMFhJbFE2cXowaFVlV3ZNeE9lNFdhS21xc2w0UWZvQ0lneUlWOFljcUhT?=
 =?utf-8?B?bU1HVWlRQ3FITWJlV3pNb3ZVbXNINjZ4dExrNnNKOFV1TjNTaU4xVEFXbmZR?=
 =?utf-8?B?cFRZSkhqS0ExbExXNnhLcjQ0RTF3OXQ2UVJqOE92aVZDWFBuRVRnVXFzZHFz?=
 =?utf-8?B?NTg2MVUwdkxUUS96MzFvWFROakh2NUlDNlkydjlYa1hrQTFqNGFrM2xhN3pW?=
 =?utf-8?B?SVEzQ2NEbnlmWXBjNW5kMkVyeDVKVVpUckNxM1pGN1BxdzBrMEMxcWhzdkRO?=
 =?utf-8?B?cHFOeXhPYzZjNm1oWHhSVnM4Q1kvZ0NhTEIxSW1zWFBBSzEzcXdIdnFQdjJy?=
 =?utf-8?B?L205YkkxeW1xUWhHbEIwMXVRMnJubXdsS00rcUFSdyt4ODhMN0VhYmtZK2dL?=
 =?utf-8?B?dUlXb2FNRDRpTU96ODBOUWJub2lIOVA3a1dvWkFKZ3l4NlFuY2daSmNWaU1I?=
 =?utf-8?B?bDU1cEtYZkVTMGVyL0dDcC93ZWNCSWpnamcyZVpHcTZGM1ZMd0RoTTZSQTFW?=
 =?utf-8?B?VUMwbEk5RFlPV0ZJTE5WdUt6WFN5TElmbkFzT1dXYlJ4aCttVWdBWUo5OFpn?=
 =?utf-8?B?K1JkeUN3Y1kvWWFFd1YyOFIxWHptOVBDbmRnUGVadnZSaDV2a0pEMzVkMFVy?=
 =?utf-8?B?b3p5YTViREtKblFxaWt2ZXIzWkRmRHNaay9QenRZS0FTcmlaMnNKUUhJL0Zu?=
 =?utf-8?B?K0daZ0RQT1M4bzZXa2RJNFZGWGZVQ25PdzZZM1JmWjdRejgwY01hWUJxSUJ1?=
 =?utf-8?B?RUorTG5wT1pVYmlWeG1LUFg3MmlraVF3c2QveTlXU0pZV29RRGNyZGxnL213?=
 =?utf-8?B?M01rVDA5OWcxZlNSbXc4YnJRU3lqUkZWdVQ4MHFzSGJGSm9mS2lKajFMb3Ez?=
 =?utf-8?B?ak4rRStRdjVIaENUQkpka2xuVHo3NVluNDBnVU5SUFZRczNDMkZDUWluUlhT?=
 =?utf-8?B?WjdmZEJTL2RXYkRyY3FVVUJ6aHRteWk5VkRZNlRIcXp4eldJTHAwN3hpNWVr?=
 =?utf-8?B?NVdPMkFvVW00UnlYVUtGNUR1cWx1eVQyb2hOc0lkQUlGOGtrWHF3WGlxZzFL?=
 =?utf-8?B?QS9mclFtNWJLeXEvR003aDB5STVvUWRBQWF1S1gwR2dYS3BXYUgxUUlSM0JL?=
 =?utf-8?B?TXo4S05pRjJpL1V0MHFucENhamFUdnRiVjM1cXRlNldVcmErRVF5a2NCcWZk?=
 =?utf-8?B?UHEyeURRQzF3ZVUyZzhaT2xPUkc1UzhhQzVFQWlyMGJUV3laTEMyYVk0ZXUy?=
 =?utf-8?B?Y1NDUXBFTXJRWTdYa3BuMGlGK1E5b3RKdzBzRlBvVlk0dURwS2lEd3BVNUxD?=
 =?utf-8?B?VlBxYmRTTTNSK2Z4elpERnB6WHY0Qno4THNlemRiUEdUeTEyRzI3Vk5IcE4r?=
 =?utf-8?B?T0xWL1plRm92MmhFaWJUWGhsZ0VNelJQMUJ0S0xzQjhSa0lZNWQrekFCK09U?=
 =?utf-8?Q?T8kfDGL5XTm9t7xCtULfh1xr+wgjNgZ9eQpb8T+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2twTDVEYUlFNU45MzRCS3lKZ3h2V2FVVWtkZk1PS2pZRU55d1BVU3RFeWV4?=
 =?utf-8?B?REhXaUdsYSsvL1prYjVTKzQrNHhIV01RL3cwRmFVRUl3RlhzdEVqUU1CTUI4?=
 =?utf-8?B?SFRUc1dLV0Q2Y056THI4TEQ2VDUzRGhaQzZBRjlNUlBKYXBvWXU4Y2gyUXo1?=
 =?utf-8?B?NE9oTG5tT3hpa01uUklQVU1hUW1hQzFqZ3NpR2VUa3ErWE9wOVkyTStiQXpF?=
 =?utf-8?B?c0pMQkVHM1BxTkNrdGZsc3JxRldNcWVld0hudDRBRDhHNDRtVWJxOHJNZDlT?=
 =?utf-8?B?UzM3MFpaTUxXcjJVL0o2OE54Q3JqUFJEOWpvR2dtdncrS0ZoK25SQStjeTRS?=
 =?utf-8?B?aEl0NE9ZSk1oOFltaktHK1UrclJ6c0t6N3FmVEsrZWMxTGIrclB5U3J5ZGxC?=
 =?utf-8?B?TUZ4bkUwd1VTYk5laHk2Nk1SWU5zd2FsZk96d2dybkFGMHNSVWErT3EyM0U0?=
 =?utf-8?B?ZDBsNjNHYnVKU0p5KzlQVWtZUjROdUpUNGRtUHNlM3podEF1SUt4WFEvL0No?=
 =?utf-8?B?cXNncGJ0eDgyU2taSXZQdXJIVlhWUUs3SzZKYVZyeVUxdG13VzM1WWI4Tzdj?=
 =?utf-8?B?KzJ5eTIwSVdoMzdIUWJWejl4M0tkTE1hVXltaXgvNTdOckNQWWhhcVd3Wm5v?=
 =?utf-8?B?ak1KMEg2S1ZvTmJETXZhUFMyVHRMR3lUYXltT3dnclNpbEJ3dUtjTGVrbGRH?=
 =?utf-8?B?VTBES252K01rdk1xVjFqWmZLeFJKS3NUd2x2Y1RwdWNXMUgzVHEvdlRnYzY5?=
 =?utf-8?B?UTZtOTJacDZEaXVBbDdidkJxSVQreXlJQ1NsYmdzR2tnU1RQRDNZRWFqcE8z?=
 =?utf-8?B?ZXMzR0RkS0lUajhUV0N2a0oxTXZjQkxSNnFNZlNudFZvWUFUeEM5U1JwUmlL?=
 =?utf-8?B?T1RzUk9seHhhODdGUklTaGppUmt5ZWVTellwc083VmxyQjVkVDJzSzNyek1E?=
 =?utf-8?B?MWVKSTZ4Z1FDVzkwTzhIZkpiYnVrTVpkNHJJNy9jdUhJWjI4U1ZPYzFkTzNR?=
 =?utf-8?B?L3lHY3NxY2FCUXJMN20xWVEwK01scktQU2paMDhQMFFGNGxxRUlWYU5EMmMx?=
 =?utf-8?B?ZmlnT1NrZ2VkTHRFbXAvNTJha3djbFAwY0hBc1NiYWlCYU1iMEZWUW5ZM1Mv?=
 =?utf-8?B?b2ExWCtxM0RNbE5RVlNwMGU1VEVldmVKYTdVTVcrbVRqUVc3MGJPdTUyRE5Q?=
 =?utf-8?B?YjV4c1pWY2VsZ0FvN0tFRE1icHMydFo2QkxNc3RIdUl2QnFIUlRZZDFHdExC?=
 =?utf-8?B?ZkxRSEsvYkZBTVFSV0pHa0thMmtUUlBqRHM4MHdaY1lSRnc3OTZOSE96S0VT?=
 =?utf-8?B?YTdVVDB0eDdWaDFJaGZXUnNjMDkrbExlSHl4a1FDU254WEd1ZmdoWXYraXBW?=
 =?utf-8?B?TDUzU2laYTNnTk9vVlAvVTJVbkxjS0Zic08xd1BIQXB4STZ4SmFjNXRyV1N1?=
 =?utf-8?B?bHlvcmt6L1BLTllZOXRWczBRQXV0UEFYMlprRTNpTHI0UTNYdERXZTVCYnlu?=
 =?utf-8?B?NjFWRTZBYXR5Q3ZJeFpTcFFYK0hmL0ZIbHF6aW9LWE1qdEZSZlRkUVlHaUZB?=
 =?utf-8?B?SUVNSmxObWs3TVF5NSs4SFQ1VFRJVHA1cHZJTkVGVDdlSVo4OGluSnNaTFND?=
 =?utf-8?B?dWMybHIxRWdGa0x5ZHZnTUtKU1VsK0JpVXlDNDlsMXUrYjJUSDNXejBaWldr?=
 =?utf-8?B?dzNMU3ZHQUYzVGt5UmJvME1maFpkNDErWjhneEd3aFN2V2FZZ3JGRjgyWEpC?=
 =?utf-8?B?SG9ObzJYYXk5dTNRcWk1dUEzclMxbUNGOXd1Zm5zTUdGTVl1OVY3R3pTdVZt?=
 =?utf-8?B?YU1yRkthMEJwTm1JTXVqVHhzQ0l3VkxKUDlKRk83NWdNNVdlNVBSVDJuMWxP?=
 =?utf-8?B?cTNhdTBvYzROU3F4YTMwdGVlV0JFQkR5SFJ2ME1HMGdYbXVLT0M5Y3M4TmRl?=
 =?utf-8?B?Q2VZM3ZyUWdPV2Q1b285c1Q5dXFlZjZidXZoTFVCbHdqM3NUUjYxaksxWW5C?=
 =?utf-8?B?d2paMGxZOG9WeGtCbFZ6eGgyZzBCam5UemNmVUk4ekdPTmZGQ014VEgxT29z?=
 =?utf-8?B?QWttRzRZTWhVZ3NSSUMyN29ycU82YmFsRkNqWU5UclAyVVdZTHhuNFZWK0tk?=
 =?utf-8?Q?lEkmi5f/O098r78tIcNwOiEow?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545763be-8fee-4ba7-51f3-08dcef2d0caf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 04:26:34.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4Kl4M8q3kKumkXXr5eQtn4tNYi7VY4Hh3qCvfZCq1E0yQNgjGBD0dscDLngswEeF/fI20B5KdXkfIY9LO06Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153



On 9/30/2024 8:52 PM, Tom Lendacky wrote:
> Limit usage of the non-architectural RMP format to Fam19h processors.
> The RMPREAD instruction, with its architecture defined output, is
> available, and should be used, for RMP access beyond Fam19h.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/cpu/amd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index 015971adadfc..ddbb6dd75fb2 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -358,7 +358,8 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
>  		 * for which the RMP table entry format is currently defined for.
>  		 */
>  		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
> -		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
> +		    (c->x86 == 0x19 || cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&

Maybe update the comment above this if condition with information about RMPREAD FEAT?


- Neeraj

> +		    snp_probe_rmptable_info()) {
>  			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
>  		} else {
>  			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);

