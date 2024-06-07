Return-Path: <linux-kernel+bounces-206625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 521E0900C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B191F23100
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AA916191A;
	Fri,  7 Jun 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HrV3V7Gz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gw7y0BEy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71814F102
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786436; cv=fail; b=j+qqNEtDFJhT+fnz+XSvVcTu8YTB7ywCtZtWodpjCFl+FaZ11kckMdl+ZRRYDNonQhAFAbj0ez6UJLi7xVMc/Ln62LhPJ6G+WNhxhfiUHOQ4wCTtwHrIqNLQsLEfc7LcoAecF1oMpOKU/zv/MFahfrEHi67S/vR8uzDMptUrfms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786436; c=relaxed/simple;
	bh=bIyt07WDEz0zziNvc/4MXUn7ICeowtQ7X61DboIfqg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cwUVO6nzI3I0U+SRe0gu3fOIlhDsqZ1SopI0xLe0vv9PhjKvvt1JhOJPYJHvvHhtEPQ/lczKVbfP5QcvhxlR+KdyyPXqnE2RIu2N7Uf7AqkmvBIIqr8FK0BmMU3I/CVTmRv43N8GdJ0rcZ2osKSZxelEgENkJaDb9BVY4XZ4cjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HrV3V7Gz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gw7y0BEy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuYeG009377;
	Fri, 7 Jun 2024 18:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=kt5Zf2IFc6VA5/9HjTZW5u6FOaNmBnlLUKNfDocuGoE=;
 b=HrV3V7GzI/atSyRDw78AFmfs+3KmD8NpYTaODqkXnBMeVUC4b6Ikg13j8PYo9cJ6OCgN
 Au9ifBOm2odR5P3NjQbTMJ8pPpF/p6iOGlKXMfc0PCc2SwuiNxpG5PL2tPDwGOi9or5a
 cPIGMrjKLiOfbvP6oakYukblAZesOmEUOS7UYLzdyg5yp/hUnoFW4RuhYvFXFj6tmz0X
 z8tWX9uXl8tO9SgNN8GLrTu9+v2yIB7yUN25HQNL1DxmKdVHsgg/IRBdRqmgZTvxYlfK
 09AnsgEbWQLHvVO0fPYZensQm3p6/IwauCT1eY//lK4nNkv2oU/GK3euCSMjQks83+Ys rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtwe89b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ICR4J023938;
	Fri, 7 Jun 2024 18:53:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2k7tv-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnFfVHHAFWU/Hq1WUVusdVtuZmplfJzQN622k3ivv833bFGjnaHc+Da468nx7HiE1qeVuKDFLL/BMdjuWco5M7Eq8RQPsM3f5UuN1f2f8LElQhbtiBvj/tTIVd+sJwxpXiVJMmyZVYvOd3T/tCPOfHTXNwJhI/t82AejLHHbpiL+uUil3wR2V4uYa/5HYNyFt5msTnYx1pwpLTPEvgltXwxNyGCOVKmeZuZ15cySmMpo7FbihXxODv82wnMvZMA5MoCXwwGiPizma3X0XgMqpmVkvisocGSnkRP6Ge0Pk4cExxfK/yFrpj2vqcPWoI5wdiAPpMOBtWt55+aEeGbx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kt5Zf2IFc6VA5/9HjTZW5u6FOaNmBnlLUKNfDocuGoE=;
 b=EFEeGcyef2hyfx225w6RXwlWK5wWL7yke5mHaGcQ+c8B6ZYoWLRpln6hV9wurA7biMkXLtkbTjo+yl3jcC87raXQvEZN+F8gQ1MV/PbvUf6Iv4uvaE+HymbMxOy8YF/VxkLcKUnYkC2F5hHkfAmoPvqOO/65dZPAFqMMhkHgrO8QH1TIuRWY+FLFWx2latCQPYgMO1SbBJZ21yBFHV/XqtsDs/YlcfP2HEYHsp4C1IX24y7Nd82mymAoiP9PDlfp8alj+5o9aF5zYtoy7vJz7U6F2hKm5Fdm9GNL82BXQdIMwvhU/7DitnGcvSlXRcdED9jFzasd5NGXRxtCdNAV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kt5Zf2IFc6VA5/9HjTZW5u6FOaNmBnlLUKNfDocuGoE=;
 b=Gw7y0BEyAt7GKWIJ/MuJDsntzaIa2JTQYYtwBP1tTnv00oKgt/dC284FVLdg6zkxJBU1Ee50zO3XSGE6B5mDzb5lHhRlIqCN9j8zs9mzwBzNwzsJ5QJJBFsQPnWcbdSH2lZ4NOoo18FsUi9vSDLgVdBdThT1CyaOE8GoW0UtB9Q=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:31 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:30 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 11/16] maple_tree: simplify mas_commit_b_node()
Date: Fri,  7 Jun 2024 11:52:52 -0700
Message-ID: <20240607185257.963768-12-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: c911a8e9-5670-4d87-a511-08dc87231f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7ykFVncahSPh5225XbJwy+x6Eq2C9YLxMrykfKGiS7Xj4FHt43Cltpn47NAC?=
 =?us-ascii?Q?vnD9HOkPqsbNoswbYTERhl+AU5LgqSNnkNUlYvBywVa51wFbqGb7SRDT1VfZ?=
 =?us-ascii?Q?J1EE5Ffaw3M58tXgBkBRmGS4TsVTD1k93NKhpQtjQxJ+nlA4NKDcm5JHA0bc?=
 =?us-ascii?Q?s3bixd5RlyPrMMUtohZJzoo9B7FmHrrEv9GTIC5aQs8u5Vd2PyyYuHBt9m8H?=
 =?us-ascii?Q?6NqkMd8vKecNS3FcVlDNLfgmIMfN8RFIHYMWmtOoPurpyF6T54VDGSMLmCTe?=
 =?us-ascii?Q?Y1ZcpJ5uqEfFq3t+B/kH7xkIFiC1bxOCQM/n7vn9BnO755dt0YXgJHtS/Elh?=
 =?us-ascii?Q?Zh+W8QwFvM1jmMlD3gDNrQUPv5ldwhFKmz86kE4vAHW1tLXXKMIt6p8ReJr+?=
 =?us-ascii?Q?NbaRuLiPVYNiyBNKWoSpRi4t4jV/Kv47BiOR0VDfJ0STfxUtSQ8A7p7RcpG5?=
 =?us-ascii?Q?JtejBxuWRvDDGDERCwK5gJsfZxfZsM7yqS5rmRylONPgtvBiNtxW3ObQSBAe?=
 =?us-ascii?Q?dUN2yiKxU40SwNbDSr+lB4JSkckzs1AYFIdOxndomxPI9wXyuuZtArew65nK?=
 =?us-ascii?Q?sBTjudUHrYs7KqnvK3umfehNBY9+4DAzOFFL65gKJdhwaYheCtRAN0qEGrUT?=
 =?us-ascii?Q?RtcrMemJLBLtgGjqVKngMPZ6j4hIHAoDiReHxHZ6tcjqDH7K/IIr1K6Lp2ty?=
 =?us-ascii?Q?Yq0RpxorjrKUVdPGahyuV2a4jR6jgp6OF/gYqnTu0W4CP++nSfjYyNLCe0nv?=
 =?us-ascii?Q?gEkh/3jh1q9hFMkkMTGnMrGwxfZRi5HaU1un0ZV4ThOi89J7bJC8SPULGuDz?=
 =?us-ascii?Q?CGBjk/N1m5FhnmIQsjcjEUQWp9CPfpXh5jB8xvCXfSVSFvW6lnKaItVT7nN0?=
 =?us-ascii?Q?Z+M2BoSipVNIRCtGmMGk2GkDylZsNDbD03e5AkQk5xDx2re/Qk959reBI3Qy?=
 =?us-ascii?Q?0k6viKg5gd7+huK90WXzszMD9CI4cDyYIg7ybsiF67EU1i4b+REOU6WljS7h?=
 =?us-ascii?Q?HJw/abFwfnx+/VBBcyCTTPGSQVw6Nx9xyiWl9OhO5uDjQoMC4mnaf0vswach?=
 =?us-ascii?Q?hDH3kkmwymagm16d+bxgjNiBzv40CtEHuMdENS93D0KiUGEIsDjQo0L7GroW?=
 =?us-ascii?Q?BlZkB6UC0cT6XZk8QKZJYCQ9GKPDhMUFQIseeyzHF/pcVpSE7u+VJn1ixkuu?=
 =?us-ascii?Q?Im9nsKplj6Dz18Mh9d/HFxheco8eimtPnNZjYl8AzsONVUZ8FyJ2r9lX5Rbv?=
 =?us-ascii?Q?72pxMfxxVHX9GIEbiVjbd2D+0DLAY3BvxA0XV6iGjWqOk85TutrcdekeoFVk?=
 =?us-ascii?Q?NnU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S71ULrciHvLsCkSum58H7/xvV005NdCrJglsqEC5/TmgS9gAlptmKEt047T1?=
 =?us-ascii?Q?TIrOvyRLZW2Su3TEfvreJTif8QteLrYMFIVpXY258lwQzQ7ILCcQuc3rNp5Q?=
 =?us-ascii?Q?PrYiZpF0HV+8Dgz439NTf0l9Aot+b7SijvCxDeuuYs3GISWXLW2FyPq4CCF2?=
 =?us-ascii?Q?ORP5WIz/TAHBcyBVueFoIHYL1Lt/yubvdG9vZUbks+5eVBeAyuqBK8GHWDZf?=
 =?us-ascii?Q?QZ2xscEZPVYz/VcQ3Azn/9PdhxHga0KeTkiAaZR1lf5ni1STm3IRDfI9BC/E?=
 =?us-ascii?Q?1Cp+PpCrUPLcuIQTjp/TGmcEOz9O8zybCZJqjkwwYMcIdSK0LZ0eVaik2v4R?=
 =?us-ascii?Q?drc7Nz/QDmEX8mN0R2vuH87/cAjUzwnKC7xe60LoPcQgld6Ye6sh5bfGKA/t?=
 =?us-ascii?Q?oCDOcXir5lKioPWMsHhJ0Fj9GZWes+0EbC+j28Uhv5DoZOQyadesiKJngyI+?=
 =?us-ascii?Q?oHlu3L6LOvIlgn/3fSAFkhSrqrdrljhGPsfuTuazqk6dhaa8CuUikPwCIo59?=
 =?us-ascii?Q?IWMva8Xm+pxsgblzL01+jg5SZMhlwpXoQXr5XLJAauMNZH838T8AnPVpybUm?=
 =?us-ascii?Q?+VlVmJAk4/wefW6XF9sZsEpzDe/KbAI2jiETDOCtiDGqEaCXANtEXptmwkUs?=
 =?us-ascii?Q?3DBRrvFvNCTwmvsCRFKl7ELySLDOOy1p/EezAIgmAfqeWnLzC3kTRT0eoMs2?=
 =?us-ascii?Q?k29KNJmzphDgdRzrr5yC23n1nF2IpVHK0ZBT52z+uUnVdaIfXnxWun6TCJgu?=
 =?us-ascii?Q?IGMdGM05h1+h2Nq46zfCOYCtxV9s4KEWAztZqEGHGd0c8m7KGL7ePafhxjhH?=
 =?us-ascii?Q?EmaVIboFnYMKfU7BjZFgdvs1+q5bg7hVM3um8k10lCuJQQ7eZI3qMAH8VJPb?=
 =?us-ascii?Q?Omf60kyOUBxnwfpciZkKyV8RztJrauEJ96ip/6u3xkNbYq3F9Fw74YbfleF/?=
 =?us-ascii?Q?RSzHeXRrZ3VoIoM0EPfHJYn21dESPyApcV3jeaLFiDPxCzEiU02YVO+T84uB?=
 =?us-ascii?Q?2ln65ea8Pf8MuRR0+CC1Ksi0TiQgAOJJ/4OV3LyQgC5HM4afMbvjfBSwtMCc?=
 =?us-ascii?Q?t0UZ0ZsxMLNInEoCEp/uWY0RBh8jNL0QromJKXt9cCJtBYCCz0nhDupl0iYD?=
 =?us-ascii?Q?W4c3oCkHDs92W+qcKeEJIU01aot2kLAgsOhLQUNi0I9M1ywKtqxNRrOdk+WJ?=
 =?us-ascii?Q?rFhm/HrpTGQz0/IpltyGSqZdrn00y+HJj3fVotpHZ3DBROkCw7Ze4h6pbWGu?=
 =?us-ascii?Q?RSsyvXT/BXkMDgkMt+cnRv/kUNNOyiqXq7ozxrmagEU04scbwRM3o5Pj0api?=
 =?us-ascii?Q?xtUx+LpOWudxy17K2FSH0P+mphySPu3rW0XWiDqcFuT4tRxlxyTGO4TgnuZc?=
 =?us-ascii?Q?y21mcN8oAj0/fK42O5OjkgzIUvuGjcq3xHfoNvLnBwZz4yBpA4fbbujRJae6?=
 =?us-ascii?Q?vZh2FJXF2M4pxIPT6HrcAZLAuYS3JA5kd2nNCGR+Lzuuh+X22I/QI/CBEtgC?=
 =?us-ascii?Q?93iWiLNRLJ2dQtIGNh+u1xLRE3nZXoAmZttjxdChk0ZgO3gHUaL6CxE9RDNQ?=
 =?us-ascii?Q?SPStESKJ3umYiwVGsasEKYjzW4NxTYciBchQnxAwrf9Res558yp1fIPlXDHt?=
 =?us-ascii?Q?99+3D70u2Pvvk8F7Y1mW5G0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NDUgEMwwY+LyLHz4sgnqPUbNNIEN7IXv+8qpijK3JkvdPgi/D5OtOihLGEC3kWPa1HSP+K6JAnJsW6IBlaOXAkyKAvhC/W8cP+Q+AVbSM31AYXk8yQUDfp/7wxR3SQKRWS7HyaLg+QOzz9i2hXaaL0EVxBT06BE75APD1GN4kFo4y4K8q4WjNZfhlnBsweCZE9PE2IWUOdMYlL/tcTegxkZM94c199/d3FgSfGezXxaULnlhH1E1mSPA56mxnsupB/LnFtC7WoRcKJYZplieYiT25OSFIAzDvWEk3nCL3IsiMc2FHw0twSiA1iq+qxVbuBg5n75DnFLg/adOlKQ7s2G4UD5S2047x6ZJmn6Wpe9Z2QNNEKyIGCbbckvKK3/Xea1uFmCDRShJkamXRAFlPQ+D4mqPOLym0Dx+3c/ncecjj5xg9T+Rx7Q5xFnWbcxJ9glsUf6kb25bQj1fbJYq7f6COZpK44jH2nnA+KOcr2oT0giAlrIDuXY9FNCkmAoo25qm3YZgGaUmI0kjFFnRS1yJdgn3SubFXkLAed5aSyilyAVwI8Sl3f7XAN9HrpRvErhLuRISQK3LjOkOCohFPha6YGzNLfmAH8b3Hk0wErE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c911a8e9-5670-4d87-a511-08dc87231f6f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:30.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLgg3NvhhuhHew1lU1WogLLUejR9o8pMcghB5tYaZhknT1yZIVUyP63KZJO5yYrVXUs1RvsGKTEnkt15ykUYEfAJynldO9cpyKH4ZMDQRB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-GUID: S9nHsH1Q15BLfpU4Jn4wWudH6qlOeCGm
X-Proofpoint-ORIG-GUID: S9nHsH1Q15BLfpU4Jn4wWudH6qlOeCGm

Use mas->store_type to simplify the logic of identifying the type of
write. We can also use mas_new_ma_node() instead of mt_mk_node() to
remove b_type and clean up the local variables.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c37bfac4f622..743de734ba0c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3431,18 +3431,14 @@ static inline bool mas_reuse_node(struct ma_wr_state *wr_mas,
 static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 			    struct maple_big_node *b_node, unsigned char end)
 {
-	struct maple_node *node;
-	struct maple_enode *old_enode;
-	unsigned char b_end = b_node->b_end;
-	enum maple_type b_type = b_node->type;
+	unsigned char b_end = 0;
+	struct maple_enode *new_enode;
+	struct maple_enode *old_enode = wr_mas->mas->node;
 
-	old_enode = wr_mas->mas->node;
-	if ((b_end < mt_min_slots[b_type]) &&
-	    (!mte_is_root(old_enode)) &&
-	    (mas_mt_height(wr_mas->mas) > 1))
+	if (wr_mas->mas->store_type == wr_rebalance)
 		return mas_rebalance(wr_mas->mas, b_node);
 
-	if (b_end >= mt_slots[b_type])
+	if (wr_mas->mas->store_type == wr_split_store)
 		return mas_split(wr_mas->mas, b_node);
 
 	if (mas_reuse_node(wr_mas, b_node, end))
@@ -3452,9 +3448,10 @@ static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 	if (mas_is_err(wr_mas->mas))
 		return 0;
 
-	node = mas_pop_node(wr_mas->mas);
-	node->parent = mas_mn(wr_mas->mas)->parent;
-	wr_mas->mas->node = mt_mk_node(node, b_type);
+	b_end = b_node->b_end;
+	new_enode = mas_new_ma_node(wr_mas->mas, b_node);
+	mte_to_node(new_enode)->parent = mte_to_node(old_enode)->parent;
+	wr_mas->mas->node = new_enode;
 	mab_mas_cp(b_node, 0, b_end, wr_mas->mas, false);
 	mas_replace_node(wr_mas->mas, old_enode);
 reuse_node:
-- 
2.45.2


