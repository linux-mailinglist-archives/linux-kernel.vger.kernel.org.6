Return-Path: <linux-kernel+bounces-437739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A815F9E97E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FEA1884BB7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E94B1A239D;
	Mon,  9 Dec 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c+PH6Sry";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VbI9482L"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0EF23313C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752507; cv=fail; b=GhHXGTbi7bWFffYjuMYO25lijLEnMRdi3c5ZkRv7PiiZ39Uz+tkVdV+fRTfuO0/20NAZn7c2eOeHzI8wxuPE2v6NP7abtNwzP/56wWt5P0Tx4oPrK2yABSTKRbt8MxQIBXllVzT5Alj2KsBTfvvoTCP1omLMKlqY8tMP4/fdE/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752507; c=relaxed/simple;
	bh=xDZMKY1unfMqQyvGM4xiYf7K3B84So4xIRDcD/bwL8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ve6GweCv5KKQXOOZDpWwP1cjufHfVG5MCFq0cqGR4Zze69Y7UEVhDHO20cp1rp55CMeMevdSJu2IXu+tPoS2osVKBH2lcj9OL/gc5gEygbJtlf35j/YEgop9d6hj/0bG0NrVp/ZYMSDu+gTbtN2C84amEpAbnBztkHLuuM8kQvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c+PH6Sry; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VbI9482L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98g0tC027274;
	Mon, 9 Dec 2024 13:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jvOY2zur95rhURGPOHSUw7UFoWUJTbimu+1wPkGvnBk=; b=
	c+PH6SryZPCjyWyPCoPsYNRBGuS0d/tFog0w+XiSNRoPqIrfZ7IGG0w+fPdjLnOH
	IsLryk8uQW0GKcRve/2EdS6dCWdu8nfR7si/k+8ImXyfFEqnGnAXrG8v8dIvJkXk
	xNhwT2V4eHdfQXBnmu131nBwrSMfcGfIiwlbePANJoeEtDOiBO2ou7KP9muEGkIi
	18xj/mbqNKRJSknwgbz1tP9dzyHs+iCOe3Bhdl+0FuVrQ+McGemK2+PSmtgfCkA/
	SqRMrGKnUKQgCD9s17fh9fYDvf2ZdJCjpIuwMqEuYy5Yj2ykTDZTdMbLEe0xp6+8
	W+eQC7i+U5t0J+Rp6Kz4Ww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce8936s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 13:54:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9C2vDV035082;
	Mon, 9 Dec 2024 13:54:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctecqhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 13:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dV0hWYdU+YpkG8AVdrW8LM5ow6PIpmCPHfrSTNZ0K89exoeTKncm+zGlWz84LHKL6zEdQE6db/EInw9Wgno3FzzcM9GD08MhQNIL28HuVnY4MnOHktXCX8pm03dJ4GhHQ+3JBF41W4b6bgYPK7T34tdSbBxCUAnrmqHcZjz4KZ18pciEgpgUh9chpCTg6MNHhB2G1VEeB8PoBPkK+b0pGfHQrtJ7eNE5kFJVfVynxOB0p47TNauhaTCaFJOPs0md6r7pAAy7u4Uwqv6u+QqKviH64a23wpdrIQTSLZOvEnlEkMrxfDJm78i6090Zs+dkrdZMsuWQVpsb0DCDAN11HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvOY2zur95rhURGPOHSUw7UFoWUJTbimu+1wPkGvnBk=;
 b=L8QXdVJfFN5yEQ41Epr96Y64HSxjlkNmNO0k3bitBjqm9+BwQMQ5WYSHmsHq59bBuW4FX42+3UuS/86LBomonuegwViyp/+zxaxt11lyM3K5BOIxVgvWgHR8Q64zAtl6xih1ggjnxqZhVwUwEMqmPSa8bgc2ehRodo9xS42n7VWrkYe+mokFPnvnru1Vm9CPiDXnWTiSmhbVTD9UXY0H9HqaZw7pfrujCYoAHzxf1LRrusZUYNRja2ypYtQJtAyKo9spFoe1pVt1Hyw+Ppm09pdzG2SwsLuNYl5johdJZUGprPUX9+n4jx3Y0886y07gdgv7Z20X4JV3EiMqws4sng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvOY2zur95rhURGPOHSUw7UFoWUJTbimu+1wPkGvnBk=;
 b=VbI9482LvPKm0WsAgOoFKIAxd9O/A6W3J/RcEDfndBpU94UYa5Osu4caKuHhJPF0mSzaXYrZ+0j8kGBWOpKzhk3blKEBDA4cRDQuO0gwiRwA6B4LYYiYBPavft5LO3KcoCOO7uBXaYX4/8tgQAUDRybkBv81UAyg9wA41YXujeU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM4PR10MB6253.namprd10.prod.outlook.com (2603:10b6:8:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 13:54:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 13:54:49 +0000
Date: Mon, 9 Dec 2024 13:54:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <ce930135-a7f9-4009-a434-66ee0ef53c2f@lucifer.local>
References: <6756d273.050a0220.2477f.003d.GAE@google.com>
 <1b8b5d54-d667-4ca9-b831-bee4b4e74c40@lucifer.local>
 <CAG48ez1mvwo1gjVstJDgFg=Q9uP7CXBk70MTQfHBwwWa5Nq9VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1mvwo1gjVstJDgFg=Q9uP7CXBk70MTQfHBwwWa5Nq9VA@mail.gmail.com>
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM4PR10MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: ae200e69-f373-4b72-bb52-08dd18590c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rkc4a2ZQMGF2UC9KK04xSytMaXhNdFlsSTRBT2JzOFlSRXppVUpmVk9iVTdG?=
 =?utf-8?B?bzF3M25ueDNiSDB1anVld1FwR1BUa2xUaS80RFJZZEF0TE51NUFnVVBuR3Ix?=
 =?utf-8?B?UExXV2h6Z1ZjVlkzZGRqUm1wMXJJSFA1OWgybFhPVjNrSHAybHp3cnhvMnVJ?=
 =?utf-8?B?SjBNSDduelhhSVZxanZnUzNVNGVRekxMTkVFejRObVFzZjZ5VlRtNmdZa0U0?=
 =?utf-8?B?NUN3NHdXMDFxa096RjFodUF6bEoxdzRLd1d0eWJDaVYwZ2FZU2lwTHkvY1pH?=
 =?utf-8?B?L3RKcXMvUlVSL2tLUmdiYVFYV1pNNTVXckY3VEM1QjZhNmVQTGd6VjJtT3JD?=
 =?utf-8?B?VWFZdWJReWxxZlgrVVpyN0dNb3Vzc3JURTVpVTJ4YWVEbGdlN1FJY1hpV0Fj?=
 =?utf-8?B?cE1aN2xiRUpURDh1QmtiN3ZUK1VZbHk2R29OTVIrdGJmNEQxRSthbFN3TEdo?=
 =?utf-8?B?YmFpaFkvZlB2VDJiZjdEeTdxN0hLYU9tOVUyOFI0TjR2cUNzR3B1KzQ0b0Yx?=
 =?utf-8?B?VDZvbGtiYS9vV1Q4aFBwU3JSZVpwdXk1VzZhY0pJMWo5NHFmYW40ZTFKazBK?=
 =?utf-8?B?alovdklyL0pBOGRodzR5N09BcGNOZVZvcmFiMmMvYjhzSC9wS3FNemFDU2p6?=
 =?utf-8?B?bGhyVWQzMUI0SlpTLzdvY09EU0xwVmEvNVZjeDZIaWVCcmVRSHFFWnBMa1ND?=
 =?utf-8?B?R095YkEyRGZXL2EyRDZIU1JreUxHNWFGN2NWRFBCaUd0cTVmaEN2VUVtTGJz?=
 =?utf-8?B?ZTY3NnZMTnQwaUp1Y2NNSGRQR0x3dzRScmluYVF5NmZyZUhLNmpqTThwVGFi?=
 =?utf-8?B?Kzdva2UyM05wYVRsaDNMRy9YMmt0eDBJN2h2NkJJUHlkUnE3ckdIcmFZekRP?=
 =?utf-8?B?dVVUaEZCYzQvM1h2cWh5elhPSGMwUURXb2tCL3J0aG1ncm9GRHpZUUticlhX?=
 =?utf-8?B?TE9WNWlZOEE2REtnd3hnRlowYXB6VlBsdzF6dm9qSTJ4SDJTc0o1YjNZbDlp?=
 =?utf-8?B?RkZOUWx3cG1Kb3diNWJHandITTMrc3BEOWJucVo2YWszSlBTU2JMMG5wU1Ex?=
 =?utf-8?B?cG9EVFUyMm1WclhYbmVncHVHYVF0OUhJeUpRdEpRM1ZOajRwV2ZWdy9oNkhm?=
 =?utf-8?B?SUdPNWU1eVc5WEZmS0FETVhNeHVlYkk5UXBsMlhTeG5CTklzU0ZuOVdJY1Mx?=
 =?utf-8?B?RzhsN2dpTmdEbU9GSlBQL2NtcndydHlFbW5kL2RBVS81d1JmL2lLeCt0bkVq?=
 =?utf-8?B?SFpsLzBSekJBdCtCRU05a3cvVHg2UGNLZTBsZHZiMEFvK3ZVZmRMa0V4ZTli?=
 =?utf-8?B?WkxWSWtSZ2NvRXdmOXdBQkU4STNRVjZkN2tsTzdFR21OZEdHU0FFb29JZkF6?=
 =?utf-8?B?dlhlYm1BeEhBd2lrM2RzcGlEdWh2WS9hUHl0RlUzNjFkU1RqWEtKL3paeUJi?=
 =?utf-8?B?aElGNGRkSE1YRzM5OEEvSEt4RmFzdmtHWWZDa0NqSnh2NzhYMXVyN1FkQUZF?=
 =?utf-8?B?VDM0VWJUbXJiSlpaM2diMTV3NTIxamRTdEl6bDg4dEFuL2R2RmNaMFV3YlAw?=
 =?utf-8?B?UGI3Qk9Vbms2ajdnaE9hT282NklkK2hBdko3dUNRV2pCVGdPUzlqOXlueU5J?=
 =?utf-8?B?UkJRNFNsM1BzQ1o1MkxLaFNPbU5nU3JTZE1GUEIxcll5YmRRaW5lS1R6K2RK?=
 =?utf-8?B?WHF2UGVrY210SkJTa2NndzBlZ0liTS9LVS93YUFMVGcxdHZRVFJQek5QRm9I?=
 =?utf-8?Q?cVs3R44QYMdUSVo4y0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0lqQ2NqalZQcEpqQW5pSkRyTmFoZWxoV0RDcXh4clU1bjNQbkFld0RsL2RH?=
 =?utf-8?B?aWhNckJTRXBLR1BWZjlQZ2xJWnRsYy8xOWczRWR5bWI2dTIzRGpodTFxNUJJ?=
 =?utf-8?B?c25LZm5WY0RlSkhyVDNsZjZ2ZmdwTmhtby9LNFlRbGp5WEtUaWtDeWV2Wjcy?=
 =?utf-8?B?UEJEWSsrVWczTjg3VHFqSXpsMWpRQ2ZkRmQxSldFODVIZ0dlM1FTVkRNbnNm?=
 =?utf-8?B?QVhweWd3R09FRkhRUWZMazBsVGxldkQ4bHBscUI5MmFkMUJTS2NORm0yL2dF?=
 =?utf-8?B?RXhVblVHMUxmWkhmd2U1UDhNRHgwTS9YT1ZXNGRpem8wZ2VLNmxVeVVXL1Ux?=
 =?utf-8?B?cUYralRHaHpZeG94aEJpRlU1ZnFmZTZHVlVmTDRGRmFIcm9NdC9NQnA2ZEYw?=
 =?utf-8?B?bkYyNy9pNDNWWUN5L1VreDJVV0J6SzllVEp2Q25JTFhRMTdXNlVUSVc1K1lS?=
 =?utf-8?B?TUE1K0w3aDZ6QlhMbm02YjJhRWRaVCtHZ2hJblMwNUREODhMOU91NzlUcHZ1?=
 =?utf-8?B?K2NEN2Y3WW9IQ0FuanU3VWtZd3dqMXVuaks0WjNwMlJXRi84TVJRKzhZNHV4?=
 =?utf-8?B?Kzd5ZnZNa3ZGMGtSWlBFc1p6b3R6VHV3MGlUbjFrZ1I0WkFxM0ZtSVJxdEUr?=
 =?utf-8?B?bW43azhha2FlLzFoRUFZcWprTDlyRHFmV3N0NE16ZlpWSUFDUXQ1NTBoOGRN?=
 =?utf-8?B?NytlNHdtTnhGb0N1dzE4ZTZNaTd5SVJTR2cyOXZRZWNLTWJHdW40UXdNcGx4?=
 =?utf-8?B?bXNFdlE1YW5MU2oydm9qSVZJRlB0Mk8xYWowWk90aHl1Ym1mWVdlcUM3VCtK?=
 =?utf-8?B?OVZEbHVrK1BrWHFwQ1gwWGc4NlQ0Rm5EVTh5N2RyK2c3Smk2WFJRNTdkeDU0?=
 =?utf-8?B?Ynp2Y0RTcUE2TGljam5aVDV5YjRjd0ZTZEJURVZGS0NOajliZldRY0ZQT0Jl?=
 =?utf-8?B?b3BsZXI1RXpDK3JUZHNIWFhNbk0zTmtqQXEra0crVGltaDlvbVBVc0tsSnFy?=
 =?utf-8?B?SE12VWN6K1plWXVVa000SlZhbEpsRHBScHJabTdCV2N5bFNrWUt6SS9DWGlp?=
 =?utf-8?B?clVpcEZnZlpPRjJnRFZGaXV6N1N6RXlWNlVDaEYxVVE5NjNwOHhucEJtK2tn?=
 =?utf-8?B?eEd2UHR5dlBsZ0VqZXRKZUtSZWhuQjVCT0ZGWWhrWnZrdXJRNkRRYWh2c1pM?=
 =?utf-8?B?aWcwcFBXdjA4cW05Q0xxVnpaNUxQTjFnRGxLRmFQd3BjdmpIcGlTaDR2Vlli?=
 =?utf-8?B?b0M3NlRnUEE5SXh4bG0wdlF4YlhkTW44dHFUclB1Z0xqaGRhS0dsUDljeEtz?=
 =?utf-8?B?bEc1NjZRTWVUVVEzbGNIeEtPTGs0bmppNGNJK2Y3NU1nb3l6V3FPZEpGZU5B?=
 =?utf-8?B?SVRSdnNRY0Z2TklJTll6U0xPWEFvYzNYT3ZkTWY0OUlzRDJjcjVubjlSYUJy?=
 =?utf-8?B?b01pVXE2ampwSVNtbmFQaXdFSmZ3ekwyZUJMWi9pZW9BV2hHYURGUk14WFU3?=
 =?utf-8?B?SnZZa1VUVDZRQkUzcmN0VXE5R3N6SENwNm5nOWtUZ3E1c3J0c1JrcXZqRWVB?=
 =?utf-8?B?aEtnMkM3dzQwSE9nejF6aVh2M1RhcnB4RDMxbVVGQmN6VW5qS0UrR2NST2w0?=
 =?utf-8?B?NlQ0R3JoVzVlMTcyVllJZGNvQk4zSUNvNzhkWmRFeXJnaUhPMjB4a1NNZzJX?=
 =?utf-8?B?VkV3bXJmeEJvYm8rZDYxSXY3Zm50KytkMHVoMVc1WjhxTU5BbzB0eXIyRmty?=
 =?utf-8?B?ZDdaVW9WUFlZb3Z3T2ltdkxBOEVzV3FLdlBaRXlpQUdsK2hidjRzQS9QeXAx?=
 =?utf-8?B?cm5tR1ZqWmNKWW12UnlGZytFSDA5a1lUakc0a3hzM2UyRlBBL1ViU1JDeFpp?=
 =?utf-8?B?KzAwZFh6VUVZSUxzQWozcytsTWc1VFRyS1NWalQwMlB4NjhRUUNia2p4Ym9U?=
 =?utf-8?B?dUpSa0FRTWlza3BjREx3WUdzdXVVdXEwQzd0REt5aEJlUDdsKyt0WEFpK2k1?=
 =?utf-8?B?cHNWZ3RnVDVMbkZJM2NUNGc5ak5OOGpSTGg1YXV6MXJ5UURXbmJNaHhRaWhK?=
 =?utf-8?B?TlMrckdXRDhrYXdXN2FuWTEzNUtUeS9Dc1BQMXhoWkVZSFdLTkFQTEk2WXJt?=
 =?utf-8?B?REhqSGJCUWpwS29xcVdLK3B3bjZHZk5UbHh6eTYxZC9WM3oyaUZFNzVXWkkv?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	co1+R2FR4G8AqTatDBLFp216ZapiHxvi7K450KTXVKS7sTx5uQZSBp4ztqigEe2ljigtWTztDa4dWV0rusj3H4nLmOxlJm+r9pXvP48M3dj5eOtWwOc4MLa3fiKscebl2cUgRQ3IPp7pJs36rjg4vQqeACStfKLpWFxq0ehmPRHTRRW8gDyGnPXTamF4JnihX+r0kzZcSJcOGzgP9q9UxdPDPY1aFsS6rfj5k6Ea5MNyDiG1IvRWr/EPLcWdZxSUORdKwDh70RlTUXgyZQPirBOqhKYocsyDpiRGjBrzhQgllQztVUgIuxZTYmBYVLzXX3iO0qyHB6d0XYb2XTtWdgcYZ6haR4R6NppB+kFj8OthbuhOrt8IKlZKGZ3siH449RshMOh4aYyeyAVW4jdfcN1gxL61d2+j/EAYmsjJU+N18tqyiyw+NmfiEz0UuL/adjEbDaG7oAMVz5sTrhKlqYMXzVYcj5uA3Jza6qjP90Oe9oKWqtN1FH1zsmCjw/3cde2q4+vZEAvUV7VhPEbFpGFhmB9cyLuLOubf4wZQqIdsk+pewMXjqHkGOJ49G5yz7tA5hM2/JC0kpva5o+ZrDl3R3GMT4yOEjUgzdpWE/Tg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae200e69-f373-4b72-bb52-08dd18590c6d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 13:54:49.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VK/VtXxUPFyh5MsuML7lkOkdlE3ccjbBmi4B3V3KT1Vb0L9eyiC5OZNhTR42cDbsPsI8SUYvLkQIVEk1QYPviTTkvnKXZK+dWxmjw4DfGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_10,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090109
X-Proofpoint-GUID: bfS68iZq9KgtrujOcWVaHcIi-DFasCxc
X-Proofpoint-ORIG-GUID: bfS68iZq9KgtrujOcWVaHcIi-DFasCxc

On Mon, Dec 09, 2024 at 02:35:27PM +0100, Jann Horn wrote:
> On Mon, Dec 9, 2024 at 1:53 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Mon, Dec 09, 2024 at 03:20:19AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17f85fc0580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=2d788f4f7cb660dac4b7
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Points to this being racey.
> >
> > >
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/vmlinux-feffde68.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdcc9cb/bzImage-feffde68.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com
> > >
> > > Oops: general protection fault, probably for non-canonical address 0xdffffc0000000080: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > KASAN: null-ptr-deref in range [0x0000000000000400-0x0000000000000407]
> >
> > This doesn't make a huge amount of sense to me, the VMA is not 0x400 (1,024)
> > bytes in size... and the actual faulting offset seems to be 0xdffffc0000000080
> > which is 0x80 off from some KASAN-specified value?
>
> If you look at the disassembly, you can see this:
>
>   13: 4d 89 ec              mov    %r13,%r12
>   16: 49 c1 ec 03          shr    $0x3,%r12
>   1a: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
>   21: fc ff df
> * 24: 41 80 3c 04 00        cmpb   $0x0,(%r12,%rax,1) <-- trapping instruction
>
> R13 is 0000000000000406, that's the address we're about to access.
> This code is trying to read KASAN shadow memory for that address by
> reading from 0xdffffc0000000000+address>>3, which for real kernel
> addresses gives you an address in the "KASAN shadow memory" range (see
> https://kernel.org/doc/html/latest/arch/x86/x86_64/mm.html), but for
> addresses in the low half of the address space gives you non-canonical
> addresses starting with 0xdfff that cause #GP on access.
> The second line "KASAN: null-ptr-deref in range
> [0x0000000000000400-0x0000000000000407]" is basically computed by
> doing that calculation in reverse.

Ah thanks.

>
> > This would be vma->vm_file. But that also doesn't really make any sense.
> >
> > But I wonder...
> >
> > I see in the report at [0] that there's a failure injection in vm_area_dup() on
> > fork:
> >
> > [   73.842623][ T5318]  ? kmem_cache_alloc_noprof+0x48/0x380
> > [   73.844725][ T5318]  ? __pfx___might_resched+0x10/0x10
> > [   73.846687][ T5318]  should_fail_ex+0x3b0/0x4e0
> > [   73.848496][ T5318]  should_failslab+0xac/0x100
> > [   73.850232][ T5318]  ? vm_area_dup+0x27/0x290
> > [   73.852017][ T5318]  kmem_cache_alloc_noprof+0x70/0x380
> > [   73.854011][ T5318]  vm_area_dup+0x27/0x290
> > [   73.855771][ T5318]  copy_mm+0xc1d/0x1f90
> >
> > I also see in the fork logic we have the following code on error path:
> >
> >         mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> >         mas_store(&vmi.mas, XA_ZERO_ENTRY);
> >
> > And XA_ZERO_ENTRY is 0x406.
>
> That matches...

And I wasn't aware that R13 was equal to the _actual_ address derefenced,
really useful to know, I mentioned it in my mega reply where I figured out
how we end up trying to deref this... :) yes I think this confirms the
theory.

