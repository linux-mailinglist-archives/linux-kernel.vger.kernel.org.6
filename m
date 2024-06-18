Return-Path: <linux-kernel+bounces-220174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B75590DDC2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48E51F23483
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5546A187356;
	Tue, 18 Jun 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JIGpGgOT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rBFtIlqC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CB178CE7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743729; cv=fail; b=cJFbNUqXb3L1X12PzWd/UKoEo4tonO8dMxJ89vPXhBXC/nWhSPVyJsGClg/cDUFLaKIytzWqbpVz0P8Y0TFMNpe9a2ZZLT9AHIFZDyP/mxWby3fkptz0HbcRCywq4DBKfhVmVdPUOLrCxu9bfJPzk/oeLluzX8Uzt/k3RrZ55u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743729; c=relaxed/simple;
	bh=g+h6bCXS3mCIFD4yRSrInXHNWoHz9Qf4YsG2xfDAdxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qSnxng9s5rrS2pfgEUDbSqDgHuWaM472kG+oc+l22fgdVohJy59573947eykEZ7oMkPxIeFhT6b25RrTjuU52t1sAAOQOnUqzZo3uXYhzG8G/jOyK67wsxSO/IgkyCVpdSx/Uxt9hQSkAgnAaoumYHoW6q/+gnxAOGbYoIfmIz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JIGpGgOT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rBFtIlqC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUskA029791;
	Tue, 18 Jun 2024 20:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=XP1A/eOgqZMUlcJAiPY9f3/4Q3XZGbvXKJ9jT8yEgaw=; b=
	JIGpGgOToHk5TqsBKqvuA39BrY812xcbxW0mUOglbpz4Mt+brlJ0JcaiYMGKHfEE
	Mk+iShgr61A9E3ozq3azP5opMorm9icrwjTNS9Qgp2+tuSMNRlq1smChEMd+MqvL
	0dBz4iLxq1/27hxjfdAIK8qoSf6lU1d7Sncczz4y+Jhnn7793aGfa4+jgyi8L+nc
	ZcmwASlFdKgKyQ8rVMQ93YQefAPWw4KNhJPn5HYQ4Go09RY0F1ZCY6Phs5ySSMM0
	I3Wgt8czMO/udVoOpqKBi1mt/UAzqJrJ8GBStXmH1tH6YpsR/KnuNMjfDfeoPXlX
	FUT+Sa41texVdNhPs3OZ0A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js5tnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJlTIR034656;
	Tue, 18 Jun 2024 20:48:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dey4ud-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NH7X9j0E3CqffwXX+OTU30Bvv/M0DM2SH/aGy1RJjGzrQmZeA3X28k088KIiMe6oc0DbP5NcCvjsF2MCUYsdSmKeVUYZ+eIwIJan/mChMp3zMOeaRfBZeLxuvy0Z1zEqB/LSC4hIPlW+iH2ek4xtmT1SpC+S4iJdlOcYUJJqsY9meLHMOGgnupsGK7eXjsn7kiF61j2CqZqoE2BhrL44vg3CIJ0eEnG1RVdpqgG5ptzZLM0ywFOo9XbhvDaV8p+P6/2qupkhCXFVTrLjitUQUnlrYD1Giv86iNs3lxLpF7l4immxhH5QCDYYdboJxhUsNJF7R3bl/yt3rgTrGp1CnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP1A/eOgqZMUlcJAiPY9f3/4Q3XZGbvXKJ9jT8yEgaw=;
 b=QLTLcdOOIEnAxgyMR+ulGCudhNUG4jF3YIKHcFTdcoOvo7SAXLf9PwKRUb6ah3gMhuWTEqdne9qLUn2KEtBlHPXagEmZnXs0ITX9ZawDDNORUKAsYcM1QNXAfW3XrfHsWj5JdwyPcptmjVCRgNk7rPhdKwW+oDYrLSpmlJ0Stq7WE9tGDsuFTvjU+LS+y5EwohCGG6GPTcIpwX0PsplYKAjjxgHBsAguYvvxLsQAqL+LEwG9uX4drEX2JOldNI9ei3NVPYlGeMMk3oY7PzyAEjzjYzI6dxdY0bkSHmCBrzMRMp5R6sQ4ML5qtCV9dIoTIxEGLdN9uoYknSaOy7I6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP1A/eOgqZMUlcJAiPY9f3/4Q3XZGbvXKJ9jT8yEgaw=;
 b=rBFtIlqC84DmUz++KjIlHY8YKJQ41LuHYmTlkPdweeddFtXtS6iKGlWJvlfCQAzFsckJ7DhlHT0NNobktCBxwpxRnEv9uSB+zUtRKgFT7eIiAVLKcNPL4KYZ5Ih70LUstdy4eXr0WrpxURKy+eQCVVjlR+AhllY2KtxeVGeVsdE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:20 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:20 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 10/16] maple_tree: convert mas_insert() to preallocate nodes
Date: Tue, 18 Jun 2024 13:47:44 -0700
Message-ID: <20240618204750.79512-11-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:208:23c::13) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c68de6-2d5b-4b5c-746b-08dc8fd7fd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wqhTsmTk18wjRiulcUEBAqsAPppw3E8eP1U5P+M0qIcKzvaHHdi3mqYgi4aL?=
 =?us-ascii?Q?U4STxl3CTKfNK3D/I7c/bhX35fpZQ6wlQJkoAOOQc55lVAx20u6UQKabeBS4?=
 =?us-ascii?Q?TPJUxCVuQu2w4Ki7IWVDr/z0B3CwUsqZOskY/kBMcR7ARkbSlGQf8iThCJKA?=
 =?us-ascii?Q?s0q0je1dcsZ8z0e7CoPPvn5DergQegQCZv2ahE+j2pVM5YwMPdM0kC8BFrii?=
 =?us-ascii?Q?Cn9m9pXH4gSaQ5qlyno6Ivw8b2kIWV6kcAr06uzj8/K1eAF5O0oiPcGM/s21?=
 =?us-ascii?Q?GhkoqUpxanSWb2LUG85WeL7jD/dgVgly2FvconcUkIK69E+XtYW3tPt9bxHW?=
 =?us-ascii?Q?kCVom3VQvD896D14kygBdaqVlm+v/ZVIoiQz0G+2DmvnypF2XrJueXpD/xuj?=
 =?us-ascii?Q?UkcbCuczAyqZNtZPXOZO5Wd6Lr9rvSFaTueWgq1cj3hix2ZE1+2Z3Q4bJrB2?=
 =?us-ascii?Q?bTfAy6XG3sCX0hltsmdr3PBeM8h9zf1AfwB+AyBfe6Y6tsPViAWruWzDi0FV?=
 =?us-ascii?Q?ZmYKJ9dfpmbvl5tzKNmOoDmwwCGjauspzZfSaAwd9VvG5OxWSrHCoAy8VHCV?=
 =?us-ascii?Q?57aCG6Vnwu/jjYGjXOlz1M6Dm9LpqSnFNkrixnQ17J11OZ29N6/bVDxfis/5?=
 =?us-ascii?Q?HK9I5SY0E/wnoIXEFqzOxKe19jlQa+hYmfBaqcj022DS23TFCZFALJnduBf7?=
 =?us-ascii?Q?pykNqgorWab7IvxksK3XRUch/VdfvvRbQqJtEiV1ozIJS0RJLL2frsN2WVae?=
 =?us-ascii?Q?erXFT57pqvP3ExEDNRFEaIMmGx8HPGPMhhpAuNSuGQV9nYqhks0h/ACtoLyV?=
 =?us-ascii?Q?tRP+/RGzro7+j8kl/xPZc1ay8SpwRd85r1dqG6RwLuNLleA3nEP+6eOVpQHO?=
 =?us-ascii?Q?VpIIw7YYJLY09yjRArKjlJGLF4TxK0+YWxt3LevVFtdIr79M5Ut9FFM2goWN?=
 =?us-ascii?Q?R59gpFdfE/PPXK+8G6McgEGRSMhzWjKdmuFdCDQVXAcfbajsIodq/Mi/ap26?=
 =?us-ascii?Q?g+ipvuJsxFxclL9F1IUIA1xT9BKcrjsbkwkTok4dA+9u3x/t1XtFejC3/lmq?=
 =?us-ascii?Q?EWag3AK/0A96cH6HG9rmXEaC43EKdhL+rI3QQjMfV6vntipd6ykxx6tRx+MG?=
 =?us-ascii?Q?2C2jSlk6nTi+6VeXybMq9tkIy9vSCFzkp1kB8E6dKiB0GyxfQaAnrYuICLgF?=
 =?us-ascii?Q?zyjnP9y606nTY0L1WGsP5MiFF27lOmE6npB2vkRDdtb3XWemUrXKRconGoZo?=
 =?us-ascii?Q?PouoR1A3CKkSnMo6Ie00zoAjnlLICg48hQcbQsgyLTaDatn2pxDH3tyBPUTe?=
 =?us-ascii?Q?+48laOAGCzKI8JN+64WP+anr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gdFM4k3f4CR9MZvxoloUjsq/6ie+PjdIWyUB2vpF+wD9zSh7z1RtznP19Zca?=
 =?us-ascii?Q?xmXyBvHlfbLsIyLIn6O5qFVCccHGDZGZiexEoxZ9IPFLUluY0CDOqWMHQOml?=
 =?us-ascii?Q?iBKnZkbeA1aQAhDzkgYEkdPxK+BWOYeDxvEZ+VPyd0jcYf+4vsUbntfBXtGr?=
 =?us-ascii?Q?X1mPp4hIXEWHfYkBtV/pwVBfscMoPy/QDpAKie3Q2DuRUnsYPNN9fh6dvEyp?=
 =?us-ascii?Q?+rL113qzTM5sDTSRQs2y3lh9Z1Gl3h/LkYnDPXxFFcnYadIiWHihydqBHsbE?=
 =?us-ascii?Q?KxWIgnftKIjsw7VuOuygXNHQHLWFPfPaZ7BUREc/GMFViEjMJdQvLR9QYip2?=
 =?us-ascii?Q?7uTV1Fxm3/1Vzeqcgtu4ibCbEfbPyHZE+J3jJa6ZzEZs1kaUHTpmeVEIcAb4?=
 =?us-ascii?Q?NHwGWwlmo2IWti1EVFUUI82F5zIx5oQniWgDu65yFMIRkD49LELrQrvImKMs?=
 =?us-ascii?Q?GyWK/Kq8xGSIVNYGp9YdgeO5R9fPG+aVr89lUnkBEXlQy/SllQg5Jcj4nKrU?=
 =?us-ascii?Q?NCO9FenJkZoRdIWL/NpD1mOyUYMmr15iBdnZnjtfEKygDRP2OohEW8gDMozw?=
 =?us-ascii?Q?5c+Rt+GTXtiLGUppxTXt2FQyoUUuy0xDRQvQv1OeUcBnDC+PwmZH7Fhtj+nu?=
 =?us-ascii?Q?qWGfjaJGZR9lbBJWBvPqjntwDomMf6BHiQrm/WqrGyf5ZxTwkoQtSCcnOPxh?=
 =?us-ascii?Q?dJkOgrhuyBc6h7At6yTiGbvfDr067VcvBbpQzRZ+fnTnN+Ogdu4F6Jprcu9N?=
 =?us-ascii?Q?7Cpsz5e+v+7alT29gklgtFLXFmBQ8Q9ed9tto9hsrSua4i0NO8VCYupLQGZ4?=
 =?us-ascii?Q?E1rbM2TYiODxR2XfxRA4E6EGKMHb7msbQtZbuO9EorWxR75xrOxrq88WEaq+?=
 =?us-ascii?Q?CXlmdQHbS0mZRIpaeWVk3isj47ZaKAgdwzKHpGsHtvZ5R6qyK5ozD36dPdV0?=
 =?us-ascii?Q?aF5oenA1dHW+alTyBoq5llHNpOdrX0bEiA/E44FDXOK42ewIfliCZiUKcm2i?=
 =?us-ascii?Q?N/vRllKqqKftjpC5STOD/3CNGe8WvVQ6UmFI5URGHJXDh9BDUInnUca3g3Jv?=
 =?us-ascii?Q?4DsoX0oRj/T0Fq0p68xi93QwxuqjPNeFB4iXb7iY0ir93qZCTOwqA9p3nZ6W?=
 =?us-ascii?Q?1+Hl4+ig9uHshHCf1mzeDCWUzD+DUSwHohluEQDfjINwAM1eX1mgKbI7o0/1?=
 =?us-ascii?Q?LR8zyvT2iX083o2e4kmv8L4LlbfXhIlc91XsdGhhunhJVyMcSfSNvBf4u9hI?=
 =?us-ascii?Q?KDKLtwapBgKweNsoV6VgoMg/bgAJnElzunI9q7OTESVZ2qoFxaeTMnHf91u/?=
 =?us-ascii?Q?O9c6pXySK8XnkocE7Sm7M6lbRC+BCqapRFm7FOHTwUrhkhT4KrGMeonRap43?=
 =?us-ascii?Q?DE1zPH+Es0aP2rcY3DStp8WM32iJFg+tKtvgw72/KtRGjLNKxmJaOmJ0ZEgW?=
 =?us-ascii?Q?2nh7PGHQOxUw1SW6NovLTR6yxyfD/q5XTyb920U/bXFu04Jn63LkS/7F94aZ?=
 =?us-ascii?Q?cnpgj5I+/mXY8XgSsW59aODDpaFaVBzyQyqlTxriMXRcsDnGAGfBADbHeKMm?=
 =?us-ascii?Q?KIj+RQ1YB+O0nZwbMhSEKPrZ74bUWNSFMdk6N5apH7+MJhB6oKXxemlq6nOy?=
 =?us-ascii?Q?CpVojDm11KXp+R+z9eHtZVs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QCRWEwd/Aeoi80yk5n1Rq3oGfANY0MgipNU58d7dkSaa57woqxKO1cCgHpKnEc8Ne7dFmFHC68BLnXrmhpsr5otgCFrOAdlEBVynHlkiu3aOCiOrAHNv8xfMXpkX/czqYP6S4889olnWh6G3ZI3Z0qdgyE8ZieWI6yjz+f5Bu26/Rtfz/8N/1dVa2aNTPDiuDD2YrDAinS80v9lfVEKkyCrJrOI4GFxzL4pZY/mrh70IpAraxKD499jH+IFsnBUujTmMibhI+Rxf4oCEeedLdYdaTVcdEqxEBId8zPSpgrbComQ9Aj3hW2aTpprPpQWDIVJfH7Tx+cOrN9Kn9ommQszc0ruMewmFF7/VD66sq+7wPZHZje4BeIAG/ho7DN0FzQNpVjGMGRjirnJ1D2IJEFTJuSgf10Fh0hDAOHsQwFIWePdQk9IlAgXpfXjqYV5uD4Ug6W7tfyDV/SCOPO5ZK2FSzteCjbxgbZT2lDuTr2EN5IBXBw0e9+dqiag4yXfB6Q+ttw4eIkHcG25spJiNY8ld07zW5W5qxkPUCo7IcWrCMfQhJeRzOxyvdF1xzKG0wJmUQqfVJ3sZ/sknqy0vDA6loV7ZMypRQPc7ggb/NjE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c68de6-2d5b-4b5c-746b-08dc8fd7fd06
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:20.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqvfdGBMpDr2gbQY+xp6kac7IxrwkVKSdpPTCPp7eGyeN2tnt4f6qfsUG23mBrwx5WaSYXCo/Djc4iD/wZ1ApVzHwUNhsBx+myNV0VlcR7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: ZwZ1nuokKgIBl60Brqr4t0OFppMXuFhm
X-Proofpoint-GUID: ZwZ1nuokKgIBl60Brqr4t0OFppMXuFhm

By setting the store type in mas_insert(), we no longer need to use
mas_wr_modify() to determine the correct store function to use. Instead,
set the store type and call mas_wr_store_entry(). Also, pass in the
requested gfp flags to mas_insert() so they can be passed to the call to
mas_wr_preallocate().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8ae87e512961..e53f1f398ece 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4442,11 +4442,12 @@ static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry, g
  * mas_insert() - Internal call to insert a value
  * @mas: The maple state
  * @entry: The entry to store
+ * @gfp: The GFP_FLAGS to use for allocations
  *
  * Return: %NULL or the contents that already exists at the requested index
  * otherwise.  The maple state needs to be checked for error conditions.
  */
-static inline void *mas_insert(struct ma_state *mas, void *entry)
+static inline void *mas_insert(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
@@ -4468,26 +4469,24 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
 	if (wr_mas.content)
 		goto exists;
 
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
-		mas_store_root(mas, entry);
+	mas_wr_preallocate(&wr_mas, entry, gfp);
+	if (mas_is_err(mas))
 		return NULL;
-	}
 
 	/* spanning writes always overwrite something */
-	if (!mas_wr_walk(&wr_mas))
+	if (mas->store_type == wr_spanning_store)
 		goto exists;
 
 	/* At this point, we are at the leaf node that needs to be altered. */
-	wr_mas.offset_end = mas->offset;
-	wr_mas.end_piv = wr_mas.r_max;
-
-	if (wr_mas.content || (mas->last > wr_mas.r_max))
-		goto exists;
+	if (mas->store_type != wr_new_root && mas->store_type != wr_store_root) {
+		wr_mas.offset_end = mas->offset;
+		wr_mas.end_piv = wr_mas.r_max;
 
-	if (!entry)
-		return NULL;
+		if (wr_mas.content || (mas->last > wr_mas.r_max))
+			goto exists;
+	}
 
-	mas_wr_modify(&wr_mas);
+	mas_wr_store_entry(&wr_mas);
 	return wr_mas.content;
 
 exists:
@@ -4532,7 +4531,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
 		return ret;
 
 	do {
-		mas_insert(mas, entry);
+		mas_insert(mas, entry, gfp);
 	} while (mas_nomem(mas, gfp));
 	if (mas_is_err(mas))
 		return xa_err(mas->node);
@@ -6536,7 +6535,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 
 	mtree_lock(mt);
 retry:
-	mas_insert(&ms, entry);
+	mas_insert(&ms, entry, gfp);
 	if (mas_nomem(&ms, gfp))
 		goto retry;
 
@@ -6585,7 +6584,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 	if (ret)
 		goto unlock;
 
-	mas_insert(&mas, entry);
+	mas_insert(&mas, entry, gfp);
 	/*
 	 * mas_nomem() may release the lock, causing the allocated area
 	 * to be unavailable, so try to allocate a free area again.
@@ -6667,7 +6666,7 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 	if (ret)
 		goto unlock;
 
-	mas_insert(&mas, entry);
+	mas_insert(&mas, entry, gfp);
 	/*
 	 * mas_nomem() may release the lock, causing the allocated area
 	 * to be unavailable, so try to allocate a free area again.
-- 
2.45.2


