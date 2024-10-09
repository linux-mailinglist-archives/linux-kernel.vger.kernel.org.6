Return-Path: <linux-kernel+bounces-357902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84A997795
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1142848E1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9821E260D;
	Wed,  9 Oct 2024 21:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H6oUSlxc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Cbc2lG4+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163B019006B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509729; cv=fail; b=Fm990LmnuzlAH7YCTkLKUpAz53gFfrnKwWKcftMpDGuicktVpW8RWywBAfeTFCEyGLMeQ0u8qyMQ02jr4aRxM045NPD9n6YYW26PW8/yWxdjp2CIkYu6HKA6Jy6rLKfMV9fBt+aScjAqwVW+wQKvW5gfbmhpwT7cHcgwDBSzIxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509729; c=relaxed/simple;
	bh=S9nf2iLysa/6a//ptV8zVoPGDjV2egqfc3U+1cTRj1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hf0rypWBMlV8YVGALsTfgK3kkNwAiO8toJzD1SefDPmeKOEzRT8CP2f96u+9wToN6AlRjn4hafK/sDgM2cq5FzOT31fi9MdV53+hWWnwqs3J5wPd0g0YywbVQZ9MvpTSGR8MeOi0eao3YBZic4eMSwSMCx/EMVw7VxadFiQUqJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H6oUSlxc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Cbc2lG4+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IIQFM029921;
	Wed, 9 Oct 2024 21:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ry/ifcA/zmU5FNyabc
	ZJHGWwAoDFQWMgWiP+jEi8glU=; b=H6oUSlxcCBANtc93fyZRRIMpql2jYdLkNh
	hUjc2Fqu/xaor/O0gRaYO/k/KMy1hcmXd69jap9HaGcxnsNMS9iiZLkX+feJT90U
	rvP3wJZFy+H7voTBOASHecCsYOaY1XDPh6vuHaux8q8XfhuVnloZVzcCDbi7j1J/
	wXsh/e7Q+prRJlsv6taxExfZ/a8fvE8i6BzXcHJahpRDQt3dknfnH8ROCrvqJrLb
	FPaVDtc1Hai0k0nKytlnGC5TwjU730tJRMV1mD9DtJ4wmN49iichIxd/VJVVxNeu
	Xre5M047AHeuDgbDXW1vvsZ/y/176+WO/7LDpBQI4aooUFXRSA0w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300e1ksu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 21:35:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499KUn3I019235;
	Wed, 9 Oct 2024 21:35:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwfh3p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 21:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I40F+fUeMJy9AVt2wABC4b6bEuukMIB5MdclTQQn19b66ZdFsJJNHOijXL5xSgSig6DMgBXKc2CwaWzn4J2nmrQkboZNsHSiJrlGPk1t6CPoSn1Ax19Jkfb5m0in1o5jcR21uijZU8MTnhceC4fZXv899LiG34mukjkyxialbx+ycuPdcB8TTJQTF1CNqfQw9Lxco+z06YInH2Uuf7xGTf0gk9niiPJf2ygrmPEnm+BpqVtuydXDspslU67KfCbpHhO74rR8VQ8KY3BJdP0X9E4Lc1KuBKbILBkGHrQAdKBnudqlLAcK87RbrRbNbdqfuCvA3faqBgJzXQXTRYvQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry/ifcA/zmU5FNyabcZJHGWwAoDFQWMgWiP+jEi8glU=;
 b=AhjuUdAbC21WxWD5gPMpo6TGCYptLCctcMdulTZonLNVnQhWIdz5/zlKBoTPJroCQrB1uVLMMXIkDpE5+qXQjQiA9N8dkRGPzJN+WCPGi8DDw/sEtOyI8vwUU628SdR5YsQNkYD+EvrXPNsxXE1b4C0n+dX2CcYFRiY4wINknYvbuCDbJPloTGfOwHlrWyycF2ngrOSmV8xm962yyghtjpf6iXxnpIaLM318wK4BkDFGSFxFucVjyUB5JwWfqmN8GcVA32pyDfnFQRUDedjHtEhyWJwsTboLLEO9HdRxcAxLN5vR6HEuooor1JYGukMttdhnwBKWP1aYe2qWLeEN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry/ifcA/zmU5FNyabcZJHGWwAoDFQWMgWiP+jEi8glU=;
 b=Cbc2lG4+ntpT6WHmPgjgA/Q3OiXx2ALh9BEtqH7VuIb4UYkY++IIaKy8b9z0g1vzaMXumZxgJJKfmgKF0t5JLB0Yf2umRFa0ktxZfREvXRb0MDAK9AA502+UrvOglksSm54eloNlKjIEKDmtH58zMvqAoCnFitnWU9VFnX/p39I=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MW5PR10MB5665.namprd10.prod.outlook.com (2603:10b6:303:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 21:35:14 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 21:35:14 +0000
Date: Wed, 9 Oct 2024 17:35:12 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add memory mapping/VMA co-maintainers
Message-ID: <w234qdcsexbz4ovjwy465gtjakxqzc2rxgu27hsrnw7ogoj63b@xza6oa3gs4sb>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241009201032.6130-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009201032.6130-1-lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0089.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MW5PR10MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 7269c3a4-ff55-46dd-9f3f-08dce8aa42e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bVEQ7BjM/J1xOWXMZi4iBzprnd0rDJ2wet8UouHDSgPF7/4TqRC5KuNx3VNh?=
 =?us-ascii?Q?rpRLKV2apqGYOg9D7n0fitCbQTyZKmnWibF34dCHsGuL0ftulBaJ9A2g48cr?=
 =?us-ascii?Q?buTHH+oDsloep4lWV0rHtc6jWnrcg/w8byWWWu82zlkr3w88OuwlP1rkwFNK?=
 =?us-ascii?Q?ZuTj4ccpDn8h/ApVKj9qzq0gCIjpaUQA9sdYruvZYAt2A9F65HQIW6f9HbNw?=
 =?us-ascii?Q?Bkn+d+LTRKz80TPEC1P73KLzbhI3uIfxscfC+kPj5WohZkVwRH1VOy/CdTyi?=
 =?us-ascii?Q?/+mtxjc2yocs3nzpEFNd+cAsb3FySfWeyDQ4T/SAZZr160j18xhi8fnBpYTj?=
 =?us-ascii?Q?CLWj6RfOCfKnpoUo5wMjwIHjNBsqfeltwKyLIPVUGizhO2shuEpCY0ulAeLA?=
 =?us-ascii?Q?JIKXXwVv6iS7bKWD++l8RDaacC4Sx9WMyg6YBgqzOb7nj+ln1U5tVnT1wlLv?=
 =?us-ascii?Q?GrH58JRE4f7HkxJHCMtLZj28N6k2iiKf3UVePhefV48MoQOVL6BQeJUu0S1R?=
 =?us-ascii?Q?Ixc+pMP/zluidIEa1ZExxB9TUxIjKXHJGwWaSV4DY3WS2uhoCE8GXFF46suX?=
 =?us-ascii?Q?6D/EGMqaU4ebcXg9IkP/DoU7Fk+wr/qhoc0T1DVMEcO1104cTnvM12anymT/?=
 =?us-ascii?Q?23pcXgLszhpJKcGM5FCk35TG2mXmE8OwSakKnvu2Yc3XFU8oTTrBkVnb6ect?=
 =?us-ascii?Q?IBeRM3haQUobJricHwsGwBNxJ70ux7i/sSK7TKDlQM8fmNSI8EBL9HP55hOm?=
 =?us-ascii?Q?xuzVNI9p9f4Q8ucm6IcGxyu8bwHztIPsMqLXg5Q676THD1m+lICEIe96HzWI?=
 =?us-ascii?Q?uE4CuDhIDHKz90rnTO1HmM1mosklLLK6Zg85ir39OdMpSRIKT0bnDhE0Nkvj?=
 =?us-ascii?Q?IWAS00HGNntt2tkqHiijV7PBjy5eeQ4fDdr8jmOrMbHWhvI9jA7cTJlcFpWJ?=
 =?us-ascii?Q?tDw/S/d/ZOaK8O+15+DYfQAnpGuKMFo8wJrVAb4S3kjiZX5fnkNtzZRPPbgz?=
 =?us-ascii?Q?qdRfhHsxuOHz3DuqW7rQmf5+yGFmhswhvbh/gTBa4C51uLsmBSNuV3m/z2YM?=
 =?us-ascii?Q?nKNWqAyw1fXV8aCDndpTITPgePGXxolJwvg17SQFfdza8CkYYQ1wuo1pdvlC?=
 =?us-ascii?Q?qpj4U09/3LztkK8pxd/iWZJXYNJzSs2YZab2SljpvE7jfftD+IhF8GBddA0c?=
 =?us-ascii?Q?lRE4WpL2hBOnnZMlyNgV6D+hW+rGQNl62NLh5wLnBvFNNjkeD6TAMfh6868?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zxyRdL1EdZK8/zqMlon7ealLhFhre6m0cRgPtb7FrMX1bym1zxA/EFZBcdCU?=
 =?us-ascii?Q?zrs1snf87TyeUWIhsP1pxtEzVMtcjbgwSGYDmW9AhAYgaWG7hhtNPPePn4E9?=
 =?us-ascii?Q?L8hOndAMXbA0Y3yBz1sITU+gAY0Bl7J4GrgYvpqht0QA/7MEqYdVCp58YC9B?=
 =?us-ascii?Q?V/nHEumZh9/OLQ+uCtst8lifrmdBdQgJiLxrsvwkUK3zkmQ3bRZgeYrwRd2y?=
 =?us-ascii?Q?FmiqP7GQiPX2sZpb8+UAFtUqx5X+IVuEgV6XgR7HY0DNJCDBt6ujpc/3Pq54?=
 =?us-ascii?Q?ZpNashhYhJddGNeY4atNsjGw4isFxn+zSJp9GypJ8kPE60lRXZmLEHTwOtbh?=
 =?us-ascii?Q?RFei9JqB2QolyBPMTfE+gnJpk/XX7w/XiMSVKAHwu2Xa5qylxp/uW2GY5/Mp?=
 =?us-ascii?Q?MeRTqnPlCMCwwKWe0IN7H7dmZFnC4T4/urXgo27i4LEjre64Fj4k99W2B+g+?=
 =?us-ascii?Q?SDhQnFiyGFv2tU8JARJ5EdHmSW6B4C6UVuGqEgXtP4eTAvJADHlQHwYgzMbI?=
 =?us-ascii?Q?5Jf36Wts9YjXp1p8zSH1pD4M/D1GWUaVeVrwfQqHgD0E4rlVe7MPRcpBJlJp?=
 =?us-ascii?Q?3f+ni5C9fYbCapknoNaOTVddB36X3x4r7tf3d6NZILivGG67mMHQN/5HTDTR?=
 =?us-ascii?Q?78yp6j20LHWEF17264pe77YqKTa2qCGy8E/MtSrT8aCdawMWmFke1FO2K7fa?=
 =?us-ascii?Q?cp4xq6G6D7TfIX+L+GfligwngQqV61W3izhv9FSywLJ8WY8FQuePTx53tYdT?=
 =?us-ascii?Q?LfZhOylZN1IQu9YCN6vKiSLQs7a+6MBrYz3PWX58Ja8LecvHuWCueZFVX+UH?=
 =?us-ascii?Q?x8+xXj6MkwwkxACGOiiCGMXAa7PvbdMuAVomFn236CJB6vqHsbZo/V3JF111?=
 =?us-ascii?Q?jl+BLfYHeB3joDFZM+c94t8Ubz/YU1DlESvc4etlHH9OrAZ/OrRuvaDjVLjz?=
 =?us-ascii?Q?loIDbwyC/qoj7YUQJt4Gvkb31uSDtUxiEdSeFaCogLiwib6OPaSjAJr3w6Zl?=
 =?us-ascii?Q?gmrDFPQqDgzR/BPo/eBjG1fY3u5ewTOzLwfHr+m6j1TMcyzr6KUf3eQb6X+Z?=
 =?us-ascii?Q?OYOxYySdEPVdYmxG79nBnGTludoTujVVH9j5CF936FBi2uEeCqdUxH3zLMtE?=
 =?us-ascii?Q?oq9DDUHVwpdI/OvWcdReb086QeCbEXYsaAbhOZCdRJTVeFSwy3v2qhmMtOpe?=
 =?us-ascii?Q?EFfHuBQ8QePDw4D7GpgAoehRoKHPne6mGE5jma0NwxsFIeqPkv4JdV5dKlpB?=
 =?us-ascii?Q?lWY4o2glil4kyyj53rNDvcGRaX3PLQHrh/rDyYOA7oyxupvFh4qWUG1RASWd?=
 =?us-ascii?Q?BHaudbmOCTD+trdwd9BCU/NpBVpzF+Rtmzg3WcO3CZ8olRTp5wEoTBQUgNPd?=
 =?us-ascii?Q?+v2/2cSmPCKegT5ac3f83DNqVvCuiKz9HRZ/Q4+KTzRCEo2dCqXriiylgbj1?=
 =?us-ascii?Q?teARph9BsuGNOaoN2whL5XZ5jDsqFYHtBj0fwXO0dfG2u9FdUqxfAW5pHY13?=
 =?us-ascii?Q?zBdmB7upwXq2sjjC40p207Ql52HkiG7JarKpo449gcZaX1bsexlONtWY3c7G?=
 =?us-ascii?Q?jht4/dT/ZRZ+uf9TnCZIY4c5/gGt0EUjRuMi0P11?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tn1xirgt867hxql2NIctyr2jHzsyDnbpjCaC060oGdWCX2N62agZ7g9WQ+JhrkwPZ1kUE4ayUHXxabGFE2VXhizyiiaeBx526aWFTK1bcAXrWDPgxgJtmc+eNJbP0IKbP4Af4SqKj52OmgxwfAVGKFsdXpjMhzjlO6nHRe+9vht7JeSlYZptwrgTWl+36fx0b7sMnalwlwnjGgEnxeyyJf/3bvtK7ttbmCA1Z06XdN87lQX6w4rFYVUB2JQGZOSMCKBx8rtCiB/YZRAzwxph+1a0yIlB6+6NjEk4MDCYmwXl+7Mr1h4TolMMT9xAf1a2/j+YHkeM58TMsnHgMyCno/wr1E3eXja4gEJJeyKomuhVUeU0LmM6yk0SqVU0nQUQicM9UWDO2WCMdkyebcbUbgKuBF9EQrShMuY/izdXM7aO/4EXOby9zozndWqGW5sLf2lK+Da732DDo806TEMMPds2IAX/3BWi/dWr+Bpt6tPufWQbAu2A0tjZiOpY+Qf7fIDARKeJpZtPhTGrbp3cvpA397bcNaOgYX3dOi6cxJNtS2oYNquD3qgalm04TnPuAvNX4Wfb+pw+ELhWxUfCfBYWkGTPmdvpFQhDwJUo8qA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7269c3a4-ff55-46dd-9f3f-08dce8aa42e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 21:35:14.5521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9doqwCcZWjlRpWqAEqnasS9ZmtLYMgFq1ShuSsap3Y71nWEkCc8lBt3bAX0eKoqJHDbXzfhjTTOyy7yaeYHZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_20,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090133
X-Proofpoint-GUID: wnmBgLexm96K6DL9IxKfksjFo2mMXXZR
X-Proofpoint-ORIG-GUID: wnmBgLexm96K6DL9IxKfksjFo2mMXXZR

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241009 16:10]:
> Add myself and Liam as co-maintainers of the memory mapping and VMA code
> alongside Andrew as we are heavily involved in its implementation and
> maintenance.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 220c1a01e361..8ebfc520e6e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14913,9 +14913,9 @@ N:	include/linux/page[-_]*
>  
>  MEMORY MAPPING
>  M:	Andrew Morton <akpm@linux-foundation.org>
> -R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>  R:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
> @@ -24728,9 +24728,9 @@ F:	tools/testing/vsock/
>  
>  VMA
>  M:	Andrew Morton <akpm@linux-foundation.org>
> -R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> +M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>  R:	Vlastimil Babka <vbabka@suse.cz>
> -R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	https://www.linux-mm.org
> -- 
> 2.46.2
> 

