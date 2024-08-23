Return-Path: <linux-kernel+bounces-299604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 031CF95D762
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289281C224AB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 20:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1064197A6E;
	Fri, 23 Aug 2024 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W/pj68mx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vjSu6P8J"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A11953BA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443669; cv=fail; b=QUIhd99G7vSnHJeZheJoUnKbK6SHayLZIJBPgxv8kXZQChgz5Og5bwvZY6V54havz9duvtogrdVdPlk/ie3FGAH6Jo1uW4Cg+DEnfdFXSFEJcqr8RNJ+NYPBC5+H4bKF3o5kGThG9Sv7R/ts6v/aY31aouYvOJB/M/oRtljetR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443669; c=relaxed/simple;
	bh=M4J39YAwOeRdlPoYevFaLRQzmVmML0zfDX+BnXcwaoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kqf7cgrPyZAoUWHfJvr1T2AH78C6/CJMI9yvGbLMAlB1/ZFjUOw8mz5bssCJU33nNjBh+In5SG8Lv9Bym1hkHFEXVThH2lkEBCJi/gK+8z0a58VuSOWUOEyjDR5hzD0Gv9QXYz2dQvWjIJa9Rg0VneudbZhVTKjbH/FlngxGhBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W/pj68mx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vjSu6P8J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0TVV009515;
	Fri, 23 Aug 2024 20:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1cVRTGlz38lLREn/y2HwxJjhQMGObDwlsW1VGdwo/4c=; b=
	W/pj68mxauJvqxrNP1P8FmTOvMv+ZjgeyjXrkhHuZu/pWgYZV+cCINcNjOfR9ixX
	OZK8AW0lll4EYnm3qg0Jld3npAaguT1y/g7QWAhwSPSq8JDDycBYIqjMcQIKN3hx
	ztOu/yABLaIjddHGNHRlutGX+eUVb1yEJDHf0GiKviyT6SzkOd+8JyfXxAMCkUqX
	KtE803yTSDFG7sOOEsHJmnNSyO5jSk3XDOSmbjNJvGRq4qjCDgdEZA3BEROOqFOo
	LoPNvAZS4CIIkORz1Q/sJFWthsXh6b2/KGrv4wxFe1AkIA0WXREA/GYpw5UN2jDv
	DeUynedn/XafjhyOI2/j5w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dwh86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NJdCpX007466;
	Fri, 23 Aug 2024 20:07:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4170s5gxw2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 20:07:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiFtiCzSFgG83OUTLGrumg9HW4pQc3MraH2xOrvCwPBT3i+5Y5zjCI7oluGkSkjhAIwMDEI75D+pPyr4KrV7SsOAReXE2wA6FRw71RiDhyAkWZOFKvlafMLNkvMFLsx57YxBr0SiZTkFpIs06NbhewHgp5UbGbyedo2vCqGEYelrQFn7N/oLVBL43Wzc5cI9/ruxUMmcS7A/PDXUOzNvN2wad0cyYp0HZzmADePHGjhlQDZdQwa9g9efp6Ua9m1lhRFIFu/8iGxUjIglsYoLxv0v6EmsUA9j4jxoS6ZpuE/CyF5gtfm3dg64tq8crdDiWKx5MC7Rx0vtPP9oP5/eiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cVRTGlz38lLREn/y2HwxJjhQMGObDwlsW1VGdwo/4c=;
 b=aER4cB120KJAWdr4PIeKCzT9e54s9J1QnNRCTAjwI9o2xvsI0/vkz4AynLr9JyYNvRqt5sfu9Z0aizGcuPrr1hWBVunNSC1FUO+fK9xJWZegopnNKqNatAK883s++chbTVc3Wtznr62y2RFNlbiJ8J40XjeftajSyhfuemq2W/b1zv56MSLQ1XkXQVcwGO7cllrDRX1J3BqidvkkzZe9ue0H8pPNR9FtUl8neqF7BRRF+3J5QPbgjUJDZ1n3fKVRCPhFbRy5OTDFe1znBPC0eISCikbdBcQp+qPN+HgF3qRAZ43I1i0nNa4qDg0xcN9QB+T1A2AsbRcsps6tU+VTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cVRTGlz38lLREn/y2HwxJjhQMGObDwlsW1VGdwo/4c=;
 b=vjSu6P8JD+qGGLzv3RAoBeaEvY7cW935RzDIdOhHQjNKkjVne9PuZRH3MtCIglY6CTbIZFNx3JxbUayFXUrqcTe2PX/OGMKcaqdKWOf//c7Ji/vAe1eOWTcI0yz6ysmx0yUEY+nyqFGE5K04muLaO5fB5Pt6tSBdgnjtgjBff6Q=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6187.namprd10.prod.outlook.com (2603:10b6:208:3be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 20:07:28 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 20:07:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 07/10] mm: make vma_prepare() and friends static and internal to vma.c
Date: Fri, 23 Aug 2024 21:07:02 +0100
Message-ID: <b063950be644779efb9a367fda9f435df8162605.1724441678.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0466.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a68a9e-97e0-4777-2537-08dcc3af3689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Omji4YgGzU6PTVTPsazPKKOl/CtjJ6wxu3pu2HoAr2uTHjOtZBbq3LHIsdkv?=
 =?us-ascii?Q?W7/5dI42wd6yOjWdeUOzYhhwnUSWPl9LL5FE6uHRjp8m3b4uGcZZBgGYoHwO?=
 =?us-ascii?Q?01KeYqNKEHZ39bQlpUaqSuhK6jRH1+iohl/WlnansPEzV/4DSlYCrS0u9k9K?=
 =?us-ascii?Q?QZQ8XONMJ0k5IkFWXg3uWID5BIova1nn1f+nk+AoRmcNAc+gVGISrBSSde3P?=
 =?us-ascii?Q?tp/1jWk/JjZFJybzFDQ7baSO4Gl1CQYCVPWFZ5WRaEKJo8vGb/2jma/bFJy8?=
 =?us-ascii?Q?dNW/iQi8viQIOouvx9EKMYcq2Ui9qLRQk9JuacLkU9cO+0rqgtbfrvyFU9R3?=
 =?us-ascii?Q?Xve4R8FPdp2GME8H5VNPsiFtrkgGg6IR0924l5MgbKBLJ9GCn3jBpB/f5/bF?=
 =?us-ascii?Q?Mbxe+hhaWVWoQwdyCcepJ0maebW8MpFzsGJ9cl3yszT19yO2QUvaK0lS7FV7?=
 =?us-ascii?Q?Vlu0Fioot69Q7aowh2AlwsEcIH5ij3vQ7nrJ1fvVllrsJIL+wRLfpqj1NAUN?=
 =?us-ascii?Q?BsIOwqhI2GnSHywoF13xeyQlndcgjc1XnaS+FfDbRQnhk6QTrElt8BtFnlLX?=
 =?us-ascii?Q?gqJWlwiIrpPxibhX6kmhfgcS0KAEhSQKROFLQpab+hEHn8x34SRRKim6pVki?=
 =?us-ascii?Q?HPJueI+FdnKEFMSqTnqUdorkGXY0haeDZlig7iHJVqLWBaXryoHFVbV9j/0U?=
 =?us-ascii?Q?MmV6yLWxT63HeZnxPIIKabVpAME1+tRLv0CWC8M7EXLjy/dTnIewH5whwSc/?=
 =?us-ascii?Q?BSD2UdTjAydjFNZvahozNx/p1lD3MqEnE8NUH+7uqxHoDC33n7zc7DAC7M4g?=
 =?us-ascii?Q?jkJoegY21i9239fDuqf1dOhYhdkTafqcNnK1SnrUf4I69ppU7raRqwu3sohP?=
 =?us-ascii?Q?DKZsGg4dVJk8sWvq7b8P1EI4GbrffKfOhXPgqBcZWM0bDEBOMtOoEj+3zvaM?=
 =?us-ascii?Q?Uy68I9NzqqvISQ9PJ1HZR+4D8JOg+Ji17VH2xNyb3kQvqCgV2NzEYkrOwopw?=
 =?us-ascii?Q?M9Vf6y1UFc+M/xayH/gwwJ4DX0rtRoD/LEsLsu1o0rWpYY3bh2EASWTJqbns?=
 =?us-ascii?Q?xXniigxVmwCe04Q5FFjN8Lw9kFE9RzARxgRKhvqU1tw0shfdeVGIJWZM2zLH?=
 =?us-ascii?Q?35kz/PHSs72mZK1lmr2mD/Y24rC6D+cSjsFPSCP/jOQmTUJs/YRQ3TRotm6Q?=
 =?us-ascii?Q?77GosbMJ7JD0yuwtGhH5289nkaVtwDq1+yYQrHbF+rWhp50n6wr0o1gMCsxz?=
 =?us-ascii?Q?w7lJ6acI8mKEJxe8xA0bIFiVT78Afc9PYPJ1GrBq7Okj5FU9psBvGJKjP1vW?=
 =?us-ascii?Q?anGkxmi6BLtq9Eagu4Js87aHU+Ow+DRar+L81XAHCMNXHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkNR5uyHQ8l2rJu1EcdiLXZzEiokR3wzSOi4+0qHwWSnktKO4TcA6P6RLvgY?=
 =?us-ascii?Q?+5BAOC1EcfuznVzDhw58WKAeoj4Dr/g/2qJ+iatYaNnz+XeLnMayAYabxh96?=
 =?us-ascii?Q?kXKxpFEoRSARacXyRau9mcQAnix+06iBuLwFM7d33y1nM4+GRUaRQ22x4yk6?=
 =?us-ascii?Q?P8KCMgtgBjAk3/GtkDCwr9ZuOTXuidbmGsTY9j3ZGgknAeKgBhViRfMG8i6L?=
 =?us-ascii?Q?Fv/jFycJbDLZD11VxO31vsN60iuyaSf+BeGkfTEUFqHdlwLpc1+yl0hBECz0?=
 =?us-ascii?Q?rziy65OoaEPR5jSqdw2+t+uoS8vd2/WaCXO1KubsjHw2Zb8SBYLA6KsqWzCE?=
 =?us-ascii?Q?q1sry8r3YkUMyUAvysTS14GTet7vnzpsNk8JdqrIOwDF5rXHGbKeCZhGkRpP?=
 =?us-ascii?Q?Dy194k5EPmDnLGxNHk5mOi/Ro2Aa/twytxl2rm2j3jBczgw0ps2o5uTHJVbC?=
 =?us-ascii?Q?jcm6D6gP0GivsWfbh6Y0PsaDAuC3PToXq1GAQuWZm0Th0whwtFBr1QcYwLnr?=
 =?us-ascii?Q?xIEdhkeOEUXKi2hxkqm+rSpX6ucSWhHPKjEUBZ9+rNtrDCuxs6m22wYOISHI?=
 =?us-ascii?Q?rQW+py7TlhfkN187co+zIe7DFNMmFtL9mWvF67wjfT8io65egAjG4jwrS+dY?=
 =?us-ascii?Q?ICj9CgjvDJKIBPj5ZIy1FNdMq1t8niseLaFB93uNqG4gOhYKuoxtB1+/UOCd?=
 =?us-ascii?Q?YGoB8vd09pQY7jxPzy7DXe6Jk5HfuHtMtnTgrFlNi5LTti0xmr/UfGIl7yDj?=
 =?us-ascii?Q?r1PaUSlvrdN1yGLz3wNXSMS5a+G1YT3ipB4k5rcajFXW96SYxC/7Mrw+OiGj?=
 =?us-ascii?Q?eKDVVjGM9SJnPREJ5DqyCCj+pXzhOngMewNHJtLH/6AEcITJuuAVhtUIGUcD?=
 =?us-ascii?Q?JhXUscIVM2AFISVHGI+i+fQcYJLQ7E5FA/mNWIRmCxFQBMMC0NQTBCiVVxAs?=
 =?us-ascii?Q?1Nrqe8ia8G6K9Zi6b15nOTzJHU6sKxKs0FF2sEW8D4UoJXn+i9FF1r6S+4NZ?=
 =?us-ascii?Q?Jt4lHhBkxCGvf2NiXxarO9U5p24tLslhVlgmGyCU/mlH9GU7lHqccabqzyaI?=
 =?us-ascii?Q?wlYGAyvpiNAO+fnPw4pppiLSpsBLsMDTpV8MYxM633SYLPOgMqc5VyGV69mV?=
 =?us-ascii?Q?0kEmQDfnDmQ2C15wigyf2HsJ8bSyU0LTir5jGuGfWFjw5NYlDjMnZNRkmvbq?=
 =?us-ascii?Q?DKkGSqIDZFdN3Og7lQ3RtHUKgw+rMN7aHsf1EPU82igbMfz3fcP+xDsFUTX/?=
 =?us-ascii?Q?fDdwDHyBrX8dfuRhI/zrSx5Pq5Efh4If8JQSStci26xOezVY4A0aShRI+2/P?=
 =?us-ascii?Q?u/XBHvWrA/43qKp+l3sWc1P9sZXrqG0dxOXLhOWYZPz+/L3dDBs9L8V1B4BQ?=
 =?us-ascii?Q?EImeMHSQ0e7/533KcVlM5zuqjge85k2ztorXELbZbv/sfcXmrIGkM7UbCtq+?=
 =?us-ascii?Q?ELdQY97tcMjoH447X3AVHQ72OvlFl6ZktBTA0sZIYSzuli9F+txeeBgGMygq?=
 =?us-ascii?Q?DKzruisad7gGJZ3v+2nnVmDfNnuboRPbAL02GV9MhxqxMugJXv9o54lYSi3z?=
 =?us-ascii?Q?/1AZM4ZgaJV2oYSESoJLazGhk0htT+3pSbsug/nvXkRySWIRrXFYEcYIAnMn?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p3oIQaoQta40t5TnN0uxPz16tAqNnWfFPxgpmwXBbWCdRxK6jfrlokC/GCK1ZXcP8D1dKYHeHRlFnG8XIRStAWwAHtEwss5TVF69MLweCsfTbSiTZR1TTGUueQlWw4Mm7kt8VZrUKOkTPTEL0GA8VA26ppiZ+338r2iQQGOj1A4QoqLsgNrrVsZ9SQ4Xz3ltDOSM/81bKSDEcJWVNy/bhd0+NcKj214xermHRH8Q5Oc46a9DBRT6hY4M78U87NlrI2o+YBvnvvVOYPSQFEb9VDgS2uNA1HpTWR7DxYiyphfXMLEgJ1dSQt4YdR8OLqAmyInqUTCPzReRKnuz3cqqL0BHA9My54GD+j2L8G+x+3HtRwp2gGSxi+lYjEoI+Y0xLszy/aaPvl+At0RyEAcsslrdj6e3WN9S+hmKhcCXypPiJs7Qw4OqYt35FWu8lI6T5Uv2YqvLh6yUjiPGLgMBaf0AIQmPO5qriAXYpCikHYJ2OTxIehA8yDg73jFBmyfTDuVMLVRJ7uCA7OJEmISDb6J9hjiJFhb4EStmvWsJiCpKprjeAjCjrXqqRla7JiWNtLu9+sta+3SQIqIRF9ay9GoQskrWkgefZabxYErMOj8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a68a9e-97e0-4777-2537-08dcc3af3689
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 20:07:28.3690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDZTnh8A6PnOO4mK8Ti6z1novpLUXlsKI0L5HPTXFViu62fcGGQMIfnbGJIxJI+tNiRw+hdPaA3zCC8nZYETaTg7PCEZ5w6gcTE6seWxfbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_16,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230148
X-Proofpoint-ORIG-GUID: ugOaNlQnvPZZIOj264AVEphZos-UXtyD
X-Proofpoint-GUID: ugOaNlQnvPZZIOj264AVEphZos-UXtyD

Now we have abstracted merge behaviour for new VMA ranges, we are able to
render vma_prepare(), init_vma_prep(), vma_complete(),
can_vma_merge_before() and can_vma_merge_after() static and internal to
vma.c.

These are internal implementation details of kernel VMA manipulation and
merging mechanisms and thus should not be exposed. This also renders the
functions userland testable.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 318 +++++++++++++++++++++++++++----------------------------
 mm/vma.h |  25 -----
 2 files changed, 158 insertions(+), 185 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 8a5fa15f46a2..07df0d5fb3d2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -97,8 +97,7 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
  *
  * We assume the vma may be removed as part of the merge.
  */
-bool
-can_vma_merge_before(struct vma_merge_struct *vmg)
+static bool can_vma_merge_before(struct vma_merge_struct *vmg)
 {
 	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
 
@@ -120,7 +119,7 @@ can_vma_merge_before(struct vma_merge_struct *vmg)
  *
  * We assume that vma is not removed as part of the merge.
  */
-bool can_vma_merge_after(struct vma_merge_struct *vmg)
+static bool can_vma_merge_after(struct vma_merge_struct *vmg)
 {
 	if (is_mergeable_vma(vmg, false) &&
 	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
@@ -130,6 +129,162 @@ bool can_vma_merge_after(struct vma_merge_struct *vmg)
 	return false;
 }
 
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
+{
+	if (vma_is_shared_maywrite(vma))
+		mapping_allow_writable(mapping);
+
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
+}
+
+/*
+ * Requires inode->i_mapping->i_mmap_rwsem
+ */
+static void __remove_shared_vm_struct(struct vm_area_struct *vma,
+				      struct address_space *mapping)
+{
+	if (vma_is_shared_maywrite(vma))
+		mapping_unmap_writable(mapping);
+
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_remove(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
+}
+
+/*
+ * vma_prepare() - Helper function for handling locking VMAs prior to altering
+ * @vp: The initialized vma_prepare struct
+ */
+static void vma_prepare(struct vma_prepare *vp)
+{
+	if (vp->file) {
+		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
+
+		if (vp->adj_next)
+			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
+				      vp->adj_next->vm_end);
+
+		i_mmap_lock_write(vp->mapping);
+		if (vp->insert && vp->insert->vm_file) {
+			/*
+			 * Put into interval tree now, so instantiated pages
+			 * are visible to arm/parisc __flush_dcache_page
+			 * throughout; but we cannot insert into address
+			 * space until vma start or end is updated.
+			 */
+			__vma_link_file(vp->insert,
+					vp->insert->vm_file->f_mapping);
+		}
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_lock_write(vp->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
+	}
+
+	if (vp->file) {
+		flush_dcache_mmap_lock(vp->mapping);
+		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
+		if (vp->adj_next)
+			vma_interval_tree_remove(vp->adj_next,
+						 &vp->mapping->i_mmap);
+	}
+
+}
+
+/*
+ * vma_complete- Helper function for handling the unlocking after altering VMAs,
+ * or for inserting a VMA.
+ *
+ * @vp: The vma_prepare struct
+ * @vmi: The vma iterator
+ * @mm: The mm_struct
+ */
+static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
+			 struct mm_struct *mm)
+{
+	if (vp->file) {
+		if (vp->adj_next)
+			vma_interval_tree_insert(vp->adj_next,
+						 &vp->mapping->i_mmap);
+		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
+		flush_dcache_mmap_unlock(vp->mapping);
+	}
+
+	if (vp->remove && vp->file) {
+		__remove_shared_vm_struct(vp->remove, vp->mapping);
+		if (vp->remove2)
+			__remove_shared_vm_struct(vp->remove2, vp->mapping);
+	} else if (vp->insert) {
+		/*
+		 * split_vma has split insert from vma, and needs
+		 * us to insert it before dropping the locks
+		 * (it may either follow vma or precede it).
+		 */
+		vma_iter_store(vmi, vp->insert);
+		mm->map_count++;
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_post_update_vma(vp->adj_next);
+		anon_vma_unlock_write(vp->anon_vma);
+	}
+
+	if (vp->file) {
+		i_mmap_unlock_write(vp->mapping);
+		uprobe_mmap(vp->vma);
+
+		if (vp->adj_next)
+			uprobe_mmap(vp->adj_next);
+	}
+
+	if (vp->remove) {
+again:
+		vma_mark_detached(vp->remove, true);
+		if (vp->file) {
+			uprobe_munmap(vp->remove, vp->remove->vm_start,
+				      vp->remove->vm_end);
+			fput(vp->file);
+		}
+		if (vp->remove->anon_vma)
+			anon_vma_merge(vp->vma, vp->remove);
+		mm->map_count--;
+		mpol_put(vma_policy(vp->remove));
+		if (!vp->remove2)
+			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
+		vm_area_free(vp->remove);
+
+		/*
+		 * In mprotect's case 6 (see comments on vma_merge),
+		 * we are removing both mid and next vmas
+		 */
+		if (vp->remove2) {
+			vp->remove = vp->remove2;
+			vp->remove2 = NULL;
+			goto again;
+		}
+	}
+	if (vp->insert && vp->file)
+		uprobe_mmap(vp->insert);
+}
+
+/*
+ * init_vma_prep() - Initializer wrapper for vma_prepare struct
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ */
+static void init_vma_prep(struct vma_prepare *vp, struct vm_area_struct *vma)
+{
+	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
+}
+
 /*
  * Close a vm structure and free it.
  */
@@ -270,31 +425,6 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
-/*
- * init_vma_prep() - Initializer wrapper for vma_prepare struct
- * @vp: The vma_prepare struct
- * @vma: The vma that will be altered once locked
- */
-void init_vma_prep(struct vma_prepare *vp,
-		   struct vm_area_struct *vma)
-{
-	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
-}
-
-/*
- * Requires inode->i_mapping->i_mmap_rwsem
- */
-static void __remove_shared_vm_struct(struct vm_area_struct *vma,
-				      struct address_space *mapping)
-{
-	if (vma_is_shared_maywrite(vma))
-		mapping_unmap_writable(mapping);
-
-	flush_dcache_mmap_lock(mapping);
-	vma_interval_tree_remove(vma, &mapping->i_mmap);
-	flush_dcache_mmap_unlock(mapping);
-}
-
 /*
  * vma has some anon_vma assigned, and is already inserted on that
  * anon_vma's interval trees.
@@ -327,60 +457,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static void __vma_link_file(struct vm_area_struct *vma,
-			    struct address_space *mapping)
-{
-	if (vma_is_shared_maywrite(vma))
-		mapping_allow_writable(mapping);
-
-	flush_dcache_mmap_lock(mapping);
-	vma_interval_tree_insert(vma, &mapping->i_mmap);
-	flush_dcache_mmap_unlock(mapping);
-}
-
-/*
- * vma_prepare() - Helper function for handling locking VMAs prior to altering
- * @vp: The initialized vma_prepare struct
- */
-void vma_prepare(struct vma_prepare *vp)
-{
-	if (vp->file) {
-		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
-
-		if (vp->adj_next)
-			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
-				      vp->adj_next->vm_end);
-
-		i_mmap_lock_write(vp->mapping);
-		if (vp->insert && vp->insert->vm_file) {
-			/*
-			 * Put into interval tree now, so instantiated pages
-			 * are visible to arm/parisc __flush_dcache_page
-			 * throughout; but we cannot insert into address
-			 * space until vma start or end is updated.
-			 */
-			__vma_link_file(vp->insert,
-					vp->insert->vm_file->f_mapping);
-		}
-	}
-
-	if (vp->anon_vma) {
-		anon_vma_lock_write(vp->anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vp->vma);
-		if (vp->adj_next)
-			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
-	}
-
-	if (vp->file) {
-		flush_dcache_mmap_lock(vp->mapping);
-		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
-		if (vp->adj_next)
-			vma_interval_tree_remove(vp->adj_next,
-						 &vp->mapping->i_mmap);
-	}
-
-}
-
 /*
  * dup_anon_vma() - Helper function to duplicate anon_vma
  * @dst: The destination VMA
@@ -675,84 +751,6 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 }
 
-/*
- * vma_complete- Helper function for handling the unlocking after altering VMAs,
- * or for inserting a VMA.
- *
- * @vp: The vma_prepare struct
- * @vmi: The vma iterator
- * @mm: The mm_struct
- */
-void vma_complete(struct vma_prepare *vp,
-		  struct vma_iterator *vmi, struct mm_struct *mm)
-{
-	if (vp->file) {
-		if (vp->adj_next)
-			vma_interval_tree_insert(vp->adj_next,
-						 &vp->mapping->i_mmap);
-		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
-		flush_dcache_mmap_unlock(vp->mapping);
-	}
-
-	if (vp->remove && vp->file) {
-		__remove_shared_vm_struct(vp->remove, vp->mapping);
-		if (vp->remove2)
-			__remove_shared_vm_struct(vp->remove2, vp->mapping);
-	} else if (vp->insert) {
-		/*
-		 * split_vma has split insert from vma, and needs
-		 * us to insert it before dropping the locks
-		 * (it may either follow vma or precede it).
-		 */
-		vma_iter_store(vmi, vp->insert);
-		mm->map_count++;
-	}
-
-	if (vp->anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vp->vma);
-		if (vp->adj_next)
-			anon_vma_interval_tree_post_update_vma(vp->adj_next);
-		anon_vma_unlock_write(vp->anon_vma);
-	}
-
-	if (vp->file) {
-		i_mmap_unlock_write(vp->mapping);
-		uprobe_mmap(vp->vma);
-
-		if (vp->adj_next)
-			uprobe_mmap(vp->adj_next);
-	}
-
-	if (vp->remove) {
-again:
-		vma_mark_detached(vp->remove, true);
-		if (vp->file) {
-			uprobe_munmap(vp->remove, vp->remove->vm_start,
-				      vp->remove->vm_end);
-			fput(vp->file);
-		}
-		if (vp->remove->anon_vma)
-			anon_vma_merge(vp->vma, vp->remove);
-		mm->map_count--;
-		mpol_put(vma_policy(vp->remove));
-		if (!vp->remove2)
-			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
-		vm_area_free(vp->remove);
-
-		/*
-		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we are removing both mid and next vmas
-		 */
-		if (vp->remove2) {
-			vp->remove = vp->remove2;
-			vp->remove2 = NULL;
-			goto again;
-		}
-	}
-	if (vp->insert && vp->file)
-		uprobe_mmap(vp->insert);
-}
-
 static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 		    struct ma_state *mas_detach, bool mm_wr_locked)
 {
diff --git a/mm/vma.h b/mm/vma.h
index dbcdf1431014..edc9034d675c 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -132,17 +132,6 @@ void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);
 /* Required for expand_downwards(). */
 void anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma);
 
-/* Required for do_brk_flags(). */
-void vma_prepare(struct vma_prepare *vp);
-
-/* Required for do_brk_flags(). */
-void init_vma_prep(struct vma_prepare *vp,
-		   struct vm_area_struct *vma);
-
-/* Required for do_brk_flags(). */
-void vma_complete(struct vma_prepare *vp,
-		  struct vma_iterator *vmi, struct mm_struct *mm);
-
 int vma_expand(struct vma_merge_struct *vmg);
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
@@ -273,20 +262,6 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
 
-/*
- * Can we merge the VMA described by vmg into the following VMA vmg->next?
- *
- * Required by mmap_region().
- */
-bool can_vma_merge_before(struct vma_merge_struct *vmg);
-
-/*
- * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
- *
- * Required by mmap_region() and do_brk_flags().
- */
-bool can_vma_merge_after(struct vma_merge_struct *vmg);
-
 /* We are about to modify the VMA's flags. */
 struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
 					struct vm_area_struct *prev,
-- 
2.46.0


