Return-Path: <linux-kernel+bounces-571050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE4AA6B883
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919A8189FF5F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60871F3D20;
	Fri, 21 Mar 2025 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Khl135on";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cK20mB9r"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB241F3B8F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551801; cv=fail; b=IHo+DPwjf/N3hGEPn8KIq/E5yQQIhis6A/YNzbGIJ3S9MKQ84L/9vksQVxmtaNCBF7Nn2qBxEloKcO71tWrE6l42uwuBJoZlZXtjG1BE3QZYD6BAD5ewkfjIneaTNHVYr3G16vYQj48sz94WP2SiP1rSft2/W/EREiV6MEAY9YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551801; c=relaxed/simple;
	bh=W5ENIEihgyW7ojyl0geXSsf+V63LjksteI+BUeeSTas=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jVYejpuXEr9W/2nnWURVgAPFqI7CyLQzDMTXQhUq31Khk6SYm2YVgD+aiF/noCxcvqQFusqx0tNEovWKDUkbXWWbxj5biastGO/Li58rXT1a3pTQxgsNCGgFjTdOFA6msZkH21hd7FCNx5LnLNK8s4B7k6PrPu0Zp68kqVoFJE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Khl135on; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cK20mB9r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L4ua14017745;
	Fri, 21 Mar 2025 10:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=w7khFOuSa8N458ML
	EYgEIQAKZfXHzfYaDDjSCt0eZaI=; b=Khl135onSJA6WHJ2S7jcGeJ5HkGoves6
	KuaGcZ18zQxB+FwA1VVzL+5hv58DkuhUjqEztJtDvYpY0XaDInMivMldPwgUl5dn
	3wkjrr6EiFZcZGXLIGLb3ypm7EDkwxmT2lDyBBrJZTvH9M1RgN07uzYwCxNeVhoX
	v52ID4gg80iyAMDoo1aF3owFWQHCPQ/IUdq8f9Y2L/nO52Q7T0b+Os8wBJ9e9ij+
	VsLxe0I6cfmb0EIH2jO0iTXZiXviIpH806Eg9t0u34t8qaTTBEb+7OWrPWtrsDGF
	A3ok/Va9NefwUEIp406e+AP/wAnb0CQY9Bim85Hfw5Ozz2zB/qW21Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s90cn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 10:09:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52L90cfq004589;
	Fri, 21 Mar 2025 10:09:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ftmy8hg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Mar 2025 10:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy+Q5Y7w7tBWiIofZ08Wnlu1Hi/bicj+4bWJ4HwSm43SdGD44ancBg7n7ZTVu0+Afz0FO3ob3E7VJh9Pyr18q8H9SyUI5wKv2p3JospVtP2eTKh3BY9ZKKzoTkq1nK4dDtJVQJJ9xhYILEWeYvaDHRhsLfOaMJ0D2GxBzBvTaq88eEeYftz7ZBw7Moc+flV5Llki4BN0N/3/QQdlG/KvK0SjfSYM81Yh0VyQeUwq6C6ogxLzzYp86ZikwsO+4ZSFd9OFoCJOC5Zs1m8dkXxg/1DdZArzoHd6bmMew+OFVD/LQUvqGtpNyMRtts1xT5G9yknmpkjKCU+0Lpz0gQtbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7khFOuSa8N458MLEYgEIQAKZfXHzfYaDDjSCt0eZaI=;
 b=a5Un0DNRjVB470hwd66ABYUBljVe4+n+6NJ2z0BN9cpOMjo/QHO8nr4oJ84gkLYDlUhfWHu4/NcTzF1DoeZdDu3ULYYuCZYiMLYf+EiLfTkM39kfw7zD4q/RthSiHk5rk+I9Y3/B6tGHAsH7EKEm0IqVEOvz4PJWjz7LxmOTMvU9Il193f60UdOtN/BKrEwRmpHYT9Lbk+Nf6j9HcuLYgho8OtaOiAR9RUltu0gvfcb592PfxPLHPGN4IhBl23h34cs9TaDzOqFjRJ5/mfpYw4THuama7pl/tpTYxMZ+6rMPM6iTtEveivrdpbewEZqUBOLH/3msvuN74iF0JJyOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7khFOuSa8N458MLEYgEIQAKZfXHzfYaDDjSCt0eZaI=;
 b=cK20mB9rlq/1VWvQCgGfQJYNubsRFwzf+wphYc2M0wO0zRWQokLvUaptlTY7/AQWrsP8cCYJzp7yUPxsChhzz4WCQEGPxB9EtFuBqBT2G01VzHlOHQvkm84idk8bOVsdyEhyZRA6OPeem336JbcgC2SODhISvp7nfZ0WiyCKJkA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW5PR10MB5850.namprd10.prod.outlook.com (2603:10b6:303:190::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 10:09:42 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 10:09:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6.15] mm/vma: add give_up_on_oom option on modify/merge, use in uffd release
Date: Fri, 21 Mar 2025 10:09:37 +0000
Message-ID: <20250321100937.46634-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0157.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW5PR10MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a85d14-a196-4700-04cd-08dd68607f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AhvjikNwjEpWfrzRRmeXHITa3wOSq748uEtCXmMi8NwS6tiGyXDHOYf+3EZ?=
 =?us-ascii?Q?IzcOlepzDyegLKcyErO3uShNcFNmMnTuk3mocluVO0mtdn/kRChH7OiepUCE?=
 =?us-ascii?Q?Ozw5mz6pU1+ye/xulBYHU0eC+wJ9nqlBITSfI4E9vKny9t8T2WxN8OBR9khm?=
 =?us-ascii?Q?6jJ+3t8o0U3lhMbi5tGiVyMUBlkfsDJx2UXKKMfq8sdX4Z6NRQADSziDhUr3?=
 =?us-ascii?Q?wX/5qEXkLo305I7+SxYqUs5tiM2EVZtZZQdMgNbt8UOfeUQaCBS09DZxETX4?=
 =?us-ascii?Q?mgC8QrEFaUEi8pMg15HaX136u6ES7vYLctFqHveJXmp7fmuH+vfJcqNHFB+x?=
 =?us-ascii?Q?5TqrrBi14Q3V0IA01FLPQ4Ec8XqNfyYw1wFiN7ktmHui5huEiLA/WhtlTkZ+?=
 =?us-ascii?Q?ln68XoVDOf89lyyBZbj3wagYMbt4cBiETPhdkxeM0IVr7UnLWRUGbCthrpYv?=
 =?us-ascii?Q?ogxVUofdIvfJUhmKlysu1koNDwgzfr+NzLGqXses9OPNo2kLUacaiAC7O8h/?=
 =?us-ascii?Q?Yfc/y1sCKqBhd/RSgSXrWl5oJIbrrexOLNcKcDUMgEgp/WTvpjeIOl1buQQk?=
 =?us-ascii?Q?QLvO9+EcRwbaLFd/3XtJoqCZp8izUeL0E7sm5AgzGN/44ikF5tm49RJ3ZPxs?=
 =?us-ascii?Q?pg019BNA6CZBatbxL3NnWHD5KkBR9/JdPuS3UwaC6fpK+XWcwjwmdPCX0iMD?=
 =?us-ascii?Q?x/FCVILho6V3YErW7QWU+yplu8Rb38//y60rSTBWXFcdxTOa6CViOANsJSPb?=
 =?us-ascii?Q?lI9uQbXfwxOnHi219L8tJEvEq+P1kr4C0iiTnXuAsQkpSKJ/wMAs0+sx4lDu?=
 =?us-ascii?Q?wzpFjAjWCB/brgbllXuQ7mvv8E57J5aq6BKWXRU3CrLhalzenycdHuwAg92s?=
 =?us-ascii?Q?TSdihMDLTvrXCBmqs7YtcBFmmkBH3AByJmCPl4ZZOw3qqY4Mb8Cf26PIYBzv?=
 =?us-ascii?Q?r2CgKB73jwPzZOauBDc5dtLqtUp8Ci/obg2+Bt0CBqwpg9nhOtspMRghvGtP?=
 =?us-ascii?Q?Wv8meO4H3PC8QJDw+ChHDq4wsQgcIIYgpESwT1r1e0PWoBLROKAZevVmw/dP?=
 =?us-ascii?Q?PO2sAppOLHMcMsIMhW9nwBEFxPpyPYzPLscOEQD1YzIKdg7uBoEQ4uMdHlQG?=
 =?us-ascii?Q?ZX5lf2twcXa1VSi1+QL76NDntIv9QJlAlVjJYSKAeZylhhl9wMgOBvaGquk4?=
 =?us-ascii?Q?B56jHBSC8WFYfUw0QWvauA9uh13rvuSyv1NLVYRNMBxwbjJFFlnqjkLgnmxo?=
 =?us-ascii?Q?RUEuzjn9NoWaTOk084adq7JIcujyWfwONKhcdAe4aQvmPbrf+FJ5L0iE/EZa?=
 =?us-ascii?Q?1yY3Akk3pqmFftOK5j8VYo3x9yv589vvTrObDGR1Ymt8e384PGFXngFnor1K?=
 =?us-ascii?Q?jS74Ippad6Tfm9O5QdSlzfSp7xay?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oNDWbxtvs8I0lwC8cSXsxte9eI+z7RiWAGr0/O0YE1VKNg/D6nlNC8PdHovA?=
 =?us-ascii?Q?jytU1tPlAzfJZSacKyg0GFvtAJCAqZQyhGRSL0Hd+JvwAS/g8p/qv/MYB00H?=
 =?us-ascii?Q?K9/iqOhWnr5bDSp0DMvQx0FQIRvVcQq/IOEIq6tk6MGYkwgWL1SjcvXz4DYZ?=
 =?us-ascii?Q?u3+PBBRjUZv0k5blOXDYZJWEsNqiTYZ2JS0HbSs4MrjOjjPwyKcWSbXyAT3y?=
 =?us-ascii?Q?P5PWmwW4kW9y5vQ6157R/pG8gAuqXg3c909+NNPDlHtRDMV0Hz70wg2upm2D?=
 =?us-ascii?Q?XBlm3tZ/5lfMCm3vU0OJTovTELvHS2JJPV1ZNwZ3LnDwVKeCjv3g+2wzHC5j?=
 =?us-ascii?Q?tbXax3Y883Y30xzYlqMKG/PpblEaoqVgTUOKgPyAOYqUORlD5HGWVvggIjta?=
 =?us-ascii?Q?rGGAhaC8cGykKXXH/yrrgLSw05Wizp1rBoVHtq9RhZqTuTBCOxIma9MMopMD?=
 =?us-ascii?Q?Yn7P+2s7gNV1G7TUjuVX7exQO2ManTSPopt0rXBx5+UA4E/6+BiHRwDYlMRQ?=
 =?us-ascii?Q?3Lg34xvPZ9R89JyKWTxmHDYhWQpUizLgKwDsEPEUZGYCxlfSWKhrdcfQHB8i?=
 =?us-ascii?Q?e6UNwahG4GGQma1mGWc37fcGj0uPsPyAtrM0ces4SXhXF5nCIy9et7O+vy7X?=
 =?us-ascii?Q?IGhqmrG99Z8jC/BW7+avCvzbIEWn7KKM3mifYWzoL+6I9Bx5y7/6eKQoauWU?=
 =?us-ascii?Q?/0e4LGwQRSgPB7MQRGnQb9iY43cUTZl7J9i8XqnowBqhlSERfFsWpR4gxktC?=
 =?us-ascii?Q?lcmCHMJa1kpJA1B4GQ3XbsH5ztlr5Yx5ub3HDsrgpBrpwASIJAzpTl8ZydYc?=
 =?us-ascii?Q?XA0t6XTxvlq67PbUD6QuDv5QrWxdaH6TocuPwSFrZlIuJFzWGc+KcEojY1Yw?=
 =?us-ascii?Q?UfC/dtBnfksDqSTCth8wp2KU8Ef/HMg1dZXn9y1AZlW6xZuNKw8ZqjviLMqF?=
 =?us-ascii?Q?bVSmyfsteo8J3ZUGx31ma9cTL2MF0Nqvy2hF4QC0tGGae9sgppDRQxpCoLAD?=
 =?us-ascii?Q?Y9VZWOGM6+5T2hsCll9IxxCzBW3UocSf2EF82aKT7iwHI9UgzRrLOB2sBX9X?=
 =?us-ascii?Q?0xJemDNPDfENYpIkjJ8n1lthGXVu5lQ+qr0X//1dekOFboNbrdjhgJbnF5py?=
 =?us-ascii?Q?7y29ETGH5qtl0q1xdCtrx7y/tibf7HEx7LCLzQtJ5YgBeTB95Z56cALwAQJf?=
 =?us-ascii?Q?e1DW2bKz8K/uXpS6Opr0CVDu4C/HhtQzc/CVpyWjUNyasHa3AjYPRSaHkhEQ?=
 =?us-ascii?Q?dYPZDnTMUrP6tEfr3K+lq1QhgEPX0tBRFqgryOazTyorQx5FBWqPvQZQuT1L?=
 =?us-ascii?Q?MLsJDcLen3MFzRItjia41EDiO+DDelGSogcq5F94G1TJXTohi49zQ6p5x90C?=
 =?us-ascii?Q?2Yoi2MaLMS8kauz26GbnpeXYOSTmLEnT+J/8rB19JtMXSska+yseS3T0/vu5?=
 =?us-ascii?Q?DzGUw2m08YzA/EAaOCCUivA9bdaEo8L5lHyTRckanjSDWJgpbOfF92nKRpYO?=
 =?us-ascii?Q?fVQWA0EssWPW7o9CyMenjXqf2jOq2YTjHBuOhVEQD7IIWgZ4pH+lAgl6+Odv?=
 =?us-ascii?Q?bcQcyc82FMoovp6aufBjBS1sO2GLdkkX2mNihI16EG7SDnrQ9XW26eCP2BDk?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yFt4rUbGLUY3l2097jhHlUYSGrXThsajIwhejd+fgsxAPSRL8RJ0zobuzclvqYK5Nq4+lTFJQfv0VjWqtJGPExcMuEIPZ3UHXthfygcWSUVCPKr9nJllo1B9+mcSDM5PCyO3akX/Ck0m9TkqVWPqfSn+zuUiuPkt7I459fynfI3HsBGTAekgWfPUFpVwEF8hpo6LbIzXgaIadTF1kgZEImOlclt0Cl/N7Abr1IkCr1ZE5+5o6jku8z+vyg545odaYo9ynZNefwhz8bXq3jGYt88mRjjGSyeKLF2b1vP7PQ3YoN+Z6vWBBsDrF3+KbdRrSTz3MejxavaGdExmajKe4yBcoqblnEKElisWlUrf5klYjuKOUz58l6gs8JC+a3YPIeE5/BBogaM3s3w0XIXfpAhoyTUE6vcg8N4JkvSvKJe7ClmHnpCyXEU25JdQYuMd2f8/rA97JTBmGCPZM7sKJmMgGZYZPyvCyR6S1o32qerG8v35FgsiEbsYx7/5Zz6Va6s3pup+ixI66LlM/U8fudqnRtOdDFaDTq5c31YujAvoSm1DcMbY3Pjq9SX6XpduVaJwEKQo8z332Ra+OOImrpHZyBVW/ZBp0ai7TULKY6w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a85d14-a196-4700-04cd-08dd68607f42
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:09:41.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glN+/i/X1cuuRUVm5Ko5oKHZyFe6vZ1kOdafwdUmn4m+I2/l991gARJwAh7y8GCLqMSKkeTyZpDwmw8oHnTT+HiT6nvV951BSIjDEckQ5po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_04,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503210075
X-Proofpoint-ORIG-GUID: WGPCNJUISooEdO4sFJ9QDQ4aoNEDu9to
X-Proofpoint-GUID: WGPCNJUISooEdO4sFJ9QDQ4aoNEDu9to

Currently, if a VMA merge fails due to an OOM condition arising on commit
merge or a failure to duplicate anon_vma's, we report this so the caller
can handle it.

However there are cases where the caller is only ostensibly trying a
merge, and doesn't mind if it fails due to this condition.

Since we do not want to introduce an implicit assumption that we only
actually modify VMAs after OOM conditions might arise, add a 'give up on
oom' option and make an explicit contract that, should this flag be set, we
absolutely will not modify any VMAs should OOM arise and just bail out.

Since it'd be very unusual for a user to try to vma_modify() with this flag
set but be specifying a range within a VMA which ends up being split (which
can fail due to rlimit issues, not only OOM), we add a debug warning for
this condition.

The motivating reason for this is uffd release - syzkaller (and Pedro
Falcato's VERY astute analysis) found a way in which an injected fault on
allocation, triggering an OOM condition on commit merge, would result in
uffd code becoming confused and treating an error value as if it were a VMA
pointer.

To avoid this, we make use of this new VMG flag to ensure that this never
occurs, utilising the fact that, should we be clearing entire VMAs, we do
not wish an OOM event to be reported to us.

Many thanks to Pedro Falcato for his excellent analysis and Jann Horn for
his insightful and intelligent analysis of the situation, both of whom were
instrumental in this fix.

Reported-by: syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67dc67f0.050a0220.25ae54.001e.GAE@google.com/
Fixes: 47b16d0462a4 ("mm: abort vma_modify() on merge out of memory failure")
Suggested-by: Pedro Falcato <pfalcato@suse.de>
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/userfaultfd.c | 13 ++++++++++--
 mm/vma.c         | 51 ++++++++++++++++++++++++++++++++++++++++++++----
 mm/vma.h         |  9 ++++++++-
 3 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index fbf2cf62ab9f..7d5d709cc838 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1902,6 +1902,14 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 					     unsigned long end)
 {
 	struct vm_area_struct *ret;
+	bool give_up_on_oom = false;
+
+	/*
+	 * If we are modifying only and not splitting, just give up on the merge
+	 * if OOM prevents us from merging successfully.
+	 */
+	if (start == vma->vm_start && end == vma->vm_end)
+		give_up_on_oom = true;

 	/* Reset ptes for the whole vma range if wr-protected */
 	if (userfaultfd_wp(vma))
@@ -1909,7 +1917,7 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,

 	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
 				    vma->vm_flags & ~__VM_UFFD_FLAGS,
-				    NULL_VM_UFFD_CTX);
+				    NULL_VM_UFFD_CTX, give_up_on_oom);

 	/*
 	 * In the vma_merge() successful mprotect-like case 8:
@@ -1960,7 +1968,8 @@ int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
 		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
 					    new_flags,
-					    (struct vm_userfaultfd_ctx){ctx});
+					    (struct vm_userfaultfd_ctx){ctx},
+					    /* give_up_on_oom = */false);
 		if (IS_ERR(vma))
 			return PTR_ERR(vma);

diff --git a/mm/vma.c b/mm/vma.c
index 5cdc5612bfc1..839d12f02c88 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -666,6 +666,9 @@ static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
 /*
  * Actually perform the VMA merge operation.
  *
+ * IMPORTANT: We guarantee that, should vmg->give_up_on_oom is set, to not
+ * modify any VMAs or cause inconsistent state should an OOM condition arise.
+ *
  * Returns 0 on success, or an error value on failure.
  */
 static int commit_merge(struct vma_merge_struct *vmg)
@@ -685,6 +688,12 @@ static int commit_merge(struct vma_merge_struct *vmg)

 	init_multi_vma_prep(&vp, vma, vmg);

+	/*
+	 * If vmg->give_up_on_oom is set, we're safe, because we don't actually
+	 * manipulate any VMAs until we succeed at preallocation.
+	 *
+	 * Past this point, we will not return an error.
+	 */
 	if (vma_iter_prealloc(vmg->vmi, vma))
 		return -ENOMEM;

@@ -915,7 +924,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 		if (anon_dup)
 			unlink_anon_vmas(anon_dup);

-		vmg->state = VMA_MERGE_ERROR_NOMEM;
+		/*
+		 * We've cleaned up any cloned anon_vma's, no VMAs have been
+		 * modified, no harm no foul if the user requests that we not
+		 * report this and just give up, leaving the VMAs unmerged.
+		 */
+		if (!vmg->give_up_on_oom)
+			vmg->state = VMA_MERGE_ERROR_NOMEM;
 		return NULL;
 	}

@@ -926,7 +941,15 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 abort:
 	vma_iter_set(vmg->vmi, start);
 	vma_iter_load(vmg->vmi);
-	vmg->state = VMA_MERGE_ERROR_NOMEM;
+
+	/*
+	 * This means we have failed to clone anon_vma's correctly, but no
+	 * actual changes to VMAs have occurred, so no harm no foul - if the
+	 * user doesn't want this reported and instead just wants to give up on
+	 * the merge, allow it.
+	 */
+	if (!vmg->give_up_on_oom)
+		vmg->state = VMA_MERGE_ERROR_NOMEM;
 	return NULL;
 }

@@ -1068,6 +1091,10 @@ int vma_expand(struct vma_merge_struct *vmg)
 		/* This should already have been checked by this point. */
 		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
 		vma_start_write(next);
+		/*
+		 * In this case we don't report OOM, so vmg->give_up_on_mm is
+		 * safe.
+		 */
 		ret = dup_anon_vma(middle, next, &anon_dup);
 		if (ret)
 			return ret;
@@ -1090,9 +1117,15 @@ int vma_expand(struct vma_merge_struct *vmg)
 	return 0;

 nomem:
-	vmg->state = VMA_MERGE_ERROR_NOMEM;
 	if (anon_dup)
 		unlink_anon_vmas(anon_dup);
+	/*
+	 * If the user requests that we just give upon OOM, we are safe to do so
+	 * here, as commit merge provides this contract to us. Nothing has been
+	 * changed - no harm no foul, just don't report it.
+	 */
+	if (!vmg->give_up_on_oom)
+		vmg->state = VMA_MERGE_ERROR_NOMEM;
 	return -ENOMEM;
 }

@@ -1534,6 +1567,13 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 	if (vmg_nomem(vmg))
 		return ERR_PTR(-ENOMEM);

+	/*
+	 * Split can fail for reasons other than OOM, so if the user requests
+	 * this it's probably a mistake.
+	 */
+	VM_WARN_ON(vmg->give_up_on_oom &&
+		   (vma->vm_start != start || vma->vm_end != end));
+
 	/* Split any preceding portion of the VMA. */
 	if (vma->vm_start < start) {
 		int err = split_vma(vmg->vmi, vma, start, 1);
@@ -1602,12 +1642,15 @@ struct vm_area_struct
 		       struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end,
 		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
+		       struct vm_userfaultfd_ctx new_ctx,
+		       bool give_up_on_oom)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);

 	vmg.flags = new_flags;
 	vmg.uffd_ctx = new_ctx;
+	if (give_up_on_oom)
+		vmg.give_up_on_oom = true;

 	return vma_modify(&vmg);
 }
diff --git a/mm/vma.h b/mm/vma.h
index 7356ca5a22d3..149926e8a6d1 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -114,6 +114,12 @@ struct vma_merge_struct {
 	 */
 	bool just_expand :1;

+	/*
+	 * If a merge is possible, but an OOM error occurs, give up and don't
+	 * execute the merge, returning NULL.
+	 */
+	bool give_up_on_oom :1;
+
 	/* Internal flags set during merge process: */

 	/*
@@ -255,7 +261,8 @@ __must_check struct vm_area_struct
 		       struct vm_area_struct *vma,
 		       unsigned long start, unsigned long end,
 		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx);
+		       struct vm_userfaultfd_ctx new_ctx,
+		       bool give_up_on_oom);

 __must_check struct vm_area_struct
 *vma_merge_new_range(struct vma_merge_struct *vmg);
--
2.48.1

