Return-Path: <linux-kernel+bounces-257765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A083937EA7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 03:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC8A1C2140D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE14279DF;
	Sat, 20 Jul 2024 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hZMsKHaV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g4/eCaEP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9863D66
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 01:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721440770; cv=fail; b=CKVgf5E7IVxLj/g8DiFaqycqQg3sIXqc0oc6bpJUzmtd+0dRH/uZBMMtryVBE6DLTb7AFsuQRqR8DpNN4tVh+UxDfD30BJikv0JEBSbfLCKTEP/2FA200BjO+uyoi15E9xLHGNv9WSk68OTlUu4z8b+JdoIlBXKPHUhDU1VlvI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721440770; c=relaxed/simple;
	bh=+ThbXGhy52rBc+JSVxoPMAKfpP8dzZTaPfDpF8sGk6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KB4/3Pxvt7SrD9cvB4ZlpnAl45qhs+rV9MUOc1BWEMkiV1DKj4GGJgF3kJG0Uh/YXHWtWF0Y7CYyosMSgt/FfaEVB2vhzsEaoUIGkUDQgcWQWZFyRFwnXU3OZZoU5+mwtrFpdLWznyw0BHcn5GP+iSTpgB2pV/7i8m0VK4t1Ih8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hZMsKHaV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g4/eCaEP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46K1uDth028402;
	Sat, 20 Jul 2024 01:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=6H/gSHUlmCQc/Aw
	TKEUkpqjPkoTeXqXcUoMZBambaaQ=; b=hZMsKHaVJVB/B96+ZcKbJgCcxuHTK4G
	VXOk+kbsCYAoVU23r8XYki041W4YyT6hbtEtl/FLi/OnLixZtTYKUCuTaNokBrlO
	jGrSVyYg2oOE70035g5VObbmBljHAdD5f6YP8TdhB1tCI8SRQ9G0ka39RQNPqj3x
	beTsiLXuIbwkypbOpTKSc+iU2HnWMN430I4qlxL1vlec4xGEk5/HvwKQzm90o+NA
	6FwTWwM0H9WNF4MyCgNvdgD/Nngu8aPz3v3t/QELggkSNf0hNan7Dz0qM+06Mq04
	YbYXQsZCiQdXQu3322+1gESk1gAXscGqutVy9bfE+0cZFmMSFixC1mg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40g40f001u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 01:59:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46K1Xuf3015901;
	Sat, 20 Jul 2024 01:40:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40g3p582af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 01:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+ssinb0uPWRbxqFnKSARGLpPx8t0O3ScgthDzVDPhQkp6O4pghSeOedbJC8MEX92NJOZSrnfPDrl+2V3wimcfuzdN+Rl87jPd07v/0xO7HYP0Lu3MzLQFaYwdeSwANwqjd49CvVuVNoyJgISdYB1ChvkZgZgC7DyhaOb1qNKUxywua7fnyUUyRDKo4xiW8eBOzXWyLllnH8m9UkQRJpPC9FqEaj5iELEtY1fRwveePXxGx3By5BeSLDTQtRQQ08gscKsIMPO9+QN6d2o/CW5UMgyLgev+BfhI0fLKU9fiKlynQwNPAIbAIPDeC/O937cfsQarL2N/oKkax5F7bczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H/gSHUlmCQc/AwTKEUkpqjPkoTeXqXcUoMZBambaaQ=;
 b=Mqph0x4uDG44VlHGp+XTyVQN330PZ68ChNdxkQEbqSpMuj6YudF/rMKv2vNrm7zA9sk54CSdlIsdbz1He95dBmP2GbCCqPJvMAqgtChVmbhkM6K1b6vCIbUKwVLlyG37mJ+XdPp/t6w429FTOEFfCr8R+XHY9JOvjZ8OxzVADTLkt6dVPtC6BsOC5q+ukrydM6clET0IH74trSBek2Welqae9oKwm+SxPYd+MOtOYNFa/X741R2Wlx2M5mEPZ8g/hpgeRvOT+V2vyFR7cmZp9sGJ56aF/Ep3pgUcWZ9gYFvhp1GeOwB9ehMz3Boc5dPtFuNWPoXcCIY6MDor6MHBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H/gSHUlmCQc/AwTKEUkpqjPkoTeXqXcUoMZBambaaQ=;
 b=g4/eCaEPaJznerxrSS4Qe+Zo3IDkF2YHaUJTB31FXla5g1dVdO2t21plapPuiqOvi2PTCOQbi/QkAYt2ODD7NV/tGX/TVeiimjwNo9HjSZjhkTYwRBZ8t12SUR1kHNqlU4sPMDjLKFvBk+ljoAWs0zKxVQdbfZiDrsUbF/r01Uw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ2PR10MB7039.namprd10.prod.outlook.com (2603:10b6:a03:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Sat, 20 Jul
 2024 01:39:59 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 01:39:59 +0000
Date: Fri, 19 Jul 2024 21:39:55 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+c0f0941337ade4c26ed1@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz, peili.dev@gmail.com
Subject: Re: [syzbot] [mm?] possible deadlock in mmap_read_lock
Message-ID: <v6jvhxxb2t7dh5ox6feqvc3xnlkgjwrdofkxodmg3t4rrtew2u@hxghrcqhk2n4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+c0f0941337ade4c26ed1@syzkaller.appspotmail.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, peili.dev@gmail.com
References: <000000000000d8474e061d9f28be@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d8474e061d9f28be@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0356.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ2PR10MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: fd836d97-8d9f-4496-e938-08dca85cdd96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gWVss1Vb8wHeNpeRaeNWcz3fh8uXcy75kqtDbhroOVqOUnwIjbc3ecEA/lcl?=
 =?us-ascii?Q?O3rXlW15yzzpquOajB+gcJMv1/xa72NVXwxjIbQUcyRYSYKT3OWV1LTPBV8m?=
 =?us-ascii?Q?XPtXk8NZxPQRIlFTrbmRl4Teym1VzFPMWS7tL2QOG7+kZjeK890iN+lq7IQG?=
 =?us-ascii?Q?ObEnjZeroSCRox5qgNVWWtpxid/4NnWLbkv7QSAFQtvGY/ogzWqbSRs3jDXp?=
 =?us-ascii?Q?HcW/jGrBr0iMy6PAvpDgwh/6zfXkEr66+pCX77RzaNC4ymCaEHdgLAN/U1fl?=
 =?us-ascii?Q?evRWJAj5lQ6NCTlHUHTaxq8zCd3QFs0szqQKrX9gxhrpzfKbUpUuVqNGnJJb?=
 =?us-ascii?Q?s4A0qmO8ahNof3DchJByOdttz3ZqqAXdexbZ6RkpRsVD/er4EwuNe+aGsXtz?=
 =?us-ascii?Q?u8N9MuJIV3D7vXcbeb0gnvZLX6K21npT5Hs01c0L5OBonNXOdripqgR79S32?=
 =?us-ascii?Q?kdITJsX9Z9fsgf1/IZ1usD+lQ0xcUlW3u8+1EzsRTAe0BZy79AKlcIxRdH2b?=
 =?us-ascii?Q?W2djEdZJTDQl5ju71OpKjJnLW6DgzV0+SAxi1da01ohJHhszLB9bl/aymru+?=
 =?us-ascii?Q?umUPprBYw0vDtzDa7EZiG3uLkalwIk6Oy7f5jZKpuh6MqBK7sw39ecdZxA0D?=
 =?us-ascii?Q?D4ouVhiddaJZfe0HzYvuvKVyrKC9eUsr2VN19DyeX4SEXVMKowRs5DnsBeFD?=
 =?us-ascii?Q?RWbsV7QwkZdbNj3HSKBRLp/Jgs3KVyPkp6fRVrj5Sl9FWSqQF4L0gcIYlHkK?=
 =?us-ascii?Q?aqLDtmdwhQWgYVgTqwKYE4bTN2XwlS8CCd9nXQfeoHOLuOMKr8TK0cD8SGl0?=
 =?us-ascii?Q?FAG3D4oTDCn4z0o2XImb0QMTMCTc3GMXmJVcKEEFfOzrpLBM/RJ3oOl4PV7w?=
 =?us-ascii?Q?XATB08MyVGi5YwGWm/gdWrInAVqQO2P0YwfoMedMPQltQlLheujJg4qEYurd?=
 =?us-ascii?Q?iOpodBOM/pBhOSdJNiqePRlzZK6n3Fqfa0kLGKHE/EDUbnBZKWvK7cv/sDFl?=
 =?us-ascii?Q?oz2ylENtqc9U5MMKYsrjup8z1R/sKob/o6ArpBnxcQLPXTPXsjKEvDbO9fkP?=
 =?us-ascii?Q?1eHh2KGV1UenILvWm58dcw4oOVM95gUCrNU42i0WAdlzK3XtlyokdM0sLxlv?=
 =?us-ascii?Q?aec/0SSKXS1plcXYA7qgT9u5rmv+WRcVEyGfngGFrjYWzo01+qsyei8ruqhw?=
 =?us-ascii?Q?sNAXF4plg01qC+qts/8fFXsbsrBKGbgjLnu0rwpDgzUf8/iNCkhZ96WEMmzi?=
 =?us-ascii?Q?rz/kqJVBsI/G2t6SHZcRDTFKqBVWpTungDCxaaMHTINABXYWcz0Q5O+iZ0RF?=
 =?us-ascii?Q?uqQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0oPz1ejFlT93RNRLDGdmCUFBcwflu2TQMpgLM2NSBvRuev+hb3oXyGRbAPuG?=
 =?us-ascii?Q?zxJK+WU7WYENgS2hY8p1Cq9SFxtFOtZuL27bdusOhzFNcjJQQ3JDibmmAbDI?=
 =?us-ascii?Q?IdIdWXo5hX+Z9M67q3d/npIxOtTSijjr3KJ07qUrrsnsv/wga3lvKo/hHYcQ?=
 =?us-ascii?Q?6eHtJxAOg5eSbWHZYcNJVIOYWgYGdJ3KU3T0vmRFPfWTPx7BSS0+huUNqe+P?=
 =?us-ascii?Q?R6NDlsjy6Y73bfZ2pz62RCJrzRqVWJTp5OhtXveqJroVQ07r/ZPskKGwfM/6?=
 =?us-ascii?Q?JfX6c5loBvDnwAZD91cx3QLALKB7cOUxzb13CDm9Mp0apMATv8+/5TK7d2Hb?=
 =?us-ascii?Q?IBuMVFyuuogfvzeqJctBZr2Uah9pv8XD1yvPpN3ymFsekci9jXKJE+d3GQ0g?=
 =?us-ascii?Q?u6BfclbaH9eTXjkqLt7znwt0fML5JMjtqL+p0cOTpnpJYKdEMxajS8BFZ+ox?=
 =?us-ascii?Q?/A7I424N8J/2MOcMYSOIRQK513hGwBYRaV7OkBekcupFeJx6x0nRKHOyXLxo?=
 =?us-ascii?Q?3Ae2vuqQAutzeU7QuGQzukzJ2gSFS5LbWBF2KeQ4eiV/YCnma2P8TnnDakF/?=
 =?us-ascii?Q?4le5Mlrf0pFVUU0BPSuzDFO1gdSb9oiShP9HiTLcDyfGWV5OJYF9BMP4Cd5Y?=
 =?us-ascii?Q?RQdM8Wa5Is6sf4pvIryLEqsBtNm49ADPq5KMsB4JFQVsGzIRgfWVN72LtY/8?=
 =?us-ascii?Q?3pp/ojbAOqkGqz40f4Lr9449iWNoKG/cpUtgiU31Zz6t5mUCx+eIIyN+Cf0s?=
 =?us-ascii?Q?eqF7F2EGKF0qCarTWnpSYp7UmLczeowJTiaksC/mNtTyU+RVw5h9U8fiUDS7?=
 =?us-ascii?Q?otuuO5deX7zApCPskl+nyHjhZjrmvAGH+sBwpJ5gDiis68kSAu78jmtxcvKi?=
 =?us-ascii?Q?gNk4cz0D+ivWFMvZRiupDGPJNzn+mcr9rgZCjDPPIfY4gw2flAoX6TzH+OFS?=
 =?us-ascii?Q?LmhFEeU7P7+79zr6YVgRs0hC6ePOZR0nrtjkELEDXYf+FmXqgCvWrV09Y10O?=
 =?us-ascii?Q?A/KoRdai882YvrSfSR3OERFqEhH01zC3DRKrJh94/Fk10MyKMqgOr0II5FbY?=
 =?us-ascii?Q?+wCMX7WkFSCraISidna3L5HTqqoeSDq0TZBP7s95qKrDXHpfu0kCHoPbFcEf?=
 =?us-ascii?Q?cPP2Un7PH6/h/87yezymiicfca86WeRe91fgcYtVyp8xE/kaQCNWFPVQUYBo?=
 =?us-ascii?Q?rvRSxl2mC2aXDKqWT5bTGTc+nrE0mC9uLJgOrexHeUsprVDrnF1VodGh7jYq?=
 =?us-ascii?Q?Q9n1lBtBIlj2//4FiAa5CdRYlgJjINQwbq2m8itnKZhpdrFuoZF9/gOgsbjr?=
 =?us-ascii?Q?2MEpoS2+77IwLX2ZIYpV7htlzuo+8wpjePugYqR8sNtyX+FTeQyJ+pfLbQG1?=
 =?us-ascii?Q?GIh8S0P80akuCNHkPWqWP7flTuyEdfuPLDw97r2BLcteaXdV3ZS7WhIXLZt7?=
 =?us-ascii?Q?TaK0imF9Y2Ogk+Yyj0DwintqLy+gjRr6gi6Gvusv5ErQRVYvYYl0mHsU5xpB?=
 =?us-ascii?Q?vuwBrpkU1S96tGeWVx9XRv3wuOhqlv250RPTc1m+3bOSyd1A4VpeLjHrOtSN?=
 =?us-ascii?Q?//Hm+zME/j1fFBzXr7htaxhyiPriAF66ikohzvXH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PteUySSUn/xjVZa4GG63XMTwhCKiJ9F13uvS8tpJP4dx13crQM3+z4cRtuCM2GcG1TgfkxAd5mAWPp1DfvXsSC453MPDtqLwh0gUKPCIy/9MgzrgEauH0p5cTfVz+8/XqeW6P+nvlndItEJOO8qYI+xyf0bwMhnO6ZR68Z8aY/3YjBOa33lQZXnVB3+cW2lhu9exVBytH4MxxLxX+i1UHAql9TUEwx6epD4M7CuSlgvMykhK+o9lb0vjI8PCMSfMA/MzAvGhVe3hGrTXofShnfA8qe4C7O5epwfoh5wg+93CxD36963G6vgeo6FpFk1p+tCIKJSLjjJVZru6z3P7kodyEp/Mg+dNzhXyyQkDGdWxibLYyZbJEsRBK7xHtd+BYwEI/L7d7viM3U8awk3DsXajTj35Oaimyh572SFwENgACci/B3FZrpMzD1ieuzKpWwynjBaxtrX7E83PfPkzUBEUDjslCBXaY4vs4BmPcOeOHE+5HbJrmsOTUdmgiXLesjRoWWzT9om7+XlvZb6RdxqbWSTesI6iGvbXyZfMwP/q8e6SjuNOvu3OCKVKN7E0yRbIQWqC/cP4fu/l7RJKY4c1ITQgcUKxrRsjQYidNp0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd836d97-8d9f-4496-e938-08dca85cdd96
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 01:39:58.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwmBtnnjy3xPulVa+IkRG5IYXwLRBObDBZfpNIOQOyb8P3V51XYJ9Pykflb3x+0fp66QLtwpyKBCpYr4qOBg4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_11,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200011
X-Proofpoint-GUID: mH-G0e6S50vORdlf9tcD4Z_JfybSYx4B
X-Proofpoint-ORIG-GUID: mH-G0e6S50vORdlf9tcD4Z_JfybSYx4B

* syzbot <syzbot+c0f0941337ade4c26ed1@syzkaller.appspotmail.com> [240719 16:01]:
> Hello,
> 
> syzbot found the following issue on:

This bug doesn't exist anymore.

> 
> HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1769e695980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
> dashboard link: https://syzkaller.appspot.com/bug?extid=c0f0941337ade4c26ed1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/8c6fbf69718d/disk-3fe121b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/39fc7e43dfc1/vmlinux-3fe121b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0a78e70e4b4e/bzImage-3fe121b6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c0f0941337ade4c26ed1@syzkaller.appspotmail.com
> 
> 
> ============================================
> WARNING: possible recursive locking detected
> 6.10.0-rc7-next-20240712-syzkaller #0 Not tainted
> --------------------------------------------
> mount/4518 is trying to acquire lock:
> ffff88801d2b1498 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock+0x1c/0x60 include/linux/mmap_lock.h:144
> 
> but task is already holding lock:
> ffff88801d2b1498 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
> ffff88801d2b1498 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x159/0xc80 mm/mmap.c:3396
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock(&mm->mmap_lock);
>   lock(&mm->mmap_lock);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 1 lock held by mount/4518:
>  #0: ffff88801d2b1498 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:144 [inline]
>  #0: ffff88801d2b1498 (&mm->mmap_lock){++++}-{3:3}, at: exit_mmap+0x159/0xc80 mm/mmap.c:3396
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 4518 Comm: mount Not tainted 6.10.0-rc7-next-20240712-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3034
>  check_deadlock kernel/locking/lockdep.c:3086 [inline]
>  validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3888
>  __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
>  down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
>  mmap_read_lock+0x1c/0x60 include/linux/mmap_lock.h:144
>  unmap_single_vma+0x2a0/0x330 mm/memory.c:1832
>  unmap_vmas+0x3cc/0x5f0 mm/memory.c:1904
>  exit_mmap+0x264/0xc80 mm/mmap.c:3412
>  __mmput+0x115/0x390 kernel/fork.c:1347
>  exit_mm+0x220/0x310 kernel/exit.c:571

This is discussed here [1].  There is some case where unmap_single_vma()
was reached without the lock held in write mode and the flag seems to
have been misunderstood.


[1.] https://lore.kernel.org/all/20240710-bug12-v1-1-0e5440f9b8d3@gmail.com/


Thanks,
Liam

