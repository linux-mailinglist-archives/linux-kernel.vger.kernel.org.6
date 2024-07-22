Return-Path: <linux-kernel+bounces-259305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4709393C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10ABF282428
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B08170822;
	Mon, 22 Jul 2024 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UIprMJvB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ki5esz0Q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C20616FF47
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673807; cv=fail; b=IacJS9QbdTFu/tltMhBJxTpjffcWfae3aZQZm+VPEKFk5gF5DONg/MCSrhm9ILvyEUBq0M3WdcBFfquK/X+CPU0+EOuEh8NxGRTHDD2UqNJKFp/BE/+0YujdW8F2ZNmDCGjJe7yUPWMFA0KsUCbybMJd50wMdcZuhGUorxP6O1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673807; c=relaxed/simple;
	bh=V1Y/zcWDbF/wG8+7uXck+YHkFJb/rClzOBA+IHK1AOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c1j0AK31513KJMzrH8+fcm9qASalh5oJPzMY/ozccOWrEy660bZ4tCA7DqC2KxGGop9mV0wlMXPLCEv6lXrkVpYUlZPL/ZOFzFkgh0OP/wSZVWvapyxWgQIAI/5q3Ul5QbxSiRRE5aoWNsETNOc8yIk2LlGDHrsZm/r7Ggsfd50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UIprMJvB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ki5esz0Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MHMY3f014893;
	Mon, 22 Jul 2024 18:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=WqqTp+GYAx8Kwey
	7q+pU0fzqf4zgDTPnJursqAPCU2U=; b=UIprMJvBFkUbCxv0H1gJVUrk1Bu90uX
	+ECCI0WsFBSUON2l9/KoPBr8XDVo80qasb53xhzfXnsq5WOe4uz5yRv5+h5Zq4Af
	prumJ/lQfEMWfK4FixQK4QcK1BWSDJD8vHyx8iXhW6nqu+pL0iBwSC3y9sNdVNGI
	P02bqe/gVmVYV7P3nLyYTRAV6rHheln/84nE0F/drl+W7heiLSqHG8yriIA1v0Id
	YJJJ8VKCCFrODPV6mbbBmqmggCVqcZiiN3Xtg5n4ciG/A2XdyjZdm9bKHrgi9jLd
	d7ea5fLWzEZberq6Ojap7W/48bLhmNN87GeRg8ZHbeVJtvzdBb8GHRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg10tx20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 18:43:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MIaeQn034330;
	Mon, 22 Jul 2024 18:43:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27kes0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 18:43:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtwV7AeNfoz+wnMVqlYYBXvePSFaJedH95T16uH5TW+89ypEBHW5RZbS5C4P9UXwpUHEUwJS+wUZT2siQyc98cv2j1rn4cCGSa/V2nUZ2DSJnaI9ImIcfaemadQlBs3lGa7T5FTHic/7ylDh3AoNBoT4GWb/FSbRlOYvp6lSOL/NH3I+bXn7s9NIfGlNDLU4+9bnb29uhlFZ8IC2CSHKFwPWX4sxcqWFYbVy+WhncgHeo6dyPD/+49cqJP6nDRXYVMNeqN4S5kr9fVhLQ75ASRFgrA8C21ZTaIg3Zom7Ak5w3ZdMnB2+7qiUwpu8lBbimISLxouQU2axrMdJ1dsL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqqTp+GYAx8Kwey7q+pU0fzqf4zgDTPnJursqAPCU2U=;
 b=hF5+3LgWVb0I8HVNsR+YE66IvfUiIru8FYq5LYN77AA1rW+3lY4pLdxPA4njdRr7M4ScrxTyM+8WgOu9i9HuI2GZLPtVUjMW4pIXZW/PgJyhNYcd61IbyrX4USsgagr+DO8ujFtnq44zfKXC06H3D0p5A0ZSB/r1xA6PMc34/VBnGgu0BUBC8jsELmNrfuinyYibxeWSnH5aVD6R+zhpxDZQogr2L4yBc+VabvD6MfTz1Vd71eE2VTfTRs8Z4n4I/dCfnBXhkLeT3KXcDYkqLo/Y0kDTSzrUKF7+entFXSr5VJjTyJi1/ofjJapjnwLHUffrl7F80R2W4hPJZ773Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqqTp+GYAx8Kwey7q+pU0fzqf4zgDTPnJursqAPCU2U=;
 b=ki5esz0QyBB8m+iMyikrr8km/u46x3wX37wlYn7MlsfFXKHYAOeCb0pN9iJ9RS90cenbIh1Ay6kvRrd7vqcesINQD7bdhg7G/Gzt2trVtjlZujtdQoErzGWmBwijPMK7zWBFBF041JLTPm23a7ZQaiZPyCxZB/RUaiYTaruysJk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by LV8PR10MB7799.namprd10.prod.outlook.com (2603:10b6:408:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 18:43:00 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 18:43:00 +0000
Date: Mon, 22 Jul 2024 19:42:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v5 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <0928cf11-ccf9-4065-8768-4216916c6223@lucifer.local>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
 <20240717200709.1552558-15-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717200709.1552558-15-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P265CA0216.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|LV8PR10MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: a6add5c8-6dce-45b9-ca04-08dcaa7e1c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h7eE/JEg1vA31MC3Y7hUJV0+Obf7YZbZQsdK4QUgF2wtXbM5dqwQZyi2NV92?=
 =?us-ascii?Q?d++HwxWemJ5yJ2zYuBsfPX3z35CFH5luhuAAhI4DTH3xbOtdHe1syFKf+ZZv?=
 =?us-ascii?Q?dTnvXmT208N/WGvE2OJLgIdn8jnEXWk/HsMDkBR5SI+aMAArucWaZqpMAYd2?=
 =?us-ascii?Q?/lnFhbNo5IU2hS+cVm/g6qMersSEcEfsnimRw9apLe3delLwG3+hY33yXIe7?=
 =?us-ascii?Q?ny4G1k5mvVyQLDCFvDgSMdiD/SoCQXJvPmFxJfu0Qu5phCdNlFYuyvanx5dM?=
 =?us-ascii?Q?rv6GmgZ9CFGZ+FiqpueleDYQ7mlDcW6j/K6HVM1k/ZmM0mHE8Nyg8cvzpPPo?=
 =?us-ascii?Q?MXpLtnqpfo/wxRju6skmrHvMAPRi9QTf/7597Oht7gt22V9bFwo25Syi3UxS?=
 =?us-ascii?Q?+DRZeOyNeNcEbN0wPCGIBRERatdD2M723ypJTGwlapW6jR5MHWoGf9CAQDqE?=
 =?us-ascii?Q?elnNPjCx0BXKhcouqhlaC9fL1L4D+TdMPDkX3hGVESIJNhILAJEWLilWV+7A?=
 =?us-ascii?Q?2zBaXePzzNDlbKZ6Tpll7yOBM1yFk/iReS0ep4Liqvz1MG3JaXc5QzzlkBNS?=
 =?us-ascii?Q?XdnOFrpsMHtxhja9jKHB95uJG5fMU/cKTn6kp6qIvS9pyRigk2bW+4zUpUKf?=
 =?us-ascii?Q?gYbi7VKr8pfyBGXVd+OO5Eg55ZZ7r9ayM84KQCx2NA86+SHYvCME70HmFZrp?=
 =?us-ascii?Q?watolgdPTxWZ3w+WyQfrL+fZomNCq8OciZerO4IrG+4nIc6KqlrzdyMXwFKQ?=
 =?us-ascii?Q?6L+N3AdaIF7ef58lnXaOP3RIJ20LS/QcEs4wPSwAn+AsnqG1Pieu+A4HpfmB?=
 =?us-ascii?Q?5B6kEyXXiTxG66n6E2kGDQM9HsbMT8kQPn37U3IH4d2UpiEohEw1/Hdrdwh8?=
 =?us-ascii?Q?wryBKvRQgAFiTbOoLeP0jodiYp3PdYBiCMyrgHZrXlOSx1JZQpI246p00zbc?=
 =?us-ascii?Q?vb7w7Ggfv4tegIOO0uG12ZAtXY98AMv3/RWEhsEMX8/97f2C0fjWEPZ6n6hv?=
 =?us-ascii?Q?rwGm0UQaznuPVXva/Ks0QKlMj3OSJzNKBNaxbdY905Qm9RtpVNciGNdueOmH?=
 =?us-ascii?Q?kGRDc1UeUkjfbKiSl9N1ctdNY2UXypT7SWkjpe60pOD1k0Fd9HQYnnmOTC5t?=
 =?us-ascii?Q?48tsSp4B+YwhYQ4Nvw1rGHCQQ3/3P+/owT9Z8jydKgRNF/h4uVPwVzJ4+BvS?=
 =?us-ascii?Q?cM6hpJ2RH79vqzYB7ctZKf+8W7bTEgklhiMBwYTVJgg3sHDdAxMDHgo3/v+M?=
 =?us-ascii?Q?88yAjAQXiQjeFY6ObKDmuHAPNkD36K4YWER2HiXltrQO2G9Rd86EP4HdNVuZ?=
 =?us-ascii?Q?g0E6e2IxEFXr40+W49//1QfEoV41y4JLH5CCZGI222Q55A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E3FEutlTRLMPBTDDnQDL4t6/XUg5T/sLW0IYgRsrply2HNdZAyiygwDEIGNZ?=
 =?us-ascii?Q?zwpB9x3Wzwnfvh3sWhkzlSKd8jMxp1XyCnpI499kje/ZHzwmNeNEh5xkLDSJ?=
 =?us-ascii?Q?8cRgZaWkvjPd6TiKgnla1ECf9Bz1UlAvR3xZP3hB82HKhrnkruG8C/Oc3zfK?=
 =?us-ascii?Q?bZxsdCyTQhwik+3DNsbUd9yQ0Oc1AFpRqaLcjSllSzqbRUjJmtvik+1xKtgW?=
 =?us-ascii?Q?mxgsWd2za01pxT+bWevD0qKMoKTwi0PVgf/Ftf4Pqke8DRkBV+VwNkbYtKjF?=
 =?us-ascii?Q?dgu3oo4h3XrqGPhWmjXWVUC9Icr3IeTYI5pn6edUunLQdwQ1XUhCGEJ8EQJw?=
 =?us-ascii?Q?rwieK3ns2327vleEEpEvzJVgdpLyJmZT/hpz0DGLkcFoi7zx9235dBZZz+Pl?=
 =?us-ascii?Q?unxkiZ+cmzvbQ32P/K9OWy7AwMBacsMkH+HIFhrDRNQlOVeAbM4evLCHx7Qp?=
 =?us-ascii?Q?9t2SSVxnyDT3Bop75puG3lRZ6BMxRGDIQ5OjmBLjK6gq8F4lBhlNpMoyeXMr?=
 =?us-ascii?Q?Uijf7HSAb6QQWIghJEZ2lpWcQGXaOaCT1haAmbp0Kq1fQ2KYll06mvTgo5lp?=
 =?us-ascii?Q?EcMYvH0qoZdgp+Iba3TTrwtOpWeEjUX3ggzTNz6zhaiG7Q4XXe+xJhGCw4wc?=
 =?us-ascii?Q?toqxr+qIawVC6QBkFtlaCCFH/ZmNeu0wxupzP5QE5NmHjsq7jpbgoex7k+DC?=
 =?us-ascii?Q?kJfBuyxE+AfqLXEz7VRGFm79+YoFM/sCjCu8T8ULZiHMH0VKswiTPWIN8fOf?=
 =?us-ascii?Q?YzDBcjLX+YP/FOzQkyDCCFGEw2sTnsGfO88q+gLQokWTSY8gCTE4ApgerBoQ?=
 =?us-ascii?Q?PueT0r3s5JkosgSI8qWQtVQoOh0LRYnmNmRIkP8Ra+qEWR7hp6//qJG/FMYL?=
 =?us-ascii?Q?HKo8LobBqYh/DhMlD2MAc4w6s2ZazExl5G0gEs+VJybVAtifR8jmPdm90k4A?=
 =?us-ascii?Q?jlsuT3HYpvkvs4vNuVtYqnsKk/0JpzqUn3P50SeoakpqxxWDO0KBHF3eUxEW?=
 =?us-ascii?Q?usTf4K2vci1xhJDG5/W7cdCm9leGf1qBWpm9JLi120ZkY3Tn8/5Ib+8zZOms?=
 =?us-ascii?Q?WtRmNYX8Dqj+m9083NCwetdofb3GeK9KdWb02LNoDSTbS3IQCtCAW4H4cdks?=
 =?us-ascii?Q?mTG66YFEk0espegjIzcGTdasXqKSPma0KGqCEFzzJiLSZ61liqkKdZHed+Mw?=
 =?us-ascii?Q?+sUpN3D5g3572G4agK5mwnCdy3gt2xrHDHp+sMprx9gsOchDFZxS8MdQmQbO?=
 =?us-ascii?Q?DAE0Cb4nw8TCaExjVrtUzHmRIvJnSeMDYorG8Rstk/vGzuzZR/k+XZtitrRQ?=
 =?us-ascii?Q?y39EuQcgdPMwdDQ6D+725fi1+Dr/qHAZs0CGGw2L9A51N9rSI6jsRJ4mYbH0?=
 =?us-ascii?Q?TB8UJ1IObb3314PGvkDFx7on5UzgwRtNi1PPCov70olMv3hHLH3gUukkJH2g?=
 =?us-ascii?Q?A3PQMYWAiSPN/2rq96TiRTRS3EpvErZ4mHlRtt6wYgWFGwUAGic1YiORQruB?=
 =?us-ascii?Q?Igf3y2MQBwNkPvq/52XuBgCGoIMA9ovACEJe8eTOHitb7TiQ/RXJ74OAKIk0?=
 =?us-ascii?Q?wq6/fZ6d4CjTBZSiQO1VkB9JOq0xtGVkMjlZXw0croTWrq1zlSSSC5IBXi8I?=
 =?us-ascii?Q?iTYb39aC2SSlrlUUIEjj3r+qnKXPMNal5/OPy+SEtA9CwQAaJ9FxKug1R3dc?=
 =?us-ascii?Q?8PwHBg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ajPX+28DkwVo6Y/Ve9cLHB+TehnnTRfg+x6BlBWLcBvj01hJI2/i4UmEQmBI71BRujSu8UPtgG8cNrl7RnnO7/u2NWCSerlyb4P3YKIs4r7On4NlgTwye+M/9gnHNliENHDXO3ZJk0QoDJsnocl+ix1bjGKITDoIO0EQbmg79PUNkvAvn+xOWjgECdjAVGlsmbJ7BFOM9ljjo65xPExD2ChyEyR65PXos4TcSBaxGpf41DeRYk42ab1BYJyEHsmZ+irkzAeuiR6WsLNWIvqHbEpr07/JiwTpe5m+K5ArnEGq4IZKX6ucEhIL2+los1/fQr9wUG736u8Fohf4C45CpJk7Z6ObEYKb6h7FQ27sOUoW3h2MEzg+oEny8A5+SeoX5ICvUkWDrQnevFGveidFBH5eBaTox6SXA4qVpUtfu8YPZeKjgBx0zzobDUgvI287XigBYgiBrVpIZCnf+UIcWlQ2/WSGS7zz0+LEEgTsxkhMCXejot0a7kcMp/elnvkFPEV8kP0Y9/Gt9VxzQQia3uG23gd8iBhh6reh7uNnO0ekL3kg8G71l142nbCjLZlstUKMDXWCcfz4dJiVC1MpC5rxNSz7OXipeD+XkhO1HUg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6add5c8-6dce-45b9-ca04-08dcaa7e1c5f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 18:43:00.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5UeWNZSvMNedtxOY1FkKhksqMXOkbaEfLmh2HJPVQfP/STcr7eRTfIQ3HkPsvPwnR1LUuBozJGbmnFkzZZAtHMTzZHmwKTz3tYlhraNf5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_12,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220140
X-Proofpoint-ORIG-GUID: VubdZWK-7G2VOOpPNHukprQmplocwP3S
X-Proofpoint-GUID: VubdZWK-7G2VOOpPNHukprQmplocwP3S

On Wed, Jul 17, 2024 at 04:07:02PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Instead of zeroing the vma tree and then overwriting the area, let the
> area be overwritten and then clean up the gathered vmas using
> vms_complete_munmap_vmas().
>
> If a driver is mapping over an existing vma, then clear the ptes before
> the call_mmap() invocation.  If the vma has a vm_ops->close(), then call
> the close() function.  This is done using the vms_clear_ptes() and
> vms_close_vmas() helpers.  This has the side effect of needing to call
> open() on the vmas if the mmap_region() fails later on.
>
> Temporarily keep track of the number of pages that will be removed and
> reduce the charged amount.
>
> This commit drops the validate_mm() call in the vma_expand() function.
> It is necessary to drop the validate as it would fail since the mm
> map_count would be incorrect during a vma expansion, prior to the
> cleanup from vms_complete_munmap_vmas().
>
> Clean up the error handing of the vms_gather_munmap_vmas() by calling
> the verification within the function.
>
> Note that before this change, a MAP_FIXED could fail and leave a gap in
> the vma tree.  With this change, a MAP_FIXED failure will fail without
> creating a gap and leave *a* vma in the area (may have been split) and
> attept to restore them to an operational state (re-attached and
> vm_ops->open()'ed if they were vm_ops->close()'d).
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/internal.h |   2 +
>  mm/mmap.c     | 119 +++++++++++++++++++++++++++++++-------------------
>  2 files changed, 76 insertions(+), 45 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index ec8441362c28..5bd60cb9fcbb 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1503,6 +1503,8 @@ struct vma_munmap_struct {
>  	unsigned long stack_vm;
>  	unsigned long data_vm;
>  	bool unlock;			/* Unlock after the munmap */
> +	bool clear_ptes;		/* If there are outstanding PTE to be cleared */
> +	bool closed;			/* vma->vm_ops->close() called already */
>  };
>
>  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 20da0d039c95..0b7aa2c46cec 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -170,10 +170,11 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
>  /*
>   * Close a vm structure and free it.
>   */
> -static void remove_vma(struct vm_area_struct *vma, bool unreachable)
> +static
> +void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
>  {
>  	might_sleep();
> -	if (vma->vm_ops && vma->vm_ops->close)
> +	if (!closed && vma->vm_ops && vma->vm_ops->close)
>  		vma->vm_ops->close(vma);
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
> @@ -401,17 +402,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
>  }
>
>  static unsigned long count_vma_pages_range(struct mm_struct *mm,
> -		unsigned long addr, unsigned long end)
> +		unsigned long addr, unsigned long end,
> +		unsigned long *nr_accounted)
>  {
>  	VMA_ITERATOR(vmi, mm, addr);
>  	struct vm_area_struct *vma;
>  	unsigned long nr_pages = 0;
>
> +	*nr_accounted = 0;
>  	for_each_vma_range(vmi, vma, end) {
>  		unsigned long vm_start = max(addr, vma->vm_start);
>  		unsigned long vm_end = min(end, vma->vm_end);
>
>  		nr_pages += PHYS_PFN(vm_end - vm_start);
> +		if (vma->vm_flags & VM_ACCOUNT)
> +			*nr_accounted += PHYS_PFN(vm_end - vm_start);
>  	}
>
>  	return nr_pages;
> @@ -527,6 +532,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
>  	vms->unmap_start = FIRST_USER_ADDRESS;
>  	vms->unmap_end = USER_PGTABLES_CEILING;
> +	vms->clear_ptes = false;	/* No PTEs to clear yet */
> +	vms->closed = false;
>  }
>
>  /*
> @@ -735,7 +742,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma_iter_store(vmi, vma);
>
>  	vma_complete(&vp, vmi, vma->vm_mm);
> -	validate_mm(vma->vm_mm);
>  	return 0;
>
>  nomem:
> @@ -2597,23 +2603,31 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>   *
>   * Reattach any detached vmas and free up the maple tree used to track the vmas.
>   */
> -static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> +static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
>  {
>  	struct vm_area_struct *vma;
>
>  	mas_set(mas_detach, 0);
> -	mas_for_each(mas_detach, vma, ULONG_MAX)
> +	mas_for_each(mas_detach, vma, ULONG_MAX) {
> +		if (closed && vma->vm_ops && vma->vm_ops->close &&
> +		    vma->vm_ops->open)
> +			vma->vm_ops->open(vma);
> +

Unfortunately I think this is broken. While in theory this should probably
be semantically correct, I think drivers get this wrong.

For instance, in the devio driver, usbdev_vm_ops assigns custom VMA
open/close functionality in usbdev_vm_open() and usbdev_vm_close().

usbdev_vm_open() simply increments a 'vma_use_count' counter, whereas
usbdev_vm_close() calls dec_usb_memory_use_count(), which, if the count
reaches zero, frees a bunch of objects.

I've not tested it directly, but it's conceivable that we could end up with
an entirely broken mapping that might result in a kernel NULL pointer deref
or some such other hideous, possibly exploitable (at least for DoS), scenario.

Also since this is up to drivers, we can't really control whether people do
stupid things here or otherwise assume this close/reopen scenario cannot
happen.

I think the fact we _might_ cause inconsistent kernel state here rules this
out as an approach unfortunately.

We can't simply do what this code did before (that is, leaving a hole) as
this might require allocations to clear a range in the maple tree (as you
pointed out in the open VMA scalability call earlier today).

However, as I suggested in the call, it seems that the case of us
performing a MAP_FIXED mapping _and_ removing underlying VMAs _and_ those
VMAs having custom close() operators is very niche, so in this instance it
seems sensible to simply preallocate memory to allow us this out, and
clearing the range + returning an error if this occurs in this scenario
only.

Since this is such an edge case it'll mean we almost never preallocate,
only doing so in this rare instance.

It's ugly, but it seems there is no really 'pretty' solution to this
problem, and we don't want this to block this series!

>  		vma_mark_detached(vma, false);
> +	}
>
>  	__mt_destroy(mas_detach->tree);
>  }
>
>
> -static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> +static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
>  		struct ma_state *mas_detach, bool mm_wr_locked)
>  {
>  	struct mmu_gather tlb;
>
> +	if (!vms->clear_ptes)
> +		return;
> +
>  	/*
>  	 * We can free page tables without write-locking mmap_lock because VMAs
>  	 * were isolated before we downgraded mmap_lock.
> @@ -2629,6 +2643,23 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
>  	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
>  		      vms->unmap_end, mm_wr_locked);
>  	tlb_finish_mmu(&tlb);
> +	vms->clear_ptes = false;
> +}
> +
> +static inline void
> +vms_close_vmas(struct vma_munmap_struct *vms, struct ma_state *mas_detach)
> +{
> +	struct vm_area_struct *vma;
> +
> +	if (!vms->vma_count)
> +		return;
> +
> +	mas_set(mas_detach, 0);
> +	mas_for_each(mas_detach, vma, ULONG_MAX)
> +		if (vma->vm_ops && vma->vm_ops->close)
> +			vma->vm_ops->close(vma);
> +
> +	vms->closed = true;
>  }
>
>  /*
> @@ -2652,7 +2683,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	if (vms->unlock)
>  		mmap_write_downgrade(mm);
>
> -	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
> +	vms_clear_ptes(vms, mas_detach, !vms->unlock);
>  	/* Update high watermark before we lower total_vm */
>  	update_hiwater_vm(mm);
>  	/* Stat accounting */
> @@ -2663,7 +2694,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	/* Remove and clean up vmas */
>  	mas_set(mas_detach, 0);
>  	mas_for_each(mas_detach, vma, ULONG_MAX)
> -		remove_vma(vma, false);
> +		remove_vma(vma, /* unreachable = */ false, vms->closed);
>
>  	vm_unacct_memory(vms->nr_accounted);
>  	validate_mm(mm);
> @@ -2804,14 +2835,18 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  	while (vma_iter_addr(vms->vmi) > vms->start)
>  		vma_iter_prev_range(vms->vmi);
>
> +	/* There are now PTEs that need to be cleared */
> +	vms->clear_ptes = true;
> +
>  	return 0;
>
>  userfaultfd_error:
>  munmap_gather_failed:
>  end_split_failed:
> -	abort_munmap_vmas(mas_detach);
> +	abort_munmap_vmas(mas_detach, /* closed = */ false);
>  start_split_failed:
>  map_count_exceeded:
> +	validate_mm(vms->mm);
>  	return error;
>  }
>
> @@ -2855,9 +2890,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return 0;
>
>  clear_tree_failed:
> -	abort_munmap_vmas(&mas_detach);
> -gather_failed:
> +	abort_munmap_vmas(&mas_detach, /* closed = */ false);
>  	validate_mm(mm);
> +gather_failed:
>  	return error;
>  }
>
> @@ -2945,24 +2980,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
>  	pgoff_t vm_pgoff;
> -	int error;
> +	int error = -ENOMEM;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	unsigned long nr_pages, nr_accounted;
>
> -	/* Check against address space limit. */
> -	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> -		unsigned long nr_pages;
> -
> -		/*
> -		 * MAP_FIXED may remove pages of mappings that intersects with
> -		 * requested mapping. Account for the pages it would unmap.
> -		 */
> -		nr_pages = count_vma_pages_range(mm, addr, end);
> -
> -		if (!may_expand_vm(mm, vm_flags,
> -					(len >> PAGE_SHIFT) - nr_pages))
> -			return -ENOMEM;
> -	}
> +	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
>
> +	/*
> +	 * Check against address space limit.
> +	 * MAP_FIXED may remove pages of mappings that intersects with requested
> +	 * mapping. Account for the pages it would unmap.
> +	 */
> +	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> +		return -ENOMEM;
>
>  	if (unlikely(!can_modify_mm(mm, addr, end)))
>  		return -EPERM;
> @@ -2979,14 +3009,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
>  		/* Prepare to unmap any existing mapping in the area */
>  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> -			goto gather_failed;
> -
> -		/* Remove any existing mappings from the vma tree */
> -		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> -			goto clear_tree_failed;
> +			return -ENOMEM;
>
> -		/* Unmap any existing mapping in the area */
> -		vms_complete_munmap_vmas(&vms, &mas_detach);
>  		next = vms.next;
>  		prev = vms.prev;
>  		vma = NULL;
> @@ -3002,8 +3026,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 */
>  	if (accountable_mapping(file, vm_flags)) {
>  		charged = len >> PAGE_SHIFT;
> +		charged -= nr_accounted;
>  		if (security_vm_enough_memory_mm(mm, charged))
> -			return -ENOMEM;
> +			goto abort_munmap;
> +		vms.nr_accounted = 0;
>  		vm_flags |= VM_ACCOUNT;
>  	}
>
> @@ -3052,10 +3078,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 * not unmapped, but the maps are removed from the list.
>  	 */
>  	vma = vm_area_alloc(mm);
> -	if (!vma) {
> -		error = -ENOMEM;
> +	if (!vma)
>  		goto unacct_error;
> -	}
>
>  	vma_iter_config(&vmi, addr, end);
>  	vma_set_range(vma, addr, end, pgoff);
> @@ -3064,6 +3088,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	if (file) {
>  		vma->vm_file = get_file(file);
> +		/* call_mmap() may map PTE, so ensure there are no existing PTEs */
> +		vms_clear_ptes(&vms, &mas_detach, /* mm_wr_locked = */ true);
> +		vms_close_vmas(&vms, &mas_detach);
>  		error = call_mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
> @@ -3154,6 +3181,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  expanded:
>  	perf_event_mmap(vma);
>
> +	/* Unmap any existing mapping in the area */
> +	if (vms.nr_pages)
> +		vms_complete_munmap_vmas(&vms, &mas_detach);
> +
>  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
>  	if (vm_flags & VM_LOCKED) {
>  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> @@ -3201,14 +3232,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  unacct_error:
>  	if (charged)
>  		vm_unacct_memory(charged);
> -	validate_mm(mm);
> -	return error;
>
> -clear_tree_failed:
> -	abort_munmap_vmas(&mas_detach);
> -gather_failed:
> +abort_munmap:
> +	if (vms.nr_pages)
> +		abort_munmap_vmas(&mas_detach, vms.closed);
>  	validate_mm(mm);
> -	return -ENOMEM;
> +	return error;
>  }
>
>  static int __vm_munmap(unsigned long start, size_t len, bool unlock)
> @@ -3549,7 +3578,7 @@ void exit_mmap(struct mm_struct *mm)
>  	do {
>  		if (vma->vm_flags & VM_ACCOUNT)
>  			nr_accounted += vma_pages(vma);
> -		remove_vma(vma, true);
> +		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
>  		count++;
>  		cond_resched();
>  		vma = vma_next(&vmi);
> --
> 2.43.0
>

