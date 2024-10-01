Return-Path: <linux-kernel+bounces-345585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9614198B7C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF5E1C22991
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769896F30F;
	Tue,  1 Oct 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ksUH1jRQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XUqoU4uy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D07192D63
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773219; cv=fail; b=EZlqqHYXAfW8hS2D02ki1ZmkxSm0b7g7+asghp8nOOcfqkQfBkFlGNYjVmu9yL7aaMmrCQ8QmfHKV0YzVlFutAOctrDSJN3pZ0+UB71q3WAjbTp+Y0s+n3DT3dIm3rndluIkRGoKm0nWkeXXmJKqfUJyLXEVr1wdprUmngfda9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773219; c=relaxed/simple;
	bh=2vAcPOzVolYB0ZjIf3GJjVFu19mc0Z0TZreScznkCN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r3Gjem/YxdDttFOi4MorNsjZ/12Fl4paiQ3y3FE75OqApa3FAI861uUFPHFHOxZ05aWyxp/EPqnIN0UcoZ4xSNK7X9aOWS9u1gly7Wf+u7rB90qL0sN8NhBM23vc8W7XfHalAW1HboFiIusmN+2JvnVEyIWuRtKk06ltiuRUEl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ksUH1jRQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XUqoU4uy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911tbDH024908;
	Tue, 1 Oct 2024 09:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=xQwGNyWwCk3yEKK
	IRTtKinRdI5mjcZXFeBkgVhn+kX0=; b=ksUH1jRQPE6/ft2Nd7AIYDArNwnU/KG
	cWY6JNOUqRyZ0wCCdrf8yzISEZf+3xm+B88GK0rS5sYA7p3AhTdscemlAk1oUkjl
	dvJvuQB9skhMMuSwZdY0Y1CZ8y1rnFe+dJG6IYlkdAKUjOTKL+Cp6uq1GG080xgE
	/vhSyB4nvZatLwoZGzxPlPDqkFNn+G7Opr54eyQ51Jl8CZnUDctu3anmXlzrW9Aq
	o5c58lMjxXr1Gr8P5t/2mFywC1e0a213ROVEy03N1vyLtLO+jl2j0nrXzzANu7jQ
	EawlNDPcImjIcfLdAC0vJzyjOkzOmrJOtHpe6UQsvDTyLeCcR3SJ0fw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9nmpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 09:00:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4918b8qx040492;
	Tue, 1 Oct 2024 09:00:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x8877y83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 09:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/0k2VqKO3dEaPvR/x3ujJ1ldjHuku/3ol14Aod5MNOoduA3HtxaD3TKRLrMG9OZkdgjwl0mkg5M2y7BTB12/+D9vqjQk1ynoV/WtM0tRq2O3IAQt19Ybl4Eqe9MObnRBWacgCaF+CxzXRdyz+fQbtFMq+oH9KQWOT+0Fjta87WCr59EyFZebf3xfn34uuYsv74uwP+QX5D94cuDepzb8Uotl7BWIys9RrtA4DuF0p8wiFlIyOfyrP+kj+WYj6eGE3zDWHFPIiJB/xKf51yhCzuBdVOubAUgQEXoh5wLgnmeCFvW0oMG57VS8jViQ9NP0GnQpChSq0A/3MY2obYT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQwGNyWwCk3yEKKIRTtKinRdI5mjcZXFeBkgVhn+kX0=;
 b=O1Kz5IiA7Lv2tYZORysxNZRQMom/BvuaM21VodOORL7Rd3dC+RnuOXopT9u2sQxfck/VexlLNX+nCGNolcBROR/ken31edbsUHKgTsTqjc7SPqeUB8gax4iawr2022zKJtbjYAq+qPnsJ9Q92UzaZcenOcykv+bFzf+CiO04SrjGYlRLwroSMW5WWz+zhJ7IqaKPh9QLZYydkXmKlhL2lFs1Nu8y/1EJtHrawkipiFnxc9+5KJy6j6Dm4WAVMmXJuFRjQYr0ufWgrm8H5AKDOa+noMC2FUL2Y5pCxpyjAUP9QuQNXWeYkU1rLWJd5zRHUt9npQpHTr+NpSJNfAnYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQwGNyWwCk3yEKKIRTtKinRdI5mjcZXFeBkgVhn+kX0=;
 b=XUqoU4uyggq23lIILfEcDbEC9N8ZzruIyvuvDNoFsZUi+EJ5x5KOBaJ5DmGhOa8sE4KGbiSy8EaOoGAGIwSJ9NvW89At7oK4D43VF/vkAsGtlzSsCgVQWwaGrsGlHnWJ+Kl3Cjpa9Dl/WUY6YnFsm+RNVsPdSnphRqOi52iiSJc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BY5PR10MB4355.namprd10.prod.outlook.com (2603:10b6:a03:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 08:59:57 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 08:59:57 +0000
Date: Tue, 1 Oct 2024 09:59:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <fdaa29c2-e1de-4f77-a23e-8fa7523919b2@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <5ec8665e-2f51-4b06-b68a-c878a969fb06@lucifer.local>
 <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
 <2f1a5621-1c3b-4c2e-97c4-86e36bc47788@lucifer.local>
 <9a97af91ba1925629d5c7fa1f1aec34f92123a15.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a97af91ba1925629d5c7fa1f1aec34f92123a15.camel@web.de>
X-ClientProxiedBy: LO4P123CA0391.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BY5PR10MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 55eb3a04-ecd7-40aa-c573-08dce1f76cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GD5LkCgPTrLMc3yQiTrV6rufLXInlWdMe77v+aKTbzylFfu6kxAF/raG17U8?=
 =?us-ascii?Q?7Pgun+uAGj8LuRJ8AVDqiL2CTLt8eTw0WL+tg8K00NNiCxqqsyw2vnBH74ka?=
 =?us-ascii?Q?tYXXcgSmPGWdRixunw49IvLKFfwNzf3Xt9EAE1aYGevLhN85D/8wblOTIakT?=
 =?us-ascii?Q?pPgU+ryyO7PGJAIMkLHC/X5c1rfEw504HR5rlZBTRg/q3M1wh5aNDPZ1ijFT?=
 =?us-ascii?Q?sbfVyJOTOKHkL9DzBu9x/8zwm68vO3rhuDBmj6HYQFzGYqYbwCtH6WOBZYjs?=
 =?us-ascii?Q?VqvkDtKS4sCKgI7sUcRZBcQb9Pj3uqefYUjZlozI/uqN0vuaGFN6V7/us+zQ?=
 =?us-ascii?Q?T8dnp2OPb1QaiBK0M/nyX420VB+bC5xnawIl0qP9UkhPW8kyP/GXOaKJsCLc?=
 =?us-ascii?Q?IkicvCbZRRZ2YJnvsNTBp6FgI0YyHEhOU6et2SUk3U1dRVRqM1PwdLV/pOVT?=
 =?us-ascii?Q?KIcp6m5W2Ib+XaPR4miVNEmlDslBiVBIcd//TifmtRG8elR2PevT1oaGE6Of?=
 =?us-ascii?Q?tSRuHZoQeDDcpDjScC1eQFg04RsJQkXTWObv6OGtM6xwvwqmtfVZX8FklQAW?=
 =?us-ascii?Q?EPQypaheHW78WrhW3f7C4oR2u63y294ALYo+06KFwrpJtUudFepwIifvD1Yw?=
 =?us-ascii?Q?cuzraMe1hPi3ofbPkX/7k8NpjYtIbADFySY3VlUZtRzegyu7VSxqjnIr7PTK?=
 =?us-ascii?Q?PRAvexCFSugBwY0x4IZigXou+HQy2rJNFjPNiDHb9CYW7oZKK/fVlmnxYxW2?=
 =?us-ascii?Q?NoET/nxaZuSf6BkrI9c+BHoQHauTkNg+ZCMqKSo0RIFnN6siVl23AxJv20Cp?=
 =?us-ascii?Q?KqFWCU+BnpaMugItZ4UmxhZdKOILHJooHpIH6TEJDiVO6Ignbhj6wBw+N7b0?=
 =?us-ascii?Q?JFkw9BQLZKNDBc7vdfNKlQcQvU95KyKdLBBkABpLiLPUuDUaMjTyh0q6TVCP?=
 =?us-ascii?Q?NsYrVtgBwxO3FFcKhvrxuNurSEFLIzWV+k9h9DQR/vtC/D8bLyDrdmxMPTCu?=
 =?us-ascii?Q?eY0GkLR/JaGrHrCLatKjp7DhG6f95VgB1grjiNm7qQWqNkFTsxt+0Rz+O3bg?=
 =?us-ascii?Q?RsSZZ6PVlJ9TlsueKIPPGIikmm9WnnWD7wrRjSX03bWPlZI7cdwLbrAfhw/a?=
 =?us-ascii?Q?o5WOUhTljQU9Ck5CxRFl5JAQrzoclS46xwKa5Yqph+MYULxIDA4QSdP0UH7z?=
 =?us-ascii?Q?gVmKg6AI4BNnGoQD2gz45KC3gx4pD1tjEwZMKa5oeKaWTwRdGLVAx2HFDiMB?=
 =?us-ascii?Q?glybKIQWv1sx09pfAfaHAV94J1tJwao4WvOvQf1wyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3AyQaJ3rRFkto1egxClT1i9V9D3p9Cm16Jul7/QuA2OZ434hgVzjVkHS4GXX?=
 =?us-ascii?Q?Hxk9xaKg3l2ZXb/9qNewtow5WoJ/lxl736F6WymOPKy+jRqmlPzm/YkfhovH?=
 =?us-ascii?Q?0gl1aWOpPuYyScD+celX2A49CSGtlLHXdCjGOwKyhZ0KDPI8b2SV4DlWLcmV?=
 =?us-ascii?Q?4vLlgwhvvroXlqCrxITdritvRRAwonNpJDx5bRJFRU8hwvsWt8EPh03lWXw2?=
 =?us-ascii?Q?zCQy24+eSXHSMOLxmqt4djYWLAlkqGWp9W6MVURggJmivMnxDZPMUKQX0BCL?=
 =?us-ascii?Q?WkrX6nV2TsGgXOIh7hnf9uUE12VU1O8LxyaS+Yiiwdbzxd9xy3dSVklmGw2G?=
 =?us-ascii?Q?h2UxEnotf/IKTRDTJQSpvbbgE1VJO0LzugHvkZtVTU9jIL9YJHmaaZ16IPtu?=
 =?us-ascii?Q?LwysJtwWrzqM/4fdZLhklYs/ljeTcGwD+9vwsH1HHFO47LC7O/ZleK6Rh2it?=
 =?us-ascii?Q?hPL3YZhvCgbbBk+xw720yoZ4i5ixx0o/8in7VzJU74wujo4EclkiraHAVYcN?=
 =?us-ascii?Q?qVQDcy+dPYdAO75DLUljX4/yneaDUp2GacSeU9FU9wJwB98eg9CYT0MpS4Q8?=
 =?us-ascii?Q?ygUY7JQmwKx95pc3IW6Ca6qFs3M2zTL14shx4Rk3u+7LLo3sP+D/akArHL85?=
 =?us-ascii?Q?1EUEROqxYxeXOsxGxPmK7+eqAcZXbE0J64ZFziJTvpBDURPdFHTJYQC9O6G8?=
 =?us-ascii?Q?qOyT8GgVqHJZqah4VRaO0KnPCB1uWlZzCHvID5jxGshYf0aMmb7MsXw+lQTE?=
 =?us-ascii?Q?mMM4eIBp855BUfEig7No+YH1Gj2UY4YnNeJlKd3ypfc25UOxNvlKAhpi+Ajt?=
 =?us-ascii?Q?ZfQNHJx4fViR0HrpYQl30sLwBiVAiCxyjMs2ZG36YChRkyeNh9v5avoUBbth?=
 =?us-ascii?Q?FPlTKVQwctUtHKTGna8rwz6fcuHRtVcd3F4th7MDIsqsUKOV/8Q2K636OL3Z?=
 =?us-ascii?Q?KrFkyXazDHne2w93cGj8KIB4mMgrfhW3nXi0fq1XPx9QBfSqHpftTrh0Al/U?=
 =?us-ascii?Q?glTLrKLxkO9Oi0npcbwAAZP93rNwA10QIOan/pzL6VbeCzScgHIFZ4H3RNRN?=
 =?us-ascii?Q?0ywgTpqljffGQKuA8NkenrqTaYCjMpdXbco9VF7hvUY/0tpk+lelInsedjJ4?=
 =?us-ascii?Q?/5mJLoX5u6EP4McW9N+G0MCKtcp6QhDMkk0AJ4uNFy2SoCowMsBXk44UZnGp?=
 =?us-ascii?Q?ddGcPXjRh+sh6X4cmYjFmBw5E5PvVXceNZ02ADXDAC3Xwn2i7VrlZvn0a90y?=
 =?us-ascii?Q?Ts6O88O6vOYWAvuhTiz7wZUZfi6zsn2UXgOhk01eIPNJlYOlemzlVFqO0iss?=
 =?us-ascii?Q?6Yuo4OVStMfn4CNhjMs7IyevIDt76L+RfnjmPzJzZckhLVfgDIfvgGEybG40?=
 =?us-ascii?Q?UrRdkecr2qKMfNtV65cgJRvAcC2J87b1iZPS/Gw0CzYMxPeovXXFN0cFSRO/?=
 =?us-ascii?Q?eCYwadJ4kvfWgenQsG1qtucMN6f2IJNOZPww6S+aDVKaJ9yRniliRBmjMWqV?=
 =?us-ascii?Q?6D7zKnIhvtlO8bcKaaiR4/gm0s5iYSZYllEwe/hj1b4la6j07PInrSZ6fgOc?=
 =?us-ascii?Q?MVDfJPfPrl26hsYPQ0YTQHSYeUvVttUNwca/8dmvxYzHnx8/CUEjP1RQezRH?=
 =?us-ascii?Q?aqR99M2MkummWPq9phemGpXZSG9xq1Y0tE1rsoFMtKxYX/9AJeS846pHYSto?=
 =?us-ascii?Q?BBW8Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7uqPc4QLHy2QzHH8m+9k/TnfwAmsQDyVYeiuF87z59UdR2jtQiyghoQSN9pg5Pgps+kMASoxgCQqvhiNwiPevaSR9g3+O2jMtOl8rtUxwfl0kIQWK41ok3o6aSEMfsZ5sgCAP0ICG/ciUG2KFC90KqvdOv/O26VB4/fP95clgiJikO0RUDqHwNaoH563DrApnl3foW3GtuBFE1ZR58pk4kGg/gWp3YLnaGu2lxv7A1jaoCA5OKA3AtDyChlB86HJux5BXUzdlQ8/s7M02+oVIWBETK/a4APlQ6wA1dHoqaa4JEHE4/Dr6m3KA0FKCaKrVZJc70/cF9gUZm4jyxwKIjQ4+arEBFc7Wkka303A2fQ6sMgJaZ5bNzqH1CfZ3AQ0pv9QpEDyrlRHHukmSmV+jHM0raM/2k6lWx7uxJ1XIEQQfRPFEvDjh1dFIJ+OlbXzUdmJIvBQeJ4vtUCd7ws/Wkdcmc4PZJIJ5+mbiLSTMQ9noRY1coWcuZEHV4yRIuTlNg5+q4sloZBTL0d8LhJPJz0mXfbhhtn5fzXCNkJrvPNvlhFDxR3ovTRs7SFuN7bBfFVxZ09B48PTfWC0KykMt2oIyc9TAz9kb1rvQdr5qsk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55eb3a04-ecd7-40aa-c573-08dce1f76cad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:59:57.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06yGQz1T94nVRDlH/cFKurr9eJ8d/4ah8Ci7T1yMBX1Ds24uCRcEU8wlCASCu8CIv0N4CEnT/ZMgUKcSErbxwpEIq/WrAF1Mn254wOdklNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4355
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410010057
X-Proofpoint-ORIG-GUID: XaL5gwKPqR66vDTFPa-0jugZUxvCIUWt
X-Proofpoint-GUID: XaL5gwKPqR66vDTFPa-0jugZUxvCIUWt

On Tue, Oct 01, 2024 at 10:55:50AM GMT, Bert Karwatzki wrote:
> Am Dienstag, dem 01.10.2024 um 09:49 +0100 schrieb Lorenzo Stoakes:
> > On Tue, Oct 01, 2024 at 10:38:35AM GMT, Bert Karwatzki wrote:
> > > Am Dienstag, dem 01.10.2024 um 09:02 +0100 schrieb Lorenzo Stoakes:
> > > > On Tue, Oct 01, 2024 at 04:34:00AM GMT, Bert Karwatzki wrote:
> > > > > I just noticed (via a bisect between v6.11 and v6.12-rc1) that this patch
> > > > > (commit f8d112a4e657 in linux-next tree) leads to a severe memory corruption
> > > > > error under these (rather rare) circumstances:
> > > > > 1. Start a 32bit windows game via steam (which uses proton, steam's version of wine)
> > > > > 2. When starting the game you the proton version used has to be updated
> > > >
> > > > Yikes. Thanks for the report, very very much appreciated. Will look into
> > > > this as Liam is out until next week.
> > > >
> > > > How repro is this? Is it consistent?
> > >
> > > Reproducability is 100%, only the method is weird, you have to switch to an
> > > older version of proton in the steam settings of the game, start the game and
> > > then switch back to the new version and start the game again.
> > >  It might also be possible using standard wine and repeatedly upgrading and
> > > downgrading wine and (I have not tried this, yet ...)
> > >
> >
> > OK that's good.
> >
> > Actually a quick one if you have a sec - could you try the same thing with tip
> > of Linus's tree?
> >
> > This will help eliminate any other possible cause.
> >
> > Thanks!
> >
> > >
> I first noticed the bug unsing linux-next-20240926, it's also present in v6.12-
> rc1 (hence the bisection), but I can try linux-next or linux-torvald master,
> too.

Next can have odd resolutions and 26th sep might not include all fixes, could
you check against Linus's tree just to rule out anything else?

Very likely it'll just repro again but be good to be sure before going too deep
on this, thanks!

>
> Bert Karwatzki

