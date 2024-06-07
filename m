Return-Path: <linux-kernel+bounces-206618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4E7900C16
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86B9B232B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EE114386F;
	Fri,  7 Jun 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HV8ItSYX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TZN2tP7W"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3E14EC4E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786429; cv=fail; b=Av/pibW5UdE65IudoGZJera+IgVo0s0NnWJc9HDd5/hSLUXBgnw0YF4DVXJiTHsSxkCxNzTEfea4xBjJiWd9hl468IPGcaVdnqG1aJBgiyQ5mLD3+rhU4po4EitO2Z4ilcgqtBwxPxQVCtMxq9WNTv3TTO3JHWBQLp45LGBtSSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786429; c=relaxed/simple;
	bh=shKverN4FLpINQZphrUPwi4h5crJY2ltltVhRR3fWFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXoUCesJ6axoHrGKghbv17qVj6t1/rTtN0G9Kd6WmPGl5PY9/IVc6PWvJQvVm8p+xRSuh7nD5oqnibK8AEt9ENeoIn6vSbvAv0Pw6NQMJeOQoOc+y93WF6RUa4vVV1UudhWI0ub8x7eeNTdwlf+Jq5quzSOvVQ0fCOd54Dm3IbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HV8ItSYX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TZN2tP7W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cup2Z021557;
	Fri, 7 Jun 2024 18:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=Y1M65IP1BASKGfJCkUXjq9SAHT6vlTg5aLtT5kQiY8k=;
 b=HV8ItSYX1CsD29a74PaiN6WWHOHfktWkwivG3ptmkhvpNWKwSa5eSN7GhkG6DZbMGRQG
 Gudczw3BvpKjr6jI3aZolgIqYWWogCdFE3eB9n7TynbPGLR7tmnGbyxWLUBvjg+yCUv7
 B1RZ3eN+UAs0C7j6v8/OERBwEsVewjtWZjEq9/vM5Hq52qRXmzEskLhqxpknQ/KRKKA7
 Z717aJff5KmxraHCAcXTVX/gJ4Kx7UvEMgFACPz0BZWxOR4npZMQGUOMEreqnhN2hi+i
 3pFAzzWO4fhSeJcGJGWIEREpmjj//wBZUNzVqGM+F2uu9EXqHQ5J+92loGx5Ql9gr7k4 aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhea3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457ICR4D023938;
	Fri, 7 Jun 2024 18:53:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2k7tv-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heNk/O28P1uBf9zXkPFaquniW6CZY2gCQ8Ek6hqD6OyG75ezpe/kpYJsz5oUiRvzPu5fttm9Thkh2es+qgep0zyvzK9NSOg5K7JXPInL3ivCMu4H1G04/3p5j3cbtroHxV05ahD2z/WH4RaQoYP5ssu31BsJcM6eqENVm+Rxm/XeWAyTQ5E+z2Rgc3gAyGoceOUsBdCnRCwojW4XwPDF9rg66oCDS9k/l7IC0/kR+hA+5/iW2HIzSqKzgRyLUjS6DeE8qLs6hgMFqtI/NJ2n3/7oAEgYvH6rFEYWaAWqfga6PqU7hHO/pJxQIdtT3Y46HB4Svlq36erax06/GP9vIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1M65IP1BASKGfJCkUXjq9SAHT6vlTg5aLtT5kQiY8k=;
 b=high2Cmsq7P4pOxaFERzstwtmAhnnWUlkWKjwIXRBaowelyHC20kg4UYzgrQc4x8W6LYxvaK595lObaK2b2q6l12nEao5rOYXEo7sZ8wVU66SepzrYWpGZ52OkOmFtxEH/ZXBu54JKgzx9gIiHZy2KN7fBCi0dbKc8to4WOQmaGyHNQA1iGTWXFRYhyhSiuEDn9B/5z2oPRLggzQ8a8Ll3SFIDdpG+PrR4phgzdff+pX87RlXFZnLjVUS7ZQRAMvBO736vbT76OxBysjvhLklDSkYmkkbceghw43EpnHUz/v/ELSFMZLDRmvu4CjzKn5o4NIq7IWN3pzIqatcFwXWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1M65IP1BASKGfJCkUXjq9SAHT6vlTg5aLtT5kQiY8k=;
 b=TZN2tP7W0g9NYZJ8baVELdDf2LVSZ2Gbc7WueqMYRNzhlYJXpZXUzcDiJqbCXgmj5PlERT5plMfIxL/kfeD9pSy4KwDEX5ENE9Uf+5bFl16+U5vnlLMHDYUp9qMkuchGnXmYKcJXTP+meROUK9RXfqtlB/dlMMqYff1TeZlD6xM=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Fri, 7 Jun
 2024 18:53:17 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:17 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 06/16] maple_tree: use mas_store_gfp() in mas_erase()
Date: Fri,  7 Jun 2024 11:52:47 -0700
Message-ID: <20240607185257.963768-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e4e354-690c-45fb-57fd-08dc872317da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HE3tENAAmn1+qEkwRNB6Js10OMc5GmQO65xfQ5xjmC1mBt/MleQwWsxKMKau?=
 =?us-ascii?Q?0tEt9ITHOzv9guIQkDkh9iHNesTVNcO+zbxugCESQlXPZl5Lw4Kbn5Vyoli1?=
 =?us-ascii?Q?hhjsWES4PPcyBuu0s5+qgBP9/cWN4UJtTcmExPUcLTcxiRFdWuAa4GM4u4x5?=
 =?us-ascii?Q?2QpVUdNlxiq5DelmlQjkU5cKW2iL1OsuxZu/QJWpT9srgcbz2Lb3gqTg6rvQ?=
 =?us-ascii?Q?PiqVsc5TkmKkFmtKACREz0a47r/dfQVIWWJWZaEjxELqtBKO/ieAoDXHjiZ7?=
 =?us-ascii?Q?XYOtixghzEyEslhd76yIPT1XKwA38EhE6ZXDPe5Mmzrudkw7R5mHDddqbgSK?=
 =?us-ascii?Q?idH3KHpGWbjJUZAKLNtWmv1p3Z/SMyvsm9uDAr6V78HMGQaSNf6eE6lqeql+?=
 =?us-ascii?Q?D9OTWeYcx5zw9y8Wl31szHDYQAdTcBxg2DtoPOJF5u5dQrU/zfJSWwN1HiqO?=
 =?us-ascii?Q?ig1rBZrspY6w0tzkYH5rwtx1dQRvuK1Zp6DEyWx46x/aRn1R57tDv76VAyke?=
 =?us-ascii?Q?uZPSlbciYa0R8WaGRvtHpiCQ6erkDPFFhn7ukhqODO76m4G8wg48TRvZ9NZa?=
 =?us-ascii?Q?VItK65k/zgVxXaRnJzJiURBNKeRfAMaBr26Y0vgpBB/1pt/TBDVr5nHsZe8o?=
 =?us-ascii?Q?dFkjLPf+97yyFq9DG0QblnaFFrOtOMR6u4WUHQILTKjodDZj4zSaqM/VizEN?=
 =?us-ascii?Q?BJZ7+T7EX8EdNZBWpiy+lXcNVLFk+t/EMhZsKttN2rhEe5gRdt/ypNz09gUE?=
 =?us-ascii?Q?hGtXpAgBVNE2dDxjGqrw+wbpW/2rCfyjlQFKXd4ZhFv5FaRvllk1cEe4Lkwe?=
 =?us-ascii?Q?1l25HPKwATNh6rkvhpXuUkx4dta5WuEDF5o1ksiRe40mcmAMQHMlSrUjcdje?=
 =?us-ascii?Q?A/8x87mkgwkNYQyKonS8f0JkLN7fVve/odNX3WPyOTKyE3h6g9uC87n+XquI?=
 =?us-ascii?Q?uyeInKrtcUgF9MHwS0bKlM9cQrZcgYKXDAV7bpWCfjN8FfCh5hoOlOCp9M7p?=
 =?us-ascii?Q?RVVBCZ8SEPGp80GpJF5lgS+abAMcpK+KIFeHjnxa3hEhuecGZwSQQpc6j07g?=
 =?us-ascii?Q?xK2afhaHTzZzxnDXyDfO8FZSjggDP4wL84wSZomNIkp+6aTotKynAnhBeIOJ?=
 =?us-ascii?Q?B9QFAmPOzSSAsvdsznng8e73VSPMCiNm3wXKU7kXyGZ898HjaiQ4dvFFgTCr?=
 =?us-ascii?Q?HMjm9oogvo42sc5p/QCQwKTuLam2XQZAbe2tsSWzW9i6r51vRFzh4LKtWf8b?=
 =?us-ascii?Q?k8xcVTHn7645PKFH410KogrvdfIg4noIj6BRSsIeGCKyXNISNJUC7F4o17H0?=
 =?us-ascii?Q?IFzpgppuLn3qDicMB3cqrOJx?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4Q/WtvBt25+8sYOL+1kU2xfvBTuHIgZEEry+5QRhQAoXs+6xW46xamjMnEtX?=
 =?us-ascii?Q?ragCTBjXtx61Aj4f+iX89Q/WNloXHIiiLL2skjswLsbxeTfaHfQ/v0CD1fw9?=
 =?us-ascii?Q?Z16JYNN0zM4vW9vtWc4wlEi15e+qjWDWcFya7zBk/0/WKI6q2eMCNuz/7x1S?=
 =?us-ascii?Q?V7UZK0NPLLpxuzVficVq/YmEoUU2NIHInU+jzZ0gF81/0T4B1tdMNBDMBAmh?=
 =?us-ascii?Q?EB/tVeXv28dQZrpdgrOJxauL5fm7kKlMA5qWdFmxOQmjUsqLl3+QdEkMyl1/?=
 =?us-ascii?Q?p++ZV6GjkDRM7PsDYBCeh4Tc7tABktkJggXEv0bJ0pzIkh4ZtS1a166baaCv?=
 =?us-ascii?Q?8Ip2wBKljxiOZCFXlL0njgq8gyciefDbolkd7Fsse87IaZrQRFkras2LSwKj?=
 =?us-ascii?Q?gQllyyuPpMuCquaOInDY/GEflcUjoOOhoqcZKMM15ONo5+xjGycWHmZEilr5?=
 =?us-ascii?Q?4vQuqh9l5eqmTYYjY2isnlaiSL5tEeWrUZpsGTUz5gGgSouXYA8aQE2hQ8hf?=
 =?us-ascii?Q?2tn+tgwCAsjpsvTY7GpiY9WDvuYPwemCOFRCqNHaUR0pgiZ2dKfWmos8FnnB?=
 =?us-ascii?Q?0ulQxqeDzG7NV+BHHMmSHo9L2YJQheLbAIAMHekeeMIRrQEig1INt4uXOgmF?=
 =?us-ascii?Q?k2MiCGMvr2lE7+56NdBKV8tfYxSPZTibOUmyJ4xIoJG0hebVcEUdjkOZrkd+?=
 =?us-ascii?Q?G4/rbzKu+H65la+Z2NEIi5PzJNvpaoVwGfp8is2ObVsvU6aoIqGBCKAtpoQe?=
 =?us-ascii?Q?TeRqDrwPVprbuoJVn6iAMS2kgJO3Qgs/l82ZGvg6wCIptr1aX4K7z1e1jYdv?=
 =?us-ascii?Q?3lcOJo0yuYDEkInJInO5i6qMgPVyFnKf5yQt/P2xb0viCN6sXPN+w6acyswS?=
 =?us-ascii?Q?1K3BUszOAnXaJlO+Qv2I9ZpHwvSIBMX58Je7hsF/RGEG7VkBPn5yGYtmO1ZL?=
 =?us-ascii?Q?vPLk2TfzL2rjSwKfcCheJv0AGHZ+W0t/84WjInnFYXZdLmEvN9jaqTaPsQBS?=
 =?us-ascii?Q?shu42vvG4f5/hOmZ7yiDEe7ZY+2yS5mdzQb33xCQr7IIPVj07Xog9qhlLr1v?=
 =?us-ascii?Q?RpAzn1bYRwfPsmJPkwl2hqSJ4Lrldp/NAWxSJeH6qu0YzgEw2iueLNxgGob9?=
 =?us-ascii?Q?Gaz1IfVqC1to0H0b7eGuy0wAe49wgjOMmX2B9uU/1hKlZibuEi1PLhTNnk2x?=
 =?us-ascii?Q?5f+gNTlYWoMBlX3MOL4Ea1cPx149Xt0t0HHbUMnVQOu59MEJc1jDK5BCFR/E?=
 =?us-ascii?Q?YQFumOsioATixxQfKyP6RRzd5bbptvFAFVUjzG2UFYnWSFJn+M8tzkzjzlPd?=
 =?us-ascii?Q?k06zAi7GeI87Hs4VX9hi1TIbVNl9ewjT2rfS8qPHSKbyyKh5mz0ht+z0+grF?=
 =?us-ascii?Q?oOGOBd0FZsvACPRaR9L0vl2J7NrJJIapBP90VCd5qQjH2/wUHh5c7B4JAoDW?=
 =?us-ascii?Q?7E9mLjVj0JSlqU8WwaAIPUBoLd3ra3JfUwhRnEXU54/gJ+suRfteJsg6ZIY9?=
 =?us-ascii?Q?SmMaUYZegCwUUKDBHgClVFLOMM4xpX/KXim/tBw+a4pXf6hMtz9gtbB8WX8V?=
 =?us-ascii?Q?UTF20iGPpoAdfYIrOVI7uZxOHyC2b8u/QZ+V/ZzXJSXg3+vNfJHG7yOV+kTE?=
 =?us-ascii?Q?LkAzPUzzPWw3q4GZHA0I3mI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SupnHJN8XovT8aevg6CtORIVq6UI8BGrWOogkb+gI3mYDi/L63oiEn5bTYJcZIjfZLnEnQOFlfKk0UMQJEiz4uh/HNjYq63SCRGYBDCzzUQe6O6bt1LuspXxe3fDjjhs1+v9gCX+mvPGDBU1T9oLeHpDngyeZR2UVJPb/5fJnzxOn1Bs7tXPTvwcTTnQ4T6shs2KSvRfvDjA6TatQTcPbGVrCkTXeJ6ESnFSach6jlO0+L0Undh0wt9IqIuGRSMR9iM/ibgfu4uLPobUQ2DMTeDuaNzTx2w8MiwYH1R4CsO80AigzzyIy/g0pUhkQPjivDKSk/2DB9AK/oFOZ8hgOupyB4r9nNXo1OCgik8Z987EutgDYR+L2lGWyWaJNWhPcZnR4T0OuENKi+iFFUNkav8mHqiqxGsP9N+90CC8wVGqqgQQAbF+l61gw+ouqSQ0+sHdC1DxWwOHSWZ0crx8atg+CMAI7XBPGmZPqyeRUnx0eLLHbQj6BESjAVt948/KKqomQVvLV8a/d4fW7ANvqCkfkKW2wtc9UXsRo4PRtkI61VeizJ42Ic8YvGsjU8KQ4xuSD7d2WPF8i9GB337eWNK+RspQFuL4Q7jptDyiuMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e4e354-690c-45fb-57fd-08dc872317da
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:17.4782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWAqyV7sJesNhJ3cfhylTLCj6S3OjfWr7RAX2mujhppD52m8iEuXQCf7rbyeBAQIdDVGV0ckQerVAvKjf+hF31KCafg1yYroUStObMajZe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070138
X-Proofpoint-GUID: mbuKiPBfaMo9MmfXx1yh6M2n3yqskt_u
X-Proofpoint-ORIG-GUID: mbuKiPBfaMo9MmfXx1yh6M2n3yqskt_u

Refactor mas_erase() to simply call mas_store_gfp() which will abstract
storing the null, memory allocation, and error handling.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b933df290887..bf309b7515e7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6355,7 +6355,6 @@ EXPORT_SYMBOL_GPL(mas_find_range_rev);
 void *mas_erase(struct ma_state *mas)
 {
 	void *entry;
-	MA_WR_STATE(wr_mas, mas, NULL);
 
 	if (!mas_is_active(mas) || !mas_is_start(mas))
 		mas->status = ma_start;
@@ -6365,15 +6364,9 @@ void *mas_erase(struct ma_state *mas)
 	if (!entry)
 		return NULL;
 
-write_retry:
 	/* Must reset to ensure spanning writes of last slot are detected */
 	mas_reset(mas);
-	mas_wr_store_setup(&wr_mas);
-	mas_wr_store_entry(&wr_mas);
-	if (mas_nomem(mas, GFP_KERNEL))
-		goto write_retry;
-
-	mas_destroy(mas);
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
 	return entry;
 }
 EXPORT_SYMBOL_GPL(mas_erase);
-- 
2.45.2


