Return-Path: <linux-kernel+bounces-300905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A679195EA54
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6A51C20F43
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF9A12CDB0;
	Mon, 26 Aug 2024 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WyHCOvm0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SXhcfG9I"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B81129A78;
	Mon, 26 Aug 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657195; cv=fail; b=qsCScklIuZx742+GC1l4CIAezogFzfOlX5pgYvtwx5y1Gph6Alz4mVjNdvReprvxThX8ZYBnOcB9jGSBqoJmUSRrbzBZ2PGmCBq5dBOoPKdruF4EMkkfi5nL4K0p6XWWOIPFPI1B+dxvVKLRNIJGq5v370hpBDaTKlqfKxZTbfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657195; c=relaxed/simple;
	bh=GPEr/HBB0VPu+YdXINB5G4YynXgu8bcXhAHSPxAXvRI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bWPJH8z11yLBGLwPBY5OvB11HPdTLZse2CEAE3Q3tjjwikcH1cL8qhPn7dOjf8OVCdMq7AzlC2gQgDsUVFyvXcC9hufECy5cltsPuvBELgW+gtJRZG1QkYMBa3QqwzuXwtQOe/r21kPUp4gIQmtCqLUQe+xp4jP0LOimT2o16+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WyHCOvm0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SXhcfG9I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q6MWoL010612;
	Mon, 26 Aug 2024 07:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=CAVydrS2XDZI7q+or6iUIlcWL7X4HvKDXPKgOg5OAuA=; b=
	WyHCOvm06/BoXYa0UyfUeZozhiBYI8irajMm7mw3tXAI8CtrhPg8JZUjRof9wIEf
	Kh29KbZw3DYbW7RuCh8raGEw/Dqko7t6zlN0M0ZWoytShWWLhtTyc5WTpt+EO+sH
	S/fNuXGU6VRMR88IibCOLUUSg/Ex6XlnVoNcb56OjXCdKDMi2y7KinjKqsRsBDcP
	TA2hvaKhGI3Emu9zOAfo+E2AZnt5GN/dQnkcBrfkpcJn1uedeQ2Xq6eThBE6JapD
	QjIKW/YB5959cAFTEm6SrZ5B3xG5HQSgI/BCtv33C98d6TDjeR6bcMmq+Ye7Ao07
	rN6isX2cmBkZCAVTDXDGXQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177hwjfk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 07:26:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q679bh035048;
	Mon, 26 Aug 2024 07:26:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sr6swg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 07:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoXwhoKas7eZDiLFMCOv0nRIrkKtN8gKf4egocLs/0ttfYOVNIo07frtW/td1cAnjxWSj6WLNhYOPgnKoYt+4H1owgF5mLikRqE6/pdIyjb2NXqMy30YCe87EyPySvIQUmZli1EIC9JAnfavFZ/apg4M4EdbZH/UTyRYc4f/TiZBcbXeP8rRi+OrQhXtNYe98hRUJBEiFm/1ES2zXnAupCwjTJI15ayzpob/alIY3QS4oAV1HxVS6IimPJCsYEQPanYww0t5407vAEMTMPYmFsU4c0z4T+gfjwQo3S6FJqFY9cquAUsPafp/AgY+0vaAD0PsSRAYFnwIKqf533kkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAVydrS2XDZI7q+or6iUIlcWL7X4HvKDXPKgOg5OAuA=;
 b=MLBKDvP26fuBZivWKWCT1hAivd4T26jIf+TEFsD5MfXQz8P+gMmk2gmi3WJ9o4F8ju0mMIXhnOO/jHcu6seswYG2rQ4zfzTAnq3+SAmV5T5q1ybEXgGv/7gqELno2PCB2zuzTq5Phl/aBoXC+TaaSEfEl1PokvsHrV1hXjls3ePTkFvQhhTgLo5zuCOAA4zR2hujYezQlfmniq5vHs5RRoxuVp/3P2/AyaW0gRCeTR3TFjJ1CfLwOTfiwRc9OMFph4bpOXBzjpTdv8irgHQ4OGJ0dYSm1v8jhvF6tWBzdLqbAm84r7cvyoVad2dqPUqKE6+7WhTyy9AjSMWMCw9FAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAVydrS2XDZI7q+or6iUIlcWL7X4HvKDXPKgOg5OAuA=;
 b=SXhcfG9IMUbuRq3byalI/Pi3rc9SdpWMe9gKUw7bvf2fut+c3DeC65hhMGTyzKHRstgZGAiN0XIBZidoQPFB5abKmisj7DRZuaA0k/FKhcYlBF4jSwNe5gUqAbPGdGwXRtuQ9me0x+BjZEnWKix4nSWAc7m4KFcJdfxwLZYFepQ=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH7PR10MB6531.namprd10.prod.outlook.com (2603:10b6:510:202::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 07:26:20 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 07:26:20 +0000
Message-ID: <56c6883e-26e6-4cc4-b731-337c454ce411@oracle.com>
Date: Mon, 26 Aug 2024 09:26:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: process: fix typos in
 Documentation/process/backporting.rst
To: Aryabhatta Dey <aryabhattadey35@gmail.com>, corbet@lwn.net,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <rd2vu7z2t23ppafto4zxc6jge5mj7w7xnpmwywaa2e3eiojgf2@poicxprsdoks>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <rd2vu7z2t23ppafto4zxc6jge5mj7w7xnpmwywaa2e3eiojgf2@poicxprsdoks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0008.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::13) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|PH7PR10MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 266c4e20-a269-46ae-cbbc-08dcc5a0617a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGZUYzhZT0ZMRWJOb1ZNQjlMZDRjcnBqWENCUW10RzR5dUZiSjJPajlIalQx?=
 =?utf-8?B?OVVOU0hwc1lTaEFiTkUxTnlTVkVNeTE4ZGwrSWRSVWgwenBHU1RlWkxzRUx6?=
 =?utf-8?B?U0o3cWtUM1BmTjRoQ2JiY0lwcG8vVnpPVHN0SHcvL1NUQ2NQenVoTk1USEFm?=
 =?utf-8?B?Z01kWE1UZnA5V1FzbjFOalVsdHhQS21iQk9wcHB1ZUFRRjlacEpJUlhnNXNV?=
 =?utf-8?B?MGFHSEJsUzVaWlduTnZwemdsZlNBVG82NmRmYXBySDVHb3FCYzBqRlRnVjM1?=
 =?utf-8?B?ekpVVXQ4VXpxVkhCZ0J4TXA1cU1JVEk1dG9rQ1N6WWU0YnFjT1NWOWZzc0NM?=
 =?utf-8?B?bHJJem9xZTR2eWlXWWtpdkpaRExsNFFlTlAwbjVrV2R5MkxzVTVXMjB4SkZy?=
 =?utf-8?B?MWhKS00vRlhOa0p6cFZmZi9LU2lyalRYa1FXNytlS2NlMnVwSWtlbnFvUS9C?=
 =?utf-8?B?MUlJYmVSdDI4a2xPYk5aRzBucm5oMlN0WHlkdHhaWnorK3lXWmxRem5iRC9i?=
 =?utf-8?B?K1Z6Zm1sK0k4QXpGd2pacXFsdS9vdVRtdThTb3hyRHN6NjRSckNTcnJqNDRp?=
 =?utf-8?B?TWdnQ3BZQkNNOGt2ZjI0OE5HUzg4MFFadEZYRmpXNE5zR2tQaG0yM3ZJUHRt?=
 =?utf-8?B?YnAxYVJPdXUrVmlZZHhoUWJNQmszQ21SODRHUVpwOGNVTHJnZ251eFV4dExq?=
 =?utf-8?B?YjhMMWF3THU1dk1GRC9HbURWdk8xN2ZiZ3UvWkpBRHFETWpadFlCZktyNm5s?=
 =?utf-8?B?MEJlN2NTdnhwT1Y2dExCeVl0RzRMUERubXRTdUZoRFNJUzUrblRWam5UaXNr?=
 =?utf-8?B?cFJ2VHVPR1pDaFFnM25iQW1Ma25ZT21hUmZ0N3l2b2xaVXpvVTg2UmNUanFX?=
 =?utf-8?B?bGdFTGJtUzRHVTRNbmFIR3FKVjRvVnJCSXJmZWNDQVV1MTJmY01IWXJ4ampI?=
 =?utf-8?B?SHBtejU4QUFsbkViaTlHb1Nxd1pDVTUzOGE2RWpkMUpobmE1NFdZSVlIanBi?=
 =?utf-8?B?RGJCNnF1emVsb1NqL1BxalBJb1U2bXRrN1JucXh4YjkxbEhnQVZyQnpEMDNM?=
 =?utf-8?B?RnNickxmK2pla1krYjNRMFRmTnpPcUNjREM2ZGlsclFUajlJOXNnMS9iMVA5?=
 =?utf-8?B?aDJ4a2tHTW9wY2xabEdzV2JBT21zZXJTeVVHaWVjUHNMY0d5M1F1N0tCcGM4?=
 =?utf-8?B?SnNwelNyT1A1RGdVMytyVkpROElsbyszWmFhOW5lamVkNmZYVTdVa3ZKdGZP?=
 =?utf-8?B?U1JkV1VoTDNLWUpKUk1ZckRxSk5TVE9OcU01SDhEc2V3enJFYmxud2FXbFFD?=
 =?utf-8?B?d0hmZlpOeW1JK1IwUEdjakpnYkQySS9NSm1pN3NNbmVucEhvZXlzL3NOc1Qr?=
 =?utf-8?B?ZE9ha2Y5VE5yV0RGWG1Idi80WUFiVEpYRzFubEJadGg3eFpVT0srR09GRDBo?=
 =?utf-8?B?MXE1bFdqZ0JuYUMvTTlJMkRaNWRZUU44TWZ0Zml6N1VYdVJ0cUQxeHhRbnYx?=
 =?utf-8?B?T3FEdy9LMEVGbGR4b29kS2wzZitMOEhhMVRLVHgvQUt1czVwNXVuWTBSbWJN?=
 =?utf-8?B?WUJoK3JHTXpZMjQ5MFRMNlQ3U25aUzJuYm1GSVZocVpwNHVtcitVQisydVhs?=
 =?utf-8?B?RGM3UmtLcEtzVDlpTzAyOHUzVUJoM1hNdEV2cm1rbkVVdnJSdnluOHdkZWxw?=
 =?utf-8?B?cmRNSnpaWUtReXY4L080L3h1YzBvaU02N2ZFMFl1ZEpXWjY2bXVsdjlzbFVE?=
 =?utf-8?B?VzQ3ckgrVGQzU2tjRkl6QjM1Z2o2Wi9MVHltQ3RLcmtSQ0JxajBMR0VJcTh5?=
 =?utf-8?B?SkZRYmcrNWJwZG1DQ2E5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2YwWm5QSEZ6c1Fzcm1kby83Y0drcE1pQk9wV0hFaVpVaGVvc1NTRExMV3Ft?=
 =?utf-8?B?QmdjaHIyb3gvRHFUcnBpK2lkS0R2QUNkVi9tSU1LU3A1bXl3TUd3YlZTWXZY?=
 =?utf-8?B?U1dZbFJselBPSmhxTkY3QzAzb2lMQUlRdks5V0dVcjQzRFdQSloyOXFkQkVF?=
 =?utf-8?B?V25YZC9iUTJRYmJReFJ1MHZBMGFtcXBOdzB2WGNBVFIyaGpzNmZrZ0FvdXg0?=
 =?utf-8?B?b2dWSFlnMmNXcis5aVVsYnJwWGo1VjVIaDAzajdIMTU4Mmh1cVFMVTNoak9E?=
 =?utf-8?B?dmdiMGh1QmU5MVJtL1E2RWxNaTZkRUlJWGxHSFpQc0J2dUZrSWhYUHRWUXVX?=
 =?utf-8?B?SmhZR1d5ZTJPQnFTazBTcTBNcTZ4d2RISzZQclFSZUJuaDBPbncvWGV6NVha?=
 =?utf-8?B?aDFaUTl4QVNTSENPUGsxTk14Qy9yWXhXanI0aVU1bjUvaS9uQk1iLzJnNkdo?=
 =?utf-8?B?Vjlaa3ptYnV5aTdOMW9TQ3dneXJRcDFBVHJ6V1FnVHBvWi9xYW5kUWRkaHE2?=
 =?utf-8?B?UzNmM2IyNHVIVkhZcFZvZW4wT1R5akJNQ2NjU3VWaE5hcXdMNmd1eDZvOUhJ?=
 =?utf-8?B?Q3VLU3JIMlNnNkdCbFBNUWRGT2c1OE1oWUs2dTRkcjU0V0FSS1UzQzlZUDJz?=
 =?utf-8?B?T3JIbDlqZTI0blNUbjBrYjBOVlo2SWwyTWJkVk1MRUg4K2lJQlNJRCtRU0lD?=
 =?utf-8?B?UzgvTGZ5R1NTUXMzTWVWaHNIVWV3V0hEZkpVczI2TENJaTlUdWZ4NFhyOEtp?=
 =?utf-8?B?bnFKbEtiQXF2aXBLdmJmbGJKMi9hU3I1aFF6a1A0MHJzK3dDaVQyVW9GczJJ?=
 =?utf-8?B?MjlvZnZSRUNyNjRXam93TGErdzBoT3hoUFp0NUxSQi84bmtGQXAyeko2Wmlv?=
 =?utf-8?B?MzJTTmVDMmxHcm9mRFJkU0tKaTZxTFpFV2RsS3QxMi85SG5WWlBpbm42bEln?=
 =?utf-8?B?ZFRiZUhzdStyT1c0Y3F5b1oyb2tmSmRRNjl6OWNFNW1DQ2RvK1Z5L3paazc3?=
 =?utf-8?B?b1B2cFJYRGxmZFh4R09zMGZQSEJGQVZrTHhRUmorSnBxUnN3ODBQSUJaN3VF?=
 =?utf-8?B?YnNUZ3V1L0E0QWFrRTZ1R2dPcklnOXY2QW0za0RDVGJTMVVYWUsyYzgxZkpr?=
 =?utf-8?B?STdBbWhURWlsUFlvV3NYTGNGR1ZHZWdnOG5QRG9yczhvelhqSGsvQWpPVCty?=
 =?utf-8?B?M3VEbnpDTjNGMVY1Z05NcmQ2aytRRlVWcHhzRXh5Nm01M0FiendwVnZjRHd1?=
 =?utf-8?B?Y2xGWHpRcVlteHgrUjJGUk9vTWdyZmhRMDhSM3VYdmJoR0F5dGYrS1piZWRQ?=
 =?utf-8?B?ODlKMDFRdnE0YXhxd2R5MXpRcytjQ1lldTJrREczV0VOTGZuWWVTSkdjRHpN?=
 =?utf-8?B?c1IxRFdPclpuUFN4Y09JQlZzOU43Wnljc2ZQY1dTNnJsV3JFNmVObDBWejhp?=
 =?utf-8?B?dERWdEMweFhWaUdmc1ZaK3JhOFZBL2xDcmk0NGJBS2hHWmxpQzI4bldXQ29t?=
 =?utf-8?B?OGRnMEUyay9FN3A0L1Z0ditHWFlhM2V6cWYxSElxeUQ5ejdqdlN4YlB2TzdS?=
 =?utf-8?B?V2VJYmx5MFJXTXNwYk1TQVFJdkFKR2llYlpsKytJcHNaT2hRTTVOUk1CeHor?=
 =?utf-8?B?RlFzOEM1aHZ3dlN1dFcybkxtZE1wRzVMcWtZaWZTVlpFdC9FN2Fab05za2Yz?=
 =?utf-8?B?UkxlMkc2dkJYcDIvTUJVZU9naE5SRVlvaFhUR3E2M3V3Y1c3dkVNOUZZdUVV?=
 =?utf-8?B?K1NZeFc0OWNCcVBYcGtiYUs4aGVDOGt3eEV5Ryt2d0F1VGp0c1NXYXE0b1pj?=
 =?utf-8?B?UlltOVUwQ2hNT3RJNFJ1SHBvUnlnanVLSS81RVNZV0k5TFVSbFJLY1RZUU1l?=
 =?utf-8?B?azhaRlduTHRuUVBYTU9YdU1XSkpYL2hvVFliR2NlOVVKVUVLTUZzdDNwcHpt?=
 =?utf-8?B?UkNVLzE3bUtMVlU2NlhTM2EraDFyMjZWT0Z4VFZtcGszNVU5RHo3Q1lHendu?=
 =?utf-8?B?VFBqU3NibWdGb3JnNWZFZ3VGcHV4dHhJY3dkdFBjN05uRDFtNkRpYkprTlBt?=
 =?utf-8?B?Nm40aTAzVndHblBHK3IxTnhaaVZQa2dSTUthNExTaXl2ZTBOd3NyRHl0R3A1?=
 =?utf-8?B?cjJ1eFN3V25hdmsrMSthK0h1Zmw1ZmpZZVlsNHZoOUwzVytHTytoaEQwMVB3?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yu8RQ3FePPcuvf5QM3VoX9RMDux/KN1S88sFZmWTVjhlZoJ8hIu/l8BPXmvCZOOf3kfuvvPzJ5wzE9CLeaHXQsx643OP4Sk/kzsNT8mHRvvdOsLIPN2y/KqOr823cHXDchc6DLrwOVjwj2XZwp1Mz5xMSEHzFeVZm30osGuDM0qb41SQNwAeh/VHBxyjGXe34ENh8h/lrmciLvu8lGuFPoC8k8AjYgz5yL/GgcjF7QGtEBrH835Nm2cez2RBmcLxk7d2vBL5uZO/wh1mu42KmasRx15K6encbX7mCwE8HCRQ4YcVjScUdB260oWPg3yAKRMC+7OEZbbwWXcoV3Ar/4y71IenD3k0BPzSFUDJjMo9ynQmbhsXzDAh/W8RKaZF4AMNHb8zwA++SWzl/qTqpSihb34HjBpyl43IJ6EQHMS4wjTvgNFaGisjPPcrWW78CYU5Jy/KgVYNqUlnWFTjbL9mBkJN26n+BF2y0/glaIj/bRFl5MpngjN2IgmMKvSM0kPwvnpByDX/Oot5Y8nnDqXRs5f7DSGnl5KtVaTBjLfogJineRgVlfmPFL0QWm2d8V1b1/ZOP72DsH3B8NH2wl0+eaIJmlbL+E/oq6Pdu7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266c4e20-a269-46ae-cbbc-08dcc5a0617a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 07:26:20.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NEYtYEeuKSQS/BM5a7zR9igqAO6AUriNv+iBP7ihL+3K58mSutFzrPbkSME9Dp2rIiloBUcpDnmXl84eCQK/TxCQODyAShgJub5HsPcNdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_04,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260058
X-Proofpoint-GUID: dzcakDTiwQC5pswWaFgkRUvsTsES9uCQ
X-Proofpoint-ORIG-GUID: dzcakDTiwQC5pswWaFgkRUvsTsES9uCQ


On 25/08/2024 13:33, Aryabhatta Dey wrote:
> Change 'submiting' to 'submitting', 'famliar' to 'familiar' and
> 'appared' to 'appeared'.
> 
> Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
> ---
>   Documentation/process/backporting.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/process/backporting.rst b/Documentation/process/backporting.rst
> index e1a6ea0a1e8a..a71480fcf3b4 100644
> --- a/Documentation/process/backporting.rst
> +++ b/Documentation/process/backporting.rst
> @@ -73,7 +73,7 @@ Once you have the patch in git, you can go ahead and cherry-pick it into
>   your source tree. Don't forget to cherry-pick with ``-x`` if you want a
>   written record of where the patch came from!
>   
> -Note that if you are submiting a patch for stable, the format is
> +Note that if you are submitting a patch for stable, the format is
>   slightly different; the first line after the subject line needs tobe

There's another one here: "tobe"

>   either::
>   
> @@ -147,7 +147,7 @@ divergence.
>   It's important to always identify the commit or commits that caused the
>   conflict, as otherwise you cannot be confident in the correctness of
>   your resolution. As an added bonus, especially if the patch is in an
> -area you're not that famliar with, the changelogs of these commits will
> +area you're not that familiar with, the changelogs of these commits will
>   often give you the context to understand the code and potential problems
>   or pitfalls with your conflict resolution.
>   
> @@ -197,7 +197,7 @@ git blame
>   Another way to find prerequisite commits (albeit only the most recent
>   one for a given conflict) is to run ``git blame``. In this case, you
>   need to run it against the parent commit of the patch you are
> -cherry-picking and the file where the conflict appared, i.e.::
> +cherry-picking and the file where the conflict appeared, i.e.::
>   
>       git blame <commit>^ -- <path>
>   

Thanks for these fixes.

Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>


Vegard

