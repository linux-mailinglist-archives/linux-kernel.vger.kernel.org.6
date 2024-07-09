Return-Path: <linux-kernel+bounces-246500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D617192C2B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A6A1F26790
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C06A1B86F4;
	Tue,  9 Jul 2024 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="OODOLUqv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2116.outbound.protection.outlook.com [40.107.236.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF31B86CC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546990; cv=fail; b=o7CUdVXWjwYFbv1fmvQQsMyNHuZWOHLgr2o+aSbjgntmbRc+dk3RWBi+VJAtiEWFQT3yITLgxRHe4czi+WW9kLcze7B8KDOiXEoi3TUH5dEJwW3rntc5kA4eIRQe8wRThb+AC+mZorpAbOPPfK2O4q7Qgw8lhanfpEq2dAtreao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546990; c=relaxed/simple;
	bh=DXVmDpEN7xqXuim4Cl1c5+RQy3GkWfU5WYmWhiYz6R8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1x876BWP8nM/vEZ54VqJlXtYyid9QhM3+p+Qtdud5gIb+Jd09PS2m2trWukDwtzEVavZW8lNcPqa9EaWZHc8DKlUIhI+AQDODq4jv1DPYfjw8+Vf9ikDU8dTfOXWQwCIUzplNUF3V2WGe88jDPOg/V2RgBY/yC5gQUN5NaE00U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=OODOLUqv; arc=fail smtp.client-ip=40.107.236.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gexl8HMFM/jxeaPYPNsTZyUTdqwERH0jlwN4T5bHxUfB4fYZegUQptNT9nXKwOpxBrq26GmQ0vDDxzn9B/fAai1toiIlxS74AIdUG/tnjjbP0CMmrHyAzErqvZBoHp71DSKEsdrWaxyn/TWMxl+k/12cFnghiSSAWu57wo9cEameND7ijvmHwYyp3doisJZV5M8J+xKI1ws7FdOVgH7A5U/rO9pqpR9Tl0wLDfRPoHBy/9Fa/VpufPujL0ViC0QydyScwKoyBdJ8u/FcgLe/EvzjerdZnlGUEK5HMsiUKV6DjGdvDEaFNOH4Im+H+OG10rZC26SEJ30K3VrBvsQa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiBaLKXZmERPAW6ghJMm+StpenU7Ej1ee1JSi08tcUA=;
 b=V+OEz/y1qxxi0EGfjh6+zFu5Cc91J9vw9i2X2ZPR7Rt17l8e9T540mvsy4DVkpaZuYJW0eJVNMp1eoiJQCuQLvmKFCxkzE2rLbJMmvDixNw3wKilzFELg5bwZ/MYeE0G4irvcdVR95EiOYMEQJzjQi8jUfL83kN2astkSC3Xf9glroPqG2kEb2MP8QBQdDRCQ+ng9fQoOVNJHl8jYQkVNAdo/aU08jjuh87SvZXkJSNse0fbrgdjlF9fEIKovuOEplbnT90Djhv4AWFAF5iRoC3NA4We9e8+S12ONv85sVUEkyPWcz+YacICIaCgrP2x4LETPBR1T1uV0AqS+nawxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiBaLKXZmERPAW6ghJMm+StpenU7Ej1ee1JSi08tcUA=;
 b=OODOLUqvyk44yzhS6dRYQdDlkIVYOBcBWTLIXuRfcBsYF2hTldleMMYVLPbQnLGP15G+/7k405vsk+2AJSUdOi1SLM1gzQHYBC9v2c6BMWAtZFO5P1r12/FxKY3KhykQMoL3lBATMASGsj0Gh50NSKg8jpDYw099tR0c0NNJAHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5471.prod.exchangelabs.com (2603:10b6:208:11b::13) by
 IA0PR01MB8308.prod.exchangelabs.com (2603:10b6:208:48c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.19; Tue, 9 Jul 2024 17:43:03 +0000
Received: from MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80]) by MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80%7]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 17:43:02 +0000
Message-ID: <b140e3e1-cbf7-4b07-8239-abfe8b85d14c@os.amperecomputing.com>
Date: Tue, 9 Jul 2024 10:42:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hugetlbfs: add MTE support
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com>
 <7a4a60af-e471-484b-a4a3-ed31daaca30b@os.amperecomputing.com>
 <546bf8d4-3680-4af3-8d4d-af2d7c192d04@os.amperecomputing.com>
 <ZoanN7hkWDBjCTu3@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZoanN7hkWDBjCTu3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0129.namprd15.prod.outlook.com
 (2603:10b6:930:68::29) To MN2PR01MB5471.prod.exchangelabs.com
 (2603:10b6:208:11b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5471:EE_|IA0PR01MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 2413d528-c937-429b-0388-08dca03e94c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NTFOQlVwUnNqYUhSZ01hRU1IOFFwWGlKckRrMVJubEEwWllsU0tFaGNVRGJ1?=
 =?utf-8?B?VVgwUm8yeHVkM0E0REgxL1FrMFlnUEZoZmRmMUpiODJjcHdWamRRLzJjZFVa?=
 =?utf-8?B?QlQ4YmxiQTk1WGFUbGpDL2pHZ25HaHBmZEFQdnpYMTRxOS9tMjYvUjNSR0py?=
 =?utf-8?B?eFVKT3RZVW5nWGMzalYySFYvdXhaYXV4eStHK0xIeS9GbUxnaXhrREMwdWEx?=
 =?utf-8?B?Z3c4MXExcHk0UTNCcWtBdW92cWxxQWVHMFNhTEhmMitzSUxJRDB3ckhFRmhM?=
 =?utf-8?B?Z1NJdmNSS2NhTDVGUXAzamZZUHBoaThFK3ppOTNlYVpoK0c4RFdzSWFnVHEv?=
 =?utf-8?B?RUtxcU5TZjhtazFoTVJWOXBZdzc3bGgrL0xSR3plNWdOYVFjYnZzSVZ4Y2xP?=
 =?utf-8?B?ZkZ6QUtJWWIrOWdKM0tSd21PME54YWJLUlk4aE9vUU84UG5NbldtcTFDckZp?=
 =?utf-8?B?cjJoRkV5SUY0RW5Zb0RVNG9BcXJsc3IwRGFqRnVYVjBQVERBTTRzWE9aYzZC?=
 =?utf-8?B?bC9YNHdGMzVLZkdkQmNpUFBWK0JaVlEyeVlQcW5nUWZESVgvTE53M2MwWnN6?=
 =?utf-8?B?M3JKWkZsaXJMN1hyYmNwVFc4YkRBeU1FQklIaENIbEtDemlBZlFWeWNyV2hZ?=
 =?utf-8?B?ODNCcVVrbk5vS3dCMDU0Z2EvWUkvb1VadWdFUld4dFowZTY2QUJwRm5nU0wx?=
 =?utf-8?B?Yjd5aUsxSFd1RnFFWm1IUUV6eCtLNXZLbk9uaTZOeGFWbmF1bmhsNXhtYjBT?=
 =?utf-8?B?alhCSWhXMElpU2RPb1A3SCtsU2RwQU9lTStFL0t2Wk9ZMG1MRFZ0VDdkZDRE?=
 =?utf-8?B?amphNlJIZ1JhTWRMTGVMaGYwam4veEFEMWp2NlpCVHN4YjRHKzlqbUhvbW1x?=
 =?utf-8?B?U1M1b2lMdG9LTEIyUVJXTTFVQW5uSUgzNGJ1c085QytFNndDVFhIV0d4OG0v?=
 =?utf-8?B?NEs2NmJ4cnhNdjIwNWd2RGh3N2R2ZEFiTE9LU2I5SWI0aFpxVVd1TTBiQXlm?=
 =?utf-8?B?TG5EeUlOUG5mejBndkU5YWEzL3N6dFNKWTE4MUpGcnhBWTEyUEdmSFRTNThB?=
 =?utf-8?B?MkZlcXFaMU96Ynk1NmZsOEoyMjdFQzlQOWhHNDFaazk0UHFCSnN0QmoxRlNl?=
 =?utf-8?B?OHMwUHY2dHpxeGFnUjNwcVJGT3p2MFUvL1NpTFpiV2FaOE1tczlNTlRRUEFS?=
 =?utf-8?B?cTAyTGM3STVIVDNJYzl5cTdjVkNTNmxLUTlacHNaZk5WeUNEUUd2ZFhyWWpp?=
 =?utf-8?B?TmxkNFNJR05CY3o2VVlyc3QzS1NvSDZ2dDdDZ0Y4VGdoNG5MMDR1ZU5pZEJL?=
 =?utf-8?B?UVZ0Z1YxY0VDcWJGNUU5QW1sZ0ZiYXU2WkZuWEpSRm9uZTNzUUJyKzBEaXpo?=
 =?utf-8?B?OWNOTTRjTUdRVFovakVYN0lRM05jM1RtT1haYlJaQzI1TmJWZmxOdjh5amFN?=
 =?utf-8?B?U2EwcmIxMG1vencrTVhaVnI1UVVEOUxrYXplUjF4bmVSZ0tqSE9Jcmk0ckRC?=
 =?utf-8?B?ZE9mZHN5R0NvSHRVS3MrR2xkME1hSWpsUzQ2Uy8wOGhOTGNuMzBOQTYvQlRB?=
 =?utf-8?B?QlFNM21QZ0lhOUpMQUxaVGlUb1FmSE9MZ1lzb20rZGpxWVNKUitzU2I5Q2pM?=
 =?utf-8?B?M3hkWmdmWnlOSm5kQjErTW5zY2hreElaMU05L0hFOURPS2s2c1VoYW5YZE14?=
 =?utf-8?B?WXB3a0xteTV6aUlNRnBYSDZQTnlmcUhMelh2SU9rYlVpQmpDbnBJTnlRdDFO?=
 =?utf-8?B?TURIU0gremQ4encvMzAzMDNrNlMxVVNWSEZaV21MemlTek03N2kvZjlUSDJX?=
 =?utf-8?B?dXNOYUtDemZnTWRSM3lxdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5471.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWNMUnhJc1NhUmhWKy9NemNrUUYvUVgwc1JhZjFqU2Q4VytYZncxTTRHRkNN?=
 =?utf-8?B?YmxXSjZqcUZWVzdyeERVRDR2NGZpeHZzY29Fc2ZOK0paNjlCaG41a3dKNURB?=
 =?utf-8?B?OUxKU01lYTQ0NmpNdktFQXVVUDZPWGFBZmt1eWxTeHVVTXBWVnlCMFBaamNS?=
 =?utf-8?B?K29qR3g2UlN3NVJoUjlvV1ErK0xaWVdteGJ0UUF0N0hCZE02YXp3bFhMM0Vi?=
 =?utf-8?B?VGRYeUorSHlvWEl5cWpQYjRwTFBhZmpWVUVtY1RsV1AwT2R5UDExc2xaRGJU?=
 =?utf-8?B?Wmd3WHQzbWhrR2VrWWdlUm5TZFdvOW0yaXY5Y0xaRFBkNkJBeVpDRlRadEt1?=
 =?utf-8?B?RXZTbUN1UllCSGVMcS9oUnpPNEhYRC9WZHBOcFRHQXdsb0pUYnFmU0dWV0E4?=
 =?utf-8?B?cmVlK0dlSXY2YWxoZnpjakZEdS9BUHBOaStXVFpQMUZZeGc0UVBMQmdtT2dT?=
 =?utf-8?B?VlpGK1J6MnlwWm0rOFFiTTM0Sm1HdVY3U2krVC94Um94UWJIc1dLeEhLeklp?=
 =?utf-8?B?eE15bTJNZ2Z0V1pQOVlxczB6YTFmM0tpNHRRVHoyeFNKcCs0bXkzWTZlYUFW?=
 =?utf-8?B?VEhLREdpM3FjQjE4T2ZNQ1pha3JHTmtYbGlucy9FcFVsejVBM3VNbndHVU1z?=
 =?utf-8?B?a1dnUDM1dkNoVDVYbHk0Mi96cVZUUzZSQ1lLV05hcGd3NVkrQTRJWjlXa0J5?=
 =?utf-8?B?ZGc2dkNQU2dzM3R4d0Y2M3ZQTFp3RzJUMHpJTW1ObGtldGFQQW5GeWVhZE1K?=
 =?utf-8?B?OWhEZXVneE1RMlNxMmpGWXEwSk1aUmxZWjZDRWJZN1N4UUdCdmhpNzlHcmk4?=
 =?utf-8?B?bUtZVnNkZ0lsS0VtVG5pN3J1TnZnaGt5TzBSM3FPMjdtQnY4MDJiRUdFM203?=
 =?utf-8?B?ZmtISDF1UUJVelZZZnFKSlQyNEJIVytQdEhqWEF6OE1MbmpiRUp6K3F6WkdH?=
 =?utf-8?B?K3UvVmJFWlNUd215YUd3dnJ5UzlQdENPampXUEZTaHNCQTh6OWl6YnArSm9O?=
 =?utf-8?B?d1dCUnRCSkZmbUJJaUtIZjRna1JGMDk3TWtQblA3NTl3cFVnOTBBaTBoeUQy?=
 =?utf-8?B?eFcrSWlPU1dHSVBTK3ZYSGVrelY2aFhwYWs4WndpQkNhTlAzUzR2ZGw1eUIy?=
 =?utf-8?B?cnFVU3pzZTJBVldDYWdPc3J3VHlNallHWUMvMnZJNWJGYnBQTEhDNUlaL0Vu?=
 =?utf-8?B?VDlqYlVFNHYrOXVFVjcvWVA4aEI3QmZMTDlGRE9MVTVDZXY1T1g3UnBsckht?=
 =?utf-8?B?SlhGR0VSSG5WUjFtRWg4MG5iZXZXV29VQ29ldEYrMHZMa1hseENRYUprTUpO?=
 =?utf-8?B?TjZwK2lSN3NGVnQ0SHNCcXJPVXd4ZWw3NGEwTS9wNXlJRlFLS3JyY0FIWDZi?=
 =?utf-8?B?ZlJpOEdBSXN3ZzFWeVAzZWJZc0JKV05CenErK2VPbnNYYnpYOEl0Y0FzS0kz?=
 =?utf-8?B?OHJ3RjZUTWJ2ZG1oUTNYZWgzd3NxMDBjSWRUTit0YWQ4bGl3T0VYTFFhRlAx?=
 =?utf-8?B?b2l6QTU4T1JGOElMWnNzSUM5TjVJakZhRnNRbjY1OUhYZVF1Z2Jsd202S0d2?=
 =?utf-8?B?WWU3NGdpbTZ0aUdDVFdpOU9RU3RGaDhmcVN3VGFiN1VnQVF6UlAwRmFMYXd1?=
 =?utf-8?B?VE55ZURHR216OGQwQUFMREY4UTN4L3p5Tnh4ZUFIa0NpSEYwV1hZUGc0OHhE?=
 =?utf-8?B?TmRkZ0hRaGxtSmlTSlc4cXZRUkxzamxBdi8vUU1rb2tMdlljYkFES3JwMGxM?=
 =?utf-8?B?SEhnZytwdGFiUW9NSjZhOU5JNUlqcm11NXFoSEt4SFJEZ2trd01MZWFOQWJP?=
 =?utf-8?B?N3JkUlhxN2dSTHVXM1JINXE3TlhPOVRzVmswU21ENVNjMUE1c2g1Q1dXZjJC?=
 =?utf-8?B?d01yNkxHM3dVS0FJdzJuaklIYU14MHkya0orTWIyWE1zY1BoTkpqNWszZTU0?=
 =?utf-8?B?aWU0V1dzSkZUUUh0enBBSUhNbFFFUFIzU3grYnViVUViNVdkbkVKUW82ZEZm?=
 =?utf-8?B?VHVYYWs1SzVPazduUmpZTFo1UU1pMWxtZFFTR3doT1FMUnM1ZjZVUnJyUkpU?=
 =?utf-8?B?YXExZnNLT3VLSzlpeVFyL2NTV1BvUEdvODBrN1Y0SFFueXNMWWN6MXhFR21S?=
 =?utf-8?B?M3VQR2hBamFGaFo4bEdSUm5Ccnc4UmJRS0dibnZsK0t0YVNQNTJmV2k5cWo2?=
 =?utf-8?Q?xGlA8KIcPc7a225guxZW3YA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2413d528-c937-429b-0388-08dca03e94c1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5471.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:43:02.5710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lyMR6gzaoH9kEo+Yhs/mXMeDyF/kOLXpjV4DJ5BNB7KIBRk8gyp//7lYylbMd8wHILJrI+ZZB7oScbxNH4nIJUO0C4ZsIhTJytHBeSJpm+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8308



On 7/4/24 6:44 AM, Catalin Marinas wrote:
> On Tue, Jul 02, 2024 at 05:15:12PM -0700, Yang Shi wrote:
>> On 7/2/24 5:04 PM, Yang Shi wrote:
>>> On 7/2/24 5:34 AM, Catalin Marinas wrote:
>>>> Last time I checked, about a year ago, this was not sufficient. One
>>>> issue is that there's no arch_clear_hugetlb_flags() implemented by your
>>>> patch, leaving PG_arch_{2,3} set on a page. The other issue was that I
>>>> initially tried to do this only on the head page but this did not go
>>>> well with the folio_copy() -> copy_highpage() which expects the
>>>> PG_arch_* flags on each individual page. The alternative was for
>>>> arch_clear_hugetlb_flags() to iterate over all the pages in a folio.
>>> Thanks for pointing this out. I did miss this point. I took a quick look
>>> at when the PG_ flags are set. IIUC, it is set by post_alloc_hook() for
>>> order-0 anonymous folio (clearing page and tags) and set_ptes() for
>>> others (just clear tags), for example, THP and hugetlb.
>>>
>>> I can see THP does set the PG_mte_tagged flag for each sub pages. But it
>>> seems it does not do it for hugetlb if I read the code correctly. The
>>> call path is:
>>>
>>> hugetlb_fault() ->
>>>    hugetlb_no_page->
>>>      set_huge_pte_at ->
>>>        __set_ptes() ->
>>>          __sync_cache_and_tags() ->
>>>
>>>
>>> The __set_ptes() is called in a loop:
>>>
>>> if (!pte_present(pte)) {
>>>          for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
>>>              __set_ptes(mm, addr, ptep, pte, 1);
>>>          return;
>>>      }
>>>
>>> The ncontig and pgsize are returned by num_contig_ptes(). For example,
>>> 2M hugetlb, ncontig is 1 and pgsize is 2M IIUC. So it means actually
>>> just the head page has PG_mte_tagged set. If so the copy_highpage() will
>>> just copy the old head page's flag to the new head page, and the tag.
>>> All the sub pages don't have PG_mte_tagged set.
>>>
>>> Is it expected behavior? I'm supposed we need tags for every sub pages
>>> too, right?
>> We should need something like the below to have tags and page flag set up
>> for each sub page:
>>
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 3f09ac73cce3..528164deef27 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -228,9 +228,12 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned
>> long addr,
>>          int ncontig;
>>          unsigned long pfn, dpfn;
>>          pgprot_t hugeprot;
>> +       unsigned long nr = sz >> PAGE_SHIFT;
>>
>>          ncontig = num_contig_ptes(sz, &pgsize);
>>
>> +       __sync_cache_and_tags(pte, nr);
>> +
>>          if (!pte_present(pte)) {
>>                  for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
>>                          __set_ptes(mm, addr, ptep, pte, 1);
> We only need this for the last loop when we have a present pte. I'd also
> avoid calling __set_ptes(...., 1) if we call the __sync_cache_and_tags()
> here already. Basically just unroll __set_ptes() in set_huge_pte_at()
> and call __set_pte() directly.
>
> It might be better to convert those page flag checks to only happen on
> the head page. My stashed changes from over a year ago (before we had
> more folio conversions) below. However, as I mentioned, I got stuck on
> folio_copy() which also does a cond_resched() between copy_highpage().

We can have the page flags set for head only for hugetlb page. For 
copy_highpage(), we should be able to do something like the below:

if  page_is_head && page_is_hugetlb && page_has_mte_tagged
     set page_mte_tagged flags
     copy tags for all sub pages
else // <-- tail page or non-hugetlb page
     current copy_highpage implementation


The hugetlb folio can't go away under us since migration path should pin 
it so the status of folio is stable. The preemption caused by 
cond_resched() should be fine too due to the pin and the page table 
entry keeps being migration entry until migration is done, so every one 
should just see migration entry and wait for migration is done.

The other concerned user of copy_highpage() is uprobe, but it also pins 
the page then doing copy and it is called with holding write mmap_lock.

IIUC, it should work if I don't miss something. This also should have no 
impact on HVO. The overhead for other users of copy_highpage() should be 
also acceptable.

>
> ---------8<--------------------------------
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index f5bcb0dc6267..a84ad0e46f12 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -49,7 +49,9 @@ static void mte_sync_page_tags(struct page *page, pte_t old_pte,
>   		return;
>   
>   	if (try_page_mte_tagging(page)) {
> -		mte_clear_page_tags(page_address(page));
> +		unsigned long i, nr_pages = compound_nr(page);
> +		for (i = 0; i < nr_pages; i++)
> +			mte_clear_page_tags(page_address(page + i));
>   		set_page_mte_tagged(page);
>   	}
>   }
> @@ -57,22 +59,23 @@ static void mte_sync_page_tags(struct page *page, pte_t old_pte,
>   void mte_sync_tags(pte_t old_pte, pte_t pte)
>   {
>   	struct page *page = pte_page(pte);
> -	long i, nr_pages = compound_nr(page);
> -	bool check_swap = nr_pages == 1;
> +	bool check_swap = !PageCompound(page);
>   	bool pte_is_tagged = pte_tagged(pte);
>   
>   	/* Early out if there's nothing to do */
>   	if (!check_swap && !pte_is_tagged)
>   		return;
>   
> +	/*
> +	 * HugeTLB pages are always fully mapped, so only setting head page's
> +	 * PG_mte_* flags is enough.
> +	 */
> +	if (PageHuge(page))
> +		page = compound_head(page);
> +
>   	/* if PG_mte_tagged is set, tags have already been initialised */
> -	for (i = 0; i < nr_pages; i++, page++) {
> -		if (!page_mte_tagged(page)) {
> -			mte_sync_page_tags(page, old_pte, check_swap,
> -					   pte_is_tagged);
> -			set_page_mte_tagged(page);
> -		}
> -	}
> +	if (!page_mte_tagged(page))
> +		mte_sync_page_tags(page, old_pte, check_swap, pte_is_tagged);
>   
>   	/* ensure the tags are visible before the PTE is set */
>   	smp_wmb();
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 5626ddb540ce..692198d8c0d2 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -1079,7 +1079,7 @@ long kvm_vm_ioctl_mte_copy_tags(struct kvm *kvm,
>   
>   			/* uaccess failed, don't leave stale tags */
>   			if (num_tags != MTE_GRANULES_PER_PAGE)
> -				mte_clear_page_tags(page);
> +				mte_clear_page_tags(page_address(page));
>   			set_page_mte_tagged(page);
>   
>   			kvm_release_pfn_dirty(pfn);
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 31d7fa4c7c14..b531b1d75cda 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1173,11 +1173,10 @@ static void sanitise_mte_tags(struct kvm *kvm, kvm_pfn_t pfn,
>   	if (!kvm_has_mte(kvm))
>   		return;
>   
> -	for (i = 0; i < nr_pages; i++, page++) {
> -		if (try_page_mte_tagging(page)) {
> -			mte_clear_page_tags(page_address(page));
> -			set_page_mte_tagged(page);
> -		}
> +	if (try_page_mte_tagging(page)) {
> +		for (i = 0; i < nr_pages; i++)
> +			mte_clear_page_tags(page_address(page + i));
> +		set_page_mte_tagged(page);
>   	}
>   }
>   
>


