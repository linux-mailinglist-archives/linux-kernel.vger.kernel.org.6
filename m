Return-Path: <linux-kernel+bounces-351809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A8991657
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08BF1C21DD3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28935148FFC;
	Sat,  5 Oct 2024 11:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P22Qyi7i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oAoM9pOZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486A36B0D
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728127092; cv=fail; b=Su4TLZhRAVC7b4QafvroK7Dfdw6f49x+bbR6zzLdes0np3nTDLQEYZnBEFe5LKj4NKoQXrpkxWrXwgCuyjIeFWnoSY9a675EjHKq4Ay6VV76yykPdlSxhR2VurDWzR057NUSGLRfP7dvxz18khTskaEszDA3imwnA38kBDhIXqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728127092; c=relaxed/simple;
	bh=huFbPRNC8/6LR779LiraKdpaxJWjWRsKHpfeGruw8kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TNHfF+LjOUHi+JEFMnUsnSLvEtRiq65QaRqophMp1x5sF1lfF542dMAYMlyYWWj0nQgq9VKeC72mTA13uyc3i9/f/xA2d2mjqjixEYhcNAm3lBIXab88Y156toF8p4orTnlleJQ9L6q3DOVXqjKsRpkI7nq2H+V4BDxWsH0udwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P22Qyi7i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oAoM9pOZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495AVC5J015316;
	Sat, 5 Oct 2024 11:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=huFbPRNC8/6LR779Li
	raKdpaxJWjWRsKHpfeGruw8kE=; b=P22Qyi7iZBZsO0DJOHl8QaEhdOuenst4C7
	+oMjjAVqT+UY59A3udwVJlE3Ns5vmNvTHcdWOHyEtwCG3AvJLjp71M/M/8TuambY
	TRpccB6+MV8JxAcC5fHvWxx1B3wExA1uacvYtBm6+kgyV2ggoRdpAzJq9b1F9Qvq
	dDE0A8AdUr/LQZj8omOXVxSnLQzTkUf6uNurDZiGC92by98sYbtwE1fCFZHtxaLf
	GIo5Fxsnaoi4vB34ZpzFMDyfEOlBxkfsHNvyNG9/O7h8ql20Mq9fxvNnCMQFh/Lr
	Jya0mDOj+ysudkMoEILyeSN3irKRjyqKsYp+Xse44JEQwkVMLMZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034g79w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 11:17:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 495A9Eq0024127;
	Sat, 5 Oct 2024 11:17:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwagrd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 11:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytB5/NlCVD4AyWuKDW0rGg0M+OtUwAdTZc0rwH7ETN7P4JC+Z1JRisqKsL2la5cESCrrbTMONgAbFZj56QAwAQd8+Lp8HizK5r2gDzTdk5DZShYR9GrSn72P0/Gvhwk8kZKcZa7XN4gc2fdzGHbxxtEo1WzTclPKrW8H/ExrKuN+81CBO02YkrKM4lKm9+msQ0md7Za8oma3aEl17TQXMsYFrcpIWcBTOlcFmW/yXBSG7H3BgcK2fjIZ/gn0EoKkb94doEnnaOBFhgPf8aRz59FVDWQzC4+KJpF8ot6LYToiAdPS4GTNwKR+48x13N6PhRwvGXaCm5sbT2/ftEt9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huFbPRNC8/6LR779LiraKdpaxJWjWRsKHpfeGruw8kE=;
 b=Y6uLJVkX2VMYhruax1Su+KkrGLWPWjVpwUeERed9m2yBEygu3hgT40P+PkyHP0ulIrywJsafkeXLgXU7paomJnG22Hob+tAWlOjrYK75Cge881mpc90FX1fqep2LcXWSDPNpeu9FBX9rER/1E9F5JGu9b5U0bW45oqelZbHZtz8ddAfs5mqnN7os8FHTgQ7ZAWFnrGV1LRs2O6eE1NElXVWwj9qFwKNWiEYA4bba3ZLmXW+w80UoBjhzfCHkaX4fjPmRVrTOb7q7pItvHoChD4OFWxCHFiseDS5StbPPijNGIlWQJyjFsFzoToJzBhAFaHB2qokBZG9x7agFMWr4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huFbPRNC8/6LR779LiraKdpaxJWjWRsKHpfeGruw8kE=;
 b=oAoM9pOZytJvJ9sTv6ZDVGbjvLn1BQP1oLZPZl6zEeZCKJQ+ztDQzNoSUjmBOBhsMkfW/KYqObAILlSA3BrdD6PzxqwCEbtSQ6r2lpYg07Am3v4FaY8cRroEqud/rg5Jau2mbfoOzrLs0Vp1qqg50451PBVNF0rt1zC1zp/rZGE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4598.namprd10.prod.outlook.com (2603:10b6:510:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sat, 5 Oct
 2024 11:17:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 11:17:56 +0000
Date: Sat, 5 Oct 2024 12:17:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: [PATCH hotfix 6.12] maple_tree: correct tree corruption on
 spanning store
Message-ID: <b7eaef5a-016e-46ae-b7e3-2bd16909110e@lucifer.local>
References: <20241005064114.42770-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005064114.42770-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO6P123CA0046.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4598:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f2019e-fc6f-4a0b-4114-08dce52f5cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HjFsUpp8l1uozSzXXVEyQX5g+dMA80POYfqo0s/l3pDf6zfH+KrZNyjr281U?=
 =?us-ascii?Q?5kF+fq9tGY8yMRiWCJPsmUKt7D62YNbBXW2o/+BIngG8vrpGcj20Csq9dsnr?=
 =?us-ascii?Q?L3q/0VeMe3+C6cBHfiXqyJP4OHB+wQKD2oRPTg2IYz4TLDaxhMfA2/0H74uF?=
 =?us-ascii?Q?RLBCzA8VcMMzZ4P5tW6KRyorlDy/Xm9K2Ipm0Ot399zttgUOBg38ILdZ4Uly?=
 =?us-ascii?Q?e+AcTGIBrcoJixsHKJ9BYPB+mjq1WmuFWsiDSNXZl4b8B8PH4PpeyKU2MekE?=
 =?us-ascii?Q?MLCWVXKyLG3eV0SzuVPOrDVWW4LQna85vo3k9Sz/oo93fm+aadGgfCsKEG+w?=
 =?us-ascii?Q?sjHwJXPprw2ETXBALReCcy/8X+TFXlRSlnSXQfTMZPYdnS5iUOn7HrH0oxWu?=
 =?us-ascii?Q?pnKa45Yx7m6kppP3sYxtEIRIw+xxSXohHEcpvYw4yHTq+JiIK32AF4raZsXP?=
 =?us-ascii?Q?2TPyghehj43ixQKvbI8wbnEnZiSyfTb1k/DCmsrzXNvwtZOzEl6Dm/MU8IYp?=
 =?us-ascii?Q?0NYx+OKT4wgZ4TVvRyl5vI5GidsNuPG66ghiKNv4XgoqAIJuz+zWRCK1Jyrq?=
 =?us-ascii?Q?6uUANsIGjuthCCEkQlh7+oJLZkAbisGC6eKi7l4CUJpnhfubo0XhzOzRxW3V?=
 =?us-ascii?Q?+LMP48lNEcHzAmITzonb1tb8Fwf4cIzGQ7ECzjmr0t0kuDkMIy74tjGa5sJM?=
 =?us-ascii?Q?AnEFZQYDp6HYn85JcTPgwgk3jMSGPmMuZSDyv6FEX8g3crcrh8Q6SeJnv5pT?=
 =?us-ascii?Q?vdVO5Ge9Y1OTnIFjuN8chlxfYeeC1cxMmsIhCefSdbSWU/gRSCw+FNxG0wvl?=
 =?us-ascii?Q?VZrRTdmr/zq2ilXLxTcREU8bP5v6QX91gzzXmCkLpRt/G5aSKC3Bd5jSYsOJ?=
 =?us-ascii?Q?KdL25xwuO2n5UTUDnFySdlaWtV4BpQFAkPLYhbAeVq4lk7PT7tha9/226Mhc?=
 =?us-ascii?Q?uuIOZBpucmdSRma5M08lkTAMkU1xrNtAcjP+TZK7Hgmei5z0eesRNcxHGEAL?=
 =?us-ascii?Q?7XonlsWKEu0Q1lKteNxTvAfvG/G2HPl3SyWAdoTJogZfn5vF87Gc0LKxva/O?=
 =?us-ascii?Q?UvIoggHL3AbRm2WI/y4Y4vz/sbUYpGis96uIVmZLnL24y1XG3hYohkan4p3e?=
 =?us-ascii?Q?o5/Srh1Y0S/r2mKzVDeoSHLhajxWWUmMRLCmB0gtHQnCO7qmLqpKERtRxLD0?=
 =?us-ascii?Q?z/TGJLWOwE/aKpmIiEYD8NOgACjQcENyYgJ8k/zwPf2tMW80sY4sn9OyISkc?=
 =?us-ascii?Q?szRboIZTUftdV9A9fCSnEDG9ZhCTtYzWDsCFKyhyag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+t4eQ9Jr0W23xbdbjvT/CYrXtKGx5DTxOal+ucLcpbECibRJGDQdzZTBA6x?=
 =?us-ascii?Q?83VuFTFpTcyXnhvpSYOzm0QSk5rB0GCj6Hb2WqG8yY6APGGwFcAeqrzBz8JE?=
 =?us-ascii?Q?LDw2KCwcqh5jvtO07IUsxGKtzT6Req85xTF76/X2hLgGWpsNBjf/zlMaJadL?=
 =?us-ascii?Q?Y1q9Ml8RUF9xf9ezU+JEz9D4t/+Fpsmd8nBA+WIjYWxKjYHuXqItQNndpFcT?=
 =?us-ascii?Q?3okuzwO0DeZ2f4h96KrCfxzFiYUQy/UZcGUG7dPWtpMkdsz5n88eDyOqEBFk?=
 =?us-ascii?Q?OLbOGWTbXM+knQ6I5vb0efnN5xoIEJAfDwakgXP0IEr+S0FrfsKZKqw4izOY?=
 =?us-ascii?Q?dce/2ZhYhmqR5mwl+ituV4wDu6+ZJ/dpC3nkucnBx71AFx3lAbn6cpF4f7pP?=
 =?us-ascii?Q?0f2KSNB2nRlf2iXsVYmWQRDPj2LaYxfeH/bfvNpAnlI7k3tIJFWxHt7FFFT0?=
 =?us-ascii?Q?XV0nto1y0TnHl8FG+J2wvq/TcYXfr+YvPzriFidUSVd9GR6BVnA1oTUqcDR4?=
 =?us-ascii?Q?TpqoVkg0lyWDrLm9pZKpBGA36SwRBBprI8nSHB3jkKU0OBkZgip1nrNu8G2n?=
 =?us-ascii?Q?PQt4uxP46zYIN1fkT91HEM8vsMUamJDb6Sqj4UanwJnC/O+0Roj8aKviMDZa?=
 =?us-ascii?Q?i8xUVAZX/vTX/aHTZAySvJaGW/KcVVt7vDhtm1KxRKxjzPA50Ft4LwTLw33N?=
 =?us-ascii?Q?yyJIE5GohN0cGtVE0gTGKgN0ZqlduuJzRBq09N3S9ppQ6GPMHJFgUW7giXA2?=
 =?us-ascii?Q?xxoQ6vlXRxYcNHg4lrcv7Xs8xtsV4Yk3jQeIa8P9BQdtENLaCFex0fJckwMy?=
 =?us-ascii?Q?B2Do5dnszJAoW0IWiWTBnPBomh4xVr00OJ1OhxXYZpkz1rY+Bnosn2zYDBDs?=
 =?us-ascii?Q?Wt5KToRNUK1KQ+1T1IADWLHcIhWJmjUdNp1VUIbh84RV8FGwT+Y1lbEF/P6O?=
 =?us-ascii?Q?s65BHDBSHGdEwPntHBjq58xRFzMBTq9pHan2MItvoVNOlaywoRi7C+VJUqIx?=
 =?us-ascii?Q?M9Xtc3VwQTUQg1OWKzeUNhEh3moPJxBLGh6lVrkE0XU/IcWglakWB9R135D+?=
 =?us-ascii?Q?E9qx4oPPsFF2oaQIUK3frXw+jyFXoow6xuh7QCDi5aCcjlb+uJLCOfMoy8aw?=
 =?us-ascii?Q?cq7CMQSnoma05jhH+WoSg+hmcj2pCZZFbFtP271azVj9kTX4FsQ+gd7myalI?=
 =?us-ascii?Q?qta6fRFPdO99vPnpangFx6LUS7U+0nLMLZVOwJ1+o9phHwbDO+pDwmP1KCZH?=
 =?us-ascii?Q?+EmCspoxsb0dsoLOpwGUUkFxUfxvULNa0m3hR8z/8jU8szdU3/lsZOGixTjR?=
 =?us-ascii?Q?VpCuyK+FR2wXLJhjEL11OmRWc0lBSI4GBA92sAWo288Zcx9dW4eAe+wdK0uo?=
 =?us-ascii?Q?6+wxEanS8B5Bxl61pdtg+eObX0/BGActwrycRT33EvRdzDrYlKtd8FJDc2D/?=
 =?us-ascii?Q?pbOHAXIMoqPUoqqUz1bg5RJu14mr19mSqvWJEpWqHb0IrXTXddJN9yDzQTmt?=
 =?us-ascii?Q?p1ry3cI+SzwJHVUSmPhZsWt4ntrkNV3g1PaNA5pDXd7/iyHs3DLuBN8F6gZB?=
 =?us-ascii?Q?NYraInXRVzReT0pgeLCEcvbGwPcwtPatZ1GoZ7vyAcqC31vuk+wvS3bHGq/W?=
 =?us-ascii?Q?VxEZ/w+WFlZHhgF1JoIvCt3wia9RNfmHGoLT6WzMuQvcSrG+KYPii1Nap/Dr?=
 =?us-ascii?Q?PW76OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BjgvDFFnYwAvxavIfb9VRzbDOXsFYHdeBQzKKR5KvQnHycJ7M3vuPhqyPRCgRA0/ejfPTNe8ynQ/aYifyflGty1ApXlaIat5efVSMzK0mlnXf3v3YPtSDmUB4SyTkWTS11Iqmc34Xr/jyBd9n/ATeAreXkWSUiwurjf1y5hRRfG8c8jfDAZxhkWHYivsasER/zL9XUNMPDiCR0LeAvNgc/aJQHDPCRLwFs8HeGL74jn5q9kVuLk8Tyxzn6zD0mujpqVeeOUPysxsH08artJNtfePNjT2XFFChjvCq2AffvmPVIHOT8zHglMjklUZvr74oYbAEvQe649vDYSDSaf+gsNMJcfAAmtZ89/aGLLDGFDeNYEqe/uCGpM5Pa3Ndk0B1AY6R+CpdqR160qtzW6qek3T2meYUv1nHfr2ScMW1TmkN4gfaeCajuGlCYUv2kyX8WPUKbX8yZgB3RJWBm/KnRfg0RA0PrtgT7Kbq0cjOj6D14QFzaY0Yp598HXKUhEcxFXHTKidmPUi0piYqiI0WMJHLFR3TetE/EqWlUut7h72rblHrou49oSyQ35sXvwNsM7Hw70yIoyAWLokDSF4c1t6NnnXKq0Eu9tygEn7U2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f2019e-fc6f-4a0b-4114-08dce52f5cad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 11:17:56.1556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IJLnIFvzY1ED9VWayz21s8ah6ZNz3hMP7aKxQOXu1U79Cwc+Z+tHfyQqBVj7M/In7zgslVU9nYWf/H9UTIoXDCeFCCc1rW3iLwlAKjW130=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_09,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410050078
X-Proofpoint-GUID: 77M_1Nk5Y8QRBFpu0w_IKLZno0fQHQdk
X-Proofpoint-ORIG-GUID: 77M_1Nk5Y8QRBFpu0w_IKLZno0fQHQdk

On Sat, Oct 05, 2024 at 07:41:14AM +0100, Lorenzo Stoakes wrote:
> Writing a data range into a maple tree may involve overwriting a number of
> existing entries that span across more than one node. Doing so invokes a
> 'spanning' store.
>

[snip]

Andrew - just to note that I have intentionally left stable off this, in
order that wre can allow this to stabilise in the 6.12 release candidates.

Up until 6.12 this bug seemed much harder to hit, and as far as I'm aware
we've never had a bug report for it prior to this.

I am confident in the patch for 6.12 as all of the (_numerous_) maple tree
userland tests pass and the kernel is stable with it, but as this is a
such a subtle algorithmic change I think we should be cautious.

As soon as things settle down I will ping stable to get it backported.

Thanks!

