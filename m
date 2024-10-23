Return-Path: <linux-kernel+bounces-377668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4EF9AC214
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620172849DB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D771A158D8B;
	Wed, 23 Oct 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mGWCC19O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HyJ0UxZt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF861FF2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673209; cv=fail; b=hkfksMzR4YCh5QvRfYaPIHPx7Oi7hXwuhGlURfqibFfL2ThF3hjr0frj7/Ro26pnlCGVOb3Hha7Dm8TUSiQf8zoRG+NH9MVZqcpaXYI0DjiXguL4w61cpw8JlaWPg7c5/4C+5kc7EqgMR+/HqaAt98S0WkjFbFwBp8Xz0Bw+pwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673209; c=relaxed/simple;
	bh=9iVjTE8xBpNYzQCdargDr+u4zjHv1dW8qDPvqXjNraM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/7PLgET6PPj70IdJ36kx8fTKazJQb1lHLFme0Hebzd7RAUZXhLOzTNF8GcakuHr4kvS/R3CE7Boh6uDl1r6rQGFllzKg8KiA6oaHnCT7FvkCOJc2g8x+nGh2nMf/XgLxlvCiXaHAd1u6kF7YOW4HrKGn1xTHVsd6MXBV7vY9Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mGWCC19O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HyJ0UxZt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N7tebf018152;
	Wed, 23 Oct 2024 08:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/qocgUIC7A1sHUrnK8
	T55KSooLShUcgpnRJEVK+Vo/8=; b=mGWCC19OGj6sTf50+T+WUaZyiTjsARpFb3
	qaPhegOxXUv5kUUKrJPMSQlDsLE7xN8aBOw57efEB7YhulbZeK1z0RULub53bVx5
	Ceh2pCgbn6m5m43JhAXASqzRNaSjfDtlwuV06yNE3pBZBGQ6+tENezemcs2YuHwO
	f7O8U4SZDAajA7y4ZoS4Myibqx0CiQCEi2fVPvSko56n6BUTYAzJOWSGI1/srjSi
	9t4Lop4k/cn31ZTglOLIOoBqX005Yrp6Ektlw/PMTPXmGR3lD3pY3lKt0IH7+iiR
	u3bXlAU1J4Y5IjVmIraqEYmYdeLc74dmebXF3ZohMEFBXEGjpGhA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5457pht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 08:45:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49N8jJqW027342;
	Wed, 23 Oct 2024 08:45:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2h4cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 08:45:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8BQRZofog86hvi8yuDwNdy9/Nfo4d1Odb1tdvb4UOEz4DLdBGhPkVAME+XmnxAyzFS1tJrg+zS7z5+5KSXj2rQyZAVwVm6A6tbW3NS0Wio3GRdusPQZORPO2SsLF/PjhCIKtJTsJe79SZxb/luS67NGY4sRcWi5fi2rRqYldx1YYEjdwgRPubEfPnnyBQPzhAV3vCwnHiEJqPte+DBXwFA3mAloFAnR1uZC8kSSarRkE8NXXVmVowgY+zvREMVprAUt4Jmtmnh+U32tvB65asxUx9NLpf+34IlYg9JMqlWPPt+Rw4y9x5uc0S36IRUJ3VHghcUxI55/lvMWBLNuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qocgUIC7A1sHUrnK8T55KSooLShUcgpnRJEVK+Vo/8=;
 b=fO3WQunsT977avzN1zDVcYJ42SgyrXb4ExdLzqdiYires8LXA/QYq9aPro8NjDRvCA2y4YwoAO+tOK7JvyN5Z3c91gmefX94ByT1AbCuZhFHVm+RWp6w4sklwaGUu5c06rXnC2ilCPkLFvVj66HlViRbJb7sBStUYlFF8boBPrK3IzLMsZ3KzQ2nbyKM9ec7gFYc+clvg+e/HHBDvKVCQht24LhsZ512N2/TGCKdFCGWUD1e+FcNgRE6R4YXGk20RCzKnLUGh4y1LIMg6wF+uppVWFi7SnFsFDHGM3prgCQTunWAp0MgaMv0ssJA0CH8cpvtcyfKQgUzY+cO9sqjrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qocgUIC7A1sHUrnK8T55KSooLShUcgpnRJEVK+Vo/8=;
 b=HyJ0UxZttfjpQr2mi/ZcYZi9bD+eapNqYyJShJinAtE8A9IrbI64IwSlwZFmPK72jpzRvPc0lDm9yns7QSJEpoljkgqdxBzk6OEwaWlOS9i51gNd1MNatgtGJZrsX6+Xme7rw8hk9XTeUKf3vTWddrqV/kOJ/1tynDDWmCrQDKU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB4825.namprd10.prod.outlook.com (2603:10b6:610:da::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 08:45:52 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 08:45:51 +0000
Date: Wed, 23 Oct 2024 09:45:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 0/8] fix error handling in mmap_region() and
 refactor
Message-ID: <78f09435-71c6-49d2-8d31-05456b9b0313@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <2ae61141-9d88-4493-9fc1-245e29dac445@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae61141-9d88-4493-9fc1-245e29dac445@suse.cz>
X-ClientProxiedBy: LO3P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB4825:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfeda3b-8413-46f0-db03-08dcf33f1961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uOLlliVSekd0fVi6h6bRy2WKx/bCzpV4EpOtGNz9mqVgpQY+K9Qa07FfHHhb?=
 =?us-ascii?Q?wOf/tpveAfWdYQLlQcAng2CLFq9EYAagungLqZ4H0YhdqvxnB8nDn29EVpKX?=
 =?us-ascii?Q?jiJkElkRPgDrfIZJsu4TZO4F4wTyQNQMd/vF1RJw13wOsKYzGKeuFmTvZqHN?=
 =?us-ascii?Q?tIh0l5MD+PoTMQFsx3CxfXPb8InPgH9cAiWY5RtsGHwl5vQ/4KlV9a1msjW3?=
 =?us-ascii?Q?K/1TxkPRLryJiGxuVqS5+h+5WsvTEqGx05T+m2CdUemJ6jOj5B6Rou47imhZ?=
 =?us-ascii?Q?RRzUdfDL5RVlzF74BzNAj8/R6G2tNT7CZO9/Pfufrno3ifcelCyCJh/4qWGw?=
 =?us-ascii?Q?sVmMeq12i+5qwu1MTRIIWD+jMy41Pcyw+dVyusPnXjsc/KVBUhOg4dZtk2G6?=
 =?us-ascii?Q?jZM2chL5IWnOt+E+qmWIZ13BWyJhXc5h47mXBLryrq37RLJx5GZP3+q645fQ?=
 =?us-ascii?Q?pwi86WCYuHtCsEjSLYgMIALqy8/FZiJroINTUDfxTDLJiUavAg+aihYT4Kor?=
 =?us-ascii?Q?vxTx2k4bBsAdCUTSP73gv1LANzTQb4QASjrCjBfktV0ujQo6ASBmjSEhTZh6?=
 =?us-ascii?Q?pAeTDOEK3AMeE94RFYEgU9H3XgBmUw67AjYfF+iYLhbyx/4TYSlG7q8CON2k?=
 =?us-ascii?Q?SCMRVadudw+mOPF3QD11+Qwp3Q2urC1joVuJ7YVdTu3HreZZKPeHbq6jKuK5?=
 =?us-ascii?Q?qHbJKkhSC8p1s0G+naKvh362ju2X8pVobbdRWsqPYpUerq10/mAdc1XbA/oO?=
 =?us-ascii?Q?CHrd+xUP3YjqjAA1WJFtz6t5qrpd4u4gudff3DATzxI5D8lanEcjSLS0QWI8?=
 =?us-ascii?Q?PKzNzSE1M9e3F7eoIBzlJ6HWmryiA8x30Q5dZdKe8KVCUgN+bf+IJCK7N2Uk?=
 =?us-ascii?Q?DbobAk3x9092h/nNY7mXsCdMS2im1FO9OwdRsb3AQyZdjtF61g5iPFU23kbd?=
 =?us-ascii?Q?vzeEh389TaTV4043D19JGye/aPlcZrydFs209O1XMZ0cWfsVaujya7NChNqQ?=
 =?us-ascii?Q?+gHGdBaFdL8YMSb16AAKHkZu5kAaHYxAAf53/T5ENNKJksIqniLTnorFnLEm?=
 =?us-ascii?Q?tmC2jpQ+VaQ+8Gfr9GWHePQtA7gdKhEtenFOVrTNqoKGYuENdjjKs0kiMCKE?=
 =?us-ascii?Q?LzmJXJ10+WaoXOwsaYQvxZHL4oxcFSt5HwVuROA/q3W3KKmLoeOF3FdiGhtw?=
 =?us-ascii?Q?pogE1ikT2lvdy7SaQnnd83qnT47bEmrId94fi2oFiiQwTXlRYZu5OuDnvK4Y?=
 =?us-ascii?Q?r3gBjZrr1d/XPOBty4TMUkTcyVAe8NhXfA2Z5onnjXaF3DcAHatMdZowcJGg?=
 =?us-ascii?Q?G8MSsIRY8mel/Zmo71KLz3bR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbXIjI9Jnya8ETIB+86/IywXmKQOcNzSjsL/Ylt70cak/A93ifvVj6oyvhjG?=
 =?us-ascii?Q?+payL+qoQzHkxHqRABF4eK3vuFHr7XCOqhYwAmxgubsY3z7M2zw6AJAv3JW/?=
 =?us-ascii?Q?EW09w/MEUl6jtVkr7UyIBGgp7fLydG34uCYjfbV6gY8ju/nxpohP6kSuCeJ8?=
 =?us-ascii?Q?BhsZgwlZY84uFqLucaF1heZBamzWFNRvhx2U+ygR4jKqv7SjxRAcp4KRaEpv?=
 =?us-ascii?Q?+6tWcpY40YyUqkcCfcsdKvVPQP8IxHC8J30kkf3CUH28eGXGK/iZQDdWAu04?=
 =?us-ascii?Q?BL3X2Qhf2kfCPpFhnT3wnDlhTm9Np7HdrUFgNQped/TLOjLgvfTi6GyoELob?=
 =?us-ascii?Q?TE1q+A7ft9luCNUpYomqKWUp+4v3qhQiyEK+06O5XU/R1YAVPRiM6rUfOweT?=
 =?us-ascii?Q?0PtGcOdC0FPa4osPeMJJ3B04vqsPen5RgDkLqdG5pu8P6IzwMnIFG3AvoQae?=
 =?us-ascii?Q?UbxBeADZaIBet3X1A5DZIzNVsZXOY02HYLwg7QJbzUD+zBKEIyFB4QgpttRZ?=
 =?us-ascii?Q?KSjgglf/C/q3ZGipx3UEf8dipOqKLk4XdAhdKwk+BW8XYdJbA7+4Est+ih9C?=
 =?us-ascii?Q?zmHWhitkNiX9RgdnjaFCHuvDXjaNhQtEOlhcQsa18zbkPlIt9MQTaGIyZRqI?=
 =?us-ascii?Q?+XoLuhCklW+LcPhQV6isYJghmrZHnRW8KLwzjd73ru/gFtWb6CFCmX+fiKE4?=
 =?us-ascii?Q?/02sMcKXZVyI7m7KMwHYi3tBHu8P6OrId7zBy9iin2pZFT//QvSDEu7CV42E?=
 =?us-ascii?Q?wA+/2oUDXgRAG6nWnN3P4nRlu84EdpYrThQxL6erL+MAOmkQ5PmMgyXBv7Ww?=
 =?us-ascii?Q?B5Ud/f+zpn7JrsLLyoXf7hyhIVSJLlKustkt05m8ywSI34eDkVnuvaEOBBt3?=
 =?us-ascii?Q?/yduU/09LGbRLQh/tf0POyqSy5CxE7JmRi4KReeDugF3+wssyJy3YPN+MXR5?=
 =?us-ascii?Q?VUubZBdBD/JSL9xzzRlxuUO5m8RnWjzmdbldddZ/HyVl0biOJTPM1mYhiC7g?=
 =?us-ascii?Q?c7yMHwPWwfyiZTP/ZczlmX9KggUsPDg+rMJ2hPArzajVa+ezUm31t0m9k2LI?=
 =?us-ascii?Q?cxh6HQVtIF+aOX2terNrhISB+238u1R9oBHY5ZKO5nxiPWpd+r6vapWwBYUT?=
 =?us-ascii?Q?XCB6SnZyQgcplabI8i47zXFIbqVxeD41M0N0IlJpU73KObU5REEP0NwuKpoY?=
 =?us-ascii?Q?72KgvjfyuLjbv8WnCEYpSbe81LipPJISK5sh0DfJCbpYCcW0l3DkLrOAqKmu?=
 =?us-ascii?Q?74nen8ZWsgb8C1eEvk05xdBdAJAIFRX8katFPQSCTojzqGuW0cI4VaQfdNHi?=
 =?us-ascii?Q?H1Cqgl4eOh0ed1qElmt1Eez/imVqFoXdQOpTl3pIvIhRxJ0DKL5HcFqNpHOZ?=
 =?us-ascii?Q?ATGyjy/RUYNbhZXoGCQ1ClLUE57BJd44L+lLaiy1+ZxKGH0+TcIUuy15zmB+?=
 =?us-ascii?Q?ZYBVdvCPg1e2Wndv1azLWwQJ/velVknwC7PMnr2szpHzsL6zDZ1UtvOfQteG?=
 =?us-ascii?Q?u6fhNpfH0Qva5KA/Ey6g4ugQhK+pc4FjaNwKmEZzA5L9vAeh51zIKpZhng1R?=
 =?us-ascii?Q?S45V0/SU7vGXmRumwZawUoZuunDp/0XagM97XbivvbNhT2T5JCdLLfyAG4rb?=
 =?us-ascii?Q?7Cl9RbRm3dabbo5xxUWRJ/KfnjAu8Q127j8IX+Vu2r5opkz89OyB4ZJ6MzAn?=
 =?us-ascii?Q?UdOlAg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hXtzIA9jg+Y3gTlzQ3HbscL43htWhQhPXYDMARHUDE2uu4t1+5U8BraCBsgvjloYaQUbqpn+hY/Ud4JxtZFcBPOI/8y4ljD8jgkuGXfnEPUPsMFneZLNrbV2Oziqpk+171c9putIir2L6Xs4TJJ6TlEqSE6UXsiud3A3iGMI49NCql3NpFPBFaLnjuWMEcKMEMPdoOsfYXbCKSd7zdvyOC/Zg3jV2d1fqtO09alO+7xb8Hgk1Z/gugoxJLhSSbYAY+BnM5K1ZOqhSgqgEmCp5CthhT6+uaSG+gvmv/yZWAQOi5k3DwpMQFO8RIDzgD+/zgRmAhYLsvw5/IQpXZepyZGuaqf1CDVpUtE+8lvhxERBt1Eb6gfg4RZ6JdGEZOUjR6uQDStwAVSNLccYulateajLUuGYHv/x9AnDcrD4oo9NpBGSs3OKqPLjKv0onN4k2f6bUy5i/QtGffw6E19CpMRdjLWbzDceEDnMSU8Nh1dVnPfyw0MeQ5x/NL8s3qZhfVlHk+0nZb7E6YN6ZPyBXqQnVbIWIfC57sSDeNlRA5fHVbbIVyFF8adC04E+Qh+FFt/vyMOAWh6cIOuQV4W1J/DrmqUhT7zRP5Etek89KLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfeda3b-8413-46f0-db03-08dcf33f1961
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 08:45:51.6553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rtl8A1r9CHykarYhVQW/BPdRmSNZQ22+ct0p0e3x8TgkbCSovn56bTwBFxH9OqQay4DQicuW7qYFOCNjJyVt+mvK3sn5I7ERLAsbynzcqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_07,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=957 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230053
X-Proofpoint-ORIG-GUID: tgxuDetSL2SHmpl10nkmBqoQAnlYxKLe
X-Proofpoint-GUID: tgxuDetSL2SHmpl10nkmBqoQAnlYxKLe

On Wed, Oct 23, 2024 at 10:37:04AM +0200, Vlastimil Babka wrote:
> On 10/22/24 22:40, Lorenzo Stoakes wrote:
> > The mmap_region() function is somewhat terrifying, with spaghetti-like
> > control flow and numerous means by which issues can arise and incomplete
> > state, memory leaks and other unpleasantness can occur.
> >
> > A large amount of the complexity arises from trying to handle errors late
> > in the process of mapping a VMA, which forms the basis of recently observed
> > issues with resource leaks and observable inconsistent state.
> >
> > This series goes to great lengths to simplify how mmap_region() works and
> > to avoid unwinding errors late on in the process of setting up the VMA for
> > the new mapping, and equally avoids such operations occurring while the VMA
> > is in an inconsistent state.
> >
> > The first four patches are intended for backporting to correct the
> > possibility of people encountering corrupted state while invoking mmap()
> > which is otherwise at risk of happening.
> >
> > After this we go further, refactoring the code, placing it in mm/vma.c in
> > order to make it eventually userland testable, and significantly
> > simplifying the logic to avoid this issue arising in future.
>
> Are the latter 4 patches thus also intended as hotfix for 6.12, or was it
> just due to git applying the same PATCH prefix to the whole series, and the
> real intention is 6.13?

They are intended as they are in the same vein, so one could argue we
should hotfix that and be done with it... but at the same time I realise
it's a bit of a stretch so I'm happy to split the last four patches for
6.13.

The issue is expressing that the the last 4 have a dependency on the first
4 and this not getting lost in the mix...

To be clear though, the first 4 do very much _have_ to be hotfixes and ones
which are backported to stable.

Andrew - we can do whatever makes sense to you here.

Thanks!

>
> > Lorenzo Stoakes (8):
> >   mm: avoid unsafe VMA hook invocation when error arises on mmap hook
> >   mm: unconditionally close VMAs on error
> >   mm: refactor map_deny_write_exec()
> >   mm: resolve faulty mmap_region() error path behaviour
> >   tools: testing: add additional vma_internal.h stubs
> >   mm: insolate mmap internal logic to mm/vma.c
> >   mm: refactor __mmap_region()
> >   mm: do not attempt second merge for file-backed VMAs
> >
> >  include/linux/mman.h             |  21 +-
> >  mm/internal.h                    |  44 ++++
> >  mm/mmap.c                        | 262 ++------------------
> >  mm/mprotect.c                    |   2 +-
> >  mm/nommu.c                       |   7 +-
> >  mm/vma.c                         | 403 ++++++++++++++++++++++++++++++-
> >  mm/vma.h                         | 101 +-------
> >  mm/vma_internal.h                |   5 +
> >  tools/testing/vma/vma_internal.h | 106 +++++++-
> >  9 files changed, 591 insertions(+), 360 deletions(-)
> >
> > --
> > 2.47.0
>

