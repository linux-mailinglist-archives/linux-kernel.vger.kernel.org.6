Return-Path: <linux-kernel+bounces-377874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9995A9AC7E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293401F27E07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F5B1A76BB;
	Wed, 23 Oct 2024 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EG8qhHZk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I3+UDnie"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB81A76CB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679198; cv=fail; b=eaXNpDdOkUA3y5U1Tr98AeCicbz39nlPnq+5n4VgjC8QWmsgi8M24wfRQ440EXWx85Y/fsKFSDwBo5vwm+esolLNlLUeH8XwY9GHfNRnEGQ7ySeCaeV7x02Z9r/uE+BOENZTDtdDB2VNnM7zFuzRakQ50hJEdLCnsYzZdSym/FY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679198; c=relaxed/simple;
	bh=eJefUcdoCXkcsi+XPYvqT55WP3Kkp7YXncEzGIZkRT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DgTg4LQFEgzZp71TYV4sF4vqKkDdGc1mujihwsTxGauZFnyZ+TaVnWRR9EK9Me/+eKLkcTbUIsvh8tTKLrfDGH+WTetwltXWyJRCTHM+Or0nZz4SVtY4Z98ACCNawV/iz2jGZlqxmOEQtIE5ZDsRfDyBWgtnz1pTD6H9w82OHQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EG8qhHZk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I3+UDnie; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N7tgd5018202;
	Wed, 23 Oct 2024 10:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=wvBfxi/BJZshP6NPsY
	vnhCvYcVkqerhcDf05xAgxs5k=; b=EG8qhHZkl1q3cuQVEm99jrdXuZVFq5xFrk
	qVZHLmtk6EShD/6dcQamhh1EbLZyp1H7lHiT7CkTrd0cTgBWSw1eSaaRzQWSTEWA
	BHoCrKJm2DyeimH4nQet7LFJE+8Wil70/TqaA1gvjBGqRPiVQMgvfz1wDQPLRZWQ
	xdII/NBTj1WPlEopJhyHJVu3F2ck+JmQaSTgYSgZBY2zHhTZwowDe10U77BQytvB
	RjrxN14oWC/UeNdvrHrasQ3enRgC8nWBzThluY9sOQ5ESj3uNLWs2/gSj/894evT
	u2tDq37cBgi8mWiTWKMJ1zOSzch8+EaoJtV8lA9qs90Cq8mQ4hrA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55uyrtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 10:26:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49N8k12c031096;
	Wed, 23 Oct 2024 10:26:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh1b7bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 10:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0Zaf9RgJDIzCZiWSVThVgrjnSDqeQcmUbfhXmn6ecaCN359bPAKyd4b7kjQIECTIDzu9RBJq5ALcXVOzOjjx1gKS7AxR2HpDWs9Q2c4oJVTiJMB+QRzW4/nmy0OKLcF0/THn85WmT3+EV/EuqznYO87W9AXTblPlMW726J9WkOP4OG3CVfOM1kMSHxx0JgKsEaDOYe+ZGP7X2tbHlGAX2UuKy4i7rJA08bDCDUAW+ZniZzorak0BQ2BtBB0kcj141hxc1uj86d6a1f3TWnGYqQRr54AeFYhRdgA6Np+kweb7KAyAj7WTBmQn5zqT6OCZUQ4Lq7bCcBMGBsReNu+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvBfxi/BJZshP6NPsYvnhCvYcVkqerhcDf05xAgxs5k=;
 b=RjfPt4TYKfGfFuccg/r/VP//3RlyKjwNC4S7VCcNntEUGEalFKF1J9PbszCCqCp9mlrL0g6PVA9xim8XSdifZy206/esg8v1xI4iPKrCdWGyEDPgAzWH8yTB6EV5Bed+mJAL+/dlTxwRbOMJQ5SGW/F78sFgxydhyV32RqZA0sHjDoJUsHiGAs2JfUoMxemc5qgWAjvxlb3mAlSjCKg/Tdqub9Ayk5nm9RyIoGke1LJB12aqAaNAaIvDlq9HYELvqsi6vYII0Z1HFg0zpXHdgcv4MuwirPwPeHkYqoA3RnNtaUXMTwkfxKHX+/hZiocaxgr1pF302Wm9rElk5aCS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvBfxi/BJZshP6NPsYvnhCvYcVkqerhcDf05xAgxs5k=;
 b=I3+UDnietPXWyfTJzCumKSR7aiorR6hagg6IJFSk1M1m+0lf+1Rwa9kPdp8BfCtj7mmqXoveoRaxGDicm8+EHkWOE+qeBjHVSGLLQXVnGeDYnpxmglKNUrRo0hvGNXm+LecJN9yOWFCdTnDdOLQVt8JUAqa0XgrnJNojZ/sERyo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6362.namprd10.prod.outlook.com (2603:10b6:806:26e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 10:26:03 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 10:26:03 +0000
Date: Wed, 23 Oct 2024 11:26:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 0/8] fix error handling in mmap_region() and
 refactor
Message-ID: <ec22d5b7-14e9-4df8-9e78-ca0af1b09930@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <20241023032236.c7a4f842b7a71c0e492bf322@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023032236.c7a4f842b7a71c0e492bf322@linux-foundation.org>
X-ClientProxiedBy: LO4P265CA0277.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b45eab9-3f25-4427-6216-08dcf34d18dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MxFCCFf4UMDGDEhzDaHo+afitxxPeOUscy7f/pCQno2To/UpwQt+ARFlskJF?=
 =?us-ascii?Q?zPrqUNKYBftR+htbEPmwCwrHPvkHojH9L98NAXnezZy2H8kZAHItUS9Q3tE6?=
 =?us-ascii?Q?O82j4xTw13HywrSvS8Lczl7lcSzYIs87/aqmyfppisYc6d/xNIyTVTIXPqBs?=
 =?us-ascii?Q?Y8nyBEBxr/3GKj5g41c05x/XcF+et8QuLx6cYhH4o145IbIpXfB6gVRdRKWw?=
 =?us-ascii?Q?Yfo3CvJyiF9uxyjiu6pgeyOgmgV33PCoAeERQQwJyPU2fiC4uvqw6VTgVD6a?=
 =?us-ascii?Q?lHqY1iN2eZSjEEpUnuF4Qm7ucEaQnXyqrbcUjiiZqCovcUeds/Bl5OPS8T2W?=
 =?us-ascii?Q?jrKvgUlfh0kzStHNmJ0e31B17wAyVx38w6EsKM/np1PtJClbahkZF8TP7MHJ?=
 =?us-ascii?Q?rYv41/nXI0ULV9M18yT6L6leg9TIuArLKd4Q8ZUODJOftQ3t/Kfo45ARDua4?=
 =?us-ascii?Q?+nPo1DPPTW442dK4uykKsGzQnUTtxjrFA5+XVvgBs0nnFz4ufN30F/QA/NDG?=
 =?us-ascii?Q?Y+3oCaLJE3i+rZ9N+5VbkosgHsRmtAJQ/LUo6QDW7V/+zZaDm1rTaFzlvAl/?=
 =?us-ascii?Q?aFp7A0qmNe1ybjYOEYT6Foh+vGfasAtq3TQP8N6vcPi2D4LOxDpzfeehQ2s9?=
 =?us-ascii?Q?1jLiSOKC8ob8mXX+QUgFyRQ0026Ym1O4Kd2NCIOAOEnjVrKKWQUOjCia1AQd?=
 =?us-ascii?Q?pIan12imVvre+t9qWVzdpcDm3iQUoux6BS9cAl//dDjNQuTt+v2vIj4y17jq?=
 =?us-ascii?Q?Dla69cp8Z1iAvk7/Qs1K93nBAxmTT4UfAGp+hJP7UNPynBu9K18u0KgfkKIe?=
 =?us-ascii?Q?Gxsp+LMs3ct01DN1h+vhAJeruGz0H02ZyoVNKs+XQFbUHl1224B62kG3V1uL?=
 =?us-ascii?Q?NItsxxQgUxsimRut8zzvsElJkApCX1M7O6o9n9KfK3T3OGLHSRu8FmZrZpCk?=
 =?us-ascii?Q?aIXl2eb84fKtNdbuNDcTv5FqJcHrJwCbrWQoSpiZ+BopQgF49WgVB+u4IL4/?=
 =?us-ascii?Q?bbsjlGKjI77+xHBwMmZGE53Ugw4TPNONrz3hPK6qo3fgaK/lTyfmGW9ah8Y6?=
 =?us-ascii?Q?z9stt6x2kR5VU8om3joxvOnQjMmjvtv97WSn/9kuM7Gcp8aPcu5l89v95NiO?=
 =?us-ascii?Q?fDW+eGcBiqro1qKT6/e1nP2hJOXFRa3CVJBaxJFpGuOdY47Nq1xvDekGVuCE?=
 =?us-ascii?Q?BV4/AodRywYM3HgXaXQ61Os7JYsQoethzxTRbotojHoVJKrV/tFw3uCLLDNf?=
 =?us-ascii?Q?d0bG+l/u3kj0yVXrA6+WZRwpxCik17l5lxkef0hwjcNs3V6RTxLADWmEAuxG?=
 =?us-ascii?Q?KXiJPQ3OAe94BOKzBe9bW5y8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QRzVae5EGERQOd2VCb2oCd6/H9rRmMtPViPmbGuGfSVUa20WD73LiKObldrN?=
 =?us-ascii?Q?W33WHdSCUSoCQnOIP9igWXkG7bRFhIOnxTi4tsIdm1aA1wB3rbRFMp1hTP+i?=
 =?us-ascii?Q?N0imWHJxtwJgEwrwao742bbsFOgXZdM+DK8NXSdTzvqTA7a/wf36sZNQL8EH?=
 =?us-ascii?Q?AfMzJQWK06oXQ+FZm9jEK/uGb9timk6sHw5MhMfrDvFaJuwmJGK2eobDESfm?=
 =?us-ascii?Q?FwwfVdsLhgJQCMOqeQuHyNK6qHcxISHuZQrHtW+a/B7Moo8sqh4sWd1h98SS?=
 =?us-ascii?Q?mzL9LEPI9MGJ7VNkoLcEWrrep6ESdXQKEOfOuvpXD2X6k3dSNtjdaDt9O1dr?=
 =?us-ascii?Q?ersBFreJfAi6Es6qtX2SM+sDbqo3cGXO6/7roED6hv2HyKBA7g4eNhYfUgcJ?=
 =?us-ascii?Q?6qxNTWZfyIYLdvC3GxVWMAuB2reW6iChqOPEz9LxArsqyde3IHjl/6OU4Oi0?=
 =?us-ascii?Q?G2hNdHiegr6Avai8/ejTNRT//QzEKWrhBEso+JpmPlyowOAu9uaeYhG+9AwI?=
 =?us-ascii?Q?2F5uCmgUSTqwQC3qL2QZS04ccFN70A29WBmVKrcguQPzeD8usWe8ExvEzbH6?=
 =?us-ascii?Q?cGFhA5STWlk6+1uoNiLgZIJKVQix/AfGclYehcC4MtWDp8ubYNZObQeIP+yj?=
 =?us-ascii?Q?goBSO+JYPFl7EdUl7IExTDkvpIHOdgwWifiw0PPpac3FQd2Ct5CXLeoxi/rg?=
 =?us-ascii?Q?16s7O/Q8426YAfsoxMIJ97sEc24EYEFngZpmiQzhgiI880oyLRsV19ub4irC?=
 =?us-ascii?Q?gUUSOIO+nURVx3r55u06XUFyjperG6dKcYnIY8kMA2YjwPRQISKtEhB5dytf?=
 =?us-ascii?Q?T1dbYA2udKoGCI+NsCLh3nsEO//40FYoKMcleAPFr08R4K7SJ4RxSYW2Z6+U?=
 =?us-ascii?Q?dFXDU3JZpQQypuQ6JJz4gal1Qqr/t21BeOF9ycmrfguMN+XTjBzc/9OeaRA/?=
 =?us-ascii?Q?txdzO55cs9wbN7casGUnNBIArIypj+dS532hZD65ZGbaoNfIEFNV7xwEjVEn?=
 =?us-ascii?Q?4vyUipuS0c2gloIS97050bNHOMaHEEfLhzQ8w7nehS+z5i2xxShZ2KmmSkJ0?=
 =?us-ascii?Q?Ji/1ANg0z3hEImtiUVeAF76KbJCPAW4/rjvvM2x+75PsuYx/IqLg8VdLYiu7?=
 =?us-ascii?Q?srf2RntuFKWe7tscoDU+SU4p4FOsdh40k2LjXCP0P96QYjzWThYVJ3jcpwmr?=
 =?us-ascii?Q?em58mQ+GMrkUOJ7mXZjqTty7Ce9yFl2XfhlhPuyY7d0LoqIzIHXo/WFTxTMG?=
 =?us-ascii?Q?tJFWNJbRELhxf0HZ3B+4kXlFDdL/ioBmmBGWHEAiandXadIagN7e5dXcxZdR?=
 =?us-ascii?Q?gG5s5xlpmYDuwGcqiIpcxJUtFdsJc8w2HDh/CGST/vr40ojfDkvcZ3JpLjax?=
 =?us-ascii?Q?sDTmehcIR2JrYis8H0ToWxgnpR1Klcqf/gri3qANfZnWLBdVXxNhlsxTk0Zs?=
 =?us-ascii?Q?t07MUZHNJCQ49fc30nel+DFBWqghpjgTJpZoZKQlUjCpBUcLjzlPOA/t4a3c?=
 =?us-ascii?Q?SCu2rqNDbPUgLX8NBmrAXyNpA9dC5eprwquwwVbyYAbfATpXIHxjPtPPZMde?=
 =?us-ascii?Q?MbDrE1KdSKtDiF5VXgbjfNAyHZJj99g85VT2NLm5PkHExanXEweuB4wr6uMQ?=
 =?us-ascii?Q?UVJ7pzgL9victBLoYGLUAUN/781jc2w8okz6lTiH9RzLTkmHF+WCnxUy0SW+?=
 =?us-ascii?Q?hqH5+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kJ6YLNOZ/tOgRifmOgJ0fqJ5GJLtGtEnwwQzOg4p6vr2wH4YqIhNCFFZn8QqWnO+PPIqeqx5F8aV3f6t4A5ev21CRJD4uf+tkU7mDKvDWqM5Jel5ZU4Oa/qLcBUukCY9OvBr857i5PHyeaxgrfexrqkdfbWWXOgAYixw9Jj1+kxCRCh2M/jKaRDhYDAzNWqh+5jrs+o5wfksBzlPDvDnLurgCt5vH8YtEBfnzhAAeErIUZN0MBg4BNdRDWqmVFqRBqvlT+s8eOuy7sF7Ytd4HjNrOoYSbeq59uAJx6kTf87GpuD6ufq429ZiNdgCINtOgRqGc3AW4Ujj4XA7ETmee/0jr6qQBZxbFqZG8XXtxwg/oEJxfcH8npGMKFY9Q6JAZtuSPkK8+02aEqUdf0KxcRE9qfP4Al7mqaJWF7nlAbwKG/1N7p0mGzG0uPXrGe11dv555J8hFKTZONTdsJtR3M/hVzXJ+GFEAWJpR0qVg5MUnL0b0Xwr2iL49XICPnfwR64xWLn1Hn/2q632CU2mxAhYP5vJqRxPq3vQm5pHjTaE/XAXCJkc+aRl+z0Yy/3dXlry47tbH/qhHQQe6eSZA8HWNlVGlIS3y0u8fI0yM+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b45eab9-3f25-4427-6216-08dcf34d18dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:26:03.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yON7S1qMitJhKXnGPK+mI88xd44yOoJ4OTF0K/MbcZwHxY4qJFqZxLyqhEP09M92SlDyW5xkWNOtsZ/RG4JxrZjlGd8ueGYMjqaduufH+Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_08,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230063
X-Proofpoint-GUID: sXyq9VRc-wdG3o7tib3g_Qi8-MhTbpBX
X-Proofpoint-ORIG-GUID: sXyq9VRc-wdG3o7tib3g_Qi8-MhTbpBX

On Wed, Oct 23, 2024 at 03:22:36AM -0700, Andrew Morton wrote:
> On Tue, 22 Oct 2024 21:40:51 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > After this we go further, refactoring the code, placing it in mm/vma.c in
> > order to make it eventually userland testable, and significantly
> > simplifying the logic to avoid this issue arising in future.
>
> I'm not sure that patches 4-8 are strictly 6.12 material.  What's the
> thinking here?
>

Patch 4 is absolutely critical and without which 1-3 don't really matter
all that much. It also needs to be backported (I will be doing some manual
backports for that once landed).

Patches 5-8 could be held back to 6.13 if preferred as, while nice to have
as they do further work to eliminate this class of bugs, are not as
important.

