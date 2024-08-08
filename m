Return-Path: <linux-kernel+bounces-279801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9110494C206
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48341C20FC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15D5190481;
	Thu,  8 Aug 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S5McLviM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A6vBhwsu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF118FC86
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132369; cv=fail; b=cte8E4MW3gAna6UcO5vXY6cKj9GaDKp2eU+0KinVrsjp1DYKXzrRtqKDlhd3kZW8hzjV2GSryiSNeBS0Br6vWi+8OWrQt8LZ8SulJgCHbgQampRgq+XBCuzWgyKTOzGy3PyojMSlf7p8EKDy4dERI0u5pMtHv8tsTWShIRgnGzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132369; c=relaxed/simple;
	bh=eNF5IMOxQK8b8rI8FHzWh5v0NUZfI8xxOR4+oVLXOBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=amoatARN1bnORcFeTSLte85GuQ5z+hZQ7hcjum7uYyjoAtvzO2nsvyNeZ2Kbw3IzYzcZQKG6DNTY5/p3KS7xJDAccDMSX5+BzWrY/RSiZDlEggi+zfrVfNbGbUR4HSidNnYaAm1qpa92tARXij6vhWcZGDsgXQLYSBSobUYyIyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S5McLviM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A6vBhwsu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AMWnX014885;
	Thu, 8 Aug 2024 15:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=u9f6op0CinD5wVu
	BAqohdUh3diUbC51pwUe2YfWdHZ0=; b=S5McLviM5VtUR0P23U57c0JgEj0y8fs
	II6UU+SBenhZ4hjT+7eCW1qJJ1NvRff+iQdnwntWjb5gc9nDvXbvRpOg1Dfk0i2+
	Nsn5XAGi+/gJriWxykVxUV5gX8K1qPe1HD/RslPnj2O0Q6YZELked33PsLujx2Ye
	xcFtM8c0DrXcUz1MJo3FRE0bJWWTi1ifATPEmhdPRrk2YJgi1KlTY1r6Z58BE+IS
	q5o4u169yyKT5+puaV/3IjfIwjVCsaAdGDrNoKrQfmGf+7wELLHWuhlOVkAKZs02
	rPvaj0l6CCzuVOdP2lrb0HqN6J2IIR25ngO1O6Uqrxrt3ALSqdZXtWg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sc5tj3qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 15:52:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478EFb8D027799;
	Thu, 8 Aug 2024 15:52:38 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0bftds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 15:52:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/huDdDcdyOT50iD7xXpdbUyuV/INJyLmv6Vk70o7PtEgO03lbbq4Y6HTh2u2ytarKVm+Kwl/hF/FvIHz2ntrsWoxs+6a5uA0l5fMBH1UstrbgM61KHmYVe5xTT6JefCzDHRxEKq67/UOzYz1Gu9PcgvXEtRN8zufwcMCL04QsfPbcERph0RyH7lCDu3lbU73gd0UiKVgN4IU2ePKt5uONFmxAR+RhdP0txnfTEv19FbKRDfI3oJDUAHtW7sdtZ6VPC5TBvbqqq1K7kKPHVJoViGeX7+bfB64OUm87e7vL3YVfELYHJCPJOwDpRdLE3A1K8huWYireO9SjoP4hm5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9f6op0CinD5wVuBAqohdUh3diUbC51pwUe2YfWdHZ0=;
 b=y8gGS7aDSeovlzx1ByxRrdmfGUsVBV62MZVfJtey6i1knfkOBZelO9n4FdiDMgHxySwc2nzbkEowwDmYKeNnEEjpvkV+8jZyTwWVPUrr5dtweSHEhb3u5Wn1kuF8nbo5KuM7BQI2DUhEqKKp8PWerJ9/onuY77G2r8tHWC1I6Ms1sDUWeeVH1xvb8h8Fp1qT6h2zHyI31LBNe/Y9mmGjevNveq6YO0uWuaDhgtaizJQCx/vqawYFxG2iW6viZz204DoCR5KjnrzG8AuYL/y/oJgC4XmU9+2kSf5Jyj6Xt+TI/3AZCKTP0LM6naoXszjUsSev2jeSpzSdWVPQkpJyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9f6op0CinD5wVuBAqohdUh3diUbC51pwUe2YfWdHZ0=;
 b=A6vBhwsuWC5fChMQ2WjbfJ47W/mgZZsARIxy5NFUNriTG84/x/gzSVTd1PEPiTiejrSiK3NpUJgS75hvSpRVCMUxKgh7mbL/bXou+D/iSmBG427TaeJm69J2zKvdfuyfWxrf9ZgrLTgwuxptOZo6WbdwoT6SC3BFqhEe5rnlAfw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB6390.namprd10.prod.outlook.com (2603:10b6:806:256::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.8; Thu, 8 Aug
 2024 15:52:34 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Thu, 8 Aug 2024
 15:52:34 +0000
Date: Thu, 8 Aug 2024 16:52:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 05/10] mm: abstract vma_merge_new_vma() to use
 vma_merge_struct
Message-ID: <fe9ab44a-919a-4a0e-a05a-f6334ab9aed8@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <f4f4b5d441379b22f92d7cd188c2095198cdbc86.1722849859.git.lorenzo.stoakes@oracle.com>
 <82b802e0-94fd-4cca-ad8f-ea2d85bcae64@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82b802e0-94fd-4cca-ad8f-ea2d85bcae64@kernel.org>
X-ClientProxiedBy: LO2P265CA0363.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: a369315e-b3f8-4394-40f5-08dcb7c21e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HuWgeJJBdSOfW4PKUUnALLK8fXZ8/NEm0jThpKopDJV7LvndBljuSgtZ3S06?=
 =?us-ascii?Q?nEx+3s5l0XxmvqLGNaRAMPKjx3SSbRA2vDyd1b45z2OCSmRJSx73REfKqH1V?=
 =?us-ascii?Q?RbMkMRfr6wuUJoob9/13ZGxSiZD67U23AiU4+4T5xTDSNtLTezMyoRV1Ngzb?=
 =?us-ascii?Q?hMn6q1va7liqX8k0KrhrA2yZ4GbUF+wEFzoNFIjZaBONgMxDWwTEj/pHLsw1?=
 =?us-ascii?Q?UBuuvG0efIk0tnJFqAUAmSitZCMwIoH64NrxekJCNaxaI1vLVzUDTMQjN1G9?=
 =?us-ascii?Q?VfvvBFwTq7+U6GOaW8VrUMstoZP9l8/decMRD7tFSI/lZlQuDqJnYBUapGCl?=
 =?us-ascii?Q?U2cR2eKQyUWd/umLbipIt5+hGdOUk2uf/HA2yGSB/fpKajgrjFD35TmIW9eb?=
 =?us-ascii?Q?7k0K4+OOL4PuFMvens9BdM2RLIqX7SahMZYV/QAXDF3cV0CCYiLbnRzZiqg9?=
 =?us-ascii?Q?0/Bknshr+GheOO/iEzr8vMLCg2K0z6qcOMvAdqrhe7h8RuM5GUS/pySY1F1p?=
 =?us-ascii?Q?0xgj5nHuFGDIqJgYLaJEFsRVAiSmoNAATorZ6ZnaTT6EH/BW0eHMBiB3f2zT?=
 =?us-ascii?Q?9z/VFZqDDjJZkPoFHaFsN8a/K/+bXhbJJdCMK+m1fAnRa80+c8kZz6x9tz18?=
 =?us-ascii?Q?14Malif44bw5B7pSTcXeT/c9dDOqf4AXKtS65WbgYsOdZS3HsoAcds5ARoKn?=
 =?us-ascii?Q?1bt9tnIk2EYtpChP8ppdnKNdI57lctKkJJXRFh6LNTvFj3/wH/USDSZLv4T7?=
 =?us-ascii?Q?TkfBfXXISLEl7WkMA/mzngzDav2yotYj26lTmxHFnypPGzt8uas9gbjOF/5U?=
 =?us-ascii?Q?LNMNfwlNdk48pnVakia4YrzN+Gmc62IvsYsOy2WEHD5DbzyfI7r/8UtBuBpp?=
 =?us-ascii?Q?R0EQES7rIZBurz1ZwinY6n4sTgzB14CsG0jnuz8G8ljy3ytR2ZQV9MnKM/Io?=
 =?us-ascii?Q?IRV+nk9cXBW/sNcS4sc6UDBpZNfK0z/T7hOb8DbZzFyeZRpUvWxYK2t2Bi83?=
 =?us-ascii?Q?0k3thGAAYciBOZJapg7N/vXoGeTSkaaYwaa82pIgZhNMJqHH9JLV6iVAJDZ5?=
 =?us-ascii?Q?sy0PjthpQNaGdMpVdvB7pO8WGtneQk+hAopUUCBp9euCQWjWhchH0dMVRCRu?=
 =?us-ascii?Q?q/q0+YIEl5GyWc/XCF6RWAaQGWl5d7wuBIOHqLMF8kdV2jJ/61eYQmgIj4f5?=
 =?us-ascii?Q?91JDx/ngrqmScHwvaOcETNA0rx/G27AV/vkZhO8BQK8X1zTXKmEpYA+QYl+s?=
 =?us-ascii?Q?/yX/Vk4Tv9xjYUvJBsvPLwyM7zMGNvn8M9/JcPG56wfj76tbIliBinOT7G3v?=
 =?us-ascii?Q?afpSIJd4K/A0wd47m1cUaIDNS5OFp6f9YOU/FoN6p1t5Tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2KuXvO2OLXm9X6CqfaFkU+s/HAiGClvEi/XUX5geemK0jeqcmEMKhlqIeL2Y?=
 =?us-ascii?Q?l+jrFQveUdhehj10tMO5T/KXjOkCHRnT1OCy+B6MHwlhC8q0Ely3Ac8/o6WP?=
 =?us-ascii?Q?umItqXnmg6tAe/2TjUgB3GTg/3mNXuL/SqwHT+LRGNcyJ+5PbcW+8/ZXAH1u?=
 =?us-ascii?Q?yKVOSh7G/+1u0FpRhZAiY0LNEzZO2bh69Zire/rDh3rpxfZ3AfxvHIsmFumA?=
 =?us-ascii?Q?a3+3wesSlQzipV49traNbb04fVMGF4JrvflcHqbzr7EATcVU9zVnbr9JmR2H?=
 =?us-ascii?Q?XZ/HwvGQz1E11vmBkJe5nEkdyshbuS1C83hGe462k405dBNLGwwdbM2BS7m4?=
 =?us-ascii?Q?qMupal9NI/3fgGS26IOxnpkxBhYYhIhXB0OXU98jwIX2Dw7rkhOJeVyaRbgi?=
 =?us-ascii?Q?cZfQVAAVgAxqjtUW0KgmKwsNhegpBgj/b1I77gbQ0FpskXXD/mQnhuRFCQu2?=
 =?us-ascii?Q?jAOz0CpZiMqFHFWAloRCO5OOM0uUeiKWM15jRquvkwn5Zl/8r4POm2Hj+RUZ?=
 =?us-ascii?Q?QTyl2HAY87MViHWZQyFzeyh5O4onyg16N9CrjEEvEZJGtiSiTDa52rQrHLi4?=
 =?us-ascii?Q?LuMt+2d/HSAoOl/a/bnEGj68h0mnIuH98MF15UB0/QiE9hdU5if5qX9sxej8?=
 =?us-ascii?Q?vxytezOWscOWQuIUEX90ElvRz8C0PgN0WwP+kkcpyu1div44ac7iXWQ4Ig0j?=
 =?us-ascii?Q?dkL3PZd2EiTv8ysp5YTOremx0cPs+Xi2Jgb5HeRCN9IOzGs2uKfckSab4+xc?=
 =?us-ascii?Q?IgjDIVYwPitCbiy/YxJyPTA3H5h0ebr+KdZX1GCkEfplrasj/43FddhxiI1u?=
 =?us-ascii?Q?QoHmGh8HwTHuKbTGuUX9PBpnTRcODBAd7V4yeamd4R7K0Efd1E3GDgwgtfDD?=
 =?us-ascii?Q?6NwxzmQjueXRrzAWWa8ZUzDyKsyIHiuwwbRTyMIDzolhX1KJiHs+Jg3eIZO8?=
 =?us-ascii?Q?bnWsxLkB+z1/69wNzv1So95oxlYDRlReOjMd+SC96A1jVAYSRa2qCRZfdW4E?=
 =?us-ascii?Q?2Vc1pg+16K+e+NYDHWJXlhBMboS212Yll6HzNrU0vH7dkBkiYVcdx5oWQzOR?=
 =?us-ascii?Q?up6nrEWgYIuns357G5Ay2VwPtvubr4uRQGqqfzH1Vf1DZr001HvHJTlpbsHq?=
 =?us-ascii?Q?v5P1JDujttnAunQBE726Qa4nCXkfNfQ1RcClndNrcpMBsQ2iSO9/IE3MVMBk?=
 =?us-ascii?Q?UJH8YI4L9dnZ2/V0jnYhseBxcwu29Mzr83YtW3f7/yV7Y6KvUb3fPDWWxT/3?=
 =?us-ascii?Q?14t6UyM9JUFMra86+NnM6Kd4jDmw1DKcYFTAX7Q/FxfoFiXbEQu9+5D5y18d?=
 =?us-ascii?Q?q/8xPrf5HwId6F5c6vGWo52DcTK3QE6fH/78JUAisVWtE2FaJQRdV2KC1JS8?=
 =?us-ascii?Q?JapMHSDi7ELdvWB8b4yIv+moCk0H+sa7xzU8gidVcqY8oRmq4PTNrq8dWK8H?=
 =?us-ascii?Q?jRVItl6T0nZ1NQ6nNjU3074rNFUxzZXATYoxKoQwoZFSMefp0lylCfWg6gMo?=
 =?us-ascii?Q?SwYLQVbMl0hK2uNc3O1/vxENOYfP+x31U0ae4hMg/3eWjvwI08riZk2DNhef?=
 =?us-ascii?Q?J8trnSMepBQQ/N8gRHtdFX0TXrxBpAHLnIFeITUIJ7M52HpizXF+cpsTALcW?=
 =?us-ascii?Q?Nr9Ugm2fsg1DdXX/h9YjLAt/QJ+U7zN2XlKf9fk4x3FxmH5KHQ717lpjq8xL?=
 =?us-ascii?Q?Wy+xKw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8rSddevolGDgIOjOCfRl8hgJRrR5MvcGN7nbh73OdXmnurZ+Xggnyy5vGnNShxLAMV7cd5u7RwINWiCvS7ITxvvPlvlwqT621naoyfH/oEvQE+fXlzm29/vsFrF5TssJ0HgW2mvQ0K4zPUBfijun8o3fhtxolIlxPZ9DC0uX70l04DBCFFveOrL0UpQYZU3qNFlR949NmyIaVq+uKh37OZ89l6TXJztRH1c0ymm2v/zKOs61bE4BkHm4VwMbkphM+zAMM9R2cZ1PJAbPkVPMuJ2KggF17eWHQh//4nUF2Mv4cqBOc4hGpLPh7wiQHlmg1TdrQWUd4qL1YSKMJl6vu8s5zMLmgeoOzVqDS1cgpDZuCC5CXTWMwsvpQU06iWAFU9K8l5gHBrnzg+ic97wpNRlxuZHRJY7jUBoAi4CvAhJMn0ZvA01ygU09BKY3abS3Onxv4KEoP8CBxbSaTdyaDtBXGgbu7iDCCLR7P395+sTSQHy6wn0A5tPag8w98iREthDwm2P6CCNzCN2aH/UA7HIEAYSh93qWtF4CwGn56XBu5RTg8h9xKUvOYyQVo2NQq08jzOswO/cEHyLRk0TqVFbLQ4BpZ0eKLoTYJsLZiEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a369315e-b3f8-4394-40f5-08dcb7c21e98
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 15:52:34.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fZarXyFWtGzjcYi7wKv0eKtYuYxDqAaOWqi2z2H91U3xr36t2IGKEwpwgGFAzf8q5qLz54pfSPQ/9am71VhE9BS45iP+dXiNCzU1fCvbo4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_16,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=847 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408080112
X-Proofpoint-ORIG-GUID: 1H9zlmjWvtNPZs05K0er5i4SDyCmOMxx
X-Proofpoint-GUID: 1H9zlmjWvtNPZs05K0er5i4SDyCmOMxx

On Thu, Aug 08, 2024 at 04:55:07PM GMT, Vlastimil Babka (SUSE) wrote:
> On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > Abstract this function to so we can write tests which use the newly
> > abstracted interface and maintain a stable interface for tests before/after
> > refactoring.
> >
> > We introduce a temporary wrapper vma_merge_new_vma_wrapper() to minimise
> > the code changes, in a subsequent commit we will entirely refactor this
> > function.
> >
> > We also introduce a temporary implementation of vma_merge_modified() for
> > the same reason - maintaining a common interface to the tests, this will be
> > removed when vma_merge_modified() is correctly implemented in a subsequent
> > commit.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> <snip>
>
> > +struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
> >  {
> > -	struct vma_merge_struct vmg = {
> > -		.vmi = vmi,
> > -		.prev = prev,
> > -		.vma = vma,
>
> This line not being addded in the wrapper felt like a mistake. I see in the
> other subthread that it's not so I'll just support your decision to tackle
> it so the code is less surprising.

This is just a wrapper that gets replaced in a subsequent commit.

For new VMAs we don't strictly need vma, as vma_merge() no longer references
this.

This is purposeful for testing purposes.

>
> > -		.start = start,
> > -		.end = end,
> > -		.flags = vma->vm_flags,
> > -		.file = vma->vm_file,
> > -		.anon_vma = vma->anon_vma,
> > -		.pgoff = pgoff,
> > -		.policy = vma_policy(vma),
> > -		.uffd_ctx = vma->vm_userfaultfd_ctx,
> > -		.anon_name = anon_vma_name(vma),
> > -	};
> > +	if (!vmg->prev) {
> > +		vmg->prev = vma_prev(vmg->vmi);
> > +		vma_iter_set(vmg->vmi, vmg->start);
> > +	}
>
> Admit this is another surprise. The old code didn't do it anywhere AFAICS so
> I don't see why it's now done. Maybe it's necessary for futher changes.
> Could you add a comment or explain it in the changelog, please?

So in the future (actual non-wrapper) version of vma_merge_new_vma(), we do not
require that the previous VMA is specified.

vma_merge() _does_ require this. So we have to go look it up if it's not there.

This is so we can add the tests in the next commit, and have them be completely
identical for the functions _before_ the refactor and afterwards so we can
assert that they pass in both cases.

I'll add a comment accordingly.

>
> > -	return vma_merge(&vmg);
> > +	return vma_merge(vmg);
> >  }
> >
> >  /*
>

