Return-Path: <linux-kernel+bounces-547635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6BAA50BD6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA87189542F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DF1254878;
	Wed,  5 Mar 2025 19:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L5H/69Go";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fl+Ugew9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B82252910
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203986; cv=fail; b=cEaCYNd29uPkkY8DAAi+HxLoGZ9ln+DUs9ZuoUh8PwkcNexoJAD2GzNqeT0f7U8PDKft84YZF8VHXbCdv/fVCNDFb41604MMfH+ANcxAGBbqRqpqHVn6QxZnX1UmbCD8i4XvKOA1G0+PkfcRxmlod0aSZhrp//RzzRDYIglOLGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203986; c=relaxed/simple;
	bh=HTfg8p1O7Wi33dp9y1nT1ySqOlwixNLYx/7rehpzO3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e+Fj2QCvTlWUnCjr6uqMqRe2oaNy2l9yfHq2WWo2aLKowPx7GgCFWWEgDAREaIu4RPscPuYN0amhfMhvj9p6AJ83/VinBaWNAWpNbZvO+Oic32F52ZXpbj1bgN1gfxsUOr/ft8s1UUqwBuexL3d9kksnSMbEgVdMtmNNaoTi2do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L5H/69Go; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fl+Ugew9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMnl8014286;
	Wed, 5 Mar 2025 19:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=QK21Wu/LJRaHLhO9wd
	XXP8CmVW/oZqPE7ZnIlTppIII=; b=L5H/69GoM2wg8FftLFzG8yhi8Fq9c1bfX2
	l+vfPLlGbHqMWq8ih7FkTeEq8Vgrimy/uXXl6VuFhMVoNp9ycBnLjq59tKrmXtpm
	eUkB9b+tA4JjZKfdxDzSSm4kzxXGwwmEKGH9sHYhtrvZvam1kshxunG5QW1fNRQc
	xK4bPVx0a1TSeQ4VkZi4ahdHtnjEiCluIhsiu5bebYUdfeNShAVdbrOswi44Bm7c
	nZ6qW3VisjdorDqx8pn9U77HGGlGYOpa/7Xhk8i7d4vBETcByu8f6SROONP6OIDT
	qXNJDz1M5WlgC02EiICdJTOB6tHDbgzUFFIkLJNPA6RI9cN0gojg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u820h5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:46:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525JJR1k039103;
	Wed, 5 Mar 2025 19:46:12 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpbjxnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:46:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgGg0TGfxJtcR5/268UsYAs5nDLfzynZSlAw41exvl+ZPOyWxlArmSb8UeKqUH9tAn335pmcz+0qRstmNIWkhXbxq7KLZPpFtbaTAx2I6G2zDgXcWrhPyZGaid7ikWptRhpMaV7k6hIWyTTCKPtyei8xNk9QH5OPvNYkkMKybnLFZNp6F40LhCFwMh2kEqCQVFYfjUt14ku4zNxWt8aVspvLEI4sBr289YUGJUVV46Jww9GV4r5a5xzwp6AjTBZ/VMAodXzYRjeFzU5ZR18ScBB1lwtaEX8J58YjKhVshBpg48C/Da+0J0dAHUNCb8qQu7iTs+bmTtUunfvSs6/yDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QK21Wu/LJRaHLhO9wdXXP8CmVW/oZqPE7ZnIlTppIII=;
 b=qP7+FnzI678Wxxz0Vc4oyU8puYlt4e/D8PzrZRbg3fm88xLYSh4JhaX0lh5+XPLSBo76uvjuWhpJoC45U7Oh6UzjBehDAlymamYINESgJ6dATxeJQOOuFoP1hSmn4/TiossA4hZZWWnyvxg5r9/nB/152XQcMu8peLc73TCBGgYJ2dlgg29I1Tg1pjV8b4PVnTgumT8MeH9GWq58bLlwEjtn0fGzMvhb0fLtTQVytg9U4EqB57MWe2T3WsATsc4Bv2AaErLReU7UQXUvekI8rENB3bB06q4SBJYqrjbE+6bw7sYpvAQaH8Mig4Qa+fnrCT3GCZMH5G7dmgSA3OeiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK21Wu/LJRaHLhO9wdXXP8CmVW/oZqPE7ZnIlTppIII=;
 b=Fl+Ugew9tKQAcVFNO2tBI8NXAzjskNSl6KxZ6vrDk3MQs20yG0c/X4kskpFVLfK3yn6u3cfFpprvjRxds5FE7SjHzWg1VnBmza1aG4t9GR7gLsWjp5M87woxDxnN2Vp0zx/PTFChNrJ4rZ76EUCdg2I/pW+OnJM/x+jSS4l+yJk=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SA1PR10MB7596.namprd10.prod.outlook.com (2603:10b6:806:389::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 19:46:10 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 19:46:10 +0000
Date: Wed, 5 Mar 2025 19:46:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm/mremap: correctly handle partial mremap() of VMA
 starting at 0
Message-ID: <2b28da79-8f2f-49bc-805f-452f91958eac@lucifer.local>
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <195c3956c70a142b12465e09b4aa5e33a898b789.1740911247.git.lorenzo.stoakes@oracle.com>
 <0a4b2608-2dc2-42fa-b30c-1c1a62b56bbf@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4b2608-2dc2-42fa-b30c-1c1a62b56bbf@suse.cz>
X-ClientProxiedBy: LO2P123CA0080.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SA1PR10MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0511d4-8114-48ea-3f70-08dd5c1e6105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZOszzg6o/zhkueFaX4OdspJn+Q0FkpsxJzC0ccuDRUJ77g1+wWS5egI3XpgQ?=
 =?us-ascii?Q?bxpj2rIWyRIh8CFvXaKDF656UmjJQCRBPrQgVYFnS69OvzGkoulwcGJfSJpE?=
 =?us-ascii?Q?TnX1rOSxmWHulYufoZD9kon1KqZE1lURkyKmHS6JIDuY/t0eO1Wpj+QeCU5g?=
 =?us-ascii?Q?6jAcc4LFBHmCSQGI1Jlqc1OLHWEGSGzLM+9ONaNUplToveCd9QQdMRRQxrGi?=
 =?us-ascii?Q?42zCKleJW0fZrLEULbVSn/PArlAA/vcgoDrSNjhngwqL+d0YHNpXfMV2bE/1?=
 =?us-ascii?Q?tvUOzd8iwhl+DVUbpvTJvFldZMCVFU1EYW0rcQ8p66XxJH83tHhf6dUBQhCg?=
 =?us-ascii?Q?kwcPPv7uMvcuKen92bATRgksHWmW36PTTspC2BsTFZQVSrPPVpPqPfxr4Lja?=
 =?us-ascii?Q?aCX8LBVL3TIlHHGfXfJTnREfSqih39hJg0ifrsHKYou/0KUZ3qIUxzzGFuF8?=
 =?us-ascii?Q?AvGW84RFIEbZtF3+xm5cYg5AxhvRSWYmE2KNR72MDDz41O0UekJqz0b8qPTR?=
 =?us-ascii?Q?Xhd3AEdxrNLsjTZbVOdc0wxrDgTSBNRij9XdVGEvUJaWHfQEDRYtnuSnNPgH?=
 =?us-ascii?Q?hxbUSNMFlJCUNd3KthpaEWjCmgkcQ9jJiYxllR31YAMGWYBggHn+R4m9FRM8?=
 =?us-ascii?Q?H0d6JxL+cARah5WrKAj+o85zOKdFto8Xc/NU8pzKimh9XjHFNOCNQd4YJyy9?=
 =?us-ascii?Q?srWuApvQEWT4Dvjj78sjadXtk5Af1Esb2dtW89tZ/XIVUU0OTMAY9aDedm3S?=
 =?us-ascii?Q?44SarU+VH3mRxVZshCLLGu1PYvOLo5IL9YZanpCTiphSaouHrr4+2Up32Gao?=
 =?us-ascii?Q?JQY+SaijU1g3c011hjFaI+bfo/AP40ovan0egiGEsMXbv0B2vK0zemK0zy9q?=
 =?us-ascii?Q?52bLQdBLhiSMi6PNFKOK9RZ9PkB4Ojyy8Qi53hvrG+0yldiRPRL2bVdIuM5H?=
 =?us-ascii?Q?1XzY0FmL0NNfkjKYIqviHL8x4JL84Dg4zfC+cJI4cQPSYkV/Sv7nHmEBk1fv?=
 =?us-ascii?Q?YY+icRg2BVNeTcyUDSWzCEIUxwfGwWFG3/kbHG9/bdBuBxFfgh4R0kZtXfvM?=
 =?us-ascii?Q?fkhycQhqcndJ6qb4ya3VaRVID8hpGZvCGFyI144OZN8NFEf7EIwzBOOyrkY4?=
 =?us-ascii?Q?b4iG49rSQvfQ3oi5gYnycVoWG9TnTOq50+8tSXdTCZIwUWo7jpKtwDcK+mMO?=
 =?us-ascii?Q?YQOfTeeZZvIWk9vq3hh8bawn74on1sLuzLusNI4GQ7fNlTcr+2y3gGL7945H?=
 =?us-ascii?Q?g5inuorQXSFaBJcHXXO/VahTocLOkXsNrnqBjiz6TvUXxSv9D/g/JjLgKNKV?=
 =?us-ascii?Q?QxZ5cJ6sLaZs+ptK5qt9fflxxa9izXrKkApjwVQAtLXZuZQBCUSaLKoFrHWv?=
 =?us-ascii?Q?5SsMUDCVGTfdpHYyu7yZat1EgDWn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sUb/FHlhSWIsAm7oxghY1ZXlhjVVvbVxzL7xELg/oaFBjfuPLg+LGN5TG6/n?=
 =?us-ascii?Q?kaz0GR81hrj8piLPV6dVTZYmvAIXX08zq31dFTV+CqZOi/zXmrM7q4LAoJWA?=
 =?us-ascii?Q?ou+8wTRu4GegXUx7p6iY9UrxvS+yqeCAbjhMjX/eRLREZ9zarTUtarbAAPRV?=
 =?us-ascii?Q?N1ZVE8F9rosZ83yQnIGIg5p5XQnrbyFfw5OCCnIxetD7kePJi57vIHUIIQEe?=
 =?us-ascii?Q?k+Swn7g6htOd46ZT2I5PwZ9vOpM23IZRWNttR7Uv2rNu5SRc4GRKbomZaoTD?=
 =?us-ascii?Q?4i4H3iJ4ZsmqOgCxJ7txNIRWqbjsvLkFrcO2q0crd3C14KoI+5c9DHEo2fr/?=
 =?us-ascii?Q?4c0O9sBGh9DjtIDQJDhto6kUS6tRk83iLtUxEAi/vgy8TSpWUn5Mx/Z71vWW?=
 =?us-ascii?Q?99AZLv0SvUD4/aLRYtQEZVtQSacdMqF0Ci2z8f7u9brlkwcmeH1yWBhpR6OS?=
 =?us-ascii?Q?V1aUXp3B3ELJo6qMwD/OlxkCYBQtWl/iEdu2gvR0NNQEQj6tept320FrE2eU?=
 =?us-ascii?Q?3jjNNrptCBI1gS+K1G+WzJKvtLhZMTjtKj1jxjvrNV7iW5XxrF/lYwe0//dy?=
 =?us-ascii?Q?vH89r4+Wsoq2aswJK8CP1NWNLc2ZRInts82BoIV2NBiyzV17QFl5GS8ltNCh?=
 =?us-ascii?Q?kiZyldf6SCmdJ103f35LIyBiSHiMEFuCBFdL4L3auumoX6+gaduBLQBminFl?=
 =?us-ascii?Q?erl3C4pBKqj4fueXFploQZPEK03RHU2J+nH0HbanWWjrrHSaRVyKsfudHmyo?=
 =?us-ascii?Q?hzBW0hJwpUZoNhcrjHnyzInkd0PoQ0IcoHGSBj2BtX94nbuXPajRUe/CfSTx?=
 =?us-ascii?Q?KEVjEMedJKi/z3ciHXfCVgmsxURn+2nhkt1Kd7YWx2Gf+qdS2VQAHTq4yY1J?=
 =?us-ascii?Q?4VOlFRiCu6NkXhgkxpIwfr/kWeJYe4GTI+yPXhyDh7wEhMnAysgVi9mTeFAl?=
 =?us-ascii?Q?zJxXaXekH6xzOYHcg9gfY9DajCLcpQY3HUMj0pQjogugQkpOAiXPCZW5DHyv?=
 =?us-ascii?Q?MV/MP1+uBEJSiVDkD7ol7S2kG2OK0R8rUPVLlOcZQeSLDQM6lllxtS4156uK?=
 =?us-ascii?Q?uQKnPiJxMrTa+LTUNYJZem8fLTD6PLyW1rf+CHRrZ7pvFtm1q9BtdXGMY8bB?=
 =?us-ascii?Q?OG6ELmnVbJUC3rcTfrsS8Pz72LZGVMBToeoSwITsaPUYdAIgOncW15liZ9fY?=
 =?us-ascii?Q?vlLr5D4lEtIpXYcjoq2EeqxpuBM9jTypd7D6a6HQEE21j6onBURuk3CtuhT1?=
 =?us-ascii?Q?6MyafqzJor3awlwFkSA0hnvloYjkfXWoTlEmbnGFRucZyoyKLUd3qxISN9Q4?=
 =?us-ascii?Q?fpV2S87+YM3UuT5CRqTAC8GwT0RMD5UD1J/Dv7rIVOVkLfHq122Dwi0+rx3f?=
 =?us-ascii?Q?GmILRQXztOnhfSTLkwGE50hi3yobsFMYhaF7+VVADsxSYtZFzdB+AEzNo0aY?=
 =?us-ascii?Q?ugJEi2zv4qM7TKU0thAGd6MqCry+/rURDdYmbgZ8AQwiPqZN9UUtlEgKebfm?=
 =?us-ascii?Q?uorIFdFIys09V4iRba/5klmLZdz/SGF4ea+0Zwo4BBtIeXwXnBIiDKHYcT3H?=
 =?us-ascii?Q?nQQUKtkYrXeeJPHGlrcnNnhwb4z+HSv0hRCEG+ljeMvQEWMi7ZOQovY6ae8W?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pMk1TXTJw1t4komgeUChL3tXHLQh3sgFdJcVt/vK/EZUvhPFd+b7eMtlwQfSRYXJkpGvdrzHJNYIUNWL9OswcikFVyrcxh5+I/2T/ntpBR8WFdxS8p33/HpE9bXQxP3i2Diniv8XiDlr2jYZ+E4/BbztDU25AB01C8qgrhmWQV5/8TvbXiXNZaywIwNBKzDiioSONa1mgibmnQ5INev71E3+mNhidDAyGy4IGBQ0R92GfhfbccH+a6hYMUEPx6GlDiYRD3K8q5Zs/cuuK4RKfI69Jn7PsEVFzuYVMEhCo/jQEiK+tMbjS0Pz9tyJSokmx9NOW0JSoZ7qkgAFHa7MbK2Cs43hzfTbuEKFZhpbrJCeuDrLG5XCz0fHxhbGbK0jAEw0BSPEU/DMysIlycdl6GkQsbLK0MbhOy+j74XwKz5pI09loSw8qxgYxNbkgjPtbjJMBtYPCFd+EuoQYql3gTjpTm4faD7UAn+Cx8C8iid+8Rx4jwXh4divRHHd6a60NjvS9P0gUWC6gTqJzFWWCZuTXpBSeAeorjPZfXepNvT8GpQV10kqkUBELaM6Gvnf/MbYtV+R1QJDyXcbbVzcTGyh4X1Tmgg3Hy29PgOlXjU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0511d4-8114-48ea-3f70-08dd5c1e6105
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:46:10.5503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnVAkSvVluRqPBlPAu6KNiR07rumKwPguy6F5y8/4QjKTxYTPy6JZeXujdHXwiFP4DEkxsiIfMEEazix4hnKS9ehzQBnxF7YI82EMxpjOdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050150
X-Proofpoint-GUID: B7awJ5hYlYHWOPSy1p3rG5BoBZ8T9Aga
X-Proofpoint-ORIG-GUID: B7awJ5hYlYHWOPSy1p3rG5BoBZ8T9Aga

On Wed, Mar 05, 2025 at 12:50:25PM +0100, Vlastimil Babka wrote:
> On 3/3/25 12:08, Lorenzo Stoakes wrote:
> > Consider the case of a a partial mremap() (that results in a VMA split) of
> > an accountable VMA (i.e. which has the VM_ACCOUNT flag set) whose start
> > address is zero, with the MREMAP_MAYMOVE flag specified and a scenario
> > where a move does in fact occur:
> >
> >        addr  end
> >         |     |
> >         v     v
> >     |-------------|
> >     |     vma     |
> >     |-------------|
> >     0
> >
> > This move is affected by unmapping the range [addr, end). In order to
> > prevent an incorrect decrement of accounted memory which has already been
> > determined, the mremap() code in move_vma() clears VM_ACCOUNT from the VMA
> > prior to doing so, before reestablishing it in each of the VMAs post-split:
> >
> >     addr  end
> >      |     |
> >      v     v
> >  |---|     |---|
> >  | A |     | B |
> >  |---|     |---|
> >
> > Commit 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
> > changed this logic such as to determine whether there is a need to do so by
> > establishing account_start and account_end and, in the instance where such
> > an operation is required, assigning them to vma->vm_start and vma->vm_end.
> >
> > Later the code checks if the operation is required for 'A' referenced above
> > thusly:
> >
> > 	if (account_start) {
> > 		...
> > 	}
> >
> > However, if the VMA described above has vma->vm_start == 0, which is now
> > assigned to account_start, this branch will not be executed.
> >
> > As a result, the VMA 'A' above will remain stripped of its VM_ACCOUNT flag,
> > incorrectly.
> >
> > The fix is to simply convert these variables to booleans and set them as
> > required.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Fixes: 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
> > Cc: stable@vger.kernel.org
>
> Looks like the variables would be more accurately named account_prev and
> account_next? But maybe it's refactored later anyway. Keeps the diff to
> stable backport smaller.

Yeah indeed, I think it's better to keep it relatively smaller.

>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks!

