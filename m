Return-Path: <linux-kernel+bounces-435699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE94E9E7B30
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A095A18877ED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48C21C5495;
	Fri,  6 Dec 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MSXR6UMo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TtVxae9F"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA422C6C3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733521977; cv=fail; b=nQhaZyygYnV80dfizlfKcHl7kP38KEtrWgXcAnxP9R9srfVFiDqRcGCLqL6dSQNx1Xv9u4FXBNUqraI++E6VMbM9ARXCwqBuqirF2vKn7D5jM+Bf2noBnLRE8eGJnI2VwsWgbdjNfCE6O4LD3y1YJ1qsUgY/MLKHkJ7q7wqv8L0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733521977; c=relaxed/simple;
	bh=NUcpkcrkvmApGs7VPSa1OZc/Lsy9kR5KtK8gJt52bAw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ROG+P0DieGTEXbCORCgR4UDErn1GLd4NkpKINPufjcJoJKN30Sip93FeQzwcKjOlXbfhBRMAzf0O1FUpxbSMJ6SEIEsuOYqL7AsH8BlsFRSQnpIjqG8C6Ov3dkM4HZOZo9NSeH6hlbWkPwP7OC0ON4WuIsRvNd7VDxmPPWCxLXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MSXR6UMo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TtVxae9F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6LWwFJ024357;
	Fri, 6 Dec 2024 21:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=pvzXqFBbGb7wKFzm
	RFxaoHNzxmbZ6iFpyIM32DJXQV4=; b=MSXR6UMo/RGbm73YpY4pjhLnsgENXvZ3
	N5OR9ac0XR/gctIL7ivHj544jla5nGGPllM4yR2/caC3ZKHKTPg/T45d8xYiMH5v
	06ruAEtvJs8nuRJMKdJCgX5N2HrrTkQpYptO49GSBlQC1YoNhwle2e6DCKoNnl9M
	A7R+2VU2se7o3E0B54u2FCxzKciVmiiCa/QaIyaKIcUOVkvjVdrm9LUwKB6uMA0A
	+VwOpFdAoB68EkBUUKniTh4G9zhHj4JrEUlNKm15Bva1RLJd3N+/ks+IsVfXCwSD
	sT5p1/EpayEKovSNGTy1CpBLXG5sCI22tsNtE3eLokxTp7o+fY5I9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tase7mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 21:52:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6K4d1n020348;
	Fri, 6 Dec 2024 21:52:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 437s5ct9dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 21:52:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hT/0xQkufYIoc8BdA6UrI3MhfkFbgRaEelEJi0uijjQGCAbfu7oXr5fJMo0Q1RQR4SYOTRraLVwMWv8v5tIs4FXRgOfiDrxq+0xUfgSPoYjv8AlSw9Po7moNY7s3/y3PNnzNMHrYpYGVTYDDXWleuzWozuZTnkzZ74ElrgFSgNC7TSaPo0zPeIBPkGskWv+zFjRN0q435R3vVS2VcPtJ6F/qxlkUpQ59xtGgwwRy03tHcLTHG7YH9vhZifotReOBYShMLoxxCB7Qj7z56fCeVOnG0KPWOCIkKF+EN9ebxj2aeIxiHcNTS7z0pQW0F+PeI/UYNHKHRn5EsRQM65NQSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvzXqFBbGb7wKFzmRFxaoHNzxmbZ6iFpyIM32DJXQV4=;
 b=Eh29uTOYIh4Bhx9hbuq1ZW8qzOfNAnLzN7oD4MJe0Tt0WIjwm97jRLCo5AIdtI1kjdqH4tK8wpPbYg0eMYEFhpSjwdq3BOnqFRdCnvnkCdV1F+vSm70Pr9+tuukqAy6DEmxJyApPFLBIHAWyafK7boBdO91XrjHZ1FlYowtAf1O/z1yhtvUsPAKpZlC+7hzh+KWD6CHq7R2Ia/IH8A5EJobG3Dmr/Lv9/v8JuhNQ4QliFokL/NK/yxoFAg2ECMMqfSYhejZfi7ex+vx72hh/pw4FkXBKDzy7EHL3AmjI+pxrZqg9y3/CWcHOr0Jo2WchndU8Xb1D1EAmK3tdosG1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvzXqFBbGb7wKFzmRFxaoHNzxmbZ6iFpyIM32DJXQV4=;
 b=TtVxae9FR2vUSjJ5KcMPN80CGfrZNOA3FzB8zBlmARkWaOZiKKoAeqpuvAlZy+ozQUarF9jFF9yo0Ggd6IN2/+gaibOq5y0xCQk4Lq73xGMsrtxZkajubcZXRq41nka20Rp7lEXxqxYpxA/x4oviA341v/WokcWRsBx4StO2W6Y=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN4PR10MB5560.namprd10.prod.outlook.com (2603:10b6:806:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 21:52:44 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 21:52:44 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: correctly reference merged VMA
Date: Fri,  6 Dec 2024 21:52:29 +0000
Message-ID: <20241206215229.244413-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0243.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN4PR10MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 8799faa9-2520-4110-30e4-08dd1640508a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/yGLB4pYw67piFx6uk8AxO8f9qsl/UHcbTcKaz7wIEPwwHX+UrEaQKhvcScN?=
 =?us-ascii?Q?oZeSqXKfsCiwTH0+Zb5x3rBo9H/88b7naEdU/48kRPVJh1TM6PDEIbTSWJKX?=
 =?us-ascii?Q?EWeMyg8PEbgTUNnijvwrTLpUE+5fF72jHBH/hW1vs7rNpYQghtHLMkpNJCuk?=
 =?us-ascii?Q?gSIWeOSTE19Wx2SIA4a1xk7+x8ZAPKTpVgx6wygDYT6tDz4V8dT4b7b6szD6?=
 =?us-ascii?Q?3f9XA+tMZX9vFZOxSqhRU3wB0ZLH/J+iFvBcXOXi7BHiDhMGwPN9bN+qtCN3?=
 =?us-ascii?Q?JjeyqRzype5blX7XYdRSwY12sZ2DUXpEX+89bcv9YknWApEjOsM0kZsd67BU?=
 =?us-ascii?Q?3bjPyucYc7qt3zvQwXWUBSicC2gkJFycLtNMnOeLSErNQe2k5sU2wIAGe8KL?=
 =?us-ascii?Q?s8J2a3SEfxp7unemZFXgmSJ7yJHx54D8BRcMbD1z1zJtmkBFB36txJ23NWBM?=
 =?us-ascii?Q?+y52Qer2V/LwoJszU4gONsqoDwHl0dTbs9vhk4EprsBTuZ4DnJsm+vJTD3Id?=
 =?us-ascii?Q?Gbw2f347839q3GxzHLsOY8Gr61vi/ytPUcXDmD4Miljl0LaZeob6qyZUtflX?=
 =?us-ascii?Q?QwTXBxkDIYt0EiSBVrTFGfbwA1aNrhdFbDTtj0QZ0q1OWkkFPYb+FqdAoNFs?=
 =?us-ascii?Q?WCMJ8vDek8JbK8xfdS6YtK4sA7jkfzP5dct+mDNFkA/OQDMv/mzJGuVpdXdy?=
 =?us-ascii?Q?i4WaZhT7Q+TDoGR58ZKOVwArHlKd312iVcWhKlymNw6/NrIDRW9FXxlG9Jb9?=
 =?us-ascii?Q?a8BdXq0XhKBBY8MZnnPVtdaCNxVZYO5QHgqrqWHexeNzFqTltiY6qCZ5JUyH?=
 =?us-ascii?Q?KAdLXsFpPJ06ifTOyOPSMnzOK5IE8pfIPMNa6zIQLGmD6kXul/BMc2CROLMZ?=
 =?us-ascii?Q?BHZxX1sHVvExvW1Y9iZqYNbL5Y25e1GlGFJZLQlNMEcv+ZinVXwwayK9LLeD?=
 =?us-ascii?Q?ST1cxpR+IGiWEipdzQGf2QRLw9Sqq2GFHpz1RmrT3QBvO9iC9UYvmn+Wzb06?=
 =?us-ascii?Q?5oQFCVFPIBw//o8PfNcLXHwXLbSfRBSiNQNna8+Uyz3WFCWbn903JxTNH7de?=
 =?us-ascii?Q?tG8BG4IzeHDgGIPZ7F/f+dpWWbebmnSBQhWB46xfQEvIgB3Quo1R1PXdqsw9?=
 =?us-ascii?Q?sGJqzB9xYEFbEF5RljRjwsxW8UKWbf87nln5rV0XvW4qvLFpnneMvw8DU2VQ?=
 =?us-ascii?Q?v0ETJTR3Ple63j7pVPFGzIWuM3sl4f2eBYRORWSojpNnCv0dVgZ6IZeVnXW6?=
 =?us-ascii?Q?24N5iQ+orHgDE4P9mCzi6yxb6UUd69QqPzAlrvXEptJ1KzZ2/DhNEL2l08mC?=
 =?us-ascii?Q?9sB9JO16JykviwB4kMBWpYZflsiCvzfUqlHkRx7guTWOUDgoar7XK253LSom?=
 =?us-ascii?Q?az++3vI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s6ITSYeOHyoMFFsRISV511lxYBtH7CmJtingMx1jUteeiKJOMNn0ptr+FPYV?=
 =?us-ascii?Q?eRbQLa3MvKpvK29p8RHggL4T95o+/iGpOXf4RD81125OqeSC3zKOTGZmF/0Z?=
 =?us-ascii?Q?IxkTjkFipUABBrN9v7GXybqXDOqSp4Jlin5uJCgELFigBLzO5yougOA4hTws?=
 =?us-ascii?Q?eLRpy8remDDgc1qWY8gjg/OwjLD2MbGhp9NSkzTk6kGdSU09R252eTvlZZz2?=
 =?us-ascii?Q?pI6vskRbzOYqOVQgdHq6vRY5CcWV4kRaAi6gkhM4Ih24Pt0ivOK42I/bJuIA?=
 =?us-ascii?Q?LJTTPB4khggO+XgLyYldMyA4WBLJOrXaZan0diiMb0IIKpUnvZoEgfo0NveT?=
 =?us-ascii?Q?lpWPdXnmlvAIDTA86dF3z7bcvYrKm+bKMGIsnbSP+jqBTod1BUsYL56XgRS+?=
 =?us-ascii?Q?Ig0W7A7Z3ludhFAljZB4wK99OW1WLC0N/mhkALOY+pzO3KTrbb0PjyORIIBp?=
 =?us-ascii?Q?hEDhSeRr2kE3JJ7vMCw1vg7aPWdvXTyDWd3EzyP9sLmH/fbfR8tjBlMwnA1m?=
 =?us-ascii?Q?W3+0KGYy5JNbhCE5wn7TT7VK8TOAb/fNHw3Cc4g/4B13FQsgzbThh2v2qrW1?=
 =?us-ascii?Q?oXYiw9PWb15I3NuXtUH4YyJtDDNiyeAaW6w8m1F6LUeujuAPwN1uEr+15GVF?=
 =?us-ascii?Q?CnSOf4amuSApCMzgoOjvECX8vapGczx6mr4Z9UTwQLkIx7KAryDehb19cpP5?=
 =?us-ascii?Q?2RXEHKYjU0kWPYUjwVNfvupEJYG+qhuXm0hjfy/jJqeflUnm+6Y9mClP2/dd?=
 =?us-ascii?Q?bl+ahpG6Pyo1tArK59g5d0jVtEtAYpNWoKMwkg/9ksBj9Iuq0iMcVSZ5Lbe4?=
 =?us-ascii?Q?bN/HBSPzOx2Ml6qfyfOi9uG20DRv+dbjpy57xtA0aL3r/hKbOv5FG8NBOrWB?=
 =?us-ascii?Q?gmfHi7Zeiow5j0lF8Gru4O8xg7mM7W0fz3q0eXPewI/kKHj1byfnbHEdIDK3?=
 =?us-ascii?Q?9OV3Sylu4W88bnzCqw4B129SULOO7ur/o8sGNrc+B3tdU1n0yG2CwOvnmIu1?=
 =?us-ascii?Q?LUMilCji+YhHNKya/Kz+He3EBDsPs8e8tcL8UyiqLPSuU0hyBFmMTXqbW2uo?=
 =?us-ascii?Q?7qqav/6DO8tX4VLDHwOHVEROsGTMDTyOcjlJYXyuAxhd81a1ozkSApB5Q1kF?=
 =?us-ascii?Q?KXP2G+06TDpGeqVPMhuFecfKP3aqB4uKErdJKeQ3RZ0VQSMfHFiIOUT9QUdY?=
 =?us-ascii?Q?RwDTce7ojwgL90wuivVsLyOQHS55Ra+vuWyFQQNncJveZxd0tWTOGdajrxZF?=
 =?us-ascii?Q?Nvs3uxifUBityyiei+mEXT95/qAuORKOTD5jV3NLcU8UVE47vWjXm6FCk/yv?=
 =?us-ascii?Q?aNFZT0fTlPR7AWOw12ozkPUlHcaCH8/4GfJdieomyPo++xxEV6nIhGsuOnKm?=
 =?us-ascii?Q?YNnixfTT5EdBNGkLgZIOMwV08RxLGquX1k/g/GqSicLL8ToxFTYWY2iawzOg?=
 =?us-ascii?Q?ogRzTK7Bxmmg20Ebzvs7V+tJoUufYAP6HT9UNCF5cp/1hAGKGWfcmLcrKGps?=
 =?us-ascii?Q?sGpRR3k1f5jnILEai0Z82TTML4jvRnQCozaDP4AUUXxuWGWDgSnHINuiguBV?=
 =?us-ascii?Q?eDRhrLNRBg1b9+TxLrG1/d3ywdYB77O+aWxu9fei65U91PWvK8BwfemAANhL?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	27T7MclEoouzJRtW3FMYNACoq9MiGx6qsIC0qBfqBZlVuH1R1WVTNrz1jOk3H9cze0BLu3D/FkduJKDJ+4gVaPVPbQZQiIqCN/Pa2ZCmuzT0z9cgCo5FzSKn44oNsFY42qaaI3BY+CJo8k5y4K0aWCFJbFpL7Cdsp4ArKBplkslsfM+nkK+GWPDaIv0oexpPLgFePQ2Amn2YBHyyL96xMPmQRdWLwnKojHX+qvCUc2XxtYKaJjcvr82Kbz6lsxbcERFQtcI4dCMcf2oDEBCCCHxkb6A+o+e5cewDlNxhXb2OTi8AfzkDun1BQwzwoGARdcyVlYQHawvqNmoAZKGMowUnFyYcDxAjZBKH26C8ttEzDv24ZS0fSw5+8U4VCBTt6jaUwOr4a2uMleI0J8uGwOF+j7+aCPsXr0EIGN19hqs/rNPtn6xDeiwaFeW95qNWIXnw/7wvVWI44UQq7oUwbr+b6FlJsPoINQXMl1LHe1Rzlx+fYKZLmgEGAy8WOhBsFsDyG/YXAEwr3dWjktvN1SuCIRQRJSKAPeeocwDM46kCIyv/7YuqxFzP7U05mDStc/NjptNmiPe0kaX4GRImUVWVSkMotncK+YY9VfmBMKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8799faa9-2520-4110-30e4-08dd1640508a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 21:52:44.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSvDk6AGQTx83DClMvwFVBO2hDSF+PFa6gdLKBCeyR6ND34nCI4N87sdtRNbGlNpPH9gpXGlNlx35yiUSUYmngi2woOiMZEf49V9E1JujXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_15,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=995
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412060165
X-Proofpoint-GUID: tG96woTRu-cpCJzPn6ZYYe6Efskyj281
X-Proofpoint-ORIG-GUID: tG96woTRu-cpCJzPn6ZYYe6Efskyj281

On second merge attempt on mmap() we incorrectly discard the possibly
merged VMA, resulting in a possible use-after-free (and most certainly a
reference to the wrong VMA) in this instance in the subsequent
__mmap_complete() invocation.

Correct this mistake by reassigning vma correctly if a merge succeeds in
this case.

Suggested-by: Jann Horn <jannh@google.com>
Reported-by: syzbot+91cf8da9401355f946c3@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67536a25.050a0220.a30f1.0149.GAE@google.com/
Fixes: 5ac87a885aec ("mm: defer second attempt at merge on mmap()")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 8a454a7bbc80..1ec349141f5e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2460,10 +2460,13 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,

 	/* If flags changed, we might be able to merge, so try again. */
 	if (map.retry_merge) {
+		struct vm_area_struct *merged;
 		VMG_MMAP_STATE(vmg, &map, vma);

 		vma_iter_config(map.vmi, map.addr, map.end);
-		vma_merge_existing_range(&vmg);
+		merged = vma_merge_existing_range(&vmg);
+		if (merged)
+			vma = merged;
 	}

 	__mmap_complete(&map, vma);
--
2.47.1

