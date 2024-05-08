Return-Path: <linux-kernel+bounces-173567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE838C0247
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F879282ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139C88F62;
	Wed,  8 May 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RikjX0DZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tDLypvdf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A865C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187133; cv=fail; b=UUq7EUfJheacOp7soaQXefPM3Hxj1vI1yJR/Tv2HuPIk5m0MxI0XSEreKeCyQEa8/6I/7W8IqaR4mtuMlHzFNkZrsXYJE3ta5+zMbsQzvZBoCWaeJc9GHKK8kLKO192ioOr/FUDGQSVd8sK4u9O53wnXFEFZYEkWBvAZhcCW9ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187133; c=relaxed/simple;
	bh=FC8IblqvYP+9iqd3ZZZSJa7XPXcmSt4XyPvweeNKE/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HbdaZ2k7uXuswczT5JLQ09s4spy82uDABKj/b1FMXMRbiz5R1tIsahe0Kc50lMW05FoGHRw+ThNTFVlRTDrPoj2rwy6x2irGF39gWAD+it90G4YFGsXslj+uXYAh0K/YN+cn2UW9y09grqagSJUM90kSY5ZmvtL8JSAL2nsG1N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RikjX0DZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tDLypvdf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CPTUH008192;
	Wed, 8 May 2024 16:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TMQB2Jk23FAHBgsk+nRxhw4k16zi+SVwjm3Yjr5VPZw=;
 b=RikjX0DZhVdwbMXx2O7ZCS52Eg2H1pndR73x4g0ffVm2FXDHOe9v8/7V01KXaJQgK0Cp
 OqXvnlLqjP7SqAU89diHspji9ofeQ33GMjbDulmNJkDjoJ9CEzA0iahOWX5TKFWAGAil
 N7FRSSGh+oxI8nIC9sCa8ZC1TDqxMphEBXOoW6yeBJYGZmPgQjSiyHQh0wIzPZpRoXfD
 6Ci4Cn2o7vIiKgInFaixMMV7vNlcNTsiAz+qVtgSFbg1UBUi/JwLRDvUHTqvxWD+VG6i
 fAXD/Mu49fc9vzb+lMK5TOwy8CLZTSpoNuBGiMR1nxrShnynAC1BEr4blFtkLYI7SFzg RQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfya94k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 16:51:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448G31sl019091;
	Wed, 8 May 2024 16:51:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfkwf0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 16:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCbkjFP0wkp6HZ7tWtLLdIewQw9X7xvNdxUZpMJdm+ZLWnwEdDxhRBJXxujT/xCYAsOzSDmf5/NYujcL67aZWRkWxkhHYrEnBgqlHm9a8dOdMpY3xs+RA8a7fllkp0f/TaIGci5bASvFWy4TaXh5q4Oonf6vdtdntOx7biewzDXzFSkPr2+EgqpIHTjqrkH3Rf0YdQ9tX3oEYuk8S7NxHgEPilO4z98yPzEOhKxKwrZy7RM50kKIODJ0Z3JIbsExTMJ5+brzt8L2odWbXkrlM4lG5AEl/7hqeRGOrx6p/5/GU38AmrnsVKY8QHvAIC6zmA4FK3sbl1ez3y0QCyiRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMQB2Jk23FAHBgsk+nRxhw4k16zi+SVwjm3Yjr5VPZw=;
 b=IO+FIHBkxfQBZAE7YKCnzCNNlvLBczZPAUgLdh/Bw8Xixd/9mqiVWgfbKXc7DNCYAyxsGIiAxKzjFGuxubG8jpZJpxLX1qiq/TnjMMPZEYqg0d+VdYXtqNJQ6Uy7+t9mPhKioDWKqcarnBtqJrodOteT9Rp1ZGfDO94CqU3rVkMLXrsPnc0ae8qGcVD1M8A7BVBWsqOlmVRSB0+4/B9D9WfsRpl2xe8WYG2abnpzQ11RUHhH5f8gVgBy+mBexMSVNx7cMttI5v4D7KFDRdpKM2FDq5nJUl5kAOdje/D8q3GQHMt5lzxlTvI+3BQqbUVfETf89V0fog9mOVKa6Y+zcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMQB2Jk23FAHBgsk+nRxhw4k16zi+SVwjm3Yjr5VPZw=;
 b=tDLypvdf6FQF9p1430O/thtKthyzV6OGz4T2QDY38qGJovpgyIaZBzpLPELaEc+oaQDxxnLk3lxzGfPFtXDEs1lRLO0oGR5ZOP2lFvC0R3HAp8Cf9St+Ct7HkyEn2vWKRenV3lQ3Efyw2lDHag+nWavXdvYtNegIL+4NwAzAZqQ=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by IA0PR10MB6867.namprd10.prod.outlook.com (2603:10b6:208:433::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 16:51:55 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 16:51:55 +0000
Message-ID: <7fd20d16-066d-4ec3-9ca1-e99ff39d3d86@oracle.com>
Date: Wed, 8 May 2024 09:51:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm/memory-failure: try to send SIGBUS even if unmap
 failed
To: Oscar Salvador <osalvador@suse.de>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240501232458.3919593-1-jane.chu@oracle.com>
 <20240501232458.3919593-2-jane.chu@oracle.com>
 <ZjnuJgUVVnwYrr5p@localhost.localdomain>
 <2f965887-19b5-47bf-98ca-d40b3ec05e75@oracle.com>
 <Zjtqqs_ImPIn7I-B@localhost.localdomain>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <Zjtqqs_ImPIn7I-B@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|IA0PR10MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 68454f81-36e7-49d3-33c1-08dc6f7f2abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SlJVbkU2Y29mbHRJOGhDZTlIK0FxS082dTNpR0MvS3l4cmcwK25PbUUxNDk0?=
 =?utf-8?B?WCtvTTVCeWRJbkYrOGpTUEFpRWJ2dE43REVpYXF3Vjg2bHAzTDl5cm5aS1pX?=
 =?utf-8?B?NWkyNWhpWUNPNTc4a0RGSHNGbDN2TXduQVNQWUpSZVdZT0lyd1FKazh1RG5t?=
 =?utf-8?B?YTBuU0NTNUJ1QnkzUjZ0WGoxK3E3eHk5SmhIRkQvTVhRL1NqT0dJN2JrSjdZ?=
 =?utf-8?B?aHFCdks4d1NMd3VydEcvSTJCaTBVdXZ5enh0VzluRWdQcDZnd08yVmF0dm9O?=
 =?utf-8?B?VDZvcTVlbEk3dUVQKzlBaElteDNJbEt1OGdIeVluQWF5S3RnVG5CNXZQZ1dx?=
 =?utf-8?B?UDh5MXJZSzBtZGM0ZW5kd3ZVMkpPOGVySk13ZVpKbjhaMkVyNFU2UUJ5Ykc4?=
 =?utf-8?B?aldtK0M4NE5MenNYZFNtby9xblJFUHJGOC9QaXNzaGJZOVExRGNTNGhLaEVB?=
 =?utf-8?B?VHQvTHowYThZcm9XQUZVK2p1aXMxbWQxU3dOOFFXZXA3aFBnZXF5U0FHNHRN?=
 =?utf-8?B?aUNoYnNwTDI3OWJ6dVU3WTVWOHJCdkIzWjliNHBjWGdibUxZYWVIZUhieWwy?=
 =?utf-8?B?Wm9HbFFmb3FML29nL0x4OXlPRFlYS2IxNUljNWNaZXB6UzdWWTNWcyttZWV1?=
 =?utf-8?B?K3dGVWxwek85d0tFa0tXTXp0emorVTlxc0NDa3lDeGwzeTl5Wnl0b3B2N3hy?=
 =?utf-8?B?L0xkdVpSMGtGMTNXekp3TFJ0cGszUjh1TzNDQTRWalBsSHlmYk92YUhxRzda?=
 =?utf-8?B?WEh1eVRGcG5zV21ZWkRWRG1pS25Mc05BdXBkK05CcXZGMkorL1hTeCtqNjdm?=
 =?utf-8?B?c2prWGUwTTRCYm5JYUVwTFpSK01qK3BYVEl4NTk4ejFoakQrOXRiQy9MdUV3?=
 =?utf-8?B?NWFOUVdqUDBPQ0RucUdxWFhDMFhkRnlrYy9QcFhTTGoxREhCdlpkQjhjYU10?=
 =?utf-8?B?cEQxS2VTRXU0NHptYXQ5Vmp4czVGR1RmdmY3d1VYS1NyLzFxRVlrK2ZabC9U?=
 =?utf-8?B?SU1RRmp3T0Z5SjlVYkpTTjZOZXNxVVBwZngwK3VIWE4ySnRwZjMvWGJhWC9y?=
 =?utf-8?B?bk1mRlNQY201WnJxMk9xWklWWHU4U05ESGZjZkgzdElUdUN5MGJVNlJrV1dY?=
 =?utf-8?B?NDhwWmRuRytHWVdvTFhKREsza1Q1YTU3YzN1WSthZUhOVUcvcDlaUnFGQ0sz?=
 =?utf-8?B?d0pkV1hUNlUwdDFHVS9xeUJpdWIzUzg2SFZSMEFhQkRWMWtLbjAwNlZYNFdR?=
 =?utf-8?B?UU1ZSHhRc2ZrTXRobEIwSGxlNXZrOCt4aU5WVTIwcFdvZ1NoM0xaVWozOFZV?=
 =?utf-8?B?dnFuK0Y5YUVKZWlYamFhME1KZ1JqZFVyNEx2ZGwvWnVGakxHMUN1QjBsZ2Fr?=
 =?utf-8?B?TlJjZ0hHMGlpaXhKTkI5TnY3L1Z1YkRqR3YveGZRN0tNT0FrU1U5emFUSlFU?=
 =?utf-8?B?OUJJcGJiY1dPQkptaFVXMFhZODhCVWh5YzlZZENTMXpja3BGQTdmTjJZTzVz?=
 =?utf-8?B?MnVlUjFJMDViT2hLV212aGRYdVoxRHlrVkp4Q0FROVBBcG9qZnR0aDZUNnJq?=
 =?utf-8?B?Y29kSTNkbmR3NDZrbmhoRVZsdWRabWtXa1NUbGplOUhaOGRSVy84VnRpMi81?=
 =?utf-8?B?YzM1Y1pib2I5czFuSzYrRnVxdmF4SkpkdktxUlJKR0VWSTVVdU4zNFM5bjNN?=
 =?utf-8?B?SzNNelBMaWRNQ3JnV1ViMWNQTkp2S3lpWmU2Y24zZ3NEQVM3cmxKeGhnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dGp0UUpHUlkvQWZ0NExvdTVvdXk0R2I3dG91ODJVQ3F5Q0dwVlVxbElnV1Nz?=
 =?utf-8?B?M2FTanliWWpyaVBRdGtrdy9WSzNjUXA0dmFUMHkrTGFCTHRGalN4ZlBFbWtP?=
 =?utf-8?B?TEVvRkxCdG5PYklQckxUMHhNcWpiYzNaTTBBdElNTFA5RlJpOUR4MDhkbUUy?=
 =?utf-8?B?R2YyM1FIY3ZvZlFRaWxLM1BkbGtIRXFvNzA1VkNZdmhSMEVNL2YrTjRhRHgw?=
 =?utf-8?B?algzeFc2VzhCRCtRbUN3ZGtxM2JLaDZLOTNxN1Z6RWJCaS9FOEZPNmJSNnFw?=
 =?utf-8?B?YUM1V2Q1aHg0aWovbzQ2NVZ6djZNUC8reHgzL1dkeXBySHNNMXhsMjVvcVJj?=
 =?utf-8?B?ZEczV1lpM05iaEhHV2tVazNZMGN6WG9CTVpBRU96Z3hxckZldSsremRjZG9m?=
 =?utf-8?B?dTd1SVZZenhleTdCQ002WStKeUc0T1RadXdvZlJZVG9VeDl4Zm5VVExTYndO?=
 =?utf-8?B?dWdzbkxqdVg3UnZlQ2Y5eFpBdUE3NHgxSEp6ZG03U1g2MXpSckIyRUl6Vm5N?=
 =?utf-8?B?b25RbzBybjNENm0vbm9EVTE0UXQ1b3Z0RUZsMXQ1bXFLWkFkUkRuVUtxUzdx?=
 =?utf-8?B?a3R2Si9mUGJoaW0rTnN1bGIveWtHSmVZZ3JkOVp6OXorcWxmTHJETGU3cFgv?=
 =?utf-8?B?OU9mWlo0dE05Q2dVYWhXUWl5eHdTT1ZtVWdMbHgvQjR3U1Q4U2tkNVBqM0ZP?=
 =?utf-8?B?eGlncWMxeU5DY2FjVUY1Wno4SzNLSmNhb3VPSW5jQWJ4VEkrbXpFc2p2bkVY?=
 =?utf-8?B?dUFMK0JreThYSzRtN3pCdy90TkpCK2pOU2JTUUVmUXRGS2cxN2Q5UkJvdTQ1?=
 =?utf-8?B?STFGbGYreUdnUG0rdThMcGpnYy8vSkJuSXlhWkVTNTlyenphdU5xL1lxOTYx?=
 =?utf-8?B?Nm9acmVDMlF2ejdBWlJoZWw2QUNDTUxwWTNGT0lhbzQrc2ZqR2FSd2ZYbTFw?=
 =?utf-8?B?Qmp2bzVOU1d0MVJvK2Y2cDFBMmgzVnNUMVpidXdDT3l5Tk94d1psOFVtTk05?=
 =?utf-8?B?M2Jxc2xCdmxJTUg1ZUIyUVk4Z1RVc3RvNElOTk13M1V1Uzlad2g1dkthTE03?=
 =?utf-8?B?eVduSHZLVjdrdW1RYXROWFdibHlHa3piQmxGc2pqbmNWTitici9VaDV5dEJj?=
 =?utf-8?B?UHBEaTR6cVA2UFo0TlMxdFpwZFJTQXgwTWFaNGlObkdQcEdYaStNVWN0eDNq?=
 =?utf-8?B?YTF5L0R0UGhEU0E4Y2Noc3AxcnpOVC9pVXlFRGwvRkpleWZFMHhwSFRDdXpk?=
 =?utf-8?B?MVlNMVpXVW1mWWR3WlFPNG1kZzBOcHJzQzZuTHFMS2hqSlN1eUEwSXd3VHVP?=
 =?utf-8?B?RFpuNHlYc05JV2NacFIvamZ3NTYvU0syR0dQYzBFdU5OTFFyMWQrdTk4K1lE?=
 =?utf-8?B?L3Ewd0VmZFJSRUVLeW5INVJTMWpHcUJ2RnJtbzdzSXJTalZRZ3N6ZmtRWmd3?=
 =?utf-8?B?eHk5VzNvdWlURHpTc0xsbG03T0FtR0lLRVlJQVlKa1RLN2JoMCtMMEg2T0tU?=
 =?utf-8?B?K01Ga3JtbEtHUUczbTVuVjh3Y3p4OXkxaW5tNnoyc0hEY1JsZDJRTUR6L2p2?=
 =?utf-8?B?RjJ4R1o5RFYvYTFtZ1AwcHJkMjcySzhEd0VIbGE1a25oQW9iT0VzaEl2VGx4?=
 =?utf-8?B?ZlpPRDh1NGV4TlhCdFdsT05GQ05McnZtQmpqdVVybGoyci9qV2F4NGVBQk5t?=
 =?utf-8?B?bVhqZ09XZ09EY3JCQzRTNklTMjloZFc0cGVYSUJ4Q1dsaWVweFNudXdDVUgv?=
 =?utf-8?B?TndGanFLeHp4L0JuWkcvcjkzS25ocnZMbW1ablVYQ2xLVzdvZFU2VzZ4V2ta?=
 =?utf-8?B?b1F0RWVhdXcrMGMzUzJISllwUkwxdXMvckJVMU9uYmZ3WjF6RW5SUzdFZnVY?=
 =?utf-8?B?WGNYNENWTkcrbmhtSzhFWktNSnRUWDc4dDBYeHpVVE4zbml3Z0xXNDhzZ1p0?=
 =?utf-8?B?RTN5UjMwbXJxVU5rb3Q1TEJHZlFud3VsWTkwdW5memN3Ujl1QUhTNmUyQ0NQ?=
 =?utf-8?B?U1lWNXJuaS91QnVtWExJL3BrQ0tFS2o3eUg4MDVpdkpkeCs5Slk1WTljdmhE?=
 =?utf-8?B?Tld5YlNpeGY3cGdHZnh4SHM2R0JnTDZRS0Jqd0pXT0dtTUt1K2FGS3hjaThx?=
 =?utf-8?Q?OCuRuSZpVRfoHJvTWeJkHdBfm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D9gc4/DBolSqgGHlc/VVUdjWmlaELvXPcKIR7pkIfQ/++4Of6XszEhrA8jG8VfU1mCkNSF3+Zpjv6osnLZcaWQrdhg1eNKFcG+tTgJfhOxln8XHbQTAudsm6e6kBisNiLtERBE/xI86PeuQ6OLoXlgZ4wghswEan+VT5Ur1BvR+WVPIPR40JcyDBORWMYA/0nEFRw3Y+fo6zJ5351AUO9mmM/Fsnd6a8BStoAIEPx7fDRMBXB/zv9hGxjgXww2Jt0sIRRBMI4Yqbd2kIUNdluXXDfGt+I4A8qHTmLE6fVS9KqXAAoyPJ1MsD3EiOzLNgCvQSsUURJM+0fXCOP/U/y02bjzj+a9sbBMO5xzi1dCT9MdNI7HI4fxVAELNGYPag/ZOeQ4vLeQOBKNMXvtkt+mXL5QVis9+3PW5RKucdiJHtQ6phYkouuV1DHdDqNiBQ0JIXrF0fdn4smgn05tAtB3e8rM4R5pkk48MgnYXJnxhzM1IMt5CH9NlPangYgMhoqap0eescgPLp2j7cW2E2l23y4gv+F3htpv4rq29MJ52UOWuXzXs2vlxOR8ix4e/Arq4vQL4jx1RKjU2+bZ+kidpLIkJpliyuG75HWihBgZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68454f81-36e7-49d3-33c1-08dc6f7f2abe
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 16:51:55.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lbgc26fWWr4+J0eKZ8zkpbcarFXfS5Smxm4pQ1OKjdNXjOu3iyPAZV7Sr0jsmpSCl5XFgzGYfHyOZ152MELwiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=945 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080122
X-Proofpoint-GUID: YYbBqB1m4wlmLcdF8WfLksrNqy_MFXMG
X-Proofpoint-ORIG-GUID: YYbBqB1m4wlmLcdF8WfLksrNqy_MFXMG

On 5/8/2024 5:06 AM, Oscar Salvador wrote:

> On Tue, May 07, 2024 at 10:54:10AM -0700, Jane Chu wrote:
>> I actually managed to hit the re-access case with an older version of Linux
>> -
>>
>> MCE occurred, but unmap failed,  no SIGBUS and test process re-access
>>
>> the same address over and over (hence MCE after MCE), as the CPU
>>
>> was unable to make forward progress.   In reality, this issue is fixed with
>>
>> kill_accessing_processes().  The comment for this patch refers to comment
>> made
> So we get a faulty page and we try to unmap it from all processes that
> might have it mapped in their pgtables.
> Prior to this patch we would kill the processes right away and now we
> deliver a SIGBUS.
>
> Seems safe as upon-reaccesing kill_accessing_process() will be called
> for already hwpoisoned pages.
>
> I think the changelog could be made more explicit about this scenario
> and state the role of kill_accessing_process more clear.
>
> With that: Reviewed-by: Oscar Salvador <osalvador@suse.de>
>   

I will revise the changelog and mention kill_accessing_process().

Thanks!

-jane

>

