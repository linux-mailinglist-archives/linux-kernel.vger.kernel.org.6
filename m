Return-Path: <linux-kernel+bounces-292687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E29572FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F08D284780
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53355189903;
	Mon, 19 Aug 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oWr3Rghd"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241C18C327;
	Mon, 19 Aug 2024 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724091510; cv=fail; b=s1jRkWW0xdNPvlconEdDufK1jfa5bK3JKoUV9xtFTDnfyiIL78xpTNn1WpoNrGH+sh8x18pAFiMa1J6tn7v5slHcs7mG2Gfjnx0MN3mqUP8+s4VzyaL7zkM70Bn+uUu/nltruGFdfCYx8eCU3rGV8usrxw44RV7b1RJOekDnsU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724091510; c=relaxed/simple;
	bh=RMZAdCCTMZhiHU2Nlfdqzzae2k3m7Rl+DgE9ZVm3ccc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u8f72btEVASD2WXJUDprEfs5n1tK1PuIsECNc8vCypLaiO8QCZZ6oQeiZTnGSQhMPanHHUvrYAhogs/3xu9Xu9OLZAysLl4v5zV8Fq6foBf7DObX46xOOwwzbf8/AVZCxxCyVkfVE7SqNtKIrvWU4VI37mv0gvKcFPfbrf4APyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oWr3Rghd; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qI0aUoJGCEUwFB/Tvc2sf3x8HwzkVWnfwWh55IAUqGet+2ng24SbFDkBO69HwgtPp+37CaAlRpzspLqIqngtSLtqenKYblyc7txOKoB6fQzlzeQ0PRQKEmf0pdRCzuXLhBRtYWeiLYGtFt8hgRKeajNzQaQHufaMHHtZZo+iDxyeX4R8CKjZEj5B2UXyo+lQ0/xQiTMlRw/J01c4WSaPQMvzvtVXnLTQHx4R5UQgcjMYQioEjO25ylIxVBrYe8GIp6ennbeR6wFUlZFDqAWrOdn1Q6MV3PhkBgNA0UoyZVbAphZ9EM1JomZJXIZDqETQGF8Zv/D61x29wfJtF3nz4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUUXFk3DAYJNHtDIl7hvpJaKf220VONpi9x6hjXbJqU=;
 b=NFaNJdGtd7ykEj33uwnTgNlz7/gCC6oCHNNbegtP583Vb/YLRbc9UdZt8Nnix3XQ2qekkqhX3NbVMbCA5pnZBjUYjB8OGm84xIjR5uEQfPVw5rB7Yinby003ZjIg616uHTL2MnpdK/83ff+BE4t0zc54sOxefLu1r3JhRj5kT2bJc+ElfPLyIVDr3XezYaSxYt9skLNGJT255StORkKbg9b2vjheGepQJG/RPdFdKZOwv4wd6yMhEoDhF4X9fr7WWqrF/3a2XHP0rs+nltnz1nypaxm9x+0qL1Y/4V04YLeALpgebxS7L2v++x2ga+R5K5h+bXG1yp3+JzB5t+cZSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUUXFk3DAYJNHtDIl7hvpJaKf220VONpi9x6hjXbJqU=;
 b=oWr3RghdhWDqk/G/J0uo+7zx83MAI7WVjSffAb5uVdML8lMw/zifqAUQ5FXXwJPppfozyQRcUtOGarFeEzPDP/0kyI5ivHO4oDF5/DZms3kFjuadN5hFf1gXPNwykqMQ8Pi95+AngZUR9UADIm+qLG/lTuLVUW3RSW6wlxCLVyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 18:18:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 18:18:25 +0000
Message-ID: <16263da0-603a-44a5-b6be-58c66b8dd863@amd.com>
Date: Mon, 19 Aug 2024 13:18:21 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 20/22] x86/resctrl: Enable AMD ABMC feature by default
 when supported
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1722981659.git.babu.moger@amd.com>
 <1061a60166f2fdb508aaf2dd9163b2bab3705063.1722981659.git.babu.moger@amd.com>
 <ab979768-a98b-417b-b319-6f14da88b857@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ab979768-a98b-417b-b319-6f14da88b857@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CY8PR12MB7706:EE_
X-MS-Office365-Filtering-Correlation-Id: 059afcf4-664d-4bb3-d4f2-08dcc07b512a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzNNbzZ2YUFnYTB2UWxXSElmNlZMT1E5blhkSlNKbTBFZUYwMWgrMVNJUkRU?=
 =?utf-8?B?eEJZREdIWU5YOGszWm53bkE0WTliRTRYcTJCT0FUak9OcUFCRW9idXU4THdN?=
 =?utf-8?B?RE9aWTlLR3JrWHdFa1NCOHViZzdmUTFzY0dZREtOQXR2ZFhaQWRTdlFBbU9M?=
 =?utf-8?B?ZTFFcE4xQkJhVEg1SE85SmloR1A5KzR4MThCMjRjR3l3K05MTXd5SGVEOWRw?=
 =?utf-8?B?cGJGNlYzMGlGRWhsUHF1WXBiZzNmaisvek91U3BSOFFUM1NmZm92aUt2ME1I?=
 =?utf-8?B?ZklRNzl2ZkFPcnNwZWM1aXV1VCt3cmRtWlBVQS92bk50MEs5R1liWnNIa2ZS?=
 =?utf-8?B?YnRWbzFtMmFraGpYZmY1VEVONEUvaTRVcFUyQnFRa3VkblJHQzdpMmoyRkxP?=
 =?utf-8?B?Rm9LWVV2K0lwN2FRY3IrL2VVeUE3VVFHYzZHU3RvRzU4RUlTelJmKzMyT0FH?=
 =?utf-8?B?Q3BIUlgwell2dmlla29vdFBlNGNiVzJ3U0dTanM2NEh4N1JmOWx5U2lsVHNZ?=
 =?utf-8?B?TXlscTk1NEtTaXhQZ2Q4UElzdE01QXZNK0FSY0xSTjVKVU9jVENtTEMzelZP?=
 =?utf-8?B?dU5wbXFieU4zZmRXQ3RCWVhBeXlEc3p0dTRFc29ua2lPUTIvUU5wSFN1Tmpw?=
 =?utf-8?B?M0JaV2ZXR0dKTjZ6cGkyZ3VRMDZZZ0xOS0xibHhobklrNnhZY2tiZDlwMGNv?=
 =?utf-8?B?NS9hYTZaUjhSZW1Vb0k3eEtQOU1qYmtUU21KUDdhWXdCbStCam1CNEtRd1Qz?=
 =?utf-8?B?Z2dBTXNvN244MlE4Q2M0dzdOWEx0STYvMFRqU050UTFsWW1UOFB4VkUzaTFT?=
 =?utf-8?B?L1M2akhPbXpPaXlzdEVodzZ1NHFOT2tVQnpyU0hHalN3OUV3NGtoTnY3enlx?=
 =?utf-8?B?cFM5V1VOYi9ZTnpOQjh5bTc4SENxanUxa0lYWVdIVUZJblc2YUpuKzBralBV?=
 =?utf-8?B?KzljR3U3Q3A3TWkrZW5XUFU5TE5PdjBkQmtZcE9ZMG9BNDhCNTRYMU9xRkVj?=
 =?utf-8?B?cGd6U2hHd1Z6Nkp5TlIreVVJbHFyMzIxdWhFUzdQRXFOZ1FWak9YcnJqNnND?=
 =?utf-8?B?WUFNSHorWkNLcUFDSGFmckszL2puMitMeTZlQUphY2FKY2dFcVI4YitqV2hJ?=
 =?utf-8?B?T3JZQ2dLcGExQUpiV0pUTk00cEdwRXVMbFNRNnBsQmFmdnVuVG9oNFZOclVV?=
 =?utf-8?B?M0VEWUwxNm13cVlVL3lsYUlJMEJwYVhoVTZVNDdPNVZnUUtMSFdBdDhaZXlX?=
 =?utf-8?B?RVgrWlkyV2FDMGl3VlFraGFHT2dGSG9HdjQwdzNzQTlHRlVaQ1ZxYkIrRXJk?=
 =?utf-8?B?dXhaZTBaL2lWNGtjbUxTWU92RTFxaGhVNXpPeHdzR3RaUERuYlphaFRDZU5z?=
 =?utf-8?B?SVlDR1BpSjlVd2hKbURYbEtQeDI3YjQ4eklQNEw3WWR2emljRUFOWEpGMkha?=
 =?utf-8?B?MWNUY3orMytaelN4TWdwY1huc0F3K0hENUtXRFNjT3cvZWZES25MeDFKbVdY?=
 =?utf-8?B?WWNOdTRIY1NKVERzSTM4M1BSa1ZnV0VNakt5N29KSndGTERJVjZiN2RWQWdt?=
 =?utf-8?B?SW02ckR4d0Q3T0JwVXJiMjk3OWtpVUtFNTJXeTA0MmRBeDE0SlBBVXk1Y2py?=
 =?utf-8?B?M0Q1MDdocjVTQ0F5NHpZSnZmS3NtemxjTDY2OXBZSkZCUXJtcFRtSXN3ZE9Q?=
 =?utf-8?B?eEVDNTJrM0YzdVhqSWcxR0xQUnBZMGN2OGFFNmdycFgwdkNIZTFTQ2Qxdi9w?=
 =?utf-8?Q?yLfZ5c26YQHvv+p8aQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3pVdGdmaUEyYk5VWE55VkJaRG1EQmRvSWpKamxYQW8weGVWV1h2T0l3cm9U?=
 =?utf-8?B?ZnVnNmFOd1lQeStEbVZXR0RxU2h6OVVvekp4MFNoODN4TElWWmw3cVQ4ckFU?=
 =?utf-8?B?Sk4wODdnenZnTERzeE50UkhBVm1oZmtlUldxRnNIQllWRjZQdGV5R3gzbnNJ?=
 =?utf-8?B?QUsranNTeU1NWmhjT0NBRXV0NktqbnFGWklCS1V3ODVWcVVHS2JqSGpkenlK?=
 =?utf-8?B?NzVFZUxFQmJuYmRmMnYwcjdwZVhsVS8vK3VKc2RHTWFxT2h2dG4xYXBtV2cv?=
 =?utf-8?B?YVBjajhFdWovdUpLYVhyNlJLR3ZsTGlDUVNXZTlrRDZaS2ZmRVo4ZWdqdGI0?=
 =?utf-8?B?ZkpEMzY0dEpFWVV5NU13SERRb0RKNHdnVW9mdzZZSllQSFZ2K292Y2kwSnV3?=
 =?utf-8?B?WFd1N0hQTlBXcHFiZzJSYXhDNlI4ZW44SWJZOFVYaDNZaGZWN043aHIvckhC?=
 =?utf-8?B?UzE3QzVMZjRRUk5lY2tSNW9LREd5OWY2bUZPUVAzckl0U0xoTXhMK2pEQnRF?=
 =?utf-8?B?eXpoMkVsak5nSlFIbVV3YUtpL0M4aWdXV3FrS0RnYjVlSlhwdzR1R1I1aEl3?=
 =?utf-8?B?OTN1U0V2b1RLWVdJRmZzY3d5dlNra29NcFBrU1RXQUN2SGZIcUFvaWdSVkhL?=
 =?utf-8?B?Nm1pZVRzRUJiMUR5cHMyUXBSTlpDYTlQUlcyTmhMTFc0R2VKK0xqLzdRNmZI?=
 =?utf-8?B?dExVT1V0cWpVM3huVEJFdFN1OEcrSHJITUFERDdmMHVZdWQ4V2tNWlJiR1J0?=
 =?utf-8?B?NW10WmhRa3l4ZlY3L0F1UEdoWkc0SmY4bFJyQXFLNG02L295MEUrWjgwL0Jr?=
 =?utf-8?B?OTNnNTNWWGt4NDErUnJob2ZkR1Vlb01UZnlOUW4zWXpNVE9aZWNUTXhBYzFy?=
 =?utf-8?B?VUVGTEllcXFSMmo0WUNja1JoQVlYTVkwalliZTVYOXQ2L3p3QmtTeHFEVGoz?=
 =?utf-8?B?a2IrVHg1SWQ2MThxNjFZdlk4RDdpMXA5eko4S1ovajN1RW9FdWZNbk00SE9C?=
 =?utf-8?B?cDRIVDNZNHNhK3EvdVhpellBT2xHRVoyM2tlTUJDeDNHYmRhTkFkT2dsVG9M?=
 =?utf-8?B?SGI0aldCLzZ3anJBV1N2dnVIL0RWMXo2VUlMQlB1L0ZJbkh3czVBemVBZHEx?=
 =?utf-8?B?YUZBY2ZQakZiRjlFWW4zVU5TSWppZzVxcDI5RmdNZ1V5L2t4RXdiMjd6R0RL?=
 =?utf-8?B?Z21aMFJhUGhyZFBWU1F4My9xWUUzUEIvYmo2SkZ3TnRNNGozQmpWc1h1Zk5y?=
 =?utf-8?B?SC9GZ0NjTUVMR2tzYjZYeHdpVENwcFJvTXhsa2NLSTRHMW1XWElHYjVidWtX?=
 =?utf-8?B?bDlVVTU0N050VDZ2ZFBEZDE0NnB4N3UzNWx3VysvVk42K3FEMEFKc0xqa1Ay?=
 =?utf-8?B?UnZ6c0dDWXFuU2NJVWFyUEc4c0kybzhZUDJMKy93S2xlV2JkVVNoZHFtWHB2?=
 =?utf-8?B?M2FFRDI2eEcvK3MvU2FlS2xTTmZmWHVVWU9VSGxmVmpBNjdXWG11N1NoMnRY?=
 =?utf-8?B?cVU3RU03RTJ2NHAzSnl1SHhHckpyTWxMSUtiVzA1N2U3TzUzbTcyU3R6QzNQ?=
 =?utf-8?B?R3NkT2FkWVhNaURkM0pqWWpjUGhwWThCNjNwVDNuT0tGWi9zK3Axa3dWeUI0?=
 =?utf-8?B?eTN6M0drSXUraGI2OGIwREt0dU9aL3MyVUZ4bmRYSVBQdmhOYUtCV1NuZkxY?=
 =?utf-8?B?dzNwOGRyMm9aR052VDA3WVZNblZNdC9YOVdrem1ZMnBTTW9VSlREZElzSVNN?=
 =?utf-8?B?bWVjTERjVkhobHMwa3phcHIzZDJhb1JTR3pXdmVwOFZQNFQyY3BkNEZCOFUy?=
 =?utf-8?B?VTgrK3RVT0NiZFUvUW5XditEcnR3enZxTW1MV0pwNXhjK3dicm5UQU5mZ01R?=
 =?utf-8?B?WGxqWWRyeUFkRUpoOWREdk9nSVZkc2RKOW1ReXQydzV4NDlod0ZqdTlVZDRx?=
 =?utf-8?B?NTlIR0ZVTUlBK1ZxSTJ2MFpFbkVjYUVkeExtRU5kOWdpeUFRQWZaaWdVdDN2?=
 =?utf-8?B?UkFVSVlKOTlxMUk3ZEs0WFZhN3EvY3gzY2VHQkk0SzViVUsveDlqcWJZU0tV?=
 =?utf-8?B?WFNFQkx2MmlGNDMyY3ZNVVlvOVlCdHgxM2hMT0lXTWk2N0owZjY0VzNoeTcy?=
 =?utf-8?Q?NaQ8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059afcf4-664d-4bb3-d4f2-08dcc07b512a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 18:18:25.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VPmadwJlIBvoBvkQ+NbBP36nfRrcIxe6tvK0CdooAbZskvsprjM1p8qzS06GVqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706

Hi Reinette,

On 8/16/24 17:33, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/6/24 3:00 PM, Babu Moger wrote:
>> Enable ABMC by default when supported during the boot up.
>>
>> Users will not see any difference in the behavior when resctrl is
>> mounted. With automatic assignment everything will work as running
>> in the legacy monitor mode.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v6 : Keeping the default enablement in arch init code for now.
>>       This may need some discussion.
>>       Renamed resctrl_arch_configure_abmc to
>> resctrl_arch_mbm_cntr_assign_configure.
>>
>> v5: New patch to enable ABMC by default.
>> ---
>>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>   arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++++++++++++
>>   3 files changed, 20 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index 6fb0cfdb5529..a7980f84c487 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -599,6 +599,7 @@ static void domain_add_cpu_mon(int cpu, struct
>> rdt_resource *r)
>>           d = container_of(hdr, struct rdt_mon_domain, hdr);
>>             cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
>> +        resctrl_arch_mbm_cntr_assign_configure();
>>           return;
>>       }
>>   @@ -620,6 +621,7 @@ static void domain_add_cpu_mon(int cpu, struct
>> rdt_resource *r)
>>       arch_mon_domain_online(r, d);
>>         resctrl_mbm_evt_config_init(hw_dom);
>> +    resctrl_arch_mbm_cntr_assign_configure();
>>         if (arch_domain_mbm_alloc(r->mon.num_rmid, hw_dom)) {
>>           mon_domain_free(hw_dom);
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index cc832955b787..ba3012f8f940 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -685,6 +685,7 @@ int mbm_cntr_alloc(struct rdt_resource *r);
>>   void mbm_cntr_free(u32 cntr_id);
>>   void resctrl_mbm_evt_config_init(struct rdt_hw_mon_domain *hw_dom);
>>   unsigned int mon_event_config_index_get(u32 evtid);
>> +void resctrl_arch_mbm_cntr_assign_configure(void);
>>   int resctrl_arch_assign_cntr(struct rdt_mon_domain *d, enum
>> resctrl_event_id evtid,
>>                    u32 rmid, u32 cntr_id, u32 closid, bool assign);
>>   int rdtgroup_assign_cntr(struct rdtgroup *rdtgrp, enum
>> resctrl_event_id evtid);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 66febff2a3d3..d15fd1bde5f4 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2756,6 +2756,23 @@ void resctrl_arch_mbm_cntr_assign_disable(void)
>>       }
>>   }
>>   +void resctrl_arch_mbm_cntr_assign_configure(void)
>> +{
>> +    struct rdt_resource *r =
>> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>> +    struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
>> +    bool enable = true;
>> +
>> +    mutex_lock(&rdtgroup_mutex);
>> +
>> +    if (r->mon.mbm_cntr_assignable) {
>> +        if (!hw_res->mbm_cntr_assign_enabled)
>> +            hw_res->mbm_cntr_assign_enabled = true;
>> +        resctrl_abmc_set_one_amd(&enable);
> 
> Earlier changelogs mentioned that counters are reset when ABMC is enabled.
> How does that behave here when one CPU comes online? Consider the scenario
> where
> a system is booted without all CPUs online. ABMC is initially enabled on
> all online
> CPUs with this flow ... user space could start using resctrl fs and create
> monitor groups that start accumulating architectural state. If the remaining
> CPUs come online at this point and this snippet enables ABMC, would it reset
> all counters? Should the architectural state be cleared?

When new cpu comes online, it should inherit the abmc state which is set
already. it should not force it either way. In that case, it is not
required to reset the architectural state.

Responded to your earlier comment.
https://lore.kernel.org/lkml/0256b457-175d-4923-aa49-00e8e52b865b@amd.com/


> 
> Also, it still does not look right that the architecture decides the policy.
> Could this enabling be moved to resctrl_online_cpu() for resctrl fs to
> request architecture to enable assignable counters if it is supported?

Sure. Will move the resctrl_arch_mbm_cntr_assign_configure() here with
changes just to update the abmc state which is set during the init.


> 
>> +    }
>> +
>> +    mutex_unlock(&rdtgroup_mutex);
>> +}
>> +
>>   /*
>>    * We don't allow rdtgroup directories to be created anywhere
>>    * except the root directory. Thus when looking for the rdtgroup
> 
> Reinette
> 

-- 
Thanks
Babu Moger

