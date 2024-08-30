Return-Path: <linux-kernel+bounces-308024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7487965628
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496EA1F2487C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E874C16C856;
	Fri, 30 Aug 2024 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hDCVX3HS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lkt5rvEZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569614D711
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990531; cv=fail; b=SYOc3EC0CUvukS6pRxhxJ3glmqoDojGbpqV3e07TD/poe8fIcs+7yOyUupWUmZWWsAFBO3QDGDxWeOV9FuWPjyDQtp5PIS4URVQiCv7/2zNX6FT0M346ETNYyZRCOnefZEziw8n9WYyj1dH1yl3vgC/0xHMPDBpPbrqji8EpHD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990531; c=relaxed/simple;
	bh=wpiLau/DsZ9Sa7lNHjJS5LSIVnN5emAXgQvEShKD42c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9r77kljg18CsEUfSEe0U7U+BGqySilP+yFbgtG8LwuKsFGLoOMqeSjw/Ic7AxihoD6M9XEPGxayqLK7xXZbVefHuQlScgc10WWZ97sxdnIFBqnaD+dWGTxYm60JxivV9LE0ou44F0zwp5d8sIh2HTLFJ/VtKIaRiTSEb6b5HUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hDCVX3HS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lkt5rvEZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2srfF011858;
	Fri, 30 Aug 2024 04:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=MnHfI2QsMe/4zoKN73j2X83vCMvsXwhWZmXTDDHf4XY=; b=
	hDCVX3HSZEkw2nzYnVTH/+6tLKS/q0w939l3eHRnEOdbT+uQs66m0AcO4hFkUI2w
	ktcbYoLvuYazxbn6l/XmMwA0hhRk8RMNHDOCRmjycLWbsY1/H18s5Gl8tsZFrJkc
	CYkz9t2rznh0AAMkv7D8yZvzcJDvX1etJ685vCEOHInzgToe6CyXLOV2ea1dhVBr
	ltV6v2cb2NpMTcQupgC4tTLEgJnpNdb9OeNYFxdR/VCJOqEh8OcsAv10LjV2updC
	y8kSX+JLFsT8i/rt33EfSbtcxXsC5R9gSxdLqVmpaez4cpA0mzhK5ktbWZwT1akm
	xHRME9Ayx88S/nR/xXA+WQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b5q3r1vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U0LvZo036604;
	Fri, 30 Aug 2024 04:01:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2tga-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEgGtfwr9t14+Hk19fb7OeTedQeEisARfIA7fIe8cZmqYnK+cL9v3CiDkCCA43Bl01k1sghcWe1bxIToq9h3JoPxxOikCpzIrt1v3HGN2qjTryM+MczyH40I2q+U4UwBT87ufNgQMS4rPBbnE2V6o5geYtNxesoI5r12nMlU68uWYn96sYAAU7chVaorJ+QPyQ6IXY0NwCl1RD1GhFv7K5HpFalSNaTX3dlml5pMM7A91Z9DHYgTbEMKKUqAS34RFCtspFPxyGPQeA+15L1twYoGSZZ/zjZdfphs18egx2BD5Ic7tUJN6zzhwEAmMOdXkJiffAxY2jOOihMH8IU+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnHfI2QsMe/4zoKN73j2X83vCMvsXwhWZmXTDDHf4XY=;
 b=CSIAqAyX1uiQ60gGzpR/9HfbTHs3QiUhHZg+WYeXARJgnGwcKlahyzAtUGmNIrT65+J0vr//pKzfy9kPzMwmfJWuNBk9nwimi/UbLN/tS9VepfluvNsYIxgYuZ/XvIwxCxV9Sw5Le45Jnpmi+va1Ohj/u7fTmGMDVwg1oRM0culRNlB92kUbrzbRUkgMYlDD3nQRlVLrj2Qagn1bsEhVly3b/yhhhkF6U92wZoA6kZb10O4CbZYZ/71T8B9aXM4AUHBJEVLAqHeKc324SQXt3xIx9TMjg8Ecd1NLg419GoY9ySTA1l0JB0pMcH57vCo257wyl71/alHmh/RBynN4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnHfI2QsMe/4zoKN73j2X83vCMvsXwhWZmXTDDHf4XY=;
 b=lkt5rvEZp24VQXY06uuWC84sb/d8XtXNp82JLBjlW79KSUSF+hzE4HzMJO5/bZ7vbU0+u3U5I2Ky2U0MWijt110yojf1Hv0GYxkrqUeTlyocSNby//RfFzuKnrC3MmRMCtiBTS9q65ozOJp1t98w8YCCRaLfRLM9hhqL8Mwjm+w=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB8115.namprd10.prod.outlook.com (2603:10b6:208:506::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 04:01:52 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:52 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v8 20/21] mm/vma: Drop incorrect comment from vms_gather_munmap_vmas()
Date: Fri, 30 Aug 2024 00:01:00 -0400
Message-ID: <20240830040101.822209-21-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: e560711e-e243-4cc0-376f-08dcc8a87ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M42PXbeARSjtG8LPNhvrnfql/DXiUfC0TfCtdeFyzjCdyZwOzmqTXMPiJ5bv?=
 =?us-ascii?Q?DLcgA7oNSa/y1ET7zhk5dNIq3o2rzrRtTMHHqUIt7pTsUTvH7Tq2UM1G2S2w?=
 =?us-ascii?Q?e34sLTnlI7OxOvUehUSPcrMLP4VI5nd/qXzLu+Bzur6YGpQsOZfMPoHOIQVn?=
 =?us-ascii?Q?PgmN4vS19pZg3nn5W/3BCDrqrmKIaQ/JYcSQDrbn4ynyTI6JLFU1TMBl61tO?=
 =?us-ascii?Q?3weIIMqu24G8IPsKHkMVyw41B/cOxMObb/99KQj/il5VNcpWckiAuLGnTVbb?=
 =?us-ascii?Q?EzAWSFBbrnuo19qhwHLu/z3L4GyRB8s2mdSPsyCgZpQelmGRkoXH9opYaS77?=
 =?us-ascii?Q?nOMZP07yNocExn6QlZ6ST2g+0rfvQL10N+OSS06HYAfwFlLQx45NECXql5c4?=
 =?us-ascii?Q?7AjtmgMo9PW5XyPbwTv/7aOa8jVc7fhuA93AW/njTzWK7JKndyEwxriaZgYM?=
 =?us-ascii?Q?rncM91ELuw48UrIgqDTO49uKz41TqmIOp4VaWZMoIRyqqyomWVHjAf6Tut/1?=
 =?us-ascii?Q?t30MpMl+J/jyZNKrREji/gi8i5OVMOCgkAChR8VFF/ZWBtnXsCsu1msNM8nR?=
 =?us-ascii?Q?EyUXwr1xJAEP8RuC7jirpM3p5zC6JQpgMjXBW5AaocRQQielTSVfYywdSWVy?=
 =?us-ascii?Q?vnaHL4fBSy20DtxDAWIcfLcb0DtjQ/7FOnnZnLO+0+OXmA4FoUCzPS+KvSc0?=
 =?us-ascii?Q?CUBVFjzVB2fxtApYf27mi40WmTUMDoth5BGw7m+wLMvrj41Vthmm6vr1lVYv?=
 =?us-ascii?Q?AUAQN4MCmnQ0tbVELxkrRgPK4Inncl1Z90arwyUtinfUKkjGneYTc6lNElcP?=
 =?us-ascii?Q?H9ECOW33vGw6kvr5kGQyibh/gZgA4dbO3CWmEmda1wg36aYogIc45rBL73BE?=
 =?us-ascii?Q?BbrH5aop2oJzFENe+F8ASU9mpZDfK2CFYcuGQMEKYLPd1k6GJObSgpwGGSLv?=
 =?us-ascii?Q?+jYBevA2r0WegsC1dxTdXkfwG/Z9wQvPFAYyELTCd6KrK/Xu2SzEGk9komvu?=
 =?us-ascii?Q?PGrXvHHAuoXA+gfQmMLtrNR6wJC7PQd7bePiw/Ja0jENpcAp4n11rfL5THx4?=
 =?us-ascii?Q?5N7Ll1EcdEN837giUQRRsBEgUWwcP1e8EKFY6miQ5VYyzS3Jk8BKU2juQDcf?=
 =?us-ascii?Q?FAn/nLP7nwfT0M2F+SFMf9oki1ar5ix7WmPoyJVoYs+b/lQk47QL3NBdQrw0?=
 =?us-ascii?Q?KTOFLYf4B6W8IMY3maWRHgh+qJV6gEOVbab6BmheAHqa3uyX2mkblNSuy7ZS?=
 =?us-ascii?Q?N4qkiChhrpVGi7qWfAe/CfqiT7KpW0rtg0UjhwwJi03u11a+qqhNy8/WVFIH?=
 =?us-ascii?Q?u14H5i7L6D1qVpwQILGHaNUcpjYXSTgi4uWcPR9V0nBFoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X03T0nnf2NK4mZC26S5sZz6RVTfVCvHpduOELOsscZhep7MWwNNQq/gc/3IC?=
 =?us-ascii?Q?8AB2xiu8vu5+Rx6Vf0frXWIumhJ6rOdinwrP3518ewNaLPdvJZz5Wny1zrXr?=
 =?us-ascii?Q?rbHWmaYVuQB0PQMNIoPM+Kr0cEk4dJKF/LFHZpQ1wu3r+xjYzLfSRlLLm7K8?=
 =?us-ascii?Q?8zTpAiktIKx8QysK3LGnsmG9BJLWLlk1zfN4mk6Pi0MBh0cGLiwk28BX3A6H?=
 =?us-ascii?Q?2rBifhK/7NZO81d/nV3Ayi5H6/ByrzBO8knhOOaI6RKwmB+nK9GfLSbQrbmO?=
 =?us-ascii?Q?ESfYG4FLyWWlob0R9QSVT7d94qqUMnaIUOh+oSeJB67kCJMZ9OsgaOiJbBO0?=
 =?us-ascii?Q?63k18H8Tn1GUhhTtX8CoGUkGfq59AHRKc86P9iDkO5LWDyITRTMzB7Wz2B+a?=
 =?us-ascii?Q?Y4yIgxAmQUYSxpJup7hvyj3g4hn7+iWP2qsBXCJA2yp7nqaR4rdF5R3XuzDP?=
 =?us-ascii?Q?mRyqNf0QeY4dfho35z5ouuUDJGqMTTdbtEp9YbmHNKuNoeiuurcw69ctyWnt?=
 =?us-ascii?Q?B2jcVCqXK72emggDb7MnmHXOW6cnCq+5L0cSxAWqJ7y6oYNVuLn69LAHzaPR?=
 =?us-ascii?Q?hYG51UzGv95qYq81mo9a2kbkFlLJDhxu19zq5LyrSncuqMObXBuc3prPrzlC?=
 =?us-ascii?Q?Jklosa+K6a2IcEtQFMhVslK2Ry+PKbYVZi8Rrz9LDnKoK3OlIUD22cFprJIo?=
 =?us-ascii?Q?OTPh0xWMz9i7QmdQfWM/EXPzk2/Fy8XVcwgtuWFIizqVTUwu7rP+hvFWlscH?=
 =?us-ascii?Q?qORHp5nrO6DgbopNsHWuyMJgJTF9I81AGTYvpJIQRHTTdUZdF6w3RrYnAT8p?=
 =?us-ascii?Q?HXpdv6Z/0bSBm7pSXTeiVvJJPO8hzAJpGMuyaDN5qHcItjVUfErMFwdIVtTY?=
 =?us-ascii?Q?FTTPKAG7v0gj3QPNg1dIhTR0flPGWde2VnyF74Mf8OufZq4zPWuq7vDY/3xf?=
 =?us-ascii?Q?jpQzWHEf/laSiQEaQ3GIUuItYEsfHarXSGPIORF5YCOWRUFKShgN9VyUimwN?=
 =?us-ascii?Q?5kz4mgQPaTe8HnS+LjG+plX/A2Mvn3vwhJlV/o2q582StdObLuF1SbiKPoO+?=
 =?us-ascii?Q?B/IT5QsDnppz85iHqRRxSnhUWMxvI/PUD8YVBvSuaDLqyca2FYzFZZs3iB7Z?=
 =?us-ascii?Q?z77kJQe6pLZHJAYiWzqQQh5UGu/qCfQEuIK2U9kd8pY6WxRMFM48kX5P/zF1?=
 =?us-ascii?Q?fGm/RcgOQHLAuMSq4oR1k+c06ZLF8OaZ5gla0z0YkgZ1Su56AwUL/VYAoIsx?=
 =?us-ascii?Q?mgUIcBTGyq+pg1dBc9nH1J1ie2217cjYdGuizfmBVEhhNiL1C9wRqq1ANhTQ?=
 =?us-ascii?Q?G7MKSRbRPT6W9R+w/jMYF1P2KCumhuRwhjXi0jfwJnwsXrzgGyTEeb/0IIbi?=
 =?us-ascii?Q?k4TNQtXbtLKUM1RbSmVQuK5eYubW3H1qgSLSuGx0F7vlczoPAWWnTTQgYYqW?=
 =?us-ascii?Q?kwsb7UbxIIuRB+SqQtAtwWTQ0KeuWbVTfphrLlPeT2lLXVvejllRdAUG6gFQ?=
 =?us-ascii?Q?57rBT1ah3xjppBWBd9h8SeGOnW2WOjvNTHK+56x3b/3XsNkxzA7xs/aorcco?=
 =?us-ascii?Q?Ztwx2Qhb3mUOPKaWxx+iVJ/4HpdVnck1NOqiGxJOmlKauFFzfRWXrInZ9FT5?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nLD+u1RBYX+qkWqtzoz7j6K7zpvfIx8g5/IA9Q50jtIGdlClitc1Fnzc2Jf2c3NsKLi8dO/ejRwAUGRVn6MkyUG7ktb1CM36ofI+sNhp/XChTXoTdIK5dRBcJxCzj/6fNm4XaMq1PNjGFWFegu7MvHqv0/Y6WVI67A9Opg45yIDFbRulWbP1MTRwo6JdrRVHKA8cQ05SaX/lEctXbfQz/nQESHL0zw7kt7F1+grJtXwvk8Rzh/xnfLXqqCTnpSm9wRu5F7CPNG8kusNdaHAtD0GPzclgRlKNSxHxXiqiceqGe2RIR0CoDiYzFoyFaMdz7WLUA6LN3oRj/lvIngJHT4yKBquzXNLGfkMGTw90bA0zTmS0e/8DMNAHZVvS3ulq24jMLRNEbiwdLNqGx5KSwHucHOekPjog5+WQS1xWY3R1WZJKirQyHrDKi0BjBUQkKLjaA5hk4Y6fdFOxbfpyo37/0n9M2UyT7yHldqJsamtVVdxLsbRNlMrKxSTjLVUBJc9cChZe7bKdv12/fOsRaNMWH6A+IoN6vCNBV67R97c12jcPTk6rdCtz18Qfx2rSt6VoeW7ZMivdelet9iPLRd6T70BCF72xtM4RslIL/ZI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e560711e-e243-4cc0-376f-08dcc8a87ac4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:52.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqT/QIWynxN4nIyP0STnZ39DLtV9223Sf8HceKBvUFqApnwnAxGvnlvmumnXFTUWaC3R2wIuLO2p9pH35yV8tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: TLqOEXDFiIXaOHvNKb_8VWoFr3P55gp_
X-Proofpoint-ORIG-GUID: TLqOEXDFiIXaOHvNKb_8VWoFr3P55gp_

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The comment has been outdated since 6b73cff239e52 ("mm: change munmap
splitting order and move_vma()").  The move_vma() was altered to fix the
fragile state of the accounting since then.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 3350fe2088bc..1736bb237b2c 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -755,13 +755,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
-	 *
-	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
-	 * unmapped vm_area_struct will remain in use: so lower split_vma
-	 * places tmp vma above, and higher split_vma places tmp vma below.
+	 * Does it split the first one?
 	 */
-
-	/* Does it split the first one? */
 	if (vms->start > vms->vma->vm_start) {
 
 		/*
-- 
2.43.0


