Return-Path: <linux-kernel+bounces-309306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844909668B9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9F828457D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B791BDAB9;
	Fri, 30 Aug 2024 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B2fAM1Y+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="whFFMXVU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718141B86E2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041468; cv=fail; b=NgpUeMf2SEzxKyOabvOs2/Uk52JGHACBLpBI19O7YLRki826lFdm8eCWmrg/seOeN/lRfAxfzL/mzpgF11LnEdYqCdFpJWPLauoyVdP2m42eSoo6F8PafTvxr5nwsPwqFWWFYz8P+qdFId81AiIgPFD7S7EKew0AdxpkmaKOxv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041468; c=relaxed/simple;
	bh=ESFhyGVe1Sw5do66AOt3UxqRZlkCfH6kms3oEkcneRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JfmXqktK46D71uAi0TsiCpPIi+NHxuzwLkpEqFcb+4u/gT8YL3p2VX8uMl12Q9fMl1PEKByRTErSAHbMXb0v4sX6/eXPfzzkyV5YTr0i/idCcd5RCqgGOvjEHX9rPwr+lQ7/BOXolSiTtWD9usT0+tGr0VkneRf+aUkEEwh+wqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B2fAM1Y+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=whFFMXVU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI0TTG014448;
	Fri, 30 Aug 2024 18:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=qIoHvPUCvGwYLbS33Siab/t0SU7czQc2ciQfFTcxWiA=; b=
	B2fAM1Y+85u/XE0paIvJ+j9UZIy0pRXqUY3lTDiFUqeaiqui+5izIKtBZnxuCgO8
	UDWaxVzxu/wXgnCRcDY5Cyu0xFn46IVRfXDJdIOr+XpYmkV5LEzSC19/YYpL2MLf
	ZkYVKmX9yHj86OInDFb2uqBiUryiyCQXs1t4N2RAvqyV0B5fcHlsHDJ2wk5vJwZ7
	ZrJl4r+gxBw0cjJQw+K5A/Dw5HKbSq3+CqlGKNw/qIPGL2q0FXdsb7cIL0/flj59
	nQTg/DiY3ECjpiqJHUA5CRKP1qeN7B5FBf0tDiXdQR8tRR2q1uAEutStpKk2AZ82
	+XULp3pN7Gg85v4x0/MGhQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41baa916xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHGGsG017489;
	Fri, 30 Aug 2024 18:10:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5wru9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKKpqmiUGbsW7lOXoai3Fjoj9GRl+cClhhK+VYA7nZH1fPvGwbYRBhetkmpCNLeM8ztykYzA7N7Ah8/Q27MFV2BOwPL5t4xfptkV8RK3qCZ4AmSQ7Dg26x0Lnz6dOzX2zML1PyPHqJZFXP0ID/n+APhDOk6/y3LGOe88lSKa5daQQcRqGKt94JDMauLmnezUkDEi7earsP0QN8Hhk/aaRVyaSKj8hrIQwgT2gmxZTvJk+PFccmU3mZj+XklLBYMaoQmW2dzQ8/zKVuosbiMKOdtQ1+xxCba+Z3GePAZBB5n5GP0ACB6DFQqZzUcxQIRVxYJFTHLA+DRY/BTEJhChnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIoHvPUCvGwYLbS33Siab/t0SU7czQc2ciQfFTcxWiA=;
 b=qqqrH6Ucpp19x0uWBF72mDV4Z6mQ00CVECTWYm8LuxweULkX1bsdFQ7Lncj4yicjCECFPfDkedfcu/MXWinXcqtWx6E7iiuOimnv6+5XsG4K0YI6cxnBA5k27cgQGHN/+9pNaU0t739xPDo2Ht8OhEdrhXHaukX2DK4ySxU1d+n+taGcr2RFPNhLwEbOKCYv6cRP9dDshyRuv8mtuIxVSPyhN2IbX3+F3fPfV7v6ZieRpLdxMjRYBJS9TJa+p9Ff52yhf9GRMBIATcz4MfNZI7mQk6c5g+ozj7i6woV6+sdFQHRbDvv2lZ/Fi1DnDaGUMpQEpLi2lDVvnP77adqjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIoHvPUCvGwYLbS33Siab/t0SU7czQc2ciQfFTcxWiA=;
 b=whFFMXVU5hGx/CSM/nXLTPGvLmEHyY3zTCJJYiwGJYdcGfe+PFmZAdTyZeIo0YU8voHcspsGnPr3V6xg2QWllZDzbTmiMDMX+CEG8s1pM3M3R7/oxyRsLwLqrkDg8jinDjN8XtwCFO+G2pxcvsjr5iRhXc0hq7ecbK+mO+PZyug=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7276.namprd10.prod.outlook.com (2603:10b6:208:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 18:10:51 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 08/10] mm: introduce commit_merge(), abstracting final commit of merge
Date: Fri, 30 Aug 2024 19:10:20 +0100
Message-ID: <7b985a20dfa549e3c370cd274d732b64c44f6dbd.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
References: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0489.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d88bb1-59ab-4e8f-c52b-08dcc91f14ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zuSQF8VwkJkANU6Kpg8n2HftcitlJNXW5sjz2YW5ggWy5Ntq3CyGPz5DJMdH?=
 =?us-ascii?Q?Ws8xWwlj894tbQuIe2mq/0bzWKlgSBqyrbYKg2sWviob9JO4QSsAu0ngH+/v?=
 =?us-ascii?Q?UgwiYFFLD5mKUlVTuAfU/NJTFD7PyWYjAwfetRyp9bQSjSeGCnLPPL4JrjNX?=
 =?us-ascii?Q?8qvH2o/ooENMZeN2jUOnskudtIGoupPdF9PoShgTlj5j/YjvPb4vztNqXt2A?=
 =?us-ascii?Q?9geDX81D6iSbtSKMBhsVtRD5zQjij9aFGOWXt1GeAPkAuTPxLFR/hxDYekAF?=
 =?us-ascii?Q?z08wa+99xZjoJExSstZEJQz3L/Br6O8Tb/1FDrmWUOZRFJ4aknfodaoq0OmQ?=
 =?us-ascii?Q?T49y5WVEtcwpVzpB+4F2nkLuHq0g2mDzNP6b8Y7L/+NfMLjD/9C4+udA2H5/?=
 =?us-ascii?Q?oS5Bz71/PxP7V1Nfuz2AyTO+dKDWAx6O4sjBiA0Yky3nYRVeLPrkmCjRX1Cn?=
 =?us-ascii?Q?s9AA4/Q3OcPtRd91vaAZEGhWtVdRoA/uadiMKQSaJWT1TsLte0KABpqzsgg8?=
 =?us-ascii?Q?JVn9ywJHFSznsThIzc5SF1tjlgjHo3aLu5b6rCEBb585iQxzlX+B9xAPqyQ+?=
 =?us-ascii?Q?Qws9GPbR5oVkQ4/l17yVuITs13CNJINIJBqyTMBUO8adffCUDezyzJTflEBJ?=
 =?us-ascii?Q?kgAt0Q9p3DntMFyNDgHhUuLfmEKW1lM36Srb59VOCGjmEfVktLfv4Ta/9F0H?=
 =?us-ascii?Q?mXzS7d1TvuwWUdTa+rgHhnbsuP4cEFDSaBPxMUOWJj9eNwv8Z5UYSLj+OVAG?=
 =?us-ascii?Q?JDYNVjJrIMCKMSW6NZxQjs9HZ0pg8Pj4bJ6upnAyscWGhEgbxUiBV7RMzc4q?=
 =?us-ascii?Q?YCb9hoV8YZTFjcvI8HCixLnOZ9Dsm2+i3YEvcLB5qwe06dQSK8nNOcVsy5Au?=
 =?us-ascii?Q?fVxV4aGTbPoiZO5/IaHEGn+SotmafwDP8CmtxC6IXtn5mPI3myl7bk1b3OGz?=
 =?us-ascii?Q?uYmkbumIuoN4UkG6WFHzhrXctva+K1gyMwGo941EBMNTnkY3OmBcM9svdZFQ?=
 =?us-ascii?Q?6uYaFnQAYf0CS1J4ZkxbD1LHEFuM+lsBioT4q42BJ3c9AN/p3dUCEX7v6NrT?=
 =?us-ascii?Q?u8aM8vXYa8yZSZNe1TTdopAXtNrw+uXMgy2RL8ybrnhjKYEeBZi/NYEtJAxI?=
 =?us-ascii?Q?Fozn3pwTLgDZ4zItabi/sWwN3ZilCxb7xWBTv9d9eVYF0pmjeCFI8mdTNhr6?=
 =?us-ascii?Q?G4GSS9GYsRC0GX9UQ58DzIy49F55tENz2li20MwKtfSOXynmRW16EnQWqAAN?=
 =?us-ascii?Q?F2z5r5qS1Oz7TZUAQ/KNgyjNh32LxGu4sDKx/jtQg8wInZ/T1QOtTxqmwYdk?=
 =?us-ascii?Q?vjV/68cYklGlmXefRk2/vE0QTwrDxvSOL69RalJeoX5l6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?llFIAmnUNsCditAOFfLUP2xyH5tx5ZChcSAnPBMw85aiKhAMNZwuUhKfS5RH?=
 =?us-ascii?Q?hccC2s3SP3q3p9DFR+jBCIWXX8PM0PSBEjy6SVTXM+03Gv8swCB7vaU43zSJ?=
 =?us-ascii?Q?4xF2UHv/geQDgZi4HMmOr3iHP1Tz43ckRbg14xNTut1mCZpUxKdCgEmKUwp4?=
 =?us-ascii?Q?K52DDMyA2RTO4kH1i9NDnLH16iAIb+tomnIG5RpkUU5hgxmcJsGAxmrc/OBk?=
 =?us-ascii?Q?bui4TSDcSMoK1aiGESbWcvijPbA2qXRdUE7X6/EwwmvXe9BKks1fhk9N4qV5?=
 =?us-ascii?Q?qB8TfGJNsDdpEjEJoVUhriXmfqdHNkrY+BxDDpyxXuIBs/TCoop4XUuGvhAd?=
 =?us-ascii?Q?RbTCPqadzFL7hmyl68twdfaVkwDhnD6TZwQEqHzqsFk6REIqClXFxKz5z+3u?=
 =?us-ascii?Q?dMw6M0vj5i2q4NP+CK3vUJ4Af8sEeP62KiHPq/OAC7izeSziL5CRwAhj4fqI?=
 =?us-ascii?Q?n+MnjEE4nM7zzE6KPcrier+V/CVHO2AA2C9BuSKK7EvQkrwybmw4l2cpgGSu?=
 =?us-ascii?Q?hlB/YNjOuCeUCyVHM9LDAOjLaEZIHtZUykjp2GoSWmCLGUgDGeVm90m+0E6p?=
 =?us-ascii?Q?W9CpV0P8E/SJEWzOUKV/FX8h0GnoZWZlMLMFaOflEVuTuAZhMUiJ+qEq7rSd?=
 =?us-ascii?Q?TetUwnSrjvRqy8rMwcsyIyIrjMMcvpTnpQXmITDk7cbHVEE+xJCzsc6HBahP?=
 =?us-ascii?Q?+xMtncx83l3kEbzieqfEP9nHaEy7Qs/UiNdNqCM4FH1gZg3UH0Fh5khKXEDc?=
 =?us-ascii?Q?0LRQ7oYxfMnV1tMO08MdXQ+vT8ldAkS7B+rs1x0UVzJmgWQlybqhG6+9jUdH?=
 =?us-ascii?Q?OKYT7Bue94Ny9aOC5qbyO11nfSKKNipydXBkNZokKVy0C16pzMmeS9C1CyBQ?=
 =?us-ascii?Q?XVCKCw/oAfAhOmxd1gY/ROF4M05urz1wlHBctVjn7bBmWqiel1LZmq+KFkZP?=
 =?us-ascii?Q?ZsPk/yohb6h/aaYmXTDdgD/p3OoEgjpXJIS48fTvc6mC4Stk03LhuGuQ1uDk?=
 =?us-ascii?Q?PTCRXqS2vw5teZLpgnyQiLg1hD8CThott3F5XaXhQ8ltOzEGlTnXbIhuUCf3?=
 =?us-ascii?Q?UFTQMf5vrTyrzeQkqrnKEQveCyXP4aKKRDdAEnOQLB+di9tTCbaYq2VOgn+O?=
 =?us-ascii?Q?u2HVonZn0T5CHKuxvLqW4dPo/h73YEbe9F+P7oju5z7EXkpBtBw2rSxl2Uv3?=
 =?us-ascii?Q?cTKbRLdczEwnRhjm5HERVWQJJT2+E6NpEG+XsHSvlEWjM3uOqIsLEYWib91m?=
 =?us-ascii?Q?l0h2Yxxlch5yw2OWdDAa+FZRMqV8GddgpXGfdPJZCgv3Tb+ug0cximDPbCi4?=
 =?us-ascii?Q?l3v6ZDAZ1y3SbBXLkwhj9TLfVj1JA/nse9PEP2EKyNd8/gqfdggqk0n2p0IW?=
 =?us-ascii?Q?vh0ANibMBi+L/ISSFx0Bqezpzf6g66K3RXTIbWCSuaJlxoID88A8K1SJzfuL?=
 =?us-ascii?Q?lfuTRTcnxHsqxYtIbyeOyoPtXaJTqMRo3lkm1ton6LasS7nF4wINzcBBB69A?=
 =?us-ascii?Q?+PVMtfhkdIGvjOAAq8yG2CIoXfAFwKWp7u5lgNQx1Au45c+aYtjpFw/2K1St?=
 =?us-ascii?Q?NMfVMlZgFfCQFKS/oGxpupQraASRLBnFCwoAqUTrHBMHKG0DxdbTLsShfVhS?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gkrUezhxbcjPBglGp162JPR919UBNOO9ShCtrcDdRDOrokX2lncidKCGzcjINfSnif7CZhP/FUDSTrbUvwzYv9eVAQWbdyyCeYQ0oDzU8cOJRbcgFOXhg+pg67qv/SQWXuH34n9nSizz/++lwgnUblCNpMjwHIa2CuNtzjHiK3jIMfa+OdkiYIxRCQ2LThjWInOuOS13xS/BYPu+DQFUvLM7kE0pNToCfaT5ThdioOhyC06F0vYkiLszIjec9AMw0MQPrd9iDt5IvCzdo6b1NmoaK5CkkaL79S1QtULNreK6Lp9rb3Uo0oYZFQhiTnwLMSFHLTtQJVNKFiq1TwHYG7ZIJ1Vsu4So0xOSDqYqvbMEhzz09WVbT2S/dLkj2+rTNmw7A55DR06qOaJy+ZNPBPVulcq5kTipqcuxFpWLW+f6AGXy2cpYhy5ZwrmwGS35aHoyeybAA9n1rSsEaFof8ju8QVzZ9+cskvMnYnrNxWfkNy4Xy4jl2Xj8q+DRJjRel7GVuCyLzpbEPeiw10Lo9hGPySPjh981pgs+yBUqtrg2U2q4ymHvYwYPKQ/3etZe00Z+A6DyDG/yoPbkpm7XcFbJHpufC8nzg0ev7QiX+fI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d88bb1-59ab-4e8f-c52b-08dcc91f14ec
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:51.2584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at0y1F8Z67fj6ADpJ0Q5I9mt4iF7n/ZazggN6t9P8T8tcCCzYWSeOgRNx7VOuUVU8Q1WtsnX4ejw+NESyfO4JmRmqc/XbtTc1JtpM9tULJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-GUID: 9u6lph1O55kfc2YFbuoz_DmvqNPXBxKA
X-Proofpoint-ORIG-GUID: 9u6lph1O55kfc2YFbuoz_DmvqNPXBxKA

Pull the part of vma_expand() which actually commits the merge operation,
that is inserts it into the maple tree and sets the VMA's vma->vm_start and
vma->vm_end parameters, into its own function.

We implement only the parts needed for vma_expand() which now as a result
of previous work is also the means by which new VMA ranges are merged.

The next commit in the series will implement merging of existing ranges
which will extend commit_merge() to accommodate this case and result in all
merges using this common code.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index eb4f32705a41..566cad2338dd 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -585,6 +585,31 @@ void validate_mm(struct mm_struct *mm)
 }
 #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
 
+/* Actually perform the VMA merge operation. */
+static int commit_merge(struct vma_merge_struct *vmg,
+			struct vm_area_struct *remove)
+{
+	struct vma_prepare vp;
+
+	init_multi_vma_prep(&vp, vmg->vma, NULL, remove, NULL);
+
+	/* Note: vma iterator must be pointing to 'start'. */
+	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
+
+	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
+		return -ENOMEM;
+
+	vma_prepare(&vp);
+	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, 0);
+	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);
+
+	vma_iter_store(vmg->vmi, vmg->vma);
+
+	vma_complete(&vp, vmg->vmi, vmg->vma->vm_mm);
+
+	return 0;
+}
+
 /*
  * vma_merge_new_range - Attempt to merge a new VMA into address space
  *
@@ -712,7 +737,6 @@ int vma_expand(struct vma_merge_struct *vmg)
 	bool remove_next = false;
 	struct vm_area_struct *vma = vmg->vma;
 	struct vm_area_struct *next = vmg->next;
-	struct vma_prepare vp;
 
 	mmap_assert_write_locked(vmg->mm);
 
@@ -727,24 +751,15 @@ int vma_expand(struct vma_merge_struct *vmg)
 			return ret;
 	}
 
-	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
 	/* Not merging but overwriting any part of next is not handled. */
-	VM_WARN_ON(next && !vp.remove &&
+	VM_WARN_ON(next && !remove_next &&
 		  next != vma && vmg->end > next->vm_start);
 	/* Only handles expanding */
 	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
 
-	/* Note: vma iterator must be pointing to 'start' */
-	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
-	if (vma_iter_prealloc(vmg->vmi, vma))
+	if (commit_merge(vmg, remove_next ? next : NULL))
 		goto nomem;
 
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
-	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
-	vma_iter_store(vmg->vmi, vma);
-
-	vma_complete(&vp, vmg->vmi, vma->vm_mm);
 	return 0;
 
 nomem:
-- 
2.46.0


