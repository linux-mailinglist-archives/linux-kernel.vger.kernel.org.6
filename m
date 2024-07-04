Return-Path: <linux-kernel+bounces-241684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B49E927DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290A4284258
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1625213848A;
	Thu,  4 Jul 2024 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YNaccPlN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HWhd+YOh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF0A13212F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122203; cv=fail; b=M276NDd40Mlfdpu4d8O5hgBBSxmmMwqfmzBv3g89xzHiQuan9AHXOYbinJW9lKQFkyCp2GCSjZNc0oYjmUzun43jyStjIr3WSEEoW1UIgNeb6vjay53r445amhjq3o0O0eBMsbE7slh2aNiMYoQggT/rIJaa7F7gGSRQP9igg/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122203; c=relaxed/simple;
	bh=V4UvehlRwyVNFgxa/229XxVg9A19bIPLeQ/Fygw8sas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwyfki81axjnZrlM395uDpeTckOvyo6Am29bHgU/OqW8wadKDKzdqWELqGg3bBCBGC7Kw7FFB+DlBLlh5qryZCXaTqtQFhVLNQe/bOCLSEdI8dwdjeamujNcbWXyzvp496+z+HAXZleCePxB8QgA6g/EYwgFedlF191z7V8NIvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YNaccPlN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HWhd+YOh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DQn4S013142;
	Thu, 4 Jul 2024 18:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=piltnTByFrtmgy9GlOmuLW0JbDdTYktoJ0ISndNfSNw=; b=
	YNaccPlN+Op4KzApCwLRBhYZGA2a6Tqv6gtRxf9EC0WD1DEwNtsWdxEULnkmbaw9
	8pldx5mHHCPnPiOvxTgfJKlm+AygIOm20P5xVVOLPAHs64LTDCWT57z/jNWv5P0B
	riQVrq0xgb9868vWfk1cP56YXLy3n7hzy23mLXJ47exLkHdfwLZwv6qLNZr5+vhw
	ClDGRb75uGZ3knvPUKd2TKVa3tbLe4yOS6/WSNkF720Gne4rIHmuktd/ajVG2ZuJ
	mM1oJgma/+44myjYRE9OiYlicBHNpbMR3aP811nGQ//iJgbPTj8U875+jMEdd/fi
	k+y4+Jw/hNacIo5DMK8ZsQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgm8av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464G46hw035991;
	Thu, 4 Jul 2024 18:27:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qacukd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1PT2LOVQPTe6JnzPWK8O0Y3naHRN6p5yAS+KpkdqFLUx70rMv7/hQF31O9czsBpTXjb9RuyOqtjAlZOQoTRmSYf7kYvMWNbntR9zwosCLl2+7zKODuhZOAlAhXksuCxbE7Tfeowgugb2yqShDPCCih5/eoRJE4ZePDDAzzzbLu74UMQ+t11QixpGETyM75i6eLqYxq88as9i0PZAaG+aOzseXUGo5U2Th3Sf+AhtB69ZlFiQVx5x6FpIJ6jmNAHaqqzfO61w5/XvjyW0XJni7fEjYNlyCroKgVS4zD2HGVfF9bSA/6aI0YPxfgBfDlydTmXeMuoq7VXYHu0+6iE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piltnTByFrtmgy9GlOmuLW0JbDdTYktoJ0ISndNfSNw=;
 b=kKw5awA/LnTKKOYa9lxOX0JO1t2EDn7cE5RAQXi0BtBB6msB9AUnsY7cr6MbKHTrHGabEazbcxAS/tKIN1/Z9F15qKRdHMWOBQblHHohpt6AQa1p6TFcyBCH1kbFFBSX7KjKqYvL/cuwW9oUQrnvDnSZgeLPgPFyxVHUbpC5qnsf+hzexhTN2vHPICRMw2jIQtxjTkdRdXBv+8JcbLmSSufNhWzAnnWMDYMa5zKyPeoDiNjNtS0KY5bBfDc8JzkxuY8T+7IOKSg7wj6YJgM55XN0I0otuxtpjno9ygob8Hh09rVRkIkPlb5GUpaSgolUNYdDrPtDhycJpCRXLWR26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piltnTByFrtmgy9GlOmuLW0JbDdTYktoJ0ISndNfSNw=;
 b=HWhd+YOhP5HbKhmhxgGK2WR/vqv/u+XAMzACe5HjOcyZctLHDpvl4fyrvDXXo6HaOUSeDH5lNPVatj0ov3o2oUbSIDdAI7aWmS+Tslm+0a2Eg4rFvhb8ag/RgKrmOLRyclQpncKsYLAlEx4EKMZclIUJhiPMrtqHeSeLMyhVQc8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:39 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:37 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 07/16] mm/mmap: Extract validate_mm() from vma_complete()
Date: Thu,  4 Jul 2024 14:27:09 -0400
Message-ID: <20240704182718.2653918-8-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e437039-e045-4221-a094-08dc9c56fb12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?r5wwN2vl9snbJEdW3ZyQiOaFRxYL5aDAblklsBkFV8m6i+c+iMnj50gy4MIB?=
 =?us-ascii?Q?HLzS/xHuryJL4JuE0CgF1sHiSw0Ki9o8mrZYe5Kg247wksXrT/BZZplqRLQz?=
 =?us-ascii?Q?Mky3uhNGgCSnFBSCZgoU9FrXkQWvErtffu2qmeXQoPTfeHlGL6J5lIdyPgt1?=
 =?us-ascii?Q?zax9TC+FM2QLaDOpCRDN85fo+woNBZGqyeBj+5Cc53RY8rt2LZzQfuWNfLVq?=
 =?us-ascii?Q?y9F9lsC2w50k0o8/fE2+Q9RMimIYcNhXW78aMmU1CUJSwTCSrHw+KBXTSfGA?=
 =?us-ascii?Q?DtO9Jid0fWxFPujufT+EBkX2M0zlhGrMTLpQ/sf8Z+9O2g/jbIepdV0TlfIR?=
 =?us-ascii?Q?1YLJub2WmKtz1yzwngbpfzuxTKtjo1e/DK2K8fcqrsFtivwPpVNDtuozWKBn?=
 =?us-ascii?Q?XDUobSrGMafT22/kMCd7zRLxkFVe/Oiqkeuu6VKrcbGyh59NkSMMWH0Cu3NZ?=
 =?us-ascii?Q?D/YlJnOQmqsCizKo8lzR3O0n2Cwp4FiMAzk2b5iQGIkIcTK8DjFpx6LUPI/1?=
 =?us-ascii?Q?JJlBsfscxm5KbgxQYu+TJk9+imshBfeAEyPjBTZNXEkWojYcQYKqWGMr6PH3?=
 =?us-ascii?Q?ZVsTBqu0u2Dmf8PEhUmTHwWyZ7csH5Kuly4M3F3XXQroxp+BQbCyKgvYnwAZ?=
 =?us-ascii?Q?XUJCuK+3pCsllPxy8SKvT8mH/EhRufbH/uuQMM1RvdE5CSd6qFnRNGAeVBKj?=
 =?us-ascii?Q?2IYhwLz4VjdbRLCaZp2zhvTjMh+9YFQckHou8Dyo0FkRzOCuXxgasoiNZ2Qz?=
 =?us-ascii?Q?OxwDDhYeWh/Vvo80ZksbmybshZ3jN+FDiyOQSMMoy7KmQjA8JCjBfr6Gso61?=
 =?us-ascii?Q?WdkVt2dIMdI7u3Qm9i4gpdLI+4dv+VyWVq7GZuMz8Xtt6MQwvaOU8JdpOLcz?=
 =?us-ascii?Q?BjNd5CsJ0UPQX7vuk3O7tuA0uxa1+354vVYwyGGviQRbbj3iH+roCgzM5dzL?=
 =?us-ascii?Q?Kcv/m3ospj5zND9QHKWDB1sKqg26wgmhbkuPmMOB5PEG43/w79ZIKZSmqr+e?=
 =?us-ascii?Q?86t/Kl2YHxS1eyw0IUN4btTNw7g+WURBP7p+Cy7lqZdq2xsMde62JkmHMF+K?=
 =?us-ascii?Q?11/I0btVnMX1PrQLNDWATmX0eOBfKHc5gTUXk6RfviOKcQb0hDZoXNle1NvW?=
 =?us-ascii?Q?lFIFqNX9vb5oavS4EFY9psX8Ihielb+iqPQSUm6lEs5siCoZ/wiwYjJHHC5G?=
 =?us-ascii?Q?5anMXb0uRlQeUwEkO2sset5tfptLdtVDNsTJtxhyKp45ZEZB7hFyBBAuHp6r?=
 =?us-ascii?Q?fOJ0DRIX1spYbut4ZqkbXqR/ZmFT37pgYQqpmQVYInIplrtenDOZWxNJhhtm?=
 =?us-ascii?Q?SP8OsI/48T0muSNDpGkNOcOjvpljBo9kP/1ainUaR4y3NA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1t3KZRU7R/s3LvLSH6iyCyXWYkMZu9b+1zhsfWZPH+gBt0VztAPb+eSkQVEs?=
 =?us-ascii?Q?EnszsvQ9bYVxIpScdA37ZyJmk4ZICouGwojKs/0J33yXRw94T/EKqZULCcYz?=
 =?us-ascii?Q?mCVrwn0GTq7FnLoQtWsEwS2l+e9dy0r/uxRorWdBCfoZL8EZW1c04B8YNMea?=
 =?us-ascii?Q?sK4UkUK73J5BvTe1XlmB3D1RPQFG5vMDGpr2zCIIIJG02V8A1bf/diqCdlbR?=
 =?us-ascii?Q?5L8d5OvDev4FL/WY0uJ8AEbqDa3cFJYFIGn5RCmWOvBMvveF+y8j5qqJdGOb?=
 =?us-ascii?Q?6sAVxNkMnFG6ai4XlBh13IaNdVMx9Up/jMmi53rsorW1W2Ccy8248S50VYck?=
 =?us-ascii?Q?BmeuAHeJo5jkthC7eSo5Fb9hW7swtqQFtqfEcZqRMxkJYkstSSXFaZB3814i?=
 =?us-ascii?Q?gRJR3Hu1aVx14zg54PvspFgZ16Ju4TOOhC+uGZF94cr0S0Axuqb7bdvybpsM?=
 =?us-ascii?Q?NyNiG2ugxXz609xo8/PWhMgd4jzrBuaP2XyFff4iF9FPa+ZEyOch2H7Wv//j?=
 =?us-ascii?Q?ZjPK+sejtirWq6AIMMIl6vVl8mxAPkvnzSpBOPqjOVrn7px2pgru7aihPmbZ?=
 =?us-ascii?Q?Rc5iPewdxewmR4tVIvVe4P0rViwPUcCfe7Gc1G4STzjq8F2qcnMuR7F/s13+?=
 =?us-ascii?Q?+4bnR8nlrx5ugTnjEmgZbdmnfkzQoB++A7Ddt7xJL4o9+gK+ej5WrmOq92DN?=
 =?us-ascii?Q?NIYEBHLPRNVMHVCG821o+P+YW0UFc8My056ZMtZ3A32E1miLfw4MjjEGudAC?=
 =?us-ascii?Q?vuQTACn46F5VhZT3fWnB1113yjeOdR/rUu+7a24Ook1E9WLV+bUG1mVT6p0I?=
 =?us-ascii?Q?wSjysV1rjkvYaxPOuxz3ZVr/a/uwS3796PeGsKIQ50ARS9/OBlR4grahaLHH?=
 =?us-ascii?Q?7vMz4sJYVSg4TxDcT9ZNySxBJqs1plWj2yaXZEyHMcwwnk3asDNgO0ekt5Fx?=
 =?us-ascii?Q?KqgZAYD6bM8zw05YWLVN4URs4UkthBC9qSZcQLNcQAyOwaHXNPw6dPryjZbj?=
 =?us-ascii?Q?6UXfgbFFdIpLjf+wSod85Wz5zxlq6GdhORdV9e/c87O1oqaYVzjc9G2l1yIl?=
 =?us-ascii?Q?PSfRa/1gxKNnnig/oepbtJGK0robsyrdQgwikjpIZtkZx+uvvPQmemmEnhNp?=
 =?us-ascii?Q?9TfjnVlc5ejPQ3v+/sxj8sEbVC0OSdDOtU5TWp1fmlzu8RJf+WYlISpPJQO2?=
 =?us-ascii?Q?yKqL0HkIs2p23AGzGr92/yLXKtvo0A0i4rAHuN3tqNrPWa21HmWfi9lI7PQG?=
 =?us-ascii?Q?Nvb4MiVUQudrxQWt9aatcyh9EGnglkK6kiNmBRvvOzSRHYpfXUoAaDnRAb3Q?=
 =?us-ascii?Q?+jm8/JQBuqZGzt7nTZcIAnRp7DwrtXAkFYVOSxop/XugMc2oRcAS1xOCF5EY?=
 =?us-ascii?Q?suPy7s1pjA3Ow9jGisZBd4Kh+8juL6jMUAv0H0vS//bkn6uE2VMIa9ZUwYT4?=
 =?us-ascii?Q?Mt6uHTLnRQRom9xTFuBjcUqquZMa5aPj5gq3ZSRfEQ7j9elp43rgWsVRyp4o?=
 =?us-ascii?Q?C3sxDk2OsUnDMmzolVBKALLNv2jkeSXN2M8QIDOsajj5IjTPv3dNNkqXwDdf?=
 =?us-ascii?Q?VzQ09pI/ijAei12cgiMx/FymLyoLGH//acuCP8Ce?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9GtCMKcF+T6j7XS/5kfa3EH0I0xBjttnczG2sJoPFxMkeKl+XGcThaWU7p04QytVEBwfwHqLHvX53Qtj7+ofTnVKwqkE1VWkZhUz10rJPh5zWH+kFq2zI39/XdKQCKL57PdTdKSmwnrySWY+OdwRzJ1yXuFVUUhEJNEr7VhaoWpRWcsKmN4ZkIew2ff6MI9U97qDOROwN1KQhlt6P5lEdlktrvl2P2bkOUsDiijJ/Rr+xabfTZ+cQnoOpLyBzoWcnPLvntM/ffFd4b52YvjNHHMS+uool1Rz4yAQWI87xUnknzUOiNX9PsPgA8hKjeKT+wJpl6DSNLtX+SKA48uAechGMtlk3KyHPHkP8prO0JEVcdp4bq2aK5ZOydy4jdky3QMdQeCVJ4UHZNeh97Z3Fu5W1GlZXcJw7wuJ4P0C3RC34TSnqKyeYMN7w8G4lnh4SPZzJUFJuHqRdlkMMbzBdJ11JfXCOKHEPPnOLdyFuFr7QhOMY/jNsEqhKGizXx9z+iUzdyFbhOV1C4SMRPUSX5mi4lFRPUx4tdBex1Z9LFl7LzV6pUI9IvUQEadEKIrV+x4ZWyWH+hFDRFy8aOFweWsGXQ6CZMjgazDru+pVABw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e437039-e045-4221-a094-08dc9c56fb12
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:37.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlvP3qITeR6HjAzTFEJwNeNnDc4WUABgXsSbZ+67tTyWlpqnmzaTSsV42rEJUI7i76o5DF/UtDMGvoVGYBclfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040134
X-Proofpoint-GUID: OmqTb5j7iZz6skuVwHvQX8O8_6BNGWUy
X-Proofpoint-ORIG-GUID: OmqTb5j7iZz6skuVwHvQX8O8_6BNGWUy

vma_complete() will need to be called during an unsafe time to call
validate_mm().  Extract the call in all places now so that only one
location can be modified in the next change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2a1a49f98fa3..8d9be791997a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -646,7 +646,6 @@ static inline void vma_complete(struct vma_prepare *vp,
 	}
 	if (vp->insert && vp->file)
 		uprobe_mmap(vp->insert);
-	validate_mm(mm);
 }
 
 /*
@@ -734,6 +733,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -775,6 +775,7 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_clear(vmi);
 	vma_set_range(vma, start, end, pgoff);
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 	return 0;
 }
 
@@ -1103,6 +1104,7 @@ static struct vm_area_struct
 	}
 
 	vma_complete(&vp, vmi, mm);
+	validate_mm(mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
 
@@ -2481,6 +2483,7 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	/* vma_complete stores the new vma */
 	vma_complete(&vp, vmi, vma->vm_mm);
+	validate_mm(vma->vm_mm);
 
 	/* Success. */
 	if (new_below)
@@ -3353,6 +3356,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_iter_store(vmi, vma);
 
 		vma_complete(&vp, vmi, mm);
+		validate_mm(mm);
 		khugepaged_enter_vma(vma, flags);
 		goto out;
 	}
-- 
2.43.0


