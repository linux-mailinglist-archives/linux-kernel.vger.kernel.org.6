Return-Path: <linux-kernel+bounces-248168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E413B92D912
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCE51F22161
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B471E199253;
	Wed, 10 Jul 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m9tgvcPi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YSbkQXkb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4613F198A2C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639433; cv=fail; b=hlIh4ydPKnJqZxpg+JxFn/lcbVDXCPguC/2yLo7Cwn0unHxSJF4bceaLMe3FiRoF1/kRdpcSygNpXKTx37kP1A57Jz89iYM5udACUdduIWZTd1Ploq/Vr8qcrwq3Zxivb3YKzqjQBEX/rJ843FAr4lxnt7f0psWSkaDzEeRfWN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639433; c=relaxed/simple;
	bh=yX8N7LsOW9s/87ueCYsjONVernMv6kVkqsqW8FgKDEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jOdsmLUlthivZONG/QmRkea7i5K0XQnULXs5tzJTRygguXCl5LOWVEomuWSH4S8vLRhQSD3cR/y1sbheM6x9OOvDZSfkgYVWL7CTubqy+Tpp9ZiooIPGB/NPvIuFQU/N5G815D0TIzVWk6BAO42WLyvMos5wF6CpYW6KRlkE1kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m9tgvcPi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YSbkQXkb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFndMl017517;
	Wed, 10 Jul 2024 19:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=x3Dh8wxvQ7Ko8hZgNHR/qkVD7PKQF7SmmQrEtbUsqKY=; b=
	m9tgvcPiMOkbEx+ahfL6tbLuXGIEIpexhs/2LgEiycKuX0OIieEH56V5m62PlRRi
	EDvGZMHbLlaxSRwppkNb+1ix+4FRuq3LvvYOTqUfIZpnnQEV4mKJyS9AZ6d3c+ye
	ADqOVsrjISzoo6fTvZ1yUoUHGSkkmlrGTxYNG7DM28lLiBn6r8uWXNzm79z6+Th6
	dgrLKoG3a0l/q+4KEtZ8Q9s/WpOiHWKDCual78pbrGtuqKTWZDK9O55zjx5YLPBo
	fi/KrR5U2RUjAQPefXl80d76m0jUFyuvK667LLEk8XCXKaawzajnpoTZDhAqMQtD
	KaIJe3cAyj7tBsQTl6zXDg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybr4d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AInZep030164;
	Wed, 10 Jul 2024 19:23:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vva93av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfYtFpoNJefTBm2W9xqt30706qPth7fS1R0vre41HQ1N06Zba1dDDSRWxd04lwH32Cq2sKGHZTVAzoiTUfdUt1Ngn1AwfJ4UXq+iDe1AZG2P0RojsAXFd93eNjNikV8GAOKi9jKvSAsG/0dNBEd4D2F2I65rQ3FbGZ3lVov1vzvHksF1UAqYxjYXd43ykXYGvCe2b/bHMpeQMygAPmw8qmtI5tPaKuhsq4x2UXWgMbFR7D7qkFe9Ru8orcyrfgT6Ixf91Ef1cY6UuxQdCp88wAOHPnDVJllKE9FxtR8Iqb4cY8A0zRXHhCKdB+ivLdBBmAaK08//QBm0CMSFfXuu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3Dh8wxvQ7Ko8hZgNHR/qkVD7PKQF7SmmQrEtbUsqKY=;
 b=d7wIXyDjN67A6kbvBY5d0dcMSlEIKWOUNgaq53vzZ39myNy27DPDQWCiF3Cw6yvh/ow9h+r9AenrrgYGPQNTewyuJVlFqssIJaPmPb66VdTo6VW5lQYH4mKYFPEvomv82qjjeLnwJ8XSNWQrokGRlZVrNNbAnuDrmaE7Tey3rG+n86MmOD/aB8/pBybyD9YAd7+obVUDchYnn2RYUbOADau5cXjBKXSKPo6bVaYQZvavaWTcPf49dVeKkuSLdGI0/Mxe4798e9c2k5KP5t1FmMYMVPEGMD+pzuDY0R4SUjuxTgwCNQLiV2+AbRAEG4cEloounchV7XQFzXxJ4lbeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3Dh8wxvQ7Ko8hZgNHR/qkVD7PKQF7SmmQrEtbUsqKY=;
 b=YSbkQXkbrMGAo8co8R06aSp2B9OyMaVjnLbH6xkY1gtf/UrbaWHrNIqgWWsGMMPdHHcSK/ySQK2CRQNXhk05UBkHi/sn1jp1UoxwhSlfsO5IkbDXzAaQi9DpQzyDRGV6YYhqFgKPDliqyXT+jC/zCV+roVekrqh806l5ZPl1DIQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:27 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:27 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v4 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Date: Wed, 10 Jul 2024 15:22:43 -0400
Message-ID: <20240710192250.4114783-15-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0425.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ee1e888-9d24-4a9c-2bdb-08dca115c613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?s4gu1sxT+ueLicxayPib0qBDcHI2aTgRAvqhYGw3NSi/t8Oj8eegJVFRGQtA?=
 =?us-ascii?Q?X2pn1WQ5/Y2Wzmd1dcaO4KVu92WZuqtuTST0r1kwTiSwLs8HvMOePmNC9qwI?=
 =?us-ascii?Q?0RVdldfyCSYSGDmmX4zMxVYy52F0J+nkv0YU9eFBr9eqyZz4qaYML2esx9kl?=
 =?us-ascii?Q?XBv689M+7/PSlG/xiQFh5c0yfNmDFRUK+/uRxUDFZH3qe6hhQ8dCqtlMvIXL?=
 =?us-ascii?Q?ACSKUb4Fbhc4Hyc14MJdLVL9D9gI4YHBn5cdmUkLT2Q0DPB2BrDwetqt83Uv?=
 =?us-ascii?Q?agPuveKCuUv59EuFqdTX9agEiAjS1c8k0xMx2g6US7Ya2r+D9/dNgsczNkHi?=
 =?us-ascii?Q?qe7jlA2gjiaoIW86T8JuUN6nNpq85jEjodmzW7jlvurI/TL1iKrqnboeLn/Q?=
 =?us-ascii?Q?0OfsgX8ITLQEOdMdMkmyatSXMpbazkOXzqlGChVjwSxECO+8E41C8OYD1K0f?=
 =?us-ascii?Q?6jS/9N+dOZBGhYm/TV0hQa1poRFodpOUxYpM7DkQnXl4qydKQS/iSHd4lfhm?=
 =?us-ascii?Q?qTvBfugSzegtmQE7ptv4HeGw4mugMOxjWUKMAIs5AXQY2QWD5B52Tit0XyNs?=
 =?us-ascii?Q?er3T/2eBRfVMa70zgAWtBruyx3/Vi/t/xBpwsp4rNia05bWbPaTdtr9iSV+r?=
 =?us-ascii?Q?G3de6op9EJ9P+3XMdaEJ4Jom8ccEkKimXTjtQhManm3XCEpPVo8sqy76h28q?=
 =?us-ascii?Q?YhmOdlBwye03DAzQowTRkVgQ6Dwj0RzW2N0nrQeRn1R8lZojTCoyBmkr5mVV?=
 =?us-ascii?Q?CuziMzUOZXS5ko3W7CWGk0rHXOJVGnS0LCVmeDCiBIPN/qsI1jlcww2vNWYO?=
 =?us-ascii?Q?AyK/ir/S0ZPV9XWyJfw0yOU/FmgQ8mLypj9j5qHwRf9ie3n7cRQ1XbWFgpYW?=
 =?us-ascii?Q?/s19FrdoCcPiHn+vloDYmYOTEjNG5614YJgVC8Djy9BVedEQZ7NaXKLrl0uP?=
 =?us-ascii?Q?6M3SwN2ftnVizKEHiuGSxYxHPUclMFTmcL//B13AKTrrUN+w8rFpkXFNG8Gf?=
 =?us-ascii?Q?RSVjX3zJ/51jHQ4Qxa+oV6MjDYHDW+pgCGDqefCfrm5o3N0SRwzsD1+L2Gwi?=
 =?us-ascii?Q?aZk6xoKbXgIgULsxJD9wd3g6DquSbm5bsV87IGpjDpeQPKLGmKnyRIrp356E?=
 =?us-ascii?Q?0QDxlsx8z7jfZmAZ9aWckFLiiIRHBe/ZT21FW/JtaRCYmE2jP8OiHiHEfLSI?=
 =?us-ascii?Q?Xyg8XlJEgbOTvVE8q383UKiTbA3tmoxyzLwRBRbfYf22dHMuMME4JUapkgFL?=
 =?us-ascii?Q?IrzDWdZ6r+SpTYg5RKAWuYkUU9XhjITW4ds8TzXyPtELaRjxtSWz/h1mLGY/?=
 =?us-ascii?Q?3J+IE+DlJZ4S4ddsfc+lyoQhz57G53mLXwXjxtJlUQwqAw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SlKpdjN9qW+YFB0C3TfKQ1q4ySaIJP3WsGkbaYZfJBBkgDCOiJJhXMD53X6c?=
 =?us-ascii?Q?J088oEwo/pxZpyA+UAVZnZLCDsIMMpm/5unTf4FiBJ5nttf4X0PovS4s1iDF?=
 =?us-ascii?Q?fZRqlHo2A2O5nLN10cvUwvWCOCuR6UFilx9y9Dz8au5wLdiQTZfLA/EqscZV?=
 =?us-ascii?Q?+vmXHEcmJDIaRnjDnJCrPhjoNY/Yhm0t7XruFNs0WaDC/b97eZapBUj8hRBH?=
 =?us-ascii?Q?EzV47vjRlAb1Pz14DSm9JsHjdUuCvJx5n/WAZtkp5y4Nz/tLFkhy05W6ptbW?=
 =?us-ascii?Q?XFbtNXKGRguyIs+OStDjzbZVptWbelCDYW0XKV2lnPAahXq1wG2r1mBurBES?=
 =?us-ascii?Q?6Ohh7X4iMzl9e1kJk5V/AJtmfM6/EnwuWyTr/wR3ukbUCbBERZ5M62Oc6wYF?=
 =?us-ascii?Q?Dx7UpkfvNkgmdZEMbRg9lIwCkbu+jTywujJhEcpsFu0VW8JkbMbeTRoGNjvI?=
 =?us-ascii?Q?RRDThpQZyce1Rb5pn6whAwdCzZqhi23a2ESIkvdGw+64xX1O7xbN4EmK5TGw?=
 =?us-ascii?Q?ltv9ipsDfugwyY4TCGAdfPVvBhj6bf8V+kb0gY8G2XJOl7je8V1xwYqJsh7z?=
 =?us-ascii?Q?vk9ofolQZFmCKzmyFtsJdvcdOQKBcBrVUJxL08XtDTYc7MVLr384maP2T6j/?=
 =?us-ascii?Q?0l4G4JBkMUV8bgBdFY8fO4xgEZuWEK7k61P0Y5M9CRvg3tlcwm+AuEx2ppli?=
 =?us-ascii?Q?p2k3FiK7UunAJos/kKqSRCO9Mr1Zh/PpuSLxXOErsz8j2drcq1wFCQLXuFWk?=
 =?us-ascii?Q?2D7HsvYxs211JN2MyLOBz7VLeWvOIHNLV/OvmwNY7Z6858NtqGRtU4o1MGpj?=
 =?us-ascii?Q?bwMDQMQkZzCADZfGcRkbjbq5ww50MYTNsQj3dH9lRY/i5+d9uWqb7wC0jpFm?=
 =?us-ascii?Q?jnX7ZprABdY8SA5UXoq3c7Nu8VQjiOocOra98pKZ6zwtLJXZsarQvFnMNjIX?=
 =?us-ascii?Q?S2P4IBUmiOpxIUDTXfX/ARX4tGZV3JQ8/+8p9mNOSZqXJB0/xJNvma08fMsB?=
 =?us-ascii?Q?FxVUHofzHXHk421QTgRGJ9VsZ1PoMngStfnDcuh+pOepruur6ZM1YIWv4h79?=
 =?us-ascii?Q?WmvI5y17NY0ilT6y1yWieWftxSB+YGplBVsokHrn2S9sWjct051uhjPsno0X?=
 =?us-ascii?Q?84ma4JubMg0kxsG8vNAoazZeDcNYUrB2FQqBYLmutzvFARn4HYG/BnJIZfi2?=
 =?us-ascii?Q?aZF9qx7PMONYMonvJqxpYX5iVN0T08xH3ke+/Q1OL2pUJ73sjDSdNylyYzEl?=
 =?us-ascii?Q?4Ac9mzpu0snCh9bBifFC62X+QglSV6Mvln4XqTqPK3SWlszTm5tK9uCV9Vni?=
 =?us-ascii?Q?qjpK162Xwa/kw5/j6ONUUHdbu9p0fr0KMOafBzYJUwLltNMyuvpe3t76Slk1?=
 =?us-ascii?Q?4hH3uhKyq0v7vmg7NttpIpwi0o/iBULAHGsrWIx9HEZOB8vOJIxDn0elX3Pt?=
 =?us-ascii?Q?NU0W7JiAMJ0fJ9khITmE3YamP4ZcSOnbLFUeo0G3ZWGoVCGMBYOHvEgGixkv?=
 =?us-ascii?Q?Ll5zkBWJQcQO+YsBsTS8fSu+oQ3QsoJpWm/frE6lD0bjBWWaXLLdGagyuUTY?=
 =?us-ascii?Q?lOjYCjcN5LpfxeI8wBUesZwNoG4apOjRM3/xc+HBrp/T0DdYR6tWyJJYXuPy?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KPOpRqO8B8fYwlOONyZhLy3dsEiK1gCXIhMfvRyGCFkptY6U41EjPdkFwenkvI+sciNcfB6Gxaw2nrsmSlfRqAUV1D8xAjU2pmkjwAuexfDC2j5sOy252W71BJMyLl8i9nGPYv59ccZxNs1jkjekIA3TldFuxFztt7Gv/V/BoYjk1BKa3QkaOmeg4qm/kH6e1yhLdGZP0wOTw5aUD4fS+EuX44e1MpuOT3iClKaZ28Es5a307oA4NExoXQx/kk1BUWamIFNgkZelU4MJXpkF08E1I+iD4Ps/I+lukkQhMdAvXtLrhdJC8B1BuQOEyrIWoaNKBjSlRbahuto6FJFZwYp2A8mBCwSNiL5HyKXxTVavXD7NCnozJhuvGdsOykeA9sAYAQdLJIB8J7NJSlKoe1fFC4upmmUKji0W2fBd5HYxc9K9NR4kmDyxNBtK+ZfpbhYe4V3wBJRY2S2MfqmsjQQoyy1UkPMzrt4EULKXLdwr1EfeqHwwEx30OU17pSbkfHTgXfQ/QrQ8rLix67+dsbznydSuFHplQcO9aF3Uj9oxl2d0p+rc1hUQlbxjt0CiqB2n7646YFLWiJLsFON+SyKLKCtwbzCGwcQd5qNiMGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee1e888-9d24-4a9c-2bdb-08dca115c613
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:27.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAUJ1qieSkKx8RjVpsa+4BqtqHnyBmzT15nrYIT/q29ubnEb50JSiOCXt1KJZDC/vqaU9vX+I9TNyWxLJYM9fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-GUID: rf5rLuU3R7r7MdPFdrIn9wkhYBwJkwhV
X-Proofpoint-ORIG-GUID: rf5rLuU3R7r7MdPFdrIn9wkhYBwJkwhV

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of zeroing the vma tree and then overwriting the area, let the
area be overwritten and then clean up the gathered vmas using
vms_complete_munmap_vmas().

If a driver is mapping over an existing vma, then clear the ptes before
the call_mmap() invocation.  This is done using the vms_clear_ptes()
helper.

Temporarily keep track of the number of pages that will be removed and
reduce the charged amount.

This also drops the validate_mm() call in the vma_expand() function.
It is necessary to drop the validate as it would fail since the mm
map_count would be incorrect during a vma expansion, prior to the
cleanup from vms_complete_munmap_vmas().

Clean up the error handing of the vms_gather_munmap_vmas() by calling
the verification within the function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/internal.h |  1 +
 mm/mmap.c     | 80 +++++++++++++++++++++++++++------------------------
 2 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 11e90c6e5a3e..dd4eede1be0f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1503,6 +1503,7 @@ struct vma_munmap_struct {
 	unsigned long stack_vm;
 	unsigned long data_vm;
 	bool unlock;			/* Unlock after the munmap */
+	bool clear_ptes;		/* If there are outstanding PTE to be cleared */
 };
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
diff --git a/mm/mmap.c b/mm/mmap.c
index 870c2d04ad6b..58cf42e22bfe 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -401,17 +401,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 }
 
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end)
+		unsigned long addr, unsigned long end,
+		unsigned long *nr_accounted)
 {
 	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
 	unsigned long nr_pages = 0;
 
+	*nr_accounted = 0;
 	for_each_vma_range(vmi, vma, end) {
 		unsigned long vm_start = max(addr, vma->vm_start);
 		unsigned long vm_end = min(end, vma->vm_end);
 
 		nr_pages += PHYS_PFN(vm_end - vm_start);
+		if (vma->vm_flags & VM_ACCOUNT)
+			*nr_accounted += PHYS_PFN(vm_end - vm_start);
 	}
 
 	return nr_pages;
@@ -524,6 +528,7 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
+	vms->clear_ptes = false;	/* No PTEs to clear yet */
 }
 
 /*
@@ -732,7 +737,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -2606,11 +2610,14 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 }
 
 
-static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
+static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach, bool mm_wr_locked)
 {
 	struct mmu_gather tlb;
 
+	if (!vms->clear_ptes) /* Nothing to do */
+		return;
+
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
@@ -2624,6 +2631,7 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
 	/* start and end may be different if there is no prev or next vma. */
 	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
 	tlb_finish_mmu(&tlb);
+	vms->clear_ptes = false;
 }
 
 /*
@@ -2647,7 +2655,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
+	vms_clear_ptes(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -2799,6 +2807,9 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	while (vma_iter_addr(vms->vmi) > vms->start)
 		vma_iter_prev_range(vms->vmi);
 
+	/* There are now PTEs that need to be cleared */
+	vms->clear_ptes = true;
+
 	return 0;
 
 userfaultfd_error:
@@ -2807,6 +2818,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	abort_munmap_vmas(mas_detach);
 start_split_failed:
 map_count_exceeded:
+	validate_mm(vms->mm);
 	return error;
 }
 
@@ -2851,8 +2863,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 clear_tree_failed:
 	abort_munmap_vmas(&mas_detach);
-gather_failed:
 	validate_mm(mm);
+gather_failed:
 	return error;
 }
 
@@ -2940,24 +2952,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	pgoff_t vm_pgoff;
-	int error;
+	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
+	unsigned long nr_pages, nr_accounted;
 
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
+	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
 
+	/*
+	 * Check against address space limit.
+	 * MAP_FIXED may remove pages of mappings that intersects with requested
+	 * mapping. Account for the pages it would unmap.
+	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
+		return -ENOMEM;
 
 	if (unlikely(!can_modify_mm(mm, addr, end)))
 		return -EPERM;
@@ -2974,18 +2981,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			goto gather_failed;
-
-		/* Remove any existing mappings from the vma tree */
-		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			goto clear_tree_failed;
+			return -ENOMEM;
 
-		/* Unmap any existing mapping in the area */
-		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
 		vma = NULL;
 	} else {
+		/* Minimal setup of vms */
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
 		if (prev)
@@ -2997,8 +2999,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = len >> PAGE_SHIFT;
+		charged -= nr_accounted;
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto abort_munmap;
+		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 	}
 
@@ -3047,10 +3051,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}
 
 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -3059,6 +3061,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (file) {
 		vma->vm_file = get_file(file);
+		/* call_mmap() may map PTE, so ensure there are no existing PTEs */
+		vms_clear_ptes(&vms, &mas_detach, true);
 		error = call_mmap(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
@@ -3149,6 +3153,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 expanded:
 	perf_event_mmap(vma);
 
+	/* Unmap any existing mapping in the area */
+	if (vms.nr_pages)
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
@@ -3196,14 +3204,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;
 
-clear_tree_failed:
-	abort_munmap_vmas(&mas_detach);
-gather_failed:
+abort_munmap:
+	if (vms.nr_pages)
+		abort_munmap_vmas(&mas_detach);
 	validate_mm(mm);
-	return -ENOMEM;
+	return error;
 }
 
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
-- 
2.43.0


