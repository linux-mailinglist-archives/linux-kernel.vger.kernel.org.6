Return-Path: <linux-kernel+bounces-378156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A79ACC27
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50FC3B21F07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66CB1B85E1;
	Wed, 23 Oct 2024 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dl3MwHIB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fgiATHQb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378615B0E2
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693286; cv=fail; b=uVjYsnztsztgESxpYY+DOHfvJMhRyj6l/aQO5KSaJuPzJM/Cgz7CnfkfV51Myx5LNkGe92e0+/DxcoEPFdZlRcFv5j49KWzqYx0XtAydim66+Ny26lL4wD139GGmW3ewQyTuHCy/lNweC/NzR+JcQ23HwKG6TdFytE6odUi4FW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693286; c=relaxed/simple;
	bh=5I9ImGxgX0Ltd+v+GcfF337VVtCYdYeBQm+MDovTZz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TwhpnjiTnLsimrOSpf4he2i3P7tjmWWP0D2s+NL88iU3Oy4u7S0Ml18DK79CZryUtY/STx6CnUQr0rBULpKtxVG32QNKDhdp1xg6u/LZzDgiad6y1AN8QDOV9n1+xfcVFEzn4Xh0iUw50sOhQp6FL5Yc8TsESpvLYCVdrDirAjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dl3MwHIB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fgiATHQb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBQj0X030913;
	Wed, 23 Oct 2024 14:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Q0zHbup28wzgSJlKAX
	T4ziF4Ca++U+XGEnuEyHCAw08=; b=dl3MwHIBWu+k1y55NL3redMWvXf2L2U9Vp
	dSwzvIk87ub6XQwZMMq7oBQTv9XKQcjZbhwYJuLLMO2Vpebl5FR06gS1hyAGqQOn
	0ZqKD8rHZhlfb1ELneIpT6IjHOYtxu3MrJ4P/Hm1GYIrV4Y7V6Jk5C7n/7AYoHqN
	a7U/x9wOV0/ptCoxAkNEhnTqNhU7RjI1gI4+DjIbx/yR8hiB7tL4BICR56968He8
	MiT/WdmuOEpFX4yay2uHH22+VquxO9TvPU4cxEHwYSo3RtVOAREoYa7FPc485JRW
	zQsyb+oR5MbcqZfaQ73/d/T7hutbfvKsD2KAieUQvOT8GMQILb/Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v07ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:21:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NE9TmK036009;
	Wed, 23 Oct 2024 14:21:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2kdad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 14:21:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rg47t57vs6fSEOGNsM6twIinpZe8Ax7TekIiK4ii1h9fy96oo03vCibfc54uHZeA/PYwNPKFfyWfJrgyJQu43QAVap1HUBAbyZ23XPb88eGyaQ4bDD17otbmDAv6vHV/5Xwx7ZY/c/QWLTYNSSVFXgLs7cQoVpbOWxxsePL7iDsuQZStjq5fEI8hiynomkDbcLIvV1ps/YsddNzf0PYoIvD0xLoFeVUGxPTd4/T4OaNr48htCz69lL8kdSxvrY19YtqjxLKT42mehD+83Y6a691erVb7b9PPRyvhskxC2gAmMkSfvpiBDN9/0b6pSfCSAUyZoRG58nerlM67/VE5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0zHbup28wzgSJlKAXT4ziF4Ca++U+XGEnuEyHCAw08=;
 b=toQKNVfvIfnhRh84DkHwlKWeSkRnb+JTykLl8oZTh52wxC0vG97umIjNQuPE8mZ78pnldMjOLPNpNaC4npuY6qMQ8nc6RLjLJ2qr3WagCh6FS+oYQghQB+ApcHJFi58pRvvWziRHQiJdUKvTsqINxnHYBn0aOVqJEsQ1GL9s0KuLS5p/QFQ9Y/iu0FNilUhUMBeeA1vDGqWv4NA43VxvAgFGmGWfAYOR1XR4hSYZPpzXi1yJejygoIWkFj+MQjb/85C+dHGpO969juLupLT22h9qcOOmjOGUM0e5Q80ueHX0GJTsg7w5o5GzGff+OD+RpWhL2f/6Cg+iAkjHP30MRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0zHbup28wzgSJlKAXT4ziF4Ca++U+XGEnuEyHCAw08=;
 b=fgiATHQbA9ra8frL+e3NIcpDHtu5q/LY142XajOCoqcJrUrKV3gvXEAiI2izo3uXUYTR9JS6JD2hhc3kZbnMMX3u+v1UpPYSTWvsMn9Zr2LkLUgdoq6xgVogGFoTwL2hotfOazOpUx//op54qb7dn/i+Ir5wHR2tywkxTxTgSyg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB7115.namprd10.prod.outlook.com (2603:10b6:208:3f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 14:20:52 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 14:20:52 +0000
Date: Wed, 23 Oct 2024 10:20:50 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 4/8] mm: resolve faulty mmap_region() error
 path behaviour
Message-ID: <73wl5i2vmh7fckairzw5j5so2fjg6p3vvxhixnpqh3zc64o7ys@yidsexyjkrs6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <3bc3ef7520eed73472f7ffdce044f2e94f809b32.1729628198.git.lorenzo.stoakes@oracle.com>
 <e2bca69d-5266-462c-b770-707ce987473e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2bca69d-5266-462c-b770-707ce987473e@suse.cz>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f54762a-520c-4844-1246-08dcf36de64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mjMQBPDje63pUPgDFk3q1M4r6o7Ylgr0cjuIvRKEel0RHM7dm0bdol0H/bgq?=
 =?us-ascii?Q?wrRvaEcjQomob64WfXBLkAtbUxbhX0NVYOEK3dJVwJ4cPNsqy+16qthnDGoo?=
 =?us-ascii?Q?pHN0u76oUAqh7OyoLn/dbcKQkN96M6jmagbcxr9wPq3MLpNDATitLDHDcP9x?=
 =?us-ascii?Q?qP4QIYOaULH6V+AfHktW/k6h35a4jfjaJLqWPyIqGN72zg+YeO+0/bc/NaW0?=
 =?us-ascii?Q?fB44yzxrsNSTpXu4IjsvzoWW1Bc4ZGGv564euXhTCwzpSk+TUqkdjmrE4c+a?=
 =?us-ascii?Q?OmTrEIjK8mR0G49dZWLwMJ3vPC86a4rfwkrNoG4rVoomeZMSC0fez9PfSP/k?=
 =?us-ascii?Q?gIZG1J7BafPtRcsg5osJetoxkLu/u4kAuAaFhCA2B1nlqCORDZypj5AS/t7S?=
 =?us-ascii?Q?xwkzS28/oISQw3mF/Q6UqQhs+lOsYZqpPX2LtZYWEDOz/H7ro6/psIpZZra/?=
 =?us-ascii?Q?4dfdiH5CcDxWb8JoxQPWwhlAToOA4COaLanZrVjtxBmdHDvYLzXhRvNmCwpe?=
 =?us-ascii?Q?lKbyGPd0/V3z2j/5xvim4bSz+q66AFRIFulsxQjX2NpcQAY4ZYyskLOKkALq?=
 =?us-ascii?Q?EoStqAJhMSQJ6ZZGun4WPw5sYiEh9TF5U/0CqgKq7LR2qs5bpWFuTeJacM0h?=
 =?us-ascii?Q?zyLVAgKTiYKoThzu7C4y6I08rsp1j2P0kXgO8oGarSXw1sMoyCNVOF7hrQU4?=
 =?us-ascii?Q?xj0CEoGe/1s66y8MXnmWhits2KDka0zj7Y/gAZGBnxK7n6kV/Pa6Kq1mZyXo?=
 =?us-ascii?Q?zxZWtL2ZKsc1SvGUb/shYTMZ6tP4ZZWmLo09kgzOYAChAsLJD2IjExyRQuhV?=
 =?us-ascii?Q?aQPIXrnhibzfI5pPHXsRcM09/dpbbCPzyZ6SKEwsBXOrHxeq63YUA1TPj0j2?=
 =?us-ascii?Q?y5jwFbeEvQ1Wb3nNwbBqblQCJSm8tZRHh3+TP+J0Z9Q/qY+rVylaXAg7bk5s?=
 =?us-ascii?Q?PFcZcHGkP/R3AkG/AQ9bIiyx5LZS56493JbBH4ekYv8VeCKxzT3PVZqebBRj?=
 =?us-ascii?Q?pxxH/RwMhcT3iqDK0BOfPBTxMnSQzJ8+/VtZ/bK5AsrNaPQpjIVdUsRlxPO2?=
 =?us-ascii?Q?OyqLr4A9fgahR41b6cTz/AxgxV+dKXTJxl/4G6bPayM0j5hjzrZYPd/KBmmW?=
 =?us-ascii?Q?rKZpWhCMOqz/ZRZrqKfQmre1HC0Y/TdnBkunj5wsmkWkBZFZai1MdJGBzeoR?=
 =?us-ascii?Q?iBlquJ32zWvw9xRvC3GI+/MA8ethRWSiu2CDsYWGP4L+gYuadVvGC0IG4AP+?=
 =?us-ascii?Q?l7/JOaL/oITgL0WqqReEe0kMOShL4Xgrw8ueo4jVTE7QhTo2MdziRulJeZ7O?=
 =?us-ascii?Q?4ZSpZT9boxaI52ypNOBo8OrH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bP+qetepmVulgiGe3b9d7OGdXy8nMsgMK4xApQMM8QpPwokW4PwWutOghwja?=
 =?us-ascii?Q?dETgN7fgqqb91anDzyxU5Wfr1j2fHLrKBB1h0LW9kOcQxdP2PTIhEi6kmzI2?=
 =?us-ascii?Q?eseoVLcsVwTt+BcmIWexW7vJleZ6kKr8RamH8Hc9BWXcMkxQNtzqIb+t3qGU?=
 =?us-ascii?Q?ohNPiZzzjdvot8SOJ20vk1dWyOCSrptCaRAjxZhys8sk8fCLfC+l8H2msU4b?=
 =?us-ascii?Q?DPwMxNsVz5ZQunU+VaI9VV673xk4kOkRJKLae602TWG3G+bkNhsmTnQvVcm+?=
 =?us-ascii?Q?iP1LrYLD7OJ7QT7yef6Flc4my4lYQIOLii5eSMU32LCvGnzRPs4DU/k47TNt?=
 =?us-ascii?Q?d9ce4XWmX0CaHTfVgA3AHuiT1GIM68HGuvDcI2Nwe+L7yw7tECusZWEBYRiS?=
 =?us-ascii?Q?pQmkTUxfNP0+cRDtImjK1E8PEhLc/nlUfeMHQwqmm1bedohovlFNJN/vxLV4?=
 =?us-ascii?Q?MuED+vObqOJvMSNtkLs93wPf+lREhrjbBcgFf1PRM6pTyrR5vav/ANQHLcR+?=
 =?us-ascii?Q?ZTtmuo1BOarSG7Qm2O4Zjmbe7g32IMx40w58o//i4C/RuJtSiNLq87y5k6M7?=
 =?us-ascii?Q?Bhesa+c9GgOUN6wmg4Qfl0yDyw6yycCu2mSwhI+310Hc249/LvuI4GZBQGlD?=
 =?us-ascii?Q?QonNCjOUe5PP6Aj6+ACPHNmUpQ808NLRFCyQ4Z6hR3Yt7HJzlNgjKSYKW7wV?=
 =?us-ascii?Q?hT3hijTsbyEZqwlsA+VT9hfVgGcA4AILLaVbnLtRjDd+rssx2WocTt4Jyt/x?=
 =?us-ascii?Q?SqmLEy8V431M+2pY3Rqr/S/FA+qhQj5Q7Zi3TEWB/qYcl5Uyh9Ku+Txr83ZF?=
 =?us-ascii?Q?f0CgGoCVkghU/a6S4WO/olbIEmVR3ncpps5Veu3Pwv3UfWjSPT4Wa4z5w9ib?=
 =?us-ascii?Q?TvMVK9vpIWIbTyxOPo9br62kEzdCUcCTqXsRg1VLcp78G6M3Bf56ov87ULO0?=
 =?us-ascii?Q?v/NFGaJ3Fwj9CGM+yIBVtuN439eK+InNg3V2DnRl5R2ZfouCJVSqJOGoG0nS?=
 =?us-ascii?Q?8lM3Gqw28LJf0H9op3vrDcN49aX+TOf/YVi+H7c9cJNxtPXwHyT+Jdqqv64N?=
 =?us-ascii?Q?bpHxkQR9szpQhiWmEzcDvuqlXCX+UL1bg0Pg/PK1rJmJOamARug566ebowBL?=
 =?us-ascii?Q?eMTIwjgO1Ym6+qJGT3mSuERpWT2PG2xQVUUHY0/lfVnqnl+NzHSk6M+BKSrO?=
 =?us-ascii?Q?0dAu0caFmtqEiBo9aguXFJaso76M6c9W3uedX+g/IMopU+ul/P+M0yFuZMle?=
 =?us-ascii?Q?r6u+R6rSM16Ce5Bvu5GlYQBlj7IBFYJZ6wzgYoBI69RBKRAkOUKU88psh6p7?=
 =?us-ascii?Q?zk5OnrscJR+t8YWFAiBsKGZJ6H7BSVDZcFnn75utvFJF++lnX8ef14vbDQUz?=
 =?us-ascii?Q?6NBGXdeVu7+kKSRaDM0xJfJFV9LQgR4lH6D7SlUdoTKQ2IgthMsNxEujPSL7?=
 =?us-ascii?Q?cPdpM5pVg8fVE6+gyrwxK7lG56uR/XiS6ffB0tVtyuu8m4VzNfh9uDpN114i?=
 =?us-ascii?Q?xFztWk0WiVnfPXDrZ6bRuJkTA3QZqb9oBUtUg8QDKrg1l3+rGYxUZfJl45nS?=
 =?us-ascii?Q?I0tn5OCqmH176S4ZoZu0AHYc56MOn+wccAFctXda?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w3jwlciQ/BngkeuDoxBOtAhU1qO9lJmgjQr2ZGJENQaWzTsVbgl6fMpPfRLmzRDua9pfq+4JmW/DA8daXvaOUFKg5ee4QdwmtY9HI1mBLF38TLNmhpYXzYms0cqgMUAMKo1GsTP71+tiZTf+7wCGO9qV97iNPCGMytWR/+6Z5LadSAGeR+uiGxU0P8VCEX5n5zZiYixpBayZvM2WWrjmvsqUW4mYTxmMnJEy9iV/V+oRDHj2DCqQ6qfRZplLxYVqFdmnI4sWUCuDSog31dM8R8OkdcmIwJtAgnyUXynHsqOxLlbMNvXHmXRKoSJsh6kRltj9Smv8m/aWmbLxYFxwfGLySTOFZVGNSjNRLv5Z7jv13ToKTY43thKSjGzT2YEfKeFytheaCV2TItz+UQckacpgpxVOVy3UEPrSG0+Ab81Qs+ekQCIgVVADdKX6PY0YyTHcFhcGVH1CR6jIO/8Tx9rYqjXYYPC1UBCpV7szLRCkLDOvQk7mnPJRRGHTGuV4oMK6P7TgU9p009FNPv1ea3QA7oAJg54JdSsxp7q89l9g8r1NOgU7LS0/ftAsACwmnJXBh5WkAQP2TxPyMbf2Y2MXvWZKiJhaINm2YLGBddE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f54762a-520c-4844-1246-08dcf36de64d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:20:52.2631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsMh0Khs1n9K7QOH6AgeeiuxihKLRE+KTtyQPMZUj6Tvp4eBN8OllCTty538+OxGfWbTw6zpiU+uRwTGkIg2Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_12,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230087
X-Proofpoint-GUID: urd8x6qYu6aKQUhdi11SmfdNC5uJr80Y
X-Proofpoint-ORIG-GUID: urd8x6qYu6aKQUhdi11SmfdNC5uJr80Y

* Vlastimil Babka <vbabka@suse.cz> [241023 08:59]:
> On 10/22/24 22:40, Lorenzo Stoakes wrote:
> > The mmap_region() function is somewhat terrifying, with spaghetti-like
> > control flow and numerous means by which issues can arise and incomplete
> > state, memory leaks and other unpleasantness can occur.
> > 
> > A large amount of the complexity arises from trying to handle errors late
> > in the process of mapping a VMA, which forms the basis of recently observed
> > issues with resource leaks and observable inconsistent state.
> > 
> > Taking advantage of previous patches in this series we move a number of
> > checks earlier in the code, simplifying things by moving the core of the
> > logic into a static internal function __mmap_region().
> > 
> > Doing this allows us to perform a number of checks up front before we do
> > any real work, and allows us to unwind the writable unmap check
> > unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
> > validation unconditionally also.
> > 
> > We move a number of things here:
> > 
> > 1. We preallocate memory for the iterator before we call the file-backed
> >    memory hook, allowing us to exit early and avoid having to perform
> >    complicated and error-prone close/free logic. We carefully free
> >    iterator state on both success and error paths.
> > 
> > 2. The enclosing mmap_region() function handles the mapping_map_writable()
> >    logic early. Previously the logic had the mapping_map_writable() at the
> >    point of mapping a newly allocated file-backed VMA, and a matching
> >    mapping_unmap_writable() on success and error paths.
> > 
> >    We now do this unconditionally if this is a file-backed, shared writable
> >    mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
> >    doing so does not invalidate the seal check we just performed, and we in
> >    any case always decrement the counter in the wrapper.
> > 
> >    We perform a debug assert to ensure a driver does not attempt to do the
> >    opposite.
> > 
> > 3. We also move arch_validate_flags() up into the mmap_region()
> >    function. This is only relevant on arm64 and sparc64, and the check is
> >    only meaningful for SPARC with ADI enabled. We explicitly add a warning
> >    for this arch if a driver invalidates this check, though the code ought
> >    eventually to be fixed to eliminate the need for this.
> > 
> > With all of these measures in place, we no longer need to explicitly close
> > the VMA on error paths, as we place all checks which might fail prior to a
> > call to any driver mmap hook.
> > 
> > This eliminates an entire class of errors, makes the code easier to reason
> > about and more robust.
> > 
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> some nits below
> 
> > ---
> >  mm/mmap.c | 120 ++++++++++++++++++++++++++++++------------------------
> >  1 file changed, 66 insertions(+), 54 deletions(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 66edf0ebba94..7d02b47a1895 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1361,20 +1361,18 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> >  	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
> >  }
> > 
> > -unsigned long mmap_region(struct file *file, unsigned long addr,
> > +static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> >  		struct list_head *uf)
> >  {
> >  	struct mm_struct *mm = current->mm;
> >  	struct vm_area_struct *vma = NULL;
> >  	pgoff_t pglen = PHYS_PFN(len);
> > -	struct vm_area_struct *merge;
> >  	unsigned long charged = 0;
> >  	struct vma_munmap_struct vms;
> >  	struct ma_state mas_detach;
> >  	struct maple_tree mt_detach;
> >  	unsigned long end = addr + len;
> > -	bool writable_file_mapping = false;
> >  	int error;
> >  	VMA_ITERATOR(vmi, mm, addr);
> >  	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> > @@ -1448,28 +1446,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	vm_flags_init(vma, vm_flags);
> >  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> > 
> > +	if (vma_iter_prealloc(&vmi, vma)) {
> > +		error = -ENOMEM;
> > +		goto free_vma;
> > +	}
> > +
> >  	if (file) {
> >  		vma->vm_file = get_file(file);
> >  		error = mmap_file(file, vma);
> >  		if (error)
> > -			goto unmap_and_free_vma;
> > -
> > -		if (vma_is_shared_maywrite(vma)) {
> > -			error = mapping_map_writable(file->f_mapping);
> > -			if (error)
> > -				goto close_and_free_vma;
> > -
> > -			writable_file_mapping = true;
> > -		}
> > +			goto unmap_and_free_file_vma;
> > 
> > +		/* Drivers cannot alter the address of the VMA. */
> > +		WARN_ON_ONCE(addr != vma->vm_start);
> >  		/*
> > -		 * Expansion is handled above, merging is handled below.
> > -		 * Drivers should not alter the address of the VMA.
> > +		 * Drivers should not permit writability when previously it was
> > +		 * disallowed.
> >  		 */
> > -		if (WARN_ON((addr != vma->vm_start))) {
> > -			error = -EINVAL;
> > -			goto close_and_free_vma;
> > -		}
> > +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> > +				!(vm_flags & VM_MAYWRITE) &&
> > +				(vma->vm_flags & VM_MAYWRITE));
> > 
> >  		vma_iter_config(&vmi, addr, end);
> 
> I wonder if this one could be removed, earlier above we did the same config
> and neither parameters changed? But it was true before this patch as well,
> and maybe it's further refactored away later in the series, just noting.

Yes, this was here in case the vma changed address, so it's probably not
necessary.

> 
> >  		/*
> > @@ -1477,6 +1473,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		 * vma again as we may succeed this time.
> >  		 */
> >  		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> > +			struct vm_area_struct *merge;
> > +
> >  			vmg.flags = vma->vm_flags;
> >  			/* If this fails, state is reset ready for a reattempt. */
> >  			merge = vma_merge_new_range(&vmg);
> > @@ -1491,10 +1489,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  				 */
> >  				fput(vma->vm_file);
> >  				vm_area_free(vma);
> > +				vma_iter_free(&vmi);
> 
> If we merged successfully, I think this is not necessary? But doesn't hurt?

Yes, it will use the allocations (and re-allocate more if necessary)
then free the unused allocations once this call path reaches
commit_merge() with the same vmi, which is nice.

And yes, it is safe to do regardless.

To be honest, this whole block is so rare that I want to delete it
anyways.

> 
> >  				vma = merge;
> >  				/* Update vm_flags to pick up the change. */
> >  				vm_flags = vma->vm_flags;
> > -				goto unmap_writable;
> > +				goto file_expanded;
> >  			}
> >  			vma_iter_config(&vmi, addr, end);
> >  		}
> > @@ -1503,26 +1502,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	} else if (vm_flags & VM_SHARED) {
> >  		error = shmem_zero_setup(vma);
> >  		if (error)
> > -			goto free_vma;
> > +			goto free_iter_vma;
> >  	} else {
> >  		vma_set_anonymous(vma);
> >  	}
> > 
> > -	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
> > -		error = -EACCES;
> > -		goto close_and_free_vma;
> > -	}
> > -
> > -	/* Allow architectures to sanity-check the vm_flags */
> > -	if (!arch_validate_flags(vma->vm_flags)) {
> > -		error = -EINVAL;
> > -		goto close_and_free_vma;
> > -	}
> > -
> > -	if (vma_iter_prealloc(&vmi, vma)) {
> > -		error = -ENOMEM;
> > -		goto close_and_free_vma;
> > -	}
> > +#ifdef CONFIG_SPARC64
> > +	/* TODO: Fix SPARC ADI! */
> > +	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> > +#endif
> > 
> >  	/* Lock the VMA since it is modified after insertion into VMA tree */
> >  	vma_start_write(vma);
> > @@ -1536,10 +1524,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 */
> >  	khugepaged_enter_vma(vma, vma->vm_flags);
> > 
> > -	/* Once vma denies write, undo our temporary denial count */
> > -unmap_writable:
> > -	if (writable_file_mapping)
> > -		mapping_unmap_writable(file->f_mapping);
> > +file_expanded:
> >  	file = vma->vm_file;
> >  	ksm_add_vma(vma);
> >  expanded:
> > @@ -1572,23 +1557,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > 
> >  	vma_set_page_prot(vma);
> > 
> > -	validate_mm(mm);
> >  	return addr;
> > 
> > -close_and_free_vma:
> > -	vma_close(vma);
> > -
> > -	if (file || vma->vm_file) {
> > -unmap_and_free_vma:
> > -		fput(vma->vm_file);
> > -		vma->vm_file = NULL;
> > +unmap_and_free_file_vma:
> > +	fput(vma->vm_file);
> > +	vma->vm_file = NULL;
> > 
> > -		vma_iter_set(&vmi, vma->vm_end);
> > -		/* Undo any partial mapping done by a device driver. */
> > -		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> > -	}
> > -	if (writable_file_mapping)
> > -		mapping_unmap_writable(file->f_mapping);
> > +	vma_iter_set(&vmi, vma->vm_end);
> > +	/* Undo any partial mapping done by a device driver. */
> > +	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> > +free_iter_vma:
> > +	vma_iter_free(&vmi);
> >  free_vma:
> >  	vm_area_free(vma);
> >  unacct_error:
> > @@ -1598,10 +1577,43 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  abort_munmap:
> >  	vms_abort_munmap_vmas(&vms, &mas_detach);
> >  gather_failed:
> > -	validate_mm(mm);
> >  	return error;
> >  }
> > 
> > +unsigned long mmap_region(struct file *file, unsigned long addr,
> > +			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> > +			  struct list_head *uf)
> > +{
> > +	unsigned long ret;
> > +	bool writable_file_mapping = false;
> > +
> > +	/* Allow architectures to sanity-check the vm_flags. */
> > +	if (!arch_validate_flags(vm_flags))
> > +		return -EINVAL;
> > +
> > +	/* Check to see if MDWE is applicable. */
> > +	if (map_deny_write_exec(vm_flags, vm_flags))
> > +		return -EACCES;
> 
> The two checks above used to be in the opposite order. Can we keep that just
> to be sure we don't change user observable behavior unnecessarily?
> 
> > +	/* Map writable and ensure this isn't a sealed memfd. */
> > +	if (file && is_shared_maywrite(vm_flags)) {
> > +		int error = mapping_map_writable(file->f_mapping);
> > +
> > +		if (error)
> > +			return error;
> > +		writable_file_mapping = true;
> > +	}
> > +
> > +	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
> > +
> > +	/* Clear our write mapping regardless of error. */
> > +	if (writable_file_mapping)
> > +		mapping_unmap_writable(file->f_mapping);
> > +
> > +	validate_mm(current->mm);
> > +	return ret;
> > +}
> > +
> >  static int __vm_munmap(unsigned long start, size_t len, bool unlock)
> >  {
> >  	int ret;
> > --
> > 2.47.0
> 

