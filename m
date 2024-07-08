Return-Path: <linux-kernel+bounces-244662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BBB92A78C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27069B20EC5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58BB148313;
	Mon,  8 Jul 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bD2TjD+g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qa6hFxrH"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BB146A98
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720457036; cv=fail; b=HM9p5yBc7VC/HOHljAvFhv3B4xuDLbBaYJfPd52y1NJ0K805pjeLzOhb3cQxFI7R68c2LpiJ9QXx8N9Lr8STGxSAPBGlC+nV5BDiUnX1Yj/WEt5F9Y1KlDJ5zhAFavypWYdw2TbherFPV81YfqEp1MtbB4O3BUCY1zkUAahb4xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720457036; c=relaxed/simple;
	bh=tVtgjEOV3L7DDT8Raw8rlPlrIMmutFNTkM7t1CgNnNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yim+aZeeGzfikEbfHalxum6Jk2FBs6JFXbdxUPolS92eaf1LMptdtaStR8lkiCIOIE133ismPxbeIfhWfEcnDPP5HZW91Q1bTYDqrMI3LLBZgq+BiTRvsMwBrXGOD/iD/Wq9Sq+lvJ5F4lk2dYkc9F5PwYBFOdxCEH038pOKi4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bD2TjD+g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qa6hFxrH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468GMTa0024227;
	Mon, 8 Jul 2024 16:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Uq/8xS3m8fBWdjf
	M4IBwCQyl9tu9whnvPMHvw3r+3vk=; b=bD2TjD+gUJosceTQF9BzworfnaF7Sa0
	QcmB0GIQLOFZA+YrpNXqUOeIyG3zRQ6H/yER419fmtjn1Kw+RNl9vphaFaZa4Ibk
	BmnA/RYFeBnsFmwSWtPYJtiJgUVbUPSdtHj/Saf/jGY7/i5NyoO3pu2Hrp/bAWL+
	OC9kSHDdfG2U4M939orzgh2vZj1o41TxhUPtW/MLHlg8wqNQ080KtAhaVbiwtxGM
	sPa03kFzGzdBPJdnNoV4R7zEizDM/OmzLv8J8P7oTpDb0Oeb8COAT9tDCeAVsUd7
	8EzBTpjuhsvKH+nBOf8ar9Gr3HEq/ESjIIQfkkUxCh6NMwki2cCBarA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknk3sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 16:43:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468GRi41037261;
	Mon, 8 Jul 2024 16:43:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tuyyq2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 16:43:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElQ6Dt0HQye5aksb1qQ6XEvrSC2C6okIUVchbHaB7hby8IVVU6A/TWovsRA2GHe5DL5pbf7hXLMBsSTQdIeYWhbzao4YkcOA9+dxOSbxxjcjq5i9DoraRPOc182CAOr1VbENrhGToZQUt5yBrqnKkLHGlSNjClN/i887zgEdt335gD+za4FHOhBpxkYprvv6Y+viIBl/m0yE0ucGCYjiqAeT/k/MuXtY/AVsc1ZwbjEtv0CMzD45ESv6jqmY17grqFrdFtOVeSlg9XgPmwSIeN9Jjtll4fC3MoDe72ce5HzYTLSTL6qD5iEHqi/XWji4I6fZc6AVkZPahGujIF9MFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uq/8xS3m8fBWdjfM4IBwCQyl9tu9whnvPMHvw3r+3vk=;
 b=P80BGMPU/AYMdiFR8bLmDPsxpO9RqnX+kX2vspLWSGozKmTr+8SYCCC+TIw8p9SYmqp8eQ2HrNJswAA0jzs/ZdnOZVrtfsomVyah2LujBwzoczqZhrKhPLbLCpI4y5cidENIvGfMbubMs7uUqM8oZbHKbMc+i4Kwtik9wtkswWMmroYB6YAKsCqCHFSottT3Lf8GmgytOddZfHBQuQHjsTfyD13KTvs2Z0QmfzrOYeeNL4zCkdRIWOfn7314hqFjYaHgVa2aRI2pF70VXFsPqyXKZCzpOmM0TlER6cVOvyRj2QP1bROl7EjwclVMDocIrnD3shPSLHmfQQwPdUEuGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq/8xS3m8fBWdjfM4IBwCQyl9tu9whnvPMHvw3r+3vk=;
 b=Qa6hFxrHqQklPha400ZzlaN5rbEXcrQm/zRnrcFq7ImIcoru6tNM9iGK7lz9Ug1cHSuSl3NBFltU7umUqmr32hdOGX949jLCWXctCt062P3ZGCq09XhV99lcXEWhrhBQOUELCIF0Ci8bYDic8lxqDXQhZdvikBoQNEjR+8Htiew=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH8PR10MB6385.namprd10.prod.outlook.com (2603:10b6:510:1c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 16:43:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 16:43:33 +0000
Date: Mon, 8 Jul 2024 12:43:30 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 10/16] mm/mmap: Reposition vma iterator in
 mmap_region()
Message-ID: <mhhdp7cyzxmyouehu7slrat2x7bg6mn5ba5hsynyaebdxtbj7b@4kavohpgexry>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-11-Liam.Howlett@oracle.com>
 <76625760-1fc6-4c81-9df9-ee47697995ff@lucifer.local>
 <c7vcig3ee4n3zpfev3tbv5epcsdeue5it3joi22iwob5vx24sg@ypl6ienxns76>
 <c894bfb0-8cc5-42fd-ae55-96ac33631769@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c894bfb0-8cc5-42fd-ae55-96ac33631769@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH5P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH8PR10MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 9032e055-387b-42f2-5a4c-08dc9f6d1b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xAkV5JBG+/vUBzX4M76t9SFzqLCVyjQpKFRrUxJyhPp6hJqwHQrHV1K+JUEx?=
 =?us-ascii?Q?lW+T7EHCwMwCm6EXP0nfgGINjOKgpc4/NoMu2FOWQ4StOMpxeV/nBKGafzHN?=
 =?us-ascii?Q?LRe+wTAoV8tyKyzPhGEErgUANcGch3BpNXSCbtwN4H+pL9soowq7aNjxUrSP?=
 =?us-ascii?Q?KakR81gAAK3Mb7CDtpqy5+jC3lof+z+69+ViihdIclPqUmNc01CH0ENHyzfD?=
 =?us-ascii?Q?m1wLLL7vOnx6Y2jFexXlOsS8bfMkRlhUXhwVVbE8UzAjZVy27V/pwh/xALc3?=
 =?us-ascii?Q?GTEKhOYQMf1qhvvYzItmOqUIlYpx4K6GsNMiO6YBWhVO5G+P6YUBIMyy8+Iw?=
 =?us-ascii?Q?iP5wOE+2aYF3Rwv970VQuF48AdlskflxzUn/bp8Rg2NWg6Q2YvDzKy5mVtUM?=
 =?us-ascii?Q?AUxYI06KhiGK+MBXT2T3Okzc2CXzUIS6uoijE6QA2cb7/Qxtb7SZ7JEqFbMU?=
 =?us-ascii?Q?x8sZyeIU00DQUn8E1d+TMea6du/7qK23bvm8a/W8dc4SnpkDUyH/04+TcnHq?=
 =?us-ascii?Q?k9Z0h10GczakgyuRvU/YTHgd78CLrb0mSCMC+TFi0k/YR0YM6wtsq7nxlN0x?=
 =?us-ascii?Q?Plii6ugWlqXhxyHkUur6EwU0IUZCodIdw/Q6wkHFwz6Q8RUnZbhgI1f8a9im?=
 =?us-ascii?Q?eOnzHDxKg2BKdtrIHxDPUDP4cajyxjDmZMfdPn45NkZlcOwDMw38QjjBZLrg?=
 =?us-ascii?Q?vZ2/KXWyo6ehmOCNd/CWNme6ZU0a4sHPV9iFwTZ+Oe0yiLiYl1lYoAK8Ii8z?=
 =?us-ascii?Q?Si+vH6RfOoAiIdMgC22X6kjEtBYEdzuZSlP2ctwNent9OPupdCBPR/qvkmC2?=
 =?us-ascii?Q?Mi8G71nLbLzWXGyuPjePhvmGNcogg5JKdJemEbCX+sG2NsqbJr52YCgXczRi?=
 =?us-ascii?Q?GOzK2mEqIvS6H3y0HVa7lmUUprLpbTLR+ic2BgTQF3zWurnKgNLF641j0Atz?=
 =?us-ascii?Q?L2oP9wfElYKth5ihNwe3m8NvfYf7zB5e0ToqrcIHEkfAb6F88Jor/lloVKdx?=
 =?us-ascii?Q?em6NN1sCJ6yvllNViWweOsIhr6TvxdwpPQmqwOx0tzhDfZMSj4/2DinHW/XL?=
 =?us-ascii?Q?XTaG0UOtAWNPxT1W5XyLYTpc3YR3Rsklq0Au8RCQVHWqXUOmoJrwhWq6HnFl?=
 =?us-ascii?Q?sGN7ddwMwroN40AN6sCUjkyjzNb44bzms/YIg2F+cvjsv3izY0rbhjYprz/w?=
 =?us-ascii?Q?D4mDMy3uD8HQee/bEojhwEFqOGNFDTHE3GTf/HwNMrq7eCIvXoRFyH4LFb/h?=
 =?us-ascii?Q?np5L8c/JarTNT06pgQNiIRhKwzps2xT+M6eORgyZs4lkC7LhaIcxXqz9e5tF?=
 =?us-ascii?Q?G9Tll7XR0o5086frHA+N+aInSnMY4kfYaIfolHGdxBo0LQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g40/NPfti3/aDpStocaRq3yQ95XxsDuLGhRp2RB6KygHh7cASnlg+0BU66eZ?=
 =?us-ascii?Q?f2q5Y99XDlyYkRujGo/60DNHF8ZdCseR41AiFJvxkb580bMAaWqCqZ5s1okZ?=
 =?us-ascii?Q?CBcqPd8ikQmMPY5VdOE4p6DCLWzk+op/aK9nZgHwMqkhIcjES5UU7J0senG/?=
 =?us-ascii?Q?+uz9sXCQwGlhWvVLb2LZlHoZm1NbQVq4SelLb/uD49eUhw87lEo2vLY43qX2?=
 =?us-ascii?Q?XoSeSOxkBJ7kS73xsflsSr1p8omCu8loWVNydTj7FYqiZM57FCzx3gMx8983?=
 =?us-ascii?Q?bcve0vpzbR5os2pDx8qE/iBsvonP1zwNL38jq9chiWjWgKieXN/tSqEZ4CNE?=
 =?us-ascii?Q?5CVVtGhbiYe3gxxHpT/tF2m2qb56XwxczgzL5W9QtEohvC/vFK4EANDA5puJ?=
 =?us-ascii?Q?S+H40kmsOgK/AUsVnxyjC1vxBN+AkUcTrAcesfgx9QUJTB/tQ8ROOylBBcVU?=
 =?us-ascii?Q?+3TA78BZh7VQXPcNVLvKK8c7e15EicH/dzUcVbpq9sXXRsRct8B3R8+tiXCV?=
 =?us-ascii?Q?JVmgfb58TCmtY8p0i5xHW+Zu660a9IdZ8f2/ygriYLFSZ3a8YmRMxTCBFXbn?=
 =?us-ascii?Q?MopzCi70lTMK6A5OTqT07Pe9py0UVXqLGsJcExVG6jZxWmvn8iUSLkuTRbCf?=
 =?us-ascii?Q?Bod27qHw0zirXOTIZy6rW0QkMFozT0ExPzp7TehzloT06lklWwkwLUzCdr62?=
 =?us-ascii?Q?CLarCSTeP10C+KL2Wy8rjNL+CFt3DfqxR5Z+ounjmNHdVbN6P+hrnYe9JFAJ?=
 =?us-ascii?Q?h340YXATKrzBSgGLTCgDGOgAq9Bk3/rBB9baupFQlpJw/Uy4I2cWEQ61b49w?=
 =?us-ascii?Q?8stP3I5Le8gA5bN+218OTzi5GMVosizkLW+zKkmTRpm9WLezr5uqNo8x/Y74?=
 =?us-ascii?Q?8Qc62SuAa224t/UtaL0MpdYcmn0eTAG8czKwN3Fo9cnOm5L5KRj3t+mWoSje?=
 =?us-ascii?Q?zHrUHP2DC5b/fvSyRACiFJIcjv0s59fC7vJmRT0mlzLhKDwX/H5x45+WxSS5?=
 =?us-ascii?Q?IMio89rgXhLpuSEnGbIBGjRequzzEy/XCGMllK49oWipPK8R0Wj0u1H5JiNd?=
 =?us-ascii?Q?W/vSKasN+H4TrJ6U6rjm7dXYZ81qWSMsqWOh0+/2Nt43F3CLcpY8adR/DlKJ?=
 =?us-ascii?Q?lcGMNzzGBUzncb7HfkoYdSF4lEHw7FG2pkPMLabFOeVS3J1PY60eYWhM5dEr?=
 =?us-ascii?Q?xY/YFzCm3UOaTJWDEpe5+xSbYIqUNx3V06p3KjqtIT2Oq/vonfl8kljS27bx?=
 =?us-ascii?Q?htrg11vPeq1ceeOaMQyCcF7848y/V7sapgbvdOaRoCdk6U/5eW9Zc+6QEFyU?=
 =?us-ascii?Q?lyLV7OZteVlnFJVy+DZTIHRa7CRP9qnh5duc3xlHol9FqJ4bm0Yr8DkvDdVP?=
 =?us-ascii?Q?RRZ37eAnVDPEgfTsK6M0cb8vXrO5aVX5cNmKsLcTTN82l69RzGF20DorMqXK?=
 =?us-ascii?Q?/f6b8OQqydidCCCdxPWsQ40Ad1rPqrz3qBbk7f47CAlxYhki6cpvv3fJYPcC?=
 =?us-ascii?Q?FlFEdr3umoFQJW67dSXWlqs5NSV+eCEhTxvLmdKZlBymP1TBA+INCOfSPVoI?=
 =?us-ascii?Q?w9A2xWFq56UOyr0RmFzO0/LftmM6uGFQgp3hc993nj/9wKhfRslK2kBKoyq7?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Hhndm9NjP+Xd5h7M1kPgB1Ljz3i+TXfuhPogSMZuCOoFM031O4rEYOM9fFZHBrYfuCLAKU19H2vkPn0krDkEdl1eBTMWMa6+Dnf8atMj+xBcDCArbk0FV71Qz9C2rNPMXIHQJR81jFHQ+GIdBRP7RE4RXGgP0FcjASKjtZdHvA3xGAZT4uotpydUjLwcK9hltPYzWSSF+PJUXoQpaK47zob9z0P/SDZm7V8vanw4bBdYO5Tmkx6pdSA6ab4GiLfZ3dduV2RpaDE4C9N/21vTL/+rvDMhde7eELTIl1qH7BcyQmZStJ/ZyE53FhpP/44uwadqP7sKg9NXcKe+xPhl8jRJqgKUeyQ5InF3chP1qn+LK7Q0mLbEiYG+6tJ0mOZ+TTLS45xrtWke0rETAiPQyKHlkR3ODpbDOgcmCnDReeIGPukoCI25ufAjrZLhPfWG2OdNTMSocR4Q1fv2wKyWdOgCRMcI+fA5P3taWgFoWdR3ErVucb0KxGodkGoCvXP5hJwjRDro/Njtm+HphljBwS3BKRJmmB6nY2Ib1jecHyZR/h8v+NKFkDmaYOmpBRnRs7QrgdnghcNN0zXhUW1eUCfsClBwaMlxqCNkMLa0234=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9032e055-387b-42f2-5a4c-08dc9f6d1b00
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 16:43:33.4396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3jmNUhUDLXSZGSbnDeEiG73oNOK+lcErsuXNTQWOLW4IppjjTT/jKfZRkx9F6AzVLf/UZtSg2HPh5NU9os04A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080125
X-Proofpoint-GUID: 3hfKcUvhhKe8_R11XbI_-elvfI6sEBYh
X-Proofpoint-ORIG-GUID: 3hfKcUvhhKe8_R11XbI_-elvfI6sEBYh

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240708 07:08]:
> On Fri, Jul 05, 2024 at 04:56:34PM GMT, Liam R. Howlett wrote:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 16:18]:
> > > On Thu, Jul 04, 2024 at 02:27:12PM GMT, Liam R. Howlett wrote:
> > > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > > >
> > > > Instead of moving (or leaving) the vma iterator pointing at the previous
> > > > vma, leave it pointing at the insert location.  Pointing the vma
> > > > iterator at the insert location allows for a cleaner walk of the vma
> > > > tree for MAP_FIXED and the no expansion cases.
> > >
> > > I mean, it's funny I litearlly just asked why it was being left pointing at
> > > prev and I guess this answers that basically :)
> > >
> > > >
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > > ---
> > > >  mm/mmap.c | 28 ++++++++++++++--------------
> > > >  1 file changed, 14 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index f5b33de4e717..ecf55d32e804 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
> > > > @@ -2963,11 +2963,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  		vms_complete_munmap_vmas(&vms, &mas_detach);
> > > >  		next = vms.next;
> > > >  		prev = vms.prev;
> > > > -		vma_prev(&vmi);
> > > >  		vma = NULL;
> > > >  	} else {
> > > >  		next = vma_next(&vmi);
> > > >  		prev = vma_prev(&vmi);
> > > > +		if (prev)
> > > > +			vma_iter_next_range(&vmi);
> > > >  	}
> > > >
> > > >  	/*
> > > > @@ -2980,11 +2981,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  		vm_flags |= VM_ACCOUNT;
> > > >  	}
> > > >
> > > > -	if (vm_flags & VM_SPECIAL) {
> > > > -		if (prev)
> > > > -			vma_iter_next_range(&vmi);
> > > > +	if (vm_flags & VM_SPECIAL)
> > > >  		goto cannot_expand;
> > > > -	}
> > > >
> > > >  	/* Attempt to expand an old mapping */
> > > >  	/* Check next */
> > > > @@ -3005,19 +3003,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  		merge_start = prev->vm_start;
> > > >  		vma = prev;
> > > >  		vm_pgoff = prev->vm_pgoff;
> > > > -	} else if (prev) {
> > > > -		vma_iter_next_range(&vmi);
> > > > +		vma_prev(&vmi);
> > >
> > > Why not vma_iter_prev_range()?
> >
> > In any situation where we arrive at prev being able to merge with the
> > current, the prev->end == addr and we are already pointing at the gap
> > with addr.  So vma_iter_prev_range() and vma_prev() will do the same
> > thing here.
> >
> > I thought a lot about this (and created a small test application since
> > it is so difficult to test vma merging right now..).  If we do not clear
> > the gap, it is possible we will be pointing at the first vma in the
> > range, and not addr at all when we call vms_gather_munmap_vmas(), but
> > the loop at the end of the gather function ensures the vmi is at the
> > correct address (vms->start is in the range). So the result is that we
> > consistently point to the correct location and so these two calls will
> > do the same thing.
> 
> Might it be worth a comment here?

Okay, I'll add something.

> 
> >
> > >
> > > >  	}
> > > >
> > > > -	/* Actually expand, if possible */
> > > > -	if (vma &&
> > > > -	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> > > > -		khugepaged_enter_vma(vma, vm_flags);
> > > > -		goto expanded;
> > > > +	if (vma) {
> > > > +		/* Actually expand, if possible */
> > > > +		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> > > > +			khugepaged_enter_vma(vma, vm_flags);
> > > > +			goto expanded;
> > > > +		}
> > > > +
> > > > +		/* If the expand fails, then reposition the vma iterator */
> > > > +		if (unlikely(vma == prev))
> > > > +			vma_iter_set(&vmi, addr);
> > > >  	}
> > > >
> > > > -	if (vma == prev)
> > > > -		vma_iter_set(&vmi, addr);
> > > >  cannot_expand:
> > > >
> > > >  	/*
> > > > --
> > > > 2.43.0
> > > >
> > > Looks good to me,
> > >
> > > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Thanks!

