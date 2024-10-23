Return-Path: <linux-kernel+bounces-378309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DC79ACE32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753B91F22394
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42F11CEEA4;
	Wed, 23 Oct 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hdU7LunO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jNpQfce/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A941C728E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695822; cv=fail; b=gNj+MvRTsB29/isI8v2WApejnC/n0nNy0Y+WmMghzE0Tm61aLyJ6BPYV7cHTySZ3PKjK7JogmbZYFexkvpFihq53xYPB+3ya1/3dZ0QV+p1OC4gos0OQHrFCrBGUtPxk5AyPSIn1M7OYBEzB8E13a0ynywhpWf05xglZGb0sZOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695822; c=relaxed/simple;
	bh=7ts+xYswd3MGvrsC6lmOb+xkAK3olHBw6I/8nBiL6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vFNsdbfkrWrCT7xfP7mL+7jJKFtFIURJos/Ug7ixHqqHG7qY2DGm3pud7JTnj1tysCa7Djn64aiVRHy2FCjpCfVOY6o0m0UIv7BJ7LXfFqhz0woK0aBuIzU4i7frxpoBnIvTGA0q/OirobAQk1AEEQrzWFs25aYqNJaKBbOslgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hdU7LunO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jNpQfce/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NF0crD005847;
	Wed, 23 Oct 2024 15:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=n6gavSChuhangOMIb7
	Fva44sUAa+71e9SPbc3qfHNdY=; b=hdU7LunOaX90fcoKtrfQXfCC+PfgOAEaAl
	004VFpCOme8wIlNhP9tGCh/N2S7WGoD5pNslofi8VZqFgUEsSvwEGy6ssH6mYMGB
	dkAG4ibeHj/m6inn/1cj+JR3MGRtc2Xn2HnJJhKeZaoANp+YOMyzTUsrBU+LpzPJ
	btESpKKT28xLQN1rvwCSDOp6sd2yzgVkfFes+yhs0IMO1fnoDyeU8msQjjgOOUia
	VWEWk57/Qb4EOWOsVRs33gITSxdWwxq57FIPwWdR6bj1rKwHAmEoh2Pbd+aZ4Amj
	Wpij8ZloLU6B5ofz78Itt4w3dXjoeltDAjB3iw60qquWr9WlGO6w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3fgw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:03:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NEUPuO036025;
	Wed, 23 Oct 2024 15:03:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2n33j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:03:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRCFktmAomIlz1T5MvDl4LtxpE4SD3FhMDa2S5sSPxJ1a3HPCqyxfzAKaIM1tKmhxSRFxocxH52c4ylQVhdus0hDyOeJgdva0lZ5atBQwNxpvVqvvDCvvC+FrcV25Bd2o79Y6dkXfIlyT0/oja6Sz3MJELsvRRp/HmP0BUdZKknw626Zq4285uxsbMDN93Ce6ZGV0hEqd/bmNnWlvhKpnrR10eP1nQXolghzCURTjizU7JOLfq3bgSlTtdAhn+ogfc4/xydlJU6kSNz9LYYHNo6pF+r6Wn1JbQ5CE6lFXk/1rNujtzja/xW3ahuJ48ELLpA1w7+nyzQCm4+0cDC0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6gavSChuhangOMIb7Fva44sUAa+71e9SPbc3qfHNdY=;
 b=oybFZgpRKj0uvkNja0RYc5F00zILnxxTlHfhm46A2k6V+IBaKtPyWtEGIxtQww3scw6XCj0xD65oJRU1URglFh+8sqrNBkbxfCgczraIkPp8r+M3fTWnGNIe7VXu6iYhDzRV3pMSHLrrMw69zpL3mko2kDCrvqlcJgzavPKvdq58Zm79kEY5+fzRWSbC3qm+5xgxADbemyqwetGPBC4zD2V/Ao9ExP8WMSKBwC0gRQhXWpaDY8e/wSTa4bOdGIh+dyl6cAU2nvhfU/ehTbmykEUQPPGeWBro6sYnqZLut0QpNmeqzpR4fjNVdqc86PxqH4mBUXnF6rUiT3W88V+D2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6gavSChuhangOMIb7Fva44sUAa+71e9SPbc3qfHNdY=;
 b=jNpQfce/nli4O19mJCIvUk8oDkn7CDniVV2FDdfcl+y5BaLh1CDK/YbV2DqZsbQgCqyBQBc6wU7OD7rXxCrhpVCeCs8NYkCR4trO31Nf+iP17YGy/IfLp8WCdrC5Tjlv0wbjtbrjqx2egd4ptLsVJVxVsvdn4zNyi4mcDsvMZ/c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB7830.namprd10.prod.outlook.com (2603:10b6:806:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 15:02:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 15:02:57 +0000
Date: Wed, 23 Oct 2024 11:02:54 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 4/8] mm: resolve faulty mmap_region() error
 path behaviour
Message-ID: <2iq3asat5h5krrwf5vm5ewhmbx3f6xyvmbpcgqfugjmsyxmdqb@twqoaancgzqv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <3bc3ef7520eed73472f7ffdce044f2e94f809b32.1729628198.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bc3ef7520eed73472f7ffdce044f2e94f809b32.1729628198.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT2PR01CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 694bc024-6b6c-48d5-cc84-08dcf373c71e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UlPZRaeSNlTKeCq6rjmrt0zVAYfciYoVTTKHYQVjHefBlb+grIH9mervlR3N?=
 =?us-ascii?Q?uVJfsYq92/m5xB7rhlPNgatuh1zYzOza1xzR95Gu/CBBCuurqtQhD0bj1wj4?=
 =?us-ascii?Q?gB5n2eEqNawfPPUSztqEGIvTFywX6MwNC9MfxNHbqv1ir/jZhIR6cOtBBiYR?=
 =?us-ascii?Q?sizd4vCNC9NxZwgMGZR69WpVb9HTwkRzMGD9cUdqKbiMXpXapO3pf3EtiWsQ?=
 =?us-ascii?Q?YQ8fPBhRdSPRI0vFC0Gyo8yrq6XzwYtMci426LENtAb0ToqDIePxqRuIW5CC?=
 =?us-ascii?Q?mnoclRgIzo/qEJNFk08Ked7WCr8d+l0c+LqPM2lEWb9bThkkru72rpk4nRNu?=
 =?us-ascii?Q?2SLxTjrqSoZG8/ghYTHOn0EAT/c7kFToK2TjXXX9bKCaocYqwvuyelSaqs9Q?=
 =?us-ascii?Q?wOmMlUggYSXj8Y/TYL/YSVoH45F+tyuQPpW+9sD+4wzTSrjPlVuTHdbHjcZt?=
 =?us-ascii?Q?zraXxsUGBCIx13NciUwJmJlGJy5DflgpURwCjZ9vVwvwTS0/2gh9KpruPTDt?=
 =?us-ascii?Q?qkHW0JQJ/x8T9toH/22aC05rdMhVAzTCGZe9QAFbJTBx4zY/89N3xJ4JmmKz?=
 =?us-ascii?Q?q3cvtAKZLYolrOB3paMLiem1H2DHJdAfAL7jy1pMqAo70stDeQt5jipiI52o?=
 =?us-ascii?Q?m9dwoA4RMzzt7d1FePA+I5MyXF8gYwPpo02VdyGO1YfOYH3FCir73dvzz1MO?=
 =?us-ascii?Q?1GbhskDXj1P5ozhAAsQpvK+xtXrs8NMCl4nL/fIny79G05p0JHCHiFPUzdzF?=
 =?us-ascii?Q?DV5Wb1ImP6eLexYgcI9i4+J2w/SxFdi9t8w3D3qj20LNOCrBDzQtum2vYrB3?=
 =?us-ascii?Q?xgJ6IzriabYcX9GbRlonZoB+UEpOjAsxS7EARjTisup6mKEm6mP0qoVep6Gc?=
 =?us-ascii?Q?zX3OZzaLvLpcqRh9WgZognVFwmUX6b/A6FeXa549t5W6Xk00N+4Gy4uuMMaS?=
 =?us-ascii?Q?1c6fUcAyB2Rknu6ZdjBewfZb2H7+8FBqnaKDLPTjkYB12h1k91UW6FYHyiXM?=
 =?us-ascii?Q?hX+apFO2E6OvkaFXi2uCxQDFaVcvuhp8Gj7XutlmTuuQd+V9TKqDHsQhem0i?=
 =?us-ascii?Q?bWGmSQR5Me62qJgo0Olq23KxjOTgHc3dQrUZ4QZrGLX3hVtr2+rPyDOHk8e1?=
 =?us-ascii?Q?aoHQ03JgTgvGL1RszniW0xzTWj+XDr5KNsSDAhzYA4B9jjiStc3Bx11DkXMG?=
 =?us-ascii?Q?RETrvDJAIn2yirAs5cZAaqEPxHkNPukEqC0+4IUtT99DH0N2KNpvkSoYPWDH?=
 =?us-ascii?Q?audcYXAwc1LAtmrU9ctGHJw4Dzdqah9fXmwJQ6ONcnAXtDvv5SBr8rgnOqU/?=
 =?us-ascii?Q?kpAvk4fqxkG5KohGsIMacsFx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nvt9J4lrVxWOi3CwsDQD41BftmdWV2n1DBMnqya/pEkh1DJzx06JS7IUMl4J?=
 =?us-ascii?Q?xFrtEtUX30BPam6wGkDKBw4qhKsJY/2j51JOxzowz6p4HxeypOe8RDnl8Dfn?=
 =?us-ascii?Q?BcDbmPRVLDEiwiQHCB7twPVmR4qRURW4T9vz6xlRUPZ1r2LsuqPLJNIsKE/X?=
 =?us-ascii?Q?kpLaKKQV8FeIn2IDKOUCveRThoiKjQRQUF4TMUYTQP81NYMMW76+6ZdQKTs8?=
 =?us-ascii?Q?U/WTeNmfytFZZGro7VR4S69NMsDX4nnLmnvnmX7AKYi7ygZ7FKpMBF0B4VMv?=
 =?us-ascii?Q?TcuKJEjisNn/Rs/0vYBtMhTg2UKSKR1ab2VCq1/Fw9liG4cNyJvlLyGH69wY?=
 =?us-ascii?Q?HTw7P5IWl0mHw91k+1El3jhnOepXYLcto8yqyrdfgrVRkwLCAUOmm+QLcWl1?=
 =?us-ascii?Q?B0nutaiomFdxmfRFBtWuwptDD6xK4hGTV9astscRUvwR7dzovH+FtO9Xh8+T?=
 =?us-ascii?Q?lHqMLrC29DQncR0F9ULONJo9pfx6MbmgFxP94j+IX4P5AcGu032A83EWxGed?=
 =?us-ascii?Q?5xam7Xrhmwb4Uvdr/zGZ2kSInMRZ5niIxwy0OQbwkvRMYUYsz64561Kezd37?=
 =?us-ascii?Q?rv+qMXUHdBQxZaRfP1YeUr8puY7iI+zUdcP/SAqfwCb7+NbAvUR6a7/P/eTi?=
 =?us-ascii?Q?HD+uJvJP0QNvZ0lTJTEsVgXqZoxhXQBX5RtmFC/gpBnBQiL41hx+MiFaMU/7?=
 =?us-ascii?Q?PshG/euDxsS5drHXHLvBil4zcHseBRfyuEUvtE0Ci3dQKTBhuM4E+k13f6Qy?=
 =?us-ascii?Q?MKVarj9LfCrW9tv6EivrTdPw9R0lxZeJivAPE0S8wdMrHxX2X6k6n74J7tsG?=
 =?us-ascii?Q?lQV4/kANO5I0ql3OJIOfOSQBgK6aH1Rvo5DygmSHndai3B0q4bYEDFrk6wC3?=
 =?us-ascii?Q?ajzJwhdSHn/kz5rVHU9Gc9ujLnekeA1QV5x+hLQK+8JoONQmPG8zvEZZ+70W?=
 =?us-ascii?Q?YaubysqSz0i7uaq0Q7tKj3rnKiFmqaUPLOZfyPgUfFiU0hHM+fUqT4tWClNZ?=
 =?us-ascii?Q?omDKGL2wctUhObeQ8BtOQce7McIZeyejuzSfevXvMHwxrB0hCWPwkAQrdqlf?=
 =?us-ascii?Q?Avujh8YNMr7981XxxufRGV1x5C7hSGctZCGzeGgI8arfzxVofHlvjYuDO83l?=
 =?us-ascii?Q?6Qd2aXDoDpEeYrhtJsJYpxEYJ/xSMmRiU76cYD2pKDGjcdU7Tkc6vLjFJffJ?=
 =?us-ascii?Q?ud46psaqC2BYHC8zQQztIcgiGaaHoiG/Cyxlodg8liDY1EkKPRlCvlLyc8Ok?=
 =?us-ascii?Q?IZGTMgshlEJAoJalP2zwx1FiVqRuhyQqp/JRUcshQlXjqN9wMJGddHg6e7ou?=
 =?us-ascii?Q?vKqUUDsRuuVZdJNu5WWfBPHiBYTrhBZ41RnoxTvnltTAr7w/RNuAvAOHMKy4?=
 =?us-ascii?Q?NHbvt451JruBtWIxfLSpGcFam+g+Pg7Lo0ssXiOd63VRXSDVi/5H27jGRGlw?=
 =?us-ascii?Q?x72Bel9FUx3sqcnha+BTeR63nSI/nKhTpfue4a7ssZnhGO/QqtxKShyziNf4?=
 =?us-ascii?Q?Nj8ZzTeTWEqJltCNoaZP8MfoL1MThFWxalfc/pToCRAdpaLpV+Go/URr8FbO?=
 =?us-ascii?Q?AB6vb3SXqvVUxVNHZbQDwMMrWfsW6C6HWG0/3sZl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dhNp1dJ7lsEMtt7s2JsIonI+hYG6OElhyoIG8QGUP8ma6r7UXRHC4CJOUhpbeD1co4lpNnPy63AitGGqQK+BxAZYGASeR/5y5uGO3XqodWoxycMnVd5y7pw8lv35oUp/mhP8l2ODKX5eTJazJqwkWvVA7CRk2FALppRRR3PQHvhlPhZscdpThgeIfAGM0EPn9I3CU57Hs7XHbyY9u6KgvQryXQ3FDhUVJ7bOojJ+mDnLrcE/zFEl9pdMTa12FGIL1mQBXktQugY/av53PgA1WUi2cAsGiC8/norVNUInJlF8Sy3N1JrqCM7iyQy0GpQ5xDWvZamBUkWwdqo6bFW2Kd/L1kj0jsosJw/HceHoc2jXAZd9cLrO0ijORNQNXJpTeq3AHORdImMVpnxyc8jBvvC+rbd1cwRTFZYdOhtPCwFBht9CZMINytzuLb0NoxXjSg+Qdkxn9ni9J2SWYdGtlsgqHIwvXKXfVlBz88aMozndPc4BharLivsjILDqX1CCN3RxIO8zqeXAc3UTKw/BV7NZrSNJs9ZIvrYdRlRbhUiq9266rY0hccKQ6AJYWwvPDKja7gT+ww68MASYRviP5Q2E2lYMT52VKz5EsV/uAd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694bc024-6b6c-48d5-cc84-08dcf373c71e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 15:02:56.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gm9UWzTQJhCs1nKXwsC2am3koSbLFX5Ndt/Qv5Ttw7xCxP3SFIPg8VVhL5PP2M4uVssG4+UxSi5M9XfHqSgbGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=976 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230092
X-Proofpoint-ORIG-GUID: uvGyl3gbLD5J7fTsINCIqm3Q29BakoLl
X-Proofpoint-GUID: uvGyl3gbLD5J7fTsINCIqm3Q29BakoLl

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241022 16:41]:
> The mmap_region() function is somewhat terrifying, with spaghetti-like
> control flow and numerous means by which issues can arise and incomplete
> state, memory leaks and other unpleasantness can occur.
> 
> A large amount of the complexity arises from trying to handle errors late
> in the process of mapping a VMA, which forms the basis of recently observed
> issues with resource leaks and observable inconsistent state.
> 
> Taking advantage of previous patches in this series we move a number of
> checks earlier in the code, simplifying things by moving the core of the
> logic into a static internal function __mmap_region().
> 
> Doing this allows us to perform a number of checks up front before we do
> any real work, and allows us to unwind the writable unmap check
> unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
> validation unconditionally also.
> 
> We move a number of things here:
> 
> 1. We preallocate memory for the iterator before we call the file-backed
>    memory hook, allowing us to exit early and avoid having to perform
>    complicated and error-prone close/free logic. We carefully free
>    iterator state on both success and error paths.
> 
> 2. The enclosing mmap_region() function handles the mapping_map_writable()
>    logic early. Previously the logic had the mapping_map_writable() at the
>    point of mapping a newly allocated file-backed VMA, and a matching
>    mapping_unmap_writable() on success and error paths.
> 
>    We now do this unconditionally if this is a file-backed, shared writable
>    mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
>    doing so does not invalidate the seal check we just performed, and we in
>    any case always decrement the counter in the wrapper.
> 
>    We perform a debug assert to ensure a driver does not attempt to do the
>    opposite.
> 
> 3. We also move arch_validate_flags() up into the mmap_region()
>    function. This is only relevant on arm64 and sparc64, and the check is
>    only meaningful for SPARC with ADI enabled. We explicitly add a warning
>    for this arch if a driver invalidates this check, though the code ought
>    eventually to be fixed to eliminate the need for this.
> 
> With all of these measures in place, we no longer need to explicitly close
> the VMA on error paths, as we place all checks which might fail prior to a
> call to any driver mmap hook.
> 
> This eliminates an entire class of errors, makes the code easier to reason
> about and more robust.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>


Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 120 ++++++++++++++++++++++++++++++------------------------
>  1 file changed, 66 insertions(+), 54 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 66edf0ebba94..7d02b47a1895 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1361,20 +1361,18 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>  	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
>  }
> 
> -unsigned long mmap_region(struct file *file, unsigned long addr,
> +static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  		struct list_head *uf)
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma = NULL;
>  	pgoff_t pglen = PHYS_PFN(len);
> -	struct vm_area_struct *merge;
>  	unsigned long charged = 0;
>  	struct vma_munmap_struct vms;
>  	struct ma_state mas_detach;
>  	struct maple_tree mt_detach;
>  	unsigned long end = addr + len;
> -	bool writable_file_mapping = false;
>  	int error;
>  	VMA_ITERATOR(vmi, mm, addr);
>  	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> @@ -1448,28 +1446,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	vm_flags_init(vma, vm_flags);
>  	vma->vm_page_prot = vm_get_page_prot(vm_flags);
> 
> +	if (vma_iter_prealloc(&vmi, vma)) {
> +		error = -ENOMEM;
> +		goto free_vma;
> +	}
> +
>  	if (file) {
>  		vma->vm_file = get_file(file);
>  		error = mmap_file(file, vma);
>  		if (error)
> -			goto unmap_and_free_vma;
> -
> -		if (vma_is_shared_maywrite(vma)) {
> -			error = mapping_map_writable(file->f_mapping);
> -			if (error)
> -				goto close_and_free_vma;
> -
> -			writable_file_mapping = true;
> -		}
> +			goto unmap_and_free_file_vma;
> 
> +		/* Drivers cannot alter the address of the VMA. */
> +		WARN_ON_ONCE(addr != vma->vm_start);
>  		/*
> -		 * Expansion is handled above, merging is handled below.
> -		 * Drivers should not alter the address of the VMA.
> +		 * Drivers should not permit writability when previously it was
> +		 * disallowed.
>  		 */
> -		if (WARN_ON((addr != vma->vm_start))) {
> -			error = -EINVAL;
> -			goto close_and_free_vma;
> -		}
> +		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
> +				!(vm_flags & VM_MAYWRITE) &&
> +				(vma->vm_flags & VM_MAYWRITE));
> 
>  		vma_iter_config(&vmi, addr, end);
>  		/*
> @@ -1477,6 +1473,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		 * vma again as we may succeed this time.
>  		 */
>  		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
> +			struct vm_area_struct *merge;
> +
>  			vmg.flags = vma->vm_flags;
>  			/* If this fails, state is reset ready for a reattempt. */
>  			merge = vma_merge_new_range(&vmg);
> @@ -1491,10 +1489,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  				 */
>  				fput(vma->vm_file);
>  				vm_area_free(vma);
> +				vma_iter_free(&vmi);
>  				vma = merge;

Nit: Might be worth moving the vma_iter_free() down (if not removed) so
that the vma pointer remains sane.  Just in case more stuff gets stuffed
between the two calls.

>  				/* Update vm_flags to pick up the change. */
>  				vm_flags = vma->vm_flags;
> -				goto unmap_writable;
> +				goto file_expanded;
>  			}
>  			vma_iter_config(&vmi, addr, end);
>  		}
> @@ -1503,26 +1502,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	} else if (vm_flags & VM_SHARED) {
>  		error = shmem_zero_setup(vma);
>  		if (error)
> -			goto free_vma;
> +			goto free_iter_vma;
>  	} else {
>  		vma_set_anonymous(vma);
>  	}
> 
> -	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
> -		error = -EACCES;
> -		goto close_and_free_vma;
> -	}
> -
> -	/* Allow architectures to sanity-check the vm_flags */
> -	if (!arch_validate_flags(vma->vm_flags)) {
> -		error = -EINVAL;
> -		goto close_and_free_vma;
> -	}
> -
> -	if (vma_iter_prealloc(&vmi, vma)) {
> -		error = -ENOMEM;
> -		goto close_and_free_vma;
> -	}
> +#ifdef CONFIG_SPARC64
> +	/* TODO: Fix SPARC ADI! */
> +	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
> +#endif
> 
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
>  	vma_start_write(vma);
> @@ -1536,10 +1524,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 */
>  	khugepaged_enter_vma(vma, vma->vm_flags);
> 
> -	/* Once vma denies write, undo our temporary denial count */
> -unmap_writable:
> -	if (writable_file_mapping)
> -		mapping_unmap_writable(file->f_mapping);
> +file_expanded:
>  	file = vma->vm_file;
>  	ksm_add_vma(vma);
>  expanded:
> @@ -1572,23 +1557,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> 
>  	vma_set_page_prot(vma);
> 
> -	validate_mm(mm);
>  	return addr;
> 
> -close_and_free_vma:
> -	vma_close(vma);
> -
> -	if (file || vma->vm_file) {
> -unmap_and_free_vma:
> -		fput(vma->vm_file);
> -		vma->vm_file = NULL;
> +unmap_and_free_file_vma:
> +	fput(vma->vm_file);
> +	vma->vm_file = NULL;
> 
> -		vma_iter_set(&vmi, vma->vm_end);
> -		/* Undo any partial mapping done by a device driver. */
> -		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> -	}
> -	if (writable_file_mapping)
> -		mapping_unmap_writable(file->f_mapping);
> +	vma_iter_set(&vmi, vma->vm_end);
> +	/* Undo any partial mapping done by a device driver. */
> +	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
> +free_iter_vma:
> +	vma_iter_free(&vmi);
>  free_vma:
>  	vm_area_free(vma);
>  unacct_error:
> @@ -1598,10 +1577,43 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  abort_munmap:
>  	vms_abort_munmap_vmas(&vms, &mas_detach);
>  gather_failed:
> -	validate_mm(mm);
>  	return error;
>  }
> 
> +unsigned long mmap_region(struct file *file, unsigned long addr,
> +			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> +			  struct list_head *uf)
> +{
> +	unsigned long ret;
> +	bool writable_file_mapping = false;
> +
> +	/* Allow architectures to sanity-check the vm_flags. */
> +	if (!arch_validate_flags(vm_flags))
> +		return -EINVAL;
> +
> +	/* Check to see if MDWE is applicable. */
> +	if (map_deny_write_exec(vm_flags, vm_flags))
> +		return -EACCES;
> +
> +	/* Map writable and ensure this isn't a sealed memfd. */
> +	if (file && is_shared_maywrite(vm_flags)) {
> +		int error = mapping_map_writable(file->f_mapping);
> +
> +		if (error)
> +			return error;
> +		writable_file_mapping = true;
> +	}
> +
> +	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
> +
> +	/* Clear our write mapping regardless of error. */
> +	if (writable_file_mapping)
> +		mapping_unmap_writable(file->f_mapping);
> +
> +	validate_mm(current->mm);
> +	return ret;
> +}
> +
>  static int __vm_munmap(unsigned long start, size_t len, bool unlock)
>  {
>  	int ret;
> --
> 2.47.0

