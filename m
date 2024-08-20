Return-Path: <linux-kernel+bounces-294436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48C958DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317AE1F24152
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BE61C3F22;
	Tue, 20 Aug 2024 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cokcrV9I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qqQPES6h"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14E418FC9E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724176487; cv=fail; b=fRWwLH+MkjGkO4zJ9iQl4SYJIEfO9BUW5hWl6nnlzZB5TsQx0hz1OWIUZQ2+wqp9NGq1mNLqbjgI28AekRN7Jej4C4kC+VaQxamA7TbiHPdUsAnhpR7MVS4Sr8ZELtdrrsZ0xYiXFy9Qlx9kfVGxMYQbKyTKFo/3XMtqVLHnd54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724176487; c=relaxed/simple;
	bh=F0qc7K9tcTT5wkBbxA9Wux8ryLpmJ5rCMXSf9YZPqgg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CX5lVFxUIXKTeZqHciBdP9E5Zcg+eFlkuQ2dyvquVSaoGGtIt31CfrTp1ecvSr0mAq4bEC9+J/BYufAZTMD9hai7Ns6XDl+N/jOuxQBshrbhnUqYXkh1PC6iaJrQALveQd/xLkOzyPTe8/De5xpiWM2pbTQkzaRJtuihv1Yj1ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cokcrV9I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qqQPES6h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KHeTDY003054;
	Tue, 20 Aug 2024 17:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=8FbFz8aoGuAKir
	Jo7+mWEn1vEqisuZjzF+CwIgG5VUE=; b=cokcrV9IiRrot7sTnXSMehn9jK9V4O
	eNG+oUYBEu74pbxMC3h+Rx7scWQKdj6/xuYNZ6iW7TsU1avzjDNYkva8G8PnDD+U
	hGaAuhfAoJej4t0W0CPPapmfCz3wcJ2MKPYWkUTeMbylgAQPjoWqzDLIxyKx4L7m
	/HYWlguwzi+HFL4eGkoyj0IMcNDWyO4XtBW0ItVIZE8DEU2RFLGHTMvUMRD6rmBK
	Nc/prwz18540HnhRU2Lf/ksCu5Jh6Y+fhPbyhaBG2n+c68GBCo30+koJo5xiHOtw
	QkNgzvE+Rk5c9z/qTjvCffGOx5kGSuTZgqNhVRuc6ZjytKl7c6lfOCLw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 414yrj00w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 17:54:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KHJPFw016982;
	Tue, 20 Aug 2024 17:54:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 414x6gw9wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 17:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUYVtmiGlgi7MNATfwOkvy7CauJHCWXXYN8DIj5t1hOolysooMMyvtBhL4n+dYTGdDJobfHjrAHUVe1Llj43wAgPjVO4ch1EBVo5ablZWICZs0soZlpg84AHLwSERH2n5CaHyPVZpEnGWqEJtoZQZAAuI0p+wa8ojk6j4zZIOeqV2WNtKqES0kfRjn1x1Awtb6hv/PkCyyZ3CxzuC+yoj3E3T9w9zlp5snHteVq4kmmMtQwvb/0ziOIDGvnGhfT+/gY38rZ7FEcA/u3Rfox6KXDUsSY8GNr1zIOCLpksrgo6UJMci8cDK6gicLOmDR46hXTx2PgsdPfd0REMw3JVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FbFz8aoGuAKirJo7+mWEn1vEqisuZjzF+CwIgG5VUE=;
 b=b6FvbPOJfQHS5SlETUnoGLLDAzbyJImFbrzC7W4/CXPvriIx8tGIqOxZsZb3F44ooRx6vaxOg+GFK8EsageNWNHwp1XilEHU7v7g/oRJUX3HR+edZSivCY7njzL1cVgNCbudz2j9509Vhc2lw4UriRE/LngpzUpXHBVWMOXBxMAMzvMeByD37rksnbXJQnw6OAr6uTC6Rtgp+6jpoUvGkc0elRj7daPKHvG0WLQbh7eZ6DBYLSJz9bYeg2gQtpPclDTAuuf9SAtHFqMkM++3EUiH7lcNN2ZP2tfka0c685kwN24ErF1Dt6a1rT1kNc3Q45rzrq6hF0CX3rpY0QLBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FbFz8aoGuAKirJo7+mWEn1vEqisuZjzF+CwIgG5VUE=;
 b=qqQPES6hPlg7FMLSHSlksHCeiie4/tY+0P6Eq7G77rCieTLyu8Y6OPlz9Ee4oGASZrtH4FS2iTaIUCHYCfEJhukXcCl1Kln29Nov6WgXWAJjxxa5DCmpswAvdIRmoB2vsLApZsVHue5gL/pddQiEJ2HGfH6WwjcVVf0+ZHvq79c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB7279.namprd10.prod.outlook.com (2603:10b6:8:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Tue, 20 Aug
 2024 17:54:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 17:54:31 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        syzbot+036af2f0c7338a33b0cd@syzkaller.appspotmail.com
Subject: [PATCH] maple_tree: Remove rcu_read_lock() from mt_validate()
Date: Tue, 20 Aug 2024 13:54:17 -0400
Message-ID: <20240820175417.2782532-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: c9bc0cc5-c2d3-4601-91aa-08dcc1412476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g8uXUu7tLPmWrOEXX11xamMc28TFjmswjhMYGQH+5QtxF22/CBvEJvj1uR4Y?=
 =?us-ascii?Q?bOgLLe8th1I1EmkfWE0PzrXk7usCkINPyM5VjX6/KiGhTkQ4w+JpG2I9S/xN?=
 =?us-ascii?Q?BpkS7CEeVbwHr/qy51F6ka+XUGNN4PdenT89MweN0iXAQ4hgn8EHX2DFP6j2?=
 =?us-ascii?Q?jU2ChIAT73oPaJnek/DNKqejy6bxabnxoqdOn6TOv0unQcBjrAJ8nIcyIRUk?=
 =?us-ascii?Q?oYCz6xlxwzaqY7H+3bh0e2ciosgoVX8We5vVe7JOtknjdNpnRcovWFlaY/ng?=
 =?us-ascii?Q?kITRohjlPvCa9e5CYYL5Syxi+z8KnE20JgqN1qnDmkTNiytrJjH2ysyOv1Ho?=
 =?us-ascii?Q?YoXb6rinG2WzMK//wbNF/iKIjx9E3jrfQQKYoAnpd7eaLSc2bzGiTc9uz4D+?=
 =?us-ascii?Q?m1kRaItHb9EyK6EDm9Y0S2Ozylj2yJaz2VKxmfUt+OPydioLNDewC166c5gA?=
 =?us-ascii?Q?B61/MRIly+yiUbBw5j+gMl0EE+rrk2P2YJPHwbzHBMS08TETzQ53jfXCZqMQ?=
 =?us-ascii?Q?GkUXw0XBQUDNTy63b1xtAH4SrQTglbCOpI5YAhOSm9vcp1pxV18iTnXdlKDm?=
 =?us-ascii?Q?6yXxRtqdooVKGmGThsliyiHEBQYoQFm/5/q58IyfDi986EU8jWAKPAEGxuQ4?=
 =?us-ascii?Q?bH/ILgxWhaKSbSTUDWnQ+TTtCliVq+JF4rPvrjgsjpIf5MlPbtuF2KkEzs9D?=
 =?us-ascii?Q?8ddTdrPi0uAIN3TsEas7FApQyuCI1ztT6WHWu+REUwR2griUa0kAuGGmTZ0c?=
 =?us-ascii?Q?5sPaVSO1SvGSkEvYzh1eWGUKv0yhJGamRAUIUgNUsAaZIEArGc7SEuMip9xI?=
 =?us-ascii?Q?q/eYnTzI5FsIHfiHllUojaG6P7zcqa1ZpAEFM5cYwlFwr4/6dEywTmk88TUE?=
 =?us-ascii?Q?Eph15GGaqGgcZb5RmViJ0ulo2VJHpwhXH+/HK/4XQelmHc+SZ/+SFiUSxMG1?=
 =?us-ascii?Q?whbox6RBIq44rYP7vwuJrYMHccN6Nth8pwPkZlW3XJb8g63z4mO8SyzRNMoM?=
 =?us-ascii?Q?60kSUAjc+tX+XeDt+6k9yWP7VrTUm9keGKgYIWSZxxJ5GPIbn0z8jmXNlKyA?=
 =?us-ascii?Q?1a4l+34FKtWAqZPK0AcJyrYs1CPP3x2Rd7LLRxOqCOG8/ypmJ0sxEVnlw9N7?=
 =?us-ascii?Q?SzNcQh0f+DOCLv6NthvY7DomHlYF6hXYvWZDZH930ncNBDmWqPXU2TI4oPhN?=
 =?us-ascii?Q?qOF1amKNIpB4UaskaNWsy+IwVBFn0/z/GFRxveDF7gR0DPzeXtKwUcDX6OvW?=
 =?us-ascii?Q?cNG7Hrr7ZeJt4VhbGmKfXbG6cnVY7TVMkFLDz+HxIKYBMw6sy5bEcewrVP/D?=
 =?us-ascii?Q?JUA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JLvjkVs0UNjfeQArZHywyB7xDbkW/4niEzYJg0ch8SfPBusVL66APrcD6IbF?=
 =?us-ascii?Q?dXPVvAvca00OB+++Boo5qCqTdansD338tEyCHftlGj3xwwnwRqDVtVNUcViB?=
 =?us-ascii?Q?GvijsK5E72Ub3VJ669ZxcRs9IhJcjFt/SPNuLHZIBOTqKl7LVDspvKKDZN7k?=
 =?us-ascii?Q?gcyL5exzu5aty60IYECQB/a25WOZRD32iwf0PF/iFfgFWhkbngLpyxdguTzu?=
 =?us-ascii?Q?Qw3S7caqnzmy77iU6OmOGMFgXyvBqBNed7aK5RoJ/8XQG32JGvWRNnlviRuC?=
 =?us-ascii?Q?vs6cY25bIkLYayNhb+vXr0CDHJ1f/c0tmZbAErJUv9TYSdDgVt1zWoszOP2d?=
 =?us-ascii?Q?JA7zz2GKBznbYZEqAk8Bi209jjyVCcOdhtNQNZKjpiBsASmybLEyiWddKOQa?=
 =?us-ascii?Q?udcjBcFk/DApusPW9lzBDP97wD5c+vAzOE+EzLgscPCoqAdAhhcCONyBGuTl?=
 =?us-ascii?Q?aoprItV/CqKQgr/VEaehzaxprFld3cyp1vE7r8u55DhOQs4M+puhtGSZuB33?=
 =?us-ascii?Q?UsfWsLR642UAguJdHMsKG4cAIuOojrKuL3aTmsb3nMKJUuu2feaGVlnfj5ex?=
 =?us-ascii?Q?o9aQsDr3lA9Fy6DdYt9qiEkuvvQkAq2cg/H8/x9QrdhwIOvR85gN7xK0ShLJ?=
 =?us-ascii?Q?/7g2hBkHvG7WTM0xnmi/FSPdUvgAHfXdv3gfw+OSfyePQHW0MRCHdD2oZqlh?=
 =?us-ascii?Q?LMUzn/7pWnIGlDNgsZ8UNwwgASX3k5jAqjVikS8+EdgaifV67PpXT/pn1O8V?=
 =?us-ascii?Q?TfXPwdIFPV+8lkWku2jGKH2jQj2usjbXlUEDPbXwV+XbAmOmznM8mzZ7cx3i?=
 =?us-ascii?Q?HPAFYfE3JeGWVwPsi3W9+Glpw231SosmCj9DiZvL7cJyssXnpwV6Jr6NMGee?=
 =?us-ascii?Q?Cf+nF+FGNeGzv/IR5A6Ay4ges2ivOl18966QGHw7eA72fnfoo8MkEaKAHwRt?=
 =?us-ascii?Q?M/6fMEN0c8A/uO8Q29aZNVsOenCSDn96cGVlcpht2x2YZQlPfb061omkUPKy?=
 =?us-ascii?Q?/RqEuPOmS8/JI5I5NmvbdEHC8ftRiuDhjfpHdn3VK53SSp+d3eU2i/TsNdu3?=
 =?us-ascii?Q?b/6s2v/DVd/qEGSK8ZlSnEYhaAa8cHA3w0Gl3S0EeLm0hWK66NQEFfHB+KvI?=
 =?us-ascii?Q?Z1z+1mVYu1PTsLG1kDw4anxcZoSD7X6y1mO8d6gOLu0XBnbaL6m3bLom+Fmw?=
 =?us-ascii?Q?Bb6GXAVPfxxEOjhw2v41b+wQuxwd59cyzPEZGBeFlVq6Y/9pDQTeyEhO0kTs?=
 =?us-ascii?Q?GS+8+JiCTjM3TuFhomILRzAyAfOyX9W/pf2u37Mv+kUCoKI81bx45dAPe7jh?=
 =?us-ascii?Q?kTZtI34c531gPuuwCvZQLE7eZEnJ7LHWE31SWRqCQqSWn1WX0ToDJviZ85qk?=
 =?us-ascii?Q?Kz7oBex36bk2X7GapPCFpIOgG5ylru/zEQaGAURkDFNdOr5xqx01/AvuDbRc?=
 =?us-ascii?Q?0lKlXtV0TbvfCLE3jctWPG76C2Kg6yQ0+Xv8jLGXu11GuFrddPhoohx6Dvwv?=
 =?us-ascii?Q?Qz7pfqE1AX+uLbaA23947BLTRjH0bMvjDgrpfnv+xufMxlw71zm6amhxSASi?=
 =?us-ascii?Q?golcspdKT87ROXhhfDWlJl6MF8kgCr3hBdkUPSK/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IsJAg3lUYrHR2qdzpY1PlRvk1LrCiM+WyAP1/YupElwDXNhuKA2R3fnqVpA0ItF0tsmhg69fD7EcQ0iT4Utbl3Oeey4IlOvVWAk963urw1biYZRDq1siU2tnl+iTokEirEYCVqilxzUdVgdGg7xuIxJh0aYWTUEONUPHjdrSILCdgMdpVErL0rzHCD0aRjf09I0in66XUVx4lXpiXl7BQ5z2AOktoQlbqOu5GI5YIb1SkIDOooXGziT8FYt8vD0urWlCk9u4S2Q7RUo5fIdpf3jC+IOPnqKhEujnh0LvbF0AMUNStcSvX8EOVMzeVZIHdWlnWfM1G0HDJrvPSuTcnipzEnQVn7B5t55Elyot+FWQFqrqwtPq9hKak924Bid8Sq/nPP7j+z0A1Fj2QXqpLtNRZx59KModQ2b/COKkxoTYr/m7wy3Om9AjW7obM6Tv9P3EyatGWRxJLfuaKGNDU4BbUjE7iDG0+pDVFMo+GiHZVv/Q6Xxy7IvhiZ8VVnA4SJETGN4GRLp4+LnSWN09xWRy2hRaPWgY0mjtUvvoz6G3nVZzquws9m8vUHY4+ux7KCvJUrq+AQqaTYVI/lEPKh25046VjmTHX+e2FKcClVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bc0cc5-c2d3-4601-91aa-08dcc1412476
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 17:54:30.9801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkKKEpi/eG0cWv3BKx2N0RllWmA3pBg59KTIuHPxLXCTvqcFaMgElUECmR7S4tPqJY/dpj4EVWKyxN2XMUiyAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_13,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408200133
X-Proofpoint-ORIG-GUID: mkAb-RM6fACaOMreBZdvj3fNZUBXC9JG
X-Proofpoint-GUID: mkAb-RM6fACaOMreBZdvj3fNZUBXC9JG

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The write lock should be held when validating the tree to avoid updates
racing with checks.  Holding the rcu read lock during a large tree
validation may also cause a prolonged rcu read window.

Link: https://lore.kernel.org/all/0000000000001d12d4062005aea1@google.com/
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reported-by: syzbot+036af2f0c7338a33b0cd@syzkaller.appspotmail.com
---
 lib/maple_tree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 755ba8b18e14..fe1b01b29201 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7588,14 +7588,14 @@ static void mt_validate_nulls(struct maple_tree *mt)
  * 2. The gap is correctly set in the parents
  */
 void mt_validate(struct maple_tree *mt)
+	__must_hold(mas->tree->ma_lock)
 {
 	unsigned char end;
 
 	MA_STATE(mas, mt, 0, 0);
-	rcu_read_lock();
 	mas_start(&mas);
 	if (!mas_is_active(&mas))
-		goto done;
+		return;
 
 	while (!mte_is_leaf(mas.node))
 		mas_descend(&mas);
@@ -7616,9 +7616,6 @@ void mt_validate(struct maple_tree *mt)
 		mas_dfs_postorder(&mas, ULONG_MAX);
 	}
 	mt_validate_nulls(mt);
-done:
-	rcu_read_unlock();
-
 }
 EXPORT_SYMBOL_GPL(mt_validate);
 
-- 
2.43.0


