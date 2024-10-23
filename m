Return-Path: <linux-kernel+bounces-378475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3079AD11F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAD41F20DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EEA1CB536;
	Wed, 23 Oct 2024 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBZIGg2G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WhH5MlGK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964301CACEF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701466; cv=fail; b=JaYy8z2GLhqOGC9lPpyGCo0mGtitlY049d8z6xxmSOABDkBth7V2bSFAr42ZHaWW4LgtJb4oca8lm5xLvgHr5R1+ZZbFaq72HrwOQp6IXtTa2PHaQ+Z+kFKHl6gI874Gb5scZSDwRa1wDIg8kL8PKYnZEcPVvK/eqxr8gvxcIFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701466; c=relaxed/simple;
	bh=bFhU3vhb4u79Jovda8Auzp7jrzM/AQ67BgVq33w+Go4=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nKy/G0Mh1V3I6yoHDTFyjIRQ4jfq/LmVmkL5p9EBriO9hOKlj9PoJ1iq+NxY6mTE3UUn8UbE1FwZFj9Dsu2j8TX9mn9h1FOtZs/1cFZk9mJ/56Tk7wLEcLOJkcivHKztJ5VKGmCcYSs7AVpi+9afxiYQ5FiJpA9V/FbwbTmT5Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kBZIGg2G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WhH5MlGK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfgfO026687;
	Wed, 23 Oct 2024 16:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=YR5tKqFSs0NvN31HZ7
	UlLt8IffdQvPM0KO2FWIYKjs0=; b=kBZIGg2G3Vo6ZREndLHHw1TDIMrpbfHvhS
	cZYlV0Mv84p+QIEPKMrgSY8ZKLBrFJDWyB06fdX5gy2DoiXAV82AwHwHbG/Dky8Q
	8TN7wtV6Nz4A97r+m4p1uboxRmxJ4xhyP+XkJL7g/SrMtwIad6/soiYOOazkz985
	a4lgRlI8hXm4qGiwWv9NePmOhYdyaQbVflNTt0fyHAwZaK4pE3dDqlPxIXmkv9EZ
	I42xdxXqcqCKilzwOGWCps3F1Ta4mVYID0u5c8L+d8FURMvswAEFeJn9c1F3ZN1y
	6ksOtOCRA/yEgg4SmHkAM2yuf0hLj+zdqvtC5f8KXs9NUYRT8m2A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55egg1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:37:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NG0WIr025332;
	Wed, 23 Oct 2024 16:37:30 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh9rvjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 16:37:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGf5nUdXGo6m6iHJL/zm577tFB9w8QiAJFkZlG3FphWFvc/BkShaP8BSjNvvMeB0wQjSa/4s0hg0ucWLmrD3hpx5sIo1oQ7BAn8VhNogIBLlEEKJkuGsIwaukHeuMVgU8bQ6hdtysr4Ttf2YUUdqDtN8ClIjlyS6+O9o/Vp1LRLke2O3+LLbKU3O1jRX2hS0mjg8mAt9z8C6uBiTkT+5+YJglG8fsvXr0pdflvUUsSk6+7tbcNP8cAxhbsySuwgyWOP8mDZD84mjC738jRPyrp0savHnPXu3iARiqk9+4wJnUJM54JHAoOoCbQuldAILwm0+jIynC0yO+co9am0fwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR5tKqFSs0NvN31HZ7UlLt8IffdQvPM0KO2FWIYKjs0=;
 b=X1eiJTmZopfqoFwToz1F2CKGZVUFjF1FBk5Op+Na3MkgrTz3SwmjFBtOz+YZiyw6MmoXoC0SyDodB4keDLQRlde/yODOXKZRGAA+SV0S9YfQnKdzL4zZrXeOSBBqHhPkvgfDS5ku3eFCIn1gPHZ1ju4Pt9vOi0SWZ94ZcB+l2C3gi3rkJO3DMq5G+aSZKQ8fGxDiVItMWQMDyhSB+04fn7xSSPaw6XSB0p0Ih4SKerc5oKDbg2DztMBWkdO2B+Z7qcz8LCDUkzrCvgtB+yd7ZHiKD2EaFS/8quKixWamgeRPybR3R/NEGQILaH/NH/C/E9mLFrEXBYldb3tn7w7EDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR5tKqFSs0NvN31HZ7UlLt8IffdQvPM0KO2FWIYKjs0=;
 b=WhH5MlGK8H5zHa8CuVlqzBzqeeIWsuYasaVaAcvursZ4gy/KCmBzWAdySp2v/BV/sLulRPFVIzHbMPM4eV9GHjHgk6VSLs22ja2l/xHb6LMNMe9zI+WNjd+Gh9feWf/jXFj15W2igzi6qSZvLILHSVEXQWGc+ZWTlvd5OxLz0cU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7901.namprd10.prod.outlook.com (2603:10b6:8:1a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 16:37:28 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 16:37:28 +0000
Date: Wed, 23 Oct 2024 17:37:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 3/8] mm: refactor map_deny_write_exec()
Message-ID: <5262b8f4-ba35-4c33-9ae7-acf3f0fae63c@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <e67b7f6c682bddbea2fe8b2d87b8441e4d2ea6e6.1729628198.git.lorenzo.stoakes@oracle.com>
 <3de53e7fmsql2t7byzoqonyt7e22bztucjcypykvqiystbalw3@2vwnvh7jcfed>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3de53e7fmsql2t7byzoqonyt7e22bztucjcypykvqiystbalw3@2vwnvh7jcfed>
X-ClientProxiedBy: LNXP265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: abb9bd90-6dd6-4bf8-848e-08dcf380fb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FNF7owdwUR28hU+UtS8hXk6+gckekfR9qivgsq5GokMXMyZ0kxqUrP8SaVNe?=
 =?us-ascii?Q?Z/y4ZZ7sYk+eIcKR/Yd4QnYC4dbMQ13b4NkG8vc4hlTakTGY1bx4yAACGjjl?=
 =?us-ascii?Q?5K4HeOPzH+ZaDBw56+itsFcgqqPQdEBh/zAzc5+/19WrbfNGDRHkoYkEOoI3?=
 =?us-ascii?Q?RuZUChj6ZvW9YhGZZ5xG/8/YIraFFbeS3Q04a9Zjcq8UvquRQibsiraC5fks?=
 =?us-ascii?Q?LO4G/l9Bbh1dfi2vIywq703LZen0YvJaqsJS8qjtMjOCJ3A4dLyqKUiyRTlL?=
 =?us-ascii?Q?f71QTuDoTeUHA0zyHpCGaFt4n6Irywa0xHeJ9muq185M49NdfvygiRHHutxE?=
 =?us-ascii?Q?1iW58gTanMclkY31MOXxY+bm2pTVjSFoCHJrH44L339HoyMmbvz+TYbIjxq3?=
 =?us-ascii?Q?h9BOHSnCGqxISr6woN+Tz7kb3TdJvYrC6UcU+fFKz2yhacaO/QV2GOHemtpz?=
 =?us-ascii?Q?N9gdt5JmqPtN37aemfZnGUH8YsUjVuR3eorn/KhcNuOxpvlBgni/hsMkppos?=
 =?us-ascii?Q?ny+U7lGYKYYVgJngPvM+qgzVr/h3rvy3Bw8lI2hfie9oDPmGUoMAe2/5zseW?=
 =?us-ascii?Q?msKG/tfiCCzAG5ZtT2Wtn5j4FM73Wg+9M1D8sGfmt8Bja2Sv2EzY1VxS7OP/?=
 =?us-ascii?Q?LfozBohApFEP8vF5zNu5jrY7qcvrz+5tzlAyxfuGGBgxnEgdQ2Cz69fI3cqn?=
 =?us-ascii?Q?+aoVdWj48BWCyJvo1kDPg8WurMOTdwUSVBv0fIE1rpvmxHhG73Kd7XTSZN2Y?=
 =?us-ascii?Q?OMwUUk1nlAsXEbqvnLGg0eOKXRc+EEl9Q8ItZHS3BjeJt47HgVnpv9XkKzvf?=
 =?us-ascii?Q?8zHoFpFZMRKc3LctUcCNkb/1kCntvYGS0PkdBehJc3Ing8O+nK7WB4SOtUSF?=
 =?us-ascii?Q?CjVkFTAcrcUmTsO1ov8AQEhZOHPJLzeeKmvlznD/CaVcyzB8jcqxGTdbw9zz?=
 =?us-ascii?Q?LnKeqcwpRLLhOrwjOfMG/zwSgCQPeHtPcEcKR1p3CkLPtVjLxxegxkwpOjJi?=
 =?us-ascii?Q?f85OLSmyZr7vg6cfArwJh858yL9al+gejkpgghcemfDTAV2Ur/QxXStoA7WO?=
 =?us-ascii?Q?HwZ0ICcgw0U0MuG/ZHx4QVNWAn1p/FT6c6qSeczq2EaweOiI6mh5RhMj9NZc?=
 =?us-ascii?Q?rrBcKR5jMeGSjdDOGueuH533A71nciuZiXukVB7+1IqYIcPgE7yfnVo+XxsC?=
 =?us-ascii?Q?iaTq74WoKvxqvgyYMec9lyOAklW/T0FIJ718UMa9eWnUgdf1CuLrBVyGTcYB?=
 =?us-ascii?Q?uXBUiW0/0NK0afjukpbyZEt+dDcjloL+MkIpxOULb3L3i0CKkBZCrPjJHK6M?=
 =?us-ascii?Q?6MGxKrEuE2lCyTCS82gVtBbD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mK0AYlgpL+WSvYWElzQCEd0Zjzw8eaEiAqI96J06U0iYSLgcREyMJJOwe8Jv?=
 =?us-ascii?Q?o/MF5UTIJ2DX+F7Ayi/L3VXuQMaUIRYU/UfGVihACVPkyLfGwXu+MojcEGXh?=
 =?us-ascii?Q?wRI6tYmkeGB3WijxV6tPUgHBQ/JJ1Y59yJh07RuOdy8loEVDszUlt7L4MN5q?=
 =?us-ascii?Q?i0tamPYNvJmhjLHTgscD0Vz9Y4oWReQui2j1eygIK1yKchYlmhRFOJFC/khm?=
 =?us-ascii?Q?lrDoXGj6pl/RiyUx3FvFAJQWQ4AFDvpZ+uI4zoGNwjiRJmMwWy0AdQWDdlX8?=
 =?us-ascii?Q?obh+rQ9OK/luForhWE+PqtNzkxzOCiJD7PrsBrSldchzv95MMpqhwkrk02tI?=
 =?us-ascii?Q?+KuN/5PA/J9VBFVxHTcHQ/L2nOkfbQKzVWs+g1iNUtl8ebycuOCXVTknZVnK?=
 =?us-ascii?Q?GWNn6zGz4fuYB/i18YSxE3dWL5mYfWgROjTUoT11easl70Kb2rpHjvm6o1GH?=
 =?us-ascii?Q?Fl3ul92SnOBuNMHncPUO79dCzOks37IsIeujwyJWLRUJhvRJEiHrHGJRQHlp?=
 =?us-ascii?Q?PjVV+vrtx65qucjxq23ajBq1H4GPGyXSKZweSIYEn2IYCWEmO8W/SogBbfb1?=
 =?us-ascii?Q?bQ2rh4jte3beEnSynIL/WvmL+01JZet+IM0KbK5bOrpu9ZJp3KReboa1vg8Y?=
 =?us-ascii?Q?I0ou0J68F52Wwwsww17KEpZRQHDE52B/sXRVB1m1HDbpSNNwxvYdWEAmoKR/?=
 =?us-ascii?Q?NV6rv7Gi1uxCdCPAmc8EUV1dbsIbQqeUNUFtQnz1Dr0xa44+lxE8kDUOq3zV?=
 =?us-ascii?Q?wvMIAIWpTABqtuRgMP85l/myyffblTQOvfe/k/26NWn+JO9b1JJ/ndRvjrEb?=
 =?us-ascii?Q?lyQ5SbznrWw9X7UW0GZDf+ZQoTQgioTJZex5yOhCSUFaDf9yuVz+3LYCHcmy?=
 =?us-ascii?Q?/26pvfnYRPNTwuH4SWDjp2l77EHRqn3JA7/3z+GGI/iIsn8FPAluVf9b3cuT?=
 =?us-ascii?Q?iSy4TWFKu1m6RPr2kq+Rw68M9xxCmTW5ebeWghki0KZibbaASm7/HhEgJMR2?=
 =?us-ascii?Q?qxZNr/p0DEj5LjMoO/VaGjk7QEH0XdbUZL/U/5LV1BsNfmhD5hMWM/G+dGu9?=
 =?us-ascii?Q?hR70iBO59Yxt/Dt1n0ZH5IrAIDbLjpfrfAIMLvL4Liq4E8RgLuDrJOUj0xbc?=
 =?us-ascii?Q?gONtVwoavciNLyXDYbmafIX/U7Hg/qN6JWLhdREXX9iRWOIyGIG4GBVff6MV?=
 =?us-ascii?Q?8x3vFWVIm8jnpoKRvr0Bqo9FAPjcAPxYvjjWWAA/QUQxp7W3YB9OawCR3zE2?=
 =?us-ascii?Q?VbUbCGmq3UTYZpzmsGkk1cGVhcwpkUE7EH3NGz+pQ92HA4AB1TV/uRjogk4r?=
 =?us-ascii?Q?2etSg7tM6PmnS0MpK18Pw3+pipSowuI7iXaCBgmudocXv+qtUIetFBv1UGF6?=
 =?us-ascii?Q?RWMmiwBsoNL027XdaqXTksEifwQHEJH4LCiq6ie/YlhPDqIHC7rESEAU9whz?=
 =?us-ascii?Q?mOfSM2Xw3MYVGb+AtcJmpGAJiJvB1Wisb1Eit4j8r6a3mPxAFvXrjOfRuH2P?=
 =?us-ascii?Q?9qHdgB05fLlM6gZMdTYITR9L8LsYY8MvAP0fkYUFjOJqBbzVyPm5a1AQJFIW?=
 =?us-ascii?Q?G90Y4YGA2xomHUdWa/L7FZiESiMK4nfU2DxRf7xYmWdNOYu4ZnOcQIdbuPAR?=
 =?us-ascii?Q?ehpg1icUfIoYgcu8SSld71YvNTXuq9NimNrSDh5HLDr1Ycm07eZjnYaX/PXe?=
 =?us-ascii?Q?gYyxdg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KzPEHNveqwZTBI8witGbWRLI2sM5TFL0MbkhIgV33B7wLY453lxLxaG2DrdfXVR+ZLmqHgJ+lw5Mz70d4/7ab/5fL74YbR/gxaTZibiPpcwpBpOACyxYmClrMAAsI1YN5gW4NjVhNtrFILnDjMtxEE1guW+Nl0juNQYTHO6wssZniZeQnQlDnH02hvmorFRfRkI2Ne1cktLVmKFK5sewgl3N9ZircSyEqfoawrHm5u/wnFFQJcB3EmCVs51/c6LPVmL3E57m05QVI6AUS9vT3lMHWbQd3LmQCG+vUXIfB4m4SWiyCHQPqzXlGW8uj0oIV17g3xm+8q0G2w3/3uhy85RTCWMQDhOPkuXcC0J+3r92qxWYkQU9zTknRKUZOiFh0Wzd0QxO2ABjKAIBBRuXXUlot++ZrUtiMRgj258LHzr3ymAMl/QwITPJ/Q/AIkog/4T2rWFy5i94BVJzy0V5O+AXymKNP5loTSJCK7HE180TRYB7mKDU/XrPKPxsnZs6N8vfBpcEOuUJImd43F8boDZFUOP7Sdi9W34OAv89F8ohCiaCBJg38IgRPQL69dS83RnVIiedCq9myAG72xbVZ3EEZF+1dCU4/tvqRvSDuiw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb9bd90-6dd6-4bf8-848e-08dcf380fb42
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 16:37:27.9134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Z491Lq/FX/nrXyv3wJBG8mlEVjG62Y14f1SUS+ZjHJ7f803WN8Ntxv30ViTKYFKHICjLm2X00kkMnVr/8KunuLKPVC5/RRq34YkRtOwxCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230102
X-Proofpoint-ORIG-GUID: COoNC6VcVNgxhPKAC52HZrTJVnGo18Uy
X-Proofpoint-GUID: COoNC6VcVNgxhPKAC52HZrTJVnGo18Uy

On Wed, Oct 23, 2024 at 10:30:46AM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241022 16:41]:
> > Refactor the map_deny_write_exec() to not unnecessarily require a VMA
> > parameter but rather to accept VMA flags parameters, which allows us to use
> > this function early in mmap_region() in a subsequent commit.
> >
> > While we're here, we refactor the function to be more readable and add some
> > additional documentation.
> >
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks!

>
> > ---
> >  include/linux/mman.h | 21 ++++++++++++++++++---
> >  mm/mmap.c            |  2 +-
> >  mm/mprotect.c        |  2 +-
> >  3 files changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > index bcb201ab7a41..d71f83b821ef 100644
> > --- a/include/linux/mman.h
> > +++ b/include/linux/mman.h
> > @@ -188,16 +188,31 @@ static inline bool arch_memory_deny_write_exec_supported(void)
> >   *
> >   *	d)	mmap(PROT_READ | PROT_EXEC)
> >   *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
>
> nit: the arguments are not in the comments (which is a pre-existing
> issue).

I add them! ----
               |
>              |
> > + *        |
> > + * This is only applicable if the user has set the Memory-Deny-Write-Execute
> > + * (MDWE) protection mask for the current process.
> > + *   v----|---------------------------------------------------------v
> > + * @old specifies the VMA flags the VMA originally possessed, and @new the ones
> > + * we propose to set.
> > + *
> > + * Return: false if proposed change is OK, true if not ok and should be denied.
> >   */
> > -static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
> > +static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
>
> Nit: somehow "new" is special in my editor.  Also, I'm too lazy to fix
> my editor so I'll live with it.

Time for a "new" editor! ;)

>
> >  {
> > +	/* If MDWE is disabled, we have nothing to deny. */
> >  	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
> >  		return false;
> >
> > -	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
> > +	/* If the new VMA is not executable, we have nothing to deny. */
> > +	if (!(new & VM_EXEC))
> > +		return false;
> > +
> > +	/* Under MDWE we absolutely do not accept writably executable... */
> > +	if (new & VM_WRITE)
> >  		return true;
> >
> > -	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
> > +	/* ...nor newly executable VMAs. */
> > +	if (!(old & VM_EXEC))
> >  		return true;
> >
> >  	return false;
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index d55c58e99a54..66edf0ebba94 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1508,7 +1508,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vma_set_anonymous(vma);
> >  	}
> >
> > -	if (map_deny_write_exec(vma, vma->vm_flags)) {
> > +	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
> >  		error = -EACCES;
> >  		goto close_and_free_vma;
> >  	}
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 0c5d6d06107d..6f450af3252e 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -810,7 +810,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> >  			break;
> >  		}
> >
> > -		if (map_deny_write_exec(vma, newflags)) {
> > +		if (map_deny_write_exec(vma->vm_flags, newflags)) {
> >  			error = -EACCES;
> >  			break;
> >  		}
> > --
> > 2.47.0

