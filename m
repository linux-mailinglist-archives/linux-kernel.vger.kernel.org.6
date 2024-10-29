Return-Path: <linux-kernel+bounces-386997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6119B4A94
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593971F21745
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E7D206940;
	Tue, 29 Oct 2024 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DUlKRjXa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qtqRIvjb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA920607A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207083; cv=fail; b=H70ENyrqRXns0hD6yduc4khGSUpmLXYUPjGMKepfQQv+IIQIA5ReMurTEvqx9O2GkJ3cycU/ecl6ZtojUKks0jTJbmYSU63Eh9g/js8vSPyxVPUOAStSA5iAuyd2dYICaGM3I8GCXyTCIKypMIaD9XRBJdYdBeprcCBwT0OUrys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207083; c=relaxed/simple;
	bh=HcLxGhIhHchRpMXaUGiaHdck1XVTEXEh5b0UmhZkXS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i2kaOE1g5NinqPhPP9yONeYWA583UnQKwdjVV2atqPP7w04m/3hnxZjwzQCO98HmXP1cusB7TBfZRb/7ngQ39axaw77sxklUEtCn9GOistWilQ7/zrCiINdxU0GPQQ5qlTLYK0pkDkSV+qAMk0tMUQl9nUjSo/aMAL3kNlX1Ifs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DUlKRjXa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qtqRIvjb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCbsIM009791;
	Tue, 29 Oct 2024 13:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NOpeGovjLTXmooO9NPqJLSGOV0MyRnixDvLGLhb9tgc=; b=
	DUlKRjXace8bVAkzykjcIsgEt3lShvpWt6MxRxiTkrzKj/2Zu7VnAJ4Ov5yvpEbD
	SjPGvyMWeBD43nOHMi6hhbjcm9N4dpS3BErKhHfkMxOlSVosYOEDgxamqCXl9eck
	TAZUcgw61fqRkV1QZZP3SfbYFogCfa6ttm5WEij+7qs915advIKxMRXy8k2BOzQF
	qxacZhqf7TV1/j+yV/Gxvtps3ucedlFTwF92oXgyctPsBuyoy7aLFVWsTYClCjwM
	F/25Pu4jO/umvyUxt0T+cChNlCpy3E7tW9NpBr+HyeiAMRkLFXMU3Jcq4AmDgLXi
	CA6SZF9gJVJ1asVro/a0sQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grys5cx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:04:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCo1aP008624;
	Tue, 29 Oct 2024 13:04:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hne9krw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:04:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEtrW0I2sGuqMz0Rj3txYCuynfGcNOBs2vLURaeKS6RatYS3ZvFuC6l+urZoSUUsnNXycwa+Cqmf7W6JwzwEh93GL5h5wDLugVXdx8s++caohPHDGkU8xkeNK9KvlnwqnnajrXznRlxYY7I/aijT1aIwtBrJtuaL92Qi8QS3kwrj1ZKScFsLnWYfwCt85yKgg6DDjI+w8143oks8Pmhzp5FtVn8t9z03RTzV0vAl2hwx5+EMHEg3mrnrg5QdBUWxeeEwjSrdRx2F7eaE4gYBUtt0a9Ed2E57gbY+7QScqWfOkmcDR33mC9LIN3wX+ECpHCXDjgqyPQRZXAAPVwIICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOpeGovjLTXmooO9NPqJLSGOV0MyRnixDvLGLhb9tgc=;
 b=CKGvch7t6y4mRcuYtLU/OBadxtx6Hv7da9mShgGYwdAYdmcaCe0SbuJJrTHPWP0/3B81+0Z4A7BIGjqDmirPf3SuDipJaQMugo3dwLFTYvQwlT7LfJ3jwBAGaSxY+K0NoSpXCGoWrJTLN/UbJOGbbn+NzFHzWOpt7Ql6SnANhgb118AQMG4OGYqf0TeLmMaGhgDfNAKeCvRa9jhAkO5X4gAO/azQLWdD8CV67ZrterbDszhTmkBCWKwjVeWXqGd314KOmDtjR7YItno+gaGMgQaeRypRNLBjSDuIUoQ5AT3BPGPaBXNJKMD9YG1FDnRSYUA1vV+DMBwwFp1+D4qowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOpeGovjLTXmooO9NPqJLSGOV0MyRnixDvLGLhb9tgc=;
 b=qtqRIvjbXYf/fklarGlHnpdCNIVdf96c2SJ+/8tgzVHZCBrsKADNp/cA+qrrkUd/4Pr0tlUSbIlq28tsFv79x6OGdE1luETEh6CekmjxgAV9QB7trhKtO/kGaYb90ROOSVSkURehzmL2NKNsNCfCMiY8eUW591hoUslXndP30bY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 13:04:11 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 13:04:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH hotfix 6.12 v3 5/5] mm: resolve faulty mmap_region() error path behaviour
Date: Tue, 29 Oct 2024 13:03:47 +0000
Message-ID: <b3452ffad3cadd5621fe8c8f21a06d22f1b92988.1730206735.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
References: <cover.1730206735.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::36) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3ab89a-5004-4184-976a-08dcf81a2e49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x8ZzwJG/f74VhQJab1ymksESbFCWglwusHxqUU7Ji3Yl8CzR0/R6aQWfvsCS?=
 =?us-ascii?Q?bXjGXTd6lS9HAUEo3F4JuLpSB7x2RMYjyqSqOi76xqVTUFu0p/i+xOvw6aBK?=
 =?us-ascii?Q?6frLCVzdkpyZ+OFn57JSD+ocnD1jmFLiy61NdtlcYxCYgUfMcimrYJn1sdAU?=
 =?us-ascii?Q?Hf9aHkyDnF124bSh3a//VMG2SYV9wyWPPlgBc7li4p1XQRgiAUMJsu7//MJB?=
 =?us-ascii?Q?nyacDsTSzTxMju7hDvZEP4OFI+O/2yxwCEm0rLCrvB6Wv47FzzQ5zBo/Mc8T?=
 =?us-ascii?Q?amXQVplUIreZTZWfSuvBmXx/ybU7nDI18FcYS0hoa8IsdrRd+OPqhT/FrMFT?=
 =?us-ascii?Q?YouDd/mbW9RfpP/YhgtW/x+r2/MW/bH3KfbR5Rc7nCcgBD9a7fORC7bwMc+U?=
 =?us-ascii?Q?a+yspbHq86WvSoDZGFirFKb1ibExF49+s8flz8uWVb4ckev6Vvl8IaWuxnIg?=
 =?us-ascii?Q?1+befUQD64sVJ86qi4YhwKCBW5KrtB1zwazYRVnLEH2YIntYNHRPI5OgXpmT?=
 =?us-ascii?Q?U5UMcUDmQOkR0hyf/TtHzmKKDnMdIYasZUEANa2YE02Z75BCxLT+4wQ/zQL8?=
 =?us-ascii?Q?DiSHfe+tgBIHzquWWzXi/8MR8L3G5Azcp3Q/QwJrdLfvm8dhOKUcdCEjFwDB?=
 =?us-ascii?Q?yQ3d5VYvEacJVfcXhL6DJSsVQs882ukA/L1StWePsGkwDPsdll+qsHRt8DV0?=
 =?us-ascii?Q?PSZsKIoKVWpnuQ5IPFuKFKMIJlE3R2dUQcLANW7zPoUbxXo1wtm400LIywfV?=
 =?us-ascii?Q?I4H5nMG9scL/2Zet3hW24mb3Wm/VrL9YAOBHywYLUp5T4YM9R9AETlmqQsYO?=
 =?us-ascii?Q?EF3Gq/1Gk+PAi5ET6AWSOPoKHbgpXPe8XhY6G585ze5QpZ//hoD8pKQh1dgj?=
 =?us-ascii?Q?3igiYHNYjRgcx3SAA8b/DmO0zO0fnwguzH/UvKxlSYbXbPejGspmNwGis4Eb?=
 =?us-ascii?Q?hoTqidZpGrzR4o8FtfuFPGux2UGejF6m+ND1YHj61dOdnyONvTyl5Yuxa4yj?=
 =?us-ascii?Q?NE7sOGo9axSvaCpYiURpSL1MR+X/HVhHlQbJw1gQaN2Eei+lrXy3AOUb7fyp?=
 =?us-ascii?Q?ZYLjNDtizy2lnPy3pETynIW67193dqQtBLCxa9AcO/wHhhcUtBf5RFMOa2iR?=
 =?us-ascii?Q?CgHXnuNNwYgU6cdTDeb0PmWDEGxUm5NA+/npz6GzUxOOgdv1mSPmCi3ws1hI?=
 =?us-ascii?Q?uw+RjQhhzWy8PX5qv5WR1OEbkLO1hhv2SBOamV6U0CltjMzySH0454TObQjU?=
 =?us-ascii?Q?CM8IXnntRur8lU0UWrWBY+qzM9fW1tUoRTsEY/zN0yao9tnTV8TmH7SV9Y73?=
 =?us-ascii?Q?nS96NPL0vlvYIXC6jI272osf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XKpfwsmYC7mKnRmV4XdXyDuuuG+YOTK46MJ2R+Zgnv2m7xQmk/u3kQGTLi5y?=
 =?us-ascii?Q?Ga2iUScQTzJpEimq4LV94BXTnJq7IXP9LMkTDb5UrrF6lN5eH9MlLgYfduEJ?=
 =?us-ascii?Q?Tz+0LKAe0Lh/BtUFvdxs81tL9MkDoywpL6AQ1wDE7Pw1dBNchfbXBrIZwIz+?=
 =?us-ascii?Q?YsIwl/Tjwjq6QkWjA3pSVbifdLP9mqpejQ8tUU1yTpEI/cbeiWkQKDXjHaxA?=
 =?us-ascii?Q?bHT8+CQJIlaVX663PoZosDnadMee6+hmySoFMq2shkro6YMuDHIB3wqIvocx?=
 =?us-ascii?Q?I6aLJT0UozR20hbQeSS13JmZtXBMn37L3h1nVcNDQJEY//nu/VGugfE+0C8Z?=
 =?us-ascii?Q?FeNlNnXz6uHzYN01Z+rWoR8t/D3lglAbO5EZLWtvPhVzov2I9wozlj8cDI7p?=
 =?us-ascii?Q?OYnh9KqYn5tq8DeAA0cJ4LZl6CwmcFG9NWKFpU1Rxrnwfw0a+kOi4o+Bs3GX?=
 =?us-ascii?Q?OJpJS9X6ZkwoPtMFG4HFaPZwSyn2N9JBY6XN6Zl4X9GUDVGK4yEmzZLisiiq?=
 =?us-ascii?Q?UHzj/6/+zLRwbvskwagzcBWLg2a+jduT0A+8hWasMV6IfmYMW+MnFSGpA0XS?=
 =?us-ascii?Q?mfWrTfWyL4ZFyHh+MkK4o9BeEoy3hyc0rw3DGwQpwEnpXcUDF5RsLrW0TNdF?=
 =?us-ascii?Q?srijvcKyLtjta3BAQkixEANAQE+GoU5P/H49+NZLA4ASNsq2NGNL1/QY789t?=
 =?us-ascii?Q?7G7hkF0D9slwwAR/xeqPHaWqwMEnLRRZieCnqiB8eAWRlc2LlvYtr7xuvfW9?=
 =?us-ascii?Q?X2+2vBpNMPnnRsZrtRGCaQV6icDbaiR9sKYGS0jWQrvtAuPmHRszoS0qzddF?=
 =?us-ascii?Q?0i75f/wbKe8Pnb2Zt0C0wvMKj6aE881jeNr51z9uwJPt8OykcKq3wUmP9VFZ?=
 =?us-ascii?Q?nsCVuOCxSb8f+3xbT3gxhiAZj2nhqSsV2W5xFzO4H3Daey65UwAdsMTnJeRt?=
 =?us-ascii?Q?f0Hx3X6PbX4+RHVzc7v8MOcWzOY0KAnZ6YEEDxr2jVOqEQk5YF4OvenyjCNt?=
 =?us-ascii?Q?DkMCyIy4yn/i2wcSxQ9OZPm7953mzg1xQU8VYPp0FFpRdRXg6RaTQfaiiy5Z?=
 =?us-ascii?Q?O7ocQn8jRU7pOFr6ZQB7CHq0oSRr59WmeQfvT5rp9cAwUE+Za2AZD3n2keny?=
 =?us-ascii?Q?/29TgO2zyznxgjk761ODSXvdOryDq+rpZJmCqRxkDjT7LqFSEEs+rCOmKpuw?=
 =?us-ascii?Q?DiO0QTnuqwjr+Kc51QNJ80EgnURHkGp+u8OSys/KNuV4N6Hw3MgazleZvDb3?=
 =?us-ascii?Q?AbKLVp7uv4cTC60Cmr3uAcwAlJ44pfX+kX3+lzGjZC+6RlmJUUICyXGPr2nP?=
 =?us-ascii?Q?CzHkL1N4Ptb+8/Od54vjklSTWW/LXqpzO/jK8xwyuFpuYRv+l6OgF9HFCW2G?=
 =?us-ascii?Q?mfcqZ/BnkmLQz7LWjx7VVGPG2vKt+7b+5P6sDsEZi6Emu/Q+uThh8e5RfmM1?=
 =?us-ascii?Q?lm5bOZQre8xpbiewHeLQJuxy6y7010slxszL1LIARhQyA5nopLS2Gn64UW12?=
 =?us-ascii?Q?JCfFKx1bxRK5R/sZofVfT63E7kolo1qG9NRLTs2fXIsKg5+FhJdxNba/kbwg?=
 =?us-ascii?Q?0QIpYGfZGhf3NStasl29GmyvK4Lbu7IoCQomcVUMgINRXtV7Qz2bh0RbOOZf?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g93Oq0gyhX+fkBFgYEfKxTvzxqUajVe6qm17MOl/Ra68bDMSXszI2QKkxqrHvrvQGtAqtbLpqZBR04/k6eToznG1gwii6qzs+uir+WQShMTMFiPwE6T28mCGyWPws6ZZqPSH2PTi+vFE1iCRL6Bc2l4dj02IEOYUbQpgXrhvpgoana40ceLp6dHgi3Wfeakq980mE61Pm3ZdDspHTHhnszP3SapgKFW5YhdF5/dGFFdj1qo+cU/h7vBSe+n0WxbX695jxKIDP15Ok0M8f7tbz9/afYmrHZbI96RK6yYXt5WmDeMrYnLgwirsKJWZzRMkknMiskGEMSyKM2JiauRtrm9nL+KjHx4SqSZqr7xbWcvA2N3TMkEn8vrNwp8CCVI38pHUh4f8O69OL4WlR0r2PkKZH8YBYDGxXN0sJBVHozYFItMbt2ZzvgNCfIyLEAolxFrVv4RRyHciVMM8mYnweSd93Z95b1Pikbmcn1cI577Gnm+C+HeCYipx4Jm+Paey4EN7M143v0qJim+t63Ur0Zh8ipYNvbiPrnFUvnvGBZRa70aSoxXW2po0Qvz4mIfrOy1UAGYLGO74q0OS3ot+2N8ZApxV4UeXLN3upMOTY/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3ab89a-5004-4184-976a-08dcf81a2e49
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 13:04:11.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7LiBK/9APHSLfFps7S3GxU0fkARICdxv9fyPFWcrbffvvSXUU4euUB+MIBqzAf05U9Po7YBweVic4r9dMinMCXvK2KJd5WbrGYw0CMyGBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_08,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290099
X-Proofpoint-ORIG-GUID: 8C8GAsQ0ijpbmrqb5qCaOij2w0XVgvEu
X-Proofpoint-GUID: 8C8GAsQ0ijpbmrqb5qCaOij2w0XVgvEu

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently observed
issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 119 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 54 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 40b5858ae875..c078c73e46ed 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1358,20 +1358,18 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	pgoff_t pglen = PHYS_PFN(len);
-	struct vm_area_struct *merge;
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
 	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
-	bool writable_file_mapping = false;
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
@@ -1445,28 +1443,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vm_flags_init(vma, vm_flags);
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);

+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
+
 	if (file) {
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
-
-		if (vma_is_shared_maywrite(vma)) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto close_and_free_vma;
-
-			writable_file_mapping = true;
-		}
+			goto unmap_and_free_file_vma;

+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
 		/*
-		 * Expansion is handled above, merging is handled below.
-		 * Drivers should not alter the address of the VMA.
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
 		 */
-		if (WARN_ON((addr != vma->vm_start))) {
-			error = -EINVAL;
-			goto close_and_free_vma;
-		}
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));

 		vma_iter_config(&vmi, addr, end);
 		/*
@@ -1474,6 +1470,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			struct vm_area_struct *merge;
+
 			vmg.flags = vma->vm_flags;
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);
@@ -1491,7 +1489,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				goto file_expanded;
 			}
 			vma_iter_config(&vmi, addr, end);
 		}
@@ -1500,26 +1498,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
-			goto free_vma;
+			goto free_iter_vma;
 	} else {
 		vma_set_anonymous(vma);
 	}

-	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
-		error = -EACCES;
-		goto close_and_free_vma;
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(file, vma->vm_flags)) {
-		error = -EINVAL;
-		goto close_and_free_vma;
-	}
-
-	if (vma_iter_prealloc(&vmi, vma)) {
-		error = -ENOMEM;
-		goto close_and_free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(file, vm_flags));
+#endif

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
@@ -1533,10 +1520,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);

-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (writable_file_mapping)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 	ksm_add_vma(vma);
 expanded:
@@ -1569,23 +1553,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	vma_set_page_prot(vma);

-	validate_mm(mm);
 	return addr;

-close_and_free_vma:
-	vma_close(vma);
-
-	if (file || vma->vm_file) {
-unmap_and_free_vma:
-		fput(vma->vm_file);
-		vma->vm_file = NULL;
+unmap_and_free_file_vma:
+	fput(vma->vm_file);
+	vma->vm_file = NULL;

-		vma_iter_set(&vmi, vma->vm_end);
-		/* Undo any partial mapping done by a device driver. */
-		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
-	}
-	if (writable_file_mapping)
-		mapping_unmap_writable(file->f_mapping);
+	vma_iter_set(&vmi, vma->vm_end);
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
+free_iter_vma:
+	vma_iter_free(&vmi);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
@@ -1595,10 +1573,43 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 abort_munmap:
 	vms_abort_munmap_vmas(&vms, &mas_detach);
 gather_failed:
-	validate_mm(mm);
 	return error;
 }

+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Check to see if MDWE is applicable. */
+	if (map_deny_write_exec(vm_flags, vm_flags))
+		return -EACCES;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(file, vm_flags))
+		return -EINVAL;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && is_shared_maywrite(vm_flags)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 {
 	int ret;
--
2.47.0

