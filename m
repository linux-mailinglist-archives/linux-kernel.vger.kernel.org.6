Return-Path: <linux-kernel+bounces-413316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E800A9D1733
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8861281278
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5651B0F24;
	Mon, 18 Nov 2024 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MdMvLNlW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DlJbj2fz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FFEC2;
	Mon, 18 Nov 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951268; cv=fail; b=nCm+HudcQUoWIxVep5zZQ6egKXwgGeEgS+Uey1jawFFhB7uWx55ObBFuuDAHlhegHZmXNoSdJAmMttkiyIpUO/ajoBtVy8CdjraE4NC/N5uUQkG5warPD4tE2MBx06SmwfhJpagFE1lCfJNLLDXXaHs75USpzqBwuMhhVhXlCIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951268; c=relaxed/simple;
	bh=K7KB+Px0hZTAS6qwAxZNq0fZIHU7gialApcjpitBmQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hgFqiTGYzytlTl51IDyyg1DRu4sks/W8F8K+cKIyAdEHTMPv6k8Mwqm39eRfDNazjeU2zvBZhjNUxKhocMoq5/OHuWRrTARGKjWWZioglEfBpVBpHY5FVK3t0Iolec8x9HtyRssaCs1OYW1TEGskGsTZyuOcEweEp/oF30rNQwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MdMvLNlW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DlJbj2fz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGeVqv012255;
	Mon, 18 Nov 2024 17:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=gDx6Ygnfasy9u2dqbI
	aOyPRlW3yZXD3uHdtLg1uhg4U=; b=MdMvLNlWXT73Di/PPHn1jDR2DDAJXZXGY9
	BGqvt9RNo8rjmrrDL/pS7sq+4sIaTLCZq0azUdjOpRd5NAlG73o8l3RQTcW5wJmm
	NPM4QWzDXBaln4SHPxflbCUPiBhfdkoWJyeSrXDytdlMNXGgM2JomSj+Z+z5KX/k
	NwimDwRFyX+I5zOIfxa6X7JGqNCJcZg8RO1dpGrGvM0Bpf2l+i6BcywV2TK5Ld+G
	gifW5V1cmsGac81UI+zxBTeOHsnXtkEHFmKKqt4CSBe+Jb4GdgSOyBN5Af3dkjZi
	HO7hEqj+y5GDYiOGjNuoXYLwtbfKSvNDyMyfKq40QqGg6VFPGCaw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98k65j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 17:33:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIH4tZi023091;
	Mon, 18 Nov 2024 17:33:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7rd48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 17:33:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twhZ0+5Sf+pZw3qXsEIWkVtg1SGm4GCY3nfBRmUEWGBl+2mq7Va5jkNj2SPaoGht+1bCRccxleXWgZAafkLdGyVGh7Fov2yRI8vE1Pvj+15ufu16Ysa7tDzgQm41lQiGcewABAl+j0ayvCskMy8CBMwDvFfXm9xOnFXib59lc+8U/sgZHLYEODUo2vXpTlyA7VoIaFj2/VbGCQPoQkJ3bI5JLiTvtUSgsfy0d19qHNxi91PErmtZNP5xUBQ08wM5N731IiP1Db8+rGCRksU5IYNC477SDm9adYIT0SMmJH6UPrYwEmz6gvKuJpVCuZQiKuwm8Juzsim7fykJZB8l4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDx6Ygnfasy9u2dqbIaOyPRlW3yZXD3uHdtLg1uhg4U=;
 b=TvhzvALDxPHcQFgVktvfWgVGbAVZwSWOu6ByqWyC8SXD5471T1YoAzgkFLm3xl7XtP2iiBK/WvGGCBHhkGyAZAwMszb7fadxBDlXPhNOXOCG8sBnHBhDqTKn8mTXdnGazjH4ip34+PJLYj3wQfhcXbjgB0WuFyrAD3grGD3NH1byYFvavhbNiZMTOwKWKigBYxCCM833+BVIjR3kvRmb62zPVdsEc2CsHmwKBfAUbTR/gUHRwwt9hGmS1PXvFCyMYzOqJNzCU/VpNpOa/gtIelRMpkY+qQ4mWHdajjUEjAD48M9VUroOAT48LV8bLj0Qh3U5TVMGJ4n1BYgYcgO4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDx6Ygnfasy9u2dqbIaOyPRlW3yZXD3uHdtLg1uhg4U=;
 b=DlJbj2fzE/uXNnIfYeWPpoDyfc8LZwZih4hc3+drcYJ9zX9+J28H5HlorlOXL6aDaux1+5nsRvsncjuTXEHQ2Hts2HN1EaaMf6RGzC7Cn/LBGGdQgoMdo+6E1h7BXWoOwbPW/EiPufXqRDy2daDILnHjOHMCMwCuCrfoZBcQKnQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB7492.namprd10.prod.outlook.com (2603:10b6:208:471::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 17:33:48 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 17:33:47 +0000
Date: Mon, 18 Nov 2024 17:33:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matteo Rizzo <matteorizzo@google.com>
Subject: Re: [PATCH v2] docs/mm: add more warnings around page table access
Message-ID: <904ef000-a2b0-461f-b5c3-6de0672c6ec2@lucifer.local>
References: <20241118-vma-docs-addition1-onv3-v2-1-c9d5395b72ee@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118-vma-docs-addition1-onv3-v2-1-c9d5395b72ee@google.com>
X-ClientProxiedBy: LO4P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e273eb-b5c0-4986-679c-08dd07f728ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vL+hBqwMnIW8DreNMBqPljUvuCQQiXnNQq4mVU+gyH7zjSdbMf9DKz9DGjgq?=
 =?us-ascii?Q?gixdfSUzrXlXgZNJy4M3yv+BtXGMSbYsuKRKut4hnlFKkdMOqAwtsNwywKKj?=
 =?us-ascii?Q?9yNM5+8UvbGiTbujVGP0TJMnSlx737iZKT00MqXW79aEOUii1OYix5xfACjS?=
 =?us-ascii?Q?JnIP/l4jpjfHEVjBKtVDGW83wHR+PtcusLbncqqPQoWtFgUmtm4nsJmb7PSl?=
 =?us-ascii?Q?98z/yaGyL9ejAjQAklKVww+Dd8eL/Y/6HYT4nHcovGsxGgEvvmmM/NZnfo7W?=
 =?us-ascii?Q?d1gwWgREvIhlXv6NhWuLbJTND0K0PjuSF2pvh0yauPLfSyz/k/h+92gBXBZq?=
 =?us-ascii?Q?jjRGr8HOgDv8BbLgljwmxnHGXTet3ArzLvH8hOxU0iJ42RU3RygebsyXOQMb?=
 =?us-ascii?Q?oBJqhsCpDsFU8sawEq628M6X7v4ULX7m2FgP+Nb98wIx6iAtexuAbv+N0Hjj?=
 =?us-ascii?Q?QAS1veylI4Crrkfrrq7M7I0qrRQAdF/wvWM5dvU0p92C3hK3+8sF8DOnZOv7?=
 =?us-ascii?Q?SsD3Hc6A+w08KEIq/kof69kOEPOyiCSNQziM2BIFWPdu09DRo9Z+/QZTIJWz?=
 =?us-ascii?Q?yHyEIUBPTse1ynCJuRMm1sQvtFbUk4ZSIiKlexd1DRiMirG0iEKOr4QbbcAU?=
 =?us-ascii?Q?o3RU5fWkJT8lZWdwazqaXUqW+89F/ydDcN83zCl2PzZStn/r4jhFqkm5cK8d?=
 =?us-ascii?Q?Jyk8xlXicO8mjzDWhDVZs2wyq15AT0ayL8dMgHgCj709JvrWJu46uLzkme3T?=
 =?us-ascii?Q?YX6QvxkifrTa0KYDWzw3gpTy7ssMPCVCudw1byDDWcT7rcrFZ/an1BfgFHep?=
 =?us-ascii?Q?QCB5Fa/spOkJq7H9khZ3FCJmV3sziVtbt1RUGFBEVRyuqhVIkODEp4UwKC/p?=
 =?us-ascii?Q?xjLcKhzjB+D0DZWmh78MEilklewMn8s9/jsej1u+lvJ+4ucyN+JY4RPJeNho?=
 =?us-ascii?Q?ERKtyc8tkhnr0bAswOyNfqXh2lfIO+/XFpiRJReKTaXTQvdG2yjv2sZRkkE9?=
 =?us-ascii?Q?ioLEZQNaxM/iHc6/tiNpwjDZ4C7QA2wGTZZsWjjDEVlQhOs+Pl4spDYizYF8?=
 =?us-ascii?Q?EXnnkEe+rroCgLE/BHB4Vf8OaLSByeGZ80kZ8Nuum3q+0B/ktxo2c4qLZ4LY?=
 =?us-ascii?Q?aJW0iyBAqseVMiURKtgg+EXFV5vSThbIPpodB8pZ2/8WhQFL/Gs7oATtxF/o?=
 =?us-ascii?Q?gUBBns+DR5xovjKf4S0MM1LpMTWfyrmYbSRNAYeOcKoFDuIOkYLiv/8NDCqB?=
 =?us-ascii?Q?+DLtzE7L0/HMwDyla4GUvhazZ+viY+BLlBDWF0jNjQ2FrLh4zG0S3utu3ORg?=
 =?us-ascii?Q?EVUPNkHmxGPJdq7rhAVYSJeS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wz/53IB2iEO4mvA9pm9BcXRXe1bB4yhp5bVJcwUKzdRjhpoPsL/1cbZH1B++?=
 =?us-ascii?Q?lNnfRAk5sKDMn9Lyyz4TQYBIZqKnrkbpFqPews23pXSnCMM4FTiju3ATz8f7?=
 =?us-ascii?Q?cz+37WK9e84gBtQSRmfsHL1Fo38bJJFLiXq9wfHuFrJwrMaN6KZShbFj45S4?=
 =?us-ascii?Q?7Jw1KK+dkGxJAKMX7iJKxzRfE8d+hqXf6rYXM9GfcQkDQNn9dfRoCKzhufkw?=
 =?us-ascii?Q?gTGPnLoH4xHHDY2bcUhM7iKJN2r9zfpy77I7DGIMKbcYMfgQioB61vWd6hwE?=
 =?us-ascii?Q?o70Vp2pReRuynBvXJSxR1mJoPCM16e9fS8VMZupeVVINIulwISymLu4y11FJ?=
 =?us-ascii?Q?7hPn/OKzkYdzc74EfL8tCbq1zA67FHtQ3EmOxKkCF0X5g1Lhva/Q8S7DRwEJ?=
 =?us-ascii?Q?Uk4zFXMKhdimVaLDxk391ZUCLbCNucXJW61WMsZsi0lfpqyTOGRw9BpgZ+eX?=
 =?us-ascii?Q?98Manx8ta/Z2hNOmHR/KPqnPVtuIcbLliBB4s5/pjXGdC2rCUcQyDYRpnG6I?=
 =?us-ascii?Q?s1KB8Lc0iVL6aJTE1xFnq9adlRY5UJPph1ivdkOWBvM5ljR3SdnPqQvsC+zk?=
 =?us-ascii?Q?NzsdS/Z9B+8h1gX69d8+xAO8Z/XIXk1oSXGbDrRvhb8SPoNvu/XN4xph4iD+?=
 =?us-ascii?Q?5LyT0U7HIZMW2eoyfHwOZ1IHnrPfqzhgn5ZzHXW/n7bxjVADpOQNVF079xYS?=
 =?us-ascii?Q?GreU6xSN4EuWkbJ4ZQb/hCr1efcB8dksIOloN99a9GLqaCe6rM4fpeScqSqH?=
 =?us-ascii?Q?+LWyfKHfiSJb9H6qBZpko2KZP5H5uOQWbHicjmBcVy1iw4Y5BIeH/M73Q2Nr?=
 =?us-ascii?Q?xa6esw76BCVDhCUd6OMD32nQ0NceLw9mQRJWu2nXoHB0b+AiWAVkDclt78C4?=
 =?us-ascii?Q?8iNXU6HCyokfINyi+Dt+OyT7hqHprbf14v6e3BECd1EXO0waPMk1JvvXDhdk?=
 =?us-ascii?Q?deYU5H7dWcemPyhHGPA60zwrlaRii8aamqJmQPW1kjG7ZH+PHIk4nZrrEyvo?=
 =?us-ascii?Q?44tw77vMMByrjE0GUjuZZ12/X+OLzdPxAlcj4aXDs3bXHOoXcqZSdveHb97F?=
 =?us-ascii?Q?Kg/tvsCpRgBMOwkO2IyVGYiSqH/tR8eapjBitwERnK4ewkJx6ZHlohz79rza?=
 =?us-ascii?Q?tu7Vprc/sUqvZzRt9mgJslVgKEM5YeInn4CyPBPGpaAaWMZKgfVHRUsMRTGe?=
 =?us-ascii?Q?8DYMBELflCLSHPgkArJkf0ve6b9NHl9Zq9C4Y/1PHCVFEsZisRispg9FdtcY?=
 =?us-ascii?Q?+dlULqUZeCP4QJ375xVHDMhzDmrdAyVL5A4VVEQpHx8v5TbXL0iEczrx4HSA?=
 =?us-ascii?Q?lNW7uWXW6aYU5NtOoi4X9H5bcy8OADJ9VE5C8nuuwSx71LMI0Qut7YgPquc8?=
 =?us-ascii?Q?fLs7w/taNnG+82HqwrEOS42qXqW98nVn3ggQihk+0aB8PHwwaB5+IJxSyo1f?=
 =?us-ascii?Q?5+lscqVpA5UEdjN58/ypyOQMClfLMYqs+Pb4+5v5r6lo0IVlxzJu/0Ijylv2?=
 =?us-ascii?Q?H+kiBJYFp0hDzEFR3CFWimiLGNPrnw9IuCw7uJpTJ9ftJ5BW0KNfImyI4ZlL?=
 =?us-ascii?Q?sxc4yMbqGKJ4JCSas0cpJyZpi6Wkl/67N/mNv4qIPd9iy/nb4ThH1E3Uh227?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uznYUhnX6Eov+Qd4h98rhAjPoceLsNpP3+vOusWLhoJQeAOA+kEqpEzeVhtbcDObpuQf3XuqCwdIcHFcYJ3FT/53yFQDb7xMd7f9FkqHSuLiD6UusqTbke1+SQZJaWkeSYql090PF1sVeRU66jtcsIePxhSYg0k5lI5tp0UO0PrLKHpYn1wGfXxWBD/qso8VyDmjxlfpmOp2obfcd7AoxgA7FYllbFsyq+ZsuVYXwvZqPCBn0ig3wIGyiofg/EJTiK9IPWvRyRtlHsEqd5mKrYFszl+HL9HGrQupi/Vebkd4z7sgU8n1+1sJ7gY+42Oxk/oMqT2PfI05c+l29/+3v5OG5icg0MjfEwsNoKOXlVm2+h27D7JJ7p799nML0x/TK4cFqBhjVevtJNe2fQiNaPp33TmbhEPoXaTv64J2l0dgIFfwz0/IRgD61DpK2lr8GkBaUtazH+FC503uhjlwcL7TtjKSuiwus+y0TT3CMVBEK8AsUvzSBjKCs+blhTBeh3nGpZRmifxd/O6kJ736gq36DXT3h00J+WftC6HPYnESnKZZzRHGeHbeKYqXrrteSq7pfZcowoxbELvqw5d3g2fES5QISwr1/XizJNJ4qGg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e273eb-b5c0-4986-679c-08dd07f728ba
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 17:33:47.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/ebP5kKAU+RJE+R2RHt4DQfxOiVG5EM3jfYW1kg8yCzAgVlPZ9IfJage0BifntYF8b5UwO/r1WdIkN8FfpweuRm9S873BOeRfOZHbc0IxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7492
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_13,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180146
X-Proofpoint-ORIG-GUID: sKsosefJEB7C5sKxrs6bBPWTqFNs9mcN
X-Proofpoint-GUID: sKsosefJEB7C5sKxrs6bBPWTqFNs9mcN

On Mon, Nov 18, 2024 at 05:47:08PM +0100, Jann Horn wrote:
> Make it clearer that holding the mmap lock in read mode is not enough
> to traverse page tables, and that just having a stable VMA is not enough
> to read PTEs.
>
> Suggested-by: Matteo Rizzo <matteorizzo@google.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Jann Horn <jannh@google.com>

Nice, LGTM, thanks for this!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> Changes in v2:
> - improved based on feedback from Lorenzo
> - Link to v1: https://lore.kernel.org/r/20241114-vma-docs-addition1-onv3-v1-1-ff177a0a2994@google.com
> ---
>  Documentation/mm/process_addrs.rst | 46 +++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
> index 1bf7ad010fc063d003bb857bb3b695a3eafa0b55..1d416658d7f59ec595bd51018f42eec606f7e272 100644
> --- a/Documentation/mm/process_addrs.rst
> +++ b/Documentation/mm/process_addrs.rst
> @@ -339,6 +339,11 @@ When **installing** page table entries, the mmap or VMA lock must be held to
>  keep the VMA stable. We explore why this is in the page table locking details
>  section below.
>
> +.. warning:: Page tables are normally only traversed in regions covered by VMAs.
> +             If you want to traverse page tables in areas that might not be
> +             covered by VMAs, heavier locking is required.
> +             See :c:func:`!walk_page_range_novma` for details.
> +
>  **Freeing** page tables is an entirely internal memory management operation and
>  has special requirements (see the page freeing section below for more details).
>
> @@ -450,6 +455,9 @@ the time of writing of this document.
>  Locking Implementation Details
>  ------------------------------
>
> +.. warning:: Locking rules for PTE-level page tables are very different from
> +             locking rules for page tables at other levels.
> +
>  Page table locking details
>  --------------------------
>
> @@ -470,8 +478,12 @@ additional locks dedicated to page tables:
>  These locks represent the minimum required to interact with each page table
>  level, but there are further requirements.
>
> -Importantly, note that on a **traversal** of page tables, no such locks are
> -taken. Whether care is taken on reading the page table entries depends on the
> +Importantly, note that on a **traversal** of page tables, sometimes no such
> +locks are taken. However, at the PTE level, at least concurrent page table
> +deletion must be prevented (using RCU) and the page table must be mapped into
> +high memory, see below.
> +
> +Whether care is taken on reading the page table entries depends on the
>  architecture, see the section on atomicity below.
>
>  Locking rules
> @@ -489,12 +501,6 @@ We establish basic locking rules when interacting with page tables:
>    the warning below).
>  * As mentioned previously, zapping can be performed while simply keeping the VMA
>    stable, that is holding any one of the mmap, VMA or rmap locks.
> -* Special care is required for PTEs, as on 32-bit architectures these must be
> -  mapped into high memory and additionally, careful consideration must be
> -  applied to racing with THP, migration or other concurrent kernel operations
> -  that might steal the entire PTE table from under us. All this is handled by
> -  :c:func:`!pte_offset_map_lock` (see the section on page table installation
> -  below for more details).
>
>  .. warning:: Populating previously empty entries is dangerous as, when unmapping
>               VMAs, :c:func:`!vms_clear_ptes` has a window of time between
> @@ -509,8 +515,28 @@ We establish basic locking rules when interacting with page tables:
>  There are additional rules applicable when moving page tables, which we discuss
>  in the section on this topic below.
>
> -.. note:: Interestingly, :c:func:`!pte_offset_map_lock` holds an RCU read lock
> -          while the PTE page table lock is held.
> +PTE-level page tables are different from page tables at other levels, and there
> +are extra requirements for accessing them:
> +
> +* On 32-bit architectures, they may be in high memory (meaning they need to be
> +  mapped into kernel memory to be accessible).
> +* When empty, they can be unlinked and RCU-freed while holding an mmap lock or
> +  rmap lock for reading in combination with the PTE and PMD page table locks.
> +  In particular, this happens in :c:func:`!retract_page_tables` when handling
> +  :c:macro:`!MADV_COLLAPSE`.
> +  So accessing PTE-level page tables requires at least holding an RCU read lock;
> +  but that only suffices for readers that can tolerate racing with concurrent
> +  page table updates such that an empty PTE is observed (in a page table that
> +  has actually already been detached and marked for RCU freeing) while another
> +  new page table has been installed in the same location and filled with
> +  entries. Writers normally need to take the PTE lock and revalidate that the
> +  PMD entry still refers to the same PTE-level page table.
> +
> +To access PTE-level page tables, a helper like :c:func:`!pte_offset_map_lock` or
> +:c:func:`!pte_offset_map` can be used depending on stability requirements.
> +These map the page table into kernel memory if required, take the RCU lock, and
> +depending on variant, may also look up or acquire the PTE lock.
> +See the comment on :c:func:`!__pte_offset_map_lock`.
>
>  Atomicity
>  ^^^^^^^^^
>
> ---
> base-commit: 1e96a63d3022403e06cdda0213c7849b05973cd5
> change-id: 20241114-vma-docs-addition1-onv3-32df4e6dffcf
>
> --
> Jann Horn <jannh@google.com>
>

