Return-Path: <linux-kernel+bounces-353689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265EA99312C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A111F22EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0DD1DB352;
	Mon,  7 Oct 2024 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hx/ZbCaa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vRX0wUyY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656A1DA619
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314940; cv=fail; b=afiddbD8gHXoruqGwZgBCh6C5TRWa98EV+mF/x77g8LIvevd4wQRCACmDchLAtY9n85dU6132wmIJjIWpYevt8Q7m1FI1MCbbjBCeUv0B0SNDOi6BaTZAS2jweXfEKPfBedKjHVJ7syiMq9TkNGe5/GYfKenWPDg8FTMvtwJNJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314940; c=relaxed/simple;
	bh=xNti0fBEL/AV+OlKK2kJLk3esEdlO7+gTKnwoQouxQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KyVX4YVrfSvAweUwQOIqqDmgGzHW7SfrFtuLojSXTXXd3VGUHBk7C+SLi66f+j03BaVfptOYSXA31KcBxqqww8e87wWX+ik4VORxqqpJjNwZuQ2DDpDTkV6bGiMy050q+UcmOhlSg0x3RhfKwKQXBgHORH4wKynysnf+l98ZlMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hx/ZbCaa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vRX0wUyY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMemE022952;
	Mon, 7 Oct 2024 15:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7A482o+x7brxhc1TRdgH9QdPrxF7DFUUes+N+8w9TI4=; b=
	hx/ZbCaa1Zp4H2lYsfIEhF3NOQsQJ0nrk0uC/dsMyQpdEfiu1Yz7ew42j0ul13gP
	D/oXAhubkEOCnf+45Pqszr6Gcc7dFF7Se/aBIGSXMFOUA7yVhhi1sDkktPNYOIGh
	ZKcD70qlpshylddspbxay9kZvYawnQYpoaWCvHKA25GnBt4KmTR4mVB92eJEpE/C
	2WCxOuBGtWjLKx3mt3HQeOo95Bya5Jl8FeNz7S3iVb4IwBLNVSiPlI/4z1782dk5
	v43Rrmuf7qdWWD4xF/1ae2lp164RI5tfsFGY/rumuboK2OkBQDKCB2cQX74dpR9u
	3DcB5btA8SZ8suhSK47mWg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ybpff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 15:28:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497FOjc1011736;
	Mon, 7 Oct 2024 15:28:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw5xa26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 15:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8JiTZNFb9ROckTGwFSk7DN8yNUPE8t6ubUuGAZFXOqb+CPuP0WWSw2+SoNYVC7GaSzhHqjrD/0Zdyfv5sg1XknQgrMu02pckYaVtflM8NUeoCGxbbcsd7cvddpvnTXxpLBmTpX4fFuLY7dv82WSa6QhvJhX0nB4Pvt0mtdHLfXuT5/Dy2e2Um29By+xrTzwirZaNGr3o/V+D+mv6Mi5cNMUHood9Z9+2HtPkNr22Wm1+mDZbj+zrEG9kOBAn4Ijvm+iOrusbrElvR+XV+1UeG6mQU85uDxcgf2l1Jd8P8b0nmpMpSoVby1qSXhV51TxhqYOxm1Wmv8ZbM4/HRzaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A482o+x7brxhc1TRdgH9QdPrxF7DFUUes+N+8w9TI4=;
 b=ifzN5sgQgk01DfaXyFmNwAJMSjcBnRuPYqMMPiqMS32uVxJUJQepLT3tNX2nhCIuMQDS6P9et9ALT/1WkMA5O+LaqmN4f6rVomr1QMXcH1QUxPFRX2dRz26swaarR3zCzVFoUNCb8kuJKJuVzd8U7AFhNubnjR8VP3E4Wjafz6BL/0EeKlx/PXSS5t+ZGYTgUXEjNJVjPe8V4UGIFlKmmF9Hhk0eycbVbYhcmgMkrGwkLEupRbR/LSRdRzOPePuMPV+2LnNux7gHAJWmGCxhtwWHIYdS+ATnC7eBRG8BSePWLLlF+xAaxpVH8NmNyW31ohJdCv3p4Lgb4Skbas/Mtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A482o+x7brxhc1TRdgH9QdPrxF7DFUUes+N+8w9TI4=;
 b=vRX0wUyY1Ko9TA7QkAtUclEPSS+Zki3lLkCbz0oGOjy7PZpeAPManC/tVTd6Sy/ZYC6TIU7U7PsPE6slM15fwWpzsd7o5Iole5/AeP85TwrqcrpQJecW6FFSeBDAagVWwDk3oyah+QetlGW4OdWz3pFK6hkJtPWyub7ygpYTF+M=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 15:28:43 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:28:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: [PATCH hotfix 6.12 v3 2/2] maple_tree: add regression test for spanning store bug
Date: Mon,  7 Oct 2024 16:28:33 +0100
Message-ID: <30cdc101a700d16e03ba2f9aa5d83f2efa894168.1728314403.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
References: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0482.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 475c713b-fff5-404b-67e9-08dce6e4ba3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7xGocnQM3F2sa9WqpLfMpYamxogfyRLl2kHZ3a4r+fmrs0xb2JztTaygUTpN?=
 =?us-ascii?Q?9FqzKFHMLzoYboyGmMU9/PNB3yNLdF8FDEqtYKTttFKQfIWi8508cmCDzzv7?=
 =?us-ascii?Q?ZcCDdA/gW71msj2BJjF/Dr7kO5+0Ota+KIgkhfYwrgUgI/6bxho80WRYvdQ2?=
 =?us-ascii?Q?6zOCNYeWTGUGXje2OjQ+aIB1LMURN3v0kjuMqMSUg3W9PBIUfM0tRNpnjfb6?=
 =?us-ascii?Q?AeFXaO76HKyACmBYQOJ6tT9TZGDPfhdYYEteAjXquntlwk/zQqQPP/4jEiUq?=
 =?us-ascii?Q?CWkAvdkfmdmgEpOdBs0vZOhmQiHqKO0Ur1BrNUSsxHS/4Ll3z1M6imCon5yj?=
 =?us-ascii?Q?DCSZCa9rO+YPi4ENwUJCHLcereGONOCPtbVnquW+EBvC1h4tJH7z3ycuvMgQ?=
 =?us-ascii?Q?r2vUUR0J5HUIrbg+UD/uXFUzfZgknxCval47hXkHt8ORVnDjfxoNqhOakbCg?=
 =?us-ascii?Q?kGv+5xllMPv00XYvO3Rs4Gc2xRXFiObPSYIAP47YvP7HEuDEKdQWBkmV4geF?=
 =?us-ascii?Q?tRmstl9TiVkacRUXdJungyLmYKdC0tKJQY+J34FSRG0GA6jvjBp9WgQESlCX?=
 =?us-ascii?Q?aIYsavldunyNyPjhaRmTVZfUsPaLqO8gZ4+58yBsFJcYch8jyU7Oj8ICFeDG?=
 =?us-ascii?Q?P+yZCVu0RHzXOxrGlqueBndHmCZK1sK0X6zYXugpsYzjwCU3QoDtvku24BVW?=
 =?us-ascii?Q?S4uiiATqFM0YUGqVInrzlb3iMRbX9Psq5uQdwbIYox2bnn1qS8vmiPPNGXaO?=
 =?us-ascii?Q?DmX8oeq+9JipkuDQ0CEgYEo/2sfnIihl1A79C0k2CvwQh1waScgoSQdMXFBt?=
 =?us-ascii?Q?JtHJLLb6ndrUDJVTlA1DJRlVgDohFXkCk+Msg9Z7goIFhQTTtDq229VF+9+f?=
 =?us-ascii?Q?kTiFaUsivBO4BWZfNdl5siEndAkofG84oPap1UPBL4YUmGosTqDvDfvyh2nF?=
 =?us-ascii?Q?mPAD9yHQ1p+lBIwwdBaITXihTzXLa6zzPy4ZssxwiDVd8VLC7oDuxBUIT636?=
 =?us-ascii?Q?9pBHtKPegM9NmMFp/wdbxSvDzrDflx7lhewuTmbO66lrUL0fnL13mwspOPkl?=
 =?us-ascii?Q?4+7tpNfIL8bJN+FjjRc+Nm2Wnw3v8eQWln973y3gv0X0GOM2tpH0A2EnQ2R9?=
 =?us-ascii?Q?uWqsU03LbA5fckxq8TQaev6w7Ttc7+oKyW8j3EX87dlZnVvCfTL0r4ctz/Er?=
 =?us-ascii?Q?b1e0q7e0ChRy62I1fKM10HKW4yj7mNeODIN88CibozUfoCdVZtEV6xEjTCKe?=
 =?us-ascii?Q?4oJylC+vRBpjchUFNsWEKAmkue9VRerey+38o1UUfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oTsBsZRMtYko7IBg/t/o6DOnGCBIdxgZrWvWT4twnFaVGdVvBwDQAmMP4Z3K?=
 =?us-ascii?Q?2a1qGoyWrHt3CpXyhYfwCUUQIairZkho2XoacXnDgdsQBmn1+3vgpCg543Y6?=
 =?us-ascii?Q?U34SfojXZyLdAhpCIr3fkKXVSXr+AqCuZKCMwhvqkviwJ7tBGhAo9rCtfG7i?=
 =?us-ascii?Q?21EIVos2PyP4+5bok8RcdR0O9LcWfi2OmWf5FsM6WmN9a6oFTFIF710fUBmb?=
 =?us-ascii?Q?CkmrpMGuEBMWoOaLwsHWR7mEQcTirjigCJ8VbnwMCEtx3QIPvh7rZ1PWXy6v?=
 =?us-ascii?Q?+y/VCdSfon3p+V4QC46UWSoYjy8Af7CpmMomOrLYe/K0h7p41b3TSljQ7V8l?=
 =?us-ascii?Q?t7PzxL0wvUPkijCc/m7WMc2noytfYojYCl9z7vewvmMJ5ta4/j1BB31+6H6N?=
 =?us-ascii?Q?8Cqszhzh2fBuAWL4c7jDOAx8+eXMVDPaRgk/gzKWliX8x7trV7+FFqk39ICD?=
 =?us-ascii?Q?FgxRIl8b8NPCIc3nIrSMVWb0Le7/drxNe9stqeP8uH9JsZQ8eF3W5bTivbS8?=
 =?us-ascii?Q?zhEjr4zYLisJZSIf0/7j84iFqMMBBDLatoFzLwQR57vGpK09F0wne2r14EgQ?=
 =?us-ascii?Q?6Noohjp/0YLNTX8P2+fbHQmhISymyjDOY0CBYXxIl9xN6wZyBkgWHukEtghw?=
 =?us-ascii?Q?uYhDsDMtsEwwhHGSMj+eFvfWUqZEfbjAqW95Aj8yeCgGCFq+mX7LSbp/d/8V?=
 =?us-ascii?Q?bow0IqfiP8XnhwRa+Z7sGb8kGYpXe5S1sdQtAcYUnGPNTcF1zVkH3b48KQ4q?=
 =?us-ascii?Q?GmTQ5mcfkZYnnRQ+wZ11uHn83uuprc8Z0BqmJXbcy45/y7gkWLcgllSgEImB?=
 =?us-ascii?Q?FJMqbxgVYtZehUlBdrkp5HO+T5IUQkLH9LMhLRx0zPSU4KStkwUmiFDVfEK6?=
 =?us-ascii?Q?cG2vwL2+vFbw2yN9e+E614EQTZZtGB52zJ2Op9lgCfJ1zl+zUZYEflgx31gR?=
 =?us-ascii?Q?rTtEtr0424mnMwQvT0bwadAhkeSDF4ILvjef7Z53WMCGXocndcAVOFBb5gW1?=
 =?us-ascii?Q?VEzP0KaYvlp0I36cLD7dgiUEmlcrekNW0mtRhQlNLZ1Z1BGfjSWW14hBwNqr?=
 =?us-ascii?Q?zL71CrJPaYFyazmag6BC1mDRcx8aoUFEYzlvrMKgTdS2cXKTkOgG249zb1+u?=
 =?us-ascii?Q?OO/fpCViW2J2BrNA79STzKaKiefaw8k8linM/ivOq3Hzcy5vjXPD5LKtEjOI?=
 =?us-ascii?Q?jyfrTc9Yy/AqmgfbEc/8ndH/re39s/MjYKcUkZ9vYmAxlIBtCkLOTci8bStf?=
 =?us-ascii?Q?I2DJmYOTMjTZVlC/8oDUvk/ATzA/tFVa732cdk9ssWjPTnTGoaZHhO5XtVdL?=
 =?us-ascii?Q?FLp6Yz7conuSmP4Z8/PCFMQtvli0K2lKkpGTwewNNHI32RNswNZhYtetATXd?=
 =?us-ascii?Q?LUtscTyYwUgFtc3TmpM1z3jYM9ThEGIIYZdfoAYM9lCePBz8WBWGiERIU0Ed?=
 =?us-ascii?Q?m8pf0v0HnmL6Xy4REt4vv8xq66lxzQIYQIad9l6SMSOMpb7VqxJt7wvkOOUC?=
 =?us-ascii?Q?qTSiILAkGERQCvuMRvIItgtrzn0N+d7K91YXHJ9Lw/hXJoYv0d9GANT3Txl4?=
 =?us-ascii?Q?gQ13pqSUidpzPlQEaeC5Luh9HmQu87Pw6d7rncU4pDeHCPEZpPT6SAYhV99v?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6ypyaQ8mWFMKVATdJTs7pNbBfl5o+nHowv/OmumRmIv5RtyMxDtbMr17s0FGYiUJuob22/jLiYijrfQj1FmGEDHF5STmhksb9wlLpD+KSED98kK9kUTcVBztXHmcY2lxfi+5qyWFXUc6HqkSFGAFwPsTscVt32d1QJrhXapQLDhd5U4nEgIU5/bGCTSmDrFSLQiMn0ONE6jIC1VwnXQfFWPcMJknPj1mlu/MbS1l85te2ZGXQ3nyuErKZHH9lf6FySQ7qb4eOMi5nVoWIKBAbn1f2gnvnB9NdH1W4WmFn7NcPeBcBBa7DaTvvgBCuaGOTR2v1Jk2pWTV2lpq3xhcVe6hbCzfhoIBCZ38Ai4qCF7YRLl9Q4uc+60l8JDtcMDHgUVtjiJSf2iNgwn8gF5os5WbzulK/m594aAy3egTtZihSrlFy3/su6CfLgonp+f0p/oHqeAIp6aKAzSsqJIQVnOKaqpMwVr91uTR77wWx7sX5Uv1/WHaic2XTqNUqv8YLhS/JnIiuYNmPB4JqGN4rGGAfy+GSb/42+Ej/gtVuxWCImRxNJOCrD1eh6ogGDjxex/aJU22Jl6e8R6yDZdaN6GxHD4xmOu/ZcNWidj/1OA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475c713b-fff5-404b-67e9-08dce6e4ba3a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:28:43.1901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28cMlZgLeZMDgvhUwahKAEu85C9YQ9ZYH2+CGhDLETvtHyf9Tnr+5Yw5mx4uGoNNTlSPZyCUMeZgsZo11fwNLChnXAtcmo043RWPkuo42U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070109
X-Proofpoint-ORIG-GUID: oeXUXm8UExhEsL5CosgpITKbYz_zeLTu
X-Proofpoint-GUID: oeXUXm8UExhEsL5CosgpITKbYz_zeLTu

Add a regression test to assert that, when performing a spanning store
which consumes the entirety of the rightmost right leaf node does not
result in maple tree corruption when doing so.

This achieves this by building a test tree of 3 levels and establishing a
store which ultimately results in a spanned store of this nature.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/radix-tree/maple.c | 84 ++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 1873ddbe16cc..5fde09999be4 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36406,9 +36406,93 @@ void farmer_tests(void)
 	check_nomem(&tree);
 }

+static unsigned long get_last_index(struct ma_state *mas)
+{
+	struct maple_node *node = mas_mn(mas);
+	enum maple_type mt = mte_node_type(mas->node);
+	unsigned long *pivots = ma_pivots(node, mt);
+	unsigned long last_index = mas_data_end(mas);
+
+	BUG_ON(last_index == 0);
+
+	return pivots[last_index - 1] + 1;
+}
+
+/*
+ * Assert that we handle spanning stores that consume the entirety of the right
+ * leaf node correctly.
+ */
+static void test_spanning_store_regression(void)
+{
+	unsigned long from = 0, to = 0;
+	DEFINE_MTREE(tree);
+	MA_STATE(mas, &tree, 0, 0);
+
+	/*
+	 * Build a 3-level tree. We require a parent node below the root node
+	 * and 2 leaf nodes under it, so we can span the entirety of the right
+	 * hand node.
+	 */
+	build_full_tree(&tree, 0, 3);
+
+	/* Descend into position at depth 2. */
+	mas_reset(&mas);
+	mas_start(&mas);
+	mas_descend(&mas);
+	mas_descend(&mas);
+
+	/*
+	 * We need to establish a tree like the below.
+	 *
+	 * Then we can try a store in [from, to] which results in a spanned
+	 * store across nodes B and C, with the maple state at the time of the
+	 * write being such that only the subtree at A and below is considered.
+	 *
+	 * Height
+	 *  0                              Root Node
+	 *                                  /      \
+	 *                    pivot = to   /        \ pivot = ULONG_MAX
+	 *                                /          \
+	 *   1                       A [-----]       ...
+	 *                              /   \
+	 *                pivot = from /     \ pivot = to
+	 *                            /       \
+	 *   2 (LEAVES)          B [-----]  [-----] C
+	 *                                       ^--- Last pivot to.
+	 */
+	while (true) {
+		unsigned long tmp = get_last_index(&mas);
+
+		if (mas_next_sibling(&mas)) {
+			from = tmp;
+			to = mas.max;
+		} else {
+			break;
+		}
+	}
+
+	BUG_ON(from == 0 && to == 0);
+
+	/* Perform the store. */
+	mas_set_range(&mas, from, to);
+	mas_store_gfp(&mas, xa_mk_value(0xdead), GFP_KERNEL);
+
+	/* If the regression occurs, the validation will fail. */
+	mt_validate(&tree);
+
+	/* Cleanup. */
+	__mt_destroy(&tree);
+}
+
+static void regression_tests(void)
+{
+	test_spanning_store_regression();
+}
+
 void maple_tree_tests(void)
 {
 #if !defined(BENCH)
+	regression_tests();
 	farmer_tests();
 #endif
 	maple_tree_seed();
--
2.46.2

