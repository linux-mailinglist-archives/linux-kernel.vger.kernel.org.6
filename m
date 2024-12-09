Return-Path: <linux-kernel+bounces-438090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E126A9E9CA9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A0B1887337
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C259A1531E2;
	Mon,  9 Dec 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SA+s4wgb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oj3e7pbw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D2A143871
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764185; cv=fail; b=NdozyKeNU6YYqTEK+foDIm4b2Jf3cJyEGIsPcdO7fLnCyUaiZFlJo2/UZWUt3hu1UTYFG0z3TzOEwq5aOp5W+QvwFbCKH4sDz9nRE1HI6naX0bfaDkBeW+wB5ZrwEuBTr7P8I7M1tIY7EwcnJbp1a73rLoUC0zqbAvvkYvaVktY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764185; c=relaxed/simple;
	bh=6fJaBfKk7F5B+f82qTW3iVr3RQUN8dtjG1ZSwu0n9tM=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O2YYyvX3lA44NsqQImRWQSwgbKmP4Z7Tau1rm9HqCZN1pn4V9iAobsKPIrSLDJehzuF0aYH7f9XD848tp2KOqpPjFqac4RcaUfhvep3LG8Qp45b6XnBhRYh4zL8pGchb4Q1x/MntMaINW70J6Ed5KVUFo/gF8H1JY2jXe9SmOhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SA+s4wgb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oj3e7pbw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Gfr6V030210;
	Mon, 9 Dec 2024 17:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TswIY021muudANnfZO
	2nlILiqA0d0Wddabtc++z3/RA=; b=SA+s4wgbMmXfKOUkhRFY1XXvdZAIcoXe8c
	b9K1yOZ0Y2llmGXnUWz7Xrs19NkLnn8/gYqvyXuLXRiNhvF+eY1A6C/wJpfuDHrv
	zeyUIjSKui+tM2Nwwz/T6YagwINWwuvdMphbIcVic86WKgDCo0IPPUjSwNwHIL3G
	M3qyWm0P7mrPft5sf5GA5ffvrJdriTuMhdNPCRWGPjGx40TyA5YJDb3YU91FZqR5
	mMbKL5U/4YLn+h9zFC/L2vRIU8Rhjj9BAtyC4U4LeshTiAlHbZ52m6fqNtI7fyB7
	cX8ucDdG5ftPLp/Ve2tlgTDLf1Pf94SjUtwVWwe6UDD3y3KSpx6Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy03syn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 17:09:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FWQwr019344;
	Mon, 9 Dec 2024 17:09:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct7gvbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 17:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQtJmaNhm8ujb+dE7zPKfeLl4vFPWlQAh8N9e5jXMg7Xm/7Uqa+T8pzmW3vX4pV1a55Hju2xiL80iQisAb5femCJ/X+b8x3e0nL2bLP1V+H41f+qXbU5tEuDzjYIUM5dIUczNTEgiAq/hKI8/kD09SoSAC1c76OhnGz3W66hG6otV3RxP/LctG+miO6K4GgbdHzHY3nZCZjXzZ6kNMso8+d/T0pf5QhlAWKNEcJJFx9CDVmDtGLuM2JO/3wEHxBrMrOj6it98qa4OV4zGcY2Iv4u1LBSCbTufaKvjNAu8yjQNjgD/OzbrytZCQ29OlMc5Xwc7WDsemLPyuUQeh8A1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TswIY021muudANnfZO2nlILiqA0d0Wddabtc++z3/RA=;
 b=Aakt3BkKaVLEwXo79hAD2B2+L1oQu3GRdDHiKIDTc7iQoRrYjJWRluXmOGq2m+wfmEc2W4XJc0Wfh+jPhnrZnzjVhbdxEnnUXZZJkCjnB08MyovhSpsuBMZy9YbSBt6LtnY4zgjmzvEUKNCJi1eWs+AUt1hqFQ3BjCrGO778f/8cE0S1CkABeTpjD3mOpR6QoezfUTUaGilD/g7mwkv4PbIVE5jTfJi5keY0YXoRKba4qWVABAl3nZcyS+S9DiR9h3K21+8S9j/mv4dLn48bN18w+AxJiyipaVU/yQUACwtaG17MWbqNftL6fsRC9v4+GjDmhOXmKSECcVmz3llGsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TswIY021muudANnfZO2nlILiqA0d0Wddabtc++z3/RA=;
 b=oj3e7pbw/jf1sLeRnLhaYtJdvldiPuyA/DMjm8Gtev2NrB5CRFh/JzEvz2SroDe4Ko6bPJ9liJAQXUglp2tzcXD3hG5yZa49hbf8duC9oFkjqCo9EDFyPOayNaKGK4fgPnAAgin4tbXYdWyfNiKkr02yQFjI9EbUP/s4xij/HiQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB5057.namprd10.prod.outlook.com (2603:10b6:208:30e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 17:09:22 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 17:09:22 +0000
Date: Mon, 9 Dec 2024 17:09:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, mhiramat@kernel.org,
        oleg@redhat.com, peterz@infradead.org, Jann Horn <jannh@google.com>,
        syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in
 find_mergeable_anon_vma
Message-ID: <c946c9d2-aff3-4492-99d1-d50e6e2659f6@lucifer.local>
References: <4d05caee-d900-42e5-84e1-448cc62435b2@lucifer.local>
 <emgf7rbacg4jqsnyg2mgmlbbeehc34o33fpnkmlaghb3xynzjx@gmldlwjliwiv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <emgf7rbacg4jqsnyg2mgmlbbeehc34o33fpnkmlaghb3xynzjx@gmldlwjliwiv>
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: e44ac062-98cf-4dfc-b3dc-08dd1874399a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JnsQyADoJ4l9uBT4kJL2BtreQNvFDsXBVezEcMgKWV2reL96IfpyS9yZsdBS?=
 =?us-ascii?Q?RqKaxgU1NEzduND2owyEOzA2Qjrn8tPRtghbj06vTMy47GrQl8qjMxmE7+tm?=
 =?us-ascii?Q?lP27ZS3hhNBKzVbjMouav5vxIPbXIiPkBUMskyzZRhG1FAry3gxK0xRPgaQW?=
 =?us-ascii?Q?65jwQaFsNtfAWqgm/1r03EQa+JcR524D6qmdxccTHlyX3SOodCzbucO2tXHV?=
 =?us-ascii?Q?NXkYhJz+7q5y33eGlsfJ88l0xcGPBP6k91zbuDsb1svuIXlATN4WSbO2ICbh?=
 =?us-ascii?Q?VfnXrTwr8I6HCVJny08w5kwEzkPpua9p0Dl0snpJRPUUSPuvjVXUJK4taY93?=
 =?us-ascii?Q?NG+gQbCU7zNbAS5U2q5fSgzD4FgIeQX6GPVff4jGetcx5u1VoBP8LUMUkYq8?=
 =?us-ascii?Q?dUQG0sjEcXRsPGcc7lN9E6TGsZCPYTpc9+0c3DSoTmIr4Yv5jMrE/hXyio8f?=
 =?us-ascii?Q?m2Mej+woX4x+06Gl5zMdyyTYb+S4tZNOV1RwFbaeIpJfqBPkIpGRgtfwTxJ6?=
 =?us-ascii?Q?z26aApojyTgK8yxzkHwNFFHINIzLrxX7bpHXWU1ZYvfKKpmKp1RIKo4cm3Ew?=
 =?us-ascii?Q?TK2G3+2dR6xx7fr2hAuZbItDJLZife10TuPVrmzDCJjuIRZSWsssjFQdri40?=
 =?us-ascii?Q?p8uIwFOCwL7kjaFeo35tR0EHBzXPY0RsFjO3KEAq3QeT8hmrnVBGR5QnmphG?=
 =?us-ascii?Q?oZwo7rRWhnv2zJ7VOjwG8YMJLPtzuuKR+QTYiC9NWBiRB+JSdqAQhWKR+Wf5?=
 =?us-ascii?Q?n/yjuOSK2rh9WwMHMTTYGuMMzOmAqqFYKrUmv6HfCRwe9CMN/wsPqqFM+/Ni?=
 =?us-ascii?Q?9OTx2MPw+CoyGFjbIFDLQ0aPSj6YgDBM0XZwTMsrUkMKiu6f9N9I/0BDQhwk?=
 =?us-ascii?Q?j3mb3Jmy61MDkZgoCs7k8lkmIiYolxehlNyzErpyCitdUdPp/L6uJgHrlZy5?=
 =?us-ascii?Q?Be5YL6VU6YQBSLPuyNesaiKRRs02wG+wD9Cf0ukVXDfRWdbUol4BMCI3Ujwg?=
 =?us-ascii?Q?y9Ki1c0SpZqopUoyFOokpLluZfQUb9XV1/bp51frP4hFgbjhdtyaSyITX+/m?=
 =?us-ascii?Q?u0o9tYa4lyaj3/YDEu6MYO5LCiBpmJo9nUL+jE3VxuE3KPFk+rRdzXbyXrSw?=
 =?us-ascii?Q?I9ljzMRnvcVice1gSyllq4YwRE6j4SZW9/7Pgpti1MDDg3OshjzKCaSkjXtw?=
 =?us-ascii?Q?0N2XIJFfInz69/MfEwVkyiVFWXgtrfuL7BzQYYwU/RyuiN16ymhEVj0TpZUE?=
 =?us-ascii?Q?C39biPCAOuBz/Ll4QX7Eq8EakSznxXCYJX45mthrxa5E1Xg5fs2AWy4e2I9u?=
 =?us-ascii?Q?QXPsR6MDF9NTuZXa5ySwMXdL6WIyzBAmX2Kp3OxIAxcAo83VL/w9YpMvNT1m?=
 =?us-ascii?Q?VUxslTX/VhHuN9dDC4HZa3D6F6Wjs8QIygRLew6UdNGGojEIVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v1zwlgIKVj9ImeATNvF5ciG6Bi+/FciemLkWe+NufTxn+JQfL3OFtrUAQzL7?=
 =?us-ascii?Q?dPMOkOW94NIRjqJNkggy6FWAAmqX2e3bZR7HRs3YKqZ0Q5pGEgciwB1l4hSY?=
 =?us-ascii?Q?KjJD/Wc2H/WThUplad+2JVKU4K7NhozYLMnBYNremkJrfX/4UCtg3kL4F8A9?=
 =?us-ascii?Q?AJsm2EKpRLwPmwVVEVuinB1Thq23ejrb/UHStzSZygip64oFNa8FKj8D3IlW?=
 =?us-ascii?Q?5KxCCBRiuFdxHsJ2UD3+lncavkenbXCyArPqHVDvdvKkvQphrMiyNYBFuf7X?=
 =?us-ascii?Q?UtUlO5xWZhzsKF7CTQ9HKyj82kAeswhgJ8hKVMeRxjgvvri0kWj+H53GhLxU?=
 =?us-ascii?Q?/bCbEvXWW4EGVaRIbpDF/7b36eCTkvSLTICfye8ImRUByCKYhsXZncxr+H+V?=
 =?us-ascii?Q?uy7w2SGhz6S8XEbQnNEFshl0B5eQ8Gcf+5YKY+NjUvAFqJ6nUtmJ+RAXrBZl?=
 =?us-ascii?Q?DHG6wFw5bGMrefduIxCsWoZJL4nytvVnb3YHdj/5V4n+AsvcCBYTNWw0Wx/J?=
 =?us-ascii?Q?f94Rc3U+eGTi97i+84Yjw/P0Po+9lVRG/RXKHLynvTCXp9VdJODVr9tn3tKb?=
 =?us-ascii?Q?Epk9iEvmf0qSEc2tmHBpbZ0PsQRRD0+p3K5Mm5lDSmDW8hxnAoA4zsSBTGir?=
 =?us-ascii?Q?3Vnwq1iueUdgF0sDK/OI8151OumqL0BHFtxg2nlNf7C09OK8WUZiW5oLdQZv?=
 =?us-ascii?Q?xSwFeLcD3xMYyHydf/yWU0bBXfjMitGIH4O6D3jYFsLWihYDoRkaw2FDs8nM?=
 =?us-ascii?Q?EbwMloY0mClKLM7dDILqaNL5GJ423tldKEjJbn20aBU2w3be+o0o6sHo/SAF?=
 =?us-ascii?Q?bJo+xlrk+MKYmOREUL7GzM6kQu3lW4Vn6GQZyDq/KS0cvZ+fNAR7UmZlarNo?=
 =?us-ascii?Q?AxNg/z8un3XvWM4h9nnzChHf+9upePQw3dfYnzADb4LMaanPYz+7At1Ae/0U?=
 =?us-ascii?Q?yByjlhdWwclk+dYaro/w5+kBIlLyXup/LxiMfl/WzCV1MqknD3yBcR2WEzZL?=
 =?us-ascii?Q?B9psttqVYd0xFqarEEHVUsayhzDf5ioVN+XFxc3FSXrWEinOGRqejEi2NN3v?=
 =?us-ascii?Q?o874D8g1zbO+h7gKf5MqQ3AaJCuCxeBVvLc0zquvYxoovKwQFKFbVmNknVVQ?=
 =?us-ascii?Q?2Rw1BW8bWSwLsJrHkDokDWnlh/xNwFrb45mbvGrYTGpoE1RY0nVIAmC/J6f9?=
 =?us-ascii?Q?3iVZsgu81iQFDMogJm0SB8RsU9agyuiWZZ6wFvIsvIWdv1fUfj9C/DtD6S4W?=
 =?us-ascii?Q?+OPmy7BELQ/zwmALaaS5NqTwhPtExdH7DgJe1SS/SDzqTUID4eHjsjwsX0BS?=
 =?us-ascii?Q?4pn4xMC7/JnsGIBzGWuGb/RBj1GQb9H3/HEs7h7vzPYJ76ePgKDidKG840qx?=
 =?us-ascii?Q?wBBs8Xv2PC3zKtFsMl3o8j7awFD6uiZ4Te2I7sRn6wUcKi6DzHAQD5shO46x?=
 =?us-ascii?Q?D3u8VKiWdMXTQNeeXes899tUGXlaBOfxLCzqEIgyRZYKJtmf+TvhCB8vkAvF?=
 =?us-ascii?Q?2+YwAx0rYJYZ9eta+IvN42E+hMkp1KD57MB/mIu09TDtwLFrs/lVHCXruSEJ?=
 =?us-ascii?Q?aJ6R4dQtcFQlZrO/v3VW/cI6BUzj6NSARJeNdax+pppkGrHMsS5eFQu6XY1m?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DDdktqWD9AFUxJp5x+8ebugjjwggtAlXWglxlIiJaxMNaltYZKTlIzASDYUnEFCQfE73acaJgdqzpUMIGbYhhzKBmfgHiIVjv6JpkhyMY3f61ZQMCb0MUfc3JqfrlydZGnhog9UVI6nYvozfZ9x9aw6Z36oOGwsxVmfWkLjollxASz89W+88OvQ6o0lp0ImPyKgnxUgAc1CNnodANaGnZfJ5GPxNibkRVa3CzSt00cnugEl9OiqyJFf06qST8AQ2z0enXR8QFTpuSF73wiarDeHBHDyd4kInv1cVOxpwX/4/2e5Bm5TXoODMTN076tn0T3+OND/o99JhDjv8wdnFVAqxLRK6mEvLW68M7zzHWJKCYUD7k1ChqVM6NnfXCWTDoTi5S1tSP85CXVhDjCf0xYFLxKN7mh2MVFXj9ury2B5lm7+ZfbgLwqYNq7CSlB3er9d7kK6Nj+2jPuaoSka7mZ6NEiYB7BIbOn+moaZSUTlG8BysLTQVJL/EVaFNSgXhhhveiVV754WTlYZuoSFbDUfE2jh51IGKyKwN9tt6BmuyyMT3ZPEUmSJLHb06oAWA7REL0voHq9LTtw8MgE2Y6XU4TRE91oxecaOzhTwGCn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44ac062-98cf-4dfc-b3dc-08dd1874399a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:09:22.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/NtYABWRx3lVXEkjeR38YBFsIiaHpmXGgt5yIus36eoxqUD0c8HOZfDHvnaTznkYD1Y/NQTzV1T3ot3iLYWSqkKX4ynlBLYpp7d8NDMFo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5057
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_14,2024-12-09_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090133
X-Proofpoint-GUID: H-K0S2V1-LuZ4Sz8o95hbay7FzEb0g8K
X-Proofpoint-ORIG-GUID: H-K0S2V1-LuZ4Sz8o95hbay7FzEb0g8K

On Mon, Dec 09, 2024 at 11:12:52AM -0500, Liam R. Howlett wrote:
> +Cc maintainers listed of kernel/events/uprobe.c
>
> TL;DR:
> dup_mmap() fails, but uprobe thinks it's fine and keeps trying to use an
> incomplete mm_struct.
>
> We're looking for a way to signal to uprobe to abort, cleanly.
>
> Looking at kernel/fork.c, dup_mmap():
>
> fail_uprobe_end:
>         uprobe_end_dup_mmap();
>         return retval;
>
> So uprobe is aware it could fail, but releases the semaphore and then
> doesn't check if the mm struct is okay to use.
>
> What should happen in the failed mm_struct case?
>
> Thanks,
> Liam
>

(As discussed on IRC) how about moving up the dup_mmap_sem lock one level, we
can put the mm before the rmap lookup in build_map_info() is able to find it,
which should avoid the whole issue?

Untested patch attached.

----8<----
From 629b04fe8cfdf6b4fad0ff91a316d4643ccd737d Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 9 Dec 2024 16:58:14 +0000
Subject: [PATCH] tmp

---
 kernel/fork.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 1450b461d196..4d62e776c413 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -639,7 +639,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, 0);

-	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
 		retval = -EINTR;
 		goto fail_uprobe_end;
@@ -783,7 +782,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	else
 		dup_userfaultfd_fail(&uf);
 fail_uprobe_end:
-	uprobe_end_dup_mmap();
 	return retval;

 fail_nomem_anon_vma_fork:
@@ -1692,9 +1690,11 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	if (!mm_init(mm, tsk, mm->user_ns))
 		goto fail_nomem;

+	uprobe_start_dup_mmap();
 	err = dup_mmap(mm, oldmm);
 	if (err)
 		goto free_pt;
+	uprobe_end_dup_mmap();

 	mm->hiwater_rss = get_mm_rss(mm);
 	mm->hiwater_vm = mm->total_vm;
@@ -1709,6 +1709,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 	mm->binfmt = NULL;
 	mm_init_owner(mm, NULL);
 	mmput(mm);
+	uprobe_end_dup_mmap();

 fail_nomem:
 	return NULL;
--
2.47.1

