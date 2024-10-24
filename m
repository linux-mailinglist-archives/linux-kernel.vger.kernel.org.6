Return-Path: <linux-kernel+bounces-380257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D339AEB15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7502B237E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5E31F5820;
	Thu, 24 Oct 2024 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XEse4gr9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gmiAh8w2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9A1F6692
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785014; cv=fail; b=iX9KjoPpZscHOWnTwZfHEh6SGhOZkPPFMZ4HYTMLr0GFYpm+cEqr5YmSe7AxqmbNURU/QRyNocv7pylMLAMcB+3YKDSwtPGJVuCiHrRN3Pi2Q6MYYBl78r5VV217Z9kM5L9WvqAInubSnw2uarD+INROBW/r8Hiwiud6LEaPCKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785014; c=relaxed/simple;
	bh=Lxev65DswyWtcaDXgsqTy7U/sHO151GKUojE7a9NgCc=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=rX7jbEnsUTvK+EWJLE12zDzoXQvO8/BqQy/Z4I2Eq+CnClAG2Fc8vlk2iiAD2yLuIT94mFSZcpChfw7zMJdYLkLV7n/JZdo7SwGtwCITyp2VPTu4bE12ZduaeTOK0LGxC4gauHHzR91G9C3HTL8+RjWQmk99huoH/7bIByMGLVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XEse4gr9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gmiAh8w2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OC1YCR030561;
	Thu, 24 Oct 2024 15:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=QVsV0Tn5vncxuwoD
	Q3s/3eCoAc6IVFSxbA69HkzFrqI=; b=XEse4gr9GI8FnY3jFT/WjKoW576+pmJU
	PytR2cqzR65SzNeRDwVXjM66Y2jiVb72s0kOwVIaV1OGvXpOHBLejgfV9akyuUQG
	oPVwuTP19nvzLUWUEnaJIZs0/vvXyFNsv3f/rufFKFLrpBs1GlcPC7Kr9F55/PIa
	QAMa5j+KiKRInPlm47nAqcAzbw4TOCVhLmwFS2+QZRrjWEyUa6T3vQfcl2l0qzqb
	ZSJMMp6uGlieoDDa8upx+XvGKxfesG+mKjDLIEekThhWzRti+gS7zGausf9fyyXw
	NQC6FCxHOn13sJKzWcN9IIiBVavaRJWihZQ7huf1me6WlPv4llEuFQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53utyby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:49:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49OFD10T027557;
	Thu, 24 Oct 2024 15:49:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh4h487-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Oct 2024 15:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8uHSl0+EYDnVXJiyOcI0ZSNAGiIXl8NtvsaPemGpPMCdYmzw0cIPHeuDpuImtOYMFKPcmpOgdru1by27RGwCg0R82z4ex1F0Gi88G2TKpZyYAXiKzM9gywGReFn2Xl3vuTOZZxfW0A24xl9eLzBVNfBVdJVArY301c6rYBWp7UbZJmB519rEy+SKbMUwTN7HoBpFbgRNQXfiFL5bEgzBV4i6pU63hlWLBJmTEl77pqbzqIzr9sGm5moRl+DzHIcBfeGv3E3JUhhYWkigMNxSktVvFt0sdghJiunHTKfDD2uo0a2vjSyK672J7JoMvh+JziWmu1UXAG9JyAybcVL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVsV0Tn5vncxuwoDQ3s/3eCoAc6IVFSxbA69HkzFrqI=;
 b=PGUz9JT0bnRVKFYIUZ/yO9VWj4dkyQfO75gsgf7+vcn+jaWMsSAiOk4ObhFKN2xnBlJ56jlY7gLEQQNk9+ygh7nR65zvkzobLHVdyUDDuAw0v5o9CfjyIqoeBuDnxge55zEhltdeMS/9SHgAmzTuRyScedHYx/UvTVmhAq0iJQqE35mwrQlcMAHrMbvU2/AYRVeQr6kVZu2mC/ngjaPwI6ajww0oOCXc5uKaBmcTRjqjnvsO1g5jILv/Y4Te4FKEQQibyoLkZthSRIXHIdyq9g58x706PPFxq9PrMPNm8vHnV9unbi+auCW/MPIRvKOBFXpyeD9h2J0JwNksesBFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVsV0Tn5vncxuwoDQ3s/3eCoAc6IVFSxbA69HkzFrqI=;
 b=gmiAh8w2IYVkZe21u1swE1ezPlRaSFQaOITcVF5Q8S9ncBkocvFZ09179sKFd8126WCG4ERSBGHOpfSqc1nsS2QRtvJLoPhqR54jM1IwPnYKfX14IhH/L8UDa06xjfVmOyZptvXIHEgynQ4+dljGqYQhjSJBSFJG9gD5tghfK5E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4729.namprd10.prod.outlook.com (2603:10b6:806:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 24 Oct
 2024 15:49:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 15:49:44 +0000
Message-ID: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
Date: Thu, 24 Oct 2024 16:49:40 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: tj@kernel.org, jiangshanlai@gmail.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com
Cc: jack@suse.cz, david@fromorbit.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
From: John Garry <john.g.garry@oracle.com>
Subject: workqueue lockup debug
Organization: Oracle Corporation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4729:EE_
X-MS-Office365-Filtering-Correlation-Id: 0578a776-52ab-4883-b493-08dcf4437ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjN1dDZSalMwUmtOTm1ZTTVuOEdzbFNEWThscVBLcFloYnM5YUJudTF1eXl4?=
 =?utf-8?B?U2pGQktCMTI5UHFqcHdhZVVzY1JPYU92SGdSRElYeVN2R3JMRlY2Nkg1Mm54?=
 =?utf-8?B?Q21BR3RWL2tSd3VRZVVVV3BmUENhbWdSQ3I0M3EzaVo0bmlibi9FTWt2dWY0?=
 =?utf-8?B?bG1aUWFHQVRGRWZlMEJFRnNkM0ZqNUwvTEhYMlZzbDZGUDAyZXdib2oxZVlC?=
 =?utf-8?B?NEdrbGpqbVVKRGZJUDlOSUFHbC94UVNzNklHdDVnTFY3ZEl3R0dYMExkVWFO?=
 =?utf-8?B?SjkzUFlkcFZ1dmljOExJQUIwUUM5SGxSK0RSckkrSXVqY1pmM2h0ckpiK25l?=
 =?utf-8?B?S25tdERpUk9MMmNnUEtBdi92bEJHUkwvbUFIM29MTnZPMnVwOGNFdUZGaHQw?=
 =?utf-8?B?YWt5NkxBM1BlcUhHYXpKQStuSG1iZUJXVXRJTE14ZnRsbmFoWEpaSnhCS0JC?=
 =?utf-8?B?cHFxd1J0LzBPRnloNjJEZENXb2YwZmJ0aEV1SUdxcDZmczNaenVQaXZjR3Uw?=
 =?utf-8?B?alp2c2s0ZTdBczEya091R2hONmppUzYyaGFnM2J5SmwwVmJ0U0RDQUo2dFJq?=
 =?utf-8?B?QVloWmwvVXJUNk8vWTZSUFdHRng5VjEzajNIellndGdoS3YvY25za0NMUEVm?=
 =?utf-8?B?Qy90T3AwbENvczIxNU9RZmZScklOR0VIT3JXZ1lGSVpZZTlIOTBuRmxmbkgv?=
 =?utf-8?B?UXhhOCtXM1hnWit5OFRVVUkwaGRkZys3ajA1c0EvUlRwcEQxMWNic3g2SWdj?=
 =?utf-8?B?M3FjaDFmeWh6OUVmV3laMjRla1ZBejY0N0FxS3lhOWtwNWFBRlVvRTBpcHVI?=
 =?utf-8?B?SitiTkkvemZmK1MyaFE5ZmI4VE5QM0ZLK2JKeXBIZ1AwS2VEYThmK0FCN0JM?=
 =?utf-8?B?TDRRWFcxOGdrZy9oNjZXMnJYSFJtQU9IL2hMUEVuODVJZE9adit1WnF1WFVJ?=
 =?utf-8?B?RndPWVArZGtBWkF5eTk1dXBWcHdsZ1dvUEVVaU00L3RLRGdvVHRiazNqQm1Y?=
 =?utf-8?B?Z3JMUzRPam1oYUxMUlVZeEpVRTJ0Q3lUL0FBM2NHamdGZnJPblJLdlRMNUt6?=
 =?utf-8?B?KzgveGREZjY5c3NYdXhlQWhXRlV3SGxkdTNXSkxTV2wwQ0d6clorMndrU0dJ?=
 =?utf-8?B?d1NBclhMZ3I5VTA5WU82VFdpTXZIQ1NHMUZzZ2M2dVd6ZEprd0l3TmtlK2xK?=
 =?utf-8?B?MXhGZDB6MUpFTDgvN2RubnR2Ym05R3NnSlFEMTdqQ2ZISXlsT0hsOHl2S01j?=
 =?utf-8?B?bmpPYzBxTTR1c1R4VmxjRzNPL1J4NVBueUpNeGNQTDVWbi95NUczaENZWEpC?=
 =?utf-8?B?S2RnTmJ4d2haWUx3MTBuem1uMnhEaTNERGMwTmJmS0tFR1NUcC9zdmpKSGxa?=
 =?utf-8?B?d3A5bFJiNFVNRkFXa1pCN3ZhUUplR0IvRnVVMW1WMUxubVZ6cWVaeGNEOU41?=
 =?utf-8?B?L25VeWNySm5xRmpNekRrYVFsWU9aODNwbXJpU3REb25UZE1vSmZROTVxaVd2?=
 =?utf-8?B?bWFENnMwWFBRRzgyYVF3Zkl0S3lWZXp3YVgxSWFQQmdUNHBNZlAyR2h1d1kv?=
 =?utf-8?B?SURSWkMvMlIwOG5TZEJ1Wk90NTdoWTBoZC9NRXZKWExwMWJXWEkvVTJXSi9Y?=
 =?utf-8?B?Z1EzRzlLVjhTMFd6ZUMxc21sVEwwc1JpY3FFN3h5cDhtTFIxcDlKUUpBWE1P?=
 =?utf-8?B?VEVlSFFsWENNZVZSdkNxNFAvbHgxa3VqOW0wS3U5bGVKNUd0ZzJjWjIwUGJI?=
 =?utf-8?Q?im5nABDxy2r3uy/7PxL5S9U2ro9byLeR+Q19x6I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qmw3LzlYdmVqY3dpenlSVHo0QjNvVGRPbGNub0lpUEhvWk5ZRTZRVFVHZnk0?=
 =?utf-8?B?dllwV3Q2RlkxbFRxV2s5UHJDWHM3dGRCQ3NhZ2pPbUFvN3hTN2htb2hZaWIy?=
 =?utf-8?B?c0RmRVZINWs3TkRVMDJBN0xrbDB1UmxHNDN3RUNlQVlhZDhnWmF1ZGVLWC82?=
 =?utf-8?B?TWp0S3hjZG8zUHpjU2l5WmhzRVplMkdPWEJSMTVrcFFDc1R3Ry8rNDlLTXBL?=
 =?utf-8?B?NGhnVjFDbk1pUWtTYUVnNkM0Q1UvaUpBdGkvekF1UHhmamRmNk9mQ3VlcytH?=
 =?utf-8?B?alFIRFVHdWpqdzgwSHNPTU5hRGFNUHZwNnpiQXE5TmtpczJEUm1nVW5uYjIw?=
 =?utf-8?B?UFNlMW1NRm1uVUxlMzlxaWU1QWdvd3FETGI3eGgranhMNlFERTV5VWtmL3NH?=
 =?utf-8?B?WXNYWFFsZ21LZXdYNHluWGNMUDViQTdNT0tQQWVBdXJaQTRVa2NsMzVWVUZD?=
 =?utf-8?B?eFRsWWZJVzhhTXBFWW9CZVQ5M1hqc0dUdEZZLzVWM3NkVWIrcXZ5aWRQOGUy?=
 =?utf-8?B?b0VHWldPSkVheGhPZmpPNmpPdThSRlovM3VXTDE1YWZIb1F2MFd2OEh4Y2Jy?=
 =?utf-8?B?SFdkMHpCeG5tdi9mYWFQVG9xSWE3RjYvMmRGbllLUGtreXBWODBrTEhrbFJp?=
 =?utf-8?B?S1NZd3ZBTC9XTVZXR3JFb0dnWmhjMlpSUURYQUhFNTV1anlkemk4OGFDVGFM?=
 =?utf-8?B?dVRZL1hTMWUyVmNLV1U4dDkvd3hnYUI1eUl0ZEdtY2NBNi9zUkVVRU5zMmZR?=
 =?utf-8?B?cHMwbzlIWlpyc2dQS3ZMUHZXZk91R21yMWNhdThTRG50WHB1cDBETXd3bUNy?=
 =?utf-8?B?T3M0bXNsSnhSS3RoZHMzRnJLSWNVRWVpUjZLTmhON2tvTHlCblBmSEJTYnZR?=
 =?utf-8?B?S3ZBZk9BUk5wdUlzZEZ2TXlxT1BicncxRGxyTEFUeVV3UFFyYXQ0QjdYWkZP?=
 =?utf-8?B?U3AzblB2NXQzNyt5dVZGNXZKbUJudVAyZWlTYWlyQXJmNDdjU3h1V3JlQWxF?=
 =?utf-8?B?bjdXNjByeC92UCtpVHNCL05EWTZqblZHQlpIWFFpMUszYzhzdC85SUkvSE9v?=
 =?utf-8?B?WDYvcjdGdXk5NTJESnlBMENnb2hlbXhyYUZKSTVnRTNqUnpWTW1qZXlXK2tT?=
 =?utf-8?B?a2pXTFVzVnZlcVhEbVVJRmRBMzFtY3pobGlBdlg5TmI1ejE1MkQvdEhRVTNp?=
 =?utf-8?B?bFhLOWQ4aWpuRHN3R2xaeHhxNk44N2ZBaUE4b1NJa2hDVFNaTUtFdnF0T0JH?=
 =?utf-8?B?UlZESVV3aU41ZDN5ZEh6NFVBNmtQeDBXb04vdGl2Z3pqWVBuTWxPY1VEMzBx?=
 =?utf-8?B?N1FxdlVYU3M1bTFHSFcvRGRLemtOcjlSbDh2L0RrOVRXbm1tQlFPRERUZWpJ?=
 =?utf-8?B?blVJOE9hZnJhTjVQRnFXU3NBUmZ3aGoxWUlONU1yRDJ5bUhITGFoTTh0ckdU?=
 =?utf-8?B?aFgxQk9aMmRqcFJRdEpIRTJ4cEI5RGpBTjNrWHRZcFFTM2FPQiszaFpCbGdo?=
 =?utf-8?B?V01zMmN2MHcvU016R0tHeGJyZ2E3SmZHZDh4Vnd0YXNCcm1pMnlFNlRKb1pR?=
 =?utf-8?B?SmpuSzlwc1VVQ0l6VVo0UEZYMUtQc2xxbStMSG1QazJOMjhlazVRREpRT1kx?=
 =?utf-8?B?QzNEL3UxcmhUamxjYTFDUjJEYWJJWFc1S2g4UHI4SEtwVGtVYXBLZC9SUXF4?=
 =?utf-8?B?SUdyVEtQeXFXSUtyZmQ1UG9mRzdabEkrdThQM1JEYnQ3ZE5CTElQWDRmbDlB?=
 =?utf-8?B?SUoxM1JmQy9IZjlSb2g4dFkwSFJyQmtNZUJvTkQ5ZU5uV3lLUzZRcE5GVnB3?=
 =?utf-8?B?c2pua1orYjh2aCs4blJIU3VxZGRNWGRRQ2wvVS9TVGs3WmtCc3cxY2J1bGpK?=
 =?utf-8?B?czZySmZuM3hDdlpIc1E1WjFoZUVvOG51NW5TR01IT1NUdDdZU1ZTWVp1Vmpv?=
 =?utf-8?B?QWozSXBGTXFxWDZyRTd2QXpnRHVnSHRXL2xPZWJSYS8vblJHdkI1TlFWSW1m?=
 =?utf-8?B?aTR2MnA5ZjVaVWdmSFFPL3hEeitKU1g3cHo1Uk5FZHZyOU1rd211TzkvbHk5?=
 =?utf-8?B?eFh5ZkdBZzBkdkI2T2FieEUrdnJLOWlkWjJ6MTFBaWQ5eFVjY3pseDhqVVhu?=
 =?utf-8?Q?rtSWa0Nz0LHZKjkYAXH9f30G5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5nVfygMHjDwxlRkTmXSCkKE7schfn+EtEGNcdfIYdmySoW9/IfErkhDIXNpS6UI0U45608GgOl7HbnuqZbQnbmojHDbmdS3vzRR+WZRby0Mynehm95mtFS7pm8kIo3hAW4ovnYURtKFAPDzdWlAhJq6BjwLbqTyCqXW7gc9Gl9ctm+mUTng4UkFjQOjUCzVpWzsmjStI+89kwZSKGXcHk/yfqFgKYj9nAkPw9MsXP/7YTsZMjUNrLeTOEIZLBUvJpKsV5piR0L9VKYGbhL/x2irOCeXZh78jgSZYsWuTLeWRvwk8g/TwdAw8vRmo3JuW1EPuUXmPEj7qT3X8Op4D012wMIZ6gQeLJkZtd1j2lg/UI/3WABo52PmPDfnK1P+7au6FGiH7QNu69Ys0oA5h3vg9U0dLxNs/ClmuV6gOx8fc/FLu06A+NBNwdEOc3nESc5GuzamePu9bvKhRqYAm8FVWSL8xoVFaDqAymq0pcgyKXhIcZJCzmOGN36GS7nBbsFSQ3XIQ1zDQqBOiQGY7LxPJZJld98Sw6Keck2aRepjoodtzEvTCuHqEKo4A/BzqwTswqypSmLu9sqySlvIZKT1F4DwMlMvNOxcuBeSjNX8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0578a776-52ab-4883-b493-08dcf4437ab3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 15:49:44.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiifhgVeNgbHpAE6RlQrLmOMD/j3R8GwwKDtjDftFSvh+LEAoSxhcBJ1yQC8WgjaAWDIzTEXi6pDq9kCzJ3Nsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-24_15,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=958 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410240130
X-Proofpoint-GUID: 5SIsmPh7tVF5fnYofk1jThBAbmQMwdup
X-Proofpoint-ORIG-GUID: 5SIsmPh7tVF5fnYofk1jThBAbmQMwdup

Hi workqueue and scheduler maintainers,

As reported in 
https://lore.kernel.org/linux-fsdevel/df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com/T/#m506b9edb1340cdddd87c6d14d20222ca8d7e8796, 
I am experiencing a workqueue lockup for v6.12-rcX.

At the point it occurs, the system becomes unresponsive and I cannot 
bring it back to life.

Enabling /proc/sys/kernel/softlockup_all_cpu_backtrace does not give 
anything extra in the way of debug. All I get is something like this:

Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 
at Oct 24 15:34:02 ...
  kernel:watchdog: BUG: soft lockup - CPU#29 stuck for 22s! [mysqld:14352]

Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 
at Oct 24 15:34:02 ...
  kernel:BUG: workqueue lockup - pool cpus=4 node=0 flags=0x0 nice=0 
stuck for 30s!

Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 
at Oct 24 15:34:02 ...
  kernel:BUG: workqueue lockup - pool cpus=31 node=0 flags=0x0 nice=0 
stuck for 49s!
^C

Can you advise on a robust method to get some debug from this system?

Maybe this is a scheduler issue, as Dave mentioned in that same thread.

Thanks,
John

