Return-Path: <linux-kernel+bounces-398751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B789BF562
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A50DB25027
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30E20896A;
	Wed,  6 Nov 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NoELXw8F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="faIbUTJy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FFB208963
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730918058; cv=fail; b=nXcHGag11vFkXAA71+Afi2jpPlS0zDtgXzdsvtRVmk8P3xkmz+PyvPAmlFNFyDXuqHjXLlC+UnBcsPABkQ3xzGnklK1XwLCIXs9VT5g46NQPIziOZDwGynHtNk1XOOJmt8Clem83dKMFeDFPgHkAY6w49f2MwPZv113xZN15CEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730918058; c=relaxed/simple;
	bh=C1LvXFHYAnhN5SqPL54kHlIxm0lkkEw6L2Cwe5mR8X0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SBofKRaQKSbXHvodaife2eb6OVm7E/5xzqkVH51nbP59ODa7lT6ymyp3ILc0I23MS6vahJD4QOoIYecEfHYgssZw159sGC6hgTuvazPwsu71ZmQuuiZ250t8Pu0NjUl5/wUsGfKkX++1MCwtcWedaldTJkhusN8UT969HnlNxWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NoELXw8F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=faIbUTJy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6IMdeu015995;
	Wed, 6 Nov 2024 18:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=corp-2023-11-20; bh=C1LvX
	FHYAnhN5SqPL54kHlIxm0lkkEw6L2Cwe5mR8X0=; b=NoELXw8FbKUIMpbVVplNa
	xpJCqbjGXe6XJLByr9byCxUq1ESO392blCtIVrRka9oN3HDuAvX4B0vnzSgW/EeR
	DTI8P6oA7ErH2B5uEt5DNDlCu0MkEOjFaypJfA3CC+GjYgnmS0iaUiXNVEtbSlzV
	nYnBqGpB9sg+Et5F0e5EWhtU5Kwoycm8VyBQoHVnvvjbCrJtCqi1ntOKQWEC5y4H
	0K58/u3cOPILI2gB9RWgIvSSOZt8eziVFZ5p90RXkwR4dC01BHYvXY3eStp4Z8nj
	dP3gvt6bn2iPaLqOBzQs7j3Mtgnhkxab28zRD2MplLZXyGzJhEanFxT6Nl5SQMyF
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nb0cgr6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 18:33:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6HrQBE036797;
	Wed, 6 Nov 2024 18:33:55 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nah8y9dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 18:33:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl87Xbi2Y6acXKlMHkhgqhNfo2A6E0JThZDmuMNGutA4FmiGuEtVt53SkCtgt7ynJ4l5g1rNvNjBSlbgi9iDQNGpdEl0f1p+/S8xDGL6kQyWTMDlILagxoasONyNr9eJt9ELyLXtP9mOQhETsfKLu+eJfWszOcStn4ZTzx3px/sfiCJk+jTah+KDaZ7uQXis6AItfwoK8+HagWb6uDygBZC+KMw41eERZYeSOm/TBFeF/Xele3iIdVeQtIU5mmvldZjRYVJOrRoUhAKVCsjUeis7kLqBpwA1BMdMVxIpwwQdgEkctiguHu0sKUuXNxr4KYbd8tk7xjFDnq6ZGYQ0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1LvXFHYAnhN5SqPL54kHlIxm0lkkEw6L2Cwe5mR8X0=;
 b=NnbImu7c9ovZVRwUFKGInEdSbhop4J7A/DD4Cm3naMD+/ZLRoIbJVk3mKnZWOuNm05DycikUTVT3Ax/tBE31kuF1zdI5L/Uf4okSaeGgQc9ZWy7lWKmEd3OG/jhGqA0SmhF+B2ZGcy00Ky/S73XRjwc7awRtFAQ47st9GYHfbFj8sDqD+9Llb3R3iiYJRlC38+cvzw72N6MnExdreQ0iaE8KAg0PjX1DSC3TuCCo/ClrwsmECBbOi+l9m7sfk0bB52Tzqrv+9zkNVCJw9yu8nLreZ1yXeJn8DdZn6+Ztecuuj7HV5MhO+yA+EKeyEHMNMHm9nHpTylAb17mcAFa/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1LvXFHYAnhN5SqPL54kHlIxm0lkkEw6L2Cwe5mR8X0=;
 b=faIbUTJynRZqZtcKqTGKU5NcMNi42ZyI73+gwZw8YzEshiKatzF0gGqgNhcHDVqMJvxjCBNTpSi1JiYWlHeLYiL4cghZ3mEbJVe0EkAJ81IiIEnsjJ14EvcuX3IF8EonnEsENwjQwH97Bf4coBYXVQAN8ehVyv5XF9uRd4jSka4=
Received: from CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7)
 by DS7PR10MB7279.namprd10.prod.outlook.com (2603:10b6:8:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 18:33:53 +0000
Received: from CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199]) by CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199%5]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 18:33:53 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Rudi Horn <rudi.horn@oracle.com>, Joe Jin <joe.jin@oracle.com>,
        Jeff Xu
	<jeffxu@chromium.org>
Subject: [RFC] Restore PKRU to user-defined value after signal handling
Thread-Topic: [RFC] Restore PKRU to user-defined value after signal handling
Thread-Index: AQHbMHpucV7Hizrp2kqRQDNKin637w==
Date: Wed, 6 Nov 2024 18:33:53 +0000
Message-ID: <4225E088-6D34-421A-91AA-E3C4A6517EB7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6708:EE_|DS7PR10MB7279:EE_
x-ms-office365-filtering-correlation-id: 5db46c9b-4d79-4060-48b9-08dcfe919114
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a0dUdDd1bkRYbThTcEliUVlITnRRc0NPMXhnTjU2MlRpekVldTMrYjA4R2Yw?=
 =?utf-8?B?K0lCTU4rbHRvY3RGSGUvNWltM21XdFNOVFErdkdkVHlxQzFISG5PY2VjcVlo?=
 =?utf-8?B?c3RITTBWTWtXT2xhOTVYZFhGV1NleUFNRjZxK3VaNXcwNkdFSXVPbjZMei9X?=
 =?utf-8?B?aFYvRGlpMS9OWjhtbDFBQmJOcnFNT3BXWlRNdlJFeVQwQXR0czgxOW12c0dr?=
 =?utf-8?B?d3RmMGlZdm8rUWdxbnJVNlgrbU50NFZnQk05WnBmK1FXMldWNDhiWWxlSkgr?=
 =?utf-8?B?cG13Q1pURGV2bmhWRjhBWG1kL0hXM1g3ZENXb3BTTDJCb0MzT3UwRjZnWXhH?=
 =?utf-8?B?aVNrNGtPR2FMT21Jd3Q4MUxlQ0U5eGZuM2lReDNacGlCVWFsU3BqNGlLMG5J?=
 =?utf-8?B?bWE0Vmxwa0VINHVWYU9sUGY4N1N2LzN2WXpJSHk3UlZpYy9KYktTUkhQbUla?=
 =?utf-8?B?S3I4dDNOdklwVkppWVQ5OG1JejkybGRvNHZqaVdHSG9xdWdMcHk4aUU1SVJz?=
 =?utf-8?B?RWZVbEZmOGlPdVRJTERSMDkySExJMEdpWXdWY05VREt1K1NQdnZKVkZWbUtQ?=
 =?utf-8?B?Q1RBc2JlZkR6aW9YUVlOT3RJOWVIdUNNZ1NhYXBiOGUvdEpOVXZ3bHhjR3JM?=
 =?utf-8?B?ZEVPRUwrMnFoMldGbDNad09yZ2JFeVBJaEFNU2lqa0JGSHR3aXB3U3BHYjVL?=
 =?utf-8?B?TklZbnc2MTBhNWh3OW80SGdCT1B4cW9zNWFvM3k2clNuWFhvd3dzMDA3eTNp?=
 =?utf-8?B?dExSaTdqSEQ1NEZkOEs0RGk1d3ZIcG1CczlBZ0hDSTJDOU0wU0RwcGEycU5h?=
 =?utf-8?B?emFrcXFGUlRpNC9mcVlmWkJ4bW10UHM0SGl5RmxiMVAyN2wyR1dQZFJ5Q1Jw?=
 =?utf-8?B?ZWdCeXdJSlZaRkpOcGYwYkY2OFlrTm9iMnhxdlQveUJsYm9PQlk1MW9tbmVF?=
 =?utf-8?B?ZnB6T1hBLzBoMG5pdVBmQVA5NDFQbWVJUTVqY1lsTGVmOEVPL3ZtNWlxSm1h?=
 =?utf-8?B?dXJUeG1UOHhudytzOHhOMFEyZFI0cm42Q1JyTlY4cjNwUWNaT1NJY3hka2dV?=
 =?utf-8?B?RS9zanFrSXVqUnc4d0F3VFN4WFVvTTNFOGZkQVFOcXdUVzZTbTc5Yi9qSmox?=
 =?utf-8?B?RU5JVWNNeDJUdGRBa01ibDhsYUo3UjBSeWR5U3RvS0Vib2MxaVAwZ0c4dUVD?=
 =?utf-8?B?MzY5dUVnUWZQSEtrRVduMnFmUXFHdUdOSkhQaW1URngvYVZWM0hyOGJYZGdm?=
 =?utf-8?B?dVdCVnZpTUhGTDdIeUxxR0pKL0JQVk9yMVNpd0E5dkc2NU0yYXFxWUZWdnY1?=
 =?utf-8?B?RTN2bnFaV2RoRkd3Sm9kTTJqTmgvd3REdzJ0eXlMVjB3cExBc2w3WUdibldV?=
 =?utf-8?B?c005RHZPYWhQdUZKVlBYREZ5VEFrT3Rnb0htTTI4U3d2dWk0OExzT3BpQk9z?=
 =?utf-8?B?SFJaR1Q5L09HZ2FhLzd1d3U1MXBFQmdJQksyQlkwc25ydlhpYzBjMFBmWXc1?=
 =?utf-8?B?L0Fha0FSazBmUFZDZ0FnNGdmYXlDTUxudFdyaTJTS20vZEdxRGtSR2ozYTVv?=
 =?utf-8?B?VjUyU0taenM0YnE0SFdNMUVKcExrbDJ3V1BaT2I5bkNHdXhzQTBtVDRscW96?=
 =?utf-8?B?Zk84Q3JqYWZYaWtwbStpS0Rubm0yZFV0TVFNdkZvSXhOMFQ2Qm90MWw3U3pv?=
 =?utf-8?B?aDB5ZmhGd05MdHBCd3pSWmpsQVdOVklQc2d6MmVEdWNpZndNWkI1ZVhGbTZn?=
 =?utf-8?B?NW0yN1o2WUZacXBSV3lFcHc3aUVnb01nY1FyTitGMmZqL0c5S1VmSnI5Y1Z0?=
 =?utf-8?Q?vD7hjSBTpp1IFBjnF3AjAtoMap2SfG4LgkeoM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6708.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWc4dktlQ094QU5MTXZNMnJ1YWtjamx3U1Y5MnZDZzgvazJMYStCQnd3aUpL?=
 =?utf-8?B?aEVTcUVGZ3BvRDdqek5jU3lXOVp6a2g2UkREdUMvUUlIaXZDOWVlQTYwaEEr?=
 =?utf-8?B?VzY0R1Qvb2pjNFZ2bkdaR1FWTUYvV3VEcTFkQUc0ZnJYRS9GQm1iTVo1NmFr?=
 =?utf-8?B?WjJaYTVjUTRFMEhCaGMvd3VDRncrcEZwd3gvUWFVZEVRa3lNUHFIQlhMTmtK?=
 =?utf-8?B?MkZ4K3ozbDMrT05SK3NQUE9xaGlzdGV3dDR6YUt5NGtoSEx1TjZZZDV3a1hS?=
 =?utf-8?B?V2xML3h4V2Q0RUQzYVN4bEt1eUxlQ2tucEhYTk9qMWpDY3hRWEVLQ252OHpB?=
 =?utf-8?B?NFErYlZRNmlBRXlwSWh4T3M4N2N0ckJFcTgxdjg5cTJUdFgzWTJ0bzl1TEZP?=
 =?utf-8?B?NVRrK25pOWZTaVZ0TmY5eXplWDQ3Q280cHpnbWxpNnBQTEtlQ1BkbmNTVk8y?=
 =?utf-8?B?dXcybml3M3hTenJmR2h1WkJ0cjA5WlcvQW5NYkRFTDR1eUtra0dsZEN6UTZE?=
 =?utf-8?B?bGovNEtwb1RVYkltZE1hQ3U2SkJtZ1lhcXdwRk1lRmJ5Vk05UGNiVVFPQUhG?=
 =?utf-8?B?VWVHcERtSDMwclE1b2dPY2oyQ2crR1VWc0hsT0lrK29xMVlRdjRtMGJTYWpT?=
 =?utf-8?B?MVVPQzVmc0hSUzdUOEJMY2MyazBDcG4vL3J6bTdoL1I1NTRUNzBVd0dWdnVV?=
 =?utf-8?B?QUdFaDdDclN2emJpNldvV29ZWnhlK3lBZEZ3L1FvOFdGNnhURThIRktMZU1V?=
 =?utf-8?B?QmtWS3JpalFyRlFoaVZlYzVDeS84UUVsZjNUZzdRbHdlVWVWdGhpU2tadEhB?=
 =?utf-8?B?TXMwdms2SWNLRkxBUWJ1eWl1ODl2NnpWbU9pZDdWeEZHd1lTMU9wK09xU2ZI?=
 =?utf-8?B?N1d3QkplaUhYQ1M1K2tXWU5VMFpFd3RHM3prU1I1OWd5VWg3a00yY2IzZk1q?=
 =?utf-8?B?M1hQZnlZYVBYaEJBOHVab3V6cDYzVkxONDdjZ1pCb2h1eEtuYTd6VytPZWwx?=
 =?utf-8?B?K2JMV2lNNEo5R1BTWHA3dWdZcXZVdUp0L21vUVp1RUJnaFRLbHUwK29CTTJI?=
 =?utf-8?B?aFdrcUNqY3orYXN0S1dyRFMwaG5XUWZ2K0RhMVRHaXZtWklnOTNMMmt0MnN5?=
 =?utf-8?B?L3kzNGVBWWk3SFhGZkRJSllrSTgrOThTOVZJODAvNlpEZTM1Z0cyaHJqV3B6?=
 =?utf-8?B?TmFoRVN5eXdxaS9qMkkwVjNsaHBiMkptQXBoOU5LVzRDOEVQVUEvZ0MwT3E5?=
 =?utf-8?B?L3VhRE9ZVks2NjA5L1A3d1NUdTlUWUE4bkYwMGI3Q3g3L3FNc2JXVHlOZWpv?=
 =?utf-8?B?ZDVPTW5NTjZLcy9OaEVWRVJVeG44b1lLVlBjVGw1U0pqdTBiTFNTblJYZ0dJ?=
 =?utf-8?B?S2xLK0RhempEcHppbkdBaTMrRC9SUFFRK05BZmVJRGJldTZrOWV1T0hPT2JW?=
 =?utf-8?B?enFFZjVtUFFlclFnYTBNOHl3Kzg4VTV5MzMzVUpIdnlWZHhaMzRlSFdsT2hR?=
 =?utf-8?B?ZFZPNkJMYnF4bkRoWGZNenQvRkpoM08vSHNkR25iS254bStSVmE2RDFxcXVO?=
 =?utf-8?B?emJXL3FwZ2thM2lrcUNlVkE5TTZLWUJSaS9sbXdIN3dUVHpTNG5uQkpzeU1u?=
 =?utf-8?B?YVYyZlZEVmhxWFJCc0Y3ckhhU21VdEJoMG1yamt6aGZ4NXBub3JyV21MeXh0?=
 =?utf-8?B?ZW9oREhWZjEweWE0Tnl3NXd0TkNzZjV5OGhsUEFmMnhaRDhZdGpKa0l6WS83?=
 =?utf-8?B?RDFjbTlXeE9HOFVHeVppVFlLWmhDbm1jQUt6STI1dXEwSm5STTBLY3U5aXVG?=
 =?utf-8?B?ZUhuWk9qbjI3VllEeXJIOWRJU0ZEY092cE04ajdqb2xuQkVkdWYraXZFYndH?=
 =?utf-8?B?REdXQkNibnJ3dE0rcHUyRm41bENtRWRDd1F5bVhqWkxDcEVSQ3hjWDl2Umg0?=
 =?utf-8?B?L2lzOXplTzRodnpCMDdQOUZMemFaTllmZzRLOGxjN0RiUWMreUVNQ00wZEpw?=
 =?utf-8?B?b3lFUG9SSFNnUXQzS0xFZk9UVG9zdDZJZFZjRWN2eTliNWRrKzdMOGVhdFBt?=
 =?utf-8?B?SU5tZUphdUx2YmIyUjkyV041c05EZUxueElKcm1IZWhZdXFoQll6K1FyZXNZ?=
 =?utf-8?B?UTl4VXpmK2plbmJWQ05RYlhSYlZUR1V3RVgwY2dHLzdZNGpHNTUvT09kY3Jv?=
 =?utf-8?Q?crETnHdfqgCB2Tw5kMGNCe44M1fXlVA4sa13QtfBJ33l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FA00DC9FDE12D4C946FCE55A5429D74@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gXpAMdoii8SiJMC9WxnbuUI4D9GoGev7SINuGP9GC1LP8B730QLbkBVxu2yAsXuSWSpetw3wxi6L6uCOly405P/HyEfp6/1bJixcwiMHvJGTJkPUXQUtAFNYvUZ0tTiODJ3fn9CU0qrGjyFLorw7QJ91n3COdT19MOPU7PTqqsiuy2QPLTwKRUq+j6zmywqZ9A/Is2uf5Aw/iSeYxh0d4GLEhlS4JVtHfDN4YlpNVXnXbobegKZvHfXrhQ9xHaWzHNuSch8JuHFNCPMIE7vL5thj/cUswvxFZqPAXS6uoVh2C4f8MNl+o3G2SY4BIF7JyNzftyGOgciKoO7379T3gJC57dhSUg/bpMu5L4MFJLGISmBOMENIrA0n1iHbIXul1in+MSkP2TkdgHpX/7QYcsFxw31yT71rM8vqWqgMWg4s1e9rwIVoe+dxLIXnZ6S01fDdfCPUZ2CLuiqxk6mY2/elO88PbopU23WvnEb9+ofXTVYgoFqPgxhHwp1VpDzmkQe5MVj9/rXAB11UPhQR05qAd3in6Qxw4ioZwO8b0eVBScufDlxDhJlScfaJNwrl6Rpy18zok20+fRr1q2d/9z1q+Z3ICV/xYjb1xjURrmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6708.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db46c9b-4d79-4060-48b9-08dcfe919114
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 18:33:53.7263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dnnkM1obDnVp/hpZ7/SLgELZ8B2gUYbkv6SrlkPOGEi32Wct6wEemiBTAaUS/fAQ6EyX99DdOejW458TFcHHHIZVMHBAY8IzNodLFT3nC78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_12,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060143
X-Proofpoint-ORIG-GUID: T2mpwYck1LiJ5seRK3zkX797V-TxsJjn
X-Proofpoint-GUID: T2mpwYck1LiJ5seRK3zkX797V-TxsJjn

SGVsbG8sDQoNClRoZSBmb2xsb3dpbmcgY29tbWl0LCB3aGljaCBpcyBwYXJ0IG9mIDYuMTIgcmMs
IGRvZXMgbm90IHdvcmsgY29uc2lzdGVudGx5IG9uIHN5c3RlbXMgd2l0aCBBTUQgcHJvY2Vzc29y
cyB2cy4gSW50ZWw6DQoNCjcwMDQ0ZGYyNTBkMDogICAgIHg4Ni9wa2V5czogVXBkYXRlIFBLUlUg
dG8gZW5hYmxlIGFsbCBwa2V5cyBiZWZvcmUgWFNBVkUNCg0KVGhpcyB6ZXJvZXMgb3V0IHRoZSBw
a2V5cyBpbiBoYW5kbGVfc2lnbmFsKCkgYnkgY2FsbGluZyBzaWdfcHJlcGFyZV9wa3J1KCk6DQoN
Ci8qDQogKiBFbmFibGUgYWxsIHBrZXlzIHRlbXBvcmFyaWx5LCBzbyBhcyB0byBlbnN1cmUgdGhh
dCBib3RoIHRoZSBjdXJyZW50DQogKiBleGVjdXRpb24gc3RhY2sgYXMgd2VsbCBhcyB0aGUgYWx0
ZXJuYXRlIHNpZ25hbCBzdGFjayBhcmUgd3JpdGVhYmxlLg0KICogVGhlIGFwcGxpY2F0aW9uIGNh
biB1c2UgYW55IG9mIHRoZSBhdmFpbGFibGUgcGtleXMgdG8gcHJvdGVjdCB0aGUNCiAqIGFsdGVy
bmF0ZSBzaWduYWwgc3RhY2ssIGFuZCB3ZSBkb24ndCBrbm93IHdoaWNoIG9uZSBpdCBpcywgc28g
ZW5hYmxlDQogKiBhbGwuIFRoZSBQS1JVIHJlZ2lzdGVyIHdpbGwgYmUgcmVzZXQgdG8gaW5pdF9w
a3J1IGxhdGVyIGluIHRoZSBmbG93LA0KICogaW4gZnB1X19jbGVhcl91c2VyX3N0YXRlcygpLCBh
bmQgaXQgaXMgdGhlIGFwcGxpY2F0aW9uJ3MgcmVzcG9uc2liaWxpdHkNCiAqIHRvIGVuYWJsZSB0
aGUgYXBwcm9wcmlhdGUgcGtleSBhcyB0aGUgZmlyc3Qgc3RlcCBpbiB0aGUgc2lnbmFsIGhhbmRs
ZXINCiAqIHNvIHRoYXQgdGhlIGhhbmRsZXIgZG9lcyBub3Qgc2VnZmF1bHQuDQogKi8NCnN0YXRp
YyBpbmxpbmUgdTMyIHNpZ19wcmVwYXJlX3BrcnUodm9pZCkNCnsNCiAgICAgICAgdTMyIG9yaWdf
cGtydSA9IHJlYWRfcGtydSgpOw0KDQogICAgICAgIHdyaXRlX3BrcnUoMCk7DQogICAgICAgIHJl
dHVybiBvcmlnX3BrcnU7DQp9DQoNClRoZSB3cml0ZV9wa3J1KDApIGNhbGwgc2VlbXMgdG8gc2V0
IHhpbnVzZVs5XSB0byAwIG9uIHN5c3RlbXMgd2l0aCBBTUQgQ1BVcyAoYnV0IG5vdCBJbnRlbCks
IHdoaWNoIG1lYW5zIHRoZSB1c2VyLWRlZmluZWQgUEtSVSB2YWx1ZSBvdmVyd3JpdHRlbiBpbiB0
aGUgc2lnZnJhbWUgKGluIHVwZGF0ZV9wa3J1X2luX3NpZ2ZyYW1lKCkpIGlzIG5vdCByZXN0b3Jl
ZCBieSBYUlNUT1IgYW5kIHRoZSBQS1JVIHZhbHVlIHN0YXlzIGF0IDAgd2hlbiBpdCByZXR1cm5z
IGJhY2sgdG8gdXNlcnNwYWNlLiBXaGljaCBpcyB1bmV4cGVjdGVkLg0KDQpBTUQ6DQoNCiQgLi9o
YW5kbGVyLXBrcnUNCnN0YXJ0dXAgcGtydSA9IDB4NTU1NTU1NTQNCmNoYW5nZWQgaW4gbWFpbiB0
aHJlYWQgcGtydSA9IDB4ZmZmZmZmZjANCnJlY2VpdmVkIHNpZ25hbCAxMA0KaW4gc2lnbmFsIGhh
bmRsZXIgcGtydSA9IDB4NTU1NTU1NTQNCmFmdGVyIHVzcjEgc2lnbmFsIHBrcnUgPSAweDAwMDAw
MDAwDQoNCuKApg0KDQp4Y3IwIDIwNw0KeGNyMCBBTkQgeGludXNlIDIwMg0Kd3JpdGluZyBwa3J1
IDANCnhjcjAgMjA3DQp4Y3IwIEFORCB4aW51c2UgMg0KDQoNCkludGVsOg0KDQokIC4vaGFuZGxl
ci1wa3J1DQpzdGFydHVwIHBrcnUgPSAweDU1NTU1NTU0DQpjaGFuZ2VkIGluIG1haW4gdGhyZWFk
IHBrcnUgPSAweGZmZmZmZmYwDQpyZWNlaXZlZCBzaWduYWwgMTANCmluIHNpZ25hbCBoYW5kbGVy
IHBrcnUgPSAweDU1NTU1NTU0DQphZnRlciB1c3IxIHNpZ25hbCBwa3J1ID0gMHhmZmZmZmZmMA0K
DQrigKYNCg0KeGNyMCAyRTcNCnhjcjAgQU5EIHhpbnVzZSAyQTINCndyaXRpbmcgcGtydSAwDQp4
Y3IwIDJFNw0KeGNyMCBBTkQgeGludXNlIDJBMg0KDQpGcm9tIHRoZSBJbnRlbCBtYW51YWw6DQoN
CuKAnA0KMTMuNiBQUk9DRVNTT1IgVFJBQ0tJTkcgT0YgWFNBVkUtTUFOQUdFRCBTVEFURQ0KDQpU
aGUgZm9sbG93aW5nIG5vdGF0aW9uIGRlc2NyaWJlcyB0aGUgc3RhdGUgb2YgdGhlIGluaXQgYW5k
IG1vZGlmaWVkIG9wdGltaXphdGlvbnM6DQrigKIgWElOVVNFIGRlbm90ZXMgdGhlIHN0YXRlLWNv
bXBvbmVudCBiaXRtYXAgY29ycmVzcG9uZGluZyB0byB0aGUgaW5pdCBvcHRpbWl6YXRpb24uIElm
IFhJTlVTRVtpXSA9IDAsIHN0YXRlIGNvbXBvbmVudCBpIGlzIGtub3duIHRvIGJlIGluIGl0cyBp
bml0aWFsIGNvbmZpZ3VyYXRpb247IG90aGVyd2lzZSBYSU5VU0VbaV0gPSAxLiBJdCBpcyBwb3Nz
aWJsZSBmb3IgWElOVVNFW2ldIHRvIGJlIDEgZXZlbiB3aGVuIHN0YXRlIGNvbXBvbmVudCBpIGlz
IGluIGl0cyBpbml0aWFsIGNvbmZpZ3VyYXRpb24uIE9uIGEgcHJvY2Vzc29yIHRoYXQgZG9lcyBu
b3Qgc3VwcG9ydCB0aGUgaW5pdCBvcHRpbWl6YXRpb24sIFhJTlVTRVtpXSBpcyBhbHdheXMgMSBm
b3IgZXZlcnkgdmFsdWUgb2YgaS4NCi4uLg0KDQrigKIgUEtSVSBzdGF0ZS4gUEtSVSBzdGF0ZSBp
cyBpbiBpdHMgaW5pdGlhbCBjb25maWd1cmF0aW9uIGlmIHRoZSB2YWx1ZSBvZiB0aGUgUEtSVSBp
cyAwLg0KLi4uDQoNCjEzLjguMSBTdGFuZGFyZCBGb3JtIG9mIFhSU1RPUg0KDQpYUlNUT1IgdXBk
YXRlcyBzdGF0ZSBjb21wb25lbnQgaSBiYXNlZCBvbiB0aGUgdmFsdWUgb2YgYml0IGkgaW4gdGhl
IFhTVEFURV9CViBmaWVsZCBvZiB0aGUgWFNBVkUgaGVhZGVyOg0K4oCiIElmIFhTVEFURV9CVltp
XSA9IDAsIHRoZSBzdGF0ZSBjb21wb25lbnQgaXMgc2V0IHRvIGl0cyBpbml0aWFsIGNvbmZpZ3Vy
YXRpb24uIFNlY3Rpb24gMTMuNiBzcGVjaWZpZXMgdGhlIGluaXRpYWwgY29uZmlndXJhdGlvbiBv
ZiBlYWNoIHN0YXRlIGNvbXBvbmVudC4NClRoZSBpbml0aWFsIGNvbmZpZ3VyYXRpb24gb2Ygc3Rh
dGUgY29tcG9uZW50IDEgcGVydGFpbnMgb25seSB0byB0aGUgWE1NIHJlZ2lzdGVycyBhbmQgbm90
IHRvIE1YQ1NSLiBTZWUgYmVsb3cgZm9yIHRoZSB0cmVhdG1lbnQgb2YgTVhDU1INCuKAoiBJZiBY
U1RBVEVfQlZbaV0gPSAxLCB0aGUgc3RhdGUgY29tcG9uZW50IGlzIGxvYWRlZCB3aXRoIGRhdGEg
ZnJvbSB0aGUgWFNBVkUgYXJlYS4gU2VlIFNlY3Rpb24gMTMuNSBmb3Igc3BlY2lmaWNzIGZvciBl
YWNoIHN0YXRlIGNvbXBvbmVudCBhbmQgZm9yIGRldGFpbHMgcmVnYXJkaW5nIG1vZGUtc3BlY2lm
aWMgb3BlcmF0aW9uIGFuZCBvcGVyYXRpb24gZGV0ZXJtaW5lZCBieSBpbnN0cnVjdGlvbiBwcmVm
aXhlcy4gU2VlIFNlY3Rpb24gMTMuMTMgZm9yIGRldGFpbHMgcmVnYXJkaW5nIGZhdWx0cyBjYXVz
ZWQgYnkgbWVtb3J5IGFjY2Vzc2VzLg0K4oCcDQoNClRoZSBsaW5lIOKAnFBLUlUgc3RhdGUgaXMg
aW4gaXRzIGluaXRpYWwgY29uZmlndXJhdGlvbiBpZiB0aGUgdmFsdWUgb2YgdGhlIFBLUlUgaXMg
MOKAnSBzZWVtcyB0byBpbXBseSB0aGF0IHdoZW4gdGhlIFBLUlUgcmVnaXN0ZXIgaXMgc2V0IHRv
IDAsIHhpbnVzZVs5XSBpcyBhbHNvIGF1dG9tYXRpY2FsbHkgc2V0IHRvIDAgYW5kIHRoYXQgaXMg
ZXhwZWN0ZWQgYmVoYXZpb3IsIHdoaWNoIGNhdXNlcyBYUlNUT1IgdG8gbm90IGxvYWQgdGhlIHJl
Z2lzdGVyIHZhbHVlIGZyb20gWFNBVkUgYXJlYS4gQnV0IHdlIGRvIG5vdCB3YW50IHhpbnVzZVs5
XSB0byBiZSBzZXQgdG8gMCBoZXJlLCBhcyB3ZSB3YW50IHRoZSBQS1JVIHZhbHVlIHRvIGJlIGNv
cnJlY3RseSByZXN0b3JlZCBmcm9tIHRoZSBzaWdmcmFtZSAtIG90aGVyd2lzZSBpdCBiZWNvbWVz
IGEgc2VjdXJpdHkgaXNzdWUuDQoNCknigJltIG5vdCByZWFsbHkgc3VyZSBvZiB0aGUgY29ycmVj
dCB3YXkgdG8gcmVzZXQgeGludXNlWzldIHRvIDEgKGFmdGVyIHdycGtydSgwKSkgLSBidXQgc29t
ZXRoaW5nIGxpa2UgdGhpcyBzZWVtcyB0byB3b3JrICh0aGFua3MgdG8gUnVkaSBIb3JuIGZvciBi
b3RoIGZpbmRpbmcgdGhlIGlzc3VlIGFuZCBzdWdnZXN0aW5nIHRoaXMgcGF0Y2gpOg0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2ZwdS9zaWduYWwuYyBiL2FyY2gveDg2L2tlcm5lbC9m
cHUvc2lnbmFsLmMNCmluZGV4IDEwNjVhYjk5NTMwNS4uNzAxYTE2M2YwYWM1IDEwMDY0NA0KLS0t
IGEvYXJjaC94ODYva2VybmVsL2ZwdS9zaWduYWwuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL2Zw
dS9zaWduYWwuYw0KQEAgLTY4LDkgKzY4LDM1IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBjaGVja194
c3RhdGVfaW5fc2lnZnJhbWUoc3RydWN0IGZ4cmVnc19zdGF0ZSBfX3VzZXIgKmZ4YnVmLA0KICAq
Lw0KIHN0YXRpYyBpbmxpbmUgaW50IHVwZGF0ZV9wa3J1X2luX3NpZ2ZyYW1lKHN0cnVjdCB4cmVn
c19zdGF0ZSBfX3VzZXIgKmJ1ZiwgdTMyIHBrcnUpDQogew0KKyAgICAgICBpbnQgZXJyID0gMDsN
CisNCiAgICAgICAgaWYgKHVubGlrZWx5KCFjcHVfZmVhdHVyZV9lbmFibGVkKFg4Nl9GRUFUVVJF
X09TUEtFKSkpDQogICAgICAgICAgICAgICAgcmV0dXJuIDA7DQotICAgICAgIHJldHVybiBfX3B1
dF91c2VyKHBrcnUsICh1bnNpZ25lZCBpbnQgX191c2VyICopZ2V0X3hzYXZlX2FkZHJfdXNlcihi
dWYsIFhGRUFUVVJFX1BLUlUpKTsNCisNCisgICAgICAgaWYgKHBrcnUgIT0gMCkgew0KKyAgICAg
ICAgICAgICAgIGVyciA9IF9fcHV0X3VzZXIocGtydSwNCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICh1bnNpZ25lZCBpbnQgX191c2VyICopZ2V0X3hzYXZlX2FkZHJfdXNlcigNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVmLCBYRkVBVFVSRV9QS1JV
KSk7DQorICAgICAgICAgICAgICAgdTY0IHhmZWF0dXJlczsNCisgICAgICAgICAgICAgICB1NjQg
X191c2VyICp4ZmVhdHVyZXNwID0gJmJ1Zi0+aGVhZGVyLnhmZWF0dXJlczsNCisNCisgICAgICAg
ICAgICAgICBlcnIgfD0gX19nZXRfdXNlcih4ZmVhdHVyZXMsIHhmZWF0dXJlc3ApOw0KKw0KKyAg
ICAgICAgICAgICAgIC8qDQorICAgICAgICAgICAgICAgICogT24gc29tZSBzeXN0ZW1zLCB3aGVu
IFBLUlUgaXMgc2V0IHRvIDAsIHRoZSBjb3JyZXNwb25kaW5nDQorICAgICAgICAgICAgICAgICog
WElOVVNFIGJpdCBpcyBhbHNvIHplcm9lZCBvdXQsIHdoaWNoIGNhdXNlcyBYUlNUT1IgdG8gbm90
DQorICAgICAgICAgICAgICAgICogbG9hZCB0aGUgcmVnaXN0ZXIgdmFsdWUgZnJvbSBYU0FWRSBh
cmVhLiBXaGljaCBtZWFucyB0aGUNCisgICAgICAgICAgICAgICAgKiBQS1JVIHZhbHVlIHRoYXQg
d2FzIHVwZGF0ZWQgb24gdGhlIHNpZ2ZyYW1lIHdpbGwgYmUNCisgICAgICAgICAgICAgICAgKiBl
ZmZlY3RpdmVseSBkaXNjYXJkZWQuDQorICAgICAgICAgICAgICAgICoNCisgICAgICAgICAgICAg
ICAgKiBNYXJrIFBLUlUgYXMgaW4gdXNlIHNvIHRoYXQgaXQgaXMgcmVzdG9yZWQgY29ycmVjdGx5
Lg0KKyAgICAgICAgICAgICAgICAqLw0KKyAgICAgICAgICAgICAgIGlmICghZXJyICYgISh4ZmVh
dHVyZXMgJiBYRkVBVFVSRV9NQVNLX1BLUlUpKSB7DQorICAgICAgICAgICAgICAgICAgICAgICB4
ZmVhdHVyZXMgfD0gWEZFQVRVUkVfTUFTS19QS1JVOw0KKyAgICAgICAgICAgICAgICAgICAgICAg
ZXJyIHw9IF9fcHV0X3VzZXIoeGZlYXR1cmVzLCB4ZmVhdHVyZXNwKTsNCisgICAgICAgICAgICAg
ICB9DQorICAgICAgIH0NCiB9DQoNCknigJl2ZSB0ZXN0ZWQgYSB2ZXJzaW9uIG9mIHRoaXMgcGF0
Y2ggb24gYm90aCBBTUQgYW5kIEludGVsIHN5c3RlbXMgYW5kIGl0IHdvcmtzLg0KDQpQbGVhc2Ug
bGV0IG1lIGtub3cgaWYgdGhpcyBpcyBhY2NlcHRhYmxlLCBvciBpZiB0aGVyZeKAmXMgYSBiZXR0
ZXIgd2F5IHRvIGRvIHRoaXMuDQoNClRoYW5rcywNCkFydW5hDQoNCg0KDQoNCg0KDQoNCg0KDQo=

