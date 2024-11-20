Return-Path: <linux-kernel+bounces-416289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FDB9D42D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4672824C0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 20:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814191BBBF8;
	Wed, 20 Nov 2024 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cPsnFrBd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qGztCsp9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E26415855C;
	Wed, 20 Nov 2024 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732133269; cv=fail; b=sydDj1KONSLXDICX4vl5Z0uDZj4VuGsj4qiR+83yNpf0FjvZTLvPcPPF62af0kMkG08pXMEdZE3pJUD84yKEiEYFnVWkpqwJObLP5igvfo3MdWhFYh++sG9EOY1OOdPhf3ZrHoOctQJOSscFb0gVT6lz66fXMqMAGAScUjF9AoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732133269; c=relaxed/simple;
	bh=jSwCj/pC8Wwo6Xpc9/GpT6eElHUD0kFJvO1Ae2VJ/68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QMtfSsbfm2+iBGK6I1yq7bW9tzdxRsS9M0/16IXAgnVmUeyLeCfTQj5b9+3M8nTeUhfiUzFJdenJPk5hnIqFlnInebhC/dAUI/YCQv6iev3h5qhhslH0t/XbqlbnqqtbAhf5/Z0S+dSrJeRe3DDBe/GyM1D2jKVCrj5wxah10zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cPsnFrBd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qGztCsp9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKFtg45012693;
	Wed, 20 Nov 2024 20:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=puGl8r8YIGiNyTVtJF
	ULGbTANE+lY2qURrdNOA25ZYE=; b=cPsnFrBd3kOqTYN1IEJ4AnOdefWogLWhW3
	LK7/qeo1JIcEwHjTGwDO4PwNT5bRmvZsjKbrukDM+pu0JoJny2PhaMgJQMXZANOs
	xAvVnmMmsTzZri2DmroLSfesy7femaCJV2/3Sbp5o1EDd0Lfd+O8wyl+G4ubvXvI
	PBt2tJtkawlF0u+xgXSLUVC9cywV7Zd54Z1xSoS3q4mt4Y9zEQOOaL/QE1t83qp5
	X4gzdjruHIeBUfcv6owEUN2shQXi6/cnK0eNyAHqL7wMhZsxZZkt1hARlbVPRNFn
	aN9BZam4iJyNow2QZCQ/LIj2BKKC2m1f11/NbysCoQE7ag4C/6AQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0sr8sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 20:07:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKJKkUm008934;
	Wed, 20 Nov 2024 20:07:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhuat6aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 20:07:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cN/uhytK0f1K3PNTdjTKNk9Jih1Yqym+tmwIAB5/vOTogtYgS14M6DwJt6y8v7Px4IuCUc3daM3SXvix1Zi7oBkRBsn/b+tS4mOdvceScKu1tsJC+aNSb0If+/LKQ+xJXMGgyWktbcbdyEu76XDOPy818B+mgoH82N46yT9tzxgoov5qiNyp2AMomlDNUBNJA4qou6vwIDiOXVYmQ63tZ9mELOLpcTGzkv3uqIX2UaBqpLE4OjCbdJx98Kg8jodhHP8aSAIQBuK//CAjakPIHGRDTnaQcabZ1Ll1v8nV1iPB33jw6XO8yRVQvSoT084GKbgbZwCpFqb2fEcHMZxHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puGl8r8YIGiNyTVtJFULGbTANE+lY2qURrdNOA25ZYE=;
 b=rwT+DuBHKNiOFPuHTwFfrbjGOG/+0DMSmUWydtsFq4YV7h0JM9RVb7ZEs4j/vDaysg0R2pbmmIMhxiUEOI9EaJ2g02ijoKl3FDDGz+njjtIqm3Aj6yhnqHTs2efO+I9ML7+o+kwofqgRHnsiAtS9zFR50pORG4rF1NkgrudLGPFgjKx2ONDiWkxg5nMPPUt0mxVPW4zuuqXDMwQo9Hpb78Yas5oTs21HCEYPdNYefhjJ3ldK4xyq44NKW1exsC6+TJorV074DHvzvSavC2qQDomM9sV8hpm+B5m71veWoh/uFWWHlz08z/a4oUombsW/ojiMkTKhRs3+bLQYZ2OZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puGl8r8YIGiNyTVtJFULGbTANE+lY2qURrdNOA25ZYE=;
 b=qGztCsp98TP+qFfoWQjHO3q/GYUkfdv+c2kuZqzB7lMiF92jD7wwmRnYcCurnv6mwbCPIHKS6ClSukkQG7nJ9I1XpYJiK2jIpBIYv2mp4rSUo0GIKf+QSyYyfMgHbTaakYa9PClmb4wvcnC/nNFAM+HBZQNFGeVnfnSlGcyhIbQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH2PR10MB4167.namprd10.prod.outlook.com (2603:10b6:610:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Wed, 20 Nov
 2024 20:07:17 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 20:07:16 +0000
Date: Wed, 20 Nov 2024 20:07:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 7/7] rust: miscdevice: add mmap support
Message-ID: <bd95657f-0fcf-4c13-a02a-d7293aa5f5ea@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-7-eb31425da66b@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120-vma-v8-7-eb31425da66b@google.com>
X-ClientProxiedBy: LO6P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH2PR10MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3e1761-9387-4ce2-737f-08dd099eee7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tn8m1NQwJILYQCOCMs+EVj7kZiSGF+b9liE2UJ6fwZdZ1s9abKzLHT9NhFpk?=
 =?us-ascii?Q?yNOuzZcwdxOW0f1xllUK8GQaso5NzCZm9enDdSAEjWPgfWNSY9bN8SciGnnO?=
 =?us-ascii?Q?c+lLYlq5q2VOuF2fwVekRsYxyIWXj3khPR1hOMDMEN7nzbOkhcq8pxnorYqR?=
 =?us-ascii?Q?W7O2PoCpyuZJYEO5AXxPjkHF4p7lHg6UN5ziPkynbb9laUN4Lo18qziV5wsK?=
 =?us-ascii?Q?Pt9xJ94HXXDxVA0bBMPx9gEz3Zl1gp3sm/FnzbzruBr7QOXcXidAICCnJEid?=
 =?us-ascii?Q?4ofNJ+FfbTCfsI0p84uWa9iPnjXcGsrJDb/X0C3Avkj1jkfjRSajnimRbdTl?=
 =?us-ascii?Q?Y5/gplOPMYLjFomyXBXneQGvjRucSm7B1erNaEw7wcpLEpi5pSqMbxbGf9ZG?=
 =?us-ascii?Q?x1bFAgT5NBxyORt4pBAQKVkgZ/GcTjrGG0TR0HXL77hq7yZ9K+rxNv3d5Wr3?=
 =?us-ascii?Q?CyVFrvkX+Vd/n8ahEOHpW2qTueD9mCYr97098hKoYueo8IDL9AU2WAamPiY4?=
 =?us-ascii?Q?GrpmXpjusgIXiXh8fCADt//+qf/BxO2MaaKHLXniwNqpvT5itAneMsoK8wjY?=
 =?us-ascii?Q?WoAE8foAi6fYn+xIk3IxHZ7LbzxurHugj42Vadoy25ouiNi3WA5unNmzKkfN?=
 =?us-ascii?Q?KB5sVayhrQ75znTf91nEom1VQ1deAmNZ+ZMgRoznNL+1Wv1Ej9camDbFjOZn?=
 =?us-ascii?Q?22zAaB7b+HsqdFvKW4oQEWt6wTwi0lRyq3o9kJnzSfqjZYJD22oJo18YxMzp?=
 =?us-ascii?Q?Kpsj6aIB0hY0LZF1CumAkmZerjMekG8as6uDCLoFpDDpT/8VHTd2ZOVeZeg5?=
 =?us-ascii?Q?A+Ps55bDXvlkBvNRBs6eFZW8VhZNVYAXahf4q0fcG2utcfVA5w5FZ3C4/A+3?=
 =?us-ascii?Q?VSdrJtR4fS7UeZLZbeNYIcWgk0nculLgs2tcVS6xPXNtgFjL5xpEu7umqcDG?=
 =?us-ascii?Q?9ZWYb8zu9ykhcF+YeyS50m5OmCq3u1MJPbjG74sbtEpku9KyrUwS7sGzXK7n?=
 =?us-ascii?Q?Efln4NwMMhgjvGFg2NeWEAzDfAiYgfn+4+raEDMekFZph1w+kcuXW8tF4JYb?=
 =?us-ascii?Q?pQ/xieJ0vEwcJyYbuNtBW4p0gkqa8bJ1GTYatp7bjkJWQAfLs1AfifooFVhX?=
 =?us-ascii?Q?AKRcyJWu1+h00c4iyDnrZGzweGuRTi0KD5yuDAib1m9CwXbmAhdZDmyspdqv?=
 =?us-ascii?Q?czSJ6FPalNcDHyeAlWh/xqq0sW4452HUeE1ERZ04bP0aHXrsOzV2mJw2bgO8?=
 =?us-ascii?Q?1KRCZsNCRjp57t7Je1dOmQWoDo/eh4j681mis5VBi3xeuAHGYf0L55yVyS9X?=
 =?us-ascii?Q?u/wF9d13Eop3qMGGGpUr9GTK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M9qxNwGdBs6ZSwwT2UQW0tgsEcE5i4PzZYNsmhJNr5Z7DMqDsAODerN4uatj?=
 =?us-ascii?Q?BMNH70zB4JeGJYNocRPchsavuKVkAVsdbTHHLwbBWbg4QykGbHYi5RoZj/FJ?=
 =?us-ascii?Q?hsq2+euZm9hyOXgnrcQoUJUzPV00/TRh4ztFm+x24j1CBoVAHGdyROPGF3ns?=
 =?us-ascii?Q?Z6TxWe7zOJAmOalrKOCHYLOHasQ8svEudOtzkKyDQBeXcXSVO9sdU+JrXzke?=
 =?us-ascii?Q?nPAO5nqouUg0lxNBQTauGP5GttneCYT4hnsdcL/6xNLAA7/m2NSeOm6s9dUo?=
 =?us-ascii?Q?hGTP7ZO0NvBSbhZz8OANzYqwCXR+W5arFQm6yMwSxA2VOo/gMB4tZOE57Pou?=
 =?us-ascii?Q?91K1KXk4RcQxGeytEIPFBCyRPJAXUog6t8Y9SI5t2NyPg42cK7iPEBQR/b7O?=
 =?us-ascii?Q?YNIEKM6WNZucC/rWR30tJ104z1bOpFkpsQmleIGbAAHkPOO7XRP0pbr6jVvq?=
 =?us-ascii?Q?JLnrck9Z5kJYQew+UMhFlbcR9o+0Lr11YLBtbZLs1sX4qLFCPFwrcnwWUt3w?=
 =?us-ascii?Q?SpsLEx0/e3B5rBpe23eZo+a7VtrpPwip4FegagGU82LfoO1ZkwyRhTyt9Fg4?=
 =?us-ascii?Q?n9pyv2ley8+8RiNn6irHDTRHS4PLt5B96rUCqJPHP+QEVFpLTc9JVfGLBVcY?=
 =?us-ascii?Q?QQSh4wFVBbOeoMhmUD9bvMLuyBC1uWrfK1eQ2k00fuWU+K5956rTxybNYaca?=
 =?us-ascii?Q?I0ZPEE81GOJXtkmP/bz1lWg3QPRPt1R4SndwoitaVCwFnBZV+agev4scpiop?=
 =?us-ascii?Q?q8Y4DCqC43HCGWd5MoUqcO0DAf7ZapcOA9SUVYQsboL5xR2aL/U+o0nV+fsA?=
 =?us-ascii?Q?ZYPp1B0kBL0JQ/bNwscMRd6sw7/o2TShgwnJUMWtU2LPeU8+oeVEQkIvyOL2?=
 =?us-ascii?Q?mDy+acBFbWD1E7rx9d+qEve2moE8iM9hfSyL9DQxcbvf5TyMxKKgl7ywsnjE?=
 =?us-ascii?Q?i2N49BFUpup52dp1WS6VoCR9fvxVkBKOJEmY92h8Werxn+qSsRKUvXkvZI6D?=
 =?us-ascii?Q?NfsWq5GULlCmBp1orN0peb202OZY7oGPSis7PdsxMNoeCAZzTNndHy79PK8M?=
 =?us-ascii?Q?BFO49LiA/IYW9cjiflh07Ws0RzjGSqQqcB1ed0aTuutpmREvjRsph2JshTda?=
 =?us-ascii?Q?OtB4x0VOAhCOc2SEsOXeaM+VwHwxnNgUG/WfN0oLuurFDxr52ldtsyzq9dT5?=
 =?us-ascii?Q?EwuhiuH/j7Vy7PlMY6bBSfCsb/BbPHczrKnrCVzQScgS9bMBYKJi1qz1P1kP?=
 =?us-ascii?Q?6F38YNCn+xoTIk55C01jJmYkuGbq4CC4n+gD7Hm1kXxhSisQnwkkBX/xi3Ea?=
 =?us-ascii?Q?4JePIRqbBiTFkMNcYdoaKW/2AbjktGSxcOvQhlneijQXtXqjpwZPA8TYr+so?=
 =?us-ascii?Q?yOiGdthA3A10y/Q8Icemrew6ne6pegkhbNjEBKyofwS2NBrEPPC/tMKOiaZx?=
 =?us-ascii?Q?L6n4gejRx0Wy0cg0Z6VMOymoxv9u3qVUTxIduG9X05LQgF/YyrLtnGXL7v4n?=
 =?us-ascii?Q?IBcs9wqAgCIMNi9/dGl9m6fXdRduFBtSzUMXy08PJ5vdyFGGpNPPoHvI/isj?=
 =?us-ascii?Q?OXFGvj34gFv2A3CDGluTkJnbGGB3h5vqI3Fncys/vshNpM/uwck1lKcbyyFI?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	idhZKZaQq/Rt5Cl2l4qChXoQ1LMQbGg0YCTyaJpaiCwX4BU+nQqQcx8DXAOJyVrBzhwRzgRun0hWYrUSyC8a+Q5wbTUv799nCovTBIVhtDnA7vCTTcuwtCVCslLCIjjDv6IDeYCxwMl/b0EJjUY37kTXxQf8Gn0bcWPI7BIGy0fq+XnSOvcdjqucts9Zt1oNSKpxdgYUvXl8gMtNZ3b9RLJvQSoNx4nXrR0vtBrF2hiErdanC5gc3SLdTya8Uvs+pvGnbWoP8nSDb0WGZcZ9upqDvG/Gl1AFJyqNNZcwAfdD1Qz0sy5sH2orK9bDXfKnTrY0EowNAiPUxxQeVwWYOMUYSNJYChhY10EPsLU4O+aqoMqoqzWtwY6RaPvPMxs3FZNWc6CduZrfZ0LftxXlpbNOBA0X9wjiUqb6W83VpiN+7gImR/WoysMBgy2oxZCnKSZNiBPfphFYMUQhCAkTtskGd96C+now66DpKbTIovkWbsfryme+PV9sYGDHWqt2uUbL2IOukvfXZI9G+AL5mAHewRTJ57wQIj6K24AozyxhXVddLGuiFmv/Zb4riHV6+NpdzfryBbeUWk2nwLmN15pIFiy8p8kuj/pNI210Nik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3e1761-9387-4ce2-737f-08dd099eee7b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 20:07:16.9388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CxhPVZmygdDJCma43ClVy5Y4J+QNVhPjemcXpZUCoQxPlYwpwMkvMQUT39rfXFMx3kaHFr8jsYqbCU018g/8zBHT1HaDPdFtucCi6AJbvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-20_17,2024-11-20_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411200140
X-Proofpoint-ORIG-GUID: cJ2tDxGea0pOWRY8d068liSHDLo68SZ4
X-Proofpoint-GUID: cJ2tDxGea0pOWRY8d068liSHDLo68SZ4

On Wed, Nov 20, 2024 at 02:50:01PM +0000, Alice Ryhl wrote:
> Using the vma support introduced by the previous commit, introduce mmap
> support for miscdevices. The mmap call is given a vma that is undergoing
> initial setup, so the VmAreaNew type is used.

Again, I'd be explicit about the VMA being passed to a struct
file_operations->mmap() hook on mmap. Otherwise this seems super vague to
me!

>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/miscdevice.rs | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> index 7e2a79b3ae26..4e4b9476e092 100644
> --- a/rust/kernel/miscdevice.rs
> +++ b/rust/kernel/miscdevice.rs
> @@ -11,6 +11,7 @@
>  use crate::{
>      bindings,
>      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> +    mm::virt::VmAreaNew,
>      prelude::*,
>      str::CStr,
>      types::{ForeignOwnable, Opaque},
> @@ -110,6 +111,11 @@ fn release(device: Self::Ptr) {
>          drop(device);
>      }
>
> +    /// Handle for mmap.
> +    fn mmap(_device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>, _vma: &VmAreaNew) -> Result {

You will have to help me with this :) ForeignOwnable, Borrowed<'_>, _vma I'm a
bit lost here!

> +        kernel::build_error(VTABLE_DEFAULT_ERROR)

What is this? Is this not yet implemented or something, and this is a
placeholder or something?

> +    }

> +
>      /// Handler for ioctls.
>      ///
>      /// The `cmd` argument is usually manipulated using the utilties in [`kernel::ioctl`].
> @@ -156,6 +162,7 @@ impl<T: MiscDevice> VtableHelper<T> {
>          const VTABLE: bindings::file_operations = bindings::file_operations {
>              open: Some(fops_open::<T>),
>              release: Some(fops_release::<T>),
> +            mmap: maybe_fn(T::HAS_MMAP, fops_mmap::<T>),
>              unlocked_ioctl: maybe_fn(T::HAS_IOCTL, fops_ioctl::<T>),
>              #[cfg(CONFIG_COMPAT)]
>              compat_ioctl: if T::HAS_COMPAT_IOCTL {
> @@ -216,6 +223,27 @@ impl<T: MiscDevice> VtableHelper<T> {
>      0
>  }
>
> +/// # Safety
> +///
> +/// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
> +/// `vma` must be a vma that is currently being mmap'ed with this file.
> +unsafe extern "C" fn fops_mmap<T: MiscDevice>(
> +    file: *mut bindings::file,
> +    vma: *mut bindings::vm_area_struct,
> +) -> c_int {
> +    // SAFETY: The mmap call of a file can access the private data.
> +    let private = unsafe { (*file).private_data };
> +    // SAFETY: Mmap calls can borrow the private data of the file.
> +    let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
> +    // SAFETY: The caller provides a vma that is undergoing initial VMA setup.
> +    let area = unsafe { VmAreaNew::from_raw(vma) };
> +
> +    match T::mmap(device, area) {
> +        Ok(()) => 0,
> +        Err(err) => err.to_errno() as c_int,
> +    }
> +}
> +
>  /// # Safety
>  ///
>  /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
>
> --
> 2.47.0.371.ga323438b13-goog
>

