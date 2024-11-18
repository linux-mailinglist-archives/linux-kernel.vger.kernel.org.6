Return-Path: <linux-kernel+bounces-413329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D57759D1773
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7951F2284C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E792F1BD9F3;
	Mon, 18 Nov 2024 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XDnZWS15";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UBVOaF70"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CA13D279
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952475; cv=fail; b=fOyBHqb9rjCqhfbPCkMtLDXOs0fYEDNkSRR0RYczAKx4CZUqU3gXhdM+P4/6BNhwGxcAZojIx+QpqG55KwHpB+8jX3VkZtPobsGWIHvXcZkU3ghaJQ6/A5J/afrvgYamBylAdoO0iz3Qwzrp3Q8QcufAM6gnYzNVYOYn49GMF5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952475; c=relaxed/simple;
	bh=S4E9f3B9xipgVhKNm3VNMDnm81ts9QAqkFTrg/PJrGo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ofS2SO//IsrLYHmPw2jmzP1XqMywupU0szcZOGMA01FbEM1VC50xs3nJq0bBPYG8GaDMs6GE03rAQj1MgO0CXXJZ598GiRrxl1ahMENFOWxc/8dzyR67IwRKNFoS9skEKvXp95z7sbZDXL3Agr/JXdQ/EEKAu2wASpSea6wJ3zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XDnZWS15; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UBVOaF70; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGIbR0005608;
	Mon, 18 Nov 2024 17:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=vqgYd64DZsuBCFy+
	IndkEK2mOojSSklzK0uhrBw7eAo=; b=XDnZWS158s0ErI7Z6EKJwGGY1eMXxS+Y
	p8TJDXNkNuWLX5IBmvIrfKVGDeKWsKUCr4T/0mQN9fojLquNBodwDJfZqlNEhNkL
	imLynUUZicOG94Wv+eIkbAK6FypI0Ucbl66qPKQrXGMOGYRvy8HqvospUaFLBHil
	2a8q1DYWI4C6aMfVTVaYVK+DSgfabOmhGxbq2rLXPfcKAIsfZjtzZjbI4hOo9URE
	4liLlKUQn5/XXTFO3mKBNvNFHHGjLINTJ0Gq5kMRaKW5hFUEr94onYdIWg47FgQE
	SYIKY6jjuuCy13m8zEu2CAbPWsEPyJLdl2xA6wT8trdrlg+lLmba/Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ynyr1rue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 17:54:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGUCgg023653;
	Mon, 18 Nov 2024 17:54:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7s6wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 17:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbqBAMAb82/d3PYr2/wv6KIz5Ufj+Q2FNjOAH6ovgSaeUt9arb5Byr76uMLoIfT419FlMDgSovKGkBkPt24uJI0/cDCOJR1mtpCuOFjciCL6yf6iRa1kFB9V60Y5ttpNcXgG2HTfY3t2ox0iApjeIkolGOTCuVPhmd+1zF9f16M+lOK23wrQwcplaTEk9/vz1L5kd7XkNGygtLnjjsIBNUSAzhVARxWKxWck04WLz6ZBmCoUZG6HIdK9gD2iqfVsjNONjnNS5eERJuQCMyaKWZYGQIzzNvHatBGmyWp207/Hb2SqOpY7XSm8O4ZHJ2XIfXkgg5z6fAn9qsNk0btNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqgYd64DZsuBCFy+IndkEK2mOojSSklzK0uhrBw7eAo=;
 b=C9BlgIYaIAOVyjZmS8q8I7ACi20gQueg+0biV4HmUvMPS3GtI22G73m3zcWp8eMNdyf2UCHY/jH0z3GZP/erL/OBi6rsm3CR8g+OvGqzkrfOAqDvlV0XSW77kgGqet01THYXumvvIN8aO3L/dF5yaTB3TMzWipjRgEP6CiEcjrToMce3Veq1CvSuLdFu37LBH4xbDVJ9s1C7FRN5mWiGEaCeuWn+Ma1gAMqnYbqq+ji26MJUNGzQ3GG7Th8gR4iYC2vhQrtCLylqkDC+Ngp40tH01x4iWPwpbl/qMLZ+ub7Miu4el1EYtkFLm6PZJvyCRcZEx597yiX/uwBEIEteFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqgYd64DZsuBCFy+IndkEK2mOojSSklzK0uhrBw7eAo=;
 b=UBVOaF70wmaHJUWYKAutt25ZGIEGCqypruaB2PDGoPtOZt/5ZxNy3rnd0PRucQlAIIRE4oVFa6yDx9pxfYWJCGvekT/Ke4MuMKhVpME0hWcBvgVArUiDKu2/MYD+LL/UJDEiGvorBmritj54lzujvvmSqkV3JzkFtfMAIe0kQgM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 18 Nov
 2024 17:54:21 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 17:54:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: correct typo in MMAP_STATE() macro
Date: Mon, 18 Nov 2024 17:54:14 +0000
Message-ID: <20241118175414.390827-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0087.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: eb09aafb-286c-4851-8d07-08dd07fa07a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L8YC/ov01O6YfwZwFCNy76apBBoyngsj3v1F2WCpJsZb9byNyjUq+Bg542xu?=
 =?us-ascii?Q?FZxfsSms7IRvAp9E/813IWdmRBZxls+kg+2dP8rtSWYwCLLOmgz/J9NJq+8R?=
 =?us-ascii?Q?q2Y4zAtrlqzQfc9h/X2OdFDiqbiIduleR0sqoTQi/jOQhSv2GXP90EjWRFyO?=
 =?us-ascii?Q?F0AqPNQ8KEdy5KzeAk7w6nRl1RlqY3JC/r+E+t/xpNfOVFQHfSyCgoiy1kIR?=
 =?us-ascii?Q?dRg2YuRD/Qo724Y/MkvqifUJ4jm2C3NsVosOprco4w4KFLu1mtJhTGtO4uVr?=
 =?us-ascii?Q?sCuECYypaThPMLwTDG37NAAcG41OL7x8wzUH3SnUpAIWST3pyvMGw6vd1RWm?=
 =?us-ascii?Q?BKaqrtGA4fkAypckOFwFqpSqkYWR2lAi3IcelSjKvDx55UEED2etHsBCszfP?=
 =?us-ascii?Q?IYmUbEt9oHjrZt2u2VWS+H/SLiJ08pNTYgrcx0lJA3xQkwzk/W4CQ3Rvsbd/?=
 =?us-ascii?Q?iOg33OGnW927+plvW1CG8odza/JyAG6nPUGQ8r5UzSI0MQQB6zob6+S4wXFl?=
 =?us-ascii?Q?zG8PLvOBBoNm0PIyf1Wm43pzHvBwY2L92Ak0zvHLUlIC5h7yBARzpzplZ88d?=
 =?us-ascii?Q?Vl6Oy6+uoVId/YQlDlmgIoQ6PEjMeaHihmqeDzeymxmK/nco7PD+RmNprM3A?=
 =?us-ascii?Q?Wn+czjRD0DAITt8x7N+EYruGp9P679L6IB/IwfS5lN4hWn4oOJC8TSX2NEj0?=
 =?us-ascii?Q?Bzb9eAYpOM+Yp9Gna2b6F6mPYGS1Mo+d/uteUOY/lwgLNfZWumCQwdC3zIwg?=
 =?us-ascii?Q?CxbuyeZxR7F0TJMEFfESOZoWRblMIvRWlKc75mbc0JIoshU8QLP71zFQfqKp?=
 =?us-ascii?Q?wIPAJNHZQ9SA8S4Hn8TUERn+K5m0cEe95+3QrOZKDRujcwr0Eg1TXufmFy+B?=
 =?us-ascii?Q?mUzCLjFYVGWm3HJoCzilJMkMcl9nJfWfMPrlTvbBAXjIZX6yeV8cO0t8FLIi?=
 =?us-ascii?Q?Cj5dw0qWvURfoHcuEMNmKbxbDTA4wni68G7SMYHOmjQX9of+Hd08Cy+UgPaW?=
 =?us-ascii?Q?Vykrjyvz1axsTKka6hk9av0zek9fQ3RoAx8awqMvIYkGzPHwVeLTKykhBLEm?=
 =?us-ascii?Q?RifNfcaEgaPYXfe62OFc5H2xTN982fTPfCu+pA5KOvmq9KMRC2EYPOtYQEHQ?=
 =?us-ascii?Q?4nyXdEa4gLS2pURcV0f70mYzv8HvkREKEdUwG+O8hbaFIAP8lWVdCfL04kW+?=
 =?us-ascii?Q?TZlC2V0Cagrh7f74BAseYAXnZXwiKB4QvK9mCpexQZ02UiMGsD6Zi8x27e9N?=
 =?us-ascii?Q?SFKTCLrOHg7b2RwKzRTEbA5F8pyGJVW/gBH8rFozr8to/U6Ff5UBS5cU5w86?=
 =?us-ascii?Q?VrFDJKk2r2tJlyelrZhkdPGl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vzwtOStjZsOIxeq48mAZ2jwQ4u+RE/cAO+TdDDjkfTcEiq2vvjogZZ4svZ8t?=
 =?us-ascii?Q?SMpXM5JHn+uDI+rfLt5LqpgScUKrh5pbDLHL3rJqe0x7SqjT47qQjKwu+a2s?=
 =?us-ascii?Q?v43ruH0+VgLb+zfJ0ng6y8GVmDM4Dgo6Q52ZZl2bdMPH6LgwRmbskYmO0HXq?=
 =?us-ascii?Q?ArMMC+vsc3R4+eOlkkghjHPJDRncJQhjlW8SjKDyuy3xCogkD4ydmviDKRuT?=
 =?us-ascii?Q?abU/+p7lD/5erOTvkSTq5nE89IbabVdBXA8IKk5vU9KmR+s7h9gXE2nHEoLY?=
 =?us-ascii?Q?KYBRzyJHaA4UYF86hN0ksMKtzhGdhfzM4kKc9QPcGpURlk/aK95VujNcNeDw?=
 =?us-ascii?Q?ZvuXT/MH/SMxQNeiWtuyCDsyYr/euS69hjqnHKsxZgpPN0enixYhP/+hNDlD?=
 =?us-ascii?Q?V2PRc7phMjNahO0brTmNNdB5qJu1Yb1hlwYPJX56TrQubjCOSHNSujiB6GBs?=
 =?us-ascii?Q?j4/B3bb+zIqVDE/1GuxdIKpAO+9HsOFBWwCEn28eK1++5XiRfQpm82MC2qYj?=
 =?us-ascii?Q?/nI4Su6Ox5d7YJu6uPbk+lkVcdb/tSskfk47GlPpS0BkNukJe3rVlZxCgf5x?=
 =?us-ascii?Q?xiMIZf9p/y0lHGZFcHmcuLpnT01nkpE2MVoArDesq7j7PaKlAQPVYyPDOPZ9?=
 =?us-ascii?Q?hIJMZmODlGj0BJwpnNYoQqPHXdqcEWdJv22BUqwZyBz9t4sLL/opQhiX8jSx?=
 =?us-ascii?Q?1VuybUj3xpVRjEUPrm18jGJ5fPWBZejvojOMsR+ZR/NaVWXYes8NoaR18H3B?=
 =?us-ascii?Q?xgGyyoA7QYDQw/QwxaiyY9YczFskUBab83dWB/TLeUppLAdBxdFjKUel4ZJr?=
 =?us-ascii?Q?KW54Xg0FXgd7wwLuX3ciwj/MDLLNnuqBeAnxbxZ9G6HHocbbccRGx1rP8UO0?=
 =?us-ascii?Q?MCNmh47fAUI58FdKBpuQG7X6ahJ5wKE5DCKq+qvUab1FA12ifZBHhqQfOUPJ?=
 =?us-ascii?Q?zhGIbBPikjKsjeNO9jGOYMhbYJVUxnka4JrjOW3HEBdUuhM0YfTJ0k6gEcpT?=
 =?us-ascii?Q?Dlz5cmhC8TZ7w/N0qO0ZPtIvSjvPY/gc7j4Q5LeEF6a0FeewxbzdWw4owbis?=
 =?us-ascii?Q?9zQIyy3DipFjicztvW7Jr+Ie/36qFfhMGSpc4go7zs/LJwJ1NRNrB4IFfttk?=
 =?us-ascii?Q?1EahyYK55QEruPVEitjmYjAk/zDnNgv5TKl30bMBm7/ng7IFTqpaeSjXw+kL?=
 =?us-ascii?Q?Z3chbsVjAtJAVR857Y4tpyyQpTRsKNHJ+RWSdrzT9/QT60H1eUronnxi5uLr?=
 =?us-ascii?Q?8R+9wiw6gQ5StvS97MpMMSnni20YLJtziQHd5xnWm2Wb9SixYeZiFk6Qtf90?=
 =?us-ascii?Q?IKm2Xh9YuSBy0hu7Jj4fUXGCh4qzEcCeblZx0IUOdCBcv/UGHhETsrtxYKM/?=
 =?us-ascii?Q?S26BjwXliOg0E8F6eshLn5oG2Jv0Lo1hA/Oa96fQSh4anXTTN6W/1NLs+ZRl?=
 =?us-ascii?Q?BYKOuKN3YQirhOG/oMR5F2QkGUrptRshQyP8VHlylb9s55gXqqQx8kKBhUZs?=
 =?us-ascii?Q?FYKT2ygeOHEQi3FXSa+bngkf23SR87Nstj8GrJLFrO4sZz2eAHvYPQOo3ndY?=
 =?us-ascii?Q?ejmO2ENizF3ev52F7aiHpDDX4BA15ImjkHrRWdUkro5R1GwGQfNYhtPgYuVX?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yFj46LRzHH+qWufQ4UZmIY/uKY74Z0pj63SHCRXOY515Frmqe5ZXsNtn5x3NDaNqKir04O9j9T337udS1L67uf2lpfljmV98UK3oANMUQbLeenSRV+RKLw19264SVAoOlOM7xS9qkFV3KOrE2/1sl1UYt1OJBZHg9zwKzrFfLMtbINwrqkO0QxUDqQQAT1eGgLlXreE4zV+p0PzMaYvmqoBmNWlJKzVJ7vCqNajhu0QboyTWk5K8YLv5KteXswZ29ScHkMrEVLRerQBgx49tl/obzeaJ99Ihl8dVAbQFzINUcYXh+JchrI7DdnKc7uPbU5oq1vE2/eVt9Dl71gofTFk56VuZFAcOx/4cVU1z95Lt3pHRHO00ufP77x2P4MYkL1ubaoMoEudTaXBsqBWms4mqSnlu49wDwL9P/ewDO7hpwIH7X3uZwQf4e9B3ApkuJWg8ZXsTKcFGJaMnPlxxlnQAEae7oPYYwoCir7JG/9XqrINQ8S3+a15qHjKVw6KWatVodNcv2WhecuumX/TmneVXcnvE65/7+h2nPmPwnmwxiAlB5szS/MoPCi3TTY4E/8Yu+ozSb0zK4JSZace+boQSAjTrvZD65TYgKV0ngMk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb09aafb-286c-4851-8d07-08dd07fa07a4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 17:54:20.8839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvJ0hptVZ9nKQI6qxW6REQKe1QSB+51BVaK8ZVdlp2qgScNx/dS2/zw1gMXjV/R4grI1jGEFROSP5dbCgnX+QwSLPhUsUGA+EXD5/i5JL+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_14,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180148
X-Proofpoint-ORIG-GUID: 884N_dxuP-GxZFr0CuV79prWQGSooAMb
X-Proofpoint-GUID: 884N_dxuP-GxZFr0CuV79prWQGSooAMb

We mistakenly refer to len rather than len_ here. The only existing caller
passes len to the len_ parameter so this has no impact on the code, but it
is obviously incorrect to do this, so fix it.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 8a454a7bbc80..8e31b7e25aeb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -35,7 +35,7 @@ struct mmap_state {
 		.mm = mm_,						\
 		.vmi = vmi_,						\
 		.addr = addr_,						\
-		.end = (addr_) + len,					\
+		.end = (addr_) + (len_),				\
 		.pgoff = pgoff_,					\
 		.pglen = PHYS_PFN(len_),				\
 		.flags = flags_,					\
-- 
2.47.0


