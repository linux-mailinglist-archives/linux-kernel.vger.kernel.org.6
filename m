Return-Path: <linux-kernel+bounces-173714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2498C047F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D80F1C216AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0757FBD0;
	Wed,  8 May 2024 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dZNTt52K"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2125.outbound.protection.outlook.com [40.107.223.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C1F1E532
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193440; cv=fail; b=Ydgx6ebaC8dWYkfozEUe7oO97uTBFDooVTif+oOe0ufOyI3WtwH0eDVNzSkDWukR5XNi9NDMXiP74FL2Cm3fHIlMQK75zp62QMrhFFUklGsZw9qyhMat5jtAE/CcVGxZzJZVxEuzAZKgwyYSZCa65wdY+oDdqlttOfe5pMQ+6ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193440; c=relaxed/simple;
	bh=V+eRvelryiF8LD4B/o8uT+86dz9edlcXVttrpHcUjYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oVfrBjQi4zq9tmp2JKrNrpVgf4MyWBvYJhRr2pI1ADuz/viQDC789+/kcPGWjVUZLsCFmYvpWH9921906XAx7CuMPlesOaDoFu4Vg708HmWFCKmgawKJRWmwxTkmfksNzqcyFMfvtjxrmQqAwEWt35UuyZedLxX6YAriVLhcRqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dZNTt52K; arc=fail smtp.client-ip=40.107.223.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2n4jgJvvLvBqqDrWdO+VRqi58cf/lGvHDfrTbOBWqduwhQ3jvZfAcLNrqe2JAYdSe9hq0r2aaSt8V7dpsySlLZSVOM9Kvb3ehg2p3R6KNCWpTZog1JlGIPU0gNtlJuM+4ooDJpQXSu65FeCAtbNjWEHGBZIK1Aq+SWTSZRwhAj8cwpNwncbY6T9+2+KK+VteIgEf5UYChK3mHRZiHwfA46iJmwQnU25BJz89NDqES4BnUm/Nxd/qAwkzi2+P/RrF628wK61dPaVoFnTuIVMGgzZ3imQ6+hpTtvPfiab1NvjmNVGc91Rd8b65DiWl3w1bU6EinNHXCyMgbwZjL35FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc1KZaCR569ERIX+WotZbv/m2vosXjxp6F0pKmRyaaw=;
 b=M32Ca+SmGDrvl85uZvSiizWY9EuCFDG2eLy2fTWd1TR8FQSyko4XreZI0lC3WaFiMI9fosWROd0DGVbsYlbdl7VxUM/3Y83j53qC6XNJSNZaby2hiSIQGVaN90h7+SAkK9JCSv50zHpDfNtqMR4HyYw2aBqkZKb2clDRqx3tudajL/NQmLK74dPihHvrbqNu6uRdiem4cekOXeQxtDcnwSf/7bP/MirtD7aF+3XPuh8kPB8l+tYWdqpeL22lEli1xRBN/NhUvIt1HLdagQxk1jS2l9dFzE6p2s72Cf4MD7KhC7SgWe3s+PMpRGXdJy5GDf0W5nPxrSfJPRT7ujaTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc1KZaCR569ERIX+WotZbv/m2vosXjxp6F0pKmRyaaw=;
 b=dZNTt52KfNl8p6gNgkVzofpCs+joCpcXoBCAR1JhMKgtHEsbCVfNl3pqvn9pz+kunAkAYz/FR5dCd7YUfKyHk0XvXw4ExyuVv42N+9rZwEgo060ierUGJ68ulI9CkeYVilaPBxKJuke8Or0eEZBzz7dyc/ZzVZWR0dSVohhJH2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SJ0PR01MB6413.prod.exchangelabs.com (2603:10b6:a03:290::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.43; Wed, 8 May 2024 18:37:11 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 18:37:09 +0000
Message-ID: <bb60d304-3341-472d-a4ee-d31b4754c39b@os.amperecomputing.com>
Date: Wed, 8 May 2024 11:37:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
To: Anshuman Khandual <anshuman.khandual@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <c9c3c0d5-bb61-4eed-8b89-b0341a2c6f5c@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <c9c3c0d5-bb61-4eed-8b89-b0341a2c6f5c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:930:45::12) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SJ0PR01MB6413:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc4c78d-fb9d-410b-04c3-08dc6f8dde2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFdkU09EenVxZGV4NjM2YlFEeVZ1dWtlRmdqUytzQ0tmNytHWFpTSWZxaFNX?=
 =?utf-8?B?S3BxVkNWaXRXaDZPVnlzbGRNUHJjSDNjTTBXQjRsbnZRdWx6eTQ0akhWSFUx?=
 =?utf-8?B?S2hVa3dwK2lWaHlsY3poY3Uwd21PWnp2RStIc2VrTk5oQ0JFeVM1cTJjaWxs?=
 =?utf-8?B?VVR3dGJFZkVZUGYzSE93b2M1Q2Y1K2VHekNPaGlacUs3VFZJTFNrKzVWYTFk?=
 =?utf-8?B?dXc2SXVkSENCTm90a1M5S2pEd1pyOHRxWU03SVpVZTZ1dHlMTmRRYW53RVZV?=
 =?utf-8?B?NThRcUdqOU9xd1hjV2tRVjdlTUsrUjZQRWgzaDI1WFR0YTIzY09vSzRzSFg0?=
 =?utf-8?B?RklQVTBvNDlod2hITU94ZG1rQmg5T1BFK1FGWDJVUWhEcjhjaWpYanFQL0Jj?=
 =?utf-8?B?VFlmc1hyNW9CNXpreUw0WnU1TyswYmh5WXVlMmtIcHJ6b09BOTRkRDlDOW1n?=
 =?utf-8?B?T0hVZXR4VEJIbGQrN25VSDBLbnVadFEzSjZCVi9ZV2dHNGZIQUJldVo4NWV5?=
 =?utf-8?B?YlI5MjdyazFpeG41Zm9LejZuMEErdk1XbDQ3YUNUMFVmVFIvNUd2V0dWQ2Z3?=
 =?utf-8?B?a0JxNGZ6dzRFcDdwaUthcnhYbjgwd0FuNGFoSzJ0NlRLYlNwcUV3SHl4R2Iy?=
 =?utf-8?B?b1pXT3FBVS9UQlZId2NIVGlaSkdpMEZFYmVzak4wT2QycjZRQ09UQ1FIdU9E?=
 =?utf-8?B?ZUg5ZzA5dmR3VGFxbTMrUXFhMDR2VEhjcktZZmp3Y2w0VVI0UFhpYnlEY3Z6?=
 =?utf-8?B?bTR2VFhjUnd3VnN0T09iRHVFaktxL2I2TVNnNkFLWjdGVUMxYldpb0RIWlgx?=
 =?utf-8?B?a3J1bnp6QkFISjhRY0x6a3RwWkRlaHJHcmxIYTF6TFQ5MVd6a3hQSERPMXFW?=
 =?utf-8?B?S3dGSFF2Y0M0ZGtCTng3VzJqOWNSNXN1aUl4bVhpVG5KRzQyeTc4aHQxSjNv?=
 =?utf-8?B?VlI0d1VtTVBrNVUzUkc4QysyNytyTTVJWWhxYzhsV0xaMjloTUNBZklaTFpL?=
 =?utf-8?B?clhvZ3VvMVRPMjMrTDYzU2Nsc0I4TnBDNS9hTmZSa1FTejkvbnhRTm1TT2lH?=
 =?utf-8?B?aUZwN1h0QVRtQUpsM1BraGRDUEY4Q2lLSDlKNmlPVXhJb3RURlYzb1Vta1Mr?=
 =?utf-8?B?WlRQMUEvVXBUZUp3cFFOZmh4ZGxuNGFJZktzaFhNMkpZU01xUVZaUjd6NEdS?=
 =?utf-8?B?V1NyamlISkhQbEdjYnhPVVoyNXluRFZFMVRaRU5jeFE1SzY0Uno3NVlnZzhk?=
 =?utf-8?B?aE40YmJ6Y09RVkcyb3E5L2kxbTBHdncyMzM2MmhuQ1FYMzZ3L05zeldzSUUw?=
 =?utf-8?B?cnhIcURoeVRCQ0ZJeWp3NmEvL0dXZUVoSzFaZ004N1dEQkkyUWRkeGo1MEYy?=
 =?utf-8?B?elJMOEI1cUhWMld0R1hQNkNkb0RVbVRIMS9Kd3B5L0RKQ0RKa2xHbU50VE9v?=
 =?utf-8?B?WTcwZEs2a0dLMU5ITk1IVkFOckxBalRBZVNpRm1rdml2bXNBV2NQWlhxdlhh?=
 =?utf-8?B?REwweXYySnZ0bVM2RGtmVjdUYjZndDhnU0IvUE92ZU1Ua0Vja0Q3TG5vMkZu?=
 =?utf-8?B?bzQxRnBPZGtzZThGNXhZTWs2RDhYOVhFT00xelRHUkxDK04weXJHaDZRVnVS?=
 =?utf-8?B?K0NUd05LVE9RM0t2aGQxUGVGRVBGZGVUcjR2WCtaVUllNnNSNTV4bmFEVG9n?=
 =?utf-8?B?eDF6dDBrTCtqOFpRZjJDSzNkczBTU2NXWS83MHZsSXlkQ0RtM0RneDlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0d4cUovWTdqekRsSjNLNnFqNjBHbHJNTXBVYjVVZm1HTXR2aGlGcExNaVZF?=
 =?utf-8?B?OU05RkFzSWUvSEtvb2hYeFJJQ2hqdVZrbVV1eVpEeHpYL3dXYkFScHVhZGZw?=
 =?utf-8?B?YVpERksxTmgvU3YrS1V5aWJYYWhMdVptQjg3cVB6SE5QY1h5c3huMDFVcWlk?=
 =?utf-8?B?RjVJZ3U2K1cxMDNTNWM3WlRsVmRpKzNtMnQwNldIQ2VpRHdMRmxmZHphSWlD?=
 =?utf-8?B?cEczRmJOS2NaVmFrWVl1N0xIcmtzUHgvUG1uNXdPcFQ1VFZoaTg5Q2lBcGlH?=
 =?utf-8?B?Tm5UM0QwWkZmZFd2dHlJZXlvWmFCOVk5aUR5YWhudklTcUJsVjVOeUpkSHc2?=
 =?utf-8?B?U00xNHdQaUx4TkRLZTc5K0graFFXRU4vQ0t4WUE1NHQvekVwZ0xobmxCR0ds?=
 =?utf-8?B?TXc0MUc5S0Y3aFIvcXFGbmtyTVJXOE1sT2w1NWliN3BoMWg4TXp2UXpQZysy?=
 =?utf-8?B?NzlTTFlrY0tiUlNWTGZ2UEhGMW1COCszbEhDNXJVVU42STJSQ0R4VW5PdDdl?=
 =?utf-8?B?N2hTbThnMU1uZ2ZBZ3J3V1lZL1BHdVFxdkhhNmFXUEJhL3dWN045ZjhFdTkz?=
 =?utf-8?B?Z09JM1VYazBBOXBJUHRJck1DRFIvMEdrUjdQWGxwa1FZQWJjZ1c3SndCWEZN?=
 =?utf-8?B?Uy9NaTRXOWhtVDBpRWxLVTVMYStTSHJvL2l6NjZRamJnME1EZGN4cnpBT1A3?=
 =?utf-8?B?WGhDbjV1TnF4V3lQY05BaUtLV0N3QzFiWTk2UkJOMzM2V2U5Y0QxN1NWWGNa?=
 =?utf-8?B?SDFsNFd4M0Q0aUNCVWdaVFV6N0FIK1dDbGdzK0xKU3NlVVFHUUZuUWdQWEtV?=
 =?utf-8?B?anhIV09zODU3STExN1V0eEJTR1BXU0ZPMmFOeURTSDYzcFRZbmd3endIMEw2?=
 =?utf-8?B?VzFldVBHamxBYnozTVlkR1pCbUNkbkp2ZzAvZW1qWFExUmR3RWlaYSsvR3dy?=
 =?utf-8?B?cXpLdzQwN3RGUmtBV2xvWGhWS3JveFlxOGl5Zm5mOTNLaWt6RmdWMGJMRlAw?=
 =?utf-8?B?MnIwdktweUl0S1BWSHZGZ2htSzIyYVB3cTU3RFRVd29UV0dTdGtIQ1hocWls?=
 =?utf-8?B?bDFkWkdrSTRtQ2RJVmNndFMzM3pHVTBHVUkwbklmM0JkeGtmZ295UGVpWTRD?=
 =?utf-8?B?eE9DVjU0Uk10YzVqZUpXdC9mWDN0elFwLzNxNUhiMHFLRmMzLzNIeWlud2xM?=
 =?utf-8?B?Z0V4SDZ3M3B3TGxxUFZhS3JjUGZWRUw2Yk5tYkpPZXJPalAwdmxqYXRTQzJV?=
 =?utf-8?B?THI5blJzTWR0a2VQNHdmekJIcncxYkp3L3JWczJWY0lZK1RNZFFvSC9yazdl?=
 =?utf-8?B?WGJPb01paU42QXlNL1o5L0xUQkdOaTlqS045aXhpcG8rMElwM3JVQjZqNHVr?=
 =?utf-8?B?emxxZ2VxZXVEekN0RE9hTUdvUjJhWTJ1S0Y3MXhidkUvYjdoc2VqdDZjSEdX?=
 =?utf-8?B?KzF1Qzd5WndrbWtQRE5neXB2NHphbUJuYmxNUkZCc1VHZktPQnhsVzlvWTZX?=
 =?utf-8?B?N2xmMWNQUndrUTR3NXNwRFBhQmN4Ni9XbHROMmdVSUJzanR0N0RLYW92Ly9J?=
 =?utf-8?B?ZlgyaDBZQVIwN0FVTW0xZHNQUXlmc1pSUTE1ZExLTzViL1ROU2xvWWNTMVZh?=
 =?utf-8?B?ZUpyU0s1K2k5NGJsUENiUHJqRXZHTkhyb1N5cWVKV0ltcHpWV3RnYndZUWN2?=
 =?utf-8?B?ZUpyQnhsckl0NVZEVllVR2VBeFZUeGhnNXhoM01lcnpWVTlaNnFWNnNnTUlz?=
 =?utf-8?B?UGZMMmN2bzgrZWNhR29WZkhHY3pLSnJIUEtjdzNTRnlzRm9LWk1yMURMRkpO?=
 =?utf-8?B?WXRUWGxobW5sVnV5dUZpd1dZMEEzaUpUaDdpZEdTZGNlejVOY0FzMG1FUXdp?=
 =?utf-8?B?WlZobmtRcUFVU1lOTHQ5VVdyTmdLZTcyMW5EYjd6KzMvUW9LYUlsdFhDNjBZ?=
 =?utf-8?B?R09VWHYrK1l2aDNXNHVaSlJVL3k4LzNuV1B5YVowUGhhcGt0aWk0WjRraEtE?=
 =?utf-8?B?Um5vK09XcFA1M3RKSXBQQzdXbjNIN3E3WVU4aHk4cHB4KzN3VTh6dllGdVN3?=
 =?utf-8?B?SS9ISVZZUmtoV29LdTBNOUFEeE8xV3M1dmVDTGZLakEwYWZDaWh2c3lnbEg5?=
 =?utf-8?B?VnZNbko4ZG1MQk1WeHhxemlTV2kvV3NPczdSQTVlVkhRSVB6cFplZWxTaXBV?=
 =?utf-8?Q?CIzmlOMNr6VsquPX0lxEAJE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc4c78d-fb9d-410b-04c3-08dc6f8dde2c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 18:37:09.0100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szlKlNZ2Yx1S3chM/Cg+T66+ZU2QhEav53A066DpBKcvSZEE7kj7iIqPnnAf9pKDSezN+V9a70aEI3svsN+fzhNfZdsZk8/1QJ+0Ux0tc28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB6413



On 5/7/24 11:45 PM, Anshuman Khandual wrote:
> Hello Yang,
>
> On 5/8/24 04:05, Yang Shi wrote:
>> The atomic RMW instructions, for example, ldadd, actually does load +
>> add + store in one instruction, it may trigger two page faults, the
>> first fault is a read fault, the second fault is a write fault.
> It may or it will definitely create two consecutive page faults. What
> if the second write fault never came about. In that case an writable
> page table entry would be created unnecessarily (or even wrongfully),
> thus breaking the CoW.
>
> Just trying to understand, is the double page fault a possibility or
> a certainty. Does that depend on architecture (please do provide some
> links) or is it implementation defined.

Christopher helped answer some questions, I will skip those if I have 
nothing to add.

It is defined in ARM architecture reference manual, so it is not 
implementation defined.

>
>> Some applications use atomic RMW instructions to populate memory, for
>> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
> But why cannot normal store operation is sufficient for pre-touching
> the heap memory, why read-modify-write (RMW) is required instead ?

Memory write is fine, but it depends on applications. For example, JVM 
may want to "permit use of memory concurrently with pretouch". So they 
chose use atomic instead of memory write.

>
>> at launch time) between v18 and v22.
> V18, V22 ?

v18/v19/v20/v21/v22

>
>> But the double page fault has some problems:
>>
>> 1. Noticeable TLB overhead.  The kernel actually installs zero page with
>>     readonly PTE for the read fault.  The write fault will trigger a
>>     write-protection fault (CoW).  The CoW will allocate a new page and
>>     make the PTE point to the new page, this needs TLB invalidations.  The
>>     tlb invalidation and the mandatory memory barriers may incur
>>     significant overhead, particularly on the machines with many cores.
>>
>> 2. Break up huge pages.  If THP is on the read fault will install huge
>>     zero pages.  The later CoW will break up the huge page and allocate
>>     base pages instead of huge page.  The applications have to rely on
>>     khugepaged (kernel thread) to collapse huge pages asynchronously.
>>     This also incurs noticeable performance penalty.
>>
>> 3. 512x page faults with huge page.  Due to #2, the applications have to
>>     have page faults for every 4K area for the write, this makes the speed
>>     up by using huge page actually gone.
> The problems mentioned above are reasonable and expected.
>   
> If the memory address has some valid data, it must have already reached there
> via a previous write access, which would have caused initial CoW transition ?
> If the memory address has no valid data to begin with, why even use RMW ?
>
>> So it sounds pointless to have two page faults since we know the memory
>> will be definitely written very soon.  Forcing write fault for atomic RMW
>> instruction makes some sense and it can solve the aforementioned problems:
>>
>> Firstly, it just allocates zero'ed page, no tlb invalidation and memory
>> barriers anymore.
>> Secondly, it can populate writable huge pages in the first place and
>> don't break them up.  Just one page fault is needed for 2M area instrad
>> of 512 faults and also save cpu time by not using khugepaged.
>>
>> A simple micro benchmark which populates 1G memory shows the number of
>> page faults is reduced by half and the time spent by system is reduced
>> by 60% on a VM running on Ampere Altra platform.
>>
>> And the benchmark for anonymous read fault on 1G memory, file read fault
>> on 1G file (cold page cache and warm page cache) don't show noticeable
>> regression.
>>
>> Some other architectures also have code inspection in page fault path,
>> for example, SPARC and x86.
> Okay, I was about to ask, but is not calling get_user() for all data
> read page faults increase the cost for a hot code path in general for
> some potential savings for a very specific use case. Not sure if that
> is worth the trade-off.

I tested read fault latency (anonymous read fault and file read fault), 
I didn't see noticeable regression.

>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/include/asm/insn.h |  1 +
>>   arch/arm64/mm/fault.c         | 19 +++++++++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index db1aeacd4cd9..5d5a3fbeecc0 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
>>    * "-" means "don't care"
>>    */
>>   __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
>> +__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
>>   
>>   __AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
>>   __AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 8251e2fea9c7..f7bceedf5ef3 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -529,6 +529,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>>   	unsigned long addr = untagged_addr(far);
>>   	struct vm_area_struct *vma;
>> +	unsigned int insn;
>>   
>>   	if (kprobe_page_fault(regs, esr))
>>   		return 0;
>> @@ -586,6 +587,24 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   	if (!vma)
>>   		goto lock_mmap;
>>   
>> +	if (mm_flags & (FAULT_FLAG_WRITE | FAULT_FLAG_INSTRUCTION))
>> +		goto continue_fault;
>> +
>> +	pagefault_disable();
>> +
>> +	if (get_user(insn, (unsigned int __user *) instruction_pointer(regs))) {
>> +		pagefault_enable();
>> +		goto continue_fault;
>> +	}
>> +
>> +	if (aarch64_insn_is_class_atomic(insn)) {
>> +		vm_flags = VM_WRITE;
>> +		mm_flags |= FAULT_FLAG_WRITE;
>> +	}
>> +
>> +	pagefault_enable();
>> +
>> +continue_fault:
>>   	if (!(vma->vm_flags & vm_flags)) {
>>   		vma_end_read(vma);
>>   		goto lock_mmap;


