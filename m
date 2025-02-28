Return-Path: <linux-kernel+bounces-538530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79500A499CE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525423A715D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F7026A1CB;
	Fri, 28 Feb 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CztM/qOf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AduOMp1/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF58468
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746918; cv=fail; b=DI7+eAtL/FyQSSf1UmyyeCB4i7FshvVrJqFBbSLCkUwLFYg1X00BgIZ52M+pNpPcwNN79Qc2udPvnn5XXUDCeXOH/zIt/HQlIEgHNJvAKkLavgj5Z4qA14KkJz2eD9z3Jys4WcSihL+ylnmXzi/VzFHh9p0kzmLEotAIFhxjxVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746918; c=relaxed/simple;
	bh=6/+aSXJGPOXidhYPqOCP3v43ZPt5uj7LbI6fkYH/gc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SCLo27rFhjk6PMpQDMRF8jrLbnZ+IcBFGfO8MocM4c7/FDQQFRDyKJvNF8wNrmu/DBj50AHFYjJLd89a+hEq+ctHbgZrLiocVaV/I4+O2kynjQnSI/UJOW+QK1lAcEs9Em9FXbLc2G3D8V7NsfKvDzLOx+PGn+6z5hAzCTIZuE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CztM/qOf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AduOMp1/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SCffdA008419;
	Fri, 28 Feb 2025 12:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Luq28w3brGDGD1xhKN
	d70Oxu/VUGk7xqjaOSKUmjCr4=; b=CztM/qOf1R7KODHUMZOSUM+UpCSahyCFnI
	3FiblYdYy8EJMRZn/8vo9Ed90E4ddb4EaqqqdLbrHDqnSqqDslsLYYZHqirDVcFr
	cbiAfAKI3Lc0wuumFIZbOCCR6o9yBmlHA8QUVzYijj8sAJNQl2enD+F7pk9YDrTp
	qu0b5Xev+OkFhoCmFati11b1HhwVB7QcB6uh8wGwNTeBaIsZbC5IOf2yAJZpm4Wo
	Wa7LFdSFRObp5OgIfJR8drjxq9hIy+BX10CMAnmfzPZzbdAV0DZJ9YnYsU/CBL/9
	KucIw0AokVTVb/g6EVG70PeHHpTF764Kh4XZ1xtGEAMC1njD2qpw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451pscdhga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 12:48:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAVaZN012668;
	Fri, 28 Feb 2025 12:48:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51et0f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 12:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/EQ1OS6i8Lrq286lTQyDABmXchagdX6YvztyG6wmSrlUKt5UmnFZROZmRCuOsMIHNwAmkrSetD2PV9OhmqlEykiDmzqpAFPrlkSVCVtGfP4chW9Jz/gKnqb/n4nugufWlY1n1T4eCK546QFmkmaXuYDbgBPwyLufgilCPQOtTW4/oSFdDDsf/FRHhvZYZEkU0ZZ+QHnRxcqgDvrkZAtvk2ZNizNjEYwDfc3Pbk+cXUZ80Odn1bgRxeoZbhjEuhH73kwMcDb0KGMcC+pfyKc2SoWK3OWoXJhDc5Ap3ByRqvvUb7F0xiY60Th9IJGLA0kFj7JlhqEHvLsDrxcTyNcEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Luq28w3brGDGD1xhKNd70Oxu/VUGk7xqjaOSKUmjCr4=;
 b=GdO7r0YLSGgEKcyQ4GE1CauHp8GwgZAfbB0ycE28htmWueLFWKCqsgv+F786LzRE66UWYdxCFC1QumV0xgDOs2bTPJ4Tcs4nHqM9D0EpAVhVv77BD847CzixWkWEzzYTLF1n1xbUDR/ZI8iWplnL8GvCJm8q4i/ParxwBnYOIfkGmuyUAOBA8mvU3TZlD0jfugjN4xXR3uZk9G0HNwRozxzhtXjZ3BzX9JE1REa/dcdHeqD0CRqunw9o16qgi4vitP3FxZmVS3ZoRp8JZ8fh/OWVckU5nWAneO4STyo/N+5Uq76M4GylaFXhir/4mkA+wH3Z6zZNbWVnGaXl7e9fOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luq28w3brGDGD1xhKNd70Oxu/VUGk7xqjaOSKUmjCr4=;
 b=AduOMp1/ZUuv7/2aF68EPRfs1gMjUuFV1F6AYXmWh8U1W6OVnNdKQVLbYVV49wKMxcR+bVFdL+j7cuWsHTCsQWYFvFOld1p95oD4etupHNSTMDUNagk/t4MbqTMpFgCkonD93d16g8PV4sh2s8Y/dy9CXJvfLr8SDYBX1OGvTco=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY8PR10MB6753.namprd10.prod.outlook.com (2603:10b6:930:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.24; Fri, 28 Feb
 2025 12:47:51 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 12:47:51 +0000
Date: Fri, 28 Feb 2025 21:47:43 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hyesoo Yu <hyesoo.yu@samsung.com>, janghyuck.kim@samsung.com,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] mm: slub: Enhanced debugging in slub error
Message-ID: <Z8GwbynIs1N_GeE6@harry>
References: <CGME20250226081354epcas2p44c2f53d569296ac2e5f8a7b01f4552fa@epcas2p4.samsung.com>
 <20250226081206.680495-1-hyesoo.yu@samsung.com>
 <c1db529b-f16c-4195-8832-8f2cecd84ece@suse.cz>
 <a206637e-f63b-432a-aaa2-2e947ae5f4d8@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a206637e-f63b-432a-aaa2-2e947ae5f4d8@suse.cz>
X-ClientProxiedBy: SE2P216CA0055.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY8PR10MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: d3decd55-2a37-41e7-aff6-08dd57f61c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xa7cnS0D6iF6tt4NuY+5rDlG/FS8D+qkSFBqVQLgZMsTp2PzSZbqFmDckQTj?=
 =?us-ascii?Q?KCTqjkamTab7p7BXK13hBVEjEZuuOYlpweKpX6XrLANmQxvQGioDIvjEchuT?=
 =?us-ascii?Q?U+3uvg2r95ynhnlhF8RiFvi+PTNBO0kZQ0U+SOeha9CpW3aInvpbJNhULi2N?=
 =?us-ascii?Q?E9tgM2zAMWI9qmw3O71A9+g8sPdh41QijNsHW6Z1bsmDnAG5kbotPxdV7x0y?=
 =?us-ascii?Q?Z+1Ayq4RrJfZGa2oUmFX/3t5+WGL3XP9fq9JGlyqjT2mMFk9P6kS7KKTlZwT?=
 =?us-ascii?Q?fTkqq0t+KzRwgiU2ZN/wcyoKA7GX2Bookqrg4BDO9gAZ9r67RKjxrZ/42xxe?=
 =?us-ascii?Q?SRrCUIljgEMJayiHHhT04cBkBI9LGWomhUbXqPPNv4VIsZD0N9YZUbo0ErEn?=
 =?us-ascii?Q?Lg2napdQpgtfuSbXJfdkUza4Ee+yq24FQj8+2fZBsQmBpq8TZg0xy5FsVev9?=
 =?us-ascii?Q?wl1BeZpwd0A3d9qoi3MCtESeAo8d7LE88Ij8iHoW2k4OVTmoTwKjv5VaUtPE?=
 =?us-ascii?Q?8aK6No9tZ18mDtkX+1To1DrF5xAsQD8QaehU54Yl5cgNnZKiTjuZP/DKZmW6?=
 =?us-ascii?Q?03Glaa5KMFaWNTtEp1zMJuJYRgTa2i7LnPAyW/iQ3cJNngdeUbUD/6F63jvH?=
 =?us-ascii?Q?cAKkBNL78Z4/V9Kkc0gJqIlkJbQqS86e6Cs5vLZYWn2ThdiBLA6YvuU8JWOI?=
 =?us-ascii?Q?gFktfsiQIde4y4BAAV/ufjvs6p8ks6TilwVxeVubfNWvL9JxHnHKCwqu8BI/?=
 =?us-ascii?Q?3CbIWifAJN00fHhIkxk7gdRKGNf9gPeBFVNkdC7qGmyGFPL+v+o6GQXKihSr?=
 =?us-ascii?Q?JCQcQkDEMWs3S/cSruS1Y21Lwv607FdVk7+NvZhdCkJVmUpogg1TSPYhokRI?=
 =?us-ascii?Q?09FQPerN+egVwOzzngSfyTcJugjZ+YUbghPmPtrAYxuSBWRAyoxuUF7DTgNC?=
 =?us-ascii?Q?DVGXXucDVjqc1VHkeL04/wlhnpibLa8nCFuyMt28p9te6hRk+zh1nFWV7fGx?=
 =?us-ascii?Q?/D3JR7MSp5K7YQjMy172zEH6TysWNL7M4fZafxQlP3W7Cn9kFNbf1+sG5w36?=
 =?us-ascii?Q?eR97kW7E6a5+r+tw2uECo79Sj9l/t9OpBYzaTxOpPujzoEwIuHNTXXGeXnHm?=
 =?us-ascii?Q?lxTeWSJUhDQq9qVdH73yRWc7v++PCPAS/SqSik+eqxF/hRHDm/UF+JABRA0g?=
 =?us-ascii?Q?4pu+r43ywa37z39T9E6WOOUEcG7x+rlOxg/05l2R4gvFoFhnWaI2cP5THltl?=
 =?us-ascii?Q?ZCWWznvLxu3RE30lDWiZWdAIbX7qfGGPNzRaXf8gzf1nyTI5/VIRZ1QNH0jR?=
 =?us-ascii?Q?uAxIwq/hcxXKhD21MVE6K7NH1oR0mQgSJq31ZPjFmE0btNYqJEvPX6EkstG6?=
 =?us-ascii?Q?x5oZvLl3sndx/Sc0IMjaF/YOXGJtAplY3DPax5uncReh+eUM5A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TMuQXCIgnnrUZA403+IkfTMGjDH7bm42xOjGpNAFDmeUELK2JjCOQWvZyBZe?=
 =?us-ascii?Q?QbLiAqO803yMErSGjy2Z1zhLVbLz4TDZBtwXA70ViszDXEiX9GQtFbTaqjIc?=
 =?us-ascii?Q?47TwpUd3B8m0mtO07SbTbcRvois8s+n3vxN6NIVjUIyh0sfZd8ayh7aUxvA8?=
 =?us-ascii?Q?gYTom7YD7j+TjWmRUw9jJqQ7p4ERjK2mJHR4Cv9Ikk+zIg+JhgMthTqUkEt0?=
 =?us-ascii?Q?lwM4KxOGOJqdTbjnWswmiYX6wWrS8RtaAXm0DOhtqT6UOgOH69MYUqk4mWay?=
 =?us-ascii?Q?YLxMtb8nfyTe3Tjsqa/ovwuPqQHG3V3py1bkYUYYPTPLOguB0n94q97XdEMF?=
 =?us-ascii?Q?lLP9YZQUV3d2s1yoF1LWmuPp/EN/nvX0VfEjEwTJyRgKmeKVNpF8eVd8+F4y?=
 =?us-ascii?Q?/AbENsPeg3H9CD9LyrvBSgfSWRa7Sub3jK5BLrH0lRM4pFP0vQ3YrCZTDpj/?=
 =?us-ascii?Q?bNrXCPYfO2jdulPEbDvcElDMkRH7MRrHFr2u08kTK0ZezZxBD+Q65iAtZbaE?=
 =?us-ascii?Q?p2J5cWcdz7TZa5VFSosyMSfq8IA7Ok1Zagxlit8g1zxTDmYhzsP7JId3e1NP?=
 =?us-ascii?Q?frU9igpnfKm/6Wkt2TV/JZWv4u806k/oPIuXMxElq06xJr7cU+BAHBQMzOSe?=
 =?us-ascii?Q?4umnbccvPaHEC7WEEIiFw9coPw3sVkqrSgEG9kGAN5YbEQLcAwyDx9nOzeXH?=
 =?us-ascii?Q?FmCPoDaocZDt9L20SEj8L/ceorlEJ1CJVmQllUfr7ZecmOPCarIyTAHH12gZ?=
 =?us-ascii?Q?VwZDRMS/9ezHahaFEcHprxyQ325iMe+PSYv36bRxbdZLw7yvth7Xd72sfmFv?=
 =?us-ascii?Q?WJ6O4CMNw2SW7SYlfAkQdcJbEDYGYWpVkMWVx2ITuqI21gQJRXFZzGSzwm9Z?=
 =?us-ascii?Q?6mIzjePFycdh8Dv348U8G/pkxPJhJYKP7l2Xsxe5ej6wR5qyyABArYfg0kHA?=
 =?us-ascii?Q?aEbYJ6xD3RZQ11XGDQ7owYP08er+H+E0qx1VIAGBcD6geCYLRUgXuHYDhg/R?=
 =?us-ascii?Q?WPCdktJ1sSd4o70Kk9zRoylaeJGRvFcmxIHoSdtGdrPDbdfQc/9eCc8f/P3u?=
 =?us-ascii?Q?2s6b6sP+g83+b1ekg2X9cGZQ9yBKWud7hO7x5NYVNKgDPpwhxAswWicezkKl?=
 =?us-ascii?Q?B0lfXpEEiqB5yGziqNYbBByNuBC7VDuuxMvlO31mfMYHQ3Ktfa+sW/wiltx+?=
 =?us-ascii?Q?KIOR5dQE9HXTeqyUX2S4fXt6pg4ABfkB2fBc4HC5YsbdFAv2L1UddCYc0khk?=
 =?us-ascii?Q?Xo3Q9dKjNkCuMRB+8mxXtOSTh8rPt96+kX0e1jh+25323s7d4g7WkobBayKo?=
 =?us-ascii?Q?/4x02j3Wazk72yY8zI1k4qdMXQObcl/cvuISsIHrADh7psu1u+li74tmgnZU?=
 =?us-ascii?Q?3tWP+P2VfjPvJUX8Xe2JOesaqIxFuChL8hs2u7OnseutBl110B5EL5OKtvYa?=
 =?us-ascii?Q?a0imlBjw5N9FNZSI+JySKJ9JvrftDLJP+NQL8YeyKAYt4nzDihcIqJaWfyO0?=
 =?us-ascii?Q?Gjp3iX3JmkNfLDfLPODFlhUDjidQWU6/Czo2NVnO1ZvPG2InrP6S90YihjO8?=
 =?us-ascii?Q?9/FGlisRENsWXVHi1n3qkcGhzxbUK68hoJaaOaFn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hpHmfYeur1oMujJJG7zeS7yYcfPeTW2NbYVj8g0+q4WqE9fAqg65J/TVbx7koub0jKdnBoDxiURB3TVxBWZG+yXK4cjhqf/5oQYRZkBkBp64lZiSU17eKsqryU0OdWjjTOxNlr3W9GzZ0MfQqwe5SDMMpH+lfXLilG6Sig4dgjMfr3TeIM35Y4dNDuMxnS5gkO3zZbXFtuhbYlSf+WJYEQi+Lw1ICRRNAbw2TEZNKL482jcHQOvJMPWTOkXUoOS3KRojDuajo/d3Df7wlN/XSQhIBMbrIl0p3DzvF457D8qoi35uYBwMT1XOCo216jhpyqrSQsp5VUH37a4ytTj1MCpcME12i0WO6CYzHEZSzPaFvMYScVReT0Q8JGSJRUnhygbee31+8XwDFNAHdrxuogoerksHzzVDgad0I3ebdc8jCLtpmanAi/q4lDrGI5Hz6RqelqNfMOEp5E/vxpJr3fUMFatk6DnFX9FjQOkmtRdXptQKiUATho37IlqzzS66lhexZAXP2knoqEpfkneuswcFJdKBHXwN2HRlD5rlCsGo4W2Z9zB3myC87vuYHbi1LlpxhXvuHeLBmBlmCztXnBjTKRpYGrayoWBmiCR1hxE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3decd55-2a37-41e7-aff6-08dd57f61c8b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 12:47:51.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CS7iTWWWUI6xHRO1VAu7CCYfRpoYqBhkpjoGRJ9jpF0bvAoz+pin2vTCoM6pM/moLXy+55jmDRDe877GtgqyMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_03,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280093
X-Proofpoint-GUID: Pdbi38-5vlaDIFMLHg9WXedEZ3Giag0-
X-Proofpoint-ORIG-GUID: Pdbi38-5vlaDIFMLHg9WXedEZ3Giag0-

On Thu, Feb 27, 2025 at 05:26:26PM +0100, Vlastimil Babka wrote:
> On 2/27/25 17:12, Vlastimil Babka wrote:
> > On 2/26/25 09:11, Hyesoo Yu wrote:
> >> Dear Maintainer,
> >> 
> >> The purpose is to improve the debugging capabilities of the slub allocator
> >> when a error occurs. The following improvements have been made:
> >> 
> >>  - Added WARN() calls at specific locations (slab_err, object_err) to detect
> >> errors effectively and to generate a crash dump if panic_on_warn is enabled.
> >> 
> >>  - Additionally, the error printing location in check_object has been adjusted to
> >> display the broken data before the restoration process. This improvement
> >> allows for a better understanding of how the data was corrupted.
> >> 
> >> This series combines two patches that were discussed seperately in the links below.
> >> https://lore.kernel.org/linux-mm/20250120082908.4162780-1-hyesoo.yu@samsung.com/
> >> https://lore.kernel.org/linux-mm/20250120083023.4162932-1-hyesoo.yu@samsung.com/
> >> 
> >> Thanks you.
> > 
> > Thanks. On top of things already mentioned, I added some kunit suppressions
> > in patch 2. Please check the result:
> > 
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.15/fixes-cleanups
> 
> What do you think about the following patch on top?
> 
> ---8<---
> From c38dadde6293cacdb91f95afc3615c22dec5830a Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 27 Feb 2025 16:05:46 +0100
> Subject: [PATCH] mm, slab: cleanup slab_bug() parameters
> 
> slab_err() has variadic printf arguments but instead of passing them to
> slab_bug() it does vsnprintf() to a buffer and passes %s, buf.
> 
> To allow passing them directly, turn slab_bug() to __slab_bug() with a
> va_list parameter, and slab_bug() a wrapper with fmt, ... parameters.
> Then slab_err() can call __slab_bug() without the intermediate buffer.
> 
> Also constify fmt everywhere, which also simplifies object_err()'s
> call to slab_bug().
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me.

FWIW,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry

>  mm/slub.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a9a02b4ae4d6..d94af020b305 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1017,12 +1017,12 @@ void skip_orig_size_check(struct kmem_cache *s, const void *object)
>  	set_orig_size(s, (void *)object, s->object_size);
>  }
>  
> -static void slab_bug(struct kmem_cache *s, char *fmt, ...)
> +static void __slab_bug(struct kmem_cache *s, const char *fmt, va_list argsp)
>  {
>  	struct va_format vaf;
>  	va_list args;
>  
> -	va_start(args, fmt);
> +	va_copy(args, argsp);
>  	vaf.fmt = fmt;
>  	vaf.va = &args;
>  	pr_err("=============================================================================\n");
> @@ -1031,8 +1031,17 @@ static void slab_bug(struct kmem_cache *s, char *fmt, ...)
>  	va_end(args);
>  }
>  
> +static void slab_bug(struct kmem_cache *s, const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	__slab_bug(s, fmt, args);
> +	va_end(args);
> +}
> +
>  __printf(2, 3)
> -static void slab_fix(struct kmem_cache *s, char *fmt, ...)
> +static void slab_fix(struct kmem_cache *s, const char *fmt, ...)
>  {
>  	struct va_format vaf;
>  	va_list args;
> @@ -1088,12 +1097,12 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
>  }
>  
>  static void object_err(struct kmem_cache *s, struct slab *slab,
> -			u8 *object, char *reason)
> +			u8 *object, const char *reason)
>  {
>  	if (slab_add_kunit_errors())
>  		return;
>  
> -	slab_bug(s, "%s", reason);
> +	slab_bug(s, reason);
>  	print_trailer(s, slab, object);
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  
> @@ -1129,15 +1138,14 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
>  			const char *fmt, ...)
>  {
>  	va_list args;
> -	char buf[100];
>  
>  	if (slab_add_kunit_errors())
>  		return;
>  
>  	va_start(args, fmt);
> -	vsnprintf(buf, sizeof(buf), fmt, args);
> +	__slab_bug(s, fmt, args);
>  	va_end(args);
> -	slab_bug(s, "%s", buf);
> +
>  	__slab_err(slab);
>  }
>  
> @@ -1175,7 +1183,7 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
>  					  s->inuse - poison_size);
>  }
>  
> -static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
> +static void restore_bytes(struct kmem_cache *s, const char *message, u8 data,
>  						void *from, void *to)
>  {
>  	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x", message, from, to - 1, data);
> @@ -1190,7 +1198,7 @@ static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
>  
>  static pad_check_attributes int
>  check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
> -		       u8 *object, char *what, u8 *start, unsigned int value,
> +		       u8 *object, const char *what, u8 *start, unsigned int value,
>  		       unsigned int bytes, bool slab_obj_print)
>  {
>  	u8 *fault;
> -- 
> 2.48.1
> 
> 

