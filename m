Return-Path: <linux-kernel+bounces-414433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54969D27E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E2701F26289
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDB41CEABB;
	Tue, 19 Nov 2024 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k1hE/KOP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZSspLBS3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62F91CB9EE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025754; cv=fail; b=c5f49Qp+l9WyVX6+V02yl1gSP7TwjuCnXiwymtv9q37HyG3MvEXX0WscmjAoHYlcwFFyzXPBqNZ6mPVWN5ApXFUHec+AoLhRf6HgrhOOHnEIu3yWj1NBiA3NYAjDeO+GQk1tgl8uFCpz8QDWUDuAYU521iUa9jIuXf9AqGOBG0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025754; c=relaxed/simple;
	bh=EiNifGEiyW1cvnPiW3CQWQp6nERwfWLBdnLRrzzaDKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HnZW891+K5fTEpwilqzjeS4+bsYjy3WrtiU4/cHZpVPSOtWCdBMPBCOYe4KXQxqX+V2suhOn4dDvMr7Kc6wUtQBZv1aZUgqDwWlnPblhx2TQLIDB/izskECR/0VSJRfdXFITYsuF+J5PqPO5WygG73fl7tVl/7GVNxjNyDd4IQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k1hE/KOP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZSspLBS3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJDilDY015076;
	Tue, 19 Nov 2024 14:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Ohhl+exibXyPRDIGo3
	A2PkK4yGxMe7Sie/q3feiukJA=; b=k1hE/KOPdvV0xW+J8Zhl7jTjeLH+5cPjtY
	7bXXeMERNkrVeLgr62/eKaRNX6rA3zIb//UTnucAurbQt53pXDhZUA/rSdCcFo6u
	M1OdNnoyybDscJqN0Spl/Ms+iuxjkbRie64bDdC2ymRuqea5cZfMStCCy5Z5W+aO
	ReMeE6by8XYpxwVc1POOw2cUeyMdlThnUR1kv9qxsXWv/Dq4uJOmG/q0M06J+Jtw
	2JSWBBx8GPi3qMsISIcelxpEoauN7YhRCRPMEKyixOMRWXSGJmJ4/UbfmwYqUmMX
	SSp5ZVBN0YYYnkgZ0mTZ1nW4KNI1nlwgNgqNegTY2oz+x8sVL/2Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebw1ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 14:15:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJD37V7037271;
	Tue, 19 Nov 2024 14:15:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8sb43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 14:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyXtyeVg2EzKUghUmB7XAL03XABLxV7wcbMLFaYQq7IQCfqYrVRtxuG/LddXgG4SeSMok5EDfkh4VS1712CotfDunfV2lwQWmLauJ6SE1UrRqnPNNehczVV+nPK4kTrMJvDigigS9ghkYrhUM4lh2dFuqm8huAh+iO3Xdaej30gneLI4NXvgMZRoFiSamUq0BGvQxx86e/0vk01S+w2pnBf9R+jAOB0oxBc9D1DapsJm7Be9QSLSjmeSoRxc38N2cexzHs7nGik6K1JIorN072bmH+cHJiGPv22ajDYWhJMkocDNdwtOzrxyxykqhBsqG5o6a2DH8JGzODXaDhj8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ohhl+exibXyPRDIGo3A2PkK4yGxMe7Sie/q3feiukJA=;
 b=hmuwMIrbQEPD9obXSqOosvStUpibDjLGzezKUfgb6qscSVt8fSNGu2qN3umOcR57Q967qIzROz32dZSjJESY6nxPv6NDuSsMiHxzH121c2b5RVNmEIjK8NtGDwmmCdrCtwgPkiNB9p21JWNLBTJeV90UNTZtTOvli2n3lpffI9MGosXV2iNkClZNjaOyKvcBqxdPlIutx9Mfqrs7IUvOR+on1xcG2nil7yQ3W49ButbIzWvWVEls5O9vpZctl9frwog/2AkqFksdyrl9njMY1eaVP8OR5AIu2HjcU4mkkwZTQy6yEDcy/yAO8/Ls8wPelSQGNBKxcc+cGo5YwIcmxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ohhl+exibXyPRDIGo3A2PkK4yGxMe7Sie/q3feiukJA=;
 b=ZSspLBS3xMQToKyf1st8FXOt7KJa5Nro0PIVYF952IUguNn8cEwKoy1QYV15QMwu7ooaSxUKs3estShR0N5T0/qnpynDRXzpZMK/IkyjCbC56SX/QueQMvU0bHqO6//N7y85SIzuflOgdv57DTR7sC/f6Ivrqho+z53u3dGwFTA=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA2PR10MB4441.namprd10.prod.outlook.com (2603:10b6:806:11d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 14:15:40 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 14:15:39 +0000
Date: Tue, 19 Nov 2024 09:15:36 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH 3/5] maple_tree: use vacant nodes to reduce worst case
 allocations
Message-ID: <i7plirck6zcsk4xguy4yonj2dj7dfdnvvsa2hi6sszfnpgws3o@xpzspa7wrtvq>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Wei Yang <richard.weiyang@gmail.com>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org
References: <20241114170524.64391-1-sidhartha.kumar@oracle.com>
 <20241114170524.64391-4-sidhartha.kumar@oracle.com>
 <20241115075203.ojspk255cw3sr3s3@master>
 <2aa439f1-d33d-43ee-9945-5ac570506c7e@oracle.com>
 <20241116014116.a7am7z4p7k33rkl5@master>
 <74e8665a-3818-4e6c-83d1-9a0220a79e49@oracle.com>
 <20241119023047.sentd5e75yak36za@master>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119023047.sentd5e75yak36za@master>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA2PR10MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: f5648db7-d701-4360-9c04-08dd08a4a551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/CHqkT8qiQ/WEggiPJk9vGfG/bwdXTwbcALfGWqvN4ArDSVbWh5mKkbG7xfv?=
 =?us-ascii?Q?tz76sBEn57RWgWwCz2ewx+j7djH6Q8qx+tVoWF8GYcUmNa4l6i9bDpD5p5/R?=
 =?us-ascii?Q?hHAwLhIdBOvR7Z/HiGUEE1EAUaPOT+gmssh8Obt2Rjzz/ZmpkhhmZli7i+k5?=
 =?us-ascii?Q?Q/9r4Dek5b6Djo94secZSGGwXjMHqFU8lRpRXAsWYvGIaEfl3C++qo4vh9Zw?=
 =?us-ascii?Q?lGw3usXWrubWuGJMwL15yk5NoQQEqlTC6GTXOmz6Z7x6HMvTJeJFBXy7Di+8?=
 =?us-ascii?Q?iCCfoziyHRqWrcA/RBzJ/cBrLF0wF6JDHFjqDY8v9NH00S4CFtfmfZqiOavo?=
 =?us-ascii?Q?S5LRW+l7qojod4hWbeIM9eGERMlcWLUpdqlIrY9iBtqRtgZhIBtNhxbEcffc?=
 =?us-ascii?Q?OxyEsMQqnG2g1MSw8mZlNM8hJ3ZaVQlGLIWC+M5PtxTAKOwLH28gS2Fq0dBv?=
 =?us-ascii?Q?M2oXaff0VqXJDOg1E54uqlmepnB7IFbn3Sl7ZG0VvKWgKeh/9GeSJ9giAuhk?=
 =?us-ascii?Q?tUCJ6nxdI+SIdmZMWIgnWBeBs110XpITlgAIWD3r377zBcYhxOkq4vTOKwqY?=
 =?us-ascii?Q?wuzQb388ghCMCDCNdZ18KyPNYKHUbtCQtXqGYDjcr1feH5gUFkYSvsLtXxm4?=
 =?us-ascii?Q?ABJy/FSTlkWJ9+BNHk/Q7aPSjoAeM+/5nityGWCULKf8FKWI7avcKCYIbxig?=
 =?us-ascii?Q?m1WVre5ceySdEPmpA+iANDIkgM1xS4bsonm4ho8BF+qhIH7qZ62rpWQqNcAK?=
 =?us-ascii?Q?2KriRfpX5wRd/GowAEMVwAToL2D2KEKceWBkSDhIgYRdGVXs9LhgJwW9Pzsp?=
 =?us-ascii?Q?r+QJBB6iAACeKu8nLuA44wcKCwa7HvBcpYxHiy7UwejtQJTcLHXxkZ2NaKuo?=
 =?us-ascii?Q?El53qQIkP40Vj0Isw+XgWy/MgJn5/quBuE80W8nWPPSiw4JYCCTXrMAkHBem?=
 =?us-ascii?Q?6zH8x9KOdVu+V+sgfx0DjrAFyhaphifpmPLMVlZqDu4osgAxOO+lE44BKo4R?=
 =?us-ascii?Q?0oj8bdYx5wSt0/JRABYO40ZVe+AhWv3ywKMUfBU8g+ZjnV/iwhy1KnAIk5vP?=
 =?us-ascii?Q?RAGwZRQx862M5CM+J5iFOSJHzkJGU86ZpZ9Xxwdy9eGZmSWF/CgWkbaosUlP?=
 =?us-ascii?Q?ogKf05BOi4MYEqXlqtuL4JoW0Co67yj7pBxTS5YFsnH2aYW2GlNoEEkYgSuS?=
 =?us-ascii?Q?yACXkLjc2teE9eIfMlTz5Gx529N3Nhxd1cc9b+X1UReM3zHwdHDdd5lXDQoW?=
 =?us-ascii?Q?dbx9NF12yp8ujhcWTMFPI7yxHPAWOedIMw7YgLrE5/7+jbvkJ8Fk/flHBkI7?=
 =?us-ascii?Q?9AwfoN9X1v0fBpyCYNDzh/uH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S78471vDl88EXegisrY4BmRj/WqneMtOdOD2/NyREs5Q1xfq93Llja2FOp7V?=
 =?us-ascii?Q?LNmc5xtnPkfVmNAMsPSRYLFpNjm6J1UvGSpILu1y2SbbNdmsJpjetYAcYiaB?=
 =?us-ascii?Q?LeF8zf8btp9d2v0P2nmFq3QTKiiPIpi58QwMgvNuYWte3oUTpVZ+F2wPWXsn?=
 =?us-ascii?Q?7XDaG09xw/dphs9Jp7DUkSFwdK3F5EDgB8ff45f7d9ou59jDBGhN9JpMOmkZ?=
 =?us-ascii?Q?jixLhxhkTAT4GE7iP/wRs274Oco4kmVPqQKH9hk0tNL3mybUrJoVtEiSftlI?=
 =?us-ascii?Q?OhtMmO8ckCfTd9qWUhjv/kY+/9nD+G+LB4OsTiduo/Ba1g9JgVKU8OMFKTNc?=
 =?us-ascii?Q?Awkkh1eD8PPeJPW24MYYQeZUtj0r6riMcijHdtx5W0cDdccP/rYH0JCsGcpw?=
 =?us-ascii?Q?yA+O0ed1Kh52YDblJVu89p8u0VjxzHMgShDNx/BElI9AcE884DE+ze7ir6NS?=
 =?us-ascii?Q?tkK4ejNSSygKJiOA+8NMS5DCl4t95dgSW53VimpJj9WHKyaR5FvHnAzOOMIi?=
 =?us-ascii?Q?0+PY+tpxKPzoPx0jT6eYdi8CPubOZx7s1PIBWe3wPZAsFLB14gdRyyMUO9aE?=
 =?us-ascii?Q?Kqo6Yju56Xtm5OfudoG3aE16BLfqMNMe43BTVt3S/s5Ah6nwnwZfkL9Mr516?=
 =?us-ascii?Q?rbSayuiCBLBsVeUfm38JbA9zZwbW/o72QBqT2nY6npj32oDO/+Ptlic9IrvH?=
 =?us-ascii?Q?CfDLgRHLzN24bpIWCborcV0lkEbXurwhFADjJ5YOWz/2cznyRjSroY5gI07m?=
 =?us-ascii?Q?xmr2E6RBiavEO1jsND6ZioKp4fMaxhoHUIJ2SufY4PaDJ9q7On4bugoVn3gG?=
 =?us-ascii?Q?zYJG9wrkengp2yzmiLts5ao2IjAlNBggY6WRK6FUWbl3rRLm9ijwqC821dCP?=
 =?us-ascii?Q?4Ua1PDU/YrNuRMgGyL8uwn9U/cyCEQZbYMnMxl92sdUfPvRImIbg57pNK6ig?=
 =?us-ascii?Q?myk5WKvpaGycEq9KXh4uV7Yd4vxhQ/s+zPZRLR3iJ25YifYchLQPgOZAJHHp?=
 =?us-ascii?Q?Op0CBbp7r4rf8/VkPmLDPFCnK8CrsuxcNjzUF5aKlKRfFHkl2y98MxBj6sZa?=
 =?us-ascii?Q?J3f/4wrCHMiv24ca29/ecW7ANZ1/6tkMHIxf/S9ChO2Tm92+rGqgpVwRot8e?=
 =?us-ascii?Q?J0N/qrexQdyJiLeC7AAVKTeGVOYd6ZMnWUrhvGdIHpWqGs7QpFuWvex//xoo?=
 =?us-ascii?Q?CvqYyPVwFA+GxKjQYOXzSRW+Imams2/HcI0ACOZSPlfW3eGHyPB9jFZGwr+F?=
 =?us-ascii?Q?oIR9sbPVggiop0jVX01Da5WhPH7CiR+UsnvKID6HHWB5qymSEZB1d6bCbnQm?=
 =?us-ascii?Q?LFwqd5V43Eb9+qJx/PxSOoGFZqHdpda0sSH7e9c54zVqSm8RDUOSoVHJxKnk?=
 =?us-ascii?Q?WYlvOTM+lpfchYgxDqEGfRt4I5KHIW8SXE9io5Fp++Xei3ajCGQF3jf82u0Q?=
 =?us-ascii?Q?VTPzdWDo9CUCdKHyfiUbSBPsqlxPDBU1bM2Awqg4bcxQY+FQmndm4r4ab668?=
 =?us-ascii?Q?cRPs9cFA9p1dXsExA0LSQWV1lNN+kmMtz1WTWSFX0I6kVzn7+IPx2RKkFly8?=
 =?us-ascii?Q?LB+ocOZXGIFSvuBwzjz6HmI5Z6oh4PmGUvgSwNoPVZG5+N1lmB2PCEcTWBeS?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MjJDkUUFuB2eH22anotJjZOgqnDPJBqHlQsjkg0XdKwXx8VVlN2DcaOLkISPZXsQHdvr5vFrLVMzsIl/7+khJkHpJUhJ3tl8/uYK4T4ZvKdqNw/fizyz3/woGltTEEqEcwppg0gfBWVCtl8+HSO8Lkwhn6p+dBRN7HAXBdsWRViCJ3TK7oP4eIcnRjbC5DbS59BArtesz+uBfu+g1ab7v8Nigr/oCtFXyM41n2FLQp92hmuVgf3dBZDpJc2BfjFEfqAQMq3NdnAULxS9Ey3UiiA4U4eJd9TkZg44M8Wzg9k+mspSwn5xS+TUr9LcrUzliv7VR+IGBjzjmXIS8nQ49hyXGAZSoR5433g0aIG0wcya9COfa/4xjQ1UzGF6UsM3SxECCOSIrKsg+xjOQvj6fbpwQDR+9VHsspOV+/bQYM54aZvJ3rnzTacvMxy+zIYHjetVQf+5RkVgMCK3S16Ws6JIW8jZ3VzvVsVVdvevEWlBZOxWoht2sey+g0S1t01YQWLXlHtAnsD8DzbthiNsaPaEiTvxSpffDhX5iKrh44J9WIP4+tea1tgtT4lzSmm1o5hWt7aJ7InJ+CeAX7CKPA6qJdVK6BVZ+qYaSMZ1kh0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5648db7-d701-4360-9c04-08dd08a4a551
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 14:15:39.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DR5k9i+ZBDd9njEz/nA9nbiyXs5yjALL5sPRm9t+/xQjK3xQBmjIdKOS/nB28Qtx3LvRxZEdGE/TZQoWHF8ppw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_06,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190104
X-Proofpoint-GUID: aRYO-mOOq481vb5Csl3GNqRxBtYxikUg
X-Proofpoint-ORIG-GUID: aRYO-mOOq481vb5Csl3GNqRxBtYxikUg

* Wei Yang <richard.weiyang@gmail.com> [241118 21:31]:
> On Mon, Nov 18, 2024 at 11:36:18AM -0500, Sidhartha Kumar wrote:
> >On 11/15/24 8:41 PM, Wei Yang wrote:
> >> On Fri, Nov 15, 2024 at 03:34:55PM -0500, Sidhartha Kumar wrote:
> >> > On 11/15/24 2:52 AM, Wei Yang wrote:
...

> >> 
> >> Hmm... I come up with a case in which vacant_height may not high enough.
> >> 
> >> Here is the subtree where spanning write locates. The first level is the
> >> parent node of the second level nodes.
> >> 
> >>                  vacant node
> >>                  +--------+-+-+-------+
> >>                  |        |l|r|       |
> >>                  +--------+-+-+-------+
> >> 
> >>                  l                 r
> >>      +------+    +----+-------+    +---------+--+    +------+
> >>      |      |    |    |       |    |         |  |    |      |
> >>      +------+    +----+-------+    +---------+--+    +------+
> >>                       ^                      ^
> >> 		     |                      |
> >> 		   index                   last
> >> 
> >> When mas_wr_walk_descend() to node l, mas_is_span_wr() return true since last
> >> is in the right sibling, node r. Let's say the parent is vacant and l/r is
> >> leaf. So the request number is (1 * 3) + 1.
> >> 
> >> Let's assume:
> >> 
> >>    * vacant node is just sufficient
> >>    * l's left part + r's right part is sufficient but not overflow
> >> 
> >> Then the "new vacant node" would be deficient and needs another round
> >> rebalance.
> >> 
> >> For this case, I am afraid it doesn't allocate enough nodes. Or I
> >> misunderstand this?
> >
> >I think you are correct and we need to use the sufficient height which is
> >introduced in patch 5 in the spanning store case similar to how patch 5 uses
> >it for the rebalance store case.
> >
> >	case wr_rebalance:
> >		if (wr_mas->sufficient_height < wr_mas->vacant_height) {
> >			ret = (height - wr_mas->sufficient_height)*2 +1;
> >			break;
> >		}
> >		ret = delta * 2 + 1;
> >		break;
> >
> 
> I have thought about this.
> 
> But the spanning write case seems to be a little special to
> splitting/rebalance.
> 
> It could be both require one more extra slot and may need to be rebalanced.
> We are not sure the exact behavior on converge node. Only check one aspect
> seems not enough.
> 
> Do you think so ?

I'm pretty sure the calculation will need to be different than the
rebalance case.  He was just saying that it's going to need to be like
rebalance, but not the same code.

Let's see what Sid comes up with.

