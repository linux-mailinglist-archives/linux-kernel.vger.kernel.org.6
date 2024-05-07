Return-Path: <linux-kernel+bounces-171902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05DF8BEA3D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A6A1F236B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E453E28;
	Tue,  7 May 2024 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CjfzW4jY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rwpjtxtm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC21509AC
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102162; cv=fail; b=Pfv5ojHhr3IagdEdbNaGgn/w2u4bo8F2x58+KK/xsoszqwIsjh+cKrR5TPocnPrCBj9o80er8uXt7ZlByI99GSDcAx7rTrbq8Qvqj2A2TJBZzIL8HMYZqj6cxZl3XlGKGa3VNk042tBiSSfW/KEMVO/a2ZEHb26pSKrkeBx+f7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102162; c=relaxed/simple;
	bh=GjcXGSmlo7F8Twn+z1GjCNkw100J8LdshnB58zieSkk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XZSo0STSlVeBfGSuwG+GZkfxr4+v9BSps983lKv4ElyXZ9X/NPo1QsyG7cmrjTDHIEsB5tUnSgZbwszuRwG7h+J2hZhAOG1ScbMaiE8cFsagicDBAZ+BAI8vBcQwREjrB0VxeC9uZZ8TiI+zC27u9Vg3SC32Ub3n3hlhDitGqwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CjfzW4jY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rwpjtxtm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447GVQb0007369;
	Tue, 7 May 2024 17:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GjcXGSmlo7F8Twn+z1GjCNkw100J8LdshnB58zieSkk=;
 b=CjfzW4jYL2jsHJEP42gAnz5sFZ4CQdu/vfuyDzmaR+YHEbQebZWaf2LzefotzI4ti0lq
 Zq4N2Xw2qW4SuOUuQmIkrBk2t+gLjvg6YkkczKeIVbiLRpcs9pYx6aiDZGp0pXFqxNK4
 i1wtenPws5t7TxJNrB8qIVHsF8JKNS3sUFtc0aLwwryUGJ5Fu6vVtEL9sM+NLqxVvr0s
 MzdtoxTXbpUq1MhVSH2zi1rmv/GqenlKT56sZMhhrz3sZhdIIHj7vLhe5btIV04C0Ssl
 ob3sh7E6cfGN+dABk58irJiZ+YAJPP1grjckCF1HMEKMFFjpY3SGaRYoLR1tOt9BrB3m /A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwdjuwj9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 17:15:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447GB3nW014142;
	Tue, 7 May 2024 17:15:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf7sxyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 17:15:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOKCpsnEkYj3Avv3k5eBMozCbYlTZZcX/TJzpYxylCCeb7lfFRNTkodjXAG/8Pdx4MOMU4QHvPAThdwn9YQmE50EFsD0fXwANGexsq/QjjAOerqXFZjBA0hK4psAyO2+4UvftKJZpLiu7fHC/brH48E9ZCqgDW3IXW4wfmAB4TBUuNn1EzSgYmdZbuAe2DUB7Eb5wPIB7G0V8u6/o4nqcmXhn+PfABI+ObCwH1+4b2KEO2rB8lr1AKBNypgqdx/ufoA+raY90Gog9nm33Ll8in1+ksldCTqkUeSDH0L/4QTdCAhClQ9jZLRn2XyXpABAHpZKqhllBHHxrJTmS5HAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjcXGSmlo7F8Twn+z1GjCNkw100J8LdshnB58zieSkk=;
 b=QG77Trxd3APf6VaAviabWuwclbovp7DrHlknc+OQVw5SuQsX1F5KHCSXCd7sscZIMXxVNfceflUPLLHyscFtO5WIuxb/+E4Q8TBbjg6epTtH63MGexRyvT0GY7uy2/yDKOQXAEfkZXjGpRIy/5QNO9vhzf66EdXZ+Z6pc7rBSirhLHiydj0NZL13cNGq9JdXugCjQp+SaWqagSjO/AoB/vsZX+hJyOaa7m+75uYlX10EdcTGpgPKQagOZwW5MnHAZDtRBFKRFNIhAcDzZoxnYj0QPL+0dNvV8GGm0d/E+eFfIRBFKxGv0H5wkj2E/z/9go+DGr2SwWwSnkv6UbSPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjcXGSmlo7F8Twn+z1GjCNkw100J8LdshnB58zieSkk=;
 b=rwpjtxtmM5bphvbmiRLL8WTsnqMt7rD4gM7LJAyetj0PQKUtsCJPASMzhidZksRMZRe2XiKa9WwVqwOyIdgkJJLMwEba3FULMHSgPzzFt/DjC3bGjt5ARmZ/m07VC/QqiRSWFOU5k2r2AR/uzdaS9E66GOjpBwl98cFTfPnvBR0=
Received: from CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7)
 by CO1PR10MB4658.namprd10.prod.outlook.com (2603:10b6:303:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 17:15:41 +0000
Received: from CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9]) by CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 17:15:41 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Keith Lucas
	<keith.lucas@oracle.com>
Subject: Re: [PATCH v3 2/4] x86/pkeys: Add helper functions to update PKRU on
 sigframe
Thread-Topic: [PATCH v3 2/4] x86/pkeys: Add helper functions to update PKRU on
 sigframe
Thread-Index: AQHalzs0MPJA5lddkU+HEAcybpIPBLGMBWUAgAAQdoA=
Date: Tue, 7 May 2024 17:15:41 +0000
Message-ID: <BE542366-453B-4510-BCD4-7F3D76559E0A@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
 <20240425180542.1042933-3-aruna.ramakrishna@oracle.com> <87zft1ppgd.ffs@tglx>
In-Reply-To: <87zft1ppgd.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7762:EE_|CO1PR10MB4658:EE_
x-ms-office365-filtering-correlation-id: ac293829-509c-49fe-586a-08dc6eb952a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NE5CaUtSaDFLMlBUaFRCUFp5YTZtUE50RVJ6VlJ4VWx0N3dIQVZnYU5JWENU?=
 =?utf-8?B?L0xNWTBlbmxDWVdBMHJTeHp2TFQvbHo4N0JlQ2J3NG9VeFprdHIxeHdUSDd2?=
 =?utf-8?B?SGZEelFmN1MxYkpsUklBdEEyN1dPR09kM2xnUE5JS0NybDZZQnN0anlpcEd1?=
 =?utf-8?B?aDJiYlRaTmRHU0Z4TlFtSHpCcThHS3JpdFVIdzhkajNFdFlMZmQzSnN2bnQz?=
 =?utf-8?B?bWo2a2JsY2dOMWNkTmNHcHdVWjQ1VHNGb2dnRkJDRzlMNW55dDMyLzlPeWZr?=
 =?utf-8?B?YWZiZTZaN3VVVUdOaEgwQzFwbUVLRDVjQ3hTM2RTU3Y4UzE3WFUzQmU0VGw1?=
 =?utf-8?B?eGpwVlBrMUpaTGZUQVI5ZGMvVjFiSitncEs2RnJ4c3N5bU9lWVRWcVJ2VC9X?=
 =?utf-8?B?QjUxU2xQMEh6Y0VUTFBqdzFXQXI0UGp6Ky9iNXViTEFvclJVOXJrSFQ0UlJC?=
 =?utf-8?B?NE5BUm5QSWFpSWdQb2x4TlFmYlBZMWNxZVRiRmdOY293SnVzTmFBY1IvZXp1?=
 =?utf-8?B?ZENwTGgveUxLNXI0Z2NKUHF1cThURmxvcE5DMjR6TE1kSTB6TUJYUFgzMnQr?=
 =?utf-8?B?akw5WUtyWm9NUks2RTJVWWUrbGpPOEhKcHhaKzB2L1YxSUZTTC9BenNkUS9i?=
 =?utf-8?B?YTNqRHl4TUYzM2M0cXdEcmVpVDJEd3pyY2dod1NGaGV1SWlWSzNSdzk2TWI3?=
 =?utf-8?B?UGZtUS9Tbm1jNkptQmsyMmZQays5M2R1eGV4d0piTHp6a0pCRDd4eHBVUHVm?=
 =?utf-8?B?Z2hWR3ppRlI1V094QlJZSlZKb2dpc3JpNmc1VjFZVElGZFhTejI0UkVwUDg1?=
 =?utf-8?B?dTdhQ2ZMWVZuTGtqMUY3a3dWdXRDV0tpcVo1V3lyQTBjMit0QzhnMFpwTGZI?=
 =?utf-8?B?RHZZNUhYalRDOEVoMEpPMzFpUXBNVnJNVHByUEIwczJ2dTFPblFUUEt6ajBy?=
 =?utf-8?B?Wk9ocm53dkhBV0ZyZXRvVzRXazFQUEhuTzJGTkpJdVNWUTdKMjlqODBZT1J2?=
 =?utf-8?B?dk5tTFZpV1RtUzVLWEYrcU56bTBsVDJQMEMrWE11NjB5Z0ZoZTRRcEREWDRD?=
 =?utf-8?B?eUNtZHY2T29pcTZGUS9HYWtwZHRqRjNOTDhNZm11dXppRmVFTmxxeElUYjdT?=
 =?utf-8?B?SDByNlFYdVJ2YkJkbUxDL2ltdDQ5S2F1T0lPb2RXT0hxMVFrb2hYQmpEQWRT?=
 =?utf-8?B?TnZsQURGZ0JOdVpSTWN1UjBBOCtxOXFZY0JvWks2eG9lczM4L2JZcE1zMmNQ?=
 =?utf-8?B?R1BkUTNtYjJNYjJRbXpZbkhWWnBZYlBWa2lTdUl0MFZrMGxCUmhJZUw4OFpE?=
 =?utf-8?B?V1BlbWNvUVZkeEZOcUNJVEdNdDkwNUkvNkM4MG5BNzl1MXJscnp0cElhMXhs?=
 =?utf-8?B?dHJnOVorNE1adU02aVI1dm5qck14ZnRFMnRpMk80MnRXVDE0RkVvVVRIT2RW?=
 =?utf-8?B?UjJOZkpuMC9oVUVLUWFIQnFYYWZoTXhEbnhTVG5xck5SR2c5bkNKVWs3SmJJ?=
 =?utf-8?B?QWREOFQxWEdFaFlXT21nZWJ1Wk5PQ2R6TXhBYllZMHlseUVUZVEyUC80SEFa?=
 =?utf-8?B?SXVETVFESEYwVVdtU2V3YWdRb2huQ01xd3hsc1JSYWtQcnQzaTU3akZuYmts?=
 =?utf-8?B?dVZtMUliMmhzWWdhdXVkaUc4MUExSGpHUFZZRFpjaVlKV0paTjBaRTRhaWpy?=
 =?utf-8?B?ME9KdWZZd2V5T3pYRG8veitPZDhYRmhCKzRhN0Nlb0VuQ0ZQSERPdUVBWXFz?=
 =?utf-8?B?ZXJDOFZUUzJHOUxIMk0veEdjcUs4ejI3bm1oZnkyS3JnN2VUanJoNW85Ty9w?=
 =?utf-8?B?UmYrQkN2RWhZelQ5UzRpdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7762.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R2tvNlQxbURkNW4rTTE2UkdrNGZZc2ExOE1HOUN0TUM4VnlPdHNIMUNnR3V3?=
 =?utf-8?B?VU9LaFlVNHdxd21kR2h4ZVNXdnMzNmlHYkNCM08rUXJLTE5CL3VBbHdFTnZP?=
 =?utf-8?B?bk5YYkVqSHJBMGtyNDNIZDJTd0NqVUNQYzYvK3UyNUtjNFNENGNBSndVKzAr?=
 =?utf-8?B?Y1l3dTBuNVJsdFJxR2h1ZG9sVkJnWG0ybUNsZzVoU3lGdE5UT2l5eHU3bE11?=
 =?utf-8?B?dklGQndjb29zRE9RbjlEQzI0Uk1kT01ONzVOaG5BeWxHY0UxNUpvb244c1JK?=
 =?utf-8?B?S3FYN3lzTjUyRy85K2ZWMHE2TWZ6NGdnWDhtZWtQRWlxWHZjRkN4LzJVTndX?=
 =?utf-8?B?QVVHQkt3eUxDUG4wYXducllkOFFIMXdoVGFNUm9mK0ZZdXd6anBabXdlbmJK?=
 =?utf-8?B?c3ErM3JjcjVYNTZBNy9LdElCS2dPWkNZK1ZPQXAvakF5VCszZU1ZM1FDVytq?=
 =?utf-8?B?VE9Cd0FTNER4TTRXZGNvSlZSc1NWZ085d1FzM1ovblJyNEZTS045SjBNR044?=
 =?utf-8?B?V3MrdUVuWXJtOHNzSzVTd1RVVFhTVWhDNEl4R3UyM0Jjd0RmandUNFNNZitp?=
 =?utf-8?B?dmRVQlF6TlBtd0ZjWkZMUFBuU2JmaGJrSmtOVTdjUENhb2VrRVN2RHJJa3BC?=
 =?utf-8?B?Z3RqeFNkTlpWSHllSU5jTGJEb3B5N1RkdkRrMTQzWXUxV2ZnbGx2T1ZtcytC?=
 =?utf-8?B?bzhyTUczZEsxa1VjRE5USW5aQ0RNdFpRZXlMZytCeVdxQ3BXZEdNV09aY0Vq?=
 =?utf-8?B?V0R5cXpwb3Q5NExRK1ludm9Fa0M1ZFNkRDNEOVZvVW9ZckpRdVZQTGNuUDkx?=
 =?utf-8?B?REZFWHNMRVRRWjVKek1tb05ZSjVlb2F3TzdHZld5LzkzRkRVRFI4RVBSTm5X?=
 =?utf-8?B?SCttdlFvbjdFWVNlWDJwZ0p5WEZFVlR3RUxuUkt1MXo2NmFaVE90SzJhWXow?=
 =?utf-8?B?ZElLelorVjVia2srVmYxYWVUM0R6bE1TM29YYUt3OFdjMHZDZ3JQb3JxSUZv?=
 =?utf-8?B?ZTI4cXhoOTh1eC9KR0hYUXJUR0xOODg1ZVRxNE9BN2pVQ2NyaFEvM1JiMi8y?=
 =?utf-8?B?aDV0K0Q0emZkOFE3SHhyS2tHOHErYlBoZWE2SjVBbWFSVkxteDQvNjJJZDNz?=
 =?utf-8?B?VzB4NEQwQmJaZW9ZbnlSS3AzNEpGK3VQUEZTZVdMdjc3elVyTE1ndTkrQ0Uy?=
 =?utf-8?B?MVpuSUJxQURycllNMEUxOHpTL1dTNWhPZXovTGNVbzFZYVQwRjVVaDduaE1O?=
 =?utf-8?B?VmhocjN6d25hYVJkaGtnajJyRFI4MmJTam1SWm8zSUs3SE1pMWlocCtUTWRZ?=
 =?utf-8?B?aEJONUNHL210VFBZdHhodTIzNEVjQ3ZyWjkyWmtKN0drN3R1d2E4K1pDRHBF?=
 =?utf-8?B?N3kreTlXK3p2RVZCa2xCbkZQQTNJdTAzUmJJd21FamROMS9vYnBSTndFTTht?=
 =?utf-8?B?R0Fmc1hCLzZmUHFHSW95ZHYyWUE3TE5YNUtwSGhRMHBsNmlSYnhYbXp6cHFS?=
 =?utf-8?B?UFdTSmZrZkZiWkpZUFF4ZWNDRFcrNWI5V0lESkZ6dWpXbUlmWFI4VTJBb3NN?=
 =?utf-8?B?dzNpS1dsYmJ1SnZtaWJsaG02Ni9PbkZYU3QwUUc4b2syaGpBcDRVQXVSUzJv?=
 =?utf-8?B?ajkxMHpLR1FrWVB5QnVvdGZCbGoxTVVBeG5PcS9YUGtXSUs5RTJvR1NTL3Av?=
 =?utf-8?B?N1A2Tk8xT3pocHRhWWJFMlhjV2xaRzZzc3A3ekhnVGlmUkluS3JtWkxuVHMy?=
 =?utf-8?B?RjlZWkhJMnBNcm9zNUZyUkg3SVlpYkdpVytXb0doZGRNL01CSEpBWWxqdU5j?=
 =?utf-8?B?c1Bpc3JUR0RFOU4wZEdERUlEdS9jcVdDUEJVdVJmWUg1MU1yeWhGeVJMeTc5?=
 =?utf-8?B?Y0luUndpK0ZraERqaG5DdU44YTQ3bTBEMkRiVXZQbG00RUZVRytRU2hlbFZl?=
 =?utf-8?B?TEk4bG41TXlUVVp0cDFlUkVKMjhGQXlWeEVPOXJhQXJTUDlPWWdYVCt6RVp1?=
 =?utf-8?B?aFRva25QT1JDN3hVQUMzclM3dkhiSG85TE5jcDlwMmFRQU90Y0tDLzhTV1JX?=
 =?utf-8?B?VlJMRDNOMTAwUmhjWDl4QjRMdVNKSjNTcEM5L1A4a2dPQzFiYk5CeU9HRUd6?=
 =?utf-8?B?TmMxejZHNDVkN2twbnk5WGJsNDNtSEdWNnMyWEtOMjZzRjZhbEtFQ2dZSU5Q?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F3C5139D71E6747907FCD0F620D187F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pKThxQjWO1AXpBDpIH5rtf9ayL7OiGh70AkSK/+f+B3eZbNtNTjHuZmdvJXUhnK/XJdI0bJyXgxeOd92lvHabRm6GbBtm2VwbFX4W9y5pL5FSCNoWb2QntYwqvqG7qtjbt58e4Bbh+6ZZVGk00ObnNsXuIx9Z5f4Xe3s5OBCv/1+OeR/e006iOAiiHId+yhVs5MptFf71IX3oiFTE39JVBpEqd9bPFw4JWqwlYuNOkfrDBrNyosPktFuqDrStNvUArjPSdfmhOT1zgRDMXZjKqNaUMPpL7lKjeqcCrNDzO/246AcMKEasUReGDGAjiU0wUJ7DdhRrq7P0hTzZPz+m+VEBbIY6MrqMddw5duCJrnBSK3I5FxkLCSw54T6y27JaDpEvENQiqPGirnaJrEqTNZ/VNiI5EaIsSEY/cBEjSIg2W0hV4b4u4AJPjwSc1lBW+EQH0cTrHmebnfFc5mO+yPv3bOlhAeQ1gIABRDaIKmOCpMm3kqwcLK9pZRTqDhoNqPBjQCGvc6VjSI5mMgsgX94ZVz3mVca6FxS0PsQgdXs3jZpVC01Brx+08Kr90qA4Ikm58uTrLUbheKI8ipRZu4Hze36Vv1R5eyPRi0jtuE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7762.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac293829-509c-49fe-586a-08dc6eb952a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 17:15:41.3721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkOFeG0FTp/Mhw8W4EPZjpy5fd3TRl2pEWgKHDVMmPbktxh6vNEWmqiA/0HqLqReALSIMreru0y0v10tTRrJZxfml2a5KdRP1M6RM8Jifmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4658
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_10,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070118
X-Proofpoint-ORIG-GUID: JD0t7rAnKBYfsqrIW99iZSNdAznGPrhv
X-Proofpoint-GUID: JD0t7rAnKBYfsqrIW99iZSNdAznGPrhv

DQo+IE9uIE1heSA3LCAyMDI0LCBhdCA5OjE24oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgQXByIDI1IDIwMjQgYXQgMTg6MDUs
IEFydW5hIFJhbWFrcmlzaG5hIHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBhZGRzIGhlbHBlciBmdW5j
dGlvbnMgdGhhdCB3aWxsIHVwZGF0ZSBQS1JVIHZhbHVlIG9uIHRoZQ0KPiANCj4gZ2l0IGdyZXAg
J1RoaXMgcGF0Y2gnIERvY3VtZW50YXRpb24vcHJvY2Vzcy8NCj4gDQo+IEFsc28gcGxlYXNlIGV4
cGxhaW4gV0hZIHRoaXMgaXMgbmVlZGVkIGFuZCBub3QganVzdCB3aGF0Lg0KDQoNClBhdGNoIDEv
NCBoYXMgdGhlIOKAnHdoeeKAnS4gU2hvdWxkIEkgZXhwYW5kIG1vcmUgaW4gdGhhdCBjb21taXQg
bWVzc2FnZT8NCk9yIGFyZSB5b3Ugc3BlY2lmaWNhbGx5IGFza2luZyBhYm91dCB3aHkgdGhlIGhl
bHBlciBmdW5jdGlvbnMgYXJlIG5lZWRlZDsNCkkgY2FuIGNlcnRhaW5seSBlbGFib3JhdGUgb24g
dGhhdCBoZXJlLg0KDQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGRldGFpbGVkIHJldmlldy4g
SSB3aWxsIG1ha2UgdGhlIHJlcXVpcmVkIGNvcnJlY3Rpb25zLg0KDQpUaGFua3MsDQpBcnVuYQ0K
IA0KPiANCj4+IHNpZ2ZyYW1lIGFmdGVyIFhTQVZFLg0KPiANCj4gLi4uDQo+IA0KPj4gKy8qDQo+
PiArICogVXBkYXRlIHRoZSB2YWx1ZSBvZiBQS1JVIHJlZ2lzdGVyIHRoYXQgd2FzIGFscmVhZHkg
cHVzaGVkDQo+PiArICogb250byB0aGUgc2lnbmFsIGZyYW1lLg0KPj4gKyAqLw0KPj4gK3N0YXRp
YyBpbmxpbmUgaW50DQo+PiArX191cGRhdGVfcGtydV9pbl9zaWdmcmFtZShzdHJ1Y3QgeHJlZ3Nf
c3RhdGUgX191c2VyICpidWYsIHUzMiBwa3J1KQ0KPiANCj4gTm8gbGluZSBicmVhayBhbmQgd2h5
IGRvZXMgdGhpcyBuZWVkIHR3byB1bmRlcnNjb3JlcyBpbiB0aGUgZnVuY3Rpb24gbmFtZT8NCj4g
DQo+PiArew0KPj4gKyBpbnQgZXJyID0gLUVGQVVMVDsNCj4+ICsgc3RydWN0IF9mcHhfc3dfYnl0
ZXMgZnhfc3c7DQo+PiArIHN0cnVjdCBwa3J1X3N0YXRlICpwayA9IE5VTEw7DQo+IA0KPiBXaHkg
YXNzaWduIE5VTEwgdG8gcGs/DQo+IA0KPiBBbHNvIHRoaXMgd2FudHMgdG8gaGF2ZSBhDQo+IA0K
PiBpZiAodW5saWtlbHkoIWNwdV9mZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfT1NQS0UpKSkN
Cj4gICAgICByZXR1cm4gMDsNCj4gDQo+IEluc3RlYWQgb2YgZG9pbmcgaXQgYXQgdGhlIGNhbGwg
c2l0ZS4NCj4gDQo+PiArIGlmICh1bmxpa2VseSghY2hlY2tfeHN0YXRlX2luX3NpZ2ZyYW1lKCh2
b2lkIF9fdXNlciAqKSBidWYsICZmeF9zdykpKQ0KPiANCj4gV2hhdCBpcyB0aGlzIGNoZWNrIGZv
cj8NCj4gDQo+IE1vcmUgaW50ZXJlc3Rpbmc6IEhvdyBpcyB0aGlzIGNoZWNrIHN1cHBvc2VkIHRv
IHN1Y2NlZWQgYXQgYWxsPw0KPiANCj4gY29weV9mcHN0YXRlX3RvX3NpZ2ZyYW1lKCkNCj4gIC4u
Li4NCj4gIGNvcHlfZnByZWdzX3RvX3NpZ2ZyYW1lKCkNCj4gICAgeHNhdmVfdG9fdXNlcl9zaWdm
cmFtZSgpOw0KPiAgICBfX3VwZGF0ZV9wa3J1X2luX3NpZ2ZyYW1lKCk7DQo+ICBzYXZlX3hzdGF0
ZV9lcGlsb2coKTsNCj4gDQo+IGNoZWNrX3hzdGF0ZV9pbl9zaWdmcmFtZSgpIHZhbGlkYXRlcyB0
aGUgZnVsbCBmcmFtZSBpbmNsdWRpbmcgd2hhdA0KPiBzYXZlX3hzdGF0ZV9lcGlsb2coKSB3cml0
ZXMgYWZ0ZXJ3YXJkcy4gU28gdGhpcyBjbGVhcmx5IGNhbm5vdCB3b3JrLg0KPiANCj4+ICsgZ290
byBvdXQ7DQo+IA0KPiBXaGF0J3Mgd3Jvbmcgd2l0aCAncmV0dXJuIC1FRkFVTFQ7Jz8NCj4gDQo+
PiArIHBrID0gZ2V0X3hzYXZlX2FkZHJfdXNlcihidWYsIFhGRUFUVVJFX1BLUlUpOw0KPj4gKyBp
ZiAoIXBrIHx8ICF1c2VyX3dyaXRlX2FjY2Vzc19iZWdpbihidWYsIHNpemVvZihzdHJ1Y3QgeHJl
Z3Nfc3RhdGUpKSkNCj4+ICsgZ290byBvdXQ7DQo+IA0KPiBXaHkgdXNlcl93cml0ZV9hY2Nlc3Nf
YmVnaW4oKT8NCj4gDQo+ICAgIDEpIFRoZSBhY2Nlc3MgdG8gdGhlIEZQVSBmcmFtZSBvbiB0aGUg
c3RhY2sgaGFzIGJlZW4gdmFsaWRhdGVkDQo+ICAgICAgIGFscmVhZHkgaW4gY29weV9mcHN0YXRl
X3RvX3NpZ2ZyYW1lKCkgX2JlZm9yZV8NCj4gICAgICAgY29weV9mcHJlZ3NfdG9fc2lnZnJhbWUo
KSBpcyBpbnZva2VkLg0KPiANCj4gICAgMikgVGhpcyBkb2VzIG5vdCByZXF1aXJlIHRoZSBub3Nw
ZWNfYmFycmllcigpIGFzIHRoaXMgaXMgbm90IGEgdXNlcg0KPiAgICAgICBjb250cm9sbGVkIHBv
dGVudGlhbGx5IG1hbGljaW91cyBhY2Nlc3MuDQo+IA0KPj4gKyB1bnNhZmVfcHV0X3VzZXIocGty
dSwgKHVuc2lnbmVkIGludCBfX3VzZXIgKikgcGssIHVhY2Nlc3NfZW5kKTsNCj4gDQo+IFRoaXMg
dHlwZSBjYXNlIHdvdWxkIG5lZWQgX19mb3JjZSB0byBiZSB2YWxpZCBmb3IgbWFrZSBDPTEuDQo+
IA0KPiBCdXQgdGhhdCdzIG5vdCByZXF1aXJlZCBhdCBhbGwgYmVjYXVzZSBnZXRfeHNhdmVfYWRk
cl91c2VyKCkgc2hvdWxkDQo+IHJldHVybiBhIHVzZXIgcG9pbnRlciBpbiB0aGUgZmlyc3QgcGxh
Y2UuDQo+IA0KPj4gKw0KPj4gKyBlcnIgPSAwOw0KPj4gK3VhY2Nlc3NfZW5kOg0KPj4gKyB1c2Vy
X2FjY2Vzc19lbmQoKTsNCj4+ICtvdXQ6DQo+PiArIHJldHVybiBlcnI7DQo+IA0KPiBTbyBub25l
IG9mIHRoZSBhYm92ZSB2b29kb28gaXMgcmVxdWlyZWQgYXQgYWxsLg0KPiANCj4gICAgICAgcmV0
dXJuIF9fcHV0X3VzZXIocGtydSwgZ2V0X3hzYXZlX2FkZHJfdXNlcihidWYsIFhGRUFUVVJFX1BL
UlUpKTsNCj4gDQo+IElzIGFsbCB3aGF0J3MgbmVlZGVkLCBubz8NCj4gDQo+PiArLyoNCj4+ICsg
KiBHaXZlbiBhbiB4c3RhdGUgZmVhdHVyZSBuciwgY2FsY3VsYXRlIHdoZXJlIGluIHRoZSB4c2F2
ZQ0KPj4gKyAqIGJ1ZmZlciB0aGUgc3RhdGUgaXMuIFRoZSB4c2F2ZSBidWZmZXIgc2hvdWxkIGJl
IGluIHN0YW5kYXJkDQo+PiArICogZm9ybWF0LCBub3QgY29tcGFjdGVkIChlLmcuIHVzZXIgbW9k
ZSBzaWduYWwgZnJhbWVzKS4NCj4+ICsgKi8NCj4+ICt2b2lkICpnZXRfeHNhdmVfYWRkcl91c2Vy
KHN0cnVjdCB4cmVnc19zdGF0ZSBfX3VzZXIgKnhzYXZlLCBpbnQgeGZlYXR1cmVfbnIpDQo+IA0K
PiB2b2lkIF9fdXNlciAqDQo+IA0KPj4gK3sNCj4+ICsgaWYgKFdBUk5fT05fT05DRSgheGZlYXR1
cmVfZW5hYmxlZCh4ZmVhdHVyZV9ucikpKQ0KPj4gKyByZXR1cm4gTlVMTDsNCj4+ICsNCj4+ICsg
cmV0dXJuICh2b2lkICopeHNhdmUgKyB4c3RhdGVfb2Zmc2V0c1t4ZmVhdHVyZV9ucl07DQo+IA0K
PiAgcmV0dXJuICh2b2lkIF9fdXNlciAqKS4uLi4NCj4gDQo+IFRoYW5rcywNCj4gDQo+ICAgICAg
ICB0Z2x4DQoNCg==

