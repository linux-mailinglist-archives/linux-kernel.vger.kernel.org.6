Return-Path: <linux-kernel+bounces-242848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477EF928DE0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A67ED1F21CA3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61D176223;
	Fri,  5 Jul 2024 19:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XAW937AS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qmOv6tE2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE8174ED2
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720208421; cv=fail; b=NfBHuKK9m4pU8K256YrQXE5PjVXDg7612biMzUrS7Q03ozoNk2yJpHfMXKBOAE2A02MaDj3n5+boEQhl5pI7HiBUAG4uDCGc3qTq2J4Mqnu94ht5KdDZelYYp36VaIFdLF84rmaCRnvYyxB9gWK4Hfl1mGC9lCvGzF3hWL9SKyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720208421; c=relaxed/simple;
	bh=AsdEoX9e1UIqw7ZeLolp/czY8wgL/zHGaQwYcR+OZ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nxw+F/PpVx8n6Pgmf3oMZRNe59j3FMI7c5pLxcsQCfqZgC5OuPdASf8I0gsJNi0nVeEuJkHqGgQnaesM8ZUaI5Zy/kaMv+IqDT/wPsDa/7DwMxvrCMqQjLTuqgsAzCaLk3dOEJLMUotjs79XlkGFwt2bBXzw7ZO8euTarXPIck8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XAW937AS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qmOv6tE2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMWMo020417;
	Fri, 5 Jul 2024 19:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=lJ4EW5IRHu+zrPh
	tCMEyZRsKr/m1WN6Jo7r3cEZ+daE=; b=XAW937ASQbPtbyDoHA/ECxoBBwT+UVw
	t5X6V+xjE0JYAZRqNyOJ3jvuFrllID/lkFmaHBPEkdXQdQ1UUtTFFpE2gQjEl3B7
	AycqJzhHNTtgCVO17iFBXVXTrVa3u5IAS9Ch/UBpjiEGtgRjUN66Yc+SjvxwoRlA
	emtLzhuwByMA7wdPOwH/h7iyYGhoOO5GW4YfMjcqSuTsozPnOW3MlUfDlwJhuvac
	ZD1jQ7XHZXPuG5tDoWG4kV2CGNtn8WraG1PyMlAm8yNWB1CN5KS83s5YiE1pOy8a
	6UGjDZOzYdjzfvWxMHQP5M80RaHZEQ8mgJkfriDN3pm+elubmKsg3/A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attmfyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:40:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465IbCB5010936;
	Fri, 5 Jul 2024 19:40:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbq1q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:40:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSytyt8eLmWZpfR8CrZMHYDqQPAIy9U3gWRqpjXRFmRsWNq5Y0djfxXSNjnOr+9UCQ5QVeRERu3C8u5mb/hSSqsyTvRP4zCIx1NcwCMFBV9RWlNvrsF7ilf1JbnhY/wX+INaf+Sa0dTteyfRU74Gm0Gi2Xj3Ug7DdDbpYnnIBfzwiGtFJyYVAUgkOTeldV6tftylrRQTdanBHNI4tNPo+0ahPRC6+TbOfgVoTCz24TJgDGyEEh5nk3zEMFgm1NJ3I/sYdUEK13oRLov4xf2o9pFeFfcYr669JhqLD/BpWYyqBcnBkmPTY66kIWKgMF7qzKsC55qnOVHFYAtHn2XBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ4EW5IRHu+zrPhtCMEyZRsKr/m1WN6Jo7r3cEZ+daE=;
 b=G7DvH2FDiDyDaJXDZeuqc/mdEbwO/j9XAkdlazy/sSwAp17lVuNzucdRVTQtjAGh2S76o+4V4Jpv3oWuBD9uEM1lCgCPivKsKkPClUhpEhwq5lbbytaLICKcrOAcqTll2pmyhDnt3V3BDKINOAPGimVJNh4S+k6Rw9yGoieB+tvyxko8AubFElhW4d45jqrfEyhIWX+TjxkE3dLI3SIcPfN7dr2lkenY6QN6H6Xi9JlfQLFOWW2jsLC38kNK8nYw5to4MHXVvQdQTHQXfhWCmWP4mq1UviEz0EVTGs7ZR6tlokng05ZdRxiF0Oxb09dX0/vgERXT2h43FDUUSNfexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ4EW5IRHu+zrPhtCMEyZRsKr/m1WN6Jo7r3cEZ+daE=;
 b=qmOv6tE22FZ0MZWlUhZ/az3lJmJkgLtG/Xdg+FXu/spQtjC60JC7YvmdhceVL5pr+lpfw10fRge9TNNRpOa0p7Tx9xOgbUwVdpqds23hKh1Bo3R7jEwfCueYyLzWCSzuIJ57v/wMNSWeOTy8ziLksLxVdFD0Vvpx5uroFTxkSP0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN4PR10MB5638.namprd10.prod.outlook.com (2603:10b6:806:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 19:39:59 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 19:39:59 +0000
Date: Fri, 5 Jul 2024 20:39:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 08/16] mm/mmap: Inline munmap operation in
 mmap_region()
Message-ID: <44d6b910-8778-44cf-b432-4d0f112397f8@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-9-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704182718.2653918-9-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0528.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN4PR10MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b63aaf-66a4-4342-6f68-08dc9d2a4193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?k7GgU1UCxRPlzBt8UtqDFlJLGwR6PiIoSddQD4EhRJqXLhPz3umApV6nxiLO?=
 =?us-ascii?Q?9q2HeqKP1N5eb+ud9Wr7k1kaB430FudK45fqwx0BMrq0i3B9D2DEs3eVOajH?=
 =?us-ascii?Q?7z9ALfPrBZC3hiC8LiczKl0mfn71ZbYxaIBaVaE+ldHd+Nk+sVY9BVWD6UMp?=
 =?us-ascii?Q?jCKMTfF/W+VC4JA20NQix5zvYFMVrWNrETViqok/UsQKMgkZn5g1S6IOYIwt?=
 =?us-ascii?Q?6EqmqQHakcjpuWtlhjp0WBIR7W5MghT5GcCPdjNFuXcdpsWRhY2Zs5e5+XN3?=
 =?us-ascii?Q?3H5rNaaVsLNN5kO3sV2RTVg9Y+AobVGzsRLlMHUHEgqr9dYrSPKtubvQEoln?=
 =?us-ascii?Q?uEK8YNz+tf3QHdvhEjumG3LzmcXkkuSZnR66InoO9pFAWfNCAIMXldO1OgsV?=
 =?us-ascii?Q?kuXMoo5TH4PSToRSnT6n95gZV3x8CoMU5KwvK6R72xChh4q6NXvLIJMGb6Uu?=
 =?us-ascii?Q?pT2D0V10e+zdftNu8SH19JB84E3VdW5fjcqPM4ebtS10odGTe5SBND5++2h+?=
 =?us-ascii?Q?OSrDu9J5deVKOQh0HxthhPpRFdhuhAu5RaPaBHOezwSgKtC0uUqb0Q1lkrGX?=
 =?us-ascii?Q?+hkpqHxNf6GxDTU2ln0u4ugtsP+GyyLuvHjnAb8zUmJtqpDLASp+E6Q84YPx?=
 =?us-ascii?Q?6yMpYGF2DqqdJ8roFeiY6GfSX7TBhP3uL6tljWfC7fG9aU53ewWUT0DdJiY1?=
 =?us-ascii?Q?eSauCKZSkYz5s9Hf72Ex1qwt0GXOKq7bg/GS0s4zaxajw3DgVmfLBbP1prP5?=
 =?us-ascii?Q?0uulOsdcMaIivh+tCWwjyrKIKcjHIteoj7Pqpc1k3fQXzBbbtENJx0k+q9Iw?=
 =?us-ascii?Q?dLk+KntpvVi7O9+NoJNnIAtOVatV1gAEjAqY2hUXlGPYfPkT28KjCKtQkw9H?=
 =?us-ascii?Q?XWUHqtvePpmmmZGlfbF2UCFMn06aiTIu7mULNgWrin+nYQzERxY9BkqKfEaK?=
 =?us-ascii?Q?5mLxojKLlARnQHysDFVb9Bhh0/37R8Fw17UNM2WR4HUkNlhuzsxSpaZ5m247?=
 =?us-ascii?Q?AwYD22wYml35cnbPghlQkIz+35JYCmhQY8X/4sXJkHflw/Rg7eBBJQZRQVUl?=
 =?us-ascii?Q?KQZCmwQSB2za9NYhdes/6/InsQA6Mhn9A99StOCCxk25dDw3djy093bxE6uF?=
 =?us-ascii?Q?3bI2vxQaQ2eLXrz+OuwmwxO9YtXKFQjxgvnujC+PNpReUbWnsfIuJJ6VnLJs?=
 =?us-ascii?Q?jVsKcTc/6B6rTNsTlArmGZU9C/E4eW7QOX7szxD3pq4RFwjhyiHa0PTyMZ4F?=
 =?us-ascii?Q?m13H0ryQbUFZkltznKMgNGrMwsUWxHlD38y9vzeGDME7C/bJGlnh4tHrGAQa?=
 =?us-ascii?Q?Q5IiBr7Y8KdJHb2NOc0tLOOIL7+1roqCebchuPV42oVUCw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6sqHg6dzbq/lBKYKFpaAEulPSxnp6+/h5up0nt3A/KutGgRjo87QSxecaGzi?=
 =?us-ascii?Q?N6hHrsKWTkhnlrHjoe6FRFZ85inDqLpn5FvKVvHGkBdHzbLEHyC2ZFalJuzd?=
 =?us-ascii?Q?GHKePcNYVE+rsyL723PSS65ch8DhuU79dgcGJveZI0DfJGSqr0w3AtDiuPUd?=
 =?us-ascii?Q?zchZkqmiXS4c/P6i2vBGVsDKd/72bj3L+syEgOq/4N6knPJcTwgPbnO8QRxm?=
 =?us-ascii?Q?TNF9orsJQtzcg1jEJLwYrrN26+9Jtz8cUf+puU/ZoIn5ZGBTYcAozKTT8v5A?=
 =?us-ascii?Q?plFNysneTPoZjn97qtJ/hMvv7uW4uJQcHV0me15Bp8VRI8E4cUL5KVgLMdPF?=
 =?us-ascii?Q?sjzBHzrjR+TEFB7jOBKXyOtxB+bmNqKdM/nwXZgXs5G8RSKrdmKCjCDnhhqM?=
 =?us-ascii?Q?+5BGhQ3a/c4Wj65PvKONgKVUrdXIRJQfm80UCETicntHficuT1aTMcnJXt+m?=
 =?us-ascii?Q?/i5L2B+kr5ZndASo3mYhQCfccKvRJwF/xQ3vBFX1XNVgT7sqMFGCgusWgFHr?=
 =?us-ascii?Q?pB+hQavjD8TmJcsSBYt/BKiryM73GqZYIoIr1l2NgdvlJ7d35qtXgKe/PjJd?=
 =?us-ascii?Q?bbvuphiMyZzZlcXx/5KFgdj3VOqzBDwC3iT8xTEbEshyAudXz7Mb2Cuw9p7G?=
 =?us-ascii?Q?rsEoNTgxwmT4G7T6SGjnvW/BDEBFSI18BCQDyso8/1Vdua2ErN7NzsIsC2sH?=
 =?us-ascii?Q?tR1hBN/Rr0EBnwLj69bJztuYy0FDV9NUhZ8rvkZYcvIQvfBjiR6v6iu8dqI0?=
 =?us-ascii?Q?MtPrrZWk+5Sz7FlUXyCOyn0GE0L6V3j/aqOKbayPOxQNjYPZSvXXj4gsQgvL?=
 =?us-ascii?Q?DNRveSc+oF98E3korsw2VYQgUP0QkfKBjwpKaC0RzzBnWCrMM/Hu+Ziq9Vhc?=
 =?us-ascii?Q?nkeyHuW1Z6CL3poYRatz7ItzFz5iR6D88+bILumdJUe6a+qLXbFYQxEN8hrQ?=
 =?us-ascii?Q?SfIpyhOoJccX1+eHPohdXeN/1AJuR1aLb1yMVAKAmeVsMuSRpGv/Mh37y19F?=
 =?us-ascii?Q?3aUkENQXhFG7nmMAJ0JMN5EQx9r+YjN0UIIbJY/JBmK0DyVAk+8nSGPdATTm?=
 =?us-ascii?Q?MTUleNi30/uo8cPlbhtLKhAWnUkRSY/KDA/OngdvuZDRrLT2GoBEu7WqOF0y?=
 =?us-ascii?Q?cIzUsP0uhU8CWo8h8ISyA9zb4dHmBEgH1fnKgNSkbKV9cGTUSEMFt+ZtNasv?=
 =?us-ascii?Q?2PHX6dW+vo3ix9AqZROo97ixYkhwqh0+viodeKpj0sIFGrRFpicYBWgUyhPi?=
 =?us-ascii?Q?et/CarDPPsFYmXbxXXDqP0KqahuwewcN+ITdKgPXPAg9cDYETRX0OLBQXbwq?=
 =?us-ascii?Q?lKNSvybS6ubnRBti0CEYZlkpBnf+rCbqtugn23hRKkCjDFODZ1YEbkMxP8ma?=
 =?us-ascii?Q?DmSSGI67pRVTJ9M/KXluHIxerHVRPJVNjkG23tyg6w8BU2PD7H0zDi1CVypK?=
 =?us-ascii?Q?nTUU2FOhdE5x1yAccmm2oTA2I1mxeFBOsM9xz63gqDrV3DfWPWMVvqzmKkO4?=
 =?us-ascii?Q?qqJprbiOyIQGL7hpTd/3V0uEmvm5dK5wZ7Sp1KeJhMDTZGrAmv+TwWNnRZ7Q?=
 =?us-ascii?Q?yPE6ttShC73hhv/K6TQb49a3HqrrIN7YNoSq2d0RrDsIueO0lEoGygZfPwmb?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1Buk9GcSqcTtmXR30zldjG3cAC3GnCJOJP6vpuP97YElMtfE00BpMBS24xUgjYMYz2zoqBlRmmcz7ZzkX656lPyie3Mbwg+URDHngerDBgkA0SvLbvces0N/CkleIXqtuUndG/wwnjJTbyRvMAw+7v1VDrRO0Jr428aa0n97qzvY/CLVVIb886dx34Ya5rD+Pi14Q+irexiTyW4hJ8rCEIIEofM7V7YlSKRY3zi6hFqKdzsqNjQuxyVodxb43OAOmILfn/LyBpSn78griU2AjUOkYP1zoVqK0RaAW7erVX+Qq4uvh9o7IiHji2OmOeCGLTbfw8GefhN4pswtVkrGjyEKb9iAZuGg8BUx1laSptXamowgohpSJ22mL5Qrbtf7mbeAXAiuWK6KNhSQ4za+hsAb/siaYw++Uf9iZJrj2UMFIGQRnqBaco1/VlOrTDnwlz095DG3U4MSYuBep62k5oqO1pBlhPUguMDpjQaCyWbr3GA2yPqZD/uT0ZRF77XjjVYULWuC7Wo6Ad+Hm308BS5d0tLgZ9COtpHbybDzZcYUKmlC55AAegBybGgs3F4IsG5jRGyVkSJxmOZkNNv3fAVxZsGPPZIjwVPcndF6veg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b63aaf-66a4-4342-6f68-08dc9d2a4193
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 19:39:59.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0C4hoOCsO33M9p/wZuo37tCdHEm6MunwxKKHG00qX6Vlh3IqqBlJDEetQWjg0R5/Y/M4WD9AlT7hDInPCq7R/pcR8qXDSstqraom7KBZVWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_14,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050143
X-Proofpoint-GUID: LuwsuTm9I4y93qeDVcHcWeTswgtntgSL
X-Proofpoint-ORIG-GUID: LuwsuTm9I4y93qeDVcHcWeTswgtntgSL

On Thu, Jul 04, 2024 at 02:27:10PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> mmap_region is already passed sanitized addr and len, so change the
> call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
> checks.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8d9be791997a..e9858ca8bbd4 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2937,12 +2937,20 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  			return -ENOMEM;
>  	}
>
> -	/* Unmap any existing mapping in the area */

This feels like an important comment, I know 'find the first overlapping
VMA' below alludes to it but whenever I've read through this function this
comment has actually been quite useful to know what the intent is.

Could we reinstate it?

> -	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
> -	if (error == -EPERM)
> -		return error;
> -	else if (error)
> -		return -ENOMEM;
> +
> +	if (unlikely(!can_modify_mm(mm, addr, end)))
> +		return -EPERM;
> +
> +	 /* arch_unmap() might do unmaps itself.  */
> +	arch_unmap(mm, addr, end);
> +
> +	/* Find the first overlapping VMA */
> +	vma = vma_find(&vmi, end);
> +	if (vma) {
> +		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
> +			return -ENOMEM;
> +		vma = NULL;
> +	}
>
>  	/*
>  	 * Private writable mapping: check memory availability
> --
> 2.43.0
>
>

Other than trivial point above, LGTM.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

