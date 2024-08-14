Return-Path: <linux-kernel+bounces-285710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942F95119C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE0D285E38
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA912E7F;
	Wed, 14 Aug 2024 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eg9HUunq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hLacQahI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FA517997
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723599485; cv=fail; b=TqJ1DWZHg8374/YB6PWSdNwIXeKbbVHDUE5TfphlTrO2Q92qH2bLs7Fd3auES315gl5YfAJCAApXeXc6pH105tJT51cKOqkO/UaADhdbeOvd37txmjJGHbraNB0oyWxbcbqtjQu8gjkXrM5Ys2DnGCCtz978SuX8cY4OSaqVxD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723599485; c=relaxed/simple;
	bh=8NA5i+hm9DUBJovlGs/Z+2KLK6valejPpm6a7TDtcEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KMZAJYbSLF/+1zk3PfCQJ8H2IihRvDYLA/YbbxK8zaq1p8U+qHQ+3S8VeA3UKzeRMqndTlbmCLaA30JSH/CHCZQiuxZIXy7n4DQkTv4o1DWJzOurW/2vx2/KpoH52j+ZH8HQaHoAw0yrt/QoZEYeAITBmZ+XttgdixMfodTj4DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eg9HUunq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hLacQahI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DN9fRZ010483;
	Wed, 14 Aug 2024 01:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=o6DiKOLOBNFoYYP
	c41/RDPoGTY1fiCQtA7QhDBM/P5k=; b=eg9HUunqKCu7nlbop3LTEp8UWk13DgW
	QT83ixkU4QCKoe922RlKgNYgCkYSKer26Dcia4s5UvkvBsf5reOCXFtgnNqDV/no
	9mGoQRjuEgJnvBGyaPS267aSDliwQw5iJ5Zeu2Wcsql6AEZTmvtfwRDHeegwEloG
	dPXHej3Q3FKlGCd6awhai+vXO9lcAvC33ezf3ygKrx4ZIRej6XNWJ+0p+OV0pI5g
	mgEZCUYKghIa75FYjx0541IB5OM3x7Ncfw0gHfxDYP74rDScH+IfiBw4zlvZDK7O
	SM8AIZsf7keUsQLQ+NmY0mYLXD/h9VbovDId3AJXrnppEJQPMdrwJNQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt0yaw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 01:37:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47E0JKBb006097;
	Wed, 14 Aug 2024 01:37:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnaaac5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 01:37:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esxLPupRdleBdeqZuwDffhArMO7XBVowSbK07LX28neDg8lSdvZcezVJaU/rE96Ayta9Erfx9ylgjNA4XjNZkSo0s0B7R1KxlVuGXTiDOROT+pcCkEK0Ip7nMjwug1e/jxWdF43NDpB1mS8kcEtEDKqsxGMhxMEKflhPQtneDLNHsJyGxOU0x3JMNap1Ymbg7hRtM3pqCmTX8z6yjPHlRCsjDmwkT+Ex9t79v4NGNVzWpJxx3cxgoOEZ3XDx60FqxOJDaOC5jFUyvBrNsQIXmmQfXxGAp1q8d7vtNQY70dhh5ScN2kAkWbFWT8pFrPYgcpJ4yFVE8RCgcGPQWwURig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6DiKOLOBNFoYYPc41/RDPoGTY1fiCQtA7QhDBM/P5k=;
 b=c2/vPEj4pBKiJ3wF682aBzq3Nt35wFxixeeDX3LwKFQma9OD3LI91yeJOWY3KMm78m7EPqHG6TVUlZB46NJ675taRdW+ZqYvZW76A5nxWNKCIA9dlBdtAsORccsV5frKiRVOZ30npveBGKdjnvWXB3jGPy+Dt7DAh3MGSC60Cd8YrnVf4ZQLIors0IZIBjjKFIoEjYUlhVqooLYvD7YlaUL7EUTvKByujwgDx93TAwtbnEIrNB/sSJ6Yf27XNrXl9hjIQWrJ0uE/Fsn3ZvVbJ1ngPl4h5oRVfdF2TJx9DJofljHSxecXKB/q3EQrnvJUWKiVtx78Xgc+Rz3lwAgxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6DiKOLOBNFoYYPc41/RDPoGTY1fiCQtA7QhDBM/P5k=;
 b=hLacQahIIlEKa2l/VhwNEiVwHWQXiObxAEQQ7sBihyV9tbJDwVBjRwEAu3YM93BmCZ5IEdzbuYTozdU9kZySimP7KxHEXwh/4bdeqrAnHi+iuNDadhBQAqQ8wJSlqbxq9NexYzQo2qa7shEwubhsWSyROJZ5UHpD0boQ9/DQhUc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7522.namprd10.prod.outlook.com (2603:10b6:8:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Wed, 14 Aug
 2024 01:37:55 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 01:37:55 +0000
Date: Tue, 13 Aug 2024 21:37:52 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 2/2] maple_tree: fix comment typo with corresponding
 maple_status
Message-ID: <45467jgljaishstyj3y6ewlylmsnpwsknhprnsnandnqyh7vvb@t2m5tv7s3tf5>
References: <20240812150925.31551-1-richard.weiyang@gmail.com>
 <20240812150925.31551-2-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812150925.31551-2-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0361.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: f954f3e0-57a4-4d8c-ba0f-08dcbc01b81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7441XO2L3B9xTMdJoNY7QjD2RZORCJNveIN/zjjYOfEajkXB24Z2kYc+ciOp?=
 =?us-ascii?Q?C3Pg1Y+sK2Aps6hokpHKksjbjJpylftMhmvR5decbuK5i+tQpX4wdnS412DY?=
 =?us-ascii?Q?gTU9r02zLVTQL+96UG+h2p0W/UHJBjk41mztLj7NC8lEckDwRmpFqhsetJMx?=
 =?us-ascii?Q?Ec1bt4BZpB2hRGbS8dwyC5pigc4cqMWUJCb1zzFHawkjZaiH6cV37knmup9d?=
 =?us-ascii?Q?6zNKqqGIAlUdgF/NbVhRAXZruW0g31ovmfoyK7f2QNkWTXpZ4An36eGKqJm6?=
 =?us-ascii?Q?jtV+M19DI5uiqS2w5DPNoKHJGfEjHaKm/0AxFtjIxDRMSDWUJNrSOYngZ7iD?=
 =?us-ascii?Q?Hq8+DrVytam6u+3IxmVuW778ZjO0zrvg36S62+pzu3JAz59NOps1sYB2v2fp?=
 =?us-ascii?Q?VtqDODxo9jq3qEBIYIGidS3fNfAr87OhtXQhiVcMcpNcuDaIVCV4vpNOn8/9?=
 =?us-ascii?Q?I8ElPbkfmKBE8MIOl3sdmLEJoebRulgnFHhvKwu0aBFzE+kg9qTrCJOnnOsH?=
 =?us-ascii?Q?3uPFO5ddfe0NjwRAdHPm2DIlvV15EzmyM5IlF6u5KIWbz7r0Qol7sz7b7GW1?=
 =?us-ascii?Q?De2h0m0Q03HcqgJffSNSALxYz/TINYeWxJlB7oxOrfEYjuTknqRKVZZMoe4u?=
 =?us-ascii?Q?3QzDNZl3Nyp4kvCICA3pbGX6SMVi6gqy2BuOpOygSSzwXixQyVtCtYhwYaLn?=
 =?us-ascii?Q?GgPB66eyOGkDcVImqu4Hfa6xZWFw+8PfrVCJV4w+K5uN7j1EZnywfgF9AhzU?=
 =?us-ascii?Q?ixbXOlYaMHsRW4izmkKsXpZS4ZeYba2cdB8gvlEuA9dt4LzkOzTS2BjPk64u?=
 =?us-ascii?Q?dbHGuCB2qt5LUeeMK21KX5ARe4ExnLdKy7djUUuPRH71AHInF9HqxA68G+xu?=
 =?us-ascii?Q?Aphf6YT8euY1DjQ6XK4AAMQXh3hHpHETgGORQHV6eJu1sY8+ONCqth/LUb12?=
 =?us-ascii?Q?yCqm1HxtZ34hfao5wxAR6nlO/tJHSHZefNkLAN1EFKbpI+NM6LmdB0zfoZ7v?=
 =?us-ascii?Q?yk1W96KZHaOjCrYLo9p4ng704WyqumJFHF1Zpb2ihUyektvhMtMHWAFKAkD1?=
 =?us-ascii?Q?HZU/j4vKEqMiV0vPwGDXOEg9LT5+udG4v8Lb2L/oYRCavaz0PZk8Z5V/mZgx?=
 =?us-ascii?Q?8HrG2nUREHPDvqRO37wFBhjVuy6vnFPoXPOh5K9zewwtK7CECRQy4SI2q/hm?=
 =?us-ascii?Q?GJMa2+2Q/tZQIEx8S+HViXojHUjnJ58J9X0i+ygwHuqH/DYALLlSNPsJsJ18?=
 =?us-ascii?Q?P9eq2ygrsPmBu9P+eiy7vyWAObqt3R+OeparU5EA1cMuRDgllFvu+CzfrGd6?=
 =?us-ascii?Q?JWYNaiw+B+yap0WkeSOJXiQP6wA/2NDvBLES7NV49gQx7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?80f9k8KsTAfGP3xpt+nt8AMUM6zR/VqdxXdAo1otkdrvpuZFjpKhecIlzYZy?=
 =?us-ascii?Q?I1qhQ/bXjmXx+GeTcZ1AA36bUrYIPdmPutQnhJe2XvD0uwcrwxiWu7s1qKHL?=
 =?us-ascii?Q?3Nk3/Q6pDGYD5w7Ro2Go2bDu0V16wpmvIJDD1klov9Ru/Rzrv/yZlZckQYjy?=
 =?us-ascii?Q?OOAv+ighed4ErzOjA3Ech1KPk2CYPX51TPY4ZMvpalDWi6APP/wfeq24u1RX?=
 =?us-ascii?Q?NOBnhvs8Mp4dtRZGZq6AwYOJCvLXXLLbcOwH79en/soegWREqzCVrUBe6SRe?=
 =?us-ascii?Q?tg6+BYAT8v6SXjRl6i4Zg81n1Cck47I1Z53mCJxoY0ktYJW4FRy5MJo1Wuyv?=
 =?us-ascii?Q?oPfdsHqjOFIsVkeWq1dyWDIZCHZDmnFY0KxkE9ouiw3YwX/LYbUHPjS40uY0?=
 =?us-ascii?Q?I51Br/0lE+RGneiGLGqgEsap3DCyBhz8TyoslBdkWG1ZI4IFJqnxUDki/GW/?=
 =?us-ascii?Q?eVyVmiRootNtOKDTgQqNji+fLyu8JqnQuMNig5NEm1ZceskOIuVFhXqyODrd?=
 =?us-ascii?Q?GKLIy5h1zJQCiVIv8GqdGa60RA4ZTIen2yx4N5OitC5sPq2XsOPXkChiXyrG?=
 =?us-ascii?Q?uhR4tyB5MEwVbQ18sjvJlh8I1SoB5u8XGh9t43WV3P8XW3FXxeRl34LhIJ7P?=
 =?us-ascii?Q?GJrFnCwJuom2rFcNDKJTXflZZLiHNd4MofhARoNPJMTrkdUmOfwrxlmKszqT?=
 =?us-ascii?Q?F98dSZChbShjoEo+L5out3BUNbZV6Mz/6e/0/D7CaQaDWWH3XSZ0l2HMASNU?=
 =?us-ascii?Q?cuZWaUph/T7WNkTXQLTlcnQROPnpQEPp+hHzvYGTWj5BmStABJUcVtFdhH57?=
 =?us-ascii?Q?tePAjNRdwHVO5H/FIXQZX9VEBTipLOiGf1iiurMD5cS119SuECCUCSiGEY2t?=
 =?us-ascii?Q?YwxvAVxZjTgUi7MJFgH/JI/l0IKET9dkGnFiDVs7rIUPHQWc9IpX/M8ABEp9?=
 =?us-ascii?Q?vfhATkKnfnlZYvhLnyWcTs9wl861UJ+PtWEVsVOlokjqB3cQrLSRw4SI0ova?=
 =?us-ascii?Q?wqov6eDGDvKnQ43jJGhzWw/V01yTdcLS7C4xiJlQ2uUi1rTI5RZ6PzHfE06E?=
 =?us-ascii?Q?NUFDrXkFL1CAc4tfiQOnCGSyE3GlJeI6uR6FcErP21tVl/EeRoaQdK4nOTfA?=
 =?us-ascii?Q?qO5E485JlOt7PCcdNarZgTqk8NFsGPqvL6SWDVx/wFEKB+CL4/GI4cJVClBA?=
 =?us-ascii?Q?DfpkJsz3tXGmq1PDS4TzEEUzU1spvw1SB5WmeNH0Vx+7yChJTMqnG/cQoOpT?=
 =?us-ascii?Q?HJZhpm+qYy5fwt0YcMNHHmjn6J6I1GhwJKVEY//zoNA7aL1Ev63wih6Uci0+?=
 =?us-ascii?Q?5XD7szPUl91bPV14C2kKzsxdvO0qlDhxFAW/spRNdUzMMHoEAtYcXolPjBTq?=
 =?us-ascii?Q?rDXZwSYpUMm0uPUQccYODgUc7Cycxp3vubxykk15G44ySD435zDLIK9Ifnwr?=
 =?us-ascii?Q?KhlQZm26ebbFz+hqacvJ7KReKhSp8G+25fGZavl9RKS6HhxMzxEmUki0wGxr?=
 =?us-ascii?Q?kSrHAI0maH4Wutyoos2hHmJMwNr2sc8YTDrIpGNH0BszIz/x1KmIPYSW37y4?=
 =?us-ascii?Q?jrnh8nV74GM6pSV1AXZiKrX1uxOOT+6BHSWlaaEg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yOW4dpOq8HJOCF6xfu7nTOWlswpwamq0fgqPEeaZQIWw0xwxOgSKSFXDF32xsAeql4bxXCybhkwBA9meaNXyC3NEQU/Zvyf2eiwUOU58guaRfuKUVUSTS4dM/YLtcO9bJFiXm/+GRBeSP4DdZFgDOemWYGLaOYEHJVjYyX7J0qpFd/1BmImvmqVQu81CVquttoYjvetW6pJYe1FiL3LKFRlL3LaeKSpcLwrim4p2YksCCcOSR19E1i+6JYOdsQgfSZI1GCsHbk2OMswBaF8kUy0+XMrbJyD2OIakedr5NQvl4YCmJoHUQB2XRnQ3RRy4q0GYSy+aZUg/CcyPvJpkeSIF/XQz5AMozvInr00oKz7ZezOGafEwSWFL+WG+uuSILxLJbckPlXIlgfY8iorXS2MELad4DkCIORBPgB7fnCemWhi3pcHcGa6J3Z9RcAXHp1yW5acSWUC2aYqXqhRpiNHGokyyFma+QbejL7pTk3VDITQKVBMlxjrBBL1TDnqEv7lrrDO4MTsbJBaSJ6uw+pgcMUMsjqyF5sJpJjoHOTujL4G3TwrSN3akOrwY5/IhC8CNp8/FBSJruxSfNNTT0uxQruDRSPGsoaBN+XTVOvc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f954f3e0-57a4-4d8c-ba0f-08dcbc01b81d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 01:37:55.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISLzzpWRjl87vHSf7nZzORqnqarJG/f6XJiZJGT5cht5tyyNHdnQLf8las4omrJY6Fg1aMqNEFsW8mP21kGaww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_14,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140010
X-Proofpoint-GUID: qzek7WEJ_okh8iuty7smHuP8-UvD3JuI
X-Proofpoint-ORIG-GUID: qzek7WEJ_okh8iuty7smHuP8-UvD3JuI

* Wei Yang <richard.weiyang@gmail.com> [240812 11:09]:
> In comment of function mas_start(), we list the return value of
> different cases. According to the comment context, tell the maple_status
> here is more consistent with others.
> 
> Let's correct it with ma_active in the case it's a tree.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 14ff54078f9e..026197c44988 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1347,7 +1347,7 @@ static void mas_node_count(struct ma_state *mas, int count)
>   * - If mas->node is an error or not mas_start, return NULL.
>   * - If it's an empty tree:     NULL & mas->status == ma_none
>   * - If it's a single entry:    The entry & mas->status == ma_root
> - * - If it's a tree:            NULL & mas->status == safe root node.
> + * - If it's a tree:            NULL & mas->status == ma_active

This was obvious fallout from the removal of the mas->node overloading
and adding a status for underflow/overflow.  With this change, the
detail that mas->node == safe root node is lost in favour of the status
being set to active.  Both are important.  Maybe this comment needs
further clearing up to state what mas->node is, but we are basically
documenting what happens in the function so I don't think it's worth
fixing.

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

>   */
>  static inline struct maple_enode *mas_start(struct ma_state *mas)
>  {
> -- 
> 2.34.1
> 

