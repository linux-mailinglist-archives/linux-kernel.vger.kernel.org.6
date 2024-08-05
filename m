Return-Path: <linux-kernel+bounces-274635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7F9947AF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FAE1F21B5D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6F156F43;
	Mon,  5 Aug 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LuMDfAhJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OkuDZ1iU"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AD155740
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860104; cv=fail; b=p9W8/UgbS/J2w9J2Ils8001hsaspY9OnJgLAVbhWfpPR4FvbtJMsZZNFvvYF1/mEPwH4w//ztothGPORkGEOE6X58Mpor9GtbcVPHaW+F0vaiuO/d2kr3A1cLQXw0uXAGXMx5PNXN/QZWnM4ndSsxRXnkvmFs+mRPtcVHCOOuQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860104; c=relaxed/simple;
	bh=munHlhh/rxqmYc7Dbvu5i57UKmIs2c20+zkmN1A1Ajk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wjr/lJ+Qun51JlwRqSzXTyfslZ+5OZkHDl9KJ2sDpbWQgJ79nMfc8p035VWunTrY72HlY2CfATR9iNjw5/0V4PYYjdAaYxiXK0e42QjCGokvUEP58I93GSBseSYyBLAXWvyedk1CmE1/qsmZih/1pCmwr2W+kT+t6qVKTZbN1xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LuMDfAhJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OkuDZ1iU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fWr4012618;
	Mon, 5 Aug 2024 12:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=/dW6PiGqZ6Gp8J7+QDKe42m1XjWc4o3dGnj+I9OHB4Y=; b=
	LuMDfAhJ9JhzA6QnG2JKos6komzNNptrfK9/UNLiro/6fqvW2Y+aOoExCZa9Js8Z
	LUKxpzM2CCyTUYOkEdsCfqMnnxyh/0wjLFrL9nFkwYe36prMUE+FvAZWQs+0N4aA
	73bCG2ToaNBiz/3HrrJHshPtZXtc1ru6u0X93m6JTx1DQ9iyo8sxSqSGm1sdz0aA
	3CuhOfH1js7Owy6UF8BwwDaPewtnZIurJbKBuQAomNLzsuXZ26wHs4i3nSVggisF
	/GCDnl2IkkYIUD1YSoQa7Yvrm5LaIK2MVA8H3GC/hVO+sA1kYdESH4+6gSoVIcsV
	jOLsp2HxHE4ws7iSHct7eA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sc5tafuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475BThYH018392;
	Mon, 5 Aug 2024 12:14:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb076pa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juGEi2BlXP9PbzwiWVO7wEn62PKhDmZqCkWGrtMe2FG70A/p38VnBdoET+RJY02ZzU+nvalQqwXdkR9wbh8M4RAV/mxCivT+Tu0mho5Gyvy/e/P/e1J9o8ly5GjxrYAR26JG004vA/ubVLSylJVxw4+R7XMStpaCHzMC7r3FZnjWkP3vfGRhSEWEfeccc+P5viSeuSS/Zmp1EtB3MAOnldAJRV+sdVUXw9TJnU+zeXhvPCePYHnYt4R8SI8iOChNDML2s3CV/X3zsYMIwj1tqMClwc/NbbS49enXurmnGWASzLaN5lEWtK7YpxCntt/mbtZzK5pyNERtuchiA9JQgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dW6PiGqZ6Gp8J7+QDKe42m1XjWc4o3dGnj+I9OHB4Y=;
 b=qiWlGIupY8gc2PHV7F+D75mtnB4ljAS3ZZXMfISMNuMNQ7EVm0tURow0rj5xWc7TztV85dQ5tMQR41FHkcTFVCFsFsVzfrO2LKYJlAMaZ74UZMqkqbQT876F1QNZ+9ozSOe486fxnWY4MYQldF+YBipUqsl9PEhHKKpV22oQ26G1P2ZPCZgFdgPpRTY+g/mXBWMzov2oYt/1crHod1kXVubBKPQGI0kNWSRVDkMbs7Z8lmYZbOJtCJ5uOQkfBfHN1X16NvEXVbbaLAaJvTK05pT2dfnhTyt5sV0Mowtt17+jMpB533ZHLRqgA4ih/WIXWY1zZR/qXaXOLlkudT1AoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dW6PiGqZ6Gp8J7+QDKe42m1XjWc4o3dGnj+I9OHB4Y=;
 b=OkuDZ1iUFOi1cuFMhrW7iPLldCIm1wmgER8Xe/Jf9/11y4JWDmtWzcNF6w509sdgeveM1M4mwbGXQc/JF9F300GYSdGC6bGvlGeLeKxGGo4D1OtO+VSfYSJsEXpkaPrQoeFpR4b7oDgangEryTUN+GWL9fqaIjAiXP2AUJS8ynQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:14:34 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 06/10] tools: add VMA merge tests
Date: Mon,  5 Aug 2024 13:13:53 +0100
Message-ID: <4c61f53edde8c362d1ac91dd48fc57003d13cf0b.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: f11109ed-342d-42ef-e79b-08dcb5482a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W0+4iKsOjIjVYt7EURNyIO3C57UrgejDRx1Zj2tXUfrnxIUXMrXGCRrwy+7+?=
 =?us-ascii?Q?HyDruvxBMXCYKMugaVsR9RIZz0fuH2A13cM4T0/7sKPkTCWp1TenxR8iSM8q?=
 =?us-ascii?Q?XbDZrhM4aSCJhKgTS7MOp/8OSD6ur3Mjh3ygeE7njqjIsGBkylGr/qJvduJV?=
 =?us-ascii?Q?vHMkRTeRPRXj04t9HiPcP6Ckm1DHCaYxZ6GghCjuh28OnpGgQXo83su55ZGA?=
 =?us-ascii?Q?ubWdSeMv4d6FGUjhkDA1An5k4VwYnbHE03i7clmQdSqn+wrDJHS7M9vklcKt?=
 =?us-ascii?Q?nvE8sZ0AgnZ0in9PCgMLU3F9OoH5WU9ZVMhuuOrczTe8ubK5SzwvVEMqIWOb?=
 =?us-ascii?Q?4jzfNOacBvvNzXxjVj8o59OJBC6yza7Zi6FH186HOo2SYucmxlGu1qnOdu+y?=
 =?us-ascii?Q?7HXEyoptgplNfUrgtJUyUJo6SMvTeHrO7VNyepOFjn4zUJUahSXBhHsCVVj1?=
 =?us-ascii?Q?6vQajNso53dmEZCw34PgF6zizws1ADWes8tjzaa01DpmAeA4cG2qvW2U5y1f?=
 =?us-ascii?Q?Eu3HPks5K8+faEShTvNDrdZREhvgnYDgaCuGG5BbgIZdgNXKpsyTV7cQcKKz?=
 =?us-ascii?Q?yiLgwAW3XQ5qswvG7GAm5mIyrkmpVe5/5+lQlCYa2/xt3LQqfjogIarZZecw?=
 =?us-ascii?Q?lIRFzIvZ+BEZauHnwCTPC+WBu39ZfNA9cPrh4Yi5TArdwvgz5Lxn49Rvj9U0?=
 =?us-ascii?Q?DR31jjt1ufpN7CTAMM/4+tZ9ovtEU2/nJ/6i0SrfgezZY7PUJUOhdOjR9oLL?=
 =?us-ascii?Q?Zzi7ao1DKtAMPaiv8VTCfMM5ydqfEm1h/sGTbLEY7Uxe6ws+vWC/I0h3dX0T?=
 =?us-ascii?Q?805pC27PjhnPaggGTHw6UyWdTfpyUjek/jnAv8n9aBpNQ6RjSKmdwlsNIFVR?=
 =?us-ascii?Q?LJh89So8MTEpSw+7mw6n/489Rt8N+yTRkIZyBGhjym8iDVY0rMwHvRWqohJJ?=
 =?us-ascii?Q?2zzNho5YBZP/Yq7k0DMv/o2TqcowiRnWmjrF4TDwBPKS8fdCEJtrllRbCQX0?=
 =?us-ascii?Q?i90zmrEz43dv38a9Vybt5Sx8kRUwhRHYZ1PyTnu49DOAQWTc7FZ+nZtGwp12?=
 =?us-ascii?Q?/6xozHl0GdcMDGJ2hPzk3xPwCVNT/PvJ87RLpsdcpdWV4QpHFbOp5hfc84Ki?=
 =?us-ascii?Q?mt4ElTSesZYSJQOv0fnxuF5orBXwYtZqHIJ4jpB+OEF2dLJYTk1WIQ9xvfkv?=
 =?us-ascii?Q?pQA7RPt/vVgE6Fhr6aY35nngb55Z0+whcHRTMsujiGLC8eieNyHbGq7S9oRU?=
 =?us-ascii?Q?TzmCTay/o1kRijHIVgBedslicjYgbKEoqCGDd5g0ks3pz2mrEbifQrtN6mmi?=
 =?us-ascii?Q?aHFMd1Z0YvG/Sy5V8C6CHk6SOH9mQR6WLzsvnetYjo/H3w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7mcou/I7fpMe/8lR64pnt/M/+kqkvaDpnwxtVfvGQhN28bwdbdTFZj2eOTt5?=
 =?us-ascii?Q?FLGk/Du8qUws+5F0AE5QUTsVUMT/IQdQdSYPselBhdCsb8MMCSGo9C5OFwHF?=
 =?us-ascii?Q?0q2cElin8qcjluknIpb17SuG6rqDG9kwnn9oDVJUDQCHmx7chXcDV68HrEAp?=
 =?us-ascii?Q?B36lVv64Fz0rz4YWmc0StftNOpGLEshGV+Z+iORpePXEzBEmSmhrjhwN8Z2u?=
 =?us-ascii?Q?Ks246UzN/DD5d4GOCbvxQrmAGHG/VY5CGKNMDK06dyZ77rxjQe56yKMqVMJP?=
 =?us-ascii?Q?GRlwMPR/jeYjkiPhmOjYgGYHZlQtDUJinndEBT9gWX1X0176uzDYqhInAXLZ?=
 =?us-ascii?Q?WJ6RjIa1fDuLVPdhHMoR4ZKYBzyYsgolFs3WA7ikjNHddGVwn0Ji2GjNElgy?=
 =?us-ascii?Q?EurLkQjhjt0SBMciznW0mPcGxbReLZ0rBE32bnBefmRB/2K/vJSBfa9i0PRZ?=
 =?us-ascii?Q?PgnEWdwrPTNfns21J2Pqb/YsOzi6vl+40RMMsOvzKHyVt6BW5pJWWJjzkBC+?=
 =?us-ascii?Q?6nttnoKnL/x+izTse6bN3PaacqvN2uEgkQ7+uRBUPKF/tY85IJu70oP7Z+0b?=
 =?us-ascii?Q?NI4F4Co/x3jqsZeBim/yCuG9JCLtbPfgideW47GIJTqJJDRjSP35iPZQdX2g?=
 =?us-ascii?Q?8ueMaDSxLL+wEpBXMfha2p5LK0gW00UlTGmjq0YrFGOMimdnGUGXiWysPSv/?=
 =?us-ascii?Q?1+wr9ghnuRPqFgz4FwBY6/zBD7oKLAw7eUA+rPvkQBUEoNMgRoOnodUKUXEE?=
 =?us-ascii?Q?qZYazNeTvRVPKFzInt5heASz4W6aC4Py6HralDWMVYSiiobYB/10FeiEbzev?=
 =?us-ascii?Q?th7Sg2X5GKDztl4Ll+2WMzPmekJ4V8/yW79I3QlhgSEECEwXJsWAJKZ3V3cP?=
 =?us-ascii?Q?7aquUsEpoDEfO/oJoNru5zbPysr6w/cCycDSn9he9bohCjIUtz1ydnzG65uU?=
 =?us-ascii?Q?+ggWKFMnWN0jQ+hj/jFe1NUi+uq5EmEzEo78g+QVo8RNM8pM4STYqg0tEF72?=
 =?us-ascii?Q?KX1sMAsCWug1uwmlColPBZ1nlt3+vKENq1XjKWCrtxjgUWSJXI1AxgJkzw1f?=
 =?us-ascii?Q?k4XZkUZeiqWXfRr2GrF5gdSw0nmlHu+XpS89Zr/GyEoZZ75gkX9jBZSYapRF?=
 =?us-ascii?Q?oItTwHNqdh7SWHSqqGvI4kde38BH6qtv8NjWQF2W9tyMjkrJlFbLDF4tJoIM?=
 =?us-ascii?Q?BPPHvY1U3xj14JmQaUe1/gE4K6i6FdhUbB8yIAEMP6cPcqIY10SVl1aEHTCO?=
 =?us-ascii?Q?mFsO8VyIZ8Exyu2LDUxgkZZwGgyHAtmx0WUNFev2a0EKFLa3Ge+AGBxxqSEP?=
 =?us-ascii?Q?uIYe8tXhsnqBXsEYjKfYtH3MLiizSalibksNAwUzrB1Q5/vhmIfnTDTwe2Gn?=
 =?us-ascii?Q?zvdMdResoy87H9CfM6MKR9d56NJlkaxuYidZ8L+3CO5X/h2XFfzFhraDeFUU?=
 =?us-ascii?Q?azWSOpf8pjXSrvZ/XVf1mvxh2NRf9b4b52j1fQyUvz71Z5V3ITzev49xLBXC?=
 =?us-ascii?Q?ojmkMS2xMOFWslkNTq/jX5DMKCkdvBofpJJKGsxcUrjyzDxWtNFm0gRQ4BfQ?=
 =?us-ascii?Q?tmP7qm9WA8E145cvUH/uzrdOgcdEskrkkDEbMSSxvlOPFGmEMcX9q8MjvrP2?=
 =?us-ascii?Q?U89WD3nhfdaVTeZz3rNpASIusFE55xP0ftfjRUWeWrznn3JCWaAgfBMkKeFC?=
 =?us-ascii?Q?gqyxKQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qszHpnfMblV2jeFBzcwG25E1VXTOLrWryaJuFRm806GfaMgGdjMjh8PRzO9KO9tuqa+phA87tavRDwr1XqcfqdX0abARklbB2JDas1DFw/3IYV0MLmO4rjEBAKEXswGAPxhSzZP5GJe9oE5WyJ/5zFg8QpFdNzJdH07mq+JIw6K1MUoXT+e/cpxPQDFk4EmlAkbs+8HohZLk7bNC996UHduy1tGTlJ/6CryR/Db0yMW0RCAFkDg4GVAJ46OqirfZVOChV9snAXCE+AIht3RdKBCMDGZPxN0Xg4YgOK5o9f9a8+rwPYMUegoeYOzs1G8YoHlbgsRzZQscDH1PDK2EaM0IUFaTZ4D46VQ9F+guqUJXm/+E6VKDQngIfCZcOCzFQXKDu4lLgyQSbmqx02m+54ghkmnSTL+gvfMU/zQRPoJy0oo8x77FZTD4BMybSJzov+dItsRYx5tzxhgs6Ef5+MjebtUQ+v1ET9fcg15JCyq71Qo7RYmkL8sYQSPI/4LNcm7aUuOHolcZ0P2rhWNnYShb/c68B9CoBM6+JRnUyPKV8bPKudvNcwmKjFxUE7DH8f6gUTkSm0PSEP2Zg5q612NktHWbgjfzheWHqPmS/Jw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11109ed-342d-42ef-e79b-08dcb5482a86
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:34.2656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lS80txRdFrzMax+0Z7NRVooWlWRur37M+XL6JhKfOW9gx/TCsAG7NRe1wsNZ2eBQtWNqo0Yz0XOTViaeYf18QfqCccZYZDyGLOf0yienoSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050088
X-Proofpoint-ORIG-GUID: TexW1xy0RgNSdvv473OjaKNnUcs34RRw
X-Proofpoint-GUID: TexW1xy0RgNSdvv473OjaKNnUcs34RRw

Add a variety of VMA merge unit tests to assert that the behaviour of VMA
merge is correct at an abstract level and VMAs are merged or not merged as
expected.

These are added intentionally in advance of heavily refactoring the VMA
merge functionality in order that we can compare the test results before
and after the refactoring to ensure that it functions correctly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/vma/vma.c          | 814 +++++++++++++++++++++++++++++++
 tools/testing/vma/vma_internal.h |   4 +-
 2 files changed, 817 insertions(+), 1 deletion(-)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 4416cfa93056..e465dc22e2d0 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -14,6 +14,7 @@
 #include "../../../mm/vma.c"

 const struct vm_operations_struct vma_dummy_vm_ops;
+static struct anon_vma dummy_anon_vma;

 #define ASSERT_TRUE(_expr)						\
 	do {								\
@@ -28,6 +29,7 @@ const struct vm_operations_struct vma_dummy_vm_ops;
 #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
 #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))

+/* Helper function to simply allocate a VMA. */
 static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 					unsigned long start,
 					unsigned long end,
@@ -47,6 +49,115 @@ static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 	return ret;
 }

+/* Helper function to allocate a VMA and link it to the tree. */
+static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
+						 unsigned long start,
+						 unsigned long end,
+						 pgoff_t pgoff,
+						 vm_flags_t flags)
+{
+	struct vm_area_struct *vma = alloc_vma(mm, start, end, pgoff, flags);
+
+	if (vma == NULL)
+		return NULL;
+
+	if (vma_link(mm, vma)) {
+		vm_area_free(vma);
+		return NULL;
+	}
+
+	/*
+	 * Reset this counter which we use to track whether writes have
+	 * begun. Linking to the tree will have caused this to be incremented,
+	 * which means we will get a false positive otherwise.
+	 */
+	vma->vm_lock_seq = -1;
+
+	return vma;
+}
+
+/*
+ * Helper function to reset merge state the associated VMA iterator to a
+ * specified new range.
+ */
+static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
+			  unsigned long end, pgoff_t pgoff, vm_flags_t flags)
+{
+	vma_iter_set(vmg->vmi, start);
+
+	vmg->prev = NULL;
+	vmg->next = NULL;
+	vmg->vma = NULL;
+
+	vmg->start = start;
+	vmg->end = end;
+	vmg->pgoff = pgoff;
+	vmg->flags = flags;
+}
+
+/*
+ * Helper function to try to merge a new VMA.
+ *
+ * Update vmg and the iterator for it and try to merge, otherwise allocate a new
+ * VMA, link it to the maple tree and return it.
+ */
+static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
+						struct vma_merge_struct *vmg,
+						unsigned long start, unsigned long end,
+						pgoff_t pgoff, vm_flags_t flags,
+						bool *was_merged)
+{
+	struct vm_area_struct *merged;
+
+	vmg_set_range(vmg, start, end, pgoff, flags);
+
+	merged = vma_merge_new_vma(vmg);
+	if (merged) {
+		*was_merged = true;
+		return merged;
+	}
+
+	*was_merged = false;
+	return alloc_and_link_vma(mm, start, end, pgoff, flags);
+}
+
+/*
+ * Helper function to remove all VMAs and destroy the maple tree associated with
+ * a virtual address space. Returns a count of VMAs in the tree.
+ */
+static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
+{
+	struct vm_area_struct *vma;
+	int count = 0;
+
+	vma_iter_set(vmi, 0);
+	for_each_vma(*vmi, vma) {
+		vm_area_free(vma);
+		count++;
+	}
+
+	mtree_destroy(&mm->mm_mt);
+	mm->map_count = 0;
+	return count;
+}
+
+/* Helper function to determine if VMA has had vma_start_write() performed. */
+static bool vma_write_started(struct vm_area_struct *vma)
+{
+	int seq = vma->vm_lock_seq;
+
+	/* We reset after each check. */
+	vma->vm_lock_seq = -1;
+
+	/* The vma_start_write() stub simply increments this value. */
+	return seq > -1;
+}
+
+/* Helper function providing a dummy vm_ops->close() method.*/
+static void dummy_close(struct vm_area_struct *)
+{
+}
+
 static bool test_simple_merge(void)
 {
 	struct vm_area_struct *vma;
@@ -196,6 +307,702 @@ static bool test_simple_shrink(void)
 	return true;
 }

+static bool test_vma_merge_new_vma(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain_a = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain_b = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain_c = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain_d = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	int count;
+	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
+	bool merged;
+
+	/*
+	 * 0123456789abc
+	 * AA B       CC
+	 */
+	vma_a = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
+	ASSERT_NE(vma_a, NULL);
+	/* We give each VMA a single avc so we can test anon_vma duplication. */
+	INIT_LIST_HEAD(&vma_a->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain_a.same_vma, &vma_a->anon_vma_chain);
+
+	vma_b = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, flags);
+	ASSERT_NE(vma_b, NULL);
+	INIT_LIST_HEAD(&vma_b->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain_b.same_vma, &vma_b->anon_vma_chain);
+
+	vma_c = alloc_and_link_vma(&mm, 0xb000, 0xc000, 0xb, flags);
+	ASSERT_NE(vma_c, NULL);
+	INIT_LIST_HEAD(&vma_c->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain_c.same_vma, &vma_c->anon_vma_chain);
+
+	/*
+	 * NO merge.
+	 *
+	 * 0123456789abc
+	 * AA B   **  CC
+	 */
+	vma_d = try_merge_new_vma(&mm, &vmg, 0x7000, 0x9000, 7, flags, &merged);
+	ASSERT_NE(vma_d, NULL);
+	INIT_LIST_HEAD(&vma_d->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain_d.same_vma, &vma_d->anon_vma_chain);
+	ASSERT_FALSE(merged);
+	ASSERT_EQ(mm.map_count, 4);
+
+	/*
+	 * Merge BOTH sides.
+	 *
+	 * 0123456789abc
+	 * AA*B   DD  CC
+	 */
+	vma_b->anon_vma = &dummy_anon_vma;
+	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, flags, &merged);
+	ASSERT_EQ(vma, vma_a);
+	/* Merge with A, delete B. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x4000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 3);
+
+	/*
+	 * Merge to PREVIOUS VMA.
+	 *
+	 * 0123456789abc
+	 * AAAA*  DD  CC
+	 */
+	vma = try_merge_new_vma(&mm, &vmg, 0x4000, 0x5000, 4, flags, &merged);
+	ASSERT_EQ(vma, vma_a);
+	/* Extend A. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x5000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 3);
+
+	/*
+	 * Merge to NEXT VMA.
+	 *
+	 * 0123456789abc
+	 * AAAAA *DD  CC
+	 */
+	vma_d->anon_vma = &dummy_anon_vma;
+	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, flags, &merged);
+	ASSERT_EQ(vma, vma_d);
+	/* Prepend. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0x6000);
+	ASSERT_EQ(vma->vm_end, 0x9000);
+	ASSERT_EQ(vma->vm_pgoff, 6);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 3);
+
+	/*
+	 * Merge BOTH sides.
+	 *
+	 * 0123456789abc
+	 * AAAAA*DDD  CC
+	 */
+	vma = try_merge_new_vma(&mm, &vmg, 0x5000, 0x6000, 5, flags, &merged);
+	ASSERT_EQ(vma, vma_a);
+	/* Merge with A, delete D. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x9000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 2);
+
+	/*
+	 * Merge to NEXT VMA.
+	 *
+	 * 0123456789abc
+	 * AAAAAAAAA *CC
+	 */
+	vma_c->anon_vma = &dummy_anon_vma;
+	vma = try_merge_new_vma(&mm, &vmg, 0xa000, 0xb000, 0xa, flags, &merged);
+	ASSERT_EQ(vma, vma_c);
+	/* Prepend C. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0xa000);
+	ASSERT_EQ(vma->vm_end, 0xc000);
+	ASSERT_EQ(vma->vm_pgoff, 0xa);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 2);
+
+	/*
+	 * Merge BOTH sides.
+	 *
+	 * 0123456789abc
+	 * AAAAAAAAA*CCC
+	 */
+	vma = try_merge_new_vma(&mm, &vmg, 0x9000, 0xa000, 0x9, flags, &merged);
+	ASSERT_EQ(vma, vma_a);
+	/* Extend A and delete C. */
+	ASSERT_TRUE(merged);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0xc000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 1);
+
+	/*
+	 * Final state.
+	 *
+	 * 0123456789abc
+	 * AAAAAAAAAAAAA
+	 */
+
+	count = 0;
+	vma_iter_set(&vmi, 0);
+	for_each_vma(vmi, vma) {
+		ASSERT_NE(vma, NULL);
+		ASSERT_EQ(vma->vm_start, 0);
+		ASSERT_EQ(vma->vm_end, 0xc000);
+		ASSERT_EQ(vma->vm_pgoff, 0);
+		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
+
+		vm_area_free(vma);
+		count++;
+	}
+
+	/* Should only have one VMA left (though freed) after all is done.*/
+	ASSERT_EQ(count, 1);
+
+	mtree_destroy(&mm.mm_mt);
+	return true;
+}
+
+static bool test_vma_merge_special_flags(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+	};
+	vm_flags_t special_flags[] = { VM_IO, VM_DONTEXPAND, VM_PFNMAP, VM_MIXEDMAP };
+	vm_flags_t all_special_flags = 0;
+	int i;
+	struct vm_area_struct *vma_left, *vma;
+
+	/* Make sure there aren't new VM_SPECIAL flags. */
+	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
+		all_special_flags |= special_flags[i];
+	}
+	ASSERT_EQ(all_special_flags, VM_SPECIAL);
+
+	/*
+	 * 01234
+	 * AAA
+	 */
+	vma_left = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	ASSERT_NE(vma_left, NULL);
+
+	/* 1. Set up new VMA with special flag that would otherwise merge. */
+
+	/*
+	 * 01234
+	 * AAA*
+	 *
+	 * This should merge if not for the VM_SPECIAL flag.
+	 */
+	vmg_set_range(&vmg, 0x3000, 0x4000, 3, flags);
+	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
+		vm_flags_t special_flag = special_flags[i];
+
+		vma_left->__vm_flags = flags | special_flag;
+		vmg.flags = flags | special_flag;
+		vma = vma_merge_new_vma(&vmg);
+		ASSERT_EQ(vma, NULL);
+	}
+
+	/* 2. Modify VMA with special flag that would otherwise merge. */
+
+	/*
+	 * 01234
+	 * AAAB
+	 *
+	 * Create a VMA to modify.
+	 */
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, flags);
+	ASSERT_NE(vma, NULL);
+	vmg.vma = vma;
+
+	for (i = 0; i < ARRAY_SIZE(special_flags); i++) {
+		vm_flags_t special_flag = special_flags[i];
+
+		vma_left->__vm_flags = flags | special_flag;
+		vmg.flags = flags | special_flag;
+		vma = vma_merge_modified(&vmg);
+		ASSERT_EQ(vma, NULL);
+	}
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_vma_merge_with_close(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+	};
+	struct vm_operations_struct vm_ops = {};
+	struct vm_area_struct *vma_next =
+		alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, flags);
+	struct vm_area_struct *vma;
+
+	/*
+	 * When we merge VMAs we sometimes have to delete others as part of the
+	 * operation.
+	 *
+	 * Considering the two possible adjacent VMAs to which a VMA can be
+	 * merged:
+	 *
+	 * [ prev ][ vma ][ next ]
+	 *
+	 * In no case will we need to delete prev. If the operation is
+	 * mergeable, then prev will be extended with one or both of vma and
+	 * next deleted.
+	 *
+	 * As a result, during initial mergeability checks, only
+	 * can_vma_merge_before() (which implies the VMA being merged with is
+	 * 'next' as shown above) bothers to check to see whether the next VMA
+	 * has a vm_ops->close() callback that will need to be called when
+	 * removed.
+	 *
+	 * If it does, then we cannot merge as the resources that the close()
+	 * operation potentially clears down are tied only to the existing VMA
+	 * range and we have no way of extending those to the nearly merged one.
+	 *
+	 * We must consider two scenarios:
+	 *
+	 * A.
+	 *
+	 * vm_ops->close:     -       -    !NULL
+	 *                 [ prev ][ vma ][ next ]
+	 *
+	 * Where prev may or may not be present/mergeable.
+	 *
+	 * This is picked up by a specific check in can_vma_merge_before().
+	 *
+	 * B.
+	 *
+	 * vm_ops->close:     -     !NULL
+	 *                 [ prev ][ vma ]
+	 *
+	 * Where prev and vma are present and mergeable.
+	 *
+	 * This is picked up by a specific check in vma_merge_modified().
+	 *
+	 * IMPORTANT NOTE: We make the assumption that the following case:
+	 *
+	 *    -     !NULL   NULL
+	 * [ prev ][ vma ][ next ]
+	 *
+	 * Cannot occur, because vma->vm_ops being the same implies the same
+	 * vma->vm_file, and therefore this would mean that next->vm_ops->close
+	 * would be set too, and thus scenario A would pick this up.
+	 */
+
+	ASSERT_NE(vma_next, NULL);
+
+	/*
+	 * SCENARIO A
+	 *
+	 * 0123
+	 *  *N
+	 */
+
+	/* Make the next VMA have a close() callback. */
+	vm_ops.close = dummy_close;
+	vma_next->vm_ops = (const struct vm_operations_struct *)&vm_ops;
+
+	/* Our proposed VMA has characteristics that would otherwise be merged. */
+	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+
+	/* The next VMA having a close() operator should cause the merge to fail.*/
+	ASSERT_EQ(vma_merge_new_vma(&vmg), NULL);
+
+	/* Now create the VMA so we can merge via modified flags */
+	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, flags);
+	vmg.vma = vma;
+
+	/*
+	 * The VMA being modified in a way that would otherwise merge should
+	 * also fail.
+	 */
+	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
+
+	/* SCENARIO B
+	 *
+	 * 0123
+	 * P*
+	 *
+	 * In order for this scenario to trigger, the VMA currently being
+	 * modified must also have a .close().
+	 */
+
+	/* Reset VMG state. */
+	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+	/*
+	 * Make next unmergeable, and don't let the scenario A check pick this
+	 * up, we want to reproduce scenario B only.
+	 */
+	vma_next->vm_ops = NULL;
+	vma_next->__vm_flags &= ~VM_MAYWRITE;
+	/* Allocate prev. */
+	vmg.prev = alloc_and_link_vma(&mm, 0, 0x1000, 0, flags);
+	/* Assign a vm_ops->close() function to VMA explicitly. */
+	vma->vm_ops = (const struct vm_operations_struct *)&vm_ops;
+	vmg.vma = vma;
+	/* Make sure merge does not occur. */
+	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_vma_merge_modified(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vm_area_struct *vma, *vma_prev, *vma_next;
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+	};
+
+	/*
+	 * Merge right case - partial span.
+	 *
+	 *    <->
+	 * 0123456789
+	 *   VVVVNNN
+	 *            ->
+	 * 0123456789
+	 *   VNNNNNN
+	 */
+	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
+	vmg.vma = vma;
+	vmg.prev = vma;
+	vma->anon_vma = &dummy_anon_vma;
+	ASSERT_EQ(vma_merge_modified(&vmg), vma_next);
+	ASSERT_EQ(vma_next->vm_start, 0x3000);
+	ASSERT_EQ(vma_next->vm_end, 0x9000);
+	ASSERT_EQ(vma_next->vm_pgoff, 3);
+	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma->vm_start, 0x2000);
+	ASSERT_EQ(vma->vm_end, 0x3000);
+	ASSERT_EQ(vma->vm_pgoff, 2);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_TRUE(vma_write_started(vma_next));
+	ASSERT_EQ(mm.map_count, 2);
+
+	/* Clear down and reset. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * Merge right case - full span.
+	 *
+	 *   <-->
+	 * 0123456789
+	 *   VVVVNNN
+	 *            ->
+	 * 0123456789
+	 *   NNNNNNN
+	 */
+	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vmg_set_range(&vmg, 0x2000, 0x6000, 2, flags);
+	vmg.vma = vma;
+	vma->anon_vma = &dummy_anon_vma;
+	ASSERT_EQ(vma_merge_modified(&vmg), vma_next);
+	ASSERT_EQ(vma_next->vm_start, 0x2000);
+	ASSERT_EQ(vma_next->vm_end, 0x9000);
+	ASSERT_EQ(vma_next->vm_pgoff, 2);
+	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma_next));
+	ASSERT_EQ(mm.map_count, 1);
+
+	/* Clear down and reset. We should have deleted vma. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
+
+	/*
+	 * Merge left case - partial span.
+	 *
+	 *    <->
+	 * 0123456789
+	 * PPPVVVV
+	 *            ->
+	 * 0123456789
+	 * PPPPPPV
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+	vma->anon_vma = &dummy_anon_vma;
+
+	ASSERT_EQ(vma_merge_modified(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x6000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_EQ(vma->vm_start, 0x6000);
+	ASSERT_EQ(vma->vm_end, 0x7000);
+	ASSERT_EQ(vma->vm_pgoff, 6);
+	ASSERT_TRUE(vma_write_started(vma_prev));
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 2);
+
+	/* Clear down and reset. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * Merge left case - full span.
+	 *
+	 *    <-->
+	 * 0123456789
+	 * PPPVVVV
+	 *            ->
+	 * 0123456789
+	 * PPPPPPP
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+	vma->anon_vma = &dummy_anon_vma;
+	ASSERT_EQ(vma_merge_modified(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x7000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma_prev));
+	ASSERT_EQ(mm.map_count, 1);
+
+	/* Clear down and reset. We should have deleted vma. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
+
+	/*
+	 * Merge both case.
+	 *
+	 *    <-->
+	 * 0123456789
+	 * PPPVVVVNNN
+	 *             ->
+	 * 0123456789
+	 * PPPPPPPPPP
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
+	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+	vma->anon_vma = &dummy_anon_vma;
+	ASSERT_EQ(vma_merge_modified(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x9000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_write_started(vma_prev));
+	ASSERT_EQ(mm.map_count, 1);
+
+	/* Clear down and reset. We should have deleted prev and next. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
+
+	/*
+	 * Non-merge ranges. vma_merge_modified() assumes that the caller always
+	 * specifies ranges within the input VMA so we need only examine these
+	 * cases.
+	 *
+	 *     -
+	 *      -
+	 *       -
+	 *     <->
+	 *     <>
+	 *      <>
+	 * 0123456789a
+	 * PPPVVVVVNNN
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x8000, 0xa000, 8, flags);
+
+	vmg_set_range(&vmg, 0x4000, 0x5000, 4, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x6000, 0x7000, 6, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x4000, 0x7000, 4, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x4000, 0x6000, 4, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(vma_merge_modified(&vmg), NULL);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
+
+	return true;
+}
+
+static bool test_anon_vma_non_mergeable(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vm_area_struct *vma, *vma_prev, *vma_next;
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain1 = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain2 = {
+		.anon_vma = &dummy_anon_vma,
+	};
+
+	/*
+	 * In the case of vma_merge_modified() merging both left and right VMAs
+	 * but where prev and next have incompatible anon_vma objects, we revert
+	 * to a merge of prev and VMA:
+	 *
+	 *    <-->
+	 * 0123456789
+	 * PPPVVVVNNN
+	 *            ->
+	 * 0123456789
+	 * PPPPPPPNNN
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
+
+	/*
+	 * Give both prev and next single anon_vma_chain fields, so they will
+	 * merge with the NULL vmg->anon_vma.
+	 *
+	 * However, when prev is compared to next, the merge should fail.
+	 */
+
+	INIT_LIST_HEAD(&vma_prev->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain1.same_vma, &vma_prev->anon_vma_chain);
+	ASSERT_TRUE(list_is_singular(&vma_prev->anon_vma_chain));
+	vma_prev->anon_vma = &dummy_anon_vma;
+	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_prev->anon_vma, vma_prev));
+
+	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain2.same_vma, &vma_next->anon_vma_chain);
+	ASSERT_TRUE(list_is_singular(&vma_next->anon_vma_chain));
+	vma_next->anon_vma = (struct anon_vma *)2;
+	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_next->anon_vma, vma_next));
+
+	ASSERT_FALSE(is_mergeable_anon_vma(vma_prev->anon_vma, vma_next->anon_vma, NULL));
+
+	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(vma_merge_modified(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x7000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_TRUE(vma_write_started(vma_prev));
+	ASSERT_FALSE(vma_write_started(vma_next));
+
+	/* Clear down and reset. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * Now consider the new VMA case. This is equivalent, only adding a new
+	 * VMA in a gap between prev and next.
+	 *
+	 *    <-->
+	 * 0123456789
+	 * PPP****NNN
+	 *            ->
+	 * 0123456789
+	 * PPPPPPPNNN
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
+
+	INIT_LIST_HEAD(&vma_prev->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain1.same_vma, &vma_prev->anon_vma_chain);
+	vma_prev->anon_vma = (struct anon_vma *)1;
+
+	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain2.same_vma, &vma_next->anon_vma_chain);
+	vma_next->anon_vma = (struct anon_vma *)2;
+
+	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg.prev = vma_prev;
+
+	ASSERT_EQ(vma_merge_new_vma(&vmg), vma_prev);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x7000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+	ASSERT_TRUE(vma_write_started(vma_prev));
+	ASSERT_FALSE(vma_write_started(vma_next));
+
+	/* Final cleanup. */
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	return true;
+}
+
 int main(void)
 {
 	int num_tests = 0, num_fail = 0;
@@ -211,11 +1018,18 @@ int main(void)
 		}							\
 	} while (0)

+	/* Very simple tests to kick the tyres. */
 	TEST(simple_merge);
 	TEST(simple_modify);
 	TEST(simple_expand);
 	TEST(simple_shrink);

+	TEST(vma_merge_new_vma);
+	TEST(vma_merge_special_flags);
+	TEST(vma_merge_with_close);
+	TEST(vma_merge_modified);
+	TEST(anon_vma_non_mergeable);
+
 #undef TEST

 	printf("%d tests run, %d passed, %d failed.\n",
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 093560e5b2ac..40797a819d3d 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -687,8 +687,10 @@ static inline int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct
 	return 0;
 }

-static inline void vma_start_write(struct vm_area_struct *)
+static inline void vma_start_write(struct vm_area_struct *vma)
 {
+	/* Used to indicate to tests that a write operation has begun. */
+	vma->vm_lock_seq++;
 }

 static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
--
2.45.2

