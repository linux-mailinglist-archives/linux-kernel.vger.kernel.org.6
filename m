Return-Path: <linux-kernel+bounces-249285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2492E972
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1FC1C21764
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404A215F301;
	Thu, 11 Jul 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D8tMlV4u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JtlRWkIb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC715EFD0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704294; cv=fail; b=TgtN1ehFV65/z3UmBgAr9NG6jHfCWPvOPAyuO1IdNGyVsR6H+C9G69tZSxZXP3WXA/QGQUe0kcfMn0dav/8jvHkqUQ3liRML+8gT/ldMlRm1LuHWX8n5Xw6MWpElQ5XMs16uthMwo6mfyexxH0HXiL9taXKzfBdhFhzTPfd43Us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704294; c=relaxed/simple;
	bh=35c1K+a8qvIuL7ydath1IByzK8UYxpyGLse++8DQld8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a5AXZfwgdYh7CPzqc2EXfQLE2umZJHC0ESYzRyRtFCrGtjTxDMtX5WVxbnuNRe3qK+pJsgAcVtOGR56J7Yo4911t6trTAHcBPUdNXG0UKTs88qjN2V4rhPdJabcbuYPvmDhsgTGbnTYsdetoL+ixqvxZm48e89uH/Ni0UzP3jTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D8tMlV4u; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JtlRWkIb reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tVEp014041;
	Thu, 11 Jul 2024 13:22:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=trfICxhxb/7HjybX7vKD9l4rCP/Mr3XJTPQlAU8/890=; b=
	D8tMlV4ukxl/zS33tTlV/FpVLcbLlzKxX3jk3OAkxxJtUWPWoLEW6FBO629Uh1SK
	MXlmrxianDqocqZsJ0fjiqDdaR/ZO2RZ73l9ePQveSZ21lI8fud0h7xBXPRbNIWs
	38Ug1GFioDZ3dHRL8ypZgARNs35XnfmNcgYTpnS7Jh3eggE/BjYIz506d58orcPB
	vsUSNvP6w5kXMyEAqqXsezULVdA6lUP1kml0nSMX9DaDxK8x9jIRsxUjF/459BLS
	KY/wqCxJbXf2BGWXTI6jqaoSg/uDh5tOAH2nNTCQTV+e6yHhUUuJAtWwNo1EUVjG
	DaXNZ5BhCLlTfMmsOFdUvA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkchh6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:22:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BCZ1ps008951;
	Thu, 11 Jul 2024 13:22:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4hw71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:22:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO6vP7q4AirhmG8mTpKd+FGU4azO+Fvs2qr3pkpfuDGk6cmb2otmZAUd20LFZyX3I25lukc2WGepbp47Emi9EdioeH4i1UAZ5KatuSZm+9G7m5Sy9S7VuPsOlZ+2vrADuWmB+JZEYXzFOkd7HPhs0+/EK7cVdTE7tNVa/P3Ylbj8CYIMrIcwru7E2HuDC1pdgURya2IByniWZZokSF14nefziX4QcOZX8u1FLsEh2acohFwD6duHvRAzrCPKdaz66iRez45yIfpYj9QXbe5h229rM+YOhjZZAmGJ8HGKX2Q+5y3Di1wtx9Jue+x/Q6kR+o4wVmASAxorfPmDYpRxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrF356xzEcsOHaO6HsbLiDCucWt+la5oghdym6XNn+4=;
 b=TArD1Dhg14allJYwYeTvD8SE2QTsxmEGX+Mn5VoSSZu3W6XtWVZDFwE2DW2ylLvznxmX81ZXWaOMPtOACLmSWlqJsHW0eAsG+wTzdYcnnES2RAEOTUrJ9mJBH89ZuGwM1/OjRmNWdW8cgboOz3MVdIAJtBzZLnUpFUs83w0vqNvfRwzHGy7G8A56vT2m3N5LXDX4oO93/ZQGKH8yrPBfsOiGUZffrXrF/Ls5dafQUGKNaUiFohGAaYQkuar0Y3Og48peAlB9IT/XgLMIEGSkFBphgJ7ERL+EgdRMiTlPCi/45XT2mmI8qt1TWo8/lv5yO22Ww8ykExzgLXrWBp6ovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrF356xzEcsOHaO6HsbLiDCucWt+la5oghdym6XNn+4=;
 b=JtlRWkIbOKLtNhynfIPA69ZhkkqEfjlBRUuK1kQN993LAENi2vrPep759nnQYTg/KwV3bDdG6vIH77fMNtFg5Eys9LyRG0u4bj38rQfw4Fljg+6J2ySrzR+I1Nxrs0A53Pecq+JsQIX/kHQT9jfNxBFCirUhfutTvWJmkv/W1Y0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7575.namprd10.prod.outlook.com (2603:10b6:610:167::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 13:22:06 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 13:22:06 +0000
Date: Thu, 11 Jul 2024 14:22:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Haoran Jiang <jianghaoran@kylinos.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org
Subject: Re: [PATCH] mm/mmap: Align the length parameter of munmap with
 hugepage size
Message-ID: <78dc63c8-009f-4b7c-b0aa-0a044b8a3120@lucifer.local>
References: <20240710054558.1959243-1-jianghaoran@kylinos.cn>
 <96c9fe70-f787-42e2-b2e7-4ccad0d2e805@lucifer.local>
 <e913863b2d54d69a19cb278e4c25377fabeb1963.camel@kylinos.cn>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e913863b2d54d69a19cb278e4c25377fabeb1963.camel@kylinos.cn>
X-ClientProxiedBy: LO2P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::32) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d8388f-3631-4885-a5f6-08dca1ac75e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?iso-8859-1?Q?kd0sJtUm8S8yiWBXZTPDm3h0XZZLKXzQd5lfe1IfbHg+Q50/cHoPHd/diS?=
 =?iso-8859-1?Q?J0crkcL4KFk9a67IZWVUcUg4kuQWxqg32UlZ0V8S/SBwEOvPhJhnHKDo4Q?=
 =?iso-8859-1?Q?mOEQsZ6ojYKFWI2m6hi6eK+PSXC8wDbmEjFJV5z38u145j08omI0a0Vjra?=
 =?iso-8859-1?Q?FpA4wEgHvfO7Gbq6Bnc9pOp2DrE/Dm+qzGL/GVk2HARSJpH8zldY27Fr9X?=
 =?iso-8859-1?Q?qQsdhEqQPi/hnTmrim3X1QOt+aAVwAhMb5WJuANNDfeHBvmz+UGj1rsr5t?=
 =?iso-8859-1?Q?oAaDjPMNHwUdf2sMyZy9EO55XmkfxiC4tfUS+ARmH6t6xv0EH+SaMNIRCa?=
 =?iso-8859-1?Q?pOn2f3Cg9pUfhtmTG/RDmHcChmsXuso5GwsfFtCnq3WEfEO5ghFIfk9yFb?=
 =?iso-8859-1?Q?Ex8uNPzrKlBf4l+NmPWdA4vpFya65UFQE6p/TPCIAoOsf9MhfCbC/IO/K6?=
 =?iso-8859-1?Q?asbYqHOqePmBWB5fYk8Tqc4+CrQQoJc5fWJ548Stx+zUlU0wShazkyEAhJ?=
 =?iso-8859-1?Q?Dfo5ZibiUmrmkXVrcmNcpBp+2M1zuHktAK+2ATkmGGIQxflZyMFoiw/d8l?=
 =?iso-8859-1?Q?95oM/ok7SER4aytJWb4s/KDxMNoqF7MQTy7PWb4EuyqIsx40fJ3DQLX0Al?=
 =?iso-8859-1?Q?B6Rx/Z/b10jtjbeWQkhm+TK85GWqvaIpNUspYTW01OWUvQpFzupy6z3glO?=
 =?iso-8859-1?Q?iKSbSgvX7vNuU0dhkcKXK8uOI6u+fgh1rhlNCgDZqWm0eDaCgVyNFdr6Po?=
 =?iso-8859-1?Q?9CK7WAbowT5JlpSi8Ez9TUg4BB3msZ5fGzuEzjL58LSG2NrLVdVtBPPtnY?=
 =?iso-8859-1?Q?idWY52Q9dkuyia9zTaTLE3R3b/11Ex/SX0BYLb3c4bmQnKCgArXhHN4HyO?=
 =?iso-8859-1?Q?Rt/04YiDo77Yh8XBQilIeV0TrVT57j77fHnNZUTSL4tGtCjQYVgoWZ9rxA?=
 =?iso-8859-1?Q?148NJUG84suXpUcgTBP12g+qWtPzmlIDQq+q5wRwfB6lvrpXrrrFHw9BzC?=
 =?iso-8859-1?Q?RJnTE2SOmFz2zpCK63AG8/CXNAyrUBPbtzYCfqMxLyHwZ8NiXKAGwkQCce?=
 =?iso-8859-1?Q?n+yrUOF9+AVSGelZVk4CD0DkRonsYo9pCYcQK9JgRuKl14h0Z8v7je/eAQ?=
 =?iso-8859-1?Q?I45q81rEVk9A5jHk/p/M5REQILd6EF+CVegf0t5wi9NePHv7nUcsuUzk3I?=
 =?iso-8859-1?Q?4k+dwUgZqpfjghCZf2n0xW2fJ4xS8JsKe0eTpbNiVOrgok7h5Vv2Er+Su+?=
 =?iso-8859-1?Q?A+eyTmZlO7viprYCWBqlhR6FukVJTCND174i4c9rYI4W7Vgz6zCBL9IXlf?=
 =?iso-8859-1?Q?ki783grX+KdbQ6DzaZiFSCUxkMZjcnVRYelDKbHc5io0zit0xJqiaJXSXd?=
 =?iso-8859-1?Q?hksY6A/WeZ0laVQlVhrpYt11HZvEfGGQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?67naSSmD0ermQ4ak0qtYaqE9pjZIKo4NRTiylgcXGNjxB3kP3DWz+0dBkS?=
 =?iso-8859-1?Q?il/RsBCAfKLskQrjVFkeN/5KMdIaicXDDNXFVP9u37cSIY5m+I5SrLqut6?=
 =?iso-8859-1?Q?yd/27vKk05ehoP4f9jBUs9hkh+cIU0zh3I1gjHiCjSDS4SgztDgMFYr4zU?=
 =?iso-8859-1?Q?32NAFdOLQiwCCq/501irYkFKzuSjrNUSocX5bWyb9BslXjmoEfK1VFX6vz?=
 =?iso-8859-1?Q?SMsgPYMOBa70/wGH2QrFG5Oele7DG14SjBZdhfe7XKihhoCk5sA3rErVmx?=
 =?iso-8859-1?Q?eUwX+WouAcTzheHM8HmPb1v6iTQpdGws9t/ua+fZBiw1gH3W8ojWY1Ur08?=
 =?iso-8859-1?Q?mg/3ukInY54qwOCz99s5fU3vqGlkzQaqQP7hdrwXY1k+wySU5okwdnVJhS?=
 =?iso-8859-1?Q?t7jOubry2XYS5Q7b/YQEEb+YhieM/R+uJ3b7XrrAAIITw8hhUulHOlyH5B?=
 =?iso-8859-1?Q?MyNwddWcfyVBIkSfA/rcTfgNYGHvBwkt+z58gHBIxt05PxvnQgGp3crLHe?=
 =?iso-8859-1?Q?cUWJ4oP7JpAJ8HhVWhtU5y4Uw7ok9b8rOiWtMM7gJoEvK2G8gVh/uA/4xS?=
 =?iso-8859-1?Q?D/iOitXB3MrCtUUyqu2bYb/G4BXiozYigrtalZjYOMlfeb1HA+stn+FgV4?=
 =?iso-8859-1?Q?638vnJKsdJEFBUZ3uNY7AyzEcMni8INTF80rlOwI758P5B0srMITDw6bHs?=
 =?iso-8859-1?Q?X9mdIpiUNDFh5mVzjBPpSjM7P+J93NG30FFUufZgkiOlUC6GzU3sJmAuz2?=
 =?iso-8859-1?Q?rpYvZsiXXeJ9+iL1lfqAKvnIojUcb4Mt499iu5cTL+CUbb6i72r/aWar2Y?=
 =?iso-8859-1?Q?OZNLa+LIE1lHqI2lW5JdxZ/bhUpDC9MeDR0NyksVi21lyD0MaaB9ZPOF5W?=
 =?iso-8859-1?Q?XwI20F7Z34auwpBbm7Ob0EFnHO/U9HAqK3rQYG/397tB6/rRnHNwXlPEkw?=
 =?iso-8859-1?Q?ens5PQLjihHnKSecBt1trWvWA5B/V87VTSFPXiHP6wjS4aPerqXkGxnbeY?=
 =?iso-8859-1?Q?ZJlz5EIZzYrKo3OFw4uHJH5bUJfT3ZnJpm0dQIGmjfbCslbdXK/aX0ZJGr?=
 =?iso-8859-1?Q?vwCFezFp6UaJ5VMzMAODFxukDHG+LkIgp3ZWkJDYQwriPARfwjMqEmJjoV?=
 =?iso-8859-1?Q?5RLlIwCRvT4EA45qnGVkjf/JS4iFnSuDWlqA7es1LlNECWQVSfykSKrzlR?=
 =?iso-8859-1?Q?4XeuMZ+jXG5oVa2s/h12K06X2DOGIJ5yowRYhf7AolgQzenGWgqwcOBWAo?=
 =?iso-8859-1?Q?vPRJbqY5hlUw3A/vUaVnUP4HtebECNzRZ2583Shlf6j3lH5mQKnudA9gOd?=
 =?iso-8859-1?Q?I2U6VBZAXIq1mw9IvS2klYCbKctZLs/LpqhQXwB7JL6k3+SDS26amue3SZ?=
 =?iso-8859-1?Q?Sm3J+6Gk4zHNkak6ovyLoqQ55BNtPyWOeXW+EGGerO3LkQdfExDZztSSWU?=
 =?iso-8859-1?Q?Cyj45srDkQoWBJPeU8Eg6LN1qJsyNVsuYAU/OhqtGdVlaCzdFwD+tZDPdw?=
 =?iso-8859-1?Q?cpMeJNkaskcNl2Y4k99OU9jezm2/wNZHa65aqCxA1+k/MaEVkWlu3Zvmj6?=
 =?iso-8859-1?Q?3SvRb3pM4btC/0vjAdj4tuRn9hgIMHpA1kuge2p5PKv8/6ZeINMeyJ0XSe?=
 =?iso-8859-1?Q?7VlL3xJ+Nz/scoXVQDj7TTw1t1ROQAU7w3WcgAGnimo5Ad0s7Q/rSlr2RN?=
 =?iso-8859-1?Q?M1N37ZijxTlGn49trFCVE5HunbkOTtixU9tup+dc5S+ZXwn88+/LIVJ3aK?=
 =?iso-8859-1?Q?oFbA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2MMOEfQ3WCtu2DhkrEC+Ue3cC3zRk9ChKwI/WAx8qRa7NE2zRnDJb5pZLBWJp8EQZ2s5oXAVGPSsdtJLTiawXRmwzS8rZCxp8msbfbX/2MKyV724TIp0MPzcoG/0LcwdSce0jUoyjcyHcZvWWXD0pxaukThQdgOP5V1VZiPqBTAabOQJzZoHGvPC36VwqhfKSSR12ZRiPXPBZgdkbKpU+NXAjgaGCKF6OKj6LkYCECFbj9P9QkpK4qIQ14imRrfeL9RAutnLS6mDSCYz/3tm9+vmAgaRLuWCLE0P/H2nOVIBvYnpl/h2r2IqB3kOBEwS4ob4V3GRsV0Sw7cbVcUdJs6IGDODFVxuUZqB2Nrm4/9zH5H8Hna9+zG06l0su+eshlF97Aui4eCvmL9WFxVubV6OS54cpwTvjVP6kN6PENEGybjbtXyqYM3t/3zdFu2ZyjBgxwxovoXeAQ6xeF/h8OM0MriMnrgBC026x2b1oBwqy78qToebelZgTW/Y8Oxf6j6EQlQ/k3fGCDmV3qbXh5YYGPtFKE0I8ZcFEODInKF5a8Meu/Oo2PvaHPIt/T74nBWzgyBD3ClsgEIS0CTMzYUfRaCG038WnxQtNglEXyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d8388f-3631-4885-a5f6-08dca1ac75e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 13:22:06.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywi9q3TDp1r05To9dN3UlNEdzuKeu9rwPsCOtV0IzP8Rg3X8thX3KLl90/5fE3fs49OB2Ab+efa+whx00Mc0c6AObMNJGNUwp7/o6SmisIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110094
X-Proofpoint-ORIG-GUID: dcH4LOZVgE9SgRT2aVvwTVYBARon4vMH
X-Proofpoint-GUID: dcH4LOZVgE9SgRT2aVvwTVYBARon4vMH

On Thu, Jul 11, 2024 at 07:32:23PM GMT, Haoran Jiang wrote:
> On Wed, 2024-07-10 at 09:24 +0100, Lorenzo Stoakes wrote:
> > On Wed, Jul 10, 2024 at 01:45:58PM GMT, Haoran Jang wrote:
> > > From: Haoran Jiang <jianghaoran@kylinos.cn>
> > >
> > > munmap hugepge mappings, if the length of the range to munmap
> > > is not aligned with hugepage size,munmap will fail.
> > > In the hugetlb_vm_op_split function, an error will be returned
> > > if startaddr+len is not hugepage size aligned.
> > >
> > > before this patch:
> > > in "tools/testing/selftests/mm/hugepage-mremap.c"
> > > modify DEFAULT_LENGTH_MB to 3M,compile and run,
> > > the following error message is displayed
> > >
> > > -------------------------
> > > running ./hugepage-mremap
> > > -------------------------
> > > TAP version 13
> > > 1..1
> > > Map haddr: Returned address is 0x7eaa40000000
> > > Map daddr: Returned address is 0x7daa40000000
> > > Map vaddr: Returned address is 0x7faa40000000
> > > Address returned by mmap() = 0x7cb34b000000
> > > Mremap: Returned address is 0x7faa40000000
> > > First hex is 0
> > > First hex is 3020100
> > > Bail out! mremap: Expected failure, but call succeeded
> > >
> > > Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> > > ---
> > >  mm/mmap.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 83b4682ec85c..0b3a60bf9b6f 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2733,7 +2733,15 @@ int do_vmi_munmap(struct vma_iterator *vmi,
> > > struct mm_struct *mm,
> > >  	if ((offset_in_page(start)) || start > TASK_SIZE || len >
> > > TASK_SIZE-start)
> > >  		return -EINVAL;
> > >
> > > -	end = start + PAGE_ALIGN(len);
> > > +	vma = find_vma(mm, start);
> > > +	if (!vma) {
> > > +		if (unlock)
> > > +			mmap_write_unlock(mm);
> > > +		return 0;
> > > +	}
> >
> > I really don't like this, firstly we're duplicating the VMA lookup
> > (we
> > vma_find() below), and we fail to use the iterator here, and also we
> > are
> > duplicating the unlock logic.
> >
> > Also the semantics seem wrong, we are looking for a VMA that ends at
> > or
> > after start, so you're just checking to see if start is past the last
> > VMA
> > in the mm aren't you?
> >
> > This doesn't seem to be accomplishing anything too useful, unless I'm
> > missing something?
> >
> > > +
> > > +	end = start + ALIGN(len, vma_kernel_pagesize(vma));
> > > +
> >
> > This seems to be the 'action' part of the change, but I'm concerned
> > this is
> > completely broken, because you're using the result of find_vma()
> > passed
> > into vma_kernel_pagesize() which could find a VMA _after_ the input
> > range,
> > and end up unmapping a far wider range...
> >
> > I'm also wondering if we should be doing some hugetlb-specific logic
> > here,
> > or whether that belongs elsewhere?
> >
> > Liam can chime in on that.
> >
> > >  	if (end == start)
> > >  		return -EINVAL;
> > >
> > > --
> > > 2.43.0
> > >
> 1, While performing an MMAP operation,The length aligned with hugepage
> size.
>
> unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
> 			      unsigned long prot, unsigned long flags,
> 			      unsigned long fd, unsigned long pgoff)
> {
>     ...
>     if (is_file_hugepages(file)) {
> 	len = ALIGN(len, huge_page_size(hstate_file(file)));
>     ...
> }
>
> 2,During the munmap, do_vmi_align_munmap->__split_vma(vmi, next, end,
> 0)->hugetlb_vm_op_split.It will determine whether the end address is
> aligned with  hugepage size, and if the end address is not aligned,
> return fail. Is there expect the application to align the length?
>
>  hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
>  {
>  	if (addr & ~(huge_page_mask(hstate_vma(vma))))
> 		return -EINVAL;
>
>  }
>
> 3,Or after the vma_find (vmi, end), recalculate the end address ?
>
> ex:
> vma = vma_find(vmi, end);
> ...
> if (is_vm_hugetlb_page(vma))
> {
> 	hugepage_size = huge_page_size(hstate_vma(vma));
> 	end = start + ALIGN(len, hugepage_size);
> }

I'm confused as to what you're saying here? I'm addressing your original
patch, which was flawed in that it could end up unmapping the incorrect
VMA.

I guess you're basically asking whether generally we expect applications to
be aligned to huge page size?

According to the man page:


   Huge page (Huge TLB) mappings

       For mappings that employ huge pages, the requirements for the
       arguments of mmap() and munmap() differ somewhat from the
       requirements for mappings that use the native system page size.

       For mmap(), offset must be a multiple of the underlying huge page
       size.  The system automatically aligns length to be a multiple of
       the underlying huge page size.

       For munmap(), addr, and length must both be a multiple of the
       underlying huge page size.


So yeah, I think this kills this patch unfortunately. This is expected
behaviour and your adjustment of the test is invalid.

I do understand why you wanted to adjust this though, but it seems that we
explicitly want this behaviour, so sorry about that, but thank you for
taking a look at this regardless! :)

I would suggest that it's probably a product of there being quite a large
difference between rounding up to base page size (which is expected and
customary for these kinds of operations) vs. treating a 1 byte length as
meaning you want to free, for instance, 2 MiB of data.

Equally, it would otherwise cause some confusion around THP pages which are
huge but can be split.

So sadly I think this is a nack for the patch/concept.

