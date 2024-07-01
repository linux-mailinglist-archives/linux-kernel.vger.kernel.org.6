Return-Path: <linux-kernel+bounces-236865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B898491E7F7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DA61C21C6A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751310F9;
	Mon,  1 Jul 2024 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CmaqYZPJ"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871529CEC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719859783; cv=fail; b=QNQ9QwzJR/Q4RUZXeHUvFxduxl8XIGwqpGe9TubqduXvGp8sNHbSMd24yBWSFefH0E3jdiVits/pE0IhsWjnnBYU1UGdp+wa1tsVr88vzLr15mqAw1mSmHSH5pP5O5eZ/6zFKjVei4loUcLQY+9LAHi9OCWPR0HPPRHnojd8QkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719859783; c=relaxed/simple;
	bh=IbpW0TasGmL0ya/uF2nRpA0vVFstEJjPoOVrYYh9mQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eNJoUHF8UN78EZs9Jix8/HcDWrOgM4H4P86R1kgmO80xEUVJuCFxTHebYvfh9tjb8/CtyPpHLRe7QbUOWlLRq6ymRjVDfDruXDyP4aNr8kw6Y452BsUw12eHveoRH7XQSGmpWMU3EGu4wpcwRCe7oGKWRLJnmydaGNtEoeaz3NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CmaqYZPJ; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMDyhvz1zZ/OaLSqISZWiqSpbt59uJKCrMcFPmXUc1HuvhIhPWVW30P+2/91XgYsz2TB20J2k88SuHKWBK9PGzITMX4ORgSSiPE9TXPhhqiQviPKUsbwlGkQPYLsJaSqK0K0qpgwU6eZHrXRipEdFcVKjOvizYvF6iwP5b5JIlZeypzLuY6ku61FKLotaMzjx7lxHRxGe9s2KjARz5Ns2IoANgyv7fSNXGyybWd2ZvFHg3NBAy0bq9rLmWwenAQmN1TVwMKPz4+P18KAfwEeGHPX+QCryWZ2CKAvU0qIXpDT6YHHuPm3mMCfajbYfAmjreAkvGWBbgyswyupdfAe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM3NzTINKqn9FR6FoV/tAMc5Gx+AEOMptNGLaqiTqlw=;
 b=ARlaoh0sjQ/ebp2Waq+ThhQ9PV3XjFaAzNr9DsPZisvgAoeU73BdVdQxVyWog6IPSQjJIefb+eTDLNk2FreXtJSqBvm+JMqBOB9ldVAXtphJ6n6z7qTdAdWBEhtvksLfGp6TetxVdPJ7+J/8ZPe9tUn+HwLmj+z22UDwfqkvBSHxC2T+if2f8WTTJbWZ2LPB+6ImTNtuoHXV7H3h1XAoqdVlY8FeeJwmurH0T6gsTgBTNEcFJoFXFhTNeBBeWGE5xl8vV+TM+iHK1jhbcnpll11wxcFY6TOBuLoLzD4vb+khFV5SMgvh3zoiTVrIMkQffA9Sog8OY5nIkBvzecKLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM3NzTINKqn9FR6FoV/tAMc5Gx+AEOMptNGLaqiTqlw=;
 b=CmaqYZPJWsD1SG6FRoIKoo5tVWKbvwwJOYNZaFxnVluB2K7FwGkI3ElX5AIqHhu+8mEJlxYE+1kqeXSO1qKexFGOMvBwhv4+OL2unCP+4CnNFA0Rey52nzLWtu0TodTJbVXJCh66iCau+vNtFheUzDBXflvu2CJpYBcpsPgQirc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 18:49:37 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%4]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 18:49:36 +0000
Message-ID: <fe0ecf26-e098-473d-a78b-58938a237bac@amd.com>
Date: Mon, 1 Jul 2024 11:49:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/53] pds_core: Simplify a create*_workqueue() call
To: Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, Shannon Nelson <shannon.nelson@amd.com>,
 Brett Creeley <brett.creeley@amd.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240630222904.627462-1-bvanassche@acm.org>
 <20240630222904.627462-24-bvanassche@acm.org>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240630222904.627462-24-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 454939ec-5c68-4f7f-b873-08dc99fe8e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1QwbFFxSVY3RzNGYXFDQmJoZXU0THQ2VUtLdWN5aCtUSG9BUUk1OVNReWRt?=
 =?utf-8?B?VWNXcGZtOWNKQ2IyUzdnMGR5MWEzancydWMwVnZuUFRhMm9HbnlrVGNpVFJE?=
 =?utf-8?B?QWNIWXd0VmhzOVpXQ2duYjFFTzRQUG5NNnVscU01OVJkT1BZQXIxWVFwT3oy?=
 =?utf-8?B?MVpvN1RObnZ2WmRLa3VackNaaHhIc2NCVEowUXdzL3c5ckppTkdWUEVOdHJH?=
 =?utf-8?B?enE1K2V5bWsyQUVqYUowMk55eHloN3JnZ0txSHlTdFBsSHpHWElaK0hjenB1?=
 =?utf-8?B?bkpMVERNTHdjQnU0czBRdmtLODZDWitwR2ErOVhRMGRpU0EyN0F0SW1WMFN5?=
 =?utf-8?B?VjJmUlVmc1lnd3lPR3RWaTV4MlhZZFd0YlJVVkRqcVpwRkJsZmxTaGpmTENI?=
 =?utf-8?B?RnFTVzFLMHR4TVZ5M2dxeHRWOVRhaWhDWlpCZVZaZG1JamI0N1B2WUxsQWUy?=
 =?utf-8?B?MzZoWkovcmc2QXlObG9SSklEYUdMRmxzZXM2SlloUDFmTlZwOHNuOEFiR3pD?=
 =?utf-8?B?TUl2OFVYNytlKzYzT1VkbXRFb1RFOERMbFF5UHhXSDR2MGNvMjdudDFFYU9Q?=
 =?utf-8?B?R2pnSTBKcnFMVU1Sb0hhdUVxb0Z4R20yeUNWYVNVUWVJbERhZGc2cUJkLzR4?=
 =?utf-8?B?NTdHUXhLSjBkOHJEQ0R6VE9JSDJGblc2bUt2NlM5Z1FQRmF1L1F6QmNISWpj?=
 =?utf-8?B?L3ErWVNYTHkxNitvT1RBYzVkTDdRWXBWSzdRY0Z1YmVscEpnSThzSWhqVWla?=
 =?utf-8?B?Tkt2MGdYR2kxWFIxWlpZRnhSNjZoQlA5MHFzWDhVNStPdVRQc1RMVkhVbFJs?=
 =?utf-8?B?WkVXMS96RFA0YnVDbGk3T1U5S1lQM3E2UXU0K2U3QVgwdjRYbHZDcWEyZ3Uz?=
 =?utf-8?B?Wml6Wi9YeHByUE9HellQcjFMWGczdTk4U1c0RCsyVTdadERrOVJ6c1hWVi82?=
 =?utf-8?B?RnNzSktvZkN4amRLdnlxeUYyTXM0aWJOZDEvcnBKL2ExNjgyWWFtaXZVOUdt?=
 =?utf-8?B?dUthV29sREkwK3lyYmsyMkU2dHNoNTdLVGdSdGMvMzFyNmhBd1N3T0FJVFJ0?=
 =?utf-8?B?VC9vYTVidldZRUE0cVhTRFJvdG5PdGVUTCtXUUszd1R1ZGl0bXlMbXlzZnd4?=
 =?utf-8?B?dmNrRngxQTNGdU9nUVhNYmhxVVU5MkxGalN1RDVDNkVveHlhajIrekRFOS92?=
 =?utf-8?B?YzV5V2RKR0NMZWRiZHcwRndQTXBPVWYyNFNjajlkckFUVmthVXNYNXhwcDhr?=
 =?utf-8?B?VDVGOUhPWDM5RHFveHQwTklQcHJVNXFCbzZjajlETVJmVVF3d2x2TjVEY3ow?=
 =?utf-8?B?MzBDQnhjajN2S3pxNlVnWUN3SkVMdUtlTHdpZWgxUUZjSDkzTTJsTk9XVC9a?=
 =?utf-8?B?eGVsN1hmUEt0K1Vpd2wxeURLS3g2V1JBWEJqNU9oRkVHcU5CakU1L1pWNUtn?=
 =?utf-8?B?UnRTWGdvR0dkZndUZTlxMmpPYncxRk8wZnkzaGd1OUo2REdVQ1pWRHNNZGRl?=
 =?utf-8?B?QmRQMXRuM290enZoY0JpdGprZkFTM2dHL2k1SWtCNHV6enp3S3BuU0c2a1kw?=
 =?utf-8?B?eXpVV1VJZUFvenNZLzRMbW1wTXhVeEhVM2RacUlyZmFYRnJoR0JxTEFra2E2?=
 =?utf-8?B?ZmxIeXRPa3RpRGNDeUQxaWIxeGFUalIzUGdZVGF1ZjVpQmFxQXErRGZxRnc3?=
 =?utf-8?B?WTk2ejNlMjRLN1NOd0hDK1djMTdTbkFOdlJva0pTWHRIZGl2a2JuSXFGeDkw?=
 =?utf-8?B?YkpOTm1DN21DcnZPeUlBd29lVG9WN2VpQU0wbENXd2RUWW9qaVhzY2Y2N1Ju?=
 =?utf-8?B?NlNzUDBkTDlXM2Rra2RYZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEFLeG8zR3d6QnNjcHV6enZVY2NHazNPK1ZVNWdxdW5vcWNFSXdDckJMTlBi?=
 =?utf-8?B?dHVPeVdDYVVSRzBBb1V2ZDVXRmQvY1BTcGxVRnNZeHRpT1lRdGJBNncrcjFz?=
 =?utf-8?B?NkMyV0VsL0o4VGxIdDc1QndkM2lNTlRBY0lxeEhPMldNRU55QTRlM3g5Rm9j?=
 =?utf-8?B?UUxsTXhROVhZckJLN0IrVm4vWW9TTmR2NmNERHF0bm4xWlFrQUNuSXJSbjJp?=
 =?utf-8?B?L0ZpbDNScWVuRHBZZGt1eW5ZNWQ0OWFkck1TMXRsb0JOWXZ2VTRqZ2Z2Q29n?=
 =?utf-8?B?UWgraUN6cWFMcTd0S2R3RVpocWtodVRRYmp0RFR5U0w2VW9OYUlmR0dLQWRK?=
 =?utf-8?B?Q0JyT20yMUFZbTlWQVRCK0tmVXZGNVlUQ1VXWFlHRkYvd3FCV05KeGo4dEV4?=
 =?utf-8?B?N2hJbnJQZ2lxUWFiK09KVlJselhheVQ3WE5KT3RjMGovZzhXZUd4OFFFdTBm?=
 =?utf-8?B?WEJIZDNwUUtOV0hYWklhT3YzczV6aDZuZWJ6ZU9oZ0Y5c3cyY09Xck9LV1pI?=
 =?utf-8?B?bExiNzJ0MnNQVWNMMCtiR01Hd3VvT1pXbmdxZCtPaTRZNWJwczdzS3l6L2p4?=
 =?utf-8?B?SHFPMmRxcmMvaXZ5azBMbGxudDdWVUszb29zM0tUMUhjYVFxcjlWMVlYbFlD?=
 =?utf-8?B?T1NCOHBOekFlaUhQQ2Y1OUNndUUrS1g3UHNPS0hpUVRoSStYaERoVFFWNFFB?=
 =?utf-8?B?b25QOHJPOVRuL3VsUklrdk1hUHFRMWExMzk3L242Y0FjR2F0Z1VtNWdUWFNY?=
 =?utf-8?B?Rk02NVc2MzRzVkN2eWMxSEJySjE5aTZzOWoxNTZNVHJGVEJ0ZHRmblZrSDdO?=
 =?utf-8?B?QW1FVnVLWmt2bmgyRlZKRnpNSXIrWDRpS3lDVmFqaVBQVnhjWE1JSmtBenBU?=
 =?utf-8?B?UUlqRzhSUVNtbXdjdUt0QXhlMWdDM0pVQ2hjR2luNUFtdU5xclJGOGxIM2Jk?=
 =?utf-8?B?eC9BTTdmOWdrYVROcEU2QXBTRDdUUFoxYWpnUmNQK3YvdmZEMlZqNVlaU3Bk?=
 =?utf-8?B?UnFkMURjZjZUSUI5UlJrb2crZTdqUDBLMndtTm1Ba1h1UHBrZlpsc2tMMGxs?=
 =?utf-8?B?RU1NZUt0bzRLQjNmaVFqZ3BnZFJWdUtWb0wzTG9pR2xubFhER256Z3dabU5U?=
 =?utf-8?B?VHEzc0xJOUczdWFXZGhRQ2JNNHgzd3ZwZ0pXZEhxUVNQK2VORTR2cVhRSFcy?=
 =?utf-8?B?c0JEam5tVHBVeDE0L2xnZG9XV0pzVWJKV09XamhHS3FaeVpkMXFFdUdPd0l0?=
 =?utf-8?B?V1FSM3hyZytJME1qSDB5QWNqT29RZUZ5elFFQ1V1Uk8ybEJZVFFDWlZ2SjdX?=
 =?utf-8?B?TGxDN1Z0TUlPSXZXVFZOYU91NVZRTVkxMjlMaHlZbkpQR252YW9GdXNkMklL?=
 =?utf-8?B?TWYvY1orWTd2T0w4TnpFVitwam5GeURwN2xXbGhNWjJvNGNRdm5SQzB5R3N1?=
 =?utf-8?B?N2wwdUlRYStwNHhKWFd2dXJiOVQyWkFaU3Exd1p4amxQQndDa0VkdVB4a3JX?=
 =?utf-8?B?RUI3cHBZZS90VjJhOHNKZWhROEJDVnJDYVZteFVzMDVNajVHYkNEOHFEcGFC?=
 =?utf-8?B?R0pXWWxEN2srQU0xWm0yMHlZYnYycHZ5akVLNWtCQnZkdFZYNzdGbGN0SHpz?=
 =?utf-8?B?aVlKZFFCWlNkYkVra05mZWxHWEVYa1ppVER2SjRGV1RIOEt4SjhhMk1jZGxC?=
 =?utf-8?B?bTBNMmdTaXRoMkdJQlhydFdPUlRPYUQ4QjhnQ21ONUFsOEkzckVrRkVwSVB1?=
 =?utf-8?B?VTN3RFhkVVRGT2taTEhHcXZ1cVA1cWpwNlZjLzk3U0ZRaGNkSXJEc2pJWWFY?=
 =?utf-8?B?Q2NvaUl6TktXK1RpbWltRWFoNGxzMzNsYUNhdjFaMkYyZFBFUmJhbkRYSXVU?=
 =?utf-8?B?T2VQaGZmWnVVeFlEQ0xNK0NqSzdJNE5MSG8zeEVyVWw0Q0ZncEt0TUltN3ho?=
 =?utf-8?B?VDJDdDZ6TDBOUjlsOGY5eVA1TnRTRGMyY0wxS1VhMElaN0xNczBodjd6T0N3?=
 =?utf-8?B?TWFRcmlVZytEdVBGMHh5ZmE1SEVRRTlsUUtzNGQxbXdtc1pBN01BdHBkUGI0?=
 =?utf-8?B?Wldia2NPV1V5ckZtYUxPQWtTb3NZZDFhTmRlTVYvWm92aGVuSkx2ZU45bHdH?=
 =?utf-8?Q?IgB6SY+l6W5d6FEfZJs15VtOd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454939ec-5c68-4f7f-b873-08dc99fe8e1e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 18:49:36.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVg6t3WyZec7xG1b6bL+65BpXHmuIE1zlQwvGAV97W2T+thHp6Cz2AyV0Wfh0CI+Ycl8DTbdZQXdu8I+UdlGMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071



On 6/30/2024 3:26 PM, Bart Van Assche wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Pass a format string to create*_workqueue2() instead of formatting the
> workqueue name before create*_workqueue() is called.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/net/ethernet/amd/pds_core/main.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 660268ff9562..e2e49656c111 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -213,12 +213,9 @@ static const struct devlink_param pdsc_dl_params[] = {
>                                pdsc_dl_enable_validate),
>   };
> 
> -#define PDSC_WQ_NAME_LEN 24
> -
>   static int pdsc_init_pf(struct pdsc *pdsc)
>   {
>          struct devlink_health_reporter *hr;
> -       char wq_name[PDSC_WQ_NAME_LEN];
>          struct devlink *dl;
>          int err;
> 
> @@ -236,8 +233,8 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>                  goto err_out_release_regions;
> 
>          /* General workqueue and timer, but don't start timer yet */
> -       snprintf(wq_name, sizeof(wq_name), "%s.%d", PDS_CORE_DRV_NAME, pdsc->uid);
> -       pdsc->wq = create_singlethread_workqueue(wq_name);
> +       pdsc->wq = create_singlethread_workqueue2("%s.%d", PDS_CORE_DRV_NAME,
> +                                                 pdsc->uid);

LGTM. Thanks.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>

BTW, I don't actually see patch 53/53 that renames *workqueue2() -> 
*workqueue(). Am I missing something here? It's mentioned in the cover 
letter, but I don't see it on the series thread.

Brett

>          INIT_WORK(&pdsc->health_work, pdsc_health_thread);
>          INIT_WORK(&pdsc->pci_reset_work, pdsc_pci_reset_thread);
>          timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);

