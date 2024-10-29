Return-Path: <linux-kernel+bounces-387465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BF09B519D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A3A2841CF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8873920494B;
	Tue, 29 Oct 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SR+gmUdl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fqfq+TgV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154F1FBF50
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730225570; cv=fail; b=tOfbjTAxDamWypy9jqlKl/K+UE51TR9y/V5WyjwBKG/HLouqr9+BcyqFldnk7urPIsx4kx4bF0aVM7je6i0fGSSnrwpqQXTAqGbCSMj3WGIbxjOAOB1b8AOlJ5RsljBeoudWeHSy71ru08PC7u3E6EXYFKXI2n08zVq2YBmlGmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730225570; c=relaxed/simple;
	bh=POYhdl147LmM8W8hNFCqJWBEYGG+0/02zgjx9UJvNRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bH5uARBv88Dy53vph6QoWzq6xFYgwsZiv7uHIGKoeg8YlO8SxrRuJgiZZwoDXJ0NK/xHqWhr4Ph2hHG3oT5Yt6C0PPLQT1jwrdyybpIDH9l/GsP3kqpwUgxBipO2Iz9BFyzqOdCafXzWujIlWYUBx9bbMP3sYWUJdzx3kmH/+hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SR+gmUdl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fqfq+TgV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGfWQj004318;
	Tue, 29 Oct 2024 18:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=owPx6h3RstDUuQfnccozZWYC1C6lZczWO8TgNEoLsp8=; b=
	SR+gmUdlVfBgvcFalfHKU4mmj3mK/Yp7POmhHyTzAutf9dhYdDpU4N2M+Ez1WJG5
	K5JPHTm8kOi8yBvBaCoH5QgHvZxaiSZJsLdx3AFUmCzihD02UBqcpYBHV/OgIwOr
	+4oB4vraffjO03AcE8kmiHcR2dA8dz0Va42TuhNb9Di6UJqKtPztS+dosbLK8Ztc
	ml0hMjINF176wsLYu7QNmpHjrSSNgpUpQfkaq3dSWAWETYU4bDdmQPAjmRYsXLxI
	x8MiPdSwppivRnfYMs++piPxapY2iIdAe+rbbejU+C1WM/+9CjtfoxhdeSCq7I/S
	/6/Yd/lFsUyrUI4xB+PUyw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc1x5s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49THds0N009964;
	Tue, 29 Oct 2024 18:12:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hn8x8x0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 18:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgrPpD6HvGJNDtys2IPEzNUxrf4tUGIR67eMgAAAWe3Vqz0C5i9W06Jw2sMIWN/u63a743O9AGjZr54bXa+aNhrKyfPoOYsY7IXFEqT5Ls9ZE5aRhR2p7C+rPsTd/mszpKrK9IyddiabTBd2WTY3uOP5+vU83+8ERxGaNMY8ECX1ReZi5SweieH8box9Ao23dehkCmHFL7BFyYJNncUw6ifYNTBLpWPXmiVqxs0rT04IjwdKZruy27MwO36h0KqGcwpBzu7Nuh7mcY6hk1WaUlBEvt9NQSUmFFEwRwSlRMj0HSZ+nnzAvKGdmsTJ9aGmkSdLdIxD/GuRtHJk7EbnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owPx6h3RstDUuQfnccozZWYC1C6lZczWO8TgNEoLsp8=;
 b=fteWYrB398HqzZF2nRIBfKBAm7GFQGuQO3LoliPSdK0r2ZjlvERjsbYH5+v7mUpsUQ1yFGnyAP2bX8PCmEVvYAoyXWYawhcHWsE8s5jnXrB+tdBQ3eps2dAvQ/aZ9e4+pPQ1XyQztqZ8aedc9GGReXX+2EDhTnDfgh8jYg09HdNGv2f0yw/IpAuRsWtN7Cvckks/nkDRBu4zeDvbVBuZAeo51Ty3vtc7XyfG7n+xM5nITv/4euiKFDx8YYcBoF0A60H6TPdD9QXVZcZwUbIN+f2pVJJmSNpvuR1vS9yYDgtimGCNjOJo/xbgTUaVWXKLHtEcqMKbK+KO/x5+nH/kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owPx6h3RstDUuQfnccozZWYC1C6lZczWO8TgNEoLsp8=;
 b=Fqfq+TgVfeuN2wb649JKPbkMw8RTHDyuHv20VES/hlt5sObrd4zQa5O6btlnteG0klQ7G3So6rJmM34WapOCHAgaByxTWtxgNOdNQNwTeLFnBKYCfA2dBRB/0iX2CbTCVbma3bx7tXJjNjJnea8ZByHMcvv5WLf5MAhwh9Nfwl8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN2PR10MB4352.namprd10.prod.outlook.com (2603:10b6:208:1de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 18:12:21 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 18:12:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH hotfix 6.12 v4 5/5] mm: resolve faulty mmap_region() error path behaviour
Date: Tue, 29 Oct 2024 18:11:48 +0000
Message-ID: <6e0becb36d2f5472053ac5d544c0edfe9b899e25.1730224667.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN2PR10MB4352:EE_
X-MS-Office365-Filtering-Correlation-Id: 540479b5-8dd8-40cc-24aa-08dcf8453b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UfE8/N7Z+kFkE30UcF87DMys1UL847X4lHyHEq8JzaxvsFO9eCzgHL1dkUeY?=
 =?us-ascii?Q?F/Cmiha4DuZzCBy5lBbaIonx4BeR4Byiogny9rCrhVkFyWvLf24Xal95UEY3?=
 =?us-ascii?Q?0jtHi21X7H11YdUtXn8R5yUToNvTOgR3gFK8Sfme70wqrEyp2aac3eEpVAEU?=
 =?us-ascii?Q?HQewheanWql3rUmk5nmYap12oCfnF+aBYVEwqf5XBEAM1TPW1+cwMMBRq8xv?=
 =?us-ascii?Q?8lwQ2ZYLXEWyj716/f7DOepdFsSgeeNMA6fAYcMN6BC7K4/EvozE2c9hxUl4?=
 =?us-ascii?Q?S6AHkPL8A7WktSehIvh8nG4pYc8948Q26r8Mvxva5nhlUXevtAe7mFC1F+B+?=
 =?us-ascii?Q?DWJ5COR6wse/5gjXnD+nea7kPd+vGKjgjx/uVuWQ/nvWBgeaj1bl3YhPRYj8?=
 =?us-ascii?Q?qRV4q5yS41JIGna2qfK5C6KxWk0pTPOOlqPqChnqN37V3N7h35YHzurbc7Ew?=
 =?us-ascii?Q?CIa7mmHtk1nAJk1Yxey3sAxj0ErA53Ujjkh752PAVyYxY/2WuwhglB64IRzs?=
 =?us-ascii?Q?Z7emO4y5TD/cQLGzeLRiSa/f/O3vTIm6yP7RaRyhyuzFl0FDV0IQWKNhkWkB?=
 =?us-ascii?Q?CNuIJskgRm42JbhimvgnQNZuvxu68gX1H9KktCRLRW9cfKva44CbfC6Qv0iZ?=
 =?us-ascii?Q?SPFkn95EHn37KpRUkySV4EsE+JilzM+cTly/hkviBkBaUVQ4d0igsFx+wzWK?=
 =?us-ascii?Q?7N1IDlJ65K5nXkKVZ9G2i98XXy+ge6Njof0Ty6QJYeFbgfIyIHUXzA0FA/WU?=
 =?us-ascii?Q?jP2t3IevutyR2HgdXAzZWMpdfRfMaFBaBJnI5djg8pwZm2ZuysWKb+92hbSC?=
 =?us-ascii?Q?kLXf49W3u8AaCEqZqBk78KIezwLwlQEVKsWUJ7zBhjSmFngzIyFFJ58fV6pw?=
 =?us-ascii?Q?tKnp+FEZRf5WPy0jCdwLNNR9lYkMRM7Yc57GCFDc4RV4yN1LeqVPFR1P88xB?=
 =?us-ascii?Q?3GHrK/+hR9K7xVRMHXnEL+51EonUljk2wfjh/YRbwnZLc118KTk6n3AhV5gJ?=
 =?us-ascii?Q?283kyIz1Tzb8YrmPzzWEajMpYhSUp1n+02if04u6NDN50I6RtjbHQDVVCCGS?=
 =?us-ascii?Q?RPqKzD1aZSt1zdL2fwQ6uiPeMLSgVHV8tAj9fllqsbN/jS+ExnxvvtnfdEDE?=
 =?us-ascii?Q?L5BiNUs9TAwQFucbdrA8WPwQWmkjMjJcOLtIFU7zq+G6nqm8Xdhcr1ECwKUi?=
 =?us-ascii?Q?FXtOQmQCcimhr/sM7U6HLgO77fcX1jDxKCTrMGOb1MCTKVWqIP8ItYDBh9WB?=
 =?us-ascii?Q?PcPslZjdK9u1u/Ekn1iqo/id7vXkimdFRgnNAIABPR1GdGWf+PlPwJPAK1fX?=
 =?us-ascii?Q?Eoc7K0yWjf0iDLYC/cjBLQ3M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nRT4ho7PzZNXVOiXyfzgTlGtWjAqj0fmds17AbQZczj+rrOR6a129X+mFGNx?=
 =?us-ascii?Q?sN3QGXAljDugN57xLjnmXdJa+zVEe+eRp6lrLU7IqmtaW+RmHIMJhZXVAnNQ?=
 =?us-ascii?Q?W7OIdLAwcogJepdPei6t+cbQ9iLY7gTQ2Hz5pAo23txLcsyeCvAtFY6/kqS+?=
 =?us-ascii?Q?YM3ewEA6eeLlK/QCMpd4bNgB0kGv4+VQEtYptTnesOVcRM9wPfJa5jjdwFHV?=
 =?us-ascii?Q?gHYlzzt+Wgs8n6ql17PNbsrdUJmkq9q+AOP55HVX4sdCXjCrZFBoSOjYOpSw?=
 =?us-ascii?Q?uERKOsdBMt4TVZobKf4UDD24rpBCviEyzf8ZC/3MG1X0NfXoIBHQKKgQefIR?=
 =?us-ascii?Q?5jcWLwTwKWV7Gt8OIcfwNIS0QSJrpkFjhPlXoWqQP5wRHejMCIVzRruofxec?=
 =?us-ascii?Q?fFcwYMV0W0zOFtKpTdthly22Zy2SNsR5/MVnnHU4qJYjWJwaVydayI6QgTfX?=
 =?us-ascii?Q?GggNdeIv2yH5ND5QzQJEnoi9JBovWJuiB+Aewg/0ZEfXhIDIT+4BoldVdw/4?=
 =?us-ascii?Q?DgU6VyuI420foSnLLVJl1pF2eC7VQi3BjIxBGR3amV5F3wwFtX7J7issLd7E?=
 =?us-ascii?Q?be/rljks/c19/6LWy08FyxzSMcj3jI//h/O+G6/+IRHAyJUTqSLnDdcZv1eJ?=
 =?us-ascii?Q?iG8/AO5x9oYf5YF8ckmmBhqZAXpcd6oR81Oe9eghagzbqHXluMqkLSIzh2bS?=
 =?us-ascii?Q?mgvOuP7WzUcjq4G3pj8LENUaeHR3+wcR9R5fDAbFWz6bM8lrUgt+ExFlw0jv?=
 =?us-ascii?Q?qf8It5hSIwhtHmtIwY95AMeZlBgrUCsWDdHIBkrD0+9VD1vfSYwIB/SG82sf?=
 =?us-ascii?Q?sf730MDeLWWl4lonoj18qpVQy1fhd6AtEKSSQpFZY0U28uffD9uQsbJp/1bQ?=
 =?us-ascii?Q?ZhMlHO52jM9Dj+jHTyYwVU/cM8QHBhd4rOtUlPKHJaFH2csGZIsdnuxRA7lS?=
 =?us-ascii?Q?dMZKZkZmcnKtVePehe1thnOgLS+L+0sjhQLPsOrJkBEmm4q9+cVnhztUmxn1?=
 =?us-ascii?Q?pbmXcgyf8+JtjqwhP2Op+6MxYX9YxMarNiVc6/Uyvn/0ioWQY0eG4+Y51aRO?=
 =?us-ascii?Q?sikyFYXmSFbEIFF4qTMUktqwdv8AFKLCwjyul7wgW+Ad0wWCUYvFD6ZZdMpJ?=
 =?us-ascii?Q?OmgOaihsMTxdIcLuUfd9du2vlWgyXxvtbtBFWZgiBJnxUZItfieKMPIbPxkU?=
 =?us-ascii?Q?mTbhLZeJuByuhkzblHdJ/6/BP4hOYWIXmEspw6vRHRNhNPaGo3dIR4Or0Ss7?=
 =?us-ascii?Q?tS8sJAcAT1cIpcNmGv/mlFwIdapXDus+/SyLTMhF99t0ROJJ/a4Nhgcxc5gg?=
 =?us-ascii?Q?NGV1yk7WVKzvWJYbcnnhPARwajvWJsmLp9hSlK5VAi0v9QTgjLD3pUECMIyw?=
 =?us-ascii?Q?DGhJkHX5p7hkyRagFlu574jE4wmqM6zFN+N7MXUCRTFs92DKtAq/TWVafR+K?=
 =?us-ascii?Q?E4EvqMD+XQivnkqEAXS39pmjWo8u547xaixJBVGk7qn/FGBCZfdXolgUBzNG?=
 =?us-ascii?Q?Ew4g29vmY40sS7frOfxZWwJ4MJ6Mo2D3KwH6ItjHFFHLGkaBipU5DgVYqFY4?=
 =?us-ascii?Q?XR5ngCRDD8JF1FT4O1V6phzx61qIcRJnd9JvxV64KpLc1p7IEnPS2kvnDibq?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vpShXdS2pDcPI4bo2/CTEv1h+649YcbdbBflMfan2/eU7CBWbDrDpInzKabs0N1Bm1IYBhafgYqdNp/DCoqJWdqAoCWfl0EtD+IeRAwIEJWcSV3uIRXwgjcvCMFDF3HZWL7TY+BUFjfXGRJ79IyB+m9ZJio1z9yeO86tT/QZN1Tt8NtGniQfolCm1DcVQoz6MgjsmN3GqZHvJ/USK8+DhKSkywpJP32nBIqrgid3glsUN4ykB8XEpOXRbybRQkYmGcP+98etc51yf8auXCKXOp3E1XpxApjZhDdg9GF06KIZk6+KuQmUEV2fcK4DDU83atGTzmtz9wEOVSF68G5dNFotd6qeQYy5EE1Hz56WHPN2YdxCxdSGQAxKORFTTDpJYlUQ/G+9TQrv/KRyFyhbupmuMDrFQxM9nbO5gtU9uv5cmC8J0u3X0DE9Ys6Awdm/YRUJ8xeHwFrmiXrSCzUcPjicaFpqMVmnfIwguAM6KgjFLF++I8oUEYgTQjZaLvDFJZKnhsw2ro1oJuvcnHgMmlEpZaZ1K3Dmbp1iJknNWm83yOhtRQhmC+c0hfu/TNtj4ybRTDnKVRgcNb+C8EESP8PeZcZwrGC0oytIAeEdLXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540479b5-8dd8-40cc-24aa-08dcf8453b49
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 18:12:21.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqkJRtjJEuSgu0lginSrRHpL3A/MwiaGEQk5BI6o51ZN2VInWVtzVba1hRQk8f82RQMc63t5TO2Sr2D+6p11QeaPjGCviHS9ZsUTK5E8rRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_13,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290136
X-Proofpoint-GUID: bSKqrEvuivnys9q9WEM4Q3zkY6K3BS6f
X-Proofpoint-ORIG-GUID: bSKqrEvuivnys9q9WEM4Q3zkY6K3BS6f

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently observed
issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 119 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 54 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index aee5fa08ae5d..79d541f1502b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1358,20 +1358,18 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	pgoff_t pglen = PHYS_PFN(len);
-	struct vm_area_struct *merge;
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
 	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
-	bool writable_file_mapping = false;
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
@@ -1445,28 +1443,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vm_flags_init(vma, vm_flags);
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);

+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
+
 	if (file) {
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
-
-		if (vma_is_shared_maywrite(vma)) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto close_and_free_vma;
-
-			writable_file_mapping = true;
-		}
+			goto unmap_and_free_file_vma;

+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
 		/*
-		 * Expansion is handled above, merging is handled below.
-		 * Drivers should not alter the address of the VMA.
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
 		 */
-		if (WARN_ON((addr != vma->vm_start))) {
-			error = -EINVAL;
-			goto close_and_free_vma;
-		}
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));

 		vma_iter_config(&vmi, addr, end);
 		/*
@@ -1474,6 +1470,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			struct vm_area_struct *merge;
+
 			vmg.flags = vma->vm_flags;
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);
@@ -1491,7 +1489,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				goto file_expanded;
 			}
 			vma_iter_config(&vmi, addr, end);
 		}
@@ -1500,26 +1498,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
-			goto free_vma;
+			goto free_iter_vma;
 	} else {
 		vma_set_anonymous(vma);
 	}

-	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
-		error = -EACCES;
-		goto close_and_free_vma;
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		goto close_and_free_vma;
-	}
-
-	if (vma_iter_prealloc(&vmi, vma)) {
-		error = -ENOMEM;
-		goto close_and_free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
@@ -1533,10 +1520,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);

-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (writable_file_mapping)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 	ksm_add_vma(vma);
 expanded:
@@ -1569,23 +1553,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	vma_set_page_prot(vma);

-	validate_mm(mm);
 	return addr;

-close_and_free_vma:
-	vma_close(vma);
-
-	if (file || vma->vm_file) {
-unmap_and_free_vma:
-		fput(vma->vm_file);
-		vma->vm_file = NULL;
+unmap_and_free_file_vma:
+	fput(vma->vm_file);
+	vma->vm_file = NULL;

-		vma_iter_set(&vmi, vma->vm_end);
-		/* Undo any partial mapping done by a device driver. */
-		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
-	}
-	if (writable_file_mapping)
-		mapping_unmap_writable(file->f_mapping);
+	vma_iter_set(&vmi, vma->vm_end);
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
+free_iter_vma:
+	vma_iter_free(&vmi);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
@@ -1595,10 +1573,43 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 abort_munmap:
 	vms_abort_munmap_vmas(&vms, &mas_detach);
 gather_failed:
-	validate_mm(mm);
 	return error;
 }

+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Check to see if MDWE is applicable. */
+	if (map_deny_write_exec(vm_flags, vm_flags))
+		return -EACCES;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(vm_flags))
+		return -EINVAL;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && is_shared_maywrite(vm_flags)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 {
 	int ret;
--
2.47.0

