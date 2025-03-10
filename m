Return-Path: <linux-kernel+bounces-555087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B6A5A54F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686CD173919
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3EA1DEFD4;
	Mon, 10 Mar 2025 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hUGvpAag";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IE/EXdye"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71551DE8A9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639899; cv=fail; b=fVPjEMMJmSyosDOWMxdRxq9qsB0jWo9pICX2kbLeOOGnlnOKwb8X2JK6fP+aNnMKZBxx5tjp/bRaP9EG5UjKRs0gZzXjCLA3ncF7D7HmLIfVIGVxy29sdBwDK1ozkRSywK6Tv4XdgU3zrmxHJAyaL0iaWScHqshO2HN+B5RvkJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639899; c=relaxed/simple;
	bh=t0Ugf60eBkxV4zzfT+kwEEOJC8BXpX+lAkDyztGXlzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F8hjjHDG+rlI96eqNrz9sHORS+aIpwzvm4X+qgMH7tjkWAdm45CFNLHaRvOvpFgZYxDsKqNisItxnGJONEov3LYMudbaEiMQPCjpIhmf6lrrPKgT9V4tzldmBAAWBVv0wVrgTQylKZq6QKx0INvHVkx1xP4RgGeTuCyVgYAaxgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hUGvpAag; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IE/EXdye; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJtl8V015577;
	Mon, 10 Mar 2025 20:51:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=USUmLJty6jCP4gZy
	VZDe6LID0/A6+yIWbo7ZqqeBKak=; b=hUGvpAagmiZwu4YT+XRUhuyBfhhXjAAR
	zeifdGvwQ6CSbooFhAxlyuUxeO9xJk+E7Ekt+Z0dSwHPOLRMOwlOSpIJDPpIi4cp
	6zwJKGcBr1Qi9sNyjpViOd6BerWbB2hb+oKvYWoCiF01cu8YDxE9fGyVxXnbCNeB
	Mzvf8+3qkmaRCL4BdzD08Q3VHNhLVtVJJCbZdFgicHIiKNKaRdMA1CV4/cW9J9Ne
	3JktArXI0+UrndVAeKwIAjCuID713iPJXZRvLfpEMTYvi3JZ+pIAWno0xLIhC6AE
	116MlMpbzJqAozcnvChoeC8gdn9l2BgNFsaris5+sVk6DFm5kraoHw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cg0ukdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKH6gC021738;
	Mon, 10 Mar 2025 20:51:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458wmnm58y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szpYbRxEGt/r7AbA2OWpfLf37iUdn5Kr6SaWmHVobBrJMWt/OIpf7W8N5tQedkiT5j6Fa9i2C0rzL0pA5rMj/+EmSxBwV2YTcWN0/DI9mjDlGBpDXT4hF9Z9Cefd649hY/L2zOVdnMJBmAcFDniB28wK5fsfG2TPWHKvd/iXKyMiT2vwVSFEx06vGatbCbY2k0QEZtPhqYgJn3ohNiJh2GuYegOqWB7usbSRWiokeqRD5C5dbMYVAkYg8mAVx6dI7eLcBn2PcRPXMv8/dmLVUA5Mc0zBMF0F0YJv5ad/VwhZOZzap0w48OZ7xWt1+46CQvjQPg/xpZy1jfaGjoGTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USUmLJty6jCP4gZyVZDe6LID0/A6+yIWbo7ZqqeBKak=;
 b=UQp9QfLGZtTUL6UY96GJkfrGYdPq2/nqC4Rw2Bp7ANFR/S463evPY4jgv2O8vNMElJL33i/c4opNx0ZWR3fBrRVRbtW8DWLdkTtL/kMViN0hIMVUs1PJMp36vLj7L89nplcv7GEtuGn21wJEe7WA2uYMe7WPO9z45vE069/kCDUDiyxKLMUk6HxYjzwxVARKgsXPKTWMKoiW08nzykvNXeOaUcBO/N7zlUHByuZI1QLH4nCAkCx/G5FIuV0UqBpXhMUXM8pi7L+q6HVdghh1ihWRE1Zdu936NTb77ecdjeVPMnjwjKZSS7U6cBNvmMCRZKNSPMH1STKr1BeNDEKbhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USUmLJty6jCP4gZyVZDe6LID0/A6+yIWbo7ZqqeBKak=;
 b=IE/EXdyexoFCIclVQCIghypxRuZOVppct+EXN+ZDLMldAYmhrS0hPZumn8+WhmRVtPcw7MTfI42WrRdCNI4vkJ5P+QCmdbNZcEcnK8mmSSHlwRLsQJmdS6MwBhXmZkIzrVWUQLwMTT0uFkxoqs5vv6gYgQ9XPUTEWRarOACcu9E=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:51:19 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 20:51:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 0/7] refactor mremap and fix bug
Date: Mon, 10 Mar 2025 20:50:33 +0000
Message-ID: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0007.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::14) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 38cf8300-c263-4e2e-c926-08dd60154f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MM4EWekaXLZBangvgR2fTcjLcNXBTfZPKLe7/MOViFK5MUlYFQOopRL3mxSZ?=
 =?us-ascii?Q?wGe9H0mBPlSlYyd0BuH7phm+nJkv+KkhrOeny39YJKJP2iD+qrI32dccuvtS?=
 =?us-ascii?Q?pts86rooQKZpxGz1JwSMwkMJOrC/WaPTdx3/C+M3m3IgNeWoGce60wt0/NMU?=
 =?us-ascii?Q?FugvPyd8Z+W93wxvykjtmgGDbCTrepLRO7rXrTBhYZNnqQTQWsieMxjFJL3K?=
 =?us-ascii?Q?0wdWST5Sb76npRg6OscTtTfAxkPv/lVs39PLx1XiwNbLkG9Hx/6MfDM6tee8?=
 =?us-ascii?Q?bqe7BPk8g0aeAP4wVAyI6SG+8nuQNyr4z7/zuAwpcim4xNBRwF8Ac9nssB4u?=
 =?us-ascii?Q?pxlLY+P+x0mlCMfrWenJzmwrG1HRbQGRIen1nG4atP7y4xmkkUMfNikb5Z8s?=
 =?us-ascii?Q?W3mxyPtvHOSRCpTzeILTIsboQ9FpXqn1IckDgUJ/iQ7o3uzzq87Oi5EGRYcg?=
 =?us-ascii?Q?Rv0qEaAL2EWsUVq0OPYh7vqc2waEupxVbs//58/t7gx8xLi6Av/P1f4MRYij?=
 =?us-ascii?Q?jNCkogFT34kDzWKRhoIfPqD8RYcjgBWMc4RgbmAB+vLb+T5IJ2R8WoTz+5ZD?=
 =?us-ascii?Q?R9OIHgGeKnNZXdnI/FmCa+yqdyarH/h8qCmiJduG+12QNJSHVfncgiPvrl/+?=
 =?us-ascii?Q?vOIN8o9ehFiWiexd/OBvbL99Vt2W5zrSyBZ5r08VBCmkijrCOulVYXxGH+Uj?=
 =?us-ascii?Q?V9GKV1n0qS0fTUGizGK6jCRwTwC9s42nuwL/QXjf7uoA2H1sh+Bf0qkI62K/?=
 =?us-ascii?Q?HkL9RQUakdvCqCNzaYxDL262eXyEsTfKNpUSRLHrj5acZ/Nw7q7XPFzEwuix?=
 =?us-ascii?Q?NAWEX9I1z4kgLuBJufdFwSCX5Y2kCAZUhnaWOo0IQDPCr0JEp7EcZ/v7t4SV?=
 =?us-ascii?Q?oZDcllGXbgm33vTvJQDuH01B5ejyEPIEvXENNomrDN4XxfbsEZwRxuvtH0gF?=
 =?us-ascii?Q?ZWCR9qx6j4cyKoqV6EErf2qqlGAfoliH824hyRU4U8b9WqHiIzJh76Iomi8B?=
 =?us-ascii?Q?Ms6Hm9FA2MA2ZGGNXXytQAmWDBRjb/B0OpS5hEypJO7D30v7D9UkXJEP3hxo?=
 =?us-ascii?Q?kwnov0aNCzLy32eyN9kGeQrXiuOQfqr7i3V6mO3h70uM0GLHpaizqwTiOZ8S?=
 =?us-ascii?Q?lblOIfWMDTX9vcYSQMSQhf+zdoETxaOnkKEE0tDcdU3MCp3F/QWsGpDzMUR4?=
 =?us-ascii?Q?2vDpkh+UAIJz1DWZTd7DLQbzUjpO9Fpkdj58iX0ZvOkrS/+DCdsRWMFAFFy0?=
 =?us-ascii?Q?HoQptZy/0DMcjpeXhtGCJchSUjr5BccXcdFoAaNp/ieYm4q2eLuHQUiI12eT?=
 =?us-ascii?Q?PDqI9wyTzt69JnxVw6mnho56oz8UYnxYNYc/rK+8M87D1sKHT+madhdQsvAz?=
 =?us-ascii?Q?oucAYrntzaX0eaUJlGpTMnS9q8K2Mju0p5G1WIEMCC7fj1sIGA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F1I8YzjPgY9XLMY108ie8MmXhH7yduLU5Km4BEXwaekFWv2fg16nG9Oa//0o?=
 =?us-ascii?Q?QIQbXf3d9rqDbaZyJgK9jqcdNTO7wwSJZwUvBMFvSbZsq1Sev3HJ+87z3iOg?=
 =?us-ascii?Q?l/29C02+yqrZ8sER58Doo/+cgwxcdUXTtrm+1D2dypd1bkZ6fAbdnU1mZR39?=
 =?us-ascii?Q?+JVhRL+h1C9XVBCi5EGkQNNoMPumQsDHvEE3lw5Fb21zDPXSuoH0GAi+VGlK?=
 =?us-ascii?Q?U0KFwS1fCYGmhv2FTLUZWvYALCoIE+G+owq7Uim22j453rCbWAGfrKX6njwx?=
 =?us-ascii?Q?uQJizfBonaOVZv6iAUTzdmN0V9rE08h/2j4Jfbb2Lxbf6sf5ebELdUA3cuN4?=
 =?us-ascii?Q?IIS0XImzJs9sd8PFGtSSbx2wSma89kAWj3ITBoOdVcNixI4ZH75iD92/5CUq?=
 =?us-ascii?Q?Awmj+65WaDjW3tTX11sfAsU44jYKeUoKur/lr33JhOCtajkaCS6YVE411Wua?=
 =?us-ascii?Q?S8nwuHHjS6pIttJvoB9ArdSC0dvvQifHQQ5TzQjA9bqiV1nUvSKqHlXleY9c?=
 =?us-ascii?Q?SrKX8/MYw09VRoSinn1zg5YEH5E2rLdCXxrqQJDWVRUpkMMfNa7s6zxrjAwq?=
 =?us-ascii?Q?a+82zo8jzhqhyO30kQt99OvAtYfwJHRTYlK4fgoCR/JYSwsfvOqvRr/KHBRb?=
 =?us-ascii?Q?fJ2/ZXekmwScgKjIzJo4J/jL/CF5PRGk+UAnPZko4Fks+00fJ7NvL9UituTd?=
 =?us-ascii?Q?+Kxss/nh8TVZaT0qpNWs1RJ/neo6vLJMnKlGjjwV0tv8FYYaOvNe52fwRGxb?=
 =?us-ascii?Q?/9xFYyQviKSvaF9UsZHGEqBr0pIem3GxQptFvNwYvEY+dU3edOVJRGhYf+sK?=
 =?us-ascii?Q?sHKqmTA1Hiab8llDAclS1KuDWwh+A2Z61x8yRMy0KA1aNBZcZnb0jNizJC1x?=
 =?us-ascii?Q?cQgojMfXWd9R05vOnxYeQNWUXZ01pHhWfVuwjt+ujWMB84f3M1b4b5H/mtRv?=
 =?us-ascii?Q?IL3cgr2nQMB7E528Cw/4JUpShSt4YXEYrMGmt7uk2GV4rTQl4r+Fv+nnOQYY?=
 =?us-ascii?Q?dtd51puChNoNowteotOz5OrXjBKgSgFQrw9S8ME7YBlMfB/llGWY2aNV7p0B?=
 =?us-ascii?Q?p/0G3bWQd2AxedZ6nyyPZk9eTAyrNJyyr6OIW851ZIJ3VBmHLWKTnhc1nmkF?=
 =?us-ascii?Q?T5Jb/whhnfumV5ISFXgzZoXAVXCfHjSFethM6PpXW0X/MIUZdc299nNOZ7oT?=
 =?us-ascii?Q?+ezYtX7BIAdpOaGU3HRYOhDOwpBbSUX6e+0OCBIbURY1gliRd5HuBJFshg6d?=
 =?us-ascii?Q?IM+sZ+ejbty69tAdhSUk6NUXIno1RVprcHLTl1JK1IYCNiie2sBs7H0ED16/?=
 =?us-ascii?Q?KEsqyW2DGISrR8uLVAKs6nWMXOG6umTKskWFNpazgOJkkdVq3MbVeFS0fPUL?=
 =?us-ascii?Q?DFhIMbw4lf94ZwhfcSTgN8DzFq6et9rhXF/ta/B4bwRwV4rHUgOcU6bh17uA?=
 =?us-ascii?Q?rlB/7CJ4/irdpsHO/mrfvFnJQW9XUrVC1n0pP8Yqg1FengfhYMl6HLn77wua?=
 =?us-ascii?Q?ctLAOlK7tMDW2Ab13xC2tBDu0pt9nNlGFDzwe/KvEDc2zUftNB1qlrrcDKFh?=
 =?us-ascii?Q?JubNkkMhag0WtP4Y7tBkvxs9XOSUNB3zFSMj6it09/qWVNGrEdORr/qZtbFq?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aQLBTHQKKPxrP+7Mg5Q3tKl3cYzoqTNCEpR3E++Kvh7Hz72N/ngFRo+Pruusk5SM4CmXWA5ZNTdnnp0ske7OK3w/eq9WQdwkt/Se7XpNjVZuWfzJOrN9nhTCJ7LG6nKwBmcoQrQPMfxjHenz0FX4wcKMEfTYMeuWBrfBnGf9HogoJBqnLeQtgFHoeqaMvdxXGBvrEmVJLkYaqkwLXQuDLBh4LiklXXy5qDIHSUMns8d0jN70/iV2Eg/SpBgnn5E16YH3uYeu40CQaceMO2uqMPUDU6SbVfTyBTKxCpaxnSoeiaqJIFAR7i/sWJixsrfcAr2akrAn2ulj6rp92piEpCi45JGkkqhvOA9E6mCfMpccZ7z+6TptzP9sqTCAewrp4GIcvAOmUdzJZqprHGcs4Xb1mOL6cTkHBa0M54c6OBossJqFI3lRuBCLAD0Vafh8q27/CAScBL9xnMmZlXkQSMee773bGHenXQwSXkdjux0uL45f54ULO8s3iSQVytwMbgUJ2o/Sk8AeKsZirJboSUeWUSFt8+eEmQFWJHEbkD0UBhrWRA4U4TFfCAI7iN0zSpJxyOumcYfRijrDyWx/O7ewcHYmXdScDTIXL3Cszk8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38cf8300-c263-4e2e-c926-08dd60154f2f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:51:19.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTfAS7ibZeEUrZeWiX3bzLINzLrGVCQcXNXX7L8qQ8W+SzMyiutm90onbABpba1qG2Wzc5YscZL6jqaV4JPHgipQlGnqAYblX3jxMkkD5s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100159
X-Proofpoint-GUID: WgLNy5pXbP3u9eoTkcctskSKb-7L9mRH
X-Proofpoint-ORIG-GUID: WgLNy5pXbP3u9eoTkcctskSKb-7L9mRH

The existing mremap() logic has grown organically over a very long period
of time, resulting in code that is in many parts, very difficult to follow
and full of subtleties and sources of confusion.

In addition, it is difficult to thread state through the operation
correctly, as function arguments have expanded, some parameters are
expected to be temporarily altered during the operation, others are
intended to remain static and some can be overridden.

This series completely refactors the mremap implementation, sensibly
separating functions, adding comments to explain the more subtle aspects of
the implementation and making use of small structs to thread state through
everything.

The reason for doing so is to lay the groundwork for planned future changes
to the mremap logic, changes which require the ability to easily pass
around state.

Additionally, it would be unhelpful to add yet more logic to code that is
already difficult to follow without first refactoring it like this.

The first patch in this series additionally fixes a bug when a VMA with
start address zero is partially remapped.

Tested on real hardware under heavy workload and all self tests are
passing.

v3:
* Propagate tags (thanks Vlastimil et al.!)
* Fix issue reported by test bot/trinity where, for length 0 input mappings
  of a VMA mapped entirely onto itself, vma_lookup() may consequently fail.
* Fixed incomplete sentence in comment as per Vlastimil.
* Reworded comment in internal.h around pagetable_move_control as per
  Vlastimil.
* Reworded reference to page table boundary for clarity as per Vlastimil.
* Dropped misleading reference to old_end in 6/7 as per Vlastimil.
* Improved should_take_rmap_locks() as per Vlastimil.

v2:
* Folded Andrew's fix for move_huge_pud() stub that I missed in v1.
* Folded Andrew's fix for err initialisation in prep_move_vma() that I
  missed in v1.
* Propagated tags (thanks everyone!)
* Aligned comments vertically as per Liam, tidied them up a bit.
* Renamed mremap_operation to mremap_type for consistency.
* Added MREMAP_INVALID as default mremap operation state, and set on
  initialisation as per Liam.
* Renamed 'locked' to 'mlocked' whenever referring to mlock state as per
  Liam.
* Dropped unnecessary vrm_set_remap_type() function as per Liam.
* Corrected redundant comment about iterator invalidation as per Liam.
* Corrected confusing vertical alignment on may_expand_vm() invocation
  as per Liam.
https://lore.kernel.org/all/cover.1741256580.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1740911247.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (7):
  mm/mremap: correctly handle partial mremap() of VMA starting at 0
  mm/mremap: refactor mremap() system call implementation
  mm/mremap: introduce and use vma_remap_struct threaded state
  mm/mremap: initial refactor of move_vma()
  mm/mremap: complete refactor of move_vma()
  mm/mremap: refactor move_page_tables(), abstracting state
  mm/mremap: thread state through move page table operation

 mm/internal.h |   46 +-
 mm/mmap.c     |    5 +-
 mm/mremap.c   | 1448 +++++++++++++++++++++++++++++++++----------------
 3 files changed, 1037 insertions(+), 462 deletions(-)

--
2.48.1

