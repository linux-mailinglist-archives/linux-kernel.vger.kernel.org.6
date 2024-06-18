Return-Path: <linux-kernel+bounces-220176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B603790DDC5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB3428381E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4F11891A6;
	Tue, 18 Jun 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZpAl+8c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QvPaDkxx"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970017921D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743730; cv=fail; b=Vm1VZfXxtaGimRvPrk/7oC8kiUq20GijugqPgsjygieKqm84hAUztOa+LQ16xMOA8MWPj/Xbp4q8oUuypad7e7z0KTI8qV+3W2lIfK+Cn9PAadt8qq85X9ZApvoaYtGo39dxyNo1wRAS9vs9UBR2ul8vX/d7t4/cah/FWm8KHMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743730; c=relaxed/simple;
	bh=saRwHl0JNYPWsWxjRf39BL5ZCNqg5rmYyLh2HfR/NFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EfCdJ7uFNoqHhURoTt/NClu4OER39u7PPwQdYZpf/tlHnhL1w9mObJiWUU4ckWDE2ayunWkLApkOYeUXmV2/C4u/vo1vmhPnLgL6JOxX6XZA3SKmv8ZqIs7pH9j6BsBaSN9YqDsWV/O6sgnshbs03jJgSk6ag90pRByAjt7oju0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NZpAl+8c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QvPaDkxx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUrdR027367;
	Tue, 18 Jun 2024 20:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=MJYJjPUqW3BO7LGUv4dPuPylke1u23RTvz/wCjTjJCM=; b=
	NZpAl+8cWoYNRR64T5f49itWdrq9paewg1tm4guIvf/iKP8S0MO2+BZ8oq7YwYHn
	diPDzRiIZpsRStc/lKzMORZfkt1b1hW9Lck9m3DPcGKm501VuJcwO3iLDtuAsHlu
	83CA6+u/++Ju6wmGFGcnSMIXlyVLmruJmFZ2kQrXAUlehBJawKQ292FIXvVQU+FJ
	1Jxl9d4haacBiJjlEts2KWmNiai51EjtXpKaclre94l/reLARcbN9AbQJT8mg7d9
	bD0TJbD/4SOfRrcUqjGhy4ZKlQQrUTUo0xv4osrHstO1Uepma1SQNo5Ni7xfU5Eh
	wDMp+oTRzBlYlOO/AOx66g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys30bnvn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJeuRe034707;
	Tue, 18 Jun 2024 20:48:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8p6p6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9sE6HluxPNHuP92Tj2AwC+MYw2idhpE1IHGEWJyioGgg2/UYvYzF8t09D9E6udCzkuJOYpQI0WEJp2CP4DSb6Aq0hyn6TpR2+nGcuQ3h0Elk6gi1OJxUXvoGfA2+4TgHGpnP6Sy6eJIEn3oQzkvBgW5qyEt/aXSGHNaRrU3v2Da828Ub4ki8naQAoGTkUT11o0chiK5wly+HfgBBW3I/nmGCP955hMwILj65ElxfH6+N+8XoyqCz2lkfbogLL82ih/fzr1XzjmbfV3JvgVbZ2dp9BWPjZe2PlFnxflE79Ux8mnjrFsaJLvtDR7tYm2BJLonndd5OV+BmBrRsX5QNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJYJjPUqW3BO7LGUv4dPuPylke1u23RTvz/wCjTjJCM=;
 b=DDRtO5v6oQLSu07iLBEb/DE3voAHHfhPo6gZdp2ny2lqh4rkMm4YjHsHHjTuwh9EnLOUQmcbhmpgo8IOUaar1jOiYIMQLCexI6huw/F1KHouRcQhkz9FF1WlQk56Kq0gLjnxe6zKR4qm2kE+2RMex3TK4b5jEJ667AbPAaBW8Aft89wemJXNHOVgivD6fAyIBfyLfwG2G+DPafx383pOfzyBoYyHenm8l96gDpHsuTFs1PKdjhVa2mLr7iOU6jQ82y0N4N2bPypSWogeumNmgC3H0tRlDkxZoJRFhMQeybH/ntCvHbfIpNFd3gpH1/5/E8bS3NaJTVPzPfzgK8mHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJYJjPUqW3BO7LGUv4dPuPylke1u23RTvz/wCjTjJCM=;
 b=QvPaDkxx2tBdLoeMby3Tu3gLyhVDIFRMDc/xyygDMrOVyjYWahD7NvKYqgNps3aYRE8HHFj6DEMuRWwRuMnLrXpxbjvNe2YEnTkgU/MZiwaWVazDFrLTzK5A862ooy7YexIBobaDmiSD73PojF+MzWbLcoy1scRSm2CLuollStQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 18 Jun
 2024 20:48:03 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:03 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 02/16] maple_tree: introduce mas_wr_prealloc_setup()
Date: Tue, 18 Jun 2024 13:47:36 -0700
Message-ID: <20240618204750.79512-3-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:a03:505::19) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b24240b-0a86-48bc-100a-08dc8fd7f2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VsrHLlJzrsx/vWSM6uBLap/C4V7vfxCZP88lS+gMIF/GGXGjD1GF3vifd1dQ?=
 =?us-ascii?Q?o4jGuH7J6DhTmznMKT5NLcIWavDvpcgzgWKcmhN1y+3JknD29jCLGG3PTFT3?=
 =?us-ascii?Q?H2yZb02Mc5XGr5K9coCDzPfJZR+IHniAzZnAjswEOC3p5nen3vCVPLoTLHpF?=
 =?us-ascii?Q?66GKxWowoZzpvcsxj8ZcCRZdS35YGspPa13qenTGpAo+So4Ux5/sh88WsJHL?=
 =?us-ascii?Q?mXxrVb9IjxWnXKJxbi++HelLQzkycV8jiqP/u0B46mCg8vrvfd0QGV8I676F?=
 =?us-ascii?Q?c+NRprp18VaQ2a2RlSairpuYE2O3ZFFuPnrmb56rFTe6ev8ioR30+IPETHen?=
 =?us-ascii?Q?tuYZHl85nPIiSxVdh6tnNS+jocA9MdLycfoa3bYBU9E5CpWFtOiGDASW7A+4?=
 =?us-ascii?Q?jNN128zljnLlMnw63fahIKfqroCyJ7iC0ZJQpBctIB+o4KD6DAJcF1oL/wLn?=
 =?us-ascii?Q?qmBpOT7ZiHk7TS+AmPd97UsG7cwv3ezs2SaX+cyRckGQqLuxEvXTaSDgzp4F?=
 =?us-ascii?Q?LPu7QaSqz7pVt3uMSRSeuF8QRy2Av+vGxJnXlx3E4khR1O69hYe3u+Hfu8D9?=
 =?us-ascii?Q?XKTc1wX30M5YdFOofjPiBBC0FBDLgVHbfDVWU7H0vEkZj1pbdXsoCPqFCr1Z?=
 =?us-ascii?Q?j/Km0mPwHtLZPcbrfePXEflTeO4rd5IwAuJD/f1TNkMmaiwyiOzgfHa0ulRw?=
 =?us-ascii?Q?2UWRzZVyGZFueI4x4VmeREc+6GjamvmuGIe7CvcxDQAbcMsvRk11OufW6Sh4?=
 =?us-ascii?Q?L5EOSYdeXWrQMvgymoagXoZBEw/M9NdwpSsGxv7UitCEYM+R34Soq1PFxbT/?=
 =?us-ascii?Q?n0U1nFKq+ifJjz++vpAXHspMVJhvmCg1gTqIaL/qivFHecSXaFHNwlzBO1qf?=
 =?us-ascii?Q?WVfQogv8df17SzncjtXy5YN8vpdZfNv9sYJsVjbhU59KLvjn5+fhO8RyoE/e?=
 =?us-ascii?Q?5OEjDB286oT5Fs2BOZrzZOQXnB00e7Ng/9Ezg3BClde6MV4VSDvJuNgB3QOi?=
 =?us-ascii?Q?N7nf2viNd79PPsxGKGUqR4NIvxGBRRV7OyBVN4TtaIqm/B4+9BVP8N3D8Xh1?=
 =?us-ascii?Q?tr2gqKK/toMYCcXHoQUNOb2uiW2vfB4/wKDlraSl8S+xcuggIfBQ1kjT+9u4?=
 =?us-ascii?Q?l4KKnW5ConCZKz287B1OsLgGu884ngQR5OzRcknei78+7mfXQNh1D9Br2l60?=
 =?us-ascii?Q?7KrENQ3R7jDy2+F8tSBOoq0ietIBwjHL2jqg8FP9dSHD+9e1MeDerNNGlJlV?=
 =?us-ascii?Q?u1wS8BN9tacilQYLPkuCBtLW+qrNFJ88vGYFRPVwOKB6un+S9qcaHCpKleiK?=
 =?us-ascii?Q?WyYSKup1DRb/qTevO3nQVdQH?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j/5S+0YiPzYcGmW9ZGvhUnBgEvBgcrmDOy3K9p4+elmoiGLjR4HLFXt6bHk3?=
 =?us-ascii?Q?ozUZtM199iyuCfaq0hiiyTS3i5CePTtHdAsVerKktg1NjycP2qVrzgvip3vS?=
 =?us-ascii?Q?nvLE10/Yqfe/61jHVt/e3GQ7XFtGIq/9UkC8tD+5QYOpV7ZRRAN9vPXFuiVh?=
 =?us-ascii?Q?bybRv51HAnhCrnViFIJRshM2DyEi9mFCRyiv98A7nzr1bnm2la8cp4FtHgJM?=
 =?us-ascii?Q?WpAsxrxSH+0Is5FzQ3iZByGZVhLlOAM8OtO+6OtdDLGsrD6/722J7Jk4sCSS?=
 =?us-ascii?Q?IMuHqcf2Qorp6ocWeLk4rQ4EcOkVdfh9VAy4WL6St7Fg4y+cnsByISoqHaH1?=
 =?us-ascii?Q?BBbPAYVzamhBZUzobCzIgg+R3UdjCfwywpkVMHBPAm3hcpS2XWvhxWPcxF5u?=
 =?us-ascii?Q?pDlZWecfEgGh0j58db8DeS2iWbdWVh/Tc7bryOCHbvRk4kXpLY9s/g/PCbWe?=
 =?us-ascii?Q?Mn5Axss9VVCH7sUGClvuk7BJRI1I5n4RfDuTjAnkpoRWUEomTECNwh3yXRir?=
 =?us-ascii?Q?/iH2oVoWluEmSR3IfX+VBQ6e7ssZPHYDGNBhNGVl0HvgyGUoyFlWuqMpa8wD?=
 =?us-ascii?Q?dpFwQvpCa+gA3I5wu2bsr/KISZt4WD8HhwF1i+KVAQjj+YThADHDz0n4jtke?=
 =?us-ascii?Q?O4pRR8BU84Ia5q4Q4GwNO4Tix1+W+6QhTXwa4C38tujYupLXy+uqzfFUNgeD?=
 =?us-ascii?Q?g4L28Q2XnlRfJqTJyF/wZgKqQ6PPVHhWorRNYi8QgB7wB0IcTKDj9j7Z98K+?=
 =?us-ascii?Q?Kr53zEhgjAFbVZs8mgNwqDcOF+n1PyeI6DuicJJrXixJZlN6j3rJ/V3WZF0d?=
 =?us-ascii?Q?O0VmkS3Us2xL+YSOhTK1xBR75UhIj8cPlGrvb3o66w+/BFZwh3QcjdUZUv/b?=
 =?us-ascii?Q?/nrDUGXsIv/OxLCrwtLqf4CW870lFzeQMo0gbLwWLeeohogZ8rdUPc7KcArz?=
 =?us-ascii?Q?jgzkdJ86A2RN9oa+gmQhxAtruYzLxpLZMdQUP52PEW1dVqkJI/w6fTaMUi1i?=
 =?us-ascii?Q?WaNeqRyW518nrYphoGziGYVr4xjM/hUThYEbL4kmMo6jGrjz4z5bVZFm3uGz?=
 =?us-ascii?Q?VgBuRauqwgkU4SssU74XYwXzEOJHK9SFMc3es8q0qSlRSpqMVm41lIrd6H9r?=
 =?us-ascii?Q?e/RbQXo/qtvhIvTfKu3OsIqsgBEHRiL6/rQi0rXkwr8XsGXYq4uex2lQDR8y?=
 =?us-ascii?Q?QWil9V6i/B+5+YdJzWaALyWO9kivIUbq8Ob2v1hJRIZUdruta3FNHeJyzDas?=
 =?us-ascii?Q?PdmeX/EKOAklkKafetBE4LHrzFyaxFdeR9DGCJ6KR8x3LkuYVoffmh7/4CeC?=
 =?us-ascii?Q?wG4hp2pgfDTyqJMy2WWn9Jt8i+DYNps1+oLmEazA3vtE7DZVyxOzsbaoBo/c?=
 =?us-ascii?Q?rUA7amQudoBs+T+KqmyL4dR9hMIQDh8gxiHQjcxOjTAP9/u8HK+mDzqVWa+9?=
 =?us-ascii?Q?oKFMLec0pMVoTqaig2+P5iAXSI05A/A/fO4OCfXNa5UM/RXBcS9I4/8K2Iyr?=
 =?us-ascii?Q?sIB+dLnDVX9icC/lpKbvWe5lSzZUAOgfGE3AUSpg3+h1EJsGTVxklLS/rrEI?=
 =?us-ascii?Q?XdegATAJGu494TBubjp4pX1qRa9RiNEqNWoRi3LpV9yIbMEWKYPhegbf1JK7?=
 =?us-ascii?Q?uUSlLyVWCtkPNcv5v7v80Nk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lIuhycS8swCnxndgfDlXxia+i5ePHA44m0/nLUg8/QIVXAC5MYFbK9FPXpL/cP5ks6J8jIsk4G9rEhdbKsTfp03V2o38uAamgHo4he+9s1bpxwLga/wHjK7Mei4bL6F4YnitwsTIBKs8o5wJuaPAjYBHRJk6kMUnZGTRP4OsdIeVVg419Y8BJFF1+JmIU/sBmViIHo/AZYUuXZiCx/gg681crejKjWliWB5rioc5/AtfAF2KKaV5tyKgt/ePv8dzyJk9dGBX86fMePF7J3fFG2JTRDajl+IiUO0KmJVBJMmzSonUArsqsYrpSWcf9EAOScuoHfEL4/vzw6pqQjN/iCMNSLTFsc/EqucW5BQZhTPtfzLne6TJYW9VWd3KPW/pQOVY7+CAj5EigaIFwG7m0R0xntToneG0UET4bzfz+H15nvMN/NpK8y8gIjY2jGq8f+kELDZlyfrDBPHD2BFGkWULytHDBNcyYFg1mgw5pCz8nlRXoWvnQrByivdEO4T2/w7Par7+wFV3Dgo0tFi/JbBPgqmtrcJrZnDXz8OrUdB3dNiM5mgRiHP557BkYWJtY7YpR31r5NpjgGoLCtouxx4DbU2c70DZYHwr3xYTxrU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b24240b-0a86-48bc-100a-08dc8fd7f2c7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:03.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFpO+ff+yh4OeW5OAgdCvQG4e4p0Xs42Y5MnAPaGc1xjTQA0aFa+fYZPmv91BEOaOJL+KeMsLGvDvMG9szZ07n/8YHerLMevPB+Bj5/bneI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-GUID: _0QO2pSvox6TbE45FSyPfYKYbQUZpuPf
X-Proofpoint-ORIG-GUID: _0QO2pSvox6TbE45FSyPfYKYbQUZpuPf

Introduce a helper function, mas_wr_prealoc_setup(), that will set up a
maple write state in order to start a walk of a maple tree.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index aa3a5df15b8e..fe490ec9067e 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5399,6 +5399,13 @@ static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 	mas_reset(wr_mas->mas);
 }
 
+static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+
+	mas_wr_store_setup(wr_mas);
+	wr_mas->content = mas_start(mas);
+}
 /* Interface */
 
 /**
@@ -5504,8 +5511,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	if (unlikely(!mas->index && mas->last == ULONG_MAX))
 		goto ask_now;
 
-	mas_wr_store_setup(&wr_mas);
-	wr_mas.content = mas_start(mas);
+	mas_wr_prealloc_setup(&wr_mas);
 	/* Root expand */
 	if (unlikely(mas_is_none(mas) || mas_is_ptr(mas)))
 		goto ask_now;
-- 
2.45.2


