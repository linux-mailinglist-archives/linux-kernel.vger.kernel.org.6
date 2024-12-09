Return-Path: <linux-kernel+bounces-437811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46EF9E98F4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E851167303
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5E1B041F;
	Mon,  9 Dec 2024 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sgo36xaA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xw36hXV7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF515575F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754776; cv=fail; b=hUVtOnMoeCxBbFVTDJ4jtwpFtsX5bIzIoc6CPKba8gZYU7rqUs/aPGdqyZ3kiocOmivm/icTGnmgzdc5a/w9cRQ2GyZksGkjTg5qHUpWQ+/nrSK4S2mtR1gmRN/rsi3ihZkvMH2j8VMN0ywC8kMMptA+K384SjL7AoHSY8DvkcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754776; c=relaxed/simple;
	bh=kXdRCdD/cFKZXVosu5gf1pJCJlnnomI4QIkBmbGG9PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gy1C6nKEz27gzsV2gj4+au48m3oMRXrRfvjSCGd1Cb/1GVpAk82gV0Ep2BVxV+7eE1CYwnAK+jXKKz4su5HP/d9rNm3j11317pwbJdTEv641ZgPDpFfedWXUTv3VfUniSjyUH3MmanHyf/MWkSnDglstnh22CpVzB0hH89u8uiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sgo36xaA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xw36hXV7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99hDnT004408;
	Mon, 9 Dec 2024 14:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=VtgZfqtEt861bgkg2K
	r5eqGSgNGQTp901qRhL7j7adM=; b=Sgo36xaASpUjRFoLFikT6IWCiDjLrB7GxX
	THemfm07e9+VrWDv7tNka++BAR0kazMUTPlT5xJIh7/z9YPd5CB9LPEykKuS77ke
	QCJe3Zq9NekxBeZLQDcSdyguyCzWztKXZ48caYxTGJ79fsKIJ9ZrJkVPKt3IFPqV
	ArXd2pnlc8MVZMer+xnjYROwO6nZtHhaQnJihG+zyCKsHJj/otQYCediFnPQW9zf
	8vkompXfn/+bK1lhDY/TPc9+ePEYj74slaac9GrufXmXb4ngilp1IWCiH0HxrPhi
	51jAHG5dHPNV4bZuvfy/FNpxRUCCHBFC7Vvn2jSuxnGbfzZ3U27A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s0h1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 14:32:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9CYKxI008552;
	Mon, 9 Dec 2024 14:32:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct73gd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 14:32:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+UFB3guTNSc3wsky372hiFoaHdlJNH2aWrV0wKOvwHVHVLfRXS3l50iLJgUvjgIZBqo+9mD2XALvtEWVT7IlTu5DfWgyLMJ15ccPwd7pTxbvpEPgjgnz6FAqB3ULuqbiro6+rzXA0JL8a0bEsgr2uF9mGzh5IIO2llegng5+qaAjKuGr+BeTSP7om0Wk0gY9NYZHxl/vUndNZ9JzNI2JXaH22NGliBg9Kf4NG+FUkRiNEirxPxPEjH4XW7got8p8DIqeqZLww6gSuN5SCtHk8IAc270ZTNro0Jz95h3EUT59fv2+sJR94ZeNGvkriP4zP7Kari4ZDAqPdPZ0WOjeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtgZfqtEt861bgkg2Kr5eqGSgNGQTp901qRhL7j7adM=;
 b=Bvvk3D/6Lcdq/NpyKVVOYGuO88bPwwKipU2cry3I6QIf6p0/R0ia2EpUxqVgwEX4Fqv7otcr+9QvzLXC/pkQDmXLIT51rwnfzmZ11pLY3QSa2hM5XFweirGKnPGku2Q1ZOiRc5k+jsFrB6qKtPM5qf/YCdhsmJAv08i6L56Fp3lHJJHGHuVnwLXGQyqG+p1SGSAursbVx3b86L7XeFriiD59pavaJFW3tpEXOm1PnuRJvXXahoIEDCZHp8B1z7EJjmgUotYuiHd4jF01gzUm1Ltol61SgWhcmXJXqzbdl3WQ9KsTnkEzzUrAwjloWp7xE7u8HLzqk5i2ojv4HbRrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtgZfqtEt861bgkg2Kr5eqGSgNGQTp901qRhL7j7adM=;
 b=Xw36hXV7jj0ZsA0DV6PUx1XBfOA+t6K6KlssdMQYJVYKz4seEBeklUqAhE4y3jhhZdi86jkH9xXzdUd8OaMfhqYJMEi1xLvefhjsAB8W/57TDwX0RreRzsS081hpdUaEAZyYHWGmn7Y69eXqWE88pl1Zg4zJxVmM5bXhwB8jZN0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB5700.namprd10.prod.outlook.com (2603:10b6:510:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 14:32:41 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 14:32:41 +0000
Date: Mon, 9 Dec 2024 14:32:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <07a3991a-5419-4e31-a95d-d77e00e5b372@lucifer.local>
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0495.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB5700:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a3477f-e787-4c27-0ce8-08dd185e5640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ADiTDWymnd3zuikGwpKJiBMx+MASBtTxcNyyVyPA63ul44kd6ZfqQqVcKpWu?=
 =?us-ascii?Q?Ge8pguG3C/dqCMwwypJ9BSv8wd/e31vhkHBQn65YNI4WzVrwqcxMZRAxc1ig?=
 =?us-ascii?Q?60hJo3Woki+1RFsvcvo/zGQpYVs7LhJMP7Pzf1sUbeCj1dF6EhmKdTZD4/0N?=
 =?us-ascii?Q?LiGHVbch3UIimcLncbNm4eLZ+pz/yA9dXSUMu5gwuJpOZJ4S6tmLjb+JjFTi?=
 =?us-ascii?Q?aPx1GXXuXGagwutbdXd0z+xdzB+UYhoT2yAwC+prMJzMvAZ9FYpVjsMNq5NM?=
 =?us-ascii?Q?kXBQfwf/baYSqPTgc7A/zgcrtGWqj2p++fEpM9wdhBrrrpYEKwys/0a+M4T/?=
 =?us-ascii?Q?SHmSY21q4lpbnylBza0+iZ/VwGgbytxT05R7rsO27rPHH5ux+BCF2Bc8kEXC?=
 =?us-ascii?Q?pMaMcGbtNmQEQCVaFt99DWSchdqzrpIdlvZF4QYJgH+cbXQY/0qIqPaptJZb?=
 =?us-ascii?Q?Zta0NsohpouEZFz+jj64Blbn02vzNuUGW2WaIJFa8sbjegeO47vGSJjjEM8Y?=
 =?us-ascii?Q?ZwYe+mrSJSRZoz6zegCs+XsYUej3TnSuuLuxrYaY7cu5UYkCNiBD/6dGU7Fh?=
 =?us-ascii?Q?Ywo/LU8l5VrsgSuCeE6eHYjEKWw3eEOexa3VB51aI5xc1uGGMzoVlDvYTFCF?=
 =?us-ascii?Q?tDQTZs4sBPUqDG/7ZyVy7K/GGc+H6ghvEz12KCm+Rc4WrYK/p9NN84GrzTS9?=
 =?us-ascii?Q?65Bnhk4BZH1WUOEr3ana0O1luM55hgYHZmkVaIafKFBCKFpK9x3WgmgXJtJq?=
 =?us-ascii?Q?P0uJOXCJWClT9a2xcim0hk+dSd77Z4hbaJZZ4zcBrsZh+ExfiC9bn6dr8as3?=
 =?us-ascii?Q?QaAQtnJp3JDnYO7Z3Qf/22VWjqCPcXvWFtQb1UTzFpJyW1dnwBHwcaksD6Jt?=
 =?us-ascii?Q?bhlkeJv66OXiiWkYNGm7UbkYi5ak4Uw01C9T+a0UTmcXRYPlNSiHmJYbDOZ/?=
 =?us-ascii?Q?ahbL3PUrR46BX1QhMWIiUH6sK8ALm6oo4aFPK5wOZe50VyJjW2LHEng22IXz?=
 =?us-ascii?Q?zXubghnXW5fjQ4dfONY2AD10IlrhLxAgCGN2UZRQSDl0Q1V7NdVLnBVchxQZ?=
 =?us-ascii?Q?yzBe0AbZkavrovf0Rc4BHos8EAwjUgp2+f0S0jzIUJezWGWF2oExKH67Uuog?=
 =?us-ascii?Q?ZBqbDMEzByWm32eN08Cw2DHwuPtGsqmnvzAMwXZ2bXJFp548KO8eMYkIGwlV?=
 =?us-ascii?Q?BqHFUM+o65Kw20w52u3WWnIYHaQtzemcvS6K2ViH0hPqRfsysVBYoBo7cXns?=
 =?us-ascii?Q?nLoNrIoKgyNyrkep8Of4MeDu3FOB6zbS28LircYVClQVS/BgyiOR9RoF7P+S?=
 =?us-ascii?Q?rSg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bAdhzSHkLXKyWpxDl9cQ4mkxs0D8DqyNhygJxLsgs7/9xXCb5NzTD/cuF8dE?=
 =?us-ascii?Q?RS68v2JYxY/9UdQ4LQ9h0MnFd741+ihOR2aIGbUB8C+I/aKRxePkF/uOfrlO?=
 =?us-ascii?Q?21g566/i++EpwPmEBTJsbCMyxzE+pnvB0MiT5zu5NEfiUgeQySbPZ2FnrpIK?=
 =?us-ascii?Q?xDvod6WCAij5blCaVedVyRe0+rZYcUpOz+aNhqXhLvTc/XQKKChntlkK7zLg?=
 =?us-ascii?Q?9//f95kZ2ywuWfn0XRPhLEfBIe95leqrfOjjnzXJOJtkk3qt0ly9Vg/jmZY4?=
 =?us-ascii?Q?qCtkmmxp7DNAMVtpo2XU15+t13oVSkDpFSaD1jh5SNAw+Xnu9rok7jlmNY5Y?=
 =?us-ascii?Q?J7N22jvxBPCCQQaeTlySl84P19Mle09Qi7RxFPyXVoqExPQFkFwF9KfM7uYj?=
 =?us-ascii?Q?bLZE4zCM7wry6Oel4QeESOJONUfovjvKmVhIo44O3MgHC25kNFBs5LRg7+RY?=
 =?us-ascii?Q?6UHilKUzuWsMmfrhWVyA73hIjfC5zCDbiyaLSouf62bH1bRZlTxdxHnRnd4X?=
 =?us-ascii?Q?eCPcfEUCO4BGYUYQum3fYXDGQygKEI8ZPYbuupc4Pf3s5Gx9LOWb2xU8MmGE?=
 =?us-ascii?Q?jJ0m4jK2/ksANLgyhrIE3rJoLhn/Yos8ShLFcUUhx9bPSb8PBhtkiiceNNn6?=
 =?us-ascii?Q?WVs8CnrIBwop9YANEN8dfgQYZcwBOLuk3zXzZS5cqM2vLenNGcbgLSuTbHA1?=
 =?us-ascii?Q?PF07KDav5VfSFjstviZa16f/VkiKWGGeadY7P1slczPPpBL0wla+8zHNlVGZ?=
 =?us-ascii?Q?ODKQBxuPgLBEWS3D8yINIDle5eeljIPr2GJdNvNTZMK//FyYNE2fkMBRYsNK?=
 =?us-ascii?Q?Ixv82BTsE06EPxhCtGCH4ELQP+y+rg4KVCh2L82VLHnuAhXJpiS8DAICSntz?=
 =?us-ascii?Q?45Xhtyj38+nJUJqiH76IfK1AU99ptNEQAw6RPhvLluehV5dESneAeCSA4joS?=
 =?us-ascii?Q?0o5PvaEVg4K/D0Jd2y1OX/W/USxpTio2nsaswXgExzmjmNfktkJCUGbIlHgw?=
 =?us-ascii?Q?o9fa+QXgkE6EMsx23Bt3cny71NEZrgIL0J5S763MEdObIkyiyzmx1DmEK2Xn?=
 =?us-ascii?Q?Ncg2JMzpucQ/UhaGWBxVNo7pcfKfN8Zs8R+0h/6x2Wx5pVp3wrDDA9D+lvxE?=
 =?us-ascii?Q?56l1jzK6z/IPVtUbgGafXikC8edx7dxY4H49VP6efzayzPygzphEstn62uZy?=
 =?us-ascii?Q?NdyIIXGEqm5uPle6rFs58KVaMYo1iok5Z9lmnquV0iml+BHtkqHthq6cxJas?=
 =?us-ascii?Q?X9K/YSv9Py47FimN86SKFTnXZ2YGa6ZhS0eyJebQgxMWIzy7gHRDtZd8JXw2?=
 =?us-ascii?Q?ArdtpDeCFJBkfpRzd8zhQ0xSKRQMsb41QbL4rSuD8IxbywiYWxR0H8KJchvf?=
 =?us-ascii?Q?BUDdkT94dkbIG/akajj4jJiliJs6gDwi1lIqYHfDC1yHt54E1+9dIyc8tmAa?=
 =?us-ascii?Q?D9aaryNXD7j5dUcNHGg9D1Rp4ejjgd595yomov1OTVMRKH3vKipi1V+hvwYw?=
 =?us-ascii?Q?WQUQhk25UucArVdrzcuXWxKJThr7msKA/4XwwW8d34GUZQ0a1tzMDFGCxI4m?=
 =?us-ascii?Q?jJs1Wk2wdlcR7M6e3ZuPv+zKOa7bY9qmt1hiRRyU6oyCwoBjZf8PlGQ/mlBy?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RJ2xaSGdrNSgfyBj5bJG79gwHUnstw6E3qopEZCq4b9DV5Nd5Oi41R4tQhd1Pv5xHh2n7ZsjoJv4NnG/XB+sXde5lWiVqW8ub5QsUeG4QNpteKWiXDMfweJ4dhRpQX7UowKtAOAM36JQrTbsCz5YOn6c0LNeKJh8qaX/RCboSHxU9ogRRYN3bOh7uZxF5Byn2UWx5F/rIsqgDr4J36w+MYZ6a83Hdm4jp9WFp5l5RjKPPpW6PDanSk2Ww/VcAv52Gb/OfV8S3EwF6aBGxBw2LcSyWG4clb9tAw3VVGr38Eqy4OytczhcjC5O5HRR17xy7DXTd4u7GUy7LG/PmYQT6tnRwjQcaj9Ui4J8/+TQADO/WnKFRTrX3ePTKfRvt8l6valsATy41uq0NNKWzzOrYZy5j9dq5JqXhKAjqWJIq1xeLC7yrJR77CWK/fowrwU16/V5kIuXGTVD30YsvJzgU89pccWq1u3m09ptDQVLcM9wwn5Rx8GYCmhB4tmcFR1OUh4ltRSmk3OQUghZ5ishxfdnZI6tJ2mCU+DBUipHn8ckLfWpQ+onkJoxkfWM8LQnJG4FlpT+d+EDe60plLh/1D4DQVrBTJTRku1uWEJi1HY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a3477f-e787-4c27-0ce8-08dd185e5640
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 14:32:41.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7E6qjkUrdrbaGDHORrj2WtS/EurpsKAbTm497uKzuPgEW1c8GmosRsZCtGn+qwzYmoQ0RmkyCcgCV7jkXAI0IqxAY3nnW1AK6ywNQfL6dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_11,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090114
X-Proofpoint-ORIG-GUID: oaJ81Nm2pnrdJHtARFSlLp9gN2QBmhtO
X-Proofpoint-GUID: oaJ81Nm2pnrdJHtARFSlLp9gN2QBmhtO

Hi Andrew,

Please drop this, David objects on the basis that these files contain page table
manipulation logic.

Thanks.

On Fri, Dec 06, 2024 at 07:16:00PM +0000, Lorenzo Stoakes wrote:
> There are a number of means of interacting with VMA operations within mm,
> and we have on occasion not been made aware of impactful changes due to
> these sitting in different files, most recently in [0].
>
> Correct this by bringing all VMA operations under the same section in
> MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
> with VMA as there needn't be two entries as they amount to the same thing.
>
> [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e930c7a58b1..95db20c26f5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15060,18 +15060,6 @@ F:	tools/mm/
>  F:	tools/testing/selftests/mm/
>  N:	include/linux/page[-_]*
>
> -MEMORY MAPPING
> -M:	Andrew Morton <akpm@linux-foundation.org>
> -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> -R:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Jann Horn <jannh@google.com>
> -L:	linux-mm@kvack.org
> -S:	Maintained
> -W:	http://www.linux-mm.org
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> -F:	mm/mmap.c
> -
>  MEMORY TECHNOLOGY DEVICES (MTD)
>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>  M:	Richard Weinberger <richard@nod.at>
> @@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	https://www.linux-mm.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> +F:	mm/madvise.c
> +F:	mm/mlock.c
> +F:	mm/mmap.c
> +F:	mm/mprotect.c
> +F:	mm/mremap.c
> +F:	mm/mseal.c
> +F:	mm/msync.c
>  F:	mm/vma.c
>  F:	mm/vma.h
>  F:	mm/vma_internal.h
> --
> 2.47.1

