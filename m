Return-Path: <linux-kernel+bounces-519562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60F3A39E16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9EB3AA35E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4452269AFA;
	Tue, 18 Feb 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O7P6I5XV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m5x669dk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE061E526
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886839; cv=fail; b=ASWqlubGWFfKzf/jXbsBiLBOtXLwDl8QbEMibWbiLY+9JGqtdgg/CHRjeI5n+QUsvXSg9RBIKyfcSsp0k4zR+l8AG2fQHG+0hDrby/DnLrtvdEeRyLIdqKPVrMgJ2dbWfgP85Ln/qhrvdKQ4FDl8N2K/Z95OBH2mqf2IKH3nYQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886839; c=relaxed/simple;
	bh=8dQkiXGNAs3ODK/FoXPffi+MYhBPY2XEvS81lAeZGR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MoBYkiEjczwTqPOHLIuy9/eDwI7PoHZ/lh4ohXdrvFx5wU0TEyp6mfTCxd5DAzOw3VZT8jSGZ5xWwmkjJmai5e9opvSaIdWZkCJuMmF3kjejUgOWtMfukb4ol+iLDm5AeSr3B7H9u8Txu8AOFt1ukE3kTmDKNHzCkqHP8vk7L20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O7P6I5XV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m5x669dk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IDWtmO010231;
	Tue, 18 Feb 2025 13:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SqN0kBAb3ydrs2N86VOVONAA/Bmqd0x55CW0lHi1eyg=; b=
	O7P6I5XVbu4Xe5ZhblDR+S9n7ewVuBEJqQ+Yd32MK/YD5gaDdOsulWDrWCzu04da
	aoJWcOisfi/TLU+1FRQn7hIrWCmnpGz5OWs3Ryd/Vkabjz3D0U1dlnG1mV5Z/Nh9
	eeBqgbIu+T8F7wERNr3kxiELU3JPiswZ2Vc+v5DFKytg60F4l23VKr+r/rtMqDPP
	noB1zw4WgJwXjupKdYdsHaNAdmTQe08b1OQhd2CsAWK1xDNZ1ehgd9lnhUeER2Oy
	ZNvRg9XXX85ek48wpd59vLr44EJ4nZI0nNplS1DYSXdyR6q0B90HHL1ia1oWihUv
	P8d2+tg85AeSS5ds17ADiA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44thuaeg79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 13:53:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51IDpvHV005104;
	Tue, 18 Feb 2025 13:53:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44thc8t3x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 13:53:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOaZmSF1H8bdnqlpn1flCdfuFCr25vna1LSALB1dO+VtqyzwPpCCo7DFY55yohBaM23hAXymkw/EWppMKNYmR4DQIh2m3eEBOhsUJZgu+rsbtxe5RmFLYYIMpvJjgrxFvbUhXjLGlSujA2bFB5H01KVnLxIXDb4qDT3VVhJsWovvy07zFIriMa6JezHjuwxqbvaxJA0OqFcOf+wiBLyq/lrwnd4v/n6A6/vSVEGk9Zt9jmFtXt2eXNB3mh4bN5xihy1I8VhbCDFfcdquGUyp8C8BN7ncC/zPFbO/IyHOdc9H2O/jN63trjsMZQ4JsJGrUbvc5ReFy4vWjzqEHL6m4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqN0kBAb3ydrs2N86VOVONAA/Bmqd0x55CW0lHi1eyg=;
 b=EZFnHy3H5MKn7B8jNdG3CXxOFegQLj9fgdxiGO0+pgeszjxBdV3TypArGTNNx+9Woee/xBDspm9f9aVxL4tU9a+JObSY0rqXegfU5WrYzSE5oMYf4olbRZbFep8nTQE4QeSU8JyHy8rp/ZRvZ2wvGsg+csr6pFIEU1D94KmdohHlksxK6mCGj0zGZfzweOJPlWUa6ydI5w7r2pUES5gXuaF8CoqZkmZNEGCPLFlYPQg5dhVBksrWRlH2B7hL25/JQVoqBNozHNjZxF1970d96/MwNICGD97mITJ3ts4tecjUKZdnpPrHYAitqoJP5ucZDVtj5pLXWT6HXFbPQqrwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqN0kBAb3ydrs2N86VOVONAA/Bmqd0x55CW0lHi1eyg=;
 b=m5x669dkpR4UAStx4LSxUSUnY7s/iNdG7apYP6D/s0EkW148vCkty4jqjoq6UzpcbKJ0DSVDvHf3cb5gbASLPNTM2oHs4EXVhO1JACZTjLEIQNlTWsglk7ynKezriNbhVpuSx1hEb16MDUJdDYmkSmpBjJlpN6vNJUu9Ub07pRk=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by MN6PR10MB8093.namprd10.prod.outlook.com (2603:10b6:208:4f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 18 Feb
 2025 13:53:52 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 13:53:51 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] CVE-2024-56642: Fix wrong fixes tag and function name in commit message.
Date: Tue, 18 Feb 2025 19:23:44 +0530
Message-ID: <20250218135344.166491-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025021818-police-task-b198@gregkh>
References: <2025021818-police-task-b198@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|MN6PR10MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: b6aa9b07-2839-46be-1e30-08dd5023ad11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rBiRs5Q9fgIHaQKS3tZ9TTa9xakhTPlwE/yX5P4qU+KLhVU5QiFBSJ73T383?=
 =?us-ascii?Q?LXg5vg2X8zbcCpj709Tb2H8JYGWr2yODd2UXUM7Kv1Q1yCii8OU8yYey8LAe?=
 =?us-ascii?Q?lZEp/XkRXDcxFMb4aoSj2xM+8TrLyDdTdAu2jnULRJ0hSQ8Laz3DVCvvhX1u?=
 =?us-ascii?Q?dG6SXHolH71+UMKrRK1OjwWGpdFEwo5f18SfCuMfmRkkEkMf5tB9n0mYvmmN?=
 =?us-ascii?Q?9iWKLZ8z2PcLy47dmQbu8OAJidpJSgUKQTNMSWZWVjhFrTb4YnoEv92/MpQA?=
 =?us-ascii?Q?JKvn5kC2McY3JeNAuH+bDNtC8HCXF0nuIXVvnff2lTH5Ar+3RaV5r7FMjsHP?=
 =?us-ascii?Q?aQBGNGJh0v6R5CegZyNiHd0r0npV/s+1f5GFXV9lrqyCutrgqlO9eYnHfOJt?=
 =?us-ascii?Q?R8kAxsRmkO+uewk9QHKIgPYxzPCpyiO3UqtDZvFDpNYWhm58fJOGscMmWy6J?=
 =?us-ascii?Q?urDz+arh843AVI0KANznIvxKrrm/Q6TpS6VW1HkjMy+Ynu6AxmPwAHtO4Ugs?=
 =?us-ascii?Q?k53nibi7JIm4vruS7kmq6H8fB7O8U4LOsqOGHT8j+QMbU7Vgd7iwFeBbmDYC?=
 =?us-ascii?Q?2K+H2LInWQQu9Zx7hZ6tpzlNL87WwvXEB6A4RVeBhylJDzcf7KbrXWoSHjpP?=
 =?us-ascii?Q?XrXkvC2OFRt6SmKJ7twZXq2FfAdgoXdcFQcByTAPIugfbXbl40MBpgxuPjm8?=
 =?us-ascii?Q?jgBIKQujCe7x2jgRVXOFk+0FZQeebhSdMFYTSmoORMdTp07QT8VvH/JjzmUV?=
 =?us-ascii?Q?qA+lHYnkGQAnAB4A2NMzuukFb4GWfjmRKM6Ot+Wx9m827gpsaZ2O2TPvje8F?=
 =?us-ascii?Q?SjT1hqjOJEkpj2BoCciShS+7hNquaAlh3NPOwuVqP9zkpzK6SCo8oTT6waS3?=
 =?us-ascii?Q?UekpA8y405RAQb6lidNEmZ3HVmJB2N85TLEW+iDpc8w4Y3yuS5nWDB6sieOE?=
 =?us-ascii?Q?qMNPPJYJuUaVZeNdyDf/rVmPUDruXXLLPSoaGCJYlP1Xg0JfyVtrtyn58eJ4?=
 =?us-ascii?Q?/tdMlLWVKP6a/3WAFlKt1tl3KYlhN9SbmLOmptlXlKneFjXuJbSYhQoOABV9?=
 =?us-ascii?Q?cIRO9t4eduxCkcWyxU3OdqrtXev4CM44W0sYzvnDO7ROE3eB+Vi1aOVDYPaB?=
 =?us-ascii?Q?VacfSpnR8ArWa+oXXX3JYOhSuk4KJ6MWtP9SDVlBcKT82z09xVa4su6aCLHi?=
 =?us-ascii?Q?Gvo3HkkB7EEAtIUHXMYrHKI2RieKrn4qiApt2vWinr7ZJHXXZksNxXfLLyry?=
 =?us-ascii?Q?jUhoeYIHFVy0zwpys7SEPPeuNQq7eSO83pDF/Q3wBJ5GjP/VAnZfg8PnENtJ?=
 =?us-ascii?Q?bBkQ+JExB/mrKM/vFA8QBj0ErKDynVoX4LRe3gfF7cnGEIINmYV5zcWq/8K0?=
 =?us-ascii?Q?pWx90nU+Qa57EYTyvZ3opBfDD8Zg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jtiruupDEe/vy3phpPpz53OZZn0B9K4QG3t3TcSE1sSJSkACpK84uJB0Ko3Q?=
 =?us-ascii?Q?pkyXCC1DIxc3YYXBIQimjIsT2uA9OQDrtZAEhjTg7l08Kpb4WGR8Sj8COPfO?=
 =?us-ascii?Q?MknF49D1ciGyOx/R4gS6V5NSONMqqorojNG0j/xLcNzYFOjlqjfDxn7HV5ml?=
 =?us-ascii?Q?yi8mjyigAsZemKY74IWCk564cjhZ6islyafExgZSeIX4Ozf0s/rAnKBELMnP?=
 =?us-ascii?Q?E33xlfA5ahJxozPdSser+ZcD7ZStCSdaIa5yy0ZRhtOnbptun/58vcUrwj7n?=
 =?us-ascii?Q?cOUnwT0YRdUEbY5ipADhPxKFdvK4G7NZOYGqV+DS3IvhGz7gvKukT1yPi+dh?=
 =?us-ascii?Q?5DWiIWqtA9rujwBMvNkx9mTMd2t9RPgyCzcvuHHUN6+FHtFgmjBdOf+J78/L?=
 =?us-ascii?Q?/7CDMHNazlj4+8g+NnHpJ9vnlPWHJw4lFHyY9aZIB+G9HL/wQRJ7mB/Gygp3?=
 =?us-ascii?Q?XPOtqoUo00Q4E5phbco3NlrC1vPGlHYN6xCdzcmfK82x2SbVhuWtfJ/0j369?=
 =?us-ascii?Q?HdOg2Ye9JponDK8w+UUMgGkbDp0gOLuk12FxYjRcI24zoHk1ybExgdt7gwda?=
 =?us-ascii?Q?IJAbgmTgt/Evp/u7Y4nzEnjrM3HsWNHvjY+ye9EXtjWFat4P/F7Ph2yP0csn?=
 =?us-ascii?Q?doH3mSMZs8xwhYVv4SrNFlYmSc3ySsdmszKNR8Cq/oV/1wK+v1PXgX/BZMaK?=
 =?us-ascii?Q?lmZgK7piP1KrJ5s4xaTgG7/D4c70oXAgjo4d2wA/8pye+A5AiPjsCmILWnNp?=
 =?us-ascii?Q?F6cL0J000hBBWHQgqHkA3IyAp777S6uhZGVsY8FecSIft8LOFcttFmKiGOSc?=
 =?us-ascii?Q?CievnGcB9RgMe/cmSkWsLHWuXd/rNECPTciHHG+8WG/nYdrbakA6175Mih6F?=
 =?us-ascii?Q?d3cg+gtAp+10Qa7WZehH9n63PczOrYgIn/yM8vdViUuWo81s9yIV3Up/Rf/w?=
 =?us-ascii?Q?S7Gh/I3n15GWKCrm6iQ1wbaQJFASu5mtvCOrdDYTKtbaMmXnIW7f4o2Jewo7?=
 =?us-ascii?Q?XCKiSMqtRx+eIyZZlzj6+yKxegj15GRm2lCSvVb7ipkvfhfrz9EBxwK87aWH?=
 =?us-ascii?Q?03wEu/neiqhvhopPw9+YpLbnijV3Cr4zpyjgGroYh/u7bnzkLQa8o+kLT/J9?=
 =?us-ascii?Q?Ym/7onO5GnO9BQi/nrvAT+EvfCu8W1qVG71E1hZaeXvyCMCic8kKJe+gG7rh?=
 =?us-ascii?Q?kxm95aV2mcblXc8/755EQGlP62tZuUXiZ64UKsFSks8mhzwFoc2pyHAZzePe?=
 =?us-ascii?Q?P2oApFTnGLehBGxVHr8CbnZ/JUBmBY+MqzMsN58+IOr4xzWEmAwW9UAnR5CY?=
 =?us-ascii?Q?R7t8gxzMGngN4HYb0gu5z/k2vmYAR6zoYaYwiVnhroxMRlkaKvtUemSfej6T?=
 =?us-ascii?Q?WAnVK41WrmqDoSjN1Vakixl7CC1PcOUBIyioAZaMKWxDaBNnxd/axvCXRAWz?=
 =?us-ascii?Q?3HXFh+wgtFBAB9h5pAkCj+Mp4yRMSrsewlv319/7LkLXBfjAE3wEPuAdcC0w?=
 =?us-ascii?Q?kYawSqCgvNfCr0ha5wFTJXQ8ANnHUpUuqYsTrpxkRodEBkZy92wC4IEqbbXY?=
 =?us-ascii?Q?oHzfUdd4cBKp/acsT68gBA2RfqcazAPLwClJOE+LLJVQALBjaTfc7UmKNsiZ?=
 =?us-ascii?Q?D+cJPxdifQBYcNzfZeeyIU8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LOOxI1qSj8OysacpCRv4+opdOIWSTAvgj+mi9/XX28BGSMMup0Tpu+Iwf7rjCdlUd08abpF7iLdyKT9+yMI4lneB5y+m9JXJuIe6Sp0thicpEJv0Ccj8xliN8j9ie62CRUgirOkNAsSQ3VkjIu+lF8hJYOVb/28v0GiKLT1ujHa6q8KPmCH0bj/iTxHcxj43NN7W14zDZocA8evJyEHodIHccEwjuVT/RTG9xeHc4RjoAT6KysfPnvuaYhDDHFZIoFzWK2NbHWX/NA4DdCx30Ju4AQZ0sYfG0hdY3eA0Pik6U9igO4A1dWFTrAsfWdO++rGNC9l0G/LBHuKAtQn9p6dUkwB2zfwUcWmBCCAPlQbWR+eUX0OsrRarqlVPVxkcSvYO+FUsynq5F+v9Rz9k/H5jfN1JLWkSmzJInVjdgaub2HwBsWlXQRPyDAxkvZAYHkG3/t4HnHK/yJeyPNkWmUZXgZ4tJcYNZVsnQXA+0nfY69qZhcvhZW+bU1iI+1YRE9OuftjiF0ix3782aOend6b3G0abVC9BR5beDZEZoEPw/xUQ4VU5tFfOZMBNQ/ksLFe6rKNmAWnvnCH5D4vLNmb8t6ReES+3Rt4HGQPELGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6aa9b07-2839-46be-1e30-08dd5023ad11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 13:53:51.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSbHV/PSfn5LbV5+xxcj5pJ9ZeFjuCZIDNMR0GiiGvmiAsAQvoIH8/a3zVMMlwNgUDbPSdObafMCv5/nz3ti3zOKCqT3grtzadUecbao6X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8093
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_06,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502180106
X-Proofpoint-GUID: i0JTIfgz-M7ZWOserm3YIr7Md98-EWmJ
X-Proofpoint-ORIG-GUID: i0JTIfgz-M7ZWOserm3YIr7Md98-EWmJ

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 cve/published/2024/CVE-2024-56642.diff       | 11 +++++++++++
 cve/published/2024/CVE-2024-56642.vulnerable |  1 +
 2 files changed, 12 insertions(+)
 create mode 100644 cve/published/2024/CVE-2024-56642.diff
 create mode 100644 cve/published/2024/CVE-2024-56642.vulnerable

diff --git a/cve/published/2024/CVE-2024-56642.diff b/cve/published/2024/CVE-2024-56642.diff
new file mode 100644
index 000000000000..b31d3694986c
--- /dev/null
+++ b/cve/published/2024/CVE-2024-56642.diff
@@ -0,0 +1,11 @@
+--- a/CVE-2024-56642.mbox
++++ b/CVE-2024-56642.mbox
+@@ -18,7 +18,7 @@ When bearer_disable() calls tipc_udp_disable(), cleanup
+ of the UDP kernel socket is deferred by work calling
+ cleanup_bearer().
+ 
+-tipc_net_stop() waits for such works to finish by checking
++tipc_exit_net() waits for such works to finish by checking
+ tipc_net(net)->wq_count.  However, the work decrements the
+ count too early before releasing the kernel socket,
+ unblocking cleanup_net() and resulting in use-after-free.
diff --git a/cve/published/2024/CVE-2024-56642.vulnerable b/cve/published/2024/CVE-2024-56642.vulnerable
new file mode 100644
index 000000000000..75eac70bd13b
--- /dev/null
+++ b/cve/published/2024/CVE-2024-56642.vulnerable
@@ -0,0 +1 @@
+04c26faa51d1e2fe71cf13c45791f5174c37f986
-- 
2.47.2


