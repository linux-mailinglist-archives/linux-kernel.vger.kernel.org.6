Return-Path: <linux-kernel+bounces-395031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F169BB762
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1790B1F22F42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B73189909;
	Mon,  4 Nov 2024 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LGKTUl1e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rDRnPCSo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A6E79FD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729892; cv=fail; b=YoKoEU5L8Eh+PcyCXBTn/Kcj+302TfsQk4pogB9iWUNkYbVwWqpPxlNYYQ8Vj0NnVFZtYwx8VH9/gxxWBtLh4b3mMFW3eF4qLISvjNJXQcnPNoMTn6DTwR8FcWK8uKEAX/bpY1LkSLqfP1aQL8jdfjXTCe4Vu4laRIJ3bxa5Cms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729892; c=relaxed/simple;
	bh=u3OTFwkY8LWxH1Bx+tjV51EAGkfxfq5eXy7QrmYOMdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DSAEOjbz/nPO04LRvDjLXrv3LZhcEW6pCtjDNsoUAmlVo1UJiSBN93FULn5979LVSrHqHXj1hYWDGDrf5pXJaGCBnaJrkxmvUvnwRj6ts/REqnYxf0DKfmpVI9hVKsFPh9haT8vkdLTRB/KB5KT1VgDaLwcf1tbNPqExSRiw3hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LGKTUl1e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rDRnPCSo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4DNswg003190;
	Mon, 4 Nov 2024 14:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TPLPis0A4HKneZnzrb
	xhaWi5q2Oan7UqxOWrwiD7Xwk=; b=LGKTUl1e0s5DaPyZsiDdGZe6sTfbgVbocW
	u0mW1Dwt2HwGsjLvO+273dOCHrYR2T25t6hLv0NSISTUOcZLlS+xRNekWb1VAbv+
	SI+RHjHA4KIp4ooOBLdyPrXv0Z1+6ycrQY/GeAR31n9lFleRuDKwnDnZ5+sQQRhO
	UVaRT6PS3kvck7EhilNnq/bl/AspgVwXnUmjPPwek0hU2xEEeOW6EjGin1iA+1kH
	eIwhZdbNwMHbU2YcMaqgjanfRUMv8PY3LUSIZ0OqrONaxOL8M+wcBuNuuF67KVjp
	O4P23jRk7nNS493jl05RrSxdDSTaQmO7Y6NXgxG5UHwf7mCnP9EA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nby8tsj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 14:17:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4EBSuI005096;
	Mon, 4 Nov 2024 14:17:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87970u7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 14:17:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nhyuFENrUGaYJHd7SZ1h7YDTJUSKNlCBkWH6Ag5qjrQeviVNjdAExdeD4OF1j0opDn30sxsHZGkd98nSURTsBMR7JOZYfx4xd1ljAuNzqDDba2LWa3pED5D5ffY6JfzmaIuf39wRI575j1c7gEJ9SkdOJzqygyZsWmuAi0Y+vcAZB6FTBs6BMvFl1Oow7sqLrQAyJete41tdHks+WnOJTcx8eznIMvL4QKR+ua1L1u+qFGlod9reOpWFENEQZQoTEgngj8nlbiVJNNhp0yHs13GmDKpilG4Ne3oM4fjdgigoMj2RwWrQGPso/SOwzKJxxsm3XC71jB9NfGhPYkGTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPLPis0A4HKneZnzrbxhaWi5q2Oan7UqxOWrwiD7Xwk=;
 b=UTXduZ0wRhlKSdRuLpT1zsnW9Dkue4YhgoHJcZ2KgT0odO4H19ipLR+lL8zRUVUNRvu7v+rd5iqjQWsEeYOJ3B+d4nBLlLNWL38HyuiZV0e++xPPCEJSiaJi42zxW5gdtLHeKPgiQ/ScOe73qSKFHVtI3ru7QzB1sTVGvqP+fkUg4aVA/x/SlmqORkD2SbZEKYUKLH7qq3hFbgV6rMHSd9bcmbX59F/qiq89Dro5U0lxfsKRMiG6w2wLDxU7xrVh4nCMoJLch5R0rGWigy3M/CtAIoW450AU4X9P1qG2ZMXvCwRs637Iyh9mGyXRoG9FXaeX1tmWgRzBQ+IK4ZDxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPLPis0A4HKneZnzrbxhaWi5q2Oan7UqxOWrwiD7Xwk=;
 b=rDRnPCSoWE43VCGmgUxhro4986RZOkwyPI7tzSICeYYLa/olteoyvhl4z01qLJlxpGHBDuI5ySzC/SkKtQMinWTWiMKyZOfCdHJU5bzvtlu1NIdFmZ63PQnfVXmLB+ahFnwS2ZIYlHcOhReooPyVlyS7UbqTLztYDA8i8MyFeag=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 14:17:43 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 14:17:43 +0000
Date: Mon, 4 Nov 2024 14:17:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs/mm: add VMA locks documentation
Message-ID: <164796a6-c9aa-423b-ba2e-5c6093e3d559@lucifer.local>
References: <20241101185033.131880-1-lorenzo.stoakes@oracle.com>
 <ZyXqJNIqIx97Y0To@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyXqJNIqIx97Y0To@kernel.org>
X-ClientProxiedBy: LO0P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN2PR10MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 227d21f2-ac25-450e-3a41-08dcfcdb7292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4BCvwKJeGKckUwBh3di6pLNCLfKd/mWqqFIQkgMDToAdtc28nFVShMW3rkg?=
 =?us-ascii?Q?fdFNFhGT1IhGd/jHBoP58HPKNJ7U+0Oey74PxtQsteXQs/JPSk4PMCbvYOS9?=
 =?us-ascii?Q?8xcOgUb3SlGoMx+2c67ek8Sy4uIM2VbwDuffiprQvHuphtCYhPrpljkHrl1m?=
 =?us-ascii?Q?xwscFnSZR512iz0o+RV/GS9MShCupk4/i2l4bhyRES8yRmP8p+jxGCe2ds+X?=
 =?us-ascii?Q?NShuvknusGCHJEt3Lv8XBk2oG2O3X5NWHiHlgvfHG3YUEEpiYEpjkn+mQKIz?=
 =?us-ascii?Q?VhNS7UI9FQNk7Z5jwjH+EoZCkykPTfHaShjfVrylis0HWbRYUTqezhZDFK+B?=
 =?us-ascii?Q?s2FPEtO5yMU1WC1rKUPTJC8me9xAZS9gJJHMY57yQPIkFBTbo93YxcHKvx/+?=
 =?us-ascii?Q?2h6imQ9SzvWepZaXHqTqwEmG0ztTobsjbUm7VHB8QeHB6Ee76AWJks4zTKOK?=
 =?us-ascii?Q?HscnS2miBSKDbsP9Q4q8cVa95OLXbF8mewk2UDse6QF9px5qyXNHbKWhnrTt?=
 =?us-ascii?Q?l8hnYG4FYoL65iolV5Ji2Mx3hEpheavo5HdB2YmnUfXtWJm+lWCv0KuN2mTE?=
 =?us-ascii?Q?RJ2nCPwmlzUYBqTzL48rCo6xgrg66/QmdNP9ZNGh5aZIPFgbq+o4EoMneSNU?=
 =?us-ascii?Q?r/5jKNMnHO8BGdIancG+7+x8oL3KRm9X0F/SYjyZcAYTPSOpzngpWaJUjM45?=
 =?us-ascii?Q?j+domZuNhm2khCWP1pRD53xJrL+b1B8kbl40x208SZVt/Qdrp4GdYLkjo7Iq?=
 =?us-ascii?Q?X8LfuBbrbDGfIOEIFqMs/OuzmLlc/kKB8BDURw1Nx47U8LEEayJTnCLQYH3u?=
 =?us-ascii?Q?LyUEzeisxFKq0Ef+lwJ1dL9T7DgSgRRl3mYymfxsD+fqFZlT8wuTffZnMLic?=
 =?us-ascii?Q?IpS/wcBSt5JOs/JJkYh6xw1LjokCUSTVC/GocYfW6CzZuu9KeiJ9snPJvy+x?=
 =?us-ascii?Q?bGUlzWdBSOeihY9XI/4XvPXB97rFz1bSJyrf9oS3OTRaBK/AQYafh56cha6M?=
 =?us-ascii?Q?mfduN++VVEt3D/9+tZo32wlaNF7X6tcGOwn7pNdDBTOBHOGj0FOCLgrRHy9O?=
 =?us-ascii?Q?J9SIhRQIkyFkBfk2DqmLM182j+HWd+XolCKLFErB1x4hipihAT2MUt25c1Iv?=
 =?us-ascii?Q?LBWR0Iw41EP+FWRaevhZzHgaPh1EhTE0Miypgt57J6h7nfbsskqbjR1M1Sd5?=
 =?us-ascii?Q?Bk5QnSDTEOJXX+0Dp9m9nIfdCbo8XfdyQhCl7B+Q8HjB/RljTKHlC6Cpnerh?=
 =?us-ascii?Q?TVswqMsblGIttPPU3xTS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kfJ8reypS7N1G/iKmbyNvrqeoZLpxQK2sZO3NA3q1sF2g5cjk5h4WrUxYeWR?=
 =?us-ascii?Q?aBc0qMqK+EZOscFKj5jGGs2sjT4+/2SQTu3sIr4DZ/DMj8KIvIjBd5CG87Pr?=
 =?us-ascii?Q?dWW5K/Ys7FbLhBg88zpAJ0C689JUZ5adF2J6Wh6Nvfnb4WcyiJF2senTQ5f/?=
 =?us-ascii?Q?yPTVYXY6yHxo1bw7H6utyMobN7jehkp4zu4zt90wUOtHYnBct40yBwDOv3nN?=
 =?us-ascii?Q?uALCz+SB6Rus5ur2oK2RLU6jypbUQyDwnAhlbJ5RvtfeO6nPjtwiqpFGWjWt?=
 =?us-ascii?Q?Si0HfJO6GUz22QC1716bf1i8vq1SBaUSJ8vFq/uVpRBgpt6V5yE8hBDiLl0V?=
 =?us-ascii?Q?6wEiTkwrR0Ig7t/RewMjjz8Yma6ZxbaJo6LeUFRRAfCF0JJZmoEruFRXjlVQ?=
 =?us-ascii?Q?tbOQo5W5EKSEo2tOJOYY9NZDneUjRDsuxHqAb5ct50NylcRPjonaRjY5ZXP4?=
 =?us-ascii?Q?PNAZzQh+uI6wzFJAgloDr8PULoH0TPhz7IuNC4KquS/uDcFY6D8FBw85Xk+8?=
 =?us-ascii?Q?MTID679dBJOlQoEZM6zfd5Xjk6Uj3H2olT4KFH6qFx9N/ASVCNMgZPaOPZPK?=
 =?us-ascii?Q?dX9n6u/FAu9gIvnya4ehbZlfpvkjX+6wV3xQa4Ixszd2FEZozD7AKWKMLucj?=
 =?us-ascii?Q?sFrE4Bt4JSwLpFeajnbH/nR+tcccDEAwnIU440aDahHYQVWCmuH84n04eezY?=
 =?us-ascii?Q?+Pedq5i8rtjEZrH2RuqXU1hyhvddcn1LWQ0TqCcEMQjiVSKA+U7zafVZpLpj?=
 =?us-ascii?Q?k/IXHLCu339RrURdKUl0fp10gOso6poh78n7TnSfWkgAttL59eXIqp26l8z1?=
 =?us-ascii?Q?1awVZbYQbo/nuWM8dAjShEER2zyjDueY+GDrZwZ2Lx5qW0IzZ48MnNwZQDLm?=
 =?us-ascii?Q?IifzCTv4r19K8Q/dBvJoRsUBAHFV9SGbt3RL+F5gkjCq2R16hVgfOIHpPJBq?=
 =?us-ascii?Q?+ObTJRnQKbToAYwjEZLMO68wNiaKJ/DmdImmBstafrh83FRpuwVQTi3SfEkm?=
 =?us-ascii?Q?ebxPKPldMGfr4fVJOQ5SqD7wbH4zWcQKsVR6si1DTErnXHdYv0Lnh+qvIrj6?=
 =?us-ascii?Q?aNQdAcyxs43rBjRriOH1UGDO1NQTU+UFImufmwfefrOcPZTrjqeQeXYDeZTv?=
 =?us-ascii?Q?lmrve/CDsy/cZDwDtpar7zjY0A0JFJNu7NW3MsPNwFxfpOKBD9UoB+lD11dw?=
 =?us-ascii?Q?h9s4Poz6RDDLSNNHPWKysfYnWNAVfx7UcmP5bsqFwmin7pBCIOi5HIP4136t?=
 =?us-ascii?Q?+XpWFFG909rZf3qV7CPFBNJHSTgMpUwVuTtzdPxLX/Mg7j05ko0vR2Jrt1r+?=
 =?us-ascii?Q?k9FnjUdfL6gWuXjweeuM5lZagtTOi0nudIvsxrTmDKHfF5AFZsSrTE5jMkTE?=
 =?us-ascii?Q?Bksn/BJYBG+i6OOwTR0l0TA++32lVk+VNkBN7ErOjK6TFz6QcknWuAxheu3k?=
 =?us-ascii?Q?u/2ppw60cRrwPXv8yRF8z7+zbPc4aLaixWUhwOZRjrbgH0ETWsVkjxoOZvYR?=
 =?us-ascii?Q?gduSBdNOUI7iq5xFr24ImmWf22ySwWDC1NvyVQCT1IV2mwhXIOTZ683MGofn?=
 =?us-ascii?Q?Cm0CXwi0PyP3Ux6lkGZEZNemh9/g7M4201ImxfL0sHpdfKGE2q4eRSduMO9a?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+wyGVln2JQdHtZT+xf8Fmn0DatYLGrU2UpfFMkWqHyhYKYiRfzcn5QizOYHpVgAjD19wZ4y7rb+UiY2KfQVZ1luqzKIziSVdm0jjW7PJOoavQOpbOvx2n8RjUTXnnp4q/w0SNwjvKJYlHgyyjCzEb2WyMNN0zQgOhLIwz/EMHEVT9wl4Qp8eG4L5js/Rb4US0Tfo905cQeXcJig2jukWZUl9PJh4EECqgDCt/vuqiFUaH80OiZJjrWTNP3WzC1etfC7fQ3fSgw3yQItPN+sYqVfsc/lWeRUvHQ9rKW7rQ4vdq2XAYTumhlzcwhViTPZJgj4kgPX9+EPuNXpc8x9p0vfFDITc741TanGrQzt+oc4fkDO1Tykc5VNnJgxFfId7pi6sAU13ZZMsk3k0i23NX84QmwGyoYQUxHFIMR97bbss72vLnpbBISrWVIEYunA3swqBsBoy5nMmx9vkHnSs6L79IZxH9NNLExmrBDC+WGhIOLFeRdIDiHF17Klh+4waPhzkr/wFvHxEqydAon4MPEPM8lLRyOT6mcmTScfTCVSDbIZgJGL/cIRHu0X6RsnEecBg3onc5T/ATJxwH5ztKa0uDK43p5r00DbveJ9OZsI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227d21f2-ac25-450e-3a41-08dcfcdb7292
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 14:17:43.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jG16HgxCGt+t1mswf5tPucKQHBWVy0xQ5OtGys9JROOdF7amEqDaB+6KrXo2niMyXrvZnqQ4PmybdSAcrfqcrvWanlHBUrv/i2hFgbA48jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_11,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411040124
X-Proofpoint-ORIG-GUID: 4g_VxiqnQu2Q6IB4qNtXCBq3IuNaWaT_
X-Proofpoint-GUID: 4g_VxiqnQu2Q6IB4qNtXCBq3IuNaWaT_

On Sat, Nov 02, 2024 at 11:00:20AM +0200, Mike Rapoport wrote:
> On Fri, Nov 01, 2024 at 06:50:33PM +0000, Lorenzo Stoakes wrote:
> > Locking around VMAs is complicated and confusing. While we have a number of
> > disparate comments scattered around the place, we seem to be reaching a
> > level of complexity that justifies a serious effort at clearly documenting
> > how locks are expected to be interacted with when it comes to interacting
> > with mm_struct and vm_area_struct objects.
> >
> > This is especially pertinent as regards efforts to find sensible
> > abstractions for these fundamental objects within the kernel rust
> > abstraction whose compiler strictly requires some means of expressing these
> > rules (and through this expression can help self-document these
> > requirements as well as enforce them which is an exciting concept).
> >
> > The document limits scope to mmap and VMA locks and those that are
> > immediately adjacent and relevant to them - so additionally covers page
> > table locking as this is so very closely tied to VMA operations (and relies
> > upon us handling these correctly).
> >
> > The document tries to cover some of the nastier and more confusing edge
> > cases and concerns especially around lock ordering and page table teardown.
> >
> > The document also provides some VMA lock internals, which are up to date
> > and inclusive of recent changes to recent sequence number changes.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >
> > REVIEWERS NOTES:
> >    You can speed up doc builds by running `make SPHINXDIRS=mm htmldocs`. I
> >    also uploaded a copy of this to my website at
> >    https://ljs.io/output/mm/vma_locks to make it easier to have a quick
> >    read through. Thanks!
> >
> >
> >  Documentation/mm/index.rst     |   1 +
> >  Documentation/mm/vma_locks.rst | 527 +++++++++++++++++++++++++++++++++
> >  2 files changed, 528 insertions(+)
> >  create mode 100644 Documentation/mm/vma_locks.rst
> >
> > diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> > index 0be1c7503a01..da5f30acaca5 100644
> > --- a/Documentation/mm/index.rst
> > +++ b/Documentation/mm/index.rst
> > @@ -64,3 +64,4 @@ documentation, or deleted if it has served its purpose.
> >     vmemmap_dedup
> >     z3fold
> >     zsmalloc
> > +   vma_locks
>
> Please keep the TOC sorted alphabetically.

Ack, as per response to SJ, will address.

>
> > diff --git a/Documentation/mm/vma_locks.rst b/Documentation/mm/vma_locks.rst
> > new file mode 100644
> > index 000000000000..52b9d484376a
> > --- /dev/null
> > +++ b/Documentation/mm/vma_locks.rst
> > @@ -0,0 +1,527 @@
> > +VMA Locking
> > +===========
> > +
> > +Overview
> > +--------
> > +
> > +Userland memory ranges are tracked by the kernel via Virtual Memory Areas or
> > +'VMA's of type `struct vm_area_struct`.
> > +
> > +Each VMA describes a virtually contiguous memory range with identical
> > +attributes, each of which described by a `struct vm_area_struct`
> > +object. Userland access outside of VMAs is invalid except in the case where an
> > +adjacent stack VMA could be extended to contain the accessed address.
> > +
> > +All VMAs are contained within one and only one virtual address space, described
> > +by a `struct mm_struct` object which is referenced by all tasks (that is,
> > +threads) which share the virtual address space. We refer to this as the `mm`.
> > +
> > +Each mm object contains a maple tree data structure which describes all VMAs
> > +within the virtual address space.
> > +
> > +The kernel is designed to be highly scalable against concurrent access to
> > +userland memory,
>
> "and concurrent changes to the virtual address space layoyt"?

Well, not sure that's quite true to be honest, because we go out of our way to
exclude other users when we change the address space layout. Really I was
getting at the fact you can have simultaneous readers and especially, with VMA
locks, simultaneous fault handlers.

Will update to reference read operations against VMAs.

>
> > so a complicated set of locks are required to ensure no data
> > +races or memory corruption occurs.
> > +
> > +This document explores this locking in detail.
> > +
> > +.. note::
> > +
> > +   There are three different things that a user might want to achieve via
> > +   locks - the first of which is **stability**. That is - ensuring that the VMA
> > +   won't be freed or modified in any way from underneath us.
> > +
> > +   All MM and VMA locks ensure stability.
> > +
> > +   Secondly we have locks which allow **reads** but not writes (and which might
> > +   be held concurrent with other CPUs who also hold the read lock).
>
> I think it should be clarified here that *reads* are from data structures
> rather than user memory.

Ack will update.

>
> > +
> > +   Finally, we have locks which permit exclusive access to the VMA to allow for
>
>                                                                       ^ object
> > +   **writes** to the VMA.

Ack

> > +
> > +MM and VMA locks
> > +----------------
> > +
> > +There are two key classes of lock utilised when reading and manipulating VMAs -
> > +the `mmap_lock` which is a read/write semaphore maintained at the `mm_struct`
> > +level of granularity and, if CONFIG_PER_VMA_LOCK is set, a per-VMA lock at the
> > +VMA level of granularity.
> > +
> > +.. note::
> > +
> > +   Generally speaking, a read/write semaphore is a class of lock which permits
> > +   concurrent readers. However a write lock can only be obtained once all
> > +   readers have left the critical region (and pending readers made to wait).
> > +
> > +   This renders read locks on a read/write semaphore concurrent with other
> > +   readers and write locks exclusive against all others holding the semaphore.
> > +
> > +If CONFIG_PER_VMA_LOCK is not set, then things are relatively simple - a write
> > +mmap lock gives you exclusive write access to a VMA, and a read lock gives you
> > +concurrent read-only access.
> > +
> > +In the presence of CONFIG_PER_VMA_LOCK, i.e. VMA locks, things are more
> > +complicated. In this instance, a write semaphore is no longer enough to gain
> > +exclusive access to a VMA, a VMA write lock is also required.
> > +
> > +The VMA lock is implemented via the use of both a read/write semaphore and
> > +per-VMA and per-mm sequence numbers. We go into detail on this in the VMA lock
> > +internals section below, so for the time being it is important only to note that
> > +we can obtain either a VMA read or write lock.
> > +
> > +.. note::
>
> I don't think the below text should be a "note", I'd just keep at
> continuation of the section

Ack will change.

>
> > +
> > +   VMAs under VMA **read** lock are obtained by the `lock_vma_under_rcu()`
> > +   function, and **no** existing mmap or VMA lock must be held, This function
> > +   either returns a read-locked VMA, or NULL if the lock could not be
> > +   acquired. As the name suggests, the VMA will be acquired under RCU, though
> > +   once obtained, remains stable.
> > +
> > +   This kind of locking is entirely optimistic - if the lock is contended or a
> > +   competing write has started, then we do not obtain a read lock.
> > +
> > +   The `lock_vma_under_rcu()` function first calls `rcu_read_lock()` to ensure
> > +   that the VMA is acquired in an RCU critical section, then attempts to VMA
> > +   lock it via `vma_start_read()`, before releasing the RCU lock via
> > +   `rcu_read_unlock()`.
> > +
> > +   VMA read locks hold the a read lock on the `vma->vm_lock` semaphore for their
>
>                          ^ no idea if it should be 'a' or 'the', but surely
> not both :)

Sometimes you have to put both _just to be sure_ ;) nah only joking, will drop
the 'a'...

>
> > +   duration and the caller of `lock_vma_under_rcu()` must release it via
> > +   `vma_end_read()`.
> > +
> > +   VMA **write** locks are acquired via `vma_start_write()` in instances where a
> > +   VMA is about to be modified, unlike `vma_start_read()` the lock is always
> > +   acquired. An mmap write lock **must** be held for the duration of the VMA
> > +   write lock, releasing or downgrading the mmap write lock also releases the
> > +   VMA write lock so there is no `vma_end_write()` function.
> > +
> > +   Note that a semaphore write lock is not held across a VMA lock. Rather, a
> > +   sequence number is used for serialisation, and the write semaphore is only
> > +   acquired at the point of write lock to update this (we explore this in detail
> > +   in the VMA lock internals section below).
> > +
> > +   This ensures the semantics we require - VMA write locks provide exclusive
> > +   write access to the VMA.
> > +
> > +Examining all valid lock state and what each implies:
> > +
> > +.. list-table::
> > +   :header-rows: 1
>
> Can we make it just .. table:

I didn't know you could do tables. I am new to rst... :) Will do!

>
> .. table::
>
>     ========= ======== ======= ================ =================
>     mmap lock VMA lock Stable? Can read safely? Can write safely?
>     ========= ======== ======= ================ =================
>     \-        \-       N       N                N
>     R         \-       Y       Y                N
>     \-        R        Y       Y                N
>     W         \-       Y       Y                N
>     W         W        Y       Y                Y
>     ========= ======== ======= ================ =================
>
> > +
> > +   * - mmap lock
> > +     - VMA lock
> > +     - Stable?
> > +     - Can read safely?
> > +     - Can write safely?
> > +   * - \-
> > +     - \-
> > +     - N
> > +     - N
> > +     - N
> > +   * - R
> > +     - \-
> > +     - Y
> > +     - Y
> > +     - N
> > +   * - \-
> > +     - R
> > +     - Y
> > +     - Y
> > +     - N
> > +   * - W
> > +     - \-
> > +     - Y
> > +     - Y
> > +     - N
> > +   * - W
> > +     - W
> > +     - Y
> > +     - Y
> > +     - Y
> > +
> > +Note that there are some exceptions to this - the `anon_vma` field is permitted
> > +to be written to under mmap read lock and is instead serialised by the `struct
> > +mm_struct` field `page_table_lock`. In addition the `vm_mm` and all
> > +lock-specific fields are permitted to be read under RCU alone  (though stability cannot
> > +be expected in this instance).
> > +
> > +.. note::
> > +   The most notable place to use the VMA read lock is on page table faults on
> > +   the x86-64 architecture, which importantly means that without a VMA write
> > +   lock, page faults can race against you even if you hold an mmap write lock.
> > +
> > +VMA Fields
> > +----------
> > +
> > +We examine each field of the `struct vm_area_struct` type in detail in the table
> > +below.
> > +
> > +Reading of each field requires either an mmap read lock or a VMA read lock to be
> > +held, except where 'unstable RCU read' is specified, in which case unstable
> > +access to the field is permitted under RCU alone.
> > +
> > +The table specifies which write locks must be held to write to the field.
> > +
> > +.. list-table::
> > +   :widths: 20 10 22 5 20
> > +   :header-rows: 1
>
> And use .. table here as well, e.g

Hm this one is a little less clearly worth it because not only will that take me
ages but it'll be quite difficult to read in a sensible editor. I can if you
insist though?

>
> .. table::
>
>     ======== ======== ========================== ================== ==========
>     Field    Config   Description                Unstable RCU read? Write lock
>     ======== ======== ========================== ================== ==========
>     vm_start          Inclusive start virtual                       mmap write,
>                       address of range VMA                          VMA write
> 		      describes
>
>     vm_end            Exclusive end virtual                         mmap write,
>                       address of range VMA                          VMA write
> 		      describes
>
>     vm_rcu   vma_lock RCU list head, in union    N/A                N/A
>                       with vma_start, vma_end.
> 		      RCU implementation detail
>     ======== ======== ========================== ================== ==========
>
>
> > +
> > +   * - Field
> > +     - Config
> > +     - Description
> > +     - Unstable RCU read?
> > +     - Write Lock
> > +   * - vm_start
> > +     -
> > +     - Inclusive start virtual address of range VMA describes.
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_end
> > +     -
> > +     - Exclusive end virtual address of range VMA describes.
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_rcu
> > +     - vma lock
> > +     - RCU list head, in union with vma_start, vma_end. RCU implementation detail.
> > +     - N/A
> > +     - N/A
> > +   * - vm_mm
> > +     -
> > +     - Containing mm_struct.
> > +     - Y
> > +     - (Static)
> > +   * - vm_page_prot
> > +     -
> > +     - Architecture-specific page table protection bits determined from VMA
> > +       flags
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_flags
> > +     -
> > +     - Read-only access to VMA flags describing attributes of VMA, in union with
> > +       private writable `__vm_flags`.
> > +     -
> > +     - N/A
> > +   * - __vm_flags
> > +     -
> > +     - Private, writable access to VMA flags field, updated by vm_flags_*()
> > +       functions.
> > +     -
> > +     - mmap write, VMA write
> > +   * - detached
> > +     - vma lock
> > +     - VMA lock implementation detail - indicates whether the VMA has been
> > +       detached from the tree.
> > +     - Y
> > +     - mmap write, VMA write
> > +   * - vm_lock_seq
> > +     - vma lock
> > +     - VMA lock implementation detail - A sequence number used to serialise the
> > +       VMA lock, see the VMA lock section below.
> > +     - Y
> > +     - mmap write, VMA write
> > +   * - vm_lock
> > +     - vma lock
> > +     - VMA lock implementation detail - A pointer to the VMA lock read/write
> > +       semaphore.
> > +     - Y
> > +     - None required
> > +   * - shared.rb
> > +     -
> > +     - A red/black tree node used, if the mapping is file-backed, to place the
> > +       VMA in the `struct address_space->i_mmap` red/black interval tree.
> > +     -
> > +     - mmap write, VMA write, i_mmap write
> > +   * - shared.rb_subtree_last
> > +     -
> > +     - Metadata used for management of the interval tree if the VMA is
> > +       file-backed.
> > +     -
> > +     - mmap write, VMA write, i_mmap write
> > +   * - anon_vma_chain
> > +     -
> > +     - List of links to forked/CoW'd `anon_vma` objects.
> > +     -
> > +     - mmap read or above, anon_vma write lock
> > +   * - anon_vma
> > +     -
> > +     - `anon_vma` object used by anonymous folios mapped exclusively to this VMA.
> > +     -
> > +     - mmap read or above, page_table_lock
> > +   * - vm_ops
> > +     -
> > +     - If the VMA is file-backed, then either the driver or file-system provides
> > +       a `struct vm_operations_struct` object describing callbacks to be invoked
> > +       on specific VMA lifetime events.
> > +     -
> > +     - (Static)
> > +   * - vm_pgoff
> > +     -
> > +     - Describes the page offset into the file, the original page offset within
> > +       the virtual address space (prior to any `mremap()`), or PFN if a PFN map.
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_file
> > +     -
> > +     - If the VMA is file-backed, points to a `struct file` object describing
> > +       the underlying file, if anonymous then `NULL`.
> > +     -
> > +     - (Static)
> > +   * - vm_private_data
> > +     -
> > +     - A `void *` field for driver-specific metadata.
> > +     -
> > +     - Driver-mandated.
> > +   * - anon_name
> > +     - anon name
> > +     - A field for storing a `struct anon_vma_name` object providing a name for
> > +       anonymous mappings, or `NULL` if none is set or the VMA is file-backed.
> > +     -
> > +     - mmap write, VMA write
> > +   * - swap_readahead_info
> > +     - swap
> > +     - Metadata used by the swap mechanism to perform readahead.
> > +     -
> > +     - mmap read
> > +   * - vm_region
> > +     - nommu
> > +     - The containing region for the VMA for architectures which do not
> > +       possess an MMU.
> > +     - N/A
> > +     - N/A
> > +   * - vm_policy
> > +     - numa
> > +     - `mempolicy` object which describes NUMA behaviour of the VMA.
> > +     -
> > +     - mmap write, VMA write
> > +   * - numab_state
> > +     - numab
> > +     - `vma_numab_state` object which describes the current state of NUMA
> > +       balancing in relation to this VMA.
> > +     -
> > +     - mmap write, VMA write
> > +   * - vm_userfaultfd_ctx
> > +     -
> > +     - Userfaultfd context wrapper object of type `vm_userfaultfd_ctx`, either
> > +       of zero size if userfaultfd is disabled, or containing a pointer to an
> > +       underlying `userfaultfd_ctx` object which describes userfaultfd metadata.
> > +     -
> > +     - mmap write, VMA write
> > +
> > +.. note::
> > +
> > +   In the config column 'vma lock' configuration means CONFIG_PER_VMA_LOCK,
> > +   'anon name' means CONFIG_ANON_VMA_NAME, 'swap' means CONFIG_SWAP, 'nommu'
> > +   means that CONFIG_MMU is not set, 'numa' means CONFIG_NUMA and 'numab' means
> > +   CONFIG_NUMA_BALANCING'.
> > +
> > +   In the write lock column '(Static)' means that the field is set only once
> > +   upon initialisation of the VMA and not changed after this, the VMA would
> > +   either have been under an mmap write and VMA write lock at the time or not
> > +   yet inserted into any tree.
> > +
> > +Page table locks
> > +----------------
> > +
> > +When allocating a P4D, PUD or PMD and setting the relevant entry in the above
> > +PGD, P4D or PUD, the `mm->page_table_lock` is acquired to do so. This is
> > +acquired in `__p4d_alloc()`, `__pud_alloc()` and `__pmd_alloc()` respectively.
> > +
> > +.. note::
> > +   `__pmd_alloc()` actually invokes `pud_lock()` and `pud_lockptr()` in turn,
> > +   however at the time of writing it ultimately references the
> > +   `mm->page_table_lock`.
> > +
> > +Allocating a PTE will either use the `mm->page_table_lock` or, if
> > +`USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in the PMD physical
> > +page metadata in the form of a `struct ptdesc`, acquired by `pmd_ptdesc()`
> > +called from `pmd_lock()` and ultimately `__pte_alloc()`.
> > +
> > +Finally, modifying the contents of the PTE has special treatment, as this is a
> > +lock that we must acquire whenever we want stable and exclusive access to
> > +entries pointing to data pages within a PTE, especially when we wish to modify
> > +them.
> > +
> > +This is performed via `pte_offset_map_lock()` which carefully checks to ensure
> > +that the PTE hasn't changed from under us, ultimately invoking `pte_lockptr()`
> > +to obtain a spin lock at PTE granularity contained within the `struct ptdesc`
> > +associated with the physical PTE page. The lock must be released via
> > +`pte_unmap_unlock()`.
> > +
> > +.. note::
> > +   There are some variants on this, such as `pte_offset_map_rw_nolock()` when we
> > +   know we hold the PTE stable but for brevity we do not explore this.
> > +   See the comment for `__pte_offset_map_lock()` for more details.
> > +
> > +When modifying data in ranges we typically only wish to allocate higher page
> > +tables as necessary, using these locks to avoid races or overwriting anything,
> > +and set/clear data at the PTE level as required (for instance when page faulting
> > +or zapping).
> > +
> > +Page table teardown
> > +-------------------
> > +
> > +Tearing down page tables themselves is something that requires significant
> > +care. There must be no way that page tables designated for removal can be
> > +traversed or referenced by concurrent tasks.
> > +
> > +It is insufficient to simply hold an mmap write lock and VMA lock (which will
> > +prevent racing faults, and rmap operations), as a file-backed mapping can be
> > +truncated under the `struct address_space` i_mmap_lock alone.
> > +
> > +As a result, no VMA which can be accessed via the reverse mapping (either
> > +anon_vma or the `struct address_space->i_mmap` interval tree) can have its page
> > +tables torn down.
> > +
> > +The operation is typically performed via `free_pgtables()`, which assumes either
> > +the mmap write lock has been taken (as specified by its `mm_wr_locked`
> > +parameter), or that it the VMA is fully detached.
>
>                "or that the VMA is..." ?
>
> > +It carefully removes the VMA from all reverse mappings, however it's important
> > +that no new ones overlap these or any route remain to permit access to addresses
> > +within the range whose page tables are being torn down.
> > +
> > +As a result of these careful conditions, note that page table entries are
> > +cleared without page table locks, as it is assumed that all of these precautions
> > +have already been taken.
> > +
> > +mmap write lock downgrading
> > +---------------------------
> > +
> > +While it is possible to obtain an mmap write or read lock using the
> > +`mm->mmap_lock` read/write semaphore, it is also possible to **downgrade** from
> > +a write lock to a read lock via `mmap_write_downgrade()`.
> > +
> > +Similar to `mmap_write_unlock()`, this implicitly terminates all VMA write locks
> > +via `vma_end_write_all()` (more or this behaviour in the VMA lock internals
> > +section below), but importantly does not relinquish the mmap lock while
> > +downgrading, therefore keeping the locked virtual address space stable.
> > +
> > +A subtlety here is that callers can assume, if they invoke an
> > +mmap_write_downgrade() operation, that they still have exclusive access to the
> > +virtual address space (excluding VMA read lock holders), as for another task to
> > +have downgraded they would have had to have exclusive access to the semaphore
> > +which can't be the case until the current task completes what it is doing.
> > +
> > +Stack expansion
> > +---------------
> > +
> > +Stack expansion throws up additional complexities in that we cannot permit there
> > +to be racing page faults, as a result we invoke `vma_start_write()` to prevent
> > +this in `expand_downwards()` or `expand_upwards()`.
> > +
> > +Lock ordering
> > +-------------
> > +
> > +As we have multiple locks across the kernel which may or may not be taken at the
> > +same time as explicit mm or VMA locks, we have to be wary of lock inversion, and
> > +the **order** in which locks are acquired and released becomes very important.
> > +
> > +.. note::
> > +
> > +   Lock inversion occurs when two threads need to acquire multiple locks,
> > +   but in doing so inadvertently cause a mutual deadlock.
> > +
> > +   For example, consider thread 1 which holds lock A and tries to acquire lock B,
> > +   while thread 2 holds lock B and tries to acquire lock A.
> > +
> > +   Both threads are now deadlocked on each other. However, had they attempted to
> > +   acquire locks in the same order, one would have waited for the other to
> > +   complete its work and no deadlock would have occurred.
> > +
> > +The opening comment in `mm/rmap.c` describes in detail the required ordering of
> > +locks within memory management code:
> > +
> > +.. code-block::
> > +
> > +  inode->i_rwsem	(while writing or truncating, not reading or faulting)
> > +    mm->mmap_lock
> > +      mapping->invalidate_lock (in filemap_fault)
> > +        folio_lock
> > +          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
> > +            vma_start_write
> > +              mapping->i_mmap_rwsem
> > +                anon_vma->rwsem
> > +                  mm->page_table_lock or pte_lock
> > +                    swap_lock (in swap_duplicate, swap_info_get)
> > +                      mmlist_lock (in mmput, drain_mmlist and others)
> > +                      mapping->private_lock (in block_dirty_folio)
> > +                          i_pages lock (widely used)
> > +                            lruvec->lru_lock (in folio_lruvec_lock_irq)
> > +                      inode->i_lock (in set_page_dirty's __mark_inode_dirty)
> > +                      bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
> > +                        sb_lock (within inode_lock in fs/fs-writeback.c)
> > +                        i_pages lock (widely used, in set_page_dirty,
> > +                                  in arch-dependent flush_dcache_mmap_lock,
> > +                                  within bdi.wb->list_lock in __sync_single_inode)
> > +
> > +Please check the current state of this comment which may have changed since the
> > +time of writing of this document.
> > +
> > +VMA lock internals
> > +------------------
> > +
> > +The VMA lock mechanism is designed to be a lightweight means of avoiding the use
> > +of the heavily contended mmap lock. It is implemented using a combination of a
> > +read/write semaphore and sequence numbers belonging to the containing `struct
> > +mm_struct` and the VMA.
> > +
> > +Read locks are acquired via `vma_start_read()`, which is an optimistic
> > +operation, i.e. it tries to acquire a read lock but returns false if it is
> > +unable to do so. At the end of the read operation, `vma_end_read()` is called to
> > +release the VMA read lock. This can be done under RCU alone.
> > +
> > +Writing requires the mmap to be write-locked and the VMA lock to be acquired via
> > +`vma_start_write()`, however the write lock is released by the termination or
> > +downgrade of the mmap write lock so no `vma_end_write()` is required.
> > +
> > +All this is achieved by the use of per-mm and per-VMA sequence counts. This is
> > +used to reduce complexity, and potential especially around operations which
> > +write-lock multiple VMAs at once.
> > +
> > +If the mm sequence count, `mm->mm_lock_seq` is equal to the VMA sequence count
> > +`vma->vm_lock_seq` then the VMA is write-locked. If they differ, then they are
> > +not.
> > +
> > +Each time an mmap write lock is acquired in `mmap_write_lock()`,
> > +`mmap_write_lock_nested()`, `mmap_write_lock_killable()`, the `mm->mm_lock_seq`
> > +sequence number is incremented via `mm_lock_seqcount_begin()`.
> > +
> > +Each time the mmap write lock is released in `mmap_write_unlock()` or
> > +`mmap_write_downgrade()`, `vma_end_write_all()` is invoked which also increments
> > +`mm->mm_lock_seq` via `mm_lock_seqcount_end()`.
> > +
> > +This way, we ensure regardless of the VMA's sequence number count, that a write
> > +lock is not incorrectly indicated (since we increment the sequence counter on
> > +acquiring the mmap write lock, which is required in order to obtain a VMA write
> > +lock), and that when we release an mmap write lock, we efficiently release
> > +**all** VMA write locks contained within the mmap at the same time.
> > +
> > +The exclusivity of the mmap write lock ensures this is what we want, as there
> > +would never be a reason to persist per-VMA write locks across multiple mmap
> > +write lock acquisitions.
> > +
> > +Each time a VMA read lock is acquired, we acquire a read lock on the
> > +`vma->vm_lock` read/write semaphore and hold it, while checking that the
> > +sequence count of the VMA does not match that of the mm.
> > +
> > +If it does, the read lock fails. If it does not, we hold the lock, excluding
> > +writers, but permitting other readers, who will also obtain this lock under RCU.
> > +
> > +Importantly, maple tree operations performed in `lock_vma_under_rcu()` are also
> > +RCU safe, so the whole read lock operation is guaranteed to function correctly.
> > +
> > +On the write side, we acquire a write lock on the `vma->vm_lock` read/write
> > +semaphore, before setting the VMA's sequence number under this lock, also
> > +simultaneously holding the mmap write lock.
> > +
> > +This way, if any read locks are in effect, `vma_start_write()` will sleep until
> > +these are finished and mutual exclusion is achieved.
> > +
> > +After setting the VMA's sequence number, the lock is released, avoiding
> > +complexity with a long-term held write lock.
> > +
> > +This clever combination of a read/write semaphore and sequence count allows for
> > +fast RCU-based per-VMA lock acquisition (especially on x86-64 page fault, though
> > +utilised elsewhere) with minimal complexity around lock ordering.
> > --
> > 2.47.0
>
> --
> Sincerely yours,
> Mike.

