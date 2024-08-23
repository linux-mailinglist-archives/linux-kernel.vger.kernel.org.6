Return-Path: <linux-kernel+bounces-299596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523DB95D75B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77CE11C21DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A71946BB;
	Fri, 23 Aug 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="msiUYvij";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o2WezEGI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F2193088
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443658; cv=fail; b=MnqUVqoPFW5YAfhmDeigTCQM8sOPCREYXLPX3VaVV52c3G/339xldJCxeO2aZu/jWLUqQ9/5Y93rsw2bi0JDr7tVGkcGMcgYtvgNTt0PuKnLTJlOFLlbE88pIl4fUoycNzclkFd4IpfcwqV1CmQesQnaftqWf5u2uaw6DfsNH0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443658; c=relaxed/simple;
	bh=8I91Hmn2AYqN+TEUS7X8+rh0mgrGu68vKabBkXurU1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NpiQ2hyOGGIoBdRqSbsIildw+QnC6VzBatXREISJyb4M4te3HAkHqQSdOiVdFwfWtb9WxsEwKZUybzuyI15nB+EFde5FkZnEMIfpz1OTTVz7DQDWDATLLUNu8yw02MPyMIPWma45TsaHHcYf4Z+L+co0fKEb19SAboJcNk9ydTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=msiUYvij; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o2WezEGI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0UQB020538;
	Fri, 23 Aug 2024 20:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=N0jU9GfEGn2Y+Rp/ei4IM2Nkf6/N/D+Xhjwf9ZOd8E4=; b=
	msiUYvijmvwxBEbqsY23KDN+YkMw19/zh+r+mmhOSXitG5M2ZBV5JCbn+KEnTWMY
	E4QVvXxYZiNQwMThXm/t5s1ccFif3toZdhJ1W4AQsEDCrtizGlxaWQ878EWX00+H
	vHOFnDIPFasW+OTE8E/v3ByMGjC7cKkchM5zIx7qyU/gfkDGnpTU1fHESY1lZyI4
	MFSttF9VfjyCtw556UwoPMlXGIzwFPCxAoIrZBXeA0AgIN96AzMWeJSVxpM6Ka7n
	2P7a6nkq9xM2zh0RinJ2naPSuC/at8smDUWrmtl38USj9TUFhHUKVWtxQvZiONer
	RwrR/VvdSRlhTsi4agUJoQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdt56b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdFFg007123;
	Fri, 23 Aug 2024 20:07:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4170s610wk-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUfaGgJbuRgvjzWLgHXct3EPZepjBaFud6WSHjBjDgXUXBfVk84uo5zwfSGwNvx7cX7Hl1Y7gR+m8uJtIOVyGUqRihF8qAfaCr6TCwQ53FffadoJDRaw+4pCfjdcd0f4rzGS2TxCnZwKf4MyaKxODcVBshsWsy8dDUKGBiu3fVQPf88sS7+w1tcWMwhk+JS9P1MH1tA4FmlQ+CdQ/A6uow9stRESjd6x3KE4SJmg3Vcz5Uk2bWzYAIY4665AZOsadBQS++Ilt9tQk4d3aIMiIiO68EHlSLpr5oBz06Z9v8Cg3v620JQ3BTj8swgiUa2v6AtURDvJYZjR0yjSueujoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0jU9GfEGn2Y+Rp/ei4IM2Nkf6/N/D+Xhjwf9ZOd8E4=;
 b=m9xYN30+WNW7GeB4JBwAN+OuHvT2FGwe2sxdTpuZbIhEjI2p5RM/2aDKNbNxUkZBR+b73el9TXt0Sfmvwgtu/WWyZkbHEes/FVPkRj/NYWuYvdzLcAt0XDUJf2VbhFyUbo6REwww6NNmNfnx/6R3QoYmdvV7p17Y2sq9pKdPq/Qb5PZOiONLZng0ROZQl4m6K0MtEkx8CiJA0UhVPM0nrvGoBWtEFaB1JHimbjyeG1ECBeFF8T6G9uIQbfv3NCmOijNTJbMcJKNqffwBh8n12r8Domk8+mTRDE45CrE77vyIeu+ixdIFW/svXA3uhz0jiXsX394lg3hd5/SkjtMTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0jU9GfEGn2Y+Rp/ei4IM2Nkf6/N/D+Xhjwf9ZOd8E4=;
 b=o2WezEGIZhG6NYQOryPd59WXZ8APzpldVR/cxdqwQXWqQHQ+yIypl+cSB7B/be7rqf3VqY3XO6siXtFm9+Otc+HFi001onDmsryRU1y+QGIf4Ctw7wUwIK5GD7uFmurqhhJfYkHwJdXarDCXd2QRiMEfJfRvh4vqUG0v2G1fFNA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 20:07:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 05/10] mm: abstract vma_expand() to use vma_merge_struct
Date: Fri, 23 Aug 2024 21:07:00 +0100
Message-ID: <0cc0e4d1af6722b3b0d121647089659bd8060087.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0288.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 1205a18f-9ab9-43f4-7270-08dcc3af3332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?is8c1VreVyKWLkbi2zdH4H3JVbrUx3DiOA6DaziGkRHsTwRL7D0EXygLeJ+B?=
 =?us-ascii?Q?u7GitrYHjwgoXQ8adgjiVGrjRCkVGhKYdOT7MtbQvZf88yPOQHzSkPvxtTkL?=
 =?us-ascii?Q?OPFj/xPDVQ46pXI09wJU5HBWPWPUICIRsDNJTrjGWoyUagQX7zei0O4GM6kD?=
 =?us-ascii?Q?WwhkHFwOo+sBlUXHgKx32S5mDQTEw1P1g3rDKUKmpUKAOMY80dWNIJUOX1J7?=
 =?us-ascii?Q?7GML1pWOBjfxoExxK11MxkczRG53ZuNmC9NsvK3QSgcF1ZyaqQFu1IjUTmft?=
 =?us-ascii?Q?oRgzu1ECKtLqJP4pJ1yqM/CdQrfsyPWaKuQwJBYEZNqdhowqbjGgzftwOCIZ?=
 =?us-ascii?Q?icpRjqnBnHekwlKry8t92s/Q4766gttr5hYOYJm8Yl89Son6RUmVosZTTMcF?=
 =?us-ascii?Q?TdAXoOAWUeP3p/OTwXjczodH/A5hqQKmN6M+1SxyFPGdWM9/EWJZeR5E1Vnx?=
 =?us-ascii?Q?/qpGmrq+xG0eA5gPPPihQbebG3ED66R7ia0k11ebOmTlT2pvqL2LVIMR7g0S?=
 =?us-ascii?Q?+dUNaFUXNn6cH3uVJEHpSoOw6F5Bc7HT8/wNhyuPG+ENrYv59nPLGN8sVuqm?=
 =?us-ascii?Q?b1MHTl/ArabBra3Av4jzs+aGr2msZt8vZJPySeZaad22zreuZftK5J5DUygX?=
 =?us-ascii?Q?2BnPpiqE6i6NrVUQnov8JnbhkIaqifJlqXvBYMzPlWhtiMucXMC4XJuuRP6C?=
 =?us-ascii?Q?le4eFeSjOy+EI8h6gziCDQcCs5dRiPQ/Ov+/ado6YBD/rw/fJFO4lKZoyrte?=
 =?us-ascii?Q?c9kniN+8xbG6fIl/ObUBXIr5UjioUwpaMYarnTk2ZgSP7+fRbhDOlIyac6sw?=
 =?us-ascii?Q?cPVCyZCTiRQ+TLTntgH33fsApFrlMwTmIX444XJkLT/r3MoQxeV+L49Oi5vJ?=
 =?us-ascii?Q?DqM85xgmyGmHEyWVNifbTeUNYrTLY7HoLTkWuOSXnVr43rQsQg36AQqfjxf/?=
 =?us-ascii?Q?u8j8j3c8BcZ9dPR8VJYVSxgWNwxvOc55wiTnJWrQVmy9aDAlrC/E2TQPWs0F?=
 =?us-ascii?Q?HQ1EzzpDi2assPR3YBGJP5LjT/d4C7mevK2PiSoCe/gvF5EQLYmpEmuyIx08?=
 =?us-ascii?Q?t3sawIqz3Wwf7dP7Qm0l5TAtOmTY00bliUCIevh+zzLMYldLpyMQppoSULVv?=
 =?us-ascii?Q?c2+7DJEc5hzOsj4WeyYFJVWqWCA4sThZ88EDpEbcSWLwMgZ5u/6wZ0zIMUOH?=
 =?us-ascii?Q?E0frPBmfJL0k0m/jXu8Na+j3n5J5sE/tIQdyDc4nrD1G9AkEx7zSTfD4xRTz?=
 =?us-ascii?Q?hTsW+SdkQiCE1/Aa7dn8fWW1mXE916zp2Qat9heEdHKA9DVj+U/zkukWlxsm?=
 =?us-ascii?Q?d3Mtyw+uJOr++VPD3s7i+l/aBY8ldI/EZyPICwyS1tgR2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AAhlbtvxUFVpTsVZL8G/77ih/MwQDS0aj1dmkSvDImNcDbBhozlL2iBKtERb?=
 =?us-ascii?Q?Q3XapPCdm+jAR+uKoEOl46BJdgApYj4vMWKBVuzQwNBPPt7KJoCZo4jj5c14?=
 =?us-ascii?Q?4sjhIIuL/rAVB4hFYjGaYbob1DXnVBDbyT49M0nGiGmYGCMz0LNYg5JzKCxP?=
 =?us-ascii?Q?ZJaDO0Ff6EmR1+4r70uVUSKHEmzsA+OZdaJuLGwPYxBXQC+UHnAGRaQtcAHz?=
 =?us-ascii?Q?SdHSSzrflJrsj6KdW+kM0Qz/M1FFcUwOAbaM02NytBUd8LGH8bClaWCFPI/X?=
 =?us-ascii?Q?Abb0gRWMyHER0Cj32ANswxN4LGC4ohJPMYddHtRANNzSSqMU2MyAYEHyBHDX?=
 =?us-ascii?Q?5D5IJRkDDh+EfboXUqR0y+E3jiJDwhLZUyJNkQLnIpyQqcp7A0wrZKQZZfPO?=
 =?us-ascii?Q?J4sf9MJsFlmIQiPV5A5o/+05y6drrDQ2W5qVLz0kGJSK3MQlViIiHjSmSssu?=
 =?us-ascii?Q?u13JU0NVUp8U+yKI6YhRYDtGxNLS7DwQo27BuQ9YtOKKxfOPBjbJ+O01rGUt?=
 =?us-ascii?Q?6eVQKE943veMIiQ2e8Ky+Hv5Zr5pQXSADreaNkaDMjmdltySzUgLiBp52MKR?=
 =?us-ascii?Q?eYMkQQB4RK8BfdA0RwBBD4zMjkQhPpf9M24Fk2wchlHaNR6r7jwryLjcpzj5?=
 =?us-ascii?Q?JOMDgEK8xncuLhoUlT11XCXKQECtKjkAL9MK5rXBvjzLrG4cXjcHz+OSxpQ1?=
 =?us-ascii?Q?9Uyc/iLG+S/eN5lObk6LIqlrh5IpDd7OdGnn3+Qzwm9sZSiy1AaLDprGlttK?=
 =?us-ascii?Q?SbmOa3F9NcT2e8fVbo/xc8wDTIIpvBZ3530rPJ4aXZN/c75t5IBhzUMODKss?=
 =?us-ascii?Q?js0cNbYQ9RFBcDWeahpebxJnGFJJG14xI1+kvBVEq54hXcMz89RgytVgfqdK?=
 =?us-ascii?Q?KqD2nuGiE2JA42GZ1PyKApzTlT1v0lj9gTrv3QyWAtNL03DECLhsPgmKsF7c?=
 =?us-ascii?Q?VZ1L4Ri+sYYyJ05SfX0SgIctIcQWL7VzmZ/oIqByTXwNU+tZiYOkhhTbMR06?=
 =?us-ascii?Q?CcTLwhXt6/9QjlSJuDiUru7yUa9kCmgaRwvlvqKXSPEWRLo4LGqsspbL7WHA?=
 =?us-ascii?Q?30j2S4DU/dzpaxsnR8YEGKNDIx5FPC5irpFDAJgzKnl3n1BmbHNgD3tJ41qx?=
 =?us-ascii?Q?CXkfwqy+U6hrcsPNklfN1MFP6kfP9ceD50NuG6QAhc+Vw30DRv+9tAQWicT6?=
 =?us-ascii?Q?ZI5kpXscIEIs/f8Ih62HHziUHwk71mv+5kKCqnEjuM5KgoYhfRfUzyvuILIc?=
 =?us-ascii?Q?aQuiOfWlhvFNeQhONsLwVnGw4A/9v84j/I1+kBjXw9aAaqREDOu0npZ699Di?=
 =?us-ascii?Q?073cJMSCOweoTbqR01u4ADjuBM77gn3RSyv0IK873T/frqVHHu/X+deN/drf?=
 =?us-ascii?Q?El1jPkIgLyBZO/9QY61MfIWwDHEdp17Pfhlm9bK6pmVvDirJW+AEl79Oa+Oz?=
 =?us-ascii?Q?rGtv/n9T1sa5KtfzTAheoDMkKAnmx9AyVM2hBS29igr8k2goyxOQXX8R4NcT?=
 =?us-ascii?Q?yL4ymLix3+La1WUYBSyt/zj5j38Iz9SHACIMW/OMBthl3u9mh8RxD0cqntwl?=
 =?us-ascii?Q?I8UASVY2FZHsrsnpHweWZ3kU8SLBTSVYGhuM3hyCfbP8Hly5JhOkNA3P6mbZ?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qgcQZuY2npfNL+u+pw8x/y6cYuhaDYXLvQvMrnuJZKJKs8iGjvkr56IwIDiH2Dt1EL443//DFRdiqMSwnpf3/Sm2g5Wl9yE3s69FoKpOqfx3cKB2dwSgLS+QjcHNeG+bDDcvDGiGd+6Ju25HerN8d8dhtF6nD+g1GoAqyo7yMwkSzUTB5z5NVIFo1vJ3eQWTSNnk+WcNC5CvTGzUw88gOPPRzQviV1gcnqa6yAIFSKIf6V62j+OD4GxbXbnne1zMrfe0X0hR1gUCw9PqEqC9MPXBv96vcxUxsMvs2STH09knbRk8pkADhkVy5UJqEA3GCzBNOq1BXuJNTZ4jlMS5JqIUNOXJ/1WcCv5xZofG20VP3bvY/MCOG255t6lZ5gr/GY3wbHUhjcPtn6O1o2bkDTwQOK6rvrT4TXNShDjCw4WjYBQH0j0r9XuW7pvBWs//QiXnPTkvLxgGoPE10mRr2FbG2ZmW8TaKquAQpgIkOkXEFzsXAPVBEypMnBOa/nelhoOlq5vC/zjwhwUrkiWJ8ie6Anee1gezKNpQrGRm7imPzZsqbFxYOl9o5/UF4B+FwYLLSha4lRqkSEbglOvBBESM7moCzYmeKhvoGBhBVxQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1205a18f-9ab9-43f4-7270-08dcc3af3332
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:22.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xn6coRJbqU7E5gku93I2udU+HyjHtnG2s7e0GFHcC2zTPO39GpxhDXfIUmRDDecQCBcTG0UKi6qT8AvBV1yEmHzD4Pa4P02GeYSw8qSr8gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-ORIG-GUID: Oy603X3y8QiBTD0ccsaNoNTODcPmRYde
X-Proofpoint-GUID: Oy603X3y8QiBTD0ccsaNoNTODcPmRYde

The purpose of the vmg is to thread merge state through functions and avoid
egregious parameter lists. We expand this to vma_expand(), which is used
for a number of merge cases.

Accordingly, adjust its callers, mmap_region() and relocate_vma_down(), to
use a vmg.

An added purpose of this change is the ability in a future commit to
perform all new VMA range merging using vma_expand().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c               | 16 +++++++++-------
 mm/vma.c                | 39 +++++++++++++++++----------------------
 mm/vma.h                |  5 +----
 tools/testing/vma/vma.c |  3 +--
 4 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c72f50feb98a..0d242c9b1f4c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1371,7 +1371,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct ma_state mas_detach;
 	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
-	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
@@ -1424,8 +1423,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Attempt to expand an old mapping */
 	/* Check next */
 	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
-		merge_end = next->vm_end;
-		vma = next;
+		vmg.end = next->vm_end;
+		vma = vmg.vma = next;
 		vmg.pgoff = next->vm_pgoff - pglen;
 		/*
 		 * We set this here so if we will merge with the previous VMA in
@@ -1438,15 +1437,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Check prev */
 	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
-		merge_start = prev->vm_start;
-		vma = prev;
+		vmg.start = prev->vm_start;
+		vma = vmg.vma = prev;
 		vmg.pgoff = prev->vm_pgoff;
 		vma_prev(&vmi); /* Equivalent to going to the previous range */
 	}
 
 	if (vma) {
 		/* Actually expand, if possible */
-		if (!vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
+		if (!vma_expand(&vmg)) {
 			khugepaged_enter_vma(vma, vm_flags);
 			goto expanded;
 		}
@@ -2319,6 +2318,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	unsigned long new_start = old_start - shift;
 	unsigned long new_end = old_end - shift;
 	VMA_ITERATOR(vmi, mm, new_start);
+	VMG_STATE(vmg, mm, &vmi, new_start, old_end, 0, vma->vm_pgoff);
 	struct vm_area_struct *next;
 	struct mmu_gather tlb;
 
@@ -2335,7 +2335,8 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+	vmg.vma = vma;
+	if (vma_expand(&vmg))
 		return -ENOMEM;
 
 	/*
@@ -2368,6 +2369,7 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	tlb_finish_mmu(&tlb);
 
 	vma_prev(&vmi);
+
 	/* Shrink the vma to just the new range */
 	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
diff --git a/mm/vma.c b/mm/vma.c
index b1ec412fac7f..4867ae722a9a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -467,30 +467,25 @@ void validate_mm(struct mm_struct *mm)
 /*
  * vma_expand - Expand an existing VMA
  *
- * @vmi: The vma iterator
- * @vma: The vma to expand
- * @start: The start of the vma
- * @end: The exclusive end of the vma
- * @pgoff: The page offset of vma
- * @next: The current of next vma.
+ * @vmg: Describes a VMA expansion operation.
  *
- * Expand @vma to @start and @end.  Can expand off the start and end.  Will
- * expand over @next if it's different from @vma and @end == @next->vm_end.
- * Checking if the @vma can expand and merge with @next needs to be handled by
- * the caller.
+ * Expand @vma to vmg->start and vmg->end.  Can expand off the start and end.
+ * Will expand over vmg->next if it's different from vmg->vma and vmg->end ==
+ * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
+ * vmg->next needs to be handled by the caller.
  *
  * Returns: 0 on success
  */
-int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff,
-	       struct vm_area_struct *next)
+int vma_expand(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *anon_dup = NULL;
 	bool remove_next = false;
+	struct vm_area_struct *vma = vmg->vma;
+	struct vm_area_struct *next = vmg->next;
 	struct vma_prepare vp;
 
 	vma_start_write(vma);
-	if (next && (vma != next) && (end == next->vm_end)) {
+	if (next && (vma != next) && (vmg->end == next->vm_end)) {
 		int ret;
 
 		remove_next = true;
@@ -503,21 +498,21 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
 	/* Not merging but overwriting any part of next is not handled. */
 	VM_WARN_ON(next && !vp.remove &&
-		  next != vma && end > next->vm_start);
+		  next != vma && vmg->end > next->vm_start);
 	/* Only handles expanding */
-	VM_WARN_ON(vma->vm_start < start || vma->vm_end > end);
+	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
 
 	/* Note: vma iterator must be pointing to 'start' */
-	vma_iter_config(vmi, start, end);
-	if (vma_iter_prealloc(vmi, vma))
+	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
+	if (vma_iter_prealloc(vmg->vmi, vma))
 		goto nomem;
 
 	vma_prepare(&vp);
-	vma_adjust_trans_huge(vma, start, end, 0);
-	vma_set_range(vma, start, end, pgoff);
-	vma_iter_store(vmi, vma);
+	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
+	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
+	vma_iter_store(vmg->vmi, vma);
 
-	vma_complete(&vp, vmi, vma->vm_mm);
+	vma_complete(&vp, vmg->vmi, vma->vm_mm);
 	return 0;
 
 nomem:
diff --git a/mm/vma.h b/mm/vma.h
index 9060a1a1edfa..8f01fbc20fe7 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -128,10 +128,7 @@ void init_vma_prep(struct vma_prepare *vp,
 void vma_complete(struct vma_prepare *vp,
 		  struct vma_iterator *vmi, struct mm_struct *mm);
 
-int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-	       unsigned long start, unsigned long end, pgoff_t pgoff,
-	       struct vm_area_struct *next);
-
+int vma_expand(struct vma_merge_struct *vmg);
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
 
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index b12f72979478..cce1ba78c57f 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -121,8 +121,7 @@ static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
  */
 static int expand_existing(struct vma_merge_struct *vmg)
 {
-	return vma_expand(vmg->vmi, vmg->vma, vmg->start, vmg->end, vmg->pgoff,
-			  vmg->next);
+	return vma_expand(vmg);
 }
 
 /*
-- 
2.46.0


