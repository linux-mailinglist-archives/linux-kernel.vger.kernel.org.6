Return-Path: <linux-kernel+bounces-281474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 921C494D748
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF654B216E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C61607B0;
	Fri,  9 Aug 2024 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="frJ9f8LH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="alLKnQR7"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648641922DB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231519; cv=fail; b=JjPdfuDBJZkUfES8qvDgXSxyqzjIyKf3j9I+M6WYD48Yy3aG320z7PIRJj0rG7wwne8/cOxmtRsyVb9ZqxKaIthgsRmtSkO27FrxQE6Fgm/XPKqKLNN1fwoFv4WG9ETpbvM63hR+n7AOukUFTyUq50C/TPVIiol0E/ReDkt/ics=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231519; c=relaxed/simple;
	bh=rwxop1UFviu25zIKZQS7w/L26JDUl76SgyEZRAIoyE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RKB8y3pokWlPsLyPv2bnf4JP1vNMnmi4GamBH48SAg2BqJadn41Zgq3u1ZmloEJhRKc8Ig+4pI2KJ4hGQMvgzvHtq3lTYTcCk+Jnufs3x0S3Q1YceKK2+1L3wXnqfw8cbXwfFVuXYc6yKCP5vKvmtqvrjqe9bv6bZOX2t3O3Xvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=frJ9f8LH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=alLKnQR7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479HtXnK027595;
	Fri, 9 Aug 2024 19:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=nGX+ptclnbjVwq2qfCeQiMEAgl3pkpyMutDKsdxXcpM=; b=
	frJ9f8LH/PbkjbGuAjWnt7bhfTFKZAbRIEvs7K0EZ7766dYq4yL3xFhTMxLPfEcR
	LIvTr7fNWq4uJj3KrFUlyxOczKmpqHNt7qF7TAkiI8ARxkYxvdollCpzgMYOtexI
	L2jev2f2N2SkNHGoJ1VP+qxUXWTn9bvg9WsR6Gx5qC8bb45wLAKHPtzFCFyI3yr8
	ryL4HEsaf55B0bX1Iul/OlMjMTC2slg285pqdM5f8i68m9M497hbzWicYzp3Xs9n
	XKULeXY7QzV3YdCbabh6su4Uz2XcCfqxVFTaEzd/GOUM+vbK1FnSrg+7ynOJtBAR
	PDlXGMwRad5n4UbbDDV9XA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfavsfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 19:24:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479JA4Ho021860;
	Fri, 9 Aug 2024 19:24:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0k8y1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 19:24:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njyxRjK1JIRVgef4WTphDn7oMK5vdpdw8XrgdjKHrrxbRqNPWwiPg4+e0GoAyZHl1EO6hdj56ER2iUR14yTWQIzOmKwlmK5OB9wmP0JNBq0So4T3/74ZKGdvzA3E6SKFTCTkU2E6MxRRglDu851pRRTVUygFk3730sL2xkZdDvY9zwW2oz5okFENVBHFtPq14ZdT3t3fBvjw0Dp44VotgqfAl2qrTeFRTIrsJeFHTBIRHZiuABLON7HIh7p/4VCRpYL1fV+GZfUwf6AyAVwBkwMmW/kLWWl3ZZfkbIbFfBqPiFkCXGZO42bUoO9NoDARk8xIOn6l3H8w0tNCk//e6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGX+ptclnbjVwq2qfCeQiMEAgl3pkpyMutDKsdxXcpM=;
 b=Df3qLnjZHVwOV8sIyiBh1T5Urnc6nKjdR0PSUudhuFqGDORTQIQWhQ8Ga0pMswaFGW86YCzd4AqY1Tz/2BnRfOnKW1Eoft/OAUguWkiHMEy6zLtFCxPACGu1RaSGp/oyJTMiMSdph+KpFGxcxeqoffYCw4/BCPfjIXTNq2uKlyMdzEhDYbHFPl8EBZoAhjulfOnfNqwS9XcxZVMsi/uCuq00nyLzjmI2JXppj9lZWtIOKng6ocEMBkYXophckDob4vYkUw1EHrj4UO9qMR8gFpMMZnpdANfxQSxuH7xk4iFFpLcDtQ2k4QwmCvU6PFK+KRrMKxfNTD5stx9LcfYQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGX+ptclnbjVwq2qfCeQiMEAgl3pkpyMutDKsdxXcpM=;
 b=alLKnQR7+yFYRrMLf5jvDVfABXCaUNsMOnX6K3TJrN7yNTxRMKAjFf9QY3BM4cgzaATmlP9wbmV5GOoI7JlysvtL5LHLQ0vOy/Me4PKMxHKCt6nmKsNNT8TZwq/k97gEpITSYjCc7hMFHslyXC7r1loxHn0CYRywzfjjPU9K3bY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Fri, 9 Aug
 2024 19:24:53 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 19:24:53 +0000
Date: Fri, 9 Aug 2024 15:24:51 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, jeffxu@google.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 2/6] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <ljhdwgkfzjgdehfjgvdxa4wyxx4d32kpqqz2pwjse65rasuaeo@nncsuq3ku53o>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, torvalds@linux-foundation.org, 
	jeffxu@google.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-3-pedro.falcato@gmail.com>
 <n3v6ebfiwnk26rvxwtgkingmuduv7gla7kaiasjdvadbrpczlw@d3xjceezvgzc>
 <3hzwtm7jw25ng5gemkp42k5ypkfky25fxeevccnk2d6gcpft32@qwkwofgauqna>
 <CAKbZUD2VV=FOeGhCOb3o5CKBiaV+6JSPoDRwzV1-3t2hZX7rQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKbZUD2VV=FOeGhCOb3o5CKBiaV+6JSPoDRwzV1-3t2hZX7rQw@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d25b364-005f-40ca-ad52-08dcb8a8f219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGN6SWUwejJYRSt2ZjRnSCsvNHBvZStueG9hZnpKUWdEaHpZUDV6THFwSWRP?=
 =?utf-8?B?WDdmRUppdjN1SG5vM0dlSW1SamhLNW1NNW54TmgvM09zMWR4UVB5MG94dURz?=
 =?utf-8?B?cEUrclhWV25sa1htNUZmb3ZoTUFtVGI5MjJOV3M5OXowY3NWK2IxMHpYQmVH?=
 =?utf-8?B?WlNIcDh2RTNYRVg1QU92Yy9OSnBoaXJsa2xrU0dOcy94UUxTbXgrRUNFa1pX?=
 =?utf-8?B?ZldDZUVkV2Z4aVBUVGZSald2bHo4SGhLTVJ2ZEtWYzd0Ulp1a0UwTGcrYnRI?=
 =?utf-8?B?QURRMHVENVIwNEdHRUJtZ3Q1cnBJZEdIVmNPTWtHTnVxOTVtcDZtdG4rSUI1?=
 =?utf-8?B?QlJxa0lmWXJUVkJQNDViTjVSajJVb0NsZFRCbnpWbEhpUERTRVR4UEIrOTUv?=
 =?utf-8?B?WTMwdHJyQ0U1aHU3N1ZWU3VlQmxPd21oWmlwS3VNblJhRGV6enBXQ29jbnEv?=
 =?utf-8?B?bTR5ekVHbVk2eTdHcTJHbjlMSytPVU9sWVNXVUdnc29LRnRNNTdUYWZJNmFR?=
 =?utf-8?B?bUY0NEJPQ0YxTjhkQUZPNE1hR2ZxV3pGb2RoVS81QUVuSWJJWU9FK3BDaUhj?=
 =?utf-8?B?OU1TZDU3UUxPVzJrdksrcExXbCtVVkp3SDk4NXNZMkxKaUc0SHdkY3czYjJp?=
 =?utf-8?B?dm1pVzhiUWR6NW1mVEZYUlZqU0FmTWU0clhiRGJJSldaYnJLbDVyZ2NxWDNG?=
 =?utf-8?B?UHBKeVg2MEp5UU5zQTJ5WUkwZnAzSXBpTHEva0lJcHRaeGpKZjNTU1lnSlo4?=
 =?utf-8?B?cnBsbkNZK05zVTdrbW8yZnBlbStuU01OVnZhNmFjM1VQem9xYzZnckdrYnEx?=
 =?utf-8?B?YzdaeUl1MHBwT0laemZIb1owM0lGd2JPQ3V2bGQ2WDQvU1VNL3BzM1I0bFhw?=
 =?utf-8?B?dE0va2FsQWpOMGRQbUptNmZ6d0JiYi9zRW1zdGtMYy9TUEdMMDBSNWh1Zkto?=
 =?utf-8?B?Z1NEK3FCTW5TY3BRK2MwYW00SzlNQ0QycExiMHI4M3FHVHdtUWdVeDZaNHov?=
 =?utf-8?B?L1FGclhCd3ZyNnkyK0pobzdrMzdaK2ZCaGZRckY4aVFJY1FpMzRuYTJoaVE4?=
 =?utf-8?B?RCtnZkgvQkxJOVZudGM3aTdEeHQ3VG85Y0Q0T29aVk5CWDZtZ2dkM2xZWTgz?=
 =?utf-8?B?R2h4b0c2bmV6ZVY5Yy80QVN2V0ptaVpHeFdTYVQ0c05IQ0pKK2srN3Z3K0Jv?=
 =?utf-8?B?dDZmUkVwYkhyNFVPT0tYdUs4QXRDUlYwSnU0a21hL3BuYno1Zko0VmtZQnRt?=
 =?utf-8?B?alRhUkJBbTB6YytoaitRU0pnQmJURzNSVnIvTWt6eXNLU2FLUEx4TUNiNkNh?=
 =?utf-8?B?L1RiWDFpYlM4ZlFzUUZnUkZ0V1dpaUpXMHRxZ0tpZUhKMW9zd0dPbzc5eTBI?=
 =?utf-8?B?N2lJYVhTU3VFU3V5b25DR3RGSzdGRDRISUQ3M1hscUZTMmJOeXlmRTlkZE55?=
 =?utf-8?B?SCtEVXV4TkJLNC82Z3luUFRjQzBHc3c3eFUyVC90QXJISFg1dVNaWW9Ydzg5?=
 =?utf-8?B?UHhmMk1MTXA2N3ptczJhWmxiZTBQcXhGM2pTb2twRFdpNXhMQ0pFZ0o5VTl3?=
 =?utf-8?B?UGpjNm5OMElybmllYUN2QXJ3NTV4ejJtakVOTXcvV00xQ0ExalllQk5tQW5K?=
 =?utf-8?B?OHBMWEVlMEoxeGFJMGdHUElyRnUzRlExQXZyakJFVHhINy84UisvOHQwdjBY?=
 =?utf-8?B?dmh3QnJPd3cxTmlvUTdrZGJncnpud09Nb3FHTVNIaDRuYlEvNXhobC9HNVR1?=
 =?utf-8?B?VnpRcEY5b1dobXFMb1BId0VIYk1NNHIxSlNUQk8xZXFDQ2F3amdRVVErUVFj?=
 =?utf-8?B?aFNWazBCNk9WRVJvM1N1Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0RLMThWdGNxeDhSNytmaDRpWUNseGI0MlpnbkhEVTZXVEEzbU12UWw0OHdT?=
 =?utf-8?B?UlFYVC8rNlJ1VmsxcFFBWXdyTzYveERDNk9UM2x6cTdVUWdSUzV4dnY1RXhL?=
 =?utf-8?B?VDY2WjQxTGdLQlZlakdsTktqdWczaHhkYTdyaXh4U215V3dTcFhSTDdxb1lB?=
 =?utf-8?B?SzZheW4xTUhueGtIZzZ3T1FBRGVsY3AyTUtZTmtibmlRcVJzdW42ZVpDcDg1?=
 =?utf-8?B?czJ5WnFqaEtRekxpUWl6b2FPYVRaNnRJWGFsTy8wb3JSd1FHL2E4RzFUbGdT?=
 =?utf-8?B?MzA4YjVWQlZUVGNNbERoaExSdnI5QXl0QzE5WVRhNHRPN1dSNG1FbkZWQ1Rr?=
 =?utf-8?B?U1NRbUdWSVJqem9VZ2pvOVVTK3A0OWZTelRXMWs5NUJCU05UbUV4MlkrU2dY?=
 =?utf-8?B?a2hYMk00cHpSOVF1RGprTVl3UTBFakhsanFpTjBodkM1T3N6NFpPNlVLUHdH?=
 =?utf-8?B?NDRQU1piQWZWb1BJZzg3WHNON3dyTVZnVG5xeGUyTUVaa2IzM1Baejhud3RV?=
 =?utf-8?B?U2dSQ2RtZlJhYlRTM0UxdGQ0djgxeHovbys4amcza2I0OHR1VFFoR0hTSWlt?=
 =?utf-8?B?QTNQU0cvelZqZzRwNHlWUzNtcUExQzFTQ2thK0F4SWdTcWkxK0xvbHNjbEw5?=
 =?utf-8?B?dUdmcXprVjNpdEJOWjdYa2s2ZlB0RzVzSGFRc3FjdkxPN1AwT3RNbS9lUXRT?=
 =?utf-8?B?QkpxV0dlZVpHNWtMaWV4T0F2NGtaQmlJaXI5STBIR0JlelE3S3kxMmFhYzR0?=
 =?utf-8?B?WFBkanhzZUNCU015L2NQZm9jWGM3U0Zlc3NYa3NpU0RjU0xnTXdraHdhNmZF?=
 =?utf-8?B?d2s0NnNGV0hRc0ZRQnJpc1ZPL1Nza25XTHd4L2N3ZnZhODIwZy81dGkwY0Qw?=
 =?utf-8?B?UGx3SlJtZ2xYWVVveFBSdUFCYWtiVmtPSDhhb2xsQXJNUlZ6ejYwMzREVER4?=
 =?utf-8?B?d08yN2dMbmxMdTNzQjJ4UEMxcFdSb1MyaHM0NVdQWlNaVXhBdzl5ZWNtaHg1?=
 =?utf-8?B?NzA3STVpNUgrRGxVbElab3NSRDkwaDRMZlQ4a0RlUzdsMVBTTU1OYndCYy9j?=
 =?utf-8?B?L2w4Qm11bjE0VlpqSEMyY3hsbXIxaVgvR0RiMEUweW82TjZGRVRnTTZGRFkv?=
 =?utf-8?B?c08yUnlXN01ETEdaZ0s3THpTWnlyRW5aTVZqOXJGL04xVmdXTFlxWTBVdGky?=
 =?utf-8?B?WHVkeXZocWZCRlBBK29udmhWMFpjSHBlMHVhMTBkOEtOV2NiRm54ZW1idHI3?=
 =?utf-8?B?TkVNY05MUnZxV2d6M2RNd3MyTHo4UUhSRkZnamp1QjhMN1JvVDREdUozVU5v?=
 =?utf-8?B?NS90dyt5a2U3elo4MGpEWCs2OE5HcmYyaktVUzZ5VWxlU2RpTk9OSUYzU3hH?=
 =?utf-8?B?VWphVVlUVlo1Q3B2NGo3Z1VRRWVzelpNZld4QzEySmxRSEUzR3dKRUIzSFI3?=
 =?utf-8?B?a2l0cjA1bWQ1cDJ0VTVoQlBvaEVVVkV1VG5COGo2WkorcTJTdW80VUdneHhx?=
 =?utf-8?B?bnVVNkZ5R1B3UitCU0ZYVHBZQm15ZDlrTzVUd3phSlRWOEtIQW0ybDJQUnlB?=
 =?utf-8?B?a0JNTU81UGUxTytPdHVOSXg5S044WTU5ajBtaEJZaXYrZitWTlVCUi9md0Iz?=
 =?utf-8?B?MXlTM3VwNFZ5aXF1cEFQTDVlM0tuRi9MeHlPdW03R1ZieVVQNnpYakpFSGVl?=
 =?utf-8?B?ZTRlTVN2QVFvMWpoSWZYc0JpdTczMEdiUzFhdWlyTGxXTXljVWlVSDNWb3Zi?=
 =?utf-8?B?YmFBVFVCV0x2QVVCZW44cFc4dWdyQ3QrUTFhTXUzY0pTN3dGV2VrNVdzYUxx?=
 =?utf-8?B?Qi8xWThva3NSZDArRWd0UzVOZ0JNM0YyQ09tOHZKblBpNmsrZXJIZ1ViSUcr?=
 =?utf-8?B?OWlXczNOOEhYRzlKWmgrWTNOa0pzdVlWNlk2QlYycE1sMm9XS2ZxUGZtbkJt?=
 =?utf-8?B?dllyeUhyRGNhYVFYTGdnWjJzV29RQmhCQk9FSUhDei9tT0ZlU2FXbUxtMjVN?=
 =?utf-8?B?OU03ejk3YVg0M05nc0tveFJnaDhqTzNKSFQxczIxUHd2RFMxTmp1UVFtTFhU?=
 =?utf-8?B?OFZXenRsbDNob0dXYWZVTU11SDRyVEU2OE9hZ01jRHBxQU1UK1NDUmZFVVhw?=
 =?utf-8?Q?wOfLGicfe5FAuZcGhXcLtDkgD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9UdKr+wgnTL+TA+KQG2LjY/vRXPZFNZ8frxhzNuUKaw11gylpAXy196sW/UjnYydlFcjMD0EWT7ey8Co2cmUh/zc4TPvIazVb46oY48PBw8p9q99QOzPaL4mZSEe2ScryRgir656dEG33fL5A7EFzCsoukCkUK3FQSUH0NJL64KjHBcvJNRLfzfHf93GTdBZVhfOTCC51xPsLiW0KDxNG5qwGqDf7qeFgE3QHFQAKXlR6XNnx1GxKtOXHxKlyLqzIs9cYiCOzz21bitcoCYOwbtZgfC5pudu87D5Gm/FDzGMDQ6qTs8SpxQc+t9KehphGCN+ICPcCl/CVVp/OqHopq4j5PR1iGS97unQkgvd5Y5JRTx+bdeTR2Oa8CyCm3CWYuVC+vyMD2tviI7ZM+U8FK0Bu3/4W5LXe9WMWYQshvXZ5C54Lp6AsVSe5LDiel2i8F3wLIQFHzJMd4+cWTWwUBJ/Y3ZTdH3yEvqCW5RkApeUYYFuS0R/YmEfkVHZKjmapWX5AwD44NHRey2UpdO9fxS274IsQA0mC/sV53GPFlnLADbaWlinfoHe9Dx8zR6xAtTzfPMpV54V+I3/fAMulDHLbFpBIWSsK5K1PAsjVfI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d25b364-005f-40ca-ad52-08dcb8a8f219
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 19:24:53.7012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9IuqQyCXg3BjjbXKv0BqFLZzKqw/naGt2fGCxg06eBScofhfQ0ykZIbBrfA1lV6+VY5bp8qRU483Yt4Ksi2/XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_16,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090140
X-Proofpoint-GUID: 0lfA9Hc9BKYQjt9oZjw_Jluf8RZbYR-t
X-Proofpoint-ORIG-GUID: 0lfA9Hc9BKYQjt9oZjw_Jluf8RZbYR-t

* Pedro Falcato <pedro.falcato@gmail.com> [240809 14:53]:
> On Fri, Aug 9, 2024 at 5:48=E2=80=AFPM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * Liam R. Howlett <Liam.Howlett@oracle.com> [240809 12:15]:
> > > * Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> > > > We were doing an extra mmap tree traversal just to check if the ent=
ire
> > > > range is modifiable. This can be done when we iterate through the V=
MAs
> > > > instead.
> > > >
> > > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > > ---
> > > >  mm/mmap.c | 13 +------------
> > > >  mm/vma.c  | 23 ++++++++++++-----------
> > > >  2 files changed, 13 insertions(+), 23 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 4a9c2329b09..c1c7a7d00f5 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1740,18 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
> > > >             unsigned long start, unsigned long end, struct list_hea=
d *uf,
> > > >             bool unlock)
> > > >  {
> > > > -   struct mm_struct *mm =3D vma->vm_mm;
> > > > -
> > > > -   /*
> > > > -    * Check if memory is sealed before arch_unmap.
> > > > -    * Prevent unmapping a sealed VMA.
> > > > -    * can_modify_mm assumes we have acquired the lock on MM.
> > > > -    */
> > > > -   if (unlikely(!can_modify_mm(mm, start, end)))
> > > > -           return -EPERM;
> > > > -
> > > > -   arch_unmap(mm, start, end);
> > > > -   return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock=
);
> > > > +   return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf=
, unlock);
> > > >  }
> > > >
> > > >  /*
> > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > index bf0546fe6ea..7a121bcc907 100644
> > > > --- a/mm/vma.c
> > > > +++ b/mm/vma.c
> > > > @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
> > > >             if (end < vma->vm_end && mm->map_count >=3D sysctl_max_=
map_count)
> > > >                     goto map_count_exceeded;
> > > >
> > > > +           /* Don't bother splitting the VMA if we can't unmap it =
anyway */
> > > > +           if (!can_modify_vma(vma)) {
> > > > +                   error =3D -EPERM;
> > > > +                   goto start_split_failed;
> > > > +           }
> > > > +
> > >
> > > Would this check be better placed in __split_vma()?  It could replace
> > > both this and the next chunk of code.
> >
> > not quite.
>=20
> Yeah, I was going to say that splitting a sealed VMA is okay (and we
> allow it on mlock and madvise).

splitting a sealed vma wasn't supposed to be okay.. but it is Jeff's
feature.  Jeff?

>=20
> >
> > >
> > > >             error =3D __split_vma(vmi, vma, start, 1);
> > > >             if (error)
> > > >                     goto start_split_failed;
> > > > @@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
> > > >      */
> > > >     next =3D vma;
> > > >     do {
> > > > +           if (!can_modify_vma(vma)) {
> > > > +                   error =3D -EPERM;
> > > > +                   goto modify_vma_failed;
> > > > +           }
> > > > +
> >
> > This chunk would need to be moved below the end check so that we catch
> > full vma unmaps.
>=20
> Why below the end check? I believe we can avoid the split? Is there
> something I'm missing?
> But I did find a bug, what I really seem to want is:
>=20
>  +           if (!can_modify_vma(next)) {

Good catch.

> instead of (vma). It's somewhat concerning how the mseal selftests
> didn't trip on this?

the end check will call split and will fail in there, if you move the
code as I suggested.

That means, if we aren't splitting, we still have to check the vma, so
the check is necessary.



