Return-Path: <linux-kernel+bounces-534224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD13A46459
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEFC173429
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BD2223321;
	Wed, 26 Feb 2025 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mnjwax5l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VTvf3GNs"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFCE221D90
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582983; cv=fail; b=h6bjvy1nqthYUZX/igpTqhPdS95w+uhiczGOSizCvV7BQSDhHLS51oJmDrcy8cPo8ERkNjWnBMWsCtIWJ8XlPTQPj+JFAa7pnewUarOKn/3O52kjSNhxYiqfLdniSh1OUYpZO1plebrNZFGc4beOoyHFCARiOscqp/5nfZ5jQhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582983; c=relaxed/simple;
	bh=moKSAsON1WdUPfSyI0TBcNfpdpEZ+ZbksD/7RBkUPEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dfpadGHuW4L5tQ56Ka2dD7fXoQvhbBeFcKU6MJ833x/kDI4mb0FYLi52rlEtxSW2aZRcSnR0yxlkE5mfFbEHlSbY+3bPLiwJjX5nl0YBpmyDi3wInwLhufzfge3Ud417UurD5P/JA+p2YfYll3lajS+VW35jYAOT4TSVgZeROLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mnjwax5l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VTvf3GNs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtZ4H009816;
	Wed, 26 Feb 2025 15:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=1WTXnmQdPESAgs85Ew
	WMMW00OdiWu6c64i4aeRBkQhc=; b=Mnjwax5leKxbwsnWFV/Her14VzMljjLsma
	FfGEEH61pRNOzrXhRBgNEWMfeT2QSlGCVHRwRsNntSdCN0KgzOmKX9eT5BnvMVjf
	oDpZsFeqJH1f41KxvUIFkflPhF6pgBoZh4IhztUjlEqG8fgoQBhCo0Qsq26yXOKV
	J81hNkI3oBIg8UqXILjpLz1kY2mpBwd0A2LsPXCuvfFnPZpOddbm1h/847v/uNBg
	ts0rQGFqNOZXV00GcX/k2QQZjan9rCO1fXiCnBgF+iHUx0mdkGFKx2CyhQ0SNrzI
	MI2g/GKj9GGB9ylw9ZZYmRnnJ44iwKIlg6Ni/ZA+KMG+BBUpCLow==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psdhd46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 15:15:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QDQnVO002760;
	Wed, 26 Feb 2025 15:15:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51b1f3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 15:15:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qG33OZHvB/lcvpYV5TzzqeUA3xxBejYZ7z8JGhoNi9WwRrbkM8YLzjoOekD0Dlnlo0AziURQIAj5M8NfqUbkYNdWt54byPLVWZq/mZdnoT/YJs2KHorjo7XbzNOfTtB9Qh2Ga/OtoewTVtpaFgMcBQinH6GuCZniHHM2yd51o4t3ltrjhPxJByB+s3W3cUmvvcJYT2zpfbokcZ3ZBoCYMKtdGo+ff+qLhdzsjcMSSjsTMjwmsq+BGmYrYxjbAs49QfT9TIC8k8SL4FFcwi555QoeT42xywa5qp/slGWeC8XhII950GLxu+x7fxZp8xdbt1dRsvKDWVI+15Y+X6rBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WTXnmQdPESAgs85EwWMMW00OdiWu6c64i4aeRBkQhc=;
 b=v8pBa5Mdh6+W7t+bY12otWWFTGgPGZEVIyYWX/pcUHokE/nLF7VypVeW9q8D8CjKPKqW+7aMfPBxPHfvbjg+kY/ojqiT9oqytQ5lgCxkKu+yrID2cXBApf/CPlb7ThlHdhlIFPzIvOfIJR9IYFpPovu0GlI7RErItDHZ/x9LHB+1fg5W3Vlo0azdeWHuYFnr9sLCUlINr8yNyh7wjvdEfdCyShSIgAv3eXFvFP1T2t/snsnF/hNH3H7tnLFT47uUr6xrOBG9Rndx/UfiIQbx/WVkpFBw51GmAsCWpsFoNDkFEKJXgWYdcGE7elHAbigl6mx6EElWDbX9zk4GkU+amQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WTXnmQdPESAgs85EwWMMW00OdiWu6c64i4aeRBkQhc=;
 b=VTvf3GNsv9fNv2X1kRjCA6aASdZ3N+Xq7elttS8ZmzFJ1KYCbK8o+Wp8Rl3KDXhW6AX1GtHIvNvcWeffX0INGETMYYkv1pAhyCrYJc38Ci2lu5jhIddYwpmzspUU+GicYmzsTqYPf4HUi9azmk+iMcqhitTzbsiF9+XSWiMJq0k=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 26 Feb
 2025 15:15:52 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 15:15:52 +0000
Date: Wed, 26 Feb 2025 10:15:49 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v2 5/6] maple_tree: add sufficient height
Message-ID: <oedzggpjfsveuhq5hjydtuk7kelhm3mdj5a4wkf7j6g3wgqtzt@sq4iyzuahuzm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
 <20250221163610.578409-6-sidhartha.kumar@oracle.com>
 <kgmriha5tcene5w5hny7vkvx46yw5i22avtqntapmsgclr72cx@bvzncliaywba>
 <65eb0ff3-07e6-422b-9c31-c5509fc0b2e7@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65eb0ff3-07e6-422b-9c31-c5509fc0b2e7@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BLAPR10MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae3a294-a40e-4df1-e854-08dd56787534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Se7tiGa//da2xqFA9d7N4rs7dGLuDsMA7+1tpwi9wa0jnmzE0iNSnDVfC8ZO?=
 =?us-ascii?Q?o+nS54DFaUwC/iuhCMSKjkhNxqDx3ad8K4WxXy57NKfLvgszNfK+KM/v/aqR?=
 =?us-ascii?Q?szo3hlSvUzKzoHEb2WwNQvFz/iqGwoq1xC3DPnwz/0YCPdQGy0dnapjyQg2v?=
 =?us-ascii?Q?876+vNtOLoyY9sBNpAGOIq87FC9XZgGaHG5Sk+e6fcODqMrJCXgqKKuMLhQy?=
 =?us-ascii?Q?RfzYMs2Ds5x++V2sDtBpokDpZ00yHB4z3n7SrBrjtkC17tNsNM7b+wMGa4ba?=
 =?us-ascii?Q?svjTwVY2udMEL3ATo9z1zRBaNDrJ1UVLfop/e7qJlPw0HYzR6jc9QdnST3qb?=
 =?us-ascii?Q?qgsHvc/V40N1D4jbmcrWrdqQ3xDohFr7I4UHA1pMmCnRXKISM8CvVRUeeI1Z?=
 =?us-ascii?Q?oK6gmKKI388XEdudXv1tCUamtfqa3Fyl2ep8ZkzIegvZaLkv55MjofhVUZ2I?=
 =?us-ascii?Q?vE1OiYbMeIXgj1yzBVRcGNtQNAg7dCar/Irimm+dY33X1B/rTBHXJnuPWWZI?=
 =?us-ascii?Q?2PvD8u1nK5K5LmNOfBGdB0mdJTYgf7eeA+P7jAgfpZSJ0h6NYGELUFS71Z1r?=
 =?us-ascii?Q?WMUE4FgiClauHMjDhm97wAjImdUVb/z7JBr5IqGcf02h4ZEXZ7eEN2wIPwuS?=
 =?us-ascii?Q?dAcqUBuU1s9MYYotnJTeHFfWx5WED9tvcQkIS5DsSeEQkVC7SctNIMCeftRK?=
 =?us-ascii?Q?c6qlO9MBPmA1VR76gNvj0D8AhBS49FL1+mOtm+iJtKbrJjMaV12dC5Z87SIp?=
 =?us-ascii?Q?vnrnFhsiuh77XcXjUi7K0RPZy8+xFUGUJV7urodaWk2PfFsgB4KwmLeGHxtY?=
 =?us-ascii?Q?ib2duGnrQSYw4nqiz1G2wTeyvV0835qHphnvZVUV9OabSKMbwyldMK47gVSs?=
 =?us-ascii?Q?rGVz+A5tCOmciEfR5nRETxcbRO4jpA9jb465i0upAX5dJjHiJ13uWaVgTFsk?=
 =?us-ascii?Q?pl+v6RVWvTsB4YiXMSUlzQ6jB49o1T0vsDSEs/jEPp0DyNUVBYh8WMKFRmRR?=
 =?us-ascii?Q?ppxiNICDVDyQ9GvMH7SXbfE0IMIDDV5QawlOXnPp4EYYWb+DNf5pHNVrJI7l?=
 =?us-ascii?Q?USEkXFXTUiaafCTZ8RMNBxLE1oTZEDYgfDJ8bichrmO8liuNUNWZ2R7Nf0Wd?=
 =?us-ascii?Q?Jey3rt09TzhI5MvnA9qZd0BoDihsVZcmZdM1nQE73k+hUVfbsChrtYthW+CY?=
 =?us-ascii?Q?RBvhaxpzmI9faXWw2BNdFOVoWe9n89JTZMcQ6xRcGqEfz2SzgOegoSl5yi5C?=
 =?us-ascii?Q?/OG+9PlLRr+KrF6OFdQKUAOAQp0Io39ANs3t+XRdpIj4S6aZ7t87RIZud34t?=
 =?us-ascii?Q?K949/CCs3ZqMurCsAiWaLyMRTQS1S5LeuWguPji+VAU2OkorVm54K3Q3BpON?=
 =?us-ascii?Q?BbxiDWPKBFaQm9lraLj4zjKslXgs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v2ruxflz6nYFp0GLPVOy2De/HoR2eqckmYX0GahcpUvBxCsUEpm+TKr/GUfa?=
 =?us-ascii?Q?7B26o0NwmoF1IvylhPsviT8slnAOIhM1hwbOXyMacc3j0Y56qKacG+icyN+f?=
 =?us-ascii?Q?fQemjpOi43fSgpz4cD1/zKnjjC/PhV6BGGo7KepNpgukL7qntdIGL1Qbjml+?=
 =?us-ascii?Q?O2wW7+K528rpKVurMU5KAg7qJt90VnGkAXCIWXE2m+ZA93KCIe8q8MYGJXdr?=
 =?us-ascii?Q?vqBu6HZXb8KVKEavClpwOj39QjcGqUyX0l6QD0LsLy8JfECwBQCXyQdyOOLl?=
 =?us-ascii?Q?NSSPJl10UJgA+q47o/N49FoqYwLXrOdWth6/5e2dMhftehzaY9oAqJCQWmw3?=
 =?us-ascii?Q?4wQCgRkWJZ+XyhHJCd1qjgrPgMt7PrQaUxRDPu+xURKja1NmeF2i2GmcipDx?=
 =?us-ascii?Q?3ZqzdY4nJyeLRK0PzAMN+xy1rFILSh1IoP1uDOjffMd+jzImZ71z5sjL2Iar?=
 =?us-ascii?Q?lAKDs41Ag/QAjEFYNufhsGBpHXBCAijmGL0EkFOneL51Jl6i2ntUZcDrhwGW?=
 =?us-ascii?Q?dNavR0nfJVRBQTSMQ6mgeSSaQCZFiCveIxCOyvLxjUgDV+KumodNMVXVT9t/?=
 =?us-ascii?Q?vf53ztERKT7CT7k5jqqnn0ZsnUOAQHvRhdOLhmlawglJK1+moRMZ2CT9vqwY?=
 =?us-ascii?Q?sKe6SneFN/tqi+JrSBn+a+GIqgXhuIFQlDKxhRupWYgtE2khPRVqS7aUo7yD?=
 =?us-ascii?Q?9xuhlzPnDeA68XIJvXefHb+dJAp/hll6wMachZnfpVEFw+Yh1RCcbUrGKxVh?=
 =?us-ascii?Q?35opCfyLIEE+5HTeg9PPXcZFxDwipwRLTZ0n4sKnN5MH8a16MEoa5J4id+lq?=
 =?us-ascii?Q?/ssQujxc3dMHHvuImgTLsBOIQICkaHNuMh1fIE241wHrXBWlFi+4qnuh2v3q?=
 =?us-ascii?Q?/1OBDm3fA7bRoIsVsp64+PPc3FKgr6Qa+Ru7Hq7NOjvryHb5rgt0xzQldz7r?=
 =?us-ascii?Q?LcsYjrZeJeuI9VfMtsZaIPKpUkcYCO9E4kYcdxqbr+SFwRBlMsYUdE4xf7dC?=
 =?us-ascii?Q?Vp/hAvzJ88n2a8jI3Q4PHZJy5FJWY2J346cDTn6MClhIeBwNokgCTNurG34P?=
 =?us-ascii?Q?AApAC7d+W85r0hONITt6Jjh6G2ABj3qdrSPnMyty/C2jTssCOc7skS0enOLF?=
 =?us-ascii?Q?5N9FuqAvUwP+/UFLChyzTzAZegGhhmy8ru75KKD4OSY5rXaBp0thAMS7G2gY?=
 =?us-ascii?Q?SSr5g7tUjMvNLE6XUyV29bFLFir8KlPBufFu3qkIr3TRqelPCwpr4vlBzJTM?=
 =?us-ascii?Q?aJe33XGDT7wmMusmf3JZ8lf9XCZ2JOXv9kwAFNyToiwddw/E0XKtmMVayxRt?=
 =?us-ascii?Q?dnZlLL/O/Pj5gtljnFVqk+Sg5VUcPhNJBjYV4R7WNy8cPthQG8sWdSfD0boN?=
 =?us-ascii?Q?83ZQiLmtdrULPbJLw14tYLs9Js3qTetAqgGewJA7eoHwieyXgsobzF4VO0v9?=
 =?us-ascii?Q?diw6HT1z7B5MuwMX42R8k7r1CQxy/rK5fnUx2J0HwH4pCUD3lyUWUVal9Fd7?=
 =?us-ascii?Q?EP6oBC1H83F0F/F7lDaHDwVoGN/QBn68KlhGyA9i08LQ71156Lh0G5hYs6js?=
 =?us-ascii?Q?f72eADQ/AcfBX3K/OmZI9p7SqqA2Llg4h7plhkCk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WVMhnhvPKXQIM0NXodbwFip/gZ+OUMj/zEGN6WB3Z08UiCmiDgZucS2VUKH0tda6jKScHfkdrqFJfj9ua/EE7mAyUwkjkrDYipDLHRBuxQuQcd6iwEiw6GGuEKizPuLuvrTulZmY8go+3/J3CiFzrds4ZF0SDvCoSqMcBmfDzkNRg8UqL2QyYXg/5YVoKQKEoUDhewr+jQboY1EBKdT6XOygSrsR5BdCLmk2jnNNZ+LkM8Prrpv0dha48D2fi4KFC9QeQoeGERid0dqh+S5q5xQGyG4w7vg7UZ0gEyvEHR/ZiDBZUuSyPuON+AeXV/woQku2WVyJWMCaFu5Oj2msWG8DCdeSElLITHnuwh0axa6xLi/9Kr6u1DS9z+NYMswFlCQmrCIso4joDHLwsYL7inHL4ZmCHBFBaiQAbV2OiUmBCF6xksWcZS6tY813nwnyOdcId9NVllfqxYp56KkX7sGhhErNzWsvsnoED6Lx3F9rUj6RDdpCtu+WljfuKLt/kZ3e4Cifkenmpi6fSEhdycVSxjR+SSQTY04j+CrtQvDGSxx9JqOy2+bY6oIIHgxr5OaeTcshpr0YKAX2QxDgbrXKW38YAD4W28SiYUINYmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae3a294-a40e-4df1-e854-08dd56787534
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:15:52.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dVTf7EN/VDjnnaMsTMekpbZLyIZBNW9TRXwb+fnf4hoAaYw0FhupaOR3wVPHZvw611i93fH9mCdkQj9zTFBsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502260121
X-Proofpoint-GUID: imglhSb2_sNpTjDIsUeQIOUiBk41jOQc
X-Proofpoint-ORIG-GUID: imglhSb2_sNpTjDIsUeQIOUiBk41jOQc

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250225 15:36]:
> On 2/25/25 11:02 AM, Liam R. Howlett wrote:
> > * Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
> > > If a parent node is vacant but holds mt_min_slots + 1 entries,
> > > rebalancing with a leaf node could cause this parent node to become
> > > insufficient. This will lead to another level of rebalancing in the tree
> > > and requires more node allocations. Therefore, we also have to track the
> > > level at which there is a node with > mt_min_slots entries. We can use
> > > this as the worst case for the spanning and rebalacning stores.
> > 
> > This may not explain the situation fully; We also have to track the last
> > level at which there is a node that will not become insufficient.  We
> > know that during rebalance, the number of entries in a non-leaf node may
> > decrease by one.  Tracking the last node that will remain sufficient and
> > stop the cascading operation can be used to reduce the number of nodes
> > preallocated for the operation.
> > 
> > Note that this can happen at any level of an operation and not just a
> > node containing leaves.
> > 
> > The spanning store operation can also be treated the same because the
> > walk down the tree stops when it is detected.  That means the location
> > of the walk that detects the spanning store may be reduced to be
> > insufficient and will be rebalanced or may be split and need to absorb
> > up to two entries.
> > 
> > I think this commit needs some more text explaining these changes.
> > 
> 
> Does this commit message work better?
> 
> 
> Using vacant height to reduce the worst case maple node allocation count can
> lead to a shortcoming of nodes in the following scenarios.

This sounds like you are fixing an issue you introduced, but really you
are making the calculation lower for cases that were not covered before.

> 
> For rebalancing writes, when a leaf node becomes insufficient, we push the
> now insufficient number of entries into a sibling node.

when a leaf node becomes insufficient, it may be combined with a sibling
into a single node.

>This means that the
> parent node which has entries for this children will lose one entry. If this
> parent node was only sufficient because it had the minimum number of entries
> to be sufficient,

"if this parent node was just meeting the minimum entries,"

>losing one entry will now cause this parent node to be
> insufficient. This leads to a cascading operation of rebalancing at
> different levels and can lead to more node allocations that simply using
                                                         ^^^^- than
> vacant height can return.
> 
> For spanning writes, a similar situation occurs. At the location at which a
> spanning write is detected, the number of ancestor nodes may similarly need
> to rebalanced into a smaller number of nodes and the same cascading
> situation could occur.
> 
> To use less than the full height of the tree for the number of allocations,
> we also need to track the height at which a non-leaf node cannot become
> insufficient. This means even if a rebalance occurs to a child of this node,
> it currently has enough entries that losing one entry will not cause this
> node to be insufficient.

"currently has enough entries that it can lose one without any further
action."

> This field is stored in the maple write state as
> sufficient height. In mas_prealloc_calc() when figuring out how many nodes
> to allocate, we check if the the vacant node is lower in the tree than a
> sufficient node (has a larger value). If it is, we cannot use the vacant
> height and must use the different in the height and sufficient height as the
> basis for the number of nodes needed.

Sounds good.

> 
> 
> 
> 
> > 
> > > 
> > > Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > > ---
> > >   include/linux/maple_tree.h       |  4 +++-
> > >   lib/maple_tree.c                 | 17 +++++++++++++++--
> > >   tools/testing/radix-tree/maple.c | 28 ++++++++++++++++++++++++++++
> > >   3 files changed, 46 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > > index 7d777aa2d9ed..37dc9525dff6 100644
> > > --- a/include/linux/maple_tree.h
> > > +++ b/include/linux/maple_tree.h
> > > @@ -464,6 +464,7 @@ struct ma_wr_state {
> > >   	void *entry;			/* The entry to write */
> > >   	void *content;			/* The existing entry that is being overwritten */
> > >   	unsigned char vacant_height;	/* Depth of lowest node with free space */
> > > +	unsigned char sufficient_height;/* Depth of lowest node with min sufficiency + 1 nodes */
> > >   };
> > >   #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
> > > @@ -499,7 +500,8 @@ struct ma_wr_state {
> > >   		.mas = ma_state,					\
> > >   		.content = NULL,					\
> > >   		.entry = wr_entry,					\
> > > -		.vacant_height = 0					\
> > > +		.vacant_height = 0,					\
> > > +		.sufficient_height = 0					\
> > >   	}
> > >   #define MA_TOPIARY(name, tree)						\
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index 4de257003251..8fdd3f477198 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -3558,6 +3558,13 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
> > >   		if (mas->end < mt_slots[wr_mas->type] - 1)
> > >   			wr_mas->vacant_height = mas->depth + 1;
> > > +		if (ma_is_root(mas_mn(mas))) {
> > > +			/* root needs more than 2 entries to be sufficient + 1 */
> > > +			if (mas->end > 2)
> > > +				wr_mas->sufficient_height = 1;
> > > +		} else if (mas->end > mt_min_slots[wr_mas->type] + 1)
> > > +			wr_mas->sufficient_height = mas->depth + 1;
> > > +
> > >   		mas_wr_walk_traverse(wr_mas);
> > >   	}
> > > @@ -4193,13 +4200,19 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
> > >   			ret = 0;
> > >   		break;
> > >   	case wr_spanning_store:
> > > -		ret = height * 3 + 1;
> > > +		if (wr_mas->sufficient_height < wr_mas->vacant_height)
> > > +			ret = (height - wr_mas->sufficient_height) * 3 + 1;
> > > +		else
> > > +			ret = delta * 3 + 1;
> > 
> > Ah, ret was short lived.  Okay.
> > 
> > I still think this stuff needs some more context in the commit message.
> > 
> > >   		break;
> > >   	case wr_split_store:
> > >   		ret = delta * 2 + 1;
> > >   		break;
> > >   	case wr_rebalance:
> > > -		ret = height * 2 + 1;
> > > +		if (wr_mas->sufficient_height < wr_mas->vacant_height)
> > > +			ret = (height - wr_mas->sufficient_height) * 2 + 1;
> > > +		else
> > > +			ret = delta * 2 + 1;
> > >   		break;
> > >   	case wr_node_store:
> > >   		ret = mt_in_rcu(mas->tree) ? 1 : 0;
> > > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> > > index d22c1008dffe..d40f70671cb8 100644
> > > --- a/tools/testing/radix-tree/maple.c
> > > +++ b/tools/testing/radix-tree/maple.c
> > > @@ -36334,6 +36334,30 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
> > >   extern void test_kmem_cache_bulk(void);
> > > +/*
> > > + * Test to check the path of a spanning rebalance which results in
> > > + * a collapse where the rebalancing of the child node leads to
> > > + * insufficieny in the parent node.
> > > + */
> > > +static void check_collapsing_rebalance(struct maple_tree *mt)
> > > +{
> > > +	int i = 0;
> > > +	MA_STATE(mas, mt, ULONG_MAX, ULONG_MAX);
> > > +
> > > +	/* create a height 4 tree */
> > > +	while (mt_height(mt) < 4) {
> > > +		mtree_store_range(mt, i, i + 10, xa_mk_value(i), GFP_KERNEL);
> > > +		i += 9;
> > > +	}
> > > +
> > > +	/* delete all entries one at a time, starting from the right */
> > > +	do {
> > > +		mas_erase(&mas);
> > > +	} while (mas_prev(&mas, 0) != NULL);
> > > +
> > > +	mtree_unlock(mt);
> > > +}
> > > +
> > >   /* callback function used for check_nomem_writer_race() */
> > >   static void writer2(void *maple_tree)
> > >   {
> > > @@ -36500,6 +36524,10 @@ void farmer_tests(void)
> > >   	check_spanning_write(&tree);
> > >   	mtree_destroy(&tree);
> > > +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> > > +	check_collapsing_rebalance(&tree);
> > > +	mtree_destroy(&tree);
> > > +
> > >   	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> > >   	check_null_expand(&tree);
> > >   	mtree_destroy(&tree);
> > > -- 
> > > 2.43.0
> > > 
> 

