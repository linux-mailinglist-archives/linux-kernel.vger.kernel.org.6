Return-Path: <linux-kernel+bounces-357893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B4997771
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0904D1F23140
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811CD1E25FB;
	Wed,  9 Oct 2024 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kzndECYE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T/vPHn4j"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C018990C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509131; cv=fail; b=E+3QgdPMCIHNGliXQVRtyEHFicy7EhzQzHzng6mcWwbgti3S3+3jvx/kR7lJv0OzIAlLI+E0mBMpcQIiC31cWOWQfW5vYUKhU5hhPqQy+sturosuO4RZ0InpA9ncaHoaM6kkxzX1B1wu/QdPICCecdul1Dtt7w08yjWaK6ThpPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509131; c=relaxed/simple;
	bh=wuethjet4vIiI39TE8Kif94Heh/asBrf4HVKpQaEQzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GcdyO0YtNcP6AnpiyMD7xtMYLfzeoXNZ0rj1AXgDkOjxxWWMiA+dbEHhXZ5tJvwDtBCW4WViowVk9IDmcxUcbDVO3lvlZKVr7ugaV7u6glRL2aqlWn4HyNxxDJQgT3JJ6qgiqLPku2EMSIGxlGO4UjRJ80vlUGgQ8uQqJ5qaupM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kzndECYE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T/vPHn4j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IIQ60016797;
	Wed, 9 Oct 2024 21:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FOSSaAcTgBW5enMxn1
	QgiR0uYhPblNWEUzT8QmUA/pg=; b=kzndECYEgb39LSH3T4D2e7q4yOlcPTDdhV
	v2tvhHQDvZIuw8rMy2y5Ym6L1JfxZJYNjdcN/b2/RJBL0NbfGU7Ddd9/+R2R7Zoe
	wBQJg3a7aiLJZS34i64Qx6WROkg1NHNph1NfxuAyLiY3tcXKFhuhqUDeWyIpxWOV
	EeWloqRklT7XuDkz9lV9YKmwXGx4MJnpIxZhD5vOs6iWXEwt+sCuWliwFaOExJTb
	bqDtrG8oHziWsRVgCCFdy56+NNXAdXj1RCw5iqc6z4n7VOQN4ER3QImXqtj/pQRV
	ZwPaiqXgcvhkUXnbXCicxjxj5cdKqvoEO/M4aVRh1kufIiFXpe/w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034st2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 21:25:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499KNOMB011526;
	Wed, 9 Oct 2024 21:25:06 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwfh7en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 21:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVtlrAQU/lUo5fIw7Uyq2tabyw7Q4YYNyMVLqpv9MWZ/981JPQN72xCaAs8Oy+XMqIN0s/bEulxhrI5SIf68U0Kl2JO0TohtjGtPm7XZgngnRgYTUWkRQF+2v9rKTCvZFnmr21btw01nvzDg7ZMLTVYwX3ur8A3ZKS5ewSnZWsGSzIbkNgyLZHELA97fT+E41cqAyXlkF6w1nG7TGip28OoIIf5o6SmXhaprjDgRsezdCW17mLZhhXh97qMeK/7c3Qb/yrAz4ez/aaCwgqhm4Nmrg7iOK9w3e1NfRyRXWMmB5c9Mj4B2nJi3+HOPXDlCKk21oqG+lKBQhlXb4FnlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOSSaAcTgBW5enMxn1QgiR0uYhPblNWEUzT8QmUA/pg=;
 b=JYpBjxU9EnQngrem7WMo8IsipVPE+oCrkku9Ogi2sfokBDf19L12awof0F//dTW7kIVpASrQMGGc/D2clhqHbTD+HgfPYx5ctu5FVj4TnI00tA4CdHrfLg3aEHwqGh22XgIFKvnHP14Xg7DxaIW+sQ7SvkK0v4ldBKAby7baVjQ+XxqoCC+QPUZwMkA9wpHmuu/Lr4SZEix8He9D4fnCVuaLvuMKIABPDaZav9YNwVxw/Gssllp/WE6gzSc6u6LnsMjmUz7WPed2Bgk+wVk9b3JK+R+JXiQPlo67EA+WCgiBZVRtXtw+MAVsugdkq0tIN6NOpXC5vd8P3dpi6mR6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOSSaAcTgBW5enMxn1QgiR0uYhPblNWEUzT8QmUA/pg=;
 b=T/vPHn4jD47I5xgHmmfWVSekhEdQf/loBg4EtAgU8H8r6UeWghOmh9uss+7/fltCKjWs9SdEgA/ofRPJr3v7khhry00kn9lyhXotC+dAIMMdaSvu4q9ssXE0vHMYqagn9oG5TtHwjyPQ3xPCiNrvZT13PekIvuLhBtgYDChS7GE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH0PR10MB4551.namprd10.prod.outlook.com (2603:10b6:510:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 21:25:04 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 21:25:03 +0000
Date: Wed, 9 Oct 2024 22:24:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Bert Karwatzki <spasswolf@web.de>,
        Jeff Xu <jeffxu@chromium.org>, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mm]  cacded5e42:  aim9.brk_test.ops_per_sec
 -5.0% regression
Message-ID: <5b7227fa-d0f1-452e-b1b3-9d7b87641522@lucifer.local>
References: <202409301043.629bea78-oliver.sang@intel.com>
 <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
 <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
 <8f5e8ae0-dfaf-4b33-ae79-ca6065dc96ec@lucifer.local>
 <ZwYmTnWEhgWO702t@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwYmTnWEhgWO702t@xsang-OptiPlex-9020>
X-ClientProxiedBy: LO2P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::34) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH0PR10MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0213d3-7368-4e88-5360-08dce8a8d6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dDomK1qP8uXgJsc+2568qxsdWhNxJS4zOC8P+LdqHChTBpYtirkMwL8rOWZ2?=
 =?us-ascii?Q?6sOQL5DRLzddMFOGILGpo9xCU4DEiUfEB3hwL7yhpNMSZcSnEU62RrDHWBoI?=
 =?us-ascii?Q?dPFPtnS/TVy7HqbGOexXojjAkS0Ufwflcrm6AwrJKuoIteHWsAq+lJXNan+0?=
 =?us-ascii?Q?JcwZ1nDoyH9I9FIbjH/x+YNus+5uKJiub3+wwO7i7+VBZ212X4hyIKz7sXcI?=
 =?us-ascii?Q?1tlxHzGnbwFdDdqvHRP23ERftXgCBIkc/xFWUJUs37XYATHzCMMHn0Hm8047?=
 =?us-ascii?Q?F9pi58yDo6VZxGJ5kmi+x/W9ho+bTKB/rAmrl+nVNTnDAU2wYKi6WAAXpDKe?=
 =?us-ascii?Q?VL5bqkD62fCSlixECsMg9WFeyKnjilskcb16N09hGkQw8jT76V4zI79iTKx1?=
 =?us-ascii?Q?hl6+SJikiaDakDKHTzUJUtrK+oPOLvVsp7fwHmnPfH3MCSUlEsMMhVWTM1Cv?=
 =?us-ascii?Q?KjcHM6aLU8fvb+NMJqrdaGXYSHtplr1p4pv84GW/g1EwEIwWTeWdgAfCdnLT?=
 =?us-ascii?Q?tq5UIfQCbKi/OIP9590o2ZdYrRFIygC6kCpXN47Sxv54bivDI6IBkvhRzbTS?=
 =?us-ascii?Q?5vEU2xZA/DDp1pWAwUfiVfB14LmdqCNAfR2hRWS/tnWv4hKZoeglE8MS0RP/?=
 =?us-ascii?Q?h+1LmgYGXDRCuDrpYct4VNk2206AXf9n2MWApzT0DNcKDyEIqxook+O67BQt?=
 =?us-ascii?Q?/dAdIML0gUOfN+8P2u5ow1N6N1fvT70RLo0kC4EOXurc5H3yAjlbk1OAo4bu?=
 =?us-ascii?Q?CYthy0qFF7xwaYaMEkLzVyQvJU6Vptl6T2pQAyGRj2TUw6bo+786mxjeyTU7?=
 =?us-ascii?Q?+PUiNenOA4niRFFKwQ0A/snJmz5O4nyOXOLMZpap9RC9HC4JG00Dc212HxVM?=
 =?us-ascii?Q?nU14ed68+vcvPbbHYcPs9y8X/Ydm258Vxdvwhsf3+lLGN7vzcMdy8KBhzMWC?=
 =?us-ascii?Q?A8PIKn9cetxh3aZOntMPHaLVKr/NVaOfTCl56NQY/FoRCOGNCgXZQjSicHzd?=
 =?us-ascii?Q?Y024KWqjLxehX9Y2hnLO8BkTeDmszXDMhIsqLm9Zhqbbr96Co1mziVk49FkB?=
 =?us-ascii?Q?nZhHdYJo7W9syq6TINwRNmUfiwDA4v+biVrPb4M+qDVQDGquWFUBmBCIqPRb?=
 =?us-ascii?Q?Cm89BGw7XDxqC3Oly83a5jyRn9sc6vp25ZWkQVRQfuOD5FIoU3dBgAUDx4Vm?=
 =?us-ascii?Q?RYWQYhAjD2LcyikNhL0uTD28zc6j0L4BHKl3CqoGXizQ1n24xKsp3I1JAVdH?=
 =?us-ascii?Q?ZTES6vXFvIWmhZGZldFWHuIFFKeRrmh9hjH1Sk5DHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Np6had75Us+OirLdIiL0vaoKX8e80Ipc0DFr+nBEZXZykjTMeJ/xu2pNLZsU?=
 =?us-ascii?Q?IrhoCoNzEiozPkmKND3LhHg4fIgZQfoZJaY2bXn6bFLIMZq1Eo2ChVMf3wjO?=
 =?us-ascii?Q?63AQEumFmmcwVyEw+O7KzW3YJoJhsVZ3bSdf0zWsToerheqynZnh6AdT49/0?=
 =?us-ascii?Q?mYR5CC0uHtM0UpvEnC7ussLGzEHbnu5nAn9pRZ8ME/PMrua/qNWGWWHw8UYC?=
 =?us-ascii?Q?lNIqPJUkSABrq1IDx0w35PU4GWEH4YSIvIemg6puxE9ZNG0Sb7AJPuBTz9Nv?=
 =?us-ascii?Q?n91REPXDujbEn01NspVEzovUQjqCVP8MfNOuIa776PpkjuUEVL2pS6WBtDOb?=
 =?us-ascii?Q?dUG7IwbuxLamJLjZFla9PJwUWgL8Thnf91Q651Ya5oL0UFejTaCyiY2SpxTj?=
 =?us-ascii?Q?jQ8oGwRZugwNNkRViDppOCUJd/ZrEx7invGkI08m5vMtSsH+YkdbTQqHITQh?=
 =?us-ascii?Q?iXjdHHyC/+QAXZwE1dfambjJWfAMY7bjxLJQaaqFMoJlTqVPu/FwAZe0O4ln?=
 =?us-ascii?Q?5+Ed+XwALgE5Mr9/4N1/fPGXoEel4dq2z3YAtjjfmqnCL2dlUlJNhIh7UfqT?=
 =?us-ascii?Q?PqKxXmMs9/ody/nH/rtBpPIDX/u6jSRCtQCByKl/VX++CatsKSz4taYdoJpB?=
 =?us-ascii?Q?c9r24WkV3O2RH5Aa36DG1mqD97v+ZTPLh2EYe0dJTfkNEhX0f/MWEHjc98BK?=
 =?us-ascii?Q?NnuKfFM/V72ZnH8NEbTadykjn11z2KWHClyYVFiP+08dv+4IIe3Twt64ssJV?=
 =?us-ascii?Q?QMxqoNskD3Av9uHA0Ucbny/2ieDPnDJbWoJEf0LZOX4DQb2yMGrUacTDk53B?=
 =?us-ascii?Q?5mRduguGJ2AIQnkJoL4C+6jZqLv2t+eBv0xjEMdvHbJ8dzJCKR5T9rNQ6ZqF?=
 =?us-ascii?Q?NVHXJeuh5HibQ5owxr6z744ecAEjYxih9b3iq5WZ2XOREWkZ46r0Zz5J5cJ8?=
 =?us-ascii?Q?Ss3j9rtv9+pNuGus3WyK/d1bmfn4Idp8lwVnui5zO1r62+5wWX8JJXvsTdW4?=
 =?us-ascii?Q?bsLyXSvG6WvzT2fd+1KjCXMQANjALCBEmSdmtCMr9tmDqtBCh7L6GmFjgmSs?=
 =?us-ascii?Q?doiF0ilnxXBSguR3ZgsdtGbupqJ8MIiMSwLkNzMzHfcPSFvQeOTimB/qDSi7?=
 =?us-ascii?Q?8xqqWw5O5Crs0XsMnPPmLN38YXrAcfpS6Q2kGgbCoGHy1LHFt66IUkci3Dko?=
 =?us-ascii?Q?G4NFlqyc1QmPulK3bajnzEYVpPgaBS0gWGe3gE1/nfi4pYX1LF2/qYF7kmLB?=
 =?us-ascii?Q?ZeuJh+izjC/pQiac1xfpxHuKMvutz2A7+kRln0KW7Y/yFdHj5RmuF2RJ+Ngc?=
 =?us-ascii?Q?Hn6Y4mXxnp7FMQtyVAmMImQ/3wBPa3JyCbcDWftQf8kmtCchLO5Dc7HBoZBj?=
 =?us-ascii?Q?1CdEyI8GKaZk2DCbo5VcUH+b/8AUdw/39f/ZpMwIzu7EZcDOflgZyNMFBzY7?=
 =?us-ascii?Q?d0ikIc6pyeDicYRgKrbSgeEYeeJwTksUeDpMAiveMJxXROSpnjf7jR0Ug9Od?=
 =?us-ascii?Q?+QymI/GnXHdL79lT70N757JPfcu8SgOV9IjbVtTCtnPTwjakqcJ+5O+mCfF/?=
 =?us-ascii?Q?JX3QNchJBG391elZ4m6R4tOMx/vUdcb4oXczI/0IZV2sxlLydmotia0AfZ1R?=
 =?us-ascii?Q?+tCBJEJQ+CBmBmBKrscE+WewB9K3UEEtkqOdEY+Q1jceYBHisoeaL3vwni/5?=
 =?us-ascii?Q?NBVn/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ejiWfgepQQ/h7buIYBx8P9ytZBARvgD/3tQRDG9dQi2cpMZjRVca7CmURCFXIAupYP3NlfTcliGj9Gvx9K2u883JWO4FAlxgup4W9lt4a6/k537mWRqpB7Ia1adn3suP/JTlcDLWim0wRneK0X8YF6bvyHXGxiJ4gzPxUptiDLDXHYKp0thM2m0TnoymlkhZmSymlFEW2TclZdJsDDDmZeEUUpn/ffQVNEUA6psCMdSjeSyVpfpult7fMNrgdcOkSRtO8eJX7d2HydrRa6/e8PoRPtHSGKxzv6JTicRJXvPgNLCRBWSc1CSFA+YbZYdshB/CiBU7/96HPWKCPeu9xZzw+DldfeJOf8GLjgr5AMhlzk926jfMFDRQIrB/2JyZEwDTHDwAKr1OD9ugIEVSCc6/KWXfzvljZLNJhg4sO1ff6AyGxjYXbA13ciiOaW0Yb+pZKw7b3J/jp4E0utoZT1byuRdc0PBdcaCQ3vtlD3fRoX5GLjfuFw9PWiwNuefkWV2xp+ZRukimTCD2c7jSmJpVVHZuYJAzUAGTXIvQfFFEZY7Hg5Nu1VW1WcXuh52+OVf/nCNKy28JspNX4PO+TUuk2TJXmkW4COFRaL2S5B4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0213d3-7368-4e88-5360-08dce8a8d6e6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 21:25:03.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUt7S//WfcdGZXI2fmfknyO4XLujlwtATczPbaug2BuvXuBYPT1NNcjRIWkMNGSjUHi8h+dCndMM+BeVKJ+5MqSNgYAK9FmpApkQ8mec6O8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_20,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090132
X-Proofpoint-GUID: AyHgLD0eQKBWOZnHlUOovaRvVZE8yHyB
X-Proofpoint-ORIG-GUID: AyHgLD0eQKBWOZnHlUOovaRvVZE8yHyB

On Wed, Oct 09, 2024 at 02:44:30PM +0800, Oliver Sang wrote:
[snip]
> >
> > I will look into this now, if I provide patches would you be able to test
> > them using the same boxes? It'd be much appreciated!
>
> sure! that's our pleasure!
>

Hi Oliver,

Thanks so much for this, could you give the below a try? I've not tried to
seriously test it locally yet, so it'd be good to set your test machines on
it.

If this doesn't help it suggests call stack/branching might be a thing here
in which case I have other approaches I can take before we have to
duplicate this code.

This patch is against the mm-unstable branch in Andrew's tree [0] but
hopefully should apply fine to Linus's too.

[0]:https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/

Thanks again!

Best, Lorenzo


----8<----
From 7eb4aa421b357668bc44405c58b0444abf44334a Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 9 Oct 2024 21:57:03 +0100
Subject: [PATCH] mm: explicitly enable an expand-only merge mode for brk()

Try to do less work on brk() to improve perf.
---
 mm/mmap.c |  1 +
 mm/vma.c  | 25 ++++++++++++++++---------
 mm/vma.h  | 11 +++++++++++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 02f7b45c3076..c2c68ef45a3b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1740,6 +1740,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma && vma->vm_end == addr) {
 		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));

+		vmg.mode = VMA_MERGE_MODE_EXPAND_ONLY;
 		vmg.prev = vma;
 		vma_iter_next_range(vmi);

diff --git a/mm/vma.c b/mm/vma.c
index 749c4881fd60..f525a0750c41 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -561,6 +561,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	unsigned long end = vmg->end;
 	pgoff_t pgoff = vmg->pgoff;
 	pgoff_t pglen = PHYS_PFN(end - start);
+	bool expand_only = vmg_mode_expand_only(vmg);
 	bool can_merge_left, can_merge_right;

 	mmap_assert_write_locked(vmg->mm);
@@ -575,7 +576,7 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		return NULL;

 	can_merge_left = can_vma_merge_left(vmg);
-	can_merge_right = can_vma_merge_right(vmg, can_merge_left);
+	can_merge_right = !expand_only && can_vma_merge_right(vmg, can_merge_left);

 	/* If we can merge with the next VMA, adjust vmg accordingly. */
 	if (can_merge_right) {
@@ -603,13 +604,18 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		return vmg->vma;
 	}

-	/* If expansion failed, reset state. Allows us to retry merge later. */
-	vmg->vma = NULL;
-	vmg->start = start;
-	vmg->end = end;
-	vmg->pgoff = pgoff;
-	if (vmg->vma == prev)
-		vma_iter_set(vmg->vmi, start);
+	/*
+	 * Unless in expand only case and expansion failed, reset state.
+	 * Allows us to retry merge later.
+	 */
+	if (!expand_only) {
+		vmg->vma = NULL;
+		vmg->start = start;
+		vmg->end = end;
+		vmg->pgoff = pgoff;
+		if (vmg->vma == prev)
+			vma_iter_set(vmg->vmi, start);
+	}

 	return NULL;
 }
@@ -641,7 +647,8 @@ int vma_expand(struct vma_merge_struct *vmg)
 	mmap_assert_write_locked(vmg->mm);

 	vma_start_write(vma);
-	if (next && (vma != next) && (vmg->end == next->vm_end)) {
+	if (!vmg_mode_expand_only(vmg) && next &&
+	    (vma != next) && (vmg->end == next->vm_end)) {
 		int ret;

 		remove_next = true;
diff --git a/mm/vma.h b/mm/vma.h
index 82354fe5edd0..14224b36a979 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -52,6 +52,11 @@ struct vma_munmap_struct {
 	unsigned long data_vm;
 };

+enum vma_merge_mode {
+	VMA_MERGE_MODE_NORMAL,
+	VMA_MERGE_MODE_EXPAND_ONLY,
+};
+
 enum vma_merge_state {
 	VMA_MERGE_START,
 	VMA_MERGE_ERROR_NOMEM,
@@ -75,9 +80,15 @@ struct vma_merge_struct {
 	struct mempolicy *policy;
 	struct vm_userfaultfd_ctx uffd_ctx;
 	struct anon_vma_name *anon_name;
+	enum vma_merge_mode mode;
 	enum vma_merge_state state;
 };

+static inline bool vmg_mode_expand_only(struct vma_merge_struct *vmg)
+{
+	return vmg->mode == VMA_MERGE_MODE_EXPAND_ONLY;
+}
+
 static inline bool vmg_nomem(struct vma_merge_struct *vmg)
 {
 	return vmg->state == VMA_MERGE_ERROR_NOMEM;
--
2.46.2

