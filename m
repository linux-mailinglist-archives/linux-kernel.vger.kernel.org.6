Return-Path: <linux-kernel+bounces-246030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C6892BCE8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3B428302D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED40C19CCEA;
	Tue,  9 Jul 2024 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FfqKZ6VO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QKnHNAhy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8519B5BC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535272; cv=fail; b=AiY3GE+MfV97pqgwFm/w6XFuMM9iua6HAlg82silishN9VklLqUJk0jMijmPtgK+Z3gGtJMAJ0ohQNKNppkcvo3iBX1uwXMv902f9vrh/AXGdc5ZrPgVKuI3SyXdPt15cXenrKyyIKO2HtiZwJet9rSPcERKlBHsF6/jG7+IZLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535272; c=relaxed/simple;
	bh=ORcz5QNQrLr/Py+QqQcuJa3vU+ndOXqqpM7RhMzlPQ0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UTomfByNtFDQRyu+VghO3Gt66KxhCVJ2rKslcacBPPIHbqstsaFjEC3Qtyoa4GNMSBdpp/lrLK2WxRHSr/NkO9AmGIEevIMdo5Ydok7+jCM2gBet6vn/CszxybrQmTRNy+YFhOW7zrQRnGIYVmh/Y79IJr55qtjcCI+iNH37L/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FfqKZ6VO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QKnHNAhy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT3lL022023;
	Tue, 9 Jul 2024 14:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=kfBa7nQHnLwkPqT
	3hWkTk+u5rhyBMg+SH7nhEmaEYmA=; b=FfqKZ6VOxYpg+Q0Icia6jdv1psP2Bnk
	LTLBR4TV/RHWETCSyktcmRnpB2LH5hpUT9YPxV4F3Fj9DhzR6xE9OI+HZgSLNBEq
	FLFGDs/BwHiKXzJ3ut9KFYTpBxZ8pzYMd9QTFXwMB3ekI51RXooSO6kuSGNyBbwj
	XOuZjbKiLsn+NgFX4MxU/43LxM6nxow7pvUQiWifYf83Wtej71qmXmMJ3788wS9N
	yrkWiLxA/AFG+/gUTPffovWwQ2CzFGS2Kpdqs3Iul7R707ZpUnEaKVqgus6lMvMD
	PkLkOTCEXAOiod9KPblDmK9YXKy4kY9aUrs4HiERVsKDcHrJMuxRtyg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknn2t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:27:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469DPxUj036181;
	Tue, 9 Jul 2024 14:27:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv1dc7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:27:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KE66KOmNxQDtTdJNB2lAjlT9pGabFUIlRvLzwJmOI8C6rNvf6hi/3jtRN0KluMmjwuITNV64Dmy1axfeGiY948/ztD/l3v8D51T2aEyW8KrjY7pyxFOCW6DLGlVfqKcZAzcLafTt6kOwhpM7DQPQz8221UE6MpjOsmkVh8gMPXJrgjsHcAZJn0PE0yH0tYw1bpvY5QCnBQ9wGdzsAoNqCq3iagaMbkBRb20leaIFUMwgQSUgi+RwG7HxROAcD3CT/pawaRfWGUZa1ugxG0IecaBp76VwT/x6BE6zQe0nzEH/ygftBeWC6gCRkdf1Wf/jZJS9vVQ+IVnfieJGsqJoug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfBa7nQHnLwkPqT3hWkTk+u5rhyBMg+SH7nhEmaEYmA=;
 b=kIit+lbW0fNYCsA7oIxmXUgu4DbrE48j3JBZAeC+xRaHC/R9+hZN+H/xwv85W5iyPdnjrXeKI8Q0dW/EOsX/pR76Pg6wB6UdEivRRWZ55O+z/DMWecFNzjy5tMZWSvDxPA0cMgNisM/gZabkk1SZtSFb7GGyG9BFGfVE/QGKvJgb0JApZlXpkLAInbw9Jj9fFsANKfwvZuwdHW03v/d6KyK4XvU8b8bm86gsE9y7rgcME8rraHvBEgP31CQKvHW5J9WsCBapk5wA9LGfWoeFyMrVA5/uERrmO48C8+W9PNLb9QYWlu/K78W5uZC1FdcvBPmtTOFh0zCD1DQXDNI0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfBa7nQHnLwkPqT3hWkTk+u5rhyBMg+SH7nhEmaEYmA=;
 b=QKnHNAhyCaJoxieJ4Cylx/QHvYYsAYMZUXXrJHiM/uKFMyHKyzyZPtayjLL5cdKWCk99h4ppr8Al+owxAcIgUhKPM+wm4By84kwJbbFhWxifOHbpcVryCwzNZzWwsQpZ3PBbJMHTdGEs4WValxnhxj146minscOxolzvSYF0BG0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW4PR10MB5701.namprd10.prod.outlook.com (2603:10b6:303:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Tue, 9 Jul
 2024 14:27:29 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:27:29 +0000
Date: Tue, 9 Jul 2024 15:27:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 13/16] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <4c9b4ec9-88b3-4ca8-8358-734463533078@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-14-Liam.Howlett@oracle.com>
 <867602f8-85bb-4c2c-81df-c15de15a2bf8@lucifer.local>
 <fhshsdxi4axwriv2od7lkqfzhhydccnwnov22caw5lgbfuy7mi@5hf73szoc3uz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fhshsdxi4axwriv2od7lkqfzhhydccnwnov22caw5lgbfuy7mi@5hf73szoc3uz>
X-ClientProxiedBy: LO4P265CA0325.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW4PR10MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 1341ea9a-2ad5-45b0-d204-08dca023433a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?bxOyVc0/nWcDffyMSbQbNTTlOzb1i0VApa4Uh1IhxZnDlg0gGBlG9fbYqnk9?=
 =?us-ascii?Q?HIJqRiyyNONttynP2Jg812RJ5pHyPMZE/KcbEqIAleyeAoNQdEFLiRpK5gIv?=
 =?us-ascii?Q?48UEH0mvsZI6xHIET+FefukfidvoefrK+8QSU6Bql3XoilvWo9eBq0/mPlPF?=
 =?us-ascii?Q?1MZkTxqi++WsWBYxQyCeXnXTP7SKp/nge207E2nwRo0K05Zm4gJFxRt9Au5d?=
 =?us-ascii?Q?T3bVM73LGkrAhUob2QUlcxcOJV0IzceINuK3MOpKUj3mz57uhN2c74E+No9F?=
 =?us-ascii?Q?0f3q0QZ6hxHhLEPFHXiDo7zLod0H4no16G6hjQfPKdqTXt7o4u/c+jRpn5EG?=
 =?us-ascii?Q?IUIi0RjbaeAaWhBo/Zew7mDuHxzJjuye2WDMnWPKIhN6z+K5M6Lu/ShvWLIm?=
 =?us-ascii?Q?4n46zO9N/WP3lZs/m34LwbB9VSOLZamkXJstt4Im8G9uvyMeAQBDuosejqQB?=
 =?us-ascii?Q?Bq90d9eC9mMylzK/IDFmFdSPgQjM/s/asiHeaiT9Ex2cQsfk8uCgGGfEUH15?=
 =?us-ascii?Q?NBdFD2EW8NAXQ6fGROc0kblMe+lpS+mu+leV7T5kasQSSfBbYuPxSx/I9BQK?=
 =?us-ascii?Q?PmzrzrRyUJ4lmjf+J9lt7oRCYZoJhRKHDHEhsfDfsR9Ps9FnZqJoKLvMGipw?=
 =?us-ascii?Q?NxgY8g9qpmwAQKlQgkaHxJB4TL/lK1icq93SN/Q+NG81PpbDxUhd0jbImOIU?=
 =?us-ascii?Q?Fv5Ru4w2cTM1rgBzR4+sFkFtBMFFTN2ehl6XW5Qkzt51ne8mTKfT/MTa91i8?=
 =?us-ascii?Q?tXYNgqLn6eG1tkwmep8zK+S1dMo42XM/ZLOg3Dnn/0Ss1KAMQj6vwkrSb0uR?=
 =?us-ascii?Q?pN9ULkO9bMHjJyVkUT7cK1odJp1VpyFUD3xh4tkhZT9MyEPoq9BS8hwG0O5D?=
 =?us-ascii?Q?Hc40RQUKxpT/twB/lKR2ThMswcE99AC9DOT61UjD4pFzNU0tzqKo+Li6BOaC?=
 =?us-ascii?Q?AN2Bf+0uCCMhATuGDCfRxdm/lK3ZeLJ7WcJc/382DzoI9YWsOq2CujtK+rr7?=
 =?us-ascii?Q?2cvWH4LTMCTVQ3XIa9yCJDzzsBSyqAgSvs/Naf2AH4jVibIFkFbyh6yGnM2y?=
 =?us-ascii?Q?vqAqFppdjlOXCik6/2gon9f8ktzk3Mw69nm0L8CJQoW0Y/Pzdcjwr3xZWQd7?=
 =?us-ascii?Q?/BtFNETOczqE45iVHnV2Qg2RPa3RYdMMas4ljLFlOny28ERHTip8xG6yMncg?=
 =?us-ascii?Q?hmyurVbhTr//pZ4liwx6wsnlMf6uFCqDzUpOlQ0ckCkeZoazf8b+CUXhuXdV?=
 =?us-ascii?Q?KoOtxIYx2xiidxYR1+NcupT53Ceh538AW3B/8fmzm79cHU0uxUy4aLtKM5FD?=
 =?us-ascii?Q?LnbFQ0W/HgK/cH+cUQ6+OnkbeZGnkGufgbAgvztRF1BrwZJxdcuAQDfUI6b6?=
 =?us-ascii?Q?odWbrSqQQcLcTtzkaBCofrBKyrAD?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gW9s+zOVSkztJlFRbg2bqts3PY1n00HQJl9D3jbSdIErfl2ha0UzP4szTr4z?=
 =?us-ascii?Q?9Hv0q5lBRbLx7U15ruMSEyEgOIXxBZd726jum1aB9IJvW9Ma5stUhjj28iGE?=
 =?us-ascii?Q?ktMpfDvH5MLqPVk6Ih6bNrWgs//y95yq2wcfldyeetmF7Qw5a3Eq2YWq+/Xm?=
 =?us-ascii?Q?ymEc37U9Dmg4RwUPV74RMwJGu54AY4iC+9G4jP+hZt/yIQddOVNvCnlJ1xy1?=
 =?us-ascii?Q?FojeKLOg8aa1NpyBmfrQp3BrB1e2VE7jvZPTGSTIRjjYDFwXeS9CAUeZaKs2?=
 =?us-ascii?Q?fBuKpIB9o48lcfw4OSlGDQkpgNXdDF1wHl8rUqBoi3iLipVdK8dMm1lPfNcQ?=
 =?us-ascii?Q?l7ONdbqT6o0/W5PaNUAehG1vrolE6hESgEuUxp4o77JfvZCGs+cSvqHkox1Q?=
 =?us-ascii?Q?sSMH872lzPfa1GAsnha33JW5HVzWNxDbE/fo/txg+ip0wASxK4tJTQTjxmsI?=
 =?us-ascii?Q?J6cM0s0tmqZnpKPeZMLnleedbrUCdX6FfswMWhX3o9cUQHdHKqDl5a+wrHwN?=
 =?us-ascii?Q?eq0PovQyKlXBPem0Xdaj45YoNWeL7RGL3eOcvGeV4Duhu0lmLELosslHzVEJ?=
 =?us-ascii?Q?66QSvRflpkqZ96VRAFzZrCTdvzdpYbhsY3PocZ9h0KKKkPlu9WzRCEjoTSlH?=
 =?us-ascii?Q?+FnRPvJgI5g+4b0dOtmNfOymCVNWp1Po1iCvbs5KQ2GaInRnocldk/1FxYrk?=
 =?us-ascii?Q?AQpn21r/hZjSSrog8v1XZ+1zRxdSRW2kqKgMbEPkXBZKCw264/o37vXV6d5d?=
 =?us-ascii?Q?WWQcLoMeQX54U50XlIqprk6aaxRUuoKaRmSwwLB3adcvaCdVDUyflNdF0LAz?=
 =?us-ascii?Q?RTIGEJuSoHi1zABoqBbQp2n1jciFR2HQeD9Pcrbz1V0JgYXy8uMcdWMt5Uj5?=
 =?us-ascii?Q?HMrjJfc6LVSDOFBWLULDi5rUN35iN1rgLnqjrdK5PztkbGOhMKirwk03bTx+?=
 =?us-ascii?Q?q3B6Ap0EhtuQn556zufJu/ftzzdYv7SlKK7PRsyJauPrB2zmI9+kuf/DtA7b?=
 =?us-ascii?Q?FprqiBFxCigFzXCbRVl3redqcbhommpkWaP5MmAuvZt8xeK+/QrxjcNYgE9N?=
 =?us-ascii?Q?oevEJYhrRFBrloji53fAJA8P1RBxFNdJs4Hg/FfaoREilh2RhFaVjwS0Infa?=
 =?us-ascii?Q?612kR6gLIAIrJT8f304vbYXljKM1acg7b0QYCPOSgde3lnL7XLbYcfQaK5vF?=
 =?us-ascii?Q?kZsiijvWNWR2doTsaoZO2fqvJwoCRTspqJHZSsGTzoRPNX7+6HVPyi1LJ9yp?=
 =?us-ascii?Q?4zxqBacOFcTGt/pnbDk/6BTCAPxhU5yzPxku1vNeBUcskaA1MLwCNyy0EID6?=
 =?us-ascii?Q?uo4klJqTB0Z9wWHfJBAh/uQN8BneKfrCtTfWEbHzvXyEkCWqLCWY69ob8Ic6?=
 =?us-ascii?Q?RqiKdhmzBG2gcGFWu7Nt2j+y0AJaik7f8CAi9VY/zY0Lt4C4yUqpVQP44gYX?=
 =?us-ascii?Q?C8kzkqGnYlfHcYmw+0ED61hRRRJljYlMOEILQEIwVC8cREeeGTUrFoMcjAmi?=
 =?us-ascii?Q?v2rygoVmVHMu/0uf0KTKTWP8xgNytk0VZKJP/HAsjLnQmtiSDCHPouqkiLbq?=
 =?us-ascii?Q?+B63bc7R6sIAqHwB8BpFPuRMjW1jEBFWlG3BzW2m/j0a6dhyIPBLN7ApgZvd?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gOux7qGY7kLPMVTy0yydhcXLBkY5Mn6g9OxIKXIdYPRA42BZuUnuT3Zpcge2w/2JYOojTlZAYiBc4Inbz9KhQFsWVcz/DqXbPjzemyzlMWwSOJaVGNJq/iqAEpkXU0F38fLM2fhnyJr806HO3xoDhAJgQipsWJIt41NdsNHMIwQwzsmY1ltma+ToUTmNsB39hSxKY1z7PICsIUftPMr2ejaLkgMBld9N1sEolN5q6RumkSk5dCxZbMkgSaVIOLjkfnDeJAT33j14LJ32CTU4c7Ud5Sf201Qi7JBXvbyZdNNm67L+3iJEEsMD3mhQBivhFl82b2rBdGEhln55vEFKGpVmzgFQNwWwwF1nKpsgA/L9rRkQaQS+JTVcOHta1jVOW6Sc9ze4FPXaydIt9SfOlK0tPd7tXabCcAxCSbNJhFDLzZ4hxagM4Dd0flgMj+cSQvnGuRhevUTuY0YLEB2k5RRWo+G+vTm1BYnq9s2io1GjGg9sD5NHL5Un7SiqMYB5NVdcNF+cjpIYymA9rePYRJSs3BB9h1vz4apOpPo4rD/IU74ExTPYKNkGa0qf/VmTKvqBNyPi6KnihSDVZHoAif7MyUOHh1vKaTycuMSha/4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1341ea9a-2ad5-45b0-d204-08dca023433a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 14:27:29.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pn7Bo0qXQ4j26vQJzgakjskyapNTO+sgRgN98ULO5qlcbXlQP8xwI4VJXoB6SWuT1V90Frj5K15BM7scxux1J79IexKfvY+wzg/6kV+QW0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090093
X-Proofpoint-GUID: 2jTDpYvvNiOOel0N5QeDuj3xqB2zIC64
X-Proofpoint-ORIG-GUID: 2jTDpYvvNiOOel0N5QeDuj3xqB2zIC64

On Mon, Jul 08, 2024 at 03:10:10PM GMT, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240708 08:18]:
> > On Thu, Jul 04, 2024 at 02:27:15PM GMT, Liam R. Howlett wrote:
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > >
> > > Instead of zeroing the vma tree and then overwriting the area, let the
> > > area be overwritten and then clean up the gathered vmas using
> > > vms_complete_munmap_vmas().
> > >
> > > In the case of a driver mapping over existing vmas, the PTEs are cleared
> > > using the helper vms_complete_pte_clear().
> > >
> > > Temporarily keep track of the number of pages that will be removed and
> > > reduce the charged amount.
> > >
> > > This also drops the validate_mm() call in the vma_expand() function.
> > > It is necessary to drop the validate as it would fail since the mm
> > > map_count would be incorrect during a vma expansion, prior to the
> > > cleanup from vms_complete_munmap_vmas().
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > ---
> > >  mm/internal.h |  1 +
> > >  mm/mmap.c     | 61 ++++++++++++++++++++++++++++++---------------------
> > >  2 files changed, 37 insertions(+), 25 deletions(-)
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index 4c9f06669cc4..fae4a1bba732 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -1503,6 +1503,7 @@ struct vma_munmap_struct {
> > >  	unsigned long stack_vm;
> > >  	unsigned long data_vm;
> > >  	bool unlock;			/* Unlock after the munmap */
> > > +	bool cleared_ptes;		/* If the PTE are cleared already */
> > >  };
> > >
> > >  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 5d458c5f080e..0c334eeae8cd 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -401,17 +401,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
> > >  }
> > >
> > >  static unsigned long count_vma_pages_range(struct mm_struct *mm,
> > > -		unsigned long addr, unsigned long end)
> > > +		unsigned long addr, unsigned long end,
> > > +		unsigned long *nr_accounted)
> > >  {
> > >  	VMA_ITERATOR(vmi, mm, addr);
> > >  	struct vm_area_struct *vma;
> > >  	unsigned long nr_pages = 0;
> > >
> > > +	*nr_accounted = 0;
> > >  	for_each_vma_range(vmi, vma, end) {
> > >  		unsigned long vm_start = max(addr, vma->vm_start);
> > >  		unsigned long vm_end = min(end, vma->vm_end);
> > >
> > >  		nr_pages += PHYS_PFN(vm_end - vm_start);
> > > +		if (vma->vm_flags & VM_ACCOUNT)
> > > +			*nr_accounted += PHYS_PFN(vm_end - vm_start);
> >
> > We're duplicating the PHYS_PFN(vm_end - vm_start) thing, probably worth
> > adding something like:
> >
> > unsigned long num_pages = PHYS_PFN(vm_end - vm_start);
> >
> > Side-note, but it'd be nice to sort out the inconsistency of PHYS_PFN()
> > vs. (end - start) >> PAGE_SHIFT. This is probably not a huge deal though...
>
> I split this out into another patch for easier reviewing.

Yeah I noticed, inevitably :) the PHYS_PFN(...) duplication persisted, a
small thing obviously but covered in the subsequent commit.

>
> >
> > >  	}
> > >
> > >  	return nr_pages;
> > > @@ -522,6 +526,7 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> > >  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
> > >  	vms->unmap_start = FIRST_USER_ADDRESS;
> > >  	vms->unmap_end = USER_PGTABLES_CEILING;
> > > +	vms->cleared_ptes = false;
> > >  }
> > >
> > >  /*
> > > @@ -730,7 +735,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> > >  	vma_iter_store(vmi, vma);
> > >
> > >  	vma_complete(&vp, vmi, vma->vm_mm);
> > > -	validate_mm(vma->vm_mm);
> >
> > Since we're dropping this here, do we need to re-add this back somehwere
> > where we are confident the state will be consistent?
>
> The vma_expand() function is used in two places - one is in the mmap.c
> file which can no longer validate the mm until the munmap is complete.
> The other is in fs/exec.c which cannot call the validate_mm().  So
> to add this call back, I'd have to add a wrapper to vma_expand() to call
> the validate_mm() function for debug builds.
>
> Really all this code in fs/exec.c doesn't belong there so we don't need
> to do an extra function wrapper just to call validate_mm(). And you have
> a patch to do that which is out for review!

Indeed :) perhaps we should add back to the wrapper?

>
> >
> > >  	return 0;
> > >
> > >  nomem:
> > > @@ -2612,6 +2616,9 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> > >  {
> > >  	struct mmu_gather tlb;
> > >
> > > +	if (vms->cleared_ptes)
> > > +		return;
> > > +
> > >  	/*
> > >  	 * We can free page tables without write-locking mmap_lock because VMAs
> > >  	 * were isolated before we downgraded mmap_lock.
> > > @@ -2624,6 +2631,7 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> > >  	mas_set(mas_detach, 1);
> > >  	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
> > >  	tlb_finish_mmu(&tlb);
> > > +	vms->cleared_ptes = true;
> > >  }
> > >
> > >  /*
> > > @@ -2936,24 +2944,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	unsigned long merge_start = addr, merge_end = end;
> > >  	bool writable_file_mapping = false;
> > >  	pgoff_t vm_pgoff;
> > > -	int error;
> > > +	int error = -ENOMEM;
> > >  	VMA_ITERATOR(vmi, mm, addr);
> > > +	unsigned long nr_pages, nr_accounted;
> > >
> > > -	/* Check against address space limit. */
> > > -	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> > > -		unsigned long nr_pages;
> > > -
> > > -		/*
> > > -		 * MAP_FIXED may remove pages of mappings that intersects with
> > > -		 * requested mapping. Account for the pages it would unmap.
> > > -		 */
> > > -		nr_pages = count_vma_pages_range(mm, addr, end);
> > > -
> > > -		if (!may_expand_vm(mm, vm_flags,
> > > -					(len >> PAGE_SHIFT) - nr_pages))
> > > -			return -ENOMEM;
> > > -	}
> > > +	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> > >
> > > +	/* Check against address space limit. */
> > > +	/*
> > > +	 * MAP_FIXED may remove pages of mappings that intersects with requested
> > > +	 * mapping. Account for the pages it would unmap.
> > > +	 */
> >
> > Utter pedantry, but could these comments be combined? Bit ugly to have one
> > after another like this.
>
> Since this was mainly a relocation, I didn't want to change it too much
> but since you asked, I'll do it.

Thanks, obviously a highly pedantic nit this one!

>
> >
> > > +	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> > > +		return -ENOMEM;
> > >
> > >  	if (unlikely(!can_modify_mm(mm, addr, end)))
> > >  		return -EPERM;
> > > @@ -2971,14 +2974,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> > >  			return -ENOMEM;
> > >
> > > -		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> > > -			return -ENOMEM;
> > > -
> > > -		vms_complete_munmap_vmas(&vms, &mas_detach);
> > >  		next = vms.next;
> > >  		prev = vms.prev;
> > >  		vma = NULL;
> > >  	} else {
> > > +		/* Minimal setup of vms */
> > > +		vms.nr_pages = 0;
> >
> > I'm not a huge fan of having vms be uninitialised other than this field and
> > then to rely on no further code change accidentally using an uninitialised
> > field. This is kind of asking for bugs.
> >
> > Can we not find a way to sensibly initialise it somehow?
>
> Yes, I can switch to the same sort of thing as the maple state and
> initialize things as empty.

Thanks.

>
> >
> > >  		next = vma_next(&vmi);
> > >  		prev = vma_prev(&vmi);
> > >  		if (prev)
> > > @@ -2990,8 +2991,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	 */
> > >  	if (accountable_mapping(file, vm_flags)) {
> > >  		charged = len >> PAGE_SHIFT;
> > > +		charged -= nr_accounted;
> > >  		if (security_vm_enough_memory_mm(mm, charged))
> > > -			return -ENOMEM;
> > > +			goto abort_munmap;
> > > +		vms.nr_accounted = 0;
> >
> > This is kind of expanding the 'vms possibly unitialised apart from selected
> > fields' pattern, makes me worry.
>
> I'll fix this with an init of the struct that will always be called.

Thanks.

>
> >
> > >  		vm_flags |= VM_ACCOUNT;
> > >  	}
> > >
> > > @@ -3040,10 +3043,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	 * not unmapped, but the maps are removed from the list.
> > >  	 */
> > >  	vma = vm_area_alloc(mm);
> > > -	if (!vma) {
> > > -		error = -ENOMEM;
> > > +	if (!vma)
> > >  		goto unacct_error;
> > > -	}
> > >
> > >  	vma_iter_config(&vmi, addr, end);
> > >  	vma_set_range(vma, addr, end, pgoff);
> > > @@ -3052,6 +3053,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >
> > >  	if (file) {
> > >  		vma->vm_file = get_file(file);
> > > +		/* call_mmap() map PTE, so ensure there are no existing PTEs */
> >
> > Typo? Should this be 'call_mmap() maps PTEs, so ensure there are no
> > existing PTEs'? I feel like this could be reworded something like:
> >
> > 'call_map() may map PTEs, so clear any that may be pending unmap ahead of
> > time.'
>
> I had changed this already to 'call_mmap() may map PTE, so ensure there
> are no existing PTEs'  That way it's still one line and more descriptive
> than what I had.

That works!

>
> >
> > > +		if (vms.nr_pages)
> > > +			vms_complete_pte_clear(&vms, &mas_detach, true);
> > >  		error = call_mmap(file, vma);
> > >  		if (error)
> > >  			goto unmap_and_free_vma;
> > > @@ -3142,6 +3146,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  expanded:
> > >  	perf_event_mmap(vma);
> > >
> > > +	if (vms.nr_pages)
> > > +		vms_complete_munmap_vmas(&vms, &mas_detach);
> > > +
> >
> > Hang on, if we already did this in the if (file) branch above, might we end
> > up calling this twice? I didn't see vms.nr_pages get set to zero or
> > decremented anywhere (unless I missed it)?
>
> No, we called the new helper vms_complete_pte_clear(), which will avoid
> clearing the ptes by the added flag vms->cleared_ptes in the second
> call.
>
> Above, I modified vms_complete_pte_clear() to check vms->cleared_ptes
> prior to clearing the ptes, so it will only be cleared if it needs
> clearing.
>
> I debated moving this nr_pages check within vms_complete_munmap_vmas(),
> but that would add an unnecessary check to the munmap() path.  Avoiding
> both checks seemed too much code (yet another static inline, or such).
> I also wanted to keep the sanity of nr_pages checking to a single
> function - as you highlighted it could be a path to insanity.
>
> Considering I'll switch this ti a VMS_INIT(), I think that I could pass
> it through and do the logic within the static inline at the expense of
> the munmap() having a few extra instructions (but no cache hits, so not
> a really big deal).

Yeah it's a bit confusing that the rest of vms_complete_munmap_vmas() is
potentially run twice even if the vms_complete_pte_clear() exits early due
to vms->cleared_ptes being set.

>
> >
> > >  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
> > >  	if (vm_flags & VM_LOCKED) {
> > >  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> > > @@ -3189,6 +3196,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  unacct_error:
> > >  	if (charged)
> > >  		vm_unacct_memory(charged);
> > > +
> > > +abort_munmap:
> > > +	if (vms.nr_pages)
> > > +		abort_munmap_vmas(&mas_detach);
> > >  	validate_mm(mm);
> > >  	return error;
> > >  }
> > > --
> > > 2.43.0
> > >
> >
> > In general I like the approach and you've made it very clear how you've
> > altered this behaviour.
> >
> > However I have a few concerns (as well some trivial comments) above. With
> > those cleared up we'll be good to go!

