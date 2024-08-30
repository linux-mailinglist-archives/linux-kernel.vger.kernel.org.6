Return-Path: <linux-kernel+bounces-308017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023F4965621
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35F9CB223C1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC8158A37;
	Fri, 30 Aug 2024 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n7UQWtP0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O2iwDVOW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42815855F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990513; cv=fail; b=sICqHIo/aD0Zo6eEwYnr8B2Ew28Nl5skY+jFXOWI6341ykOxSyikWGSu4GBgOI9y4q7WHg2SXDZr5VcOU3TCPcX+H9/DXGjo0pl+wKIWUNmreBgrUv9QpMjC2yFdc07qtMdxdsWN9rEUS6tFjWlRqiU/QJUShYTtcB/TFnyxD3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990513; c=relaxed/simple;
	bh=xnMkA6bC1RzKgJhOaXWzTxskMoA1/9x8jk+ccsJ5cIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EK5VcMSYCJEmvGhfcTQTZxpF35nsLdfXDruEDlgHnvk4FBl95c9TDlJSGZXw5EI8Re5lA95lvyA1XL1mk2L/u/PdOl9+NNUsSYtd6l91Otfivti8p8DV7TEUfrG7Dvm1CmuTmZG7sfSXdgxDxmWWiWDn/zkbDNqG2OldTEQSHMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n7UQWtP0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O2iwDVOW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3MisG024297;
	Fri, 30 Aug 2024 04:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1UDjaqCUY5CJt3NaoL1p2VlJ7dG2+K7tNGwtmFfkaek=; b=
	n7UQWtP0I71xATwhhSCJkDUKitw1JWUt8jsC1h2P+z5xi0KL5vIdBkov210zmi4V
	Ix+vIRU9ETRlvuYcGauZn8jSIZ5tx3LtD4OAEmKthK60x+s0FNKRkKGFRVL7sr1I
	jxAzOIy/LpjiWWXjX6GrlRzlXVNSGR3Hg/lhxLq32lR7Eiz0nmjKU4QBt+UdkfhQ
	Qb1scn9ZAr6tmoj0JA97V9Tww2M8STAv2mdZJh1pIStNSVzFP/HDuITYyFdVpaky
	W5eQ7oIIcRx1DNrnRSwgqVZwnKvQcivMZ4h/+pec2mFs893zobY39RDmVvlI6BVd
	1rw9yBI7phQpuziYj26KlQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b3myr58d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U1G4jc036539;
	Fri, 30 Aug 2024 04:01:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2t6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umB38vR58aHAHJAg/qM/CB9odk3xpE278u8qHB+8qrp74BibzOcwYMmk6MtAnv2UfClu7yW+7ssT9nkaX2g7HLzC7LHCd9iSahB2REP3yfeaBRVaGESuqd+VtMHCkTZyGuPCUmAX0PPhlrYnDgRVkBhcWNgjKR+LvYGlxLGUZxZ/OhdNPThy/8NdODCKqjt9VOmnv2utVwFXonJORybgQheTiC9bblbuhvvb87Q9CcdF74mGohaYlStsa3dSIhReuvsR+qwJi5qmbLLuRbSyT4yg+si2s2LPC+S/hmEfmhadNEnDQc/h/l5MWEuykTl5+WII/EhTEwvETbE8J2vbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UDjaqCUY5CJt3NaoL1p2VlJ7dG2+K7tNGwtmFfkaek=;
 b=MyfB7Ajvq4+dpY+RSBGnujVoldLr9tgQpjZVJI+ok5FnTIv4wmEnaOmVW1yMwru9TfhlyiSzEimv+C8gOvrMrYfj71XM+qVVc8KtUEZ90tdP16uzjR5o9zB56DnZX0NfqkZGaIrBZdQZ/eMM9voLZe9q1JuzwccR6vBuwUAQYMddhi+kP+szceaEdlGoZafXABa7/YGtmRlmqwSH2hbieaBfyV5qaPdHjgBxtnEfy5Ht4KAkEEUy7q8hnFFxTi4jffsovftZ8eYCaWQOkg1xHBurpNeGc3CXJ1aFHlHNxLJgnDIsW2XZ4MD+FSZe1YNpdH7l/8wBIxJWksu9KBhjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UDjaqCUY5CJt3NaoL1p2VlJ7dG2+K7tNGwtmFfkaek=;
 b=O2iwDVOWWhC+7UlxKT8GmhbduF7fDfAcYCgLZl3SEUDDuZdl/vU/I9xapNN+6YKQZOdMdeyjXju18QhktbqZxCWvtvoK78B23mXOHm91BjnCm5/XfeMT1Mc8sp93AaI37FUrAZCRJJ45q1sigvEe98I9L10DiVn54IASzxtWJz8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:34 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:34 +0000
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
Subject: [PATCH v8 12/21] mm/vma: Track start and end for munmap in vma_munmap_struct
Date: Fri, 30 Aug 2024 00:00:52 -0400
Message-ID: <20240830040101.822209-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: eeaa53b6-d7a6-4426-03c7-08dcc8a87022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s5+CusT+Ug+CqIQLM9+Nl9iO0TKO6TP3iMpLroUwfX/lemZMQeG4l+oNLxyP?=
 =?us-ascii?Q?jgokWXgQbfwBEi4zLE7/iPPEIGoPkNwksrDgCqDQ4bFMj7BkwSkF3oQaZW5F?=
 =?us-ascii?Q?dTrp+7JDruQ4Rbfqb//OwIXFOssbhCvgGEt6mpxgcop+EsWv7gslozL2r8Qh?=
 =?us-ascii?Q?vi0R3S15ItfvhMNivijmOHclzVr9CbOW4KE9dUnvosZZDAThC9tMMHjzVIub?=
 =?us-ascii?Q?8ttWcQzq31I1wJMnu0E9fV6FFXDmU6yw9U1wror/9SA1CAasTEuHJkb/BvaE?=
 =?us-ascii?Q?CjAuVK+2OW/f9O9WPWbe2ee2cmmg1pXqGBF4ebf4XJ3k9WFfd9MQ3pwB0Qqp?=
 =?us-ascii?Q?Kmj3rRFm/Y4rEJxrBYGJy8et7an7IsrXJGQOMJxk2Y+d1IWRBzBGcf6WQndj?=
 =?us-ascii?Q?7kOFKm7HRbtVGm7CVpbc1q7xIs3laAt5KtW/a2DYQx9LbixvEZ/1u7jjfWbB?=
 =?us-ascii?Q?sk3Skc/cUmHqZYxfxL6vj25fX2TLur9kaJ/A5BFrRFuHVjpFI3ZjEJyke55t?=
 =?us-ascii?Q?mWdVyfULsjIk9rixPFylKiq7+hrJupwOXXcZ+twALkmGEFBJ7/CVSizvnFcm?=
 =?us-ascii?Q?YnfwF9PDM34Bs9rYymAQC2WmYQskos/WAgqdbh+tB47FVYwFBNw+wJ2Kb3WP?=
 =?us-ascii?Q?GqtWG2THxdpKGoHpIjuQZ1SHBslYDpt3bS44uI5RKTq5/S5EAi41p78N6Xcv?=
 =?us-ascii?Q?HNEtdv2XmS4S5pDt9NRTOnrndzRHmJPBJPO8K3bujuA1Xp0NzNJsdeKzNS5D?=
 =?us-ascii?Q?3dHNX2P7ep1xiMMTIVgHwhViHY4LdTcMPSxuzMUPg05e18ZsRXQBNM459fJQ?=
 =?us-ascii?Q?KiLv+KtkV+EkvsFCjcbuVX/rZHHvGpzELESmFdD9jOqYXWARB/tTtgxgSpbj?=
 =?us-ascii?Q?IP7ni8szPgLcSm0cCnflNMA3/FUJXzS5VHUnNq2xPTuIfTLzVSKNixCKkWlR?=
 =?us-ascii?Q?JxuP0BkTCvVsDyCmBuVuPHwxdpqkpkpfqxW0KgOU3TIMY4OR7L1mIEa/TXGO?=
 =?us-ascii?Q?5FKs8CeH0peaZGGGdiYhVSHSttvA2k4jRuhX9wNS3iNOWxMZ0VAC1YY8myWv?=
 =?us-ascii?Q?/BzpwgiHUvtTxo7sfHO5RJLHyUrtGlzbYPdtfzfeeu6ysxj5RkfhpPdQH3O9?=
 =?us-ascii?Q?p669953H4OpAmcJIfVjHW5CshxpkIxDIvCzaltDnWQEs/0swJkEe4CLtG5M8?=
 =?us-ascii?Q?ehF/CTQScX7tVOPw11aSCeZLgiHrEMG6+YjcD5fFoZhf5BXi93WRHIvug/rC?=
 =?us-ascii?Q?QETdTn7EfnX8AEG3ZzpE0/gAp56gQRluwTye1ACwA/Ef0xNca+Z3zkOtt52H?=
 =?us-ascii?Q?7VDjL8akZVeWPfdrwsj3nUUn3fLefhRsUSGyqH5Htm7r3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S3Q56uW159YVy3z4I2ZNeBZkitq9m3gsCsk2cyy6qtNxmllIyREhueQT2/Rq?=
 =?us-ascii?Q?vO5QygLtbNbI79YowGm/1cRd7OQY4xv6zROTjV04DXxxw9UmvzHz5Ehrc8DF?=
 =?us-ascii?Q?/WZUceOYXaTpZtlYrlllg11jEFYEtCrx9UxFQ9h8+3MQXfSHPhDk5uTtcEbc?=
 =?us-ascii?Q?L+QcKbCuPkDu4ot9oitJJRbToP7sY5vAOJVhk5G35OztJyH4OFR6BiHmcOFZ?=
 =?us-ascii?Q?sSqdz8zWMxDZCjpvh+Mdp8I4j2GtJ+f1zkWN4nf55UJwnxWrfFPnMfaCjGmv?=
 =?us-ascii?Q?rxzjzJfDKQ2HhEkIQulBs5pVzPQwJ4/jQsCo76/cWB995C73JyMVsUuE7CTh?=
 =?us-ascii?Q?ZT7qc5UyuPmkNUOCdn0CWhYyzI4ku1aHZKEbeSnBiNlN5olhQhdq3cBlZT2A?=
 =?us-ascii?Q?neiuL5O24t91eyesl/KYo5psFFqJ2tVzLY3vGwKXWms+L+aLbtBg9AfgdqMH?=
 =?us-ascii?Q?qOVr1pZA2HbBmnrTXpaRpPqGaf0VSpg3cGso7slVDXW8ftqSxUNODCnqlUTF?=
 =?us-ascii?Q?/DUBcwaF+JnuMPrQSLYmb/HiLgwNy5dNSvhizLROZA+hDTJjuxhZUZCovhSk?=
 =?us-ascii?Q?qaodNXjn3BmX5WhfbYM3saz6N5HlCRaTKmedeMDFAe41a7x3kGXInZ3L/YS0?=
 =?us-ascii?Q?cbxtffG/fz5fgIj/S1/PVyyBzrCo/LxK9Z+t+h5nG/kK6WjjdfGzZmZs+LST?=
 =?us-ascii?Q?eSCaXibqAWZVPD8q4qQuLjqHNtbv/BUoYZ8mKRGQP9mCnNAK7KkWeB9KfG2E?=
 =?us-ascii?Q?VyY4DSJYuwP0UZkfnLXkExodS1MIZJzQV0sqQQZnHFKOzVW+9AiM7ahjMJGw?=
 =?us-ascii?Q?EgVhtB0YKFgUi+wyGoMBWXZTNVnVXiTuuQGbUSdI+Ho3KJC3d0grToVIXBa3?=
 =?us-ascii?Q?UhP30Cei3d0RUOKrjirApmpnMHeXvwmAkOJ/qBGw5B4+UwhpCHZHcLCdQAar?=
 =?us-ascii?Q?UTYihNEnh9y14FUuSD6Pr/yUbRhJZ1hmW3bK7RA/xiw4duSBEqrdiM0ekoJR?=
 =?us-ascii?Q?yyUcMHC+CcCttUzsbYjK1+TFlTU8n6Ng2OFUCZDFrIII3vezz4acyELcgpbJ?=
 =?us-ascii?Q?l2EK+hn1axWnfbP/ono+kB3q5RuxFnxFBTfXXDtHl1nMRV+faZoWeEe2oIvg?=
 =?us-ascii?Q?WeaF/l7SUGxqpng07Qmx5IYzrdkdNLdmTNicB+lqvC1YT5kKzLoXLhe/+UZ4?=
 =?us-ascii?Q?+L9SWglIemCVYq0hykrRDAlS/qyQl7LebxyR3p8qmIqyvIgiw4lHewSpy4iT?=
 =?us-ascii?Q?nrDNxl1o107KwJdhMjzB7ezpX2hCXsFk3rjyy2QW+82270lDBAjCZOo/z8QU?=
 =?us-ascii?Q?tyGTa2v88t9zTK7qxkV21VWdaQ+qeor6tjYEsRpOXVl9S+rpVCSKG7xrxZS/?=
 =?us-ascii?Q?3F6OXsXLluWGYre/7LQzCtnA/j0ZxczlqiZIcg5DNQ1GRv9MsjrUJjMWfGz+?=
 =?us-ascii?Q?Oyp5DKJ2i1p2pfO4RuN1Fmp4oTLU2j4ITfbQV8koH1Ar7KWtF/bU8mZzU0eN?=
 =?us-ascii?Q?UDnEZet1jAk/ZIfER95jNbxYdjARRBXd49dIaSn8bHhsCwOuWyhHic1Dao8U?=
 =?us-ascii?Q?V3bQThFZ4RUHT+NNdM2+ox2E7VPndczj5a9v5QPktm72rVf0x3pSJwffTwL5?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DrZGeCunhnhojLLZ6c6CPv1dqEWAY1L5lFZBCkLDQQpiN3AqVbETa+lVb5VIZ4fwLwD35GCEc20VETk0zqaWDjEQP5jfCKrJye8NBaCj9PSL4l5fUi/mECOayO06Ghc+E89xMdKlaMBtFLWHJrlnFp8t35+po5L+3vRCDHfmgsYnUkVfBfmRX1uJluqDx7pJcVIcujgzFcUROCUMzqhyMUd+83EJRYXFpJgdItmd8vtMQdYuOpShBPRzyrjdCnZ4/nLtwPBO3nRB7/YVy2qaHbylVovhI+aszBMVgnyx0+mIZ1pZyXQm218YLpHKUq3xvNPyAO6EmYcztDLKg84nWqnHyBglDZ9UL9foIJ8hpp8UwUi2r/O0EIaDZEuyeU6cF0qqDPz/pzuoJJqsScb/a1CHtFhlt0byS+Irb5wpMpNmaqv3aNs28NG39GYQa/GhjGH1FrstivmAwHxoJ/FcxKRNHuyruFxCbzNZ9ti/V2F7/tgnQzU0DfUrMfPH9++dG3kuig1ecpVYdagqcFE9AIiyWs45DK4vK0fVygTpI6WxzLUfGwXgW4ka6RLyOq+Zn6sGwD8uG3bbzgwF34WAxbF83pIAbyNosceMLWeRWtE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeaa53b6-d7a6-4426-03c7-08dcc8a87022
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:34.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eM6+xp4JHq0pjzF+7V2O4My71/JPIH/sSrIfEGV8XnhreOQrYIkbLxGPScLUbUYmzSZSuIx768B9IUIHT+9rzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: gPE7UbEfr89SN2-XGAYnktLd8lFfNf_I
X-Proofpoint-ORIG-GUID: gPE7UbEfr89SN2-XGAYnktLd8lFfNf_I

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Set the start and end address for munmap when the prev and next are
gathered.  This is needed to avoid incorrect addresses being used during
the vms_complete_munmap_vmas() function if the prev/next vma are
expanded.

Add a new helper vms_complete_pte_clear(), which is needed later and
will avoid growing the argument list to unmap_region() beyond the 9 it
already has.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 32 +++++++++++++++++++++++++-------
 mm/vma.h |  6 ++++++
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 5e0ed5d63877..c71dda026191 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -646,6 +646,26 @@ void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
+static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked)
+{
+	struct mmu_gather tlb;
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, vms->mm);
+	update_hiwater_rss(vms->mm);
+	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
+	mas_set(mas_detach, 1);
+	/* start and end may be different if there is no prev or next vma. */
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
+	tlb_finish_mmu(&tlb);
+}
+
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
@@ -667,13 +687,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
-		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -745,6 +759,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 	}
 	vms->prev = vma_prev(vms->vmi);
+	if (vms->prev)
+		vms->unmap_start = vms->prev->vm_end;
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
@@ -805,6 +821,8 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 
 	vms->next = vma_next(vms->vmi);
+	if (vms->next)
+		vms->unmap_end = vms->next->vm_start;
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
diff --git a/mm/vma.h b/mm/vma.h
index c85fc7c888a8..8afaa661224d 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -38,6 +38,8 @@ struct vma_munmap_struct {
 	struct list_head *uf;           /* Userfaultfd list_head */
 	unsigned long start;            /* Aligned start addr (inclusive) */
 	unsigned long end;              /* Aligned end addr (exclusive) */
+	unsigned long unmap_start;      /* Unmap PTE start */
+	unsigned long unmap_end;        /* Unmap PTE end */
 	int vma_count;                  /* Number of vmas that will be removed */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
@@ -78,6 +80,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
 
+#ifdef CONFIG_MMU
 /*
  * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
  * @vms: The vma munmap struct
@@ -108,7 +111,10 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->vma_count = 0;
 	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+	vms->unmap_start = FIRST_USER_ADDRESS;
+	vms->unmap_end = USER_PGTABLES_CEILING;
 }
+#endif
 
 int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach);
-- 
2.43.0


