Return-Path: <linux-kernel+bounces-555091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A8A5A552
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A1D18924FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEFC1E1C02;
	Mon, 10 Mar 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eHXNzQOq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pe1mW3Ql"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAF71DF747
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639912; cv=fail; b=OebR7ioVTwKv68JWbBx0IGzXuIlZe2MmSHrBsRThhcIEwk5YrjcYjr/fI/VxZWIgWhB345G90drOn8NotkLkT2JL15TywQFNOD++ifT5Q0ceVVOiAU+5cDHmJKdae6uFPR9J2Ftjr8l+04UCksGzRBE0KAGJ8HTB99JIl+MPgkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639912; c=relaxed/simple;
	bh=6GX5JDJFniUayYx1/VHxqDsY4FRRHaOXJ6NZzmYVDF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2GdmXSB3Dc9R7HAqavbFOeuG5UUsuyMzG2OJWS4gmyutMnz0E7sKHAsq8E0mv11pIfOLHJkyYSLWI1PXLqNuL0cORq1qfvIYxyBV7Km0mr3vdhHgpi2Pzsm0jVTNOQmYjeIAhRHwk8YzGL44B5XJm7To62XyEnrKz3omK7F2ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eHXNzQOq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pe1mW3Ql; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJtmEq023148;
	Mon, 10 Mar 2025 20:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lPIlvW4NVmibYfzg4WPczV9X5P42nRAQz3FSSwbojDY=; b=
	eHXNzQOqgegnAJk+Cy8flHc88DPL/6AHzz4C93bvd48T3Uu7mHb3jZkx8wLyYnD/
	R8xQ+Zahb8CIcLXILC4YTGgl105u2AyCkoc4LsmBQYDfA22aJv3OWO4Vu8bScbOX
	4Ui9cm7BdIz3/NEml2K+XXCXiW/tXOzGPJ4/RsoGs47Zb91uRS3fcz6SpL74nhEx
	HykP2cnMg6dNE+uvfb53hA0XYehxLYNt5GoirbuSOn75dTZnWd2J3NiGI3c7FFc0
	g54mZoETahNIR/YjhQemCf0KfWffl6hT0VY5d98HwocSNc1rsUxlxfZtlKumBGTX
	fYEOCthDpkHUXsU2MJLN7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9kgu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKne4w019250;
	Mon, 10 Mar 2025 20:51:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbeng0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGDVWcx1zbqsqJTxyOavmh3RW6pKrMtZXYvWPCGpOLDUHtqJZA+dhVRdlYJvevi+X3gnRc9Ga70wzGKCSRc9WQIRW+WWVB8ZvYUCV2bd9tg+eV+5IKVF4165Z3tU+4sejcixS0pNG79nzAXFNpP0OAF8ANgukv0kxjn/JBEd82bwiIcAZQ2H3pipSACrNsWqWMui0ijbi/rDeZGcnNBQYyCLyGEX+WuyRi31adWZ5qjo8HE0t90lS0VSUZkVILIVyTJPenU6Hd7M9VHgg7sypYC1MRi3RIlVG5tv14DluP7KdaxUi+KA8yHT+eYb7Wwi2ysw8f/umCMZpggUxd+7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPIlvW4NVmibYfzg4WPczV9X5P42nRAQz3FSSwbojDY=;
 b=ZtA3lIr/O6ux/W4W0B/GF4KO924IRyKMfX12/VFRhhEeCcjns2xv1VnB38G7mQgxubHZYI6pi9PmUZWa2ifz2ed2Czubzt2IsjOv+cgIFQLgqhbgDZSbvH4Ucko/meiO7+hoZOBFdq9GTMj9uUIZ9VqWw7jb4R91hckTwoVViS3FSbfmxPf9JFiX5hXXPrH2YlTNUzjw3rjVtNrFrOO07zwMhhdbf04aCS11hmHpbqB4Tkg+ZItH3figFmaJv87SpZGCxZe1f7hTKe3DNOK/OiOsUYb9K92Ra7MwjM3fU+AEwpetF0Qov3TkGI6sRlq1cOn1uBf5DKRQpIN/COADXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPIlvW4NVmibYfzg4WPczV9X5P42nRAQz3FSSwbojDY=;
 b=pe1mW3Qly+SvoXzli4K4V7UH0hephW1uCLtOXdA9PwRHteKa201C/sXZhegvQxB+ZaPEIVjQOby5lQJHZyC37b8Lbbv466B8vArmLRkNh5jAzU71R8uxkN3BT/dv1nqNC8HSC+hsM5BGCzskLV4pah1H0DqanKy7M+qGDTlXDLk=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:51:26 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 20:51:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 2/7] mm/mremap: refactor mremap() system call implementation
Date: Mon, 10 Mar 2025 20:50:35 +0000
Message-ID: <fc4a925396dc3cc36791ec92c4d329209e816308.1741639347.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
References: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0008.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::16) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: c301f52f-10ae-4cb9-17d6-08dd601552dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0bCSX6gHEU7ZySAaLY6qEyVEOre2P+65fWmvqyDgYZAvclTkdd2mtFpCgHIe?=
 =?us-ascii?Q?oyGmz44WB3ECjADXrAamotsZyFKUngIQDmaIfap2VA3Pa+WC7he79LOsPQAv?=
 =?us-ascii?Q?5VdWL8yiOnA9UvzgZPT18+PI1n5gEO5WYpv+MVh/yXsB4yE26nzScHQrX+qP?=
 =?us-ascii?Q?EoYwDyRTAlKEh5d1u6YvUvzjki8rV9CC4uOfXPI1WCSzjoU0+vtU0QerTL8S?=
 =?us-ascii?Q?9iUu5wWUCGCJtc+4Z4D3GGrOKMkTjG3uOOZSVOMCr9Etkzb7KWXGN3nvq+sj?=
 =?us-ascii?Q?f0M1Y7ekvyfO0pDCkN+v7PuQ77XaTHxVhAJokgC5b1S3yQ3RgKHyPcSrCxLH?=
 =?us-ascii?Q?5hycyv+Lnsm71KBVwDiwLCl2fuaZ+YmY2sg5P/YpVxmpUoJ8bpOoer/yjvD9?=
 =?us-ascii?Q?J37s25P2AqwQBb0I8nEFJ9oq9/IAcs2sM1naoeCXpSehcFikqmfDDvhQGmiR?=
 =?us-ascii?Q?ihrNhlvSbCuC8d8FCZE2M+QZZtpXZWmMiW2NTrBuPHmNH85YK59hEIxPVng4?=
 =?us-ascii?Q?P2TXYAZhZnKXZOAhd6k0r8RTw7w8ftn8Tqunqw0uNpUhDAUVbi389PI3h+8W?=
 =?us-ascii?Q?HMCTvvQH/DhvWJzC0wM7beXBHWgnFiVGJetudxGvkKA4B/Kplupz+1w5710I?=
 =?us-ascii?Q?o6QEpUXL6EVIFvObz3q7Nk3x2OMf2aWbQE6EiNnuEW8xAbt3v02UUtKlWCGK?=
 =?us-ascii?Q?PL/rVY5f8grG/h3GAIZPWd6kXxu/JauF9jbBfqxOsFZ/dMJRvfcb+x7ldDeb?=
 =?us-ascii?Q?tVPxYJGNrFjkiVfAyFZtdjHS9L5XYnbgZ6w7KPYCkNBnFtwApCM+yvhtaG8Z?=
 =?us-ascii?Q?r3mpp5et36ik6IIaPKX46BvQ+LnvwB194MHM/ypoXl+p3V4OKP1S9EmoPtIT?=
 =?us-ascii?Q?IQQRedb3oZWTwNFZRoe3p+Vmo7jDQlw9EB4D/Wuoh0/Jw/tU1RzIow++5pqQ?=
 =?us-ascii?Q?4v2UOy1V8tHYwMlUnL0kmD2k1lwGtOH0Ij3p8EXjXTc93PKfrAqHPI9J9Iix?=
 =?us-ascii?Q?UB3E9mmNiVw7eKnlZi0cZm89e9G16F3yB61OlA340hy6sAybbOYXdc66MXFJ?=
 =?us-ascii?Q?FGjKUY68VlBcZkScHhQ5t7EzAbqCmvXFBeN/FtLi4hFHd8R0qKodTGA45J3W?=
 =?us-ascii?Q?MVg1uo2JyDE7T6FCztBu3DlYyxgaXh4FEibiiMtUO/vkeiQ4FtpIQ5Az50CG?=
 =?us-ascii?Q?D1s691OXsJcRVQ9NxC/5vjnaQOJCogaaOmJWtFpg6ej29D9126LHsmwmRPgN?=
 =?us-ascii?Q?CBfte/wndLGv16T0sSxWGtRBon4LfIvaStEctvKTdbkHHqUZkbNRv81AP79Z?=
 =?us-ascii?Q?BKzvdwZYRj67Z8dh/6jY1+c9n4qnGVIV/7jh3fqWwn1g04d80jsU2EIWOIMY?=
 =?us-ascii?Q?eAgAILZihYXFNxpLFCn4O+MBsGxK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ZgExoJOW3xGcR+1Lj4zIuNU4zQfB/aHsGavJjyoQgEVV44XDu0E/uXIjJbx?=
 =?us-ascii?Q?/VsjQsal/QxdvbKhFolBPrSmDB+HhdPEuWRQzngtayt9+ENmqkiMYJcLKkDq?=
 =?us-ascii?Q?IRrF3kOd/gw23QMr0TNNK0m6ypF6eAtwFTrMhmAbNDNWGvwVlMWs2HisdZ5b?=
 =?us-ascii?Q?VjE53qhcrzZQRsZG9GSc6nvGCkMxtBUw253sT/htStgUDsmACEiBWxaHoM6j?=
 =?us-ascii?Q?cvLYpOSdHMNq9EEVGsWq03DwZeHmkd8Zhv4xgjyxbO4/tf/g5FImvMqvDSCW?=
 =?us-ascii?Q?jFK+xicG9mn2UBkAxo9xNU/1LMWMcVxK0huRoXqgZgGW08FUVRYTCh1BYs0U?=
 =?us-ascii?Q?4/RGFsh/zcEgaT7anCRvt8uGNEKAkpLc+p2d/KCpP0lPDZMgR1TSs2ifE1UP?=
 =?us-ascii?Q?+15DYCs4QO9Sgo4IesUwmEQ2anNfLVfID9jEYZIOGDQk0CWLaKs61BM9N1KV?=
 =?us-ascii?Q?5zY5DfrvW03odK1Vy9bu61oDNABfaw5MuUWypU9lug8wdRBhj7k0NIUWOlYR?=
 =?us-ascii?Q?N1DMv1Ax9sVG2ku3I2SZJv6JhOVrJADTRbn0/CZM42ZzWicy4LoMpZ9SsPMK?=
 =?us-ascii?Q?a79va8E9EEes/4d+yk19vwqqdtCd48vuZz+g67ec4uT+ejkb7FrvVsxs+s/V?=
 =?us-ascii?Q?cREkaujDiJMrguahQo6drGtAh6y1Fmj1hE0soj7aFaRH2PJWb8p/nrEyRsca?=
 =?us-ascii?Q?ZLaotsUuFd/5npHxKBFiWN1Ywx5cT4ftQAQVCn0Rg+bItzm3kHVwqrrUVuyj?=
 =?us-ascii?Q?IhnCw9i/IeX530OAPj0piW3HwVo6AMh37b8Lph7uM6tydGDoUio8rnyHcAFd?=
 =?us-ascii?Q?9m8dQIzbpLZ6aNbvkM3QIbFl23EHuTJgJbH5esSV7NS19pExLbLfTdKtZ7xQ?=
 =?us-ascii?Q?0o2+Mg4uR7jxGhiuN4PsYNppBBDlbsAsp5Yr1+ZltmnAwtIVNW9rE2QL3ZDk?=
 =?us-ascii?Q?glRodzrdetF47pNR5Bd5IyczPvfdjFE/+5yCyiUhiemoWcQeHiCvumF9S4sU?=
 =?us-ascii?Q?084ZX2i7nuh5hi/L89pgRGxM65iuSa0wKXXsNjamjxmVqZk/cDxTw6W48NCm?=
 =?us-ascii?Q?xjvbVvreie7hxGvYHFqKkzgF4TUojVaMIBlzAl33MHGFkP2pL7mGRftcNwad?=
 =?us-ascii?Q?++DrmUciEpDwrHwzUQP/4RkR7mFb/mRA8jPoh/mU1JUb9PKf5ycWVEQtyYq8?=
 =?us-ascii?Q?uRM92dhnFuXiq2W20pFACBvjar8zscjCDWPdreZxmwmdFSGaPQRbyfA0TxZF?=
 =?us-ascii?Q?VLeYxj2sWlnwbBFN0fHyh1/LZguauUHfxOhQM78TNK3b4ifm65OfF64ZCUVa?=
 =?us-ascii?Q?JCgwLDw3VcBl8gxUYV/1zBEep8oztS26EY0B+SEu6Ez/vqYNQbgCUnSmRUo5?=
 =?us-ascii?Q?nbt7ZjZdol57TSng33A3ilntd4ndQcyJbGpMEeSa8B2SxgEI93HBjB5QAjc6?=
 =?us-ascii?Q?b6wbVx4/Q+17hcnEP6suQ5e+DmliFn9S6wqgZ8VWIRmCquJ9LYOFo5pLiqOP?=
 =?us-ascii?Q?xxN/PE9lH9hT/gcwJxHPI5biXNHwxFS7ei5denHexO0MZgV04EAVfkZZTypW?=
 =?us-ascii?Q?hpgzDDnA3Icgg90XV+WKA3Qos0cztKSpr0xtpbn3e2GgHk0UXSYVjwzcrPZa?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6qpmNcJGymKJjv7rDQAMpa5rsF34miOK34/to+qktAmFw/2vJe8ptLCmy/SOsFmxVU7g2tjthTHyttP17I1K2caXQAoPTvpWXCcKk1mA2qMuUS3AK2IYEfnlOgdIA91PlKaZ2IIXWDnsgCwvu4ybMvqg2MhrHYM+9CceCsR9Ts7Z8Qn+9LAZMb6IYyUs6rUs6C/gMZXJX9hb5YWrBljRCUkjoSdgXNl6RUPiH8CW/MLfeWJ2tKWMUFOtvsI/R0uycpOvQaXlKUeqpBvfejqRpo/1G2wVsqgvGGfKUkDqe9ELSuoEBOIynGtmcmA25ts+eCafCZ29PZyLAXA2gYP0aL1+b7StkYl1I93NHF4FNUDrv8fP/ak0aB62nbl5B28q2rUUx8ajBj38Q32weolhCfAsVDkPznziJAdOlMoBKkjEVWi9GWN4zJV5hQRFndUb/x45tqDCk1IfQ/wnMYRGcfuTvNElX+OR/7SpHk9KI+0Z6MfGzeSGHjpS0+h0+4RZbyz17J4fo0VXsxAmRduXTskA9AlWHSGoXV9P53Fnu+JsAo7uZ9HD8nW55vikA5PC8vYVc2RLmD2c0mqc9B4DncqPc0w6dfGLaYgzMA+NBgI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c301f52f-10ae-4cb9-17d6-08dd601552dd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:51:25.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6vhJayURDxaHsC3Gc7wGJGinSY4ZKfnZmc2F51vrqOy7tCuadhc1sTG4rELt2p/X9nULDRMEYzkYrM/uhtrKVXCtufi5fwuJ/+k3/TnYpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100159
X-Proofpoint-GUID: 7CtrwClCzbIXHVpe-5C2xzszkbvyyP9C
X-Proofpoint-ORIG-GUID: 7CtrwClCzbIXHVpe-5C2xzszkbvyyP9C

Place checks into a separate function so the mremap() system call is less
egregiously long, remove unnecessary mremap_to() offset_in_page() check
and just check that earlier so we keep all such basic checks together.

Separate out the VMA in-place expansion, hugetlb and expand/move logic
into separate, readable functions.

De-duplicate code where possible, add comments and ensure that all error
handling explicitly specifies the error at the point of it occurring
rather than setting a prefixed error value and implicitly setting (which
is bug prone).

This lays the groundwork for subsequent patches further simplifying and
extending the mremap() implementation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 405 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 251 insertions(+), 154 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index c3e4c86d0b8d..c4abda8dfc57 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -942,33 +942,14 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	unsigned long ret;
 	unsigned long map_flags = 0;
 
-	if (offset_in_page(new_addr))
-		return -EINVAL;
-
+	/* Is the new length or address silly? */
 	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
 		return -EINVAL;
 
-	/* Ensure the old/new locations do not overlap */
+	/* Ensure the old/new locations do not overlap. */
 	if (addr + old_len > new_addr && new_addr + new_len > addr)
 		return -EINVAL;
 
-	/*
-	 * move_vma() need us to stay 4 maps below the threshold, otherwise
-	 * it will bail out at the very beginning.
-	 * That is a problem if we have already unmaped the regions here
-	 * (new_addr, and old_addr), because userspace will not know the
-	 * state of the vma's after it gets -ENOMEM.
-	 * So, to avoid such scenario we can pre-compute if the whole
-	 * operation has high chances to success map-wise.
-	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
-	 * split in 3 before unmapping it.
-	 * That means 2 more maps (1 for each) to the ones we already hold.
-	 * Check whether current map count plus 2 still leads us to 4 maps below
-	 * the threshold, otherwise return -ENOMEM here to be more safe.
-	 */
-	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
-		return -ENOMEM;
-
 	if (flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
@@ -1035,6 +1016,218 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 	return 1;
 }
 
+/* Do the mremap() flags require that the new_addr parameter be specified? */
+static bool implies_new_addr(unsigned long flags)
+{
+	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
+}
+
+/*
+ * Are the parameters passed to mremap() valid? If so return 0, otherwise return
+ * error.
+ */
+static unsigned long check_mremap_params(unsigned long addr,
+					 unsigned long flags,
+					 unsigned long old_len,
+					 unsigned long new_len,
+					 unsigned long new_addr)
+{
+	/* Ensure no unexpected flag values. */
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
+		return -EINVAL;
+
+	/* Start address must be page-aligned. */
+	if (offset_in_page(addr))
+		return -EINVAL;
+
+	/*
+	 * We allow a zero old-len as a special case
+	 * for DOS-emu "duplicate shm area" thing. But
+	 * a zero new-len is nonsensical.
+	 */
+	if (!PAGE_ALIGN(new_len))
+		return -EINVAL;
+
+	/* Remainder of checks are for cases with specific new_addr. */
+	if (!implies_new_addr(flags))
+		return 0;
+
+	/* The new address must be page-aligned. */
+	if (offset_in_page(new_addr))
+		return -EINVAL;
+
+	/* A fixed address implies a move. */
+	if (!(flags & MREMAP_MAYMOVE))
+		return -EINVAL;
+
+	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
+	if (flags & MREMAP_DONTUNMAP && old_len != new_len)
+		return -EINVAL;
+
+	/*
+	 * move_vma() need us to stay 4 maps below the threshold, otherwise
+	 * it will bail out at the very beginning.
+	 * That is a problem if we have already unmaped the regions here
+	 * (new_addr, and old_addr), because userspace will not know the
+	 * state of the vma's after it gets -ENOMEM.
+	 * So, to avoid such scenario we can pre-compute if the whole
+	 * operation has high chances to success map-wise.
+	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
+	 * split in 3 before unmapping it.
+	 * That means 2 more maps (1 for each) to the ones we already hold.
+	 * Check whether current map count plus 2 still leads us to 4 maps below
+	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 */
+	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/*
+ * We know we can expand the VMA in-place by delta pages, so do so.
+ *
+ * If we discover the VMA is locked, update mm_struct statistics accordingly and
+ * indicate so to the caller.
+ */
+static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
+					unsigned long delta, bool *locked)
+{
+	struct mm_struct *mm = current->mm;
+	long pages = delta >> PAGE_SHIFT;
+	VMA_ITERATOR(vmi, mm, vma->vm_end);
+	long charged = 0;
+
+	if (vma->vm_flags & VM_ACCOUNT) {
+		if (security_vm_enough_memory_mm(mm, pages))
+			return -ENOMEM;
+
+		charged = pages;
+	}
+
+	/*
+	 * Function vma_merge_extend() is called on the
+	 * extension we are adding to the already existing vma,
+	 * vma_merge_extend() will merge this extension with the
+	 * already existing vma (expand operation itself) and
+	 * possibly also with the next vma if it becomes
+	 * adjacent to the expanded vma and otherwise
+	 * compatible.
+	 */
+	vma = vma_merge_extend(&vmi, vma, delta);
+	if (!vma) {
+		vm_unacct_memory(charged);
+		return -ENOMEM;
+	}
+
+	vm_stat_account(mm, vma->vm_flags, pages);
+	if (vma->vm_flags & VM_LOCKED) {
+		mm->locked_vm += pages;
+		*locked = true;
+	}
+
+	return 0;
+}
+
+static bool align_hugetlb(struct vm_area_struct *vma,
+			  unsigned long addr,
+			  unsigned long new_addr,
+			  unsigned long *old_len_ptr,
+			  unsigned long *new_len_ptr,
+			  unsigned long *delta_ptr)
+{
+	unsigned long old_len = *old_len_ptr;
+	unsigned long new_len = *new_len_ptr;
+	struct hstate *h __maybe_unused = hstate_vma(vma);
+
+	old_len = ALIGN(old_len, huge_page_size(h));
+	new_len = ALIGN(new_len, huge_page_size(h));
+
+	/* addrs must be huge page aligned */
+	if (addr & ~huge_page_mask(h))
+		return false;
+	if (new_addr & ~huge_page_mask(h))
+		return false;
+
+	/*
+	 * Don't allow remap expansion, because the underlying hugetlb
+	 * reservation is not yet capable to handle split reservation.
+	 */
+	if (new_len > old_len)
+		return false;
+
+	*old_len_ptr = old_len;
+	*new_len_ptr = new_len;
+	*delta_ptr = abs_diff(old_len, new_len);
+	return true;
+}
+
+/*
+ * We are mremap()'ing without specifying a fixed address to move to, but are
+ * requesting that the VMA's size be increased.
+ *
+ * Try to do so in-place, if this fails, then move the VMA to a new location to
+ * action the change.
+ */
+static unsigned long expand_vma(struct vm_area_struct *vma,
+				unsigned long addr, unsigned long old_len,
+				unsigned long new_len, unsigned long flags,
+				bool *locked_ptr, unsigned long *new_addr_ptr,
+				struct vm_userfaultfd_ctx *uf_ptr,
+				struct list_head *uf_unmap_ptr)
+{
+	unsigned long err;
+	unsigned long map_flags;
+	unsigned long new_addr; /* We ignore any user-supplied one. */
+	pgoff_t pgoff;
+
+	err = resize_is_valid(vma, addr, old_len, new_len, flags);
+	if (err)
+		return err;
+
+	/*
+	 * [addr, old_len) spans precisely to the end of the VMA, so try to
+	 * expand it in-place.
+	 */
+	if (old_len == vma->vm_end - addr &&
+	    vma_expandable(vma, new_len - old_len)) {
+		err = expand_vma_inplace(vma, new_len - old_len, locked_ptr);
+		if (IS_ERR_VALUE(err))
+			return err;
+
+		/*
+		 * We want to populate the newly expanded portion of the VMA to
+		 * satisfy the expectation that mlock()'ing a VMA maintains all
+		 * of its pages in memory.
+		 */
+		if (*locked_ptr)
+			*new_addr_ptr = addr;
+
+		/* OK we're done! */
+		return addr;
+	}
+
+	/*
+	 * We weren't able to just expand or shrink the area,
+	 * we need to create a new one and move it.
+	 */
+
+	/* We're not allowed to move the VMA, so error out. */
+	if (!(flags & MREMAP_MAYMOVE))
+		return -ENOMEM;
+
+	/* Find a new location to move the VMA to. */
+	map_flags = (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
+	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
+	new_addr = get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_flags);
+	if (IS_ERR_VALUE(new_addr))
+		return new_addr;
+	*new_addr_ptr = new_addr;
+
+	return move_vma(vma, addr, old_len, new_len, new_addr,
+			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
+}
+
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
@@ -1048,7 +1241,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long ret = -EINVAL;
+	unsigned long ret;
+	unsigned long delta;
 	bool locked = false;
 	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
 	LIST_HEAD(uf_unmap_early);
@@ -1067,70 +1261,38 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	 */
 	addr = untagged_addr(addr);
 
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
-		return ret;
-
-	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
-		return ret;
-
-	/*
-	 * MREMAP_DONTUNMAP is always a move and it does not allow resizing
-	 * in the process.
-	 */
-	if (flags & MREMAP_DONTUNMAP &&
-			(!(flags & MREMAP_MAYMOVE) || old_len != new_len))
-		return ret;
-
-
-	if (offset_in_page(addr))
+	ret = check_mremap_params(addr, flags, old_len, new_len, new_addr);
+	if (ret)
 		return ret;
 
 	old_len = PAGE_ALIGN(old_len);
 	new_len = PAGE_ALIGN(new_len);
+	delta = abs_diff(old_len, new_len);
 
-	/*
-	 * We allow a zero old-len as a special case
-	 * for DOS-emu "duplicate shm area" thing. But
-	 * a zero new-len is nonsensical.
-	 */
-	if (!new_len)
-		return ret;
-
-	if (mmap_write_lock_killable(current->mm))
+	if (mmap_write_lock_killable(mm))
 		return -EINTR;
+
 	vma = vma_lookup(mm, addr);
 	if (!vma) {
 		ret = -EFAULT;
 		goto out;
 	}
 
-	/* Don't allow remapping vmas when they have already been sealed */
+	/* If mseal()'d, mremap() is prohibited. */
 	if (!can_modify_vma(vma)) {
 		ret = -EPERM;
 		goto out;
 	}
 
-	if (is_vm_hugetlb_page(vma)) {
-		struct hstate *h __maybe_unused = hstate_vma(vma);
-
-		old_len = ALIGN(old_len, huge_page_size(h));
-		new_len = ALIGN(new_len, huge_page_size(h));
-
-		/* addrs must be huge page aligned */
-		if (addr & ~huge_page_mask(h))
-			goto out;
-		if (new_addr & ~huge_page_mask(h))
-			goto out;
-
-		/*
-		 * Don't allow remap expansion, because the underlying hugetlb
-		 * reservation is not yet capable to handle split reservation.
-		 */
-		if (new_len > old_len)
-			goto out;
+	/* Align to hugetlb page size, if required. */
+	if (is_vm_hugetlb_page(vma) &&
+	    !align_hugetlb(vma, addr, new_addr, &old_len, &new_len, &delta)) {
+		ret = -EINVAL;
+		goto out;
 	}
 
-	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
+	/* Are we RELOCATING the VMA to a SPECIFIC address? */
+	if (implies_new_addr(flags)) {
 		ret = mremap_to(addr, old_len, new_addr, new_len,
 				&locked, flags, &uf, &uf_unmap_early,
 				&uf_unmap);
@@ -1138,109 +1300,44 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	}
 
 	/*
-	 * Always allow a shrinking remap: that just unmaps
-	 * the unnecessary pages..
-	 * do_vmi_munmap does all the needed commit accounting, and
-	 * unlocks the mmap_lock if so directed.
+	 * From here on in we are only RESIZING the VMA, attempting to do so
+	 * in-place, moving the VMA if we cannot.
 	 */
-	if (old_len >= new_len) {
-		VMA_ITERATOR(vmi, mm, addr + new_len);
 
-		if (old_len == new_len) {
-			ret = addr;
-			goto out;
-		}
+	/* NO-OP CASE - resizing to the same size. */
+	if (new_len == old_len) {
+		ret = addr;
+		goto out;
+	}
+
+	/* SHRINK CASE. Can always be done in-place. */
+	if (new_len < old_len) {
+		VMA_ITERATOR(vmi, mm, addr + new_len);
 
-		ret = do_vmi_munmap(&vmi, mm, addr + new_len, old_len - new_len,
+		/*
+		 * Simply unmap the shrunken portion of the VMA. This does all
+		 * the needed commit accounting, unlocking the mmap lock.
+		 */
+		ret = do_vmi_munmap(&vmi, mm, addr + new_len, delta,
 				    &uf_unmap, true);
 		if (ret)
 			goto out;
 
+		/* We succeeded, mmap lock released for us. */
 		ret = addr;
 		goto out_unlocked;
 	}
 
-	/*
-	 * Ok, we need to grow..
-	 */
-	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
-	if (ret)
-		goto out;
-
-	/* old_len exactly to the end of the area..
-	 */
-	if (old_len == vma->vm_end - addr) {
-		unsigned long delta = new_len - old_len;
-
-		/* can we just expand the current mapping? */
-		if (vma_expandable(vma, delta)) {
-			long pages = delta >> PAGE_SHIFT;
-			VMA_ITERATOR(vmi, mm, vma->vm_end);
-			long charged = 0;
-
-			if (vma->vm_flags & VM_ACCOUNT) {
-				if (security_vm_enough_memory_mm(mm, pages)) {
-					ret = -ENOMEM;
-					goto out;
-				}
-				charged = pages;
-			}
-
-			/*
-			 * Function vma_merge_extend() is called on the
-			 * extension we are adding to the already existing vma,
-			 * vma_merge_extend() will merge this extension with the
-			 * already existing vma (expand operation itself) and
-			 * possibly also with the next vma if it becomes
-			 * adjacent to the expanded vma and otherwise
-			 * compatible.
-			 */
-			vma = vma_merge_extend(&vmi, vma, delta);
-			if (!vma) {
-				vm_unacct_memory(charged);
-				ret = -ENOMEM;
-				goto out;
-			}
+	/* EXPAND case. We try to do in-place, if we can't, then we move it. */
+	ret = expand_vma(vma, addr, old_len, new_len, flags, &locked, &new_addr,
+			 &uf, &uf_unmap);
 
-			vm_stat_account(mm, vma->vm_flags, pages);
-			if (vma->vm_flags & VM_LOCKED) {
-				mm->locked_vm += pages;
-				locked = true;
-				new_addr = addr;
-			}
-			ret = addr;
-			goto out;
-		}
-	}
-
-	/*
-	 * We weren't able to just expand or shrink the area,
-	 * we need to create a new one and move it..
-	 */
-	ret = -ENOMEM;
-	if (flags & MREMAP_MAYMOVE) {
-		unsigned long map_flags = 0;
-		if (vma->vm_flags & VM_MAYSHARE)
-			map_flags |= MAP_SHARED;
-
-		new_addr = get_unmapped_area(vma->vm_file, 0, new_len,
-					vma->vm_pgoff +
-					((addr - vma->vm_start) >> PAGE_SHIFT),
-					map_flags);
-		if (IS_ERR_VALUE(new_addr)) {
-			ret = new_addr;
-			goto out;
-		}
-
-		ret = move_vma(vma, addr, old_len, new_len, new_addr,
-			       &locked, flags, &uf, &uf_unmap);
-	}
 out:
 	if (offset_in_page(ret))
 		locked = false;
-	mmap_write_unlock(current->mm);
+	mmap_write_unlock(mm);
 	if (locked && new_len > old_len)
-		mm_populate(new_addr + old_len, new_len - old_len);
+		mm_populate(new_addr + old_len, delta);
 out_unlocked:
 	userfaultfd_unmap_complete(mm, &uf_unmap_early);
 	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
-- 
2.48.1


