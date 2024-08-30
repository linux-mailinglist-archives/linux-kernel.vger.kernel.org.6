Return-Path: <linux-kernel+bounces-308848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674BF9662A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E84E2827B2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046881A7AD0;
	Fri, 30 Aug 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bb586tRO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sK+6+PaF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE218E378
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023434; cv=fail; b=kVX6qE6/X0H0oSSjIhmxUsTlr2wMGLba7YSFRpDaqT204OP790J7Kknko0wzYiLoUb78a9nC/vrD68tOVSl6JTNCE2GBoAI0k5cXpCN8oCJCsPKu68YxzNlMIqij5cyTIk5puz17QOnVGgz2xZOqccjAV78Kf6i3GojHwmUpNtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023434; c=relaxed/simple;
	bh=EC5uy63diLBL3lOsSAgu/N7+Fh+kwLq0X3CcVL943WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G1xPo1szJHimmnFo8WhfATAaMLcWdEglvkcwRicCAguqbuDGOKjcuPl5vRvparb/Bi62hrIQwugeHRFP9xHnPqM0M6AJiOQNqhV6AH2pMtr3nGi2YQSw7W5ObfPIp7GjcQyF7+qcVKOUQgJcwlzoSmyhO3IGGEjW76Bi/noNE68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bb586tRO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sK+6+PaF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U9gKQb007609;
	Fri, 30 Aug 2024 13:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=EC5uy63diLBL3lO
	sSAgu/N7+Fh+kwLq0X3CcVL943WA=; b=Bb586tROaNo05i2UOdJZvxlllo3SRNY
	hEMHJ0T2vgV2yqoyPgpm6U1jo96d5RXLsHs2PqyYbJSuyHCgFQWMURTn7iEJRZPx
	vDMjYPzxNdSl0jfRbLYdo2RM44VAs8jJf/dyFyu2Lk27vN4h0pbFI0QZNTriegYP
	1cyc3iMFLnjkUQxpvvGEaV7Gws0l9kH+89ECqHumflQPcYp2TYt5gS84SZl60x1m
	zDgTl8sKNFw/lbujP4nN8pPMhsx4Z6hZwaGiAVwssT/m4OHBSQFJyogUCCRg6g0j
	eIRk2uAEFad9LtSMZP8ym7HPDP5N3Hf+hDk9378YBPOJOQ770bw4WXw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41ax0gsnfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 13:10:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UCq1V2009924;
	Fri, 30 Aug 2024 13:10:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894s1s3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 13:10:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/KgrACyU4Er6ylgVYDz9pzuXvsJSiCLRh4t+ipbnz9fX8BS4vHUCatA72xwd0MkQAnImLQHvL1K30pLVVmHZ9WH9kjP4pTYwTt88jEiUuHWzQw9cCkw24TxXfgAsoKsxvM9rxqt8l+oOnhugqsZg63lATJmrJXAyRUmmg3osRqX+hNaLmMp9FULhtAp9AePKXKsjTX1iyDFXMUlpgm84ehoB/3q4VpxqwWmFeVhmEfEQmbR5IkcXTCwKN+S96rggbCvT+hzfaI//WbMOGPApDrwrXMVTSwrP3JximjA9j4aiy1bWPs3Ac4YHnMLi7zPWQbmyh09rLG3okEZ7eG2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC5uy63diLBL3lOsSAgu/N7+Fh+kwLq0X3CcVL943WA=;
 b=iLJohhVv5ZDskDKy7iUdnHgf26kgzH2n7+/NZe7doa2A7OkLBxtr49qaBbZ5kq5+7U+bK7dBVMBywyE5uTMXIKMNPZNb1Wd1IUCH5Y9zl4BWdJs4yyE5N/3DyOEYz8e4dTDrb05RbUbq+5pZuieyHpOyel1qtNjSrOspvIaxjwmau9ui7jsAXIn1bo3pjyDJdtlnzyH2vDERlSvHK1v8f958lmaVQg1QJBnfnl6p9OpzPfK5EKLzh8HgjVOozyUjMLIxhtAAwmfC+y0hKTcJ/tutnMP/oyrufPAbCIh8R9EDecgim+x4jhC3k+H6RAgPnxHXpfnHztEe1mU9jO73TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC5uy63diLBL3lOsSAgu/N7+Fh+kwLq0X3CcVL943WA=;
 b=sK+6+PaFQiEocuUL7B4gamEu3eYCxw0BU3FQqQFwhI9se21ZZCLMC0Ui5FbeaDBAj1C41+LABUjFh3JJr5DMLxowCyDyWG+zkfRF+b67+K2iBiQ0z5SwUjN5Z+UA6rbS6rEvX8VCszS1RQFShXYxUwZ6baWIZTGFYOfXJHoKvm0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB6350.namprd10.prod.outlook.com (2603:10b6:a03:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 13:10:16 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 13:10:16 +0000
Date: Fri, 30 Aug 2024 14:10:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>,
        Aishwarya TCV <aishwarya.tcv@arm.com>, dev.jain@arm.com
Subject: Re: [PATCH v2 06/10] mm: avoid using vma_merge() for new VMAs
Message-ID: <5e1ba7bd-89ce-4c11-885b-d1b1842333cd@lucifer.local>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <57f55a1473586a88211e04b44c6b128332d4272c.1724441678.git.lorenzo.stoakes@oracle.com>
 <51452bab-65ef-4924-8ca8-61536d2bc168@sirena.org.uk>
 <9dcddc2c-482b-4e12-a409-eee8d902ba26@lucifer.local>
 <622b3769-fb5c-4a3e-82b7-1301623faf43@sirena.org.uk>
 <82718839-dacb-4774-a72d-99d9c2b134c8@lucifer.local>
 <9e3b42ca-ef40-4400-b4ed-3d082da82a0f@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e3b42ca-ef40-4400-b4ed-3d082da82a0f@sirena.org.uk>
X-ClientProxiedBy: LO2P265CA0317.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB6350:EE_
X-MS-Office365-Filtering-Correlation-Id: 13071d1f-ce6a-499d-5663-08dcc8f51783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7pqKNjLJmf5gjcVR2wpLshLU7ohyJEp/nPcwOuJg/e/DuUZVgm4PCDiTVXI0?=
 =?us-ascii?Q?7YpDu3VCh1uIj1g+P4ydV2Jdm2nw20QI5I7NFV2E1l/DfU8MYB/JKxx5mSp/?=
 =?us-ascii?Q?RMMTkBzggrIyaFx4UX1+Unqt0N6mQWb8mSlQSESkDbj0XDq3ERZcf7QE2K2r?=
 =?us-ascii?Q?JS1ztUgJLUIXKuY3AglOaOWq7DVLFHjv+tThiPFAzbXkwfOLF1kf2XbwdjVk?=
 =?us-ascii?Q?U1WkbH9++6NrlgZL/4yH67Q+hxJ8Dbq2GddrpdIvfS6BMxoCdduv47k0BZpi?=
 =?us-ascii?Q?S8JtxTikYA4n71QCXuYADaJPyGI8inCvC4gSVqfNDIlJBp8SBKaCIYMb+Jqm?=
 =?us-ascii?Q?ZMKeQR3/vx61iHQribyJb3vMtuhFap9bc/yIhlBq+chQrsaMwJE9SnqrpRRN?=
 =?us-ascii?Q?BW6vvN2hty8ZmSfYMaG7lFgKoMNBvFxSfdKWLTfzf+3CdYe+L2m3R3V0l18a?=
 =?us-ascii?Q?xhqTqsGf3MbPJoKXYvW0ZmL4LkmBrbi0Tws2vUl7kStMtKycrduapyjjVVHa?=
 =?us-ascii?Q?6CKWJE8wuZtCaoCRGz4ayiPD/WWFQOXRehU4HMUHiEMT19ddc7+2fjPK8RVY?=
 =?us-ascii?Q?7Bl3bPWaobkM0tHU5pQoMPfEg24j4dicWOxUIWIoNaV1FJSqsPS/AY/xkqLh?=
 =?us-ascii?Q?+IofUNAwypwl+V23fcs8RJwGQ/0XOy5UbV6RCFe7SdQNmZdjDZZaFu+Ze+ns?=
 =?us-ascii?Q?rc/CJ2z0PUiIjRaDQcUfJKWh1dA8hE+SC9P7qVVhDxv/VmIzz8VPXcrUTGRW?=
 =?us-ascii?Q?eQScl8bw2HBHXFZalTjJvemHaM4qMl4QzedEcrPiLjLtOMsSV4imsWatye28?=
 =?us-ascii?Q?mG0thWIW7UM5h0XXHKe1ivzOd/g4OD+Ep1IH7evAFJlyFgoBa1ojSfP8nffo?=
 =?us-ascii?Q?VsmAhxjr5Q+vgFzv5d5O17Jx+SjMEIpWMAijD08h7UbSPmj4/tabptd9/UoH?=
 =?us-ascii?Q?3+g3TofKSjslDbflUSDt6BfX3L/lZwC6a/9IawrkAca6upPr1ZA4czYZXHnI?=
 =?us-ascii?Q?KQKWiSTRQ/EuEJpxwjOBRSdYKd3GpUgRD623opqvJ9ZtfXsbSHPmK4TSFl29?=
 =?us-ascii?Q?S+UqtJ6aRiAFPxW7a1ob06uocM047I5SByX7BmwT9kQ762VgJU/9HajSvyXm?=
 =?us-ascii?Q?6JZ3eQ7EYqTMoRpnpl/qSa47MQzs27sTtJbqia3BzarmvCUJBE/0bMJToQFC?=
 =?us-ascii?Q?xgNV2sCTfNcDtfFZakiogyJGUbXi1ICyAcal+ucNUiBr1V/95ijyREbQQrYg?=
 =?us-ascii?Q?KQPwFkvUouTnSzTDheanEThvVIXoXhvPaeaYd7RFZm0BK+2gJ9J18zZbswi1?=
 =?us-ascii?Q?04G8/e+x4Qb1kQdOj9HDcA9tCnYFrFnuRJ/hs3aArF1ubQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QB1axfaSOwoiLuJSgONRbs0ELAjlfbr8zhPXfhY1y6zmXC6GUd7UQiPGufi2?=
 =?us-ascii?Q?vbLLT6ozJ4ei0Zkoi1darE7NlNH/16pDduToGpss/kE5iSqFwImFHMhWjqhF?=
 =?us-ascii?Q?8ZiKKH1gSZ/AD+kKNQ7kDZ8sSfHJSy3e5ya1sbp/TlTpmCyNFWO18bkOaba+?=
 =?us-ascii?Q?ef2Qazt6eVPPllrSUll9dSY3tiNpN/IaFy6kZIaGpvLRS90qDh3IYEz2WE2m?=
 =?us-ascii?Q?JNsFuD8KxmAIl9XfOBpeTbrXv/rlwbJARlos4ZmiaiA/KMTRUgWJFQ9fs+Xb?=
 =?us-ascii?Q?3O+t78ryX9zKDrSOKh8d7j00lc6DwHszgy8Dp2sogGyCvr9w7xuU3uGNBSNJ?=
 =?us-ascii?Q?OzJOECu4Q+70oMwkge6Lkvs4w6TrrpBhOdRxS+QXJ/Vev81yxgXhsG1COsEL?=
 =?us-ascii?Q?/UJ6eiGGbb9sYZrOjxWqWEIhCJsROjfNj8z0X8YC5cy5dWvfe80qKq2NZirN?=
 =?us-ascii?Q?4xvTz1pf87wz+/lXjW8uLxinbVIcuIFvokt0qDdPdhI7evsQ91uwSgoskmIr?=
 =?us-ascii?Q?dml2aAOoHb5CSvrWsCzwwQ1WZuI/Buv+mpyMq2m9VzM5o2dN5SQh8SRaDmTS?=
 =?us-ascii?Q?sUm8k9FkI9RfKXDiNbl6p28Ee1OKPR8Kaqu1t91kSQ8//2JiVunGWac4eTPG?=
 =?us-ascii?Q?KXjqqPY948S0/EHsr8GdgnqC0NaSuov/SWmeanyg7GNN0cRIC2n8dqhdQb7E?=
 =?us-ascii?Q?tR40DkcuCHJ2zUolve2Xwv0TDffCPagNLSPtm2gx1KD9ne3BiyTlfSBE5Mdh?=
 =?us-ascii?Q?1TNMFrR0YlCixW6CkJbUMtMr79GnTblUf5+vw+/hKKabvIdBPHq/YFDQxF1D?=
 =?us-ascii?Q?/Bo6bhOQw6Mw/yiO6K0PrnUadttWG4rVText0JWGI4i7ETckpZgcyZq110Q6?=
 =?us-ascii?Q?NRM7+gatwkOZ6KJnUrugDrfmiHZoNe+LvdnX2NmEL94xPeVzfRg4Jx3JRLdJ?=
 =?us-ascii?Q?GszBivVIlYgGRH0JnRqVxqPK0VIjlhneDOVOSJ9jQjvkENXw/hmsXW27pmL7?=
 =?us-ascii?Q?/XMBooFAkkfPRjcgPz9cgY6JId3H9P7gYklRVNMUZXFWHFHVrTFO80LWQS9y?=
 =?us-ascii?Q?LMwy5ByrcoG190BI/qoZjq6cECyzvXVnIkmAPuZ7KYqUmgPx8o+h/NWXMHY1?=
 =?us-ascii?Q?LVFrD2yUh791/JwS7pEH2SCVtSIp2iDnR4jv5nELA9mrrVmctIhq32FlK83y?=
 =?us-ascii?Q?/5CiOSUi33+e9Fgw/i0oxbS0uocyv5e+AY9SsZtv9cuW4USTQzkUe9gz00sA?=
 =?us-ascii?Q?H7XFT3qa4OEq47DaJwTorwmg+DbxeWWKuba/UhLiYCrbamxw8n2zxh3BKQWy?=
 =?us-ascii?Q?e04kbwblVO1pfFizKyqls+InujSAxj1298/99wZxLPcezcKykr10shPnkehk?=
 =?us-ascii?Q?83eqmoF4EU/fVqCIXJwe71H8rr0jBA7JA7z1wKmLDDVHi1FyfaiV9GqE3mZW?=
 =?us-ascii?Q?PINLl/RxC7RKyjIwD8rytC9wK5v1biaUtneCm1QZWmdN7NEzOxAHU4rAeFGQ?=
 =?us-ascii?Q?H0dfJzOp/sUbvPwpFMNr3cu7zZYM/BhM3Oj82OcPNLburpN7So3fp60PWzv+?=
 =?us-ascii?Q?g2CLpLTqODfsll2kr1Ji2B/IRjHKCwKpYS+lV2WRV7GtOlYn5KeKtrso9o1D?=
 =?us-ascii?Q?KczqOw8CjktjWaJtFdJvix+srLV29vU6meL/SbzjaXWH5uSjumL2zuZ/5itn?=
 =?us-ascii?Q?sInxbw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kb9kADNp2ZtaEG9myUS+3V2j9zZPnbEW2YRxODbAFp1lJaOepghtvoscVjfWc6JFpPc6qHHJ0aEVHA5k+eGMQJ7jsOU4vMxT5L/KoULVwUmWAMblcO1/tDizBT8DlZWYV+lC57AoBNBXdkyoxvjP2ohxmzLubLXaZ3QBhlA8LzYMhv8ljg6VayaeKyy421ikwePTpWdC7MKTz6e8bAIEpGo/3p5FeNAqsmpbY9zGIZXfDBRCu2M97eXuarfXwHOuICkQlPwifsJk6zo053UQyLBqiDG3zEc/iQ/yktLGw6TT8/Rb4TY3MmLbT/eXGiX4yh9bslpWGpVGMjVgtlVrePz683MDGCdGMW0ejeNm42+mLdDZNg+AIQMMwFqyca7OYR4TuqhA8elBFT6g4g9f6BTYpAPCIkob9yrkUB/3H9HOZ25DOddEGT3ZH0jHM4CJbE8YEoNDCTlxGGX4ltj4KJdfhZSyeK9U8tEtvSNh2p2PziGaTYjclWniJ8hBzUADAIuqOJ3sWOlMmwr5Jk9QMjz3PRSOjcU0ltcwyvmmhwG+yRW/1Q4VUPGczxS9/bmYCLfK/GS+LSSY28obvpaH1SY0Rx0NtN0oclqRMmZ+BzE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13071d1f-ce6a-499d-5663-08dcc8f51783
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:10:16.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5ZpYdykkMlzgjjOv0c5NKKaXSvKlvYLKr+xBsVfQKLKENmsXy8wnZUNPGEqj2/sAep/PU5YtsC0T7o77mDvV+ArPLUHpHmWuUmO+ENfx2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6350
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_08,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=455 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300100
X-Proofpoint-GUID: HI9tESrfWdFTQCmsJOEsITV8oiwy-Uaz
X-Proofpoint-ORIG-GUID: HI9tESrfWdFTQCmsJOEsITV8oiwy-Uaz

On Fri, Aug 30, 2024 at 02:05:23PM GMT, Mark Brown wrote:
> On Fri, Aug 30, 2024 at 02:02:33PM +0100, Lorenzo Stoakes wrote:
> > On Fri, Aug 30, 2024 at 01:59:37PM GMT, Mark Brown wrote:
>
> > > Tested-by: Mark Brown <broonie@kernel.org>
>
> > Thanks! I will be folding this into a respin soon, are you good with me
> > adding this tag to the patch 6/10 in general? No worries if not, as fix
> > will be subsumed there.
>
> Sure.

Thanks!

