Return-Path: <linux-kernel+bounces-390862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7949B7F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7147B1C222C8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3621B86E4;
	Thu, 31 Oct 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uXeSizGr"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8A1A76D1;
	Thu, 31 Oct 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390034; cv=fail; b=JR2U0LjkRdZZuc4OfQaHLQbyGX0tLcrdKBXUpUUIY0/r/rNzWHu7AEJLR3osq4aIVOJ8i7ljRu5lyVryWVX+Mq9+Vsc0pbUq6lD4mmRyYZXAMCfrNcn1Obw1xZ3M+ZRrEMD/20DpfhGmC3x2cFXk6/2F4PO94qj2eQY5ygbp8+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390034; c=relaxed/simple;
	bh=B2eS6G4Wpe/Mn54kJHzoVutbLnrXN2TzuAB/8AxsVQ4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EYmP22L16HtbUqAlFKaroy80VuSJW6PgRngKarSIFEMyJSgQY/TR4PVPSrSHOC5dZusCzX8E6rIC1DD4/hl1JZi4QwSsDygyqrBiSSHVHhL4kMTcxpurkTnO6zYzcL26kOkOdph67DFK2j1oqg04b33eDF2FplGZgUKlroCqazU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uXeSizGr; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8Xx3VDtETAM2c/mB2f9OxeLxpQD/YOz3M/pnDT6XKn/6HjZ4s9GUNrtb1as5rdRXxYNY8ZG1rcgXSfFyCNWj1c76LtpPJe4KW5bhsyTFoMBQ/72jdkt/Lm+yIvcnK/7nZwdZr2/yC/sgEqK9qxYAh5aRVN0bm1mAD/3Mxyqq0p//tSkg0t5LptgL+VuXtHktTE3a/ZRBAnAeXXerYyi3wEGLnxT35NUHEjaXkQrjzBdSTnOhgSogS3AiJ9SQmKKsX3D/Dl561LGPfAn8SyzFfkgzsGBcq56XQhso7SR1uxuoUJFpGhqvfvbZgT5wfv2nah33R/a7KRbigoAl9xSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jY23PKTPkngLkKhaHhK+S7PkZMvhqjHmbZEi1Q8VH0=;
 b=nSsewpIrVKVsotIpjMifULI1MJTG/7+Ov7q7Q3X7lQuZaBbTX+wIg+HQrqD3hNKb8tNxY20TXxxekYutGtf0DY9JbKB4dULXiSoCcCiuNDn5+mjNgNvJNRTpekpcooTNRXfafkIx8wvGmoyfMbRtRAOdvDvXo5hXR2t8ygGmesteRt0+CZITY5X5n/ENeErNmZZjXhNLJq8OE9TX+HphvH23JEvHfRn/jEaViYGHGrMNUCPRlWHpk65C9VlRnQ9HpuChg7t3r4idHs5iKpDb8dfCDZzcp/elpnEJN9XPtNLC/L7qZGcpb0ij2XLFErPKN02jyLSxwa2dKwKIBPgNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jY23PKTPkngLkKhaHhK+S7PkZMvhqjHmbZEi1Q8VH0=;
 b=uXeSizGrUriBvVOZWFlqho7XsfrkpvUMK5/OCMLHVLgHOG1J+LgeezDTYTLXetWQykVtyPrQGKvVDSfzQWtsW00mjgR8Gf2jZyVR+DkcpLq2fLEblDu6Ni/AbDgbX6y1svlB2tsPL3Ex4fk8jDteaz5opu9Xs89VR+iKI+2GEaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 15:53:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:53:48 +0000
Message-ID: <f236aea8-de6a-418e-9008-26f9505362c0@amd.com>
Date: Thu, 31 Oct 2024 10:53:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dell-wmi-base: Handle META key Lock/Unlock events
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 pali@kernel.org, platform-driver-x86@vger.kernel.org, w_armin@gmx.de
References: <20241031154023.6149-2-kuurtb@gmail.com>
 <20241031154441.6663-2-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241031154441.6663-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:806:d2::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fc35d9-3844-4051-15c1-08dcf9c4355f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEdlVi9EVTg1WkcrcXdxOGkzUHJyaTU5S0d0aDJ6dDdmNnlNZno4cVJ6ZEhH?=
 =?utf-8?B?cittb2RGZWlMRWRtM2tpd2llR3NJd0FxSGFUalpHaGRJZ0ovQUlUN1Fzd25j?=
 =?utf-8?B?V3RMdEJUa29LaWV3VWo0dlBGbW4wei9iaWNvRzF2VTVIVDVneEZ5TkpoRnpQ?=
 =?utf-8?B?SmFyT2xyNEtOSWJIMksweEdENUZVR1A1bmpZdTdsV1VuNHAyZHhxcllWTVJN?=
 =?utf-8?B?ejdMcmxscjJWcm8zUGRmU1AyaHZRb1NzRm04ZXZ0UnBsVDN0TGpwZ3BsbDNR?=
 =?utf-8?B?U1RXRWJXbTB6UkE3Yjlsa0pvZXltWDBOWGJYTDhGTlB0bk9yZUViUEtkekRn?=
 =?utf-8?B?Z3dOYkZxSXpIdWZZak9LamZ2azd0RFowYW5EaS9laHh1emZjRitmV1VEZkha?=
 =?utf-8?B?QmZkVDdBQXI2OWJYNHBkQjZXQnlzRnJEdUQ4VXNzWlVPcGxHeERJZ1A4Qk1r?=
 =?utf-8?B?TlBGeWNvSUx0SUhaN0VFOE9pV2V4K0ttYU9oVHFJWUc4bG16OGw1V0J0UTZS?=
 =?utf-8?B?NUMzcXN0Nk1NcGJPTVNwZG1jenNhd2xSVTlQY0hjS3UwYmFnZG56aWp1Ukd0?=
 =?utf-8?B?d3VnMlpkS1V4Y0x6K2cveFo3R2NNa0Y4MWJ1c081UnV6UFI4N2JvOTZEZHZp?=
 =?utf-8?B?emlHSjVtZ3FQa2RXcFZmdC84NWx6Z1psZ0FQdVordmp0Q2RwUVR1a0s2OTk4?=
 =?utf-8?B?VVp1TnBhbUJtWXlsbnhTajJ3aHNwTEhoT0pPK3FFWXVvNjBtOVE3VnlFMHV6?=
 =?utf-8?B?dTlBVEZMMzkwNHhFU2FzRkpEUHg4S0Ird2ZQV1B6OUoyZDBHekQ1Y3h0QnBv?=
 =?utf-8?B?cmJoWnRNek5QY0hYeDZocnBZZ29nSXZwUkZpajBkaDFlblBRZzNwWGRoS2VT?=
 =?utf-8?B?Yzd1R0I3S0pmUitJVTgwc3FSY2J1U0RGK3ZVaGdoZ1ZrNjNOdzZaNEZMR0s2?=
 =?utf-8?B?YUt4WEpWY21GMU5ySStZU2U2MUtQUUhDUnlGWFdwOEFOazhBNHRPdmZrZkxo?=
 =?utf-8?B?MHBTbVdqbXFlbGd0T0JBUW8wR3BnempGdnJhbjQwdXBmdFFaVkFocGY4YVVS?=
 =?utf-8?B?NCtXMFNsTG9MTVBwN0ZNcVpQM3Y4TnpIYkVKb0tXNEk1NExXU2M1ajBDamFx?=
 =?utf-8?B?ZFBsM3hCZER5WEozOHAxS25uSDhRa2JreFJ5TlJicGJDdUIyWm1sK1Q5SVJs?=
 =?utf-8?B?QTF0emNWM0lDUFNGWDhSU1lZblZpWkZSQXkvT2d5cG1vbzFqZG11eFozZzVt?=
 =?utf-8?B?elFTT05lSUVjUXNETEwyb0JpMnZBSllnNTVrYTdhcDJLdFVRak0zOGwwcFlC?=
 =?utf-8?B?VEJuc2MrdFRUZnZuRU4wWHRSOU1mNW9Rc0dmbGZFMjVEcEdRaVRVbmFrazdj?=
 =?utf-8?B?bDJjOTdiVUdNTHU5by9HYVdmUXRaMmVMdGljQzRtSGorRldPVkVKa3pTVUp4?=
 =?utf-8?B?SFdUcDJEbXZvdXgvTEFsNnBnSmZITkd3RGxucmlOL2hoak9lN2YwLzJQK2s1?=
 =?utf-8?B?eFJjRnppMGx3N2V1V2xTRXZCL000ZHV4U2FwZG5IQS8wd0s3bXljVUxnd0ZX?=
 =?utf-8?B?cjNNdG10QmdzZDlWTmE2dVhDMHJudGFhUXNlTkhsbzg3Vk1RS0VKbDNmYk1a?=
 =?utf-8?B?L3pEM2M1bjg0U2tOd0t1Uk5ibFlHNlkzZGZlaDFxZUxkbk8yTlBtNis1UGN5?=
 =?utf-8?B?NnJzWE1mRG9UUVhsWWJqclp3aU1qb3FyZGpEWm9MV05WVEdaMkNFamNoVVpv?=
 =?utf-8?Q?FxNFPIAe+iLe3Nf9Kw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVFlZTh0MXV2aDVWdERZN08zYjlBRkQ3SnlnNWZnSVhEYjdYb2I2cWEveStt?=
 =?utf-8?B?ZWhqZDZNV1ltVlJpbDJ0WEU3bjJ3ak5Zd05peWdpeXVjc0hoc0RvVFVMUGhT?=
 =?utf-8?B?Y1dqb1RBSE1Gd3h2ck5OUjdKNldvOXVSYzF5L1VPQnRiaS83bUsyZGtUL25G?=
 =?utf-8?B?elRRMkRzZFdOQ0JZQUhseWQ5WXNyR1JlVnQrZmVGMnVHcmI3S1hGTlkxYW4r?=
 =?utf-8?B?OE4yL1Y1M24vTVgxankyejV0cEgxWFhGNUJmQ1orLzE2MGlQaUJwR1RhQWtX?=
 =?utf-8?B?MzR0aXZTdERaQkFuQXhDSnU2Vm1CNlFERFdVZ0hSc2hCemNxcit2K3hLTXpH?=
 =?utf-8?B?ZUxuOVQycEFkVUsrUmhBV1NtTk5QOW5hSk0zcUZabG5tdWN5ZU9sUDZJcVh1?=
 =?utf-8?B?UHRjb0QvTHduTmYxZjh4dVM2WTQxckVQQ3U3Yno3WDk3dmt3ZDlUWExVQTRZ?=
 =?utf-8?B?QlhMSFlTVGhhcHl4Q0RHNTNTZEVLRjNOV3FOa2FXcjltRGd2cGN4M1Ewd3BH?=
 =?utf-8?B?cEV0Q0lWREV1VUZjTHJyNWtYRnFIUVlhUlJVZHFuVm1seDZiSnZDcjF1cWlW?=
 =?utf-8?B?YnRteEN5TU10eUpGR2FGOWROR2Q3NUM2VDVLS3RDNGNWM1VyOCs1djR1eDhy?=
 =?utf-8?B?ZUIvYVVLTm1JNTdaNnFTamduRmcyTW5Hc09UUjN6Q1BNSXdvaWt2ZmROU0xK?=
 =?utf-8?B?M0lSZWlSdmJZa3N5QlpkcFRLbE5LVDNrZUl3UGJpVlY2cU9JTlRtVjdWWWxl?=
 =?utf-8?B?TlN0czRKbWY4c0djaWhlRDNwSnd3dVphU0lJMTBGd05tdVVxbHZKRE5LWFlU?=
 =?utf-8?B?VXBnRFVrSlRjQitxeWdYMWF1TkF1MGhocGt3MnRoV0dZUzlhcmVldXA2bThu?=
 =?utf-8?B?VkI0QzJ0dHpjUDhDMjlzeW1WWnV1Wi8wYzlrU1VRblZZNVVJakcxNTNURXFD?=
 =?utf-8?B?QlN5eWxyTVQzWWdXZFp6RXYrRjlLbldITXFZNGRpQTdPZ1NMU2R3MHVxS2V2?=
 =?utf-8?B?YVJHVzNyTkZSUVlEbTlwalE5RmlhV3BScER4aWRrYldLZGxqdFpGNWhRdENw?=
 =?utf-8?B?ZncxMWxjSHlMMHQyc1ZWbms2L0dPR2hIek5VYjgzb0pNZ1B3UkxvYitvK1hD?=
 =?utf-8?B?UEZ1ajJBaEtqNCtiaTc4TitSZHlQZitDbUIzNmpRTHlCVVorZ0hwd0pEK0d6?=
 =?utf-8?B?T2NkclJvZ1l5dWQzN1ZrakV6TnI2VDYrZDhHa3lIeGZKbllxWkNkbklwalIz?=
 =?utf-8?B?dTJxR2ZmUXovMlMvRUtUK2t1MXl3ZnRtUXJtOFF2d2EzWjlNdHF0U3lpLzN5?=
 =?utf-8?B?RkVqZzJjdmg2KzNVWUVMbUlZcDRybzRGQjZhSmJObnlyYitNZmNhK2JYZkZm?=
 =?utf-8?B?UVZYTW5HYUJyNFlTZDFXTUxTTm1aVFpkVWRjTlE1UVowQjEzalFGUzRvNThR?=
 =?utf-8?B?eFdvZjJ3UGV1ZjBIWmFNM3hWVGt5K3pDLzlmU1NHYUh1U003NU5uSlhKbmw3?=
 =?utf-8?B?Q1FqRklQWnhNd3Y3MWg0WUYvQjhUL3NTd09jUmtvRDhlRmhVbXYydTFYd1hD?=
 =?utf-8?B?Mjh0Wm9YVTIvRHVZOExLc0FvMEUvZW9hWTRrdEF1VElqSi9PSmtVdjRsOGlZ?=
 =?utf-8?B?NFpkclpiTmFxajV0aFY1RlM3S09LMTZRdG8rdi8vSGV4aUVGbmpiRzBwalZu?=
 =?utf-8?B?WURLSGhZQk1pM2dXMjEwa01KY0s4YVN2bktMNzM0UTNZa2ErMThBamwzQWlz?=
 =?utf-8?B?Z3VhelhxdkEweSt6VVpSVHIrM3hZTU1PbFZJU2xnQS85TXB5L2hZTld3NWlX?=
 =?utf-8?B?Q01FVkhUK0xPTFVlSFFNdjI0aElubnJiR1RDTkhJdnFMWmVWVnRyVit5WGFj?=
 =?utf-8?B?RHhpc0FnRHByNTZGVFJncXAwZDJkUDJPMUVjRHZqcTFqZTMzMnVYUGNrbFlI?=
 =?utf-8?B?eEh6S2dXR05EL2FKL3RaNWpWRExqbWlyVjZFeURHbnpWaE5aSUxRd0FGRUFM?=
 =?utf-8?B?SU1kb3o3dlFUQVpXVUJlV016WHlJdTRzWUtZVURWQTZ5YVNvZ005dm5sK3FL?=
 =?utf-8?B?eTFOZU1jcURsd3lHaW1uRFFnSURSdUFaUk9OdlFKMXF1MnFHZVhOelI2djJ2?=
 =?utf-8?Q?LZ6Xe6qrgSXJbhdrTOc+OAyzV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fc35d9-3844-4051-15c1-08dcf9c4355f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:53:48.5483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vb8KeoJCMjH0LEkKle50Xfc9ZA/gEqXkq5jsP5ofMv/ySLeZlbbVcvjzT+N3UppgyqMTpd65uwk5xqR1jofB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261

On 10/31/2024 10:44, Kurt Borja wrote:
> Some Alienware devices have a key that locks/unlocks the Meta key. This
> key triggers a WMI event that should be ignored by the kernel, as it's
> handled by internally the firmware.
> 
> There is no known way of changing this default behavior. The firmware
> would lock/unlock the Meta key, regardless of how the event is handled.
> 

Thinking through why this event exists, it's probably so that there can 
be a toast message or popup or something similar in Windows to show an 
icon that it was changed, which doesn't currently exist in Linux.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> Tested on an Alienware x15 R1.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> v2:
>   - Fixed entry style
>   - Commit message clarifies firmware behavior
>   - Commit message now has "Tested on"
> ---
>   drivers/platform/x86/dell/dell-wmi-base.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> index 502783a7a..ce421e51b 100644
> --- a/drivers/platform/x86/dell/dell-wmi-base.c
> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> @@ -80,6 +80,12 @@ static const struct dmi_system_id dell_wmi_smbios_list[] __initconst = {
>   static const struct key_entry dell_wmi_keymap_type_0000[] = {
>   	{ KE_IGNORE, 0x003a, { KEY_CAPSLOCK } },
>   
> +	/* Meta key lock */
> +	{ KE_IGNORE, 0xe000, { KEY_RIGHTMETA } },
> +
> +	/* Meta key unlock */
> +	{ KE_IGNORE, 0xe001, { KEY_RIGHTMETA } },
> +
>   	/* Key code is followed by brightness level */
>   	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
>   	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },


