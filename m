Return-Path: <linux-kernel+bounces-368341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E19A0EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6D11F238B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6320E02A;
	Wed, 16 Oct 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dAu2lclo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bqE+/150"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF43754720
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729093210; cv=fail; b=e2yRp1crKmf3BSPcgvhgitj5evb7qWTR2glrYPXYiFvZt4nRYZXV4qwzX5AAe5Az93csxpzEHXwaLdUaJHQ5FNi2oAZWNDA1la/U3S09FQZ2Mi/PeUXp8s3qqwkIqP3AIald+v3gYERSzSiSpUYAHvPMDsm5LoMW2UR6KA3sqq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729093210; c=relaxed/simple;
	bh=F59PdbrdYlj6sSvzkUJzM0VFv7jgH8yjxjfhSy+UhH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rn1V07v391AXD8mmkq5QSrf9aL/e4ytJBHudVaTr/vEINZhrAFafo57y6WobyCgA8Gk2JMFjYAxDcw8wgPyUYnOn8i0smm3r34W2L9QLCHvXQ0AwF2MFeYagEVfdZRpjtjvVSpsHNxW272JsO2jUV1nblKfnhA3+wIBPTOCbkDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dAu2lclo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bqE+/150; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GEBiO5030998;
	Wed, 16 Oct 2024 15:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dVaBCiQLYnAlaSAxNE
	WGMDgX81lQ4/liSxNX9H5dLOQ=; b=dAu2lclozhce34Pgdl6ZcasxYHI4MwKbzI
	Bc8WpjP0depQ3UlgMQnbMmNTBvmNR8Uq78SNkLipkrrS3CR8tzkChy44K3Uw4M0A
	s0UR1KE27sWttgf5sc3Y8f7ufvxz1B3pChG2PcxIKHEDB0aXJESSj+UBSwAVeOBV
	6iEPJPMjyWqLWv6zRwOMiuGWS4qGmQ3e0EvqLN81hwVMmCP9Pg3cBjaLc1jc6Lq9
	u5XRJipWRkhZX7IC9kPjJz31LEMRodL3fsMm36kmTsWmM6LoaPMvHOfimY2CNqcE
	hMPLSr8nK9Qdk0uAPKZ/cXm6mcodBZhigQbJ3yhR/rZQlQ6PyJnw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cmeab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 15:39:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GF17Ij036017;
	Wed, 16 Oct 2024 15:39:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjfd0d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 15:39:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2Zq4dEK8NUyLUOJpiA1B0FIn7fZeg51kRuiqGF6QDoRlbcA8Up/VhuoosMiHFbzSoDgtp00jMU+hwBJyzu53qzcccVRz/3XlNcq5D1nfrnKiEoOwjq1vZ7gsVu8/PblyLOYIpNeLbAQQ16cjrtH/fYdJDzWga5PWVMX9+BXewis4mrN6dQvw2huGX+1Ce2mHyFvIUReOEkbWWJ+UG76HRPxu0OMJT8IO3J0XsKfLJpq0g4WmV/u/YkU2Mw1upoI+eVc9z6RTkhKZ1CBpEoZYnxSFzYKoxcQNvpSgH4Ds2/F0qCjVSM51qM+ikOSfhAhInOKezXX+9jvvH5WWOo1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVaBCiQLYnAlaSAxNEWGMDgX81lQ4/liSxNX9H5dLOQ=;
 b=RUULb/7o2cjWVlKPkeo21OY5zaeLtPo/qvodd3NIpW1sRNN/XlzRhc3j/V+6qlzUsgKgw3Y07kh9+Cv2tyoyvM3kI3vUbyXt05+8CVnFZ2neVlNJyGiIW/ghBOGAytJReJMLk3D5Eb4p4fWyi16I2knmT+AWV4/yhEyFQfuoJl5oObgYMaiLHHdswKO3jtn+Xx1SxLOKicN2n2zRgqpjuCYph16tHWQEkhcj2pqvHKKRuvJXquk/+uVJDFDkqngUuHNwIJbgTa2//yBrmFgXPMHoq8yo9KdSZaqY0TXoF2Xua0pJ2oJtblCdiSVsGXy4TR3fLQ+TZNmVefwT8TTvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVaBCiQLYnAlaSAxNEWGMDgX81lQ4/liSxNX9H5dLOQ=;
 b=bqE+/150zDqA0lFJN5dzwbjVcrpE3B0leTkCF5IdScs7VEJydzfJC0ElGD/ah2igwD6RHDniCJPXYxrDiex63+VVUwDo0cZetF0kfQvemPkAPsLj5DxK6D5nt7PNWFLT7dhqRh46re2AkF3WKv/ITH4YtYPGNBfLp98uQv0KWFQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB5686.namprd10.prod.outlook.com (2603:10b6:806:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 15:39:55 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 15:39:55 +0000
Date: Wed, 16 Oct 2024 11:39:53 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH fix 6.12] mm: mark mas allocation in
 vms_abort_munmap_vmas as __GFP_NOFAIL
Message-ID: <3lixuwepwvc6zqy57k2zcw4dntd7cc5cwlx7xxoieuo3pvaajy@e2p5zf5mdzon>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20241016-fix-munmap-abort-v1-1-601c94b2240d@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-fix-munmap-abort-v1-1-601c94b2240d@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0226.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffd749a-6caf-4344-722f-08dcedf8c898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lJ652F1Q3PwkxR123HEV0i5PyuaxeZoheQ2RhWeYDNjUWSwzb8oFXg+Vmi/0?=
 =?us-ascii?Q?IIeV5wBGlW5SosA9HVMTe7M5ebBGw4vlRzm6sxrv9eE7qcNTf6TW1Hg4zlYK?=
 =?us-ascii?Q?i78oj1tNILr546r3bUcAeJSpcUMvNTmaRrsUu1jLku6Jq9rke9qutNebSOVg?=
 =?us-ascii?Q?eFWOyavGACQb+B0jxeRECGfqN3Iwew3+wpsypOaUt35i8ZC9ejliJbDaaD/J?=
 =?us-ascii?Q?bqM25p+OQ3rKJm3bR0WAl2B8aTBgUEeRK9RBwTj2YOw+JwOqZrFPo9OpTyyE?=
 =?us-ascii?Q?REMgeGJiH9C4VZp6yedztQNilrq1g5iMux8Z0ypkqfyW8M5gDGD6A8dXya04?=
 =?us-ascii?Q?AUarE58tU7MlGndq3dktGSM/4wGLLRvvGu83IurbOPSvuCqW6X8otD5adjOF?=
 =?us-ascii?Q?ZCJRDNz/fSjYpHX2UrMUd8/uXpChOoiTZyYzIXuQ5v9KkVj24Goez/u/MOvG?=
 =?us-ascii?Q?D0evKbOqgibbbcqote7yNOhcPNybeziCNCUrF/O91Eea5G9cfJkbhxOFCc5m?=
 =?us-ascii?Q?2A8cvYRCb4gnCcZF2Yn35TLbDN3JgW04Zv3+8j62W77gSojob2veU5weQ/EP?=
 =?us-ascii?Q?x9pWhMTGHHZoghXEhgZ0mWxMzHS8lQWfFbezJ6bDni+0drPaeIqJD3EWXiG3?=
 =?us-ascii?Q?s3uTjQxgxqKnw8LcWm2uIe3vP75a9ZzRampRDDCGiAuczmoZ/pZ+Eh8Rs5Vx?=
 =?us-ascii?Q?A83tSOuOlR8PI0z6PVOU2vKqtgWX57l+GPMa9QCnKPJ/QJ9wjkXSPUyPT0oo?=
 =?us-ascii?Q?XVz+v8g2t2QU/gVCWMD8PrxgxDY7hQVpgKHE1t+RbhFTBwA7IIuhwA8lBGhi?=
 =?us-ascii?Q?jkYCwkhpceeIy4G1LZhOuUCDdjEbga8U3GgyVAuRg/mH7RqcMBn1Rm5uuz8Q?=
 =?us-ascii?Q?5GH2O9Cvurzigq6RArBmRyIN5/NPohvRaVZWP6+eyqA3wV30MzuW/u1ATbcl?=
 =?us-ascii?Q?GiMh2l7+/vQJBs/5q6fzwcqYKteSFdvxI6JA6+J76MhOJvvdoO8SyNB3avxy?=
 =?us-ascii?Q?T3IRE2lvyEx7dy5T3zMmJyrgbnxj3/w/9wcpWXLnXLaIuphJOGuCpki8lJMD?=
 =?us-ascii?Q?c5oPt82XklBm1opgl9rlLgTgPQF4k0+oFyGWq8nCwhRC7c2ScBGz/7G7mezq?=
 =?us-ascii?Q?fi4+4axm96hNT8ZD4ZkE5RMoRQIVnvs86evp+MOuNW2zCXMM9QaxMAW0cRCM?=
 =?us-ascii?Q?81Hta9F9s37VmG5heEL1PZaUm5BaHzU5L5aydIc9a2Crgfqr4oYkaYsgkbrg?=
 =?us-ascii?Q?0XzAzAiHetE6ThiwneNgkt2QX+5HzOgFwkqg679WUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bAxS1nm+FGemzw3NfHMmoYEBUM49saQxW1tE+uqCvTQ7gwth2kGCWBoUe/GT?=
 =?us-ascii?Q?vqmqNIEF4Qbm1PWNAay0BCNSH6MjSoaQXcdfN/DHUyzJKx5wGQITYmbzGC3q?=
 =?us-ascii?Q?mrnxjR3jp4cQ8D12vDq/Gm+gb5kuMxALBRONxGE5xWAslAkCAgOZhTvhA5uf?=
 =?us-ascii?Q?oGkgTKey+zxmmZrCSkTWUq0XpwU0PErUu/fOJyBTD6htAL0vZ7qubi6cybUM?=
 =?us-ascii?Q?lmlT0IT9vIDNq2xYfmXMPOoK2XQCXFXkAgWiz0z213wgMlWLg9CCyGcmFF+e?=
 =?us-ascii?Q?Aw8Fz15Z8GpAE8QsJnKqDcshTH2mI9DYN/KTI9bAIf8ru2ShSEhopqoZGVjI?=
 =?us-ascii?Q?R4T22ZJs5tY2I5RSnLuXfZFRYKcVS5KX4GrvtIz91DrC2bEzigulLkmILnDx?=
 =?us-ascii?Q?x69NqnMGfTKM6vnFFZkiyDfJw7PBnC+adHHcCAVRNA1b1+0vccX2aL0LELV0?=
 =?us-ascii?Q?g99B8CXV3fwRwzcIVu89qtgomzMMs7Mxl8YWWpcZuuNHaQoCLq7AW38pHBa2?=
 =?us-ascii?Q?/xSvePENW2IRI3r3erWrLFuTSW9x4QYxx2dief5wHkPn4O6XF1TnPZCCmpAL?=
 =?us-ascii?Q?G3s1CgKIqsv38mPqnn53PLo9nXE7Hqkl6NlAECC+f/Y0z6xLc/RvEfJMDXOg?=
 =?us-ascii?Q?+al/fiPQcmAg0H8xm1oqKEJoIKoS6ng75XL3F8hhWGD8/XEMxP3kyDQkI4S7?=
 =?us-ascii?Q?Mt9AnEm6EW22QYRI0wMcjhRC5UTA/Fh6IuiX6h9ohqTieT7q50hWpkb2ZGz1?=
 =?us-ascii?Q?Sd5JofXwEHTVspXqhDN/2H2n+JpbYHKMlq/5mJr6jySc/O2W7NzJXaFjGGyi?=
 =?us-ascii?Q?1fDm1nUflAToGM8MV/quB9MCRIlf+Paa9qY1U9cqfpzGDcgtP6lL3yeYqoof?=
 =?us-ascii?Q?8s34XMs50+s276pc1MTSiJLGoUHbUFWxVpmSoRCc+wXXwwupCflrQVjL6+P7?=
 =?us-ascii?Q?Tjcnm63h9c+ZFwRC/cbWlT5NSvr5dzstMwrnNxGPEXTM0VTCdp17+rjajIXG?=
 =?us-ascii?Q?oE5WKa9iHV0AbsqnOg3zWtu5XZvDDgSz6VcfK557r9keIBiiabHuCXnZvCPY?=
 =?us-ascii?Q?//23uowlOT/+hSDQm8ei17vMPdUa/iPubUW30LCTkal3GxToF8pS3YO4X6uj?=
 =?us-ascii?Q?FGLMxUvFtxWoVkqp09BOV7uhS0v/Mzu8nPW61bTQX4qAf07JH+ALo5bnedKD?=
 =?us-ascii?Q?Vt/T2+2HFmT65DB+sES45tZ+ArRoOoIcOZN8pqJhoujVJOB8bTLcmELk/nMR?=
 =?us-ascii?Q?klw5+sh4HkD6By2l+jm50CBz0fx8M0wSjvmYkRH8TPrPEQGdy29M8e2V8tqP?=
 =?us-ascii?Q?CBeDPyo5UMDYnNw3wP6Mg1hyIwTEwKOi/+poQl3kPzi5THR2jOomAdNLOPiR?=
 =?us-ascii?Q?2tJBHxe6GNrAepN5MNBP4xpA8kylcI++PSOg2CUYs509CuJwLDSvJX3q8Pwn?=
 =?us-ascii?Q?ZdGFBu29OQjOOfGM1GhYAvIhkaey9lr62uUjfiJuosL/TCLR0FxduBWNBJYT?=
 =?us-ascii?Q?UGy7al//1HsApWMUarRAx44TuIGPXzLhZfJaVBfCb1wTS9d6jmnzjxtMdFPB?=
 =?us-ascii?Q?DE2YnyDzSY5Jtb6TSwC972So6i5KiZ8lbie9x6uuzj2bv3hNF5nveBEIy6qg?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T/TWsLHEDWLq7MDydOqgUIJXj1Cw1pgsJy4VNRMee44FcPWdRwnI6xL4vAbQ7Ms7QbleI78eL9xuo6js7/kP3mvFMnWSrbrwenp4EJnUlJk1dJhvyj1U7JWp3tYOMCeeTGJOUp/in+3yzmpqL1jPhXloCjoH1oeIvZJz+lj+DkyB8fPTiGMyuwaK5dMVCw4zLIMcO04LJrM+K6MvM26H0ZfP9ew44uu33Lkwoq8tQ9rWaGZIIsTugy2ZIdHbu4uzHr1MXFD2T4TUM431ZpB1Es4+S7f/QwxKzhPLXqy+p8qXyKrtLG7yM+/P10wnjcBIZ+Bn6dG7ZQ8YA1nXj/nNhi/MugQEBTOeL96jPuy8es88mdKz2tlRHwyIE1VEHM3Sq2C/7m/7RrtZv73ei1ECRRvRbi08hCu8cyFkVX6p4rlK3+WERnWTH54FWvsVqQN1dkX1ZgTC6mv40AWiPLAP6IbZ3v4vj+tbGfInnhpvMHJH2KOSvH260F1EYr2k89zViltTsF9mBOhz4WwiDtz2EBb1QiXcRp46UgPgoIoGEgtLkxd1+vyU/pzldG6gcxeY9fwiQuGET4SMRbH6k96qYAATb6hzeIWFDzPIwZwSLdI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffd749a-6caf-4344-722f-08dcedf8c898
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 15:39:55.4139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5qTbGm02MU1TbvD4o5z0YWRRaPy0qV2/2vlkNj6yL+NRzakt/TvlRLPWqbBTQECJlDg9+vABv03NWp/Ybv4ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_13,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160098
X-Proofpoint-ORIG-GUID: KI2VHkU06hzVSK0oRFRjy02eOlwT8cyd
X-Proofpoint-GUID: KI2VHkU06hzVSK0oRFRjy02eOlwT8cyd

* Jann Horn <jannh@google.com> [241016 11:08]:
> vms_abort_munmap_vmas() is a recovery path where, on entry, some VMAs
> have already been torn down halfway (in a way we can't undo) but are
> still present in the maple tree.
> 
> At this point, we *must* remove the VMAs from the VMA tree, otherwise
> we get UAF.

Wait, the vma should be re-attached without PTEs and files closed in
this case.  I don't see how we are hitting the UAF in your example - we
shouldn't unless there is something with the driver itself and the file
close?

My concern is that I am missing an error scenario.

> 
> Because removing VMA tree nodes can require memory allocation, the
> existing code has an error path which tries to handle this by
> reattaching the VMAs; but that can't be done safely.
> 
> A nicer way to fix it would probably be to preallocate enough maple
> tree nodes for the removal before the point of no return, or something
> like that; but for now, fix it the easy and kinda ugly way, by marking
> this allocation __GFP_NOFAIL.

I don't think that's any better than what happens now or what you have
below.  We have a way to do what you are saying, but it would slow down
everyone for the sake of having enough memory around for the very rare
error path, and it is certainly better to dip into the reserves at that
point.  Your patch is better than this alternative.

But since this is under a lock that allows sleeping, shouldn't the
shrinker kick in?  Should we just use __GFP_NOFAIL for the first store
instead of the error path?

> 
> Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring the gap on failure")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> This can be tested with the following reproducer (on a kernel built with
> CONFIG_KASAN=y, CONFIG_FAILSLAB=y, CONFIG_FAULT_INJECTION_DEBUG_FS=y,
> with the reproducer running as root):
> 
> ```
> 
>   typeof(x) __res = (x);      \
>   if (__res == (typeof(x))-1) \
>     err(1, "SYSCHK(" #x ")"); \
>   __res;                      \
> })
> 
> static void write_file(char *name, char *buf) {
>   int fd = open(name, O_WRONLY);
>   if (fd == -1)
>     err(1, "unable to open for writing: %s", name);
>   if (SYSCHK(write(fd, buf, strlen(buf))) != strlen(buf))
>     errx(1, "write %s", name);
>   SYSCHK(close(fd));
> }
> 
> int main(void) {
>   // make a large area with a bunch of VMAs
>   char *area = SYSCHK(mmap(NULL, AREA_SIZE, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0));
>   for (int off=0; off<AREA_SIZE; off += 0x2000)
>     SYSCHK(mmap(area+off, 0x1000, PROT_READ, MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS, -1, 0));
> 
>   // open a file whose mappings use usbdev_vm_ops, and map it in part of this area
>   int map_fd = SYSCHK(open("/dev/bus/usb/001/001", O_RDONLY));
>   void *map = SYSCHK(mmap(area, 0x1000, PROT_READ, MAP_SHARED|MAP_FIXED, map_fd, 0));
>   close(map_fd);
> 
>   // make RWX mapping request fail late
>   SYSCHK(prctl(65/*PR_SET_MDWE*/, 1/*PR_MDWE_REFUSE_EXEC_GAIN*/, 0, 0, 0));
> 
>   // some random other file
>   int fd = SYSCHK(open("/etc/passwd", O_RDONLY));
> 
>   /* disarm for now */
>   write_file("/sys/kernel/debug/failslab/probability", "0");
> 
>   /* fail allocations of maple_node... */
>   write_file("/sys/kernel/debug/failslab/cache-filter", "Y");
>   write_file("/sys/kernel/slab/maple_node/failslab", "1");
>   /* ... even though it's a sleepable allocation... */
>   write_file("/sys/kernel/debug/failslab/ignore-gfp-wait", "N");
>   /* ... in this task... */
>   write_file("/sys/kernel/debug/failslab/task-filter", "Y");
>   write_file("/proc/self/make-it-fail", "1");
>   /* ... every time... */
>   write_file("/sys/kernel/debug/failslab/times", "-1");
>   /* ... after 8 successful allocations (value chosen experimentally)... */
>   write_file("/sys/kernel/debug/failslab/space", "2048"); // one object is 256
>   /* ... and print where the allocations actually failed... */
>   write_file("/sys/kernel/debug/failslab/verbose", "2");
>   /* ... and that's it, arm it */
>   write_file("/sys/kernel/debug/failslab/probability", "100");
> 
>   // This mmap request will fail late due to MDWE.
>   // The error recovery path will attempt to clear out the VMA pointers with a
>   // spanning_store (which will be blocked by error injection).
>   mmap(area, AREA_SIZE, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, fd, 0);
> 
>   /* disarm */
>   write_file("/sys/kernel/debug/failslab/probability", "0");
> 
>   SYSCHK(munmap(map, 0x1000)); // UAF expected here
>   system("cat /proc/$PPID/maps");
> }
> ```
> 
> Result:
> ```
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 100, space 256, times -1
> CPU: 3 UID: 0 PID: 607 Comm: unmap-fail Not tainted 6.12.0-rc3-00013-geca631b8fe80 #518
> [...]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x80/0xa0
>  should_fail_ex+0x4d3/0x5c0
> [...]
>  should_failslab+0xc7/0x130
>  kmem_cache_alloc_noprof+0x73/0x3a0
> [...]
>  mas_alloc_nodes+0x3a3/0x690
>  mas_nomem+0xaa/0x1d0
>  mas_store_gfp+0x515/0xa80
> [...]
>  mmap_region+0xa96/0x2590
> [...]
>  do_mmap+0x71e/0xfe0
> [...]
>  vm_mmap_pgoff+0x17a/0x2f0
> [...]
>  ksys_mmap_pgoff+0x2ee/0x460
>  do_syscall_64+0x68/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [...]
>  </TASK>
> mmap: unmap-fail: (607) Unable to abort munmap() operation
> ==================================================================
> BUG: KASAN: slab-use-after-free in dec_usb_memory_use_count+0x365/0x430
> Read of size 8 at addr ffff88810e9ba8b8 by task unmap-fail/607

What was this pointer?

> 
> CPU: 3 UID: 0 PID: 607 Comm: unmap-fail Not tainted 6.12.0-rc3-00013-geca631b8fe80 #518
> [...]
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x670
> [...]
>  kasan_report+0xf7/0x130
> [...]
>  dec_usb_memory_use_count+0x365/0x430
>  remove_vma+0x76/0x120
>  vms_complete_munmap_vmas+0x447/0x750
>  do_vmi_align_munmap+0x4b9/0x700
> [...]
>  do_vmi_munmap+0x164/0x2e0
>  __vm_munmap+0x128/0x2a0
> [...]
>  __x64_sys_munmap+0x59/0x80
>  do_syscall_64+0x68/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [...]
>  </TASK>
> 
> Allocated by task 607:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0xaa/0xb0
>  usbdev_mmap+0x1a0/0xaf0
>  mmap_region+0xf6e/0x2590
>  do_mmap+0x71e/0xfe0
>  vm_mmap_pgoff+0x17a/0x2f0
>  ksys_mmap_pgoff+0x2ee/0x460
>  do_syscall_64+0x68/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Freed by task 607:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x4f/0x70
>  kfree+0x148/0x450
>  vms_clean_up_area+0x188/0x220

What line is this?

>  mmap_region+0xf1b/0x2590
>  do_mmap+0x71e/0xfe0
>  vm_mmap_pgoff+0x17a/0x2f0
>  ksys_mmap_pgoff+0x2ee/0x460
>  do_syscall_64+0x68/0x140
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [...]
> ==================================================================
> ```
> ---
>  mm/vma.h | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vma.h b/mm/vma.h
> index 819f994cf727..ebd78f1577f3 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -241,15 +241,9 @@ static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
>  	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
>  	 */
>  	mas_set_range(mas, vms->start, vms->end - 1);
> -	if (unlikely(mas_store_gfp(mas, NULL, GFP_KERNEL))) {
> -		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
> -			     current->comm, current->pid);
> -		/* Leaving vmas detached and in-tree may hamper recovery */
> -		reattach_vmas(mas_detach);
> -	} else {
> -		/* Clean up the insertion of the unfortunate gap */
> -		vms_complete_munmap_vmas(vms, mas_detach);
> -	}
> +	mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
> +	/* Clean up the insertion of the unfortunate gap */
> +	vms_complete_munmap_vmas(vms, mas_detach);
>  }
>  
>  int
> 
> ---
> base-commit: eca631b8fe808748d7585059c4307005ca5c5820
> change-id: 20241016-fix-munmap-abort-2330b61332aa
> -- 
> Jann Horn <jannh@google.com>
> 

