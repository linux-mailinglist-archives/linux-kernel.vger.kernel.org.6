Return-Path: <linux-kernel+bounces-276387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4C49492DF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B24F1F23DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED9318D65C;
	Tue,  6 Aug 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a9rhpBnL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y7USojGm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D688918D64C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954074; cv=fail; b=VLD5lPODPczjbtBNYN9Y3Si/uhiK/uEYZzvMZbjQUAq6+y8rCDpTWcIyh1SrWg76sMXs5E363NKOhLbMVFIpShFv/T9vPpYHfyCehtT76kynpHZ+NleX8sFCTWfH4cGSOaM/gYml7ADUnOS/I2xgn8FY/hJJbIW7WhXHNeC4ruk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954074; c=relaxed/simple;
	bh=EgPFQYZwy0iS0lqP9LXCT087wXyCC2bNC9Iuth5/UTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oa9EtmJZxb59peYoZOIRdCkOBGxR4/BVbdfbo/lLRgn9SnYB+f7W0mhm8QNxyTkWSRuvjTssDfKsckxwVPaDvpehsOVKHF3VnwKe71bwD1WilkakkZoaTB5vjVQWxvPMtzShD850Pzm5/beRnwa2C9MgvZvDYfOrhf+/Aix2rpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a9rhpBnL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y7USojGm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765lGWn001770;
	Tue, 6 Aug 2024 14:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=VaFA4MwFHa9OWUd5dNfLzSU2LaFpGYjYuMgtkxyWbG0=; b=
	a9rhpBnLSvCqIW9y9IqZmc0E30vjW+CCZaXkJkfO9/FySs8clZzyne6/+auryIo2
	7OoSaGR5Ubsf4OASvhIQNuDgGoXRd9gyyocaDAgneOcdtJOkHIANkv9GBu288oK/
	7rgNvvtBQh6zAnYPl2JgoFuaOn7hlA4W9pulgxwHyp/dQjwcJUX5dA/Y7QNcRBYM
	kvKILWAD64u0807vPUE50+nEL5mVpGgz/XshtU0ch4bl5dqjgGnEGDStwkT3MPYc
	zrxUcAHZKzpG+JZDNX0s0dgQdsYB/MNmIMsJVREZCGHy5vqShO8szHvlsFaKgs4O
	Ws0P4a200dmtXWGf0sUabQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfanfu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 14:21:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476E0EMI034980;
	Tue, 6 Aug 2024 14:20:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08xaq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 14:20:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbYz73WTLYExiw/smjHTjYcKDyO73p7lgAqI/jB9UTdnpMF36pKCBkgFI38lV7YqXFeQyNiVW6j6yCAg1oXrj1QPOWeTQ5DfIZgVd1G61H1ScIsWJuVfuS+gIQVJeiykwdcl17+c4OAPTKQXpSq4Uj3OYBbjNx9Ssqin81Dd1zlYxO7ene/+cJ/3sOrfIV9Y5v3B5d+OWrgAFGFxmX9FenS6rbX7X3xzcmqMLjL3xW9kXIDo7y4/Lu/9beJqD1wshdPVhL2ltUXc/6w7yVBWTryx8MoErf9vZERouhbxsC6ZJSuvIXFQs6w402ghWZ+7IEUFfLDPZDHe28vpKH2giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaFA4MwFHa9OWUd5dNfLzSU2LaFpGYjYuMgtkxyWbG0=;
 b=d0NwpBEDbSVf6xfQh1/Vqu2kqX6Tp7fhcFXNYQL9ExfjKHErxPRLmwIM6+sc2hm9p9nCog7q327BUrTejib2tkzqE4ZGI+0SbfWauXHopYyQ7v4u5gevM0+bf0t441ERRd/sook7xMAge2Rh7KK5dPOmirbMhQJcBp8DgFrpuvMpyc0oAzG3bIEzByYavmcz61dInbRrhyRRXhfF5j9cbU626PQ6Hnfry5+dGLEQwBvqoq1TiG0g7lV9ApXJsA6IeJFf3dKMtHHn8X2KaRFV7u8S06UhE3j7I9jbiKa3vlfvh3RCzRPB5K5EuveVa/Ih5WzcYAxkmHDiQyr9TGl6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaFA4MwFHa9OWUd5dNfLzSU2LaFpGYjYuMgtkxyWbG0=;
 b=y7USojGmyeOUdIxeA5E866wBBSLqC3lXO0ZrzkGQHJCc2mYEyOa5q9higfUYeOSWJAxnopvzAVPMUtfMMArJetTRts2SUkyuGaeWqEUqhw0oHH/CJkb5UP6j4NSma1VzKBWceNqf5qJs/OpR5/NVhr+EFjRBjqzyj4RSl+Hhw9Y=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB6888.namprd10.prod.outlook.com (2603:10b6:8:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 14:20:52 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 14:20:52 +0000
Date: Tue, 6 Aug 2024 15:20:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 02/10] mm: introduce vma_merge_struct and abstract merge
 parameters
Message-ID: <654dd596-3875-4ab4-acdf-9e5f547b5551@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
 <20240806144754.447001bc@mordecai.tesarici.cz>
 <ddc4c351-d79f-4654-8e0e-63f22afc146f@lucifer.local>
 <20240806160650.16af656e@mordecai.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806160650.16af656e@mordecai.tesarici.cz>
X-ClientProxiedBy: LO2P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 72841731-7f1f-4349-dd00-08dcb622fa1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVFvY25PYmc2S0w5ZWR5dysrazY3anFVZkR3VjJuQjBUNXNMYnNRVGxabWc1?=
 =?utf-8?B?QjlOZldja2tLNWZ1bVdjOGdwNnp3YThHbTVGcUtPc0hlZmljUlpGZXhpajRt?=
 =?utf-8?B?QmEzdllRSlpPenJUQ21CVWFJbHZmR1BGRm9WM0x3YnIyTXRZSzhrRm9PcXVF?=
 =?utf-8?B?c3R0cVcrb2FBa0J1aCt6MXlFQ0IxZlRoR3hDTTdOaGcrZlRTeCs1VGg1NzNK?=
 =?utf-8?B?U3B4cUpOQXMzbHIySlMwZEJwa21LRFRXZWNhVTZ0R2M2Y3pTZzlueWdFbzc4?=
 =?utf-8?B?a25rajlWYUhMWE53VXZmQWllaEQzck5seWtCMS85UUpVOW5rd3lWQTNzbHFI?=
 =?utf-8?B?MGQ5Q3oxWFRDTXh1VStpZEVXYTJadEI4eFJCQStwOExZZGxXMWNsSVBNa25Y?=
 =?utf-8?B?Mjg1OU1NOVFueDFRdkNud1NsdGxFZEwwQk1uS2g3a0owRStydFBKdGVRV2lm?=
 =?utf-8?B?eCtBczVxN1JoQkNtNTJLbzZIVlh6NTU4aldycFRLTjZDdTlzMmR1WkdvNkZ4?=
 =?utf-8?B?VU03RXk2RG9FdUNxcitGeGxDY0dVUytCRS9tSndpakxuU2NoVGVmT3V3bWdy?=
 =?utf-8?B?a3BsdGpEUTRoU2N6WnlWcVdoeUM3aFNwUjFDU0pCa3crYVF4eExINFpaRVV6?=
 =?utf-8?B?MkpSMlVra2lBU1ZnalNicjlyeWhmaTNFWXhhcG05TEU2YzRYdVM4Yms3dlJi?=
 =?utf-8?B?T0cxVWVYeW91c3BrL1pwdG5UZk9mMlZmRnlESVFkdkU2UlVTeGFnTnZ2eVJ5?=
 =?utf-8?B?NlF6bm5GRHdzTElZMUYyN3VRRC9JTnhKQk9BdStBU2RtZDErQnNlVEQ4aUlI?=
 =?utf-8?B?ekliSlBFcjMycXVGS3JRS2hpYWRHSElhUEdXVHI1YVJyT0JvRjl1aXBEVzRs?=
 =?utf-8?B?Q2wvYlUrUTY5Ryt6a0swTm5seE1JQzJka3N2S0N2Z2JiUnlOSnVScER6bEJx?=
 =?utf-8?B?YVpGQzhXWHF1S2FsWnlQcGgwUWpyV3NOTllYQkFDbDBlWkY4VWxhT2VZSUVE?=
 =?utf-8?B?OGVWd3JEZDBqNEFnVUhVazY4Y09zbTArOUQyUSt1SzBRTGxxSkZQcENIdVlo?=
 =?utf-8?B?dGczMkpWaHpNeW5nelhhRFl3ZjVZbGpGVmpnVSsybU1ya3BidTlxQWd1T1o1?=
 =?utf-8?B?My9rbVJIUTM4TGJjRFdFZFhJM0VtZlpMNmtsZlA4QjVvV050VnVzck1RKzFx?=
 =?utf-8?B?OWp1WEttcHg0cjhzbDVaaTM3dExiYkpIb3VLNms0Zzhzd3RIc0hFRVdYQnh2?=
 =?utf-8?B?Wk9jU0R4RVF5KytZU1hMZW5LQXdIRzkxa1YrWTZJVGhkaTRpdStrSC9kVS9S?=
 =?utf-8?B?VzZRNWJrUmRIUElLMFNtdlZnNC9aRmlvRE81RjdwUEhVNzArcUlLVVhvSTRS?=
 =?utf-8?B?V2RWN3Z2bVJraEo0TG94eDU0Z1l6azNzT0JLRElVWjZlUzRXbTVZQlpxNHVq?=
 =?utf-8?B?QXVwTnNJdVI3T3BHanFWNXZCQmZhc0RkNWU2eFFIb09tSHErWnM4T0Z6RHZk?=
 =?utf-8?B?L3N1Y2ZZQnpmeW0wR1pFSjQyWXhndmlKaE1abTRTMFJTbWNHVStFMkdhNEk0?=
 =?utf-8?B?a3owRUQzSWNYbWFMVDNlTEF3aklveTFLeGpzb1RBaXVJalJ0MWg5NGt5MW84?=
 =?utf-8?B?THd5M3hmcVpKRHZwcmtnMkNWbmtlN2Nsc2tpd1JtUEs2RUxCRkVycGc3Q01m?=
 =?utf-8?B?MmVUYTR5cVBTYTFrc3FBWHRSRURUd1ZNdnlXUFhaZHZ2QWVaeEY4NG1VclFD?=
 =?utf-8?B?OXI2Vll0VFk0d1JScVhMWkJISVdSMlhYV0x6REFJMDVsdUR5R1B6UlNOcFJC?=
 =?utf-8?B?U1B5bWcxcjdGQmNWb2RUZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkxqTHdtZEFENEhDUnoyMW5zM3ZOaFpPaHQvNmhGVFk1SDNpaUdSTGVDbDVv?=
 =?utf-8?B?ZkdYV09ZUU9XQ2sxNnd6NGc3RTJNUjhtTU1Vak5EeU5zZnZKRHZKSzZuejEw?=
 =?utf-8?B?RFdzSDFuV3l0K3NnT1J0UFpEa0d2TW5uSy9tc1ZJblRJS1hKdUpEYy9VSjBV?=
 =?utf-8?B?c3VMbzEwMldlNElOYzlnZjI5ZEZVR3lmS29RU2Z4RG5TYjlTaHdQSXcybDgx?=
 =?utf-8?B?b01iTm1aUXNadG1rc2t0cWhvQVI1Vmk1eFZhUUtaVityUWhFcDl0YnJ1UVk0?=
 =?utf-8?B?THd3eGtBZ01NZzliQjUveERzR3hhTDFkZ1pIV0tsWDBVVTc1cG1BU1NqNnlV?=
 =?utf-8?B?Q0JqWkVPNmZzYWZocUlQMXA0N2cvdUlLZDVNOEJRN05mTlY0QmN1NFlkS3d2?=
 =?utf-8?B?a0tXSTVLUXJxYkN2d3lYMFVkSHJDaDVwMmtBVW04allNcm03SXU2cnN3NXlB?=
 =?utf-8?B?Z2hzT3d1ckRvYm9nS2lLU3lRWmhpNXpHUmVDZGNDa0kxVjc4V1VxSUloVzd3?=
 =?utf-8?B?QndoL2tJVlArbzc2SXlCZkx0anpabkptdGhOUEVXd3I0U2ZTTVJldlhIQTFs?=
 =?utf-8?B?VkJjM3ZmeCtOTURIc2NxY2pRZXQwY01rdXpiSXFFNksxU2hGdE92czVlWVlj?=
 =?utf-8?B?Y3RHV2V2MjlIb291Rk8xVHNHV0hEQ0xJNXN3c1NFcmxja0h5YU12cERlSzVq?=
 =?utf-8?B?dmo3Y1Evb28wb1h4UWdhL01yNkVMdWpvcW9LOEozMFg0VVk3SWJmYWRTRnRO?=
 =?utf-8?B?NFYxZFdCeEl5L1p4T1JDSmNibFhZZUhXOTZ5U2FGSTZkYXhhSTQ5cks5UUR3?=
 =?utf-8?B?T0FCVTRaTWxKdWVETit3b3cxZW13UTNJeEdKejNUanluRUNpMkx4dUhaRkdi?=
 =?utf-8?B?RlkxeG9DWGt2VXFiOERXa0xDVENGeXJ0ZzF3SytiVVBHUFY0b2orQk9wMmpE?=
 =?utf-8?B?UFFzZGIwT0lpNnNUMER4TFBJUHMrVXAxSEFUVFhyQVc2MUNvZ0srelBUM0dO?=
 =?utf-8?B?b2ZIMnVaa2RZR0pXMmFPU3g0VWtoUDlaSklRaHFsSE5KS0VPdG0xRm4xNU02?=
 =?utf-8?B?Q1U2M1NENHk0dG9VVXkyWS9ORFA2ZUdzYzZ0OXI3MzJFVjVTbUZsOW8zWEFk?=
 =?utf-8?B?KzREUEtHMFcwdFRqUEJmTjZIWjZuOUM5MHg4Y0ZhaWh1N3EvWitrYWJtMkpM?=
 =?utf-8?B?NzlIc0NyNXhHTzFaaW8vWDhtQXJOUTI4LzQwMmRmV2d4WTBWUlVaVUVoT1Vr?=
 =?utf-8?B?SU45ZkMwV2NYSWx2eHVKT1ZsMkNIL0VweTlIdTZ2T3lKd2dJaXhhSjB0eXNu?=
 =?utf-8?B?T1lKVzltQzB0R2RnaHBxZU9qSVE4TFJ2bXduN1dqVVpPMUJPdWR4REFvYmhF?=
 =?utf-8?B?aElrazNacHZUd3VKdDVNK3F1MGFTdDBxaGVZR0doeVo3MGY2Qlk0M1dXbUln?=
 =?utf-8?B?QjNsMU8rYVNNWkRKck8weFM5d1hqdUNUNm1UUnJZeFRTS2xIdzd5cER6bHhI?=
 =?utf-8?B?eDVLeHovZ2lLOVdscGJ1ZXA0NEIreVBkVGFTL3hSTmZBbUtyU0lkWjd2TUpZ?=
 =?utf-8?B?ODhVOXkzbFBvakc3aWZyUURxRCttR2hPa0w3Ky8rK0NYRVN4MjN0czNPTHV0?=
 =?utf-8?B?bnlVZWRUcERvaElMeWwyRmJzTVNYT01sRWtpNE9hM2NXNGppamJLZU5YNVl2?=
 =?utf-8?B?eGtIb2pRTVdlNHpLRjU0UGY1NFY3S2Y4dFlpVklTeDBkcGRUZm9YSlpEU25G?=
 =?utf-8?B?MlNHQ1BjQUx4MkNKTjRhVjRyTXYveHBobVVUa0RQSU1HZU04d3RKU2g2bVNw?=
 =?utf-8?B?cjBTZjNYVTJJYjlVS20vYjArYlRHVS96YXlPcmVPY0gwamp1QXIvNHRLSXRC?=
 =?utf-8?B?amlPeEhVVDA2R083VVU5N2FZeUlpMU9lN1E2QUdDQUVzQldMRDh1eDNGR0RT?=
 =?utf-8?B?MGtYS1FZWnc2MW1tTFJjRk1KVHNSMVF6Z0g5ZGNDbFh2NEtjOTl0VmE5VTJQ?=
 =?utf-8?B?T2h6RTYyYUp4NTArcW45Y05qQW94OFNzdjFnNGwzb1p1Vlhmd2JFenp0aEFD?=
 =?utf-8?B?RlJ0OXNuL0gyOWlrRUVyMVRSVldlWjR2YVE0N3dTc3lXdVVsTVJOWFRiaG9z?=
 =?utf-8?B?cE42aXdnN0V1MmZqcndmOG9GTzRvVVkxOThYNldNb2tMeURCbXgrU0s3YnNB?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c8LOg8ksR0aDDpbKHr33Vk3lEPjcv5xv2zriyE8fXIgpkBmUGmjQ7iMDpeHA1E71S4WQ8TVFvTHvqoCxc1ZY43m8d0t10Y/YdF/oOoF/bQEfbOYoWs1suPOjnMUJ3MpAvnfkDC+wU6gklyB0OWS7UKI5j9uRgjRvYM3Em7GcPzYVvddg2/0hlZ1/0pglaoVPR0qlpRkBlqPWJcOpmJ6A6dkB3aGwt/bhHz7Z7+34zwoAPcoZ9m9UgDg+r4rmcGSU5kO3dtTmEZ6YPmNLXasj+WDEQGWhbVfaypwgq6fOkELk2u02f1E3EUM9V6yKy4glF8la9kmAQnwXcQkE1+uGCfEIvsb8XxSfPK4kXJtW5Ep6Md7FgUfKnduW05QSJlzH1II5vvmzpJBYuVGbnTe3YZ0x1msqc+N1eZhmbKEheQiKseL0reMJxdE2oA+VVCdWu6QubC1IWS67G0jLk5J3VAv8+Ic7yE9w1oLuXa41/TXNGLgAyIDdLv/vH9Fx23RNqCTMtow9iQGbV5RfTyDDrifBIX3e6JDpq6u+0LJhjF0Pt766dzFeQ947B1HGlRoQUk+2ZZw3HJJLT3nNg5BbXwdhMRYCRnS1pF5i7yCxwGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72841731-7f1f-4349-dd00-08dcb622fa1a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:20:52.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYk/RNzt31yXtk9WYC7mnaIiJMEH7WA4ZADmtLouxx3TaIraaTaZrOGPhhLQLZCM3oP6J7KigVKYTo7uFf4qlzjku//hpu0yls2XY1i4DAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408060099
X-Proofpoint-GUID: EuEfC1ZMfAcWhwRWKYJDFO-M9GVxmSGI
X-Proofpoint-ORIG-GUID: EuEfC1ZMfAcWhwRWKYJDFO-M9GVxmSGI

On Tue, Aug 06, 2024 at 04:06:50PM GMT, Petr Tesařík wrote:
> On Tue, 6 Aug 2024 14:43:48 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > On Tue, Aug 06, 2024 at 02:47:54PM GMT, Petr Tesařík wrote:
> > > Hi Lorenzo!
> > >
> > > On Mon,  5 Aug 2024 13:13:49 +0100
> > > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > > Rather than passing around huge numbers of parameters to numerous helper
> > > > functions, abstract them into a single struct that we thread through the
> > > > operation.
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >  mm/mmap.c |  76 ++++++++------
> > > >  mm/vma.c  | 297 ++++++++++++++++++++++++++++++++++++++----------------
> > > >  mm/vma.h  |  92 ++++++++---------
> > > >  3 files changed, 294 insertions(+), 171 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index 4a9c2329b09a..f931000c561f 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -1369,9 +1369,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  	unsigned long end = addr + len;
> > > >  	unsigned long merge_start = addr, merge_end = end;
> > > >  	bool writable_file_mapping = false;
> > > > -	pgoff_t vm_pgoff;
> > > >  	int error;
> > > >  	VMA_ITERATOR(vmi, mm, addr);
> > > > +	struct vma_merge_struct vmg = {
> > > > +		.vmi = &vmi,
> > > > +		.start = addr,
> > > > +		.end = end,
> > > > +		.flags = vm_flags,
> > > > +		.pgoff = pgoff,
> > > > +		.file = file,
> > > > +	};
> > > >
> > > >  	/* Check against address space limit. */
> > > >  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> > > > @@ -1405,8 +1412,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  		vm_flags |= VM_ACCOUNT;
> > > >  	}
> > > >
> > > > -	next = vma_next(&vmi);
> > > > -	prev = vma_prev(&vmi);
> > > > +	next = vmg.next = vma_next(&vmi);
> > > > +	prev = vmg.prev = vma_prev(&vmi);
> > >
> > > So, next is now a shortcut for vmg.next, and prev is a shortcut for
> > > vmg.prev. ATM there is only one assignment, so no big deal, but I
> > > wonder if next and prev could be removed instead, same as you replaced
> > > vm_pgoff with vmg.pgoff.
> >
> > It's simply to avoid repeatedly referencing vmg.xxx / at least reduce
> > _some_ churn. Also this will get moved shortly, so it's worth looking at in
> > final form.
>
> I'm not a MM maintainer, so my comments may not be relevant, but my
> experience shows that pointer aliases have a potential to introduce all
> kinds of subtle bugs. That's the reason I generally try to avoid them.

Right, I understand, I don't want to get too deep into a distracting bike
shed when this series is doing something quite major.

If you feel this is absolutely critical, I can adjust this code that I
later delete, if not I suggest leaving it as it is.

>
> >
> > >
> > > Is the resulting code _too_ ugly?
> > >
> > > >  	if (vm_flags & VM_SPECIAL) {
> > > >  		if (prev)
> > > >  			vma_iter_next_range(&vmi);
> > > > @@ -1416,29 +1423,30 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  	/* Attempt to expand an old mapping */
> > > >  	/* Check next */
> > > >  	if (next && next->vm_start == end && !vma_policy(next) &&
> > > > -	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
> > > > -				 NULL_VM_UFFD_CTX, NULL)) {
> > > > +	    can_vma_merge_before(&vmg)) {
> > > >  		merge_end = next->vm_end;
> > > >  		vma = next;
> > > > -		vm_pgoff = next->vm_pgoff - pglen;
> > > > +		vmg.pgoff = next->vm_pgoff - pglen;
> > > > +	}
> > > > +
> > > > +	if (vma) {
> > > > +		vmg.anon_vma = vma->anon_vma;
> > > > +		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
> > > >  	}
> > > >
> > > >  	/* Check prev */
> > > >  	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
> > > > -	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
> > > > -				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
> > > > -		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
> > > > -				       NULL_VM_UFFD_CTX, NULL))) {
> > > > +	    can_vma_merge_after(&vmg)) {
> > > >  		merge_start = prev->vm_start;
> > > >  		vma = prev;
> > > > -		vm_pgoff = prev->vm_pgoff;
> > > > +		vmg.pgoff = prev->vm_pgoff;
> > > >  	} else if (prev) {
> > > >  		vma_iter_next_range(&vmi);
> > > >  	}
> > > >
> > > >  	/* Actually expand, if possible */
> > > >  	if (vma &&
> > > > -	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> > > > +	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
> > > >  		khugepaged_enter_vma(vma, vm_flags);
> > > >  		goto expanded;
> > > >  	}
> > > > @@ -1790,25 +1798,31 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > > >  	 * Expand the existing vma if possible; Note that singular lists do not
> > > >  	 * occur after forking, so the expand will only happen on new VMAs.
> > > >  	 */
> > > > -	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
> > > > -	    can_vma_merge_after(vma, flags, NULL, NULL,
> > > > -				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
> > > > -		vma_iter_config(vmi, vma->vm_start, addr + len);
> > > > -		if (vma_iter_prealloc(vmi, vma))
> > > > -			goto unacct_fail;
> > > > -
> > > > -		vma_start_write(vma);
> > > > -
> > > > -		init_vma_prep(&vp, vma);
> > > > -		vma_prepare(&vp);
> > > > -		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > > > -		vma->vm_end = addr + len;
> > > > -		vm_flags_set(vma, VM_SOFTDIRTY);
> > > > -		vma_iter_store(vmi, vma);
> > > > -
> > > > -		vma_complete(&vp, vmi, mm);
> > > > -		khugepaged_enter_vma(vma, flags);
> > > > -		goto out;
> > > > +	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
> > > > +		struct vma_merge_struct vmg = {
> > > > +			.prev = vma,
> > > > +			.flags = flags,
> > > > +			.pgoff = addr >> PAGE_SHIFT,
> > > > +		};
> > > > +
> > > > +		if (can_vma_merge_after(&vmg)) {
> > > > +			vma_iter_config(vmi, vma->vm_start, addr + len);
> > > > +			if (vma_iter_prealloc(vmi, vma))
> > > > +				goto unacct_fail;
> > > > +
> > > > +			vma_start_write(vma);
> > > > +
> > > > +			init_vma_prep(&vp, vma);
> > > > +			vma_prepare(&vp);
> > > > +			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > > > +			vma->vm_end = addr + len;
> > > > +			vm_flags_set(vma, VM_SOFTDIRTY);
> > > > +			vma_iter_store(vmi, vma);
> > > > +
> > > > +			vma_complete(&vp, vmi, mm);
> > > > +			khugepaged_enter_vma(vma, flags);
> > > > +			goto out;
> > > > +		}
> > > >  	}
> > > >
> > > >  	if (vma)
> > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > index bf0546fe6eab..20c4ce7712c0 100644
> > > > --- a/mm/vma.c
> > > > +++ b/mm/vma.c
> > > > @@ -7,16 +7,18 @@
> > > >  #include "vma_internal.h"
> > > >  #include "vma.h"
> > > >
> > > > -/*
> > > > - * If the vma has a ->close operation then the driver probably needs to release
> > > > - * per-vma resources, so we don't attempt to merge those if the caller indicates
> > > > - * the current vma may be removed as part of the merge.
> > > > - */
> > > > -static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> > > > -		struct file *file, unsigned long vm_flags,
> > > > -		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > > > -		struct anon_vma_name *anon_name, bool may_remove_vma)
> > > > +static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
> > > >  {
> > > > +	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> > > > +	/*
> > > > +	 * If the vma has a ->close operation then the driver probably needs to
> > > > +	 * release per-vma resources, so we don't attempt to merge those if the
> > > > +	 * caller indicates the current vma may be removed as part of the merge,
> > > > +	 * which is the case if we are attempting to merge the next VMA into
> > > > +	 * this one.
> > > > +	 */
> > > > +	bool may_remove_vma = merge_next;
> > > > +
> > >
> > > This variable is used only once. If you want to clarify the double
> > > meaning of the merge_next parameter, consider moving this comment
> > > further down to the conditional and merely renaming the parameter.
> > >
> > > >  	/*
> > > >  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
> > > >  	 * match the flags but dirty bit -- the caller should mark
> > > > @@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> > > >  	 * the kernel to generate new VMAs when old one could be
> > > >  	 * extended instead.
> > > >  	 */
> > > > -	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
> > > > +	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
> > > >  		return false;
> > > > -	if (vma->vm_file != file)
> > > > +	if (vma->vm_file != vmg->file)
> > > >  		return false;
> > > >  	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
> > >
> > > AFAICS this is the only place where may_remove_vma is used.
> >
> > Yes it is, but the point is to document what we're doing. The compiler
> > simplifies all this in the generated code.
>
> What's wrong with moving the comment for this variable before this
> conditional?

Because in kernel-style C you have to put declarations at the top, the
parameter was originally called may_remove_vma, and it's self-documenting
by having that name.

Do note that I ultimately remove this code in patch 10.

This feels very bike-sheddy.

>
> > >
> > > >  		return false;
> > > > -	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
> > > > +	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
> > > >  		return false;
> > > > -	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
> > > > +	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
> > > >  		return false;
> > > >  	return true;
> > > >  }
> > > > @@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
> > > >   * We assume the vma may be removed as part of the merge.
> > > >   */
> > > >  bool
> > > > -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> > > > -		struct anon_vma *anon_vma, struct file *file,
> > > > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > > > -		struct anon_vma_name *anon_name)
> > > > +can_vma_merge_before(struct vma_merge_struct *vmg)
> > > >  {
> > > > -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
> > > > -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> > > > -		if (vma->vm_pgoff == vm_pgoff)
> > > > +	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> > > > +
> > > > +	if (is_mergeable_vma(vmg, true) &&
> > > > +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
> > > > +		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
> > > >  			return true;
> > > >  	}
> > > > +
> > > >  	return false;
> > > >  }
> > > >
> > > > @@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> > > >   *
> > > >   * We assume that vma is not removed as part of the merge.
> > > >   */
> > > > -bool
> > > > -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> > > > -		struct anon_vma *anon_vma, struct file *file,
> > > > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > > > -		struct anon_vma_name *anon_name)
> > > > +bool can_vma_merge_after(struct vma_merge_struct *vmg)
> > > >  {
> > > > -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
> > > > -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> > > > -		pgoff_t vm_pglen;
> > > > -
> > > > -		vm_pglen = vma_pages(vma);
> > > > -		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
> > > > +	if (is_mergeable_vma(vmg, false) &&
> > > > +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> > > > +		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
> > > >  			return true;
> > > >  	}
> > > >  	return false;
> > > > @@ -180,7 +175,7 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> > > >   * VMA Iterator will point to the end VMA.
> > > >   */
> > > >  static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > > > -		       unsigned long addr, int new_below)
> > > > +		       unsigned long addr, bool new_below)
> > > >  {
> > > >  	struct vma_prepare vp;
> > > >  	struct vm_area_struct *new;
> > > > @@ -261,13 +256,14 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > > >   * Split a vma into two pieces at address 'addr', a new vma is allocated
> > > >   * either for the first part or the tail.
> > > >   */
> > > > -static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > > > -		     unsigned long addr, int new_below)
> > > > +static int split_vma(struct vma_merge_struct *vmg, bool new_below)
> > >
> > > IMHO this patch is already long enough. Maybe the type change from int
> > > to bool could be split out to a separate patch to reduce churn here?
> >
> > I don't really understand this comment. This reduces the number of lines of
> > code, and it's a line I have to change anyway, so there'd be _more_ churn
> > to split this out?
> >
> > I don't think this is really all that important, but it'd be very silly to
> > split this out in my opinion.
>
> Possibly a matter of taste. The churn is further down:
>
> >
> > >
> > > >  {
> > > > -	if (vma->vm_mm->map_count >= sysctl_max_map_count)
> > > > +	if (vmg->vma->vm_mm->map_count >= sysctl_max_map_count)
> > > >  		return -ENOMEM;
> > > >
> > > > -	return __split_vma(vmi, vma, addr, new_below);
> > > > +	return __split_vma(vmg->vmi, vmg->vma,
> > > > +			   new_below ? vmg->start : vmg->end,
> > > > +			   new_below);
> > > >  }
> > > >
> > > >  /*
> > > > @@ -712,7 +708,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > > >  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
> > > >  			goto map_count_exceeded;
> > > >
> > > > -		error = __split_vma(vmi, vma, start, 1);
> > > > +		error = __split_vma(vmi, vma, start, true);
>
> Churn here.
>
> > > >  		if (error)
> > > >  			goto start_split_failed;
> > > >  	}
> > > > @@ -725,7 +721,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > > >  	do {
> > > >  		/* Does it split the end? */
> > > >  		if (next->vm_end > end) {
> > > > -			error = __split_vma(vmi, next, end, 0);
> > > > +			error = __split_vma(vmi, next, end, false);
>
> Churn here.
>

Right, this is extremely silly. Churn isn't a synonym for 'literally any
change that you don't think has immediate value'. It implies _significant_
changes made for little to no value.

This is an absolutely tiny change, made when already changing the signature
that improves the code quality.

> But you're right, no big deal.
>

I'm glad we agree on that :)

> > > >  			if (error)
> > > >  				goto end_split_failed;
> > > >  		}
> > > > @@ -934,16 +930,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> > > >   * **** is not represented - it will be merged and the vma containing the
> > > >   *      area is returned, or the function will return NULL
> > > >   */
> > > > -static struct vm_area_struct
> > > > -*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> > > > -	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
> > > > -	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
> > > > -	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > > > -	   struct anon_vma_name *anon_name)
> > > > +static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
> > > >  {
> > > > -	struct mm_struct *mm = src->vm_mm;
> > > > -	struct anon_vma *anon_vma = src->anon_vma;
> > > > -	struct file *file = src->vm_file;
> > > > +	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);
> > > > +	struct vm_area_struct *prev = vmg->prev;
> > > >  	struct vm_area_struct *curr, *next, *res;
> > > >  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> > > >  	struct vm_area_struct *anon_dup = NULL;
> > > > @@ -953,16 +943,18 @@ static struct vm_area_struct
> > > >  	bool merge_prev = false;
> > > >  	bool merge_next = false;
> > > >  	bool vma_expanded = false;
> > > > +	unsigned long addr = vmg->start;
> > > > +	unsigned long end = vmg->end;
> > > >  	unsigned long vma_start = addr;
> > > >  	unsigned long vma_end = end;
> > > > -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> > > > +	pgoff_t pglen = PHYS_PFN(end - addr);
> > > >  	long adj_start = 0;
> > > >
> > > >  	/*
> > > >  	 * We later require that vma->vm_flags == vm_flags,
> > > >  	 * so this tests vma->vm_flags & VM_SPECIAL, too.
> > > >  	 */
> > > > -	if (vm_flags & VM_SPECIAL)
> > > > +	if (vmg->flags & VM_SPECIAL)
> > > >  		return NULL;
> > > >
> > > >  	/* Does the input range span an existing VMA? (cases 5 - 8) */
> > > > @@ -970,27 +962,26 @@ static struct vm_area_struct
> > > >
> > > >  	if (!curr ||			/* cases 1 - 4 */
> > > >  	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> > > > -		next = vma_lookup(mm, end);
> > > > +		next = vmg->next = vma_lookup(mm, end);
> > > >  	else
> > > > -		next = NULL;		/* case 5 */
> > > > +		next = vmg->next = NULL;	/* case 5 */
> > >
> > > Again, is it worth keeping the "next" variable, or could we replace it
> > > with "vmg->next" everywhere?
> >
> > I already responded previously but equally, I'm explicitly using a local
> > variable to keep the code relatively simple and to not be constantly
> > ostensibly dereferencing vmg.
>
> Yeah, sure. OTOH whoever looks at the code may ask why there is both
> "vmg->next" and "next" and if they're really (supposed to be) the same
> thing or if there's a subtle difference.

Again, I ultimately delete this code, so this is not really worth spending
much time on.

>
> Petr T

