Return-Path: <linux-kernel+bounces-299605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67595D766
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E12282F19
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D1C1953A2;
	Fri, 23 Aug 2024 20:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JCYJi7pU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bsVY8O5v"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA56193089
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443691; cv=fail; b=gg0WBvkmmqb/VZHnbTVcYTlfA4dqVv3xju3dFmFNujhn3R13WPWyaa3hRvn9YxTWLICLbK1HQaq8s1sCcljMGYCEI/lqCqO31m3JTWBJFfBHYD3w9Ge1wz1pVPUWe+K5NQITyHqLW3lsTb7PrOSJYbtz/8CUnihbOMpM4ge/oR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443691; c=relaxed/simple;
	bh=+J/pMI+NsVAF5xaAFppritUpum+rJhP2JQrXQdQND60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmQyNmtnsETPw3kSVbZEXvAkQPqf4pVJvqw0jAMfOPr0E2fajs652pECsw+QEOM1FKf2YX6XrtG6QYk3CBbP65TdRUOqMd16drVSzxOR8oSdI7pA1tQFIPsn0WrZiQ1gXKvDsLNppWR6qgP4fH+V2E6fgkljQeQauggt0nVKmeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JCYJi7pU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bsVY8O5v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0Ve8002321;
	Fri, 23 Aug 2024 20:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1/OPj+BBHa5JPP0Om/PikHyhUPZrpTHgM+iJwISRc54=; b=
	JCYJi7pUVqkyPojyJ/Mi6swpPK2qsdrrvGPXtolZF8DsuzVpzusG/aCzQhSbwy30
	4iiocB7K16IJy71MfDoOOOLJvBhKmrMkrk74xKKGcA+fWl/eEk5N3+iWzIkwddbO
	FxAvvcKEmWtb0+9FFSUt7dcGDlbYwFfoUjpRWeqReDNLwWZNAcVNj+2JrmeWspeS
	72gQH48pTfNursYzcTDM1SSL20zNmJ2I62MVB3MUAb56eCPl73l6kOVLYprFnoo6
	22oRP0F4zzBk0pXPtzxHgkdkiBxz1D21tbQpX7HjhVjb04y5oYlP4CAmu2LEGNUw
	Xoz2+XOBiElcW7ldKXwuuQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67n1gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:08:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdDFl007056;
	Fri, 23 Aug 2024 20:07:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4170s612ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkLUsKlUwEDR866YHKwtC/ShWtRFRkbXRHTBnQqAFV3mK5Ecg2C3q43GvJ+i9w+On9f/mPkGQHWGvyYUm5WNKZmsI5zmTheTA4N6vvYZU9DmhWBWpV6STgiVjM7wOo6uJ8CH1RTXUEortzR+f1d4AHwHPxDt8NSNAY19kialLbDVmAlx9rrwNut00NtJtDzVPskqrJpa/plnKUi0y6yRA7IwvOFJcYUNGHIS883HyUKllem+wkKPpqdtZ9ZZSn5LDmuouISxiqsAHeREEsG7sGfmYAN78f8t441wdCmulbtGAlAkarfQaoDoLn/iJ0VWoGYBILrNg+FLHOK/t0ZGhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/OPj+BBHa5JPP0Om/PikHyhUPZrpTHgM+iJwISRc54=;
 b=xqaY31G3ilur2ihxX6Hx6Wzy9ooDjolMYMpkyzOYC5L96yg4xsqlcwgh+Fqv3d5z4IZNdBF7/69xTfnhnHYm61UnZpRg5HLOMwjl1+qHjWdDAcXDwRhVdEaLfIoOCrpmfkMOCB93Qfd02AxkI5E6Ru/knoKLp5z8rHEW2u7IYllz8OT4P+Q9MMNuoAD+b8qlo3EV2JXIJwfx0uRhV9w7zB2aTRhsD0cZbrVQ5fVbfwtss2lPn1CVYzA4c6zbLagvvfTs88BYthM9R8yiwY5Dycr8pGhn54p67kbvkgPadUAIjj1W0TYMXvEC2/l8nI0yV19ZP0t0Gb7tYFSpOsuKIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/OPj+BBHa5JPP0Om/PikHyhUPZrpTHgM+iJwISRc54=;
 b=bsVY8O5vS0kx4L0iyc/NTHFIbiVEV8jbfiK6AShGjbqAcl163D8RT2C7RS4AC6bgkftrGHg5EHL4CHs9TIbw1TwePR3P+OsFdkGK/l5sIji1t6d0sXDy+nuj0Z2JjHWMneJrxq5yjY2XnDj8Tytw89lZCu+FXbNEv9Xr5LKE+7s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA6PR10MB8086.namprd10.prod.outlook.com (2603:10b6:806:446::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Fri, 23 Aug
 2024 20:07:37 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 10/10] mm: rework vm_ops->close() handling on VMA merge
Date: Fri, 23 Aug 2024 21:07:05 +0100
Message-ID: <3fdfcebeef4b2004940bd09eac6648ad9b2f224b.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA6PR10MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 04aff7d7-d862-4837-ab8d-08dcc3af3ba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dyE35eItbDJSHAyv2YxDVd1bqN/jVvDij45MpoWARnTqbHRoMbHPpnaQ5Nps?=
 =?us-ascii?Q?VYmJFfZsny7Sr5MruJfdCdjvGft7/K3mAC+5wKcNk+HkLn0to0QaOLuz+bZw?=
 =?us-ascii?Q?ci3XcfgbKCgvIIE5Sfh68wQS/Qt0sMLBmYsNQdUbaXHaBVRhgqHFNWE3+XeM?=
 =?us-ascii?Q?dvTaM/7CWRNSfPj67i9SNCk8eT+Me6zRkpMCXy4+KJpkkg1ZplLWV7N1bXAh?=
 =?us-ascii?Q?uOTLl/M/f1ni7rCjBeSOeb3Uqe9vTxIkrIV37vv0BNGAKvj0E1ZGU5mKNOAP?=
 =?us-ascii?Q?qqXMG9111LRM6enFMRZUMXp14sb9un/QldIfQkUhdxAaDLkUUFib0xQCpXUH?=
 =?us-ascii?Q?5xqaJBZLItjwtyVSx7156MNOudxhTumGgTJJ+NyRiaDper9ltF7QZI18YitH?=
 =?us-ascii?Q?wluLFRPsG6QlY7GseNhOWKQcdnZ3j/X4no0+efJ6d0cVGCtPXMLNq26vM5rd?=
 =?us-ascii?Q?ieyWBxfWHT6XkZ5bAkCYVBd7NfJVCko5GWMQhVtEVkY0WuLe7YVwZoY3AdPP?=
 =?us-ascii?Q?lx3jAnEqc7cAED2TDthChtfmKr+v4HLmiliLjfCqFQ16LAhYKmNb8LaKJEBI?=
 =?us-ascii?Q?cpzmEo6rR6NxbYmVEGSeEO5ZYXEno3aWwgFjbDP8tK6ZWI6NZSqt/yDzk1+u?=
 =?us-ascii?Q?4n37Up4qytFqTIbb1MbhOBGQdvzK6asFR9nhousrm1zJxS587Gy7s45636YJ?=
 =?us-ascii?Q?HYH7fUFZUefvqDYBwD+/F3cn304CaQD1PKnHUish4TBXUf/WAbjTdOHnXJor?=
 =?us-ascii?Q?sCmttDsi5CMF1uJD1fHN2cjGt6bvtk8Qvj4ZHd1S7O3YIUH2xhtHQjlcMjHw?=
 =?us-ascii?Q?xU0NAnv3UINc/gR1D7308cKGYHbtl19yfrZDpHqysxo5B8ZuxXGURcoC/N5D?=
 =?us-ascii?Q?CVGJ31BE7AwlhPP+8Yhs1PSttYrg7ocV2oaO1K11uj5sh3/N1Nt7SzPuiRoe?=
 =?us-ascii?Q?qyqk3Z9vP3LPJn3CXEvQ2h6Et0TuS2sniuB/eipePlrStRCKt963Mu6g0ccI?=
 =?us-ascii?Q?Q7w4iyF/0pWUrgU+v5yQi5z2LpTqvqmEP+bbob5d/3lxi8TP6HaXCkQF/eik?=
 =?us-ascii?Q?mpVIdp6RfEMOKllu8YJ6ZSaJWhoPxg5egw4G4iy9N21Jc3SpfucyWpScWPb9?=
 =?us-ascii?Q?Jt9vxfP02B7R+WU3mKgp7kkXWUTEWqEZIomfnRIlDkmYhS6qqYz/dwS3Niog?=
 =?us-ascii?Q?AhrisMuZk1mztCPlA8min98JqrZBNUDgJnkfB0en61BrFUlfisIpGL+sPjZo?=
 =?us-ascii?Q?hEauwAGqrkNJYKeGkCHdyJKR2sctoF5aPBbOEPkeyTi5dZ60DpN+3vA+jh86?=
 =?us-ascii?Q?ZZ5ozD96SDBDab9+4S9wnX3HT6WAZAwCG1K4NNrlPbMc9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cMdMMlaos0Shk+/K11UB8WM2WHL6NlLlZ21oZZ7aMOR8R6Vs0Sj8naSMj9K0?=
 =?us-ascii?Q?RyrX9Ct5L7n4Q6b33T1ZCvc+vCg8jNohW5dTGwRg98MRAU0PpkZqOrUqrJfv?=
 =?us-ascii?Q?pyruLsMLxDVKIVNA/9I1XJqD1EvpnGsijJ/Z0R+knNCXi6yGun2tzF9devV+?=
 =?us-ascii?Q?HFgZP+AReVh3aKJnFrJ94B1pEk11NoK/XK9qD1TmQdqcnqTTYU+PbS+gBwL2?=
 =?us-ascii?Q?mmYr6Zu1nw5mYdOYedptfEbJyc0CPY4CeN20rZui5EKiuGLONwkgaeQjsA2S?=
 =?us-ascii?Q?wYxyRCk7fwT6evg2CT8JFVgyLATH3Po2QvounbyAl10b4AfG60xV6cOmXIhX?=
 =?us-ascii?Q?3XMEznpvRMDgptfZUswYEcXOyv9YUMiXV0Aq49c9PeNw/YcU8TGiKIwXM/Ce?=
 =?us-ascii?Q?npSQV+wVm24vyAc1y+Xs99zbLoiujMMPYsHvlny2OsBtNhF7+kaGauhhxXWE?=
 =?us-ascii?Q?Ub80ac9OBh8+D1gEKs06iyW56539bz/pSBSnktzb5pa/3kwb99zW2ia+ghOR?=
 =?us-ascii?Q?HRckaGeEs505KLOO8bgaG6A+htm7EWOrvm2oVzVELPgUoEjHElQSnmc7CCfL?=
 =?us-ascii?Q?zedseLPDPfMcJ19FJP9Puy/KFv6/W9wFO3lQVfpeHW25tWUmp/A9SCUQnhAZ?=
 =?us-ascii?Q?ZIPZa1fLmRQo/FMFaeMIfxJG22x95hYRMxy88m+F8nO9+LM1bA8cPj+U/vuq?=
 =?us-ascii?Q?PtYnYNS78uSZnG+FysWbuvL/xqZ+hrYdtt8o8t6wvtteumuKvVIiZx6VEqMX?=
 =?us-ascii?Q?jxCzVgG/ViZub3A9ToHGIj+iGDw1lrnUeZZOb1wvYQPMeVbKUEEwldf/C33s?=
 =?us-ascii?Q?9jn5yZX44jhxdt3fpcaa85KkaWYJVOcNqIx5CycgApi1xV2eMdAMJuc+rioC?=
 =?us-ascii?Q?ZXwcR3YnEIEoZROPJY5M5iSc4WOhylxPTAYwPsAhEbi5ox+oea3Q93H1R6mJ?=
 =?us-ascii?Q?qwC6g9z+EPINV7EJ5COE4rPTRdoLeoxIZ/jVYPAAO2olNZmC3sR13PA5W4IL?=
 =?us-ascii?Q?SrOUN8a5zvKAdNVxKlxBuUj8Gl7W5WF1rtNDohZV0Tr8x0KQ/Oe2rwuH5ilm?=
 =?us-ascii?Q?tplFXnBPHEG0u6oZYGNYGoQWujJDNqJsSqewgvhNqOciavYGoK0ooVhfQ+pe?=
 =?us-ascii?Q?8TspWRT43/YG1sHa59FsnUSGNVhafJ9v5+ryoCTVm0r9KhLV9ABpRuFj50vD?=
 =?us-ascii?Q?Rpk0oSvzy9irBAP2h473FrwOeUBO2Tykk3MfZFZG13ZzmiTMEHd3/Mr/MkkC?=
 =?us-ascii?Q?YtZmy4ScZvlqPCOCQpr2ljqDxmDDKHL/HkyBJcAtPy8IboGZ13COVxgDPzXH?=
 =?us-ascii?Q?XIa7FktkgDnUTDUKj0Rblb0juSGPZABCrJEOYxiCIks677y8nENS8VIpwwNH?=
 =?us-ascii?Q?ipVf8NWUg66Z+WOmu1CYwx75x51sxzUfhrqVQPOAoo6rQX8Jwjn6fSTYC56J?=
 =?us-ascii?Q?Vg6dAVG/ZPrHtsuHsVjHrejAjH4OKMndLdI6EZZpPvmdf8ntoU1zufmBJ5gI?=
 =?us-ascii?Q?mrYVAFAydQAPWAykDiLE1zEk23zZdFTzfheG0EGQFT3hWeFOu8tuM2OjlPRP?=
 =?us-ascii?Q?EbbDkGrUhLEoV9dW37GFstPPLcTWXo9shX2gSMwxS/47iXKr33MorHboPT5A?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NRnxqhhrMolg4/WCVQ0DhSYCvp1zj1cU1V7ihG/QKDOcyOjo7fpd51aEPLAIxc9I4b+J3aRsJssX8rpSeFHsp5UVYXy7ja03WKnwTMZmxpESJsus6eIzedvwuBftqa/It1yzg5RA784w6IcBpykEepbThyGjVwLK+S2jLnJMAtUFKOI5v7JIYkXl/KCNEQQKIbkV4D9kaDf8DqrW2nk8gX3L8JXQcFX+VYwjCM5wOuLa23iHVT55MhKSVH0BxAOSErs5zGSBLM22l3gYMSljHFoescm2SDSYeLn1MExVH2P1Ll//LsrjggnmBWcioY8Em9nvAt5QLlNK0o7HPqCa9ktDjux3s5HhgsvG7tkcgFCQmiwVHxdx79loo4j/tJRVNkMNjTPUkBGODQI0BKYVqXZBSsLGRB/PXOHxkC7uPnzHPQdAtO6q4AjI08KepWnwdTAf8ABarlXWPuBSNK2f+AHx9LMvjzdWBRgiHV9TWORQPhUK2/76yHp/N1Z1XXK8GN3hMwbeUWIPuT6/EwM+05E0T50xHu8lkruRb2DXeXrZVs9cM7SKMBEl60EDL9nQ5BoTxTiNMlQWHGe89Pm2zeIS9QZi9aWXhzrzPNm89QE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04aff7d7-d862-4837-ab8d-08dcc3af3ba5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:36.9320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4w9Spix2WCqbx431ba+1vYVXZch4u1xhtKBZmmX7E9UnsXSoVf20o2PR/Gs+CMaiGPj0ZYnz7xHku2FH+Mee09RqGbjmKBAIuZdr8kENe5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-ORIG-GUID: jtNl3bkj5kmzX89BNO8R1uDbptNz_-Sq
X-Proofpoint-GUID: jtNl3bkj5kmzX89BNO8R1uDbptNz_-Sq

In commit 714965ca8252 ("mm/mmap: start distinguishing if vma can be
removed in mergeability test") we relaxed the VMA merge rules for VMAs
possessing a vm_ops->close() hook, permitting this operation in instances
where we wouldn't delete the VMA as part of the merge operation.

This was later corrected in commit fc0c8f9089c2 ("mm, mmap: fix vma_merge()
case 7 with vma_ops->close") to account for a subtle case that the previous
commit had not taken into account.

In both instances, we first rely on is_mergeable_vma() to determine whether
we might be dealing with a VMA that might be removed, taking advantage of
the fact that a 'previous' VMA will never be deleted, only VMAs that follow
it.

The second patch corrects the instance where a merge of the previous VMA
into a subsequent one did not correctly check whether the subsequent VMA
had a vm_ops->close() handler.

Both changes prevent merge cases that are actually permissible (for
instance a merge of a VMA into a following VMA with a vm_ops->close(), but
with no previous VMA, which would result in the next VMA being extended,
not deleted).

In addition, both changes fail to consider the case where a VMA that would
otherwise be merged with the previous and next VMA might have
vm_ops->close(), on the assumption that for this to be the case, all three
would have to have the same vma->vm_file to be mergeable and thus the same
vm_ops.

And in addition both changes operate at 50,000 feet, trying to guess
whether a VMA will be deleted.

As we have majorly refactored the VMA merge operation and de-duplicated
code to the point where we know precisely where deletions will occur, this
patch removes the aforementioned checks altogether and instead explicitly
checks whether a VMA will be deleted.

In cases where a reduced merge is still possible (where we merge both
previous and next VMA but the next VMA has a vm_ops->close hook, meaning we
could just merge the previous and current VMA), we do so, otherwise the
merge is not permitted.

We take advantage of our userland testing to assert that this functions
correctly - replacing the previous limited vm_ops->close() tests with tests
for every single case where we delete a VMA.

We also update all testing for both new and modified VMAs to set
vma->vm_ops->close() in every single instance where this would not prevent
the merge, to assert that we never do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/vma.c                |  60 ++++++++++-----
 tools/testing/vma/vma.c | 166 +++++++++++++++++++++++++++++++---------
 2 files changed, 167 insertions(+), 59 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 31c52598ee50..dcc641a3f979 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -10,14 +10,6 @@
 static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
 	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
-	/*
-	 * If the vma has a ->close operation then the driver probably needs to
-	 * release per-vma resources, so we don't attempt to merge those if the
-	 * caller indicates the current vma may be removed as part of the merge,
-	 * which is the case if we are attempting to merge the next VMA into
-	 * this one.
-	 */
-	bool may_remove_vma = merge_next;
 
 	if (!mpol_equal(vmg->policy, vma_policy(vma)))
 		return false;
@@ -33,8 +25,6 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 		return false;
 	if (vma->vm_file != vmg->file)
 		return false;
-	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
-		return false;
 	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
 		return false;
 	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
@@ -587,6 +577,12 @@ static int commit_merge(struct vma_merge_struct *vmg,
 	return 0;
 }
 
+/* We can only remove VMAs when merging if they do not have a close hook. */
+static bool can_merge_remove_vma(struct vm_area_struct *vma)
+{
+	return !vma->vm_ops || !vma->vm_ops->close;
+}
+
 /*
  * vma_merge_existing_range - Attempt to merge VMAs based on a VMA having its
  * attributes modified.
@@ -699,12 +695,30 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
 
 	/* If we span the entire VMA, a merge implies it will be deleted. */
 	merge_will_delete_vma = left_side && right_side;
+
+	/*
+	 * If we need to remove vma in its entirety but are unable to do so,
+	 * we have no sensible recourse but to abort the merge.
+	 */
+	if (merge_will_delete_vma && !can_merge_remove_vma(vma))
+		return NULL;
+
 	/*
 	 * If we merge both VMAs, then next is also deleted. This implies
 	 * merge_will_delete_vma also.
 	 */
 	merge_will_delete_next = merge_both;
 
+	/*
+	 * If we cannot delete next, then we can reduce the operation to merging
+	 * prev and vma (thereby deleting vma).
+	 */
+	if (merge_will_delete_next && !can_merge_remove_vma(next)) {
+		merge_will_delete_next = false;
+		merge_right = false;
+		merge_both = false;
+	}
+
 	/* No matter what happens, we will be adjusting vma. */
 	vma_start_write(vma);
 
@@ -746,21 +760,12 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
 		vmg->start = prev->vm_start;
 		vmg->pgoff = prev->vm_pgoff;
 
-		if (merge_will_delete_vma) {
-			/*
-			 * can_vma_merge_after() assumed we would not be
-			 * removing vma, so it skipped the check for
-			 * vm_ops->close, but we are removing vma.
-			 */
-			if (vma->vm_ops && vma->vm_ops->close)
-				err = -EINVAL;
-		} else {
+		if (!merge_will_delete_vma) {
 			adjust = vma;
 			adj_start = vmg->end - vma->vm_start;
 		}
 
-		if (!err)
-			err = dup_anon_vma(prev, vma, &anon_dup);
+		err = dup_anon_vma(prev, vma, &anon_dup);
 	} else { /* merge_right */
 		/*
 		 *     |<----->| OR
@@ -885,6 +890,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	unsigned long end = vmg->end;
 	pgoff_t pgoff = vmg->pgoff;
 	pgoff_t pglen = PHYS_PFN(end - start);
+	bool merge_next = false;
 	bool can_merge_before, can_merge_after;
 
 	mmap_assert_write_locked(vmg->mm);
@@ -910,6 +916,8 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		vmg->end = next->vm_end;
 		vmg->vma = next;
 		vmg->pgoff = next->vm_pgoff - pglen;
+
+		merge_next = true;
 	}
 
 	/* If we can merge with the previous VMA, adjust vmg accordingly. */
@@ -918,6 +926,14 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		vmg->vma = prev;
 		vmg->pgoff = prev->vm_pgoff;
 
+		/*
+		 * If this merge would result in removal of the next VMA but we
+		 * are not permitted to do so, reduce the operation to merging
+		 * prev and vma.
+		 */
+		if (merge_next && !can_merge_remove_vma(next))
+			vmg->end = end;
+
 		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
 	}
 
@@ -973,6 +989,8 @@ int vma_expand(struct vma_merge_struct *vmg)
 		int ret;
 
 		remove_next = true;
+		/* This should already have been checked by this point. */
+		VM_WARN_ON(!can_merge_remove_vma(next));
 		vma_start_write(next);
 		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index d31bb7bd972a..ea4f9109ffc2 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -387,6 +387,9 @@ static bool test_merge_new(void)
 	struct anon_vma_chain dummy_anon_vma_chain_d = {
 		.anon_vma = &dummy_anon_vma,
 	};
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};
 	int count;
 	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
 	bool merged;
@@ -430,6 +433,7 @@ static bool test_merge_new(void)
 	 * 0123456789abc
 	 * AA*B   DD  CC
 	 */
+	vma_a->vm_ops = &vm_ops; /* This should have no impact. */
 	vma_b->anon_vma = &dummy_anon_vma;
 	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, flags, &merged);
 	ASSERT_EQ(vma, vma_a);
@@ -466,6 +470,7 @@ static bool test_merge_new(void)
 	 * AAAAA *DD  CC
 	 */
 	vma_d->anon_vma = &dummy_anon_vma;
+	vma_d->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, flags, &merged);
 	ASSERT_EQ(vma, vma_d);
 	/* Prepend. */
@@ -483,6 +488,7 @@ static bool test_merge_new(void)
 	 * 0123456789abc
 	 * AAAAA*DDD  CC
 	 */
+	vma_d->vm_ops = NULL; /* This would otherwise degrade the merge. */
 	vma = try_merge_new_vma(&mm, &vmg, 0x5000, 0x6000, 5, flags, &merged);
 	ASSERT_EQ(vma, vma_a);
 	/* Merge with A, delete D. */
@@ -640,13 +646,11 @@ static bool test_vma_merge_with_close(void)
 	const struct vm_operations_struct vm_ops = {
 		.close = dummy_close,
 	};
-	struct vm_area_struct *vma_next =
-		alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, flags);
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma_prev, *vma_next, *vma;
 
 	/*
-	 * When we merge VMAs we sometimes have to delete others as part of the
-	 * operation.
+	 * When merging VMAs we are not permitted to remove any VMA that has a
+	 * vm_ops->close() hook.
 	 *
 	 * Considering the two possible adjacent VMAs to which a VMA can be
 	 * merged:
@@ -697,28 +701,52 @@ static bool test_vma_merge_with_close(void)
 	 * would be set too, and thus scenario A would pick this up.
 	 */
 
-	ASSERT_NE(vma_next, NULL);
-
 	/*
-	 * SCENARIO A
+	 * The only case of a new VMA merge that results in a VMA being deleted
+	 * is one where both the previous and next VMAs are merged - in this
+	 * instance the next VMA is deleted, and the previous VMA is extended.
 	 *
-	 * 0123
-	 *  *N
+	 * If we are unable to do so, we reduce the operation to simply
+	 * extending the prev VMA and not merging next.
+	 *
+	 * 0123456789
+	 * PPP**NNNN
+	 *             ->
+	 * 0123456789
+	 * PPPPPPNNN
 	 */
 
-	/* Make the next VMA have a close() callback. */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
 	vma_next->vm_ops = &vm_ops;
 
-	/* Our proposed VMA has characteristics that would otherwise be merged. */
-	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	ASSERT_EQ(merge_new(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x5000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
 
-	/* The next VMA having a close() operator should cause the merge to fail.*/
-	ASSERT_EQ(merge_new(&vmg), NULL);
-	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
 
-	/* Now create the VMA so we can merge via modified flags */
-	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
-	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, flags);
+	/*
+	 * When modifying an existing VMA there are further cases where we
+	 * delete VMAs.
+	 *
+	 *    <>
+	 * 0123456789
+	 * PPPVV
+	 *
+	 * In this instance, if vma has a close hook, the merge simply cannot
+	 * proceed.
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
 	vmg.vma = vma;
 
 	/*
@@ -728,38 +756,90 @@ static bool test_vma_merge_with_close(void)
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
-	/* SCENARIO B
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * This case is mirrored if merging with next.
 	 *
-	 * 0123
-	 * P*
+	 *    <>
+	 * 0123456789
+	 *    VVNNNN
 	 *
-	 * In order for this scenario to trigger, the VMA currently being
-	 * modified must also have a .close().
+	 * In this instance, if vma has a close hook, the merge simply cannot
+	 * proceed.
 	 */
 
-	/* Reset VMG state. */
-	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
-	/*
-	 * Make next unmergeable, and don't let the scenario A check pick this
-	 * up, we want to reproduce scenario B only.
-	 */
-	vma_next->vm_ops = NULL;
-	vma_next->__vm_flags &= ~VM_MAYWRITE;
-	/* Allocate prev. */
-	vmg.prev = alloc_and_link_vma(&mm, 0, 0x1000, 0, flags);
-	/* Assign a vm_ops->close() function to VMA explicitly. */
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
 	vma->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
 	vmg.vma = vma;
-	/* Make sure merge does not occur. */
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	/*
 	 * Initially this is misapprehended as an out of memory report, as the
 	 * close() check is handled in the same way as anon_vma duplication
 	 * failures, however a subsequent patch resolves this.
 	 */
-	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * Finally, we consider two variants of the case where we modify a VMA
+	 * to merge with both the previous and next VMAs.
+	 *
+	 * The first variant is where vma has a close hook. In this instance, no
+	 * merge can proceed.
+	 *
+	 *    <>
+	 * 0123456789
+	 * PPPVVNNNN
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
+
+	/*
+	 * The second variant is where next has a close hook. In this instance,
+	 * we reduce the operation to a merge between prev and vma.
+	 *
+	 *    <>
+	 * 0123456789
+	 * PPPVVNNNN
+	 *            ->
+	 * 0123456789
+	 * PPPPPNNNN
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma_next->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x5000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
 
-	cleanup_mm(&mm, &vmi);
 	return true;
 }
 
@@ -828,6 +908,9 @@ static bool test_merge_existing(void)
 		.mm = &mm,
 		.vmi = &vmi,
 	};
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};
 
 	/*
 	 * Merge right case - partial span.
@@ -840,7 +923,9 @@ static bool test_merge_existing(void)
 	 *   VNNNNNN
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
+	vma->vm_ops = &vm_ops; /* This should have no impact. */
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
 	vmg.vma = vma;
 	vmg.prev = vma;
@@ -873,6 +958,7 @@ static bool test_merge_existing(void)
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range(&vmg, 0x2000, 0x6000, 2, flags);
 	vmg.vma = vma;
 	vma->anon_vma = &dummy_anon_vma;
@@ -899,7 +985,9 @@ static bool test_merge_existing(void)
 	 * PPPPPPV
 	 */
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vma->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.vma = vma;
@@ -932,6 +1020,7 @@ static bool test_merge_existing(void)
 	 * PPPPPPP
 	 */
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
 	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
 	vmg.prev = vma_prev;
@@ -960,6 +1049,7 @@ static bool test_merge_existing(void)
 	 * PPPPPPPPPP
 	 */
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
 	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
-- 
2.46.0


