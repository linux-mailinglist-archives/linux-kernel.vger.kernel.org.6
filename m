Return-Path: <linux-kernel+bounces-387196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E39B4DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E198286470
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51252193425;
	Tue, 29 Oct 2024 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TOVrPCrv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="prO/HYaC"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14232192D83
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215258; cv=fail; b=t0HmpXPnuxvaA1bdWhbhbzRX6yWgXABau5Rfw8CaJJNkG2+OwGjae6k1A0qe7x5YOHoiBE1yMxbYvBhvRpUjYzhIvoAGOFrdAOc9A177B3MQji0Mu0mTT2SCGkdMTXW/1ekaOEWDiOSBzM/e8AH3Xfy/g5HF7JCOurrkdVf2s+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215258; c=relaxed/simple;
	bh=Ayjw8ugA6LOf5KLU2CwADD2NuT9o1agz5lvdLM/0TKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T8cNlIbKkjRzlG2LQeJN5QF8SSf1hU/XRJBbTIK06HDqDZefWAJYGALdFsJDjBQgQtz4qVO7sdqVVleBjGsU5GQ7gO10s8xvEwaB78UzN0LfZzNLmwOdLMb/ZffJ4Qwk2VEmuQvRSeA+wVvCFQwNdKKj9OETyEXfpCMwT4aYFqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TOVrPCrv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=prO/HYaC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TEtfHu008655;
	Tue, 29 Oct 2024 15:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=1D2zXny4v1ZdHJTNBK
	j5YTgCkzjMY0oWl70TpQl8Ots=; b=TOVrPCrvp5J32RxtTodn9zipbBjdKQ0CAr
	wC1OdOcHlwV+J2byjvHpzHq9N16E3fPpty/YYIDWtJxrmWGoUJSfOvxExCwkbUeT
	4xwSSFUCFurZrB2WJMDT9TgyggcX9xQJllS/ZyVUsvgZhYHCVba7O6Qe+d37tA3P
	ZbCIqMTfMzNKXErkrF9M2/Stg/u18mbmVhN9Uez+LXaMVYf/YJRJ1cqlXsI2EN48
	jRuLFz+UceEskegiwo+7iv4nFqFziW6GFPfvyZmSFUzlN97tGQRgC1bqH7ltu79z
	MewdltN4jYyRHcxJe2PDHLtqy2YpmmElOIuQa0Y1zR4ihIaZctjg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwdrcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:20:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TE9IXK010281;
	Tue, 29 Oct 2024 15:20:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8x12be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 15:20:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zedr/j52uX2pIYCoPi9cr1cf8QR2miw6qnmWnD5YwQKJpxzdfcsU8qjblN3llijm8ysvB8bG8lDBf52/DgX4dyNxsPBrihlsijlSdUv3PAh9jKB4NBRg5ZswtkLwHP3Uipr/pz9a6DIu09BPgIaIiZk1rusY4nyDjbg66YC6AeqIqpln+m6lW+37c0r+E8joqF4MxKsZKHFYQKJqs2J/th4gILNSUfkuc+nUaTsvsQdXCAn6NXSgqPkfxf1YloO9pLwYRtINZ3UE18t12I6kGQTQxdOglVjFWmJzu4sXGdA+s0pECZ5whI4TjkiDOM21JfegXQxdYu4cLtbj7l5iMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1D2zXny4v1ZdHJTNBKj5YTgCkzjMY0oWl70TpQl8Ots=;
 b=M44b4DkS4TB7ycw6EHEK5Y91EbQTTPkEnIW0T3JWsJ7R0XwjGS898wIonEY+y2tH73FU7NWd4xtI32UuYmpEKKmxqQtVu867Ax8plA7wDyMPH72YwkWhNzOS395UVVWZq1Id5SfUQBJ4qQ1LsSun081b8Kl9otIahc8hwdJ19OetplKQpBuzl+re6oezkOz2JA1jNSulOUadTe6Y36RTh2ZtTlSSWt56wFC4lUgPjKn5TFFlee2isClmoM5CsDzUZ7z0va/AH0yNMXyCaPTchhL6hSmkp7p/i/hZ99bx7PtkZgYu9NQHs2BRhoXk+y5fwhLw0NF/W66WkwT7FI5oVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1D2zXny4v1ZdHJTNBKj5YTgCkzjMY0oWl70TpQl8Ots=;
 b=prO/HYaCk/5BlaAFbppRTx/nWx5MiHsLg4i68ndwW/eEWt61QXm61dBV+sTm3UNFbxQYH70zAl7JTwQT5Rj5Mry2rPI/w4/L7wXTnQngu8DJMJRggsDVB7MsG6PvMDKtZcVv+w/4nW55oiY9UTH1xeCQhtdojQtnHFTlZte6YXw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 15:20:31 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 15:20:31 +0000
Date: Tue, 29 Oct 2024 15:16:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <da15a72b-c1de-427b-a764-0ebbdd3f6a8e@lucifer.local>
References: <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local>
 <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
 <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
 <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
 <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
 <ZyD5iXikMzotl9mU@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyD5iXikMzotl9mU@arm.com>
X-ClientProxiedBy: LO4P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b02f07-3f11-4389-e3c4-08dcf82d3a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kjk7R/UDW0RKMbGdM17e3axCE3qwtHU2uAJk/FkH4PCoKXPJD+1zuk2AFxyG?=
 =?us-ascii?Q?L5HPtNgoyNFOX3NN+vtZhXTh4yPGfZc+j6UdACbtWl07rf1agYlfJ3711PHY?=
 =?us-ascii?Q?sceTPTxrcn2F7GJ8Qlq9WNYwfL+w3octUaxr+zb50rfKyD4eG4c+2Pw1SMUc?=
 =?us-ascii?Q?QtAoACrBn/fkLiwa786Gg8m15G0xkJY4BXcnxUYkwLB0x/gO4NIm1xwPMlIj?=
 =?us-ascii?Q?nEJ0GqzyDR+0DYKj2fRjNNeqnMvcQn6DNxt4/NzMCfkP1B0jsDR9arDSHUeD?=
 =?us-ascii?Q?RFj42t0vQV19o2OZks1ME+gihFHhimHeRHIEhNhvfx7hrbObR+elAxZxl9ki?=
 =?us-ascii?Q?VX0pn5Xj674gKDB5+jE6PkdJueyCLBNXrANv7l38LZln54tGFATVug0c+HAq?=
 =?us-ascii?Q?L2bo4eheFSZPNohbyPqo+P5XoP6M59ber3ao3q4/bG5fek2wf/kNDr4l1iIU?=
 =?us-ascii?Q?Dlt8CIijRP5knW1TzKvMHYzihTeU6ria0bKGIH4XoPJlh837neC893mjpybp?=
 =?us-ascii?Q?QzBqb107YaMc3sj5KF++E9ktYPnGXOTuWnbZPGmFg+aMDpIo8oXTfAeywVUl?=
 =?us-ascii?Q?vXMC9WXfY90/X+Oh+vagHJyBRYEOL1NCB9UrbQ87bk9EBmpcCzw++NLuZahf?=
 =?us-ascii?Q?FIU/w6GdPUdsmu1mRU8Fe6+IACplNd7ak4ht0PhI30HV6zW8cbq+CutiJlaU?=
 =?us-ascii?Q?vO3XuZU2sXKY1IhNBDlrdWnnLVoELnY8oFuB688EBi2g0ZcGObuXUYonrDPO?=
 =?us-ascii?Q?NTOAOKf+qSzPrMlp/BMWJjP40BugOYGGrfl+VpwibNusHh35bBHfCkCMb7hp?=
 =?us-ascii?Q?DjCn0K2F/qu0yLrr2VDnaeY4FC+Oe+IUEosJR0lzobt0B9Kt3VjHpBmnqRDx?=
 =?us-ascii?Q?3X2h2K5ExwD2y3flhMH82ecV3zCFnpt5ImlQVIU+hO7OU5szuhqHm9zX3pKz?=
 =?us-ascii?Q?xCfjrT9v3tujfbGaMIfsKG/+gCIAPt/6ThbXkO62VKFYDJDP/P9nYmMCu0jJ?=
 =?us-ascii?Q?Hg9Tq9rRmq4QfuS1DCgvxc5ri8JM+hDvz5skiOkqY63eICt/R0xqVanUYnAU?=
 =?us-ascii?Q?KTQpASaCB7UVQYeVtLSDd2zf0RcuD4c4lPi4+WSLcDcsdTkMG3v4QEl5IrY9?=
 =?us-ascii?Q?qk7FdpHd5GDeyKydTkJMQNHTCz2JR9R67oxugSCMl+Y3pQxQ/AjHZ39Sacs7?=
 =?us-ascii?Q?NLfOvK2E/kVROiS+jcN7NKHUAQRoyiGt6ZaW/aRz2LZFCXK5jEQScSc3klI1?=
 =?us-ascii?Q?Z9NZNUmC5ovUNFqPF/F529vWIxWNA3Ve03rxDEuWJfmCmvJ4FrIbSfHPpEaD?=
 =?us-ascii?Q?Acw7hMFMz2cQecAOVakxDdDM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AZF+crp3TkLCcM4EQlgSxrkknDjcSNs66Z53KZ6+kd9NtB/Qdc8IK0nIDVxF?=
 =?us-ascii?Q?Xko0/vNF0H6rr8Z0fOd6WeMLFTu4iP6I+WG9RkFlYNIvIw98rCc9ZUgpmSyw?=
 =?us-ascii?Q?mTbbh7jc21I3PRfp1jMuJYhl3myGpHljU2hzIr1rL6B1cyUN+cm8Iu9BVvSX?=
 =?us-ascii?Q?ALIzhXM7L2+KHkGMF7ux4zVoyINKF1kIXIJL4Z6KWXNIHNNHOHY87IZ9OlmC?=
 =?us-ascii?Q?dH75BL+YnfgB1A/gwymudg1hwgc/nu/lTh3s+GEXQQaO5X9EJhBnBG7QSNW7?=
 =?us-ascii?Q?Kd+zyCmxFQHe5lyk+NL/6se8Z7XZ7ykHLv3CHS4peMzqmVj3zoCCPhGzS2u0?=
 =?us-ascii?Q?sUroc3smzFbkptcGHKb7BXGfan6PoMhiYh1vAWTuKCvci3W9+zMPOzKkA7dM?=
 =?us-ascii?Q?7ULlwhm2Az+d4QLgWqGLzJtirsyxuxLU2U/8JsFwQzHa40z/TtMcbomwehhk?=
 =?us-ascii?Q?wrRscHwGiL6jcqyML5hUt4w+bnpvdUBz42omuI+5qlQHXTV4r9R6EdTxAdMM?=
 =?us-ascii?Q?eEG0zKVbuwy9L+jnz1kcFfjOo9gdlsSJkMIRNR5ITfLKwfOJ539+/NFId7Y2?=
 =?us-ascii?Q?tUiAUmK40zT0N3MjHGODBBF0TUI4sTUKDxgZKY2jJ6mEynf4CUXC1jStewwU?=
 =?us-ascii?Q?qoUWxGQkBc4nYk92FEkjl+oZIyjs1UasoO3mTK35ZumiuA2h4AOloffbmEUN?=
 =?us-ascii?Q?dy8DRTp92TQgZ3GrpblSS5y7+Wiilg7dwrlFq/05YrH8zfnGOGRbhiUL3QmT?=
 =?us-ascii?Q?3V7wDwkkqmqF6tYCZzNe+jPJ7uh8VsZL0SQG/1Mw+8ZeNWkwNnlM6G1t0945?=
 =?us-ascii?Q?K0od+tfCSahJ32KbhxA6H3e/UAXc5saasItrYxm8njoBeG/khxyEEbtZMTSS?=
 =?us-ascii?Q?At4Itb7RF7LvHMucixSirftOwuc1cvqsSU8Zu6O6ujIWJZuI0UJOSqBsQ439?=
 =?us-ascii?Q?IPzFnwf/UDwmJBFeNpbfSnvhAJh/nRn8qKStuy0zNH2Humc2pSIvNN8kNKqh?=
 =?us-ascii?Q?IYVc+AfRYyF1lTr0jhdlo6aRQc+F6gViTSJKyhuhsE76eDrCFpdplH3z5+nH?=
 =?us-ascii?Q?LAUN7W5ZrvI4J43To8UfWKl5a+DVxYpGIhfvWq49IETOXub0NoP6eWKR543u?=
 =?us-ascii?Q?oiLUYc9lmrZQ1/RdHvUZ3c27QtYI8URP03OKkNh+nATX0BluaVkMT+ScvC5M?=
 =?us-ascii?Q?9sS3d3y64+hoKYmrgeMXxbt3gezKaAVpCpBpmuyg4nAUEvcM1zxI5X/UAOZ+?=
 =?us-ascii?Q?2RpjIVHKIVg/46hRCaMjE6f0F2X7f8gQQ01BA0FSTKDkUUSbuw9t7EaixvFR?=
 =?us-ascii?Q?BUs1EwhdhNsvEvFQKIwPlWY19F4I4nAYK32YP3eaHj+gGZFGxbyH48TIXWwX?=
 =?us-ascii?Q?5EtuTbsNgPOPR++85hdL+CoVIcyBsiqBFglQkojS/VBDFhiwSLgMx0ANOF6N?=
 =?us-ascii?Q?N87sDI8MCmuc9GJnPJCFoHPKP1OWxHUlIKoU4aMpsBtuZF2fT5Bl5sqEwkQ9?=
 =?us-ascii?Q?ORBSiGX/oTIEqyYIaIjktyHL2lrtkio3p9v173cbYo5iAhFAKQA/oYlc/pAF?=
 =?us-ascii?Q?r+JpPumZy/N9GN7+aq+SHgDuu1BejVzm4uQiwHu9D903Kl15+LtVH+jP/Cey?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dR/X86inTwsNuWkOAdsIXNmLgsJY2S6LCxouv2Qki9IRP9I4AQ5N3E/UVvSPjsR4rtrycjRJSEvR8wtKmS/LFZLsEv0JFXRduo7QvpwyHs+BQjOWjL5NWQ68E2VgfGZtM0veC3wsQB8e5z//wkBoCEcefl0BXXYagfv+0xoseksuHAmxW44UTVWizpwiHgE/z/+cLOhkgNNQagUD3LhFPzW3BoptpRi6KLTL+xCwxUYevaBIJ53vIoFxPAw/2LIGdU0v5Ag5EXMe+L93MQVUTnKatr8hAbe2y+NFm+mfVS60ie/jKaHx3WzW/7IVtwMxrTh/JyXqzOfRAi0f/yGPEE5salbopgVorZZtuQenzQVkjl+xaQ/wNfP3BRCeOfAHWpaZeltuNeseO4gXVpnPhheyj4VKnjzzBX55tdaS9XDgWytl9XzHd2i7Fr7kbzGZRnkWh3dUisY/S6Pg2UTQ2fJ7Up7VTWVsUBhaGagk4jbus4Gi/YoI10MiE4R/0bVddhvieOiP02ebUmGNyxxer0MRlhEzhvPzuc5VtM+y/uP5JaLqq8A3VeBWs8JTJKvKHn0MCs7dutgQp2y0qkFObNGUzWLU1bkji0L7yJejjFg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b02f07-3f11-4389-e3c4-08dcf82d3a09
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:20:31.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLhn6QzfbsFLbrbnNETxZ11pcJCat3Z2ei57aLwJVnCOcHjSAaXPMijITexmaHjgAfhQ9eDh/8rdolb881ZJNmf17WCfcsATY7aLloBqgiM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_10,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290117
X-Proofpoint-ORIG-GUID: 31EJjwFd_X2Mo5x6aOkrRA3bZRQn1bS6
X-Proofpoint-GUID: 31EJjwFd_X2Mo5x6aOkrRA3bZRQn1bS6

On Tue, Oct 29, 2024 at 03:04:41PM +0000, Catalin Marinas wrote:
> Hi Lorenzo,
>
> Thanks for trying to fix this.
>
> On Mon, Oct 28, 2024 at 10:14:50PM +0000, Lorenzo Stoakes wrote:
> > From 247003cd2a4b5f4fc2dac97f5ef7e473a47f4324 Mon Sep 17 00:00:00 2001
> > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Date: Mon, 28 Oct 2024 22:05:44 +0000
> > Subject: [PATCH] mm: perform MTE check within arm64 hook entirely
> >
> > It doesn't make sense to have shmem explicitly check this one arch-specific
> > case, it is arch-specific, so the arch should handle it. We know shmem is a
> > case in which we want to permit MTE, so simply check for this directly.
> >
> > This also fixes the issue with checking arch_validate_flags() early, which
> > would otherwise break mmap_region().
> >
> > In order to implement this we must pass a file pointer, and additionally
> > update the sparc code to accept this parameter too.
> >
> > We'd ideally like to have eliminated the arch_calc_vm_flag_bits() case, but
> > we risk inadvertently changing behaviour as we do not have mmap() flags
> > available at the point of the arch_validate_flags() check and a MAP_ANON |
> > MAP_HUGETLB case would be accepted for MTE currently, but a MAP_SHARED |
> > MAP_HUGETLB would not.
> >
> > This is likely an oversight but we want to try to keep behaviour identical
> > to before in this patch.
>
> MAP_HUGETLB support for MTE is only in -next currently, so there
> wouldn't be any ABI change if we also allowed MAP_SHARED | MAP_HUGETLB.
> In 6.12, MAP_HUGETLB is not allowed to have PROT_MTE.
>
> > So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
> > MAP_ANON.
> [...]
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 4ba1d00fabda..e87f5d6799a7 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
> >  	if (ret)
> >  		return ret;
> >
> > -	/* arm64 - allow memory tagging on RAM-based files */
> > -	vm_flags_set(vma, VM_MTE_ALLOWED);
>
> This breaks arm64 KVM if the VMM uses shared mappings for the memory
> slots (which is possible). We have kvm_vma_mte_allowed() that checks for
> the VM_MTE_ALLOWED flag as the VMM may not use PROT_MTE/VM_MTE directly.

Ugh yup missed that thanks.

>
> I need to read this thread properly but why not pass the file argument
> to arch_calc_vm_flag_bits() and set VM_MTE_ALLOWED in there?

Can't really do that as it is entangled in a bunch of other stuff,
e.g. calc_vm_prot_bits() would have to pass file and that's used in a bunch
of places including arch code and... etc. etc.

And definitely no good for a hotfix that has to be backported.

I suggest instead we instead don't drop the yucky shmem thing, which will
set VM_MTE_ALLOWED for shmem, with arch_calc_vm_flag_bits() still setting
it for MAP_ANON, but the other changes will mean the arch_validate_flags()
will be fixed too.

So this just means not dropping the mm/shmem.c bit basically and everything
should 'just work'?

>
> --
> Catalin

But we definitely need to find a better way post-hotfix to sort all this
out I'm sure you agree :)

