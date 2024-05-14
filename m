Return-Path: <linux-kernel+bounces-179095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C918C5BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C121C21BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9335E18130A;
	Tue, 14 May 2024 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zyaSaTxF"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1C180A9A;
	Tue, 14 May 2024 19:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715714133; cv=fail; b=nlRSGTMipGavt2glY2NO8WSN6b+DBaN+Trkof+fBXTdfeorn0oy7ORzw8+hIOWvYIxD1sOVzw7rD4+/1uud1TiWpvXGzdIrKsdKVqomDr2LhL+Cifjio2gqxeMHOk54AnTN0ZqJUjl0gk0r9cYHpHVrmdMqZp5RknvdjDrY3tNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715714133; c=relaxed/simple;
	bh=WUdOzAzB2vviTxLJInHWcv05T78yzIUEyMk4QPlGE40=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CxIaS3WMZP2ORD5+vH46A1Zgw31hDxLBrxYsgZIdpXtBkSC66/saCz0zKBb8VvesY5xhyT9C5XAJkL2yaTCZDeK7+g1S0rlhBLzP6ufuxzNZc4x+n7ZfFnQ+VQJGSxFqhRye7QgHe1akDoFt40JIeWxBjY1pkO6meHli5M0+Gk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zyaSaTxF; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3aMzY98+OVZzfcgav1lw6vmsXMBo7WYB1CBAGjnkQ2k0qofoQmZtQjqCLBx9W1VTFhJrc8J6FFCLia2rMR0702U3ATXa2pbEEkCe7EuSSl8LjWdZNCW8p693FC3JpF8RJLQNmcokKFtkjFj1+KL7gwNCnxKqpvpQiFJust06HYWL4uUiCWX4GkPNePJ8gJE8jIh80KS/l7AuNQ5HAACnq3sGPQEWddvvdgWl7c9VGfH5xKvZAu/BUMSnmvdCN3oiz6y0Rc/p8pyCH1h9OSzvvnIk2kOQnk9ENkC1sWOOsqrgP1xQ9OPGDH1ziDrQ38G/oVxnL7pA7+JZWDFGRUHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRUWybpvRPOh43U6T5h4pk5A+1qOE9YhE43DQTodQQw=;
 b=RiacPEApNNZz0k2/FvSIsnIehJYB8MmcNyw5tXodT00vMIMiQa2ZeAapQ/pT20Hz0SKmDfvqeIXIOeJi84wICDUN2DqhGGZkWXB5+YHKxaNg7Qp2ghun8dNqrdc4BOoL+pyq6M2wKvBqwLgj46vo93ZpCAgdyRt3SRuFswjkPsQnsTSRMwJydSZ0QQVqEuYIUdyULAPDUHu/EsbhG5KhDoCzbrsCNYAzeXoGOsBtjSUaudb3Wtl1bXVs1vCszeEl82F4pEEg/6GIw/6tcDTwii1Y08aQpcUZJUzChqRPw3A7yfAj+aOjcsqCwNkOG2oqeAAe0/fYTMf4tyFogFzaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRUWybpvRPOh43U6T5h4pk5A+1qOE9YhE43DQTodQQw=;
 b=zyaSaTxFz30Y2IHan4yubHaJzBS5zQNKI83RH45jd6NvnHbhz6qzBde9G/GFd8QGzbreglhgpivOKGFAPstY2gQBp/QdbNKfghrflcRsrzPMbi1zxLaT6o6TM+EKESH/OAVqywiIZhemo2ADkrkrJW9smV/QQrWYqfPwGrZb220=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 19:15:28 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::295:5055:c88b:cddd]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::295:5055:c88b:cddd%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 19:15:27 +0000
Message-ID: <8cf0d519-ae6c-4ed0-899e-899f67479052@amd.com>
Date: Wed, 15 May 2024 00:45:19 +0530
User-Agent: Mozilla Thunderbird
From: "Chatradhi, Naveen Krishna" <naveenkrishna.chatradhi@amd.com>
Subject: Re: [PATCH 2/2] sbrmi: Add support for APML protocols
To: Guenter Roeck <linux@roeck-us.net>,
 Naveen Krishna Chatradhi <nchatrad@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Akshay Gupta <Akshay.Gupta@amd.com>, arnd@arndb.de, lee@kernel.org,
 gregkh@linuxfoundation.org
References: <20240502220554.2768611-1-nchatrad@amd.com>
 <20240502220554.2768611-2-nchatrad@amd.com>
 <dd4ef0b6-8272-40b6-9a50-edbeec14d5e4@roeck-us.net>
Content-Language: en-US
In-Reply-To: <dd4ef0b6-8272-40b6-9a50-edbeec14d5e4@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::10) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b9883e-3937-4e60-2688-08dc744a36ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnExMHpxUUZxcFdrYm5aOTUxZU1tZUFnYUJMYnBwdnlIbzk5ZExkT0QvVnFr?=
 =?utf-8?B?K05BMmttN1dQODNGdHNERGNRL1hod2tqbWpBSzRoMFBvNHZuYjllLzE3OXBp?=
 =?utf-8?B?N2pKOHM3dEkweUE3NjhFRWRjQXExS2dDRUpKY0c3Q2UrSjl0UVRCWU1PeDhi?=
 =?utf-8?B?dkVvZ3hJaE9WQnMxT3FpakxHeGQwMWwybUZEQnpHRnY1YVBJSyt6UFV4Y08y?=
 =?utf-8?B?KzRMVEREdE4yZWY3MXBONXE5YVJJd1NFdnNNQXUzSnQvanNqc2pWaktad2dY?=
 =?utf-8?B?ZXk3VGFjcm1nRXp6TmNaYU4rVnVtbUR1aW1LOTErZ3h4NzNuYWU1aWRrcW5Q?=
 =?utf-8?B?OFZzOUhIQXVwSjQvM1kwNTJ2U2l1RG1hM3V2MUtVbXplcGJCRlVxYzBYMldG?=
 =?utf-8?B?d1JCbUUzY1FmdkZUVFJIVDNhaFVrdk4vQWlQdCtKckJPM0xtV2tKNkVBTUww?=
 =?utf-8?B?NCtkVkdUbUlOMERtR0VWUithbUNkYU1heGhNcHpNOHNsSlNxZGFWbG5WdWRZ?=
 =?utf-8?B?SnVLSGxrR1hUVExCSkxCSld2eWk2ZTVyNXltZVhuUzhnRURVMCt3RjY1YlVO?=
 =?utf-8?B?aXE0R09COHpoZkl2SzZBeVM3bTBKVS9kQjlKM1JTTVNmRExPRGVldGh3djlw?=
 =?utf-8?B?R0Z6YTZ6Uk5pYjNaVmFtRjFsZi9PTGZQMGszR25maUgvcGUwQXFYNHdYaFUr?=
 =?utf-8?B?WlY1QW15WWE0QUYwOHhuTEE1akVlQlBOemloNmovejFCajBSdVhYSTRLQUFx?=
 =?utf-8?B?aUZ6TEdnSjJxK2Y5c2c3eWpIV1JLb2NZUnBtdkhkdnRZSGtzbkJaYURtbkZO?=
 =?utf-8?B?VUUzSDdLcTVxYVJDSU5oRlc3U0tNVkw3WEZybExGUHpOMjM0OTZpcm1ZUml1?=
 =?utf-8?B?RGVFNXp4N1JrU1lzMlo1emc1QzdlcEhIT0pkeTFPRWJKM1QyNUxFM0hlOTVQ?=
 =?utf-8?B?NDZYYkl0RVo2cWNkVmVzT2g1cjFXYisvWnY0OElvenlzaGRodWpub1g0TmpT?=
 =?utf-8?B?Y0FZWHNlR05jaDdLcHpJRlp5UXZYUFVDWFdUV0kyV2k3alhaRXdOR0oxWWNH?=
 =?utf-8?B?YWVMVGVqQVdNanZHbjJuM2VySTU2SjNzdlJZM2tHMUNqa0lkZ2dpUXJGaTZQ?=
 =?utf-8?B?TDhWR1Jsb2VhdHp0RXduYnowMTM0em1CSzZielU2MGNrYk5BekJYVUd1cWs5?=
 =?utf-8?B?L21PWXBXM3BHZml5NG9RZ0JsUzlCVTZDNDVKR0orVHVUdmFpNWJlRE5mZFJj?=
 =?utf-8?B?bFRJeFlSVjRQNTFJRDI4OGk0U3pnUnlUM1FGaVpQVnZFUlgzVGErVEVCUkw0?=
 =?utf-8?B?YWxrMitaeXNvWkEzWHBPU3E5VzRieEhreDNza3dwaklDZTZpVVZ6SGdKOXJ2?=
 =?utf-8?B?eHhBeGNGc05wOFdRVGVZbW1JRncyWjVUY3FQS3VMWUtXTy92bTVnTkhobWpn?=
 =?utf-8?B?WmlEUVNPcGxBK1d1ZU9mYXA1bHJVdWw2Wk1mR1l3WG5XS0tFaTNmU2RmM2hQ?=
 =?utf-8?B?MTZ5dzFkVlo4WEl2QUhuTzBjVlBWU1ZaRVZCQ3hOQjMzdlFEZk1yLytUUmVx?=
 =?utf-8?B?YWRkcVhWdWduN3JqNDVoR05Ec05NNjJ0OTBHdGpFQ0NzZFprYVNRSHExbVIw?=
 =?utf-8?Q?JTclhNyB2Hj89S7fQiKaBR0oWsXgFfYuEEScoztHAMpY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3dkK2tUZUZOUE5FK25lWDJjNkdvM2NNZ0RoRHBXaE9kcStYSFJ6cndWZHlo?=
 =?utf-8?B?bW91SmxiOVBKUit6a3hVRzc1QVhiZ21jSVc2WWc0MDdrVUJqaXZWZERhWGs1?=
 =?utf-8?B?SWswZTRVb3VWZ3hCNm40SzdKQU02UlFZQUUvYmVxNmFjQlJRMDI4S1RyR0JR?=
 =?utf-8?B?MGR5bmhhNVpWT2hMeXEvVzlOd2JDK2IyNzlWRVlJRUxoaVVLbHFUZGR0bHpZ?=
 =?utf-8?B?dStIQzVOOU9pb2I0QkxmbkxjaHNxWkROQ3pWTDV5V1BYL04wTVpWNHhaWkdv?=
 =?utf-8?B?aWoyYVEzZVhkN1pDMkk0WlpodTVFMHhSNjEzZ2FYOCs3WXJjQ2JiYW1sNXhO?=
 =?utf-8?B?SmIyMUVscEhxa3RyaFlmb0pINTUzY2JIUi9BcTRrTG4rRXBqdVhsUkVpVjdn?=
 =?utf-8?B?VXA3UnFmYm9ET1l5RGxuUElHU09KMkJVNVBpSDdQYXJsOUdwYVF6U3ppQmNO?=
 =?utf-8?B?YlVIVEhONnNRRzcwd1g5eEdQcFVPdjNJdnR0N3lSQWVHUDNJeFRMUzhzbXpI?=
 =?utf-8?B?b0ZkT2kwR2Jmb1NSZ0NidTg0ZXJQZlh4T3c3SkZsMHdhMDVVSnhrMzgvSWhG?=
 =?utf-8?B?YTN3UTRUYzFwNVN3RHNYU0R6N3JGYnlLOWVMRTRIb1QvZEFOeEFKRWxnazJv?=
 =?utf-8?B?cVNqRTBxSG80OXRhRHhJYmkwYTI4bFpWYmRwRW9yNTFlalVoYUMzc1M3OWMy?=
 =?utf-8?B?TG40TkpjL0xxOERJSHVnTUU2azh2REdqOVVtcXdRNVpjYkoxc2M3ZXB3ODB6?=
 =?utf-8?B?aURnUE1qK29ibHdEbTdQVFJyY3JYb25tL3NEbGRQUVQ3eTVaVHFPelJTSGxH?=
 =?utf-8?B?bVRzV3gyc1FiZ2FaZHdhUGxEYVFtQWQ0ZWs1d3V6L3pmR3Fab1RtcUtsbTlU?=
 =?utf-8?B?SGl0Y01UanN6UFp4ekhRSllMMzZlMFVnd1JwUU9aKzJxTkxQRkVhUWFEdnBB?=
 =?utf-8?B?bVV2eWhYUUE1MTNQYlR5UlFTSjRkQzgxSWR5cTQ3QjZEbEVmYTVJOGp0c3Iw?=
 =?utf-8?B?VllabWk5TmtVaXFiZTdLOEJzMDhjak9Ta3BWSFZ3MTZBNW52ZHBWQVEzOXZ3?=
 =?utf-8?B?RmZBelVBVndselV2andhazhmcXQ2YnAvaWl1Qlh5ejJsRys2eUVUZTZncHE0?=
 =?utf-8?B?dHRBdWpNNFNoUjJJY09JbG5xM2xWYWVmOXE3Mm9EaVp2bHNuZks4bTZlK3RW?=
 =?utf-8?B?MHQ2UlE5OTZrb2hjUkwxTFRTZXZTakZtSEFHeDlYZ0JXVGdoK0Q2bzFqODJQ?=
 =?utf-8?B?QjBMSklaUjk5KzJTOVcwaWlmSTFzS3pDelhEQjl4cldFU3BYQ1dsdFFJNmh1?=
 =?utf-8?B?MU5SWWRkTExtTE04MnlSUFloSGl0S0tjRUJNbzlaQkg5MWMvbnZmbFNlckxp?=
 =?utf-8?B?WGJSQmVGNnl4NG4wN0kzQ2dCSFRKRW02WjNNZXBiSVlPRzMyZmdWMDNMSzhG?=
 =?utf-8?B?bkVLVW5WSHNQdUlzSWZqNWRCWXFjamVSSEt1UW1rQ09ESGZhdGxNZy9KTlpZ?=
 =?utf-8?B?dHAxM0hvN2xjOGVZWDVBZ1J2eW5IZGNjRTcybkowL2F2eWxrTldBbVdSWDdY?=
 =?utf-8?B?OEZuSnEyYzFxU0lLR3JtOWVpZitONHI2ckJVcEZEaC9NN3NqSGVhY2VlcjBz?=
 =?utf-8?B?cGFkVGdlVElrcndaN2FFaW1KN2dTTmdkeHhHQyt3cWVWWmdTdWF0aGxDMFhT?=
 =?utf-8?B?QWM2OWxvQU02YXM2K0NqdFhYV3BzdTFZU0lsSGFFV1lCR2VMb212eE5GV2gy?=
 =?utf-8?B?eFlScUVNZTg1OGV6MmJHTUl0MDQ3YVJHZWhRaWR1QkJlMHdnVWlpODR4TUpO?=
 =?utf-8?B?enZBYkdHaEZCTzdOK0tNeHhaTk1nbFpwWDl4TGI4Z1Y3T2x2bWQrSkdoaWl0?=
 =?utf-8?B?WmRUWGFpblI4bnc2NWtDYjRDeUNzalBubVhoQ3BSSWV3clhVVm00Mktha1Jo?=
 =?utf-8?B?YU5xdUdubmpCWWxrak1tSFc2UDgrbkdHQkJFY0Q2QjVEYlI2QmxaTWQwbkFy?=
 =?utf-8?B?WjM4V1k1YW1kM0Y4bE1panFxMUhxRHY5U1EvZmlSVnZSRVZWdGRLNzhmL1ZE?=
 =?utf-8?B?T3FjSGl0NmZjS3A3cWs3b3lxUlRJdnczY3RWcWFiMyszZXE2OUxGRTFaK1BC?=
 =?utf-8?Q?LzS/62ygYLQzHalGGb4l2qoHh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b9883e-3937-4e60-2688-08dc744a36ce
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 19:15:27.8670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBA6YFxOqJV4GUwaToD1pAcQAZnN5/iW3RzNb4yFLUdcBnKT5v9WPLXbNaCpQVFtFsZRE1Wlw2rgtVdsDrHkSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262

+ @Misc and @MFD maintainers in CC

Hi

On 5/3/2024 3:56 AM, Guenter Roeck wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
>
>
> On 5/2/24 15:05, Naveen Krishna Chatradhi wrote:
>> From: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
>>
>> The present sbrmi module only support reporting power. However, AMD data
>> center processors support various system management functionality
>> Out-of-band over Advanced Platform Management Link APML.
>>
>> Register a miscdevice, which creates a device /dev/sbrmiX with an IOCTL
>> interface for the user space to invoke the following protocols.
>>    - Mailbox read/write (already defined in sbrmi_mailbox_xfer())
>>    - CPUID read
>>    - MCAMSR read
>>
>
> This is not hardware monitoring functionality and would have to reside
> elsewhere, outside the hwmon subsystem.

I thought as much, please provide your opinion on the following approach.

Background: Present sbrmi under hwmon subsystem is probed as an i2c 
driver and reports power.

However, APML interface defines few other protocols to support OOB 
system management functionality.

As adding the core functionality of the APML interface in 
drivers/hwmon/sbrmi is not the correct approach.

We would like do the following

1. Move the i2c client probe, misc device registration and 
rmi_mailbox_xfer() function to a drivers/misc.

2. Add an MFD device with a cell, which probes the hwmon/sbrmi and 
continues to report power using the symbols exported by the misc/sbrmi.

3. Define an ioctl for user-space to access other system management 
functionality.

    a. The open-sourced https://github.com/amd/esmi_oob_library will 
continue to provide user space programmable API

Regards,

naveenk

>
> Guenter
>

