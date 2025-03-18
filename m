Return-Path: <linux-kernel+bounces-565325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14804A665E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061D73AFCA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEB77DA95;
	Tue, 18 Mar 2025 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T/lDe39b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D/iJq3D6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B03BE4F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263190; cv=fail; b=YXIIK9fLfBK3eVfUCXK143l9GdhDrO6p3zJ2jZkiV0EtGM6DeNBwMFArB3ehYUQt2vGUt7kxmFZ09oxuWG71KGGIiVISX1S5Qx822uXRSF/rvMQKKfhx7wystfRFXj4evjm3dZBSc2qSbhXKpNum4CCbyAUouk2lEJU8UAcXovc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263190; c=relaxed/simple;
	bh=kPowirnjYekFkbCIYc9Z8kCIA7D+ej68CK1Q4+J+z2A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=palJE2iR0aw9QyYZiRmxZXu78qFEvd8tgeGxVx8dNhmuvo9Wvzr800Y1ca1bkRn7nG+WpxA3t1JzpjPkqd6EspzzS027Gv0REWciJoZ4mXSeGweNq0vY1UbVCeaXUj8iFuDdnQzFR1WG4YlXa5D2oBY4soz8EE25xXnC4rLsn9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T/lDe39b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D/iJq3D6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HLtumI007190;
	Tue, 18 Mar 2025 01:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=V6PHt35mQ5mg1ThX
	XmkSmgl36JSZluCXoY64qfajUyI=; b=T/lDe39bFM/vTBnOFnAbbwZHD4p0KOWW
	riMAxpEbskImn3PcPUHSKxhjdri0+jJl6ZWD/Z9g/wnT2n4qyw6ZWzuXmGhtqDFx
	OHyqV8d1Vgz+awE1c9uIGFmeiM2wKr0Vb+sTUMSaaFBqpMZUJ2xXXHVstqkPtEG6
	Rwxrf6k3ABFdErff8lcFZplU2z3Lv3a/lMB/x/qzt4gAuBK+o3Eb8V2FgU88Dm05
	Th4yP2Z0Eh1gIpBLiSLL2a0Bn1hoQ1fa7hQ2jC7fsJGAL6Tr77K3O4tS8UEmNv+A
	ZomKv2k1K4rxZraH5Pdl4s9BBjCHXZZKDuLqEPmgpR6x7+5gM+b/uw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3m626-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 01:59:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HNorOk022438;
	Tue, 18 Mar 2025 01:59:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc4xa7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 01:59:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1c3gx+lPQHBRWsP144trFy4quWeaWtSWdBAE9Wblqjyt3OyDtHm6WpYqctb+KLwuVjrfgIB01457o/s1R6fFWKCyIHGQh284ZubwxGp50AbatDqCsQljxlKSmHEgLFxz+Nw2hlHRVUuTT0D408RrWxakNBM0seGoOkkbau/NZ0dcZqAvmrdSY40n2r7t6w1kD8AP67LvbBHNDByspnJa59EIA3MRBskV+PqXHZp4b059auyNwql+qPE/4gzRTg9KPvQXPzrlicvVPIVSi7XpUKeMTyVTgh8Uuiav0XCZ4iriMSJAVIiHhOYGxQjtFhyOJdhXzYG6tPFmwZ1u9jssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6PHt35mQ5mg1ThXXmkSmgl36JSZluCXoY64qfajUyI=;
 b=LuRx1cTxjs78edlWX3zKf0eCPAnMvan1M4IlDqQlPqhbWEZWs5h9dVt318y8Dlw/m5NOe3bwdWTqCAjM5OB/Hdo7ChB3ittdROVgwQveuHPbvJY/htwGqUgOIn9A3L9DN1I3O2qCpZpoeyTZKUAHp4jnarPRKpYAVGa04YLz4fp11Lh4auDRvoc8ivUSu9yF9krCM7tsUNMN64qZDEEN2eASwBt35Cdfd/942hGyEvrUncepfCGe5ojlP2uF2lMybt0OWQhV5XAUVQqFZAtiuwD0VtL1Q1a/NixfpNvaRC8qkQ3rY/YrNwGatxClJag6nTMRrLfCiAVHNNJ2L7Vzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6PHt35mQ5mg1ThXXmkSmgl36JSZluCXoY64qfajUyI=;
 b=D/iJq3D6caX/HabfjOXcQePMJxPX/MtmNhCHiKE8OSpbWNsgAtNRaQAD8ZEqvItUBQWzzF09dfPf5LXulNFyB72FKjLqqtc9FOk697aXxcH8uiXu3qhhtfa7vjsl3a5J3JXuJBWL1WM8Y64KNs5+6ytvVVBTee2XuN0R8VnQS4I=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6218.namprd10.prod.outlook.com (2603:10b6:208:3a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 01:59:32 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 01:59:32 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH mm-unstable] mm/kasan: use SLAB_NO_MERGE flag instead of an empty constructor
Date: Tue, 18 Mar 2025 10:59:26 +0900
Message-ID: <20250318015926.1629748-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0206.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:19::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: da4fb964-4da0-45fe-8722-08dd65c08644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iBTUqad91wl08lfsgf14fFSx67zMmivDwXDiRZhvKEyc0P3vN0dRw3OOsskP?=
 =?us-ascii?Q?r3TdFOjtDn2Ve5IwgnV+nQeFO3+gnGTK4IcXNFxEAq4NN/rDWgHFYEJmtzTy?=
 =?us-ascii?Q?jZzoiPKYBGjb+poZ+GZAUTn0U5wee2lxPggCs7VLPOexepNYZbVwYdwUtTkB?=
 =?us-ascii?Q?ZR9BFX7hL2F2ZbU5G0WqUYSm9JLYcgLqZISGlwCo9YexaTcvMpwasAIPPWNV?=
 =?us-ascii?Q?aLTKkJPvZNaJPyV2c/uIRuad/chOca1pQOc4livVKNiKQwxcTWFdmnvO6Zni?=
 =?us-ascii?Q?Z6kCRD+dovltDAnYB5wm5l8ULHvLgJHrCLDfBUZ95yRRuN5RTDRJZ+/x48b0?=
 =?us-ascii?Q?s9IXhEBzz+nU2J5w9HoAAHYhBg3gYHbBJJhWBMMuzTukig0cz6vZFtiMuTHk?=
 =?us-ascii?Q?7n8ZCihQ9rhQLDpbc/rPW8OI8GOrLFJmL1q5SYbQm7L6dWlcRglDBvxmtTVS?=
 =?us-ascii?Q?OrxVFGfInBrPLqyFtrLY4Kw8Ha0WTcuxc8b4fCBeyHLYR6ApfkShleO20of/?=
 =?us-ascii?Q?/xk8cvXyQShUVjK7EZ5ruH7UXr5RsM0W7gHci4CoadBU69xokr7vCHNdTrKv?=
 =?us-ascii?Q?j5gQNq/Xuu1sH2XWBtSr6aS6D1U8oXwZny96NjtF0HOegkTSqd/B6qee102Y?=
 =?us-ascii?Q?0Gh7oXoT9sOheZibJVQ9164ptx3ZSaqyviVBWjsdHx0Asj/9APDEd3lYNSje?=
 =?us-ascii?Q?kBOblBlhYhjIBmqNQMDipZx/vGeq4mMVtsnSGVOi050HYCXrFCYrr6ohkSSG?=
 =?us-ascii?Q?3Xl9dEli23Za5M279L3fBGgmouuX+L7PqJw+BfiImHdvCJraRb4Hsqz3WEd5?=
 =?us-ascii?Q?Iew5sr4je5a+ZEXNfm+D9GOm+zH/0NEMJT6ZLi5EN3IdUEiLQtmPz/sDgI/F?=
 =?us-ascii?Q?IoiuwtOivtiVBrN+SFZD3aeE7pv49nzd7iTxzHly7/bMXP0UoCUGQMl5V4vr?=
 =?us-ascii?Q?SSdg8DdLCL43MbB9cvqrL9OMWgk4W2vFxurGH+Del5qZbMc/hEvEWHpTWPUE?=
 =?us-ascii?Q?bYgEb6CIZLI+q/GyQ/XdeQ+ggHuee1Y/VTSPD+G20PeHi2CbGovHl79Mrhx7?=
 =?us-ascii?Q?Ti6QwV+/QSep0Anqm0wu+qT3L3qG1xCCvA6oYtLw0IVdDgm1fSmL3Wb05baj?=
 =?us-ascii?Q?FXPoyEvZNUR9FRAcPWz8KfmHcVRwKWEvvzs2Q0lZVo1Uzj4buSoXvsl6Qzlq?=
 =?us-ascii?Q?IUHWm7eniL3iG41Ytd+JuKXW//2+DBfHjcGBJt5+JJI2bH2RhesNO6Ur3WqS?=
 =?us-ascii?Q?TQfpbNlvQmHqtRfN2mWDBIgTTYM6/ssHnyWwNSOaGt6jGVvK3iQBoeEDcoeY?=
 =?us-ascii?Q?u+E4RoLWzYE+YofAgoSAW7tK7/xSGA/02hFp8xsceL7s6y3KEhVoH3wFCig3?=
 =?us-ascii?Q?gYb/oi1iqYvKVA+GFOfNTKAZcxP6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5izPCIEn1bP+lW7jMIhScX/XCdp4rKwIGnzrJBYPELbfKToR9svQQiI5nLO9?=
 =?us-ascii?Q?CkaIHut61FGir6vbJATtSi6g1MOSPiT7Un9S4oyO9ZNhmKHNTu/SOruPnL6O?=
 =?us-ascii?Q?kmk/MWuCkcR7xyusmAKbloa/EwbuD+lQKQzTYFguH0j+3fDY9VDiJBw8DmOe?=
 =?us-ascii?Q?PdMS2gC7GGMk3rE6UDV2X87nBLfkDqMABy/xUjEn9wWOzVSPRQsTi/h4ND+2?=
 =?us-ascii?Q?hmvREJ1uJyCuA7/RD9UqsDnfKMmU0cIM8HYZbPm8RB+0Ynoc2Ht0OxAiESeG?=
 =?us-ascii?Q?/nQ221+lAgzBdFaA45AUi/tdDC/o2fiHkjQ+bLEkHIWA04WSZlAuBMtU/re1?=
 =?us-ascii?Q?EKoNENwChj/7ChmPuIRJKNwcJf90boxQUhyZEJal6HmglFiToGe56xLZNa/I?=
 =?us-ascii?Q?3bGyjZ2VwrAcv7JNR/KLaBlMdh3lHKI6YQNvZRCsnYgrWVykka0BW05/GnYl?=
 =?us-ascii?Q?sc8XQE7gaG9rYdszT9sLTQCBzbFiFdCqIxYr2bRjU8EEPBJIOJ039z3TXeVO?=
 =?us-ascii?Q?jw1Q1aHKCMiono+JYi4UlQSqiJbVsmH+CH6kfsDn6dPcvfUtlvtwJtFspvKS?=
 =?us-ascii?Q?uPiDBWQaSIW7/WJaPh1+WPLAUv7bx0wSPVEbGXbIgBCiuDB3NInGHFDKVvyu?=
 =?us-ascii?Q?4JzELVLwW1VQ4D0rWXdek4Xggwu9ncBUcjwp9MfbKEkICTvvh6QK+zTCctWw?=
 =?us-ascii?Q?Mc5GS9e4Bd9WIzEWMlnHOTeAcAajnwdFzQuDKAREhzPNnRPv10ShJcQ2PCX8?=
 =?us-ascii?Q?cHpftXqIdYse0/q8YMHqSY0tR3+NFtG5ou25NtIUORgz2RIhGnQ67ZBKbo/b?=
 =?us-ascii?Q?ZDBYYV3F3Pqrvh3vklEcjGmi+m+k0Cm7h8Lk3r1oIeTy0j1/wb28vC/vqqYe?=
 =?us-ascii?Q?H0k4uYw6uL4GEZ3kCryGbzkitT5a4EIILeb3TyqZ0h3jHoOPY0gwmWJKIV0O?=
 =?us-ascii?Q?sqzip/yAED+kmGWekE0rj2EcPaUU1ZgI93qBvehuuZE5DMqTCfhEXn6RhTG+?=
 =?us-ascii?Q?xYBqOGt13tLZjWvmvZVyy2xJnJjuhaLpcl3E4I5EF2Ki18/EYq6M7iqR63IS?=
 =?us-ascii?Q?V2nPFaeOgEHA7rdlU6E/bXuW289h3rI5K15CtDNKTiB+3MY5c4jGRFcOyGNz?=
 =?us-ascii?Q?N4uX5Ed5Rr4PviXqLfDyrjUN+64IuWPPaxMji1hLD5S4SH1fUQ1bnzMwYmrc?=
 =?us-ascii?Q?689cZwvPhwSYzJ5p9obMXVuyVa7VVliJMyOQyKUZnnLetKauUdarH+gA2tmQ?=
 =?us-ascii?Q?J8pbJfSD1q93vn584PYc34lzjLIocHgzIfg7w2nNxfhgB4oWdACO92Zk3yCD?=
 =?us-ascii?Q?FKxch0jt8SQ9hXzbvhQTryBCVyk0yO6XyW8gZRUweXKNJ/S0bMXoOxnYovFF?=
 =?us-ascii?Q?q651egSZL2o30LWCjE4bpu5jJAH9z4oGDAQlqAJbjUdAk4OahKzSlhKXEo97?=
 =?us-ascii?Q?tUUTZ0a87hiKczNzEFI78AZkphTn2zs7Iv3YaMuJyaKD9zcZYkgc5YZ9L7y7?=
 =?us-ascii?Q?+fD+TuPMSG7JQf+fGN7hUuDhFbmR9RMaO7uvmRAdGSFtDF9PQAVgWLsyB/Ss?=
 =?us-ascii?Q?7N/2W96NG9rAmEuB4VJEM+uY8+NDqR0mXGx85YZI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KGWR3I2x3N0qDzGwe+JLCxE7JfQ414zGAsgqBm+YG7L7BdV3Xvl1XbgvIGUbiTUc87lR79frYZB/MytUMWWmUAnytE1u1LaPpLzfoKQDp74gI0LmIO3AxhSdQY7CkbryKvISgu9w4xRmtJNSC2gnr7jphAZCBcW749HKm4uN+2Mf7lG4c3RZNHPTwmpOTWJA8gMcR9lgBwPs6053XMrFgWR7PUognaRT+OUUor3HDCCzvTMA9+u1GblMNb1qbjFKpP3rd60X5gl5HzDV5g5PGO9JJd00LgDoff3Wxb0VUE6fg9iceRFOivqR4K/JK96BqQLT6BTzUpK6T8SacdyjubdtkhEZNgTXfyGFfdA8AppnVJjayYRWEqQIjpOTBtmXZAOsIyzdpzFMYEgJiKffcGzPmqciTMT8MXKcmgYLzlLJMA0EeqiHPvkdukese3/9OEghgFoli+n7LETjPZ9aeTOXyo8jys7i8NAxqzHonH89ntiD/veZQyp0Pjeoc8u8F1BVsIR95hO5nkEg/KMso1tH6beuKJEa1yqxlE3BGcMoF2k8oWv311vYHfSpssoewVHtteHUuypktkxDL9kocIK2sO12+PSjxKCHITqMwoQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4fb964-4da0-45fe-8722-08dd65c08644
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 01:59:31.9645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5iCknTvziyqVuQZTMvmmKUQJbL9nnJv4t3vdVCk1TyA6WuRgpayywlSxdEg2PoNAUR+zmK6MiGFBqQ7Cm9qzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180013
X-Proofpoint-ORIG-GUID: B79onL_W6UEQE8yoWu0EZ6dceDoouH4c
X-Proofpoint-GUID: B79onL_W6UEQE8yoWu0EZ6dceDoouH4c

Use SLAB_NO_MERGE flag to prevent merging instead of providing an
empty constructor. Using an empty constructor in this manner is an abuse
of slab interface.

The SLAB_NO_MERGE flag should be used with caution, but in this case,
it is acceptable as the cache is intended solely for debugging purposes.

No functional changes intended.

Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/kasan/kasan_test_c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 59d673400085..3ea317837c2d 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1073,14 +1073,11 @@ static void kmem_cache_rcu_uaf(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
-static void empty_cache_ctor(void *object) { }
-
 static void kmem_cache_double_destroy(struct kunit *test)
 {
 	struct kmem_cache *cache;
 
-	/* Provide a constructor to prevent cache merging. */
-	cache = kmem_cache_create("test_cache", 200, 0, 0, empty_cache_ctor);
+	cache = kmem_cache_create("test_cache", 200, 0, SLAB_NO_MERGE, NULL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
 	kmem_cache_destroy(cache);
 	KUNIT_EXPECT_KASAN_FAIL(test, kmem_cache_destroy(cache));
-- 
2.43.0


