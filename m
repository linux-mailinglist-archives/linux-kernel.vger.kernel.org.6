Return-Path: <linux-kernel+bounces-352424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55B9991EE9
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FAD28253B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582FA130E27;
	Sun,  6 Oct 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fmLUYvAj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iVJ6OCAP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA2AD55
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728225108; cv=fail; b=KOSkYH4Cemx6CO+K8UpNRXThjm1U7vIl1x9LoSrE++f583V1lgcyYrhu3g+HNXPqLEO4LSwygD2Li77sEdr8F6WycayX7lNqfAWczgba8Wf8z/pL4VWLxmPQwriw+WweA2RQPf4iYjeyZ+MbohZLvUK2+FMMcOnFiLhbdHXFfTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728225108; c=relaxed/simple;
	bh=s3vdWToQLynOhjrZS6JTUlFGNZPIyrvMirD/R+1macI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mqdjwt12FPoEV/FmkWsM+v+xsG6qBO8mDuJ3imRjHTAzCMhyOs9QNpp5WqEl9gy+OW3hfSEqRrMyw0+2Lz45kc42uEfdu9wQLszwCFJm/BzbTOm52j+jgbKIfNyoB0X64f2oNb0rnstf46fVVCpcRyeKXDTN9sH07Z0Mfe1bc4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fmLUYvAj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iVJ6OCAP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4966XX8B004608;
	Sun, 6 Oct 2024 14:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=sk/AdneOvcPd+6OW0+cMIAMxl2oHVeqmx8xLwcLve40=; b=
	fmLUYvAjxOxLBKzW7tbBiOMQhmcT4UcRbJht2ocYRmewREAAYL0iiianOcohYqhj
	LcSqSVQU7UtgYb4PW6EhTl6fMsx8U1A9AHNZevPdJHM5q2nmbBx8M0+4JoOGd9+S
	/lYVYJsPohOC0XV0i4JNGrV2wxnvi2cBTrYeT4JKCZXTWeV0SxCHbzKt1fVdY28h
	Wp4MmhGDmEkSZ2oL+BSJsYp8dwT17IyWKrbj2a/VrOL3uu/ntKPENHbF3hxlLDT5
	mw2L2mcmvHOBiKrClBbvW0CzzJqAHHLeP/AFeXyOBaakVJRPX7YgW5JIQb9Sifml
	Rkrl7reyEF/xzZhVnWK0EA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302p9968-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 14:31:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4969Z03Y012028;
	Sun, 6 Oct 2024 14:31:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw4x515-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 14:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJoe0pQR2HZ9+DNUi1/cqekY6yDicIGXWXGazfKuT+HiBw2TEqpd7OjYyFo2BkebaCJ09LlQirBHCp4QpwqBAExJz8WQSETJsKCzC+o61Qis9Q4guifTF9qkRKsfC4/IA4pL9fCyGOflmH4qlHMVALZ4QjGQD54vXtaV6Uz8J0r3Ubhi83oXN8JD14hQhMDTLV+C54SiWYHuUhIZ3WIsLyzvN3nIft9yGEF30trWwcwh8OXR7rZ+gf5loACYkfm2mD9rFGZWnaRJu6y9BQuCIU5ZBYWTSArm0lfS6v8dH1O27piNht5y7XlP4EvLIpcspbiE3l1ZDZzdX4EU0TVAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sk/AdneOvcPd+6OW0+cMIAMxl2oHVeqmx8xLwcLve40=;
 b=N1O7OwbsZ0y0Byf7lERSJrB9QKxMaPqF2zKQe6RkrgFJaK9lo8dDjUsvlyAGQtI+B22rzk2fxLfCG8knoGYH4Sd5YPDfsbIAO41sNMmaHlkXasGD19nlY/5cRiUvFNQpQHq7SHlyPbfIXeVydKLJXGSyU/bCEXgXLhV85MpCOk9A8+wuoUPXhgv5QN1mUbfpovp/yPChYkIPRd08SdwY4kmJNhamUo4KVshTMoV/2a6PqSy+Dcys6fl7IbkDIwEGZPmUZpV/uG2uaScrBcOZovxnn7D2/IEKClALiN4fITCC+ks9tKG2LmjlMaRmHwUETPRNKFRxEp/7k60o8m2EZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sk/AdneOvcPd+6OW0+cMIAMxl2oHVeqmx8xLwcLve40=;
 b=iVJ6OCAPsG1vlP4mIv96XDwBo15tCQNFqv+AVp8OF0L2kmCcz3Z9/lDKT87h16sa5eVOO/F80E9voro2h3Vf3fjuHs7NXcSFfazhFa59ddt49+93GCNkO4ulKTfoB/UA3OAzbWmxcowBeprZcCl1B92y0iZjx+jWFuoCdkg785Q=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH8PR10MB6503.namprd10.prod.outlook.com (2603:10b6:510:229::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21; Sun, 6 Oct
 2024 14:31:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 14:31:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: [PATCH v2  hotfix 6.12 2/2] maple_tree: add regression test for spanning store bug
Date: Sun,  6 Oct 2024 15:31:08 +0100
Message-ID: <12af588c6b3338bf6a73cd2d95943a83a44c3b42.1728223996.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728223996.git.lorenzo.stoakes@oracle.com>
References: <cover.1728223996.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0147.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH8PR10MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: 802234f9-2ebd-4e3b-86f9-08dce6138d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+9e4TBeP+wIfZbn40pWa5YTy3YHHZjnbo1BbpiuRIlMciG22kLrPcEXpxhMQ?=
 =?us-ascii?Q?Y4gaucfwCoy+J1rKi1z2N7D74LaF+kHk9dhdyF3EuhHz4PFKzGtmFidw/S/1?=
 =?us-ascii?Q?zDnFgg6qHSeUZ1iSF4I71FRW9EHU1+IQwZ/QH++As2gQ3EDf2degy81U5RhG?=
 =?us-ascii?Q?ZM4fOn0TCLHnJIPNvR35Lqb1C64XmR1GBjawDUCQGBvwsLd59jkvJTHwgiER?=
 =?us-ascii?Q?LEeJOmar+Klj1lN70HUEwNlUtymfOwHghkqP7EifW+oqlna80CDCwnldc21x?=
 =?us-ascii?Q?P1ui4w+wwNO7G74mrM/Ghk0P3bScenIW+UgmAAJEIMcXZXpKwpfvY/tvrhgz?=
 =?us-ascii?Q?EJBCyqRrRPq+GPbriG4QGd7MEbwNTWg6Fsvv6Qtph/ZRbGACx42hLlib3lGL?=
 =?us-ascii?Q?nJv+0Kutrc+SsyPAo42gAIRk/tIo/rH6wtdFGOqeO5xhKxCYvaL8AxcByoNz?=
 =?us-ascii?Q?of6qbv92nprZEn0msFZ3U7wJJnk8hTwhr10pxBB76UczBUupA4yhE06/Khj2?=
 =?us-ascii?Q?0qRLRrZVBZdlKyGkmWvM4ork22Q/8K5u1vfFBq2wPBwuhEPkbhNWCG1U6ov3?=
 =?us-ascii?Q?1AhtN0PkpnL8Ec3CzOeT+C43y0Mari5IkGKjtiRZf2DsTSr1zo3Bqq4nvoyG?=
 =?us-ascii?Q?N2f7q/eed8DV1wDjZEFicuZEXpEN0y/Ouda0b+neGkbkKW5K2F9ghWZesybS?=
 =?us-ascii?Q?jfsMeIqOLBsXlM+CF4ipmZEh1fKPwgZnOX6Fl7BwOK0rg5NFIj0XI89iWMzt?=
 =?us-ascii?Q?mnuMeYOxRDSn3/lU+4colSPHL3nneqdATiyAr5qkGwwjH5wnB5RmJRk70PyU?=
 =?us-ascii?Q?rk5ucjYTcwSB8r7W1qm0SSpIMXg5VDMXuLuu6NRF2cLf1dqgV1rp9q+X+amU?=
 =?us-ascii?Q?Q+2yOnXLJzRTQkWf3LFD1BpSro/roiBHsqNJfJe88nAh51Zurl01vlZPvj7l?=
 =?us-ascii?Q?zJZiP2XNHczcamL8PBqe52MyqCn47ICclAwUcaHi+tyXOIlq8On1ugo2520b?=
 =?us-ascii?Q?4LlGMklzOJDt+41UwGkgLCWjsHBAxw5x6aIJWRk5/XiKhHeBjIrAE8mj44w2?=
 =?us-ascii?Q?glSoXFTbgM+GG2pC0JVLxOLaSAA2fIgWgrqDg27kA/Ie01AEVY2X/8q4KVDn?=
 =?us-ascii?Q?6eN3+8ngl6n3n3s+ugDqlJt9K/S9xyyEpv9JChv8FvyxLanuTbg5OX7q0gHh?=
 =?us-ascii?Q?N53Zxe0JV5waSeDuB/byKzi3eQhIpawz9PFsmRwB+2hhVIm2xk9rmR+8U0Iz?=
 =?us-ascii?Q?COu+kJ8b3X1FhXEkUPj7iRa/I/swJY+Q2m8nncf8ug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zB2PlB7VQdNvflBf3Osty2ladEZQEgR+sW5xV6gIAf/wc1w5i+p5qz/TSjPo?=
 =?us-ascii?Q?ZlZUcYBZ+N6+9i5bWVv8xtnBoVIshZtlLu0NlSfKBOwK4wIvjcg5M1LZ7Sb8?=
 =?us-ascii?Q?7Mqpi9jGhVEWAHlXlxslVmGUui+SBUz1xBxuODhco0l3Dps10QLhaM2CG2HW?=
 =?us-ascii?Q?+e1Ev0eVyVOuJ7jXo7/t8fjMixh+7NF89ZyQUaGNCrJE8c9IHfn5mr8k/ncn?=
 =?us-ascii?Q?983uWDPk+1ybfbE3H9ZJbLUjFwvLEt+qz1xNPBkugrRLqnkP+vjq83b3JDs3?=
 =?us-ascii?Q?L+fEZNupRTuLWrBB0bbHoC+Tk3KSQUYIml8NQBpW9TFvRvaZAEllNVtyQv9e?=
 =?us-ascii?Q?R2t9r72Ze39V/yUthb4aQtvOCPTtwftP0W8kJRcwMhf+ll7kSim9LxIAnkc+?=
 =?us-ascii?Q?R8j2TGnMBE2CYxCuasZix2zoT8NP6XunNM4Mxo+Mwg4JTBhdIWDxPeG3FEwF?=
 =?us-ascii?Q?OtEBTNWkJ9K5OayU6+WBnQK7/Cks4NDHSlFkGD58GzRUJ64KnNMvuW/hInLU?=
 =?us-ascii?Q?DaXksv6s3iopiVzQtpBohQzRq2BwbH0cOEAQnWCAlL3jXSiPiK02AWHMEoNj?=
 =?us-ascii?Q?G9F4KAZMVIlEwPetP+z37YMHlj5crwC7JjuOAzgYA1anbgfxGOaaZitFMRfp?=
 =?us-ascii?Q?iZYM1ZR5OMDr1J7fwmDG3DvgIBoEjihY7Ejf+qMnJOql+yl2NbfrYqxLcZ0c?=
 =?us-ascii?Q?FsCWJcLEDs44ArRf4ZkRwYc6vKarekgO9iUsyxEAA7UFRxqgLCMckr30swbn?=
 =?us-ascii?Q?YHgpV0nbFW9Jfuwhvgi/G4lZxJujlCMldAkWzyYkvKx8RZibgN0wn8n9EM1i?=
 =?us-ascii?Q?bgclacvXURkMyhc76vPHgx11spAWj3jrl0legb7QUI2rSxC0uVlS4uXSm5qw?=
 =?us-ascii?Q?dBg9orAk+Zz6QMSY8et+IqWWWqmMssklYgVJEro1yLKqPyHG6U6yxH8sj+ra?=
 =?us-ascii?Q?6qa/1BraLDiUjpm1pXrDWhp0opj6M1Qcdvmm+iRk+hsARL8q5EuI533FWK4r?=
 =?us-ascii?Q?3yrnH0SX40mZedQkAkfd1/RHoK967ZrQETgT7Z1rRDbb4Ah7WPZaJYhiBjA+?=
 =?us-ascii?Q?AuLXMlb2JZQEitFDF5h3JFbQAtSodAofCH89f7pttOW8eJHsI0tzjp40Z7OB?=
 =?us-ascii?Q?vfT3X2zwWg+rEtwZqyt+7b2EhBOK25brkzKpg+xajYCa4nxDBDAONUBnUTkS?=
 =?us-ascii?Q?JHRL5uJu1K2lDzTYWbWMiwcMtcQ2cprVH12HQNvWITIh9gaaTBgRycTnomWe?=
 =?us-ascii?Q?IB1vjYNGH+NSget1ltk4GSMEkV+6vxwuB8QDHhzQzM5rX/r43gsZ5dKssGU9?=
 =?us-ascii?Q?VZEaGaHY/b6Y+DOhK/umUKtW5ir5khnOrDL5yHvUcm9Yiygreq2BHRyISzF3?=
 =?us-ascii?Q?mi5Rf202y0BDIZ/wIJQhyivJUVtT7rSFGQiH8XkiIQN0eHRKtCN1aXwMzfxn?=
 =?us-ascii?Q?jdcd+BPy6cp6nYZH/Jj6ijcSadfosrQjBSy1JIPjPAAWJE2IgScEY8NoaksR?=
 =?us-ascii?Q?tziIGVNPU1acBBDDqTIq+/S+YYnwQFk2hA6i45a+uOG/kAgQM4yRBrJtepRj?=
 =?us-ascii?Q?5msnfDHQ0gijR+2JRQvGzxXKq3JADVQPV10L+VhlwIzy4Qu8/HCxvXAVcroi?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zEXyT5uOn1aA/R5Zh/+8pshUGaOoKZ+ljbPGd4GAuamlp0EckttCXM31apXi+z1dPMgF1x7fiyE+bAjKSg2LXIo/qR/LQVnVitbc3d3V08rd/s8N6RMaRhECpxTyA3OrWN5vZSV5htdU00YVzdoD36RDHyTLfjH03JJk4MN0uymJhPAE7P04U5/JgVHAKI7UKDF52437KFE6SPIh9atbge7j/ixUTTlaSs5fa/WCcL9iZ/3Rdw1UT8qv6tPabYkBpMl/3TmGHB202YJRwzSvrNUnlprpmaq27U4aeZK35yDy+kKmamG8spzxIV7Zpd/HbDarcQG1FZQEHDP6EkKnZCH/TQX65jtbi4R5aUQYpsbRbA2yskMOXEVjdwLUNNMc7TUNrkZOnkbya0hjXY5nwtpnjRa1mXIyePKel3G5ZVbw9ZRNxuZy7jM7h2I1nQBO08+2vhGmYzIsWaAAnXQqhg7UMihw7LJ3EIOJ0ryy6eG+u4hwpfveT/2YlmBapYClNl/Yzeaa+liw/Hfc2o6rooGsh9kwvnIm5n1Q5ggDdNt/s04niVexc01+yHBa/Ign5Mwco/rtSBWvDNqkkMkWyBdZVYWQFfkYrljk1Dw842k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802234f9-2ebd-4e3b-86f9-08dce6138d6a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 14:31:23.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCLYufe0L4EGC3CkQ99Nsnq7CPgXul/LY9X+4nC1iLcXaoQmC9CUvgQdPBnntPrT9MNG96xvjr0QBMEwpo9074Sz+5b0rUl9XudoMfsbqcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_11,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410060105
X-Proofpoint-ORIG-GUID: 7fgNrj8yXV3IuNJGH-JI5wt2RG6ECY1n
X-Proofpoint-GUID: 7fgNrj8yXV3IuNJGH-JI5wt2RG6ECY1n

Add a regression test to assert that, when performing a spanning store
which consumes the entirety of the rightmost right leaf node does not
result in maple tree corruption when doing so.

This achieves this by building a test tree of 3 levels and establishing a
store which ultimately results in a spanned store of this nature.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/radix-tree/maple.c | 84 ++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 1873ddbe16cc..5fde09999be4 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36406,9 +36406,93 @@ void farmer_tests(void)
 	check_nomem(&tree);
 }

+static unsigned long get_last_index(struct ma_state *mas)
+{
+	struct maple_node *node = mas_mn(mas);
+	enum maple_type mt = mte_node_type(mas->node);
+	unsigned long *pivots = ma_pivots(node, mt);
+	unsigned long last_index = mas_data_end(mas);
+
+	BUG_ON(last_index == 0);
+
+	return pivots[last_index - 1] + 1;
+}
+
+/*
+ * Assert that we handle spanning stores that consume the entirety of the right
+ * leaf node correctly.
+ */
+static void test_spanning_store_regression(void)
+{
+	unsigned long from = 0, to = 0;
+	DEFINE_MTREE(tree);
+	MA_STATE(mas, &tree, 0, 0);
+
+	/*
+	 * Build a 3-level tree. We require a parent node below the root node
+	 * and 2 leaf nodes under it, so we can span the entirety of the right
+	 * hand node.
+	 */
+	build_full_tree(&tree, 0, 3);
+
+	/* Descend into position at depth 2. */
+	mas_reset(&mas);
+	mas_start(&mas);
+	mas_descend(&mas);
+	mas_descend(&mas);
+
+	/*
+	 * We need to establish a tree like the below.
+	 *
+	 * Then we can try a store in [from, to] which results in a spanned
+	 * store across nodes B and C, with the maple state at the time of the
+	 * write being such that only the subtree at A and below is considered.
+	 *
+	 * Height
+	 *  0                              Root Node
+	 *                                  /      \
+	 *                    pivot = to   /        \ pivot = ULONG_MAX
+	 *                                /          \
+	 *   1                       A [-----]       ...
+	 *                              /   \
+	 *                pivot = from /     \ pivot = to
+	 *                            /       \
+	 *   2 (LEAVES)          B [-----]  [-----] C
+	 *                                       ^--- Last pivot to.
+	 */
+	while (true) {
+		unsigned long tmp = get_last_index(&mas);
+
+		if (mas_next_sibling(&mas)) {
+			from = tmp;
+			to = mas.max;
+		} else {
+			break;
+		}
+	}
+
+	BUG_ON(from == 0 && to == 0);
+
+	/* Perform the store. */
+	mas_set_range(&mas, from, to);
+	mas_store_gfp(&mas, xa_mk_value(0xdead), GFP_KERNEL);
+
+	/* If the regression occurs, the validation will fail. */
+	mt_validate(&tree);
+
+	/* Cleanup. */
+	__mt_destroy(&tree);
+}
+
+static void regression_tests(void)
+{
+	test_spanning_store_regression();
+}
+
 void maple_tree_tests(void)
 {
 #if !defined(BENCH)
+	regression_tests();
 	farmer_tests();
 #endif
 	maple_tree_seed();
--
2.46.2

