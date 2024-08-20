Return-Path: <linux-kernel+bounces-294702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE7A959176
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45151F22C34
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8BA1CB33B;
	Tue, 20 Aug 2024 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pnm5X5XV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YEZh1KgX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A21CB304
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198303; cv=fail; b=EsW6UuLbW95JWYJ+RBVwog1qTUOv9dYNVeJurJIIzP1ddDWzfGJGBy+74MN6Ez3GSlzGNiMRf3onKomwXfKo+fUkHFeNaAaMKwy9K/O8sWjaeIQWPy4n70igSfMURrh4G21Wp133Sz/+F9TvMqqpM3X/iXNCR1UQp7l69RqWTRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198303; c=relaxed/simple;
	bh=wCJ8vpY4Ox3YnJrb7FttPRx5X3KT3nCRfov9u8QYjwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MqXdQ2GMgZG4l8KLJzdUWEHUWaOnXQ71VUSapMQchAZfFYXpTpLaOuJTtRWrSCSAvU9OuAyiYrNwktEALze4k2Z7hRb2o6C9pgnHulOT/3DKQXdP+i6IA7TEpgFFCKC3HPsZPo8j68MPHAy1PQ1gMmU+Lg00SVYWB1GvlosS1og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pnm5X5XV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YEZh1KgX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBWNt020404;
	Tue, 20 Aug 2024 23:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=MpWIi7cMQmivMHPf3/Pmr7r1vB9/WxBvplax7ihq6P8=; b=
	Pnm5X5XV4KrFS2zZyrDlkxGTHoRnuQlL2sFY7G2j/0Nqb9NG24VMom0WcueKChob
	2qVAAgJYvzcZ5cNM1qWPaCtXxXPWvGqs6He4JGFo4GyJ5H8G52176nASFEkmFBV3
	DEW5DxXg2H7tdJg6j31NT1+FhsyAPyz/Nrc4L6Fm8v8Z95uxN2Tg79azcnkHvt/j
	3odMpDDjDjJtUO/I8BBOW79/7mbFmxDoZOxSB1I8LBHRUe9V1EJMDSDDyhylnMmT
	sD7+Wv4UbVfSWdxPxAo0InSfI86hGcwtGVZACVaan42uwaOD+pHt2ZIbv7dmw1Td
	zNwRk/pWYygwGdCkT7KUxw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6ged1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMJJkI040123;
	Tue, 20 Aug 2024 23:58:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4153u2tbef-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdF7PHGespa4a/IVKDr6kefniyRGoGg6qNqcTzebTIzrOkoViTprp5bRRfcj9OckSkZUiwHwVe0z4gYNsM1jr70BaP8kCCeyZ7PbnH1fC3ikvmfHnzXbPQQ3/BVQu0XiOJ9AcNAoU794WGWNfgLtwSL8RKnUcXvuMxFqE6jiHpHMShWFRry1x3EbensNmTwrX5VpL7JBgRaaOSMsqC4UN5d3eNMnz+qllUKKWCYVO+gmyZnSbTW+24TOfVlKgB/jr7FxL+7m0lkt0eoiUK9Rp6qFP/XbOTT0m/W8+wV1/MDo/4WUMrqhOj1/iduef4/OYVh3XkTXZITfWMdJR3zeMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpWIi7cMQmivMHPf3/Pmr7r1vB9/WxBvplax7ihq6P8=;
 b=EN2O6stzmMzONnBmYMhIKPGq8+9W+N941D+OEnEw+ul/gpjmZAFmXiFZhrs1/CVWQtIe1f2ZqhAUqNAUWRxGlVnf4T84VXpFC96Ljw4vvBPOKfBwr4TLNx3tw6lqMt5jgXdX8mcy/Xye7bpYe8wCHoaPLFkgjdmXlXWuqqAY2opHPfXH9cDjrrmrBxNp6EPwPZwsEn2D5ujA1TMgRp3SaCYwfov0/IRbahEsOVmRFGdY6BleYdC2ijESOSZwUiug2tEMfxsMtxc/qBDGVB5L4aYa6814453PLA8li0ul9ZEARfBY1y+UmeJAmWeZ/gvDDn/+P1oTHeFDpOgtwb6AGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpWIi7cMQmivMHPf3/Pmr7r1vB9/WxBvplax7ihq6P8=;
 b=YEZh1KgX3ZA+Z+1tu8PPtdNReCx/gJyRPcQhz/jiyt+WIZ769KjtR6AxbdoqvdMjRc1CNbwY0dsdHE853plnJ0GzGaw/fpxijpktKyalHZl6eBvFtJlLwutfPw1aj1Yl/6VUT2dqSrKNAWx73ENC4MrTTIekmB+7ta6yvAYksJc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:02 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:02 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v6 08/20] mm/vma: Inline munmap operation in mmap_region()
Date: Tue, 20 Aug 2024 19:57:17 -0400
Message-ID: <20240820235730.2852400-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc5c620-27d7-472e-d6fd-08dcc173ed0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kpuNkhYEzdYEhmlNxQYMuwQnjDfTjUpnoT7Sa1BQaih8ijN3wydnpmRgyPJl?=
 =?us-ascii?Q?8RbWT7iHssIBPOmB3qxK5S/GXzfTYhZYPgmWYvLg2VnaAqJrs2mAt+gL4+D8?=
 =?us-ascii?Q?cmpaYnEzG0ql9W4QBSNOPv1voKRavBNhgDUTzu1rMlouvNq8vzkU5XVrQE0z?=
 =?us-ascii?Q?L/MbjZ37V8vhfYkeHeek/mKkDZdDcigL4kB93bcnmRhMJdP7l3nBCa9ItER4?=
 =?us-ascii?Q?I1AVo+8KfHUq2Z+m75N91C+Eac045qzdEgOTHxXqSPbubGjhJVZdLqmS3WWv?=
 =?us-ascii?Q?MCakXJsumvKXmiwFWTbbamBQhunkHKn1s6u5F6lYxWa5I/vdrDL6ql0S6srP?=
 =?us-ascii?Q?fm8LDne3lFd4WRzb3o4G0JfwZSOPVc+b/c3KvvnnETkuc/kUAix9SzJTkJG5?=
 =?us-ascii?Q?MgOy4HONPketZB77ME+QmLKxOD7zWnUuKA97Y8tlF3wZRN/2Oq+3KQLrGSPt?=
 =?us-ascii?Q?oR/OQZOtKoqPvwuVIyAkOej5VRggJMagp86bOjyfQVZtvCEqUmPtyMNQjza1?=
 =?us-ascii?Q?dypJMtLDV3YLgzRtspcWB/8jfjAyaWPFYf2eYs6wcDkrmOW296ahL7CWUqLn?=
 =?us-ascii?Q?m2R8JG+YRjDnW5CAj4mCNQrhnnESFVDB9d8zDjb0dI170nQqGZO10FPkXIco?=
 =?us-ascii?Q?RX5h7qHHKiqj4qtpFAfM/gbd2x7ln/tQcsRihpA3APxdXNtcZO/uOiOea65N?=
 =?us-ascii?Q?GoWz6ftk2IL5QQkYefVX91E3ahURoGmd4xdDo+Seyt7cirEyK87zqckO5XjM?=
 =?us-ascii?Q?MzV72TyR9zYDbaIhSqTvytAC7X3GZTix8tbmLO88gGlu23fg87iDR6pRRlUR?=
 =?us-ascii?Q?B4on+32cQs3toY+g9FCajUcBB9TL1hOffHgQDthflpBIKwg1ix5Dxadr1TPC?=
 =?us-ascii?Q?M7fKnbuvKdwv49d731RZCyZ8k5Ov8P8OeRUbDGBRZkxUyOt9Rd4RJ9vW2uPq?=
 =?us-ascii?Q?eKRxGf5KnBO/G3TC5hufnhYqKo733zwAhj622fgfPW6qDsX/tI2cLCwJEks7?=
 =?us-ascii?Q?8G5OHfhWNsse0blP+OY1VN1XtasTxYfpddiX8u2YO3kAMQkiwQZsR7iEJMal?=
 =?us-ascii?Q?iF8/9KAnyHPBXc6muPdiC/ftmNIeZxM2euYydwhF7fYX7UKx8vVOdfnM/LfX?=
 =?us-ascii?Q?RNgS3olRS9sSfSj9cTtdUa+FTZqtifGay8FbK0QMGzBo6Y4nxgdUe7yBgR6q?=
 =?us-ascii?Q?i5Qz+Pcyi/UBjqX/jeEb8czRqx41dnwstjSAye/yhe6M55eY/jAkSB5HXdUl?=
 =?us-ascii?Q?7DO/6sT0lYWUCQUt7m/1FL5x80JNp0oKKzSRqgxlZunOapNhv/6/RrZlsxsj?=
 =?us-ascii?Q?b/c78i193rFCo58p2P2wVDBfdqyGECnhyVoM/CL9wF9mYA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O36XFwkPlQ83TJU1F66dTN54hYduJqH+VocpsGmiePKAjvct+RwxSPyjGFMp?=
 =?us-ascii?Q?t8DecMYgZZgOS2T76RPHGu9LGaMGbyNitMcPy6px4x8ximMrT/DvxrFY7o6v?=
 =?us-ascii?Q?VrU0c4/p1VfybJL3TLi/PrkMjPzIjbjlpe3Ak1yGBaxzrKPW0KX7scvHw6OS?=
 =?us-ascii?Q?BdWFz5mIHCZAWpPbKT2lrks/IaHii9PE6FGJ4f1jWmAIC3HIazTECOuoVlHD?=
 =?us-ascii?Q?WbG3SY0S8BMpI24oRAtk3A3LxLUFVQm59XsTJNszE9oa6TyaJpteMgHwLg7U?=
 =?us-ascii?Q?p1b+C8BhB3KfC37H4k5OQ4+UdaIrNfRGuqqIBE/oqENJ2RhreoSHpob4w12h?=
 =?us-ascii?Q?s3fjBxT4Tf9naAfIRM1H5387qn6hlALlcokQNyYm8IwZfmYvLajhz1Lo7cg6?=
 =?us-ascii?Q?+gMkIKzWodMnDaFpmvZOJYKt+f52O9hAp8fJfMyHNl6N3IuiYClm11iacsbN?=
 =?us-ascii?Q?zBhwqhymrXfo2rngxn/6ooYvQ5XXsGoZbagnUw6Sj8278Z+8esFMnc6PwWOM?=
 =?us-ascii?Q?vRURlxvcpjSmKnIfuiKmQsgkNGRrDBhgG0udGaYd2Iey3BIxNi/SLC2sV/t0?=
 =?us-ascii?Q?l0nKBavu73keDiB23088AHeaIOC9PPcvzlSGZTQLbiYZa1oANG0g9sNlKSRG?=
 =?us-ascii?Q?SnQZ27iy1mcbRUnHdBx56EGh3lUQ4f62OW/7jjfyGkqkdQnXy3gkiehqBScg?=
 =?us-ascii?Q?ttw88EB7KfEbfHpUOmpExfeXSRHjLR87rePpBWARbW+f6AfEtaBd6rszvf1E?=
 =?us-ascii?Q?8d0l4YvGDGwxLxJE9f3Bds0TPvzt7cQuO3nWsbeXXBoe+vOlThR5TxpHo+uL?=
 =?us-ascii?Q?Ii096OedH53m+LckEBKotsVpTuNuTWUhyKyJ9zJtwjzvmjSryDpKnrzf7D/D?=
 =?us-ascii?Q?0ec+cwuVWyiMVimp6kKe/YpnK8nZFDRexzSeOkHD4xnowMTv4asY2biCeFP+?=
 =?us-ascii?Q?aSbapwAJrIo0TH4AJxjdSj9pCkLIb+vGGMIAq6QOlCNFllRoEZq6xFKtfqju?=
 =?us-ascii?Q?IMoDPANAGBuEPLkPRdmUMMJIhRXerzVoOxoel84jKy1PfA2uxl6jBcaSQGIE?=
 =?us-ascii?Q?pPovTm23ZZXUCI83V6VMzTzPwN0JT8D4n7hlSZv2y/4hF3XwJWK38//aAyp9?=
 =?us-ascii?Q?Gm4xpYDCrLQN8hcOdahZmninR7kDteVABw0dP7+hAvK1523fPS3y9LsyI1RE?=
 =?us-ascii?Q?ObsncZJMHHnB3bJ8aRUaLUOtVsyOg7MyfIaG6rmtNjw0nw6Q2PHgRrsKxgSN?=
 =?us-ascii?Q?zBCG/zOx3dhQ7DKt3fdCVqOdt/PDBa726HkZ7TIguQkeJXNfar5Sa/S3evkv?=
 =?us-ascii?Q?1xLpY4+BZZMCuR69kzQ5A2xmQHiG0f4UBB9CxBqDOf7rs8Fv+XWi09Ob5Kdh?=
 =?us-ascii?Q?HEkUllYQJwJqQQvpLwLpJWdduAoPI7Qd2sjXa7LoN9cNOsOOZI/Qgpf/P7B8?=
 =?us-ascii?Q?iznEvuZrvPaOJa81JZcOXAFoDx99FkDvnwKxAZLDCRqekHWUSJZcgmb3WHty?=
 =?us-ascii?Q?2T8G6AObxujuFx9ItI4dPVvwIhrrqZrnYhhOmLDKOmpaf9ZSgsIwX6shTfs3?=
 =?us-ascii?Q?vyyUT8Ye7QDgBhcKZGnT76QP7UO9v7nBOUNyV2NYIHoYyxVhTjLpI9nWhWQF?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u28HWtD6Ew+yIupblqiGZFn/Zt23hDRiru0+ciU1PsLmVM6eMHR8Q+D0suMaxK3jglPM1RRaCgrhB8CM9LknB3C0d2/E53MXJdPivBRSN0zRHk8nPIqiIDuhhVxhSWwxaKvdUuFAdJSzrYCT1XwxdcGXkp2YziLYZ3MhNAbYB5zCKj1zq87nryR6hjt9cquYQ7kggdaCSDYWIXmA6xKj27lTXPjZ5rpyVM1WOQU5cLQGXZPz4RuqCCKqrmuwQPS5y/68oBB//UG+9+zs245sldtJsAoY4Vy2HcKrDGvpVkDofKk+MD03ng3B1nCHqGyK6GA2rGekXi6dLAm1Z+U2a1MZTh093yWMZ0agQHcLWV6Lak0m2Bg6vi0kwOmL4kR7Iqc/TN52z+8/UHklNCpuPvCxHU/5nTUL/bN7G69/Ba5GnjJmaWqgexTZ4e6XTh3/QXlRnPImJHHSiAQs207FQ1vOdRQYsKNiCqrJPBfQS3QulBO0Xg22ZYUmC+kL2QGR0aOILezFIYEv8wWou8Q8FkuK5yqZQdD/QzdFREPh9EQAGYBH0ifdo0gbvPRAAE1SL7/V3xY0cxWjO1KjeCorLAzQaRiAnSMjfS0SaDrinYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc5c620-27d7-472e-d6fd-08dcc173ed0e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:02.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGOU31m/hrJUV7CSmRYtfLdND9U2Jg/ZR8T1fOB6v/g0FN2B8JUd8eARJq2YD57yDvLdNyndMnOVTn0r5iY2Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=925 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: siyvEitxUJgjuO-g00DHOC-mBaJlVNYL
X-Proofpoint-GUID: siyvEitxUJgjuO-g00DHOC-mBaJlVNYL

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mmap_region is already passed sanitized addr and len, so change the
call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
checks.

The inlining of the function and checks is an intermediate step in the
series so future patches are easier to follow.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 112f2111c457..0f5be29d48b6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1388,12 +1388,14 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			return -ENOMEM;
 	}
 
-	/* Unmap any existing mapping in the area */
-	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
-	if (error == -EPERM)
-		return error;
-	else if (error)
-		return -ENOMEM;
+	/* Find the first overlapping VMA */
+	vma = vma_find(&vmi, end);
+	if (vma) {
+		/* Unmap any existing mapping in the area */
+		if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false))
+			return -ENOMEM;
+		vma = NULL;
+	}
 
 	/*
 	 * Private writable mapping: check memory availability
-- 
2.43.0


