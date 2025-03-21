Return-Path: <linux-kernel+bounces-571693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFFEA6C0CE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237AA3B39BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5E522D7B0;
	Fri, 21 Mar 2025 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jwhaq/rS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xQvPJMBZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878392F43
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576675; cv=fail; b=oz7in25djcH7Bl9KKjeg76gFAEuxQD/Tb6pPH6I8cv/QKOc1RKVC04ABQ+zIwXlAnP5ijub34NHaBkNqJ3/btx+nIDjrX10cnb2l81NJ7wMiO/jXiOJ6ihTvqYFlKCM3HR0y6eTAkAsyTk+U4t6NX0LXNg28vv66/CyRgI8xwDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576675; c=relaxed/simple;
	bh=praWsKJDzmSzJfMOvKiF4Rnn1ThuBVwPnsf5TYSOdp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R+IK/ns06sMeInL/343ioURm+deJ/MH3FqmLN0/LLkVmeD8RAvtDnJPBGFoGENUZxW5tNMgnO+dm4MiUtil2qoh58Vwym1rFXme5yEc23m+NApLIFc1NXQVjtlxMDy4kJe9ZfYFmulfaNsCvf8ZvOzYEgH4JSttcXaJu9iwKwT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jwhaq/rS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xQvPJMBZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LECGSW024922;
	Fri, 21 Mar 2025 17:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=praWsKJDzmSzJfMOvK
	iF4Rnn1ThuBVwPnsf5TYSOdp8=; b=Jwhaq/rSfgtKw0kxUC7gF873dUNitz+EWl
	AknQ/1Jm0oPo+SFSw7Jm2JNpMmaQWAj0Pgg7wG2XoNW+OwmQSfRB8NEYGIfidk1h
	Qt7VxxZbXe0RkI6G5tICmGgBGoMfTqkKYn97TaYTBtJyHdNQBhZOJmKdCcYPYW89
	uLW8CkAyRT/RPP8H5d7nP3ooJYM/Ieck4OTmy0nfJ+A3MFJhs7IEeW7kcnZov/tc
	UVGOHbiSkQqCg4SDEOqwVMFn+8hZWB7cL/pfIgI8bhz4HOj0e+Ehr0UbsbnpkcVX
	ExrOsvosbD3RphueyJz67B/wkmXzLrqfWY6gxwDf44g/jc3Q7UJA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbh235-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 17:04:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LFhrUo024459;
	Fri, 21 Mar 2025 17:04:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbp379k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 17:04:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfQDY4jzw+BI5LZDhen9/087TctSxwYPYf6dkhhwQfXls7Buu7oqJGz2YiZ1E0rUJYP4Be3++E+wNYTZhW9w9EptvAfwP2sYCrlBf/Rd2oswmbSiCn4gcEtzPxcUF0opYazXn4HacAA9GBnveSNQEdXlCKS49hIhKMiixJjAOhpu1pnbBbULKFJWqV6sPTF2IK9g4g6nqZNxMxApH3UT8uBlou462VZTObZFY7g3tLeTrUa2Y4fwdxMThoNGYnGjcjI8Y0brwuDX6PJEuSVEhP/gILAwNx2vEsxVoQ4SLvL/9XOF+VJ9PqZmmI6K9QJpumOsuKFrkr8n7uXvDpDLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=praWsKJDzmSzJfMOvKiF4Rnn1ThuBVwPnsf5TYSOdp8=;
 b=kLaNOGroHhCiJ8g0KcsxTfamMfSZgyRlxjKV60rxhoQuHgh8Np1kzJrngT8JZ6k2OaZKzfrDdvoXpHNX4EfJotji3930Fp9PHV1h7xO/XNvJH5LstqTicWC1bnz3cMwiD1Kmfc+QFsgkdlXot7JR8dzhhYGF74kmr52f7PqJFQJNdq331u/K223yRZxQYIk+te1Fxoc7YPUeO0H340Iql7ThTMfJp89pqXZph51c17SPVYjs30vB/eHjhigd0wdKHyaeUu1/zmDmnL2durBtoqeK6YlydNCR0JifbeuBjHDknGpf3a/3BrbuO2vCUoftjZG36k0caVHakFp8LQsIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=praWsKJDzmSzJfMOvKiF4Rnn1ThuBVwPnsf5TYSOdp8=;
 b=xQvPJMBZmrWc/fZ6VUFpS/TiJjehuFisXWpO5EXPDwNjuOhngQoNflR8W5salTfY/V3GSzGKRb8KbBHjXfyP5krthEqK8WOarZNy5UIvpi3iYmjwnxUB47UeQPAqk8fCNjnUKCa7MkylQ7bj0mMxKPjgWk6uegEea3HAHMvyfng=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPF558EA2A2C.namprd10.prod.outlook.com (2603:10b6:518:1::7a2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 17:04:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 17:04:19 +0000
Date: Fri, 21 Mar 2025 17:04:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.15] mm/vma: add give_up_on_oom option on modify/merge,
 use in uffd release
Message-ID: <d7f8e2e8-1670-49b4-a9a1-2ca236e9d5f9@lucifer.local>
References: <20250321100937.46634-1-lorenzo.stoakes@oracle.com>
 <233o4lohzhriye27szk6mucduneuvosmnp6pmnjepz3enxjgtt@id6kwhjgysbj>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <233o4lohzhriye27szk6mucduneuvosmnp6pmnjepz3enxjgtt@id6kwhjgysbj>
X-ClientProxiedBy: LO2P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPF558EA2A2C:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b209211-2e9c-407a-b5cf-08dd689a6b06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1SC44O+U9DMFJj+KuYUySP1pXM3l7w+zHMxQZ5kiCOzNiI70SEEM1RGRb3Y8?=
 =?us-ascii?Q?5m+5sDfARy/AHCsbsS945BUK8OWYv+9YwZQWecq1SbSvZfePQmIjZlKgDs/S?=
 =?us-ascii?Q?YV1pf1B6pBaqnHFZdFjuiI+r4oQP8a8efOr/dXzw8EVSE8F095lwdO/hlvlt?=
 =?us-ascii?Q?RSA1IFGgstNGmT+r/d/HZ4pcq/G6U8Q3+y4lbwAx3A5Im6KRjPPkQUxzC12F?=
 =?us-ascii?Q?Y0CTOiB3dG+yVSD86hYFHdY5zM1W0KUPxxfSXwXSZxyBlWE+Z8zTGInYbV+i?=
 =?us-ascii?Q?v4koHudrSqCPTkzhykVDZc22/ABCYCG5sK/A3XFiqDVuRUVp6k9da1gya4gh?=
 =?us-ascii?Q?wgxaSilg20F3lgbOMECC9JL69SBgBO1bypKCIQKCpM4wYSShxkNMfAFzArob?=
 =?us-ascii?Q?qkwy22eoqej1uT0CtTeGhVMKyQBhCtYZ2uI4oLcV9yh/O+jwSOPmTvR1D7Td?=
 =?us-ascii?Q?RzzDA2fVJxGt32+MocQILPzseRTQS2kQBhV7cQUnw+N8ecLWvfUh8HsxSFm+?=
 =?us-ascii?Q?xnN2hCerDXjAchEbGKiOPtvHmaLF9mTdzpzwkoJyNlG5B9avE+B3h/zX9lWk?=
 =?us-ascii?Q?xBuoroAGTkMV+b4g5I0WpLh6m88pxji6enXXrUecckNlSfBb6CMVxNeJxFaf?=
 =?us-ascii?Q?Jms+chlGYOmROjhtxHPPixHWz/wgJ12ei2MVZsxO+dLcWBil8WrL5UJ3Vd7m?=
 =?us-ascii?Q?1q67eB89yFVUKVuo7u/a6b7Ly3y8hTFPEszNiXYssZHtppZKhFrxegwQqnwk?=
 =?us-ascii?Q?4zo6SoAFSDA5iw6I57vWu2Jh7Z6xNFbe1rmli8p5Nl4fOd0jZLVNZpCDf75M?=
 =?us-ascii?Q?VuMDR3tvD/1PsTZqzOYZlHMUQ9aYXRF+ktV/Tn/7DWnr8XvLtEJtD57HSABa?=
 =?us-ascii?Q?qsUn7MV5HTfsoKRvkL2cWFpz4+wy/gQ05WvHGCixI8xYxDU5IryD4No8HFYh?=
 =?us-ascii?Q?IRWqkdZsFY5dakSjLAIPg+sziH3y6KESwmvlQMuRIYseNEdYmKZJvy3LK2nR?=
 =?us-ascii?Q?gWYC0NlJ117kBNUTvU0uiS8apH/liAvJFlYIOk+0Vuz6fESAKVFIPPQdHY+P?=
 =?us-ascii?Q?RQUzOSE4PcuQexkSF0XlAYgzIn8jzcr9xDdqOBLXuqjG2skvejZ98lkoY5t/?=
 =?us-ascii?Q?bsHIFOiN3MEy1KivIFtyuKRwH6h2wsa4OW1wRpFq7GwqxzjV663iZqcEsPvm?=
 =?us-ascii?Q?iNyNOmvuHkplWERtDnVkQrflI+xR6Zc9kM4Vhy6cZQU6hccaByQ/PF7aRYTL?=
 =?us-ascii?Q?VPuoEQSau8sqVXKxRit2xW4HdUf+AzfBjqyDcsJjHT0NLWvcJLUtTbEkL+SI?=
 =?us-ascii?Q?Bnkkr8FKjn1AF1Gk8xlx6nN3U3PweCNzJN8v9wxy/OsTjQZuqD3YoKW2n179?=
 =?us-ascii?Q?VUCHLva5iGkKXagla5M+pt5WLEWo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?amlGguVVDWeOiuxov/LzQDz3LJJTWYKK6Dnxur54Se5uRxI83XnlFkfmFgDE?=
 =?us-ascii?Q?UBQuiohfeFq15jomLhThqDqLzDY3KywitR4U69OYKwG7mWzr2fmgEtxbIaM9?=
 =?us-ascii?Q?xzV1S0TA5Ki1US6IkObzgMoQf2/SWUDSB3nU7/H/a18OKJ8yZMMr6cvwg1ct?=
 =?us-ascii?Q?wAd+0yyjj3IH0tfJ0YvoxKGGffASSjUAHt7jMrc95WU+a8sYdL8+PJPFcfyU?=
 =?us-ascii?Q?ZOEFRYWfoD3rcAcNu61H/HawvizpV9SM981l+MZMOnYkn4hMFOvKUQ37hAp2?=
 =?us-ascii?Q?C11bKwecMrCfqE8arbKs6d/K01OvNiI0pz0ql0R21/GAiU5pIbq+vjrsqvnG?=
 =?us-ascii?Q?vk5OMJTE1EjQFiQUVaCReUkU98FaidedBbwVIERu3fo+RUNk3g3H2ZwaxtEx?=
 =?us-ascii?Q?8JclBAdGwwgTtBAMFeElpjH51wwe0mcPkujydatHWK+AGmdp+ZrctfcE8VMk?=
 =?us-ascii?Q?TLqcW1e58j7uLvKrhDJEzDlLSKcda+An/Lrz/IMl6tNwQulRYv7oD+5YLncs?=
 =?us-ascii?Q?bob2AAWmMfIJh9+nEBaOivxi0wqMzb12LpIONABixxxQxIubTYgNYw9MXfVu?=
 =?us-ascii?Q?mWN9w/zFRV4VnKcgJ3E3MwmRsCuETZOAbGJzF5+yCSqFqbcfdLaTzPMJ8ldm?=
 =?us-ascii?Q?vwjay8Uuv3Y+1KjqC3dMhGbKN5lQ4PK2emArHkqjZAqX/GdTpcqDuLcWnaen?=
 =?us-ascii?Q?F2JpRjhoj6KWiOvCFXaAiWlEMJgssLgBVeqqDPh4Klj84ma8q0aHbUEqSDM+?=
 =?us-ascii?Q?R1gPXINwkkOF3zOPOJ7hB9jcthg4gn0jWcG0teNaT/QI7qp/lvZkGo2lPy4r?=
 =?us-ascii?Q?w8tEXDgvbcoCD536JdHSzpPdGXUronyNwbN/R1neIJr+sWR0xcosKnVa8P/h?=
 =?us-ascii?Q?01UhJC/ppyjXtEQhj0xloH1RMCIhN0oIDcsLAzONm+1EQ/CkGTiUwEYaF1Ec?=
 =?us-ascii?Q?hGob4EYyLfIAD6GwMopEM8CDFSumD2RPe1aCG1bp15JNM5CDSv47h4s9rlol?=
 =?us-ascii?Q?pIXu+2/15PM4uep4AZYSOlLKo4KsSz7jBqzK5ITyUe4fcsvNKsEklqg3oND1?=
 =?us-ascii?Q?lcfonb43/Zm8hyQpFRw6rv1Id+S8NTTguMYhcWcW+HS1geLTFt4XbOsQw5fd?=
 =?us-ascii?Q?yMtu5rnclk6RMvhrcVBv3UdGT14PvILFMtVzZOVb/e2jUkLK0k/pMIYUeb5T?=
 =?us-ascii?Q?wrBZw1ul1RJ3zXRoqME5cnCmv/GjiLLPxePgeTlHqxkEkYcik8uvTNqCb4Oa?=
 =?us-ascii?Q?5vFZBV9Ufiq3jSy7IdagdH7SneBPFzH0h9AUIG2k/VHmiHu4cYeZA+yVGuRG?=
 =?us-ascii?Q?COoSBHHTRJg2DhVpUeJnMqaBdDsqPmKhA+ay9Bj9VgU79FYmekYug2N7mr8S?=
 =?us-ascii?Q?qQWU6wBvmu1MTIIrNVkApzdt/2+OvnwCL7LM5XdCbZiviFdUfdaoc03g0rpy?=
 =?us-ascii?Q?JV8RoTQE3dhojq2m8cFbfmhTQLxH4MPHsb7J2x6RUuXJCURU9E3s71AoYWdl?=
 =?us-ascii?Q?mOxJsp0hSvTnU3VeVMucu5XO4RtjZhUoWhVxqcSYRXj/SGZ9l9d0jECXThYh?=
 =?us-ascii?Q?j3nVejgpVomnoKam4rqKsmDWxcs6S4bWAP8i1SDDi1U/X+T1OgRatKapMPMX?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HfVpM4V+7A+M5O4WVmCWE+0e0rpwHWdCLevGjHImv75caWxmeB0EOHgOPK1A5OR8mzbfPeUzmITxC0QmC2mRs4GpT3BuuOn5QrOyN/vfgoj9Le9u7x8cDbMnkkbru+4JD/kh+GuMy5Zy4F9a8mfPpGs7N8rtDGLZPqx9iUc6b7HYX4hyTUl+i2GyTfQj3/47Krm7QI1hNyL3kM2irA2OWjISJBCG7n7RUckdewkxRJLwmNZaIBoamTv/YfD8ZyKOfYYIOYwfUA92XIlrPiEvIL5kCF7o+hMsQSQ2nIbZE2uKFI1NUD5qYQzdrztHBXH1IcGWtOvr9Rnnk99Orwx4Zpgudfj01TIu2i+THCLjP8cqOVZ4+88V4Grn66jwMzRKAJh2AG7blDzY5+JgNovk1GQ39TwlLYYz7bZbgEMqJaivuAeQv+OUh4q8k6EgcTZ1sFaUrkMvbe8esapYHJIE1rhN3uo6JS4pOg07Amgsat9BX1dKPstYTrr8sLet81WIt7g0XFBHIfRsFY8hguz6GXCSTn2lS36fuiMJ4Ap6PTyYBhLpNq9XkswH++Uc9KqajNwaA35DeQgBcozt1eRmjw1/oDrL1Y1gEO3s/VP5+IE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b209211-2e9c-407a-b5cf-08dd689a6b06
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 17:04:19.1141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDagxF7RN4VATxHNVkjdoNSFroiqRmOS6e2nYErdVOlpSRtwOVD+ze9rHJuDv/Uwc8NDTRZ/hUkMMXuY7g74L4VA9RVnFzgB+CYoQ/xz07M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF558EA2A2C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=860 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503210125
X-Proofpoint-GUID: Mu_Qn_XA12hZUKyEFsDbdnxPmldd3v5W
X-Proofpoint-ORIG-GUID: Mu_Qn_XA12hZUKyEFsDbdnxPmldd3v5W

On Fri, Mar 21, 2025 at 11:26:18AM +0000, Pedro Falcato wrote:
> On Fri, Mar 21, 2025 at 10:09:37AM +0000, Lorenzo Stoakes wrote:
> > Currently, if a VMA merge fails due to an OOM condition arising on commit
> > merge or a failure to duplicate anon_vma's, we report this so the caller
> > can handle it.
> >
> > However there are cases where the caller is only ostensibly trying a
> > merge, and doesn't mind if it fails due to this condition.
> >
>
> Ok, so here's my problem with your idea: I don't think merge should be exposed
> to vma_modify() callers. Right now (at least AIUI), you want to modify a given
> VMA, you call vma_modify(), and it gives you a vma you can straight up modify
> without any problems. Essentially breaks down any VMAs necessary. This feels
> contractually simple and easy to use, and I don't think leaking details about
> merging is the correct approach here.

The vmg passed is already 'exposing' merge and has flags you can change. There's
no contract that vma_modify() abstracts this, you're saying you want to modify,
maybe merge if we can.

Uffd is actually calling it in a purely special case - one where you would never
split.

I mean an alternative is to have something not-vma_modify() do it, but then we
end up with code duplication, which is why I made the unregister + clear paths
do the same thing here.

>
> > Since we do not want to introduce an implicit assumption that we only
> > actually modify VMAs after OOM conditions might arise, add a 'give up on
> > oom' option and make an explicit contract that, should this flag be set, we
> > absolutely will not modify any VMAs should OOM arise and just bail out.
> >
>
> Thus, to me the most natural solution is still mine. Do you think it places too
> many constraints on vma_modify()? vma_modify() on a single VMA, without
> splitting, Just Working(tm) is a sensible expectation (and vma_merge being fully
> best-effort). Things like mprotect() failing due to OOM are also pretty disastrous,
> so if we could limit that it'd be great.

I disagree, again for the same reason as stated before, you are making an
implicit assumption that an OOM error means the VMA is not deleted. This only
happens to be true _now_.

Having this implicit assumption there, which later might change, is _precisely_
the kind of thing that led us to this issue in the first place.

So that's just not workable.

A version of your thing that would work is where vma_modify() itself sets the
flag so we -establish this contract-.

But I don't want to infect all other callers who don't have uffd's problem with
this.

Also, again, this is a -uffd- problem. Uffd is calling a function that can
return an error, assuming it must not return an error, and breaking if it does.

We have to on some level have uffd say 'actually we rely on this'.

So, ugly as it is, I feel my approach is the best for now.

But to be revisited!

>
> In any case, your solution looks palatable to me, but I want to make
> sure we're not making this excessively complicated.

Thanks!

I don't think this is any more complicated than it needs to be, as Liam alludes
to in his reply.

But rethinking this whole thing on a deeper level is on my agenda now.

Error paths are an ugly pain anywwhere :(

>
> --
> Pedro

