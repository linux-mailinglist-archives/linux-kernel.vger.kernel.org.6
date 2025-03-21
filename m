Return-Path: <linux-kernel+bounces-572021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA17A6C581
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7D53B3F90
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD76328E7;
	Fri, 21 Mar 2025 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GtP0DPel";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xM7mvX/r"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E3233707
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594109; cv=fail; b=jxewgmEiTqpPmTQcnPBtXEQWW7to6Nb3MOt4vg4x7++kh3hOqApqNO33beltl1jPBGLxTOCVBaRdOGMQ86RloaeQYs8Ha4US6vs3ulv8txgCKu1t5esuUFfgX6Mp3l3hT+uvYsJG2jtbe7QtHp2SOY+q5UUr5ui1yO+itB5xEoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594109; c=relaxed/simple;
	bh=ZzePpFFZvljzriaKnLkKvBYk+PZaVpqwD/RrcHYv1CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=byrqueaCL/vuU9HpLp8jojvjREeBcN/fsE/WrM0fGjbFxjkJHJAcrqPTH5NXD//kGltU0ySHTORma1v01dKpzXkA3nwP1etGH+pQSQHW6UzyEHWiEoePXu7tJ4rt7ihJldHWP8jq/NO8DHHEfLW7Oaf9H/1y24dBsP7U7Djefj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GtP0DPel; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xM7mvX/r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKgAZk002756;
	Fri, 21 Mar 2025 21:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tmP0Uk2iQ/RhVqGJpNWxQVOhjFWRkq0HRksYixUrgDg=; b=
	GtP0DPelaGwzH2LyT+VSIL3332spxUe0l+/njiMxFL9nkaIlw3ZdLyyNS+IauzQl
	XqoMdLzKoD6NEdL0gqzYdL8MRJkljeLAJNzOVhI/4VkTv+DMBHQJE8hGUs1gKltA
	vVysP5A1XKiCxzkonhJq6h40p0rOV4RaAdrHTQJg/YX5o3lvK92jI6vcCPTI/Wu4
	ECzvCLt72xeaKV8mwltZ/iH8hF93vcah1bTGwUHpdsmzsHJiiRgAV6Jqx1lHk18J
	kYolFEEDTg2niptRwnjsqOZhYaqxsHYzDIKKbb3PrFlJftes9w2/eel1bLlKBtmY
	8uI592RGFVUFmvJEiIiKHQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m19qqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52LKVKAT018502;
	Fri, 21 Mar 2025 21:54:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdr1876-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 21:54:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOArgzf7nn9xK3Bababozrh2WJTccYL5k4hTtKWCpuzdWHMdIkKaxcfF3/r7k+6WfrFsYmAKvMPFBcyEWfBepV72MUyRgUxDt9SiMlJ+BB82cYBarwQJWxAwRB1VJ9mQN+7T4ArI9pKZwgscDUy4bU7IY2qwuN2JBG5zqTyKdiUysYoP0L9uBXzAJuFecuifcjOZY0L3H1a3sMd7o6ZuCyL8vqG3hslqz+O3XQXpl9EgEp8leCRmk0+4rSl24nKcDdmzKJ4yz+deeaVniGS3ZjjRJUV3N1GyL3D0Yqos/0SYqZsArikw0hbcXyFmtmmLdGxvzsxLbzGQbEtaMw4WgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmP0Uk2iQ/RhVqGJpNWxQVOhjFWRkq0HRksYixUrgDg=;
 b=gzn+LHfP3P5UUn1Uqz5MfVnM9FGzPkZ8xVD48RYR9sTQsv2VdNt59HYAI5ZKFvwEwvM3XjKKXH81wptYMLfYFToW59Xrp5PIBB81Vwab/wvtE+FYBYa+cN87/HT2aBmdU9tVG1HKkqK9D8oqbrVpVU8Bn3PhRBx9V3NVdQVOOCsd9xLnINcKfJw8l/ccEQd9BZ6MmSOzIy497olLXnGqGh5spq+53T5p5UHbaR0bV4g5Q6rYvLsVUhqG08LNmeyS0rtxioYbQAo5/SE5CfJV1xklemSjMxBxmId3oVXc1WXlFU9LpdTQhWQet5XA0OKdlPDihHkeUoBaR7mmwQLAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmP0Uk2iQ/RhVqGJpNWxQVOhjFWRkq0HRksYixUrgDg=;
 b=xM7mvX/rbt1rXzDTP4qvUMkoyRS5Z5iLVYVLDjOzsGEAoUUOI4g3SKMgJqcbvBDSViVNKXXnVQ28KZ8xW/PGzum7XU2cXox/jwz/39JivSeQUoh8xinFwkUrT2yNJBJofmbo8y181YMF7jS7duzRkkmAX4QqOVcsgqkVBMTdvRo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY5PR10MB6144.namprd10.prod.outlook.com (2603:10b6:930:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 21:54:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:54:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/7] tools UAPI: Update copy of linux/mman.h from the kernel sources
Date: Fri, 21 Mar 2025 21:54:33 +0000
Message-ID: <bb49ab10e5c6462e88e07516dc86f0142f7f46f7.1742478846.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
References: <cover.1742478846.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0094.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY5PR10MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3ecaf1-4cc5-498e-64d0-08dd68c3023d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IZBoCxWiRNbfZ7ghuuVkIdmjgi5BLDt0rwNZfP1JG5DzeX270WvWWBnrIiwD?=
 =?us-ascii?Q?YA+TbHT2rmIX0rw17MZgB9FXcmbIfEFgRfvkN5Eqd7U5LE7E8gGe9RWATbxV?=
 =?us-ascii?Q?qs8PWr7qxFAzpAT3J+GpbsXSL80gHFicE8keJvVN6VrzLL0rRuIWjdBjA/9i?=
 =?us-ascii?Q?yaw/PK4xHVuR0NOrwyCZJvkgHYHdCKcCfsWYtodrxSBGARhBD53DZynXApAt?=
 =?us-ascii?Q?0J9DNdWeZ/CvmbmHYCkz70ejjyl8p3NvxuJihXJgsGbL2nLTB0uifIUSLMxt?=
 =?us-ascii?Q?U/ZCsA3vdrFzvJW6y/7Gs5y4xkfBDQB9m22vPMjegvKSk3HFtY1vD31yXYbl?=
 =?us-ascii?Q?UuYS3fhkMw0n/ix50YoiZ5BIoNvJ5wgJSf7RI+0BsZz83NMk/ktg15+X983u?=
 =?us-ascii?Q?Rm8Js2/p1HW/QcLqe7VUG53lJor0to3p5nPMwgbKWrd1eHDhc7pNCls1OJz/?=
 =?us-ascii?Q?EuFnIgwccc/kfPMCyfonBqhbnSXam0KPEyQOa11VFNAAtET4eUFyZW1phT1T?=
 =?us-ascii?Q?T5dFCw0L9htMA4/vp0pIjkfo2HgdckNI3czS5Qiq9vAmflV3auSpz63ioBV+?=
 =?us-ascii?Q?wPqNfEcoVhe1r2SlEo0Jsa95OeygDN/aZffe+q040Qcu0v02He8ofGKV/fVQ?=
 =?us-ascii?Q?tVKADI+xpTLoHaTK3iwKwVNwRqRwP0aTfFPYN71fKMqfr/dzHXvhZv2urBR7?=
 =?us-ascii?Q?Pm0AhKi1/srE7be188HNWFsVhUFsdBPNjfEz1ziB8jbw3u2RPSiVQUU0oUuh?=
 =?us-ascii?Q?yIcfaUmQEACdFtQ4scMNWiINYXUmA6N3ShP9/x+CmRASwJIvWYagtO13Tmbs?=
 =?us-ascii?Q?CmMkOZyzROCBVk/SpXtfeLokSCrpBdSbJh1WkDEbFIYQGAcFAtV85ovHy+z/?=
 =?us-ascii?Q?/1dDoTnir2I0ToPsUZY1Uoq0I2HP0cg9llWEeLLfVsDmuhvtbYJxpCO7dMms?=
 =?us-ascii?Q?OO6WXhxVJ1x/wWTemHm4oaLs/OFxTTkmUQaUKx9gJnWifMRhamw2i99pwgLp?=
 =?us-ascii?Q?fespBqtfMIE2ESOKdUxuvLLBmqGRcZZPP0uWHdQFCxX1kTF/01ehPtLansIy?=
 =?us-ascii?Q?ovzdcRv9QiC00sVMF3+WRG88Hqv1NAYbgLaWxWAMqt7pLNpjCBX0yaYXSeEu?=
 =?us-ascii?Q?o9nMg/nnwVrrWWuUnuCGqRGM7NdV4LHMO1kcUVxxNzR/q3mv8h0XOBJuUKiy?=
 =?us-ascii?Q?47vtqnZYNCzXm3nt/1h0N1M/LWMNwtw2RSvTt6eWQGMh0jvdfreIM50SRTPH?=
 =?us-ascii?Q?8RrsInf1U8iwW3+HkIOVQjmCuyd/VkTYGMIiava9589OFVT8ypp0P3HuQh+G?=
 =?us-ascii?Q?vap0+KciGtkeaHr9C5X8LbvBm75p94lNdI+VHDKlA9ADjqzzHkdEAg2uH7UK?=
 =?us-ascii?Q?96j8kKvjcP89TiEEecDW43dM6Iyr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3y1JznIvANWMArJHem72tiylTiMmua6f3Ho9mso67fqVGmB2/S4i9h7kWXVS?=
 =?us-ascii?Q?JS1MMgQPF+QuyDmtNEkFroYSG//VRSy1fWgDIZitOsEmvBjGfxrysEaBLHCa?=
 =?us-ascii?Q?4VVJBOd2+4mAQxtcgvvPsROsXNtC0wD5gU80KYC7DNzkOQxsf8BhPeARVDfv?=
 =?us-ascii?Q?SSQQecry+vc016w3zLvm5YPVBge9AgsoTCcDdWhp+nPHwu9vrgenzV83mInL?=
 =?us-ascii?Q?AwH7pE9uQescZAhymZrijmQDZprIja8fo08zwL7Mn1ccF1baCSwFND0Sphgo?=
 =?us-ascii?Q?BzQuH3pbLvpe+dTMYgyt159IXbwuWhh9LltN08vMTHid+KCvFlpQk1OBRRZi?=
 =?us-ascii?Q?5fgSWXEtVgw0PpWZzXiMJKdAIPTsuLyfAnf1QQJw1YgDPSOYhJplJtp4r9MU?=
 =?us-ascii?Q?olvqVrl4G5BtIQ+5OYeuZJoF/96QW9JQaDaLc7wK2tkwiMBl9LW3VVsFzLHl?=
 =?us-ascii?Q?ro9zm5gTZMIHUqRFLh2KQVEWdda6v4Q4pqJaiMjnni2Pge0XxrvltMieMGIs?=
 =?us-ascii?Q?Ch3bPY9cU9iaTS7OodPP/98lqsRASCD908DHd3NZFmutLBajigJ2iQxhRTzX?=
 =?us-ascii?Q?kXaNh8UIs4GCNQy0PoLfOSmBE47rv7cp+gMREb/yL8hSLK6nPUBY+ZEYoHrh?=
 =?us-ascii?Q?KbrmjfA+ij6QF9YuK7UvIzgAtJwNPVHNbhRIi+ayiiseoqe0+t0qubWmfBHt?=
 =?us-ascii?Q?NPLRLOKQuGjUD82BXod8iqw5FMhQauHC4in7tWXPB3D8ms59Yw+Jpr/xYctx?=
 =?us-ascii?Q?4/AQVFzHnaVViBuskzmX+egTXbygvzRJ9hNgkl4m6gkA5vwSP/9hJVdj04WZ?=
 =?us-ascii?Q?aUuD9wJ8JJdMhYIppRh8pEe0o34G60GL3/cTOnMcRYd0JaxKlZ8iONvWWeUQ?=
 =?us-ascii?Q?GZb2xdBRZ5OsLyKFaqAL+KXCNqAYwSGRjKKhbJ1sMJ/2RhQchNDzd633s/8Q?=
 =?us-ascii?Q?AjM0XVNqiaq5RxIz8URdZp6IrrChVk9SFlIOX2ihA7tHagT8cX3GZRnhGu0Q?=
 =?us-ascii?Q?mQmyrN9AaUs9qCo2q4ABueCJ/py5swWMYxv9/BGvYlhyPwXfD2EeTqnVJodO?=
 =?us-ascii?Q?vcpmaGhFGRKpI6w/oQvnajxY4HErQ5q4x/n0uTzjY7YA5rQ/hGJTQPCRVUhc?=
 =?us-ascii?Q?TqL4BOXph4IM8HwPJlgducTiQjQ454CmKmmzEwE/J4ohXtwIMWOAcxCUvVnS?=
 =?us-ascii?Q?MFF9rxh7NLN9Zx1uTTdH7kAkClfiElMvxQT8KQhXJEipHOQVl07hL12ZDovR?=
 =?us-ascii?Q?3q9Bug941ImShDLSUnUZJPys892O3a2DQmzFwZLAkuOE4uZae7PT0X9pRE17?=
 =?us-ascii?Q?DVLpVFYN56Or+z0RpvQ7LLVIxT9BG5v2+IKwAZLCN7yiVrZciaFoYqB5UFan?=
 =?us-ascii?Q?6uN30ffxNC5c4R/uMEMF5T9kJvay3xz2dKXb3B/1tEtMbyQx7d+52OIwE2s9?=
 =?us-ascii?Q?CqAQYgxLL9gaYoQ48z9g0+a2uNieNKyAwyBsZU7PApPheNJluF3WN9BWRMFc?=
 =?us-ascii?Q?psttMViP4jIs1pBdV6xNHDqlDTg66FeUZ8asiHHp4f+yy3yumeZK/30Ueqhs?=
 =?us-ascii?Q?uf6y0rZ8a9DlDlrH2t1yxv2mXg/CenvS0DdjjOYpUZ3Iq096YNYYFmXs9iW6?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KI1VcwJgtqIcjLbwA781xFIYMG7zr1xQWPoGz6rnMfIrUoYdJw8mKXtiRenY9mmR6+4Bzr6BVpA/ynWmDCBju7Un5uaa1jLV8ElzBq8hyuURF+9aq8v6lEJMZsOtTk4yKHCZR8y+XA3SkNsM/sFxtLy6rqWPgJEy2OskEW0trAozh7WhtcNsdV7dmML9TuHnKNCwGWS0mipwqN+6+yG54z/Ai84ZlHaBsL2BQccaLw1NyP8qSm3FIVrH0nD9Zh8X2PX1mbO/4Rvy8Mc7rZDIQWASHH56cJ0Trhx3xPod/XpR3/RRa8ycN7ZmUoXaWE4O+3f9JsKD4xwTJ/OVkc2g2YDq+SSkWSVxNSCqMfQWruZHSDrbsAEaecR5PPOIcKWMij/sU0Sq1NVTUM4te5WoNRR+mjVCtNG3bOlhLOCXoMTrbxUf8ytCamzqFy6yybN7RmoMiI0PUY2bmC3kip3qkCyT5EVczS+/N8p9JJJr4VRuoX1EV1a2rd+gQuNmtsTEMYCwyiSpa3XMJ7yfvP9BgHb2W1Mtikn8glIqch4BiyeTCYSUg2ATgfjVmhaUe7Vo4I6oktGb/u/egVmc8p1QRB4p7cbrDBh2RCYn3e1pQAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3ecaf1-4cc5-498e-64d0-08dd68c3023d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 21:54:52.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDsbnOo3BDqnUTOM2RyExzxbfx2C5z5f2Wg0Rw+oZ7x9xtKNWZjmIH7nQ6vLTcAal87Xktuuql8aJJKtSCRj3+RY4feXGMgdeIU0Oh3mqiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210160
X-Proofpoint-GUID: EiTMXTjRYeNsTXVLfofbJXzCDRuXyKEd
X-Proofpoint-ORIG-GUID: EiTMXTjRYeNsTXVLfofbJXzCDRuXyKEd

Import newly introduced MREMAP_RELOCATE_ANON_* defines.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/include/uapi/linux/mman.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/mman.h
index e89d00528f2f..a61dbe1e8b2b 100644
--- a/tools/include/uapi/linux/mman.h
+++ b/tools/include/uapi/linux/mman.h
@@ -6,9 +6,11 @@
 #include <asm-generic/hugetlb_encode.h>
 #include <linux/types.h>
 
-#define MREMAP_MAYMOVE		1
-#define MREMAP_FIXED		2
-#define MREMAP_DONTUNMAP	4
+#define MREMAP_MAYMOVE			1
+#define MREMAP_FIXED			2
+#define MREMAP_DONTUNMAP		4
+#define MREMAP_RELOCATE_ANON		8
+#define MREMAP_MUST_RELOCATE_ANON	16
 
 #define OVERCOMMIT_GUESS		0
 #define OVERCOMMIT_ALWAYS		1
-- 
2.48.1


