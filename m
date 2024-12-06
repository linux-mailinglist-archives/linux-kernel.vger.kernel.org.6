Return-Path: <linux-kernel+bounces-435690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D41C9E7B0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6742E167338
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21222C6CC;
	Fri,  6 Dec 2024 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UjJkwvPr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QlFtI6UV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4743122C6CA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733520554; cv=fail; b=Mvc9yWZBkspzAlhwxpeSguBVgmM94EJIY29Fvy1IIVkicQdkacxODXbNnMRXIhwm73DEVi+JTsZBKdee5qEQpolprIe9B85uHmKQWZDhQnEd/6r13FyluKlT4An26kS0sxC7iaZJ1IyDN+3FabU86avZF6iv3pcdlc1BdMbJ48U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733520554; c=relaxed/simple;
	bh=BGEyubn4bCF8ANMLL90EvYSp1k2G9feBBpNdNtPVJrE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=becJ4QrlYO6bb8DdUgVFUfXOfF3ivCYiBIFoY2lglI7yoezojkOpm4I4Y/G7q7hViwfneu7AQTF5EoLOag08ieiw9Lf+5S2SBa36jjPzwC6bidlyk5tutETeAHQIdMNlqwuciQBwAruJAC+4vAas0AbtC+7BPk3f2GbVAWDTCPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UjJkwvPr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QlFtI6UV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6JMhKN005663;
	Fri, 6 Dec 2024 21:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=ijG5woLzrfP/ShYz
	DvS4wLkGf0SQ3gNGK3bFvVQNIuA=; b=UjJkwvPrL6aQPvIRfVVYcMM5fOvOa/r0
	Zs+7/XWdsgkGIk+Wot5cpGg+TFVaeUrPkkiAbq8WplEyTDvJD/9LquVltI022iJC
	V4TaSBJ+/HSqkq+z2ELXCIZMuT94aZVPFfkmS72R4X1mgN4W3kjAfmHsMlnBdW+U
	ZmBz/U/XcC+6YwTayc0e4SYWUOlNMvx28TOEAEXRUyJv0wwC0gWL0JFG/pvQJYza
	12Q0RaN7XbBwnHEoS/nuEhRNh4Msi/9c8v68Vtkhkd1Th+Uto8uLTHQQAsdMCBAx
	Re10hudQ+QDCESsgpgb72EqAbL9jwRRxKj7JzqNbDypEfLdvNlyQLA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sg2e9t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 21:28:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6KV7rf040191;
	Fri, 6 Dec 2024 21:28:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836ypqdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 21:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9GDp/lAwltoJ5NJS7stz1REt4EMgtzfTNCIm+VkG+iYxpvvj7FSHJQ8eCfY0iFOGyf/n/4rB7/NoQ2Nw86lf+toGONllDsf4NvQCzOgi7L4zqE+rbbyf/eLDle58agSRT+Wu4eHYhXbGwBUwZpxxUyhW5ZBTBcAkBt+OtFRSNVvUQTCGWiA7FKCXrf/Az3LU7E8aiS3iHHf7MkdHljx5RsIsX8mtiQYdd80+x4PaZl4lqqm+AoLJ47q8Ce7qFr+2Ml2yGgdkxjMkHoznDXiH7fJq1qEc66YuF6gtM6QjKzCIApe1I9+68Wfe464q+nl5spBuwTuG67LQQ+X3NsHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijG5woLzrfP/ShYzDvS4wLkGf0SQ3gNGK3bFvVQNIuA=;
 b=JYT2T2rMx/QgDt/71r2SjwCSNA783crZcqicJHjY+wgFK3B8BspP2INQwOeWL8QeccBy7KwCIUBeZWHfaXge6zKJWmrUzmJhQkhcIJkxkxOGSS33Jx8pPY8zHVyNZ3ShyFseDh80kGuxgfNMAOox+/vPn1MEd+QrkElwxrZ3nnATcRAPCw7GIVZ5OygJbF7QLH0JL0xDawix6PZb4ugfvz6bJlv6DvswzwbUBHNsJkj7PeD/QVyxQjNvlgWah9dZpXbOKZIZXlyV0tnRoSWngB3optjK3mLTEm1Bh/GYcz+AB5GUho8DDIL2Kvy8OUCUl4ufMO5z7ynxnkgkoKPqKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijG5woLzrfP/ShYzDvS4wLkGf0SQ3gNGK3bFvVQNIuA=;
 b=QlFtI6UVR8a6VOdp2nkStnMS6tra5AJQock39yZ65qZIkr02csqk0zIl7G0BJ7xAyoVIjpDXIxP/uwPExCLU1H4UcxSGGdiydsMHKGw5GlnSgoBAc7F8S7Ro00KDk2qGdQ8RlwlnG/rE3KAW4p0MIPfwepVe5i0Q+Po+H+Td0AE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB5780.namprd10.prod.outlook.com (2603:10b6:510:149::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 21:28:50 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 21:28:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Isaac Manjarres <isaacmanjarres@google.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: [PATCH] mm: perform all memfd seal checks in a single place
Date: Fri,  6 Dec 2024 21:28:46 +0000
Message-ID: <20241206212846.210835-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0365.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: b3d0076c-73d9-49f8-0a4b-08dd163cf9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RsbV8/o8WsmZZoG3BvfwGYm7ofQ5A7whjZSk2MsDse67ziGygEneQhaW/Na2?=
 =?us-ascii?Q?ZHiX1vLWxm6lwFfyctuY5IrslwEaFLwdg+WthfjqGgsVIHBXZFYecPMVPkrP?=
 =?us-ascii?Q?OMLK/VxSzL6wi/t2ll3jNTW6ByrB1QkcvhlXJf4t+nJF+HZqvqKnrkrQybLH?=
 =?us-ascii?Q?4d6j7LF94pYutHiRUFzak2BmG4Rxhrxjd+9uCwcuun0sNOgoUGACynPjdUkM?=
 =?us-ascii?Q?WPZTnlwn0vjcNXVdYap+QNF/z4WByhOSYO1jEQhaKfrI9JJyLsxBQL63Bz7+?=
 =?us-ascii?Q?dgRYicewq4/SUgHkU8LhSX5f6XlMpzsphpEzFtcuxOz/ZPoXMi2EKg/fk9Sw?=
 =?us-ascii?Q?gT/436/Wr5Fw5Q96DqdqsP5B0pFHphuh3QHEyIEuLn+l8X5wCn1BnYMJEM7l?=
 =?us-ascii?Q?8yaelUh1XDrbnS8jCBQ9VNuqgEPnbbg7rL/U0L9k4rHwguBps8+l4Px+4lED?=
 =?us-ascii?Q?+Id5yoKoIWQQ6BArT9p897SWYx4lG966aJ+YmJdFmVywHb1+HD7YO/K3Wt7B?=
 =?us-ascii?Q?riouNk7603lJ6KHMnnCNeBobwhZeuH35IKjjLjU9GMgDg+YcQj5H0c151GDg?=
 =?us-ascii?Q?rXQRThbdUE8apv/ZBsF/SeXXFP7VzNh60V70h9OuJ3dRpXhI7fI/+o8ODfRj?=
 =?us-ascii?Q?FdFfDu9Gi3skwq3q4xDLWVRD/GHX9Efa1ROlJt3tzyl3Nr5G/8c686UDdWNz?=
 =?us-ascii?Q?X36dhhZ3CCofBlHRWsFh+iXuSOk0skLDBiM9skwsbM066vPiovmZbe+tKG35?=
 =?us-ascii?Q?Oe01RteFBjvM6TdrgwKNLZdWkE/Vn+ApHFTiWFxxCN2CrvnyZge1aR7++Lgg?=
 =?us-ascii?Q?7bEsa02xbf1GNbGwQ/IG4KpkH/o9bESccblBRWB2gCYaNrMWm1rEvNem2E97?=
 =?us-ascii?Q?srMlHH4IpI56eJuYM9DthZ5cWifn5tWAzqK/fIZoNV6V2d6SlQpjQBWJAYco?=
 =?us-ascii?Q?DC3p3C2/ANHxclO9Hrv7vk8p62dqshByZWg1OmBLBh2yd82tWvv5qXyrvbAC?=
 =?us-ascii?Q?DdmvbrFgsQtctENa5hez1DHHIQVsJULQPpU3jIadGPBhmjqN28PBTBGDwh+X?=
 =?us-ascii?Q?0qZEqxsh1As1ICPkrMAUqHlfa2RhqAuIkzDbRWZpBlW7B0eoA6KzAaH3ATSm?=
 =?us-ascii?Q?01LC5hhSS6tlqvyDs7XcRvbI83U2VRmpRntdePvLO1JKADlcsIps1oWeNFXh?=
 =?us-ascii?Q?CZscIeZgqp/4fu2QBXi/I5scGdoOzdVBTpE2SAUgLvsil1daKsCpvDpeF2LZ?=
 =?us-ascii?Q?hmbbK9D7cU+49II8PkKNW30v37aS7mbzwpLxB5fpu1e11xkreAZM4IXqFafG?=
 =?us-ascii?Q?G/NK0EWk1DHyZLa8SS7XVXFUXCH7InBORrvkfa3ltdlYxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?So9mxrk9gdw2qZbjJ2p2mVHuVsBvvAjeiPMuTpDORbrbsn7/gp9jOOcz9sjf?=
 =?us-ascii?Q?3x6vRaI2VTaBcVnOL8VSH2lk0LlEYNSuuil0v9c72giYk+RAVMeReiUu/WIb?=
 =?us-ascii?Q?70LznIFS+JrG0if2yrvf8V7bTCrgNFv0cRFB/o0H5/7piYJGHesFpiO6jP56?=
 =?us-ascii?Q?39wDKydU8DZgxjb4hjnUCqPP7X+F9iiufzlk9N1Y7vVuEVDDUt/RyKjSJ1XD?=
 =?us-ascii?Q?bFDPPYRo9BCdlBV01I6bC0ScLTtELbWnu7Qrke15ygQWuBwoFvF6cw2UqHKP?=
 =?us-ascii?Q?K1Ersgga7FETtzPW+J2RX4naTvjNfZrPwcGxLzulJW/bx+9LVD96zPuZZDeb?=
 =?us-ascii?Q?1gNwA3kIAE2wSxIaS3sEDaPtZttK7AiSayIR/aQHOfTit8R1AbEVstnOwLGq?=
 =?us-ascii?Q?UROf5+djyBW+GBhXTZrolNhx71DvbsVvH62bXyRYL9noDlAkd0sal8nxm59S?=
 =?us-ascii?Q?OGOk1m5Dem7uzpQQB+aKuciB2wkHasfGVoZHY7qCV5TNOVvLqhBwo46Gx+rm?=
 =?us-ascii?Q?EdqI0Os1Ir7dnRbzU+W2ooJitxUv+hwieGy5RZeeueTRG54uTqCCdQnnMmXE?=
 =?us-ascii?Q?SOUa36U9W3mBZoGSP6FI9/pdxMNTh7+T1YabjZf8S8k8FlX00GKqaZwHDE84?=
 =?us-ascii?Q?EdGDc5mEjFYvB3haoRfDs16Jn4W4JJvYB4hIL5qLo2aOBsVDK6Dbz62buofc?=
 =?us-ascii?Q?oxwDRpnleqK0M7NVTvB6p0Av9bx/40cHEHb8hrtoyWMPp/AzVaF4JS88kHSN?=
 =?us-ascii?Q?YdC9vUtdUFzrQUuuhSPIBn2k4KUIkK1kf7jrIRH8XHdksCbmA74LDmDSN2HP?=
 =?us-ascii?Q?djq+hWCDddtRZpNSIGOsAlyJkHesRXRc432e6ScxmjiSgGueNAg1BOvfZtZd?=
 =?us-ascii?Q?5xjD7Qq8eUHbBttKLS7sqTWLds5r5hGw3uKNVL1G/SOH//BKJxGWABNkRgX3?=
 =?us-ascii?Q?YtvTqEZWGfBOAaHdJI6yGCxMJwyu8XUPxGrNBR1MWa/eqZ/nZzFQKQV7fiFP?=
 =?us-ascii?Q?Fd2gOnlbIsRhpCFpcoB796WSjGNDmr2Reocf7hZYXjhikT7rESEkemmyptq8?=
 =?us-ascii?Q?EcuI1xKM2n17YHZyYea0nBVcYaHEBe6kLgaOt8vQrZtACRoJIzGNr0MN6L7i?=
 =?us-ascii?Q?LWV+hvz9iMuths253f+5uQJk7vXI3UJ67nvvgqNeI/4ZQNK1OhBYxVRMp8NU?=
 =?us-ascii?Q?0cEjc2o8aj9dgPQ2cqe899yX/TZCW05Wbi/w2X1m85jryxfolisgbScka8oe?=
 =?us-ascii?Q?EhI/c6LBcvaZJjwwdJdXkGHWSykiZyMogc1mir9CfxzTtTGqMDXln9+LGuco?=
 =?us-ascii?Q?IMLbKNfc43UCYcjHDMt1v3FlzhZ//O4v4se5RtgYPKv2UWMT314uImt7PtZf?=
 =?us-ascii?Q?TiaDwE2Ivq8lb5ZwwQ6pqi+NyqKloNATeWQ3yBAKKbgI/NJAnmDjU+TEY3T3?=
 =?us-ascii?Q?k9R+FzAAXnsGsD+mBt8QDjDjm5LiMpRtkNj/dAh/hKcezQ4PGS63IDMOVLT1?=
 =?us-ascii?Q?FF7Xu20LUWx1+2eNHH0uvQ/mesvp+z81kEhmJnAcZSTq4KNa+lXMJjyz/Ak0?=
 =?us-ascii?Q?s3Xs1kbvQjXchrkHyOoHdZpXrUD1bWDQcVhH1zWN+75VSDR1/iavCUMPIhBR?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TOPyoRg3a5Xg1cFlA+JCnKLUxqag9kUyUYDEC27GPV6RNKVICygKWP+zg/c0mxm+yKU+B2Zdo8bY8Bav+FYxcmU8611YKj+xzwn9Bj74M+o5q6sWHDqs62oqSddQZ5oAWCb0Aq57q+fPmnEUukX4/p/gRgbArY6QK04YeM/36jZI1Envc3hUbFiIdBl/No+oqE+SL1m54YaK6Q9D29zrRjRobO9DX3AovZTXQtBeO7hnnvp4leA6JS7eOjHF0arP7UdARfdXCVVuiH5lwTEs3hC8MZxUu2RKZ2oXq/JEhAjVojd9mPJm8UAc1e7VOEFZVg39vFxnKNaKg3XMiJVXYR0riV4Qz81yOfQs2eQAwjSuPaPR2FmV2nl2xi2ZSUiK70egwrggaGCH8cH/6gKMN4XfVphV392IkVXOWw6QM8GbTgs44CCmDH056Zuzzk6An6Xbp/nz/h3rFTxi8F2ArlATaE0E1eHUcmLc/c7rZLmApyMDHuYP37XVwe30+H7UO7NG3C+Gc7Cbw54vkFH2KFaR0M040HVTeP56GGO1HL/lXCH2G+eOb40LTh/IuZRnYtUAdAIdLqiWWdfcgkbOEUEnqTVYarIe1gjV0PzR1KA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d0076c-73d9-49f8-0a4b-08dd163cf9aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 21:28:50.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUvNOslsr8gWZWCAxmejn47MdapQyKaeqNNHMblkIU7MKYGCICnqhMb1CWFe630hgZJ48FN+C+p/qEvZ8CGriHXCAum5eXMOSQYIZdgIVH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_15,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060162
X-Proofpoint-ORIG-GUID: L9DKb6x8vzm2p7-yZhwkz7ifZ6_s3zio
X-Proofpoint-GUID: L9DKb6x8vzm2p7-yZhwkz7ifZ6_s3zio

We no longer actually need to perform these checks in the f_op->mmap() hook
any longer.

We already moved the operation which clears VM_MAYWRITE on a read-only
mapping of a write-sealed memfd in order to work around the restrictions
imposed by commit 5de195060b2e ("mm: resolve faulty mmap_region() error
path behaviour").

There is no reason for us not to simply go ahead and additionally check to
see if any pre-existing seals are in place here rather than defer this to
the f_op->mmap() hook.

By doing this we remove more logic from shmem_mmap() which doesn't belong
there, as well as doing the same for hugetlbfs_file_mmap(). We also remove
dubious shared logic in mm.h which simply does not belong there either.

It makes sense to do these checks at the earliest opportunity, we know
these are shmem (or hugetlbfs) mappings whose relevant VMA flags will not
change from the invoking do_mmap() so there is simply no need to wait.

This also means the implementation of further memfd seal flags can be done
within mm/memfd.c and also have the opportunity to modify VMA flags as
necessary early in the mapping logic.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/hugetlbfs/inode.c  |  5 ----
 include/linux/memfd.h | 22 ++++++++---------
 include/linux/mm.h    | 55 -------------------------------------------
 mm/memfd.c            | 44 +++++++++++++++++++++++++++++++++-
 mm/mmap.c             | 12 +++++++---
 mm/shmem.c            |  6 -----
 6 files changed, 62 insertions(+), 82 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a5ea006f403e..d8f852b52c56 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -99,7 +99,6 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
-	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 	loff_t len, vma_len;
 	int ret;
 	struct hstate *h = hstate_file(file);
@@ -116,10 +115,6 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
 	vma->vm_ops = &hugetlb_vm_ops;
 
-	ret = seal_check_write(info->seals, vma);
-	if (ret)
-		return ret;
-
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
 	 * overflow a loff_t when converted to byte offset.  This can
diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index d437e3070850..d53408b0bd31 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -7,7 +7,14 @@
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
 struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
-unsigned int *memfd_file_seals_ptr(struct file *file);
+/*
+ * Check for any existing seals on mmap, return an error if access is denied due
+ * to sealing, or 0 otherwise.
+ *
+ * We also update VMA flags if appropriate by manipulating the VMA flags pointed
+ * to by vm_flags_ptr.
+ */
+int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
 {
@@ -17,19 +24,10 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 {
 	return ERR_PTR(-EINVAL);
 }
-
-static inline unsigned int *memfd_file_seals_ptr(struct file *file)
+int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags)
 {
-	return NULL;
+	return 0;
 }
 #endif
 
-/* Retrieve memfd seals associated with the file, if any. */
-static inline unsigned int memfd_file_seals(struct file *file)
-{
-	unsigned int *sealsp = memfd_file_seals_ptr(file);
-
-	return sealsp ? *sealsp : 0;
-}
-
 #endif /* __LINUX_MEMFD_H */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cd2b33157d5b..d642f637cef8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4091,61 +4091,6 @@ void mem_dump_obj(void *object);
 static inline void mem_dump_obj(void *object) {}
 #endif
 
-static inline bool is_write_sealed(int seals)
-{
-	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
-}
-
-/**
- * is_readonly_sealed - Checks whether write-sealed but mapped read-only,
- *                      in which case writes should be disallowing moving
- *                      forwards.
- * @seals: the seals to check
- * @vm_flags: the VMA flags to check
- *
- * Returns whether readonly sealed, in which case writess should be disallowed
- * going forward.
- */
-static inline bool is_readonly_sealed(int seals, vm_flags_t vm_flags)
-{
-	/*
-	 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
-	 * MAP_SHARED and read-only, take care to not allow mprotect to
-	 * revert protections on such mappings. Do this only for shared
-	 * mappings. For private mappings, don't need to mask
-	 * VM_MAYWRITE as we still want them to be COW-writable.
-	 */
-	if (is_write_sealed(seals) &&
-	    ((vm_flags & (VM_SHARED | VM_WRITE)) == VM_SHARED))
-		return true;
-
-	return false;
-}
-
-/**
- * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
- *                    handle them.
- * @seals: the seals to check
- * @vma: the vma to operate on
- *
- * Check whether F_SEAL_WRITE or F_SEAL_FUTURE_WRITE are set; if so, do proper
- * check/handling on the vma flags.  Return 0 if check pass, or <0 for errors.
- */
-static inline int seal_check_write(int seals, struct vm_area_struct *vma)
-{
-	if (!is_write_sealed(seals))
-		return 0;
-
-	/*
-	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
-	 * write seals are active.
-	 */
-	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
-		return -EPERM;
-
-	return 0;
-}
-
 #ifdef CONFIG_ANON_VMA_NAME
 int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
 			  unsigned long len_in,
diff --git a/mm/memfd.c b/mm/memfd.c
index 35a370d75c9a..5f5a23c9051d 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -170,7 +170,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 	return error;
 }
 
-unsigned int *memfd_file_seals_ptr(struct file *file)
+static unsigned int *memfd_file_seals_ptr(struct file *file)
 {
 	if (shmem_file(file))
 		return &SHMEM_I(file_inode(file))->seals;
@@ -327,6 +327,48 @@ static int check_sysctl_memfd_noexec(unsigned int *flags)
 	return 0;
 }
 
+static inline bool is_write_sealed(unsigned int seals)
+{
+	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
+}
+
+static int check_write_seal(unsigned long *vm_flags_ptr)
+{
+	unsigned long vm_flags = *vm_flags_ptr;
+	unsigned long mask = vm_flags & (VM_SHARED | VM_WRITE);
+
+	/* If a private matting then writability is irrelevant. */
+	if (!(mask & VM_SHARED))
+		return 0;
+
+	/*
+	 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
+	 * write seals are active.
+	 */
+	if (mask & VM_WRITE)
+		return -EPERM;
+
+	/*
+	 * This is a read-only mapping, disallow mprotect() from making a
+	 * write-sealed mapping writable in future.
+	 */
+	*vm_flags_ptr &= ~VM_MAYWRITE;
+
+	return 0;
+}
+
+int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr)
+{
+	int err = 0;
+	unsigned int *seals_ptr = memfd_file_seals_ptr(file);
+	unsigned int seals = seals_ptr ? *seals_ptr : 0;
+
+	if (is_write_sealed(seals))
+		err = check_write_seal(vm_flags_ptr);
+
+	return err;
+}
+
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
diff --git a/mm/mmap.c b/mm/mmap.c
index 1c6bdffa13dd..902fe4266448 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -368,8 +368,8 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 
 	if (file) {
 		struct inode *inode = file_inode(file);
-		unsigned int seals = memfd_file_seals(file);
 		unsigned long flags_mask;
+		int err;
 
 		if (!file_mmap_ok(file, inode, pgoff, len))
 			return -EOVERFLOW;
@@ -409,8 +409,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			if (!(file->f_mode & FMODE_WRITE))
 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
-			else if (is_readonly_sealed(seals, vm_flags))
-				vm_flags &= ~VM_MAYWRITE;
 			fallthrough;
 		case MAP_PRIVATE:
 			if (!(file->f_mode & FMODE_READ))
@@ -430,6 +428,14 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		default:
 			return -EINVAL;
 		}
+
+		/*
+		 * Check to see if we are violating any seals and update VMA
+		 * flags if necessary to avoid future seal violations.
+		 */
+		err = memfd_check_seals_mmap(file, &vm_flags);
+		if (err)
+			return (unsigned long)err;
 	} else {
 		switch (flags & MAP_TYPE) {
 		case MAP_SHARED:
diff --git a/mm/shmem.c b/mm/shmem.c
index f4e9c94ed8ae..41d7a181ed89 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2815,12 +2815,6 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file_inode(file);
-	struct shmem_inode_info *info = SHMEM_I(inode);
-	int ret;
-
-	ret = seal_check_write(info->seals, vma);
-	if (ret)
-		return ret;
 
 	file_accessed(file);
 	/* This is anonymous shared memory if it is unlinked at the time of mmap */
-- 
2.47.1


