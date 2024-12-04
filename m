Return-Path: <linux-kernel+bounces-432105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9589E45A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B577B326A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA51F03CF;
	Wed,  4 Dec 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2msTPR6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F7g/CXZp"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76940239197
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733342327; cv=fail; b=HwYVi3mdRtL4jESJkAoUV/+mIJHUiQ/50si52lOJtQVvOPtpp3iUvD7/9XmxFmUZtyIHWyAXHVYFViMa477jOQUjrt0izYoyJ5GaH8hZ8dkAUFr81CuiNmkA5NMqTxCRqz06X6HBc9R82TU1JK6SNBLcpGvaUjdaRj5JBP6Kmkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733342327; c=relaxed/simple;
	bh=DHzhvG6ERsWKOcfrGgn/NEXaw2UDazJjodOH/0o6EVU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=JyQwF/qygGXHe3eEd6I7vdBZd3NvqAVSPxOAMTOnKfQiITXG+053ClL/tF3uLjHmGncMOlHXPkHmvaoQ++5KDVySJDAqoHYD3lCjauLVV1GaDlRqqGaMV7FlxQHSI0NjltAm3rO+LUlyQB4BJE/sXeCdCd86ZJBMg9uzo2XgT+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W2msTPR6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F7g/CXZp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4Iu8rT012280;
	Wed, 4 Dec 2024 19:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DHzhvG6ERsWKOcfrGgn/NEXaw2UDazJjodOH/0o6EVU=; b=
	W2msTPR6fhqVkzfyxIr2s4+NGjET27BCs65Q/gBjMemfM7ubpgKTm97F52AQ2IJJ
	rgIV0Ob+Bqg8XjeAXnDLAyfZPL84C1sBj56o+aW/qdYTDX4s40FTMl2eqSEMcAWn
	68J3+Fy2ASpnKzw0Wpz7aof61sPqd0dHZv+nbOO+Sr0Gr8Be1h1eElfLPCEcqaft
	IF+uHFAlreDx1SykijJqo5b6Fz5fTiCmJhDct4HQxCPWTc5JoyXmRT7jiQQBoZDP
	VpvuaddBQWlg/godmk/CppECSP6NJLaa4UCL+KRWSf70vqbwAo3sIqFoU+q/Keed
	EMyTE1zB3CjsLo97BcS9hg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437trbse0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 19:58:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4JkHnX020445;
	Wed, 4 Dec 2024 19:58:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s59y0v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Dec 2024 19:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjIJZPJQ3E6d33U8YEMzZW2e+zl+am58ON2DVMmMKRc7uloFsx46Yv1Zi8PXxNwIj4lOZUFh8878i1wuv/uFElH+F4R2xv7zfi/FHjusc7mIO/R7gWUThJVVnve5rzJoedqC5xlOO9tTDQlJc8nI5N0GKupfBPEvbogKxz3ChFT97KHp/xi1zjWatagoh47QPJq3Mh+RiPYEXvRHW0eogMmTz5ok160j778XmPpA+DrNoXkKz6RUq7/vGZhTSerW/4JMuASBQnDLkCHOhG1jolfOdbmwC73eTCiORcYgOAXnlZ983c3nr2wGPrCOK+lDUHQJJPZJ64fqIeju6Wlb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHzhvG6ERsWKOcfrGgn/NEXaw2UDazJjodOH/0o6EVU=;
 b=BZMvIT69mJe7V9u3sDNCEk5alRJLKmAgEMprPXLMHYhjCvEodfZd6HDm88GdiKsqf/UIQmS6YLq6uqkcD7onkxGQct90o19Ly6/HevP5ykOVyp8YakDVUbVk275sCjJWd3SD7Fbq/23e3/sSreOGE5dUzMpoWFnFdOUg6EXo+7GWrPlSDgC3P3n8/pmElOc98uO1AEQ4agbHHdXSB5WmwpyBx7ldoSdkiDXxkx7mBdPGl778HCs2+E+UW3vzh5FW0n3bJZp2nmfqItwvpuZgsXk9uT4+knLjPUbcivovkqbWy9hIu1ITpRrkygUwJn1KzjqgcYRkcTlF18y1Bm2vvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHzhvG6ERsWKOcfrGgn/NEXaw2UDazJjodOH/0o6EVU=;
 b=F7g/CXZp3ayBRAmGjv+7Ga0KJrjyACQy8SbmELwRrTi+u2gmALfwH/k1E2dW2lj/fGhw7Dhvi+JtIJrzK2GTd5X888+7GVO7hXb8UecDTCz2E2VDe+29b8rC2SrFF0XiZaIGLz7j8yFoqOaWmArJc3iA6ryGmxux1QrNR/JdsKA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB5925.namprd10.prod.outlook.com (2603:10b6:8:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 19:57:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 19:57:56 +0000
References: <20241202202058.3249628-1-fvdl@google.com>
 <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <87mshccnxr.fsf@oracle.com>
 <CAPTztWbceW0dbCPVMw_maer8o_o851Jf-omOBCQkwwA9qQP2qg@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Frank van der Linden <fvdl@google.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, Mateusz Guzik
 <mjguzik@gmail.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Muchun
 Song <muchun.song@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>, Oscar
 Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>, Peter
 Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
In-reply-to: <CAPTztWbceW0dbCPVMw_maer8o_o851Jf-omOBCQkwwA9qQP2qg@mail.gmail.com>
Date: Wed, 04 Dec 2024 11:57:55 -0800
Message-ID: <87cyi7cjb0.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:303:16d::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d346303-e940-4220-8124-08dd149df26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anVYTVZSMXI2NEdRV1NHbm92Ymc1ZXl1VXoyR0dxb1p0M2pFc1lBZ3lmM3Fv?=
 =?utf-8?B?eVpWcjkxQ3daQXVoL1NJeHYrdW9vQUJ2dktqV2NnTWRHTG1ZbzJoSWZubXNV?=
 =?utf-8?B?QUlZNlVpdlUwc3llV1I0cVpEbU42SVRHMVQ0eEwyb3lqa0JrTFFQOW1kdTkw?=
 =?utf-8?B?bVV4ejJyOFhWelBpOTlPOWc4MzVRQmdsTmxUVmR4aFN1ZDRLdytwWllndkZJ?=
 =?utf-8?B?ci8zUzVUVTZ4RUQwVWJSWGJUWTQ2a2x4WGVYc1FkeVdqd29ORVpPZkpLMEh3?=
 =?utf-8?B?aHpkVkJDZW9SSk9tUVZaNnlENnFNd21oem9uenQ3czl1bDVkT3ZqS1U1alZH?=
 =?utf-8?B?SWd2UVphR0xuYzRpczlucTE3aGR0TnpwSEdoTlFaQ3FBREhQMUNkTStzNnk2?=
 =?utf-8?B?ZEg4TXFZdkNFV1ZYSzNUaDVFK0VQYkNyaEJITnRBQk9aRmNqSERVMEFvdU1V?=
 =?utf-8?B?dTZqbjNydkdrTHB3LzA0K29ERGJHSm52eWFmOG5PVWRSYzZUalJuRjV2RHJE?=
 =?utf-8?B?SzZWUjVmaDNDVlVzN00vSkkyOEZmRkVkSzVnYU5zMmhiZDNIM2t0ZDZ3MGVF?=
 =?utf-8?B?SUp6c3BSL1o5NG1kS1V2NTVHZlJrRUswUGhTdEhPUEhSZE8zazE2OUJoVFQ3?=
 =?utf-8?B?c3VYUFhXaTNnUGwxdmhiSlM2aHZFRDZHSHREc1JpemNkYnBhTXBGMjg2dFFi?=
 =?utf-8?B?dlRZczJEN3dnMTE1elhLbm45elN3eUVxQmFrTXByUWk3TXNUeEtJQXVIS1Rk?=
 =?utf-8?B?RFhrTi91ZzNMa0ZZelBRZFNPVkdTeHAyT0xkeE9oRW9YU3JiSjhIclVXTXFi?=
 =?utf-8?B?UWpUQUxMWnN2Nmw1NHZ2YWdlaS8rL0VtT3g3QmR4YWFuQzM5bzlTN3VURWkw?=
 =?utf-8?B?UWJBU2JvOHNsUHZhdk05K1RyL3lESVZ2QWFQY2hBUjBLWHpmN01Tck5YWitY?=
 =?utf-8?B?OThHdklvWEtxYnU2WFF3YzJSc1B1ZGdOYVZnTFZ6ZTBwUmdQUWQvSDhjTXRT?=
 =?utf-8?B?R1I0OTY3aU8yV3I1VXh2MmJROWFDcEdCUVNtR21qczNBdDBGRXRvd2xrQStG?=
 =?utf-8?B?U3oweGs2cHN1QUFZWEJOT2xYcGNaeUU1ZTBVLzk5WUpPM1NRaUNHRHd5WDFJ?=
 =?utf-8?B?TzZTVisvVVVhZlRadC9hMlpPRkcwUnVXYjV5Y2xLdjZzMjV3N3lLU0hzb1l4?=
 =?utf-8?B?elRmVC9pRmdPTmpCeS9JMW9FcHVNQkdUYkRQczVxM1dUbS9VS2JHK3dtWUxB?=
 =?utf-8?B?ajBFUW1DbWlSRUtTMFVaRW1OTUlkT3VFWEQ5UmI0RUEyQ201czZ1bUt4UE55?=
 =?utf-8?B?b000UFJFK3lqR3piOHU1MzJqeU1SUWNZY29kRGthNytSTDFvZ2ZqQmVNQjBJ?=
 =?utf-8?B?Ly90TmZ2ZE96eWMreFJxVlk2bndlV0UzSytwSHFnWkE0SWJtalFJTGRNejhM?=
 =?utf-8?B?QnVaSFVlUTRXYTdoaHpmSUkyQkV2RUJkOWJkbVd0U3FPQnFVeTBORXp6RnZ6?=
 =?utf-8?B?cWtueFVpVGxrc3VTc3dFOUNueDZONnNxK3JEK3BwcnJPK055VG0vSlBwUUpB?=
 =?utf-8?B?RDI3a0FmSzhOVDFsMGREN1p2NEZ1RUdEOEV2NDd2SWt3YmkrRFZsV0Zub21L?=
 =?utf-8?B?TVFxOGJ1Nmt6djF2b2NJYXdjalAxbW1ab3ByUTU4c1dxUGViOGNydG5kdVdK?=
 =?utf-8?B?SVUvT1dPWmhrVXJXakpVVHZFc2h4Y2tOS0pBbytQZU1DYW95dnZZbjg5WHNu?=
 =?utf-8?B?WFRQRE9qaWsvMU1EM1dRbXpVY3FOS1NPNTV3ZW9DUGZCWElQTnZDYzV4OEI3?=
 =?utf-8?Q?H10jNrBhfaDrSvG9wI2TXl4N+zv6w4Q1LNwlY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b25mNXJQbWJUelZaTG1yZlJCdWxvK1ZhRkxONFl3ZlgwNjJ3ZEVTKzVSSzJQ?=
 =?utf-8?B?eEk0T1FpRk05RGJja2d4QTc0NFYzdGFUZVNXb0ZJMVBsY3JSUTY1V05IODF2?=
 =?utf-8?B?MENEanhNbGM1bTREV1FBTkYwTDc3SUlpRXBCeEZFeU4zY1BWZjYxRWIxSGlW?=
 =?utf-8?B?K2l3aEhabE4vVGxVZGI5Y3dZQ1hLVHlnNnJXZlpIZnpiSytSNFVENzZGMHFy?=
 =?utf-8?B?ZjN5ZFo1WEdoWlRIRDQxaWhXcGU2UU5vVWNNc1R6eVlWZkJwVzJCaEFrTStB?=
 =?utf-8?B?NERiNlFqQi91YkhhVlpla1M4dkhpY1RybXhUWjhZWVRQaFhpaTc1b3MvVE45?=
 =?utf-8?B?Uzg1VmJuNDNoQWcrV0VEQ2VEZ1pjWTZsRG5CSjkwL24rS2FoVTRuUU9JbFlN?=
 =?utf-8?B?Yk9TcGFCVnBvVDlwU0ErZ0gvTzEvcG1jaG1GRjNWVkZscHdnQVJTLzFsMWtV?=
 =?utf-8?B?Sy9RU0dOZk5sMEFXaDBobTVmTUtQRk1rNU5YMVVZYTd0VEhGU3Y5VnZZYnpr?=
 =?utf-8?B?clhRYkp0Q21VdjFlZ3hGeWEvZVdZVTljczRyeFlVVUhWaTFsOTFmQ3pnRFgx?=
 =?utf-8?B?eG4ydEVudUxCeU1qM2dmMzFnaGorTkVtN1EzalRyazVOcHdiSjA1dDhLdzVN?=
 =?utf-8?B?WlZOYmtwSzFVQzJNTmUzSy9VUDc2ZXlaUDBjcldLcERVbnJqSm1yV3JqM0d0?=
 =?utf-8?B?VkZTaDA2c2V5QnhDakxBYWdkZ3o4QzVCcnpRM3RaaExVTEhmMjFNNW5jcGtB?=
 =?utf-8?B?MTh2cUNRYjRZblFuVGw1THlxL09lWDNiWkRrWWFrVVZ5cjVkYStPOVBqUUpl?=
 =?utf-8?B?ejdzdlhjdUsvSW1uaFBUV0dydVFNN3l2M3orZHpQeEtGTUh1a1cxZU5rUlR3?=
 =?utf-8?B?Y0pWWmRldG1NSFdaSXZzZGE0S2lXMFd5TTV1VHovd1RiMWl3N2g2K3ZMMlBG?=
 =?utf-8?B?ek9pY3JTQWY5YncxcVV4YkFLbksyYjIrR3E3aXpkM1R2azNKNVAxbjYwQm95?=
 =?utf-8?B?YTZNbzZZY0U4SlppZjlzOC9USVhjRGdQUzh0ME5PUmVYVWtZODJHaXRlQnhx?=
 =?utf-8?B?VlRxRmdmKzVVN2JHQ2cybkhDeEFabCtGOGdHKzdFdzRlSnJRN2xxb0NIY1o3?=
 =?utf-8?B?QytKR041YURyWlc2dFpXaFpwYytnM3FHSHpJTkdZUXhFb0JlUkFKeHZraGRo?=
 =?utf-8?B?YzdEd0c0dExMZUNINVBSRm44Ujc5TkV4L2ZKSzJyZG4xNUM0ZHlSVFdlOUhm?=
 =?utf-8?B?c0Y0REYweUp4Q3I5R3JxaGFidHc5aG4zcTZ3dE9hR0l0ckI1VjJtSzlXcEV0?=
 =?utf-8?B?OExJSVNaU1RxQXU0Y3BLcnk0OGNXZ24rOHlYMTBLWnhGcHA4RkhjajJqU01n?=
 =?utf-8?B?MTZHdGhUOVdhWGtIeVRvUEVnYjFqQzArQm5wa0lyMkhQM0RiUlp1NXk0NjFq?=
 =?utf-8?B?YVNkT0piSUkwb3lvQWN3S2QrTnJKVnlJSGVHSnZIcWFjN1IrYXdGRFJxV1VY?=
 =?utf-8?B?WWhPcUhNS2FlU0RBVEVNYW40TnQwUXpDdHdEM1BUejF2TG9UQTcyNG1XbkZa?=
 =?utf-8?B?Nm5Pb05BYzFNTWJiNzlDUDUwR3VUMUY5SnVuOTQ2MjI5NEdCeHVRNk1UY0xh?=
 =?utf-8?B?bGhVWHF4WHFJeWxoa0ZRTFFVci8wRzNRODZLS0h2c3Q3dFM5SlY0SzVuVDVl?=
 =?utf-8?B?SHJ4bmR4a2NNY1JtUSs5dTdRMmhuWFREb1lWZ3JJOEl5eElSeVlpb1JQdjV6?=
 =?utf-8?B?T2tzOW1iQTV3K2kwNjJ4cC94OVZBNCtqc1dhb3pOL0hxc2M4c0h0YWFWY2tt?=
 =?utf-8?B?VVk1b215MEo5UGJBZDRGUEl3RlkvV09lMU9MTlZYdHhVV1l1SnJrTDVzVU1T?=
 =?utf-8?B?KzdBSVgxSTBWUUVmc3MvYTNiU2dPZmFwQ1p4RmJ0RjhpdVVDUHZYc0VWdnpr?=
 =?utf-8?B?d2k0bzJuOE0rcE9ITGV0SmhtTE1sQUpDRVlMQUVqbzRwMkV3U3BIMnFrMnNt?=
 =?utf-8?B?Rnd3cWlvZEJPUS9FN3JndVErSFgyY3pEMEQraGxaTUJHeTlZVXZwSllOOUtR?=
 =?utf-8?B?TTlXUHpreThXQnZXWVVLYjNTYlJEQnBvRkEvSHQ3WkMyMTBZbkFwd3Z5SGo5?=
 =?utf-8?B?Q3VVOEhqekRWa2VLT004MXFHYXhtbW9YWlQ1UnMzWEl0ejFIZG5iMk5HYTVs?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cDzgy6BvtoeY8QVQ3c03SNBSDDspHNanH1y7puTgaaBeE2nHkDsjMQuQF9MuYZkYEy43LIlhjf66DZsRBcZCUPpmKRMMekTqXEj0mSQFijnX3+iINKlVTxxF1cHMEKoBb4nM3OFD2mkfWlVPLPwoP8jBtpxqGfZGf+qhVJSOWhFiGTSYqf4ojXnt2mOeoBzna7dxdmccyuUkfSNdtFPasNyx/4ebNTBJLHNTEitOW9sc0A5AfPK+DFEtvZbLTJPu2zOus0Rlvodi61DxoDqu5KhqkH8ZzSGkLVk6LA6kPTYrdSaf741eivRwUMIbvhOxMMh2QZVKeBa/nZUwYInRw5DzqoSRpUWPVKX3KxqVNKxqT661LR20+87J01oqGJeJTlD7dY5SqliW3DUqecOdqI0qluY+4s4xVYyo0BM6Jrrqj+zWgl9se5udxAwsVagm//7GeMpIU38MSbBweYCB/wbMu54IM5c7uyecnhdytk4CrztVN4CvomRUh5+8YUoYviTGVkUYP6psDTIWcq034f2Km7iZXMvGEoM2lkSei9S+E0fSNzbLQDkmbgl9if1k3wCcKgBXO6nAJUyfjesTYqSy6MfbkJw/dCqflhuNeAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d346303-e940-4220-8124-08dd149df26e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 19:57:56.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sX7S8I3OEkwqeR1WBQawTpD4GiJ2VPIB5G+9fKrlJ1ZTrmrIeP7ThEjj3jgCKZPI0B6wj2qBCSucBu/zdtpBwwgqiK54u5yheqS9WYQzcZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5925
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_16,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412040153
X-Proofpoint-GUID: oMIKbIrBPofBiGOVU9ZmeDRxAzwKwWYL
X-Proofpoint-ORIG-GUID: oMIKbIrBPofBiGOVU9ZmeDRxAzwKwWYL


Frank van der Linden <fvdl@google.com> writes:

> On Tue, Dec 3, 2024 at 4:05=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle.=
com> wrote:
>>
>>
>> Mateusz Guzik <mjguzik@gmail.com> writes:
>>
>> > On Mon, Dec 02, 2024 at 08:20:58PM +0000, Frank van der Linden wrote:
>> >> Fresh hugetlb pages are zeroed out when they are faulted in,
>> >> just like with all other page types. This can take up a good
>> >> amount of time for larger page sizes (e.g. around 40
>> >> milliseconds for a 1G page on a recent AMD-based system).
>> >>
>> >> This normally isn't a problem, since hugetlb pages are typically
>> >> mapped by the application for a long time, and the initial
>> >> delay when touching them isn't much of an issue.
>> >>
>> >> However, there are some use cases where a large number of hugetlb
>> >> pages are touched when an application (such as a VM backed by these
>> >> pages) starts. For 256 1G pages and 40ms per page, this would take
>> >> 10 seconds, a noticeable delay.
>> >
>> > The current huge page zeroing code is not that great to begin with.
>>
>> Yeah definitely suboptimal. The current huge page zeroing code is
>> both slow and it trashes the cache while zeroing.
>>
>> > There was a patchset posted some time ago to remedy at least some of i=
t:
>> > https://lore.kernel.org/all/20230830184958.2333078-1-ankur.a.arora@ora=
cle.com/
>> >
>> > but it apparently fell through the cracks.
>>
>> As Joao mentioned that got side tracked due to the preempt-lazy stuff.
>> Now that lazy is in, I plan to follow up on the zeroing work.
>>
>> > Any games with "background zeroing" are notoriously crappy and I would
>> > argue one should exhaust other avenues before going there -- at the en=
d
>> > of the day the cost of zeroing will have to get paid.
>>
>> Yeah and the background zeroing has dual cost: the cost in CPU time plus
>> the indirect cost to other processes due to the trashing of L3 etc.
>
> I'm not sure what you mean here - any caching side effects of zeroing
> happen regardless of who does it, right?

Sure.

> It doesn't matter if it's a
> kthread or the calling thread.

As other people point out it's more a matter of accruing it to the
right context. The noise will always spill over but userspace can use
cpu cgroups etc to to limit how far these effects are seen.

Additionally, this kthread will be doing bulk zeroing while a user
thread would zero as needed. Though I guess for the VM prefaulting
case it's likely similar.

> If you're concerned about the caching side effects in general, using
> non-temporal instructions helps (e.g. movnti on x86). See the link I
> mentioned for a patch that was sent years ago (
> https://lore.kernel.org/all/20180725023728.44630-1-cannonmatthews@google.=
com/
> ). Using movnti on x86 definitely helps performance (up to 50% in my
> experiments). Which is great, but it still leaves considerable delay
> for the use case I mentioned.

In my testing at least on AMD you can get a lot more than 50%
improvement.

See for instance the CLZERO (or the REP STOS) numbers here: https://lore.ke=
rnel.org/lkml/20220606202109.1306034-1-ankur.a.arora@oracle.com/

--
ankur

