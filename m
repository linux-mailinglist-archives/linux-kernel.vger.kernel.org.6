Return-Path: <linux-kernel+bounces-569954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A92A6AA19
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE80D1897768
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB6A1E8323;
	Thu, 20 Mar 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nE+UGiVj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uyvMvIU2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBE61EA7FD
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485312; cv=fail; b=riRewT7YEOrwtYCk6M1OXCy/kCCbTz0c9UvDY5U8FujGPm4Xa8x0q9z7twXAfLgrEJo56dMKjcpXshyflYDbIM9hGUkLCyXohGv37mbTXgouDEAz1rY2UcCOlDohNZBsGAOM+IQc7R4n75Pp94qbYD1eJJ9OAvYDGCZ1ETZG/y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485312; c=relaxed/simple;
	bh=h0k0piU62/WYR3p5DhiUXnuiVGWUjr5NpG02IdhfKSg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h+LthqoaLsiVZRDmJzxyYU6fOVYAiCL6BjMfFEp8EmA7DZvm3DBRkqmSowQIK56PSf4i5kf2leh6Vv60K0NNdfwUKEpe2cxvn/rdj99EB0hI2/g9XyCn5wt3/Wj3i/T2FZdMTbHPZr3ABFhJ5BL1/FOby/JW4LdYW4EIHSxrucQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nE+UGiVj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uyvMvIU2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KDNJh7009074;
	Thu, 20 Mar 2025 15:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LZrIpHtzjThFoi0+T4V1ee1rdxI06TUk47axmf/ev+M=; b=
	nE+UGiVjBJsOoMd/dfQeO6qQt81gpgYreKrSeCXojLPm+p1OagPpKxyociEG2uld
	GZLtD6+ckzFY9hIGn8vc2cbffNw1AvK+6PoT4g936H143s9L3fpc7/hI6kTFKvDT
	rzWqvTmUHQI3zIqh5Ch1RrCvk7S+1box9sXJLWjnuxxPe6gVlo7YE4Z7m81kPlSR
	IbZfLChrAhJtXCTjTPvpiwbvXtHrzX8Y87EalFNvLb2IsHJWSbYZGnGHkadPI4+5
	R8Jd03eA1R//TtXFG31H7PJQjWVLIuhbgfMLm9ndimOrufH9jUB1ez9Zbp/41KT1
	2Uf1sMR8Gjl3SyxRYjefmg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8pbs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 15:41:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52KF6YfQ022461;
	Thu, 20 Mar 2025 15:41:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxejh56b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 15:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=axm68w1RFeTAr1YZL38QSIwBlzd8znFY2SJU2V54TWCgHMWAH/MHNUp/4/w1a8vonuH6posfNesuT2VS0RrHwxZK57v2ikcQHpwmBL26FqW17ypG/HbvBfdrWwbmn66BsjPwPZOJCEXxuTRJUR5jTl/ghc0rYY8A/lTgTnRncOUfzIb6lB5DDU4dv9lF7LNIqvrhu87R3WclGQ6SELHvYClppynRcy57gdMeuYQHEO4wL98+BMlDyfVIvV/TB5g0ORiD1DUc8k+6SppIdBgdaNL6ch9BmOvRfChkhDAxvDuAKAmGfA6Fd57jES5D/pW/y0rivq8ETb21QaFgGD2Ejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZrIpHtzjThFoi0+T4V1ee1rdxI06TUk47axmf/ev+M=;
 b=q1VcPIBFt6j670FidaRTiy/YPGIbVoC/JEJUjO1f2IqmoaDiYno+aO0xBDbR5J2mHcU6gGurn7q4m+zBfb6bCdSO8kSIwMmE+qPV0hEtmRV3e7JKvuO3RiZkVmI6UeVLvqeGjrCXXxmKQGToaxZj8u/ik30MujYQbpQsKz1GCzlRgrA2Scph6QEOSZI+ivEjumhwZv7TNf3Js9hktHegGBsEHm3zRlWtSXI6Vy2H2SEcSs4UWBKwAH9WesWZ1heWKxOglq5OItUjL/W4qy1rJW+B4BSBVlTD0hvcFttn+Fx7Pq4/j0KWjeWdC2yacji2PEY+JdBalGX99heLqNaQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZrIpHtzjThFoi0+T4V1ee1rdxI06TUk47axmf/ev+M=;
 b=uyvMvIU2OKyRFWW6hIkNx+FxDttP0A4+IJaaLC/gQuhjeoj5i6UfoDg0t5z1YK8Xn5xUJQIIp1KbPxVfzHG1igBxcMAfreOcYoiRYcl07R5RfQFKpdPSn0L3G2CpfU4Rgdn+r4J+7+D4Eo76pHNby1Bpag8q1dAqNq+iw2OJcz4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB7150.namprd10.prod.outlook.com (2603:10b6:8:df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 15:41:29 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%5]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 15:41:29 +0000
Message-ID: <dc37ed50-2739-4e51-88d0-b8d429ba2530@oracle.com>
Date: Thu, 20 Mar 2025 10:41:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_alloc: Replace flag check with PageHWPoison() in
 check_new_page_bad()
To: Ye Liu <ye.liu@linux.dev>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ye Liu <liuye@kylinos.cn>
References: <20250320063346.489030-1-ye.liu@linux.dev>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20250320063346.489030-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0060.namprd03.prod.outlook.com
 (2603:10b6:610:b3::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB7150:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dfbacfc-9a4f-44f0-4edd-08dd67c5ae7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFF5eTZKK2x1TWVoakF6eDhwdk41czFKWlM2UXJmOUlyb0RGNVJsa3UzaDM3?=
 =?utf-8?B?MWFvNDJBY3R5NmQrbjUrOEVGSmNHWEtyY3RSMWV3UGxsZXFBYUI2SG1wc21X?=
 =?utf-8?B?WDJicFlCOEdHdTdJUGd6dWl0dTAra0U3eHRzanNuMVhLeFhqWmVzRXVNdnRB?=
 =?utf-8?B?djhsbGV0RUFSemY3N2hUUmVqdHk0dlVMaTh3R0d4L2c5SjNZR2FMRmNGS21W?=
 =?utf-8?B?NHpNUW8yVnpkaWdYY09zTnVSSW1kNC9qbW00WkhZSmZIbXZQR1NGYTIwYnl5?=
 =?utf-8?B?VWMweGxheFJqWEtWS05DN3RKQWJiZ3kxNW9TL2lPNUlnK2R6MTZrQjRSazhz?=
 =?utf-8?B?Z1RRY0txbkFHR1N3QURNQy9zVWxqU21ROVhQVDQ4cUNxUzdyN05XRkFtODl5?=
 =?utf-8?B?Y2ZNV0JxNFpOTjdheTc1bnMyUDN6RS9CQ0owN3lZSGprWG9KWTlKd3VPbjI4?=
 =?utf-8?B?NS82bktaZUhVY3VqbXZtcFdTQ1dBcWZ4UUpsd1YyckJTZkV2dVoyeDJ3NHZY?=
 =?utf-8?B?a3pXb2Roc3BoWUFmTHNQVjBuOWFKUnY3L3hMZXgzbk9sNHA1R3lxRkowb2kx?=
 =?utf-8?B?dUUrWk95a0xBMEFhejFudFZNNnM5cTRjYjVieXkxYUhNZWRocGVJUUN6V25w?=
 =?utf-8?B?WDJNbURBeWQ5RGoxNTk2SFllM3I0MVhqT0puZzh2WlgvQTd2ak9MS1ozZkpy?=
 =?utf-8?B?UjBvTGREQUNNbzV6QlRkODZDdDFta0pCSWNRZE43VHZZeXBxWmsrWStrQ095?=
 =?utf-8?B?WXNIK2RmaVhZSXhXY0k5Zmd4TWlnTVNqTHloU1BsZnBLeWdzb004bTd6Mjhi?=
 =?utf-8?B?ZnMzTHdmZ2dPRDlpbTE4Z1FoR2laM2Nud3kvWFp6SGVuTFE2ZWJSSldLR25x?=
 =?utf-8?B?S1p3Rzg5QVJmY1gzWUNXNTJ2SmwwN2hYamZZTDNlTkhiaGNRSnNWc3RrbHVL?=
 =?utf-8?B?M0g1MldhU3V6U0UrMFpiY3FuWEpyOVkwR3Joc1VsSjN1TGxaSllsaFhmc280?=
 =?utf-8?B?eTJsUjMrenZHaTRrY3V0b0VOOHNxUkpJZ0lRMC90T2I3MVRiTTNBWTNlZUhS?=
 =?utf-8?B?ektQR1FMUUlCLzBWQ2FLbE5vZTUwaVF6SzEwNWQyWEhVVytFMzNVaVFoeDVt?=
 =?utf-8?B?S25lT3djUDJTalFDZUtxUWNJRm16eTQzYjBTcDV0TElvYVltcE14aVR1bmxx?=
 =?utf-8?B?SXJnM0hFcG56WVZ4alRJRjRDZmVZVHF5T01pSDBmejRVMk92VG1QckdZVERQ?=
 =?utf-8?B?bjBQZ3RwM3B6WnF6TU1jcTdFVW5YUmkvQlhUMTRFSjRNdFZLWGF5SVByRHJm?=
 =?utf-8?B?MW5EcENhcGZ6MTV0MFJodHptZ0tiVVpZcHIrbjV1SUUwVzc3RVpSRGVoZnZv?=
 =?utf-8?B?TEdrUjBFVHNxWVZHK3cxTVdOdjVQNStrZDlyaVF0OXFxREt1SXRPQWszb3h1?=
 =?utf-8?B?MUlxVTNDUEJqTU93clVMaWJWOElVb3ZZamFHMXd2Ky96Y0YrRUd5SmxwRWUx?=
 =?utf-8?B?MUNqRXkvMjBxOEJlSGFHc1J3WlJBRW01R2c2RDNJZzVaMGJRT2RvZUc2aUlQ?=
 =?utf-8?B?ZmVPRVVpL0NISkZralU2QTU1SGVueHAyWHBubEI0NllNZzk2aDRpbXpUZndF?=
 =?utf-8?B?S3h6bUdzaFpidmkrY1NHY0diby9CZ2o4azVHTGpnbzVYc3FENTUvVzc0STRM?=
 =?utf-8?B?dm9XdmdnaDMvY2kreGZuVFJIbFhyVUlRbnk2NUt6cDVzQjNSM3QzRThhT2g2?=
 =?utf-8?B?Y1VLVjZRZWllWE9vWkFBR1lVTWRyVVRKYUU3UDNMVnhxcHZDaVNIcGNmK3ow?=
 =?utf-8?B?U1p1TG5nYnB1VldHd3RXcU5DNWJBMDYvMnlaWTd5SHlNeU0wdzVLd1JwUmow?=
 =?utf-8?Q?aUefzvjaZAK05?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU1SMThRZlBZVkNGdkl3VTM3MXZYbWlMaDFpVjlrRGkxdi9NSERkR1gvenMz?=
 =?utf-8?B?YXNqTWVYQkxIaGlPcU81REttMmgydGQwYk5QcmZyTEE2d3dLeXRKTUlVSElk?=
 =?utf-8?B?U2xodjFrSjdaM2ErUWl5Y1JnbmZGRVlHOHdvNnY2aDZNeDMzUEgzMUhkZVF3?=
 =?utf-8?B?YzIxSnZkYU8rT0xzcUVjTS9UcG9sMzdnbWNqdkg0UGJia3djYXNxYXJIZXkx?=
 =?utf-8?B?MTFhRVpwcE1hNlZESVhJNkRCR3N4Ym9sM3QvZnBmOHg3NmRJZnNGUWljVU5m?=
 =?utf-8?B?bEJYZmhndGgvRmdianY2NndQb2cwTG4yenYvYmlZRWNKbE1OVjlWV0YyTXo0?=
 =?utf-8?B?c1AvWU9Jam02U0R2SDZzcEdYdmVFUTRvODhTQzFKcmV3OFJyR0xsZFVwMWpV?=
 =?utf-8?B?T01abGovcjl3QThndUw5Q1IyM1o5UU5RUXhxNC9lc1B3OEJ1Tjl4SC9ubmxu?=
 =?utf-8?B?Qmhxem1CUjN6ZTcyQXRHVXdsa3lQMW1NSXd0WC81aEIydmIySXVVQm1hZk02?=
 =?utf-8?B?UnVjQTJHZlcxckx3K2xSakhESHVkdnpBd0tEWjVDcDZrK09ZakVYQm5CYlk0?=
 =?utf-8?B?RFVoWlU0NlA2eWMvaHlTeUZOQ1gyQmVXcVBZamlCbjUySDlyRm9iU2llY3FC?=
 =?utf-8?B?KzA0eFcxNG9HVWhtSGhDUlgzWnJXdEptUVdqMUEyQTQvQlQ3QlFlcmJxVlo0?=
 =?utf-8?B?SFJ5SE9IT3RXVytzeHY4cG9CY29UYi9WVjFyZ21jU2Nxd0RvK2pyMHpTUUdD?=
 =?utf-8?B?eHJXb3ZEb3JYUi9ybVY3SzFqVVBTUFZ5MUhpLzk5OFdMdGRyME5yNkh5U3ZL?=
 =?utf-8?B?RFBoNkI5RkJYa2w2aElIWjMxRVJLVEhrWVZtK09YTGMrbWUwZFN2Z3dhY2Jm?=
 =?utf-8?B?T1ozNU1SUnd2SGtVSG5PMDVjcU4wZGxUZHFobjNXWDNPSWxzKzRoZHRnVGFr?=
 =?utf-8?B?UXB4bGJNU0NBVVdYK1k2bFhJRmd6UWJiOTdLL212ZVdMakhFZ0xPSER6QitN?=
 =?utf-8?B?UXlELy8rdDdubE01YlYrSHE1K2R0cmR1RWZDMWl1UHVzM28yRjBiYTlKYjBN?=
 =?utf-8?B?TE9HSlRPNzRYTDJsTW9vT0IvUjdxS2Zic3BnKzV5TWhPWW9PRzFyWm1lMlVD?=
 =?utf-8?B?NzNuTUs4RExQOTAreEZzYUNMTk1MZlRadytnc1BUSzZWOFFyT2tmMTNIaCtD?=
 =?utf-8?B?ZXRianh1Wnh3VVJyOEJLeWQ2eFdIYXZWNWtFUkQrb2t2Y0w3OG9kM2dvQ0dI?=
 =?utf-8?B?OUw0T2VJbE54OGNPOXJVVjJtNzhPR1RXT2RDVnUyTGFrY0ZkRVRmUTFHTXF0?=
 =?utf-8?B?aFpSWnJvUDExWU14ZVB2WFp4Q3g5K2J0dEhmdTFHeWVkMXhZcWQ4V3EyVWdY?=
 =?utf-8?B?NTFiMjlvcVNVYzgwcnhrb2tOQmExSkNnSnJJbjI4Y2YxZ1AyN1h6YlkzZDJE?=
 =?utf-8?B?WjM0TXZZdXhiVmhCM0xsSGdFQTRQY01pNmhjcTFMYWVrd21wMXhrRFM1N05F?=
 =?utf-8?B?YWlnbEl5aW5JQk84enhBalhQWWxEOHRtaEJLMTc0Z29qOHJIRk9ZUHBSc0Zm?=
 =?utf-8?B?MHdQcWpmdHBVaVRkbFJDaktUZFpqelJaQ013MExFbmdKcTRTSlJyR0NPV1hJ?=
 =?utf-8?B?M0tpWjJIdXNFWGZOL2ZVVllUdWVGcURiVGtTRVVoTUptZkJTaC9NdTk4c2lW?=
 =?utf-8?B?cElrNDJuT1NZcWg4dGg0L0s2Z0tmNSthSmRCWHNLOTQ1MzF0N3BydW1WU2p3?=
 =?utf-8?B?SS82a0tKMEhkQ2x1Mno2QTVwQlhUWTBicnJMb2pFek1jd0QySHBTUVlmaG9E?=
 =?utf-8?B?dW9GMDJ1ZUM0RHdxVDdxQzJZaWdjSk5GUTRXWEZuYlc3SUp1NFE4aFdaeHNO?=
 =?utf-8?B?L1luR1pobVh4UXRVRVlzaXJPd3UwN21GNXlmNTFjQjRLZEU3QUNIQ2VMMU9T?=
 =?utf-8?B?YlFoeDFmUEVVbFE2bDU4Sk5FcDdMSnRlS3hrYnh6T3BDMEFUWjR0V3VBaFlU?=
 =?utf-8?B?SmVJWXVJaHBHQXk5S293c3B5TTVQN0l4N0RFL1k0M2dDQ09PUFA3c0JGUjFw?=
 =?utf-8?B?NEFEd3d2QkxKMDdsbjN1YU1nOFdrL2V2eTczRXg0VTZ0WS96ZHVrSWRwdVF0?=
 =?utf-8?B?L1U4SEgzTG5TZXY0QTd6bjkyYkVFblJvNG5TZWkrb2xOdjNTQ0lJSnJXTEx6?=
 =?utf-8?B?bjVQT3MyK2o1R0Z5cldEQXBqdE84bUVGdk1CdFQ5STJMdDVUREpwenNjR2cy?=
 =?utf-8?B?Wm1CWGs0a2hLMW9GZ1N2VDZDUE53PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+VI6Pad/fDync7JtoJyaCPx9qMNGcYF9zXi8+VjwKJMkgMthdA5duqoXrgdrYgCK5fyhUXdrhRBYR8oCn3wad50AFBKK/JtF37bPOjMSor/qDZR3XshGz8YXJm8uHwor2cbg3CCAuxsEBJ1Bx3lJZZL5F3y8A+3ZNkQaUXcJJc7kQS5VhVZf/iNXP5dFknRnZtZeBkgmaBOC4z4e6GqJLOmAx3FVXx+5ofmWGTWzGqAmRMfG+iC47QCqNE4OuHSORh1doeSgia4jPZSfjx/jwpzlV+XE1zVadcaDh+7Ve14W0epoGSTEKCog/bJ+ECPMCc3WEBfVB70ShVxJTi5jbCxRLF5u+PQb1PvwfAOnEZ5Cx/WPy8BtomCu7x13qAVly13EvTJTF1O3Wj6Q4Le5eatqNBCb5on+++oUy8N+W2iOZMx4Snde6S+5DNbmFOxKvs8JAfnfImP6yqq/CVMztGw0nwIy+hW6QUcIJlePnVnuoos5IG839hmUFeXk2+NuUB3r2ubZIwNaF6mLsvzp2PhaSALv1RfoW1ZulU/QdhnraaL2OVyuxI+JShdpOAaM2Mpj+djSzNIxuSs/WYTJ7cX8IHioIiKAaK/BOBDhk9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dfbacfc-9a4f-44f0-4edd-08dd67c5ae7d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 15:41:29.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+nZ35vVBYuvMBEVZJTPvZrZLCVBxlM9w8NJi5DwOllotec523/KV5oHdtcJj3EjlyrpxzmwuXb2E9PPxGaXhFfK7fBavMKv3eBvvWrWm1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503200098
X-Proofpoint-ORIG-GUID: lcVGWwEQXJ7BG1-Hnm-YPqhQJ52xhuE2
X-Proofpoint-GUID: lcVGWwEQXJ7BG1-Hnm-YPqhQJ52xhuE2

On 3/20/25 2:33 AM, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> This patch replaces the direct check for the __PG_HWPOISON flag with
> the PageHWPoison() macro, improving code readability and maintaining
> consistency with other parts of the memory management code.
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>
> ---
>   mm/page_alloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fe76fd237dd0..6ef54abebf51 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1427,7 +1427,7 @@ static __always_inline void page_del_and_expand(struct zone *zone,
>   
>   static void check_new_page_bad(struct page *page)
>   {
> -	if (unlikely(page->flags & __PG_HWPOISON)) {
> +	if (unlikely(PageHWPoison(page))) {
>   		/* Don't complain about hwpoisoned pages */
>   		if (PageBuddy(page))
>   			__ClearPageBuddy(page);

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

