Return-Path: <linux-kernel+bounces-285707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0340A951196
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A40B23FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 01:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1321912B6C;
	Wed, 14 Aug 2024 01:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y4r8UaBN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DkOVyws+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93736195
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723599074; cv=fail; b=ciHqn2aRAdvGec7tF/3IeJkZvl/qj4zvh4xF0JPruiEo5mb3DCj7JNgN02wZZyKivmfZfqiQEAkCoG7RgVuVbM2wwDWn5twWo48A40u/ARZVXPlMT24GgfIkSxcRCrKVaXHGQtTwcbdHEsW0Kyty79lyaHurOSqq8qH3+DhHZN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723599074; c=relaxed/simple;
	bh=RFuNTAFsWjKsOQQssbG0DMomhA16Mg2nelQ54qk6dXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OuQ+LP13vKUJ8y5yEHfPG5uGhQsy+953rRxK6D2MlPR9Xq6klIp2GSBHO430422nnv8QpTonbE3kz9OPj0hMsLaZ9tGpZNWia0/oCx8f/1eGTBxKPYtIyZr2waJTQZeqhZasT5M8X/qjsLjdUlvY4obBfLhOVUYfCrAahDvgMdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y4r8UaBN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DkOVyws+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DN99x9021367;
	Wed, 14 Aug 2024 01:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=O7N7+kbTnBcC74E
	68ESdUlTgH8wZKXiFEA0g9hcW8r8=; b=Y4r8UaBN0mNUqJUV7E0f5VENCB3Djsp
	6LwNGP2a8h3uTgdh2lPctJ9oCznLs9KLGQj9j16yDko1JCheT0lRWZUuVVUz/jtr
	VF3n1MujOSssIHvFUaz3Xe80ObWlH7W4c5WTiJ39e0Tf1/DZgFzaOnCOWVaJ270R
	aOZyo8s77cfZnKKWy3xbYRNF7vifQhTfvmTtIUbjwE6/Kj+kVG6K1p+ytGLdUcKB
	FRTRUtHzFe8RYo4FlqCAjjzLDdZi0ap6CLE1O1dPoyIkRvA9OYdocWqaNm5mL99L
	eqOAMUj4RTB2Jmd6jGSZQ6eOZnDCK/Pfu6TB5j8BCkOx/ZU1dWZpOwg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x03975b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 01:31:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47DNnKKo021179;
	Wed, 14 Aug 2024 01:31:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnft810-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 01:31:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4tS6vFzBSDs00Efyvh1oZ39+MpmSoorIousRF9BZ5Ey5zg2f1DSkusv8o2tV4CUEvjDohoHx8y6Hq3zBdYBS7797kXItYxYIxoAzn7oou+WWhiTCZBmGxHiGlTLfgL74lTm4kOc4Y68M55S3ebIO23mkzqSJMgbOx9+gPxemtbdEBSOfwNVb1kTqUPQ/XVbat+2fTHOWznl2hqTWCwMUmBG848WCHlOYADNMQOo+oOHPujuhU1aaS2mpP8vIncFdQSUHjJhp/o2JIbTdcn6dxA+KBUNfHaqf3ryDU4uMLmBvw4fIB8W8JtvLlziJMe+q6wbAm/95YZDiAbhr2kZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7N7+kbTnBcC74E68ESdUlTgH8wZKXiFEA0g9hcW8r8=;
 b=hudJjc+T9Ab+2yNCbshL4Qr1xIHTem/peThfnEIVrqIvRMBQxwYbrJE/HuM0/xVFYueqmit4Vp2Kqa2sEKS6LuajDka9ejL8s+HnRhAWjmTJSF6zjn5owrYqBCjhphNPZ/wawX32Lhv2HA0+BAfAUFZ2QoTylXFx5f5YiblAZx5wYePUen3n+mNhmi8uEXTwznAgE7sIazeSnU/09EBCnpcPTWuTfpO/V6euv2L3/eY2XSwf6bifeOIj5+rNaqV0ZWW8AJtpk4Or1vV+Auxt+ApQz2lU9nhyrq0UYIG+R+HWJnVy94BD6t8mo/cb1XiIJ/o4nC3bgxbzrEHRzkvQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7N7+kbTnBcC74E68ESdUlTgH8wZKXiFEA0g9hcW8r8=;
 b=DkOVyws+7Itrzf9Mpn/LA4kgwxaaxsHtg8GWetfA4JFiDM8F/8r9jGUzdSCDhx4mSeGlSSgLUqM3ZtQJVvIyRPwTJMhu6zVyp788mX/qARgPpSuLWDNlSkRMWFQT7ataHLdIySfReJLQQ78DvCWqJMZpVDaAw2B3zmkSKti2TUc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB6644.namprd10.prod.outlook.com (2603:10b6:806:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 01:31:03 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 01:31:03 +0000
Date: Tue, 13 Aug 2024 21:31:01 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 1/2] maple_tree: fix comment typo of ma_root
Message-ID: <4jkkom7ble6ireunal7jse63tifepwpwla2y4jpsqkx7mz466m@of74l7ksicon>
References: <20240812150925.31551-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812150925.31551-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 4486f543-a2b7-4a76-683b-08dcbc00c2b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Ue0DFPvE2c7m/mB1dToEQtrEm+eqMw0fTAt2nvkTiTWLw9bNK862YF1mR01?=
 =?us-ascii?Q?ba8EvRN6UjUDGCLFmYiQEpBgGdoRDPX0W7sIblrbxJKUqqlTzOrdVnh5OTos?=
 =?us-ascii?Q?zFklBJG/AlvwsMjR8yI2YSAfu7y432wo1Q8HJ5V0kh5EjELo2oycYglbH3sC?=
 =?us-ascii?Q?YBYEjpt/3nN7asVd2Ep8a8qRhYHDQe1AewnIp+PojXpocE098RbYwPryN4e6?=
 =?us-ascii?Q?n2ffBuKuAo2y+qLq1EzZXCUQGlZLgURBprW3pI/GNDFsz6kcaU/otn5gJLi0?=
 =?us-ascii?Q?ZOajQzwE7EIZmQaVWGGTCB3HFlszokq8MOIFmZjlpCWrt77RAqJEWvS1FQsB?=
 =?us-ascii?Q?l3aiQbNMEDq3KUtBXePZCPCLFJlP4KHSdX1Pu/iPNk6xCChmZS8dwKMm+uon?=
 =?us-ascii?Q?SkvMLtnNcyVUXJ3be7kiKTLfP4uVdujEHRzFWaGDbIBhmKGbaPf7UG2lekn/?=
 =?us-ascii?Q?4pk1nSNJxjiQGxKNxjgI1N7d9h8Xjq6D8zvKqEFVL1838ClP/pmEfmgPo+YC?=
 =?us-ascii?Q?AyeJjborjv8erMXKbZlY8WWDMOycftjm7yveizybWnJ9VLCI035uOv/CIx15?=
 =?us-ascii?Q?kz2V7Hbn2PUJvyhkD2i5frtAs5QRopYXgi6bx50Wie9MqkX3yPTJRYJ6mVdn?=
 =?us-ascii?Q?GIUqksxvKPHfumRnaYt92AWiHE4v2gctLfmwccwsBRn5bcShIGCUWHY/y2bq?=
 =?us-ascii?Q?UVQJ5H9i/wrqF2BV11BMWqMPJ2hqK3ZeD/CgBGeJl+bCTFEa4KeQVYf2I3v8?=
 =?us-ascii?Q?De9oFOCYvkv/RMGUB2tIztfrrppkg54wW3TGXfkVGXCEA7qIac0WwPIhly+Q?=
 =?us-ascii?Q?KYmAtxAJi+vkCtqG+zEahe3HU6LY/llOJsor7ZYfP+1ZnDvJsRrfGIzhpWI/?=
 =?us-ascii?Q?Ni10cVDgXH1Hxo4j6rGQ4x27x8gSKabQjx+VDKaX4YYNMYbUOA2YrXIRxKcT?=
 =?us-ascii?Q?ipT9YncLQaCqeOB6+8U8IX6VflEAHfClptdwCBI01iO0qJ4laCpX0RjalmzK?=
 =?us-ascii?Q?Whw0j3zL3Bep9AYiZnxkOOFgDQJ2VOAK2Nzr5b8C/dCHqSTMqKWPzgdFQYni?=
 =?us-ascii?Q?FEWxXsTLWa7HB4Bm2TkIyy0R8VPXSkCFmWjc9Dskum+AreaNuUOdF716VAU3?=
 =?us-ascii?Q?/5qaLHMt+jsThec6pU5dwm85c0Rqcl13wQUmqiu6VaeF3YXZoE/jbn+6mzGM?=
 =?us-ascii?Q?KWkj0SbK+4cn/CTGGSC/f3Y1DogxSXlcEE+TxRgSm7O76cFhZ/EKxyqKOges?=
 =?us-ascii?Q?QxpL78MovXBds1lyP/KuLVamz98s5nyKroSQSSXeB/HcuZ7g6mW0Td3jBDyY?=
 =?us-ascii?Q?MZFD9V0yVH0hpuzQsSJY8AXClSTzOczHR7KpVA6ekJQnVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Gsp/XezyCnW8c4npm226enooUwgRghM13XF5I4QSDoVAJ2P/FfOZPqIzZ4s?=
 =?us-ascii?Q?yGOZbQbuN5VyIJLjIzAWppJpgf2z/Oyyp2XT7vkaCc9e8PbSwAkpMiJ/GRJw?=
 =?us-ascii?Q?9sknnUip0OftSFl4s4SxoPTu0T1AnTZhbpY+KJ9VDAriVxJRyJaKsg9IywoY?=
 =?us-ascii?Q?7XvJFwvqQP3EMojmdK2I4c+94b6TJB86FWTVu7ZiMVBVgLeLxN4qCR3EJ/rl?=
 =?us-ascii?Q?c8vd7RwZA20bQL/4xZJLHaIcpcipuYYXBNTEFGBH6J/+RMK5Ma/I4kykemdS?=
 =?us-ascii?Q?K8hFHVYp1qknPubdeQ0g1IJhPR5zjkhbB5X962OErh3BNdAan7DXVus355Fc?=
 =?us-ascii?Q?zl+HQZlh8iDEDKSxP06tnhMR2k3gqvL5MECVKlAJjTP3ae1+844tBW/UqAv9?=
 =?us-ascii?Q?ma3ZZzmLU8zgyIL3FcQRh/lptqRJuWMKz/20OsBoXRZVrTLxabZvjdImrd60?=
 =?us-ascii?Q?w0Nv4fMVn/q8zsgRrttHIU+nXQU25UHC+hr1Lm3Zk+6cTLe+8sz45f00whTf?=
 =?us-ascii?Q?PFN5Zw+o3EoIYlfyySGopaFt2rObcfZI5qAMl6Wx6zpdHsxb5UA0iJr5b758?=
 =?us-ascii?Q?eftinkuzzFzQOx2SR7GJ9qb88cYtRN2rXs3UC+B+p0lPGBqTJHGGq9H4MuyR?=
 =?us-ascii?Q?8UV921yd0Y0Ro7yNBdtGh/puloXrr2WXzLwpbNYIm7OcN/qnDUGuJY1FQT2C?=
 =?us-ascii?Q?ayjyu8cN9LB1x7+P1KAK7oYOMwGlhYzXBVSqMYuivMMXO0u3GjUAkflqZzIM?=
 =?us-ascii?Q?GfEc1jPo9Ar0IvexqhV17KqgRGjGrbTxS5fBOnTUOtNc+9sZ0uRV+W5ufghY?=
 =?us-ascii?Q?Qa5S6k4IdRi4xuErujDo42SJXn0iUB+NTBMOKjQzOr7pjXKS3yrFTFG8kYUE?=
 =?us-ascii?Q?1ouDdlJGtPQMJj+LWBnq2nbNW0nY/5blCJ+A6P7T4QBTaBje6vTfH0HYSFxM?=
 =?us-ascii?Q?hN8+Pj0VLKJc0KQjMsi2TCwX/TCMXSdHeFNb9egHL40pOPCyHvts8etGn9jg?=
 =?us-ascii?Q?zzBu81Jdxk7X36LgWb0w6L/GaLrP8n5/pd++Gw8PZ+z3qhwbNeRgqEGIsODL?=
 =?us-ascii?Q?FULir8OZxeVvhCBFeKqONpeS6woOkQ6zqFg2l0gQxI4CD+fFn+q6iKC3yQxj?=
 =?us-ascii?Q?Nnodr98nJDIZglO3FRA9Mvux4GkgZ8DRH3JQnk6XqpnpaUbu5Mg1dKlNWi2D?=
 =?us-ascii?Q?cNW9kQGxdpL9eATe+CFoI9xqspJ13AtwHx/iryg5826YZANij9gSfatot7PO?=
 =?us-ascii?Q?D8PYJt7hMogFXVjGHAny1oojBSwEo1flfAWSvC6gubNDRHyYOXXFFOg/HqVe?=
 =?us-ascii?Q?TlzQ0oXa1L3KYep+28MpTc39pXcL0NPZyx7gY+vkvf1geGLgnG/ekmq7mvnI?=
 =?us-ascii?Q?FurxMEm5hOtTXjcLk8U8soNnSh0Owrm+h3Ybj4KrVPcXjLMXPmdYbuVkVDRr?=
 =?us-ascii?Q?gypRE66kwYE2mDgjxRzlQYUSiBIk9CL8Byik2Qs8UsXYkv5NGJApf3642RxV?=
 =?us-ascii?Q?rn3MWF1um+K+AeqiYRF94xBV6aSGc3DHMUjyHHocYfSVI8pnUyS1P7df2sQW?=
 =?us-ascii?Q?1aRZ5lEgpyWutbOH2eckPqNCO/9UUQYwngA4P5vy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wMV1hKfF8GspphaBdMH6eKf8IThC+Tof4Ck4vfaurNvR37408Qku+C5oh88iNld4dDMkpQLZO5V2GaKC86w3Kg/TXVOdr1TJxA4kZTgJXEPtiuF5heUHh6rDmnioWUfTltwZdEXpT7Sv/H1+iBELeYP6wP6wtqKFGkK6PwulltnS3dphayHyXHEh6mYB4Q2qHM/MNSFpTRE5RvfYRNIYlMZrREbBnQmKmv/GxHRO4zb4RUeyb5wikIArG7F9zNORJxT1APAU0eI9n5EAN3grC8r5Qdgm+7O/GS/riA9XaXw2CU5lBIilYERdrXWi51iwJkfr2QviMeJzNv5I3fGNLY0GyOJlWPU2S14UKkzid5pl/+5xcZyGPdYtVKTrADl/hzk1D1CnwuBi75MxqFJQPk+fY6iwGP6ReGj9+PG4l17OxjHKKKy1KD7toEpRSNQhsR0IWpT8mlRXC1KnYubXEkTcue7yo+1LzQ+GFeayFa8sQNDIgZpo/rmb1lj15KyZ9Ikp0bdelXrD6e3jSzwbfw0tcoxxK5r1aFQwpCRgKl7Trt0CCM02LwK0SUqHusDTh+AUe7/ctGSRxVchLcCDX3/eKz90uhOBCQZT0FgfDqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4486f543-a2b7-4a76-683b-08dcbc00c2b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 01:31:03.3292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLsZof7WbyBvA232rFIfcl0SvMnBEfdKhI++vn+8CUVneC9tiJd4/yEWRHa9CHgeDcTTs86xQSBFsKilmcLspQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_14,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408140010
X-Proofpoint-ORIG-GUID: ayhkZUtzetiM_M0mgHGUgne2nsrZQiky
X-Proofpoint-GUID: ayhkZUtzetiM_M0mgHGUgne2nsrZQiky

* Wei Yang <richard.weiyang@gmail.com> [240812 11:09]:
> In comment of mas_start(), we lists the return value for different
> cases. In case of a single entry, we set mas->status to ma_root, while
> the comment uses mas_root, which is not a maple_status.
> 
> Fix the typo according to the code.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

If you are fixing typos in a single comment, we can probably do that in
one patch.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 3d2e207d9a5f..14ff54078f9e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -1346,7 +1346,7 @@ static void mas_node_count(struct ma_state *mas, int count)
>   * Return:
>   * - If mas->node is an error or not mas_start, return NULL.
>   * - If it's an empty tree:     NULL & mas->status == ma_none
> - * - If it's a single entry:    The entry & mas->status == mas_root
> + * - If it's a single entry:    The entry & mas->status == ma_root
>   * - If it's a tree:            NULL & mas->status == safe root node.
>   */
>  static inline struct maple_enode *mas_start(struct ma_state *mas)
> -- 
> 2.34.1
> 

