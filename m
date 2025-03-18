Return-Path: <linux-kernel+bounces-565754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF592A66E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210A53ADBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305351FCF47;
	Tue, 18 Mar 2025 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ks1ocgUU"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2055.outbound.protection.outlook.com [40.107.117.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E61FA14B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287192; cv=fail; b=VbskZII7/4cVQf1HVX8wScV2kNlx6xyJi5UlbCdcJXGtPgcmHsPY3KYKafHpldQ7imLKX6q8bwPaul7F7EXScf6NpcCkLawiQ/egygObQ+qybtB2MhW6zn1N4dMlnDigfLbfOAAYj/k/FFkwr7UBMhQHF2w9ZD17sfFGi2ImQ9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287192; c=relaxed/simple;
	bh=ib3NyFwEXGW51kf6y/CZIQoGNm8MSw7Oc/Nf87cNH5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NdvUgI9rFz1vjJ5E8S8R/iHzWyIgO4UlmTgqZHvO+xvPTD51QWcsLPc0xzXVTEEGjBfEp5oWAcaqjfgUUtudIEjOtQ91ruc7gMFVH4g8EZMlG01EnZPVPwkP8hnu+lZS+ZVeLOhytLVO7dZ3YNlHO/9YdwyYvWuavriVZJGfo6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ks1ocgUU; arc=fail smtp.client-ip=40.107.117.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+Fz1ZzXQBiQ1WLEySenZ8uBeU0+udgHBk9GR6Jb30lOqRZnXJ9N273s15iiR9HntIej6Bc80lDZ98UCIUKnEyvBHI+Iq5clHhYq3fXwu01SO8sgduaBtscfKkgRSUxDimP7ptAwEa5r3LlQugc463/NAx0fQBDW8dr/rbMfh1v7DnfSsvKZenFHCqI5rYSJojCxLXtOizKLD0L1ksyWgFYeeCjdtX0pqHGzvH9kpTwdTTQMLaYKPMn/p0ydTaT9abkwqwSH3QS4anfiwCWBUugb9CEtsKDUBe/rGzH3poq1KflpMj0V6tXny5wgpJScLBcWLw5SEjEdhmkmxFyVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndu3CI4YWxIbKoLPUn5L8d/4DYpRu2MGxiM6gcgGnUk=;
 b=dRystXLUYUZ+XmP0zHQrfnx3kHZufDn0KVntz46InZBc6CGHksaB5U48aqhBIGjc0Hbw3dSea5MWZQ8kqxFWxEIFANdNt8CFc3YY7Q75+ZvWwjH604yt3Lc4tYZuEqrUbsGAS2ARhF+z7hKvHQRlP652StG2/8KjhcDtNsrTGrNUrSsn19mZ5BvhkTCo8qGgzRpq5RdWZ+ivx17WHYJpOsII6XGlSw29dDkKfUM5iwgGAkLJ0SJZXaK52YErZ4hrhtA0csmpnK0bpckCasuBmhxzv2FC7rlNs6d49SHFpinq/c2A6Co/G9PxzZtP+NXrGlqN4rr2kg2hCzvnZfZaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndu3CI4YWxIbKoLPUn5L8d/4DYpRu2MGxiM6gcgGnUk=;
 b=ks1ocgUUUYQbh7JJOwtcBnZRCYpahewKu0V/VNpau7gMXbfbZw29xfOtjHI2eZjv5LXDbIyHqZqhM/cqzpLP8iPk+kZI6RXZSc0rLEYRcM2H3P0ZbupHohvITxdZ9ChR8oJKPV0ubmb9qLcb/ZwVweFmhhDx50KenPlsx+PA8ba2QaIeVCAQef7z2myBCet2WsqkI9YjDIG0eevCFMd4XzXcTL/XM2//oYNny+EXN/z3lPWLHx+hJuxyi7KjwL+NppQuek/Sn9+3qqhNosnDUBsV4OnqqcK/DBI54iCgVpKbz3iiZbUg95Fbvv0gVzog/VYgzbN9qiFhO6OJN/ytVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB6850.apcprd06.prod.outlook.com (2603:1096:990:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:39:45 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 08:39:45 +0000
Message-ID: <bcbbc2e9-858f-46ed-909e-1d911dd614f0@vivo.com>
Date: Tue, 18 Mar 2025 16:39:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc: fix mischeck pfn valid in vmap_pfns
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, bingbu.cao@linux.intel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, opensource.kernel@vivo.com, rppt@kernel.org,
 ryan.roberts@arm.com, urezki@gmail.com, ziy@nvidia.com,
 vivek.kasireddy@intel.com
References: <20250317055304.GB26662@lst.de>
 <5a12454c-16a1-4400-a764-f49293d8dece@vivo.com>
 <20250318064805.GA16121@lst.de>
 <5229b24f-1984-4225-ae03-8b952de56e3b@vivo.com>
 <20250318083330.GB18902@lst.de>
From: Huan Yang <link@vivo.com>
In-Reply-To: <20250318083330.GB18902@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|JH0PR06MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 62c33af8-8f83-4d39-8eac-08dd65f86f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkpvUmhSWFY3NnRtU2RGUWIxZ0xYZkRWWjlOc1FBZWhKeXgwY2ptek1mbnRh?=
 =?utf-8?B?VFJ1ZFZHSEhxSm9TaHQ4U1QyU3VTcXB4cDY0WUF5NzkzM1dUaXMxQjhlVnJL?=
 =?utf-8?B?WmJuU0NGQWRLSlYzNWxuVGxtSWtRN3FUcVEzOEdGendpckVSQkRsbkZjTWpP?=
 =?utf-8?B?VndjUlB6aG0wYUJJZFVUZVhqOUdObExvWS9vYVE3RUpJMlh0emxzUEVZclhT?=
 =?utf-8?B?eFY5R05CN1lmMzN6Uy9lUUR4SGxYaUNtS3g3aXNSUlBIZjQ4TDk3b1prQVBw?=
 =?utf-8?B?L0QveFQzckJzVnhLUURMYkF2MllJZEVSMUNWNjlTaFM5M1JBR2JZdGhQYkFn?=
 =?utf-8?B?TGJxTW5rNW11N29laGY2bDEwNTB4NzdmT3QwZlVaZjg3dnY4Y1o2TFBONW0w?=
 =?utf-8?B?eFhlTTgzaUI5OGw4bDIrQy9RVzdSQ3FrNHJmYS9QWXBVRVFFSFVnUXJhWVRi?=
 =?utf-8?B?YkdhRkJ4dnl1Q1R6bHJzVEpaWG9UbTI0a3A5SkVCVjBFek9xVURkZ1VRTjdq?=
 =?utf-8?B?K2kvaXJTamJaaG0vOVZNdzNTd2c3UVBXY3lpVGdCWkhkZ3NLaUdCUm51Wk50?=
 =?utf-8?B?bi95aVNseHNjN0ROU0NkWVlVWUo1b0w4ZU9hL0pFVFN3LzdnTWk2Z2xFRmRC?=
 =?utf-8?B?LzJBWFNuSEtmNTRaNEl1OVU3ZHRuL2thYjdMRnVudmt6bHh1WmtpRGc4MDd1?=
 =?utf-8?B?MnREZ1JDVXFEaHR2ZGFHK2E4ZWYzcUNSa2xCYnhmenk3b0hscTJaZUNiNjJY?=
 =?utf-8?B?K3VEY3NYVFBTakxYSk5xc0Z0QU1uWUd3dHJTZ0QzdUcxVXZKalhFTEFrQzVL?=
 =?utf-8?B?UVpRS1UvcmVubmV3MVp6WFpaZUUvbTZGYXVlTWcvcFlYMUZwKzNlTFVnZTRo?=
 =?utf-8?B?ZkQ3eDg2S0U2b3BJbHRKd3Q0Q1gyY2MyRGd4OHBpVkpSL00yallGbW9mNTUx?=
 =?utf-8?B?dzJSNFFKQU9JR0VVU3orUDVWek0zRW5nK0NURmFaSUpsUEZlcHlRdjl1cWNE?=
 =?utf-8?B?Z29kcTF6blZHd1MvQmFvNmd0TmlTTnNSNVdWNlhPRTBvQmR2M252UUU5V0c4?=
 =?utf-8?B?dUVmVGZ4QnlCY2dkR2syQi9XdHRVVkZuUHltdkVXMmRRSDNUL0s1V29CeThR?=
 =?utf-8?B?enlidS9lTlM4MEZmTlJsdE5ZRk1BYXJ6b1BmTEhvRlRhQ3ErbnRENWhIQ0R4?=
 =?utf-8?B?Y29BU25GU3RMYWNmTU5NcUVhdEI4b0FXcFpSQ0RHZ3NvSGJaUkFKTjRoNE9h?=
 =?utf-8?B?NU9uYjBQdmhuRkpDMTdlaFJLdENnakJOczBOeHJjSjdxMlZ3L0UvaURDbXdM?=
 =?utf-8?B?cXJZazBqcmhwUFUvM3FPMkZuL2Y2UWpvVkF1UDkxczFVYmZQOTZUQVhNQUcz?=
 =?utf-8?B?QjI0VWllUmRxeGVFUnJlZE1qR3Nxb09nWVUza2RYOUJXRmV6b0pQSUdRMWxp?=
 =?utf-8?B?K2VPWFhpSm9YWHBKdUtXVHF0akY5NUtxbXlrNFI3dk15WjFjSSt3VHhkbEZs?=
 =?utf-8?B?L3h1aisrUERtQ2Z2aU5LSUtpRzdwSTQrSW83N0taRXpxclZyWVEzUjNXNUtW?=
 =?utf-8?B?TGltaVBPRTNtczRyTVVFZWdEd2cxdUNaNVArODVOQ3hyMzNCemZmOFJJVzZO?=
 =?utf-8?B?ekNhSnF2a2w1ZTBzdGFsL3hneEVlV090dzdPMnJha1U0TEpycGFJa25kQUFN?=
 =?utf-8?B?NlZMNWduZzlVbVVxekk3NEUxUFpSeEt0K04wallsdTVobTZJOE9OcUEwVDJh?=
 =?utf-8?B?R2lGc0lmWE5WUis2YzhiandEY0duY0didFgxYXlteE1VYU81alppSUpLbSsx?=
 =?utf-8?B?SkRjRWl5SUFYcTNjdFQzSERuQlpBeXpDODhObE9hajBTQUpCSkFEMHhxMzhC?=
 =?utf-8?B?S1EyNmx0TXMrQnZCY2xwOEk4T3JyZzQrRTJMc1dJMllnVHR5bWVBSkNOanlK?=
 =?utf-8?Q?bMVq4cJKcN1Hr8WVBQqOzb2BYSl7rfCz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGpYRVp4RDlPUHEzR1RETHRxejU3UUpqYWNKQU5zZ2dTeXYwT2JGYXZ5MFFC?=
 =?utf-8?B?aUtsVDkwRFFXRGEwOE1kWEpmeUFubTBjRWlBU25OVy92SnNjZHlCejk0L2RG?=
 =?utf-8?B?ZWhGSHBzdTl5ZHdDME90RzlrdWVvUDRhVWZya2piYWhRcTZ1VkxHWjBvU0wv?=
 =?utf-8?B?UkJtS1pwbGR0ekdYNjdDN2JUUzJON2dPdTdtRkdSSy9LYytDN2UvejlTUk4v?=
 =?utf-8?B?eXhhZkpSYWkrQ0hJQWMxTVd2UUV1S2g2MmxXamtCaGlTRm9HcXp0ZEgrY042?=
 =?utf-8?B?RGJUdkhHb01jS3FzYXkwZTg4TWsyZ2JEUFZzVEJMc2RvQ1I3T3lscml1OFFm?=
 =?utf-8?B?dzhGWFEzZjArUEl6cE1WVE1qZlJjRm5sNmJJVWk2SU0vVlhMVzY1NytMYXpP?=
 =?utf-8?B?dnNGUHBmRHRWV25TZExzbzRwOHhUZFBpcEs0TmJqSFR5TDUyNzB1SnNyVXhT?=
 =?utf-8?B?ajNhQ0JWWldoL1lBTXFMVDgyTDhLYm0yRmJwOElxZ3hNeDZ6L0xFZGh0djAy?=
 =?utf-8?B?YWI0TENKYWhKWTRUaXVvK3Zpc3d2dEtiZHhJYmFsRXE3MEZiSFQxbC9uM0Iw?=
 =?utf-8?B?MldpTm8yb1U1NjA1dTNZbzY0dGNaMWNJUmJIRDNKYlA0ajFmdk9OSHhRWE8z?=
 =?utf-8?B?bkxHTXBjQ0NmOEVNeGpGTDczN0ZMUHBYdUJQaCtLYytXVTN0bHdtWUk0MFRv?=
 =?utf-8?B?WjFXZXNCM2h0dmF1LzQrNlBKNit6QzZlMFNORC9PanZ6dEFuSWFnRytlZE1n?=
 =?utf-8?B?alR4VlVYcVRGOHRXK1JQeG1uZXFkUlVBVkE3a1Q2Snl2VVZqcGZRSlcrd3ZO?=
 =?utf-8?B?cjUwaHZQR2xsa0ZKYnJjK2pGQUJuK09aaUZpcXBZUVRkRE45Tm9KcFpjR1dS?=
 =?utf-8?B?bTd0ZndtTEUyMXlPNGhUNGluN1h6V3ZkSkhCQkhFMFI0NTdrL2VBNTZoSndI?=
 =?utf-8?B?S0YrV1Qvdm9WaVFDVnZSekZzZ0pWckFudS84eWRqRC80dC9Yd0hoWXBSazVu?=
 =?utf-8?B?YkE2T0kwRW9FTGxiNmJ1NnMxMkIrNEVDbXBQTWFHeU9oOXFkS0x2c2NYSmZ1?=
 =?utf-8?B?UG44VUNDaEM4anZrTHFsUkpMUGJyeDJKSTlRcFJTdFdCNjd3SkorMWd1VnNL?=
 =?utf-8?B?UjM1U21yUm1IVG9jYW8vQnJEYlIzcDV6OTU1U1Z2T1VySThtNm5lZCt0dTYr?=
 =?utf-8?B?MWJhcExrS1daWk82S1BQeldZeGRKWDZXZ3RDR3VIS0llNlN2WkNQV20wOFlP?=
 =?utf-8?B?c2Jlck9wai8rVWRaUnlmRVBqNmR4Q2ZLT2l1V2RyU2draElZMjl6N1dRL1Vv?=
 =?utf-8?B?T2xzcHp2R2lVYU5CM2RCbjVlNTZCZDVUdVlhN21uTGhzaTQ1bnJSZStOUWMw?=
 =?utf-8?B?K3lUaFIyNnFENEZpUnNIamtlRkFqUGZEbFd5N3ZPdUsvd2FaQ3ZBRFA4RDl1?=
 =?utf-8?B?eXJGMVVvVHppajE2bjA0SWNESWRVRDNFVUlMbVQ5aU1RN0FESzlyMnlyTVZ3?=
 =?utf-8?B?dDl4aVZQNlNHclZjc2ZKTXZWUE1TaUhNamZFYlljeGgxYlpGWGNwOGtSN1lU?=
 =?utf-8?B?dGhCckZIL2swSmJzZ3NZUmcybGRqaWNXc1RIZ3oybGU2bjNTalJVYlhEU0JC?=
 =?utf-8?B?TWxwVmlUdkVPd3pGZitZclBHRU5HNUhEVU01cnRrYnBnZitCRmlrZXEyaDls?=
 =?utf-8?B?dllXYS9yNm9sdis0M0t4Z3NmSEFNa01vZEtiK29NYVlJMFZ2SldBYkFlUHZE?=
 =?utf-8?B?NUlmSENZSlpZbStuS2NDMDZKS3dkWC9uUEpLWTVRZFRwOWlZUTRKeUtPWG92?=
 =?utf-8?B?eXY3b3IwdEl6dE40VjQ5S2NxcXY4aTRLdXFpVk9BcEQwTURzT2FteTFWTTNt?=
 =?utf-8?B?U2tUWkpkN21sbEtmRUVDUUxjVkllVDRBajQvSEhoUDR6TkxQbFNXL0k3QmQ5?=
 =?utf-8?B?VDdNOHVvb09HMHlMdWdMSUZYU29IUVdEcjhJUjBNdWw4MnNDVXJUYUJkcUdX?=
 =?utf-8?B?Y0dob3plbDk1djg3cWVlQTROcklya1dPaytlUmxZOXE0L2tWaEFrMklzbEdj?=
 =?utf-8?B?WHQ4Y1JOaWMzSkpCZFM3b1NOUXZPeUJlS2JOdEtqL0lld0MzSFJYUEd3UGIw?=
 =?utf-8?Q?f40wmPuPyFaVDS+GxdFlL4n3c?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c33af8-8f83-4d39-8eac-08dd65f86f45
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:39:45.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8yyo5t4dvwrmP4TGTWH3ocA8JKbvR5XHoI/7efbC3Q8PDwRV78r2DISBjuQyFNmXp3te7ht5HgQ9dm2XerPmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6850

HI Christoph

在 2025/3/18 16:33, Christoph Hellwig 写道:
> [You don't often get email from hch@lst.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Tue, Mar 18, 2025 at 04:20:17PM +0800, Huan Yang wrote:
>> This prevents us from properly invoking vmap, which is why we have turned to using vmap_pfn instead.
>>
>> Even if a folio-based vmap is implemented, it still cannot handle mapping multiple folio ranges of physical
>>
>> memory to vmalloc regions. A range of folio is important, it maybe an offset in memfd, no need entire folio.
>>
>> So, I still consider vmap_pfn to be the optimal solution for this specific scenario. :)
> No, vmap_pfn is entirely for memory not backed by pages or folios,
> i.e. PCIe BARs and similar memory.  This must not be mixed with proper
> folio backed memory.
OK, I learn it more.
>
> So you'll need a vmap for folios to support this use case.
May can't
>
>>> historically backed by pages and now folios.
>> So by HVO, it also not backed by pages, only contains folio head, each tail pfn's page struct go away.
> And a fully folios based vmap solves that problem.

A folio may be 2MB or more large 1GB, what if we only need a little, 1M or 512MB, can vmap based on folio can solve it?

Normally, can offer 4k-page based array map it. But consider HVO, can't. That's why wanto base on pfn.

Thank you

Huan Yang

>

