Return-Path: <linux-kernel+bounces-557829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE490A5DE51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD2847A4ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBC7242904;
	Wed, 12 Mar 2025 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W7Wjrnbp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="te7hiM3h"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE111CF8B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787233; cv=fail; b=IumwGlUZ9u3SBplMtDl+JHDfxWH/iF56EijdmjOJUQ/1DuaG4YnxrOTUyb/5WQ51xngdPFQz8SlUCssunz1HhLjbQvDfoJJDQufyE50ynE0ZFpq5/IzaDbn30aFyPAnJTD0EkICEgddd/R3EPG9vCZr4F976Ns/Ll5DVtSFkA8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787233; c=relaxed/simple;
	bh=+E160CizXePb0nu6dK8zenBsXgBcBKrNKB1xPNOvK7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PjnDKkzGacHfd08hILiUtGquhRlIfUURBtKWpZkhSFlLHmRzHTl5plEwbWvVrC+1WhqDW9+ITCQJM27+MYXoDIPxZYojfyLnrjDCw5vrRcg4EclLw3Oa1NhCkPxYtOUBBeyz4ermrN8hFkotFTH65xiK5RyOS2kRuHGBs0/komU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W7Wjrnbp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=te7hiM3h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CC1h3n016943;
	Wed, 12 Mar 2025 13:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=j2bX2COgrEzGS9kZVy
	GPQw1aIH3Gf2ZwDfIX15zsfmw=; b=W7Wjrnbpx/tM5aURShQ3FeoYWfBTOTIpQ8
	+BA4ADbYI7/mWYXn3SQYeDd99U7//3/DWuGs9bZD9LWKF/vTgDoS0h4/LozR9QgC
	XztpdZSYAQpYZNsci11KqjpAvMAtEaK5wFNKrW7E9r3EV3SSdjzUnNbmLOLVJLjH
	xxmvwik3NPNhw/Vt5Bh7pUyIc/etU++JwJgMZ/WbueRroltLjh4j/EyMFuY1aHpS
	3IZoSS5YmWobHYbtWs6REYyQeySFTXFdmuhLGytB1KG1Xdw0GqLx8/BZb+6joYJZ
	yRN56sI5HdMe6a2tyKMM6ugDggpaL+d7kWyZiR8ZpdtcpjaNO8iw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h9t4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 13:46:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CDChbM003830;
	Wed, 12 Mar 2025 13:46:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn0sd0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 13:46:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgmx7k40t2raP02BfR3mF4CPWeY5Y1GJuj/lC04QUMW1gOe//qU1xT6E4Te3xzJbWmHiHLF3ck3nZyEPtKnmf3IKDXJW0BsSt2fGiUCAjl2F3KqrFbyHPAIQPs4YMk4L8gg8bePx9CxuEmA5lUPNViV0tCzYkwPvjOWmphFDybXqwUsOpEzML3kfzLF0JEuMYbmkkCvDcGDgzZIw7qZzYAoGflcGWg+Aw1iArJ5fAgteZsybolMzDqqdskM4rWrC7XeN9ttDDnFnkUFDc8Jh2jDdDthGOpPmkrILX21o3adEd7fBAxSV+FnoFfuBtzUpTtNpshRVdC2yiKLAghgk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2bX2COgrEzGS9kZVyGPQw1aIH3Gf2ZwDfIX15zsfmw=;
 b=VG7VOhKNgprSrI7ePQx62sHr9GxOUSQi4cO6DFPAPBZVsUBvnTq4ja4PDkRQiQ7i+izLWzBSFrRm2Zv8/iWi5KeKjWv9RI1W0Dgfi5wxNqQp46A0Ys6QjWFE6f4XOVncJyYcLPjDZ8JotREhthuti9Or1njz+lzWg6jHYdbtWLlsavl11bEiwg/ps9RLo0Ehlhw1dqqCa3BYuvYs13F6Lwn8xuDeirBfUsBn31T3zQ1rqPBcMcSgoNtjUWt4xMFbSGwK4BQmut7Tqs1YDtCxlGzwc/vD7g1/SNanz8ezDUtJTQJH4igg3IYUky2DqumrLOaPosbEaYgzWm1MQJpQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2bX2COgrEzGS9kZVyGPQw1aIH3Gf2ZwDfIX15zsfmw=;
 b=te7hiM3htdnPk9A42Acb8NxHxJRkAMjuGl7fCjkmkJQTd0+/Xo2XGnFK/MaaJP8pdLRR9wrDDa9GvT7dUXTiohKSM2EMJPPp726EV85iMk+aZTgae7QVuGOPLqtd1OS2YQbnyZVaRBbra0Os0Ttzjl1yv8o487GwVIOTKXN7ERE=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MN6PR10MB7519.namprd10.prod.outlook.com (2603:10b6:208:471::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 13:46:40 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 12 Mar 2025
 13:46:40 +0000
Date: Wed, 12 Mar 2025 13:46:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 9/9] mm/madvise: remove !tlb support from
 madvise_{dontneed,free}_single_vma()
Message-ID: <9891d4a4-954f-42f2-b60e-d42796627c7e@lucifer.local>
References: <246b547e-d7ad-44c7-9652-6f5a72828b26@lucifer.local>
 <20250311210211.85566-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311210211.85566-1-sj@kernel.org>
X-ClientProxiedBy: LO4P123CA0227.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MN6PR10MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df65409-049e-40d2-ec4d-08dd616c510d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9D69GrSSc23U40ZflDR1RcmqIVbxzKdlxJA894jexZwIJ1G5h/6K8JJAjg4N?=
 =?us-ascii?Q?m9zB2oTpgWOu6CqsX2lE5rQ+NxVYJ7U7nrkbD6OKj4JThz8QzN2xIDqBd4ia?=
 =?us-ascii?Q?ofbMcl8k0xGx5SPttsw0Zlcec0SOjCffc20XlxmVNZkAbX/yYfZKbuT+sCm1?=
 =?us-ascii?Q?+Jp/W1ZIDcsAr5JGsNo7q2GTFZ4crCZs9fWqc632o+4SEN5LdKXJNXcS9uyY?=
 =?us-ascii?Q?2eBLLde9PnRNo1oBkFaZ4UQBXsgdS3YxNN/nBzQnd4DJUrKkGpz8mI0OaOGy?=
 =?us-ascii?Q?h1bYHZhURW1sbo/UfpKxmrKvUJJTfg85ClLl9Gs6/ARScoJpx/K0KV5/jquz?=
 =?us-ascii?Q?zwd729oBTt6mJ2NL2w0RrilDWkjSkhj1AcL1roQfaeGthdsTicAso39+ZBtG?=
 =?us-ascii?Q?WTV+RDqNHgOjM+MAOLP3XtommscIViv4goHtTGu/JCTueZ5oFhLsnSplYllT?=
 =?us-ascii?Q?jaj5PGPOmET9H1PwTfk58yxWUKV13FBjE/o4vdZyG4i1qsbMRUCOl04IYORY?=
 =?us-ascii?Q?QfbCL3VVWIjeU00zF0XaJId7898NcYp0bY04x/dLMWye6G2TYJ3KKUnWEuaI?=
 =?us-ascii?Q?nDGmu9Z2vFrSredqDyBmObWTdisIGZiXF4zzqL/OURT5QJXdS6jtDR28+kkm?=
 =?us-ascii?Q?I0YO2dEgNd+kWOAIOi6hEcVJbTN3sDO0xjR3g83+P2GWVAV5EEGCEzI1LAhy?=
 =?us-ascii?Q?7w2dPWrqBY2uOBey9nd+atNVHieko16TbyCY8YxPigNcUjuaFK10Xc1k0k9m?=
 =?us-ascii?Q?/ZuIvy1Jjzsm1ECWMNPr7aysFabJ9XFnEP+ShzchMcIAVquJQIIXTc+Xzy5K?=
 =?us-ascii?Q?5BpIvFvhvEwkth7v+7XNjd6lKucNkIbFlQp/kbuazagoRvN44J89wCKGZHTg?=
 =?us-ascii?Q?lunE6uhW9W9Oz7mkJQtq7XmBRfegJoDH642xnq6IBoVRdnoyqShRPOxAfDGS?=
 =?us-ascii?Q?nZvEmLJRNKaso3F7RKh6l2PbDq+eKx85JZgTjgWeKreYKVNPeek8Nn0Bxgs3?=
 =?us-ascii?Q?cmZkuHVJv9s1VJg3YZB++hOcSu+dIuywlz1e986Ho225Ct9F000932gAcvRa?=
 =?us-ascii?Q?4CBQXZdWn1BgpiG0tZ2sp2qnGwExyixcwuZ02XbtF8i4QuOwFILSSq/uj3l5?=
 =?us-ascii?Q?GzmP8rRlVtE+Ao+0qhjbKfF+vQE5G4+Rk/T78km1CwJvV3i5Pb3jqaVe3SRv?=
 =?us-ascii?Q?BGZbU1n8UMjHs3FUrGByKzx5e+TYJxkiWiPdjRxIWwO3PhJtFB52xjvmSn/t?=
 =?us-ascii?Q?LWfsoh4n1d5lZVGFG5njTTDz2puyZuOLyofofxUHsGdNyZNwlUD61aqkfmt8?=
 =?us-ascii?Q?Q/Ju8VXLnEhQOP6/NIhWsUju5O1fglaXDUJJp4mJV4kokAuSDXR7eyK4ox2o?=
 =?us-ascii?Q?5/gefxA1Nzk2HtwpjeFaDObgWr4A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mt8LBvzMmykcy9dMr84VVem/+uTRNGflW/qF4RsepaUKliROEibSl5Cgm2BC?=
 =?us-ascii?Q?GIKyjh4vGkPeLR6OigPMAgjeJY7H+9SOmdHWjnz+GmvOwJaudKb+XOwfcUC0?=
 =?us-ascii?Q?2T0GtgGV/Hh7bEDZybZ6u7Aer186x8dpIMg+xuiLvhk7vpM+rjs57ldEUmOm?=
 =?us-ascii?Q?yPO3ogACKrN1S+uHGtlcQwbi23LiTsv+4UEw1sBipWktY+3Kc1YtQaYXislo?=
 =?us-ascii?Q?jgQvULQBWOxZCoZnKAwX4BNkzS1NQLZHtzt95AVyZxxjX4KgQ8++cKd/34tP?=
 =?us-ascii?Q?UCaq+KmA/hlyI2OosleH/1pY6hD9JhuzovRtzCNmiR+nfE2E0kaZGnttmbI4?=
 =?us-ascii?Q?G/kf/JjtatzZRWIcGKPLT2JZ+oSIvH16OvHLzttlPoarDpmooQh7UPNE61h7?=
 =?us-ascii?Q?GybqTiZ0qJW85v8byyQS6DAukobMtYDbY2Rgh18XvOmJB4f3Wy6aG9Ia58LC?=
 =?us-ascii?Q?h+9Tco0Z7pyWWGufywNjb/T9ujrrZitBIDYtyxRJNQFeQ0IGx2N1BqbN+Wll?=
 =?us-ascii?Q?iaAntWGRpi4QynlSsTrgGLo8snvV9EsWct0o9nGXfdkYXQ6apZTk+ldWTc0b?=
 =?us-ascii?Q?aHdt+bu7OYvHXwliRDVEV85R1MAVyKaImJmM0kwSXAtXcnXlOTH/fa+9jIzr?=
 =?us-ascii?Q?YF1LBOYpe60Ho0vxWOqc1ulPAO1tQjuoEhilYifsr5RldbTc+nXQRxv2rAVZ?=
 =?us-ascii?Q?k+67tdqOa0ak0Tw4xJoP2kmpEmN7yTjPBTtmUSkUSgPql18QAyt9RWWBRhhC?=
 =?us-ascii?Q?OSzHofX3pmSEesSfknBWgjvuvb/loFSzAH3O3y07BFyDeHmnliI3mHUDPArI?=
 =?us-ascii?Q?Dx66+0owaItEQiZg5kvwJBYaenO1M29CYbRXHuva98alrMAXLoZW+B6xMmq7?=
 =?us-ascii?Q?NHkvPlAvYgQ0utGx6hd2lojwSxD9Mt7b0SoL1nITMZaToDNWfqiw61RVx9vk?=
 =?us-ascii?Q?yg7IXlmCCzWog4Dxzpi3ldNUKGeWnkelqS5uJOkWwk9HZpdyhjJIrhbmBtRW?=
 =?us-ascii?Q?V3BmjBkUOTo4mORzsZGtaNJqxJw4O4kafprxeRjXG/VGxvrSPlFzJiXgBjr8?=
 =?us-ascii?Q?qsX7YCxVF64abSssvHgILF54oLxbkLSKHCo1elJh9TnLlfPUqRPuGZI0VC0n?=
 =?us-ascii?Q?wrkbhkzqwcOb5+cQPbojKKAteKC8gBIrQuL9uoFjDtH5GuvmLbffGyjhqYR6?=
 =?us-ascii?Q?BFQr15E9fPyLw/bdXpZZIwRJS83sfy/ywkEVx2KHUfXFLK6ulZFsVcV6W5au?=
 =?us-ascii?Q?LcuRgS0m+hggzI5BNutxJV2UP8QR9srykTi1+w3UiFgCwivclb+VY0AZJ4nY?=
 =?us-ascii?Q?iEZnc37WyHk1WG5E4PDEb6jbNPDnEhYl0sb/noZ8o42ctf4QF57HR9wJdSQ/?=
 =?us-ascii?Q?l76iWBjXCFIPllf0e8VFjej0JU9gGr/aCdARD+2iDVrDB+dvBA1o9AHO1vvz?=
 =?us-ascii?Q?bPVH3McZoAK0lA6MdSrIJZJbbVagDAETQ+43SQl68okjQvta8vRmRac5Lq2A?=
 =?us-ascii?Q?AkLtevzWhVdUS20p2laFmfamzHQI5SG3KISAsaQjPmTGLJfFy7ekP54RoILL?=
 =?us-ascii?Q?vpuffDI5zPl8NFhxP3h4XrZzub6YkMU9KmAmx9hGo/GYwqLR+viNR8Wia9Zz?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k5PVK6RvB1PIkIPRlM2T/zHv0vFuLJDYyqY2aqWG9lupTfTdAfrfJ0gEPb4sfyDXEJ7TpvfBHYNSN0Uc4CWgWMN5XRih3w8QE4SXTeIfobFfuVqG9//lAOI2+d702VBlwmSxuQ99W5U2A2gnON3FJTdbiFTJhUBg8n1KeYANrKcLXLlflzElLDiHfRDPqxefqAiASDAIiZEyJjM5J+eH9gzHOM8yotaqTj63qSWq6xEt3BuvdEfG/zKYh1JinstRMyth8ZR17zsetT9MqJIliWTgKiLr6ZFWo6TOO+ipUctBtMUhWY05AJ17W/jdXegHqcsKtt/Z93Wia1RcNX+EtYsLSw0lkbGybxWYbUPI+n2pgh7fSRMDDLhG9rNCz92Nr6DWZXdBt4n+f5mz5e3LYfMQs5qjSzNlDBe+4Y32wfAjk/JeHfVqcfucXlgi/zi0O9vtn9AvwxHaFmy4f8SKwiA5Ni8JP2Pi8gRM/asSNSeKmdiUWZVVlWu+vsHb3f+rbB03/4EncU8c0gfOdWmT/K+TIq96vNOdfGS1+6GbtkGS8wLFTA/Ke/P0fUjSUyLHWH31cgg3K9LPZ8enKjnxOouowCkcnXaQjUJfT7sfo3Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df65409-049e-40d2-ec4d-08dd616c510d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 13:46:40.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVVP7wSfmgOLAyzZPa8Z51Tvmf0C2msa1x1gOWspNp3LXmYvmO56/35pNEIiHt2w5gnEXxG4Xq5vQ0FLTt/NAILA88DmZWCrrB9cv3kPaCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120096
X-Proofpoint-GUID: 76fZF95YruFkePYTPF97mJflzEWCjLJq
X-Proofpoint-ORIG-GUID: 76fZF95YruFkePYTPF97mJflzEWCjLJq

On Tue, Mar 11, 2025 at 02:02:11PM -0700, SeongJae Park wrote:
> On Tue, 11 Mar 2025 14:01:20 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > On Mon, Mar 10, 2025 at 10:23:18AM -0700, SeongJae Park wrote:
> > > madvise_dontneed_single_vma() and madvise_free_single_vma() support both
> > > batched tlb flushes and unbatched tlb flushes use cases depending on
> > > received tlb parameter's value.  The supports were for safe and fine
> > > transition of the usages from the unbatched flushes to the batched ones.
> > > Now the transition is done, and therefore there is no real unbatched tlb
> > > flushes use case.  Remove the code for supporting the no more being used
> > > cases.
> > >
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> >
> > Obviously I support this based on previous preview :) but I wonder if we
> > can avoid this horrid caller_tlb pattern in the first instance.
>
> I will try, though I have no good idea for that for now.
>
> Maybe we could simply squash patches 7-9.  I'm bit concerned if it makes
> changes unnecessariy mixed and not small, but I have no strong opinion about
> it.  Please feel free to let me know if you want that.

Yeah, though maybe try to make things as incremental as possible within
that?

>
> >
> > FWIW:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Appreciate your reviews!

No problem! Feel free to propagate to respin (assuming no major changes :)
thanks for writing good clean code!

>
>
> Thanks,
> SJ
>
> [...]

