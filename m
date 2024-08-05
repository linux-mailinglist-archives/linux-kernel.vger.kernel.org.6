Return-Path: <linux-kernel+bounces-274638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBEE947AF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF286B21DD9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91AA1581E3;
	Mon,  5 Aug 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PtIBKqZ/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MFfCRyud"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DBF158DAA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860117; cv=fail; b=U5Nd4LEI6LX/2cgYUWlCwMgEExfZtPPlgn6E8eLTy2IVzL3HUc7+bVz7CZUHvVjWwJi9SQ/BtuSgvJ2yFGR3MQdmdvpm3Dxeay8gl3a6uakcid4SXBCtswKVISwOUFVZuA3Zae2fHHZ04TXvHJY0sGHbPzZlAH251f/Dqm7nqyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860117; c=relaxed/simple;
	bh=aMdmemi5PdaaulJe0FtJNFqQGkGGNFuEIzFLz4rsbpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dtOzlweMY37NEpGdz1AtSVfPkyS+NpjajZxHxnSTwUOoW2CBesx28ogOWEdvtUDzIQBuMOukr2w4Gg8FO2s1IQCU4m4spqREXBONXXq5WLws0NISrcgkQRVP/7wWQWpzl7sk5nM8cFEomAm00aJcEljU+zwJCGh38sc2Y/FEKpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PtIBKqZ/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MFfCRyud; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fYEb026939;
	Mon, 5 Aug 2024 12:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=bYQk9Vtsd4JlmFKs6P23Vuo5xBwRpp8167VysTqmo+s=; b=
	PtIBKqZ/xS1xi8J85gOg91FPgFHwE/k6MVHCN9Y16lnxS+Qxe6y6/S6fo2uE6oN1
	DhzZyNBXQm9fRMTbRaS47CV3NSFSOdWiectshvEptG6CgLZ/NuMWAzngnnU1OHlG
	Jt3QBUHhm6XW5qLa/9GT/f9uqOLc9uEqjqreoJRBLBHsMZt7wXrgPFIcBkeFdbsj
	MhUyd7/59uXrUpE+gPcqhbypqx7EkXe8iIRnVrL2HxAk/BLjlbPzOiLl4URUkWw3
	Zy3yUvipJMvLTNYWBxGeBSZWtQcFPPjgV+7gUkufj9oggohyWXIduntmneJY1Q5G
	hItElSr9wXEyuQRDzovy8w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51ag9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:15:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475BoM08017725;
	Mon, 5 Aug 2024 12:14:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb076pj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjZPLTquSkJXo8N84EyMqkfD+2yYasWkNHTGFzAG3jz5f2NmNHkdhrstvkFf6Y/2Fu2i4DFQixyXZYyN5Yunm5I/id/XYj5DBUI2MmQhDlrshcxKbcDNaMaowt7qfZDhErKZAgEASNhX2QOkYMfqDP6p/v22PH+YV3mBs5JGaDih0P8OwPQoVuFbL9ZKQmjKZKHcoNNjWLEVJWi9ksZhF7qK9QPrPslxL2HnQXfkv1z4pa+/y6CW32xrwwH1b8NMo0IBPUCNhpq6yGf4llP+rBPrwXqzYcg6WXV3RngxFMj3mtxVL46Oj+lqLncZuyASQ+2GUztDhJqIM8AbIIYdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYQk9Vtsd4JlmFKs6P23Vuo5xBwRpp8167VysTqmo+s=;
 b=DjFEjl57f4kRCaY1osoP1vdFgg7VBZAac2vVY8cH5SLC6nQarZiQOtDG8Xcbzy/kVoVgVU1/8X6Q1ctSPuXgA2p/krh7saT94antneTaB1lFa1lxxOp+jEQlmaDIytT9aOUqPGt04uK1ISBwzhK373qeBy7JpWNteTiW8YuitDVqVgM4fSHFRQobylFaSH365fFVTDp7sJh94ulYI6urovpABSqZsGewylTojQjr3GEiVI+q/5K/XTXPCTKRxtxLU1M96/jxG+qlyc9rza5rqdomHp5mjWtckxBf5hk3dv9xhHz37b5SFB09yDO9iKufveJ3StJWwYKYnP9S4WsCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYQk9Vtsd4JlmFKs6P23Vuo5xBwRpp8167VysTqmo+s=;
 b=MFfCRyud9V+/tC0On26dOmK2+lHLbXDky8dvuHb4txYB7m8KQw9Q7QYgSrFviiyfCZ6vDfyIM5n7U/ALey64i2ncsUh2vG8G95UTLw/cRQF7pLaRXZt4TBsoE3Iq2pzSgt4BvTFK3Tk8S04s/OO6G1MSeXn/HGNaf5h+u3TA77E=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:14:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 09/10] mm: refactor vma_merge() into modify-only vma_merge_modified()
Date: Mon,  5 Aug 2024 13:13:56 +0100
Message-ID: <5ffdf3241d10bfe96371947a27f596bf21761af8.1722849860.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0600.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 73df79f8-7fb8-4e56-0bbe-08dcb5483229
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pjWnMBstPse+L/mJadyGx52HKDAaY6vPjZAdwtSz1G8nT0fioNmonhddsU5L?=
 =?us-ascii?Q?/HMYmcm2SztBte4s4H1AEQnAdPJWv0Q2LyWt/HRPhu71gOlfLRoug9Fgz8nz?=
 =?us-ascii?Q?Ja4Vi5NKupP45SxTeQtoDzEfXXM4dkq6CF4qcCRhuS9dse1jhJsRc4bwzQVz?=
 =?us-ascii?Q?3INCE0Gkj5PnmNgYMhudFmeRTEaOsUaRjlbZEv0URkZEX1yZ9L1RIaX+BWz4?=
 =?us-ascii?Q?rL3scqCnzEH+a4DRGpHCMigkT6hGAKgg3ut0Mao5ygZjaxDJltEsF2WmjeVS?=
 =?us-ascii?Q?rq/bI5U4ecPvsKIGXB97gcAff6Zsa2WqB84FZCwdOgwRdOgjLGBTcpzqQ3v9?=
 =?us-ascii?Q?3xwJFw+WyVjHBNslWxHx7Pt4/Wg7rOHLqqbFr40XzpSSueND0Vw8176H7fIz?=
 =?us-ascii?Q?lsh1vsUD9syfq9GR24B5x2WLBiehHqpE2rPN7iddOVB0ulVyIH5IjFk//eEv?=
 =?us-ascii?Q?NewvG+OWVV1tEt5ktxmULrHR+9gGkMaxgkTl5H6MPXQPcjJkFsclAxXbu+mQ?=
 =?us-ascii?Q?p64W49iJbGQZ6CdN9uu6Ty6oq/xxYBGzGuTenH6tstaRwvGTI673NRWZrBaa?=
 =?us-ascii?Q?L0+drJ/5WvC4x7mtJsg4ASyu87MgEZ/HINIauImKC4Am6nsTZmxgMWzcLjWj?=
 =?us-ascii?Q?EDTG+hu4Q1Z01rjCXYX+Lm+RfAdlchbyJlvx14B+sIrHRmsWStVc+cGDvlOk?=
 =?us-ascii?Q?AjaMSDtFpLz/pqRzyeC8zqZ9fotIvNALE+eoJ2bT9gDir7Uabc6X/ebaJ7lC?=
 =?us-ascii?Q?ITFdKQ/R/YDL7vEp1djSBdez76Ku+30FMkAYs9TasTkAFX52ogVCUd+t/lKT?=
 =?us-ascii?Q?i9OL/2584/mK5bI1x0B8PvkInVHHN1Ta8HmnOymV/pbEmAr/s5HFenyofuSO?=
 =?us-ascii?Q?5eNy2L2DOzMNEOTNJg13jwPu8q0btu6dw9R5SxJKmyatXo7VWkcAVU9rEcXc?=
 =?us-ascii?Q?TMdRo0B6isauWBBBsUAR52IjkxVU872A8L1jZYilI1yeOackeJSUO/S5wNVu?=
 =?us-ascii?Q?6wOpyx8UATuFU9dEs4Y1JwOiu99hqssYkPjMNZO/5uvj275K2tT1YT9nrpmM?=
 =?us-ascii?Q?t3+Kt9pAs1Hm79M81TZkeWI57lNK85QHTcRFyrap+kuUd6woNss3JrkkbCrM?=
 =?us-ascii?Q?+BWFN8v7Ojb19g6Ej7G7m30u7lm6lf5HnHKQM61PSksZK4u1tSAeENHUXNFX?=
 =?us-ascii?Q?7iVuqHKwmCGSvJe6UCmww968J/z+VtMR9ltIr0Cgp3YNVDN/ttgjMvGver/w?=
 =?us-ascii?Q?OsxO/MWL8EW6URtfi3jbfF7LHMw1gyAH0lp6sXcD7F5lS5mJDChD2guz06W6?=
 =?us-ascii?Q?IkgYqMG8o8lHnlrYdzKzUiXf3McH7jcvHz5kWsF+2CI62A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lZNISII5nIqo8KGcACaRhlFrbqi5noYj+wy7dhOAy4kpglV6EjShvSvSGMU3?=
 =?us-ascii?Q?oKaE4O+t6jvYilsqIJGKX9DL9Jhv0/nUTRyFW+Upw0DvBOdJESTYTw8tue67?=
 =?us-ascii?Q?Ilo1PKszTD1zeZfGW5Kir9IcMNyi453i+OEMcwehLFkX/AyOWof4vxg2ic6w?=
 =?us-ascii?Q?7QLIM+0JlLRIdNnMDfqitezt+xNtC42+xyYtLY83BxLn6s7dkROgpEkfA8Na?=
 =?us-ascii?Q?jAmgEVv82/QtQJq4PZfwPbZOsIdrB6dIthewh3HjbykFa+hLpVHJYnNSpt8z?=
 =?us-ascii?Q?DubzuxszX4Mxa0WNyI6BUl3Q18e1N9hxhdbl8lyBpEbcPcjANZEkGog652IJ?=
 =?us-ascii?Q?s2t0wS7Hg+iqbVLJyeS0WpFJTzo4wwMMdh1sXE2w9hlbAO7cLnumJpMwHsWu?=
 =?us-ascii?Q?PUDsRwfremJnfzaifnU04DHX27g0l/Me+BFSmtrXDOXLwB6Pdv+x5+5yqR6E?=
 =?us-ascii?Q?kiG7nrtPEeeYa5RvBeTm7mzC18InMhVbdIjbCBL4zLMOoekY+1pqQPl4arwX?=
 =?us-ascii?Q?iYK1ADZacXbG/L4Laeda0SCJRPGck7BmODh1uQ2rDSOM4BWypDSiqhl2t8XD?=
 =?us-ascii?Q?WTtnw12PEImznMVCKSvGfEA8cMRac99IEz/HNzwvY+yHvui9kBD6jDFmb7H+?=
 =?us-ascii?Q?fKOj3ejKtmI5MQEzfXuyLKajwzb6gjnpEKINm7Hp2aGg9kxVXu+HhhuSV3GS?=
 =?us-ascii?Q?4v87WwuKjYIuUjfcz1GM1rvtybj2lR1pqMjoEIa/vcPtXTJ01l1ukFZjbIMi?=
 =?us-ascii?Q?HA3jNJUwiovn3J8pcjYS73ngcn2ysNQzWhaHc/ropb/Qw7cHp4GGAMtL5aq+?=
 =?us-ascii?Q?+Anw3A26x5JCstbG0E1pm0/qMAN+cHzBaawvIKOGdi+bXfbZYN6ki2wLUtAc?=
 =?us-ascii?Q?+/eywY4rmLdEiS8DnmdDMd9TlKW9pgMLbvp0Soqixw7rcn7bN4OhmOsRYllF?=
 =?us-ascii?Q?UYnyU7w+fuYGN3QiQ4MuKuHFZ/DC8Mb6WEXSODgyholgXqpIqyqIpa2qEvf2?=
 =?us-ascii?Q?JopKpTKBjlF0fiZqtmAYG4Y+VAhtqWMPKiJZMuwtyxpl8E5LFlIiGyyTy8cl?=
 =?us-ascii?Q?gUm4+5BLC89PJy9m0HLk0xktJ11bgQcZjXEjMEjfC1mqIIoAysbk19aGyFzx?=
 =?us-ascii?Q?ccuTa5V5cgNknNp2R65DMgQhjd1J/nyJ9QU/dQS5xUJXzxSWrxM6hkhRE8Ob?=
 =?us-ascii?Q?+0eTKw3elEj5sNO4+JTrUBt8vYksamSRkFD7toN0JyJqhX8DXPjHv2UZaAFY?=
 =?us-ascii?Q?i+9+U/NbyV/NTLlIeYLXZ+2l9PJZCMq65HskzwwPdQwdAcw3Tsr60J78icht?=
 =?us-ascii?Q?I0C+ihb/WIDpUddLP7ZNn28+YLV+4kzYOyjVmK1HZ93v8dZedhVXYx7JE6aA?=
 =?us-ascii?Q?/S8Vu5YNNAOVc4aTz8txVW23ck4Jus6kWG3vxZ8xFAZPTcEdd84cY9VJiPLF?=
 =?us-ascii?Q?sU5iw56s1w47ftqycii3YY4HmRiw8ih/vSYnPa0WRWpJ3VDbhdyTbTP48BQF?=
 =?us-ascii?Q?WYlZTdbBKhAz5sToM4HEN36yd2GviG8hlhqDtTAR64VaFmgMiTu3oikEy7EM?=
 =?us-ascii?Q?pJ9tlGYslOCD8ZD1Dpltgr0ze120FIONhXy2TKL7JlD/QCz1JqF+ujCMvcSo?=
 =?us-ascii?Q?6zc1bPW/MdwGDcmQ1JImiyAIGctZynFPPjwioNpYg7iELI/Q3JZeEphTs4VF?=
 =?us-ascii?Q?pUc9CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NI0Lu9fqlqJY6lacojjYKuUzG+jxwQIOcA4fVvEBjH0T3NHgGd6P9RCJtF0aKeG9NLIP18KdEjrZczYAw9fUEueTiRN1JyIDjMhUVzR/43YneaB87VkzL0mDK3iDLHjx596XI3L5++moe3B7nfCysYm/10GnrFgsWv9EU4adom5U9F3fprUXZqXdFbJUEIPW1TJ04hcelFQMhu/WD9H9vsBgf24Nc/eQW/gnJkj/C6FS1sGCy/VHEpm80uYorhA/221C6+vOJeLXmdm6RMOr23VhKBLSAlCWKcyCc6ISDSAtY5s0zpXTnvXcuZKSOQQkhds79cSmOKsZ1e+Xp4zLDnMdgY6aSFW1eWM47M7b/Jc0bjLws0+yG/46g3we0hccnixPKo3IwrGHsARg8TGZ7Co/p9IVKmnXmpOqI92EjpjmICA9FKe63UHlUlBMqFYTZN8ERyWmj78vSu1va1A/TGPqs0r2NPsWybUHp44CiU2yoObV7RJyNtCHhYE+DIkTLFcbacufcss1qGmRriT1miwZ1vYZ/YCLIvH1nOU03EexDC3Rlj22xtWccR6iPmZeks+Yr37ms0QCH2uXCfCeUeS2B28BWykgwzD5FDYSqvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73df79f8-7fb8-4e56-0bbe-08dcb5483229
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:46.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZE/L7am17eCbbvvJ5FfuUCBlMHo7aXFSsDS+FLxTFrTl6U2EBFpz3nTgCsqhoYpUdtK5dyu3k1UG3j5wmfTTVF91V3uoR8Tz9gINmpERWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050088
X-Proofpoint-ORIG-GUID: Aafz0hpcomZzDra5sFRwca5gTmBRfl30
X-Proofpoint-GUID: Aafz0hpcomZzDra5sFRwca5gTmBRfl30

The existing vma_merge() function is no longer required to handle what were
previously referred to as cases 1-3 (i.e. the merging of a new VMA), as
this is now handled by vma_merge_new_vma().

Additionally, we simplify the convoluted control flow of the original,
maintaining identical logic only expressed more clearly and doing away with
a complicated set of cases, rather logically examining each possible
outcome - merging of both the previous and subsequent VMA, merging of the
previous VMA and merging of the subsequent VMA alone.

We now utilise the previously implemented commit_merge() function to share
logic with vma_expand() deduplicating code and providing less surface area
for bugs and confusion.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 474 +++++++++++++++++++++++++++----------------------------
 mm/vma.h |   6 -
 2 files changed, 232 insertions(+), 248 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index b7e3c64d5d68..c55ae035f5d6 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -569,8 +569,7 @@ static int commit_merge(struct vma_merge_struct *vmg,
 			struct vm_area_struct *adjust,
 			struct vm_area_struct *remove,
 			struct vm_area_struct *remove2,
-			long adj_start,
-			bool expanded)
+			long adj_start, bool expanded)
 {
 	struct vma_prepare vp;
 
@@ -607,6 +606,236 @@ static int commit_merge(struct vma_merge_struct *vmg,
 	return 0;
 }
 
+/*
+ * vma_merge_modified - Attempt to merge VMAs based on a VMA having its
+ * attributes modified.
+ *
+ * @vmg: Describes the modifications being made to a VMA and associated
+ *       metadata.
+ *
+ * When the attributes of a range within a VMA change, then it might be possible
+ * for immediately adjacent VMAs to be merged into that VMA due to having
+ * identical properties.
+ *
+ * This function checks for the existence of any such mergeable VMAs and updates
+ * the maple tree describing the @vmg->vma->vm_mm address space to account for
+ * this, as well as any VMAs shrunk/expanded/deleted as a result of this merge.
+ *
+ * As part of this operation, if a merge occurs, the @vmg object will have its
+ * vma, start, end, and pgoff fields modified to execute the merge. Subsequent
+ * calls to this function should reset these fields.
+ *
+ * Returns: The merged VMA if merge succeeds, or NULL otherwise.
+ *
+ * ASSUMPTIONS:
+ * - The caller must assign the VMA to be modifed to vmg->vma.
+ * - The caller must have set vmg->prev to the previous VMA, if there is one.
+ * - The caller does not need to set vmg->next, as we determine this.
+ * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
+ */
+static struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
+{
+	struct vm_area_struct *vma = vmg->vma;
+	struct vm_area_struct *prev = vmg->prev;
+	struct vm_area_struct *next, *res;
+	struct vm_area_struct *anon_dup = NULL;
+	struct vm_area_struct *adjust = NULL;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
+	bool left_side = vma && start == vma->vm_start;
+	bool right_side = vma && end == vma->vm_end;
+	bool merge_will_delete_vma, merge_will_delete_next;
+	bool merge_left, merge_right;
+	bool merge_both = false;
+	int err = 0;
+	long adj_start = 0;
+
+	VM_WARN_ON(!vma); /* We are modifying a VMA, so caller must specify. */
+	VM_WARN_ON(vmg->next); /* We set this. */
+	VM_WARN_ON(prev && start <= prev->vm_start);
+	VM_WARN_ON(start >= end);
+	/*
+	 * If vma == prev, then we are offset into a VMA. Otherwise, if we are
+	 * not, we must span a portion of the VMA.
+	 */
+	VM_WARN_ON(vma && ((vma != prev && vmg->start != vma->vm_start) ||
+			   vmg->end > vma->vm_end));
+
+	/*
+	 * If a special mapping or neither at the furthermost left or right side
+	 * of the VMA, then we have no chance of merging and should abort.
+	 *
+	 * We later require that vma->vm_flags == vm_flags, so this tests
+	 * vma->vm_flags & VM_SPECIAL, too.
+	 */
+	if (vmg->flags & VM_SPECIAL || (!left_side && !right_side))
+		return NULL;
+
+	if (left_side && prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
+		merge_left = true;
+		vma_prev(vmg->vmi);
+	} else {
+		merge_left = false;
+	}
+
+	if (right_side) {
+		next = vmg->next = vma_lookup(vma->vm_mm, end);
+
+		/*
+		 * We can merge right if there is a subsequent VMA, if it is
+		 * immediately adjacent, and if it is compatible with vma.
+		 */
+		merge_right = next && end == next->vm_start &&
+			can_vma_merge_before(vmg);
+
+		/*
+		 * We can only merge both if the anonymous VMA of the previous
+		 * VMA is compatible with the anonymous VMA of the subsequent
+		 * VMA.
+		 *
+		 * Otherwise, we default to merging only the left.
+		 */
+		if (merge_left && merge_right)
+			merge_right = merge_both =
+				is_mergeable_anon_vma(prev->anon_vma,
+						      next->anon_vma, NULL);
+	} else {
+		merge_right = false;
+		next = NULL;
+	}
+
+	/* If we have nothing to merge, abort. */
+	if (!merge_left && !merge_right)
+		return NULL;
+
+	/* If we span the entire VMA, a merge implies it will be deleted. */
+	merge_will_delete_vma = left_side && right_side;
+	/* If we merge both VMAs, then next is also deleted. */
+	merge_will_delete_next = merge_both;
+
+	/* No matter what happens, we will be adjusting vma. */
+	vma_start_write(vma);
+
+	if (merge_left)
+		vma_start_write(prev);
+
+	if (merge_right)
+		vma_start_write(next);
+
+	if (merge_both) {
+		/*
+		 *         |<----->|
+		 * |-------*********-------|
+		 *   prev     vma     next
+		 *  extend   delete  delete
+		 */
+
+		vmg->vma = prev;
+		vmg->start = prev->vm_start;
+		vmg->end = next->vm_end;
+		vmg->pgoff = prev->vm_pgoff;
+
+		/*
+		 * We already ensured anon_vma compatibility above, so now it's
+		 * simply a case of, if prev has no anon_vma object, which of
+		 * next or vma contains the anon_vma we must duplicate.
+		 */
+		err = dup_anon_vma(prev, next->anon_vma ? next : vma, &anon_dup);
+	} else if (merge_left) {
+		/*
+		 *         |<----->| OR
+		 *         |<--------->|
+		 * |-------*************
+		 *   prev       vma
+		 *  extend shrink/delete
+		 */
+
+		unsigned long end = vmg->end;
+
+		vmg->vma = prev;
+		vmg->start = prev->vm_start;
+		vmg->pgoff = prev->vm_pgoff;
+
+		if (merge_will_delete_vma) {
+			/*
+			 * can_vma_merge_after() assumed we would not be
+			 * removing vma, so it skipped the check for
+			 * vm_ops->close, but we are removing vma.
+			 */
+			if (vma->vm_ops && vma->vm_ops->close)
+				err = -EINVAL;
+		} else {
+			adjust = vma;
+			adj_start = end - vma->vm_start;
+		}
+
+		if (!err)
+			err = dup_anon_vma(prev, vma, &anon_dup);
+	} else { /* merge_right */
+		/*
+		 *     |<----->| OR
+		 * |<--------->|
+		 * *************-------|
+		 *      vma       next
+		 * shrink/delete extend
+		 */
+
+		pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
+
+		VM_WARN_ON(!merge_right);
+		/* If we are offset into a VMA, then prev must be vma. */
+		VM_WARN_ON(vmg->start > vma->vm_start && prev && vma != prev);
+
+		if (merge_will_delete_vma) {
+			vmg->vma = next;
+			vmg->end = next->vm_end;
+			vmg->pgoff = next->vm_pgoff - pglen;
+		} else {
+			/*
+			 * We shrink vma and expand next.
+			 *
+			 * IMPORTANT: This is the ONLY case where the final
+			 * merged VMA is NOT vmg->vma, but rather vmg->next.
+			 */
+
+			vmg->start = vma->vm_start;
+			vmg->end = start;
+			vmg->pgoff = vma->vm_pgoff;
+
+			adjust = next;
+			adj_start = -(vma->vm_end - start);
+		}
+
+		err = dup_anon_vma(next, vma, &anon_dup);
+	}
+
+	if (err)
+		goto abort;
+
+	if (commit_merge(vmg, adjust,
+			 merge_will_delete_vma ? vma : NULL,
+			 merge_will_delete_next ? next : NULL,
+			 adj_start,
+			 /*
+			  * In nearly all cases, we expand vmg->vma. There is
+			  * one exception - merge_right where we partially span
+			  * the VMA. In this case we shrink the end of vmg->vma
+			  * and adjust the start of vmg->next accordingly.
+			  */
+			 !merge_right || merge_will_delete_vma))
+		return NULL;
+
+	res = merge_left ? prev : next;
+	khugepaged_enter_vma(res, vmg->flags);
+
+	return res;
+
+abort:
+	vma_iter_set(vmg->vmi, start);
+	vma_iter_load(vmg->vmi);
+	return NULL;
+}
+
 /*
  * vma_merge_new_vma - Attempt to merge a new VMA into address space
  *
@@ -1022,245 +1251,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
 }
 
-/*
- * Given a mapping request (addr,end,vm_flags,file,pgoff,anon_name),
- * figure out whether that can be merged with its predecessor or its
- * successor.  Or both (it neatly fills a hole).
- *
- * In most cases - when called for mmap, brk or mremap - [addr,end) is
- * certain not to be mapped by the time vma_merge is called; but when
- * called for mprotect, it is certain to be already mapped (either at
- * an offset within prev, or at the start of next), and the flags of
- * this area are about to be changed to vm_flags - and the no-change
- * case has already been eliminated.
- *
- * The following mprotect cases have to be considered, where **** is
- * the area passed down from mprotect_fixup, never extending beyond one
- * vma, PPPP is the previous vma, CCCC is a concurrent vma that starts
- * at the same address as **** and is of the same or larger span, and
- * NNNN the next vma after ****:
- *
- *     ****             ****                   ****
- *    PPPPPPNNNNNN    PPPPPPNNNNNN       PPPPPPCCCCCC
- *    cannot merge    might become       might become
- *                    PPNNNNNNNNNN       PPPPPPPPPPCC
- *    mmap, brk or    case 4 below       case 5 below
- *    mremap move:
- *                        ****               ****
- *                    PPPP    NNNN       PPPPCCCCNNNN
- *                    might become       might become
- *                    PPPPPPPPPPPP 1 or  PPPPPPPPPPPP 6 or
- *                    PPPPPPPPNNNN 2 or  PPPPPPPPNNNN 7 or
- *                    PPPPNNNNNNNN 3     PPPPNNNNNNNN 8
- *
- * It is important for case 8 that the vma CCCC overlapping the
- * region **** is never going to extended over NNNN. Instead NNNN must
- * be extended in region **** and CCCC must be removed. This way in
- * all cases where vma_merge succeeds, the moment vma_merge drops the
- * rmap_locks, the properties of the merged vma will be already
- * correct for the whole merged range. Some of those properties like
- * vm_page_prot/vm_flags may be accessed by rmap_walks and they must
- * be correct for the whole merged range immediately after the
- * rmap_locks are released. Otherwise if NNNN would be removed and
- * CCCC would be extended over the NNNN range, remove_migration_ptes
- * or other rmap walkers (if working on addresses beyond the "end"
- * parameter) may establish ptes with the wrong permissions of CCCC
- * instead of the right permissions of NNNN.
- *
- * In the code below:
- * PPPP is represented by *prev
- * CCCC is represented by *curr or not represented at all (NULL)
- * NNNN is represented by *next or not represented at all (NULL)
- * **** is not represented - it will be merged and the vma containing the
- *      area is returned, or the function will return NULL
- */
-static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
-{
-	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);
-	struct vm_area_struct *prev = vmg->prev;
-	struct vm_area_struct *curr, *next, *res;
-	struct vm_area_struct *vma, *adjust, *remove, *remove2;
-	struct vm_area_struct *anon_dup = NULL;
-	struct vma_prepare vp;
-	pgoff_t vma_pgoff;
-	int err = 0;
-	bool merge_prev = false;
-	bool merge_next = false;
-	bool vma_expanded = false;
-	unsigned long addr = vmg->start;
-	unsigned long end = vmg->end;
-	unsigned long vma_start = addr;
-	unsigned long vma_end = end;
-	pgoff_t pglen = PHYS_PFN(end - addr);
-	long adj_start = 0;
-
-	/*
-	 * We later require that vma->vm_flags == vm_flags,
-	 * so this tests vma->vm_flags & VM_SPECIAL, too.
-	 */
-	if (vmg->flags & VM_SPECIAL)
-		return NULL;
-
-	/* Does the input range span an existing VMA? (cases 5 - 8) */
-	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
-
-	if (!curr ||			/* cases 1 - 4 */
-	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
-		next = vmg->next = vma_lookup(mm, end);
-	else
-		next = vmg->next = NULL;	/* case 5 */
-
-	if (prev) {
-		vma_start = prev->vm_start;
-		vma_pgoff = prev->vm_pgoff;
-
-		/* Can we merge the predecessor? */
-		if (addr == prev->vm_end && can_vma_merge_after(vmg)) {
-			merge_prev = true;
-			vma_prev(vmg->vmi);
-		}
-	}
-
-	/* Can we merge the successor? */
-	if (next && can_vma_merge_before(vmg)) {
-		merge_next = true;
-	}
-
-	/* Verify some invariant that must be enforced by the caller. */
-	VM_WARN_ON(prev && addr <= prev->vm_start);
-	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
-	VM_WARN_ON(addr >= end);
-
-	if (!merge_prev && !merge_next)
-		return NULL; /* Not mergeable. */
-
-	if (merge_prev)
-		vma_start_write(prev);
-
-	res = vma = prev;
-	remove = remove2 = adjust = NULL;
-
-	/* Can we merge both the predecessor and the successor? */
-	if (merge_prev && merge_next &&
-	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
-		vma_start_write(next);
-		remove = next;				/* case 1 */
-		vma_end = next->vm_end;
-		err = dup_anon_vma(prev, next, &anon_dup);
-		if (curr) {				/* case 6 */
-			vma_start_write(curr);
-			remove = curr;
-			remove2 = next;
-			/*
-			 * Note that the dup_anon_vma below cannot overwrite err
-			 * since the first caller would do nothing unless next
-			 * has an anon_vma.
-			 */
-			if (!next->anon_vma)
-				err = dup_anon_vma(prev, curr, &anon_dup);
-		}
-	} else if (merge_prev) {			/* case 2 */
-		if (curr) {
-			vma_start_write(curr);
-			if (end == curr->vm_end) {	/* case 7 */
-				/*
-				 * can_vma_merge_after() assumed we would not be
-				 * removing prev vma, so it skipped the check
-				 * for vm_ops->close, but we are removing curr
-				 */
-				if (curr->vm_ops && curr->vm_ops->close)
-					err = -EINVAL;
-				remove = curr;
-			} else {			/* case 5 */
-				adjust = curr;
-				adj_start = end - curr->vm_start;
-			}
-			if (!err)
-				err = dup_anon_vma(prev, curr, &anon_dup);
-		}
-	} else { /* merge_next */
-		vma_start_write(next);
-		res = next;
-		if (prev && addr < prev->vm_end) {	/* case 4 */
-			vma_start_write(prev);
-			vma_end = addr;
-			adjust = next;
-			adj_start = -(prev->vm_end - addr);
-			err = dup_anon_vma(next, prev, &anon_dup);
-		} else {
-			/*
-			 * Note that cases 3 and 8 are the ONLY ones where prev
-			 * is permitted to be (but is not necessarily) NULL.
-			 */
-			vma = next;			/* case 3 */
-			vma_start = addr;
-			vma_end = next->vm_end;
-			vma_pgoff = next->vm_pgoff - pglen;
-			if (curr) {			/* case 8 */
-				vma_pgoff = curr->vm_pgoff;
-				vma_start_write(curr);
-				remove = curr;
-				err = dup_anon_vma(next, curr, &anon_dup);
-			}
-		}
-	}
-
-	/* Error in anon_vma clone. */
-	if (err)
-		goto anon_vma_fail;
-
-	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
-		vma_expanded = true;
-
-	if (vma_expanded) {
-		vma_iter_config(vmg->vmi, vma_start, vma_end);
-	} else {
-		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
-				adjust->vm_end);
-	}
-
-	if (vma_iter_prealloc(vmg->vmi, vma))
-		goto prealloc_fail;
-
-	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
-	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
-		   vp.anon_vma != adjust->anon_vma);
-
-	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, vma_start, vma_end, adj_start);
-	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
-
-	if (vma_expanded)
-		vma_iter_store(vmg->vmi, vma);
-
-	if (adj_start) {
-		adjust->vm_start += adj_start;
-		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
-		if (adj_start < 0) {
-			WARN_ON(vma_expanded);
-			vma_iter_store(vmg->vmi, next);
-		}
-	}
-
-	vma_complete(&vp, vmg->vmi, mm);
-	khugepaged_enter_vma(res, vmg->flags);
-	return res;
-
-prealloc_fail:
-	if (anon_dup)
-		unlink_anon_vmas(anon_dup);
-
-anon_vma_fail:
-	vma_iter_set(vmg->vmi, addr);
-	vma_iter_load(vmg->vmi);
-	return NULL;
-}
-
-struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg)
-{
-	return vma_merge(vmg);
-}
-
 /*
  * We are about to modify one or multiple of a VMA's flags, policy, userfaultfd
  * context and anonymous VMA name within the range [start, end).
@@ -1280,7 +1270,7 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 	struct vm_area_struct *merged;
 
 	/* First, try to merge. */
-	merged = vma_merge(vmg);
+	merged = vma_merge_modified(vmg);
 	if (merged)
 		return merged;
 
diff --git a/mm/vma.h b/mm/vma.h
index bbb173053f34..bf29ff569a3d 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -110,12 +110,6 @@ struct vm_area_struct
 
 struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg);
 
-/*
- * Temporary wrapper around vma_merge() so we can have a common interface for
- * tests.
- */
-struct vm_area_struct *vma_merge_modified(struct vma_merge_struct *vmg);
-
 struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta);
-- 
2.45.2


