Return-Path: <linux-kernel+bounces-247962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90E92D6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5398E1C209BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957B3198843;
	Wed, 10 Jul 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mUDe6K57";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GDlsp3Nu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC24198837
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629376; cv=fail; b=Y4bVFpClfbJkhFw7QMDZ5GW/xGEDHTK2ESf9yAuYWCefbNS3YBXK3wB1o53RBqUD/HD/Zo+L1slUbvu91vk4l7uHOXraaPa3nMUYJS+fY7ocx1tJWkxFf2hOLXm04Fq9YxHcpVBj2xk3BFnEKAXTSHeInOvWrBE7PJSDeEHSC7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629376; c=relaxed/simple;
	bh=hUjwpG0mE4guMlWCifhDbRp6BHt19tnpTnLa/q4RScs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MmbUwawsQnQAKOuIW1tsg31EwmIlWqAAn2n8XAmSaffV0x4fMc26LrG4aOUBX3ae4v9yKOLvcNTogaiYfAXMvBpdCH5V44xzxOLnQIgMUTp3qegzIFnhNSvtk5mLI2Xw7jFxB8hP7TfPd7XJd48JPrl3XcHXMUW6eqj/UHM6IVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mUDe6K57; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GDlsp3Nu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AG73s0012119;
	Wed, 10 Jul 2024 16:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=A9Fmgv+NA1VlidAUhfn9O3ArHJqteQHwVC129FUBgSU=; b=
	mUDe6K575VedyjJhBU204xZwWLBVtZ9Tuvs/ynzL90BRRuToei8bg1EflU3qzxaP
	6FgGaqMcZY4s/O4mAOHngAKO5FalHYr4wt9OxkX3aY8UxeF7TgiPClCHC1KS25WZ
	bmVEdnxRCKfIkgeZl3kelF2LxcYlbmg0DMj1925uOB5tr8UwjXEbJNBQqZnqig4D
	hq+Oe2Zb2kAqlgyw9LAHetujOA1DCnVhnEYGiNumhE0tldjfkmwzcjBGTft3YAID
	4KkoPxiJEMty7baXA8T0G/ywaqbWal5n/w0iWCeCONvsLWJ8haOZzpsEvJdErIzK
	JSRLi9tByhLYX+VG0JnyiQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsy2vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 16:35:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AFKt0E010901;
	Wed, 10 Jul 2024 16:35:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv4k0vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 16:35:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edZdJgSrucP0Uu27bvNaKji0rc/YDBeDCZ2G3BQ21aGLSSlzjujK23oBR5xPQIrAqUlj07GTQJ01t7PoKTyr/HVg/6OlAdrjcedECAfn31fCB2YRfcl1vDAvz5HaVDordG7LRww/f9ewAqOay2wPfyPtIxKqpFz5oaZ8qvs40WTndpuEGcTvoH/uTjH1/ae/4pnxnBoullqwLilUNOOLM+ofOAVcEHes6+caTIyhBdjXYNudmxFyq4mztGynMMjIPRDFXvILg+idMq1CUITto3lYTLQuUUNftaKTo3t8Ni2yr3Zc4MB1TVG8vNkCtQITmSiAq3t8Vg8v+4xkDEYByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9Fmgv+NA1VlidAUhfn9O3ArHJqteQHwVC129FUBgSU=;
 b=EdzWyMG77kbMLZhvA+42ioJfDmcWvge8VsPI/W548EZnNNHP53goPKnr3S9vhxVbLkLsoECQ9EQwV37TETfhnfZ9vaGMIV+TPCFYRkcrEGpSjWHwf+K/SfdaQxGsLS5wH6T3Rp2KovAtxkW/j5+1A3ncNtXtZlRnS4T7Nr5LMf+pzvdT4q7JO3rGBMAP0U1cEtqFzlCygvpViDbi9m5ik7f/xFrp5rGavsntWTVRo/Fdc9BEeotR2kG7HQQzk8anCZw+OjSwRI9JOlrwNWUId4XR3r/TJPIA4j9z3nw4hKPjOqTQAshbXjAOetDuJLMv4QvooMWfRyPLn9CqWijozw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9Fmgv+NA1VlidAUhfn9O3ArHJqteQHwVC129FUBgSU=;
 b=GDlsp3NuNTR+SI7WnO7ROeuAy4+VDCFa3tEZg5AJSw7jSX/QPrjQTS2BU0omSjITC1Iy5gIobEGpZB1Lv45hO4f1lbVl6qSkrSsfQvsWZ0AvPx/XoJm8r2zQUAAayY8duEXLy3B7Pms1ONnlOufxFoggTx7K91EBH8Upt/AaqSU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH2PR10MB4184.namprd10.prod.outlook.com (2603:10b6:610:7f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 16:35:21 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 16:35:21 +0000
Date: Wed, 10 Jul 2024 12:35:18 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 08/16] mm/mmap: Inline munmap operation in
 mmap_region()
Message-ID: <6vwpreukkricmwcuefxrp3w6sl55pzpxiau2ejaua3wdqjrk62@4ryovwh6pr5y>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-9-Liam.Howlett@oracle.com>
 <CAJuCfpFNJ1j7Kcf3Z6efBB0xmvpRCWnfZhnNOuD_hBZmKc-bqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpFNJ1j7Kcf3Z6efBB0xmvpRCWnfZhnNOuD_hBZmKc-bqA@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH2PR10MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 3369c302-d3fd-412d-4d89-08dca0fe4a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UnkwMEIwQjNFSnc4eXVaTC9LaXVRaVFoWHF0QTdzcnh0ZDRrSmdXRHFYWGN3?=
 =?utf-8?B?SVFLQVRyU01ycm9wd21jK2dNcE9kbE01cFMrYllsbDFuQkVSZUlsd0xGUng3?=
 =?utf-8?B?MDVXaWp1WHBwL1BRSFQwN1AzUGlPUXQ5a0YzdGhneFdjLzY1WUVscEt2SU50?=
 =?utf-8?B?RldjU3hsZUhBdU44UUtzanJQVFMyMThIU0RUdSs2VDdrQlR4RUp0d2dGU3ZP?=
 =?utf-8?B?TFR6VXBWS29CZEc1N3dUMzNwUDJDbk1xTGczSmIzWDJqanIvTWJFMHYrMHB5?=
 =?utf-8?B?cHg3L0EyVS9hV3ExZ01nMmkzM1VidEc3a2lCRElDeGQ1amdadERiRUE2eTVj?=
 =?utf-8?B?NFQybHRBVUVjbUJvMGxNUkFZNzljYkZURjdwbWNFL3hVQ2pPMTlFOE9XamVR?=
 =?utf-8?B?bWZFNHVZMVVXRDEwb1RTL2MzVlRBMTVROXQ5ekJuTGJ4NG1xTzVrektZcS9j?=
 =?utf-8?B?NjNoUWFsbVNHalNpQlJwZ2M3MGd2Y0tHZllYRlBSTlI1MWtMSnU5SjRoWkFY?=
 =?utf-8?B?RGhBMlRzNEkvRVhHSDBFeTJCdWtoTUYxWWpES2RRNlFNS3dPV2pwc0VmMzRl?=
 =?utf-8?B?S1dhWlhtZm1ZMmVKMkoxbW5qekVwTUhwRURjbEJJSE03QzlNZFpmcFVvSlVF?=
 =?utf-8?B?M2pZZGRiNk5xYi9LQkZ6SUplaHFOMnNkbDh6NUdtMG05amVEVFRTNlV3OWVP?=
 =?utf-8?B?emNPSm81bjRQckFqeTc0elJLb1NHNU9KVHdzZmtnR21lYmszbnJsYlh4MWpC?=
 =?utf-8?B?RVdOQ1VlZmRQVmdzWlR4TFpSdnJYeFkvQkFyTW5nZGNyZGlEak54V3g0NW5J?=
 =?utf-8?B?TkNNLzViWm9oa2hsQzc1R1NFYkRnVTdCUlZFNjFXc1ZmVHBDQVVMQng0UStI?=
 =?utf-8?B?Qkg3TnJCZ1RLU3Zad0diTHVIcG51eEp3ZkpzZnFwcG1CM3ZWZDFuMHo3TUtR?=
 =?utf-8?B?aC9xRHhScU0rWXdBK0RjbnJKcVh1R2xyR1I0UG1EQkp3cmVRaWt5SjJ6eTJ0?=
 =?utf-8?B?d2hUTENqWGZOa3NoM3Z1TDRlTjc0WVpwT0lhSjRGQVdFNE1taW9ob2dHbFk1?=
 =?utf-8?B?OU95eUtQNGlLMnVPYi9zcnZuY3huMi92cEJaRmp4SjhSVHUxbVIvbjRUYTVT?=
 =?utf-8?B?YmRKcXAzQldySXJsdVRpV2w5QzRUbkZub1ZuR2RGem9vbE4yRHVqMkVhZFhq?=
 =?utf-8?B?QmhtK0ZEQjVNZHV4TThjQXQzYkFESk9zS2FPSWdvQklGZHlpWXFyNUJBdTc0?=
 =?utf-8?B?cmNUa1lBSWJxS2c0cHo3anloZkx1eW9RVDZROCthYThZd0ErQXo0QmxLUnpD?=
 =?utf-8?B?QkZLZUVScnpLVytYM3M3WU5ZRzhoWGNYU2YrWmF0L3FXdVBCSWh0UkhsdUtm?=
 =?utf-8?B?OUVHQXVvZW5lbmxVbGpNQThpYjhLNXF3VGVVbDhFQ2NwdGtEa0RWUjdhUVd2?=
 =?utf-8?B?ZS9ISm96NWlLampOdFcrY1ZRRFJvUFRnbmdDeE9lRkdCMFRwSzI2cUZkOXY3?=
 =?utf-8?B?bjI2Z05OWW84ZWdMdFUzQll6aDZRZmFaSVFnWnJ5UzRKR2FNVlRQUkMvMTR4?=
 =?utf-8?B?S2J1c1FaQXhPbzJXMnFldU9jZEFOa0MwY0tPZ0E0akdEOW04K0R1MTAxTDk4?=
 =?utf-8?B?K2tsdVFSV2M1RGhjRXBtMkZua2JIN3dxVjFKTm9EeVJ6eS9sWmJYL294RDVK?=
 =?utf-8?B?UmIxdDdLaDY0ejVnYVFHODRMeGo0TVFrMjd6eTczQVZaSnl3ekFDMWszTnFN?=
 =?utf-8?B?NHRBS3RjZ3BmM1QyS0hWejVEemIrSDF0bEIzRU1LNVdJS2lFdDZBZ0tMMTFq?=
 =?utf-8?B?cVRYREh3SFBUVXBWOGlyUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MW12OU1wWXc2UDBpNVJNK05BK2pxbUNlUmhYN0JYbjF2eFhHQWhkeENsUE1m?=
 =?utf-8?B?U3Z2OUlReVQrclphVkptcmNjdXdMR3l0all0M21NWTArV0FwZ3lveitVcHNJ?=
 =?utf-8?B?K1FFTGh6WGFiclBJRlRFUm1jT1JWbGR1R1VzZEpOajhDMlJJK1pWWFVoY1pM?=
 =?utf-8?B?RVQ4VGtGZUN2eGNpMENvZU50T3NkQ2w4VUd2c3FkQTU0Z1dvWE1RcndLWndV?=
 =?utf-8?B?SnVGMVY5MHJONUE4OFR0T1NoVVM3WE1OOTlyalB0NjRIWldXTXRhWE9wSHpB?=
 =?utf-8?B?YzNmc3Nyb2VMQkxBK1p2QUtZMnc2S09kQ1NxUGxuMi9oNFZwNTVzVzBFdWtW?=
 =?utf-8?B?RUg3Y0RxaFovVm96Q0cxa0c5VXBKSEZCTU1HU2R6RjRtQ05JcmowTTlkTWt3?=
 =?utf-8?B?VWZuTUptTi95ZE10WjBEOTdqVkxGNGdKWEMvdW9vVWUzUENyL3ljS20vNGRu?=
 =?utf-8?B?S3RWWXlEWFg5S1FJdndYaHpMVytpVHBhQzR5eU93eHBLeXBpa2ViY1gwcFg0?=
 =?utf-8?B?TWRQaTBqSWJFUlRVc2xxNUZtSjRnQkd2V2JZRk1sY05ZUjBsQVYrY2pyZmpS?=
 =?utf-8?B?UmdEajE1Nk5NTFNpRUVVR0U1NnlLWXRhczFhbm02R2lRSENrL0dpL1RLeS9X?=
 =?utf-8?B?a1pwUnB3cTlCNS92QXY3RWZNckp4WEdhOTlONTlNTU1FNWs0Vi9ZYnZmWGx6?=
 =?utf-8?B?MVozcEgrR3ZlQzdBbUlhV1hjdElCSDBNWjA1aWR0UCsySm9JNGIwK1Exc3h6?=
 =?utf-8?B?NnpkVGFXN3Jxb3NhUU5ZK1kzVEdwMnNEOWxjQ2dzeVlONW1HSENIT0w5UFRK?=
 =?utf-8?B?U3dYU0krZXJNRlZNeElEbG1aNkgrcmQxelEyb216MEZPbitjZ3o1aDlvUTVQ?=
 =?utf-8?B?UmZlVStGdXRLMm5teHRnRUxUZFFhKytnRnd4QVpONUlVV2lJK3ZhNVpWdVl6?=
 =?utf-8?B?dVhvSGF0SXhJTUhJS2lrbGN5OHduckRlRTBsejhiakRsMHlwSEVSZ0lqdGVh?=
 =?utf-8?B?VmJ0RnI0OGlyVFVaakFWR01sdEdnaVE3RUNOdUxlNHJ4Q3V2OWxaVjZjODd1?=
 =?utf-8?B?RDEvb1FpdHoxM3lRd21mQm5SbFlzTHpXZVRwRXM1TlFNMnVRS3htdGU2YVR5?=
 =?utf-8?B?eDJsVDI5MDNROUVWK1pZV1pZK2xqakJIVVlSM1d3TXBnYkV5bEltVjlLb0dt?=
 =?utf-8?B?NS8vUHRneENVYmFlckpacGVzRzh3cUVvNkEvRmRnSTdGTW0wVEVQMUQ4WkRL?=
 =?utf-8?B?UlRYYzR1YlNzVi81TjNmVUxCY3cwbksvRGZHRGJMNnVFZlE4RERDc3dvbHFs?=
 =?utf-8?B?TEE2Y25CaTZBOVNOYno2UjNnb2c3M2V4czdQUkVMRTZEc0NLNDJISXhLOFUr?=
 =?utf-8?B?RWh1b1Z6bTllRkRIYSt1VnMwL3U1citJbFpoaTdoZWZOdkhabTRkdTZGN251?=
 =?utf-8?B?QThvR2p4M2xLcGd3SlV6S2NtaElXMXd6dlYvQXZQNnU5MDZtMXNMYWx3cjhO?=
 =?utf-8?B?a1QzWElvdy96amZZUkJ3Q0dsR3ZtL2owaEZ3K3pLYkdzbVlIdFFiMlZJNzBj?=
 =?utf-8?B?WU5scE1pbHhoRHBuYmtROVo1TS85WnYxQ3pwUzY5Z3EwTHNuMVV6OTdzdnBE?=
 =?utf-8?B?NkdoTTVxY2NVNWxObFlPV01IbEpKRVJaaUFXMkpIOGRMLys3Q0dueWVYekVm?=
 =?utf-8?B?cFkrKzlsT29OQU41OEdGS0NsY2p3OFNLWUV5WDJLMUVCZUxNY1JQN0loK2dv?=
 =?utf-8?B?TkdkcXllYm93NXRXZFdDVG8xNVlRcXlxQXBPYkxmUXdYN21LbmNJUnpRRzFG?=
 =?utf-8?B?SmwxNExjSXhLMU9aOEVvQmJvTG0rRnlPUFo2UHNiQ01IZ1FlQmtxK1hmK1lk?=
 =?utf-8?B?N3lETEx1VDNQdWcrcnhzTzNyMU5PeVIrSW1URUFlYkJpaklXb2ljeWltV1RE?=
 =?utf-8?B?WUQ5d3BCUlloSWpxdERXajArN0d3UEtHbkNzVmcvTjhLZjVFa0VKWlhaS1JH?=
 =?utf-8?B?QmJ6Y2VEQ1cweE91ejlqTnRvUCtWbm00MCtnaDVCQ052T3JVZ3NpUzBHN3VR?=
 =?utf-8?B?SU91V0VCMFJRZUNvZXNjcDlVMnJkM1U5UzJ2ZERkZDZBNm5WbVRIQ3R3NFZ0?=
 =?utf-8?Q?UnLU8tI4YE9uUig0XwvEJR+WE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WT6mxgYT5R4b/RgOJT4a6E8KWJlXZiwSBEOPZNj7gOTqrgYoeN1j82CCnyoK3hPsu4xwptR+EFdeo/89t0cOqnt8ey0Mr7jKDe84opbih8MYJJ0/aFqbSTstAbdWFxvvNUA0oXyxEQApB/5o6+PWQNKks28JMRsRcyTf+LublRD4uGCPS8fWd4aMDdd4wO2/tfFI9qqOoZ0ILFgTwlgVmyThiv424VPoOr3GuQfK0Efb+KysFDjX3YF9FYsg/7iXucy/YU/pzt6W5HideVaRH+2QKhbDJf0qR+FC4/yk4yCAY+NDoAtHdgEpy5+HCn8eHk7j/XivBhUo2MXWpgDj7fEwfroXPOw9UAib91xnF+MsVU/MJtn+qg76nMCVMmC0PnChqg2VVv/wVtgklzm85i9ldLNCEs5mMH/Qg+cvcX11U/n6NcUIT+8PTOklrs8DJRES9doAvWZ/sVfllBwdK3Mu852E3gKqFmHFcHcoxPq9MRKXp+hKJ4SFitUkhTt+7cyhNJADYWh1Qe42zfEvClEr6yqk+qj81GcgiwiqxbcIkgSLtKZ6bsI4/DcDLOiKMkaa8IUf/Tcz0RqW7u/BwzSuEmkN7hG1+P9XdF+xw3U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3369c302-d3fd-412d-4d89-08dca0fe4a72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 16:35:21.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/5FHsRwGRg8n9t0jK8Fut/e1HVe8NUJogPTxOiR2y72SzQGQY4iLT70YRMsD93QI2mLfcKP2Kg0USLzXAcgpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_11,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100115
X-Proofpoint-GUID: SLTlghk8KVsic182rJstu860E0iw4vhE
X-Proofpoint-ORIG-GUID: SLTlghk8KVsic182rJstu860E0iw4vhE

* Suren Baghdasaryan <surenb@google.com> [240710 12:16]:
> On Thu, Jul 4, 2024 at 11:27=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > mmap_region is already passed sanitized addr and len, so change the
> > call to do_vmi_munmap() to do_vmi_align_munmap() and inline the other
> > checks.
>=20
> Hmm. I think such refactoring when you want to skip some checks would
> be done a bit differently... You would introduce a __do_vmi_munmap()
> function which is called at the end of do_vmi_munmap() after the
> checks and then call __do_vmi_munmap() directly wherever you want to
> skip the checks. That would avoid code duplication. Any reason that
> can't be done here?

Because I'm going to completely change and remove the checks in future
patches.  I should have added this to the log that this is an internal
step for reviewing.

>=20
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 8d9be791997a..e9858ca8bbd4 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2937,12 +2937,20 @@ unsigned long mmap_region(struct file *file, un=
signed long addr,
> >                         return -ENOMEM;
> >         }
> >
> > -       /* Unmap any existing mapping in the area */
> > -       error =3D do_vmi_munmap(&vmi, mm, addr, len, uf, false);
> > -       if (error =3D=3D -EPERM)
> > -               return error;
> > -       else if (error)
> > -               return -ENOMEM;
> > +
> > +       if (unlikely(!can_modify_mm(mm, addr, end)))
> > +               return -EPERM;
> > +
> > +        /* arch_unmap() might do unmaps itself.  */
> > +       arch_unmap(mm, addr, end);
> > +
> > +       /* Find the first overlapping VMA */
> > +       vma =3D vma_find(&vmi, end);
> > +       if (vma) {
> > +               if (do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, f=
alse))
> > +                       return -ENOMEM;
> > +               vma =3D NULL;
> > +       }
> >
> >         /*
> >          * Private writable mapping: check memory availability
> > --
> > 2.43.0
> >
>=20

