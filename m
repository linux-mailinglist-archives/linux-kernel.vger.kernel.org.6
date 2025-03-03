Return-Path: <linux-kernel+bounces-542178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE52A4C689
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48A53A7860
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1723E227;
	Mon,  3 Mar 2025 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nFN0gBSH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j6pJUEpq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B923CEE8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018205; cv=fail; b=DwF24f38tZ6E607meWs8TN4B/4om5nVm2bBaS7VmWhKl4xt/Ik9NnfNmrtghz2g+5AgaVKdxL6zGX32Na7OyB5EQjq0P9CNOHoInI3XPJ5agS1t/ievFSjX2X2ABXrVtwR8BWgGjO0LGac7QhVKCfeoMaREfiS5Hdh7AlX0r4tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018205; c=relaxed/simple;
	bh=2xf7oL/qXZWpLOYCgiuJgDDrV8KfL0755XGSzebTyJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NaHJYimTqhTJ+3pa54hYjTB7FLMPMmVlTi+pC1GwUGO5UjXkqCWKoFpYOQ8FIXFfpWgwYV+z1SBGZB6cqZfwb+2aZBZPQ/XgxPncQpMCV0/S8QvC9TReTA8ZO5BNaUSR3leE82jt89DusciCnNmIAL1jIHrM2zvH9jRIFPfjPkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nFN0gBSH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j6pJUEpq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523G5XPY024212;
	Mon, 3 Mar 2025 16:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Ru2Jd/oJPoVkn8jzr4
	srRMihVPfOApN7HZcMjxfwVJU=; b=nFN0gBSHQjHgJbSMGSCR6sffl4xBA1qS+T
	knaLftvWRu+i9tewJXCHlqwU/wQDL4dfYyrkBB6qs3pdLrSNJGnKhE7vBtvoK/U+
	c8f+7IUFYAU2Zu+TKzplUCrYHUFrBkQG3N5bfDPM52jdjANEDj9ELFcNZ8sI45Hv
	AHqmbLVTXtTf1Ms0U91CuK5LiNGtT7crqaY6eOg5q/tAOxjTL6NOGOctLnX8dxnr
	8M13Sob0xLb8XMEPb11eaVmBy9PKmzBpB0JdfMygB7SSRriWXkEbFUyGrdnOEsA6
	KKb+MHSXTWf8ZJYGLJ8+l099Y/TjaiMyqH+TykjvIkQoXan0cM/g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hb1yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 16:09:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523F3pRE003158;
	Mon, 3 Mar 2025 16:09:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rp7pscv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 16:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyKShyF2SZVJY8u5NV1+TOO/yXu1FDAiIGrtuMqUILeznnZpD43mwNNeCN6jz6DM85gv4kgtUADLEJjF7u9LfXoXguVKqYnU+rEE1Ud0yTml5HIlxLId/6QxJOQmkGA7kSHyOdcD+cA8olAZ3E5AEGReDWLjrA4sm/YB8XVpXUWtyxt7leHCzDnphuxTQdQKgHniY6V2r0NKXNDDg7woFA7cZq3VBwdnmmUaVj5f56ZssNGYj2AWeX8shMYWwabLaNr9FvHZFh7W2ZaG2JZw0NE2nL9CpwjNw28meK+1OoU4t+heEB6VV4vuvA4oSAlZvU0SSXgiMSmjfpUBruKg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ru2Jd/oJPoVkn8jzr4srRMihVPfOApN7HZcMjxfwVJU=;
 b=Zxh9JSJSQo1QbMjWssQPB8rltAMXcdjEzAoF8UT1IJX5PTtvuT6FXePoC2l4eFL4XZSmTGmqQfxC+kMKJvllt9ZkJGH5TDPQAQpGNoLiEdKWQ3C6OvpHksn1gvxNtJJKbjrGBbRjXLOV9YoX1tybw2qRcDYksWu49dMUreQTvMz81O36JEZUa2r7W5aylRQDdhFciIf5SgFttaOn/VK0hoJZZ1bIKKwXP7HihO7+cZ4plNN1i4/VI8xzGygURocrociMzal7Rf4OiOAt9EKgS5LvfSAC8eGgJmnOR6/j+wy8RUQQqgqBLnbeqDpd9CK9MVfI/K2utojteZ92cN87Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ru2Jd/oJPoVkn8jzr4srRMihVPfOApN7HZcMjxfwVJU=;
 b=j6pJUEpqQtE7i/2bCSuT6L79TY5gB2RALXjsEf0ERJJahbjmWEGMV2qd42ypYP/lWW7AiyVuTVaTuFho2PzjF0NbUONIk5qZoNiVUkTscQaJu6ayYFRj2O0qo6qNRsQSkrf+OKVMhLFB3zMpn6n/J0bC4afAOMFdsQJjBtRJtdk=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by LV8PR10MB7752.namprd10.prod.outlook.com (2603:10b6:408:1e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 16:09:51 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:09:51 +0000
Date: Mon, 3 Mar 2025 11:09:48 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm/mremap: correctly handle partial mremap() of VMA
 starting at 0
Message-ID: <b4govbcfdet5cv2ik7xpkvb2slczxpfiaqcrin6huz4uv3jnv5@q6zbwev6ho5u>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <cover.1740911247.git.lorenzo.stoakes@oracle.com>
 <195c3956c70a142b12465e09b4aa5e33a898b789.1740911247.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <195c3956c70a142b12465e09b4aa5e33a898b789.1740911247.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::15) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|LV8PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: faf74e72-ced0-4d89-a9fc-08dd5a6dd425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SqDu5zuGKvY9AJR0w9pMayW2YED/OdXQBhVZ9Zj9VepURAM69FWXLUPfMF06?=
 =?us-ascii?Q?hINpZuyonG8H4Msb+WaftDAT2l+Zr3jLCMLwDFfYO3+iXSlWPvY2qsPDlbKV?=
 =?us-ascii?Q?ecIXaHxBqCKX3zhTw4iyIIs0YA5dqaX1kyKDWDCdLNCSjnzz82s+onT8pxqO?=
 =?us-ascii?Q?VUAA6GXWARJfmV8IDM5+n8jS44VnlZSUfxTPh4UwRwK99ShyBmW5F4bkyr6A?=
 =?us-ascii?Q?cAgQIrUoPzVCPRqtjJgdpuu3pTUpxR2qMMARc1rW0r26NZbHIpan+0Bo6BtO?=
 =?us-ascii?Q?0ppcfZKVHpRGBTBP0Abk9c3wmqZlTtUaPlvrIG4IgUVUSinS09OTvl682TbO?=
 =?us-ascii?Q?IerFL3GfXSvU5t+ohPwpSGH2f7V+oBpRn2QRhKXIqEFUzt2fmtBVMu1psUQw?=
 =?us-ascii?Q?XzhoehSXyctV+WrOCLy3hxM0tkHf94VEeEOrcRFieNCegAiWXs4NqKoVUMHu?=
 =?us-ascii?Q?zRS1o71WE9nR5H0qBzzQEeetVNGUlmaxJJzzv4jVaXIt8iJG2GKMmGgpjWgI?=
 =?us-ascii?Q?SYIvuj18k6W94W7yFx5fVDF631vHRIAGbvC+6UWmihHRK/stpIDKWlBVI9Qb?=
 =?us-ascii?Q?+gYDoXR3dUbc/ZR7FHyUBALyfZxq7Cia/Mk9qFdzSYtoV4At4y7aIvpgipaz?=
 =?us-ascii?Q?13OHL2DxTAJ0dUqXFxFOIXOe1D0ZswP2C3V47/Gls6ZNmMR4II3QPkiME06S?=
 =?us-ascii?Q?cnwi9dpH8kln5sNMxGGNIsa2j+OruTFIZ2/htm5/uLBpGX7h7F2iRb/Ly2qj?=
 =?us-ascii?Q?Vnp8pRjCVgs9+bo0+zTk/6whafnpboULTGXcIA/Pk0c0brKspBebmsLAILQu?=
 =?us-ascii?Q?E1J6G2+yuJuVn7r0T2oqYnT0z7GZfrpcBWntJan4RwHyH5w40bbHiomrExUr?=
 =?us-ascii?Q?uCz0V5Ywt9ocK+cy+7xeyEHpRK1umH8hMcG+dev3VjsojMV64tB2F3o43n8s?=
 =?us-ascii?Q?D7qmDaaL2ViZoywjhuA0OpFfsAl28ocgs9EXhRL73gl/EKQduVWBs2+rSYPF?=
 =?us-ascii?Q?IXS0OVioUDwqrgLC37T8U09MuvGM2x3MSV8Ac74Z/h8f8bZCezIGxukJAa9w?=
 =?us-ascii?Q?4iepEaZWrzArGwcaH79az9zTmbK3JTCkbJDj2fK2i/j0KGfUiGdi3jONx3ig?=
 =?us-ascii?Q?/H7ODKnrG6X2uLGslJZomX7N5t9zNJvoQdmPANlZ7Vy8DYqrR5dUWWqiGEM9?=
 =?us-ascii?Q?JXndHNMG0Z8lF5h83+db+gDMS6V0I3LL69iPNnn91jIk1tQnFunrWQnIeNDa?=
 =?us-ascii?Q?FQApyvFuKx4DjSOja/W6QkRwgxfKcwt/oir/DvSqKzEhsSFiSYlfv3yDHhzC?=
 =?us-ascii?Q?JKst42gx9CbqQJr+3zdTdIozyFWejxGeQW3Lpp6pwTI5676GHIRtzlF8ahIW?=
 =?us-ascii?Q?GddfOSqU2AudZhfEfUebnsbBaR0q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vis0zj/6FYuzUtKk9PF1e2Njtbys2+Q3QJBvpjHKhRfs+IMnvI4UNx33FNsw?=
 =?us-ascii?Q?E5ewK5t2xABGpbIR/a+UiVzM3DyunKAX+5KW5zIq9bt3tEan69Jf2wZ+Yc/f?=
 =?us-ascii?Q?b26IGU8Ni5hd+3XlNKxsaM/6wzD4XTD/Myg8s5lC+QiDn/p+Srpaq87GvDhA?=
 =?us-ascii?Q?QTsOKBtfbdm3trVXOqGY0EssKtMsiyPnWJgGQYoIeswH7jE4xZ0xaxHxJ2/c?=
 =?us-ascii?Q?bX8QEIDwMOj2dkJ1RQjdP3TkgxqQRNVwX7CEXhIvYiJyrTISYJyUdZeRGoz5?=
 =?us-ascii?Q?1LrLYT94/2uLJ1srk+bVVotOmAWqrF4xIQttgwBBQggmnDxd+Bzg6SPJZeug?=
 =?us-ascii?Q?4NxgkG7Y5l0weffl/CF0ebBwevKyXVaO0OYLRNa/fnF7A12n4Bo4+TVr2nqs?=
 =?us-ascii?Q?sdGr59DPyJZ7rZQCMRYquOt7B/Shh+ERTmc5V8dKcNb9Q3NyQ1kz2AGft0kW?=
 =?us-ascii?Q?R4UHOckmpMBl7G7dinleLDUvNohSY2v9Z8lN8hsEfHsezITHo6Smuot1kzcJ?=
 =?us-ascii?Q?F6slZYjFgT2UfRolpjg60YCjXRp/eryEI9nrIOTD7Ks8du1OlO0bozyMSDMB?=
 =?us-ascii?Q?NH3Rc0n6/gyJVJESJfCrwJv1IcvYmDoyFMMr8kuguIYlcrJ4K1LTAMOIyNss?=
 =?us-ascii?Q?RGD/dM2pFRTpvgJIZQ3AFdAQv6JM7zGMw6urm1H2rmE7fOtJpBWAKtzyY71g?=
 =?us-ascii?Q?2A2/u97V4AZdwEDgTmnvSJyG8JQUqO+z4Ui/BvEkmnxLT7AMLyxldCASLOkf?=
 =?us-ascii?Q?uYU1jLcLUQXUyQak+UTux6wxgLfIEirM5vLMctoKJ3LJ+wqqfWEY6HbKRUxp?=
 =?us-ascii?Q?6MKGbp6jQ6Ojd/MNI+O8jFVRBiAoTsRjvola/93qfRxGSvoWpI68tc2ZgHMt?=
 =?us-ascii?Q?4J2V1PqaW4LwcmuTaTfePQa80EUtKl/FYZ6LBvsn+4A+GUru5YyNGSgHTaj9?=
 =?us-ascii?Q?DOBR0xFY/9xIcf2BBKVB+4tm16tF06IGTcJKPGMAzLItGDbvctw5netGEa2W?=
 =?us-ascii?Q?D9XjBOJ+JbYNB41hyRK22SDsllRyx+RSwpp/zDDXUJH1g16jDH4z6sko/Ld+?=
 =?us-ascii?Q?TK5MnY3iSjX4QMiuWzJHBUk9j+eKdmH3gucmhhgzdLOkpn4z1Z8eDOtvu7Oz?=
 =?us-ascii?Q?TIQ6jG9+N9G4jiGE1Soiv0hYV9/Bkg8paRdwZO80NxRlCskm5jq68E8HIfOh?=
 =?us-ascii?Q?Y3OiC05qf98sqYZm9wtYohYb8HNqhPDACLqnWB1M5vCnlS+bjY0kqad+TZSr?=
 =?us-ascii?Q?LSo4XV7Y7QwZLclheCBXBvf2bEAvsdI3W7r9/UtSmZSwKsnChV8WvWKfmTxZ?=
 =?us-ascii?Q?m0Mb0TC+t5+MsysPPhf2oskboLViyqpVyzdAo+H/x8/do1qJOmQHokkRcaWp?=
 =?us-ascii?Q?tJDk8v27SbfIiIMB3EMtte8AxK/+XCs7YkKn5vnLzSktpR6BMGONQuRUfNqr?=
 =?us-ascii?Q?c7nN1PGJkrnbcV4uYM7vFfuumIkJTTY6I+S0joq8m0UWr5jxzwaIdHW5b7h+?=
 =?us-ascii?Q?idFkeUlLmyhXdlahS0hUv/Dkksbfz4lbXg1rjBq53e8fhzuNDJ288d4ckV4B?=
 =?us-ascii?Q?gjtHRoeJnM3+n6sEiTW+pqUGQ3S0N/tyzD0Qe/Dn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w0r2XbD/hIRqFE/av9sa0kWRJydvuD6KNS3bFWz9w6Hn8eF4A7AeGujtYNhSk5LSjpj0sfTxe3VVzTZiluLxYb72p8XILnFmqDYspE8o+DuI0XwxYYz08hp5zNcYg4iVtQLv6/ZhbK4nI4jzB7UK2LWqlv5daAkf9I4Uvsn0JDHC+3OT9kBuZjiagR8o9ujBTE+sihZpy0o34F90x6bOWe6Mgov/JoGlkeknwARs02Da+tqf2Qts9A8yXLemNiT6jKGkbykNXU/POAZZMcx7hQEBeg+3yUv6m7JCqmW8pxLhUtUzCXurDefcwp6J+DuXfz/ya3Duqi58ffxXgYy7T2uoUiyauXtxod6eUrVZt3OU9wsY0jxQ+Rjx/jsdEJlbGL+agG7DMl/JUdaT2Lq/JAbUoecR45EWhZcEIDsbLCqw7yLoyO/pzwiR3sykm3lZ7Uol95HD648UpdBSL87VjGSW1CNDbwMWkjUizMiEV1CYnkm/X6RL7CJ8BwkfVIi66NWAvX4gHlx3MDYpLzuXWNx8SpVVM6cvsmd2uhd2zdZFyUUeeassnmpSoG5Ypun66QeFuidwrvkWRc4hqAJJ7S0vWFPd+hXg34UlA5m0DgM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf74e72-ced0-4d89-a9fc-08dd5a6dd425
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:09:51.5396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRoYmAWD7/Z/3uOh2Rmzn9V9L7Ay/jlbdfKwsBwJCLQx0vyp7qqK/+SzU6e0s6pPwYA8Bx2r1URAipVqib8Xpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030123
X-Proofpoint-GUID: FK7OF3AQvzJf2BqPQjETpDmccMUF1XI1
X-Proofpoint-ORIG-GUID: FK7OF3AQvzJf2BqPQjETpDmccMUF1XI1

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250303 06:08]:
> Consider the case of a a partial mremap() (that results in a VMA split) of
> an accountable VMA (i.e. which has the VM_ACCOUNT flag set) whose start
> address is zero, with the MREMAP_MAYMOVE flag specified and a scenario
> where a move does in fact occur:
> 
>        addr  end
>         |     |
>         v     v
>     |-------------|
>     |     vma     |
>     |-------------|
>     0
> 
> This move is affected by unmapping the range [addr, end). In order to
> prevent an incorrect decrement of accounted memory which has already been
> determined, the mremap() code in move_vma() clears VM_ACCOUNT from the VMA
> prior to doing so, before reestablishing it in each of the VMAs post-split:
> 
>     addr  end
>      |     |
>      v     v
>  |---|     |---|
>  | A |     | B |
>  |---|     |---|
> 
> Commit 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
> changed this logic such as to determine whether there is a need to do so by
> establishing account_start and account_end and, in the instance where such
> an operation is required, assigning them to vma->vm_start and vma->vm_end.
> 
> Later the code checks if the operation is required for 'A' referenced above
> thusly:
> 
> 	if (account_start) {
> 		...
> 	}
> 
> However, if the VMA described above has vma->vm_start == 0, which is now
> assigned to account_start, this branch will not be executed.
> 
> As a result, the VMA 'A' above will remain stripped of its VM_ACCOUNT flag,
> incorrectly.
> 
> The fix is to simply convert these variables to booleans and set them as
> required.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Fixes: 6b73cff239e5 ("mm: change munmap splitting order and move_vma()")
> Cc: stable@vger.kernel.org

Thanks for taking care of this.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mremap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index cff7f552f909..c3e4c86d0b8d 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -705,8 +705,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	unsigned long vm_flags = vma->vm_flags;
>  	unsigned long new_pgoff;
>  	unsigned long moved_len;
> -	unsigned long account_start = 0;
> -	unsigned long account_end = 0;
> +	bool account_start = false;
> +	bool account_end = false;
>  	unsigned long hiwater_vm;
>  	int err = 0;
>  	bool need_rmap_locks;
> @@ -790,9 +790,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP)) {
>  		vm_flags_clear(vma, VM_ACCOUNT);
>  		if (vma->vm_start < old_addr)
> -			account_start = vma->vm_start;
> +			account_start = true;
>  		if (vma->vm_end > old_addr + old_len)
> -			account_end = vma->vm_end;
> +			account_end = true;
>  	}
>  
>  	/*
> @@ -832,7 +832,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		/* OOM: unable to split vma, just get accounts right */
>  		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
>  			vm_acct_memory(old_len >> PAGE_SHIFT);
> -		account_start = account_end = 0;
> +		account_start = account_end = false;
>  	}
>  
>  	if (vm_flags & VM_LOCKED) {
> -- 
> 2.48.1
> 

