Return-Path: <linux-kernel+bounces-378804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506A59AD5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E5B1F22E39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DDF1F80B1;
	Wed, 23 Oct 2024 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g/Noy20H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P7GtL/xO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD701F471B
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715958; cv=fail; b=VEb8XWtFZtJnZ8+tVuIf1BaVUAe/mS2RRw+2SW5dEeDHJOurc9cVDBK13QVQfcs6IVAWgnC6RAc4EJE9T8TIZbxZaafTtCuuE7SVJv6Iw4iXViev+doQzaB3EPMZNgxgJYB/V9aaLMBzvtD07N+m6YXKikr6L7sQ57VqPSPm1pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715958; c=relaxed/simple;
	bh=ZDlslQsibN1rGDSDxSonHj9X4+3bg7PC2SBRCECqv04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RYPBt415ht6yrf0xMPSGWmoc4yJGst/RNRt7bxJ1dg1E9rKCLgkp8w3bNgycv945N/9FrrToYpjvaR+iUDFGRYozVLJjVwVpXZW7xYhsqMOZkboOSBK5Wfk3o+GgIZP86tpJvE75cSoZctLQ8Rkcq2xW21XGRhAJMRS+uiUP1iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g/Noy20H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P7GtL/xO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKd40K032473;
	Wed, 23 Oct 2024 20:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0rDE1LjjLhK0evyvP5sZKz477C4Wubbi+LdXiNbsMzY=; b=
	g/Noy20HV5Dd8HzkCO2gi2P98GR09+Nti773nFRj0swO5hRJEEkl0SICGDuR1yjN
	x/usyNE+3+l+7NEcGAyW3WTxUYkbTxRyxxKngGPVWWB3l5hgvon9PjQRID0MjbUo
	xSHT1qcTGY8BfiIwYe7s3AfeF4XfJji1qydmljWleGKqNrpyn9bMte0I1JY5Idyj
	Dr1Oo0TikhDPax6Wvf8V03xJ1Nf+pBxczlKyn/51oE3gdMlJYUew/Y0J/pdKvc+H
	2H2WCXUyTJf3r43N43a8h9C7lGxdgK/osAd0diCn/I3AfAktW2LxUBuHT++5TDiY
	wnbw26zHdUfUfYMxoPCxYg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53us4cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJk0V1025440;
	Wed, 23 Oct 2024 20:39:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emha1aka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukZhib82aRZmQFL9/FpnX8fp81MEqcz9CbalGwf7886y12xhvVJvcpSHdUed1wD9ciTeCtRIZqNWb1vhxpVEDzZqCZBuwEYNU1/+5gvXXwJWSGeztD+nrDqkC6kjhWmp2JpuqDpciKDv/ZZjNY3z7l4UThhJF42xreW4qik19ewin18LRVqle6xY95CtJc3Zo6vCmzWSGlPPWMCM5qrfiM2GrTdfqyEuATs94sceLFvZOGeqHfPfRFkHX6pQtGGoiVfANsVzQ2y2AgWtlMhkaTFPpolKOobK7GuhNouZBtMrhEtbO8+ALQDB1b4xeMDBSmwxJzR1//p3KpSfJokBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rDE1LjjLhK0evyvP5sZKz477C4Wubbi+LdXiNbsMzY=;
 b=o1Ae8zZ0NQ/8Z49B3jS29y0ofG6GPNoy8MH6dFi+pIW8PwByde3ZdEq9qLymOJnMcu9t8aXEA3oLtJHXQY3G29pXNKsufZEnl6QmJgOOu81c/S2BI6BMyb9MQnSagsCqShCYJKH5Ifv9CdyRHQooDY+9MlbjTm23Qzwmi9fRZIMMv1h0e7SyA+nIka+E3Tt2YgwvMHgvSmDQ/1/c76jTQV/Jgq22rU6u6CXGleTAu4wfPrbsUi76l72/T2DoHnvdedR1nK/d2vy/gNuyZ/yPVPY8apxtzO6KGY/C0MvIGisHm4MsCFlYPvqRAqrxAQtjXwV5+hbv+Cs8VbmKJmJdqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rDE1LjjLhK0evyvP5sZKz477C4Wubbi+LdXiNbsMzY=;
 b=P7GtL/xOOyVCLqxowaVBS/nPBC2Fm5xAwRfacJaMVA60zd3mnd2DPFRomMh0QyN1sz7HwaMegoOuWjpcHaZPp+UR7fChpbHuSWyQ15MZodZUjA8Xxn9nMXlMk1Bvj8999hQRGgS/OP1+zyjaHao8JyOeoUXAWK77LSPolCws73s=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 20:39:00 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:39:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 v2 3/8] mm: refactor map_deny_write_exec()
Date: Wed, 23 Oct 2024 21:38:28 +0100
Message-ID: <e82d23cebaa87fe5b767fecf9e730e0059066e63.1729715266.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: b00151d5-ffde-4ec8-a869-08dcf3a2b989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3KII73MuJfN9qT1zp5XFQbPmvQVTagMFSElgtq9NteCNqzfw1sA/KE4MpILE?=
 =?us-ascii?Q?WNo3DMdYQL6t1xfu4W4GJCWTp6pDWuaLG7OBOw/yIiQJSuzrT0LV+QjB1k78?=
 =?us-ascii?Q?s80bjeJ9awBfmgmg6XdAd/5xiw0ah/IwB2wUgj7Kjz0P//MmyCO9JtQJ5Xj7?=
 =?us-ascii?Q?N9tJjrwK5CmEIDfPOF5ZEOvbTvvP1wwNa3IMhXDy4XxRRyudlSey0idNxx+t?=
 =?us-ascii?Q?5e9l0A4juf4ewwzezC3PNYGpLStP5jGvWoglXgBd+Nld/Gz+8ZYv0Kli1yXm?=
 =?us-ascii?Q?PdJi5aCPv6nQNOgH7+fcLqpuBaYb6kThdVAmlBMabJxZTTXEiYz9gKWW8eMn?=
 =?us-ascii?Q?pDY7Okn2VZK6V7791JdAz8PJnTaPUzHvQOks5rRmKg/iy/5Nie/8cw4kO0ws?=
 =?us-ascii?Q?nSyp+tiiUVpiPMygQ6VwyyCFt3tDLjKq5vK6ALY9wx9/v691ZxsS/X5O5kPX?=
 =?us-ascii?Q?V/reaPNs4drsZqnNfbL4adPlMGc2zE01Hjjo6vM1pEQYorMY6Glb27uON3sd?=
 =?us-ascii?Q?SvIGm41Q0/K9358qp+4nXmllyharE6JF/SmTXsZGaWsP0DLky7FJyLjvu5vw?=
 =?us-ascii?Q?9XWkuJjAlBgRrPgRCzbFB3ykzskl1lotGwFf4BF7P/kHSnyU1piiLa45GGYn?=
 =?us-ascii?Q?1lHHNDa2qjF/NEugmjZ3Yt7igWSUazqn7oD3IFze6IsOY+u5gjE22f4UQeMn?=
 =?us-ascii?Q?RDQ7s1OaGId8nTaJYAz2nbspv4FZFy8U9+6Ku+utI+LWp5KSIwCPk3U4nyQ+?=
 =?us-ascii?Q?tXkT6d3hG4pLL7boixPGzE7yRj+4aAwdCjPpoaWpfwt1f/Jznv6v8KDp47N0?=
 =?us-ascii?Q?8lDZyBgOynEutU0iufm0NKhUByriF40OGpCAtIQVbOkpsseINT7DYnKB/wed?=
 =?us-ascii?Q?ASLsbLhqhypholQ8BxpaB7cHFWymubXDFWizLFZBJblHsj9XaNS+0PWZLY3B?=
 =?us-ascii?Q?kLoV/Hppbay5U5LoSunAyPYX3tOu+MPoQuHetktVDsbTi6u93c7z6CU01STi?=
 =?us-ascii?Q?190n/9+8uTYeAe/WM6Z9fBA5Gg9+84zsmApLkXqgguZ2YYtrdXK0nhHj4x4P?=
 =?us-ascii?Q?gRX8ZkyRyy5Oh9h+Twcy0OQKutkP6QnhBnaxHFzgtMH0OVRAcoD/1JsH1SpB?=
 =?us-ascii?Q?1MMayQLtnxB+j/UT/32UKAiZxmvEzUMUFpOjYWZ+QkdJWA0xmTu1VofNqoWC?=
 =?us-ascii?Q?StiSva4jk5reu9ZiWBJQV48hVg1lzxnDRPVg0EXq5Pc+wiUxx5RTIUC0q/Fi?=
 =?us-ascii?Q?oSGELkW3qYOZ828pWSwTuBB6etQa8mxcLNsUA3v1OYwbq0PgjTxwFuyNo5ro?=
 =?us-ascii?Q?oZ2SEExvLyzawxlGRllHhJKZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zdr+XzLVmwsicy+us10ugEYhiO8in6ZhBsuapSYtVC4/6QEKzFCbBG9maceT?=
 =?us-ascii?Q?4qfs+oHXHAgiISlqUJS6KRpbCA40tAbAqqJ4dHiDPzV0/BaAKn+mLRmi6XC4?=
 =?us-ascii?Q?y7YIqPdX15AvI1bBGc+hqBio5ZgBV7+naYrvFzsWt7uoWUvRLOA9VpV7xhxa?=
 =?us-ascii?Q?q7e1qjpGcC0U2bdHzvfR7o/QpJtypUDhFTBU27ZpWHTUkSK+BvNZtUmsvQ01?=
 =?us-ascii?Q?gF3rFyh7WhHHLDWCk2Vlp8HTsHFYopJGYdcv8+Cm47b/0dn2Evy0oVQS8dtv?=
 =?us-ascii?Q?TE3QGTaid+OP2OQdduQ+HK5Ys9p8wmahXQ2H4zEa24gmrUqY8HtI57RcQBdW?=
 =?us-ascii?Q?WZr1kXgfNb6M0snEfINVoL/SuXATpbfWV6/FdY0oLda+ggkoMBWhBLs1/XBm?=
 =?us-ascii?Q?eNt8TgoJYneSVETOsi9svLsnQU4gBKCBKMQ5Qq1ZG9EdrNMzGvpA9aA0/72d?=
 =?us-ascii?Q?3jP59AfSw2w+SdAXjRMuc5qmtjvBIjhzH7j7HI8bP9Lqed8vG52k00AWxoQk?=
 =?us-ascii?Q?dNN8oJCbReKXVBiHB2MqBecvyr4/Y83GGd6ao3OA8VYovjjieyoEG7mSWQ+6?=
 =?us-ascii?Q?qnhgTg6BWcB0enSHE8kQClb9h8Y4BTiiWqI2izO9g9ZlT3YRJMItE6cKSqa0?=
 =?us-ascii?Q?J6du8c/bP3KoKJasAWWWMFlxnXWWFarYQ8CNBRBf1Q/3pEQ4GdTYEjWHJG6P?=
 =?us-ascii?Q?xVE7qR1k6WSsluNSvdgg5wmWhz1WUWjnyc+/z91VAYLYCAVbnYJmIlulPp+3?=
 =?us-ascii?Q?dSG7soJzLQoSQbkkgLwpXL2P5GMkzD8YiZf2Ql3jqVy3vopFaQ+mfK59ACwZ?=
 =?us-ascii?Q?kn4yCGJVmihKmwky65+Tig34DIJjsYKJ2+Sia+tkV2gyO3Qoeiv54+yhE16n?=
 =?us-ascii?Q?jOCWk6qA6fuJGdH02r+iAayzivKJD3kCdrBclj2WRM3JrUUwxLItGLtHXlKi?=
 =?us-ascii?Q?mihRKSs5nTYdi4uNbxd9LRr9rND8tyq3OQ1nT6UyIhym3idSWw9vRQEpb+ul?=
 =?us-ascii?Q?HlfG+O8lc3y86hkgfOeGCPd6cwUsKNWDTMlGXC+UraAf2PrFOHBL6eRWzsIQ?=
 =?us-ascii?Q?EBcOL16iwQbJIMUl9oeh/2zbY1EOcW39bIyg6Xml+uetvGdqqGq/IW+vCZ6W?=
 =?us-ascii?Q?oJPynV1IF047JEUhTLCWkh/nsMele1binyVfzZrc7jCztcOAihDrQpODZ8+D?=
 =?us-ascii?Q?+apDxqFyTK6OH3GOe4rmHE8cmSZ3+rd8U6zYTyTHNoQPxqkIIhCfCkTkDf0O?=
 =?us-ascii?Q?/X1aSJsYiQzOjWicc3T+MW4J475nitlAsXvgiIHq2dkI9ufCPU76XRYkZYff?=
 =?us-ascii?Q?MQNS5KR0bSLaa8UP3ImgZY6nQ57TBmw4K6fhkg8LqD2ocvKcfhMJpGyFuiSU?=
 =?us-ascii?Q?+n5kGSRmeQS4PrIJuYL0RBHiJ/Bibtl+k+Y87XRdXkCljjdeDdBCH7xLkt/h?=
 =?us-ascii?Q?CAbe+ygKFvkq7giDDQuxbk9cqAruAoc+vCDN2bm0r/X0PX4DqeFy+tg82z93?=
 =?us-ascii?Q?8DI2GdnSZ9CeaCB86DnTLeXXMpenTJo7+IMvlCkZW8dshjJVgncKsI3UeyiM?=
 =?us-ascii?Q?m0FuJi4IU4+uER0go75bfqkOSCi20AssNR0nTcApnWbPY+/ZmE14P5Xw9OWJ?=
 =?us-ascii?Q?EYvMaQ2vZU0mDEQCNMSgDPUBZiNCrRGsOnA3sT6M1n57vPJcaFtfk5RTDv0S?=
 =?us-ascii?Q?pff4Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ur3x4okU2WYLZJyUQ2s5URPO5LYOc5/m15FdUdQJkqpUSb4zMYH2ZkgiuZbQrghSy6qw+cDUAzv4OBu9NIX1kY6tCLl8YR+EwQZgRA3002rDxymZzlyYkKJGy0i5n76bap4fC2Lw3XSyDpbY8toXt89p9LjoaC4hg6UeeRt2yQy1AjuGTEAhBj+lBMicbdyXU3D3sFnuUhOIdFNsyxOSf1rp0MsgtcO7mgJwKAvS1z4pwRbh2r/S3ZAcxv+T9MMj+AwWedns0obFi37jUgblElq+Sb18cvriz35k24UFHPUBD6fqj3rDgzEyAcYBm9TQkGdYh+AFdxQZ9jqZ5n4tIG6RLL50hHk3lHhuKBphYsNKUz99SGTpnU69/8OhArb17upMFSipedV6Tn5umwfe8hg2/6OQLM19yFU4BYVm6pRHbCiKAnAGaVfi3o4ihLOA/h/A4rujEvpdqoa+dqAmPyQmNPW5/P5T+5cZ1ra2TTnSbYLRj08bRgayq75aVfjrvRQ+/D2nTm5fmhLWJbx4V5UbQUEkDXcYZM5IWPq2bnlH3SRY0QUXPXP8fSoapX06PVrI2BTNi10NjxuXDvTin/R8OHm0Rc/1NfMSZb6RGyg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00151d5-ffde-4ec8-a869-08dcf3a2b989
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:39:00.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xF6uWvu602bfRFdFB2BKx9MRQ/tLrwtBFrcx+TWAECQqV7oYMd3ivopAVSPiBSRYFiA3dmfQjp+BSnowM5Q2MbPF7/Ol3kBD3ii2InxYBRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=927 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230132
X-Proofpoint-GUID: zAz0mEDJK1N6tTkXJSG4x5pi-wPazSyK
X-Proofpoint-ORIG-GUID: zAz0mEDJK1N6tTkXJSG4x5pi-wPazSyK

Refactor the map_deny_write_exec() to not unnecessarily require a VMA
parameter but rather to accept VMA flags parameters, which allows us to use
this function early in mmap_region() in a subsequent commit.

While we're here, we refactor the function to be more readable and add some
additional documentation.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mman.h | 21 ++++++++++++++++++---
 mm/mmap.c            |  2 +-
 mm/mprotect.c        |  2 +-
 mm/vma.h             |  2 +-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index bcb201ab7a41..8ddca62d6460 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -188,16 +188,31 @@ static inline bool arch_memory_deny_write_exec_supported(void)
  *
  *	d)	mmap(PROT_READ | PROT_EXEC)
  *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
+ *
+ * This is only applicable if the user has set the Memory-Deny-Write-Execute
+ * (MDWE) protection mask for the current process.
+ *
+ * @old specifies the VMA flags the VMA originally possessed, and @new the ones
+ * we propose to set.
+ *
+ * Return: false if proposed change is OK, true if not ok and should be denied.
  */
-static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
+static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
 {
+	/* If MDWE is disabled, we have nothing to deny. */
 	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
 		return false;

-	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
+	/* If the new VMA is not executable, we have nothing to deny. */
+	if (!(new & VM_EXEC))
+		return false;
+
+	/* Under MDWE we do not accept newly writably executable VMAs... */
+	if (new & VM_WRITE)
 		return true;

-	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
+	/* ...nor previously non-executable VMAs becoming executable. */
+	if (!(old & VM_EXEC))
 		return true;

 	return false;
diff --git a/mm/mmap.c b/mm/mmap.c
index d55c58e99a54..66edf0ebba94 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1508,7 +1508,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}

-	if (map_deny_write_exec(vma, vma->vm_flags)) {
+	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
 		error = -EACCES;
 		goto close_and_free_vma;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..6f450af3252e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -810,7 +810,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			break;
 		}

-		if (map_deny_write_exec(vma, newflags)) {
+		if (map_deny_write_exec(vma->vm_flags, newflags)) {
 			error = -EACCES;
 			break;
 		}
diff --git a/mm/vma.h b/mm/vma.h
index 75558b5e9c8c..d58068c0ff2e 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -42,7 +42,7 @@ struct vma_munmap_struct {
 	int vma_count;                  /* Number of vmas that will be removed */
 	bool unlock;                    /* Unlock after the munmap */
 	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	/* 1 byte hole */
+	/* 2 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
 	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */
--
2.47.0

