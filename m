Return-Path: <linux-kernel+bounces-206626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCD4900C1D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE7D1F231AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68775167292;
	Fri,  7 Jun 2024 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mmAZov7q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CeUOI6fe"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0ED15AD9C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786436; cv=fail; b=oi7OkevLEPxMo8nLeRakr09y3ZlDWSvoas143D7t6ZMNY6qEXIUnlmeXp6PlijUSN49gJGlrflmNe2k7Y0lBbljXWdAVXdP6romzYg3/ii7dkoyw4VBx/zLq7cXd/l4mbkc8ogoVPH3s9N38PdaY0plOcatdl5CujXMttAKXS2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786436; c=relaxed/simple;
	bh=SC9mgJvnHR0lVnGesibUnyhPSmqA4MG2OZQml/tJc1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EyW/6m+sVGvn7uNl6SMHiNuykSUU2pmLa3/1nyKS5h/KslGDUuUymWthNSN0EKHD1+lnxN+i7FQhLZt8uCcBI+f+y1Rx3rUQ57SfT3OrzO+y80AzHVSDD+jmjqNfbQIhZAQEAsT61Hma542ZikwcPpvW+flkiN1YmV89MAMZWvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mmAZov7q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CeUOI6fe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cv6SL010387;
	Fri, 7 Jun 2024 18:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=FdLnC6elJcTLzta3VDOmOxQ9vkOouE2N1SeWytMh46M=;
 b=mmAZov7qNpW/CQ+J7pvpPoJ9rERDO4fr3jJZI5UDjuO0vbeIZJr1ij9CiryO9Naif8VU
 37lOX2S+lToXi/5e5KQSgeoj9bGxJesgMhcRjGNGVWixtYrSxAL9kj02sl2/pXU61EjJ
 0bhZjfKL82ThOLotCsDk2S/Ak43xqMi667CTJqsvf1PK71fiFm4IiLs0M374hc/ZEon+
 LzwNu48Q4heSPUmVMAQxGVZAaUI2aIaxEJkelOK6C2kNPmBBvTZaVgcSBKdN9Sc/kB+a
 lu3Yevl/wjbj4bh8/g52BEqgaKwC0z1CpjKGcMB0xFCwXUOVAgwNrdGte0SR+XejuViC bA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtwe89a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ICR4H023938;
	Fri, 7 Jun 2024 18:53:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2k7tv-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lauC7seCsn1sPsf1tyJm23MhZTicEgnI3c+jWwhKiVBLjLHaqSqXQNlYVxznqKfS6yot9N1HKTEcLCHHS86JYdRa8ikypD+J/D27cE1O7bLxAro5r0+WwzMeg/bZ+3BodmYieYIZvi8aNs3W5B/m86oSQwU9tEmKfPYHpYO16KzLDKPof6PMVJPvS+/c3WHQuGg3Bf4PrlRtdFUYBUXwTHrj4Ajdg2LiZgYa4bFMMOY2pYic4u9bCWBLRPy/brS+Vi7kkJ7v5B3KnqtB0uZ8B3LV69mGD8MiHbl4WLHxJO2KReFWbMMVtaWKvwK//fk2Dyi2TvafvwjI5whmq6MdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdLnC6elJcTLzta3VDOmOxQ9vkOouE2N1SeWytMh46M=;
 b=KlyO6JCWMQOENTQsL378WuGDQt26akF6kdrhYHkwEnEg+zfRlJ+a+dUuIhVJLM6pkPeN7vD0eidKa3ZRPTqhYBHP6vIc3g4z48SSPW9Gp/GO0szYH3h/B5OCOYaOrJt4B9nKDFQgezX9kk8S39HidVXHtDkxV94mP3NAS5fHvTrPkK5Al/VQ66QFUGKM9KYr+xWFpYykCXYy/H7vu7seYxa6Rc6gsBFuomAisj1mXLj8LUigAqWm89Tx2znwXOjLdTPWLEuXAj71+RQon3UeJyo2zDo6hzt7EkWFGbfcL0eOmum7gfgTFoOy85slAq4Kyiqc7NhqfCwfEcPN/jDCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdLnC6elJcTLzta3VDOmOxQ9vkOouE2N1SeWytMh46M=;
 b=CeUOI6fe9sseLBeffNK03C40fud03HNC4nKgnKGCK/7umQerBcX+PoXqj2zNYPF0b+y9SI0usfmYZHxclwXm9G4+hmkscVQ2WdWmw/cfr5uzh8QgiA6OCVs7J8P3zGhBCDx8l2Z31UxznbEeOZMFAmKSg9ftORfDsnD4wMRbFVE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:25 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:25 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 09/16] maple_tree: use store type in mas_wr_store_entry()
Date: Fri,  7 Jun 2024 11:52:50 -0700
Message-ID: <20240607185257.963768-10-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb1a767-1a42-49b5-b21f-08dc87231c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SOrt0XI8XnAPZew8pEleIYc0pqE3lq/s4L4eIaqUwyHwPTvMD2vpEGtIq3it?=
 =?us-ascii?Q?i2LRlcsFVPwNuiFcpGJS9BePNkEwuHt4Jy/p7Hux4iXqql++b9P3PKmnYekr?=
 =?us-ascii?Q?n7ymsF8cEVyQFWwoj9DGDTE+BXxgb0M4zWYB8T/SVUrFiBqqljiiapCnPdem?=
 =?us-ascii?Q?DMUdFSWsTYe9qOjsB9nthd9olSpVZGSK98IyCN+qhSJuAUeuJOQafHWO6BFL?=
 =?us-ascii?Q?g4LiYmDHD/2nYEg1N/JR7Ngg01sgSsFLd/cEsB7biTTolmYHNzywe8v6+zpe?=
 =?us-ascii?Q?Tr/rx+m6GYYLgUY+gfNg1Mbt+t48kyM+h6jAAE+576SGcoAZixf88osHpEQp?=
 =?us-ascii?Q?+k11UWXi3O32DWxh56mM9y93wETPhW8gRHJAe24hf5s2+kiyRQUd91iY9inB?=
 =?us-ascii?Q?vaX5vJ/DYw0x7Nr+w4yIKVld3grJ6XGQMuqCXltkX3WaJyUSjG/fOtrkkjoE?=
 =?us-ascii?Q?4vb8OoB8NDVPNPRBBou13LhWGNBa2udM2tZ+qxrjGtYrLIniVBaCVfY0tlnO?=
 =?us-ascii?Q?rD+1nKHg6B8LpOym87hOw858XeNzX9o69kgDodG0OSAsqnaMKg3E+V9yogTs?=
 =?us-ascii?Q?rDYdNJBlbkcXdI8ONaszT3J0NaEgjOGUZycNg8tN940RoRpEgWFlga1d7TsU?=
 =?us-ascii?Q?MrkZGKN/6//x9wdgDik2R7++o5gRzmwjSUgFdPkf5blc7w+iwUc2M9h31JsL?=
 =?us-ascii?Q?x3x4LfPeeZtTcZCXGBKbPFiK0fZvG7gyq82iMucisHkBeuOXt6t/5URXxX60?=
 =?us-ascii?Q?fR2A9NsZZHEzoiQhtCes/xUz8mvUdHNtyKf4RiEBKnvaeMdRsE5KTVhXWRac?=
 =?us-ascii?Q?dqMqck4hPg+ij/SiOVJa91CzhekY2wZneyueYjwVgTlFt4AqZLP+lY4v9T7x?=
 =?us-ascii?Q?Fq3C9me0ESg9QnQKK0gx0U/CzxG3M64Wkw28z1BFuntT88vnFQwTUFB4hrxV?=
 =?us-ascii?Q?WGFR2i4Y3TfQFM7Vg/UQwL4Z9ywyQdkNndmhp17+pcdwWqQMN+qp6BTLWdid?=
 =?us-ascii?Q?yCr2ofaCfQUBF3Ybw0twcZNdi+p14CDR2g02BNI6ACiIS6DMHEB6fxvzXsPs?=
 =?us-ascii?Q?VaSrKHCj/59Nej0/jAgLepndm9zezi1HEvzBPtlvudhsgBBHvxGZcwOOYzmR?=
 =?us-ascii?Q?kn5Rs1GRuDXFvsNJ9K488csx4MSaj8LNlvLCS14FY3vEoBawpVr4tPKxz6AR?=
 =?us-ascii?Q?BoFsJn7cQJuKUl1iQ54wHBb3I5a8Kfv2sx2Y/rsbqgDhNUOGY9UkDyE4VmdZ?=
 =?us-ascii?Q?lmsaDb3mj/0PKDY/DTZXZl3N/cbokw+vopoRYGvQE6dveFjiFFr5UQQU1gLx?=
 =?us-ascii?Q?W9TEMr3aTCEjMDpCkeJX7TBE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RBH6gLPWmishdK9gBpk9s0jWJkpqwagLssRkdcKt/N5Ipin6B8NmWchAaDdX?=
 =?us-ascii?Q?H66nEnEUCYORdyvUXZqZTto44J6Lkxyx0cugUlk4AB3uOAYc874/Y5GuRIjJ?=
 =?us-ascii?Q?t3HxkmYU3AbkU3LumKIGV4+kgvIVRK6ircmJuXTah/cwwaacMkl1xsz3QKpv?=
 =?us-ascii?Q?x1wvf0uCuPwLrudl/cDRatxlxzRDO2qIGVRN1OAD7uT68zCBcCxzl14ARsxt?=
 =?us-ascii?Q?rjncORxTn3ZKyJEGPl3sdDzvS0Vr0mlT7oBnV26qpdKxumukbU4uYtoNg0I0?=
 =?us-ascii?Q?2nahCXY39sgGxLIFDws7aav5DWQou2j+4YjhsJJWyheHWLmTAKme4mVQatLJ?=
 =?us-ascii?Q?WfY3WjhtVCfORTN+W53Fe4VBLCtglch7xTBzbjQvZztP/EIAO2JKraR13qFX?=
 =?us-ascii?Q?OMs9IUFD+Zbo3A202Z9kH75CjAG+qxxkY31Lz2r7lIIS2XPzDOjHEY+Afjyn?=
 =?us-ascii?Q?ArmBBqgk5REyQEmr1bzQHCpPj+e8/JvnZgcilxo90tToLps7SfloYyEi6uyQ?=
 =?us-ascii?Q?lERFs9PWNSCqaWBOOvG7zQzf56IF2wTI4jNWHOfngXXGx6Seoe5h1KeERQt/?=
 =?us-ascii?Q?hXZDaQ69mBY4hYwvbHMNxcb8wPpGQCSzGzevTccF7LghZ+2Xl50dstHZKUlk?=
 =?us-ascii?Q?kmRbqzQBmhj3LuZfyB32jKGhjpXtJJeQyfhdnSpQgSmox+HFTTQEUBM3xFnk?=
 =?us-ascii?Q?yLyxElGAGYhE/vnCGdaniQtoaciPRTNmrl4JIhmz3nktiPNVTjKaA+MZ5uLF?=
 =?us-ascii?Q?Gy6W7iJRDwIeRzAmPX7GAKeZsLs2fOfUHof5p/NFmQqbqBGiXSV2CeZXezrV?=
 =?us-ascii?Q?RuJpCmxcEawBtb/XfUeQvPbqpBC0KjNW6IZEuvmiaLEr+gCHe1316YHA2Y/G?=
 =?us-ascii?Q?P36tkDO0/8KGHQQIqgdIySBjQCXydfKpcyELLKYnedjVF+ZmH+KjXOqqQVPK?=
 =?us-ascii?Q?t03WR+a4kyh3YpVbbD0nHvL7D29SK9EgxHuqB071gNHK5afA+hseNd2qKnXe?=
 =?us-ascii?Q?MC324/XojmzWog0+kiAjjHm5gp6pez6cm3EZFgwn4yfiXB3kawDfYEeySAvD?=
 =?us-ascii?Q?JAwIr1fiRq7+puJCHbNjLfsYTHX1UPuRHlUOqrjQPJUGie5PpLBoZ8u94WYv?=
 =?us-ascii?Q?7hrmLQNjT0qNAT0HdFYe02+KHikbd8TgquznUMH6z4aE2gld+LbLM9RbagVG?=
 =?us-ascii?Q?rSAT8gl3xNSf/PXm/JsPCrhaqAiZByf7EVdBn8OXCgSpcyTrg9xSlu5Yu4+Q?=
 =?us-ascii?Q?b1gr3pvcv/ncPYiBKxSHf+uvfQ9cNCLEFdNXIDYkO4NYPjK/P5c39+CQ/bRS?=
 =?us-ascii?Q?iEgMUym41E4WJcU6vBBAtN0yPkJjqVTO8zbO0YFyIPYmWoHNH5O8cDP+khzg?=
 =?us-ascii?Q?dxA4cRodPskBhSGtaf3ciR1X365y56TvQ+um6ZKYE45PyPqUH/Rv8S/xwIme?=
 =?us-ascii?Q?tVNDapEpqGua+TADxWN6oRBH/615ZxqvxO2VfdgaSHcxaBdFjxPi6wpL0BwZ?=
 =?us-ascii?Q?EryaoL6aAB8f5nI/pRq5+BKXpZPPslkTqcPzGByqVbPYS787kx1aQ5c6sAeq?=
 =?us-ascii?Q?pb2F+WOCVQgCIQEL6ciJwNpAuGlDM5qY72rGESbWtmFQKuW2Cht4h0ZpzZJe?=
 =?us-ascii?Q?S5CclhGpCG6XASawt9JcCgs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0ARf6/I/EUltTOs/J1BNkkDQJSfkHJcw3i8AC/ZpKcGK4Gtnn27RIOZE1HV7h5i9yU7PSZDOVYrRhv0eAH6zJ8oL6MBBqFwtZQAfsnP3GRmQQl+epiGrFR9uUKkgoPVD4psMxlpyAIfQwIBVnrZ7pHwSDRY1AJdinkLAMCLH+kd/7QDKLhdbng5MIpg8ngiAWpFk3Gff7QsyKWtSc2N8joNzB1bW/VdtQoDWJF9C8JO+IV7t4UDjEUKvZhoE/F+roGWn/WDgCQF0cgw6e4FRI0fa1qrAbt89Pg4Zk+ayeuCSAizbtIwfDE0IRTt/9czgREFaDpmYVt5oMJeCs/uOb/ZKCzz3nhY8vQwuC+rW25czSCgc03WK96aUus4joYtnwYpEburWcq/hM9law6/R1nT9nmD6H0T6w/GxOGnWReSBbYuQV1Cn/RTxnrKiEf80qoFoawdFRyYVsktNabzAtlpQVMiFRtp37uxEwzFUt1mZF6Awdm+yFh1dzAgupFtxILcziw/9+oqWXAeNcmCJL+mqCMnYfb06DO7jM+Od6U31bFrB6qdZ8ZXIoFLIan5IuWLe9Dt42xEVlMhj35U4pmcVowaHgg7cPbilRMeM/2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb1a767-1a42-49b5-b21f-08dc87231c75
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:25.1942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51HFLJJBeNcuU66D0H5AVBF6mC0NA9xyhsw8lrlAV1otaidoPFCvNp5RZuNyl1Nskd88T/1DdLWZ9WG81Vj4ZD6Zv+kundTB/du+8cnells=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-GUID: 8nkelKO-z_5mcRZ6sUp_6VQLTK08V6ol
X-Proofpoint-ORIG-GUID: 8nkelKO-z_5mcRZ6sUp_6VQLTK08V6ol

When storing an entry, we can read the store type that was set from a
previous partial walk of the tree. Now that the type of store is known,
select the correct write helper function to use to complete the store.

Also noinline mas_wr_spanning_store() to limit stack frame usage in
mas_wr_store_entry() as it allocates a maple_big_node on the stack.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 55 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 91b18eef81e1..2c42e99c400c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3780,7 +3780,7 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
  *
  * Return: 0 on error, positive on success.
  */
-static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
+static noinline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 {
 	struct maple_subtree_state mast;
 	struct maple_big_node b_node;
@@ -4206,27 +4206,42 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end = mas_wr_new_end(wr_mas);
 
-	wr_mas->content = mas_start(mas);
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
+	switch (mas->store_type) {
+	case wr_invalid:
+		MT_BUG_ON(mas->tree, 1);
+		return NULL;
+	case wr_new_root:
+		mas_new_root(mas, wr_mas->entry);
+		break;
+	case wr_store_root:
 		mas_store_root(mas, wr_mas->entry);
-		return wr_mas->content;
-	}
-
-	if (unlikely(!mas_wr_walk(wr_mas))) {
+		break;
+	case wr_exact_fit:
+		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
+		if (!!wr_mas->entry ^ !!wr_mas->content)
+			mas_update_gap(mas);
+		break;
+	case wr_append:
+		mas_wr_append(wr_mas, new_end);
+		break;
+	case wr_slot_store:
+		mas_wr_slot_store(wr_mas);
+		break;
+	case wr_node_store:
+		mas_wr_node_store(wr_mas, new_end);
+		break;
+	case wr_spanning_store:
 		mas_wr_spanning_store(wr_mas);
-		return wr_mas->content;
-	}
-
-	/* At this point, we are at the leaf node that needs to be altered. */
-	mas_wr_end_piv(wr_mas);
-	/* New root for a single pointer */
-	if (unlikely(!mas->index && mas->last == ULONG_MAX)) {
-		mas_new_root(mas, wr_mas->entry);
-		return wr_mas->content;
+		break;
+	case wr_split_store:
+	case wr_rebalance:
+	case wr_bnode:
+		mas_wr_bnode(wr_mas);
+		break;
 	}
 
-	mas_wr_modify(wr_mas);
 	return wr_mas->content;
 }
 
@@ -5590,7 +5605,8 @@ void *mas_store(struct ma_state *mas, void *entry)
 	 * want to examine what happens if a single store operation was to
 	 * overwrite multiple entries within a self-balancing B-Tree.
 	 */
-	mas_wr_store_setup(&wr_mas);
+	mas_wr_prealloc_setup(&wr_mas);
+	mas_wr_store_type(&wr_mas);
 	mas_wr_store_entry(&wr_mas);
 	return wr_mas.content;
 }
@@ -5639,7 +5655,8 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	mas_wr_store_setup(&wr_mas);
+	mas_wr_prealloc_setup(&wr_mas);
+	mas_wr_store_type(&wr_mas);
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
-- 
2.45.2


