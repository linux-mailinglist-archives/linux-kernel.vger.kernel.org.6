Return-Path: <linux-kernel+bounces-255618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 493629342F1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01264282A66
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4641891A9;
	Wed, 17 Jul 2024 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UEOHCqPv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o2RCFJsz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FB187850
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246869; cv=fail; b=eBaqhvWpTK0gl908mCtGz734vOU4UwvWDMCPmwS7t7Lkt+/p8EnVRodnkd7ySEe7AcUPzUlaCMuAl3+nLLfv481fIBcA3aFKCPbfWPbFAOy3Eq9//Xe8MFkWX6EnPRZ/tSYMj+RIgUkgSVHD5vTT3tU6WTaBZLGyo2Q66hvO9M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246869; c=relaxed/simple;
	bh=sXsnaUPNx2s7xu38GwZZGqSmUoOvaXfbJLoh1yiCk3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNHefdq0blnTapd+k8tAajcRxWTOhyyItKq0ceSRS61lr7/oWJ8j4W5F3WorfIodjaBh7RJ4r1jyydOyKE9U0tHmaFptFlBAI1lyZB3JERLUXb5/F7xCfIBY1Vy+5P2TJcEjZ+ptHn+ivbFXA1FRAOU/8gFwdah/J7TKVuMMg/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UEOHCqPv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o2RCFJsz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HJtlDn031584;
	Wed, 17 Jul 2024 20:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=tD/0zTBFlIy2X0qEJP0lFciqbADB3HhcYy8G490XlQE=; b=
	UEOHCqPvhcJhliieKdzkhIxyN9qMci3eK5c/N/MaZJE3xNzVrIzA920wNZDCNCLt
	J32mDh3DNeAj6Do5/096814Vx2/2UEsdbhrKOWpjoomOivICj/iQwmluszgfSOyC
	zwxlFamfyOJXke9MUyRPUIrS2d6MB7QOBkhFUgOL6djdH7pdWHx3kdl+nPmDh73F
	lSSdNj18Bmq2vpkEz6Ngy4cPvav3Xv40G99Oj/QQYXy4Ot5Tk78jw4zVRlgsoJnS
	wgormYVg5sLKSdSiznhp/6CP8s8S5FG1FW7qqLwk1ELqXMpkX5YCVbB3goAuN4Ix
	z1vSaW80HcGurqgFOuyw5A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emhpr0qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HIrJXp006940;
	Wed, 17 Jul 2024 20:07:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwey1fcb-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRElpd9xBDE8mhBPJl1G/HQ++kucTHhRj7G3Sr+QGFRvUWc2NtQZxoRY0mj+YgZWowaKseEg/yrulpyrLKc0S/Nq0jWy+rWOSR+VmckNFkGm94yf5+5lbYQL4MMKoQbo0annDkxdFiqlIdWbGKgavoTI5KbazWLJixEb1tHNCQblZKP6lBHSqrpvy+4/qouAu7NE13jKiZMhm1ZhQRKjnFHTLdoxKd/W2wLGTibq+3slBltMBfo461P3f7fb7QkI1SOvebaEcwK5nYXRJElQqQjMShLFOqxHq4k/c81yF4IbXr47iT3Byht8/+rvPm8xGCrFWNbe4p+S7VIZwodAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD/0zTBFlIy2X0qEJP0lFciqbADB3HhcYy8G490XlQE=;
 b=K7KX4eHUZivoYjWJRGFcJUi4vDNg/yisvkcOp8VoNxSqdOHPIiH9KSjoPJZULyh+HMYFOwRIH8VyIpV9C3rCSdRwfiCKXWc4pmfLsUht7xFHlu3jL18xErLJeXjBfFLzYikZzoWb7gNtNI9KOgSkCCwwejh+TeAqau597wHajYkmTbvHRQLPDu+RQoPCcYv34EDZcT3T3s/yuTlz22My0TV7myEhAGLAIl9H0jMrNre27gFapbplsOGwKXB0oRUk+AjtfWisAB4c8klZihTsFfRbuGgST/2s1FkzOtWSgn7O7Qi+65zkD8APLhZEBYRYnL0OsQJHAPEEUFIo8QGy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tD/0zTBFlIy2X0qEJP0lFciqbADB3HhcYy8G490XlQE=;
 b=o2RCFJsz33b5sRj08lELKRjgC9J5K6flbTgv2rjTZjhmx6pEK8vcV0m4gb8USE0y/6mpoYMBYxz93nFO2nqexzX6E4j3ylz4fckz2tXj/QzlWirGnVmjavwar8CCtDWhxjK29XCh/d8RAb5TTPeok9hX7+SidftH1lbJtUn7aWs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7303.namprd10.prod.outlook.com (2603:10b6:208:40d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 20:07:26 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:26 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 06/21] mm/mmap: Change munmap to use vma_munmap_struct() for accounting and surrounding vmas
Date: Wed, 17 Jul 2024 16:06:54 -0400
Message-ID: <20240717200709.1552558-7-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::31) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: ef419b56-51d9-4931-2f7a-08dca69c1461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9nGc5X9E1SbyP5TrkU9tpJEb8sfFGDYF08E1Q0Ec+V1yj8IQTLTLlN+h/VZn?=
 =?us-ascii?Q?tcdjcMwB3uOSIckbB6l0o2AaW1DiK6KJ6Iyw5Ko+cxRrySKN54SMiO957zrj?=
 =?us-ascii?Q?lvS+42fdJIWj9ct4mofnDMIMpwGTp9MBax5leCFwgAx59wq4MnbekqNGcUIe?=
 =?us-ascii?Q?Hu4FDWkaB0nv/VqThNe2ZDnYjbaLYMDNBxKQ0aDwBH4+EsW7D0XyCFtfHB/B?=
 =?us-ascii?Q?LhBUmnHEdBkYYMMc65sSNuMxbBkBtsAYYPer6tlliT1DKoKbAADdTkiE0FGa?=
 =?us-ascii?Q?ew4ovZZb0fKqu8uNXz3SQg+Hh+KMQgthzhCIQ+6XtRaWFbSY4d7Q2di37Z4S?=
 =?us-ascii?Q?wa7gquc/IZ5WVHklYCwFq0WkmhPn4TjWv75W/n2CGI5CM+EGaempzdhAxci2?=
 =?us-ascii?Q?mJxipaa75I/E34MFDJ53Mt8tD9cWpLvF5uhqS8TtAN13GSrNTKZXuTkP4Xx5?=
 =?us-ascii?Q?p3Y7W4dpd6aLcswhA8K3oOHRs02dJp13H8wDzEqx092XUQmE6pa6RtKnIkqP?=
 =?us-ascii?Q?ua/b2yZ/VucNdKkAB6i3CLDMweepHCtAa5kZwA59hIKEZzPdV4HsnZ5L1Ncp?=
 =?us-ascii?Q?+3Cry7Eg4SJ6NSfjYuV2jl2Lw8HIN0HcUnPsJdDYNxkwNQtPprzP79K817AR?=
 =?us-ascii?Q?gNTOb3QSrHAJxr+OXqfyt00FVRaFyWLchtlomNIyQblTdPZE1bNVraXwgrhq?=
 =?us-ascii?Q?OzcEtCIOZszPXlIusf6Rq0gEu3VfrdUwXVmGLNE+hnBdQXEhHPewoGfwXp34?=
 =?us-ascii?Q?Tx72eHUVPdSDJmwUtmhZVTlfeuO5HKObG9/vIxA8ajxADc0QdqQTRw0fhXLP?=
 =?us-ascii?Q?i3aIGV4a671Cv7InJPvl1qpwC4PxUSsUNoVe7JAxszl13xahcIkXlqY0ydnT?=
 =?us-ascii?Q?IRoop+72oGVBVwBJTJUGoGH/KftL+mqUgpnMn4SFC84CBSFz2ZpgUwnHVKtM?=
 =?us-ascii?Q?f7JOyPW7I5yqI3NArldpUVM2bBhK3CrtU8A09X/f2qhsRPf8ms0mzStBhGrf?=
 =?us-ascii?Q?etlwYhbii/KbpQ1vgElvy8WcHkI94hicggThfig6Pd4CqyRbWE1df4Ux/8dq?=
 =?us-ascii?Q?35OGFnITS60xMt6IBF1q4yRpcViLxdoopK1K57dXW/ikYtAn2tEUqh7RNRyE?=
 =?us-ascii?Q?XOtkg9y+oCKBo6xjU+aVvp4mV/Z0rrNc9Zc2VVwN9lb23+3t5uh5GW0od/S0?=
 =?us-ascii?Q?m0N97ITipsmDex9Mm6WSYiBUjPjnyC6HCQImmZTk8oBF3MxFFPHMqH0VyqkT?=
 =?us-ascii?Q?IaFV/0qWCPJ1nzerJqIq04IbdTOJrKuoEVzu4tnanXBXR70joMtStrjH3Zaf?=
 =?us-ascii?Q?xR/C5szA93DF38KIQ1GshZVamNT+kUzQ8NEAtxFh+2YCtg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Rfuvp8+mtjwSu+I9A56ykuX/qrwl5DhTOBFHrFi6JSi2p9VjmqBJUygF/wS+?=
 =?us-ascii?Q?Wp/5QNxnrx1b0tLjp/OgDdEJTVGbkov9Z4h3Ftr4e6/wEg4djvHOJXxg8KoX?=
 =?us-ascii?Q?39YMrITdIhhyWbHE88TNiqRY9AhS9VQsFZSMfpNYA1NjJy2JeOD/mn9kh3o+?=
 =?us-ascii?Q?qL9BPDYUtzK5MLvF05PpuOq8qZfdNT/o0aR/r82aS0bmH4c17l27fVYD9G2A?=
 =?us-ascii?Q?Bfpxyy1ZjTvkhgk1lkXgTL6r1MYdGWjsivystxdtpjVwAGf8lgb8wxD0xZIv?=
 =?us-ascii?Q?QxGgwpYvObvBvoht5Rd8/fltLIFR6XTjVZo6a/+mQcfo+qFjO3Ouo3HEKx4w?=
 =?us-ascii?Q?zJ58Bf70P6njU5jDBwm/R8ZPiuwe91vfxL9ifr9sdAo+MahgcMwj0jpo+8hu?=
 =?us-ascii?Q?ekYZyECbalIa7ROHfmld3WbKEuhzYGwbZRjW48JnFIWqtRwfrlkFtVCJYW1C?=
 =?us-ascii?Q?4Pu9WDzeEQv5u0GqNJsUvAQb1mP0ZgOU1dq7bcoBRjFs/YWsIldau++20WSx?=
 =?us-ascii?Q?uhT2l6wQX8rux76tm/+svnIC+kHpjY0Fzrz49s3ovj5/rzZDcXBI4tftHCrx?=
 =?us-ascii?Q?Y6g5D/G0f8y/EOdFinAPJFiQ6K83GPsw09bh0MD/1wXcC3O9aqSAC20MNDD3?=
 =?us-ascii?Q?lcD6RY6b81o0ELmbRFhHm4f/R4uwHdYy6RSHpAmlX3SOxLiqbcy1jVmbNwrU?=
 =?us-ascii?Q?jsHsvJKMTV2vQ/2c124v9XS0HXWYbxPtygNd9F2NT3zN1QWFG//u9t8NS7XP?=
 =?us-ascii?Q?duDhKuFgSZyVM3RzVd21h9Yp9KDeX8O8PtzTRr2R3bb61n17w244QwaohAvF?=
 =?us-ascii?Q?VbemCYng5TLleolqoz3xSdTl6/wNl0R73O21uAP3BD5SpmldWp6gZ6waVg3X?=
 =?us-ascii?Q?Opqt5SZnbwCe5hZe0d31hYpE9UbHFA6gBgeqw1V9RjfYhpSZLfDOMLhGMWN6?=
 =?us-ascii?Q?63vYkEYZPeicaqCiCNI/1ImyFmt3mfpQfHm4G45AgOxDm3eC+vSmocJ+19fR?=
 =?us-ascii?Q?PD+JHSsk+6aIRvqQgGA7/7EiW1ZjRcTPnP1pWXbFEqth3P10dA0LsLI/zJuh?=
 =?us-ascii?Q?2Qa2CtUP0VgMffMGf0XvpIzBI1Tmm6Eo1w/tHEFleOMa5MpLNK8IKBKGTcwS?=
 =?us-ascii?Q?E++2jKhkTuVHRAQQFIKznZiv/xetL9yViILXnHtIRVnGXewJ+o0NeDA2hB3b?=
 =?us-ascii?Q?mBC8FX3C56g5X3k7uCnnfYGv+95UVbTFa7S5vG5tXghaKR0ZBoclxlZ3i91C?=
 =?us-ascii?Q?O3w39+WZiVHKDiQZXUaYrpP7nsA7y9uI/Z9Hgeo/V9cRGskPfpwDsfffMfhw?=
 =?us-ascii?Q?vDmOvImA5b8qp3UdoPjuBg6HycbM9cPlWcQfyqiXaAcHGzdcxzGj/0AqcfVn?=
 =?us-ascii?Q?eGZ3/PkCkd0OpnqNtgkZR0i3gi+lmKnyILNuR+QpU90wkfFaGuKxf3c8vKyP?=
 =?us-ascii?Q?ZCU9w/HVomzcJITDP+sZ3j3YiWjg9Ax0TRRIhZw87um8+bWAVylJTUpLIiSZ?=
 =?us-ascii?Q?MFls6CEjBaX43RVGqrw5DkH+3nskXJsUsNZIYo3+tQqaI2uJiELAuEBK3sJG?=
 =?us-ascii?Q?IIGy1J4d0QaId9Je8lvhHRAzl7UVU6QtfqyFy6uv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PyJ9K5P+U7VVUm3IX8Sfzb0Sm3Q840Z0ZJ/A6VBmnKEaBJ0ucmm1rjJrNuaqHyGbzPQu/IGm7Uy1kN3qUesZ1dkuau2X5sYzgVT8ykWHSiUrTCI6mLAog7gBYPvPxdsPpWJNROZG4e+tp2PEXbUkg08AEhgHcdGWHyD2R1PnOLkcgXcJdOgFWwB/ZVRctU8Vgd7nNZcuU4uCr4uwst8nUegv2aZSDNj+sm+0dEmoALq36a4aWvoXNkTGGfj1JXDSfT/qo8QXTSuUkgOv5c/LtaPLyad7Z3Z9QFbcSBQNVdWxet4Pll9DvQnq61dwt56RvA89USoQS3s1s/tC/QShSQM42ApSRKF2WQ5w72leRS7H9FrEFCStiquFF0lSp1py3/drzbw/xRKZzFRp7efm81vDl5HXQAqvTkA0VmRc+n5gqq9Anaor0J8MUH7JJ/XwZrNUAiAFObtw9lF4EVuw1kSV27URWMfXn6HwXcatuSWY+rWqW6euNRH4xtgc2WHnf+QRvGprv9qpbjRYvp5xo2Rub2x4U9ughsi97UNoY9T4Zj6e0lC9uqNUUDiRWMHiBqqzzMA6tUWu7AGr5tgCjn+pmykAuuXte6Yw9WZdTIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef419b56-51d9-4931-2f7a-08dca69c1461
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:26.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDhIvbNrNjGt/VOKHOCSmMAgTf5L7QJ/Kx38jeuPqa5wFuNjgF68xAOeAhpIzpZ6gX9PW1lfkoApkarE5mTg4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-GUID: 1lp5xNXu4R5qAyxKqzPfYsmeLJd5spJy
X-Proofpoint-ORIG-GUID: 1lp5xNXu4R5qAyxKqzPfYsmeLJd5spJy

Clean up the code by changing the munmap operation to use a structure
for the accounting and munmap variables.

Since remove_mt() is only called in one location and the contents will
be reduced to almost nothing.  The remains of the function can be added
to vms_complete_munmap_vmas().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/internal.h |  6 ++++
 mm/mmap.c     | 80 +++++++++++++++++++++++++--------------------------
 2 files changed, 46 insertions(+), 40 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9d0f4d1bebba..02627e269d6b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1488,12 +1488,18 @@ struct vma_munmap_struct {
 	struct vma_iterator *vmi;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;	/* The first vma to munmap */
+	struct vm_area_struct *prev;    /* vma before the munmap area */
+	struct vm_area_struct *next;	/* vma after the munmap area */
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr (inclusive) */
 	unsigned long end;		/* Aligned end addr (exclusive) */
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
+	unsigned long nr_accounted;	/* Number of VM_ACCOUNT pages */
+	unsigned long exec_vm;
+	unsigned long stack_vm;
+	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
 };
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 1ed0720c38c5..62ff7aa10004 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -523,7 +523,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 }
 
 /*
@@ -2388,30 +2389,6 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
 	return vma;
 }
 
-/*
- * Ok - we have the memory areas we should free on a maple tree so release them,
- * and do the vma updates.
- *
- * Called with the mm semaphore held.
- */
-static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
-{
-	unsigned long nr_accounted = 0;
-	struct vm_area_struct *vma;
-
-	/* Update high watermark before we lower total_vm */
-	update_hiwater_vm(mm);
-	mas_for_each(mas, vma, ULONG_MAX) {
-		long nrpages = vma_pages(vma);
-
-		if (vma->vm_flags & VM_ACCOUNT)
-			nr_accounted += nrpages;
-		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		remove_vma(vma, false);
-	}
-	vm_unacct_memory(nr_accounted);
-}
-
 /*
  * Get rid of page table information in the indicated region.
  *
@@ -2632,15 +2609,14 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
  * @vms: The vma munmap struct
  * @mas_detach: The maple state of the detached vmas
  *
- * This updates the mm_struct, unmaps the region, frees the resources
+ * This function updates the mm_struct, unmaps the region, frees the resources
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-
 static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 
 	mm = vms->mm;
@@ -2649,21 +2625,26 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vms->vmi);
-	next = vma_next(vms->vmi);
-	if (next)
-		vma_iter_prev_range(vms->vmi);
-
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
-		     vms->vma_count, !vms->unlock);
-	/* Statistics and freeing VMAs */
+	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
+		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	/* Update high watermark before we lower total_vm */
+	update_hiwater_vm(mm);
+	/* Stat accounting */
+	WRITE_ONCE(mm->total_vm, READ_ONCE(mm->total_vm) - vms->nr_pages);
+	mm->exec_vm -= vms->exec_vm;
+	mm->stack_vm -= vms->stack_vm;
+	mm->data_vm -= vms->data_vm;
+	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
-	remove_mt(mm, mas_detach);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		remove_vma(vma, false);
+
+	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
 	if (vms->unlock)
 		mmap_read_unlock(mm);
@@ -2711,13 +2692,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		if (error)
 			goto start_split_failed;
 	}
+	vms->prev = vma_prev(vms->vmi);
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vms->vma;
-	do {
+	for_each_vma_range(*(vms->vmi), next, vms->end) {
+		long nrpages;
 		/* Does it split the end? */
 		if (next->vm_end > vms->end) {
 			error = __split_vma(vms->vmi, next, vms->end, 0);
@@ -2731,6 +2713,22 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
+		nrpages = vma_pages(next);
+
+		vms->nr_pages += nrpages;
+		if (next->vm_flags & VM_LOCKED)
+			vms->locked_vm += nrpages;
+
+		if (next->vm_flags & VM_ACCOUNT)
+			vms->nr_accounted += nrpages;
+
+		if (is_exec_mapping(next->vm_flags))
+			vms->exec_vm += nrpages;
+		else if (is_stack_mapping(next->vm_flags))
+			vms->stack_vm += nrpages;
+		else if (is_data_mapping(next->vm_flags))
+			vms->data_vm += nrpages;
+
 		if (next->vm_flags & VM_LOCKED)
 			vms->locked_vm += vma_pages(next);
 
@@ -2754,7 +2752,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		BUG_ON(next->vm_start < vms->start);
 		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*(vms->vmi), next, vms->end);
+	}
+
+	vms->next = vma_next(vms->vmi);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
-- 
2.43.0


