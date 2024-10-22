Return-Path: <linux-kernel+bounces-376958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A839AB816
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8A31F2270A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8711CCB50;
	Tue, 22 Oct 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GQvLaRtV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UBqYQ++L"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851361CC146
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630728; cv=fail; b=Zjho1cVIXVMCyZYLcrqn2db6U2fHKD8tMpL5wVmIJZFD8nGWbEgSoPwRJyYDeCU1JkNq8DXruBSFIxgd32/DYdUS4FKwny6ZUCa7XZIZszyTKFvqG59qYCvS3keEo2XIcVVSIgfOHoVRRqaYjxRmmWRU0FhN1Ey9iCmwjaQUj2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630728; c=relaxed/simple;
	bh=2DitT3YZnLWISAhaBAng9b/TJRxb4lid6evl0/OF6P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bE+4zUBuwsvUKRPFVay7VdeZ0iUUagiAKGYClXDSFr4Py4/VW5cS5WEVBmOki4WEiZRrVFew52qtw0egLyoETyCZ2Lbxr913ABUKThi9X7ArW7l3bthGxqECJXBAl7Na65PIizNMcsla5StT3hxIXiIJSHVjmidsS1T6olN1vqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GQvLaRtV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UBqYQ++L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKqK8S032210;
	Tue, 22 Oct 2024 20:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=htWCVEweYHoXZtPWfH
	gY/tdoPMeptXFYGJgsCEROaiM=; b=GQvLaRtVFi70rhA4bbRYew/Pg4NVvwpLGy
	DxvM+w9BhdILsxXjVJSGnL50W3ynvgv/WKPSyYIS++B4R36sxLKkSzMlK7rDVa3O
	E2C9xx3Fq2AzzNhxasZgbCsETK5z+O505w4sMbgIWabyPPeYcC0T/R/9fOmjI469
	hrfgtvonIzI1AsLSC46Z1cCHsmHC/NvokEQifvXpSzrBl0IgDjv7lVr5cgrEPP7Z
	b8Ppj1RQ6SrsXAJULdWxbFUzHTKrsHm0EBdvz1to5nuYslL4cIjeeah7Xv9Xrapq
	OGRsvg6k0k0d0hOggCiWJPlkEWUxpYQr9fBeT1zZnHBe0XwB4y3A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqx07b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:58:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKJ91T022623;
	Tue, 22 Oct 2024 20:58:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c8ew3n8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRIW620/jGjieXNkFe5NFrC3cAFNm+7c5hLZAJxiRVFqjVsCFp2I2B+baHHxQPseEiJjFxg++qvGuXH0CjTv16M0J7lkmny1jR+YbssHcrWFlt8NR5ywzYJg9z+vxHPYMSmprtiaxYulAg+m1masVDOQszA1rcHwJ0Qp3nbJnTNX9oyJGkkM9oDCcbp5Wta5I+wEdH4QCBQX+lBOK6I3INzPmtFedLOVyHrO9Xh9CHjMWEcujwz1Wy2G8efPho0LztWrtU85qp/OyIqjoT8CoEuI7BWZ2EsawSKnXnJ8/Aog1gU+jb6YUJR9LQfxbTZVb++GHtOQRXf5KAPfvOymmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htWCVEweYHoXZtPWfHgY/tdoPMeptXFYGJgsCEROaiM=;
 b=V1PZe9BJiDfDA2TFNfRiMP13lnIz7S52RklLDPNlJmnnnAGAt8MPi1pmjV72P1QPhG+Z2ZlXTUnf8vjDIbSuzr7b8y9zX7aw1zuNc+ggJumjDwvpg6/P7l81B6J+psthGsruCPU0kikJqKkz6sqYcywaSR85h08r9sZF4I8kXrEafEXgDKQ96cOk33ac3kfnRV02YX5RDPFu95eiAYepxRfmJLR65N8RQKzep+Dh/RfQZFImWPj0YYFs0GvSrv+wCxxpCY0BUKLJpRqn+FsJEZPo1Dgck8i4cY/CdClTUXCooN2UKTA029YndqP8h1xaYf7WligAh7dsWuxNb0pyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htWCVEweYHoXZtPWfHgY/tdoPMeptXFYGJgsCEROaiM=;
 b=UBqYQ++LnBvJFnfZgTztkSHhS/J9vtSMYDbXR3/CCaaT0unnaMgK7ycg0toUxgyS0RJBhYBj0sQLqhhWfJw59wvv97nDnpy8vimT0S7/6Ikw5Euz4ILe6i/PQxqRBBTwStz0pONXvb7wgEuU69RC3DUvbWFKNklv59P3JRwdlXg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 20:58:08 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:58:08 +0000
Date: Tue, 22 Oct 2024 21:58:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 0/8] fix error handling in mmap_region() and
 refactor
Message-ID: <eac33351-4aba-4eea-8485-a4507a748cd3@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4515:EE_
X-MS-Office365-Filtering-Correlation-Id: 41343fa6-ef6e-4753-8c7e-08dcf2dc3b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ICetI/59rwcSJ/8LkwBCldoLjQZWWqB/jrc318MPN/Zaq3NPldJzJKZZiw/R?=
 =?us-ascii?Q?axrdsXNM/Ukx7At/P8H6iwZm5r71/fy+0dKI1J4Wdg4lsCvOfDfCIEGutwGt?=
 =?us-ascii?Q?z8rZNueXclHwwh4xwVoSHuP8a0YRaWMrPxm5Lu4B2rEgGUY0iB4hRry/rUpQ?=
 =?us-ascii?Q?1+PLMn+6g1a/6Rb2JHVhLwc/EWuyJ5qlldfky5XFYpALg82xf/YviDujTwe0?=
 =?us-ascii?Q?9AyNH7+4l2yYqjYZdSDUM+++R72CWhIRnBfnT4uBriNwUMFbYCZgoP9ces81?=
 =?us-ascii?Q?UZPX91gXN7QO/VfrGAk78TEWfbW+k4CUlM5aueaKKlwWfEGSwrBudQ4X5vCJ?=
 =?us-ascii?Q?QiloLMqcyIZ/OUyrPfIkgnPyQeffU4g7g2v430tbal9KpqDPsP+tLpuCL4UB?=
 =?us-ascii?Q?rKAasE1BA0+fbD6Ch5MgVUEp2uVLm6GikFWrFU+QLIcbxtbA4ASM67dEgKfp?=
 =?us-ascii?Q?R1wdn2WwVfj5lqtJdwbJNhjsyI3xFJ7E4q/cKJQ3TOeht9oCy6CKe9meAVCj?=
 =?us-ascii?Q?ktEM6J7ffeDjN1s7YJIiRjSeRvGuKmGvAEQhcRpLWjl8LmaY89Cz5Fk0e6e4?=
 =?us-ascii?Q?1uf9k1KiPPNtYb9N5UZkxgz1FlseK+ODKUg0DN3v8D1KyP8fKJYe8g/RGV5O?=
 =?us-ascii?Q?RZvEn2xtRTPZbIRnzy+6Iioe+ffanMj21k4u72kBoS1oKgfqYFK6zncpmOyj?=
 =?us-ascii?Q?eFyDcBCP9pgBs3bMJLnIlfMWJ8gMGCpEpEiEQ9ldJ9FqQ1uuSbfZ6VFjcpFI?=
 =?us-ascii?Q?JOvQePvK+vfsMPVYbpoo8El9SWjzZa05zzkX3TPwtqi4JnwyRoMvNJFs1Xgy?=
 =?us-ascii?Q?0qnihbZghJQ/HuaqBPVmYcaeJWrI3wKxWTQtAmPhijMlPLhdHIXgmfNHjPYT?=
 =?us-ascii?Q?QOX6SbIgTSlAD2bwi+wIKiddM244ZkXG7PGf2IOLrOTVgZewsCwWwAjHaq9J?=
 =?us-ascii?Q?PfTteDwAA7GfMI3jtD2KeZglwFxastwnEKFgGsaKOn6y0nUBc41RH8wD/eKA?=
 =?us-ascii?Q?a6C0DoHs6pzMiAeyEwKIM0xq9eo3XuJJlrTI/iRk4xyTMIowZ8QHyNeqM1wo?=
 =?us-ascii?Q?AUSe5WMSwqON2QkpOiAYpcStilQj86dPFXSQ9y+mS4HblY/40zkP3LyoviZM?=
 =?us-ascii?Q?Vq/oDjMAcOtxqUm59quMCIywXsMWh3jq6ZkscYGH1Vle3Bdbipi5kI3E6Rod?=
 =?us-ascii?Q?GsdgG7BJDzfRsLxDehLEgr8myrJPBepFjN3j5JUhV2zmYdnMSu+u4Lhkzbdi?=
 =?us-ascii?Q?uSr9AxMLS+SqN30mrOU1ytnbMFexJpUsrIMLgESqvS7tDE2vlc+NQPcqxp2z?=
 =?us-ascii?Q?uN1krDfsKSIFi/ugsoJT8N06?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n2xOJTP+yI3Pj4pNTDerU+2+XfLHJ5GZl42/oESBJwHnHxMrAqv/plckDAi1?=
 =?us-ascii?Q?LVnY9tR48Oh2p48IMirpOy99KhLHE0uGLreOq1iVQ4GTaeXPPM0O/gtnKo9O?=
 =?us-ascii?Q?SLNJTr5zXKLsApKCpL09qI00SDaljH8R+yAQdZsjzRIK5XzJF9H0CIicCp/8?=
 =?us-ascii?Q?C84GQMzff7M7/z3FcExz6h9vlG83kfzCCNejgyaJPJWBU81K508mrVQVKsEG?=
 =?us-ascii?Q?rJhXtZdk8OQ/h86BQZ2sBuARoQHwR3SYUq416FsVEvE5QmdCIsY54RjM1rsn?=
 =?us-ascii?Q?PoScN8dfLLZt13gpf/pmDgSJxxvKBQ3q0m+VuZCHdYFGuteBMg6ToLcAfaTo?=
 =?us-ascii?Q?UPSTzQVuH4Nq7L08/JcpyxSMkY84fUy4E+sM+iB8VVnBTik8brDOeDJhdg54?=
 =?us-ascii?Q?52KytePqTvHSxXNGlaMYVXntT6JWSCfROSSfvc1tL5+Wo+SBJyyWFOWztKlr?=
 =?us-ascii?Q?e/XoMr5Z/ax5Bw/kG0d0jocjzrR/Dp5EwOus2mch2OLeBDaj/7oMxYq0z20R?=
 =?us-ascii?Q?JQ/cGMsYD7jTVxOnwUIdlbn0FUwTSJKVrgjH6zVgR+3iDsD5+VaAmBustbXt?=
 =?us-ascii?Q?EopwA9nGpwZLBN9D57Rr5BTc5sSWJ/kjiQup9Req1qxGCyF6fiEBcXG5eHvN?=
 =?us-ascii?Q?0W7HaYMggtAksIBS1bEZeS/L+WRIlqgeHqlN118guw3zCg1BODStyiWyAhdd?=
 =?us-ascii?Q?ELfhCwmoLklYHPrlHRJOVB4+q4aV5iNfZSKF8FMUjEHTT9wsXPMNRKzvxWye?=
 =?us-ascii?Q?igHK65MyObkivM8yvBtIa9K4lElIbEiv6cdgUsH9nzEuiTJDpA6Ac4hwNkBV?=
 =?us-ascii?Q?arpRRgsK80lDrHHpZHc13h+Nt+xsnDkKUGacCG1wGXBE1wlGPu2WjYHA0p9f?=
 =?us-ascii?Q?JE4lSNRvLckY2yqewF6EZHdhX+okgXoko7X5NctjBuFPIoM2tdvyD48I1Dg3?=
 =?us-ascii?Q?DtIlGitWK2Rt65T0sAOyWzLIK0GBuATY+R2OFWM1hdtZykgjb6UYDE6OpI0j?=
 =?us-ascii?Q?57DdczrzNU7px68qq/AXoEaVT/3jWkW3YfhxowGedFeFil1L8CTqpnJbqj3l?=
 =?us-ascii?Q?xSk56rh6woeTiwuq7a4inTFYi9X0rZMrifDtIMpaDZ5l1JvLgvgO90W0FANO?=
 =?us-ascii?Q?J2oyfiuBcQh0/WCvh319tAbTKFcbeDLl9kZfDqmFm6MqESmzZ0j+CSn0ZgVf?=
 =?us-ascii?Q?wXXgVyE+S7lva0/XBEoRnyv5/E7xILZHMIkuuC7lHX00jFMMy5zI9MsMXaCE?=
 =?us-ascii?Q?vJBpRm0DxKLrlttr6iUtA/6fIxb4ub6j/8OnZB77aucXeyE9CFYewgWssr+A?=
 =?us-ascii?Q?wIq5xJlG6Kqi6MmyB0n7meEMUcvl2PENUNkwbbkWpb6hf2fgYQvA7f1R68PI?=
 =?us-ascii?Q?/A8BkHorl93cZ6U1t75rqjrkM4NpKSTY1NBp4ADJMjsvKGkV9nrQVzrHyGTd?=
 =?us-ascii?Q?jBzDkHBD13rJias7uJb+WrhNmoBOT7fgToNJ6QLHg/cE6zeH+gsFQuZz9mFG?=
 =?us-ascii?Q?MKOiY7hKsMS59j51y6dxl4MP1aKZHvPKGg10J20WbJjJSi72B/6CPiw7kSPO?=
 =?us-ascii?Q?7dwZnP3HbSTb+p5RzZ/s7gkf9K/D482UGC7jPQjI/a457uaRgO+u4uwK+E6S?=
 =?us-ascii?Q?MQT4c+eDy7onZwq72n3u4O9r6aGyF0ucqN0ZxnEJ4bXgavTSa5W8EEM7TqAU?=
 =?us-ascii?Q?6XkNKQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o+uGHQDLAuApbxextKe+bnZ9SKOnixKDW7uPn/2LrFiLmlpQxIO7pv+ypLYUqduk4zkquvsF5XYIzhi/JQBeynUjr5VK3eaqxqM1TCpzAJAS5UJHpuRyHKDAebEA+joCOb39NwTPKjKncTGnnVXvn7c2r4gpNy0JWYcLOu3+T1W+7pfbSYkJXMM5TfKyWAdZGENwkpmFoNzXP1Ebpd2nJQn6sYXxLUauzg4JC0KOdL2PFAqAwsf8mgZSItYdVtWDEQmM+U4o7nQZ5C/6/IiQ10W9lLh71bbAfPJlUxSrsbi4v401zpwoNNZrXnrFwO73WPVOVEY53dL05dIzG6uADrgwm3ypfyd1m80jqz7Gddt7On6hl6x45MpHgIgIz/FnbJyTNnU0qDEnepyrFx4PLpBzyXOmj8E0WDoFMOLzKFCvuQhMUFwm8On/rwf74Gnx5llJlfamISLRHLT1ov+sIIt0fGCz/CbnovC+CO0e6FrkD9HjAc7VO082oUiVOB99dhWRi8maplVDrhXXmVSis1O49i4Y3Nc4Jnv5mF9QvuQRqWGYeK7wGOx+VJFs5fG/I7DX9Ij9gk1nnXIR7DrQp2M4cck0rybFMVssj02JOfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41343fa6-ef6e-4753-8c7e-08dcf2dc3b29
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:58:08.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp5DBSAIGNu9ddXdkiOG2BZ2FUffmN5o9Qz3qunrQQup4dS98Z0pE8ASNnEV6iSc4KFs375Ja405MrkaG8VrBTTCJh7BMsHfQD8mtcM9DbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_23,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=931 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220136
X-Proofpoint-GUID: JH3-qSOTgcD8-Jr98BHMpFSBADowzSzQ
X-Proofpoint-ORIG-GUID: JH3-qSOTgcD8-Jr98BHMpFSBADowzSzQ

On Tue, Oct 22, 2024 at 09:40:51PM +0100, Lorenzo Stoakes wrote:
> The mmap_region() function is somewhat terrifying, with spaghetti-like
> control flow and numerous means by which issues can arise and incomplete
> state, memory leaks and other unpleasantness can occur.
>
> A large amount of the complexity arises from trying to handle errors late
> in the process of mapping a VMA, which forms the basis of recently observed
> issues with resource leaks and observable inconsistent state.
>
> This series goes to great lengths to simplify how mmap_region() works and
> to avoid unwinding errors late on in the process of setting up the VMA for
> the new mapping, and equally avoids such operations occurring while the VMA
> is in an inconsistent state.
>
> The first four patches are intended for backporting to correct the
> possibility of people encountering corrupted state while invoking mmap()
> which is otherwise at risk of happening.
>
> After this we go further, refactoring the code, placing it in mm/vma.c in
> order to make it eventually userland testable, and significantly
> simplifying the logic to avoid this issue arising in future.
>
> Lorenzo Stoakes (8):
>   mm: avoid unsafe VMA hook invocation when error arises on mmap hook
>   mm: unconditionally close VMAs on error
>   mm: refactor map_deny_write_exec()
>   mm: resolve faulty mmap_region() error path behaviour
>   tools: testing: add additional vma_internal.h stubs
>   mm: insolate mmap internal logic to mm/vma.c
>   mm: refactor __mmap_region()
>   mm: do not attempt second merge for file-backed VMAs
>
>  include/linux/mman.h             |  21 +-
>  mm/internal.h                    |  44 ++++
>  mm/mmap.c                        | 262 ++------------------
>  mm/mprotect.c                    |   2 +-
>  mm/nommu.c                       |   7 +-
>  mm/vma.c                         | 403 ++++++++++++++++++++++++++++++-
>  mm/vma.h                         | 101 +-------
>  mm/vma_internal.h                |   5 +
>  tools/testing/vma/vma_internal.h | 106 +++++++-
>  9 files changed, 591 insertions(+), 360 deletions(-)
>
> --
> 2.47.0

To clarify - this applies against Andrew's tree [0] in the
mm-hotfixes-unstable branch in order to be applicable against outstanding
hotfix patches for 6.12.

[0]:https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/

