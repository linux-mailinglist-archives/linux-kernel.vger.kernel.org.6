Return-Path: <linux-kernel+bounces-274628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B886D947AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41AFB21A65
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E53156862;
	Mon,  5 Aug 2024 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EldSn5YW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ha6ks3Jq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F614D290
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860069; cv=fail; b=lIzVyhcMsAqeiuXiJZUSI9KOGTVvVdCwzDPAY1U82s+2sES/JWRcc6ZFRmHTayw5CWBRB2d2K/In6Md1vZXqmXsPad4kkxnRvYFjjviqkE61rP7I0AvlpY21qIURpnWc6nOOjfE18rV5Zv81cxm7SRRS2JQquGFxGLdQgD0dtZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860069; c=relaxed/simple;
	bh=waC2NLuZD8iDs+TUHOjhenhKCknQsaJjdh9gr5GuUgg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kKI60dWv98HlMXiAwg4+Dqvcizascox3vUsYd4VtKXfLxLlvBN/ZJXsD4VFFBOYdCF+LkaRgB5G/z6pPcYEeLqKrjn938uE5aau1/QF1XU5CedeQVyLBfjUMmrMsU9h3k7dMhQreanCZM30cJ+sKIiwjI1ZOMsI8QW+UKtQDMaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EldSn5YW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ha6ks3Jq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fb3j027500;
	Mon, 5 Aug 2024 12:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=cmA0sSzWLBBHHP
	YNAAlVaWgReAkK72HcEFMcZn7yt7I=; b=EldSn5YW2qryNcHfiQHRt1qmQafawJ
	rn7bdY+Li4KtUmup8nLgzQ9e37k5MB6yOrTQT3eakGy4ehVbz2ht+BRP3pcSfOD4
	bWH9t/f0SaVSvyx29Ydf0j0t0P8uq5wcv7wi8zUB/Oh5r3HYtc41Eny75mhkM6pL
	JY9E0DZyER7FcvD+SNmhKGfqclT8tqSpyPMM2ZSIviQ2K+6tLHukLHaoEvYXFB/o
	u76k1U0J0tWdP71Z7hTk/Ia1IimW+oFZiw1sVZn9e7OLJRzb03sES8oSTKoMyQt3
	0V5U5gwa8w4gphZIedLQqbi90TOuyrMIxY+o+M3Lb2axOfmChcttR4iQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfajgjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475C9Gb7018638;
	Mon, 5 Aug 2024 12:14:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb076nvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkVsNw+reN5ZXNyY5L5yqSLpXbhlOLxmrSgRS0qfI9Xw7CpEv0Axcaw4FktmJpQ0XYRSWSD6n92O+odbybfOTS8uipAFxVtscI1RPFy5U8RASkgHJ0A0i2rlihd2JFkLErrBArS2g3R3VRMjFBA4/t97I323Roj+8IQ/g0l0yw4KDrd/OeB9Mw2DkUp2zxGVs+6vz1wtj+AGTWp3FdNKpRUnA76KDIDJ/odtSeOKfUpr3rl0PbK79YwxNF2uT7cLpJ+GQyRRYNh0v9UvOvXCMbwfpGAsZFyPWY9A/RWH+btJ9QpAqw9KQ2hsZ0Ou1j6DG5TcsPMuoWeITJHeXQhR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmA0sSzWLBBHHPYNAAlVaWgReAkK72HcEFMcZn7yt7I=;
 b=UbM1vISn6sB4GOV5kknVgXyc4lDfuhVY6wuvLABRILjr7/rJlTdblxkBJ9nau5C7KSuQ3YkQ74Q9PhFNCCX3Vz7ynvTNWzyfaHf0NazEVyZzMtqZ0oHMACXNjOWLnWPtpPtr/njgFXSVXt32s+GWt1b+MIcPnNyT+r5RydaTkG1RkkwpqqPIpaegbtg3mtY7uyC0eMVcIfLSGU6IGzcWEcLjA8c9/H3MaZ6YfVe/GABD4Di3inncTjY61Purg/M5jr/VRVZrVYQVBxkLUPLDLWkfNLjRtA8cDytZMkcJetBtVAwnWdGZq29qu3pd7rPNB4G4RxwaDzYbq6djFE6BwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmA0sSzWLBBHHPYNAAlVaWgReAkK72HcEFMcZn7yt7I=;
 b=Ha6ks3Jq7cUUBqCc7U3ZaEQFtjDSjW/ho15XYCi9vMRwQjvrDqSrkvOrz3luHv5RKkbvsoa67mK8ENx93R6j8NIZZSyCPB2dJaQ5Pmio9+GX+nBarWt/2jCXeIh/0BDdZzMlPuSWVf2kXSL4IGcrKTYpGVpe6DJtixw9CDMKtGI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:14:12 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 00/10] mm: remove vma_merge()
Date: Mon,  5 Aug 2024 13:13:47 +0100
Message-ID: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bac94d2-f467-466c-9b64-08dcb5481e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XCoGV3s/riLjMTkzI9HKu9wyHyX7lsp/wxDKIVuQWQawJpD8By2lf2QFM8el?=
 =?us-ascii?Q?E5nGIf4UDd4OqZ3VPQXwdtHOGoxGCvGqNLUq4qzWCa6Iwcm4BLZ/FSXV78s6?=
 =?us-ascii?Q?tQGtPtBuH55hAyfIXTpqwW0w4cZR90Lq1jY4f2wrelNqnFBtT4yTfxj5s9a+?=
 =?us-ascii?Q?NMGktreDaJ/YBMrNEGNzvIEI1ynKkFQ7x/eenvU3Zy8i3rqA1wBlXsPjfEHp?=
 =?us-ascii?Q?AMpOjh1zDTg1EOc/UEowinzucJcZCkPbhTJ3xEG1MmwBK8M6CpyFY+skq7Ww?=
 =?us-ascii?Q?kKgNRJYZwf5/Ysx/G+jqNH0WHB10ZwV7ciCao4C1bfSIFOwVkoavis6eE3Kk?=
 =?us-ascii?Q?krf/9Vtmd4UicW+7YP7m0LDbYWGKIKBBOPkDWS0x0PTZpvNgS2qzocpJdPlS?=
 =?us-ascii?Q?Tmnh1GVUD2tfm4hrTlzbwm6QxJu7KSwH5Y4wBeJYnytz8C+ZuGbMyXqMEaVw?=
 =?us-ascii?Q?JunK6ZjkEjLoDIhMNE7tgijO8lj79gPwCge7uTs+pzkj5KzNHaSSONaP68UN?=
 =?us-ascii?Q?DM3Mdsjc1m6LsO2BEoyH3OBIGMojA7myNu0trOydI7ffdyHclYUFpls+wnyl?=
 =?us-ascii?Q?tXHIzkGhaNOaDk9SRPFR3Heat1GXOm66hzag4ELXhWl7bHg11Jb+9DRG7bpA?=
 =?us-ascii?Q?MMccaEHwPlsqmBRTIK0HPU3pBTyVMaJndKRHActtnsqwBL1HX3qilDylbHvB?=
 =?us-ascii?Q?Q/Jxb2MOL6C7oc/+nPlToa+NXSAkmXQJnEnvmrI9rm4Q3g2DOye5Go+PNcfr?=
 =?us-ascii?Q?//h2wzG6tkmP10q8zs+nmUJ4L9X93tyfjMpnbO0dUYfpBdoAm+QDtbetjLEP?=
 =?us-ascii?Q?3k086p+cwsMOHzoaYRqWRqXFakTzTQP8tyfCm9G6LmsSeYcfsM3hZxpbhJnl?=
 =?us-ascii?Q?XZzc6I6SDiM7KJekjWzuIoPULvaEMvzTabWVy7y/nVZUcYV9J8zPdroJuhVe?=
 =?us-ascii?Q?ld3t6ToLeH8vn01sFdLjPhaSz0dX+UXvk+vk6uxCKHYEpThN+D1Hwmj962HA?=
 =?us-ascii?Q?ib1Gxmcn2dnKbgTDWdzkKeUCsvauOsjK7AojipxwJdmgc0NYSZdle7BPgO9A?=
 =?us-ascii?Q?e8Ss7CZpHHDzahvPH0dF/kMXQnnh+HtPN1CqP5Nl5BxJkpuvL6t6KeIqy54V?=
 =?us-ascii?Q?cKtsndn+uzXTZK765HqViFzvTzs/glPXW26oKbjr4UPhGH+61hbbFVA/gA1E?=
 =?us-ascii?Q?WS4CZlGESqJWvnbXUz7QSZa2AyeZQr6t0npDB/VIi+Dmiqxvfks/enIeJHwb?=
 =?us-ascii?Q?NYaKiQTj4QJ8ZAkwOMwKuMX/m583JP8DxsDLJzB2Psdl3y25T3how8TdLhAt?=
 =?us-ascii?Q?9u4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ES68WdKMcxFkd0FPwiIIaPKBcSoLpwaYExHru5PFY9aE4h5w3OmjxPswXkeW?=
 =?us-ascii?Q?OLaOKqifEon3MOAbygXn6cTCU+9l3zVFa4tEG2lAaWxyKkkSZ7gOTvp54AvH?=
 =?us-ascii?Q?f3m8zD5wLe62/ZATcHVqdlRXEgutN5iS+s/k9rUlytr8AvCTx6dHCCHgBCGH?=
 =?us-ascii?Q?B7yvYEWy8Xx+DRFErffQM8mYj4DB38OrFqGxuTlwxhjy89EBnoYzMNlGlJU3?=
 =?us-ascii?Q?TYSMqGnY0GI+XBW9jGSKLIi1XU4ajFwNQNX0wnEeQu+rYTsiMWPsYV59+7Uu?=
 =?us-ascii?Q?mIGTS5vQLspbfICXwkUMtLujpf/2gj7KtsflQJyRiwnmlkiuwUs6dGQXmAmA?=
 =?us-ascii?Q?DyZ6gcGVl/Vesi5HX/UYoTpKfCy81j5KINIG7+GQ+5944NflD0FN9HMh9Yb/?=
 =?us-ascii?Q?xT6fvAaUBgiC7srMm/2d4s+S18xDpqHqZrKEZSdtUPAj6YTK0B1kXwgpVyTA?=
 =?us-ascii?Q?+KLvmwVGRhqXDRd3xwIbL2YfEC5doEAkqF6Xe14B2WDRQZ8lj/dSNp7+a3Vu?=
 =?us-ascii?Q?J5rmD0kWWD22k1ROnwZwCnsdoQuEB0DOArbcyj7Ha68Wyn79bNBp67SQISYL?=
 =?us-ascii?Q?bCo0oFdUiNP97+T33KXWSy1hiN1e0PJcQ0cahioDt3jWyOHJbTlA72YJqzPp?=
 =?us-ascii?Q?WEZ/bf5lv5f/MBnYQ8isiA9q9rHwgiwr/0cALUyEVk9prij5f1GhAJyQOK3d?=
 =?us-ascii?Q?SVsqmsTFKqGNpCQM5edAYTUGezUpTpIIY1rIj//193xHK8nklPGuuIRklOXM?=
 =?us-ascii?Q?AQk6EGIIjmqcuWUUC/rFeDm3We5hztM1MuGMVrp10C3NMiAgEpEY6+u6esHr?=
 =?us-ascii?Q?Mm/l0luhY7Dk4CJ0StGNJA0xmp7GC5K3p5Ml4crxesKmEjBLXC7tqWjXI5e0?=
 =?us-ascii?Q?63D+FsdDDIrrgP8tGuNsdDjbCNEmvTiBdjCzMSp12qP+h0QtSFUQlxYtn46d?=
 =?us-ascii?Q?eAaN5LITDfc0sKTtFFKfe2yvL8fIMGQ722HCUth3Ang41ZhrasP1/G4zZoRr?=
 =?us-ascii?Q?v1zWXLDWwkFB7dqahronjhEmhFAc6Wa7czIgfmUmi6DdJeMR+WMw2sLZ4/Mn?=
 =?us-ascii?Q?ZRpbsyt41jyhB7k7j6CN1QBR3qUim5ORmGlLdAt5QDVVavi8po004KiOLRl1?=
 =?us-ascii?Q?dA4f7clRsBv2SOc/X3Moht2a8wWCLflP3cBHSRBz9cAWDCBygVn0NxQt0DGw?=
 =?us-ascii?Q?Ji/Ts3XKQ7DmzXcf/qVifwP09Hi6qY0LMh9UdXh0YSycrbYk716Y7r+QGPc5?=
 =?us-ascii?Q?cncWQNG81+IosKjT92Fg062zUh1WMiQ/zEzfE1i7iw/UKIyPDgQWF851qpEU?=
 =?us-ascii?Q?q/63bszfgfahPhJmp1JH7VpHqLM6yTB/gPu3ESNF1TP36zzOT672arcObqRb?=
 =?us-ascii?Q?WOWOHlNt9GZK4sH8UVeeBrvuq8yfonAguUdiLjYan99SDO4TANyi0//aSz4S?=
 =?us-ascii?Q?ubgQivLj61vJyJSnSBV+dV0WY07AFovPWgHieT5ZbjfkwFKIPhWQZn1Gd9+K?=
 =?us-ascii?Q?RVEa5IjMXbBykcalV1vsc/BEPe4D2KIU5FqqXv9NoEfrnj8sCNM/vWXtnhIZ?=
 =?us-ascii?Q?4bsd+QJkvToartiUNSp4/2e60wC4qKGdKINGd9jYBtC8NaW3bqXDbLXrneBK?=
 =?us-ascii?Q?UviDQtpYDPh39obMD1brm858bmeMnBnd7U4TS6MOEbAmTu7gVVw2HvbJnhMk?=
 =?us-ascii?Q?LxxcXQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g/KUrTL10kc+ujawXv8dzC1f9nPUahps9fCVGc2AkJj/Raeu4GsJE6+0nmvwN12OWt1npPkU4lvrd/uUpswhDgizZHL+sK76KiMORPthII1q2G9i3axoOf8jJkK248DR+j2pd7QUo60O9i8tydNKtirBDU4p0rj5vGUKOHqXekkBMwP7f+LxkdmQaFqrbL2lAtylthS6y6ljxuFp4deINWI61RuPgsoMrRED6pZaLtsMP6ZnXz07yEfVRaptSoLiMTduCu2gu/NNfu/kb71LDmYOx0QpF9eVj5HgyIu5RvhtVpohTux3SYakzYG19u2bx9n7ZUK5++lnXPdGQ9LJ652iHHlATEPiiPC0Pd/TyeXgd8DkCd6YFDvfVMEdBrbeR6qU6XCG1HD0Aqpnsk8gWJAXaRC3/HF9tKvIN28sYd+Q7aM25lXH9lVMMjqpf9yH2bKFHep5IWfupZ459D2aRJ8zleGygJhTwH0sGmLPS+fwumJ4cepI1WNc2KpB4mxceBhX4higAZB4GcMY26Y499XZfEyjebS7BxXGPgEdKF4tXRnh8cmeDa77jecXw+xhnxmArUWGIBCRfMKxJQ2lLnRuVCxOeuQ9wIJP6q3MDTM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bac94d2-f467-466c-9b64-08dcb5481e09
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:12.7416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLHSNHF9Fqb+INKZrjWBg31rsf6E4IsWLXGg8bD2Eoxp7EHyusY6cdWqvO8cdLAIYntjuIxKj4YhVF5EHvLNzeIrf/3xbNjBZi7T/wUF4uc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408050088
X-Proofpoint-GUID: iEdfQxuRDS6F_9_EC3g5f1ssehUAJHJ1
X-Proofpoint-ORIG-GUID: iEdfQxuRDS6F_9_EC3g5f1ssehUAJHJ1

The infamous vma_merge() function has been the cause of a great deal of
pain, bugs and confusion for a very long time.

It is subtle, contains many corner cases, tries to do far too much and is
as a result very fragile.

The fact that the function requires there to be a numbering system to cover
each possible eventuality with references to each in the many branches of
its implementation as to which case you are looking at speaks to all this.

Some of this complexity is inherent - unfortunately there is no getting
away from the need to figure out precisely how to execute the merge,
whether we need to remove VMAs, whether it is safe to do so, what
constitutes a mergeable VMA and so on.

However, a lot of the complexity is not inherent but instead a product of
the function's 'organic' development.

Liam has gone to great lengths to improve the situation as a part of his
maple tree implementation, greatly improving the readability of the code,
and Vlastimil and myself have additionally gone to lengths to try to
improve things further.

However, with the availability of userland VMA testing, it now becomes
possible to perform a rather more significant refactoring while maintaining
confidence in its correct operation.

An attempt was previously made by Vlastimil [0] to eliminate vma_merge(),
however it was rather - brutal - and an astute reader might refer to the
date of that patch for insight as to its intent.

This series instead divides merge operations into two natural kinds -
merges which occur when a NEW vma is being added to the address space, and
merges which occur when a vma is being MODIFIED.

Happily, the vma_expand() function introduced by Liam, which has the
capacity for also deleting a subsequent VMA, covers each of the NEW vma
cases.

By abstracting the actual final commit of changes to a VMA to its own
function, commit_merge() and writing a wrapper around vma_expand() for new
VMA cases vma_merge_new_vma(), we can avoid having to use vma_merge() for
these instances altogether.

By doing so we are also able to then de-duplicate all existing merge logic
in mmap_region() and do_brk_flags() and have everything invoke this new
function, so we universally take the same approach to merging new VMAs.

Having done so, we can then completely rework vma_merge() into
vma_merge_modified() and use this for the instances where a merge is
proposed for a region of an existing VMA.

This function completely reworks vma_merge(), eliminates the numbered cases
and instead divides things into logical cases - merge both, merge left,
merge right (the latter 2 being either partial or full merges).

The code is heavily annotated with ASCII diagrams and greatly simplified in
comparison to the existing vma_merge() function.

Having made this change, we take the opportunity to address an issue with
merging VMAs possessing a vm_ops->close() hook - commit 714965ca8252
("mm/mmap: start distinguishing if vma can be removed in mergeability
test") and commit fc0c8f9089c2 ("mm, mmap: fix vma_merge() case 7 with
vma_ops->close") make efforts to relax how we handle these, making
assumptions about which VMAs might end up deleted (and thus, if possessing
a vm_ops->close() hook, cannot be).

This refactor means we do not need to guess, so instead explicitly only
disallow merge in instances where a VMA with a vm_ops->close() hook would
be deleted (and try a smaller merge in cases where this is possible).

In addition to these changes, we introduce a new vma_merge_struct
abstraction to allow VMA merge state to be threaded through the operation
neatly.

There is heavy unit testing provided for all merge functionality, added
prior to the refactoring, allowing for before/after testing.

The vm_ops->close() change also introduces exhaustive testing to
demonstrate that this functions as expected, and in addition to this the
reproduction code from commit fc0c8f9089c2 ("mm, mmap: fix vma_merge() case
7 with vma_ops->close") was tested and confirmed passing.

[0]: https://lore.kernel.org/linux-mm/20240401192623.18575-2-vbabka@suse.cz/

Lorenzo Stoakes (10):
  tools: improve vma test Makefile
  mm: introduce vma_merge_struct and abstract merge parameters
  mm: abstract duplicated policy comparison
  mm: abstract parameters for vma_expand/shrink()
  mm: abstract vma_merge_new_vma() to use vma_merge_struct
  tools: add VMA merge tests
  mm: avoid using vma_merge() for new VMAs
  mm: introduce commit_merge(), abstracting merge operation
  mm: refactor vma_merge() into modify-only vma_merge_modified()
  mm: rework vm_ops->close() handling on VMA merge

 mm/mmap.c                        |  115 +--
 mm/vma.c                         | 1399 ++++++++++++++++++------------
 mm/vma.h                         |  104 +--
 tools/testing/vma/Makefile       |    6 +-
 tools/testing/vma/vma.c          |  885 ++++++++++++++++++-
 tools/testing/vma/vma_internal.h |   10 +-
 6 files changed, 1799 insertions(+), 720 deletions(-)

--
2.45.2

