Return-Path: <linux-kernel+bounces-220177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9130E90DDC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C66A1C2338E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B29176FD6;
	Tue, 18 Jun 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IIRl+aEG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l/rGJPax"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF118132A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743732; cv=fail; b=ZoWJxbPR29cy6FtFaOlDEThhYTDryjScHQ1AhzhDtMY9vqlJzwP7u19nw1yOav97b0XcHnfCfM7cusCyXfA0M5KMZ+x0vpMkSzab3Q0k7s8eGFGv+QrupHXXBCbB/02L5o2adW/CikgwmZYexeG7wiZK1XbnyFSqxytF/LujIE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743732; c=relaxed/simple;
	bh=hu+doLv8M+P55PkrROtDZk5CAUz4nhaaviRSaBvqrSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nZa+7D60NDTvluTFQSxfAMzmDrcUXTE9B9SCqvmxrjl6NrbMiZhXqqGUWKxasQLStj7VUJllX/nNJ94IcXgmrQSJCdp2nIyaSFcsTKScxitndafcFEfW8I0CKyJmJvkSShEGD03cFvuir9yPqz89RqwZMWC/gao7zOq5r1yTg3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IIRl+aEG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l/rGJPax; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIV0JD021561;
	Tue, 18 Jun 2024 20:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Mr7ZCZdBNUuLIytxDOxFub9NGBSHRTcM1seHAm11Q1w=; b=
	IIRl+aEGRyolBpHTkebEz9fR8G26yaPruGdXMXA42lqJdGOcOL7ZAA5p9NDFy4QA
	n1GV9J6pAhVbb0ED2eQqJNQwGwU05JvrZagI0JuMiLICSn3TRY4b/PXhW9DCvIKq
	3ljc0qu+e4qBKWAKb7MUnufjIFhBfTMX+ELbYTPFk7E4I6Bi2f+llmSAiirwTXy/
	eWyoWo5MhZznYxMlRVI8+fmM5/e1M7aEVj2dvgZ7WLQF6GRNBdX1lAH39721D4CN
	6evPLsUZC3d3zA5crGy4vPo9+Jzt+pxDbQ3VXQkhs8INL+qeTDtUTfuTgftCCqLe
	2UBBxV/oRQS0AxQ+IRpfKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1cc5u8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJeuRf034707;
	Tue, 18 Jun 2024 20:48:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8p6p6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFaQs7Q8kQPRVV+O3q7DbXJulr29DuqcH/WSfYqJpcaafAmhGCgT3dWwcGPPP0jGfmWjC6i9VkBRc7lBl5L0qhPs4dBBvaca8LxJPIQrr6wmGqPZ4xauYnWxBnuRp1jfC88n51RiF0kiuaRSjPBdF2aXN4pEvKZtsQ+Zcoi1/i0NURDGQjEzuqLN3rVYv3cb1vr4feLVRRyBXYOBf4G5hQuSrS1w1Z11mIq+YU4NwfCbJ0LY8WMO+MTuKlBpEhbBzjg+6yWZau+w1aP8Wp8ca3XTHNoTA0VWp8wfd73K+CNl4W66tRV1TnBVPyJXvh6AEvOxmYG4TmYF5d5fczn2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mr7ZCZdBNUuLIytxDOxFub9NGBSHRTcM1seHAm11Q1w=;
 b=ereV4egk95cQzQ4BZaQJAhInEWyy9wt0q7RMvpRtT7oIbqWoEAuXDzfvw/w/sJ7rXRdMhrCffgHaMXsjJ5h/jdkqvXTLyb7eYpBaESYRbOY+4c+Yla570Ot71ZEiFoepBW29x25b7kyoaJotmPT+DKBSD/bFw1YOLI4Ty8M6V52Uc3X3eJjUTSEB9dARbt6OZ+LAWM0A1Kdux9275unEuKUhlO+ZI+/85A0Xp7+cg1+VMZ4pOdcVorQXYdFvFPRanu7Kr6mRbGIPk47TV+2nJtpqOPPfnWjrH/RiCh43TChxlfI3kO0d+Vl+bXvbJg+vNbJflUY3D0PGFRmEyCjqaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mr7ZCZdBNUuLIytxDOxFub9NGBSHRTcM1seHAm11Q1w=;
 b=l/rGJPaxN1L4W6UCT53WboC8Chgy/rZI8UZPGPqe9Q+J5AEcHfLwCETE/pYMrZjQlWybQnbQfUn9nBID8wOKOF5eRa6chBlFKC8/lhQb6QRluMiC0Q8CGM0QJp0kt0W1fpdlYytWVS8ZxfEilbBdEg7/PSDOsI1rhjufLnTBB7M=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 18 Jun
 2024 20:48:06 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:06 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 03/16] maple_tree: move up mas_wr_store_setup() and mas_wr_prealloc_setup()
Date: Tue, 18 Jun 2024 13:47:37 -0700
Message-ID: <20240618204750.79512-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0055.namprd08.prod.outlook.com
 (2603:10b6:a03:117::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 8611efc6-64af-4cdc-954f-08dc8fd7f454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hrFV/yvpCJOJSYFS+Hhnk0Yv1gl/Y9ErTW0VrJIdT+kQ+e3zqRAZydZjsyR6?=
 =?us-ascii?Q?/MHS4Y34aUVt3dxc/KjcQ1PyC1zJjIDPHIWH90u8eBCsTmvazsiPbYm3PCbI?=
 =?us-ascii?Q?yPqG6X9yk/t6yLI/gOHwQJdfoEgXQExH5cyefSL9zOHdvdRdFxCRgYJHQJ93?=
 =?us-ascii?Q?WkUXCFtgCOG5FglLix5Y3mL31vTXHkss0XCz+XRsaRGe5Vj5oxq+XCa+P2z4?=
 =?us-ascii?Q?HfuQZc3/7t25MnqwzyHIb+PYI2Cc6CSm/mHZ8zRmkq4TUjt6MjFbdfRbSB3o?=
 =?us-ascii?Q?On1jnE/G6ol5cPGk8smF8sIN/F3cEA1R0+x2EDIXunM3mSKAT0/daRFd2fI3?=
 =?us-ascii?Q?Rtn6OHzDZ9gwjOk3ylkmCSIdxQli+sdMeeLx4u2nWHQt9MorsUdPBdkzxS6U?=
 =?us-ascii?Q?KALJXs+UDDppirFJWwd9vmElZN5k0AjKDKletUCHLUsb/7BX1vHgryqaw9Yl?=
 =?us-ascii?Q?2Qw3XqzC+HmakDxi2Le4iNX3B2HAUGpo+8RSrj1HujmK+gfzbprT2dRJI/Kt?=
 =?us-ascii?Q?kUBwCpkyJtSIv2PgSF+2pxSuHfB8D1Y/Q1cflpw3GdCBhn97LzzKHx/oZljd?=
 =?us-ascii?Q?WRCw99yNbJoU/0qX5/10jXZBgIIEqTUTvlofkeVGyk6FNdvPThFrh7eSjV1t?=
 =?us-ascii?Q?jKuoHaPXi+UJGiHAaNfpgR3eJLwdkcAtfe/dDDTPzajF2FUrhS4T1KCfDmDf?=
 =?us-ascii?Q?H0xrTM8cIfUabWaEmlXwVn0L3JqJFBXRhLKci8KR27Mhndq6P4LMtA7YDKKO?=
 =?us-ascii?Q?FLzoN5Hip4qDoxOZmvunmQM2HAXFiLG2uTOHjn3AXGbqYAO/6llQObdXZ1wW?=
 =?us-ascii?Q?W26xaX09+e+A9zuAeHkdG2zpoxO8QLQqU/Iio0E5fpKyqr71lFXKOwkn3AZX?=
 =?us-ascii?Q?032qUjFhpuo+ZiJPRzwjw9rZmR4/ZxSC0mkCcMy1/EOuIM7168vgHo3Sl5s0?=
 =?us-ascii?Q?+dO7B6sUizhd9VM9dXwI8etjIM96iv6NkrXb1SUhkoASK3gggbnbuIVUKbxc?=
 =?us-ascii?Q?Tcno44yY0YbcsYZ9FBFZWb+/cusIy4XSDFZ7HNnD06/HGtxXTfr3QODT7f3j?=
 =?us-ascii?Q?FQ073bDvvieZ/J4iAFDeSmUiK04HFKzg1LK8l/0qblztX+9U3vvJf1RTzPt+?=
 =?us-ascii?Q?psfqmEYsGFG9eQkk1Xh4yPPeZGbtQ+s8qP8oHzV6HfEqwQK80+fNmbkr9Vp4?=
 =?us-ascii?Q?VBJudHJe47RPynKAHapMf9I8xyWC6UhRuTlUqC5V32bvnivTYXewLViFQn8Z?=
 =?us-ascii?Q?wFacXrDRj9WRfkz7JLfcnGog57AEP6W6wL158xbpxzSl+dTkY9BkTzA2Bye/?=
 =?us-ascii?Q?oi3Qf1kTlZPXRuyGiA6jbpBN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CVhrtDOz8iEiY7PixQJkerV4+e3VoqLsCipubbXQ7BGLxExwZmnJE452bXFI?=
 =?us-ascii?Q?VH5AFj/w/w7iRqmbFnZ9rvco6egi0VZqYRE+OgYxiTpSkcXNRQHQX/4B90cB?=
 =?us-ascii?Q?PCTKP0E9FjC4qcUJgHmKXiyUUY5AvyvMTuq7MEwXfR41BrR3uN/yqV/bzg/9?=
 =?us-ascii?Q?yfi7bMMwsIOoizpQS2hSVSVQSk8vGEsUcuk1AWdT/fRMhNBRyd0gCasD4Kyo?=
 =?us-ascii?Q?msERRapDrAkaLef6i+Bf2HpcuQ/GltG3VDltRuZYnUW81ElhFl2nkOMEq8wu?=
 =?us-ascii?Q?FUH0zsIryqrEFFV6aDXWamhmIztjy/VKXnurc67FfXnx+NXByrhWMHDmlu4D?=
 =?us-ascii?Q?wjAxfn1jjdvHfV7eFPsTsfM1ZVXaqpdH/jv8tWEQR5R742Ho9og9Q+5xwX48?=
 =?us-ascii?Q?hBvTBm7NZ4SfirSWqbWyiAzNehkLT+Z3LJu+rQN7VYNx4/03KLoY6eL9bGKZ?=
 =?us-ascii?Q?7neDESTYsW5X6kNF8yhQsJHpvPoidA6VMqMTfjGQNInEpLGKweEgj2KipoyE?=
 =?us-ascii?Q?wTDbkBeyelDWzdcvv0oX0YelTEZVOxW4WNG0J3VM1QS02glwAyKdZ02JY6U5?=
 =?us-ascii?Q?7bGqgHViaSbjkRtkLX03cY+v4XO9KyPcFcUat1FHL2S8qWDtVhgGJ/dy/Hc3?=
 =?us-ascii?Q?BbBhegqV07uuJpKeLbdb+NCTX5V1rZCahBRMfAhVJuwgPMDf6Ef1SVvt812O?=
 =?us-ascii?Q?ClZMQhaAogR6ZfyGiGB3GIySrlfWImufIDQXRDvSxXRF22BwmnofzM6h4ZrC?=
 =?us-ascii?Q?uUkO0CXhfxX22C1RrcGSrNoos6xPqjh0xh8DQPWAjzEHfacnLiD5nh42hfqN?=
 =?us-ascii?Q?ysG9hxj8jQ/4c+LBWQBL97YUhWyadz/0wShdHrCdlgr26MYeFHWiLZuKbGLB?=
 =?us-ascii?Q?KEmhFdkNqNx3QAhc8sOGAXyjZq38snJY4xE4b0GxpMvXw30puX5+vroPXt1z?=
 =?us-ascii?Q?ir6ztqTVm4vXqLstzgDuzY18m1cKspgXkrdY6cymJxYCE8BBGwuxmpdgGrdz?=
 =?us-ascii?Q?9k/u/oSk0ZTa+5hFIK4+Io0Cs4UZbILHxiqF2o1OP1YNl0SD5ROPiXRvoKCY?=
 =?us-ascii?Q?BRz/BNa5g/B49OM/D9XcovENpU9OLvaTLKasMhucDmPj9f+L1k2h+7/hc4+7?=
 =?us-ascii?Q?g9nS/F8j05qMKXClAsoaDSW7G9AR208lQAM1/nFagPAKQ3aRNYWtMPrCLUmo?=
 =?us-ascii?Q?0g7Iw1YWb8XA9WQ3F7F7/if8LtNnAJ/TbNX+9wauvaLOnwCJ7xCIQMZ3BCm3?=
 =?us-ascii?Q?dB8ITx6Y2EbNGeVM9MaW9ciMwaCW3JpAV2yD8Cy2ZwCwYLHhs94V01jsCf1G?=
 =?us-ascii?Q?icosP+xjBwLgn1hq/vR4DC9BzWXfot4wVFHG/Ug0KDn+3zY9yXNqKJayiXD3?=
 =?us-ascii?Q?bglqY2IrMjWJK9IWyRqunkfJJKV0MEjxLeVXjbHbXtvuKIPrHgNEb6U3vqF3?=
 =?us-ascii?Q?DzO4YAkE/tpgYgKMT836KM7DO1kIf1mHWDFc8/fwMjw0GytUFn/mguMwPu8O?=
 =?us-ascii?Q?vUS8PFIBgjJuvkizcfG0V2W0rqD/vnPIDSrHiEX57NlmdAC6JRAzP8QNlMDx?=
 =?us-ascii?Q?088LBhnZkbDNUE+DaDWOq0sEAaU/+jLgIg7ypv6o96cAcmB7JA1xFc9pW6NA?=
 =?us-ascii?Q?3oNeI07kiU3FsArPTh9We9I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z9ZE7JVl71J75SoLyAQY6HSQAU7nR25QXkuNXw9TK3K3VuLg/jfEC/CJmFLYG6nrGxe2PYKKWasuqwNCDvHgPkqiodSNvmVBipxAS5o84Kp5SyMbL1nj+a/cfET0OglJhMn+TksAN5oLbukssW2eMSMhss8pPAN0hs9by5UGmkp9oT3esBY7RaQxbZ28yvxLJJ7akgDlL18h0624FdDqmfdcMuiitOzMt6BaBU/WlzWe9po8H60EGl1QSedQaDBMDtUskYkj9vEzmsCu7u5M3Mt7QqrdXzo0lAGfiUlK9SGrTequ7QU4Wx0nxQ9XfrrqEiUtpeInkfryJcOB7+qZGz8VSjITMcvI5ZzlkDrF+leRGU+7IVOIczaOBysQBlApLjTeXsGInvLQX4GJYyecTnQhG3DZ01+3ZVbON2ga1vK9eNLtwqFOUWLbwp7mG8CGvjwXILjMsYpcJe48vIBR9YsaWnpKSPIymMJRJIQsGTDkRBeZy/9S+5s/cYPJXySXbNHGMD30DOTXp3EIQnc5xrjWalouQbzK2VkTMJBKow6Ha0iBruiIod/GqW6SwdBR2+lT+ideBhQiYphSF0rd7dnXR4Al9kWilQL2lZBjwvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8611efc6-64af-4cdc-954f-08dc8fd7f454
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:06.1121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehuVBZVWw5Jfz0sVddriFYgj3FqGe5DQ8GzG4rgNmdcn30T0bjiKRmUJ5Ab6SST51bIMQidNhuz+FFfNN8b4ZQ+ZRy5NtFT35qx0S+94RJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: 9rhLJK2pIFfwMyrpN25MycHVqCZqWx8u
X-Proofpoint-GUID: 9rhLJK2pIFfwMyrpN25MycHVqCZqWx8u

Subsequent patches require these definitions to be higher, no functional
changes intended.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 96 ++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fe490ec9067e..62b465f0d97d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4227,6 +4227,54 @@ static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 		mas_wr_modify(wr_mas);
 }
 
+static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
+{
+	if (!mas_is_active(wr_mas->mas)) {
+		if (mas_is_start(wr_mas->mas))
+			return;
+
+		if (unlikely(mas_is_paused(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_none(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_overflow(wr_mas->mas)))
+			goto reset;
+
+		if (unlikely(mas_is_underflow(wr_mas->mas)))
+			goto reset;
+	}
+
+	/*
+	 * A less strict version of mas_is_span_wr() where we allow spanning
+	 * writes within this node.  This is to stop partial walks in
+	 * mas_prealloc() from being reset.
+	 */
+	if (wr_mas->mas->last > wr_mas->mas->max)
+		goto reset;
+
+	if (wr_mas->entry)
+		return;
+
+	if (mte_is_leaf(wr_mas->mas->node) &&
+	    wr_mas->mas->last == wr_mas->mas->max)
+		goto reset;
+
+	return;
+
+reset:
+	mas_reset(wr_mas->mas);
+}
+
+static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
+{
+	struct ma_state *mas = wr_mas->mas;
+
+	mas_wr_store_setup(wr_mas);
+	wr_mas->content = mas_start(mas);
+}
+
 /**
  * mas_insert() - Internal call to insert a value
  * @mas: The maple state
@@ -5358,54 +5406,6 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 		mt_destroy_walk(enode, mt, true);
 	}
 }
-
-static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
-{
-	if (!mas_is_active(wr_mas->mas)) {
-		if (mas_is_start(wr_mas->mas))
-			return;
-
-		if (unlikely(mas_is_paused(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_none(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_overflow(wr_mas->mas)))
-			goto reset;
-
-		if (unlikely(mas_is_underflow(wr_mas->mas)))
-			goto reset;
-	}
-
-	/*
-	 * A less strict version of mas_is_span_wr() where we allow spanning
-	 * writes within this node.  This is to stop partial walks in
-	 * mas_prealloc() from being reset.
-	 */
-	if (wr_mas->mas->last > wr_mas->mas->max)
-		goto reset;
-
-	if (wr_mas->entry)
-		return;
-
-	if (mte_is_leaf(wr_mas->mas->node) &&
-	    wr_mas->mas->last == wr_mas->mas->max)
-		goto reset;
-
-	return;
-
-reset:
-	mas_reset(wr_mas->mas);
-}
-
-static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
-{
-	struct ma_state *mas = wr_mas->mas;
-
-	mas_wr_store_setup(wr_mas);
-	wr_mas->content = mas_start(mas);
-}
 /* Interface */
 
 /**
-- 
2.45.2


