Return-Path: <linux-kernel+bounces-439290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ED19EAD36
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A97C165688
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A063210F75;
	Tue, 10 Dec 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jw2aLDdN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N03cx7/r"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423DF78F30
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824291; cv=fail; b=dtjIW8o8UI10vy42k6MhMi2klVMuQaJzvJ4fi7ocJ1hK7UsZXmvjIitBjD3XxiZ7ftzsplJt9ihD3kqU2i6ANVRsQ5FfGAjWjcFCsxiMKTyGBIWDsgbjMJSvYs6iedatyDkZE+yhmESi57KRAnRpFwIyaIayzHuwhOmPFbzycBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824291; c=relaxed/simple;
	bh=z7pGbxQ+n6vMFlMI8skZt9KbpfUeaFHZsS7cofabMnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b0dFddHh0LdWfdGeCl74Ez6tafQzmYTtxw5h5KMtoQkNKmKgNwVb3nDuQBvSyyppS0xCNiqKiyQDbdn9BkiFn8DED9cTjVGq0V6+pNz+7b/IJubnexfRyiGKEwWJr1TqvsZfVsTUzax/uwj77GK1wC2DxlfwtfDdaCmUgF2SQNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jw2aLDdN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N03cx7/r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA1C11S027593;
	Tue, 10 Dec 2024 09:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=z7pGbxQ+n6vMFlMI8s
	kZt9KbpfUeaFHZsS7cofabMnc=; b=jw2aLDdNlfQ+waws1IOeb9H7ZvlC9ojR9u
	OF4FxZphe1ezmigVZItduxkCAvcqlplv4rVlfAieCWPtM4FojmvUAC6zqc6jSvf8
	Eyl4zP+m1ydg30bIiozGz6hWayrK7B182cMMfgwHTEETpMjHOASu8NijUcI8jwd2
	IhAITxkLGT/mfYc4eyNUYqnOGJB9FbMw5FT7VDcH+SEt8OTNKv9ad8AbWptpDCaJ
	3kqgrtXqwOvaZcURn9/YccATPr7yzFMp2ByyqcuXcUmQXSTZepUbk+L4TQZQGCnO
	6mwr0EchHPvIPcdEMIMbo46rvfNbP8p6Q/4PeqCL/bU+ua4hqflA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ce8959wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 09:51:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA9FMs4008536;
	Tue, 10 Dec 2024 09:51:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct860ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 09:51:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbLQvEwHKpJX50YJVIS23gDYpYCyyhlRyLZfeqExB0pT3E04p4SkZ/asJ2fsHzvqsq+Ll5iO51/5SAqC4DRoi5DY1/94bWtE93FnmN0viEgblYdD8WX1ODxWAmkdV/kr6DLusxSe5S5u5ZaAqZq6oEUAYVRzpI0DmgBvxUncaUYI0smEZCKbM84tAEOLxltQsSK8wrl9SNXnKUHfHiPOo1o0WGfBCSvR8+Jjr+6Q9ViFDvsfgYDGF28SNsnWQb22qcco6uZ7ACUYIgEijPoHVVQdwcUV2RnlwjFkESikFp4OGMEdaMsbEqkO7AYUSbtUWTLujLSltR7Fr7FRn5i7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7pGbxQ+n6vMFlMI8skZt9KbpfUeaFHZsS7cofabMnc=;
 b=fFngHRvnQGEW2G13HYjK+ExspqK781KXe9AlkTf4ggeNPV/Sq6ej9C45N5Jo1oMO39bfRGRLALUIkslTLGgDMJB5kBTZDwwbaYxAtJ6kyoFA+ONiBxpPBbTen3BDtJL0AsRp8FmaP1BdhKjJMJntbPkzeMS9mbGLuBWiUK7RCAIt/2QOwlcz7wLXfurVaoB20Wspet9+mGVzCu+1Gv0cn2jEMJyA2MlK+aB+II72Olpjc5ihkvkfWuDwkS2ZUUrgW0npoaojvYNY6DIctPulTg5xS9beACQNa4jTabSLS10FG863p85DtPwZLVjZb7eIu5O/P4FhD5k7qCUOMxH03A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7pGbxQ+n6vMFlMI8skZt9KbpfUeaFHZsS7cofabMnc=;
 b=N03cx7/rxfgkUsXHkcHhtvJ9Qv0+5EVMaFdb088lUbcpZWrnB10dtbNHuQAfCHe3mWikq6+xs+cs1sZWCiaPTZ9b5gEYoFl3lrmAozrdypqfCfWZ6rL+1m4GhUh6Q7CvXnRfz18WXhWv0C0N2NPaP//I2p+073118Ae0l4Gag3M=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB8189.namprd10.prod.outlook.com (2603:10b6:208:4f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 09:51:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 09:51:11 +0000
Date: Tue, 10 Dec 2024 09:51:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <dfe6b339-a742-4adc-9a53-c653510428d8@lucifer.local>
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
 <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
 <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
 <81fc4cd1-55f4-4569-aef7-0b0da9684fdf@lucifer.local>
 <af887f35-0831-4c7d-9f1d-bc857b52975b@redhat.com>
 <67ae2a5f-0c86-446f-a122-f14decdb84d3@lucifer.local>
 <a3cacdde-8dab-4dcb-a720-9e00833ee9c1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3cacdde-8dab-4dcb-a720-9e00833ee9c1@redhat.com>
X-ClientProxiedBy: LO4P123CA0649.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 474dbac9-d696-4575-5b00-08dd19002d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z4EG5DyCl0xHSYpLQ5ij8NrBUq8Sir+k9E+oPm580g5TYvtUVb4unPeh3ID+?=
 =?us-ascii?Q?xFSH2Vx2ne+zq1ivk+iIZpjQGjEollHwecUKhXYRUpj1u2HK30C7Ce68sGVN?=
 =?us-ascii?Q?4J+bualP6qASJJM5Zv0e9QTTdkFgEJgRIlXWKeIBTVsLVEYf76uSsvXP/gZe?=
 =?us-ascii?Q?u/GbjUbqHhmSrs9GKRy4R6BxVX6VgwJ9q72YJlGWYCnhR7MrXC27VMjVPJ9R?=
 =?us-ascii?Q?mqZIff+vsIt/p/Cs+yzHqZGETQLUlHsqeVo0oWuHXdvVWbzP4L2EFQ4hYvdc?=
 =?us-ascii?Q?oi7zpXLic9tRtPx+gEW2LC3AZacupv0BlA66Mqnl0x9ulOkw5myG5By9Eym8?=
 =?us-ascii?Q?KmBtzDXPPGd2V6uHTMW9HSlGYk9ctTQ+LcN7Yo+ATXYAUTZSCMC9rNDcXG92?=
 =?us-ascii?Q?qUFLdg1EMvihsiuP44d+vQQlQl7CUPuuEkoL7eIQYoXrj1P5NgxdXm+siJhq?=
 =?us-ascii?Q?+4GtJacWNNhKDLHHVX6ZHLeI/2Efl70nk73jMMzhZ2Q7zhF3Yk8zbczQT8zA?=
 =?us-ascii?Q?wO/V7p803Okm6Mrw8v7H2+E0N1f7QesI+y2XZtmicIZltVjLMDjyGeJG9K2m?=
 =?us-ascii?Q?sI0/VY6oNSwf/SYZDfS4MZKAUWgmfFavG1l+qITrEjGJBD9QxAlSbXzjmWEp?=
 =?us-ascii?Q?E+oXSUBrzU+qZ+hMbUn41OvwipoXka94VGK3uww02rJlMxtlbOC5oHDUGz8C?=
 =?us-ascii?Q?jWoFZulAy196Fdn4mDUx3TOva5AgISeAaoX0f6rQicMV4vJ2UZyEVY4htOPN?=
 =?us-ascii?Q?gMwcdLgMEx+cmdOYGYykC6qBxXidq/G2IMG3udyNv+eH1XjIRnVwAoPzq4nL?=
 =?us-ascii?Q?dhJTEdX/Ro6GUdeJxUd7Ccs3HRi9heyE5zASnsffgeGpo6JFh6xVCs6qgteC?=
 =?us-ascii?Q?NeKsia8/rmkgBtpRpXOzYtN/o85f72NfDnH8kYXmhlW9aCXAYtLevgSs03xh?=
 =?us-ascii?Q?+jo2n3vWIvv9jioeVJitttcXXT841QnKxqLAb+gpsR2EfGW7jjgUm0YiPpBH?=
 =?us-ascii?Q?uipicSi4RDMMVkqicpDGiq1dkixae85232CXP+9DTPkW9jEPohbqGmWbW3Xj?=
 =?us-ascii?Q?AzVwTd8761SogkPAUKTHfn4H6ySxbDbrxhigctmqg2M5kRuOPF+V+v9a71UX?=
 =?us-ascii?Q?tNEBz6n1zLziUjsuaR0Dct6DHi+UDuVt21FVcOdyM+8wXo9DLlNGdTLJCVMS?=
 =?us-ascii?Q?//DXCqJnprvRcb/gd3PgA5rqIo2MblsTF1su1R8Noa0nISp02Hyds+EQ1LtN?=
 =?us-ascii?Q?1rFavbcgqHjrsnKuy9jvtWK03tPPBWvN628X2y4/C5+MUPaFmQ2jKQgTrbYB?=
 =?us-ascii?Q?J3Ui2CQpMbW2HcP7Io/NpOATeRuB/pFh3n6wwdNZEv/BcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6A4xF+iGd0/j4mxV0pE/gnGcYPDIe5ScymEbjXZZLkOjIKnjNrZeLGbeLfgV?=
 =?us-ascii?Q?nAUaUkIANtPwQ4udauSxPo78FSlsXF6kiY37USaUWzwf0rw7wodOPVHKZmvP?=
 =?us-ascii?Q?PiNU5gpalSOFiLNDO44udOs8aG6UcAEloH0BQaUhcWh2x7Sjbj+xrQhedaBt?=
 =?us-ascii?Q?dAG/M3KkViviVsDrHhNoAdRhW5u97udS+vjnua9F4g705wy/7qgNxZJnmA6G?=
 =?us-ascii?Q?OwBPKxoBY1Si0WgIKXk5EAdVAkDHtXxND/ljw9VlVSnR8S6pRmJMvmCVUV8H?=
 =?us-ascii?Q?cVRuew8uXvTf/0J1i912eaM+WPEwcUkdNDCcqCXBTSm9JpqnBqfuf812hvST?=
 =?us-ascii?Q?drOMgb6cDVq1Z3wpIls7ClD5Pem/w/zAx7CB1a92k4FZAZLws7ZHnVfrJMus?=
 =?us-ascii?Q?aNql9XJk4XZULGvFB2+LL1I4+sP7Ek9GFDrKB601UTqTC2xNnWRQnhTMlJ70?=
 =?us-ascii?Q?Fzx3ELe10KuTExsJreGpofLiZ5Bi5RCHRh6pE6hWeA64M0qXX01C8D11RIvr?=
 =?us-ascii?Q?tbQb+xK7SukqbGnpeW3JNLIMSx9p9CKDeULwiBjK51d+4EBpAxpIEgZtkFYR?=
 =?us-ascii?Q?U90/l7/0e7TTHme62qVQlQZQw7KnIGzdt9iQOtkrtFQFw0h8OgWjNyzQu0R0?=
 =?us-ascii?Q?8nhcsbB4qgrcc57fT99423gv5UFui/GZJo09lw9T52wMjDSe1WPcwRWb6Db/?=
 =?us-ascii?Q?B/wQrVVP4/p6j+sjTS/HekXwtKwtRIqTwpgi/OehQhsUhqvdUOG4YO5Il0c2?=
 =?us-ascii?Q?FIi/iqhq52Rtn6Boq4zAJaxZ5NdUX+F82bogsPCHGfgGUeiO3k5ooDuJRC0x?=
 =?us-ascii?Q?ay3K+yHSlYekcUrK7HqOSbpf+iyJ5V78Rn42XPXRHB+MP74NgYYn+EduiByH?=
 =?us-ascii?Q?zgRlJRbuJCD3W8ox5wJEh+tXlLP9OX2FjpAnOz5JER9qICyVA7I1T1SDcIu2?=
 =?us-ascii?Q?5+6XZ7YjR9OJweBFsJWJj/ImK516gcubmdgpYIed2U8qoibQPbqcG3jtmM3g?=
 =?us-ascii?Q?aZiRaPXcLGPyQlxqbXwcdtBaXTa/btDWRT3lFg6iKSqpIMpRB/c8bpVAbt6w?=
 =?us-ascii?Q?jZwPNlOqtj0YjBXVUFYCyT52boGy9yvB2yi1+39/W859xiYeaYJW7ITdLZzj?=
 =?us-ascii?Q?x5pEm2+A2aDQqTNL09T4uuU1hkLJMMwnl5swfzfvgAqOv1VcO0br4FmB7Kcx?=
 =?us-ascii?Q?JnIxFTMopLtsj9HHBJNZpcUQnp7yvZErC0Cjw0sAkJgQ5ucpaSvjXiAm9jwO?=
 =?us-ascii?Q?lmIZ7U54zUB++EzUkNpBcqLcq/a8ufhQgZ3Olds/Wg5T9hqR99kPafaJkJct?=
 =?us-ascii?Q?BUdaeSTLwJBGuLmS4U5kLQ1/l16jzlnwyJ+5+hUu5AuMytHAV2G9uPIR8Zd4?=
 =?us-ascii?Q?5VngHjeOcb9D3jNFYLHUKMhXnhNIU3fiRzduCvYB7VpfcKTqjcvE/zpLsPOO?=
 =?us-ascii?Q?Q6imYBUnSCaEryQZ4WjJ4uQ5LqfpTglp9r168BsLvHJo71XcBkIV6WR0nxIi?=
 =?us-ascii?Q?+8jZHGit6Q5BBxfV9Dkyp0eEtDKWhWGcrdp7Xj3es5hm3RyNfJCQ4Yg94min?=
 =?us-ascii?Q?FTfVLVvxIv3F9jUhK+/TnGl32KnPlyT1lvnCR75xE4V+6y8x6IfOxN2nnRsg?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YkHv72eADFJbIy3rVMi5ceKWK1sfK5dlMbJU7k4gwaypUGCgcIIrGxi2S+gquAy7QY8MvTW1Bytg2y/WOdRTRs2fCpBcY1keNlBa3//uQo2MyGSet2QFGv6wfIJXTTwip0Z1GD/63cucBJASJr8IukM+h9XxXJEA+1ujZ7cXCDWIBDj+pSTS3s4OIyCYCz1coJcaWhSjZssFMzL3aieNR3kuTKmjxIgXPwFhiM7+fTf51EC9kvaYTa/wonQZeFlgrROb2kq6XvMNPUKuYZfo4ZkoTlHiN2TDVujcy56zOJFrniXBB0wZBAR82KaacCXokBkDnWSAbwZ3VmvNQ2gJQ42ZzaCxO/v836e294dvQQDSidYrqUTKMLP6IApLrYbJ7/yfdyxxm/i3KeX9Y1btkDywceBL+jAFPAkiqQRX9kf2BgFVkhDo0pKVJAOBv//qTmbMxMMT0sgDbHx3Gr6eWY2AQxYj/FcqNp7vGAg2C3slWCAUdVQ3mEkAsligTKEliTgyXBg9A50sVjZuB4fpgGfdHLQj+fjdGZbklSqPZQRbCdz7LB73PoU6QtibO5Aoqi+m3n714r7slkoyaPLx0o/HK5+bcfuNDxUrhFvX1Y0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474dbac9-d696-4575-5b00-08dd19002d5f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:51:11.0495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hA3sOxvF9J2ADYTW8XfMC3zC6BgGz5rWt8PNBvJI1GnsjK42c3C34ndmeDC2Ix489yAdOaFBuSpHy9dkfyDlfP+eiGamGNK79K0pWsRdV+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_04,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100073
X-Proofpoint-GUID: 26w47tV31dM1Z5_zD1MQ1D11ZEaGfMJD
X-Proofpoint-ORIG-GUID: 26w47tV31dM1Z5_zD1MQ1D11ZEaGfMJD

David,

To avoid an infinite back-and-forth...

I think you're stuck on the idea that we are sat in a VMA 'vacuum', perhaps
because I put so much effort into separating out the VMA logic, for the
purpose of being able to userland test it, it's almost given the wrong
impression (I should perhaps have put less effort into this? :)

But we have for quite some time now de facto been expected to maintain all
aspects of mapping, remapping, etc. INCLUDING page table considerations.

We are more or less de facto maintaining all that (modulo madvise.c - I
grant you this is the odd one out).

So you can imagine it's a bit frustrating, when that's the case, to be told
in effect - no this isn't for you - right?

For instance, as I said before, we have spent large parts of the 6.12 cycle
dealing with practical concerns specifically around page table
manipulation.

Maintainership is more than setting up lei rules, obviously. One can set
lei rules for anything. It means that our say has more impact, and it also
means that we are (co-)responsible for the listed files, and that's acked
rather than disregarded.

So, again, I politely disagree with your assessment re: page tables.

I think their manipulation under circumstances where you
map/remap/mprotect/mlock is -inseparable- from memory mapping/VMA
logic. Otherwise, what's the point right?

My suggestion is that:

a. we put everything in MEMORY MAPPING
b. We drop mm/madvise.c from the list

I'm more than happy to hear your suggestions however. But whatever your
view won't change the de facto situation, it only makes it more difficult
for us to do what is already expected of us...

But I'd also like - given your strong push back - to remind you - this is
not a coup :) we are simply co-maintainers with Andrew, we don't send a PR
to Linus, the <2.5% of mm code this change represents would not be our sole
domain...

Thanks, Lorenzo

