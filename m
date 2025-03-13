Return-Path: <linux-kernel+bounces-558770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2B3A5EAFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED1E3B9B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F9C1F91C5;
	Thu, 13 Mar 2025 05:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="meHd/k7x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gbaUCbwS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17BF1372
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 05:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843004; cv=fail; b=WOjUGjWSgXBIdl+N55eBAOjppGramn3Ell9swB1aiKBVZDPshCxThu8LCxaXQRsdNDdy2TWpnctw0WdnuYFGY2m95TzJX8IUWB78y2s13+hlhVxRjMTMhxsnp5r4VC1a2y3984tDqUAdL+RCaa2ZFiD12j3iokEoj7t8b4hJ1bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843004; c=relaxed/simple;
	bh=7/8Dp5H6aER8F4w0jvNnYT47wzX5e70jPBPt0wlDwmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bydTVKKbCWGOUUQLOjFGGfWUMTvL9l2aZUpjmghRjpdCjRJVlCI0dLz9C6sJz+QRhKy//ltIts30y4aaKUnEwjAsHg+nRP9yqc0+iGsOXmHsQhtTL7qD5RDOVdE8t9D6zbV0Q1DSGWT23JDpFjPs8KsvAydyOJ4lhRepERCbId0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=meHd/k7x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gbaUCbwS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3tk0P021072;
	Thu, 13 Mar 2025 05:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=uVcDHV32cplhkQFiEX
	KBaUijel0BIUI8NjownND2aE0=; b=meHd/k7xOBbZachhx9U6oMo1l8lsBUSiZk
	BAUgDl/E8KC+Ywylc/SH7Au71zKI1JbA733I6gsEm/h3nUh4JdozCPWH3BW5aew0
	p1Ts4sj9UKHaP8+5dI+j2H36yIwWzry3VjYq9Cgd/toFYs6p0OzxHqQP287X5k06
	A474Pk5w8qv3xZPTmR/PfcVgshUNNVlfUuSHERsIwvsokILbcFOegN0FlG2udob5
	yC2Wko60nTKDAjnhHlGKQUjFSKo4/oP5cLjwbDN56XvYwjeDRlwnj7YoY0+oUxgS
	nTd9chDJIzdIC7tpfH0CdmO9qptQmJGsD3Mt2Pc/J5RlOh5t0Z5g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h3d5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 05:16:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3cZ8H002149;
	Thu, 13 Mar 2025 05:16:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn87jus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 05:16:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzmmQfWhaylTmqWcxcVvjf5/GHCLSTqaYlfBx/XXXpNm3c6KeUK+EGilBVtJta1+Tl9k8ipY4eCfNv/Ne6eYmqRXDOARHKdDiKL6R9Sw5Fp63TlKym332m+q3RP5o95a1reDKYn3WI/0eBclQfEYiWCYUEnN2CKAmJey2YnNCu2tq2vaYkb+4Lb4yzkE4I6+sCvoTAmiCsHserDrI/wgsOsHNikEGL6660qsxPXl6dqhF6g/fmsjNRD93wkBUvg6GB91Z4rrZAledL5beyaFWV5bvXYSacUZeYjmNqyDCekqoLQQEjLbd2Gjn7Qlm3r8ivdx+taOfAbAHnWGb7azdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVcDHV32cplhkQFiEXKBaUijel0BIUI8NjownND2aE0=;
 b=kxsypkFPuYcuMp+zEhUoZhNcY6rxWNE6hlC3E2RR9AOB5jbINokRFOZaOW4FrW26JcQAr0BpaSmP7hKGHXC7/9fIzR4y0TWWfDc5rDktA8Rizn4Bk0xkZcwR5TzTqudYCPlXCmMmJrtHCoIKk4B26RZwss9JV5DlLyHTYNg7WS891ZMcQ9sq/Ri4wqCCHhud0rdC8SS9kdK1JiBYT1PsfNd/f59yOmp8zAP1rQxC0r3+UOYlqvFRuV760cdr+kEM3X2fnoUypHmEROrA1T6JdopyeKePBlVFP8CrMdyEigesE2YL+3iqyrimmOpJefwhmZTTWq5p1igVAhOLvCffzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVcDHV32cplhkQFiEXKBaUijel0BIUI8NjownND2aE0=;
 b=gbaUCbwSC6p4kPa+YibE6HnM0K6RfjaQte6hA5tkBUst5ET1MSehVwCTCYA6xdF7h1QvCuzdHqas30JUIO2Uvu78dbv/62pp3mJwZDXD4WTyj7LXjrc7Ro/tNuv98OES++S6K/g0s1B7OeCGCLyBN5M4ehEl5bL/8SH2jVU1qrg=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CY8PR10MB6586.namprd10.prod.outlook.com (2603:10b6:930:59::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.29; Thu, 13 Mar
 2025 05:16:21 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 13 Mar 2025
 05:16:19 +0000
Date: Thu, 13 Mar 2025 05:16:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Vasily Gorbik <gor@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
        oliver.sang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [v2 PATCH] mm: vma: skip anonymous vma when inserting vma to
 file rmap tree
Message-ID: <9dc18681-66fa-41f4-ab49-4a395b52ea25@lucifer.local>
References: <your-ad-here.call-01741821544-ext-0004@work.hours>
 <459212b0-6440-48c4-b7ae-47be46f17089@os.amperecomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459212b0-6440-48c4-b7ae-47be46f17089@os.amperecomputing.com>
X-ClientProxiedBy: LO4P265CA0062.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::18) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CY8PR10MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 90854680-97f3-40be-d602-08dd61ee300f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j2ZdZksbvLOS2KYQHctyrDsalWwefd0fdAOruQLBYZPX8DiMpvlPa82wFHi1?=
 =?us-ascii?Q?Fi2QUh5RdSQeiiRQGEb7QDDkR3KXW6xmqOFFOkyyNlm+BdWio5n7ui7D3m4j?=
 =?us-ascii?Q?8Kb0a5SMFdmZ3SBDNTxcPQLHDNkOVPndZ64YBt2E570t8HHATSFCFbCBGsPb?=
 =?us-ascii?Q?lrPOPS1BzdiFKEfe+SXQAheB1ydzQvJMNtINbc70S3WKUAo3ahmPlDDW5mwY?=
 =?us-ascii?Q?WzO02HWZpx/A+8Xz0noql+Fdt6VWlkZ9zXq0vJiSZoZhEEdZebqpETKx3KLr?=
 =?us-ascii?Q?XNsrycyAXmppsZJZqcO6ZhOIVYNx4kvTY2zMAFD2rmZiE1C1Wq2tYZIyxYuH?=
 =?us-ascii?Q?bAmzNji1vB5/1T8nUCDYkolF87kJlwy7eTD0SJoYFgXmgM09PrwPmJyOAs96?=
 =?us-ascii?Q?Bj5nNUJZK+3mK5sMIp0Xxd8oVBNSVOvFtNfhzXaHOCM0w17i+KpkoFNQBudK?=
 =?us-ascii?Q?Yzt6jLkHoH+73fm6rHSEEYvgMMynX2YhovSKYqTFdkmSQCJm3UhTbY34IRVC?=
 =?us-ascii?Q?8BYkgSgNbBUNHIGrE/xFoF8M3dwPzxJbZNxEm896OqOZhfEfR2EOA/HbXxt/?=
 =?us-ascii?Q?NUl+xL+97nWnVz8H3AFJCieOuMFoYrMkru5GSmiFaM3Mo7PwlNCRooYOWIZt?=
 =?us-ascii?Q?ptn5pd8oW2NI1xSVsqItdPoYXw9p/sPTOupoTo0dpFQ9W54O8zIFuC63oDk0?=
 =?us-ascii?Q?xyxcSeJI4rDMy3wp3AgubQCIxa/Y73Tghfim5W5tgEVwHKDKTchg6+5XwyrW?=
 =?us-ascii?Q?c0TK4tsq8gkmsSJ0hfVe/V27KcZ2XpVUA33fVGEXeDbpveq7OqoFyGucdVyW?=
 =?us-ascii?Q?qQseosLyiJ5Knh/73rPxBPfxbcMH5ENT/Nj40rYnMfOJhvKDK9za4gp4kc1B?=
 =?us-ascii?Q?qaTsTE9vzl3gd5lHRNGZT5MFImGwDsyg5CtyUN3S8n9Gg3wsjBTDpjIYsjMa?=
 =?us-ascii?Q?+l/L8rLCWZ9rHILBxbwHaTSyZ2W5Z+AAggZGIGMICcEVj+JtDUpcUisHnsgV?=
 =?us-ascii?Q?TwLeGE4HbS5FyVDw+/zmaDM3r3BjiUOTST+/YffT/c2iUl4478STN5OMrEeC?=
 =?us-ascii?Q?UrllVv1K0P/mcGrOuCUxNQQwdH9OsTRQW7DrdRWNJzNgraGuIdu9oPR1w/qD?=
 =?us-ascii?Q?uRlxBPYTteGsgTDsdyl7JrX/77SSNFdFSA2HQhYF4q0Mcj7KtRv0Kd+eT7nQ?=
 =?us-ascii?Q?z5hA/HJmW8qWljT8JIXKO5H88h1b7LR/i4Vuz7NsVRyKq/X75tP3Bfs6eU6H?=
 =?us-ascii?Q?Uf5/UmuFAf7PLXPyoUw+RLhgjE/Jos1ddHUOErNYDZbCFm7IO3tjxy51guNA?=
 =?us-ascii?Q?HfHmikd7eNtfmU8Sb6WiiCBpiNBR1SqJ6J02S1JcAn9ixXqsCJvXfngXZIpp?=
 =?us-ascii?Q?ChqhMDTNxG8fBNbcevv19rFZnxLO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sFBiO7bOuS5zvnd0ZfvLD42RwLVvAVG1MLegFDpBnYjSftojKX0bay1zvCYx?=
 =?us-ascii?Q?pErkBB2EkIpWWQGkaAwboRt8AmmEXvb2EOuRUGrbCsF2q/Jv4a96q6890Bg8?=
 =?us-ascii?Q?2PAUZwQSaFqYnR8D8/ek/GHXFO6Gq/hO6Vhhp8qbv+TqPC1E0aAnMRi3nAc7?=
 =?us-ascii?Q?YKm5fZPQrN/Xm2JP+8IplpodaEdnZygZAvcDafG4hGEGlQ/nSVc2AVHdIbeY?=
 =?us-ascii?Q?4S4M/LxPEsee4NnB1Pqut1VXKHSONWJK3s/p8NzSsur6KWn26WBNmqqd3SIn?=
 =?us-ascii?Q?MfFX/tv8V1sUwkpY6TnB7mwXMD3ISMqteIEtIKwd1uEpRmkzEHW7AEXZ1xfY?=
 =?us-ascii?Q?soujV7PY2OW7QbQNkUi1ea4ypEGuHYbx4kw1SonJ9pNSwEQ6kJHaarUdxhad?=
 =?us-ascii?Q?JlJe1uFnzSo6YPu7ua9Bi70N6Vm6rcHQg89PL7KPOg3Xrc/LL2sgXFl/EVDb?=
 =?us-ascii?Q?thTEX06TK4nMbqi9q4gx223DUU55jYAnmsnjeleX6cmelutWT8oHoE+kuy8m?=
 =?us-ascii?Q?9nefj9CF31tfeQtc6yVxYHUApA0ZXt0GIQTjIOoKezvH+Hempmd6thJyMvDp?=
 =?us-ascii?Q?qN3hSpew3/BDetpoJeX9NqQiCmp+egl9FW6FT1oWvHY1WZ9FMgFbek13iV/J?=
 =?us-ascii?Q?lQDbHjsoE/EwrB+tRoWlSmh3S4GX8fHi2s7ROcblVGWi8tX28Uq8qOqT58V2?=
 =?us-ascii?Q?oSUunH1PjP5xNvWIK3bDh4gdavKcZ2fkIayOD1b+evdSnNGZ2IyHK8HKG03x?=
 =?us-ascii?Q?vIX8AoRn0FXyEyJiq0YjywWXZ9VfLjsnoM5giW4wtImYVM3eU1S8rkUZ8kKn?=
 =?us-ascii?Q?sBjuGvTELheCiHaD748nkV/KK6BGfWBlY67ypVXtm5b4yMQzimTfDMOzUa9j?=
 =?us-ascii?Q?EQzpnqS5BaCHTPF7e3uSPfXVQJGs84BkcH3Iby4P+Xw5+se0V3sYFoPSGCmJ?=
 =?us-ascii?Q?1MQG9rtAbNVmXXYuWXin0HPAdhj74exRtFe0R5+J0qBCQxMYZYGhGLWYOe3M?=
 =?us-ascii?Q?EDjzmrK2IfrUKe/G/D80TOPSUZHuaxVLby0wp+l0IZb15llCbKuK48cKWPbo?=
 =?us-ascii?Q?dcazIa7izfT2740Nq1qVwu316qq4hXZewKZGv8sCvSV3Gj209hqGBx3TL/vD?=
 =?us-ascii?Q?PukdxdGSCFNts8ZTpC1Si/rrz1VVYBz3ImebuymvdNxEITZM2glBlisSgIQu?=
 =?us-ascii?Q?713ZDmYFDV599D0i8WzsolbwX1X8WjkIB17xViAZ6Sp5+tUWFNbLjcQlFYMq?=
 =?us-ascii?Q?WPmZh2Am4Ko8nxDfP3Grw7lBs6e1kUkrltNH+q+jUvRtEGA/ZfzIeyXYcIjU?=
 =?us-ascii?Q?wx6G0sNkN8LwTap83+ZrhZeT6EPu73zyrr2whBfscfWTqxn7Dy99v8hUWmEQ?=
 =?us-ascii?Q?7GyGvAwEhG34LQ3V69WoxJcltsV0UXtXIQOI3MQzc6FHP3sV5PZ9Z+rhWM8L?=
 =?us-ascii?Q?PQpAf3HIcnUygRQ+brY8xqPX2Db928zLHyM6W7o98gMPbPrhVtwsA9/VgS+p?=
 =?us-ascii?Q?v76r9xRxPJY2lAvNMsqZ3gm9sqmSjH3Mzhkq2nJ3R6eOdEYvbe5h7CsupXEv?=
 =?us-ascii?Q?Ql4J+0Cv1WF/aZ9SLMxZUMLMZTQFNqvKrIobzsc1WsiZlWEU3zP87B3G88pq?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bn3VYJJqBh+GX1UEyGQOrl34hSeqS1sKNmEM9uuTMqptKJv6zq9ZNOmTUPfFPBb2PEtWxS+HZ+PAT/BtxiuSWbwONMQfIT0FsTfbHTttOOBctr+PKiLCJS7Ieqcv7eKDpef8T505aGgBTqjZeAqOGZnMuA2BublQgRwq5g1cgVZMevbzJB0TR3fOHUCR0kqPtPXpgNnSUOY245md/qk2yU6d8ValsjyAyVTqIVesKzqW0e+fzy62Qu+zmiq66gRU5gNzY9AQjC8HXIiD7efrjfZek8AFqoaymgRZwg21NEWXyB3l14tLb2Bhx1eA3LmKpU8qOwBg2CKTPXVpEuThNJ7Wb4sEPZ6FImmEOeEJCbxBrePus28n53QT3Kso9rTDiLClFMp0eHbTSA+swsPNjvOsUinMkwml2Vu/X0lK0+qOTZ5Q+AMuH5TBAIy+pTB2TYggd5iXwLZ98M3n7SN1C9v4IP6XG7bEHV0sgVvBggfZpWS44ofoZdMGGuGUnhOkAKDPk9DjHlrcTf2m+JUJe5Zl/gGndYwZvF9Y6tTNZK5XnhGbXr74XdFJ+HZfvvr9aazb7lVlUyS13RcfnIfoDSDEN8M+YIdej1rzwBlxXUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90854680-97f3-40be-d602-08dd61ee300f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 05:16:19.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qt0uilUpxLdQe8xBZ9oHM8ef0ksyJszt7SSKHZGb/8eDbz6/OuOkE2TGUIU1lFMOu7YeIA1pqG7NFJqHvqyjixJ3lFbydOoGvMQySyscbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6586
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130039
X-Proofpoint-ORIG-GUID: J6byFkj1Z-rCwgJ7thr8VefYLhJwg68p
X-Proofpoint-GUID: J6byFkj1Z-rCwgJ7thr8VefYLhJwg68p

On Wed, Mar 12, 2025 at 08:04:23PM -0700, Yang Shi wrote:
>
>
> On 3/12/25 4:55 PM, Vasily Gorbik wrote:
> > On Wed, Mar 12, 2025 at 03:15:21PM -0700, Yang Shi wrote:
> > > LKP reported 800% performance improvement for small-allocs benchmark
> > > from vm-scalability [1] with patch ("/dev/zero: make private mapping
> > > full anonymous mapping") [2], but the patch was nack'ed since it changes
> > > the output of smaps somewhat.
> > ...
> > > ---
> > > v2:
> > >     * Added the comments in code suggested by Lorenzo
> > >     * Collected R-b from Lorenze
> > >
> > >   mm/vma.c | 18 ++++++++++++++++--
> > >   1 file changed, 16 insertions(+), 2 deletions(-)
> > Hi Yang,
> >
> > Replying to v2, as the code is the same as v1 in linux-next:
> >
> > The LTP test "mmap10" consistently triggers a kernel NULL pointer
> > dereference with this change, at least on x86 and s390. Reverting just
> > this single patch from linux-next fixes the issue.
>
> Hi Vasily,
>
> Thanks for the report. It is because dup_mmap() inserts the VMA into file
> rmap by checking whether vma->vm_file is NULL or not. This splat can be
> killed by skipping anonymous vma, but this actually will expose a more
> severe problem. The struct file refcount may be imbalance. The refcount is
> inc'ed in mmap, then inc'ed again by fork(), it is dec'ed when unmap or
> process exit. If we skip refcount inc in fork, we need skip refcount dec in
> unmap too, but there is still one refcount from mmap.
>
> Can we dec refcount in mmap if we see it is anonymous vma finally?
> Unfortunately, no. If the refcount reaches 0, the struct file will be freed.
> We will run into UAF when looking up smaps IIUC. It may point to anything.
>
> Lorenzo,
>
> This problem seems more complicated than what I thought in the first place.
> Making it is a real anonymous vma (vm_file is NULL) may be still the best
> option. But we need figure out how we can keep compatible smaps.

Ugh lord. I am not in favour of this for reasons aforementioned, and I _really_
don't want to special case this any more than we already do...

Let me think a bit about this also.

Maybe if you're at LSF we can chat about it there?

Thanks!

>
> Andrew,
>
> Can you please drop this patch from your tree?
>
> Thanks,
> Yang
>
> >
> > LTP: starting mmap10
> > BUG: kernel NULL pointer dereference, address: 0000000000000008
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 800000010d22a067 P4D 800000010d22a067 PUD 11ff09067 PMD 0
> > Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 5 UID: 0 PID: 1719 Comm: mmap10 Not tainted 6.14.0-rc6-next-20250312 #3
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> > RIP: 0010:__rb_insert_augmented+0x2b/0x1d0
> > Code: 0f 1e fa 48 89 f8 48 8b 3f 48 85 ff 0f 84 a4 01 00 00 41 55 49 89 f5 41 54 49 89 d4 55 53 48 8b 1f f6 c3 01 0f 85 e1 00 00 00 <48> 8b 53 08 48 39 fa 74 67 48 85 d2 74 09 f6 02 01 0f 84 a0 00 00
> > RSP: 0018:ffffc90002b47cc8 EFLAGS: 00010246
> > RAX: ffff8881143ab788 RBX: 0000000000000000 RCX: 00000000000009ff
> > RDX: ffffffff814ad5d0 RSI: ffff888100bb5060 RDI: ffff8881143ab088
> > RBP: ffff8881053af8c0 R08: ffff8881143ab700 R09: 00007ff6433f2000
> > R10: 00007ff6433f2000 R11: ffff8881143ab000 R12: ffffffff814ad5d0
> > R13: ffff888100bb5060 R14: ffff8881143ab700 R15: ffff8881143ab000
> > FS:  00007ff643df1740(0000) GS:ffff8882b45bf000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000008 CR3: 000000011b042000 CR4: 00000000000006f0
> > Call Trace:
> >   <TASK>
> >   ? __die_body.cold+0x19/0x2b
> >   ? page_fault_oops+0xc4/0x1f0
> >   ? search_extable+0x26/0x30
> >   ? search_module_extables+0x3f/0x60
> >   ? exc_page_fault+0x6b/0x150
> >   ? asm_exc_page_fault+0x26/0x30
> >   ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
> >   ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
> >   ? __rb_insert_augmented+0x2b/0x1d0
> >   copy_mm+0x48a/0x8c0
> >   copy_process+0xf98/0x1930
> >   kernel_clone+0xb7/0x3b0
> >   __do_sys_clone+0x65/0x90
> >   do_syscall_64+0x9e/0x1a0
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7ff643eb2b00
> > Code: 31 c0 31 d2 31 f6 bf 11 00 20 01 48 89 e5 53 48 83 ec 08 64 48 8b 04 25 10 00 00 00 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 89 c3 85 c0 75 31 64 48 8b 04 25 10 00 00
> > RSP: 002b:00007ffdac219010 EFLAGS: 00000202 ORIG_RAX: 0000000000000038
> > RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff643eb2b00
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> > RBP: 00007ffdac219020 R08: 0000000000000000 R09: 0000000000000000
> > R10: 00007ff643df1a10 R11: 0000000000000202 R12: 0000000000000001
> > R13: 0000000000000000 R14: 00007ff644036000 R15: 0000000000000000
> >   </TASK>
> > Modules linked in:
> > CR2: 0000000000000008
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:__rb_insert_augmented+0x2b/0x1d0
> > Code: 0f 1e fa 48 89 f8 48 8b 3f 48 85 ff 0f 84 a4 01 00 00 41 55 49 89 f5 41 54 49 89 d4 55 53 48 8b 1f f6 c3 01 0f 85 e1 00 00 00 <48> 8b 53 08 48 39 fa 74 67 48 85 d2 74 09 f6 02 01 0f 84 a0 00 00
> > RSP: 0018:ffffc90002b47cc8 EFLAGS: 00010246
> > RAX: ffff8881143ab788 RBX: 0000000000000000 RCX: 00000000000009ff
> > RDX: ffffffff814ad5d0 RSI: ffff888100bb5060 RDI: ffff8881143ab088
> > RBP: ffff8881053af8c0 R08: ffff8881143ab700 R09: 00007ff6433f2000
> > R10: 00007ff6433f2000 R11: ffff8881143ab000 R12: ffffffff814ad5d0
> > R13: ffff888100bb5060 R14: ffff8881143ab700 R15: ffff8881143ab000
> > FS:  00007ff643df1740(0000) GS:ffff8882b45bf000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000008 CR3: 000000011b042000 CR4: 00000000000006f0
> >
> >
> >
> > LTP: starting mmap10
> > Unable to handle kernel pointer dereference in virtual kernel address space
> > Failing address: 0000000000000000 TEID: 0000000000000483
> > Fault in home space mode while using kernel ASCE.
> > AS:000000000247c007 R3:00000001ffffc007 S:00000001ffffb801 P:000000000000013d
> > Oops: 0004 ilc:3 [#1] SMP
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 665 Comm: mmap10 Not tainted 6.14.0-rc6-next-20250312 #16
> > Hardware name: IBM 3931 A01 704 (KVM/Linux)
> > Krnl PSW : 0704c00180000000 000003ffe0ee0440 (__rb_insert_augmented+0x60/0x210)
> >             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> > Krnl GPRS: 00000000009ff000 0000000000000000 000000008e5f7508 0000000084a7ed08
> >             00000000000009fe 0000000000000000 0000000000000000 0000037fe06c7b68
> >             00000000801d0e90 000003ffe04158d0 0000000084a7ed08 0000000000000000
> >             000003ffbb700000 00000000801d0e48 000003ffe0ee057c 0000037fe06c7a40
> > Krnl Code: 000003ffe0ee0430: e31030080004        lg      %r1,8(%r3)
> >             000003ffe0ee0436: ec1200888064        cgrj    %r1,%r2,8,000003ffe0ee0546
> >            #000003ffe0ee043c: b90400a3            lgr     %r10,%r3
> >            >000003ffe0ee0440: e310b0100024        stg     %r1,16(%r11)
> >             000003ffe0ee0446: e3b030080024        stg     %r11,8(%r3)
> >             000003ffe0ee044c: ec180009007c        cgij    %r1,0,8,000003ffe0ee045e
> >             000003ffe0ee0452: ec2b000100d9        aghik   %r2,%r11,1
> >             000003ffe0ee0458: e32010000024        stg     %r2,0(%r1)
> > Call Trace:
> >   [<000003ffe0ee0440>] __rb_insert_augmented+0x60/0x210
> >   [<000003ffe016d6c4>] dup_mmap+0x424/0x8c0
> >   [<000003ffe016dc62>] copy_mm+0x102/0x1c0
> >   [<000003ffe016e8ae>] copy_process+0x7ce/0x12b0
> >   [<000003ffe016f458>] kernel_clone+0x68/0x380
> >   [<000003ffe016f84a>] __do_sys_clone+0x5a/0x70
> >   [<000003ffe016faa0>] __s390x_sys_clone+0x40/0x50
> >   [<000003ffe011c9b6>] do_syscall.constprop.0+0x116/0x140
> >   [<000003ffe0ef1d64>] __do_syscall+0xd4/0x1c0
> >   [<000003ffe0efd044>] system_call+0x74/0x98
> > Last Breaking-Event-Address:
> >   [<000003ffe0ee058a>] __rb_insert_augmented+0x1aa/0x210
> > Kernel panic - not syncing: Fatal exception: panic_on_oops
>

