Return-Path: <linux-kernel+bounces-444496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E56C9F07C9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDF42815A0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F681B2187;
	Fri, 13 Dec 2024 09:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CD5XuMx8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PE4gMWzL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D851B0F01
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081852; cv=fail; b=ilL2yKTsnws5U1YwQEGrZkvCmC1AjYZTcTK0IbTs4zmiaGbxgewj39kRW0pkQ7DLqFXiYRHgah+26D8bco/NUIlgBj0R0Warg8a9LIh1bVtETxhUjH5IMRlqH4hzyCTIOnFRC2CAMdtPYplGa9kKjV4iBfepI/daj0h6F+s//Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081852; c=relaxed/simple;
	bh=ovB6GDAdrLE1TmJQr9IxX9/a3GmJjHtV72fwPQPRlC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vtp73u4I9cEOXbUAXriE48Dt+iF8RDbQYIpdy9KjcHUd5dJCOhyQ64sHottBaVxVVTIqDfDoNpWIobqHHkrsYrJwLZL0R1UWOCXH0N3WynATYbxSM7m0ueiAFlhr+5/+U3OHWNl0GsLZDs5sw9zPmc0rVmVPIyK1oZVzm8WEXW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CD5XuMx8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PE4gMWzL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1flqp024605;
	Fri, 13 Dec 2024 09:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=ovB6GDAdrLE1TmJQr9
	IxX9/a3GmJjHtV72fwPQPRlC8=; b=CD5XuMx8OIQt/YOe14F1efv0Ncd0hRBnkm
	Gn2pek3NkK/LvFb6syMLGfOT3CeXdRpvwKKywcMm4RkI9JVAAoge5tDTIgF2n0kq
	EMj6uL4YCmuwT/hdjse7ISiHSdmecxtocDEjRCwJRmOn9GNfL2WI2HAINQ1Ty9lH
	A1StlOpUIbC5EbB3pCL8NINk7cp4oE/xR+FxBNITuksYiRe6TBer464FNCr6s7TL
	IvznIC3F2nSVzntF5nwXROjwoki83PvtuJiQxbksKAaLYWlDiEHnNYsNBpIEZcoP
	11y/rJ6gcy3Rv9wfQlEe2pw3+hM9YVp37ekK4vSqrccf7z+CY0Dw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5sa5ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 09:24:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD7oF42035082;
	Fri, 13 Dec 2024 09:23:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctksxuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 09:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGC9jA8KR1bhZCxLLfZOQi3KGnOrdVQD218w4KC5Foo91EFEWe3q70kHiLboAF/xXpKM3B0fdAHAHHm+5HT7j+XpkWzBxzMePHkICvFqXtuJrr/jDZyZ+XpNdnanBx9uRcHHpY7v4xK2ewO5kPoUSD3Ev2Lh6J2Hys1e4tofAoNaPYxIUvnsScf1xUQw2pKUJlbg7P3YcKgS205nDhLh0FqX7Jus2hcynIElxR76RviBDsX6ruptcWvDTFpwMtzxQ+2SSA/gVTl1NshidVa5XBbBWXfTkE9LoqvFbWPdwwDTMnqfdFDoO9oeP02nwAtphP1S53ZkGb4TX8Uf6c98Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovB6GDAdrLE1TmJQr9IxX9/a3GmJjHtV72fwPQPRlC8=;
 b=yY4X3PyfyurTdjSO1X+3RjoQqetoI8FkU+Nuw0cWTk26fBMzrveTCxMW4E0/HhZgUMtQbOA4d6feGg6DnIdHV089HEuQrrTnS8i0uvWJpz1Jc9MPm7ipQ2FBGGICufGwaprC84SiFAVuyBiIjuz8nqSINYLLryszxo8JmXW7REWEVkw+JPZrjS60/SSNYzaFirMNzFkdg7f+lFVsjxeMJ3klDveNr7dflTOIVAbJ+M8TQl4DaTRR7FqJXOzqOAJtgPsJUU/RBjfe29hzQZCHWFtaPWoQy7a1+B7UMbZ1od5DG8a3VsRES4ZfFFhM3E0ah0lIqiKMRhYm/WGQC5cr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovB6GDAdrLE1TmJQr9IxX9/a3GmJjHtV72fwPQPRlC8=;
 b=PE4gMWzLdvMexeJhYF2G6kMKt3ZOZYdeHhMTOqAsunH9QLHBf+SvTrd/bC/Tk8oFU52gTrHAXE+U8iaxh9k4+lsnWDy7gFlqOwwOkc+PWi9yv/qJ9tydGclZRqnMYgSSdKCde7Lp2/Gm5PoBzloh5XjPopIPkc1igLCjce2MKCI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB7097.namprd10.prod.outlook.com (2603:10b6:510:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 09:23:57 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 09:23:57 +0000
Date: Fri, 13 Dec 2024 09:23:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
Message-ID: <4da9eeb4-c097-4b36-8c76-207a3d2f2c40@lucifer.local>
References: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
 <CABi2SkXTSi8HKTyE1WoL3qqOTk4KDnF1-RkSOX+ne=cEFJL4qg@mail.gmail.com>
 <a2c43cfe-5c99-481a-b599-fca8b4fe1e38@lucifer.local>
 <CAOUHufYCF0i_aJZPceMXfcTZUcZsCY9fBuMr=25q1bROWx5nsg@mail.gmail.com>
 <cb5eea98-2515-4b06-8f65-515842e1081b@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5eea98-2515-4b06-8f65-515842e1081b@lucifer.local>
X-ClientProxiedBy: LO6P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: aecf64e4-1452-4643-cfaf-08dd1b57df08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xfqYyud9eerfNn/GDO/fRQq1LUs8MVJ+rdpp1t98c4+Y63tz5sKUbzTKGDdm?=
 =?us-ascii?Q?JBQZNJFvmeGhkmH8u9zAzTMsjHneEyceY4ZbksfEdfkNC1gcOi5bqhyhrpRF?=
 =?us-ascii?Q?xNxb1/fZFV+1VhvlPIT5xEWFc8a1dxddAz44Om5KD/c//7Ilxkkj6aA6Vq/H?=
 =?us-ascii?Q?d6nbE751KxJobHQT/i2VHzWwjOW11vk9MylybLFfeWH9cL93y3KKLtZMb4Bz?=
 =?us-ascii?Q?IU54Xqh0KS369TdZNWVXgT6/Q2YhmB4eABue8y8EshUM5padmM+XJeT5gS3W?=
 =?us-ascii?Q?OFQ6JwJX7meAwbgDM/x0nno/zxDITjveGiz5KFD9+qLFiAx6vR0cqOJGz9iH?=
 =?us-ascii?Q?lO+bHmGMQczC8Z1JtlRSbYGOCD6FWbgiugRVqcY4A/4IjyNnpgAdJwJJanP3?=
 =?us-ascii?Q?ZFRSEDrBcNyhp7i7Gc/Cr0nAa+8u2x5l93awBiO3VxSxC0xlrwb/hruvyhGq?=
 =?us-ascii?Q?Q4pGl+BPutAJgjmPExqyaLnyrQmj0sEiyUrjPwDrYhLAxz7AbbiVy6gTiLZk?=
 =?us-ascii?Q?fPY3VHzDRnE6S4hhrP2qTN5n6uv63EdplDEX2m463p9FngE4Mzo4KeXERJ8O?=
 =?us-ascii?Q?MFkGdk+v7dDW/d9Ya7q9GeMs/WY11rIwhNOTFPu65NF7gPnQw0XYVgIk9h0S?=
 =?us-ascii?Q?ZAXIoCbtgV81JoZYTgFfngER+XceIpN07KgHpYjluKFJShsEn1YcDb0u4iay?=
 =?us-ascii?Q?yKMR7ke1Q2pas3b8PJ8RAtEhbQTTZRFIhg+kgwQ2bT985dM2S3L7nEzb4jqm?=
 =?us-ascii?Q?g2XDbKLwOEO2l9AaCLz6UI35s/QyLFRfKqvJzP8A/xNJdI8fKgCGaBLedi54?=
 =?us-ascii?Q?cRsG/tk9Z3jgbWIbepQ+e9vxmoRoGldwNWyc/pOCVuJB0w3EBfeN+v/oNgm4?=
 =?us-ascii?Q?iMvZcO0SBU74A/X3KCiQqeUdp8kOvjPlNpnT/4CXT5s0PQx5r5MKgtJ1FS+i?=
 =?us-ascii?Q?M7NGIWHLdw8Lav/E6zQFB73Q2nicJ36AMrYSiQeXS0eGVjltU9iJhYQ37jkh?=
 =?us-ascii?Q?iEX5VJ/nWTwZTuuuOd/xsf9DdlFk+OkcgkB7cfyQc8Ani0zRvg7l8fojoGoN?=
 =?us-ascii?Q?tcbgsmdWttAuFFcQAf7c+jGcqQEO7IeNKDrR1xrcfXma6FVs50E6HdzIIRaU?=
 =?us-ascii?Q?vvObeudYQSy068hCjkJXTQMtcJwce7pgshidXnc3Zx4teQelWKMbNJG0Ix/J?=
 =?us-ascii?Q?DoEBCn6J7Rs2qY0TMCQ+X0afj+4BNzx4Aw4eRyWQcAIsvXMxz3CxTOzAVMom?=
 =?us-ascii?Q?R7BH2wM9uhVDKw8UIpFX26//9xkOpIgCxkaqrtsJoNBSfm3yEA69q8HR+PRt?=
 =?us-ascii?Q?ystdjGvh88AEFs5mOrnB2uiYLGRMqi573DGS73YCq4GXRA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Og8i9Z/8Q7CaANRU0jywlWHh1rFrXluooeoW/sSahqUR/OqgRua/m5EduEJ?=
 =?us-ascii?Q?eCMqs08954JK0r7b6PyjNamG5uwUIsxGpaeli+UGopEcopNkEuG1TDEjIBaJ?=
 =?us-ascii?Q?bRQ5X/psShjcYDKzQvgrXHOUksFCkEvK9rEiWDfdrTSfs+neSFIKYWgtKKWe?=
 =?us-ascii?Q?ff7sKZfxu39T3U9Veefb0Hbl1d9DhvHUKcnkd4yLDeFeqpBpk8G0XCT+joDA?=
 =?us-ascii?Q?JXyJfNqEIWT69b3BDj5sh6H3MICjlX5pt1jtur2Q+DgsDCJFvCCQ7i0BsJyd?=
 =?us-ascii?Q?6fTVqu/jVxuv6k828hN7+tluiLX+aYH5jk2frKmaB54jo+HKW2t3pbBfFtnD?=
 =?us-ascii?Q?a064B3NkRsS8gHrbCKXkgKp8KFmTny/BCHyoKTcEcVvQjuI6ZjF2WqaP+zm9?=
 =?us-ascii?Q?wTKn0KDJUC0kF1VjQaAJvCLQYW29VYyre4DPCjwoaDe/W3Of+5Z6Lp63zNUS?=
 =?us-ascii?Q?9SQ2JXn+byPbQvy+mQ1NVeJ+6/ODbxjTyj+SHjzPLqxVeNPmNzh8x06atmy0?=
 =?us-ascii?Q?9FG+sq2jZ/vW2zGjjCLFsBzNu2LSz1XtwtBajsTtJ8uBW+XYR4mcTvNte6uL?=
 =?us-ascii?Q?AghbwMtz2g2kYPjp6S75DamZR9gmd3txtUQJfCkCsSUQaxudth6v8I23qCjj?=
 =?us-ascii?Q?nipKicEGOJNaUTtHcnBDzJheMEX4U1iXkv6QEsF4+kObHopvdwaSbYOKdpYS?=
 =?us-ascii?Q?qNlT3pu5iPdlYl8XyLHpdI8J2b5fK387beyM48q7Md9eSsKCpkvo3qMp4m8s?=
 =?us-ascii?Q?aE6q5eb8xcVpIve5k1WyXLZRcG8IfG7agpdtvLeF3wTNshTAtfBqSja30UZk?=
 =?us-ascii?Q?g8MUeuoZqGGuWqJx5JTxTTFozmkE8C8YAxJRUxrGsDmPzGTnpGlk4kxxjH4S?=
 =?us-ascii?Q?4rrKHHJpiXsjvy8nMgAtwhio/9aoThv4L6ykn+NqNCE13ceI+fOUIOFhqSRr?=
 =?us-ascii?Q?6eBYmUKJSSyywE+aywZhudH1KRDzmLYu0vUwvTcfwCylJfiA/oRaSoel46iK?=
 =?us-ascii?Q?G7wpZT4lDU7XWuMRulx0rCJYMCgjkCmzdx5drJo+UO+Amc/k1ehFY+CzJ2zA?=
 =?us-ascii?Q?PndXoCryJgvkQ9dluzwRR3nMJEAKo3von+pYMjlEI8v4RDsGLT/J3/4rKt/0?=
 =?us-ascii?Q?vsumpLS8p8UFzJcfyJFQQw5Lrwy9AfJICODFiIfgSnxLZC4V/wWiuEd7yaHJ?=
 =?us-ascii?Q?P+/qOF1hSQJMB0mH2BRRaEKG8Nryr0qOoHZulzKsofnvoL2ZqjMqEjTWyNCr?=
 =?us-ascii?Q?gn5sMyQV237KxDgLPOTlkagiF9n/0K5d3Y9KAvzJNjrHums/kKDjBd4fqQpk?=
 =?us-ascii?Q?sQ2ncSyQDJL6btN4RWZc2sbl7SAKqW7ViC4yqbXl6XM43Qijp+7mslvEfGND?=
 =?us-ascii?Q?0E5AK7fqVF5eE4jw+xa6LGk7BJYGxIZ3XNt47WPCYsG1waSi7inplmgUgWFY?=
 =?us-ascii?Q?OR7fk+8V9JQJW9Bq51w2VkS5UaO2KuHMlz9YyQeAkhxxsa+yJDUytahJZQjx?=
 =?us-ascii?Q?l8luTE6MhG/Bu1BfnMnfzHYh2OLpJJQTNui9Im32q0c3kf4MUhES4GUGnjYH?=
 =?us-ascii?Q?IbaKLZlgwsXJr1jPXsDteOAGau0dqfBCuuVq3z2dPlkqZsX0d1p+yw7DsGP3?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YEJnJ8nD46IetwMAnaj5XZRUJiQHotbWrtIFC6qjLQrfCnjARAdIgGC77nLUB0V/vAEkC61ExnxFkqCGzKfq350/gAT/mVbmoiT/KF3ykm5NdJHiwCPOuioVEZW4+L+C+Uiw9owq6HMTbsnxClTub5J4Dblhs9hh4T6tEf9GCe6NL0I5uDOpfu2nxnb0xMsBegVzdN7+ycq6o7t2vm035sWZA/BpEoeEKxbc/jY/m154SWmbL76mEYy2ipfs9ObbEQ3Vph+FU0H75jqxKZsm3zJQ07fR7zvF8h8+s7U/ViDgd8t5MO1J++9MS9q7rdmcgnrdtUej4NiWsMdUeVh2YwXVT2MboSW2ip/x5W+6NN6sH030/LOfm11z9/PIJtOUoJtptv5MpIlnb7B+fsvX2hq638vCxPrtExuKgLv3y7kUVgMOZfdOPicJf0jRv7hFFIcVLSmGSeo/GGrzc97/CmMIa2wE3B8lIF3ChqJ2DCZ8zoVhG5H0XNSDuMuBYQFTYdleLVC5n5lQ9P00oxwh1d715yyL0Ol6WDkDo5CT3WksE28iCZJICfHhqCHPH4YaNyGTvjenjs41VqXi/W+8uuoNgz2CsuGWDrUVvd4baFk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecf64e4-1452-4643-cfaf-08dd1b57df08
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 09:23:57.5489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aGy3K1mYBSctX4O5mQ23MnkAim4n37n7upSqvHf9+71s0G+spVk7C4e2QI02ZuLaDamQjXDHbJVIuO2h5L7Y95eNmMaYm6AjE1p3TO35nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_03,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=815 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130064
X-Proofpoint-ORIG-GUID: Ud3VJDRuW-JYbiiBOzdTTMfXR106HPk0
X-Proofpoint-GUID: Ud3VJDRuW-JYbiiBOzdTTMfXR106HPk0

On Fri, Dec 13, 2024 at 09:17:57AM +0000, Lorenzo Stoakes wrote:
> However as Vlastimil points out - we can't separate out mseal.c here, not
> reasonably. And it is so clearly strictly an mmap/vma bit of logic that it
> really ought to be included here to ensure that we who maintain the overall
> vma work can ensure everything works together - it doesn't make sense to.

^ it doesn't make sense _NOT_ to :P a silly typo because I've not had coffee yet...

