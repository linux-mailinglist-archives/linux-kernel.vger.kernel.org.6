Return-Path: <linux-kernel+bounces-246512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB26492C2EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E291283CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F917B05D;
	Tue,  9 Jul 2024 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Z4+wRdFj"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2112.outbound.protection.outlook.com [40.107.237.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FD17B05C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547828; cv=fail; b=eL7xDicBrqEmRj/QHRwEx2m4xhO4E5V/oVhMdUxw1Lu3QgyAWARzSdv48Cx14M4Ife2Qh/SPUlONiwgSde0JC2IQspziw4OeN/0c4vlsllDxyjNGPER1z22rSDvNGZi8fthcxqKIOaBOGiVM5RMiKEhHU0ZrzHUlb5LVkKWqf6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547828; c=relaxed/simple;
	bh=SDQo3s+FsOqURe7H5nhiRvEfHCnG2iJtJxkHiXQm2NE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PpHuRvi89LjN/NlEe+KiCtXHHyzI7RhSkKMXSVCB4E0AGnRs/XzIumfGu7St63mX8nKiQzYVXSsj4oonjzx+Omb0idtSefPzqd5tWc4px/YZBQ4mXCo6cabmoOHjf66pKqHBrp0sSqlZu98k7w7mjoW1qmlB25CzS9Mllo7t5s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Z4+wRdFj; arc=fail smtp.client-ip=40.107.237.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls3QID5Dy5oiopKN/DCwKBhD2entkzRT+Zqu4GiC46o4EaWZ6EbCPLgfYBZ+xxYBEi8+TX0aZwG+/APVvLOT8qI/vur6l5O6VlDWFN3pFaxtAQushJ7y5Z8ShBJfN2ZPO8MVqHaJZzo7TYhhkkakUVLLsGzRTlDnQGLIg2h3J4FtmY+w9HPpUAqqUACnm0ua35t4NsXiM5t79NTDYA3L8VeEXzK9ZacOTbj8lfBtgAO9LXTUIl85lJ7sk/UNJx7xBYoRB/7Ms+ZxvOTChru+bQuVOIMtvbxlzJ4wjUk9Sp5Lpt47fHQEc6GRWnNtHE4XNzrKfoSKP6WdKMLP5qmLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WanFKFXq65bgmg4eXes1MilV5oHoJO/legzmK+DjslU=;
 b=h6t8Z/cZq9KDwtJR0Nnuuic+tgCsDBxWM7VAZuwvDfJ9G5uTmbyIoOBMi4ZC/BjInK2gBIYZAMJqeEuOq8xNeEj0dbjvql10kBtUhDXfB28yoWH83LEMETUXxx7y6fSmU8vT6J3sKaOG8KlCKnDR7z7QXy1TgF17Z/mJNAXOP7gAQBgAuvZMlPns6gWY/6B5Bu+gAvx9P+1/53S4hQZuH1QPL7PCKRa9KSyho0GuHrgQfSm1wMf0Z9FsYeE3lykxS4spu2I0vRDuRhX7jJw2yDrkZI7btoLn8zv9CygkX1F5XpYNOSbLHkGwbCimOW0+xgvjxGvF/R9YTjP7iijGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WanFKFXq65bgmg4eXes1MilV5oHoJO/legzmK+DjslU=;
 b=Z4+wRdFjtye6fsP33RZ7FNUzfoXA+7la3NQ/5eMPVqgIdITzs2fYMVCWO1kWNpS0lHEheM7MCWKt7M0WwwuQEjlLzqaNeP9CGBgXfYFu5AUgaUpeEaLRHcsEkRDduEB9B/WG27GTeYCHfl496bVsSy6X5JDGmIL2duGlVv0eQwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5471.prod.exchangelabs.com (2603:10b6:208:11b::13) by
 BN0PR01MB7024.prod.exchangelabs.com (2603:10b6:408:16f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Tue, 9 Jul 2024 17:56:59 +0000
Received: from MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80]) by MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80%7]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 17:56:59 +0000
Message-ID: <35f70ba6-5305-4268-b7ba-81545cacd83f@os.amperecomputing.com>
Date: Tue, 9 Jul 2024 10:56:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, will@kernel.org,
 anshuman.khandual@arm.com, david@redhat.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240626191830.3819324-1-yang@os.amperecomputing.com>
 <Zn7q3oL1AE8jdM-g@arm.com> <773c8be7-eb73-010c-acea-1c2fefd65b84@gentwo.org>
 <Zn7xs6OYZz4dyA8a@arm.com>
 <200c5d06-c551-4847-adaf-287750e6aac4@os.amperecomputing.com>
 <ZoMG6n4hQp5XMhUN@arm.com>
 <1689cd26-514a-4d72-a1bd-b67357aab3e0@os.amperecomputing.com>
 <ZoZzhf9gGQxADLFM@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZoZzhf9gGQxADLFM@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:a03:80::42) To MN2PR01MB5471.prod.exchangelabs.com
 (2603:10b6:208:11b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5471:EE_|BN0PR01MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4f6bcd-2a57-4515-5067-08dca04087a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVZvTkJlZGRndUJZQlAyMWFadEEzSDhUcm1OaXdLT2ROWjkrRDBXaWY5aUZu?=
 =?utf-8?B?TlJmU1ZSbzRYMzBwM2ppNklnN0xneXRkWGh2ZEJPWDRtamFzUEtCZTJLNGE4?=
 =?utf-8?B?eElvUGlNRU5KUlVDVzcrb2F3VTFNc21TT09OeEFWT09sNWM3dWNPRitQVkhU?=
 =?utf-8?B?L1JCbUZMeWVTOGw4NVZ6aDh2aDVkcXY4dG5VSEhSWEc0R0prU3VTZEt0djlw?=
 =?utf-8?B?eUlKZHdKckxhb1JrU3lqYldRWTFVVVV6cmQ3c05PSmk4YUZ4Wk1DWWpuellv?=
 =?utf-8?B?cTFEdTN6YmEyNVoraFpJRmhGNjh3b0ZQN2pHTnV1YWc4QVBXVUNNUG9UTkI4?=
 =?utf-8?B?OHJuai9Cb2tKbEhuUzYzQVVXWUF4WXpYOFhlc0xKR2psYy9nL0VNS1grdy9M?=
 =?utf-8?B?dHdsVER2QUQyS0tva1R0Q0VXZGVBeUQybFNRWmtWTldNZ2FyWTJrQStrc2U0?=
 =?utf-8?B?MmtvYnpOWmY0bW1yRzcrcVVMdTJmL3ZkL2V2TGVQdldzQituZ1Z3VWNiVEE5?=
 =?utf-8?B?dStZL290Z01YRVRONGt1S0w1WUNqRWZrb3Y4bGtPTW02bWpiSlBhUmlia043?=
 =?utf-8?B?VVNob0lRWkJpckJ1WklNaTkvU2VRMFo2bjU0cmowM2o5K0paSytBU3BTb0Jw?=
 =?utf-8?B?M0x4djJzNjF1MEx2M0FPU1NyNGcxczNhdk9jTGxyK1dPVWpCZFh0VTdyR0tZ?=
 =?utf-8?B?eEJ6cmxDbXVmb200Y1MxUGZNN1pJUVJCalJsc25ibTdrTlkwYitvSWhtQzBJ?=
 =?utf-8?B?UXF1a3JrOHNyenl6MHVFWkZRbnZ4MUJrVXNKeFNKMWRxUk9WTjN6L25JcGd0?=
 =?utf-8?B?NjZVdTBvRXJva3k5NnlGQ2FyMDdLQy9JM0JhQnROajNISytKUHUwMmpkdW5v?=
 =?utf-8?B?ZHEvYjVrdUc2UEMrUmVvV0IrVHREbGorNW9wNmdtVHR6dm5oOFJxWi9FcXM0?=
 =?utf-8?B?b0ZCOUVuVVFsd3ZYd1Y2cFhXbk1Pb1RRTXdVRktQZVV4Wmg4U0d5aVVOTlpo?=
 =?utf-8?B?eFlBRDVKYjBHSHo3bVFXSlFPa01COEhEZ1MxNEIwZFFaZUgrWUZWckptWDNo?=
 =?utf-8?B?ZnVlY0ZFQzVJNEhXaHB6Q2RkVEtCbjB4Nmx5ZzZUWS9HMmNGSWtwK0Z1NmlE?=
 =?utf-8?B?WWYvbE5IQVF2Rlc3YU05OXJzc1QwZzN1THhxdjV2SHBRbXNtK0U2cEk0aTdZ?=
 =?utf-8?B?WXNUc2RpdlRSaklHa1E2WC8xbmNPdGZ1THhMbWhKY2cvNW5qY1NMdlVlUHZ5?=
 =?utf-8?B?NGZFLzFUUjhnaTBibDdVKzVuQlBpWENLSGJLUVhXNTIxditIWmdLMEFmSmQ4?=
 =?utf-8?B?SkNyTXAyWDJBTk9WQzk0YlZWM2RNUHR6NXN5dEsvOGoxVHlBMzlxVEhlcmox?=
 =?utf-8?B?RE0wZ1lpQ3RHL1orYnBZTmhOVENtK09RTUk5R0VmYVZ5dEJ5aGs2aDQxTkdC?=
 =?utf-8?B?RFhkTHVsRzdhVXNrazFnWWxseTk1aUJkZ0lTaS9GYWFNNW1wNEhlL0NralVT?=
 =?utf-8?B?ZiticmFBK3c3cnZrZmVVRERoQ3hrcHVXUHd2cHgrcXZvQ0pkdHJpYzl4Mkgr?=
 =?utf-8?B?cndBeVRDNkNRbDhqcHc0ZzB6UWJpRWptdkd5b05DS1J3cTAzdG1zR0RyTy9D?=
 =?utf-8?B?RDhFZHNDYVFtNXVmRkNGSWJpdFhydDMvVlFmdFZFa1F5TnliR2JLbmpBck9Y?=
 =?utf-8?B?eWhrV2RORkJFUHlTWE40akV4aE9rOXJUU3dIeGNWaGNkdGM1ZTQ2L0xyeHoz?=
 =?utf-8?Q?zukqVYEn84qmDbI7dk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5471.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0d1anJ2bGs4MmNYZWpzbWxUenRwNjdHZFFjbllzZ25kTGl4SkdsMnA2U3B4?=
 =?utf-8?B?bjNuTWhma2RXQ2JhcnRTNUtzRnc0QTdWUzNnL3NJUzlpN01jdGVkTzRiUWZn?=
 =?utf-8?B?dUQ0UXN6NzhQSU9OWEEyNTJGSDd0bXpVeFFkZHU5bTdyZncyZ2Izcm41Rk10?=
 =?utf-8?B?SW95dkhFTGo2eUxrUGJjdkZ5WWdHRmM3TnB0VXBCUno3RFVPdVJrY1hwR21I?=
 =?utf-8?B?NThwdkhuZGJoNWxBZmVmS0g3bHpGajN5SXVZazBFUkpFejhwdmUxblgwd3hE?=
 =?utf-8?B?YkNjUmZQTDRWYVp6VEk1amdmeEJOb015VEdZWlRyYlJjT0RaaGkwZUZpRCtL?=
 =?utf-8?B?VllXZnl1dzRDUjVVZEZWem1PN0ZmTlJEN2YrcWJQbERreUp5ZmlWYkJpVFF3?=
 =?utf-8?B?aldqV3YwY0pKQjZGalpTaGxCREIzQytZdERGQnlLNlZYZ3l2Smo0VmhseTVp?=
 =?utf-8?B?S3NBSExuVGVrejNGak9DbEF2NlFxR2xtZEllM0tqVzdZa2d6N2syNkJ0WUV0?=
 =?utf-8?B?NncvazZlZXVYQklOeVBva2dNRGRkUHhEV3FxK1haUEJaeGNhbnhMWkFGS3M0?=
 =?utf-8?B?cGEzdVZpYkNTajUwT3llZ1duWTd3UnhKN1BvOXNwWXBrNCtuYURKM3h0Wmhr?=
 =?utf-8?B?NmR3UzNxVk41VFdhSUJYOVFid0laSGp1aFRhQmxjMXhXZUlSa0pyek1BaEcy?=
 =?utf-8?B?eUN0UzVscW8rSVBuWFpnajNtSHNESWVVb2tENlJsZmovZDkzTjRsakhFaTEx?=
 =?utf-8?B?Q0w3RlJQQUpsY0YzNzcvZFBiaDNSKzJ1SmpoVndQVUhFTTJaVU5URGt4LzE3?=
 =?utf-8?B?MkJjUUJzeFYvd1ZzaVlwTVRJU3o4Qm4xVit4SjhNdFFFMlkyZ2pCVTNYUGlZ?=
 =?utf-8?B?dGE0cHpSMTJ3QURqajhhYUI2VUNQMlVjQTZIR2NkQU5XNXhnRTd5K2FWdzJH?=
 =?utf-8?B?K3pyVVpHS21OR2U3NE5xOFdWNEtXOEllWHhiSm5jODhYQ2ZSRzdSb0pkZFA4?=
 =?utf-8?B?c0VqNGk3NWlrVjAzRXFKdVBtdHJZMHVIN2Z2RU9TckZQTVovRjFrSC93YUsz?=
 =?utf-8?B?SlF2UDNCUStoMVN5aGxxelRzWnExR0p6T2FNK3NxVDJiTVJuS3g5S3N2cTdl?=
 =?utf-8?B?SXgvSmdhd2pid1FucnpzRDFEYVp5T012ZnJCRHRESkx5SEdUcHFYZW5uOWdx?=
 =?utf-8?B?dFhrTE1ib2xBN0h0SGFtSVhlZ3hJNEhlSEt3SHlsa1hqS0p0OGYySWZNa0Jn?=
 =?utf-8?B?akNCbzAwRTllSXBzRDR4TTN0ZEtkMkdyZ0hla0lsaTBpM1dJSEMyNEZxeEd4?=
 =?utf-8?B?T0RoT0VmRCtXUmdqMWpOMCtHYk84YWhnN3pIM0Y1bHlCK2xFVXkxTWFNT0dl?=
 =?utf-8?B?UGhUSWxZMENtZFNObDRTVlVtbjBXZVBNZUZUWFIwNG5vdGdIRk1XVDMvajRE?=
 =?utf-8?B?eG9QdVZ5VEU3Wm95RjRNTzNiWmt2cDFsbGl4dlM5alNQdk1sa1J4T2xDYlo5?=
 =?utf-8?B?UGRnc0Z4NnZyc0lSb2JBOURRSVZOOFE1SWgvN21FOWZQMkZ5ZSt2eno3THZm?=
 =?utf-8?B?d2pVaE96K2djbmgwNmVhR0JwWlZSQ3kvMW1OalFaQXVuUUJXeXpsNHU5SzRr?=
 =?utf-8?B?c3RRZDFqVGNyR0FQNGtzdU1mU2h0WkZDVGNCbFFBdDFpNCtMSDdOL1IzTmNI?=
 =?utf-8?B?QmUvODEwSmxGS1cwckxsd0J1bDZpdEFpVDhKL0l3bVdZMm52a1k1eVZHaXNF?=
 =?utf-8?B?UUNMRmFLTkdUL25Sb2FTOEFBS004SjM2MTdTWUdJRm8wVjJoN25DRWVLYnZp?=
 =?utf-8?B?VWdxbzhPQy9kN1A4TmhwRkpSQ01LVVZMWTVJSGVGK0xoZEVpYzBwVFFITDUy?=
 =?utf-8?B?T014TUxXMlBMNEZLbVFzSFE4UXk4S1BWbjZBVXNXZ0xzWVdoTElJc0Y4YnhH?=
 =?utf-8?B?eGE5T2NtRnRVRkh0eFF0WWc3RWF5TE9pMXlsTElULzVBczJTL0dhbllsdS8r?=
 =?utf-8?B?V1k2RkxYbUliYmxmM1lReU1mZnZOcnJPd3B0amN1dFh1aCtHdjM3RXh0dHY5?=
 =?utf-8?B?dFhiUkl4OGRtYS9KTHVqM2FWMzZRSVFZclN1M3RtL01XdWd0U0hKUU9YSncx?=
 =?utf-8?B?aTVHak5CVGZRanI0SXI0V2ZXTS80YzNST0xUOWcxbElzblJXaytnNW9qSHhB?=
 =?utf-8?Q?XbUsN6qV2pNUjiqsErDx5xo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4f6bcd-2a57-4515-5067-08dca04087a5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5471.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:56:59.6383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjAaBSaBsIc+gXrbycPs1G/9crxaGH7YkYXvSPHsyRrtBqWdft2mw/XOa9qMrt/ALtHpyJmLTde3qBP7k5okETF9GFFbmD1HK+8kGgCHxT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7024



On 7/4/24 3:03 AM, Catalin Marinas wrote:
> On Tue, Jul 02, 2024 at 03:21:41PM -0700, Yang Shi wrote:
>> On 7/1/24 12:43 PM, Catalin Marinas wrote:
>>> I don't follow OpenJDK development but I heard that updates are dragging
>>> quite a lot. I can't tell whether people have picked up the
>>> atomic_add(0) feature and whether, by the time a kernel patch would make
>>> it into distros, they'd also move to the MADV_POPULATE_WRITE pattern.
>> As Christopher said there may be similar use of atomic in other
>> applications, so I don't worry too much about dead code problem IMHO.
>> OpenJDK is just the usecase that we know. There may be unknown unknowns. And
>> the distros typically backport patches from mainline kernel to their kernel
>> so there should be combos like old kernel + backported patch + old OpenJDK.
> That's a somewhat valid argument I heard internally as well. People tend
> to change or patch kernel versions more often than OpenJDK versions
> because of the risk of breaking their Java stack. But, arguably, one can
> backport the madvise() OpenJDK change since it seems to have other
> benefits on x86 as well.
>
>> AFAICT, the users do expect similar behavior as x86 (one fault instead of
>> two faults). Actually we noticed this problem due to a customer report.
> It's not a correctness problem, only a performance one. Big part of that
> could be mitigated by some adjustment to how THP pages are allocated on
> a write fault (though we'd still have an unnecessary read fault and some
> TLBI). See Ryan's sub-thread.

Yes, the TLBI is still sub-optimal and it is quite noticeable.

>
>>> There's a point (c) as well on the overhead of reading the faulting
>>> instruction. I hope that's negligible but I haven't measured it.
>> I think I showed benchmark data requested by Anshuman in the earlier email
>> discussion.
> Do you mean this:
>
> https://lore.kernel.org/r/328c4c86-96c8-4896-8b6d-94f2facdac9a@os.amperecomputing.com
>
> I haven't figured out what the +24% case is in there, it seems pretty
> large.

I think I ran the test much more iterations and I didn't see such 
outlier anymore.

 >> To rule out the worst case, I also ran the test 100 iterations with 
160 threads then compared the worst case:
 >>
 >>      N           Min           Max        Median Avg Stddev
 >>   100         34770         84979         65536 63537.7 10358.873
 >>   100         38077         87652         65536 63119.02 8792.7399

>
> What you haven't benchmarked (I think) is the case where the instruction
> is in an exec-only mapping. The subsequent instruction read will fault
> and it adds to the overhead. Currently exec-only mappings are not
> widespread but I heard some people planning to move in this direction as
> a default build configuration.

I tested exec-only on QEMU tcg, but I don't have a hardware supported 
EPAN. I don't think performance benchmark on QEMU tcg makes sense since 
it is quite slow, such small overhead is unlikely measurable on it.

>
> It could be worked around with a new flavour of get_user() that uses the
> non-T LDR instruction and the user mapping is readable by the kernel
> (that's the case with EPAN, prior to PIE and I think we can change this
> for PIE configurations as well). But it adds to the complexity of this
> patch when the kernel already offers a MADV_POPULATE_WRITE solution.
>


