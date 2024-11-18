Return-Path: <linux-kernel+bounces-412352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DA59D07F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E451A281E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1FF32C8B;
	Mon, 18 Nov 2024 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n29y0ZG5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rmfPEK2w"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534942110E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731898197; cv=fail; b=uN7WySYCiE3fcj/7u9ew179r9Zyzvf28+KYzfA0Ms20uRjY0P4DfysMzLZZ6s3qezzz2mTouyfGLHrML/Df2toSWTzry9KlEbdQ0ErGDkggiUXwtDJho3WXnr+SFtgqLi2TIFl3I9BJtfC1re7WH55toK7KuDPNJnehZgZOiCjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731898197; c=relaxed/simple;
	bh=i52q0rcghY+au/uSD/7pi6/5PJG4neAOIwwVyrlNU+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CZ0fj/VmGsQaAAiuAK/H9y1CclUNiz3iQDx/lZLmrBxMXiJzYmzUDVt/geTBGsYKDf/wG/lDElXoXLq2QLf8nq7T7sl/ycP8mpr2t77M7/UgZFyyW3r5iytujUimhgjAw8zP2OpzAqBxRxKUfJY3cWPt8f2JRkEuoNyaxO6dwAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n29y0ZG5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rmfPEK2w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI1Bf2v029556;
	Mon, 18 Nov 2024 02:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=pU7dBVsNwO30epBKw5
	sHJZ6G4lnIm32BO0TcTVfMOW0=; b=n29y0ZG5Hi9ByZBFLVqge7AWXihn/kz/EQ
	Gc83zL8tLUGcV6uewWs77VQvtykypyx3luwFAWxcqCMoXzmFkC131wqq0IRGZXuB
	abk7RSzA56L/TIKuDzePO5zfdQX2wxE0jWmZapueXP6jXYNGCJVPikNSWS1YLxM4
	vAjeX53JPXslyAR0oe/3SWEpTflSVQyyARHE2PHIFEC5Jt7UkGP9V58TGiNo7zaJ
	wHXTMD/jzMObcKGH/9hXJ6vveNJk04XXFECuMG17kU98WMDXYUN7PYE3XjfCYsyN
	TRH49nENDuW/VD1NCzmLHkg2rXBeJLlSJp552HmbytCK5AasnoHg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc1tvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 02:49:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI2fg0k037093;
	Mon, 18 Nov 2024 02:49:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu6k23g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 02:49:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBEikbdKjDbc+GbtyzEdJBbmJvF0YwuDLOSez3BGQjLFmxI5uDzCeOT3rSrteUJ4s/CmufyWZR48M4JG6DyNqCnEX2scQPYBAmfdTnEfmKL8Jgqw/g960kbd1e/K+j7ZFyE7q1Ru8p14ToL7E8q5O3I0LHNnW+qtkgNtYBggYsx+MMQQfx9GQJyCL4k5vwJpL58LR8NWDAorjt9eXEMbfXY6VKihVYw2VGXx3HzBnwPEz7H9z4M+7cerGtVnZhQqGh2oM9aeXpXK1mYS8qh54OIBOb7KBDS8be4/FI8CQ6dcrgy0ZkaZ4N6kHVHRz3RSNJiagQYBn6sIHwl2N2Ewkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU7dBVsNwO30epBKw5sHJZ6G4lnIm32BO0TcTVfMOW0=;
 b=LaO0JTyoB5f7XREYFmiRdFVmfYGnsbFYvKPby02JxujoFHY/Ng6iEtDMFgoHOOxgO8oR1byVFU5QE+xcpfGAbzpyzG3BNi34csHlelt986In/qmOAi6tS/swZQHzDKf2W33Bb2Nf7zYvRwBZObimcp38aInTYwyYswuMoGYZ/hOFhJqvknSex81DQ32UQqgTO3pZ+Ac4DCAq9s372z2Eg2e57w6zPJWqhAac9OXZxe7tU/ouoSXrrakm0/wiWx9GvFFW00VXPXMRWsysuvSjrLrECJFvMROSsHYgSuh3P5DWHf0QDIeSVhh29gkCh0aeMpNI+EX6LzfBPnYrR05ARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU7dBVsNwO30epBKw5sHJZ6G4lnIm32BO0TcTVfMOW0=;
 b=rmfPEK2w2YO9rGD3sO1k+HWFlBP2W8p39fZjxd+KJPIwwuz1W4XfGa4Y19R/H3VPHErhwJAMk0SkMNgBBrsnB2MRLUI3/YEVZOlej1L0Iqgfewr2rL0bshSnOqX7zQ5Ta9u8jBRgbfmwY96PWbnYMV4w8awTtPPnlN4lv7ENrsk=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 02:49:41 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 02:49:41 +0000
Date: Sun, 17 Nov 2024 21:49:37 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in mas_store_prealloc
Message-ID: <ko2rebsgpuw3akuwnsghjsjokhh2m6jshbr2ahsipkyk3txylr@3xpad7pj23in>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <6739c892.050a0220.e1c64.0013.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6739c892.050a0220.e1c64.0013.GAE@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::19) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 12095b1c-d77c-49b0-cf67-08dd077ba670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QOC68zeYFIY3J5uqF3YqxIlYTg2CCaUaLEC29obzY6o0qTNUZaF41NVeRycz?=
 =?us-ascii?Q?/16H8mZubZL6VPG+u1yTYwoqvmI1p4mnDxSz/8lZUOcsp5CfQ8457a6N6vzQ?=
 =?us-ascii?Q?mFL1aamZGkyJB9PolHKgCsxccXM9WxhXh7XPc5WtiGLiG5GSvc/7JbzL5yeM?=
 =?us-ascii?Q?jHCYyWVJysD+BOUnAyd5ScF2TGlzVbp0dVL2nrtSWhzyGDw44mZjZm/eyShj?=
 =?us-ascii?Q?jdnry/ZxbQ9ubx8kmfhX/XMZEK7zPVrEgFXdzJHLBTEdekFf+auC0E7Nr/4t?=
 =?us-ascii?Q?gWyA1PDoM2ViSN/hqhm+rL+Hij6hnWnTLwohOuwjm7cQznCYaFaur671cSy7?=
 =?us-ascii?Q?v8b3Ttlk55yOIprNtWVcoHtBAXsjXy6jhLZzaxtid3RrtCh9xdgp/MM23mFy?=
 =?us-ascii?Q?OrBqlyYqc+e0VkfAtdeWdPeIbNx5kJdqOCdEycJGQ1VWXRFZfPVYU6MNaW5n?=
 =?us-ascii?Q?5Askw9/l/jAwikdHmD71U/B/+hkE2shBL/6lqjXrGelSTUF35dpXmEJY2Uk3?=
 =?us-ascii?Q?ZAHLLBEt4OPgg55H5NWV1j6H2w376sLGvYRKz5oTyMbKiw1ouWxmPxsox2lg?=
 =?us-ascii?Q?siU90XBmMOLBP/OkIvwwI94MyfyHPzhLnBL4NRagMbS0zFJfyGHDF5AHegAi?=
 =?us-ascii?Q?gNtuoVS9eZuVtMSKKaq6AVUP2ZYVctvO2ndJQwJyCmp7FhpiWk322q1UtsU4?=
 =?us-ascii?Q?F2QTbAhB5/NPA8XJqdC0BuZCxi5fLYFDrqqPy0hGp/fCTqXK2A3RtiJi+O4l?=
 =?us-ascii?Q?ZLOgq+SntDg4kheUG4mzwBnKphDYBeDQvLZXPR+HjSenXpQo7/M8MR/cezrW?=
 =?us-ascii?Q?KI1o3sN5s14K5azty15aL+G4qM02wrIcaFVAorBKS4eygRuVLbrrxtX91JFO?=
 =?us-ascii?Q?WNOlHzyETQLvoSq+nvQucaYGGhAzCfhkHwKPCPIWOrICloC4Pp3oVkq4BShH?=
 =?us-ascii?Q?ub71KgTDrqALLiieUhLZwGfhMw7RcZxAuzcPuJwdy8hZYu8Ix9TFw2TVQxSG?=
 =?us-ascii?Q?K1hN9H3Md/TtO+08FjKNKjUI0dJ7zpl2YITDQzLOiQ5arGLczZKzPIOr6mV5?=
 =?us-ascii?Q?UXmCdGr+gCiicoIps4jW01+R+E0ufZTzH6CyaTFc5ThhY7ozNlShMBRxY8Ss?=
 =?us-ascii?Q?LFVxQ7xHcyQbggHPzQN47zKn9vnpN4n5MDjosxx8RUVFcp8ZsJ7GBaCoHZkh?=
 =?us-ascii?Q?9IhAe6cM/gP+CT+C/8hXWexpuU2aGbLg4LalHOp/4kr8Ch/r//ag725KhAr3?=
 =?us-ascii?Q?ze1Dqseoz9TMsLSm9VUSCQ+dIXjCIeip2JENM9rvdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qspPuiGgzO6ptsr4Qins59j4DQOr/UVxVFSKe3U81odsK9Pz52JO54wlYsKo?=
 =?us-ascii?Q?5yEdfOFW3x97R0Kj1MnoS5V8yh8GWFomGzYPq2JeLMsCKkRuCbqy4HORoZ7W?=
 =?us-ascii?Q?Wg0lSj0YRE62vjj2kpYVrA3079Evu+Bmkizi9k32nud15lWYQ2yvqOrqYCMA?=
 =?us-ascii?Q?GyFLa/D1WJV3MGhVc9mIVFXm6pQ9ckAKg+RIa5T35p/0xQB+Tqiu5YY0qg8v?=
 =?us-ascii?Q?rmZ2GARL+u4nCkG/Nky8m6+w6pbrlTD5IDaxhPHeSag9vrj3JSap4oU5skK3?=
 =?us-ascii?Q?VAqNeux8n/62NYcSjLXdOjyB1QVjRb+85iSDPAc2ycehwCNgdo0Ngi/k3egl?=
 =?us-ascii?Q?tjKNv95foZ1OxQM5m+xQgDBEgedXEnEBk0vtrL1+wWP0xD/yLQ6WhPO5HMmb?=
 =?us-ascii?Q?MEwFgyobgHZ+kbiEm2mN66vK38ea4A+quzpm2p4Qz44UIV5m0bpSxPzgX819?=
 =?us-ascii?Q?SC4tMvO4K4RQGG/1N9qb10BOm+tIoBLamjliDuVbBqgSF6AwnsWN5J6quGGa?=
 =?us-ascii?Q?RHXJW5cDB0LVsYtVkv8g4SuAVxU5O3dSk1rVxKiYvKbxxVc13k4zI8g7mpJT?=
 =?us-ascii?Q?24m4PvWJwcohbP4rY0GpGUNB3kAFo3cc0i0jerR5pVrGcXDFcsqpwI9CF9W9?=
 =?us-ascii?Q?Gu324BvNbIS9v04DASOi/0zm4iaobdgONFPQbnVrjrrXHM1N/Nc0cRcrjnxz?=
 =?us-ascii?Q?fSEAQby40J/PbYLqjbN8+7v9roSkb2gAqRjG0wDrGBcd19kD8ptDjyJifu0D?=
 =?us-ascii?Q?hbTwq+xFmZLchFe0d//X4mVp7Wc4y4x9uJDzByMq8OL06xPW+NYfAnRP+4Mr?=
 =?us-ascii?Q?xYwpTEtuBVBRxNPJiNKhPUYULGkTq9AXxKS0gEhj7U0Obeqsl0sWAnL2QxEk?=
 =?us-ascii?Q?m8yI3FQIBpJYXOTlAZUeqF52DQjHWlIrEM9rDybhVLqsiOEQhphqEIOUjHVA?=
 =?us-ascii?Q?1dIejPEkueHnPNH8N61cMgYlTjA2KWtkU0g8Ma2biG3TSZxtMLFabR/7mY4c?=
 =?us-ascii?Q?ACd60EMYkjX/Ifa2s5ot2O0sYabwwlg3M1G+CSGAsOqzqQwkD4QeolpcGWyI?=
 =?us-ascii?Q?Ks96Kz5IV+t2NEvE8yA4AEkmEzt93tMX4/hKioOjXsliV21zvLXkv/eWCcAb?=
 =?us-ascii?Q?UyBsASbbRHo1omu4zftaCgjin0TafrYbnPozjBPSuJ3tdXf1pyCMoBl5a1GR?=
 =?us-ascii?Q?4eVjapLdTu6b6FquHO91U0V2rLTDBhVJFwgJ/5fRYdwoZRHBa98v1sL5Gg7u?=
 =?us-ascii?Q?CyoiIZ9YYUF031bl2mpNoUD6UXqeg2Z1OWeMuUCdas/851VNUChny1A7gWKV?=
 =?us-ascii?Q?7i173vy//L0yzvpVGHP/8NmhMbVPhPvpLWV9FGPN03PRDitF3JYcwziUgfhx?=
 =?us-ascii?Q?WhyaEedZAd2vgr9TjOxgmFUKyAMf1OhOY9VFTZTtfKMG03Om83xuMgdykl5n?=
 =?us-ascii?Q?Bbqym4wsPe//5qu+AkblJnBx3+wKAJbnXLVwtQrUEISHcwWei3XPK/i/PAyT?=
 =?us-ascii?Q?ib5m9L1qvbXevh9x74dRlWRYUlbalpljnnRrxgoUYZn1Bftbx/Cil1D1GrsO?=
 =?us-ascii?Q?v11/HAlZFocAZ+3ZbIyYDJAlTsE+bFtm4xU3Lvmm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sg7nnRx2KIzGCIVYLtSYUDa8tsxNvDHmXhr0g1dttD04Be18aWgdUWU3xjBB9pi3n9RL5Mim6ltjNYd6ru2e7p8E1wSSZSeEI4o4rh8mgtE5E+QJus5Rx76CCPZQh59LzeN7f1GTKB6M+Jycnvy4Cf0f8scRfJa5zgJj7ec4DLa3f52yjdUaDWxX2QQtD3wNGVygElRSyuWCkTOjV/nO3yJeVHHn/K6aBNZoan4gfIWniu051uFfvbXuQfM6XI1Sfg3CeCvm6oMn6XcKo4rkT8w/VvcMoFkbUwZsM1wHYDdb46G8YdQlw+JlAKS7SEMTNPaJZjSPw/ysT/BMaP0w1xWRU3is8mWZ8SS41+fcQ3JaFxxcgf6TRSReWq9Ldu08emp5oGWytTfKsxkOAGcFMlIIWeto3GBr+m6zwRUlu8iuK/1yvu6tBOZUHQlwZrtFYu7v3PS7nNn8EX2YDLxnk7w7v8/m+LRkj5fcNxoXW7lePeeKV3ZL7sdpvDYxy8YaSZDrzJ8v9dQOe9oOjKef869xqDVwfjJ5lZJMECC6Nmi1kk6bE8paGC7TDAuw7VwQtt2TnIPAYXmHX/vwWc4C77ov3hD8q5HFO+sb0Q3hs0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12095b1c-d77c-49b0-cf67-08dd077ba670
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 02:49:41.2913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8p0G3CzjFjwK8XNd4qjBJL++eDmOXxUvsLc8xQRscc+13bW/E6ioCN9jYzfsrz76X6MrayYffel3/dTETkMSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-17_24,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180023
X-Proofpoint-GUID: CNG6ag3KzO1FuJ7oppdihqVg0iAMp7aN
X-Proofpoint-ORIG-GUID: CNG6ag3KzO1FuJ7oppdihqVg0iAMp7aN

* syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com> [241117 05:42]:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8e9a54d7181b Merge remote-tracking branch 'iommu/arm/smmu'..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b0ace8580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a1eb85a42cb8ccec
> dashboard link: https://syzkaller.appspot.com/bug?extid=bc6bfc25a68b7a020ee1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=147521a7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102e14c0580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ad658fb4d0a2/disk-8e9a54d7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1b7754fa8c67/vmlinux-8e9a54d7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/50315382fefb/Image-8e9a54d7.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com

I was unable to get this reproducer to work on my own image, even using
the config and compiler specified in the report.  The injection was not
happening at the same location as the crash reports.

After using the provided disk (which was tricky), I was able to get it
to work.  Booting was painfully slow, and makes me wonder if there is a
better way for reproducing issues in the future.

I've been debating just abusing the bot to debug, but it will spam the
entire list, but I have it reproducing now.

Thanks,
Liam

