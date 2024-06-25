Return-Path: <linux-kernel+bounces-229574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C974D9170FF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5C41C212DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4AD17DE3A;
	Tue, 25 Jun 2024 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e9BJF1HU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yl/N9pF0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58C17DE0D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342747; cv=fail; b=Lu7T6s+qnCAXlrqv3sdrw3uXvqBq8+hHOKG4+H6/8zP/M5X8g8x5Kls6Hk0EX0mOf2plg2pW54z2pOxrCa7F9vi4ovnrudeeiI7nyyPuhTcbippojWNWstrl54E0+IBFOtbU0URsxkKri78efFvjdrusvUvUVD+qcniPhz/h8U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342747; c=relaxed/simple;
	bh=12pxhC/DkUR6+FxwsbIlaRs+Y07xn/yB+ya8opPIXtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PAEsxt207rIXTVrbyiIzKPZcaHC9DdTDtFLUAbjksjpK/qAlEqO35z+tMZM+404vd+GLt3np19mofxvnpU8cWlE2+83jN1cV1ZvlmD7YY1Or5tUZMZcd4Lzj6ZDegqh1QY9Qr619IlaC37htKce3QO5y8AWF9WTGZjhUslrUFiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e9BJF1HU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yl/N9pF0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PIfUqf023000;
	Tue, 25 Jun 2024 19:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1DoxtPb5EdsWVu0FMLjwtMRXKfWWaZ02jMrwbY8xjCg=; b=
	e9BJF1HUBMWMMg8bhqOBpGItD5sJ5O+xJYOCDIMBpwhmp8udgCSTzwsWADl0TVTh
	Fz0T8AFsEn+IiJFOR298dBW6LSoYAixPXVpXY19flWbeh4GwQxuXHkwab7N/oyEP
	d4a/HWr6YXx0U4/jQKbNkHZ8NqR8+ZOklDLd6bjjXuqz6Hv/DOBAQc83SJSeVuTP
	rliaWVaOMjSAzcsss48NG/n4K7FxNF/jGFfmVcXxZ8TWqGeugr6wOHPeG7o2s/Nu
	kAd4QhCsfEvNxlQqX5AumXVVQmokXDIoqwK4WAWWyhi3ud9ly/cMFXnUtP3G6m8A
	wODlO3iaOONsAN+wJve2xQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t1k2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PIqmFt010741;
	Tue, 25 Jun 2024 19:12:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2egtpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 19:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVEo4a73gpKT7S2BBD0GZxKyo6AGTXtA4cxu/Pg7i7sbOkZsW5rK7d74I8dByts3FmDn8Bf96ZWirHuqp2orFdCTnuMSHj/jp8iYlfMt4uc9dU2H7AHe4Q1D0tuS1kjqHUfYS9aVZPqh+Upq/sNea4ZTNixeJzAAcd5ZemfmB2Jqswpv4EyWjOX+oBKBNiUbJbo+aTDF4YJ478iMHW9ib/4Ef66D7vkv3ibGdtM2i8IJz3Lx4d0m0eu/f6+K9Q4QKX8SdgaN6G+OLoX3y2aVE3fRHwbLZmZZTP2R3RIYIfQmX8tup7QkovfQkpHESZ/8B3hAuoiLqvi6owpjIeGt4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DoxtPb5EdsWVu0FMLjwtMRXKfWWaZ02jMrwbY8xjCg=;
 b=Io5uHQgc36L6Ad5GRup7M1Rlqxhqc21MZy+EYhKr4fVJrSEa3cEmiEJm/StfacDSPcnevsaABrMAAMzQYHwZlp2ecrZ4Gt9iGoEVuyVMZlmQcke0Hxmn4aB6bCkUS1pQViUjjWhFoU4/Ismek6HBE4Od7avPyJh2nt0eopQ63x5GH6FyAnWYku5zfzR/VxGenxJvgblNFMkSHoNscVxBYNRd87Ns+qFvcXOUZ3S306vl2s4j+t4IUjcTOlvllwvuaShvum6SUl4VL/NpjtkgiQE0WTGayAKB6wOH0J1MTtcsOkUrw1i1s0wz71Y3gCeIH+HtoCLMunsS1dfqq7dJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DoxtPb5EdsWVu0FMLjwtMRXKfWWaZ02jMrwbY8xjCg=;
 b=yl/N9pF0DEtFK6O/i8ZduA6JFAgN5xV8EYgttJU8vTmPE1volFpw7dY2WgAXa2binJiOQIjHeudbPWV1EJ16+hf3RfrXXvTxan66kwJQEzEx4AryWBTQO9BieOWGg4ZquigG6aY8f8mZgtj0Rh63U/AQH03CUuwAS4aLSWueESU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4707.namprd10.prod.outlook.com (2603:10b6:303:92::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:12:08 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 19:12:08 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v2 08/15] mm/mmap: Inline munmap operation in mmap_region()
Date: Tue, 25 Jun 2024 15:11:38 -0400
Message-ID: <20240625191145.3382793-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0017.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4707:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbfd661-7819-4291-36b4-08dc954ab586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|7416012|1800799022;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XwdcP5vv4jbudIqAzSrKPiN+e0G3/x3yS9/KrqGM7hB8aUIy9QsXM4yavS1C?=
 =?us-ascii?Q?NHuqeAol8MzlMTrRUiFcxHByddZ+45BAltVZk1ZcByatXtxQI7Y59OCDTt5R?=
 =?us-ascii?Q?gy353yHwu2j/aAaGXiPYrXladzZR17ct//VQ443EcAP8xQxybcb9IIR8UNCX?=
 =?us-ascii?Q?ozcsgTxoqKTSVdBxH+nuDDfh98nFu1Pg0pU3NXQyKqqT1jTRLL05M86m/ArP?=
 =?us-ascii?Q?5fpiEwWB/+pWD2951jzn38EBBRwNzpMAc8q8/uS/cLEwZeBKdutrNmvEpuqj?=
 =?us-ascii?Q?fI5HR9GpKrKL3hUbrO7xZcD7DcLnwbLhZA+qEnrG6Xgs/0YskPbIYc1Eg88X?=
 =?us-ascii?Q?cVcShtnJcHjSvYohgunVpVaZlhznXwWoMJKtu/nGOBdHJX0zmgFCMcKIVFbi?=
 =?us-ascii?Q?acumUvM4X3K2V57NQRNSuMTHpTiG2WHK7JhtVV/w+hpkI8k+/OJ1akmku8lg?=
 =?us-ascii?Q?oXP+D8pMShPkaFE+bO0c1Vkr4cktBpt6W47cRukIh2pVoT8nV3DE8nL21w18?=
 =?us-ascii?Q?387NS6BvSWjLfij3qmcLEh9Ixic9klqwOmU/upse0YKcPhsjKikSUGupGCeJ?=
 =?us-ascii?Q?FLNyuTWHxlWgx+6Okfz33WW6rtrtkqAJgRnzSHSr8v13u0rvGkfVr7hm6sPZ?=
 =?us-ascii?Q?P7VXCB4SbGoZeOXy1xeN44djJs/1k6VU54q5YjXVMgiP5M/f18rG8EbdWxZr?=
 =?us-ascii?Q?s2o/jNFCjU5Fc1s+bwBF+6jzunm1VwtXCAO2kZvQrc743yfbs1W1H8vnTRHP?=
 =?us-ascii?Q?WAvo5EQPWqudb8psDFj5iD57RPTKRvfMJwB2cpWA7kygFxq5r80Pbo8nxcTQ?=
 =?us-ascii?Q?d3OxCVvkNWiO/S3G13kXjgYLEyDpvIT1nx+jOTPB/2kxwsR42RrRwnzyVPTE?=
 =?us-ascii?Q?srAEtXcv+nMTnypuJMeaPPaTXTC99WpzBLjJyNjubeqXD1lJmMkQeKqaYyTX?=
 =?us-ascii?Q?L3Ympcn+/nh0C7NhzSLONMgJtn/fnFfy57eVVxblNWV+MNbKNS3ezFfFa3lZ?=
 =?us-ascii?Q?Z3VTxieWL9vNACwgcQ8wCVVhfDMSe2t2N6qcmxlKxP5/ZcKZzs0OE000df9N?=
 =?us-ascii?Q?wjhFLTa0Tgk174/ZD4MdVzR4VMZna1kpdbVNqDgRPg8LynSE4G2EaTRdPfKG?=
 =?us-ascii?Q?U98PNXsS3c1a11w6FQHaA+3Wxoer89yKIpLEMvSnmHToMXIPtft1bcVyxCT8?=
 =?us-ascii?Q?VoM30WRUV4nBGu2CGesPdNnYcJgZ5TrevI/2VNT/CgnXXmtOv1GJO9MdNdeb?=
 =?us-ascii?Q?HMSCHdwaJDInuqJrTx50kk5VCNIcVTXPNC+Pzr8RgQorv2yGslR9Jk0oWia0?=
 =?us-ascii?Q?++7aMN4lL9wv2HOipgQcbhZn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(7416012)(1800799022);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/RljETI5WQA4YzLC2oofCgCNZQgljRaqucng+uaiMsQkxgSNGlerZp37Acc2?=
 =?us-ascii?Q?0ZRKpZoEzfObLBxC2l3FjrciuNSatK1JnZPYCbp3V0i6IlxftisBli7Z3rSE?=
 =?us-ascii?Q?Y5H9CXApxTFafqaYZT3ekEKAGmoZJpeW+q0Sjt0AVLgD+pL3TaBJ2b9Z8lBH?=
 =?us-ascii?Q?RNO9Bzc64utxbyvy9CpIybf3/fmFG4HhfZbo5qC1K/jt22QZkDtB7UYKer14?=
 =?us-ascii?Q?rkPNlELRJL4VXmKvsWnbrQs4r6GZSX96aGaCXytWqapEhUzVAKiwVVNqowYY?=
 =?us-ascii?Q?0ZxDoUgX4jn8QofSiZ0UKI3lIdRHm1r7QQz7DP+VcVBOu1UaQMtwvdVLwBeT?=
 =?us-ascii?Q?FuoIDqKBKxDA5qiZ0DuaD9vAhoEnzz8O0A0dMPVItrlPZjw8Fj2MV/npxGwA?=
 =?us-ascii?Q?sFPDwaOz+RWaf8MiqbZjYfunfROidfLDiri/OP8EtwN66edxEnl1NfvVtwU6?=
 =?us-ascii?Q?tnF61otElWk1YsZrxcaHOvpHiwhcNXw6F5WjA/CnegAzyGWH9M4/178weELj?=
 =?us-ascii?Q?EHMH/Snngut3bloTnv03AINJpzUVGG09kWxCWWMqZ4pu1E1SoBroShOKoLc6?=
 =?us-ascii?Q?6VaHD8ip7vQ53/g6X2PaRcpZpyiaQGEBOqlWJ/3xWHlpmLd7S9BAoYRQ2NCD?=
 =?us-ascii?Q?Wr5itX9AcQOpjdRZoFFDgG2NH+wmxeBk2KPxp/5qDDcvjYdOrfxuDafXJQrg?=
 =?us-ascii?Q?gG+2q7TE3CZHA/21L9VzhIC8+E4Lhufkhtbq3Dkb1x7JT/oLpm6G0r8cBiK0?=
 =?us-ascii?Q?UQU2Z4LwRMvEMa71TwXRBJDz07g55FhQfbMKXn9yN1EQTAhVVdO1VBn0krcA?=
 =?us-ascii?Q?xZOrWYPg/N39hukIRNmbUvcI6KIpkqaFBqGyWpfC8foa8wSbVJc8oPy6O29a?=
 =?us-ascii?Q?OFq2gCxTJG3uZrErSKJ4VgWxEfOYVZILvIcD84aZHJUEDX65RCyKg/voZL0o?=
 =?us-ascii?Q?90ie+zDCPVCslWfHkzhmZEPhxgDWz5rvZG+Em5ETEqb1GO8Q3oWqEl3SWoPN?=
 =?us-ascii?Q?de5AiAEDqQKd10TxLtL4KO8R6tf7tqeIBNunzU61ZfW5LkBRBG4MPZ7A5XS8?=
 =?us-ascii?Q?bktjOvcls/EI4FZ13Cx0+ntJSahbTHv9TihBg4Ss5tdf1i5DiRKfQeRTIwAq?=
 =?us-ascii?Q?IuRsKo2oOn/c7EOZDH7sR5VVRQjATRSWE0p0pRgwadeiT65a9QzG2n5EaK6W?=
 =?us-ascii?Q?XmEkHPFcKFOzbkmGhSK+4Zq10j8ezDQWJNW7H+BR19bm87Hq22KvexgpXbrQ?=
 =?us-ascii?Q?B1oexdjv1kv5I66xMhGqsChtP4YLcnMRAPaVOTHSA1iMKQIIXLDl8YOcR/+4?=
 =?us-ascii?Q?nB5cpn9D4aNJUMcEW3uSHD0BUPpUBgJFnqTGNDv07R6fobn8ulU+uLxznnfz?=
 =?us-ascii?Q?bWZN7dM/5pcUuEqxN2Nf5YAy8te0RcVGOMhYS6yjLtjfwKC8ULGjlnQqMmvt?=
 =?us-ascii?Q?fV6BgUP0vImN8ux8PvcGtwpzxMyv2Wi0JmaxZvcvtr26/JrU2fYuLOJNW+uC?=
 =?us-ascii?Q?ZL4mxwNEz77SKlwdLvUwoYKelCIXS66vEbUBZfU1mYU5EVhl0/cFgqWmdOMp?=
 =?us-ascii?Q?PgcDzIIXUiZ46n8F4b4z+R7pwdRKrOM4ZorIvXlIAUtJqNZ1yj7MYjSPcc5b?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	viFCLWDmSXZMzXyvEiwG9Vbgigx7alWEvxToddeq3l2ppqiTmzH8H8uSxe1yXb2QqByUoWayRf99Phmvq8nVqH7e2fpm6dqf1v2cIPz/j0pw3W0yJwMifXQC4YTNEEYPR9Yd8+iG3o9p+KPBsLBOfavclPZLkB7iU/Zs7pCuGHJP5vSuDzdnngqaMBXMo516310LKo31LDcAO7Q9YDD6/Kj+J7mjjh+MoiE3rpHPZqyM+0TQx9UxDgH4Ca90a6ut37ZlMUYbD3tp+57V/Gb2vs+EJtRbtIKI/mVh2ksPouRd8bmkWXQO37SRJKE+HJcblGo8M9k+z7QuI6o61YJZTlzn8dEYvXcfpu62GBqAy6Rp5T2cQD78Ui8/D/LwtvCg0z0mfJ8aL3whwObyj6LTqGA0PWHXJ5CothPqh+IkS7p11VfJdmsVCUo/KXiNzSKvGeBQw7Kced1P15ch7r+kHp4ViXJzO8YB8WJejh/FtecxvkXgao8c61sGpeEztrci6p3lOAftt5Q0dFo5MMOte7Gt0cEBDRH/pgbmxvmFeMqu8jL3UyjKPYbH9pWQJUKrNIsv/4A5fU7mD0nWOBQScORv4+k0zL0m7yQ3TtT3t0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbfd661-7819-4291-36b4-08dc954ab586
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:12:08.6168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbmR37RPGx4zXRF6d8ITlOd6vpXDBfHcwAz5HY7KW90YQD7LzednJqKwVoiFktdpRpAD2l3nDL4WiG1Ur5tTcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_14,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406250141
X-Proofpoint-GUID: Qg10Wj-9hnBdFnDrHzvOAY_JxdxilOXj
X-Proofpoint-ORIG-GUID: Qg10Wj-9hnBdFnDrHzvOAY_JxdxilOXj

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mmap_region is already passed sanitized addr and len, so change the
call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8d9be791997a..e9858ca8bbd4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2937,12 +2937,20 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			return -ENOMEM;
 	}
 
-	/* Unmap any existing mapping in the area */
-	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
-	if (error == -EPERM)
-		return error;
-	else if (error)
-		return -ENOMEM;
+
+	if (unlikely(!can_modify_mm(mm, addr, end)))
+		return -EPERM;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, addr, end);
+
+	/* Find the first overlapping VMA */
+	vma = vma_find(&vmi, end);
+	if (vma) {
+		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+			return -ENOMEM;
+		vma = NULL;
+	}
 
 	/*
 	 * Private writable mapping: check memory availability
-- 
2.43.0


