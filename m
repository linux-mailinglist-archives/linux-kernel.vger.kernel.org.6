Return-Path: <linux-kernel+bounces-255619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9350C9342F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CA91C21451
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1BD18C337;
	Wed, 17 Jul 2024 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L8Qn6u6u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kIz/lBPa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF368188CC1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246871; cv=fail; b=AfMn5Ef5BzYd88wfyg3B4R9bSUJjCd7vNVqvvGCdiLLH2eeRGInDnhEcnL+FxBlje5iGIr969r+YxolNEUfxk+T9gfJ2KLrWNg+2bLqeVkdCljj2W/6Wc0KVE5UNc4vlTTkGqUZwgiI+LcLg3ltU2ttbO7ou28aO6zXISbpTDq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246871; c=relaxed/simple;
	bh=ahjT4jAX2L9Bvhdj5nbsQZCB8KEUEamjhkuT5LY7s2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q/xIQOwPv0ivQC34M0ZviqaqWXDnZ6/8/viDbOydWq0IrgYZ8er9npk9vYpZcE0LeXvoq5ARvjYvdjwL9N+PHNUpByLy2FYOjgUc6BOo6nMeMSZpii4zQUPifFEasItPvy109LIiEEnpR1e95nCyjRyS/WdTEdWwawEB48MLgL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L8Qn6u6u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kIz/lBPa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HK02JU028040;
	Wed, 17 Jul 2024 20:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=dpHEzn80OIyOxWiBfc/i9nreyp81gPbsuptSnKpNCXI=; b=
	L8Qn6u6uI0rigaSQ56VHmhUlWrMua93Sqy8GV8Slqr1He+Ft0X9tCEG3z1LVceuZ
	JJffKVIFsP7nxRK/Z0RClQtrkXlvFL/3iM1F3zUgjtd9BuAFJr5VTp90t433vbBq
	7P2JR5Xvq3y/wRm8MqFIYdDX57wHnYkgjIYPmfq87eUmUww/PVqkrv3+moimZTH2
	AIKkUzNFW2GRGv6zNRsNU8yxfzwCAejkaHD8YP9wejT/pOusfNMn8ahywZ1P3npf
	NQ9UOB/33ijfTU97vqbcyvKRaQCK0/nqAUseX+oodXCexz6MQpzVwbIwyJhjS3Re
	YGhHRnhj1cF2MAJnrIbJDQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emkyg19k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HIrJXl006940;
	Wed, 17 Jul 2024 20:07:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwey1fcb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUSht0IDkIuSCu+OnoiRYek3cOumGDq22liHknB1nzXWtmW8sRCz8VRmAd0GDNRrAB8jqcOYOcj+1yee7a3HY/kozLOQ4j7zpZgGCcD48fbHOCjU1talcGGAr/+r9W5xFqS90sbwbtWuIxuKZppny0tKmJQ3tVpOEYTgFFBqgic65ZfSUwTghRJ+DzYjSmKiVXrSXDrdwhNg2crCPaEAffsPhowSRgRjslMfJxNjaaSIwxE1buCLuxvcO5RjfYd0kRa0t2wEuZ46L6Y2s4n2xkNrkzCUJRY7oX6FSb0gNXKIiVrzjAU7W3OIJI7AS56wpj9rm/MlcU1C2pIhjyEooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpHEzn80OIyOxWiBfc/i9nreyp81gPbsuptSnKpNCXI=;
 b=EwqowUH+XnKKwYt6rwqqfcqhgp9Sbnx200vhKzyALnRQ8THjL5vROTZ8fK/AneIPRpZtlWxhUkl7rHjedEodcwNeLd2zzaGZIi1M+KnkXuvA56Y4MbOftDSRa+FAJM40ariKE44/Fg7iIGnavFRPrdGtYHyJCYOuHTIITNIMTDyQxf3ueMd3WQJF6ZQD4KU6OGtoxPgVFuDDdz4DeTjBnqoOz8qb4J4nDDQsg3nk00rwBb61XzHNQoErKRObmvRYdCz1GaTNuq7Ohjo+OkWtZ53XYO1hSaIw7Mq1gMOPDQqcaoxD0hkovPQGJ9P109Kz0LzGTmQdKyxv13wzu5KRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpHEzn80OIyOxWiBfc/i9nreyp81gPbsuptSnKpNCXI=;
 b=kIz/lBPaRN6SI/ITe+XB0lwkWvfhFUMHZRM5San4l04X3XGX4H1/RoLiAnQxldWTOMTm3KzIyvoH83dhMtKaoqlCUkY1lr7CHXFDu8OHvSkEq9c02jWDHXIqTPtgX5AizbYlTufLjBmlHJqrCuWn1DIhZvRYE9NeMzVaGFvm+sU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:24 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 03/21] mm/mmap: Introduce vmi_complete_munmap_vmas()
Date: Wed, 17 Jul 2024 16:06:51 -0400
Message-ID: <20240717200709.1552558-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: b85c3025-21dd-441b-d1b0-08dca69c104b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?e62a/9dA5J44bLZYKBqIKnzoJJ6Zi/nbGUX9DI5NjKkqdCIb1DoVARYe/95l?=
 =?us-ascii?Q?oYqQJnztszPGlwudsPbLQPRsDlX9FLlvrVhf/yL5MK6Y3XJxIG9ult17+QRb?=
 =?us-ascii?Q?W65k83nOr9oBQ+lnrGPHBjIJd49fEMSWEtJSncx/kXWQ+zWmmWKPmpTBDQKQ?=
 =?us-ascii?Q?5gN3dO6m8/Ind5Ug/Yiamulw9SW2P4N1QgWTA3yCygZF51yXehdiaS8f0OIq?=
 =?us-ascii?Q?NaaXaKeFV8Wf4mAIXvBTzFsJgE5gm3WG+94MpH9zu232ebpSFufP6b4lCCCv?=
 =?us-ascii?Q?KgYiV1oEdtovKrt0CeSWGHP0LTlcJqeYG1ZIgAaoysLQVELxeEPO8w06Vjx/?=
 =?us-ascii?Q?PvC222aD7sOK1UGbucn4NYiVIWqHi6bgxje6vbeHiE5pjHKBg6HXiNuv5CEl?=
 =?us-ascii?Q?5TyIf+mTHQpxC8ioPubVDQvkgfxAxdA4OzeI9ujHWit8ow8xrCF0MU6XM8rr?=
 =?us-ascii?Q?qWZjk6PoKJ9LGdF+Uwr4gqPXPKjTKIyxueCukKg7/O3Uqsk6nP7rnpol5KGd?=
 =?us-ascii?Q?LQCtHzDIHc10iUNj5JOOVfOa85Gjntof2zcV3Aefa0And0F2bHdvhScHi6Le?=
 =?us-ascii?Q?RK4tMq7G/VWmAJUeHTXipcAGKUDlp0jHxoCR4l8BFhfGl4QAFSRvJ/YYKU7V?=
 =?us-ascii?Q?fapuHqB6jfog88nHYmNTUzUzmTG0oqflI+yuZHyxe6WZ36gNXpBayKt4ilKh?=
 =?us-ascii?Q?pU+aWrk7kQ9JcRdU0tI65S8MZRtx923+A7fRyj/d9DYqheWroO1sO1DrFspZ?=
 =?us-ascii?Q?NdG/dO8eWHR32+2ldL0yEjbUnY2REh52myd8eKEZYfZp5CIDxDbQyinAKA5F?=
 =?us-ascii?Q?ZeS85lRkWuXob8I0X9fHXdLxqpeKDsZ4z3KL8gSOsPwkga7rJYgvJZ6HgU5i?=
 =?us-ascii?Q?zmgUG6DRg96PjiNttZWeDJtMy6RCvt2xLTDv2tKYaSvI9nYlup+5IL7k88hz?=
 =?us-ascii?Q?ShR1RMGrxB+icw0zPv5uCx99qpY8VT61G9LYacamTM04bzv9YMixozEc08kl?=
 =?us-ascii?Q?hCgGrqIncZp+OQKhMv1ou2/XSgfesLreN6inXGMmnny0A3Fsvbf7CQaRwv7A?=
 =?us-ascii?Q?icyqPnnT8s+9+YLtXBSLgufBIQ0jbh8/WSPVfNq2FBDOBjmle4miCmFZXa+x?=
 =?us-ascii?Q?Ac5X9Y0Bb9ekPHQsfkBkGnJ3TSA3n8+59dpS5A0vlvDYYWSmEneryLdX1m59?=
 =?us-ascii?Q?epuL5zpAuiUjxpSGTQ7XoOK8AYZs2dzcZzdnxSNBWxO7z7L1N1MRNHSYm/0G?=
 =?us-ascii?Q?ISqbF6vbi/kIynqzXSFAJFBj4FyxF0Rmt3VjNHNI4etPU17kss6XksI0dIMq?=
 =?us-ascii?Q?qod1Q33bWXmRkdv3mWty51HJP7ze1TRlF1ueotMQ3fKBkw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gE5StXQyyZXM9PxttijVvsn5BqKp/q/f5nUgGnKBxmeMEvXguXiHrIuL1nEC?=
 =?us-ascii?Q?kb2Sqts2gDU/gV1WeSJpWbpVs1t7RwYIoaxTKT92IEVExkmakLqvbGXHwy36?=
 =?us-ascii?Q?wJi51E3WQdcSq1S5QFvpLzloATUJDaPGrb6ptoUvb4WQ7YlQJqyRMKMKX98s?=
 =?us-ascii?Q?E2A9iGvbZnYClYVVV9FwJ4boGH6q9/ZYmHcf+v8nMU/BwjHsuYui5FOkhlyw?=
 =?us-ascii?Q?/Xn+wEfNI+1HlOTqKrTO2Fa/Vzg3tuC1nbAqqslbxG6eOsEP9A9UUFr17buW?=
 =?us-ascii?Q?FK/a1VdDSggvzbVsrry073nOJUej+Ne9X2hPwtEVg/PGeSu2FeJu/qWClXZI?=
 =?us-ascii?Q?zJFHhywoIz8WqRU35dDWN2HxhF8EobYN0nWof5D3ms2UNxNfswjyvRhlSSUR?=
 =?us-ascii?Q?2U2cbS+INQuyUyjERt3hLIn5UYYv4DGp6aDDnsSzrBk3cQHaii/DT6Vu79/y?=
 =?us-ascii?Q?zCKHW8h5IOxihJr0K5gOcnLAqGWewmdg/waLezcO9PVU1xVLldzR9cJVbmIY?=
 =?us-ascii?Q?CbhOvo7YOLJ/tremHgyX2AAoPVG7IAlR8Eus2RJcJrtF/gpeqkj7N1v2zunu?=
 =?us-ascii?Q?vgpQjj3ka7ltz7iYET9+HAZga0GsGQRHPMvGjOT4vei3mJ6r0Bbmoz6Bvo94?=
 =?us-ascii?Q?809Y3fmpyKfNufBG1f71L6jym0p8xFQ8GtWU3bR9KVzj/EFLuheZfUz3TWSh?=
 =?us-ascii?Q?M2hctDHbBTs/NWWLUq2T8U2aQxcoHxiMCjeo/Ngk0AD1t8akbIekVU6FDY3+?=
 =?us-ascii?Q?CGW7iN/qTptvJOWudV8mE9CyuvMewm4nJDGKpW4Z03nL/Z+DGrwEEY1W8Ohc?=
 =?us-ascii?Q?RAC5Or9GktuOw/MraXX0pw7cwnwIevNdPATlCs1e4QqJTOLQlOZVsOt23Her?=
 =?us-ascii?Q?SGx7Sa5Qiw7lbNJUsbku5xSdNO1cR9v0M9tJ/vB5jZUgA4eXxVRMR390I7TZ?=
 =?us-ascii?Q?rLWEvzn7YFboj+7vjsGdQ62wknx/cXgKljCm0346Jr4KVv5CGm4u4Nbb04Qz?=
 =?us-ascii?Q?RE6HdJkyHqy6Hzk9+x9BBZnhds8fopKl5+Mr/Jk+4Kfn0qa8RZ7VWEMyupNF?=
 =?us-ascii?Q?w53i04EqDThQ0ZTiql8U64KM1Vzs6caJ1CsAvK4gVSqqGxqPaKZaLHPPkNb3?=
 =?us-ascii?Q?fSc64AbgkZd+4KGewPgqi3zJUaLRgRPJe0xLdSKvie62++qcF5OPRlhCnZhd?=
 =?us-ascii?Q?frzNnJA7XP/CLd0JzcY74nzFBOg2AmJSGFDYBG98NdU1IqfWu24fDZAWmJ9G?=
 =?us-ascii?Q?pXmlz2l8K6CT+jFbIcgKw7HD8NmuSU24Ur1kwRqGwM3Q3KYuVQ5MK0KZ/RUa?=
 =?us-ascii?Q?yS8GfsxoG+fm8k4ZJBx3OsPhTVCAx/8ysiHxB0g0gIoeAscZQE8zMQ+Ux077?=
 =?us-ascii?Q?fA+JaW0AiMBVzoSDgmCaG1um5qglKzALrmkQZChFlneqa/EFztfBbQlx0xkh?=
 =?us-ascii?Q?5LAIKZJnzrjVf15O2bOhC0yCX3fyiVIumaeDumhG7yqZ9/96/3AtR4JV10hm?=
 =?us-ascii?Q?LFnbYGdrVlSxNEjRxm890qZC4X5BwiSYGn+DRXlQ8ILqKDHl4SvHBJIVq9F+?=
 =?us-ascii?Q?yfZP7SZIWNRlON5Omo/D4ImrNlqTH8r9+MJdFm15?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sfZMqnuArvtftoEvrJ/D1Q8W1ic2laaU1Y8v/8+U64Q7zS58ffa1GR3n1omsvrL0dpqzldeWifJw46X6AAxQ9XVXk61HfG1qUqQV4yera+BrIcN8RtCgxo2vPJ1ConXsWKfEPA/+IzkOon+l9Vwe/r3TRbdDd5/4OhkLpYHECw169bFg+dQWp89ihKJI52oap5uQqCG3VDkQvjqDdtdQKLeq3Srzm0UmHtVrFctuaPqBLiFt5sUjzn9EbSPUs9Xc9MDaThH3NWTyw+Jmu734b5ksmDYw1rGyVkrbyE8gMgLShz3raXaYW2cddePGbC1s2UZXu1lofoyI25tYijtsXm15dNJD1hGIG/qJ+UORreMOnGNZCl9SzB6S07mrCIxhYHMfwT/lb5y+c/qPl8Ejk18sZupTJDmYZCCNsFZ8Vsg4D2Wnj6Eo3uqkplBzkcXf15+JwNUyVnO2MAKoR4qNKCs/jwxAjM7IixPUFQ+Vol+IVuw9CTTp2wmDShK+ghTymbREOE7bMJJpjRJRsjJIGn85SwaKUXZQNNsYMGpxmORBMbH4qfXR8ldd68j1SLjdJNgnEr7SN1t2T3H8dkfnsJgR4Re+2Yll5tZCvPtGOqk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85c3025-21dd-441b-d1b0-08dca69c104b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:19.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U5l9aqes1KCB4reRwC4OxJjzBddKEafZibhuXhfLdVbwPfnHGirI/2BtUMnPt/fGf8VOAy6bCAcmqol3Ii4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-GUID: qKmkn7AXKb2v2bJP3Hj8a8xZ3O6BRXsf
X-Proofpoint-ORIG-GUID: qKmkn7AXKb2v2bJP3Hj8a8xZ3O6BRXsf

Extract all necessary operations that need to be completed after the vma
maple tree is updated from a munmap() operation.  Extracting this makes
the later patch in the series easier to understand.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 81 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index babfa50f1411..bd3378935c70 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2602,6 +2602,58 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * vmi_complete_munmap_vmas() - Finish the munmap() operation
+ * @vmi: The vma iterator
+ * @vma: The first vma to be munmapped
+ * @mm: The mm struct
+ * @start: The start address
+ * @end: The end address
+ * @unlock: Unlock the mm or not
+ * @mas_detach: them maple state of the detached vma maple tree
+ * @locked_vm: The locked_vm count in the detached vmas
+ *
+ * This function updates the mm_struct, unmaps the region, frees the resources
+ * used for the munmap() and may downgrade the lock - if requested.  Everything
+ * needed to be done once the vma maple tree is updated.
+ */
+static void
+vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		struct mm_struct *mm, unsigned long start,
+		unsigned long end, bool unlock, struct ma_state *mas_detach,
+		unsigned long locked_vm)
+{
+	struct vm_area_struct *prev, *next;
+	int count;
+
+	count = mas_detach->index + 1;
+	mm->map_count -= count;
+	mm->locked_vm -= locked_vm;
+	if (unlock)
+		mmap_write_downgrade(mm);
+
+	prev = vma_iter_prev_range(vmi);
+	next = vma_next(vmi);
+	if (next)
+		vma_iter_prev_range(vmi);
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
+		     !unlock);
+	/* Statistics and freeing VMAs */
+	mas_set(mas_detach, 0);
+	remove_mt(mm, mas_detach);
+	validate_mm(mm);
+	if (unlock)
+		mmap_read_unlock(mm);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2621,7 +2673,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool unlock)
 {
-	struct vm_area_struct *prev, *next = NULL;
+	struct vm_area_struct *next = NULL;
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
@@ -2725,31 +2777,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	mm->locked_vm -= locked_vm;
-	mm->map_count -= count;
-	if (unlock)
-		mmap_write_downgrade(mm);
-
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
-	if (next)
-		vma_iter_prev_range(vmi);
-
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(&mas_detach, 1);
-	unmap_region(mm, &mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
-	/* Statistics and freeing VMAs */
-	mas_set(&mas_detach, 0);
-	remove_mt(mm, &mas_detach);
-	validate_mm(mm);
-	if (unlock)
-		mmap_read_unlock(mm);
-
-	__mt_destroy(&mt_detach);
+	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
+				 locked_vm);
 	return 0;
 
 clear_tree_failed:
-- 
2.43.0


