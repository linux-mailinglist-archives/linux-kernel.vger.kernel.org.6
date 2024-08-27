Return-Path: <linux-kernel+bounces-303828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D17961584
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCE81C22AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39351D1730;
	Tue, 27 Aug 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="APu27ISE"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5571C9ECD;
	Tue, 27 Aug 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779945; cv=fail; b=aQ4uXAyJ+RaFk9jrmpSv0CoRz1ouHyP1oNI8rh0Z8kuhzt0hifbQR1nx4+FHsnCC4RkKk1yD8C9STJTZeU8141RQ9AmkDDqA3M+bdiU8ofnlnexxKFxYSpaC4obB+jZTGGkxNGxviRCkGViyRMjiMmM/NTNoBF9sMI92ITKzwT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779945; c=relaxed/simple;
	bh=No8uwUNjgs4rEtMKz/3ddypHPhB4mgr9UVJWH/HM/CI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EZx3DeXFGrcUXgigSY4fafIyFSA8xqRexJDvDs4NXWdGTR4GOQTFUtQr0Y53z0jtYW8YvoQgspVTVAYNB3RVZrzl5K79T79eA9YESfFNXeBP6eDG9hERKb1EQ9kA+hm6wHA6qn64NCZAs/UUwGXcqe9tw5Iwz5/d3znfopODGvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=APu27ISE; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6uZqA+Gj9/bELMCvDP56fcXVrovwDcHdwJCpytdWO3L2ZDlUBbh0uM2gkzbS92Cz/1Eec80DGq3UqBDt9bih9XYIuK7R5R+DZ5UcLqo096fDok6TWQbqfWuRSrZfNduAZn1poAzSlGDmM4nauMm1jwrf5mYjZCnfw9Ul5s4Q81XK+fCxonOd/jwEn1vuA3iMzxVub3fZHVcPbgdyil3e7WtzZMQm0CDMsMZ80NuhYK0zlBklwdryIUgSiBwfBAOOf3Sq4CK+3mB6D6PK4bpw0w5bX6e2UGNjPdCH/O1Wh+zCr8aX0FIyg5mLpY79EX8pnVd+rt4RDGpf+XVPHItug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AL3H44mwQCBAZvFYggE5glEsZT3RN2+MoLVQxWvGnA=;
 b=KSwM8RP5qaFoUIUWouWCogV5WB2SgU+pdPfraqvsDQIuqWijLTtbP61N8do+IwUaIPR6zzR7ZmFdhDF9rdhSBRHGTpfdU6qxn6oexDkEILj9vshpV84bDItm3jNReyWwKr+NHnEdYzqFS8XAbZGV9/Awq45+bG0+o+u06EtEPYUpUeRlD5dv0oeFxnFb8BPErgKP5c45zxkl3m/KturQXO0i0KFQIYANdyKNVSd1Kl/f49G7Wgn45cZEHigKdH5v6TSss/s1YOgLKQ1TptvMMFLN0/8mtZ1Gq1NYNkl8ucUD9DukS0/HPUCTk2SCeYHGZgq9OvDufbKUePIwTI6dQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AL3H44mwQCBAZvFYggE5glEsZT3RN2+MoLVQxWvGnA=;
 b=APu27ISEGav5ZW5Kid/3aR4ZZAVneEr5O/5/a62XGJg5UxO5/3L6XgUhImWCApslXmz1COWWoCb+fxJ0FCsgcnO+tTykuVnvMyaB7nZ2tuNuY+nA0b1RUWUCl5p5WaV29U0V80loOeoOP5S+vuNFpI7fnwiH00lrtT7X/XnVkbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:32:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 17:32:20 +0000
Message-ID: <41260ea1-f89a-44cc-9485-449b3c29f421@amd.com>
Date: Tue, 27 Aug 2024 12:32:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] platform/x86: hfi: Introduce AMD Hardware Feedback
 Interface Driver
To: Perry Yuan <perry.yuan@amd.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, Borislav.Petkov@amd.com,
 kprateek.nayak@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com,
 bharathprabhu.perdoor@amd.com, poonam.aggrwal@amd.com, Li.Meng@amd.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiaojian.Du@amd.com
References: <cover.1724748733.git.perry.yuan@amd.com>
 <8d3d75941a87839ab88dff20e89b73c0f5e6cb2a.1724748733.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <8d3d75941a87839ab88dff20e89b73c0f5e6cb2a.1724748733.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0168.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 023ef3f2-061c-4fa8-4ae7-08dcc6be3475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MC9pM2NCYlAxMUJEencxYndlYzhRdEdibmN3bFBDOWRsNjRQV3Y5bE42K2cr?=
 =?utf-8?B?a1NxK3hGQVlNeWJvNW1LNndqaWkwU2t4ZUE3OG5ycDRHNXhwQXZPWWs1dDhS?=
 =?utf-8?B?RDdBeXhTV0wzMnd4U3g0a2lyNisvYUNjY2xXQkhoQ3diYmJiRTA3aVBPbmht?=
 =?utf-8?B?L3pRUTRISHhBNFBOdUczMkYrNzlzeElhenVkdG56N1dQRVJpRmYyYXpDN3Zv?=
 =?utf-8?B?dS8yYlM3SVRXQllGNTZZN3VvWU90UUlGR0Q2VitnMVpLU3FNVysvanliVC81?=
 =?utf-8?B?V29NYXlYamxFSVNOL2I0OGdtOGFML01VTmNwYXZ1ZTNaYXorSmNLY1B4NUJp?=
 =?utf-8?B?NU9vVnRoU0ZoVUc3ZjhrazZSMFVHU01OTjc5ODZtTEFQdHQvSHNtdGZjT0Z2?=
 =?utf-8?B?YW92OW01YVRRb3IvbXppOGJNd2l3NUhZczE3VENJM1grS2s3QnVNakV4bVkx?=
 =?utf-8?B?cDNpY2xBMGxaKzZKbmVVQWxrMW15Sk9ZdEd1MEw4ZjdadnlZdVRmL3BLL1Ry?=
 =?utf-8?B?eG8vVTNnbTRyYzhDWmdlQ0NsUE55RzZ1WmU3Qkt2bkFCWFhVTm9Ta1Y3cjFM?=
 =?utf-8?B?dzk2eXJNWjRTbGpiWWJWLzh3R3dBK3EwenVhYzFvTXJVVjZKYjZRWVUvL2JG?=
 =?utf-8?B?OGxIWjM3VEIxV2wwOUJoc0NQUlBuWHhOQisrV1RzbzlyM1JTNEU3VFRUY0N3?=
 =?utf-8?B?R20rRVZ0Q1RBNDlzUHY5SHRxTmVhQ2Q0ZVFLK2ZxT1ZYMm5GeHlUYXVBQXNW?=
 =?utf-8?B?MlhZQW5wMkxuazhCalJCOFVxL0dpLytMODdQdDNMaXVZaFZLd0RidVlXcVRS?=
 =?utf-8?B?ZVc3eVh1MmNFNlhkbDB6N3l1NWtOaml0R0JyY2VmQ3gwK016R0pKMU94ZGhz?=
 =?utf-8?B?cDZyNFQwbm1nSm5iNkgwVklxTlprclVnTXlkUzNHRWQzUEZlZDlMbVNuR3dO?=
 =?utf-8?B?QjRMaHkvTGkwQ25OMkhiSXRJNjFUSFE4YlgwN0hxRTdFSU95NVpHejU4NzJK?=
 =?utf-8?B?MmZKTlZNYkY1RDM1dUtRR25QeUpFNHNOeG5ia2o4bEphSnJFY25ScnFwUm51?=
 =?utf-8?B?eDBSaGh1bUpvYWozaDJvQVZHbmI4QkY1WngvbGtXSHM3VlFhZWtIaWx4VkJB?=
 =?utf-8?B?ZU54SHc3clFRQXI1Q0daMWhWYTNkTnREbDVqbUwvREZIZmdxdDB2S0JBcitH?=
 =?utf-8?B?OFhta3FCV3UyemdJZ0NySnBPdWo1WnVjNytKNmxXaTF0UkIrMUl3NmhGUVF0?=
 =?utf-8?B?UnpHT1JNZ2lsTFB4UHN2MmpaVW5vc3dBNHZRVUJkNXZTaFQzZW1nSllKblJ0?=
 =?utf-8?B?dk04R0tTaUZEVStETnQ5b2ZSQUxMZ3ozNnlmMGU2c3BCL1ViUVM5RUFhYzZi?=
 =?utf-8?B?SWpLQnVJcGFwOFRrN3ZFVkRaVldJczhOS2tIaXBzd2pHc2dSMk1QcVpqVmVm?=
 =?utf-8?B?alNGbUhLdzdHM2g2TkFlQUpsWjBzSnJERmQ5UWRsQTl3RE9SVkNlcVdKQk5Q?=
 =?utf-8?B?anF0WW1pQnozUVVSOXRudEVIc2hSMlB4bklRY0oydkZ6OTRkQWZLbEtOb2VC?=
 =?utf-8?B?eEdLNUhOdkZ5VG1xZjhGTlRFWk1rTDZXUlRZK0lMNkhQYVh5YVhiNktHRWtm?=
 =?utf-8?B?aEp5WWpJRU93NlJTTDF5anNxblFKdlpDL1U4RFhTMkt4MmxJbDNJRkdKZjgw?=
 =?utf-8?B?dDdvQ2UxTjdTRWE4ckplc0tjN280MHhabDltbDd5VFdvazJJaGtiTE12bkdQ?=
 =?utf-8?B?VUkxazNjVlZRdDg5bkJZQXRRYlhOWnZnYzlaMU9WWVlMY2VQeW9Xd1AwRGI0?=
 =?utf-8?Q?IgEje9fO00vQ0FLNPpVgud5DqajC7TgxvDWjs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2dlVi9UQ3RHOUFSVXNzbGdaYTl0dGV6NU1KQUJNVFdvdW1UT0JXMGI2bTVq?=
 =?utf-8?B?aEFJdEFHekwvV3ZwTkxlTTMwT3VKV0hLR0RtL3JiZm82Yk40aG5IRnhzaEdq?=
 =?utf-8?B?cThVTzFKaUVnK3Z3SFZMcmxQNVFKcDgvMTlNTDlUQmxIem0zMlJXd1FkWFdj?=
 =?utf-8?B?bEZrMXZmTmhmNGFjYk1zS3pLNWNZLzBVL3ozMlVjYkJnR2VGRG9vdk1ZMjFZ?=
 =?utf-8?B?THpiM1g2ZUxWRzNiQ2ZBVDB2Vlp3WlBFWWhLamtOY1VCM3JjSVhVaWdrZlFa?=
 =?utf-8?B?akUvMENCdFdBY0Q5S0NJNmVrak8wRlh6VklGeTF2Slc2UGh0KzEvdERXYTVV?=
 =?utf-8?B?NzY3YVZCekoramJlSTZUeDM5NlBEY05aZ3YxRFQ4QmtxbHJBeGxkcmE1UklY?=
 =?utf-8?B?TUtMQUNIMG1Oa2ZNeVliOWUwM3dqU2t4QlFsblNya0FmM2xhVGwyUG5oSVFp?=
 =?utf-8?B?UGhUcHQzWXN1ZmxBemxaY2xjamNiUWcvSDVNSFI2cStHWWlLa1BFL3pKdUdq?=
 =?utf-8?B?ZWZZYW03Zld6TzgvTENxQWh2TCs3N2hUN1FWeUtUWjRnU2IwMUJkME8wbWpJ?=
 =?utf-8?B?Z0Y1bXdVZ2hTY1Z0Y2hPMEUzYjk4SEhUK1l5MWYxa05zRjROTVkydXpwTTZK?=
 =?utf-8?B?aEkxZXBjSTJGUFhsZVNiOWM0K3hkbEx0RVo5ZytpcUlxbXVZQlBkLytMdW16?=
 =?utf-8?B?S1IreVI4QXRBUitDRk41UW1IZEZkVHVrS1AzdkY1cWlnN2JzS3ZoQU4yZDVn?=
 =?utf-8?B?NUJZVFE0Sit5bjVOQVhPOXRYaGZkdWxGakpsdTJuRGVrUVV2NWZXampoV2dQ?=
 =?utf-8?B?Z3U3UDk3T0JyVGswWC9aM0tHamc1a2d4VVQ5aFZFZ1NtcW1uM0dwRXB0UDJz?=
 =?utf-8?B?UDEwZ3RTKzJ2czZOV1orZEo5djNQTjBQMVhaVGttbFRKNjdHeEtqM2k1SlhB?=
 =?utf-8?B?azVrSlZQaVk2Tm9mRGV2L2oreXViNityM2VkVmFSRzBxR25TZW9SVXVaWWJX?=
 =?utf-8?B?aWQ3ZW93WURrRmpES0hIczJOMndFWEI4bE1mY21SWWlxQXdpUnE4d3lZdko1?=
 =?utf-8?B?cnlNVTBtT3RxSHZUcXlyWkZuN0E2R09WM2d6SEdvNzhvdkJ6dHcxVGVsdHRN?=
 =?utf-8?B?SUxhTHA2RlRMZmxZZkJ0NHZxV2Jua0loWnhQTGw1eG1Kc3Rnb2FxMlMwSkxj?=
 =?utf-8?B?TU1yME5vd2tGV0w0YnQvNUFLa0lZMTJSeHBLZGRUSXdJTGxYM2gybkQvUER0?=
 =?utf-8?B?Ry9PVExUWU9MT285blV4dElBNzZ1aFJhVmVrNDByOUw0OE42TnZNY2lBcmd4?=
 =?utf-8?B?UGx3THdOd0pJRFhCU0I5TnJodEdXNWhqY3NBWE5tRmFvamRMWWlndjdKdm5O?=
 =?utf-8?B?M0hSUysxV0pOcEJpZERJYjJZalZHZVlRYXZqOG5JeE1kZWVWbTRGZHVta2RB?=
 =?utf-8?B?NHhJa0YyM0F1blFKcmdDaWROOXovVmE4WXZ4TFZBd3NMalduZFJMNDB5VXls?=
 =?utf-8?B?Y05tWFJBc1RMRGlqR2dMTm92Nyt1bGlIajhwdUFyU2NaUVQ4WFlnRFN3REFP?=
 =?utf-8?B?QUFtYUNMSlVGREtLOTVPckZydUpBM1NiTnFtQnhkNFp4aXJtV21QVWlTOXVi?=
 =?utf-8?B?ZWFDVHkySXpZZW5BUnZubE40MlRENzlBc0p5OU42R2FPK25LTGRjRkIxdjhX?=
 =?utf-8?B?M0xoRDkyL0ZFR1Z4aVorY3o0YXpjZUtMdmN5SW02K3owcTFsVW5WeXI3bEcv?=
 =?utf-8?B?YVh5Yk5vNXhxcFR3cUE1djlrTGRHVUU2d2R5MS9xTEhhc0pBQ3YvT1R2dGVR?=
 =?utf-8?B?R3NScUVMSDVIU1JCSnNjVnJjLzJwa1c2eHNHN3NNNTVhZzBrV0xwZUplc2hw?=
 =?utf-8?B?VTIxTUR0TzAwdUpjSmtRUzJLWjZiLzE5QmdCYllYNXc4YTVKRkwyYlpBaXZI?=
 =?utf-8?B?TlJrc1FwRHQ1cXo1eWVNWGs4endOWDY0UERqWS9HU1AzUVd4QmJtMHZJQUd1?=
 =?utf-8?B?ODVRSHYvWmZQSHErdFc3cTVIVVIwenp6U3lYRTV5clZwZUJVemFRQmRDNVZj?=
 =?utf-8?B?OEZhTXZzTUJIUDYwZmgwelFFNzBuSlBzSHc0bnNSK3dta04rZUtJZkVEbHVT?=
 =?utf-8?Q?1EoFgo2jsl+ZIqkz+Y1wcd2gH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023ef3f2-061c-4fa8-4ae7-08dcc6be3475
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:32:20.7274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYedc/rDFarqLRlwJiA40nKo4r5d4fwWIAi8Zo2LBdel6QUcSwHFB59Bo2wMg6+/a56aA7QqF+5gnlcF0f3ssA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288

On 8/27/2024 04:36, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> The AMD Heterogeneous core design and Hardware Feedback Interface (HFI)
> provide behavioral classification and a dynamically updated ranking table
> for the scheduler to use when choosing cores for tasks.
> 
> There are two CPU core types defined: `Classic Core` and `Dense Core`.
> "Classic" cores are the standard performance cores, while "Dense" cores
> are optimized for area and efficiency.
> 
> Heterogeneous compute refers to CPU implementations that are comprised
> of more than one architectural class, each with two capabilities. This
> means each CPU reports two separate capabilities: "perf" and "eff".
> 
> Each capability lists all core ranking numbers between 0 and 255, where
> a higher number represents a higher capability.
> 
> Heterogeneous systems can also extend to more than two architectural
> classes.
> 
> The purpose of the scheduling feedback mechanism is to provide information
> to the operating system scheduler in real time, allowing the scheduler to
> direct threads to the optimal core during task scheduling.
> 
> All core ranking data are provided by the BIOS via a shared memory ranking
> table, which the driver reads and uses to update core capabilities to the
> scheduler. When the hardware updates the table, it generates a platform
> interrupt to notify the OS to read the new ranking table.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> ---
>   drivers/platform/x86/amd/Kconfig      |   1 +
>   drivers/platform/x86/amd/Makefile     |   1 +
>   drivers/platform/x86/amd/hfi/Kconfig  |  21 +++
>   drivers/platform/x86/amd/hfi/Makefile |   7 +
>   drivers/platform/x86/amd/hfi/hfi.c    | 209 ++++++++++++++++++++++++++
>   5 files changed, 239 insertions(+)
>   create mode 100644 drivers/platform/x86/amd/hfi/Kconfig
>   create mode 100644 drivers/platform/x86/amd/hfi/Makefile
>   create mode 100644 drivers/platform/x86/amd/hfi/hfi.c
> 
> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> index f88682d36447..c3f69dbe3037 100644
> --- a/drivers/platform/x86/amd/Kconfig
> +++ b/drivers/platform/x86/amd/Kconfig
> @@ -5,6 +5,7 @@
>   
>   source "drivers/platform/x86/amd/pmf/Kconfig"
>   source "drivers/platform/x86/amd/pmc/Kconfig"
> +source "drivers/platform/x86/amd/hfi/Kconfig"
>   
>   config AMD_HSMP
>   	tristate "AMD HSMP Driver"
> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
> index dcec0a46f8af..2676fc81fee5 100644
> --- a/drivers/platform/x86/amd/Makefile
> +++ b/drivers/platform/x86/amd/Makefile
> @@ -9,3 +9,4 @@ amd_hsmp-y			:= hsmp.o
>   obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
>   obj-$(CONFIG_AMD_PMF)		+= pmf/
>   obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
> +obj-$(CONFIG_AMD_HFI)		+= hfi/
> diff --git a/drivers/platform/x86/amd/hfi/Kconfig b/drivers/platform/x86/amd/hfi/Kconfig
> new file mode 100644
> index 000000000000..4671cc1037a0
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Kconfig
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +config AMD_HFI
> +	bool "AMD Hetero Core Hardware Feedback Driver"
> +	depends on ACPI
> +	depends on CPU_SUP_AMD
> +	select IPC_CLASSES

Was this ever merged?  Presumably you shouldn't be selecting something 
not in the kernel.

I thought the last I saw for that series was:

https://lore.kernel.org/all/20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com/

> +	help
> +	 Select this option to enable the AMD Heterogeneous Core Hardware Feedback Interface. If
> +	 selected, hardware provides runtime thread classification guidance to the operating system
> +	 on the performance and energy efficiency capabilities of each heterogeneous CPU core.
> +	 These capabilities may vary due to the inherent differences in the core types and can
> +	 also change as a result of variations in the operating conditions of the system such
> +	 as power and thermal limits. If selected, the kernel relays updates in heterogeneous
> +	 CPUs' capabilities to userspace, allowing for more optimal task scheduling and
> +	 resource allocation, leveraging the diverse set of cores available.
> +
> +
> diff --git a/drivers/platform/x86/amd/hfi/Makefile b/drivers/platform/x86/amd/hfi/Makefile
> new file mode 100644
> index 000000000000..672c6ac106e9
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# AMD Hardware Feedback Interface Driver
> +#
> +
> +obj-$(CONFIG_AMD_HFI) += amd_hfi.o
> +amd_hfi-objs := hfi.o
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> new file mode 100644
> index 000000000000..914390682fef
> --- /dev/null
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Hardware Feedback Interface Driver
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All Rights Reserved.
> + *
> + * Author: Perry Yuan <Perry.Yuan@amd.com>
> + *
> + */
> +
> +#define pr_fmt(fmt)  "amd-hfi: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/cpu.h>
> +#include <linux/cpumask.h>
> +#include <linux/gfp.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/smp.h>
> +#include <linux/string.h>
> +
> +#define AMD_HFI_DRIVER		"amd_hfi"
> +#define AMD_HETERO_CPUID_27	0x80000027
> +static struct platform_device *device;
> +
> +struct amd_hfi_data {
> +	const char	*name;
> +	struct device	*dev;
> +	struct mutex	lock;
> +	acpi_handle	dhandle;
> +};
> +
> +struct amd_hfi_classes {
> +	u32	perf;
> +	u32	eff;
> +} __packed;
> +
> +/**
> + * struct amd_hfi_cpuinfo - HFI workload class info per CPU
> + * @cpu:		cpu index
> + * @cpus:		cpu mask of cpus
> + * @class_index:	workload class ID index
> + * @nr_classa:		max number of workload class supported
> + * @amd_hfi_classes:	current cpu workload class ranking data
> + *
> + * Parameters of a logical processor linked with hardware feedback class
> + */
> +struct amd_hfi_cpuinfo {
> +	int		cpu;
> +	cpumask_var_t	cpus;
> +	s16		class_index;
> +	u8		nr_class;
> +	struct amd_hfi_classes	*amd_hfi_classes;
> +};
> +
> +static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
> +
> +static int amd_hfi_alloc_class_data(struct platform_device *pdev)
> +{
> +	struct amd_hfi_cpuinfo *hfi_cpuinfo;
> +	struct device *dev = &pdev->dev;
> +	int idx;
> +	int nr_class_id;
> +
> +	nr_class_id = cpuid_eax(AMD_HETERO_CPUID_27);
> +	if (nr_class_id < 0 || nr_class_id > 255) {
> +		dev_warn(dev, "failed to get supported class number from CPUID %d\n",
> +				AMD_HETERO_CPUID_27);
> +		return -EINVAL;
> +	}
> +
> +	for_each_possible_cpu(idx) {
> +		hfi_cpuinfo = per_cpu_ptr(&amd_hfi_cpuinfo, idx);
> +		hfi_cpuinfo->amd_hfi_classes = devm_kmalloc(dev, nr_class_id *
> +				sizeof(struct amd_hfi_classes), GFP_KERNEL);
> +		if (!hfi_cpuinfo->amd_hfi_classes) {
> +			pr_err("failed to allocate memory\n");
> +			return -ENOMEM;
> +		}
> +
> +		hfi_cpuinfo->nr_class = nr_class_id;
> +	}
> +
> +	return 0;
> +}
> +
> +static void amd_hfi_remove(struct platform_device *pdev)
> +{
> +	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
> +
> +	mutex_destroy(&dev->lock);
> +}
> +
> +static const struct acpi_device_id amd_hfi_platform_match[] = {
> +	{ "AMDI0104", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, amd_hfi_platform_match);
> +
> +static int amd_hfi_probe(struct platform_device *pdev)
> +{
> +	struct amd_hfi_data *amd_hfi_data;
> +	const struct acpi_device_id *id;
> +	struct acpi_device *acpi_dev;
> +	acpi_handle dhandle;
> +	int ret;
> +
> +	id = acpi_match_device(amd_hfi_platform_match, &pdev->dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	amd_hfi_data = devm_kzalloc(&pdev->dev,
> +			sizeof(*amd_hfi_data), GFP_KERNEL);
> +	if (!amd_hfi_data)
> +		return -ENOMEM;
> +
> +	amd_hfi_data->dev = &pdev->dev;
> +	dhandle = ACPI_HANDLE(&pdev->dev);
> +	if (!dhandle) {
> +		dev_err(&pdev->dev, "dhandle is null\n");
> +		return -ENODEV;
> +	}
> +
> +	acpi_dev = acpi_fetch_acpi_dev(dhandle);
> +	if (!acpi_dev)
> +		return -ENODEV;
> +
> +	amd_hfi_data->dhandle = dhandle;
> +	mutex_init(&amd_hfi_data->lock);
> +	platform_set_drvdata(pdev, amd_hfi_data);
> +
> +	/* alloc data array for hardware feedback class data */
> +	ret = amd_hfi_alloc_class_data(pdev);
> +	if (ret)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver amd_hfi_driver = {
> +	.driver = {
> +		.name = AMD_HFI_DRIVER,
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(amd_hfi_platform_match),
> +	},
> +	.probe = amd_hfi_probe,
> +	.remove_new = amd_hfi_remove,
> +};
> +
> +static int amd_platform_hfi_init(void)
> +{
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_register_simple(AMD_HFI_DRIVER, -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		pr_err("unable to register hfi platform device\n");
> +		return PTR_ERR(pdev);
> +	}
> +
> +	ret = platform_driver_register(&amd_hfi_driver);
> +	if (ret) {
> +		pr_err("Failed to register hfi driver\n");
> +	}
> +
> +	return ret;
> +}
> +
> +static int __init amd_hfi_init(void)
> +{
> +	int ret;
> +
> +	if (acpi_disabled)
> +		return -ENODEV;
> +
> +	if (!boot_cpu_has(X86_FEATURE_HETERO_CORE_TOPOLOGY)) {
> +		pr_debug("amd Hetero Core feature reporting not supported!\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!boot_cpu_has(X86_FEATURE_WORKLOAD_CLASS)) {
> +		pr_debug("workload class reporting not supported!\n");
> +		return -ENODEV;
> +	}
> +
> +	/* platform PCC Subspace Type 4 driver init */
> +	ret = amd_platform_hfi_init();
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static __exit void amd_hfi_exit(void)
> +{
> +	platform_device_unregister(device);
> +	platform_driver_unregister(&amd_hfi_driver);
> +}
> +module_init(amd_hfi_init);
> +module_exit(amd_hfi_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD Hardware Feedback Interface Driver");


