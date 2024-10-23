Return-Path: <linux-kernel+bounces-378167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EA39ACC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF412841B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D211BD039;
	Wed, 23 Oct 2024 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dLS1cOEg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D2AulT9a"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD239FC1
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693600; cv=fail; b=c09JHxcB6w6ZVzH50LobxGimoONlJ+cQrrd9x9Kugci0Qs46sELtdQh/Uyq9bDEiC2xtg4JwMty2kAb7eDBTeeTCZ4gmIs3tKArqn0c8MYYVkcp9w1XtSB/85ePUWFlsmiOLalfbIruYgzeTr3CVYc4/cdy4cdAaYc7iV8q/vmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693600; c=relaxed/simple;
	bh=Xves6otuj4fT9EGWLoIgzPb2N0THI0sk899YXycAfXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=urvfPj8PlDoK9y7OiewhhBe8ieuhTxWkbh/Wg5Rd5WHR6U/0MtmwFZ3FxVxBgZWZCfANiAKZ4Cu/3GczrqtLdFuysufRrBn+9lE55J2hm2GLfYTLU2n1VN3fVTnjEkC9tS0M42oJKtCjWAyrAc3Nx61kPfuhmtK6BN8fKjjWXyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dLS1cOEg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D2AulT9a; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQWXV017377;
	Wed, 23 Oct 2024 14:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=C4+HHrzxOQtNH7W1Xt
	UdE6gmNINvRnvEI09BUjlNnQs=; b=dLS1cOEggWMHUVkqyjR7CpbNeUvje/bWjU
	5/uKmGv5mVs+JROipfICWvsYB9YROX/7D10ypllWfN/uMJ/Y6yXoCyDvDXn5XYAi
	Q5Tr8/alVj4ijgW2yCWx8yFWkIzh0ziJ8bh/7Qc40Tifue+yGjNijJfN2Pezmil3
	MF5k4tjt5VMkP1EES4wSt7PqPSTBh0rD/bvJUxIA3FeDCG0gTGZmWdqe2p+rVtyv
	mHmGBrR/i6Cpp/3gqnE2Iumq8piq+KN92L0n+gsccpMAWgJruJuiTfRiSDxBceYJ
	CHT2RphaB6B2G+A94Q+1acHzyMmwCbjdO9vBBQnh/pzw564+63WQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5458cuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:26:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NCvb1T030906;
	Wed, 23 Oct 2024 14:26:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh1kn1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:26:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+VhWVOriWsgQ7uWhNy9SLKdMT5y4iXa38e3H9x31/1+bEXCdDUAnl1mmYr6I7WzWQl+1+HICX0/znimSwSx4xVPJKI9nHWK3awD+uctsM9a5gCw8lTagOKX3zuH+B7fK6ic/nZudSmDRUDVvqRfaGdyTIJi5U3vae8Bb8T+HxzRSFfM7Rmt+74T0dH3QDK1IMqYaXOjXL2GT+eIHse29rreOn/4Tl6gNUomXo3Hu4JwvjjEUyXdKGWjLWQK10OiDnpprFr6EbHL7rFiQPRzPwH70YoXDVSkG+TT1XY1izT5DCoNjtS3DcuDcKB17x/zmxlS3bVXoMNriP+L7yCpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4+HHrzxOQtNH7W1XtUdE6gmNINvRnvEI09BUjlNnQs=;
 b=kLhKLe1OrpYo3Y3qLDdoRtPXVf0pKSXkkcqCKDLz+hEvLEVQN+zi3A5xXzlfi4ACZbUQ85mfchen3ybyxxrP2e7ctq6ddHLVUshcexPhrAjkoclHrhqf0+fY57eI46f0PTt1C72rTyFQIghScdF+QjUOs6/YfFG/V2ksbk2C6e097dvV0qTlJFUs9jTI9JHppLGAlxcxJsfg3qj82CJGSRFkMBrWc1eEiJJgt26ftd989M7eYxy6Ps39ZJHXPKKF/xQ+zm0KI6QW2klOgfBrC9lamDsZ3Gkk+02GoV9H2AZQ4+FlR3/mfOYh74MnuPeJYViKUapxDpDXhKYZmsi7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4+HHrzxOQtNH7W1XtUdE6gmNINvRnvEI09BUjlNnQs=;
 b=D2AulT9a9p+YlndGjhTbBecgRSh/cmEM5UZyqh84sc+a9UYoGBIZy7TbIkM2T0fgmF6aqGgm+f2EsjQMgzIaQVuYKvoYPJFE5psA65EEQOQziN8gxT7/TW19OTUbao5bgZ32Qv2BYOAzZW6D0wm50NfTvzM+rVE/GHIthyMSKUs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7807.namprd10.prod.outlook.com (2603:10b6:610:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Wed, 23 Oct
 2024 14:26:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 14:26:24 +0000
Date: Wed, 23 Oct 2024 10:26:21 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 2/8] mm: unconditionally close VMAs on error
Message-ID: <ce452qkevarrw4q3rlsvasw6srur7rwa7iyc443vxsvq3wsf6v@5gy23ibfxa4k>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <9a84bad9fdebbdb0adca2b5b43ed63afceb5bacc.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a84bad9fdebbdb0adca2b5b43ed63afceb5bacc.1729628198.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YTBP288CA0025.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 931d8018-fc79-48f5-37bb-08dcf36eabfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+lwzH15vWI0nyKUzGjcqOq2gAG6OPWvo07bce402e3qAHOA4JBU25LIGvWVe?=
 =?us-ascii?Q?14LeaDif3cN0YVI+b6MYiGszW1ugjmjdx2rDcek+CkbFC7yjPLrfxCm6l7Cj?=
 =?us-ascii?Q?t+oKCfaXhqH6nInChaMt8Khe44TtVcoWWrCTjDWIKl+JLRd4p50KHZaRPNuQ?=
 =?us-ascii?Q?4OGMxqvbHOWJvZdXDSpkL4imwvPsLFUcnDqcQgIeD89LdMle7xC0D1XDIsel?=
 =?us-ascii?Q?QWb7zlkoK18GowSEbd/L0CZD+a3SfptNE9+RYHUbtwc2qYz6VZ0iuLO7qk6x?=
 =?us-ascii?Q?3nJFpdwobh37U7kTRcl/Zw9OEbSevjaOvBKIsCKnaXRptwomHuaa4wTTYjtp?=
 =?us-ascii?Q?clEJ53wyp9HGJ7eBYZtwcjj7yyteMdiWoIbPWG/6R2brf6Q7zR8hQB+oURMr?=
 =?us-ascii?Q?umoqHYKpPj67BPimoffVhUpsskTsvjel+aW+BfdO6p10Qr/xOrQ6fgXrUjTd?=
 =?us-ascii?Q?BTWeP5XutM/8pwT1tca5tgbQCdNwZ4jV1vJvNgJDgGS8E+7wg8QfUHeZuM+G?=
 =?us-ascii?Q?faacbsIlnml8yK37SM7N+/rhNGPki1C33gEoPEX3KnAiVDGi2wTAKWhMAPjj?=
 =?us-ascii?Q?grYX3u26hA3s+/1a4vlmfwGmKD7NfbFu9cauDfFsF9zu93PtvFvQs538UhqJ?=
 =?us-ascii?Q?b8zdYClz5g0RrJrw4G2Ec5DDO40V5xtcbxngwtNwvU0Htit8idz3qT/qzIan?=
 =?us-ascii?Q?sI/hdHsdRNrDdWYv3AbmXEKl7XvZhXnA1+oYfjtpZWd5TbG5CQazIIaneREw?=
 =?us-ascii?Q?ZpC/tv/dbliIygMHcTBAcD7nwLhJYusP+29dT6vk0/eD3E8HwUlpTR47FfHM?=
 =?us-ascii?Q?bC6O7EMZsjH0l+8vCvbswkHJOKoBRHfCEPlKi0/ujtdqPh2sDIZFzGY5XV8l?=
 =?us-ascii?Q?BDGnHm3h3F52toh+TLScU0NqbO3ofoRjY88FR1gsmRQuH0kn3KpK1lV2QQRH?=
 =?us-ascii?Q?5T2gtTxo+momZwNSUqeCtszLJFkkr1R2OCNIexv6m8pMDEXKd5FYkJ7FRgDX?=
 =?us-ascii?Q?1Kz1a7MItxGDm9wdrfppaurdq2HVYDFiB1mkjk4ZtjgyqgVLaqVz1x3/OufW?=
 =?us-ascii?Q?LaQoP7y9igx5L5sfznsq1TIWRaZgMfprQkzizUz3OY8drF+ppgN6mNy18mLz?=
 =?us-ascii?Q?IfAWYAqLIYg5djBHKUfFVjKhToT0C+ALWsM7XKmabpmFg6iGtbQURd5AGI+n?=
 =?us-ascii?Q?OJmJaZxGtDl+XCugHnGwtQaDewpPfNekE3nOK3vCtEQ7rP1+kF3kz9YW7NVy?=
 =?us-ascii?Q?X5LnapehDlwJuswnrwqsmQhHmhnfzaDUbZZ4fgqEvjtCcrDMVUBFbPu24xX7?=
 =?us-ascii?Q?GWCWF5j1JRDk3bWmCesDOMKu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ru7Yy7lwJcSYQPsOskvEQ8dcG4PFB43Rj3it6sXqi4xORLwk205OsVmB5sx?=
 =?us-ascii?Q?a9fGbK0WMirmrjLbMFRdeX8ZSrMwVcVJAUx620aUdpCHXJIT3kaQNH4P41Dj?=
 =?us-ascii?Q?b2Tj8//O8DJGI4T9F4d/lhYpvaH7yi8W8iTfmVRHK9yOzUce7F0bbuQsll54?=
 =?us-ascii?Q?KQsQM0h06wo5iLxL85DISMGEBn5c/BKixnlX686HgzBFBd/2CiZSFMYaxf/C?=
 =?us-ascii?Q?tMCHApDAhj0ckSogr6K6er5PY5KPbBNPVrbSdVM4gHdEZbZ/2yNHu9ICKA+v?=
 =?us-ascii?Q?bND321fMx0XBbx7EQdJIvadprZAYGnhYOv4AVkgOAydvxMikXDwrRJC5HWmQ?=
 =?us-ascii?Q?jGK/1l9ShTZZYiw7k3KZQgj9/AOzKn039wRIAfCD+aDGQGY6mLihrAP3cZ8s?=
 =?us-ascii?Q?vvHXu/RtDhdFGqCOXjikVmVxzExprZy1rsRfh11JK5e6ZR/6P8bv7RwxXpZD?=
 =?us-ascii?Q?wNOljkojQNyB3L19j4U3i/EBhh8HC4mTwwBsEf9lvPAddy4x/HdwWMOYg+sL?=
 =?us-ascii?Q?FZdm4Lz8vGHowbp9m/FSwmsf8knYtwBPS3YirdHrCISXqLZhz6bV+uPe+awm?=
 =?us-ascii?Q?0WiaNDUOITZTbjwYWuvThEWqvEU7Q3Qw19GI8OJMva6aKQwFXlX0g3UABYlj?=
 =?us-ascii?Q?feYKpbv+b63/OGe1gY1TWJFUC8E9yucg/4j3588RSVA2D0fY9hs3E8uaUtxj?=
 =?us-ascii?Q?4buu0hQmzwjtD8xexSbKGtBsBVSqrVuGB2ZtIwdbetw1T0FTgb8RSJ57toSi?=
 =?us-ascii?Q?YC26ZsFFealam1055Jj1dU/T7/6hH89txVJED3TJuAd0QTEfSkbrRTm2A0yk?=
 =?us-ascii?Q?/lazfnv9cZtG5Hop8fQqO2yQTodjbJV9vjOSmtlhi6DvTO+VNmhodlJH0e9H?=
 =?us-ascii?Q?GEOODCpHOXaGr31GjlZ7xBDP49kbm5VzgMmDXWsgt58zq3N1AtslONqf2spm?=
 =?us-ascii?Q?Y1EFasK6+NPdgD0bHgK0oCnmTFtmiq7yM8tHmnrx5bTBmOdoGPp32BpywMM7?=
 =?us-ascii?Q?Mh+APlfkevKYtA8AZQOVJLGITd2vT7bkIqRhnphT67GQC7WwqKj+RZxCxz6e?=
 =?us-ascii?Q?ZQY8VeLvGvnck8x4oswhgDSKEWegbRRLSJtroVJGUG/MslWWCXvcN6ZEyBFA?=
 =?us-ascii?Q?wBx8n3FXAgUIYuQqFURYPWdRwLi+DRuMcfLvN5RcuvBMmear5jXDjnMpwRTR?=
 =?us-ascii?Q?ugoBfYk0A6C2RgQ7RUlxtKzJy1Mpge6WBAXKkzWEEaxGO1bvemsTaK4Vl++F?=
 =?us-ascii?Q?/Yt1oZNtKCnNrzsEaeVYwGIaZXo8NvEFlp8Y+XUcdYhO1/lOxYIY2du6L5Ah?=
 =?us-ascii?Q?xG0UUKWXJnzfQz1VPsiDl24rW1W391YPizApt68Hms9i0X53v89KFSeaJe4o?=
 =?us-ascii?Q?dsR//Q2Bxw28fF49WnYQwJTgXIwcBd44nrs/RCtuofN06W+5TuqfZi0wrzaP?=
 =?us-ascii?Q?yg/M4diu0rfHiprC/MVBHoj1PUljM37JRB5dPyzdOwsx3XKVk687l0mbXtva?=
 =?us-ascii?Q?V4qmbv22jPfoMDr3gJvWh3L8YaDBeAwGZ/8RUNLS+cAKjaApssSehP4eqiMW?=
 =?us-ascii?Q?+I2nsUGAn7ywWhJzJmPgmlovJJ5Qk+VCZcgb72aTTXjPP7+fBvo+8c5eKmvX?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	v+ChsMoUnpfML1fyLJPYRRs/ZLRMfo2rl4UA3vf4Uce09TR+yyrz17KqP1ViO0wCZChO1+vOSx7DwePpBJl23lpzwzxMqjSsUAhayMjrl2ZY2Pp+cY/qK9/0a+5KUi07yeuLI7fDC41/PJmEk+ZQUBjOqD7lpCgWiJvjwiepDeVJbAgPxwyVIsQ084axMcdHJvVeCgYxHX+DR34+NTVPjcQZZTGVCOKUqAiVWjqDsWf3f5OmZWBaEH94vZoWpROvLG0N6a073PXVg5gaj+ZX7Tx/Ys8IU3nOSdShfZEkTv5jgDfBbO5sTsHASdBTcSy4+VnpF0JMSEfeLMd71Xquwe7an878WnqpRPDzv3P7TEAoaCVfrvJP/QWDTeh0ZrlBlZvy6vZggFMTRPmq9WP/z/kZXyHLe60uQxJVtgRsuI/g6fIHVeetZaxkQCIdOX7WP7+nzBxXuYU0CebibuqZQf/2tEZVZT6xvrTKoXu0j02hOBSSEf+QYltyWkfYqxa59lzto67WOIKudCANOtqF5v0JFHZRELa/SSJK27ai4zLiIvlFvfiWjKWsxzPAGEB0C7vQNxz8FogH3CRoGjO8icr7JHMasBH6U1jM5wCXLt8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931d8018-fc79-48f5-37bb-08dcf36eabfc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:26:23.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSooEvliDB06nMOsm5KLYYjjCt1kATtGJ8bnklePE7RHUaD59+etubZ+ZHAEaUXo/1lDLuIOxFvl5K7xt8cPsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_12,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230087
X-Proofpoint-ORIG-GUID: HKcuFRr0PyxZ2ScExdwgkVOL4rBGjwyX
X-Proofpoint-GUID: HKcuFRr0PyxZ2ScExdwgkVOL4rBGjwyX

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241022 16:41]:
> Incorrect invocation of VMA callbacks when the VMA is no longer in a
> consistent state is bug prone and risky to perform.
> 
> With regards to the important vm_ops->close() callback We have gone to
> great lengths to try to track whether or not we ought to close VMAs.
> 
> Rather than doing so and risking making a mistake somewhere, instead
> unconditionally close and reset vma->vm_ops to an empty dummy operations
> set with a NULL .close operator.
> 
> We introduce a new function to do so - vma_close() - and simplify existing
> vms logic which tracked whether we needed to close or not.
> 
> This simplifies the logic, avoids incorrect double-calling of the .close()
> callback and allows us to update error paths to simply call vma_close()
> unconditionally - making VMA closure idempotent.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/internal.h | 17 +++++++++++++++++
>  mm/mmap.c     |  5 ++---
>  mm/nommu.c    |  3 +--
>  mm/vma.c      | 14 +++++---------
>  mm/vma.h      |  4 +---
>  5 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index af032e76dfd4..3a45cc592fd0 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -135,6 +135,23 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
>  	return err;
>  }
> 
> +/*
> + * Unconditionally close the VMA if it has a close hook and prevent hooks from
> + * being invoked after close. VMA hooks are mutated.
> + */
> +static inline void vma_close(struct vm_area_struct *vma)
> +{
> +	if (vma->vm_ops && vma->vm_ops->close) {
> +		vma->vm_ops->close(vma);
> +
> +		/*
> +		 * The mapping is in an inconsistent state, and no further hooks
> +		 * may be invoked upon it.
> +		 */
> +		vma->vm_ops = &vma_dummy_vm_ops;
> +	}
> +}
> +
>  #ifdef CONFIG_MMU
> 
>  /* Flags for folio_pte_batch(). */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 10f4ccaf491b..d55c58e99a54 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1576,8 +1576,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	return addr;
> 
>  close_and_free_vma:
> -	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
> -		vma->vm_ops->close(vma);
> +	vma_close(vma);
> 
>  	if (file || vma->vm_file) {
>  unmap_and_free_vma:
> @@ -1937,7 +1936,7 @@ void exit_mmap(struct mm_struct *mm)
>  	do {
>  		if (vma->vm_flags & VM_ACCOUNT)
>  			nr_accounted += vma_pages(vma);
> -		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
> +		remove_vma(vma, /* unreachable = */ true);
>  		count++;
>  		cond_resched();
>  		vma = vma_next(&vmi);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index f9ccc02458ec..635d028d647b 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -589,8 +589,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
>   */
>  static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
> -	if (vma->vm_ops && vma->vm_ops->close)
> -		vma->vm_ops->close(vma);
> +	vma_close(vma);
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
>  	put_nommu_region(vma->vm_region);
> diff --git a/mm/vma.c b/mm/vma.c
> index 3c5a80876725..bb7cfa2dc282 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -323,11 +323,10 @@ static bool can_vma_merge_right(struct vma_merge_struct *vmg,
>  /*
>   * Close a vm structure and free it.
>   */
> -void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
> +void remove_vma(struct vm_area_struct *vma, bool unreachable)
>  {
>  	might_sleep();
> -	if (!closed && vma->vm_ops && vma->vm_ops->close)
> -		vma->vm_ops->close(vma);
> +	vma_close(vma);
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
>  	mpol_put(vma_policy(vma));
> @@ -1115,9 +1114,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
>  	vms_clear_ptes(vms, mas_detach, true);
>  	mas_set(mas_detach, 0);
>  	mas_for_each(mas_detach, vma, ULONG_MAX)
> -		if (vma->vm_ops && vma->vm_ops->close)
> -			vma->vm_ops->close(vma);
> -	vms->closed_vm_ops = true;
> +		vma_close(vma);
>  }
> 
>  /*
> @@ -1160,7 +1157,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	/* Remove and clean up vmas */
>  	mas_set(mas_detach, 0);
>  	mas_for_each(mas_detach, vma, ULONG_MAX)
> -		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
> +		remove_vma(vma, /* unreachable = */ false);
> 
>  	vm_unacct_memory(vms->nr_accounted);
>  	validate_mm(mm);
> @@ -1684,8 +1681,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  	return new_vma;
> 
>  out_vma_link:
> -	if (new_vma->vm_ops && new_vma->vm_ops->close)
> -		new_vma->vm_ops->close(new_vma);
> +	vma_close(new_vma);
> 
>  	if (new_vma->vm_file)
>  		fput(new_vma->vm_file);
> diff --git a/mm/vma.h b/mm/vma.h
> index 55457cb68200..75558b5e9c8c 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -42,7 +42,6 @@ struct vma_munmap_struct {
>  	int vma_count;                  /* Number of vmas that will be removed */
>  	bool unlock;                    /* Unlock after the munmap */
>  	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
> -	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
>  	/* 1 byte hole */
>  	unsigned long nr_pages;         /* Number of pages being removed */
>  	unsigned long locked_vm;        /* Number of locked pages */
> @@ -198,7 +197,6 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  	vms->unmap_start = FIRST_USER_ADDRESS;
>  	vms->unmap_end = USER_PGTABLES_CEILING;
>  	vms->clear_ptes = false;
> -	vms->closed_vm_ops = false;
>  }
>  #endif
> 
> @@ -269,7 +267,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  		  unsigned long start, size_t len, struct list_head *uf,
>  		  bool unlock);
> 
> -void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
> +void remove_vma(struct vm_area_struct *vma, bool unreachable);
> 
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
> --
> 2.47.0

