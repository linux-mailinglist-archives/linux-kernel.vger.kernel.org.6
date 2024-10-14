Return-Path: <linux-kernel+bounces-364744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E400499D8C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 23:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA59B21C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27EE1D1507;
	Mon, 14 Oct 2024 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZDkYEKvq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kyT4dlCi"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CD1CDFAF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728940192; cv=fail; b=Ai3qs/9hqkt0JPEYsN0cOwjPJKhc6yeoNQI3vE8zJJGYARnJ0JmPk05JSsYO4peKXRy7hS5MPoe3+om6R+aLPRBfZc7VYE5+Qj/vlUXrDMtN+jA8fTMOVXXfxJe8spdDrGeZ2qR075gyrNFTXs1V9tgO+O7rUBH4czhmsR7hC8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728940192; c=relaxed/simple;
	bh=pW+KMBayPlFrlmlzwTrOSiaXLvcsNwEz/IcIP5uzyFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S4Od56/CEqmZcW7aa8U50lxRISJySmokD43nSlCIb/qiOJ2jofXHxT2EaPLRaparDq0+DSYnK0soK6oNevY5C3FEOYBHL2DtaV8NZLGQc4xqhr9Dg+zqzPBuRaDau9uTyY2peKGhaJ6Bmt1852+QzHP6ioxvXVA2kv/IKRFgwRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZDkYEKvq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kyT4dlCi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EKtaT0008640;
	Mon, 14 Oct 2024 21:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ba9ajez1WkOYRVBQ16
	WctVOhxReU+41MamSFkuBa2u0=; b=ZDkYEKvqqvk5fHw9UiPi6xogMEXfb5rtJ0
	e3rW1Angw6aT7BuazUrZwb0dIl3VHFrb/Juylc/5/Fsq/Gn6aySPe9mY2LNDnr3I
	11JLAsfoqbtQXdZhsafTPNas+X7xXj7k3FITDs3kOn04pG92ZRCFYjC2T1XbmCRT
	ySnd6o086EqHZ6c/iRIzAkM9CKY/LVu9Gvban9tq164ZwCBHXCS8rIYaqwnHiR/X
	SJjXedqLgA2FL6CxMCBPZWg0wz6r+KWrOXDtRfmatLGxDAqpDCJ0jWL1gsQZavlb
	CBu2Q8TXMMOOB1KtDeodHQnIAx9X1xOTGVsXZZJVH12C2jVlAy8Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqsy9f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 21:09:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49EJQxuj027143;
	Mon, 14 Oct 2024 21:09:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjd40pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 21:09:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+IkuThQqn4sSqKSWjfAS2Bdg4rDz9M/K2EdjWKZHApLyLatA9MqT1Y+CtDRRY5oVMpH4Ju2sc0tfTnXPDkA1T05FNTx2UpRWz8Nhz6YOxcgDeH4WWlg8/IgxyA6OHC0UlYwyudUkusjpz+m6uu3G92vYXyMBSPLzS1uTuygnisnsh9otTvULlkuh6En0MWQJhdwTMoMS2aAUexCJWSvUwJR9IlT8gR5kmYeVPOXbdS06s4cQELTRviGS+Qd31Fq9XK62Svix7Rl8vXmVf3WRIlBjjPKiDR+bUiCnZVTjm9zKcprtj6EjwRXYBAaQMqHqQW35mHeITdaEeTU/N8Tnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba9ajez1WkOYRVBQ16WctVOhxReU+41MamSFkuBa2u0=;
 b=Dx7Lw+nuycnOSs8w/9pd18Vv5O2YOHqtysrpzGCY9QoXB8NVaPM/gjKuCQNFOBM9rjrPJaSrUpVfTTZsaXtcn0hW7W+xpt98aFjckmW7y4oEmFyXk2hG7UtQI2n6FilCJEAwj6l7TyQjpptEBAYmvQQmV2PLsRe0HM1dERypCuR2Mp6UoCnOlmeGIRKcOGgRLocNVRwsWxbXq98xej8dpcx8wU3Z0ubZgPQIs0mks2h7TgPKj5sbHyGl11SqcSMTXYQF6tPvca+77tPyPQwb4HZJBZJTWqIskTG+VJK+iUiJ2jBeDGLq9RNy10SQ23CblhDIvjm2NZW0EpjW1vhvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ba9ajez1WkOYRVBQ16WctVOhxReU+41MamSFkuBa2u0=;
 b=kyT4dlCiRG/RgawM5H+2SPIhddKia26CWqVs0lZpADkQ6SGJ+3E9Uavtr4/74S8WoeupA5wLCUXKc9kywrYlVL+TeXnKRHrJ1Tt/7RuZaBY8cvkYdFzb+pcq0atL6gP5vOpc+2XuQh0jYu09BftbpixkVtJCPZ7hT33P0v/1Tlg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 21:09:39 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 21:09:39 +0000
Date: Mon, 14 Oct 2024 22:09:35 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as memory mapping/VMA reviewer
Message-ID: <acce2a19-17b6-4288-a3e8-3033c62cb5d3@lucifer.local>
References: <20241014-maintainers-mmap-reviewer-v1-1-50dce0514752@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014-maintainers-mmap-reviewer-v1-1-50dce0514752@google.com>
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c82f174-a989-4e78-3407-08dcec948411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Uk9cjdUErzF6DROxI8TIlIx/G3C6LlX6sZKNnyUNk0NX4h+SHehyQJILJ7H?=
 =?us-ascii?Q?Fa4K5vP4SNgCeBNFMs2VF4yQ8flNwTIHou+jiZlbNpXPOdQQJUXC+fq170WJ?=
 =?us-ascii?Q?9Er7xaGH3R6TFAh5Losz5TsDn47j3VRHfPRu8EGeUxwfRHPuZW96Bz5UykFD?=
 =?us-ascii?Q?ImilhfLS/0X4oAlR/QQpCLdL9V9+OlZH02zgTXXq37Nd1bywILdz/iwGm8tL?=
 =?us-ascii?Q?4+naeyRsozHh5bJm9i8OeNCfK7401r+B7Gj7ShdKB7qMBDzMPISBauY8/EXB?=
 =?us-ascii?Q?vOUx2hHveOjjA2oPBvnEXXvAjKEuEPTup/fTEXOeTG+c0mAhg8jfL2GwY+zf?=
 =?us-ascii?Q?/4ctUSmEg4t+zPGLU171u90nVuTQk6XG5uBjkiHOxsvzfxgyOZ+7MQA1nx0X?=
 =?us-ascii?Q?8g/GzEpvHAxYfoB7Z5RlnYFc3hZFU85OmFcoaw/2w2PFcdyN5rKzkMCHe1E1?=
 =?us-ascii?Q?56aNIZ8G0MyGUXXLSo0nc35g5Zozsu13JHSAgGA0q5HhfP5czWS9EQWuQvQv?=
 =?us-ascii?Q?yo+Bs9VZNhHNN7e4fzjesXERsDQLP38fnCOqwCHsIOCjyWhLh+Qnchw+k1jP?=
 =?us-ascii?Q?9r1O7WhKVVuP6k5QRKoxwaW3MDi4tSw0rppQOqhDgbvClkcUAQJr2ul1mVEt?=
 =?us-ascii?Q?e09/2KMHxrkUbZo2Ayy488jCBRkWgV0ytvDmhIwasR7tBTPY0EIBkcqWGKeD?=
 =?us-ascii?Q?GjAY57je/uCs/IaHnRK6OIhgJTJZ3VqQgDcOWtG7EPth1S5k5zrVnCA1E7gg?=
 =?us-ascii?Q?BaukGLJEo64X72WKWc8qYpvmjvqpsmCp8oHSNGdavSgThercNsDtAD3wqFwy?=
 =?us-ascii?Q?KScGU17A40MF/HIQ/EVVXIbqGXcTVNFJF5XbzLR5pJwR4emUhTdF2r1glfSs?=
 =?us-ascii?Q?1MCejVkwHyld3wx+Roz7/rpZiwzkc8P+Qvjq3ZeaRl16qcWrNv5U5XElLcgd?=
 =?us-ascii?Q?ZkduIyXfNsWMaP8hvAKeff/EUxM5bn5EQwLRPBnGp7nL/+WdXYVQ8Iq2GrAi?=
 =?us-ascii?Q?aKGZ3BBVyVA9Btv8CZBv2LREXJ1We0c2beJfpZTu4FVaa82KKocKjf+02lWO?=
 =?us-ascii?Q?DUsIWn9pgY5wjmcclbMkFIMaVTRMBula2oECHx3l7FyeJZ70T66GMRv67VJs?=
 =?us-ascii?Q?YJd9Ev96L/yEd7NjIsecOTF4v8DmzjvXw9KrfP5OyYws6wBnr2+B5LXVMHcU?=
 =?us-ascii?Q?4Vt0yCh/XKE0+tXTwuxBeeT5TvpwKxWJB7MyWdL6BWr0pZcy7+l0HwEoirg?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E+HvLWQ8N0G/1wYchrk5WMnyzmZdy2LbjKd+vwbQJLauPscoWvYyV6N5Biws?=
 =?us-ascii?Q?97JHWgUOKtcdVgGfvu7dqV68EHip7P/hVYFGcDCi65MNvoosckYo9/tHnzff?=
 =?us-ascii?Q?EEISHToX21FrEFq9rFlJ63RWOCOjxgr/SkG86sk6bSg8mYRy9ue7de8n95M2?=
 =?us-ascii?Q?1ihBVsRvgls0v8NUhJWXovaseYnmVeWfGv3AVUh+jBW0RZPQIU6Z0GKCM0gZ?=
 =?us-ascii?Q?hqvDRxyiLEa0NqP2nNqnBoUNtlY4LbyQZkdSZ68+mzKWizSeQQiT6mG4p4KU?=
 =?us-ascii?Q?SAPGZjT0bRjGeodm0Bc4+9GbS7xfrpIRLTqBfGRsmNCnH7EIqPHPVzwERQEb?=
 =?us-ascii?Q?/0VrsULKpyKVEFHcev7Un7xwY8siUwxuknciNF9Qb2n1xygfuYVjdBDsLE4Y?=
 =?us-ascii?Q?lx73l/cdUzyac9HVQCyMWZdn5OWUvgMw3BTj2FRuBOu6BGMyqdlk+LQSgQBl?=
 =?us-ascii?Q?sNSsuALC2K7DcZqj3MoFTMjJ8ZfFyz7x0yqyZh11jhygnBmeph2W5AwDog4P?=
 =?us-ascii?Q?kvu65GIb/MSTAlLiSsdEf/5lsZ35QbhxFKFV+8Ft9f+ZEDlWOqFTUPIbJVt9?=
 =?us-ascii?Q?W3qJJH8Uyh22LOKt7XDuRP5ciey/7pQaw1ok/+2tVRCX5bOQ/5fAP+I5F5fz?=
 =?us-ascii?Q?nWk6Nod1GPT1Yvd9SPxuALM7K7U2n/jUXDAo5aVktKXBAhY1orhNtxUOjTQT?=
 =?us-ascii?Q?n3xrWV01SuCKlig5cntkiSFDLiNVRvHtOPHd3Q1eqgV24wwmGJ+iqrwsSqoY?=
 =?us-ascii?Q?Xo3FQcN69BNxgKf4a9u8ZMFXzCdaZVsd64Y/Y3MWMLWMGg/OaFwz+CBS8iiM?=
 =?us-ascii?Q?ym3V6rdJu8oUVvDkBiUpn3evdIesqXsoT1j2qqzU9Y3091CLAhV0I6XV1aUX?=
 =?us-ascii?Q?bP5n36tcsXUta9Gf4agXhiel/buxA+ukyvxNZn76tlOZFcuCpQ70PFADVPqu?=
 =?us-ascii?Q?WsZsjeRc/lLLixAMsKDg40aKiPAAWsXULw5cCbZJCcErVnYtNV0THdolEPH8?=
 =?us-ascii?Q?+zdJYGZax73vskLEti3x75DywJC/tX83gskrH1QZl9c0OrDUofTld12194Q6?=
 =?us-ascii?Q?JBGF8MfIZVw15Ng938w/Ys2f+QbRRgjrcEG6sCKgwGH4kn+iMMx9FMGU+T9O?=
 =?us-ascii?Q?0zj/InD/zen0ZLrUC2DvJ37vQTA4xDJ1yztkJL1h6UQ3cyKREs/z5XxuonI2?=
 =?us-ascii?Q?tie5LR0KEYf/uWxjln8UL6UUowcGM5BDkW5Lw/B+s+fHvJbXtsy71w4ACdlp?=
 =?us-ascii?Q?NiLkYixEhJQgCGbIp4TVipF1LCW8ZUNl1vtbERgGgQBc6H8oclOPdijVJeXG?=
 =?us-ascii?Q?p9sDLJf4L0xfdSdFdqCxzrRb3o2BphibcnI9qZhuY6hwzxPXHI7PZGkOKEuy?=
 =?us-ascii?Q?O52QCD6FNyZjynBjvmnqQTZdQLDbu6twZm/H9Zy5QrLUqYkhs0/HfmPdg5UN?=
 =?us-ascii?Q?1ooYWUrYvDvg7AfTi5DzH8EVjsjpQYP/36aqleQ12J1wndwNHwl4188Widtf?=
 =?us-ascii?Q?Bac9YQxIuE4ghHMSBu6zWijn7089qygqnQpFyXcRUHhtOabEzcUjpQqH9DYR?=
 =?us-ascii?Q?V8UGt1DnFE7aS5g9r7NQXHXMN1jmiIWyznlkbkd+bb+NrY1cCufbw422ENbX?=
 =?us-ascii?Q?Mq/8J7yPqWgZc2vzhqlUf59k8pdo6jBJXmIw/rnhN5iKbaf5Mn5Yy7U2nctg?=
 =?us-ascii?Q?DaiqpA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	la2pRSl8l4q2h38dhI2MvdYkWlwYz/+M7PVNy/scIk44Ptrp8BOdtfTRryx15Bniz2vJClrXXzztsVdWPXtRCFYxuXWOVItyrL073Ccpo485nLynU9DEb8aq9jh3yYshVv/85Q8eMS2ZyNQsxHrCqtaWSKJxh40qh2uxeVCNFD/OLQCUEvPIXGZp3SzAPnatodBhE0nLxpd6+9UHtoLnjHeysDr25TYZ6GpqqoY+T4dYqSBeu0mMnceMMqyHSihgdGa74JhyXrIiJdCdaEsIf5eINi8lMsyPHHR7vznpYbgrcraeyjCWplmhgRRG84HL1Y6G4qlSzlASw+GF2OapGIDpRlL7Nq/gB6dMpGB7u6sRtPAVgBIshdYvep/BmrKMYTyuquaGhgo8EM6EZ8NLcls+LVQt5UC8qcNCbzKWuSS5qkPe2Zmlvdkf3n19Ofb6ivWTlZxMW9BT4uD50lt1SjEa0isokJwu0INk4/geHsrMwKunxaiYSrbMoMqizPOgCzpYZHos1rRPixNsoX7uuyB7iaMoNiNl7nfZ/gvsyHN59XpsNd3w8/XdE4XVL7/ieQmYV2Ez2s8+3fqCmq12s1GxMtZEwFmLYPAJaQuKjFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c82f174-a989-4e78-3407-08dcec948411
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 21:09:39.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLp47MVqFYu/ZrYOzPhQ+wCOH2hCIdteRgIsUiftoLy4J3mDbaQ/c/3ZNHfAPmR7kyMERL4mpV4pYig44pES9RXfUoQs37BRqUQhY5AODDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_15,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410140150
X-Proofpoint-GUID: aYI7dfgvNytGweEVKjK5kxssuTLiQ05m
X-Proofpoint-ORIG-GUID: aYI7dfgvNytGweEVKjK5kxssuTLiQ05m

On Mon, Oct 14, 2024 at 10:50:57PM +0200, Jann Horn wrote:
> Add myself as a reviewer for memory mapping / VMA code.
> I will probably only reply to patches sporadically, but hopefully this will
> help me keep up with changes that look interesting security-wise.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> (as discussed with Lorenzo)
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 659aca7cfad3..6978444f81d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14918,6 +14918,7 @@ M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>  M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>  R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Jann Horn <jannh@google.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	http://www.linux-mm.org
> @@ -24733,6 +24734,7 @@ M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Liam R. Howlett <Liam.Howlett@oracle.com>
>  M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>  R:	Vlastimil Babka <vbabka@suse.cz>
> +R:	Jann Horn <jannh@google.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
>  W:	https://www.linux-mm.org
>
> ---
> base-commit: d4e7ab0ed929645bee32538532039d3d451efb00
> change-id: 20241014-maintainers-mmap-reviewer-82a031ff2425
> --
> Jann Horn <jannh@google.com>
>

