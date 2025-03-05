Return-Path: <linux-kernel+bounces-547620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB66A50BA6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F953A2BD1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8CE253B44;
	Wed,  5 Mar 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fYuUp4ox";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y6tBboe3"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45978F3A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203610; cv=fail; b=HwZZMRqxdQyZvdgxyJXD2uEA7KofH3cONmGMGDd3DVgkrV6o4osvF3i4DOqT2HFeQVC7ub92ykks2u83fmOOqNX2LURx58N4zyTSVbOF+Ukf1auzLCqlTqbQmvPbvVqoI0GhqNPL8I0rB9aqc+WcqIgCpp+obc30WtTrDqWISuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203610; c=relaxed/simple;
	bh=t//APsSmLneM4V7Nxp5wTL9uvVQji8p1GamfgQACI2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LxSFIIes6MnZ/eGC7BuNL7yFNYdo4TU2BfP7Mv3+VTs5b/TwoHmemVXHWO7laztS+FagHzCNuMJrIGQFZMNlVQw/WKIIKGVXND+lsuRTBwWkIzLmujpsRwa8l4mR5jrcXOPgc/ncVUWVNInaCDnoi0hn9XYfXurlH+/uMplZpT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fYuUp4ox; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y6tBboe3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMmUY002645;
	Wed, 5 Mar 2025 19:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=nM0xf9VN4C+In4yxa4
	CTSzD0XKQnS8Wjf0oozi6ZCXE=; b=fYuUp4oxExJgPmWEI6s/3zCb8NA2PXdoCb
	/juVznUNlpm4IfkIHbEDBzsQU/rOZ64QckK2GeiLvmcTJPdi1ZvQ6B3DmnTbjg0c
	og+n5TFTyUy9EBgVmeh2SEJkJUFAmQpgKvkm1CLMcbgIzLD1++kZpFk2lV70eg2z
	hTUAysTC19/2oukc8eOcD/sJ3mKQoveakuRTjGVoMh4KyPX/HiY2VwUAZQ2Clkbz
	BQuFgC1+PPeTtMOerfN+f01fcMIX+Em+Pu+fbjrCb3E8o28Cml6m8bUed/4RBdM6
	uWJB8CMulz0vbjEkmECWZG7ebM7XvtUxsypzCTDhFfGFOV8BXCSg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hggv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:39:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525JNOpC040400;
	Wed, 5 Mar 2025 19:39:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rph5r7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:39:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOjwdKKwAl9fz3w7gWEWw/hAX+b3YmV04pGvtyZ0KJjTOJkXU78JDd40DB3aG/wyvFyN69rgCjr+bPWcF0BNZPz8ebHsM2r7ld8BEfYeta5A+psGAUl03x97IGRIjhSBOd5MDaYuNllGG7vWbcQCmPig1ayx+UmSZr8ry741CczpkTkcbNXXupKhLLD70rWGD2t2ygtdLPsS5d0FxiyWnaRh7YHiNo/D0r3JBQSlD1Vm2RigEPQ5n8tJ4vQc26W1452TNlL8N94at+7WmFjUk/WmNLHGY73o3lU++lZICTxhYe+2n/orPnygAup8NelmDUVuHSTabWsnVHCfIdN1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nM0xf9VN4C+In4yxa4CTSzD0XKQnS8Wjf0oozi6ZCXE=;
 b=rhH6KBnxhnEXbAXWobPe23uek5I7CTveKpd6z0MYijAJlW0x9llgXEvmuKGYcoyHXe2mX05QVcXzmkN7Qbyr8zMZl50KeY3bhYsCKivKjoSjjYnySz2+WRvAEvyuda1mvZhRhW4kyCtXAfmyS+YCLj4U4KtgcdFJFS9M9kn+UIUTpN1kbSzEUTVfjnhD+p8LAw7gzhuXQ7BFDPHoqEs3GvevQBEMqA5zw5TUM6aFT9F6n8BDad1GlwwYzyaJ8ZOTfEnPFiT1mg/zmp8A+RlBYgnbhUAF8wvfzZyKTquIpem/Xj/0MnFixpPa+vG0yEI2PzqZl9mThCq1yIabWcHFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nM0xf9VN4C+In4yxa4CTSzD0XKQnS8Wjf0oozi6ZCXE=;
 b=Y6tBboe3qT6yxf/Es8JkfsFMOIIfu7VfXR/MLwJcqDuUXaTREo/d+si9/js7BoNEfB079FgNQB/HkWvZDS+bel1GKH1LGJ75F6VuyvKlBrJnIs2zbd4Tbg6UuvQ4h1zXz19dWeKLG8ROMV6v2RS+ZtuZ4wCkRK7P3rcL8WGiSC0=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 19:39:39 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 19:39:39 +0000
Date: Wed, 5 Mar 2025 19:39:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, SeongJae Park <sj@kernel.org>,
        "Liam R. Howlett" <howlett@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for
 MADV_DONTNEED and MADV_FREE
Message-ID: <d2fe0cb9-ffbc-4b55-a7a9-e2b03a176044@lucifer.local>
References: <20250305181611.54484-1-sj@kernel.org>
 <Z8ieZVFEa6vAouvu@casper.infradead.org>
 <46960f37-0d12-4cfd-a214-1ddae2495665@redhat.com>
 <8c7714ca-a766-4a07-bfdc-f1d91aee379d@lucifer.local>
 <f63146c0-0316-4182-9a62-48dfc39f27b7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f63146c0-0316-4182-9a62-48dfc39f27b7@redhat.com>
X-ClientProxiedBy: LO0P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::8) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|SJ0PR10MB4512:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b88f20c-237c-4f2a-5f77-08dd5c1d7805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGdZAN+27xwp9oDln8utj+WMt5RU1ugOP/iXEcI37NrhzJ8DFhDyLpuPcI5/?=
 =?us-ascii?Q?c56IFQ60hsLPksCE+juQeE76v83MZ4xvp/x/pdUUY9ZXiV8iYuSdgeghQwtj?=
 =?us-ascii?Q?cQqZ0VWgJPNMTnYRGvpQOWSckh/hU8MnXPMhj9CLfrKFtJ/wuBs1dLaTh43U?=
 =?us-ascii?Q?rm06ZwETaM9cYgRxoakxxmPWyikS1wYFAqfg4DksR90Ml/E7tRbPQNudLaae?=
 =?us-ascii?Q?5vkb9vYP1DKcaiB1Kxqra94ndQNDdF3QudlnQcSTFDQyC8fddmkj1Ume2Wri?=
 =?us-ascii?Q?JvprxAy83CEY7eSeWhzCV7+h6hv0ciz7kRvE6av/x4z8tDjBzCilLo3gMOQy?=
 =?us-ascii?Q?wIfLccgH2jpSSy6H68i5ZggXLMUvXLvtULpb7Zcg6nUU8/bQImH3UTq5rFd2?=
 =?us-ascii?Q?cbYkwGgHMtrS08jvwZdDacYteBm2i8IzlqgzlT8YgnK51OAsai5NAit4O30D?=
 =?us-ascii?Q?drayk0BfouufYkTOspRZ0lO5aRvn8LeUjNAr0QbC05Jy1HZ39RpVVftfFJSt?=
 =?us-ascii?Q?1gUCTPmykm9bgMRr6DIiwfSJab3MiACRFpHBruXqqWN5c4zhh7jqGTJD7x6R?=
 =?us-ascii?Q?TVzD910HPVjZDtplhAG32R0itssP4UiokbcDC4b8CHjOIyJO5j1tamHQEJOu?=
 =?us-ascii?Q?dBLDWJMTpmftJFzDEb00DVFePCZXUBQSrUHwaxQTKp+vxm7JgZL9a6lw33+k?=
 =?us-ascii?Q?7SvB1woO4zg8zCLNMjeCV/wDYMPBaEzuTrlpDsNqQUsXIyXoBdkUQ11P1IMb?=
 =?us-ascii?Q?GKV6Bk4WGKsBtf1u6C/YMSxejERmavdIKD1FgR3xqVLz03OmCDGDzYREt+XV?=
 =?us-ascii?Q?Un7cPtsqOMGFgkGZpVudJCO/oK0HJFPr8iTz8KCVlZ/j737sJe3Ex3q0yTfi?=
 =?us-ascii?Q?FolQjxreHtRDzbusSL91dpcd6jOBNLzh/r0VLvqH4RPSEpxreNeAziA9c7XB?=
 =?us-ascii?Q?bzGwaH1Ei/hmzxJkK9DzJV92OgJNQdiGGz72D2nuFY2KHHyEUDBzJ5q1IKMY?=
 =?us-ascii?Q?8X4SxtfTzQdfb8R95t2qZwuFrocgX3kI8gZm3p3H4X8w+xSlCXdTzsOZcb9n?=
 =?us-ascii?Q?4K6NxfUGBsQWXjpK9Qr8z57mBTQ8JgKy5MNETWseysNlHUdKK2BG9jNvtuQR?=
 =?us-ascii?Q?HKSgUOoGqxYuZBXZnkXdL9/z9Lh4bgQAwIwnR4Cvq8CDV4bEp97j60wakzIz?=
 =?us-ascii?Q?Q8kGdCsOoZPE79z/whkFUxcDsAt+Hn493sH+wNS6qAF8c+JBePiT8DAMPMvD?=
 =?us-ascii?Q?VeENoXNfJMGhT121naLUxSL9gLeK/IEnZHiynkvY1S4RGVXqJbcYm/UbJ6VA?=
 =?us-ascii?Q?H+20/63SvKwPZlTclBep9yATMZP7M+rNiw5cAj79Bz/hu84f6fc2bt+JSacP?=
 =?us-ascii?Q?I/4mQ8ktSEmQfDkuJHbKs1bKPo7S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2vrlHcQjGSXVhdkBzfzXkqpPTAe0i4xpPeLD5NaXG981yTrXIYoYUuhFwHFY?=
 =?us-ascii?Q?OJZ68FaGrqicOmT198o4TQZoWkIcJiAh+xmsM9kgJPXPHrI/iXrbS7nPo+c/?=
 =?us-ascii?Q?3g7pd1/aFl0ZFzHj9Iov6obvgO7fRxC0Lm4pW5cJy0kN6m1zMJpNQCOabxnA?=
 =?us-ascii?Q?ontgIjgYVTCFLBlmcur6xAyZB+rdqkaokKvlqyQ/+TMBmCXtrGg6W35kGXi9?=
 =?us-ascii?Q?ALNnXaCLRMXAMfr8bgLVJqxKU0W8FGf8XTJPq9tvRPYcdyotUfYBoJakCkDg?=
 =?us-ascii?Q?sKmngn4PgsnvIK/Pi1LaxVFMqCfu5sOIsQXIoxv9C+isyb2QzIj2dMsrAj1M?=
 =?us-ascii?Q?uRRwjGs8X+++zvzgb0XNc+L79ib3W83tQGAkbGDzdP6mpSYr2irvlKdMmPWt?=
 =?us-ascii?Q?GEm3SOiQinZ/8bB5V6Z53FtcXjEwvxB7FuqKjOa6oKFEMa0mZWXoA+z4Or1H?=
 =?us-ascii?Q?hxcl0MvLflvMUKicgk0i7wNNJs3+5pc4GwOtQ07bBhAEDDegl5F9ny22rAPf?=
 =?us-ascii?Q?gbxwQFH0szN9UyB9aSDubdhxjHXkJu1mZ7UDRPcDHqsw00vE49IC2fGgJyvC?=
 =?us-ascii?Q?Z19SZsC8QyVZxMB3D6cNqrv0Gu9+CqFNrau+HqMl7/XOQF3rzIpKWhPE8Rsf?=
 =?us-ascii?Q?YS2dhjKOyZsePT4+Ez4sP67mDCAkZbkwr4yvBU6fLEYjauh7toopZG6YNBea?=
 =?us-ascii?Q?ICuSWEf21XIcyZBJl7wowOVcmbQH/xAJkdzyitklAvwr09Ke10XwShwBG2Fa?=
 =?us-ascii?Q?X+4TIO13wuiYLh2LWxqL28HdR5yZHkkW6Dc6wvrbhlukC+b+jQbO72vjJL/2?=
 =?us-ascii?Q?hDNXoPxWsPyc3OCY3WYfdWVAfVOWwLF1U/AXlbBa8UFcWv0UkRw7T2x2l9Y7?=
 =?us-ascii?Q?CTn8/dZH0LzmNxa6RnWEGnNq8UaseSODNcZ8p3EFOozdCtWIBUphz5Dg1h/D?=
 =?us-ascii?Q?4TpMpAnlFLOo/6VTRe/lS7+mOUOnZ8/ZjhJEWnUc3ITLPi5fG04O/wMN9Bcc?=
 =?us-ascii?Q?lwA4DHYtnremJHYun+Uk0AWFIJu+AxcWKdbTVZZjyQnNRei9RYLcjDVHZ5aW?=
 =?us-ascii?Q?sxeK6Ir/jSpmSQnWbVx7LT3Ybn8aDByQQiqB2fPwMw/kjLZf4Z11122d7B4m?=
 =?us-ascii?Q?dvDjcBXutSwl0Edt69QafI3pSFiOQd+jELViogdzRmMsc4A2hoD1+EUW+MvH?=
 =?us-ascii?Q?3RUYjj7wpLiZh6VlmWXE8dp/Lb9ALfn83U13shsiaWUI+1A+2tC+FQC+mg+Q?=
 =?us-ascii?Q?xDXucKHiPRLfR9PpdI5SxMmLk0cMDynMyPhAlDqEuQYx/lV9/0Lcjcez7gI4?=
 =?us-ascii?Q?RRCl58BZOkOXEK2nX1aBsMbyf3hlfV1tUSyiI/k+arakHHJ2UMrWKBAClyTI?=
 =?us-ascii?Q?BQ74ez2yHG81lzFfPl1YfSL+VZjAKxFlZK73WFeYWUP8ZTDLPblEHO11b6yB?=
 =?us-ascii?Q?3Udn0sFZqonTV6mIRi4awqDLwS+fXsGG2fqL3019L/zC4tEo6NB0hTbMlkNY?=
 =?us-ascii?Q?0UfkO6TdUH3yseCz8FEJPF6IjkF74t3m58+khUAlse7bipCxmWYbCUXoV0cm?=
 =?us-ascii?Q?+5BQG/ZXmYVWGpBj1Om2bihfI2KLwEFz5jxTHxVFl19JD0k2H1lr7BfMlhOm?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E8nbLo6kGn00K9COMAU81s7EmLZ9qWDFQtIYTXKI0FXuTl95u+iwwO1gOqthjm6Wbx8v8Iy3VbqKFEwf7jZ0Ai/r7v6nrSYvpOMKHLmcHU0LkaZ8tqmQn8LOeRhAdyygFFWOCuufwxsviJUDZ/gjlOhMYpcI9Xcj3Yf98BUGEmHhCAGgimZxxt5D1hsUOVPf3B839YI+UPCZfZLt1BHZX+ALI6Me4xe7daLgh3Xb4uNQ30umsyM8daxmQXDDLCeab0H1X60j+SMlMwA7LR158VIBwGIJ+iSUrzaOgFls++XxgfciKIpi18jg8nVIRVA33n/6DaPxmtdMupCahKeBJdPYc6GC08wF/qiVlVjrfQGWGBHAvq7l3zbzLv1z+8Sc7/DYp1YUxRn4mHi95cgZ8IzB5bmDlLUOArVUaxoA6V3/Af+VbG0Gw0O+Rvr1z8BCBUAzP6TKRukFcfC3YWETRAugB9xFrtO8OErUfzqRG4ug+R7LhLO7ULyjOj/+kN/mTDSYTKBYGeEXtH7TcHxUv/69sxAJ/9/J7VoAhRODkl7zHCF9gpOFX0jp3GmWVknu916Kc3jYIGDKzbhZsZ9m0RUhW0921i9MW0VdcqU52fw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b88f20c-237c-4f2a-5f77-08dd5c1d7805
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:39:39.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HugTA544/vFD4jCLuK7EShHuJeSHb5iMq8IKCAwCzRboMmyNuxpQT52Tb3ZhaEGrd4pZYuXiFfVu/pN8tFGrSTv8AwfhGa7UEFAChESorNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050149
X-Proofpoint-GUID: gOMrNoENBRl5JAik4fXgohsfEaHgs50x
X-Proofpoint-ORIG-GUID: gOMrNoENBRl5JAik4fXgohsfEaHgs50x

On Wed, Mar 05, 2025 at 08:35:36PM +0100, David Hildenbrand wrote:
> On 05.03.25 20:26, Lorenzo Stoakes wrote:
> > On Wed, Mar 05, 2025 at 08:19:41PM +0100, David Hildenbrand wrote:
> > > On 05.03.25 19:56, Matthew Wilcox wrote:
> > > > On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
> > > > > For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> > > > > can happen for each vma of the given address ranges.  Because such tlb
> > > > > flushes are for address ranges of same process, doing those in a batch
> > > > > is more efficient while still being safe.  Modify madvise() and
> > > > > process_madvise() entry level code path to do such batched tlb flushes,
> > > > > while the internal unmap logics do only gathering of the tlb entries to
> > > > > flush.
> > > >
> > > > Do real applications actually do madvise requests that span multiple
> > > > VMAs?  It just seems weird to me.  Like, each vma comes from a separate
> > > > call to mmap [1], so why would it make sense for an application to
> > > > call madvise() across a VMA boundary?
> > >
> > > I had the same question. If this happens in an app, I would assume that a
> > > single MADV_DONTNEED call would usually not span multiples VMAs, and if it
> > > does, not that many (and that often) that we would really care about it.
> > >
> > > OTOH, optimizing tlb flushing when using a vectored MADV_DONTNEED version
> > > would make more sense to me. I don't recall if process_madvise() allows for
> > > that already, and if it does, is this series primarily tackling optimizing
> > > that?
> >
> > Yeah it's weird, but people can get caught out by unexpected failures to merge
> > if they do fun stuff with mremap().
> >
> > Then again mremap() itself _mandates_ that you only span a single VMA (or part
> > of one) :)
>
> Maybe some garbage collection use cases that shuffle individual pages, and
> later free larger chunks using MADV_DONTNEED. Doesn't sound unlikely.
>
> >
> > Can we talk about the _true_ horror show that - you can span multiple VMAs _with
> > gaps_ and it'll allow you, only it'll return -ENOMEM at the end?
> >
> > In madvise_walk_vmas():
> >
> > 	for (;;) {
> > 		...
> >
> > 		if (start < vma->vm_start) {
> > 			unmapped_error = -ENOMEM;
> > 			start = vma->vm_start;
> > 			...
> > 		}
> >
> > 		...
> >
> > 		error = visit(vma, &prev, start, tmp, arg);
> > 		if (error)
> > 			return error;
> >
> > 		...
> > 	}
> >
> > 	return unmapped_error;
> >
> > So, you have no idea if that -ENOMEM is due to a gap, or do to the
> > operation returning an -ENOMEM?
> > > I mean can we just drop this? Does anybody in their right mind rely on
> > this? Or is it intentional to deal with somehow a racing unmap?
> > > But, no, we hold an mmap lock so that's not it.
>
> Races could still happen if user space would do it from separate threads.
> But then, who would prevent user space from doing another mmap() and getting
> pages zapped ... so that sounds unlikely.

Ah yeah, I mean if you got unlucky on timing, munmap()/mmap() or mremap() with
MAP_FIXED quickly unmaps on another thread before you grab the mmap lock and fun
times.

I mean for that to happen you'd have to be doing something... very odd or insane
so. But still.

>
> >
> > Yeah OK so can we drop this madness? :) or am I missing some very important
> > detail about why we allow this?
>
> I stumbled over that myself a while ago. It's well documented behavior in
> the man page :(

Haha ok I guess we have to live with it then.

>
> At that point I stopped caring, because apparently somebody else cared
> enough to document that clearly in the man page :)
>
> >
> > I guess spanning multiple VMAs we _have_ to leave in because plausibly
> > there are users of that out there?
>
> Spanning multiple VMAs can probably easily happen. At least in QEMU I know
> some sane ways to trigger it on guest memory. But, all corner cases, so
> nothing relevant for performance.
>
>
> --
> Cheers,
>
> David / dhildenb
>

