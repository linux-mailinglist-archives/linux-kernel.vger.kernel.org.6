Return-Path: <linux-kernel+bounces-244874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEADA92AAB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678E5283331
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C1344C64;
	Mon,  8 Jul 2024 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cL1tx+WG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W5dfXI2J"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437D8A29
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471420; cv=fail; b=KjYUUHdj8d5U7HQ5Ru5TxBhjZUnT8wMEaBh5OTa0axlLo4XLhaSFIuzKWAYupEk1pz5BWY1N8qYahRB2afA+M82JIFoW93q9M0dL88L4cMslX1Zb+6zOh85w3oA2Wu80RarfofaRnUESBFsltR+WZDaWT+kaZ4hk5dy57iElzKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471420; c=relaxed/simple;
	bh=FMew3vFp7GsldjBZiOiksVkVZOb41+ykr5m93TuqhVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V7cXrm6lDvsnz/+fXX5T7gqPCUoh+T32eAndd563ZnH0vdAWbPqrS2OFzk+Aj/3S2iFGKlcTwkh4ueWlV+hG+YMnjRyKccaIIvEbmP/8RZH9EaInxJ/AlnheOvtf0vJJX5WLZqdUKeMbamSzss4CBO8OnCEZ3VdXefts7Tpn4Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cL1tx+WG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W5dfXI2J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468JfYm5015844;
	Mon, 8 Jul 2024 20:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=lmjJSJhvGFNLAE4
	330UuNJCvo4VLlo/OzCMvHFwSuUs=; b=cL1tx+WGxy/rgjBXyGNchHbyJZjtku4
	c2judEoHtSqiCcBYZJy+oJjbnCq5jHNv+GfzyxMhO30EpIFry2aIpjVQjKyVFV48
	sqSwohPiHFupKrOb0lXelgAyUFhvDpCewAjm2+FyoURc9HPyXQaKmMRFPC0B5pIz
	lk2Hu7f0zXnagU3s55awyO7bg6FxjYhp6yM+klO0GDtYtuFCgTssYXE3QWUL/IyH
	95m07XE1opqOFiU4lyY5+wFuy6VUhVozU1W/VJVUp82s7a/J0djVV/Q11DaGd5qI
	f/p+5qulhQ1kMRRgI2IQ6cH9G/ttz8Dk4U5KcUUgPgkfE84qOWJklkg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wky3m9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 20:43:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468JjLRq007626;
	Mon, 8 Jul 2024 20:43:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu26y9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 20:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA8zqwKBGwsTRmEqV2mbaJZID8EjfQZz6o+GQuD52hpoXSRvZ+cVIOd330v35kWuO8yyhQ+3IyY9z1IweMFMPMzsabmW4tr+CvjFEndcURUV2Nf1NzuCN1QcuAt0JnZCopxkrX9x9BFl3C3nIoeCCTaGh80kDqAM/rG8DOUwdEiMkmNQyFM5TSgOrVpayTlLc5oUXdWRtGOgs5pDdWlqa3KM1NkfOhwBbb7ZTRU7a9YPIngNPSF9iM6xFPY4VYuciRBYUhqortf0CeLzXUbKE024RddqDlb0voLhfC2t5V409aoa0uOFNpyKQBJyEnbCpZgImROjzXmOp5daX62FfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmjJSJhvGFNLAE4330UuNJCvo4VLlo/OzCMvHFwSuUs=;
 b=MlqZLmIRwu/jpmXqmraaBv8V429lWa/Vb26B6ecasP2JTH9n5cz7efKYf0opdHNQQpr4x6ZkdEWr4qQA7CZ+rmrNANXQAYToY9NJ8yLa0w1qq8UWZPR+db3/XKyr6ObJ1mJsiBI4uNLabRmbAO6ATG2IOFdKZkm66fL5XXGofJwQhPMlXqns0cwSHzmsIrTdbe6xao3TUuojqB8HxNIRg/ZaJLYJIUay0TAHbU245lSdyZaxwqudCkRteA8mIzrRELDKnc4Hs4gNAetePGq1EwXflfFPpk2vMJw3DWwb2FEksie/YqoE7tCP3NoUebrr8jaixyQrO3CFbJXiMRi+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmjJSJhvGFNLAE4330UuNJCvo4VLlo/OzCMvHFwSuUs=;
 b=W5dfXI2J8O0zRPmxoPDkuwT1nBBwO0UFgJEY80Qu7Djwy93MeL1jBJ15mGEhomC7xHj1EmbDxFkCEfbgdhoSkdEXSCDrRs8GF9LMEMPmvhmh+ToNNwVqKYVTqJnXbFX2tyUXPBs1Y5mOXf+Fe+vZou3Tz04/Xjwy2Wy5xokFGB8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB7085.namprd10.prod.outlook.com (2603:10b6:510:279::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Mon, 8 Jul
 2024 20:43:18 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 20:43:18 +0000
Date: Mon, 8 Jul 2024 16:43:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 16/16] mm/mmap: Move may_expand_vm() check in
 mmap_region()
Message-ID: <e5ldsusdn3som7wn2rw76wtrhnlrxk3vkyk3iyimh6qv3ptvwu@24zfmamllev6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-17-Liam.Howlett@oracle.com>
 <8fbb424d-a781-4e61-af7a-904e281eba8c@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fbb424d-a781-4e61-af7a-904e281eba8c@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH2PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:610:4e::40) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 377422f3-02e1-4cb3-c7c6-08dc9f8e9920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TwDquN2/ssp5kSmwKrTwFUuL6HHDkxzwWAN4kEZtqJ5Ip/+QG44ASJmw07oF?=
 =?us-ascii?Q?llcOQRnNej9WQsHbr20+2vwhXUqheaWEtilCpjc73QoTMnX6qXHOxDBdnZcZ?=
 =?us-ascii?Q?/7KWHjee71OmzaA6ONaWdeaYQonHdjGlsNIlzOd0ZCJAqGZQkfN7Tbwhz1ei?=
 =?us-ascii?Q?U+mN9dwwTnDTu4yfY3DZl2tmYbFiKWZyZDoj6hIXP7qwS9iPhTdKuQnHaWXZ?=
 =?us-ascii?Q?fcAQXP1jSJ43mSDmhp8Ggmb+gVpQ6uDDKNuwKK7+ESzN6drOhlKl050aZo5n?=
 =?us-ascii?Q?6zpzgirvutyptcK7q4gYg2ah+mRfjwzTRoczypWDHBzzeROqNEbxxAiO2dpC?=
 =?us-ascii?Q?9dBAfiGX7VlSXZ6GC0kniIRGLUkaXvqIzdGIi+VvnXtHfACSsbJpx/m9S0Z1?=
 =?us-ascii?Q?oZ3JUBtc94U2gAhseewJZHUGgvWxNpfHw3tB+hUT5xAh1isp/A5FqZ/1t9c0?=
 =?us-ascii?Q?K6/X7DReRFTrISUlp+cE7DMVDAKofmjAGNLSWPMIAQaVY/sXr7hjJYZwiUgf?=
 =?us-ascii?Q?K4CzShgprOy/3NhfkosUzH49X9oLkc+U2UzrIUCbD0Pkkf3XFUoMrKDom9E5?=
 =?us-ascii?Q?lAKuo6CLY/LSRzwnRSEphvsxGgVBl2O14qDx8ftOIW8X9yq5uovzA+FsgoM7?=
 =?us-ascii?Q?aummd9EaIucWTHgtNlQFJrP6BmxYSvbdAYRHu0lTH2jUuUXsyUkUOX2b+Wvr?=
 =?us-ascii?Q?moQ+ffvZQlj4byQhZ62WprbpRRkIteDuLXbevNQhAsO91j+/L0mPiwvSLnZj?=
 =?us-ascii?Q?c3bTDofdcj9+sBolfq47g9CwBTCxddUOxdzJJNLWzOwHWO2UZMqrW17fmfQ/?=
 =?us-ascii?Q?yLwbW0d32uXVku0nrgFyLlIUL/fsxBi0OgG8tTc6zErYaeEJDf165KgUEJGp?=
 =?us-ascii?Q?CqYCvKxJK1GAQ7iZ5/vuNPP3ZGzkgvZNnyFOcnPRzCyJgcqm6uLswom9iug3?=
 =?us-ascii?Q?6HKHyn3MSCi4wcCJMkoBioeJreVV7HVmxiVTFKANAEsqezogXZMdx1/Tt5tJ?=
 =?us-ascii?Q?+OePGssh1EssBOz9luXUbhmoznAJDiJmhm4Lk+RVaBpZ1ev9wvTCYd2BlzuZ?=
 =?us-ascii?Q?BFGWZRdcPUI9fvk4oWuy0nWYdWQIR4hUd83GOjPS22mebAYmbl8loRltkTH8?=
 =?us-ascii?Q?TLJErOVegS2DSv2Say9oF/RuQgVQxz11Mhn2wEJzI2esGKXLjtdeuCEIlDJF?=
 =?us-ascii?Q?dTUeTxp8ezyp2ejXHB9p76ZbcT2bh67Llu9LrSBclWVDdN+3MblOSiJ7O18b?=
 =?us-ascii?Q?V90e3RIKUQ7Dj3ewSr4N82dqHnANWWBWVOAZpfZHFBrynW0Sg0NFZd6ol3ZX?=
 =?us-ascii?Q?dLRYjyQ8dGUQN+9THhUKig/SgL9HPRITqW8FyWJ8tjLduw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?D3m5eo+JOk5jr9D+6tIp3b+3yjDSQeDAcW2QWXvIzy7YCiJptvtWVU0TJJXZ?=
 =?us-ascii?Q?IfGBb20DH3Bzu7mneo5MKfC9OO5Z+tqHhaHUQ/P7DbvIoA2BlIwWWhS+E3z4?=
 =?us-ascii?Q?ochpZisfFHw8XiEf9WeoxNCH5QrB0aV0DCtHuSZe9RhAk4HjCdiGFsqSePCi?=
 =?us-ascii?Q?54YkvcVbAYbDJOHt8ktV1cb3uPlshSELFN0rBohR77asNcTmHuTe8q4E53IT?=
 =?us-ascii?Q?d9RDyU4LhHrF4EMQudPN+LYlxr9SL9HZ01scOzm1qo+EwhH1PviZANd4kw6v?=
 =?us-ascii?Q?1qs07DS5U70FMWfjuIKLaqqph3TD/DoGMHjduFed5TUx1PiVqZdFUsrJYwwn?=
 =?us-ascii?Q?/u7ZWdWIgesVrBY+hS/qPqOoJOJpVPsbYK8QWOG+Ndu+aqB5h41prDOOahOJ?=
 =?us-ascii?Q?WlTDfYu3a6WmPSHKC/w3ZHAdZimKlIVQ0WqoWVG2KTjgQEgq759wEvvL2R4/?=
 =?us-ascii?Q?T2iyRM7axrv2QIBv4ELGKnW43mbqjtswfyRnboVUw6LQjM3GVkGm/C5wQkZa?=
 =?us-ascii?Q?sG4zf4dg8eOmrfeD09ic8b1lIvReg/dPoT2SQ4wR1s80iXoC24f/x3wi7Xsc?=
 =?us-ascii?Q?2MbK7KUUzJ/0E+W0rlK3waf/P4YDbp0I/KZDgzDXgvk32Q3BUHZvZcSHV9Mo?=
 =?us-ascii?Q?2NYSuRb+8S1sJBPvkBzYrsaGyTSpy0VtrG+1nRBqUn6w8TPn2BgGIbEpQPpm?=
 =?us-ascii?Q?MPMt1pZoJBOZN4prqEj675llAMVEV5aKWklQrH+4E+BHPhOhapRbC4/gFQV5?=
 =?us-ascii?Q?IiqPO2uUGCppcinKiOzfbDzIS63uJlH/iGYARFu8wacC0EzL+7AEuiq4/Nvf?=
 =?us-ascii?Q?z/zBc7MQmsQa+9TOmmLC1/aNPg/hHhybReJ/BvxJDVeqm16LsJwENTODk3ts?=
 =?us-ascii?Q?QgcwOqSjhWNPzUehPeIPsin0YD7jo9kbrHCoNp+kfeF50/7WK/dlXHIx9ycR?=
 =?us-ascii?Q?rPZ4mspVpupxTGNdCAI00TqUPw1SxZ48oB47ryyezcpEPn3ZtQy4GWiP+VI0?=
 =?us-ascii?Q?m1XizGvHla2gbxy6Fc4IR+tILPH7TkYkHhsANfB7Sqf+cgBAY9YwyV5H+Pdv?=
 =?us-ascii?Q?X1go6+9XMv5KeP4Se93kJshbRAIwpDwZAtyz/SrRiQyLyMgHOPTzGzY+Xxog?=
 =?us-ascii?Q?Lt/0OPoyuShomFB7FTLDuCWiicUg1w4+nOIAXhXAtAMzijaYF/h95mVZbXaX?=
 =?us-ascii?Q?YM/6TydJHK/vYa2MOMKi89YUn6V6bjVl7ECrGodagwY9HnWYGjQiUdJuOyG4?=
 =?us-ascii?Q?31PPOqXyPlTGBkWM3WJBmvQ5/3If3GqcWU4iNkF86GNaRcASh1LCy2653vFb?=
 =?us-ascii?Q?v85x9Uh91w4HLxc/X3d/Ny8+LitAN3K5/Jn4B450TIei6Mp905UE2QVdMIlB?=
 =?us-ascii?Q?BhREkI8qa42J2aFRsqXzquhy6QNf77J89hJpzx7a3UDL+wQwnFcZtlBH5IdD?=
 =?us-ascii?Q?lzAkjR+rocQnSpp22VWLDt4D/0Fylwukv4pRhls+llfX+PAyZ4SVJEOj99fS?=
 =?us-ascii?Q?Bnoos0yIrCOcEzrOV8wXi8sY9oNSHWX7OcjZWXRkKcSYU6qwV5P/nQY3XR8u?=
 =?us-ascii?Q?NZnQmSlU+dmIUENTdk2MWgXsw+0OLVYMfqgA453as7SBWCq3rGLD2KTCXYRG?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ueS7+7+8Q6nv6HMcgdzNyrYQbkyeWcsIqXiBng1+flpNlvcM+DWs3i1EPwh3llLyO9XtgajB/knw1+wdj/DEFwxek8UyoKRCwyIJEr88UR3RRg0JCZ9A4nywufhXaQRsIagAG7Du+LrHfjErCkPW7jPZz+YtG+qiWF6DRhCs7egAAVfQWrDBwldajKkwLIrroAerYUGXu42eazsrrwNzKdnrN359BE/XWGRkszX8+c4FMFPa/A/LfsclHYaek/DiNUz+Zqxv4xwI/73FLTKpu6hA8DpdkfmHxDqtjmz4JMt85ZfYXrmxtLTPDKh9QeEtlcwh0T0Tmqr23MScG5scsqoSWl8m4TDAPR74fgecbChft6Vi+Qq6bPwWOr31pQ5nbwORwoUCubvh3TiT7ntWzh/hmieB5VMRiQ4LBxKzUezwi0A4XdyIc9nGl0W90889EQ+HuvYHX1ZScx12vpdm8iP7mo9MBApMhtbRBsG6HsUm53vXXcwIT9gO6x0GJm4zQyNhuhwMSvTlutwlFLWSt9Bc7qtNqn6vA/j43qFmVf5RUoR/QARJm4t58KUFT4KOjU2H7bvWJJqffLjQg2xwMD+Rokmeq4NjlWeF7xDUHs8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377422f3-02e1-4cb3-c7c6-08dc9f8e9920
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 20:43:18.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmW/Hr9278gUST53ww2BWkam52dqShWT3iFK/0palzXn3zazkJ4gmtk8Vyy0uAO618PfjRNNhvZSSqjeZw3E6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_11,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080153
X-Proofpoint-ORIG-GUID: qabzc-diGCZoF05m1JggUILgm2NCU7eU
X-Proofpoint-GUID: qabzc-diGCZoF05m1JggUILgm2NCU7eU

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240708 08:53]:
> On Thu, Jul 04, 2024 at 02:27:18PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
> > call, so use it instead of looping over the vmas twice.
> 
> Predictably indeed you removed the thing I commented on in the last patch
> ;) but at least this time I predicted it! ;)
> 
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 36 ++++--------------------------------
> >  1 file changed, 4 insertions(+), 32 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index b2de26683903..62edaabf3987 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -400,27 +400,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
> >  		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
> >  }
> >
> > -static unsigned long count_vma_pages_range(struct mm_struct *mm,
> > -		unsigned long addr, unsigned long end,
> > -		unsigned long *nr_accounted)
> > -{
> > -	VMA_ITERATOR(vmi, mm, addr);
> > -	struct vm_area_struct *vma;
> > -	unsigned long nr_pages = 0;
> > -
> > -	*nr_accounted = 0;
> > -	for_each_vma_range(vmi, vma, end) {
> > -		unsigned long vm_start = max(addr, vma->vm_start);
> > -		unsigned long vm_end = min(end, vma->vm_end);
> > -
> > -		nr_pages += PHYS_PFN(vm_end - vm_start);
> > -		if (vma->vm_flags & VM_ACCOUNT)
> > -			*nr_accounted += PHYS_PFN(vm_end - vm_start);
> > -	}
> > -
> > -	return nr_pages;
> > -}
> > -
> >  static void __vma_link_file(struct vm_area_struct *vma,
> >  			    struct address_space *mapping)
> >  {
> > @@ -2946,17 +2925,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	pgoff_t vm_pgoff;
> >  	int error = -ENOMEM;
> >  	VMA_ITERATOR(vmi, mm, addr);
> > -	unsigned long nr_pages, nr_accounted;
> > -
> > -	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> > -
> > -	/* Check against address space limit. */
> > -	/*
> > -	 * MAP_FIXED may remove pages of mappings that intersects with requested
> > -	 * mapping. Account for the pages it would unmap.
> > -	 */
> > -	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
> > -		return -ENOMEM;
> >
> >  	if (unlikely(!can_modify_mm(mm, addr, end)))
> >  		return -EPERM;
> > @@ -2987,6 +2955,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  			vma_iter_next_range(&vmi);
> >  	}
> >
> > +	/* Check against address space limit. */
> > +	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
> > +		goto abort_munmap;
> > +
> 
> I know you can literally only do this after the vms_gather_munmap_vmas(),
> but this does change where we check this, so for instance we do
> arch_unmap() without having checked may_expand_vm().
> 
> However I assume this is fine?

Thanks for pointing this out.

The functionality here has changed
--- from ---
may_expand_vm() check
can_modify_mm() check
arch_unmap()
vms_gather_munmap_vmas()
...

--- to ---
can_modify_mm() check
arch_unmap()
vms_gather_munmap_vmas()
may_expand_vm() check
...

vms_gather_munmap_vmas() does nothing but figures out what to do later,
but could use memory and can fail.

The user implications are:

1. The return type on the error may change to -EPERM from -ENOMEM, if
you are not allowed to expand and are trying to overwrite mseal()'ed
VMAs. That seems so very rare that I'm not sure it's worth mentioning.


2. arch_unmap() called prior to may_expand_vm().
powerpc uses this to set mm->context.vdso = NULL if mm->context.vdso is
within the unmap range.  User implication of this means that an
application my set the vdso to NULL prior to hitting the -ENOMEM case in
may_expand_vm() due to the address space limit.

Assuming the removal of the vdso does not cause the application to seg
fault, then the user visible change is that any vdso call after a failed
mmap(MAP_FIXED) call would result in a seg fault.  The only reason it
would fail is if the mapping process was attempting to map a large
enough area over the vdso (which is accounted and in the vma tree,
afaict) and ran out of memory. Note that this situation could arise
already since we could run out of memory (not accounting) after the
arch_unmap() call within the kernel.

The code today can suffer the same fate, but not by the accounting
failure.  It can happen due to failure to allocate a new vma,
do_vmi_munmap() failure after the arch_unmap() call, or any of the other
failure scenarios later in the mmap_region() function.

At the very least, this requires an expanded change log.

> 
> >  	/*
> >  	 * Private writable mapping: check memory availability
> >  	 */
> > --
> > 2.43.0
> >
> 
> Looks good to me generally,
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

