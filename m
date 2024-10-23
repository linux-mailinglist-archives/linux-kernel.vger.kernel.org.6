Return-Path: <linux-kernel+bounces-378540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C48F9AD20C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DC31F28E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFF11D0148;
	Wed, 23 Oct 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RQceBIcQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kyVj7yS7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E4D79C4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702727; cv=fail; b=vCj/rxcY3nErUOL3mTQnef2+eaEL3HpSTgQFmg4q6+EywB7PFCA9/GFrNN++rzsa9Hm1mH0qSbyUn37xR8ru9iVm+ZUwqSet4DkQI4Sm72/dxIiVAnM96lq3Jy0hAgs+n87NlasfXb7RbLU+xlGejN7Wx9Xirf6O8tqQTryCHZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702727; c=relaxed/simple;
	bh=ltMdL419AjSbZixANr6NgBEfBMYi92WcyNR3TMVFPFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KhVsvsnkcdJVMN39C5jQZ5CTtPWecYJw7S1Q8ZUojE90BNa74yT3IapWhD+291ZcGL42A07ZROmDCzD4f8RjuyeE+vYDqwwWsN268cD8jfB+qqUFZE2BkMv2WbZe9+gYQTMROl4h9IVUJBRhy3GAae47PmOS6rXZX3k0otY8PFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RQceBIcQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kyVj7yS7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfeMx031470;
	Wed, 23 Oct 2024 16:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Y+o8PVjl7S+01VjmEj
	LnTEaCUw4NOCksjV7SynMkTVw=; b=RQceBIcQirck/a0qvbwG3Dnth3470Lg1bP
	hYgX3JnwmoTQIQ+wh/+7SSM+MG7tHg+LcWKjmoTj2LgZCDGOk/IcGvQ+fE1saLdH
	UqT1Ipc53c4ASE/wiVhPLFrwIz194Db0ppoHBOG0QgUsBCu0Kl82ViDeEzCTUGm4
	8v8ZG7RlyZc0+NNomswJ68b0zetu5NymsFr8ZANgQ+0e1UmoSGJ7tXtmGKXmCsG2
	66bHpcJ+UJerTv2WfImxUcC5QM08m8ocAtnuUHOvqXDGD+NCbRtahhI7Ai6CBl0c
	if9H5k552RUxNu/mc+5aA+76p/PJyvG/RgFq/bxSTbrg0McRVwfQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqyy38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:58:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NGPBuW036077;
	Wed, 23 Oct 2024 16:58:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2sknm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:58:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1RZJkUVUtstE3kH6J5nAK2hiqCu/jxMo0rF3HAwGjco5RlBiY4PifwdqJ6y9TOhwkhtK/obpc6AVDWPohuqEJCo6b2HjW9a79kc+0+KPgc05DjyJskDS4ss15QhpcK0sQsQZYP2YiR93kGnF4DltutBtHkV3P1OeS92j8uQiiRgJPQ5OiUPCIuJ51ax1XTspjLqLv0hkfRX24Ih2+087niNSh1jZgOybnXdYlGjlGRMLlTMgL+zkIHH9HXpxkhmUYzWk4+j8wU89pT1juTM1YHUal22WV60BADQqS3mPVN7t0HG5Ze08v/eUTf7HtvRJ0ShV3Nm4U0FEKYDogr6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+o8PVjl7S+01VjmEjLnTEaCUw4NOCksjV7SynMkTVw=;
 b=dWznvHg/2Hmxu0HGiku3cgxmvLZSdVmr/eVp0D37uZEQl9/oASdxfbezz1arAyEkSJEvs3Qu11zY+Ekku54LWaDJZ1+2p9aMVy0ARRyHwVxUqpXSzJSsLCeTwO27OffsjKbJQl7hAMnybGOpmO2iGKuMii3lKXtRRCQPYr9N8m7pVHFzUtTYc2oF62gYPG+uCvid4306kyGgTYAN/qlGzfTBucVKiAAxUgUHK6X41NKPUQZ7eKc+7oG2VumjcLrp7y+agvgtloxD4gu3nbNHGoMZqWTBRNQnk6bKXc2DwXJHJkSyKaOjwrELqeug2IA30sgQUH/DPYDj+F2gY59DmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+o8PVjl7S+01VjmEjLnTEaCUw4NOCksjV7SynMkTVw=;
 b=kyVj7yS7WwRvCQr54UPPcQK+eqnPPoOF65nB6uSRRNR+2XUtsKmneYFH+zJDc3u6X/vtK9LhFSR78Au1/f1jd224r0U1PV6vN25r+RUEZsw0BzEjkuz2Jf4vGmI7CSzjIDEi8E/+vCqh5JpiVy5PmeFbzsSMRCuq0N9BmXi8LVI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6727.namprd10.prod.outlook.com (2603:10b6:8:13a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 16:58:09 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 16:58:09 +0000
Date: Wed, 23 Oct 2024 17:58:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 2/8] mm: unconditionally close VMAs on error
Message-ID: <eae8bc95-8da6-4af4-baef-a678e27f4665@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <9a84bad9fdebbdb0adca2b5b43ed63afceb5bacc.1729628198.git.lorenzo.stoakes@oracle.com>
 <27a022e9-dd74-4269-b98e-c4d78bb5339e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27a022e9-dd74-4269-b98e-c4d78bb5339e@suse.cz>
X-ClientProxiedBy: LO2P265CA0414.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ece34a7-7536-4702-8bd4-08dcf383df80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f1RmQwhyufseKD1JZvbOjBFVkOsfCXWrq/kAT71DSMkpPJd6FGFCOg6F0rHx?=
 =?us-ascii?Q?mR2MpDKLeug3hKsrLhEywvcQ2z5ygNIESY08FirWbeZXpnpzxyh1DqMXa1qq?=
 =?us-ascii?Q?Ac9L/ACZ1rLlMxJn1384x4a1zL/dgp651xcOPuKjmbbqTCfH9RZ6ZM5GysQ0?=
 =?us-ascii?Q?chCRAD6eUvWsxQ9v+rL092o4o0bSqYRvls/4Ljf9b2LxjZSfLOBalj9BkuYw?=
 =?us-ascii?Q?bOaDxPB6KgUhoXx32ZYINFdpsavTEnwUdvuS6OXc4eap/lYsFaMbFfMoiTFf?=
 =?us-ascii?Q?ixUoMRhy3j6f7wTnGZgkND4lu/yDGFWXtL1MqYKGtM1J9hY94w+DvInFqoFu?=
 =?us-ascii?Q?X3NqB+gWptbQ3+/K1DSySLQydxfBLg/nba/lCF8ajmYTB0Lvx2tQ3NTUj9xC?=
 =?us-ascii?Q?AfNjtHozKOfbrpuixL75bVGsDjTbXOYP6ga0W1j6v7lmgf/XYzxcb14U8/98?=
 =?us-ascii?Q?vs4CuwAyKcqS8YUIVJc7CNwQYai64tQhKFh1vlAhv9s/iQXY5IhtsqoEPtUj?=
 =?us-ascii?Q?lHPojAzmY83jpQn1eAuenD3i7AhR1cVuLkCz1nae1p77v+kByRp2PpzArLyj?=
 =?us-ascii?Q?sxz4X9+Okh1gPsyDkxYfacpzrv7GuoEKQ0aVspZ26zyE1SPyZUAC+q/QkJLJ?=
 =?us-ascii?Q?c0RJIJRB1KWJ0WAG7LunY+L/MiDPYwjI545NHZeD3PUxLWZ1rX9ffWOwHFAA?=
 =?us-ascii?Q?DtaUF3Mcpn/tOyQ3GxK2Ul5hDcrbYErVoPtvjXouBWx9XMrMHR6g6VE7hmYB?=
 =?us-ascii?Q?yOyOUWVGdEqAOM9rkGukDA6OVg7x86Bz2y/D3e0krdZejt/ySqI/SOSAVTnh?=
 =?us-ascii?Q?QMVElTJxJuc5k8+FwXS2o7fmOReOoPDYtLENN1hWN+DJzlQQ37YaGGeLWc6L?=
 =?us-ascii?Q?Mwx6XbniEL6g+De0sGbnlzjNwd5Lh2XDFT2zVs9PRlhHEST3mbXepsQKPOxL?=
 =?us-ascii?Q?ZE5VKR7nJ/SEdqQZErJBIo5/nRLYGiup9JMe1alcNwPB9UoQMRRmi40ETBrk?=
 =?us-ascii?Q?fGhTouXgF696oUtpUPqO7OQuHlr/NuawOXXAciKLFlm2kZ7NMf8eauLpkrhG?=
 =?us-ascii?Q?W40vQ5URJGdWG3VLAmSn8i3NeFesw2UDkX0YviffSkF7bmW/HOwMKnZ87/od?=
 =?us-ascii?Q?favy8+xi4XOHddp6TebEAqy+jtKdDktZo+dsEVZ8o0lFcXDFgLaXpy1uvDj/?=
 =?us-ascii?Q?zd6YmrPXu6vVDGja2tMSEg8wjI+cWl2L+L4kX/0tbt70OxvzXwuJ1E8JIyDi?=
 =?us-ascii?Q?nNBpPmiNgYBusYYmefHUxdg4nwk5VyE839InypinVAhL5MyiJvPf0w/jIl1V?=
 =?us-ascii?Q?v+cBKJTN/mlPXdt+Kx2ngZDX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjd8eQ3C7JnnF2Wx0NYET1+k3O/JJeNYP4Sn7hfidficmlsIXE+7lxV4k2NQ?=
 =?us-ascii?Q?06PrvDPNpKU3DcELKWFKciuqhew9UkHaKfR2FYtyhMdoNju9S4DhtPDVc+xR?=
 =?us-ascii?Q?s/G9Pg46HqmgXNW8RvGMuKMTXQJCBhlX/KkbQMLgTk7g/QSZ/Wu2dZxpfYig?=
 =?us-ascii?Q?giayu+0S4WnFl1a4N79+mC2xYmh69hQYKh9wRRhgRESpV/1iO3aszfYROqaA?=
 =?us-ascii?Q?5Aml/L3QpWvl3+lgoguAA42DQavQoxiG9jBbOXS+bcRa+qhldjz3FK0+3LDi?=
 =?us-ascii?Q?M/6f3vsxt3Uwppe7Qj9oFAO5WbJ8lFAigqGHaNSeTC4vMuNr6ZdcbGlVS3D9?=
 =?us-ascii?Q?G6siDVLjvZ+B2n9ukqcYZXUQg/la1pVO6Gn5YuXLjuYrcRuJDq2zbPf/5Bql?=
 =?us-ascii?Q?ATgzui34x74G0Y8EK9o7gBG3lE/5Vihr0gfILtI9l3iqyDNVRFMV5Zp/0Aoa?=
 =?us-ascii?Q?T5Cz8k21RAXfYhXygjIyCZVWVxoipazrYRu52Mrq1/Tj0Aiay2t+z+njG8IL?=
 =?us-ascii?Q?xKDtlane5pKlai9UJuEqPPPkDxjRUAEfGQmOZVR4wGtYxgcocmXpr9BHE4si?=
 =?us-ascii?Q?aNSVj1b1qH74ibM4luJ/UNrG1HKjFjO+inXvcqf1O0kKkVIOOMZs5/+YNB/h?=
 =?us-ascii?Q?yqpq0jgvu8mQ5zLRb1hu8dtwJy0QK8se7Jg9cLLvRhClKqFE7GgUIkGFyN1/?=
 =?us-ascii?Q?6IKrgxxVCDZ3wEuR3CcF3sxdUZBv41G8uDkcHOHnNGD8LPD0Jd5GoMbZa5VW?=
 =?us-ascii?Q?zIh+Zp7ZZLbg3c1w3uz3BGkzgCcguFId7GMDMK9gykKemE0iudX5ABgcKkaf?=
 =?us-ascii?Q?7gBjOTaXlspO0uigpvz8+sqcuQ4gggLOZe4qUbClok9pqLYaBqhsKSW7iX1p?=
 =?us-ascii?Q?1XaSS5VlEvS//XR4UNaIWMI6yb+JFx2zJ3IloENpAoJTp/svWL3BZjZyep+D?=
 =?us-ascii?Q?ySdAPGcztDdKB5pqwSBY9IvxGZDB+aJWpXqnEbzDjFzqKPsG4rnK5b/N38At?=
 =?us-ascii?Q?cEpuJxSW3NrTXE7NLMEX7AX7IfqNIZuOeMhZIJ9roqAFprvc6xLeRHACkd0k?=
 =?us-ascii?Q?Mwo1KDajT0EjyxO4iAzBNq263ZqPbNwMkARU+h0w2s5kBlN0Z5XfZegpHoOQ?=
 =?us-ascii?Q?3OE3Dyk/eh5BCLgxhkDE54ula6txYOpjBiIGrrR6KM0N1A3/gdVW0P39w6CO?=
 =?us-ascii?Q?jS/EO7aXIXwbPdjTug9/NFD12HoSxrmCHEZhy59JPKiyZ55ebdxmSHEBchFy?=
 =?us-ascii?Q?me0fYUOsu2U4puFISphToJZq6tPCVGqm+mp4XvuXAaEIcmuDtHLhLbZc0Ulv?=
 =?us-ascii?Q?yk2wz5wVrfKodoED/qzW02vHwivmDrvZoyvoZ5mJBDwESbY5Hk63zxZnSimI?=
 =?us-ascii?Q?s2e6yz6ZoyaXgVH2MebnGzJC2Y9eCtA5YyDkLY56kTRtiCCcmAfO+ZcOMEqm?=
 =?us-ascii?Q?w6iC7GpxVKsPxdtIOUg9wBrUvUguGjA2KnohLitppi/e1FoK9Ck9jlctfISc?=
 =?us-ascii?Q?rWmBgtLeMOPsqLyKHjNHHn3IdXpusZd9srsYYVYgp41oNdIzliriwczEDOTa?=
 =?us-ascii?Q?fEosT+44VaXRb2nMYoBMe/6QVVf2ZuJT1QB59Vg5tIfWqvdArVOo0lZy8Xww?=
 =?us-ascii?Q?oHjwW+im8b9rFVCa4y/+Q7f8ZRt9wsPHNhf18NZYsTZGcaCmYcRSz0S7e/4S?=
 =?us-ascii?Q?Cv62bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rI4ly2TNCYvdiyE3Hc8oCtGEQrRb3pYNwBG8fabNRCGzqcXW0fp1y2oiuR3x8I3LFW9j90lc0oASP9DZ7li24zLGcOG+GFJa8+UuGMfnYhiiOE+ibZ6pwXgheK6h8A9/arMMoFSa6e63jTEsAguFUWAj/+yHD6Sp2y4w0vgBxjToBbIEKSFVdBoWuXXoFBHO/2MHNZlckgeH3IzqOM6uJyihpHomXprEx1ecHl7LD3bzhpKaQEFk8BS9s2ZBK90TN1KKsr6bisoWkcIIevJBYmFsowobnBvjgp3f46B8qXc6DGgZDEh8vxy6ZzLvkX+2YJ8Gp587xVEPV6lR9hvB2h+nm2Fid365eD/LVJcVycYfyUPzQQPT1QgmpXTonxWbRmt5GJWVtsdJN/sJ6e6gN0/0H8kgz+aIUNB5eQP+kDUS9DGbbELKaOSC9o4a534L4YSAH3f5qlAPZUuTktQPFLTQsL3YoPMJRlS17fmExmIT5q/5o9SHq0p80R1Xrqu9qU1qjfFP39znKrnUAXdRwJzJN7FMHtMOFImcM6wGDbybkUfB5zE3N8TKanaBHrCmlx0xpG58qDjy4AmlgxE8VQQnTn1lwbhBXKh/4jXmEiM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ece34a7-7536-4702-8bd4-08dcf383df80
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:58:09.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kzXrWoL9mK1Dx0nvdRQ3ApqO7lF+ttKovBx2Kmyo3SFRjmxwqqh3Nkx000YhVNmJ9gdFCcXNi06uAw63D2/SGjaRRHTLYVpvCHpYVRXD2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230106
X-Proofpoint-GUID: DQYH5xMKQEg0mgnm48k15b0fIS9a0sqZ
X-Proofpoint-ORIG-GUID: DQYH5xMKQEg0mgnm48k15b0fIS9a0sqZ

On Wed, Oct 23, 2024 at 11:24:40AM +0200, Vlastimil Babka wrote:
> On 10/22/24 22:40, Lorenzo Stoakes wrote:
> > Incorrect invocation of VMA callbacks when the VMA is no longer in a
> > consistent state is bug prone and risky to perform.
> >
> > With regards to the important vm_ops->close() callback We have gone to
> > great lengths to try to track whether or not we ought to close VMAs.
> >
> > Rather than doing so and risking making a mistake somewhere, instead
> > unconditionally close and reset vma->vm_ops to an empty dummy operations
> > set with a NULL .close operator.
> >
> > We introduce a new function to do so - vma_close() - and simplify existing
> > vms logic which tracked whether we needed to close or not.
> >
> > This simplifies the logic, avoids incorrect double-calling of the .close()
> > callback and allows us to update error paths to simply call vma_close()
> > unconditionally - making VMA closure idempotent.
> >
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Nice simplification. Nit below.

Thanks!

>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> > +/*
> > + * Unconditionally close the VMA if it has a close hook and prevent hooks from
> > + * being invoked after close. VMA hooks are mutated.
> > + */
> > +static inline void vma_close(struct vm_area_struct *vma)
> > +{
> > +	if (vma->vm_ops && vma->vm_ops->close) {
> > +		vma->vm_ops->close(vma);
> > +
> > +		/*
> > +		 * The mapping is in an inconsistent state, and no further hooks
> > +		 * may be invoked upon it.
> > +		 */
> > +		vma->vm_ops = &vma_dummy_vm_ops;
> > +	}
>
> Nit: if we want to "prevent hooks" as in "any hooks" then we should be
> replacing existing vm_ops even if it has no close hook? If it's enough to
> prevent further close() hooks (as commit log suggests) then the
> implementation is fine but the comment might be misleading.

We prevent hooks _after close_, if it has no close, then no, but I'll update the
comment to be crystal clear.

>
> > +}
> > +
> >  #ifdef CONFIG_MMU
> >
> >  /* Flags for folio_pte_batch(). */
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 10f4ccaf491b..d55c58e99a54 100644

