Return-Path: <linux-kernel+bounces-247948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708B192D693
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7E71F272CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C883198846;
	Wed, 10 Jul 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IlhRwYUq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TU+bBp9I"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63284198821
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629052; cv=fail; b=lJwndSidcPN1xWBP3wXlR7VgqCO0FMHaQRQB9j0bcZ2YXcUrNdG4ZziqU249I2RS5kK2jYipYHa9VhBb+0q/F3AsjblRyqfCUD7TYhGZZYbWZS09nHWIWzOINMCRcnE+fCswJxT7AhrNMbDcDuoOl2AqDIudidkNRxeG2/0Hwcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629052; c=relaxed/simple;
	bh=Edjnxy1GQdru9nx0HgxKffpS7YF6Oh0GkeFv+Js/TEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UX7bIMUHk0y58uDPyAgRuI/MlwQ91xYnJeowsnQEMXOJGlW7YrKRPrIVbEVxKcpDVTGR2UdsWWfuwopwcQcrU+FyRuHFzychDv6TKglQxVQOSaHSnmlhjdCypzv/bc7douSbhDz74QI5OdQ2Gh2pS/1HtUKrQRyCLehwAchO++Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IlhRwYUq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TU+bBp9I; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AG4FLF012186;
	Wed, 10 Jul 2024 16:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=uR8p2F9ChcrqVJyzf0bHGxAnXYG70Mf6Wv+z3wTZ5is=; b=
	IlhRwYUqDVKMVc1xA1ThTQB952pc65gm/SjrSOgAnRqzATczDJQijR5R4qljGJaM
	ZmfDXY6tdbdiGHw5Iq5cg6/BQyaF/uN1iu57+5l+jqHbXlVL/PuebDspOr2dz1ad
	ymoTvA/SWuZXiA73X56rmb3RYgOuERvknKBhKO0O40MPUe04raeURBo9bMvYPRO/
	d8ya1uoj72Y6MV0yC8skGdjfehelDTXYuTRnmf+xbUi2wr8NsjoBB08t+VY/8uFk
	OufXDZcLEWPO2o21S49ap7lAw4EBUXQADpfvPG43BbeGTDDlklcD87sBk+ia18FV
	m9pTMGGo4ycvxkkh9rnXYQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsy2hv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 16:30:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AFKlkn008705;
	Wed, 10 Jul 2024 16:30:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv3awbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 16:30:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWBfAQFyfiG9njvD3F8P7fj/nok91e/bDlXHfwQiO2uhzvpesw3zgJoUJDvID/tw5st18U1K1y483jtZdUUbnadq5H98oJHIr2EX+GiOWX6IziOTMK2Mmt255SkyDhwBdvrOnlzPI+JKuifWQ5V6KN7KIbgY4RxuLjf2o/M1DMKJZUoqN3OMTUHC7JKyjVfbJueZ/EOx0kfpHTHKdZsoKdqFJvk09xW0Q9ZbhvwP/hiecXu232Pw1xv2gH+sC0jGMxfxE+MlXFZaApmgLNwv2L2k5o4RDMeD6/M0W5CYiZuIWsNiQi2pSucao4uhuPNPOXxMnEHsOEY+abCgbHHHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uR8p2F9ChcrqVJyzf0bHGxAnXYG70Mf6Wv+z3wTZ5is=;
 b=fQGgn9P9nLwdQqUPwbhUzufWLUDNug8+QjAK0UOLTj4ZIK/hgya+IRVBw2tqWGpfQKiZ/opbBjh5pH4+wKXIVtO9hKb6BLfMxoOi6ltRjlwbkC9PmSINeKgmg4fIz0nyVbDm3Gv+BMCqvh2q1Cr28zwmbsJkX791OSnR19/2txSk6EBgQDIMJFhH9HyuCDVJZrEZyTlNZTjFuJTx2LSxHV6SJ1hgUtc4fw1VHNi7x/DI6NsJjWfgvqd3qAxksqR5Z0QohrALUixbdc73OS1NKGLjN+/svAN4Wb3WvmkEB8GV3OKDyOzraRNGfY/8G8OlQMfHmLzUNBVdBfXxndSn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR8p2F9ChcrqVJyzf0bHGxAnXYG70Mf6Wv+z3wTZ5is=;
 b=TU+bBp9IdA1WHt3rQN9i4qB6cZn4J9AramhUM+pTYahpUPp67lt0N7s+ak/hr/rZMScJeULO9jwmFz0J8V+4zCyQQpz7aN53lt70MmtJk7YMHDRDmaxruQVWdwEcuVXcSP0AuLsonf6p2ifV5O71oyEFLt/q/GkKaMGAgPSjgK4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB7739.namprd10.prod.outlook.com (2603:10b6:806:3a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 16:30:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 16:30:21 +0000
Date: Wed, 10 Jul 2024 12:30:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 05/16] mm/mmap: Introduce vma_munmap_struct for use in
 munmap operations
Message-ID: <du4sbcomhbnuojtav5bsfgkvloiyd5tlqhz5yi2mjx4ew44i5y@dsmfcr7errqa>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-6-Liam.Howlett@oracle.com>
 <a1f1e48c-5aed-4c03-b4d1-b4d4ac85a6de@lucifer.local>
 <jcdeostzaoalxqbtlz4x6egjay2agiox6mg5o744ovfznbxh3i@pdqvicfbbblb>
 <CAJuCfpG+Jok-ySXzRkokU-hrvnLxxMkeufXRMk1tmPLQcgnzNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpG+Jok-ySXzRkokU-hrvnLxxMkeufXRMk1tmPLQcgnzNw@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: faf83fcc-860d-4826-edc0-08dca0fd97d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OFpQdDBZR0NxNFVMZjR3eVhWRGdhbnE2UG1sSG1QazRsNmRNbHAzQVU0amdS?=
 =?utf-8?B?NmpsME1Wa2h1WG0rcWRNY0ROaTFWV0NwNnVHVm5ubmt3YlFnekE3by83ZnhS?=
 =?utf-8?B?QmNCMGwzM0NYUnZBMVdQV2pHOHk3Z282aXlzczhLY1lEalRERm9sT0VId2xk?=
 =?utf-8?B?OVhTeUxzYnhyOVl6aVh0aW1LV1FCT245NDM4NUpqS2ZLck51VFBSbXduMi9D?=
 =?utf-8?B?TXBTVHl2dDBJS3hIcnFXcFljQVRVVjIvVzhnQlpWOEVmN0syK1BYTzBVTWRr?=
 =?utf-8?B?dnd1a1FIZ1NlMFRWQ2thOEpzL05TWHQ4S1NTWUNxTUxGMzRrMjZZTXdtL1pU?=
 =?utf-8?B?SDBpSmV4azJQcHhpdzJSWGhyWjR4bWtuaVdCSStzUXgvbnBsUUFVaUNWZTVz?=
 =?utf-8?B?RUVNeE1sMGR3Y2ltaGdRSnBGRy9ZQW11M1FFRHFCeFRwQWtYR1hvazdLMEtY?=
 =?utf-8?B?TzZsTnlyb3lxOUdmcjU1cW5aK2tYL0tZRDVQYWwzbTFWWi9uVjg1VE9yYlhP?=
 =?utf-8?B?YmhHbE1QbVVGaHVJRjJpTEFMbDBqWnR0cStKWjlkWVdsZGswQTVheFZLREVY?=
 =?utf-8?B?R2JzN2FWU1oreVVSQU5BL3RHRkRKTFBYUitBVFBxUHN5dUFmQjVpWjBOd3hv?=
 =?utf-8?B?bFN3ajNCUm43MTVJbWZTanZsb0s1Y1FUY3lSZFlUS1V1aGZUWjF4WTU4K3Vk?=
 =?utf-8?B?dHFmZjJLQVJ2WVFDVkxDVWdoN1IxbHpUNTlNZ3ordmFUcy96OG9CWWF2RlBq?=
 =?utf-8?B?TFdQRVAyVU8zWVJhVlQ2QkZDTUJNaUZHU1BUZHVyVzZkZFJLSUtMT2Jab04w?=
 =?utf-8?B?MGxmTE10a3UyN1pZYW1kMndnR0VTNkV4bXFNRkpLWE04RGZ0cEdCZVdRQjBr?=
 =?utf-8?B?dmZPZTdYemFiSDRWZDBRWFhya2JlaHRkNitGbXBqYm5ZbUNXTXBBSU1senhK?=
 =?utf-8?B?SGFUWjQxTVNQY0tkM1Urd1FCUDdPaXlFZmNseW9aWnl3OEt3V1B5LzRrYW9E?=
 =?utf-8?B?bVkvVzQxZjdGeHRMbTdISW42QWlFTm1MWkFBZkhXNnpBTGFJYkd3c0ZPOXZT?=
 =?utf-8?B?R3FxZG5RR1MvcHFGUTFNYWxDTURtOEFQOGRPc1lSSWZLbjF0MEVmNDdkNitr?=
 =?utf-8?B?S1dzbmZkb1JoRCt0RGJjSXVFTitxbXAyYUNjY0ZxSEZkUjhBZDkwekJFMllH?=
 =?utf-8?B?b1dDVmlaWVBUdUZVakx2ZlNFMndacENYV1c1eTdxaHNBSUNEY256RlpITnhs?=
 =?utf-8?B?T3ErZTROQWw5L3hlcVcvRmRRQ29JM1lHeHM2UnZCc1VGNkZNUlNjeTdWc0pl?=
 =?utf-8?B?RHA1VHJTRjM0TW9TSzFFQmNkT0JheEs1QmV5NGdkTTRUbEtMSVl4NWs1LzZw?=
 =?utf-8?B?enZlS0h4MW9RODVUbEFqWkRWZDRnWDFuTkw5NDloNXMvRmpYdXNmQWVVZ1J2?=
 =?utf-8?B?WFYrdHlibEx2cVpZZXdra090RGhoVC83QllrN3VUSlBmSlJDREEzd3gxdWhJ?=
 =?utf-8?B?eFNRb2ZPN1lGV095cHhBOGRNODJYZW9wQWxWYmE4eFVuL1RzUGFTM0NDejFS?=
 =?utf-8?B?TDdTeWxzL29iQk0rT1V3Y2VIaWFhOHVPOE5aSlJQV1VCUHZwNDR0UmFQQ0JH?=
 =?utf-8?B?MEVObWt6WWRuZ0tPRWlSSlFkYjlrNVJzNkJNWGpPekV3bFhPaVovS2Q4RW01?=
 =?utf-8?B?b2VLeC8wU3ZqSzM3UWtrSFhNVjFoZDJtMjcxVzViOE9YemtVYXVvZ1V1N2NL?=
 =?utf-8?B?aXlnK2hKTjBpVVRmV1VxREZ4MXh2UVNZMFlpNUJaRnJWS3hjZzU3b0d3TFg5?=
 =?utf-8?B?OWtDYzk4c0dBcGI4VG9VZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzhZTXg2MTZCTERzNjYzSHNCdlc0U1hUSnh0NDJnU09IYzF1WkhDcjVHVjdX?=
 =?utf-8?B?TDNsU3BuTlhyemdza3ptdm5NNXAxZnBKMktoalYrZ1p0NnRDMEI0ZkRKcUtt?=
 =?utf-8?B?aXBjYXl1eU1zako1amZ2MzdGNDZCOCt4WGRobjRSSUdkbGk5KzVhN0o0dXpl?=
 =?utf-8?B?enlSU1kxSk81ZWswblV0dFlkLzdVZ0t6SDZYL1lxbWNRVm42eUJXUU9EN3h4?=
 =?utf-8?B?a1dmWTBiQmJtNWZ1Z29Vek9hV2Z3TWlrUnhUbUU1Tm82QXpCeTJqUWhGdW03?=
 =?utf-8?B?NzhiRHZodnlwL2xWcHk2Mmx5bGNIQlVVeWZ1cTdzS1ZtVko5WmtwZG5uQks4?=
 =?utf-8?B?d3NSZkZVRHNISkY4b1Q5dXBXaDhHdnlZM3VNMThmVjBxWlludkRTK2NDVkht?=
 =?utf-8?B?Q29uL01EcUFvVTBlYzVudDVpTlB2VURyTmNRZ2lBOTE2cUU2Q2x5OVB2ZGdh?=
 =?utf-8?B?aG1LUUdpbU1veS9YRWhFeFdDSlA4N3JhTTRnODNLd1ZLZzB1cDl0MmZrd3F3?=
 =?utf-8?B?M1VOSlppcFRnTjhzbFVnQlgyM3IwWkFHcThVYUdVUitFd2l5dm1PVXFLZTh2?=
 =?utf-8?B?Qnl1L3NSeU9OTDZYTkpTMUx2blZoZVM2UVFPWE9uWll2ZHFObjBDU1cwY3Vu?=
 =?utf-8?B?VVhGR0xBWE0zd2hNeFJDaGhqSWZ1VDcyRm9pdE5iUzE5ODZrSUo4ZFl3S0dF?=
 =?utf-8?B?b3prUi91bEp5RnlvUWowNlhvUlRPbXRSc1lnNXdZTU05SEZVNFNYNFBHRDNr?=
 =?utf-8?B?enhzZVF6b001WHRQNEhTdTdvdXFwRXExM3FLMUhqZkhJaHNMSW0xcnhabkJu?=
 =?utf-8?B?STRMSjN2Z1lhbWdKSWdxK0t6UXFiM2RlaEo5Lzh4c1hRYVZMTDZ2ZnF0aURk?=
 =?utf-8?B?YmVrQnRHeURpaGtGTVRucHk2YitDTXRYR2lzVk5ZcmVtbUVnRG55RFpMM3R0?=
 =?utf-8?B?VEU2ZmEyS2RuTkNQK3YyVytzc3AzK01hMlVwcWNoditZU2xZR2JCZWRjNnJo?=
 =?utf-8?B?clFkcUc4eGtja1VxZWJEcXB1dndjZkt4SzdGeGlHRkRkZUVzV1A0Ukg2WlM4?=
 =?utf-8?B?cm9Yd1FwbEc1Vk92U2hSWFBwYXNkeEQwaVlmRXo0MDJrY2VlVldLRUtDVlZs?=
 =?utf-8?B?V3EzUlA1UlhRTU5LaVBURmhaczNNSjdNcHBYQjliNTV1N1FkRlZJaWVUREh5?=
 =?utf-8?B?WUNXbXNCWXI2eDNsM2t6RXBxeWIvenN2d0xYRzE5dXJsNjdPcmNTOHJRTDJp?=
 =?utf-8?B?OUlrQkxlb1hXU1R5TytBLy9BWXpZeC82eldpQUpXVWg4UnRlaWtZU2oybVBv?=
 =?utf-8?B?RXhQWnFUQW1sYVhucUdkUUpLNFdmU2o2aVhFYTA1bEtseEZjU3hPdHFObExS?=
 =?utf-8?B?VWFoV0xiOGs5TGRaS3JoMVFuVDdha3dGOVc4ZXVXNW9rNTV6RHh1emhFUWcz?=
 =?utf-8?B?YkQ2MjkzVUhGTThlS3pmWTRLcG5wWk5HcXh2S1VpYjdMejFHRHFsZlRNRU9o?=
 =?utf-8?B?aHU5RGM2WDFGUGQxWVZWMDJBYm04eHBMZC9weURXalcxRkZPZXlpNUNqeERY?=
 =?utf-8?B?QW1uRXZSK0FqdjZqMWpkL05CYXlhclFsZTJLMGNxd0dWaFJjTm9wa2lEZzMx?=
 =?utf-8?B?Rytqczdja3dIMUdHK25NYzJZZkM4YUVvYlRFRXdKeUEvVVdkUzViWVUwTGQv?=
 =?utf-8?B?ZlJkQm1lckxmTkI2a0Rwd1k3T2pla3pBaHNiYk0vVW1hS3NrRG9TNEtoN0t1?=
 =?utf-8?B?blMrSXk3WnNIMTJEWExsaVhTZUkxQlpjU1BGeEh3TUZjOVhETm90TWhUSDRQ?=
 =?utf-8?B?cDNaNVIySHRiVkV5NmRhRVQyL044VEtpUjZEWjh5bVYzQkszOFFMYk9aR0ZO?=
 =?utf-8?B?N0ltOW1adExMcnVUL0tTOWJ1TzNSZnArVTVaL3lCTjFCQzJjR2V6UmgvZHl0?=
 =?utf-8?B?MHJhR3QwS1AyVkJDQUdrVEUvdzcxUVdqUFpBeDNjVDVRbStwdWYyclZUTFZL?=
 =?utf-8?B?K3YzV0lBQWU0ekNGOVcwS3VZWUpJME8rY21aQmV5V2g2KzVxeHA4QndieVIv?=
 =?utf-8?B?RjRlTDVqbGN5b2RsdGVYWC9kWkVZYWREaEs4d08rWHN6WGp5aktsUmVOT0px?=
 =?utf-8?B?YTRwNlZHMy90MDIyMG90eERwMkZqeHRwWDJqeUw3bVdwNFlRNXVweXlXdFBH?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tKCI6NOQhyGtf9prK5KtuHG11n/bsDkX52b2elMLmt5nNbJ3bEz2r0DTvkcnAbrq1TbPwM2Zr/6+S3pcmiwogksuf29o/44Pgn4GvxFnnuhvYqFV3V+C0EhYvRM+MNHzg6S3jVYCWzg76K169YwY8iVc5C9fAKPNINhqkOWphV9MSS/OreI8saHL6CxiMIEzsCBcusnt3ul63t3+CpcbGS4DMH8AEqG0mnyXQlGo+8JHwEm7RL5Hp2cSSZRJUqqF/IPDQ7YQIXvdVZW6LPaaCjIy5YmatZjNLNbQdukx1z+L8ig7J1SVZObIbqxuhVkJggLny9i5zrHuvpHN80A7tqM9du/1Wsot/E9EcD+WsAOBp9gF3kAGQUia+uSCZyhasxeIejL7d78ki7iUSIt861qYObuWQul0KrgmszxUnAvW6h0AY2ZjAldBVUIfxOlyLcX2YLAwlfEZFhpTn91xcwwu7AdcbaIiH7aMbq36KftujUxOB3nNLduxrrYPojyrIORPHk2Ce3EK8OK7X2c6YWYZXiX2B1KBivIWjnu+Yyjj0suIkX/CQljhhiNbiZxZh3ZhfNPOoveEAioNWrlPGFAu5m2ESb59FBYGmoxgWBs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf83fcc-860d-4826-edc0-08dca0fd97d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 16:30:21.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHozee140irEBbCaocOc5b7ukN0Z4qDLBpsgDY9/uqYDDQDvcxzlP/zU4T1FRN3YYO+AgTewuFZ6ovCpM33ypg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_11,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100114
X-Proofpoint-GUID: TbjU5ECTLNpGZuCTc8ufNKfYbJ4BRgy9
X-Proofpoint-ORIG-GUID: TbjU5ECTLNpGZuCTc8ufNKfYbJ4BRgy9

* Suren Baghdasaryan <surenb@google.com> [240710 12:07]:
> On Fri, Jul 5, 2024 at 12:09=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 14:39]:
> > > On Thu, Jul 04, 2024 at 02:27:07PM GMT, Liam R. Howlett wrote:
> > > > Use a structure to pass along all the necessary information and cou=
nters
> > > > involved in removing vmas from the mm_struct.
> > > >
> > > > Update vmi_ function names to vms_ to indicate the first argument
> > > > type change.
> > > >
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  mm/internal.h |  16 ++++++
> > > >  mm/mmap.c     | 137 ++++++++++++++++++++++++++--------------------=
----
> > > >  2 files changed, 88 insertions(+), 65 deletions(-)
> > > >
> > > > diff --git a/mm/internal.h b/mm/internal.h
> > > > index 2ea9a88dcb95..f1e6dea2efcf 100644
> > > > --- a/mm/internal.h
> > > > +++ b/mm/internal.h
> > > > @@ -1481,6 +1481,22 @@ struct vma_prepare {
> > > >     struct vm_area_struct *remove2;
> > > >  };
> > > >
> > > > +/*
> > > > + * vma munmap operation
> > > > + */
> > > > +struct vma_munmap_struct {
> > > > +   struct vma_iterator *vmi;
> > > > +   struct mm_struct *mm;
> > > > +   struct vm_area_struct *vma;     /* The first vma to munmap */
> > > > +   struct list_head *uf;           /* Userfaultfd list_head */
> > > > +   unsigned long start;            /* Aligned start addr */
> > > > +   unsigned long end;              /* Aligned end addr */
> > > > +   int vma_count;                  /* Number of vmas that will be =
removed */
> > > > +   unsigned long nr_pages;         /* Number of pages being remove=
d */
> > > > +   unsigned long locked_vm;        /* Number of locked pages */
> > > > +   bool unlock;                    /* Unlock after the munmap */
> > > > +};
> > >
> > >
> > > I'm a big fan of breaking out and threading state like this through s=
ome of
> > > these more... verbose VMA functions.
> > >
> > > I have a similar idea as part of my long dreamed of 'delete vma_merge=
()'
> > > patch set. Coming soon :)
> > >
> > > > +
> > > >  void __meminit __init_single_page(struct page *page, unsigned long=
 pfn,
> > > >                             unsigned long zone, int nid);
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 8dc8ffbf9d8d..76e93146ee9d 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -500,6 +500,31 @@ static inline void init_vma_prep(struct vma_pr=
epare *vp,
> > > >     init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
> > > >  }
> > > >
> > > > +/*
> > > > + * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
> > > > + * @vms: The vma munmap struct
> > > > + * @vmi: The vma iterator
> > > > + * @vma: The first vm_area_struct to munmap
> > > > + * @start: The aligned start address to munmap
> > > > + * @end: The aligned end address to munmap
> > >
> > > Maybe worth mentioning if inclusive/exclusive.
> >
> > The "address to munmap" isn't specific enough that we are using the sam=
e
> > logic as the munmap call?  That is, the vma inclusive and exclusive for
> > start and end, respectively.
> >
> > Not a big change, either way.
>=20
> +1. Every time I look into these functions with start/end I have to go
> back and check these inclusive/exclusive rules, so mentioning it would
> be helpful.

I am making this clear with the follow in v4:
+       unsigned long start;            /* Aligned start addr (inclusive) *=
/
+       unsigned long end;              /* Aligned end addr (exclusive) */

Any time we deal with the vma it is like this, the maple tree is
inclusive/inclusive.

