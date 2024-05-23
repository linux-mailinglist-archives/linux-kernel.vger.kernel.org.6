Return-Path: <linux-kernel+bounces-188066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD62F8CDCCC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 00:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219A42884A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E212836A;
	Thu, 23 May 2024 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="axM9uwQK"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2104.outbound.protection.outlook.com [40.107.236.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC314A82
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716502413; cv=fail; b=icAu+RBI6KVzDpXgrmExS7woueKe+pBi+a7wyedKE7Vmq6OXIkHWnOQFuu9RwD9Y/Eb4UNP2zJ6XxP/5CgSmLqQXZrPCLOvH5DW/+Q0OWMx2Ad6eaI9OqRqyiPhdLM6PaxHJfT4YYFM8+60LVBkA6FyNmD75VTA++9uGer/ZHUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716502413; c=relaxed/simple;
	bh=VR9YRcjAwdJSPDgH/pFtSXgprA5kUZ51VTAzJQtb7gk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fCOKWCr6kOW10F8KLAy1/Ab9a/n/xOC80A8HJMxCl04L5+xQE5FRvC1aUYLhSZZvyUOTxuCJ4UnseWK8FoCBxnr801UrYhBIU6ukfmfEZM2wiB13s83tL3ztCbFHtUeW5VrFMs+Y5hJwOn5UGWfGa6WeCzN9phcFYzu95id6McI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=axM9uwQK; arc=fail smtp.client-ip=40.107.236.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5MLtU9k2z3LguRXWEO4QxkK+TKiR/4/HSv2XjcKcZvqNl1yI4vvd6hgCTA/mcZs5R0zo27I0j82nw1z9Q0S3cAAltO/p0UFJT4rNmNvj6idGDV4Gc84XcLwGoslC+mBQq0TduonKImHly1L2Skg5eDUMwymHvLLkTgiwiJi0l/sdC/5mn1m6ifG1w8IM4+USnXwJyCkHq8gyMbHyGAJbZmbSlmACLYeqoZFtXp4T3Eyy4+MklmoMBVZHLB4QudfTioR0FjE83PzfCVUzo/s1VWRH6SSwPy27mVIx3PvAdPPNgj72+OrqJGnXw+uLIBltcmhrYxBzSwF8GycuL3XVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbmBuca06Kpg8knNKpFEnUVJ04Zdqi4fldl5aZs6rSg=;
 b=oWZbEiMxKQVYeNTR1kIGFmA9/9bDlon/Hsc1wRwo965xbPF4PhR2wYdcqlT+7U3JdFNbIhQf20Q4R8xEOttAAHrPDRiAiI7wfQFLFCinoEZjMfpts2mpm+7HaDlG3rm7q7+afCOuLZ1FzCQJsgC7JX8GzmV26z4lej5H5qfeP0V1yaoKrYzmtFbb4fc/rcaowRTpZ45ndc0joFtTXg4hm4hWYDCJkQBrSULT5G2+gDtMFaFKdSQfTWUQvDhwaXF5TIQX1GuRYKefgj2ds2UPUtVSn4RKN7kNuDaiAhk5IzAXOhHe22NY83Ut0uOmdIJv09HyT0J0Xplx8RbjICJWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbmBuca06Kpg8knNKpFEnUVJ04Zdqi4fldl5aZs6rSg=;
 b=axM9uwQKdvO2NOd/6cgknC+4tYmAcPpzA9kdteSQg5ia5QOabCUurb+yKm1qXYhiJBilgxlM05UjTSWBNZP0wLyYPVIOzB6XIcIrK4yjuRjFB27nH9FCCTUA17ME3+inKPinCSkvPxuhYNi3ILR8G6v/MX57gn+H81cUCetgvBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SA3PR01MB8502.prod.exchangelabs.com (2603:10b6:806:39f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.19; Thu, 23 May 2024 22:13:27 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 22:13:27 +0000
Message-ID: <d18611c7-9108-46f7-a5a5-6c8e0069de9b@os.amperecomputing.com>
Date: Thu, 23 May 2024 15:13:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>,
 "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240520165636.802268-1-yang@os.amperecomputing.com>
 <Zk93vBqAD3LgmbGb@arm.com> <640f8606-2757-4e82-721f-9625d48ded65@gentwo.org>
 <Zk-SNVyEHT1UsxqD@arm.com> <ad87bb77-a9a5-2c0d-b4b2-13db09615d7c@linux.com>
 <Zk-2a7s2pvkVsm2C@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zk-2a7s2pvkVsm2C@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:610:cc::33) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SA3PR01MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1baf25-9dbe-481f-c171-08dc7b75925b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWdmZnJkaUVDWk9mdDI4dTJSdGFlOVBTeHphOXR1dEhVK1ZQcVZISUxHQldq?=
 =?utf-8?B?QktBSmhKVVBCWjV4TGRwVHlheDBLZXMyUEpacmdsdkNhRU5kQm83aFZpOGdt?=
 =?utf-8?B?b2ZubytjcVdvNWZnSXdiSjUyYVBkcEg1NmJQZ21jUzBoUWRCZEJIQ2VkQWc1?=
 =?utf-8?B?NnJ5YjQ2N0NpWjY3U2FZZ3pIbXZ0ZHl4Y3BkVkpDbG95YmZuNTYyRGJHYmw1?=
 =?utf-8?B?QnFOS0pOTHc3TkRIOEYxRkZXM00rcTZ6ZmJPc3hML1VHdEpwMEJRZXphNjMy?=
 =?utf-8?B?ZXZJbm9wdDU4K3BOa2gyT1ZWajdBK3dyUDV1WTBuWEZxRmRKM08yaGJSa3Vl?=
 =?utf-8?B?R2IzUTFZTGRLT2NnZ04yR3p4VFAvaGdmNitrVU5CSHhzdUkvK1ZPN2wvQVZK?=
 =?utf-8?B?SXBYcE0vWW40VFBVNEo3TENCbVpnU2NOQkVGMEtMZmRPb2JocFFGUmhJcWEr?=
 =?utf-8?B?cEdWV0ozK2JRTzlLTGJ6KzB0eFpFenNHb0xLTm1zMm1SRmQzd2dxZU9GdE5i?=
 =?utf-8?B?RU5tdUNIM3A0ZGNSVmV3eXRhTWoyUmxneHFLaWRuR2ZVeHE2MzBKTE0vQk1s?=
 =?utf-8?B?WENYdlYrVEdjbjJXVzlNZHRmaUpZSTJSbFRpR04xVzVnOXNEVUp0ZzQyaWhl?=
 =?utf-8?B?bUFySXZTeU5rYjIvbzFoWVF6Nm5mM3lCZEpWQUF5U1N6eTN5eVBYam5oeVhu?=
 =?utf-8?B?M0lrcEQrSktuS0NnNEd6cjFlallNOWhBT2tnQWRCVUt4b0s5VXN4OVRsQmRN?=
 =?utf-8?B?UnowZFpsaXNFOTRGQXV6L1RYTGxvTzZTQzZnd2txTXh2RVRxNUlJSEVySFVQ?=
 =?utf-8?B?ekRab3A3KzlodVlleGtoazZJc29pQXNkWU5yeTZlNEJ4dWRNMlkzeDNNZnpK?=
 =?utf-8?B?UDUzN3dreEZESDhZV0F4WWplTWJjbWVIQk44SzN2K2VYTWNhZWFOeENQalRu?=
 =?utf-8?B?TVhnZUt4WTljSjBxYUplVEtlZitOeWw5S2U5UExaemZPa29TUUxVMU96SGhk?=
 =?utf-8?B?QkV2cy9kRFQxWkJaNnJuMnVWdHp0ODZJc0doaHJvNHFjUUUwRmNZbzFINXFI?=
 =?utf-8?B?M0V1akFWeVczTUdmSkU0bGpqRmRYT3piNU4yY2daZ2doWGZ6c1ZVVHZYYm9W?=
 =?utf-8?B?R3pSbTRQZXZzclYxY1FyMVlRb1hNTnd5QTArdFA4VlIxMDBMOE9SWkEwSmFh?=
 =?utf-8?B?ODc2eHNONlBDYmdOV0VLZ09RTnNhY1pvOTl6WmptTmxld3hncDJ6MjdQTXlt?=
 =?utf-8?B?elk5U1ZzUFVsSU5pMVQxNHRJK0NaY1VDcUZJZHhRTklWTHV4THhOblFWRHVC?=
 =?utf-8?B?Q0t2STFFbTB3OVovKzFqMDk0UlZDbnVRNmJXSnkwb2doeGtOT3FSS2hpajZn?=
 =?utf-8?B?OXlWZ0RlU0xtOXVSdmFPZVpBMUc5alBQaUlRdThNL3F2K2RTem4xS2EzTE54?=
 =?utf-8?B?eDg3K2JTY3VOSDFLL0pYUUtzZVZOcHBRNEFFNzN6UWtXbDdMdVE1SkhDYU03?=
 =?utf-8?B?cHBFeGY4c0xPdWpMUWNicnNaRlFwVWw4cVFlMDBxUHh5YXZQZ2VlYkttRGdL?=
 =?utf-8?B?T0dkdko1R3FiQkNmVWNjdG5UWUlESEsrakRma25WanMzN1M3cllpR1hkWndw?=
 =?utf-8?B?bC9tTEJtQVNNWGJEbEpYMjJJcnpnU1hJdnlSOWZURDVoQWg1ZTM4MEVOSDJw?=
 =?utf-8?B?eGxwaWNwcDNQeWJxMlhqcmQwTlcrams0c2p6dUNTS0psRXBwUDJvM0hRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1daM3dFRUcxTlVaT1VXcENlTE9kWFk5TWNaNFlCKzJZamZFVWxGSHNVVjJz?=
 =?utf-8?B?SDBRSDBVZ2hZS0tDMUJMUnlCaHRiQWtreTdxZkNSUmRaM1RkOWF6aGR5alhD?=
 =?utf-8?B?UUVONFU4QlloUU1rSlhhc0tOWVV1VEhoVDhzVFprbkkzTTJqL0VLOTdZUGZ2?=
 =?utf-8?B?Z0k1azg3QXVPSE14WlhRV0dXN0NYM3NScDJmMjcxazJSUnlZNE9aQkxQbE9t?=
 =?utf-8?B?dkQyNVQ1QVNHZndtYlltWHNtcm9Odm1LcVVIKzMyU1ZsRmNseXlRVFNORFJE?=
 =?utf-8?B?K3gzU1o2SEJyejhQZFEvMC9GUVBqZ0dCLzVOM1UxVWpHVHE0MjFURnAzOHpN?=
 =?utf-8?B?SzdIRnk2MHFhcDRYdFlzNFZLS0xpVkY5VFozV3pIeFlpOGVUazJ5ZkdwQTJx?=
 =?utf-8?B?eUYzWUNQdkthbzVyZ1QyNHZRRzNIbEdHYUdNUWRRcUZMN3pWaXh2ZTRWOVk3?=
 =?utf-8?B?cmZKeWJPdGovVDZ0RTNGT1ZOSVArK1FLQTBtT2tjSzBpVklZZFB6Ky81TFh4?=
 =?utf-8?B?dXNFU2greUh6bkRVcGZTcmE2Ym9MTTZzSktoTkxrSGx4MWpIQTFScVVmZFov?=
 =?utf-8?B?WnJRU1lGUjBVZHhHQ2dWNExKanMxUmd5WitZenJaRk1mV0ZHZHVpU0dSazQ2?=
 =?utf-8?B?OUJtYXNjRys0ditsTlNVV0NPYUJrWHg3UCtobUpOM3p0dnlUOTF0NDU4SjJI?=
 =?utf-8?B?L2ZXdGVJZHppQVpSYVNMbHlKN21Nb1ptMVFzTGYwNThXMTdzcmpCMG1melp1?=
 =?utf-8?B?ZXREeVA5NDg0WGtzZjJGTXlWTllJalVlSzVEZEU5cFJ3MlEwTVhSUEhwUVpX?=
 =?utf-8?B?N3NXQ1h5Sy84cStQTERmODFudkV6aUdNa2pOZmlMWWluMVJQTUg2eHdPVmhY?=
 =?utf-8?B?bys3TkNkT2JzTW5WZFQxaDlUVm1DRHhhUXM0ajh1b0xBMjZTNlF1UDZmUk51?=
 =?utf-8?B?eGQ1WGxkZkl6R1Rzd1d1c2t6Z3MyYlBiRDNDQnBpdThPa0ZQY0xUcFBJWEQ3?=
 =?utf-8?B?cUpnS3N3a1lKS3UwcklsZEE4a2VzM2VEQzNrMytUUStXVER4UlYwTWhKeDNs?=
 =?utf-8?B?WXMrb2N4TnlwZFN1SFdFL3lGRFVEZ0lBTW9RVmdDMys4L3JPYWlDUkQzRHJL?=
 =?utf-8?B?THBoL2dSSXJUcTFFbXU4QTZqa2lHWVNkVVJkWjdZR1BMSjhwSVJid0pzanJP?=
 =?utf-8?B?SkhaK0ZtVFovYXhobzd3VDgwSEltS05LK245dGtjNUJFRVhXejBSZ1pnR0ps?=
 =?utf-8?B?b2FsQ3ljRWFrWWJ3UDMwd3FhWjByODhRSGt6eTJiQUovMEN2cXRibXFQZWlE?=
 =?utf-8?B?S3F4dGhTaWI1SStyWXkrUEs4SnY1NjAyems2UjVkTGlwL0FwUHF5NE9uWXJH?=
 =?utf-8?B?RVZ2cGs3eGRFOGEyNUdha0pGeW9MTTdWdlpMTTA2OHQzT0VBVTF2THFKZ3kz?=
 =?utf-8?B?Nkc4cDhVZ0QvQi9YWGVIU3dRU2xKQ0pEQmpjdGJRMEo1cHRXcDhoS0R3aEdJ?=
 =?utf-8?B?ZGsvWXlwSGxyd01rSHhYeVhoVXYzL3VaRVU0c2p4Z0RZUVZuS2ZrWlZGV3BH?=
 =?utf-8?B?K2VKVWRlRW1zZ1ZJSHllOExaeFd6dFZLWW9PbHZBYXdzUTdSUVlrbTE5VGc3?=
 =?utf-8?B?RkQyc1VNZDUzS3dzMjJ4d1VvbTVtRS9JM2NYakswV1l1bUhJbjNScFZSRDl6?=
 =?utf-8?B?N2Mvb2RUU3hGRG13cFJMSGFZQnpWY25telVJS0ROQW45eStmS0RLVE9mSkJn?=
 =?utf-8?B?d25xVC84SXJ2b0FWd01MZkRZbmlnYnk0cDJ3ekMyNWFDZ3UxQWgwaFM3c3pQ?=
 =?utf-8?B?TWg1VHpubnd5bDFKNmM1Q1E0VEpBNUpLVC9MSlhvb29aMkF0TXl5aElEQTRF?=
 =?utf-8?B?T3B6dFcyZnFsZDVRV0E0QVhuQWNQbGNjRUNiUUlwcTI0YnRFRktpdHEvUDMz?=
 =?utf-8?B?bUxIY1VMQXZCbGRoQVgzSzh4dnQ1RHBuK2xNSk91SXVaMHBwOWUwQlhlTTlS?=
 =?utf-8?B?NVNYZ2VsSEZwazBkSjMvQXNudU0zek9SNC9hTC95NWlhVEMzSjNqZk96cTU1?=
 =?utf-8?B?cHdiNzc1ZTlsc2kvT0xFckJ5dFlPN0pTNHZVQnZCcTJ1dTYybGd4MHpEVUVi?=
 =?utf-8?B?N3JUNzdUdmswYnowWlVIQ3FHa2crNE12cmRmenFSTVB0Z0dBUUFvRDA0eEF5?=
 =?utf-8?Q?RWB3U1nS1ngp3w5gUQFOOVw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1baf25-9dbe-481f-c171-08dc7b75925b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 22:13:27.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPTeY9YHIJDKfXR5r9o9jAbRP9yNYAJmBcGvTkoeSU5uZOa0LtXb0C+TA9DrDvYe/l+g+YVD7EIhA/q3j37mX+qkrLrZztcSykidcM63dZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8502



On 5/23/24 2:34 PM, Catalin Marinas wrote:
> On Thu, May 23, 2024 at 12:43:34PM -0700, Christoph Lameter (Ampere) wrote:
>> On Thu, 23 May 2024, Catalin Marinas wrote:
>>>>> While this class includes all atomics that currently require write
>>>>> permission, there's some unallocated space in this range and we don't
>>>>> know what future architecture versions may introduce. Unfortunately we
>>>>> need to check each individual atomic op in this class (not sure what the
>>>>> overhead will be).
>>>> Can you tell us which bits or pattern is not allocated? Maybe we can exclude
>>>> that from the pattern.
>>> Yes, it may be easier to exclude those patterns. See the Arm ARM K.a
>>> section C4.1.94.29 (page 791).
>> Hmmm. We could consult an exception table once the pattern matches to reduce
>> the overhead.
> Yeah, check the atomic class first and then go into the finer-grained
> details. I think this would reduce the overhead for non-atomic
> instructions.

If I read the instruction encoding correctly, the unallocated 
instructions are decided by the below fields:

   - size
   - VAR
   - o3
   - opc

To exclude them I think we can do something like:

if atomic instructions {
     if V == 1
         return false;
     if o3 opc == 111x
         return false;
     switch VAR {
         000
             check o3 and opc
         001
             check 03 and opc
         010
             check o3 and opc
         011
             check o3 and opc
         default
             if size != 11
                 check o3 and opc
     }
}

So it may take 4 + the possible unallocated combos of o3 and opc 
branches for the worst case. I saw 5 different combos for o3 and opc, so 
9 branches for worst cases.

>
>> However, the harm done I think is acceptable even if we leave things as is.
>> In the worst case we create unnecesssary write fault processing for an
>> "atomic op" that does not need write access. Also: Why would it need to be
>> atomic if it does not write???
> I'm thinking of some conditional instruction that states no write if
> condition fails. But it could be even worse if the architects decide to
> reuse that unallocated space for some instructions that have nothing to
> do with the atomic accesses.

Even though the condition fails, forcing write fault still seems fine 
IIUC. I'm supposed the read fault will happen regardless of the 
condition. Then a page with all 0 content is installed. This is 
guaranteed. We just end up having write permission instead of read-only 
permission. We will also be in this state transiently with current 
supported atomic instructions.

But if they will be allocated to non-atomic instructions, we have to do 
fine-grained decoding, but it may be easier since we can just filter out 
those non-atomic instructions? Anyway it depends on how they will be 
used. Hopefully this won't happen.

>
> It's something we need to clarify with them but I'm about to go on
> holiday for a week, so I won't be able to check.

Have a good holiday.

>
>> The ultimate solution would be to change the spec so that arm processors can
>> skip useless read faults.
> I raised this already, waiting for feedback from the architects.

Thank you so much.

>


