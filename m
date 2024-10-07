Return-Path: <linux-kernel+bounces-352739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60199238F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 06:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 590C9B21D69
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 04:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D358210;
	Mon,  7 Oct 2024 04:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A+IRqNbw"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E412B64;
	Mon,  7 Oct 2024 04:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274934; cv=fail; b=mYxAeMEM3k6BZM4YcyQnBeI5CAlVhdQvBviK89c2s3jZUut+/rv0wKxpSedCcvgYVtiMSmYZOyvPj6PQ4AbaatA+/6m/3lyw+Iv54qw9fOHWRq4r5YIHjtr5/B9q/wVHWtw6vQcKpng/RAuW6BrgQPaxNlzG9CtT5VwL2NkkMxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274934; c=relaxed/simple;
	bh=U/TdnHdwAcdwwTeRPgO1WwVH9ed54irb0OPHdYeu6eE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aRqWtj/T3HK9pZRuZ2tG7yE7kcovDuUjDBhG1FDMIHp+sYDnK8ICGMNz1wk14gP4DliZeL2WkSxjxofLEGcWkR+CSzvM6YtacHxSko95Y046j+Vlwdn8k/0r5t+VqAiHLNXLATGyAxIuB9WVV2B5Rn1l4/nIKuRXRRS5Dny4pQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A+IRqNbw; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYYr0kzInyQhRKq+j5QYULgq79XtyPVColyEmjusYqyaWkl0VHMR/6p+HpSYW0Ro7EC65jlMgPzpDMtkSqdvomss6uZQWtLkPSXruqvFKUMh0PeS1FLcTEnzPxbHhU9c3XkGd+1JwKuTBamVaxHsS05BWpeDJ7jw8EAdYWhN1CD4Mdnq4vntnJ4ORbL+vcfeXdlxjmtrIVG4rYl0ktzINa5EiWZ8RLGDVY+le5z329kqbIYuijvuzYKgkp0gq6gPu+hKyvWMIwriRvqH14ik/YMf4M62UBclw7Ycp5w6wkrcJamiodWMF51G/1+BQzYffi+jVkMH8ir/JgMDiP5hxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxQBYo3exzPFpf6lDlrUc9C+7QRkztAgM2vMJnzaY/M=;
 b=A33Cw2JNzV6RLAY2WbZrLoErjRlOpwKrpXfilZ28UcyCi1DbxnYXJSNFoL5P9VYYpXGVA3c4eURZmCASQFVjENficPtPw21RImdnNAEBOt7OYgw9ZSTcfq6V6lsYeMbVn5bEuMAvO/KdEfaixXL3q1HB4yvMjytr+hNJclaoDiB40IyjFUW9oW+B82D/cBhoYtRTt/AYu3ObdrXwo4B0ag0D1duhp3hMBTbhlfX0Q7/nmEiizxmUwZKpIcPJJtXh5u9upHz9BTmvesHXM8WoL9D9dh5/jOYoLl+QQ7H89Y7VQiXuabbKz8AQZHWXi/MN8jf6gn4s/YcHHtJ7sAQNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxQBYo3exzPFpf6lDlrUc9C+7QRkztAgM2vMJnzaY/M=;
 b=A+IRqNbwS7VWZdGw54wmuQLhoVWXPI6OxMp+YNvRjNtOEFdXnWgDrw9Z6jGtS07sn1HUjLuUtD/2OyNh93XGHaxl6nDUnlRHt9GgMOCz9SfAIrXUOCuKcA85f/aRU2AhK5gIqcuN+AkI7UFeLpZk77bOOQKL9xPGnKJI/SXW6Pt7Pm++rFjoFCq0JgsGyKgI045ex1x8vazhHb6nIK3E0GJNJyDsmUSOTp3wdkNqou07KxmKWTeS2rghDgYzmLLcTxzF6I/urtYecQAJu7mV85vCkbjsxIBU2uGrFFREdOhqp/jqRB5Cm7ixR9WQUQB8LLWP457k1tB53RLLAbq/fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by PH7PR12MB7378.namprd12.prod.outlook.com (2603:10b6:510:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 04:22:09 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 04:22:08 +0000
Message-ID: <f6b62a45-c44f-492f-8f79-96b4fd54555e@nvidia.com>
Date: Mon, 7 Oct 2024 12:22:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] platform/x86/hp: Avoid spurious wakeup on HP ProOne
 440
To: Hans de Goede <hdegoede@redhat.com>, ilpo.jarvinen@linux.intel.com,
 gregkh@linuxfoundation.org, jorge.lopez2@hp.com
Cc: acelan.kao@canonical.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240906053047.459036-1-kai.heng.feng@canonical.com>
 <87d40775-9bd4-4f22-81da-4e670236c15e@redhat.com>
Content-Language: en-US
From: Kai-Heng Feng <kaihengf@nvidia.com>
In-Reply-To: <87d40775-9bd4-4f22-81da-4e670236c15e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:4:91::15) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|PH7PR12MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c15b21-1f53-46d7-5828-08dce6879b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWhJd25HUlFEa3hMRGJmaWNjTlhqL1JJNEN2N3FHS05mcXRxMEdCVnI0NzYx?=
 =?utf-8?B?ZC9lbUV1dHpRdGZjNzFNb1EyUjU0dnlqbERVQlFha2Nmc2g1cXAvY0RmNmVS?=
 =?utf-8?B?S0ZxbjkwTkJiaDZFRXRnVXhYczRtK0p4NG1HNTVPbm9scy9OUkVOYTY1ay9Z?=
 =?utf-8?B?YzZ4eGFpK0IvN2ZEaU1Wck5hQzBvckV3Wnc4OTJxYXRTVUZZUERSWjVOZFNl?=
 =?utf-8?B?Vm03eThjczEyNWFPNnJqcFBJZHdMUWVXZytWN2hGZ2VlYit0MU90Uy9tRWlq?=
 =?utf-8?B?bE50UmNFQUg2RDRrVXJaTlhiekxNYXprcG5MdkhVSFdiZHkvUmQ0Tm50Q1Z3?=
 =?utf-8?B?UW1FTVYvdFVwOVFGMDFVYWh4RkpKTW9MYzRZYkxGd2l6cDB2NWwyMjBCL1lT?=
 =?utf-8?B?WlFyYmdRK2ozRG5Zc1VrenZWd1ZDRlRYZmRyWkVIaWZZY0xLbzNtZjF4bUIz?=
 =?utf-8?B?bDBQdnBTUjhjdGRRTlQwaDVLK01PUS9oSUpQQ3g2UkpOSlpwK3ptSkJHYnJQ?=
 =?utf-8?B?ZHk4ODNZL2V3ekhFVWZDZzgyQnJRUWcvYmd0NnIyZENtL2JGZTJ0c3hlWTZJ?=
 =?utf-8?B?azAwcmVDREg3c29Tems5WTloaGZKZUNVdWt0V1Awd2kzd2JPVzEvelRxaDBH?=
 =?utf-8?B?SVg2K0dkZ2laVFhjd3kvaHMxNzZKZU5ZMTNuY3BidlVPN1N4V1FlVFB6QXBV?=
 =?utf-8?B?OEhENzFhOHpOaTlwSjRYUWNZbS9kQlVMdnZtaDUyWGhwOXRJQ1UybG5rQkVr?=
 =?utf-8?B?RCt5dnRIWEg3SlUxSFlPZEZWcnUyVUtUU3k3WmZyNmwyeDJKSFRZaThTdkp4?=
 =?utf-8?B?RzFicGRlV3NxbUtuSDNjRnQ3a2g0dUhybkVqSzdCdlpUQk9BVGtJdEhiYU9E?=
 =?utf-8?B?YmdzRTNxZXc0MkY3aUZIaVc3RlRBaXBaRUp6SHZFa01yWXA5ajlITzk1VHlX?=
 =?utf-8?B?OXZTVDg2NDJyMjY2S0xDbm1MUmd6MlJZTTlDUXRlTUl0ZDhKb2RtUlhoNjZK?=
 =?utf-8?B?eW8ramhEUWIwQ3NMeXppeXZlL0RmMHMyVGtZWGNSVHJ0MTNFOGkxdS9jelhB?=
 =?utf-8?B?WVJWZVY5RDJFbXprczJmeVAyT1hJSlJ1NS9GTlBHYXF1ZjFVMFBmQ1JhNkJn?=
 =?utf-8?B?d2V0bWFUWnJvaUVrbk9vSVdrb2Y2eTcyS0NpTnBZZlhqN3RHbVpaRVdJQUNq?=
 =?utf-8?B?aklwSmtyanRDMFh5c3VzYmV1MlJndU1jUDNGc3ZNV2w3ZVlWNTJDMWVpWFVV?=
 =?utf-8?B?NFZnbGZsNTN6YVVJVlpPYUttMEhFT1djRHdsVEhXdXYyakYzOGRjS2gvSEd0?=
 =?utf-8?B?bDA0V0J2eEIvTTFZaFBIMG5aRWVYUTh5a29qclh2UHp3Z3VKZnZmTW9XR2hl?=
 =?utf-8?B?RG9XRHlJajR3cFBUMjdRcWdnQjZYQ0ZrckdzUzZVTEdPYWpKV0pYaFdkRC9h?=
 =?utf-8?B?VjBFYlZvbEpZcllLVkdWWW1YRFVFSFJGZ21xUzVUK3ZMREJ0a2lvZ3pjZ3Vl?=
 =?utf-8?B?YVNWZHg2NUNwWC9BU1N0eDlKZjRGTTRPdjBRbnJlWkxnZW93eGF2MWVaOTlw?=
 =?utf-8?B?d0JxUGZtOWRDckg4SDBpSEtsQmtwT090L0UrOXBWZ2dIN0RQalRRMnpmYnBo?=
 =?utf-8?B?K0NZQ21sM1JnQlRSb1EvZGNkRXV1MXFoUjZuVW9sRHVGZ0UxbTFVQ3pjWUwx?=
 =?utf-8?B?b1lILzA2dWMzUjBYUEt1blNMYmxEbzFFdGlkdlNNdVhXanlZRnEyVEVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEhYZm05RlBVekRZalQzUU16KzZaTVkxLzFjNUN1VlBkcEpkWWhxcXlwekhQ?=
 =?utf-8?B?YmJCc0ZNVFdsUDJ3OEhIMkozU0FjZzNtTUNVVUtUVlc2TFJxeHgzUWowSFZX?=
 =?utf-8?B?cjRCSzc0NXIyczBIL3FWeXczTmVHbFB1eis0TFR5WWtqeFkwdTFkSlh3K0RJ?=
 =?utf-8?B?WllPSk5PNGtQNGFnbmdBMFNzZ0p1aWxoOGdHRHVaTEJ6Q2c1clhGV0lsRjZs?=
 =?utf-8?B?MFBLakNYanJ6eEJCYU80Y1pvSTVrdDRYQjdjcWJoTXVnZGZobkFCVjk4SnRz?=
 =?utf-8?B?SHNSR3c3eCtzU29jQW5jUXdwMjVldng3by9idDdVNXBjaHBJNnExUHZTb1dH?=
 =?utf-8?B?RzdudTlMS3ZxNVNRU2hDenJOR1Y2Y0dEL2toampPeU01TjhXbHd5V3hhbUhy?=
 =?utf-8?B?KzVRTlFGNzVNUWlGRm9sbllQVnY0NktudkRRYlRzMnNXRTlaVjYvWlUyd2Yz?=
 =?utf-8?B?Y0tOeVNTa0h3TEVnaTdnZGZsVkpPN0xJODFucisxRXlnVWVuanIwYi92UVRP?=
 =?utf-8?B?WnRxRWIxeVV1WVVFb0lZWkY1RmRVNHQrYmNSTE9BRW81cUdCSzQxVSs4M091?=
 =?utf-8?B?R1dXUnBHTis2VndidU1WTmZZQnFrQitBemJKd2RieFlacktWbGRSRStJWVUr?=
 =?utf-8?B?VmhyVG9UeXN0ZEhTRXNpdXVmNy96NVl6S2o5aTFpRmtZVkpKOEVaZDczczgz?=
 =?utf-8?B?WWN5RGhTMmhYdFFleU4vTnFXbUJjWW9Namhza0VWWW9KS1cyWkxSNnFjTWpZ?=
 =?utf-8?B?a0NxVkM0bERZZ1FKWnN6UDBobGlwR1NKdzhyT05pTGJmVmlpbnorRUNIQ2hM?=
 =?utf-8?B?UWdHL2xWRWtYMlc1SG1wM2RXeWJ2ZzJzOVppdm9jbWVjOUVxUUNLSUN4eTBa?=
 =?utf-8?B?N29IOHN1ZnlzM0pQQTJYSXcwUldReFh2eGhJRVlWbGhnSThyN05mc2ZtVG41?=
 =?utf-8?B?Y2JLUnBUZzUrOHpjL3dicVlINXlzY2RKR3JtMEdZcGRQQWtqaFUrRGNmRHl1?=
 =?utf-8?B?czluRjlYckt5OU14eXhuTjl4NzE3ZHB3dmVKMFR5YlZpQkxkaDBSRnk3ck95?=
 =?utf-8?B?OUxFOU1Vall0b0NrNUx6Z29zaWRpY2Zhc1VYdlEyLy84R2lTemw5aFBkZGNn?=
 =?utf-8?B?clBEWjNwWno0c1U1ZGFjZjlKL2tYWG9oZW5OK3dHaHU0WktKeG5QTk5xcHVE?=
 =?utf-8?B?M2pNaUpXY3g4dUEyenhvenBNb0ZxVVJxOVVZTXEzdmdyZHZnQXE1emYrbDFo?=
 =?utf-8?B?a0F5bWxxek15Y2dXbVR0WTVPd2V3TzZXTWNEWjBBSHVrSy9aazlzZVAvdTQy?=
 =?utf-8?B?a3Q0YlZDZ3JFamZGdEdIZGM3Y3R3MXFHbElyZ1krOElBUWVKZkwzdlRPRmFn?=
 =?utf-8?B?eFFJZGVSMThicm9HSmJkd1l0eVB6UUtRQWQ5cXUzemduOUpFNHBsck03MURM?=
 =?utf-8?B?TUxtNDNPS1V5Y2tob3pKZExuTGtydGYxT1VlOHJBZ0NtNklYWDRLY2M0SzlO?=
 =?utf-8?B?ajhHM1BhQUJqdkpEUC8zNlF6bDZId0IyWjZjcEhRdnFaUGlpd3dyUUIyK05n?=
 =?utf-8?B?SjQ4UVVYLzVMRFVkcmRGYUx5VkdvQzVYZzlMcS9SQXRYaE1PcElzQngzTVBZ?=
 =?utf-8?B?RTc0M1hHTWxnbjlseVYrS2hnSU5jTFhSY2d4a3hnSko2SlNOUFA0bUNjM3lO?=
 =?utf-8?B?cXBFaldkakpQN3c0ZjZhWk91cjY5TllUN0JGdnZVTUMxTEdqSUF5TEYzMHI4?=
 =?utf-8?B?ZVNGc0hDT2RzZU9iQlNybWxoSWdLWm5OSUVEN0pkRWJpVWlHSnlvNEh4Sjlu?=
 =?utf-8?B?MXFuQnRzK21PUkNtdjJUalg4cHFEQ1o4NWNiYUd0QzdMM2htTURDZFZlYjJ2?=
 =?utf-8?B?UUpCZi9tT1NYcU04bUlYYnhTNUVRMUM5WG1KWG1WV3RpSUx1d1BSWjFiS1l5?=
 =?utf-8?B?dVh3ams2U3F6cVgwYkM5NUZPL0pjTGtoU2tNQlk1dkkzZjZ5M0VlUmVsc016?=
 =?utf-8?B?VXpuVU1aM0JwNUtGMU9CYjVqN0F4NjEvWWlCdENPbHpwU0xCeWxQNktJRlpP?=
 =?utf-8?B?M3JWVVZBOFFCT0MwRzNyUUJ1Wno3Q3dGUlM5YTZUcVFQbndoK1JRdHp6d2I1?=
 =?utf-8?Q?EUd2TIkHHaeu94s2N5g7f94Pq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c15b21-1f53-46d7-5828-08dce6879b9c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:22:08.8342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01VIqtO2ipkBxUkDD9uic6Qt7rGSAnU0j/T2rz4CjnNqLrQ1gGgTISXcwhx5OZR0fJAnbw8+wBXivZC84wdRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7378

Hi Hans,

On 2024/10/5 10:25 PM, Hans de Goede wrote:
> Hi Kai-Heng,
> 
> On 6-Sep-24 7:30 AM, Kai-Heng Feng wrote:
>> The HP ProOne 440 has a power saving design that when the display is
>> off, it also cuts the USB touchscreen device's power off.
>>
>> This can cause system early wakeup because cutting the power off the
>> touchscreen device creates a disconnect event and prevent the system
>> from suspending:
>> [  445.814574] hub 2-0:1.0: hub_suspend
>> [  445.814652] usb usb2: bus suspend, wakeup 0
>> [  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, portsc: 0x202a0
>> [  445.824639] xhci_hcd 0000:00:14.0: resume root hub
>> [  445.824651] xhci_hcd 0000:00:14.0: handle_port_status: starting usb1 port polling.
>> [  445.844039] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x20 returns -16
>> [  445.844058] xhci_hcd 0000:00:14.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x1c0 returns -16
>> [  445.844072] xhci_hcd 0000:00:14.0: PM: failed to suspend async: error -16
>> [  446.276101] PM: Some devices failed to suspend, or early wake event detected
>>
>> So add a quirk to make sure the following is happening:
>> 1. Let the i915 driver suspend first, to ensure the display is off so
>>     system also cuts the USB touchscreen's power.
>> 2. Wait a while to let the USB disconnect event fire and get handled.
>> 3. Since the disconnect event already happened, the xhci's suspend
>>     routine won't be interrupted anymore.
>>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> I was wondering if there is any progress in trying to come up with
> a more generic fix at the USB hub level for this as discussed in
> other emails in this thread ?

This patch fixes this issue and IMO quite generic:
https://lore.kernel.org/linux-usb/20240906030548.845115-1-duanchenghao@kylinos.cn/

> 
> Also have you seen this series:
> 
> [PATCH v2 0/5] acpi/x86: s2idle: move Display off/on calls outside suspend (fixes ROG Ally suspend)
> https://lore.kernel.org/platform-driver-x86/20240922172258.48435-1-lkml@antheas.dev/
> 
> ?
> 
> I wonder if that is relevant. If the touchscreen gets turned off when
> the GPU enters D3 then this will not help, but if it gets turned off
> by the system wide Display Off call as described in that series then
> that series + extending patch 3 to maybe also include the HP ProOne 440
> might be another (cleaner) way to fix this ?

The series won't help. The display was turned off when i915 turning off 
CRTCs, so it's much earlier than the LPI's Display Off.

If the the touchsreen is turned off by Display Off, then the issue 
shouldn't exist at all, as .suspend_noirq for xHCI is already called.

Kai-Heng

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
>> ---
>> v3:
>>   - Use dev_dbg() instead of dev_info().
>>
>> v2:
>>   - Remove the part that searching for the touchscreen device.
>>   - Wording.
>>
>>   drivers/platform/x86/hp/hp-wmi.c | 59 +++++++++++++++++++++++++++++++-
>>   1 file changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
>> index 876e0a97cee1..92cb02b50dfc 100644
>> --- a/drivers/platform/x86/hp/hp-wmi.c
>> +++ b/drivers/platform/x86/hp/hp-wmi.c
>> @@ -30,6 +30,8 @@
>>   #include <linux/rfkill.h>
>>   #include <linux/string.h>
>>   #include <linux/dmi.h>
>> +#include <linux/delay.h>
>> +#include <linux/pci.h>
>>   
>>   MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>>   MODULE_DESCRIPTION("HP laptop WMI driver");
>> @@ -1708,6 +1710,14 @@ static void __exit hp_wmi_bios_remove(struct platform_device *device)
>>   		platform_profile_remove();
>>   }
>>   
>> +static int hp_wmi_suspend_handler(struct device *device)
>> +{
>> +	/* Let the xhci have time to handle disconnect event */
>> +	msleep(200);
>> +
>> +	return 0;
>> +}
>> +
>>   static int hp_wmi_resume_handler(struct device *device)
>>   {
>>   	/*
>> @@ -1745,7 +1755,7 @@ static int hp_wmi_resume_handler(struct device *device)
>>   	return 0;
>>   }
>>   
>> -static const struct dev_pm_ops hp_wmi_pm_ops = {
>> +static struct dev_pm_ops hp_wmi_pm_ops = {
>>   	.resume  = hp_wmi_resume_handler,
>>   	.restore  = hp_wmi_resume_handler,
>>   };
>> @@ -1871,6 +1881,51 @@ static int hp_wmi_hwmon_init(void)
>>   	return 0;
>>   }
>>   
>> +static int lg_usb_touchscreen_quirk(const struct dmi_system_id *id)
>> +{
>> +	struct pci_dev *vga, *xhci;
>> +	struct device_link *vga_link, *xhci_link;
>> +
>> +	vga = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, NULL);
>> +
>> +	xhci = pci_get_class(PCI_CLASS_SERIAL_USB_XHCI, NULL);
>> +
>> +	if (vga && xhci) {
>> +		xhci_link = device_link_add(&hp_wmi_platform_dev->dev, &xhci->dev,
>> +				      DL_FLAG_STATELESS);
>> +		if (xhci_link)
>> +			dev_dbg(&hp_wmi_platform_dev->dev, "Suspend before %s\n",
>> +				 pci_name(xhci));
>> +		else
>> +			return 1;
>> +
>> +		vga_link = device_link_add(&vga->dev, &hp_wmi_platform_dev->dev,
>> +					   DL_FLAG_STATELESS);
>> +		if (vga_link)
>> +			dev_dbg(&hp_wmi_platform_dev->dev, "Suspend after %s\n",
>> +				 pci_name(vga));
>> +		else {
>> +			device_link_del(xhci_link);
>> +			return 1;
>> +		}
>> +	}
>> +
>> +	hp_wmi_pm_ops.suspend = hp_wmi_suspend_handler;
>> +
>> +	return 1;
>> +}
>> +
>> +static const struct dmi_system_id hp_wmi_quirk_table[] = {
>> +	{
>> +		.callback = lg_usb_touchscreen_quirk,
>> +		.matches = {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProOne 440 23.8 inch G9 All-in-One Desktop PC"),
>> +		},
>> +	},
>> +	{}
>> +};
>> +
>>   static int __init hp_wmi_init(void)
>>   {
>>   	int event_capable = wmi_has_guid(HPWMI_EVENT_GUID);
>> @@ -1909,6 +1964,8 @@ static int __init hp_wmi_init(void)
>>   			goto err_unregister_device;
>>   	}
>>   
>> +	dmi_check_system(hp_wmi_quirk_table);
>> +
>>   	return 0;
>>   
>>   err_unregister_device:
> 


