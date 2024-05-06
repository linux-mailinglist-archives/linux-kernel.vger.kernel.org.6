Return-Path: <linux-kernel+bounces-169991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F9D8BD04A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB221C21C8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733BE13D287;
	Mon,  6 May 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f3ZdkM5j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pxo+GxFG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3AE12AAD6;
	Mon,  6 May 2024 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005779; cv=fail; b=iDbLb9paZ5MFDajJCCXVOWb2ufW/Iyg8J84NEJczactpQUW89jy9OWVNwKuKlxHo5zXqrnbLjjbOVb/d3adS6bUq7ZUlzL8c3jIhrhKQINmm1uW4KCXcnxmeUqAjYrGSrZt8ZGgxh/dMFsV1sXCvlMKZiIS/84lNid0cEKWeQ7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005779; c=relaxed/simple;
	bh=WSHCXieK4A//OzLZdT3c6ghLjtpXpk0Fg3yc/42aeto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Iyz3mGSfitcG5yvhSJJJ9+BpGpVBRykVjaTSJwKvlVnyazP9fjtmzluB/OS9YqVrOIDWaqJLDiPU6CtkpmTYpSLIHXXB1gPGy//45bMCbIs7lmXjLPSxeIv562/cadtL/tqJY4IC7hHFtjlJ5q2ZDJY8Gn1QPhfBxtMnGVwFOYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f3ZdkM5j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pxo+GxFG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446ApPp4007369;
	Mon, 6 May 2024 14:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=CToBfp7tSVAtvG88uVFtia9O1uN5Klls8NBHFUVdCqw=;
 b=f3ZdkM5jsZcyUE2p0YbniNWHoaNFoqPg9oQh62Ty70PxbXWGbxwHzjK/+L8VGeGRZyrU
 JCKsUCnKT8IPM8TVozTDJmJx+fPYWWAtF7OREXiBrih7Aw800aqjkO2BfS1Zrofp391G
 yoG/VdniaJRdh8LU6qW5z7B/EcqxzEi2xFJcTJ/LJ7C8XMleC+I+tbFjbiWZcexApMKc
 QLuPHRCTh34kwqhw8QDSIZZ83F4t6qbzsupiYyM4/yqILJRd0n68mXPhyU9nHHUzJSTV
 SJ5PRi9vK8elmYdjV8RnVu67fu1TIyM3Sil3dmRozFW3R96ZtVRWrIUgq2t3JgwYs3Mk Mg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcwbtpw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:29:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446ELjeG029231;
	Mon, 6 May 2024 14:29:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfbxey8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:29:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Twqcf84oSD9XIoH9DPINWBeAUGpj+9yxZmLS7hoDK79fJHsNq1HRwy3rbmmP2B9TGGyl4Xy/fdQdmM6/tviubm4kFcN+a/YCxt6Mhm7LuSj1el2kq8dWOo5HTjtFYz2QMUO5fqiofm801PCOgvwHMydYZNGhA3HAugLF35gLVWEY6NfundjTZDaJzU6wXpCkp+768z+wXxh50MOrxq/rJGrTHMb++Vx2vKlNnFV4xtwgzurCyP2WUprPmjPQd9GviQPW83wD1Gc15tW8+STYow/9Jj3uhUHFeyKL0rg5yhoJHIG/u3I12aqcSbqvkX0/2PQToSiyA0F0Z1JP7tPkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CToBfp7tSVAtvG88uVFtia9O1uN5Klls8NBHFUVdCqw=;
 b=iGeMDgHenrwRfJ+8939BSAClx/MuJ77uP3lLMSXq3w4lEYGnpwwsw+gxgnoXW8yJi9R5P5sRyk0xIu5Bh3RdkNWcGALVptFW77HV1uHI75eJVQDyXV6px1fn8eT6JnjWY3DZ074yGrxCZ0i5nV4CanVG7afWwi8lYoCLhN5048k43nXlofohYyAq2WmJfVuAKdAUM1NuQ0WN8m7ds7g+M+hAlHGqUrDn+LIpXM8QxRb9JQW4VC4snFu9WCI1O8BGvs9Nx/6fP2N/3p+kB2T+ntO05ugpdX4fqXl8FRtb00sAXmfIo5mxCTgeBke+ljsFj7+6nrno87Dh2OcKkAe3Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CToBfp7tSVAtvG88uVFtia9O1uN5Klls8NBHFUVdCqw=;
 b=Pxo+GxFGDQo9mzqR+Ha4/4W8QITEu5X4VO4srsx3Qt848uEAciaxJnzGDggDiiqHKP6+am55MntHGDs66hTWC5wXTeWRghnk7HGukYCwITcXN2ALyAigzvztBzpcGBLKdLR/m/b94HMKJZjq2oAUZjAmvDrT+64na41LbwxO3z4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB7515.namprd10.prod.outlook.com (2603:10b6:208:450::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:29:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:29:11 +0000
Date: Mon, 6 May 2024 10:29:09 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kuan-Wei Chiu <visitorckw@gmail.com>, ndesaulniers@google.com,
        morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] maple_tree: Fix build failure with W=1 and LLVM=1
Message-ID: <u27qo2hnypvnziv36gdzs3eta76t4ia2sjxj7j7fhll3icljng@doeeizsosli2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Kuan-Wei Chiu <visitorckw@gmail.com>, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, llvm@lists.linux.dev, jserv@ccns.ncku.edu.tw
References: <20240503095027.747838-1-visitorckw@gmail.com>
 <ZjTWkM9hTnoIhzqV@casper.infradead.org>
 <ZjTgEsuxYF29AVFJ@visitorckw-System-Product-Name>
 <ZjTmqM4ePSZgSt9_@casper.infradead.org>
 <20240503160821.GB3960118@thelio-3990X>
 <20240504160257.02e20addebc407cb4a18da48@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504160257.02e20addebc407cb4a18da48@linux-foundation.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0475.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 40955c2e-72da-4315-bc24-08dc6dd8e5e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XwHgqyZ+z8I0qmejg6FlI7QmLOvbTjcfMUyq9jAFK7iwxG55S5PmFSHVP/SS?=
 =?us-ascii?Q?FU9Vf11BTJX2VYn84C7YDaDuyzjTgP3qwskjPyMq/FNP8NGq7i8XBXXJ2FBm?=
 =?us-ascii?Q?9NyU/ZlQtR+jx/4Fg8jWfwqwXgWdbvzHsJXyGDL/NZbzoTG+NLGl8uCMYL8g?=
 =?us-ascii?Q?tDgShzhcUn6jZoQifYn+D8abjzdkHhxf4/kDJruBt6IpxNw9N54kt214+WjU?=
 =?us-ascii?Q?5Dbrbesuf6G63MAkq8xMaRQShK4oOwJBYJ8DzsFLdQUuhFI9M/0eN4WKx8Cp?=
 =?us-ascii?Q?JgyIEJwFTRXe+NTG94NUEuDQfjFCBEajJbf+adxTf6TOixj6yzafuQMO8aqM?=
 =?us-ascii?Q?01lPp0GnKV5G5JCKdT3bqCNeNPzT5V+O723jc9PJAh1FANWwlKIj6RQC6Hio?=
 =?us-ascii?Q?kyBaZC0tEH55f8UANWt5AhQsvJ3WsNt65dkEgtTtRNwpPJQYUacJWP0moPqT?=
 =?us-ascii?Q?mpR5Igo1OODEkRBHg4hxPQ+a/cf3iOCe4XWr5/nr0VnY7zVDQvzsmdN3UQLJ?=
 =?us-ascii?Q?BKFPo7jEPSBIuo4r6j823xzvJ0rNBvEMzZ3PIT6hReOrBVT0cC0v4M3+uii5?=
 =?us-ascii?Q?KgVGVpQXkq9izcA38t4NMiP1iEpH4vOYVL0F3fcbAbnm5jq4nmKNyXi1gnrt?=
 =?us-ascii?Q?/wHHOq/kMuzIf3739pAvbmuZffF+0Zw5UaFauoVQUa14/Eu0DAnQIXOW3bmW?=
 =?us-ascii?Q?anBkSEruvdsw8R3pN1h0tyYasDDQtnf16ExgFaarI49HxJ/ASnqmDoxAjOc2?=
 =?us-ascii?Q?/OlIQEifiJWjuH++njxnWvPaRP4npNZb60krZduUgiW7zJa7PTShk3Yezrb7?=
 =?us-ascii?Q?fMt0/f5mxh/a7XAGrUMjqfYywEKIWEvcrcIrT+vijX0X1A+jIXHhmebipT+Y?=
 =?us-ascii?Q?AXJJeYw7ylHBLbPxW/eHnf17kR+WynikpflDm/mgVICBdEQy2B6HANYlWgrN?=
 =?us-ascii?Q?SVqF3qncrNoUwWwZK0WUSvF1K2SKksAf3qAEYj1isbGJm8u2BUwbTzjTLYQY?=
 =?us-ascii?Q?fufMImhU+TmiMnr4rplPcFDbkm/sbvQllR11ady+6wSlEEDVS25+4MKWcztX?=
 =?us-ascii?Q?7bzlL1ftHQsVZS+tBvniCTZ/UUeoU030xD5tzEVvuepmNHiL9ebIjjmJBYjy?=
 =?us-ascii?Q?DmbMTIF9wOCGi/DFpwm92BRAYsRStd8ft0O3ECUWUo3aIuB8lVbMOxNNPR9P?=
 =?us-ascii?Q?B/nfJaX0Dz2ckF37Mh4MYGs3YfutEBLd9kSjgvV5tClDhTMQdH8nFljj4Qc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2ZdQgdX128TamPr+3T0cYPNq/5irukO3hD30LH/DVlDcW8Q2jdWxdfG5lJfH?=
 =?us-ascii?Q?W0eQZvF2whO/Fw7l674Q+X3AUWIXnOSqJSPffSK9NOr+udcU2IuCJZ/kxD9y?=
 =?us-ascii?Q?tbDmx4FGG656YqGm1VvLz6jyWFfk6tEB8iQlDg+jzLelgAqHImYqJFrq5oj3?=
 =?us-ascii?Q?Y2V93K3CR9M1BBhqSw6kzjP4boHMrs04e4y1VZmqJaD/PGW4z/3NSsl5AHmN?=
 =?us-ascii?Q?gKnd2a3ph8jwL3r7XqVY9mHqa1OCLezVORNqH86oVYliRZVfk6cadMcsbXxV?=
 =?us-ascii?Q?2Dh4/yeG8gsib8DmOL1CGbpwU3Ct9lHhv7WpvRZJ5nneLrbZ+oG8ljhv8GwX?=
 =?us-ascii?Q?dM8ZKLYGXQmE1DIuRcz/aLXzcybZml8beMjZQXubUl+zE8hB38GCDfL1YiTq?=
 =?us-ascii?Q?UrjPKYfqaDi8zAplX79YwLPgWJQ6v6UvYw8e8YEFsJ3f1vYy45swCmOr60Fd?=
 =?us-ascii?Q?/hfAbhd7gfFM+p3eCtFtinD3pqtWxhWuQUd1SjWvbzLj0XJ8o7XpAhsI5VIf?=
 =?us-ascii?Q?+my7+h0+q0W4FwMZR1FZkLQUTvaijtKYJ+BfcS0JnegDHRBxCmMeGvUuSy/o?=
 =?us-ascii?Q?clDLtPfR3A/GVmD6qucjmPrzrYUGju/7k7lTLPYMat88lKgPe/5JORar3xOy?=
 =?us-ascii?Q?y8KN0PPKOaJmW5fPElmKITutCIyPGT4hANFU4VFAJfX5uCHK25/8k6Tk1p81?=
 =?us-ascii?Q?gWvL76IKEXqFBWbjZhnLwlMNuYzkWRpPTqUtAtbpcJBuQeRoUCEGPhCzzO+p?=
 =?us-ascii?Q?5Aoq1xMAHEGmHU+1/5jrtFii1QUEn2UPoH6uGoiRX0xTVCneIhGu3foPOxVF?=
 =?us-ascii?Q?oWqLjNQV5NO+E03RvaKUY8XCnlqOMGlXT1xfvO+JhrnqPEY16tKtYt6ybq44?=
 =?us-ascii?Q?QmzVl/T0K2hhbIQC5qs6mxEpC1YDLcHK7mmXugLSdk8qUJtALtdiJj59XnuU?=
 =?us-ascii?Q?irIPMPHuSiR9TLHhcjXTD5ukcFvyJyQll6ISaJUniuQhKAfGmUmOyHWDsSPk?=
 =?us-ascii?Q?MxSPwDSl3YIkADRpUtb2BgXtfuThD9d22cGAH9R77scZz5cPtWdpEJj2MiDc?=
 =?us-ascii?Q?bf9yfUjMkozyYCU2jSxeddWGfGqkyoE3R1opGYD+d9w5aSK4SHJxCn1mxRTp?=
 =?us-ascii?Q?AwopwNU8VMa6LxL2kp9aqEV8f7dNZrPfcHIbdtkf8o21ul0atL/XEM94fhU1?=
 =?us-ascii?Q?zRv6tB3vtvX88TNSL0thR2NQiqh/oeaKm0pvXw4R+7zDejhrsc55lRuv5Ihd?=
 =?us-ascii?Q?gvogYkiFUZBpQhHavAiBSzxorzK28ejZIgvWFkROamBc9gmO5eWrhEikkNJ/?=
 =?us-ascii?Q?BSLbQ5bqnkXcO2dnbPltmYipiE8/2vJld8BBe0qZRocs0ghUcMSPsA06nNTh?=
 =?us-ascii?Q?tfWU8+BCbFTQmpwAfb+ENH+86vFV5C4hLRcrSut5NLiMXRLozxNLsTxJlZOl?=
 =?us-ascii?Q?+n/hoQ8n4w2bEtOwtPH7axv/nDZWCtvPPdCCQDR0Y9dg+dQTREZFpwXObuqi?=
 =?us-ascii?Q?HOG3mJ0aEW5FLiGuYtGEGpLZzx5hw6sJ5c00Q88qd1QqKEYgx0fP9et2Lpum?=
 =?us-ascii?Q?UYpu3GQHAr4cCcvxkcUcXWjZQVldtsB3kDHsh+Ig?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XfSFJuDJHlJVimJUfegfjsyGGxnPLu4+jJ9tYjutTRNqlAkIHG9pPgXHSSl7IAevmLKumWkqc6iqi6j6qeqlmwHmC/osSfnLI4ks694peWX3yoTNYeuAy1UmzuZi4XhUDNGFZJfzuUHgJtar3Wzy4BsP/l998kLA5380QL3BfTI+GEpph5iwwXXvOV7RyE4/ALKEaytXFl6eq2ZWW95vGrwvvdMzE+aCgV/k1aGrv51NjOIRB9EVXveOf9CGuCxKoUS7L8gUTk9cs7+HSDOVeajeNgc1LAhCI4rGQi9fPi5mhMxu7rQ0eqlOsgqyC9AhpG0ZyZmsNS3R1PxAiS0NM+Lj/5TI2U5wys8xpAdCf6QoWywNvCU6cQ3NfAhiU+KXst+HoCZ+rOeFdKeUVaw7DKW2iFOCWPTS+alawD6Ti9ewO2LlFbR18xv8qXtp4Co5hfPLHro+uz5ELZghVKVAdBhVBZjt6I9WM7N6qzrnIQu2CmoJAz+9/tEpKsHcILR1u172oRYEnv3bx6a00OsaMARfjwY8NoH7Y2cSWkL1TWd+Cl5Fq/MJYaoO1MJ54w9KOvaZqaXDdFqj/x8J3mXPBSohCnPU47mg2+aKcGKZxnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40955c2e-72da-4315-bc24-08dc6dd8e5e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:29:11.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHb5F8O39UoCIKPwU4dhEC23uUYJPnT+QOadisWkT5tn0RW/WHH5yntxS533eiAFNrMVYye7Dl1H6PSgnocZRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060100
X-Proofpoint-GUID: sgAY-O0Mtt451V0vrpueEfvvrOaVbN9A
X-Proofpoint-ORIG-GUID: sgAY-O0Mtt451V0vrpueEfvvrOaVbN9A

* Andrew Morton <akpm@linux-foundation.org> [240504 19:03]:
> On Fri, 3 May 2024 09:08:21 -0700 Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > This patch has effectively been sent four times now:
> > 
> > https://lore.kernel.org/all/20220914101829.82000-1-jiapeng.chong@linux.alibaba.com/
> > https://lore.kernel.org/all/20230217084647.50471-1-jiapeng.chong@linux.alibaba.com/
> > https://lore.kernel.org/all/20230319132903.1702426-1-trix@redhat.com/
> > https://lore.kernel.org/all/20240503095027.747838-1-visitorckw@gmail.com/ (this change obviously)
> > 
> > Your first comment from the 2022 patch:
> > 
> >   They're not used now, but they will be in a release or two.
> > 
> > I think a few releases have passed since then :) I don't personally care
> > if there is a solution here or not, as I don't test with W=1 (there's
> > enough to do at W=0 :P), but maybe it is time for either __maybe_unused
> > (as that strikes at the heart of the issue) or at the very least a
> > comment saying "hey, these functions are currently unused but there are
> > plans for them to be used, so don't remove them", rather than just
> > saying the status quo?
> 
> We could just slap a #if 0 around them.  But I don't think it'll kill us to
> have to type them in again one day ;)

I've had people try to use this bit for other reasons, even with these
functions.

If we're dropping this code, then we should put something in to avoid it
disappearing on us.

I am working on the use of these functions in a branch, but I don't have
a timeline of when that feature will land.

Thanks,
Liam

