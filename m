Return-Path: <linux-kernel+bounces-309300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF859668B2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E78B28493B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816B81BBBF3;
	Fri, 30 Aug 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GWuQZg1f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SDVF6KYz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1743DBB6
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041446; cv=fail; b=QK/+dT5AzFWevfwbXWarMI5skTUwQhnJYNMzUzav6p2uXRIRJ0TPwts38kf8KHbvX4uskN52OqLuCzKNoimATpHIwWJ2qZs+HCyMJHtWEqdM2Gx9oGO0kOkRYhKS6ml2IcTw9Ajy6K6TIgHjGIXhY3Lzrfusr2TzMrOPf4Vvlk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041446; c=relaxed/simple;
	bh=d29p+GNGWxOiMyjllBMdLx53TUZd9INAqurOujOoeLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BP9LRocMAkcsPEzA11dpAQ56xE0miqn6EmUhjeRCvliRt1W+rzTmOZlEeDra3gfuWE4oQER2ubINPg7EIn3WJFppgtf1AKnJBR1Psm/NJp+d/QTB+/rnsB5t2+87P5R3pogN64EHQ7nq0AjUaL/QgGkv5Q8tzFJyTbPVGGybx5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GWuQZg1f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SDVF6KYz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI0U2q009303;
	Fri, 30 Aug 2024 18:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=NTZwZTOmB+O5Qz9U31DBMLehGh0zPlWPYaDyzTnldiM=; b=
	GWuQZg1fBJ0KXWGfqhp7LOQEJV9p5hMsI02YvnAWvGobspLJ+zsaAkSwCSJNJUdM
	lq2a8MnqXb2zxCUTXZ9XywbHxt0pi9h3g2djTzuv4WPmBPmFqTSTRsQYv0RtHbqf
	Ev6ZibHCG86crQ2uDxjsG1d/ZjDUp+2IPRp17XBV4jy9icWn+mXD0v7gmmCERp+d
	+i2/hRcgTJL8c6utUxlrFqcPAgprYwFgT8POck4NEFNM+SJ+uM4BRFO6wPxwZulV
	18Dhf66hDj6WvC+7ZT8ouEwGXQxdqoHWT69DZvkQQrsyJhwZ1BJZFURDBGzmLiCt
	QnHdO1nHF7GqLNDuqf+ZrA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bfgj8gw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UGWAK6010532;
	Fri, 30 Aug 2024 18:10:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894sbvk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/bDVBSTqJzGSk292HK1Um/6uGb/WNnzqiQxZxfXjf5JuI+m41BOGgfDq+uWVrY+Aj7pbSOQiaoQN87/RA4m4Dbcdoc+syUWHm5qGw9BxIIRmcmrIhUV/QEuN13txJbifIgVP9+ZMEdVJpbVDxCPMdcfw8R3ST9wAofxXc7Kh8opy5pArbwrek+k6DZxlgHKEGwpe31OROiMCwd5flxkTkwEiTG2tITf5zm7lPpmqUvoGbZNQrFzbnsk1hlZV2Q+HJXQtgrD9xtb4qHZKl/yRn9mOGjJKAtHzw747DptbTaAUtelkGPRkDXOaPCabYUvdSmZwp+67dKP33R57YCdZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTZwZTOmB+O5Qz9U31DBMLehGh0zPlWPYaDyzTnldiM=;
 b=WKHcW/fOx7Sqz+0BdpECIzUMFCJ3z2DCyt9vlyVXeGS0mIk0NQXVLkhgvbz2uGqsKZ5BPgI9SA3++6HA/tN4K2UeCbfdt0+wFa5xOOJR5NsKEgPppBr4CERJjxFtZiUf2TXNqpo0RvYkfCX4TLCX+QidaD9/jTswR4yCXIVZUfYquqcUJdK6bjkAIjLnavEPP1LkwkCijNQSaaB+GwkV0EhkOZ0loQ1tu9sAVwjo47fIO1/wi1MtzxNGtCsENiYSvO6Tgxpz5ntlowNlIrTku2Cx78Zq4520j1a1aIH43mMkfu9+aVhstLOLbIUCCjdyc73kqpqOeue9LNApa6ceLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTZwZTOmB+O5Qz9U31DBMLehGh0zPlWPYaDyzTnldiM=;
 b=SDVF6KYzFj9wQXi5mGzE6PEow/InUVxyegzFy2JHQigdByVhFtA8hdsolhudqEKo4TgVwi8dCVbIyN4GVb2umqEUaqDahJ1R+HyHesAW7IITO+ZavrhhL2P7U+H6/QUpOx8eudQbHqvKE94E1e+F7J4hAIgSag4jfxitr2JWAeM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7151.namprd10.prod.outlook.com (2603:10b6:8:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:10:30 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 01/10] tools: improve vma test Makefile
Date: Fri, 30 Aug 2024 19:10:13 +0100
Message-ID: <e3ea58f08364ae5432c9a074de0195a7c7e0b04a.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
References: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dfe91f-530e-48fa-ccfd-08dcc91f087f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rzgXzDHoYYUdsbqKWbEHaUGgSRiG7hASf6DdtFKXZh4n7dP3KVaJiSDOh7Jo?=
 =?us-ascii?Q?sMgkpKkC3Tx4XjZ2d3MY3iyiCfEmdgPmo3596etqRYpcwnvl+LZvuGoB8joW?=
 =?us-ascii?Q?riz/WhH56vciA37AgMAsVk9QvdP0hnIA2YJyOagQuARSxKq+HAqZx81GPYBh?=
 =?us-ascii?Q?95GAqdPF/tKYgtSE8DkWowRdPzySdlciCipQcXDze3JVpcvMMuWv6hFwlJpK?=
 =?us-ascii?Q?bKhlzhqFQ0ICNvqbvEB5FXwUjw/m/g40sSf/nmrMAmNcTQxW42b5cVI2hs9X?=
 =?us-ascii?Q?VjnLqiBrfKVOHjnCt2Ux/YpF+nhlwZRmjBRuNsZTbui8xie0/s/EqwGwfgcN?=
 =?us-ascii?Q?WDKYLZ/8w4IllI0luzry4DfCGaFiHcp3+Svm2VTjh6SYVjbEQXz/ZXA4AtTD?=
 =?us-ascii?Q?lrp66iScqYjv6sbhx5onaxosxsPU+FClkaqkpuhJqHj8OGH3h4y/tiYj97E7?=
 =?us-ascii?Q?58qLOgyyc8yA1uN3an4K6+6t8Hq3iVq6NZIUpzFxiis2EiOrAT30IaUZ9eGG?=
 =?us-ascii?Q?T+Bak7TK8v6RMXb6ojCarItC4s+a2zvWkZw1fSIn+W6wpn5krgP1Fja+w+S+?=
 =?us-ascii?Q?HFofU5jMDk4PUymoicSbuUNYnzddyP076a5lCe4/b3GpHj6y1Z16A/8lfjLO?=
 =?us-ascii?Q?C0flyU3BzCbZErp/taVfqBje5uV9SItPgnBR1xuXzTYQ1IO6E5RMqGqUZetN?=
 =?us-ascii?Q?IEwHyrsHjSPx0CXdB8VaMu2Vxi8H2oP9OmK8dKzsZa1W7lm2LGlRXZqODirt?=
 =?us-ascii?Q?S5ZwStWPv6J83T6twE6QMzlLSFCZ0ZMrk8lQJV6rgfpNnPX+P43SfcawmsDT?=
 =?us-ascii?Q?Qpvo9SO8q8n2Qk1gPJ3AqQ4XXiNxYIjh3wgL37uCYu6pUQ7O27FJ1CwHuSdq?=
 =?us-ascii?Q?4K0vLTW8VqrUFvgMfIUL2hC3gnqnDwq75APt137m9Cyg/n/um1taghXLXra6?=
 =?us-ascii?Q?8pjCKlTD50UNjy7rVFnBDRJLGhBSRjHTPdAQS7b/8w7d88hcgG87Js9AKkhZ?=
 =?us-ascii?Q?+9OvQxztke9yeCfxxcWd0yBULArXST7mapwFyYlPdMdkh5HYhOZP+Gn2Sr1t?=
 =?us-ascii?Q?C8V+sVQb4D+OOcRD2VCvlwaZLKd05LKjjjy7zjiCbX2YpCNcRX0ClPsPPOqI?=
 =?us-ascii?Q?GQhifm/vJBNjtRuvkX3vXBCYiCij5AVXcZPRnkcPfOb961iebD0uzp/5ido7?=
 =?us-ascii?Q?+WKxrKvX1h9qzgxAiiPr+ISwoks6efYN/6dXE6a+OwAY+m9MJ1yJg7L/DT9Q?=
 =?us-ascii?Q?c/vBySiNsaaL0yt6vUp9eCuDSum0ewJlgfo0vKecqg5cEMXPMTxSLae/HHNU?=
 =?us-ascii?Q?reWXviAO30CoLtOFkdHMOrLYlfwUNuxaCrTto6eFi03RFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ze/G9qpQZocI6IzBYf50aI0JPK+j2yO10qNYNxLKSjdURmW2mVyVY7U4IP74?=
 =?us-ascii?Q?+nwzbjSorAkQNLK5E76v0dJPjbc8YAhVQVLNuqHFZTEOWAAVRelLL9Tq8Qyp?=
 =?us-ascii?Q?QCXVSftVNMQdLBu0w+lOp8/YAM+UiXLSZmH+Q+hRxsjlEoJ7TmpjSeIdd3+7?=
 =?us-ascii?Q?N91joQrGRbdwV05z4ZFxwuiCAFZMvXylsVIDrWfPoTaJYFJiuttSH905UWgn?=
 =?us-ascii?Q?0yuwmnSpiqpyy5k1KdJYEVkzyGkz4Od9L244yLSyiq9bi6cd0GyIosZGhZpq?=
 =?us-ascii?Q?+gL/Uk1alf2O0b1yjsSdoYdioKghvKC2clWtVn0z557Pq47DdTIoCJ8490ef?=
 =?us-ascii?Q?OJCvDkb5J5wpN5KG0CcUGh60P1k9iwNrhi+mGkY4PYXtT5gsJ0fC4RVtS1oH?=
 =?us-ascii?Q?5zzDGfMUOEWuBegAZ0npmr/3J8B21Km2mLx8i+5+tJoupOhPRLGgI+xZGiCG?=
 =?us-ascii?Q?zb5sYOc1lECAvVENLx1nXcGAlMmoUzGYByDU6WVLYZBe8qxvFqV7fai6xpVy?=
 =?us-ascii?Q?62sTafbmkRKL+7Cxdmv04OA+35TwFEO8cQ8/VnbR/hL+udM1FuX8f3SmaN2e?=
 =?us-ascii?Q?aB77fgVVt+9q1drvvQNtnDLyradIQnth7bade9IZdqpUFw/+JTweGYf7hKVE?=
 =?us-ascii?Q?Ou7+ZfBGmgigFWxn01yrJZyQBMUfdjXS6hWMdmT4vGbX9Ble4wE/bha05EGC?=
 =?us-ascii?Q?VIhua5hfXKtIflpRIVAI1HsT56W5BaRilxHAhDf5flk0Ty1ovTUtP+yfQZxh?=
 =?us-ascii?Q?t029M+1oo4gfdP2OVDXAb+85ES8dcxMfh2BZ/wUa7QpjH2Ho8EsuiVZIEKM4?=
 =?us-ascii?Q?vQkHXOkeWB2czJakTDf8hRM6Xk9FuV6e7+iiV7VRxdB6TzNCFFtNq0EbyDVO?=
 =?us-ascii?Q?PjnpLPEqInSUDVKXp2JSNuWDOgG4lZ57pNyWejzWkynDYjokpHaDQA9RjcZi?=
 =?us-ascii?Q?uSjRk3zUXvx/uiV1UbrkVUjtponiexDVvSVN+Ht75n3iz1dQwNskWFvdOZBl?=
 =?us-ascii?Q?2bvOWEdpiwGGjdHsKSYASBDLyNd3PRuNu8aPGK5Qf//JZ0eDu2B9lCb9ovcG?=
 =?us-ascii?Q?ca5TAiXrJYkX8fAsCddVKg7Caj/MtgGTITP9ORy5xTwF3mmEau4rmkmuxtvz?=
 =?us-ascii?Q?WNFIGDr28RqR5LTmN4CgKoRV5oUC8LVz5RpibDzTCYoXTq9qL0f/Y9794QQL?=
 =?us-ascii?Q?UghPnX8/wH5chTChyHwmJQZgant/JdRtRuhAbrIZdswoj8xnRXmbGZ+tabgp?=
 =?us-ascii?Q?IoN4Cre7DWSvG88bnvBQcagE3lkgp/PAAlX+AwyZ6Ihbyadeq+iR2yHmWc9J?=
 =?us-ascii?Q?lNJPtFiBhOaFur7JdM+Ly+DxCaeYvZf8XGx8YlB1xzQFLRylhfLi0sgPpksV?=
 =?us-ascii?Q?ho5Fr0QkXItICqvLLDrHOe7aEaSU8+d4r38l4nWuQ2xJQVNQXwMH1UylodoZ?=
 =?us-ascii?Q?LHccXMRFL+aTOnHdjYcwNvukeD8Pdltq1cMHfeR1xTku0qY2CKqkO7Q9QS2r?=
 =?us-ascii?Q?j7a21XLSIXScWSNupmV8VWIUDglbVCNdHjoOGnuoLAE0ThWC3lMKs4YZ4Pv5?=
 =?us-ascii?Q?6gv8vdw3VmJ7V4sRAQ/4LLU7z6px3j/8ROv5/pZvrUpAhQow/JRXfnZskSfZ?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JoREYi9ZVs/dFYBCBxPYtnSfk3zJu6satODFOUPgLWbM/AoLjqK4GkL/uLfP0PjzsWOoupcLKbjKYQiuaePXVnYZB3d4SKyu6h1vJBlOPFZ6EgkAnTq1jDKPgBX6J8r/gzvFYCWAVBKiiHgFBDgxg2iPRSDgM1E5QhlxbyQBp2gIbTa47ofv2xUiV5ULUjsRnsoK+mflHrJPFltNP1XI0llHap8g96y/4RWRuqTXp9RTuBJ7C0Hkc47tOdvypUCGBeTH8HWzr3JIdhmKumuG9XpG97xmb0InwkA0pBqd7cq/It8TkP5+QguA+5c8gkkSDgZAR1Sk3Ctx8AovIQnLANZ3Po9F3jWXJW5Xn4oCY5HCtlDU5L9qaTFMTG8sao2MT634q/M4mX74Vd2NxBshJVty5GObmnIyOGG9MBlVkYuBRfi04o/GOmbrXAfyk1RpkowsQj5uLowq4hP0ieMvfV1DaXQehKGWyDvhyd7subADdASDg5YRoyEZ60CPEroWtCbkHPkz1WgWzKfHEG7BxCU4aBEbvWeviEP8wLNYagfo25BOh7MjwVpzS/LQ7su/Yz7n3Zoo4H6l5vkY69d37xepN85tbNrMKzO5bFNaY+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dfe91f-530e-48fa-ccfd-08dcc91f087f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:30.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOnxUFZRcQtgbK8ooC8e2tCcrsAtIxpfAXHr0MzBCJq8+Nf/IpE2F2xm5amblrAboQeLNgyK8Gm3y5XhLnkJg3MeAQoQz/eHk3c6JMvQFzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-ORIG-GUID: oaN2HgiJ5x1T6HSqsfmJig9TK6kYLJyi
X-Proofpoint-GUID: oaN2HgiJ5x1T6HSqsfmJig9TK6kYLJyi

Have vma.o depend on its source dependencies explicitly, as previously
these were simply being ignored as existing object files were up to date.

This now correctly re-triggers the build if mm/ source is changed as well
as local source code.

Also set clean as a phony rule.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/vma/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index bfc905d222cf..860fd2311dcc 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-.PHONY: default
+.PHONY: default clean
 
 default: vma
 
@@ -9,7 +9,9 @@ include ../shared/shared.mk
 OFILES = $(SHARED_OFILES) vma.o maple-shim.o
 TARGETS = vma
 
-vma:	$(OFILES) vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
+vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
+
+vma:	$(OFILES)
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
 
 clean:
-- 
2.46.0


