Return-Path: <linux-kernel+bounces-416266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0769D42AB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EF71F22583
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FAE1BD03C;
	Wed, 20 Nov 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cNcJZTeZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oQXPtnUV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707AC15532A;
	Wed, 20 Nov 2024 19:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732132050; cv=fail; b=EnO1CepW8qOntcmusFYiCdmj0H15kmZyzg91N5JM2UJwdOPVrVz/5OCph3C0PnzXKRJlCPzICRJW2jWw/QeOHGF6UYhY1A/tKTLufgLFHYJBOip+rOoyc/WJuxw76uq3+KcD/Nh5Kb6dxHZoDRFy4V43e/UeG/3n9IgZdssLCng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732132050; c=relaxed/simple;
	bh=IVsZMXVjyFoY4hdX6uCBeU4tdCHfRKE3wjlcQ34wGRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eeC+SpxfJ2Y/mj2exBL3IQRfW3s+lbWmktXm+sqqQXWExEfqFPNmcqcKgEJr5Z9gjk6Y+q+l0DiKZHJkTfmC+8yMVG5sK/Cyix07xCCc/RzDEdJaFizRc6CPr1lO+EGxRFV0eVMnjy1kixBxeypfONeDijpRRwZr0HfBqL9Lzbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cNcJZTeZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oQXPtnUV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFtYHm011421;
	Wed, 20 Nov 2024 19:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=sEDibA4chJb39fIopH
	0l1Qv0UpXQ5jgN5vGOEJlLIFE=; b=cNcJZTeZ8xCk4ugqkf9NmlH3QbRu/yaqWW
	rSfy8VVTw1tp45kqT05geqL/K8qgLiZt8m5MNfBqEGfOOCnbCCzCGliNE4bQ9XLE
	5ew+E3nS8yeiWYQg0zXcPfuuUpYLUSwgpkO1uWXVEAfyxFYbiJ++JgteyMci5Ytp
	pJF0oHhhYevUZRLlOp2qUB2cb6Ik4+/o6mVaze8qdHI/fC699kveBZAVSaY3ITci
	95npQrp+x/izW6+puMbWDnIxGAuN1DzCNN6Ae+JWfxm/taUXOuPVksJiHNlwF11i
	5H+PPjBhw7rXaYrqI1xym1ZX+gUW2j/d55+EiA62v0DQUpDMJu1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa8752-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 19:46:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKIKDPt023304;
	Wed, 20 Nov 2024 19:46:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhub2xhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 19:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMfSLjrupaebou8GRniKzeNu/r/FfPxynnFILDUKwmyuT5SzHGRKR5PI7fmN8yk3YD/k+0AqlDB2rkbjPn6982BlGRuMC1o98lG6yAWjJkG0CxEPDQ+y5N/S4VhKhkDCYSOQoEnYvY9MNrAwcLpmaL2cQVVUnXB0u+Mn7MWbRTKRS9D11fqL/Oo96NY+LhX7DewlQNrS7F9p0Hyo8Lv8VIbaKa8ozlwbJtdQj5eckjro4nTYwVAwdMfAzeLCoS+TvoofwQJIY04pTlU6HDJskQqKNNfGRDJDPpLpg+du6gOLNGVRrWaZhI61N82m+vywR+CH1LOtGmYbHhfNQDHH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEDibA4chJb39fIopH0l1Qv0UpXQ5jgN5vGOEJlLIFE=;
 b=aKtyfObRI0e1yJ2zbgVDpTndZt/TRs+D0ySk+kdPWk5HqGfz3OLEE5U2eXFhEEsH8RiIRdwcm99zrT/pj1QGU9mGrbjqM02EdNOXaZ1yI2kEnvSqmFwpeZxaDld1llDOqiKdevsVrKqHJO+hNocme34fQZ6x2oJtPVpRbeyabK69lPpd9LMDIUIzGP0co0esO96q2ckCnX5+Mo4XvlFfJAwuZsaOB46BK4F3J3Rn6xOjMOlqWLoIbhhgpAS7/GnQ96SS2NF9rw/f98HFaidHmTVQ/aUkAJN33JyMBBroHR5pKJUZQd9iq4udrn1myKa/xpiuNw/8p5a9Tg5lRwflOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEDibA4chJb39fIopH0l1Qv0UpXQ5jgN5vGOEJlLIFE=;
 b=oQXPtnUVdqV4We8+NpYNF/lgGx2dBpLoPUGbWpYPJS4qT/j6D09t+qD9Rxg5u5W9Cc8pNUQRQBdUy1uUZfHbKImrgWS3Ns7ptvMt0iM1ThtH6qwZqZGr5hqhFRAHR0lv+OigqFSSb1graAAxCbaj2CMPEho/ATan6pEyqzdSGlg=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA1PR10MB7753.namprd10.prod.outlook.com (2603:10b6:806:3a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Wed, 20 Nov
 2024 19:46:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 19:46:49 +0000
Date: Wed, 20 Nov 2024 19:46:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 5/7] mm: rust: add mmput_async support
Message-ID: <5762ab92-3091-46cf-9565-f59cf917b470@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-5-eb31425da66b@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-vma-v8-5-eb31425da66b@google.com>
X-ClientProxiedBy: LO4P123CA0566.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA1PR10MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: a224ba9a-d712-4cb0-0a0f-08dd099c129c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HgkMYP10UfW247eZB7mUJH1wsI+/cRCUSoOts+PKKTeaQVRSWejM2ViWY02c?=
 =?us-ascii?Q?U3QTQoepVa5cyuRHyGBvOEBJrU69WQMz30ms4Kkb00kYw60zJ35SVzd2vp3J?=
 =?us-ascii?Q?rrEwvhSm5Eo4JYRVlx2nU3RweKyG9d33TXb4iVuzuM/hZPF0KBRiOhhFk0Bq?=
 =?us-ascii?Q?bq0NhmEPXsSD/KvxRPiEv3EhNACq2wloP82KSfPyfh4nkPoJI6KtUkwb6TPY?=
 =?us-ascii?Q?lznUNb0ZowKagTSBPMxrRdSaLwEDfxB8YOPO5JXScc7wceuYZsu8d3ZlDeqG?=
 =?us-ascii?Q?kG8bdAfiVl/jY/UX2KZa3KMXwizfxAJR1+4EMq+PJgJXT7lkynNaFDpkJpaW?=
 =?us-ascii?Q?u+nW31hQaWXhhTiSzLGoAjKNdCj41q8F+yaW4dx5FbXQFS0wM0MjsYXN9Ghb?=
 =?us-ascii?Q?EAf6QW1k7cYayI3fQpIGk7iMYL+KKuGz0OW+TPBZuFQ46thYCOLVO1Eo8tfQ?=
 =?us-ascii?Q?tlB92xXwmtWaBVA8gYABIJfa16OUbN9noTfTzKdONxH88y7gQyvjNlHQ6xSI?=
 =?us-ascii?Q?zICsHS+TOz0EONFEuG5NIQdvwChzw2zaiib4HSnPJ342wj2pif1FwKD6ZhMa?=
 =?us-ascii?Q?/XxD+uSloQjA/qR4EHRnKXvJ56bcC4aD3kgqLIuVTTa9/7D+pJDF2E2GsK86?=
 =?us-ascii?Q?8bHX2Jn2vazA8uio7rS2Dov6viKZ0dqufpGvSmqim/hZ/dtqsa1TCFAn+RJG?=
 =?us-ascii?Q?29TnEn2cUROOsCzEXVFfDsKI5KApK70+Vx4XEdAMUkjiUvXPgAXjm2wBR41l?=
 =?us-ascii?Q?O/FTXQLu+khwHVVp1fxadxonPZDADlJEA0AvLGej/evzqF7piiuT4txk1s6a?=
 =?us-ascii?Q?KOraknWsIuAA6xNJTUs/aBI6UAPVzqLcvkVsi+XGWUATuAw67yF3t9q3dYgD?=
 =?us-ascii?Q?OQa22xUZ3sXo3GjGdXU9Tg+WdBvqMafIPHRhFXrMseIu9dibOTZUsyKNEsK4?=
 =?us-ascii?Q?Hdpeely3EAHqwSpHBETxO1dX17Mk6+KwsoNhy2H0Dkl+jS58af8VnpQpzICW?=
 =?us-ascii?Q?h+GRSLB9NSB0gZdTH+qMfWOIurX2o37yFayeb1o3rofzmRNDAlmhImo+a+FT?=
 =?us-ascii?Q?7/EcYw6non6IyYbIz4H01lGb6Ghhk6KvixW2bXwWhCtSM6gNANwKSGY68vRH?=
 =?us-ascii?Q?qErSVm2O/mAIgCtr0t3mGh/YB22D9y8GE4vU6XwFvZMIkbjlp6XfecF71Gyh?=
 =?us-ascii?Q?gV8CKVA2ceGF8uqP9Xcvl0W566uM9atAcILXlOgJThhZ4W3mRRnvZZ5Ck82n?=
 =?us-ascii?Q?6IuUreOkt/i7AHNEC9sAV2xcUV6yFE+QV1RF19eKwYDKUQsHrbTPsyxY6K3P?=
 =?us-ascii?Q?+yEChfdfLsct/7VgL7SJXAMK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L9OCQPFdplrp+AG/Yqja9ZLAdBDrIWvAtMiAfHH6VDXZWzXcQJzRDI3rXsam?=
 =?us-ascii?Q?dbjTODR2X2UdWIiOjD0evrOD4hzlvj0q2zfk3c2/BO479tncfjM0BjuUA7nk?=
 =?us-ascii?Q?TdA8eIyWpnkC5BYLaKIThKwSdLrdIU5GDQRl7zfdzgQ6z5Fh4A8UNojvOm9m?=
 =?us-ascii?Q?hbsPF234ArY3ZWR0TBALs26WELB6AQT4rf6tSXezSfAOzEc72sXvdsLyk9xu?=
 =?us-ascii?Q?m3qK1BxfBxdDJjDVuv78e+/OGNnyu01IePCsINoET/FlKF/ye4X4AokH6lRL?=
 =?us-ascii?Q?0TAyhgBjCg/UyAlwpOLcmiLUqzSs3v51Fa2vFX0xXAjPB98DTNI5/kYQjFrN?=
 =?us-ascii?Q?VCJbMHhImhisom8/LaisTA4gq+yX/IDAXa/iFOXSMj2yqbcL1H5B6lnPT5FI?=
 =?us-ascii?Q?SycxlxENdVAkj6e0B67NVo/R3cMsY4cgfliZrIWUIOxdekv3EwP6i/p9fD9V?=
 =?us-ascii?Q?NAh1WG6XIVakbsJtOO0kkNi5BxHJ17FhN2rOwtJu+kCBJHtxOuapUZ3W2Sov?=
 =?us-ascii?Q?RBkTTXpGkXhbJC3U8KOktHqPMvXg5CdNscJ0RunXLHV2nyKDtBoPOtgrbhqb?=
 =?us-ascii?Q?p5EfoOxerhnl70aNr36MWQbTK6c5qST+kuhTLt3zhBlXcX8SySqwzB4RhWCo?=
 =?us-ascii?Q?e9ifOw4y0hbNdl3cvY91N097RnfbZEiRDckA7ObW2PVE2vL9BseBlpTIb49A?=
 =?us-ascii?Q?Hw5DM8gzGVd/g5/XBtpPA/mOrhpGCOMg3VjutpaSKjEr4BvNrSp817zGsgVJ?=
 =?us-ascii?Q?PzuDxtYchiBLfIqAvTR5Dg/+MVSQeagVIQol7Zt3MiOVGnFLFV2HmQbylN9L?=
 =?us-ascii?Q?pGdQfaY3SI3xtY+h5/Wu2zNiSh3q0Mbu5y792ZnVI1AYHQYDPnYpFh275Fwq?=
 =?us-ascii?Q?GEHMuPqULFdCWrBz8vZqYlTUoACc0QDbdFy2wZEP2l2bgcGJ+bFrZoQg5Roj?=
 =?us-ascii?Q?mD8F9MMYIvWtlV65pfMe2KBzNRsiaouNukyQV7HRzsC8BrUqvwltxWkfg5Wz?=
 =?us-ascii?Q?/dXvSWFKmKBRLHlvrd9b4ZeJ/vWmbv2bAbU8T72JPNO2mzxbP5RJCUHjAVQ/?=
 =?us-ascii?Q?Kz/LpJ7ckU7U3ngY0JDH4yA8Hlnxy+RQIwOvTZZWzGXtGnN97fCiRD+wNLp8?=
 =?us-ascii?Q?XnaTGlb8Skn7eQoU+qGBGG5LiU24KnPvdp9uZFdePYsg+ynxRmZwm/cu7YCO?=
 =?us-ascii?Q?YQwKoFHJVjDcEVdjzq9NHBG5zDRJ3jbDtSv5mbyiusHjc6mlsKxNF/SEkO4x?=
 =?us-ascii?Q?pFi+xijmrr5jkuXhWPeISDLHEDOZoOdx8I4cAvwCAko+euJrBu+JH6exn+M3?=
 =?us-ascii?Q?gWS2pvIhVw2A7pIC2geHcAzOyklsG8y/M/aE3El7VdlNerXMo3rx3SNKl0B6?=
 =?us-ascii?Q?EZ0KgfODJ6kL9vkatIkaN4Ve3tIIDSHjP2E8Ld4M43bfpsBQxfoCA6m/EN8k?=
 =?us-ascii?Q?rsmkOEZ4Hj0PZ2dgTtU35y/R3pPwsLa4HT6ew+WYdPfwKBKrtHQHwACfcArc?=
 =?us-ascii?Q?iLzpe11HVEPIcew8psHLqbmb5HFO5phZNV/U3LVhUaIBnRwJ8Di58ft7do23?=
 =?us-ascii?Q?2lGFVfCeUkPDG9Hg3flJNeMDcvMSuH3AsydlvgLD8h1G8T8Jj702zRJs2RKr?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sSDDdBF5UKFfWETRgQrCIDTazLp+FSuK2YLzTFfhn7/IsUOnYjdv8NbgbM0kv30FkRu6OjAuu6jHGTNiDRY74TlMRLgA6fSGrRniScExqdts66P+VriPR8NXDZB6TwXUZWGNF74jOPe9vJkVD0XxkAvueLRtL742JwY+tASqQuMs+s2+1NEJGz8oCDOVIvjGUpSMPG+Rr5kMsumy0zj35MgXIYDebZWqRyPJqP8KVWPzOEg9mEpuJssWjitGbUpR/tHiw+3OqRgSRTTxfPY+J+57uqk59XMLc3E2W7Wt0GBW/yKpoPtUy74om3SOJzodz+uN6RD7ir3Xywwr1pc6oHXBW+7m2/xhd9bSAY1IwKdwd9o/PYREdLAULeHZm6WhQGkoShIOQIg2NPj5EOZrw/G5E0SD+IqcuGtGlT5/OfP+m6FFXG2q7i0L39LBSJow9Peg4NHXWXE2iDO6mM+x3vJkCHAJCqZQyjKiJLdM9VOnoYIxBvJ06XdQydM6rXmqp7To7MnrHsxaSiwYVeCVch3sB4SWkTpRj1H+7JBXoB0xV2QGuGZPaX5fsQpnHppwRbI2mkuA++10kfNb6FP4G64pswyu98Br8ODVmdXpS8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a224ba9a-d712-4cb0-0a0f-08dd099c129c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:46:49.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjmlweyZyoJVgFpvr3uP62w24QPBrruYHnHGaGV3Ji2HMqMQlKrmKwv9BBBDYyHXipaILjQgux821BMUIS33CU9w0y0Nlpx5APZWudQO5so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_17,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411200138
X-Proofpoint-ORIG-GUID: xbilo9mEg0U8FE0Hd7ozFR8bS7TUcERW
X-Proofpoint-GUID: xbilo9mEg0U8FE0Hd7ozFR8bS7TUcERW

On Wed, Nov 20, 2024 at 02:49:59PM +0000, Alice Ryhl wrote:
> Adds an MmWithUserAsync type that uses mmput_async when dropped but is
> otherwise identical to MmWithUser. This has to be done using a separate
> type because the thing we are changing is the destructor.
>
> Rust Binder needs this to avoid a certain deadlock. See commit
> 9a9ab0d96362 ("binder: fix race between mmput() and do_exit()") for
> details. It's also needed in the shrinker to avoid cleaning up the mm in
> the shrinker's context.

Oh Lord, I didn't even know this existed... I see it was (re-)added in commit
a1b2289cef92 ("android: binder: drop lru lock in isolate callback") back in 2017
so quite a history of being necessary for binder.

I see mmdrop_async(), I guess that's not needed for anything binder-ish? A quick
look in the code suggests this is invoked in free_signal_struct() and is there
due to some softirq stuff on x86... so yeah I guess not :)

>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/mm.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index a15acb546f68..f800b6c244cd 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -98,6 +98,48 @@ fn deref(&self) -> &Mm {
>      }
>  }
>
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// This type is identical to `MmWithUser` except that it uses `mmput_async` when dropping a
> +/// refcount. This means that the destructor of `ARef<MmWithUserAsync>` is safe to call in atomic
> +/// context.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
> +#[repr(transparent)]
> +pub struct MmWithUserAsync {
> +    mm: MmWithUser,
> +}
> +
> +// SAFETY: It is safe to call `mmput_async` on another thread than where `mmget` was called.
> +unsafe impl Send for MmWithUserAsync {}
> +// SAFETY: All methods on `MmWithUserAsync` can be called in parallel from several threads.
> +unsafe impl Sync for MmWithUserAsync {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for MmWithUserAsync {
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmget(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmput_async(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +// Make all `MmWithUser` methods available on `MmWithUserAsync`.
> +impl Deref for MmWithUserAsync {
> +    type Target = MmWithUser;
> +
> +    #[inline]
> +    fn deref(&self) -> &MmWithUser {
> +        &self.mm
> +    }
> +}
> +
>  // These methods are safe to call even if `mm_users` is zero.
>  impl Mm {
>      /// Call `mmgrab` on `current.mm`.
> @@ -171,6 +213,13 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
>          unsafe { &*ptr.cast() }
>      }
>
> +    /// Use `mmput_async` when dropping this refcount.
> +    #[inline]
> +    pub fn use_mmput_async(me: ARef<MmWithUser>) -> ARef<MmWithUserAsync> {

Again, nitty, but I wonder if this should be as_xxx()?

But I guess this makes sense too.

> +        // SAFETY: The layouts and invariants are compatible.
> +        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
> +    }
> +
>      /// Try to lock the vma read lock under rcu.
>      ///
>      /// If this operation fails, the vma may still exist. In that case, you should take the mmap
>
> --
> 2.47.0.371.ga323438b13-goog
>

