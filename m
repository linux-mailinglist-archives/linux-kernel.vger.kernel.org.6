Return-Path: <linux-kernel+bounces-376939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A199AB7D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112A01C220D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8831CDFBF;
	Tue, 22 Oct 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SkM/NLbI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c4qV4smk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651D1CDA27
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729629705; cv=fail; b=Wg4GYbSGowXk/aZCUOnN0j+6ozLiV/4NrYWri0oqM1T14X8i+o22EKREbmTtzjDZiszr9boDzuKmoEFZEFt59g5dQElMMRigziCibnk/NFNbQ7QIM4sOtY9Rw8iHFa8nPZ/rTZhdDjKcPseujvO/EvqmKhqBqYRjxVF1Mcr2BR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729629705; c=relaxed/simple;
	bh=u2xeLpH8MJekB5QclwF9w+6Ou4rLxnbFl2vKYOhoKR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j6Up4yKLO08znjUF6LGJoXubHO3cxq+9E1K1rwSW1Ek+c1u1LWc3fq+2LBb+wZ4CwNMy4Q0HKv1n0GWAnZqcTqVmPwwUEJuU4reINqh/IY2vioYYm5j9vBWvWu8G21mG0+9z8I9WEzfIwv1mSaDWcb0gmWGZcQktWqh8NeTcx7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SkM/NLbI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c4qV4smk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MK3Xbs017462;
	Tue, 22 Oct 2024 20:41:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BXayzKW+JRbaXCboa+yyboq8km8gURUeWkwUdDs/fdk=; b=
	SkM/NLbIKZvJZytfp8LZxqN7GLkP/FhhOq5fAB87fothJ2oYfI5PeG+fUySpOcn+
	thOQD4snAlfIgqie7O4qw5xPTF8LBsFMD6SeFznxRc1MVmfxDS71cqN29dBH/Pxj
	60Z0AGRD4xheX94Pa+PJev+JNd1Fad9EXEhixB0sEQL6aN5EGVg2CUttGlI9XFGZ
	d1Z8iOO8NwDLfRAwUgLEGzF5ThbU6gLzD0pbkAIRFEhZK3PRRH6I1kaeyfzA9Zu9
	p8HCC+GCPlWDYPcOHiXQRqiA++ZYXmtxeuCwbPIMZar1LY24BT0RHo3GqbypjZwn
	9SfUjcLZj3fZsrNz5HUxwg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqwy2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKSeQk026202;
	Tue, 22 Oct 2024 20:41:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c3786y7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 20:41:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY6QxKPXFX8E+lrcmGp3tDK23TrNE/otmDQOKyLY552yvz9teqtWdUvbcdwVDNHKk/dvkYo2qhoxXOSk9QCLK6/UnYRG9RIiB8Kv+JGBNWbo4F7OsVhzUlsDAKUf4DOKKFsnX3+VSGcaLAYG1gYQdxWV6Y7TptKmHhgo/BUcIyqsaKXYoBgwQATGR8IuWBlTVK6w2gXTYWSw+n8SfjDQ4sSmYKv2EZCzyW2uP/jWyekrlcxm/PX7egWeikzV/zE3PAFcf1zKi0dDt61lzHteXBGaAZ64pvngBy4YoE0YWmrQI3LoYAClzcuZFxh2fUlZ8jihy4JtU4jXwGxuHHsQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXayzKW+JRbaXCboa+yyboq8km8gURUeWkwUdDs/fdk=;
 b=a+BcHNbMHHUL6mXiWIs1Srm/FdA+7FWvdjElPdxuNHA3TziSjzKrN3Fa4cfbtyKv2jCuL3bJLn+GEdvZmAnd8pzqvIGXfEEL/FPzhaw0NZORGqQyOS3+woa2CI2MePli16ifHCiXZs5k7TBfb02D/rakq+8KDnung1xWoIkPvW+mKA4iLzaVBKZ0EP4L96avAojJG4e1FOkuaipOGqZyKp9OSnYJoTFXryzOn/uQwT54tebmuk/IOAtQcgjpacUKblIyPVbmkk7+Z+J6g07YjswW7V/0nwtV97eAX8ixDVghdKaaGnFl9a2zbrsnQzs0P8ulgJu243XJ1mFoHspUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXayzKW+JRbaXCboa+yyboq8km8gURUeWkwUdDs/fdk=;
 b=c4qV4smkZY5UjJ1Dq6ke3R+GTmzDxI2g9LVdCNqmCATFiodiyP1kRb+dlcKdv8CJZPZ/BfIKYq66bjDTIkOkGdBvN20rPfUlFjevOy9kAvlTriHNSlDD6apPkvJoXPOW9VfqrTteAYM0Dn3ZRpcXWtPwLFe2s9oR+2Unz2hfMN0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB7437.namprd10.prod.outlook.com (2603:10b6:610:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 20:41:30 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:41:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 7/8] mm: refactor __mmap_region()
Date: Tue, 22 Oct 2024 21:40:58 +0100
Message-ID: <125b6ebddc7ae8790b8b10b47906c2d39e68f3d9.1729628198.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB7437:EE_
X-MS-Office365-Filtering-Correlation-Id: 7094f31e-58b4-4183-2383-08dcf2d9e890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?obceIAltgyCD31yP6ZP/386kh/meg4pu082wVpMLK4a+nvzWl2jwZIo1OT4h?=
 =?us-ascii?Q?oPGLbA5jntQfX3IXhAUa8ujKvWDY6O4WmvzSXspoILLXguAeheKx3U9HgimM?=
 =?us-ascii?Q?N2OK1PcsSpaGVOjIix/gL2f5ML/A6Poi/LqNre6lzpbnowEdq89l99R6lvl9?=
 =?us-ascii?Q?0l4mu4JQ9lfk1k/pd5ba6MJ1mYKi/6C1zeA3mwcvsxcvx1ylTwoERY4Ciqez?=
 =?us-ascii?Q?XBuyV4IrWYOqgr2uVikHeRpN2ryCslmxK7jpufgIcNVHCAr/p8XE8840eTej?=
 =?us-ascii?Q?l/sHIU+lI5pcn8CBhz8YsZlXV8NO/35U6raV1/eP4LD2HfgE4mn4tZw/Pe0i?=
 =?us-ascii?Q?B1jykqqlAgS/gTUhNaGzZ5kjRSNmVzlhjWvZQMEPdGUe6Lx1agekykgf0nfU?=
 =?us-ascii?Q?yRGUw2ahRbTI75BZak8U98OK/jAUeYOD3TxKF05MTeP++Ji70WHHWqQsu217?=
 =?us-ascii?Q?kejwidQCEirwqRUs4okbHM5UUjhMhvueoRN+IcABwKJMHp2pKD7/8L+vapzn?=
 =?us-ascii?Q?mcKe6pNqUJGH309iEJKBD6exu53wAK3yBoYptvrXFo/gEhHlS/1pJhIEAl4h?=
 =?us-ascii?Q?Eb+kGC/8Z5HFE5C+Z9/+e7E5UD70OfU+lqdT1C6o5jASusErAfCENKyKTIOd?=
 =?us-ascii?Q?Lp4z120EE+7SWCC7DCTPlmr23L3rTz7fHvMe8FCDq8IIR0p+qPLORuKtsSCP?=
 =?us-ascii?Q?TnSIPiHMGsLrWKculmUetTt4Rkw2+U/dX/JI+PrUdSQdfFQ/Y9cutCo5wg0u?=
 =?us-ascii?Q?s1mS9/L0yp7zy+uv36g/6JXJn3AP8dbNG2smFw5R5FQcdE30DGr8FK5XOFlc?=
 =?us-ascii?Q?SbbbEhKJi6ruTbHZhOkKBk3xzLQx+gXPkUV9v/aSxsV4lehcy808cRsGhk7T?=
 =?us-ascii?Q?7fSzSFnXKznVrCUh6TFIslUM6gf0/K93iukxQfYL4H6Js4YqqtMYNETEzuHS?=
 =?us-ascii?Q?K12eKjAm3qDQV08K6KRMgM0WP0e4s9O8tlbSX1fnG8e4CzbyZnWLmUBcuw/Q?=
 =?us-ascii?Q?Jhw/y3zR6WP3vhwgVzJjbp60EEKFCPlXqeCEDsFzEQnIWdw+o6qzGmh1eHsp?=
 =?us-ascii?Q?UbN4tPhYckRvk73Ot9OTm2YpPvMB4x5F07oOV67hrHoo8ECZmmNwM+0eZs38?=
 =?us-ascii?Q?PTHAsP+ZwjYjPlBZcFq/1orQx0wiCvH7s5dTIVcPwb9FzM2oKG/vaH84knD6?=
 =?us-ascii?Q?vGyqmMmG5yzDVgRSeq4HLtLjdhIVNBdELEj47p+isxhpOn/QBRqDzY5TQXBu?=
 =?us-ascii?Q?F/GY7POcXPaTRwJy4JpT6H5T/FsLa0enz835I1yssIuD/W6+TehSA2fpB1o+?=
 =?us-ascii?Q?8hG1gS6ubh74tDp6ez4+8Awm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GHxcu/iUi/weqrkN44zOKWZcQJHOVKLFhAFChx597TwgqMq4Qh3Fb6nB02aU?=
 =?us-ascii?Q?pxedbbcfSbXHBb6Kr/yYLxN0kvMmRGuGxdSvt3V2AN+loWTorVlksQLsV8l6?=
 =?us-ascii?Q?+aGYYCRqYt/Za7VRYmEnq+yG8XCt9jhuaJKv9UItMzZodRS3b4ovmUtJQebc?=
 =?us-ascii?Q?TtkKkbaREFc72E/HTjPRB8kUM45M9UghRAIwCSLlBTUv7aodEW6yMLNnvfWf?=
 =?us-ascii?Q?PCoqFACQuFHeq/shN+qFUspskTyb16veeAq3ihJkkqMNEoMeDIywEIR5Khvr?=
 =?us-ascii?Q?z4el9/fuYjoEyplrtn3fct+ONzg36145GIclvGdgVp/3WZ0H+9452Xhr/oVB?=
 =?us-ascii?Q?KrWwTvoJ2BhwnmzY29VdBxrcSM0Wbs3NxScax6TjtIN75QLR+pDzTdeHkCVL?=
 =?us-ascii?Q?s1U6M20CitXrYB0EILc/R8jMlGrx2OxmGUJiMsprDukC21NotSkHLp01xTt2?=
 =?us-ascii?Q?YxLf8ydS8CsZ1PhLHk85Ilc4aha7va89HiBdYA6j6jk+tcM7TtM5L1aaXhXZ?=
 =?us-ascii?Q?IPpjl5jFM5eV3za6yRmqf8uPc9YH3ttbRQyrCgBXSx/XAyPzKB0JWVbOPoF/?=
 =?us-ascii?Q?/N+lsU7i9NxJodKRx3PFBUW9zXev2QTCAAhVcW+9YGeJhvTbn51xKFFbalSH?=
 =?us-ascii?Q?D1hQHydg13g+Ru0KKeChnQsV4nRE+k/VOMP8fdjOxkRCLdvMDzxvuqA2UWN6?=
 =?us-ascii?Q?o0yGGhy4nZKvFztxvEE6oTOdkgbhshLE44bazvXMV9TN1G+oRUJ65+nDpO55?=
 =?us-ascii?Q?dC/SUvXwegEszt+1pluWu3JvOLYftkcf9rRKjQFhw+JMFDMAHrOpsjY+K81B?=
 =?us-ascii?Q?wSQpfRpgzcsXK3UzrLrji5U6YpwzwoESAPUHxMeCsdSj8lSQbpE2vosUtjQU?=
 =?us-ascii?Q?K2AmU4Fy26K0G2Teu12LuHkiVKzYds3bpBaJItZYAeO5qocRYJTXnBTLf9M7?=
 =?us-ascii?Q?asQChlPoTmIMKexTp8y/GhFiPLPmimt1iEaNwHdN0VGISnt/wYgx+6lQ+/FZ?=
 =?us-ascii?Q?WghgrRtpxgzI47PBH3VHRoCSy6sZv3MrGHqNLuDydxqNgPpehlEoz+mVQ47p?=
 =?us-ascii?Q?QG/sc1F6YJEXAg+3MrA/U6xaazLWJ/RC4HOt066ycgBQZJXlhTLkIjHp0QNe?=
 =?us-ascii?Q?9rUrMxy/m69JGe24VexF81ii2hmk1MB9i/F30R2w8qPxyWl23Nm59kfyx6f2?=
 =?us-ascii?Q?QKKiC8rKtNnraxIbYK3XnGTCVf02K9UDICT271mtXWo3ZN8cv/n6XjbyNGBn?=
 =?us-ascii?Q?3hSubzwOUM38AkNUsqbMI/SkVHK3CN9O0iiGCq5AQyKd+wkn0VDYjzdWKziP?=
 =?us-ascii?Q?uCag60cfffDkITPROKm88NtLb43TcewfDhEx0yKcL3oMTq1Xr4egEGiz7WDp?=
 =?us-ascii?Q?gX4AHd70cgvbKqNldL02RQV2Gp6ex3E6Wzr7RKb4itISXXp90Vw9xqeI7tBS?=
 =?us-ascii?Q?a8OLEPejGa/oXg2oM71e5LnVhtf+lKZUaF6/JNswUmIDnrVijwxt+3Uv2Acn?=
 =?us-ascii?Q?u/m0YmffDjYu0dAqgkOTueuuLpnxeCAfOfcPgpKnE1wS/9gxQUkbOlDYVo0Y?=
 =?us-ascii?Q?qKEztPlzizR7Mtc/EmItmwk3wh63i2MU/TiZcT4wF2NmdLOjgSs1B6bR78gZ?=
 =?us-ascii?Q?RaHOSwHtT1GhJKBicbVtOhHTpW7hlBjFLCNomu1tNWtah6CofdjoZaqDTBzx?=
 =?us-ascii?Q?b7hhTQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fe45ZWKllBpGCqnKO/oAS9y4LbwLgSu6Flo2R7oj1K4ystQRC8UVVbRHzngTSNZaSwgjuzk/GXG4cnYvbsOjfFIMYlKstzmL19z0mkUOcuIbvc243gQkc4HBPoSkYWFz2CK6YxjLDQVLiTP/5PWyaZdOME9GF1r9lm9dmDD/Xy5WOKT8k2fN1UfnMb6EOuiLQzzuaWOIf1xsLFUh63Hi2xWN7iiHv1I/p03qfW492no3y8EyHJv+wOjFKXSP7EIiLXo6H9LHMXdWGQFJuM8gNGOdPEqkyuIcew9N+bUXiPDcytvAJ3RAAa6vog8NNFiJ+jTck44/L4HnmxCNgMewdCIWVrEkaZKeoktu8wTmGROMycHf/VLO+1Nd7Js7vK0vWmDUJnC8DnsuInjxFG0zh0Ps0d69wkLa3aw59uniwbatw+QbkSRCOT/+1tCPdlmqZpS2ME5I6CiW+t+knaN1po3TKEsqlvRJC+GFE3g6moS1pGWFD04wWfIvnVnxGFu/pJi1nFX34A4r9LpyMZK4GrVySMNMO371ze3Ok2EUtDAMYUWfJv9ZHcZMcnkhEnMsCCwhehTVF8nA9KEvKOem9Nl4L0e6gl+gTDXLmJF+r0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7094f31e-58b4-4183-2383-08dcf2d9e890
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:41:30.5614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7doej8ELU+6U+B8YxRsSOKY/LqCp26xmSGq+RjA4+2NlwMK0X0DnyjD/n8o+UjlxEiIj7wxItfcJpEToFQ4gq9qZR4j99c7BRbJQoDOr2Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_21,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410220134
X-Proofpoint-GUID: XNdwUTDDwNH2hKNDT-2pUgCrDl7KjbfC
X-Proofpoint-ORIG-GUID: XNdwUTDDwNH2hKNDT-2pUgCrDl7KjbfC

We have seen bugs and resource leaks arise from the complexity of the
__mmap_region() function. This, and the generally deeply fragile error
handling logic and complexity which makes understanding the function
difficult make it highly desirable to refactor it into something readable.

Achieve this by separating the function into smaller logical parts which
are easier to understand and follow, and which importantly very
significantly simplify the error handling.

Note that we now call vms_abort_munmap_vmas() in more error paths than we
used to, however in cases where no abort need occur, vms->nr_pages will be
equal to zero and we simply exit this function without doing more than we
would have done previously.

Importantly, the invocation of the driver mmap hook via mmap_file() now has
very simple and obvious handling (this was previously the most problematic
part of the mmap() operation).

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 380 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 240 insertions(+), 140 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 7617f9d50d62..a271e2b406ab 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -7,6 +7,31 @@
 #include "vma_internal.h"
 #include "vma.h"

+struct mmap_state {
+	struct mm_struct *mm;
+	struct vma_iterator *vmi;
+	struct vma_merge_struct *vmg;
+	struct list_head *uf;
+
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
+
+	unsigned long flags;
+	unsigned long pglen;
+	unsigned long charged;
+};
+
+#define MMAP_STATE(name, mm_, vmi_, vmg_, uf_, flags_, len_)	\
+	struct mmap_state name = {				\
+		.mm = mm_,					\
+		.vmi = vmi_,					\
+		.vmg = vmg_,					\
+		.uf = uf_,					\
+		.flags = flags_,				\
+		.pglen = PHYS_PFN(len_),			\
+	}
+
 static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
 	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
@@ -2169,189 +2194,247 @@ static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
 	vms_complete_munmap_vmas(vms, mas_detach);
 }

-unsigned long __mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
+/*
+ * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
+ *                    unmapped once the map operation is completed, check limits,
+ *                    account mapping and clean up any pre-existing VMAs.
+ *
+ * @map: Mapping state.
+ *
+ * Returns: 0 on success, error code otherwise.
+ */
+static int __mmap_prepare(struct mmap_state *map)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = NULL;
-	pgoff_t pglen = PHYS_PFN(len);
-	unsigned long charged = 0;
-	struct vma_munmap_struct vms;
-	struct ma_state mas_detach;
-	struct maple_tree mt_detach;
-	unsigned long end = addr + len;
 	int error;
-	VMA_ITERATOR(vmi, mm, addr);
-	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
-
-	vmg.file = file;
-	/* Find the first overlapping VMA */
-	vma = vma_find(&vmi, end);
-	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
-	if (vma) {
-		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-		mt_on_stack(mt_detach);
-		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+	struct vma_iterator *vmi = map->vmi;
+	struct vma_merge_struct *vmg = map->vmg;
+	struct vma_munmap_struct *vms = &map->vms;
+
+	/* Find the first overlapping VMA and initialise unmap state. */
+	vms->vma = vma_find(vmi, vmg->end);
+	init_vma_munmap(vms, vmi, vms->vma, vmg->start, vmg->end, map->uf,
+			/* unlock = */ false);
+
+	/* OK, we have overlapping VMAs - prepare to unmap them. */
+	if (vms->vma) {
+		mt_init_flags(&map->mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(map->mt_detach);
+		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
-		error = vms_gather_munmap_vmas(&vms, &mas_detach);
+		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
 		if (error)
-			goto gather_failed;
+			return error;

-		vmg.next = vms.next;
-		vmg.prev = vms.prev;
-		vma = NULL;
+		vmg->next = vms->next;
+		vmg->prev = vms->prev;
 	} else {
-		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
+		vmg->next = vma_iter_next_rewind(vmi, &vmg->prev);
 	}

 	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
-		error = -ENOMEM;
-		goto abort_munmap;
-	}
+	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
+		return -ENOMEM;

-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged = pglen;
-		charged -= vms.nr_accounted;
-		if (charged) {
-			error = security_vm_enough_memory_mm(mm, charged);
+	/* Private writable mapping: check memory availability. */
+	if (accountable_mapping(vmg->file, map->flags)) {
+		map->charged = map->pglen;
+		map->charged -= vms->nr_accounted;
+		if (map->charged) {
+			error = security_vm_enough_memory_mm(map->mm, map->charged);
 			if (error)
-				goto abort_munmap;
+				return error;
 		}

-		vms.nr_accounted = 0;
-		vm_flags |= VM_ACCOUNT;
-		vmg.flags = vm_flags;
+		vms->nr_accounted = 0;
+		map->flags |= VM_ACCOUNT;
 	}

 	/*
-	 * clear PTEs while the vma is still in the tree so that rmap
+	 * Clear PTEs while the vma is still in the tree so that rmap
 	 * cannot race with the freeing later in the truncate scenario.
 	 * This is also needed for mmap_file(), which is why vm_ops
 	 * close function is called.
 	 */
-	vms_clean_up_area(&vms, &mas_detach);
-	vma = vma_merge_new_range(&vmg);
-	if (vma)
-		goto expanded;
+	vms_clean_up_area(vms, &map->mas_detach);
+
+	return 0;
+}
+
+static int __mmap_new_file_vma(struct mmap_state *map, struct vm_area_struct *vma,
+			       struct vm_area_struct **mergep)
+{
+	struct vma_iterator *vmi = map->vmi;
+	struct vma_merge_struct *vmg = map->vmg;
+	int error;
+
+	vma->vm_file = get_file(vmg->file);
+	error = mmap_file(vma->vm_file, vma);
+	if (error) {
+		fput(vma->vm_file);
+		vma->vm_file = NULL;
+
+		vma_iter_set(vmi, vma->vm_end);
+		/* Undo any partial mapping done by a device driver. */
+		unmap_region(&vmi->mas, vma, vmg->prev, vmg->next);
+
+		return error;
+	}
+
+	/* Drivers cannot alter the address of the VMA. */
+	WARN_ON_ONCE(vmg->start != vma->vm_start);
+	/*
+	 * Drivers should not permit writability when previously it was
+	 * disallowed.
+	 */
+	VM_WARN_ON_ONCE(map->flags != vma->vm_flags &&
+			!(map->flags & VM_MAYWRITE) &&
+			(vma->vm_flags & VM_MAYWRITE));
+
+	vma_iter_config(vmi, vmg->start, vmg->end);
+	/*
+	 * If flags changed after mmap_file(), we should try merge
+	 * vma again as we may succeed this time.
+	 */
+	if (unlikely(map->flags != vma->vm_flags && vmg->prev)) {
+		struct vm_area_struct *merge;
+
+		vmg->flags = vma->vm_flags;
+		/* If this fails, state is reset ready for a reattempt. */
+		merge = vma_merge_new_range(vmg);
+
+		if (merge) {
+			/*
+			 * ->mmap() can change vma->vm_file and fput
+			 * the original file. So fput the vma->vm_file
+			 * here or we would add an extra fput for file
+			 * and cause general protection fault
+			 * ultimately.
+			 */
+			fput(vma->vm_file);
+			vm_area_free(vma);
+			vma_iter_free(vmi);
+			*mergep = merge;
+		} else {
+			vma_iter_config(vmi, vmg->start, vmg->end);
+		}
+	}
+
+	map->flags = vma->vm_flags;
+	return 0;
+}
+
+/*
+ * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
+ *                    possible.
+ *
+ *                    An exception to this is if the mapping is file-backed, and
+ *                    the underlying driver changes the VMA flags, permitting a
+ *                    subsequent merge of the VMA, in which case the returned
+ *                    VMA is one that was merged on a second attempt.
+ *
+ * @map:  Mapping state.
+ * @vmap: Output pointer for the new VMA.
+ *
+ * Returns: Zero on success, or an error.
+ */
+static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
+{
+	struct vma_iterator *vmi = map->vmi;
+	struct vma_merge_struct *vmg = map->vmg;
+	struct vm_area_struct *merge = NULL;
+	int error = 0;
+	struct vm_area_struct *vma;
+
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
 	 * not unmapped, but the maps are removed from the list.
 	 */
-	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
-		goto unacct_error;
-	}
+	vma = vm_area_alloc(map->mm);
+	if (!vma)
+		return -ENOMEM;

-	vma_iter_config(&vmi, addr, end);
-	vma_set_range(vma, addr, end, pgoff);
-	vm_flags_init(vma, vm_flags);
-	vma->vm_page_prot = vm_get_page_prot(vm_flags);
+	vma_iter_config(vmi, vmg->start, vmg->end);
+	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
+	vm_flags_init(vma, map->flags);
+	vma->vm_page_prot = vm_get_page_prot(map->flags);

-	if (vma_iter_prealloc(&vmi, vma)) {
+	if (vma_iter_prealloc(vmi, vma)) {
 		error = -ENOMEM;
 		goto free_vma;
 	}

-	if (file) {
-		vma->vm_file = get_file(file);
-		error = mmap_file(file, vma);
-		if (error)
-			goto unmap_and_free_file_vma;
-
-		/* Drivers cannot alter the address of the VMA. */
-		WARN_ON_ONCE(addr != vma->vm_start);
-		/*
-		 * Drivers should not permit writability when previously it was
-		 * disallowed.
-		 */
-		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
-				!(vm_flags & VM_MAYWRITE) &&
-				(vma->vm_flags & VM_MAYWRITE));
-
-		vma_iter_config(&vmi, addr, end);
-		/*
-		 * If vm_flags changed after mmap_file(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
-			struct vm_area_struct *merge;
-
-			vmg.flags = vma->vm_flags;
-			/* If this fails, state is reset ready for a reattempt. */
-			merge = vma_merge_new_range(&vmg);
-
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma_iter_free(&vmi);
-				vma = merge;
-				/* Update vm_flags to pick up the change. */
-				vm_flags = vma->vm_flags;
-				goto file_expanded;
-			}
-			vma_iter_config(&vmi, addr, end);
-		}
-
-		vm_flags = vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
+	if (vmg->file)
+		error = __mmap_new_file_vma(map, vma, &merge);
+	else if (map->flags & VM_SHARED)
 		error = shmem_zero_setup(vma);
-		if (error)
-			goto free_iter_vma;
-	} else {
+	else
 		vma_set_anonymous(vma);
-	}
+
+	if (error)
+		goto free_iter_vma;
+
+	if (merge)
+		goto file_expanded;

 #ifdef CONFIG_SPARC64
 	/* TODO: Fix SPARC ADI! */
-	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+	WARN_ON_ONCE(!arch_validate_flags(map->flags));
 #endif

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
-	vma_iter_store(&vmi, vma);
-	mm->map_count++;
+	vma_iter_store(vmi, vma);
+	map->mm->map_count++;
 	vma_link_file(vma);

 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
 	 */
-	khugepaged_enter_vma(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma, map->flags);

 file_expanded:
-	file = vma->vm_file;
 	ksm_add_vma(vma);
-expanded:
+
+	*vmap = vma;
+	return 0;
+
+free_iter_vma:
+	vma_iter_free(vmi);
+free_vma:
+	vm_area_free(vma);
+	return error;
+}
+
+/*
+ * __mmap_complete() - Unmap any VMAs we overlap, account memory mapping
+ *                     statistics, handle locking and finalise the VMA.
+ *
+ * @map: Mapping state.
+ * @vma: Merged or newly allocated VMA for the mmap()'d region.
+ */
+static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = map->mm;
+	unsigned long vm_flags = vma->vm_flags;
+
 	perf_event_mmap(vma);

-	/* Unmap any existing mapping in the area */
-	vms_complete_munmap_vmas(&vms, &mas_detach);
+	/* Unmap any existing mapping in the area. */
+	vms_complete_munmap_vmas(&map->vms, &map->mas_detach);

-	vm_stat_account(mm, vm_flags, pglen);
+	vm_stat_account(mm, vma->vm_flags, map->pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
-					vma == get_gate_vma(current->mm))
+					vma == get_gate_vma(mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm += pglen;
+			mm->locked_vm += map->pglen;
 	}

-	if (file)
+	if (vma->vm_file)
 		uprobe_mmap(vma);

 	/*
@@ -2364,26 +2447,43 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
 	vm_flags_set(vma, VM_SOFTDIRTY);

 	vma_set_page_prot(vma);
+}

-	return addr;
+unsigned long __mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	int error;
+	VMA_ITERATOR(vmi, mm, addr);
+	VMG_STATE(vmg, mm, &vmi, addr, addr + len, vm_flags, pgoff);
+	MMAP_STATE(map, mm, &vmi, &vmg, uf, vm_flags, len);

-unmap_and_free_file_vma:
-	fput(vma->vm_file);
-	vma->vm_file = NULL;
+	vmg.file = file;

-	vma_iter_set(&vmi, vma->vm_end);
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
-free_iter_vma:
-	vma_iter_free(&vmi);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
+	error = __mmap_prepare(&map);
+	if (error)
+		goto abort_munmap;
+
+	/* Attempt to merge with adjacent VMAs... */
+	vmg.flags = map.flags;
+	vma = vma_merge_new_range(&vmg);
+	if (!vma) {
+		/* ...but if we can't, allocate a new VMA. */
+		error = __mmap_new_vma(&map, &vma);
+		if (error)
+			goto unacct_error;
+	}
+
+	__mmap_complete(&map, vma);

+	return addr;
+
+unacct_error:
+	if (map.charged)
+		vm_unacct_memory(map.charged);
 abort_munmap:
-	vms_abort_munmap_vmas(&vms, &mas_detach);
-gather_failed:
+	vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
 	return error;
 }
--
2.47.0

