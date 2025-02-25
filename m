Return-Path: <linux-kernel+bounces-531771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4C3A44495
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E393B8A40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C4E156236;
	Tue, 25 Feb 2025 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HGri5ktN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c481hR6T"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B215DBB3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498026; cv=fail; b=BB4ve+pKTnZVJQnMEwBcxGRwgdkRu+nti4xYzdfl1GpMbPuJLYXrkddagpV+AV7h9pnUsKqpW9BURYXN06E0DgqVxWACv8zw3XyragDdu0ob0j0Sq1/gm2kZcj1t2/Zo3w23uBc6hEAHbEBeqkEk37/jmIZkAYapgpoWwaIW2DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498026; c=relaxed/simple;
	bh=DlGS17BjmoxELhYs3JdoTgQ+enZyNlb+OHV690chDms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=No1EK6IkJyngHMOWbE8p6Bazah+brqytCx9Qmk9Sv2C184f2Z6qLYI74hL51VyieVa2y9cTnoqTlYPR38Bl47utzeZIhvNR6cRvguRiNr3gUSlPlYGJUk7+wZiBYQA6L3mtRkgUVr3lCeGOBpD4MzhILW8BT4Qnklpe0+sCj0S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HGri5ktN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c481hR6T; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMbHG002021;
	Tue, 25 Feb 2025 15:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=oM7AkIn+MyJ6dTekPh
	+eNae1FcTj3VhXCs5VIWQkuKQ=; b=HGri5ktN/PfsIsJsF0KcN3rDbhkyqk9SjD
	0w3wiIN3Vf2OBnNJ0Xva/+4fsXprBSECD0yVMoD2uetjMj3dgGrCMb2VJUe3Jm9B
	O3RUwb5qNY6t4ODJcKHbpFjsTmHr6OnttBeSYb62CIP0Hc8DB5aV8eiU269pTDPX
	3UTpzHrTShiT4fqwXhbI8tj+GNETPu1zau3eJWFVuizejvycUXyN3DYnVEexsiKW
	NfroF9KVt/4SViFDvC1fORLWBGzla+j2jxfaWDQn30w/A8lukp38BL2FwLTQsKgY
	tCYQ0nhmz1UWleD1txqxVmxIoXAUhlhLZ7jtiGw2lvL8q0TPC12g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2dkft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:40:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PEVjp2012629;
	Tue, 25 Feb 2025 15:40:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51amy7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMdpBAeb971r3A/TX0Qb0p8Dw5esvseuDpLph+oAt6+My6a4bwpjJtdS85Da9LWswpoUjoRC0Bsqo/VoICzZS37bN/cVZzqiC9hiVX4qN5dQsmvKYgi7TkxZx0/06Mgv+s/3rjrEIURyUqVGj7PSz6zdv7VDtyzuz5mIDH+2zgk+reoI9DoUlQQ7T25VSRVTXjZUkH5iJAz1PZrJvZw1fRg7TcWLkuaTOFhIqL6NHpSrVHu6Wt/cGSUbzPhByQzfa5aU3IcHsq3BT6vdZOBXCKy+L+NN4h24b1p9mCJ3r3C0JN9N3UtTC+/SOQhcAwOU1hiEDHowaPk63f74ZsW/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oM7AkIn+MyJ6dTekPh+eNae1FcTj3VhXCs5VIWQkuKQ=;
 b=lPhiHWd8oy6bLTLlG28Uw+Byu9jlFxCR2uSvAQ5E7cA9TPyLnAKGPuhKjeMVDi5RZbPsJEE2qSMAtZgR2EuPF4T3dpoKCBvWhzmD0YQCfK0MvOxXXUpZwq7VtXgrPfWLV9Th4AQb9qT+do+4mgX3f/I87YqpRvbnawnP2j++5Y+SX70cr+/cOBXKeNEfM+mKEL3OMeuYYNXb11uHZvbdmWsjaWF+rcVxgPiycUPO4vqMUsm2bAsT27L3PCWEZcVtzyIP+hUYw5Ei0SUwYYRTLk4R5XvwJKRJShEuz6LFDjgBzrYruMDI42PNUhl0vAC3eVOBbeJWlXs92wIrDAwiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM7AkIn+MyJ6dTekPh+eNae1FcTj3VhXCs5VIWQkuKQ=;
 b=c481hR6TW9Gp7owUztWakgPhk8Bu2kP2p0D5IjPaEjb0fCMX/ZV790hYOdLFLlNfThRgcwtKyaajB5gQ2mstOjhsQ6/PtCU5CSUWpSsTTcMBJkXk/3jXqHiTvLvV76kEd6JORyiX8SsQDASQHpEvy4EmsodHjWH5hJfwyGw4AAM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 15:40:11 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:40:11 +0000
Date: Tue, 25 Feb 2025 10:40:08 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v2 0/6] Track node vacancy to reduce worst case
 allocation counts
Message-ID: <sgohw7e665kdphxgo2gk3yqfhw7qcvh7neei4qwcdec42p6lw6@u2ra53q3346k>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0351.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::28) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BL3PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac836bc-73a6-4b4f-a918-08dd55b2b07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ekfj6d2X+EH5tlHZOU0MZEYzAaD49B6mwzoMH7LJBbzYr4uP0B9cQfsGjwCT?=
 =?us-ascii?Q?gHInQEXvDY0bE/ZgEUdbbQLZ4FgMLk3Il+xPU0JNiRmhWoCnmu7RBKQl5qT4?=
 =?us-ascii?Q?NOMmYFIEMCdC1h68PwGRE4DAkgJ59VcKmDG+d+Kt4NmCPXGSQMdLTSM9BoQj?=
 =?us-ascii?Q?qrQxa5LvvCrkDi8PIrppY21a4v/0pgFBym6hSHK42wIcATk2Pn3oR3QFNY57?=
 =?us-ascii?Q?AIK7hdW1hT/YPe8e6F9QeibloZQLy64FMjd6S+ICLj0Q5V3tbSoOLWu6UTa2?=
 =?us-ascii?Q?Lc/QHGZGhyl9n6GylvufTHqiQ/0N0xzlfRxNQyK2k7IU1jZxO6gbtHTGN0ha?=
 =?us-ascii?Q?zFL7q/Txz4E0KkEZTW600RrEYFv29/PqFxniDcNQ/NVor3HQXN7Lvi70Lztd?=
 =?us-ascii?Q?YKKzxBi0RiWlKQDaCt5pLm9JouOiiuUUd3qUF8xDeLVWF8vq85X/IWXnK4sC?=
 =?us-ascii?Q?vkULUjDhjKpPUtuivxxvYy9/Omyp4tS1Hh34bFouNhoKcCgbnft+aApYzYQs?=
 =?us-ascii?Q?OLHqVkSPXtZXr9+Qja0MxyEVxC1dN96HyVkrXEPBbCMq8I203uDwG9UcNGdQ?=
 =?us-ascii?Q?cPTGmH45BqBzt1xXXOaK3HLXdpPyuxrCAqtTxOFv/1U+rHowW/rzi5iERqcI?=
 =?us-ascii?Q?j4gAk3Dby/a6C2Ww6qG+vZFknR3RnCg02iijLkxh+1m5dFwmTPCNcTtOd4Dt?=
 =?us-ascii?Q?Z8d/WPurm6eJSs2s4d48HNv3ghlb6P9oW2YrGvcrGcvX336TSftxMvrYbuoQ?=
 =?us-ascii?Q?jKvWxxEkxv9zB/iJSM+4vKJsUmkmnE+LoLeDVF61DhUNMbWiZl48itRXEwsJ?=
 =?us-ascii?Q?Zd4DIKIMnr9Kk/zklNIkh5R+S9h0MBbgG/Qzcvx97rHufjt0j3eXQvzoGPHu?=
 =?us-ascii?Q?oOrysTbzHj27YciRejuZCVvH2IkTOTjl+eRdkmLRHOdlVfLNukb2vKrhEKax?=
 =?us-ascii?Q?01lzNipEeV2HQJc3fF3Vk6j3fkvCQhwt/tM+ryNCH1/n0M07S38NArlMsIKi?=
 =?us-ascii?Q?G8+71IflT73LcnO95zuG7DJd799fc7D48qGW+OG6ifeVs/eJIlT2wgt8b92K?=
 =?us-ascii?Q?y7nTE/EJyoqXxu0a037Mlrk7+STLs3jv4a6GtymLDMlaSe2srvqZaW1DcLnu?=
 =?us-ascii?Q?CXF0TpeU99IRivbs2v+PZiuyZow8cqD3+ZPxzxpR2VyBMxYwKAUyMvp3vDk1?=
 =?us-ascii?Q?klNc8k9BpwSJT8VORpHbEeIDoLviKYjOrLtzh5VQkz51zux7e9mCrMzazp69?=
 =?us-ascii?Q?LxhGT27SpwQT6xd2SXNeVGVuKj76DGKrEYFN+Ud3jgHczs0CP/TE8wBTqS1d?=
 =?us-ascii?Q?kBydtJTurkYzYvRKuPidNV2C2oKxr3aRAa7axqrj0vWfm9IKbO2KvU7lUoTl?=
 =?us-ascii?Q?8mznDwv0qJOU44fntjxA+hF0ZZJ/2RluWVT/zcJtRceasEzAzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YNwCYsFxXp6qP0gmB9NWfXvqlzgtClVwssnggIpDvVoPv8uiuc3OSqDVDGHw?=
 =?us-ascii?Q?zD12LFhMVKm+Yf8wZc9eI6isk5E/srkOR5br7vf56vpzLRHka2GafaFecGzF?=
 =?us-ascii?Q?s6PmvMsX67M9iglfwAbJHAsumJKUX2Oxa+jz76PeLK14XrIAhb9LNMxKHt1M?=
 =?us-ascii?Q?AqSbdu/3K0oHtFcBMn9S0EI+hzH46ORn5yniK21JKF7grnDwR4lORnFdZ9RX?=
 =?us-ascii?Q?2vGZCKRfGwMxOAwtNCHZs6Wo+BnamqzwvcRve28FbtLvf/Ms7amT6x/g4m5d?=
 =?us-ascii?Q?q2eI65ofzS2eIh/pHhVqK2jXP+jPWIUL5BXIFk64LC8kA13z6jnn0W1f3Y/t?=
 =?us-ascii?Q?kCKGbXrdR+7cWDK2BS/uQdgbbWc1B9kyuQLbrS87xH/KA6NCma8KsuN6VClY?=
 =?us-ascii?Q?6nzC3Rk/amiF1B0fPfXlKveJaFPLbb+/OA5BJOpPCpdAVhhFQOlPUqahOLRs?=
 =?us-ascii?Q?HY7hmbxTrSvlT1/DOuSikiH5MqIH6Ua+pMmY1Mu8i+bXeFIJqDiVi3JsH2ay?=
 =?us-ascii?Q?EW9UzSw//n5E0imEh+QV2jfpgwyMvjZNyJF44fDRMXx6hgvRw1KuvKOyZ5bY?=
 =?us-ascii?Q?NMftwwkhbdlutvERfsboAAxEHk9qx3JtqdiGiRDihxQ6rqpSCSWOzXmcLlrI?=
 =?us-ascii?Q?1ktSYk3q3vkvQdaLpJHDPjkacu9b1fiaDeSQmVVOsZWKeEch5psh+238xCB3?=
 =?us-ascii?Q?dMT7khipvf1F7Cj0AbMgLQKrG99wJ0yFiT7wdtno7pdOYfmgHLRqklW5p8nj?=
 =?us-ascii?Q?WjKoRVUzziVnjrwPQUQR6/n6nrOkmwC6uji/7m/1Zch0fBUlQCcAGhrf/oKS?=
 =?us-ascii?Q?nT3BBjvSVKVi/kU1CUGCK+vxBJIJnVj8Gu+ES5j63i2gzN9LyU4E/GV7o2KT?=
 =?us-ascii?Q?whM2ajvLAXZAWbzIZDwP/Ww2Enk+PDIi3N9PpEqU/rK6XY053ea6xwweSenw?=
 =?us-ascii?Q?KbJOpOsa04ojFvlkBQ8F34KTAefbnREIVDTQ8YYTBVyJ6YAcBplwWsdSheJt?=
 =?us-ascii?Q?nHX2FhGjrWCepGcs55UVchD9/9cMeorOsOJLRgWeUMdHtJG5u12R93R0oTyT?=
 =?us-ascii?Q?9efTjjXJV+pTjWQRCaiVttIwSgAZV7+Zg+5lzb99MoTvgu/btdAn27y+leQN?=
 =?us-ascii?Q?C2YGLVWvG+Fn4Vy+5syXA+xQ/XVTQxiO8dakSBZZzl43toCO+l3Mp7W66Zlf?=
 =?us-ascii?Q?BAUjF9EfQuJfAdMTrWnbYHbMJ4ogqzOQX6YryGPcOXbJopM36anrOqgXixDj?=
 =?us-ascii?Q?1zgqi4udiejR0TDfU2E9648oNv/gScTGnFuIuIuvoi2ESo4wxlMP0SWgP33v?=
 =?us-ascii?Q?hwI2cUil3X4BG11kbxNLC3L4qd+ZSvFY82VvB8aJBzQU4EZZhiBBrygvybuf?=
 =?us-ascii?Q?n7lQDwSHqZr+aJ6M8U8qJLxxIYLshpUN4zA4re9pjxgv02cV50BWEo7gOfnN?=
 =?us-ascii?Q?Z1ZuTQ5bd3XC0yB36DAS1e8l6eo9zkNGHTd37RkRa7Y5EAVDBmGqduYzKZrx?=
 =?us-ascii?Q?+Le0Jf4OsCE/tRQGPyeCYPJkMcFzojLtxsonh5O/a9KaQSHG7l75xGkTsvCa?=
 =?us-ascii?Q?cY42wPTitZ4SxmVBXBrjlccGqiH3MC/sIlNUgin8r0o8dEj6qGbbZZuP83Wp?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KtCFOpXLU+u7VNKqJpwHJ+xakgnu5HXc40oanSa2sMNBKhH7hqUXPBa5DIYsmb0yUBePu9n6ASKUbxYlf0oDzHApTcEQdZSJQrVOftftPPDGxmLG3U9cYtDTbnRzYUtq5HKuoiJ50pSQIJULqGoxI3+bq8mzlE2L4azu7XxNx0POffMTonVnXgJ2QzOkRD8N36XahT/+XjZV9vLZnROZJ7R/yiHYtDlFfre4xAo7MJKDTTz0hXZf7lB5rPg72svc/P1EHypzVoodRoiVoB5daQx9gRqWDNY3GMPqOp7Eu/TSifkzA0scTkyobPSnqKeDnIpZ2bPkWI2hT6JbHK96spLdAdnhdav8o9gcxjXV35BrZpxwykOD87zwXLImAURzX0WvT/8Rlu1WF5gZGH47XWqVpkIAo82mdcJ2wgMrpn5jPZpDekHPp8VBTrezBxX5Lll79fjL1DoI2JvHTJmdsLpq7LQ0EpGIgFuntdxMZgdVoXZ2AfdkKIdP/gOY4+h3Cp08uIwZNeH1mqVsDegry37nXsGHs7MgPABOAdi4Qa8q6EvXdQ/jIVjBJakbX9leBTV8a0hq1MdA64e6xWVg0m2P0H7NKKGJ96S2I/JelWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac836bc-73a6-4b4f-a918-08dd55b2b07a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:40:11.1515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3VNoK3+4WO2WDZMkMubv5cQmBhgG+FIxGfICUTA+FtDx6q9mffOGi4Zas0CHPIhPsn90nslDEvuLyjCoUbxOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250103
X-Proofpoint-ORIG-GUID: ocP-evJP6meABErPaisZ0QQBq_zRcKUd
X-Proofpoint-GUID: ocP-evJP6meABErPaisZ0QQBq_zRcKUd

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
> v1[1] -> v2:
>   - fix comment for vacant_height which refers to depth per Wei 
> 
>   - add a patch to reorder switch case statements in mas_prealloc_calc and
>     mas_wr_store_entry
> 
>   - use sufficient height in spanning stores
> 
>   - modify patch 2 to use a counter to track ascending the tree rather
>     than overloading mas->depth to have this function.
> 
> ================ overview ========================
> Currently, the maple tree preallocates the worst case number of nodes for
> given store type by taking into account the whole height of the tree. This
> comes from a worst case scenario of every node in the tree being full and
> having to propagate node allocation upwards until we reach the root of the
> tree. This can be optimized if there are vacancies in nodes that are at a
> lower depth than the root node. This series implements tracking the level
> at which there is a vacant node so we only need to allocate until this
> level is reached, rather than always using the full height of the tree.
> The ma_wr_state struct is modified to add a field which keeps track of the
> vacant height and is updated during walks of the tree. This value is then
> read in mas_prealloc_calc() when we decide how many nodes to allocate.
> 
> For rebalancing and spanning stores, we also need to track the lowest
> height at which a node has 1 more entry than the minimum sufficient number
> of entries. This is because rebalancing can cause a parent node to become
> insufficient which results in further node allocations. In this case, we
> need to use the sufficient height as the worst case rather than the vacant
> height.
> 
> patch 1-2: preparatory patches
> patch 3: implement vacant height tracking + update the tests
> patch 4: support vacant height tracking for rebalacning writes
                                              ^^^^^^^^^^^- Typo
> patch 5: implement sufficient height tracking
> patch 6: reorder switch case statements
> 
> ================ results =========================
> Bpftrace was used to profile the allocation path for requesting new maple
> nodes while running stress-ng mmap 120s. The histograms below represent
> requests to kmem_cache_alloc_bulk() and show the count argument. This
> represnts how many maple nodes the caller is requesting in
> kmem_cache_alloc_bulk()
> 
> command: stress-ng --mmap 4 --timeout 120
> 
> mm-unstable 
> 
> @bulk_alloc_req:
> [3, 4)                 4 |                                                    |
> [4, 5)             54170 |@                                                   |
> [5, 6)                 0 |                                                    |
> [6, 7)            893057 |@@@@@@@@@@@@@@@@@@@@                                |
> [7, 8)                 4 |                                                    |
> [8, 9)           2230287 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [9, 10)            55811 |@                                                   |
> [10, 11)           77834 |@                                                   |
> [11, 12)               0 |                                                    |
> [12, 13)         1368684 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     |
> [13, 14)               0 |                                                    |
> [14, 15)               0 |                                                    |
> [15, 16)          367197 |@@@@@@@@                                            |
> 
> 
> @maple_node_total: 46,630,160
> @total_vmas: 46184591
> 
> mm-unstable + this series
> 
> @bulk_alloc_req:
> [2, 3)               198 |                                                    |
> [3, 4)                 4 |                                                    |
> [4, 5)                43 |                                                    |
> [5, 6)                 0 |                                                    |
> [6, 7)           1069503 |@@@@@@@@@@@@@@@@@@@@@                               |
> [7, 8)                 4 |                                                    |
> [8, 9)           2597268 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [9, 10)           472191 |@@@@@@@@@                                           |
> [10, 11)          191904 |@@@                                                 |
> [11, 12)               0 |                                                    |
> [12, 13)          247316 |@@@@                                                |
> [13, 14)               0 |                                                    |
> [14, 15)               0 |                                                    |
> [15, 16)           98769 |@                                                   |
> 
> 
> @maple_node_total: 37,813,856
> @total_vmas: 43493287
> 
> This represents a ~19% reduction in the number of bulk maple nodes allocated.
> 
> For more reproducible results, a historgram of the return value of
> mas_prealloc_calc() is displayed while running the maple_tree_tests
> whcih have a deterministic store pattern
> 
> mas_prealloc_calc() return value mm-unstable
> 1   :  							 (12068)
> 3   :  							 (11836)
> 5   : ***** 						 (271192)
> 7   : ************************************************** (2329329)
> 9   : *********** 					 (534186)
> 10  :  							 (435)
> 11  : *************** 					 (704306)
> 13  : ******** 						 (409781)
> 
> mas_prealloc_calc() return value mm-unstable + this series
> 1   : 							 (12070)
> 3   : ************************************************** (3548777)
> 5   : ********                                           (633458)
> 7   :  							 (65081)
> 9   :  							 (11224)
> 10  :  							 (341)
> 11  :  							 (2973)
> 13  :  							 (68)
> 
> do_mmap latency was also measured for regressions:
> command: stress-ng --mmap 4 --timeout 120
> 
> mm-unstable:
> avg = 7162 nsecs, total: 16101821292 nsecs, count: 2248034
> 
> mm-unstable + this series:
> avg = 6689 nsecs, total: 15135391764 nsecs, count: 2262726
> 
> 
> [1]: https://lore.kernel.org/lkml/20241114170524.64391-1-sidhartha.kumar@oracle.com/T/
> 
> Sidhartha Kumar (6):
>   maple_tree: convert mas_prealloc_calc() to take in a maple write state
>   maple_tree: use height and depth consistently
>   maple_tree: use vacant nodes to reduce worst case allocations
>   maple_tree: break on convergence in mas_spanning_rebalance()
>   maple_tree: add sufficient height
>   maple_tree: reorder mas->store_type case statements
> 
>  include/linux/maple_tree.h       |   4 +
>  lib/maple_tree.c                 | 193 ++++++++++++++++++-------------
>  tools/testing/radix-tree/maple.c | 130 +++++++++++++++++++--
>  3 files changed, 240 insertions(+), 87 deletions(-)
> 
> -- 
> 2.43.0
> 

