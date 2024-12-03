Return-Path: <linux-kernel+bounces-429661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A19E1F36
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA64283E28
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60881F4707;
	Tue,  3 Dec 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gpOd7Uw5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U0Cygn28"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7A51F4276
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236317; cv=fail; b=KgXvcCv2YqeoGOdFVNlLC2Ib9qZ1S/Ewa+U09LSD2dzrpn+gXex6jpOpCCQUzwE+UIwynlHyn9Ow19TXu5HE7pczS1vjEUHrflmqmOG8gaA+MD1FSQReNSPAyoHsJduI+Yynjv0LkzubjePVzDVpEatLPxeYUIRcnXV1vw9VdCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236317; c=relaxed/simple;
	bh=aQNMIGrD5wJ9VCGo4L5f8nGoRB324wiPDsJyjQDoIzc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PGY0FL4FibYicNisCnqd8J9wrShSu+OmzbocPi6swJxoBu9UPxaNGgPH2niV7hHcBwJPp9r4qHTzkIgVF+UovOQ0pgpFQcNv2PXm0G7C9IHfglsrJS4EVGpWDNSIxX6dRcN0KVHItH4ml0dtkj3hNtlQnTi1ZkgXEn4oA17WB3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gpOd7Uw5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U0Cygn28; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37XfpB012893;
	Tue, 3 Dec 2024 14:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/0VeyPQcHyLhklZhr5pm3mLO61HGzc534NDI9OZE/9Y=; b=
	gpOd7Uw51kKrn5aNxVqUWpDv61XHXB/k+vU2ljvkin65brOzC+rbKO7jyKMfJL5N
	h+2lKvQR+lLECNGcWd22y6EqC1Ei2Dnix/TRF1W3glIeg5zw71BNO6eKLHuGsVqN
	yXa5MiwdO7hHEq/Svx2xS/7Dw+C58BirchIyh6eF5yD0sVfBOJfV4ygueSBQM0Vj
	5WHbV6LQfi6sU2bpWUtxrkPQGxwPhIob9jq4T3GUCDbaJulAJDXhPRhl5ZnJdMKV
	iKsgk2lHiwoFauJ5q3CDqtY2ulpfGSejsOGsPwNTtXlwPtgCjvunWQ1wJVcNf8RY
	+ET9HlUrvRTo2AwA5WrLOg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437u8t631h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:26:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3CgaFE030371;
	Tue, 3 Dec 2024 14:26:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437wjck2rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Dec 2024 14:26:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k46pAsFw1ekGtrpceM8JDvtIkShBIJGFfPTq1DSHL4CvYcb3yo8kFAIkSvIeKAUJ+UlJBi0QaYwCmTg5ZlNuuWQBppPFP6OUJP1oplx1XOB+/ZUAb9RsWCOKprOSlVl52oH2x+UG2ISfo5rOqZdKc/b3/nZpFoPX3Qz+v5FQPgCHmvqlxxh0kfGNsMKyi+/GAt0kfI5JfqqTjgZYt3GKYWTGhQ9RtqQGm85X4VGNu7AaDcirc3iLo23CdsIK3H2jUHaZ09isBam3fhjOlCuP4bBSCgbO9euYPXlW1PcrQuLb8YB3LewxL3I08l55hFH2YY98VNWBNjmCEMbKp/N/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0VeyPQcHyLhklZhr5pm3mLO61HGzc534NDI9OZE/9Y=;
 b=VYs2daCWBrmvYzlDGX4lxLB/iCqaGy3SK4dNC26F+mYJV3mzazL7o/wtRAQUOM1pHpT2jb5qiKYcu+z+RdlY2gKatUSA7Aqmc8jCZa2FS5sAww/IEovM/DDMujVjDJ/iP6pp0fesvV+MqZsyTl73BnVOlPyJD9SqXEEDTXnU/YUyQ2pPnQ3AL7FtJSyR7hJu7N8pDdDsYM+cgMAywJSTl/r8qJHPpqJBF0i0KmSrm8cNvsRTtNCceUcKw4x2LCjWA9ifyCYddGOOcsl9FUOZCQXEcZV3TDJsgyjkqg7V/5vnDEbuxfWhm0d7FOIrbFpu/2gzNUwQxZ/nb8ITIJ3D5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0VeyPQcHyLhklZhr5pm3mLO61HGzc534NDI9OZE/9Y=;
 b=U0Cygn28iNxF2cq4mIBVWVoHuK8I5RuNtfOfqP/QXjM4eXzZPaV4RTw1CUcW42vUmyZF4CluAuvrQiMrFtZwIc8AZPDZrbYa5LIlAnMy8MdZ1GewtiHtIMs57pRujtoHlX9zJneWqtJ1XwkUP6C9y8Z78YyVH9AkFybmK0DxsWA=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH8PR10MB6453.namprd10.prod.outlook.com (2603:10b6:510:22f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:26:13 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 14:26:13 +0000
Message-ID: <d1f224fb-c0fb-47f9-bea8-3c33137be161@oracle.com>
Date: Tue, 3 Dec 2024 14:26:04 +0000
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
To: Michal Hocko <mhocko@suse.com>, Frank van der Linden <fvdl@google.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Muchun Song <muchun.song@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20241202202058.3249628-1-fvdl@google.com>
 <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <CAPTztWbmkFisL7qnmAnre5hv=UD1E60P0hr_kXNyLoQFy9OoTA@mail.gmail.com>
 <Z070YE81kJ-OnSX8@tiehlicka>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <Z070YE81kJ-OnSX8@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::17) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH8PR10MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: a44c583e-26dd-47f3-7be5-08dd13a6709c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUp0ZTVlb2tSMCt0SjJGWnBGUnNLbFFIcHR1Ym5ld1ZqOWc3WkZhRGVyRjgw?=
 =?utf-8?B?em5XYWhDd2h2ay92WGUybk5QQkdnVkFqajNoa0liQlkrYWJjWmhMOEdDM1NL?=
 =?utf-8?B?cjdTT0Y0Z3lHbFZQOVppUUhWdlNLN2RKVk84Q0VrV3VIYk5XUzFkbEtINWFW?=
 =?utf-8?B?a2pPYVErSHBvUnlhaEtuOUczY0FSZWEyamhtQ0ZDd2dtKzE3RThZMm9BOHBW?=
 =?utf-8?B?aE9WejRKLzkxS0VBTkRJSXZPaEplcTBLZ0NLNklwcVNGMXdRTWdseldrQlFR?=
 =?utf-8?B?ajNZMTZFa0pLWXhrOVQzV3JJMWRmNEh2R0VnOGNSVW5IaERHK2VhSTJjc1pV?=
 =?utf-8?B?OStqQnIrcm9vcDVuODR6UUZaVDhTZHg4eVVyU1ZkUENIMFU2V0VObnowdU93?=
 =?utf-8?B?cHo2Q21RZTRtMjZ6VXNVVkVBMG42aWJYSFQwdGZxOEtNT3lQV0M1UVN4eGlz?=
 =?utf-8?B?SWhiSzRDVjZNeldnZ0RiMytiT0ZUelpUdE9YK1lOcXhXZG5lWGFkaWNkNytN?=
 =?utf-8?B?UVZrZFQ2azAzam1CYU1GUFN2N2UzYmN6NVBacWpDVlJBMitoMGpYU3RoWURG?=
 =?utf-8?B?QXUvaWJMYkVXbEVEalZPdXZMVU41RnkybGhaZDIyTkkxZkdUSDRoNzNnRU1l?=
 =?utf-8?B?MlVxSC9JMElBQ1hHRzZ6V214eGFDRkZ3ak9neEJOM1Btb0s0R2RkZEZDQVpi?=
 =?utf-8?B?Lyt0ZFlqRUVkZUwwN2xWQjNRN3RVUDRjbDRuMVF0cjRxRlVsem9vb0Q2dDFK?=
 =?utf-8?B?SzdMYnp1SUppbDQ2R0xzeDFxb2M1d2lnQUpxd1M2SEkyNUxNOTQ0K1NXSm5Q?=
 =?utf-8?B?TktBVmk2b29JT3kzVFF2SER5MU1tL2xRbmZWL0ZrdG5tTkZhSmE1bGZYYjVB?=
 =?utf-8?B?WXpMdCtoQWlsNFhIdFZoTzRwcUdMWWNkeXg5VXdwcXpyekROSmVLYU40bVNr?=
 =?utf-8?B?WTZ1STZwU2VxVm9JN1BRUG1yUGxncElJbkpnZDZ5UWFRazRhTmhiQk1PUjdI?=
 =?utf-8?B?WHdMK3FrdUV5Y3c2SnBtUTRxYWZMZFN2MnhjTnYxZEdsRE9LT3M1ZGZEWEhV?=
 =?utf-8?B?cnhNTjEzdEI0N2d6L3c5Q3RtZHBCTlRBN1d6dndDdU9kZ0gzaTU3TUtIOUx3?=
 =?utf-8?B?NXlvMFpQYU5remNieklLSU9zR3VMVHhZM2hTamxybjRjU0pIZWp2UVN3MDFr?=
 =?utf-8?B?V3kvK3NGNWhlb1BtOUZWWFEyMjVGYnBMUDJQdlJxQVVBbkkwZnhadHIvMzB3?=
 =?utf-8?B?TnJFdjNwejNpamtsZ3ltUDBiQlNzeFpnZWJITUlXYVNVdVFyODl1bzJBQnk5?=
 =?utf-8?B?ZGVKSjJrUWtqWWxzYUgyMm56d2plSlh6YjFrQmVxSTViSlVBNWxhWlJQOUtS?=
 =?utf-8?B?V0o5akJhTm4yS1dUdURXbHVJbzlybkRKWC96S3o0Z2RpLzYrUGc5bDArYTJE?=
 =?utf-8?B?VzVJd0xXL3R4VS9GOEw5T1pPdXVBeWhqaG5xc09xRDVMOXVIZHVMa2gxdHh2?=
 =?utf-8?B?MFcvS0FSSVJrZUxqNnZpYitEWlVNbTBUdnpBa2pnaktuNFBFaDN4Y0VpdlNv?=
 =?utf-8?B?MFBDV08yMDBqdFk4RWZLRHREZXpsQUdCWEt5VkU2dDF2cnNzMEI3Y3pXMlc4?=
 =?utf-8?B?YldJRVhXSlJROU9RdUV2SjBjS0hpOVhQMm9MVkRiTXpIOGJMMitpQWQ0c1M0?=
 =?utf-8?B?dU1YcENvTmNZVUJKQUtjWm1KM3BIOHB6cGZVWHdqb25IdnN6TUJkRUw2M3Bv?=
 =?utf-8?B?QU80ckQxa1N5eWlEMEYvT01kWXYxODFaajRCcWN3QWNjVS9kR2xoRTdKeWVh?=
 =?utf-8?B?VTl5WHFISU5IZS9VUnpFZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXZnSHQ5UmZhdDFHRWNueVdNMFRsQ040cDNGZjlCVVVaeFNPdk9nRjJNVUtO?=
 =?utf-8?B?QnZ6Q2FpdUMxVGdrZVhDR1IzMkJac1NMbEJUVkE4M3p5dC92NzEyTDN2TSts?=
 =?utf-8?B?WHlJTUkwekRNRDFPek5PSUlBUzJNTThCR3d5djlnNEhmdkwwVVlvbGRBb29H?=
 =?utf-8?B?cUNlelpBR2wyUFlmRUJtclpSTUdLdWplb0hUZm1NYXVDOTVDWjVyb2JBaE5H?=
 =?utf-8?B?Y1pibWRGTzRXNGFpUFg2cGRmU3UzbWNhSmxkZXpQam1aMHJCTzNhY05UM0ZU?=
 =?utf-8?B?ejVnWHk0OGJQL3N1NkJSMlZJc3IxTWE5dmFqblh3SVBJdGpDOWZBSGh3Rmow?=
 =?utf-8?B?b1NJRmNXem5TT2FJaUxPK21xcjhUWjFqb0tCYW5PeHdrMzFBb09XMnJoamxI?=
 =?utf-8?B?b1NLa0lZcnAzYzd1cm9RUzVkdUhjL3N4S3VqdFdidmJCWG00M0N5elFzSElM?=
 =?utf-8?B?SXJGczRXTVNVSDB2ZTdkWVVucDZqYm95VTMrN0NtdWovTlJQR3ZVNThMYU1E?=
 =?utf-8?B?eEJ2c2RvSHNuQzJRdlN4R2M2Z1ZFRHhiSHdaRzNQWjUrQ0FMSkRobGc1UWwv?=
 =?utf-8?B?UklQTlhKbG5ibEdnU3lBYlFVaWJLWjc0MzFPM2JqbnpwMi9wN2ovZTFMVUg3?=
 =?utf-8?B?Q1oxV0xPRlBVM21rMGRDNnVSL285Qk9xRXRnQXZ4enlqc3hVZTRaeURab0lY?=
 =?utf-8?B?NkliR2ROaUp6dGl1bHFWaUJmaVNRcjNBYWNoUGtYSkh4eW52MmZ3dVZNRURY?=
 =?utf-8?B?bDJjdGF4VTRyL2xnY0NDSGZ1TlplNmNmMHZhc1FVTUZzTlgzQ1VIZThQeHZ0?=
 =?utf-8?B?NVpqSnFxNnVXakF1cHc0V3h1blRxWHNTbVBscVJBbnE5bDc3Nmlsb0IzcU5G?=
 =?utf-8?B?QXY1ck9KamlKTzA5dDhVcTRhd05SZGZzeHU0Ky9qc0ZLdjFBUTVDenNyL3lR?=
 =?utf-8?B?UU1xZU15eHpWVDdkc1NNc2lwdXJGNkZnVjFvVXFKVGc2M2ZrV25xaW1PUnl5?=
 =?utf-8?B?cGZMMGM2RXhBOWNmbGMyVTNZTDlrS0NMTE51MFJPTElGOHdIbkpMNlRVKzBx?=
 =?utf-8?B?YWI2d0R2V1VsYTViS0lFL0RGcGJ4NENyOUJuaEQ4UEorOS9RcjB0ODRleU94?=
 =?utf-8?B?bmtPS1dDSjQ0QUZwOFhZZzFJNURJeVExdWNIeU5tZS9rWFVuWHhwN1FESVcv?=
 =?utf-8?B?eU1RRm5xaWJPNEZlc3RoR2trVnQ2VXdVcEpKN0x1aVo2TXgzN3lieTJ0WDdp?=
 =?utf-8?B?V3lFNHFEcitabVBiVm1mWjh1UUUzalowN3RZcmVaeTV6akVMZkNNUlR6eU5j?=
 =?utf-8?B?SWRpQTdMODNoN2hJTklkOFlGNlBsSklsV1IwR215Yy8yV0R6U1J1ZFc0dEZ2?=
 =?utf-8?B?UzIrYkdjUy9TYUcwZ0ljd1cwdkMzYmRhVDBLTUJQNVVSbllza2QvNkN2UmVa?=
 =?utf-8?B?QWtOdTdaSzhJaHlldi9yZjJoVlIzNTd0dDJlN0lIWUFHQ3N0dlNiM3pnSWpK?=
 =?utf-8?B?Y0Zudm5RSGVHYmZDK1RvVElUc2RCbTN3Mk94ak5Oa2JwU3V4aVUvSW40eGQ1?=
 =?utf-8?B?QzlZYy9uamM3NkdQdDFQb1dZS2VTQWZURTgrWnU2bkxoQUtQT21YYkpXOFMy?=
 =?utf-8?B?cFQxdUdxanhOYTJ0TVcvam1KOVZxU3BXZUhKUDRPR3huM0lxNjdWcExYSmlP?=
 =?utf-8?B?S3hES0dlV2NEcVpJWmJ3RldOUFB3V1hpSklVbWpKRStudXB5ckgwcytibU00?=
 =?utf-8?B?TjJ2QzQ1Y0t2QVJWZEs5Y1pzSHdoNk5DVDdsUU5oa0ZEMlZIaHZhZktjWVFL?=
 =?utf-8?B?T3BEQ3l5cE83bnpxei91ejBodWsxNndNTXhPRlV6VVBFREtNU1U1M3BVTDIx?=
 =?utf-8?B?Qno1QXdxU1JQb284aS96L1doekM2NjlreGYwTytZYXNoQm1Od0lGREdGT1Nt?=
 =?utf-8?B?dDFybGRhTVRQYUtaRTIxcG81M1BzRE9sWExXODA0K09MTTdqTmFiaFRqM2Na?=
 =?utf-8?B?MXY5cFk0RFcrWFJzbjUydXIzRmlSZEo5cDEzZFlPN0NqenNLY2JLYVRMNzlv?=
 =?utf-8?B?ek1sekNsTmlRM2JuWFFWa0xUdHlHT0VxcXJBRVc5SUVQd1dkSUtFUzc4NHpj?=
 =?utf-8?B?ei9HQ1U4WnlSVlhRUkNvMWRPVUE2UHh2Ukw0blh6Q3hId0ZURFYyTDJHektn?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n1uU23RPZZzOpqEGtQ8J5hwG5WQoSuAIfxGby8Bl/OkZ6ONl3bOsG+8TlehajGIed5xmbJ3OXhva6c6cwvPiU9YbYRXtuNeHDjUcfQxBo8svD7EhEVXiFBQDr11VfmVb3UBYE/6S0UDod5thYdmJnK7qWLZvQdzwMt3cDUvwaUaVJ7jGDEK9m+ni0uvrfexWUbucj6CfVYncUUPzGbyVRe1ZtBHYiKcm7SdYnc3lmCX0beXKIFGiB3UqPoCxXrOV3rCABt0NE1CTwjBpFtS7SYe9EBJdyp0sB+4+A46jhXhE11y+QIBhhubDPx/98zOIWvwOWAMXJ+gAqE07Bgp7tYIAODQJ1r8YCKdlQKQfYAQTLk71gwtbcIKYCvLOC0oaus51Tq8WPdSt5QEqV3uNnW0VHAc/fFhwwQpg8GML7S+8/YL03nFhzwK0nJVgOMga6SwIw74g9iZYaPvzAHpQkG8vXViAwKvFyMNhi1UtYYMXKPt9Hm+w+qN34O105HF1V3nhHnwOw/gRnCQ0fJUwYTezgD7A/Sk6Iqqo4/R9Xzxh5WB2vyARfrxcyhlf2q/6hHv1Gl5YOYx6xPZbS8Dx1+iKFHCcDslVCdewdwAp7Z0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44c583e-26dd-47f3-7be5-08dd13a6709c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:26:13.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq6T8RVuFqj0CQ+tnyc2TwqR5iURlLtqbIShhe5bU+zcd3hgkumZ1aAz7VjTP/PF7Aup0e6RPriF0+VVGRQ4EUbQKimJz4N77UjB//8lAgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_03,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=691
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412030123
X-Proofpoint-ORIG-GUID: -ZVIab4R7aJt2g47nOTaBmk256hsQy2f
X-Proofpoint-GUID: -ZVIab4R7aJt2g47nOTaBmk256hsQy2f

On 03/12/2024 12:06, Michal Hocko wrote:
> On Mon 02-12-24 14:50:49, Frank van der Linden wrote:
>> On Mon, Dec 2, 2024 at 1:58 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>>> Any games with "background zeroing" are notoriously crappy and I would
>>> argue one should exhaust other avenues before going there -- at the end
>>> of the day the cost of zeroing will have to get paid.
>>
>> I understand that the concept of background prezeroing has been, and
>> will be, met with some resistance. But, do you have any specific
>> concerns with the patch I posted? It's pretty well isolated from the
>> rest of the code, and optional.
> 
> The biggest concern I have is that the overhead is payed by everybody on
> the system - it is considered to be a system overhead regardless only
> part of the workload benefits from hugetlb pages. In other words the
> workload using those pages is not accounted for the use completely.
> 
> If the startup latency is a real problem is there a way to workaround
> that in the userspace by preallocating hugetlb pages ahead of time
> before those VMs are launched and hand over already pre-allocated pages?

It should be relatively simple to actually do this. Me and Mike had experimented
ourselves a couple years back but we never had the chance to send it over. IIRC
if we:

- add the PageZeroed tracking bit when a page is zeroed
- clear it in the write (fixup/non-fixup) fault-path

[somewhat similar to this series I suspect]

Then what's left is to change the lookup of free hugetlb pages
(dequeue_hugetlb_folio_node_exact() I think) to search first for non-zeroed
pages. Provided we don't track its 'cleared' state, there's no UAPI change in
behaviour. A daemon can just allocate/mmap+touch/etc them with read-only and
free them back 'as zeroed' to implement a userspace scrubber. And in principle
existing apps should see no difference. The amount of changes is consequently
significantly smaller (or it looked as such in a quick PoC years back).

Something extra on the top would perhaps be the ability so select a lookup
heuristic such that we can pick the search method of
non-zero-first/only-nonzero/zeroed pages behind ioctl() (or a better generic
UAPI) to allow a scrubber to easily coexist with hugepage user (e.g. a VMM, etc)
without too much of a dance.

	Joao

