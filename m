Return-Path: <linux-kernel+bounces-555094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E43A5A555
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E88918925A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD31E47AE;
	Mon, 10 Mar 2025 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JPG8LQpy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uh92e+t3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC81DF26A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639918; cv=fail; b=ni498u62Qez+si/5k0EpId9eoQ8oTRAeNuVPYNymLGzjMOC3wFDBOEVa4eLJNRTnwhBxLA9S8XIeHqM029el2bnTJnp83SHK9Whr0aplKyZw0Sh+td6e/XQWrzzbzIDlAXtD4vbv3IUhlKkMki348DU8aNudPGGAUL8Ni2Xtc2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639918; c=relaxed/simple;
	bh=k++NP4RpuHULGmCMer4GdABYCWAmOKrpdPJUJz1vSLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0rb+oo4DtjR8vVeDvhAiXDYd2pRart15tycGo4hGpk8z+VAZv4TylZK791v98+ovQThhKEA+lTsRHryhXpR7nNKvYJMkc3GxGfiDBMF3sxp7evs0S3TR/lwu48GkpReKUIbAR6xi0mt00T0qSN6QMbgdifzTbmCPea1TZNbTZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JPG8LQpy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uh92e+t3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJtlPc023523;
	Mon, 10 Mar 2025 20:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kYvPH1xqsucyarxMcUO2+UA36cQxvVaeGgCKwzhQaf0=; b=
	JPG8LQpyulAtBEODvzZ9K8fb4TMlpMOZE6jOV3A6h9YK1e5PYZd1eyUoyBWlxFWq
	grd6QqvPoj6ltdzKff+9uOP1miRKf0gJZG9T29EAFM017vsbQsLJYSOfBcLge7ZJ
	lSqc2zebe3XuHEgHLy0oSNQrYIjbTvRNDF5eJLlouucPaBUzMbQ4fiCI2KDevuhS
	LBdT3MqHWUeFOcfLm00r5pGjUaKCwn5nHnDr/8M+q+athXH69A8THyszVNnM5pYM
	zLTPsn6e9d7xsAeu27dCiN3bGWjv8U42eUk2sePWNVdtmczFX2CE6MwkfXCR/Fkn
	ExM2NCVeFi04Kf6BwmbHpQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb3m7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJmvP4030644;
	Mon, 10 Mar 2025 20:51:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458gcmgcuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inID2LYUTqQwsaTgjdGveTDKVfpkCkH0kzkI28kD3Pzqu8Mvhm+sHJ0Hbao8NmmBLvXkVCSXRTh41Q1btOJTHPAfJdW9SNEfRAagKW7tEZglcFtu9SKNaWBBf3dlTJQ4lhw3xNNnidJqzbBa0xrltQbu06gGmiuhoFNwzYptzDzP3EaCBz8zqM2U/gIw3OmtAZCgslXgEDLVL7WOgQdq/34HwlYIXC1FsKHMp3t+vZsMNUvZpsRt4vaBTkO00wFQjw2jI7nhA+0BLFHrKFcxQwHnU+tnOgxWjgPbVkpwy1t/w51jVOHSep4v6r3vq3bW01EiJjsF1zbWYfSlJrWLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYvPH1xqsucyarxMcUO2+UA36cQxvVaeGgCKwzhQaf0=;
 b=koM6tBriC3P/GwCGFvh8cV2b0uH4msrZa5OkWltwANNpzzYNsgGUFVwjxAwCspm/cDbZ6FJPGwtC7sTVzVu7R27g2s3HHBNT9WdM8nITuetg0dsyGVutehmAJluh4ZlcDgh2zrp6Yjjta2w5JQ9MVLdIOKiu/I9//JcTN0tYUw4etFM4dp1dBJTuDppOeNTot5euXOnhkmS1UK48Yjxt1umEryvLhTvPHcppAGWNlOfDFn6IediaLftnEalZslvVEUc3+Oj89x9+KUjvcHCyDspkCH3o2aT62id6aBabUHz7U/0voW6ICdJ2uycNn/RT+f69Mpa+nLiv/p+jysyWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYvPH1xqsucyarxMcUO2+UA36cQxvVaeGgCKwzhQaf0=;
 b=uh92e+t3g+mzJaQ64QRT5O5uNafRtNt7UK/sww6OepTWm7kwFmgoaTecURo3QMtydDXBRebqBiKYuSxT44Blt5QTCv0sBIxN6U8aU0fJGTxGas81fHr7fFw0uuE+tOMQJgwAOCDT5rR6jsEzYM+GLiWunHEpDv+ylMSzPT/BegM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:51:34 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 20:51:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 5/7] mm/mremap: complete refactor of move_vma()
Date: Mon, 10 Mar 2025 20:50:38 +0000
Message-ID: <e7eaa307e444ba2b04d94fd985c907c8e896f893.1741639347.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
References: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0432.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::36) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 0593843c-9e42-4989-cc7f-08dd6015579e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gj8tvzM+yfpZkKJ4opUv20PcfEmlYowfr03KhNk+Xu4LeAEfqwaouQNANQBc?=
 =?us-ascii?Q?UM8ukSmjjw1IM4s6TYweOEnndmgL5DSVBlHzWm03OkkvY9UnE7nRdYGuHQ8e?=
 =?us-ascii?Q?YuN/PlKgZMFulnhV9UlNHKLWzQr2ytzYOGENyyAQBplmiMG5jIHmgKQc3t5J?=
 =?us-ascii?Q?OfFqrlfKhVMskRHVtlirP5mx9MUeJy/Wh9fl/zipZmRwtLWf56EhvgSChasA?=
 =?us-ascii?Q?lXrn0pqiQoLiS8gezK/7N5CoTWr0r4bK+RFqDTmid+bMviq2XNr6OG4yrWub?=
 =?us-ascii?Q?MFabVSMmc+/S1mcqIj23t27/qAj7L1GHBFZY5x9/H3R9usSRZ739ew1gfSGi?=
 =?us-ascii?Q?NeFeJSQXAQVIqmGTCzYtKAx+0YtfcUHgd2+r065YYY+60qHQcPkJGBuF4YTC?=
 =?us-ascii?Q?N/c3giwk7CxZ03u/SyRNPhd1csJhTSJCAxsYDSkcREnglY868dyg4pvXWD17?=
 =?us-ascii?Q?c717UgjUQVWZnmkkRSOYqhkgW2JnSsaHUpRQT6WMBsbiBgc6LQnzfcbT+cpl?=
 =?us-ascii?Q?rGTuumGAhAWmLE6e7+TApdGGdM5vw9vsGAd0O/b0ks3jNR5pzgMKemSIins1?=
 =?us-ascii?Q?W8dwzam3dxqhOn7IE52URUsknT0NX/EF5n6syYvGzVbWzC7idCHLbLmbLMl3?=
 =?us-ascii?Q?Kso/HAj9H3pJtSPEM3xgFSuu9Dv7rO69WIWbcFKlC2qRATizIqbgkIsz9ITo?=
 =?us-ascii?Q?jt2Nq1gieCPiUYmpZC39mXU9cJvFOqluxcE8i6GahoirsenxUO81IEp9oFr3?=
 =?us-ascii?Q?P6IsEkPYF78FBnydGmeTfxSwu2FCE4lCTzRrrdXKwR1xY0DwIR50Cx69qIeh?=
 =?us-ascii?Q?TVGpZ5gl6t+rSeVn51uEHjgxbY1++ACbWZhBJg8JPOSRnyFmGEqNVHgZVjQb?=
 =?us-ascii?Q?xPTpykIdF7lmvSsr4+AZGM52W3sTB+F5hjO/p4kl40s0mh9/iSYrUX5Wet1U?=
 =?us-ascii?Q?Igfgm41a1fLsLo9xhafIwlj1f5ByQG/5EW17xEKX8fHrnIjSLqbIBpjnmsF6?=
 =?us-ascii?Q?tMvHvj5YB+ntASefh89VC/s0qoDclmYrfQbI4Xrji1ycQYkYwfPuL56nkLmG?=
 =?us-ascii?Q?wZmv7qFgFto5iqVpfNh4rTpDZKL4NabF8ppXXLvs2gNDfxVaDR6kQs7hMaIr?=
 =?us-ascii?Q?ETbWV4neOZrz6gdmq2UIdbflT0P87ousYPKjpwOnTBam/xfeKDcKuEtr2M/o?=
 =?us-ascii?Q?nL6ervArFmx+OdPQYBYjIy44UGXCauzr0Mc/L8fJDpDm7kJo+ZcxAG+ksBkz?=
 =?us-ascii?Q?G418QMIvDUrQ1nmp1W7Xsci/srFtMPK8cbkpikGtTcxSg/vksCxzd43WxdAZ?=
 =?us-ascii?Q?q7QamJnu5Gby7gMoYcssfaBmJ7u2+TTm4+B56yJMH9c0t+WFWqiftXnV10x1?=
 =?us-ascii?Q?z+0gG+4fcQt4EPmhJN85k+6BEyGk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/E4BmOzNOxcT6/GokfDL13Stu2fuDI5bKqdH3/JRYNzrH2yTYB5hArNFxtzE?=
 =?us-ascii?Q?XBANNHuBkpD9KhazkcIUKeg8WpLV0OVq+dwcP3LHuJhzwRUe0Zp9eo6sScxk?=
 =?us-ascii?Q?os3xafbUvBTE6vO3QWuAv3IlmTuz8ipOf3TCfx2kQY3OktKVhsXkPTkAU8KR?=
 =?us-ascii?Q?DFelKsgs40V6H9GsXkPk1V4RFfM9RsM8skll9tFaqXo1ClfqsXN5FA8wN95k?=
 =?us-ascii?Q?tGJ2wH5/vcJ48iF5L6MLgQECU2AOoQRfe2umld5bJ9I5rnvyPIOf9TP4Ja/J?=
 =?us-ascii?Q?CaiS9Dhyy63163JfXfI3Neo26xTE0CCve1YHwMnGYpQ+6ASgXfuvP7lRZesu?=
 =?us-ascii?Q?qBOwWQow4rOxMT5qGmoBXRNomagZYcEKGRn0Tc2Hx51rzv9cwWpXSnfnyHlw?=
 =?us-ascii?Q?lw86UdW2BBnwOdurFP4jL4T2/VXIzk5LTmzUxIueiY0Q07H6dwuUDV1UHwcR?=
 =?us-ascii?Q?/40oVmV01gLmqC0iYWGv1cyHP3xDZ1ZYweummRmw5DsCCHH5y3cAX2NNNrLf?=
 =?us-ascii?Q?qolD4xmrEQTijvEKjyH1suLWyKOXu64nOdnwDEWlIEqtOVl+hJMHHtv7Nh/z?=
 =?us-ascii?Q?Z/abbCME4hqmG2N8QvC4Wl1jnp+CT4k00scH+qNG5d2xUQVA6Cq5o+dXew/K?=
 =?us-ascii?Q?exA2G+62JGINjm/d5IkFtBreXFrifGTWkKY4L+sJl+jZEFJWSt4/GtbKMWd+?=
 =?us-ascii?Q?skllAZZP+p3BPrzQoeUfycvhbcNfbR9R6JhlCrVEi35DcuBZ1ycBb+tADgoq?=
 =?us-ascii?Q?/nZfLyYeyuRksJxJ9pS/xR5vXIF3aB9OP6vtHcH09cKBKclpl2GGeVn75dKQ?=
 =?us-ascii?Q?DPnmPL8n2mEWhAxt4HwejlFPHEYmmzuAkSdsKRmwjaMo92gxtjmX0Ign0eUm?=
 =?us-ascii?Q?j6CTH4bohS4KdvwRm7D2KrOW5KOKgIL+tW+NeQshTYUSuUdcOHKH7ATnM6u8?=
 =?us-ascii?Q?wngRZXwPGnQZz17Hzk9uraVBj7p21d93Boo6Y8hvLXeDLZQPPSM+9RajpD56?=
 =?us-ascii?Q?nTcYdo+TKVMAle4tL0bMdzn1hl8bE/BZd8i62i6X/WozQaXbMVcbYZXf7ph5?=
 =?us-ascii?Q?+BSsdXg2MntS7C61/oXKxpkjirjvQwEaQsSHtXgOcSYFuxlU7QYhE6GAIqaO?=
 =?us-ascii?Q?DXuk6gz3QtyEgWTJX1chQxrkAXz7BUd/XaY99rlcTUDZNOCqADg2XBpsTsdx?=
 =?us-ascii?Q?iDWT3GkfTwCqMJ4H85gBloOx6LI1mRyCRui4diNIyljAe1/ch/9C6/ZwKHP7?=
 =?us-ascii?Q?ZWoE78dbbTNGAFCV9uaucPCyP6pDW6Rzi1XWxRpPjrlWxvALZYRz5bX7RWiL?=
 =?us-ascii?Q?eihV0Cr3i/+WfmJlIHKUYfU0hMvz18qUgLMeFiDqR/nSUS/CWMwDD3fOy+Pi?=
 =?us-ascii?Q?D+OdRAcgjEJACG1X8HE6q+WwO9w2aPKcXqswRYyDicAT2DNYK7p2YMonjwco?=
 =?us-ascii?Q?ZAmsuY++gXTll8zMov96Pp7P8hwDtr+gfIeIlCzaxcjnbKcoHBUYqJL54U3E?=
 =?us-ascii?Q?BD9xLG0LgUjydZdwLn1jK39KKyU0p2GcmUXwCdfM9IlvJEYY08EuSAp/JEgF?=
 =?us-ascii?Q?simgDjrL449PA1OpEJvCpetYG5HEL6qCxHjpy0GzZUfZq8BwyffUGi4C79sO?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	63qCSfllHxN9mfT2rgnNqccA2QuCeqxw6I6OdZ4C0x15f0O+ab5ewsuEcx87g1OIP2DRxvNKLYTt8Qxx23zJ6KYr3VjbICr1VeoAfCTti6ommFQzdIgRWorqJX8H/++VdvI6Zrieb1lxeMpt1CQQFhvZYi5/cveZ0TMPI07g8x//ab2x1DqP3yvnofmihpPaBmAQR/WZ49SUs9FV5knZaY1jemPfNQBHbTxGkctpTRt2wMK47ds1DH+x+5AribllFn0NXbGedw7hCVzEEvueQiytrL6fSten/gzuQAAWSx+NQJ2+nwBmOfIAj2IUs55UWZqOr1Sf3jLRM/uxseUe38n96Rg1HVMjz47/xouK/ItjKDpAL5+bUH11XplkHT0T+2hSt6e4l74OCrB+SzOV4GV3AY4W9ySF7cwOyQXFmKZ0R3d4khlA31bj/SaJy7RdjJMJMWamyfXIrjX9833az8Lcq8qkYi+YJDjgnm8+707lym4+jsd78toOTiQx/5q6GUUHH7ABl/kGVc6j6XeQaJpYuqgKWkZEuwFno6et3+ajBvyox4uRrrItgL2wQ6D7Dat5Ad4irbDp8I52UNQ/Cs8R+Gc8U9hokSiGZ4EWgI8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0593843c-9e42-4989-cc7f-08dd6015579e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:51:33.9355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60/YD7pzpUdPk8ECfdJ7pueLkojXU2uiFC64QVfPUOeWQGQbxB1s98o5v6bKADI+LoPm+BhUHaMK4KtThb5mGAI803ATRoEpoXyX1GULByI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100159
X-Proofpoint-GUID: hzCifiA9qfLwkauq-OUaxv_zvqcjJCAw
X-Proofpoint-ORIG-GUID: hzCifiA9qfLwkauq-OUaxv_zvqcjJCAw

We invoke ksm_madvise() with an intentionally dummy flags field, so no
need to pass around.

Additionally, the code tries to be 'clever' with account_start,
account_end, using these to both check that vma->vm_start != 0 and that we
ought to account the newly split portion of VMA post-move, either before
or after it.

We need to do this because we intentionally removed VM_ACCOUNT on the VMA
prior to unmapping, so we don't erroneously unaccount memory (we have
already calculated the correct amount to account and accounted it, any
subsequent subtraction will be incorrect).

This patch significantly expands the comment (from 2002!) about
'concealing' the flag to make it abundantly clear what's going on, as well
as adding and expanding a number of other comments also.

We can remove account_start, account_end by instead tracking when we
account (i.e.  vma->vm_flags has the VM_ACCOUNT flag set, and this is not
an MREMAP_DONTUNMAP operation), and figuring out when to reinstate the
VM_ACCOUNT flag on prior/subsequent VMAs separately.

We additionally break the function into logical pieces and attack the very
confusing error handling logic (where, for instance, new_addr is set to
err).

After this change the code is considerably more readable and easy to
manipulate.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 293 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 204 insertions(+), 89 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 6305cb9a86f6..7dc058d5d5e2 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -884,13 +884,13 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
  * Perform checks before attempting to write a VMA prior to it being
  * moved.
  */
-static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
-				   unsigned long *vm_flags_ptr)
+static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err = 0;
 	struct vm_area_struct *vma = vrm->vma;
 	unsigned long old_addr = vrm->addr;
 	unsigned long old_len = vrm->old_len;
+	unsigned long dummy = vma->vm_flags;
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -916,56 +916,151 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm,
 	 * so KSM can come around to merge on vma and new_vma afterwards.
 	 */
 	err = ksm_madvise(vma, old_addr, old_addr + old_len,
-			  MADV_UNMERGEABLE, vm_flags_ptr);
+			  MADV_UNMERGEABLE, &dummy);
 	if (err)
 		return err;
 
 	return 0;
 }
 
-static unsigned long move_vma(struct vma_remap_struct *vrm)
+/*
+ * Unmap source VMA for VMA move, turning it from a copy to a move, being
+ * careful to ensure we do not underflow memory account while doing so if an
+ * accountable move.
+ *
+ * This is best effort, if we fail to unmap then we simply try to correct
+ * accounting and exit.
+ */
+static void unmap_source_vma(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned long addr = vrm->addr;
+	unsigned long len = vrm->old_len;
 	struct vm_area_struct *vma = vrm->vma;
-	struct vm_area_struct *new_vma;
-	unsigned long vm_flags = vma->vm_flags;
-	unsigned long old_addr = vrm->addr, new_addr = vrm->new_addr;
-	unsigned long old_len = vrm->old_len, new_len = vrm->new_len;
-	unsigned long new_pgoff;
-	unsigned long moved_len;
-	unsigned long account_start = false;
-	unsigned long account_end = false;
-	unsigned long hiwater_vm;
+	VMA_ITERATOR(vmi, mm, addr);
 	int err;
-	bool need_rmap_locks;
-	struct vma_iterator vmi;
+	unsigned long vm_start;
+	unsigned long vm_end;
+	/*
+	 * It might seem odd that we check for MREMAP_DONTUNMAP here, given this
+	 * function implies that we unmap the original VMA, which seems
+	 * contradictory.
+	 *
+	 * However, this occurs when this operation was attempted and an error
+	 * arose, in which case we _do_ wish to unmap the _new_ VMA, which means
+	 * we actually _do_ want it be unaccounted.
+	 */
+	bool accountable_move = (vma->vm_flags & VM_ACCOUNT) &&
+		!(vrm->flags & MREMAP_DONTUNMAP);
 
-	err = prep_move_vma(vrm, &vm_flags);
-	if (err)
-		return err;
+	/*
+	 * So we perform a trick here to prevent incorrect accounting. Any merge
+	 * or new VMA allocation performed in copy_vma() does not adjust
+	 * accounting, it is expected that callers handle this.
+	 *
+	 * And indeed we already have, accounting appropriately in the case of
+	 * both in vrm_charge().
+	 *
+	 * However, when we unmap the existing VMA (to effect the move), this
+	 * code will, if the VMA has VM_ACCOUNT set, attempt to unaccount
+	 * removed pages.
+	 *
+	 * To avoid this we temporarily clear this flag, reinstating on any
+	 * portions of the original VMA that remain.
+	 */
+	if (accountable_move) {
+		vm_flags_clear(vma, VM_ACCOUNT);
+		/* We are about to split vma, so store the start/end. */
+		vm_start = vma->vm_start;
+		vm_end = vma->vm_end;
+	}
 
-	/* If accounted, charge the number of bytes the operation will use. */
-	if (!vrm_charge(vrm))
-		return -ENOMEM;
+	err = do_vmi_munmap(&vmi, mm, addr, len, vrm->uf_unmap, /* unlock= */false);
+	vrm->vma = NULL; /* Invalidated. */
+	if (err) {
+		/* OOM: unable to split vma, just get accounts right */
+		vm_acct_memory(len >> PAGE_SHIFT);
+		return;
+	}
 
-	vma_start_write(vma);
-	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
-	new_vma = copy_vma(&vrm->vma, new_addr, new_len, new_pgoff,
+	/*
+	 * If we mremap() from a VMA like this:
+	 *
+	 *    addr  end
+	 *     |     |
+	 *     v     v
+	 * |-------------|
+	 * |             |
+	 * |-------------|
+	 *
+	 * Having cleared VM_ACCOUNT from the whole VMA, after we unmap above
+	 * we'll end up with:
+	 *
+	 *    addr  end
+	 *     |     |
+	 *     v     v
+	 * |---|     |---|
+	 * | A |     | B |
+	 * |---|     |---|
+	 *
+	 * The VMI is still pointing at addr, so vma_prev() will give us A, and
+	 * a subsequent or lone vma_next() will give as B.
+	 *
+	 * do_vmi_munmap() will have restored the VMI back to addr.
+	 */
+	if (accountable_move) {
+		unsigned long end = addr + len;
+
+		if (vm_start < addr) {
+			struct vm_area_struct *prev = vma_prev(&vmi);
+
+			vm_flags_set(prev, VM_ACCOUNT); /* Acquires VMA lock. */
+		}
+
+		if (vm_end > end) {
+			struct vm_area_struct *next = vma_next(&vmi);
+
+			vm_flags_set(next, VM_ACCOUNT); /* Acquires VMA lock. */
+		}
+	}
+}
+
+/*
+ * Copy vrm->vma over to vrm->new_addr possibly adjusting size as part of the
+ * process. Additionally handle an error occurring on moving of page tables,
+ * where we reset vrm state to cause unmapping of the new VMA.
+ *
+ * Outputs the newly installed VMA to new_vma_ptr. Returns 0 on success or an
+ * error code.
+ */
+static int copy_vma_and_data(struct vma_remap_struct *vrm,
+			     struct vm_area_struct **new_vma_ptr)
+{
+	unsigned long internal_offset = vrm->addr - vrm->vma->vm_start;
+	unsigned long internal_pgoff = internal_offset >> PAGE_SHIFT;
+	unsigned long new_pgoff = vrm->vma->vm_pgoff + internal_pgoff;
+	unsigned long moved_len;
+	bool need_rmap_locks;
+	struct vm_area_struct *vma;
+	struct vm_area_struct *new_vma;
+	int err = 0;
+
+	new_vma = copy_vma(&vrm->vma, vrm->new_addr, vrm->new_len, new_pgoff,
 			   &need_rmap_locks);
-	/* This may have been updated. */
-	vma = vrm->vma;
 	if (!new_vma) {
 		vrm_uncharge(vrm);
+		*new_vma_ptr = NULL;
 		return -ENOMEM;
 	}
+	vma = vrm->vma;
 
-	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
-				     need_rmap_locks, false);
-	if (moved_len < old_len) {
+	moved_len = move_page_tables(vma, vrm->addr, new_vma,
+				     vrm->new_addr, vrm->old_len,
+				     need_rmap_locks, /* for_stack= */false);
+	if (moved_len < vrm->old_len)
 		err = -ENOMEM;
-	} else if (vma->vm_ops && vma->vm_ops->mremap) {
+	else if (vma->vm_ops && vma->vm_ops->mremap)
 		err = vma->vm_ops->mremap(new_vma);
-	}
 
 	if (unlikely(err)) {
 		/*
@@ -973,28 +1068,84 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 		 * which will succeed since page tables still there,
 		 * and then proceed to unmap new area instead of old.
 		 */
-		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
-				 true, false);
-		vma = new_vma;
-		old_len = new_len;
-		old_addr = new_addr;
-		new_addr = err;
+		move_page_tables(new_vma, vrm->new_addr, vma, vrm->addr,
+				 moved_len, /* need_rmap_locks = */true,
+				 /* for_stack= */false);
+		vrm->vma = new_vma;
+		vrm->old_len = vrm->new_len;
+		vrm->addr = vrm->new_addr;
 	} else {
 		mremap_userfaultfd_prep(new_vma, vrm->uf);
 	}
 
-	if (is_vm_hugetlb_page(vma)) {
+	if (is_vm_hugetlb_page(vma))
 		clear_vma_resv_huge_pages(vma);
-	}
 
-	/* Conceal VM_ACCOUNT so old reservation is not undone */
-	if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP)) {
-		vm_flags_clear(vma, VM_ACCOUNT);
-		if (vma->vm_start < old_addr)
-			account_start = true;
-		if (vma->vm_end > old_addr + old_len)
-			account_end = true;
-	}
+	/* Tell pfnmap has moved from this vma */
+	if (unlikely(vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_clear(vma);
+
+	*new_vma_ptr = new_vma;
+	return err;
+}
+
+/*
+ * Perform final tasks for MADV_DONTUNMAP operation, clearing mlock() and
+ * account flags on remaining VMA by convention (it cannot be mlock()'d any
+ * longer, as pages in range are no longer mapped), and removing anon_vma_chain
+ * links from it (if the entire VMA was copied over).
+ */
+static void dontunmap_complete(struct vma_remap_struct *vrm,
+			       struct vm_area_struct *new_vma)
+{
+	unsigned long start = vrm->addr;
+	unsigned long end = vrm->addr + vrm->old_len;
+	unsigned long old_start = vrm->vma->vm_start;
+	unsigned long old_end = vrm->vma->vm_end;
+
+	/*
+	 * We always clear VM_LOCKED[ONFAULT] | VM_ACCOUNT on the old
+	 * vma.
+	 */
+	vm_flags_clear(vrm->vma, VM_LOCKED_MASK | VM_ACCOUNT);
+
+	/*
+	 * anon_vma links of the old vma is no longer needed after its page
+	 * table has been moved.
+	 */
+	if (new_vma != vrm->vma && start == old_start && end == old_end)
+		unlink_anon_vmas(vrm->vma);
+
+	/* Because we won't unmap we don't need to touch locked_vm. */
+}
+
+static unsigned long move_vma(struct vma_remap_struct *vrm)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *new_vma;
+	unsigned long hiwater_vm;
+	int err;
+
+	err = prep_move_vma(vrm);
+	if (err)
+		return err;
+
+	/* If accounted, charge the number of bytes the operation will use. */
+	if (!vrm_charge(vrm))
+		return -ENOMEM;
+
+	/* We don't want racing faults. */
+	vma_start_write(vrm->vma);
+
+	/* Perform copy step. */
+	err = copy_vma_and_data(vrm, &new_vma);
+	/*
+	 * If we established the copied-to VMA, we attempt to recover from the
+	 * error by setting the destination VMA to the source VMA and unmapping
+	 * it below.
+	 */
+	if (err && !new_vma)
+		return err;
 
 	/*
 	 * If we failed to move page tables we still do total_vm increment
@@ -1007,51 +1158,15 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	 */
 	hiwater_vm = mm->hiwater_vm;
 
-	/* Tell pfnmap has moved from this vma */
-	if (unlikely(vma->vm_flags & VM_PFNMAP))
-		untrack_pfn_clear(vma);
-
-	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP))) {
-		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
-		vm_flags_clear(vma, VM_LOCKED_MASK);
-
-		/*
-		 * anon_vma links of the old vma is no longer needed after its page
-		 * table has been moved.
-		 */
-		if (new_vma != vma && vma->vm_start == old_addr &&
-			vma->vm_end == (old_addr + old_len))
-			unlink_anon_vmas(vma);
-
-		/* Because we won't unmap we don't need to touch locked_vm */
-		vrm_stat_account(vrm, new_len);
-		return new_addr;
-	}
-
-	vrm_stat_account(vrm, new_len);
-
-	vma_iter_init(&vmi, mm, old_addr);
-	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, vrm->uf_unmap, false) < 0) {
-		/* OOM: unable to split vma, just get accounts right */
-		if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP))
-			vm_acct_memory(old_len >> PAGE_SHIFT);
-		account_start = account_end = false;
-	}
+	vrm_stat_account(vrm, vrm->new_len);
+	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP)))
+		dontunmap_complete(vrm, new_vma);
+	else
+		unmap_source_vma(vrm);
 
 	mm->hiwater_vm = hiwater_vm;
 
-	/* Restore VM_ACCOUNT if one or two pieces of vma left */
-	if (account_start) {
-		vma = vma_prev(&vmi);
-		vm_flags_set(vma, VM_ACCOUNT);
-	}
-
-	if (account_end) {
-		vma = vma_next(&vmi);
-		vm_flags_set(vma, VM_ACCOUNT);
-	}
-
-	return new_addr;
+	return err ? (unsigned long)err : vrm->new_addr;
 }
 
 /*
-- 
2.48.1


