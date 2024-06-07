Return-Path: <linux-kernel+bounces-206620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9003900C18
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01231C20E0C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1BE14A4E0;
	Fri,  7 Jun 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QPB/Ol8k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LttFZupC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5113E8BE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786431; cv=fail; b=BPizZFvP1NismDTZBhABx4Csmqhg+jtLUhIZ4IHoNmDsKqrRSlQGQeaKlps8hAzl9qce/D+lhP3op02GvOgz/m66xUJ6RFH+mRMmj/mUxyy3fN6VT0wNF+9MOY7tBj8vtwiyXDisHc4uXjxGbER1SokdzxrzCpK9nybtRvcyfTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786431; c=relaxed/simple;
	bh=XCs/eLFwhx4sg/wv9ctzvp943hqtsorFZNltJgvMBto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kz7Tu/AR4MtWQ2wcEh5J6wVXFtppX830dsRe/KrzuY26ohpLOJq1lFW/fyYoQm9mmR50ALRsFaJGVY8g+KJi4WfReCXi/ktmLlAu+HSjNnZoyg9acJdXwAUc9ec1ld76kLBfvjCnG8xxgYN3Yg4akkgXx7SWI/azxIKXT03paXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QPB/Ol8k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LttFZupC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cum7h021527;
	Fri, 7 Jun 2024 18:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=t2/Od+WpVk7WfFC2jfuoIu2ZEGfVLJUcbhjQt8CRCcg=;
 b=QPB/Ol8k+jhJKx87C1HUfohQf7WoLQ0Tx9qYLNXjvu3VKq0jPBtF/AFO3bdllet/gqnY
 gBRPC5sqR0aOovRd19G26PDkAbW0OLt6N3HmDgollQzmuOF5UUrh25gqVGCfcxKU15UL
 PAP99qbS4qySd9PGH676GdXMmrz/hQv2QjSqgPpdvZ3saIaLX84hLtB5EapUblBeP7Ey
 bCf4tHxXwFL9tz7YhuV9c79o/npc4jfqcxoWdBhgxHfouDpxtPCLfEzHpwqVDDdE+cWb
 hxyFREc6GkrNyLqtubVG/B+1xB8UGJniaYdMr8Ew4a5/8v1y5FXrLoY13bnjas+KBzTM 4Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhea3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ICR48023938;
	Fri, 7 Jun 2024 18:53:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2k7tv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYOg399oFM5DPDu8F6PSyul8rlEMuObL7z7sbklC4i9K91TbfYlWhC899pusaC6SwG0Re6fe6M7QjlQ+vYhsrp6FMOfWCvQ5sI17zKSMx2j1Seh0lsvYg3sXsLcoVfl6kmY7oyaxvyd99+YCP6Lc6us2PuNw+qJ6ssYyxYGOm+zhwCUiLPUDnSSlOl+8jmcLeUwzUrNGirZgfFjHadepwuXdL1Mjqte4wKUlI3CR6eFxWYxIjtz50uI4CppkxhQorIBnb5/rNuqnvvIHxI6XgatycJqhSwBlAvjey806Yn3KsaP2l5qqtH2+j4EZXVc9WUQb1OUO+mGXMlSYmz4ePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2/Od+WpVk7WfFC2jfuoIu2ZEGfVLJUcbhjQt8CRCcg=;
 b=D8WoSiILVaup4Wlp8QebIalf54CeGDVkuUNg8Wn9ifRM+O4pfLjsdcLAddEHS0a59++n/Qr11wxk7MTsbj60tTz67ItV51QbfmpJ5GFvn45PiY6R4AjcrRejL5aMcnkGNsHH26LhJ24sjXFRxh21UzIwikoKKpc1Gtuywz/Hj+IZ//rAYLdU+HIxQWUEcwccv7btKnQamLsGgSAL+wubouXdqlCuBrYBfZCFM9boNuy0VGfs+szYfc7yBO/+yHkbfSElLXUMMrwXkA+8SV5uYZEMUI6r4POQABcLGRamVw/xsyF1VUW8FRYqBb7IOTobZIVpKadvSNTLodikn5FENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2/Od+WpVk7WfFC2jfuoIu2ZEGfVLJUcbhjQt8CRCcg=;
 b=LttFZupCnRDyP4TBhX3tuIHn7dmTlnHF8BRwOaKY/guPbXYaC3d8bFQ1ogkjuIhs4poD3xCFgK6ToxNOzuE5wTGj34Lc43Zs/aPixgRQIdVmJHkRb4wmJod3AJAy+iuq3Mdutab9xX66dns12KNSXMPeY749yrAPWDBPo3l7uK0=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:14 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:14 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 05/16] maple_tree: remove mas_destroy() from mas_nomem()
Date: Fri,  7 Jun 2024 11:52:46 -0700
Message-ID: <20240607185257.963768-6-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:208:23c::34) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3646da-d32d-4446-4493-08dc8723163d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0NwiBiuwch0cpB2oQwe/HrtXB8T7Vec2sTykymen48Blh02DUs9HTSGcDRI6?=
 =?us-ascii?Q?AQ+8rbRj4t/ftU3kY4NGYu392zHHGZWiRwC07Z+ds/rbP705BPTSOiaQ6zoI?=
 =?us-ascii?Q?m5QB/LgwOZ+ZSH6V+kbyMHotzwJxDODZj+VgMCNDJ5IjqJRoMQ7z8yR2t8Va?=
 =?us-ascii?Q?b8J0UPG/FhTd1L+IQYGHafCkKGMHdc4uXsKoEdf0S9y1BFCr8rMgXPENeziY?=
 =?us-ascii?Q?1+XfVF0W6phMlsBJYkG/Ec9LcTW/9PJszJ5N+DFJ3UIfjbhb647ebefJr3gj?=
 =?us-ascii?Q?XhCZoNRYRzPVFA3/Yhte/WEASTOzo8+MEBU4lqxs7gTFFTbniOGsqazF9V93?=
 =?us-ascii?Q?GczBKgE1/JHUM1z1QfxdwQqCC5JtbvVFqpLiJujJo1CzFN293OiDOGxbyJxP?=
 =?us-ascii?Q?gdLK2ukzGX4o7ZbNV7IZMThjJgDqAtd8XH4owMvlrgJlxB8uMpGSjtJVt0lq?=
 =?us-ascii?Q?L3L7vHO5UEam3zFSLDkKQ65ZN0ESOAn/xhHl3YTrNz5FYdBsayFh9xT6vdoD?=
 =?us-ascii?Q?4T/aW3tqDCIN3/zLfpGIOEuMf1gNhgGLu7EB+v/EP/GhGvesaIua4/4QtY2e?=
 =?us-ascii?Q?OJr6ewPfyOCS7iPOhgAuj8xRi5c4m9U37rCyiLXbfCp5wXbZrqk+hhAHOOI5?=
 =?us-ascii?Q?OZxwpPdjIr5TijQwKti4RkqBYge0t3jCTX+UrbIgt51QYhhrvwK8i4A6yvFn?=
 =?us-ascii?Q?2fI1ZHWkF8i9H76+gZiXeEFVRtjvFis976yktziM2hImaSXI07CyRb6lSBTV?=
 =?us-ascii?Q?ELo2iHNyGN+Zfl2zJJ7wAuEpwYdaGnRaHcy86uoUruOw2/+sqLn46RUNbruv?=
 =?us-ascii?Q?0UtB1WrK1gtVHMZ40TSeIJFj+0b79XNnlzouu6aER9ERRci8+bzmLHhCvB2E?=
 =?us-ascii?Q?kzEODxXaaRWZ5GQacqKLNxnRVWHix7/Aj6XMLHXYUq0NpFV3dlBfotofMH0J?=
 =?us-ascii?Q?R7Mj+QE9Ayvn0C1mNQcUmlWJdCzgT8TKbhUdSXEUXh5YXXoJ+Ok++XWunSZ3?=
 =?us-ascii?Q?dEMpywM26j1cOkxvmYZ8Se5HLzK2jSIdqhH0EdKnV0K5kU/sHWCElLKfnx8W?=
 =?us-ascii?Q?8Fjj2SoN8h0wIcUcYgQVUB2umqFwPnkj7M2ieV2HiLASbJz8gyjILHSeVs38?=
 =?us-ascii?Q?i70WvPYFDKk2cECImcGNOwpFE6oEGTaFxVimqKCmx/NWiO6jDlVN0tfsc1kh?=
 =?us-ascii?Q?uHJbJxVJ2/lSQKScNRZONVkZhaILGoREc0zhyuU1FgHLN/fwyvqBbgMHD4Yn?=
 =?us-ascii?Q?6uUZ+IzbqfMpqmjnKlDoLD9HvrclEW46W59+kQ8aJKSc+FsTt+MXpWdfm10l?=
 =?us-ascii?Q?T+3H02C2/CV9aA6ZrTfCwpn7?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QcrS8/g+h7aJgavWJlq9pTP0lKHvlQGIVdIeDOZt8QI6QSvr1E3lScL1zd3N?=
 =?us-ascii?Q?/GQsyxEcpO2XpsOPjtxRkxJKeXpbOJZnG/VgtKBO5JyMmbwZZcR4IBfhA1eL?=
 =?us-ascii?Q?nSEaHgDEE6nVTQE7g/RUjm5j18AWFsaMkV7014BhCniRh+GYsyG4A0odfaAB?=
 =?us-ascii?Q?O/Z+0ytLckkA2vWAmy0tOBdSqYW0ApBK4Oaulx6N6Nan2aqFwWxEo0e4zJo4?=
 =?us-ascii?Q?JnRROo0wEpt145FxmpjRLn3bShoYJtjy4tQV/qqN37Q3F1i4nNM6/qQecHr1?=
 =?us-ascii?Q?VaclAIKKo0yS9cQGz6DrdcCE4D4Oe+6flS3CeJZ2lmDc94ILc56wGX6s/aCR?=
 =?us-ascii?Q?JHvJaQyJTuSVsSppKN03mg5cxPE2OAo9Z0Vs+24l67I9svLvTRE/fB4WEXeO?=
 =?us-ascii?Q?4HAcuK8vvup26WYwfg2ObBMCXztTBYNSe49WL4IlW08ZwwnLt+DVT/LfZU9h?=
 =?us-ascii?Q?hKegEZNRWLViR96S1bqSXhF8MWE2fPWW33OIndhIn6jnTDYLmkURmtGdRop7?=
 =?us-ascii?Q?Jay8W2CdJyDWfSMdSigH0wNB1dWnVnY2phGI+0MVuSAF9PyVle6x88M/DPqN?=
 =?us-ascii?Q?pxulAc0KhU7POk7ldtBzKJdmnlnvkw6RTy+yfSFEXSbKXiWoE076NhlgsSxI?=
 =?us-ascii?Q?u0FsKACYzZvBrZIb8iVjXdMO8La1+/ACwvLGLwjkeQcjzFuANYAh+7m54It9?=
 =?us-ascii?Q?ubRe6Xiqf/e2JfqxJ5Xa9Gse6ddRVBjJfBhyuY1Q9fqDLvSJky5r5Y7vCUpb?=
 =?us-ascii?Q?bVPfoo6gScvLKNe9q9VIRrcDlUqHbLMtyKu6w+lMkWRmMRad1h+zNIHqR+9/?=
 =?us-ascii?Q?9WNrrPrT5omwlBuHLmFvKOpPe+Z/d/1HVZr8P0bQWi2pZmncmobp4dbm2qwE?=
 =?us-ascii?Q?A2DjFsaDVZzap4DdPaSKm7tVcpQxs4nEZ2BwNkJ6efhPAcyM99uighB/SD49?=
 =?us-ascii?Q?yf5/DJVdmqcoQhlZbZlK5os/1pazXioK8AcXmhPgAMUEAgPcuYOmpHf7qzKl?=
 =?us-ascii?Q?aNGs0pGP9FRvRieoBPdl38pR+0zcSzqrGdwy+7ZCMWNM0RDqjs+ASHhkci1G?=
 =?us-ascii?Q?/CHtC53Z6mtd1Ld4ypnqFkKROYDDZna1lAGv9fkKgvsRnO5lOKRRqI8TshLs?=
 =?us-ascii?Q?DVJB2f7D401KZVDx15SHvbkWuSysdvqcaIXBgv5OtwUsj6vdgJcsu8BwehMX?=
 =?us-ascii?Q?0CfNK7J3irvdgTRYtGKlHC16byWIVfq48RR9tZ51GAwIVhPqWu3YF1Ghy7aq?=
 =?us-ascii?Q?A2XKVtDYKyrF0rdOOvLL7gIVZgCSgjxpxQg4isMwSQfJey53aEoC8eSegMNF?=
 =?us-ascii?Q?pqz+dovQRUcqVr4mmCWTBGJ5Pb2wKcTp0H70/QpwViue7KGvLzhoxeUtThx2?=
 =?us-ascii?Q?AVl105r1SSF670I2O9OvAh6q3AwyBi4J02/PgZzeT088Pf6yVskGCG4tKekl?=
 =?us-ascii?Q?4XElxPQqDRfTrVUu2YgzGlXjBFpj4F7EXTYVPpwPoJfdN3PLzzzcWyr5tGTf?=
 =?us-ascii?Q?ARyWyLTz938BCghDy0dX4LIDUQLaZHu06D8kvPryvxLgyxeKyhqKCC86CnA4?=
 =?us-ascii?Q?y1xtJiJKjNb8Jn4TymDaxWrdyWSLlAZL2AY9mfNnUHyT50kqJwtJN2vUb4m6?=
 =?us-ascii?Q?x68hyfdemxGePbdj2n4Qzx4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TmW7Xw8h59iMX/gBMJAjKdBbs2G7wFZJipL2lHbtBETmhjnabcRX9IoLl26Ladr4dZ3/CyVvy+Mldsdema4fcPDDd/SxQp2Y7AyiXneY20yTnEZJEDdrKGA9TDeG6daV7VsN0iwXPjxwp/yCGEfmhmfM6wXX4LCatZedAd4/tSP3CQ7skdewyQ2xjXVY2XYYvFkj8nsUKS1S0/wNAFP1cJtm7fVYSeU8XM6Vyq7vRJ0g6mJ/3gAqa/4PxGjcgbytFqutcobhLwTBIxhmQokmqqTTtrf3iGMMSCq3TAz5sD2LetfcaYQlhWPVItvTHrQM1f2SN96ki1z/Hzd9rbDEPGS/X9gdmbsSCmCkRuMpgmjLkVQv8zqyorLTL5B92ri+93Lu5dfoNNUHpqUQITVdBPASksRUsEyuE2PdJONzBiWpzOrWLVca3pxGfZDJl8CD00rfmNPxHapsD3A8c/M8VTue/03XWgDyJ1kCksxhyUMAcCA0TooaDAUzaPMYBVHaM08CpFOxeP5s2qF6BKhJLQeT6nNl3EXMytCmXZ4mKc5/1F1pY56dMkx0120mZPY03DVh0+PVB5u/Ba6CMGgqhrbbXmyqvCOdUoNexa7P8i4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3646da-d32d-4446-4493-08dc8723163d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:14.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3kJ1LkfIyJIHOIqRnXnbVKvycYEnvMzC47TdIWTA4L+oppadu+0kQvx25NbjlthUdBGo4+4958IyyRC+XUV4PAeUJ5PlEmZYiv39eosmI04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-GUID: nk2u7n62-OunHNqMhyfLXnWAShqkBd6Q
X-Proofpoint-ORIG-GUID: nk2u7n62-OunHNqMhyfLXnWAShqkBd6Q

Separate call to mas_destroy() from mas_nomem() so we can check for no
memory errors without destroying the current maple state in
mas_store_gfp(). We then add calls to mas_destroy() to callers of
mas_nomem().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c                 | 39 +++++++++++++++++++++-----------
 tools/testing/radix-tree/maple.c | 10 ++++----
 2 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a7f585ed488c..b933df290887 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4527,6 +4527,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
 	if (*next == 0)
 		mas->tree->ma_flags |= MT_FLAGS_ALLOC_WRAPPED;
 
+	mas_destroy(mas);
 	return ret;
 }
 EXPORT_SYMBOL(mas_alloc_cyclic);
@@ -5607,18 +5608,24 @@ EXPORT_SYMBOL_GPL(mas_store);
 int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
+	int ret = 0;
 
-	mas_wr_store_setup(&wr_mas);
-	trace_ma_write(__func__, mas, 0, entry);
 retry:
-	mas_wr_store_entry(&wr_mas);
+	mas_wr_preallocate(&wr_mas, entry, gfp);
+	WARN_ON_ONCE(mas->store_type == wr_invalid);
+
 	if (unlikely(mas_nomem(mas, gfp)))
 		goto retry;
 
-	if (unlikely(mas_is_err(mas)))
-		return xa_err(mas->node);
+	if (mas_is_err(mas)) {
+		ret = xa_err(mas->node);
+		goto out;
+	}
 
-	return 0;
+	mas_wr_store_entry(&wr_mas);
+out:
+	mas_destroy(mas);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mas_store_gfp);
 
@@ -6366,6 +6373,7 @@ void *mas_erase(struct ma_state *mas)
 	if (mas_nomem(mas, GFP_KERNEL))
 		goto write_retry;
 
+	mas_destroy(mas);
 	return entry;
 }
 EXPORT_SYMBOL_GPL(mas_erase);
@@ -6380,10 +6388,8 @@ EXPORT_SYMBOL_GPL(mas_erase);
 bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 	__must_hold(mas->tree->ma_lock)
 {
-	if (likely(mas->node != MA_ERROR(-ENOMEM))) {
-		mas_destroy(mas);
+	if (likely(mas->node != MA_ERROR(-ENOMEM)))
 		return false;
-	}
 
 	if (gfpflags_allow_blocking(gfp) && !mt_external_lock(mas->tree)) {
 		mtree_unlock(mas->tree);
@@ -6461,6 +6467,7 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 {
 	MA_STATE(mas, mt, index, last);
 	MA_WR_STATE(wr_mas, &mas, entry);
+	int ret = 0;
 
 	trace_ma_write(__func__, &mas, 0, entry);
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
@@ -6476,10 +6483,12 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		goto retry;
 
 	mtree_unlock(mt);
+
 	if (mas_is_err(&mas))
-		return xa_err(mas.node);
+		ret = xa_err(mas.node);
 
-	return 0;
+	mas_destroy(&mas);
+	return ret;
 }
 EXPORT_SYMBOL(mtree_store_range);
 
@@ -6515,6 +6524,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 		unsigned long last, void *entry, gfp_t gfp)
 {
 	MA_STATE(ms, mt, first, last);
+	int ret = 0;
 
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return -EINVAL;
@@ -6530,9 +6540,10 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 
 	mtree_unlock(mt);
 	if (mas_is_err(&ms))
-		return xa_err(ms.node);
+		ret = xa_err(ms.node);
 
-	return 0;
+	mas_destroy(&ms);
+	return ret;
 }
 EXPORT_SYMBOL(mtree_insert_range);
 
@@ -6587,6 +6598,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 
 unlock:
 	mtree_unlock(mt);
+	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_range);
@@ -6668,6 +6680,7 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 
 unlock:
 	mtree_unlock(mt);
+	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_rrange);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 1c68ccc1b475..e897f60d1a1d 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -119,7 +119,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.alloc->slot[0] == NULL);
 	mas_push_node(&mas, mn);
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL); /* free */
+	mas_destroy(&mas);
 	mtree_unlock(mt);
 
 
@@ -143,7 +143,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 	mas.status = ma_start;
-	mas_nomem(&mas, GFP_KERNEL);
+	mas_destroy(&mas);
 	/* Allocate 3 nodes, will fail. */
 	mas_node_count(&mas, 3);
 	/* Drop the lock and allocate 3 nodes. */
@@ -160,7 +160,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
 	/* Free. */
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL);
+	mas_destroy(&mas);
 
 	/* Set allocation request to 1. */
 	mas_set_alloc_req(&mas, 1);
@@ -276,6 +276,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 		}
 		mas_reset(&mas);
 		MT_BUG_ON(mt, mas_nomem(&mas, GFP_KERNEL));
+		mas_destroy(&mas);
 
 	}
 
@@ -298,7 +299,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	}
 	MT_BUG_ON(mt, mas_allocated(&mas) != total);
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL); /* Free. */
+	mas_destroy(&mas); /* Free. */
 
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	for (i = 1; i < 128; i++) {
@@ -35846,6 +35847,7 @@ static noinline void __init check_nomem(struct maple_tree *mt)
 	mas_store(&ms, &ms); /* insert 1 -> &ms */
 	mas_nomem(&ms, GFP_KERNEL); /* Node allocated in here. */
 	mtree_unlock(mt);
+	mas_destroy(&ms);
 	mtree_destroy(mt);
 }
 
-- 
2.45.2


