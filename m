Return-Path: <linux-kernel+bounces-551189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3217AA56927
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D791F3B0DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B53A21A436;
	Fri,  7 Mar 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O9P7q61A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X6oCDFcx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D1E21A431
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354939; cv=fail; b=DRfOkogYcaeDeGmOmCT4c9PzUxxMSGndl5a1a4x+XskR6aSYlZcSQLcAlq9XJyzuqsKKiqbgOUWPbuwULEKIDralosNun0zVQMN7MM0Jih7Q4C3icb1iuErHM74ldMdG6+4nUkrgEHUxHuLgyQ98HDjfHL8EE31EYrCGY4Uw4tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354939; c=relaxed/simple;
	bh=9qEQGl7HczY5AviwCSUng19G9XUUT6y3y30PhbmV7ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tWaYSjb8hrNyNcuf0OhvHW4w79zKUbYuWjd2dfDK+JOySRfjtqoR4f8mFACiiITutZ74lWFj58CJfU+PVttbTBPyaaTJ0lkrvLMn896760m9yR8crgpiqh2J4Pks3rUK8IuEXG6qLhHctvd1spJY/ZbpJCACsX47rqFrHQP2nSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O9P7q61A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X6oCDFcx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5273FD75019526;
	Fri, 7 Mar 2025 13:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=JL/scoWvniNv9yuKTWlW5UVO0WBH+gao29iUI/ur6Ec=; b=
	O9P7q61AC/T00t2rD/rjKtwkxVuo3gstCu3zGFyAuZpSl4wgS7Qthoilcc0cjpkf
	cFj/YBo6aTgmx2aOGMe7bz9Fyh3RshSgF2ZL77WuScnEKzyO9YJlRBelguyQCRb7
	FFtwPlXsUG+RrVCafFJ18CDZTq8rvr0q8xdsPXC1sixQOZl66CWQHZivhUMU6M26
	5to2gZQSI4shQWcFI+tjgTSdRMK25pSM175NoZEFcKBbFyv6MG2hM1cIgffRkdKq
	qi+5M04+QAFRAcGxXU538iLDsiTNRqbpbJahnkgnYEHZnsmFx6NOtUxUs+KkgTJb
	NxZ9DtmzqlXfUHLZifCARw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4541r4c513-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 13:42:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527D3YZq015772;
	Fri, 7 Mar 2025 13:42:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpemc1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 13:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNTMg4gpIuuFXBBOjapBvYodWJadw8UWCMWgvqs8f7PCGJUBxbBOEBkK7cqFwFMxLwCrfCXpBg2+wSXxCjTaBtpCDEh7A/OcSW+5QxcsePVutaYP7qqVQpJ+Wmr528Tm8lxCZW4TCpNNdCDfblEJzPAmJWuryDgt50jABdX58qzeQDS4o7l1TzNhCmAL0r6EU2kUykfuT9JIEzVdNxHhoMEqswkfNYkkV0rXA7hCjf+a3CW+DLBK3Ors1262icJxMlgdRWTGsexgfqb/4RpY9Eni6YtF62wJL6Wu+6QlYvHifQNN3YhbfKze3eQadciPjxafc87HM6tSwocgV4jVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JL/scoWvniNv9yuKTWlW5UVO0WBH+gao29iUI/ur6Ec=;
 b=RzXIaRpC8so9QSzoCdDytCq62Jqkv+RQVaICLnPd8gu5JQuUjhiDGj51dfeSh5k42B0PnD2Qg5tp6Elh8qnj9vM6VLaOyxYV3HWxdp+JKon5axnecvcd6RovjVKG/AwgD/CEaUS8e0waS+KhlIMn4VxlZejSdRVOwy2/y7kW3asxLwOb3YsDEsUhiTZwrxOUeoKJ12ult9OY3M9CjdvBqLmxchUihD+hL6IeDHnhOX4gK07F1rA4s4/MlpTEWJAVL4xOI8dOO6JzRixqLr2a/MNhpK7kuPOvWIsBM/LveYb6SIEJBMFesVZXSLVyy8H5MdRumPzqUX8i1m2s1Y8VTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JL/scoWvniNv9yuKTWlW5UVO0WBH+gao29iUI/ur6Ec=;
 b=X6oCDFcxUherVxhiMH03O2Lec8SHMMt2PxhVqiFS9CP19IPBGbzA449OMJa/tXIy+G1l6PLbkc6uu+bHopbb8UMSCoHGhN3YfQ7uyBw6bcRVIqugiQ4yJ3QC0NtQHEh6QK6ddXRI7BwrOl3+e1hMLofgVzrHZkD+Psy9lbM6UVY=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SJ0PR10MB5582.namprd10.prod.outlook.com (2603:10b6:a03:3db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Fri, 7 Mar
 2025 13:42:00 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 13:42:00 +0000
Date: Fri, 7 Mar 2025 13:41:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, Liam.Howlett@oracle.com,
        vbabka@suse.cz, jannh@google.com, oliver.sang@intel.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vma: skip anonymous vma when inserting vma to file
 rmap tree
Message-ID: <fdd28cd2-d563-4bdc-8dab-033ed80ae287@lucifer.local>
References: <20250306214948.2939043-1-yang@os.amperecomputing.com>
 <6f3cece7-4dc6-471c-978c-efcf4bbe64ce@lucifer.local>
 <CAKbZUD3Gk8Qb4zznpCszXHzfAO82=rkTOb0_z6yVU0CXWAMoSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbZUD3Gk8Qb4zznpCszXHzfAO82=rkTOb0_z6yVU0CXWAMoSA@mail.gmail.com>
X-ClientProxiedBy: LO2P123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::15) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SJ0PR10MB5582:EE_
X-MS-Office365-Filtering-Correlation-Id: d75a1fa8-e36d-4590-08a3-08dd5d7dd630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkxISmRNdzF3WmZBK212OW0zYnJCeEZES0d5TGgvWmlhcDR1WUxzU09LYWov?=
 =?utf-8?B?S1ZMaS9Bei9WTDA5WFhVa285STF2ZGg4VHNCZndEcVZXaG4zejJvdTcwcXBi?=
 =?utf-8?B?Sm1pbUZsUTFFcWZaK3JTcVljTUZybE56N3M1ZGFvZWVnWmJRZjFmRXl6Rjk2?=
 =?utf-8?B?QXBVWUczWWxLc3BjYVhhdDFjTjh5bWI0emxtL1h6UWlSRS9LZFp0N1o5UndR?=
 =?utf-8?B?RkJaSExwUnhNQytlMUtpcGhnb0s4aWljNXpidy9QWHNsNVVXZkNKWjFVdjhq?=
 =?utf-8?B?Y0w1RDlKaFdCYzBHRzdpVG5vSmpmaXZzYWkzaDhzTWpJNDVGeUJhTUlwUmN2?=
 =?utf-8?B?UjhqZVFTUDY5YzdJTDBHWmJ2czgvVWU3Z09UWWZPWE1kYWpkLzFmWVJjQ1hq?=
 =?utf-8?B?eE1lQW45eG9hNzZGdDRzMHRYMFVFSENYRDJrUXlNR2IyZkNIdEVOR0VuT1Nt?=
 =?utf-8?B?aXlZQTFUTzJJSDlQR29ycjJhUWVheWNzQ2dPcHB4bWVhRUxLZmN1c3pLekY5?=
 =?utf-8?B?d2NIcWQ3d2x6ZG9YdFc1K0tpdUN6UkZyUUF3R1B3c29US0lzeDBZeEFqU1oz?=
 =?utf-8?B?TTR1SGdZcXMzS2tLVU50V3Z5NSsrT0NUc29RUFh0QThxT1FyU01BclU1Rk1v?=
 =?utf-8?B?em4zdHIyaFEzNmNYdnFYSGVITWZ2ZW03QmRydVZEclhaK3RwWStTbFE2dVhl?=
 =?utf-8?B?b3hZY2xiK1J1ejlNakhOaXNQYk0vUTBYd1UwMW1GS0V4VC92RjhlaW5TMldu?=
 =?utf-8?B?a2lSRk5mRzBEVWEzWkc2UDdNYk1TM0Z4UENHVndmMUFkdjd2Q1dGY2ZmcGZL?=
 =?utf-8?B?SkZnVm5HUFp6bUtpQW4zdlBXcUJyL3Y4Y0tPRVdDVWFjNjdkOUdSck5MSmFl?=
 =?utf-8?B?ellqYjFUY2RFOGNSL1J1T3l0WHRGVmEvblFVazJwaldIWjhobU9sN3FVMFZX?=
 =?utf-8?B?ZTBHdXZCS00wYVBlbGlPYmFCQzhZeTAzUURvNUlTU3BuTWU3R3A2Zk93U1Vq?=
 =?utf-8?B?MzI5cjMxckdnZWtDdlJ1SGZJTTVxdm1IekMvdzFSNWhxQUJqVlVSbUwzZVZS?=
 =?utf-8?B?bmVKZ0xzUjZqQmxxUEhjR3lpK3hWMzErMytibmpIQWVhTENPQnBCcHZRakV0?=
 =?utf-8?B?bk5KaFZtN3BBRXJKcHFjbEY3bzBlRkZZVlpkcHpFdGJ6bFRJWUI0aEtJY1RZ?=
 =?utf-8?B?Q3hDNkc5L3R0SkV0N2dsMk92c2RDWUdZcWhSSXk3cjZaQ0Zld0hvOEpWdU5i?=
 =?utf-8?B?MlIzWHpac0ErbE9HWmVhVGZ5QmZwZE9LRmF5d3YzSGNVZFpkdTNjRHhHNU5J?=
 =?utf-8?B?UW80MExFRkR1RGJkYlc5QVp0R1kvdmdvUUhXZXUzUG1pdWk0VWYzMU1HVE9Z?=
 =?utf-8?B?RlMydk9oMVg1bjFmaGhYVjZvaFl2SlI2eGJ0bUV3ZWljekhDZCtGSGdpZlJl?=
 =?utf-8?B?YUdRZjRNRllNeGloMDQ3WVR0dmFOdlZzWGlCMFlsSUovR1prYkJScmh2YVFs?=
 =?utf-8?B?c3BJK3JPYjlJbzZrTXAvRjF2VUFuZ2ZZSTA2bzcwdEtEMXVtVFFDMjVvQ2F3?=
 =?utf-8?B?cDdIaUhVUXBRRVRFc2kyRGNvSDM2ckEzNUFHSjlLYzFnaktVaXFlT1o3TThD?=
 =?utf-8?B?U3VkUDZPR3lqc2RJVEZJSWhXZ3NvZXR3Q0Q4UVB5bUR4dWd5elh2dGJZaStU?=
 =?utf-8?B?VWY3TmFpL081K1RPSm5pMjJ6WFV3cFJUSlpRb0k1R0xZVWMwQkhnQWNNdHZ2?=
 =?utf-8?B?dHpQZ1lXU3lBYmhhVHFOcldlS1RlZVNEOWpiWHBpeXMya3lkVXgvRWMzTTdL?=
 =?utf-8?B?SVZGWGFCVEtFa0RyeWpHLzB5eFpmV05ZTGoyNnoyT0laNG9pa0hIaStkbWQ0?=
 =?utf-8?Q?IA0YmzadO3jCV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2ZmS1V6NWthK3MycHYvdHVMTndvSkl6bEVHeWh1UmFpNWZwTjgwNFZ5RllI?=
 =?utf-8?B?enVONXRFY0swVm0zK2IzaUdCdlcxMXJuNm9GQVltUVN5WHo0eDNROGFwQUpW?=
 =?utf-8?B?RHd2VUFLNlpaZEtyQ1JVTTJLTm83azdxVUVTbEg2S0Z1eVVmM0pSMUppY0tC?=
 =?utf-8?B?Lzgwd0t0RkR1OEYyTG9oV1Npa2VUSlRrcmJ6cGRyY1BTeGhVaHRlbG91aFFh?=
 =?utf-8?B?c1hIMWZmYXVqM09FZ2RPNE5ORkxDV3VsRzBDbWpRS2s5SVkxRkMzakVyajJ6?=
 =?utf-8?B?WW1KSHZzSTM3RXNCNDU2dkRrVXk4Q0RFMjdpOGFLR2ZrNDlxZW5HcVhLaUVN?=
 =?utf-8?B?TGZYVmtoQ2dRTDE1N2M5cmxZRzFGWkxXdDA2WVV5WkZrRUxFV3dRMVBsZmMx?=
 =?utf-8?B?ZWZ6MUVPY2FXb2ZFWDkwVTBuTldBaXhwNGE3UlFhRjVyVTFFbG5pc1lJMTNQ?=
 =?utf-8?B?YUlmZGpveExCOFpmQVdMaFJxRGYxQkZtWlg4WHh5ZDcvMVNoc3RvcGMxZllv?=
 =?utf-8?B?NER5em1vVEtMQUJZWG9qaGtiM1hzd0l3dEFlRFc3em9iS0xvUFBxZUJXNDVB?=
 =?utf-8?B?U0lja3BXUFhyTDgzeVl0dVZydFBoaVZyMmhBM1B0WDJiOTZwenJsN3hZSmFq?=
 =?utf-8?B?TVhUMGdwNnJXRWVWMGo2L0Y1VlVKN2VBaEg4SG83aXJSNUNhNGRkSVUyaURH?=
 =?utf-8?B?YTQ0SGdIVklyTXd5VVhsczhoMEVjVmx3dVo1ZnhmZGkwcUY2WkdOeUJKa1dS?=
 =?utf-8?B?cHBCUzFEUlF4eG1kT3oycHlqOWY2OFpUUUR6YkF3R0I4Nk5LcEE1a3VsWXZJ?=
 =?utf-8?B?WXRxVnN6L3VhZStlVzNWYUlCN0pZWEt4bTA2d1JtYjRxRDV5bFFCdktZVVl4?=
 =?utf-8?B?K3B1YnViTUpGYU1xNjVHUndyOFJnSGdjajFRb2pPbEVNaTc1R2tyUWlmRW1X?=
 =?utf-8?B?NzkzMGpCY1p2UVdpZW41S3FNZW16NmExOU5TL1d0N2FHcWpqWDgrUnQzckRh?=
 =?utf-8?B?U3BGVXRBZFpZd3JGaDVPd3M5UFNIc01mV0R5Y2cyQmRzSElyS04zbWpRemlN?=
 =?utf-8?B?WDFIblRUbDFFcml2Q1JiTEd1YXZEUHRkVjBma2xTYkdFQi9aUkNqRUFiQkRF?=
 =?utf-8?B?eDVScTJnSjRoTDQwZVY0OEtoTkFCQ1pld0pQVVlwaG9QN3llMkc5dWNueGpV?=
 =?utf-8?B?WU95NkxjSUlsVGtWdG9YTC9jNmVKRzA2ditVRnkzYnJqZ3A2Y2tsV29LMkdR?=
 =?utf-8?B?MFc3Ui9Ga0g2TnpvclEybVZxcXRtNG1odVhrTFVlYk1RWnBxVk03aVgzTzdX?=
 =?utf-8?B?ZTl1ZVdSYkVVUEMyb2djOTlxSk5jZ251RzB0YlJWajZNRWRVK2libCtRZUo1?=
 =?utf-8?B?RU5HVnZJeWwyK21nQjJTRi9mbXBxZTVYRjQyMWVINFQyemJTYndqZ2ppeFpH?=
 =?utf-8?B?a3A2a2RQaHJLN20wa1J0cDE3ckIvMFNLSDk2ZURIM1NuZ2RzQm9VaHhha3JS?=
 =?utf-8?B?OHBNcktlOXlDMXlSRlRTWmRQNjFXVDFOUWJwSHI5bUErclo4NENCOFpnMzMy?=
 =?utf-8?B?MFdPRHJJeE4wLzJFNGxvTlZGUEI3UEEzS2lxaEFLRlUzQlRtblFzbmZRb0xJ?=
 =?utf-8?B?NUZPMVlqc3JRbXhiaS9WQjFTRTJ2UVI0dHBHcTJQV1l0RDNMZmZQVjFldHEr?=
 =?utf-8?B?ejgwQjE5WEV5U1h1Q3l6bERVSWZBcy85NUNNbkc0QUNTNnFPdDdra1dnVC90?=
 =?utf-8?B?Rkl4NVFpRFFXS3FQUkFRREhLcFhJbTVvY2l2Skhqckwvc0p5WGhFQ1F3VDRx?=
 =?utf-8?B?ZFNyajNMaDFUU2NWMVJ5WlFjVkprWEs2a0VWQkt0UlhCQThUS2xSelNDSCti?=
 =?utf-8?B?QUZaeTJOakNNL0dobGZUUDdhT2RwaWxILzJ6NDJTUWIxaHNDdHQ0aU9EQ1FY?=
 =?utf-8?B?Um1nVjR4c011NDBCc0JKdlVhd0VYRzJ4ZzNOWFVaeDYvK21ia1VMckdoR3ls?=
 =?utf-8?B?RUtySHRreEQ0eHRIMElaazZTdHFUallkeXZhT0dLRU9tdEFzdzBHNjJxeUFZ?=
 =?utf-8?B?dHFscVdNNEpya2lRLzVmeldsMlRqT3gzRXk0RVBCOCtoaktGdGhLR3B2bmFt?=
 =?utf-8?B?Qmd3WGhyUmhtNmVtc0FMeDZaQVdqWjljdEZpT1U0bDduODg0K0VxUGhpTERU?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+CGldlDVSScn1W2Plt1TsTq8H/faiv4xR9PWlxVGO49IWqE/jkl98xKrKM0JDg5GvmMFTdYh384Ud5oKFe2J51kPQF/whUwChdKGoKoBxkDoql1n3s59xPszxrU5w+uWYz1So3Xm1rh0eab278o2+0uIX6pjoQDmhvEd24ux/Rz/6cNLWxLRh1XVRRoTlKNH9ZFBRGEZR7iRkCYLhg3O+9HLqdhGIPWxD8jdtilcskxkKMFA4Vb00UR5AX/b/StgvwG7wI5p3QIKNIZfz5VrqrV0shdR/G3Y+Q6KQlo1MsMAcmBh0Vy2DoNaENI7vx+XHqHwUrHu3duHwltmKNZQR2SHUDvp83V8LvEdGlbLA0CZPlxGOe51szDPhY1jwhYhx76IVNY+0u5WwZEbDWJx+nSaIkujPje4ZWtYEX0OZ7nfLzPz16uwPIhTZgy/idOebuWGrvNyRfAY56+V8dddZAUPn70GC9zgPuiTh3NBokrUC2tErsdZ0bFWd1lMmzdb2c9jLW7ZIz8jGip/dz/nEWiNdunjNkCS6TMsMBXCjJD70Afdeu7pYDqAvIxC89atvavUrce/rrJ/S7F38hrt90ln9HxlalolRNbghdHQ8WA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75a1fa8-e36d-4590-08a3-08dd5d7dd630
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 13:42:00.3386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9CgBvJN7OWSm+4Cn2ttQd2gCy0oiG1K46MIPZbnHqgtH0/+ORPpugU3rK1BmA0jxp3VzEJVMjTGdt9+X5mhY7W5BdxDQUleYLuzCYp9Jpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_05,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070100
X-Proofpoint-ORIG-GUID: mmm6_OGyrpQogjW6jctP1Ga1v3TdPb6X
X-Proofpoint-GUID: mmm6_OGyrpQogjW6jctP1Ga1v3TdPb6X

On Fri, Mar 07, 2025 at 01:35:00PM +0000, Pedro Falcato wrote:
> On Fri, Mar 7, 2025 at 1:12 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Mar 06, 2025 at 01:49:48PM -0800, Yang Shi wrote:
> > > LKP reported 800% performance improvement for small-allocs benchmark
> > > from vm-scalability [1] with patch ("/dev/zero: make private mapping
> > > full anonymous mapping") [2], but the patch was nack'ed since it changes
> > > the output of smaps somewhat.
> >
> > Yeah sorry about that, but unfortunately something we really do have to
> > think about (among other things, the VMA edge cases are always the source
> > of weirdness...)
> >
> > >
> > > The profiling shows one of the major sources of the performance
> > > improvement is the less contention to i_mmap_rwsem.
> >
> > Great work tracking that down! Sorry I lost track of the other thread.
> >
> > >
> > > The small-allocs benchmark creates a lot of 40K size memory maps by
> > > mmap'ing private /dev/zero then triggers page fault on the mappings.
> > > When creating private mapping for /dev/zero, the anonymous VMA is
> > > created, but it has valid vm_file.  Kernel basically assumes anonymous
> > > VMAs should have NULL vm_file, for example, mmap inserts VMA to the file
> > > rmap tree if vm_file is not NULL.  So the private /dev/zero mapping
> > > will be inserted to the file rmap tree, this resulted in the contention
> > > to i_mmap_rwsem.  But it is actually anonymous VMA, so it is pointless
> > > to insert it to file rmap tree.
> >
> > Ughhhh god haha.
> >
> > >
> > > Skip anonymous VMA for this case.  Over 400% performance improvement was
> > > reported [3].
> >
> > That's insane. Amazing work.
> >
>
> Ok, so the real question (to Yang) is: who are these /dev/zero users
> that require an insane degree of scalability, and why didn't they
> switch to regular MAP_ANONYMOUS? Are they in the room with us?

This could be said about a lot of benchmarks.

>
> > >
> > > It is not on par with the 800% improvement from the original patch.  It is
> > > because page fault handler needs to access some members of struct file
> > > if vm_file is not NULL, for example, f_mode and f_mapping.  They are in
> > > the same cacheline with file refcount.  When mmap'ing a file the file
> > > refcount is inc'ed and dec'ed, this caused bad cache false sharing
> > > problem.  The further debug showed checking whether the VMA is anonymous
> > > or not can alleviate the problem.  But I'm not sure whether it is the
> > > best way to handle it, maybe we should consider shuffle the layout of
> > > struct file.
> >
> > Interesting, I guess you'll take a look at this also?
>
> ... And this is probably a non-issue in 99% of !/dev/zero mmaps unless
> it's something like libc.so.6 at an insane rate of execs/second.

But the cost of fixing this is...?

>
> This seems like a patch in search of a problem and I really don't see
> why we should wart up the mmap code otherwise. Not that I have a huge
> problem with this patch, which is somewhat simple and obvious.
> It'd be great if there was a real workload driving this rather than
> useless synthetic benchmarks.

Disagree with first part. Disallowing a known-broken situation for very low
cost in the majority of cases, as well as documenting that such odd
creatures exist is valuable.

Improving benchmarks, however synthetic they may be, also valuable.

But on the latter bit, yes it'd be nice if we could get information on
real-life scenarios where this is an issue if you have it Yang.

>
> --
> Pedro

The patch is fine as-is AFAIC, and I am very happy to reduce lock
contention on heavily contested locks wherever I can, especially when the
cost for doing so, in this case, is so low.

