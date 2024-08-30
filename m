Return-Path: <linux-kernel+bounces-309313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5B39668C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD4A1F21095
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1851BC9E1;
	Fri, 30 Aug 2024 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TphJKY8t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BYcf3DYP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0761FEB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041628; cv=fail; b=JB5Eg19rjm6Olv/W/3/jGG8UOQcjokOyhYImHsijQliZjvxWOspuswPZXXPoFLatP7MpbfOw9KMes6yblzMRbcMLKt7ajmBSKzR4BzoHv8orfBAl6DzNy07isPCwfuOX16QmMUduEUgRUuD3pJ992CJzzZC21sIaoWyBHoIleiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041628; c=relaxed/simple;
	bh=RGHC/sxYURzHMPTguw1hHBsh/0MjyWmXNukd1VQ0Ixs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lPnxc84wF6tUfoTpw/MOKwb5Wwb7CbxCm0IENugVQ5ZRvX5M6/r2ftxRfQ3xtRzvFlOXa0gaOPotg5/0VUR4ICL7LfPXoqNZqbvZT9rEaIHB2q8paV9YfhA+LPt/0O97PiNaNmaOax5RN0tnt2R1FoWg8m7aR/FvhWRTW41zUHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TphJKY8t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BYcf3DYP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI0Xuv012239;
	Fri, 30 Aug 2024 18:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=fiL+cPk0PMMnEkKS6fv8q8c9qJXxClNLH3oSx1nbgGM=; b=
	TphJKY8t8W1qUxPvvg6+0d2OyaW5zxeatnPrxteCWGbJZIZO+r/9BW+ARTPvDks4
	XJN8uzhbKTjXZ47TuXERKHneXVpEC2Q7dOu2TB6aFE6IZ2BcExrH4NnBpUm67v+v
	R9SYaEXNxwIr3/2WKvfkGCSvYDz+w1PTr1KzhPadI/J99TSNfKoF2xwD+Cygn7AS
	lTC7TmoEo/G21WSDl8zLvz5iC3NUuwqZ2Z9m3ijXog80ZkEW9quMqMIXdTrdTSj1
	9eLF/QUZ3mIPdb9qcBqCaig+mAPaOPnnzgOkK95SLlitYoJrt0ZyHdD1PXVXi+Q7
	QkMDRinn++DEfgNDMczUqg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bgf78c2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:13:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHjEOR034678;
	Fri, 30 Aug 2024 18:10:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sxqd5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN7MoO4BcXtrQqciJVktAQl9EKX8UJtikZJu/g63LkpK8nBqs1av0/Qv+o/KFr6pRrry7PUn4F3tJOQThBYnF0CYR2lQ2yfbmVvnm/INDa70v1HIo+GBw2o2kk0dkBQpwWY9P4c6MMbkQ0tAW0xeALg+t1zpRAUz/nYGjAAJHzI/D7gChmkrq/7im5VBninLUYIuVBiIz0XhpnHeIWeaqNv8DfgfP/DGxmsiKGhGOi/D8USaFVJXT5c5508I4pvSXxydsGB0TUGanSZNqpD5/cEFGUNU/xzAA7A4idDLCYtYJh1Fx2u8B2/owVQKifZ08sXbXvEyg7MavGjgYdD6Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiL+cPk0PMMnEkKS6fv8q8c9qJXxClNLH3oSx1nbgGM=;
 b=UUSqF9PFxidcsaQeEksyDN4HxL2APi+qGOpbssmqsNZ4y27MOOMiSELhJFTWZPE0pZNzkzSD+BJ85ei+985E4UJ5TGodeR1I4puPP1OmvpRWqQzJr4V1nD4GC8itnmdfSO5XNjBhwbotMLFzE1w3BHt48XovAi12ssvAf99ONeI4NkbsPKsN6eAKr0bpT8A0d8fvQRy5vAXFaLZwLAmgdUBygEvTsEFjpnnTrI97KPySKf61fnbT6rRLggJpQ/NrLrWWyzhKWGNLrAICu92Nct0VSJyYVV6zp1JymegT5mb4xdBipkgYrCp3ZQWQ+zDVIWh2nNN4rsy0j9CXJUrl6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiL+cPk0PMMnEkKS6fv8q8c9qJXxClNLH3oSx1nbgGM=;
 b=BYcf3DYPthjT95F9uOV/At3gBVbg8JKtHA7QemOtJcpfWu9YlFegFBfiZu3L8CjDo4SXzx20dBICCQRYirVTKElUhhmj1PT3W9cgc0Qq5CjzEhxqJLli9qnH2Bg7pP9Ytz4ORFHwTIndp6lFwPMfmMUjx3p3koRNt3iSg0zadmg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7276.namprd10.prod.outlook.com (2603:10b6:208:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 18:10:33 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 02/10] tools: add VMA merge tests
Date: Fri, 30 Aug 2024 19:10:14 +0100
Message-ID: <1c7a0b43cfad2c511a6b1b52f3507696478ff51a.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
References: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3bce01-5ac3-442e-c5f1-08dcc91f0a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bRO/sGFC7a8zj7gD+qH7Av9pUM0m0JXLhQE92GHl1kvucR8zX2x4mNEsorfV?=
 =?us-ascii?Q?fXgt5NtozJ1p/8yzE7iWqzM40xzpf9oiGSOP7jelneLIYO6uLuljs+hVVUfd?=
 =?us-ascii?Q?6RrEoKOY3Zx1DAgmQhB/03Nysg2dXe1kRvicbvzq80m98nzyA/F85IZ7RV65?=
 =?us-ascii?Q?uoU/zDXhzipz9EvfK2jpSwggQkQqtrv6dPbK33OEnlQun3fjE9lIMZWdYLOW?=
 =?us-ascii?Q?V/9bX1EagOjZwcLUYPZum8/I5vTlVscvxlGFhWwkzZ6BaKwNnJIG3AnxzL68?=
 =?us-ascii?Q?ipB/ZJyT66U0LO6KFynMT7H/kg/Er4v4FdYXr8LFdkPxl0aPNrdNK1QyHhn9?=
 =?us-ascii?Q?rilF5JwyiQ/j3gRMZj3fO9O29FcN5g6wUNythh88lWzNBYfUYeEBDwh/cA7N?=
 =?us-ascii?Q?+tJ7zS3ByOitZ9m6Ow8umyU5bwtPnTf0j1aFegKA8W3SNmU4SruWDfv+6nk1?=
 =?us-ascii?Q?MeV0guUS2wdii91kZHDiwBEPDevMPj6ZoNMQlSx4J0vMUTp6HdmxUgy3guSM?=
 =?us-ascii?Q?d0D78jWSp4OgBGwMiE+5n2QN1kDY8SNUnvn96QO9l+b1Wh5Xg13CHpyUmq0Z?=
 =?us-ascii?Q?JDQBQ/tHgDFf8Q/YkRIk6S9ivpSKCjAyBFmv2WQSv6DeGt2K/qS3cVvoFjfY?=
 =?us-ascii?Q?+zY0+2UrCyt7PsDieEdRhg+7XTak0ly8ZkLM9PvysiYiVU1x0BKEapAg1qWg?=
 =?us-ascii?Q?Tx1uSmhvboFK9LkrXsaM4q5djdkUBXueUbWUVOGGGf/F5F8P6ztx2xKlxB1j?=
 =?us-ascii?Q?CZIal9nxpR/EAeOuE4vwUMYKvNZ3vvOd7vAHs9OJ2bAfaW+2YHDfUhCInK9z?=
 =?us-ascii?Q?4O0NUeSPynNvI3ns0aFj7tC2dpxSqLgWNQ6QVizmZ9kWzXju93/M5RhL0Sry?=
 =?us-ascii?Q?K/5DkWvm0jfif84dFFuMAfXfRsMN0mmNDuN7A13LTmGGKwoAjKQzYCPbTzjA?=
 =?us-ascii?Q?P0nJGg57CjeOQ04g5At5z/s/YP1ZDAySpQrxH0UvOTYFlAf7GpLc+HvLk8VT?=
 =?us-ascii?Q?hvtXIarle3cKyzED/aw8TWQuZNsnWZWV2E8r/6kLdvx9HFHAN/OyLuYNQMK6?=
 =?us-ascii?Q?NhyLauDFQnCFOhLbyv753mC3mD0Kw+8VXTJlDWlkU1sKmL/zSeQzCoHiT/W4?=
 =?us-ascii?Q?pGnQw79mS7Lry3RVM6ynOYD1nXaKEjDZyMJu0nJ2RlqrUL1TeFRRkKN5kPAA?=
 =?us-ascii?Q?LOv4c84V4PDraF8xk0N8EUrkebkNWGNqIRGlI4nbAPuCGj7tB89hYFt730n7?=
 =?us-ascii?Q?EDafqamXcDDSMIiIYV40Aan4p0KJ2Zx+6FuFuUSMmaQZxi2ZDsvmnLi/EA7+?=
 =?us-ascii?Q?9PSlXS9Q42x50zuGBb3YTcualbQyVHAgmLRFXjwCd/Er7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n+aBqcPzoi+RO5VjK19x28Fw8geaHPAGMpD2BOFFdd+m3v8ZRsWgmexe1lfE?=
 =?us-ascii?Q?v2bPFjrTR/oeyGPSGLXNuXlp0SZw8CQBdpleB7sqLnXZHukJ05IbnZzzW9WU?=
 =?us-ascii?Q?KC3GoSL9IwNYDni3iKqehUllxyd0Ug4Muvj6TGSx0Hmq7BSHLOYwly6JckHt?=
 =?us-ascii?Q?zAwimeRzIg7jNJ/ppopheIEjkxRp0WkQkjnxCmrNnymAr9jJK9cUX5rF3qN3?=
 =?us-ascii?Q?ymKNrvp/afNeVpzneOGWPmkKG248TVUl1n6T7ccxDQIc8+eYe9wMwZ5KK9dX?=
 =?us-ascii?Q?ge56QCglqipbyoB1pmN8MBZ6qBXeHr/zhwkhlrgTJZ3ZaA4f3Ep8TKhJq434?=
 =?us-ascii?Q?v1IGPb6w0ELmvS9iqI0Mwc885TKHuNupeTaqANk2HE2Dlvgk9G/U3gD8/7tx?=
 =?us-ascii?Q?Y4VVgBbe0H+Bnt1wzH35hlu8Jr/4two0zjPSz//Fn7iKda9T7ilrgBBG40ms?=
 =?us-ascii?Q?WWUKLWUMdK963RqYfMXeB4atw4DXi3WXURqVUmJOQ0Z7gMX59DmLXX8m/nL+?=
 =?us-ascii?Q?pH/xJ1pPn+sFBiNaZKGkvOM8ssQ7HYHgGr99wiXI8hkHq8JC4BMKz7Fehqnm?=
 =?us-ascii?Q?cnS6UYZmXp5qDNZaWBpALpM0cg8YCOCwXXAwpuC2zzGO2G1C885gKD+MOg8t?=
 =?us-ascii?Q?96UnpI9WyLGAq1dF/aqIzMl42mYSrQrfet0o+8Gp+q9LffhKvKHQguekWtT6?=
 =?us-ascii?Q?EKyJE5BRbGT1gWKCij4nfI6kin0/oR9wKwFaXyL8nFLYtUCSbhfH22ifX/jX?=
 =?us-ascii?Q?2ORdyhC6gfNXiuu53VPHq11I84SljZNkxNwzrMPQXv/v2YsKysgONrBfQsTd?=
 =?us-ascii?Q?O9LZOtrhsAjIrhBx+xp+gtqkmYsByctVveoYuyQb8+Pi2eMHsn37Yga+15hd?=
 =?us-ascii?Q?i40jiTZmPHcLba41mb/mHI7mxjHOnJE2dsm8sqquvcoHe5Se+41rdol3ZMc0?=
 =?us-ascii?Q?BMvgmEz04C9xr2JfXU6tZN1Xp6BVeot9LcOfcKtm3KZ1lTdpNLsLyAWxvS2w?=
 =?us-ascii?Q?4RjRSKZxonrOZ1YNpCC/7e8bJyGHQIREbn432LWdI1cKMX2lnF5rYW/wo1vz?=
 =?us-ascii?Q?eFPnOb1uKJrujA5V9EWbSvrG2MbNk9XemDNmVXoR6USqo4uSPz621IJfWJdu?=
 =?us-ascii?Q?hqO+j6OJMDngdHPaZC2pDZfvfFDEUniQk6m6qubcQSvvYBYM/zWrdWqQa23z?=
 =?us-ascii?Q?JY8Q8BF+nzX+px7vNIlGWH4UKNRlIm5Lg6RMTO3rSM+YRALFdTVnRyr9CvxQ?=
 =?us-ascii?Q?GNa8UAyZLBZsl+1xMAoe6m3Kdxl3cLK6EPqXLbE6e7nu9vzQ2VyaiQ2M4l5a?=
 =?us-ascii?Q?dSBVJKeiP7arua2Ag6W7d1QZ64DTHN47omt21t93A9uTVCyDwy+/PP1vtuBg?=
 =?us-ascii?Q?cm20ZR0FZ5sgaL+CdQxIhSTgjLkyVJ+hgQfnvEPObEoNoODSqzJbUuZ4UJ6Q?=
 =?us-ascii?Q?QW6axetvznUl0S6xfg0SbVjw3iV+Z5+0oLyT9/6Ygan7Uojlblh0W+7D7XrC?=
 =?us-ascii?Q?c7pJp8WJ6no0XtTfwEH8/fb5fw0eZ1H4t68DRX485TG9ZJHG4CTTZG3tE4vw?=
 =?us-ascii?Q?U44aIYyE5yVJSiSuqX6y/l1/SRw6224RqtX6hYa2j3Sgo4Ww0f8BEjZbjFnQ?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+eJz8bdw71q6AEleFtCKi6Jgd7eSXJPHzPb+wrfJgmHH9g4/RoYScHHT7Qa5hxyvUBG5f2ySpsjDqIpSNl3DQPWNkpen6WhqqcCu/9amG1nC4y8qCtvIyeJbDoGoaKoQSfc7fxto0Tfvz3C1ktk5xTdaeILjHBzANTXsQp2C6akqY0FODayUk07PLDDkOqLnhTLQqvhqSt9kBSCKvmajd6ovPvvI3kqT52a752bhhf9ypmM7rDCYJ5EK+pn9MqlvkUexJTQDJS9StoZYWWhtj2kjR57ywb8gwxss7TZmOScWyfL6Di17x1swZC/TG5P+yY9A5WZbPrcqgiURDADKF/t0uamHUUTFQcFSvO631w3wAEM9lYeiHq+oXRuzpPdHn+B8L34Dfm8WE9XS7wOqwgkYeAvEnt1U65+MccXil8mEBrKNKTJyAPCxXIOmpFlZ2WVOLKCYhyI4TMkdhm1cxMiqn7o5TlUhOLCvwRxCNTHeqVqE8RSlqFJcpcFVKK8+msUEzoNwFQSas/fBFEk3wzt2ARQk4UniXk08X6pgc0L5KmOGevCWcwH+nKnK2QgUX8WUckr58iP0Zo60YIEwOL3J8hqBW/vNzUIMlj/8SRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3bce01-5ac3-442e-c5f1-08dcc91f0a19
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:33.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9m/KSZ9gsCt6umope0bKtKB1MMaldReqxLWWB6qoZ+m64H5VzR+hqa7NheCHNg4uLWkCCZTT0HWbLSCbKX+aEt5Lq1wsvUxEtsaGTFGikQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-GUID: gwl1-ehf92OrUROuDUg6jz3uJ7xBoAWM
X-Proofpoint-ORIG-GUID: gwl1-ehf92OrUROuDUg6jz3uJ7xBoAWM

Add a variety of VMA merge unit tests to assert that the behaviour of VMA
merge is correct at an abstract level and VMAs are merged or not merged as
expected.

These are intentionally added _before_ we start refactoring vma_merge() in
order that we can continually assert correctness throughout the rest of the
series.

In order to reduce churn going forward, we backport the vma_merge_struct
data type to the test code which we introduce and use in a future commit,
and add wrappers around the merge new and existing VMA cases.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/testing/vma/vma.c          | 1282 +++++++++++++++++++++++++++++-
 tools/testing/vma/vma_internal.h |   45 +-
 2 files changed, 1317 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 48e033c60d87..71bd30d5da81 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -7,13 +7,43 @@
 #include "maple-shared.h"
 #include "vma_internal.h"
 
+/* Include so header guard set. */
+#include "../../../mm/vma.h"
+
+static bool fail_prealloc;
+
+/* Then override vma_iter_prealloc() so we can choose to fail it. */
+#define vma_iter_prealloc(vmi, vma)					\
+	(fail_prealloc ? -ENOMEM : mas_preallocate(&(vmi)->mas, (vma), GFP_KERNEL))
+
 /*
  * Directly import the VMA implementation here. Our vma_internal.h wrapper
  * provides userland-equivalent functionality for everything vma.c uses.
  */
 #include "../../../mm/vma.c"
 
+/*
+ * Temporarily forward-ported from a future in which vmg's are used for merging.
+ */
+struct vma_merge_struct {
+	struct mm_struct *mm;
+	struct vma_iterator *vmi;
+	pgoff_t pgoff;
+	struct vm_area_struct *prev;
+	struct vm_area_struct *next; /* Modified by vma_merge(). */
+	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
+	unsigned long start;
+	unsigned long end;
+	unsigned long flags;
+	struct file *file;
+	struct anon_vma *anon_vma;
+	struct mempolicy *policy;
+	struct vm_userfaultfd_ctx uffd_ctx;
+	struct anon_vma_name *anon_name;
+};
+
 const struct vm_operations_struct vma_dummy_vm_ops;
+static struct anon_vma dummy_anon_vma;
 
 #define ASSERT_TRUE(_expr)						\
 	do {								\
@@ -28,6 +58,14 @@ const struct vm_operations_struct vma_dummy_vm_ops;
 #define ASSERT_EQ(_val1, _val2) ASSERT_TRUE((_val1) == (_val2))
 #define ASSERT_NE(_val1, _val2) ASSERT_TRUE((_val1) != (_val2))
 
+static struct task_struct __current;
+
+struct task_struct *get_current(void)
+{
+	return &__current;
+}
+
+/* Helper function to simply allocate a VMA. */
 static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
 					unsigned long start,
 					unsigned long end,
@@ -47,22 +85,201 @@ static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
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
+/* Helper function which provides a wrapper around a merge new VMA operation. */
+static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
+{
+	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
+	struct vm_area_struct dummy = {
+		.vm_mm = vmg->mm,
+		.vm_flags = vmg->flags,
+		.anon_vma = vmg->anon_vma,
+		.vm_file = vmg->file,
+	};
+
+	/*
+	 * For convenience, get prev and next VMAs. Which the new VMA operation
+	 * requires.
+	 */
+	vmg->next = vma_next(vmg->vmi);
+	vmg->prev = vma_prev(vmg->vmi);
+
+	vma_iter_set(vmg->vmi, vmg->start);
+	return vma_merge_new_vma(vmg->vmi, vmg->prev, &dummy, vmg->start,
+				 vmg->end, vmg->pgoff);
+}
+
+/*
+ * Helper function which provides a wrapper around a merge existing VMA
+ * operation.
+ */
+static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
+{
+	/* vma_merge() needs a VMA to determine mm, anon_vma, and file. */
+	struct vm_area_struct dummy = {
+		.vm_mm = vmg->mm,
+		.vm_flags = vmg->flags,
+		.anon_vma = vmg->anon_vma,
+		.vm_file = vmg->file,
+	};
+
+	return vma_merge(vmg->vmi, vmg->prev, &dummy, vmg->start, vmg->end,
+			 vmg->flags, vmg->pgoff, vmg->policy, vmg->uffd_ctx,
+			 vmg->anon_name);
+}
+
+/*
+ * Helper function which provides a wrapper around the expansion of an existing
+ * VMA.
+ */
+static int expand_existing(struct vma_merge_struct *vmg)
+{
+	return vma_expand(vmg->vmi, vmg->vma, vmg->start, vmg->end, vmg->pgoff,
+			  vmg->next);
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
+	merged = merge_new(vmg);
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
+ * Helper function to reset the dummy anon_vma to indicate it has not been
+ * duplicated.
+ */
+static void reset_dummy_anon_vma(void)
+{
+	dummy_anon_vma.was_cloned = false;
+	dummy_anon_vma.was_unlinked = false;
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
+	fail_prealloc = false;
+	reset_dummy_anon_vma();
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
 	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
 	struct mm_struct mm = {};
 	struct vm_area_struct *vma_left = alloc_vma(&mm, 0, 0x1000, 0, flags);
-	struct vm_area_struct *vma_middle = alloc_vma(&mm, 0x1000, 0x2000, 1, flags);
 	struct vm_area_struct *vma_right = alloc_vma(&mm, 0x2000, 0x3000, 2, flags);
 	VMA_ITERATOR(vmi, &mm, 0x1000);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+		.start = 0x1000,
+		.end = 0x2000,
+		.flags = flags,
+		.pgoff = 1,
+	};
 
 	ASSERT_FALSE(vma_link(&mm, vma_left));
-	ASSERT_FALSE(vma_link(&mm, vma_middle));
 	ASSERT_FALSE(vma_link(&mm, vma_right));
 
-	vma = vma_merge_new_vma(&vmi, vma_left, vma_middle, 0x1000,
-				0x2000, 1);
+	vma = merge_new(&vmg);
 	ASSERT_NE(vma, NULL);
 
 	ASSERT_EQ(vma->vm_start, 0);
@@ -142,10 +359,17 @@ static bool test_simple_expand(void)
 	struct mm_struct mm = {};
 	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x1000, 0, flags);
 	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+		.vma = vma,
+		.start = 0,
+		.end = 0x3000,
+		.pgoff = 0,
+	};
 
 	ASSERT_FALSE(vma_link(&mm, vma));
 
-	ASSERT_FALSE(vma_expand(&vmi, vma, 0, 0x3000, 0, NULL));
+	ASSERT_FALSE(expand_existing(&vmg));
 
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x3000);
@@ -178,6 +402,1042 @@ static bool test_simple_shrink(void)
 	return true;
 }
 
+static bool test_merge_new(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
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
+		.mm = &mm,
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
+		vma = merge_new(&vmg);
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
+		vma = merge_existing(&vmg);
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
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};
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
+	 * This is picked up by a specific check in the modified VMA merge.
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
+	vma_next->vm_ops = &vm_ops;
+
+	/* Our proposed VMA has characteristics that would otherwise be merged. */
+	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+
+	/* The next VMA having a close() operator should cause the merge to fail.*/
+	ASSERT_EQ(merge_new(&vmg), NULL);
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
+	ASSERT_EQ(merge_existing(&vmg), NULL);
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
+	vma->vm_ops = &vm_ops;
+	vmg.vma = vma;
+	/* Make sure merge does not occur. */
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_vma_merge_new_with_close(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	struct vm_area_struct *vma_prev = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
+	struct vm_area_struct *vma_next = alloc_and_link_vma(&mm, 0x5000, 0x7000, 5, flags);
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};
+	struct vm_area_struct *vma;
+
+	/*
+	 * We should allow the partial merge of a proposed new VMA if the
+	 * surrounding VMAs have vm_ops->close() hooks (but are otherwise
+	 * compatible), e.g.:
+	 *
+	 *        New VMA
+	 *    A  v-------v  B
+	 * |-----|       |-----|
+	 *  close         close
+	 *
+	 * Since the rule is to not DELETE a VMA with a close operation, this
+	 * should be permitted, only rather than expanding A and deleting B, we
+	 * should simply expand A and leave B intact, e.g.:
+	 *
+	 *        New VMA
+	 *       A          B
+	 * |------------||-----|
+	 *  close         close
+	 */
+
+	/* Have prev and next have a vm_ops->close() hook. */
+	vma_prev->vm_ops = &vm_ops;
+	vma_next->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x2000, 0x5000, 2, flags);
+	vma = merge_new(&vmg);
+	ASSERT_NE(vma, NULL);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x5000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_EQ(vma->vm_ops, &vm_ops);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 2);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_merge_existing(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vm_area_struct *vma, *vma_prev, *vma_next;
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
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
+	ASSERT_EQ(merge_existing(&vmg), vma_next);
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
+	ASSERT_EQ(merge_existing(&vmg), vma_next);
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
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
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
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
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
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
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
+	 * Non-merge ranges. the modified VMA merge operation assumes that the
+	 * caller always specifies ranges within the input VMA so we need only
+	 * examine these cases.
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
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x6000, 0x7000, 6, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x4000, 0x7000, 4, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x4000, 0x6000, 4, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+
+	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+	ASSERT_EQ(merge_existing(&vmg), NULL);
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
+		.mm = &mm,
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
+	 * In the case of modified VMA merge, merging both left and right VMAs
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
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
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
+	ASSERT_EQ(merge_new(&vmg), vma_prev);
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
+static bool test_dup_anon_vma(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	struct anon_vma_chain dummy_anon_vma_chain = {
+		.anon_vma = &dummy_anon_vma,
+	};
+	struct vm_area_struct *vma_prev, *vma_next, *vma;
+
+	reset_dummy_anon_vma();
+
+	/*
+	 * Expanding a VMA delete the next one duplicates next's anon_vma and
+	 * assigns it to the expanded VMA.
+	 *
+	 * This covers new VMA merging, as these operations amount to a VMA
+	 * expand.
+	 */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next->anon_vma = &dummy_anon_vma;
+
+	vmg_set_range(&vmg, 0, 0x5000, 0, flags);
+	vmg.vma = vma_prev;
+	vmg.next = vma_next;
+
+	ASSERT_EQ(expand_existing(&vmg), 0);
+
+	/* Will have been cloned. */
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+
+	/* Cleanup ready for next run. */
+	cleanup_mm(&mm, &vmi);
+
+	/*
+	 * next has anon_vma, we assign to prev.
+	 *
+	 *         |<----->|
+	 * |-------*********-------|
+	 *   prev     vma     next
+	 *  extend   delete  delete
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
+
+	/* Initialise avc so mergeability check passes. */
+	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
+	list_add(&dummy_anon_vma_chain.same_vma, &vma_next->anon_vma_chain);
+
+	vma_next->anon_vma = &dummy_anon_vma;
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x8000);
+
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+
+	cleanup_mm(&mm, &vmi);
+
+	/*
+	 * vma has anon_vma, we assign to prev.
+	 *
+	 *         |<----->|
+	 * |-------*********-------|
+	 *   prev     vma     next
+	 *  extend   delete  delete
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
+
+	vma->anon_vma = &dummy_anon_vma;
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x8000);
+
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+
+	cleanup_mm(&mm, &vmi);
+
+	/*
+	 * vma has anon_vma, we assign to prev.
+	 *
+	 *         |<----->|
+	 * |-------*************
+	 *   prev       vma
+	 *  extend shrink/delete
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, flags);
+
+	vma->anon_vma = &dummy_anon_vma;
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x5000);
+
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_prev->anon_vma->was_cloned);
+
+	cleanup_mm(&mm, &vmi);
+
+	/*
+	 * vma has anon_vma, we assign to next.
+	 *
+	 *     |<----->|
+	 * *************-------|
+	 *      vma       next
+	 * shrink/delete extend
+	 */
+
+	vma = alloc_and_link_vma(&mm, 0, 0x5000, 0, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
+
+	vma->anon_vma = &dummy_anon_vma;
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_next);
+
+	ASSERT_EQ(vma_next->vm_start, 0x3000);
+	ASSERT_EQ(vma_next->vm_end, 0x8000);
+
+	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(vma_next->anon_vma->was_cloned);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_vmi_prealloc_fail(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vma_merge_struct vmg = {
+		.mm = &mm,
+		.vmi = &vmi,
+	};
+	struct vm_area_struct *vma_prev, *vma;
+
+	/*
+	 * We are merging vma into prev, with vma possessing an anon_vma, which
+	 * will be duplicated. We cause the vmi preallocation to fail and assert
+	 * the duplicated anon_vma is unlinked.
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma->anon_vma = &dummy_anon_vma;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	fail_prealloc = true;
+
+	/* This will cause the merge to fail. */
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+	/* We will already have assigned the anon_vma. */
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	/* And it was both cloned and unlinked. */
+	ASSERT_TRUE(dummy_anon_vma.was_cloned);
+	ASSERT_TRUE(dummy_anon_vma.was_unlinked);
+
+	cleanup_mm(&mm, &vmi); /* Resets fail_prealloc too. */
+
+	/*
+	 * We repeat the same operation for expanding a VMA, which is what new
+	 * VMA merging ultimately uses too. This asserts that unlinking is
+	 * performed in this case too.
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma->anon_vma = &dummy_anon_vma;
+
+	vmg_set_range(&vmg, 0, 0x5000, 3, flags);
+	vmg.vma = vma_prev;
+	vmg.next = vma;
+
+	fail_prealloc = true;
+	ASSERT_EQ(expand_existing(&vmg), -ENOMEM);
+
+	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
+	ASSERT_TRUE(dummy_anon_vma.was_cloned);
+	ASSERT_TRUE(dummy_anon_vma.was_unlinked);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_merge_extend(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	VMA_ITERATOR(vmi, &mm, 0x1000);
+	struct vm_area_struct *vma;
+
+	vma = alloc_and_link_vma(&mm, 0, 0x1000, 0, flags);
+	alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, flags);
+
+	/*
+	 * Extend a VMA into the gap between itself and the following VMA.
+	 * This should result in a merge.
+	 *
+	 * <->
+	 * *  *
+	 *
+	 */
+
+	ASSERT_EQ(vma_merge_extend(&vmi, vma, 0x2000), vma);
+	ASSERT_EQ(vma->vm_start, 0);
+	ASSERT_EQ(vma->vm_end, 0x4000);
+	ASSERT_EQ(vma->vm_pgoff, 0);
+	ASSERT_TRUE(vma_write_started(vma));
+	ASSERT_EQ(mm.map_count, 1);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
+static bool test_copy_vma(void)
+{
+	unsigned long flags = VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE;
+	struct mm_struct mm = {};
+	bool need_locks = false;
+	VMA_ITERATOR(vmi, &mm, 0);
+	struct vm_area_struct *vma, *vma_new, *vma_next;
+
+	/* Move backwards and do not merge. */
+
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
+
+	ASSERT_NE(vma_new, vma);
+	ASSERT_EQ(vma_new->vm_start, 0);
+	ASSERT_EQ(vma_new->vm_end, 0x2000);
+	ASSERT_EQ(vma_new->vm_pgoff, 0);
+
+	cleanup_mm(&mm, &vmi);
+
+	/* Move a VMA into position next to another and merge the two. */
+
+	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, flags);
+	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
+
+	ASSERT_EQ(vma_new, vma_next);
+
+	cleanup_mm(&mm, &vmi);
+	return true;
+}
+
 int main(void)
 {
 	int num_tests = 0, num_fail = 0;
@@ -193,11 +1453,23 @@ int main(void)
 		}							\
 	} while (0)
 
+	/* Very simple tests to kick the tyres. */
 	TEST(simple_merge);
 	TEST(simple_modify);
 	TEST(simple_expand);
 	TEST(simple_shrink);
 
+	TEST(merge_new);
+	TEST(vma_merge_special_flags);
+	TEST(vma_merge_with_close);
+	TEST(vma_merge_new_with_close);
+	TEST(merge_existing);
+	TEST(anon_vma_non_mergeable);
+	TEST(dup_anon_vma);
+	TEST(vmi_prealloc_fail);
+	TEST(merge_extend);
+	TEST(copy_vma);
+
 #undef TEST
 
 	printf("%d tests run, %d passed, %d failed.\n",
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 093560e5b2ac..a3c262c6eb73 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -81,8 +81,6 @@
 
 #define AS_MM_ALL_LOCKS 2
 
-#define current NULL
-
 /* We hardcode this for now. */
 #define sysctl_max_map_count 0x1000000UL
 
@@ -92,6 +90,12 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
 typedef unsigned long vm_flags_t;
 typedef __bitwise unsigned int vm_fault_t;
 
+/*
+ * The shared stubs do not implement this, it amounts to an fprintf(STDERR,...)
+ * either way :)
+ */
+#define pr_warn_once pr_err
+
 typedef struct refcount_struct {
 	atomic_t refs;
 } refcount_t;
@@ -100,9 +104,30 @@ struct kref {
 	refcount_t refcount;
 };
 
+/*
+ * Define the task command name length as enum, then it can be visible to
+ * BPF programs.
+ */
+enum {
+	TASK_COMM_LEN = 16,
+};
+
+struct task_struct {
+	char comm[TASK_COMM_LEN];
+	pid_t pid;
+	struct mm_struct *mm;
+};
+
+struct task_struct *get_current(void);
+#define current get_current()
+
 struct anon_vma {
 	struct anon_vma *root;
 	struct rb_root_cached rb_root;
+
+	/* Test fields. */
+	bool was_cloned;
+	bool was_unlinked;
 };
 
 struct anon_vma_chain {
@@ -682,13 +707,21 @@ static inline int vma_dup_policy(struct vm_area_struct *, struct vm_area_struct
 	return 0;
 }
 
-static inline int anon_vma_clone(struct vm_area_struct *, struct vm_area_struct *)
+static inline int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
 {
+	/* For testing purposes. We indicate that an anon_vma has been cloned. */
+	if (src->anon_vma != NULL) {
+		dst->anon_vma = src->anon_vma;
+		dst->anon_vma->was_cloned = true;
+	}
+
 	return 0;
 }
 
-static inline void vma_start_write(struct vm_area_struct *)
+static inline void vma_start_write(struct vm_area_struct *vma)
 {
+	/* Used to indicate to tests that a write operation has begun. */
+	vma->vm_lock_seq++;
 }
 
 static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
@@ -759,8 +792,10 @@ static inline void vma_assert_write_locked(struct vm_area_struct *)
 {
 }
 
-static inline void unlink_anon_vmas(struct vm_area_struct *)
+static inline void unlink_anon_vmas(struct vm_area_struct *vma)
 {
+	/* For testing purposes, indicate that the anon_vma was unlinked. */
+	vma->anon_vma->was_unlinked = true;
 }
 
 static inline void anon_vma_unlock_write(struct anon_vma *)
-- 
2.46.0


