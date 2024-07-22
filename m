Return-Path: <linux-kernel+bounces-259354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFB79394A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EAD281BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5FE208A4;
	Mon, 22 Jul 2024 20:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="amWDxI5O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ekzxaglU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94781BDD5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721678904; cv=fail; b=oSPKeBJuVHUK9DSPHnvhOA6E98dPVEBs9Qfm7DkJGA9av7SxzXC7HFBGCPNT7g5b8g7iyAfXgjkJM7kxE6cfaLPwb7bnQF+qdqGHUGZJc5LKVmH7Eh6oVj+ulcm1VBYpJgpDawuMoDeKK8yHEjou2JGnhYaTXj66FIcWmNI4Ic0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721678904; c=relaxed/simple;
	bh=yTajEfi1o1hM37NrNi9M5eT5TGGBqSW66VFjAV1hjsk=;
	h=Message-ID:Date:To:Cc:Subject:From:Content-Type:MIME-Version; b=CzVCINSr+03c5Mr7g/Dk5f7dmu7GAm9nb+huAhnQbGMfseVtfWuyKEOE6roNXm0u8u9pMckJQGU+ANylmQfB26WBckOg8h8QcoGnqyozaBJvrmbcOUZ+yORVs4hith+74cwiN18GhpoGz3yeDfdoiEfqa/Z30kCfEM5vdtCr7Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=amWDxI5O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ekzxaglU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MK7Miq024939;
	Mon, 22 Jul 2024 20:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:to:cc:subject:from:content-type
	:content-transfer-encoding:mime-version; s=corp-2023-11-20; bh=1
	Lrr28r1+dq2KfWkJnYmhpc9bD073O5nAFx5SO0liy0=; b=amWDxI5Obe07dv8z8
	LCfBpa+tl6RWnmMMNM/cnON1nOcmcCriQZRU7OIye7IUeZqajChZajJRIcBsZQXR
	LdHEN3GZtN1L59T+MQc17qeIlxlenpIujWBdU2HMdC7AOmrK9hNvIdyGtmbXHMPr
	xXlf1zHD9C4p3mvrwDoRYgF7M5X6kCoERZ2crRgqrL1OsUqnLxiIULIeoCvL4UD3
	P31Qaq8aE9CFLXROKYMimpdb+xP2mmmOelD07h2bETDoQrtVVSANp06ZarNaSI1c
	kqGf8OwAP4dH2DakwLcc7mSrnOd5VnNtjxRyi376zGaTZWXp+tF36CyVPfa2bQ+v
	WaPVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt39kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 20:08:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MIstIv011034;
	Mon, 22 Jul 2024 20:08:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h29q81ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 20:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PooL4jn2Y21fNGJroXRZeNGip61mEWMXOC2g9cY+iy2fswXHbcB4rBmHsaFiUwggeuAbok1w9veW1+IUsP0qQmMeNhjufBC/v3WzUnOXECrv1s+spJMzF3o06SvJO9GDA3wEtggB1fasVdjf8JTmi//IwMu/i1ECqwUzPO0HQPS1schf2Xvkatw9f1JhHu7r/VlVwGneFiYZgupwzMx9HPJsLUpDO+xx8HvuMiD9CXLeK3PsDh8xaUUBSTqWOFUudaSZpjfbbepkoIFPJL/UbgMUWfNxWTxkJP4eQ4eqgYrlUXSAlq5doBOD5e3yAL2w1RattT6QKtEdsZX8WYw21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Lrr28r1+dq2KfWkJnYmhpc9bD073O5nAFx5SO0liy0=;
 b=i7CIwNVebYTKdZ8PQygozmCnCFzI1u+eGXhbWgSMamU8g7nmQQ5ubckhLgg7eSPC1s9fV2+Q6ZSaDMVi80b4A6sVZO2zUV1fSfV16xTpk6TNZUUfQAMr22Cd6F0HotL90w/DWbQrkSmYyIVGCz8UTpdJr19kGsAQ3mRWiR2SVdmOpzjsoIXV7H2rzLiJ3A/R0nWLUrStixzYchRnmU1H2fIrL+OVLEVjReGfdvt42LSuJI9VbgIkDL0NQwufB79KrwuMLv7JcsvjFVWwMTCQeDLsADq3BVgXl303tYZlZ+wJWI3DONVDk7FZqZHBBXoXhviOcF+LmuSeTO2xHyV/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Lrr28r1+dq2KfWkJnYmhpc9bD073O5nAFx5SO0liy0=;
 b=ekzxaglU03T4T5lM/Pp4sRS9AnmYBhHnskaTG51gcdQ/YifxDo1xVbYkycoo/KaAf44iDdEp404+BiSabQK9XgV1IEBhcfU0M2FgxeWrhGRLTD0FJ0bdKYmOvTeM9LKsbYTZUplbrr2bBVFopz5o71ZwTblICCCrUbeBIdbKkww=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by MW4PR10MB6509.namprd10.prod.outlook.com (2603:10b6:303:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 20:08:03 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%4]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 20:08:03 +0000
Message-ID: <4a4e7343-3af8-499f-8a7c-544848a71f14@oracle.com>
Date: Mon, 22 Jul 2024 15:08:00 -0500
User-Agent: Mozilla Thunderbird
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        "jfs-discussion@lists.sourceforge.net" <jfs-discussion@lists.sourceforge.net>
Subject: [GIT PULL] jfs updates for v6.11
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:610:b3::12) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|MW4PR10MB6509:EE_
X-MS-Office365-Filtering-Correlation-Id: 1290733d-7c90-4668-d01a-08dcaa89fe27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eURsQ3VlemorOEZmL2lleitqRTM0NEVZRzJVaW5vNlB5UHJWb21hcXZBbzE5?=
 =?utf-8?B?OGliaUdYSDFwajJmN3FvTWxLRVdwZGRORG00WFVVNFdXV2FXbEZIeWF6c1cv?=
 =?utf-8?B?b2NBMWhwQ29jY3h3NVdIcXBSZWVUWmVDSzVvcXVMOHVHbXVKQTBtQ0Ria3M1?=
 =?utf-8?B?WXJCUmUwSjZ6N3NGNU9MRk94UTFmOGxLK2NpMXFmRFNaNTlOeEcxenJ0MDR5?=
 =?utf-8?B?dndPZWtkT05aWHgvYWZJWVdjL3VCV0Y3cythS25qYU1xcDhmUFVYUnNZODUx?=
 =?utf-8?B?Tk80WndaVWhNczI1S0tOQUVJQzREa0lCT3JVZWFYOFloRjFqOUo0U1RkVFQ5?=
 =?utf-8?B?aEVrdWVYYVhFL0xoUUZWbS80b0VKQldDNzljdHpiaFRkOXozODRNL010eG9r?=
 =?utf-8?B?QUtwL2JYRUFaMmpBNjhWVnFtZXBPOXFWTFhGZmR1aWJXdEl1US9HbEtjNTRO?=
 =?utf-8?B?Rk03R2h0V1B4ai9UbTY1TmdaRTVyYzc3K3JDaTNVenpTOERPV2N6NEtENjh4?=
 =?utf-8?B?ZEtBYzJ1V0xyZC9TbDNpb2ducFJLV3hHODVlZElGaU9BSmhYVFJRakJpVi9l?=
 =?utf-8?B?T3NIYzdKdTdYVU1vQlp4SGdvbWVLVmpPcGU5MDh3TDJyK3VyTjRjSnRMY2c1?=
 =?utf-8?B?bGtqeVpYQys3ZGVwNFo3M3NVYnEwN0ZvSEpudjg0RDNZZWdpbkdZUUxmZWd5?=
 =?utf-8?B?VVlGY3N4R0pYOEdxd1l0UFBJc1JKaCtUTXRzR3d2YU1EYThQd1VEZ1lEQ1ow?=
 =?utf-8?B?RlFDeE1kN1pFQ1AvWENwNEFFMXR2NkRZazk3czlYeTc2bmxzS3pPWk1YazlL?=
 =?utf-8?B?RUF5WGpNVVdDdGRVSUtIanIzazZKY0tGTG5mSWZWcGFrVDFLNnZNek1CZlhw?=
 =?utf-8?B?K0NrOXp5MFFMd21xWTJUMFRyNWwzZmw1Y1JmT1ZjUzhnNkVMckR1ajVoelR6?=
 =?utf-8?B?L2VsR3A0d3BJRUxkVmNIYnBnQ1RONzNLTWMxYXFZNk5rVkpMOWkwUzFnbCtx?=
 =?utf-8?B?dmNaNytZcE5ncXlVL09SdkNxaFQ0d2pGbGJ5Z3lDVDUrTTdtWTFIc0dzMGpq?=
 =?utf-8?B?Qjg2N1kvOHBXSm9pTTAzaEZtanlob3pOSC9wNlpPOVd4clpRZVNSMUVtVElp?=
 =?utf-8?B?eVd0WFpheUZmM0lUTnovaXd4RmUxNVYzQ21DL3k5NEo0ck5Mbk9EdGY5ZGpW?=
 =?utf-8?B?RDU4L1Vnbzg4WWFvMTVJYzRtUnRoVDlMWXRSSGdPZnpvRHZpYkF5Und3Q1hD?=
 =?utf-8?B?QWZ3dmFNYUFUUWtqczR4QnFMWDdBSmhMVlUzaFVyNlhDZ1J0N1NlZjZSb3Jz?=
 =?utf-8?B?YTdTUm02UTFKdUo3em96K1lrc2dJdUt3bWhzZVVCY09zeUVrMEdMU3gxYWpU?=
 =?utf-8?B?ajlmeEVHT1lCR2lTWjN2ZWxMcm1oeHFvK2ltdDlrRXpuVmE5QzlqUU1nWlA2?=
 =?utf-8?B?ZkVlbzdkWUxKTVRPOVNma0VVL1NuK1F5Z0FHN1RrVGVJcDBub1lnYmc2T2Nh?=
 =?utf-8?B?QUNuSjNRL3ZNa2MzUzFHYktsUWJXb05LU3BjMVNoaXRYRTNvUHhnRzhjbjN3?=
 =?utf-8?B?RS93TlJPdk1iaDZ1QjRVamR2MGZBVHVGWjUyellxbXlvdXE3UzgrWDhKb3lN?=
 =?utf-8?B?YWk1M2l1UUc3aFhnSkwyRDI1bEZjUlIvL3doWmlGVS9GL2ljMVN3YlNnK09v?=
 =?utf-8?B?NUdKN3pUMWdyMGJFcDVpUTM0b1h2WFNtUTJxVEpSQk9VWlhnY0xOOGtMNmVj?=
 =?utf-8?B?MDBPQVNmVTg0a0IzU2dnNTA2Z2lZWVFRaG5ZL0JPQzhOeDlUYjIwQzVEZFNq?=
 =?utf-8?B?U0RPN3JkV2doUGJlMHUxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1ZpcmtSdU1Oc210S1JIakQ3V3lCU2swdUkwTVJmbUJUVk9oc2Yybk5iWkpy?=
 =?utf-8?B?b2ZUdGhWRE9BV2Rxdm9wZnF0cGYrOExBbnNtNTVmd2NtUTBta1RMalpzaVpU?=
 =?utf-8?B?MWlRUmFjalJ1QktLZVNQS0dwSVVTdEZZRHhoc3RzOFpsejhVb0EwZEZDZmlO?=
 =?utf-8?B?azN1elRMTjZKKzFSRjhxeWR6VC9yQVc1ZkRLMVpNQ24vclVxZndhK0tGcHlR?=
 =?utf-8?B?SG5tN1EvY3A3YXlONVFRMzV0ZTltRU51Tk9iZkk0VUlrVEdNNXdkM1ArVU5H?=
 =?utf-8?B?SVlSL0k4cVBpbkxISHZTdEhBaE1IN2VBT09LT2tMQmpmQWFycVVHL0RmV3J4?=
 =?utf-8?B?aER5Z2d2blJSTE9VSCtQSWJYRWRXM2Nqd013T1kyZFJ0THZMbWRPUzF6SDBX?=
 =?utf-8?B?Mm91RWt0THo2VHdoVFVtKzNyTThZQ0EzS0tFQ20xeE9KMVpobzVHamdmd0tM?=
 =?utf-8?B?M1VXcHRoSTgvY3pRWmFkOGlZSTVQanNUMk5Ka0NQUCtaVEVCSEc5T1FhaWJt?=
 =?utf-8?B?WmFxN24xNGVHb1UweVZ0Mkt6bFUrZDhZbFg5YmV4YyttRlI2aUpiVzd0Y2tW?=
 =?utf-8?B?dVdWUVhZanJtOXYvbmZxcWZIV3h1TENkSEw1ampkYldHTk50ZnNwQ0M4WE45?=
 =?utf-8?B?SWsyQ1ZGRWhhcnM5Qm1WeThZRjlhbVdycmFtTHZXcTRyQkYwMnRScnVueWhX?=
 =?utf-8?B?aWVpUXFPeW9XcXF5L3djd3doVHVxdTFlTE5CVU91U2RyN1h5c1dVZ1E3RWx5?=
 =?utf-8?B?Znc4aVUyR0lTZHBhN0xFOW9WQWtGcm4wYkFPRFpxU0hxZnpBN3hIK1MzNk5J?=
 =?utf-8?B?QlJxT1lWSzRHVnhJcTl6WUZjMnE5eENYR2JoTlh6YWpWVFdWaGJ2Z3ZzU1Vr?=
 =?utf-8?B?SWRYUDVwM01vS3BDckR4VnZIQ1BlTGUzZGJOUGpkK2hVVkpvSFRZTmhLYWZp?=
 =?utf-8?B?a0VtZ013M3Q3eWNRZ01kMzlPdzdGZll5THFtZFVaU0txZGw4Z05XVFJDTnhO?=
 =?utf-8?B?NDlvMUlpSFB1ZzJlZS8xSWlvNEsrVmVya3lqMDk1Y3FmYzlyc0tTY1o0aW9D?=
 =?utf-8?B?UytQNjVjaG9DK1prSUtueTBzSFZBSE4yMkc4Rm5CQ0dRKzhEQnVLL2RVZlNI?=
 =?utf-8?B?cTQ2T0t1SXBpRU11Y2E3RFpVSG1BbldDWlZlN3NvWEcrcnk1Q1RvbENwMkc3?=
 =?utf-8?B?SlRKWmdjNWlFYS9jMUQ1cENGV0dSUXVPUDRpUkN2YitaL3RHdTgyR2JjTzdQ?=
 =?utf-8?B?SnVHbGF4QnE0RnF4NzZUTE5qSWtSUkI5SjAyVkUzQmNSSkZxZ2VLRTVYNi9k?=
 =?utf-8?B?OUJpZGIyTjI2b1piWmVNUElYMWFLaDNocFNvYVdwaXdYcDUvNVlYOEx2VzZk?=
 =?utf-8?B?eVllbEFLalc0UWlEOE8xRzdRci9FTTZ1LytxSDFBUWFKVnY5WXZyMlZiLzBV?=
 =?utf-8?B?NUJ0aGtTeUJ3eE92SmZ3cXBLc2tVMmIzRzRQVHcyaEFuWDIzSXhJR2s2VTd4?=
 =?utf-8?B?dEo5d2N0SCtzd2x2bDZ5QU1MZmUwRTErQWlXU3o3WXdzNkUrUW9DWDhLbUVU?=
 =?utf-8?B?Kyszb2VveTZzdzNNWG1Hd2FONnkvTWxrdjhFMlgzWXRyVWNuV0RRaW5SMVJS?=
 =?utf-8?B?RzdNTDBoVXcvR2NadHByM296M2hvbDVCemxUSGp2OGpqQmduSkV5UklyUjFl?=
 =?utf-8?B?bVduQ28yekxkeXZGUThQL0hocGZlQjlHUDZVRCswVTg3RGYrbU14YzQ2R3F0?=
 =?utf-8?B?eE9aSnNpcC9oQVJXY3VRYVN1NlE2RlJYaFBFaHYwc1RldERCMzZvaXFjQWtw?=
 =?utf-8?B?aHNYV2RncFRoYUo2dVZMMnUyN0NNMjhENGtObWtsbys5RU84Q0oreGNaQ3FZ?=
 =?utf-8?B?OFJNMS9INGdnY2wxYnAxekRvaDZFRHhKZmFKR29VWG81eHJuMEx2Sk9zVGlZ?=
 =?utf-8?B?NFJsSFZVNWpzMlFSSXRVc3VuQjdzT2NHOEZpYmJmck1IRU5tYTBUTFVDV1RT?=
 =?utf-8?B?ZERYdjQwc1h0V3lMUE1mdTdtSkZKekVRWldxS2RhZklCSEJxV3VrVkpHOWNU?=
 =?utf-8?B?RmR0K0RWUFNMUWhobHZqbisrakhZem1RdWdyN3hlZ2MvTFM1d2tzN2xKSnI5?=
 =?utf-8?B?bExUa1hCMVQ5c0IvemJpdnhLSlZWUE92M1RWUThZZTZLY3E2ZzVlQTZWbldB?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hAyjIzB/VUjTCKlJ0kn2SoDhpTC5dUKYZ+O6ahBA0VfG5ZLL6j1M1hT4XGUsKgO64toR4dMo5/SplcQdSzlCnufdDx5pseGFAKVhMNWMAGnbkAu47YpW5VPayHhnGldrPWunqgAOHWM/xrzbkQT3Yefz6HUg4JqBZkYpcZCSFtCqVdQt1XefkSajriIiOU59ZXSr54Gqa6YoRynG77oDT63MfkCKi4vFO4pIg5/sSsv+OkXjRx5RDEyFGWLoH/ht22TBubr1uY0ta7WxP/gpBCvzfkw/WRk9wb+5TkQS9/XD8E/h2LJfztv+5rFvzGYbB0CARQzgTMKTtrr5vWRIIHFvJbla+Zcw1JL9M5VwpoVjnP+oSWFAnWAK1bDrXa0NDWDIOclRWxi5+dqyvADiWLdd+nPt3BsQMJm6Ee1m/q2QZtYyvNg6rjHc6oAGgBNQtB0gxLcE2QCcbQoUn/I27YBnDGmT02R7ucgwqtCWX4NWTbq0Zt05ZEavH4XPyRsBz1wekjqOhEv60go/tOGdGMeJkIybkKnZmgY7sD4IGmJF0VarJZF+TFxKo8D5UUCojlm5SrxziDJa6QOtb18YwlGlRZZPIWcsHxal6f3Kwi0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1290733d-7c90-4668-d01a-08dcaa89fe27
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 20:08:03.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOQD0bMrirKurj5z2QcT86zMvGFMn+mncs6M0T2lHzWhACqtFYryISnxnsybUC59a5aa6mN84837Hwwk8TNas6WjRLXOIkMYh5R4XynWRKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_14,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=850 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220149
X-Proofpoint-GUID: ZI5xOW0VgMYTFbszoLQyIvo08y2ZHknZ
X-Proofpoint-ORIG-GUID: ZI5xOW0VgMYTFbszoLQyIvo08y2ZHknZ

The following changes since commit 6d69b6c12fce479fde7bc06f686212451688a102:

   Merge tag 'nfs-for-6.10-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs (2024-05-23 13:51:09 -0700)

are available in the Git repository at:

   git@github.com:kleikamp/linux-shaggy.git tags/jfs-6.11

for you to fetch changes up to d0fa70aca54c8643248e89061da23752506ec0d4:

   jfs: don't walk off the end of ealist (2024-06-27 08:43:07 -0500)

----------------------------------------------------------------
Folio conversion from Matthew Wilcox and a few various fixes

----------------------------------------------------------------
Edward Adam Davis (1):
       jfs: fix null ptr deref in dtInsertEntry

Jeongjun Park (1):
       jfs: Fix array-index-out-of-bounds in diFree

Matthew Wilcox (Oracle) (14):
       jfs: Convert metapage_read_folio to use folio APIs
       jfs: Convert metapage_writepage to metapage_write_folio
       jfs: Convert __get_metapage to use a folio
       jfs: Convert insert_metapage() to take a folio
       jfs; Convert release_metapage to use a folio
       jfs: Convert drop_metapage and remove_metapage to take a folio
       jfs: Convert dec_io to take a folio
       jfs; Convert __invalidate_metapages to use a folio
       jfs: Convert page_to_mp to folio_to_mp
       jfs: Convert inc_io to take a folio
       jfs: Convert force_metapage to use a folio
       jfs: Change metapage->page to metapage->folio
       fs: Remove i_blocks_per_page
       jfs: Remove use of folio error flag

Pei Li (1):
       jfs: Fix shift-out-of-bounds in dbDiscardAG

lei lu (1):
       jfs: don't walk off the end of ealist

  fs/jfs/jfs_dmap.c       |   2 +
  fs/jfs/jfs_dtree.c      |   2 +
  fs/jfs/jfs_imap.c       |   5 +-
  fs/jfs/jfs_logmgr.c     |   2 +-
  fs/jfs/jfs_metapage.c   | 316 ++++++++++++++++++++++++------------------------
  fs/jfs/jfs_metapage.h   |  16 +--
  fs/jfs/xattr.c          |  23 +++-
  include/linux/pagemap.h |   6 -
  8 files changed, 193 insertions(+), 179 deletions(-)

