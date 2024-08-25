Return-Path: <linux-kernel+bounces-300485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492CF95E43B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664E028170A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C26155730;
	Sun, 25 Aug 2024 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d4GrW72h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ubx5/Zc6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D92F34
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724601939; cv=fail; b=hw1xN55nnGfgkpxh4EtX3DpPhZsPX1ZW6sMaMx6CA87aPoP4BoclYvwQ5JmorY1ysselpRlQY3g6jNZ9c1Z2v+YBp68pL0t+5nUxIdr9xNaQ80FHss3A7xifYlMRYBnWhUd+rfZCebE1iBIYCtVAVSZ4ICtdhY/Roa59o2c+x8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724601939; c=relaxed/simple;
	bh=UyjxguOLcW3DMWrrfJFEaCTl3Qb1AOBLFSJHnxpH67k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YGmQKH+z3PqsbTSMAAh/NlvaqDb8E8Y5mM4N/XNDPgTs2H5jFi4sO82JiJIax7FPls0mdePh+VdkYTkUaDqYiX604ndxP2xmypVHWAD4nMyI39EqaimB1cXxTWEgB5ia/tiW7lqduwknczTzavklyT0h36lPb1tL8puUktXVdjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d4GrW72h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ubx5/Zc6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47P5A6Qg005748;
	Sun, 25 Aug 2024 16:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=zLWcxdJX3K/T+Tz
	8l9puGNPLX2FAZzib28W+pFTonls=; b=d4GrW72hZ9vMfvrKerjgy1eSigMk1dz
	yyBOkrlLPYlX/lmZaiAjKLPyyhyunNs6KaFg0MTIhsr046PetN9ux+ULAwBReDgu
	RzpJi796IcMav1B2fu2IHeUBbx7DPnAh2/GAR0diLyA7dBY+Y89RjDAeqE3uZ2TK
	5AdiT3IjFOhLiEgBinap4/FFq0fTK3tyYKgbUHIGCJImpUwgVW3jqzeYkIFhcImj
	366Ya2gxluXQ3Jbg3DtPavxWeffLZh2Kalh2atfUPG0P6F3ItNd6bxk6VWOe335Q
	Q6hHfSUCutqDN65+BEpLBaWKfQxqmFSxe+m0GrxOADT+D9tg54mdwXw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177u6hmhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 16:04:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47PFJAnn021428;
	Sun, 25 Aug 2024 16:04:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4187570m84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Aug 2024 16:04:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glqblcls9EFYm/3HJVOd0o6HMmYY3yI7tHjAM77Kfu3ZBE9/CdZ9Twu0DQk7RXwNA1LZ17UoNWYLtbdIy9Hrem0IMhtshD/DbgqwqzXXSKBIf8wzeVtNkUM6pTddCTg77v5dqSeRkgbR0LuLNbg731KDvNvUG9+q/UAhetiEBSWjvyNzjRHypKvFPSVSKE/mXcpp/1eblLlKzLja+79n14Fy5t9jkuSQoR/L795qWWuhJnRxdUFOMP8u3t0seLwHK4XTClKPGWOmQfafYjtNjVDpTbRlW9aeuakoVvVw8QtYH1yqW1Pe0GrY8D2c4Y/K1GooMKaMcfuUlnNMEN56NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLWcxdJX3K/T+Tz8l9puGNPLX2FAZzib28W+pFTonls=;
 b=yybAZAl1FmxAcbMFAD/fTBqImuuDO0tS3u89eIDgsmcEdFCgrDGCxAkfLU/XJxzVtVsgcS8PYhFW7KeoFzp8ESjvrKyuucwXi71qhJ6xtLXD7Bo8b40ORPVHV3t0z3Fyz4aCz11/nhkFVE/HSLykIophq7Ga241G1VpmecvBl34yo2HIH5QYS2mUedcC6DvdKbrcd9U78+3cklWlUexnyRQ/oKE+SP+ZvAG0U+5oFJYqDeh9L0NOMsmKZT9ASZRNIGQhDVNoI7wxnT3y+Z9QBD46ICdI2dx4NfQVljTk0s5/SWyYtNwUWHTya6ZZF1RzieCPy/NVX1WLDnYFUGav1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLWcxdJX3K/T+Tz8l9puGNPLX2FAZzib28W+pFTonls=;
 b=Ubx5/Zc6JtEiM0lctKSYlgyJ+AfJZexSubRehbUp9zvvzphl/zRUDJCjgmPryS2DpMR3BO6upWOSFqqE1al9Yv6P3AGvVFvJj8VOuO7f7RQjASC/41dXAEtNEg3yQcD+MZRaDtngiqF8EDCL4+W8DqY2ABQghf0YjGRb/j3+7lQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7861.namprd10.prod.outlook.com (2603:10b6:610:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Sun, 25 Aug
 2024 16:04:50 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.012; Sun, 25 Aug 2024
 16:04:50 +0000
Date: Sun, 25 Aug 2024 17:04:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bigeasy@linutronix.de
Subject: Re: [PATCH] x86/mm/pat: Support splitting of virtual memory areas
Message-ID: <8ed51ba1-a844-483a-9eea-36571ec635ff@lucifer.local>
References: <20240825152403.3171682-1-namcao@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825152403.3171682-1-namcao@linutronix.de>
X-ClientProxiedBy: LO4P123CA0173.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a0f997-b021-4648-6899-08dcc51fa654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3xPMC4oVUCQFhAATTirvO77Hen7HFRSZxf8HLSUCDk2agOuwb0KWe2j+UAft?=
 =?us-ascii?Q?7TBuD1GC3VwpGLz8/1RmzGgMH46I02ZT4RFAoHRJ10Lh41PdDRrTqauDlTck?=
 =?us-ascii?Q?Mz38GawhZK/12HUrLnGuRn2AD/1P1cA38xBznPugw0xOmF5GLMDeuIqbTfMC?=
 =?us-ascii?Q?P0xidzrcpz09hVH1OhEtvqT7y+Z1af8M9NLeWk0jlK4cQQxt6T48uFNlFber?=
 =?us-ascii?Q?5D+OBiWNNnrj+GbRL9/303ciHPoy19tpiq5Sjfd4Vs77Uvi0QV7z0xUGGrrA?=
 =?us-ascii?Q?81gvj8MI47E0/VCQaP7pED6hds6RKfdlpbsjWHwAjl+K7IVcRHUoicNuqeiL?=
 =?us-ascii?Q?BC0ow2VGe7Yohy2dni99yIM0jNUlYspAva7KqtH0O0IfCswBb4Lpdh1PjVcW?=
 =?us-ascii?Q?3bc2Tz7bNoxUfedgsJuTtHrKBdSDExhEYmJCMczhjdmO9AtO4NyK2DugG1I1?=
 =?us-ascii?Q?wh3ruhFWlx60RJl/g9W+Mh7nClub761wNP4++wnG/2BbEnJrvV5sgx18NdoR?=
 =?us-ascii?Q?UQlfiwpqhy9HnyJvX1KqlXqZ6/nQAWflMaSYVIrrQv+uV7quLQyRaOf38iQ3?=
 =?us-ascii?Q?TmkAZsK5oMOruWlJJu2ahZrOaEkknrvjAGBeyED0xGTRt9UAbZ9bn3QKxC1o?=
 =?us-ascii?Q?tAl07/WepfRQCjAsxU32z16WQB2Wo4iNZ8kEvJ+6OvYH1AAvn1RPMOn+ZKiF?=
 =?us-ascii?Q?52+rBm5PjUOk4ZYltu8RcliQmi/LFUUmutbV0FbFMIHvSiWUoM5ySQI/Z07B?=
 =?us-ascii?Q?I8pWagSs11RjskNSWBmelY6xu1aEqV4Gb9Dol9dY55yYrPpruzo7xTlM8kjH?=
 =?us-ascii?Q?voq3Si43LCCSd40DoG6gLfnJdWbWDQuzQws8kOSzhBsIrdoGng5TRqFw7k8t?=
 =?us-ascii?Q?M8TpaTate6v3oFyqgv9eDZ0vOryy2uqVcAhSMzheGpupnwHQ5NgW5TqX59i0?=
 =?us-ascii?Q?44JbtwA+UlnW+DjYj5YgMxSFoe1kYWY5jPF/WI8Hx7M6xfNrXI+CvHN5z7aM?=
 =?us-ascii?Q?rTsMkJbG/O6sMJc0lPGNzZFK5OVLQ4t5vzPVlElV702LDQmTJyf3tn8zVOVi?=
 =?us-ascii?Q?95FsTWAzDCz6UgnyFwHEtX/xzJAGF9S+JBAEHuNElQuhl/OesMTEvzG0T7rf?=
 =?us-ascii?Q?SVSXQNXMMGj4G86hs+l2vQAQ+6Id0xuG8U/uoJwyW9ofGJMKtdhSolYjcng1?=
 =?us-ascii?Q?+1tF4jOLbfhqux583hXwS/RcvBd6nEGnb2Qgd8sY87EXHjH5RPRdoxPdpMrJ?=
 =?us-ascii?Q?1DZi9pLroDXY1uBOrWI52mZBywS94mA/tTsmMyeEg/dFM26lHzWNhXhEPqpt?=
 =?us-ascii?Q?wZWZKYq65Hs+S6EoLf18m2pD1OO/ExkJOY1C0X+PBLLRLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/l1nnX2sdPkeNuAvLqUG7L/CuTI2b2dne9Sza0fJwgwQD8jyWl7m+aQb4hlJ?=
 =?us-ascii?Q?6XK+I5sdEoT3iMVu5BSsZcX73vpWrMI8j7M4Z82OvHPBWg+/D+WZzae4phKa?=
 =?us-ascii?Q?c5NAqoM8M3Mt03TLSUBrehs8B6CIp/pf0RnSNA+uBCwcW9Q0s0JJtfBLrxRE?=
 =?us-ascii?Q?1ET0JTNgtgSGM+renq+MU6cIQFXCrAQy3jNi0YuI4ZFBW6mrVvggTj6M8eh2?=
 =?us-ascii?Q?nQ+mkjmV2C3BhjMK0hufBPoIINBOHMKKjKHMKzDoFyuz0RxYe6qxJHeIhElW?=
 =?us-ascii?Q?liaDnJLMKzzSPYDQl6sZt/6fttDkqtRf4X3u5HQl29FsTPaZw5Apa/GTrlgo?=
 =?us-ascii?Q?8uoOW6B/L/4XcisNBSmF6V718n+gq+v3t3ely79hfWmGAa1cxhB3FUmokg/8?=
 =?us-ascii?Q?IrB1/5voInQRv2WwFIQjB28hif+gIOhnxVuiU+a5ylnrESKkRps9syZzdLYF?=
 =?us-ascii?Q?af17JbslryYB5aNt1YmmlcaruqckXFG41AcOeAIDdu9zjNzLYaNeZrE0czyE?=
 =?us-ascii?Q?/XLe5RLAuULzthgrlbwSgIgwKIhiVRZPLX6zsJX/8BnNc+YS0IHdKEjxqsPZ?=
 =?us-ascii?Q?U/f05VuBen509FFdYMP8uLsYp4ZXSLwvU5i1gZ+Hc2FH59cLKRCEc7ppiYlT?=
 =?us-ascii?Q?WV3ewvelLAvUP+SJT5X/TMck0sEUzwKTbWmNH1qfCAyz59ZsyheIM3Vw0G7Y?=
 =?us-ascii?Q?cJw+W0nnNsg1EuBtgkSmNoMQS66OLfRUONSeJiLMJaOv/n+/g33oOb5M4bX+?=
 =?us-ascii?Q?M2jzsHDpq7FqFO8ARCaWB1cwDyrlgriSAICwntkw82b3cP33XRrz884y42og?=
 =?us-ascii?Q?fOnIMkFcuQ2s0X0keT1/dBjYDih3tk/h7w9CSKkLtXHaH4jW199cTNYqqm5H?=
 =?us-ascii?Q?fIh0lcUuew7x6h/f4pcZaGMuoGlhdGSZWtWDfX/uc3c7GuaHzY0YAhXc2ylK?=
 =?us-ascii?Q?bgUzi1zmzuum5EBizjxXwGTMVRuBfPnuKyXAsfOx4VH8Fumlac5JoMtld74C?=
 =?us-ascii?Q?JWbOKhecro74VGARCoriuo1Iy9FGNhgGdaR2VV6nEMgReeaQRphbRxKdKPut?=
 =?us-ascii?Q?MdZh6XN97kGElkFRYUSOUzx8qHnUxquZ6YNGVjfr5Y9Fz2hAe05wIavClyoH?=
 =?us-ascii?Q?lS8j21xRP8THN2SWSXIdRtGVLYWTh/UfYz6Q3bb1lBKqqNegy3ApBdoDgS5s?=
 =?us-ascii?Q?11wGGqJFOJ1tc3OKHfLOrYsLLzSIjnqjayq4vRFn5VYam5sNRkmW+F45VdUp?=
 =?us-ascii?Q?RMX5AfdjQzS9/Otdyh4c1V/bYBdjqCpMh3ffv6qgL6ZWYO5N6QXD4TN/t8k4?=
 =?us-ascii?Q?BeRgdd8w2FbcCwu5GgbP1T6H30eP6WSUkibXcMUcHrUAAln2J6+sqwU5LBfv?=
 =?us-ascii?Q?5TzSroV86cWqcIKewC00Z4iy/nZdtVxhB+MXMO9Ys67BiOK+72pBV8Eh6N/s?=
 =?us-ascii?Q?50OyDtAtQ3dNfgwC7Gobnz28GEH/P7zcvgELzDwCKgZ0NhoVEAN1A2Blk//m?=
 =?us-ascii?Q?EHjWfzsrlXDAidKqyvv0NPjTZId7N1CdAhCO00DiTBGPhnqHkWCnkq0DFzUX?=
 =?us-ascii?Q?7fNfv/szLmd4kZ7vUdIQavaVkj+4V+aMbXRNyEiX9TIjFTz1Fcv88gwAJqfk?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hdTbv2zZu0H9+nO30ddIymF0Gq64uhoZRI+2vFXe8TeETtnB5Lm0352SwJTg/+TNbNHSL7Xr8aZ2JECQIhqfB/I0VoNbyi+kqv6cjyq2BLslStop8r4Ahx4/pAboVK1y8LXBlxgMkTj1igiCqqaA2y1oJLpjpjeslQdJ3ZLXAlZcbmwEBhjonCYOcWuo3evXs5P4qmJON0SZ7EBVDOeBEdl57zpoo5OHX6ArG/LYWGFtc06yw74+oBAI4wnN90GaD0dwCq/EmKr3d2n8CFRTPoeR/wBwlPN2HFQyw23wL084J0DB8Pf0xfdmpmn20P1L+IZUw75RW40jnOJSsyNzhRF53HJbtayk/JQR2mW7jF6Z7NzuBnyT/h71BQNVmtIfy/xSLXQQXhD6dbtljLCkuLPrcnvKzzq4vuIr56fiCyg56fH5FaMx3Yh8sPgH9lR60Jnw/gFc5SnWte5vOua8lzlPk6zHCSQLa5QHqYRHlJU5LC+zJfslqU6R7RmdkNdx5oU7Gqb2nUVxW2ZaPNhTf5CJ+Fq52j9MwKdlJc+04RPAB4Lh3kHoDipkQWCESWkrTudXW53v/IpTya/kGZzTEsl5hjLt0l9/YhOAUhamKK0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a0f997-b021-4648-6899-08dcc51fa654
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 16:04:50.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTjS56PbPf2eTIaDW2vKNf9QmaNMHFUgyaxW0Uk6B3k5bbOH6jtY1B1y4IGZqlRTcLtQpYhUnwM7OvsxsCwt9+H39GA9ZW6uorr+ZcGeW9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-25_13,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408250128
X-Proofpoint-ORIG-GUID: nH9vm4NLW53CjJMTPkbX2KFb9SgBiLwU
X-Proofpoint-GUID: nH9vm4NLW53CjJMTPkbX2KFb9SgBiLwU

On Sun, Aug 25, 2024 at 05:24:03PM GMT, Nam Cao wrote:

[snip]

> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0dfc85b209b..64067ddb8382 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2486,6 +2486,12 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (err)
>  		goto out_free_mpol;
>
> +	if (unlikely(vma->vm_flags & VM_PFNMAP)) {
> +		err = track_pfn_split(vma, addr);
> +		if (err)
> +			goto out_vma_unlink;
> +	}
> +
>  	if (new->vm_file)
>  		get_file(new->vm_file);
>
> @@ -2515,6 +2521,8 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		vma_next(vmi);
>  	return 0;
>
> +out_vma_unlink:
> +	unlink_anon_vmas(vma);
>  out_free_mpol:
>  	mpol_put(vma_policy(new));
>  out_free_vmi:
> --
> 2.39.2
>

Right from the start the 6.11rc cycle mm-unstable and therefore -next has
moved this function out to mm/vma.c, so you will need to make this change
there rather than against mm/mmap.c (or whichever tree this is intended to
come through needs to sync up, especially as there's a fairly substantial
amount of change going on right now in VMA handling).

Sorry about that!

