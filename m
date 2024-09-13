Return-Path: <linux-kernel+bounces-328379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BFE9782A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884031F250B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21215E90;
	Fri, 13 Sep 2024 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vu/r4+mb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UfIQJH/p"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB325228
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238176; cv=fail; b=u3/iLb4rv7iADpCZQfzfnZ2l+X7F3QhzbFQc/tmvUmYbzwo2U3RkM8TKb0+GXlf9mXe4nFXKmn/64yF0Vb6tKTaGOgtzcHzpJss3d1dzXNZsLopbWeI+moMSDOLK9J5e5oboNG+J3QNw+SgVmHpv2G0o54zBvnA0m6YkDQUgDfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238176; c=relaxed/simple;
	bh=5pCWrjvAURN01V1PP3zSbQJrH4MTnBdr6kG+kNd/2DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CXn+rlZlcSFJAoxx6TsFUXq4iITujrS/2ZwcUaf1egJ5wJHAHaX5gPEx0Dz57IfgIkVq5y06npzJV4LGTy1MiwMdnRGvStLDauo3nUQ1MHMglZiITlQOWd8k6auLg2yyI1PUWi2pdKbjXo9mQnxrAwt0f3pyuIB9JpBKHeVNv3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vu/r4+mb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UfIQJH/p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D9YJ70010939;
	Fri, 13 Sep 2024 14:36:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=k90xw8sRquMQXpu
	gw9N7NYgOmIxxwZGh+w8vgik6Mc4=; b=Vu/r4+mbmSKtEXqhPe/FVJQbaqU0Xhm
	VqeTMAXyc82b3+nI3LwvqKJ0h98tTMRWgSV9epW5Hc1NOs7OWhaYqEua1QFPmymf
	qi/sDsLQBKzTF1XzDjzsMoq3WMFQk3A26YrO9ydDgi7KMdiL0Y0LGXi71OfKVJUl
	wbKzR/sZK6RH8msenWkIbB8D/z0NGNeulsC3XW5xgxCRzgMhLyzQ5qlM9BMWf9nM
	Fs48EkH0gXQR5Rtx1biYNDcj8DAjdU3nc0LkjHZnC0FV4MZlYEDaIU44LQBXzijZ
	iiB/JHOmSUfDpvmEqRG/M5elOQeetE1OVFTq+H/ZGCIq4EY/ie9r3zQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2wtq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 14:36:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DDmB3u032415;
	Fri, 13 Sep 2024 14:36:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9k2cju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 14:36:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vRlBfM0mvJ3+Onw5bNZgHDpF8aIy1Wsc23tEfb4Zaiu+VlOl5A9vQ1A9bSCiIcPFk6CzgWzCzYjdTmDdzQY+6+emf5MuPBpRL5bSm+ms0Vks/Iq3L7bPqVgWPCTlBgWARrK8s69iAcbSF5E/iAcmNexMkn/up4AuH1EG5RWz/opQj7yZd6OSdqclS7osPRxaFuqAs29rAPaSCwAuhBQTOPtCdLXgpY/SedqOb5rnM2F+vskn46XpjRiedQViZOc4uod3+CmsykiepK1wguBkU66rugZr3EB2uRZT/iMXQeG8GvduOw3Zvt7Cuv3tIXGEskw8c51OV/RvR2wlXKNIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k90xw8sRquMQXpugw9N7NYgOmIxxwZGh+w8vgik6Mc4=;
 b=H3ylwc72ajlgyMVqS5yHTdqSZdhovsaEeLR3Hj6RL0E6677HisZaANueXWLVanujXFY1WwUdFG0Ca+jtB1Ixb4OEfIiA7wrYNugS4idZar2ogWYyhcten77Tcaz1cjh5upZG6Ijt39JHv612fl/MLFvT+Lkfx4aspFj7WIeo9fXQ34cKjlO0hJ7DBdhf1FVaX8j8U93xdH2bUwMUu2SJnM/PY3iyvygLekI8YFw5lijE8SyjtF/sJp1UhKp3i0lZrYd7TGWEEpd4HoqkNmAreJrVa1tLyZIPlvuevqnPEA2vqBddc1jpuzXsxYc8sSg8dw4aSm7qWjpYIZp5QGAJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k90xw8sRquMQXpugw9N7NYgOmIxxwZGh+w8vgik6Mc4=;
 b=UfIQJH/p1W8+AjVR+FLzmuvzXbjnCCFUKizocfdjUW+Gyi9RIyf78R+zE1ew7M7/iyYJSCCgJBpjGJl7of0Y3iIlMJuQUEZUWccWajPP4zX2CT6J3KgIPF3De16EioGA1Q3BBIo88KjANBnwQzGx3qMiSWMEdA41vZyVMy6hUow=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN2PR10MB4239.namprd10.prod.outlook.com (2603:10b6:208:1d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 14:36:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.024; Fri, 13 Sep 2024
 14:36:00 +0000
Date: Fri, 13 Sep 2024 10:35:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/madvise: process_madvise() drop capability check if
 same mm
Message-ID: <x4lutkd66z46qeymya5r5k4y6luggvsx3phoyt2gohzq6txe4f@cut73peawi2d>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>
References: <20240913140628.77047-1-lorenzo.stoakes@oracle.com>
 <k4euomzfssryq7r3tglsvk372d4vj3nd52ge6hjmgoozvjubww@jvqup75daqsv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k4euomzfssryq7r3tglsvk372d4vj3nd52ge6hjmgoozvjubww@jvqup75daqsv>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN2PR10MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 622b706c-559b-473e-987e-08dcd4016346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDriL+FEIFBCmLylDtEYVKPIQmXZJK29v+OtNaT7EKYvh0kXfrmIWkwjImS4?=
 =?us-ascii?Q?O4+WU2UoINFNn7I4V017z4CTqodPN3s387gZiQclGrfCy8BIQFSX3cYjc8X4?=
 =?us-ascii?Q?8b7KrnHJ/xyrU1X1L+Tn5oq5wYzNC80yAynrUofT8nLYYorF5/SPxiJb9dhv?=
 =?us-ascii?Q?XDYp3kvVqYy0t21+0JqcrIH8aPKCmcMhQR0G1ulonuebHAxlYBGrUMXd6W2Q?=
 =?us-ascii?Q?sK0ESIuuxOSlt7LosErGFHOXrVjDpgwBcb/dcKiwISYX4ZFpk775TN/guZhJ?=
 =?us-ascii?Q?+G+tupfHNQIO3tWL2A2C1Xt9IEFLQtpzN2Yk3tqRR+28XSk3XQBcqqY1gIKb?=
 =?us-ascii?Q?gNG5ldy2K5BL86+gJBlPLHNKWQ6C57tiiaxORAwW+obv3V29XXprkSYTHsaU?=
 =?us-ascii?Q?dLN4oWhh0u2nXkfJI+wfyl1hV5XRFj0DUd6xRbGCn4ffzedYf7V4gFSUsKOZ?=
 =?us-ascii?Q?5cNj8yCmDmXcc6LMkBhJJb22RrzoTezDkagbEEsMjU5XA+Ri9OqP7wknZT0S?=
 =?us-ascii?Q?y9HfD5qP4L1ZxA2YUvjLJvHjZi7ALd0hpIChBvY35MiKW8zjdd0ZnUeu/Rwc?=
 =?us-ascii?Q?9l6YZ7AbUIuhIgxOUKTMaKPLwr8yGScIzM1ypM/OCJPHjqJfVCnQT1KsB6ZO?=
 =?us-ascii?Q?af+HbVMgkc07/mJd5j0t8IVzMDK0F9GgDgdWYa5EPs2LOEMf5jsj978QlbV6?=
 =?us-ascii?Q?Y8jhk+liWbvaiAo0Q/lck9pU0b0QMyWCU6aT+K4qyNdsZDAJh/dhIiz58Cs1?=
 =?us-ascii?Q?ttU9wLezVXGkm0JdBqXvNy+14VSfQgnN2T2rmXRx5038fI+TsxlAMxnS3MYu?=
 =?us-ascii?Q?dLus+xSTqSdWkIRHQsE1YDJ1omYv3G223veP+4jqFVWzuT4NVJEp9tjmfUhu?=
 =?us-ascii?Q?fxOQ9UusiyzwAn/jJ0OHkUr5UxLPcL6VTXVQszsXcOnqjpHf39BPr1Lm5Dx+?=
 =?us-ascii?Q?Urdbxk+yyWwo7zAxYZM4RZr1nvWpKdar0TJXa1s2XK8zhKerVPPER3qirUia?=
 =?us-ascii?Q?E/HeOL45DpIHGztA78jP5fI9BShqcx59NFKWbc9rHkYDmThEjd3i+sCtO/5Y?=
 =?us-ascii?Q?xWaaVmduDaKNWz2p+LtzcNhHNRfeO2NvJCDn+ZG3YlFCHq/QLLHTNJgmrCJP?=
 =?us-ascii?Q?MJk2i3Sx+QW27gHkQsm0ybbPsc6Zy2HTNd+QIv+Wkwrn68pE06rWwnOeKXxJ?=
 =?us-ascii?Q?sS0z1XHYZ6mJkKqWha4R4ugLl8ULjkvgM6kIsVr8vwRtJupOvpKlD5Wq872I?=
 =?us-ascii?Q?4OgJL0OrqAqfsrCsM4JeRqulnNNM0WSa+0aLHo/hv4asVMdjKjXw04afda/s?=
 =?us-ascii?Q?o+Jxubeg3HRtmCTe+WDOjGRqgbyIHX0zptOp0h9j3z19Dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g+WRaGkyuEKfVQ/CWKzwr1FmJJFVWp1GP1uMp/C/ATguLZpp8Juo4f+nHVBL?=
 =?us-ascii?Q?fE4VkZOtvbYIpcNjUn3OjkUWRb5lvpvcX2bX3obZlmBSTNieKgyzmsyNlJSd?=
 =?us-ascii?Q?LIVJCr3lDgPK8pDdFTF1BLFa/zoEdeTSCjO13RreY6tbNONvnslXjH+NYHjW?=
 =?us-ascii?Q?I2+eV3bmeDAbim26pgLCxtNIC/0osm61xKLwhMx7rVyDGQft3pyhitdXI8OF?=
 =?us-ascii?Q?fsWYMpfzSApq7pkbnIKkRHJjLQD+LuZdOx1kNYpmThrwPzWN03g2hMfAKspx?=
 =?us-ascii?Q?/sIcIDIo64PhmHo0lsO5XfDQl3+BOCfYcR0HcbIfe309EFSqvYdwQ4DO9pTo?=
 =?us-ascii?Q?DRugOax9CxW5nhhfUapgC5CNvJSefNnUJuwXUJgx3hviL3RAg0Ws0qgxJTwq?=
 =?us-ascii?Q?+j2+765YNO5CgXMWEC6upIPfzko5B122lvK4IRptXj/hn0WDdix1q65J5tB8?=
 =?us-ascii?Q?Sl3Uv2vd/lc9xP9bYaZlfZz3NQzyxBrOGi0sGefBiKLyN+Z5gOSapl3pmjtC?=
 =?us-ascii?Q?6sjHMtg34Fi9mLRhLEzmzWZCDBQO92xOVMVrfhbPz+UkRwJFEIJrwZgCjRYY?=
 =?us-ascii?Q?JsbjUBypk3Sty0NaiX9ADo/P7c3q2OuZzze0hp6FmjU67kxD52+2Ss6Vk19c?=
 =?us-ascii?Q?vNsdrR5EH+S0tCzb0W6Mzz794eH+odiG9gqbOErQFFDy493FEOGeCD7onR8K?=
 =?us-ascii?Q?AK0Im5Jnk4PIncsBANzWMC49L6AynaFEpiWRHf2R7zs82R/gUYpUt+ROZj6Y?=
 =?us-ascii?Q?7Vz2WrbqJzuYvYzR7+Z+RBMqp+GkEINlXz62DTFI3v5JSgrLJVTudfU2KPAX?=
 =?us-ascii?Q?9EBvfygeSUAUMFAJRNA6xJhRWeOGFUI9yugP4RxVF5dqYzBhKOG22jwU4dpm?=
 =?us-ascii?Q?NK70CqkXBQevqc8TKg/YMyimzyc/pQyaIEY+fgKSUr0zokJa+4dX0XKPwCuG?=
 =?us-ascii?Q?KD2v+HvsCc5c8TYkhk4xLwoFFQnvyYKd1BgAP5E1dHqCF6zGox0gQugHOC8P?=
 =?us-ascii?Q?2DCPBWARjUSRaZ3N1t4Onc1QYQFy6pMBVCAmL43icOxjaupAybDWocV73pU+?=
 =?us-ascii?Q?s3onaUWFrYFn2hfV+FnElvB895wyv4sTy4INJzuMkJpA/7qd20D9GesdEtTi?=
 =?us-ascii?Q?5NWjDnWBN3LfhPytFr558Be1godxgXW1LnGXQWjmoBjeOaA5mHaSyPSNeXLc?=
 =?us-ascii?Q?VMW0GJW3UEig6zhCaSz0N7PMDPcuslQRUrEKaWxFwrDO1bhssTjD4F//pKbZ?=
 =?us-ascii?Q?7RkdLKkJe+0jsh7zUu/KTnvKJkjENetntDSCol5+SRHdxRsvrBTf76HWo3Df?=
 =?us-ascii?Q?k+Hnghdt7DSjSQnSbsx2XCfDY5a3ZWSwSgcf+NERxxLgmOTG9i/H1y/rW58z?=
 =?us-ascii?Q?ls2HvgUAwSbAuhxQYrjJoV/x+xgZsuCYmWDhq/RLS+GWwB30HhB4/EfQtAC5?=
 =?us-ascii?Q?R6ZIPMcG8z8/2pR6PAtuDZTPJpGBqvy3EU6wxYLHG0e0PtBwMoMA5vrKUDvd?=
 =?us-ascii?Q?Tpj0McSlbkBmKjvw+uU42KyihiDDcB6tk5kCFXW7YNo4hZ6cjlTz25gVl5u6?=
 =?us-ascii?Q?kF8gJpYL5BLV+O3HZWy4IslvKo+KC5s4Q+GTMm3r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SYDFSZqOyCLLxQL3Ya5LxBe8POIlrJF7r+CU4o1yJvWdqZMmh7eZf+YQ5ZUbYzWz+0jRUiISL2B47UOJcGwTWRhzk39Z2ppxKzWK5dK/ujFaf42rcsxGW+ns1DzpEtvYaGL1IxPdb2z/D2r7CCj876AJWioXh9aNj/hveC60S20Sspw00vyv8wlY/WNH7mCrAHUPhdI5o+LelqlmGTWp1UHfcmsLTDz6dSN2V+tYYchgQn3WbnE81qYNRMp9fMZGVyUlEn8UnV6Kdv3gjClqggtMSQ9Rp5n200X7E27VvfDWJ59uRVS+OnkwwIgPoFqmlPE+w5r52h39gy9w8FJ/LWMK9j6VewJZ4lbhmQ8M9SFqmToaliQcUaiclmaeO8GB7HmDvJEHzZicNxOfYni3KK/0hrmJS4FjHVypPEY0B3OWgGzNI2yvqOD0SL0PAZ7/T3pcawYtuYew/ZgR7sXi/EaELCPdzeL29lWhF4T/5QnFm83vwbt/XcCncxTHsUkxdaT7pJHMlVKHlwHKp47jJeucMuPA/2zGn96ptMEpx3DdgnJW+3ohRj1tgpjH+ju9+okWcjrGE7eNbEeKSe0bVdWMSlvkaTzAklJyM4cVUt8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622b706c-559b-473e-987e-08dcd4016346
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 14:36:00.6684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcYmc6oXXAPskaAhxFAFX68LW5AxlMj6M0NOfLrt41aAinD9v0PI5vpr+Edfqxcc3cCd7/KuRhcYRo0H/CB+hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130102
X-Proofpoint-GUID: IxkR7qcwGaZGFme-BMUSjYCpvvX0eHXu
X-Proofpoint-ORIG-GUID: IxkR7qcwGaZGFme-BMUSjYCpvvX0eHXu


..Add Shakeel's new email address

* Liam R. Howlett <Liam.Howlett@oracle.com> [240913 10:31]:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240913 10:06]:
> > In commit 96cfe2c0fd23 ("mm/madvise: replace ptrace attach requirement for
> > process_madvise") process_madvise() was updated to require the caller to
> > possess the CAP_SYS_NICE capability to perform the operation, in addition
> > to a check against PTRACE_MODE_READ performed by mm_access().
> > 
> > The mm_access() function explicitly checks to see if the address space of
> > the process being referenced is the current one, in which case no check is
> > performed.
> > 
> > We, however, do not do this when checking the CAP_SYS_NICE capability. This
> > means that we insist on the caller possessing this capability in order to
> > perform madvise() operations on its own address space, which seems
> > nonsensical.
> > 
> > Simply add a check to allow for an invocation of this function with pidfd
> > set to the current process without elevation.
> > 
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Probably needs a fixes 96cfe2c0fd23 tag?
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> 
> > ---
> >  mm/madvise.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 4e64770be16c..ff139e57cca2 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1520,7 +1520,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >  	 * Require CAP_SYS_NICE for influencing process performance. Note that
> >  	 * only non-destructive hints are currently supported.
> >  	 */
> > -	if (!capable(CAP_SYS_NICE)) {
> > +	if (mm != current->mm && !capable(CAP_SYS_NICE)) {
> >  		ret = -EPERM;
> >  		goto release_mm;
> >  	}
> > -- 
> > 2.46.0
> > 

