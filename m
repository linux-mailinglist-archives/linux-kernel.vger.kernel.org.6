Return-Path: <linux-kernel+bounces-202977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7738FD428
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BD52855D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9291D13A3E6;
	Wed,  5 Jun 2024 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ORWDp8LL"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2110.outbound.protection.outlook.com [40.107.102.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF85D107B6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608721; cv=fail; b=lMk3jey+f/ufTj4rFIZZ5kYVTCl4S7aAbmSjN8Rt8ZD/ESTJXJkZqEFIgsLgClYPB2fDzEFueD04/33hA4WN7UYz5WJBbBVE+P3cEbx8CXGYgWrH5ZqVlCA47nx6Q6lzAqG/65Ti2XlqNEZl2NClBfDX7xmV00L9Ym6ggyhGuxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608721; c=relaxed/simple;
	bh=XTZfaM1gFXx94wXZ4SgtLu7vy4twc/FXhzuT8fktihQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nmvvnIepgdQjktIJb0KUMMFdMExn3thRpxacjbIj7s65G03E3OhUBADORQ156BI6/FruRjmU+aq/j5h3MAm7dvmFzelarxRCudo4blgQyBb7df4pDFTlwYdFHSSAtqZeDKtAEPZyjWbGUSyctAX+jDxvpns3xp0qQfTtEfMBXCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ORWDp8LL; arc=fail smtp.client-ip=40.107.102.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhJ3eJpzfw3mhRBzU2yQnzArLU8DvrKBVeaQnLwXUdiGAAovjY9u1qszIxPcHMWAbnyu4wisIxCNkxGekuYL+6chnQ2uitoJ73xeO7cEuz6ncfaHP3qtjTFwRNrcbDPjBThfKV4lPpEPa3LDB6lSWzuQ5AfOGTZDVXhbG/bgFbR2iSCKxyageTxWdfDJecwB4N9WiaVRDRZ0Qoa/C6j9TvNuAFoI32Xv9zbcMov506Iq9hYGrLb1Xh3c1d2aLa1x+3xZtBrvWY7LB4xgBaQWY/AJ2m44ZUTQ5nX0zM7di57niaMmXIAVu3Dng3zvNo9aAPXkOSxLnLSlylYNzpp0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjklIz4JJqDvOkpCITvlI4mGdcBXuIBX7XBpZ7Ra+ck=;
 b=CfPlj6cQ/saOnPaoWG+lpF5QIcQb/kMOulNqH5psKPLhBEnFTa600lIxuVVwGxv/M2ZAeJRhrpxfIZK2rkC7bY/7y1k/OoIrVYaFTZQyEscwnUohfeN3wVinCVrC/ASF6PdME7u0gkg23tcr+UK/CvjVWX9F9q1BOw7Vec9qhks0yWKd9TFaIkZraXxKx7Tj9SawacZQ36F3jXGM5OGNeDP1HqtF7iW+gAzgXYH5OsRB/52wt1KmjpQrzw1WVgMEyQuvW/n2xa6Ih3ToqbDD/rrwrMuZwwsCraXAkQRV9xaUQQQkyY5cljd/1FQrs+o8l6bBJH+5l/qeRokRkSb+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjklIz4JJqDvOkpCITvlI4mGdcBXuIBX7XBpZ7Ra+ck=;
 b=ORWDp8LLf6rjV3vIJFsxLDCf2GKwI0kHHSNxLMJBaDiD1cZBEAb+4Yr9LOdyP8kQYkeqENx0a4yWxoWn8dyv6ceLAG2h/WGFWB9j4MOWlMsWSDvVfUpbOXWSrv+vtPoXnra/Jg1FIM9IGzLxxAoBnTSe/CnqZ3aq89f46bH3wuQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 BL1PR01MB7748.prod.exchangelabs.com (2603:10b6:208:39b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.22; Wed, 5 Jun 2024 17:31:55 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 17:31:54 +0000
Message-ID: <ee4d5664-a426-48d3-ad40-b33ac5f44a7f@os.amperecomputing.com>
Date: Wed, 5 Jun 2024 10:31:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, scott@os.amperecomputing.com,
 cl@gentwo.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240604171516.2361853-1-yang@os.amperecomputing.com>
 <ZmCYLvb_JlkCuc_u@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZmCYLvb_JlkCuc_u@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::10) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|BL1PR01MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e16f587-208e-4639-d1b2-08dc858564c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFVrQ0NZcDExRGhTR3djT2p5Rlp6Q25nVklCbXZDL1VqMWZZMEpxME04Vitl?=
 =?utf-8?B?K1FBYWV5NGtsMnlEZkc0RjFKMzdpZitjQkVKVEQvNHlOOVZSb1A5Nm1VV2U4?=
 =?utf-8?B?dk1nb0hrVEUxaGJIS0dlYzU2elJvMFozbnFXbGRod0FRRmwxNHFCTXZzSWw1?=
 =?utf-8?B?SUUwcDJzRzNBVkhJWXJDMHFtNUhnVzJBbVBBVjQ5bEl0MGlkeTNzVjlrcEdO?=
 =?utf-8?B?YVZaVHRkWGZab0JPeWhwazdLNWwzbHlCUjF5MllyMElyV3J4U1dWbC9tWUE0?=
 =?utf-8?B?V3pwVlFTdVlqc0RFVGlhdHVsNWhDUUJGMFQ5V2k4MEErelQ4OVp6bHBkSVJQ?=
 =?utf-8?B?Y2Q4Sy9DY0kzSmFyZkx0RVNmSGRYRjluc0daNzZKYStEWGFIdkNXYTYya05B?=
 =?utf-8?B?YTNaVytlL2FJUXZBeitabVlFR2cwVGxyeHo2dFJFa0pzalkwOTI4QlBZeDha?=
 =?utf-8?B?ZW13eEMxWGRFS0NzYXQ5QVFqL3o2VVZESjJQR2FwWHlDOWZVeUt5NnhwcE5y?=
 =?utf-8?B?bmYrQ2kvVWt4R2NxV3J4NFF2c0FKWGdQWWhtQkxVUVFaL0wxWXg5SmozSGZO?=
 =?utf-8?B?Ti9zeitnRFpmZHhWaGVTRU8yOFdmcEo4Y2QxYnczS0Z4U2hJUHpXaERxWW5W?=
 =?utf-8?B?QnA0QnptckZqOCszUWVPeW8vaVZjZkszaUJLUW1kNkQ2YmtmR1Job0VsUGZY?=
 =?utf-8?B?TS9KenJ2bkVyOHhUZ2l2bitUS1dLOGEzVlBjK2xGeVVnVjRsaTlvYXpoWnFv?=
 =?utf-8?B?eGxrNjN1dWlqaWtraW84QUxVcWsxN2RZNVRMazZhZWVrUXppZFlTWERWbnQx?=
 =?utf-8?B?MWlJUFdORjh3eEc3MHFYODBxWGxGeWNxNWF5TjlNMjhCK29ZWHFPeXhUSjIr?=
 =?utf-8?B?N2ZyTG85dDIrbUI2bEwyMkVHL1FKcDNUT3lGcTV1WWg3cE85MjNBdkgxeGNx?=
 =?utf-8?B?WjFyeXZyWXVVNkR2M1I4TVU3VzdJeTFidUExZk9yRFN2ZU1mc3p4Uk5HS0FL?=
 =?utf-8?B?cTdGSkNwVDhSOVhiVHFIaDFldXgwMSt2Q2FlQ2l3aUtPMEtVaE54akpHbzhp?=
 =?utf-8?B?T1ZLUHRYL0lvaXdtY25LdWlWMHRmWW5CYWhJbktmWHpBeUhvNkMvRUg2dllj?=
 =?utf-8?B?U3ZQQWRhZHU3QXVyMjdNU0RBMWVWUlk4TVB1NlpjdjRlcmhkckNwbEVRUGZV?=
 =?utf-8?B?RDl0QlpEWjR1cUpsUHAvaThid1ZJbUxZMDlydVd2QXdYdzZMb1FGZzJpWEtu?=
 =?utf-8?B?YnVFNDZyVlFyRU10eVRMd3FQQ2lnMWRpcGp6U2MreFFPakdYSU95QTlmeCt4?=
 =?utf-8?B?UG5hejd2MndxM25TblRnVVRRM0dOYjNkemxXdWNySnJEYW45YTBTczNtNlpt?=
 =?utf-8?B?Tm5YSFRnLy9kNUFrbWxjSnBzTG5UdSt2SlVyUllFYloyZlYxbWZwb25WeDNp?=
 =?utf-8?B?RVkrUDZNbnVDbjNqYzA5blNqUzZQS2h5eHdwSFdUeFEwVXRVYjV0ZkkzN010?=
 =?utf-8?B?VTN2NlZFbklaQkxJYW1RSjdOTko5SUlEWUppMVZ0aks4bHdsbmFQS0lBY2Ro?=
 =?utf-8?B?ck4yZ2FmMWJLTkhLMWllMjRkeEdZKysrWkl2cm1sUjVqUWxaUlBhK2ljQURi?=
 =?utf-8?B?Tkp0Ym1xc21VRnBTTDd5L2NNZUtyLzU1NGhxMk5vQy9WQm5tK2duakpNVmgx?=
 =?utf-8?B?MkJWVHJqdW9xZG9kTGI4ZDVTUlEzK3dhRHBNYnZIWFhabTJiQkU4UFJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjRTSVZlNVV6SXp3eGNRRVVZMWt4Uzk5RG9WTWpxb2Q0NlFXb3JDWm5CN21s?=
 =?utf-8?B?MnZRUnc4UWZ5Q2oreGVrS1c3ckttK1d3bWJhWTlhQ1ZTUHlXcHFNanI3RC9N?=
 =?utf-8?B?ODJlenNuSUUzK0hXbDJoZm54K29oY0NPeVlQTGxtQnpxUkpPWjZkbkdXR01i?=
 =?utf-8?B?bncxZkVUNzVkWExlZkU4OTRLYTB1ZVFpR1BDQ0FIMmg2WU5qWjl1K2I1MHl1?=
 =?utf-8?B?M1ZLSjZWc1N1SFhGQUloMy9SQ000NVc1V2tWcHJFMmNTSkxhSC9lcFBYeEJX?=
 =?utf-8?B?UEFybnhsdDZRa0dJbTJIbUJNeVdZd3lqV2J6cFg4UDdmekJVcDFqdnhINkN4?=
 =?utf-8?B?amVOS2N3MzhkdHMweDBIZTE2aDJWbjBMV2YwbWRvSWFSZFBMUG5BcWVOT25T?=
 =?utf-8?B?aURjMVREQTYzdHpzVExnblNyUUI1VGlObHRGVWdrTkRCZTVxYWFXOUFCeXdT?=
 =?utf-8?B?WFdJdHNDV3RZSDhRd0Z5d0FTcGh2WG1mb0pLUFRrYmZrN0FnYXBmSDdHLzJo?=
 =?utf-8?B?c2M5eEc3ZDF6RmsvM1FnYnpKM01oT1lTWDRwc0MzRzkxbjRNeWdHYyt0RDZH?=
 =?utf-8?B?a29sa3FsMTZkdFpQRWV3V0xHam1VNWtqVzYvU3ZORkVjZmxneVEzTUlvNlhS?=
 =?utf-8?B?NjZWTGJzWlk5ZVBDRjVOZTJtaWt6elY1b1RwMlkyMzJaZkU0eFZlZ3VrT0Z5?=
 =?utf-8?B?WXd0a25uZWFIcFJxaHZQUVYyRTUveG53cDVYOVgyWGpNRFFnNm4rU1pRQjhW?=
 =?utf-8?B?ZFJCRTcvOHlsT2VkRFI2elJ1emVpdmhjTmZGcS9mSEdqNklndVF1eitkREdy?=
 =?utf-8?B?NkRvQ3VPc29Lb0FLa0NxY2Z0MVM0ZkdwSHZ4TDM5RVQ1Z0N4eFRrZys5QWdB?=
 =?utf-8?B?bTVmMGlPMGtvTTIvSDYrbWs5MXFwd1BVUnl5UUJZaU95YWpRbmMrSzgveWtF?=
 =?utf-8?B?QWUzdVd3WjRXcjdCVG5qOFl3T1Uwb1BXTUF1Q1JJc2J1YU5qYit1Wmp4ZXRP?=
 =?utf-8?B?U0ZpWVNmOTlsRHlmK08waEprYkxxVEZjWHN2MmpkT0dlRzdEbm9kR2c1aGJ5?=
 =?utf-8?B?a2FZWHhLd1JIdDI2TG41N0syaGdWMnZtY05UNktHQmxnU3FibzhhRGVvWmlx?=
 =?utf-8?B?TnVFdENZc00zdmVxMTQzTVhsSCthdy9MYjFjc3NBRHkwSExNVlF0OEJXQXRm?=
 =?utf-8?B?WU1Ka2JYRVNnNkJQVTNURzFpb1VvNEROMC9wUnFMVm55b2pPNnBhQ01FbEJv?=
 =?utf-8?B?MjZrbUtHNWZ1bGx0VFFJaldSVGRUanFZVklQUU5mU3N0bUpUVEwyekZ6SXIy?=
 =?utf-8?B?dFFYRHE3V3l2MkU0eFg1OXlLVzI1WHNjZllaY2g5TjhVaWJnZXhWK3RJRFJN?=
 =?utf-8?B?NWRpRXRMQVJraHp3SlFZTWVnQlljQ2o5LzBNT2tHQUsrdE9kUHNZSW0vei9E?=
 =?utf-8?B?RUZ0MUxTb05PWDBhejNUVFpuQ1ZOQ1dkbllleVpaVVFOWVF5U0luazRTYlJ3?=
 =?utf-8?B?dEFHcjFtdGFkclh5Y08zRWU1NXM5ODFIVDBBTzE1anZxYkVibER1OVRrVVY5?=
 =?utf-8?B?QzJRN1d4cFYrVkR6T2l6NGRXV2k4U1pFZXUrc0NCVExxNlFCdm9QK2VBa09D?=
 =?utf-8?B?LytocExpRjQ3VllSbUFWQzlqNzZSQ081K0tDVkd1WUZUYTBmRDJkbXRTc0Yz?=
 =?utf-8?B?Y0pmYjhGOUdBazF6TnBEYmxDQTlxb296eGNOc3J3cTVxc05KSlRwVmFPUmFI?=
 =?utf-8?B?cmowa3VZWU42NDI1cXZHSzVSTnFTQjNoN2VvUDEyazdGc1JVc2wxckZBRW9Q?=
 =?utf-8?B?VG5PSmtKNnNSRjdkYjlLVEI2NlRONHdzeVJscUsxNjdrclJGczlhSVZYbm9K?=
 =?utf-8?B?elByZzdWYVJYRjhEYmVNTkhiK3J6S2VDRjFYemt5YTNINnE5U2dFdkFzWHd3?=
 =?utf-8?B?WlNyZ21lZnFxL3ExVVdPU0pKSU53WWxoRE9leVV1b2RTMGs5MDFPWE9oK3E4?=
 =?utf-8?B?Z0lvNk8rbDFCSUlJR0xtSmVxUzc4QllTYzFhbXhka1h2Um80aEJXeCtUTXA2?=
 =?utf-8?B?WEw4bW5HNkZVSjR5cnBaTkpEQWVGaFJEemQ4REtsS2RVN1lMT2FSdFJzeEpr?=
 =?utf-8?B?cm1pL1ZrQWFjbU1BZEgrbWdwVys3MlRJVnEzRXhPci9XcHJxelJqUGFFU0VM?=
 =?utf-8?Q?oG6HuxJtT7LJToyHVgUKm8M=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e16f587-208e-4639-d1b2-08dc858564c9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 17:31:54.8877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UR2EE/xlfDuXBEbnT68Rw6AhY61+bCFpJY1pKEmti7QD3Ogu29pYEEk1CafD6y7uwv+kKfZllkgHmuDURHbUKb1tEoU+jktuMQlcI88zkBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7748

>> @@ -557,6 +587,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   		/* It was write fault */
>>   		vm_flags = VM_WRITE;
>>   		mm_flags |= FAULT_FLAG_WRITE;
>> +	} else if (is_el0_atomic_instr(regs)) {
>> +		/* Force write fault */
>> +		vm_flags = VM_WRITE;
>> +		mm_flags |= FAULT_FLAG_WRITE;
>> +		force_write = true;
>>   	} else {
>>   		/* It was read fault */
>>   		vm_flags = VM_READ;
>> @@ -586,6 +621,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   	if (!vma)
>>   		goto lock_mmap;
>>   
>> +	/* vma flags don't allow write, undo force write */
>> +	if (force_write && !(vma->vm_flags & VM_WRITE)) {
>> +		vm_flags |= VM_READ;
>> +		if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
>> +			vm_flags |= VM_EXEC;
>> +		mm_flags &= ~FAULT_FLAG_WRITE;
>> +	}
> Ah, this revert to the non-write flags doesn't look great as we
> basically duplicate the 'else' block in the original check. So, it
> probably look better as per your earlier patch to just do the
> instruction read just before the !(vma->vm_flags & flags) check,
> something like:
>
> 	if ((vma->vm_flags & VM_WRITE) && is_el0_atomic_instr(regs)) {
> 		vm_flags = VM_WRITE;
> 		mm_flags |= FAULT_FLAG_WRITE;
> 	}
>
> This way we also only read the instruction if the vma is writeable. I
> think it's fine to do this under the vma lock since we have
> pagefault_disable() for the insn read.

I think we also need to skip this for write fault and instruction fault. 
Some something like:

@@ -529,6 +557,7 @@ static int __kprobes do_page_fault(unsigned long 
far, unsigned long esr,
         unsigned int mm_flags = FAULT_FLAG_DEFAULT;
         unsigned long addr = untagged_addr(far);
         struct vm_area_struct *vma;
+       bool may_force_write = false;

         if (kprobe_page_fault(regs, esr))
                 return 0;
@@ -565,6 +594,7 @@ static int __kprobes do_page_fault(unsigned long 
far, unsigned long esr,
                 /* If EPAN is absent then exec implies read */
                 if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
                         vm_flags |= VM_EXEC;
+               may_force_write = true;
         }

         if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, esr, 
regs)) {
@@ -586,6 +616,12 @@ static int __kprobes do_page_fault(unsigned long 
far, unsigned long esr,
         if (!vma)
                 goto lock_mmap;

+       if (may_force_write && (vma->vm_flags & VM_WRITE) &&
+           is_el0_atomic_instr(regs)) {
+               vm_flags = VM_WRITE;
+               mm_flags |= FAULT_FLAG_WRITE;
+       }
+
         if (!(vma->vm_flags & vm_flags)) {
                 vma_end_read(vma);
                 goto lock_mmap;

>


