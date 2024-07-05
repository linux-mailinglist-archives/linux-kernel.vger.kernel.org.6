Return-Path: <linux-kernel+bounces-242878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E85928E45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97842287491
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF18613C681;
	Fri,  5 Jul 2024 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e3+wwjKu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NdNc+ANQ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04C1F61C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 20:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720211471; cv=fail; b=rsCNd7h+dPpq8EvqzUtBg9XckeFbtOHQfXQ+XvBKR9mVvYXrUAHtS6R9IW1h/zjARtwXWQwQUErypAMFdJ+UOy+sjR6E57ENuYwHXkXUekc/Ce56mOnq3i7QR5e10x/1hp/uThsa1IIFZawK4/BVTaKAQI3+4+yBs3/uUkNVsd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720211471; c=relaxed/simple;
	bh=W3ubDzemnnH1uQex4ZjC54B0YsyPN+Bs3udhocBDFKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y48L7MxYaxqh53yK5cADIzQbS+KnKH9CUfxXaxYkBj0npJPgyPp8SLdylOrug/5Szy4YwlET79QXm9NZM2SRVfdjU50hGhe7SxeWg/JBBvtTWigaMYYmMMzh426LkMt+HeahpkuJ/l1BAFAmGjLLYm/guSav7eTaDySvKV1qawU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e3+wwjKu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NdNc+ANQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465K7Zbd030301;
	Fri, 5 Jul 2024 20:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Jyug9s2LVPFHesa
	OgzNPwXS0MQGmRa/V5lfG2/DM5TM=; b=e3+wwjKuy/A/4HdtWXoBH2Fkh+tlP0i
	wvd+GCYwdV9G00mYMb11xzYwboeRronZ5AOupoz7O7zIXS+RKGwVfSrDVhiEsEL7
	Z/wlj3h28xZWrdZhyJd5BplUT9Hsl8s3Ol/F9H3WuKF5wGdd9MfwzBKQr1uqKBTC
	sws/WUuxlMrVOQzq7mM3BNzzS7OwGuEXAiLZHMZgkdna9+EGsTHDA487NHcpoFJv
	DzAi4LZUmy19r4fBRYjsTEk+aO0lC/56j53Ga1RY2mb8DLjqKeczrXTt75EOYstp
	PcR0Dv0FLcmtDis1kbdWVUPVPdlm6V03jxYPmtU6hPu/v6CL5VnqtVg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsvd2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:30:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465K0m6G021527;
	Fri, 5 Jul 2024 20:30:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhsp31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 20:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOuFZ2LTyWXN/yCObM2ORpNrFIwo3Ut4zOHRWfEnhkgYr+unP+36bm9TgUOCXrkqe5Clvom/+DvieNb/SE0vTnPAI6Jr3aJsgWshut4vQhYvXUZ5V6UJQEum0xA6zDonzg74gFHrbaINXwFmDNSuqB7oxiuclAL8rFQ+fDN5xAdPsgYghhURbrW7/zV9V6wwugXFnNuFZMoOzwAVbQSFlttBBAl6NxANBv1/8z/dd4oBg+Kmx1sLYsM/bHV8oSmgUEuamBVlpDtm3UoJSC2Emd5ZVXTaPgjFBwtuxorpzqpOyvglCqTLyfygFzc8MhpmCr6dvcI6F86PU0qNl/Plew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jyug9s2LVPFHesaOgzNPwXS0MQGmRa/V5lfG2/DM5TM=;
 b=e3DBnFV9O2I+yIW5HDDvmiGXsFQ9NYRVyDmQJPkFaqEt9X2JpX0NIoa71g8KwEUTdvztf47LpoZZ1lWNB1Qp+pLvr6ff8bt2xW4sulpnUJOpMxzFkIogYj8MZuEDNWBCceQ4bgTghUwtNrId9mr9XKegP+V86eFTNkxOPdVWo3VWsaLGNDeo9huJlYZjx+5vgX0MyFRI0O3222y4+LssUypiMKPvwspT7vTQdzHbHZ/IpqmKBHqKlQGnGQu9vlLzKbI8mFFx11uZAKKoWePOKwm4hii5YcY737WWQ5LIA14VWG+TrGhtNLc1bicmhX6/u2y4wJvDSrj0wyXINWPMkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jyug9s2LVPFHesaOgzNPwXS0MQGmRa/V5lfG2/DM5TM=;
 b=NdNc+ANQqEujHZtfQ1SleJuU240zCLa5ctdzDbyZybLN41ZDtPUfZPrfXLWUI89UKtd6g+SvcEmSqdfe+zXdcT6eDD/bZcNft2P+Es88DjWVIPl09Ztg5D1HpNw3z9x7v8uw47cb+KOc6vRZ3+xt6DOC/kBZAH2DMkLMYMFpAj4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 5 Jul
 2024 20:30:49 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 20:30:49 +0000
Date: Fri, 5 Jul 2024 16:30:46 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 09/16] mm/mmap: Expand mmap_region() munmap call
Message-ID: <pnnhq7ok3uhm7a3va2gdnpjvywziqvicxrzp64a5dhfbmydjv3@x52pq3vq7zdv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-10-Liam.Howlett@oracle.com>
 <b283fae7-fe72-4bdf-a7d9-7508c3f93293@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b283fae7-fe72-4bdf-a7d9-7508c3f93293@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0090.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::23) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b9b06e-87dd-43c5-d8e8-08dc9d315b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EVJgsSYHnGZ+pQvlJz5JNKqnCIrRZ8elXwjHoeKGw84D/AVPHKygtMWNqrgb?=
 =?us-ascii?Q?g/nC/LhBx9RDFzG7aO7txCwOmBkJu+0H8y18gWrggiL/buwBLFgMdbb/AeRg?=
 =?us-ascii?Q?2i6EucVA7f//Zb1Bg35P74GMbDB4q/QQbTqunJUorGdreNr9Q3MLfjxuxpyy?=
 =?us-ascii?Q?VHsWSVJEdUK1HYEVH2dSefQCmGQp/AfsJgBd4ac7ylh0Iq2qLslv3x8usAEl?=
 =?us-ascii?Q?Mub7j6ip0MTKhXZUxpM+x0nXF1mjWcpBPrI7bZLLx/otp6oxtyqrMKi4Ylw4?=
 =?us-ascii?Q?J8TayXw+0KJ0buCyxza95D2WJKyzzqTVn7uc1X1yohZ/64L9t7MBqDacCGcY?=
 =?us-ascii?Q?+55J5NuxG0ta1dJgzJQNce2DimSRObUfg3j1vJHk+PhQgKNtVSPj0RJdCiJi?=
 =?us-ascii?Q?CYxyrkVAAgwgMbz/6VoVHI8kCLQBa6jl42Ew7tCz92wKzQcoXU6b7EFZiQ2/?=
 =?us-ascii?Q?thr8m4VCteZM1xif7jC2epEto85Vg+Px33C/WWm/07ZUcamDS/b8jORN6+6W?=
 =?us-ascii?Q?0wsNXAP6CmDfgYX893sHlQ4oHNbCtZ925qUaeV30+E1VQeO+J6YuqiUX/+0z?=
 =?us-ascii?Q?LBdAi5nqTtzQr7WC0DUOMqAHMCAEFQknYGhJrGdfcJWCVOF5Q6nTJBCScUlA?=
 =?us-ascii?Q?sLstvBq0DF5YLI7CcHAvbVacsaCo43i2Mb248D4b52hcTQ6y+CmeoqFYOUC0?=
 =?us-ascii?Q?B4RM8crxRwlDivwAWCg2JxNPWSx95NG87eSQsRbwuyKKOCi3ZyqGI0Zlu0MH?=
 =?us-ascii?Q?4kPiAZbNi1h/TPxskU5I66ukWd88ZtncbZ6nZXyMMOwinQGuZlFY4HKGmPJc?=
 =?us-ascii?Q?Lo7vSicvdmYHkKejpoiMTxN5WcngSbzjA+3N/on8FoZDjMvcYBjYmotqlQrt?=
 =?us-ascii?Q?yUodo5GTtaUqDsFcroZaApyMOMu0Sb9xzLRPoNXmjT4uaFW2Nm+L0xA0vPqD?=
 =?us-ascii?Q?t3oa8Z731cUntKsmeOa4UiQuSDeumx2zXosg3zc+dXsvd5nlYR3tZ3i8lmcl?=
 =?us-ascii?Q?bPpUJGB2pyJBpPt6hfsMy/kLrJ5iPdoTh2oONUVlE1bsailc6kGdNGlZB6rK?=
 =?us-ascii?Q?QYUExmcr9JtsX8p8VsWIR1wUhVQVn7aDj9FdFeMWkoOZOd5/e5R2m2HFdxJL?=
 =?us-ascii?Q?5pg+Ro2KfVB5F4O3h1NqnAQzxyK7WnXcDIJpVGKCpS6ffHiIFNdC4KmamnSp?=
 =?us-ascii?Q?G7wMez1hx7tUgcA0wwvND3gOxg6SHjSh31WSVFCPbcVv4eBQjloXP7wDl3v0?=
 =?us-ascii?Q?6/Y3soYeBk+jMyzjb0toLS35is16IuzYQmz4qF/q3j1dtTlLXFuhBICA0E1i?=
 =?us-ascii?Q?sgUsE46/vT2bvi/O8+m8zNLJpNrsyKw7mjUGIexOnISszA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Wxmnu/rFh99xSVSq/tkltqDE0uMyYsACSYIfwyg9PdRHa2/DBc8GSvA1i7kw?=
 =?us-ascii?Q?Xz7/Fakz+5Iz7r5YDLLAVFEa2e1nzhaZYuMCuqTIoyM6RaupQFuGpUbfQwiI?=
 =?us-ascii?Q?vB2zknez5UUcHaUZbmMz/YLotwyMxutJzwx6RtpVYMJFHq9gfEUsAg/z59/p?=
 =?us-ascii?Q?r5gPgGRCcyF3VrHLZnrr0D1gAuikLzOrI5xWtWPtY4+6E3Ef7ftuDnjvlFlp?=
 =?us-ascii?Q?hWtGMnzY8hdBPev7Lr14J70qm7CyEzkF0UO4nSGeBXZLQ2dOJfbJyY4soW6o?=
 =?us-ascii?Q?qULWyBRDNgrjZWw1O0Lvsm01YlRe1oQMyGpSQPWKO9vROH5hfAcZEjbDrnOe?=
 =?us-ascii?Q?BGEpCK72pyDr79hlLe/eM9K75Ojn1UQAbj9T24jbLTBgfE5GZPFm0HhvZabr?=
 =?us-ascii?Q?PDMuP3RnxpN0KZywJnkyuNUs049aK+f0xYy2Th3u+qYLQNUgbMnt8WOYiu5T?=
 =?us-ascii?Q?51akaaaIfrgAhe3PUAhS+nV8pyXbsfICO4VuvyX5s3xzeJklfph+x6UoyJhC?=
 =?us-ascii?Q?yHAvkhEzudgRt0nzx5ynwpyuD5+NcxfbzCTJzpQziqJYDJnQ9lvVjoD5CnuC?=
 =?us-ascii?Q?7x/vlrTB9wyo3wXGmf5eFjWjW/OYXYHM/7yo/6dvkzJB1vCsol1iJo2nvxHp?=
 =?us-ascii?Q?79M3rOZnfPfTsUFqgVVXE4KJzHiEmtBEyB27AVc7DSRx2Kjl3vqbk/RV2XSj?=
 =?us-ascii?Q?G040vbW5CS7JLwA1fm1zej12Q5qNGaG4dA3TGzuCKHGirRkGWUljXEtd3GUY?=
 =?us-ascii?Q?ZVKSXna+2G9v+2AD4ajcDcSBXEQb3RRbVRIBLLzEHawWmouWAXA0JMYpjUji?=
 =?us-ascii?Q?i2CB3nyoLuE3L1fh7T+PJM+usCjG8ZbdjDAFA290d1QG0yfYYCYPVX5ovGMP?=
 =?us-ascii?Q?/5XyHPEjWzM7sjZG8iK1CkxeLRAuL5x7mPwUY7hHX/++SnSA8WzMzTNj9ebt?=
 =?us-ascii?Q?z8uz2pSGXUajRnyS71dbvZ/rpOwI17JytEuJOkgOz4ZVzhSLkgSNibW9zosn?=
 =?us-ascii?Q?foNVvC1WQsad8+0EQ7qyf/ggzdSK3qW4Wg2psA7TrRla1dAumcj8vK0Fp9C9?=
 =?us-ascii?Q?hIvYv+bTPB6garJTI1B8EgJOkvM4qfaXzmgJpSmeTJmkOdCrklupqymn2c/6?=
 =?us-ascii?Q?bP2hhs2DlvmdqOmXFSofUnIVazvw6Yetb6dPGpX4ypYlbS1x6Sdg+dyCPI11?=
 =?us-ascii?Q?1KQL6jCEfXyX6b3je1Ie2N5WPkXSvSjbFAj/TKQR0ddgvsIQrH0N6Wk6dM5X?=
 =?us-ascii?Q?KiGnw07jMl+AjDv8iV8IoRLiXiGfvjZeyL0EtCV+akUCOpxNP/zjEyqco9lr?=
 =?us-ascii?Q?hv1WEltygrpOLefDdFGRzE2KHamu0nJvfxH1pPksAsLXDYBHMojcmuuETNQs?=
 =?us-ascii?Q?VDbFWM1XdOpT+BUwKDcLnvxOthtKP+aw1mZGRpaO2Rs2p/QvvRHkeHtx57uy?=
 =?us-ascii?Q?B/T+kiRlfzdNx2ewnO1t10VH58qC7f/Vq7A8SNI7WElQtW/2hybRy1QjrvQC?=
 =?us-ascii?Q?YiwDrmeWtfKA1id7EAuyWo323cu9tLBDAAWVu3ngdWYA8xjNjpH3YNi0qozS?=
 =?us-ascii?Q?m0aWFZYmuUO86XIt+HcBmNKIqqUpPzDBePCQhLlD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1oFhJQIBbBmF8HLYuvKe93G26ZjTI/LKlQQsH36LO9YAk6eskRvo5DOE/NgqAqJNkiuWhhZ+7yQp6mR6mKuGjn/6/fG88aJgkwoc6xdZkJyeuWlkB79V/CBl2mgI/O7wg+YgylhPw+70NoAm/2YwqMZyFQQ7RHLvIcx63H99Vae2yI2iXbltOryTZqTL/nYDqAarmkgrZDRNe3wy7Pd76YA47JXyeyY9nlgphC3GNFtUTFX+KXm/xWPSXw1N+zS2JSO30NN2GSG68QpNAlsWfcMa2/K6P2tHtaXVyWqUKd+0Dx3y40r1p/6nCNxpzJZ+uV5yvGE+pHNzoqHyP6Op/J3f7wad75NNZkzCDYdVBJXRH6KZ680PyAK2yN1rOYSObojVPLf5l/zhmd01dGo7F1ZH2CSyGB7yrbLkkT1WTPwKUArWUwa5uu9k16wsQhUf2x7PRJuMrSckMkF1rC7dUwIZme4bNW8sb2f5wMYRhbtLGyLn5Gh5go7sIggSp6uyX0i9SpPylkj+jk+rPJB7FxUxgQYXb6TA1ppmVc0ngq/NPsNdSs62+4/Gn9cRic5mRE37LgLr0A2kHe9MZwAXWGK2BKuzg1DV5nzNNPCefBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b9b06e-87dd-43c5-d8e8-08dc9d315b45
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 20:30:49.1121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDtWT3jnvaP13S/xMR9aVgWOvyy832Zmi9s2ZlZZjbz3givNm7Rsz/sTVndsprg7oP7IUQUzNoESnwEZRFlrEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_15,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050150
X-Proofpoint-GUID: 0Jt6Q6hY6d6gqUL494oEEWkIXMxdyQUI
X-Proofpoint-ORIG-GUID: 0Jt6Q6hY6d6gqUL494oEEWkIXMxdyQUI

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 16:06]:
> On Thu, Jul 04, 2024 at 02:27:11PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Open code the do_vmi_align_munmap() call so that it can be broken up
> > later in the series.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index e9858ca8bbd4..f5b33de4e717 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2915,6 +2915,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	struct vm_area_struct *next, *prev, *merge;
> >  	pgoff_t pglen = len >> PAGE_SHIFT;
> >  	unsigned long charged = 0;
> > +	struct vma_munmap_struct vms;
> > +	struct ma_state mas_detach;
> > +	struct maple_tree mt_detach;
> >  	unsigned long end = addr + len;
> >  	unsigned long merge_start = addr, merge_end = end;
> >  	bool writable_file_mapping = false;
> > @@ -2947,9 +2950,24 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	/* Find the first overlapping VMA */
> >  	vma = vma_find(&vmi, end);
> >  	if (vma) {
> > -		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
> > +		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
> > +		mt_on_stack(mt_detach);
> > +		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> 
> I'm guessing this is exactly equivalent (or equivalent enough for our purposes
> here) to the MA_STATE() call in do_vmi_align_munmap()?

Yes, what we are doing is inlining the function call so that it can be
split to parts.  So for reviewing, I just made it in-line.

> 
> Checking the two against each other it seems that it is indeed.
> 
> > +		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
> > +		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> > +			return -ENOMEM;
> 
> In do_vmi_align_munmap() we also invoke vmalidate_mm(), why aren't we doing that
> here?

I don't see the validate_mm() call in do_vmi_align_munmap, it is called
in the vms_complete_munmap_vmas() function  though.

> 
> > +
> > +		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> >  			return -ENOMEM;
> 
> Same here.

It would fail here, our count would be wrong.

> 
> > +
> > +		vms_complete_munmap_vmas(&vms, &mas_detach);
> > +		next = vms.next;
> > +		prev = vms.prev;
> > +		vma_prev(&vmi);
> 
> I'm sure this is correct, but just to double-check - we want to set the VMI to
> prev here right?

Yes.  In the current function, the vmi points to prev when we are done
this dance - so I put it there.
> 
> It might be worth adding a small cmoment saying '/* vmi now points at prev */'
> or similar, I've found it can get quite hard to follow where the iterator is at
> sometimes.

So this is about to change..

> 
> >  		vma = NULL;
> > +	} else {
> > +		next = vma_next(&vmi);
> > +		prev = vma_prev(&vmi);
> 
> But here we move forward to the next VMA and set this to next, then go back to
> the _original_ one and this is prev?
> 
> Actually I guess if vma == NULL, next gets you to the next, and prev jumps back
> to prev, with nothing between, and so that makes sense.

Yes, this is what I'm doing.

> 
> 
> >  	}
> >
> >  	/*
> > @@ -2962,8 +2980,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> >
> > -	next = vma_next(&vmi);
> > -	prev = vma_prev(&vmi);
> >  	if (vm_flags & VM_SPECIAL) {
> >  		if (prev)
> >  			vma_iter_next_range(&vmi);
> > --
> > 2.43.0
> >
> >

