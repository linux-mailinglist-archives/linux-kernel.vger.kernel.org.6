Return-Path: <linux-kernel+bounces-439894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC729EB599
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3940F188A593
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095001B6D0D;
	Tue, 10 Dec 2024 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HdmrFlsZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g4Q+rqbF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266923DEBB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846789; cv=fail; b=CZEFDyvw/xCTPfo4T33G4JgmrCsKx/NkPxDKHlBpKqVN06gku6L38ihVIhDwSVp8QMJzTiTlCyMZpQCXyTC9s7H4ypDyzHhfld2DGYxeBG9ZEqn0UAOnkYaMsL9+r7R8YqNSPKqnfZHPUgZ7JXjuOd/cMAMUAfw7o3+uQRjz2U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846789; c=relaxed/simple;
	bh=Llib2VnrEl0Km9unVWpwEXjcY4scSEdJ7Q1Vnh+uk5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LH8ZhNt+Qvg0N3oyw9fFLB5gowc2K1Lxnutny7qPtRvYGM4IjWBS6SBNNvlUZXrrfKwKL/1jhvtYveXSGNT/jm5bF4iOhyGNdTm+keCur9EY0k4CXvy1EWoqeQV8Ir3liTMOHxwf6uH4x0Vw3jAor8GvWV888+9kb9OgfVd8has=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HdmrFlsZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g4Q+rqbF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAA8nlW025158;
	Tue, 10 Dec 2024 16:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=R9db+EA1v5VDsAsxJH
	xuyxUvafYle+dRpHpkyLw4Wxg=; b=HdmrFlsZqqhdf34+Vn1E4Z7tNW0d78XlYS
	w/XhcKiECrMUYvWcr5/zq2mxDjeVBL26ig95IMBMhPC9a8Nek8A9KKiXRJQY5shD
	dguv8CJ3UEuGuvsF+a3uA9XOfe5htiZ/n2mXUeNnPSINjpeeL7eQkvj7YP7N1kGb
	nmuehGCyyu9htWhjh8zhp9doQ+dke2bqJPL8RFGYt7MoX69LJ8AYwicMhRU+YPHs
	F6LI7US8VEaGnksQM/mP54mefdHFW/2A3FexMQmUn7UUev2mIwyJt8tZStiyp+x9
	xKXjjaTdvM2oOc1/xIPr2NnSfRoZL6pV7+UytX+UiMiCX0FvHiKg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt65x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 16:06:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAFdA5C020580;
	Tue, 10 Dec 2024 16:06:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct8gth9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 16:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoeE5Uez54H+JnWt0o3tiseEJK4coQYbG2ddpV6my7MaPp8DvH6aAIo6uiXJh+tQ1yS9Qj5jG1SF6yJmI7n+5SXqyOcaEKhARPP8IvjAYHyDJ0RSP1QqXayFvORtsHrjJKXvJugZD1QLdvCWmpfiihaSY7YsgHMHHDl5+EA1xj/QvCMjsye1/cVV9cegfzKG1k2vvOW44gUM2kGEItvwTRKbyxShZxWYMJb3TF0GPgSBXSpPm4xT+K4bU0G/DignOVpSVyEXseoFHe6wqYGImzhPGKOPgoW3Phl0cGi+YvaIvLKnkWQaukufY9Kj+mK1/I/UUALosdRzXOxMLNz9Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9db+EA1v5VDsAsxJHxuyxUvafYle+dRpHpkyLw4Wxg=;
 b=PO+gLjqjDdvnClsLcUkon6xOzZVUTnr1yCQERFhkET3XJk3IV3rPRtBo4bNNGKaGBAapm0MNR7sSfwJAmqS4mZ7gTygv1vLukcUoi6UJkgMJEk66FV34UEeN+R+x0WL4qv2ajHs7ce6x5BuEsCbHlUR+JH9Ml81tT35ircc6cUPRuM9Z6gvxk+4Q4U8qF9ewox0An5oaRHmumj5tqK87HFIM753YAiYb8FGygB6qqdAIkT6XWczKX/HS0CYK+bYbi/i7dVtnsquVVAKMDYzaJLIc9KjLaIa6dvwxtj531+eXAAq/9ulU5GnQ/6hWs9S3KeaGJ7tv0KIyDL+WgP0Uwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9db+EA1v5VDsAsxJHxuyxUvafYle+dRpHpkyLw4Wxg=;
 b=g4Q+rqbF5QV7nLKidBSaE4VpL0XlqSo4THsxcWi6n3dWKxjwRfalGBn8x+Xl/JI3NpFDoJA/IvnZGi5s+7giZxTex1jfN46Cp9sEAGvq1udySnHdqUW/PQep2Xf8+2P+MG7n1J5tmUpxaraxEeRvV/E0clCJoz6dV3EJ21AGkm8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Tue, 10 Dec
 2024 16:06:10 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 16:06:09 +0000
Date: Tue, 10 Dec 2024 11:06:07 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <w7fskn5jemlijpk45n5jtto5gh7ne23ygxezeaw5h4ups4b4pk@t5nmdroazzmd>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
 <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
 <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
 <81fc4cd1-55f4-4569-aef7-0b0da9684fdf@lucifer.local>
 <af887f35-0831-4c7d-9f1d-bc857b52975b@redhat.com>
 <67ae2a5f-0c86-446f-a122-f14decdb84d3@lucifer.local>
 <a3cacdde-8dab-4dcb-a720-9e00833ee9c1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3cacdde-8dab-4dcb-a720-9e00833ee9c1@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::29) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 62989be1-15ec-4584-dbfa-08dd19348fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n5Pp+nADhnrp7VahC1UogjsWScRrUJcCuk28RbdQHPOtswSlKB2H4E11JlTX?=
 =?us-ascii?Q?HRi7I3jTlQ72w8mdWwiMJdPmvZlJDIsCbY+pPN5Xww4E+g3+Thfjp4fiXdTp?=
 =?us-ascii?Q?vvg+5SMITM/rMTLzIjodrSmu+rdJvqyRPm9HkaSM10Mcf4yhe1EChCUN7MZC?=
 =?us-ascii?Q?jBflaj747DIUWqxFwUCxEnntczlrbjICja4ce3R6O8Leap1RfZeBdwNg6qHB?=
 =?us-ascii?Q?CEVSx/n/q1+faGQhtgK0WSs8WMHV2ziCP9Q1vOb5Tz0RiHv2JFZqa1vx207g?=
 =?us-ascii?Q?EIFdPdlPM2OUHNEAbPW1ahmFwJW7bXWz6YewkChDj0bZOHs5sULxYIt0xQ3U?=
 =?us-ascii?Q?lxX9EDBFJ0SRh5L3JDbyIQlAZnKP668pRocv/ipb5WZHiLpnNI4vrlOk2U+w?=
 =?us-ascii?Q?z6iIDk3po/aOURWkBIGQPywzR7Vl2aZH01zC5Tysoh2FEQ6rJPRaRDfG7rrH?=
 =?us-ascii?Q?ylgYX1BNec9BijtqjI3kTns1Ps75SDIsHx3WRJURvRXjhXcWhA+xbbh01kAd?=
 =?us-ascii?Q?k039h+4ifz3lp1RVnvencc5fxoH7gPxuKPY6oZTYwushN2Cbt5nRqWVe72fh?=
 =?us-ascii?Q?6XkcBAcTgb/tBMf6K2K1f6XM5eY6qOuRvoiYgD2MVtpJgie+LunuCpdBsD+y?=
 =?us-ascii?Q?a2ra3TsTxdzvcJ8T0SNLjn8aWZFIaKZkm0+xny1dgUC04h9kJra6KRN6Eloo?=
 =?us-ascii?Q?lG6KXEazFmzsN04LFDckuQU8geMHOXOZuSK+VRRwdeP9Km5SB9Mk35IrIOpw?=
 =?us-ascii?Q?j1bBmlvkPqKZ72F1uACXQPynfOm7fDqyD/M/XO/QFwrchSfvV2UICCdfTVx7?=
 =?us-ascii?Q?bDOdXeOxMi0ZczuaK1tHZsEgMMW0Rf/KD6gh+xEQZWkyUwaJkYbSOuj8ssPN?=
 =?us-ascii?Q?XGSFQvkSuFjfPXQtqWlra2Rd8X05pi8cfjdDbSYJBmVyb7VWkvfJJ9K3TDgH?=
 =?us-ascii?Q?otr+30wxRMGkr5HFmbeJG38Oo3k+1RRdxOsUKK4NWfVpnftFEbP+Y2Y6YBuA?=
 =?us-ascii?Q?Gdmaq2SIUSZdxetOCKzGBliFNh/9s3PupEm6Nx/yvwDuyH3pAjq3DAHWivTE?=
 =?us-ascii?Q?X1E1Sh8heEFWLITvzZmxuVeaqpbeinCD5rdYMD1z4TschIVOOllnk5GvDKat?=
 =?us-ascii?Q?uCqsmZKGtnfMiPHIZ584GbaLRWSywnTEbmJP5F54ogsR0+VGz3EXaLBGv2pk?=
 =?us-ascii?Q?/yHbLVlezvZpO7Jpocb8z9/ZJjWmVXuybs0sji26WgNNgq1crQy7w8yXh0E8?=
 =?us-ascii?Q?vkV/0uDo3vOGK4Hkslae19wcVaOTXwsGofXUB4JQTRweoJznxOWtIIrHbKrZ?=
 =?us-ascii?Q?MO6MrhNaj9Fv0y5Yr0a35jU2glitNynDgMaEZHPt7CmnLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M527+Kabt59FZPNgBD31q8Ja3qvvKi6vQle2c5kWd2VV5Nx6V23NMw1VFZpz?=
 =?us-ascii?Q?LCJajqm/j27Uhy0P8qui7hc3UsLgB0VUywHLFxFqpHJPaqrOVD399f+8E+7C?=
 =?us-ascii?Q?kcLy5qylObw78ZSrQDZWJtGitvu/vneVfJ7jSrRpDdwqQIPJLVOeE3s0Z7aU?=
 =?us-ascii?Q?kKR90h3Eavj8ow/HGl/RyCVVly1GCfhALYvIRWGW1zmYtwV7roJZ+t0MBKkS?=
 =?us-ascii?Q?zuRnbpIdTd18W29mYuoZjY58KLFvyI/0c9LOyD7C1AyxUZnQ2NQdhCRTwE1V?=
 =?us-ascii?Q?eXp+tBRXx9r1np38kP9O7fU9L75B6VKBwE7Hr9PMZkiWVCLZNr5DNd4V2AvN?=
 =?us-ascii?Q?fCFvBAMFiaZRTFfPz++QIItocmG754slg8F5LC3/Ic503PcJi1CRDF/o6o5w?=
 =?us-ascii?Q?D0NvEirkYxV1EVRwr+gMAPYSmvnKOpmoMGOOKyuR+VHCUoJk1uxiAHuxtw/u?=
 =?us-ascii?Q?oI/SFOlqcP7gOBMqcipMYV2qVbCRZDprKZa9z4N9JSILmTEmdJ6WHmCSmjVD?=
 =?us-ascii?Q?30rQ+bPdW4potXLkKLLHGOfc+MXaMeOP7kx1k8i6cX0cnHRELVTwdZvlf2wp?=
 =?us-ascii?Q?Q5gfmus8a4ZEnGdiXjdFvel8SdYFSMsToHQNIELpDPtsU15Ac7Sl84aveVZE?=
 =?us-ascii?Q?tokBC0C9NdwoCB0QDGbQYWOOQpKY7F+FkymMisFW0sN8L/3NtNVv+CQN4cYp?=
 =?us-ascii?Q?dNQWvJUx4OCeM/kTCrOkS+drUk1tk2Pkrlt1Tee18DE8rWtQE8WPySVS3BEl?=
 =?us-ascii?Q?aGUmpLbH2r9KhMN6X+pODgaOgYTKxJsi641KyfnXUS4Qx20ZXO79RUvJ3jfz?=
 =?us-ascii?Q?871VLxLm+mFO3+j6Bd3o0utMh0ycBH5xtFizVzK+TtLWntWVmqQDkwISvQCR?=
 =?us-ascii?Q?AiGZY9ppl857C0+NZLan++pSSer6eiO6H+KezggeW7nb+dnFDDsFmPMd4GF1?=
 =?us-ascii?Q?TkSPl02U8f9hOHho+hcwqKT2FrVkP2G7J4heCmggno8Qd6fvFkAbtNqOi7VO?=
 =?us-ascii?Q?bDNJxwk4KzXige0mp25JQtd3oKxxCL7olpnCIq0QuUHgKKbXKT8Q/UoAUdI0?=
 =?us-ascii?Q?Odow2unzUJFETNVCCPXDIViuyd7uWfhRIng6aTWosUYVpiDzTxxLCNSVogtY?=
 =?us-ascii?Q?J41R1oPA6PBvDB2gwKjfiB3JN6jAUtTNwdwndhqoHa9petNfoZ+H2+qvAECo?=
 =?us-ascii?Q?yHDPuXgvW4DX+RPfMTbxpeJ652cFDOlDJpQleOsVBlD8wgr2wjWVVZyd0EmE?=
 =?us-ascii?Q?iQod8xVbeG3h6y6avM+sHMzv7u2G+UCZvj48OWJ/NTtECI7uqDmvHzUlVwjj?=
 =?us-ascii?Q?Yl/t2f4D0G4IklX2ouHJp7+gGkQbxuAK4ecnKYj5GJwLu5i1Oaiuqv3T1VMa?=
 =?us-ascii?Q?jXgjD/fxURp1cRSpH8FZUk5d73/De84PQfqNwRN7sC5MwfUA1Kw4t9vn724o?=
 =?us-ascii?Q?TUUDC4h9gz/2kkugOtrpFRXaqQG7KMBn25tMh4ugolxFRYnaVcUf8pPVo5xH?=
 =?us-ascii?Q?3OZw/jCuhqE+CAVcU/Uq1Mg9/+OHuakKNIcDL+xLB0BGBGTVBR/mj+6qpliE?=
 =?us-ascii?Q?ISC3pYbobyNMuQJnkV5E4kBJ4ovJZZPxsByUpdCG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/P+q+crHYNlD7SFJMecKHgYh0/YMOhOdT0nBSmS2plSPak2X4qkH42JVXuohlc9HLOrJxhAR9Ti+NIwBu9Z4RDkxO798zWeB+0+39vVBdCkI3nNh6Naop9eMPA/DWb5DIg6+k6Bxp7B9Z16Xi5FPgzlUor56EKbWhhOZtMAV1qs7y2vX50rysbOCY5YeUp4GqpNK24V/xJV21J5TFPO/tw+geW9S4SrRpyIgcLnI/Gexyio8uVwFkrnvnLR3sa+ZztsoWamzcWLH2/jtjVOsrIOVhFDTU5LoqTyiv8wLWRBT74UrLIcbM0cXRDI6wbN1Fk/b2nOHyHMWaKvPc0Luom+Z+XDZJWw+uFa55heCIlkRkC5gMQ4hpaECXj+KX0+5M3pWGPoLeRUZ/5SmqVIVeqzUzr6YESrJiTzdGx2nnCbQTCBElkoxjhTx+xcWgPnwNSPtKnxiDErC8IRWcc8bf+57h9jD6+hDJlvPgaNsahhbgiQXeSpFnUpxWCthSbnqoObqxjjl86jGjsy+ul109ZI9yyhIE2kvWotdvGOZ5a/E4Hu5vJq1hpQe9G4lz0ymc87B2tMTkI9RoIUGrvUWWjqCgHwkv6ccgneXHoxasYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62989be1-15ec-4584-dbfa-08dd19348fbb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 16:06:09.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGQCPWjxj6ifwG2UP2V+9EWIh3Dkil3Y5+MMNtrqEmvmxupHiDE9b6lzQlHNNoXULSVvcpfnumL3o3lQ71QkjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_08,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100119
X-Proofpoint-ORIG-GUID: fohufspMrc0YwzNluxYwJbjPWcicj6xl
X-Proofpoint-GUID: fohufspMrc0YwzNluxYwJbjPWcicj6xl

* David Hildenbrand <david@redhat.com> [241209 17:02]:
> > > 
> > > Maybe there is a better way to split up things or rework the code; likely
> > > we'd want this code that works on VMAs to have a clean interface with the
> > > core vma logic in vma.c, if the current way of handling it is a problem for
> > > you.
> > 
> > I think we probably need a compromise for the time being, and as I was
> > saying to Jann I don't think it makes sense really to separate the VMA and
> > page table bits from these files _except_ when we finally have a shared
> > page table interface that we've spoken about before and perhaps we will
> > collaborate on in future :)
> 
> In fork.c we split out the page table bits (into mm/memory.c), but left the
> VMA bits in there ... :)
> 
> > 
> > The key point is so we avoid stepping on landmines when we discover
> > something was merged in file X which we weren't cc'd on that breaks core
> > feature Y we have been working on in the VMA part of the code.
> 
> In my experience, tracking files is not particularly helpful. People will
> still not CC you, or do nasty stuff in files you are not tracking.
> 
> What I do is (well, besides screening most of linux-mm), is have a list of
> magic names/keywords, and tag the mails.
> 
> This way, when someone uses the magic "COW" keyword, for example, or calls
> mapcount functions, I get them put into a separate folder where I can just
> briefly sanity check them.

Maybe I can explain where this came from a little bit and see what you
think.

We have found files changed after a release without hitting the mm
branch at all.  Not just once, but a few times.

We have regular push-back and continued conversations for development
after a nack on threads with ideas that need rethinking.

Now we have a user visible undocumented change that is actively being
used that will need to be supported, forever.

It's horrible and we need to do something - anything - to try and change
what is happening.

I'm happy for lei and mailbox rules to help lighten the load, but some
of these things need more weight behind them. I also don't think that a
new tool means we should abandon the existing infrastructure.  Maybe all
the tools together will be more effective.

My hope is that having names against the files will have more weight
when someone decides that they can just take this patch through their
own branch, or mailing list, or whatever.  That is, an explicit
statement to stop doing things behind our backs.

We can also, hopefully, get more reviewers Cc'ed on these areas.

Would a different topic with you, us, and others make sense instead of
under VMA?  I would think MEMORY MAPPING might work for a combined area,
but I have no strong opinion on what we call it; this one already exists
for mmap.c.

Thanks,
Liam

