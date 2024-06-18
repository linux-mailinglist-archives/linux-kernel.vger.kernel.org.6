Return-Path: <linux-kernel+bounces-220166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A6290DDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B286A282009
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C9D17838D;
	Tue, 18 Jun 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UVquG9C1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iLsM1fGi"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5024D8DC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743726; cv=fail; b=VMVlMphA7xEwAfxfVDgCy3aAxDMdvjs2LsO6QG7tJprqKCfA0ysM21AvJC16c7yr4H86K0CW94tzYIbgyu0Ej2naGabU2LhO91rBgu2Y+2jEHMLODAIwEXVbFBmiBa52gkDx0j5rtBWZzSJELoko9TpcRRXu3XJMcuc5KU8IXlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743726; c=relaxed/simple;
	bh=Pvzx52pE8AYyW/atbB050br5Jnxnxz0qjTaOJ4Yn5iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TAV82RjFXy5scBcy7CU1Epe5ZcYyEwAYwn5ZitF1vkKczvkrLXWOPz8lSnuo95+8X3vt9FhhJfhknWQ4wweEQVAEjP5prinJwV2Am6MNnELTxUqPU5K3Bd4sb+RIA8/oG6LJU10jxDeB8LUXU07SicEM72ybGjh4pTTYxuz0sxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UVquG9C1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iLsM1fGi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUvLA020993;
	Tue, 18 Jun 2024 20:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=32B6ngM4WOWVGCyckbuU6wS0iwX4RANJwBQYctQ4B90=; b=
	UVquG9C1fNHUZyrkcWzOWktbRcGJrwQFCYMqFzGe0aoPoBjbalhbkPAJyTCcnzeR
	O/OXUdYQe21BFjwLBnMSEiMeQ0JEZMT+WeuK6ZYXskz4NSOWGGsZfeHCTLcR1Ij1
	K8yrHmXm4SPsEUV0I1sMbIZ4DC9yUXPark2Ul+Yocexel8KodpzjU+jmO+KZ+34/
	5WcHkN17t+xvris/H+AMRj+gP/TE+ZcDPtFMagi8mq+GGbZJZ7yrM0xpQ99mxPaD
	hHkvtW5hlJcREwqelYV8f6t8seTAIclygHmi0eAeGuO3b3jv8HWOR9AqissetzBK
	6kQq8/LYp2rxMnkaNy59Zw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1vedxn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJlTIS034656;
	Tue, 18 Jun 2024 20:48:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dey4ud-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlpN9RDIDG2+UUJC0ImC6W6qWqr0KxcTRrShySg8ghbVyi9MD30WeJVCCtKO6Rpu6mfjcwaw/Kq4I9gQ1lWfE2FMKKh07MsXfKBjPf6EzHxYIQdmi09XNYOspiPdgS4rIyY5JBfDZGF1wKwyst5s7eB95ayH9Y0Z+oCMu61NU/DHfbBD+DoYGsJ9IqDFmyUjowVLXA4MBi/hiaVFzqsu2w+evq9/2yWXabaEPzFGVLxR3XOOUE8UHoThtrDGPTvuWpQ+n1tpP8AHNp8l6MjoW0bXW4+FobJyW9pSkrl72MnILxrBNqbBjPNWT5B1dPMX0zN0pq7fWUDzTrowr/A8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32B6ngM4WOWVGCyckbuU6wS0iwX4RANJwBQYctQ4B90=;
 b=FkWZaZ6w6U2EZo15s/48+TE+IKTzw+EQB5+QLBdtp9NVQpscS7wkpNrvW6XboYwMOTwssLr3KKRZHqZAlVZ17+vbb6npCwSViOO0144oJRiKo6tM15tDzIR0czQua5NMOjRMl6+3KJqF3YASLbk8R1Zk1aiOdy8tR8TVl31C2hwx+XmLMR9ZcBEsQcrN4DBj17/lHuiWAn0qS6vJeOO8VMvaVJNkvivUbwbbvb/IZ5Do9vy6f76BVq7QskaMwhSZ7Mtp5Jct/N9ZgQ+w3wUC7MzXdJ/wRtC3DE/7NmFmMO70WenKhQsINn0NmpW4f+U5A/gouTkdvWKovtm8ewRKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32B6ngM4WOWVGCyckbuU6wS0iwX4RANJwBQYctQ4B90=;
 b=iLsM1fGiyeJKgmbJp38WrBR8GzSwFMD1k0KtiLUpF3JE0ALYBESxOyCf/SK5pYL0KGk2UYRtSMMHgsFbJ6lcEDsVCxMFrSAENJwiQvA7xTm/vfUyJgye/YZR7CDhsHWO5JbY+SeoZJAYdbFkb6I/KeljcLThHp4I8O8YBO82lJ0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:23 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:23 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 11/16] maple_tree: simplify mas_commit_b_node()
Date: Tue, 18 Jun 2024 13:47:45 -0700
Message-ID: <20240618204750.79512-12-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d780ca2-e1a5-438f-3767-08dc8fd7fe5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?FodfimtBjA/shm972txfBr9YDCU1OxxEJPSib+O1J23b+ZL6S64UyFXjEwjb?=
 =?us-ascii?Q?tqixiargVqGEd7SE4bcdslkU0MC/6oY9KP3s616FN9kq7W6pra37MfisUfwf?=
 =?us-ascii?Q?e0guLQQPtI6vW+uhaz4mdZr+eQQZpYiOl+W7iBkPKZWUhQcdR5GHCg1GDwG9?=
 =?us-ascii?Q?DENap8RlZm5U073zFvLr5rNFDjc6RheymEQpuxXHF+jJ5M4YcLSuY0BNy2R4?=
 =?us-ascii?Q?46PlhKCiBNO9vsOKVDe1a9y385zMrY+Bt542QCFxV14HBcTQBJHJ7jMtNwFL?=
 =?us-ascii?Q?AD1qSannM2LlWg8sUVuBcSvGEzyAmso4YLsexcRLUTnTIBthEPNgtUSLay1z?=
 =?us-ascii?Q?U1t33euUEhaMczuN/guFlqChDcE357w/mVCud4vlM/e6hsaE12NrTFpqtTDD?=
 =?us-ascii?Q?VhOG4dfkJadvgZ53Ks9kHFaFkSKQ2vHQ0JBf+JXVG1jQlTpckoWOTv//FBgT?=
 =?us-ascii?Q?0553lRi2WOwCyzAqPCHYiSBHUGza4X5m1639GnVIm7L4f//isOeYMZGU+Ci/?=
 =?us-ascii?Q?GOb8WzjhbirTcwJzX5HQtsdR9t2sm/6g4YUAvnRbUn8AMCLz5QV/G/icZ54H?=
 =?us-ascii?Q?ZzHBw6u6eR53WDux3JVqa9APcvi/alBm0nC5uYual9XZkv4j25UIdAkSW8DB?=
 =?us-ascii?Q?HMEnH3NmLmqk2ogD/yDq7CaLfM4emQIqD6rKA9gTeOSqBpMdIwExAfSy979h?=
 =?us-ascii?Q?ssnvrMOY0nf/ufLUrx7J0cJiLaSvX3zZzc09WrOLGcxRoHVX8AzlcEbdsJqR?=
 =?us-ascii?Q?f640GxtOlCnTgpj0lbHHg/W+EXI5ZZN+YieB8mZHgHyUFwBUauCNnDcWbRVA?=
 =?us-ascii?Q?PbBxT9nEKoOiU1Qk/6vdu9luRZHT1ITBy/APfL2dO2bWSokKQpLbU/fHsxPE?=
 =?us-ascii?Q?finR3c53PNDfZrwBnFs7AZ1qJqRiXmU2bnBHFYFV5c1W8a0b4pvKiNF/QR9N?=
 =?us-ascii?Q?nY19sVxxd2X12DeyBB6pMDkuS7jdiLdY9BcgrlbOJgbWJcDIlqBarhUQOt2U?=
 =?us-ascii?Q?AfXzYTZtKHag+bomT5Xp2rFp82optz2306l/cuLDEmEHAjRSK4ZJb+kZm5a7?=
 =?us-ascii?Q?rDXQlSYU6Ktg4Nbn6pEL7sDYogiKw2o7IsuCeKDEhtyuVaL0gNW0LsH2fuks?=
 =?us-ascii?Q?FhzX8UeRO3ivfpG8Bn4JgodwS1Lc8MXQ7FFnpVb0TF5TjXnjCOMKKD/Fl1Ot?=
 =?us-ascii?Q?RIElCzijm6DHD14yDe4+K2CWNm5zI65oqa2L3P9vmDIcgmEJzD2l0JN3dAhn?=
 =?us-ascii?Q?KNuKLZxa5v683qCY5pr+g2HtIJHp0yRRmSLheWGbJ2nI+alRQoY3aJE37z/4?=
 =?us-ascii?Q?WD4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gGnp1ivA/oRCOvmsmgdyuqoKHgQuC0ipBWR35DTgWCDNmjsXGuNRVAjZ+Wke?=
 =?us-ascii?Q?HKYxvmccm8Op9U3HLWuPI9ROwCQTbIsOs2onLoWxOwfflbAVK4xoJPcOtQnq?=
 =?us-ascii?Q?J8vUFlmJxJVU4midaweQpfOaRvxy1OokihMCJoCXRyO9TTd3DXxIvZ5u9grY?=
 =?us-ascii?Q?MxzyH2OmtgoUWdASxBvVtAJ3PM1JqEJt/4rGViwTXKYYBxsyeL8aLLSmMCUY?=
 =?us-ascii?Q?bEqy7vTNikF0F3tTmNnLdB7Yh/FbiW1jn5OMrmtlAkus3Lqk2nQ7j6IKVOPX?=
 =?us-ascii?Q?nY5kJMwIXP5NXHyf2C9r2jVEImP63O6ypBV0J64zsSoRrALp/QjY0RwSsmXd?=
 =?us-ascii?Q?exacngm2/GW5mJUNv+11Tr57hSfL0RBtDiF3ncGt8lSqwba2zyi7v5DMlisE?=
 =?us-ascii?Q?36JobsXsYKkOphQQC80gz1nXEtMX9ehR8yAUBsezQ0hdF4L9P4NF+Pb+Qb1N?=
 =?us-ascii?Q?8qCsWssFiqB7lx/QtU2vSolRj43i7IdDwV/W8HA37MVmtWCrsY7HD5D5vGzD?=
 =?us-ascii?Q?kZmPiCR2NkNA4F1N1G4tOd0/iTjwwjEUoTsFK1t0GYRCXO2L5eV6+68eN4lU?=
 =?us-ascii?Q?wAuglhgKyuU+MctAD2XPlhev6yaVbDuxFzAZmx4Rai2JMkSHRs2rE1n1kLcB?=
 =?us-ascii?Q?L6aMQw+0fVuADmQLm+OalXlndikTS5q91zA4BMvelCPslb8DrljUfZaXTmaz?=
 =?us-ascii?Q?90mnh7TPgmbuAl6iE1JYT6vB80w4UJcIoypzofKWRghk+7tmuCOUhmf0Y230?=
 =?us-ascii?Q?sQd9pjdHAgVthBylc1wzlKcCn9J7fZ+vlQwMCxon1vTKCvudN1ujpBZd5w99?=
 =?us-ascii?Q?upSKqWNYw5FouEKgxaQ9zSC2t57KikB31lqWZ0bnR59VJSRsUPZnvUhaLU+6?=
 =?us-ascii?Q?n99XDU46E7RL0xThW0DF2H9pNIqIiRnZi9CzW5ho8sfh9QINNcy5D5Ot3IQm?=
 =?us-ascii?Q?oJiehN62nt4U9vV1miNWsD3j/FvNGjhhbfULiAwO/j5sKzujkloPnJn2hKYx?=
 =?us-ascii?Q?H26MeM06cS4apYXfhhqha6j0wOhrsmaL3PJ67y20ilp6MyYXCwdDSA4Moa/f?=
 =?us-ascii?Q?Is/tY4NYVaUH6tN+xg9TSPE73r0BL6gMUKNwP40oOHx5nNbAL/0hW7DzZJv3?=
 =?us-ascii?Q?QFv6zx2pdY7VPu38BbIbFXsaV59pkQlsnXvsXSFXbJpb2csDWvn7r80+77z8?=
 =?us-ascii?Q?cx6Hja9p4jx7bzRuk00FNN+ESsQhTYvknsI2cC08usIyZNsbAArueI7czeu9?=
 =?us-ascii?Q?jKCU7/v9rwCF1kbOsQZvy2Y6MZom37ZojzZ/UItz0Ef5E/cE7XF2S1dMgSm+?=
 =?us-ascii?Q?gSZIr9mO0q7vyNtJlH0JJUHME9hcUmsfznbkAvOwTlpHtva2ZlqgKQX0lNXM?=
 =?us-ascii?Q?+o+uZuARglBVUneJ571BxzZtaIBkMxIU84yod/3ctLfJwtKc5fCK57+8+Qka?=
 =?us-ascii?Q?wPq0BhsoDy/+0lpRYhffFA1uSTXTzGjQa2K4h79x5jYTOh0FcVOJeB9aJk+p?=
 =?us-ascii?Q?0HgqrYZOr1t9tDM0YFRqwFUGeqo07mT6QTJ6hrxeFkhObkqxUzFfm6KWBl+e?=
 =?us-ascii?Q?8uCfIyNC3yMvEB4mPDALAe5rP2+ywaYmHj5SO+KpZrWX6DyoFq/5RdyRnlrR?=
 =?us-ascii?Q?h8PrK7R9Yq2H3SXH+slw9uQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1T7D5hH6HkupmR9NRzxJA5xvXizBjGh5+juKn2s3U6rfQzsG1W+422WuDh/51v6/xRKN6bvX/YTEn93QDLv1ZajBtuFiU5d8g7/za72jCYN1MT2hb7jnPQxbPIDiPzUn16+JFU7QscR3R0Xa+pvZsshkMNSEreCOaSdykhF7dsD2wI+Fv1EKE6WcQ4L2AWtP7qY3u7P7+pxm/C4IoyLT1Z6XK4h1koxvhSQj42RN/mimrAHqU3Sr9T4LM7Kz1e9Y5NYDSn8NanV48/oduuAhJYUCFR2nPdlw4tyrdC2ryYrglDuGQ2VduRxdf9jfLk7MBDO9MgWIzcX3UPHmNnuwwTdceqEDaBz4RxwKOkb2rnSUZb4Cmba8qOTManU5suN/sSXrGJuG12lHK9ODEcN1ziw3s6ROwkKglqNLrOqhI3QTkeowCOLiupA56bcOa5xcKqNEhls5sB0SPEaALBwbfoG2q2NNMYzwWQa/2R4pPc8XiWWo3UgNcW2V6K2u8vGluu1wgk3auPre8PA8SzM/30/6V8MuQT64gHcclTK8o/2dDjlxRe6TAsNfHQfh3wwWtr9J1BqBochOBBhBoGWbchVbH79bl0OS0R6Hf6jmIvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d780ca2-e1a5-438f-3767-08dc8fd7fe5a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:23.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf1Db37eQQjn8yB1O81H0UJs5DqyRuMiKmiY0qcT2NapYE+5Dcnz5FWrMjXtPDG76RrGAxKPnExJN5iDviSzL5k15qmSK7TBT09jOKbEekw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: bamwehXJsUT65StQ9w5cyiGGeXUF1A1v
X-Proofpoint-GUID: bamwehXJsUT65StQ9w5cyiGGeXUF1A1v

Use mas->store_type to simplify the logic of identifying the type of
write. We can also use mas_new_ma_node() instead of mt_mk_node() to
remove b_type and clean up the local variables.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e53f1f398ece..b2062e034f89 100644
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


