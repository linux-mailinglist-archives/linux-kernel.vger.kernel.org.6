Return-Path: <linux-kernel+bounces-258814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BCD938CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC8A2822E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9253016D4E1;
	Mon, 22 Jul 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="CfM210xi"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2121.outbound.protection.outlook.com [40.107.236.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465B16D332
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642538; cv=fail; b=RdTWjuhCZi+xLD6rV82ug8nRCQk5gYwYn0tJsmbSSUUftjrc+Ygw9Gi7o4BRp9wRSe+M6kVQ/SbxfRiXOUxEE/DaOC33SxK2PG84KiiieTeKuyiqi8aII0kDiJ/rz72xlvbLC+zRC5fk+Jm6mTH0PyHFQU+1nq9EXofTxete1mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642538; c=relaxed/simple;
	bh=88gboLwk24qcQMk3emzvV/y5TJjUfMdj8u7uZikjE2A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VeDWat/UkvfyrMnw/kry2NuilqyY1iOioIciZ8AozLjFwIJCT6Pw8EEgSUCkBiMGyQb4KzoS9liG1iG0r9atMB9tLa/QlYrRonCA/ewnNl3jqwV+J6bRcFY6PND+p450hmKkGXjXtr7Ktt3+9WlfkQMqvvbN9FnWMOWLsuQ47/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=CfM210xi; arc=fail smtp.client-ip=40.107.236.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Teb61Nr/w6cVJuf1v7YMcPzIVaCVSzgx/GF7EEQYLX8/ETH2N3dL/4YIIyV4inmwJtEe8zoplqraabfRbUJXDc66K0WaeW36ZFich9enO7BYxuAF6umpLiQJm/C+xWNi5e2ITocCJlG+IXQ1QURupcvNlHw2OA2IlyJqgk5fsWgI/8+EsG2tYRDiHJtZjFvpqEu+oGSYwvEVCyg7OHXyjl0rtLF0Ea4SUUoljKKrs2Ac4QRZ8BzIj/Fw1bp0mv6y5wb9EfUjo7Os03NYHO3/BCXM5lXWmU/YQ7FnSOQVwrgYOUqhWp+J2HC/tCGxUWzah+r5avVUqCO7w1soboQmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsEGERbQTWvk2u24FuVv7QSVOTiLV4UD1MwR6/K8g+8=;
 b=G43jOPxMKTZtvQGQmyzJr/j37z/VS6vMZAErWqk0I1fSppfREH400H6vvJbT6orjMqbqK9kXOVbZfhNOIoZ8LTmTv7cYi7f22ZjgFykxD5zjvOnsAfEfVp5S2DCMfxJlqyCdbte1MQKb9a0Kk+8mxHL3Nru8n2qPqkMOq41dMoyfmfECnJ6LIfCYDtFO+MD9rHv1QGFOxQFoofQl+jpDgfJtHz3kWYbkPS4BX/mNX/7WuBAXO0MZLRvnBBtrRx0K6xU1oC7p6ycVbQNbphqzq1J5pP2Tlg7OaiVVs2YPGloGj01hKLrclhjWlcHO1MQIG83njjNxChi2/bW3VXGIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsEGERbQTWvk2u24FuVv7QSVOTiLV4UD1MwR6/K8g+8=;
 b=CfM210xiRNtjSDZCCzmNtuoSp33aNdNXSPuoW8gChfOlrtMRKPHdjcuDfjMNN2ScPBodoXlvVHyVSV8VBG8WRNNFTCE612cwQjmnvI81Ea0u0wsdy1c0C2ENn+f0nOWHwK83WyReL8gzGZtco8EiyNldeh/D6VhYeph9LTER85I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 BN0PR01MB6973.prod.exchangelabs.com (2603:10b6:408:16c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.19; Mon, 22 Jul 2024 10:02:11 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%3]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 10:02:10 +0000
Message-ID: <6920de94-a9c8-47f4-840f-391d1ec85c0c@os.amperecomputing.com>
Date: Mon, 22 Jul 2024 15:32:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf scripts python arm-cs-trace-disasm.py: Skip disasm
 if address continuity is broken
To: James Clark <james.clark@linaro.org>, james.clark@arm.com,
 mike.leach@linaro.org, suzuki.poulose@arm.com, Leo Yan <leo.yan@arm.com>
Cc: acme@redhat.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 darren@os.amperecomputing.com, scclevenger@os.amperecomputing.com
References: <20240719092619.274730-1-gankulkarni@os.amperecomputing.com>
 <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <7302367c-311f-4655-9a83-3c4034c50086@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|BN0PR01MB6973:EE_
X-MS-Office365-Filtering-Correlation-Id: d779e10d-23cc-42f0-2bee-08dcaa355a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rzl6RU0rUSsvMW5IZXZkTnlhZnNib25ySzIvbFZqRWNQTEtjbzV1SzZsOFVl?=
 =?utf-8?B?QWVPWU5QcnhjMlhjZHRCa0Z1SnNuck9kYm1MVDEzQnQybnpkUWlPN2M5aCtq?=
 =?utf-8?B?T0xadjVUN1daZ1FLUjZVYXI5ZHVyWnJzODVmMnE3M1I1b0hEK2xjVlZuN1Ju?=
 =?utf-8?B?aldWK3MrbHJETytpS2NGTXdrdWQ5Z2ZndWhsNlFPZG5kOEdrYkc4SDBxdi9L?=
 =?utf-8?B?d2xEd0pxTVIyWHF0a096YUl6Z2x5MHZqMC9jcVVZdW04aSs0WVptTTBiOUg3?=
 =?utf-8?B?QmVUWWhHK1gxdTNTb1NvUU9VQTR5MU1wZ2ZrNGdOMHFMbEhyYjgyOEhyWHhU?=
 =?utf-8?B?dlY0L0Z6d3pSSjVCZGlPT2dla0ZNVVNNWXFJanh4RTM0ODFTOXBCWVFKTVRw?=
 =?utf-8?B?dkgyRmdxMUltaDBSLzVlMjhrTHV1VUx3S0h6MS9XblNBTnpLcUtyTmh3SjVU?=
 =?utf-8?B?OW5yVVFDRUhsZHBYeGhFQW9VRTdzSkNmZmw5NlRFd281OXB3d1FvTzYvajcw?=
 =?utf-8?B?RjVjazErV0lZOGhVV0ROZjJ4N2pmWFJBUDRnRWhkSGFUb2Q4VkpjaURZU05M?=
 =?utf-8?B?ZjY0N3lSSzIzdytLYVlPc002SHpxUkNJaTFCV3VuQ1hyQ3lnbjRpU0FhUlZk?=
 =?utf-8?B?UmR4Qjh6ZllmUkk0Zzk0cW05b0FmbzNBZ0REd0IrVktqbWwyaVZUaVN2S0pp?=
 =?utf-8?B?VUQ5TklRYlRuSXFRRzI2WnFmTytoa1ZRbWl0SjRmTFkyZ3dPanpTTlJmR2RJ?=
 =?utf-8?B?STlSalEvVVYyOHF5SjlyZFhNZyt2bGducWpsak9tUW1CbDdtUWdRUGY3QXJY?=
 =?utf-8?B?Rkc0MXdnUEZUemRRMGtMSzJxWkNiWkErb1lDQW1oR3IyLzlWTEhPYnBsV2hs?=
 =?utf-8?B?OHg1VW5mY3RSOUsrc1B6MmYwVStmK3kzUnBhZk9DajRUakFKcU42eEpSMDc4?=
 =?utf-8?B?VDloWXI1U2xIWGJCL1A4V1dOTnYyV1RGcUdyNGltQ1YxY1dYU3NYTEhEVjVl?=
 =?utf-8?B?dkJ2b1lXV3pnYmk2M2ltZ1ZkZEpQa2xBcThEdXZtRWFMR2kvM0VndmRLUE5i?=
 =?utf-8?B?NEljeEpudzU3TXVodHFVOWlKSHBHQkF3YlN6UUd4UlB3UERLMVUvemsvR1Zv?=
 =?utf-8?B?M3ZsUFQ4d1dEMWNMSjcveE95OU0vMjRrdEpGaU41bzNrOEtjK3lFUnFCdXVx?=
 =?utf-8?B?UXB5QnI1ak00WXdSdjlSRDJJU05KeURxSjdmYU5IenVHREg1emoyaWx5bndO?=
 =?utf-8?B?NjB4QlBhbmUvRmxCRHFwM0w2eWZDK1FYNWZNbEl6Z2tpTkJqclQzRCtybGhi?=
 =?utf-8?B?L1o5T0tVRmcybVdURFZtbkFTdmNEbFZGYjFuOVU2SzlBQXlsYVQxblFQdWVh?=
 =?utf-8?B?c2FRa0FTUEthL2gxTzFHS3dLUUhoZEtHU2dRVURtb3dvU1hXWDZVNzhFVThl?=
 =?utf-8?B?TFhVQnFaVStqOEZCN3d1SGZhcm0zWFlNb3JjZE5wTHcycWtWUUxSalM5TkRM?=
 =?utf-8?B?QjF1Z3VHVm9yeUh6MVBFQjBOVkhWNXVBYlJkeGM2dGUwYUVpSk5OelFUTzg5?=
 =?utf-8?B?dFJvazBCZy9JWUlzMjdkMDhQV09EVzhYQ0k5UCtuZU95ZW9ZdURZckozK1FQ?=
 =?utf-8?B?UzJqZTZGaWo5Z2xRdnU3MVRzejRidnNUMjAzVWc5N0FOZlZhY01LS29lMENi?=
 =?utf-8?B?djhweUh0VitkcUg0aktNeWdSbmJVV0dmdWl3MVBmWXBOZkFhQzlDdncxRFdM?=
 =?utf-8?B?Q2xBMXhtcGVqeERZNmx3NVdCQVJoRnNZdXMzVEJVQXBodVA1U0ErK0NOT1kz?=
 =?utf-8?B?eU0wbU1TMzkyWlhNWEV6UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vmh3enRXQ1ppSytOM3Rrb1VTeWlKTERkM25vbWJRWitTckJDQy9xQXNvcnBl?=
 =?utf-8?B?K0Z2eGY0ZG5hTnQyNUgrOXpqWHlCYkM0TzBmTkdUODJEdWd3MGhGdG9iMzAy?=
 =?utf-8?B?MXdheCsxL09TaFRFUUcvMkI3b0xkTzFmbE9GQTh5azNtUGN2L2s2MFpMN05p?=
 =?utf-8?B?TEt0T3B2YW1xdUMwOC9DK01TNG9WYSttUXY0Vk1aeUdiSVIrZTd4TUhCSk9T?=
 =?utf-8?B?TWNFQmhlaC9RdnFuaEFjY2lRR0R0eXg3SjRVZTZkbmlrVlhHTUFIVklZR2Jm?=
 =?utf-8?B?L2hCWG1xNDVrdStuM0c2YS80akdRclBVUytFUzE3bk10eVlsczlTK0llMktx?=
 =?utf-8?B?YTg2M2xsVEZ0TzlTYlhLUXN5UmRzK3ZEQktDbG11WWF1K0pLejRHNmJ0V3lu?=
 =?utf-8?B?RmpzejJjamRKZm5xaWlib1hQZnZGVUlNaVdBUmlYSjVDV3RmMmlXWXJNaEQ3?=
 =?utf-8?B?b3JrOEZNWUw1cEJwd1RRUUo4dC94a3BieDJXRG5NYWJoYVBRb0tmQXNVRWdG?=
 =?utf-8?B?bUxxN3lGSVZKd3BJVmVDR24ybUJSU2lXL2VXWCtlenRKNFp5ZVREWEszR0wr?=
 =?utf-8?B?SzJXQ3gwMTdsd2ZZWDA5OCtjOEZyeWphWmUzRnM0eWpwVzFGOG43L3FHMnhB?=
 =?utf-8?B?RTlOOFlVYW1RQ0t1L2xOZVI2a2FvNkpFUnBIY1FubnhZVnRuNlpjYy9zQ3A4?=
 =?utf-8?B?S3RhdlpydUZ6VmkvM2NWSXVJQmVqZ0hHcFVCN2RjTmZTMkMwblpncHdGY0hO?=
 =?utf-8?B?azlKejBvMk5zQVNrclJaQ1V3bzYveDVsb25vVXBuY2ZZaTl0ZE40azQ5eXI3?=
 =?utf-8?B?aFNhVklGaSt2Szg5VTRWcllLaTIyd2Erd2NyWmFvL0FPZmozVjV1WHI5WDBP?=
 =?utf-8?B?dXRkWXJtQ2pudlVudkdsRU1tNko4V0p5RE1uRCsvaWRrSTdDMjQ0WXpLUlFN?=
 =?utf-8?B?QmJBQk5qdUZzRjhKaVpROWZpeWpnbnhIbW5MUCtKbkdLVUQ5cE9jWFQ4U3FW?=
 =?utf-8?B?SjcrUFhCWmxJUzgvcDlqelpyV0VRWGUreUpQZmpPMDlYUEIzWG1QMkhVT3pa?=
 =?utf-8?B?b1RaRDZsSGJBTGJmSFlySmFBamh4c0VOWGZBZXl4RDd5ZmxaVVNmNDNWRUFm?=
 =?utf-8?B?YWhaaWFXTXlPdWtuMkxjWGI2Z2xaSHRtb0djZWdmNVViNXlvVmhLeWVCRHh3?=
 =?utf-8?B?QWpDK3pmTjJHdXpkZ1lSL0pueVIxM0hlaXY2UlA5OW9uYXljRjlNdjBFRWtx?=
 =?utf-8?B?eTRmV0x2M0hOU0ZWWitsa29Yc3NxdExkWm1kOXR3aDNPQm5NbGZSNUlTSHdK?=
 =?utf-8?B?Z2YzUHh0N2RhbDgrUmh5VUhrT1FIM21xYTF0K2t2ZE94TitabitHMVhodmJR?=
 =?utf-8?B?MXNlbkNBNGJyOUxWcHRBbldQRVg1cEV5WDdmaTd3UStNN2VqbmY4R0U2SXYv?=
 =?utf-8?B?eG8wL1BmVW5LUTRmZkU5MHVZYWJNSkhaN2VpY0JSZ0ErRjhlWjU0VHVUbDgv?=
 =?utf-8?B?WlZaS09tcEphcjRJOUpNeWI4OERSZjZkVVJyOGptZlZWM3o2SUVYMWx2MkdE?=
 =?utf-8?B?VHVVNGFwQzg4R3VaakVTMjVUKy9HZ1lFTWNCb2lXbzZkU3Q0b3ZqaGR6TmRH?=
 =?utf-8?B?NWNLTGlEdHVvV0VFbFFUekJzeVB5RVNTaWpGejhFTFBDVFliVTNUak9BYUUw?=
 =?utf-8?B?ckpoaFZ1Z01jTUd3NDV4ZjkxTTVPeEp6UVZLY01FWC8rTC90S1F6ZzJhcUZY?=
 =?utf-8?B?SHhqQUR0ZlJVN1VCVlVMVmlQc0E3K2cxYm9XcG1VZGx5UDNVOXYzL3grWkZi?=
 =?utf-8?B?OFRKOFB5TUhFVVcrbFlRQzdvZDdadUhrUm9UTkh5cUpXVk1WTXNWeFFJQ0Fy?=
 =?utf-8?B?dlB6VXBwL2p5MGFrcGR3OGszVWI0dlp1OUcreFhtYUxqT1VkM3BXdnR1UTg5?=
 =?utf-8?B?N0ZIaWZmK2RTcDNDTGpOcHBBanNVRlZlYy94bk4waUpSOWh0Y2l6bHBHWkJ5?=
 =?utf-8?B?M1hLWmNsL0lvWWwxNEI3RXdmTCtGcytaQVBDdGM5UlJ4WDBsdE1CQ0hmejI4?=
 =?utf-8?B?eE4yL1lSeTk0U0tCTmlWOFhGQTZiazRheUM5TlQyY29yOVQ3cnVDdk5Kalo0?=
 =?utf-8?B?eDVtOGJQS01WQ3laaHlVU0U0aFlZL3hwa0I0WUs4cjBpTFdKakRJaUxMSHAr?=
 =?utf-8?Q?5eL0AqeBmg9/snwfJK88rLIKuTjmPXI0zpFU0LLKSYOW?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d779e10d-23cc-42f0-2bee-08dcaa355a65
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 10:02:10.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/BV80jvSwPoe2iV/5TRGMKGlbiVcWClMWXLMqWNvnaQfCffrOz0zWh6SG0fMaYtcppU2g2KtApnX/49BJw1S97xoN90NIXlmyJd8N/XTYufWpUVGhxea9A1kpYvxgAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6973


Hi James,

On 19-07-2024 08:09 pm, James Clark wrote:
> 
> 
> On 19/07/2024 10:26 am, Ganapatrao Kulkarni wrote:
>> To generate the instruction tracing, script uses 2 contiguous packets
>> address range. If there a continuity brake due to discontiguous branch
>> address, it is required to reset the tracing and start tracing with the
>> new set of contiguous packets.
>>
>> Adding change to identify the break and complete the remaining tracing
>> of current packets and restart tracing from new set of packets, if
>> continuity is established.
>>
> 
> Hi Ganapatrao,
> 
> Can you add a before and after example of what's changed to the commit 
> message? It wasn't immediately obvious to me if this is adding missing 
> output, or it was correcting the tail end of the output that was 
> previously wrong.

It is adding tail end of the trace as well avoiding the segfault of the 
perf application. With out this change the perf segfaults with as below log


./perf script --script=python:./scripts/python/arm-cs-trace-disasm.py -- 
-d objdump -k ../../vmlinux -v $* > dump
objdump: error: the stop address should be after the start address
Traceback (most recent call last):
   File "./scripts/python/arm-cs-trace-disasm.py", line 271, in 
process_event
     print_disam(dso_fname, dso_vm_start, start_addr, stop_addr)
   File "./scripts/python/arm-cs-trace-disasm.py", line 105, in print_disam
     for line in read_disam(dso_fname, dso_start, start_addr, stop_addr):
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "./scripts/python/arm-cs-trace-disasm.py", line 99, in read_disam
     disasm_output = check_output(disasm).decode('utf-8').split('\n')
                     ^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib64/python3.12/subprocess.py", line 466, in check_output
     return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/usr/lib64/python3.12/subprocess.py", line 571, in run
     raise CalledProcessError(retcode, process.args,
subprocess.CalledProcessError: Command '['objdump', '-d', '-z', 
'--start-address=0xffff80008125b758', 
'--stop-address=0xffff80008125a934', '../../vmlinux']' returned non-zero 
exit status 1.
Fatal Python error: handler_call_die: problem in Python trace event handler
Python runtime state: initialized

Current thread 0x0000ffffb05054e0 (most recent call first):
   <no Python frame>

Extension modules: perf_trace_context, systemd._journal, 
systemd._reader, systemd.id128, report._py3report, _dbus_bindings, 
problem._py3abrt (total: 7)
Aborted (core dumped)

> 
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
>>   tools/perf/scripts/python/arm-cs-trace-disasm.py | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
>> b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> index d973c2baed1c..ad10cee2c35e 100755
>> --- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> +++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
>> @@ -198,6 +198,10 @@ def process_event(param_dict):
>>           cpu_data[str(cpu) + 'addr'] = addr
>>           return
>> +    if (cpu_data.get(str(cpu) + 'ip') == None):
>> +        cpu_data[str(cpu) + 'ip'] = ip
>> +
> 
> Do you need to write into the global cpu_data here? Doesn't it get 
> overwritten after you load it back into 'prev_ip'

No, the logic is same as holding the addr of previous packet.
Saving the previous packet saved ip in to prev_ip before overwriting 
with the current packet.
> 
>    prev_ip = cpu_data[str(cpu) + 'ip']
> 
>    ... then ...
> 
>    # Record for previous sample packet
>    cpu_data[str(cpu) + 'addr'] = addr
>    cpu_data[str(cpu) + 'ip'] = stop_addr
> 
> Would a local variable not accomplish the same thing?

No, We need global to hold the ip of previous packet.
> 
>> +    prev_ip = cpu_data[str(cpu) + 'ip']
>>       if (options.verbose == True):
>>           print("Event type: %s" % name)
>> @@ -243,12 +247,18 @@ def process_event(param_dict):
>>       # Record for previous sample packet
>>       cpu_data[str(cpu) + 'addr'] = addr
>> +    cpu_data[str(cpu) + 'ip'] = stop_addr
>>       # Handle CS_ETM_TRACE_ON packet if start_addr=0 and stop_addr=4
>>       if (start_addr == 0 and stop_addr == 4):
>>           print("CPU%d: CS_ETM_TRACE_ON packet is inserted" % cpu)
>>           return
>> +    if (stop_addr < start_addr):
>> +        # Continuity of the Packets broken, set start_addr to previous
>> +        # packet ip to complete the remaining tracing of the address 
>> range.
>> +        start_addr = prev_ip
>> +
>>       if (start_addr < int(dso_start) or start_addr > int(dso_end)):
>>           print("Start address 0x%x is out of range [ 0x%x .. 0x%x ] 
>> for dso %s" % (start_addr, int(dso_start), int(dso_end), dso))
>>           return

Thanks,
Ganapat

